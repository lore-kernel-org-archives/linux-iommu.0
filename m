From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH] swiotlb: use dma_direct_supported for swiotlb_ops
Date: Mon,  9 Apr 2018 11:15:17 +0200
Message-ID: <20180409091517.6619-2-hch@lst.de>
References: <20180409091517.6619-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180409091517.6619-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

swiotlb_alloc calls dma_direct_alloc, which can satisfy lower than 32-bit
dma mask requests using GFP_DMA if the architecture supports it.  Various
x86 drivers rely on that, so we need to support that.  At the same time
the whole kernel expects 32-bit dma mask to just work, so the other magic
in swiotlb_dma_support isn't actually needed either.

Reported-by: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Fixes: 6e4bf5867783 ("x86/dma: Use generic swiotlb_ops")
Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 lib/swiotlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 47aeb04c1997..32aacd0d56a8 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -1087,6 +1087,6 @@ const struct dma_map_ops swiotlb_dma_ops = {
 	.unmap_sg		= swiotlb_unmap_sg_attrs,
 	.map_page		= swiotlb_map_page,
 	.unmap_page		= swiotlb_unmap_page,
-	.dma_supported		= swiotlb_dma_supported,
+	.dma_supported		= dma_direct_supported,
 };
 #endif /* CONFIG_DMA_DIRECT_OPS */
-- 
2.16.3
