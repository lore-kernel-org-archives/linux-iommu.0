From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [RFC v2] dma-mapping: Use unsigned long for dma_attrs
Date: Mon, 30 May 2016 13:54:06 +0200
Message-ID: <1464609246-6948-2-git-send-email-k.kozlowski@samsung.com>
References: <1464609246-6948-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1464609246-6948-1-git-send-email-k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Michal Hocko <mhocko-IBi9RG/b67k@public.gmane.org>, Mel Gorman <mgorman-3eNAlZScCAx27rWaFMvyedHuzzzSOjJt@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, sstabellini-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

The dma-mapping core and the implementations do not change the
DMA attributes passed by pointer.  Thus the pointer can point to const
data.  However the attributes do not have to be a bitfield. Instead
unsigned long will do fine:

1. This is just simpler.  Both in terms of reading the code and setting
   attributes.  Instead of initializing local attributes on the stack and
   passing pointer to it to dma_set_attr(), just set the bits.

2. It brings safeness and checking for const correctness because the
   attributes are passed by value.

Please have in mind that this is RFC, not finished yet.  Only ARM and
ARM64 are fixed (and not everywhere).
However other API users also have to be converted which is quite
intrusive.  I would rather avoid it until the overall approach is
accepted.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 Documentation/DMA-API.txt                 |   2 +-
 Documentation/DMA-attributes.txt          |   2 +-
 arch/arm/include/asm/dma-mapping.h        |  13 ++--
 arch/arm/include/asm/xen/page-coherent.h  |  16 ++---
 arch/arm/mm/dma-mapping.c                 |  82 +++++++++++------------
 arch/arm/xen/mm.c                         |   4 +-
 arch/arm64/mm/dma-mapping.c               |  57 ++++++++--------
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c |   2 +-
 drivers/gpu/drm/exynos/exynos_drm_g2d.c   |   1 -
 drivers/gpu/drm/exynos/exynos_drm_gem.c   |  20 +++---
 drivers/gpu/drm/exynos/exynos_drm_gem.h   |   2 +-
 drivers/iommu/dma-iommu.c                 |   6 +-
 drivers/xen/swiotlb-xen.c                 |  14 ++--
 include/linux/dma-attrs.h                 |  71 --------------------
 include/linux/dma-iommu.h                 |   6 +-
 include/linux/dma-mapping.h               | 105 +++++++++++++++++-------------
 include/linux/swiotlb.h                   |  10 +--
 include/xen/swiotlb-xen.h                 |  12 ++--
 lib/dma-noop.c                            |   9 +--
 lib/swiotlb.c                             |  13 ++--
 20 files changed, 195 insertions(+), 252 deletions(-)
 delete mode 100644 include/linux/dma-attrs.h

diff --git a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
index 45ef3f279c3b..0b55cb7c5aaa 100644
--- a/Documentation/DMA-API.txt
+++ b/Documentation/DMA-API.txt
@@ -391,7 +391,7 @@ without the _attrs suffixes, except that they pass an optional
 struct dma_attrs*.
 
 struct dma_attrs encapsulates a set of "DMA attributes". For the
-definition of struct dma_attrs see linux/dma-attrs.h.
+definition of struct dma_attrs see linux/dma-mapping.h.
 
 The interpretation of DMA attributes is architecture-specific, and
 each attribute should be documented in Documentation/DMA-attributes.txt.
diff --git a/Documentation/DMA-attributes.txt b/Documentation/DMA-attributes.txt
index e8cf9cf873b3..2d455a5cf671 100644
--- a/Documentation/DMA-attributes.txt
+++ b/Documentation/DMA-attributes.txt
@@ -2,7 +2,7 @@
 			==============
 
 This document describes the semantics of the DMA attributes that are
-defined in linux/dma-attrs.h.
+defined in linux/dma-mapping.h.
 
 DMA_ATTR_WRITE_BARRIER
 ----------------------
diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index a83570f10124..d009f7911ffc 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -5,7 +5,6 @@
 
 #include <linux/mm_types.h>
 #include <linux/scatterlist.h>
-#include <linux/dma-attrs.h>
 #include <linux/dma-debug.h>
 
 #include <asm/memory.h>
@@ -174,7 +173,7 @@ static inline void dma_mark_clean(void *addr, size_t size) { }
  * to be the device-viewed address.
  */
 extern void *arm_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
-			   gfp_t gfp, struct dma_attrs *attrs);
+			   gfp_t gfp, unsigned long attrs);
 
 /**
  * arm_dma_free - free memory allocated by arm_dma_alloc
@@ -191,7 +190,7 @@ extern void *arm_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
  * during and after this call executing are illegal.
  */
 extern void arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
-			 dma_addr_t handle, struct dma_attrs *attrs);
+			 dma_addr_t handle, unsigned long attrs);
 
 /**
  * arm_dma_mmap - map a coherent DMA allocation into user space
@@ -208,7 +207,7 @@ extern void arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
  */
 extern int arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 			void *cpu_addr, dma_addr_t dma_addr, size_t size,
-			struct dma_attrs *attrs);
+			unsigned long attrs);
 
 /*
  * This can be called during early boot to increase the size of the atomic
@@ -262,16 +261,16 @@ extern void dmabounce_unregister_dev(struct device *);
  * The scatter list versions of the above methods.
  */
 extern int arm_dma_map_sg(struct device *, struct scatterlist *, int,
-		enum dma_data_direction, struct dma_attrs *attrs);
+		enum dma_data_direction, unsigned long attrs);
 extern void arm_dma_unmap_sg(struct device *, struct scatterlist *, int,
-		enum dma_data_direction, struct dma_attrs *attrs);
+		enum dma_data_direction, unsigned long attrs);
 extern void arm_dma_sync_sg_for_cpu(struct device *, struct scatterlist *, int,
 		enum dma_data_direction);
 extern void arm_dma_sync_sg_for_device(struct device *, struct scatterlist *, int,
 		enum dma_data_direction);
 extern int arm_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		struct dma_attrs *attrs);
+		unsigned long attrs);
 
 #endif /* __KERNEL__ */
 #endif
diff --git a/arch/arm/include/asm/xen/page-coherent.h b/arch/arm/include/asm/xen/page-coherent.h
index 9408a994cc91..95ce6ac3a971 100644
--- a/arch/arm/include/asm/xen/page-coherent.h
+++ b/arch/arm/include/asm/xen/page-coherent.h
@@ -2,15 +2,14 @@
 #define _ASM_ARM_XEN_PAGE_COHERENT_H
 
 #include <asm/page.h>
-#include <linux/dma-attrs.h>
 #include <linux/dma-mapping.h>
 
 void __xen_dma_map_page(struct device *hwdev, struct page *page,
 	     dma_addr_t dev_addr, unsigned long offset, size_t size,
-	     enum dma_data_direction dir, struct dma_attrs *attrs);
+	     enum dma_data_direction dir, unsigned long attrs);
 void __xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir,
-		struct dma_attrs *attrs);
+		unsigned long attrs);
 void __xen_dma_sync_single_for_cpu(struct device *hwdev,
 		dma_addr_t handle, size_t size, enum dma_data_direction dir);
 
