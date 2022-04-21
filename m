Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BDE1C433F5
	for <iommu@archiver.kernel.org>; Thu, 21 Apr 2022 05:24:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 41334405BA;
	Thu, 21 Apr 2022 05:24:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Df8d52Clpd9m; Thu, 21 Apr 2022 05:24:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 35ED940497;
	Thu, 21 Apr 2022 05:24:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1819FC002F;
	Thu, 21 Apr 2022 05:24:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2270C002C
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 05:24:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9ACDD4199F
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 05:24:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q-Qm0KdKru8T for <iommu@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 05:24:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B64AD41998
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 05:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650518654; x=1682054654;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BKIzNNGqmV4foEUQe34V+LL7z7rFtTEgFa1bQg+vi/E=;
 b=kE+UpfgQ3kT+NUwpnYnHbMGF17PUrFhncHn7gTlUdECfzTNwPMIEhWS2
 RuBpJY2bJdkRc3Ee+y7HVylzS5FZHMX7+wzdT2twxWIRaaKkQaysDWQOu
 mNj9jI67yaLxUlyrOqyOdX0nq02fyyd+7yAoZO764Yi8qSFxsU9e1+qAD
 jFFUNK77Ce5kIYTndrqtCDaYUD58U0u0ButUHgFoi+mWA3Xk4R1lCXsgF
 CKgAygo8o9TUIpZ6AHV1oK7fiisKL8ruvLCXkWrN6DCqNccdK62DEyDnm
 ZBiO3tPcXEYd0D3VrvtZxiTIxCjihZlvUuZXrQmVpsMV9Tx3MvVpEnNgq Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="244176669"
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; d="scan'208";a="244176669"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2022 22:24:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; d="scan'208";a="702944092"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 20 Apr 2022 22:24:11 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH v4 02/12] iommu: Add pasid_bits field in struct dev_iommu
Date: Thu, 21 Apr 2022 13:21:11 +0800
Message-Id: <20220421052121.3464100-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220421052121.3464100-1-baolu.lu@linux.intel.com>
References: <20220421052121.3464100-1-baolu.lu@linux.intel.com>
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
