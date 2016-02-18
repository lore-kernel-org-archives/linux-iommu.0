From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2 03/13] iommu: exynos: remove ARM-specific cache flush
 interface
Date: Thu, 18 Feb 2016 15:12:50 +0100
Message-ID: <1455804780-9616-4-git-send-email-m.szyprowski@samsung.com>
References: <1455804780-9616-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1455804780-9616-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: iommu@lists.linux-foundation.org

This patch replaces custom ARM-specific code for performing CPU cache flush
operations with generic code based on DMA-mapping. Domain managing code
is independent of particular SYSMMU device, so the first registered SYSMMU
device is used for DMA-mapping calls. This simplification works fine
because all SYSMMU controllers are in the same address space (where
DMA address equals physical address) and the DMA-mapping calls are done
mainly to flush CPU cache to make changes visible to SYSMMU controllers.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 74 +++++++++++++++++++++++++++++---------------
 1 file changed, 49 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 595e0da55db4..8c8a7f7968d1 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -27,9 +27,6 @@
 #include <linux/slab.h>
 #include <linux/dma-iommu.h>
 
-#include <asm/cacheflush.h>
-#include <asm/pgtable.h>
-
 typedef u32 sysmmu_iova_t;
 typedef u32 sysmmu_pte_t;
 
@@ -83,6 +80,7 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
 	return (iova >> SPAGE_ORDER) & (NUM_LV2ENTRIES - 1);
 }
 
+#define LV1TABLE_SIZE (NUM_LV1ENTRIES * sizeof(sysmmu_pte_t))
 #define LV2TABLE_SIZE (NUM_LV2ENTRIES * sizeof(sysmmu_pte_t))
 
 #define SPAGES_PER_LPAGE (LPAGE_SIZE / SPAGE_SIZE)
@@ -134,6 +132,7 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
 
 #define has_sysmmu(dev)		(dev->archdata.iommu != NULL)
 
+static struct device *dma_dev;
 static struct kmem_cache *lv2table_kmem_cache;
 static sysmmu_pte_t *zero_lv2_table;
 #define ZERO_LV2LINK mk_lv1ent_page(virt_to_phys(zero_lv2_table))
@@ -650,16 +649,19 @@ static struct platform_driver exynos_sysmmu_driver __refdata = {
 	}
 };
 
-static inline void pgtable_flush(void *vastart, void *vaend)
+static inline void update_pte(sysmmu_pte_t *ent, sysmmu_pte_t val)
 {
-	dmac_flush_range(vastart, vaend);
-	outer_flush_range(virt_to_phys(vastart),
-				virt_to_phys(vaend));
+	dma_sync_single_for_cpu(dma_dev, virt_to_phys(ent), sizeof(*ent),
+				DMA_TO_DEVICE);
+	*ent = val;
+	dma_sync_single_for_device(dma_dev, virt_to_phys(ent), sizeof(*ent),
+				   DMA_TO_DEVICE);
 }
 
 static struct iommu_domain *exynos_iommu_domain_alloc(unsigned type)
 {
 	struct exynos_iommu_domain *domain;
+	dma_addr_t handle;
 	int i;
 
 
@@ -694,7 +696,10 @@ static struct iommu_domain *exynos_iommu_domain_alloc(unsigned type)
 		domain->pgtable[i + 7] = ZERO_LV2LINK;
 	}
 
-	pgtable_flush(domain->pgtable, domain->pgtable + NUM_LV1ENTRIES);
+	handle = dma_map_single(dma_dev, domain->pgtable, LV1TABLE_SIZE,
+				DMA_TO_DEVICE);
+	/* For mapping page table entries we rely on dma == phys */
+	BUG_ON(handle != virt_to_phys(domain->pgtable));
 
 	spin_lock_init(&domain->lock);
 	spin_lock_init(&domain->pgtablelock);
@@ -738,10 +743,18 @@ static void exynos_iommu_domain_free(struct iommu_domain *iommu_domain)
 	if (iommu_domain->type == IOMMU_DOMAIN_DMA)
 		iommu_put_dma_cookie(iommu_domain);
 
+	dma_unmap_single(dma_dev, virt_to_phys(domain->pgtable), LV1TABLE_SIZE,
+			 DMA_TO_DEVICE);
+
 	for (i = 0; i < NUM_LV1ENTRIES; i++)
-		if (lv1ent_page(domain->pgtable + i))
+		if (lv1ent_page(domain->pgtable + i)) {
+			phys_addr_t base = lv2table_base(domain->pgtable + i);
+
+			dma_unmap_single(dma_dev, base, LV2TABLE_SIZE,
+					 DMA_TO_DEVICE);
 			kmem_cache_free(lv2table_kmem_cache,
-				phys_to_virt(lv2table_base(domain->pgtable + i)));
+					phys_to_virt(base));
+		}
 
 	free_pages((unsigned long)domain->pgtable, 2);
 	free_pages((unsigned long)domain->lv2entcnt, 1);
