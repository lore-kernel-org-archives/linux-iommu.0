From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH] dma-mapping: bypass indirect calls for dma-direct
Date: Thu,  6 Dec 2018 07:37:20 -0800
Message-ID: <20181206153720.10702-2-hch@lst.de>
References: <20181206153720.10702-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181206153720.10702-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Jesper Dangaard Brouer <brouer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Ilias Apalodimas <ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke-LJ9M9ZcSy1A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tariq Toukan <tariqt-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Avoid expensive indirect calls in the fast path DMA mapping
operations by directly calling the dma_direct_* ops if we are using
the directly mapped DMA operations.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 include/linux/dma-direct.h  |  17 -----
 include/linux/dma-mapping.h | 138 +++++++++++++++++++++++++++++++-----
 kernel/dma/direct.c         |  13 ++--
 3 files changed, 127 insertions(+), 41 deletions(-)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index 3b0a3ea3876d..b7338702592a 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -60,22 +60,5 @@ void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
 struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs);
 void __dma_direct_free_pages(struct device *dev, size_t size, struct page *page);
-dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
-		unsigned long offset, size_t size, enum dma_data_direction dir,
-		unsigned long attrs);
-void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
-		size_t size, enum dma_data_direction dir, unsigned long attrs);
-int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
-		enum dma_data_direction dir, unsigned long attrs);
-void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
-		int nents, enum dma_data_direction dir, unsigned long attrs);
-void dma_direct_sync_single_for_device(struct device *dev,
-		dma_addr_t addr, size_t size, enum dma_data_direction dir);
-void dma_direct_sync_sg_for_device(struct device *dev,
-		struct scatterlist *sgl, int nents, enum dma_data_direction dir);
-void dma_direct_sync_single_for_cpu(struct device *dev,
-		dma_addr_t addr, size_t size, enum dma_data_direction dir);
-void dma_direct_sync_sg_for_cpu(struct device *dev,
-		struct scatterlist *sgl, int nents, enum dma_data_direction dir);
 int dma_direct_supported(struct device *dev, u64 mask);
 #endif /* _LINUX_DMA_DIRECT_H */
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 8916499d2805..648ca7da3bb3 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -221,6 +221,69 @@ static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
 }
 #endif
 
