Return-Path: <SRS0=A59K=AG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C86C433E3
	for <iommu@archiver.kernel.org>; Thu, 25 Jun 2020 20:18:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81F26212CC
	for <iommu@archiver.kernel.org>; Thu, 25 Jun 2020 20:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F26212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 740BB89290;
	Thu, 25 Jun 2020 20:18:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UMQO1nUlVwML; Thu, 25 Jun 2020 20:18:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6095989292;
	Thu, 25 Jun 2020 20:18:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56309C08A5;
	Thu, 25 Jun 2020 20:18:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE618C016F
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 20:18:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B784788248
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 20:18:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iyKdTark-gvQ for <iommu@lists.linux-foundation.org>;
 Thu, 25 Jun 2020 20:18:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5E71D8821C
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 20:18:41 +0000 (UTC)
IronPort-SDR: Y10JirygdkI+8AFXjRq+SGgkxxh+B573mdvXPPLH6fRjX+hgbUJltS7ayE1pF3i9k17w0FnWry
 RfHA9fLHNAuA==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="146566763"
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; d="scan'208";a="146566763"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2020 13:18:41 -0700
IronPort-SDR: HbgYQQ8F3D7g2vr8/RvnYIWtioJfA4KeFyfwXB/YXYs/9trH2MY7r1HLPidfTlYvchctlF8Co8
 5mBjpCFmzgJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; d="scan'208";a="453132256"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
 by orsmga005.jf.intel.com with ESMTP; 25 Jun 2020 13:18:40 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Joerg Roedel" <joro@8bytes.org>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "Peter Zijlstra" <peterz@infradead.org>, "H Peter Anvin" <hpa@zytor.com>,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 "Dave Hansen" <dave.hansen@intel.com>, "Tony Luck" <tony.luck@intel.com>,
 "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
 "Christoph Hellwig" <hch@infradeed.org>, "Ashok Raj" <ashok.raj@intel.com>,
 "Jacob Jun Pan" <jacob.jun.pan@intel.com>,
 "Dave Jiang" <dave.jiang@intel.com>, "Sohil Mehta" <sohil.mehta@intel.com>,
 "Ravi V Shankar" <ravi.v.shankar@intel.com>
Subject: [PATCH v4 10/12] x86/mmu: Allocate/free PASID
Date: Thu, 25 Jun 2020 13:17:20 -0700
Message-Id: <1593116242-31507-11-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1593116242-31507-1-git-send-email-fenghua.yu@intel.com>
References: <1593116242-31507-1-git-send-email-fenghua.yu@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, iommu@lists.linux-foundation.org,
 x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
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

A PASID is allocated for an "mm" the first time any thread attaches
to an SVM capable device. Later device attachments (whether to the same
device or another SVM device) will re-use the same PASID.

The PASID is freed when the process exits (so no need to keep
reference counts on how many SVM devices are sharing the PASID).

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v4:
- Change PASID type to u32 (Christoph)

v3:
- Add sanity checks in alloc_pasid() and _free_pasid() (Baolu)
- Add a comment that the private PASID feature will be removed completely
  from IOMMU and don't track private PASID in mm (Thomas)

v2:
- Define a helper free_bind() to simplify error exit code in bind_mm()
  (Thomas)
- Fix a ret error code in bind_mm() (Thomas)
- Change pasid's type from "int" to "unsigned int" to have consistent
  pasid type in iommu (Thomas)
- Simplify alloc_pasid() a bit.

 arch/x86/include/asm/iommu.h       |   2 +
 arch/x86/include/asm/mmu_context.h |  14 ++++
 drivers/iommu/intel/svm.c          | 128 ++++++++++++++++++++++++++---
 3 files changed, 132 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
index bf1ed2ddc74b..ed41259fe7ac 100644
--- a/arch/x86/include/asm/iommu.h
+++ b/arch/x86/include/asm/iommu.h
@@ -26,4 +26,6 @@ arch_rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
 	return -EINVAL;
 }
 
+void __free_pasid(struct mm_struct *mm);
+
 #endif /* _ASM_X86_IOMMU_H */
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 47562147e70b..f8c91ce8c451 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -13,6 +13,7 @@
 #include <asm/tlbflush.h>
 #include <asm/paravirt.h>
 #include <asm/debugreg.h>
+#include <asm/iommu.h>
 
 extern atomic64_t last_mm_ctx_id;
 
@@ -117,9 +118,22 @@ static inline int init_new_context(struct task_struct *tsk,
 	init_new_context_ldt(mm);
 	return 0;
 }
+
+static inline void free_pasid(struct mm_struct *mm)
+{
+	if (!IS_ENABLED(CONFIG_INTEL_IOMMU_SVM))
+		return;
+
+	if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
+		return;
+
+	__free_pasid(mm);
+}
+
 static inline void destroy_context(struct mm_struct *mm)
 {
 	destroy_context_ldt(mm);
+	free_pasid(mm);
 }
 
 extern void switch_mm(struct mm_struct *prev, struct mm_struct *next,
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 8a0cf2f0dd54..4c788880b037 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -425,6 +425,69 @@ int intel_svm_unbind_gpasid(struct device *dev, u32 pasid)
 	return ret;
 }
 
