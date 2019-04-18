Return-Path: <SRS0=+ohw=SU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C89AC10F0E
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 13:34:23 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B83320652
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 13:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B83320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 220B71152;
	Thu, 18 Apr 2019 13:34:23 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D9A39114B
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 13:34:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5A4C2466
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 13:34:01 +0000 (UTC)
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com
	[66.24.58.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 00B2D20652;
	Thu, 18 Apr 2019 13:33:57 +0000 (UTC)
Date: Thu, 18 Apr 2019 09:33:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexander Potapenko <glider@google.com>
Subject: Re: [patch V2 14/29] dm bufio: Simplify stack trace retrieval
Message-ID: <20190418093356.5d4b7732@gandalf.local.home>
In-Reply-To: <CAG_fn=WL0yLqavV_mhodT=B6KcAzJ+LS0hss1jqany9Cn92RHw@mail.gmail.com>
References: <20190418084119.056416939@linutronix.de>
	<20190418084254.361284697@linutronix.de>
	<CAG_fn=WP9+bVv9hedoaTzWK+xBzedxaGJGVOPnF0o115s-oWvg@mail.gmail.com>
	<alpine.DEB.2.21.1904181353420.3174@nanos.tec.linutronix.de>
	<CAG_fn=WL0yLqavV_mhodT=B6KcAzJ+LS0hss1jqany9Cn92RHw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Mike Snitzer <snitzer@redhat.com>, David Airlie <airlied@linux.ie>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	Linux Memory Management List <linux-mm@kvack.org>,
	dm-devel@redhat.com, Christoph Lameter <cl@linux.com>,
	Christoph Hellwig <hch@lst.de>, Alasdair Kergon <agk@redhat.com>,
	linux-arch@vger.kernel.org, x86@kernel.org,
	kasan-dev <kasan-dev@googlegroups.com>,
	David Rientjes <rientjes@google.com>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Alexey Dobriyan <adobriyan@gmail.com>, intel-gfx@lists.freedesktop.org,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Josef Bacik <josef@toxicpanda.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Mike Rapoport <rppt@linux.vnet.ibm.com>, Andy Lutomirski <luto@kernel.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>, David Sterba <dsterba@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <20190418133356.8se1qu47faye_qsmT1xzzqu7XiQ0ZYc4uWHTWdVPzLo@z>

On Thu, 18 Apr 2019 14:11:44 +0200
Alexander Potapenko <glider@google.com> wrote:

> On Thu, Apr 18, 2019 at 1:54 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Thu, 18 Apr 2019, Alexander Potapenko wrote:  
> > > On Thu, Apr 18, 2019 at 11:06 AM Thomas Gleixner <tglx@linutronix.de> wrote:  
> > > > -       save_stack_trace(&b->stack_trace);
> > > > +       b->stack_len = stack_trace_save(b->stack_entries, MAX_STACK, 2);  
> > > As noted in one of similar patches before, can we have an inline
> > > comment to indicate what does this "2" stand for?  
> >
> > Come on. We have gazillion of functions which take numerical constant
> > arguments. Should we add comments to all of them?  
> Ok, sorry. I might not be familiar enough with the kernel style guide.

It is a legitimate complaint but not for this series. I only complain
about hard coded constants when they are added. That "2" was not
added by this series. This patch set is a clean up of the stack tracing
code, not a clean up of removing hard coded constants, or commenting
them.

The hard coded "2" was there without a comment before this patch series
and Thomas is correct to leave it as is for these changes. This patch
series should not modify what was already there which is out of scope
for the purpose of these changes.

A separate clean up patch to the maintainer of the subsystem (dm bufio
in this case) is fine. But it's not Thomas's responsibility.

-- Steve
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
