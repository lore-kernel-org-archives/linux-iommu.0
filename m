From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 5/8] iommu/io-pgtable-arm: Support lockless operation
Date: Thu,  8 Jun 2017 12:52:04 +0100
Message-ID: <fbae45568d6210ad6d9ac25e73bde31d85b64b63.1496921366.git.robin.murphy@arm.com>
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

For parallel I/O with multiple concurrent threads servicing the same
device (or devices, if several share a domain), serialising page table
updates becomes a massive bottleneck. On reflection, though, we don't
strictly need to do that - for valid IOMMU API usage, there are in fact
only two races that we need to guard against: multiple map requests for
different blocks within the same region, when the intermediate-level
table for that region does not yet exist; and multiple unmaps of
different parts of the same block entry. Both of those are fairly easily
solved by using a cmpxchg to install the new table, such that if we then
find that someone else's table got there first, we can simply free ours
and continue.

Make the requisite changes such that we can withstand being called
without the caller maintaining a lock. In theory, this opens up a few
corners in which wildly misbehaving callers making nonsensical
overlapping requests might lead to crashes instead of just unpredictable
results, but correct code really does not deserve to pay a significant
performance cost for the sake of masking bugs in theoretical broken code.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/io-pgtable-arm.c | 75 ++++++++++++++++++++++++++++++++----------
 1 file changed, 58 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index bdc954cb98c1..d857961af1d3 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -20,6 +20,7 @@
 
 #define pr_fmt(fmt)	"arm-lpae io-pgtable: " fmt
 
+#include <linux/atomic.h>
 #include <linux/iommu.h>
 #include <linux/kernel.h>
 #include <linux/sizes.h>
@@ -99,6 +100,8 @@
 #define ARM_LPAE_PTE_ATTR_HI_MASK	(((arm_lpae_iopte)6) << 52)
 #define ARM_LPAE_PTE_ATTR_MASK		(ARM_LPAE_PTE_ATTR_LO_MASK |	\
 					 ARM_LPAE_PTE_ATTR_HI_MASK)
+/* Software bit for solving coherency races */
+#define ARM_LPAE_PTE_SW_SYNC		(((arm_lpae_iopte)1) << 55)
 
 /* Stage-1 PTE */
 #define ARM_LPAE_PTE_AP_UNPRIV		(((arm_lpae_iopte)1) << 6)
@@ -249,15 +252,20 @@ static void __arm_lpae_free_pages(void *pages, size_t size,
 	free_pages_exact(pages, size);
 }
 
+static void __arm_lpae_sync_pte(arm_lpae_iopte *ptep,
+				struct io_pgtable_cfg *cfg)
+{
+	dma_sync_single_for_device(cfg->iommu_dev, __arm_lpae_dma_addr(ptep),
+				   sizeof(*ptep), DMA_TO_DEVICE);
+}
+
 static void __arm_lpae_set_pte(arm_lpae_iopte *ptep, arm_lpae_iopte pte,
 			       struct io_pgtable_cfg *cfg)
 {
 	*ptep = pte;
 
 	if (!(cfg->quirks & IO_PGTABLE_QUIRK_NO_DMA))
-		dma_sync_single_for_device(cfg->iommu_dev,
-					   __arm_lpae_dma_addr(ptep),
-					   sizeof(pte), DMA_TO_DEVICE);
+		__arm_lpae_sync_pte(ptep, cfg);
 }
 
 static int __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