+static void free_bind(struct intel_svm *svm, struct intel_svm_dev *sdev,
+		      bool new_pasid)
+{
+	if (new_pasid)
+		ioasid_free(svm->pasid);
+	kfree(svm);
+	kfree(sdev);
+}
+
+/*
+ * If this mm already has a PASID, use it. Otherwise allocate a new one.
+ * Let the caller know if a new PASID is allocated via 'new_pasid'.
+ */
+static int alloc_pasid(struct intel_svm *svm, struct mm_struct *mm,
+		       u32 pasid_max, bool *new_pasid,
+		       unsigned int flags)
+{
+	u32 pasid;
+
+	*new_pasid = false;
+
+	/*
+	 * Reuse the PASID if the mm already has a PASID and not a private
+	 * PASID is requested.
+	 */
+	if (mm && mm->pasid && !(flags & SVM_FLAG_PRIVATE_PASID)) {
+		void *p;
+
+		/*
+		 * Since the mm has a PASID already, the PASID should be
+		 * bound and unbound to the mm before calling this allocation.
+		 * So the PASID must be allocated by bind_mm() previously and
+		 * should still exist in ioasid; but its data must be cleared
+		 * already by unbind_mm().
+		 *
+		 * Do a sanity check here to ensure the PASID has the right
+		 * status before reusing it.
+		 */
+		p = ioasid_find(NULL, mm->pasid, NULL);
+		if (IS_ERR(p) || p)
+			return INVALID_IOASID;
+
+		/*
+		 * Once the PASID is allocated for this mm, it
+		 * stays with the mm until the mm is dropped. Reuse
+		 * the PASID which has been already allocated for the
+		 * mm instead of allocating a new one.
+		 */
+		ioasid_set_data(mm->pasid, svm);
+
+		return mm->pasid;
+	}
+
+	/* Allocate a new pasid. Do not use PASID 0, reserved for init PASID. */
+	pasid = ioasid_alloc(NULL, PASID_MIN, pasid_max - 1, svm);
+	if (pasid != INVALID_IOASID) {
+		/* A new pasid is allocated. */
+		*new_pasid = true;
+	}
+
+	return pasid;
+}
+
 /* Caller must hold pasid_mutex, mm reference */
 static int
 intel_svm_bind_mm(struct device *dev, unsigned int flags,
@@ -518,6 +581,8 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 	init_rcu_head(&sdev->rcu);
 
 	if (!svm) {
+		bool new_pasid;
+
 		svm = kzalloc(sizeof(*svm), GFP_KERNEL);
 		if (!svm) {
 			ret = -ENOMEM;
@@ -529,12 +594,9 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 		if (pasid_max > intel_pasid_max_id)
 			pasid_max = intel_pasid_max_id;
 
-		/* Do not use PASID 0, reserved for RID to PASID */
-		svm->pasid = ioasid_alloc(NULL, PASID_MIN,
-					  pasid_max - 1, svm);
+		svm->pasid = alloc_pasid(svm, mm, pasid_max, &new_pasid, flags);
 		if (svm->pasid == INVALID_IOASID) {
-			kfree(svm);
-			kfree(sdev);
+			free_bind(svm, sdev, new_pasid);
 			ret = -ENOSPC;
 			goto out;
 		}
@@ -547,9 +609,7 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 		if (mm) {
 			ret = mmu_notifier_register(&svm->notifier, mm);
 			if (ret) {
-				ioasid_free(svm->pasid);
-				kfree(svm);
-				kfree(sdev);
+				free_bind(svm, sdev, new_pasid);
 				goto out;
 			}
 		}
@@ -565,12 +625,20 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 		if (ret) {
 			if (mm)
 				mmu_notifier_unregister(&svm->notifier, mm);
-			ioasid_free(svm->pasid);
-			kfree(svm);
-			kfree(sdev);
+			free_bind(svm, sdev, new_pasid);
 			goto out;
 		}
 
+		if (mm && new_pasid && !(flags & SVM_FLAG_PRIVATE_PASID)) {
+			/*
+			 * Track the new pasid in the mm. The pasid will be
+			 * freed at process exit.
+			 *
+			 * The private PASID feature will be removed soon from
+			 * IOMMU. Don't track requested private PASID in the mm.
+			 */
+			mm->pasid = svm->pasid;
+		}
 		list_add_tail(&svm->list, &global_svm_list);
 	} else {
 		/*
@@ -640,7 +708,8 @@ static int intel_svm_unbind_mm(struct device *dev, u32 pasid)
 			kfree_rcu(sdev, rcu);
 
 			if (list_empty(&svm->devs)) {
-				ioasid_free(svm->pasid);
+				/* Clear data in the pasid. */
+				ioasid_set_data(pasid, NULL);
 				if (svm->mm)
 					mmu_notifier_unregister(&svm->notifier, svm->mm);
 				list_del(&svm->list);
@@ -1001,3 +1070,38 @@ u32 intel_svm_get_pasid(struct iommu_sva *sva)
 
 	return pasid;
 }
+
+/*
+ * An invalid pasid is either 0 (init PASID value) or bigger than max PASID
+ * (PASID_MAX - 1).
+ */
+static bool invalid_pasid(u32 pasid)
+{
+	return (pasid == INIT_PASID) || (pasid >= PASID_MAX);
+}
+
+/* On process exit free the PASID (if one was allocated). */
+void __free_pasid(struct mm_struct *mm)
+{
+	u32 pasid = mm->pasid;
+	void *p;
+
+	/* No need to free invalid pasid. */
+	if (invalid_pasid(pasid))
+		return;
+
+	/* The pasid shouldn't be bound to any mm by now. */
+	p = ioasid_find(NULL, pasid, NULL);
+	if (!IS_ERR_OR_NULL(p)) {
+		pr_err("PASID %d is still in use\n", pasid);
+
+		return;
+	}
+
+	/*
+	 * Since the pasid is not bound to any svm, there is no race
+	 * here with binding/unbinding and no need to protect the free
+	 * operation by pasid_mutex.
+	 */
+	ioasid_free(pasid);
+}
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
