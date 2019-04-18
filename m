Return-Path: <SRS0=+ohw=SU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15647C10F0E
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 09:34:44 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5498214DA
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 09:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5498214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3345B1520;
	Thu, 18 Apr 2019 09:34:38 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7157E11B0
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 09:34:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from Galois.linutronix.de (Galois.linutronix.de [146.0.238.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id EFBFA828
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 09:34:35 +0000 (UTC)
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
	by Galois.linutronix.de with esmtp (Exim 4.80)
	(envelope-from <tglx@linutronix.de>)
	id 1hH309-0001su-Qw; Thu, 18 Apr 2019 11:06:38 +0200
Message-Id: <20190418084254.729689921@linutronix.de>
User-Agent: quilt/0.65
Date: Thu, 18 Apr 2019 10:41:37 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V2 18/29] lockdep: Move stack trace logic into check_prev_add()
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
Message-ID: <20190418084137.YfA0Lh4VGxarTDcc3wqjOaQvnChcewsQyplmRtwQuzQ@z>

There is only one caller of check_prev_add() which hands in a zeroed struct
stack trace and a function pointer to save_stack(). Inside check_prev_add()
the stack_trace struct is checked for being empty, which is always
true. Based on that one code path stores a stack trace which is unused. The
comment there does not make sense either. It's all leftovers from
historical lockdep code (cross release).

Move the variable into check_prev_add() itself and cleanup the nonsensical
checks and the pointless stack trace recording.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/locking/lockdep.c |   30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2158,10 +2158,10 @@ check_deadlock(struct task_struct *curr,
  */
 static int
 check_prev_add(struct task_struct *curr, struct held_lock *prev,
-	       struct held_lock *next, int distance, struct stack_trace *trace,
-	       int (*save)(struct stack_trace *trace))
+	       struct held_lock *next, int distance)
 {
 	struct lock_list *uninitialized_var(target_entry);
+	struct stack_trace trace;
 	struct lock_list *entry;
 	struct lock_list this;
 	int ret;
@@ -2196,17 +2196,8 @@ check_prev_add(struct task_struct *curr,
 	this.class = hlock_class(next);
 	this.parent = NULL;
 	ret = check_noncircular(&this, hlock_class(prev), &target_entry);
-	if (unlikely(!ret)) {
-		if (!trace->entries) {
-			/*
-			 * If @save fails here, the printing might trigger
-			 * a WARN but because of the !nr_entries it should
-			 * not do bad things.
-			 */
-			save(trace);
-		}
+	if (unlikely(!ret))
 		return print_circular_bug(&this, target_entry, next, prev);
-	}
 	else if (unlikely(ret < 0))
 		return print_bfs_bug(ret);
 
@@ -2253,7 +2244,7 @@ check_prev_add(struct task_struct *curr,
 		return print_bfs_bug(ret);
 
 
-	if (!trace->entries && !save(trace))
+	if (!save_trace(&trace))
 		return 0;
 
 	/*
@@ -2262,14 +2253,14 @@ check_prev_add(struct task_struct *curr,
 	 */
 	ret = add_lock_to_list(hlock_class(next), hlock_class(prev),
 			       &hlock_class(prev)->locks_after,
-			       next->acquire_ip, distance, trace);
+			       next->acquire_ip, distance, &trace);
 
 	if (!ret)
 		return 0;
 
 	ret = add_lock_to_list(hlock_class(prev), hlock_class(next),
 			       &hlock_class(next)->locks_before,
-			       next->acquire_ip, distance, trace);
+			       next->acquire_ip, distance, &trace);
 	if (!ret)
 		return 0;
 
@@ -2287,12 +2278,6 @@ check_prevs_add(struct task_struct *curr
 {
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
@@ -2318,7 +2303,8 @@ check_prevs_add(struct task_struct *curr
 		 * added:
 		 */
 		if (hlock->read != 2 && hlock->check) {
-			int ret = check_prev_add(curr, hlock, next, distance, &trace, save_trace);
+			int ret = check_prev_add(curr, hlock, next, distance);
+
 			if (!ret)
 				return 0;
 


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
