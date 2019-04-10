From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH] iommu/amd: remove the leftover of bypass support
Date: Wed, 10 Apr 2019 18:50:14 +0200
Message-ID: <20190410165014.9932-1-hch@lst.de>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The AMD iommu dma_ops are only attached on a per-device basis when an
actual translation is needed.  Remove the leftover bypass support which
in parts was already broken (e.g. it always returns 0 from ->map_sg).

Use the opportunity to remove a few local variables and move assignments
into the declaration line where they were previously separated by the
bypass check.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 80 +++++++++------------------------------
 1 file changed, 17 insertions(+), 63 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index f7cdd2ab7f11..982435434c3a 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2498,20 +2498,10 @@ static dma_addr_t map_page(struct device *dev, struct page *page,
 			   unsigned long attrs)
 {
 	phys_addr_t paddr = page_to_phys(page) + offset;
-	struct protection_domain *domain;
-	struct dma_ops_domain *dma_dom;
-	u64 dma_mask;
-
-	domain = get_domain(dev);
-	if (PTR_ERR(domain) == -EINVAL)
-		return (dma_addr_t)paddr;
-	else if (IS_ERR(domain))
-		return DMA_MAPPING_ERROR;
-
-	dma_mask = *dev->dma_mask;
-	dma_dom = to_dma_ops_domain(domain);
+	struct protection_domain *domain = get_domain(dev);
+	struct dma_ops_domain *dma_dom = to_dma_ops_domain(domain);
 
-	return __map_single(dev, dma_dom, paddr, size, dir, dma_mask);
+	return __map_single(dev, dma_dom, paddr, size, dir, *dev->dma_mask);
 }
 
 /*
@@ -2520,14 +2510,8 @@ static dma_addr_t map_page(struct device *dev, struct page *page,
 static void unmap_page(struct device *dev, dma_addr_t dma_addr, size_t size,
 		       enum dma_data_direction dir, unsigned long attrs)
 {
-	struct protection_domain *domain;
-	struct dma_ops_domain *dma_dom;
-
-	domain = get_domain(dev);
-	if (IS_ERR(domain))
-		return;
-
-	dma_dom = to_dma_ops_domain(domain);
+	struct protection_domain *domain = get_domain(dev);
+	struct dma_ops_domain *dma_dom = to_dma_ops_domain(domain);
 
 	__unmap_single(dma_dom, dma_addr, size, dir);
 }
@@ -2567,20 +2551,13 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 		  unsigned long attrs)
 {
 	int mapped_pages = 0, npages = 0, prot = 0, i;
-	struct protection_domain *domain;
-	struct dma_ops_domain *dma_dom;
+	struct protection_domain *domain = get_domain(dev);
+	struct dma_ops_domain *dma_dom = to_dma_ops_domain(domain);
 	struct scatterlist *s;
 	unsigned long address;
-	u64 dma_mask;
+	u64 dma_mask = *dev->dma_mask;
 	int ret;
 
-	domain = get_domain(dev);
-	if (IS_ERR(domain))
-		return 0;
-
-	dma_dom  = to_dma_ops_domain(domain);
-	dma_mask = *dev->dma_mask;
-
 	npages = sg_num_pages(dev, sglist, nelems);
 
 	address = dma_ops_alloc_iova(dev, dma_dom, npages, dma_mask);
@@ -2652,20 +2629,11 @@ static void unmap_sg(struct device *dev, struct scatterlist *sglist,
 		     int nelems, enum dma_data_direction dir,
 		     unsigned long attrs)
 {
-	struct protection_domain *domain;
-	struct dma_ops_domain *dma_dom;
-	unsigned long startaddr;
-	int npages = 2;
-
-	domain = get_domain(dev);
-	if (IS_ERR(domain))
-		return;
-
-	startaddr = sg_dma_address(sglist) & PAGE_MASK;
-	dma_dom   = to_dma_ops_domain(domain);
-	npages    = sg_num_pages(dev, sglist, nelems);
+	struct protection_domain *domain = get_domain(dev);
+	struct dma_ops_domain *dma_dom = to_dma_ops_domain(domain);
 
-	__unmap_single(dma_dom, startaddr, npages << PAGE_SHIFT, dir);
+	__unmap_single(dma_dom, sg_dma_address(sglist) & PAGE_MASK,
+			sg_num_pages(dev, sglist, nelems) << PAGE_SHIFT, dir);
 }
 
 /*
@@ -2676,16 +2644,11 @@ static void *alloc_coherent(struct device *dev, size_t size,
 			    unsigned long attrs)
 {
 	u64 dma_mask = dev->coherent_dma_mask;
-	struct protection_domain *domain;
+	struct protection_domain *domain = get_domain(dev);
 	struct dma_ops_domain *dma_dom;
 	struct page *page;
 
-	domain = get_domain(dev);
-	if (PTR_ERR(domain) == -EINVAL) {
-		page = alloc_pages(flag, get_order(size));
-		*dma_addr = page_to_phys(page);
-		return page_address(page);
-	} else if (IS_ERR(domain))
+	if (IS_ERR(domain))
 		return NULL;
 
 	dma_dom   = to_dma_ops_domain(domain);
@@ -2731,22 +2694,13 @@ static void free_coherent(struct device *dev, size_t size,
 			  void *virt_addr, dma_addr_t dma_addr,
 			  unsigned long attrs)
 {
-	struct protection_domain *domain;
-	struct dma_ops_domain *dma_dom;
-	struct page *page;
+	struct protection_domain *domain = get_domain(dev);
+	struct dma_ops_domain *dma_dom = to_dma_ops_domain(domain);
+	struct page *page = virt_to_page(virt_addr);
 
-	page = virt_to_page(virt_addr);
 	size = PAGE_ALIGN(size);
 
-	domain = get_domain(dev);
-	if (IS_ERR(domain))
-		goto free_mem;
-
-	dma_dom = to_dma_ops_domain(domain);
-
 	__unmap_single(dma_dom, dma_addr, size, DMA_BIDIRECTIONAL);
-
-free_mem:
 	if (!dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT))
 		__free_pages(page, get_order(size));
 }
-- 
2.20.1
