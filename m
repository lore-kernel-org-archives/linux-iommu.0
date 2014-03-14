From: Cho KyongHo <pullip.cho@samsung.com>
Subject: [PATCH v11 26/27] iommu/exynos: apply workaround of caching fault page
 table entries
Date: Fri, 14 Mar 2014 14:14:04 +0900
Message-ID: <20140314141404.dfe7026b207c491c6445f691@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>, Linux DeviceTree <devicetree@vger.kernel.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
Cc: Antonios Motakis <a.motakis@virtualopensystems.com>, Grant Grundler <grundler@chromium.org>, Joerg Roedel <joro@8bytes.org>, Kukjin Kim <kgene.kim@samsung.com>, Prathyush <prathyush.k@samsung.com>, Rahul Sharma <rahul.sharma@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Varun Sethi <Varun.Sethi@freescale.com>
List-Id: iommu@lists.linux-foundation.org

This patch contains 2 workaround for the System MMU v3.x.

System MMU v3.2 and v3.3 has FLPD cache that caches first level page
table entries to reduce page table walking latency. However, the
FLPD cache is filled with a first level page table entry even though
it is not accessed by a master H/W because System MMU v3.3
speculatively prefetches page table entries that may be accessed
in the near future by the master H/W.
The prefetched FLPD cache entries are not invalidated by iommu_unmap()
because iommu_unmap() only unmaps and invalidates the page table
entries that is mapped.

Because exynos-iommu driver discards a second level page table when
it needs to be replaced with another second level page table or
a first level page table entry with 1MB mapping, It is required to
invalidate FLPD cache that may contain the first level page table
entry that points to the second level page table.

Another workaround of System MMU v3.3 is initializing the first level
page table entries with the second level page table which is filled
with all zeros. This prevents System MMU prefetches 'fault' first
level page table entry which may lead page fault on access to 16MiB
wide.

System MMU 3.x fetches consecutive page table entries by a page
table walking to maximize bus utilization and to minimize TLB miss
panelty.
Unfortunately, functional problem is raised with the fetching behavior
because it fetches 'fault' page table entries that specifies no
translation information and that a valid translation information will
be written to in the near future. The logic in the System MMU generates
page fault with the cached fault entries that is no longer coherent
with the page table which is updated.

There is another workaround that must be implemented by I/O virtual
memory manager: any two consecutive I/O virtual memory area must have
a hole between the two that is larger than or equal to 128KiB.
Also, next I/O virtual memory area must be started from the next
128KiB boundary.

0            128K           256K               384K             512K
|-------------|---------------|-----------------|----------------|
|area1---------------->|.........hole...........|<--- area2 -----

The constraint is depicted above.
The size is selected by the calculation followed:
 - System MMU can fetch consecutive 64 page table entries at once
   64 * 4KiB = 256KiB. This is the size between 128K ~ 384K of the
   above picture. This style of fetching is 'block fetch'. It fetches
   the page table entries predefined consecutive page table entries
   including the entry that is the reason of the page table walking.
 - System MMU can prefetch upto consecutive 32 page table entries.
   This is the size between 256K ~ 384K.

Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
---
 drivers/iommu/exynos-iommu.c |  164 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 147 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 3d4dabb..4888383 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -47,8 +47,12 @@
 #define LPAGE_MASK (~(LPAGE_SIZE - 1))
 #define SPAGE_MASK (~(SPAGE_SIZE - 1))
 
-#define lv1ent_fault(sent) (((*(sent) & 3) == 0) || ((*(sent) & 3) == 3))
-#define lv1ent_page(sent) ((*(sent) & 3) == 1)
+#define lv1ent_fault(sent) ((*(sent) == ZERO_LV2LINK) || \
+			   ((*(sent) & 3) == 0) || ((*(sent) & 3) == 3))
+#define lv1ent_zero(sent) (*(sent) == ZERO_LV2LINK)
+#define lv1ent_page_zero(sent) ((*(sent) & 3) == 1)
+#define lv1ent_page(sent) ((*(sent) != ZERO_LV2LINK) && \
+			  ((*(sent) & 3) == 1))
 #define lv1ent_section(sent) ((*(sent) & 3) == 2)
 
 #define lv2ent_fault(pent) ((*(pent) & 3) == 0)
