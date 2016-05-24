From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [RFC 4/4] dma-mapping: Constify dma_attrs
Date: Tue, 24 May 2016 08:28:10 +0200
Message-ID: <1464071290-15948-5-git-send-email-k.kozlowski@samsung.com>
References: <1464071290-15948-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1464071290-15948-1-git-send-email-k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Stefano Stabellini <sstabellini-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Pointer to dma_attrs passed to all dma-mapping implementations can point
to const data. This brings some benefits:
 - const-safeness,
 - is a direct indication that ownership of memory is not transferred to
   called functions so it can be safely allocated on the stack (which is
   a pattern already used).

Please have in mind that this is RFC, not finished yet. Only ARM and
ARM64 are fixed. However other API users also have to be converted which
is quite intrusive. I would rather avoid it until the overall approach
is accepted.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/include/asm/dma-mapping.h | 12 ++++----
 arch/arm/mm/dma-mapping.c          | 61 +++++++++++++++++++++-----------------
 arch/arm/xen/mm.c                  |  4 +--
 arch/arm64/mm/dma-mapping.c        | 47 +++++++++++++++--------------
 drivers/iommu/dma-iommu.c          |  6 ++--
 include/linux/dma-iommu.h          |  6 ++--
 include/linux/dma-mapping.h        | 34 +++++++++++----------
 include/linux/swiotlb.h            |  9 +++---
 lib/dma-noop.c                     |  9 +++---
 lib/swiotlb.c                      |  9 +++---
 10 files changed, 104 insertions(+), 93 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index a83570f10124..07202beed663 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -174,7 +174,7 @@ static inline void dma_mark_clean(void *addr, size_t size) { }
  * to be the device-viewed address.
  */
 extern void *arm_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
-			   gfp_t gfp, struct dma_attrs *attrs);
+			   gfp_t gfp, const struct dma_attrs *attrs);
 
 /**
  * arm_dma_free - free memory allocated by arm_dma_alloc
@@ -191,7 +191,7 @@ extern void *arm_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
  * during and after this call executing are illegal.
  */
 extern void arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
-			 dma_addr_t handle, struct dma_attrs *attrs);
+			 dma_addr_t handle, const struct dma_attrs *attrs);
 
 /**
  * arm_dma_mmap - map a coherent DMA allocation into user space
@@ -208,7 +208,7 @@ extern void arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
  */
 extern int arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 			void *cpu_addr, dma_addr_t dma_addr, size_t size,
-			struct dma_attrs *attrs);
+			const struct dma_attrs *attrs);
 
 /*
  * This can be called during early boot to increase the size of the atomic
@@ -262,16 +262,16 @@ extern void dmabounce_unregister_dev(struct device *);
  * The scatter list versions of the above methods.
  */
 extern int arm_dma_map_sg(struct device *, struct scatterlist *, int,
-		enum dma_data_direction, struct dma_attrs *attrs);
+		enum dma_data_direction, const struct dma_attrs *attrs);
 extern void arm_dma_unmap_sg(struct device *, struct scatterlist *, int,
-		enum dma_data_direction, struct dma_attrs *attrs);
+		enum dma_data_direction, const struct dma_attrs *attrs);
 extern void arm_dma_sync_sg_for_cpu(struct device *, struct scatterlist *, int,
 		enum dma_data_direction);
 extern void arm_dma_sync_sg_for_device(struct device *, struct scatterlist *, int,
 		enum dma_data_direction);
 extern int arm_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		struct dma_attrs *attrs);
