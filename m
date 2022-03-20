Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55011C433F5
	for <iommu@archiver.kernel.org>; Sun, 20 Mar 2022 06:43:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1934381A64;
	Sun, 20 Mar 2022 06:43:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vkSD-hes5aI7; Sun, 20 Mar 2022 06:43:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9FC9081A50;
	Sun, 20 Mar 2022 06:43:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84B96C001A;
	Sun, 20 Mar 2022 06:43:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B58DC000B
 for <iommu@lists.linux-foundation.org>; Sun, 20 Mar 2022 06:43:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8B83D4014E
 for <iommu@lists.linux-foundation.org>; Sun, 20 Mar 2022 06:43:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7IRliDp_QMvP for <iommu@lists.linux-foundation.org>;
 Sun, 20 Mar 2022 06:43:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A82AC40133
 for <iommu@lists.linux-foundation.org>; Sun, 20 Mar 2022 06:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647758583; x=1679294583;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=i48PsSFDn9P9SUcu6pxPrab+KNIby29bArypa5yzeIs=;
 b=UtEpDjAITIWaKxPeJ1GnwSWVexJJiP9SMIbIguS9Fy2llJD1AN53SoS8
 rG1y7YIOt151k/I+njZ/iBMP36ZMUDlL5d79NwqZfC/d0jecVfVm1TcD7
 Ji4TFKjl06qnV/duVZ5HqO0w05b837wdzoCLuWkppTsXrcnf8JnaFpocS
 gbED1Dy0M36QmivmZSScHOgrWhh+Nauy3aoEY4DMfeCmEagpbMz4VkmTh
 JtCMK9CBf76ldH15OQ9I2GNeP/1GQf1wVawa/F45PK0tAz4VVXsYRPr8J
 zO8S+sx55eNAtUkOLE3CpbPweBopYlp5EGyy8jttToNBBRuv71gAwMyjl w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10291"; a="237961417"
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; d="scan'208";a="237961417"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2022 23:43:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; d="scan'208";a="691839943"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 19 Mar 2022 23:43:00 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH RFC 07/11] iommu: Remove SVA related callbacks from iommu ops
Date: Sun, 20 Mar 2022 14:40:26 +0800
Message-Id: <20220320064030.2936936-8-baolu.lu@linux.intel.com>
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

These ops'es have been replaced with the dev_attach/detach_pasid domain
ops'es. There's no need for them anymore. Remove them to avoid dead
code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/intel-iommu.h                   |  4 --
 include/linux/iommu.h                         |  8 ---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 17 -------
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 36 --------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  3 --
 drivers/iommu/intel/iommu.c                   |  3 --
 drivers/iommu/intel/svm.c                     | 49 -------------------
 7 files changed, 120 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index c14283137fb5..7ce12590ce0f 100644
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
 extern const struct iommu_domain_ops intel_svm_domain_ops;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 1c7db6a94022..47c9aa5aa9c8 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -212,9 +212,6 @@ struct iommu_iotlb_gather {
  * @dev_has/enable/disable_feat: per device entries to check/enable/disable
  *                               iommu specific features.
  * @dev_feat_enabled: check enabled feature
- * @sva_bind: Bind process address space to device
- * @sva_unbind: Unbind process address space from device
- * @sva_get_pasid: Get PASID associated to a SVA handle
  * @page_response: handle page request response
  * @def_domain_type: device default domain type, return value:
  *		- IOMMU_DOMAIN_IDENTITY: must use an identity domain
@@ -248,11 +245,6 @@ struct iommu_ops {
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
index 7631c00fdcbd..2513309ec0db 100644
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
 int arm_smmu_sva_attach_dev_pasid(struct iommu_domain *domain,
 				  struct device *dev, ioasid_t id);
@@ -794,19 +790,6 @@ static inline bool arm_smmu_master_iopf_supported(struct arm_smmu_master *master
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
 
 static inline int arm_smmu_sva_attach_dev_pasid(struct iommu_domain *domain,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 1e114b9dc17f..3537a2291d7c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -351,42 +351,6 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
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
index 2e9d3cd30510..026b783d602f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2864,9 +2864,6 @@ static struct iommu_ops arm_smmu_ops = {
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
index d55dca3eacf8..8781305b9a02 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4892,9 +4892,6 @@ const struct iommu_ops intel_iommu_ops = {
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
index b9f4dd7057d1..7a43ed4c0a27 100644
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
@@ -810,47 +802,6 @@ static irqreturn_t prq_event_thread(int irq, void *d)
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
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
