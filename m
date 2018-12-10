From: Dongli Zhang <dongli.zhang-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 2/2] swiotlb: checking whether swiotlb buffer is full with
	io_tlb_used
Date: Mon, 10 Dec 2018 08:37:58 +0800
Message-ID: <1544402278-8175-2-git-send-email-dongli.zhang@oracle.com>
References: <1544402278-8175-1-git-send-email-dongli.zhang@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1544402278-8175-1-git-send-email-dongli.zhang-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
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
Cc: konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, dongli.zhang-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, joe.jin-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch uses io_tlb_used to help check whether swiotlb buffer is full.
io_tlb_used is no longer used for only debugfs. It is also used to help
optimize swiotlb_tbl_map_single().

Suggested-by: Joe Jin <joe.jin-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Dongli Zhang <dongli.zhang-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
---
 kernel/dma/swiotlb.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 3979c2c..9300341 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -76,12 +76,10 @@ static phys_addr_t io_tlb_start, io_tlb_end;
  */
 static unsigned long io_tlb_nslabs;
 
-#ifdef CONFIG_DEBUG_FS
 /*
  * The number of used IO TLB block
  */
 static unsigned long io_tlb_used;
-#endif
 
 /*
  * This is a free list describing the number of free entries available from
@@ -489,6 +487,10 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 	 * request and allocate a buffer from that IO TLB pool.
 	 */
 	spin_lock_irqsave(&io_tlb_lock, flags);
+
+	if (unlikely(nslots > io_tlb_nslabs - io_tlb_used))
+		goto not_found;
+
 	index = ALIGN(io_tlb_index, stride);
 	if (index >= io_tlb_nslabs)
 		index = 0;
@@ -538,9 +540,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes)\n", size);
 	return SWIOTLB_MAP_ERROR;
 found:
-#ifdef CONFIG_DEBUG_FS
 	io_tlb_used += nslots;
-#endif
 	spin_unlock_irqrestore(&io_tlb_lock, flags);
 
 	/*
@@ -602,9 +602,7 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 		for (i = index - 1; (OFFSET(i, IO_TLB_SEGSIZE) != IO_TLB_SEGSIZE -1) && io_tlb_list[i]; i--)
 			io_tlb_list[i] = ++count;
 
-#ifdef CONFIG_DEBUG_FS
 		io_tlb_used -= nslots;
-#endif
 	}
 	spin_unlock_irqrestore(&io_tlb_lock, flags);
 }
-- 
2.7.4
