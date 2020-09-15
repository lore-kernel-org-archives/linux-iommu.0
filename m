Return-Path: <SRS0=AdPL=CY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887E5C43461
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 16:30:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 322C8206BE
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 16:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 322C8206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BA99F87273;
	Tue, 15 Sep 2020 16:30:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hsJsGupuNlDL; Tue, 15 Sep 2020 16:30:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9745187029;
	Tue, 15 Sep 2020 16:30:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90E5DC0859;
	Tue, 15 Sep 2020 16:30:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7999AC0051
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 16:30:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 560E22040D
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 16:30:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y4FljBw1eLTH for <iommu@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 16:30:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by silver.osuosl.org (Postfix) with ESMTPS id 2658E220B2
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 16:30:24 +0000 (UTC)
IronPort-SDR: 92sH0LRMIX3GE9wE7OwlVwEcsBYUWivP1r7c1qzIvIndT/waRGHXxbHNJR4xUXqk05+B3sTogq
 otELHnFK7rJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="220861359"
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; d="scan'208";a="220861359"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2020 09:30:24 -0700
IronPort-SDR: +qX/hSXycQZoKuBpkG9blx/CCvzw6IeBbK6J4Xe1PGACPGeXkOv7XKDbJxjk+y8RnIp8j6KOJ7
 QJhjJi29A1hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; d="scan'208";a="345909950"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
 by orsmga007.jf.intel.com with ESMTP; 15 Sep 2020 09:30:23 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Borislav Petkov" <bp@alien8.de>,
 "Ingo Molnar" <mingo@redhat.com>, "H Peter Anvin" <hpa@zytor.com>,
 "Andy Lutomirski" <luto@kernel.org>,
 "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
 "Christoph Hellwig" <hch@infradead.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 "Dave Hansen" <dave.hansen@intel.com>, "Tony Luck" <tony.luck@intel.com>,
 "Randy Dunlap" <rdunlap@infradead.org>, "Ashok Raj" <ashok.raj@intel.com>,
 "Jacob Jun Pan" <jacob.jun.pan@intel.com>,
 "Dave Jiang" <dave.jiang@intel.com>, "Sohil Mehta" <sohil.mehta@intel.com>,
 "Ravi V Shankar" <ravi.v.shankar@intel.com>
Subject: [PATCH v8 9/9] x86/mmu: Allocate/free PASID
Date: Tue, 15 Sep 2020 09:30:13 -0700
Message-Id: <1600187413-163670-10-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1600187413-163670-1-git-send-email-fenghua.yu@intel.com>
References: <1600187413-163670-1-git-send-email-fenghua.yu@intel.com>
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

A PASID is allocated for an "mm" the first time any thread binds
to an SVM capable device and is freed from the "mm" when the SVM is
unbound by the last thread. It's possible for the "mm" to have different
PASID values in different binding/unbinding SVM cycles.

The mm's PASID (non-zero for valid PASID or 0 for invalid PASID) is
propagated to per-thread PASID MSR for all threads within the mm through
IPI, context switch, or inherit. So that a running thread has the right
PASID MSR matching the mm's PASID.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v8:
- Re-write commit message (Boris).
- Remove ppasid_state == NULL check in update_pasid() (Boris).
- Move "#ifdef CONFIG_IOMMU_SUPPORT" hunk to patch 8 (Boris).
- Add comment when calling update_pasid().

v7:
- Don't fix up PASID in #GP. Instead, update the PASID MSR by IPI and
  context switch after PASID allocation and free. Inherit PASID from
  parent. (Andy)

Before v7:
- Allocate a PASID for the mm and free it until mm exit.

 arch/x86/include/asm/fpu/api.h      | 12 ++++++
 arch/x86/include/asm/fpu/internal.h |  7 ++++
 arch/x86/kernel/fpu/xstate.c        | 57 +++++++++++++++++++++++++++++
 drivers/iommu/intel/svm.c           | 28 +++++++++++++-
 4 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index b774c52e5411..dcd9503b1098 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -62,4 +62,16 @@ extern void switch_fpu_return(void);
  */
 extern int cpu_has_xfeatures(u64 xfeatures_mask, const char **feature_name);
 
+/*
+ * Tasks that are not using SVA have mm->pasid set to zero to note that they
+ * will not have the valid bit set in MSR_IA32_PASID while they are running.
+ */
+#define PASID_DISABLED	0
+
+#ifdef CONFIG_IOMMU_SUPPORT
+/* Update current's PASID MSR/state by mm's PASID. */
+void update_pasid(void);
+#else
+static inline void update_pasid(void) { }
+#endif
 #endif /* _ASM_X86_FPU_API_H */
diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 0a460f2a3f90..341d00eba3f8 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -583,6 +583,13 @@ static inline void switch_fpu_finish(struct fpu *new_fpu)
 			pkru_val = pk->pkru;
 	}
 	__write_pkru(pkru_val);
