From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v2 2/2] arm64: Add support for DMA_ATTR_FORCE_CONTIGUOUS to
	IOMMU
Date: Fri, 27 Jan 2017 16:34:19 +0100
Message-ID: <1485531259-17513-3-git-send-email-geert+renesas@glider.be>
References: <1485531259-17513-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1485531259-17513-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Add support for allocation physically contiguous DMA buffers on arm64
systems with an IOMMU, by dispatching DMA buffer allocations with the
DMA_ATTR_FORCE_CONTIGUOUS attribute to the appropriate IOMMU DMA
helpers.

Note that as this uses the CMA allocator, setting this attribute has a
runtime-dependency on CONFIG_DMA_CMA, just like on arm32.

For arm64 systems using swiotlb, no changes are needed to support the
allocation of physically contiguous DMA buffers:
  - swiotlb always uses physically contiguous buffers (up to
    IO_TLB_SEGSIZE = 128 pages),
  - arm64's __dma_alloc_coherent() already calls
    dma_alloc_from_contiguous() when CMA is available.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
v2:
  - New, handle dispatching in the arch (arm64) code, as requested by
    Robin Murphy.
---
 arch/arm64/mm/dma-mapping.c | 51 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 1d7d5d2881db7c19..325803e0ba79ef26 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -577,20 +577,7 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 	 */
 	gfp |= __GFP_ZERO;
 
-	if (gfpflags_allow_blocking(gfp)) {
-		struct page **pages;
-		pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL, coherent);
-
-		pages = iommu_dma_alloc(dev, iosize, gfp, attrs, ioprot,
-					handle, flush_page);
-		if (!pages)
-			return NULL;
-
-		addr = dma_common_pages_remap(pages, size, VM_USERMAP, prot,
-					      __builtin_return_address(0));
-		if (!addr)
-			iommu_dma_free(dev, pages, iosize, handle);
-	} else {
+	if (!gfpflags_allow_blocking(gfp)) {
 		struct page *page;
 		/*
 		 * In atomic context we can't remap anything, so we'll only
@@ -614,6 +601,35 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 				__free_from_pool(addr, size);
 			addr = NULL;
 		}
+	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
+		pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL, coherent);
+		struct page *page;
+
+		page = iommu_dma_alloc_contiguous(dev, iosize, ioprot, handle);
+		if (!page)
+			return NULL;
+
+		if (!coherent)
+			__dma_flush_area(page_to_virt(page), iosize);
+
+		addr = dma_common_contiguous_remap(page, size, VM_USERMAP,
+						   prot,
+						   __builtin_return_address(0));
+		if (!addr)
+			iommu_dma_free_contiguous(dev, page, iosize, handle);
+	} else {
+		pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL, coherent);
+		struct page **pages;
+
+		pages = iommu_dma_alloc(dev, iosize, gfp, attrs, ioprot,
+					handle, flush_page);
+		if (!pages)
+			return NULL;
+
+		addr = dma_common_pages_remap(pages, size, VM_USERMAP, prot,
+					      __builtin_return_address(0));
+		if (!addr)
+			iommu_dma_free(dev, pages, iosize, handle);
 	}
 	return addr;
 }
@@ -626,6 +642,8 @@ static void __iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 	size = PAGE_ALIGN(size);
 	/*
 	 * @cpu_addr will be one of 3 things depending on how it was allocated:
+	 * - A remapped array of pages from iommu_dma_alloc_contiguous()
+	 *   for contiguous allocations.
 	 * - A remapped array of pages from iommu_dma_alloc(), for all
 	 *   non-atomic allocations.
 	 * - A non-cacheable alias from the atomic pool, for atomic
@@ -637,6 +655,11 @@ static void __iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 	if (__in_atomic_pool(cpu_addr, size)) {
 		iommu_dma_unmap_page(dev, handle, iosize, 0, 0);
 		__free_from_pool(cpu_addr, size);
+	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
+		struct page *page = phys_to_page(dma_to_phys(dev, handle));
+
+		iommu_dma_free_contiguous(dev, page, iosize, &handle);
+		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
 	} else if (is_vmalloc_addr(cpu_addr)){
 		struct vm_struct *area = find_vm_area(cpu_addr);
 
-- 
1.9.1
