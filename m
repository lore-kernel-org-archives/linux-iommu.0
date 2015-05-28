From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 16/22] iommu/amd: Implement add_device and remove_device
Date: Thu, 28 May 2015 18:41:39 +0200
Message-ID: <1432831305-11126-17-git-send-email-joro@8bytes.org>
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

Implement these two iommu-ops call-backs to make use of the
initialization and notifier features of the iommu core.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c      | 210 +++++++++++------------------------------
 drivers/iommu/amd_iommu_init.c |  31 ++----
 2 files changed, 63 insertions(+), 178 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index dc8e44b..44eeca4 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -119,7 +119,7 @@ struct iommu_cmd {
 struct kmem_cache *amd_iommu_irq_cache;
 
 static void update_domain(struct protection_domain *domain);
-static int __init alloc_passthrough_domain(void);
+static int alloc_passthrough_domain(void);
 
 /****************************************************************************
  *
@@ -434,64 +434,15 @@ static void iommu_uninit_device(struct device *dev)
 	/* Unlink from alias, it may change if another device is re-plugged */
 	dev_data->alias_data = NULL;
 
+	/* Remove dma-ops */
+	dev->archdata.dma_ops = NULL;
+
 	/*
 	 * We keep dev_data around for unplugged devices and reuse it when the
 	 * device is re-plugged - not doing so would introduce a ton of races.
 	 */
 }
 
-void __init amd_iommu_uninit_devices(void)
-{
-	struct iommu_dev_data *dev_data, *n;
-	struct pci_dev *pdev = NULL;
-
-	for_each_pci_dev(pdev) {
-
-		if (!check_device(&pdev->dev))
-			continue;
-
-		iommu_uninit_device(&pdev->dev);
-	}
-
-	/* Free all of our dev_data structures */
-	list_for_each_entry_safe(dev_data, n, &dev_data_list, dev_data_list)
-		free_dev_data(dev_data);
-}
-
-int __init amd_iommu_init_devices(void)
-{
-	struct pci_dev *pdev = NULL;
-	int ret = 0;
-
-	for_each_pci_dev(pdev) {
-
-		if (!check_device(&pdev->dev))
-			continue;
-
-		ret = iommu_init_device(&pdev->dev);
-		if (ret == -ENOTSUPP)
-			iommu_ignore_device(&pdev->dev);
-		else if (ret)
-			goto out_free;
-	}
-
-	/*
-	 * Initialize IOMMU groups only after iommu_init_device() has
-	 * had a chance to populate any IVRS defined aliases.
-	 */
-	for_each_pci_dev(pdev) {
-		if (check_device(&pdev->dev))
-			init_iommu_group(&pdev->dev);
-	}
-
-	return 0;
-
-out_free:
-
-	amd_iommu_uninit_devices();
-
-	return ret;
-}
 #ifdef CONFIG_AMD_IOMMU_STATS
 
 /*
@@ -2402,81 +2353,79 @@ static struct protection_domain *domain_for_device(struct device *dev)
 	return dom;
 }
 
-static int device_change_notifier(struct notifier_block *nb,
-				  unsigned long action, void *data)
+static int amd_iommu_add_device(struct device *dev)
 {
 	struct dma_ops_domain *dma_domain;
 	struct protection_domain *domain;
 	struct iommu_dev_data *dev_data;
-	struct device *dev = data;
 	struct amd_iommu *iommu;
 	unsigned long flags;
 	u16 devid;
+	int ret;
 
-	if (!check_device(dev))
+	if (!check_device(dev) || get_dev_data(dev))
 		return 0;
 
-	devid    = get_device_id(dev);
-	iommu    = amd_iommu_rlookup_table[devid];
-	dev_data = get_dev_data(dev);
-
-	switch (action) {
-	case BUS_NOTIFY_ADD_DEVICE:
-
-		iommu_init_device(dev);
-		init_iommu_group(dev);
+	devid = get_device_id(dev);
+	iommu = amd_iommu_rlookup_table[devid];
 
-		/*
-		 * dev_data is still NULL and
-		 * got initialized in iommu_init_device
-		 */
-		dev_data = get_dev_data(dev);
+	ret = iommu_init_device(dev);
+	if (ret == -ENOTSUPP) {
+		iommu_ignore_device(dev);
+		goto out;
+	}
+	init_iommu_group(dev);
 
