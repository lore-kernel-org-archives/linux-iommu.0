Return-Path: <SRS0=5yIV=F3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB45C433DB
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 06:27:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C87CB20759
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 06:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87CB20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5D69885DD1;
	Wed, 23 Dec 2020 06:27:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ukAylNqalC61; Wed, 23 Dec 2020 06:27:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CF0F385D90;
	Wed, 23 Dec 2020 06:27:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7ED8C1825;
	Wed, 23 Dec 2020 06:27:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0BEAAC0893
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 06:27:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0814D85DCA
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 06:27:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id idQRDIFE57pN for <iommu@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 06:27:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7A95785D97
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 06:27:54 +0000 (UTC)
IronPort-SDR: O9QjeqB28WbQYnCw6acTe00PzCDBduvsWshMpNAcBS9iFZh6c7hE6kZzMSwvvl6jdFE61SwtRt
 iMcOvHyZofrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9843"; a="155760414"
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; d="scan'208";a="155760414"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2020 22:27:54 -0800
IronPort-SDR: WGXaI/Dk3DFMjRBTzmi2/8NIjS+mFn1z99YVnXDdvJcFSlM+Gq74zincqzLtuogdoWnXZhSly8
 tdAfLj/x+yyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; d="scan'208";a="338703599"
Received: from yiliu-dev.bj.intel.com (HELO iov-dev.bj.intel.com)
 ([10.238.156.135])
 by fmsmga007.fm.intel.com with ESMTP; 22 Dec 2020 22:27:50 -0800
From: Liu Yi L <yi.l.liu@intel.com>
To: baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org,
 jacob.jun.pan@linux.intel.com
Subject: [PATCH v2 3/3] iommu/vt-d: Fix ineffective devTLB invalidation for
 subdevices
Date: Wed, 23 Dec 2020 14:27:20 +0800
Message-Id: <20201223062720.29364-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201223062720.29364-1-yi.l.liu@intel.com>
References: <20201223062720.29364-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Cc: kevin.tian@intel.com, ashok.raj@intel.com, jun.j.tian@intel.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 yi.y.sun@intel.com
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
device. Fix it by adding loop for subdevices as well. Also, the domain->
has_iotlb_device needs to be updated when attaching to subdevices.

Fixes: 67b8e02b5e761 ("iommu/vt-d: Aux-domain specific domain attach/detach")
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 63 +++++++++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index acfe0a5b955e..e97c5ac1d7fc 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -726,6 +726,8 @@ static int domain_update_device_node(struct dmar_domain *domain)
 	return nid;
 }
 
+static void domain_update_iotlb(struct dmar_domain *domain);
+
 /* Some capabilities may be different across iommus */
 static void domain_update_iommu_cap(struct dmar_domain *domain)
 {
@@ -739,6 +741,8 @@ static void domain_update_iommu_cap(struct dmar_domain *domain)
 	 */
 	if (domain->nid == NUMA_NO_NODE)
 		domain->nid = domain_update_device_node(domain);
+
+	domain_update_iotlb(domain);
 }
 
 struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
@@ -1459,6 +1463,18 @@ iommu_support_dev_iotlb (struct dmar_domain *domain, struct intel_iommu *iommu,
 	return NULL;
 }
 
+static bool dev_iotlb_enabled(struct device_domain_info *info)
+{
+	struct pci_dev *pdev;
+
+	if (!info->dev || !dev_is_pci(info->dev))
+		return false;
+
+	pdev = to_pci_dev(info->dev);
+
+	return !!pdev->ats_enabled;
+}
+
 static void domain_update_iotlb(struct dmar_domain *domain)
 {
 	struct device_domain_info *info;
@@ -1466,17 +1482,20 @@ static void domain_update_iotlb(struct dmar_domain *domain)
 
 	assert_spin_locked(&device_domain_lock);
 
-	list_for_each_entry(info, &domain->devices, link) {
-		struct pci_dev *pdev;
-
-		if (!info->dev || !dev_is_pci(info->dev))
-			continue;
-
-		pdev = to_pci_dev(info->dev);
-		if (pdev->ats_enabled) {
+	list_for_each_entry(info, &domain->devices, link)
+		if (dev_iotlb_enabled(info)) {
 			has_iotlb_device = true;
 			break;
 		}
+
+	if (!has_iotlb_device) {
+		struct subdev_domain_info *sinfo;
+
+		list_for_each_entry(sinfo, &domain->subdevices, link_domain)
+			if (dev_iotlb_enabled(get_domain_info(sinfo->pdev))) {
+				has_iotlb_device = true;
+				break;
+			}
 	}
 
 	domain->has_iotlb_device = has_iotlb_device;
@@ -1557,25 +1576,37 @@ static void iommu_disable_dev_iotlb(struct device_domain_info *info)
 #endif
 }
 
+static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
+				    u64 addr, unsigned int mask)
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
+	struct subdev_domain_info *sinfo;
 
 	if (!domain->has_iotlb_device)
 		return;
 
 	spin_lock_irqsave(&device_domain_lock, flags);
-	list_for_each_entry(info, &domain->devices, link) {
-		if (!info->ats_enabled)
-			continue;
+	list_for_each_entry(info, &domain->devices, link)
+		__iommu_flush_dev_iotlb(info, addr, mask);
 
-		sid = info->bus << 8 | info->devfn;
-		qdep = info->ats_qdep;
-		qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
-				qdep, addr, mask);
+	list_for_each_entry(sinfo, &domain->subdevices, link_domain) {
+		__iommu_flush_dev_iotlb(get_domain_info(sinfo->pdev),
+					addr, mask);
 	}
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 }
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
