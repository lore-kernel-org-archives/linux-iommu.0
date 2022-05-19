Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93C6C433F5
	for <iommu@archiver.kernel.org>; Thu, 19 May 2022 07:24:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C23A41C8E;
	Thu, 19 May 2022 07:24:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AE3UoQXYJC_j; Thu, 19 May 2022 07:24:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0A63D41C7E;
	Thu, 19 May 2022 07:24:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7A7CC0032;
	Thu, 19 May 2022 07:24:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0535C002D
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 07:24:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A092840913
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 07:24:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nKRaACxerTFD for <iommu@lists.linux-foundation.org>;
 Thu, 19 May 2022 07:24:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E130C4048D
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 07:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652945074; x=1684481074;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=z00PR00Z0bBOcue3nPUlEzoXnGwLMcqBoCnXf6Kl2GI=;
 b=QC5KZDhL546qWd0T1dsEo//xYo/JQ6T7BFF2qZpGYvqQatA/7BpVJEW8
 BIsSHnyDXbPx639/4RrKYuRwexZ3prZPswjdewvxzlfB1078sKQRB+/5W
 900H2emGysg0hlHZ1QwxMhw+0IVLE47JG6+/PDSqZkhqBu4tMpGBDZHAW
 9/Cfj/Ase1HQNdVdc8hck/m0FNfbAPHHPirv2i1mQs1uOB0SLEBAbGtWi
 NlDnWxBeZZ/itEFNrP3bj/d9yo+30IwcJbvvcbJO2kDmmtraYjPFk1DAX
 17IYvSncFnlzghWAD+S56DwJm0ab3hHawA/cR2qBerfG0YmpW2DdO2Nk6 Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="335113034"
X-IronPort-AV: E=Sophos;i="5.91,236,1647327600"; d="scan'208";a="335113034"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2022 00:24:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,236,1647327600"; d="scan'208";a="714853061"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 19 May 2022 00:24:31 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v7 04/10] iommu/vt-d: Add SVA domain support
Date: Thu, 19 May 2022 15:20:41 +0800
Message-Id: <20220519072047.2996983-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
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

Add support for domain ops callbacks for an SVA domain.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/intel-iommu.h |  4 ++++
 drivers/iommu/intel/iommu.c |  4 ++++
 drivers/iommu/intel/svm.c   | 37 ++++++++++++++++++++++++++++++++-----
 3 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index df23300cfa88..5e88eaa245aa 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -744,6 +744,10 @@ void intel_svm_unbind(struct iommu_sva *handle);
 u32 intel_svm_get_pasid(struct iommu_sva *handle);
 int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
 			    struct iommu_page_response *msg);
+int intel_svm_attach_dev_pasid(struct iommu_domain *domain,
+			       struct device *dev, ioasid_t pasid);
+void intel_svm_detach_dev_pasid(struct iommu_domain *domain,
+				struct device *dev, ioasid_t pasid);
 
 struct intel_svm_dev {
 	struct list_head list;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e56b3a4b6998..2b6a52c87c73 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4923,6 +4923,10 @@ const struct iommu_ops intel_iommu_ops = {
 	.sva_unbind		= intel_svm_unbind,
 	.sva_get_pasid		= intel_svm_get_pasid,
 	.page_response		= intel_svm_page_response,
+	.sva_domain_ops = &(const struct iommu_domain_ops) {
+		.set_dev_pasid		= intel_svm_attach_dev_pasid,
+		.block_dev_pasid	= intel_svm_detach_dev_pasid,
+	},
 #endif
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev		= intel_iommu_attach_device,
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index d04880a291c3..d575792441f3 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -323,6 +323,7 @@ static int intel_svm_alloc_pasid(struct device *dev, struct mm_struct *mm)
 
 static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 					   struct device *dev,
+					   ioasid_t pasid,
 					   struct mm_struct *mm)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
@@ -331,13 +332,13 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 	struct intel_svm *svm;
 	int ret = 0;
 
-	svm = pasid_private_find(mm->pasid);
+	svm = pasid_private_find(pasid);
 	if (!svm) {
 		svm = kzalloc(sizeof(*svm), GFP_KERNEL);
 		if (!svm)
 			return ERR_PTR(-ENOMEM);
 
-		svm->pasid = mm->pasid;
+		svm->pasid = pasid;
 		svm->mm = mm;
 		INIT_LIST_HEAD_RCU(&svm->devs);
 
@@ -387,7 +388,7 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 	/* Setup the pasid table: */
 	sflags = cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
 	spin_lock_irqsave(&iommu->lock, iflags);
-	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, mm->pasid,
+	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, pasid,
 					    FLPT_DEFAULT_DID, sflags);
 	spin_unlock_irqrestore(&iommu->lock, iflags);
 
@@ -403,7 +404,7 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 free_svm:
 	if (list_empty(&svm->devs)) {
 		mmu_notifier_unregister(&svm->notifier, mm);
-		pasid_private_remove(mm->pasid);
+		pasid_private_remove(pasid);
 		kfree(svm);
 	}
 
@@ -822,7 +823,7 @@ struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm)
 		return ERR_PTR(ret);
 	}
 
-	sva = intel_svm_bind_mm(iommu, dev, mm);
+	sva = intel_svm_bind_mm(iommu, dev, mm->pasid, mm);
 	mutex_unlock(&pasid_mutex);
 
 	return sva;
@@ -931,3 +932,29 @@ int intel_svm_page_response(struct device *dev,
 	mutex_unlock(&pasid_mutex);
 	return ret;
 }
+
+int intel_svm_attach_dev_pasid(struct iommu_domain *domain,
+			       struct device *dev, ioasid_t pasid)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct mm_struct *mm = domain_to_mm(domain);
+	struct intel_iommu *iommu = info->iommu;
+	struct iommu_sva *sva;
+	int ret = 0;
+
+	mutex_lock(&pasid_mutex);
+	sva = intel_svm_bind_mm(iommu, dev, pasid, mm);
+	if (IS_ERR(sva))
+		ret = PTR_ERR(sva);
+	mutex_unlock(&pasid_mutex);
+
+	return ret;
+}
+
+void intel_svm_detach_dev_pasid(struct iommu_domain *domain,
+				struct device *dev, ioasid_t pasid)
+{
+	mutex_lock(&pasid_mutex);
+	intel_svm_unbind_mm(dev, pasid);
+	mutex_unlock(&pasid_mutex);
+}
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
