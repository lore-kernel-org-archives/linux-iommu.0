From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 1/3] xtensa: remove partial support for DMA buffers in high
	memory
Date: Thu, 20 Sep 2018 19:15:38 +0200
Message-ID: <20180920171540.2657-2-hch@lst.de>
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

This reverts commit 6137e4166004e2ec383ac05d5ca15831f4668806.

We explicitly clear GFP_HIGHMEM from the allowed dma flags at the beginning
of the function (and the generic dma_alloc_attr function calling us does the
same!), so this code just adds dead wood.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 arch/xtensa/kernel/pci-dma.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/arch/xtensa/kernel/pci-dma.c b/arch/xtensa/kernel/pci-dma.c
index 1fc138b6bc0a..a764d894ffdd 100644
--- a/arch/xtensa/kernel/pci-dma.c
+++ b/arch/xtensa/kernel/pci-dma.c
@@ -171,20 +171,6 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 		return page;
 	}
 
-#ifdef CONFIG_MMU
-	if (PageHighMem(page)) {
-		void *p;
-
-		p = dma_common_contiguous_remap(page, size, VM_MAP,
-						pgprot_noncached(PAGE_KERNEL),
-						__builtin_return_address(0));
-		if (!p) {
-			if (!dma_release_from_contiguous(dev, page, count))
-				__free_pages(page, get_order(size));
-		}
-		return p;
-	}
-#endif
 	BUG_ON(!platform_vaddr_cached(page_address(page)));
 	__invalidate_dcache_range((unsigned long)page_address(page), size);
 	return platform_vaddr_to_uncached(page_address(page));
@@ -201,10 +187,8 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 	} else if (platform_vaddr_uncached(vaddr)) {
 		page = virt_to_page(platform_vaddr_to_cached(vaddr));
 	} else {
-#ifdef CONFIG_MMU
-		dma_common_free_remap(vaddr, size, VM_MAP);
-#endif
-		page = pfn_to_page(PHYS_PFN(dma_to_phys(dev, dma_handle)));
+		WARN_ON_ONCE(1);
+		return;
 	}
 
 	if (!dma_release_from_contiguous(dev, page, count))
-- 
2.18.0
