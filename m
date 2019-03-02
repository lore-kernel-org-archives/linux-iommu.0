From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH RFC/RFT] dma-contiguous: Get normal pages for single-page allocations
Date: Fri,  1 Mar 2019 19:14:42 -0800
Message-ID: <20190302031442.22767-1-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: hch@lst.de, robin.murphy@arm.com
Cc: vdumpa@nvidia.com, catalin.marinas@arm.com, will.deacon@arm.com, chris@zankel.net, jcmvbkbc@gmail.com, joro@8bytes.org, dwmw2@infradead.org, m.szyprowski@samsung.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org, jonathanh@nvidia.com
List-Id: iommu@lists.linux-foundation.org

The addresses within a single page are always contiguous, so it's
not so necessary to always allocate one single page from CMA area.
Since the CMA area has a limited predefined size of space, it may
run out of space in heavy use cases, where there might be quite a
lot CMA pages being allocated for single pages.

However, there is also a concern that a device might care where a
page comes from -- it might expect the page from CMA area and act
differently if the page doesn't.

This patch tries to get normal pages for single-page allocations
unless the device has its own CMA area. This would save resources
from the CMA area for more CMA allocations. And it'd also reduce
CMA fragmentations resulted from trivial allocations.

Also, it updates the API and its callers so as to pass gfp flags.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 arch/arm/mm/dma-mapping.c      |  5 ++---
 arch/arm64/mm/dma-mapping.c    |  2 +-
 arch/xtensa/kernel/pci-dma.c   |  2 +-
 drivers/iommu/amd_iommu.c      |  2 +-
 drivers/iommu/intel-iommu.c    |  3 +--
 include/linux/dma-contiguous.h |  4 ++--
 kernel/dma/contiguous.c        | 23 +++++++++++++++++++----
 7 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 8a90f298af96..c39fc2d97712 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -588,7 +588,7 @@ static void *__alloc_from_contiguous(struct device *dev, size_t size,
 	struct page *page;
 	void *ptr = NULL;
 
-	page = dma_alloc_from_contiguous(dev, count, order, gfp & __GFP_NOWARN);
+	page = dma_alloc_from_contiguous(dev, count, order, gfp);
 	if (!page)
 		return NULL;
 
@@ -1293,8 +1293,7 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
 		unsigned long order = get_order(size);
 		struct page *page;
 
-		page = dma_alloc_from_contiguous(dev, count, order,
-						 gfp & __GFP_NOWARN);
+		page = dma_alloc_from_contiguous(dev, count, order, gfp);
 		if (!page)
 			goto error;
 
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 78c0a72f822c..660adedaab5d 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -159,7 +159,7 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 		struct page *page;
 
 		page = dma_alloc_from_contiguous(dev, size >> PAGE_SHIFT,
-					get_order(size), gfp & __GFP_NOWARN);
+						 get_order(size), gfp);
 		if (!page)
 			return NULL;
 
diff --git a/arch/xtensa/kernel/pci-dma.c b/arch/xtensa/kernel/pci-dma.c
index 9171bff76fc4..e15b893caadb 100644
--- a/arch/xtensa/kernel/pci-dma.c
+++ b/arch/xtensa/kernel/pci-dma.c
@@ -157,7 +157,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 
 	if (gfpflags_allow_blocking(flag))
 		page = dma_alloc_from_contiguous(dev, count, get_order(size),
-						 flag & __GFP_NOWARN);
+						 flag);
 
 	if (!page)
 		page = alloc_pages(flag | __GFP_ZERO, get_order(size));
diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 6b0760dafb3e..c54923a9e31f 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2691,7 +2691,7 @@ static void *alloc_coherent(struct device *dev, size_t size,
 			return NULL;
 
 		page = dma_alloc_from_contiguous(dev, size >> PAGE_SHIFT,
-					get_order(size), flag & __GFP_NOWARN);
+						 get_order(size), flag);
 		if (!page)
 			return NULL;
 	}
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a0ef7c5e5dfe..cd3483d03f3b 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3789,8 +3789,7 @@ static void *intel_alloc_coherent(struct device *dev, size_t size,
 	if (gfpflags_allow_blocking(flags)) {
 		unsigned int count = size >> PAGE_SHIFT;
 
-		page = dma_alloc_from_contiguous(dev, count, order,
-						 flags & __GFP_NOWARN);
+		page = dma_alloc_from_contiguous(dev, count, order, flags);
 		if (page && iommu_no_mapping(dev) &&
 		    page_to_phys(page) + size > dev->coherent_dma_mask) {
 			dma_release_from_contiguous(dev, page, count);
diff --git a/include/linux/dma-contiguous.h b/include/linux/dma-contiguous.h
index f247e8aa5e3d..b166e8a8740f 100644
--- a/include/linux/dma-contiguous.h
+++ b/include/linux/dma-contiguous.h
@@ -112,7 +112,7 @@ static inline int dma_declare_contiguous(struct device *dev, phys_addr_t size,
 }
 
 struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
-				       unsigned int order, bool no_warn);
+				       unsigned int order, gfp_t gfp);
 bool dma_release_from_contiguous(struct device *dev, struct page *pages,
 				 int count);
 
@@ -145,7 +145,7 @@ int dma_declare_contiguous(struct device *dev, phys_addr_t size,
 
 static inline
 struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
-				       unsigned int order, bool no_warn)
+				       unsigned int order, gfp_t gfp);
 {
 	return NULL;
 }
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index b2a87905846d..11b6d6ef4fc9 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -186,16 +186,31 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
  *
  * This function allocates memory buffer for specified device. It uses
  * device specific contiguous memory area if available or the default
- * global one. Requires architecture specific dev_get_cma_area() helper
- * function.
+ * global one.
+ *
+ * However, it allocates normal pages for one-page size of allocations
+ * instead of getting from CMA areas. As the addresses within a single
+ * page are always contiguous, so there is no need to waste CMA pages
+ * for that kind; it also helps reduce fragmentations in the CMA area.
+ *
+ * Requires architecture specific dev_get_cma_area() helper function.
  */
 struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
-				       unsigned int align, bool no_warn)
+				       unsigned int align, gfp_t gfp)
 {
+	struct cma *cma;
+
 	if (align > CONFIG_CMA_ALIGNMENT)
 		align = CONFIG_CMA_ALIGNMENT;
 
-	return cma_alloc(dev_get_cma_area(dev), count, align, no_warn);
+	if (dev && dev->cma_area)
+		cma = dev->cma_area;
+	else if (count > 1)
+		cma = dma_contiguous_default_area;
+	else
+		return alloc_pages(gfp, align);
+
+	return cma_alloc(cma, count, align, gfp & __GFP_NOWARN);
 }
 
 /**
-- 
2.17.1
