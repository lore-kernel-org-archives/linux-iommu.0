Return-Path: <SRS0=+ohw=SU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8702C10F0E
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 09:33:58 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C11DD214DA
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 09:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11DD214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A537614CF;
	Thu, 18 Apr 2019 09:33:58 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 95912115D
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 09:33:57 +0000 (UTC)
X-Greylist: greylisting inactive for cl@linux.com in SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from Galois.linutronix.de (Galois.linutronix.de [146.0.238.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id F1349466;
	Thu, 18 Apr 2019 09:33:56 +0000 (UTC)
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
	by Galois.linutronix.de with esmtp (Exim 4.80)
	(envelope-from <tglx@linutronix.de>)
	id 1hH30Z-00021L-Q0; Thu, 18 Apr 2019 11:07:04 +0200
Message-Id: <20190418084255.740246383@linutronix.de>
User-Agent: quilt/0.65
Date: Thu, 18 Apr 2019 10:41:48 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V2 29/29] x86/stacktrace: Use common infrastructure
References: <20190418084119.056416939@linutronix.de>
MIME-Version: 1.0
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
Message-ID: <20190418084148.X8edy4N6kMnzIZkA6mlz6BKwrg9CPC8d3VETkYbddI8@z>

Replace the stack_trace_save*() functions with the new arch_stack_walk()
interfaces.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
---
 arch/x86/Kconfig             |    1 
 arch/x86/kernel/stacktrace.c |  116 +++++++------------------------------------
 2 files changed, 20 insertions(+), 97 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -74,6 +74,7 @@ config X86
 	select ARCH_MIGHT_HAVE_ACPI_PDC		if ACPI
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
+	select ARCH_STACKWALK
 	select ARCH_SUPPORTS_ACPI
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_NUMA_BALANCING	if X86_64
--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -12,75 +12,31 @@
 #include <asm/stacktrace.h>
 #include <asm/unwind.h>
 
-static int save_stack_address(struct stack_trace *trace, unsigned long addr,
-			      bool nosched)
-{
-	if (nosched && in_sched_functions(addr))
-		return 0;
-
-	if (trace->skip > 0) {
-		trace->skip--;
-		return 0;
-	}
-
-	if (trace->nr_entries >= trace->max_entries)
-		return -1;
-
-	trace->entries[trace->nr_entries++] = addr;
-	return 0;
-}
-
-static void noinline __save_stack_trace(struct stack_trace *trace,
-			       struct task_struct *task, struct pt_regs *regs,
-			       bool nosched)
+void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
+		     struct task_struct *task, struct pt_regs *regs)
 {
 	struct unwind_state state;
 	unsigned long addr;
 
-	if (regs)
-		save_stack_address(trace, regs->ip, nosched);
+	if (regs && !consume_entry(cookie, regs->ip, false))
+		return;
 
 	for (unwind_start(&state, task, regs, NULL); !unwind_done(&state);
 	     unwind_next_frame(&state)) {
 		addr = unwind_get_return_address(&state);
-		if (!addr || save_stack_address(trace, addr, nosched))
+		if (!addr || !consume_entry(cookie, addr, false))
 			break;
 	}
 }
 
 /*
- * Save stack-backtrace addresses into a stack_trace buffer.
+ * This function returns an error if it detects any unreliable features of the
+ * stack.  Otherwise it guarantees that the stack trace is reliable.
+ *
+ * If the task is not 'current', the caller *must* ensure the task is inactive.
  */
-void save_stack_trace(struct stack_trace *trace)
-{
-	trace->skip++;
-	__save_stack_trace(trace, current, NULL, false);
-}
-EXPORT_SYMBOL_GPL(save_stack_trace);
-
-void save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
-{
-	__save_stack_trace(trace, current, regs, false);
-}
-
-void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
-{
-	if (!try_get_task_stack(tsk))
-		return;
-
-	if (tsk == current)
-		trace->skip++;
-	__save_stack_trace(trace, tsk, NULL, true);
-
-	put_task_stack(tsk);
-}
-EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
-
-#ifdef CONFIG_HAVE_RELIABLE_STACKTRACE
-
-static int __always_inline
-__save_stack_trace_reliable(struct stack_trace *trace,
-			    struct task_struct *task)
+int arch_stack_walk_reliable(stack_trace_consume_fn consume_entry,
+			     void *cookie, struct task_struct *task)
 {
 	struct unwind_state state;
 	struct pt_regs *regs;
@@ -117,7 +73,7 @@ static int __always_inline
 		if (!addr)
 			return -EINVAL;
 
-		if (save_stack_address(trace, addr, false))
+		if (!consume_entry(cookie, addr, false))
 			return -EINVAL;
 	}
 
@@ -132,32 +88,6 @@ static int __always_inline
 	return 0;
 }
 
-/*
- * This function returns an error if it detects any unreliable features of the
- * stack.  Otherwise it guarantees that the stack trace is reliable.
- *
- * If the task is not 'current', the caller *must* ensure the task is inactive.
- */
-int save_stack_trace_tsk_reliable(struct task_struct *tsk,
-				  struct stack_trace *trace)
-{
-	int ret;
-
-	/*
-	 * If the task doesn't have a stack (e.g., a zombie), the stack is
-	 * "reliably" empty.
-	 */
-	if (!try_get_task_stack(tsk))
-		return 0;
-
-	ret = __save_stack_trace_reliable(trace, tsk);
-
-	put_task_stack(tsk);
-
-	return ret;
-}
-#endif /* CONFIG_HAVE_RELIABLE_STACKTRACE */
-
 /* Userspace stacktrace - based on kernel/trace/trace_sysprof.c */
 
 struct stack_frame_user {
@@ -182,15 +112,15 @@ copy_stack_frame(const void __user *fp,
 	return ret;
 }
 
-static inline void __save_stack_trace_user(struct stack_trace *trace)
+void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
+			  const struct pt_regs *regs)
 {
-	const struct pt_regs *regs = task_pt_regs(current);
 	const void __user *fp = (const void __user *)regs->bp;
 
-	if (trace->nr_entries < trace->max_entries)
-		trace->entries[trace->nr_entries++] = regs->ip;
+	if (!consume_entry(cookie, regs->ip, false))
+		return;
 
-	while (trace->nr_entries < trace->max_entries) {
+	while (1) {
 		struct stack_frame_user frame;
 
 		frame.next_fp = NULL;
@@ -200,8 +130,8 @@ static inline void __save_stack_trace_us
 		if ((unsigned long)fp < regs->sp)
 			break;
 		if (frame.ret_addr) {
-			trace->entries[trace->nr_entries++] =
-				frame.ret_addr;
+			if (!consume_entry(cookie, frame.ret_addr, false))
+				return;
 		}
 		if (fp == frame.next_fp)
 			break;
@@ -209,11 +139,3 @@ static inline void __save_stack_trace_us
 	}
 }
 
-void save_stack_trace_user(struct stack_trace *trace)
-{
-	/*
-	 * Trace user stack if we are not a kernel thread
-	 */
-	if (current->mm)
-		__save_stack_trace_user(trace);
-}


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
