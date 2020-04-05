Return-Path: <SRS0=HSJZ=5V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9272C2BA19
	for <iommu@archiver.kernel.org>; Sun,  5 Apr 2020 08:34:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A676F20659
	for <iommu@archiver.kernel.org>; Sun,  5 Apr 2020 08:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A676F20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 99386860D2;
	Sun,  5 Apr 2020 08:34:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tQwxYNT6J1A0; Sun,  5 Apr 2020 08:34:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E148185C06;
	Sun,  5 Apr 2020 08:34:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD126C1AE2;
	Sun,  5 Apr 2020 08:34:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24C1BC0177
 for <iommu@lists.linux-foundation.org>; Sun,  5 Apr 2020 08:34:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 21214204A8
 for <iommu@lists.linux-foundation.org>; Sun,  5 Apr 2020 08:34:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DUd6HV0vnuKH for <iommu@lists.linux-foundation.org>;
 Sun,  5 Apr 2020 08:34:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by silver.osuosl.org (Postfix) with ESMTPS id D224D20429
 for <iommu@lists.linux-foundation.org>; Sun,  5 Apr 2020 08:34:28 +0000 (UTC)
IronPort-SDR: iLbf3D2ySaD3NKRICI+PHYnOXqn9JvtKLI2WM9Zp5Q2ByeXUpeAKPRIFnHJw2keFvkJ04GaWd8
 yzwPlTFdIZxg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Apr 2020 01:34:28 -0700
IronPort-SDR: 5zxzdLfRMA3YoFb+Z0U9DH026yW4yMK8bTzu1MfzEt+2nx5qTfE2Naz5KXCrJB3JLY0DCKEjhN
 BcqcgJPcnUGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,347,1580803200"; d="scan'208";a="397179418"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by orsmga004.jf.intel.com with ESMTP; 05 Apr 2020 01:34:26 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 17/19] iommu/vt-d: Add get_domain_info() helper
Date: Sun,  5 Apr 2020 16:30:51 +0800
Message-Id: <20200405083053.17865-18-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200405083053.17865-1-baolu.lu@linux.intel.com>
References: <20200405083053.17865-1-baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Add a get_domain_info() helper to retrieve the valid per-device
iommu private data.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 38 +++++++++++++++++++++++++------------
 drivers/iommu/intel-pasid.c | 12 ++++++------
 drivers/iommu/intel-svm.c   |  2 +-
 include/linux/intel-iommu.h |  1 +
 4 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 087cf8a701f6..3c82fcb50ee7 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -365,6 +365,21 @@ EXPORT_SYMBOL_GPL(intel_iommu_gfx_mapped);
 
 #define DUMMY_DEVICE_DOMAIN_INFO ((struct device_domain_info *)(-1))
 #define DEFER_DEVICE_DOMAIN_INFO ((struct device_domain_info *)(-2))
+struct device_domain_info *get_domain_info(struct device *dev)
+{
+	struct device_domain_info *info;
+
+	if (!dev)
+		return NULL;
+
+	info = dev->archdata.iommu;
+	if (unlikely(info == DUMMY_DEVICE_DOMAIN_INFO ||
+		     info == DEFER_DEVICE_DOMAIN_INFO))
+		return NULL;
+
+	return info;
+}
+
 DEFINE_SPINLOCK(device_domain_lock);
 static LIST_HEAD(device_domain_list);
 
@@ -2430,7 +2445,7 @@ struct dmar_domain *find_domain(struct device *dev)
 		dev = &pci_real_dma_dev(to_pci_dev(dev))->dev;
 
 	/* No lock here, assumes no domain exit in normal case */
-	info = dev->archdata.iommu;
+	info = get_domain_info(dev);
 	if (likely(info))
 		return info->domain;
 
@@ -5012,9 +5027,8 @@ static void dmar_remove_one_dev_info(struct device *dev)
 	unsigned long flags;
 
 	spin_lock_irqsave(&device_domain_lock, flags);
