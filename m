Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496ECC433FE
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 00:08:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDF07613E6
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 00:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EDF07613E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF43282E95;
	Wed, 29 Sep 2021 00:08:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S1IYPI-6uvlK; Wed, 29 Sep 2021 00:08:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A349980D20;
	Wed, 29 Sep 2021 00:08:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 755A4C0011;
	Wed, 29 Sep 2021 00:08:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7592C000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 00:08:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DA8534059C
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 00:08:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id offzv7G8OHry for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 00:08:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E6AF64045A
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 00:08:03 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="224899513"
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; d="scan'208";a="224899513"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2021 17:08:02 -0700
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; d="scan'208";a="486731358"
Received: from agluck-desk2.sc.intel.com (HELO
 agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2021 17:08:02 -0700
Date: Tue, 28 Sep 2021 17:08:00 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH 4/8] x86/traps: Demand-populate PASID MSR via #GP
Message-ID: <YVOuYAFaTG6Khotb@agluck-desk2.amr.corp.intel.com>
References: <20210920192349.2602141-5-fenghua.yu@intel.com>
 <1aae375d-3cd4-4ab8-9c64-9e387916e6c0@www.fastmail.com>
 <YVIxeBh3IKYYK711@agluck-desk2.amr.corp.intel.com>
 <035290e6-d914-a113-ea6c-e845d71069cf@intel.com>
 <YVNj8sm8iectc6iU@agluck-desk2.amr.corp.intel.com>
 <3f97b77e-a609-997b-3be7-f44ff7312b0d@intel.com>
 <YVN652x14dMgyE85@agluck-desk2.amr.corp.intel.com>
 <f6014b16-7b4c-cbb6-c975-1ec34092956f@intel.com>
 <YVOg7zgpdQlc7Zjt@agluck-desk2.amr.corp.intel.com>
 <YVOp60LOL+bfh3iT@otcwcpicx3.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YVOp60LOL+bfh3iT@otcwcpicx3.sc.intel.com>
Cc: "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
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

On Tue, Sep 28, 2021 at 11:50:37PM +0000, Fenghua Yu wrote:
> If xfeatures's feature bit is 0, xsaves will not write its init value to the
> memory due to init optimization. So the xsaves will do nothing and the
> state is not initialized and may have random data.

> Setting TIF_NEED_FPU_LOAD cannot guaranteed to execute XRSTORS on exiting
> to user. In fpregs_restore_userregs():
> 	if (!fpregs_state_valid(fpu, cpu)) {
> 		...
>                 __restore_fpregs_from_fpstate(&fpu->state, mask);
> 		...
> 	}
> 
> fpregs state should be invalid to get the XRSTROS executed.
> 
> So setting TIF_NEED_FPU_LOAD may get the FPU register unchanged on exiting
> to user.

Does this help?
Changed lines marked with //<<<<<

-Tony

void *begin_update_one_xsave_feature(struct task_struct *tsk,
				     enum xfeature xfeature, bool full)
{
	struct xregs_state *xsave = &tsk->thread.fpu.state.xsave;
	struct xregs_state *xinit = &init_fpstate.xsave;
	u64 fmask = 1ull << xfeature;
	void *addr;

	BUG_ON(!(xsave->header.xcomp_bv & fmask));

	fpregs_lock();

	addr = __raw_xsave_addr(xsave, xfeature);

	if (full || tsk != current) {
		memcpy(addr, __raw_xsave_addr(xinit, xfeature), xstate_sizes[xfeature]);
		goto out;
	}

	if (!(xsave->header.xfeatures & fmask)) {
		xsave->header.xfeatures |= fmask;	//<<<<<
		xsaves(xsave, fmask);
	}

out:
	xsave->header.xfeatures |= fmask;
	return addr;
}

void finish_update_one_xsave_feature(struct task_struct *tsk)
{
	set_ti_thread_flag(task_thread_info(tsk), TIF_NEED_FPU_LOAD);
	if (tsk == current)				//<<<<<
		__cpu_invalidate_fpregs_state();	//<<<<<
	fpregs_unlock();
}
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
