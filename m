From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [RFC v3 32/45] mips: dma-mapping: Use unsigned long for dma_attrs
Date: Thu, 02 Jun 2016 17:39:34 +0200
Message-ID: <1464881987-13203-33-git-send-email-k.kozlowski__316.914756740694$1464882246$gmane$org@samsung.com>
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
 arch/mips/cavium-octeon/dma-octeon.c      |  8 ++++----
 arch/mips/loongson64/common/dma-swiotlb.c | 10 +++++-----
 arch/mips/mm/dma-default.c                | 14 +++++++-------
 arch/mips/netlogic/common/nlm-dma.c       |  4 ++--
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/mips/cavium-octeon/dma-octeon.c b/arch/mips/cavium-octeon/dma-octeon.c
index 2cd45f5f9481..fd69528b24fb 100644
--- a/arch/mips/cavium-octeon/dma-octeon.c
+++ b/arch/mips/cavium-octeon/dma-octeon.c
@@ -125,7 +125,7 @@ static phys_addr_t octeon_small_dma_to_phys(struct device *dev,
 
 static dma_addr_t octeon_dma_map_page(struct device *dev, struct page *page,
 	unsigned long offset, size_t size, enum dma_data_direction direction,
-	struct dma_attrs *attrs)
+	unsigned long attrs)
 {
 	dma_addr_t daddr = swiotlb_map_page(dev, page, offset, size,
 					    direction, attrs);
@@ -135,7 +135,7 @@ static dma_addr_t octeon_dma_map_page(struct device *dev, struct page *page,
 }
 
 static int octeon_dma_map_sg(struct device *dev, struct scatterlist *sg,
-	int nents, enum dma_data_direction direction, struct dma_attrs *attrs)
+	int nents, enum dma_data_direction direction, unsigned long attrs)
 {
 	int r = swiotlb_map_sg_attrs(dev, sg, nents, direction, attrs);
 	mb();
@@ -157,7 +157,7 @@ static void octeon_dma_sync_sg_for_device(struct device *dev,
 }
 
 static void *octeon_dma_alloc_coherent(struct device *dev, size_t size,
-	dma_addr_t *dma_handle, gfp_t gfp, struct dma_attrs *attrs)
+	dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
 	void *ret;
 
@@ -189,7 +189,7 @@ static void *octeon_dma_alloc_coherent(struct device *dev, size_t size,
 }
 
 static void octeon_dma_free_coherent(struct device *dev, size_t size,
-	void *vaddr, dma_addr_t dma_handle, struct dma_attrs *attrs)
+	void *vaddr, dma_addr_t dma_handle, unsigned long attrs)
 {
 	swiotlb_free_coherent(dev, size, vaddr, dma_handle);
 }
diff --git a/arch/mips/loongson64/common/dma-swiotlb.c b/arch/mips/loongson64/common/dma-swiotlb.c
index 4ffa6fc81c8f..1a80b6f73ab2 100644
--- a/arch/mips/loongson64/common/dma-swiotlb.c
+++ b/arch/mips/loongson64/common/dma-swiotlb.c
@@ -10,7 +10,7 @@
 #include <dma-coherence.h>
 
 static void *loongson_dma_alloc_coherent(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t gfp, struct dma_attrs *attrs)
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
 	void *ret;
 
@@ -41,7 +41,7 @@ static void *loongson_dma_alloc_coherent(struct device *dev, size_t size,
 }
 
 static void loongson_dma_free_coherent(struct device *dev, size_t size,
-		void *vaddr, dma_addr_t dma_handle, struct dma_attrs *attrs)
+		void *vaddr, dma_addr_t dma_handle, unsigned long attrs)
 {
 	swiotlb_free_coherent(dev, size, vaddr, dma_handle);
 }
