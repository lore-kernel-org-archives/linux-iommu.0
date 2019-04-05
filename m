From: Dongli Zhang <dongli.zhang-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/1] swiotlb: dump used and total slots when swiotlb buffer is
	full
Date: Fri,  5 Apr 2019 09:15:25 +0800
Message-ID: <1554426925-2431-1-git-send-email-dongli.zhang@oracle.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, dongli.zhang-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, joe.jin-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srinivas.eeda-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

So far the kernel only prints the requested size if swiotlb buffer if full.
It is not possible to know whether it is simply an out of buffer, or it is
because swiotlb cannot allocate buffer with the requested size due to
fragmentation.

As 'io_tlb_used' is available since commit 71602fe6d4e9 ("swiotlb: add
debugfs to track swiotlb buffer usage"), both 'io_tlb_used' and
'io_tlb_nslabs' are printed when swiotlb buffer is full.

Signed-off-by: Dongli Zhang <dongli.zhang-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
---
 kernel/dma/swiotlb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 53012db..3f43b37 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -540,7 +540,8 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 not_found:
 	spin_unlock_irqrestore(&io_tlb_lock, flags);
 	if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
-		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes)\n", size);
+		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes), total %lu, used %lu\n",
+			 size, io_tlb_nslabs, io_tlb_used);
 	return DMA_MAPPING_ERROR;
 found:
 	io_tlb_used += nslots;
-- 
2.7.4
