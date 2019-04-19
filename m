Return-Path: <SRS0=myD+=SV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1DAC282DA
	for <iommu@archiver.kernel.org>; Fri, 19 Apr 2019 09:07:56 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5660D218CD
	for <iommu@archiver.kernel.org>; Fri, 19 Apr 2019 09:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RJpXP6G5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5660D218CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 12285230C;
	Fri, 19 Apr 2019 09:07:56 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6B9EF2306
	for <iommu@lists.linux-foundation.org>;
	Fri, 19 Apr 2019 09:07:40 +0000 (UTC)
X-Greylist: greylisting inactive for cl@linux.com in SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 167016C5;
	Fri, 19 Apr 2019 09:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209;
	h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Z3FgX2qYeAVr6a7aOjZTKzD1LI5HjVL2uBhAKfg9pDs=;
	b=RJpXP6G57WJQo20w1oN6XV1Sv
	W0L+9FKiKEGCXF0UITD24ixi+tPLIpDsoo3ae5bCC4wswL29O/O1INxloaH4aS+LS5yudtvbT81Fe
	Wyjy7ZPOBCxw1Isgsz4PXKHIt/FoNeftgsdcHKhkwrLmW0UrqT9w+USQ4dwLxmPbn84yeQGclO3a6
	xNsCQIrNih4rri7LJVSPoidSd3rDLti1c9VgyWRiS/K6aGXChzk762fRVgxajeZs/pUD/y03P1xNR
	3LO1qv4gn1QkLcarsdl9Pi02ID3DDYmPnYB9iH/StdK1D5dChx2YdtqtZ/iCpQ/j41edlnb+n3hiR
	7ZbFFPYzQ==;
Received: from [92.65.108.250] (helo=worktop.programming.kicks-ass.net)
	by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hHPUT-0001vd-67; Fri, 19 Apr 2019 09:07:25 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0D676984ED8; Fri, 19 Apr 2019 11:07:18 +0200 (CEST)
Date: Fri, 19 Apr 2019 11:07:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V2 28/29] stacktrace: Provide common infrastructure
Message-ID: <20190419090717.GN7905@worktop.programming.kicks-ass.net>
References: <20190418084119.056416939@linutronix.de>
	<20190418084255.652003111@linutronix.de>
	<20190419071843.GM4038@hirez.programming.kicks-ass.net>
	<alpine.DEB.2.21.1904191031390.3174@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1904191031390.3174@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Mike Snitzer <snitzer@redhat.com>, David Airlie <airlied@linux.ie>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
	dm-devel@redhat.com, Alexander Potapenko <glider@google.com>,
	Christoph Lameter <cl@linux.com>, Christoph Hellwig <hch@lst.de>,
	Alasdair Kergon <agk@redhat.com>, linux-arch@vger.kernel.org,
	x86@kernel.org, kasan-dev@googlegroups.com,
	David Rientjes <rientjes@google.com>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Alexey Dobriyan <adobriyan@gmail.com>, intel-gfx@lists.freedesktop.org,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, Josef Bacik <josef@toxicpanda.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Mike Rapoport <rppt@linux.vnet.ibm.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
	David Sterba <dsterba@suse.com>,
	Dmitry Vyukov <dvyukov@google.com>, Chris Mason <clm@fb.com>,
	LKML <linux-kernel@vger.kernel.org>, Pekka Enberg <penberg@kernel.org>,
	iommu@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-btrfs@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190419090717.Pz5YN2bKWqL5sQ4HEsxjxL6OlkcHJRG_RO45ttQwDtU@z>

On Fri, Apr 19, 2019 at 10:32:30AM +0200, Thomas Gleixner wrote:
> On Fri, 19 Apr 2019, Peter Zijlstra wrote:
> > On Thu, Apr 18, 2019 at 10:41:47AM +0200, Thomas Gleixner wrote:
> > 
> > > +typedef bool (*stack_trace_consume_fn)(void *cookie, unsigned long addr,
> > > +                                      bool reliable);
> > 
> > > +void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
> > > +		     struct task_struct *task, struct pt_regs *regs);
> > > +int arch_stack_walk_reliable(stack_trace_consume_fn consume_entry, void *cookie,
> > > +			     struct task_struct *task);
> > 
> > This bugs me a little; ideally the _reliable() thing would not exists.
> > 
> > Thomas said that the existing __save_stack_trace_reliable() is different
> > enough for the unification to be non-trivial, but maybe Josh can help
> > out?
> > 
> > >From what I can see the biggest significant differences are:
> > 
> >  - it looks at the regs sets on the stack and for FP bails early
> >  - bails for khreads and idle (after it does all the hard work!?!)
> > 
> > The first (FP checking for exceptions) should probably be reflected in
> > consume_fn(.reliable) anyway -- although that would mean a lot of extra
> > '?' entries where there are none today.
> > 
> > And the second (KTHREAD/IDLE) is something that the generic code can
> > easily do before calling into the arch unwinder.
> 
> And looking at the powerpc version of it, that has even more interesting
> extra checks in that function.

Right, but not fundamentally different from determining @reliable I
think.

Anyway, it would be good if someone knowledgable could have a look at
this.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
