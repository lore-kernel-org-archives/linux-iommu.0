From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [RFC PATCH 1/5] arm64: Combine coherent and non-coherent swiotlb
	dma_ops
Date: Mon, 12 Jan 2015 20:48:53 +0000
Message-ID: <8e1a2cdd9eeb9e0733b752d3b4319d0f83a196f4.1421086706.git.robin.murphy@arm.com>
References: <cover.1421086706.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1421086706.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, stefano.stabellini-mvvWK6WmYclDPfheJLI6IQ@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>

Since dev_archdata now has a dma_coherent state, combine the two
coherent and non-coherent operations and remove their declaration,
together with set_dma_ops, from the arch dma-mapping.h file.

Signed-off-by: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
---
 arch/arm64/include/asm/dma-mapping.h |  11 +---
 arch/arm64/mm/dma-mapping.c          | 116 ++++++++++++++++-------------------
 2 files changed, 54 insertions(+), 73 deletions(-)

diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index 9ce3e68..6932bb5 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -28,8 +28,6 @@
 
 #define DMA_ERROR_CODE	(~(dma_addr_t)0)
 extern struct dma_map_ops *dma_ops;
-extern struct dma_map_ops coherent_swiotlb_dma_ops;
-extern struct dma_map_ops noncoherent_swiotlb_dma_ops;
 
 static inline struct dma_map_ops *__generic_dma_ops(struct device *dev)
 {
@@ -47,23 +45,18 @@ static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 		return __generic_dma_ops(dev);
 }
 
-static inline void set_dma_ops(struct device *dev, struct dma_map_ops *ops)
-{
-	dev->archdata.dma_ops = ops;
-}
-
 static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 				      struct iommu_ops *iommu, bool coherent)
 {
 	dev->archdata.dma_coherent = coherent;
-	if (coherent)
-		set_dma_ops(dev, &coherent_swiotlb_dma_ops);
 }
 #define arch_setup_dma_ops	arch_setup_dma_ops
 
 /* do not use this function in a driver */
 static inline bool is_device_dma_coherent(struct device *dev)
 {
+	if (!dev)
+		return false;
 	return dev->archdata.dma_coherent;
 }
 
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index d920942..0a24b9b 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -134,16 +134,17 @@ static void __dma_free_coherent(struct device *dev, size_t size,
 		swiotlb_free_coherent(dev, size, vaddr, dma_handle);
 }
 