@@ -18,22 +17,20 @@ void __xen_dma_sync_single_for_device(struct device *hwdev,
 		dma_addr_t handle, size_t size, enum dma_data_direction dir);
 
 static inline void *xen_alloc_coherent_pages(struct device *hwdev, size_t size,
-		dma_addr_t *dma_handle, gfp_t flags,
-		struct dma_attrs *attrs)
+		dma_addr_t *dma_handle, gfp_t flags, unsigned long attrs)
 {
 	return __generic_dma_ops(hwdev)->alloc(hwdev, size, dma_handle, flags, attrs);
 }
 
 static inline void xen_free_coherent_pages(struct device *hwdev, size_t size,
-		void *cpu_addr, dma_addr_t dma_handle,
-		struct dma_attrs *attrs)
+		void *cpu_addr, dma_addr_t dma_handle, unsigned long attrs)
 {
 	__generic_dma_ops(hwdev)->free(hwdev, size, cpu_addr, dma_handle, attrs);
 }
 
 static inline void xen_dma_map_page(struct device *hwdev, struct page *page,
 	     dma_addr_t dev_addr, unsigned long offset, size_t size,
-	     enum dma_data_direction dir, struct dma_attrs *attrs)
+	     enum dma_data_direction dir, unsigned long attrs)
 {
 	unsigned long page_pfn = page_to_xen_pfn(page);
 	unsigned long dev_pfn = XEN_PFN_DOWN(dev_addr);
@@ -58,8 +55,7 @@ static inline void xen_dma_map_page(struct device *hwdev, struct page *page,
 }
 
 static inline void xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
-		size_t size, enum dma_data_direction dir,
-		struct dma_attrs *attrs)
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	unsigned long pfn = PFN_DOWN(handle);
 	/*
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index ff7ed5697d3e..fe31fbfd926d 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -124,7 +124,7 @@ static void __dma_page_dev_to_cpu(struct page *, unsigned long,
  */
 static dma_addr_t arm_dma_map_page(struct device *dev, struct page *page,
 	     unsigned long offset, size_t size, enum dma_data_direction dir,
-	     struct dma_attrs *attrs)
+	     unsigned long attrs)
 {
 	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
 		__dma_page_cpu_to_dev(page, offset, size, dir);
@@ -133,7 +133,7 @@ static dma_addr_t arm_dma_map_page(struct device *dev, struct page *page,
 
 static dma_addr_t arm_coherent_dma_map_page(struct device *dev, struct page *page,
 	     unsigned long offset, size_t size, enum dma_data_direction dir,
-	     struct dma_attrs *attrs)
+	     unsigned long attrs)
 {
 	return pfn_to_dma(dev, page_to_pfn(page)) + offset;
 }
@@ -153,8 +153,7 @@ static dma_addr_t arm_coherent_dma_map_page(struct device *dev, struct page *pag
  * whatever the device wrote there.
  */
 static void arm_dma_unmap_page(struct device *dev, dma_addr_t handle,
-		size_t size, enum dma_data_direction dir,
-		struct dma_attrs *attrs)
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
 		__dma_page_dev_to_cpu(pfn_to_page(dma_to_pfn(dev, handle)),
@@ -194,12 +193,12 @@ struct dma_map_ops arm_dma_ops = {
 EXPORT_SYMBOL(arm_dma_ops);
 
 static void *arm_coherent_dma_alloc(struct device *dev, size_t size,
-	dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs);
+	dma_addr_t *handle, gfp_t gfp, unsigned long attrs);
 static void arm_coherent_dma_free(struct device *dev, size_t size, void *cpu_addr,
-				  dma_addr_t handle, struct dma_attrs *attrs);
+				  dma_addr_t handle, unsigned long attrs);
 static int arm_coherent_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		 struct dma_attrs *attrs);
+		 unsigned long attrs);
 
 struct dma_map_ops arm_coherent_dma_ops = {
 	.alloc			= arm_coherent_dma_alloc,
@@ -621,7 +620,7 @@ static void __free_from_contiguous(struct device *dev, struct page *page,
 	dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT);
 }
 
-static inline pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t prot)
+static inline pgprot_t __get_dma_pgprot(unsigned long attrs, pgprot_t prot)
 {
 	prot = dma_get_attr(DMA_ATTR_WRITE_COMBINE, attrs) ?
 			    pgprot_writecombine(prot) :
@@ -732,7 +731,7 @@ static struct arm_dma_allocator remap_allocator = {
 
 static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 			 gfp_t gfp, pgprot_t prot, bool is_coherent,
-			 struct dma_attrs *attrs, const void *caller)
+			 unsigned long attrs, const void *caller)
 {
 	u64 mask = get_coherent_dma_mask(dev);
 	struct page *page = NULL;
@@ -814,7 +813,7 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
  * virtual and bus address for that space.
  */
 void *arm_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
-		    gfp_t gfp, struct dma_attrs *attrs)
+		    gfp_t gfp, unsigned long attrs)
 {
 	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
 
@@ -823,7 +822,7 @@ void *arm_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 }
 
 static void *arm_coherent_dma_alloc(struct device *dev, size_t size,
-	dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs)
+	dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
 {
 	return __dma_alloc(dev, size, handle, gfp, PAGE_KERNEL, true,
 			   attrs, __builtin_return_address(0));
@@ -831,7 +830,7 @@ static void *arm_coherent_dma_alloc(struct device *dev, size_t size,
 
 static int __arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		 struct dma_attrs *attrs)
+		 unsigned long attrs)
 {
 	int ret = -ENXIO;
 #ifdef CONFIG_MMU
@@ -859,14 +858,14 @@ static int __arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
  */
 static int arm_coherent_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		 struct dma_attrs *attrs)
+		 unsigned long attrs)
 {
 	return __arm_dma_mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
 }
 
 int arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		 struct dma_attrs *attrs)
+		 unsigned long attrs)
 {
 #ifdef CONFIG_MMU
 	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot);
@@ -878,7 +877,7 @@ int arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
  * Free a buffer as defined by the above mapping.
  */
 static void __arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
-			   dma_addr_t handle, struct dma_attrs *attrs,
+			   dma_addr_t handle, unsigned long attrs,
 			   bool is_coherent)
 {
 	struct page *page = pfn_to_page(dma_to_pfn(dev, handle));
@@ -900,20 +899,20 @@ static void __arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
 }
 
 void arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
-		  dma_addr_t handle, struct dma_attrs *attrs)
+		  dma_addr_t handle, unsigned long attrs)
 {
 	__arm_dma_free(dev, size, cpu_addr, handle, attrs, false);
 }
 
 static void arm_coherent_dma_free(struct device *dev, size_t size, void *cpu_addr,
-				  dma_addr_t handle, struct dma_attrs *attrs)
+				  dma_addr_t handle, unsigned long attrs)
 {
 	__arm_dma_free(dev, size, cpu_addr, handle, attrs, true);
 }
 
 int arm_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 		 void *cpu_addr, dma_addr_t handle, size_t size,
-		 struct dma_attrs *attrs)
+		 unsigned long attrs)
 {
 	struct page *page = pfn_to_page(dma_to_pfn(dev, handle));
 	int ret;
@@ -1046,7 +1045,7 @@ static void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
  * here.
  */
 int arm_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-		enum dma_data_direction dir, struct dma_attrs *attrs)
+		enum dma_data_direction dir, unsigned long attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 	struct scatterlist *s;
@@ -1080,7 +1079,7 @@ int arm_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
  * rules concerning calls here are the same as for dma_unmap_single().
  */
 void arm_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
-		enum dma_data_direction dir, struct dma_attrs *attrs)
+		enum dma_data_direction dir, unsigned long attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 	struct scatterlist *s;
@@ -1253,7 +1252,7 @@ static inline void __free_iova(struct dma_iommu_mapping *mapping,
 static const int iommu_order_array[] = { 9, 8, 4, 0 };
 
 static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
-					  gfp_t gfp, struct dma_attrs *attrs)
+					  gfp_t gfp, unsigned long attrs)
 {
 	struct page **pages;
 	int count = size >> PAGE_SHIFT;
@@ -1342,7 +1341,7 @@ error:
 }
 
 static int __iommu_free_buffer(struct device *dev, struct page **pages,
-			       size_t size, struct dma_attrs *attrs)
+			       size_t size, unsigned long attrs)
 {
 	int count = size >> PAGE_SHIFT;
 	int i;
@@ -1439,7 +1438,7 @@ static struct page **__atomic_get_pages(void *addr)
 	return (struct page **)page;
 }
 
-static struct page **__iommu_get_pages(void *cpu_addr, struct dma_attrs *attrs)
+static struct page **__iommu_get_pages(void *cpu_addr, unsigned long attrs)
 {
 	struct vm_struct *area;
 
@@ -1484,7 +1483,7 @@ static void __iommu_free_atomic(struct device *dev, void *cpu_addr,
 }
 
 static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
-	    dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs)
+	    dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
 {
 	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
 	struct page **pages;
@@ -1532,7 +1531,7 @@ err_buffer:
 
 static int arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 		    void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		    struct dma_attrs *attrs)
