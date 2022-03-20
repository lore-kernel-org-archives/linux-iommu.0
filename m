Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D923AC433EF
	for <iommu@archiver.kernel.org>; Sun, 20 Mar 2022 06:42:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 844BA40906;
	Sun, 20 Mar 2022 06:42:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6BM6OQkRv1HB; Sun, 20 Mar 2022 06:42:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 83C1B40900;
	Sun, 20 Mar 2022 06:42:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D1FEC001A;
	Sun, 20 Mar 2022 06:42:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5656AC000B
 for <iommu@lists.linux-foundation.org>; Sun, 20 Mar 2022 06:42:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 391AD40903
 for <iommu@lists.linux-foundation.org>; Sun, 20 Mar 2022 06:42:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VNGhq8mbgYtg for <iommu@lists.linux-foundation.org>;
 Sun, 20 Mar 2022 06:42:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 95BB740902
 for <iommu@lists.linux-foundation.org>; Sun, 20 Mar 2022 06:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647758561; x=1679294561;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=riq+74Hd12qH3YALmkqybAFcLX89Dbvo/9sgqkY6aro=;
 b=kfvQJ8GlVKse/d/TmJllqVtxigk6+G7Rxqd6MKrtvf1S2aO+0gnvYfVN
 /YPHtefs4cYQGcJCXjSvLKmLG/tlKtvctp7IL1VFQIruyxGLHVUqywxbw
 n5ae0KXoAEnbl5TTVZ2NmqO0Al52j6XeLGrHM4qax/JW7PiGsL7wy7ixe
 FfyGesQ77X7vFQ450lV/GE5f7WQ8Pz7Sw1wmrsnCIswzN3XMeyPoKB6Lx
 5vb3YWbmwy+3++/dbs6JAwO3kBxr/7dj2CZtIncoGgj/aqvszS+5bb27A
 5zaOnSW0E59zIwkcXTdScGbhr8QApT8Sq57H/ILud8IsngU8/tXqhYpet g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10291"; a="237961380"
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; d="scan'208";a="237961380"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2022 23:42:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; d="scan'208";a="691839870"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 19 Mar 2022 23:42:38 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH RFC 01/11] iommu: Add pasid_bits field in struct dev_iommu
Date: Sun, 20 Mar 2022 14:40:20 +0800
Message-Id: <20220320064030.2936936-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
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

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h                       | 1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
 drivers/iommu/intel/iommu.c                 | 5 ++++-
 3 files changed, 6 insertions(+), 1 deletion(-)

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
index 627a3ed5ee8f..8e262210b5ad 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2812,6 +2812,7 @@ static int arm_smmu_dev_enable_feature(struct device *dev,
 		master->iopf_enabled = true;
 		return 0;
 	case IOMMU_DEV_FEAT_SVA:
+		dev->iommu->pasid_bits = master->ssid_bits;
 		return arm_smmu_master_enable_sva(master);
 	default:
 		return -EINVAL;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 6f7485c44a4b..c1b91bce1530 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4587,8 +4587,11 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
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
