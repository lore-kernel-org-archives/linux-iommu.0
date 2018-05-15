From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 1/6] swiotlb: remove a pointless comment
Date: Tue, 15 May 2018 20:05:18 +0200
Message-ID: <20180515180523.3038-2-hch@lst.de>
References: <20180515180523.3038-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180515180523.3038-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This comments describes an aspect of the map_sg interface that isn't
even exploited by swiotlb.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 lib/swiotlb.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 16ace0e25d52..721f93677eee 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -927,12 +927,6 @@ swiotlb_sync_single_for_device(struct device *hwdev, dma_addr_t dev_addr,
  * appropriate dma address and length.  They are obtained via
  * sg_dma_{address,length}(SG).
  *
- * NOTE: An implementation may be able to use a smaller number of
- *       DMA address/length pairs than there are SG table elements.
- *       (for example via virtual mapping capabilities)
- *       The routine returns the number of addr/length pairs actually
- *       used, at most nents.
- *
  * Device ownership issues as mentioned above for swiotlb_map_page are the
  * same here.
  */
-- 
2.17.0
