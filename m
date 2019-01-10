From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/3] swiotlb: Export maximum allocation size
Date: Thu, 10 Jan 2019 14:44:31 +0100
Message-ID: <20190110134433.15672-2-joro@8bytes.org>
References: <20190110134433.15672-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190110134433.15672-1-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Michael S . Tsirkin" <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jason Wang <jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: Jens Axboe <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, brijesh.singh-5C7GfCeVMHo@public.gmane.org, jon.grimm-5C7GfCeVMHo@public.gmane.org, jfehlig-IBi9RG/b67k@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-block-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

The SWIOTLB implementation has a maximum size it can
allocate dma-handles for. This needs to be exported so that
device drivers don't try to allocate larger chunks.

This is especially important for block device drivers like
virtio-blk, that might do DMA through SWIOTLB.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 include/linux/swiotlb.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 7c007ed7505f..0bcc80a97036 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -72,6 +72,11 @@ static inline bool is_swiotlb_buffer(phys_addr_t paddr)
 	return paddr >= io_tlb_start && paddr < io_tlb_end;
 }
 
+static inline size_t swiotlb_max_alloc_size(void)
+{
+	return ((1UL << IO_TLB_SHIFT) * IO_TLB_SEGSIZE);
+}
+
 bool swiotlb_map(struct device *dev, phys_addr_t *phys, dma_addr_t *dma_addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs);
 void __init swiotlb_exit(void);
@@ -95,6 +100,13 @@ static inline unsigned int swiotlb_max_segment(void)
 {
 	return 0;
 }
+
+static inline size_t swiotlb_max_alloc_size(void)
+{
+	/* There is no limit when SWIOTLB isn't used */
+	return ~0UL;
+}
+
 #endif /* CONFIG_SWIOTLB */
 
 extern void swiotlb_print_info(void);
-- 
2.17.1
