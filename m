Return-Path: <SRS0=lDAf=5C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE294C4CECE
	for <iommu@archiver.kernel.org>; Tue, 17 Mar 2020 07:05:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B955620719
	for <iommu@archiver.kernel.org>; Tue, 17 Mar 2020 07:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B955620719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 83F70872E7;
	Tue, 17 Mar 2020 07:05:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S8AMiaBUhY83; Tue, 17 Mar 2020 07:05:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CDA7186FDE;
	Tue, 17 Mar 2020 07:05:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8FC9C18DA;
	Tue, 17 Mar 2020 07:05:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3CEACC013E
 for <iommu@lists.linux-foundation.org>; Tue, 17 Mar 2020 07:05:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2C0DA88B15
 for <iommu@lists.linux-foundation.org>; Tue, 17 Mar 2020 07:05:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TK6w-x3VMVsD for <iommu@lists.linux-foundation.org>;
 Tue, 17 Mar 2020 07:05:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 08A4E88B31
 for <iommu@lists.linux-foundation.org>; Tue, 17 Mar 2020 07:05:17 +0000 (UTC)
IronPort-SDR: bqZ264hIzo77xHuQEEN5tFwStvUjTriYHB6unUdRQqR6UOWxPY87EDEFfkVuI8eg1FidoWkFo/
 /VDd//xCUPpA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2020 00:05:16 -0700
IronPort-SDR: bbOHQF9CFwbGmFiVjECsajKwus9j1itPYl3LyDanBb+5UR/gFqPoxVicptNq3N6T7Gh41DcPj1
 I6xQIiiGzrBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,563,1574150400"; d="scan'208";a="267867308"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 17 Mar 2020 00:05:13 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/5] iommu/vt-d: Add get_domain_info() helper
Date: Tue, 17 Mar 2020 15:02:25 +0800
Message-Id: <20200317070229.21131-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200317070229.21131-1-baolu.lu@linux.intel.com>
References: <20200317070229.21131-1-baolu.lu@linux.intel.com>
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org
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
index 7f93ad70c6c2..fdba70bf39cc 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -383,6 +383,21 @@ EXPORT_SYMBOL_GPL(intel_iommu_gfx_mapped);
 
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
 
@@ -2451,7 +2466,7 @@ struct dmar_domain *find_domain(struct device *dev)
 		dev = &pci_real_dma_dev(to_pci_dev(dev))->dev;
 
 	/* No lock here, assumes no domain exit in normal case */
-	info = dev->archdata.iommu;
+	info = get_domain_info(dev);
 	if (likely(info))
 		return info->domain;
 