+		    unsigned long attrs)
 {
 	unsigned long uaddr = vma->vm_start;
 	unsigned long usize = vma->vm_end - vma->vm_start;
@@ -1568,7 +1567,7 @@ static int arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
  * Must not be called with IRQs disabled.
  */
 void arm_iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
-			  dma_addr_t handle, struct dma_attrs *attrs)
+			  dma_addr_t handle, unsigned long attrs)
 {
 	struct page **pages;
 	size = PAGE_ALIGN(size);
@@ -1595,7 +1594,7 @@ void arm_iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 
 static int arm_iommu_get_sgtable(struct device *dev, struct sg_table *sgt,
 				 void *cpu_addr, dma_addr_t dma_addr,
-				 size_t size, struct dma_attrs *attrs)
+				 size_t size, unsigned long attrs)
 {
 	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	struct page **pages = __iommu_get_pages(cpu_addr, attrs);
@@ -1633,7 +1632,7 @@ static int __dma_direction_to_prot(enum dma_data_direction dir)
  */
 static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
 			  size_t size, dma_addr_t *handle,
-			  enum dma_data_direction dir, struct dma_attrs *attrs,
+			  enum dma_data_direction dir, unsigned long attrs,
 			  bool is_coherent)
 {
 	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
@@ -1676,7 +1675,7 @@ fail:
 }
 
 static int __iommu_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-		     enum dma_data_direction dir, struct dma_attrs *attrs,
+		     enum dma_data_direction dir, unsigned long attrs,
 		     bool is_coherent)
 {
 	struct scatterlist *s = sg, *dma = sg, *start = sg;
@@ -1734,7 +1733,7 @@ bad_mapping:
  * obtained via sg_dma_{address,length}.
  */
 int arm_coherent_iommu_map_sg(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, struct dma_attrs *attrs)
+		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
 	return __iommu_map_sg(dev, sg, nents, dir, attrs, true);
 }
@@ -1752,14 +1751,14 @@ int arm_coherent_iommu_map_sg(struct device *dev, struct scatterlist *sg,
  * sg_dma_{address,length}.
  */
 int arm_iommu_map_sg(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, struct dma_attrs *attrs)
+		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
 	return __iommu_map_sg(dev, sg, nents, dir, attrs, false);
 }
 
 static void __iommu_unmap_sg(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, struct dma_attrs *attrs,
-		bool is_coherent)
+		int nents, enum dma_data_direction dir,
+		unsigned long attrs, bool is_coherent)
 {
 	struct scatterlist *s;
 	int i;
@@ -1786,7 +1785,8 @@ static void __iommu_unmap_sg(struct device *dev, struct scatterlist *sg,
  * rules concerning calls here are the same as for dma_unmap_single().
  */
 void arm_coherent_iommu_unmap_sg(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, struct dma_attrs *attrs)
+		int nents, enum dma_data_direction dir,
+		unsigned long attrs)
 {
 	__iommu_unmap_sg(dev, sg, nents, dir, attrs, true);
 }
@@ -1802,7 +1802,8 @@ void arm_coherent_iommu_unmap_sg(struct device *dev, struct scatterlist *sg,
  * rules concerning calls here are the same as for dma_unmap_single().
  */
 void arm_iommu_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
-			enum dma_data_direction dir, struct dma_attrs *attrs)
+			enum dma_data_direction dir,
+			unsigned long attrs)
 {
 	__iommu_unmap_sg(dev, sg, nents, dir, attrs, false);
 }
