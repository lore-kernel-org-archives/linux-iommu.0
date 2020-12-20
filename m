Return-Path: <SRS0=TI1w=FX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_12_24,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B95C4361B
	for <iommu@archiver.kernel.org>; Sat, 19 Dec 2020 00:04:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E6A820780
	for <iommu@archiver.kernel.org>; Sat, 19 Dec 2020 00:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E6A820780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3352F2E368;
	Sat, 19 Dec 2020 00:04:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EV0-0dDUDShA; Sat, 19 Dec 2020 00:04:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id F0FFB2E36B;
	Sat, 19 Dec 2020 00:04:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DAFCFC1786;
	Sat, 19 Dec 2020 00:04:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9524C0893
 for <iommu@lists.linux-foundation.org>; Sat, 19 Dec 2020 00:04:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8EA8386BB1
 for <iommu@lists.linux-foundation.org>; Sat, 19 Dec 2020 00:04:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SUKz6eP6csXH for <iommu@lists.linux-foundation.org>;
 Sat, 19 Dec 2020 00:04:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 87D0486A78
 for <iommu@lists.linux-foundation.org>; Sat, 19 Dec 2020 00:04:17 +0000 (UTC)
IronPort-SDR: bmb+PhLKQnMME62L1/vsG4yxVmjLB/zqOOwQnafI6jQOTl1TB2GrTLNMKR5GDHw6QM6GYxKcQ/
 74ApGJ/kEmuA==
X-IronPort-AV: E=McAfee;i="6000,8403,9839"; a="239615746"
X-IronPort-AV: E=Sophos;i="5.78,431,1599548400"; d="scan'208";a="239615746"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2020 16:04:16 -0800
IronPort-SDR: dVCdYHE6WIctqa73ht3UFhEKeypgFsw1v+RiQjZkRTfBiGZmPoPESytsfA3l+YtSJL0+YSVWma
 6hrFDvHAib4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,431,1599548400"; d="scan'208";a="340801476"
Received: from yiliu-dev.bj.intel.com (HELO iov-dev.bj.intel.com)
 ([10.238.156.135])
 by fmsmga008.fm.intel.com with ESMTP; 18 Dec 2020 16:04:14 -0800
From: Liu Yi L <yi.l.liu@intel.com>
To: baolu.lu@linux.intel.com, jacob.jun.pan@intel.com, xin.zeng@intel.com,
 Kaijie.Guo@intel.com, will@kernel.org, joro@8bytes.org
Subject: [PATCH 3/3] iommu/vt-d: A fix to iommu_flush_dev_iotlb() for
 aux-domain
Date: Sun, 20 Dec 2020 08:03:52 +0800
Message-Id: <20201220000352.183523-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201220000352.183523-1-yi.l.liu@intel.com>
References: <20201220000352.183523-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Cc: kevin.tian@intel.com, jun.j.tian@intel.com,
 iommu@lists.linux-foundation.org, ashok.raj@intel.com
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

iommu_flush_dev_iotlb() is called to invalidate caches on device. It only
loops the devices which are full-attached to the domain. For sub-devices,
this is ineffective. This results in invalid caching entries left on the
device. Fix it by adding loop for subdevices as well. Also, update the
domain->has_iotlb_device for both device/subdevice attach/detach and
ATS enabling/disabling.

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 90 +++++++++++++++++++++++++++++--------
 1 file changed, 72 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4274b4acc325..d9b6037b72b1 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1437,6 +1437,10 @@ static void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did,
 			(unsigned long long)DMA_TLB_IAIG(val));
 }
 
+/**
+ * For a given bus/devfn, fetch its device_domain_info if it supports
+ * device tlb. Only needs to loop devices attached in normal manner.
+ */
 static struct device_domain_info *
 iommu_support_dev_iotlb (struct dmar_domain *domain, struct intel_iommu *iommu,
 			 u8 bus, u8 devfn)
@@ -1459,6 +1463,18 @@ iommu_support_dev_iotlb (struct dmar_domain *domain, struct intel_iommu *iommu,
 	return NULL;
 }
 
