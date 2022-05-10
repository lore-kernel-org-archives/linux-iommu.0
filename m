Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51D3C433FE
	for <iommu@archiver.kernel.org>; Tue, 10 May 2022 06:21:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 777F340A91;
	Tue, 10 May 2022 06:21:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zohRrHWGBCBT; Tue, 10 May 2022 06:21:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 024194010E;
	Tue, 10 May 2022 06:21:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E08E7C0039;
	Tue, 10 May 2022 06:21:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C81EDC002D
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 06:21:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C0C17415EF
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 06:21:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QsU8p8mgRQ9M for <iommu@lists.linux-foundation.org>;
 Tue, 10 May 2022 06:21:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6099A415E2
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 06:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652163685; x=1683699685;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NaNtWrfv3W647Mx2sWxzXqxtVfiPJBus1GNJDmeNZgg=;
 b=GDYsgsJk9kF6vgwAmxMfOPu8EsXf/odpbdlrELMzhLFpe41T/Aj8ox1z
 mYD5f5MLCYWNip05SHxlIrx/MqF1x02LiXpEDbPehkyH0AWhwzJbn7Nmf
 NGDgQP13P90+6deiOHiOq0VUQqAwGtdW629cM6mtAKMVTA8Ezdy55+OOx
 mSlT0Wp17jByRioQcFG63j+wUBChu/ljXnxGesFBaGqeUlmj8iWKlWubs
 lik97CFpEXD7oce4f/NpHqSnVo1RIprPYIAezs4kT7naiiFP4R8jx5Zq7
 zCNj6cuenBJ5c/LRLkI3z/5ZvnkY36vsuLVgs6P2mAFphWaOcvk66QTm4 w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="266863810"
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; d="scan'208";a="266863810"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2022 23:21:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; d="scan'208";a="552636606"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by orsmga002.jf.intel.com with ESMTP; 09 May 2022 23:21:20 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v6 09/12] iommu: Remove SVA related callbacks from iommu ops
Date: Tue, 10 May 2022 14:17:35 +0800
Message-Id: <20220510061738.2761430-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
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

These ops'es have been replaced with the dev_attach/detach_pasid domain
ops'es. There's no need for them anymore. Remove them to avoid dead
code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/linux/intel-iommu.h                   |  4 --
 include/linux/iommu.h                         |  8 ---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 17 -------
 drivers/iommu/iommu-sva-lib.h                 |  1 -
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 41 ----------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  3 --
 drivers/iommu/intel/iommu.c                   |  3 --
 drivers/iommu/intel/svm.c                     | 49 -------------------
 drivers/iommu/iommu-sva-lib.c                 |  4 +-
 9 files changed, 2 insertions(+), 128 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 2397c2007cda..4a5cc796f917 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -738,10 +738,6 @@ struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn);
 extern void intel_svm_check(struct intel_iommu *iommu);
 extern int intel_svm_enable_prq(struct intel_iommu *iommu);
 extern int intel_svm_finish_prq(struct intel_iommu *iommu);
-struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm,
-				 void *drvdata);
-void intel_svm_unbind(struct iommu_sva *handle);
-u32 intel_svm_get_pasid(struct iommu_sva *handle);
 int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
 			    struct iommu_page_response *msg);
 struct iommu_domain *intel_svm_domain_alloc(void);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5a3ef4d58b1f..392b8adc3495 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -215,9 +215,6 @@ struct iommu_iotlb_gather {
  * @dev_has/enable/disable_feat: per device entries to check/enable/disable
  *                               iommu specific features.
  * @dev_feat_enabled: check enabled feature
- * @sva_bind: Bind process address space to device
- * @sva_unbind: Unbind process address space from device
- * @sva_get_pasid: Get PASID associated to a SVA handle
  * @page_response: handle page request response
  * @def_domain_type: device default domain type, return value:
  *		- IOMMU_DOMAIN_IDENTITY: must use an identity domain
@@ -251,11 +248,6 @@ struct iommu_ops {
 	int (*dev_enable_feat)(struct device *dev, enum iommu_dev_features f);
 	int (*dev_disable_feat)(struct device *dev, enum iommu_dev_features f);
 
-	struct iommu_sva *(*sva_bind)(struct device *dev, struct mm_struct *mm,
-				      void *drvdata);
-	void (*sva_unbind)(struct iommu_sva *handle);
-	u32 (*sva_get_pasid)(struct iommu_sva *handle);
-
 	int (*page_response)(struct device *dev,
 			     struct iommu_fault_event *evt,
 			     struct iommu_page_response *msg);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index e077f21e2528..15dd4c7e6d3a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -754,10 +754,6 @@ bool arm_smmu_master_sva_enabled(struct arm_smmu_master *master);
 int arm_smmu_master_enable_sva(struct arm_smmu_master *master);
 int arm_smmu_master_disable_sva(struct arm_smmu_master *master);
 bool arm_smmu_master_iopf_supported(struct arm_smmu_master *master);
-struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm,
-				    void *drvdata);
-void arm_smmu_sva_unbind(struct iommu_sva *handle);
-u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle);
 void arm_smmu_sva_notifier_synchronize(void);
 struct iommu_domain *arm_smmu_sva_domain_alloc(void);
 #else /* CONFIG_ARM_SMMU_V3_SVA */
@@ -791,19 +787,6 @@ static inline bool arm_smmu_master_iopf_supported(struct arm_smmu_master *master
 	return false;
 }
 
-static inline struct iommu_sva *
-arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
-{
-	return ERR_PTR(-ENODEV);
-}
-
-static inline void arm_smmu_sva_unbind(struct iommu_sva *handle) {}
-
-static inline u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle)
-{
-	return IOMMU_PASID_INVALID;
-}
-
 static inline void arm_smmu_sva_notifier_synchronize(void) {}
 
 static inline struct iommu_domain *arm_smmu_sva_domain_alloc(void)
diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva-lib.h
index 8909ea1094e3..3420654c6e2f 100644
--- a/drivers/iommu/iommu-sva-lib.h
+++ b/drivers/iommu/iommu-sva-lib.h
@@ -8,7 +8,6 @@
 #include <linux/ioasid.h>
 #include <linux/mm_types.h>
 
-int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max);
 struct mm_struct *iommu_sva_find(ioasid_t pasid);
 
 /* I/O Page fault */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 9d176e836d6b..56644e553c42 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -335,11 +335,6 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 	if (!bond)
 		return ERR_PTR(-ENOMEM);
 
-	/* Allocate a PASID for this mm if necessary */
-	ret = iommu_sva_alloc_pasid(mm, 1, (1U << master->ssid_bits) - 1);
-	if (ret)
-		goto err_free_bond;
-
 	bond->mm = mm;
 	bond->sva.dev = dev;
 	refcount_set(&bond->refs, 1);
@@ -358,42 +353,6 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 	return ERR_PTR(ret);
 }
 
