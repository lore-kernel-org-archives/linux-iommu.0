Return-Path: <SRS0=4mi1=S3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B28C43219
	for <iommu@archiver.kernel.org>; Thu, 25 Apr 2019 13:30:20 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C660C212F5
	for <iommu@archiver.kernel.org>; Thu, 25 Apr 2019 13:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C660C212F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B0EF81E9B;
	Thu, 25 Apr 2019 13:30:19 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 70C391E93
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Apr 2019 13:29:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B1BAC82B
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Apr 2019 13:29:51 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4B577307B4B0;
	Thu, 25 Apr 2019 13:29:50 +0000 (UTC)
Received: from treble (ovpn-123-99.rdu2.redhat.com [10.10.123.99])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 390A060141;
	Thu, 25 Apr 2019 13:29:39 +0000 (UTC)
Date: Thu, 25 Apr 2019 08:29:35 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V3 21/29] tracing: Use percpu stack trace buffer more
	intelligently
Message-ID: <20190425132935.ae35l5oybby5ddgl@treble>
References: <20190425094453.875139013@linutronix.de>
	<20190425094803.066064076@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190425094803.066064076@linutronix.de>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Thu, 25 Apr 2019 13:29:51 +0000 (UTC)
Cc: Mike Snitzer <snitzer@redhat.com>, David Airlie <airlied@linux.ie>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
	dm-devel@redhat.com, Alexander Potapenko <glider@google.com>,
	Christoph Lameter <cl@linux.com>,
	Miroslav Benes <mbenes@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Alasdair Kergon <agk@redhat.com>, linux-arch@vger.kernel.org,
	x86@kernel.org, kasan-dev@googlegroups.com,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Alexey Dobriyan <adobriyan@gmail.com>, intel-gfx@lists.freedesktop.org,
	David Rientjes <rientjes@google.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, Josef Bacik <josef@toxicpanda.com>,
	Mike Rapoport <rppt@linux.vnet.ibm.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Sterba <dsterba@suse.com>, Dmitry Vyukov <dvyukov@google.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Chris Mason <clm@fb.com>, LKML <linux-kernel@vger.kernel.org>,
	Pekka Enberg <penberg@kernel.org>, iommu@lists.linux-foundation.org,
	Daniel Vetter <daniel@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20190425132935.RQ0g0srPg2-Sf0rfq3Kr0xvOqkIIhtbuLPn_s02EEHU@z>

On Thu, Apr 25, 2019 at 11:45:14AM +0200, Thomas Gleixner wrote:
> @@ -2788,29 +2798,32 @@ static void __ftrace_trace_stack(struct
>  	 */
>  	preempt_disable_notrace();
>  
> -	use_stack = __this_cpu_inc_return(ftrace_stack_reserve);
> +	stackidx = __this_cpu_inc_return(ftrace_stack_reserve);
> +
> +	/* This should never happen. If it does, yell once and skip */
> +	if (WARN_ON_ONCE(stackidx >= FTRACE_KSTACK_NESTING))
> +		goto out;
> +
>  	/*
> -	 * We don't need any atomic variables, just a barrier.
> -	 * If an interrupt comes in, we don't care, because it would
> -	 * have exited and put the counter back to what we want.
> -	 * We just need a barrier to keep gcc from moving things
> -	 * around.
> +	 * The above __this_cpu_inc_return() is 'atomic' cpu local. An
> +	 * interrupt will either see the value pre increment or post
> +	 * increment. If the interrupt happens pre increment it will have
> +	 * restored the counter when it returns.  We just need a barrier to
> +	 * keep gcc from moving things around.
>  	 */
>  	barrier();
> -	if (use_stack == 1) {
> -		trace.entries		= this_cpu_ptr(ftrace_stack.calls);
> -		trace.max_entries	= FTRACE_STACK_MAX_ENTRIES;
> -
> -		if (regs)
> -			save_stack_trace_regs(regs, &trace);
> -		else
> -			save_stack_trace(&trace);
> -
> -		if (trace.nr_entries > size)
> -			size = trace.nr_entries;
> -	} else
> -		/* From now on, use_stack is a boolean */
> -		use_stack = 0;
> +
> +	fstack = this_cpu_ptr(ftrace_stacks.stacks) + (stackidx - 1);

nit: it would be slightly less surprising if stackidx were 0-based:

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d3f6ec7eb729..4fc93004feab 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2798,10 +2798,10 @@ static void __ftrace_trace_stack(struct ring_buffer *buffer,
 	 */
 	preempt_disable_notrace();
 
-	stackidx = __this_cpu_inc_return(ftrace_stack_reserve);
+	stackidx = __this_cpu_inc_return(ftrace_stack_reserve) - 1;
 
 	/* This should never happen. If it does, yell once and skip */
-	if (WARN_ON_ONCE(stackidx >= FTRACE_KSTACK_NESTING))
+	if (WARN_ON_ONCE(stackidx > FTRACE_KSTACK_NESTING))
 		goto out;
 
 	/*
@@ -2813,7 +2813,7 @@ static void __ftrace_trace_stack(struct ring_buffer *buffer,
 	 */
 	barrier();
 
-	fstack = this_cpu_ptr(ftrace_stacks.stacks) + (stackidx - 1);
+	fstack = this_cpu_ptr(ftrace_stacks.stacks) + stackidx;
 	trace.entries		= fstack->calls;
 	trace.max_entries	= FTRACE_KSTACK_ENTRIES;
 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
