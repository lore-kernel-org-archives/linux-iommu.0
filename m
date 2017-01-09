From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 2/4] iommu/exynos: Fix warnings from DMA-debug
Date: Mon, 09 Jan 2017 13:03:54 +0100
Message-ID: <1483963436-29803-3-git-send-email-m.szyprowski@samsung.com>
References: <1483963436-29803-1-git-send-email-m.szyprowski@samsung.com>
	<CGME20170109120412eucas1p2d0f898940a61a973bcc8d1645138f0ca@eucas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1483963436-29803-1-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Add a simple checks for dma_map_single() return value to make DMA-debug
checker happly. Exynos IOMMU on Samsung Exynos SoCs always use device,
which has linear DMA mapping ops (dma address is equal to physical memory
address), so no failures are returned from dma_map_single().

Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 058ee8425f35..b0d537e6a445 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -744,6 +744,8 @@ static struct iommu_domain *exynos_iommu_domain_alloc(unsigned type)
 				DMA_TO_DEVICE);
 	/* For mapping page table entries we rely on dma == phys */
 	BUG_ON(handle != virt_to_phys(domain->pgtable));
+	if (dma_mapping_error(dma_dev, handle))
+		goto err_lv2ent;
 
 	spin_lock_init(&domain->lock);
 	spin_lock_init(&domain->pgtablelock);
@@ -755,6 +757,8 @@ static struct iommu_domain *exynos_iommu_domain_alloc(unsigned type)
 
 	return &domain->domain;
 
+err_lv2ent:
+	free_pages((unsigned long)domain->lv2entcnt, 1);
 err_counter:
 	free_pages((unsigned long)domain->pgtable, 2);
 err_dma_cookie:
@@ -898,6 +902,7 @@ static sysmmu_pte_t *alloc_lv2entry(struct exynos_iommu_domain *domain,
 	}
 
 	if (lv1ent_fault(sent)) {
+		dma_addr_t handle;
 		sysmmu_pte_t *pent;
 		bool need_flush_flpd_cache = lv1ent_zero(sent);
 
@@ -909,7 +914,12 @@ static sysmmu_pte_t *alloc_lv2entry(struct exynos_iommu_domain *domain,
 		update_pte(sent, mk_lv1ent_page(virt_to_phys(pent)));
 		kmemleak_ignore(pent);
 		*pgcounter = NUM_LV2ENTRIES;
-		dma_map_single(dma_dev, pent, LV2TABLE_SIZE, DMA_TO_DEVICE);
+		handle = dma_map_single(dma_dev, pent, LV2TABLE_SIZE,
+					DMA_TO_DEVICE);
+		if (dma_mapping_error(dma_dev, handle)) {
+			kmem_cache_free(lv2table_kmem_cache, pent);
+			return ERR_PTR(-EADDRINUSE);
+		}
 
 		/*
 		 * If pre-fetched SLPD is a faulty SLPD in zero_l2_table,
-- 
1.9.1
