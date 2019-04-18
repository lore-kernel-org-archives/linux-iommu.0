Return-Path: <SRS0=+ohw=SU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241CBC10F0E
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 15:43:23 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2C832083D
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 15:43:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2C832083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BEB9F194D;
	Thu, 18 Apr 2019 15:43:22 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7F44514B9
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 15:43:11 +0000 (UTC)
X-Greylist: greylisting inactive for cl@linux.com in SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from Galois.linutronix.de (Galois.linutronix.de [146.0.238.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 097A4108;
	Thu, 18 Apr 2019 15:43:10 +0000 (UTC)
Received: from pd9ef12d2.dip0.t-ipconnect.de ([217.239.18.210] helo=nanos)
	by Galois.linutronix.de with esmtpsa
	(TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256) (Exim 4.80)
	(envelope-from <tglx@linutronix.de>)
	id 1hH9Bh-0004nI-GJ; Thu, 18 Apr 2019 17:42:57 +0200
Date: Thu, 18 Apr 2019 17:42:55 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [patch V2 28/29] stacktrace: Provide common infrastructure
In-Reply-To: <20190418145201.mjzyqbmkjcghqzex@treble>
Message-ID: <alpine.DEB.2.21.1904181734200.3174@nanos.tec.linutronix.de>
References: <20190418084119.056416939@linutronix.de>
	<20190418084255.652003111@linutronix.de>
	<20190418145201.mjzyqbmkjcghqzex@treble>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
	SHORTCIRCUIT=-0.0001
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
Message-ID: <20190418154255.EylWBd9COJaBevU8EE2tJjdzkfrPrACt5NaWFXAS87o@z>

On Thu, 18 Apr 2019, Josh Poimboeuf wrote:

> On Thu, Apr 18, 2019 at 10:41:47AM +0200, Thomas Gleixner wrote:
> > All architectures which support stacktrace carry duplicated code and
> > do the stack storage and filtering at the architecture side.
> > 
> > Provide a consolidated interface with a callback function for consuming the
> > stack entries provided by the architecture specific stack walker. This
> > removes lots of duplicated code and allows to implement better filtering
> > than 'skip number of entries' in the future without touching any
> > architecture specific code.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Cc: linux-arch@vger.kernel.org
> 
> This is a step in the right direction, especially if it allows us to get
> rid of the 'skip' stuff.  But I'm not crazy about the callbacks.
> 
> Another idea I had (but never got a chance to work on) was to extend the
> x86 unwind interface to all arches.  So instead of the callbacks, each
> arch would implement something like this API:
> 
> 
> struct unwind_state state;
> 
> void unwind_start(struct unwind_state *state, struct task_struct *task,
> 		  struct pt_regs *regs, unsigned long *first_frame);
> 
> bool unwind_next_frame(struct unwind_state *state);
> 
> inline bool unwind_done(struct unwind_state *state);
> 
> 
> Not only would it avoid the callbacks (which is a nice benefit already),
> it would also allow the interfaces to be used outside of the
> stack_trace_*() interfaces.  That would come in handy in cases like the
> ftrace stack tracer code, which needs more than the stack_trace_*() API
> can give.

I surely thought about that, but after staring at all incarnations of
arch/*/stacktrace.c I just gave up.

Aside of that quite some archs already have callback based unwinders
because they use them for more than stacktracing and just have a single
implementation of that loop.

I'm fine either way. We can start with x86 and then let archs convert over
their stuff, but I wouldn't hold my breath that this will be completed in
the forseeable future.

> Of course, this may be more work than what you thought you signed up for
> ;-)

I did not sign up for anything. I tripped over that mess by accident and me
being me hated it strong enough to give it at least an initial steam blast.

Thanks,

	tglx
	
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
