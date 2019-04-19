Return-Path: <SRS0=myD+=SV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767B7C282DA
	for <iommu@archiver.kernel.org>; Fri, 19 Apr 2019 07:03:01 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40863217FA
	for <iommu@archiver.kernel.org>; Fri, 19 Apr 2019 07:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i1Hy/GRW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40863217FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id F0E0921B3;
	Fri, 19 Apr 2019 07:03:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 519FA2140
	for <iommu@lists.linux-foundation.org>;
	Fri, 19 Apr 2019 07:02:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0CAFF14D
	for <iommu@lists.linux-foundation.org>;
	Fri, 19 Apr 2019 07:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209;
	h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=L7eq8Aug6+D0Uzgmn7vgZITr6hThHMPewFsEW47cNZg=;
	b=i1Hy/GRW9HiWiapoFoRTCdgu1
	cUt7Er7sr71bgd43+dYv+n0Lv5GqnvJ+fSpYP2kjtQcZK4KSH9eqZMuPMywNyKvmhH64/AJZF28Kd
	AlhoxD9/xO4V7UsOg/7MAE2EeVnrnoWM0Pi7ybOHHUHP44EMSsIwE6Jwu+NXpJ/AgQnIsAxNgPdAJ
	Ota/ejkQQY1W48qZZdy3Q4RNzTzjM7hk86diK53SIfg/s2qF6MI2J0OScfSmfawFdDLDzngU6/tDG
	13MF/x52A68J+MK67YWX2NX2H2bIpQcWWr4GQXNqFjTBedeNIaoV6M4g88Nvr+yKVzWJBaI25hvyv
	9aVlwsorw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
	helo=hirez.programming.kicks-ass.net)
	by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hHNXI-00007w-SC; Fri, 19 Apr 2019 07:02:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5B5DB29B52F42; Fri, 19 Apr 2019 09:02:11 +0200 (CEST)
Date: Fri, 19 Apr 2019 09:02:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V2 28/29] stacktrace: Provide common infrastructure
Message-ID: <20190419070211.GL4038@hirez.programming.kicks-ass.net>
References: <20190418084119.056416939@linutronix.de>
	<20190418084255.652003111@linutronix.de>
	<20190418145201.mjzyqbmkjcghqzex@treble>
	<alpine.DEB.2.21.1904181734200.3174@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1904181734200.3174@nanos.tec.linutronix.de>
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
Message-ID: <20190419070211.sxTsH279rQrtr7ECXNJlUl_JGdGlSi55BvHg8QlPjOE@z>

On Thu, Apr 18, 2019 at 05:42:55PM +0200, Thomas Gleixner wrote:
> On Thu, 18 Apr 2019, Josh Poimboeuf wrote:

> > Another idea I had (but never got a chance to work on) was to extend the
> > x86 unwind interface to all arches.  So instead of the callbacks, each
> > arch would implement something like this API:

> I surely thought about that, but after staring at all incarnations of
> arch/*/stacktrace.c I just gave up.
> 
> Aside of that quite some archs already have callback based unwinders
> because they use them for more than stacktracing and just have a single
> implementation of that loop.
> 
> I'm fine either way. We can start with x86 and then let archs convert over
> their stuff, but I wouldn't hold my breath that this will be completed in
> the forseeable future.

I suggested the same to Thomas early on, and I even spend the time to
convert some $random arch to the iterator interface, and while it is
indeed entirely feasible, it is _far_ more work.

The callback thing OTOH is flexible enough to do what we want to do now,
and allows converting most archs to it without too much pain (as Thomas
said, many archs are already in this form and only need minor API
adjustments), which gets us in a far better place than we are now.

And we can always go to iterators later on. But I think getting the
generic unwinder improved across all archs is a really important first
step here.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
