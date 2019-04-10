From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 2/3] intel-iommu: use dma_direct for bypass devices
Date: Wed, 10 Apr 2019 18:14:07 +0200
Message-ID: <20190410161408.7119-3-hch@lst.de>
References: <20190410161408.7119-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190410161408.7119-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The intel-iommu driver currently has a partial reimplementation
of the direct mapping code for devices that use pass through
mode.  Replace that code with calls to the relevant dma_direct
routines at the highest level.  This means we have exactly the
same behvior as the dma direct code itself, and can prepare for
eventually only attaching the intel_iommu ops to devices that
actually need dynamic iommu mappings.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 71 ++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 40 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 121a0cb450df..497217cb0880 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3655,9 +3655,6 @@ static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 
 	BUG_ON(dir == DMA_NONE);
 
-	if (!iommu_need_mapping(dev))
-		return paddr;
-
 	domain = get_valid_domain_for_dev(dev);
 	if (!domain)
 		return DMA_MAPPING_ERROR;
@@ -3706,15 +3703,20 @@ static dma_addr_t intel_map_page(struct device *dev, struct page *page,
 				 enum dma_data_direction dir,
 				 unsigned long attrs)
 {
-	return __intel_map_single(dev, page_to_phys(page) + offset, size,
-				  dir, *dev->dma_mask);
+	if (iommu_need_mapping(dev))
+		return __intel_map_single(dev, page_to_phys(page) + offset,
+				size, dir, *dev->dma_mask);
+	return dma_direct_map_page(dev, page, offset, size, dir, attrs);
 }
 
 static dma_addr_t intel_map_resource(struct device *dev, phys_addr_t phys_addr,
 				     size_t size, enum dma_data_direction dir,
 				     unsigned long attrs)
 {
-	return __intel_map_single(dev, phys_addr, size, dir, *dev->dma_mask);
+	if (iommu_need_mapping(dev))
+		return __intel_map_single(dev, phys_addr, size, dir,
+				*dev->dma_mask);
+	return dma_direct_map_resource(dev, phys_addr, size, dir, attrs);
 }
 
 static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
@@ -3726,9 +3728,6 @@ static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
 	struct intel_iommu *iommu;
 	struct page *freelist;
 
-	if (!iommu_need_mapping(dev))
-		return;
-
 	domain = find_domain(dev);
 	BUG_ON(!domain);
 
@@ -3764,7 +3763,17 @@ static void intel_unmap_page(struct device *dev, dma_addr_t dev_addr,
 			     size_t size, enum dma_data_direction dir,
 			     unsigned long attrs)
 {
-	intel_unmap(dev, dev_addr, size);
+	if (iommu_need_mapping(dev))
+		intel_unmap(dev, dev_addr, size);
+	else
+		dma_direct_unmap_page(dev, dev_addr, size, dir, attrs);
+}
+
+static void intel_unmap_resource(struct device *dev, dma_addr_t dev_addr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+	if (iommu_need_mapping(dev))
+		intel_unmap(dev, dev_addr, size);
 }
 
 static void *intel_alloc_coherent(struct device *dev, size_t size,
@@ -3774,28 +3783,18 @@ static void *intel_alloc_coherent(struct device *dev, size_t size,
 	struct page *page = NULL;
 	int order;
 
+	if (!iommu_need_mapping(dev))
+		return dma_direct_alloc(dev, size, dma_handle, flags, attrs);
+
 	size = PAGE_ALIGN(size);
 	order = get_order(size);
-
-	if (iommu_need_mapping(dev))
-		flags &= ~(GFP_DMA | GFP_DMA32);
-	else if (dev->coherent_dma_mask < dma_get_required_mask(dev)) {
-		if (dev->coherent_dma_mask < DMA_BIT_MASK(32))
-			flags |= GFP_DMA;
-		else
-			flags |= GFP_DMA32;
-	}
+	flags &= ~(GFP_DMA | GFP_DMA32);
 
 	if (gfpflags_allow_blocking(flags)) {
 		unsigned int count = size >> PAGE_SHIFT;
 
 		page = dma_alloc_from_contiguous(dev, count, order,
 						 flags & __GFP_NOWARN);
-		if (page && !iommu_need_mapping(dev) &&
-		    page_to_phys(page) + size > dev->coherent_dma_mask) {
-			dma_release_from_contiguous(dev, page, count);
-			page = NULL;
-		}
 	}
 
 	if (!page)
@@ -3821,6 +3820,9 @@ static void intel_free_coherent(struct device *dev, size_t size, void *vaddr,
 	int order;
 	struct page *page = virt_to_page(vaddr);
 
+	if (!iommu_need_mapping(dev))
+		return dma_direct_free(dev, size, vaddr, dma_handle, attrs);
+
 	size = PAGE_ALIGN(size);
 	order = get_order(size);
 
@@ -3838,6 +3840,9 @@ static void intel_unmap_sg(struct device *dev, struct scatterlist *sglist,
 	struct scatterlist *sg;
 	int i;
 
+	if (!iommu_need_mapping(dev))
+		return dma_direct_unmap_sg(dev, sglist, nelems, dir, attrs);
+
 	for_each_sg(sglist, sg, nelems, i) {
 		nrpages += aligned_nrpages(sg_dma_address(sg), sg_dma_len(sg));
 	}
@@ -3845,20 +3850,6 @@ static void intel_unmap_sg(struct device *dev, struct scatterlist *sglist,
 	intel_unmap(dev, startaddr, nrpages << VTD_PAGE_SHIFT);
 }
 
-static int intel_nontranslate_map_sg(struct device *hddev,
-	struct scatterlist *sglist, int nelems, int dir)
-{
-	int i;
-	struct scatterlist *sg;
-
-	for_each_sg(sglist, sg, nelems, i) {
-		BUG_ON(!sg_page(sg));
-		sg->dma_address = sg_phys(sg);
-		sg->dma_length = sg->length;
-	}
-	return nelems;
-}
-
 static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nelems,
 			enum dma_data_direction dir, unsigned long attrs)
 {
@@ -3874,7 +3865,7 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 
 	BUG_ON(dir == DMA_NONE);
 	if (!iommu_need_mapping(dev))
-		return intel_nontranslate_map_sg(dev, sglist, nelems, dir);
+		return dma_direct_map_sg(dev, sglist, nelems, dir, attrs);
 
 	domain = get_valid_domain_for_dev(dev);
 	if (!domain)
@@ -3924,7 +3915,7 @@ static const struct dma_map_ops intel_dma_ops = {
 	.map_page = intel_map_page,
 	.unmap_page = intel_unmap_page,
 	.map_resource = intel_map_resource,
-	.unmap_resource = intel_unmap_page,
+	.unmap_resource = intel_unmap_resource,
 	.dma_supported = dma_direct_supported,
 };
 
-- 
2.20.1
