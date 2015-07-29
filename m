From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 6/9] iommu/io-pgtable-arm: Centralise sync points
Date: Wed, 29 Jul 2015 19:46:09 +0100
Message-ID: <37640b8b568a81f791e2d491cf70f80b1b0a6e2d.1438195011.git.robin.murphy@arm.com>
References: <6999933bfa9b3d50853fd023d455c837a0d7ff23.1438195011.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <6999933bfa9b3d50853fd023d455c837a0d7ff23.1438195011.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

With all current users now opted in to DMA API operations, make the
iommu_dev pointer mandatory, rendering the flush_pgtable callback
redundant for cache maintenance. However, since the DMA calls could be
nops in the case of a coherent IOMMU, we still need to ensure the page
table updates are fully synchronised against a subsequent page table
walk. In the unmap path, the TLB sync will usually need to do this
anyway, so just cement that requirement; in the map path which may
consist solely of cacheable memory writes (in the coherent case),
insert an appropriate barrier at the end of the operation, and obviate
the need to call flush_pgtable on every individual update for
synchronisation.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/io-pgtable-arm.c | 43 +++++++++++++++++++++++-------------------
 drivers/iommu/io-pgtable.h     |  3 ++-
 2 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 28cca8a..0617687 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -26,6 +26,8 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 
+#include <asm/barrier.h>
+
 #include "io-pgtable.h"
 
 #define ARM_LPAE_MAX_ADDR_BITS		48
@@ -215,7 +217,7 @@ static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
 	if (!pages)
 		return NULL;
 
-	if (dev) {
+	if (!selftest_running) {
 		dma = dma_map_single(dev, pages, size, DMA_TO_DEVICE);
 		if (dma_mapping_error(dev, dma))
 			goto out_free;
@@ -243,24 +245,22 @@ static void __arm_lpae_free_pages(void *pages, size_t size,
 {
 	struct device *dev = cfg->iommu_dev;
 
-	if (dev)
+	if (!selftest_running)
 		dma_unmap_single(dev, __arm_lpae_dma_addr(dev, pages),
 				 size, DMA_TO_DEVICE);
 	free_pages_exact(pages, size);
 }
 
 static void __arm_lpae_set_pte(arm_lpae_iopte *ptep, arm_lpae_iopte pte,
-			       struct io_pgtable_cfg *cfg, void *cookie)
+			       struct io_pgtable_cfg *cfg)
 {
 	struct device *dev = cfg->iommu_dev;
 
 	*ptep = pte;
 
-	if (dev)
+	if (!selftest_running)
 		dma_sync_single_for_device(dev, __arm_lpae_dma_addr(dev, ptep),
 					   sizeof(pte), DMA_TO_DEVICE);
-	else if (cfg->tlb->flush_pgtable)
-		cfg->tlb->flush_pgtable(ptep, sizeof(pte), cookie);
 }
 
 static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
@@ -288,7 +288,7 @@ static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 	pte |= ARM_LPAE_PTE_AF | ARM_LPAE_PTE_SH_IS;
 	pte |= pfn_to_iopte(paddr >> data->pg_shift, data);
 
-	__arm_lpae_set_pte(ptep, pte, cfg, data->iop.cookie);
+	__arm_lpae_set_pte(ptep, pte, cfg);
 	return 0;
 }
 
@@ -297,7 +297,6 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
 			  int lvl, arm_lpae_iopte *ptep)
 {
 	arm_lpae_iopte *cptep, pte;
-	void *cookie = data->iop.cookie;
 	size_t block_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
 	struct io_pgtable_cfg *cfg = &data->iop.cfg;
 
@@ -323,7 +322,7 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
 		pte = __pa(cptep) | ARM_LPAE_PTE_TYPE_TABLE;
 		if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS)
 			pte |= ARM_LPAE_PTE_NSTABLE;
-		__arm_lpae_set_pte(ptep, pte, cfg, cookie);
+		__arm_lpae_set_pte(ptep, pte, cfg);
 	} else {
 		cptep = iopte_deref(pte, data);
 	}
