Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89995C433F5
	for <iommu@archiver.kernel.org>; Tue,  1 Mar 2022 02:03:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4419080C36;
	Tue,  1 Mar 2022 02:03:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vhF4n-5FsVOR; Tue,  1 Mar 2022 02:03:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8AF5980C52;
	Tue,  1 Mar 2022 02:03:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67336C0077;
	Tue,  1 Mar 2022 02:03:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A69C1C001A
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 02:03:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9068380C36
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 02:03:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yspiaB0PC9ms for <iommu@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 02:03:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 312F980C9C
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 02:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646100232; x=1677636232;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Y1pxiGOT9ZondLK3fcSD+ox6b6OV/Wf1GQnl2QmkoEA=;
 b=BF8vycvB0sAV/IY4HBwYNQWEd35MrHqBUGwdEVStgnXrIXqEeYKlTU0u
 /RnaIJ1CfC7IF4A/orRCIDsvAMklJ2wL5E3a6NRj1W6XI3DFdxhyVI5xs
 QT/8RMyzPo+DFw9UsfP6NjaqksAQ3hgw1J37N5FoG5mqiTDmQRxo9d1GX
 n6UPbBBiOPJINlWujqYUY/ln0UJyh5JHh83qvPOD9TQcri/BXqtWCFQsP
 GoCTC0Gi9XCu4+KMWncTImja89UcHi/dFuoNWMWylqdyYD6kldn5WM6AC
 PISi4tqxV3IuSjVGClJPV7/a4uvdGVqRUfKv5K/Galnr3cGbKNUVxhaO7 A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="339468461"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; d="scan'208";a="339468461"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2022 18:03:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; d="scan'208";a="685551168"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2022 18:03:49 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 05/12] iommu/vt-d: Remove DEFER_DEVICE_DOMAIN_INFO
Date: Tue,  1 Mar 2022 10:01:52 +0800
Message-Id: <20220301020159.633356-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220301020159.633356-1-baolu.lu@linux.intel.com>
References: <20220301020159.633356-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: YueHaibing <yuehaibing@huawei.com>, Marco Bonelli <marco@mebeim.net>,
 iommu@lists.linux-foundation.org, Jason Gunthorpe <jgg@nvidia.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Allocate and set the per-device iommu private data during iommu device
probe. This makes the per-device iommu private data always available
during iommu_probe_device() and iommu_release_device(). With this changed,
the dummy DEFER_DEVICE_DOMAIN_INFO pointer could be removed. The wrappers
for getting the private data and domain are also cleaned.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20220214025704.3184654-1-baolu.lu@linux.intel.com
---
 include/linux/intel-iommu.h   |   2 -
 drivers/iommu/intel/debugfs.c |   3 +-
 drivers/iommu/intel/iommu.c   | 186 +++++++++++++---------------------
 drivers/iommu/intel/pasid.c   |  12 +--
 drivers/iommu/intel/svm.c     |   6 +-
 5 files changed, 79 insertions(+), 130 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 8c7591b5f3e2..03f1134fc2fe 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -733,8 +733,6 @@ int for_each_device_domain(int (*fn)(struct device_domain_info *info,
 				     void *data), void *data);
 void iommu_flush_write_buffer(struct intel_iommu *iommu);
 int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev);