+static inline bool dma_is_direct(const struct dma_map_ops *ops)
+{
+	return IS_ENABLED(CONFIG_DMA_DIRECT_OPS) && ops == &dma_direct_ops;
+}
+
+/*
+ * All the dma_direct_* declarations are here just for the indirect call bypass,
+ * and must not be used directly drivers!
+ */
+dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
+		unsigned long offset, size_t size, enum dma_data_direction dir,
+		unsigned long attrs);
+int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
+		enum dma_data_direction dir, unsigned long attrs);
+
+#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
+    defined(CONFIG_SWIOTLB)
+void dma_direct_sync_single_for_device(struct device *dev,
+		dma_addr_t addr, size_t size, enum dma_data_direction dir);
+void dma_direct_sync_sg_for_device(struct device *dev,
+		struct scatterlist *sgl, int nents, enum dma_data_direction dir);
+#else
+static inline void dma_direct_sync_single_for_device(struct device *dev,
+		dma_addr_t addr, size_t size, enum dma_data_direction dir)
+{
+}
+static inline void dma_direct_sync_sg_for_device(struct device *dev,
+		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
+{
+}
+#endif
+
+#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
+    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL) || \
+    defined(CONFIG_SWIOTLB)
+void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs);
+void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
+		int nents, enum dma_data_direction dir, unsigned long attrs);
+void dma_direct_sync_single_for_cpu(struct device *dev,
+		dma_addr_t addr, size_t size, enum dma_data_direction dir);
+void dma_direct_sync_sg_for_cpu(struct device *dev,
+		struct scatterlist *sgl, int nents, enum dma_data_direction dir);
+#else
+static inline void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+}
+static inline void dma_direct_unmap_sg(struct device *dev,
+		struct scatterlist *sgl, int nents, enum dma_data_direction dir,
+		unsigned long attrs)
+{
+}
+static inline void dma_direct_sync_single_for_cpu(struct device *dev,
+		dma_addr_t addr, size_t size, enum dma_data_direction dir)
+{
+}
+static inline void dma_direct_sync_sg_for_cpu(struct device *dev,
+		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
+{
+}
+#endif
+
 static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
 					      size_t size,
 					      enum dma_data_direction dir,
@@ -231,9 +294,12 @@ static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
 
 	BUG_ON(!valid_dma_direction(dir));
 	debug_dma_map_single(dev, ptr, size);
-	addr = ops->map_page(dev, virt_to_page(ptr),
-			     offset_in_page(ptr), size,
-			     dir, attrs);
+	if (dma_is_direct(ops))
+		addr = dma_direct_map_page(dev, virt_to_page(ptr),
+				offset_in_page(ptr), size, dir, attrs);
+	else
+		addr = ops->map_page(dev, virt_to_page(ptr),
+				offset_in_page(ptr), size, dir, attrs);
 	debug_dma_map_page(dev, virt_to_page(ptr),
 			   offset_in_page(ptr), size,
 			   dir, addr, true);
@@ -248,8 +314,12 @@ static inline void dma_unmap_single_attrs(struct device *dev, dma_addr_t addr,
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	BUG_ON(!valid_dma_direction(dir));
-	if (ops->unmap_page)
-		ops->unmap_page(dev, addr, size, dir, attrs);
+	if (ops->unmap_page) {
+		if (dma_is_direct(ops))
+			dma_direct_unmap_page(dev, addr, size, dir, attrs);
+		else
+			ops->unmap_page(dev, addr, size, dir, attrs);
+	}
 	debug_dma_unmap_page(dev, addr, size, dir, true);
 }
 
@@ -265,7 +335,10 @@ static inline int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 	int ents;
 
 	BUG_ON(!valid_dma_direction(dir));
-	ents = ops->map_sg(dev, sg, nents, dir, attrs);
+	if (dma_is_direct(ops))
+		ents = dma_direct_map_sg(dev, sg, nents, dir, attrs);
+	else
+		ents = ops->map_sg(dev, sg, nents, dir, attrs);
 	BUG_ON(ents < 0);
 	debug_dma_map_sg(dev, sg, nents, ents, dir);
 
@@ -280,8 +353,12 @@ static inline void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg
 
 	BUG_ON(!valid_dma_direction(dir));
 	debug_dma_unmap_sg(dev, sg, nents, dir);
-	if (ops->unmap_sg)
-		ops->unmap_sg(dev, sg, nents, dir, attrs);
+	if (ops->unmap_sg) {
+		if (dma_is_direct(ops))
+			dma_direct_unmap_sg(dev, sg, nents, dir, attrs);
+		else
+			ops->unmap_sg(dev, sg, nents, dir, attrs);
+	}
 }
 
 static inline dma_addr_t dma_map_page_attrs(struct device *dev,
@@ -294,7 +371,10 @@ static inline dma_addr_t dma_map_page_attrs(struct device *dev,
 	dma_addr_t addr;
 
 	BUG_ON(!valid_dma_direction(dir));
-	addr = ops->map_page(dev, page, offset, size, dir, attrs);
+	if (dma_is_direct(ops))
+		addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
+	else
+		addr = ops->map_page(dev, page, offset, size, dir, attrs);
 	debug_dma_map_page(dev, page, offset, size, dir, addr, false);
 
 	return addr;
@@ -308,8 +388,12 @@ static inline void dma_unmap_page_attrs(struct device *dev,
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	BUG_ON(!valid_dma_direction(dir));
-	if (ops->unmap_page)
-		ops->unmap_page(dev, addr, size, dir, attrs);
+	if (ops->unmap_page) {
+		if (dma_is_direct(ops))
+			dma_direct_unmap_page(dev, addr, size, dir, attrs);
+		else
+			ops->unmap_page(dev, addr, size, dir, attrs);
+	}
 	debug_dma_unmap_page(dev, addr, size, dir, false);
 }
 
@@ -355,8 +439,12 @@ static inline void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	BUG_ON(!valid_dma_direction(dir));
-	if (ops->sync_single_for_cpu)
-		ops->sync_single_for_cpu(dev, addr, size, dir);
+	if (ops->sync_single_for_cpu) {
+		if (dma_is_direct(ops))
+			dma_direct_sync_single_for_cpu(dev, addr, size, dir);
+		else
+			ops->sync_single_for_cpu(dev, addr, size, dir);
+	}
 	debug_dma_sync_single_for_cpu(dev, addr, size, dir);
 }
 
@@ -374,8 +462,12 @@ static inline void dma_sync_single_for_device(struct device *dev,
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	BUG_ON(!valid_dma_direction(dir));
-	if (ops->sync_single_for_device)
-		ops->sync_single_for_device(dev, addr, size, dir);
+	if (ops->sync_single_for_device) {
+		if (dma_is_direct(ops))
+			dma_direct_sync_single_for_device(dev, addr, size, dir);
+		else
+			ops->sync_single_for_device(dev, addr, size, dir);
+	}
 	debug_dma_sync_single_for_device(dev, addr, size, dir);
 }
 
@@ -393,8 +485,12 @@ dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	BUG_ON(!valid_dma_direction(dir));
-	if (ops->sync_sg_for_cpu)
-		ops->sync_sg_for_cpu(dev, sg, nelems, dir);
+	if (ops->sync_sg_for_cpu) {
+		if (dma_is_direct(ops))
+			dma_direct_sync_sg_for_cpu(dev, sg, nelems, dir);
+		else
+			ops->sync_sg_for_cpu(dev, sg, nelems, dir);
+	}
 	debug_dma_sync_sg_for_cpu(dev, sg, nelems, dir);
 }
 