-		if (iommu_pass_through || dev_data->iommu_v2) {
-			dev_data->passthrough = true;
-			attach_device(dev, pt_domain);
-			break;
-		}
+	dev_data = get_dev_data(dev);
 
-		domain = domain_for_device(dev);
+	if (iommu_pass_through || dev_data->iommu_v2) {
+		/* Make sure passthrough domain is allocated */
+		alloc_passthrough_domain();
+		dev_data->passthrough = true;
+		attach_device(dev, pt_domain);
+		goto out;
+	}
 
-		/* allocate a protection domain if a device is added */
-		dma_domain = find_protection_domain(devid);
-		if (!dma_domain) {
-			dma_domain = dma_ops_domain_alloc();
-			if (!dma_domain)
-				goto out;
-			dma_domain->target_dev = devid;
+	domain = domain_for_device(dev);
 
-			spin_lock_irqsave(&iommu_pd_list_lock, flags);
-			list_add_tail(&dma_domain->list, &iommu_pd_list);
-			spin_unlock_irqrestore(&iommu_pd_list_lock, flags);
-		}
+	/* allocate a protection domain if a device is added */
+	dma_domain = find_protection_domain(devid);
+	if (!dma_domain) {
+		dma_domain = dma_ops_domain_alloc();
+		if (!dma_domain)
+			goto out;
+		dma_domain->target_dev = devid;
 
-		dev->archdata.dma_ops = &amd_iommu_dma_ops;
+		init_unity_mappings_for_device(dma_domain, devid);
 
-		break;
-	case BUS_NOTIFY_REMOVED_DEVICE:
+		spin_lock_irqsave(&iommu_pd_list_lock, flags);
+		list_add_tail(&dma_domain->list, &iommu_pd_list);
+		spin_unlock_irqrestore(&iommu_pd_list_lock, flags);
+	}
 
-		iommu_uninit_device(dev);
+	attach_device(dev, &dma_domain->domain);
 
-	default:
-		goto out;
-	}
+	dev->archdata.dma_ops = &amd_iommu_dma_ops;
 
+out:
 	iommu_completion_wait(iommu);
 
-out:
 	return 0;
 }
 
-static struct notifier_block device_nb = {
-	.notifier_call = device_change_notifier,
-};
-
-void amd_iommu_init_notifier(void)
+static void amd_iommu_remove_device(struct device *dev)
 {
-	bus_register_notifier(&pci_bus_type, &device_nb);
+	struct amd_iommu *iommu;
+	u16 devid;
+
+	if (!check_device(dev))
+		return;
+
+	devid = get_device_id(dev);
+	iommu = amd_iommu_rlookup_table[devid];
+
+	iommu_uninit_device(dev);
+	iommu_completion_wait(iommu);
 }
 
 /*****************************************************************************
@@ -3018,54 +2967,6 @@ static int amd_iommu_dma_supported(struct device *dev, u64 mask)
 	return check_device(dev);
 }
 
-/*
- * The function for pre-allocating protection domains.
- *
- * If the driver core informs the DMA layer if a driver grabs a device
- * we don't need to preallocate the protection domains anymore.
- * For now we have to.
- */
-static void __init prealloc_protection_domains(void)
-{
-	struct iommu_dev_data *dev_data;
-	struct dma_ops_domain *dma_dom;
-	struct pci_dev *dev = NULL;
-	u16 devid;
-
-	for_each_pci_dev(dev) {
-
-		/* Do we handle this device? */
-		if (!check_device(&dev->dev))
-			continue;
-
-		dev_data = get_dev_data(&dev->dev);
-		if (!amd_iommu_force_isolation && dev_data->iommu_v2) {
-			/* Make sure passthrough domain is allocated */
-			alloc_passthrough_domain();
-			dev_data->passthrough = true;
-			attach_device(&dev->dev, pt_domain);
-			pr_info("AMD-Vi: Using passthrough domain for device %s\n",
-				dev_name(&dev->dev));
-		}
-
-		/* Is there already any domain for it? */
-		if (domain_for_device(&dev->dev))
-			continue;
-
-		devid = get_device_id(&dev->dev);
-
-		dma_dom = dma_ops_domain_alloc();
-		if (!dma_dom)
-			continue;
-		init_unity_mappings_for_device(dma_dom, devid);
-		dma_dom->target_dev = devid;
-
-		attach_device(&dev->dev, &dma_dom->domain);
-
-		list_add_tail(&dma_dom->list, &iommu_pd_list);
-	}
-}
-
 static struct dma_map_ops amd_iommu_dma_ops = {
 	.alloc = alloc_coherent,
 	.free = free_coherent,
@@ -3131,11 +3032,6 @@ int __init amd_iommu_init_dma_ops(void)
 			goto free_domains;
 	}
 
