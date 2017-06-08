From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 6/8] iommu/io-pgtable-arm-v7s: Support lockless operation
Date: Thu,  8 Jun 2017 12:52:05 +0100
Message-ID: <89faebabaaddb09d8c700bf62a52c42cc5007d58.1496921366.git.robin.murphy@arm.com>
References: <cover.1496921366.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1496921366.git.robin.murphy@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: will.deacon@arm.com, joro@8bytes.org
Cc: salil.mehta@huawei.com, sunil.goutham@cavium.com, iommu@lists.linux-foundation.org, ray.jui@broadcom.com, linux-arm-kernel@lists.infradead.org, linu.cherian@cavium.com, nwatters@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

Mirroring the LPAE implementation, rework the v7s code to be robust
against concurrent operations. The same two potential races exist, and
are solved in the same manner, with the fixed 2-level structure making
life ever so slightly simpler.

What complicates matters compared to LPAE, however, is large page
entries, since we can't update a block of 16 PTEs atomically, nor assume
available software bits to do clever things with. As most users are
never likely to do partial unmaps anyway (due to DMA API rules), it
doesn't seem unreasonable for this case to remain behind a serialising
lock; we just pull said lock down into the bowels of the implementation
so it's well out of the way of the normal call paths.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 78 ++++++++++++++++++++++++++++----------
 1 file changed, 58 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 2437f2899661..35d0f41af276 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -32,6 +32,7 @@
 
 #define pr_fmt(fmt)	"arm-v7s io-pgtable: " fmt
 
+#include <linux/atomic.h>
 #include <linux/dma-mapping.h>
 #include <linux/gfp.h>
 #include <linux/iommu.h>
@@ -39,6 +40,7 @@
 #include <linux/kmemleak.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/types.h>
 
 #include <asm/barrier.h>
@@ -168,6 +170,7 @@ struct arm_v7s_io_pgtable {
 
 	arm_v7s_iopte		*pgd;
 	struct kmem_cache	*l2_tables;
+	spinlock_t		split_lock;
 };
 
 static dma_addr_t __arm_v7s_dma_addr(void *pages)
