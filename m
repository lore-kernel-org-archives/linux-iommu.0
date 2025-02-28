Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7FD1D5CFA
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 11:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740742280; cv=none; b=lfzKdO//locIQe/HO+tQJyy+NAY8j8jLebcd7oAlO9ON0ljhl4K6p20sfXkbkoM7JDFZBcZK13002c3imIUgpeVT3QGpBgxrT0jXUEpzACFtSC/wyPlHEcFuR3IGALdkx9ZHThulWPxCMeMUtpP0ZKDFFqSQPsInwKtubaak00g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740742280; c=relaxed/simple;
	bh=KKNqZzAb7uykCKLes3JwpzjoU79vnZecGgmTSWAzSz8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GMmnwPJItLKsPPeVwgvbrse67bs4Up4Lq+9TCXJHkfGGBjcw6UPnZlU127FoeC0C0COGrOVJrA1A8MXzSsPRXSn3qYeIbYnssFJrtgp6okR60GgDAFG6ELXmvhO2QB2vu0cnhTb5JDXLElH1lZUJMcs8faD2nILM6qlpKs1oa/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2A0B1063;
	Fri, 28 Feb 2025 03:31:31 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B5B9D3F673;
	Fri, 28 Feb 2025 03:31:15 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	joro@8bytes.org
Cc: iommu@lists.linux.dev,
	jgg@nvidia.com,
	nicolinc@nvidia.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: Sort out domain user data
Date: Fri, 28 Feb 2025 11:31:11 +0000
Message-Id: <4e68d5820be06adc1b34fc0d1c9399481151daee.1740742271.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When DMA/MSI cookies were made first-class citizens back in commit
46983fcd67ac ("iommu: Pull IOVA cookie management into the core"), there
was no real need to further expose the two different cookie types.
However, now that IOMMUFD wants to add a third type of MSI-mapping
cookie, we do have a nicely compelling reason to properly dismabiguate
things at the domain level beyond just vaguely guessing from the domain
type.

Meanwhile, we also effectively have another "cookie" in the form of the
anonymous union for other user data, which isn't much better in terms of
being vague and unenforced. The fact is that all these cookie types are
mutually exclusive, in the sense that combining them makes zero sense
and/or would be catastrophic (iommu_set_fault_handler() on an SVA
domain, anyone?) - the only combination which *might* be reasonable is
perhaps a fault handler and an MSI cookie, but nobody's doing that at
the moment, so let's rule it out as well for the sake of being clear and
robust. To that end, we pull DMA and MSI cookies apart a little more,
mostly to clear up the ambiguity at domain teardown, then for clarity
(and to save a little space), move them into the union, whose ownership
we can then properly describe and enforce entirely unambiguously.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 189 ++++++++++++++++++++------------------
 drivers/iommu/dma-iommu.h |   5 +
 drivers/iommu/iommu-sva.c |   1 +
 drivers/iommu/iommu.c     |  17 +++-
 include/linux/iommu.h     |  13 ++-
 5 files changed, 134 insertions(+), 91 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 44afb0c5e80d..02e5c545a731 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -41,11 +41,6 @@ struct iommu_dma_msi_page {
 	phys_addr_t		phys;
 };
 
