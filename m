Return-Path: <SRS0=4mi1=S3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DB6C10F03
	for <iommu@archiver.kernel.org>; Thu, 25 Apr 2019 10:00:22 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FC9B206BA
	for <iommu@archiver.kernel.org>; Thu, 25 Apr 2019 10:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FC9B206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id EBE101C25;
	Thu, 25 Apr 2019 10:00:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4407A1C16
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Apr 2019 09:59:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from Galois.linutronix.de (Galois.linutronix.de [146.0.238.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 92F9574A
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Apr 2019 09:59:28 +0000 (UTC)
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
	by Galois.linutronix.de with esmtp (Exim 4.80)
	(envelope-from <tglx@linutronix.de>)
	id 1hJb9w-0001rd-FT; Thu, 25 Apr 2019 11:59:16 +0200
Message-Id: <20190425094802.067210525@linutronix.de>
User-Agent: quilt/0.65
Date: Thu, 25 Apr 2019 11:45:03 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V3 10/29] mm/page_owner: Simplify stack trace handling
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
Message-ID: <20190425094503._80nqebAQw3GyVeOdUrKV-vaTvwh3vpGy9_VMp1Tn0M@z>

Replace the indirection through struct stack_trace by using the storage
array based interfaces.

The original code in all printing functions is really wrong. It allocates a
storage array on stack which is unused because depot_fetch_stack() does not
store anything in it. It overwrites the entries pointer in the stack_trace
struct so it points to the depot storage.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/page_owner.c |   79 +++++++++++++++++++-------------------------------------
 1 file changed, 28 insertions(+), 51 deletions(-)

--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -58,15 +58,10 @@ static bool need_page_owner(void)
 static __always_inline depot_stack_handle_t create_dummy_stack(void)
 {
 	unsigned long entries[4];
-	struct stack_trace dummy;
+	unsigned int nr_entries;
 
-	dummy.nr_entries = 0;
-	dummy.max_entries = ARRAY_SIZE(entries);
-	dummy.entries = &entries[0];
-	dummy.skip = 0;
-
-	save_stack_trace(&dummy);
-	return depot_save_stack(&dummy, GFP_KERNEL);
+	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
+	return stack_depot_save(entries, nr_entries, GFP_KERNEL);
 }
 
 static noinline void register_dummy_stack(void)
@@ -120,46 +115,39 @@ void __reset_page_owner(struct page *pag
 	}
 }
 
-static inline bool check_recursive_alloc(struct stack_trace *trace,
-					unsigned long ip)
+static inline bool check_recursive_alloc(unsigned long *entries,
+					 unsigned int nr_entries,
+					 unsigned long ip)
 {
-	int i;
+	unsigned int i;
 
-	if (!trace->nr_entries)
-		return false;
-
-	for (i = 0; i < trace->nr_entries; i++) {
-		if (trace->entries[i] == ip)
+	for (i = 0; i < nr_entries; i++) {
+		if (entries[i] == ip)
 			return true;
 	}
-
 	return false;
 }
 
 static noinline depot_stack_handle_t save_stack(gfp_t flags)
 {
 	unsigned long entries[PAGE_OWNER_STACK_DEPTH];
-	struct stack_trace trace = {
-		.nr_entries = 0,
-		.entries = entries,
-		.max_entries = PAGE_OWNER_STACK_DEPTH,
-		.skip = 2
-	};
 	depot_stack_handle_t handle;
+	unsigned int nr_entries;
 
-	save_stack_trace(&trace);
+	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 2);
 
 	/*
-	 * We need to check recursion here because our request to stackdepot
-	 * could trigger memory allocation to save new entry. New memory
-	 * allocation would reach here and call depot_save_stack() again
-	 * if we don't catch it. There is still not enough memory in stackdepot
-	 * so it would try to allocate memory again and loop forever.
+	 * We need to check recursion here because our request to
+	 * stackdepot could trigger memory allocation to save new
+	 * entry. New memory allocation would reach here and call
+	 * stack_depot_save_entries() again if we don't catch it. There is
+	 * still not enough memory in stackdepot so it would try to
+	 * allocate memory again and loop forever.
 	 */
-	if (check_recursive_alloc(&trace, _RET_IP_))
+	if (check_recursive_alloc(entries, nr_entries, _RET_IP_))
 		return dummy_handle;
 
-	handle = depot_save_stack(&trace, flags);
+	handle = stack_depot_save(entries, nr_entries, flags);
 	if (!handle)
 		handle = failure_handle;
 
@@ -337,16 +325,10 @@ print_page_owner(char __user *buf, size_
 		struct page *page, struct page_owner *page_owner,
 		depot_stack_handle_t handle)
 {
-	int ret;
-	int pageblock_mt, page_mt;
+	int ret, pageblock_mt, page_mt;
+	unsigned long *entries;
+	unsigned int nr_entries;
 	char *kbuf;
-	unsigned long entries[PAGE_OWNER_STACK_DEPTH];
-	struct stack_trace trace = {
-		.nr_entries = 0,
-		.entries = entries,
-		.max_entries = PAGE_OWNER_STACK_DEPTH,
-		.skip = 0
-	};
 
 	count = min_t(size_t, count, PAGE_SIZE);
 	kbuf = kmalloc(count, GFP_KERNEL);
@@ -375,8 +357,8 @@ print_page_owner(char __user *buf, size_
 	if (ret >= count)
 		goto err;
 
-	depot_fetch_stack(handle, &trace);
-	ret += snprint_stack_trace(kbuf + ret, count - ret, &trace, 0);
+	nr_entries = stack_depot_fetch(handle, &entries);
+	ret += stack_trace_snprint(kbuf + ret, count - ret, entries, nr_entries, 0);
 	if (ret >= count)
 		goto err;
 
@@ -407,14 +389,9 @@ void __dump_page_owner(struct page *page
 {
 	struct page_ext *page_ext = lookup_page_ext(page);
 	struct page_owner *page_owner;
-	unsigned long entries[PAGE_OWNER_STACK_DEPTH];
-	struct stack_trace trace = {
-		.nr_entries = 0,
-		.entries = entries,
-		.max_entries = PAGE_OWNER_STACK_DEPTH,
-		.skip = 0
-	};
 	depot_stack_handle_t handle;
+	unsigned long *entries;
+	unsigned int nr_entries;
 	gfp_t gfp_mask;
 	int mt;
 
@@ -438,10 +415,10 @@ void __dump_page_owner(struct page *page
 		return;
 	}
 
-	depot_fetch_stack(handle, &trace);
+	nr_entries = stack_depot_fetch(handle, &entries);
 	pr_alert("page allocated via order %u, migratetype %s, gfp_mask %#x(%pGg)\n",
 		 page_owner->order, migratetype_names[mt], gfp_mask, &gfp_mask);
-	print_stack_trace(&trace, 0);
+	stack_trace_print(entries, nr_entries, 0);
 
 	if (page_owner->last_migrate_reason != -1)
 		pr_alert("page has been migrated, last migrate reason: %s\n",


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
