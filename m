From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 4/5] dma-mapping: properly stub out the DMA API for
	!CONFIG_HAS_DMA
Date: Wed,  2 Jan 2019 09:33:18 +0100
Message-ID: <20190102083319.12374-5-hch@lst.de>
References: <20190102083319.12374-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190102083319.12374-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Corentin Labbe <clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This avoids link failures in drivers using the DMA API, when they
are compiled for user mode Linux with CONFIG_COMPILE_TEST=y.

Fixes: 356da6d0cd ("dma-mapping: bypass indirect calls for dma-direct")
Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 include/linux/dma-mapping.h | 255 +++++++++++++++++++++++-------------
 1 file changed, 164 insertions(+), 91 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 937c2a949fca..cef2127e1d70 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -194,33 +194,6 @@ static inline int dma_mmap_from_global_coherent(struct vm_area_struct *vma,
 }
 #endif /* CONFIG_HAVE_GENERIC_DMA_COHERENT */
 
-#ifdef CONFIG_HAS_DMA
-#include <asm/dma-mapping.h>
-static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
-{
-	if (dev && dev->dma_ops)
-		return dev->dma_ops;
-	return get_arch_dma_ops(dev ? dev->bus : NULL);
-}
-
-static inline void set_dma_ops(struct device *dev,
-			       const struct dma_map_ops *dma_ops)
-{
-	dev->dma_ops = dma_ops;
-}
-#else
-/*
- * Define the dma api to allow compilation of dma dependent code.
- * Code that depends on the dma-mapping API needs to set 'depends on HAS_DMA'
- * in its Kconfig, unless it already depends on <something> || COMPILE_TEST,
- * where <something> guarantuees the availability of the dma-mapping API.
- */
-static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
-{
-	return NULL;
-}
-#endif
-
 static inline bool dma_is_direct(const struct dma_map_ops *ops)
 {
 	return likely(!ops);
@@ -284,6 +257,22 @@ static inline void dma_direct_sync_sg_for_cpu(struct device *dev,
 }
 #endif
 
+#ifdef CONFIG_HAS_DMA
+#include <asm/dma-mapping.h>
+
+static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
+{
+	if (dev && dev->dma_ops)
+		return dev->dma_ops;
+	return get_arch_dma_ops(dev ? dev->bus : NULL);
+}
+
+static inline void set_dma_ops(struct device *dev,
+			       const struct dma_map_ops *dma_ops)
+{
+	dev->dma_ops = dma_ops;
+}
+
 static inline dma_addr_t dma_map_page_attrs(struct device *dev,
 		struct page *page, size_t offset, size_t size,
 		enum dma_data_direction dir, unsigned long attrs)
@@ -399,13 +388,6 @@ static inline void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
 	debug_dma_sync_single_for_cpu(dev, addr, size, dir);
 }
 
-static inline void dma_sync_single_range_for_cpu(struct device *dev,
-		dma_addr_t addr, unsigned long offset, size_t size,
-		enum dma_data_direction dir)
-{
-	return dma_sync_single_for_cpu(dev, addr + offset, size, dir);
-}
-
 static inline void dma_sync_single_for_device(struct device *dev,
 					      dma_addr_t addr, size_t size,
 					      enum dma_data_direction dir)
@@ -420,13 +402,6 @@ static inline void dma_sync_single_for_device(struct device *dev,
 	debug_dma_sync_single_for_device(dev, addr, size, dir);
 }
 
-static inline void dma_sync_single_range_for_device(struct device *dev,
-		dma_addr_t addr, unsigned long offset, size_t size,
-		enum dma_data_direction dir)
-{
-	return dma_sync_single_for_device(dev, addr + offset, size, dir);
-}
-
 static inline void
 dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
 		    int nelems, enum dma_data_direction dir)
@@ -456,6 +431,138 @@ dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 
 }
 
