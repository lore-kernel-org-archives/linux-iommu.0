Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF1BC433F5
	for <iommu@archiver.kernel.org>; Tue, 15 Mar 2022 05:04:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EBAD44090E;
	Tue, 15 Mar 2022 05:04:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zdZPRnd5_g3L; Tue, 15 Mar 2022 05:04:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 53F7740911;
	Tue, 15 Mar 2022 05:04:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B568C0091;
	Tue, 15 Mar 2022 05:04:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12F00C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 05:04:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AFA8E415BF
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 05:04:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gtb3RzacEglc for <iommu@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 05:04:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0F9CB401F1
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 05:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647320640; x=1678856640;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6bPP85I/X2JN+a+CF0RYCDiAmljsVzkxdKPwz9WA20I=;
 b=cPFjq/NAKoR2+IqsyUgvsDXYEeCJXLF78vHRopSU5rG/4vqRPEI/v5cd
 XtoqgJGg1SaL8hlFN7OPsjfacXeWYIyRbBF6QnevGSBhf8jjEZNt2k11R
 vVVrAB376FPw49/ULixuPzG+CkY88Fa83MxcpuzFQn3sWVQLNmXKfhOtZ
 /HDT7/WwMkFPLxu0y60eZDAgQoJB2s1AeN++FaMfzY7sJdScdOV5n0jzh
 GbIzUi3nePK2LcHCmESoZXLPo50bLbd//lPy9U5MhjvKGsjQoCV7Z5TNs
 q7zy71S0i39v/9TQmiyIq+La/ZJfEyzdkk9FUQUh7li/RcoFnYaZglv3g Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="342640154"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; d="scan'208";a="342640154"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2022 22:03:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; d="scan'208";a="580383590"
Received: from otc-wp-03.jf.intel.com (HELO jacob-builder.jf.intel.com)
 ([10.54.39.79])
 by orsmga001.jf.intel.com with ESMTP; 14 Mar 2022 22:03:59 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 "Christoph Hellwig" <hch@infradead.org>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH v2 7/8] iommu/vt-d: Delete supervisor/kernel SVA
Date: Mon, 14 Mar 2022 22:07:11 -0700
Message-Id: <20220315050713.2000518-8-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>, "Zanussi,
 Tom" <tom.zanussi@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
 Jacob Pan <jacob.jun.pan@intel.com>, Dan Williams <dan.j.williams@intel.com>
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

In-kernel DMA with PASID should use DMA API now, remove supervisor PASID
SVA support. Remove special cases in bind mm and page request service.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 42 ++++++++-------------------------------
 1 file changed, 8 insertions(+), 34 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 2c53689da461..37d6218f173b 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -516,11 +516,10 @@ static void intel_svm_free_pasid(struct mm_struct *mm)
 
 static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 					   struct device *dev,
-					   struct mm_struct *mm,
-					   unsigned int flags)
+					   struct mm_struct *mm)
 {
 	struct device_domain_info *info = get_domain_info(dev);
-	unsigned long iflags, sflags;
+	unsigned long iflags, sflags = 0;
 	struct intel_svm_dev *sdev;
 	struct intel_svm *svm;
 	int ret = 0;
@@ -533,16 +532,13 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 
 		svm->pasid = mm->pasid;
 		svm->mm = mm;
-		svm->flags = flags;
 		INIT_LIST_HEAD_RCU(&svm->devs);
 
-		if (!(flags & SVM_FLAG_SUPERVISOR_MODE)) {
-			svm->notifier.ops = &intel_mmuops;
-			ret = mmu_notifier_register(&svm->notifier, mm);
-			if (ret) {
-				kfree(svm);
-				return ERR_PTR(ret);
-			}
+		svm->notifier.ops = &intel_mmuops;
+		ret = mmu_notifier_register(&svm->notifier, mm);
+		if (ret) {
+			kfree(svm);
+			return ERR_PTR(ret);
 		}
 
 		ret = pasid_private_add(svm->pasid, svm);
@@ -583,8 +579,6 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 	}
 
 	/* Setup the pasid table: */
-	sflags = (flags & SVM_FLAG_SUPERVISOR_MODE) ?
-			PASID_FLAG_SUPERVISOR_MODE : 0;
 	sflags |= cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
 	spin_lock_irqsave(&iommu->lock, iflags);
 	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, mm->pasid,
@@ -957,7 +951,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 			 * to unbind the mm while any page faults are outstanding.
 			 */
 			svm = pasid_private_find(req->pasid);
-			if (IS_ERR_OR_NULL(svm) || (svm->flags & SVM_FLAG_SUPERVISOR_MODE))
+			if (IS_ERR_OR_NULL(svm))
 				goto bad_req;
 		}
 
@@ -1011,29 +1005,9 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
 {
 	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
-	unsigned int flags = 0;
 	struct iommu_sva *sva;
 	int ret;
 
-	if (drvdata)
-		flags = *(unsigned int *)drvdata;
-
-	if (flags & SVM_FLAG_SUPERVISOR_MODE) {
-		if (!ecap_srs(iommu->ecap)) {
-			dev_err(dev, "%s: Supervisor PASID not supported\n",
-				iommu->name);
-			return ERR_PTR(-EOPNOTSUPP);
-		}
-
-		if (mm) {
-			dev_err(dev, "%s: Supervisor PASID with user provided mm\n",
-				iommu->name);
-			return ERR_PTR(-EINVAL);
-		}
-
-		mm = &init_mm;
-	}
-
 	mutex_lock(&pasid_mutex);
 	ret = intel_svm_alloc_pasid(dev, mm, flags);
 	if (ret) {
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
