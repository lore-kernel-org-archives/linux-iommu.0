Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248743;
	b=yBnC5ra26Ok31O0wj3zfdip6aE/ouioG9mJry7hTGlGyKIEbqSCcsDwTUVKLWKHyFmhT
	 VOZZHvTJZwzWDTIfRGRV+xmBqeNUJi3jWlBmiwcsIX67BulF/NNpizqxMGu1SdozGfRtU
	 AwRUPN51b4u2OqH/fnjUTDQBcqMK6igR8YdO7n0wcUJwCGMuYOIguYUOuQYb9GdrjFBm8
	 dMLn/mtjCaYOFlzR4B88z7OJ6vv6szBHGzrQ+cUVg3pz2wkJmXMyjedi1iEqEFNKrITLE
	 07oP8/wfttxOPfdq1br/GEv8Q7s06zWtURGhqubAGkboIcibVmHzk18JVbzPYmLsOgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248743;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=EKH/c3hk/KLjxJEXD2H3KrIqAmWh0TyGFdVjmyb1yr4=;
	b=Qj8vw4CM/mic9aTggXznNKQMM9KsDH0/Z+oCMAJCYLJRsCQ0wghOiaVGWcv0tsj8oIPm
	 lK+WLYmVki2kQrXQMGnE2wxINVajMhZXxU0C1o/31xg8D8uvWgbkFHguTvUgJNlG6eINl
	 EGdbuHINzzZt/KnAH4ai4xTRpPsk/hMseR7cPqsrynRUCaj4EDZbxq0Tzf6zUCYOsRxTr
	 HbvMzJo/vWT599YOdt+tIsYLD2H7XVv03quBu7zz/iJjtlHMW+mXCJRGjSrEelnyahIM7
	 EajO4L/5wCISxfZLNg9DrD/SNKS77Vr+cXOQvMzAQ7iVTW+Q51GaDeJNL1BJMtshuGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Oz7nMy8w;
	arc=none smtp.remote-ip=209.85.208.69
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C86160A263D
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 18:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C86160A263D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Oz7nMy8w
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6b570bd4817so1232377a12.1
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 10:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794248741; x=1794853541; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EKH/c3hk/KLjxJEXD2H3KrIqAmWh0TyGFdVjmyb1yr4=;
        b=Oz7nMy8wqDgeIrvUwNxgLJ/x40beGzoqu+U+Y2NEIOkt5ZGrE/AzwuGb3X9PeFhxiX
         WLwRYP34U8iSGbsEyWb4c7hudDK/RuHwc8uWh6r/zOnrujElUPXhfFhXsfCRAEI3pIzo
         tj/3mjedTY+JFbhzRCX1xl5UcMM6Hih6IcznYv3zfoHU/QgV178jiLhFpbjcAZ4mCUNs
         JdtJJX5jYIN8VVNa984ugJMMgeBzBm2XwKfQQnHE7KfKmo8Vu9qw8DBCVd32+eh62NaQ
         ThBnyKAUePmN58c5InSKN1No3OFG7dIiNY87Lbc88FvLWa8P/6evmd8dg7lK5rKACi/4
         O22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248741; x=1794853541;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EKH/c3hk/KLjxJEXD2H3KrIqAmWh0TyGFdVjmyb1yr4=;
        b=IfmaOU+qzvQvN7zp8YYJXx4WGc4M608T6E2PZQQie8K0vugYppiySj5LDCTxrTEPSj
         M7DSkstvaucbPt4N+YPfYhjNcGP+ktrBdoIHOuOrFIvpFo7CNcW/8+faWx7k70oc+FcE
         0P8Cn4+h88vgVnw/oa74ATcLFirxuOo01cZbB7tSE30YM2xF/q4pEs90jJDWh1nlGZ6E
         oMXt+zu42KA56iuUc3VElh8rInTyX5jADtQN7QUn5Phu/HRBSCg+1lXvCHt+xnRdNSKU
         j6QIEBgh0Wf5LdC6bpbCyIwtimPDa5oMJe761/U25l0wsgDM6oRN6ZRhjIvbxlPI3tld
         szzA==
