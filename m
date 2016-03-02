From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH] arm64/dma-mapping: Add DMA_ATTR_ALLOC_SINGLE_PAGES support
Date: Thu, 3 Mar 2016 02:54:26 +0800
Message-ID: <1456944866-15990-1-git-send-email-yong.wu@mediatek.com>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Sometimes it is not worth for the iommu allocating big chunks.
Here we enable DMA_ATTR_ALLOC_SINGLE_PAGES which could help avoid to
allocate big chunks while iommu allocating buffer.

More information about this attribute, please check Doug's commit[1].

[1]: https://lkml.org/lkml/2016/1/11/720

Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Suggested-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---

Our video drivers may soon use this.

 arch/arm64/mm/dma-mapping.c |  4 ++--
 drivers/iommu/dma-iommu.c   | 14 ++++++++++----
 include/linux/dma-iommu.h   |  4 ++--
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 331c4ca..3225e3ca 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -562,8 +562,8 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 		struct page **pages;
 		pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL, coherent);
 
-		pages = iommu_dma_alloc(dev, iosize, gfp, ioprot, handle,
-					flush_page);
+		pages = iommu_dma_alloc(dev, iosize, gfp, ioprot, attrs,
+					handle, flush_page);
 		if (!pages)
 			return NULL;
 
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 72d6182..3569cb6 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -190,7 +190,8 @@ static void __iommu_dma_free_pages(struct page **pages, int count)
 	kvfree(pages);
 }
 
-static struct page **__iommu_dma_alloc_pages(unsigned int count, gfp_t gfp)
+static struct page **__iommu_dma_alloc_pages(unsigned int count, gfp_t gfp,
+					     struct dma_attrs *attrs)
 {
 	struct page **pages;
 	unsigned int i = 0, array_size = count * sizeof(*pages);
@@ -203,6 +204,10 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count, gfp_t gfp)
 	if (!pages)
 		return NULL;
 
+	/* Go straight to 4K chunks if caller says it's OK. */
+	if (dma_get_attr(DMA_ATTR_ALLOC_SINGLE_PAGES, attrs))
+		order = 0;
+
 	/* IOMMU can map any pages, so himem can also be used here */
 	gfp |= __GFP_NOWARN | __GFP_HIGHMEM;
 
@@ -268,6 +273,7 @@ void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
  * @size: Size of buffer in bytes
  * @gfp: Allocation flags
  * @prot: IOMMU mapping flags
+ * @attrs: DMA attributes flags
  * @handle: Out argument for allocated DMA handle
  * @flush_page: Arch callback which must ensure PAGE_SIZE bytes from the
  *		given VA/PA are visible to the given non-coherent device.
@@ -278,8 +284,8 @@ void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
  * Return: Array of struct page pointers describing the buffer,
  *	   or NULL on failure.
  */
-struct page **iommu_dma_alloc(struct device *dev, size_t size,
-		gfp_t gfp, int prot, dma_addr_t *handle,
+struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
+		int prot, struct dma_attrs *attrs, dma_addr_t *handle,
 		void (*flush_page)(struct device *, const void *, phys_addr_t))
 {
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
@@ -292,7 +298,7 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size,
 
 	*handle = DMA_ERROR_CODE;
 
-	pages = __iommu_dma_alloc_pages(count, gfp);
+	pages = __iommu_dma_alloc_pages(count, gfp, attrs);
 	if (!pages)
 		return NULL;
 
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index fc48103..08d9603 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -38,8 +38,8 @@ int dma_direction_to_prot(enum dma_data_direction dir, bool coherent);
  * These implement the bulk of the relevant DMA mapping callbacks, but require
  * the arch code to take care of attributes and cache maintenance
  */
-struct page **iommu_dma_alloc(struct device *dev, size_t size,
-		gfp_t gfp, int prot, dma_addr_t *handle,
+struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
+		int prot, struct dma_attrs *attrs, dma_addr_t *handle,
 		void (*flush_page)(struct device *, const void *, phys_addr_t));
 void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
 		dma_addr_t *handle);
-- 
1.8.1.1.dirty
