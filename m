From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 17/23] iommu/amd: Allocate new aperture ranges in
	dma_ops_alloc_addresses
Date: Tue, 22 Dec 2015 23:21:22 +0100
Message-ID: <1450822888-22590-18-git-send-email-joro@8bytes.org>
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

It really belongs there and not in __map_single.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index c657e48..4c926da 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1597,13 +1597,19 @@ static unsigned long dma_ops_alloc_addresses(struct device *dev,
 					     unsigned long align_mask,
 					     u64 dma_mask)
 {
-	unsigned long address;
+	unsigned long address = -1;
 
 #ifdef CONFIG_IOMMU_STRESS
 	dom->next_index = 0;
 #endif
 
-	address = dma_ops_area_alloc(dev, dom, pages, align_mask, dma_mask);
+	while (address == -1) {
+		address = dma_ops_area_alloc(dev, dom, pages,
+					     align_mask, dma_mask);
+
+		if (address == -1 && alloc_new_range(dom, true, GFP_ATOMIC))
+			break;
+	}
 
 	if (unlikely(address == -1))
 		address = DMA_ERROR_CODE;
@@ -2460,26 +2466,11 @@ static dma_addr_t __map_single(struct device *dev,
 	if (align)
 		align_mask = (1UL << get_order(size)) - 1;
 
-retry:
 	address = dma_ops_alloc_addresses(dev, dma_dom, pages, align_mask,
 					  dma_mask);
-	if (unlikely(address == DMA_ERROR_CODE)) {
-		if (alloc_new_range(dma_dom, false, GFP_ATOMIC))
-			goto out;
-
-		/*
-		 * setting next_index here will let the address
-		 * allocator only scan the new allocated range in the
-		 * first run. This is a small optimization.
-		 */
-		dma_dom->next_index = dma_dom->aperture_size >> APERTURE_RANGE_SHIFT;
 
-		/*
-		 * aperture was successfully enlarged by 128 MB, try
-		 * allocation again
-		 */
-		goto retry;
-	}
+	if (address == DMA_ERROR_CODE)
+		goto out;
 
 	start = address;
 	for (i = 0; i < pages; ++i) {
-- 
1.9.1
