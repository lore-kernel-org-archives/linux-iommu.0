Return-Path: <SRS0=4mi1=S3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F220C10F03
	for <iommu@archiver.kernel.org>; Thu, 25 Apr 2019 10:35:31 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EECA82084B
	for <iommu@archiver.kernel.org>; Thu, 25 Apr 2019 10:35:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EECA82084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BE8D01D3B;
	Thu, 25 Apr 2019 10:34:48 +0000 (UTC)
Received: from smtp2.linuxfoundation.org (smtp2.linux-foundation.org
	[172.17.192.36])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4996B1D49
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Apr 2019 10:34:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from Galois.linutronix.de (Galois.linutronix.de [146.0.238.70])
	by smtp2.linuxfoundation.org (Postfix) with ESMTPS id B8E521DD44
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Apr 2019 10:34:06 +0000 (UTC)
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
	by Galois.linutronix.de with esmtp (Exim 4.80)
	(envelope-from <tglx@linutronix.de>)
	id 1hJbAK-0001yx-7e; Thu, 25 Apr 2019 11:59:40 +0200
Message-Id: <20190425094803.437950229@linutronix.de>
User-Agent: quilt/0.65
Date: Thu, 25 Apr 2019 11:45:18 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V3 25/29] livepatch: Simplify stack trace retrieval
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
Message-ID: <20190425094518.GVKHtpVvCK0B7vqar6_4ww8xdpW9W7ttK6oJdf4HNW8@z>

Replace the indirection through struct stack_trace by using the storage
array based interfaces.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Miroslav Benes <mbenes@suse.cz>
---
 kernel/livepatch/transition.c |   22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -202,15 +202,15 @@ void klp_update_patch_state(struct task_
  * Determine whether the given stack trace includes any references to a
  * to-be-patched or to-be-unpatched function.
  */
-static int klp_check_stack_func(struct klp_func *func,
-				struct stack_trace *trace)
+static int klp_check_stack_func(struct klp_func *func, unsigned long *entries,
+				unsigned int nr_entries)
 {
 	unsigned long func_addr, func_size, address;
 	struct klp_ops *ops;
 	int i;
 
-	for (i = 0; i < trace->nr_entries; i++) {
-		address = trace->entries[i];
+	for (i = 0; i < nr_entries; i++) {
+		address = entries[i];
 
 		if (klp_target_state == KLP_UNPATCHED) {
 			 /*
@@ -254,29 +254,25 @@ static int klp_check_stack_func(struct k
 static int klp_check_stack(struct task_struct *task, char *err_buf)
 {
 	static unsigned long entries[MAX_STACK_ENTRIES];
-	struct stack_trace trace;
 	struct klp_object *obj;
 	struct klp_func *func;
-	int ret;
+	int ret, nr_entries;
 
-	trace.skip = 0;
-	trace.nr_entries = 0;
-	trace.max_entries = MAX_STACK_ENTRIES;
-	trace.entries = entries;
-	ret = save_stack_trace_tsk_reliable(task, &trace);
+	ret = stack_trace_save_tsk_reliable(task, entries, ARRAY_SIZE(entries));
 	WARN_ON_ONCE(ret == -ENOSYS);
-	if (ret) {
+	if (ret < 0) {
 		snprintf(err_buf, STACK_ERR_BUF_SIZE,
 			 "%s: %s:%d has an unreliable stack\n",
 			 __func__, task->comm, task->pid);
 		return ret;
 	}
+	nr_entries = ret;
 
 	klp_for_each_object(klp_transition_patch, obj) {
 		if (!obj->patched)
 			continue;
 		klp_for_each_func(obj, func) {
-			ret = klp_check_stack_func(func, &trace);
+			ret = klp_check_stack_func(func, entries, nr_entries);
 			if (ret) {
 				snprintf(err_buf, STACK_ERR_BUF_SIZE,
 					 "%s: %s:%d is sleeping on function %s\n",


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