X-Forwarded-Encrypted: i=1; AL+hErE8cKmVWI3sDpsvk3hcepKzcc5do5ydHr56QlVvD4JKANaX6HhPBRPwXsAVickiaBwfOv1Gbg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9d/+9PaImMQU+eRcyBLEui8g4VSIltZ6bQBqfBkTD2ur/S1cOt
	xmoGFGwM2IYWmfkFacTya2hEVUlMsbrkEpIzL/QZceCN6Vv99gm+ejnKi4DiRHVkiiXfL1xd8pg
	cIpru4g==
X-Received: from ejbbn2.prod.google.com ([2002:a17:906:c0c2:b0:c2e:774e:ca99])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:d09:b0:c40:b477:dfa0
 with SMTP id a640c23a62f3a-c504953fce3mr17865966b.18.1794248740573; Mon, 09
 Nov 2026 10:25:40 -0800 (PST)
Date: Mon,  9 Nov 2026 18:25:11 +0000
In-Reply-To: <20261003212241.3432303-1-lrizzo@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261109182533.3594984-4-lrizzo@google.com>
Subject: [RFC PATCH v2 03/25] iommu/dma: Add per-NUMA-node PISA page reservoir
From: Luigi Rizzo <lrizzo@google.com>
To: Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, David Hildenbrand <david@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	iommu@lists.linux.dev, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

Allocating a large page may involve compacting and blocking, so it cannot
be issued in GFP_ATOMIC context.

Add a per-NUMA-node reservoir of pre-allocated and set up PISA pages,
that can serve allocations without blocking. The reservoir is refilled in
process context by a per-node work item, queued with queue_work_node()
on system_dfl_wq so each node is refilled from its own CPUs, not bound
to the CPU that caused the miss.

pisa.reservoir_max, writable at runtime, sets the number of PISA pages
per node (default 16 = 32 MB per node; 0 = disabled).

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/iommu/Makefile     |   2 +-
 drivers/iommu/pisa-alloc.c |  17 ++-
 drivers/iommu/pisa-kunit.c |   7 +
 drivers/iommu/pisa-meta.c  |   1 +
 drivers/iommu/pisa-node.c  | 268 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/pisa-priv.h  |  30 +++++
 6 files changed, 323 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/pisa-node.c

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index bda0b102dd3ba..bc58166f9303a 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_IOMMU_API) += iommu-traces.o
 obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
 obj-$(CONFIG_IOMMU_DEBUGFS) += iommu-debugfs.o
 obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
-obj-$(CONFIG_PISA) += pisa-meta.o pisa-alloc.o
+obj-$(CONFIG_PISA) += pisa-meta.o pisa-alloc.o pisa-node.o
 obj-$(CONFIG_PISA_META_KUNIT_TEST) += pisa-kunit.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
diff --git a/drivers/iommu/pisa-alloc.c b/drivers/iommu/pisa-alloc.c
index 68f5d333ae15c..cf559ee86d6f9 100644
--- a/drivers/iommu/pisa-alloc.c
+++ b/drivers/iommu/pisa-alloc.c
@@ -46,6 +46,14 @@ module_param_named(idle_ms, pisa_idle_ms, uint, 0644);
 static LIST_HEAD(pisa_allocs);
 static DEFINE_RWLOCK(pisa_allocs_lock);
 
+/* Per-NUMA-node PISA state (ring/TX/user allocators, reservoir). */
+struct pisa_node pisa_nodes[MAX_NUMNODES] = {
+	[0 ... MAX_NUMNODES - 1] = {
+		.next_alloc = INITIAL_JIFFIES,
+		.lock = __SPIN_LOCK_UNLOCKED(pisa_nodes.lock),
+	},
+};
+
 static void pisa_schedule_reclaim(void);
 
 /*
@@ -75,8 +83,13 @@ static void pisa_release_page_rcu(struct rcu_head *head)
 }
 
 /* Unmap a retired PISA page, clear PISA_ACTIVE, and queue RCU release. */
