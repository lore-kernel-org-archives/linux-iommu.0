From: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 2/2] swiotlb: Fix dma_supported() to consider direct allocation
Date: Sun, 15 Apr 2018 11:08:08 +0200
Message-ID: <20180415090808.19121-3-tiwai@suse.de>
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

Along with the recent change to use the common swiotlb dma_ops, x86
also takes over the swiotlb_dma_supported().  This caused a regression
when a low bit DMA mask is set; e.g. parport_pc driver now fails to
set the 24bit DMA mask:

  parport_pc parport_pc.956: Unable to set coherent dma mask: disabling DMA

It's because swiotlb_dma_supported() only checks the swiotlb range,
and the 24bit DMA mask is below io_tlb_end.  OTOH, in the past kernel
versions, x86's swiotlb dma_supported() was NULL, which was
effectively evaluated as the direct DMA, hence the lower DMA mask was
allowed.

This patch fixes the regression by extending swiotlb_dma_supported()
to check the direct DMA at first for covering the primary allocation
before swiotlb.

Fixes: 6e4bf5867783 ("x86/dma: Use generic swiotlb_ops")
Signed-off-by: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
---
 lib/swiotlb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index de7cc540450f..a81502ea79e7 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -1042,6 +1042,10 @@ swiotlb_dma_mapping_error(struct device *hwdev, dma_addr_t dma_addr)
 int
 swiotlb_dma_supported(struct device *hwdev, u64 mask)
 {
+#ifdef CONFIG_DMA_DIRECT_OPS
+	if (dma_direct_supported(hwdev, mask))
+		return 1;
+#endif
 	return __phys_to_dma(hwdev, io_tlb_end - 1) <= mask;
 }
 
-- 
2.16.3
