Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2676C182A8
	for <iommu@lists.linux.dev>; Wed,  9 Aug 2023 12:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691585438; x=1723121438;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tdgrp3Maev1ZcS6b/C0V5HVL9R+QcLiORmhmxsQhAQw=;
  b=As6A4jScnhdWxIx8DpWVTEqav9ekN31XYM/cONnO18s1WSK0XVUTFLLJ
   r2y0d2hRbXx9PnvVd3+neWuR0bQA+ZyOKg/+cz62UmKFt+xvrPXJJ4orq
   dwfIQ0B2Z4ppAnlcAg8hUoVGT6fpu3gSyUTeFnCduo+l5ya9BiiPbsLY6
   ynM9GQdHTnzSyoiY8xqWEfvw/WRqJUGtdShGguQg12SARxQC06Syd1z7h
   s0HGakhkL2BTWApHua+d3MCt+demb9TbuyGl8gomNv7mNxotgrUw3IEZ8
   8P7PnJ+Os1Dc0tGUInuZVqEc3/cFhD4rygXR5NInrasMLTLdhCwkxxWjd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="374821727"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="374821727"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 05:50:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="855521762"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="855521762"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga004.jf.intel.com with ESMTP; 09 Aug 2023 05:50:35 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: YueHaibing <yuehaibing@huawei.com>,
	Yanfei Xu <yanfei.xu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/13] iommu/vt-d: Add set_dev_pasid callback for dma domain
Date: Wed,  9 Aug 2023 20:48:00 +0800
Message-Id: <20230809124806.45516-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809124806.45516-1-baolu.lu@linux.intel.com>
References: <20230809124806.45516-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows the upper layers to set a domain to a PASID of a device
if the PASID feature is supported by the IOMMU hardware. The typical
use cases are, for example, kernel DMA with PASID and hardware
assisted mediated device drivers.

The attaching device and pasid information is tracked in a per-domain
list and is used for IOTLB and devTLB invalidation.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20230802212427.1497170-8-jacob.jun.pan@linux.intel.com
---
 drivers/iommu/intel/iommu.h |   7 +++
 drivers/iommu/intel/iommu.c | 104 ++++++++++++++++++++++++++++++++++--
 2 files changed, 106 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 6d94a29f5d52..c18fb699c87a 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -595,6 +595,7 @@ struct dmar_domain {
 
 	spinlock_t lock;		/* Protect device tracking lists */
 	struct list_head devices;	/* all devices' list */
+	struct list_head dev_pasids;	/* all attached pasids */
 
 	struct dma_pte	*pgd;		/* virtual address */
 	int		gaw;		/* max guest address width */
@@ -717,6 +718,12 @@ struct device_domain_info {
 	struct pasid_table *pasid_table; /* pasid table */
 };
 
+struct dev_pasid_info {
+	struct list_head link_domain;	/* link to domain siblings */
+	struct device *dev;
+	ioasid_t pasid;
+};
+
 static inline void __iommu_flush_cache(
 	struct intel_iommu *iommu, void *addr, int size)
 {
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4a41aca6a2ba..f939fc2aa66c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1359,6 +1359,7 @@ domain_lookup_dev_info(struct dmar_domain *domain,
 
 static void domain_update_iotlb(struct dmar_domain *domain)
 {
+	struct dev_pasid_info *dev_pasid;
 	struct device_domain_info *info;
 	bool has_iotlb_device = false;
 	unsigned long flags;
@@ -1370,6 +1371,14 @@ static void domain_update_iotlb(struct dmar_domain *domain)
 			break;
 		}
 	}
+
+	list_for_each_entry(dev_pasid, &domain->dev_pasids, link_domain) {
+		info = dev_iommu_priv_get(dev_pasid->dev);
+		if (info->ats_enabled) {
+			has_iotlb_device = true;
+			break;
+		}
+	}
 	domain->has_iotlb_device = has_iotlb_device;
 	spin_unlock_irqrestore(&domain->lock, flags);
 }
@@ -1455,6 +1464,7 @@ static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
 static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 				  u64 addr, unsigned mask)
 {
+	struct dev_pasid_info *dev_pasid;
 	struct device_domain_info *info;
 	unsigned long flags;
 
@@ -1464,6 +1474,19 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 	spin_lock_irqsave(&domain->lock, flags);
 	list_for_each_entry(info, &domain->devices, link)
 		__iommu_flush_dev_iotlb(info, addr, mask);
+
+	list_for_each_entry(dev_pasid, &domain->dev_pasids, link_domain) {
+		info = dev_iommu_priv_get(dev_pasid->dev);
+
+		if (!info->ats_enabled)
+			continue;
+
+		qi_flush_dev_iotlb_pasid(info->iommu,
+					 PCI_DEVID(info->bus, info->devfn),
+					 info->pfsid, dev_pasid->pasid,
+					 info->ats_qdep, addr,
+					 mask);
+	}
 	spin_unlock_irqrestore(&domain->lock, flags);
 }
 
