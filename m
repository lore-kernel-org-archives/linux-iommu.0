From: Cho KyongHo <pullip.cho@samsung.com>
Subject: [PATCH v8 04/12] iommu/exynos: allocate lv2 page table from own slab
Date: Fri, 26 Jul 2013 20:27:29 +0900
Message-ID: <003a01ce89f3$1cb475d0$561d6170$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Linux ARM Kernel' <linux-arm-kernel@lists.infradead.org>, 'Linux IOMMU' <iommu@lists.linux-foundation.org>, 'Linux Kernel' <linux-kernel@vger.kernel.org>, 'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>
Cc: 'Hyunwoong Kim' <khw0178.kim@samsung.com>, 'Joerg Roedel' <joro@8bytes.org>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Prathyush' <prathyush.k@samsung.com>, 'Rahul Sharma' <rahul.sharma@samsung.com>, 'Subash Patel' <supash.ramaswamy@linaro.org>, 'Keyyoung Park' <keyyoung.park@samsung.com>, 'Grant Grundler' <grundler@chromium.org>, 'Antonios Motakis' <a.motakis@virtualopensystems.com>, kvmarm@lists.cs.columbia.edu, 'Sachin Kamat' <sachin.kamat@linaro.org>
List-Id: iommu@lists.linux-foundation.org

Since kmalloc() does not guarantee that the allignment of 1KiB when it
allocates 1KiB, it is required to allocate lv2 page table from own
slab that guarantees alignment of 1KiB

Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
---
 drivers/iommu/exynos-iommu.c |   24 ++++++++++++++++++++----
 1 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 6c4ecce..093eea5 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -100,6 +100,8 @@
 #define REG_PB1_SADDR		0x054
 #define REG_PB1_EADDR		0x058
 
+static struct kmem_cache *lv2table_kmem_cache;
+
 static unsigned long *section_entry(unsigned long *pgtable, unsigned long iova)
 {
 	return pgtable + lv1ent_offset(iova);
@@ -765,7 +767,8 @@ static void exynos_iommu_domain_destroy(struct iommu_domain *domain)
 
 	for (i = 0; i < NUM_LV1ENTRIES; i++)
 		if (lv1ent_page(priv->pgtable + i))
-			kfree(__va(lv2table_base(priv->pgtable + i)));
+			kmem_cache_free(lv2table_kmem_cache,
+					__va(lv2table_base(priv->pgtable + i)));
 
 	free_pages((unsigned long)priv->pgtable, 2);
 	free_pages((unsigned long)priv->lv2entcnt, 1);
@@ -859,7 +862,7 @@ static unsigned long *alloc_lv2entry(unsigned long *sent, unsigned long iova,
 	if (lv1ent_fault(sent)) {
 		unsigned long *pent;
 
-		pent = kzalloc(LV2TABLE_SIZE, GFP_ATOMIC);
+		pent = kmem_cache_zalloc(lv2table_kmem_cache, GFP_ATOMIC);
 		BUG_ON((unsigned long)pent & (LV2TABLE_SIZE - 1));
 		if (!pent)
 			return ERR_PTR(-ENOMEM);
@@ -884,7 +887,7 @@ static int lv1set_section(unsigned long *sent, phys_addr_t paddr, short *pgcnt)
 		if (*pgcnt != NUM_LV2ENTRIES)
 			return -EADDRINUSE;
 
-		kfree(page_entry(sent, 0));
+		kmem_cache_free(lv2table_kmem_cache, page_entry(sent, 0));
 
 		*pgcnt = 0;
 	}
@@ -1092,10 +1095,23 @@ static int __init exynos_iommu_init(void)
 {
 	int ret;
 
+	lv2table_kmem_cache = kmem_cache_create("exynos-iommu-lv2table",
+				LV2TABLE_SIZE, LV2TABLE_SIZE, 0, NULL);
+	if (!lv2table_kmem_cache) {
+		pr_err("%s: Failed to create kmem cache\n", __func__);
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
1.7.2.5
