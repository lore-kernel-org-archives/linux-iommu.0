From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 06/14] x86/amd_gart: use dma_direct_{alloc,free}
Date: Wed, 14 Mar 2018 18:52:05 +0100
Message-ID: <20180314175213.20256-7-hch@lst.de>
References: <20180314175213.20256-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180314175213.20256-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Muli Ben-Yehuda <mulix-BzGcCpaT2IbYtjvyW6yDsg@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This gains support for CMA allocations for the force_iommu case, and
cleans up the code a bit.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 arch/x86/kernel/amd_gart_64.c | 36 ++++++++++++++----------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index 79ac6caaaabb..f299d8a479bb 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -480,29 +480,21 @@ static void *
 gart_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_addr,
 		    gfp_t flag, unsigned long attrs)
 {
-	dma_addr_t paddr;
-	unsigned long align_mask;
-	struct page *page;
-
-	if (force_iommu && dev->coherent_dma_mask > DMA_BIT_MASK(24)) {
-		flag &= ~(__GFP_DMA | __GFP_HIGHMEM | __GFP_DMA32);
-		page = alloc_pages(flag | __GFP_ZERO, get_order(size));
-		if (!page)
-			return NULL;
-
-		align_mask = (1UL << get_order(size)) - 1;
-		paddr = dma_map_area(dev, page_to_phys(page), size,
-				     DMA_BIDIRECTIONAL, align_mask);
-
-		flush_gart();
-		if (paddr != bad_dma_addr) {
-			*dma_addr = paddr;
-			return page_address(page);
-		}
-		__free_pages(page, get_order(size));
-	} else
-		return dma_direct_alloc(dev, size, dma_addr, flag, attrs);
+	void *vaddr;
+
+	vaddr = dma_direct_alloc(dev, size, dma_addr, flag, attrs);
+	if (!vaddr ||
+	    !force_iommu || dev->coherent_dma_mask <= DMA_BIT_MASK(24))
+		return vaddr;
 
+	*dma_addr = dma_map_area(dev, virt_to_phys(vaddr), size,
+			DMA_BIDIRECTIONAL, (1UL << get_order(size)) - 1);
+	flush_gart();
+	if (unlikely(*dma_addr == bad_dma_addr))
+		goto out_free;
+	return vaddr;
+out_free:
+	dma_direct_free(dev, size, vaddr, *dma_addr, attrs);
 	return NULL;
 }
 
-- 
2.14.2
