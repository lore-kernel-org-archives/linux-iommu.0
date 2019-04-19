Return-Path: <SRS0=myD+=SV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0566AC282DA
	for <iommu@archiver.kernel.org>; Fri, 19 Apr 2019 13:28:44 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE9F3222AA
	for <iommu@archiver.kernel.org>; Fri, 19 Apr 2019 13:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE9F3222AA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6119023B7;
	Fri, 19 Apr 2019 13:28:43 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 697B923B3
	for <iommu@lists.linux-foundation.org>;
	Fri, 19 Apr 2019 13:28:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D816214D
	for <iommu@lists.linux-foundation.org>;
	Fri, 19 Apr 2019 13:28:28 +0000 (UTC)
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com
	[66.24.58.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 262412229E;
	Fri, 19 Apr 2019 13:28:25 +0000 (UTC)
Date: Fri, 19 Apr 2019 09:28:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V2 22/29] tracing: Make ftrace_trace_userstack() static
	and conditional
Message-ID: <20190419092823.094a6061@gandalf.local.home>
In-Reply-To: <20190418084255.088813838@linutronix.de>
References: <20190418084119.056416939@linutronix.de>
	<20190418084255.088813838@linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Mike Snitzer <snitzer@redhat.com>, David Airlie <airlied@linux.ie>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
	dm-devel@redhat.com, Alexander Potapenko <glider@google.com>,
	Christoph Lameter <cl@linux.com>, Christoph Hellwig <hch@lst.de>,
	Alasdair Kergon <agk@redhat.com>, linux-arch@vger.kernel.org,
	x86@kernel.org, kasan-dev@googlegroups.com,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Alexey Dobriyan <adobriyan@gmail.com>, intel-gfx@lists.freedesktop.org,
	David Rientjes <rientjes@google.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Josef Bacik <josef@toxicpanda.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Mike Rapoport <rppt@linux.vnet.ibm.com>, Andy Lutomirski <luto@kernel.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>, David Sterba <dsterba@suse.com>,
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
Message-ID: <20190419132823.xHwhQCvwoW8zilSF92f06aoVS88kiMRad7y8r1oOx4c@z>

On Thu, 18 Apr 2019 10:41:41 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> It's only used in trace.c and there is absolutely no point in compiling it
> in when user space stack traces are not supported.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Steven Rostedt <rostedt@goodmis.org>

Funny, these were moved out to global functions along with the
ftrace_trace_stack() but I guess they were never used.

This basically just does a partial revert of:

 c0a0d0d3f6528 ("tracing/core: Make the stack entry helpers global")


> ---
>  kernel/trace/trace.c |   14 ++++++++------
>  kernel/trace/trace.h |    8 --------
>  2 files changed, 8 insertions(+), 14 deletions(-)
> 
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -159,6 +159,8 @@ static union trace_eval_map_item *trace_
>  #endif /* CONFIG_TRACE_EVAL_MAP_FILE */
>  
>  static int tracing_set_tracer(struct trace_array *tr, const char *buf);
> +static void ftrace_trace_userstack(struct ring_buffer *buffer,
> +				   unsigned long flags, int pc);
>  
>  #define MAX_TRACER_SIZE		100
>  static char bootup_tracer_buf[MAX_TRACER_SIZE] __initdata;
> @@ -2905,9 +2907,10 @@ void trace_dump_stack(int skip)
>  }
>  EXPORT_SYMBOL_GPL(trace_dump_stack);
>  
> +#ifdef CONFIG_USER_STACKTRACE_SUPPORT
>  static DEFINE_PER_CPU(int, user_stack_count);
>  
> -void
> +static void
>  ftrace_trace_userstack(struct ring_buffer *buffer, unsigned long flags, int pc)
>  {
>  	struct trace_event_call *call = &event_user_stack;
> @@ -2958,13 +2961,12 @@ ftrace_trace_userstack(struct ring_buffe
>   out:
>  	preempt_enable();
>  }
> -
> -#ifdef UNUSED

Strange, I never knew about this ifdef. I would have nuked it when I
saw it.

Anyway,

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


> -static void __trace_userstack(struct trace_array *tr, unsigned long flags)
> +#else /* CONFIG_USER_STACKTRACE_SUPPORT */
> +static void ftrace_trace_userstack(struct ring_buffer *buffer,
> +				   unsigned long flags, int pc)
>  {
> -	ftrace_trace_userstack(tr, flags, preempt_count());
>  }
> -#endif /* UNUSED */
> +#endif /* !CONFIG_USER_STACKTRACE_SUPPORT */
>  
>  #endif /* CONFIG_STACKTRACE */
>  
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -782,17 +782,9 @@ void update_max_tr_single(struct trace_a
>  #endif /* CONFIG_TRACER_MAX_TRACE */
>  
>  #ifdef CONFIG_STACKTRACE
> -void ftrace_trace_userstack(struct ring_buffer *buffer, unsigned long flags,
> -			    int pc);
> -
>  void __trace_stack(struct trace_array *tr, unsigned long flags, int skip,
>  		   int pc);
>  #else
> -static inline void ftrace_trace_userstack(struct ring_buffer *buffer,
> -					  unsigned long flags, int pc)
> -{
> -}
> -
>  static inline void __trace_stack(struct trace_array *tr, unsigned long flags,
>  				 int skip, int pc)
>  {
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
