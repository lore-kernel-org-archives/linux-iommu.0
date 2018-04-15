From: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 1/2] dma-direct: Don't repeat allocation for no-op GFP_DMA
Date: Sun, 15 Apr 2018 11:08:07 +0200
Message-ID: <20180415090808.19121-2-tiwai@suse.de>
References: <20180415090808.19121-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180415090808.19121-1-tiwai-l3A5Bk7waGM@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

When an allocation with lower dma_coherent mask fails,
dma_direct_alloc() retries the allocation with GFP_DMA.  But, it's
useless for architectures that has no ZONE_DMA, obviously.

Fix it by adding the check of CONFIG_ZONE_DMA before retrying the
allocation.

Fixes: 95f183916d4b ("dma-direct: retry allocations using GFP_DMA for small masks")
Signed-off-by: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
---
 lib/dma-direct.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/dma-direct.c b/lib/dma-direct.c
index c0bba30fef0a..bbfb229aa067 100644
--- a/lib/dma-direct.c
+++ b/lib/dma-direct.c
@@ -84,7 +84,8 @@ void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		__free_pages(page, page_order);
 		page = NULL;
 
-		if (dev->coherent_dma_mask < DMA_BIT_MASK(32) &&
+		if (IS_ENABLED(CONFIG_ZONE_DMA) &&
+		    dev->coherent_dma_mask < DMA_BIT_MASK(32) &&
 		    !(gfp & GFP_DMA)) {
 			gfp = (gfp & ~GFP_DMA32) | GFP_DMA;
 			goto again;
-- 
2.16.3
