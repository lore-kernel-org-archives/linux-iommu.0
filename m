Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF72C433EF
	for <iommu@archiver.kernel.org>; Mon,  7 Feb 2022 06:43:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9609C400E5;
	Mon,  7 Feb 2022 06:43:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PWNqkskOtbi5; Mon,  7 Feb 2022 06:43:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D675140272;
	Mon,  7 Feb 2022 06:43:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1874C0011;
	Mon,  7 Feb 2022 06:43:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49643C000B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 06:43:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2A8E060B97
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 06:43:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Nj1B5DOWaYDA for <iommu@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 06:43:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3DC9A60625
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 06:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644216205; x=1675752205;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lJxwiEIQSk9dgfIPGnEA9tRvOUzFf2hlDhpa/mB/TOA=;
 b=cZiUqB1tXljrc2e12JKy+QOKaf1PiprJb8vCr7rFWA4RN60Tk9fanpiR
 UaaiidHh7lj2k39LEtyYUbKljCkbrYYlyYjJoqO16lwXRqv1k6E4sU8Gs
 aTyfeApZWkkn609y0D9n0R1j0JeHbDqlDHjMGcq2LsF7Vme71h1wQqTwH
 9YwOZALknq3K1Rpgz2dYZ7eY1G9ph8mhYWBHXTvCNyFvC5PRlbR6cRuUH
 2IpE5vZO7Ec5NC/uu9Z1uYRYSBg64wAeKqOggzwxrgzIpFdbnjiO+FT8U
 UZ89ALL0tsxVtigTgCf53hvgOOTOYC5yCEFByyaXQ/2s8hbSUqPB6WHTk A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="228622982"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; d="scan'208";a="228622982"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2022 22:43:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; d="scan'208";a="525020319"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 06 Feb 2022 22:43:21 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v1 08/10] iommu/vt-d: Use rculist for dmar_domain::devices
Date: Mon,  7 Feb 2022 14:41:40 +0800
Message-Id: <20220207064142.1092846-9-baolu.lu@linux.intel.com>
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

Use rculist for list of devices attached by a domain. And use the RCU
lock for read/write protection. As both the global device_domain array
and per-domain device_domain list are protected by RCU lock now, there
is no need to use the spinlock anymore. Cleanup device_domain_lock.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/intel-iommu.h   |   1 -
 drivers/iommu/intel/debugfs.c |   3 -
 drivers/iommu/intel/iommu.c   | 118 ++++++++++++++--------------------
 3 files changed, 47 insertions(+), 75 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 1ccba739a062..2091576b5989 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -480,7 +480,6 @@ enum {
 #define VTD_FLAG_SVM_CAPABLE		(1 << 2)
 
 extern int intel_iommu_sm;
-extern spinlock_t device_domain_lock;
 
 #define sm_supported(iommu)	(intel_iommu_sm && ecap_smts((iommu)->ecap))
 #define pasid_supported(iommu)	(sm_supported(iommu) &&			\
diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index db7a0ca73626..43137704f187 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -363,13 +363,10 @@ static int show_device_domain_translation(struct device *dev, void *data)
 
 static int domain_translation_struct_show(struct seq_file *m, void *unused)
 {
-	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
 	ret = bus_for_each_dev(&pci_bus_type, NULL, m,
 			       show_device_domain_translation);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
 
 	return ret;
 }
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d7eba86c7f72..7d2fec3041e4 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -282,7 +282,6 @@ static int hw_pass_through = 1;
 static int g_num_of_iommus;
 
 static void domain_exit(struct dmar_domain *domain);
-static void domain_remove_dev_info(struct dmar_domain *domain);
 static void dmar_remove_one_dev_info(struct device *dev);
 static void __dmar_remove_one_dev_info(struct device_domain_info *info);
 static int intel_iommu_attach_device(struct iommu_domain *domain,
@@ -312,7 +311,6 @@ struct device_domain_info *get_domain_info(struct device *dev)
 	return dev_iommu_priv_get(dev);
 }
 
-DEFINE_SPINLOCK(device_domain_lock);
 static DEFINE_XARRAY_ALLOC(device_domain_array);
 
 #define DEVI_IDX(seg, bus, devfn) ((((u16)(seg)) << 16) | PCI_DEVID(bus, devfn))
@@ -590,12 +588,11 @@ static int domain_update_device_node(struct dmar_domain *domain)
 	struct device_domain_info *info;
 	int nid = NUMA_NO_NODE;
 
-	assert_spin_locked(&device_domain_lock);
-
 	if (list_empty(&domain->devices))
 		return NUMA_NO_NODE;
 
-	list_for_each_entry(info, &domain->devices, link) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(info, &domain->devices, link) {
 		if (!info->dev)
 			continue;
 
@@ -609,6 +606,7 @@ static int domain_update_device_node(struct dmar_domain *domain)
 		if (nid != NUMA_NO_NODE)
 			break;
 	}
+	rcu_read_unlock();
 
 	return nid;
 }
