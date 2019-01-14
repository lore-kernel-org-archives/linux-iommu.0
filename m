From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH] swiotlb: clear io_tlb_start and io_tlb_end in swiotlb_exit
Date: Mon, 14 Jan 2019 21:14:08 +0100
Message-ID: <20190114201408.12270-1-hch@lst.de>
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
To: konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org
Cc: Sibren Vasse <sibren-DLwv2wemLo05ZU0pBKPMFg@public.gmane.org>, michel-otUistvHUpPR7s880joybQ@public.gmane.org, freedesktop-DLwv2wemLo05ZU0pBKPMFg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Otherwise is_swiotlb_buffer will return false positives when
we first initialize a swiotlb buffer, but then free it because
we have an IOMMU available.

Fixes: 55897af63091 ("dma-direct: merge swiotlb_dma_ops into the dma_direct code")
Reported-by: Sibren Vasse <sibren-DLwv2wemLo05ZU0pBKPMFg@public.gmane.org>
Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Tested-by: Sibren Vasse <sibren-DLwv2wemLo05ZU0pBKPMFg@public.gmane.org>
---
 kernel/dma/swiotlb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index d6361776dc5c..1fb6fd68b9c7 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -378,6 +378,8 @@ void __init swiotlb_exit(void)
 		memblock_free_late(io_tlb_start,
 				   PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT));
 	}
+	io_tlb_start = 0;
+	io_tlb_end = 0;
 	io_tlb_nslabs = 0;
 	max_segment = 0;
 }
-- 
2.20.1
