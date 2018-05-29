From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 1/3] nds32: consolidate DMA cache maintainance routines
Date: Tue, 29 May 2018 11:48:12 +0200
Message-ID: <20180529094814.17644-2-hch@lst.de>
References: <20180529094814.17644-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180529094814.17644-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Make sure all other DMA methods call nds32_dma_sync_single_for_{device,cpu}
to perform cache maintaince, and remove the consisteny_sync helper that
implemented both with entirely separate code based off an argument.

Also make sure these helpers handled highmem properly, for which code
is copy and pasted from mips.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 arch/nds32/kernel/dma.c | 187 ++++++++++++++++++++--------------------
 1 file changed, 93 insertions(+), 94 deletions(-)

diff --git a/arch/nds32/kernel/dma.c b/arch/nds32/kernel/dma.c
index d291800fc621..e0c94a2889c5 100644
--- a/arch/nds32/kernel/dma.c
+++ b/arch/nds32/kernel/dma.c
@@ -22,11 +22,6 @@
 static pte_t *consistent_pte;
 static DEFINE_RAW_SPINLOCK(consistent_lock);
 
-enum master_type {
-	FOR_CPU = 0,
-	FOR_DEVICE = 1,
-};
-
 /*
  * VM region handling support.
  *
@@ -333,106 +328,105 @@ static int __init consistent_init(void)
 }
 
 core_initcall(consistent_init);
-static void consistent_sync(void *vaddr, size_t size, int direction, int master_type);
-static dma_addr_t nds32_dma_map_page(struct device *dev, struct page *page,
-				     unsigned long offset, size_t size,
-				     enum dma_data_direction dir,
-				     unsigned long attrs)
-{
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		consistent_sync((void *)(page_address(page) + offset), size, dir, FOR_DEVICE);
-	return page_to_phys(page) + offset;
-}
-
-static void nds32_dma_unmap_page(struct device *dev, dma_addr_t handle,
-				 size_t size, enum dma_data_direction dir,
-				 unsigned long attrs)
-{
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		consistent_sync(phys_to_virt(handle), size, dir, FOR_CPU);
-}
 
-/*
- * Make an area consistent for devices.
- */
-static void consistent_sync(void *vaddr, size_t size, int direction, int master_type)
+static inline void cache_op(phys_addr_t paddr, size_t size,
+		void (*fn)(unsigned long start, unsigned long end))
 {
-	unsigned long start = (unsigned long)vaddr;
-	unsigned long end = start + size;
+	struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
+	unsigned offset = paddr & ~PAGE_MASK;
+	size_t left = size;
+	unsigned long start;
 
-	if (master_type == FOR_CPU) {
-		switch (direction) {
-		case DMA_TO_DEVICE:
-			break;
-		case DMA_FROM_DEVICE:
-		case DMA_BIDIRECTIONAL:
-			cpu_dma_inval_range(start, end);
-			break;
-		default:
-			BUG();
-		}
-	} else {
-		/* FOR_DEVICE */
-		switch (direction) {
-		case DMA_FROM_DEVICE:
-			break;
-		case DMA_TO_DEVICE:
-		case DMA_BIDIRECTIONAL:
-			cpu_dma_wb_range(start, end);
-			break;
-		default:
-			BUG();
-		}
-	}
-}
-
-static int nds32_dma_map_sg(struct device *dev, struct scatterlist *sg,
-			    int nents, enum dma_data_direction dir,
-			    unsigned long attrs)
-{
-	int i;
-
-	for (i = 0; i < nents; i++, sg++) {
-		void *virt;
-		unsigned long pfn;
-		struct page *page = sg_page(sg);
+	do {
+		size_t len = left;
 
-		sg->dma_address = sg_phys(sg);
-		pfn = page_to_pfn(page) + sg->offset / PAGE_SIZE;
-		page = pfn_to_page(pfn);
 		if (PageHighMem(page)) {
-			virt = kmap_atomic(page);
-			consistent_sync(virt, sg->length, dir, FOR_CPU);
-			kunmap_atomic(virt);
+			void *addr;
+
+			if (offset + len > PAGE_SIZE) {
+				if (offset >= PAGE_SIZE) {
+					page += offset >> PAGE_SHIFT;
+					offset &= ~PAGE_MASK;
+				}
+				len = PAGE_SIZE - offset;
+			}
+
+			addr = kmap_atomic(page);
+			start = (unsigned long)(addr + offset);
+			fn(start, start + len);
+			kunmap_atomic(addr);
 		} else {
-			if (sg->offset > PAGE_SIZE)
-				panic("sg->offset:%08x > PAGE_SIZE\n",
-				      sg->offset);
-			virt = page_address(page) + sg->offset;
-			consistent_sync(virt, sg->length, dir, FOR_CPU);
+			start = (unsigned long)phys_to_virt(paddr);
+			fn(start, start + size);
 		}
-	}
-	return nents;
+		offset = 0;
+		page++;
+		left -= len;
+	} while (left);
 }
 
