From: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v7 02/19] iommu/dma: Allow MSI-only cookies
Date: Mon,  9 Jan 2017 13:45:53 +0000
Message-ID: <1483969570-3154-3-git-send-email-eric.auger@redhat.com>
References: <1483969570-3154-1-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1483969570-3154-1-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, geethasowjanya.akula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, shankerd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, gpkulkarni-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

IOMMU domain users such as VFIO face a similar problem to DMA API ops
with regard to mapping MSI messages in systems where the MSI write is
subject to IOMMU translation. With the relevant infrastructure now in
place for managed DMA domains, it's actually really simple for other
users to piggyback off that and reap the benefits without giving up
their own IOVA management, and without having to reinvent their own
wheel in the MSI layer.

Allow such users to opt into automatic MSI remapping by dedicating a
region of their IOVA space to a managed cookie, and extend the mapping
routine to implement a trivial linear allocator in such cases, to avoid
the needless overhead of a full-blown IOVA domain.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/dma-iommu.c | 119 +++++++++++++++++++++++++++++++++++++---------
 include/linux/dma-iommu.h |   6 +++
 2 files changed, 102 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index a59ca47..008ad88 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -37,15 +37,50 @@ struct iommu_dma_msi_page {
 	phys_addr_t		phys;
 };
 
+enum iommu_dma_cookie_type {
+	IOMMU_DMA_IOVA_COOKIE,
+	IOMMU_DMA_MSI_COOKIE,
+};
+
 struct iommu_dma_cookie {
-	struct iova_domain	iovad;
-	struct list_head	msi_page_list;
-	spinlock_t		msi_lock;
+	enum iommu_dma_cookie_type	type;
+	union {
+		/* Full allocator for IOMMU_DMA_IOVA_COOKIE */
+		struct iova_domain	iovad;
+		/* Trivial linear page allocator for IOMMU_DMA_MSI_COOKIE */
+		dma_addr_t		msi_iova;
+	};
+	struct list_head		msi_page_list;
+	spinlock_t			msi_lock;
 };
 
+static inline size_t cookie_msi_granule(struct iommu_dma_cookie *cookie)
+{
+	if (cookie->type == IOMMU_DMA_IOVA_COOKIE)
+		return cookie->iovad.granule;
+	return PAGE_SIZE;
+}
+
 static inline struct iova_domain *cookie_iovad(struct iommu_domain *domain)
 {
-	return &((struct iommu_dma_cookie *)domain->iova_cookie)->iovad;
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+
+	if (cookie->type == IOMMU_DMA_IOVA_COOKIE)
+		return &cookie->iovad;
+	return NULL;
+}
+
+static struct iommu_dma_cookie *cookie_alloc(enum iommu_dma_cookie_type type)
+{
+	struct iommu_dma_cookie *cookie;
+
+	cookie = kzalloc(sizeof(*cookie), GFP_KERNEL);
+	if (cookie) {
+		spin_lock_init(&cookie->msi_lock);
+		INIT_LIST_HEAD(&cookie->msi_page_list);
+		cookie->type = type;
+	}
+	return cookie;
 }
 
 int iommu_dma_init(void)
@@ -62,25 +97,53 @@ int iommu_dma_init(void)
  */
 int iommu_get_dma_cookie(struct iommu_domain *domain)
 {
+	if (domain->iova_cookie)
+		return -EEXIST;
+
+	domain->iova_cookie = cookie_alloc(IOMMU_DMA_IOVA_COOKIE);
+	if (!domain->iova_cookie)
+		return -ENOMEM;
+
+	return 0;
+}
+EXPORT_SYMBOL(iommu_get_dma_cookie);
+
+/**
+ * iommu_get_msi_cookie - Acquire just MSI remapping resources
+ * @domain: IOMMU domain to prepare
+ * @base: Start address of IOVA region for MSI mappings
+ *
+ * Users who manage their own IOVA allocation and do not want DMA API support,
+ * but would still like to take advantage of automatic MSI remapping, can use
+ * this to initialise their own domain appropriately. Users should reserve a
+ * contiguous IOVA region, starting at @base, large enough to accommodate the
+ * number of PAGE_SIZE mappings necessary to cover every MSI doorbell address
+ * used by the devices attached to @domain.
+ */
+int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
+{
 	struct iommu_dma_cookie *cookie;
 
+	if (domain->type != IOMMU_DOMAIN_UNMANAGED)
+		return -EINVAL;
+
 	if (domain->iova_cookie)
 		return -EEXIST;
 
-	cookie = kzalloc(sizeof(*cookie), GFP_KERNEL);
+	cookie = cookie_alloc(IOMMU_DMA_MSI_COOKIE);
 	if (!cookie)
 		return -ENOMEM;
 
-	spin_lock_init(&cookie->msi_lock);
-	INIT_LIST_HEAD(&cookie->msi_page_list);
+	cookie->msi_iova = base;
 	domain->iova_cookie = cookie;
 	return 0;
 }
