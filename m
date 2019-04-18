Return-Path: <SRS0=+ohw=SU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA164C10F0E
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 11:54:03 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0C172183E
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 11:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C172183E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 81D951655;
	Thu, 18 Apr 2019 11:54:03 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0C60C1654
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 11:53:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from Galois.linutronix.de (Galois.linutronix.de [146.0.238.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8E5E2108
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 11:53:44 +0000 (UTC)
Received: from pd9ef12d2.dip0.t-ipconnect.de ([217.239.18.210] helo=nanos)
	by Galois.linutronix.de with esmtpsa
	(TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256) (Exim 4.80)
	(envelope-from <tglx@linutronix.de>)
	id 1hH5bc-000615-N4; Thu, 18 Apr 2019 13:53:28 +0200
Date: Thu, 18 Apr 2019 13:53:26 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: [patch V2 09/29] mm/kasan: Simplify stacktrace handling
In-Reply-To: <5b77992a-52b6-807e-f77d-9cf3e648c71f@virtuozzo.com>
Message-ID: <alpine.DEB.2.21.1904181350080.3174@nanos.tec.linutronix.de>
References: <20190418084119.056416939@linutronix.de>
	<20190418084253.903603121@linutronix.de>
	<5b77992a-52b6-807e-f77d-9cf3e648c71f@virtuozzo.com>
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
	Johannes Thumshirn <jthumshirn@suse.de>,
	Alexey Dobriyan <adobriyan@gmail.com>, intel-gfx@lists.freedesktop.org,
	David Rientjes <rientjes@google.com>,
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
Message-ID: <20190418115326.IF0rfkcLqAEAD2NKxf-r1MxdFBncR1RYiJ6Ruq_HLS0@z>

On Thu, 18 Apr 2019, Andrey Ryabinin wrote:
> On 4/18/19 11:41 AM, Thomas Gleixner wrote:
> > Replace the indirection through struct stack_trace by using the storage
> > array based interfaces.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Acked-by: Dmitry Vyukov <dvyukov@google.com>
> > Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> > Cc: Alexander Potapenko <glider@google.com>
> > Cc: kasan-dev@googlegroups.com
> > Cc: linux-mm@kvack.org
> 
> Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> 
> >  
> >  static inline depot_stack_handle_t save_stack(gfp_t flags)
> >  {
> >  	unsigned long entries[KASAN_STACK_DEPTH];
> > -	struct stack_trace trace = {
> > -		.nr_entries = 0,
> > -		.entries = entries,
> > -		.max_entries = KASAN_STACK_DEPTH,
> > -		.skip = 0
> > -	};
> > +	unsigned int nr_entries;
> >  
> > -	save_stack_trace(&trace);
> > -	filter_irq_stacks(&trace);
> > -
> > -	return depot_save_stack(&trace, flags);
> > +	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
> > +	nr_entries = filter_irq_stacks(entries, nr_entries);
> > +	return stack_depot_save(entries, nr_entries, flags);
> 
> Suggestion for further improvement:
> 
> stack_trace_save() shouldn't unwind beyond irq entry point so we wouldn't
> need filter_irq_stacks().  Probably all call sites doesn't care about
> random stack above irq entry point, so it doesn't make sense to spend
> resources on unwinding non-irq stack from interrupt first an filtering
> out it later.

There are users which care about the full trace.

Once we have cleaned up the whole architeture side, we can add core side
filtering which allows to

   1) replace the 'skip number of entries at the beginning

   2) stop the trace when it reaches a certain point

Right now, I don't want to change any of this until the whole mess is
consolidated.

Thanks,

	tglx



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
