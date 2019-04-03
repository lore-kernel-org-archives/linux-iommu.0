From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v2 5/6] iommu/ipmmu-vmsa: Extract hardware context
	initialization
Date: Wed,  3 Apr 2019 20:21:47 +0200
Message-ID: <20190403182148.18058-6-geert+renesas@glider.be>
References: <20190403182148.18058-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190403182148.18058-1-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
Cc: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

ipmmu_domain_init_context() takes care of (1) initializing the software
domain, and (2) initializing the hardware context for the domain.

Extract the code to initialize the hardware context into a new subroutine
ipmmu_domain_setup_context(), to prepare for later reuse.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
v2:
  - s/ipmmu_context_init/ipmmu_domain_setup_context/.
---
 drivers/iommu/ipmmu-vmsa.c | 91 ++++++++++++++++++++------------------
 1 file changed, 48 insertions(+), 43 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 3fa57627b1e35562..56e84bcc9532e1ce 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -404,52 +404,10 @@ static void ipmmu_domain_free_context(struct ipmmu_vmsa_device *mmu,
 	spin_unlock_irqrestore(&mmu->lock, flags);
 }
 
-static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
+static void ipmmu_domain_setup_context(struct ipmmu_vmsa_domain *domain)
 {
 	u64 ttbr;
 	u32 tmp;
-	int ret;
-
-	/*
-	 * Allocate the page table operations.
-	 *
-	 * VMSA states in section B3.6.3 "Control of Secure or Non-secure memory
-	 * access, Long-descriptor format" that the NStable bit being set in a
-	 * table descriptor will result in the NStable and NS bits of all child
-	 * entries being ignored and considered as being set. The IPMMU seems
-	 * not to comply with this, as it generates a secure access page fault
-	 * if any of the NStable and NS bits isn't set when running in
-	 * non-secure mode.
-	 */
-	domain->cfg.quirks = IO_PGTABLE_QUIRK_ARM_NS;
-	domain->cfg.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K;
-	domain->cfg.ias = 32;
-	domain->cfg.oas = 40;
-	domain->cfg.tlb = &ipmmu_gather_ops;
-	domain->io_domain.geometry.aperture_end = DMA_BIT_MASK(32);
-	domain->io_domain.geometry.force_aperture = true;
-	/*
-	 * TODO: Add support for coherent walk through CCI with DVM and remove
-	 * cache handling. For now, delegate it to the io-pgtable code.
-	 */
-	domain->cfg.iommu_dev = domain->mmu->root->dev;
-
-	/*
-	 * Find an unused context.
-	 */
-	ret = ipmmu_domain_allocate_context(domain->mmu->root, domain);
-	if (ret < 0)
-		return ret;
-
-	domain->context_id = ret;
-
-	domain->iop = alloc_io_pgtable_ops(ARM_32_LPAE_S1, &domain->cfg,
-					   domain);
-	if (!domain->iop) {
-		ipmmu_domain_free_context(domain->mmu->root,
-					  domain->context_id);
-		return -EINVAL;
-	}
 
 	/* TTBR0 */
 	ttbr = domain->cfg.arm_lpae_s1_cfg.ttbr[0];
@@ -495,7 +453,54 @@ static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
 	 */
 	ipmmu_ctx_write_all(domain, IMCTR,
 			    IMCTR_INTEN | IMCTR_FLUSH | IMCTR_MMUEN);
+}
+
+static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
+{
+	int ret;
+
+	/*
+	 * Allocate the page table operations.
+	 *
+	 * VMSA states in section B3.6.3 "Control of Secure or Non-secure memory
+	 * access, Long-descriptor format" that the NStable bit being set in a
+	 * table descriptor will result in the NStable and NS bits of all child
+	 * entries being ignored and considered as being set. The IPMMU seems
+	 * not to comply with this, as it generates a secure access page fault
+	 * if any of the NStable and NS bits isn't set when running in
+	 * non-secure mode.
+	 */
+	domain->cfg.quirks = IO_PGTABLE_QUIRK_ARM_NS;
+	domain->cfg.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K;
+	domain->cfg.ias = 32;
+	domain->cfg.oas = 40;
+	domain->cfg.tlb = &ipmmu_gather_ops;
+	domain->io_domain.geometry.aperture_end = DMA_BIT_MASK(32);
+	domain->io_domain.geometry.force_aperture = true;
+	/*
+	 * TODO: Add support for coherent walk through CCI with DVM and remove
+	 * cache handling. For now, delegate it to the io-pgtable code.
+	 */
+	domain->cfg.iommu_dev = domain->mmu->root->dev;
+
+	/*
+	 * Find an unused context.
+	 */
+	ret = ipmmu_domain_allocate_context(domain->mmu->root, domain);
+	if (ret < 0)
+		return ret;
+
+	domain->context_id = ret;
+
+	domain->iop = alloc_io_pgtable_ops(ARM_32_LPAE_S1, &domain->cfg,
+					   domain);
+	if (!domain->iop) {
+		ipmmu_domain_free_context(domain->mmu->root,
+					  domain->context_id);
+		return -EINVAL;
+	}
 
+	ipmmu_domain_setup_context(domain);
 	return 0;
 }
 
-- 
2.17.1
