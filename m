Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9ACAC433EF
	for <iommu@archiver.kernel.org>; Sun, 10 Apr 2022 10:27:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7988D8423C;
	Sun, 10 Apr 2022 10:27:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jJ3HURqU52wD; Sun, 10 Apr 2022 10:27:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 531E38425B;
	Sun, 10 Apr 2022 10:27:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CDABC0084;
	Sun, 10 Apr 2022 10:27:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26D7CC002C
 for <iommu@lists.linux-foundation.org>; Sun, 10 Apr 2022 10:27:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 152DC417D0
 for <iommu@lists.linux-foundation.org>; Sun, 10 Apr 2022 10:27:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uqcDV1yAmZbD for <iommu@lists.linux-foundation.org>;
 Sun, 10 Apr 2022 10:27:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E558B417C6
 for <iommu@lists.linux-foundation.org>; Sun, 10 Apr 2022 10:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649586447; x=1681122447;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tbyPavgTClKEq610i0Jm+ug5uU5a3xD+avms0HQq1vo=;
 b=gmOnAKUflHyudLnCc2H4+YhdfD83vasK6wRkvhr4gR7dMldmiocq7C9i
 VcopejpJi4pPqEePR4XZuVUNil6h9ONY2IPJJp6HNR+CCLc9o1CiuZWwU
 Pl8Vqksjj1Xa9cJom+o6xipyU6CsgisnBoQvARfY9zClUdHB232aKqn/U
 PpjvD970Tl71LB3qJ9LOgHOvqk2SwzoHWxbNdwhKW9KWI0jcAvuQ/PE+P
 wR3wEZ3CABRq1Ppvag/XXvriFs/YmzvASh9/i8Pd1eFhSzAHUFLNtmba/
 0iRIKMbfmYwG4iNheF5pXiPSUtAT1nS7fNfBKFkHaq15uCerQVzLXvKWw Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10312"; a="249238467"
X-IronPort-AV: E=Sophos;i="5.90,249,1643702400"; d="scan'208";a="249238467"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2022 03:27:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,249,1643702400"; d="scan'208";a="699019608"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 10 Apr 2022 03:27:23 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH RFC v3 05/12] iommu/vt-d: Remove SVM_FLAG_SUPERVISOR_MODE
 support
Date: Sun, 10 Apr 2022 18:24:36 +0800
Message-Id: <20220410102443.294128-6-baolu.lu@linux.intel.com>
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

The current in-kernel supervisor PASID support is based on the SVA
machinery in SVA lib. The binding between a kernel PASID and kernel
mapping has many flaws. Remove SVM_FLAG_SUPERVISOR_MODE support.

Link: https://lore.kernel.org/linux-iommu/20210511194726.GP1002214@nvidia.com/
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 53 +++++++++------------------------------
 1 file changed, 12 insertions(+), 41 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 23a38763c1d1..4c283a250541 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -313,8 +313,7 @@ static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
 	return 0;
 }
 
-static int intel_svm_alloc_pasid(struct device *dev, struct mm_struct *mm,
-				 unsigned int flags)
+static int intel_svm_alloc_pasid(struct device *dev, struct mm_struct *mm)
 {
 	ioasid_t max_pasid = dev_is_pci(dev) ?
 			pci_max_pasids(to_pci_dev(dev)) : intel_pasid_max_id;
@@ -324,8 +323,7 @@ static int intel_svm_alloc_pasid(struct device *dev, struct mm_struct *mm,
 
 static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 					   struct device *dev,
-					   struct mm_struct *mm,
-					   unsigned int flags)
+					   struct mm_struct *mm)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	unsigned long iflags, sflags;
@@ -341,22 +339,18 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 
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
 		if (ret) {
-			if (svm->notifier.ops)
-				mmu_notifier_unregister(&svm->notifier, mm);
+			mmu_notifier_unregister(&svm->notifier, mm);
 			kfree(svm);
 			return ERR_PTR(ret);
 		}
@@ -391,9 +385,7 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 	}
 
 	/* Setup the pasid table: */
-	sflags = (flags & SVM_FLAG_SUPERVISOR_MODE) ?
-			PASID_FLAG_SUPERVISOR_MODE : 0;
-	sflags |= cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
+	sflags = cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
 	spin_lock_irqsave(&iommu->lock, iflags);
 	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, mm->pasid,
 					    FLPT_DEFAULT_DID, sflags);
@@ -410,8 +402,7 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 	kfree(sdev);
 free_svm:
 	if (list_empty(&svm->devs)) {
-		if (svm->notifier.ops)
-			mmu_notifier_unregister(&svm->notifier, mm);
+		mmu_notifier_unregister(&svm->notifier, mm);
 		pasid_private_remove(mm->pasid);
 		kfree(svm);
 	}
@@ -817,37 +808,17 @@ static irqreturn_t prq_event_thread(int irq, void *d)
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
-	ret = intel_svm_alloc_pasid(dev, mm, flags);
+	ret = intel_svm_alloc_pasid(dev, mm);
 	if (ret) {
 		mutex_unlock(&pasid_mutex);
 		return ERR_PTR(ret);
 	}
 
-	sva = intel_svm_bind_mm(iommu, dev, mm, flags);
+	sva = intel_svm_bind_mm(iommu, dev, mm);
 	mutex_unlock(&pasid_mutex);
 
 	return sva;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