@@ -137,6 +141,8 @@ typedef u32 sysmmu_iova_t;
 typedef u32 sysmmu_pte_t;
 
 static struct kmem_cache *lv2table_kmem_cache;
+static sysmmu_pte_t *zero_lv2_table;
+#define ZERO_LV2LINK mk_lv1ent_page(virt_to_phys(zero_lv2_table))
 
 static sysmmu_pte_t *section_entry(sysmmu_pte_t *pgtable, sysmmu_iova_t iova)
 {
@@ -538,6 +544,33 @@ static bool exynos_sysmmu_disable(struct device *dev)
 	return disabled;
 }
 
+static void __sysmmu_tlb_invalidate_flpdcache(struct sysmmu_drvdata *data,
+					      sysmmu_iova_t iova)
+{
+	if (__raw_sysmmu_version(data) == MAKE_MMU_VER(3, 3))
+		__raw_writel(iova | 0x1, data->sfrbase + REG_MMU_FLUSH_ENTRY);
+}
+
+static void sysmmu_tlb_invalidate_flpdcache(struct device *dev,
+					    sysmmu_iova_t iova)
+{
+	struct sysmmu_list_data *list;
+
+	for_each_sysmmu_list(dev, list) {
+		unsigned long flags;
+		struct sysmmu_drvdata *data = dev_get_drvdata(list->sysmmu);
+
+		__master_clk_enable(data);
+
+		spin_lock_irqsave(&data->lock, flags);
+		if (is_sysmmu_active(data) && data->runtime_active)
+			__sysmmu_tlb_invalidate_flpdcache(data, iova);
+		spin_unlock_irqrestore(&data->lock, flags);
+
+		__master_clk_disable(data);
+	}
+}
+
 static void sysmmu_tlb_invalidate_entry(struct device *dev, sysmmu_iova_t iova,
 					size_t size)
 {
@@ -844,21 +877,32 @@ static inline void pgtable_flush(void *vastart, void *vaend)
 static int exynos_iommu_domain_init(struct iommu_domain *domain)
 {
 	struct exynos_iommu_domain *priv;
+	int i;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	priv->pgtable = (sysmmu_pte_t *)__get_free_pages(
-						GFP_KERNEL | __GFP_ZERO, 2);
+	priv->pgtable = (sysmmu_pte_t *)__get_free_pages(GFP_KERNEL, 2);
 	if (!priv->pgtable)
 		goto err_pgtable;
 
-	priv->lv2entcnt = (short *)__get_free_pages(
-						GFP_KERNEL | __GFP_ZERO, 1);
+	priv->lv2entcnt = (short *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, 1);
 	if (!priv->lv2entcnt)
 		goto err_counter;
 
+	/* w/a of System MMU v3.3 to prevent caching 1MiB mapping */
+	for (i = 0; i < NUM_LV1ENTRIES; i += 8) {
+		priv->pgtable[i + 0] = ZERO_LV2LINK;
+		priv->pgtable[i + 1] = ZERO_LV2LINK;
+		priv->pgtable[i + 2] = ZERO_LV2LINK;
+		priv->pgtable[i + 3] = ZERO_LV2LINK;
+		priv->pgtable[i + 4] = ZERO_LV2LINK;
+		priv->pgtable[i + 5] = ZERO_LV2LINK;
+		priv->pgtable[i + 6] = ZERO_LV2LINK;
+		priv->pgtable[i + 7] = ZERO_LV2LINK;
+	}
+
 	pgtable_flush(priv->pgtable, priv->pgtable + NUM_LV1ENTRIES);
 
 	spin_lock_init(&priv->lock);
@@ -972,8 +1016,8 @@ static void exynos_iommu_detach_device(struct iommu_domain *domain,
 	}
 }
 
-static sysmmu_pte_t *alloc_lv2entry(sysmmu_pte_t *sent, sysmmu_iova_t iova,
-					short *pgcounter)
+static sysmmu_pte_t *alloc_lv2entry(struct exynos_iommu_domain *priv,
+		sysmmu_pte_t *sent, sysmmu_iova_t iova, short *pgcounter)
 {
 	if (lv1ent_section(sent)) {
 		WARN(1, "Trying mapping on %#08x mapped with 1MiB page", iova);
@@ -982,6 +1026,7 @@ static sysmmu_pte_t *alloc_lv2entry(sysmmu_pte_t *sent, sysmmu_iova_t iova,
 
 	if (lv1ent_fault(sent)) {
 		sysmmu_pte_t *pent;
+		bool need_flush_flpd_cache = lv1ent_zero(sent);
 
 		pent = kmem_cache_zalloc(lv2table_kmem_cache, GFP_ATOMIC);
 		BUG_ON((unsigned int)pent & (LV2TABLE_SIZE - 1));
@@ -992,12 +1037,39 @@ static sysmmu_pte_t *alloc_lv2entry(sysmmu_pte_t *sent, sysmmu_iova_t iova,
 		*pgcounter = NUM_LV2ENTRIES;
 		pgtable_flush(pent, pent + NUM_LV2ENTRIES);
 		pgtable_flush(sent, sent + 1);
+
+		/*
+		 * If pretched SLPD is a fault SLPD in zero_l2_table, FLPD cache
+		 * may caches the address of zero_l2_table. This function
+		 * replaces the zero_l2_table with new L2 page table to write
+		 * valid mappings.
+		 * Accessing the valid area may cause page fault since FLPD
+		 * cache may still caches zero_l2_table for the valid area
+		 * instead of new L2 page table that have the mapping
+		 * information of the valid area
+		 * Thus any replacement of zero_l2_table with other valid L2
+		 * page table must involve FLPD cache invalidation for System
+		 * MMU v3.3.
+		 * FLPD cache invalidation is performed with TLB invalidation
+		 * by VPN without blocking. It is safe to invalidate TLB without
+		 * blocking because the target address of TLB invalidation is
+		 * not currently mapped.
+		 */
+		if (need_flush_flpd_cache) {
+			struct exynos_iommu_owner *owner;
+			spin_lock(&priv->lock);
+			list_for_each_entry(owner, &priv->clients, client)
+				sysmmu_tlb_invalidate_flpdcache(
+							owner->dev, iova);
+			spin_unlock(&priv->lock);
+		}
 	}
 
 	return page_entry(sent, iova);
 }
 
-static int lv1set_section(sysmmu_pte_t *sent, sysmmu_iova_t iova,
+static int lv1set_section(struct exynos_iommu_domain *priv,
+			  sysmmu_pte_t *sent, sysmmu_iova_t iova,
 			  phys_addr_t paddr, short *pgcnt)
 {
 	if (lv1ent_section(sent)) {
@@ -1017,6 +1089,18 @@ static int lv1set_section(sysmmu_pte_t *sent, sysmmu_iova_t iova,
 		*pgcnt = 0;
 	}
 
+	spin_lock(&priv->lock);
+	if (lv1ent_page_zero(sent)) {
+		struct exynos_iommu_owner *owner;
+		/*
+		 * Flushing FLPD cache in System MMU v3.3 that may cache a FLPD
+		 * entry by speculative prefetch of SLPD which has no mapping.
+		 */
+		list_for_each_entry(owner, &priv->clients, client)
+			sysmmu_tlb_invalidate_flpdcache(owner->dev, iova);
+	}
+	spin_unlock(&priv->lock);
+
 	*sent = mk_lv1ent_sect(paddr);
 
 	pgtable_flush(sent, sent + 1);
@@ -1056,6 +1140,32 @@ static int lv2set_page(sysmmu_pte_t *pent, phys_addr_t paddr, size_t size,
 	return 0;
 }
 
+/*
+ * *CAUTION* to the I/O virtual memory managers that support exynos-iommu:
+ *
+ * System MMU v3.x have an advanced logic to improve address translation
+ * performance with caching more page table entries by a page table walk.
+ * However, the logic has a bug that caching fault page table entries and System
+ * MMU reports page fault if the cached fault entry is hit even though the fault
+ * entry is updated to a valid entry after the entry is cached.
+ * To prevent caching fault page table entries which may be updated to valid
+ * entries later, the virtual memory manager should care about the w/a about the
+ * problem. The followings describe w/a.
+ *
+ * Any two consecutive I/O virtual address regions must have a hole of 128KiB
+ * in maximum to prevent misbehavior of System MMU 3.x. (w/a of h/w bug)
+ *
+ * Precisely, any start address of I/O virtual region must be aligned by
+ * the following sizes for System MMU v3.1 and v3.2.
+ * System MMU v3.1: 128KiB
+ * System MMU v3.2: 256KiB
+ *
+ * Because System MMU v3.3 caches page table entries more aggressively, it needs
+ * more w/a.
+ * - Any two consecutive I/O virtual regions must be have a hole of larger size
+ *   than or equal size to 128KiB.
+ * - Start address of an I/O virtual region must be aligned by 128KiB.
+ */
 static int exynos_iommu_map(struct iommu_domain *domain, unsigned long l_iova,
 			 phys_addr_t paddr, size_t size, int prot)
 {
@@ -1072,12 +1182,12 @@ static int exynos_iommu_map(struct iommu_domain *domain, unsigned long l_iova,
 	entry = section_entry(priv->pgtable, iova);
 
 	if (size == SECT_SIZE) {
-		ret = lv1set_section(entry, iova, paddr,
+		ret = lv1set_section(priv, entry, iova, paddr,
 					&priv->lv2entcnt[lv1ent_offset(iova)]);
 	} else {
 		sysmmu_pte_t *pent;
 
-		pent = alloc_lv2entry(entry, iova,
+		pent = alloc_lv2entry(priv, entry, iova,
 					&priv->lv2entcnt[lv1ent_offset(iova)]);
 
 		if (IS_ERR(pent))
@@ -1096,11 +1206,24 @@ static int exynos_iommu_map(struct iommu_domain *domain, unsigned long l_iova,
 	return ret;
 }
 
+static void exynos_iommu_tlb_invalidate_entry(struct exynos_iommu_domain *priv,
+						sysmmu_iova_t iova, size_t size)
+{
+	struct exynos_iommu_owner *owner;
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	list_for_each_entry(owner, &priv->clients, client)
+		sysmmu_tlb_invalidate_entry(owner->dev, iova, size);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+}
+
 static size_t exynos_iommu_unmap(struct iommu_domain *domain,
 				       unsigned long l_iova, size_t size)
 {
 	struct exynos_iommu_domain *priv = domain->priv;
-	struct exynos_iommu_owner *owner;
 	sysmmu_iova_t iova = (sysmmu_iova_t)l_iova;
 	sysmmu_pte_t *ent;
 	size_t err_pgsize;
@@ -1118,7 +1241,7 @@ static size_t exynos_iommu_unmap(struct iommu_domain *domain,
 			goto err;
 		}
 
-		*ent = 0;
+		*ent = ZERO_LV2LINK; /* w/a for h/w bug in Sysmem MMU v3.3 */
 		pgtable_flush(ent, ent + 1);
 		size = SECT_SIZE;
 		goto done;
@@ -1161,10 +1284,7 @@ static size_t exynos_iommu_unmap(struct iommu_domain *domain,
 done:
 	spin_unlock_irqrestore(&priv->pgtablelock, flags);
 
-	spin_lock_irqsave(&priv->lock, flags);
-	list_for_each_entry(owner, &priv->clients, client)
-		sysmmu_tlb_invalidate_entry(owner->dev, iova, size);
-	spin_unlock_irqrestore(&priv->lock, flags);
+	exynos_iommu_tlb_invalidate_entry(priv, iova, size);
 
 	return size;
 err:
@@ -1261,6 +1381,14 @@ static int __init exynos_iommu_init(void)
 		goto err_reg_driver;
 	}
 
+	zero_lv2_table = kmem_cache_zalloc(lv2table_kmem_cache, GFP_KERNEL);
+	if (zero_lv2_table == NULL) {
+		pr_err("%s: Failed to allocate zero level2 page table\n",
+			__func__);
+		ret = -ENOMEM;
+		goto err_zero_lv2;
+	}
+
 	ret = bus_set_iommu(&platform_bus_type, &exynos_iommu_ops);
 	if (ret) {
 		pr_err("%s: Failed to register exynos-iommu driver.\n",
@@ -1270,6 +1398,8 @@ static int __init exynos_iommu_init(void)
 
 	return 0;
 err_set_iommu:
+	kmem_cache_free(lv2table_kmem_cache, zero_lv2_table);
+err_zero_lv2:
 	platform_driver_unregister(&exynos_sysmmu_driver);
 err_reg_driver:
 	kmem_cache_destroy(lv2table_kmem_cache);
-- 
1.7.9.5
