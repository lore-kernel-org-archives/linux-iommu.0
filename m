Return-Path: <SRS0=4mi1=S3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD09C282E1
	for <iommu@archiver.kernel.org>; Thu, 25 Apr 2019 10:00:38 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEC8B206BA
	for <iommu@archiver.kernel.org>; Thu, 25 Apr 2019 10:00:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC8B206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D23951C3B;
	Thu, 25 Apr 2019 10:00:09 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 473B61C16
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Apr 2019 09:59:35 +0000 (UTC)
X-Greylist: greylisting inactive for cl@linux.com in SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from Galois.linutronix.de (Galois.linutronix.de [146.0.238.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C786282A;
	Thu, 25 Apr 2019 09:59:34 +0000 (UTC)
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
	by Galois.linutronix.de with esmtp (Exim 4.80)
	(envelope-from <tglx@linutronix.de>)
	id 1hJbAB-0001vz-NK; Thu, 25 Apr 2019 11:59:32 +0200
Message-Id: <20190425094802.979089273@linutronix.de>
User-Agent: quilt/0.65
Date: Thu, 25 Apr 2019 11:45:13 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V3 20/29] tracing: Simplify stacktrace retrieval in histograms
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
Message-ID: <20190425094513.p-SqwxI9CzOQPlmib7m0Y68Psj33caogeM3soQSuGJY@z>

The indirection through struct stack_trace is not necessary at all. Use the
storage array based interface.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5186,7 +5186,6 @@ static void event_hist_trigger(struct ev
 	u64 var_ref_vals[TRACING_MAP_VARS_MAX];
 	char compound_key[HIST_KEY_SIZE_MAX];
 	struct tracing_map_elt *elt = NULL;
-	struct stack_trace stacktrace;
 	struct hist_field *key_field;
 	u64 field_contents;
 	void *key = NULL;
@@ -5198,14 +5197,9 @@ static void event_hist_trigger(struct ev
 		key_field = hist_data->fields[i];
 
 		if (key_field->flags & HIST_FIELD_FL_STACKTRACE) {
-			stacktrace.max_entries = HIST_STACKTRACE_DEPTH;
-			stacktrace.entries = entries;
-			stacktrace.nr_entries = 0;
-			stacktrace.skip = HIST_STACKTRACE_SKIP;
-
-			memset(stacktrace.entries, 0, HIST_STACKTRACE_SIZE);
-			save_stack_trace(&stacktrace);
-
+			memset(entries, 0, HIST_STACKTRACE_SIZE);
+			stack_trace_save(entries, HIST_STACKTRACE_DEPTH,
+					 HIST_STACKTRACE_SKIP);
 			key = entries;
 		} else {
 			field_contents = key_field->fn(key_field, elt, rbe, rec);


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
