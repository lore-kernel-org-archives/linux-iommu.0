From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH RESEND 2/3] iommu/dma: Clean up MSI IOVA allocation
Date: Fri, 31 Mar 2017 15:46:06 +0100
Message-ID: <0d9ed41de4b88964e5bd0d653eed1094959e7276.1490971180.git.robin.murphy@arm.com>
References: <cover.1490971180.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1490971180.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Now that allocation is suitably abstracted, our private alloc/free
helpers can drive the trivial MSI cookie allocator directly as well,
which lets us clean up its exposed guts from iommu_dma_map_msi_msg() and
simplify things quite a bit.

Reviewed-by: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Tested-by: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/dma-iommu.c | 58 ++++++++++++++++++++---------------------------
 1 file changed, 25 insertions(+), 33 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 8e0b684da1ba..1b94beb43036 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -61,15 +61,6 @@ static inline size_t cookie_msi_granule(struct iommu_dma_cookie *cookie)
 	return PAGE_SIZE;
 }
 
-static inline struct iova_domain *cookie_iovad(struct iommu_domain *domain)
-{
-	struct iommu_dma_cookie *cookie = domain->iova_cookie;
-
-	if (cookie->type == IOMMU_DMA_IOVA_COOKIE)
-		return &cookie->iovad;
-	return NULL;
-}
-
 static struct iommu_dma_cookie *cookie_alloc(enum iommu_dma_cookie_type type)
 {
 	struct iommu_dma_cookie *cookie;
@@ -368,11 +359,19 @@ int dma_info_to_prot(enum dma_data_direction dir, bool coherent,
 static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 		size_t size, dma_addr_t dma_limit, struct device *dev)
 {
-	struct iova_domain *iovad = cookie_iovad(domain);
-	unsigned long shift = iova_shift(iovad);
-	unsigned long iova_len = size >> shift;
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	struct iova_domain *iovad = &cookie->iovad;
+	unsigned long shift, iova_len;
 	struct iova *iova = NULL;
 
+	if (cookie->type == IOMMU_DMA_MSI_COOKIE) {
+		cookie->msi_iova += size;
+		return cookie->msi_iova - size;
+	}
+
+	shift = iova_shift(iovad);
+	iova_len = size >> shift;
+
 	if (domain->geometry.force_aperture)
 		dma_limit = min(dma_limit, domain->geometry.aperture_end);
 
@@ -396,6 +395,12 @@ static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
 	struct iova_domain *iovad = &cookie->iovad;
 	struct iova *iova_rbnode;
 
+	/* The MSI case is only ever cleaning up its most recent allocation */
+	if (cookie->type == IOMMU_DMA_MSI_COOKIE) {
+		cookie->msi_iova -= size;
+		return;
+	}
+
 	iova_rbnode = find_iova(iovad, iova_pfn(iovad, iova));
 	if (WARN_ON(!iova_rbnode))
 		return;
@@ -406,14 +411,15 @@ static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
 static void __iommu_dma_unmap(struct iommu_domain *domain, dma_addr_t dma_addr,
 		size_t size)
 {
-	struct iova_domain *iovad = cookie_iovad(domain);
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	struct iova_domain *iovad = &cookie->iovad;
 	size_t iova_off = iova_offset(iovad, dma_addr);
 
 	dma_addr -= iova_off;
 	size = iova_align(iovad, size + iova_off);
 
 	WARN_ON(iommu_unmap(domain, dma_addr, size) != size);
-	iommu_dma_free_iova(domain->iova_cookie, dma_addr, size);
+	iommu_dma_free_iova(cookie, dma_addr, size);
 }
 
 static void __iommu_dma_free_pages(struct page **pages, int count)
@@ -838,7 +844,6 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 {
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iommu_dma_msi_page *msi_page;
-	struct iova_domain *iovad = cookie_iovad(domain);
 	dma_addr_t iova;
 	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
 	size_t size = cookie_msi_granule(cookie);
@@ -852,29 +857,16 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	if (!msi_page)
 		return NULL;
 
-	msi_page->phys = msi_addr;
-	if (iovad) {
-		iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
-		if (!iova)
-			goto out_free_page;
-		msi_page->iova = iova;
-	} else {
-		msi_page->iova = cookie->msi_iova;
-		cookie->msi_iova += size;
-	}
-
-	if (iommu_map(domain, msi_page->iova, msi_addr, size, prot))
-		goto out_free_iova;
+	iova = __iommu_dma_map(dev, msi_addr, size, prot);
+	if (iommu_dma_mapping_error(dev, iova))
+		goto out_free_page;
 
 	INIT_LIST_HEAD(&msi_page->list);
+	msi_page->phys = msi_addr;
+	msi_page->iova = iova;
 	list_add(&msi_page->list, &cookie->msi_page_list);
 	return msi_page;
 
-out_free_iova:
-	if (iovad)
-		iommu_dma_free_iova(cookie, iova, size);
-	else
-		cookie->msi_iova -= size;
 out_free_page:
 	kfree(msi_page);
 	return NULL;
-- 
2.11.0.dirty
