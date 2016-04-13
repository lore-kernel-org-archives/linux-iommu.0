From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2] iommu/dma: Finish optimising higher-order allocations
Date: Wed, 13 Apr 2016 17:29:10 +0100
Message-ID: <3e4572cb0a175061c1c4b436e3806ba9d7b9f199.1460563676.git.robin.murphy@arm.com>
References: <89763f6b1ac684c3d8712e38760bec55b7885e3b.1460048991.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <89763f6b1ac684c3d8712e38760bec55b7885e3b.1460048991.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Now that we know exactly which page sizes our caller wants to use in the
given domain, we can restrict higher-order allocation attempts to just
those sizes, if any, and avoid wasting any time or effort on other sizes
which offer no benefit. In the same vein, this also lets us accommodate
a minimum order greater than 0 for special cases.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

Just throwing this out as a quick solo update as I'm still expecting
discussion on the rest of the series.

Since v1:
- Rearrange things so that all allocations happen within the loop,
  and always get split as appropriate.
- Rename a bunch of things to make more sense.
- Got rid of a fair amount of the gratuitous bit-twiddling.

 arch/arm64/mm/dma-mapping.c |  4 +--
 drivers/iommu/dma-iommu.c   | 60 +++++++++++++++++++++++++++++----------------
 include/linux/dma-iommu.h   |  4 +--
 3 files changed, 43 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 5d36907..41d19a0 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -562,8 +562,8 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 		struct page **pages;
 		pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL, coherent);
 
-		pages = iommu_dma_alloc(dev, iosize, gfp, ioprot, handle,
-					flush_page);
+		pages = iommu_dma_alloc(dev, iosize, gfp, attrs, ioprot,
+					handle, flush_page);
 		if (!pages)
 			return NULL;
 
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 6edc852..c67713f 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -190,11 +190,15 @@ static void __iommu_dma_free_pages(struct page **pages, int count)
 	kvfree(pages);
 }
 
-static struct page **__iommu_dma_alloc_pages(unsigned int count, gfp_t gfp)
+static struct page **__iommu_dma_alloc_pages(unsigned int count,
+		unsigned long order_mask, gfp_t gfp)
 {
 	struct page **pages;
 	unsigned int i = 0, array_size = count * sizeof(*pages);
-	unsigned int order = MAX_ORDER;
+
+	order_mask &= (2U << MAX_ORDER) - 1;
+	if (!order_mask)
+		return NULL;
 
 	if (array_size <= PAGE_SIZE)
 		pages = kzalloc(array_size, GFP_KERNEL);
@@ -208,36 +212,38 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count, gfp_t gfp)
 
 	while (count) {
 		struct page *page = NULL;
-		int j;
+		unsigned int order_size;
 
 		/*
 		 * Higher-order allocations are a convenience rather
 		 * than a necessity, hence using __GFP_NORETRY until
-		 * falling back to single-page allocations.
+		 * falling back to minimum-order allocations.
 		 */
-		for (order = min_t(unsigned int, order, __fls(count));
-		     order > 0; order--) {
-			page = alloc_pages(gfp | __GFP_NORETRY, order);
+		for (order_mask &= (2U << __fls(count)) - 1;
+		     order_mask; order_mask &= ~order_size) {
+			unsigned int order = __fls(order_mask);
+
+			order_size = 1U << order;
+			page = alloc_pages((order_mask - order_size) ?
+					   gfp | __GFP_NORETRY : gfp, order);
 			if (!page)
 				continue;
-			if (PageCompound(page)) {
-				if (!split_huge_page(page))
-					break;
-				__free_pages(page, order);
-			} else {
+			if (!order)
+				break;
+			if (!PageCompound(page)) {
 				split_page(page, order);
 				break;
+			} else if (!split_huge_page(page)) {
+				break;
 			}
+			__free_pages(page, order);
 		}
-		if (!page)
-			page = alloc_page(gfp);
 		if (!page) {
 			__iommu_dma_free_pages(pages, i);
 			return NULL;
 		}
-		j = 1 << order;
-		count -= j;
-		while (j--)
+		count -= order_size;
+		while (order_size--)
 			pages[i++] = page++;
 	}
 	return pages;
@@ -267,6 +273,7 @@ void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
  *	 attached to an iommu_dma_domain
  * @size: Size of buffer in bytes
  * @gfp: Allocation flags
+ * @attrs: DMA attributes for this allocation
  * @prot: IOMMU mapping flags
  * @handle: Out argument for allocated DMA handle
  * @flush_page: Arch callback which must ensure PAGE_SIZE bytes from the
@@ -278,8 +285,8 @@ void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
  * Return: Array of struct page pointers describing the buffer,
  *	   or NULL on failure.
  */
-struct page **iommu_dma_alloc(struct device *dev, size_t size,
-		gfp_t gfp, int prot, dma_addr_t *handle,
+struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
+		struct dma_attrs *attrs, int prot, dma_addr_t *handle,
 		void (*flush_page)(struct device *, const void *, phys_addr_t))
 {
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
@@ -288,11 +295,22 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size,
 	struct page **pages;
 	struct sg_table sgt;
 	dma_addr_t dma_addr;
-	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	unsigned int count, min_size, alloc_sizes = domain->pgsize_bitmap;
 
 	*handle = DMA_ERROR_CODE;
 
-	pages = __iommu_dma_alloc_pages(count, gfp);
+	min_size = alloc_sizes & -alloc_sizes;
+	if (min_size < PAGE_SIZE) {
+		min_size = PAGE_SIZE;
+		alloc_sizes |= PAGE_SIZE;
+	} else {
+		size = ALIGN(size, min_size);
+	}
+	if (dma_get_attr(DMA_ATTR_ALLOC_SINGLE_PAGES, attrs))
+		alloc_sizes = min_size;
+
+	count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	pages = __iommu_dma_alloc_pages(count, alloc_sizes >> PAGE_SHIFT, gfp);
 	if (!pages)
 		return NULL;
 
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index fc48103..8443bbb 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -38,8 +38,8 @@ int dma_direction_to_prot(enum dma_data_direction dir, bool coherent);
  * These implement the bulk of the relevant DMA mapping callbacks, but require
  * the arch code to take care of attributes and cache maintenance
  */
-struct page **iommu_dma_alloc(struct device *dev, size_t size,
-		gfp_t gfp, int prot, dma_addr_t *handle,
+struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
+		struct dma_attrs *attrs, int prot, dma_addr_t *handle,
 		void (*flush_page)(struct device *, const void *, phys_addr_t));
 void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
 		dma_addr_t *handle);
-- 
2.7.3.dirty
