Return-Path: <SRS0=rAFC=PC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E474AC433F5
	for <iommu@archiver.kernel.org>; Thu, 14 Oct 2021 05:43:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F2F1610E6
	for <iommu@archiver.kernel.org>; Thu, 14 Oct 2021 05:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9F2F1610E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 828514076A;
	Thu, 14 Oct 2021 05:43:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C1-7oogwGzUV; Thu, 14 Oct 2021 05:43:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 805184071A;
	Thu, 14 Oct 2021 05:43:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69945C0011;
	Thu, 14 Oct 2021 05:43:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D632DC000D
 for <iommu@lists.linux-foundation.org>; Thu, 14 Oct 2021 05:42:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C2CFB60B0C
 for <iommu@lists.linux-foundation.org>; Thu, 14 Oct 2021 05:42:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id owEr4zNazJnx for <iommu@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 05:42:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0AC4760B08
 for <iommu@lists.linux-foundation.org>; Thu, 14 Oct 2021 05:42:58 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="214544025"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; d="scan'208";a="214544025"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2021 22:42:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; d="scan'208";a="626685264"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 13 Oct 2021 22:42:55 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 7/9] iommu/vt-d: Clean up unused PASID updating functions
Date: Thu, 14 Oct 2021 13:38:37 +0800
Message-Id: <20211014053839.727419-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211014053839.727419-1-baolu.lu@linux.intel.com>
References: <20211014053839.727419-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Fenghua Yu <fenghua.yu@intel.com>, Kevin Tian <kevin.tian@intel.com>,
 Tony Luck <tony.luck@intel.com>, Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
 Kyung Min Park <kyung.min.park@intel.com>, iommu@lists.linux-foundation.org,
 Longpeng <longpeng2@huawei.com>
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

From: Fenghua Yu <fenghua.yu@intel.com>

update_pasid() and its call chain are currently unused in the tree because
Thomas disabled the ENQCMD feature. The feature will be re-enabled shortly
using a different approach and update_pasid() and its call chain will not
be used in the new approach.

Remove the useless functions.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/r/20210920192349.2602141-1-fenghua.yu@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 arch/x86/include/asm/fpu/api.h |  2 --
 drivers/iommu/intel/svm.c      | 24 +-----------------------
 2 files changed, 1 insertion(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index 23bef08a8388..ca4d0dee1ecd 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -106,6 +106,4 @@ extern int cpu_has_xfeatures(u64 xfeatures_mask, const char **feature_name);
  */
 #define PASID_DISABLED	0
 
-static inline void update_pasid(void) { }
-
 #endif /* _ASM_X86_FPU_API_H */
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 0c228787704f..5b5d69b04fcc 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -505,21 +505,6 @@ int intel_svm_unbind_gpasid(struct device *dev, u32 pasid)
 	return ret;
 }
 
-static void _load_pasid(void *unused)
-{
-	update_pasid();
-}
-
-static void load_pasid(struct mm_struct *mm, u32 pasid)
-{
-	mutex_lock(&mm->context.lock);
-
-	/* Update PASID MSR on all CPUs running the mm's tasks. */
-	on_each_cpu_mask(mm_cpumask(mm), _load_pasid, NULL, true);
-
-	mutex_unlock(&mm->context.lock);
-}
-
 static int intel_svm_alloc_pasid(struct device *dev, struct mm_struct *mm,
 				 unsigned int flags)
 {
@@ -614,10 +599,6 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 	if (ret)
 		goto free_sdev;
 
-	/* The newly allocated pasid is loaded to the mm. */
-	if (!(flags & SVM_FLAG_SUPERVISOR_MODE) && list_empty(&svm->devs))
-		load_pasid(mm, svm->pasid);
-
 	list_add_rcu(&sdev->list, &svm->devs);
 success:
 	return &sdev->sva;
@@ -670,11 +651,8 @@ static int intel_svm_unbind_mm(struct device *dev, u32 pasid)
 			kfree_rcu(sdev, rcu);
 
 			if (list_empty(&svm->devs)) {
-				if (svm->notifier.ops) {
+				if (svm->notifier.ops)
 					mmu_notifier_unregister(&svm->notifier, mm);
-					/* Clear mm's pasid. */
-					load_pasid(mm, PASID_DISABLED);
-				}
 				pasid_private_remove(svm->pasid);
 				/* We mandate that no page faults may be outstanding
 				 * for the PASID when intel_svm_unbind_mm() is called.
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
