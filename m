Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EAD4C433F5
	for <iommu@archiver.kernel.org>; Mon,  7 Feb 2022 06:43:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4730A40240;
	Mon,  7 Feb 2022 06:43:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dZw6zVOHMePU; Mon,  7 Feb 2022 06:43:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B020A40272;
	Mon,  7 Feb 2022 06:43:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 899AAC0011;
	Mon,  7 Feb 2022 06:43:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A0AFC000B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 06:43:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 07DDA600C5
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 06:43:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pGjrAc_gi4jX for <iommu@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 06:43:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 542AA60767
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 06:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644216202; x=1675752202;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/1FAEc7MxY57hsQjIIjJSXw/pIhYqbkltVpu9dLzdic=;
 b=ly6vyYTolQv/XXxOYw82CemChLHLPu7PuMwfSNygCjgy3w7ILHP8mMhe
 +jkO12BZmKciSeMJZbY3lA4jDlu7ZYU07HHE88Tj30vYNpVGhpNiCF+K4
 NfpB7kJfbz11MFNfvK0eov8YioZbDRAC119ezECUt6Ti9+4qHP9nYKrIM
 eIcE+/PHHaG1Ad+fHICkTi1BcG5BlV6sOzdsBmsCI4yGB/ywCQtTPtmsK
 y8bAUWqaiFmpPGhNYZWtU8fDBo2RzvO4R5Scj7bwcfRIGuB2sU2O7pl/A
 id7dFve2WQqJxBJe2rbQ2bvVdsamcTasNT9ksQ26Q/upyHpOAvdH0ZbQf w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="228622976"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; d="scan'208";a="228622976"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2022 22:43:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; d="scan'208";a="525020303"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 06 Feb 2022 22:43:18 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v1 07/10] iommu/vt-d: Use an xarray for global
 device_domain_info
Date: Mon,  7 Feb 2022 14:41:39 +0800
Message-Id: <20220207064142.1092846-8-baolu.lu@linux.intel.com>
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

