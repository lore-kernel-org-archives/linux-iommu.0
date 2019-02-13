From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 12/21] dma-iommu: factor atomic pool allocations into helpers
Date: Wed, 13 Feb 2019 19:29:11 +0100
Message-ID: <20190213182920.16764-13-hch@lst.de>
References: <20190213182920.16764-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190213182920.16764-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

This keeps the code together and will simplify compiling the code
out on architectures that are always dma coherent.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 51 +++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index c1ecb0c3436e..ff1ada9f98f5 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -674,6 +674,35 @@ static int iommu_dma_get_sgtable_remap(struct sg_table *sgt, void *cpu_addr,
 			GFP_KERNEL);
 }
 
+static void iommu_dma_free_pool(struct device *dev, size_t size,
+		void *vaddr, dma_addr_t dma_handle)
+{
+	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), dma_handle, size);
+	dma_free_from_pool(vaddr, PAGE_ALIGN(size));
+}
+
+static void *iommu_dma_alloc_pool(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
+{
+	bool coherent = dev_is_dma_coherent(dev);
+	struct page *page;
+	void *vaddr;
+
+	vaddr = dma_alloc_from_pool(PAGE_ALIGN(size), &page, gfp);
+	if (!vaddr)
+		return NULL;
+
+	*dma_handle = __iommu_dma_map(dev, page_to_phys(page), size,
+			dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs),
+			iommu_get_domain_for_dev(dev));
+	if (*dma_handle == DMA_MAPPING_ERROR) {
+		dma_free_from_pool(vaddr, PAGE_ALIGN(size));
+		return NULL;
+	}
+
+	return vaddr;
+}
+
 static void iommu_dma_sync_single_for_cpu(struct device *dev,
 		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
 {
@@ -982,21 +1011,18 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 		 * get the virtually contiguous buffer we need by way of a
 		 * physically contiguous allocation.
 		 */
-		if (coherent) {
-			page = alloc_pages(gfp, get_order(size));
-			addr = page ? page_address(page) : NULL;
-		} else {
-			addr = dma_alloc_from_pool(size, &page, gfp);
-		}
-		if (!addr)
+		if (!coherent)
+			return iommu_dma_alloc_pool(dev, iosize, handle, gfp,
+					attrs);
+
+		page = alloc_pages(gfp, get_order(size));
+		if (!page)
 			return NULL;
 
+		addr = page_address(page);
 		*handle = __iommu_dma_map_page(dev, page, 0, iosize, ioprot);
 		if (*handle == DMA_MAPPING_ERROR) {
-			if (coherent)
-				__free_pages(page, get_order(size));
-			else
-				dma_free_from_pool(addr, size);
+			__free_pages(page, get_order(size));
 			addr = NULL;
 		}
 	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
@@ -1050,8 +1076,7 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
 	 * Hence how dodgy the below logic looks...
 	 */
 	if (dma_in_atomic_pool(cpu_addr, size)) {
-		__iommu_dma_unmap_page(dev, handle, iosize, 0, 0);
-		dma_free_from_pool(cpu_addr, size);
+		iommu_dma_free_pool(dev, size, cpu_addr, handle);
 	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
 		struct page *page = vmalloc_to_page(cpu_addr);
 
-- 
2.20.1
