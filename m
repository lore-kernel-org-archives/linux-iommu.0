Return-Path: <SRS0=fDzP=OK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AFCC4332F
	for <iommu@archiver.kernel.org>; Mon, 20 Sep 2021 20:02:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89DA861242
	for <iommu@archiver.kernel.org>; Mon, 20 Sep 2021 20:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 89DA861242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5473E60AE4;
	Mon, 20 Sep 2021 20:02:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WsuniuRSXcRd; Mon, 20 Sep 2021 20:02:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0EA5360AE1;
	Mon, 20 Sep 2021 20:02:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E374CC0011;
	Mon, 20 Sep 2021 20:02:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F292C002A
 for <iommu@lists.linux-foundation.org>; Mon, 20 Sep 2021 20:02:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5EF7160AE3
 for <iommu@lists.linux-foundation.org>; Mon, 20 Sep 2021 20:02:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jQy4xkwhnffu for <iommu@lists.linux-foundation.org>;
 Mon, 20 Sep 2021 20:02:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 63D7360AE5
 for <iommu@lists.linux-foundation.org>; Mon, 20 Sep 2021 20:02:15 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="220033641"
X-IronPort-AV: E=Sophos;i="5.85,309,1624345200"; d="scan'208";a="220033641"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2021 13:02:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,309,1624345200"; d="scan'208";a="473779485"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
 by fmsmga007.fm.intel.com with ESMTP; 20 Sep 2021 13:02:14 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, "Peter Zijlstra" <peterz@infradead.org>,
 "Andy Lutomirski" <luto@kernel.org>, "Dave Hansen" <dave.hansen@intel.com>,
 "Tony Luck" <tony.luck@intel.com>, "Lu Baolu" <baolu.lu@linux.intel.com>,
 "Joerg Roedel" <joro@8bytes.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 "Dave Jiang" <dave.jiang@intel.com>,
 "Jacob Jun Pan" <jacob.jun.pan@intel.com>,
 "Ashok Raj" <ashok.raj@intel.com>,
 "Ravi V Shankar" <ravi.v.shankar@intel.com>
Subject: [PATCH 4/8] x86/traps: Demand-populate PASID MSR via #GP
Date: Mon, 20 Sep 2021 19:23:45 +0000
Message-Id: <20210920192349.2602141-5-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210920192349.2602141-1-fenghua.yu@intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

ENQCMD requires the IA32_PASID MSR has a valid PASID value which was
allocated to the process during bind. The MSR could be populated eagerly
by an IPI after the PASID is allocated in bind. But the method was
disabled in commit 9bfecd058339 ("x86/cpufeatures: Force disable
X86_FEATURE_ENQCMD and remove update_pasid()")' due to locking and other
issues.

Since the MSR was cleared in fork()/clone(), the first ENQCMD will
generate a #GP fault. The #GP fault handler will initialize the MSR
if a PASID has been allocated for this process.

The lazy enabling of the PASID MSR in the #GP handler is not an elegant
solution. But it has the least complexity that fits with h/w behavior.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/fpu/api.h |  6 ++++
 arch/x86/include/asm/iommu.h   |  2 ++
 arch/x86/kernel/fpu/xstate.c   | 59 ++++++++++++++++++++++++++++++++++
 arch/x86/kernel/traps.c        | 12 +++++++
 drivers/iommu/intel/svm.c      | 32 ++++++++++++++++++
 5 files changed, 111 insertions(+)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index ca4d0dee1ecd..f146849e5c8c 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -106,4 +106,10 @@ extern int cpu_has_xfeatures(u64 xfeatures_mask, const char **feature_name);
  */
 #define PASID_DISABLED	0
 
+#ifdef CONFIG_INTEL_IOMMU_SVM
+void fpu__pasid_write(u32 pasid);
+#else
+static inline void fpu__pasid_write(u32 pasid) { }
+#endif
+
 #endif /* _ASM_X86_FPU_API_H */
diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
index bf1ed2ddc74b..9c4bf9b0702f 100644
--- a/arch/x86/include/asm/iommu.h
+++ b/arch/x86/include/asm/iommu.h
@@ -26,4 +26,6 @@ arch_rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
 	return -EINVAL;
 }
 
+bool __fixup_pasid_exception(void);
+
 #endif /* _ASM_X86_IOMMU_H */
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index c8def1b7f8fb..8a89b2cecd77 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1289,3 +1289,62 @@ int proc_pid_arch_status(struct seq_file *m, struct pid_namespace *ns,
 	return 0;
 }
 #endif /* CONFIG_PROC_PID_ARCH_STATUS */
