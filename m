From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 10/21] dma-iommu: move __iommu_dma_map
Date: Wed, 27 Mar 2019 09:04:37 +0100
Message-ID: <20190327080448.5500-11-hch@lst.de>
References: <20190327080448.5500-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327080448.5500-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Moving this function up to its unmap counterpart helps to keep related
code together for the following changes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 46 +++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 57f2d8621112..4d46beeea5b7 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -435,6 +435,29 @@ static void __iommu_dma_unmap(struct iommu_domain *domain, dma_addr_t dma_addr,
 	iommu_dma_free_iova(cookie, dma_addr, size);
 }
 
+static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
+		size_t size, int prot, struct iommu_domain *domain)
+{
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	size_t iova_off = 0;
+	dma_addr_t iova;
+
+	if (cookie->type == IOMMU_DMA_IOVA_COOKIE) {
+		iova_off = iova_offset(&cookie->iovad, phys);
+		size = iova_align(&cookie->iovad, size + iova_off);
+	}
+
+	iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
+	if (!iova)
+		return DMA_MAPPING_ERROR;
+
+	if (iommu_map(domain, iova, phys - iova_off, size, prot)) {
+		iommu_dma_free_iova(cookie, iova, size);
+		return DMA_MAPPING_ERROR;
+	}
+	return iova + iova_off;
+}
+
 static void __iommu_dma_free_pages(struct page **pages, int count)
 {
 	while (count--)
@@ -689,29 +712,6 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
 		arch_sync_dma_for_device(dev, sg_phys(sg), sg->length, dir);
 }
 
-static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
-		size_t size, int prot, struct iommu_domain *domain)
-{
-	struct iommu_dma_cookie *cookie = domain->iova_cookie;
-	size_t iova_off = 0;
-	dma_addr_t iova;
-
-	if (cookie->type == IOMMU_DMA_IOVA_COOKIE) {
-		iova_off = iova_offset(&cookie->iovad, phys);
-		size = iova_align(&cookie->iovad, size + iova_off);
-	}
-
-	iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
-	if (!iova)
-		return DMA_MAPPING_ERROR;
-
-	if (iommu_map(domain, iova, phys - iova_off, size, prot)) {
-		iommu_dma_free_iova(cookie, iova, size);
-		return DMA_MAPPING_ERROR;
-	}
-	return iova + iova_off;
-}
-
 static dma_addr_t __iommu_dma_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size, int prot)
 {
-- 
2.20.1
