From: Stephen Boyd <swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v3] dma-debug: Check for drivers mapping invalid addresses in
	dma_map_single()
Date: Mon,  8 Oct 2018 00:20:07 -0700
Message-ID: <20181008072007.26387-1-swboyd@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

I recently debugged a DMA mapping oops where a driver was trying to map
a buffer returned from request_firmware() with dma_map_single(). Memory
returned from request_firmware() is mapped into the vmalloc region and
this isn't a valid region to map with dma_map_single() per the DMA
documentation's "What memory is DMA'able?" section.

Unfortunately, we don't really check that in the DMA debugging code, so
enabling DMA debugging doesn't help catch this problem. Let's add a new
DMA debug function to check for a vmalloc address or an invalid virtual
address and print a warning if this happens. This makes it a little
easier to debug these sorts of problems, instead of seeing odd behavior
or crashes when drivers attempt to map the vmalloc space for DMA.

Cc: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Stephen Boyd <swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---

Changes from v2:
 * Rename function properly and actually test it!
 * Add Robin's reviewed-by tag

Changes from v1:                                                                                                                    
 * Update code to check for invalid virtual address too                                                                             
 * Rename function to debug_dma_map_single()    

 include/linux/dma-debug.h   |  8 ++++++++
 include/linux/dma-mapping.h |  1 +
 kernel/dma/debug.c          | 16 ++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/include/linux/dma-debug.h b/include/linux/dma-debug.h
index a785f2507159..30213adbb6b9 100644
--- a/include/linux/dma-debug.h
+++ b/include/linux/dma-debug.h
@@ -32,6 +32,9 @@ extern void dma_debug_add_bus(struct bus_type *bus);
 
 extern int dma_debug_resize_entries(u32 num_entries);
 
+extern void debug_dma_map_single(struct device *dev, const void *addr,
+				 unsigned long len);
+
 extern void debug_dma_map_page(struct device *dev, struct page *page,
 			       size_t offset, size_t size,
 			       int direction, dma_addr_t dma_addr,
@@ -103,6 +106,11 @@ static inline int dma_debug_resize_entries(u32 num_entries)
 	return 0;
 }
 
+static inline void debug_dma_map_single(struct device *dev, const void *addr,
+					unsigned long len)
+{
+}
+
 static inline void debug_dma_map_page(struct device *dev, struct page *page,
 				      size_t offset, size_t size,
 				      int direction, dma_addr_t dma_addr,
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 562af6b45f23..547a48bcfa3d 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -229,6 +229,7 @@ static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
 	dma_addr_t addr;
 
 	BUG_ON(!valid_dma_direction(dir));
+	debug_dma_map_single(dev, ptr, size);
 	addr = ops->map_page(dev, virt_to_page(ptr),
 			     offset_in_page(ptr), size,
 			     dir, attrs);
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index c007d25bee09..231ca4628062 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1312,6 +1312,22 @@ static void check_sg_segment(struct device *dev, struct scatterlist *sg)
 #endif
 }
 
+void debug_dma_map_single(struct device *dev, const void *addr,
+			    unsigned long len)
+{
+	if (unlikely(dma_debug_disabled()))
+		return;
+
+	if (!virt_addr_valid(addr))
+		err_printk(dev, NULL, "DMA-API: device driver maps memory from invalid area [addr=%p] [len=%lu]\n",
+			   addr, len);
+
+	if (is_vmalloc_addr(addr))
+		err_printk(dev, NULL, "DMA-API: device driver maps memory from vmalloc area [addr=%p] [len=%lu]\n",
+			   addr, len);
+}
+EXPORT_SYMBOL(debug_dma_map_single);
+
 void debug_dma_map_page(struct device *dev, struct page *page, size_t offset,
 			size_t size, int direction, dma_addr_t dma_addr,
 			bool map_single)
-- 
Sent by a computer through tubes
