From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH] iommu/dma: Remove bogus dma_supported() implementation
Date: Wed,  1 Feb 2017 17:53:04 +0000
Message-ID: <143b03c101e727cb156b26a907c8d7e390eb9114.1485971565.git.robin.murphy@arm.com>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Back when this was first written, dma_supported() was somewhat of a
murky mess, with subtly different interpretations being relied upon in
various places. The "does device X support DMA to address range Y?"
uses assuming Y to be physical addresses, which motivated the current
iommu_dma_supported() implementation and are alluded to in the comment
therein, have since been cleaned up, leaving only the far less ambiguous
"can device X drive address bits Y" usage internal to DMA API mask
setting. As such, there is no reason to keep a slightly misleading
callback which does nothing but duplicate the current default behaviour;
we already constrain IOVA allocations to the iommu_domain aperture where
necessary, so let's leave DMA mask business to architecture-specific
code where it belongs.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

Techincally an IOMMU patch, but could possibly go via arm64 I suppose.

 arch/arm64/mm/dma-mapping.c |  1 -
 drivers/iommu/dma-iommu.c   | 10 ----------
 include/linux/dma-iommu.h   |  1 -
 3 files changed, 12 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 88493b0ebd5e..351f7595cb3e 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -810,7 +810,6 @@ static struct dma_map_ops iommu_dma_ops = {
 	.sync_sg_for_device = __iommu_sync_sg_for_device,
 	.map_resource = iommu_dma_map_resource,
 	.unmap_resource = iommu_dma_unmap_resource,
-	.dma_supported = iommu_dma_supported,
 	.mapping_error = iommu_dma_mapping_error,
 };
 
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 1c9ac26e3b68..48d36ce59efb 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -734,16 +734,6 @@ void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
 	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), handle);
 }
 
-int iommu_dma_supported(struct device *dev, u64 mask)
-{
-	/*
-	 * 'Special' IOMMUs which don't have the same addressing capability
-	 * as the CPU will have to wait until we have some way to query that
-	 * before they'll be able to use this framework.
-	 */
-	return 1;
-}
-
 int iommu_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
 	return dma_addr == DMA_ERROR_CODE;
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 3a846f9ec0fd..5725c94b1f12 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -67,7 +67,6 @@ dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
 		size_t size, enum dma_data_direction dir, unsigned long attrs);
 void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir, unsigned long attrs);
-int iommu_dma_supported(struct device *dev, u64 mask);
 int iommu_dma_mapping_error(struct device *dev, dma_addr_t dma_addr);
 
 /* The DMA API isn't _quite_ the whole story, though... */
-- 
2.11.0.dirty
