Return-Path: <SRS0=cQN6=S2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C617FC282CE
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 19:45:27 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96F8320652
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 19:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jnXyb2lO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F8320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 68F791634;
	Wed, 24 Apr 2019 19:45:27 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B7A6C12AD
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 19:45:25 +0000 (UTC)
X-Greylist: greylisting inactive for cl@linux.com in SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 635D0870;
	Wed, 24 Apr 2019 19:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209;
	h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nXNCzgXPp/MC/y/PJgs7pmMKbFnjx8a6N8WFYhwtNcs=;
	b=jnXyb2lOVttIJoTmHH09wDdgf
	n8NwsMb9Q8EZ9BhZYTUEmA/PHtyPiQZOmqBu9mXa6yS7FNimIsZTp3th5+3stcuYygHbNmLLYqBGT
	QahsATylTqjWyQwmQWDXx0qU89AA6/OXLd2NCoPGpUOZ+2qhJ4st3eHGbksMYs7v8Vz1EtlVHBU/V
	0d2uWTvtE1ut2NEV0rW9PoEWWmPOPkZ6B4Ll/v8YqCWjQwzFWcsIDvwui3aaYqTf72W1WXM1j/0xM
	JpCvyP3P7MY/egBVMNbkcye19upsSYlZcw08/CLq5k4oepPII8zRfmSr6JNXtPbV5jb8VqzdiXZp7
	XpWmu0naw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
	helo=hirez.programming.kicks-ass.net)
	by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hJNpM-0005aH-OA; Wed, 24 Apr 2019 19:45:08 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id E5F80203E8871; Wed, 24 Apr 2019 21:45:05 +0200 (CEST)
Date: Wed, 24 Apr 2019 21:45:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V2 18/29] lockdep: Move stack trace logic into
	check_prev_add()
Message-ID: <20190424194505.GR11158@hirez.programming.kicks-ass.net>
References: <20190418084119.056416939@linutronix.de>
	<20190418084254.729689921@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190418084254.729689921@linutronix.de>
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
Message-ID: <20190424194505.AdRLxbEYEv14D2loFulbrE4oZYOezHKtELiBYlmfHko@z>

On Thu, Apr 18, 2019 at 10:41:37AM +0200, Thomas Gleixner wrote:
> There is only one caller of check_prev_add() which hands in a zeroed struct
> stack trace and a function pointer to save_stack(). Inside check_prev_add()
> the stack_trace struct is checked for being empty, which is always
> true. Based on that one code path stores a stack trace which is unused. The
> comment there does not make sense either. It's all leftovers from
> historical lockdep code (cross release).

I was more or less expecting a revert of:

ce07a9415f26 ("locking/lockdep: Make check_prev_add() able to handle external stack_trace")

And then I read the comment that went with the "static struct
stack_trace trace" that got removed (in the above commit) and realized
that your patch will consume more stack entries.

The problem is when the held lock stack in check_prevs_add() has multple
trylock entries on top, in that case we call check_prev_add() multiple
times, and this patch will then save the exact same stack-trace multiple
times, consuming static resources.

Possibly we should copy what stackdepot does (but we cannot use it
directly because stackdepot uses locks; but possible we can share bits),
but that is a patch for another day I think.

So while convoluted, perhaps we should retain this code for now.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
