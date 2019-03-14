From: James Sewart via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: [PATCH v2 6/7] iommu/vt-d: Allow IOMMU_DOMAIN_DMA to be allocated by
	iommu_ops
Date: Thu, 14 Mar 2019 11:59:17 +0000
Message-ID: <C8765B75-BA3F-4DBE-8281-363A586BD8C3@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
	<83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
Reply-To: James Sewart <jamessewart-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <83B82113-8AE5-4B0C-A079-F389520525BD-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Tom Murphy <tmurphy-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Safonov <dima-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Allowing IOMMU_DOMAIN_DMA type IOMMU domain to be allocated allows the
default_domain of an iommu_group to be set. This delegates device-domain
relationships to the generic IOMMU code.

Signed-off-by: James Sewart <jamessewart-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 99 +++++++++++++++++++++++++++++--------
 1 file changed, 78 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 35821df70f78..2c9d793af394 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -309,6 +309,18 @@ static int hw_pass_through = 1;
 /* si_domain contains mulitple devices */
 #define DOMAIN_FLAG_STATIC_IDENTITY	(1 << 1)
 
+/*
+ * Domain managed externally, don't cleanup if it isn't attached
+ * to any devices.
+ */
+#define DOMAIN_FLAG_MANAGED_EXTERNALLY	(1 << 2)
+
+/*
+ * Set after domain initialisation. Used when allocating dma domains to
+ * defer domain initialisation until it is attached to a device
+ */
+#define DOMAIN_FLAG_INITIALISED	(1 << 3)
+
 #define for_each_domain_iommu(idx, domain)			\
 	for (idx = 0; idx < g_num_of_iommus; idx++)		\
 		if (domain->iommu_refcnt[idx])
@@ -560,6 +572,16 @@ static inline int domain_type_is_vm_or_si(struct dmar_domain *domain)
 				DOMAIN_FLAG_STATIC_IDENTITY);
 }
 