-static void pisa_release_page(struct pisa_meta *meta)
+void pisa_release_page(struct pisa_meta *meta)
 {
+	if (!meta->pa) {
+		__free_pages(pfn_to_page(pisa_meta_to_pfn(meta)), PISA_ORDER);
+		return;
+	}
+
 	/* pisa_unmap_all(meta) will be called here once IOMMU mappings are added. */
 
 	/* Clear PISA_ACTIVE before the RCU grace period so new readers stop entering. */
@@ -359,6 +372,8 @@ bool __pisa_free_page(struct page *page)
 
 static int __init pisa_init(void)
 {
+	pisa_node_init();
+
 	/* Dedicated WQ_MEM_RECLAIM workqueue so reclaim never blocks behind system_wq. */
 	pisa_wq = alloc_workqueue("pisa", WQ_MEM_RECLAIM, 0);
 	if (!pisa_wq)
diff --git a/drivers/iommu/pisa-kunit.c b/drivers/iommu/pisa-kunit.c
index 12edc73abc9c6..079f6220e742a 100644
--- a/drivers/iommu/pisa-kunit.c
+++ b/drivers/iommu/pisa-kunit.c
@@ -92,11 +92,18 @@ static void test_alloc_and_recycle(struct kunit *test)
 	pisa_set_name(NULL, "ignored");
 }
 
+static void test_reservoir_and_scrubber(struct kunit *test)
+{
+	KUNIT_ASSERT_EQ(test, pisa_meta_init(), 0);
+	KUNIT_EXPECT_EQ(test, READ_ONCE(pisa_reservoir_max), 16U);
+}
+
 static struct kunit_case pisa_meta_test_cases[] = {
 	KUNIT_CASE(test_meta_init_and_roundtrip),
 	KUNIT_CASE(test_meta_invalid_phys),
 	KUNIT_CASE(test_meta_active_toggle),
 	KUNIT_CASE(test_alloc_and_recycle),
+	KUNIT_CASE(test_reservoir_and_scrubber),
 	{}
 };
 
diff --git a/drivers/iommu/pisa-meta.c b/drivers/iommu/pisa-meta.c
index 5ceea91e4d5e8..00939c366ba6d 100644
--- a/drivers/iommu/pisa-meta.c
+++ b/drivers/iommu/pisa-meta.c
@@ -272,6 +272,7 @@ int pisa_meta_init(void)
 
 	/* Register outside pisa_meta_mutex (taken by the notifier under chain lock). */
 	register_memory_notifier(&pisa_meta_memory_nb);
+	pisa_schedule_reservoir();
 	return 0;
 
 out_free_vm:
diff --git a/drivers/iommu/pisa-node.c b/drivers/iommu/pisa-node.c
new file mode 100644
index 0000000000000..524f0d4457ad7
--- /dev/null
+++ b/drivers/iommu/pisa-node.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * PISA per-NUMA-node state: PISA page reservoir and background work.
+ * See Documentation/core-api/pisa.rst for the architecture overview.
+ */
+
+#include <linux/atomic.h>
+#include <linux/pisa.h>
+#include <linux/err.h>
+#include <linux/gfp.h>
+#include <linux/list.h>
+#include <linux/mm.h>
+#include <linux/moduleparam.h>
+#include <linux/nodemask.h>
+#include <linux/sched.h>
+#include <linux/sched/mm.h>
+#include <linux/spinlock.h>
+#include <linux/topology.h>
+#include <linux/workqueue.h>
+
+#include "pisa-priv.h"
+
+/* Parameters are pisa.<name> at boot and in /sys/module/pisa/parameters/. */
+#undef MODULE_PARAM_PREFIX
+#define MODULE_PARAM_PREFIX "pisa."
+
+/*
+ * Per-NUMA-node reservoir of pre-allocated, pre-zeroed, and pre-decrypted
+ * PISA pages (pisa.reservoir_max, default 16, 0 = disabled). Refilled and
+ * trimmed by each node's work item on system_dfl_wq, which also scrubs
+ * allocators on that node.
+ */
+unsigned int pisa_reservoir_max __read_mostly = 16;
+
+static int pisa_reservoir_max_set(const char *val, const struct kernel_param *kp)
+{
+	int ret = param_set_uint(val, kp);
+
+	/* Schedule per-node workers to refill or trim once pisa_meta_init() has run. */
+	if (!ret && static_branch_unlikely(&pisa_key))
+		pisa_schedule_reservoir();
+	return ret;
+}
+
+static const struct kernel_param_ops pisa_reservoir_max_ops = {
+	.set = pisa_reservoir_max_set,
+	.get = param_get_uint,
+};
+module_param_cb(reservoir_max, &pisa_reservoir_max_ops, &pisa_reservoir_max, 0644);
+
+/* Apply GFP_NOFS/GFP_NOIO scope around internal GFP_KERNEL allocations. */
+static unsigned int pisa_memalloc_save(gfp_t gfp)
+{
+	unsigned int flags = 0;
+
+	if (!(gfp & __GFP_FS))
+		flags |= PF_MEMALLOC_NOFS;
+	if (!(gfp & __GFP_IO))
+		flags |= PF_MEMALLOC_NOIO;
+	return memalloc_flags_save(flags);
+}
+
+/* Allocate a PISA page from the buddy allocator and initialize its metadata. */
+static struct pisa_meta *__pisa_page_alloc(gfp_t gfp, int nid, bool can_block,
+					   bool *clean)
+{
+	struct pisa_meta *meta;
+	unsigned int memflags;
+	struct page *page;
+
+	if (unlikely(!static_branch_unlikely(&pisa_key))) {
+		if (!can_block || (gfp & (__GFP_FS | __GFP_IO)) != (__GFP_FS | __GFP_IO) ||
+		    pisa_meta_init())
+			return ERR_PTR(-EAGAIN);
+	}
+
+	/*
+	 * Long-lived active pages must be unmovable, lowmem, non-compound, and
+	 * must not dip into emergency reserves or trigger OOM/warnings.
+	 */
+	gfp &= ~(__GFP_COMP | __GFP_HIGHMEM | __GFP_MOVABLE);
+	gfp |= __GFP_NOWARN | __GFP_NOMEMALLOC | (can_block ? __GFP_RETRY_MAYFAIL : __GFP_NORETRY);
+
+	if (can_block)
+		memflags = pisa_memalloc_save(gfp);
+	page = alloc_pages_node(nid, gfp, PISA_ORDER);
+	if (!page) {
+		if (can_block)
+			memalloc_flags_restore(memflags);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/* Ensure the metadata chunk for this PFN is populated. */
+	if (unlikely(pisa_meta_ensure_pfn(page_to_pfn(page), can_block))) {
+		if (can_block)
+			memalloc_flags_restore(memflags);
+		__free_pages(page, PISA_ORDER);
+		return ERR_PTR(-ERANGE);
+	}
+	if (can_block)
+		memalloc_flags_restore(memflags);
+
+	meta = pisa_meta_of_pfn(page_to_pfn(page));
+	memset(meta, 0, sizeof(*meta));
+	*clean = (gfp & __GFP_ZERO) || want_init_on_alloc(0) || want_init_on_free();
+
+	return meta;
+}
+
+
+/* Refill node @nid's reservoir up to pisa_reservoir_max pre-zeroed PISA pages. */
+static void pisa_reservoir_refill_node(int nid)
+{
+	struct pisa_node *res = &pisa_nodes[nid];
+
+	while (res->nr_pages < READ_ONCE(pisa_reservoir_max)) {
+		struct pisa_meta *meta;
+		unsigned long flags;
+		bool clean;
+
+		meta = __pisa_page_alloc(GFP_KERNEL | __GFP_THISNODE, nid, true, &clean);
+		if (IS_ERR(meta))
+			break;
+
+		/* init_on_alloc/init_on_free pages are already zeroed. */
+		if (!clean)
+			memset(page_address(pfn_to_page(pisa_meta_to_pfn(meta))), 0, PISA_SIZE);
+
+		spin_lock_irqsave(&res->lock, flags);
+		list_add(&meta->list, &res->pages);
+		res->nr_pages++;
+		spin_unlock_irqrestore(&res->lock, flags);
+
+		cond_resched();
+	}
+}
+
+/* Release PISA pages in node @nid's reservoir above @max. */
+static void pisa_reservoir_trim_node(int nid, unsigned int max)
+{
+	struct pisa_node *res = &pisa_nodes[nid];
+	struct pisa_meta *meta, *tmp;
+	LIST_HEAD(free_list);
+	unsigned long flags;
+
+	spin_lock_irqsave(&res->lock, flags);
+	while (res->nr_pages > max && !list_empty(&res->pages)) {
+		list_move(res->pages.prev, &free_list);
+		res->nr_pages--;
+	}
+	spin_unlock_irqrestore(&res->lock, flags);
+
+	list_for_each_entry_safe(meta, tmp, &free_list, list) {
+		list_del_init(&meta->list);
+		pisa_release_page(meta);
+		cond_resched();
+	}
+}
+
+static void pisa_node_work_fn(struct work_struct *work)
+{
+	struct pisa_node *res = container_of(work, struct pisa_node, work);
+	int nid = res - pisa_nodes;
+	unsigned int max = READ_ONCE(pisa_reservoir_max);
+
+	if (unlikely(pisa_meta_init()))
+		return;
+
+	if (READ_ONCE(res->nr_pages) < max)
+		pisa_reservoir_refill_node(nid);
+	else if (READ_ONCE(res->nr_pages) > max)
+		pisa_reservoir_trim_node(nid, max);
+}
+
+/* Queue @nid's reservoir worker on a CPU belonging to @nid. */
+static void pisa_schedule_reservoir_node(int nid)
+{
+	if (nid >= 0 && nid < MAX_NUMNODES && node_state(nid, N_MEMORY))
+		queue_work_node(nid, system_dfl_wq, &pisa_nodes[nid].work);
+}
+
+/* Queue reservoir refill/trim workers on all memory nodes. */
+void pisa_schedule_reservoir(void)
+{
+	int nid;
+
+	for_each_node_state(nid, N_MEMORY)
+		pisa_schedule_reservoir_node(nid);
+}
+
+/* Pop one pre-prepared PISA page from node @nid's reservoir under @res->lock. */
+static struct pisa_meta *pisa_reservoir_pop_node(int nid, unsigned int max)
+{
+	struct pisa_node *res = &pisa_nodes[nid];
+	struct pisa_meta *meta;
+	unsigned long flags;
+	bool refill = false;
+
+	if (!READ_ONCE(res->nr_pages))
+		return NULL;
+
+	spin_lock_irqsave(&res->lock, flags);
+	meta = list_first_entry_or_null(&res->pages, struct pisa_meta, list);
+	if (meta) {
+		list_del_init(&meta->list);
+		res->nr_pages--;
+		refill = res->nr_pages <= max / 2;
+	}
+	spin_unlock_irqrestore(&res->lock, flags);
+
+	if (refill)
+		pisa_schedule_reservoir_node(nid);
+
+	return meta;
+}
+
+/*
+ * Pop a pre-prepared PISA page from @nid's reservoir (scheduling an async
+ * refill when <= half full or empty), or allocate one inline on miss.
+ */
+struct pisa_meta *pisa_reservoir_pop(int nid, gfp_t gfp, bool *clean)
+{
+	bool can_block = gfpflags_allow_blocking(gfp);
+	unsigned int max = READ_ONCE(pisa_reservoir_max);
+	struct pisa_meta *meta;
+
+	nid = pisa_sanitize_nid(nid);
+	if (max) {
+		meta = pisa_reservoir_pop_node(nid, max);
+		if (meta) {
+			*clean = true;
+			return meta;
+		}
+		/* Empty: pop_node() only schedules after a successful pop. */
+		pisa_schedule_reservoir_node(nid);
+	}
+
+	/* Back off briefly on GFP_ATOMIC if previous allocation on @nid failed. */
+	if (!can_block && time_before(jiffies, READ_ONCE(pisa_nodes[nid].next_alloc)))
+		return ERR_PTR(-EAGAIN);
+
+	meta = __pisa_page_alloc(gfp, nid, can_block, clean);
+	if (IS_ERR(meta))
+		pisa_alloc_backoff(nid, can_block);
+	return meta;
+}
+
+/* Number of PISA pages held in all the reservoirs. */
+unsigned long pisa_reservoir_count(void)
+{
+	unsigned long nr = 0;
+	int nid;
+
+	for_each_node_state(nid, N_MEMORY)
+		nr += READ_ONCE(pisa_nodes[nid].nr_pages);
+	return nr;
+}
+
+void __init pisa_node_init(void)
+{
+	int nid;
+
+	for (nid = 0; nid < MAX_NUMNODES; nid++) {
+		spin_lock_init(&pisa_nodes[nid].lock);
+		INIT_LIST_HEAD(&pisa_nodes[nid].pages);
+		INIT_WORK(&pisa_nodes[nid].work, pisa_node_work_fn);
+	}
+}
diff --git a/drivers/iommu/pisa-priv.h b/drivers/iommu/pisa-priv.h
index 769b0ef071705..0d097c665c790 100644
--- a/drivers/iommu/pisa-priv.h
+++ b/drivers/iommu/pisa-priv.h
@@ -4,12 +4,14 @@
 
 #include <linux/dma-direction.h>
 #include <linux/pisa.h>
+#include <linux/jiffies.h>
 #include <linux/list.h>
 #include <linux/llist.h>
 #include <linux/nodemask.h>
 #include <linux/spinlock.h>
 #include <linux/topology.h>
 #include <linux/types.h>
+#include <linux/workqueue.h>
 
 #ifdef CONFIG_PISA
 
@@ -95,6 +97,19 @@ struct pisa_alloc {
 	char			name[48];
 } ____cacheline_aligned;
 
+/* Per-NUMA-node PISA state. */
+struct pisa_node {
+	unsigned long		next_alloc;	/* atomic alloc backoff jiffies */
+
+	spinlock_t		lock;		/* protects @pages and @nr_pages */
+	struct list_head	pages;		/* reservoir */
+	unsigned int		nr_pages;
+	struct work_struct	work;		/* refill/trim, on this node */
+} ____cacheline_aligned_in_smp;
+
+/* Per-NUMA-node PISA state (ring/TX/user allocators, reservoir). */
+extern struct pisa_node pisa_nodes[MAX_NUMNODES];
+
 int pisa_meta_ensure_pfn(unsigned long pfn, bool can_block);
 struct pisa_meta *pisa_meta_of_pfn(unsigned long pfn);
 unsigned long pisa_meta_to_pfn(const struct pisa_meta *meta);
@@ -102,6 +117,7 @@ unsigned long pisa_meta_to_pfn(const struct pisa_meta *meta);
 struct pisa_alloc *pisa_create(int nid, unsigned int order, enum dma_data_direction dir);
 __printf(2, 3)
 void pisa_set_name(struct pisa_alloc *pa, const char *fmt, ...);
+void pisa_release_page(struct pisa_meta *meta);
 
 static inline int pisa_sanitize_nid(int nid)
 {
@@ -112,5 +128,19 @@ static inline int pisa_sanitize_nid(int nid)
 	return nid;
 }
 
+static inline void pisa_alloc_backoff(int nid, bool can_block)
+{
+	nid = pisa_sanitize_nid(nid);
+	if (!can_block)
+		WRITE_ONCE(pisa_nodes[nid].next_alloc, jiffies + DIV_ROUND_UP(HZ, 100));
+}
+
+/* pisa-node.c: per-NUMA-node PISA page reservoir and work item */
+extern unsigned int pisa_reservoir_max;
+void pisa_node_init(void);
+void pisa_schedule_reservoir(void);
+struct pisa_meta *pisa_reservoir_pop(int nid, gfp_t gfp, bool *clean);
+unsigned long pisa_reservoir_count(void);
+
 #endif /* CONFIG_PISA */
 #endif /* _DRIVERS_IOMMU_PISA_PRIV_H */
-- 
2.56.0.542.g3ef89b7020-goog