-	/*
-	 * Pre-allocate the protection domains for each device.
-	 */
-	prealloc_protection_domains();
-
 	iommu_detected = 1;
 	swiotlb = 0;
 
@@ -3228,7 +3124,7 @@ out_err:
 	return NULL;
 }
 
-static int __init alloc_passthrough_domain(void)
+static int alloc_passthrough_domain(void)
 {
 	if (pt_domain != NULL)
 		return 0;
@@ -3464,6 +3360,8 @@ static const struct iommu_ops amd_iommu_ops = {
 	.unmap = amd_iommu_unmap,
 	.map_sg = default_iommu_map_sg,
 	.iova_to_phys = amd_iommu_iova_to_phys,
+	.add_device = amd_iommu_add_device,
+	.remove_device = amd_iommu_remove_device,
 	.get_dm_regions = amd_iommu_get_dm_regions,
 	.put_dm_regions = amd_iommu_put_dm_regions,
 	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 450ef50..e4a6e40 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -226,6 +226,7 @@ static enum iommu_init_state init_state = IOMMU_START_STATE;
 
 static int amd_iommu_enable_interrupts(void);
 static int __init iommu_go_to_state(enum iommu_init_state state);
+static void init_device_table_dma(void);
 
 static inline void update_last_devid(u16 devid)
 {
@@ -1385,7 +1386,12 @@ static int __init amd_iommu_init_pci(void)
 			break;
 	}
 
-	ret = amd_iommu_init_devices();
+	init_device_table_dma();
+
+	for_each_iommu(iommu)
+		iommu_flush_all_caches(iommu);
+
+	amd_iommu_init_api();
 
 	print_iommu_info();
 
@@ -1825,8 +1831,6 @@ static bool __init check_ioapic_information(void)
 
 static void __init free_dma_resources(void)
 {
-	amd_iommu_uninit_devices();
-
 	free_pages((unsigned long)amd_iommu_pd_alloc_bitmap,
 		   get_order(MAX_DOMAIN_ID/8));
 
@@ -2019,27 +2023,10 @@ static bool detect_ivrs(void)
 
 static int amd_iommu_init_dma(void)
 {
-	struct amd_iommu *iommu;
-	int ret;
-
 	if (iommu_pass_through)
-		ret = amd_iommu_init_passthrough();
+		return amd_iommu_init_passthrough();
 	else
-		ret = amd_iommu_init_dma_ops();
-
-	if (ret)
-		return ret;
-
-	init_device_table_dma();
-
-	for_each_iommu(iommu)
-		iommu_flush_all_caches(iommu);
-
-	amd_iommu_init_api();
-
-	amd_iommu_init_notifier();
-
-	return 0;
+		return amd_iommu_init_dma_ops();
 }
 
 /****************************************************************************
-- 
1.9.1
