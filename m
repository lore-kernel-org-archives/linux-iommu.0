From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 04/25] iommu/dma: Remove the flush_page callback
Date: Tue, 30 Apr 2019 06:51:53 -0400
Message-ID: <20190430105214.24628-5-hch@lst.de>
References: <20190430105214.24628-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190430105214.24628-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

We now have a arch_dma_prep_coherent architecture hook that is used
for the generic DMA remap allocator, and we should use the same
interface for the dma-iommu code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/mm/dma-mapping.c | 8 +-------
 drivers/iommu/dma-iommu.c   | 8 +++-----
 include/linux/dma-iommu.h   | 3 +--
 3 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 674860e3e478..10a8852c8b6a 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -104,12 +104,6 @@ arch_initcall(arm64_dma_init);
 #include <linux/platform_device.h>
 #include <linux/amba/bus.h>
 
-/* Thankfully, all cache ops are by VA so we can ignore phys here */
-static void flush_page(struct device *dev, const void *virt, phys_addr_t phys)
-{
-	__dma_flush_area(virt, PAGE_SIZE);
-}
-
 static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 				 dma_addr_t *handle, gfp_t gfp,
 				 unsigned long attrs)
@@ -186,7 +180,7 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 		struct page **pages;
 
 		pages = iommu_dma_alloc(dev, iosize, gfp, attrs, ioprot,
-					handle, flush_page);
+					handle);
 		if (!pages)
 			return NULL;
 
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 77aabe637a60..77d704c8f565 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -22,6 +22,7 @@
 #include <linux/acpi_iort.h>
 #include <linux/device.h>
 #include <linux/dma-iommu.h>
+#include <linux/dma-noncoherent.h>
 #include <linux/gfp.h>
 #include <linux/huge_mm.h>
 #include <linux/iommu.h>
@@ -531,8 +532,6 @@ void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
  * @attrs: DMA attributes for this allocation
  * @prot: IOMMU mapping flags
  * @handle: Out argument for allocated DMA handle
- * @flush_page: Arch callback which must ensure PAGE_SIZE bytes from the
- *		given VA/PA are visible to the given non-coherent device.
  *
  * If @size is less than PAGE_SIZE, then a full CPU page will be allocated,
  * but an IOMMU which supports smaller pages might not map the whole thing.
@@ -541,8 +540,7 @@ void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
  *	   or NULL on failure.
  */
 struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
-		unsigned long attrs, int prot, dma_addr_t *handle,
-		void (*flush_page)(struct device *, const void *, phys_addr_t))
+		unsigned long attrs, int prot, dma_addr_t *handle)
 {
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
@@ -586,7 +584,7 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 		 */
 		sg_miter_start(&miter, sgt.sgl, sgt.orig_nents, SG_MITER_FROM_SG);
 		while (sg_miter_next(&miter))
-			flush_page(dev, miter.addr, page_to_phys(miter.page));
+			arch_dma_prep_coherent(miter.page, PAGE_SIZE);
 		sg_miter_stop(&miter);
 	}
 
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 8741637941ca..3216447178a7 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -44,8 +44,7 @@ int dma_info_to_prot(enum dma_data_direction dir, bool coherent,
  * the arch code to take care of attributes and cache maintenance
  */
 struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
-		unsigned long attrs, int prot, dma_addr_t *handle,
-		void (*flush_page)(struct device *, const void *, phys_addr_t));
+		unsigned long attrs, int prot, dma_addr_t *handle);
 void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
 		dma_addr_t *handle);
 
-- 
2.20.1