@@ -4951,9 +4966,8 @@ static void dmar_remove_one_dev_info(struct device *dev)
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
@@ -5043,7 +5057,7 @@ static void intel_iommu_domain_free(struct iommu_domain *domain)
 static inline bool
 is_aux_domain(struct device *dev, struct iommu_domain *domain)
 {
-	struct device_domain_info *info = dev->archdata.iommu;
+	struct device_domain_info *info = get_domain_info(dev);
 
 	return info && info->auxd_enabled &&
 			domain->type == IOMMU_DOMAIN_UNMANAGED;
@@ -5052,7 +5066,7 @@ is_aux_domain(struct device *dev, struct iommu_domain *domain)
 static void auxiliary_link_device(struct dmar_domain *domain,
 				  struct device *dev)
 {
-	struct device_domain_info *info = dev->archdata.iommu;
+	struct device_domain_info *info = get_domain_info(dev);
 
 	assert_spin_locked(&device_domain_lock);
 	if (WARN_ON(!info))
@@ -5065,7 +5079,7 @@ static void auxiliary_link_device(struct dmar_domain *domain,
 static void auxiliary_unlink_device(struct dmar_domain *domain,
 				    struct device *dev)
 {
-	struct device_domain_info *info = dev->archdata.iommu;
+	struct device_domain_info *info = get_domain_info(dev);
 
 	assert_spin_locked(&device_domain_lock);
 	if (WARN_ON(!info))
@@ -5153,7 +5167,7 @@ static void aux_domain_remove_dev(struct dmar_domain *domain,
 		return;
 
 	spin_lock_irqsave(&device_domain_lock, flags);
-	info = dev->archdata.iommu;
+	info = get_domain_info(dev);
 	iommu = info->iommu;
 
 	auxiliary_unlink_device(domain, dev);
@@ -5551,7 +5565,7 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev)
 	spin_lock(&iommu->lock);
 
 	ret = -EINVAL;
-	info = dev->archdata.iommu;
+	info = get_domain_info(dev);
 	if (!info || !info->pasid_supported)
 		goto out;
 
@@ -5647,7 +5661,7 @@ static int intel_iommu_enable_auxd(struct device *dev)
 		return -ENODEV;
 
 	spin_lock_irqsave(&device_domain_lock, flags);
-	info = dev->archdata.iommu;
+	info = get_domain_info(dev);
 	info->auxd_enabled = 1;
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 
@@ -5660,7 +5674,7 @@ static int intel_iommu_disable_auxd(struct device *dev)
 	unsigned long flags;
 
 	spin_lock_irqsave(&device_domain_lock, flags);
-	info = dev->archdata.iommu;
+	info = get_domain_info(dev);
 	if (!WARN_ON(!info))
 		info->auxd_enabled = 0;
 	spin_unlock_irqrestore(&device_domain_lock, flags);
@@ -5742,7 +5756,7 @@ intel_iommu_dev_disable_feat(struct device *dev, enum iommu_dev_features feat)
 static bool
 intel_iommu_dev_feat_enabled(struct device *dev, enum iommu_dev_features feat)
 {
-	struct device_domain_info *info = dev->archdata.iommu;
+	struct device_domain_info *info = get_domain_info(dev);
 
 	if (feat == IOMMU_DEV_FEAT_AUX)
 		return scalable_mode_support() && info && info->auxd_enabled;
diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index 22b30f10b396..692e808e1a4e 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -94,7 +94,7 @@ int intel_pasid_alloc_table(struct device *dev)
 	int size;
 
 	might_sleep();
-	info = dev->archdata.iommu;
+	info = get_domain_info(dev);
 	if (WARN_ON(!info || !dev_is_pci(dev) || info->pasid_table))
 		return -EINVAL;
 
@@ -141,7 +141,7 @@ void intel_pasid_free_table(struct device *dev)
 	struct pasid_entry *table;
 	int i, max_pde;
 
-	info = dev->archdata.iommu;
+	info = get_domain_info(dev);
 	if (!info || !dev_is_pci(dev) || !info->pasid_table)
 		return;
 
@@ -167,7 +167,7 @@ struct pasid_table *intel_pasid_get_table(struct device *dev)
 {
 	struct device_domain_info *info;
 
-	info = dev->archdata.iommu;
+	info = get_domain_info(dev);
 	if (!info)
 		return NULL;
 
@@ -178,7 +178,7 @@ int intel_pasid_get_dev_max_id(struct device *dev)
 {
 	struct device_domain_info *info;
 
-	info = dev->archdata.iommu;
+	info = get_domain_info(dev);
 	if (!info || !info->pasid_table)
 		return 0;
 
@@ -199,7 +199,7 @@ struct pasid_entry *intel_pasid_get_entry(struct device *dev, int pasid)
 		return NULL;
 
 	dir = pasid_table->table;
-	info = dev->archdata.iommu;
+	info = get_domain_info(dev);
 	dir_index = pasid >> PASID_PDE_SHIFT;
 	index = pasid & PASID_PTE_MASK;
 
@@ -394,7 +394,7 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
 	struct device_domain_info *info;
 	u16 sid, qdep, pfsid;
 
-	info = dev->archdata.iommu;
+	info = get_domain_info(dev);
 	if (!info || !info->ats_enabled)
 		return;
 
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index e576aba2dd1e..1148f7994747 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -301,7 +301,7 @@ static int intel_svm_bind_mm(struct device *dev, int flags, struct svm_dev_ops *
 		goto out;
 	}
 
-	info = dev->archdata.iommu;
+	info = get_domain_info(dev);
 	if (!info || !info->pasid_supported) {
 		kfree(sdev);
 		goto out;
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index d512f9cd63be..a29b464e937b 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -667,6 +667,7 @@ int for_each_device_domain(int (*fn)(struct device_domain_info *info,
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