+		const struct dma_attrs *attrs);
 
 #endif /* __KERNEL__ */
 #endif
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 4abc50952451..245954e7e343 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -124,7 +124,7 @@ static void __dma_page_dev_to_cpu(struct page *, unsigned long,
  */
 static dma_addr_t arm_dma_map_page(struct device *dev, struct page *page,
 	     unsigned long offset, size_t size, enum dma_data_direction dir,
-	     struct dma_attrs *attrs)
+	     const struct dma_attrs *attrs)
 {
 	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
 		__dma_page_cpu_to_dev(page, offset, size, dir);
@@ -133,7 +133,7 @@ static dma_addr_t arm_dma_map_page(struct device *dev, struct page *page,
 
 static dma_addr_t arm_coherent_dma_map_page(struct device *dev, struct page *page,
 	     unsigned long offset, size_t size, enum dma_data_direction dir,
-	     struct dma_attrs *attrs)
+	     const struct dma_attrs *attrs)
 {
 	return pfn_to_dma(dev, page_to_pfn(page)) + offset;
 }
@@ -154,7 +154,7 @@ static dma_addr_t arm_coherent_dma_map_page(struct device *dev, struct page *pag
  */
 static void arm_dma_unmap_page(struct device *dev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir,
-		struct dma_attrs *attrs)
+		const struct dma_attrs *attrs)
 {
 	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
 		__dma_page_dev_to_cpu(pfn_to_page(dma_to_pfn(dev, handle)),
@@ -194,12 +194,13 @@ struct dma_map_ops arm_dma_ops = {
 EXPORT_SYMBOL(arm_dma_ops);
 
 static void *arm_coherent_dma_alloc(struct device *dev, size_t size,
-	dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs);
+	dma_addr_t *handle, gfp_t gfp, const struct dma_attrs *attrs);
 static void arm_coherent_dma_free(struct device *dev, size_t size, void *cpu_addr,
-				  dma_addr_t handle, struct dma_attrs *attrs);
+				  dma_addr_t handle,
+				  const struct dma_attrs *attrs);
 static int arm_coherent_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		 struct dma_attrs *attrs);
+		 const struct dma_attrs *attrs);
 
 struct dma_map_ops arm_coherent_dma_ops = {
 	.alloc			= arm_coherent_dma_alloc,
@@ -814,7 +815,7 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
  * virtual and bus address for that space.
  */
 void *arm_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
-		    gfp_t gfp, struct dma_attrs *attrs)
+		    gfp_t gfp, const struct dma_attrs *attrs)
 {
 	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
 
@@ -823,7 +824,7 @@ void *arm_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 }
 
 static void *arm_coherent_dma_alloc(struct device *dev, size_t size,
-	dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs)
+	dma_addr_t *handle, gfp_t gfp, const struct dma_attrs *attrs)
 {
 	return __dma_alloc(dev, size, handle, gfp, PAGE_KERNEL, true,
 			   attrs, __builtin_return_address(0));
@@ -831,7 +832,7 @@ static void *arm_coherent_dma_alloc(struct device *dev, size_t size,
 
 static int __arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		 struct dma_attrs *attrs)
+		 const struct dma_attrs *attrs)
 {
 	int ret = -ENXIO;
 #ifdef CONFIG_MMU
@@ -859,14 +860,14 @@ static int __arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
  */
 static int arm_coherent_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		 struct dma_attrs *attrs)
+		 const struct dma_attrs *attrs)
 {
 	return __arm_dma_mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
 }
 
 int arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		 struct dma_attrs *attrs)
+		 const struct dma_attrs *attrs)
 {
 #ifdef CONFIG_MMU
 	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot);
@@ -900,20 +901,20 @@ static void __arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
 }
 
 void arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
-		  dma_addr_t handle, struct dma_attrs *attrs)
+		  dma_addr_t handle, const struct dma_attrs *attrs)
 {
 	__arm_dma_free(dev, size, cpu_addr, handle, attrs, false);
 }
 
 static void arm_coherent_dma_free(struct device *dev, size_t size, void *cpu_addr,
-				  dma_addr_t handle, struct dma_attrs *attrs)
+				  dma_addr_t handle, const struct dma_attrs *attrs)
 {
 	__arm_dma_free(dev, size, cpu_addr, handle, attrs, true);
 }
 
 int arm_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 		 void *cpu_addr, dma_addr_t handle, size_t size,
-		 struct dma_attrs *attrs)
+		 const struct dma_attrs *attrs)
 {
 	struct page *page = pfn_to_page(dma_to_pfn(dev, handle));
 	int ret;
@@ -1046,7 +1047,7 @@ static void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
  * here.
  */
 int arm_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-		enum dma_data_direction dir, struct dma_attrs *attrs)
+		enum dma_data_direction dir, const struct dma_attrs *attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 	struct scatterlist *s;
@@ -1080,7 +1081,7 @@ int arm_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
  * rules concerning calls here are the same as for dma_unmap_single().
  */
 void arm_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
