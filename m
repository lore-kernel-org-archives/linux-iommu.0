From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 15/19] dma-iommu: refactor iommu_dma_alloc
Date: Mon, 14 Jan 2019 10:41:55 +0100
Message-ID: <20190114094159.27326-16-hch@lst.de>
References: <20190114094159.27326-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114094159.27326-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Split all functionality related to non-coherent devices into a
separate helper, and make the decision flow more obvious.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 51 +++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 956cb218c6ba..fd25c995bde4 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -760,6 +760,22 @@ static void *iommu_dma_alloc_pool(struct device *dev, size_t size,
 	return vaddr;
 }
 
+static void *iommu_dma_alloc_noncoherent(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
+{
+	/*
+	 * In atomic context we can't remap anything, so we'll only get the
+	 * virtually contiguous buffer we need by way of a physically
+	 * contiguous allocation.
+	 */
+	if (!gfpflags_allow_blocking(gfp))
+		return iommu_dma_alloc_pool(dev, size, dma_handle, gfp, attrs);
+	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS)
+		return iommu_dma_alloc_contiguous_remap(dev, size, dma_handle,
+				gfp, attrs);
+	return iommu_dma_alloc_remap(dev, size, dma_handle, gfp, attrs);
+}
+
 static void iommu_dma_sync_single_for_cpu(struct device *dev,
 		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
 {
@@ -1033,40 +1049,23 @@ static void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
 }
 
 static void *iommu_dma_alloc(struct device *dev, size_t size,
-		dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
-	bool coherent = dev_is_dma_coherent(dev);
-	size_t iosize = size;
-	void *addr;
-
 	/*
 	 * Some drivers rely on this, and we probably don't want the
 	 * possibility of stale kernel data being read by devices anyway.
 	 */
 	gfp |= __GFP_ZERO;
 
-	if (!gfpflags_allow_blocking(gfp)) {
-		/*
-		 * In atomic context we can't remap anything, so we'll only
-		 * get the virtually contiguous buffer we need by way of a
-		 * physically contiguous allocation.
-		 */
-		if (!coherent)
-			return iommu_dma_alloc_pool(dev, iosize, handle, gfp,
-					attrs);
-		return iommu_dma_alloc_contiguous(dev, iosize, handle, gfp,
+	if (!dev_is_dma_coherent(dev))
+		return iommu_dma_alloc_noncoherent(dev, size, dma_handle, gfp,
 				attrs);
-	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
-		if (coherent)
-			addr = iommu_dma_alloc_contiguous(dev, iosize, handle,
-					gfp, attrs);
-		else
-			addr = iommu_dma_alloc_contiguous_remap(dev, iosize,
-					handle, gfp, attrs);
-	} else {
-		addr = iommu_dma_alloc_remap(dev, iosize, handle, gfp, attrs);
-	}
-	return addr;
+
+	if (gfpflags_allow_blocking(gfp) &&
+	    !(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
+		return iommu_dma_alloc_remap(dev, size, dma_handle, gfp, attrs);
+
+	return iommu_dma_alloc_contiguous(dev, size, dma_handle, gfp, attrs);
 }
 
 static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
-- 
2.20.1