@@ -1855,7 +1856,7 @@ void arm_iommu_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
  */
 static dma_addr_t arm_coherent_iommu_map_page(struct device *dev, struct page *page,
 	     unsigned long offset, size_t size, enum dma_data_direction dir,
-	     struct dma_attrs *attrs)
+	     unsigned long attrs)
 {
 	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
 	dma_addr_t dma_addr;
@@ -1889,7 +1890,7 @@ fail:
  */
 static dma_addr_t arm_iommu_map_page(struct device *dev, struct page *page,
 	     unsigned long offset, size_t size, enum dma_data_direction dir,
-	     struct dma_attrs *attrs)
+	     unsigned long attrs)
 {
 	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
 		__dma_page_cpu_to_dev(page, offset, size, dir);
@@ -1907,8 +1908,7 @@ static dma_addr_t arm_iommu_map_page(struct device *dev, struct page *page,
  * Coherent IOMMU aware version of arm_dma_unmap_page()
  */
 static void arm_coherent_iommu_unmap_page(struct device *dev, dma_addr_t handle,
-		size_t size, enum dma_data_direction dir,
-		struct dma_attrs *attrs)
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
 	dma_addr_t iova = handle & PAGE_MASK;
@@ -1932,8 +1932,7 @@ static void arm_coherent_iommu_unmap_page(struct device *dev, dma_addr_t handle,
  * IOMMU aware version of arm_dma_unmap_page()
  */
 static void arm_iommu_unmap_page(struct device *dev, dma_addr_t handle,
-		size_t size, enum dma_data_direction dir,
-		struct dma_attrs *attrs)
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
 	dma_addr_t iova = handle & PAGE_MASK;
@@ -1944,6 +1943,7 @@ static void arm_iommu_unmap_page(struct device *dev, dma_addr_t handle,
 	if (!iova)
 		return;
 
+	// FIXME: replace get with simple check
 	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
 		__dma_page_dev_to_cpu(page, offset, size, dir);
 
diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index c5f9a9e3d1f3..fc67ed236a10 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -98,7 +98,7 @@ static void __xen_dma_page_cpu_to_dev(struct device *hwdev, dma_addr_t handle,
 
 void __xen_dma_map_page(struct device *hwdev, struct page *page,
 	     dma_addr_t dev_addr, unsigned long offset, size_t size,
-	     enum dma_data_direction dir, struct dma_attrs *attrs)
+	     enum dma_data_direction dir, unsigned long attrs)
 {
 	if (is_device_dma_coherent(hwdev))
 		return;
@@ -110,7 +110,7 @@ void __xen_dma_map_page(struct device *hwdev, struct page *page,
 
 void __xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir,
-		struct dma_attrs *attrs)
+		unsigned long attrs)
 
 {
 	if (is_device_dma_coherent(hwdev))
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index c566ec83719f..a7686028dfeb 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -29,7 +29,7 @@
 
 #include <asm/cacheflush.h>
 
-static pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t prot,
+static pgprot_t __get_dma_pgprot(unsigned long attrs, pgprot_t prot,
 				 bool coherent)
 {
 	if (!coherent || dma_get_attr(DMA_ATTR_WRITE_COMBINE, attrs))
@@ -88,7 +88,7 @@ static int __free_from_pool(void *start, size_t size)
 
 static void *__dma_alloc_coherent(struct device *dev, size_t size,
 				  dma_addr_t *dma_handle, gfp_t flags,
-				  struct dma_attrs *attrs)
+				  unsigned long attrs)
 {
 	if (dev == NULL) {
 		WARN_ONCE(1, "Use an actual device structure for DMA allocation\n");
@@ -118,7 +118,7 @@ static void *__dma_alloc_coherent(struct device *dev, size_t size,
 
 static void __dma_free_coherent(struct device *dev, size_t size,
 				void *vaddr, dma_addr_t dma_handle,
-				struct dma_attrs *attrs)
+				unsigned long attrs)
 {
 	bool freed;
 	phys_addr_t paddr = dma_to_phys(dev, dma_handle);
@@ -137,7 +137,7 @@ static void __dma_free_coherent(struct device *dev, size_t size,
 
 static void *__dma_alloc(struct device *dev, size_t size,
 			 dma_addr_t *dma_handle, gfp_t flags,
-			 struct dma_attrs *attrs)
+			 unsigned long attrs)
 {
 	struct page *page;
 	void *ptr, *coherent_ptr;
@@ -185,7 +185,7 @@ no_mem:
 
 static void __dma_free(struct device *dev, size_t size,
 		       void *vaddr, dma_addr_t dma_handle,
-		       struct dma_attrs *attrs)
+		       unsigned long attrs)
 {
 	void *swiotlb_addr = phys_to_virt(dma_to_phys(dev, dma_handle));
 
@@ -202,7 +202,7 @@ static void __dma_free(struct device *dev, size_t size,
 static dma_addr_t __swiotlb_map_page(struct device *dev, struct page *page,
 				     unsigned long offset, size_t size,
 				     enum dma_data_direction dir,
-				     struct dma_attrs *attrs)
+				     unsigned long attrs)
 {
 	dma_addr_t dev_addr;
 
@@ -216,7 +216,7 @@ static dma_addr_t __swiotlb_map_page(struct device *dev, struct page *page,
 
 static void __swiotlb_unmap_page(struct device *dev, dma_addr_t dev_addr,
 				 size_t size, enum dma_data_direction dir,
-				 struct dma_attrs *attrs)
+				 unsigned long attrs)
 {
 	if (!is_device_dma_coherent(dev))
 		__dma_unmap_area(phys_to_virt(dma_to_phys(dev, dev_addr)), size, dir);
@@ -225,7 +225,7 @@ static void __swiotlb_unmap_page(struct device *dev, dma_addr_t dev_addr,
 
 static int __swiotlb_map_sg_attrs(struct device *dev, struct scatterlist *sgl,
 				  int nelems, enum dma_data_direction dir,
-				  struct dma_attrs *attrs)
+				  unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i, ret;
@@ -242,7 +242,7 @@ static int __swiotlb_map_sg_attrs(struct device *dev, struct scatterlist *sgl,
 static void __swiotlb_unmap_sg_attrs(struct device *dev,
 				     struct scatterlist *sgl, int nelems,
 				     enum dma_data_direction dir,
-				     struct dma_attrs *attrs)
+				     unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i;
@@ -303,7 +303,7 @@ static void __swiotlb_sync_sg_for_device(struct device *dev,
 static int __swiotlb_mmap(struct device *dev,
 			  struct vm_area_struct *vma,
 			  void *cpu_addr, dma_addr_t dma_addr, size_t size,
-			  struct dma_attrs *attrs)
+			  unsigned long attrs)
 {
 	int ret = -ENXIO;
 	unsigned long nr_vma_pages = (vma->vm_end - vma->vm_start) >>
@@ -330,7 +330,7 @@ static int __swiotlb_mmap(struct device *dev,
 
 static int __swiotlb_get_sgtable(struct device *dev, struct sg_table *sgt,
 				 void *cpu_addr, dma_addr_t handle, size_t size,
-				 struct dma_attrs *attrs)
+				 unsigned long attrs)
 {
 	int ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
 
@@ -425,21 +425,21 @@ out:
 
 static void *__dummy_alloc(struct device *dev, size_t size,
 			   dma_addr_t *dma_handle, gfp_t flags,
-			   struct dma_attrs *attrs)
+			   unsigned long attrs)
 {
 	return NULL;
 }
 
 static void __dummy_free(struct device *dev, size_t size,
 			 void *vaddr, dma_addr_t dma_handle,
-			 struct dma_attrs *attrs)
+			 unsigned long attrs)
 {
 }
 
 static int __dummy_mmap(struct device *dev,
 			struct vm_area_struct *vma,
 			void *cpu_addr, dma_addr_t dma_addr, size_t size,
-			struct dma_attrs *attrs)
+			unsigned long attrs)
 {
 	return -ENXIO;
 }
@@ -447,20 +447,20 @@ static int __dummy_mmap(struct device *dev,
 static dma_addr_t __dummy_map_page(struct device *dev, struct page *page,
 				   unsigned long offset, size_t size,
 				   enum dma_data_direction dir,
-				   struct dma_attrs *attrs)
+				   unsigned long attrs)
 {
 	return DMA_ERROR_CODE;
 }
 
 static void __dummy_unmap_page(struct device *dev, dma_addr_t dev_addr,
 			       size_t size, enum dma_data_direction dir,
-			       struct dma_attrs *attrs)
+			       unsigned long attrs)
 {
 }
 
 static int __dummy_map_sg(struct device *dev, struct scatterlist *sgl,
 			  int nelems, enum dma_data_direction dir,
-			  struct dma_attrs *attrs)
+			  unsigned long attrs)
 {
 	return 0;
 }
@@ -468,7 +468,7 @@ static int __dummy_map_sg(struct device *dev, struct scatterlist *sgl,
 static void __dummy_unmap_sg(struct device *dev,
 			     struct scatterlist *sgl, int nelems,
 			     enum dma_data_direction dir,
-			     struct dma_attrs *attrs)
+			     unsigned long attrs)
 {
 }
 
@@ -540,7 +540,7 @@ static void flush_page(struct device *dev, const void *virt, phys_addr_t phys)
 
 static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 				 dma_addr_t *handle, gfp_t gfp,
-				 struct dma_attrs *attrs)
+				 unsigned long attrs)
 {
 	bool coherent = is_device_dma_coherent(dev);
 	int ioprot = dma_direction_to_prot(DMA_BIDIRECTIONAL, coherent);
@@ -600,7 +600,8 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 }
 
 static void __iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
-			       dma_addr_t handle, struct dma_attrs *attrs)
+			       dma_addr_t handle,
+			       unsigned long attrs)
 {
 	size_t iosize = size;
 
@@ -616,7 +617,7 @@ static void __iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 	 * Hence how dodgy the below logic looks...
 	 */
 	if (__in_atomic_pool(cpu_addr, size)) {
-		iommu_dma_unmap_page(dev, handle, iosize, 0, NULL);
+		iommu_dma_unmap_page(dev, handle, iosize, 0, 0);
 		__free_from_pool(cpu_addr, size);
 	} else if (is_vmalloc_addr(cpu_addr)){
 		struct vm_struct *area = find_vm_area(cpu_addr);
@@ -626,14 +627,14 @@ static void __iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 		iommu_dma_free(dev, area->pages, iosize, &handle);
 		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
 	} else {
-		iommu_dma_unmap_page(dev, handle, iosize, 0, NULL);
+		iommu_dma_unmap_page(dev, handle, iosize, 0, 0);
 		__free_pages(virt_to_page(cpu_addr), get_order(size));
 	}
 }
 
 static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 			      void *cpu_addr, dma_addr_t dma_addr, size_t size,
-			      struct dma_attrs *attrs)
+			      unsigned long attrs)
 {
 	struct vm_struct *area;
 	int ret;
@@ -653,7 +654,7 @@ static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 
 static int __iommu_get_sgtable(struct device *dev, struct sg_table *sgt,
 			       void *cpu_addr, dma_addr_t dma_addr,
-			       size_t size, struct dma_attrs *attrs)
+			       size_t size, unsigned long attrs)
 {
 	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	struct vm_struct *area = find_vm_area(cpu_addr);
@@ -694,7 +695,7 @@ static void __iommu_sync_single_for_device(struct device *dev,
 static dma_addr_t __iommu_map_page(struct device *dev, struct page *page,
 				   unsigned long offset, size_t size,
 				   enum dma_data_direction dir,
-				   struct dma_attrs *attrs)
+				   unsigned long attrs)
 {
 	bool coherent = is_device_dma_coherent(dev);
 	int prot = dma_direction_to_prot(dir, coherent);
@@ -709,7 +710,7 @@ static dma_addr_t __iommu_map_page(struct device *dev, struct page *page,
 
 static void __iommu_unmap_page(struct device *dev, dma_addr_t dev_addr,
 			       size_t size, enum dma_data_direction dir,
-			       struct dma_attrs *attrs)
+			       unsigned long attrs)
 {
 	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
 		__iommu_sync_single_for_cpu(dev, dev_addr, size, dir);
@@ -747,7 +748,7 @@ static void __iommu_sync_sg_for_device(struct device *dev,
 
 static int __iommu_map_sg_attrs(struct device *dev, struct scatterlist *sgl,
 				int nelems, enum dma_data_direction dir,
-				struct dma_attrs *attrs)
+				unsigned long attrs)
 {
 	bool coherent = is_device_dma_coherent(dev);
 
@@ -761,7 +762,7 @@ static int __iommu_map_sg_attrs(struct device *dev, struct scatterlist *sgl,
 static void __iommu_unmap_sg_attrs(struct device *dev,
 				   struct scatterlist *sgl, int nelems,
 				   enum dma_data_direction dir,
-				   struct dma_attrs *attrs)
+				   unsigned long attrs)
 {
 	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
 		__iommu_sync_sg_for_cpu(dev, sgl, nelems, dir);
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
index 67dcd6831291..dd091175fc2d 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
@@ -52,7 +52,7 @@ static int exynos_drm_fb_mmap(struct fb_info *info,
 
 	ret = dma_mmap_attrs(to_dma_dev(helper->dev), vma, exynos_gem->cookie,
 			     exynos_gem->dma_addr, exynos_gem->size,
-			     &exynos_gem->dma_attrs);
+			     exynos_gem->dma_attrs);
 	if (ret < 0) {
 		DRM_ERROR("failed to mmap.\n");
 		return ret;
diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
index 493552368295..f65e6b7ef93b 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
@@ -17,7 +17,6 @@
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 #include <linux/dma-mapping.h>
-#include <linux/dma-attrs.h>
 #include <linux/of.h>
 
 #include <drm/drmP.h>
diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.c b/drivers/gpu/drm/exynos/exynos_drm_gem.c
index cdf9f1af4347..f2ae72ba7d5a 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gem.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gem.c
@@ -24,7 +24,7 @@
 static int exynos_drm_alloc_buf(struct exynos_drm_gem *exynos_gem)
 {
 	struct drm_device *dev = exynos_gem->base.dev;
-	enum dma_attr attr;
+	unsigned long attr;
 	unsigned int nr_pages;
 	struct sg_table sgt;
 	int ret = -ENOMEM;
@@ -34,7 +34,7 @@ static int exynos_drm_alloc_buf(struct exynos_drm_gem *exynos_gem)
 		return 0;
 	}
 
-	init_dma_attrs(&exynos_gem->dma_attrs);
+	exynos_gem->dma_attrs = 0;
 
 	/*
 	 * if EXYNOS_BO_CONTIG, fully physically contiguous memory
@@ -42,7 +42,7 @@ static int exynos_drm_alloc_buf(struct exynos_drm_gem *exynos_gem)
 	 * as possible.
 	 */
 	if (!(exynos_gem->flags & EXYNOS_BO_NONCONTIG))
-		dma_set_attr(DMA_ATTR_FORCE_CONTIGUOUS, &exynos_gem->dma_attrs);
+		exynos_gem->dma_attrs |= DMA_ATTR_FORCE_CONTIGUOUS;
 
 	/*
 	 * if EXYNOS_BO_WC or EXYNOS_BO_NONCACHABLE, writecombine mapping
@@ -54,8 +54,8 @@ static int exynos_drm_alloc_buf(struct exynos_drm_gem *exynos_gem)
 	else
 		attr = DMA_ATTR_NON_CONSISTENT;
 
-	dma_set_attr(attr, &exynos_gem->dma_attrs);
-	dma_set_attr(DMA_ATTR_NO_KERNEL_MAPPING, &exynos_gem->dma_attrs);
+	exynos_gem->dma_attrs |= attr;
+	exynos_gem->dma_attrs |= DMA_ATTR_NO_KERNEL_MAPPING;
 
 	nr_pages = exynos_gem->size >> PAGE_SHIFT;
 
@@ -67,7 +67,7 @@ static int exynos_drm_alloc_buf(struct exynos_drm_gem *exynos_gem)
 
 	exynos_gem->cookie = dma_alloc_attrs(to_dma_dev(dev), exynos_gem->size,
 					     &exynos_gem->dma_addr, GFP_KERNEL,
-					     &exynos_gem->dma_attrs);
+					     exynos_gem->dma_attrs);
 	if (!exynos_gem->cookie) {
 		DRM_ERROR("failed to allocate buffer.\n");
 		goto err_free;
@@ -75,7 +75,7 @@ static int exynos_drm_alloc_buf(struct exynos_drm_gem *exynos_gem)
 
 	ret = dma_get_sgtable_attrs(to_dma_dev(dev), &sgt, exynos_gem->cookie,
 				    exynos_gem->dma_addr, exynos_gem->size,
-				    &exynos_gem->dma_attrs);
+				    exynos_gem->dma_attrs);
 	if (ret < 0) {
 		DRM_ERROR("failed to get sgtable.\n");
 		goto err_dma_free;
@@ -99,7 +99,7 @@ err_sgt_free:
 	sg_free_table(&sgt);
 err_dma_free:
 	dma_free_attrs(to_dma_dev(dev), exynos_gem->size, exynos_gem->cookie,
-		       exynos_gem->dma_addr, &exynos_gem->dma_attrs);
+		       exynos_gem->dma_addr, exynos_gem->dma_attrs);
 err_free:
 	drm_free_large(exynos_gem->pages);
 
@@ -120,7 +120,7 @@ static void exynos_drm_free_buf(struct exynos_drm_gem *exynos_gem)
 
 	dma_free_attrs(to_dma_dev(dev), exynos_gem->size, exynos_gem->cookie,
 			(dma_addr_t)exynos_gem->dma_addr,
-			&exynos_gem->dma_attrs);
+			exynos_gem->dma_attrs);
 
 	drm_free_large(exynos_gem->pages);
 }
@@ -346,7 +346,7 @@ static int exynos_drm_gem_mmap_buffer(struct exynos_drm_gem *exynos_gem,
 
 	ret = dma_mmap_attrs(to_dma_dev(drm_dev), vma, exynos_gem->cookie,
 			     exynos_gem->dma_addr, exynos_gem->size,
-			     &exynos_gem->dma_attrs);
+			     exynos_gem->dma_attrs);
 	if (ret < 0) {
 		DRM_ERROR("failed to mmap.\n");
 		return ret;
diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.h b/drivers/gpu/drm/exynos/exynos_drm_gem.h
index 78100742281d..df7c543d6558 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gem.h
+++ b/drivers/gpu/drm/exynos/exynos_drm_gem.h
@@ -50,7 +50,7 @@ struct exynos_drm_gem {
 	void			*cookie;
 	void __iomem		*kvaddr;
 	dma_addr_t		dma_addr;
-	struct dma_attrs	dma_attrs;
+	unsigned long		dma_attrs;
 	struct page		**pages;
 	struct sg_table		*sgt;
 };
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index ea5a9ebf0f78..6c1bda504fb1 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -286,7 +286,7 @@ void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
  *	   or NULL on failure.
  */
 struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
-		struct dma_attrs *attrs, int prot, dma_addr_t *handle,
+		unsigned long attrs, int prot, dma_addr_t *handle,
 		void (*flush_page)(struct device *, const void *, phys_addr_t))
 {
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
@@ -400,7 +400,7 @@ dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 }
 
 void iommu_dma_unmap_page(struct device *dev, dma_addr_t handle, size_t size,
-		enum dma_data_direction dir, struct dma_attrs *attrs)
+		enum dma_data_direction dir, unsigned long attrs)
 {
 	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), handle);
 }
@@ -560,7 +560,7 @@ out_restore_sg:
 }
 
 void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
-		enum dma_data_direction dir, struct dma_attrs *attrs)
+		enum dma_data_direction dir, unsigned long attrs)
 {
 	/*
 	 * The scatterlist segments are mapped into a single
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 7399782c0998..87e6035c9e81 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -294,7 +294,7 @@ error:
 void *
 xen_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 			   dma_addr_t *dma_handle, gfp_t flags,
-			   struct dma_attrs *attrs)
+			   unsigned long attrs)
 {
 	void *ret;
 	int order = get_order(size);
@@ -346,7 +346,7 @@ EXPORT_SYMBOL_GPL(xen_swiotlb_alloc_coherent);
 
 void
 xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
-			  dma_addr_t dev_addr, struct dma_attrs *attrs)
+			  dma_addr_t dev_addr, unsigned long attrs)
 {
 	int order = get_order(size);
 	phys_addr_t phys;
@@ -378,7 +378,7 @@ EXPORT_SYMBOL_GPL(xen_swiotlb_free_coherent);
 dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 				unsigned long offset, size_t size,
 				enum dma_data_direction dir,
-				struct dma_attrs *attrs)
+				unsigned long attrs)
 {
 	phys_addr_t map, phys = page_to_phys(page) + offset;
 	dma_addr_t dev_addr = xen_phys_to_bus(phys);
@@ -434,7 +434,7 @@ EXPORT_SYMBOL_GPL(xen_swiotlb_map_page);
  */
 static void xen_unmap_single(struct device *hwdev, dma_addr_t dev_addr,
 			     size_t size, enum dma_data_direction dir,
-				 struct dma_attrs *attrs)
+			     unsigned long attrs)
 {
 	phys_addr_t paddr = xen_bus_to_phys(dev_addr);
 
@@ -462,7 +462,7 @@ static void xen_unmap_single(struct device *hwdev, dma_addr_t dev_addr,
 
 void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
 			    size_t size, enum dma_data_direction dir,
-			    struct dma_attrs *attrs)
+			    unsigned long attrs)
 {
 	xen_unmap_single(hwdev, dev_addr, size, dir, attrs);
 }
@@ -538,7 +538,7 @@ EXPORT_SYMBOL_GPL(xen_swiotlb_sync_single_for_device);
 int
 xen_swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
 			 int nelems, enum dma_data_direction dir,
-			 struct dma_attrs *attrs)
+			 unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i;
@@ -599,7 +599,7 @@ EXPORT_SYMBOL_GPL(xen_swiotlb_map_sg_attrs);
 void
 xen_swiotlb_unmap_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
 			   int nelems, enum dma_data_direction dir,
-			   struct dma_attrs *attrs)
+			   unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i;
diff --git a/include/linux/dma-attrs.h b/include/linux/dma-attrs.h
deleted file mode 100644
index 5246239a4953..000000000000
--- a/include/linux/dma-attrs.h
+++ /dev/null
@@ -1,71 +0,0 @@
-#ifndef _DMA_ATTR_H
-#define _DMA_ATTR_H
-
-#include <linux/bitmap.h>
-#include <linux/bitops.h>
-#include <linux/bug.h>
-
-/**
- * an enum dma_attr represents an attribute associated with a DMA
- * mapping. The semantics of each attribute should be defined in
- * Documentation/DMA-attributes.txt.
- */
-enum dma_attr {
-	DMA_ATTR_WRITE_BARRIER,
-	DMA_ATTR_WEAK_ORDERING,
-	DMA_ATTR_WRITE_COMBINE,
-	DMA_ATTR_NON_CONSISTENT,
-	DMA_ATTR_NO_KERNEL_MAPPING,
-	DMA_ATTR_SKIP_CPU_SYNC,
-	DMA_ATTR_FORCE_CONTIGUOUS,
-	DMA_ATTR_ALLOC_SINGLE_PAGES,
-	DMA_ATTR_MAX,
-};
-
-#define __DMA_ATTRS_LONGS BITS_TO_LONGS(DMA_ATTR_MAX)
-
-/**
- * struct dma_attrs - an opaque container for DMA attributes
- * @flags - bitmask representing a collection of enum dma_attr
- */
-struct dma_attrs {
-	unsigned long flags[__DMA_ATTRS_LONGS];
-};
-
-#define DEFINE_DMA_ATTRS(x) 					\
-	struct dma_attrs x = {					\
-		.flags = { [0 ... __DMA_ATTRS_LONGS-1] = 0 },	\
-	}
-
-static inline void init_dma_attrs(struct dma_attrs *attrs)
-{
-	bitmap_zero(attrs->flags, __DMA_ATTRS_LONGS);
-}
-
-/**
- * dma_set_attr - set a specific attribute
- * @attr: attribute to set
- * @attrs: struct dma_attrs (may be NULL)
- */
-static inline void dma_set_attr(enum dma_attr attr, struct dma_attrs *attrs)
-{
-	if (attrs == NULL)
-		return;
-	BUG_ON(attr >= DMA_ATTR_MAX);
-	__set_bit(attr, attrs->flags);
-}
-
-/**
- * dma_get_attr - check for a specific attribute
- * @attr: attribute to set
- * @attrs: struct dma_attrs (may be NULL)
- */
-static inline int dma_get_attr(enum dma_attr attr, struct dma_attrs *attrs)
-{
-	if (attrs == NULL)
-		return 0;
-	BUG_ON(attr >= DMA_ATTR_MAX);
-	return test_bit(attr, attrs->flags);
-}
-
-#endif /* _DMA_ATTR_H */
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 8443bbb5c071..81c5c8d167ad 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -39,7 +39,7 @@ int dma_direction_to_prot(enum dma_data_direction dir, bool coherent);
  * the arch code to take care of attributes and cache maintenance
  */
 struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
-		struct dma_attrs *attrs, int prot, dma_addr_t *handle,
+		unsigned long attrs, int prot, dma_addr_t *handle,
 		void (*flush_page)(struct device *, const void *, phys_addr_t));
 void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
 		dma_addr_t *handle);
