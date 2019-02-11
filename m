From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 10/12] dma-mapping: simplify allocations from per-device coherent memory
Date: Mon, 11 Feb 2019 14:35:52 +0100
Message-ID: <20190211133554.30055-11-hch@lst.de>
References: <20190211133554.30055-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190211133554.30055-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>, x86@kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

All users of per-device coherent memory are exclusive, that is if we can't
allocate from the per-device pool we can't use the system memory either.
Unfold the current dma_{alloc,free}_from_dev_coherent implementation and
always use the per-device pool if it exists.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/mm/dma-mapping-nommu.c | 12 ++---
 include/linux/dma-mapping.h     | 14 ++----
 kernel/dma/coherent.c           | 89 ++++++++-------------------------
 kernel/dma/internal.h           | 19 +++++++
 kernel/dma/mapping.c            | 12 +++--
 5 files changed, 55 insertions(+), 91 deletions(-)
 create mode 100644 kernel/dma/internal.h

diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
index f304b10e23a4..c72f024f1e82 100644
--- a/arch/arm/mm/dma-mapping-nommu.c
+++ b/arch/arm/mm/dma-mapping-nommu.c
@@ -70,16 +70,10 @@ static void arm_nommu_dma_free(struct device *dev, size_t size,
 			       void *cpu_addr, dma_addr_t dma_addr,
 			       unsigned long attrs)
 {
-	if (attrs & DMA_ATTR_NON_CONSISTENT) {
+	if (attrs & DMA_ATTR_NON_CONSISTENT)
 		dma_direct_free_pages(dev, size, cpu_addr, dma_addr, attrs);
-	} else {
-		int ret = dma_release_from_global_coherent(get_order(size),
-							   cpu_addr);
-
-		WARN_ON_ONCE(ret == 0);
-	}
-
-	return;
+	else
+		dma_release_from_global_coherent(size, cpu_addr);
 }
 
 static int arm_nommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index b12fba725f19..018e37a0870e 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -158,30 +158,24 @@ static inline int is_device_dma_capable(struct device *dev)
  * These three functions are only for dma allocator.
  * Don't use them in device drivers.
  */
-int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
-				       dma_addr_t *dma_handle, void **ret);
-int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr);
-
 int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
 			    void *cpu_addr, size_t size, int *ret);
 
-void *dma_alloc_from_global_coherent(ssize_t size, dma_addr_t *dma_handle);
-int dma_release_from_global_coherent(int order, void *vaddr);
+void *dma_alloc_from_global_coherent(size_t size, dma_addr_t *dma_handle);
+void dma_release_from_global_coherent(size_t size, void *vaddr);
 int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *cpu_addr,
 				  size_t size, int *ret);
 
 #else
-#define dma_alloc_from_dev_coherent(dev, size, handle, ret) (0)
-#define dma_release_from_dev_coherent(dev, order, vaddr) (0)
 #define dma_mmap_from_dev_coherent(dev, vma, vaddr, order, ret) (0)
 
