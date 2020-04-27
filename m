Return-Path: <SRS0=6Sm1=6L=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6991C81B42
	for <iommu@archiver.kernel.org>; Mon, 27 Apr 2020 20:12:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE72D2072D
	for <iommu@archiver.kernel.org>; Mon, 27 Apr 2020 20:12:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE72D2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 97CFF2221C;
	Mon, 27 Apr 2020 20:12:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id amIsYzLRizic; Mon, 27 Apr 2020 20:12:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E5E172226E;
	Mon, 27 Apr 2020 20:12:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D00AEC0172;
	Mon, 27 Apr 2020 20:12:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2A8EC003B
 for <iommu@lists.linux-foundation.org>; Mon, 27 Apr 2020 20:12:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id AE39585BEE
 for <iommu@lists.linux-foundation.org>; Mon, 27 Apr 2020 20:12:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oEqSx8T7MYQr for <iommu@lists.linux-foundation.org>;
 Mon, 27 Apr 2020 20:12:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BF7DD86142
 for <iommu@lists.linux-foundation.org>; Mon, 27 Apr 2020 20:12:38 +0000 (UTC)
IronPort-SDR: HI83kJOcbLhonjUgYMQ4KSlG2JfSScM+x/GiCh5ix17vgBMlgkpjjQMsGDkcywEKvPL41QjlYN
 2qP7vGQBXdOQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2020 13:12:38 -0700
IronPort-SDR: YBiqKDU6yALRocwGMfAP5WdABSpYbxOMw94dJKnOcHjyDm/PQNZwcV+8e63r+ViAUTAQzF2MWh
 3uvOvlkaS+iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,325,1583222400"; d="scan'208";a="404431049"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
 by orsmga004.jf.intel.com with ESMTP; 27 Apr 2020 13:12:37 -0700
Date: Mon, 27 Apr 2020 13:11:42 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 6/7] x86/traps: Fix up invalid PASID
Message-ID: <20200427201141.GA242333@romley-ivt3.sc.intel.com>
References: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com>
 <1585596788-193989-7-git-send-email-fenghua.yu@intel.com>
 <87mu6ys20d.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87mu6ys20d.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, H Peter Anvin <hpa@zytor.com>,
 David Woodhouse <dwmw2@infradead.org>
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

On Sun, Apr 26, 2020 at 05:25:06PM +0200, Thomas Gleixner wrote:
> Fenghua Yu <fenghua.yu@intel.com> writes:
> > A #GP fault is generated when ENQCMD instruction is executed without
> > a valid PASID value programmed in.
> 
> Programmed in what?

Will change to "...programmed in the PASID MSR".

> 
> > The #GP fault handler will initialize the current thread's PASID MSR.
> >
> > The following heuristic is used to avoid decoding the user instructions
> > to determine the precise reason for the #GP fault:
> > 1) If the mm for the process has not been allocated a PASID, this #GP
> >    cannot be fixed.
> > 2) If the PASID MSR is already initialized, then the #GP was for some
> >    other reason
> > 3) Try initializing the PASID MSR and returning. If the #GP was from
> >    an ENQCMD this will fix it. If not, the #GP fault will be repeated
> >    and we will hit case "2".
> >
> > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Just for the record I also suggested to have a proper errorcode in the
> #GP for ENQCMD and I surely did not suggest to avoid decoding the user
> instructions.
> 
> >  void __free_pasid(struct mm_struct *mm);
> > +bool __fixup_pasid_exception(void);
> >  
> >  #endif /* _ASM_X86_IOMMU_H */
> > diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> > index 6ef00eb6fbb9..369b5ba94635 100644
> > --- a/arch/x86/kernel/traps.c
> > +++ b/arch/x86/kernel/traps.c
> > @@ -56,6 +56,7 @@
> >  #include <asm/umip.h>
> >  #include <asm/insn.h>
> >  #include <asm/insn-eval.h>
> > +#include <asm/iommu.h>
> >  
> >  #ifdef CONFIG_X86_64
> >  #include <asm/x86_init.h>
> > @@ -488,6 +489,16 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
> >  	return GP_CANONICAL;
> >  }
> >  
> > +static bool fixup_pasid_exception(void)
> > +{
> > +	if (!IS_ENABLED(CONFIG_INTEL_IOMMU_SVM))
> > +		return false;
> > +	if (!static_cpu_has(X86_FEATURE_ENQCMD))
> > +		return false;
> > +
> > +	return __fixup_pasid_exception();
> > +}
> > +
> >  #define GPFSTR "general protection fault"
> >  
> >  dotraplinkage void do_general_protection(struct pt_regs *regs, long error_code)
> > @@ -499,6 +510,12 @@ dotraplinkage void do_general_protection(struct pt_regs *regs, long error_code)
> >  	int ret;
> >  
> >  	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
> > +
> > +	if (user_mode(regs) && fixup_pasid_exception()) {
> > +		cond_local_irq_enable(regs);
> 
> The point of this conditional irq enable _AFTER_ calling into the fixup
> function is? Also what's the reason for keeping interrupts disabled
> while calling into that function? Comments exist for a reason.

irq needs to be disabled because the fixup function requires to disable
preempt in order to update the PASID MSR on the faulting CPU.

Will add comments here.

> 
> > +		return;
> > +	}
> > +
> >  	cond_local_irq_enable(regs);
> >  
> >  	if (static_cpu_has(X86_FEATURE_UMIP)) {
> > diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> > index da718a49e91e..5ed39a022adb 100644
> > --- a/drivers/iommu/intel-svm.c
> > +++ b/drivers/iommu/intel-svm.c
> > @@ -759,3 +759,40 @@ void __free_pasid(struct mm_struct *mm)
> >  	 */
> >  	ioasid_free(pasid);
> >  }
> > +
> > +/*
> > + * Fix up the PASID MSR if possible.
> > + *
> > + * But if the #GP was due to another reason, a second #GP might be triggered
> > + * to force proper behavior.
> > + */
> > +bool __fixup_pasid_exception(void)
> > +{
> > +	struct mm_struct *mm;
> > +	bool ret = true;
> > +	u64 pasid_msr;
> > +	int pasid;
> > +
> > +	mm = get_task_mm(current);
> 
> Why do you need a reference to current->mm ?

The PASID for the address space is per mm and is stored in mm.
To get the PASID, we need to get the mm and the pasid=mm->context.pasid.


> 
> > +	/* This #GP was triggered from user mode. So mm cannot be NULL. */
> > +	pasid = mm->context.pasid;
> > +	/* Ensure this process has been bound to a PASID. */
> > +	if (!pasid) {
> > +		ret = false;
> > +		goto out;
> > +	}
> > +
> > +	/* Check to see if the PASID MSR has already been set for this task. */
> > +	rdmsrl(MSR_IA32_PASID, pasid_msr);
> > +	if (pasid_msr & MSR_IA32_PASID_VALID) {
> > +		ret = false;
> > +		goto out;
> > +	}
> > +
> > +	/* Fix up the MSR. */
> > +	wrmsrl(MSR_IA32_PASID, pasid | MSR_IA32_PASID_VALID);
> > +out:
> > +	mmput(mm);

Thanks,

-Fenghua

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