-enum iommu_dma_cookie_type {
-	IOMMU_DMA_IOVA_COOKIE,
-	IOMMU_DMA_MSI_COOKIE,
-};
-
 enum iommu_dma_queue_type {
 	IOMMU_DMA_OPTS_PER_CPU_QUEUE,
 	IOMMU_DMA_OPTS_SINGLE_QUEUE,
@@ -58,34 +53,30 @@ struct iommu_dma_options {
 };
 
 struct iommu_dma_cookie {
-	enum iommu_dma_cookie_type	type;
+	struct iova_domain iovad;
+	struct list_head msi_page_list;
+	/* Flush queue */
 	union {
-		/* Full allocator for IOMMU_DMA_IOVA_COOKIE */
-		struct {
-			struct iova_domain	iovad;
-			/* Flush queue */
-			union {
-				struct iova_fq	*single_fq;
-				struct iova_fq	__percpu *percpu_fq;
-			};
-			/* Number of TLB flushes that have been started */
-			atomic64_t		fq_flush_start_cnt;
-			/* Number of TLB flushes that have been finished */
-			atomic64_t		fq_flush_finish_cnt;
-			/* Timer to regularily empty the flush queues */
-			struct timer_list	fq_timer;
-			/* 1 when timer is active, 0 when not */
-			atomic_t		fq_timer_on;
-		};
-		/* Trivial linear page allocator for IOMMU_DMA_MSI_COOKIE */
-		dma_addr_t		msi_iova;
+		struct iova_fq *single_fq;
+		struct iova_fq __percpu *percpu_fq;
 	};
-	struct list_head		msi_page_list;
-
+	/* Number of TLB flushes that have been started */
+	atomic64_t fq_flush_start_cnt;
+	/* Number of TLB flushes that have been finished */
+	atomic64_t fq_flush_finish_cnt;
+	/* Timer to regularily empty the flush queues */
+	struct timer_list fq_timer;
+	/* 1 when timer is active, 0 when not */
+	atomic_t fq_timer_on;
 	/* Domain for flush queue callback; NULL if flush queue not in use */
-	struct iommu_domain		*fq_domain;
+	struct iommu_domain *fq_domain;
 	/* Options for dma-iommu use */
-	struct iommu_dma_options	options;
+	struct iommu_dma_options options;
+};
+
+struct iommu_dma_msi_cookie {
+	dma_addr_t msi_iova;
+	struct list_head msi_page_list;
 };
 
 static DEFINE_STATIC_KEY_FALSE(iommu_deferred_attach_enabled);
@@ -364,38 +355,25 @@ int iommu_dma_init_fq(struct iommu_domain *domain)
 	return 0;
 }
 
-static inline size_t cookie_msi_granule(struct iommu_dma_cookie *cookie)
-{
-	if (cookie->type == IOMMU_DMA_IOVA_COOKIE)
-		return cookie->iovad.granule;
-	return PAGE_SIZE;
-}
-
-static struct iommu_dma_cookie *cookie_alloc(enum iommu_dma_cookie_type type)
-{
-	struct iommu_dma_cookie *cookie;
-
-	cookie = kzalloc(sizeof(*cookie), GFP_KERNEL);
-	if (cookie) {
-		INIT_LIST_HEAD(&cookie->msi_page_list);
-		cookie->type = type;
-	}
-	return cookie;
-}
-
 /**
  * iommu_get_dma_cookie - Acquire DMA-API resources for a domain
  * @domain: IOMMU domain to prepare for DMA-API usage
  */
 int iommu_get_dma_cookie(struct iommu_domain *domain)
 {
-	if (domain->iova_cookie)
+	struct iommu_dma_cookie *cookie;
+
+	if (domain->cookie_type != IOMMU_NO_COOKIE)
 		return -EEXIST;
 
-	domain->iova_cookie = cookie_alloc(IOMMU_DMA_IOVA_COOKIE);
-	if (!domain->iova_cookie)
+	cookie = kzalloc(sizeof(*cookie), GFP_KERNEL);
+	if (!cookie)
 		return -ENOMEM;
 
+	INIT_LIST_HEAD(&cookie->msi_page_list);
+	domain->cookie_type = IOMMU_DMA_IOVA_COOKIE;
+	domain->iova_cookie = cookie;
+
 	return 0;
 }
 
