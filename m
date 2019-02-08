From: Tom Murphy <murphyt7@tcd.ie>
Subject: [PATCH] remove unused end_pfn
Date: Fri,  8 Feb 2019 14:04:38 +0000
Message-ID: <20190208140439.26738-1-murphyt7@tcd.ie>
References: <2017datesandletters@somehostname>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2017datesandletters@somehostname>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Tom Murphy <murphyt7@tcd.ie>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

This variable is useless.

---
 drivers/iommu/dma-iommu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 8e04b0603a4a..eff301d5e496 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -291,7 +291,7 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 {
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
-	unsigned long order, base_pfn, end_pfn;
+	unsigned long order, base_pfn;
 	int attr;
 
 	if (!cookie || cookie->type != IOMMU_DMA_IOVA_COOKIE)
@@ -300,7 +300,6 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	/* Use the smallest supported page size for IOVA granularity */
 	order = __ffs(domain->pgsize_bitmap);
 	base_pfn = max_t(unsigned long, 1, base >> order);
-	end_pfn = (base + size - 1) >> order;
 
 	/* Check the domain allows at least some access to the device... */
 	if (domain->geometry.force_aperture) {
-- 
2.17.1
