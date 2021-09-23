Return-Path: <SRS0=900o=ON=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF026C433F5
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 07:03:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 502A261131
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 07:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 502A261131
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 11607406FE;
	Thu, 23 Sep 2021 07:03:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wXQxLs92bz_3; Thu, 23 Sep 2021 07:03:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8152F406F1;
	Thu, 23 Sep 2021 07:03:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 640B2C0011;
	Thu, 23 Sep 2021 07:03:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2EACAC000D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 07:03:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 114D661519
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 07:03:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ivdJQGY8tOKD for <iommu@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 07:03:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8370461540
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 07:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=yBNicDjw8WK7MOJLUTRpaRMtfJjNW3VolUiGgcMY76E=; b=oaFb+XMbK85Xxum8z8ebeFAOZ2
 d5COXc8LI5sfH9MwypwQP5Catqv3zAu2Br/kxPWaVGeqpUkqqvgLr4/3f9QNydMeyOm2FqQfj8zx4
 e9K2Acx+dvXmmO85PVYoAIHx/kL3LRfUUNYMhlwtjrfG5KhQWC8A+GvvkiWrzEDfY8tzhAAkdHqcz
 ksgm7aauQUaUD1I6ze8m79+0+6Ze6FlQ/88pb1R8hfzKzqB/a1zhXXj/Q2+zSkNlima4yMDUaandF
 q3XfXBhPfC584OC8vRXSZGSeJrNvVvd5jkgyHbgHq223J7EribWdEiICEHozaROBGYT8jhhjL/3gf
 xkAUqz2A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mTIlB-005ATk-1G; Thu, 23 Sep 2021 07:03:09 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D806F30031A;
 Thu, 23 Sep 2021 09:03:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 75EB72133B1A7; Thu, 23 Sep 2021 09:03:07 +0200 (CEST)
Date: Thu, 23 Sep 2021 09:03:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH 4/8] x86/traps: Demand-populate PASID MSR via #GP
Message-ID: <YUwmq1M0yIio5CZC@hirez.programming.kicks-ass.net>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-5-fenghua.yu@intel.com>
 <20210922210722.GV4323@worktop.programming.kicks-ass.net>
 <20210922211145.GF5106@worktop.programming.kicks-ass.net>
 <abfbdfbc9a68477f985eeb4192839fca@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <abfbdfbc9a68477f985eeb4192839fca@intel.com>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, "Shankar,
 Ravi V" <ravi.v.shankar@intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, "Hansen,
 Dave" <dave.hansen@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Andy Lutomirski <luto@kernel.org>,
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

On Wed, Sep 22, 2021 at 09:26:10PM +0000, Luck, Tony wrote:
> >> > +static bool fixup_pasid_exception(void)
> >> > +{
> >> > +	if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
> >> > +		return false;
> >> > +
> >> > +	return __fixup_pasid_exception();
> >> > +}
> >
> > That is, shouldn't the above at the very least decode the instruction
> > causing the #GP and check it's this ENQCMD thing?
> 
> It can't reliably do that because some other thread in the process may
> have re-written the memory that regs->ip points at (bizarre case, but
> I think Dave Hansen brought it up).

I don't buy that argument, any cross modifying code gets to keep the
pieces in that case.

> So it would just add extra code, and still only be a hint.
> 
> Without the check this sequence is possible:
> 
> 1) Process binds an accelerator (so mm->pasid is set)
> 2) Task in the process executes something other than ENQCMD that gets a #GP
> 3) Kernel says "Oh, mm->pasid is set, I'll initialize the IA32_PASID MSR to see if that fixes it"
> 4) Nope. Re-executing the instruction at step #2 just gives another #GP
> 5) Kernel says "I already set IA32_PASID, so this must be something else ... do regular #GP actions"
> 
> Now if the task catches the signal that results from step #5 and avoids termination, it will have
> IA32_PASID set ... but to the right value should it go on to actually execute ENQCMD at some
> future point.
> 
> So the corner case from not knowing whether this #GP was from ENQCMD or not is harmless.

And all that *really* should be a in a comment near there, because I'm
100% sure I'll get confused and wonder about that very same thing the
next time I see that code.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