-EXPORT_SYMBOL(iommu_get_dma_cookie);
+EXPORT_SYMBOL(iommu_get_msi_cookie);
 
 /**
  * iommu_put_dma_cookie - Release a domain's DMA mapping resources
- * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
+ * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie() or
+ *          iommu_get_msi_cookie()
  *
  * IOMMU drivers should normally call this from their domain_free callback.
  */
@@ -92,7 +155,7 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 	if (!cookie)
 		return;
 
-	if (cookie->iovad.granule)
+	if (cookie->type == IOMMU_DMA_IOVA_COOKIE && cookie->iovad.granule)
 		put_iova_domain(&cookie->iovad);
 
 	list_for_each_entry_safe(msi, tmp, &cookie->msi_page_list, list) {
@@ -137,11 +200,12 @@ static void iova_reserve_pci_windows(struct pci_dev *dev,
 int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 		u64 size, struct device *dev)
 {
-	struct iova_domain *iovad = cookie_iovad(domain);
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	struct iova_domain *iovad = &cookie->iovad;
 	unsigned long order, base_pfn, end_pfn;
 
-	if (!iovad)
-		return -ENODEV;
+	if (!cookie || cookie->type != IOMMU_DMA_IOVA_COOKIE)
+		return -EINVAL;
 
 	/* Use the smallest supported page size for IOVA granularity */
 	order = __ffs(domain->pgsize_bitmap);
@@ -671,11 +735,12 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 {
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iommu_dma_msi_page *msi_page;
-	struct iova_domain *iovad = &cookie->iovad;
+	struct iova_domain *iovad = cookie_iovad(domain);
 	struct iova *iova;
 	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
+	size_t size = cookie_msi_granule(cookie);
 
-	msi_addr &= ~(phys_addr_t)iova_mask(iovad);
+	msi_addr &= ~(phys_addr_t)(size - 1);
 	list_for_each_entry(msi_page, &cookie->msi_page_list, list)
 		if (msi_page->phys == msi_addr)
 			return msi_page;
@@ -684,13 +749,18 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	if (!msi_page)
 		return NULL;
 
-	iova = __alloc_iova(domain, iovad->granule, dma_get_mask(dev), dev);
-	if (!iova)
-		goto out_free_page;
-
 	msi_page->phys = msi_addr;
-	msi_page->iova = iova_dma_addr(iovad, iova);
-	if (iommu_map(domain, msi_page->iova, msi_addr, iovad->granule, prot))
+	if (iovad) {
+		iova = __alloc_iova(domain, size, dma_get_mask(dev), dev);
+		if (!iova)
+			goto out_free_page;
+		msi_page->iova = iova_dma_addr(iovad, iova);
+	} else {
+		msi_page->iova = cookie->msi_iova;
+		cookie->msi_iova += size;
+	}
+
+	if (iommu_map(domain, msi_page->iova, msi_addr, size, prot))
 		goto out_free_iova;
 
 	INIT_LIST_HEAD(&msi_page->list);
@@ -698,7 +768,10 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	return msi_page;
 
 out_free_iova:
-	__free_iova(iovad, iova);
+	if (iovad)
+		__free_iova(iovad, iova);
+	else
+		cookie->msi_iova -= size;
 out_free_page:
 	kfree(msi_page);
 	return NULL;
@@ -739,7 +812,7 @@ void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
 		msg->data = ~0U;
 	} else {
 		msg->address_hi = upper_32_bits(msi_page->iova);
-		msg->address_lo &= iova_mask(&cookie->iovad);
+		msg->address_lo &= cookie_msi_granule(cookie) - 1;
 		msg->address_lo += lower_32_bits(msi_page->iova);
 	}
 }
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 7f7e9a7..28df844 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -27,6 +27,7 @@
 
 /* Domain management interface for IOMMU drivers */
 int iommu_get_dma_cookie(struct iommu_domain *domain);
+int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
 void iommu_put_dma_cookie(struct iommu_domain *domain);
 
 /* Setup call for arch DMA mapping code */
@@ -86,6 +87,11 @@ static inline int iommu_get_dma_cookie(struct iommu_domain *domain)
 	return -ENODEV;
 }
 
+static inline int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
+{
+	return -ENODEV;
+}
+
 static inline void iommu_put_dma_cookie(struct iommu_domain *domain)
 {
 }
-- 
1.9.1
