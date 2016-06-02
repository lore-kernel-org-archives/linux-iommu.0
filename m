From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [RFC v3 31/45] microblaze: dma-mapping: Use unsigned long for
	dma_attrs
Date: Thu, 02 Jun 2016 17:39:33 +0200
Message-ID: <1464881987-13203-32-git-send-email-k.kozlowski__21000.6851041273$1464882273$gmane$org@samsung.com>
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
 arch/microblaze/include/asm/dma-mapping.h |  1 -
 arch/microblaze/kernel/dma.c              | 12 ++++++------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/microblaze/include/asm/dma-mapping.h b/arch/microblaze/include/asm/dma-mapping.h
index 1884783d15c0..1768d4bdc8d3 100644
--- a/arch/microblaze/include/asm/dma-mapping.h
+++ b/arch/microblaze/include/asm/dma-mapping.h
@@ -25,7 +25,6 @@
 #include <linux/mm.h>
 #include <linux/scatterlist.h>
 #include <linux/dma-debug.h>
-#include <linux/dma-attrs.h>
 #include <asm/io.h>
 #include <asm/cacheflush.h>
 
diff --git a/arch/microblaze/kernel/dma.c b/arch/microblaze/kernel/dma.c
index bf4dec229437..ec04dc1e2527 100644
--- a/arch/microblaze/kernel/dma.c
+++ b/arch/microblaze/kernel/dma.c
@@ -17,7 +17,7 @@
 
 static void *dma_direct_alloc_coherent(struct device *dev, size_t size,
 				       dma_addr_t *dma_handle, gfp_t flag,
-				       struct dma_attrs *attrs)
+				       unsigned long attrs)
 {
 #ifdef NOT_COHERENT_CACHE
 	return consistent_alloc(flag, size, dma_handle);
@@ -42,7 +42,7 @@ static void *dma_direct_alloc_coherent(struct device *dev, size_t size,
 
 static void dma_direct_free_coherent(struct device *dev, size_t size,
 				     void *vaddr, dma_addr_t dma_handle,
-				     struct dma_attrs *attrs)
+				     unsigned long attrs)
 {
 #ifdef NOT_COHERENT_CACHE
 	consistent_free(size, vaddr);
@@ -53,7 +53,7 @@ static void dma_direct_free_coherent(struct device *dev, size_t size,
 
 static int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl,
 			     int nents, enum dma_data_direction direction,
-			     struct dma_attrs *attrs)
+			     unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i;
@@ -78,7 +78,7 @@ static inline dma_addr_t dma_direct_map_page(struct device *dev,
 					     unsigned long offset,
 					     size_t size,
 					     enum dma_data_direction direction,
-					     struct dma_attrs *attrs)
+					     unsigned long attrs)
 {
 	__dma_sync(page_to_phys(page) + offset, size, direction);
 	return page_to_phys(page) + offset;
@@ -88,7 +88,7 @@ static inline void dma_direct_unmap_page(struct device *dev,
 					 dma_addr_t dma_address,
 					 size_t size,
 					 enum dma_data_direction direction,
-					 struct dma_attrs *attrs)
+					 unsigned long attrs)
 {
 /* There is not necessary to do cache cleanup
  *
@@ -157,7 +157,7 @@ dma_direct_sync_sg_for_device(struct device *dev,
 static
 int dma_direct_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
 			     void *cpu_addr, dma_addr_t handle, size_t size,
-			     struct dma_attrs *attrs)
+			     unsigned long attrs)
 {
 #ifdef CONFIG_MMU
 	unsigned long user_count = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
-- 
1.9.1