-static inline void *dma_alloc_from_global_coherent(ssize_t size,
+static inline void *dma_alloc_from_global_coherent(size_t size,
 						   dma_addr_t *dma_handle)
 {
 	return NULL;
 }
 
-static inline int dma_release_from_global_coherent(int order, void *vaddr)
+static inline void dma_release_from_global_coherent(size_t size, void *vaddr)
 {
 	return 0;
 }
diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 29fd6590dc1e..d1da1048e470 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/dma-mapping.h>
+#include "internal.h"
 
 struct dma_coherent_mem {
 	void		*virt_base;
@@ -21,13 +22,6 @@ struct dma_coherent_mem {
 
 static struct dma_coherent_mem *dma_coherent_default_memory __ro_after_init;
 
-static inline struct dma_coherent_mem *dev_get_coherent_memory(struct device *dev)
-{
-	if (dev && dev->dma_mem)
-		return dev->dma_mem;
-	return NULL;
-}
-
 static inline dma_addr_t dma_get_device_base(struct device *dev,
 					     struct dma_coherent_mem * mem)
 {
@@ -135,8 +129,8 @@ void dma_release_declared_memory(struct device *dev)
 }
 EXPORT_SYMBOL(dma_release_declared_memory);
 
-static void *__dma_alloc_from_coherent(struct dma_coherent_mem *mem,
-		ssize_t size, dma_addr_t *dma_handle)
+void *__dma_alloc_from_coherent(struct dma_coherent_mem *mem, size_t size,
+		dma_addr_t *dma_handle)
 {
 	int order = get_order(size);
 	unsigned long flags;
@@ -165,33 +159,7 @@ static void *__dma_alloc_from_coherent(struct dma_coherent_mem *mem,
 	return NULL;
 }
 
-/**
- * dma_alloc_from_dev_coherent() - allocate memory from device coherent pool
- * @dev:	device from which we allocate memory
- * @size:	size of requested memory area
- * @dma_handle:	This will be filled with the correct dma handle
- * @ret:	This pointer will be filled with the virtual address
- *		to allocated area.
- *
- * This function should be only called from per-arch dma_alloc_coherent()
- * to support allocation from per-device coherent memory pools.
- *
- * Returns 0 if dma_alloc_coherent should continue with allocating from
- * generic memory areas, or !0 if dma_alloc_coherent should return @ret.
- */
-int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
-		dma_addr_t *dma_handle, void **ret)
-{
-	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
-
-	if (!mem)
-		return 0;
-
-	*ret = __dma_alloc_from_coherent(mem, size, dma_handle);
-	return 1;
-}
-
-void *dma_alloc_from_global_coherent(ssize_t size, dma_addr_t *dma_handle)
+void *dma_alloc_from_global_coherent(size_t size, dma_addr_t *dma_handle)
 {
 	if (!dma_coherent_default_memory)
 		return NULL;
@@ -200,48 +168,33 @@ void *dma_alloc_from_global_coherent(ssize_t size, dma_addr_t *dma_handle)
 			dma_handle);
 }
 
-static int __dma_release_from_coherent(struct dma_coherent_mem *mem,
-				       int order, void *vaddr)
+static bool dma_in_coherent_range(struct dma_coherent_mem *mem, size_t size,
+		void *vaddr)
 {
-	if (mem && vaddr >= mem->virt_base && vaddr <
-		   (mem->virt_base + (mem->size << PAGE_SHIFT))) {
-		int page = (vaddr - mem->virt_base) >> PAGE_SHIFT;
-		unsigned long flags;
-
-		spin_lock_irqsave(&mem->spinlock, flags);
-		bitmap_release_region(mem->bitmap, page, order);
-		spin_unlock_irqrestore(&mem->spinlock, flags);
-		return 1;
-	}
-	return 0;
+	return vaddr >= mem->virt_base &&
+		vaddr + size <= mem->virt_base + (mem->size << PAGE_SHIFT);
 }
 
-/**
- * dma_release_from_dev_coherent() - free memory to device coherent memory pool
- * @dev:	device from which the memory was allocated
- * @order:	the order of pages allocated
- * @vaddr:	virtual address of allocated pages
- *
- * This checks whether the memory was allocated from the per-device
- * coherent memory pool and if so, releases that memory.
- *
- * Returns 1 if we correctly released the memory, or 0 if the caller should
- * proceed with releasing memory from generic pools.
- */
-int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr)
+void __dma_release_from_coherent(struct dma_coherent_mem *mem, size_t size,
+		void *vaddr)
 {
-	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
+	int page = (vaddr - mem->virt_base) >> PAGE_SHIFT;
+	unsigned long flags;
+
+	if (WARN_ON_ONCE(!dma_in_coherent_range(mem, size, vaddr)))
+		return;
 
-	return __dma_release_from_coherent(mem, order, vaddr);
+	spin_lock_irqsave(&mem->spinlock, flags);
+	bitmap_release_region(mem->bitmap, page, get_order(size));
+	spin_unlock_irqrestore(&mem->spinlock, flags);
 }
 
-int dma_release_from_global_coherent(int order, void *vaddr)
+void dma_release_from_global_coherent(size_t size, void *vaddr)
 {
 	if (!dma_coherent_default_memory)
-		return 0;
+		return;
 
-	return __dma_release_from_coherent(dma_coherent_default_memory, order,
-			vaddr);
+	__dma_release_from_coherent(dma_coherent_default_memory, size, vaddr);
 }
 
 static int __dma_mmap_from_coherent(struct dma_coherent_mem *mem,
diff --git a/kernel/dma/internal.h b/kernel/dma/internal.h
new file mode 100644
index 000000000000..48a0a71487b1
--- /dev/null
+++ b/kernel/dma/internal.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _DMA_INTERNAL_H
+#define _DMA_INTERNAL_H
+
+static inline struct dma_coherent_mem *dev_get_coherent_memory(struct device *dev)
+{
+#ifdef DMA_DECLARE_COHERENT
+	if (dev && dev->dma_mem)
+		return dev->dma_mem;
+#endif
+	return NULL;
+}
+
+void *__dma_alloc_from_coherent(struct dma_coherent_mem *mem, size_t size,
+		dma_addr_t *dma_handle);
+void __dma_release_from_coherent(struct dma_coherent_mem *mem, size_t size,
+		void *vaddr);
+
+#endif /* _DMA_INTERNAL_H */
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index a11006b6d8e8..d3c4363b2143 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -14,6 +14,7 @@
 #include <linux/of_device.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include "internal.h"
 
 /*
  * Managed DMA API
@@ -248,12 +249,13 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t flag, unsigned long attrs)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
+	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
 	void *cpu_addr;
 
 	WARN_ON_ONCE(dev && !dev->coherent_dma_mask);
 
-	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
-		return cpu_addr;
+	if (mem)
+		return __dma_alloc_from_coherent(mem, size, dma_handle);
 
 	/* let the implementation decide on the zone to allocate from: */
 	flag &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
@@ -277,9 +279,11 @@ void dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 		dma_addr_t dma_handle, unsigned long attrs)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
+	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
+
+	if (mem)
+		return __dma_release_from_coherent(mem, size, cpu_addr);
 
-	if (dma_release_from_dev_coherent(dev, get_order(size), cpu_addr))
-		return;
 	/*
 	 * On non-coherent platforms which implement DMA-coherent buffers via
 	 * non-cacheable remaps, ops->free() may call vunmap(). Thus getting
-- 
2.20.1