-struct dmar_domain *find_domain(struct device *dev);
-struct device_domain_info *get_domain_info(struct device *dev);
 struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index db7a0ca73626..ed796eea4581 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -344,7 +344,8 @@ static void pgtable_walk_level(struct seq_file *m, struct dma_pte *pde,
 
 static int show_device_domain_translation(struct device *dev, void *data)
 {
-	struct dmar_domain *domain = find_domain(dev);
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct dmar_domain *domain = info->domain;
 	struct seq_file *m = data;
 	u64 path[6] = { 0 };
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7f2ef790595e..c109d12cab0d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -342,21 +342,6 @@ static int iommu_skip_te_disable;
 int intel_iommu_gfx_mapped;
 EXPORT_SYMBOL_GPL(intel_iommu_gfx_mapped);
 
-#define DEFER_DEVICE_DOMAIN_INFO ((struct device_domain_info *)(-2))
-struct device_domain_info *get_domain_info(struct device *dev)
-{
-	struct device_domain_info *info;
-
-	if (!dev)
-		return NULL;
-
-	info = dev_iommu_priv_get(dev);
-	if (unlikely(info == DEFER_DEVICE_DOMAIN_INFO))
-		return NULL;
-
-	return info;
-}
-
 DEFINE_SPINLOCK(device_domain_lock);
 static LIST_HEAD(device_domain_list);
 
@@ -741,11 +726,6 @@ struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
 	return &context[devfn];
 }
 
-static bool attach_deferred(struct device *dev)
-{
-	return dev_iommu_priv_get(dev) == DEFER_DEVICE_DOMAIN_INFO;
-}
-
 /**
  * is_downstream_to_pci_bridge - test if a device belongs to the PCI
  *				 sub-hierarchy of a candidate PCI-PCI bridge
@@ -2432,15 +2412,6 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 	__iommu_flush_dev_iotlb(info, 0, MAX_AGAW_PFN_WIDTH);
 }
 
-static inline void unlink_domain_info(struct device_domain_info *info)
-{
-	assert_spin_locked(&device_domain_lock);
-	list_del(&info->link);
-	list_del(&info->global);
-	if (info->dev)
-		dev_iommu_priv_set(info->dev, NULL);
-}
-
 static void domain_remove_dev_info(struct dmar_domain *domain)
 {
 	struct device_domain_info *info, *tmp;
@@ -2452,24 +2423,6 @@ static void domain_remove_dev_info(struct dmar_domain *domain)
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 }
 
-struct dmar_domain *find_domain(struct device *dev)
-{
-	struct device_domain_info *info;
-
-	if (unlikely(!dev || !dev->iommu))
-		return NULL;
-
-	if (unlikely(attach_deferred(dev)))
-		return NULL;
-
-	/* No lock here, assumes no domain exit in normal case */
-	info = get_domain_info(dev);
-	if (likely(info))
-		return info->domain;
-
-	return NULL;
-}
-
 static inline struct device_domain_info *
 dmar_search_domain_by_dev_info(int segment, int bus, int devfn)
 {
@@ -2530,66 +2483,20 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 						    struct device *dev,
 						    struct dmar_domain *domain)
 {
-	struct device_domain_info *info;
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	unsigned long flags;
 	int ret;
 
-	info = kzalloc(sizeof(*info), GFP_KERNEL);
-	if (!info)
-		return NULL;
-
-	if (!dev_is_real_dma_subdevice(dev)) {
-		info->bus = bus;
-		info->devfn = devfn;
-		info->segment = iommu->segment;
-	} else {
-		struct pci_dev *pdev = to_pci_dev(dev);
-
-		info->bus = pdev->bus->number;
-		info->devfn = pdev->devfn;
-		info->segment = pci_domain_nr(pdev->bus);
-	}
-
-	info->dev = dev;
-	info->domain = domain;
-	info->iommu = iommu;
-
-	if (dev && dev_is_pci(dev)) {
-		struct pci_dev *pdev = to_pci_dev(info->dev);
-
-		if (ecap_dev_iotlb_support(iommu->ecap) &&
-		    pci_ats_supported(pdev) &&
-		    dmar_find_matched_atsr_unit(pdev))
-			info->ats_supported = 1;
-
-		if (sm_supported(iommu)) {
-			if (pasid_supported(iommu)) {
-				int features = pci_pasid_features(pdev);
-				if (features >= 0)
-					info->pasid_supported = features | 1;
-			}
-
-			if (info->ats_supported && ecap_prs(iommu->ecap) &&
-			    pci_pri_supported(pdev))
-				info->pri_supported = 1;
-		}
-	}
-
 	spin_lock_irqsave(&device_domain_lock, flags);
+	info->domain = domain;
 	spin_lock(&iommu->lock);
 	ret = domain_attach_iommu(domain, iommu);
 	spin_unlock(&iommu->lock);
-
 	if (ret) {
 		spin_unlock_irqrestore(&device_domain_lock, flags);
-		kfree(info);
 		return NULL;
 	}
-
 	list_add(&info->link, &domain->devices);
-	list_add(&info->global, &device_domain_list);
-	if (dev)
-		dev_iommu_priv_set(dev, info);
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 
 	/* PASID table is mandatory for a PCI device in scalable mode. */
@@ -4336,13 +4243,11 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 		intel_pasid_free_table(info->dev);
 	}
 
-	unlink_domain_info(info);
+	list_del(&info->link);
 
 	spin_lock_irqsave(&iommu->lock, flags);
 	domain_detach_iommu(domain, iommu);
 	spin_unlock_irqrestore(&iommu->lock, flags);
