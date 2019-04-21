From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v3 04/10] swiotlb: Extend swiotlb to support page bounce
Date: Sun, 21 Apr 2019 09:17:13 +0800
Message-ID: <20190421011719.14909-5-baolu.lu@linux.intel.com>
References: <20190421011719.14909-1-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190421011719.14909-1-baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, alan.cox-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pengfei.xu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This extends below swiotlb APIs to support page bounce.

- swiotlb_tbl_map_single()
- swiotlb_tbl_unmap_single()

In page bounce manner, swiotlb allocates a whole page from the
slot pool, syncs the data, and returns the start place of the
bounced buffer in the page. The caller is responsible to sync
the data after DMA transfer with swiotlb_tbl_sync_single().

In order to distinguish page bounce from other type of bounces,
this introduces a new DMA attribution bit (DMA_ATTR_BOUNCE_PAGE)
which will be set in the @attrs passed to these APIs.

Cc: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 include/linux/dma-mapping.h |  6 +++++
 kernel/dma/swiotlb.c        | 53 ++++++++++++++++++++++++++++++++-----
 2 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 75e60be91e5f..26e506e5b04c 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -70,6 +70,12 @@
  */
 #define DMA_ATTR_PRIVILEGED		(1UL << 9)
 
+/*
+ * DMA_ATTR_BOUNCE_PAGE: used by the IOMMU sub-system to indicate that
+ * the buffer is used as a bounce page in the DMA remapping page table.
+ */
+#define DMA_ATTR_BOUNCE_PAGE		(1UL << 10)
+
 /*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.
  * It can be given to a device to use as a DMA source or target.  A CPU cannot
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index dbb937ce79c8..96b87a11dee1 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -34,6 +34,7 @@
 #include <linux/scatterlist.h>
 #include <linux/mem_encrypt.h>
 #include <linux/set_memory.h>
+#include <linux/iommu.h>
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
 #endif
@@ -596,6 +597,14 @@ swiotlb_tbl_free_tlb(struct device *hwdev, phys_addr_t tlb_addr, size_t size)
 	spin_unlock_irqrestore(&io_tlb_lock, flags);
 }
 
+static unsigned long
+get_iommu_pgsize(struct device *dev, phys_addr_t phys, size_t size)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	return domain_minimal_pgsize(domain);
+}
+
 phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 				   dma_addr_t tbl_dma_addr,
 				   phys_addr_t orig_addr, size_t size,
@@ -603,17 +612,37 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 				   unsigned long attrs)
 {
 	phys_addr_t tlb_addr;
+	unsigned long offset = 0;
+
+	if (attrs & DMA_ATTR_BOUNCE_PAGE) {
+		unsigned long pgsize = get_iommu_pgsize(hwdev, orig_addr, size);
+
+		offset = orig_addr & (pgsize - 1);
+
+		/* Don't allow the buffer to cross page boundary. */
+		if (offset + size > pgsize)
+			return DMA_MAPPING_ERROR;
+
+		tlb_addr = swiotlb_tbl_alloc_tlb(hwdev,
+				__phys_to_dma(hwdev, io_tlb_start),
+				ALIGN_DOWN(orig_addr, pgsize), pgsize);
+	} else {
+		tlb_addr = swiotlb_tbl_alloc_tlb(hwdev,
+				tbl_dma_addr, orig_addr, size);
+	}
 
-	tlb_addr = swiotlb_tbl_alloc_tlb(hwdev, tbl_dma_addr, orig_addr, size);
 	if (tlb_addr == DMA_MAPPING_ERROR) {
 		if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
 			dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes)\n",
 				 size);
-	} else if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
-		   (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL)) {
-		swiotlb_bounce(orig_addr, tlb_addr, size, DMA_TO_DEVICE);
+		return DMA_MAPPING_ERROR;
 	}
 
+	tlb_addr += offset;
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
+		swiotlb_bounce(orig_addr, tlb_addr, size, DMA_TO_DEVICE);
+
 	return tlb_addr;
 }
 
@@ -626,6 +655,10 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 {
 	int index = (tlb_addr - io_tlb_start) >> IO_TLB_SHIFT;
 	phys_addr_t orig_addr = io_tlb_orig_addr[index];
+	unsigned long offset = 0;
+
+	if (attrs & DMA_ATTR_BOUNCE_PAGE)
+		offset = tlb_addr & ((1 << IO_TLB_SHIFT) - 1);
 
 	/*
 	 * First, sync the memory before unmapping the entry
@@ -633,9 +666,17 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 	if (orig_addr != INVALID_PHYS_ADDR &&
 	    !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    ((dir == DMA_FROM_DEVICE) || (dir == DMA_BIDIRECTIONAL)))
-		swiotlb_bounce(orig_addr, tlb_addr, size, DMA_FROM_DEVICE);
+		swiotlb_bounce(orig_addr + offset,
+			       tlb_addr, size, DMA_FROM_DEVICE);
+
+	if (attrs & DMA_ATTR_BOUNCE_PAGE) {
+		unsigned long pgsize = get_iommu_pgsize(hwdev, tlb_addr, size);
 
-	swiotlb_tbl_free_tlb(hwdev, tlb_addr, size);
+		swiotlb_tbl_free_tlb(hwdev,
+				     ALIGN_DOWN(tlb_addr, pgsize), pgsize);
+	} else {
+		swiotlb_tbl_free_tlb(hwdev, tlb_addr, size);
+	}
 }
 
 void swiotlb_tbl_sync_single(struct device *hwdev, phys_addr_t tlb_addr,
-- 
2.17.1
