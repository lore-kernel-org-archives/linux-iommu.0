From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 02/11] iommu: exynos: add support for IOMMU_DOMAIN_DMA domain
 type
Date: Tue, 16 Feb 2016 15:56:55 +0100
Message-ID: <1455634624-18130-3-git-send-email-m.szyprowski@samsung.com>
References: <1455634624-18130-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1455634624-18130-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: iommu@lists.linux-foundation.org

This patch adds support for DMA domain type. Such domain have DMA cookie
prepared and can be used by generic DMA-IOMMU glue layer.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 4fc0790..595e0da 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -25,9 +25,9 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
+#include <linux/dma-iommu.h>
 
 #include <asm/cacheflush.h>
-#include <asm/dma-iommu.h>
 #include <asm/pgtable.h>
 
 typedef u32 sysmmu_iova_t;
@@ -662,16 +662,21 @@ static struct iommu_domain *exynos_iommu_domain_alloc(unsigned type)
 	struct exynos_iommu_domain *domain;
 	int i;
 
-	if (type != IOMMU_DOMAIN_UNMANAGED)
-		return NULL;
 
 	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
 	if (!domain)
 		return NULL;
 
+	if (type == IOMMU_DOMAIN_DMA) {
+		if (iommu_get_dma_cookie(&domain->domain) != 0)
+			goto err_pgtable;
+	} else if (type != IOMMU_DOMAIN_UNMANAGED) {
+		goto err_pgtable;
+	}
+
 	domain->pgtable = (sysmmu_pte_t *)__get_free_pages(GFP_KERNEL, 2);
 	if (!domain->pgtable)
-		goto err_pgtable;
+		goto err_dma_cookie;
 
 	domain->lv2entcnt = (short *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, 1);
 	if (!domain->lv2entcnt)
@@ -703,6 +708,9 @@ static struct iommu_domain *exynos_iommu_domain_alloc(unsigned type)
 
 err_counter:
 	free_pages((unsigned long)domain->pgtable, 2);
+err_dma_cookie:
+	if (type == IOMMU_DOMAIN_DMA)
+		iommu_put_dma_cookie(&domain->domain);
 err_pgtable:
 	kfree(domain);
 	return NULL;
@@ -727,6 +735,9 @@ static void exynos_iommu_domain_free(struct iommu_domain *iommu_domain)
 
 	spin_unlock_irqrestore(&domain->lock, flags);
 
+	if (iommu_domain->type == IOMMU_DOMAIN_DMA)
+		iommu_put_dma_cookie(iommu_domain);
+
 	for (i = 0; i < NUM_LV1ENTRIES; i++)
 		if (lv1ent_page(domain->pgtable + i))
 			kmem_cache_free(lv2table_kmem_cache,
-- 
1.9.2
