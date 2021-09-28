Return-Path: <SRS0=IJZW=OS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F4BC433EF
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 23:50:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31201613B5
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 23:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 31201613B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F0FF660BB5;
	Tue, 28 Sep 2021 23:50:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I3mbpLXfahvL; Tue, 28 Sep 2021 23:50:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EAECD60BB1;
	Tue, 28 Sep 2021 23:50:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7575CC001C;
	Tue, 28 Sep 2021 23:50:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D0A1C000D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 23:50:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0593060BB2
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 23:50:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1CeUiJSrgp7h for <iommu@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 23:50:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 44DB260BB1
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 23:50:45 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="310377418"
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; d="scan'208";a="310377418"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2021 16:50:44 -0700
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; d="scan'208";a="538605950"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2021 16:50:44 -0700
Date: Tue, 28 Sep 2021 23:50:37 +0000
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH 4/8] x86/traps: Demand-populate PASID MSR via #GP
Message-ID: <YVOp60LOL+bfh3iT@otcwcpicx3.sc.intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-5-fenghua.yu@intel.com>
 <1aae375d-3cd4-4ab8-9c64-9e387916e6c0@www.fastmail.com>
 <YVIxeBh3IKYYK711@agluck-desk2.amr.corp.intel.com>
 <035290e6-d914-a113-ea6c-e845d71069cf@intel.com>
 <YVNj8sm8iectc6iU@agluck-desk2.amr.corp.intel.com>
 <3f97b77e-a609-997b-3be7-f44ff7312b0d@intel.com>
 <YVN652x14dMgyE85@agluck-desk2.amr.corp.intel.com>
 <f6014b16-7b4c-cbb6-c975-1ec34092956f@intel.com>
 <YVOg7zgpdQlc7Zjt@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YVOg7zgpdQlc7Zjt@agluck-desk2.amr.corp.intel.com>
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

Hi, Tony,

On Tue, Sep 28, 2021 at 04:10:39PM -0700, Luck, Tony wrote:
> Moving beyond pseudo-code and into compiles-but-probably-broken-code.
> 
> 
> The intent of the functions below is that Fenghua should be able to
> do:
> 
> void fpu__pasid_write(u32 pasid)
> {
> 	u64 msr_val = pasid | MSR_IA32_PASID_VALID;
> 	struct ia32_pasid_state *addr;
> 
> 	addr = begin_update_one_xsave_feature(current, XFEATURE_PASID, true);
> 	addr->pasid = msr_val;
> 	finish_update_one_xsave_feature(current);
> }
> 
> So here's the two new functions that would be added to
> arch/x86/kernel/fpu/xstate.c
> 
> ----
> 
> void *begin_update_one_xsave_feature(struct task_struct *tsk,
>                                      enum xfeature xfeature, bool full)
> {
>         struct xregs_state *xsave = &tsk->thread.fpu.state.xsave;
>         struct xregs_state *xinit = &init_fpstate.xsave;
>         u64 fmask = 1ull << xfeature;
>         void *addr;
> 
>         BUG_ON(!(xsave->header.xcomp_bv & fmask));
> 
>         fpregs_lock();
> 
>         addr = __raw_xsave_addr(xsave, xfeature);
> 
>         if (full || tsk != current) {
>                 memcpy(addr, __raw_xsave_addr(xinit, xfeature), xstate_sizes[xfeature]);
>                 goto out;
>         }
> 
> 	/* could optimize some cases where xsaves() isn't fastest option */
>         if (!(xsave->header.xfeatures & fmask))
>                 xsaves(xsave, fmask);

If xfeatures's feature bit is 0, xsaves will not write its init value to the
memory due to init optimization. So the xsaves will do nothing and the
state is not initialized and may have random data.

> 
> out:
>         xsave->header.xfeatures |= fmask;
>         return addr;
> }
> 
> void finish_update_one_xsave_feature(struct task_struct *tsk)
> {
>         set_ti_thread_flag(task_thread_info(tsk), TIF_NEED_FPU_LOAD);

Setting TIF_NEED_FPU_LOAD cannot guaranteed to execute XRSTORS on exiting
to user. In fpregs_restore_userregs():
	if (!fpregs_state_valid(fpu, cpu)) {
		...
                __restore_fpregs_from_fpstate(&fpu->state, mask);
		...
	}

fpregs state should be invalid to get the XRSTROS executed.

So setting TIF_NEED_FPU_LOAD may get the FPU register unchanged on exiting
to user.


>         fpregs_unlock();
> }

Thanks.

-Fenghua
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
