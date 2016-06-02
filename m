From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [RFC v3 41/45] tile: dma-mapping: Use unsigned long for dma_attrs
Date: Thu, 02 Jun 2016 17:39:43 +0200
Message-ID: <1464881987-13203-42-git-send-email-k.kozlowski__43311.7318120368$1464882281$gmane$org@samsung.com>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1464881987-13203-1-git-send-email-k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Richard Henderson <rth-hL46jP5Bxq7R7s880joybQ@public.gmane.org>, Ivan Kokshaysky <ink-biIs/Y0ymYJMZLIVYojuPNP0rXTJTi09@public.gmane.org>, Matt Turner <mattst88-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Vineet Gupta <vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Stefano Stabellini <sstabellini-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Haavard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hans-Christian Egtvedt <egtvedt-BrfabpQBY5qlHtIdYg32fQ@public.gmane.org>, Steven Miao <realmz6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Salter <msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Aurelien Jacquiot <a-jacquiot-l0cyMroinI0@public.gmane.org>, Mikael Starvik <starvik-VrBV9hrLPhE@public.gmane.org>, Jesper Nilsson <jesper.nilsson-VrBV9hrLPhE@public.gmane.org>, Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>, Richard Kuo <rkuo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Cc: hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Split out subsystem specific changes for easier reviews. This will be
squashed with main commit.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 arch/tile/kernel/pci-dma.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/tile/kernel/pci-dma.c b/arch/tile/kernel/pci-dma.c
index b6bc0547a4f6..09bb774b39cd 100644
--- a/arch/tile/kernel/pci-dma.c
+++ b/arch/tile/kernel/pci-dma.c
@@ -34,7 +34,7 @@
 
 static void *tile_dma_alloc_coherent(struct device *dev, size_t size,
 				     dma_addr_t *dma_handle, gfp_t gfp,
-				     struct dma_attrs *attrs)
+				     unsigned long attrs)
 {
 	u64 dma_mask = (dev && dev->coherent_dma_mask) ?
 		dev->coherent_dma_mask : DMA_BIT_MASK(32);
@@ -78,7 +78,7 @@ static void *tile_dma_alloc_coherent(struct device *dev, size_t size,
  */
 static void tile_dma_free_coherent(struct device *dev, size_t size,
 				   void *vaddr, dma_addr_t dma_handle,
-				   struct dma_attrs *attrs)
+				   unsigned long attrs)
 {
 	homecache_free_pages((unsigned long)vaddr, get_order(size));
 }
@@ -202,7 +202,7 @@ static void __dma_complete_pa_range(dma_addr_t dma_addr, size_t size,
 
 static int tile_dma_map_sg(struct device *dev, struct scatterlist *sglist,
 			   int nents, enum dma_data_direction direction,
-			   struct dma_attrs *attrs)
+			   unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i;
@@ -224,7 +224,7 @@ static int tile_dma_map_sg(struct device *dev, struct scatterlist *sglist,
 
 static void tile_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
 			      int nents, enum dma_data_direction direction,
-			      struct dma_attrs *attrs)
+			      unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i;
@@ -240,7 +240,7 @@ static void tile_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
 static dma_addr_t tile_dma_map_page(struct device *dev, struct page *page,
 				    unsigned long offset, size_t size,
 				    enum dma_data_direction direction,
-				    struct dma_attrs *attrs)
+				    unsigned long attrs)
 {
 	BUG_ON(!valid_dma_direction(direction));
 
@@ -252,7 +252,7 @@ static dma_addr_t tile_dma_map_page(struct device *dev, struct page *page,
 
 static void tile_dma_unmap_page(struct device *dev, dma_addr_t dma_address,
 				size_t size, enum dma_data_direction direction,
-				struct dma_attrs *attrs)
+				unsigned long attrs)
 {
 	BUG_ON(!valid_dma_direction(direction));
 
@@ -343,7 +343,7 @@ EXPORT_SYMBOL(tile_dma_map_ops);
 
 static void *tile_pci_dma_alloc_coherent(struct device *dev, size_t size,
 					 dma_addr_t *dma_handle, gfp_t gfp,
-					 struct dma_attrs *attrs)
+					 unsigned long attrs)
 {
 	int node = dev_to_node(dev);
 	int order = get_order(size);
@@ -368,14 +368,14 @@ static void *tile_pci_dma_alloc_coherent(struct device *dev, size_t size,
  */
 static void tile_pci_dma_free_coherent(struct device *dev, size_t size,
 				       void *vaddr, dma_addr_t dma_handle,
-				       struct dma_attrs *attrs)
+				       unsigned long attrs)
 {
 	homecache_free_pages((unsigned long)vaddr, get_order(size));
 }
 
 static int tile_pci_dma_map_sg(struct device *dev, struct scatterlist *sglist,
 			       int nents, enum dma_data_direction direction,
-			       struct dma_attrs *attrs)
+			       unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i;
@@ -400,7 +400,7 @@ static int tile_pci_dma_map_sg(struct device *dev, struct scatterlist *sglist,
 static void tile_pci_dma_unmap_sg(struct device *dev,
 				  struct scatterlist *sglist, int nents,
 				  enum dma_data_direction direction,
-				  struct dma_attrs *attrs)
+				  unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i;
@@ -416,7 +416,7 @@ static void tile_pci_dma_unmap_sg(struct device *dev,
 static dma_addr_t tile_pci_dma_map_page(struct device *dev, struct page *page,
 					unsigned long offset, size_t size,
 					enum dma_data_direction direction,
-					struct dma_attrs *attrs)
+					unsigned long attrs)
 {
 	BUG_ON(!valid_dma_direction(direction));
 
@@ -429,7 +429,7 @@ static dma_addr_t tile_pci_dma_map_page(struct device *dev, struct page *page,
 static void tile_pci_dma_unmap_page(struct device *dev, dma_addr_t dma_address,
 				    size_t size,
 				    enum dma_data_direction direction,
-				    struct dma_attrs *attrs)
+				    unsigned long attrs)
 {
 	BUG_ON(!valid_dma_direction(direction));
 
@@ -531,7 +531,7 @@ EXPORT_SYMBOL(gx_pci_dma_map_ops);
 #ifdef CONFIG_SWIOTLB
 static void *tile_swiotlb_alloc_coherent(struct device *dev, size_t size,
 					 dma_addr_t *dma_handle, gfp_t gfp,
-					 struct dma_attrs *attrs)
+					 unsigned long attrs)
 {
 	gfp |= GFP_DMA;
 	return swiotlb_alloc_coherent(dev, size, dma_handle, gfp);
@@ -539,7 +539,7 @@ static void *tile_swiotlb_alloc_coherent(struct device *dev, size_t size,
 
 static void tile_swiotlb_free_coherent(struct device *dev, size_t size,
 				       void *vaddr, dma_addr_t dma_addr,
-				       struct dma_attrs *attrs)
+				       unsigned long attrs)
 {
 	swiotlb_free_coherent(dev, size, vaddr, dma_addr);
 }
-- 
1.9.1
