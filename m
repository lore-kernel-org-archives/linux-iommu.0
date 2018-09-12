From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 3/3] arm64/dma-mapping: Mildly optimise non-coherent IOMMU
	ops
Date: Wed, 12 Sep 2018 16:24:14 +0100
Message-ID: <b6d77151ac0133a39f3a3e69766f7bcf13edc70f.1536764440.git.robin.murphy@arm.com>
References: <cover.1536764440.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1536764440.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org
Cc: guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Whilst the symmetry of deferring to the existing sync callback in
__iommu_map_page() is nice, taking a round-trip through
iommu_iova_to_phys() is a pretty heavyweight way to get an address we
can trivially compute from the page we already have. Tweaking it to just
perform the cache maintenance directly when appropriate doesn't really
make the code any more complicated, and the runtime efficiency gain can
only be a benefit.

Furthermore, the sync operations themselves know they can only be
invoked on a managed DMA ops domain, so can use the fast specific domain
lookup to avoid excessive manipulation of the group refcount
(particularly in the scatterlist cases).

Acked-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

v2: Don't be totally broken by forgetting the offset

 arch/arm64/mm/dma-mapping.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 072c51fb07d7..cf017c5bb5e7 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -712,7 +712,7 @@ static void __iommu_sync_single_for_cpu(struct device *dev,
 	if (is_device_dma_coherent(dev))
 		return;
 
-	phys = iommu_iova_to_phys(iommu_get_domain_for_dev(dev), dev_addr);
+	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dev_addr);
 	__dma_unmap_area(phys_to_virt(phys), size, dir);
 }
 
@@ -725,7 +725,7 @@ static void __iommu_sync_single_for_device(struct device *dev,
 	if (is_device_dma_coherent(dev))
 		return;
 
-	phys = iommu_iova_to_phys(iommu_get_domain_for_dev(dev), dev_addr);
+	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dev_addr);
 	__dma_map_area(phys_to_virt(phys), size, dir);
 }
 
@@ -738,9 +738,9 @@ static dma_addr_t __iommu_map_page(struct device *dev, struct page *page,
 	int prot = dma_info_to_prot(dir, coherent, attrs);
 	dma_addr_t dev_addr = iommu_dma_map_page(dev, page, offset, size, prot);
 
-	if (!iommu_dma_mapping_error(dev, dev_addr) &&
-	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
-		__iommu_sync_single_for_device(dev, dev_addr, size, dir);
+	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+	    !iommu_dma_mapping_error(dev, dev_addr))
+		__dma_map_area(page_address(page) + offset, size, dir);
 
 	return dev_addr;
 }
-- 
2.19.0.dirty