@@ -834,11 +847,10 @@ static sysmmu_pte_t *alloc_lv2entry(struct exynos_iommu_domain *domain,
 		if (!pent)
 			return ERR_PTR(-ENOMEM);
 
-		*sent = mk_lv1ent_page(virt_to_phys(pent));
+		update_pte(sent, mk_lv1ent_page(virt_to_phys(pent)));
 		kmemleak_ignore(pent);
 		*pgcounter = NUM_LV2ENTRIES;
-		pgtable_flush(pent, pent + NUM_LV2ENTRIES);
-		pgtable_flush(sent, sent + 1);
+		dma_map_single(dma_dev, pent, LV2TABLE_SIZE, DMA_TO_DEVICE);
 
 		/*
 		 * If pre-fetched SLPD is a faulty SLPD in zero_l2_table,
@@ -891,9 +903,7 @@ static int lv1set_section(struct exynos_iommu_domain *domain,
 		*pgcnt = 0;
 	}
 
-	*sent = mk_lv1ent_sect(paddr);
-
-	pgtable_flush(sent, sent + 1);
+	update_pte(sent, mk_lv1ent_sect(paddr));
 
 	spin_lock(&domain->lock);
 	if (lv1ent_page_zero(sent)) {
@@ -917,12 +927,15 @@ static int lv2set_page(sysmmu_pte_t *pent, phys_addr_t paddr, size_t size,
 		if (WARN_ON(!lv2ent_fault(pent)))
 			return -EADDRINUSE;
 
-		*pent = mk_lv2ent_spage(paddr);
-		pgtable_flush(pent, pent + 1);
+		update_pte(pent, mk_lv2ent_spage(paddr));
 		*pgcnt -= 1;
 	} else { /* size == LPAGE_SIZE */
 		int i;
+		dma_addr_t pent_base = virt_to_phys(pent);
 
+		dma_sync_single_for_cpu(dma_dev, pent_base,
+					sizeof(*pent) * SPAGES_PER_LPAGE,
+					DMA_TO_DEVICE);
 		for (i = 0; i < SPAGES_PER_LPAGE; i++, pent++) {
 			if (WARN_ON(!lv2ent_fault(pent))) {
 				if (i > 0)
@@ -932,7 +945,9 @@ static int lv2set_page(sysmmu_pte_t *pent, phys_addr_t paddr, size_t size,
 
 			*pent = mk_lv2ent_lpage(paddr);
 		}
-		pgtable_flush(pent - SPAGES_PER_LPAGE, pent);
+		dma_sync_single_for_device(dma_dev, pent_base,
+					   sizeof(*pent) * SPAGES_PER_LPAGE,
+					   DMA_TO_DEVICE);
 		*pgcnt -= SPAGES_PER_LPAGE;
 	}
 
@@ -1042,8 +1057,7 @@ static size_t exynos_iommu_unmap(struct iommu_domain *iommu_domain,
 		}
 
 		/* workaround for h/w bug in System MMU v3.3 */
-		*ent = ZERO_LV2LINK;
-		pgtable_flush(ent, ent + 1);
+		update_pte(ent, ZERO_LV2LINK);
 		size = SECT_SIZE;
 		goto done;
 	}
@@ -1064,9 +1078,8 @@ static size_t exynos_iommu_unmap(struct iommu_domain *iommu_domain,
 	}
 
 	if (lv2ent_small(ent)) {
-		*ent = 0;
+		update_pte(ent, 0);
 		size = SPAGE_SIZE;
-		pgtable_flush(ent, ent + 1);
 		domain->lv2entcnt[lv1ent_offset(iova)] += 1;
 		goto done;
 	}
@@ -1077,9 +1090,13 @@ static size_t exynos_iommu_unmap(struct iommu_domain *iommu_domain,
 		goto err;
 	}
 
+	dma_sync_single_for_cpu(dma_dev, virt_to_phys(ent),
+				sizeof(*ent) * SPAGES_PER_LPAGE,
+				DMA_TO_DEVICE);
 	memset(ent, 0, sizeof(*ent) * SPAGES_PER_LPAGE);
-	pgtable_flush(ent, ent + SPAGES_PER_LPAGE);
-
+	dma_sync_single_for_device(dma_dev, virt_to_phys(ent),
+				   sizeof(*ent) * SPAGES_PER_LPAGE,
+				   DMA_TO_DEVICE);
 	size = LPAGE_SIZE;
 	domain->lv2entcnt[lv1ent_offset(iova)] += SPAGES_PER_LPAGE;
 done:
@@ -1261,6 +1278,13 @@ static int __init exynos_iommu_of_setup(struct device_node *np)
 	if (IS_ERR(pdev))
 		return PTR_ERR(pdev);
 
+	/*
+	 * use the first registered sysmmu device for performing
+	 * dma mapping operations on iommu page tables (cpu cache flush)
+	 */
+	if (!dma_dev)
+		dma_dev = &pdev->dev;
+
 	of_iommu_set_ops(np, &exynos_iommu_ops);
 	return 0;
 }
-- 
1.9.2
