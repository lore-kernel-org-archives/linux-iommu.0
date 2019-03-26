From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH RFC/RFT 4/5] arm64: dma-mapping: Add fallback normal page allocations
Date: Tue, 26 Mar 2019 15:49:58 -0700
Message-ID: <20190326224959.9656-5-nicoleotsuka@gmail.com>
References: <20190326224959.9656-1-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190326224959.9656-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hch@lst.de, robin.murphy@arm.com
Cc: vdumpa@nvidia.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, joro@8bytes.org, m.szyprowski@samsung.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, tony@atomide.com
List-Id: iommu@lists.linux-foundation.org

The cma allocation will skip allocations of single pages to save CMA
resource. This requires its callers to rebound those page allocations
from normal area. So this patch adds fallback routines.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 arch/arm64/mm/dma-mapping.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 78c0a72f822c..be2302533334 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -156,17 +156,20 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 		}
 	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
 		pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
+		unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 		struct page *page;
 
-		page = dma_alloc_from_contiguous(dev, size >> PAGE_SHIFT,
-					get_order(size), gfp & __GFP_NOWARN);
+		page = dma_alloc_from_contiguous(dev, count, get_order(size),
+						 gfp & __GFP_NOWARN);
+		if (!page)
+			page = alloc_pages(gfp, get_order(size));
 		if (!page)
 			return NULL;
 
 		*handle = iommu_dma_map_page(dev, page, 0, iosize, ioprot);
 		if (*handle == DMA_MAPPING_ERROR) {
-			dma_release_from_contiguous(dev, page,
-						    size >> PAGE_SHIFT);
+			if (!dma_release_from_contiguous(dev, page, count))
+				__free_pages(page, get_order(size));
 			return NULL;
 		}
 		addr = dma_common_contiguous_remap(page, size, VM_USERMAP,
@@ -178,8 +181,8 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 			memset(addr, 0, size);
 		} else {
 			iommu_dma_unmap_page(dev, *handle, iosize, 0, attrs);
-			dma_release_from_contiguous(dev, page,
-						    size >> PAGE_SHIFT);
+			if (!dma_release_from_contiguous(dev, page, count))
+				__free_pages(page, get_order(size));
 		}
 	} else {
 		pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
@@ -201,6 +204,7 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 static void __iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 			       dma_addr_t handle, unsigned long attrs)
 {
+	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	size_t iosize = size;
 
 	size = PAGE_ALIGN(size);
@@ -222,7 +226,8 @@ static void __iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 		struct page *page = vmalloc_to_page(cpu_addr);
 
 		iommu_dma_unmap_page(dev, handle, iosize, 0, attrs);
-		dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT);
+		if (!dma_release_from_contiguous(dev, page, count))
+			__free_pages(page, get_order(size));
 		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
 	} else if (is_vmalloc_addr(cpu_addr)){
 		struct vm_struct *area = find_vm_area(cpu_addr);
-- 
2.17.1
