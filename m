Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B07C43334
	for <iommu@archiver.kernel.org>; Wed, 29 Jun 2022 07:52:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C4945828AA;
	Wed, 29 Jun 2022 07:52:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C4945828AA
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I48EWSNG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vmpgUxSDOlOj; Wed, 29 Jun 2022 07:52:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6D83082F32;
	Wed, 29 Jun 2022 07:52:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6D83082F32
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 497E3C0039;
	Wed, 29 Jun 2022 07:52:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47047C002D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 07:52:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 138B4416CD
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 07:52:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 138B4416CD
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=I48EWSNG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FLd5nRnYD7FV for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 07:52:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CEDA4409C3
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CEDA4409C3
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 07:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656489135; x=1688025135;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yfKGiGqgBCGt3LELuF8+oSTbi0JzvMyYgIXr3AIdF+4=;
 b=I48EWSNGJGz3tloRvrw9KeQHh5xTFdl1p+dPMwF6nSKVHZJSLVKYyYY/
 aVoBODAGD/6c3kfUzh6w9URPOU0FAa7A6VbdJUkhWQWusSaxOp9j9B5xm
 1r2k0Vm4NXfwAtU1WleU8gH1lmbn66n0jvqcuArmfo5fJao6sc6ZIZ4Dm
 Ay+vjRD7k1JocRKc6+lo6+UnsuNgOZbmIpXQsXuWRHNvUIJphqKvQGWTC
 5S9xE0QkiZb5e4tHbzn7qm4/4M4lsyqUZley/ddZe8J1+4HAusif7Bar/
 0iJGAaFaZGmUOYa5o0JHxeRXs2pisLGvmoStKeMD9ltYIaN/EpzPTeeqJ A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="262362993"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; d="scan'208";a="262362993"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2022 00:52:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; d="scan'208";a="588209743"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by orsmga007.jf.intel.com with ESMTP; 29 Jun 2022 00:52:13 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux-foundation.org,
	iommu@lists.linux.dev
Subject: [PATCH v3 10/11] iommu/vt-d: Use device_domain_lock accurately
Date: Wed, 29 Jun 2022 15:47:24 +0800
Message-Id: <20220629074725.2331441-11-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629074725.2331441-1-baolu.lu@linux.intel.com>
References: <20220629074725.2331441-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, Jacob jun Pan <jacob.jun.pan@intel.com>
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
 drivers/iommu/intel/iommu.c | 61 ++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 38 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 3038aafecff9..1783859b511a 100644
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
@@ -1376,23 +1371,24 @@ static void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did,
 }
 
 static struct device_domain_info *
-iommu_support_dev_iotlb (struct dmar_domain *domain, struct intel_iommu *iommu,
-			 u8 bus, u8 devfn)
+iommu_support_dev_iotlb(struct dmar_domain *domain, struct intel_iommu *iommu,
+			u8 bus, u8 devfn)
 {
 	struct device_domain_info *info;
-
-	assert_spin_locked(&device_domain_lock);
+	unsigned long flags;
 
 	if (!iommu->qi)
 		return NULL;
 
-	list_for_each_entry(info, &domain->devices, link)
+	spin_lock_irqsave(&device_domain_lock, flags);
+	list_for_each_entry(info, &domain->devices, link) {
 		if (info->iommu == iommu && info->bus == bus &&
 		    info->devfn == devfn) {
-			if (info->ats_supported && info->dev)
-				return info;
-			break;
+			spin_unlock_irqrestore(&device_domain_lock, flags);
+			return info->ats_supported ? info : NULL;
 		}
+	}
+	spin_unlock_irqrestore(&device_domain_lock, flags);
 
 	return NULL;
 }
@@ -1401,24 +1397,23 @@ static void domain_update_iotlb(struct dmar_domain *domain)
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
 
@@ -1464,8 +1459,6 @@ static void iommu_disable_dev_iotlb(struct device_domain_info *info)
 {
 	struct pci_dev *pdev;
 
-	assert_spin_locked(&device_domain_lock);
-
 	if (!dev_is_pci(info->dev))
 		return;
 
@@ -1908,11 +1901,11 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
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
@@ -1925,7 +1918,6 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 
 	BUG_ON(!domain->pgd);
 
-	spin_lock_irqsave(&device_domain_lock, flags);
 	spin_lock(&iommu->lock);
 
 	ret = -ENOMEM;
@@ -1978,7 +1970,6 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 		 * Setup the Device-TLB enable bit and Page request
 		 * Enable bit:
 		 */
-		info = iommu_support_dev_iotlb(domain, iommu, bus, devfn);
 		if (info && info->ats_supported)
 			context_set_sm_dte(context);
 		if (info && info->pri_supported)
@@ -2001,7 +1992,6 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 					goto out_unlock;
 			}
 
-			info = iommu_support_dev_iotlb(domain, iommu, bus, devfn);
 			if (info && info->ats_supported)
 				translation = CONTEXT_TT_DEV_IOTLB;
 			else
@@ -2047,7 +2037,6 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 
 out_unlock:
 	spin_unlock(&iommu->lock);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
 
 	return ret;
 }
@@ -2460,13 +2449,12 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
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
+	info->domain = domain;
+	spin_lock_irqsave(&device_domain_lock, flags);
 	list_add(&info->link, &domain->devices);
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 
@@ -4636,7 +4624,6 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev)
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct context_entry *context;
 	struct dmar_domain *domain;
-	unsigned long flags;
 	u64 ctx_lo;
 	int ret;
 
@@ -4644,7 +4631,6 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev)
 	if (!domain)
 		return -EINVAL;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
 	spin_lock(&iommu->lock);
 
 	ret = -EINVAL;
@@ -4676,7 +4662,6 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev)
 
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
