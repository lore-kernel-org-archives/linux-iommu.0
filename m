From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 14/25] iommu/dma: Refactor iommu_dma_alloc
Date: Tue, 30 Apr 2019 06:52:03 -0400
Message-ID: <20190430105214.24628-15-hch@lst.de>
References: <20190430105214.24628-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190430105214.24628-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

From: Robin Murphy <robin.murphy@arm.com>

Shuffle around the self-contained atomic and non-contiguous cases to
return early and get out of the way of the CMA case that we're about to
work on next.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
[hch: slight changes to the code flow]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 60 +++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f5c0e8cd3387..26f2d059873b 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -954,14 +954,19 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 {
 	bool coherent = dev_is_dma_coherent(dev);
 	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
+	pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
 	size_t iosize = size;
+	struct page *page;
 	void *addr;
 
 	size = PAGE_ALIGN(size);
 	gfp |= __GFP_ZERO;
 
+	if (gfpflags_allow_blocking(gfp) &&
+	    !(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
+		return iommu_dma_alloc_remap(dev, iosize, handle, gfp, attrs);
+
 	if (!gfpflags_allow_blocking(gfp)) {
-		struct page *page;
 		/*
 		 * In atomic context we can't remap anything, so we'll only
 		 * get the virtually contiguous buffer we need by way of a
@@ -983,39 +988,34 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 				__free_pages(page, get_order(size));
 			else
 				dma_free_from_pool(addr, size);
-			addr = NULL;
-		}
-	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
-		pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
-		struct page *page;
-
-		page = dma_alloc_from_contiguous(dev, size >> PAGE_SHIFT,
-					get_order(size), gfp & __GFP_NOWARN);
-		if (!page)
 			return NULL;
-
-		*handle = __iommu_dma_map(dev, page_to_phys(page), iosize, ioprot);
-		if (*handle == DMA_MAPPING_ERROR) {
-			dma_release_from_contiguous(dev, page,
-						    size >> PAGE_SHIFT);
-			return NULL;
-		}
-		addr = dma_common_contiguous_remap(page, size, VM_USERMAP,
-						   prot,
-						   __builtin_return_address(0));
-		if (addr) {
-			if (!coherent)
-				arch_dma_prep_coherent(page, iosize);
-			memset(addr, 0, size);
-		} else {
-			__iommu_dma_unmap(dev, *handle, iosize);
-			dma_release_from_contiguous(dev, page,
-						    size >> PAGE_SHIFT);
 		}
-	} else {
-		addr = iommu_dma_alloc_remap(dev, iosize, handle, gfp, attrs);
+		return addr;
 	}
+
+	page = dma_alloc_from_contiguous(dev, size >> PAGE_SHIFT,
+					 get_order(size), gfp & __GFP_NOWARN);
+	if (!page)
+		return NULL;
+
+	*handle = __iommu_dma_map(dev, page_to_phys(page), iosize, ioprot);
+	if (*handle == DMA_MAPPING_ERROR)
+		goto out_free_pages;
+
+	addr = dma_common_contiguous_remap(page, size, VM_USERMAP, prot,
+			__builtin_return_address(0));
+	if (!addr)
+		goto out_unmap;
+
+	if (!coherent)
+		arch_dma_prep_coherent(page, iosize);
+	memset(addr, 0, size);
 	return addr;
+out_unmap:
+	__iommu_dma_unmap(dev, *handle, iosize);
+out_free_pages:
+	dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT);
+	return NULL;
 }
 
 static int __iommu_dma_mmap_pfn(struct vm_area_struct *vma,
-- 
2.20.1
