Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBA5C433F5
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 18:07:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED4C4615E0
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 18:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ED4C4615E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8E2F240724;
	Wed, 29 Sep 2021 18:07:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mXBIVGKzJWNY; Wed, 29 Sep 2021 18:07:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 417F240133;
	Wed, 29 Sep 2021 18:07:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEEF9C000F;
	Wed, 29 Sep 2021 18:07:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19AAAC000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 18:07:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0F6E641967
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 18:07:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UcBKWh6MLkg1 for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 18:07:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5A654415C2
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 18:07:31 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="223118729"
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; d="scan'208";a="223118729"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2021 11:07:30 -0700
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; d="scan'208";a="708463491"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2021 11:07:30 -0700
Date: Wed, 29 Sep 2021 18:07:22 +0000
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH 5/8] x86/mmu: Add mm-based PASID refcounting
Message-ID: <YVSrWouhMo2JxRCC@otcwcpicx3.sc.intel.com>
References: <YUyuEjlrcOeCp4qQ@agluck-desk2.amr.corp.intel.com>
 <87o88jfajo.ffs@tglx> <87k0j6dsdn.ffs@tglx>
 <YU3414QT0J7EN4w9@agluck-desk2.amr.corp.intel.com>
 <a77ee33c-6fa7-468c-8fc0-a0a2ce725e75@www.fastmail.com>
 <YVQ3wc/XjeOHpGCX@hirez.programming.kicks-ass.net>
 <87r1d78t2e.ffs@tglx>
 <75e95acc-6730-ddcf-d722-66e575076256@kernel.org>
 <877dez8fqu.ffs@tglx>
 <YVSlVv/j+WKftUU5@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YVSlVv/j+WKftUU5@agluck-desk2.amr.corp.intel.com>
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

Hi, Tony,

On Wed, Sep 29, 2021 at 10:41:42AM -0700, Luck, Tony wrote:
> On Wed, Sep 29, 2021 at 07:15:53PM +0200, Thomas Gleixner wrote:
> > On Wed, Sep 29 2021 at 09:59, Andy Lutomirski wrote:
> > > On 9/29/21 05:28, Thomas Gleixner wrote:
> > >> Looking at that patch again, none of this muck in fpu__pasid_write() is
> > >> required at all. The whole exception fixup is:
> > >> 
> > >>      if (!user_mode(regs))
> > >>               return false;
> > >> 
> > >>      if (!current->mm->pasid)
> > >>               return false;
> > >> 
> > >>      if (current->pasid_activated)
> > >>      	     return false;
> > >
> > > <-- preemption or BH here: kaboom.
> > 
> > Sigh, this had obviously to run in the early portion of #GP, i.e. before
> > enabling interrupts.
> 
> Like this? Obviously with some comment about why this is being done.
> 
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index a58800973aed..a848a59291e7 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -536,6 +536,12 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
>  	unsigned long gp_addr;
>  	int ret;
>  

Add
+#ifdef CONFIG_IOMMU_SUPPORT
because mm->pasid and current-pasid_activated are defined only if
CONFIG_IOMMU_SUPPORT is defined.

> +	if (user_mode(regs) && current->mm->pasid && !current->pasid_activated) {

Maybe need to add "&& cpu_feature_enabled(X86_FEATURE_ENQCMD)" because
the IA32_PASID MSR is only used when ENQCMD is enabled?

> +		current->pasid_activated = 1;
> +		wrmsrl(MSR_IA32_PASID, current->mm->pasid | MSR_IA32_PASID_VALID);
> +		return;
> +	}
> +

+endif

>  	cond_local_irq_enable(regs);
>  
>  	if (static_cpu_has(X86_FEATURE_UMIP)) {

Thanks.

-Fenghua
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
