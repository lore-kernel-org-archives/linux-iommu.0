From: Huaisheng Ye via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: [PATCH] dma-mapping: remove unused attrs parameter to
	dma_common_get_sgtable
Date: Thu,  3 Jan 2019 16:29:08 +0800
Message-ID: <20190103082908.9988-1-yehs2007@zoho.com>
Reply-To: Huaisheng Ye <yehs2007-ytc+IHgoah0@public.gmane.org>
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
To: hch-jcswGhMUV9g@public.gmane.org
Cc: jgross-IBi9RG/b67k@public.gmane.org, sstabellini-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Huaisheng Ye <yehs1-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>, konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, chengnt-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, boris.ostrovsky-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Huaisheng Ye <yehs1-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>

dma_common_get_sgtable has parameter attrs which is not used at all.
Remove it.

Signed-off-by: Huaisheng Ye <yehs1-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>
---
 drivers/xen/swiotlb-xen.c   | 2 +-
 include/linux/dma-mapping.h | 5 ++---
 kernel/dma/mapping.c        | 3 +--
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 2a7f545..2dc17a5 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -697,7 +697,7 @@ static void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
 							   handle, size, attrs);
 	}
 #endif
-	return dma_common_get_sgtable(dev, sgt, cpu_addr, handle, size, attrs);
+	return dma_common_get_sgtable(dev, sgt, cpu_addr, handle, size);
 }
 
 static int xen_swiotlb_mapping_error(struct device *dev, dma_addr_t dma_addr)
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index d327bdd..bbfad44 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -483,7 +483,7 @@ void *dma_common_pages_remap(struct page **pages, size_t size,
 
 int
 dma_common_get_sgtable(struct device *dev, struct sg_table *sgt, void *cpu_addr,
-		dma_addr_t dma_addr, size_t size, unsigned long attrs);
+		dma_addr_t dma_addr, size_t size);
 
 static inline int
 dma_get_sgtable_attrs(struct device *dev, struct sg_table *sgt, void *cpu_addr,
@@ -495,8 +495,7 @@ void *dma_common_pages_remap(struct page **pages, size_t size,
 	if (ops->get_sgtable)
 		return ops->get_sgtable(dev, sgt, cpu_addr, dma_addr, size,
 					attrs);
-	return dma_common_get_sgtable(dev, sgt, cpu_addr, dma_addr, size,
-			attrs);
+	return dma_common_get_sgtable(dev, sgt, cpu_addr, dma_addr, size);
 }
 
 #define dma_get_sgtable(d, t, v, h, s) dma_get_sgtable_attrs(d, t, v, h, s, 0)
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 58dec7a..6b33f10 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -202,8 +202,7 @@ void dmam_release_declared_memory(struct device *dev)
  * Create scatter-list for the already allocated DMA buffer.
  */
 int dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
-		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		 unsigned long attrs)
+		 void *cpu_addr, dma_addr_t dma_addr, size_t size)
 {
 	struct page *page;
 	int ret;
-- 
1.8.3.1