@@ -413,48 +391,56 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
  */
 int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
 {
-	struct iommu_dma_cookie *cookie;
+	struct iommu_dma_msi_cookie *cookie;
 
 	if (domain->type != IOMMU_DOMAIN_UNMANAGED)
 		return -EINVAL;
 
-	if (domain->iova_cookie)
+	if (domain->cookie_type != IOMMU_NO_COOKIE)
 		return -EEXIST;
 
-	cookie = cookie_alloc(IOMMU_DMA_MSI_COOKIE);
+	cookie = kzalloc(sizeof(*cookie), GFP_KERNEL);
 	if (!cookie)
 		return -ENOMEM;
 
 	cookie->msi_iova = base;
-	domain->iova_cookie = cookie;
+	INIT_LIST_HEAD(&cookie->msi_page_list);
+	domain->cookie_type = IOMMU_DMA_MSI_COOKIE;
+	domain->msi_cookie = cookie;
 	return 0;
 }
 EXPORT_SYMBOL(iommu_get_msi_cookie);
 
 /**
  * iommu_put_dma_cookie - Release a domain's DMA mapping resources
- * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie() or
- *          iommu_get_msi_cookie()
+ * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
  */
 void iommu_put_dma_cookie(struct iommu_domain *domain)
 {
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iommu_dma_msi_page *msi, *tmp;
 
-	if (!cookie)
-		return;
-
-	if (cookie->type == IOMMU_DMA_IOVA_COOKIE && cookie->iovad.granule) {
+	if (cookie->iovad.granule) {
 		iommu_dma_free_fq(cookie);
 		put_iova_domain(&cookie->iovad);
 	}
-
-	list_for_each_entry_safe(msi, tmp, &cookie->msi_page_list, list) {
-		list_del(&msi->list);
+	list_for_each_entry_safe(msi, tmp, &cookie->msi_page_list, list)
+		kfree(msi);
+	kfree(cookie);
+}
+
+/**
+ * iommu_put_msi_cookie - Release a domain's MSI mapping resources
+ * @domain: IOMMU domain previously prepared by iommu_get_msi_cookie()
+ */
+void iommu_put_msi_cookie(struct iommu_domain *domain)
+{
+	struct iommu_dma_msi_cookie *cookie = domain->msi_cookie;
+	struct iommu_dma_msi_page *msi, *tmp;
+
+	list_for_each_entry_safe(msi, tmp, &cookie->msi_page_list, list)
 		kfree(msi);
-	}
 	kfree(cookie);
-	domain->iova_cookie = NULL;
 }
 
 /**
@@ -674,7 +660,7 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, struct device *dev
 	struct iova_domain *iovad;
 	int ret;
 
-	if (!cookie || cookie->type != IOMMU_DMA_IOVA_COOKIE)
+	if (domain->cookie_type != IOMMU_DMA_IOVA_COOKIE || !cookie)
 		return -EINVAL;
 
 	iovad = &cookie->iovad;
@@ -757,9 +743,9 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 	struct iova_domain *iovad = &cookie->iovad;
 	unsigned long shift, iova_len, iova;
 
-	if (cookie->type == IOMMU_DMA_MSI_COOKIE) {
-		cookie->msi_iova += size;
-		return cookie->msi_iova - size;
+	if (domain->cookie_type == IOMMU_DMA_MSI_COOKIE) {
+		domain->msi_cookie->msi_iova += size;
+		return domain->msi_cookie->msi_iova - size;
 	}
 
 	shift = iova_shift(iovad);
@@ -796,16 +782,16 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 	return (dma_addr_t)iova << shift;
 }
 
-static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
+static void iommu_dma_free_iova(struct iommu_domain *domain,
 		dma_addr_t iova, size_t size, struct iommu_iotlb_gather *gather)
 {
-	struct iova_domain *iovad = &cookie->iovad;
+	struct iova_domain *iovad = &domain->iova_cookie->iovad;
 
 	/* The MSI case is only ever cleaning up its most recent allocation */
-	if (cookie->type == IOMMU_DMA_MSI_COOKIE)
-		cookie->msi_iova -= size;
+	if (domain->cookie_type == IOMMU_DMA_MSI_COOKIE)
+		domain->msi_cookie->msi_iova -= size;
 	else if (gather && gather->queued)
-		queue_iova(cookie, iova_pfn(iovad, iova),
+		queue_iova(domain->iova_cookie, iova_pfn(iovad, iova),
 				size >> iova_shift(iovad),
 				&gather->freelist);
 	else
@@ -833,7 +819,7 @@ static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
 
 	if (!iotlb_gather.queued)
 		iommu_iotlb_sync(domain, &iotlb_gather);
-	iommu_dma_free_iova(cookie, dma_addr, size, &iotlb_gather);
+	iommu_dma_free_iova(domain, dma_addr, size, &iotlb_gather);
 }
 
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
@@ -861,7 +847,7 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 		return DMA_MAPPING_ERROR;
 
 	if (iommu_map(domain, iova, phys - iova_off, size, prot, GFP_ATOMIC)) {
-		iommu_dma_free_iova(cookie, iova, size, NULL);
+		iommu_dma_free_iova(domain, iova, size, NULL);
 		return DMA_MAPPING_ERROR;
 	}
 	return iova + iova_off;
@@ -998,7 +984,7 @@ static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
 out_free_sg:
 	sg_free_table(sgt);
 out_free_iova:
-	iommu_dma_free_iova(cookie, iova, size, NULL);
+	iommu_dma_free_iova(domain, iova, size, NULL);
 out_free_pages:
 	__iommu_dma_free_pages(pages, count);
 	return NULL;
@@ -1475,7 +1461,7 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 	return __finalise_sg(dev, sg, nents, iova);
 
 out_free_iova:
-	iommu_dma_free_iova(cookie, iova, iova_len, NULL);
+	iommu_dma_free_iova(domain, iova, iova_len, NULL);
 out_restore_sg:
 	__invalidate_sg(sg, nents);
 out:
@@ -1753,17 +1739,46 @@ void iommu_setup_dma_ops(struct device *dev)
 	dev->dma_iommu = false;
 }
 
