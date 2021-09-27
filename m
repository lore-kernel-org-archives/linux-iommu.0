Return-Path: <SRS0=QBaT=OR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54754C433FE
	for <iommu@archiver.kernel.org>; Mon, 27 Sep 2021 21:02:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBAA161178
	for <iommu@archiver.kernel.org>; Mon, 27 Sep 2021 21:02:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CBAA161178
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 89CEB404B8;
	Mon, 27 Sep 2021 21:02:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xltt21meS2st; Mon, 27 Sep 2021 21:02:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5A6F140053;
	Mon, 27 Sep 2021 21:02:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13A43C001C;
	Mon, 27 Sep 2021 21:02:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7FF77C000F
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 21:02:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 67B1740053
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 21:02:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1gdKNGuU9t_l for <iommu@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 21:02:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BE821401BC
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 21:02:50 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="204053401"
X-IronPort-AV: E=Sophos;i="5.85,327,1624345200"; d="scan'208";a="204053401"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2021 14:02:50 -0700
X-IronPort-AV: E=Sophos;i="5.85,327,1624345200"; d="scan'208";a="518731694"
Received: from agluck-desk2.sc.intel.com (HELO
 agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2021 14:02:50 -0700
Date: Mon, 27 Sep 2021 14:02:48 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 4/8] x86/traps: Demand-populate PASID MSR via #GP
Message-ID: <YVIxeBh3IKYYK711@agluck-desk2.amr.corp.intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-5-fenghua.yu@intel.com>
 <1aae375d-3cd4-4ab8-9c64-9e387916e6c0@www.fastmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1aae375d-3cd4-4ab8-9c64-9e387916e6c0@www.fastmail.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
 "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
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

On Thu, Sep 23, 2021 at 04:17:05PM -0700, Andy Lutomirski wrote:
> > +	fpregs_lock();
> > +
> > +	/*
> > +	 * If the task's FPU doesn't need to be loaded or is valid, directly
> > +	 * write the IA32_PASID MSR. Otherwise, write the PASID state and
> > +	 * the MSR will be loaded from the PASID state before returning to
> > +	 * the user.
> > +	 */
> > +	if (!test_thread_flag(TIF_NEED_FPU_LOAD) ||
> > +	    fpregs_state_valid(fpu, smp_processor_id())) {
> > +		wrmsrl(MSR_IA32_PASID, msr_val);
> 
> Let me try to decode this.
> 
> If the current task's FPU state is live or if the state is in memory but the CPU regs just happen to match the copy in memory, then write the MSR.  Else write the value to memory.
> 
> This is wrong.  If !TIF_NEED_FPU_LOAD && fpregs_state_valid, you MUST NOT MODIFY FPU STATE.  This is not negotiable -- you will break coherence between CPU regs and the memory image.  The way you modify the current task's state is either you modify it in CPU regs (if the kernel knows that the CPU regs are the one and only source of truth) OR you modify it in memory and invalidate any preserved copies (by zapping last_cpu). 
> 
> In any event, that particular bit of logic really doesn't belong in here -- it belongs in some helper that gets it right, once.

Andy,

A helper sounds like a good idea. Can you flesh out what
you would like that to look like?

Is it just the "where is the live register state?" so the
above could be written:

	if (xsave_state_in_memory(args ...))
		update pasid bit of xsave state in memory
	else
		wrmsrl(MSR_IA32_PASID, msr_val);

Or are you thinking of a helper that does both the check
and the update ... so the code here could be:

	update_one_xsave_feature(XFEATURE_PASID, &msr_val, sizeof(msr_val));

With the helper being something like:

void update_one_xsave_feature(enum xfeature xfeature, void *data, size_t size)
{
	if (xsave_state_in_memory(args ...)) {
		addr = get_xsave_addr(xsave, xfeature);
		memcpy(addr, data, size);
		xsave->header.xfeatures |= (1 << xfeature);
		return;
	}

	switch (xfeature) {
	case XFEATURE_PASID:
		wrmsrl(MSR_IA32_PASID, *(u64 *)data);
		break;

	case each_of_the_other_XFEATURE_enums:
		code to update registers for that XFEATURE
	}
}

either way needs the definitive correct coding for xsave_state_in_memory()

-Tony
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
