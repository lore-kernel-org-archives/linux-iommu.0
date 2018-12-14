From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH] nios2: use dma_direct_alloc_pages
Date: Fri, 14 Dec 2018 13:10:15 +0100
Message-ID: <20181214121015.26720-1-hch@lst.de>
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
To: lftan-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org
Cc: nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Use the generic dma allocator to get various quirks and support
for CMA allocations (if enabled) for free.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 arch/nios2/mm/dma-mapping.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/arch/nios2/mm/dma-mapping.c b/arch/nios2/mm/dma-mapping.c
index 4af9e5b5ba1c..5ecd21555495 100644
--- a/arch/nios2/mm/dma-mapping.c
+++ b/arch/nios2/mm/dma-mapping.c
@@ -65,15 +65,8 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 {
 	void *ret;
 
-	/* optimized page clearing */
-	gfp |= __GFP_ZERO;
-
-	if (dev == NULL || (dev->coherent_dma_mask < 0xffffffff))
-		gfp |= GFP_DMA;
-
-	ret = (void *) __get_free_pages(gfp, get_order(size));
-	if (ret != NULL) {
-		*dma_handle = virt_to_phys(ret);
+	ret = dma_direct_alloc_pages(dev, size, dma_handle, gfp, attrs);
+	if (ret) {
 		flush_dcache_range((unsigned long) ret,
 			(unsigned long) ret + size);
 		ret = UNCAC_ADDR(ret);
@@ -81,11 +74,11 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 
 	return ret;
 }
+}
 
 void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 		dma_addr_t dma_handle, unsigned long attrs)
 {
-	unsigned long addr = (unsigned long) CAC_ADDR((unsigned long) vaddr);
-
-	free_pages(addr, get_order(size));
+	vaddr = (void *)CAC_ADDR((unsigned long)cpu_addr);
+	dma_direct_free_pages(dev, size, vaddr, dma_handle, attrs);
 }
-- 
2.19.2
