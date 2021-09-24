Return-Path: <SRS0=LkSb=OO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB251C433F5
	for <iommu@archiver.kernel.org>; Fri, 24 Sep 2021 13:40:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 823706105A
	for <iommu@archiver.kernel.org>; Fri, 24 Sep 2021 13:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 823706105A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4E452406E6;
	Fri, 24 Sep 2021 13:40:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X1czscL9VgaZ; Fri, 24 Sep 2021 13:40:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3A77841969;
	Fri, 24 Sep 2021 13:40:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D0B7C000F;
	Fri, 24 Sep 2021 13:40:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB556C000D
 for <iommu@lists.linux-foundation.org>; Fri, 24 Sep 2021 13:40:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BB3354161E
 for <iommu@lists.linux-foundation.org>; Fri, 24 Sep 2021 13:40:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SQd1OiLJj1bj for <iommu@lists.linux-foundation.org>;
 Fri, 24 Sep 2021 13:39:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2F3E9406E6
 for <iommu@lists.linux-foundation.org>; Fri, 24 Sep 2021 13:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=66iruQyw4wjAu1lDqnvGKU6vRWu6JERcPGI2qJLde+U=; b=q2HwTNPmMxKrZbOf3MOv42gDBK
 8Bve+tNf0Z/zni3CLHBmX9ix/2RjmcP8uXbGwFJlGKA005f0spq6CnmA2lWI6Ywir1VEYqz+Iwrdy
 SpsSBktQrWYdfkfsrPEnbUB0OZ+08LQSIu/PNnIuR6kDFd1ISHb8cRgrSue/sAJGwkMKxJgE/Jq7K
 7IL0wQtmfCWkPHaSGV8WeWp/taPAHWPd3dKrr5iyxFsIxGRDgyFb3wOsgy0EwMNqqiDvdCYM/3MTu
 iJnGmcWzx14oypzEtPs8WFWvLIgFwN5fvpC4IJdS7PGnHnnSVUpEZjdYHg1gZZJrIxsaURvykUGqx
 OU1gNCKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mTlOF-007FCG-ON; Fri, 24 Sep 2021 13:38:03 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 144ED30026F;
 Fri, 24 Sep 2021 15:37:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id C38B52C5DFD94; Fri, 24 Sep 2021 15:37:22 +0200 (CEST)
Date: Fri, 24 Sep 2021 15:37:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH 4/8] x86/traps: Demand-populate PASID MSR via #GP
Message-ID: <YU3UkvNdzCqAANSY@hirez.programming.kicks-ass.net>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-5-fenghua.yu@intel.com>
 <20210922210722.GV4323@worktop.programming.kicks-ass.net>
 <YUy2AmabA4ODOgAC@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YUy2AmabA4ODOgAC@agluck-desk2.amr.corp.intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
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

On Thu, Sep 23, 2021 at 10:14:42AM -0700, Luck, Tony wrote:
> On Wed, Sep 22, 2021 at 11:07:22PM +0200, Peter Zijlstra wrote:
> > On Mon, Sep 20, 2021 at 07:23:45PM +0000, Fenghua Yu wrote:
> > > @@ -538,6 +547,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
> > >  
> > >  	cond_local_irq_enable(regs);
> > >  
> > > +	if (user_mode(regs) && fixup_pasid_exception())
> > > +		goto exit;
> > > +
> 
> > So you're eating any random #GP that might or might not be PASID
> > related. And all that witout a comment... Enlighten?
> 
> This is moderately well commented inside the fixup_pasid_exception()
> function. Another copy of the comments here at the call-site seems
> overkill.

+static bool fixup_pasid_exception(void)
+{
+       if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
+               return false;
+
+       return __fixup_pasid_exception();
+}

/me goes looking for comments in that function, lemme get out the
electron microscope, because I can't seem to spot them with the naked
eye.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
