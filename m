Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF39C433FE
	for <iommu@archiver.kernel.org>; Fri, 27 May 2022 06:34:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F4924261F;
	Fri, 27 May 2022 06:34:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eyuegJBLtLd2; Fri, 27 May 2022 06:34:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7CF9942617;
	Fri, 27 May 2022 06:34:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55B39C0032;
	Fri, 27 May 2022 06:34:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0D4BC002D
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 06:34:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 91F10404FD
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 06:34:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ch-xeuyRYCE6 for <iommu@lists.linux-foundation.org>;
 Fri, 27 May 2022 06:34:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C711E412E2
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 06:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653633271; x=1685169271;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ayGOLvUJ2hmU1CL/db1tdoLlaoeUGWq/xeKiGG3RMD0=;
 b=neLgDginWMGiSfxbZpwhweD3BLKRLjQJML0rZnEBBS1OGEVRvwTLfWjF
 95pf+yuf/brEzrj3hBUu9wENEr9aeWBaP8wgJ1rv+nezyYrejL6GrJx7U
 kUi05h+cW/avLK3kPfwQr8xss68EK7NzNbEs3BJdvndwy5Xx6nVzlCt7m
 7eEz9h67GiImydTcN1rfVIcLNNVPn1ACvhE+BcPh73LvmI8lAnMeg9Kny
 zafc5vlEfLS8lYXE5lowmJDo9VEDIFd/Ov7bOjvyjIgb6usZfouBrskXX
 4Vzq/gAvhtbmwnFaNiay439/n4c02P5SzqMRjaT+XMZlJa5N5NTmbH1O2 A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="274123394"
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; d="scan'208";a="274123394"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2022 23:34:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; d="scan'208";a="718689038"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 26 May 2022 23:34:28 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 11/12] iommu/vt-d: Use device_domain_lock accurately
Date: Fri, 27 May 2022 14:30:18 +0800
Message-Id: <20220527063019.3112905-12-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Robin Murphy <robin.murphy@arm.com>
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

