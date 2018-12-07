From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 06/15] dma-mapping: simplify the
	dma_sync_single_range_for_{cpu, device} implementation
Date: Fri,  7 Dec 2018 11:07:11 -0800
Message-ID: <20181207190720.18517-7-hch@lst.de>
References: <20181207190720.18517-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181207190720.18517-1-hch-jcswGhMUV9g@public.gmane.org>
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
Cc: Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke-LJ9M9ZcSy1A@public.gmane.org>, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ilias Apalodimas <ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Keith Busch <keith.busch-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Jonathan Derrick <jonathan.derrick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Tariq Toukan <tariqt-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

We can just call the regular calls after adding offset the the address instead
of reimplementing them.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 include/linux/dma-debug.h   | 27 ------------------------
 include/linux/dma-mapping.h | 34 +++++++++---------------------
 kernel/dma/debug.c          | 42 -------------------------------------
 3 files changed, 10 insertions(+), 93 deletions(-)

diff --git a/include/linux/dma-debug.h b/include/linux/dma-debug.h
index 30213adbb6b9..c85e097a984c 100644
--- a/include/linux/dma-debug.h
+++ b/include/linux/dma-debug.h
@@ -72,17 +72,6 @@ extern void debug_dma_sync_single_for_device(struct device *dev,
 					     dma_addr_t dma_handle,
 					     size_t size, int direction);
 
-extern void debug_dma_sync_single_range_for_cpu(struct device *dev,
-						dma_addr_t dma_handle,
-						unsigned long offset,
-						size_t size,
-						int direction);
-
-extern void debug_dma_sync_single_range_for_device(struct device *dev,
-						   dma_addr_t dma_handle,
-						   unsigned long offset,
-						   size_t size, int direction);
-
 extern void debug_dma_sync_sg_for_cpu(struct device *dev,
 				      struct scatterlist *sg,
 				      int nelems, int direction);
@@ -174,22 +163,6 @@ static inline void debug_dma_sync_single_for_device(struct device *dev,
 {
 }
 
-static inline void debug_dma_sync_single_range_for_cpu(struct device *dev,
-						       dma_addr_t dma_handle,
-						       unsigned long offset,
-						       size_t size,
-						       int direction)
-{
-}
-
-static inline void debug_dma_sync_single_range_for_device(struct device *dev,
-							  dma_addr_t dma_handle,
-							  unsigned long offset,
-							  size_t size,
-							  int direction)
-{
-}
-
 static inline void debug_dma_sync_sg_for_cpu(struct device *dev,
 					     struct scatterlist *sg,
 					     int nelems, int direction)
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 7799c2b27849..8916499d2805 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -360,6 +360,13 @@ static inline void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
 	debug_dma_sync_single_for_cpu(dev, addr, size, dir);
 }
 
+static inline void dma_sync_single_range_for_cpu(struct device *dev,
+		dma_addr_t addr, unsigned long offset, size_t size,
+		enum dma_data_direction dir)
+{
+	return dma_sync_single_for_cpu(dev, addr + offset, size, dir);
+}
+
 static inline void dma_sync_single_for_device(struct device *dev,
 					      dma_addr_t addr, size_t size,
 					      enum dma_data_direction dir)
@@ -372,32 +379,11 @@ static inline void dma_sync_single_for_device(struct device *dev,
 	debug_dma_sync_single_for_device(dev, addr, size, dir);
 }
 
-static inline void dma_sync_single_range_for_cpu(struct device *dev,
-						 dma_addr_t addr,
-						 unsigned long offset,
-						 size_t size,
-						 enum dma_data_direction dir)
-{
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-
-	BUG_ON(!valid_dma_direction(dir));
-	if (ops->sync_single_for_cpu)
-		ops->sync_single_for_cpu(dev, addr + offset, size, dir);
-	debug_dma_sync_single_range_for_cpu(dev, addr, offset, size, dir);
-}
-
 static inline void dma_sync_single_range_for_device(struct device *dev,
-						    dma_addr_t addr,
-						    unsigned long offset,
-						    size_t size,
-						    enum dma_data_direction dir)
+		dma_addr_t addr, unsigned long offset, size_t size,
+		enum dma_data_direction dir)
 {
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-
-	BUG_ON(!valid_dma_direction(dir));
-	if (ops->sync_single_for_device)
-		ops->sync_single_for_device(dev, addr + offset, size, dir);
-	debug_dma_sync_single_range_for_device(dev, addr, offset, size, dir);
+	return dma_sync_single_for_device(dev, addr + offset, size, dir);
 }
 
 static inline void
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 231ca4628062..3214833b47e2 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1662,48 +1662,6 @@ void debug_dma_sync_single_for_device(struct device *dev,
 }
 EXPORT_SYMBOL(debug_dma_sync_single_for_device);
 
-void debug_dma_sync_single_range_for_cpu(struct device *dev,
-					 dma_addr_t dma_handle,
-					 unsigned long offset, size_t size,
-					 int direction)
-{
-	struct dma_debug_entry ref;
-
-	if (unlikely(dma_debug_disabled()))
-		return;
-
-	ref.type         = dma_debug_single;
-	ref.dev          = dev;
-	ref.dev_addr     = dma_handle;
-	ref.size         = offset + size;
-	ref.direction    = direction;
-	ref.sg_call_ents = 0;
-
-	check_sync(dev, &ref, true);
-}
-EXPORT_SYMBOL(debug_dma_sync_single_range_for_cpu);
-
-void debug_dma_sync_single_range_for_device(struct device *dev,
-					    dma_addr_t dma_handle,
-					    unsigned long offset,
-					    size_t size, int direction)
-{
-	struct dma_debug_entry ref;
-
-	if (unlikely(dma_debug_disabled()))
-		return;
-
-	ref.type         = dma_debug_single;
-	ref.dev          = dev;
-	ref.dev_addr     = dma_handle;
-	ref.size         = offset + size;
-	ref.direction    = direction;
-	ref.sg_call_ents = 0;
-
-	check_sync(dev, &ref, false);
-}
-EXPORT_SYMBOL(debug_dma_sync_single_range_for_device);
-
 void debug_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
 			       int nelems, int direction)
 {
-- 
2.19.1
