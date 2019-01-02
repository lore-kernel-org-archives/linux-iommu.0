From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 1/5] dma-mapping: implement dma_map_single_attrs using
	dma_map_page_attrs
Date: Wed,  2 Jan 2019 09:33:15 +0100
Message-ID: <20190102083319.12374-2-hch@lst.de>
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

And also switch the way we implement the unmap side around to stay
consistent.  This ensures dma-debug works again because it records which
function we used for mapping to ensure it is also used for unmapping,
and also reduces further code duplication.  Last but not least this
also officially allows calling dma_sync_single_* for mappings created
using dma_map_page, which is perfectly fine given that the sync calls
only take a dma_addr_t, but not a virtual address or struct page.

Fixes: 7f0fee242e ("dma-mapping: merge dma_unmap_page_attrs and dma_unmap_single_attrs")
Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 include/linux/dma-debug.h   | 11 +++----
 include/linux/dma-mapping.h | 66 ++++++++++++++-----------------------
 kernel/dma/debug.c          | 17 +++-------
 3 files changed, 32 insertions(+), 62 deletions(-)

diff --git a/include/linux/dma-debug.h b/include/linux/dma-debug.h
index 2ad5c363d7d5..cb422cbe587d 100644
--- a/include/linux/dma-debug.h
+++ b/include/linux/dma-debug.h
@@ -35,13 +35,12 @@ extern void debug_dma_map_single(struct device *dev, const void *addr,
 
 extern void debug_dma_map_page(struct device *dev, struct page *page,
 			       size_t offset, size_t size,
-			       int direction, dma_addr_t dma_addr,
-			       bool map_single);
+			       int direction, dma_addr_t dma_addr);
 
 extern void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr);
 
 extern void debug_dma_unmap_page(struct device *dev, dma_addr_t addr,
-				 size_t size, int direction, bool map_single);
+				 size_t size, int direction);
 
 extern void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
 			     int nents, int mapped_ents, int direction);
@@ -95,8 +94,7 @@ static inline void debug_dma_map_single(struct device *dev, const void *addr,
 
 static inline void debug_dma_map_page(struct device *dev, struct page *page,
 				      size_t offset, size_t size,
-				      int direction, dma_addr_t dma_addr,
-				      bool map_single)
+				      int direction, dma_addr_t dma_addr)
 {
 }
 
@@ -106,8 +104,7 @@ static inline void debug_dma_mapping_error(struct device *dev,
 }
 
 static inline void debug_dma_unmap_page(struct device *dev, dma_addr_t addr,
-					size_t size, int direction,
-					bool map_single)
+					size_t size, int direction)
 {
 }
 
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index ba521d5506c9..0452a8be2789 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -284,32 +284,25 @@ static inline void dma_direct_sync_sg_for_cpu(struct device *dev,
 }
 #endif
 
-static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
-					      size_t size,
-					      enum dma_data_direction dir,
-					      unsigned long attrs)
+static inline dma_addr_t dma_map_page_attrs(struct device *dev,
+		struct page *page, size_t offset, size_t size,
+		enum dma_data_direction dir, unsigned long attrs)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 	dma_addr_t addr;
 
 	BUG_ON(!valid_dma_direction(dir));
-	debug_dma_map_single(dev, ptr, size);
 	if (dma_is_direct(ops))
-		addr = dma_direct_map_page(dev, virt_to_page(ptr),
-				offset_in_page(ptr), size, dir, attrs);
+		addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
 	else
-		addr = ops->map_page(dev, virt_to_page(ptr),
-				offset_in_page(ptr), size, dir, attrs);
-	debug_dma_map_page(dev, virt_to_page(ptr),
-			   offset_in_page(ptr), size,
-			   dir, addr, true);
+		addr = ops->map_page(dev, page, offset, size, dir, attrs);
+	debug_dma_map_page(dev, page, offset, size, dir, addr);
+
 	return addr;
 }
 
