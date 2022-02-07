Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E2CC433F5
	for <iommu@archiver.kernel.org>; Mon,  7 Feb 2022 06:43:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6142060B92;
	Mon,  7 Feb 2022 06:43:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4WslSx4YpQbQ; Mon,  7 Feb 2022 06:43:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 05A6660625;
	Mon,  7 Feb 2022 06:43:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6A96C0011;
	Mon,  7 Feb 2022 06:43:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55007C000B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 06:43:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 449B060625
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 06:43:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oKjKQ0T-927E for <iommu@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 06:43:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 67BBB60AAF
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 06:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644216208; x=1675752208;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mT+9PcyYDHIgmL0UWJZy2RHRNEpPZBOFnxSL7FkSYzI=;
 b=Wvo0gQhngfzIyHtvSGZaERNy8svm+A+viJimcRVmTPpQtAsLxXu9ybuh
 fnttj48IKNqor+JM+lFCo66oZw03RBFzm3hoXLxuv8d0jxtJk2mGnR9n+
 Ayvj5qzjeMFC4TkDvFYkASx++pGZP+w0BpKD+ZzOgWuI5R0TYYT5WpZ+M
 56+i0IfxPYME2H8P4ZA3MVu5L1SSCtHFIyOth7OEZqfcbSMzFXhMBO4x/
 jiScvH0E8ILwxTef+reA+U5j3wIdFZH76TkJFxatvQrXX6hdmVt799R4U
 DLjXK+n1B3pYxrPUiG20qFOopFaAMUFJyvdos7Pik8Ky403KL+4Z+LtHU w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="228622989"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; d="scan'208";a="228622989"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2022 22:43:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; d="scan'208";a="525020334"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 06 Feb 2022 22:43:25 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v1 09/10] iommu/vt-d: Refactor dmar_insert_one_dev_info()
Date: Mon,  7 Feb 2022 14:41:41 +0800
Message-Id: <20220207064142.1092846-10-baolu.lu@linux.intel.com>
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

The existing dmar_insert_one_dev_info() implementation looks messy.
This refactors it by moving pasid table allocation to device probe
function, changing the return type to integer, adding the error
rewinding paths.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 117 +++++++++++++++++-------------------
 1 file changed, 54 insertions(+), 63 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7d2fec3041e4..9a9f21fd268a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2379,15 +2379,6 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 	__iommu_flush_dev_iotlb(info, 0, MAX_AGAW_PFN_WIDTH);
 }
 
-static inline void unlink_domain_info(struct device_domain_info *info)
-{
-	list_del_rcu(&info->link);
-	xa_erase(&device_domain_array,
-		 DEVI_IDX(info->segment, info->bus, info->devfn));
-	if (info->dev)
-		dev_iommu_priv_set(info->dev, NULL);
-}
-
 struct dmar_domain *find_domain(struct device *dev)
 {
 	struct device_domain_info *info;
@@ -2445,35 +2436,22 @@ static bool dev_is_real_dma_subdevice(struct device *dev)
 	       pci_real_dma_dev(to_pci_dev(dev)) != to_pci_dev(dev);
 }
 
