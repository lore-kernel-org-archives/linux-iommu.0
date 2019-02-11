From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 11/12] dma-mapping: handle per-device coherent memory mmap in common code
Date: Mon, 11 Feb 2019 14:35:53 +0100
Message-ID: <20190211133554.30055-12-hch@lst.de>
References: <20190211133554.30055-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190211133554.30055-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>, x86@kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

We handle allocation and freeing in common code, so we should handle
mmap the same way.  Also all users of per-device coherent memory are
exclusive, that is if we can't allocate from the per-device pool we
can't use the system memory either.  Unfold the current
dma_mmap_from_dev_coherent implementation and always use the
per-device pool if it exists.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/mm/dma-mapping-nommu.c |  7 ++--
 arch/arm/mm/dma-mapping.c       |  3 --
 arch/arm64/mm/dma-mapping.c     |  3 --
 include/linux/dma-mapping.h     | 11 ++-----
 kernel/dma/coherent.c           | 58 ++++++++-------------------------
 kernel/dma/internal.h           |  2 ++
 kernel/dma/mapping.c            |  8 ++---
 7 files changed, 24 insertions(+), 68 deletions(-)

diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
index c72f024f1e82..4eeb7e5d9c07 100644
--- a/arch/arm/mm/dma-mapping-nommu.c
+++ b/arch/arm/mm/dma-mapping-nommu.c
@@ -80,11 +80,8 @@ static int arm_nommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 			      void *cpu_addr, dma_addr_t dma_addr, size_t size,
 			      unsigned long attrs)
 {
-	int ret;
-
-	if (dma_mmap_from_global_coherent(vma, cpu_addr, size, &ret))
-		return ret;
-
+	if (!(attrs & DMA_ATTR_NON_CONSISTENT))
+		return dma_mmap_from_global_coherent(vma, cpu_addr, size);
 	return dma_common_mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
 }
 
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 3c8534904209..e2993e5a7166 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -830,9 +830,6 @@ static int __arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 	unsigned long pfn = dma_to_pfn(dev, dma_addr);
 	unsigned long off = vma->vm_pgoff;
 
-	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
-		return ret;
-
 	if (off < nr_pages && nr_vma_pages <= (nr_pages - off)) {
 		ret = remap_pfn_range(vma, vma->vm_start,
 				      pfn + off,
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 78c0a72f822c..a55be91c1d1a 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -246,9 +246,6 @@ static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 
 	vma->vm_page_prot = arch_dma_mmap_pgprot(dev, vma->vm_page_prot, attrs);
 
-	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
-		return ret;
-
 	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
 		/*
 		 * DMA_ATTR_FORCE_CONTIGUOUS allocations are always remapped,
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 018e37a0870e..ae6fe66f97b7 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -158,17 +158,12 @@ static inline int is_device_dma_capable(struct device *dev)
  * These three functions are only for dma allocator.
  * Don't use them in device drivers.
  */
-int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
-			    void *cpu_addr, size_t size, int *ret);
-
 void *dma_alloc_from_global_coherent(size_t size, dma_addr_t *dma_handle);
 void dma_release_from_global_coherent(size_t size, void *vaddr);
 int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *cpu_addr,
-				  size_t size, int *ret);
+				  size_t size);
 
 #else
-#define dma_mmap_from_dev_coherent(dev, vma, vaddr, order, ret) (0)
-
 static inline void *dma_alloc_from_global_coherent(size_t size,
 						   dma_addr_t *dma_handle)
 {
@@ -177,12 +172,10 @@ static inline void *dma_alloc_from_global_coherent(size_t size,
 
 static inline void dma_release_from_global_coherent(size_t size, void *vaddr)
 {
-	return 0;
 }
 
 static inline int dma_mmap_from_global_coherent(struct vm_area_struct *vma,
-						void *cpu_addr, size_t size,
-						int *ret)
+						void *cpu_addr, size_t size)
 {
 	return 0;
 }
diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index d1da1048e470..d7a27008f228 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -197,60 +197,30 @@ void dma_release_from_global_coherent(size_t size, void *vaddr)
 	__dma_release_from_coherent(dma_coherent_default_memory, size, vaddr);
 }
 
