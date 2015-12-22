From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 07/23] iommu/amd: Add dma_ops_aperture_alloc() function
Date: Tue, 22 Dec 2015 23:21:12 +0100
Message-ID: <1450822888-22590-8-git-send-email-joro@8bytes.org>
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

Make this a wrapper around iommu_ops_area_alloc() for now
and add more logic to this function later on.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 1d1ef37..be0e81a 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1518,6 +1518,28 @@ out_free:
 	return -ENOMEM;
 }
 
+static dma_addr_t dma_ops_aperture_alloc(struct aperture_range *range,
+					 unsigned long pages,
+					 unsigned long next_bit,
+					 unsigned long dma_mask,
+					 unsigned long boundary_size,
+					 unsigned long align_mask)
+{
+	unsigned long offset, limit, flags;
+	dma_addr_t address;
+
+	offset = range->offset >> PAGE_SHIFT;
+	limit  = iommu_device_max_index(APERTURE_RANGE_PAGES, offset,
+					dma_mask >> PAGE_SHIFT);
+
+	spin_lock_irqsave(&range->bitmap_lock, flags);
+	address = iommu_area_alloc(range->bitmap, limit, next_bit, pages,
+				   offset, boundary_size, align_mask);
+	spin_unlock_irqrestore(&range->bitmap_lock, flags);
+
+	return address;
+}
+
 static unsigned long dma_ops_area_alloc(struct device *dev,
 					struct dma_ops_domain *dom,
 					unsigned int pages,
@@ -1530,8 +1552,6 @@ static unsigned long dma_ops_area_alloc(struct device *dev,
 	int i = start >> APERTURE_RANGE_SHIFT;
 	unsigned long boundary_size, mask;
 	unsigned long address = -1;
-	unsigned long limit;
-	unsigned long flags;
 
 	next_bit >>= PAGE_SHIFT;
 
@@ -1541,19 +1561,12 @@ static unsigned long dma_ops_area_alloc(struct device *dev,
 				   1UL << (BITS_PER_LONG - PAGE_SHIFT);
 
 	for (;i < max_index; ++i) {
-		unsigned long offset = dom->aperture[i]->offset >> PAGE_SHIFT;
-
 		if (dom->aperture[i]->offset >= dma_mask)
 			break;
 
-		limit = iommu_device_max_index(APERTURE_RANGE_PAGES, offset,
-					       dma_mask >> PAGE_SHIFT);
-
-		spin_lock_irqsave(&dom->aperture[i]->bitmap_lock, flags);
-		address = iommu_area_alloc(dom->aperture[i]->bitmap,
-					   limit, next_bit, pages, offset,
-					    boundary_size, align_mask);
-		spin_unlock_irqrestore(&dom->aperture[i]->bitmap_lock, flags);
+		address = dma_ops_aperture_alloc(dom->aperture[i], pages,
+						 next_bit, dma_mask,
+						 boundary_size, align_mask);
 		if (address != -1) {
 			address = dom->aperture[i]->offset +
 				  (address << PAGE_SHIFT);
-- 
1.9.1
