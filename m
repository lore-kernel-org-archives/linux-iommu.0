From: Dongli Zhang <dongli.zhang-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/1] swiotlb: fix comment on swiotlb_bounce()
Date: Thu,  6 Dec 2018 12:17:56 +0800
Message-ID: <1544069876-21185-1-git-send-email-dongli.zhang@oracle.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: dongli.zhang-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Fix the comment as swiotlb_bounce() is used to copy from original dma
location to swiotlb buffer during swiotlb_tbl_map_single(), while to
copy from swiotlb buffer to original dma location during
swiotlb_tbl_unmap_single().

Signed-off-by: Dongli Zhang <dongli.zhang-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
---
 kernel/dma/swiotlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 045930e..0a5ec94 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -389,7 +389,7 @@ static int is_swiotlb_buffer(phys_addr_t paddr)
 }
 
 /*
- * Bounce: copy the swiotlb buffer back to the original dma location
+ * Bounce: copy the swiotlb buffer from or back to the original dma location
  */
 static void swiotlb_bounce(phys_addr_t orig_addr, phys_addr_t tlb_addr,
 			   size_t size, enum dma_data_direction dir)
-- 
2.7.4
