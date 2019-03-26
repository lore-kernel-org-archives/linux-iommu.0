From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH v2 RFC/RFT 5/5] dma-contiguous: Do not allocate a single page from CMA area
Date: Tue, 26 Mar 2019 16:01:31 -0700
Message-ID: <20190326230131.16275-6-nicoleotsuka@gmail.com>
References: <20190326230131.16275-1-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190326230131.16275-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hch@lst.de, robin.murphy@arm.com
Cc: vdumpa@nvidia.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, joro@8bytes.org, m.szyprowski@samsung.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, tony@atomide.com
List-Id: iommu@lists.linux-foundation.org

The addresses within a single page are always contiguous, so it's
not so necessary to always allocate one single page from CMA area.
Since the CMA area has a limited predefined size of space, it may
run out of space in heavy use cases, where there might be quite a
lot CMA pages being allocated for single pages.

However, there is also a concern that a device might care where a
page comes from -- it might expect the page from CMA area and act
differently if the page doesn't.

This patch tries to skip of one-page size allocations and returns
NULL so as to let callers allocate normal pages unless the device
has its own CMA area. This would save resources from the CMA area
for more CMA allocations. And it'd also reduce CMA fragmentations
resulted from trivial allocations.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 kernel/dma/contiguous.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index b2a87905846d..09074bd04793 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -186,16 +186,32 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
  *
  * This function allocates memory buffer for specified device. It uses
  * device specific contiguous memory area if available or the default
- * global one. Requires architecture specific dev_get_cma_area() helper
- * function.
+ * global one.
+ *
+ * However, it skips one-page size of allocations from the global area.
+ * As the addresses within one page are always contiguous, so there is
+ * no need to waste CMA pages for that kind; it also helps reduce the
+ * fragmentations in the CMA area. So a caller should be the rebounder
+ * in such case to allocate a normal page upon NULL return value.
+ *
+ * Requires architecture specific dev_get_cma_area() helper function.
  */
 struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
 				       unsigned int align, bool no_warn)
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
+		return NULL;
+
+	return cma_alloc(cma, count, align, no_warn);
 }
 
 /**
-- 
2.17.1
