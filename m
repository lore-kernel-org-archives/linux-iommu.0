Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8611C433F5
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 07:24:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5623561042
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 07:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5623561042
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D852340323;
	Wed, 29 Sep 2021 07:24:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QSf_i8-TnA7Q; Wed, 29 Sep 2021 07:24:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7775B402EF;
	Wed, 29 Sep 2021 07:24:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E985C0011;
	Wed, 29 Sep 2021 07:24:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36CCFC000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 07:24:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1319460663
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 07:24:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s6XbE5N_uxO7 for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 07:24:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2058C60656
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 07:24:10 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="285894381"
X-IronPort-AV: E=Sophos;i="5.85,331,1624345200"; d="scan'208";a="285894381"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2021 00:24:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,331,1624345200"; d="scan'208";a="476553453"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 29 Sep 2021 00:24:07 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/1] iommu/vt-d: Delete dev_has_feat callback
Date: Wed, 29 Sep 2021 15:20:30 +0800
Message-Id: <20210929072030.1330225-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org
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

The commit 262948f8ba573 ("iommu: Delete iommu_dev_has_feature()") has
deleted the iommu_dev_has_feature() interface. Remove the dev_has_feat
callback to avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 59 ++++---------------------------------
 1 file changed, 5 insertions(+), 54 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 01162b0b9712..dc733de9eea5 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5516,62 +5516,14 @@ static int intel_iommu_disable_sva(struct device *dev)
 	return ret;
 }
 
-/*
- * A PCI express designated vendor specific extended capability is defined
- * in the section 3.7 of Intel scalable I/O virtualization technical spec
- * for system software and tools to detect endpoint devices supporting the
- * Intel scalable IO virtualization without host driver dependency.
- *
- * Returns the address of the matching extended capability structure within
- * the device's PCI configuration space or 0 if the device does not support
- * it.
- */
-static int siov_find_pci_dvsec(struct pci_dev *pdev)
-{
-	int pos;
-	u16 vendor, id;
-
-	pos = pci_find_next_ext_capability(pdev, 0, 0x23);
-	while (pos) {
-		pci_read_config_word(pdev, pos + 4, &vendor);
-		pci_read_config_word(pdev, pos + 8, &id);
-		if (vendor == PCI_VENDOR_ID_INTEL && id == 5)
-			return pos;
-
-		pos = pci_find_next_ext_capability(pdev, pos, 0x23);
-	}
-
-	return 0;
-}
-
-static bool
-intel_iommu_dev_has_feat(struct device *dev, enum iommu_dev_features feat)
+static int intel_iommu_enable_iopf(struct device *dev)
 {
 	struct device_domain_info *info = get_domain_info(dev);
 
-	if (feat == IOMMU_DEV_FEAT_AUX) {
-		int ret;
-
-		if (!dev_is_pci(dev) || dmar_disabled ||
-		    !scalable_mode_support() || !pasid_mode_support())
-			return false;
-
-		ret = pci_pasid_features(to_pci_dev(dev));
-		if (ret < 0)
-			return false;
-
-		return !!siov_find_pci_dvsec(to_pci_dev(dev));
-	}
-
-	if (feat == IOMMU_DEV_FEAT_IOPF)
-		return info && info->pri_supported;
-
-	if (feat == IOMMU_DEV_FEAT_SVA)
-		return info && (info->iommu->flags & VTD_FLAG_SVM_CAPABLE) &&
-			info->pasid_supported && info->pri_supported &&
-			info->ats_supported;
+	if (info && info->pri_supported)
+		return 0;
 
-	return false;
+	return -ENODEV;
 }
 
 static int
@@ -5582,7 +5534,7 @@ intel_iommu_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
 		return intel_iommu_enable_auxd(dev);
 
 	case IOMMU_DEV_FEAT_IOPF:
-		return intel_iommu_dev_has_feat(dev, feat) ? 0 : -ENODEV;
+		return intel_iommu_enable_iopf(dev);
 
 	case IOMMU_DEV_FEAT_SVA:
 		return intel_iommu_enable_sva(dev);
@@ -5708,7 +5660,6 @@ const struct iommu_ops intel_iommu_ops = {
 	.get_resv_regions	= intel_iommu_get_resv_regions,
 	.put_resv_regions	= generic_iommu_put_resv_regions,
 	.device_group		= intel_iommu_device_group,
-	.dev_has_feat		= intel_iommu_dev_has_feat,
 	.dev_feat_enabled	= intel_iommu_dev_feat_enabled,
 	.dev_enable_feat	= intel_iommu_dev_enable_feat,
 	.dev_disable_feat	= intel_iommu_dev_disable_feat,
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