@@ -1472,9 +1495,13 @@ static void domain_flush_pasid_iotlb(struct intel_iommu *iommu,
 				     unsigned long npages, bool ih)
 {
 	u16 did = domain_id_iommu(domain, iommu);
+	struct dev_pasid_info *dev_pasid;
 	unsigned long flags;
 
 	spin_lock_irqsave(&domain->lock, flags);
+	list_for_each_entry(dev_pasid, &domain->dev_pasids, link_domain)
+		qi_flush_piotlb(iommu, did, dev_pasid->pasid, addr, npages, ih);
+
 	if (!list_empty(&domain->devices))
 		qi_flush_piotlb(iommu, did, IOMMU_NO_PASID, addr, npages, ih);
 	spin_unlock_irqrestore(&domain->lock, flags);
@@ -1739,6 +1766,7 @@ static struct dmar_domain *alloc_domain(unsigned int type)
 		domain->use_first_level = true;
 	domain->has_iotlb_device = false;
 	INIT_LIST_HEAD(&domain->devices);
+	INIT_LIST_HEAD(&domain->dev_pasids);
 	spin_lock_init(&domain->lock);
 	xa_init(&domain->iommu_array);
 
@@ -4719,7 +4747,10 @@ static void intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
 static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 {
 	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
+	struct dev_pasid_info *curr, *dev_pasid = NULL;
+	struct dmar_domain *dmar_domain;
 	struct iommu_domain *domain;
+	unsigned long flags;
 
 	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
 	if (WARN_ON_ONCE(!domain))
@@ -4735,17 +4766,79 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 		goto out_tear_down;
 	}
 
-	/*
-	 * Should never reach here until we add support for attaching
-	 * non-SVA domain to a pasid.
-	 */
-	WARN_ON(1);
+	dmar_domain = to_dmar_domain(domain);
+	spin_lock_irqsave(&dmar_domain->lock, flags);
+	list_for_each_entry(curr, &dmar_domain->dev_pasids, link_domain) {
+		if (curr->dev == dev && curr->pasid == pasid) {
+			list_del(&curr->link_domain);
+			dev_pasid = curr;
+			break;
+		}
+	}
+	WARN_ON_ONCE(!dev_pasid);
+	spin_unlock_irqrestore(&dmar_domain->lock, flags);
 
+	domain_detach_iommu(dmar_domain, iommu);
+	kfree(dev_pasid);
 out_tear_down:
 	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
 	intel_drain_pasid_prq(dev, pasid);
 }
 
+static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
+				     struct device *dev, ioasid_t pasid)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct intel_iommu *iommu = info->iommu;
+	struct dev_pasid_info *dev_pasid;
+	unsigned long flags;
+	int ret;
+
+	if (!pasid_supported(iommu) || dev_is_real_dma_subdevice(dev))
+		return -EOPNOTSUPP;
+
+	if (context_copied(iommu, info->bus, info->devfn))
+		return -EBUSY;
+
+	ret = prepare_domain_attach_device(domain, dev);
+	if (ret)
+		return ret;
+
+	dev_pasid = kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
+	if (!dev_pasid)
+		return -ENOMEM;
+
+	ret = domain_attach_iommu(dmar_domain, iommu);
+	if (ret)
+		goto out_free;
+
+	if (domain_type_is_si(dmar_domain))
+		ret = intel_pasid_setup_pass_through(iommu, dmar_domain,
+						     dev, pasid);
+	else if (dmar_domain->use_first_level)
+		ret = domain_setup_first_level(iommu, dmar_domain,
+					       dev, pasid);
+	else
+		ret = intel_pasid_setup_second_level(iommu, dmar_domain,
+						     dev, pasid);
+	if (ret)
+		goto out_detach_iommu;
+
+	dev_pasid->dev = dev;
+	dev_pasid->pasid = pasid;
+	spin_lock_irqsave(&dmar_domain->lock, flags);
+	list_add(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
+	spin_unlock_irqrestore(&dmar_domain->lock, flags);
+
+	return 0;
+out_detach_iommu:
+	domain_detach_iommu(dmar_domain, iommu);
+out_free:
+	kfree(dev_pasid);
+	return ret;
+}
+
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
@@ -4765,6 +4858,7 @@ const struct iommu_ops intel_iommu_ops = {
 #endif
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev		= intel_iommu_attach_device,
+		.set_dev_pasid		= intel_iommu_set_dev_pasid,
 		.map_pages		= intel_iommu_map_pages,
 		.unmap_pages		= intel_iommu_unmap_pages,
 		.iotlb_sync_map		= intel_iommu_iotlb_sync_map,
-- 
2.34.1

