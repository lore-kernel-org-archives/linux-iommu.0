Return-Path: <SRS0=4mi1=S3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E36C10F03
	for <iommu@archiver.kernel.org>; Thu, 25 Apr 2019 10:35:14 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C014F2084B
	for <iommu@archiver.kernel.org>; Thu, 25 Apr 2019 10:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C014F2084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 45ECD1D5D;
	Thu, 25 Apr 2019 10:34:27 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9EC691D27
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Apr 2019 10:33:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from Galois.linutronix.de (Galois.linutronix.de [146.0.238.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id DFF1274A
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Apr 2019 10:33:54 +0000 (UTC)
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
	by Galois.linutronix.de with esmtp (Exim 4.80)
	(envelope-from <tglx@linutronix.de>)
	id 1hJbA4-0001to-VQ; Thu, 25 Apr 2019 11:59:25 +0200
Message-Id: <20190425094802.622094226@linutronix.de>
User-Agent: quilt/0.65
Date: Thu, 25 Apr 2019 11:45:09 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V3 16/29] drm: Simplify stacktrace handling
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
	Mike Rapoport <rppt@linux.vnet.ibm.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Sterba <dsterba@suse.com>, Dmitry Vyukov <dvyukov@google.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Chris Mason <clm@fb.com>,
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
Message-ID: <20190425094509.edr3NyN0cmuj3_WF9-dfm8hSH0WN2uPOlO3ml-qSGBU@z>

Replace the indirection through struct stack_trace by using the storage
array based interfaces.

The original code in all printing functions is really wrong. It allocates a
storage array on stack which is unused because depot_fetch_stack() does not
store anything in it. It overwrites the entries pointer in the stack_trace
struct so it points to the depot storage.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Daniel Vetter <daniel@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 drivers/gpu/drm/drm_mm.c                |   22 +++++++---------------
 drivers/gpu/drm/i915/i915_vma.c         |   11 ++++-------
 drivers/gpu/drm/i915/intel_runtime_pm.c |   21 +++++++--------------
 3 files changed, 18 insertions(+), 36 deletions(-)

--- a/drivers/gpu/drm/drm_mm.c
+++ b/drivers/gpu/drm/drm_mm.c
@@ -106,22 +106,19 @@
 static noinline void save_stack(struct drm_mm_node *node)
 {
 	unsigned long entries[STACKDEPTH];
-	struct stack_trace trace = {
-		.entries = entries,
-		.max_entries = STACKDEPTH,
-		.skip = 1
-	};
+	unsigned int n;
 
-	save_stack_trace(&trace);
+	n = stack_trace_save(entries, ARRAY_SIZE(entries), 1);
 
 	/* May be called under spinlock, so avoid sleeping */
-	node->stack = depot_save_stack(&trace, GFP_NOWAIT);
+	node->stack = stack_depot_save(entries, n, GFP_NOWAIT);
 }
 
 static void show_leaks(struct drm_mm *mm)
 {
 	struct drm_mm_node *node;
-	unsigned long entries[STACKDEPTH];
+	unsigned long *entries;
+	unsigned int nr_entries;
 	char *buf;
 
 	buf = kmalloc(BUFSZ, GFP_KERNEL);
@@ -129,19 +126,14 @@ static void show_leaks(struct drm_mm *mm
 		return;
 
 	list_for_each_entry(node, drm_mm_nodes(mm), node_list) {
-		struct stack_trace trace = {
-			.entries = entries,
-			.max_entries = STACKDEPTH
-		};
-
 		if (!node->stack) {
 			DRM_ERROR("node [%08llx + %08llx]: unknown owner\n",
 				  node->start, node->size);
 			continue;
 		}
 
-		depot_fetch_stack(node->stack, &trace);
-		snprint_stack_trace(buf, BUFSZ, &trace, 0);
+		nr_entries = stack_depot_fetch(node->stack, &entries);
+		stack_trace_snprint(buf, BUFSZ, entries, nr_entries, 0);
 		DRM_ERROR("node [%08llx + %08llx]: inserted at\n%s",
 			  node->start, node->size, buf);
 	}
--- a/drivers/gpu/drm/i915/i915_vma.c
+++ b/drivers/gpu/drm/i915/i915_vma.c
@@ -36,11 +36,8 @@
 
 static void vma_print_allocator(struct i915_vma *vma, const char *reason)
 {
-	unsigned long entries[12];
-	struct stack_trace trace = {
-		.entries = entries,
-		.max_entries = ARRAY_SIZE(entries),
-	};
+	unsigned long *entries;
+	unsigned int nr_entries;
 	char buf[512];
 
 	if (!vma->node.stack) {
@@ -49,8 +46,8 @@ static void vma_print_allocator(struct i
 		return;
 	}
 
-	depot_fetch_stack(vma->node.stack, &trace);
-	snprint_stack_trace(buf, sizeof(buf), &trace, 0);
+	nr_entries = stack_depot_fetch(vma->node.stack, &entries);
+	stack_trace_snprint(buf, sizeof(buf), entries, nr_entries, 0);
 	DRM_DEBUG_DRIVER("vma.node [%08llx + %08llx] %s: inserted at %s\n",
 			 vma->node.start, vma->node.size, reason, buf);
 }
--- a/drivers/gpu/drm/i915/intel_runtime_pm.c
+++ b/drivers/gpu/drm/i915/intel_runtime_pm.c
@@ -60,27 +60,20 @@
 static noinline depot_stack_handle_t __save_depot_stack(void)
 {
 	unsigned long entries[STACKDEPTH];
-	struct stack_trace trace = {
-		.entries = entries,
-		.max_entries = ARRAY_SIZE(entries),
-		.skip = 1,
-	};
+	unsigned int n;
 
-	save_stack_trace(&trace);
-	return depot_save_stack(&trace, GFP_NOWAIT | __GFP_NOWARN);
+	n = stack_trace_save(entries, ARRAY_SIZE(entries), 1);
+	return stack_depot_save(entries, n, GFP_NOWAIT | __GFP_NOWARN);
 }
 
 static void __print_depot_stack(depot_stack_handle_t stack,
 				char *buf, int sz, int indent)
 {
-	unsigned long entries[STACKDEPTH];
-	struct stack_trace trace = {
-		.entries = entries,
-		.max_entries = ARRAY_SIZE(entries),
-	};
+	unsigned long *entries;
+	unsigned int nr_entries;
 
-	depot_fetch_stack(stack, &trace);
-	snprint_stack_trace(buf, sz, &trace, indent);
+	nr_entries = stack_depot_fetch(stack, &entries);
+	stack_trace_snprint(buf, sz, entries, nr_entries, indent);
 }
 
 static void init_intel_runtime_pm_wakeref(struct drm_i915_private *i915)


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
