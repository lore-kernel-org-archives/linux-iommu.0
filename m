From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [RFC v3 38/45] s390: dma-mapping: Use unsigned long for dma_attrs
Date: Thu, 02 Jun 2016 17:39:40 +0200
Message-ID: <1464881987-13203-39-git-send-email-k.kozlowski__2411.17126211083$1464882296$gmane$org@samsung.com>
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
 arch/s390/include/asm/dma-mapping.h |  1 -
 arch/s390/pci/pci_dma.c             | 23 ++++++++++++-----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/s390/include/asm/dma-mapping.h b/arch/s390/include/asm/dma-mapping.h
index 3249b7464889..ffaba07f50ab 100644
--- a/arch/s390/include/asm/dma-mapping.h
+++ b/arch/s390/include/asm/dma-mapping.h
@@ -5,7 +5,6 @@
 #include <linux/types.h>
 #include <linux/mm.h>
 #include <linux/scatterlist.h>
-#include <linux/dma-attrs.h>
 #include <linux/dma-debug.h>
 #include <linux/io.h>
 
diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
index 1ea8c07eab84..159f767f9011 100644
--- a/arch/s390/pci/pci_dma.c
+++ b/arch/s390/pci/pci_dma.c
@@ -285,7 +285,7 @@ static inline void zpci_err_dma(unsigned long rc, unsigned long addr)
 static dma_addr_t s390_dma_map_pages(struct device *dev, struct page *page,
 				     unsigned long offset, size_t size,
 				     enum dma_data_direction direction,
-				     struct dma_attrs *attrs)
+				     unsigned long attrs)
 {
 	struct zpci_dev *zdev = to_zpci(to_pci_dev(dev));
 	unsigned long nr_pages, iommu_page_index;
@@ -331,7 +331,7 @@ out_err:
 
 static void s390_dma_unmap_pages(struct device *dev, dma_addr_t dma_addr,
 				 size_t size, enum dma_data_direction direction,
-				 struct dma_attrs *attrs)
+				 unsigned long attrs)
 {
 	struct zpci_dev *zdev = to_zpci(to_pci_dev(dev));
 	unsigned long iommu_page_index;
@@ -354,7 +354,7 @@ static void s390_dma_unmap_pages(struct device *dev, dma_addr_t dma_addr,
 
 static void *s390_dma_alloc(struct device *dev, size_t size,
 			    dma_addr_t *dma_handle, gfp_t flag,
-			    struct dma_attrs *attrs)
+			    unsigned long attrs)
 {
 	struct zpci_dev *zdev = to_zpci(to_pci_dev(dev));
 	struct page *page;
@@ -369,7 +369,7 @@ static void *s390_dma_alloc(struct device *dev, size_t size,
 	pa = page_to_phys(page);
 	memset((void *) pa, 0, size);
 
-	map = s390_dma_map_pages(dev, page, 0, size, DMA_BIDIRECTIONAL, NULL);
+	map = s390_dma_map_pages(dev, page, 0, size, DMA_BIDIRECTIONAL, 0);
 	if (dma_mapping_error(dev, map)) {
 		free_pages(pa, get_order(size));
 		return NULL;
@@ -383,19 +383,19 @@ static void *s390_dma_alloc(struct device *dev, size_t size,
 
 static void s390_dma_free(struct device *dev, size_t size,
 			  void *pa, dma_addr_t dma_handle,
-			  struct dma_attrs *attrs)
+			  unsigned long attrs)
 {
 	struct zpci_dev *zdev = to_zpci(to_pci_dev(dev));
 
 	size = PAGE_ALIGN(size);
 	atomic64_sub(size / PAGE_SIZE, &zdev->allocated_pages);
-	s390_dma_unmap_pages(dev, dma_handle, size, DMA_BIDIRECTIONAL, NULL);
+	s390_dma_unmap_pages(dev, dma_handle, size, DMA_BIDIRECTIONAL, 0);
 	free_pages((unsigned long) pa, get_order(size));
 }
 
 static int s390_dma_map_sg(struct device *dev, struct scatterlist *sg,
 			   int nr_elements, enum dma_data_direction dir,
-			   struct dma_attrs *attrs)
+			   unsigned long attrs)
 {
 	int mapped_elements = 0;
 	struct scatterlist *s;
@@ -404,7 +404,7 @@ static int s390_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	for_each_sg(sg, s, nr_elements, i) {
 		struct page *page = sg_page(s);
 		s->dma_address = s390_dma_map_pages(dev, page, s->offset,
-						    s->length, dir, NULL);
+						    s->length, dir, 0);
 		if (!dma_mapping_error(dev, s->dma_address)) {
 			s->dma_length = s->length;
 			mapped_elements++;
@@ -418,7 +418,7 @@ unmap:
 	for_each_sg(sg, s, mapped_elements, i) {
 		if (s->dma_address)
 			s390_dma_unmap_pages(dev, s->dma_address, s->dma_length,
-					     dir, NULL);
+					     dir, 0);
 		s->dma_address = 0;
 		s->dma_length = 0;
 	}
@@ -428,13 +428,14 @@ unmap:
 
 static void s390_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 			      int nr_elements, enum dma_data_direction dir,
-			      struct dma_attrs *attrs)
+			      unsigned long attrs)
 {
 	struct scatterlist *s;
 	int i;
 
 	for_each_sg(sg, s, nr_elements, i) {
-		s390_dma_unmap_pages(dev, s->dma_address, s->dma_length, dir, NULL);
+		s390_dma_unmap_pages(dev, s->dma_address, s->dma_length, dir,
+				     0);
 		s->dma_address = 0;
 		s->dma_length = 0;
 	}
-- 
1.9.1
