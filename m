Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E11E1C433F5
	for <iommu@archiver.kernel.org>; Mon,  7 Feb 2022 06:43:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D56F81458;
	Mon,  7 Feb 2022 06:43:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1qvIWm8KwQ7H; Mon,  7 Feb 2022 06:43:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 45DB48144C;
	Mon,  7 Feb 2022 06:43:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 300CBC0011;
	Mon,  7 Feb 2022 06:43:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23949C000B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 06:43:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 030F440240
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 06:43:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U3zC76y_XPkI for <iommu@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 06:43:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 18BB4400E5
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 06:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644216199; x=1675752199;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6WtSTQdjRD4wi8NPB/wH0EeILHtZl3dydvFj3GNNpHk=;
 b=mKWUP/wNDVNtnB8Nnm2qobod4ipQeBdSxbPXjK1Na7UGq8u2UiwVvhBV
 HBJDb92tE7sCbadoyYt7WJNX+Y3sBcobI04xK1eNDqW6nvCPWMC24qwK1
 IHwlS+Lec7Ixszj7H99zPT2m05Cn1rQ853goM90ntmp/VoWMtff9VS4e1
 Lp/qqE3dJoHgiWO4P12fiR/yNlAjxepGZg8UzQUS3qR6iCBWl/suGi/JQ
 JzPbeysCdVWkbEowQX4XgSfCNsbDPxI/aoCTlwE4UNEWyxcGQoF4N+0Ly
 yOHeLHa8edOrNgJQi7U9npk12PNbzVJqls+XkHYOuz7K2BVhNfKy+8S1d w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="228622961"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; d="scan'208";a="228622961"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2022 22:43:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; d="scan'208";a="525020280"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 06 Feb 2022 22:43:15 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v1 06/10] iommu/vt-d: Remove DEFER_DEVICE_DOMAIN_INFO
Date: Mon,  7 Feb 2022 14:41:38 +0800
Message-Id: <20220207064142.1092846-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
References: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
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
probe. Add a flag to indicate whether default domain attachment is
deferred. With this refactoring, the dummy DEFER_DEVICE_DOMAIN_INFO
pointer is removed.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 122 +++++++++++++++---------------------
 1 file changed, 51 insertions(+), 71 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 185aa38df602..165c890b8304 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -309,19 +309,9 @@ static int iommu_skip_te_disable;
 int intel_iommu_gfx_mapped;
 EXPORT_SYMBOL_GPL(intel_iommu_gfx_mapped);
 
-#define DEFER_DEVICE_DOMAIN_INFO ((struct device_domain_info *)(-2))
 struct device_domain_info *get_domain_info(struct device *dev)
 {
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
+	return dev_iommu_priv_get(dev);
 }
 
 DEFINE_SPINLOCK(device_domain_lock);
@@ -708,11 +698,6 @@ struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
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
@@ -2426,9 +2411,6 @@ struct dmar_domain *find_domain(struct device *dev)
 	if (unlikely(!dev || !dev->iommu))
 		return NULL;
 
-	if (unlikely(attach_deferred(dev)))
-		return NULL;
-
 	/* No lock here, assumes no domain exit in normal case */
 	info = get_domain_info(dev);
 	if (likely(info))
@@ -2497,66 +2479,20 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 						    struct device *dev,
 						    struct dmar_domain *domain)
 {
-	struct device_domain_info *info;
+	struct device_domain_info *info = get_domain_info(dev);
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
@@ -4405,14 +4341,56 @@ static bool intel_iommu_capable(enum iommu_cap cap)
 
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
@@ -4635,7 +4613,9 @@ intel_iommu_dev_disable_feat(struct device *dev, enum iommu_dev_features feat)
 
 static bool intel_iommu_is_attach_deferred(struct device *dev)
 {
-	return attach_deferred(dev);
+	struct device_domain_info *info = get_domain_info(dev);
+
+	return translation_pre_enabled(info->iommu) && !info->domain;
 }
 
 /*
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
