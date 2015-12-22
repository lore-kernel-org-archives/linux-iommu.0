From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 14/23] iommu/amd: Iterate over all aperture ranges in
	dma_ops_area_alloc
Date: Tue, 22 Dec 2015 23:21:19 +0100
Message-ID: <1450822888-22590-15-git-send-email-joro@8bytes.org>
References: <1450822888-22590-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1450822888-22590-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

This way we don't need to care about the next_index wrapping
around in dma_ops_alloc_addresses.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 62a4079..faf51a0 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1563,35 +1563,36 @@ static unsigned long dma_ops_area_alloc(struct device *dev,
 					unsigned long align_mask,
 					u64 dma_mask)
 {
-	int max_index = dom->aperture_size >> APERTURE_RANGE_SHIFT;
 	unsigned long next_bit, boundary_size, mask;
 	unsigned long address = -1;
-	int i = dom->next_index;
+	int start = dom->next_index;
+	int i;
 
 	mask = dma_get_seg_boundary(dev);
 
 	boundary_size = mask + 1 ? ALIGN(mask + 1, PAGE_SIZE) >> PAGE_SHIFT :
 				   1UL << (BITS_PER_LONG - PAGE_SHIFT);
 
-	for (;i < max_index; ++i) {
-		struct aperture_range *range = dom->aperture[i];
+	for (i = 0; i < APERTURE_MAX_RANGES; ++i) {
+		struct aperture_range *range;
+
+		range = dom->aperture[(start + i) % APERTURE_MAX_RANGES];
 
-		if (range->offset >= dma_mask)
-			break;
+		if (!range || range->offset >= dma_mask)
+			continue;
 
 		next_bit  = range->next_bit;
 
-		address = dma_ops_aperture_alloc(dom, dom->aperture[i], pages,
+		address = dma_ops_aperture_alloc(dom, range, pages,
 						 dma_mask, boundary_size,
 						 align_mask);
 		if (address != -1) {
-			address = dom->aperture[i]->offset +
-				  (address << PAGE_SHIFT);
+			address = range->offset + (address << PAGE_SHIFT);
 			dom->next_index = i;
 			break;
 		}
 
-		if (next_bit > dom->aperture[i]->next_bit)
+		if (next_bit > range->next_bit)
 			dom->need_flush = true;
 	}
 
@@ -1613,13 +1614,6 @@ static unsigned long dma_ops_alloc_addresses(struct device *dev,
 
 	address = dma_ops_area_alloc(dev, dom, pages, align_mask, dma_mask);
 
-	if (address == -1) {
-		dom->next_index = 0;
-		address = dma_ops_area_alloc(dev, dom, pages, align_mask,
-					     dma_mask);
-		dom->need_flush = true;
-	}
-
 	if (unlikely(address == -1))
 		address = DMA_ERROR_CODE;
 
-- 
1.9.1
