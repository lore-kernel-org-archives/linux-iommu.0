From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH v2] dma-direct: do not allocate a single page from CMA area
Date: Tue, 15 Jan 2019 13:51:40 -0800
Message-ID: <20190115215140.1545-1-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com
Cc: vdumpa@nvidia.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

The addresses within a single page are always contiguous, so it's
not so necessary to allocate one single page from CMA area. Since
the CMA area has a limited predefined size of space, it might run
out of space in some heavy use case, where there might be quite a
lot CMA pages being allocated for single pages.

This patch tries to skip CMA allocations of single pages and lets
them go through normal page allocations unless the allocation has
a DMA_ATTR_FORCE_CONTIGUOUS attribute. This'd save some resources
in the CMA area for further more CMA allocations, and it can also
reduce CMA fragmentations resulted from trivial allocations.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Robin/Christoph,

I have some personal priority to submit this patch. I understand
you might have other plan to clean up the code first. Just would
it be possible for you to review and apply this one if it doesn't
conflict too much? Thanks!

Changelog
v1->v2:
 * Added DMA_ATTR_FORCE_CONTIGUOUS flag check so as to enforce
   CMA allocations if callers specified.
 * Added to the commit message the reduction of fragmentations
   suggested by Robin.

 kernel/dma/direct.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 355d16acee6d..5d57f99b2edf 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -109,8 +109,14 @@ struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 	gfp |= __dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
 			&phys_mask);
 again:
-	/* CMA can be used only in the context which permits sleeping */
-	if (gfpflags_allow_blocking(gfp)) {
+	/*
+	 * CMA can be used only in the context which permits sleeping.
+	 * Since addresses within one PAGE are always contiguous, skip
+	 * CMA allocation for a single page to save CMA reserved space
+	 * unless DMA_ATTR_FORCE_CONTIGUOUS is flagged.
+	 */
+	if (gfpflags_allow_blocking(gfp) &&
+	    (count > 1 || attrs & DMA_ATTR_FORCE_CONTIGUOUS)) {
 		page = dma_alloc_from_contiguous(dev, count, page_order,
 						 gfp & __GFP_NOWARN);
 		if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
-- 
2.17.1