-		enum dma_data_direction dir, struct dma_attrs *attrs)
+		enum dma_data_direction dir, const struct dma_attrs *attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 	struct scatterlist *s;
@@ -1486,7 +1487,7 @@ static void __iommu_free_atomic(struct device *dev, void *cpu_addr,
 }
 
 static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
-	    dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs)
+	    dma_addr_t *handle, gfp_t gfp, const struct dma_attrs *attrs)
 {
 	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
 	struct page **pages;
@@ -1534,7 +1535,7 @@ err_buffer:
 
 static int arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 		    void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		    struct dma_attrs *attrs)
+		    const struct dma_attrs *attrs)
 {
 	unsigned long uaddr = vma->vm_start;
 	unsigned long usize = vma->vm_end - vma->vm_start;
@@ -1570,7 +1571,7 @@ static int arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
  * Must not be called with IRQs disabled.
  */
 void arm_iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
-			  dma_addr_t handle, struct dma_attrs *attrs)
+			  dma_addr_t handle, const struct dma_attrs *attrs)
 {
 	struct page **pages;
 	size = PAGE_ALIGN(size);
@@ -1597,7 +1598,7 @@ void arm_iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 
 static int arm_iommu_get_sgtable(struct device *dev, struct sg_table *sgt,
 				 void *cpu_addr, dma_addr_t dma_addr,
-				 size_t size, struct dma_attrs *attrs)
+				 size_t size, const struct dma_attrs *attrs)
 {
 	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	struct page **pages = __iommu_get_pages(cpu_addr, attrs);
@@ -1736,7 +1737,8 @@ bad_mapping:
  * obtained via sg_dma_{address,length}.
  */
 int arm_coherent_iommu_map_sg(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, struct dma_attrs *attrs)
+		int nents, enum dma_data_direction dir,
+		const struct dma_attrs *attrs)
 {
 	return __iommu_map_sg(dev, sg, nents, dir, attrs, true);
 }
@@ -1754,7 +1756,8 @@ int arm_coherent_iommu_map_sg(struct device *dev, struct scatterlist *sg,
  * sg_dma_{address,length}.
  */
 int arm_iommu_map_sg(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, struct dma_attrs *attrs)
+		int nents, enum dma_data_direction dir,
+		const struct dma_attrs *attrs)
 {
 	return __iommu_map_sg(dev, sg, nents, dir, attrs, false);
 }
@@ -1788,7 +1791,8 @@ static void __iommu_unmap_sg(struct device *dev, struct scatterlist *sg,
  * rules concerning calls here are the same as for dma_unmap_single().
  */
 void arm_coherent_iommu_unmap_sg(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, struct dma_attrs *attrs)
+		int nents, enum dma_data_direction dir,
+		const struct dma_attrs *attrs)
 {
 	__iommu_unmap_sg(dev, sg, nents, dir, attrs, true);
 }
@@ -1804,7 +1808,8 @@ void arm_coherent_iommu_unmap_sg(struct device *dev, struct scatterlist *sg,
  * rules concerning calls here are the same as for dma_unmap_single().
  */
 void arm_iommu_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
-			enum dma_data_direction dir, struct dma_attrs *attrs)
+			enum dma_data_direction dir,
+			const struct dma_attrs *attrs)
 {
 	__iommu_unmap_sg(dev, sg, nents, dir, attrs, false);
 }
