Return-Path: <SRS0=4mi1=S3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B6BC282E1
	for <iommu@archiver.kernel.org>; Thu, 25 Apr 2019 10:34:44 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F1EE2084B
	for <iommu@archiver.kernel.org>; Thu, 25 Apr 2019 10:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F1EE2084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4A2DC1D59;
	Thu, 25 Apr 2019 10:34:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 312891D27
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Apr 2019 10:33:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from Galois.linutronix.de (Galois.linutronix.de [146.0.238.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 99C6A82A
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Apr 2019 10:33:41 +0000 (UTC)
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
	by Galois.linutronix.de with esmtp (Exim 4.80)
	(envelope-from <tglx@linutronix.de>)
	id 1hJbAD-0001wo-Fc; Thu, 25 Apr 2019 11:59:33 +0200
Message-Id: <20190425094803.066064076@linutronix.de>
User-Agent: quilt/0.65
Date: Thu, 25 Apr 2019 11:45:14 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V3 21/29] tracing: Use percpu stack trace buffer more
	intelligently
References: <20190425094453.875139013@linutronix.de>
MIME-Version: 1.0
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
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Mike Rapoport <rppt@linux.vnet.ibm.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
	David Sterba <dsterba@suse.com>, Dmitry Vyukov <dvyukov@google.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Chris Mason <clm@fb.com>, Pekka Enberg <penberg@kernel.org>,
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
Message-ID: <20190425094514.96Agq3I1P8OGcz0bK9wOXHbwJseoOREV2mCYnrYuboI@z>

The per cpu stack trace buffer usage pattern is odd at best. The buffer has
place for 512 stack trace entries on 64-bit and 1024 on 32-bit. When
interrupts or exceptions nest after the per cpu buffer was acquired the
stacktrace length is hardcoded to 8 entries. 512/1024 stack trace entries
in kernel stacks are unrealistic so the buffer is a complete waste.

Split the buffer into 4 nest levels, which are 128/256 entries per
level. This allows nesting contexts (interrupts, exceptions) to utilize the
cpu buffer for stack retrieval and avoids the fixed length allocation along
with the conditional execution pathes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
V3: Limit to 4 nest levels and increase size per level.
---
 kernel/trace/trace.c |   77 +++++++++++++++++++++++++--------------------------
 1 file changed, 39 insertions(+), 38 deletions(-)

--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2749,12 +2749,21 @@ trace_function(struct trace_array *tr,
 
 #ifdef CONFIG_STACKTRACE
 
-#define FTRACE_STACK_MAX_ENTRIES (PAGE_SIZE / sizeof(unsigned long))
+/* Allow 4 levels of nesting: normal, softirq, irq, NMI */
+#define FTRACE_KSTACK_NESTING	4
+
+#define FTRACE_KSTACK_ENTRIES	(PAGE_SIZE / FTRACE_KSTACK_NESTING)
+
 struct ftrace_stack {
-	unsigned long		calls[FTRACE_STACK_MAX_ENTRIES];
+	unsigned long		calls[FTRACE_KSTACK_ENTRIES];
+};
+
+
+struct ftrace_stacks {
+	struct ftrace_stack	stacks[FTRACE_KSTACK_NESTING];
 };
 
-static DEFINE_PER_CPU(struct ftrace_stack, ftrace_stack);
+static DEFINE_PER_CPU(struct ftrace_stacks, ftrace_stacks);
 static DEFINE_PER_CPU(int, ftrace_stack_reserve);
 
 static void __ftrace_trace_stack(struct ring_buffer *buffer,
@@ -2763,10 +2772,11 @@ static void __ftrace_trace_stack(struct
 {
 	struct trace_event_call *call = &event_kernel_stack;
 	struct ring_buffer_event *event;
+	struct ftrace_stack *fstack;
 	struct stack_entry *entry;
 	struct stack_trace trace;
-	int use_stack;
-	int size = FTRACE_STACK_ENTRIES;
+	int size = FTRACE_KSTACK_ENTRIES;
+	int stackidx;
 
 	trace.nr_entries	= 0;
 	trace.skip		= skip;
@@ -2788,29 +2798,32 @@ static void __ftrace_trace_stack(struct
 	 */
 	preempt_disable_notrace();
 
-	use_stack = __this_cpu_inc_return(ftrace_stack_reserve);
+	stackidx = __this_cpu_inc_return(ftrace_stack_reserve);
+
+	/* This should never happen. If it does, yell once and skip */
+	if (WARN_ON_ONCE(stackidx >= FTRACE_KSTACK_NESTING))
+		goto out;
+
 	/*
-	 * We don't need any atomic variables, just a barrier.
-	 * If an interrupt comes in, we don't care, because it would
-	 * have exited and put the counter back to what we want.
-	 * We just need a barrier to keep gcc from moving things
-	 * around.
+	 * The above __this_cpu_inc_return() is 'atomic' cpu local. An
+	 * interrupt will either see the value pre increment or post
+	 * increment. If the interrupt happens pre increment it will have
+	 * restored the counter when it returns.  We just need a barrier to
+	 * keep gcc from moving things around.
 	 */
 	barrier();
-	if (use_stack == 1) {
-		trace.entries		= this_cpu_ptr(ftrace_stack.calls);
-		trace.max_entries	= FTRACE_STACK_MAX_ENTRIES;
-
-		if (regs)
-			save_stack_trace_regs(regs, &trace);
-		else
-			save_stack_trace(&trace);
-
-		if (trace.nr_entries > size)
-			size = trace.nr_entries;
-	} else
-		/* From now on, use_stack is a boolean */
-		use_stack = 0;
+
+	fstack = this_cpu_ptr(ftrace_stacks.stacks) + (stackidx - 1);
+	trace.entries		= fstack->calls;
+	trace.max_entries	= FTRACE_KSTACK_ENTRIES;
+
+	if (regs)
+		save_stack_trace_regs(regs, &trace);
+	else
+		save_stack_trace(&trace);
+
+	if (trace.nr_entries > size)
+		size = trace.nr_entries;
 
 	size *= sizeof(unsigned long);
 
@@ -2820,19 +2833,7 @@ static void __ftrace_trace_stack(struct
 		goto out;
 	entry = ring_buffer_event_data(event);
 
-	memset(&entry->caller, 0, size);
-
-	if (use_stack)
-		memcpy(&entry->caller, trace.entries,
-		       trace.nr_entries * sizeof(unsigned long));
-	else {
-		trace.max_entries	= FTRACE_STACK_ENTRIES;
-		trace.entries		= entry->caller;
-		if (regs)
-			save_stack_trace_regs(regs, &trace);
-		else
-			save_stack_trace(&trace);
-	}
+	memcpy(&entry->caller, trace.entries, size);
 
 	entry->size = trace.nr_entries;
 


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
