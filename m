From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 03/19] dma-iommu: don't use a scatterlist in iommu_dma_alloc
Date: Mon, 14 Jan 2019 10:41:43 +0100
Message-ID: <20190114094159.27326-4-hch@lst.de>
References: <20190114094159.27326-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114094159.27326-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Directly iterating over the pages makes the code a bit simpler and
prepares for the following changes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 40 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d19f3d6b43c1..4f5546a103d8 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -30,6 +30,7 @@
 #include <linux/mm.h>
 #include <linux/pci.h>
 #include <linux/scatterlist.h>
+#include <linux/highmem.h>
 #include <linux/vmalloc.h>
 
 struct iommu_dma_msi_page {
@@ -549,9 +550,9 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
 	struct page **pages;
-	struct sg_table sgt;
 	dma_addr_t iova;
-	unsigned int count, min_size, alloc_sizes = domain->pgsize_bitmap;
+	unsigned int count, min_size, alloc_sizes = domain->pgsize_bitmap, i;
+	size_t mapped = 0;
 
 	*handle = DMA_MAPPING_ERROR;
 
@@ -576,32 +577,25 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 	if (!iova)
 		goto out_free_pages;
 
-	if (sg_alloc_table_from_pages(&sgt, pages, count, 0, size, GFP_KERNEL))
-		goto out_free_iova;
+	for (i = 0; i < count; i++) {
+		phys_addr_t phys = page_to_phys(pages[i]);
 
-	if (!(prot & IOMMU_CACHE)) {
-		struct sg_mapping_iter miter;
-		/*
-		 * The CPU-centric flushing implied by SG_MITER_TO_SG isn't
-		 * sufficient here, so skip it by using the "wrong" direction.
-		 */
-		sg_miter_start(&miter, sgt.sgl, sgt.orig_nents, SG_MITER_FROM_SG);
-		while (sg_miter_next(&miter))
-			flush_page(dev, miter.addr, page_to_phys(miter.page));
-		sg_miter_stop(&miter);
-	}
+		if (!(prot & IOMMU_CACHE)) {
+			void *vaddr = kmap_atomic(pages[i]);
 
-	if (iommu_map_sg(domain, iova, sgt.sgl, sgt.orig_nents, prot)
-			< size)
-		goto out_free_sg;
+			flush_page(dev, vaddr, phys);
+			kunmap_atomic(vaddr);
+		}
+
+		if (iommu_map(domain, iova + mapped, phys, PAGE_SIZE, prot))
+			goto out_unmap;
+		mapped += PAGE_SIZE;
+	}
 
 	*handle = iova;
-	sg_free_table(&sgt);
 	return pages;
-
-out_free_sg:
-	sg_free_table(&sgt);
-out_free_iova:
+out_unmap:
+	iommu_unmap(domain, iova, mapped);
 	iommu_dma_free_iova(cookie, iova, size);
 out_free_pages:
 	__iommu_dma_free_pages(pages, count);
-- 
2.20.1
