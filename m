Return-Path: <SRS0=IJZW=OS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE529C433FE
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 18:50:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 649A661361
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 18:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 649A661361
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 29F3260B34;
	Tue, 28 Sep 2021 18:50:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4CPgHkcwTCxO; Tue, 28 Sep 2021 18:50:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0C9AA60B24;
	Tue, 28 Sep 2021 18:50:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D35A9C0011;
	Tue, 28 Sep 2021 18:50:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8BBD6C000D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 18:50:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 87CCE4149B
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 18:50:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1HwAp0wqOJf1 for <iommu@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 18:50:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A43DA41486
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 18:50:30 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="288439817"
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; d="scan'208";a="288439817"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2021 11:50:30 -0700
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; d="scan'208";a="519215652"
Received: from agluck-desk2.sc.intel.com (HELO
 agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2021 11:50:29 -0700
Date: Tue, 28 Sep 2021 11:50:26 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 4/8] x86/traps: Demand-populate PASID MSR via #GP
Message-ID: <YVNj8sm8iectc6iU@agluck-desk2.amr.corp.intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-5-fenghua.yu@intel.com>
 <1aae375d-3cd4-4ab8-9c64-9e387916e6c0@www.fastmail.com>
 <YVIxeBh3IKYYK711@agluck-desk2.amr.corp.intel.com>
 <035290e6-d914-a113-ea6c-e845d71069cf@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <035290e6-d914-a113-ea6c-e845d71069cf@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
 "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Jacob Jun Pan <jacob.jun.pan@intel.com>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

On Mon, Sep 27, 2021 at 04:51:25PM -0700, Dave Hansen wrote:
> That's close to what we want.
> 
> The size should probably be implicit.  If it isn't implicit, it needs to
> at least be double-checked against the state sizes.
> 
> Not to get too fancy, but I think we also want to have a "replace"
> operation which is separate from the "update".  Think of a case where
> you are trying to set a bit:
> 
> 	struct pkru_state *pk = start_update_xstate(tsk, XSTATE_PKRU);
> 	pk->pkru |= 0x100;
> 	finish_update_xstate(tsk, XSTATE_PKRU, pk);
> 
> versus setting a whole new value:
> 
> 	struct pkru_state *pk = start_replace_xstate(tsk, XSTATE_PKRU);
> 	memset(pkru, sizeof(*pk), 0);
> 	pk->pkru = 0x1234;
> 	finish_replace_xstate(tsk, XSTATE_PKRU, pk);
> 
> They look similar, but they actually might have very different costs for
> big states like AMX.  We can also do some very different debugging for
> them.  In normal operation, these _can_ just return pointers directly to
> the fpu...->xstate in some case.  But, if we're debugging, we could
> kmalloc() a buffer and do sanity checking before it goes into the task
> buffer.
> 
> We don't have to do any of that fancy stuff now.  We don't even need to
> do an "update" if all we need for now for XFEATURE_PASID is a "replace".
> 
> 1. Hide whether we need to write to real registers
> 2. Hide whether we need to update the in-memory image
> 3. Hide other FPU infrastructure like the TIF flag.
> 4. Make the users deal with a *whole* state in the replace API

Is that difference just whether you need to save the
state from registers to memory (for the "update" case)
or not (for the "replace" case ... where you can ignore
the current register, overwrite the whole per-feature
xsave area and mark it to be restored to registers).

If so, just a "bool full" argument might do the trick?

Also - you have a "tsk" argument in your pseudo code. Is
this needed? Are there places where we need to perform
these operations on something other than "current"?

pseudo-code:

void *begin_update_one_xsave_feature(enum xfeature xfeature, bool full)
{
	void *addr;

	BUG_ON(!(xsave->header.xcomp_bv & xfeature));

	addr = __raw_xsave_addr(xsave, xfeature);

	fpregs_lock();

	if (full)
		return addr;

	if (xfeature registers are "live")
		xsaves(xstate, 1 << xfeature);

	return addr;
}

void finish_update_one_xsave_feature(enum xfeature xfeature)
{
	mark feature modified
	set TIF bit
	fpregs_unlock();
}

-Tony
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