@@ -1857,7 +1862,7 @@ void arm_iommu_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
  */
 static dma_addr_t arm_coherent_iommu_map_page(struct device *dev, struct page *page,
 	     unsigned long offset, size_t size, enum dma_data_direction dir,
-	     struct dma_attrs *attrs)
+	     const struct dma_attrs *attrs)
 {
 	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
 	dma_addr_t dma_addr;
@@ -1891,7 +1896,7 @@ fail:
  */
 static dma_addr_t arm_iommu_map_page(struct device *dev, struct page *page,
 	     unsigned long offset, size_t size, enum dma_data_direction dir,
-	     struct dma_attrs *attrs)
+	     const struct dma_attrs *attrs)
 {
 	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
 		__dma_page_cpu_to_dev(page, offset, size, dir);
@@ -1910,7 +1915,7 @@ static dma_addr_t arm_iommu_map_page(struct device *dev, struct page *page,
  */
 static void arm_coherent_iommu_unmap_page(struct device *dev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir,
-		struct dma_attrs *attrs)
+		const struct dma_attrs *attrs)
 {
 	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
 	dma_addr_t iova = handle & PAGE_MASK;
@@ -1935,7 +1940,7 @@ static void arm_coherent_iommu_unmap_page(struct device *dev, dma_addr_t handle,
  */
 static void arm_iommu_unmap_page(struct device *dev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir,
-		struct dma_attrs *attrs)
+		const struct dma_attrs *attrs)
 {
 	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
 	dma_addr_t iova = handle & PAGE_MASK;
diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index c5f9a9e3d1f3..0af2fbbc25be 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -98,7 +98,7 @@ static void __xen_dma_page_cpu_to_dev(struct device *hwdev, dma_addr_t handle,
 
 void __xen_dma_map_page(struct device *hwdev, struct page *page,
 	     dma_addr_t dev_addr, unsigned long offset, size_t size,
-	     enum dma_data_direction dir, struct dma_attrs *attrs)
+	     enum dma_data_direction dir, const struct dma_attrs *attrs)
 {
 	if (is_device_dma_coherent(hwdev))
 		return;
@@ -110,7 +110,7 @@ void __xen_dma_map_page(struct device *hwdev, struct page *page,
 
 void __xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir,
-		struct dma_attrs *attrs)
+		const struct dma_attrs *attrs)
 
 {
 	if (is_device_dma_coherent(hwdev))
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 0ef620a34c4e..9f6c6b12db30 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -137,7 +137,7 @@ static void __dma_free_coherent(struct device *dev, size_t size,
 
 static void *__dma_alloc(struct device *dev, size_t size,
 			 dma_addr_t *dma_handle, gfp_t flags,
-			 struct dma_attrs *attrs)
+			 const struct dma_attrs *attrs)
 {
 	struct page *page;
 	void *ptr, *coherent_ptr;
@@ -185,7 +185,7 @@ no_mem:
 
 static void __dma_free(struct device *dev, size_t size,
 		       void *vaddr, dma_addr_t dma_handle,
-		       struct dma_attrs *attrs)
+		       const struct dma_attrs *attrs)
 {
 	void *swiotlb_addr = phys_to_virt(dma_to_phys(dev, dma_handle));
 
@@ -202,7 +202,7 @@ static void __dma_free(struct device *dev, size_t size,
 static dma_addr_t __swiotlb_map_page(struct device *dev, struct page *page,
 				     unsigned long offset, size_t size,
 				     enum dma_data_direction dir,
-				     struct dma_attrs *attrs)
+				     const struct dma_attrs *attrs)
 {
 	dma_addr_t dev_addr;
 
@@ -216,7 +216,7 @@ static dma_addr_t __swiotlb_map_page(struct device *dev, struct page *page,
 
 static void __swiotlb_unmap_page(struct device *dev, dma_addr_t dev_addr,
 				 size_t size, enum dma_data_direction dir,
-				 struct dma_attrs *attrs)
+				 const struct dma_attrs *attrs)
 {
 	if (!is_device_dma_coherent(dev))
 		__dma_unmap_area(phys_to_virt(dma_to_phys(dev, dev_addr)), size, dir);
@@ -225,7 +225,7 @@ static void __swiotlb_unmap_page(struct device *dev, dma_addr_t dev_addr,
 
 static int __swiotlb_map_sg_attrs(struct device *dev, struct scatterlist *sgl,
 				  int nelems, enum dma_data_direction dir,
-				  struct dma_attrs *attrs)
+				  const struct dma_attrs *attrs)
 {
 	struct scatterlist *sg;
 	int i, ret;
@@ -242,7 +242,7 @@ static int __swiotlb_map_sg_attrs(struct device *dev, struct scatterlist *sgl,
 static void __swiotlb_unmap_sg_attrs(struct device *dev,
 				     struct scatterlist *sgl, int nelems,
 				     enum dma_data_direction dir,
-				     struct dma_attrs *attrs)
+				     const struct dma_attrs *attrs)
 {
 	struct scatterlist *sg;
 	int i;
@@ -303,7 +303,7 @@ static void __swiotlb_sync_sg_for_device(struct device *dev,
 static int __swiotlb_mmap(struct device *dev,
 			  struct vm_area_struct *vma,
 			  void *cpu_addr, dma_addr_t dma_addr, size_t size,
-			  struct dma_attrs *attrs)
+			  const struct dma_attrs *attrs)
 {
 	int ret = -ENXIO;
 	unsigned long nr_vma_pages = (vma->vm_end - vma->vm_start) >>
@@ -330,7 +330,7 @@ static int __swiotlb_mmap(struct device *dev,
 
 static int __swiotlb_get_sgtable(struct device *dev, struct sg_table *sgt,
 				 void *cpu_addr, dma_addr_t handle, size_t size,
-				 struct dma_attrs *attrs)
+				 const struct dma_attrs *attrs)
 {
 	int ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
 
@@ -425,21 +425,21 @@ out:
 
 static void *__dummy_alloc(struct device *dev, size_t size,
 			   dma_addr_t *dma_handle, gfp_t flags,
-			   struct dma_attrs *attrs)
+			   const struct dma_attrs *attrs)
 {
 	return NULL;
 }
 
 static void __dummy_free(struct device *dev, size_t size,
 			 void *vaddr, dma_addr_t dma_handle,
-			 struct dma_attrs *attrs)
+			 const struct dma_attrs *attrs)
 {
 }
 
 static int __dummy_mmap(struct device *dev,
 			struct vm_area_struct *vma,
 			void *cpu_addr, dma_addr_t dma_addr, size_t size,
-			struct dma_attrs *attrs)
+			const struct dma_attrs *attrs)
 {
 	return -ENXIO;
 }
@@ -447,20 +447,20 @@ static int __dummy_mmap(struct device *dev,
 static dma_addr_t __dummy_map_page(struct device *dev, struct page *page,
 				   unsigned long offset, size_t size,
 				   enum dma_data_direction dir,
-				   struct dma_attrs *attrs)
+				   const struct dma_attrs *attrs)
 {
 	return DMA_ERROR_CODE;
 }
 
 static void __dummy_unmap_page(struct device *dev, dma_addr_t dev_addr,
 			       size_t size, enum dma_data_direction dir,
-			       struct dma_attrs *attrs)
+			       const struct dma_attrs *attrs)
 {
 }
 
 static int __dummy_map_sg(struct device *dev, struct scatterlist *sgl,
 			  int nelems, enum dma_data_direction dir,
-			  struct dma_attrs *attrs)
+			  const struct dma_attrs *attrs)
 {
 	return 0;
 }
@@ -468,7 +468,7 @@ static int __dummy_map_sg(struct device *dev, struct scatterlist *sgl,
 static void __dummy_unmap_sg(struct device *dev,
 			     struct scatterlist *sgl, int nelems,
 			     enum dma_data_direction dir,
-			     struct dma_attrs *attrs)
+			     const struct dma_attrs *attrs)
 {
 }
 
@@ -540,7 +540,7 @@ static void flush_page(struct device *dev, const void *virt, phys_addr_t phys)
 
 static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 				 dma_addr_t *handle, gfp_t gfp,
-				 struct dma_attrs *attrs)
+				 const struct dma_attrs *attrs)
 {
 	bool coherent = is_device_dma_coherent(dev);
 	int ioprot = dma_direction_to_prot(DMA_BIDIRECTIONAL, coherent);
@@ -600,7 +600,8 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 }
 
 static void __iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
-			       dma_addr_t handle, struct dma_attrs *attrs)
+			       dma_addr_t handle,
+			       const struct dma_attrs *attrs)
 {
 	size_t iosize = size;
 
@@ -633,7 +634,7 @@ static void __iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 
 static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 			      void *cpu_addr, dma_addr_t dma_addr, size_t size,
-			      struct dma_attrs *attrs)
+			      const struct dma_attrs *attrs)
 {
 	struct vm_struct *area;
 	int ret;
@@ -653,7 +654,7 @@ static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 
 static int __iommu_get_sgtable(struct device *dev, struct sg_table *sgt,
 			       void *cpu_addr, dma_addr_t dma_addr,
-			       size_t size, struct dma_attrs *attrs)
+			       size_t size, const struct dma_attrs *attrs)
 {
 	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	struct vm_struct *area = find_vm_area(cpu_addr);
@@ -694,7 +695,7 @@ static void __iommu_sync_single_for_device(struct device *dev,
 static dma_addr_t __iommu_map_page(struct device *dev, struct page *page,
 				   unsigned long offset, size_t size,
 				   enum dma_data_direction dir,
-				   struct dma_attrs *attrs)
+				   const struct dma_attrs *attrs)
 {
 	bool coherent = is_device_dma_coherent(dev);
 	int prot = dma_direction_to_prot(dir, coherent);
@@ -709,7 +710,7 @@ static dma_addr_t __iommu_map_page(struct device *dev, struct page *page,
 
 static void __iommu_unmap_page(struct device *dev, dma_addr_t dev_addr,
 			       size_t size, enum dma_data_direction dir,
-			       struct dma_attrs *attrs)
+			       const struct dma_attrs *attrs)
 {
 	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
 		__iommu_sync_single_for_cpu(dev, dev_addr, size, dir);
@@ -747,7 +748,7 @@ static void __iommu_sync_sg_for_device(struct device *dev,
 
 static int __iommu_map_sg_attrs(struct device *dev, struct scatterlist *sgl,
 				int nelems, enum dma_data_direction dir,
-				struct dma_attrs *attrs)
+				const struct dma_attrs *attrs)
 {
 	bool coherent = is_device_dma_coherent(dev);
 
@@ -761,7 +762,7 @@ static int __iommu_map_sg_attrs(struct device *dev, struct scatterlist *sgl,
 static void __iommu_unmap_sg_attrs(struct device *dev,
 				   struct scatterlist *sgl, int nelems,
 				   enum dma_data_direction dir,
-				   struct dma_attrs *attrs)
+				   const struct dma_attrs *attrs)
 {
 	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
 		__iommu_sync_sg_for_cpu(dev, sgl, nelems, dir);
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index ea5a9ebf0f78..69eb1fdce971 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -286,7 +286,7 @@ void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
  *	   or NULL on failure.
  */
 struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
-		struct dma_attrs *attrs, int prot, dma_addr_t *handle,
+		const struct dma_attrs *attrs, int prot, dma_addr_t *handle,
 		void (*flush_page)(struct device *, const void *, phys_addr_t))
 {
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
@@ -400,7 +400,7 @@ dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 }
 
 void iommu_dma_unmap_page(struct device *dev, dma_addr_t handle, size_t size,
-		enum dma_data_direction dir, struct dma_attrs *attrs)
+		enum dma_data_direction dir, const struct dma_attrs *attrs)
 {
 	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), handle);
 }
@@ -560,7 +560,7 @@ out_restore_sg:
 }
 
 void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
-		enum dma_data_direction dir, struct dma_attrs *attrs)
+		enum dma_data_direction dir, const struct dma_attrs *attrs)
 {
 	/*
 	 * The scatterlist segments are mapped into a single
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 8443bbb5c071..797b47bc6dae 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -39,7 +39,7 @@ int dma_direction_to_prot(enum dma_data_direction dir, bool coherent);
  * the arch code to take care of attributes and cache maintenance
  */
 struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
-		struct dma_attrs *attrs, int prot, dma_addr_t *handle,
+		const struct dma_attrs *attrs, int prot, dma_addr_t *handle,
 		void (*flush_page)(struct device *, const void *, phys_addr_t));
 void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
 		dma_addr_t *handle);
