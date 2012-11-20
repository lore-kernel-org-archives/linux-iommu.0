From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v6 06/12] iommu/exynos: allocate lv2 page table from own slab
Date: Tue, 20 Nov 2012 16:30:26 +0900
Message-ID: <002001cdc6f0$e8eb2e30$bac18a90$%cho@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-language: ko
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: 'Kukjin Kim' <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, 'Subash Patel' <subash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Sanghyun Lee' <sanghyun75.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Since kmalloc() does not guarantee the alignment of 1KB when it
allocates 1KB, it is required to allocate lv2 page table from
own slab that guarantees alignment of 1KB.

Signed-off-by: KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index b939b6e..0191ab5 100644
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
@@ -868,7 +870,8 @@ static void exynos_iommu_domain_destroy(struct iommu_domain *domain)
 
 	for (i = 0; i < NUM_LV1ENTRIES; i++)
 		if (lv1ent_page(priv->pgtable + i))
-			kfree(__va(lv2table_base(priv->pgtable + i)));
+			kmem_cache_free(lv2table_kmem_cache,
+					__va(lv2table_base(priv->pgtable + i)));
 
 	free_pages((unsigned long)priv->pgtable, 2);
 	free_pages((unsigned long)priv->lv2entcnt, 1);
@@ -962,7 +965,7 @@ static unsigned long *alloc_lv2entry(unsigned long *sent, unsigned long iova,
 	if (lv1ent_fault(sent)) {
 		unsigned long *pent;
 
-		pent = kzalloc(LV2TABLE_SIZE, GFP_ATOMIC);
+		pent = kmem_cache_zalloc(lv2table_kmem_cache, GFP_ATOMIC);
 		BUG_ON((unsigned long)pent & (LV2TABLE_SIZE - 1));
 		if (!pent)
 			return NULL;
@@ -985,7 +988,7 @@ static int lv1set_section(unsigned long *sent, phys_addr_t paddr, short *pgcnt)
 		if (*pgcnt != NUM_LV2ENTRIES)
 			return -EADDRINUSE;
 
-		kfree(page_entry(sent, 0));
+		kmem_cache_free(lv2table_kmem_cache, page_entry(sent, 0));
 
 		*pgcnt = 0;
 	}
@@ -1171,10 +1174,23 @@ static int __init exynos_iommu_init(void)
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