+
+#ifdef CONFIG_INTEL_IOMMU_SVM
+/**
+ * fpu__pasid_write - Write the current task's PASID state/MSR.
+ * @pasid:	the PASID
+ *
+ * The PASID is written to the IA32_PASID MSR directly if the MSR is active.
+ * Otherwise it's written to the PASID. The IA32_PASID MSR should contain
+ * the PASID after returning to the user.
+ *
+ * This is called only when ENQCMD is enabled.
+ */
+void fpu__pasid_write(u32 pasid)
+{
+	struct xregs_state *xsave = &current->thread.fpu.state.xsave;
+	u64 msr_val = pasid | MSR_IA32_PASID_VALID;
+	struct fpu *fpu = &current->thread.fpu;
+
+	/*
+	 * ENQCMD always uses the compacted XSAVE format. Ensure the buffer
+	 * has space for the PASID.
+	 */
+	BUG_ON(!(xsave->header.xcomp_bv & XFEATURE_MASK_PASID));
+
+	fpregs_lock();
+
+	/*
+	 * If the task's FPU doesn't need to be loaded or is valid, directly
+	 * write the IA32_PASID MSR. Otherwise, write the PASID state and
+	 * the MSR will be loaded from the PASID state before returning to
+	 * the user.
+	 */
+	if (!test_thread_flag(TIF_NEED_FPU_LOAD) ||
+	    fpregs_state_valid(fpu, smp_processor_id())) {
+		wrmsrl(MSR_IA32_PASID, msr_val);
+	} else {
+		struct ia32_pasid_state *ppasid_state;
+		/*
+		 * Mark XFEATURE_PASID as non-init in the XSAVE buffer.
+		 * This ensures that a subsequent XRSTOR will see the new
+		 * value instead of writing the init value to the MSR.
+		 */
+		xsave->header.xfeatures |= XFEATURE_MASK_PASID;
+		ppasid_state = get_xsave_addr(xsave, XFEATURE_PASID);
+		/*
+		 * ppasid_state shouldn't be NULL because XFEATURE_PASID
+		 * was set just now.
+		 *
+		 * Please note that the following operation is a "write only"
+		 * operation on the PASID state and it writes the *ENTIRE*
+		 * state component. Please don't blindly copy this code to
+		 * modify other XSAVE states.
+		 */
+		ppasid_state->pasid = msr_val;
+	}
+
+	fpregs_unlock();
+}
+#endif /* CONFIG_INTEL_IOMMU_SVM */
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index a58800973aed..a25d738ae839 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -61,6 +61,7 @@
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
 #include <asm/vdso.h>
+#include <asm/iommu.h>
 
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
@@ -526,6 +527,14 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
 	return GP_CANONICAL;
 }
 
+static bool fixup_pasid_exception(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
+		return false;
+
+	return __fixup_pasid_exception();
+}
+
 #define GPFSTR "general protection fault"
 
 DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
@@ -538,6 +547,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 
 	cond_local_irq_enable(regs);
 
+	if (user_mode(regs) && fixup_pasid_exception())
+		goto exit;
+
 	if (static_cpu_has(X86_FEATURE_UMIP)) {
 		if (user_mode(regs) && fixup_umip_exception(regs))
 			goto exit;
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 5b5d69b04fcc..ab65020019b6 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -1179,3 +1179,35 @@ int intel_svm_page_response(struct device *dev,
 	mutex_unlock(&pasid_mutex);
 	return ret;
 }
+
+/*
+ * Try to figure out if there is a PASID MSR value to propagate to the
+ * thread taking the #GP.
+ */
+bool __fixup_pasid_exception(void)
+{
+	u32 pasid;
+
+	/*
+	 * This function is called only when this #GP was triggered from user
+	 * space. So the mm cannot be NULL.
+	 */
+	pasid = current->mm->pasid;
+
+	/* If no PASID is allocated, there is nothing to propagate. */
+	if (pasid == PASID_DISABLED)
+		return false;
+
+	/*
+	 * If the current task already has a valid PASID MSR, then the #GP
+	 * fault must be for some non-ENQCMD related reason.
+	 */
+	if (current->has_valid_pasid)
+		return false;
+
+	/* Fix up the MSR by the PASID in the mm. */
+	fpu__pasid_write(pasid);
+	current->has_valid_pasid = 1;
+
+	return true;
+}
-- 
2.33.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