@@ -56,9 +56,9 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
  * directly as DMA mapping callbacks for simplicity
  */
 void iommu_dma_unmap_page(struct device *dev, dma_addr_t handle, size_t size,
-		enum dma_data_direction dir, struct dma_attrs *attrs);
+		enum dma_data_direction dir, const struct dma_attrs *attrs);
 void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
-		enum dma_data_direction dir, struct dma_attrs *attrs);
+		enum dma_data_direction dir, const struct dma_attrs *attrs);
 int iommu_dma_supported(struct device *dev, u64 mask);
 int iommu_dma_mapping_error(struct device *dev, dma_addr_t dma_addr);
 
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 71c1b215ef66..c8b339436dfa 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -21,34 +21,35 @@
 struct dma_map_ops {
 	void* (*alloc)(struct device *dev, size_t size,
 				dma_addr_t *dma_handle, gfp_t gfp,
-				struct dma_attrs *attrs);
+				const struct dma_attrs *attrs);
 	void (*free)(struct device *dev, size_t size,
 			      void *vaddr, dma_addr_t dma_handle,
-			      struct dma_attrs *attrs);
+			      const struct dma_attrs *attrs);
 	int (*mmap)(struct device *, struct vm_area_struct *,
-			  void *, dma_addr_t, size_t, struct dma_attrs *attrs);
+			  void *, dma_addr_t, size_t,
+			  const struct dma_attrs *attrs);
 
 	int (*get_sgtable)(struct device *dev, struct sg_table *sgt, void *,
-			   dma_addr_t, size_t, struct dma_attrs *attrs);
+			   dma_addr_t, size_t, const struct dma_attrs *attrs);
 
 	dma_addr_t (*map_page)(struct device *dev, struct page *page,
 			       unsigned long offset, size_t size,
 			       enum dma_data_direction dir,
-			       struct dma_attrs *attrs);
+			       const struct dma_attrs *attrs);
 	void (*unmap_page)(struct device *dev, dma_addr_t dma_handle,
 			   size_t size, enum dma_data_direction dir,
-			   struct dma_attrs *attrs);
+			   const struct dma_attrs *attrs);
 	/*
 	 * map_sg returns 0 on error and a value > 0 on success.
 	 * It should never return a value < 0.
 	 */
 	int (*map_sg)(struct device *dev, struct scatterlist *sg,
 		      int nents, enum dma_data_direction dir,
-		      struct dma_attrs *attrs);
+		      const struct dma_attrs *attrs);
 	void (*unmap_sg)(struct device *dev,
 			 struct scatterlist *sg, int nents,
 			 enum dma_data_direction dir,
-			 struct dma_attrs *attrs);
+			 const struct dma_attrs *attrs);
 	void (*sync_single_for_cpu)(struct device *dev,
 				    dma_addr_t dma_handle, size_t size,
 				    enum dma_data_direction dir);
