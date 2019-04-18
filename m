Return-Path: <SRS0=+ohw=SU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D7EC10F0E
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 14:53:58 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 145E5206B6
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 14:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145E5206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DAE9718DC;
	Thu, 18 Apr 2019 14:53:57 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0B91F18D6
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 14:53:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 799CF108
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 14:53:39 +0000 (UTC)
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com
	[66.24.58.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 35831206B6;
	Thu, 18 Apr 2019 14:53:36 +0000 (UTC)
Date: Thu, 18 Apr 2019 10:53:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V2 21/29] tracing: Use percpu stack trace buffer more
	intelligently
Message-ID: <20190418105334.5093528d@gandalf.local.home>
In-Reply-To: <20190418084254.999521114@linutronix.de>
References: <20190418084119.056416939@linutronix.de>
	<20190418084254.999521114@linutronix.de>
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
Message-ID: <20190418145334.3yOF8GcOqSLy-oV8faD8CS71qB_8LMG_qlwAlD8nKGs@z>

On Thu, 18 Apr 2019 10:41:40 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> The per cpu stack trace buffer usage pattern is odd at best. The buffer has
> place for 512 stack trace entries on 64-bit and 1024 on 32-bit. When
> interrupts or exceptions nest after the per cpu buffer was acquired the
> stacktrace length is hardcoded to 8 entries. 512/1024 stack trace entries
> in kernel stacks are unrealistic so the buffer is a complete waste.
> 
> Split the buffer into chunks of 64 stack entries which is plenty. This
> allows nesting contexts (interrupts, exceptions) to utilize the cpu buffer
> for stack retrieval and avoids the fixed length allocation along with the
> conditional execution pathes.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> ---
>  kernel/trace/trace.c |   77 +++++++++++++++++++++++++--------------------------
>  1 file changed, 39 insertions(+), 38 deletions(-)
> 
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -2749,12 +2749,21 @@ trace_function(struct trace_array *tr,
>  
>  #ifdef CONFIG_STACKTRACE
>  
> -#define FTRACE_STACK_MAX_ENTRIES (PAGE_SIZE / sizeof(unsigned long))
> +/* 64 entries for kernel stacks are plenty */
> +#define FTRACE_KSTACK_ENTRIES	64
> +
>  struct ftrace_stack {
> -	unsigned long		calls[FTRACE_STACK_MAX_ENTRIES];
> +	unsigned long		calls[FTRACE_KSTACK_ENTRIES];
>  };
>  
> -static DEFINE_PER_CPU(struct ftrace_stack, ftrace_stack);
> +/* This allows 8 level nesting which is plenty */

Can we make this 4 level nesting and increase the size? (I can see us
going more than 64 deep, kernel developers never cease to amaze me ;-)
That's all we need:

 Context: Normal, softirq, irq, NMI

Is there any other way to nest?

-- Steve

> +#define FTRACE_KSTACK_NESTING	(PAGE_SIZE / sizeof(struct ftrace_stack))
> +
> +struct ftrace_stacks {
> +	struct ftrace_stack	stacks[FTRACE_KSTACK_NESTING];
> +};
> +
> +static DEFINE_PER_CPU(struct ftrace_stacks, ftrace_stacks);
>  static DEFINE_PER_CPU(int, ftrace_stack_reserve);
>  
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
