Return-Path: <SRS0=Rn8G=OM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD84C433EF
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 21:13:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6884161090
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 21:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6884161090
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 18E02614F4;
	Wed, 22 Sep 2021 21:13:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l2rQpAATbKjz; Wed, 22 Sep 2021 21:13:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DDAB260B85;
	Wed, 22 Sep 2021 21:13:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B30B2C0011;
	Wed, 22 Sep 2021 21:13:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65F07C000D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 21:13:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 54F5C40598
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 21:13:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RjQNtZjDyj2l for <iommu@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 21:13:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8CD5B40121
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 21:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=T9aqR6ds6fZf+ziFJLavcqledvnXK6/xbqEb0NC2lrs=; b=NEYoGGh5giSDV/HksndZuN4zNa
 Po/LERjVXKQBI/dJr5ysIGCq242l11aKwDhMB7GKASgYDOgLnDvSdCKaRxeI0ft4RrXffTd+/RwXl
 50lCYZ6ZQ0cyLk2RzjNvGlMpctJDH3X4GnbnwFUibxYtcpmLoT/9sqiAZIiIOjJfWXdCmIzOBpi/H
 ddPPFCHfgniaDI0aAxkpJA1VbjN9maJhz0J539MwAkWEBPqNZIv80TDr0Oab7wW+uZ/D2R82pXzad
 9EjGnwQRIr6VfgnL4W5v1c9Pd8+K6mOzxhX6C4sAkOy2HmVu3xoW0LbMAnvNn/OoNjNrpREPJZm87
 IkD577VQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=worktop.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mT9Ws-0059St-Hm; Wed, 22 Sep 2021 21:12:15 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
 id 91BCC9811F0; Wed, 22 Sep 2021 23:11:45 +0200 (CEST)
Date: Wed, 22 Sep 2021 23:11:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH 4/8] x86/traps: Demand-populate PASID MSR via #GP
Message-ID: <20210922211145.GF5106@worktop.programming.kicks-ass.net>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-5-fenghua.yu@intel.com>
 <20210922210722.GV4323@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210922210722.GV4323@worktop.programming.kicks-ass.net>
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
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

On Wed, Sep 22, 2021 at 11:07:22PM +0200, Peter Zijlstra wrote:
> On Mon, Sep 20, 2021 at 07:23:45PM +0000, Fenghua Yu wrote:
> > diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> > index a58800973aed..a25d738ae839 100644
> > --- a/arch/x86/kernel/traps.c
> > +++ b/arch/x86/kernel/traps.c
> > @@ -61,6 +61,7 @@
> >  #include <asm/insn.h>
> >  #include <asm/insn-eval.h>
> >  #include <asm/vdso.h>
> > +#include <asm/iommu.h>
> >  
> >  #ifdef CONFIG_X86_64
> >  #include <asm/x86_init.h>
> > @@ -526,6 +527,14 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
> >  	return GP_CANONICAL;
> >  }
> >  
> > +static bool fixup_pasid_exception(void)
> > +{
> > +	if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
> > +		return false;
> > +
> > +	return __fixup_pasid_exception();
> > +}

That is, shouldn't the above at the very least decode the instruction
causing the #GP and check it's this ENQCMD thing?

> >  #define GPFSTR "general protection fault"
> >  
> >  DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
> > @@ -538,6 +547,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
> >  
> >  	cond_local_irq_enable(regs);
> >  
> > +	if (user_mode(regs) && fixup_pasid_exception())
> > +		goto exit;
> > +
> >  	if (static_cpu_has(X86_FEATURE_UMIP)) {
> >  		if (user_mode(regs) && fixup_umip_exception(regs))
> >  			goto exit;
> 
> So you're eating any random #GP that might or might not be PASID
> related. And all that witout a comment... Enlighten?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
