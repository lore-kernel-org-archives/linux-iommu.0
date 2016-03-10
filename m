From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 1/2] iommu/dma: Restore scatterlist offsets correctly
Date: Thu, 10 Mar 2016 19:28:12 +0000
Message-ID: <c14a93373a34633f6db89214ca2ddf69b0eaa1c3.1457637385.git.robin.murphy@arm.com>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

With the change to stashing just the IOVA-page-aligned remainder of the
CPU-page offset rather than the whole thing, the failure path in
__invalidate_sg() also needs tweaking to account for that in the case of
differing page sizes where the two offsets may not be equivalent.
Similarly in __finalise_sg(), lest the architecture-specific wrappers
later get the wrong address for cache maintenance on sync or unmap.

Fixes: 164afb1d85b8 ("iommu/dma: Use correct offset in map_sg")
Reported-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/dma-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 72d6182..58f2fe6 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -403,7 +403,7 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
 		unsigned int s_length = sg_dma_len(s);
 		unsigned int s_dma_len = s->length;
 
-		s->offset = s_offset;
+		s->offset += s_offset;
 		s->length = s_length;
 		sg_dma_address(s) = dma_addr + s_offset;
 		dma_addr += s_dma_len;
@@ -422,7 +422,7 @@ static void __invalidate_sg(struct scatterlist *sg, int nents)
 
 	for_each_sg(sg, s, nents, i) {
 		if (sg_dma_address(s) != DMA_ERROR_CODE)
-			s->offset = sg_dma_address(s);
+			s->offset += sg_dma_address(s);
 		if (sg_dma_len(s))
 			s->length = sg_dma_len(s);
 		sg_dma_address(s) = DMA_ERROR_CODE;
-- 
2.7.2.333.g70bd996.dirty
