From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 17/22] iommu/amd: Support IOMMU_DOMAIN_DMA type allocation
Date: Thu, 28 May 2015 18:41:40 +0200
Message-ID: <1432831305-11126-18-git-send-email-joro@8bytes.org>
References: <1432831305-11126-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1432831305-11126-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

This enables allocation of DMA-API default domains from the
IOMMU core and switches allocation of domain dma-api domain
to the IOMMU core too.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c       | 311 ++++++++++------------------------------
 drivers/iommu/amd_iommu_types.h |   3 -
 2 files changed, 73 insertions(+), 241 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 44eeca4..06d19e8 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -64,10 +64,6 @@
 
 static DEFINE_RWLOCK(amd_iommu_devtable_lock);
 
-/* A list of preallocated protection domains */
-static LIST_HEAD(iommu_pd_list);
-static DEFINE_SPINLOCK(iommu_pd_list_lock);
-
 /* List of all available dev_data structures */
 static LIST_HEAD(dev_data_list);
 static DEFINE_SPINLOCK(dev_data_list_lock);
@@ -234,31 +230,38 @@ static bool pdev_pri_erratum(struct pci_dev *pdev, u32 erratum)
 }
 
 /*
- * In this function the list of preallocated protection domains is traversed to
- * find the domain for a specific device
+ * This function actually applies the mapping to the page table of the
+ * dma_ops domain.
  */
