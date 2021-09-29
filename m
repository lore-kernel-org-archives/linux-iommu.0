Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721BBC433EF
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 18:31:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FE5361501
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 18:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2FE5361501
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F100460752;
	Wed, 29 Sep 2021 18:31:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n-sh4EjpNeYN; Wed, 29 Sep 2021 18:31:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C756660736;
	Wed, 29 Sep 2021 18:31:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5369C000F;
	Wed, 29 Sep 2021 18:31:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D32F5C000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 18:31:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CED8060752
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 18:31:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9q2RLvzwe9ri for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 18:31:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 227CD60736
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 18:31:28 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="223123512"
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; d="scan'208";a="223123512"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2021 11:31:28 -0700
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; d="scan'208";a="563481249"
Received: from agluck-desk2.sc.intel.com (HELO
 agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2021 11:31:28 -0700
Date: Wed, 29 Sep 2021 11:31:27 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH 5/8] x86/mmu: Add mm-based PASID refcounting
Message-ID: <YVSw/6BAFvh9C+ct@agluck-desk2.amr.corp.intel.com>
References: <87o88jfajo.ffs@tglx> <87k0j6dsdn.ffs@tglx>
 <YU3414QT0J7EN4w9@agluck-desk2.amr.corp.intel.com>
 <a77ee33c-6fa7-468c-8fc0-a0a2ce725e75@www.fastmail.com>
 <YVQ3wc/XjeOHpGCX@hirez.programming.kicks-ass.net>
 <87r1d78t2e.ffs@tglx>
 <75e95acc-6730-ddcf-d722-66e575076256@kernel.org>
 <877dez8fqu.ffs@tglx>
 <YVSlVv/j+WKftUU5@agluck-desk2.amr.corp.intel.com>
 <YVSrWouhMo2JxRCC@otcwcpicx3.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YVSrWouhMo2JxRCC@otcwcpicx3.sc.intel.com>
Cc: "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Peter Zijlstra <peterz@infradead.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, Andy Lutomirski <luto@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
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

On Wed, Sep 29, 2021 at 06:07:22PM +0000, Fenghua Yu wrote:
> Add
> +#ifdef CONFIG_IOMMU_SUPPORT
> because mm->pasid and current-pasid_activated are defined only if
> CONFIG_IOMMU_SUPPORT is defined.
> 
> > +	if (user_mode(regs) && current->mm->pasid && !current->pasid_activated) {
> 
> Maybe need to add "&& cpu_feature_enabled(X86_FEATURE_ENQCMD)" because
> the IA32_PASID MSR is only used when ENQCMD is enabled?
> 
> > +		current->pasid_activated = 1;
> > +		wrmsrl(MSR_IA32_PASID, current->mm->pasid | MSR_IA32_PASID_VALID);
> > +		return;
> > +	}
> > +
> 
> +endif

New version that addresses those issues.  Has ugly #ifdef in C
code :-(  If that's unacceptable, then could create some stub
functions, or add a call to __try_fixup_pasid() that's in a
file in the iommu code that is only built when CONFIG_IOMMU_SUPPORT
is set.  But either of those move the details far away from the
#GP handler so make extra work for anyone trying to follow along
with what is happening here.

-Tony

---

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index a58800973aed..5a3c87fd65de 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -528,6 +528,32 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
 
 #define GPFSTR "general protection fault"
 
+/*
+ * When a user executes the ENQCMD instruction it will #GP
+ * fault if the IA32_PASID MSR has not been set up with a
+ * valid PASID.
+ * So if the process has been allocated a PASID (mm->pasid)
+ * AND the IA32_PASID MSR has not been initialized, try to
+ * fix this #GP by initializing the IA32_PASID MSR.
+ * If the #GP was for some other reason, it will trigger
+ * again, but this routine will return false and the #GP
+ * will be processed.
+ */
+static void try_fixup_pasid(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
+		return false;
+
+#ifdef CONFIG_IOMMU_SUPPORT
+	if (current->mm->pasid && !current->pasid_activated) {
+		current->pasid_activated = 1;
+		wrmsrl(MSR_IA32_PASID, current->mm->pasid);
+		return true;
+	}
+#endif
+	return false;
+}
+
 DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 {
 	char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;
@@ -536,6 +562,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 	unsigned long gp_addr;
 	int ret;
 
+	if (user_mode(regs) && try_fixup_pasid())
+		return;
+
 	cond_local_irq_enable(regs);
 
 	if (static_cpu_has(X86_FEATURE_UMIP)) {
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
