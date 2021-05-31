Return-Path: <SRS0=AF0h=K2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E4DC47082
	for <iommu@archiver.kernel.org>; Mon, 31 May 2021 08:43:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F4FA61248
	for <iommu@archiver.kernel.org>; Mon, 31 May 2021 08:43:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F4FA61248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D312440356;
	Mon, 31 May 2021 08:43:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LVpurD34vL_q; Mon, 31 May 2021 08:43:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 83B0040353;
	Mon, 31 May 2021 08:43:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56541C000E;
	Mon, 31 May 2021 08:43:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30FF6C0001
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 08:43:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1120E607AF
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 08:43:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=alien8.de
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yziqCvRYPx1q for <iommu@lists.linux-foundation.org>;
 Mon, 31 May 2021 08:43:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E4E28606B0
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 08:43:09 +0000 (UTC)
Received: from zn.tnic (p200300ec2f080f006c0d0ceb240e6208.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f08:f00:6c0d:ceb:240e:6208])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 68B531EC04E4;
 Mon, 31 May 2021 10:43:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1622450586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=Msp6/mOzC+reDvbox8TBHENLxJVuN3KTGhQXfGNqILQ=;
 b=FZF0oT4e1GlPmzBdC0e7FNh+013Gmgv1blbMPHdTuIvHp0TwDqPr5GpE+1K8SLm2yfTzri
 wu0Um0wg5IP8ceCy86/NY2IQfCTYL2OYBAq5GF+wLSHiQC62Ue4SaUJ5yk4M87W9L/31hZ
 oOMLqeQbUvHLw18N/Nc0VniOlhFBRFM=
Date: Mon, 31 May 2021 10:43:04 +0200
From: Borislav Petkov <bp@alien8.de>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86/cpufeatures: Force disable X86_FEATURE_ENQCMD and
 remove update_pasid()
Message-ID: <YLShmFEzddfm7WQs@zn.tnic>
References: <1600187413-163670-1-git-send-email-fenghua.yu@intel.com>
 <1600187413-163670-10-git-send-email-fenghua.yu@intel.com>
 <87mtsd6gr9.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87mtsd6gr9.ffs@nanos.tec.linutronix.de>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Ravi V Shankar <ravi.v.shankar@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, Christoph Hellwig <hch@infradead.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Randy Dunlap <rdunlap@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, H Peter Anvin <hpa@zytor.com>,
 David Woodhouse <dwmw2@infradead.org>
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

On Sat, May 29, 2021 at 11:17:30AM +0200, Thomas Gleixner wrote:
> While digesting the XSAVE related horrors, which got introduced with the
> supervisor/user split, the recent addition of ENQCMD related functionality
> got on the radar and turned out to be similarly broken.
> 
> update_pasid(), which is only required when X86_FEATURE_ENQCMD is
> available, is invoked from two places:
> 
>  1) From switch_to() for the incoming task
> 
>  2) Via a SMP function call from the IOMMU/SMV code
> 
> #1 is half-ways correct as it hacks around the brokenness of get_xsave_addr()
>    by enforcing the state to be 'present', but all the conditionals in that
>    code are completely pointless for that.
> 
>    Also the invocation is just useless overhead because at that point
>    it's guaranteed that TIF_NEED_FPU_LOAD is set on the incoming task
>    and all of this can be handled at return to user space.
> 
> #2 is broken beyond repair. The comment in the code claims that it is safe
>    to invoke this in an IPI, but that's just wishful thinking.
> 
>    FPU state of a running task is protected by fregs_lock() which is
>    nothing else than a local_bh_disable(). As BH disabled regions run
>    usually with interrupts enabled the IPI can hit a code section which
>    modifies FPU state and there is absolutely no guarantee that any of the
>    assumptions which are made for the IPI case is true.

... so on a PASID system, your trivial reproducer would theoretically
fire the same way and corrupt FPU state just as well.

Hohumm, I'd say we need all those reproducers turned into proper self
tests and run on everything new that touches xstate. *At* *least*.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