-static void *__dma_alloc_noncoherent(struct device *dev, size_t size,
-				     dma_addr_t *dma_handle, gfp_t flags,
-				     struct dma_attrs *attrs)
+static void *__dma_alloc(struct device *dev, size_t size,
+			 dma_addr_t *dma_handle, gfp_t flags,
+			 struct dma_attrs *attrs)
 {
 	struct page *page;
 	void *ptr, *coherent_ptr;
+	bool coherent = is_device_dma_coherent(dev);
 
 	size = PAGE_ALIGN(size);
 
-	if (!(flags & __GFP_WAIT)) {
+	if (!coherent && !(flags & __GFP_WAIT)) {
 		struct page *page = NULL;
 		void *addr = __alloc_from_pool(size, &page);
 
@@ -151,13 +152,16 @@ static void *__dma_alloc_noncoherent(struct device *dev, size_t size,
 			*dma_handle = phys_to_dma(dev, page_to_phys(page));
 
 		return addr;
-
 	}
 
 	ptr = __dma_alloc_coherent(dev, size, dma_handle, flags, attrs);
 	if (!ptr)
 		goto no_mem;
 
+	/* no need for non-cacheable mapping if coherent */
+	if (coherent)
+		return ptr;
+
 	/* remove any dirty cache lines on the kernel alias */
 	__dma_flush_range(ptr, ptr + size);
 
@@ -179,15 +183,17 @@ no_mem:
 	return NULL;
 }
 
-static void __dma_free_noncoherent(struct device *dev, size_t size,
-				   void *vaddr, dma_addr_t dma_handle,
-				   struct dma_attrs *attrs)
+static void __dma_free(struct device *dev, size_t size,
+		       void *vaddr, dma_addr_t dma_handle,
+		       struct dma_attrs *attrs)
 {
 	void *swiotlb_addr = phys_to_virt(dma_to_phys(dev, dma_handle));
 
-	if (__free_from_pool(vaddr, size))
-		return;
-	vunmap(vaddr);
+	if (!is_device_dma_coherent(dev)) {
+		if (__free_from_pool(vaddr, size))
+			return;
+		vunmap(vaddr);
+	}
 	__dma_free_coherent(dev, size, swiotlb_addr, dma_handle, attrs);
 }
 
@@ -199,7 +205,8 @@ static dma_addr_t __swiotlb_map_page(struct device *dev, struct page *page,
 	dma_addr_t dev_addr;
 
 	dev_addr = swiotlb_map_page(dev, page, offset, size, dir, attrs);
-	__dma_map_area(phys_to_virt(dma_to_phys(dev, dev_addr)), size, dir);
+	if (!is_device_dma_coherent(dev))
+		__dma_map_area(phys_to_virt(dma_to_phys(dev, dev_addr)), size, dir);
 
 	return dev_addr;
 }
@@ -209,7 +216,8 @@ static void __swiotlb_unmap_page(struct device *dev, dma_addr_t dev_addr,
 				 size_t size, enum dma_data_direction dir,
 				 struct dma_attrs *attrs)
 {
-	__dma_unmap_area(phys_to_virt(dma_to_phys(dev, dev_addr)), size, dir);
+	if (!is_device_dma_coherent(dev))
+		__dma_unmap_area(phys_to_virt(dma_to_phys(dev, dev_addr)), size, dir);
 	swiotlb_unmap_page(dev, dev_addr, size, dir, attrs);
 }
 
@@ -221,9 +229,10 @@ static int __swiotlb_map_sg_attrs(struct device *dev, struct scatterlist *sgl,
 	int i, ret;
 
 	ret = swiotlb_map_sg_attrs(dev, sgl, nelems, dir, attrs);
-	for_each_sg(sgl, sg, ret, i)
-		__dma_map_area(phys_to_virt(dma_to_phys(dev, sg->dma_address)),
-			       sg->length, dir);
+	if (!is_device_dma_coherent(dev))
+		for_each_sg(sgl, sg, ret, i)
+			__dma_map_area(phys_to_virt(dma_to_phys(dev, sg->dma_address)),
+				       sg->length, dir);
 
 	return ret;
 }
@@ -236,9 +245,10 @@ static void __swiotlb_unmap_sg_attrs(struct device *dev,
 	struct scatterlist *sg;
 	int i;
 
-	for_each_sg(sgl, sg, nelems, i)
-		__dma_unmap_area(phys_to_virt(dma_to_phys(dev, sg->dma_address)),
-				 sg->length, dir);
+	if (!is_device_dma_coherent(dev))
+		for_each_sg(sgl, sg, nelems, i)
+			__dma_unmap_area(phys_to_virt(dma_to_phys(dev, sg->dma_address)),
+					 sg->length, dir);
 	swiotlb_unmap_sg_attrs(dev, sgl, nelems, dir, attrs);
 }
 
@@ -246,7 +256,8 @@ static void __swiotlb_sync_single_for_cpu(struct device *dev,
 					  dma_addr_t dev_addr, size_t size,
 					  enum dma_data_direction dir)
 {
-	__dma_unmap_area(phys_to_virt(dma_to_phys(dev, dev_addr)), size, dir);
+	if (!is_device_dma_coherent(dev))
+		__dma_unmap_area(phys_to_virt(dma_to_phys(dev, dev_addr)), size, dir);
 	swiotlb_sync_single_for_cpu(dev, dev_addr, size, dir);
 }
 
@@ -255,7 +266,8 @@ static void __swiotlb_sync_single_for_device(struct device *dev,
 					     enum dma_data_direction dir)
 {
 	swiotlb_sync_single_for_device(dev, dev_addr, size, dir);
-	__dma_map_area(phys_to_virt(dma_to_phys(dev, dev_addr)), size, dir);
+	if (!is_device_dma_coherent(dev))
+		__dma_map_area(phys_to_virt(dma_to_phys(dev, dev_addr)), size, dir);
 }
 
 static void __swiotlb_sync_sg_for_cpu(struct device *dev,
@@ -265,9 +277,10 @@ static void __swiotlb_sync_sg_for_cpu(struct device *dev,
 	struct scatterlist *sg;
 	int i;
 
-	for_each_sg(sgl, sg, nelems, i)
-		__dma_unmap_area(phys_to_virt(dma_to_phys(dev, sg->dma_address)),
-				 sg->length, dir);
+	if (!is_device_dma_coherent(dev))
+		for_each_sg(sgl, sg, nelems, i)
+			__dma_unmap_area(phys_to_virt(dma_to_phys(dev, sg->dma_address)),
+					 sg->length, dir);
 	swiotlb_sync_sg_for_cpu(dev, sgl, nelems, dir);
 }
 
@@ -279,9 +292,10 @@ static void __swiotlb_sync_sg_for_device(struct device *dev,
 	int i;
 
 	swiotlb_sync_sg_for_device(dev, sgl, nelems, dir);
-	for_each_sg(sgl, sg, nelems, i)
-		__dma_map_area(phys_to_virt(dma_to_phys(dev, sg->dma_address)),
-			       sg->length, dir);
+	if (!is_device_dma_coherent(dev))
+		for_each_sg(sgl, sg, nelems, i)
+			__dma_map_area(phys_to_virt(dma_to_phys(dev, sg->dma_address)),
+				       sg->length, dir);
 }
 
 /* vma->vm_page_prot must be set appropriately before calling this function */
@@ -308,28 +322,20 @@ static int __dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 	return ret;
 }
 
-static int __swiotlb_mmap_noncoherent(struct device *dev,
-		struct vm_area_struct *vma,
-		void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		struct dma_attrs *attrs)
-{
-	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot, false);
-	return __dma_common_mmap(dev, vma, cpu_addr, dma_addr, size);
-}
-
-static int __swiotlb_mmap_coherent(struct device *dev,
-		struct vm_area_struct *vma,
-		void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		struct dma_attrs *attrs)
+static int __swiotlb_mmap(struct device *dev,
+			  struct vm_area_struct *vma,
+			  void *cpu_addr, dma_addr_t dma_addr, size_t size,
+			  struct dma_attrs *attrs)
 {
-	/* Just use whatever page_prot attributes were specified */
+	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot,
+					     is_device_dma_coherent(dev));
 	return __dma_common_mmap(dev, vma, cpu_addr, dma_addr, size);
 }
 