+static bool dev_iotlb_enabled(struct device *dev)
+{
+	struct pci_dev *pdev;
+
+	if (!dev || !dev_is_pci(dev))
+		return false;
+
+	pdev = to_pci_dev(dev);
+
+	return !!pdev->ats_enabled;
+}
+
 static void domain_update_iotlb(struct dmar_domain *domain)
 {
 	struct device_domain_info *info;
@@ -1467,21 +1483,37 @@ static void domain_update_iotlb(struct dmar_domain *domain)
 	assert_spin_locked(&device_domain_lock);
 
 	list_for_each_entry(info, &domain->devices, link) {
-		struct pci_dev *pdev;
-
-		if (!info->dev || !dev_is_pci(info->dev))
-			continue;
-
-		pdev = to_pci_dev(info->dev);
-		if (pdev->ats_enabled) {
+		if (dev_iotlb_enabled(info->dev)) {
 			has_iotlb_device = true;
 			break;
 		}
 	}
 
+	if (!has_iotlb_device) {
+		struct subdevice_domain_info *subinfo;
+
+		list_for_each_entry(subinfo, &domain->sub_devices, link_phys) {
+			if (dev_iotlb_enabled(subinfo->dev)) {
+				has_iotlb_device = true;
+				break;
+			}
+		}
+	}
 	domain->has_iotlb_device = has_iotlb_device;
 }
 
+static void dev_update_domain_iotlb(struct device_domain_info *info)
+{
+	struct subdevice_domain_info *subinfo;
+
+	assert_spin_locked(&device_domain_lock);
+
+	domain_update_iotlb(info->domain);
+
+	list_for_each_entry(subinfo, &info->auxiliary_domains, link_domain)
+		domain_update_iotlb(subinfo->domain);
+}
+
 static void iommu_enable_dev_iotlb(struct device_domain_info *info)
 {
 	struct pci_dev *pdev;
@@ -1524,7 +1556,7 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
 	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
 	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
 		info->ats_enabled = 1;
-		domain_update_iotlb(info->domain);
+		dev_update_domain_iotlb(info);
 		info->ats_qdep = pci_ats_queue_depth(pdev);
 	}
 }
@@ -1543,7 +1575,7 @@ static void iommu_disable_dev_iotlb(struct device_domain_info *info)
 	if (info->ats_enabled) {
 		pci_disable_ats(pdev);
 		info->ats_enabled = 0;
-		domain_update_iotlb(info->domain);
+		dev_update_domain_iotlb(info);
 	}
 #ifdef CONFIG_INTEL_IOMMU_SVM
 	if (info->pri_enabled) {
@@ -1557,26 +1589,43 @@ static void iommu_disable_dev_iotlb(struct device_domain_info *info)
 #endif
 }
 
+static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
+				    u64 addr, unsigned mask)
+{
+	u16 sid, qdep;
+
+	if (!info || !info->ats_enabled)
+		return;
+
+	sid = info->bus << 8 | info->devfn;
+	qdep = info->ats_qdep;
+	qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
+			   qdep, addr, mask);
+}
+
 static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 				  u64 addr, unsigned mask)
 {
-	u16 sid, qdep;
 	unsigned long flags;
 	struct device_domain_info *info;
+	struct subdevice_domain_info *subinfo;
 
 	if (!domain->has_iotlb_device)
 		return;
 
 	spin_lock_irqsave(&device_domain_lock, flags);
-	list_for_each_entry(info, &domain->devices, link) {
-		if (!info->ats_enabled)
-			continue;
+	list_for_each_entry(info, &domain->devices, link)
+		__iommu_flush_dev_iotlb(info, addr, mask);
+
+	/*
+	 * Besides looping all devices attached normally, also
+	 * needs to loop all devices attached via auxiliary
+	 * manner.
+	 */
+	list_for_each_entry(subinfo, &domain->sub_devices, link_phys)
+		__iommu_flush_dev_iotlb(get_domain_info(subinfo->dev),
+					addr, mask);
 
-		sid = info->bus << 8 | info->devfn;
-		qdep = info->ats_qdep;
-		qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
-				qdep, addr, mask);
-	}
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 }
 
@@ -5208,6 +5257,9 @@ static void auxiliary_link_device(struct dmar_domain *domain,
 	subinfo->dev = dev;
 	list_add(&subinfo->link_domain, &info->auxiliary_domains);
 	list_add(&subinfo->link_phys, &domain->sub_devices);
+	if (dev_iotlb_enabled(dev))
+		domain_update_iotlb(domain);
+
 	_auxiliary_link_device(domain, subinfo, dev);
 	domain->auxd_refcnt++;
 }
@@ -5242,6 +5294,8 @@ static int auxiliary_unlink_device(struct dmar_domain *domain,
 		list_del(&subinfo->link_domain);
 		list_del(&subinfo->link_phys);
 		kfree(subinfo);
+		if (domain->has_iotlb_device)
+			domain_update_iotlb(domain);
 	}
 	domain->auxd_refcnt--;
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
