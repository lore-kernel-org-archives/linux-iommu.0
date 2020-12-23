Return-Path: <SRS0=5yIV=F3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4324DC433DB
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 06:27:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF2A220449
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 06:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF2A220449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 32E3E22EE6;
	Wed, 23 Dec 2020 06:27:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Os-TjjZmWsS4; Wed, 23 Dec 2020 06:27:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7F33520028;
	Wed, 23 Dec 2020 06:27:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C8CCC1825;
	Wed, 23 Dec 2020 06:27:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78A97C0893
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 06:27:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 67F9385DC7
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 06:27:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id slF70-TLkaJx for <iommu@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 06:27:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B253785D97
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 06:27:42 +0000 (UTC)
IronPort-SDR: xzjc6LCtdrahLIDBauV4MxCrXmSBG2A/o1N+nuT5QDsrm9OCk+9P4F7Y8+tu/TL4qTfZUC1QLh
 yzwIoO7UEz7w==
X-IronPort-AV: E=McAfee;i="6000,8403,9843"; a="155182360"
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; d="scan'208";a="155182360"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2020 22:27:42 -0800
IronPort-SDR: qVDtNeVL/E7F3LKeLpJf8Av5fqsm+UUsnhu8iS5sD0JMTq+6d7eKOxAX37jYFCsBqGBMTtEr/P
 xU2+uy29Y0Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; d="scan'208";a="338703531"
Received: from yiliu-dev.bj.intel.com (HELO iov-dev.bj.intel.com)
 ([10.238.156.135])
 by fmsmga007.fm.intel.com with ESMTP; 22 Dec 2020 22:27:38 -0800
From: Liu Yi L <yi.l.liu@intel.com>
To: baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org,
 jacob.jun.pan@linux.intel.com
Subject: [PATCH v2 1/3] iommu/vt-d: Move intel_iommu info from struct
 intel_svm to struct intel_svm_dev
Date: Wed, 23 Dec 2020 14:27:18 +0800
Message-Id: <20201223062720.29364-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201223062720.29364-1-yi.l.liu@intel.com>
References: <20201223062720.29364-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Cc: kevin.tian@intel.com, ashok.raj@intel.com, jun.j.tian@intel.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 yi.y.sun@intel.com, Guo Kaijie <Kaijie.Guo@intel.com>,
 David Woodhouse <dwmw2@infradead.org>
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

Current struct intel_svm has a field to record the struct intel_iommu
pointer for a PASID bind. And struct intel_svm will be shared by all
the devices bind to the same process. The devices may be behind different
DMAR units. As the iommu driver code uses the intel_iommu pointer stored
in intel_svm struct to do cache invalidations, it may only flush the cache
on a single DMAR unit, for others, the cache invalidation is missed.

As intel_svm struct already has a device list, this patch just moves the
intel_iommu pointer to be a field of intel_svm_dev struct.

Fixes: 1c4f88b7f1f92 ("iommu/vt-d: Shared virtual address in scalable mode")
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Raj Ashok <ashok.raj@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Reported-by: Guo Kaijie <Kaijie.Guo@intel.com>
Reported-by: Xin Zeng <xin.zeng@intel.com>
Signed-off-by: Guo Kaijie <Kaijie.Guo@intel.com>
Signed-off-by: Xin Zeng <xin.zeng@intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Tested-by: Guo Kaijie <Kaijie.Guo@intel.com>
---
 drivers/iommu/intel/svm.c   | 9 +++++----
 include/linux/intel-iommu.h | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 3242ebd0bca3..4a10c9ff368c 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -142,7 +142,7 @@ static void intel_flush_svm_range_dev (struct intel_svm *svm, struct intel_svm_d
 	}
 	desc.qw2 = 0;
 	desc.qw3 = 0;
-	qi_submit_sync(svm->iommu, &desc, 1, 0);
+	qi_submit_sync(sdev->iommu, &desc, 1, 0);
 
 	if (sdev->dev_iotlb) {
 		desc.qw0 = QI_DEV_EIOTLB_PASID(svm->pasid) |
@@ -166,7 +166,7 @@ static void intel_flush_svm_range_dev (struct intel_svm *svm, struct intel_svm_d
 		}
 		desc.qw2 = 0;
 		desc.qw3 = 0;
-		qi_submit_sync(svm->iommu, &desc, 1, 0);
+		qi_submit_sync(sdev->iommu, &desc, 1, 0);
 	}
 }
 
@@ -211,7 +211,7 @@ static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	 */
 	rcu_read_lock();
 	list_for_each_entry_rcu(sdev, &svm->devs, list)
-		intel_pasid_tear_down_entry(svm->iommu, sdev->dev,
+		intel_pasid_tear_down_entry(sdev->iommu, sdev->dev,
 					    svm->pasid, true);
 	rcu_read_unlock();
 
@@ -363,6 +363,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	}
 	sdev->dev = dev;
 	sdev->sid = PCI_DEVID(info->bus, info->devfn);
+	sdev->iommu = iommu;
 
 	/* Only count users if device has aux domains */
 	if (iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX))
@@ -546,6 +547,7 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 		goto out;
 	}
 	sdev->dev = dev;
+	sdev->iommu = iommu;
 
 	ret = intel_iommu_enable_pasid(iommu, dev);
 	if (ret) {
@@ -575,7 +577,6 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 			kfree(sdev);
 			goto out;
 		}
-		svm->iommu = iommu;
 
 		if (pasid_max > intel_pasid_max_id)
 			pasid_max = intel_pasid_max_id;
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index d956987ed032..94522685a0d9 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -758,6 +758,7 @@ struct intel_svm_dev {
 	struct list_head list;
 	struct rcu_head rcu;
 	struct device *dev;
+	struct intel_iommu *iommu;
 	struct svm_dev_ops *ops;
 	struct iommu_sva sva;
 	u32 pasid;
@@ -771,7 +772,6 @@ struct intel_svm {
 	struct mmu_notifier notifier;
 	struct mm_struct *mm;
 
-	struct intel_iommu *iommu;
 	unsigned int flags;
 	u32 pasid;
 	int gpasid; /* In case that guest PASID is different from host PASID */
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