+static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
+{
+	debug_dma_mapping_error(dev, dma_addr);
+
+	if (dma_addr == DMA_MAPPING_ERROR)
+		return -ENOMEM;
+	return 0;
+}
+
+void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
+		gfp_t flag, unsigned long attrs);
+void dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
+		dma_addr_t dma_handle, unsigned long attrs);
+void *dmam_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
+		gfp_t gfp, unsigned long attrs);
+void dmam_free_coherent(struct device *dev, size_t size, void *vaddr,
+		dma_addr_t dma_handle);
+void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
+		enum dma_data_direction dir);
+int dma_get_sgtable_attrs(struct device *dev, struct sg_table *sgt,
+		void *cpu_addr, dma_addr_t dma_addr, size_t size,
+		unsigned long attrs);
+int dma_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
+		void *cpu_addr, dma_addr_t dma_addr, size_t size,
+		unsigned long attrs);
+int dma_supported(struct device *dev, u64 mask);
+int dma_set_mask(struct device *dev, u64 mask);
+int dma_set_coherent_mask(struct device *dev, u64 mask);
+u64 dma_get_required_mask(struct device *dev);
+#else /* CONFIG_HAS_DMA */
+static inline dma_addr_t dma_map_page_attrs(struct device *dev,
+		struct page *page, size_t offset, size_t size,
+		enum dma_data_direction dir, unsigned long attrs)
+{
+	return DMA_MAPPING_ERROR;
+}
+static inline void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+}
+static inline int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
+{
+	return 0;
+}
+static inline void dma_unmap_sg_attrs(struct device *dev,
+		struct scatterlist *sg, int nents, enum dma_data_direction dir,
+		unsigned long attrs)
+{
+}
+static inline dma_addr_t dma_map_resource(struct device *dev,
+		phys_addr_t phys_addr, size_t size, enum dma_data_direction dir,
+		unsigned long attrs)
+{
+	return DMA_MAPPING_ERROR;
+}
+static inline void dma_unmap_resource(struct device *dev, dma_addr_t addr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+}
+static inline void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
+		size_t size, enum dma_data_direction dir)
+{
+}
+static inline void dma_sync_single_for_device(struct device *dev,
+		dma_addr_t addr, size_t size, enum dma_data_direction dir)
+{
+}
+static inline void dma_sync_sg_for_cpu(struct device *dev,
+		struct scatterlist *sg, int nelems, enum dma_data_direction dir)
+{
+}
+static inline void dma_sync_sg_for_device(struct device *dev,
+		struct scatterlist *sg, int nelems, enum dma_data_direction dir)
+{
+}
+static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
+{
+	return -ENOMEM;
+}
+static inline void *dma_alloc_attrs(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t flag, unsigned long attrs)
+{
+	return NULL;
+}
+static void dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
+		dma_addr_t dma_handle, unsigned long attrs)
+{
+}
+static inline void *dmam_alloc_attrs(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
+{
+	return NULL;
+}
+static inline void dmam_free_coherent(struct device *dev, size_t size,
+		void *vaddr, dma_addr_t dma_handle)
+{
+}
+static inline void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
+		enum dma_data_direction dir)
+{
+}
+static inline int dma_get_sgtable_attrs(struct device *dev,
+		struct sg_table *sgt, void *cpu_addr, dma_addr_t dma_addr,
+		size_t size, unsigned long attrs)
+{
+	return -ENXIO;
+}
+static inline int dma_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
+		void *cpu_addr, dma_addr_t dma_addr, size_t size,
+		unsigned long attrs)
+{
+	return -ENXIO;
+}
+static inline int dma_supported(struct device *dev, u64 mask)
+{
+	return 0;
+}
+static inline int dma_set_mask(struct device *dev, u64 mask)
+{
+	return -EIO;
+}
+static inline int dma_set_coherent_mask(struct device *dev, u64 mask)
+{
+	return -EIO;
+}
+static inline u64 dma_get_required_mask(struct device *dev)
+{
+	return 0;
+}
+#endif /* CONFIG_HAS_DMA */
+
 static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
@@ -470,15 +577,28 @@ static inline void dma_unmap_single_attrs(struct device *dev, dma_addr_t addr,
 	return dma_unmap_page_attrs(dev, addr, size, dir, attrs);
 }
 