@@ -56,9 +56,9 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
  * directly as DMA mapping callbacks for simplicity
  */
 void iommu_dma_unmap_page(struct device *dev, dma_addr_t handle, size_t size,
-		enum dma_data_direction dir, struct dma_attrs *attrs);
+		enum dma_data_direction dir, unsigned long attrs);
 void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
-		enum dma_data_direction dir, struct dma_attrs *attrs);
+		enum dma_data_direction dir, unsigned long attrs);
 int iommu_dma_supported(struct device *dev, u64 mask);
 int iommu_dma_mapping_error(struct device *dev, dma_addr_t dma_addr);
 
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 71c1b215ef66..19e581d5f8b4 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -5,13 +5,25 @@
 #include <linux/string.h>
 #include <linux/device.h>
 #include <linux/err.h>
-#include <linux/dma-attrs.h>
 #include <linux/dma-debug.h>
 #include <linux/dma-direction.h>
 #include <linux/scatterlist.h>
 #include <linux/kmemcheck.h>
 #include <linux/bug.h>
 
+/**
+ * List of possible attributes associated with a DMA mapping. The semantics
+ * of each attribute should be defined in Documentation/DMA-attributes.txt.
+ */
+#define DMA_ATTR_WRITE_BARRIER		BIT(1)
+#define DMA_ATTR_WEAK_ORDERING		BIT(2)
+#define DMA_ATTR_WRITE_COMBINE		BIT(3)
+#define DMA_ATTR_NON_CONSISTENT		BIT(4)
+#define DMA_ATTR_NO_KERNEL_MAPPING	BIT(5)
+#define DMA_ATTR_SKIP_CPU_SYNC		BIT(6)
+#define DMA_ATTR_FORCE_CONTIGUOUS	BIT(7)
+#define DMA_ATTR_ALLOC_SINGLE_PAGES	BIT(8)
+
 /*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.
  * It can be given to a device to use as a DMA source or target.  A CPU cannot
@@ -21,34 +33,35 @@
 struct dma_map_ops {
 	void* (*alloc)(struct device *dev, size_t size,
 				dma_addr_t *dma_handle, gfp_t gfp,
-				struct dma_attrs *attrs);
+				unsigned long attrs);
 	void (*free)(struct device *dev, size_t size,
 			      void *vaddr, dma_addr_t dma_handle,
-			      struct dma_attrs *attrs);
+			      unsigned long attrs);
 	int (*mmap)(struct device *, struct vm_area_struct *,
-			  void *, dma_addr_t, size_t, struct dma_attrs *attrs);
+			  void *, dma_addr_t, size_t,
+			  unsigned long attrs);
 
 	int (*get_sgtable)(struct device *dev, struct sg_table *sgt, void *,
-			   dma_addr_t, size_t, struct dma_attrs *attrs);
+			   dma_addr_t, size_t, unsigned long attrs);
 
 	dma_addr_t (*map_page)(struct device *dev, struct page *page,
 			       unsigned long offset, size_t size,
 			       enum dma_data_direction dir,
-			       struct dma_attrs *attrs);
+			       unsigned long attrs);
 	void (*unmap_page)(struct device *dev, dma_addr_t dma_handle,
 			   size_t size, enum dma_data_direction dir,
-			   struct dma_attrs *attrs);
+			   unsigned long attrs);
 	/*
 	 * map_sg returns 0 on error and a value > 0 on success.
 	 * It should never return a value < 0.
 	 */
 	int (*map_sg)(struct device *dev, struct scatterlist *sg,
 		      int nents, enum dma_data_direction dir,
-		      struct dma_attrs *attrs);
+		      unsigned long attrs);
 	void (*unmap_sg)(struct device *dev,
 			 struct scatterlist *sg, int nents,
 			 enum dma_data_direction dir,
-			 struct dma_attrs *attrs);
+			 unsigned long attrs);
 	void (*sync_single_for_cpu)(struct device *dev,
 				    dma_addr_t dma_handle, size_t size,
 				    enum dma_data_direction dir);