-static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
-						    int bus, int devfn,
-						    struct device *dev,
-						    struct dmar_domain *domain)
+static int dmar_insert_one_dev_info(struct intel_iommu *iommu, int bus,
+				    int devfn, struct device *dev,
+				    struct dmar_domain *domain)
 {
 	struct device_domain_info *info = get_domain_info(dev);
 	unsigned long flags;
 	int ret;
 
 	spin_lock_irqsave(&iommu->lock, flags);
+	/* Link to iommu and get a domain id: */
 	ret = domain_attach_iommu(domain, iommu);
-	spin_unlock_irqrestore(&iommu->lock, flags);
 	if (ret)
-		return NULL;
-
-	info->domain = domain;
-	list_add_rcu(&info->link, &domain->devices);
-
-	/* PASID table is mandatory for a PCI device in scalable mode. */
-	if (dev && dev_is_pci(dev) && sm_supported(iommu)) {
-		ret = intel_pasid_alloc_table(dev);
-		if (ret) {
-			dev_err(dev, "PASID table allocation failed\n");
-			dmar_remove_one_dev_info(dev);
-			return NULL;
-		}
+		goto attach_iommu_err;
 
-		/* Setup the PASID entry for requests without PASID: */
-		spin_lock_irqsave(&iommu->lock, flags);
+	/* Setup the PASID entry for requests without PASID: */
+	if (dev_is_pci(dev) && sm_supported(iommu)) {
 		if (hw_pass_through && domain_type_is_si(domain))
 			ret = intel_pasid_setup_pass_through(iommu, domain,
 					dev, PASID_RID2PASID);
@@ -2483,21 +2461,31 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 		else
 			ret = intel_pasid_setup_second_level(iommu, domain,
 					dev, PASID_RID2PASID);
-		spin_unlock_irqrestore(&iommu->lock, flags);
-		if (ret) {
-			dev_err(dev, "Setup RID2PASID failed\n");
-			dmar_remove_one_dev_info(dev);
-			return NULL;
-		}
+		if (ret)
+			goto pasid_setup_err;
 	}
+	spin_unlock_irqrestore(&iommu->lock, flags);
 
-	if (dev && domain_context_mapping(domain, dev)) {
-		dev_err(dev, "Domain context map failed\n");
-		dmar_remove_one_dev_info(dev);
-		return NULL;
-	}
+	/* Setup the context entry for device: */
+	ret = domain_context_mapping(domain, dev);
+	if (ret)
+		goto setup_context_err;
 
-	return domain;
+	info->domain = domain;
+	list_add_rcu(&info->link, &domain->devices);
+
+	return 0;
+
+setup_context_err:
+	spin_lock_irqsave(&iommu->lock, flags);
+	if (dev_is_pci(dev) && sm_supported(iommu))
+		intel_pasid_tear_down_entry(iommu, dev, PASID_RID2PASID, false);
+pasid_setup_err:
+	domain_detach_iommu(domain, iommu);
+attach_iommu_err:
+	spin_unlock_irqrestore(&iommu->lock, flags);
+
+	return ret;
 }
 
 static int iommu_domain_identity_map(struct dmar_domain *domain,
@@ -2575,7 +2563,6 @@ static int __init si_domain_init(int hw)
 
 static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 {
-	struct dmar_domain *ndomain;
 	struct intel_iommu *iommu;
 	u8 bus, devfn;
 
@@ -2583,11 +2570,7 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 	if (!iommu)
 		return -ENODEV;
 
-	ndomain = dmar_insert_one_dev_info(iommu, bus, devfn, dev, domain);
-	if (ndomain != domain)
-		return -EBUSY;
-
-	return 0;
+	return dmar_insert_one_dev_info(iommu, bus, devfn, dev, domain);
 }
 
 static bool device_has_rmrr(struct device *dev)
@@ -4001,16 +3984,13 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 
 		iommu_disable_dev_iotlb(info);
 		domain_context_clear(info);
-		intel_pasid_free_table(info->dev);
 	}
 
-	unlink_domain_info(info);
+	list_del_rcu(&info->link);
 
 	spin_lock_irqsave(&iommu->lock, flags);
 	domain_detach_iommu(domain, iommu);
 	spin_unlock_irqrestore(&iommu->lock, flags);
-
-	kfree(info);
 }
 
 static void dmar_remove_one_dev_info(struct device *dev)
@@ -4310,8 +4290,10 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 	struct pci_dev *pdev = dev_is_pci(dev) ? to_pci_dev(dev) : NULL;
 	struct device_domain_info *info;
 	struct intel_iommu *iommu;
+	unsigned long index;
 	u8 bus, devfn;
 	void *curr;
+	int ret;
 
 	iommu = device_to_iommu(dev, &bus, &devfn);
 	if (!iommu)
@@ -4353,30 +4335,39 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 		}
 	}
 
-	curr = xa_store(&device_domain_array,
-			DEVI_IDX(info->segment, info->bus, info->devfn),
-			info, GFP_KERNEL);
+	index = DEVI_IDX(info->segment, info->bus, info->devfn);
+	curr = xa_store(&device_domain_array, index, info, GFP_KERNEL);
 	if (xa_err(curr) || WARN_ON(curr)) {
-		kfree(info);
-		return ERR_PTR(-ENOSPC);
+		ret = -ENOSPC;
+		goto free_out;
 	}
 
 	dev_iommu_priv_set(dev, info);
+	if (sm_supported(iommu)) {
+		ret = intel_pasid_alloc_table(dev);
+		if (ret)
+			goto cleanup_out;
+	}
 
 	return &iommu->iommu;
+
+cleanup_out:
+	dev_iommu_priv_set(dev, NULL);
+	xa_erase(&device_domain_array, index);
+free_out:
+	kfree(info);
+	return ERR_PTR(ret);
 }
 
 static void intel_iommu_release_device(struct device *dev)
 {
-	struct intel_iommu *iommu;
-
-	iommu = device_to_iommu(dev, NULL, NULL);
-	if (!iommu)
-		return;
-
-	dmar_remove_one_dev_info(dev);
+	struct device_domain_info *info = get_domain_info(dev);
+	unsigned long index = DEVI_IDX(info->segment, info->bus, info->devfn);
 
+	xa_erase(&device_domain_array, index);
+	dev_iommu_priv_set(info->dev, NULL);
 	set_dma_ops(dev, NULL);
+	kfree(info);
 }
 
 static void intel_iommu_probe_finalize(struct device *dev)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
