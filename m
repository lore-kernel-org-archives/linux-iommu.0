From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 8/9] swiotlb: add support for non-coherent DMA
Date: Mon, 17 Sep 2018 17:38:25 +0200
Message-ID: <20180917153826.28052-9-hch@lst.de>
References: <20180917153826.28052-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180917153826.28052-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Handle architectures that are not cache coherent directly in the main
swiotlb code.  This involves two related changes:

 - call arch_sync_dma_for_{device,cpu} in all the right places from the
   various dma_map/unmap/sync methods when the device is non-coherent
 - call arch_dma_{alloc,free} for devices that are non-coherent

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm64/mm/dma-mapping.c |  6 ++---
 include/linux/swiotlb.h     |  4 ++--
 kernel/dma/swiotlb.c        | 44 ++++++++++++++++++++++++++++++-------
 3 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index abcae73eea50..07d9c2633f80 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -112,7 +112,7 @@ static void *__dma_alloc(struct device *dev, size_t size,
 		return addr;
 	}
 
-	ptr = swiotlb_alloc(dev, size, dma_handle, flags, attrs);
+	ptr = __swiotlb_alloc(dev, size, dma_handle, flags, attrs);
 	if (!ptr)
 		goto no_mem;
 
@@ -133,7 +133,7 @@ static void *__dma_alloc(struct device *dev, size_t size,
 	return coherent_ptr;
 
 no_map:
-	swiotlb_free(dev, size, ptr, *dma_handle, attrs);
+	__swiotlb_free(dev, size, ptr, *dma_handle, attrs);
 no_mem:
 	return NULL;
 }
@@ -151,7 +151,7 @@ static void __dma_free(struct device *dev, size_t size,
 			return;
 		vunmap(vaddr);
 	}
-	swiotlb_free(dev, size, swiotlb_addr, dma_handle, attrs);
+	__swiotlb_free(dev, size, swiotlb_addr, dma_handle, attrs);
 }
 
 static dma_addr_t __swiotlb_map_page(struct device *dev, struct page *page,
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index f847c1b265c4..bc809d826d4f 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -67,9 +67,9 @@ extern void swiotlb_tbl_sync_single(struct device *hwdev,
 
 /* Accessory functions. */
 
-void *swiotlb_alloc(struct device *hwdev, size_t size, dma_addr_t *dma_handle,
+void *__swiotlb_alloc(struct device *hwdev, size_t size, dma_addr_t *dma_handle,
 		gfp_t flags, unsigned long attrs);
-void swiotlb_free(struct device *dev, size_t size, void *vaddr,
+void __swiotlb_free(struct device *dev, size_t size, void *vaddr,
 		dma_addr_t dma_addr, unsigned long attrs);
 
 extern dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 4d7a4d85d71e..83e597101c6a 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -21,6 +21,7 @@
 
 #include <linux/cache.h>
 #include <linux/dma-direct.h>
+#include <linux/dma-noncoherent.h>
 #include <linux/mm.h>
 #include <linux/export.h>
 #include <linux/spinlock.h>
@@ -749,6 +750,10 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
 		dma_addr = swiotlb_bounce_page(dev, &phys, size, dir, attrs);
 	}
 
+	if (!dev_is_dma_coherent(dev) &&
+	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
+		arch_sync_dma_for_device(dev, phys, size, dir);
+
 	return dma_addr;
 }
 
@@ -768,6 +773,10 @@ void swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
 
 	BUG_ON(dir == DMA_NONE);
 
+	if (!dev_is_dma_coherent(hwdev) &&
+	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
+		arch_sync_dma_for_cpu(hwdev, paddr, size, dir);
+
 	if (is_swiotlb_buffer(paddr)) {
 		swiotlb_tbl_unmap_single(hwdev, paddr, size, dir, attrs);
 		return;
@@ -804,15 +813,17 @@ swiotlb_sync_single(struct device *hwdev, dma_addr_t dev_addr,
 
 	BUG_ON(dir == DMA_NONE);
 
-	if (is_swiotlb_buffer(paddr)) {
+	if (!dev_is_dma_coherent(hwdev) && target == SYNC_FOR_CPU)
+		arch_sync_dma_for_cpu(hwdev, paddr, size, dir);
+
+	if (is_swiotlb_buffer(paddr))
 		swiotlb_tbl_sync_single(hwdev, paddr, size, dir, target);
-		return;
-	}
 
-	if (dir != DMA_FROM_DEVICE)
-		return;
+	if (!dev_is_dma_coherent(hwdev) && target == SYNC_FOR_DEVICE)
+		arch_sync_dma_for_device(hwdev, paddr, size, dir);
 
-	dma_mark_clean(phys_to_virt(paddr), size);
+	if (!is_swiotlb_buffer(paddr) && dir == DMA_FROM_DEVICE)
+		dma_mark_clean(phys_to_virt(paddr), size);
 }
 
 void
@@ -928,7 +939,7 @@ swiotlb_dma_supported(struct device *hwdev, u64 mask)
 	return __phys_to_dma(hwdev, io_tlb_end - 1) <= mask;
 }
 
-void *swiotlb_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
+void *__swiotlb_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t gfp, unsigned long attrs)
 {
 	void *vaddr;
@@ -950,13 +961,30 @@ void *swiotlb_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	return vaddr;
 }
 
-void swiotlb_free(struct device *dev, size_t size, void *vaddr,
+static void *swiotlb_alloc(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
+{
+	if (!dev_is_dma_coherent(dev))
+		return arch_dma_alloc(dev, size, dma_handle, gfp, attrs);
+	return __swiotlb_alloc(dev, size, dma_handle, gfp, attrs);
+}
+
+void __swiotlb_free(struct device *dev, size_t size, void *vaddr,
 		dma_addr_t dma_addr, unsigned long attrs)
 {
 	if (!swiotlb_free_buffer(dev, size, dma_addr))
 		dma_direct_free(dev, size, vaddr, dma_addr, attrs);
 }
 
+static void swiotlb_free(struct device *dev, size_t size, void *vaddr,
+		dma_addr_t dma_addr, unsigned long attrs)
+{
+	if (!dev_is_dma_coherent(dev))
+		arch_dma_free(dev, size, vaddr, dma_addr, attrs);
+	else
+		__swiotlb_free(dev, size, vaddr, dma_addr, attrs);
+}
+
 const struct dma_map_ops swiotlb_dma_ops = {
 	.mapping_error		= dma_direct_mapping_error,
 	.alloc			= swiotlb_alloc,
-- 
2.18.0
