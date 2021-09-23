Return-Path: <SRS0=900o=ON=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAB1C433EF
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 17:48:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B3FD6103D
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 17:48:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0B3FD6103D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CF8C3606B3;
	Thu, 23 Sep 2021 17:48:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aIoQarQ35bNH; Thu, 23 Sep 2021 17:48:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A102D606EA;
	Thu, 23 Sep 2021 17:48:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C66BC0011;
	Thu, 23 Sep 2021 17:48:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81625C000D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 17:48:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6A26380E7B
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 17:48:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="0UJ1kq8z";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="ORk/j6uy"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wzVkVHLtiAZe for <iommu@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 17:48:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A31BF80C97
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 17:48:15 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1632419292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jI90BA5MPkAckY4vCCiww4UBg58P9vuxvJTxiYDoROo=;
 b=0UJ1kq8zXk/55UFzhAZk8Pa/XZuXjzCVfxiIxP2wPsrRq/WS8NctFN9pPIrs3nmofqPIP7
 H2aPjzRh9GR+G9Cdb8xTKWQufz1VHAQ6dujOII5dU+SvvFZ6ykivpnYLA/Ah1uTOZt/ulB
 kNKfoZsD3Kb4/+Vx0LNVNygBQ0+ky6S5krGcltgbWTDxsI4dzNlM68MNSkDxrHF0QykUAA
 O9pkfxEdPXUb/iI1LEehs5tBa8v8bTd9tEmIovUEIpBseIU/ZySvqgn8125Dhvh8w0phry
 n1W85HXgx53+fXcgANboDgJUTbFKkNRPO1pfr3pzAHoKKz5LPPteZ7/TGQJxSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1632419292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jI90BA5MPkAckY4vCCiww4UBg58P9vuxvJTxiYDoROo=;
 b=ORk/j6uylsTqc5jG0yKd1pGXrqufsWVy4PgKm8KzRi0t/b5TInyrmgTwhDGlN5E+6QEECX
 z2wrzbL+gvYV1XCQ==
To: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH 5/8] x86/mmu: Add mm-based PASID refcounting
In-Reply-To: <YUyuEjlrcOeCp4qQ@agluck-desk2.amr.corp.intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-6-fenghua.yu@intel.com> <87y27nfjel.ffs@tglx>
 <YUyuEjlrcOeCp4qQ@agluck-desk2.amr.corp.intel.com>
Date: Thu, 23 Sep 2021 19:48:11 +0200
Message-ID: <87o88jfajo.ffs@tglx>
MIME-Version: 1.0
Cc: Fenghua Yu <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, Andy Lutomirski <luto@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>
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

On Thu, Sep 23 2021 at 09:40, Tony Luck wrote:
> On Thu, Sep 23, 2021 at 04:36:50PM +0200, Thomas Gleixner wrote:
>> This code is again defining that PASID is entirely restricted to
>> INTEL. It's true, that no other vendor supports this, but PASID is
>> a non-vendor specific concept.
>> 
>> Sticking this into INTEL code means that any other PASID implementation
>> has to rip it out again from INTEL code and make it a run time property.
>> 
>> The refcounting issue should be the same for all PASID mechanisms which
>> attach PASID to a mm. What's INTEL specific about that?
>> 
>> So can we pretty please do that correct right away?
>
> It's a bit messy (surprise).
>
> There are two reasons to hold a refcount on a PASID
>
> 1) The process has done a bind on a device that uses PASIDs
>
> 	This one isn't dependent on Intel.

Yep.

> 2) A task within a process is using ENQCMD (and thus holds
>    a reference on the PASID because IA32_PASID MSR for this
>    task has the PASID value loaded with the enable bit set).
>
> 	This is (currently) Intel specific (until others
> 	implement an ENQCMD-like feature to allow apps to
> 	access PASID enabled devices without going through
> 	the OS).

Right, but all it does is to grab another reference on the PASID and if
the task exits it needs to be dropped, right?

So you already added 'has_valid_pasid' to task_struct, which is a
misnomer btw. The meaning of this flag is that the task is actually
using the PASID (in the ENQCMD case written to the MSR) beyond the
purposes of the PASID which is attached to current->mm.

But the information which is important from a pasid resource management
POV is whether the task actually holds a seperate refcount on the PASID
or not. That's completely generic. It does not matter whether the task
uses it to populate the IA32_PASID_MSR or to just keeps it in memory
just because it can. The point is that is holds a refcount.

So we can have a generic interface:

int iommu_pasid_get_task_ref()
{
        if (current->holds_pasid_ref)
        	return -EYOUGOTONEALREADY;

	if (!has_pasid(current->mm)
		return -EWHATAREYOUASKINGFOR;

	if (!iommu->pasid_get_ref)
		return -EHOWDIDYOUMAKEUPAPASID;

	if (iommu->pasid_get_ref())
        	return -ETHEIOMMUDOESNOTLIKEYOU;
        
        current->holds_pasid_ref = true;
        return 0;
}

Actually letting this return a bool should be good enough, but you get
the idea.

void iommu_pasid_put_task_ref()
{
        if (!current->holds_pasid_ref)
        	return;
        current->holds_pasid_ref = false;
	iommu->pasid_put_ref();
}

Which makes the exception handling in traps.c the real x86/intel
specific muck:

bool fixup_pasid_exception(...)
{
        /* ENCQMD and future muck */
	if (!per_task_pasid_usage_enabled())
        	return false;
        if (iommu_pasid_get_ref())
        	return false;
        fpu_write_task_pasid();
        return true;
}

fpu_write_task_pasid() can just grab the pasid from current->mm->pasid
and be done with it.

The task exit code can just call iommu_pasid_put_task_ref() from the
generic code and not from within x86.

That means you want in Kconfig:

     PASID_TASK_REFS
     bool

and select that when a IOMMU supporting it is enabled and provide either
the proper protypes or stub functions depending on that.

Hmm?

Thanks,

        tglx




_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
