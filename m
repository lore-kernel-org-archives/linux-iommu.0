Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D16C433EF
	for <iommu@archiver.kernel.org>; Sun, 10 Apr 2022 10:27:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C3C86417E7;
	Sun, 10 Apr 2022 10:27:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Oe-6SWIEKLjA; Sun, 10 Apr 2022 10:27:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7A706417C6;
	Sun, 10 Apr 2022 10:27:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F2E2C0084;
	Sun, 10 Apr 2022 10:27:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E721C0088
 for <iommu@lists.linux-foundation.org>; Sun, 10 Apr 2022 10:27:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2008541760
 for <iommu@lists.linux-foundation.org>; Sun, 10 Apr 2022 10:27:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FlsUUU70tZvC for <iommu@lists.linux-foundation.org>;
 Sun, 10 Apr 2022 10:27:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3F4B44175D
 for <iommu@lists.linux-foundation.org>; Sun, 10 Apr 2022 10:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649586433; x=1681122433;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BKIzNNGqmV4foEUQe34V+LL7z7rFtTEgFa1bQg+vi/E=;
 b=LMV6kNqZIGhuuCW98286fhZFBaNjos5KAZx25DqfsDwxuEJXIlqLPRAx
 Ipy8o2/XFwRB1pOsbhWeo7uDQHQo7I83Zckdc5IZ1Ux3KZjFlMxt753pR
 Xh8HC4xbwv7ly6teeS0zg4clJffKwx2dIMofnFTrdunQVc9Z3IWPuh3vH
 4W0EWbhvCuDS2DipcZ6jTQET8Fvnc5ZXwu/p9wpZcRqXnhbHFYdhGCnFm
 uwE5T1R+Lvs3GilVz8dbkXhK33hCqTi/o2NpQkAwZG18btM2siy6XIJBE
 3zdo/S8rHt3pjIxgUcCWazf06u2zQBRGb0qukvmb+GenprgFzZGBuFXg4 w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10312"; a="249238446"
X-IronPort-AV: E=Sophos;i="5.90,249,1643702400"; d="scan'208";a="249238446"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2022 03:27:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,249,1643702400"; d="scan'208";a="699019585"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 10 Apr 2022 03:27:09 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH RFC v3 01/12] iommu: Add pasid_bits field in struct dev_iommu
Date: Sun, 10 Apr 2022 18:24:32 +0800
Message-Id: <20220410102443.294128-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220410102443.294128-1-baolu.lu@linux.intel.com>
References: <20220410102443.294128-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>
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

Use this field to save the pasid/ssid bits that a device is able to
support with its IOMMU hardware. It is a generic attribute of a device
and lifting it into the per-device dev_iommu struct makes it possible
to allocate a PASID for device without calls into the IOMMU drivers.
Any iommu driver which suports PASID related features should set this
field before features are enabled on the devices.

For initialization of this field in the VT-d driver, the
info->pasid_supported is only set for PCI devices. So the status is
that non-PCI SVA hasn't been supported yet. Setting this field only for
PCI devices has no functional change.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h                       | 1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 ++
 drivers/iommu/intel/iommu.c                 | 5 ++++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 6ef2df258673..36f43af0af53 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -368,6 +368,7 @@ struct dev_iommu {
 	struct iommu_fwspec		*fwspec;
 	struct iommu_device		*iommu_dev;
 	void				*priv;
+	unsigned int			pasid_bits;
 };
 
 int iommu_device_register(struct iommu_device *iommu,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 627a3ed5ee8f..afc63fce6107 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2681,6 +2681,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 	    smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
 		master->stall_enabled = true;
 
+	dev->iommu->pasid_bits = master->ssid_bits;
+
 	return &smmu->iommu;
 
 err_free_master:
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index df5c62ecf942..ffad7f8f2d73 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4593,8 +4593,11 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 			if (pasid_supported(iommu)) {
 				int features = pci_pasid_features(pdev);
 
-				if (features >= 0)
+				if (features >= 0) {
 					info->pasid_supported = features | 1;
+					dev->iommu->pasid_bits =
+						fls(pci_max_pasids(pdev)) - 1;
+				}
 			}
 
 			if (info->ats_supported && ecap_prs(iommu->ecap) &&
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