-static void nds32_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
-			       int nhwentries, enum dma_data_direction dir,
-			       unsigned long attrs)
+static void
+nds32_dma_sync_single_for_device(struct device *dev, dma_addr_t handle,
+				 size_t size, enum dma_data_direction dir)
 {
+	switch (dir) {
+	case DMA_FROM_DEVICE:
+		break;
+	case DMA_TO_DEVICE:
+	case DMA_BIDIRECTIONAL:
+		cache_op(handle, size, cpu_dma_wb_range);
+		break;
+	default:
+		BUG();
+	}
 }
 
 static void
 nds32_dma_sync_single_for_cpu(struct device *dev, dma_addr_t handle,
 			      size_t size, enum dma_data_direction dir)
 {
-	consistent_sync((void *)phys_to_virt(handle), size, dir, FOR_CPU);
+	switch (dir) {
+	case DMA_TO_DEVICE:
+		break;
+	case DMA_FROM_DEVICE:
+	case DMA_BIDIRECTIONAL:
+		cache_op(handle, size, cpu_dma_inval_range);
+		break;
+	default:
+		BUG();
+	}
+}
+
+static dma_addr_t nds32_dma_map_page(struct device *dev, struct page *page,
+				     unsigned long offset, size_t size,
+				     enum dma_data_direction dir,
+				     unsigned long attrs)
+{
+	dma_addr_t dma_addr = page_to_phys(page) + offset;
+
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		nds32_dma_sync_single_for_device(dev, handle, size, dir);
+	return dma_addr;
+}
+
+static void nds32_dma_unmap_page(struct device *dev, dma_addr_t handle,
+				 size_t size, enum dma_data_direction dir,
+				 unsigned long attrs)
+{
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		nds32_dma_sync_single_for_cpu(dev, handle, size, dir);
 }
 
 static void
-nds32_dma_sync_single_for_device(struct device *dev, dma_addr_t handle,
-				 size_t size, enum dma_data_direction dir)
+nds32_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
+			     int nents, enum dma_data_direction dir)
 {
-	consistent_sync((void *)phys_to_virt(handle), size, dir, FOR_DEVICE);
+	int i;
+
+	for (i = 0; i < nents; i++, sg++) {
+		nds32_dma_sync_single_for_device(dev, sg_dma_address(sg),
+				sg->length, dir);
+	}
 }
 
 static void
@@ -442,23 +436,28 @@ nds32_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int nents,
 	int i;
 
 	for (i = 0; i < nents; i++, sg++) {
-		char *virt =
-		    page_address((struct page *)sg->page_link) + sg->offset;
-		consistent_sync(virt, sg->length, dir, FOR_CPU);
+		nds32_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
+				sg->length, dir);
 	}
 }
 
-static void
-nds32_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
-			     int nents, enum dma_data_direction dir)
+static int nds32_dma_map_sg(struct device *dev, struct scatterlist *sg,
+			    int nents, enum dma_data_direction dir,
+			    unsigned long attrs)
 {
 	int i;
 
 	for (i = 0; i < nents; i++, sg++) {
-		char *virt =
-		    page_address((struct page *)sg->page_link) + sg->offset;
-		consistent_sync(virt, sg->length, dir, FOR_DEVICE);
+		nds32_dma_sync_single_for_device(dev, sg_dma_address(sg),
+				sg->length, dir);
 	}
+	return nents;
+}
+
+static void nds32_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
+			       int nhwentries, enum dma_data_direction dir,
+			       unsigned long attrs)
+{
 }
 
 struct dma_map_ops nds32_dma_ops = {
-- 
2.17.0