+static inline int domain_managed_externally(struct dmar_domain *domain)
+{
+	return domain->flags & DOMAIN_FLAG_MANAGED_EXTERNALLY;
+}
+
+static inline int domain_is_initialised(struct dmar_domain *domain)
+{
+	return domain->flags & DOMAIN_FLAG_INITIALISED;
+}
+
 static inline int domain_pfn_supported(struct dmar_domain *domain,
 				       unsigned long pfn)
 {
@@ -1664,7 +1686,7 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
 
 		__dmar_remove_one_dev_info(info);
 
-		if (!domain_type_is_vm_or_si(domain)) {
+		if (!domain_managed_externally(domain)) {
 			/*
 			 * The domain_exit() function  can't be called under
 			 * device_domain_lock, as it takes this lock itself.
@@ -1897,6 +1919,7 @@ static int domain_init(struct dmar_domain *domain, struct intel_iommu *iommu,
 	domain->pgd = (struct dma_pte *)alloc_pgtable_page(domain->nid);
 	if (!domain->pgd)
 		return -ENOMEM;
+	domain->flags |= DOMAIN_FLAG_INITIALISED;
 	__iommu_flush_cache(iommu, domain->pgd, PAGE_SIZE);
 	return 0;
 }
@@ -1909,6 +1932,9 @@ static void domain_exit(struct dmar_domain *domain)
 	if (!domain)
 		return;
 
+	if (!domain_is_initialised(domain))
+		goto free_mem;
+
 	/* Remove associated devices and clear attached or cached domains */
 	rcu_read_lock();
 	domain_remove_dev_info(domain);
@@ -1921,6 +1947,7 @@ static void domain_exit(struct dmar_domain *domain)
 
 	dma_free_pagelist(freelist);
 
+free_mem:
 	free_domain_mem(domain);
 }
 
@@ -4585,7 +4612,7 @@ static int device_notifier(struct notifier_block *nb,
 		return 0;
 
 	dmar_remove_one_dev_info(domain, dev);
-	if (!domain_type_is_vm_or_si(domain) && list_empty(&domain->devices))
+	if (!domain_managed_externally(domain) && list_empty(&domain->devices))
 		domain_exit(domain);
 
 	return 0;
@@ -5039,6 +5066,7 @@ static int md_domain_init(struct dmar_domain *domain, int guest_width)
 	domain->pgd = (struct dma_pte *)alloc_pgtable_page(domain->nid);
 	if (!domain->pgd)
 		return -ENOMEM;
+	domain->flags |= DOMAIN_FLAG_INITIALISED;
 	domain_flush_cache(domain, domain->pgd, PAGE_SIZE);
 	return 0;
 }
@@ -5047,28 +5075,43 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 {
 	struct dmar_domain *dmar_domain;
 	struct iommu_domain *domain;
+	int flags = DOMAIN_FLAG_MANAGED_EXTERNALLY;
 
-	if (type != IOMMU_DOMAIN_UNMANAGED)
-		return NULL;
+	switch (type) {
+	case IOMMU_DOMAIN_UNMANAGED:
+		flags |= DOMAIN_FLAG_VIRTUAL_MACHINE | DOMAIN_FLAG_INITIALISED;
+		dmar_domain = alloc_domain(flags);
+		if (!dmar_domain)
+			return NULL;
 
-	dmar_domain = alloc_domain(DOMAIN_FLAG_VIRTUAL_MACHINE);
-	if (!dmar_domain) {
-		pr_err("Can't allocate dmar_domain\n");
-		return NULL;
-	}
-	if (md_domain_init(dmar_domain, DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
-		pr_err("Domain initialization failed\n");
-		domain_exit(dmar_domain);
+		if (md_domain_init(dmar_domain, DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
+			pr_err("Domain initialization failed\n");
+			domain_exit(dmar_domain);
+			return NULL;
+		}
+		domain_update_iommu_cap(dmar_domain);
+		domain = &dmar_domain->domain;
+		domain->geometry.aperture_start = 0;
+		domain->geometry.aperture_end =
+			__DOMAIN_MAX_ADDR(dmar_domain->gaw);
+		domain->geometry.force_aperture = true;
+		break;
+	case IOMMU_DOMAIN_DMA:
+		dmar_domain = alloc_domain(flags);
+		if (!dmar_domain)
+			return NULL;
+		/*
+		 * init domain in device attach when we know IOMMU
+		 * capabilities
+		 */
+		break;
+	case IOMMU_DOMAIN_IDENTITY:
+		return &si_domain->domain;
+	default:
 		return NULL;
 	}
-	domain_update_iommu_cap(dmar_domain);
-
-	domain = &dmar_domain->domain;
-	domain->geometry.aperture_start = 0;
-	domain->geometry.aperture_end   = __DOMAIN_MAX_ADDR(dmar_domain->gaw);
-	domain->geometry.force_aperture = true;
 
-	return domain;
+	return &dmar_domain->domain;
 }
 
 static void intel_iommu_domain_free(struct iommu_domain *domain)
@@ -5099,8 +5142,8 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 			dmar_remove_one_dev_info(old_domain, dev);
 			rcu_read_unlock();
 
-			if (!domain_type_is_vm_or_si(old_domain) &&
-			     list_empty(&old_domain->devices))
+			if (list_empty(&old_domain->devices) &&
+			     !domain_managed_externally(old_domain))
 				domain_exit(old_domain);
 		}
 	}
@@ -5114,6 +5157,16 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 	if (!iommu)
 		return -ENODEV;
 
+	/*
+	 * Initialise domain with IOMMU capabilities if it isn't already
+	 * initialised
+	 */
+	if (!domain_is_initialised(dmar_domain)) {
+		if (domain_init(dmar_domain, iommu,
+				DEFAULT_DOMAIN_ADDRESS_WIDTH))
+			return -ENOMEM;
+	}
+
 	/* check if this iommu agaw is sufficient for max mapped address */
 	addr_width = agaw_to_width(iommu->agaw);
 	if (addr_width > cap_mgaw(iommu->cap))
@@ -5160,6 +5213,10 @@ static int intel_iommu_map(struct iommu_domain *domain,
 	int prot = 0;
 	int ret;
 
+	/* Don't bother if hardware passthrough used. */
+	if (dmar_domain == si_domain && hw_pass_through)
+		return 0;
+
 	if (iommu_prot & IOMMU_READ)
 		prot |= DMA_PTE_READ;
 	if (iommu_prot & IOMMU_WRITE)
-- 
2.17.1
