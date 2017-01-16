From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 2/2] iommu/dma: Implement PCI allocation optimisation
Date: Mon, 16 Jan 2017 13:24:55 +0000
Message-ID: <db8af3d98f2a717c51d007c9c36d3b8eb1acd9a1.1484572209.git.robin.murphy@arm.com>
References: <d899aa686e7c8cb45142fa6785aa539ef3b88dec.1484572209.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <d899aa686e7c8cb45142fa6785aa539ef3b88dec.1484572209.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Whilst PCI devices may have 64-bit DMA masks, they still benefit from
using 32-bit addresses wherever possible in order to avoid DAC (PCI) or
longer address packets (PCIe), which may incur a performance overhead.
Implement the same optimisation as other allocators by trying to get a
32-bit address first, only falling back to the full mask if that fails.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/dma-iommu.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9aa432e8fbd3..8adff5f83b38 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -281,19 +281,28 @@ int dma_direction_to_prot(enum dma_data_direction dir, bool coherent)
 }
 
 static struct iova *__alloc_iova(struct iommu_domain *domain, size_t size,
-		dma_addr_t dma_limit)
+		dma_addr_t dma_limit, struct device *dev)
 {
 	struct iova_domain *iovad = cookie_iovad(domain);
 	unsigned long shift = iova_shift(iovad);
 	unsigned long length = iova_align(iovad, size) >> shift;
+	struct iova *iova = NULL;
 
 	if (domain->geometry.force_aperture)
 		dma_limit = min(dma_limit, domain->geometry.aperture_end);
+
+	/* Try to get PCI devices a SAC address */
+	if (dma_limit > DMA_BIT_MASK(32) && dev_is_pci(dev))
+		iova = alloc_iova(iovad, length, DMA_BIT_MASK(32) >> shift,
+				  true);
 	/*
 	 * Enforce size-alignment to be safe - there could perhaps be an
 	 * attribute to control this per-device, or at least per-domain...
 	 */
-	return alloc_iova(iovad, length, dma_limit >> shift, true);
+	if (!iova)
+		iova = alloc_iova(iovad, length, dma_limit >> shift, true);
+
+	return iova;
 }
 
 /* The IOVA allocator knows what we mapped, so just unmap whatever that was */
@@ -446,7 +455,7 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 	if (!pages)
 		return NULL;
 
-	iova = __alloc_iova(domain, size, dev->coherent_dma_mask);
+	iova = __alloc_iova(domain, size, dev->coherent_dma_mask, dev);
 	if (!iova)
 		goto out_free_pages;
 
@@ -517,7 +526,7 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 	struct iova_domain *iovad = cookie_iovad(domain);
 	size_t iova_off = iova_offset(iovad, phys);
 	size_t len = iova_align(iovad, size + iova_off);
-	struct iova *iova = __alloc_iova(domain, len, dma_get_mask(dev));
+	struct iova *iova = __alloc_iova(domain, len, dma_get_mask(dev), dev);
 
 	if (!iova)
 		return DMA_ERROR_CODE;
@@ -675,7 +684,7 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		prev = s;
 	}
 
-	iova = __alloc_iova(domain, iova_len, dma_get_mask(dev));
+	iova = __alloc_iova(domain, iova_len, dma_get_mask(dev), dev);
 	if (!iova)
 		goto out_restore_sg;
 
@@ -755,7 +764,7 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 
 	msi_page->phys = msi_addr;
 	if (iovad) {
-		iova = __alloc_iova(domain, size, dma_get_mask(dev));
+		iova = __alloc_iova(domain, size, dma_get_mask(dev), dev);
 		if (!iova)
 			goto out_free_page;
 		msi_page->iova = iova_dma_addr(iovad, iova);
-- 
2.10.2.dirty
