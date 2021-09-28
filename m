Return-Path: <SRS0=IJZW=OS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C1AC433EF
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 23:10:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A479360EBB
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 23:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A479360EBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D15282925;
	Tue, 28 Sep 2021 23:10:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YvOBHCqXY37j; Tue, 28 Sep 2021 23:10:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 46DBC8294A;
	Tue, 28 Sep 2021 23:10:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1BCB9C000F;
	Tue, 28 Sep 2021 23:10:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4058C000D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 23:10:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AC68F60609
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 23:10:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jlDpOpWUxncn for <iommu@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 23:10:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1A397605EF
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 23:10:41 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="310372943"
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; d="scan'208";a="310372943"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2021 16:10:41 -0700
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; d="scan'208";a="478985758"
Received: from agluck-desk2.sc.intel.com (HELO
 agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2021 16:10:41 -0700
Date: Tue, 28 Sep 2021 16:10:39 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 4/8] x86/traps: Demand-populate PASID MSR via #GP
Message-ID: <YVOg7zgpdQlc7Zjt@agluck-desk2.amr.corp.intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-5-fenghua.yu@intel.com>
 <1aae375d-3cd4-4ab8-9c64-9e387916e6c0@www.fastmail.com>
 <YVIxeBh3IKYYK711@agluck-desk2.amr.corp.intel.com>
 <035290e6-d914-a113-ea6c-e845d71069cf@intel.com>
 <YVNj8sm8iectc6iU@agluck-desk2.amr.corp.intel.com>
 <3f97b77e-a609-997b-3be7-f44ff7312b0d@intel.com>
 <YVN652x14dMgyE85@agluck-desk2.amr.corp.intel.com>
 <f6014b16-7b4c-cbb6-c975-1ec34092956f@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f6014b16-7b4c-cbb6-c975-1ec34092956f@intel.com>
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

Moving beyond pseudo-code and into compiles-but-probably-broken-code.


The intent of the functions below is that Fenghua should be able to
do:

void fpu__pasid_write(u32 pasid)
{
	u64 msr_val = pasid | MSR_IA32_PASID_VALID;
	struct ia32_pasid_state *addr;

	addr = begin_update_one_xsave_feature(current, XFEATURE_PASID, true);
	addr->pasid = msr_val;
	finish_update_one_xsave_feature(current);
}

So here's the two new functions that would be added to
arch/x86/kernel/fpu/xstate.c

----

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

	/* could optimize some cases where xsaves() isn't fastest option */
        if (!(xsave->header.xfeatures & fmask))
                xsaves(xsave, fmask);

out:
        xsave->header.xfeatures |= fmask;
        return addr;
}

void finish_update_one_xsave_feature(struct task_struct *tsk)
{
        set_ti_thread_flag(task_thread_info(tsk), TIF_NEED_FPU_LOAD);
        fpregs_unlock();
}

----

-Tony
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
