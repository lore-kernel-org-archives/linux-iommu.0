Return-Path: <SRS0=IJZW=OS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7869C433FE
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 20:28:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 661BA6127C
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 20:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 661BA6127C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A8B640105;
	Tue, 28 Sep 2021 20:28:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dmsdBehmypHA; Tue, 28 Sep 2021 20:28:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D37DA4159B;
	Tue, 28 Sep 2021 20:28:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6B55C0011;
	Tue, 28 Sep 2021 20:28:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED817C000D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 20:28:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C92C160B5D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 20:28:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PdU4RRr-FPaz for <iommu@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 20:28:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C7D02606B6
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 20:28:25 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="211882297"
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; d="scan'208";a="211882297"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2021 13:28:25 -0700
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; d="scan'208";a="554291749"
Received: from agluck-desk2.sc.intel.com (HELO
 agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2021 13:28:24 -0700
Date: Tue, 28 Sep 2021 13:28:23 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 4/8] x86/traps: Demand-populate PASID MSR via #GP
Message-ID: <YVN652x14dMgyE85@agluck-desk2.amr.corp.intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-5-fenghua.yu@intel.com>
 <1aae375d-3cd4-4ab8-9c64-9e387916e6c0@www.fastmail.com>
 <YVIxeBh3IKYYK711@agluck-desk2.amr.corp.intel.com>
 <035290e6-d914-a113-ea6c-e845d71069cf@intel.com>
 <YVNj8sm8iectc6iU@agluck-desk2.amr.corp.intel.com>
 <3f97b77e-a609-997b-3be7-f44ff7312b0d@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3f97b77e-a609-997b-3be7-f44ff7312b0d@intel.com>
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

On Tue, Sep 28, 2021 at 12:19:22PM -0700, Dave Hansen wrote:
> On 9/28/21 11:50 AM, Luck, Tony wrote:
> > On Mon, Sep 27, 2021 at 04:51:25PM -0700, Dave Hansen wrote:
> ...
> >> 1. Hide whether we need to write to real registers
> >> 2. Hide whether we need to update the in-memory image
> >> 3. Hide other FPU infrastructure like the TIF flag.
> >> 4. Make the users deal with a *whole* state in the replace API
> > 
> > Is that difference just whether you need to save the
> > state from registers to memory (for the "update" case)
> > or not (for the "replace" case ... where you can ignore
> > the current register, overwrite the whole per-feature
> > xsave area and mark it to be restored to registers).
> > 
> > If so, just a "bool full" argument might do the trick?
> 
> I want to be able to hide the complexity of where the old state comes
> from.  It might be in registers or it might be in memory or it might be
> *neither*.  It's possible we're running with stale register state and a
> current->...->xsave buffer that has XFEATURES&XFEATURE_FOO 0.
> 
> In that case, the "old" copy might be memcpy'd out of the init_task.
> Or, for pkeys, we might build it ourselves with init_pkru_val.

So should there be an error case if there isn't an "old" state, and
the user calls:

	p = begin_update_one_xsave_feature(XFEATURE_something, false);

Maybe instead of an error, just fill it in with the init state for the feature?

> > Also - you have a "tsk" argument in your pseudo code. Is
> > this needed? Are there places where we need to perform
> > these operations on something other than "current"?
> 
> Two cases come to mind:
> 1. Fork/clone where we are doing things to our child's XSAVE buffer
> 2. ptrace() where we are poking into another task's state
> 
> ptrace() goes for the *whole* buffer now.  I'm not sure it would need
> this per-feature API.  I just call it out as something that we might
> need in the future.

Ok - those seem ok ... it is up to the caller to make sure that the
target task is in some "not running, and can't suddenly start running"
state before calling these functions.

> 
> > pseudo-code:
> > 
> > void *begin_update_one_xsave_feature(enum xfeature xfeature, bool full)
> > {
> > 	void *addr;
> > 
> > 	BUG_ON(!(xsave->header.xcomp_bv & xfeature));
> > 
> > 	addr = __raw_xsave_addr(xsave, xfeature);
> > 
> > 	fpregs_lock();
> > 
> > 	if (full)
> > 		return addr;
> 
> If the feature is marked as in the init state in the buffer
> (XSTATE_BV[feature]==0), this addr *could* contain total garbage.  So,
> we'd want to make sure that the memory contents have the init state
> written before handing them back to the caller.  That's not strictly
> required if the user is writing the whole thing, but it's the nice thing
> to do.

Nice guys waste CPU cycles writing to memory that is just going to get
written again.

> 
> > 	if (xfeature registers are "live")
> > 		xsaves(xstate, 1 << xfeature);
> 
> One little note: I don't think we would necessarily need to do an XSAVES
> here.  For PKRU, for instance, we could just do a rdpkru.

Like this?

	if (tsk == current) {
		switch (xfeature) {
		case XFEATURE_PKRU:
			*(u32 *)addr = rdpkru();
			break;
		case XFEATURE_PASID:
			rdmsrl(MSR_IA32_PASID, msr);
			*(u64 *)addr = msr;
			break;
		... any other "easy" states ...
		default:
			xsaves(xstate, 1 << xfeature);
			break;
		}
	}

> 
> > 	return addr;
> > }
> > 
> > void finish_update_one_xsave_feature(enum xfeature xfeature)
> > {
> > 	mark feature modified
> 
> I think we'd want to do this at the "begin" time.  Also, do you mean we
> should set XSTATE_BV[feature]?

Begin? End? It's all inside fpregs_lock(). But whatever seems best.

Yes, I think that this means set XSTATE_BV[feature] ... but I'm
relying on you as the xsave expert to help get the subtle bits right so
the Andy Lutomirski can smile at this code.

> > 	set TIF bit
> 
> Since the XSAVE buffer was updated, it now contains the canonical FPU
> state.  It may have diverged from the register state, thus we need to
> set TIF_NEED_FPU_LOAD.

Yes, that's the TIF bit my pseudo-code intended.

> It's also worth noting that we *could*:
> 
> 	xrstors(xstate, 1<<xfeature);
> 
> as well.  That would bring the registers back up to day and we could
> keep TIF_NEED_FPU_LOAD==0.

Only makes sense if "tsk == current". But does this help. The work seems
to be the same whether we do it now, or later. We don't know for sure
that we will directly return to the task. We might context switch to
another task, so loading the state into registers now would just be
wasted time.

> 
> > 	fpregs_unlock();
> > }

-Tony
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