The device_domain_lock is used to protect the device tracking list of
a domain. Remove unnecessary spin_lock/unlock()'s and move the necessary
ones around the list access.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 68 +++++++++++++++----------------------
 1 file changed, 27 insertions(+), 41 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d02ddd338afd..f8aa8649dc6f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -534,16 +534,10 @@ static int domain_update_device_node(struct dmar_domain *domain)
 {
 	struct device_domain_info *info;
 	int nid = NUMA_NO_NODE;
+	unsigned long flags;
 
-	assert_spin_locked(&device_domain_lock);
-
-	if (list_empty(&domain->devices))
-		return NUMA_NO_NODE;
-
+	spin_lock_irqsave(&device_domain_lock, flags);
 	list_for_each_entry(info, &domain->devices, link) {
-		if (!info->dev)
-			continue;
-
 		/*
 		 * There could possibly be multiple device numa nodes as devices
 		 * within the same domain may sit behind different IOMMUs. There
@@ -554,6 +548,7 @@ static int domain_update_device_node(struct dmar_domain *domain)
 		if (nid != NUMA_NO_NODE)
 			break;
 	}
+	spin_unlock_irqrestore(&device_domain_lock, flags);
 
 	return nid;
 }
@@ -1376,49 +1371,50 @@ static void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did,
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
+	struct device_domain_info *info = NULL, *tmp;
+	unsigned long flags;
 
 	if (!iommu->qi)
 		return NULL;
 
-	list_for_each_entry(info, &domain->devices, link)
-		if (info->iommu == iommu && info->bus == bus &&
-		    info->devfn == devfn) {
-			if (info->ats_supported && info->dev)
-				return info;
+	spin_lock_irqsave(&device_domain_lock, flags);
+	list_for_each_entry(tmp, &domain->devices, link) {
+		if (tmp->iommu == iommu && tmp->bus == bus &&
+		    tmp->devfn == devfn) {
+			if (tmp->ats_supported)
+				info = tmp;
 			break;
 		}
+	}
+	spin_unlock_irqrestore(&device_domain_lock, flags);
 
-	return NULL;
+	return info;
 }
 
 static void domain_update_iotlb(struct dmar_domain *domain)
 {
 	struct device_domain_info *info;
 	bool has_iotlb_device = false;
+	unsigned long flags;
 
-	assert_spin_locked(&device_domain_lock);
-
-	list_for_each_entry(info, &domain->devices, link)
+	spin_lock_irqsave(&device_domain_lock, flags);
+	list_for_each_entry(info, &domain->devices, link) {
 		if (info->ats_enabled) {
 			has_iotlb_device = true;
 			break;
 		}
-
+	}
 	domain->has_iotlb_device = has_iotlb_device;
+	spin_unlock_irqrestore(&device_domain_lock, flags);
 }
 
 static void iommu_enable_dev_iotlb(struct device_domain_info *info)
 {
 	struct pci_dev *pdev;
 
-	assert_spin_locked(&device_domain_lock);
-
 	if (!info || !dev_is_pci(info->dev))
 		return;
 
@@ -1464,8 +1460,6 @@ static void iommu_disable_dev_iotlb(struct device_domain_info *info)
 {
 	struct pci_dev *pdev;
 
-	assert_spin_locked(&device_domain_lock);
-
 	if (!dev_is_pci(info->dev))
 		return;
 
@@ -1900,11 +1894,11 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 				      struct pasid_table *table,
 				      u8 bus, u8 devfn)
 {
+	struct device_domain_info *info =
+			iommu_support_dev_iotlb(domain, iommu, bus, devfn);
 	u16 did = domain->iommu_did[iommu->seq_id];
 	int translation = CONTEXT_TT_MULTI_LEVEL;
-	struct device_domain_info *info = NULL;
 	struct context_entry *context;
-	unsigned long flags;
 	int ret;
 
 	WARN_ON(did == 0);
@@ -1917,7 +1911,6 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 
 	BUG_ON(!domain->pgd);
 
-	spin_lock_irqsave(&device_domain_lock, flags);
 	spin_lock(&iommu->lock);
 
 	ret = -ENOMEM;
@@ -1970,7 +1963,6 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 		 * Setup the Device-TLB enable bit and Page request
 		 * Enable bit:
 		 */
-		info = iommu_support_dev_iotlb(domain, iommu, bus, devfn);
 		if (info && info->ats_supported)
 			context_set_sm_dte(context);
 		if (info && info->pri_supported)
@@ -1993,7 +1985,6 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 					goto out_unlock;
 			}
 
-			info = iommu_support_dev_iotlb(domain, iommu, bus, devfn);
 			if (info && info->ats_supported)
 				translation = CONTEXT_TT_DEV_IOTLB;
 			else
@@ -2039,7 +2030,6 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 
 out_unlock:
 	spin_unlock(&iommu->lock);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
 
 	return ret;
 }
@@ -2452,15 +2442,14 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 	if (!iommu)
 		return -ENODEV;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
-	info->domain = domain;
 	ret = domain_attach_iommu(domain, iommu);
-	if (ret) {
-		spin_unlock_irqrestore(&device_domain_lock, flags);
+	if (ret)
 		return ret;
-	}
+
+	spin_lock_irqsave(&device_domain_lock, flags);
 	list_add(&info->link, &domain->devices);
 	spin_unlock_irqrestore(&device_domain_lock, flags);
+	info->domain = domain;
 
 	/* PASID table is mandatory for a PCI device in scalable mode. */
 	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
@@ -4629,7 +4618,6 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev)
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct context_entry *context;
 	struct dmar_domain *domain;
-	unsigned long flags;
 	u64 ctx_lo;
 	int ret;
 
@@ -4637,7 +4625,6 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev)
 	if (!domain)
 		return -EINVAL;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
 	spin_lock(&iommu->lock);
 
 	ret = -EINVAL;
@@ -4669,7 +4656,6 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev)
 
  out:
 	spin_unlock(&iommu->lock);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
 
 	return ret;
 }
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
