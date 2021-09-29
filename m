Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E146C433EF
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 16:59:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3AC061439
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 16:59:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B3AC061439
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 82B704072A;
	Wed, 29 Sep 2021 16:59:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id muZRs04--CGb; Wed, 29 Sep 2021 16:59:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2BED240723;
	Wed, 29 Sep 2021 16:59:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8DEBC000F;
	Wed, 29 Sep 2021 16:59:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC97DC000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 16:59:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BA5FE82443
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 16:59:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xliw5DwxTG9p for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 16:59:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4536E82404
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 16:59:44 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40053613D1;
 Wed, 29 Sep 2021 16:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632934783;
 bh=NIb8p1udmU2cyyxgdKTASy2CHdIukYGs/zoSTQfFkTo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=JUXaf/PU8zljz7WC6Nq05HvgArXrLqToUQ1ZwS6h6AisXMXNfCYy1rRmH/E9gILcm
 fBe8b58GTWuoDqSGlWgsbKMZAX0BSNwQBPuQgZ+yIlXKCSA7MUZkL1fqld8f8nY3JK
 72grjrOBGxS4d74bnNQ2kyZR8nSEZ9PmcUSts6Janc2AADE1d/g/ZcZ8MNvkxc4OuX
 lIFCscyzIf6jaD200C6wFbHJ9qEUj/lzukmjwSpfBAdRsZmrko55fyRgg62RhP/0no
 AHV/HzoAzi8A/LxCNU+iYq3GB2898pCWft87k/IL9O5AGmVIyiZlwXLhUeUxjs2Gtp
 QcK7gWdplJdNw==
Message-ID: <75e95acc-6730-ddcf-d722-66e575076256@kernel.org>
Date: Wed, 29 Sep 2021 09:59:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 5/8] x86/mmu: Add mm-based PASID refcounting
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-6-fenghua.yu@intel.com> <87y27nfjel.ffs@tglx>
 <YUyuEjlrcOeCp4qQ@agluck-desk2.amr.corp.intel.com> <87o88jfajo.ffs@tglx>
 <87k0j6dsdn.ffs@tglx> <YU3414QT0J7EN4w9@agluck-desk2.amr.corp.intel.com>
 <a77ee33c-6fa7-468c-8fc0-a0a2ce725e75@www.fastmail.com>
 <YVQ3wc/XjeOHpGCX@hirez.programming.kicks-ass.net> <87r1d78t2e.ffs@tglx>
From: Andy Lutomirski <luto@kernel.org>
In-Reply-To: <87r1d78t2e.ffs@tglx>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 9/29/21 05:28, Thomas Gleixner wrote:
> On Wed, Sep 29 2021 at 11:54, Peter Zijlstra wrote:
>> On Fri, Sep 24, 2021 at 04:03:53PM -0700, Andy Lutomirski wrote:
>>> I think the perfect and the good are a bit confused here. If we go for
>>> "good", then we have an mm owning a PASID for its entire lifetime.  If
>>> we want "perfect", then we should actually do it right: teach the
>>> kernel to update an entire mm's PASID setting all at once.  This isn't
>>> *that* hard -- it involves two things:
>>>
>>> 1. The context switch code needs to resync PASID.  Unfortunately, this
>>> adds some overhead to every context switch, although a static_branch
>>> could minimize it for non-PASID users.
>>
>>> 2. A change to an mm's PASID needs to sent an IPI, but that IPI can't
>>> touch FPU state.  So instead the IPI should use task_work_add() to
>>> make sure PASID gets resynced.
>>
>> What do we need 1 for? Any PASID change can be achieved using 2 no?
>>
>> Basically, call task_work_add() on all relevant tasks [1], then IPI
>> spray the current running of those and presto.
>>
>> [1] it is nigh on impossible to find all tasks sharing an mm in any sane
>> way due to CLONE_MM && !CLONE_THREAD.
> 
> Why would we want any of that at all?
> 
>    Process starts, no PASID assigned.
> 
>    bind to device -> PASID is allocated and assigned to the mm
> 
>    some task of the process issues ENQCMD -> #GP -> write PASID MSR
> 
>    After that the PASID is saved and restored as part of the XSTATE and
>    there is no extra overhead in context switch or return to user space.
> 
>    All tasks of the process which did never use ENQCMD don't care and their
>    PASID xstate is in init state.
> 
> There is absolutely no point in enforcing that all tasks of the process
> have the PASID activated immediately when it is assigned. If they need
> it they get it via the #GP fixup and everything just works.
> 
> Looking at that patch again, none of this muck in fpu__pasid_write() is
> required at all. The whole exception fixup is:
> 
>      if (!user_mode(regs))
>               return false;
> 
>      if (!current->mm->pasid)
>               return false;
> 
>      if (current->pasid_activated)
>      	     return false;

<-- preemption or BH here: kaboom.

> 
>      wrmsrl(MSR_IA32_PASID, current->mm->pasid);

This needs the actual sane fpstate writing helper -- see other email.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
