From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [RFC v3 37/45] misc: mic: dma-mapping: Use unsigned long for dma_attrs
Date: Thu, 02 Jun 2016 17:39:39 +0200
Message-ID: <1464881987-13203-38-git-send-email-k.kozlowski__13586.1740135171$1464882287$gmane$org@samsung.com>
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
 drivers/misc/mic/host/mic_boot.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/mic/host/mic_boot.c b/drivers/misc/mic/host/mic_boot.c
index e047efd83f57..9599d732aff3 100644
--- a/drivers/misc/mic/host/mic_boot.c
+++ b/drivers/misc/mic/host/mic_boot.c
@@ -38,7 +38,7 @@ static inline struct mic_device *vpdev_to_mdev(struct device *dev)
 static dma_addr_t
 _mic_dma_map_page(struct device *dev, struct page *page,
 		  unsigned long offset, size_t size,
-		  enum dma_data_direction dir, struct dma_attrs *attrs)
+		  enum dma_data_direction dir, unsigned long attrs)
 {
 	void *va = phys_to_virt(page_to_phys(page)) + offset;
 	struct mic_device *mdev = vpdev_to_mdev(dev);
@@ -48,7 +48,7 @@ _mic_dma_map_page(struct device *dev, struct page *page,
 
 static void _mic_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
 				size_t size, enum dma_data_direction dir,
-				struct dma_attrs *attrs)
+				unsigned long attrs)
 {
 	struct mic_device *mdev = vpdev_to_mdev(dev);
 
@@ -144,7 +144,7 @@ static inline struct mic_device *scdev_to_mdev(struct scif_hw_dev *scdev)
 
 static void *__mic_dma_alloc(struct device *dev, size_t size,
 			     dma_addr_t *dma_handle, gfp_t gfp,
-			     struct dma_attrs *attrs)
+			     unsigned long attrs)
 {
 	struct scif_hw_dev *scdev = dev_get_drvdata(dev);
 	struct mic_device *mdev = scdev_to_mdev(scdev);
@@ -164,7 +164,7 @@ static void *__mic_dma_alloc(struct device *dev, size_t size,
 }
 
 static void __mic_dma_free(struct device *dev, size_t size, void *vaddr,
-			   dma_addr_t dma_handle, struct dma_attrs *attrs)
+			   dma_addr_t dma_handle, unsigned long attrs)
 {
 	struct scif_hw_dev *scdev = dev_get_drvdata(dev);
 	struct mic_device *mdev = scdev_to_mdev(scdev);
@@ -176,7 +176,7 @@ static void __mic_dma_free(struct device *dev, size_t size, void *vaddr,
 static dma_addr_t
 __mic_dma_map_page(struct device *dev, struct page *page, unsigned long offset,
 		   size_t size, enum dma_data_direction dir,
-		   struct dma_attrs *attrs)
+		   unsigned long attrs)
 {
 	void *va = phys_to_virt(page_to_phys(page)) + offset;
 	struct scif_hw_dev *scdev = dev_get_drvdata(dev);
@@ -188,7 +188,7 @@ __mic_dma_map_page(struct device *dev, struct page *page, unsigned long offset,
 static void
 __mic_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
 		     size_t size, enum dma_data_direction dir,
-		     struct dma_attrs *attrs)
+		     unsigned long attrs)
 {
 	struct scif_hw_dev *scdev = dev_get_drvdata(dev);
 	struct mic_device *mdev = scdev_to_mdev(scdev);
@@ -198,7 +198,7 @@ __mic_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
 
 static int __mic_dma_map_sg(struct device *dev, struct scatterlist *sg,
 			    int nents, enum dma_data_direction dir,
-			    struct dma_attrs *attrs)
+			    unsigned long attrs)
 {
 	struct scif_hw_dev *scdev = dev_get_drvdata(dev);
 	struct mic_device *mdev = scdev_to_mdev(scdev);
@@ -229,7 +229,7 @@ err:
 static void __mic_dma_unmap_sg(struct device *dev,
 			       struct scatterlist *sg, int nents,
 			       enum dma_data_direction dir,
-			       struct dma_attrs *attrs)
+			       unsigned long attrs)
 {
 	struct scif_hw_dev *scdev = dev_get_drvdata(dev);
 	struct mic_device *mdev = scdev_to_mdev(scdev);
@@ -327,7 +327,7 @@ static inline struct mic_device *mbdev_to_mdev(struct mbus_device *mbdev)
 static dma_addr_t
 mic_dma_map_page(struct device *dev, struct page *page,
 		 unsigned long offset, size_t size, enum dma_data_direction dir,
-		 struct dma_attrs *attrs)
+		 unsigned long attrs)
 {
 	void *va = phys_to_virt(page_to_phys(page)) + offset;
 	struct mic_device *mdev = dev_get_drvdata(dev->parent);
@@ -338,7 +338,7 @@ mic_dma_map_page(struct device *dev, struct page *page,
 static void
 mic_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
 		   size_t size, enum dma_data_direction dir,
-		   struct dma_attrs *attrs)
+		   unsigned long attrs)
 {
 	struct mic_device *mdev = dev_get_drvdata(dev->parent);
 	mic_unmap_single(mdev, dma_addr, size);
-- 
1.9.1