@@ -123,7 +124,7 @@ static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
 					      size_t size,
 					      enum dma_data_direction dir,
-					      struct dma_attrs *attrs)
+					      const struct dma_attrs *attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 	dma_addr_t addr;
@@ -142,7 +143,7 @@ static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
 static inline void dma_unmap_single_attrs(struct device *dev, dma_addr_t addr,
 					  size_t size,
 					  enum dma_data_direction dir,
-					  struct dma_attrs *attrs)
+					  const struct dma_attrs *attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 
@@ -158,7 +159,7 @@ static inline void dma_unmap_single_attrs(struct device *dev, dma_addr_t addr,
  */
 static inline int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 				   int nents, enum dma_data_direction dir,
-				   struct dma_attrs *attrs)
+				   const struct dma_attrs *attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 	int i, ents;
@@ -176,7 +177,7 @@ static inline int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 
 static inline void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
 				      int nents, enum dma_data_direction dir,
-				      struct dma_attrs *attrs)
+				      const struct dma_attrs *attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 
@@ -321,7 +322,7 @@ void dma_common_free_remap(void *cpu_addr, size_t size, unsigned long vm_flags);
  */
 static inline int
 dma_mmap_attrs(struct device *dev, struct vm_area_struct *vma, void *cpu_addr,
-	       dma_addr_t dma_addr, size_t size, struct dma_attrs *attrs)
+	       dma_addr_t dma_addr, size_t size, const struct dma_attrs *attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 	BUG_ON(!ops);
@@ -338,7 +339,8 @@ dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
 
 static inline int
 dma_get_sgtable_attrs(struct device *dev, struct sg_table *sgt, void *cpu_addr,
-		      dma_addr_t dma_addr, size_t size, struct dma_attrs *attrs)
+		      dma_addr_t dma_addr, size_t size,
+		      const struct dma_attrs *attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 	BUG_ON(!ops);
@@ -356,7 +358,7 @@ dma_get_sgtable_attrs(struct device *dev, struct sg_table *sgt, void *cpu_addr,
 
 static inline void *dma_alloc_attrs(struct device *dev, size_t size,
 				       dma_addr_t *dma_handle, gfp_t flag,
-				       struct dma_attrs *attrs)
+				       const struct dma_attrs *attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 	void *cpu_addr;
@@ -378,7 +380,7 @@ static inline void *dma_alloc_attrs(struct device *dev, size_t size,
 
 static inline void dma_free_attrs(struct device *dev, size_t size,
 				     void *cpu_addr, dma_addr_t dma_handle,
-				     struct dma_attrs *attrs)
+				     const struct dma_attrs *attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 017fced60242..0ff87d75982b 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -68,10 +68,10 @@ swiotlb_free_coherent(struct device *hwdev, size_t size,
 extern dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
 				   unsigned long offset, size_t size,
 				   enum dma_data_direction dir,
-				   struct dma_attrs *attrs);
+				   const struct dma_attrs *attrs);
 extern void swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
 			       size_t size, enum dma_data_direction dir,
-			       struct dma_attrs *attrs);
+			       const struct dma_attrs *attrs);
 
 extern int
 swiotlb_map_sg(struct device *hwdev, struct scatterlist *sg, int nents,
@@ -83,12 +83,13 @@ swiotlb_unmap_sg(struct device *hwdev, struct scatterlist *sg, int nents,
 
 extern int
 swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl, int nelems,
-		     enum dma_data_direction dir, struct dma_attrs *attrs);
+		     enum dma_data_direction dir,
+		     const struct dma_attrs *attrs);
 
 extern void
 swiotlb_unmap_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
 		       int nelems, enum dma_data_direction dir,
