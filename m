From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 1/3] intel-iommu: clean up iommu_no_mapping
Date: Wed, 10 Apr 2019 18:14:06 +0200
Message-ID: <20190410161408.7119-2-hch@lst.de>
References: <20190410161408.7119-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190410161408.7119-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Invert the return value to avoid double negatives, use a bool
instead of int as the return value, and reduce some indentation
after early returns.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 47 +++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 28cb713d728c..121a0cb450df 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3606,45 +3606,40 @@ struct dmar_domain *get_valid_domain_for_dev(struct device *dev)
 }
 
 /* Check if the dev needs to go through non-identity map and unmap process.*/
-static int iommu_no_mapping(struct device *dev)
+static bool iommu_need_mapping(struct device *dev)
 {
 	int found;
 
 	if (iommu_dummy(dev))
-		return 1;
+		return false;
 
 	if (!iommu_identity_mapping)
-		return 0;
+		return true;
 
 	found = identity_mapping(dev);
 	if (found) {
 		if (iommu_should_identity_map(dev, 0))
-			return 1;
-		else {
-			/*
-			 * 32 bit DMA is removed from si_domain and fall back
-			 * to non-identity mapping.
-			 */
-			dmar_remove_one_dev_info(dev);
-			dev_info(dev, "32bit DMA uses non-identity mapping\n");
-			return 0;
-		}
+			return false;
+
+		/*
+		 * 32 bit DMA is removed from si_domain and fall back to
+		 * non-identity mapping.
+		 */
+		dmar_remove_one_dev_info(dev);
+		dev_info(dev, "32bit DMA uses non-identity mapping\n");
 	} else {
 		/*
 		 * In case of a detached 64 bit DMA device from vm, the device
 		 * is put into si_domain for identity mapping.
 		 */
-		if (iommu_should_identity_map(dev, 0)) {
-			int ret;
-			ret = domain_add_dev_info(si_domain, dev);
-			if (!ret) {
-				dev_info(dev, "64bit DMA uses identity mapping\n");
-				return 1;
-			}
+		if (iommu_should_identity_map(dev, 0) &&
+		    !domain_add_dev_info(si_domain, dev)) {
+			dev_info(dev, "64bit DMA uses identity mapping\n");
+			return false;
 		}
 	}
 
-	return 0;
+	return true;
 }
 
 static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
@@ -3660,7 +3655,7 @@ static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 
 	BUG_ON(dir == DMA_NONE);
 
-	if (iommu_no_mapping(dev))
+	if (!iommu_need_mapping(dev))
 		return paddr;
 
 	domain = get_valid_domain_for_dev(dev);
@@ -3731,7 +3726,7 @@ static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
 	struct intel_iommu *iommu;
 	struct page *freelist;
 
-	if (iommu_no_mapping(dev))
+	if (!iommu_need_mapping(dev))
 		return;
 
 	domain = find_domain(dev);
@@ -3782,7 +3777,7 @@ static void *intel_alloc_coherent(struct device *dev, size_t size,
 	size = PAGE_ALIGN(size);
 	order = get_order(size);
 
-	if (!iommu_no_mapping(dev))
+	if (iommu_need_mapping(dev))
 		flags &= ~(GFP_DMA | GFP_DMA32);
 	else if (dev->coherent_dma_mask < dma_get_required_mask(dev)) {
 		if (dev->coherent_dma_mask < DMA_BIT_MASK(32))
@@ -3796,7 +3791,7 @@ static void *intel_alloc_coherent(struct device *dev, size_t size,
 
 		page = dma_alloc_from_contiguous(dev, count, order,
 						 flags & __GFP_NOWARN);
-		if (page && iommu_no_mapping(dev) &&
+		if (page && !iommu_need_mapping(dev) &&
 		    page_to_phys(page) + size > dev->coherent_dma_mask) {
 			dma_release_from_contiguous(dev, page, count);
 			page = NULL;
@@ -3878,7 +3873,7 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 	struct intel_iommu *iommu;
 
 	BUG_ON(dir == DMA_NONE);
-	if (iommu_no_mapping(dev))
+	if (!iommu_need_mapping(dev))
 		return intel_nontranslate_map_sg(dev, sglist, nelems, dir);
 
 	domain = get_valid_domain_for_dev(dev);
-- 
2.20.1