@@ -289,13 +297,13 @@ static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 			     arm_lpae_iopte prot, int lvl,
 			     arm_lpae_iopte *ptep)
 {
-	arm_lpae_iopte pte;
+	arm_lpae_iopte pte = *ptep;
 
-	if (iopte_leaf(*ptep, lvl)) {
+	if (iopte_leaf(pte, lvl)) {
 		/* We require an unmap first */
 		WARN_ON(!selftest_running);
 		return -EEXIST;
-	} else if (iopte_type(*ptep, lvl) == ARM_LPAE_PTE_TYPE_TABLE) {
+	} else if (iopte_type(pte, lvl) == ARM_LPAE_PTE_TYPE_TABLE) {
 		/*
 		 * We need to unmap and free the old table before
 		 * overwriting it with a block entry.
@@ -315,16 +323,30 @@ static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 
 static arm_lpae_iopte arm_lpae_install_table(arm_lpae_iopte *table,
 					     arm_lpae_iopte *ptep,
+					     arm_lpae_iopte curr,
 					     struct io_pgtable_cfg *cfg)
 {
-	arm_lpae_iopte new;
+	arm_lpae_iopte old, new;
 
 	new = __pa(table) | ARM_LPAE_PTE_TYPE_TABLE;
 	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS)
 		new |= ARM_LPAE_PTE_NSTABLE;
 
-	__arm_lpae_set_pte(ptep, new, cfg);
-	return new;
+	old = cmpxchg64_relaxed(ptep, curr, new);
+
+	if (cfg->quirks & IO_PGTABLE_QUIRK_NO_DMA)
+		return old;
+
+	/* Even if it's not ours, there's no point waiting; just kick it */
+	if (!(old & ARM_LPAE_PTE_SW_SYNC))
+		__arm_lpae_sync_pte(ptep, cfg);
+	if (old == curr) {
+		/* Ensure our sync is finished before we mark it as such */
+		wmb();
+		*ptep |= ARM_LPAE_PTE_SW_SYNC;
+	}
+
+	return old;
 }
 
 static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
@@ -333,6 +355,7 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
 {
 	arm_lpae_iopte *cptep, pte;
 	size_t block_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
+	size_t tblsz = ARM_LPAE_GRANULE(data);
 	struct io_pgtable_cfg *cfg = &data->iop.cfg;
 
 	/* Find our entry at the current level */
@@ -347,20 +370,26 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
 		return -EINVAL;
 
 	/* Grab a pointer to the next level */
-	pte = *ptep;
+	pte = READ_ONCE(*ptep);
 	if (!pte) {
-		cptep = __arm_lpae_alloc_pages(ARM_LPAE_GRANULE(data),
-					       GFP_ATOMIC, cfg);
+		cptep = __arm_lpae_alloc_pages(tblsz, GFP_ATOMIC, cfg);
 		if (!cptep)
 			return -ENOMEM;
 
-		arm_lpae_install_table(cptep, ptep, cfg);
-	} else if (!iopte_leaf(pte, lvl)) {
-		cptep = iopte_deref(pte, data);
-	} else {
+		pte = arm_lpae_install_table(cptep, ptep, 0, cfg);
+		if (pte)
+			__arm_lpae_free_pages(cptep, tblsz, cfg);
+	} else if (!(cfg->quirks & IO_PGTABLE_QUIRK_NO_DMA) &&
+		   !(pte & ARM_LPAE_PTE_SW_SYNC)) {
+		__arm_lpae_sync_pte(ptep, cfg);
+	}
+
+	if (iopte_leaf(pte, lvl)) {
 		/* We require an unmap first */
 		WARN_ON(!selftest_running);
 		return -EEXIST;
+	} else if (pte) {
+		cptep = iopte_deref(pte, data);
 	}
 
 	/* Rinse, repeat */
@@ -502,7 +531,19 @@ static int arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
 		__arm_lpae_set_pte(&tablep[i], pte, cfg);
 	}
 
-	arm_lpae_install_table(tablep, ptep, cfg);
+	pte = arm_lpae_install_table(tablep, ptep, blk_pte, cfg);
+	if (pte != blk_pte) {
+		__arm_lpae_free_pages(tablep, tablesz, cfg);
+		/*
+		 * We may race against someone unmapping another part of this
+		 * block, but anything else is invalid. We can't misinterpret
+		 * a page entry here since we're never at the last level.
+		 */
+		if (iopte_type(pte, lvl) != ARM_LPAE_PTE_TYPE_TABLE)
+			return 0;
+
+		tablep = iopte_deref(pte, data);
+	}
 
 	if (unmap_idx < 0)
 		return __arm_lpae_unmap(data, iova, size, lvl, tablep);
-- 
2.12.2.dirty