+static inline void dma_sync_single_range_for_cpu(struct device *dev,
+		dma_addr_t addr, unsigned long offset, size_t size,
+		enum dma_data_direction dir)
+{
+	return dma_sync_single_for_cpu(dev, addr + offset, size, dir);
+}
+
+static inline void dma_sync_single_range_for_device(struct device *dev,
+		dma_addr_t addr, unsigned long offset, size_t size,
+		enum dma_data_direction dir)
+{
+	return dma_sync_single_for_device(dev, addr + offset, size, dir);
+}
+
 #define dma_map_single(d, a, s, r) dma_map_single_attrs(d, a, s, r, 0)
 #define dma_unmap_single(d, a, s, r) dma_unmap_single_attrs(d, a, s, r, 0)
 #define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, 0)
 #define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
 #define dma_map_page(d, p, o, s, r) dma_map_page_attrs(d, p, o, s, r, 0)
 #define dma_unmap_page(d, a, s, r) dma_unmap_page_attrs(d, a, s, r, 0)
-
-void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
-		enum dma_data_direction dir);
+#define dma_get_sgtable(d, t, v, h, s) dma_get_sgtable_attrs(d, t, v, h, s, 0)
+#define dma_mmap_coherent(d, v, c, h, s) dma_mmap_attrs(d, v, c, h, s, 0)
 
 extern int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
@@ -498,25 +618,10 @@ bool dma_in_atomic_pool(void *start, size_t size);
 void *dma_alloc_from_pool(size_t size, struct page **ret_page, gfp_t flags);
 bool dma_free_from_pool(void *start, size_t size);
 
-int dma_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
-		void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		unsigned long attrs);
-#define dma_mmap_coherent(d, v, c, h, s) dma_mmap_attrs(d, v, c, h, s, 0)
-
 int
 dma_common_get_sgtable(struct device *dev, struct sg_table *sgt, void *cpu_addr,
 		dma_addr_t dma_addr, size_t size, unsigned long attrs);
 
-int dma_get_sgtable_attrs(struct device *dev, struct sg_table *sgt,
-		void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		unsigned long attrs);
-#define dma_get_sgtable(d, t, v, h, s) dma_get_sgtable_attrs(d, t, v, h, s, 0)
-
-void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
-		gfp_t flag, unsigned long attrs);
-void dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
-		dma_addr_t dma_handle, unsigned long attrs);
-
 static inline void *dma_alloc_coherent(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp)
 {
@@ -531,18 +636,6 @@ static inline void dma_free_coherent(struct device *dev, size_t size,
 	return dma_free_attrs(dev, size, cpu_addr, dma_handle, 0);
 }
 
-static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	debug_dma_mapping_error(dev, dma_addr);
-
-	if (dma_addr == DMA_MAPPING_ERROR)
-		return -ENOMEM;
-	return 0;
-}
-
-int dma_supported(struct device *dev, u64 mask);
-int dma_set_mask(struct device *dev, u64 mask);
-int dma_set_coherent_mask(struct device *dev, u64 mask);
 
 static inline u64 dma_get_mask(struct device *dev)
 {
@@ -575,8 +668,6 @@ static inline int dma_coerce_mask_and_coherent(struct device *dev, u64 mask)
 	return dma_set_mask_and_coherent(dev, mask);
 }
 
-extern u64 dma_get_required_mask(struct device *dev);
-
 #ifndef arch_setup_dma_ops
 static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,
 				      u64 size, const struct iommu_ops *iommu,
@@ -673,24 +764,6 @@ dma_mark_declared_memory_occupied(struct device *dev,
 }
 #endif /* CONFIG_HAVE_GENERIC_DMA_COHERENT */
 
-/*
- * Managed DMA API
- */
-#ifdef CONFIG_HAS_DMA
-extern void *dmam_alloc_attrs(struct device *dev, size_t size,
-				 dma_addr_t *dma_handle, gfp_t gfp,
-				 unsigned long attrs);
-extern void dmam_free_coherent(struct device *dev, size_t size, void *vaddr,
-			       dma_addr_t dma_handle);
-#else /* !CONFIG_HAS_DMA */
-static inline void *dmam_alloc_attrs(struct device *dev, size_t size,
-					dma_addr_t *dma_handle, gfp_t gfp,
-					unsigned long attrs)
-{ return NULL; }
-static inline void dmam_free_coherent(struct device *dev, size_t size,
-				      void *vaddr, dma_addr_t dma_handle) { }
-#endif /* !CONFIG_HAS_DMA */
-
 static inline void *dmam_alloc_coherent(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp)
 {
-- 
2.19.2
