From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 06/09] iommu/ipmmu-vmsa: Write IMCTR twice
Date: Mon, 19 Jun 2017 18:14:48 +0900
Message-ID: <149786368825.14868.10471030796615221922.sendpatchset@little-apple>
References: <149786362527.14868.2143461703972595839.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <149786362527.14868.2143461703972595839.sendpatchset@little-apple>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>

Write IMCTR both in the root device and the leaf node.

To allow access of IMCTR introduce the following function:
 - ipmmu_ctx_write_all()

While at it also rename context functions:
 - ipmmu_ctx_read() -> ipmmu_ctx_read_root()
 - ipmmu_ctx_write() -> ipmmu_ctx_write_root()

Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
---

 Changes since V3:
 - Changed function names to improve code readability - Thanks Robin!

 Changes since V2:
 - None

 Changes since V1:
 - None

 drivers/iommu/ipmmu-vmsa.c |   55 +++++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 21 deletions(-)

--- 0023/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2017-06-19 14:06:16.770607110 +0900
@@ -261,17 +261,28 @@ static void ipmmu_write(struct ipmmu_vms
 	iowrite32(data, mmu->base + offset);
 }
 
-static u32 ipmmu_ctx_read(struct ipmmu_vmsa_domain *domain, unsigned int reg)
+static u32 ipmmu_ctx_read_root(struct ipmmu_vmsa_domain *domain,
+			       unsigned int reg)
 {
 	return ipmmu_read(domain->root, domain->context_id * IM_CTX_SIZE + reg);
 }
 
-static void ipmmu_ctx_write(struct ipmmu_vmsa_domain *domain, unsigned int reg,
-			    u32 data)
+static void ipmmu_ctx_write_root(struct ipmmu_vmsa_domain *domain,
+				 unsigned int reg, u32 data)
 {
 	ipmmu_write(domain->root, domain->context_id * IM_CTX_SIZE + reg, data);
 }
 
+static void ipmmu_ctx_write_all(struct ipmmu_vmsa_domain *domain,
+				unsigned int reg, u32 data)
+{
+	if (domain->mmu != domain->root)
+		ipmmu_write(domain->mmu,
+			    domain->context_id * IM_CTX_SIZE + reg, data);
+
+	ipmmu_write(domain->root, domain->context_id * IM_CTX_SIZE + reg, data);
+}
+
 /* -----------------------------------------------------------------------------
  * TLB and microTLB Management
  */
