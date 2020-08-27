Return-Path: <SRS0=m4IM=CF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6903C433E3
	for <iommu@archiver.kernel.org>; Thu, 27 Aug 2020 15:07:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6A0E22B40
	for <iommu@archiver.kernel.org>; Thu, 27 Aug 2020 15:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6A0E22B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AB830868A9;
	Thu, 27 Aug 2020 15:07:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Afx0VWtuEhc3; Thu, 27 Aug 2020 15:07:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 58B6B86A5D;
	Thu, 27 Aug 2020 15:07:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F9EEC016F;
	Thu, 27 Aug 2020 15:07:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EED54C0051
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 15:07:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DD52D86ACB
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 15:07:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mW01atb2jV2e for <iommu@lists.linux-foundation.org>;
 Thu, 27 Aug 2020 15:07:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 22A0686A70
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 15:07:02 +0000 (UTC)
IronPort-SDR: gQPMph5Z3bmt2+ij6KG2F+6qt50n0e4Y5v03AmAeoeaSFSMuly511EJImobIdQu5y4QSW0dotP
 c/g+lrpgtB9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="144175681"
X-IronPort-AV: E=Sophos;i="5.76,359,1592895600"; d="scan'208";a="144175681"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2020 08:07:00 -0700
IronPort-SDR: 5iWFj7LdX/DYg6s2cCgFzAavsgCvohV07HFPm268lGJlNHnjGRdDLrZki56Dm8kXNb9hMbQlc0
 J2OquSTpIN3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,359,1592895600"; d="scan'208";a="332212874"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
 by fmsmga002.fm.intel.com with ESMTP; 27 Aug 2020 08:07:00 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, "H Peter Anvin" <hpa@zytor.com>,
 "Andy Lutomirski" <luto@kernel.org>,
 "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
 "Christoph Hellwig" <hch@infradead.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 "Dave Hansen" <dave.hansen@intel.com>, "Tony Luck" <tony.luck@intel.com>,
 "Ashok Raj" <ashok.raj@intel.com>,
 "Jacob Jun Pan" <jacob.jun.pan@intel.com>,
 "Dave Jiang" <dave.jiang@intel.com>, "Sohil Mehta" <sohil.mehta@intel.com>,
 "Ravi V Shankar" <ravi.v.shankar@intel.com>
Subject: [PATCH v7 9/9] x86/mmu: Allocate/free PASID
Date: Thu, 27 Aug 2020 08:06:34 -0700
Message-Id: <1598540794-132666-10-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1598540794-132666-1-git-send-email-fenghua.yu@intel.com>
References: <1598540794-132666-1-git-send-email-fenghua.yu@intel.com>
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
through IPI, context switch, or inherit to ensure a running thread has
the right PASID MSR matching the mm's PASID.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v7:
- Don't fix up PASID in #GP. Instead, update the PASID MSR by IPI and
  context switch after PASID allocation and free. Inherit PASID from
  parent. (Andy)

Before v7:
- Allocate a PASID for the mm and free it until mm exit.

 arch/x86/include/asm/disabled-features.h |  2 +-
 arch/x86/include/asm/fpu/api.h           | 12 +++++
 arch/x86/include/asm/fpu/internal.h      |  2 +
 arch/x86/kernel/fpu/xstate.c             | 56 ++++++++++++++++++++++++
 drivers/iommu/intel/svm.c                | 28 +++++++++++-
 5 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 588d83e9da49..5861d34f9771 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -56,7 +56,7 @@
 # define DISABLE_PTI		(1 << (X86_FEATURE_PTI & 31))
 #endif
 
-#ifdef CONFIG_INTEL_IOMMU_SVM
+#ifdef CONFIG_IOMMU_SUPPORT
 # define DISABLE_ENQCMD	0
 #else
 # define DISABLE_ENQCMD (1 << (X86_FEATURE_ENQCMD & 31))
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
index 0a460f2a3f90..2d737e02b59a 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -583,6 +583,8 @@ static inline void switch_fpu_finish(struct fpu *new_fpu)
 			pkru_val = pk->pkru;
 	}
 	__write_pkru(pkru_val);
+
+	update_pasid();
 }
 
 /*
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 67f1a03b9b23..556040e14f1c 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1402,3 +1402,59 @@ int proc_pid_arch_status(struct seq_file *m, struct pid_namespace *ns,
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
+		if (ppasid_state) {
+			/*
+			 * Only update the task's PASID state when it's
+			 * different from the mm's pasid.
+			 */
+			if (ppasid_state->pasid != pasid_state) {
+				/*
+				 * Invalid fpregs so that xrstors will pick up
+				 * the PASID state.
+				 */
+				__fpu_invalidate_fpregs_state(fpu);
+				ppasid_state->pasid = pasid_state;
+			}
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
