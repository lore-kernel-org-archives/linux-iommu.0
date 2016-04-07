From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 4/5] iommu/dma: Finish optimising higher-order allocations
Date: Thu,  7 Apr 2016 18:42:07 +0100
Message-ID: <89763f6b1ac684c3d8712e38760bec55b7885e3b.1460048991.git.robin.murphy@arm.com>
References: <cover.1460048991.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1460048991.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, brian.starkey-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Now that we know exactly which page sizes our caller wants to use in the
given domain, we can restrict higher-order allocation attempts to just
those sizes, if any, and avoid wasting any time or effort on other sizes
which offer no benefit. In the same vein, this also lets us accommodate
a minimum order greater than 0 for special cases.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 arch/arm64/mm/dma-mapping.c |  4 ++--
 drivers/iommu/dma-iommu.c   | 37 ++++++++++++++++++++++++++++---------
 include/linux/dma-iommu.h   |  4 ++--
 3 files changed, 32 insertions(+), 13 deletions(-)

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
index 6edc852..6dc8dfc 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -190,11 +190,16 @@ static void __iommu_dma_free_pages(struct page **pages, int count)
 	kvfree(pages);
 }
 
-static struct page **__iommu_dma_alloc_pages(unsigned int count, gfp_t gfp)
+static struct page **__iommu_dma_alloc_pages(unsigned int count,
+		unsigned long pgsize_orders, gfp_t gfp)
 {
 	struct page **pages;
 	unsigned int i = 0, array_size = count * sizeof(*pages);
-	unsigned int order = MAX_ORDER;
+	unsigned int min_order = __ffs(pgsize_orders);
+
+	pgsize_orders &= (2U << MAX_ORDER) - 1;
+	if (!pgsize_orders)
+		return NULL;
 
 	if (array_size <= PAGE_SIZE)
 		pages = kzalloc(array_size, GFP_KERNEL);
@@ -208,6 +213,7 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count, gfp_t gfp)
 
 	while (count) {
 		struct page *page = NULL;
+		unsigned int order;
 		int j;
 
 		/*
@@ -215,8 +221,9 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count, gfp_t gfp)
 		 * than a necessity, hence using __GFP_NORETRY until
 		 * falling back to single-page allocations.
 		 */
-		for (order = min_t(unsigned int, order, __fls(count));
-		     order > 0; order--) {
+		for (pgsize_orders &= (2U << __fls(count)) - 1;
+		     (order = __fls(pgsize_orders)) > min_order;
+		     pgsize_orders &= (1U << order) - 1) {
 			page = alloc_pages(gfp | __GFP_NORETRY, order);
 			if (!page)
 				continue;
@@ -230,7 +237,7 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count, gfp_t gfp)
 			}
 		}
 		if (!page)
-			page = alloc_page(gfp);
+			page = alloc_pages(gfp, order);
 		if (!page) {
 			__iommu_dma_free_pages(pages, i);
 			return NULL;
@@ -267,6 +274,7 @@ void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
  *	 attached to an iommu_dma_domain
  * @size: Size of buffer in bytes
  * @gfp: Allocation flags
+ * @attrs: DMA attributes for this allocation
  * @prot: IOMMU mapping flags
  * @handle: Out argument for allocated DMA handle
  * @flush_page: Arch callback which must ensure PAGE_SIZE bytes from the
@@ -278,8 +286,8 @@ void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
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
@@ -288,11 +296,22 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size,
 	struct page **pages;
 	struct sg_table sgt;
 	dma_addr_t dma_addr;
-	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	unsigned int count, min_pgsize, pgsizes = domain->pgsize_bitmap;
 
 	*handle = DMA_ERROR_CODE;
 
-	pages = __iommu_dma_alloc_pages(count, gfp);
+	if (pgsizes & (PAGE_SIZE - 1)) {
+		pgsizes &= PAGE_MASK;
+		pgsizes |= PAGE_SIZE;
+	}
+
+	min_pgsize = pgsizes ^ (pgsizes & (pgsizes - 1));
+	if (dma_get_attr(DMA_ATTR_ALLOC_SINGLE_PAGES, attrs))
+		pgsizes = min_pgsize;
+
+	size = ALIGN(size, min_pgsize);
+	count = size >> PAGE_SHIFT;
+	pages = __iommu_dma_alloc_pages(count, pgsizes >> PAGE_SHIFT, gfp);
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
