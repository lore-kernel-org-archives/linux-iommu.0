From: Krishna Reddy <vdumpa@nvidia.com>
Subject: [PATCH] iommu/dma: limit the IOVA allocated to dma-ranges region
Date: Thu, 31 Aug 2017 15:08:21 -0700
Message-ID: <1504217301-17216-1-git-send-email-vdumpa@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, vdumpa@nvidia.com
List-Id: iommu@lists.linux-foundation.org

Limit the IOVA allocated to dma-ranges specified for the device.
This is necessary to ensure that IOVA allocated is addressable
by device.

Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
---
 drivers/iommu/dma-iommu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9d1cebe7f6cb..e8a8320b571b 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -364,6 +364,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
 	unsigned long shift, iova_len, iova = 0;
+	dma_addr_t dma_end_addr;
 
 	if (cookie->type == IOMMU_DMA_MSI_COOKIE) {
 		cookie->msi_iova += size;
@@ -381,6 +382,10 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 	if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
 		iova_len = roundup_pow_of_two(iova_len);
 
+	/* Limit IOVA allocated to device addressable dma-ranges region. */
+	dma_end_addr = (dma_addr_t)iovad->dma_32bit_pfn << shift;
+	dma_limit = dma_limit > dma_end_addr ? dma_end_addr : dma_limit;
+
 	if (domain->geometry.force_aperture)
 		dma_limit = min(dma_limit, domain->geometry.aperture_end);
 
-- 
2.1.4