-static inline void dma_unmap_single_attrs(struct device *dev, dma_addr_t addr,
-					  size_t size,
-					  enum dma_data_direction dir,
-					  unsigned long attrs)
+static inline void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
@@ -318,13 +311,7 @@ static inline void dma_unmap_single_attrs(struct device *dev, dma_addr_t addr,
 		dma_direct_unmap_page(dev, addr, size, dir, attrs);
 	else if (ops->unmap_page)
 		ops->unmap_page(dev, addr, size, dir, attrs);
-	debug_dma_unmap_page(dev, addr, size, dir, true);
-}
-
-static inline void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr,
-		size_t size, enum dma_data_direction dir, unsigned long attrs)
-{
-	return dma_unmap_single_attrs(dev, addr, size, dir, attrs);
+	debug_dma_unmap_page(dev, addr, size, dir);
 }
 
 /*
@@ -363,25 +350,6 @@ static inline void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg
 		ops->unmap_sg(dev, sg, nents, dir, attrs);
 }
 
-static inline dma_addr_t dma_map_page_attrs(struct device *dev,
-					    struct page *page,
-					    size_t offset, size_t size,
-					    enum dma_data_direction dir,
-					    unsigned long attrs)
-{
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-	dma_addr_t addr;
-
-	BUG_ON(!valid_dma_direction(dir));
-	if (dma_is_direct(ops))
-		addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
-	else
-		addr = ops->map_page(dev, page, offset, size, dir, attrs);
-	debug_dma_map_page(dev, page, offset, size, dir, addr, false);
-
-	return addr;
-}
-
 static inline dma_addr_t dma_map_resource(struct device *dev,
 					  phys_addr_t phys_addr,
 					  size_t size,
@@ -488,6 +456,20 @@ dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 
 }
 
+static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+	debug_dma_map_single(dev, ptr, size);
+	return dma_map_page_attrs(dev, virt_to_page(ptr), offset_in_page(ptr),
+			size, dir, attrs);
+}
+
+static inline void dma_unmap_single_attrs(struct device *dev, dma_addr_t addr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+	return dma_unmap_page_attrs(dev, addr, size, dir, attrs);
+}
+
 #define dma_map_single(d, a, s, r) dma_map_single_attrs(d, a, s, r, 0)
 #define dma_unmap_single(d, a, s, r) dma_unmap_single_attrs(d, a, s, r, 0)
 #define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, 0)
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 164706da2a73..1e0157113d15 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -49,7 +49,6 @@
 
 enum {
 	dma_debug_single,
-	dma_debug_page,
 	dma_debug_sg,
 	dma_debug_coherent,
 	dma_debug_resource,
@@ -1300,8 +1299,7 @@ void debug_dma_map_single(struct device *dev, const void *addr,
 EXPORT_SYMBOL(debug_dma_map_single);
 
 void debug_dma_map_page(struct device *dev, struct page *page, size_t offset,
-			size_t size, int direction, dma_addr_t dma_addr,
-			bool map_single)
+			size_t size, int direction, dma_addr_t dma_addr)
 {
 	struct dma_debug_entry *entry;
 
@@ -1316,7 +1314,7 @@ void debug_dma_map_page(struct device *dev, struct page *page, size_t offset,
 		return;
 
 	entry->dev       = dev;
-	entry->type      = dma_debug_page;
+	entry->type      = dma_debug_single;
 	entry->pfn	 = page_to_pfn(page);
 	entry->offset	 = offset,
 	entry->dev_addr  = dma_addr;
@@ -1324,9 +1322,6 @@ void debug_dma_map_page(struct device *dev, struct page *page, size_t offset,
 	entry->direction = direction;
 	entry->map_err_type = MAP_ERR_NOT_CHECKED;
 
-	if (map_single)
-		entry->type = dma_debug_single;
-
 	check_for_stack(dev, page, offset);
 
 	if (!PageHighMem(page)) {
@@ -1378,10 +1373,10 @@ void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 EXPORT_SYMBOL(debug_dma_mapping_error);
 
 void debug_dma_unmap_page(struct device *dev, dma_addr_t addr,
-			  size_t size, int direction, bool map_single)
+			  size_t size, int direction)
 {
 	struct dma_debug_entry ref = {
-		.type           = dma_debug_page,
+		.type           = dma_debug_single,
 		.dev            = dev,
 		.dev_addr       = addr,
 		.size           = size,
@@ -1390,10 +1385,6 @@ void debug_dma_unmap_page(struct device *dev, dma_addr_t addr,
 
 	if (unlikely(dma_debug_disabled()))
 		return;
-
-	if (map_single)
-		ref.type = dma_debug_single;
-
 	check_unmap(&ref);
 }
 EXPORT_SYMBOL(debug_dma_unmap_page);
-- 
2.19.2