Replace the existing global device_domain_list with an array so that it
could be easily searched. The index of the array is composed by the PCI
segment, bus and devfn. And use RCU lock for protection.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/intel-iommu.h |  1 -
 drivers/iommu/intel/iommu.c | 68 ++++++++++++++++---------------------
 2 files changed, 30 insertions(+), 39 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 8c7591b5f3e2..1ccba739a062 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -610,7 +610,6 @@ struct intel_iommu {
 /* PCI domain-device relationship */
 struct device_domain_info {
 	struct list_head link;	/* link to domain siblings */
-	struct list_head global; /* link to global list */
 	struct list_head table;	/* link to pasid table */
 	u32 segment;		/* PCI segment number */
 	u8 bus;			/* PCI bus number */
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 165c890b8304..d7eba86c7f72 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -151,8 +151,6 @@ static struct intel_iommu **g_iommus;
 
 static void __init check_tylersburg_isoch(void);
 static int rwbf_quirk;
-static inline struct device_domain_info *
-dmar_search_domain_by_dev_info(int segment, int bus, int devfn);
 
 /*
  * set to 1 to panic kernel if can't successfully enable VT-d
@@ -315,30 +313,30 @@ struct device_domain_info *get_domain_info(struct device *dev)
 }
 
 DEFINE_SPINLOCK(device_domain_lock);
-static LIST_HEAD(device_domain_list);
+static DEFINE_XARRAY_ALLOC(device_domain_array);
+
+#define DEVI_IDX(seg, bus, devfn) ((((u16)(seg)) << 16) | PCI_DEVID(bus, devfn))
 
 /*
- * Iterate over elements in device_domain_list and call the specified
+ * Iterate over elements in device_domain_array and call the specified
  * callback @fn against each element.
  */
 int for_each_device_domain(int (*fn)(struct device_domain_info *info,
 				     void *data), void *data)
 {
-	int ret = 0;
-	unsigned long flags;
 	struct device_domain_info *info;
+	unsigned long index;
+	int ret = 0;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
-	list_for_each_entry(info, &device_domain_list, global) {
+	rcu_read_lock();
+	xa_for_each(&device_domain_array, index, info) {
 		ret = fn(info, data);
-		if (ret) {
-			spin_unlock_irqrestore(&device_domain_lock, flags);
-			return ret;
-		}
+		if (ret)
+			break;
 	}
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+	rcu_read_unlock();
 
-	return 0;
+	return ret;
 }
 
 const struct iommu_ops intel_iommu_ops;
@@ -900,7 +898,8 @@ static void pgtable_walk(struct intel_iommu *iommu, unsigned long pfn, u8 bus, u
 	struct dmar_domain *domain;
 	int offset, level;
 
-	info = dmar_search_domain_by_dev_info(iommu->segment, bus, devfn);
+	info = xa_load(&device_domain_array,
+		       DEVI_IDX(iommu->segment, bus, devfn));
 	if (!info || !info->domain) {
 		pr_info("device [%02x:%02x.%d] not probed\n",
 			bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
@@ -1747,14 +1746,14 @@ static int iommu_init_domains(struct intel_iommu *iommu)
 
 static void disable_dmar_iommu(struct intel_iommu *iommu)
 {
-	struct device_domain_info *info, *tmp;
-	unsigned long flags;
+	struct device_domain_info *info;
+	unsigned long index;
 
 	if (!iommu->domain_ids)
 		return;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
-	list_for_each_entry_safe(info, tmp, &device_domain_list, global) {
+	rcu_read_lock();
+	xa_for_each(&device_domain_array, index, info) {
 		if (info->iommu != iommu)
 			continue;
 
@@ -1763,7 +1762,7 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
 
 		__dmar_remove_one_dev_info(info);
 	}
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+	rcu_read_unlock();
 
 	if (iommu->gcmd & DMA_GCMD_TE)
 		iommu_disable_translation(iommu);
@@ -2388,7 +2387,8 @@ static inline void unlink_domain_info(struct device_domain_info *info)
 {
 	assert_spin_locked(&device_domain_lock);
 	list_del(&info->link);
-	list_del(&info->global);
+	xa_erase(&device_domain_array,
+		 DEVI_IDX(info->segment, info->bus, info->devfn));
 	if (info->dev)
 		dev_iommu_priv_set(info->dev, NULL);
 }
@@ -2419,19 +2419,6 @@ struct dmar_domain *find_domain(struct device *dev)
 	return NULL;
 }
 
-static inline struct device_domain_info *
-dmar_search_domain_by_dev_info(int segment, int bus, int devfn)
-{
-	struct device_domain_info *info;
-
-	list_for_each_entry(info, &device_domain_list, global)
-		if (info->segment == segment && info->bus == bus &&
-		    info->devfn == devfn)
-			return info;
-
-	return NULL;
-}
-
 static int domain_setup_first_level(struct intel_iommu *iommu,
 				    struct dmar_domain *domain,
 				    struct device *dev,
@@ -4344,8 +4331,8 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 	struct pci_dev *pdev = dev_is_pci(dev) ? to_pci_dev(dev) : NULL;
 	struct device_domain_info *info;
 	struct intel_iommu *iommu;
-	unsigned long flags;
 	u8 bus, devfn;
+	void *curr;
 
 	iommu = device_to_iommu(dev, &bus, &devfn);
 	if (!iommu)
@@ -4387,10 +4374,15 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 		}
 	}
 
-	spin_lock_irqsave(&device_domain_lock, flags);
-	list_add(&info->global, &device_domain_list);
+	curr = xa_store(&device_domain_array,
+			DEVI_IDX(info->segment, info->bus, info->devfn),
+			info, GFP_KERNEL);
+	if (xa_err(curr) || WARN_ON(curr)) {
+		kfree(info);
+		return ERR_PTR(-ENOSPC);
+	}
+
 	dev_iommu_priv_set(dev, info);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
 
 	return &iommu->iommu;
 }
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
