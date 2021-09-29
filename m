Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FB2C433EF
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 12:28:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 955A961406
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 12:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 955A961406
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A48482F84;
	Wed, 29 Sep 2021 12:28:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id px_rs0jAEmd7; Wed, 29 Sep 2021 12:28:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 40DE5829DC;
	Wed, 29 Sep 2021 12:28:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C00DC000F;
	Wed, 29 Sep 2021 12:28:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6B1AC000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 12:28:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A8C074160B
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 12:28:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="Zig++SWZ";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="OVL3UJh7"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B7Y7cQ4wQeK9 for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 12:28:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E9282415B2
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 12:28:13 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1632918490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e1BMtnJgV70KLngTKgu2ZON12D6kuHuc1YBGUlYYeH4=;
 b=Zig++SWZv0uFvNn6iGF13hJygMX5H996xpm+TsQquNkXhCAmVkqTaO9mbz8DV2f/X/auqo
 gUm0Ss4GO8/nlt+ATF4qvB1V4XsR7HAUeJ57s5CtiWn5ahPg/us3yQPPK3FX1v4rcrAnwk
 rAALyWUnPCCw3LSPtmT54SScsGe1MYpPPmDUe4ZPRFW8BC8roV/YbHkUhPE47Am9hIgvCF
 nRy2uMjRf6Rg3E5PcPrARtPJ5pLWJMRMP6EzoqOwbcF1NOzoIMtUoxOQX+E66dKctUPRMZ
 l1p+xUwEYPnAxjpLh4KCF/MSU4n9rZ4YD3tJFHFvvbW1EodR0jR24DNSaGWT0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1632918490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e1BMtnJgV70KLngTKgu2ZON12D6kuHuc1YBGUlYYeH4=;
 b=OVL3UJh7xDcOsC045ZS9rtxR4krp71fKnSTY/BYUAQF7wAfq7q4/bwyT+V0XI9fr4dGDlf
 DzTdxqe9f01dfrDA==
To: Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 5/8] x86/mmu: Add mm-based PASID refcounting
In-Reply-To: <YVQ3wc/XjeOHpGCX@hirez.programming.kicks-ass.net>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-6-fenghua.yu@intel.com> <87y27nfjel.ffs@tglx>
 <YUyuEjlrcOeCp4qQ@agluck-desk2.amr.corp.intel.com> <87o88jfajo.ffs@tglx>
 <87k0j6dsdn.ffs@tglx> <YU3414QT0J7EN4w9@agluck-desk2.amr.corp.intel.com>
 <a77ee33c-6fa7-468c-8fc0-a0a2ce725e75@www.fastmail.com>
 <YVQ3wc/XjeOHpGCX@hirez.programming.kicks-ass.net>
Date: Wed, 29 Sep 2021 14:28:09 +0200
Message-ID: <87r1d78t2e.ffs@tglx>
MIME-Version: 1.0
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>, "Shankar,
 Ravi V" <ravi.v.shankar@intel.com>, the arch/x86 maintainers <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>
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

On Wed, Sep 29 2021 at 11:54, Peter Zijlstra wrote:
> On Fri, Sep 24, 2021 at 04:03:53PM -0700, Andy Lutomirski wrote:
>> I think the perfect and the good are a bit confused here. If we go for
>> "good", then we have an mm owning a PASID for its entire lifetime.  If
>> we want "perfect", then we should actually do it right: teach the
>> kernel to update an entire mm's PASID setting all at once.  This isn't
>> *that* hard -- it involves two things:
>> 
>> 1. The context switch code needs to resync PASID.  Unfortunately, this
>> adds some overhead to every context switch, although a static_branch
>> could minimize it for non-PASID users.
>
>> 2. A change to an mm's PASID needs to sent an IPI, but that IPI can't
>> touch FPU state.  So instead the IPI should use task_work_add() to
>> make sure PASID gets resynced.
>
> What do we need 1 for? Any PASID change can be achieved using 2 no?
>
> Basically, call task_work_add() on all relevant tasks [1], then IPI
> spray the current running of those and presto.
>
> [1] it is nigh on impossible to find all tasks sharing an mm in any sane
> way due to CLONE_MM && !CLONE_THREAD.

Why would we want any of that at all?

  Process starts, no PASID assigned.

  bind to device -> PASID is allocated and assigned to the mm

  some task of the process issues ENQCMD -> #GP -> write PASID MSR

  After that the PASID is saved and restored as part of the XSTATE and
  there is no extra overhead in context switch or return to user space.

  All tasks of the process which did never use ENQCMD don't care and their
  PASID xstate is in init state.

There is absolutely no point in enforcing that all tasks of the process
have the PASID activated immediately when it is assigned. If they need
it they get it via the #GP fixup and everything just works.

Looking at that patch again, none of this muck in fpu__pasid_write() is
required at all. The whole exception fixup is:

    if (!user_mode(regs))
             return false;

    if (!current->mm->pasid)
             return false;

    if (current->pasid_activated)
    	     return false;

    wrmsrl(MSR_IA32_PASID, current->mm->pasid);
    current->pasid_activated = true;
    return true;

There is zero requirement to look at TIF_NEED_FPU_LOAD or
fpregs_state_valid() simply because the #GP comes straight from user
space which means the FPU registers contain the current tasks user space
state.

If TIF_NEED_FPU_LOAD would be set or fpregs_state_valid() would be false
after the user_mode() check then this would simply be a bug somewhere
else and has nothing to do with this PASID fixup.

So no need for magic update_one_xstate_feature() wrappers, no
concurrency concerns, nothing.

It's that simple, really. Anything more complex is just a purely
academic exercise which creates more problems than it solves.

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
