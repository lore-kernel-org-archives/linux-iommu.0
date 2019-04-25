Return-Path: <SRS0=4mi1=S3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85043C282E3
	for <iommu@archiver.kernel.org>; Thu, 25 Apr 2019 10:00:31 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63FE8217D7
	for <iommu@archiver.kernel.org>; Thu, 25 Apr 2019 10:00:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63FE8217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8E3F21C39;
	Thu, 25 Apr 2019 10:00:09 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 729D41C16
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Apr 2019 09:59:34 +0000 (UTC)
X-Greylist: greylisting inactive for cl@linux.com in SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from Galois.linutronix.de (Galois.linutronix.de [146.0.238.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5371A854;
	Thu, 25 Apr 2019 09:59:33 +0000 (UTC)
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
	by Galois.linutronix.de with esmtp (Exim 4.80)
	(envelope-from <tglx@linutronix.de>)
	id 1hJbA9-0001vH-Ry; Thu, 25 Apr 2019 11:59:30 +0200
Message-Id: <20190425094802.891724020@linutronix.de>
User-Agent: quilt/0.65
Date: Thu, 25 Apr 2019 11:45:12 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V3 19/29] lockdep: Simplify stack trace handling
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
Message-ID: <20190425094512.-SNLdYf6tNv9zIp6bB6nMwjX3qgQDk84NuKYXuoZPuM@z>

Replace the indirection through struct stack_trace by using the storage
array based interfaces and storing the information is a small lockdep
specific data structure.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/lockdep.h  |    9 +++++--
 kernel/locking/lockdep.c |   55 +++++++++++++++++++++++------------------------
 2 files changed, 35 insertions(+), 29 deletions(-)

--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -66,6 +66,11 @@ struct lock_class_key {
 
 extern struct lock_class_key __lockdep_no_validate__;
 
+struct lock_trace {
+	unsigned int		nr_entries;
+	unsigned int		offset;
+};
+
 #define LOCKSTAT_POINTS		4
 
 /*
@@ -100,7 +105,7 @@ struct lock_class {
 	 * IRQ/softirq usage tracking bits:
 	 */
 	unsigned long			usage_mask;
-	struct stack_trace		usage_traces[XXX_LOCK_USAGE_STATES];
+	struct lock_trace		usage_traces[XXX_LOCK_USAGE_STATES];
 
 	/*
 	 * Generation counter, when doing certain classes of graph walking,
@@ -188,7 +193,7 @@ struct lock_list {
 	struct list_head		entry;
 	struct lock_class		*class;
 	struct lock_class		*links_to;
-	struct stack_trace		trace;
+	struct lock_trace		trace;
 	int				distance;
 
 	/*
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -434,18 +434,14 @@ static void print_lockdep_off(const char
 #endif
 }
 
-static int save_trace(struct stack_trace *trace)
+static int save_trace(struct lock_trace *trace)
 {
-	trace->nr_entries = 0;
-	trace->max_entries = MAX_STACK_TRACE_ENTRIES - nr_stack_trace_entries;
-	trace->entries = stack_trace + nr_stack_trace_entries;
-
-	trace->skip = 3;
-
-	save_stack_trace(trace);
-
-	trace->max_entries = trace->nr_entries;
+	unsigned long *entries = stack_trace + nr_stack_trace_entries;
+	unsigned int max_entries;
 
+	trace->offset = nr_stack_trace_entries;
+	max_entries = MAX_STACK_TRACE_ENTRIES - nr_stack_trace_entries;
+	trace->nr_entries = stack_trace_save(entries, max_entries, 3);
 	nr_stack_trace_entries += trace->nr_entries;
 
 	if (nr_stack_trace_entries >= MAX_STACK_TRACE_ENTRIES-1) {
@@ -1196,7 +1192,7 @@ static struct lock_list *alloc_list_entr
 static int add_lock_to_list(struct lock_class *this,
 			    struct lock_class *links_to, struct list_head *head,
 			    unsigned long ip, int distance,
-			    struct stack_trace *trace)
+			    struct lock_trace *trace)
 {
 	struct lock_list *entry;
 	/*
@@ -1415,6 +1411,13 @@ static inline int __bfs_backwards(struct
  * checking.
  */
 
+static void print_lock_trace(struct lock_trace *trace, unsigned int spaces)
+{
+	unsigned long *entries = stack_trace + trace->offset;
+
+	stack_trace_print(entries, trace->nr_entries, spaces);
+}
+
 /*
  * Print a dependency chain entry (this is only done when a deadlock
  * has been detected):
@@ -1427,8 +1430,7 @@ print_circular_bug_entry(struct lock_lis
 	printk("\n-> #%u", depth);
 	print_lock_name(target->class);
 	printk(KERN_CONT ":\n");
-	print_stack_trace(&target->trace, 6);
-
+	print_lock_trace(&target->trace, 6);
 	return 0;
 }
 
@@ -1740,7 +1742,7 @@ static void print_lock_class_header(stru
 
 			len += printk("%*s   %s", depth, "", usage_str[bit]);
 			len += printk(KERN_CONT " at:\n");
-			print_stack_trace(class->usage_traces + bit, len);
+			print_lock_trace(class->usage_traces + bit, len);
 		}
 	}
 	printk("%*s }\n", depth, "");
@@ -1765,7 +1767,7 @@ print_shortest_lock_dependencies(struct
 	do {
 		print_lock_class_header(entry->class, depth);
 		printk("%*s ... acquired at:\n", depth, "");
-		print_stack_trace(&entry->trace, 2);
+		print_lock_trace(&entry->trace, 2);
 		printk("\n");
 
 		if (depth == 0 && (entry != root)) {
@@ -1878,14 +1880,14 @@ print_bad_irq_dependency(struct task_str
 	print_lock_name(backwards_entry->class);
 	pr_warn("\n... which became %s-irq-safe at:\n", irqclass);
 
-	print_stack_trace(backwards_entry->class->usage_traces + bit1, 1);
+	print_lock_trace(backwards_entry->class->usage_traces + bit1, 1);
 
 	pr_warn("\nto a %s-irq-unsafe lock:\n", irqclass);
 	print_lock_name(forwards_entry->class);
 	pr_warn("\n... which became %s-irq-unsafe at:\n", irqclass);
 	pr_warn("...");
 
-	print_stack_trace(forwards_entry->class->usage_traces + bit2, 1);
+	print_lock_trace(forwards_entry->class->usage_traces + bit2, 1);
 
 	pr_warn("\nother info that might help us debug this:\n\n");
 	print_irq_lock_scenario(backwards_entry, forwards_entry,
@@ -2158,7 +2160,7 @@ check_deadlock(struct task_struct *curr,
  */
 static int
 check_prev_add(struct task_struct *curr, struct held_lock *prev,
-	       struct held_lock *next, int distance, struct stack_trace *trace)
+	       struct held_lock *next, int distance, struct lock_trace *trace)
 {
 	struct lock_list *uninitialized_var(target_entry);
 	struct lock_list *entry;
@@ -2196,7 +2198,7 @@ check_prev_add(struct task_struct *curr,
 	this.parent = NULL;
 	ret = check_noncircular(&this, hlock_class(prev), &target_entry);
 	if (unlikely(!ret)) {
-		if (!trace->entries) {
+		if (!trace->nr_entries) {
 			/*
 			 * If save_trace fails here, the printing might
 			 * trigger a WARN but because of the !nr_entries it
@@ -2252,7 +2254,7 @@ check_prev_add(struct task_struct *curr,
 		return print_bfs_bug(ret);
 
 
-	if (!trace->entries && !save_trace(trace))
+	if (!trace->nr_entries && !save_trace(trace))
 		return 0;
 
 	/*
@@ -2284,14 +2286,9 @@ check_prev_add(struct task_struct *curr,
 static int
 check_prevs_add(struct task_struct *curr, struct held_lock *next)
 {
+	struct lock_trace trace = { .nr_entries = 0 };
 	int depth = curr->lockdep_depth;
 	struct held_lock *hlock;
-	struct stack_trace trace = {
-		.nr_entries = 0,
-		.max_entries = 0,
-		.entries = NULL,
-		.skip = 0,
-	};
 
 	/*
 	 * Debugging checks.
@@ -2719,6 +2716,10 @@ static inline int validate_chain(struct
 {
 	return 1;
 }
+
+static void print_lock_trace(struct lock_trace *trace, unsigned int spaces)
+{
+}
 #endif
 
 /*
@@ -2815,7 +2816,7 @@ print_usage_bug(struct task_struct *curr
 	print_lock(this);
 
 	pr_warn("{%s} state was registered at:\n", usage_str[prev_bit]);
-	print_stack_trace(hlock_class(this)->usage_traces + prev_bit, 1);
+	print_lock_trace(hlock_class(this)->usage_traces + prev_bit, 1);
 
 	print_irqtrace_events(curr);
 	pr_warn("\nother info that might help us debug this:\n");


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
