Return-Path: <SRS0=yzgR=76=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18662C433E0
	for <iommu@archiver.kernel.org>; Wed, 17 Jun 2020 08:31:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1E4520C09
	for <iommu@archiver.kernel.org>; Wed, 17 Jun 2020 08:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pGHQQ40P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E4520C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B09688883D;
	Wed, 17 Jun 2020 08:31:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0czvvi9ZRfhb; Wed, 17 Jun 2020 08:31:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 12B3E886C8;
	Wed, 17 Jun 2020 08:31:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E458FC0863;
	Wed, 17 Jun 2020 08:31:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3BB7C016E
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 08:31:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8899E203DF
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 08:31:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lrqKFrIj4qOZ for <iommu@lists.linux-foundation.org>;
 Wed, 17 Jun 2020 08:31:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by silver.osuosl.org (Postfix) with ESMTPS id 8A588203C4
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 08:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=PpSWQoZVa+rxLKWKXqLIv8btjA0lR/+HCKmuqJBW6Xk=; b=pGHQQ40PYz4XaECx9UDuuOmLNJ
 iEv5F88GbuYBu2poejXdWHicH5VKt9K55XNs+X7kjcA4Ziud4AiW8B9/kkzms7DKrt5D5SkXyRJ7i
 13H0V+UjQGP44jR/2/jse9tN0T+yis59NLW/oCaxSJFrXMdIJqdIIhospUM3uifcNnSsIQVLTpawd
 NJX0fYkyo4zsgw0iYsha0fyO68x5Jj7UP/avH40jVs0GpURHNTfSA54lBJ22FbSqFopcdlPTPTF2f
 W40tlM9Cpbvl3n+lwS16GWI8Hhe4VKYYFh02MjbguiAeDv5JScHO7p4fABJti7WYYcxP85TtJKYG+
 mCvr5jmg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlTTa-0006uB-MI; Wed, 17 Jun 2020 08:31:18 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C68F3306102;
 Wed, 17 Jun 2020 10:31:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id AD21229E5A2E1; Wed, 17 Jun 2020 10:31:16 +0200 (CEST)
Date: Wed, 17 Jun 2020 10:31:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v2 12/12] x86/traps: Fix up invalid PASID
Message-ID: <20200617083116.GE2531@hirez.programming.kicks-ass.net>
References: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
 <1592008893-9388-13-git-send-email-fenghua.yu@intel.com>
 <20200615075649.GK2497@hirez.programming.kicks-ass.net>
 <20200615154854.GB13792@romley-ivt3.sc.intel.com>
 <20200615160357.GA2531@hirez.programming.kicks-ass.net>
 <20200615181259.GC13792@romley-ivt3.sc.intel.com>
 <20200615183116.GD2531@hirez.programming.kicks-ass.net>
 <20200615185529.GD13792@romley-ivt3.sc.intel.com>
 <20200615190928.GJ2531@hirez.programming.kicks-ass.net>
 <20200616232345.GC15763@romley-ivt3.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200616232345.GC15763@romley-ivt3.sc.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, H Peter Anvin <hpa@zytor.com>,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 x86 <x86@kernel.org>, amd-gfx <amd-gfx@lists.freedesktop.org>,
 Ingo Molnar <mingo@redhat.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
 Yu-cheng Yu <yu-cheng.yu@intel.com>, Andrew Donnellan <ajd@linux.ibm.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Tony Luck <tony.luck@intel.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jacob Jun Pan <jacob.jun.pan@intel.com>,
 Frederic Barrat <fbarrat@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>
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

On Tue, Jun 16, 2020 at 04:23:46PM -0700, Fenghua Yu wrote:
> Hi, Peter,
> 
> On Mon, Jun 15, 2020 at 09:09:28PM +0200, Peter Zijlstra wrote:
> > On Mon, Jun 15, 2020 at 11:55:29AM -0700, Fenghua Yu wrote:
> > 
> > > Or do you suggest to add a random new flag in struct thread_info instead
> > > of a TIF flag?
> > 
> > Why thread_info? What's wrong with something simple like the below. It
> > takes a bit from the 'strictly current' flags word.
> > 
> > 
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index b62e6aaf28f0..fca830b97055 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -801,6 +801,9 @@ struct task_struct {
> >  	/* Stalled due to lack of memory */
> >  	unsigned			in_memstall:1;
> >  #endif
> > +#ifdef CONFIG_PCI_PASID
> > +	unsigned			has_valid_pasid:1;
> > +#endif
> >  
> >  	unsigned long			atomic_flags; /* Flags requiring atomic access. */
> >  
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 142b23645d82..10b3891be99e 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -955,6 +955,10 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
> >  	tsk->use_memdelay = 0;
> >  #endif
> >  
> > +#ifdef CONFIG_PCI_PASID
> > +	tsk->has_valid_pasid = 0;
> > +#endif
> > +
> >  #ifdef CONFIG_MEMCG
> >  	tsk->active_memcg = NULL;
> >  #endif
> 
> Can I add "Signed-off-by: Peter Zijlstra <peterz@infradead.org>"
> to this patch? I will send this patch in the next version of the series.

Sure, n/p.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