@@ -88,6 +101,16 @@ static inline int is_device_dma_capable(struct device *dev)
 	return dev->dma_mask != NULL && *dev->dma_mask != DMA_MASK_NONE;
 }
 
+/**
+ * dma_get_attr - check for a specific attribute
+ * @attr: attribute to look for
+ * @attrs: attributes to check within
+ */
+static inline bool dma_get_attr(unsigned long attr, unsigned long attrs)
+{
+	return !!(attr & attrs);
+}
+
 #ifdef CONFIG_HAVE_GENERIC_DMA_COHERENT
 /*
  * These three functions are only for dma allocator.
@@ -123,7 +146,7 @@ static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
 					      size_t size,
 					      enum dma_data_direction dir,
-					      struct dma_attrs *attrs)
+					      unsigned long attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 	dma_addr_t addr;
@@ -142,7 +165,7 @@ static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
 static inline void dma_unmap_single_attrs(struct device *dev, dma_addr_t addr,
 					  size_t size,
 					  enum dma_data_direction dir,
-					  struct dma_attrs *attrs)
+					  unsigned long attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 
@@ -158,7 +181,7 @@ static inline void dma_unmap_single_attrs(struct device *dev, dma_addr_t addr,
  */
 static inline int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 				   int nents, enum dma_data_direction dir,