@@ -370,7 +369,7 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
 {
 	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
 	arm_lpae_iopte *ptep = data->pgd;
-	int lvl = ARM_LPAE_START_LVL(data);
+	int ret, lvl = ARM_LPAE_START_LVL(data);
 	arm_lpae_iopte prot;
 
 	/* If no access, then nothing to do */
@@ -378,7 +377,14 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
 		return 0;
 
 	prot = arm_lpae_prot_to_pte(data, iommu_prot);
-	return __arm_lpae_map(data, iova, paddr, size, prot, lvl, ptep);
+	ret = __arm_lpae_map(data, iova, paddr, size, prot, lvl, ptep);
+	/*
+	 * Synchronise all PTE updates for the new mapping before there's
+	 * a chance for anything to kick off a table walk for the new iova.
+	 */
+	wmb();
+
+	return ret;
 }
 
 static void __arm_lpae_free_pgtable(struct arm_lpae_io_pgtable *data, int lvl,
@@ -428,7 +434,6 @@ static int arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
 	phys_addr_t blk_paddr;
 	arm_lpae_iopte table = 0;
 	struct io_pgtable_cfg *cfg = &data->iop.cfg;
-	void *cookie = data->iop.cookie;
 
 	blk_start = iova & ~(blk_size - 1);
 	blk_end = blk_start + blk_size;
@@ -454,9 +459,9 @@ static int arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
 		}
 	}
 
-	__arm_lpae_set_pte(ptep, table, cfg, cookie);
+	__arm_lpae_set_pte(ptep, table, cfg);
 	iova &= ~(blk_size - 1);
-	cfg->tlb->tlb_add_flush(iova, blk_size, true, cookie);
+	cfg->tlb->tlb_add_flush(iova, blk_size, true, data->iop.cookie);
 	return size;
 }
 
@@ -478,7 +483,7 @@ static int __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 
 	/* If the size matches this level, we're in the right place */
 	if (size == blk_size) {
-		__arm_lpae_set_pte(ptep, 0, &data->iop.cfg, cookie);
+		__arm_lpae_set_pte(ptep, 0, &data->iop.cfg);
 
 		if (!iopte_leaf(pte, lvl)) {
 			/* Also flush any partial walks */
@@ -703,8 +708,8 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 	if (!data->pgd)
 		goto out_free_data;
 
-	if (cfg->tlb->flush_pgtable)
-		cfg->tlb->flush_pgtable(data->pgd, data->pgd_size, cookie);
+	/* Ensure the empty pgd is visible before any actual TTBR write */
+	wmb();
 
 	/* TTBRs */
 	cfg->arm_lpae_s1_cfg.ttbr[0] = virt_to_phys(data->pgd);
@@ -792,8 +797,8 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
 	if (!data->pgd)
 		goto out_free_data;
 
-	if (cfg->tlb->flush_pgtable)
-		cfg->tlb->flush_pgtable(data->pgd, data->pgd_size, cookie);
+	/* Ensure the empty pgd is visible before any actual TTBR write */
+	wmb();
 
 	/* VTTBR */
 	cfg->arm_lpae_s2_cfg.vttbr = virt_to_phys(data->pgd);
diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
index c69529c..8f61286 100644
--- a/drivers/iommu/io-pgtable.h
+++ b/drivers/iommu/io-pgtable.h
@@ -17,7 +17,8 @@ enum io_pgtable_fmt {
  *
  * @tlb_flush_all: Synchronously invalidate the entire TLB context.
  * @tlb_add_flush: Queue up a TLB invalidation for a virtual address range.
- * @tlb_sync:      Ensure any queue TLB invalidation has taken effect.
+ * @tlb_sync:      Ensure any queued TLB invalidation has taken effect, and
+ *                 any corresponding page table updates are visible.
  * @flush_pgtable: Ensure page table updates are visible to the IOMMU.
  *
  * Note that these can all be called in atomic context and must therefore
-- 
1.9.1
