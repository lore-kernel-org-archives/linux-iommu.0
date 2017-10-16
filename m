From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH v5 06/09] iommu/ipmmu-vmsa: Write IMCTR twice
Date: Mon, 16 Oct 2017 21:30:18 +0900
Message-ID: <150815701852.32763.14169011352697521964.sendpatchset@little-apple>
References: <150815695455.32763.1660214306749693609.sendpatchset@little-apple>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <150815695455.32763.1660214306749693609.sendpatchset@little-apple>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, robin.murphy@arm.com, m.szyprowski@samsung.com
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas@opensource.se>

Write IMCTR both in the root device and the leaf node.

To allow access of IMCTR introduce the following function:
 - ipmmu_ctx_write_all()

While at it also rename context functions:
 - ipmmu_ctx_read() -> ipmmu_ctx_read_root()
 - ipmmu_ctx_write() -> ipmmu_ctx_write_root()

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V4:
 - Updated to make use of new root pointer location

 Changes since V3:
 - Changed function names to improve code readability - Thanks Robin!

 Changes since V2:
 - None

 Changes since V1:
 - None

 drivers/iommu/ipmmu-vmsa.c |   56 +++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 21 deletions(-)

--- 0015/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2017-10-16 19:50:19.240607110 +0900
@@ -248,19 +248,31 @@ static void ipmmu_write(struct ipmmu_vms
 	iowrite32(data, mmu->base + offset);
 }
 
-static u32 ipmmu_ctx_read(struct ipmmu_vmsa_domain *domain, unsigned int reg)
+static u32 ipmmu_ctx_read_root(struct ipmmu_vmsa_domain *domain,
+			       unsigned int reg)
 {
 	return ipmmu_read(domain->mmu->root,
 			  domain->context_id * IM_CTX_SIZE + reg);
 }
 
-static void ipmmu_ctx_write(struct ipmmu_vmsa_domain *domain, unsigned int reg,
-			    u32 data)
+static void ipmmu_ctx_write_root(struct ipmmu_vmsa_domain *domain,
+				 unsigned int reg, u32 data)
 {
 	ipmmu_write(domain->mmu->root,
 		    domain->context_id * IM_CTX_SIZE + reg, data);
 }
 
+static void ipmmu_ctx_write_all(struct ipmmu_vmsa_domain *domain,
+				unsigned int reg, u32 data)
+{
+	if (domain->mmu != domain->mmu->root)
+		ipmmu_write(domain->mmu,
+			    domain->context_id * IM_CTX_SIZE + reg, data);
+
+	ipmmu_write(domain->mmu->root,
+		    domain->context_id * IM_CTX_SIZE + reg, data);
+}
+
 /* -----------------------------------------------------------------------------
  * TLB and microTLB Management
  */
@@ -270,7 +282,7 @@ static void ipmmu_tlb_sync(struct ipmmu_
 {
 	unsigned int count = 0;
 
-	while (ipmmu_ctx_read(domain, IMCTR) & IMCTR_FLUSH) {
+	while (ipmmu_ctx_read_root(domain, IMCTR) & IMCTR_FLUSH) {
 		cpu_relax();
 		if (++count == TLB_LOOP_TIMEOUT) {
 			dev_err_ratelimited(domain->mmu->dev,
@@ -285,9 +297,9 @@ static void ipmmu_tlb_invalidate(struct
 {
 	u32 reg;
 
-	reg = ipmmu_ctx_read(domain, IMCTR);
+	reg = ipmmu_ctx_read_root(domain, IMCTR);
 	reg |= IMCTR_FLUSH;
-	ipmmu_ctx_write(domain, IMCTR, reg);
+	ipmmu_ctx_write_all(domain, IMCTR, reg);
 
 	ipmmu_tlb_sync(domain);
 }
@@ -428,31 +440,32 @@ static int ipmmu_domain_init_context(str
 
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
@@ -461,7 +474,8 @@ static int ipmmu_domain_init_context(str
 	 * software management as we have no use for it. Flush the TLB as
 	 * required when modifying the context registers.
 	 */
-	ipmmu_ctx_write(domain, IMCTR, IMCTR_INTEN | IMCTR_FLUSH | IMCTR_MMUEN);
+	ipmmu_ctx_write_all(domain, IMCTR,
+			    IMCTR_INTEN | IMCTR_FLUSH | IMCTR_MMUEN);
 
 	return 0;
 }
@@ -474,7 +488,7 @@ static void ipmmu_domain_destroy_context
 	 *
 	 * TODO: Is TLB flush really needed ?
 	 */
-	ipmmu_ctx_write(domain, IMCTR, IMCTR_FLUSH);
+	ipmmu_ctx_write_all(domain, IMCTR, IMCTR_FLUSH);
 	ipmmu_tlb_sync(domain);
 	ipmmu_domain_free_context(domain->mmu->root, domain->context_id);
 }
@@ -490,11 +504,11 @@ static irqreturn_t ipmmu_domain_irq(stru
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
@@ -502,7 +516,7 @@ static irqreturn_t ipmmu_domain_irq(stru
 	 * seems to require 0. The error address register must be read before,
 	 * otherwise its value will be 0.
 	 */
-	ipmmu_ctx_write(domain, IMSTR, 0);
+	ipmmu_ctx_write_root(domain, IMSTR, 0);
 
 	/* Log fatal errors. */
 	if (status & IMSTR_MHIT)