@@ -49,7 +49,7 @@ static void loongson_dma_free_coherent(struct device *dev, size_t size,
 static dma_addr_t loongson_dma_map_page(struct device *dev, struct page *page,
 				unsigned long offset, size_t size,
 				enum dma_data_direction dir,
-				struct dma_attrs *attrs)
+				unsigned long attrs)
 {
 	dma_addr_t daddr = swiotlb_map_page(dev, page, offset, size,
 					dir, attrs);
@@ -59,9 +59,9 @@ static dma_addr_t loongson_dma_map_page(struct device *dev, struct page *page,
 
 static int loongson_dma_map_sg(struct device *dev, struct scatterlist *sg,
 				int nents, enum dma_data_direction dir,
-				struct dma_attrs *attrs)
+				unsigned long attrs)
 {
-	int r = swiotlb_map_sg_attrs(dev, sg, nents, dir, NULL);
+	int r = swiotlb_map_sg_attrs(dev, sg, nents, dir, 0);
 	mb();
 
 	return r;
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index cb557d28cb21..c9052108094f 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -131,7 +131,7 @@ static void *mips_dma_alloc_noncoherent(struct device *dev, size_t size,
 }
 
 static void *mips_dma_alloc_coherent(struct device *dev, size_t size,
-	dma_addr_t * dma_handle, gfp_t gfp, struct dma_attrs *attrs)
+	dma_addr_t * dma_handle, gfp_t gfp, unsigned long attrs)
 {
 	void *ret;
 	struct page *page = NULL;
@@ -176,7 +176,7 @@ static void mips_dma_free_noncoherent(struct device *dev, size_t size,
 }
 
 static void mips_dma_free_coherent(struct device *dev, size_t size, void *vaddr,
-	dma_addr_t dma_handle, struct dma_attrs *attrs)
+	dma_addr_t dma_handle, unsigned long attrs)
 {
 	unsigned long addr = (unsigned long) vaddr;
 	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
@@ -200,7 +200,7 @@ static void mips_dma_free_coherent(struct device *dev, size_t size, void *vaddr,
 
 static int mips_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 	void *cpu_addr, dma_addr_t dma_addr, size_t size,
-	struct dma_attrs *attrs)
+	unsigned long attrs)
 {
 	unsigned long user_count = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
 	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
@@ -291,7 +291,7 @@ static inline void __dma_sync(struct page *page,
 }
 
 static void mips_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
-	size_t size, enum dma_data_direction direction, struct dma_attrs *attrs)
+	size_t size, enum dma_data_direction direction, unsigned long attrs)
 {
 	if (cpu_needs_post_dma_flush(dev))
 		__dma_sync(dma_addr_to_page(dev, dma_addr),
@@ -301,7 +301,7 @@ static void mips_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
 }
 
 static int mips_dma_map_sg(struct device *dev, struct scatterlist *sglist,
-	int nents, enum dma_data_direction direction, struct dma_attrs *attrs)
+	int nents, enum dma_data_direction direction, unsigned long attrs)
 {
 	int i;
 	struct scatterlist *sg;
@@ -322,7 +322,7 @@ static int mips_dma_map_sg(struct device *dev, struct scatterlist *sglist,
 
 static dma_addr_t mips_dma_map_page(struct device *dev, struct page *page,
 	unsigned long offset, size_t size, enum dma_data_direction direction,
-	struct dma_attrs *attrs)
+	unsigned long attrs)
 {
 	if (!plat_device_is_coherent(dev))
 		__dma_sync(page, offset, size, direction);
@@ -332,7 +332,7 @@ static dma_addr_t mips_dma_map_page(struct device *dev, struct page *page,
 
 static void mips_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
 	int nhwentries, enum dma_data_direction direction,
-	struct dma_attrs *attrs)
+	unsigned long attrs)
 {
 	int i;
 	struct scatterlist *sg;
diff --git a/arch/mips/netlogic/common/nlm-dma.c b/arch/mips/netlogic/common/nlm-dma.c
index 3758715d4ab6..0630693bec2a 100644
--- a/arch/mips/netlogic/common/nlm-dma.c
+++ b/arch/mips/netlogic/common/nlm-dma.c
@@ -45,7 +45,7 @@
 static char *nlm_swiotlb;
 
 static void *nlm_dma_alloc_coherent(struct device *dev, size_t size,
-	dma_addr_t *dma_handle, gfp_t gfp, struct dma_attrs *attrs)
+	dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
 	/* ignore region specifiers */
 	gfp &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
@@ -62,7 +62,7 @@ static void *nlm_dma_alloc_coherent(struct device *dev, size_t size,
 }
 
 static void nlm_dma_free_coherent(struct device *dev, size_t size,
-	void *vaddr, dma_addr_t dma_handle, struct dma_attrs *attrs)
+	void *vaddr, dma_addr_t dma_handle, unsigned long attrs)
 {
 	swiotlb_free_coherent(dev, size, vaddr, dma_handle);
 }
-- 
1.9.1