-struct iommu_sva *
-arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
-{
-	struct iommu_sva *handle;
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
-	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
-
-	if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
-		return ERR_PTR(-EINVAL);
-
-	mutex_lock(&sva_lock);
-	handle = __arm_smmu_sva_bind(dev, mm);
-	mutex_unlock(&sva_lock);
-	return handle;
-}
-
-void arm_smmu_sva_unbind(struct iommu_sva *handle)
-{
-	struct arm_smmu_bond *bond = sva_to_bond(handle);
-
-	mutex_lock(&sva_lock);
-	if (refcount_dec_and_test(&bond->refs)) {
-		list_del(&bond->list);
-		arm_smmu_mmu_notifier_put(bond->smmu_mn);
-		kfree(bond);
-	}
-	mutex_unlock(&sva_lock);
-}
-
-u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle)
-{
-	struct arm_smmu_bond *bond = sva_to_bond(handle);
-
-	return bond->mm->pasid;
-}
-
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
 {
 	unsigned long reg, fld;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9daf3de7e539..6a10fa181827 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2857,9 +2857,6 @@ static struct iommu_ops arm_smmu_ops = {
 	.dev_feat_enabled	= arm_smmu_dev_feature_enabled,
 	.dev_enable_feat	= arm_smmu_dev_enable_feature,
 	.dev_disable_feat	= arm_smmu_dev_disable_feature,
-	.sva_bind		= arm_smmu_sva_bind,
-	.sva_unbind		= arm_smmu_sva_unbind,
-	.sva_get_pasid		= arm_smmu_sva_get_pasid,
 	.page_response		= arm_smmu_page_response,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 	.owner			= THIS_MODULE,
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 10b1e9dcbd98..a5728f743c6d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4919,9 +4919,6 @@ const struct iommu_ops intel_iommu_ops = {
 	.def_domain_type	= device_def_domain_type,
 	.pgsize_bitmap		= SZ_4K,
 #ifdef CONFIG_INTEL_IOMMU_SVM
-	.sva_bind		= intel_svm_bind,
-	.sva_unbind		= intel_svm_unbind,
-	.sva_get_pasid		= intel_svm_get_pasid,
 	.page_response		= intel_svm_page_response,
 #endif
 	.default_domain_ops = &(const struct iommu_domain_ops) {
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 641ab0491ada..ca83ebc708a8 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -313,14 +313,6 @@ static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
 	return 0;
 }
 
-static int intel_svm_alloc_pasid(struct device *dev, struct mm_struct *mm)
-{
-	ioasid_t max_pasid = dev_is_pci(dev) ?
-			pci_max_pasids(to_pci_dev(dev)) : intel_pasid_max_id;
-
-	return iommu_sva_alloc_pasid(mm, PASID_MIN, max_pasid - 1);
-}
-
 static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 					   struct device *dev,
 					   struct mm_struct *mm)
@@ -809,47 +801,6 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 	return IRQ_RETVAL(handled);
 }
 
-struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
-{
-	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
-	struct iommu_sva *sva;
-	int ret;
-
-	mutex_lock(&pasid_mutex);
-	ret = intel_svm_alloc_pasid(dev, mm);
-	if (ret) {
-		mutex_unlock(&pasid_mutex);
-		return ERR_PTR(ret);
-	}
-
-	sva = intel_svm_bind_mm(iommu, dev, mm);
-	mutex_unlock(&pasid_mutex);
-
-	return sva;
-}
-
-void intel_svm_unbind(struct iommu_sva *sva)
-{
-	struct intel_svm_dev *sdev = to_intel_svm_dev(sva);
-
-	mutex_lock(&pasid_mutex);
-	intel_svm_unbind_mm(sdev->dev, sdev->pasid);
-	mutex_unlock(&pasid_mutex);
-}
-
-u32 intel_svm_get_pasid(struct iommu_sva *sva)
-{
-	struct intel_svm_dev *sdev;
-	u32 pasid;
-
-	mutex_lock(&pasid_mutex);
-	sdev = to_intel_svm_dev(sva);
-	pasid = sdev->pasid;
-	mutex_unlock(&pasid_mutex);
-
-	return pasid;
-}
-
 int intel_svm_page_response(struct device *dev,
 			    struct iommu_fault_event *evt,
 			    struct iommu_page_response *msg)
diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
index e7301514f286..ef6ed87d04ba 100644
--- a/drivers/iommu/iommu-sva-lib.c
+++ b/drivers/iommu/iommu-sva-lib.c
@@ -24,7 +24,8 @@ static DECLARE_IOASID_SET(iommu_sva_pasid);
  *
  * Returns 0 on success and < 0 on error.
  */
-int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
+static int iommu_sva_alloc_pasid(struct mm_struct *mm,
+				 ioasid_t min, ioasid_t max)
 {
 	int ret = 0;
 	ioasid_t pasid;
@@ -50,7 +51,6 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
 	mutex_unlock(&iommu_sva_lock);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);
 
 /* ioasid_find getter() requires a void * argument */
 static bool __mmget_not_zero(void *mm)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
