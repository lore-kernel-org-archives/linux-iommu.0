Return-Path: <SRS0=myD+=SV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88814C282DA
	for <iommu@archiver.kernel.org>; Fri, 19 Apr 2019 16:17:58 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66DF5208C0
	for <iommu@archiver.kernel.org>; Fri, 19 Apr 2019 16:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66DF5208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1771224C0;
	Fri, 19 Apr 2019 16:17:58 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4C37024B3
	for <iommu@lists.linux-foundation.org>;
	Fri, 19 Apr 2019 16:17:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 42153823
	for <iommu@lists.linux-foundation.org>;
	Fri, 19 Apr 2019 16:17:43 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B05EF85541;
	Fri, 19 Apr 2019 16:17:41 +0000 (UTC)
Received: from treble (ovpn-124-190.rdu2.redhat.com [10.10.124.190])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8459E5D9D2;
	Fri, 19 Apr 2019 16:17:32 +0000 (UTC)
Date: Fri, 19 Apr 2019 11:17:30 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 28/29] stacktrace: Provide common infrastructure
Message-ID: <20190419161730.zgpa3e5fhny42wq7@treble>
References: <20190418084119.056416939@linutronix.de>
	<20190418084255.652003111@linutronix.de>
	<20190419071843.GM4038@hirez.programming.kicks-ass.net>
	<alpine.DEB.2.21.1904191031390.3174@nanos.tec.linutronix.de>
	<20190419090717.GN7905@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190419090717.GN7905@worktop.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Fri, 19 Apr 2019 16:17:42 +0000 (UTC)
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
	Mike Rapoport <rppt@linux.vnet.ibm.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Sterba <dsterba@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <20190419161730.FjWw2yO4QsNDOJimS_k9GjhsEtzqucIaGwHF4LiqTq4@z>

On Fri, Apr 19, 2019 at 11:07:17AM +0200, Peter Zijlstra wrote:
> On Fri, Apr 19, 2019 at 10:32:30AM +0200, Thomas Gleixner wrote:
> > On Fri, 19 Apr 2019, Peter Zijlstra wrote:
> > > On Thu, Apr 18, 2019 at 10:41:47AM +0200, Thomas Gleixner wrote:
> > > 
> > > > +typedef bool (*stack_trace_consume_fn)(void *cookie, unsigned long addr,
> > > > +                                      bool reliable);
> > > 
> > > > +void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
> > > > +		     struct task_struct *task, struct pt_regs *regs);
> > > > +int arch_stack_walk_reliable(stack_trace_consume_fn consume_entry, void *cookie,
> > > > +			     struct task_struct *task);
> > > 
> > > This bugs me a little; ideally the _reliable() thing would not exists.
> > > 
> > > Thomas said that the existing __save_stack_trace_reliable() is different
> > > enough for the unification to be non-trivial, but maybe Josh can help
> > > out?
> > > 
> > > >From what I can see the biggest significant differences are:
> > > 
> > >  - it looks at the regs sets on the stack and for FP bails early
> > >  - bails for khreads and idle (after it does all the hard work!?!)

That's done for a reason, see the "Success path" comments.

> > > The first (FP checking for exceptions) should probably be reflected in
> > > consume_fn(.reliable) anyway -- although that would mean a lot of extra
> > > '?' entries where there are none today.
> > > 
> > > And the second (KTHREAD/IDLE) is something that the generic code can
> > > easily do before calling into the arch unwinder.
> > 
> > And looking at the powerpc version of it, that has even more interesting
> > extra checks in that function.
> 
> Right, but not fundamentally different from determining @reliable I
> think.
> 
> Anyway, it would be good if someone knowledgable could have a look at
> this.

Yeah, we could probably do that.

The flow would need to be changed a bit -- some of the errors are soft
errors which most users don't care about because they just want a best
effort.  The soft errors can be remembered without breaking out of the
loop, and just returned at the end.  Most users could just ignore the
return code.

The only thing I'd be worried about is performance for the non-livepatch
users, but I guess those checks don't look very expensive.  And the x86
unwinders are already pretty slow anyway...

-- 
Josh
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
