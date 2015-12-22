From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 09/23] iommu/amd: Retry address allocation within one aperture
Date: Tue, 22 Dec 2015 23:21:14 +0100
Message-ID: <1450822888-22590-10-git-send-email-joro@8bytes.org>
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

Instead of skipping to the next aperture, first try again in
the current one.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 2a22515..58d7d82 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -125,6 +125,7 @@ struct aperture_range {
 	/* address allocation bitmap */
 	unsigned long *bitmap;
 	unsigned long offset;
+	unsigned long next_bit;
 
 	/*
 	 * Array of PTE pages for the aperture. In this array we save all the
@@ -1519,7 +1520,6 @@ out_free:
 
 static dma_addr_t dma_ops_aperture_alloc(struct aperture_range *range,
 					 unsigned long pages,
-					 unsigned long next_bit,
 					 unsigned long dma_mask,
 					 unsigned long boundary_size,
 					 unsigned long align_mask)
@@ -1532,8 +1532,17 @@ static dma_addr_t dma_ops_aperture_alloc(struct aperture_range *range,
 					dma_mask >> PAGE_SHIFT);
 
 	spin_lock_irqsave(&range->bitmap_lock, flags);
-	address = iommu_area_alloc(range->bitmap, limit, next_bit, pages,
-				   offset, boundary_size, align_mask);
+	address = iommu_area_alloc(range->bitmap, limit, range->next_bit,
+				   pages, offset, boundary_size, align_mask);
+	if (address == -1)
+		/* Nothing found, retry one time */
+		address = iommu_area_alloc(range->bitmap, limit,
+					   0, pages, offset, boundary_size,
+					   align_mask);
+
+	if (address != -1)
+		range->next_bit = address + pages;
+
 	spin_unlock_irqrestore(&range->bitmap_lock, flags);
 
 	return address;
@@ -1546,14 +1555,11 @@ static unsigned long dma_ops_area_alloc(struct device *dev,
 					u64 dma_mask,
 					unsigned long start)
 {
-	unsigned long next_bit = dom->next_address % APERTURE_RANGE_SIZE;
 	int max_index = dom->aperture_size >> APERTURE_RANGE_SHIFT;
 	int i = start >> APERTURE_RANGE_SHIFT;
-	unsigned long boundary_size, mask;
+	unsigned long next_bit, boundary_size, mask;
 	unsigned long address = -1;
 
-	next_bit >>= PAGE_SHIFT;
-
 	mask = dma_get_seg_boundary(dev);
 
 	boundary_size = mask + 1 ? ALIGN(mask + 1, PAGE_SIZE) >> PAGE_SHIFT :
@@ -1563,9 +1569,11 @@ static unsigned long dma_ops_area_alloc(struct device *dev,
 		if (dom->aperture[i]->offset >= dma_mask)
 			break;
 
+		next_bit = dom->aperture[i]->next_bit;
+
 		address = dma_ops_aperture_alloc(dom->aperture[i], pages,
-						 next_bit, dma_mask,
-						 boundary_size, align_mask);
+						 dma_mask, boundary_size,
+						 align_mask);
 		if (address != -1) {
 			address = dom->aperture[i]->offset +
 				  (address << PAGE_SHIFT);
@@ -1573,7 +1581,8 @@ static unsigned long dma_ops_area_alloc(struct device *dev,
 			break;
 		}
 
-		next_bit = 0;
+		if (next_bit > dom->aperture[i]->next_bit)
+			dom->need_flush = true;
 	}
 
 	return address;
-- 
1.9.1
