From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 5/8] iommu/io-pgtable-arm: Support lockless operation
Date: Thu, 22 Jun 2017 16:53:54 +0100
Message-ID: <af61929e3984a31588cab08ed84a237602b5263e.1498145008.git.robin.murphy@arm.com>
References: <cover.1498145008.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1498145008.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: sunil.goutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, wangzhou1-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, ray.jui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org
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

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

v2:
 - Fix barriers in install_table
 - Make a few more PTE accesses with {READ,WRITE}_ONCE() just in case
 - Minor cosmetics

 drivers/iommu/io-pgtable-arm.c | 72 +++++++++++++++++++++++++++++++++---------
 1 file changed, 57 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 6334f51912ea..52700fa958c2 100644
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
@@ -314,16 +322,30 @@ static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 
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
+	/* Ensure the table itself is visible before its PTE can be */
+	wmb();
+
+	old = cmpxchg64_relaxed(ptep, curr, new);
+
+	if ((cfg->quirks & IO_PGTABLE_QUIRK_NO_DMA) ||
+	    (old & ARM_LPAE_PTE_SW_SYNC))
+		return old;
+
+	/* Even if it's not ours, there's no point waiting; just kick it */
+	__arm_lpae_sync_pte(ptep, cfg);
+	if (old == curr)
+		WRITE_ONCE(*ptep, new | ARM_LPAE_PTE_SW_SYNC);
+
+	return old;
 }
 
 static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
@@ -332,6 +354,7 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
 {
 	arm_lpae_iopte *cptep, pte;
 	size_t block_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
+	size_t tblsz = ARM_LPAE_GRANULE(data);
 	struct io_pgtable_cfg *cfg = &data->iop.cfg;
 
 	/* Find our entry at the current level */
@@ -346,17 +369,23 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
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
+		pte = arm_lpae_install_table(cptep, ptep, 0, cfg);
+		if (pte)
+			__arm_lpae_free_pages(cptep, tblsz, cfg);
+	} else if (!(cfg->quirks & IO_PGTABLE_QUIRK_NO_DMA) &&
+		   !(pte & ARM_LPAE_PTE_SW_SYNC)) {
+		__arm_lpae_sync_pte(ptep, cfg);
+	}
+
+	if (pte && !iopte_leaf(pte, lvl)) {
 		cptep = iopte_deref(pte, data);
-	} else {
+	} else if (pte) {
 		/* We require an unmap first */
 		WARN_ON(!selftest_running);
 		return -EEXIST;
@@ -502,7 +531,19 @@ static int arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
 		__arm_lpae_init_pte(data, blk_paddr, pte, lvl, &tablep[i]);
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
+		if (iopte_type(pte, lvl - 1) != ARM_LPAE_PTE_TYPE_TABLE)
+			return 0;
+
+		tablep = iopte_deref(pte, data);
+	}
 
 	if (unmap_idx < 0)
 		return __arm_lpae_unmap(data, iova, size, lvl, tablep);
@@ -523,7 +564,7 @@ static int __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 		return 0;
 
 	ptep += ARM_LPAE_LVL_IDX(iova, lvl, data);
-	pte = *ptep;
+	pte = READ_ONCE(*ptep);
 	if (WARN_ON(!pte))
 		return 0;
 
@@ -585,7 +626,8 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
 			return 0;
 
 		/* Grab the IOPTE we're interested in */
-		pte = *(ptep + ARM_LPAE_LVL_IDX(iova, lvl, data));
+		ptep += ARM_LPAE_LVL_IDX(iova, lvl, data);
+		pte = READ_ONCE(*ptep);
 
 		/* Valid entry? */
 		if (!pte)
-- 
2.12.2.dirty
