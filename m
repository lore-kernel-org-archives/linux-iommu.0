Return-Path: <SRS0=+ohw=SU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7509C10F0E
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 11:57:49 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD1C6217FA
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 11:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD1C6217FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 664FB1660;
	Thu, 18 Apr 2019 11:57:49 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 292401654
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 11:57:36 +0000 (UTC)
X-Greylist: greylisting inactive for cl@linux.com in SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from Galois.linutronix.de (Galois.linutronix.de [146.0.238.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A0DCF108;
	Thu, 18 Apr 2019 11:57:35 +0000 (UTC)
Received: from pd9ef12d2.dip0.t-ipconnect.de ([217.239.18.210] helo=nanos)
	by Galois.linutronix.de with esmtpsa
	(TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256) (Exim 4.80)
	(envelope-from <tglx@linutronix.de>)
	id 1hH5fQ-00069B-K5; Thu, 18 Apr 2019 13:57:24 +0200
Date: Thu, 18 Apr 2019 13:57:22 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [patch V2 28/29] stacktrace: Provide common infrastructure
In-Reply-To: <20190418115207.GB13304@rapoport-lnx>
Message-ID: <alpine.DEB.2.21.1904181355300.3174@nanos.tec.linutronix.de>
References: <20190418084119.056416939@linutronix.de>
	<20190418084255.652003111@linutronix.de>
	<20190418115207.GB13304@rapoport-lnx>
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
Message-ID: <20190418115722.06FlB9ffXmXzyyyDJQnkVxM22EBONWUMebFwxHvBUKE@z>

On Thu, 18 Apr 2019, Mike Rapoport wrote:
> On Thu, Apr 18, 2019 at 10:41:47AM +0200, Thomas Gleixner wrote:
> > +/**
> > + * arch_stack_walk - Architecture specific function to walk the stack
> > +
> 
> Nit: no '*' at line beginning makes kernel-doc unhappy

Oops.

> > + * @consume_entry:	Callback which is invoked by the architecture code for
> > + *			each entry.
> > + * @cookie:		Caller supplied pointer which is handed back to
> > + *			@consume_entry
> > + * @task:		Pointer to a task struct, can be NULL
> > + * @regs:		Pointer to registers, can be NULL
> > + *
> > + * @task	@regs:
> > + * NULL		NULL	Stack trace from current
> > + * task		NULL	Stack trace from task (can be current)
> > + * NULL		regs	Stack trace starting on regs->stackpointer
> 
> This will render as a single line with 'make *docs'.
> Adding line separators makes this actually a table in the generated docs:
> 
>  * ============ ======= ============================================
>  * task		regs
>  * ============ ======= ============================================
>  * NULL		NULL	Stack trace from current
>  * task		NULL	Stack trace from task (can be current)
>  * NULL		regs	Stack trace starting on regs->stackpointer
>  * ============ ======= ============================================

Cute.

> > + * Returns number of entries stored.
> 
> Can you please s/Returns/Return:/ so that kernel-doc will recognize this as
> return section.
> 
> This is relevant for other comments below as well.

Sure.

Thanks for the free kernel doc course! :)

	tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
