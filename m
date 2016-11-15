From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] iommu/exynos: Fix warnings from DMA-debug
Date: Tue, 15 Nov 2016 11:01:09 +0100
Message-ID: <1479204069-29552-1-git-send-email-m.szyprowski@samsung.com>
References: <CGME20161115100127eucas1p102655ca6a67c33bb9e92c60bba7477a9@eucas1p1.samsung.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Seung-Woo Kim <sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Add a simple checks for dma_map_single() return value to make DMA-debug
checker happly. Exynos IOMMU on Samsung Exynos SoCs always use device,
which has linear DMA mapping ops (dma address is equal to physical memory
address), so no failures are returned from dma_map_single().

Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 30808e9..7b0bd86 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -763,6 +763,7 @@ static struct iommu_domain *exynos_iommu_domain_alloc(unsigned type)
 				DMA_TO_DEVICE);
 	/* For mapping page table entries we rely on dma == phys */
 	BUG_ON(handle != virt_to_phys(domain->pgtable));
+	BUG_ON(dma_mapping_error(dma_dev, handle));
 
 	spin_lock_init(&domain->lock);
 	spin_lock_init(&domain->pgtablelock);
@@ -909,6 +910,7 @@ static sysmmu_pte_t *alloc_lv2entry(struct exynos_iommu_domain *domain,
 	}
 
 	if (lv1ent_fault(sent)) {
+		dma_addr_t handle;
 		sysmmu_pte_t *pent;
 		bool need_flush_flpd_cache = lv1ent_zero(sent);
 
@@ -920,7 +922,9 @@ static sysmmu_pte_t *alloc_lv2entry(struct exynos_iommu_domain *domain,
 		update_pte(sent, mk_lv1ent_page(virt_to_phys(pent)));
 		kmemleak_ignore(pent);
 		*pgcounter = NUM_LV2ENTRIES;
-		dma_map_single(dma_dev, pent, LV2TABLE_SIZE, DMA_TO_DEVICE);
+		handle = dma_map_single(dma_dev, pent, LV2TABLE_SIZE,
+					DMA_TO_DEVICE);
+		BUG_ON(dma_mapping_error(dma_dev, handle));
 
 		/*
 		 * If pre-fetched SLPD is a faulty SLPD in zero_l2_table,
-- 
1.9.1