-
-	kfree(info);
 }
 
 static void dmar_remove_one_dev_info(struct device *dev)
@@ -4351,7 +4256,7 @@ static void dmar_remove_one_dev_info(struct device *dev)
 	unsigned long flags;
 
 	spin_lock_irqsave(&device_domain_lock, flags);
-	info = get_domain_info(dev);
+	info = dev_iommu_priv_get(dev);
 	if (info)
 		__dmar_remove_one_dev_info(info);
 	spin_unlock_irqrestore(&device_domain_lock, flags);
@@ -4475,10 +4380,9 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 
 	/* normally dev is not mapped */
 	if (unlikely(domain_context_mapped(dev))) {
-		struct dmar_domain *old_domain;
+		struct device_domain_info *info = dev_iommu_priv_get(dev);
 
-		old_domain = find_domain(dev);
-		if (old_domain)
+		if (info->domain)
 			dmar_remove_one_dev_info(dev);
 	}
 
@@ -4642,28 +4546,73 @@ static bool intel_iommu_capable(enum iommu_cap cap)
 
 static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 {
+	struct pci_dev *pdev = dev_is_pci(dev) ? to_pci_dev(dev) : NULL;
+	struct device_domain_info *info;
 	struct intel_iommu *iommu;
+	unsigned long flags;
+	u8 bus, devfn;
 
-	iommu = device_to_iommu(dev, NULL, NULL);
+	iommu = device_to_iommu(dev, &bus, &devfn);
 	if (!iommu)
 		return ERR_PTR(-ENODEV);
 
-	if (translation_pre_enabled(iommu))
-		dev_iommu_priv_set(dev, DEFER_DEVICE_DOMAIN_INFO);
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return ERR_PTR(-ENOMEM);
+
+	if (dev_is_real_dma_subdevice(dev)) {
+		info->bus = pdev->bus->number;
+		info->devfn = pdev->devfn;
+		info->segment = pci_domain_nr(pdev->bus);
+	} else {
+		info->bus = bus;
+		info->devfn = devfn;
+		info->segment = iommu->segment;
+	}
+
+	info->dev = dev;
+	info->iommu = iommu;
+	if (dev_is_pci(dev)) {
+		if (ecap_dev_iotlb_support(iommu->ecap) &&
+		    pci_ats_supported(pdev) &&
+		    dmar_find_matched_atsr_unit(pdev))
+			info->ats_supported = 1;
+
+		if (sm_supported(iommu)) {
+			if (pasid_supported(iommu)) {
+				int features = pci_pasid_features(pdev);
+
+				if (features >= 0)
+					info->pasid_supported = features | 1;
+			}
+
+			if (info->ats_supported && ecap_prs(iommu->ecap) &&
+			    pci_pri_supported(pdev))
+				info->pri_supported = 1;
+		}
+	}
+
+	spin_lock_irqsave(&device_domain_lock, flags);
+	list_add(&info->global, &device_domain_list);
+	dev_iommu_priv_set(dev, info);
+	spin_unlock_irqrestore(&device_domain_lock, flags);
 
 	return &iommu->iommu;
 }
 
 static void intel_iommu_release_device(struct device *dev)
 {
-	struct intel_iommu *iommu;
-
-	iommu = device_to_iommu(dev, NULL, NULL);
-	if (!iommu)
-		return;
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	unsigned long flags;
 
 	dmar_remove_one_dev_info(dev);
 
+	spin_lock_irqsave(&device_domain_lock, flags);
+	dev_iommu_priv_set(dev, NULL);
+	list_del(&info->global);
+	spin_unlock_irqrestore(&device_domain_lock, flags);
+
+	kfree(info);
 	set_dma_ops(dev, NULL);
 }
 
@@ -4732,14 +4681,14 @@ static void intel_iommu_get_resv_regions(struct device *device,
 
 int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev)
 {
-	struct device_domain_info *info;
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct context_entry *context;
 	struct dmar_domain *domain;
 	unsigned long flags;
 	u64 ctx_lo;
 	int ret;
 
-	domain = find_domain(dev);
+	domain = info->domain;
 	if (!domain)
 		return -EINVAL;
 
@@ -4747,8 +4696,7 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev)
 	spin_lock(&iommu->lock);
 
 	ret = -EINVAL;