@@ -1437,25 +1435,26 @@ static void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did,
 }
 
 static struct device_domain_info *
-iommu_support_dev_iotlb (struct dmar_domain *domain, struct intel_iommu *iommu,
-			 u8 bus, u8 devfn)
+iommu_support_dev_iotlb(struct dmar_domain *domain, struct intel_iommu *iommu,
+			u8 bus, u8 devfn)
 {
-	struct device_domain_info *info;
-
-	assert_spin_locked(&device_domain_lock);
+	struct device_domain_info *tmp, *info = NULL;
 
 	if (!iommu->qi)
 		return NULL;
 
-	list_for_each_entry(info, &domain->devices, link)
-		if (info->iommu == iommu && info->bus == bus &&
-		    info->devfn == devfn) {
-			if (info->ats_supported && info->dev)
-				return info;
+	rcu_read_lock();
+	list_for_each_entry_rcu(tmp, &domain->devices, link) {
+		if (tmp->iommu == iommu && tmp->bus == bus &&
+		    tmp->devfn == devfn) {
+			if (tmp->ats_supported && tmp->dev)
+				info = tmp;
 			break;
 		}
+	}
+	rcu_read_unlock();
 
-	return NULL;
+	return info;
 }
 
 static void domain_update_iotlb(struct dmar_domain *domain)
@@ -1463,13 +1462,14 @@ static void domain_update_iotlb(struct dmar_domain *domain)
 	struct device_domain_info *info;
 	bool has_iotlb_device = false;
 
-	assert_spin_locked(&device_domain_lock);
-
-	list_for_each_entry(info, &domain->devices, link)
+	rcu_read_lock();
+	list_for_each_entry_rcu(info, &domain->devices, link) {
 		if (info->ats_enabled) {
 			has_iotlb_device = true;
 			break;
 		}
+	}
+	rcu_read_unlock();
 
 	domain->has_iotlb_device = has_iotlb_device;
 }
@@ -1478,8 +1478,6 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
 {
 	struct pci_dev *pdev;
 
-	assert_spin_locked(&device_domain_lock);
-
 	if (!info || !dev_is_pci(info->dev))
 		return;
 
@@ -1525,8 +1523,6 @@ static void iommu_disable_dev_iotlb(struct device_domain_info *info)
 {
 	struct pci_dev *pdev;
 
-	assert_spin_locked(&device_domain_lock);
-
 	if (!dev_is_pci(info->dev))
 		return;
 
@@ -1566,17 +1562,15 @@ static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
 static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 				  u64 addr, unsigned mask)
 {
-	unsigned long flags;
 	struct device_domain_info *info;
 
 	if (!domain->has_iotlb_device)
 		return;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
-	list_for_each_entry(info, &domain->devices, link)
+	rcu_read_lock();
+	list_for_each_entry_rcu(info, &domain->devices, link)
 		__iommu_flush_dev_iotlb(info, addr, mask);
-
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+	rcu_read_unlock();
 }
 
 static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
@@ -1821,7 +1815,7 @@ static struct dmar_domain *alloc_domain(unsigned int type)
 	if (first_level_by_default(type))
 		domain->flags |= DOMAIN_FLAG_USE_FIRST_LEVEL;
 	domain->has_iotlb_device = false;
-	INIT_LIST_HEAD(&domain->devices);
+	INIT_LIST_HEAD_RCU(&domain->devices);
 
 	return domain;
 }
