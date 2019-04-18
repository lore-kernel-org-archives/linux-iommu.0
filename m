Return-Path: <SRS0=+ohw=SU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B06C10F0E
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 09:33:24 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A790A214DA
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 09:33:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A790A214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5CE8114CF;
	Thu, 18 Apr 2019 09:33:24 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 83F34115D
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 09:33:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from Galois.linutronix.de (Galois.linutronix.de [146.0.238.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id CE827823
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 09:33:21 +0000 (UTC)
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
	by Galois.linutronix.de with esmtp (Exim 4.80)
	(envelope-from <tglx@linutronix.de>)
	id 1hH30N-0001wk-9B; Thu, 18 Apr 2019 11:06:51 +0200
Message-Id: <20190418084255.275696472@linutronix.de>
User-Agent: quilt/0.65
Date: Thu, 18 Apr 2019 10:41:43 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V2 24/29] tracing: Remove the last struct stack_trace usage
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
Message-ID: <20190418084143.0gnBv9GfAYWcei0OkwTiHvkp6ObFdU5Fx_QcyW1sxOs@z>

Simplify the stack retrieval code by using the storage array based
interface.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/trace/trace_stack.c |   42 ++++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -23,16 +23,7 @@
 static unsigned long stack_dump_trace[STACK_TRACE_ENTRIES];
 static unsigned stack_trace_index[STACK_TRACE_ENTRIES];
 
-/*
- * Reserve one entry for the passed in ip. This will allow
- * us to remove most or all of the stack size overhead
- * added by the stack tracer itself.
- */
-struct stack_trace stack_trace_max = {
-	.max_entries		= STACK_TRACE_ENTRIES - 1,
-	.entries		= &stack_dump_trace[0],
-};
-
+static unsigned int stack_trace_entries;
 static unsigned long stack_trace_max_size;
 static arch_spinlock_t stack_trace_max_lock =
 	(arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
@@ -49,10 +40,10 @@ static void print_max_stack(void)
 
 	pr_emerg("        Depth    Size   Location    (%d entries)\n"
 			   "        -----    ----   --------\n",
-			   stack_trace_max.nr_entries);
+			   stack_trace_entries);
 
-	for (i = 0; i < stack_trace_max.nr_entries; i++) {
-		if (i + 1 == stack_trace_max.nr_entries)
+	for (i = 0; i < stack_trace_entries; i++) {
+		if (i + 1 == stack_trace_entries)
 			size = stack_trace_index[i];
 		else
 			size = stack_trace_index[i] - stack_trace_index[i+1];
@@ -98,13 +89,12 @@ static void check_stack(unsigned long ip
 
 	stack_trace_max_size = this_size;
 
-	stack_trace_max.nr_entries = 0;
-	stack_trace_max.skip = 0;
-
-	save_stack_trace(&stack_trace_max);
+	stack_trace_entries = stack_trace_save(stack_dump_trace,
+					       ARRAY_SIZE(stack_dump_trace) - 1,
+					       0);
 
 	/* Skip over the overhead of the stack tracer itself */
-	for (i = 0; i < stack_trace_max.nr_entries; i++) {
+	for (i = 0; i < stack_trace_entries; i++) {
 		if (stack_dump_trace[i] == ip)
 			break;
 	}
@@ -113,7 +103,7 @@ static void check_stack(unsigned long ip
 	 * Some archs may not have the passed in ip in the dump.
 	 * If that happens, we need to show everything.
 	 */
-	if (i == stack_trace_max.nr_entries)
+	if (i == stack_trace_entries)
 		i = 0;
 
 	/*
@@ -131,13 +121,13 @@ static void check_stack(unsigned long ip
 	 * loop will only happen once. This code only takes place
 	 * on a new max, so it is far from a fast path.
 	 */
-	while (i < stack_trace_max.nr_entries) {
+	while (i < stack_trace_entries) {
 		int found = 0;
 
 		stack_trace_index[x] = this_size;
 		p = start;
 
-		for (; p < top && i < stack_trace_max.nr_entries; p++) {
+		for (; p < top && i < stack_trace_entries; p++) {
 			/*
 			 * The READ_ONCE_NOCHECK is used to let KASAN know that
 			 * this is not a stack-out-of-bounds error.
@@ -168,7 +158,7 @@ static void check_stack(unsigned long ip
 			i++;
 	}
 
-	stack_trace_max.nr_entries = x;
+	stack_trace_entries = x;
 
 	if (task_stack_end_corrupted(current)) {
 		print_max_stack();
@@ -270,7 +260,7 @@ static void *
 {
 	long n = *pos - 1;
 
-	if (n >= stack_trace_max.nr_entries)
+	if (n >= stack_trace_entries)
 		return NULL;
 
 	m->private = (void *)n;
@@ -334,7 +324,7 @@ static int t_show(struct seq_file *m, vo
 		seq_printf(m, "        Depth    Size   Location"
 			   "    (%d entries)\n"
 			   "        -----    ----   --------\n",
-			   stack_trace_max.nr_entries);
+			   stack_trace_entries);
 
 		if (!stack_tracer_enabled && !stack_trace_max_size)
 			print_disabled(m);
@@ -344,10 +334,10 @@ static int t_show(struct seq_file *m, vo
 
 	i = *(long *)v;
 
-	if (i >= stack_trace_max.nr_entries)
+	if (i >= stack_trace_entries)
 		return 0;
 
-	if (i + 1 == stack_trace_max.nr_entries)
+	if (i + 1 == stack_trace_entries)
 		size = stack_trace_index[i];
 	else
 		size = stack_trace_index[i] - stack_trace_index[i+1];


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
