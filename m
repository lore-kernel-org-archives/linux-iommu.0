From: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 26/33] iommu/vt-d: Rename 'hwdev' variables to 'dev' now that
	that's the norm
Date: Fri, 21 Mar 2014 17:19:07 +0000
Message-ID: <1395422354-19762-27-git-send-email-David.Woodhouse@intel.com>
References: <1395422354-19762-1-git-send-email-David.Woodhouse@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1395422354-19762-1-git-send-email-David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index cfe08ea..f3c1624 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2955,7 +2955,7 @@ static int iommu_no_mapping(struct device *dev)
 	return 0;
 }
 
-static dma_addr_t __intel_map_single(struct device *hwdev, phys_addr_t paddr,
+static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 				     size_t size, int dir, u64 dma_mask)
 {
 	struct dmar_domain *domain;
@@ -2968,17 +2968,17 @@ static dma_addr_t __intel_map_single(struct device *hwdev, phys_addr_t paddr,
 
 	BUG_ON(dir == DMA_NONE);
 
-	if (iommu_no_mapping(hwdev))
+	if (iommu_no_mapping(dev))
 		return paddr;
 
-	domain = get_valid_domain_for_dev(hwdev);
+	domain = get_valid_domain_for_dev(dev);
 	if (!domain)
 		return 0;
 
 	iommu = domain_get_iommu(domain);
 	size = aligned_nrpages(paddr, size);
 
-	iova = intel_alloc_iova(hwdev, domain, dma_to_mm_pfn(size), dma_mask);
+	iova = intel_alloc_iova(dev, domain, dma_to_mm_pfn(size), dma_mask);
 	if (!iova)
 		goto error;
 
@@ -3016,7 +3016,7 @@ error:
 	if (iova)
 		__free_iova(&domain->iovad, iova);
 	printk(KERN_ERR"Device %s request: %zx@%llx dir %d --- failed\n",
-		dev_name(hwdev), size, (unsigned long long)paddr, dir);
+		dev_name(dev), size, (unsigned long long)paddr, dir);
 	return 0;
 }
 
@@ -3155,7 +3155,7 @@ static void intel_unmap_page(struct device *dev, dma_addr_t dev_addr,
 	}
 }
 
-static void *intel_alloc_coherent(struct device *hwdev, size_t size,
+static void *intel_alloc_coherent(struct device *dev, size_t size,
 				  dma_addr_t *dma_handle, gfp_t flags,
 				  struct dma_attrs *attrs)
 {
@@ -3165,10 +3165,10 @@ static void *intel_alloc_coherent(struct device *hwdev, size_t size,
 	size = PAGE_ALIGN(size);
 	order = get_order(size);
 
-	if (!iommu_no_mapping(hwdev))
+	if (!iommu_no_mapping(dev))
 		flags &= ~(GFP_DMA | GFP_DMA32);
-	else if (hwdev->coherent_dma_mask < dma_get_required_mask(hwdev)) {
-		if (hwdev->coherent_dma_mask < DMA_BIT_MASK(32))
+	else if (dev->coherent_dma_mask < dma_get_required_mask(dev)) {
+		if (dev->coherent_dma_mask < DMA_BIT_MASK(32))
 			flags |= GFP_DMA;
 		else
 			flags |= GFP_DMA32;
@@ -3179,16 +3179,16 @@ static void *intel_alloc_coherent(struct device *hwdev, size_t size,
 		return NULL;
 	memset(vaddr, 0, size);
 
-	*dma_handle = __intel_map_single(hwdev, virt_to_bus(vaddr), size,
+	*dma_handle = __intel_map_single(dev, virt_to_bus(vaddr), size,
 					 DMA_BIDIRECTIONAL,
-					 hwdev->coherent_dma_mask);
+					 dev->coherent_dma_mask);
 	if (*dma_handle)
 		return vaddr;
 	free_pages((unsigned long)vaddr, order);
 	return NULL;
 }
 
-static void intel_free_coherent(struct device *hwdev, size_t size, void *vaddr,
+static void intel_free_coherent(struct device *dev, size_t size, void *vaddr,
 				dma_addr_t dma_handle, struct dma_attrs *attrs)
 {
 	int order;
@@ -3196,11 +3196,11 @@ static void intel_free_coherent(struct device *hwdev, size_t size, void *vaddr,
 	size = PAGE_ALIGN(size);
 	order = get_order(size);
 
-	intel_unmap_page(hwdev, dma_handle, size, DMA_BIDIRECTIONAL, NULL);
+	intel_unmap_page(dev, dma_handle, size, DMA_BIDIRECTIONAL, NULL);
 	free_pages((unsigned long)vaddr, order);
 }
 
-static void intel_unmap_sg(struct device *hwdev, struct scatterlist *sglist,
+static void intel_unmap_sg(struct device *dev, struct scatterlist *sglist,
 			   int nelems, enum dma_data_direction dir,
 			   struct dma_attrs *attrs)
 {
@@ -3210,10 +3210,10 @@ static void intel_unmap_sg(struct device *hwdev, struct scatterlist *sglist,
 	struct intel_iommu *iommu;
 	struct page *freelist;
 
-	if (iommu_no_mapping(hwdev))
+	if (iommu_no_mapping(dev))
 		return;
 
-	domain = find_domain(hwdev);
+	domain = find_domain(dev);
 	BUG_ON(!domain);
 
 	iommu = domain_get_iommu(domain);
@@ -3257,7 +3257,7 @@ static int intel_nontranslate_map_sg(struct device *hddev,
 	return nelems;
 }
 
-static int intel_map_sg(struct device *hwdev, struct scatterlist *sglist, int nelems,
+static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nelems,
 			enum dma_data_direction dir, struct dma_attrs *attrs)
 {
 	int i;
@@ -3271,10 +3271,10 @@ static int intel_map_sg(struct device *hwdev, struct scatterlist *sglist, int ne
 	struct intel_iommu *iommu;
 
 	BUG_ON(dir == DMA_NONE);
-	if (iommu_no_mapping(hwdev))
-		return intel_nontranslate_map_sg(hwdev, sglist, nelems, dir);
+	if (iommu_no_mapping(dev))
+		return intel_nontranslate_map_sg(dev, sglist, nelems, dir);
 
-	domain = get_valid_domain_for_dev(hwdev);
+	domain = get_valid_domain_for_dev(dev);
 	if (!domain)
 		return 0;
 
@@ -3283,8 +3283,8 @@ static int intel_map_sg(struct device *hwdev, struct scatterlist *sglist, int ne
 	for_each_sg(sglist, sg, nelems, i)
 		size += aligned_nrpages(sg->offset, sg->length);
 
-	iova = intel_alloc_iova(hwdev, domain, dma_to_mm_pfn(size),
-				*hwdev->dma_mask);
+	iova = intel_alloc_iova(dev, domain, dma_to_mm_pfn(size),
+				*dev->dma_mask);
 	if (!iova) {
 		sglist->dma_length = 0;
 		return 0;
-- 
1.8.5.3