@@ -1833,7 +1827,6 @@ static int domain_attach_iommu(struct dmar_domain *domain,
 	unsigned long ndomains;
 	int num;
 
-	assert_spin_locked(&device_domain_lock);
 	assert_spin_locked(&iommu->lock);
 
 	domain->iommu_refcnt[iommu->seq_id] += 1;
@@ -1861,7 +1854,6 @@ static void domain_detach_iommu(struct dmar_domain *domain,
 {
 	int num;
 
-	assert_spin_locked(&device_domain_lock);
 	assert_spin_locked(&iommu->lock);
 
 	domain->iommu_refcnt[iommu->seq_id] -= 1;
@@ -1890,8 +1882,15 @@ static inline int guestwidth_to_adjustwidth(int gaw)
 static void domain_exit(struct dmar_domain *domain)
 {
 
-	/* Remove associated devices and clear attached or cached domains */
-	domain_remove_dev_info(domain);
+	struct device_domain_info *info, *tmp;
+
+	/*
+	 * Remove associated devices and clear attached or cached domains.
+	 * No worries about new devices insertion or removal. Hence no need
+	 * for a lock here.
+	 */
+	list_for_each_entry_safe(info, tmp, &domain->devices, link)
+		__dmar_remove_one_dev_info(info);
 
 	if (domain->pgd) {
 		LIST_HEAD(freelist);
@@ -1974,9 +1973,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 
 	BUG_ON(!domain->pgd);
 
-	spin_lock_irqsave(&device_domain_lock, flags);
-	spin_lock(&iommu->lock);
-
+	spin_lock_irqsave(&iommu->lock, flags);
 	ret = -ENOMEM;
 	context = iommu_context_addr(iommu, bus, devfn, 1);
 	if (!context)
@@ -2095,8 +2092,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	ret = 0;
 
 out_unlock:
-	spin_unlock(&iommu->lock);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+	spin_unlock_irqrestore(&iommu->lock, flags);
 
 	return ret;
 }
@@ -2385,25 +2381,13 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 
 static inline void unlink_domain_info(struct device_domain_info *info)
 {
-	assert_spin_locked(&device_domain_lock);
-	list_del(&info->link);
+	list_del_rcu(&info->link);
 	xa_erase(&device_domain_array,
 		 DEVI_IDX(info->segment, info->bus, info->devfn));
 	if (info->dev)
 		dev_iommu_priv_set(info->dev, NULL);
 }
 
-static void domain_remove_dev_info(struct dmar_domain *domain)
-{
-	struct device_domain_info *info, *tmp;
-	unsigned long flags;
-
-	spin_lock_irqsave(&device_domain_lock, flags);
-	list_for_each_entry_safe(info, tmp, &domain->devices, link)
-		__dmar_remove_one_dev_info(info);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
-}
-
 struct dmar_domain *find_domain(struct device *dev)
 {
 	struct device_domain_info *info;
@@ -2470,17 +2454,14 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
-	info->domain = domain;
-	spin_lock(&iommu->lock);
+	spin_lock_irqsave(&iommu->lock, flags);
 	ret = domain_attach_iommu(domain, iommu);
-	spin_unlock(&iommu->lock);
-	if (ret) {
-		spin_unlock_irqrestore(&device_domain_lock, flags);
+	spin_unlock_irqrestore(&iommu->lock, flags);
+	if (ret)
 		return NULL;
-	}
-	list_add(&info->link, &domain->devices);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+
+	info->domain = domain;
+	list_add_rcu(&info->link, &domain->devices);
 
 	/* PASID table is mandatory for a PCI device in scalable mode. */
 	if (dev && dev_is_pci(dev) && sm_supported(iommu)) {
@@ -4004,8 +3985,6 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 	struct intel_iommu *iommu;
 	unsigned long flags;
 
-	assert_spin_locked(&device_domain_lock);
-
 	if (WARN_ON(!info))
 		return;
 
@@ -4013,9 +3992,12 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 	domain = info->domain;
 
 	if (info->dev && !dev_is_real_dma_subdevice(info->dev)) {
-		if (dev_is_pci(info->dev) && sm_supported(iommu))
+		if (dev_is_pci(info->dev) && sm_supported(iommu)) {
+			spin_lock_irqsave(&iommu->lock, flags);
 			intel_pasid_tear_down_entry(iommu, info->dev,
 					PASID_RID2PASID, false);
+			spin_unlock_irqrestore(&iommu->lock, flags);
+		}
 
 		iommu_disable_dev_iotlb(info);
 		domain_context_clear(info);
@@ -4034,13 +4016,10 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 static void dmar_remove_one_dev_info(struct device *dev)
 {
 	struct device_domain_info *info;
-	unsigned long flags;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
 	info = get_domain_info(dev);
 	if (info)
 		__dmar_remove_one_dev_info(info);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
 }
 
 static int md_domain_init(struct dmar_domain *domain, int guest_width)
@@ -4476,9 +4455,7 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev)
 	if (!domain)
 		return -EINVAL;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
-	spin_lock(&iommu->lock);
-
+	spin_lock_irqsave(&iommu->lock, flags);
 	ret = -EINVAL;
 	info = get_domain_info(dev);
 	if (!info || !info->pasid_supported)
@@ -4508,8 +4485,7 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev)
 	ret = 0;
 
  out:
-	spin_unlock(&iommu->lock);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+	spin_unlock_irqrestore(&iommu->lock, flags);
 
 	return ret;
 }
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
