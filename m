From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 1/4] swiotlb-xen: make instances match their method names
Date: Thu, 11 Apr 2019 09:19:57 +0200
Message-ID: <20190411072000.4306-2-hch@lst.de>
References: <20190411072000.4306-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190411072000.4306-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Boris Ostrovsky <boris.ostrovsky-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Juergen Gross <jgross-IBi9RG/b67k@public.gmane.org>, Stefano Stabellini <sstabellini-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Just drop two pointless _attrs prefixes to make the code a little
more grep-able.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 drivers/xen/swiotlb-xen.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 877baf2a94f4..d4bc3aabd44d 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -504,9 +504,8 @@ xen_swiotlb_sync_single_for_device(struct device *hwdev, dma_addr_t dev_addr,
  * concerning calls here are the same as for swiotlb_unmap_page() above.
  */
 static void
-xen_swiotlb_unmap_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
-			   int nelems, enum dma_data_direction dir,
-			   unsigned long attrs)
+xen_swiotlb_unmap_sg(struct device *hwdev, struct scatterlist *sgl, int nelems,
+		enum dma_data_direction dir, unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i;
@@ -535,9 +534,8 @@ xen_swiotlb_unmap_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
  * same here.
  */
 static int
-xen_swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
-			 int nelems, enum dma_data_direction dir,
-			 unsigned long attrs)
+xen_swiotlb_map_sg(struct device *hwdev, struct scatterlist *sgl, int nelems,
+		enum dma_data_direction dir, unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i;
@@ -562,8 +560,7 @@ xen_swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
 				/* Don't panic here, we expect map_sg users
 				   to do proper error handling. */
 				attrs |= DMA_ATTR_SKIP_CPU_SYNC;
-				xen_swiotlb_unmap_sg_attrs(hwdev, sgl, i, dir,
-							   attrs);
+				xen_swiotlb_unmap_sg(hwdev, sgl, i, dir, attrs);
 				sg_dma_len(sgl) = 0;
 				return 0;
 			}
@@ -690,8 +687,8 @@ const struct dma_map_ops xen_swiotlb_dma_ops = {
 	.sync_single_for_device = xen_swiotlb_sync_single_for_device,
 	.sync_sg_for_cpu = xen_swiotlb_sync_sg_for_cpu,
 	.sync_sg_for_device = xen_swiotlb_sync_sg_for_device,
-	.map_sg = xen_swiotlb_map_sg_attrs,
-	.unmap_sg = xen_swiotlb_unmap_sg_attrs,
+	.map_sg = xen_swiotlb_map_sg,
+	.unmap_sg = xen_swiotlb_unmap_sg,
 	.map_page = xen_swiotlb_map_page,
 	.unmap_page = xen_swiotlb_unmap_page,
 	.dma_supported = xen_swiotlb_dma_supported,
-- 
2.20.1
