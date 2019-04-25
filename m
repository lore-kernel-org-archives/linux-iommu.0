Return-Path: <SRS0=4mi1=S3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CA7C10F03
	for <iommu@archiver.kernel.org>; Thu, 25 Apr 2019 10:34:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA8CC2084B
	for <iommu@archiver.kernel.org>; Thu, 25 Apr 2019 10:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA8CC2084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 96962CC8;
	Thu, 25 Apr 2019 10:34:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B972F1D27
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Apr 2019 10:33:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from Galois.linutronix.de (Galois.linutronix.de [146.0.238.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5C62374A
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Apr 2019 10:33:44 +0000 (UTC)
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
	by Galois.linutronix.de with esmtp (Exim 4.80)
	(envelope-from <tglx@linutronix.de>)
	id 1hJb9q-0001r1-8n; Thu, 25 Apr 2019 11:59:10 +0200
Message-Id: <20190425094801.683039030@linutronix.de>
User-Agent: quilt/0.65
Date: Thu, 25 Apr 2019 11:44:59 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V3 06/29] latency_top: Simplify stack trace handling
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
Message-ID: <20190425094459.2jvUot7kaKrSQ-nDPmuhmX1TOyHVfgvLiGKBTkmUvJ8@z>

Replace the indirection through struct stack_trace with an invocation of
the storage array based interface.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/latencytop.c |   17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

--- a/kernel/latencytop.c
+++ b/kernel/latencytop.c
@@ -141,20 +141,6 @@ account_global_scheduler_latency(struct
 	memcpy(&latency_record[i], lat, sizeof(struct latency_record));
 }
 
-/*
- * Iterator to store a backtrace into a latency record entry
- */
-static inline void store_stacktrace(struct task_struct *tsk,
-					struct latency_record *lat)
-{
-	struct stack_trace trace;
-
-	memset(&trace, 0, sizeof(trace));
-	trace.max_entries = LT_BACKTRACEDEPTH;
-	trace.entries = &lat->backtrace[0];
-	save_stack_trace_tsk(tsk, &trace);
-}
-
 /**
  * __account_scheduler_latency - record an occurred latency
  * @tsk - the task struct of the task hitting the latency
@@ -191,7 +177,8 @@ void __sched
 	lat.count = 1;
 	lat.time = usecs;
 	lat.max = usecs;
-	store_stacktrace(tsk, &lat);
+
+	stack_trace_save_tsk(tsk, lat.backtrace, LT_BACKTRACEDEPTH, 0);
 
 	raw_spin_lock_irqsave(&latency_lock, flags);
 


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