-	info = get_domain_info(dev);
-	if (!info || !info->pasid_supported)
+	if (!info->pasid_supported)
 		goto out;
 
 	context = iommu_context_addr(iommu, info->bus, info->devfn, 0);
@@ -4790,7 +4738,7 @@ static struct iommu_group *intel_iommu_device_group(struct device *dev)
 
 static int intel_iommu_enable_sva(struct device *dev)
 {
-	struct device_domain_info *info = get_domain_info(dev);
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu;
 	int ret;
 
@@ -4819,7 +4767,7 @@ static int intel_iommu_enable_sva(struct device *dev)
 
 static int intel_iommu_disable_sva(struct device *dev)
 {
-	struct device_domain_info *info = get_domain_info(dev);
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
 	int ret;
 
@@ -4832,7 +4780,7 @@ static int intel_iommu_disable_sva(struct device *dev)
 
 static int intel_iommu_enable_iopf(struct device *dev)
 {
-	struct device_domain_info *info = get_domain_info(dev);
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
 
 	if (info && info->pri_supported)
 		return 0;
@@ -4872,7 +4820,9 @@ intel_iommu_dev_disable_feat(struct device *dev, enum iommu_dev_features feat)
 
 static bool intel_iommu_is_attach_deferred(struct device *dev)
 {
-	return attach_deferred(dev);
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+
+	return translation_pre_enabled(info->iommu) && !info->domain;
 }
 
 /*
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 10fb82ea467d..f8d215d85695 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -150,7 +150,7 @@ int intel_pasid_alloc_table(struct device *dev)
 	int size;
 
 	might_sleep();
-	info = get_domain_info(dev);
+	info = dev_iommu_priv_get(dev);
 	if (WARN_ON(!info || !dev_is_pci(dev) || info->pasid_table))
 		return -EINVAL;
 
@@ -197,7 +197,7 @@ void intel_pasid_free_table(struct device *dev)
 	struct pasid_entry *table;
 	int i, max_pde;
 
-	info = get_domain_info(dev);
+	info = dev_iommu_priv_get(dev);
 	if (!info || !dev_is_pci(dev) || !info->pasid_table)
 		return;
 
@@ -223,7 +223,7 @@ struct pasid_table *intel_pasid_get_table(struct device *dev)
 {
 	struct device_domain_info *info;
 
-	info = get_domain_info(dev);
+	info = dev_iommu_priv_get(dev);
 	if (!info)
 		return NULL;
 
@@ -234,7 +234,7 @@ static int intel_pasid_get_dev_max_id(struct device *dev)
 {
 	struct device_domain_info *info;
 
-	info = get_domain_info(dev);
+	info = dev_iommu_priv_get(dev);
 	if (!info || !info->pasid_table)
 		return 0;
 
@@ -254,7 +254,7 @@ static struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid)
 		return NULL;
 
 	dir = pasid_table->table;
-	info = get_domain_info(dev);
+	info = dev_iommu_priv_get(dev);
 	dir_index = pasid >> PASID_PDE_SHIFT;
 	index = pasid & PASID_PTE_MASK;
 
@@ -487,7 +487,7 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
 	struct device_domain_info *info;
 	u16 sid, qdep, pfsid;
 
-	info = get_domain_info(dev);
+	info = dev_iommu_priv_get(dev);
 	if (!info || !info->ats_enabled)
 		return;
 
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index d04c83dd3a58..944e2408b6d2 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -200,7 +200,7 @@ static void __flush_svm_range_dev(struct intel_svm *svm,
 				  unsigned long address,
 				  unsigned long pages, int ih)
 {
-	struct device_domain_info *info = get_domain_info(sdev->dev);
+	struct device_domain_info *info = dev_iommu_priv_get(sdev->dev);
 
 	if (WARN_ON(!pages))
 		return;
@@ -337,7 +337,7 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 					   struct mm_struct *mm,
 					   unsigned int flags)
 {
-	struct device_domain_info *info = get_domain_info(dev);
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	unsigned long iflags, sflags;
 	struct intel_svm_dev *sdev;
 	struct intel_svm *svm;
@@ -545,7 +545,7 @@ static void intel_svm_drain_prq(struct device *dev, u32 pasid)
 	u16 sid, did;
 	int qdep;
 
-	info = get_domain_info(dev);
+	info = dev_iommu_priv_get(dev);
 	if (WARN_ON(!info || !dev_is_pci(dev)))
 		return;
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