+static bool has_msi_cookie(const struct iommu_domain *domain)
+{
+	return domain && (domain->cookie_type == IOMMU_DMA_IOVA_COOKIE ||
+			  domain->cookie_type == IOMMU_DMA_MSI_COOKIE);
+}
+
+static size_t cookie_msi_granule(const struct iommu_domain *domain)
+{
+	switch (domain->cookie_type) {
+	case IOMMU_DMA_IOVA_COOKIE:
+		return domain->iova_cookie->iovad.granule;
+	case IOMMU_DMA_MSI_COOKIE:
+		return PAGE_SIZE;
+	default:
+		unreachable();
+	};
+}
+
+static struct list_head *cookie_msi_pages(const struct iommu_domain *domain)
+{
+	switch (domain->cookie_type) {
+	case IOMMU_DMA_IOVA_COOKIE:
+		return &domain->iova_cookie->msi_page_list;
+	case IOMMU_DMA_MSI_COOKIE:
+		return &domain->msi_cookie->msi_page_list;
+	default:
+		unreachable();
+	};
+}
+
 static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 		phys_addr_t msi_addr, struct iommu_domain *domain)
 {
-	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iommu_dma_msi_page *msi_page;
 	dma_addr_t iova;
 	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
-	size_t size = cookie_msi_granule(cookie);
+	size_t size = cookie_msi_granule(domain);
 
 	msi_addr &= ~(phys_addr_t)(size - 1);
-	list_for_each_entry(msi_page, &cookie->msi_page_list, list)
+	list_for_each_entry(msi_page, cookie_msi_pages(domain), list)
 		if (msi_page->phys == msi_addr)
 			return msi_page;
 
@@ -1781,11 +1796,11 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	INIT_LIST_HEAD(&msi_page->list);
 	msi_page->phys = msi_addr;
 	msi_page->iova = iova;
-	list_add(&msi_page->list, &cookie->msi_page_list);
+	list_add(&msi_page->list, cookie_msi_pages(domain));
 	return msi_page;
 
 out_free_iova:
-	iommu_dma_free_iova(cookie, iova, size, NULL);
+	iommu_dma_free_iova(domain, iova, size, NULL);
 out_free_page:
 	kfree(msi_page);
 	return NULL;
@@ -1805,7 +1820,7 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 	struct iommu_dma_msi_page *msi_page;
 	static DEFINE_MUTEX(msi_prepare_lock); /* see below */
 
-	if (!domain || !domain->iova_cookie) {
+	if (!has_msi_cookie(domain)) {
 		desc->iommu_cookie = NULL;
 		return 0;
 	}
@@ -1839,11 +1854,11 @@ void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 
 	msi_page = msi_desc_get_iommu_cookie(desc);
 
-	if (!domain || !domain->iova_cookie || WARN_ON(!msi_page))
+	if (!has_msi_cookie(domain) || WARN_ON(!msi_page))
 		return;
 
 	msg->address_hi = upper_32_bits(msi_page->iova);
-	msg->address_lo &= cookie_msi_granule(domain->iova_cookie) - 1;
+	msg->address_lo &= cookie_msi_granule(domain) - 1;
 	msg->address_lo += lower_32_bits(msi_page->iova);
 }
 
diff --git a/drivers/iommu/dma-iommu.h b/drivers/iommu/dma-iommu.h
index c12d63457c76..9cca11806e5d 100644
--- a/drivers/iommu/dma-iommu.h
+++ b/drivers/iommu/dma-iommu.h
@@ -13,6 +13,7 @@ void iommu_setup_dma_ops(struct device *dev);
 
 int iommu_get_dma_cookie(struct iommu_domain *domain);
 void iommu_put_dma_cookie(struct iommu_domain *domain);
+void iommu_put_msi_cookie(struct iommu_domain *domain);
 
 int iommu_dma_init_fq(struct iommu_domain *domain);
 
@@ -40,6 +41,10 @@ static inline void iommu_put_dma_cookie(struct iommu_domain *domain)
 {
 }
 
+static inline void iommu_put_msi_cookie(struct iommu_domain *domain)
+{
+}
+
 static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 {
 }
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 503c5d23c1ea..df4443ba26b9 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -310,6 +310,7 @@ static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
 	}
 
 	domain->type = IOMMU_DOMAIN_SVA;
