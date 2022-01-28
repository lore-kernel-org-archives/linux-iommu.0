Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BAEC43217
	for <iommu@archiver.kernel.org>; Fri, 28 Jan 2022 20:29:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C19B83EB6;
	Fri, 28 Jan 2022 20:29:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hg6qfhPSpnLK; Fri, 28 Jan 2022 20:29:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8358583EE9;
	Fri, 28 Jan 2022 20:29:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D989C0070;
	Fri, 28 Jan 2022 20:29:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2ADEEC0031
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 20:29:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 760338282C
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 20:29:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tn7Adwz_RFvt for <iommu@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 20:29:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7F2E882893
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 20:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643401764; x=1674937764;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jUmhLCHJPiqhmaaqrTsN4KWS/+AZ+jsPvivdmM8ieFY=;
 b=nAqBN1pFHjse/39b2n6f6r9bvy79h2qiKtkuEsdfh8d5CpTFp13oHDIK
 sCkX0hRoElRg1pDbkoMNrgE47FRJM9/RshKIwT1w5qzC/20I4uj3Rqo+d
 J1u7OTcFML/WcPkMFSLAs1tXmPr/hJf1wSrMvhjsNn91v9u61zrLt65Dk
 1SyG2YO/cd8ost5bGCzYtLUpFacbNC/8skIurICFbccy+j4WII+VzHqIv
 MK/RjE/oM4EM6YuxKYC9lJYFxGvGLWzNoz4Uc2KYx8mbU/s9Y9/XCs9IF
 VxNxfTE7UTC0rPX+SJig13LMZ4vfZUG0lHB88tdKkvai4NDn8VxvL5NF1 Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="227862446"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; d="scan'208";a="227862446"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2022 12:29:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; d="scan'208";a="618827709"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
 by FMSMGA003.fm.intel.com with ESMTP; 28 Jan 2022 12:29:23 -0800
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Andy Lutomirski" <luto@kernel.org>, "Tony Luck" <tony.luck@intel.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>, "Joerg Roedel" <joro@8bytes.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
 "Ashok Raj" <ashok.raj@intel.com>,
 "Ravi V Shankar" <ravi.v.shankar@intel.com>
Subject: [PATCH v3 08/11] x86/traps: Demand-populate PASID MSR via #GP
Date: Fri, 28 Jan 2022 12:29:02 -0800
Message-Id: <20220128202905.2274672-9-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220128202905.2274672-1-fenghua.yu@intel.com>
References: <20220128202905.2274672-1-fenghua.yu@intel.com>
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

All tasks start with PASID state disabled. This means that the first
time they execute an ENQCMD instruction they will take a #GP fault.

Modify the #GP fault handler to check if the "mm" for the task has
already been allocated a PASID. If so, try to fix the #GP fault by
loading the IA32_PASID MSR.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v2:
- Directly write IA32_PASID MSR in fixup while local IRQ is still disabled
  (Thomas)
- Move #ifdef over to CONFIG_IOMMU_SVA since it is what
  defines mm->pasid and ->pasid_activated (Dave Hansen).
- Rename try_fixup_pasid() -> try_fixup_enqcmd_gp(). This
  code really is highly specific to ENQCMD, not PASIDs (Dave Hansen).
- Add lockdep assert and comment about context (Dave Hansen).
- Re-flow the if() mess (Dave Hansen).

 arch/x86/kernel/traps.c | 55 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c9d566dcf89a..7ef00dee35be 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -39,6 +39,7 @@
 #include <linux/io.h>
 #include <linux/hardirq.h>
 #include <linux/atomic.h>
+#include <linux/ioasid.h>
 
 #include <asm/stacktrace.h>
 #include <asm/processor.h>
@@ -559,6 +560,57 @@ static bool fixup_iopl_exception(struct pt_regs *regs)
 	return true;
 }
 
+/*
+ * The unprivileged ENQCMD instruction generates #GPs if the
+ * IA32_PASID MSR has not been populated.  If possible, populate
+ * the MSR from a PASID previously allocated to the mm.
+ */
+static bool try_fixup_enqcmd_gp(void)
+{
+#ifdef CONFIG_IOMMU_SVA
+	u32 pasid;
+
+	/*
+	 * MSR_IA32_PASID is managed using XSAVE.  Directly
+	 * writing to the MSR is only possible when fpregs
+	 * are valid and the fpstate is not.  This is
+	 * guaranteed when handling a userspace exception
+	 * in *before* interrupts are re-enabled.
+	 */
+	lockdep_assert_irqs_disabled();
+
+	/*
+	 * Hardware without ENQCMD will not generate
+	 * #GPs that can be fixed up here.
+	 */
+	if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
+		return false;
+
+	pasid = current->mm->pasid;
+
+	/*
+	 * If the mm has not been allocated a
+	 * PASID, the #GP can not be fixed up.
+	 */
+	if (!pasid_valid(pasid))
+		return false;
+
+	/*
+	 * Did this thread already have its PASID activated?
+	 * If so, the #GP must be from something else.
+	 */
+	if (current->pasid_activated)
+		return false;
+
+	wrmsrl(MSR_IA32_PASID, pasid | MSR_IA32_PASID_VALID);
+	current->pasid_activated = 1;
+
+	return true;
+#else
+	return false;
+#endif
+}
+
 DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 {
 	char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;
@@ -567,6 +619,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 	unsigned long gp_addr;
 	int ret;
 
+	if (user_mode(regs) && try_fixup_enqcmd_gp())
+		return;
+
 	cond_local_irq_enable(regs);
 
 	if (static_cpu_has(X86_FEATURE_UMIP)) {
-- 
2.35.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