-static struct dma_ops_domain *find_protection_domain(u16 devid)
+static void alloc_unity_mapping(struct dma_ops_domain *dma_dom,
+				struct unity_map_entry *e)
 {
-	struct dma_ops_domain *entry, *ret = NULL;
-	unsigned long flags;
-	u16 alias = amd_iommu_alias_table[devid];
-
-	if (list_empty(&iommu_pd_list))
-		return NULL;
-
-	spin_lock_irqsave(&iommu_pd_list_lock, flags);
+	u64 addr;
 
-	list_for_each_entry(entry, &iommu_pd_list, list) {
-		if (entry->target_dev == devid ||
-		    entry->target_dev == alias) {
-			ret = entry;
-			break;
-		}
+	for (addr = e->address_start; addr < e->address_end;
+	     addr += PAGE_SIZE) {
+		if (addr < dma_dom->aperture_size)
+			__set_bit(addr >> PAGE_SHIFT,
+				  dma_dom->aperture[0]->bitmap);
 	}
+}
+
+/*
+ * Inits the unity mappings required for a specific device
+ */
+static void init_unity_mappings_for_device(struct device *dev,
+					   struct dma_ops_domain *dma_dom)
+{
+	struct unity_map_entry *e;
+	u16 devid;
 
-	spin_unlock_irqrestore(&iommu_pd_list_lock, flags);
+	devid = get_device_id(dev);
 
-	return ret;
+	list_for_each_entry(e, &amd_iommu_unity_map, list) {
+		if (!(devid >= e->devid_start && devid <= e->devid_end))
+			continue;
+		alloc_unity_mapping(dma_dom, e);
+	}
 }
 
 /*
@@ -290,11 +293,23 @@ static bool check_device(struct device *dev)
 
 static void init_iommu_group(struct device *dev)
 {
+	struct dma_ops_domain *dma_domain;
+	struct iommu_domain *domain;
 	struct iommu_group *group;
 
 	group = iommu_group_get_for_dev(dev);
-	if (!IS_ERR(group))
-		iommu_group_put(group);
+	if (IS_ERR(group))
+		return;
+
+	domain = iommu_group_default_domain(group);
+	if (!domain)
+		goto out;
+
+	dma_domain = to_pdomain(domain)->priv;
+
+	init_unity_mappings_for_device(dev, dma_domain);
+out:
+	iommu_group_put(group);
 }
 
 static int __last_alias(struct pci_dev *pdev, u16 alias, void *data)
@@ -1414,94 +1429,6 @@ static unsigned long iommu_unmap_page(struct protection_domain *dom,
 	return unmapped;
 }
 
-/*
- * This function checks if a specific unity mapping entry is needed for
- * this specific IOMMU.
- */
-static int iommu_for_unity_map(struct amd_iommu *iommu,
-			       struct unity_map_entry *entry)
-{
-	u16 bdf, i;
-
-	for (i = entry->devid_start; i <= entry->devid_end; ++i) {
-		bdf = amd_iommu_alias_table[i];
-		if (amd_iommu_rlookup_table[bdf] == iommu)
-			return 1;
-	}
-
-	return 0;
-}
-
-/*
- * This function actually applies the mapping to the page table of the
- * dma_ops domain.
- */
-static int dma_ops_unity_map(struct dma_ops_domain *dma_dom,
-			     struct unity_map_entry *e)
-{
-	u64 addr;
-	int ret;
-
-	for (addr = e->address_start; addr < e->address_end;
-	     addr += PAGE_SIZE) {
-		ret = iommu_map_page(&dma_dom->domain, addr, addr, e->prot,
-				     PAGE_SIZE);
-		if (ret)
-			return ret;
-		/*
-		 * if unity mapping is in aperture range mark the page
-		 * as allocated in the aperture
-		 */
-		if (addr < dma_dom->aperture_size)
-			__set_bit(addr >> PAGE_SHIFT,
-				  dma_dom->aperture[0]->bitmap);
-	}
-
-	return 0;
-}
-
-/*
- * Init the unity mappings for a specific IOMMU in the system
- *
- * Basically iterates over all unity mapping entries and applies them to
- * the default domain DMA of that IOMMU if necessary.
- */
-static int iommu_init_unity_mappings(struct amd_iommu *iommu)
-{
-	struct unity_map_entry *entry;
-	int ret;
-
-	list_for_each_entry(entry, &amd_iommu_unity_map, list) {
-		if (!iommu_for_unity_map(iommu, entry))
-			continue;
-		ret = dma_ops_unity_map(iommu->default_dom, entry);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-/*
- * Inits the unity mappings required for a specific device
- */
-static int init_unity_mappings_for_device(struct dma_ops_domain *dma_dom,
-					  u16 devid)
-{
-	struct unity_map_entry *e;
-	int ret;
-
-	list_for_each_entry(e, &amd_iommu_unity_map, list) {
-		if (!(devid >= e->devid_start && devid <= e->devid_end))
-			continue;
-		ret = dma_ops_unity_map(dma_dom, e);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
 /****************************************************************************
  *
  * The next functions belong to the address allocator for the dma_ops
@@ -2324,42 +2251,9 @@ static void detach_device(struct device *dev)
 	dev_data->ats.enabled = false;
 }
 
-/*
- * Find out the protection domain structure for a given PCI device. This
- * will give us the pointer to the page table root for example.
- */
-static struct protection_domain *domain_for_device(struct device *dev)
-{
-	struct iommu_dev_data *dev_data;
-	struct protection_domain *dom = NULL;
-	unsigned long flags;
-
-	dev_data   = get_dev_data(dev);
-
-	if (dev_data->domain)
-		return dev_data->domain;
-
-	if (dev_data->alias_data != NULL) {
-		struct iommu_dev_data *alias_data = dev_data->alias_data;
-
-		read_lock_irqsave(&amd_iommu_devtable_lock, flags);
-		if (alias_data->domain != NULL) {
-			__attach_device(dev_data, alias_data->domain);
-			dom = alias_data->domain;
-		}
-		read_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
-	}
-
-	return dom;
-}
-
 static int amd_iommu_add_device(struct device *dev)
 {
-	struct dma_ops_domain *dma_domain;
-	struct protection_domain *domain;
-	struct iommu_dev_data *dev_data;
 	struct amd_iommu *iommu;
-	unsigned long flags;
 	u16 devid;
 	int ret;
 
@@ -2376,35 +2270,6 @@ static int amd_iommu_add_device(struct device *dev)
 	}
 	init_iommu_group(dev);
 
-	dev_data = get_dev_data(dev);
-
-	if (iommu_pass_through || dev_data->iommu_v2) {
-		/* Make sure passthrough domain is allocated */
-		alloc_passthrough_domain();
-		dev_data->passthrough = true;
-		attach_device(dev, pt_domain);
-		goto out;
-	}
-
-	domain = domain_for_device(dev);
-
-	/* allocate a protection domain if a device is added */
-	dma_domain = find_protection_domain(devid);
-	if (!dma_domain) {
-		dma_domain = dma_ops_domain_alloc();
-		if (!dma_domain)
-			goto out;
-		dma_domain->target_dev = devid;
-
-		init_unity_mappings_for_device(dma_domain, devid);
-
-		spin_lock_irqsave(&iommu_pd_list_lock, flags);
-		list_add_tail(&dma_domain->list, &iommu_pd_list);
-		spin_unlock_irqrestore(&iommu_pd_list_lock, flags);
-	}
-
-	attach_device(dev, &dma_domain->domain);
-
 	dev->archdata.dma_ops = &amd_iommu_dma_ops;
 
 out:
@@ -2445,34 +2310,19 @@ static struct protection_domain *get_domain(struct device *dev)
 {
 	struct protection_domain *domain;
 	struct iommu_domain *io_domain;
-	struct dma_ops_domain *dma_dom;
-	u16 devid = get_device_id(dev);
 
 	if (!check_device(dev))
 		return ERR_PTR(-EINVAL);
 
 	io_domain = iommu_get_domain_for_dev(dev);
-	if (io_domain) {
-		domain = to_pdomain(io_domain);
-		return domain;
-	}
+	if (!io_domain)
+		return NULL;
 
-	domain = domain_for_device(dev);
-	if (domain != NULL && !dma_ops_domain(domain))
+	domain = to_pdomain(io_domain);
+	if (!dma_ops_domain(domain))
 		return ERR_PTR(-EBUSY);
 
-	if (domain != NULL)
-		return domain;
-
-	/* Device not bound yet - bind it */
-	dma_dom = find_protection_domain(devid);
-	if (!dma_dom)
-		dma_dom = amd_iommu_rlookup_table[devid]->default_dom;
-	attach_device(dev, &dma_dom->domain);
-	DUMP_printk("Using protection domain %d for device %s\n",
-		    dma_dom->domain.id, dev_name(dev));
-
-	return &dma_dom->domain;
+	return domain;
 }
 
 static void update_device_table(struct protection_domain *domain)
@@ -3014,23 +2864,7 @@ void __init amd_iommu_init_api(void)
 
 int __init amd_iommu_init_dma_ops(void)
 {
-	struct amd_iommu *iommu;
-	int ret, unhandled;
-
-	/*
-	 * first allocate a default protection domain for every IOMMU we
-	 * found in the system. Devices not assigned to any other
-	 * protection domain will be assigned to the default one.
-	 */
-	for_each_iommu(iommu) {
-		iommu->default_dom = dma_ops_domain_alloc();
-		if (iommu->default_dom == NULL)
-			return -ENOMEM;
-		iommu->default_dom->domain.flags |= PD_DEFAULT_MASK;
-		ret = iommu_init_unity_mappings(iommu);
-		if (ret)
-			goto free_domains;
-	}
+	int unhandled;
 
 	iommu_detected = 1;
 	swiotlb = 0;
@@ -3050,14 +2884,6 @@ int __init amd_iommu_init_dma_ops(void)
 		pr_info("AMD-Vi: Lazy IO/TLB flushing enabled\n");
 
 	return 0;
-
-free_domains:
-
-	for_each_iommu(iommu) {
-		dma_ops_domain_free(iommu->default_dom);
-	}
-
-	return ret;
 }
 
 /*****************************************************************************
@@ -3142,30 +2968,39 @@ static int alloc_passthrough_domain(void)
 static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
 {
 	struct protection_domain *pdomain;
+	struct dma_ops_domain *dma_domain;
 
-	/* We only support unmanaged domains for now */
-	if (type != IOMMU_DOMAIN_UNMANAGED)
-		return NULL;
+	switch (type) {
+	case IOMMU_DOMAIN_UNMANAGED:
+		pdomain = protection_domain_alloc();
+		if (!pdomain)
+			return NULL;
 
-	pdomain = protection_domain_alloc();
-	if (!pdomain)
-		goto out_free;
+		pdomain->mode    = PAGE_MODE_3_LEVEL;
+		pdomain->pt_root = (void *)get_zeroed_page(GFP_KERNEL);
+		if (!pdomain->pt_root) {
+			protection_domain_free(pdomain);
+			return NULL;
+		}
 
-	pdomain->mode    = PAGE_MODE_3_LEVEL;
-	pdomain->pt_root = (void *)get_zeroed_page(GFP_KERNEL);
-	if (!pdomain->pt_root)
-		goto out_free;
+		pdomain->domain.geometry.aperture_start = 0;
+		pdomain->domain.geometry.aperture_end   = ~0ULL;
+		pdomain->domain.geometry.force_aperture = true;
 
-	pdomain->domain.geometry.aperture_start = 0;
-	pdomain->domain.geometry.aperture_end   = ~0ULL;
-	pdomain->domain.geometry.force_aperture = true;
+		break;
+	case IOMMU_DOMAIN_DMA:
+		dma_domain = dma_ops_domain_alloc();
+		if (!dma_domain) {
+			pr_err("AMD-Vi: Failed to allocate\n");
+			return NULL;
+		}
+		pdomain = &dma_domain->domain;
+		break;
+	default:
+		return NULL;
+	}
 
 	return &pdomain->domain;
-
-out_free:
-	protection_domain_free(pdomain);
-
-	return NULL;
 }
 
 static void amd_iommu_domain_free(struct iommu_domain *dom)
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 05030e5..fe796cf 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -552,9 +552,6 @@ struct amd_iommu {
 	/* if one, we need to send a completion wait command */
 	bool need_sync;
 
-	/* default dma_ops domain for that IOMMU */
-	struct dma_ops_domain *default_dom;
-
 	/* IOMMU sysfs device */
 	struct device *iommu_dev;
 
-- 
1.9.1