-				   struct dma_attrs *attrs)
+				   unsigned long attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 	int i, ents;
@@ -176,7 +199,7 @@ static inline int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 
 static inline void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
 				      int nents, enum dma_data_direction dir,
-				      struct dma_attrs *attrs)
+				      unsigned long attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 
@@ -195,7 +218,7 @@ static inline dma_addr_t dma_map_page(struct device *dev, struct page *page,
 
 	kmemcheck_mark_initialized(page_address(page) + offset, size);
 	BUG_ON(!valid_dma_direction(dir));
-	addr = ops->map_page(dev, page, offset, size, dir, NULL);
+	addr = ops->map_page(dev, page, offset, size, dir, 0);
 	debug_dma_map_page(dev, page, offset, size, dir, addr, false);
 
 	return addr;
@@ -208,7 +231,7 @@ static inline void dma_unmap_page(struct device *dev, dma_addr_t addr,
 
 	BUG_ON(!valid_dma_direction(dir));
 	if (ops->unmap_page)
-		ops->unmap_page(dev, addr, size, dir, NULL);
+		ops->unmap_page(dev, addr, size, dir, 0);
 	debug_dma_unmap_page(dev, addr, size, dir, false);
 }
 
@@ -289,10 +312,10 @@ dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 
 }
 
-#define dma_map_single(d, a, s, r) dma_map_single_attrs(d, a, s, r, NULL)
-#define dma_unmap_single(d, a, s, r) dma_unmap_single_attrs(d, a, s, r, NULL)
-#define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, NULL)
-#define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, NULL)
+#define dma_map_single(d, a, s, r) dma_map_single_attrs(d, a, s, r, 0)
+#define dma_unmap_single(d, a, s, r) dma_unmap_single_attrs(d, a, s, r, 0)
+#define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, 0)
+#define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
 
 extern int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 			   void *cpu_addr, dma_addr_t dma_addr, size_t size);
@@ -321,7 +344,7 @@ void dma_common_free_remap(void *cpu_addr, size_t size, unsigned long vm_flags);
  */
 static inline int
 dma_mmap_attrs(struct device *dev, struct vm_area_struct *vma, void *cpu_addr,
-	       dma_addr_t dma_addr, size_t size, struct dma_attrs *attrs)
+	       dma_addr_t dma_addr, size_t size, unsigned long attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 	BUG_ON(!ops);
@@ -330,7 +353,7 @@ dma_mmap_attrs(struct device *dev, struct vm_area_struct *vma, void *cpu_addr,
 	return dma_common_mmap(dev, vma, cpu_addr, dma_addr, size);
 }
 
-#define dma_mmap_coherent(d, v, c, h, s) dma_mmap_attrs(d, v, c, h, s, NULL)
+#define dma_mmap_coherent(d, v, c, h, s) dma_mmap_attrs(d, v, c, h, s, 0)
 
 int
 dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
@@ -338,7 +361,8 @@ dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
 
 static inline int
 dma_get_sgtable_attrs(struct device *dev, struct sg_table *sgt, void *cpu_addr,
-		      dma_addr_t dma_addr, size_t size, struct dma_attrs *attrs)
+		      dma_addr_t dma_addr, size_t size,
+		      unsigned long attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 	BUG_ON(!ops);
@@ -348,7 +372,7 @@ dma_get_sgtable_attrs(struct device *dev, struct sg_table *sgt, void *cpu_addr,
 	return dma_common_get_sgtable(dev, sgt, cpu_addr, dma_addr, size);
 }
 
-#define dma_get_sgtable(d, t, v, h, s) dma_get_sgtable_attrs(d, t, v, h, s, NULL)
+#define dma_get_sgtable(d, t, v, h, s) dma_get_sgtable_attrs(d, t, v, h, s, 0)
 
 #ifndef arch_dma_alloc_attrs
 #define arch_dma_alloc_attrs(dev, flag)	(true)