@@ -281,7 +292,7 @@ static void ipmmu_tlb_sync(struct ipmmu_
 {
 	unsigned int count = 0;
 
-	while (ipmmu_ctx_read(domain, IMCTR) & IMCTR_FLUSH) {
+	while (ipmmu_ctx_read_root(domain, IMCTR) & IMCTR_FLUSH) {
 		cpu_relax();
 		if (++count == TLB_LOOP_TIMEOUT) {
 			dev_err_ratelimited(domain->mmu->dev,
@@ -296,9 +307,9 @@ static void ipmmu_tlb_invalidate(struct
 {
 	u32 reg;
 
-	reg = ipmmu_ctx_read(domain, IMCTR);
+	reg = ipmmu_ctx_read_root(domain, IMCTR);
 	reg |= IMCTR_FLUSH;
-	ipmmu_ctx_write(domain, IMCTR, reg);
+	ipmmu_ctx_write_all(domain, IMCTR, reg);
 
 	ipmmu_tlb_sync(domain);
 }
@@ -425,31 +436,32 @@ static int ipmmu_domain_init_context(str
 
 	/* TTBR0 */
 	ttbr = domain->cfg.arm_lpae_s1_cfg.ttbr[0];
-	ipmmu_ctx_write(domain, IMTTLBR0, ttbr);
-	ipmmu_ctx_write(domain, IMTTUBR0, ttbr >> 32);
+	ipmmu_ctx_write_root(domain, IMTTLBR0, ttbr);
+	ipmmu_ctx_write_root(domain, IMTTUBR0, ttbr >> 32);
 
 	/*
 	 * TTBCR
 	 * We use long descriptors with inner-shareable WBWA tables and allocate
 	 * the whole 32-bit VA space to TTBR0.
 	 */
-	ipmmu_ctx_write(domain, IMTTBCR, IMTTBCR_EAE |
-			IMTTBCR_SH0_INNER_SHAREABLE | IMTTBCR_ORGN0_WB_WA |
-			IMTTBCR_IRGN0_WB_WA | IMTTBCR_SL0_LVL_1);
+	ipmmu_ctx_write_root(domain, IMTTBCR, IMTTBCR_EAE |
+			     IMTTBCR_SH0_INNER_SHAREABLE | IMTTBCR_ORGN0_WB_WA |
+			     IMTTBCR_IRGN0_WB_WA | IMTTBCR_SL0_LVL_1);
 
 	/* MAIR0 */
-	ipmmu_ctx_write(domain, IMMAIR0, domain->cfg.arm_lpae_s1_cfg.mair[0]);
+	ipmmu_ctx_write_root(domain, IMMAIR0,
+			     domain->cfg.arm_lpae_s1_cfg.mair[0]);
 
 	/* IMBUSCR */
-	ipmmu_ctx_write(domain, IMBUSCR,
-			ipmmu_ctx_read(domain, IMBUSCR) &
-			~(IMBUSCR_DVM | IMBUSCR_BUSSEL_MASK));
+	ipmmu_ctx_write_root(domain, IMBUSCR,
+			     ipmmu_ctx_read_root(domain, IMBUSCR) &
+			     ~(IMBUSCR_DVM | IMBUSCR_BUSSEL_MASK));
 
 	/*
 	 * IMSTR
 	 * Clear all interrupt flags.
 	 */
-	ipmmu_ctx_write(domain, IMSTR, ipmmu_ctx_read(domain, IMSTR));
+	ipmmu_ctx_write_root(domain, IMSTR, ipmmu_ctx_read_root(domain, IMSTR));
 
 	/*
 	 * IMCTR
@@ -458,7 +470,8 @@ static int ipmmu_domain_init_context(str
 	 * software management as we have no use for it. Flush the TLB as
 	 * required when modifying the context registers.
 	 */
-	ipmmu_ctx_write(domain, IMCTR, IMCTR_INTEN | IMCTR_FLUSH | IMCTR_MMUEN);
+	ipmmu_ctx_write_all(domain, IMCTR,
+			    IMCTR_INTEN | IMCTR_FLUSH | IMCTR_MMUEN);
 
 	return 0;
 }
@@ -484,7 +497,7 @@ static void ipmmu_domain_destroy_context
 	 *
 	 * TODO: Is TLB flush really needed ?
 	 */
-	ipmmu_ctx_write(domain, IMCTR, IMCTR_FLUSH);
+	ipmmu_ctx_write_all(domain, IMCTR, IMCTR_FLUSH);
 	ipmmu_tlb_sync(domain);
 	ipmmu_domain_free_context(domain->root, domain->context_id);
 }
@@ -500,11 +513,11 @@ static irqreturn_t ipmmu_domain_irq(stru
 	u32 status;
 	u32 iova;
 
-	status = ipmmu_ctx_read(domain, IMSTR);
+	status = ipmmu_ctx_read_root(domain, IMSTR);
 	if (!(status & err_mask))
 		return IRQ_NONE;
 
-	iova = ipmmu_ctx_read(domain, IMEAR);
+	iova = ipmmu_ctx_read_root(domain, IMEAR);
 
 	/*
 	 * Clear the error status flags. Unlike traditional interrupt flag
@@ -512,7 +525,7 @@ static irqreturn_t ipmmu_domain_irq(stru
 	 * seems to require 0. The error address register must be read before,
 	 * otherwise its value will be 0.
 	 */
-	ipmmu_ctx_write(domain, IMSTR, 0);
+	ipmmu_ctx_write_root(domain, IMSTR, 0);
 
 	/* Log fatal errors. */
 	if (status & IMSTR_MHIT)
