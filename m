From: Cho KyongHo <pullip.cho@samsung.com>
Subject: [PATCH v3 06/12] iommu/exynos: allocate lv2 page table from own slab
Date: Wed, 21 Nov 2012 14:05:55 +0900
Message-ID: <002d01cdc7a5$e32ad9e0$a9808da0$%cho@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: 'Joerg Roedel' <joro@8bytes.org>, sw0312.kim@samsung.com, 'Sanghyun Lee' <sanghyun75.lee@samsung.com>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Subash Patel' <subash.ramaswamy@linaro.org>, prathyush.k@samsung.com, rahul.sharma@samsung.com
List-Id: iommu@lists.linux-foundation.org

Since kmalloc() does not guarantee the alignment of 1KB when it
allocates 1KB, it is required to allocate lv2 page table from
own slab that guarantees alignment of 1KB.

Change-Id: Ia25642c7c0143d2c50a8ed5a3d0dd9067f324c4e
Signed-off-by: KyongHo Cho <pullip.cho@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 4061b17..0bb194e 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -104,6 +104,8 @@
 #define REG_PB1_SADDR		0x054
 #define REG_PB1_EADDR		0x058
 
+static struct kmem_cache *lv2table_kmem_cache;
+
 static unsigned long *section_entry(unsigned long *pgtable, unsigned long iova)
 {
 	return pgtable + lv1ent_offset(iova);
@@ -865,7 +867,8 @@ static void exynos_iommu_domain_destroy(struct iommu_domain *domain)
 
 	for (i = 0; i < NUM_LV1ENTRIES; i++)
 		if (lv1ent_page(priv->pgtable + i))
-			kfree(__va(lv2table_base(priv->pgtable + i)));
+			kmem_cache_free(lv2table_kmem_cache,
+					__va(lv2table_base(priv->pgtable + i)));
 
 	free_pages((unsigned long)priv->pgtable, 2);
 	free_pages((unsigned long)priv->lv2entcnt, 1);
@@ -959,7 +962,7 @@ static unsigned long *alloc_lv2entry(unsigned long *sent, unsigned long iova,
 	if (lv1ent_fault(sent)) {
 		unsigned long *pent;
 
-		pent = kzalloc(LV2TABLE_SIZE, GFP_ATOMIC);
+		pent = kmem_cache_zalloc(lv2table_kmem_cache, GFP_ATOMIC);
 		BUG_ON((unsigned long)pent & (LV2TABLE_SIZE - 1));
 		if (!pent)
 			return NULL;
@@ -982,7 +985,7 @@ static int lv1set_section(unsigned long *sent, phys_addr_t paddr, short *pgcnt)
 		if (*pgcnt != NUM_LV2ENTRIES)
 			return -EADDRINUSE;
 
-		kfree(page_entry(sent, 0));
+		kmem_cache_free(lv2table_kmem_cache, page_entry(sent, 0));
 
 		*pgcnt = 0;
 	}
@@ -1168,10 +1171,23 @@ static int __init exynos_iommu_init(void)
 {
 	int ret;
 
+	lv2table_kmem_cache = kmem_cache_create("exynos-iommu-lv2table",
+		LV2TABLE_SIZE, LV2TABLE_SIZE, 0, NULL);
+	if (!lv2table_kmem_cache) {
+		pr_err("%s: failed to create kmem cache\n", __func__);
+		return -ENOMEM;
+	}
+
 	ret = platform_driver_register(&exynos_sysmmu_driver);
 
 	if (ret == 0)
-		bus_set_iommu(&platform_bus_type, &exynos_iommu_ops);
+		ret = bus_set_iommu(&platform_bus_type, &exynos_iommu_ops);
+
+	if (ret) {
+		pr_err("%s: Failed to register exynos-iommu driver.\n",
+								__func__);
+		kmem_cache_destroy(lv2table_kmem_cache);
+	}
 
 	return ret;
 }
-- 
1.8.0