@@ -356,7 +380,7 @@ dma_get_sgtable_attrs(struct device *dev, struct sg_table *sgt, void *cpu_addr,
 
 static inline void *dma_alloc_attrs(struct device *dev, size_t size,
 				       dma_addr_t *dma_handle, gfp_t flag,
-				       struct dma_attrs *attrs)
+				       unsigned long attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 	void *cpu_addr;
@@ -378,7 +402,7 @@ static inline void *dma_alloc_attrs(struct device *dev, size_t size,
 
 static inline void dma_free_attrs(struct device *dev, size_t size,
 				     void *cpu_addr, dma_addr_t dma_handle,
-				     struct dma_attrs *attrs)
+				     unsigned long attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 
@@ -398,31 +422,27 @@ static inline void dma_free_attrs(struct device *dev, size_t size,
 static inline void *dma_alloc_coherent(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t flag)
 {
-	return dma_alloc_attrs(dev, size, dma_handle, flag, NULL);
+	return dma_alloc_attrs(dev, size, dma_handle, flag, 0);
 }
 
 static inline void dma_free_coherent(struct device *dev, size_t size,
 		void *cpu_addr, dma_addr_t dma_handle)
 {
-	return dma_free_attrs(dev, size, cpu_addr, dma_handle, NULL);
+	return dma_free_attrs(dev, size, cpu_addr, dma_handle, 0);
 }
 
 static inline void *dma_alloc_noncoherent(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp)
 {
-	DEFINE_DMA_ATTRS(attrs);
-
-	dma_set_attr(DMA_ATTR_NON_CONSISTENT, &attrs);
-	return dma_alloc_attrs(dev, size, dma_handle, gfp, &attrs);
+	return dma_alloc_attrs(dev, size, dma_handle, gfp,
+			       DMA_ATTR_NON_CONSISTENT);
 }
 
 static inline void dma_free_noncoherent(struct device *dev, size_t size,
 		void *cpu_addr, dma_addr_t dma_handle)
 {
-	DEFINE_DMA_ATTRS(attrs);
-
-	dma_set_attr(DMA_ATTR_NON_CONSISTENT, &attrs);
-	dma_free_attrs(dev, size, cpu_addr, dma_handle, &attrs);
+	dma_free_attrs(dev, size, cpu_addr, dma_handle,
+		       DMA_ATTR_NON_CONSISTENT);
 }
 
 static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
@@ -646,9 +666,8 @@ static inline void dmam_release_declared_memory(struct device *dev)
 static inline void *dma_alloc_wc(struct device *dev, size_t size,
 				 dma_addr_t *dma_addr, gfp_t gfp)
 {
-	DEFINE_DMA_ATTRS(attrs);
-	dma_set_attr(DMA_ATTR_WRITE_COMBINE, &attrs);
-	return dma_alloc_attrs(dev, size, dma_addr, gfp, &attrs);
+	return dma_alloc_attrs(dev, size, dma_addr, gfp,
+			       DMA_ATTR_WRITE_COMBINE);
 }
 #ifndef dma_alloc_writecombine
 #define dma_alloc_writecombine dma_alloc_wc
@@ -657,9 +676,8 @@ static inline void *dma_alloc_wc(struct device *dev, size_t size,
 static inline void dma_free_wc(struct device *dev, size_t size,
 			       void *cpu_addr, dma_addr_t dma_addr)
 {
-	DEFINE_DMA_ATTRS(attrs);
-	dma_set_attr(DMA_ATTR_WRITE_COMBINE, &attrs);
-	return dma_free_attrs(dev, size, cpu_addr, dma_addr, &attrs);
+	return dma_free_attrs(dev, size, cpu_addr, dma_addr,
+			      DMA_ATTR_WRITE_COMBINE);
 }
 #ifndef dma_free_writecombine
 #define dma_free_writecombine dma_free_wc
@@ -670,9 +688,8 @@ static inline int dma_mmap_wc(struct device *dev,
 			      void *cpu_addr, dma_addr_t dma_addr,
 			      size_t size)
 {
-	DEFINE_DMA_ATTRS(attrs);
-	dma_set_attr(DMA_ATTR_WRITE_COMBINE, &attrs);
-	return dma_mmap_attrs(dev, vma, cpu_addr, dma_addr, size, &attrs);
+	return dma_mmap_attrs(dev, vma, cpu_addr, dma_addr, size,
+			      DMA_ATTR_WRITE_COMBINE);
 }
 #ifndef dma_mmap_writecombine
 #define dma_mmap_writecombine dma_mmap_wc
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 017fced60242..5f81f8a187f2 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -6,7 +6,6 @@
 #include <linux/types.h>
 
 struct device;
-struct dma_attrs;
 struct page;
 struct scatterlist;
 
@@ -68,10 +67,10 @@ swiotlb_free_coherent(struct device *hwdev, size_t size,
 extern dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
 				   unsigned long offset, size_t size,
 				   enum dma_data_direction dir,
-				   struct dma_attrs *attrs);
+				   unsigned long attrs);
 extern void swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
 			       size_t size, enum dma_data_direction dir,
-			       struct dma_attrs *attrs);
+			       unsigned long attrs);
 
 extern int
 swiotlb_map_sg(struct device *hwdev, struct scatterlist *sg, int nents,
@@ -83,12 +82,13 @@ swiotlb_unmap_sg(struct device *hwdev, struct scatterlist *sg, int nents,
 
 extern int
 swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl, int nelems,
-		     enum dma_data_direction dir, struct dma_attrs *attrs);
+		     enum dma_data_direction dir,
+		     unsigned long attrs);
 
 extern void
 swiotlb_unmap_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
 		       int nelems, enum dma_data_direction dir,
-		       struct dma_attrs *attrs);
+		       unsigned long attrs);
 
 extern void
 swiotlb_sync_single_for_cpu(struct device *hwdev, dma_addr_t dev_addr,
diff --git a/include/xen/swiotlb-xen.h b/include/xen/swiotlb-xen.h
index 8b2eb93ae8ba..7c35e279d1e3 100644
--- a/include/xen/swiotlb-xen.h
+++ b/include/xen/swiotlb-xen.h
@@ -9,30 +9,30 @@ extern int xen_swiotlb_init(int verbose, bool early);
 extern void
 *xen_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 			    dma_addr_t *dma_handle, gfp_t flags,
-			    struct dma_attrs *attrs);
+			    unsigned long attrs);
 
 extern void
 xen_swiotlb_free_coherent(struct device *hwdev, size_t size,
 			  void *vaddr, dma_addr_t dma_handle,
-			  struct dma_attrs *attrs);
+			  unsigned long attrs);
 
 extern dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 				       unsigned long offset, size_t size,
 				       enum dma_data_direction dir,
-				       struct dma_attrs *attrs);
+				       unsigned long attrs);
 
 extern void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
 				   size_t size, enum dma_data_direction dir,
-				   struct dma_attrs *attrs);
+				   unsigned long attrs);
 extern int
 xen_swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
 			 int nelems, enum dma_data_direction dir,
-			 struct dma_attrs *attrs);
+			 unsigned long attrs);
 
 extern void
 xen_swiotlb_unmap_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
 			   int nelems, enum dma_data_direction dir,
-			   struct dma_attrs *attrs);
+			   unsigned long attrs);
 
 extern void
 xen_swiotlb_sync_single_for_cpu(struct device *hwdev, dma_addr_t dev_addr,
diff --git a/lib/dma-noop.c b/lib/dma-noop.c
index 72145646857e..3d766e78fbe2 100644
--- a/lib/dma-noop.c
+++ b/lib/dma-noop.c
@@ -10,7 +10,7 @@
 
 static void *dma_noop_alloc(struct device *dev, size_t size,
 			    dma_addr_t *dma_handle, gfp_t gfp,
-			    struct dma_attrs *attrs)
+			    unsigned long attrs)
 {
 	void *ret;
 
@@ -22,7 +22,7 @@ static void *dma_noop_alloc(struct device *dev, size_t size,
 
 static void dma_noop_free(struct device *dev, size_t size,
 			  void *cpu_addr, dma_addr_t dma_addr,
-			  struct dma_attrs *attrs)
+			  unsigned long attrs)
 {
 	free_pages((unsigned long)cpu_addr, get_order(size));
 }
@@ -30,13 +30,14 @@ static void dma_noop_free(struct device *dev, size_t size,
 static dma_addr_t dma_noop_map_page(struct device *dev, struct page *page,
 				      unsigned long offset, size_t size,
 				      enum dma_data_direction dir,
-				      struct dma_attrs *attrs)
+				      unsigned long attrs)
 {
 	return page_to_phys(page) + offset;
 }
 
 static int dma_noop_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
-			     enum dma_data_direction dir, struct dma_attrs *attrs)
+			     enum dma_data_direction dir,
+			     unsigned long attrs)
 {
 	int i;
 	struct scatterlist *sg;
diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 76f29ecba8f4..22e13a0e19d7 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -738,7 +738,7 @@ swiotlb_full(struct device *dev, size_t size, enum dma_data_direction dir,
 dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
 			    unsigned long offset, size_t size,
 			    enum dma_data_direction dir,
-			    struct dma_attrs *attrs)
+			    unsigned long attrs)
 {
 	phys_addr_t map, phys = page_to_phys(page) + offset;
 	dma_addr_t dev_addr = phys_to_dma(dev, phys);
@@ -807,7 +807,7 @@ static void unmap_single(struct device *hwdev, dma_addr_t dev_addr,
 
 void swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
 			size_t size, enum dma_data_direction dir,
-			struct dma_attrs *attrs)
+			unsigned long attrs)
 {
 	unmap_single(hwdev, dev_addr, size, dir);
 }
@@ -877,7 +877,7 @@ EXPORT_SYMBOL(swiotlb_sync_single_for_device);
  */
 int
 swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl, int nelems,
-		     enum dma_data_direction dir, struct dma_attrs *attrs)
+		     enum dma_data_direction dir, unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i;
@@ -914,7 +914,7 @@ int
 swiotlb_map_sg(struct device *hwdev, struct scatterlist *sgl, int nelems,
 	       enum dma_data_direction dir)
 {
-	return swiotlb_map_sg_attrs(hwdev, sgl, nelems, dir, NULL);
+	return swiotlb_map_sg_attrs(hwdev, sgl, nelems, dir, 0);
 }
 EXPORT_SYMBOL(swiotlb_map_sg);
 
@@ -924,7 +924,8 @@ EXPORT_SYMBOL(swiotlb_map_sg);
  */
 void
 swiotlb_unmap_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
-		       int nelems, enum dma_data_direction dir, struct dma_attrs *attrs)
+		       int nelems, enum dma_data_direction dir,
+		       unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i;
@@ -941,7 +942,7 @@ void
 swiotlb_unmap_sg(struct device *hwdev, struct scatterlist *sgl, int nelems,
 		 enum dma_data_direction dir)
 {
-	return swiotlb_unmap_sg_attrs(hwdev, sgl, nelems, dir, NULL);
+	return swiotlb_unmap_sg_attrs(hwdev, sgl, nelems, dir, 0);
 }
 EXPORT_SYMBOL(swiotlb_unmap_sg);
 
-- 
1.9.1
