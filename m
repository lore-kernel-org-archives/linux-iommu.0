Return-Path: <SRS0=+ohw=SU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80126C10F0E
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 11:52:49 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57F0F2183E
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 11:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57F0F2183E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 294D2165C;
	Thu, 18 Apr 2019 11:52:49 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 612B2163F
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 11:52:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
	[148.163.156.1])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9CF89823
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 11:52:26 +0000 (UTC)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3IBlvOp004651
	for <iommu@lists.linux-foundation.org>; Thu, 18 Apr 2019 07:52:26 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rxqyu24vf-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <iommu@lists.linux-foundation.org>; Thu, 18 Apr 2019 07:52:25 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <iommu@lists.linux-foundation.org> from <rppt@linux.ibm.com>;
	Thu, 18 Apr 2019 12:52:22 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
	by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 18 Apr 2019 12:52:12 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
	[9.149.105.232])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x3IBqBqF56688694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Thu, 18 Apr 2019 11:52:11 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B587E52052;
	Thu, 18 Apr 2019 11:52:11 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.112])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 162925204F;
	Thu, 18 Apr 2019 11:52:09 +0000 (GMT)
Date: Thu, 18 Apr 2019 14:52:07 +0300
From: Mike Rapoport <rppt@linux.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V2 28/29] stacktrace: Provide common infrastructure
References: <20190418084119.056416939@linutronix.de>
	<20190418084255.652003111@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190418084255.652003111@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19041811-0012-0000-0000-000003103332
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041811-0013-0000-0000-00002148758A
Message-Id: <20190418115207.GB13304@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-18_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=611 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1904180084
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
Message-ID: <20190418115207.5gJ4Llb3hXkzT_HnogQ_sXFjxUTndnhMD0LbfEI5YRI@z>