-static int __dma_mmap_from_coherent(struct dma_coherent_mem *mem,
-		struct vm_area_struct *vma, void *vaddr, size_t size, int *ret)
+int __dma_mmap_from_coherent(struct dma_coherent_mem *mem,
+		struct vm_area_struct *vma, void *vaddr, size_t size)
 {
-	if (mem && vaddr >= mem->virt_base && vaddr + size <=
-		   (mem->virt_base + (mem->size << PAGE_SHIFT))) {
-		unsigned long off = vma->vm_pgoff;
-		int start = (vaddr - mem->virt_base) >> PAGE_SHIFT;
-		int user_count = vma_pages(vma);
-		int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-
-		*ret = -ENXIO;
-		if (off < count && user_count <= count - off) {
-			unsigned long pfn = mem->pfn_base + start + off;
-			*ret = remap_pfn_range(vma, vma->vm_start, pfn,
-					       user_count << PAGE_SHIFT,
-					       vma->vm_page_prot);
-		}
-		return 1;
-	}
-	return 0;
-}
+	unsigned long off = vma->vm_pgoff;
+	int start = (vaddr - mem->virt_base) >> PAGE_SHIFT;
+	int user_count = vma_pages(vma);
+	int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 
-/**
- * dma_mmap_from_dev_coherent() - mmap memory from the device coherent pool
- * @dev:	device from which the memory was allocated
- * @vma:	vm_area for the userspace memory
- * @vaddr:	cpu address returned by dma_alloc_from_dev_coherent
- * @size:	size of the memory buffer allocated
- * @ret:	result from remap_pfn_range()
- *
- * This checks whether the memory was allocated from the per-device
- * coherent memory pool and if so, maps that memory to the provided vma.
- *
- * Returns 1 if @vaddr belongs to the device coherent pool and the caller
- * should return @ret, or 0 if they should proceed with mapping memory from
- * generic areas.
- */
-int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
-			   void *vaddr, size_t size, int *ret)
-{
-	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
-
-	return __dma_mmap_from_coherent(mem, vma, vaddr, size, ret);
+	if (WARN_ON_ONCE(!dma_in_coherent_range(mem, size, vaddr)))
+		return -ENXIO;
+	if (off >= count || user_count > count - off)
+		return -ENXIO;
+	return remap_pfn_range(vma, vma->vm_start, mem->pfn_base + start + off,
+			user_count << PAGE_SHIFT, vma->vm_page_prot);
 }
-EXPORT_SYMBOL(dma_mmap_from_dev_coherent);
 
 int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *vaddr,
-				   size_t size, int *ret)
+				   size_t size)
 {
 	if (!dma_coherent_default_memory)
 		return 0;
 
 	return __dma_mmap_from_coherent(dma_coherent_default_memory, vma,
-					vaddr, size, ret);
+					vaddr, size);
 }
 
 /*
diff --git a/kernel/dma/internal.h b/kernel/dma/internal.h
index 48a0a71487b1..651a0991777f 100644
--- a/kernel/dma/internal.h
+++ b/kernel/dma/internal.h
@@ -15,5 +15,7 @@ void *__dma_alloc_from_coherent(struct dma_coherent_mem *mem, size_t size,
 		dma_addr_t *dma_handle);
 void __dma_release_from_coherent(struct dma_coherent_mem *mem, size_t size,
 		void *vaddr);
+int __dma_mmap_from_coherent(struct dma_coherent_mem *mem,
+		struct vm_area_struct *vma, void *vaddr, size_t size);
 
 #endif /* _DMA_INTERNAL_H */
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index d3c4363b2143..5f28dc8f9bf4 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -158,13 +158,9 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	unsigned long off = vma->vm_pgoff;
 	unsigned long pfn;
-	int ret = -ENXIO;
 
 	vma->vm_page_prot = arch_dma_mmap_pgprot(dev, vma->vm_page_prot, attrs);
 
-	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
-		return ret;
-
 	if (off >= count || user_count > count - off)
 		return -ENXIO;
 
@@ -201,6 +197,10 @@ int dma_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 		unsigned long attrs)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
+	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
+
+	if (mem)
+		return __dma_mmap_from_coherent(mem, vma, cpu_addr, size);
 
 	if (!dma_is_direct(ops) && ops->mmap)
 		return ops->mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
-- 
2.20.1
