From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 10/23] iommu/amd: Flush iommu tlb in dma_ops_aperture_alloc()
Date: Tue, 22 Dec 2015 23:21:15 +0100
Message-ID: <1450822888-22590-11-git-send-email-joro@8bytes.org>
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

Since the allocator wraparound happens in this function now,
flush the iommu tlb there too.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 58d7d82..eb11996 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1518,7 +1518,8 @@ out_free:
 	return -ENOMEM;
 }
 
-static dma_addr_t dma_ops_aperture_alloc(struct aperture_range *range,
+static dma_addr_t dma_ops_aperture_alloc(struct dma_ops_domain *dom,
+					 struct aperture_range *range,
 					 unsigned long pages,
 					 unsigned long dma_mask,
 					 unsigned long boundary_size,
@@ -1526,6 +1527,7 @@ static dma_addr_t dma_ops_aperture_alloc(struct aperture_range *range,
 {
 	unsigned long offset, limit, flags;
 	dma_addr_t address;
+	bool flush = false;
 
 	offset = range->offset >> PAGE_SHIFT;
 	limit  = iommu_device_max_index(APERTURE_RANGE_PAGES, offset,
@@ -1534,17 +1536,24 @@ static dma_addr_t dma_ops_aperture_alloc(struct aperture_range *range,
 	spin_lock_irqsave(&range->bitmap_lock, flags);
 	address = iommu_area_alloc(range->bitmap, limit, range->next_bit,
 				   pages, offset, boundary_size, align_mask);
-	if (address == -1)
+	if (address == -1) {
 		/* Nothing found, retry one time */
 		address = iommu_area_alloc(range->bitmap, limit,
 					   0, pages, offset, boundary_size,
 					   align_mask);
+		flush = true;
+	}
 
 	if (address != -1)
 		range->next_bit = address + pages;
 
 	spin_unlock_irqrestore(&range->bitmap_lock, flags);
 
+	if (flush) {
+		domain_flush_tlb(&dom->domain);
+		domain_flush_complete(&dom->domain);
+	}
+
 	return address;
 }
 
@@ -1566,12 +1575,14 @@ static unsigned long dma_ops_area_alloc(struct device *dev,
 				   1UL << (BITS_PER_LONG - PAGE_SHIFT);
 
 	for (;i < max_index; ++i) {
-		if (dom->aperture[i]->offset >= dma_mask)
+		struct aperture_range *range = dom->aperture[i];
+
+		if (range->offset >= dma_mask)
 			break;
 
-		next_bit = dom->aperture[i]->next_bit;
+		next_bit  = range->next_bit;
 
-		address = dma_ops_aperture_alloc(dom->aperture[i], pages,
+		address = dma_ops_aperture_alloc(dom, dom->aperture[i], pages,
 						 dma_mask, boundary_size,
 						 align_mask);
 		if (address != -1) {
-- 
1.9.1