On Thu, Apr 18, 2019 at 10:41:47AM +0200, Thomas Gleixner wrote:
> All architectures which support stacktrace carry duplicated code and
> do the stack storage and filtering at the architecture side.
> 
> Provide a consolidated interface with a callback function for consuming the
> stack entries provided by the architecture specific stack walker. This
> removes lots of duplicated code and allows to implement better filtering
> than 'skip number of entries' in the future without touching any
> architecture specific code.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-arch@vger.kernel.org
> ---
>  include/linux/stacktrace.h |   38 +++++++++
>  kernel/stacktrace.c        |  173 +++++++++++++++++++++++++++++++++++++++++++++
>  lib/Kconfig                |    4 +
>  3 files changed, 215 insertions(+)
> 
> --- a/include/linux/stacktrace.h
> +++ b/include/linux/stacktrace.h
> @@ -23,6 +23,43 @@ unsigned int stack_trace_save_regs(struc
>  unsigned int stack_trace_save_user(unsigned long *store, unsigned int size);
> 
>  /* Internal interfaces. Do not use in generic code */
> +#ifdef CONFIG_ARCH_STACKWALK
> +
> +/**
> + * stack_trace_consume_fn - Callback for arch_stack_walk()
> + * @cookie:	Caller supplied pointer handed back by arch_stack_walk()
> + * @addr:	The stack entry address to consume
> + * @reliable:	True when the stack entry is reliable. Required by
> + *		some printk based consumers.
> + *
> + * Returns:	True, if the entry was consumed or skipped
> + *		False, if there is no space left to store
> + */
> +typedef bool (*stack_trace_consume_fn)(void *cookie, unsigned long addr,
> +				       bool reliable);
> +/**
> + * arch_stack_walk - Architecture specific function to walk the stack
> +

Nit: no '*' at line beginning makes kernel-doc unhappy

> + * @consume_entry:	Callback which is invoked by the architecture code for
> + *			each entry.
> + * @cookie:		Caller supplied pointer which is handed back to
> + *			@consume_entry
> + * @task:		Pointer to a task struct, can be NULL
> + * @regs:		Pointer to registers, can be NULL
> + *
> + * @task	@regs:
> + * NULL		NULL	Stack trace from current
> + * task		NULL	Stack trace from task (can be current)
> + * NULL		regs	Stack trace starting on regs->stackpointer

This will render as a single line with 'make *docs'.
Adding line separators makes this actually a table in the generated docs:

 * ============ ======= ============================================
 * task		regs
 * ============ ======= ============================================
 * NULL		NULL	Stack trace from current
 * task		NULL	Stack trace from task (can be current)
 * NULL		regs	Stack trace starting on regs->stackpointer
 * ============ ======= ============================================


> + */
> +void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
> +		     struct task_struct *task, struct pt_regs *regs);
> +int arch_stack_walk_reliable(stack_trace_consume_fn consume_entry, void *cookie,
> +			     struct task_struct *task);
> +void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
> +			  const struct pt_regs *regs);
> +
> +#else /* CONFIG_ARCH_STACKWALK */
>  struct stack_trace {
>  	unsigned int nr_entries, max_entries;
>  	unsigned long *entries;
> @@ -37,6 +74,7 @@ extern void save_stack_trace_tsk(struct
>  extern int save_stack_trace_tsk_reliable(struct task_struct *tsk,
>  					 struct stack_trace *trace);
>  extern void save_stack_trace_user(struct stack_trace *trace);
> +#endif /* !CONFIG_ARCH_STACKWALK */
>  #endif /* CONFIG_STACKTRACE */
> 
>  #if defined(CONFIG_STACKTRACE) && defined(CONFIG_HAVE_RELIABLE_STACKTRACE)
> --- a/kernel/stacktrace.c
> +++ b/kernel/stacktrace.c
> @@ -5,6 +5,8 @@
>   *
>   *  Copyright (C) 2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
>   */
> +#include <linux/sched/task_stack.h>
> +#include <linux/sched/debug.h>
>  #include <linux/sched.h>
>  #include <linux/kernel.h>
>  #include <linux/export.h>
> @@ -64,6 +66,175 @@ int stack_trace_snprint(char *buf, size_
>  }
>  EXPORT_SYMBOL_GPL(stack_trace_snprint);
> 
> +#ifdef CONFIG_ARCH_STACKWALK
> +
> +struct stacktrace_cookie {
> +	unsigned long	*store;
> +	unsigned int	size;
> +	unsigned int	skip;
> +	unsigned int	len;
> +};
> +
> +static bool stack_trace_consume_entry(void *cookie, unsigned long addr,
> +				      bool reliable)
> +{
> +	struct stacktrace_cookie *c = cookie;
> +
> +	if (c->len >= c->size)
> +		return false;
> +
> +	if (c->skip > 0) {
> +		c->skip--;
> +		return true;
> +	}
> +	c->store[c->len++] = addr;
> +	return c->len < c->size;
> +}
> +
> +static bool stack_trace_consume_entry_nosched(void *cookie, unsigned long addr,
> +					      bool reliable)
> +{
> +	if (in_sched_functions(addr))
> +		return true;
> +	return stack_trace_consume_entry(cookie, addr, reliable);
> +}
> +
> +/**
> + * stack_trace_save - Save a stack trace into a storage array
> + * @store:	Pointer to storage array
> + * @size:	Size of the storage array
> + * @skipnr:	Number of entries to skip at the start of the stack trace
> + *
> + * Returns number of entries stored.

Can you please s/Returns/Return:/ so that kernel-doc will recognize this as
return section.

This is relevant for other comments below as well.

> + */
> +unsigned int stack_trace_save(unsigned long *store, unsigned int size,
> +			      unsigned int skipnr)
> +{
> +	stack_trace_consume_fn consume_entry = stack_trace_consume_entry;
> +	struct stacktrace_cookie c = {
> +		.store	= store,
> +		.size	= size,
> +		.skip	= skipnr + 1,
> +	};
> +
> +	arch_stack_walk(consume_entry, &c, current, NULL);
> +	return c.len;
> +}
> +EXPORT_SYMBOL_GPL(stack_trace_save);
> +
> +/**
> + * stack_trace_save_tsk - Save a task stack trace into a storage array
> + * @task:	The task to examine
> + * @store:	Pointer to storage array
> + * @size:	Size of the storage array
> + * @skipnr:	Number of entries to skip at the start of the stack trace
> + *
> + * Returns number of entries stored.
> + */
> +unsigned int stack_trace_save_tsk(struct task_struct *tsk, unsigned long *store,
> +				  unsigned int size, unsigned int skipnr)
> +{
> +	stack_trace_consume_fn consume_entry = stack_trace_consume_entry_nosched;
> +	struct stacktrace_cookie c = {
> +		.store	= store,
> +		.size	= size,
> +		.skip	= skipnr + 1,
> +	};
> +
> +	if (!try_get_task_stack(tsk))
> +		return 0;
> +
> +	arch_stack_walk(consume_entry, &c, tsk, NULL);
> +	put_task_stack(tsk);
> +	return c.len;
> +}
> +
> +/**
> + * stack_trace_save_regs - Save a stack trace based on pt_regs into a storage array
> + * @regs:	Pointer to pt_regs to examine
> + * @store:	Pointer to storage array
> + * @size:	Size of the storage array
> + * @skipnr:	Number of entries to skip at the start of the stack trace
> + *
> + * Returns number of entries stored.
> + */
> +unsigned int stack_trace_save_regs(struct pt_regs *regs, unsigned long *store,
> +				   unsigned int size, unsigned int skipnr)
> +{
> +	stack_trace_consume_fn consume_entry = stack_trace_consume_entry;
> +	struct stacktrace_cookie c = {
> +		.store	= store,
> +		.size	= size,
> +		.skip	= skipnr,
> +	};
> +
> +	arch_stack_walk(consume_entry, &c, current, regs);
> +	return c.len;
> +}
> +
> +#ifdef CONFIG_HAVE_RELIABLE_STACKTRACE
> +/**
> + * stack_trace_save_tsk_reliable - Save task stack with verification
> + * @tsk:	Pointer to the task to examine
> + * @store:	Pointer to storage array
> + * @size:	Size of the storage array
> + *
> + * Returns:	An error if it detects any unreliable features of the
> + *		stack. Otherwise it guarantees that the stack trace is
> + *		reliable and returns the number of entries stored.
> + *
> + * If the task is not 'current', the caller *must* ensure the task is inactive.
> + */
> +int stack_trace_save_tsk_reliable(struct task_struct *tsk, unsigned long *store,
> +				  unsigned int size)
> +{
> +	stack_trace_consume_fn consume_entry = stack_trace_consume_entry;
> +	struct stacktrace_cookie c = {
> +		.store	= store,
> +		.size	= size,
> +	};
> +	int ret;
> +
> +	/*
> +	 * If the task doesn't have a stack (e.g., a zombie), the stack is
> +	 * "reliably" empty.
> +	 */
> +	if (!try_get_task_stack(tsk))
> +		return 0;
> +
> +	ret = arch_stack_walk_reliable(consume_entry, &c, tsk);
> +	put_task_stack(tsk);
> +	return ret;
> +}
> +#endif
> +
> +#ifdef CONFIG_USER_STACKTRACE_SUPPORT
> +/**
> + * stack_trace_save_user - Save a user space stack trace into a storage array
> + * @store:	Pointer to storage array
> + * @size:	Size of the storage array
> + *
> + * Returns number of entries stored.
> + */
> +unsigned int stack_trace_save_user(unsigned long *store, unsigned int size)
> +{
> +	stack_trace_consume_fn consume_entry = stack_trace_consume_entry;
> +	struct stacktrace_cookie c = {
> +		.store	= store,
> +		.size	= size,
> +	};
> +
> +	/* Trace user stack if not a kernel thread */
> +	if (!current->mm)
> +		return 0;
> +
> +	arch_stack_walk_user(consume_entry, &c, task_pt_regs(current));
> +	return c.len;
> +}
> +#endif
> +
> +#else /* CONFIG_ARCH_STACKWALK */
> +
>  /*
>   * Architectures that do not implement save_stack_trace_*()
>   * get these weak aliases and once-per-bootup warnings
> @@ -193,3 +364,5 @@ unsigned int stack_trace_save_user(unsig
>  	return trace.nr_entries;
>  }
>  #endif /* CONFIG_USER_STACKTRACE_SUPPORT */
> +
> +#endif /* !CONFIG_ARCH_STACKWALK */
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -597,6 +597,10 @@ config ARCH_HAS_UACCESS_FLUSHCACHE
>  config ARCH_HAS_UACCESS_MCSAFE
>  	bool
> 
> +# Temporary. Goes away when all archs are cleaned up
> +config ARCH_STACKWALK
> +       bool
> +
>  config STACKDEPOT
>  	bool
>  	select STACKTRACE
> 
> 

-- 
Sincerely yours,
Mike.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
