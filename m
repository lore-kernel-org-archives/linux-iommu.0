From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 2/3] nds32: implement the unmap_sg DMA operation
Date: Tue, 29 May 2018 11:48:13 +0200
Message-ID: <20180529094814.17644-3-hch@lst.de>
References: <20180529094814.17644-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180529094814.17644-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This matches the implementation of the more commonly used unmap_single
routines and the sync_sg_for_cpu method which should provide equivalent
cache maintainance.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 arch/nds32/kernel/dma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/nds32/kernel/dma.c b/arch/nds32/kernel/dma.c
index e0c94a2889c5..b9973317c734 100644
--- a/arch/nds32/kernel/dma.c
+++ b/arch/nds32/kernel/dma.c
@@ -458,6 +458,12 @@ static void nds32_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 			       int nhwentries, enum dma_data_direction dir,
 			       unsigned long attrs)
 {
+	int i;
+
+	for (i = 0; i < nhwentries; i++, sg++) {
+		nds32_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
+				sg->length, dir);
+	}
 }
 
 struct dma_map_ops nds32_dma_ops = {
-- 
2.17.0
