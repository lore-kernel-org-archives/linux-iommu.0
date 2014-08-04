From: Sachin Kamat <sachin.kamat-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2] iommu: exynos: Fix trivial typos
Date: Mon,  4 Aug 2014 10:06:28 +0530
Message-ID: <1407126988-15806-1-git-send-email-sachin.kamat@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: spk.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Fixed trivial typos and grammar to improve readability.
Changed w/a to workaround.

Signed-off-by: Sachin Kamat <sachin.kamat-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c | 51 ++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index d037e87..7423318 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -32,7 +32,7 @@
 typedef u32 sysmmu_iova_t;
 typedef u32 sysmmu_pte_t;
 
-/* We does not consider super section mapping (16MB) */
+/* We do not consider super section mapping (16MB) */
 #define SECT_ORDER 20
 #define LPAGE_ORDER 16
 #define SPAGE_ORDER 12
@@ -307,7 +307,7 @@ static void show_fault_information(const char *name,
 
 static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 {
-	/* SYSMMU is in blocked when interrupt occurred. */
+	/* SYSMMU is in blocked state when interrupt occurred. */
 	struct sysmmu_drvdata *data = dev_id;
 	enum exynos_sysmmu_inttype itype;
 	sysmmu_iova_t addr = -1;
@@ -567,8 +567,8 @@ static void sysmmu_tlb_invalidate_entry(struct device *dev, sysmmu_iova_t iova,
 		/*
 		 * L2TLB invalidation required
 		 * 4KB page: 1 invalidation
-		 * 64KB page: 16 invalidation
-		 * 1MB page: 64 invalidation
+		 * 64KB page: 16 invalidations
+		 * 1MB page: 64 invalidations
 		 * because it is set-associative TLB
 		 * with 8-way and 64 sets.
 		 * 1MB page can be cached in one of all sets.
@@ -714,7 +714,7 @@ static int exynos_iommu_domain_init(struct iommu_domain *domain)
 	if (!priv->lv2entcnt)
 		goto err_counter;
 
-	/* w/a of System MMU v3.3 to prevent caching 1MiB mapping */
+	/* Workaround for System MMU v3.3 to prevent caching 1MiB mapping */
 	for (i = 0; i < NUM_LV1ENTRIES; i += 8) {
 		priv->pgtable[i + 0] = ZERO_LV2LINK;
 		priv->pgtable[i + 1] = ZERO_LV2LINK;
@@ -861,14 +861,14 @@ static sysmmu_pte_t *alloc_lv2entry(struct exynos_iommu_domain *priv,
 		pgtable_flush(sent, sent + 1);
 
 		/*
-		 * If pretched SLPD is a fault SLPD in zero_l2_table, FLPD cache
-		 * may caches the address of zero_l2_table. This function
-		 * replaces the zero_l2_table with new L2 page table to write
-		 * valid mappings.
+		 * If pre-fetched SLPD is a faulty SLPD in zero_l2_table,
+		 * FLPD cache may cache the address of zero_l2_table. This
+		 * function replaces the zero_l2_table with new L2 page table
+		 * to write valid mappings.
 		 * Accessing the valid area may cause page fault since FLPD
-		 * cache may still caches zero_l2_table for the valid area
-		 * instead of new L2 page table that have the mapping
-		 * information of the valid area
+		 * cache may still cache zero_l2_table for the valid area
+		 * instead of new L2 page table that has the mapping
+		 * information of the valid area.
 		 * Thus any replacement of zero_l2_table with other valid L2
 		 * page table must involve FLPD cache invalidation for System
 		 * MMU v3.3.
@@ -963,27 +963,27 @@ static int lv2set_page(sysmmu_pte_t *pent, phys_addr_t paddr, size_t size,
 /*
  * *CAUTION* to the I/O virtual memory managers that support exynos-iommu:
  *
- * System MMU v3.x have an advanced logic to improve address translation
+ * System MMU v3.x has advanced logic to improve address translation
  * performance with caching more page table entries by a page table walk.
- * However, the logic has a bug that caching fault page table entries and System
- * MMU reports page fault if the cached fault entry is hit even though the fault
- * entry is updated to a valid entry after the entry is cached.
- * To prevent caching fault page table entries which may be updated to valid
- * entries later, the virtual memory manager should care about the w/a about the
- * problem. The followings describe w/a.
+ * However, the logic has a bug that while caching faulty page table entries,
+ * System MMU reports page fault if the cached fault entry is hit even though
+ * the fault entry is updated to a valid entry after the entry is cached.
+ * To prevent caching faulty page table entries which may be updated to valid
+ * entries later, the virtual memory manager should care about the workaround
+ * for the problem. The following describes the workaround.
  *
  * Any two consecutive I/O virtual address regions must have a hole of 128KiB
- * in maximum to prevent misbehavior of System MMU 3.x. (w/a of h/w bug)
+ * at maximum to prevent misbehavior of System MMU 3.x (workaround for h/w bug).
  *
- * Precisely, any start address of I/O virtual region must be aligned by
+ * Precisely, any start address of I/O virtual region must be aligned with
  * the following sizes for System MMU v3.1 and v3.2.
  * System MMU v3.1: 128KiB
  * System MMU v3.2: 256KiB
  *
  * Because System MMU v3.3 caches page table entries more aggressively, it needs
- * more w/a.
- * - Any two consecutive I/O virtual regions must be have a hole of larger size
- *   than or equal size to 128KiB.
+ * more workarounds.
+ * - Any two consecutive I/O virtual regions must have a hole of size larger
+ *   than or equal to 128KiB.
  * - Start address of an I/O virtual region must be aligned by 128KiB.
  */
 static int exynos_iommu_map(struct iommu_domain *domain, unsigned long l_iova,
@@ -1061,7 +1061,8 @@ static size_t exynos_iommu_unmap(struct iommu_domain *domain,
 			goto err;
 		}
 
-		*ent = ZERO_LV2LINK; /* w/a for h/w bug in Sysmem MMU v3.3 */
+		/* workaround for h/w bug in System MMU v3.3 */
+		*ent = ZERO_LV2LINK;
 		pgtable_flush(ent, ent + 1);
 		size = SECT_SIZE;
 		goto done;
-- 
1.8.1.2
