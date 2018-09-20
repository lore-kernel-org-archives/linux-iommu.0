From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 3/3] xtensa: use dma_direct_{alloc,free}_pages
Date: Thu, 20 Sep 2018 19:15:40 +0200
Message-ID: <20180920171540.2657-4-hch@lst.de>
References: <20180920171540.2657-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180920171540.2657-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>, Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Use the generic helpers for dma allocation instead of opencoding them
with slightly less bells and whistles.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 arch/xtensa/kernel/pci-dma.c | 48 ++++++++++--------------------------
 1 file changed, 13 insertions(+), 35 deletions(-)

diff --git a/arch/xtensa/kernel/pci-dma.c b/arch/xtensa/kernel/pci-dma.c
index a764d894ffdd..a74ca0dd728a 100644
--- a/arch/xtensa/kernel/pci-dma.c
+++ b/arch/xtensa/kernel/pci-dma.c
@@ -141,56 +141,34 @@ void __attribute__((weak)) *platform_vaddr_to_cached(void *p)
  * Note: We assume that the full memory space is always mapped to 'kseg'
  *	 Otherwise we have to use page attributes (not implemented).
  */
-
-void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
-		gfp_t flag, unsigned long attrs)
+void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
+		gfp_t gfp, unsigned long attrs)
 {
-	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	struct page *page = NULL;
-
-	/* ignore region speicifiers */
-
-	flag &= ~(__GFP_DMA | __GFP_HIGHMEM);
-
-	if (dev == NULL || (dev->coherent_dma_mask < 0xffffffff))
-		flag |= GFP_DMA;
-
-	if (gfpflags_allow_blocking(flag))
-		page = dma_alloc_from_contiguous(dev, count, get_order(size),
-						 flag & __GFP_NOWARN);
+	void *vaddr;
 
-	if (!page)
-		page = alloc_pages(flag, get_order(size));
-
-	if (!page)
+	vaddr = dma_direct_alloc_pages(dev, size, dma_handle, gfp, attrs);
+	if (!vaddr)
 		return NULL;
 
-	*handle = phys_to_dma(dev, page_to_phys(page));
+	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING)
+		return virt_to_page(vaddr); /* just a random cookie */
 
-	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING) {
-		return page;
-	}
-
-	BUG_ON(!platform_vaddr_cached(page_address(page)));
-	__invalidate_dcache_range((unsigned long)page_address(page), size);
-	return platform_vaddr_to_uncached(page_address(page));
+	BUG_ON(!platform_vaddr_cached(vaddr));
+	__invalidate_dcache_range((unsigned long)vaddr, size);
+	return platform_vaddr_to_uncached(vaddr);
 }
 
 void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 		dma_addr_t dma_handle, unsigned long attrs)
 {
-	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	struct page *page;
-
 	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING) {
-		page = vaddr;
+		vaddr = page_to_virt((struct page *)vaddr); /* decode cookie */
 	} else if (platform_vaddr_uncached(vaddr)) {
-		page = virt_to_page(platform_vaddr_to_cached(vaddr));
+		vaddr = platform_vaddr_to_cached(vaddr);
 	} else {
 		WARN_ON_ONCE(1);
 		return;
 	}
 
-	if (!dma_release_from_contiguous(dev, page, count))
-		__free_pages(page, get_order(size));
+	dma_direct_free_pages(dev, size, vaddr, dma_handle, attrs);
 }
-- 
2.18.0
