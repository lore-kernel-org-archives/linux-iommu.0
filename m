Return-Path: <SRS0=myD+=SV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC67C282DA
	for <iommu@archiver.kernel.org>; Fri, 19 Apr 2019 15:51:17 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B03A222CE
	for <iommu@archiver.kernel.org>; Fri, 19 Apr 2019 15:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B03A222CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B68C1238A;
	Fri, 19 Apr 2019 15:51:16 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0E462234D
	for <iommu@lists.linux-foundation.org>;
	Fri, 19 Apr 2019 15:50:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A39C9466
	for <iommu@lists.linux-foundation.org>;
	Fri, 19 Apr 2019 15:50:58 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A13B13076C9E;
	Fri, 19 Apr 2019 15:50:57 +0000 (UTC)
Received: from treble (ovpn-124-190.rdu2.redhat.com [10.10.124.190])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 485F819C58;
	Fri, 19 Apr 2019 15:50:46 +0000 (UTC)
Date: Fri, 19 Apr 2019 10:50:44 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 28/29] stacktrace: Provide common infrastructure
Message-ID: <20190419155044.2uch7eaj4vzg47w6@treble>
References: <20190418084119.056416939@linutronix.de>
	<20190418084255.652003111@linutronix.de>
	<20190418145201.mjzyqbmkjcghqzex@treble>
	<alpine.DEB.2.21.1904181734200.3174@nanos.tec.linutronix.de>
	<20190419070211.GL4038@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190419070211.GL4038@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Fri, 19 Apr 2019 15:50:58 +0000 (UTC)
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
Message-ID: <20190419155044.xdk6y0DW-JhNwuF8y56W-SGSuD67rYTrpni2FD_YdGc@z>

On Fri, Apr 19, 2019 at 09:02:11AM +0200, Peter Zijlstra wrote:
> On Thu, Apr 18, 2019 at 05:42:55PM +0200, Thomas Gleixner wrote:
> > On Thu, 18 Apr 2019, Josh Poimboeuf wrote:
> 
> > > Another idea I had (but never got a chance to work on) was to extend the
> > > x86 unwind interface to all arches.  So instead of the callbacks, each
> > > arch would implement something like this API:
> 
> > I surely thought about that, but after staring at all incarnations of
> > arch/*/stacktrace.c I just gave up.
> > 
> > Aside of that quite some archs already have callback based unwinders
> > because they use them for more than stacktracing and just have a single
> > implementation of that loop.
> > 
> > I'm fine either way. We can start with x86 and then let archs convert over
> > their stuff, but I wouldn't hold my breath that this will be completed in
> > the forseeable future.
> 
> I suggested the same to Thomas early on, and I even spend the time to
> convert some $random arch to the iterator interface, and while it is
> indeed entirely feasible, it is _far_ more work.
> 
> The callback thing OTOH is flexible enough to do what we want to do now,
> and allows converting most archs to it without too much pain (as Thomas
> said, many archs are already in this form and only need minor API
> adjustments), which gets us in a far better place than we are now.
> 
> And we can always go to iterators later on. But I think getting the
> generic unwinder improved across all archs is a really important first
> step here.

Fair enough.

-- 
Josh
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
