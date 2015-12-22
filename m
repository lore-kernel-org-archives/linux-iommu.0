From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 12/23] iommu/amd: Rename dma_ops_domain->next_address to
	next_index
Date: Tue, 22 Dec 2015 23:21:17 +0100
Message-ID: <1450822888-22590-13-git-send-email-joro@8bytes.org>
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

It points to the next aperture index to allocate from. We
don't need the full address anymore because this is now
tracked in struct aperture_range.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 2962c62..a26cd76 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -146,8 +146,8 @@ struct dma_ops_domain {
 	/* size of the aperture for the mappings */
 	unsigned long aperture_size;
 
-	/* address we start to search for free addresses */
-	unsigned long next_address;
+	/* aperture index we start searching for free addresses */
+	unsigned long next_index;
 
 	/* address space relevant data */
 	struct aperture_range *aperture[APERTURE_MAX_RANGES];
@@ -1564,9 +1564,9 @@ static unsigned long dma_ops_area_alloc(struct device *dev,
 					u64 dma_mask)
 {
 	int max_index = dom->aperture_size >> APERTURE_RANGE_SHIFT;
-	int i = dom->next_address >> APERTURE_RANGE_SHIFT;
 	unsigned long next_bit, boundary_size, mask;
 	unsigned long address = -1;
+	int i = dom->next_index;
 
 	mask = dma_get_seg_boundary(dev);
 
@@ -1587,7 +1587,7 @@ static unsigned long dma_ops_area_alloc(struct device *dev,
 		if (address != -1) {
 			address = dom->aperture[i]->offset +
 				  (address << PAGE_SHIFT);
-			dom->next_address = address + (pages << PAGE_SHIFT);
+			dom->next_index = i;
 			break;
 		}
 
@@ -1607,14 +1607,14 @@ static unsigned long dma_ops_alloc_addresses(struct device *dev,
 	unsigned long address;
 
 #ifdef CONFIG_IOMMU_STRESS
-	dom->next_address = 0;
+	dom->next_index = 0;
 	dom->need_flush = true;
 #endif
 
 	address = dma_ops_area_alloc(dev, dom, pages, align_mask, dma_mask);
 
 	if (address == -1) {
-		dom->next_address = 0;
+		dom->next_index = 0;
 		address = dma_ops_area_alloc(dev, dom, pages, align_mask,
 					     dma_mask);
 		dom->need_flush = true;
@@ -1648,7 +1648,7 @@ static void dma_ops_free_addresses(struct dma_ops_domain *dom,
 		return;
 #endif
 
-	if (address >= dom->next_address)
+	if ((address >> APERTURE_RANGE_SHIFT) >= dom->next_index)
 		dom->need_flush = true;
 
 	address = (address % APERTURE_RANGE_SIZE) >> PAGE_SHIFT;
@@ -1884,7 +1884,7 @@ static struct dma_ops_domain *dma_ops_domain_alloc(void)
 	 * a valid dma-address. So we can use 0 as error value
 	 */
 	dma_dom->aperture[0]->bitmap[0] = 1;
-	dma_dom->next_address = 0;
+	dma_dom->next_index = 0;
 
 
 	return dma_dom;
@@ -2477,15 +2477,15 @@ retry:
 	address = dma_ops_alloc_addresses(dev, dma_dom, pages, align_mask,
 					  dma_mask);
 	if (unlikely(address == DMA_ERROR_CODE)) {
+		if (alloc_new_range(dma_dom, false, GFP_ATOMIC))
+			goto out;
+
 		/*
-		 * setting next_address here will let the address
+		 * setting next_index here will let the address
 		 * allocator only scan the new allocated range in the
 		 * first run. This is a small optimization.
 		 */
-		dma_dom->next_address = dma_dom->aperture_size;
-
-		if (alloc_new_range(dma_dom, false, GFP_ATOMIC))
-			goto out;
+		dma_dom->next_index = dma_dom->aperture_size >> APERTURE_RANGE_SHIFT;
 
 		/*
 		 * aperture was successfully enlarged by 128 MB, try
-- 
1.9.1
