From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 03/23] iommu/amd: Introduce bitmap_lock in struct
	aperture_range
Date: Tue, 22 Dec 2015 23:21:08 +0100
Message-ID: <1450822888-22590-4-git-send-email-joro@8bytes.org>
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

This lock only protects the address allocation bitmap in one
aperture.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 9ce51eb..8ff3331 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -120,6 +120,8 @@ static int protection_domain_init(struct protection_domain *domain);
  */
 struct aperture_range {
 
+	spinlock_t bitmap_lock;
+
 	/* address allocation bitmap */
 	unsigned long *bitmap;
 
@@ -1436,6 +1438,8 @@ static int alloc_new_range(struct dma_ops_domain *dma_dom,
 
 	dma_dom->aperture[index]->offset = dma_dom->aperture_size;
 
+	spin_lock_init(&dma_dom->aperture[index]->bitmap_lock);
+
 	if (populate) {
 		unsigned long address = dma_dom->aperture_size;
 		int i, num_ptes = APERTURE_RANGE_PAGES / 512;
@@ -1527,6 +1531,7 @@ static unsigned long dma_ops_area_alloc(struct device *dev,
 	unsigned long boundary_size, mask;
 	unsigned long address = -1;
 	unsigned long limit;
+	unsigned long flags;
 
 	next_bit >>= PAGE_SHIFT;
 
@@ -1544,9 +1549,11 @@ static unsigned long dma_ops_area_alloc(struct device *dev,
 		limit = iommu_device_max_index(APERTURE_RANGE_PAGES, offset,
 					       dma_mask >> PAGE_SHIFT);
 
+		spin_lock_irqsave(&dom->aperture[i]->bitmap_lock, flags);
 		address = iommu_area_alloc(dom->aperture[i]->bitmap,
 					   limit, next_bit, pages, 0,
 					    boundary_size, align_mask);
+		spin_unlock_irqrestore(&dom->aperture[i]->bitmap_lock, flags);
 		if (address != -1) {
 			address = dom->aperture[i]->offset +
 				  (address << PAGE_SHIFT);
@@ -1602,6 +1609,7 @@ static void dma_ops_free_addresses(struct dma_ops_domain *dom,
 {
 	unsigned i = address >> APERTURE_RANGE_SHIFT;
 	struct aperture_range *range = dom->aperture[i];
+	unsigned long flags;
 
 	BUG_ON(i >= APERTURE_MAX_RANGES || range == NULL);
 
@@ -1615,7 +1623,9 @@ static void dma_ops_free_addresses(struct dma_ops_domain *dom,
 
 	address = (address % APERTURE_RANGE_SIZE) >> PAGE_SHIFT;
 
+	spin_lock_irqsave(&range->bitmap_lock, flags);
 	bitmap_clear(range->bitmap, address, pages);
+	spin_unlock_irqrestore(&range->bitmap_lock, flags);
 
 }
 
-- 
1.9.1