@@ -396,16 +399,19 @@ static int arm_v7s_init_pte(struct arm_v7s_io_pgtable *data,
 
 static arm_v7s_iopte arm_v7s_install_table(arm_v7s_iopte *table,
 					   arm_v7s_iopte *ptep,
+					   arm_v7s_iopte curr,
 					   struct io_pgtable_cfg *cfg)
 {
-	arm_v7s_iopte new;
+	arm_v7s_iopte old, new;
 
 	new = virt_to_phys(table) | ARM_V7S_PTE_TYPE_TABLE;
 	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS)
 		new |= ARM_V7S_ATTR_NS_TABLE;
 
-	__arm_v7s_set_pte(ptep, new, 1, cfg);
-	return new;
+	old = cmpxchg_relaxed(ptep, curr, new);
+	__arm_v7s_pte_sync(ptep, 1, cfg);
+
+	return old;
 }
 
 static int __arm_v7s_map(struct arm_v7s_io_pgtable *data, unsigned long iova,
@@ -429,16 +435,23 @@ static int __arm_v7s_map(struct arm_v7s_io_pgtable *data, unsigned long iova,
 		return -EINVAL;
 
 	/* Grab a pointer to the next level */
-	pte = *ptep;
+	pte = READ_ONCE(*ptep);
 	if (!pte) {
 		cptep = __arm_v7s_alloc_table(lvl + 1, GFP_ATOMIC, data);
 		if (!cptep)
 			return -ENOMEM;
 
-		arm_v7s_install_table(cptep, ptep, cfg);
-	} else if (ARM_V7S_PTE_IS_TABLE(pte, lvl)) {
-		cptep = iopte_deref(pte, lvl);
+		pte = arm_v7s_install_table(cptep, ptep, 0, cfg);
+		if (pte)
+			__arm_v7s_free_table(cptep, lvl + 1, data);
 	} else {
+		/* We've no easy way of knowing if it's synced yet, so... */
+		__arm_v7s_pte_sync(ptep, 1, cfg);
+	}
+
+	if (ARM_V7S_PTE_IS_TABLE(pte, lvl)) {
+		cptep = iopte_deref(pte, lvl);
+	} else if (pte) {
 		/* We require an unmap first */
 		WARN_ON(!selftest_running);
 		return -EEXIST;
@@ -491,27 +504,31 @@ static void arm_v7s_free_pgtable(struct io_pgtable *iop)
 	kfree(data);
 }
 
-static void arm_v7s_split_cont(struct arm_v7s_io_pgtable *data,
-			       unsigned long iova, int idx, int lvl,
-			       arm_v7s_iopte *ptep)
+static arm_v7s_iopte arm_v7s_split_cont(struct arm_v7s_io_pgtable *data,
+					unsigned long iova, int idx, int lvl,
+					arm_v7s_iopte *ptep)
 {
 	struct io_pgtable *iop = &data->iop;
 	arm_v7s_iopte pte;
 	size_t size = ARM_V7S_BLOCK_SIZE(lvl);
 	int i;
 
+	/* Check that we didn't lose a race to get the lock */
+	pte = *ptep;
+	if (!arm_v7s_pte_is_cont(pte, lvl))
+		return pte;
+
 	ptep -= idx & (ARM_V7S_CONT_PAGES - 1);
-	pte = arm_v7s_cont_to_pte(*ptep, lvl);
-	for (i = 0; i < ARM_V7S_CONT_PAGES; i++) {
-		ptep[i] = pte;
-		pte += size;
-	}
+	pte = arm_v7s_cont_to_pte(pte, lvl);
+	for (i = 0; i < ARM_V7S_CONT_PAGES; i++)
+		ptep[i] = pte + i * size;
 
 	__arm_v7s_pte_sync(ptep, ARM_V7S_CONT_PAGES, &iop->cfg);
 
 	size *= ARM_V7S_CONT_PAGES;
 	io_pgtable_tlb_add_flush(iop, iova, size, size, true);
 	io_pgtable_tlb_sync(iop);
+	return pte;
 }
 
 static int arm_v7s_split_blk_unmap(struct arm_v7s_io_pgtable *data,
@@ -542,7 +559,16 @@ static int arm_v7s_split_blk_unmap(struct arm_v7s_io_pgtable *data,
 		__arm_v7s_set_pte(&tablep[i], pte, num_entries, cfg);
 	}
 
-	arm_v7s_install_table(tablep, ptep, cfg);
+	pte = arm_v7s_install_table(tablep, ptep, blk_pte, cfg);
+	if (pte != blk_pte) {
+		__arm_v7s_free_table(tablep, 2, data);
+
+		if (!ARM_V7S_PTE_IS_TABLE(pte, 1))
+			return 0;
+
+		tablep = iopte_deref(pte, 1);
+		return __arm_v7s_unmap(data, iova, size, 2, tablep);
+	}
 
 	io_pgtable_tlb_add_flush(&data->iop, iova, size, size, true);
 	return size;
@@ -563,17 +589,28 @@ static int __arm_v7s_unmap(struct arm_v7s_io_pgtable *data,
 	idx = ARM_V7S_LVL_IDX(iova, lvl);
 	ptep += idx;
 	do {
-		if (WARN_ON(!ARM_V7S_PTE_IS_VALID(ptep[i])))
+		pte[i] = READ_ONCE(ptep[i]);
+		if (WARN_ON(!ARM_V7S_PTE_IS_VALID(pte[i])))
 			return 0;
-		pte[i] = ptep[i];
 	} while (++i < num_entries);
 
 	/*
 	 * If we've hit a contiguous 'large page' entry at this level, it
 	 * needs splitting first, unless we're unmapping the whole lot.
+	 *
+	 * For splitting, we can't rewrite 16 PTEs atomically, and since we
+	 * can't necessarily assume TEX remap we don't have a software bit to
+	 * mark live entries being split. In practice (i.e. DMA API code), we
+	 * will never be splitting large pages anyway, so just wrap this edge
+	 * case in a lock for the sake of correctness and be done with it.
 	 */
-	if (num_entries <= 1 && arm_v7s_pte_is_cont(pte[0], lvl))
-		arm_v7s_split_cont(data, iova, idx, lvl, ptep);
+	if (num_entries <= 1 && arm_v7s_pte_is_cont(pte[0], lvl)) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&data->split_lock, flags);
+		pte[0] = arm_v7s_split_cont(data, iova, idx, lvl, ptep);
+		spin_unlock_irqrestore(&data->split_lock, flags);
+	}
 
 	/* If the size matches this level, we're in the right place */
 	if (num_entries) {
@@ -672,6 +709,7 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
 	if (!data)
 		return NULL;
 
+	spin_lock_init(&data->split_lock);
 	data->l2_tables = kmem_cache_create("io-pgtable_armv7s_l2",
 					    ARM_V7S_TABLE_SIZE(2),
 					    ARM_V7S_TABLE_SIZE(2),
-- 
2.12.2.dirty