@@ -405,8 +501,12 @@ dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	BUG_ON(!valid_dma_direction(dir));
-	if (ops->sync_sg_for_device)
-		ops->sync_sg_for_device(dev, sg, nelems, dir);
+	if (ops->sync_sg_for_device) {
+		if (dma_is_direct(ops))
+			dma_direct_sync_sg_for_device(dev, sg, nelems, dir);
+		else
+			ops->sync_sg_for_device(dev, sg, nelems, dir);
+	}
 	debug_dma_sync_sg_for_device(dev, sg, nelems, dir);
 
 }
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 372c1955454a..cd535e7c67d7 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -223,6 +223,7 @@ void dma_direct_sync_single_for_device(struct device *dev,
 	if (!dev_is_dma_coherent(dev))
 		arch_sync_dma_for_device(dev, paddr, size, dir);
 }
+EXPORT_SYMBOL(dma_direct_sync_single_for_device);
 
 void dma_direct_sync_sg_for_device(struct device *dev,
 		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
@@ -240,6 +241,7 @@ void dma_direct_sync_sg_for_device(struct device *dev,
 					dir);
 	}
 }
+EXPORT_SYMBOL(dma_direct_sync_sg_for_device);
 #endif
 
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
@@ -258,6 +260,7 @@ void dma_direct_sync_single_for_cpu(struct device *dev,
 	if (is_swiotlb_buffer(paddr))
 		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_CPU);
 }
+EXPORT_SYMBOL(dma_direct_sync_single_for_cpu);
 
 void dma_direct_sync_sg_for_cpu(struct device *dev,
 		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
@@ -277,6 +280,7 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
 	if (!dev_is_dma_coherent(dev))
 		arch_sync_dma_for_cpu_all(dev);
 }
+EXPORT_SYMBOL(dma_direct_sync_sg_for_cpu);
 
 void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
@@ -289,6 +293,7 @@ void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
 	if (is_swiotlb_buffer(phys))
 		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
 }
+EXPORT_SYMBOL(dma_direct_unmap_page);
 
 void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
 		int nents, enum dma_data_direction dir, unsigned long attrs)
@@ -300,11 +305,7 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
 		dma_direct_unmap_page(dev, sg->dma_address, sg_dma_len(sg), dir,
 			     attrs);
 }
-#else
-void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
-		int nents, enum dma_data_direction dir, unsigned long attrs)
-{
-}
+EXPORT_SYMBOL(dma_direct_unmap_sg);
 #endif
 
 static inline bool dma_direct_possible(struct device *dev, dma_addr_t dma_addr,
@@ -331,6 +332,7 @@ dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
 		arch_sync_dma_for_device(dev, phys, size, dir);
 	return dma_addr;
 }
+EXPORT_SYMBOL(dma_direct_map_page);
 
 int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 		enum dma_data_direction dir, unsigned long attrs)
@@ -352,6 +354,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 	dma_direct_unmap_sg(dev, sgl, i, dir, attrs | DMA_ATTR_SKIP_CPU_SYNC);
 	return 0;
 }
+EXPORT_SYMBOL(dma_direct_map_sg);
 
 /*
  * Because 32-bit DMA masks are so common we expect every architecture to be
-- 
2.19.1