-	info = dev->archdata.iommu;
-	if (info && info != DEFER_DEVICE_DOMAIN_INFO
-	    && info != DUMMY_DEVICE_DOMAIN_INFO)
+	info = get_domain_info(dev);
+	if (info)
 		__dmar_remove_one_dev_info(info);
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 }
@@ -5104,7 +5118,7 @@ static void intel_iommu_domain_free(struct iommu_domain *domain)
 static inline bool
 is_aux_domain(struct device *dev, struct iommu_domain *domain)
 {
-	struct device_domain_info *info = dev->archdata.iommu;
+	struct device_domain_info *info = get_domain_info(dev);
 
 	return info && info->auxd_enabled &&
 			domain->type == IOMMU_DOMAIN_UNMANAGED;
@@ -5113,7 +5127,7 @@ is_aux_domain(struct device *dev, struct iommu_domain *domain)
 static void auxiliary_link_device(struct dmar_domain *domain,
 				  struct device *dev)
 {
-	struct device_domain_info *info = dev->archdata.iommu;
+	struct device_domain_info *info = get_domain_info(dev);
 
 	assert_spin_locked(&device_domain_lock);
 	if (WARN_ON(!info))
@@ -5126,7 +5140,7 @@ static void auxiliary_link_device(struct dmar_domain *domain,
 static void auxiliary_unlink_device(struct dmar_domain *domain,
 				    struct device *dev)
 {
-	struct device_domain_info *info = dev->archdata.iommu;
+	struct device_domain_info *info = get_domain_info(dev);
 
 	assert_spin_locked(&device_domain_lock);
 	if (WARN_ON(!info))
@@ -5214,7 +5228,7 @@ static void aux_domain_remove_dev(struct dmar_domain *domain,
 		return;
 
 	spin_lock_irqsave(&device_domain_lock, flags);
-	info = dev->archdata.iommu;
+	info = get_domain_info(dev);
 	iommu = info->iommu;
 
 	auxiliary_unlink_device(domain, dev);
@@ -5780,7 +5794,7 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev)
 	spin_lock(&iommu->lock);
 
 	ret = -EINVAL;
-	info = dev->archdata.iommu;
+	info = get_domain_info(dev);
 	if (!info || !info->pasid_supported)
 		goto out;
 
@@ -5876,7 +5890,7 @@ static int intel_iommu_enable_auxd(struct device *dev)
 		return -ENODEV;
 
 	spin_lock_irqsave(&device_domain_lock, flags);
-	info = dev->archdata.iommu;
+	info = get_domain_info(dev);
 	info->auxd_enabled = 1;
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 
@@ -5889,7 +5903,7 @@ static int intel_iommu_disable_auxd(struct device *dev)
 	unsigned long flags;
 
 	spin_lock_irqsave(&device_domain_lock, flags);
-	info = dev->archdata.iommu;
+	info = get_domain_info(dev);
 	if (!WARN_ON(!info))
 		info->auxd_enabled = 0;
 	spin_unlock_irqrestore(&device_domain_lock, flags);
@@ -5966,7 +5980,7 @@ intel_iommu_dev_disable_feat(struct device *dev, enum iommu_dev_features feat)
 static bool
 intel_iommu_dev_feat_enabled(struct device *dev, enum iommu_dev_features feat)
 {
-	struct device_domain_info *info = dev->archdata.iommu;
+	struct device_domain_info *info = get_domain_info(dev);
 
 	if (feat == IOMMU_DEV_FEAT_AUX)
 		return scalable_mode_support() && info && info->auxd_enabled;
diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index 8da1b4162a82..503231a1ce60 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -151,7 +151,7 @@ int intel_pasid_alloc_table(struct device *dev)
 	int size;
 
 	might_sleep();
-	info = dev->archdata.iommu;
+	info = get_domain_info(dev);
 	if (WARN_ON(!info || !dev_is_pci(dev) || info->pasid_table))
 		return -EINVAL;
 
@@ -198,7 +198,7 @@ void intel_pasid_free_table(struct device *dev)
 	struct pasid_entry *table;
 	int i, max_pde;
 
-	info = dev->archdata.iommu;
+	info = get_domain_info(dev);
 	if (!info || !dev_is_pci(dev) || !info->pasid_table)
 		return;
 
@@ -224,7 +224,7 @@ struct pasid_table *intel_pasid_get_table(struct device *dev)
 {
 	struct device_domain_info *info;
 
-	info = dev->archdata.iommu;
+	info = get_domain_info(dev);
 	if (!info)
 		return NULL;
 
@@ -235,7 +235,7 @@ int intel_pasid_get_dev_max_id(struct device *dev)
 {
 	struct device_domain_info *info;
 
-	info = dev->archdata.iommu;
+	info = get_domain_info(dev);
 	if (!info || !info->pasid_table)
 		return 0;
 
@@ -256,7 +256,7 @@ struct pasid_entry *intel_pasid_get_entry(struct device *dev, int pasid)
 		return NULL;
 
 	dir = pasid_table->table;
-	info = dev->archdata.iommu;
+	info = get_domain_info(dev);
 	dir_index = pasid >> PASID_PDE_SHIFT;
 	index = pasid & PASID_PTE_MASK;
 
@@ -522,7 +522,7 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
 	struct device_domain_info *info;
 	u16 sid, qdep, pfsid;
 
-	info = dev->archdata.iommu;
+	info = get_domain_info(dev);
 	if (!info || !info->ats_enabled)
 		return;
 
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index a0e30267667a..81a7e77de6b4 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -507,7 +507,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 		goto out;
 	}
 
-	info = dev->archdata.iommu;
+	info = get_domain_info(dev);
 	if (!info || !info->pasid_supported) {
 		kfree(sdev);
 		goto out;
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 4038fa3d837a..28e4aa2296fa 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -714,6 +714,7 @@ int for_each_device_domain(int (*fn)(struct device_domain_info *info,
 void iommu_flush_write_buffer(struct intel_iommu *iommu);
 int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev);
 struct dmar_domain *find_domain(struct device *dev);
+struct device_domain_info *get_domain_info(struct device *dev);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 extern void intel_svm_check(struct intel_iommu *iommu);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
