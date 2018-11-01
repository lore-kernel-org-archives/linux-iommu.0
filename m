From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH] iommu/dma: Zero pages manually in a length of scatterlist
Date: Thu,  1 Nov 2018 14:35:00 -0700
Message-ID: <20181101213500.21800-1-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: vdumpa@nvidia.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

The __GFP_ZERO will be passed down to the generic page allocation
routine which zeros everything page by page. This is safe to be a
generic way but not efficient for iommu allocation that organizes
contiguous pages using scatterlist.

So this changes drops __GFP_ZERO from the flag, and adds a manual
memset after page/sg allocations, using the length of scatterlist.

My test result of a 2.5MB size allocation shows iommu_dma_alloc()
takes 46% less time, reduced from averagely 925 usec to 500 usec.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/iommu/dma-iommu.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d1b04753b204..e48d995e65c5 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -551,10 +551,13 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
+	struct scatterlist *s;
 	struct page **pages;
 	struct sg_table sgt;
 	dma_addr_t iova;
 	unsigned int count, min_size, alloc_sizes = domain->pgsize_bitmap;
+	bool gfp_zero = false;
+	int i;
 
 	*handle = IOMMU_MAPPING_ERROR;
 
@@ -568,6 +571,15 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 	if (attrs & DMA_ATTR_ALLOC_SINGLE_PAGES)
 		alloc_sizes = min_size;
 
+	/*
+	 * The generic zeroing in a length of one page size is slow,
+	 * so do it manually in a length of scatterlist size instead
+	 */
+	if (gfp & __GFP_ZERO) {
+		gfp &= ~__GFP_ZERO;
+		gfp_zero = true;
+	}
+
 	count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	pages = __iommu_dma_alloc_pages(count, alloc_sizes >> PAGE_SHIFT, gfp);
 	if (!pages)
@@ -581,6 +593,12 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 	if (sg_alloc_table_from_pages(&sgt, pages, count, 0, size, GFP_KERNEL))
 		goto out_free_iova;
 
+	if (gfp_zero) {
+		/* Now zero all the pages in the scatterlist */
+		for_each_sg(sgt.sgl, s, sgt.orig_nents, i)
+			memset(sg_virt(s), 0, s->length);
+	}
+
 	if (!(prot & IOMMU_CACHE)) {
 		struct sg_mapping_iter miter;
 		/*
-- 
2.17.1
