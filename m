Return-Path: <SRS0=+ohw=SU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25ABC10F0E
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 09:34:11 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA52A214DA
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 09:34:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA52A214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1C41F115D;
	Thu, 18 Apr 2019 09:34:11 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 77929115D
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 09:34:09 +0000 (UTC)
X-Greylist: greylisting inactive for cl@linux.com in SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from Galois.linutronix.de (Galois.linutronix.de [146.0.238.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0704A466;
	Thu, 18 Apr 2019 09:34:09 +0000 (UTC)
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
	by Galois.linutronix.de with esmtp (Exim 4.80)
	(envelope-from <tglx@linutronix.de>)
	id 1hH30R-0001y0-Gu; Thu, 18 Apr 2019 11:06:55 +0200
Message-Id: <20190418084255.471038924@linutronix.de>
User-Agent: quilt/0.65
Date: Thu, 18 Apr 2019 10:41:45 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V2 26/29] stacktrace: Remove obsolete functions
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
Message-ID: <20190418084145.Ees-NvlQjCtay0VaIrTErgP5GGqiK5nwOcRHxUcvySE@z>

No more users of the struct stack_trace based interfaces. Remove them.

Remove the macro stubs for !CONFIG_STACKTRACE as well as they are pointless
because the storage on the call sites is conditional on CONFIG_STACKTRACE
already. No point to be 'smart'.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/stacktrace.h |   17 -----------------
 kernel/stacktrace.c        |   14 --------------
 2 files changed, 31 deletions(-)

--- a/include/linux/stacktrace.h
+++ b/include/linux/stacktrace.h
@@ -36,24 +36,7 @@ extern void save_stack_trace_tsk(struct
 				struct stack_trace *trace);
 extern int save_stack_trace_tsk_reliable(struct task_struct *tsk,
 					 struct stack_trace *trace);
-
-extern void print_stack_trace(struct stack_trace *trace, int spaces);
-extern int snprint_stack_trace(char *buf, size_t size,
-			struct stack_trace *trace, int spaces);
-
-#ifdef CONFIG_USER_STACKTRACE_SUPPORT
 extern void save_stack_trace_user(struct stack_trace *trace);
-#else
-# define save_stack_trace_user(trace)              do { } while (0)
-#endif
-
-#else /* !CONFIG_STACKTRACE */
-# define save_stack_trace(trace)			do { } while (0)
-# define save_stack_trace_tsk(tsk, trace)		do { } while (0)
-# define save_stack_trace_user(trace)			do { } while (0)
-# define print_stack_trace(trace, spaces)		do { } while (0)
-# define snprint_stack_trace(buf, size, trace, spaces)	do { } while (0)
-# define save_stack_trace_tsk_reliable(tsk, trace)	({ -ENOSYS; })
 #endif /* CONFIG_STACKTRACE */
 
 #if defined(CONFIG_STACKTRACE) && defined(CONFIG_HAVE_RELIABLE_STACKTRACE)
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -30,12 +30,6 @@ void stack_trace_print(unsigned long *en
 }
 EXPORT_SYMBOL_GPL(stack_trace_print);
 
-void print_stack_trace(struct stack_trace *trace, int spaces)
-{
-	stack_trace_print(trace->entries, trace->nr_entries, spaces);
-}
-EXPORT_SYMBOL_GPL(print_stack_trace);
-
 /**
  * stack_trace_snprint - Print the entries in the stack trace into a buffer
  * @buf:	Pointer to the print buffer
@@ -70,14 +64,6 @@ int stack_trace_snprint(char *buf, size_
 }
 EXPORT_SYMBOL_GPL(stack_trace_snprint);
 
-int snprint_stack_trace(char *buf, size_t size,
-			struct stack_trace *trace, int spaces)
-{
-	return stack_trace_snprint(buf, size, trace->entries,
-				   trace->nr_entries, spaces);
-}
-EXPORT_SYMBOL_GPL(snprint_stack_trace);
-
 /*
  * Architectures that do not implement save_stack_trace_*()
  * get these weak aliases and once-per-bootup warnings


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
