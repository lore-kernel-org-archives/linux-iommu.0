Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BE3C43217
	for <iommu@archiver.kernel.org>; Fri, 17 Dec 2021 22:02:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 252FC84CF5;
	Fri, 17 Dec 2021 22:02:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oVEiEEX0wrvI; Fri, 17 Dec 2021 22:02:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EEC2684DAC;
	Fri, 17 Dec 2021 22:02:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3965FC0070;
	Fri, 17 Dec 2021 22:02:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03E63C0012
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 22:02:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E95836117D
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 22:01:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T7euGRWAwJ3p for <iommu@lists.linux-foundation.org>;
 Fri, 17 Dec 2021 22:01:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6240461188
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 22:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1639778518; x=1671314518;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OBpDZUm4EngfnhF5Yo9KgToppXO+yZbVrmisYzFVZ8w=;
 b=AXC/gzpouVfWiR8lkamEbZVRSZ0MO452jPs1vmIeZjF5WWI7mbiRFCtL
 1ICPcMYfftw6beb2kT1fxZ9juXSqUhBon2GYcpVWhMsqYIQ17PVlU5Rzy
 1ACD2bMr7VCtxfuGQJaoJLpkI6RHPUXOg5woB9i/R7DZDK03BdIJGwb3C
 lXIAjsd31/zbchxrj6dDmY22koNcvINlXF5Ucbm/2PYi+Llq/di6mRUyJ
 jXv1XFWF/R+2DreTJUcJrU9dxiQ887Ztt40YJVchLPgzj+08rcPegb85N
 kqV5zz1LvypjwqkZt0dtcxma81VK1kNayWvgiAtWXAGGYgncRR4uKKwZ+ g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="239793590"
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; d="scan'208";a="239793590"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2021 14:01:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; d="scan'208";a="506928104"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
 by orsmga007.jf.intel.com with ESMTP; 17 Dec 2021 14:01:50 -0800
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, "Peter Zijlstra" <peterz@infradead.org>,
 "Andy Lutomirski" <luto@kernel.org>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Tony Luck" <tony.luck@intel.com>, "Lu Baolu" <baolu.lu@linux.intel.com>,
 "Joerg Roedel" <joro@8bytes.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
 "Ashok Raj" <ashok.raj@intel.com>,
 "Ravi V Shankar" <ravi.v.shankar@intel.com>
Subject: [PATCH v2 08/11] x86/traps: Demand-populate PASID MSR via #GP
Date: Fri, 17 Dec 2021 22:01:33 +0000
Message-Id: <20211217220136.2762116-9-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217220136.2762116-1-fenghua.yu@intel.com>
References: <20211217220136.2762116-1-fenghua.yu@intel.com>
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
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