-		       struct dma_attrs *attrs);
+		       const struct dma_attrs *attrs);
 
 extern void
 swiotlb_sync_single_for_cpu(struct device *hwdev, dma_addr_t dev_addr,
diff --git a/lib/dma-noop.c b/lib/dma-noop.c
index 72145646857e..22e44fc26eba 100644
--- a/lib/dma-noop.c
+++ b/lib/dma-noop.c
@@ -10,7 +10,7 @@
 
 static void *dma_noop_alloc(struct device *dev, size_t size,
 			    dma_addr_t *dma_handle, gfp_t gfp,
-			    struct dma_attrs *attrs)
+			    const struct dma_attrs *attrs)
 {
 	void *ret;
 
@@ -22,7 +22,7 @@ static void *dma_noop_alloc(struct device *dev, size_t size,
 
 static void dma_noop_free(struct device *dev, size_t size,
 			  void *cpu_addr, dma_addr_t dma_addr,
-			  struct dma_attrs *attrs)
+			  const struct dma_attrs *attrs)
 {
 	free_pages((unsigned long)cpu_addr, get_order(size));
 }
@@ -30,13 +30,14 @@ static void dma_noop_free(struct device *dev, size_t size,
 static dma_addr_t dma_noop_map_page(struct device *dev, struct page *page,
 				      unsigned long offset, size_t size,
 				      enum dma_data_direction dir,
-				      struct dma_attrs *attrs)
+				      const struct dma_attrs *attrs)
 {
 	return page_to_phys(page) + offset;
 }
 
 static int dma_noop_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
-			     enum dma_data_direction dir, struct dma_attrs *attrs)
+			     enum dma_data_direction dir,
+			     const struct dma_attrs *attrs)
 {
 	int i;
 	struct scatterlist *sg;
diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 76f29ecba8f4..f881405d0b17 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -738,7 +738,7 @@ swiotlb_full(struct device *dev, size_t size, enum dma_data_direction dir,
 dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
 			    unsigned long offset, size_t size,
 			    enum dma_data_direction dir,
-			    struct dma_attrs *attrs)
+			    const struct dma_attrs *attrs)
 {
 	phys_addr_t map, phys = page_to_phys(page) + offset;
 	dma_addr_t dev_addr = phys_to_dma(dev, phys);
@@ -807,7 +807,7 @@ static void unmap_single(struct device *hwdev, dma_addr_t dev_addr,
 
 void swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
 			size_t size, enum dma_data_direction dir,
-			struct dma_attrs *attrs)
+			const struct dma_attrs *attrs)
 {
 	unmap_single(hwdev, dev_addr, size, dir);
 }
@@ -877,7 +877,7 @@ EXPORT_SYMBOL(swiotlb_sync_single_for_device);
  */
 int
 swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl, int nelems,
-		     enum dma_data_direction dir, struct dma_attrs *attrs)
+		     enum dma_data_direction dir, const struct dma_attrs *attrs)
 {
 	struct scatterlist *sg;
 	int i;
@@ -924,7 +924,8 @@ EXPORT_SYMBOL(swiotlb_map_sg);
  */
 void
 swiotlb_unmap_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
-		       int nelems, enum dma_data_direction dir, struct dma_attrs *attrs)
+		       int nelems, enum dma_data_direction dir,
+		       const struct dma_attrs *attrs)
 {
 	struct scatterlist *sg;
 	int i;
-- 
1.9.1