+
+	/*
+	 * Expensive PASID MSR write will be avoided in update_pasid() because
+	 * TIF_NEED_FPU_LOAD was set. And the PASID state won't be updated
+	 * unless it's different from mm->pasid to reduce overhead.
+	 */
+	update_pasid();
 }
 
 /*
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 67f1a03b9b23..5d8047441a0a 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1402,3 +1402,60 @@ int proc_pid_arch_status(struct seq_file *m, struct pid_namespace *ns,
 	return 0;
 }
 #endif /* CONFIG_PROC_PID_ARCH_STATUS */
+
+#ifdef CONFIG_IOMMU_SUPPORT
+void update_pasid(void)
+{
+	u64 pasid_state;
+	u32 pasid;
+
+	if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
+		return;
+
+	if (!current->mm)
+		return;
+
+	pasid = READ_ONCE(current->mm->pasid);
+	/* Set the valid bit in the PASID MSR/state only for valid pasid. */
+	pasid_state = pasid == PASID_DISABLED ?
+		      pasid : pasid | MSR_IA32_PASID_VALID;
+
+	/*
+	 * No need to hold fregs_lock() since the task's fpstate won't
+	 * be changed by others (e.g. ptrace) while the task is being
+	 * switched to or is in IPI.
+	 */
+	if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
+		/* The MSR is active and can be directly updated. */
+		wrmsrl(MSR_IA32_PASID, pasid_state);
+	} else {
+		struct fpu *fpu = &current->thread.fpu;
+		struct ia32_pasid_state *ppasid_state;
+		struct xregs_state *xsave;
+
+		/*
+		 * The CPU's xstate registers are not currently active. Just
+		 * update the PASID state in the memory buffer here. The
+		 * PASID MSR will be loaded when returning to user mode.
+		 */
+		xsave = &fpu->state.xsave;
+		xsave->header.xfeatures |= XFEATURE_MASK_PASID;
+		ppasid_state = get_xsave_addr(xsave, XFEATURE_PASID);
+		/*
+		 * Since XFEATURE_MASK_PASID is set in xfeatures, ppasid_state
+		 * won't be NULL and no need to check its value.
+		 *
+		 * Only update the task's PASID state when it's different
+		 * from the mm's pasid.
+		 */
+		if (ppasid_state->pasid != pasid_state) {
+			/*
+			 * Invalid fpregs so that state restoring will pick up
+			 * the PASID state.
+			 */
+			__fpu_invalidate_fpregs_state(fpu);
+			ppasid_state->pasid = pasid_state;
+		}
+	}
+}
+#endif /* CONFIG_IOMMU_SUPPORT */
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index fc90a079e228..60ffe083b6d6 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -19,6 +19,7 @@
 #include <linux/mm_types.h>
 #include <linux/ioasid.h>
 #include <asm/page.h>
+#include <asm/fpu/api.h>
 
 #include "pasid.h"
 
@@ -444,6 +445,24 @@ int intel_svm_unbind_gpasid(struct device *dev, u32 pasid)
 	return ret;
 }
 
+static void _load_pasid(void *unused)
+{
+	update_pasid();
+}
+
+static void load_pasid(struct mm_struct *mm, u32 pasid)
+{
+	mutex_lock(&mm->context.lock);
+
+	/* Synchronize with READ_ONCE in update_pasid(). */
+	smp_store_release(&mm->pasid, pasid);
+
+	/* Update PASID MSR on all CPUs running the mm's tasks. */
+	on_each_cpu_mask(mm_cpumask(mm), _load_pasid, NULL, true);
+
+	mutex_unlock(&mm->context.lock);
+}
+
 /* Caller must hold pasid_mutex, mm reference */
 static int
 intel_svm_bind_mm(struct device *dev, unsigned int flags,
@@ -591,6 +610,10 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 		}
 
 		list_add_tail(&svm->list, &global_svm_list);
+		if (mm) {
+			/* The newly allocated pasid is loaded to the mm. */
+			load_pasid(mm, svm->pasid);
+		}
 	} else {
 		/*
 		 * Binding a new device with existing PASID, need to setup
@@ -654,8 +677,11 @@ static int intel_svm_unbind_mm(struct device *dev, u32 pasid)
 
 			if (list_empty(&svm->devs)) {
 				ioasid_free(svm->pasid);
-				if (svm->mm)
+				if (svm->mm) {
 					mmu_notifier_unregister(&svm->notifier, svm->mm);
+					/* Clear mm's pasid. */
+					load_pasid(svm->mm, PASID_DISABLED);
+				}
 				list_del(&svm->list);
 				/* We mandate that no page faults may be outstanding
 				 * for the PASID when intel_svm_unbind_mm() is called.
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
