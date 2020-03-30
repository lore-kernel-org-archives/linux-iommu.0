Return-Path: <SRS0=/IpK=5P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EE5C2BA13
	for <iommu@archiver.kernel.org>; Mon, 30 Mar 2020 20:38:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94EB0207FF
	for <iommu@archiver.kernel.org>; Mon, 30 Mar 2020 20:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94EB0207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7B5E887C51;
	Mon, 30 Mar 2020 20:38:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VXMfj8RQs9Mi; Mon, 30 Mar 2020 20:38:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7B5C887CAE;
	Mon, 30 Mar 2020 20:38:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 726C6C1D89;
	Mon, 30 Mar 2020 20:38:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41A98C1D7E
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 20:38:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2FB7E20416
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 20:38:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g3wrpb8Q9YGR for <iommu@lists.linux-foundation.org>;
 Mon, 30 Mar 2020 20:38:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by silver.osuosl.org (Postfix) with ESMTPS id 68B8E22851
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 20:38:03 +0000 (UTC)
IronPort-SDR: QTFydAUam5xS401oEoZ+uZrdpGM9VaBMRxJoM8i32ltP1SV8F9TMYlnNVxBkmoTa9LPnOgJn+P
 +n3wzUJzIkVg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2020 13:38:03 -0700
IronPort-SDR: haPA83LUmCXaOVy56e3v+JFkDdVu3y6B6FE7X4vFztwvFpQv4+jjdYqzMMdB7J88eLzXyVu++Y
 Q2XhKUl3h9/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,325,1580803200"; d="scan'208";a="242143895"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
 by orsmga008.jf.intel.com with ESMTP; 30 Mar 2020 13:38:02 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, "H Peter Anvin" <hpa@zytor.com>,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 "Dave Hansen" <dave.hansen@intel.com>, "Tony Luck" <tony.luck@intel.com>,
 "Ashok Raj" <ashok.raj@intel.com>,
 "Jacob Jun Pan" <jacob.jun.pan@intel.com>,
 "Dave Jiang" <dave.jiang@intel.com>, "Sohil Mehta" <sohil.mehta@intel.com>,
 "Ravi V Shankar" <ravi.v.shankar@intel.com>
Subject: [PATCH 6/7] x86/traps: Fix up invalid PASID
Date: Mon, 30 Mar 2020 12:33:07 -0700
Message-Id: <1585596788-193989-7-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com>
References: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com>
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

A #GP fault is generated when ENQCMD instruction is executed without
a valid PASID value programmed in. The #GP fault handler will initialize
the current thread's PASID MSR.

The following heuristic is used to avoid decoding the user instructions
to determine the precise reason for the #GP fault:
1) If the mm for the process has not been allocated a PASID, this #GP
   cannot be fixed.
2) If the PASID MSR is already initialized, then the #GP was for some
   other reason
3) Try initializing the PASID MSR and returning. If the #GP was from
   an ENQCMD this will fix it. If not, the #GP fault will be repeated
   and we will hit case "2".

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/iommu.h |  1 +
 arch/x86/kernel/traps.c      | 17 +++++++++++++++++
 drivers/iommu/intel-svm.c    | 37 ++++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
index ed41259fe7ac..e9365a5d6f7d 100644
--- a/arch/x86/include/asm/iommu.h
+++ b/arch/x86/include/asm/iommu.h
@@ -27,5 +27,6 @@ arch_rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
 }
 
 void __free_pasid(struct mm_struct *mm);
+bool __fixup_pasid_exception(void);
 
 #endif /* _ASM_X86_IOMMU_H */
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 6ef00eb6fbb9..369b5ba94635 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -56,6 +56,7 @@
 #include <asm/umip.h>
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
+#include <asm/iommu.h>
 
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
@@ -488,6 +489,16 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
 	return GP_CANONICAL;
 }
 
+static bool fixup_pasid_exception(void)
+{
+	if (!IS_ENABLED(CONFIG_INTEL_IOMMU_SVM))
+		return false;
+	if (!static_cpu_has(X86_FEATURE_ENQCMD))
+		return false;
+
+	return __fixup_pasid_exception();
+}
+
 #define GPFSTR "general protection fault"
 
 dotraplinkage void do_general_protection(struct pt_regs *regs, long error_code)
@@ -499,6 +510,12 @@ dotraplinkage void do_general_protection(struct pt_regs *regs, long error_code)
 	int ret;
 
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
+
+	if (user_mode(regs) && fixup_pasid_exception()) {
+		cond_local_irq_enable(regs);
+		return;
+	}
+
 	cond_local_irq_enable(regs);
 
 	if (static_cpu_has(X86_FEATURE_UMIP)) {
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index da718a49e91e..5ed39a022adb 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -759,3 +759,40 @@ void __free_pasid(struct mm_struct *mm)
 	 */
 	ioasid_free(pasid);
 }
+
+/*
+ * Fix up the PASID MSR if possible.
+ *
+ * But if the #GP was due to another reason, a second #GP might be triggered
+ * to force proper behavior.
+ */
+bool __fixup_pasid_exception(void)
+{
+	struct mm_struct *mm;
+	bool ret = true;
+	u64 pasid_msr;
+	int pasid;
+
+	mm = get_task_mm(current);
+	/* This #GP was triggered from user mode. So mm cannot be NULL. */
+	pasid = mm->context.pasid;
+	/* Ensure this process has been bound to a PASID. */
+	if (!pasid) {
+		ret = false;
+		goto out;
+	}
+
+	/* Check to see if the PASID MSR has already been set for this task. */
+	rdmsrl(MSR_IA32_PASID, pasid_msr);
+	if (pasid_msr & MSR_IA32_PASID_VALID) {
+		ret = false;
+		goto out;
+	}
+
+	/* Fix up the MSR. */
+	wrmsrl(MSR_IA32_PASID, pasid | MSR_IA32_PASID_VALID);
+out:
+	mmput(mm);
+
+	return ret;
+}
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
