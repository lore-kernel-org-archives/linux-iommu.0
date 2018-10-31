From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH RFC] dma-direct: do not allocate a single page from CMA area
Date: Wed, 31 Oct 2018 13:03:55 -0700
Message-ID: <20181031200355.19945-1-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, vdumpa@nvidia.com
List-Id: iommu@lists.linux-foundation.org

The addresses within a single page are always contiguous, so it's
not so necessary to allocate one single page from CMA area. Since
the CMA area has a limited predefined size of space, it might run
out of space in some heavy use case, where there might be quite a
lot CMA pages being allocated for single pages.

This patch tries to skip CMA allocations of single pages and lets
them go through normal page allocations. This would save resource
in the CMA area for further more CMA allocations.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 kernel/dma/direct.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 22a12ab5a5e9..14c5d49eded2 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -120,8 +120,12 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	gfp |= __dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
 			&phys_mask);
 again:
-	/* CMA can be used only in the context which permits sleeping */
-	if (gfpflags_allow_blocking(gfp)) {
+	/*
+	 * CMA can be used only in the context which permits sleeping.
+	 * Since addresses within one PAGE are always contiguous, skip
+	 * CMA allocation for a single page to save CMA reserved space
+	 */
+	if (gfpflags_allow_blocking(gfp) && count > 1) {
 		page = dma_alloc_from_contiguous(dev, count, page_order,
 						 gfp & __GFP_NOWARN);
 		if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
-- 
2.17.1