-struct dma_map_ops noncoherent_swiotlb_dma_ops = {
-	.alloc = __dma_alloc_noncoherent,
-	.free = __dma_free_noncoherent,
-	.mmap = __swiotlb_mmap_noncoherent,
+static struct dma_map_ops swiotlb_dma_ops = {
+	.alloc = __dma_alloc,
+	.free = __dma_free,
+	.mmap = __swiotlb_mmap,
 	.map_page = __swiotlb_map_page,
 	.unmap_page = __swiotlb_unmap_page,
 	.map_sg = __swiotlb_map_sg_attrs,
@@ -341,24 +347,6 @@ struct dma_map_ops noncoherent_swiotlb_dma_ops = {
 	.dma_supported = swiotlb_dma_supported,
 	.mapping_error = swiotlb_dma_mapping_error,
 };
-EXPORT_SYMBOL(noncoherent_swiotlb_dma_ops);
-
-struct dma_map_ops coherent_swiotlb_dma_ops = {
-	.alloc = __dma_alloc_coherent,
-	.free = __dma_free_coherent,
-	.mmap = __swiotlb_mmap_coherent,
-	.map_page = swiotlb_map_page,
-	.unmap_page = swiotlb_unmap_page,
-	.map_sg = swiotlb_map_sg_attrs,
-	.unmap_sg = swiotlb_unmap_sg_attrs,
-	.sync_single_for_cpu = swiotlb_sync_single_for_cpu,
-	.sync_single_for_device = swiotlb_sync_single_for_device,
-	.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
-	.sync_sg_for_device = swiotlb_sync_sg_for_device,
-	.dma_supported = swiotlb_dma_supported,
-	.mapping_error = swiotlb_dma_mapping_error,
-};
-EXPORT_SYMBOL(coherent_swiotlb_dma_ops);
 
 extern int swiotlb_late_init_with_default_size(size_t default_size);
 
@@ -427,7 +415,7 @@ static int __init swiotlb_late_init(void)
 {
 	size_t swiotlb_size = min(SZ_64M, MAX_ORDER_NR_PAGES << PAGE_SHIFT);
 
-	dma_ops = &noncoherent_swiotlb_dma_ops;
+	dma_ops = &swiotlb_dma_ops;
 
 	return swiotlb_late_init_with_default_size(swiotlb_size);
 }
-- 
1.9.1