+	domain->cookie_type = IOMMU_SVA_COOKIE;
 	mmgrab(mm);
 	domain->mm = mm;
 	domain->owner = ops;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0fce7a1677e6..4fca10d107c8 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1950,8 +1950,10 @@ void iommu_set_fault_handler(struct iommu_domain *domain,
 					iommu_fault_handler_t handler,
 					void *token)
 {
-	BUG_ON(!domain);
+	if (WARN_ON(!domain || domain->cookie_type != IOMMU_NO_COOKIE))
+		return;
 
+	domain->cookie_type = IOMMU_FAULT_HANDLER_COOKIE;
 	domain->handler = handler;
 	domain->handler_token = token;
 }
@@ -2021,9 +2023,18 @@ EXPORT_SYMBOL_GPL(iommu_paging_domain_alloc_flags);
 
 void iommu_domain_free(struct iommu_domain *domain)
 {
-	if (domain->type == IOMMU_DOMAIN_SVA)
+	switch (domain->cookie_type) {
+	case IOMMU_DMA_IOVA_COOKIE:
+		iommu_put_dma_cookie(domain);
+		break;
+	case IOMMU_DMA_MSI_COOKIE:
+		iommu_put_msi_cookie(domain);
+		break;
+	case IOMMU_SVA_COOKIE:
 		mmdrop(domain->mm);
-	iommu_put_dma_cookie(domain);
+		break;
+	default:
+	}
 	if (domain->ops->free)
 		domain->ops->free(domain);
 }
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 446ca5a5af35..4a1e8b68dd81 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -41,6 +41,7 @@ struct iommu_dirty_ops;
 struct notifier_block;
 struct iommu_sva;
 struct iommu_dma_cookie;
+struct iommu_dma_msi_cookie;
 struct iommu_fault_param;
 struct iommufd_ctx;
 struct iommufd_viommu;
@@ -163,6 +164,14 @@ struct iommu_domain_geometry {
 	bool force_aperture;       /* DMA only allowed in mappable range? */
 };
 
+enum iommu_domain_cookie_type {
+	IOMMU_NO_COOKIE,
+	IOMMU_DMA_IOVA_COOKIE,
+	IOMMU_DMA_MSI_COOKIE,
+	IOMMU_FAULT_HANDLER_COOKIE,
+	IOMMU_SVA_COOKIE,
+};
+
 /* Domain feature flags */
 #define __IOMMU_DOMAIN_PAGING	(1U << 0)  /* Support for iommu_map/unmap */
 #define __IOMMU_DOMAIN_DMA_API	(1U << 1)  /* Domain for use in DMA-API
@@ -209,15 +218,17 @@ struct iommu_domain_geometry {
 
 struct iommu_domain {
 	unsigned type;
+	enum iommu_domain_cookie_type cookie_type;
 	const struct iommu_domain_ops *ops;
 	const struct iommu_dirty_ops *dirty_ops;
 	const struct iommu_ops *owner; /* Whose domain_alloc we came from */
 	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
 	struct iommu_domain_geometry geometry;
-	struct iommu_dma_cookie *iova_cookie;
 	int (*iopf_handler)(struct iopf_group *group);
 	void *fault_data;
 	union {
+		struct iommu_dma_cookie *iova_cookie;
+		struct iommu_dma_msi_cookie *msi_cookie;
 		struct {
 			iommu_fault_handler_t handler;
 			void *handler_token;
-- 
2.39.2.101.g768bb238c484.dirty

