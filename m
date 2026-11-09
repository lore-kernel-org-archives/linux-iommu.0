Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248745;
	b=SLGnzXiPgotedQ2SygnV9ytmLAc6QqKgOKih1QLjP3ttTJ02B8TichAe3Sc2K03T+PHk
	 L6zAiK4EA8PZIMu+DVEdxQ8AwQwtSxjmT2Ad4AwqibBbd738Ebn8n39k/Bi1i2iLhj+ho
	 XDYl3+Ejn9SBKVPLzdJQ51b7i4Z/AhcSCkC2LHG29Zz2CmgXVNVrX+6+Z722t56tT4KGH
	 YmKciYaZ7vB/+5+U6/4FpBKIljBte7JkgNPB6qjVCuRbktXWCzsW4aUVe4CsUoMkRIST1
	 RB95NwdkHX6z+mIFPVT2l6ZZ8kZrtk59++V1otym6yoyQzNdaWEsq/kYZp647IcjhZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=54ExQeOShcGppfyJua980qoDBOFtyYHHsHDIcQmw4W4=;
	b=Gpp09/2Ov22IztjyEZG0NtBWYf5x7L3iVwqLs76zmkwJIUChentdgl1Gy2JKNXc/1efA
	 h/WQ3XwNYcNeIu77dh3IqRfHgH1DTVpf6y6dufZdTR0wRhy61t49RGD18TirsYtdkz3ug
	 l54jNjZmm56YtMYrQGfxGmZD9jZH0KOQqb/c+1P63oYTVfrFCx0+grlKhJj4mc47AD6I/
	 FKSE33HD3SAzHKW+onlzuaps6tmSszfW5rtCW5myA5Xf//EOrzudflTR+nG3wl/Q9XfXQ
	 tKBnBPcpV33ReHhtUrF5b1mhJkIii1jM+WRAask5BrbqbJgJMnJVKkcWAAo7H7IyqyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bfuIBTYF;
	arc=none smtp.remote-ip=209.85.218.69
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFE960A382A
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 18:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CFE960A382A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bfuIBTYF
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c42f98f354fso102288666b.0
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 10:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794248742; x=1794853542; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=54ExQeOShcGppfyJua980qoDBOFtyYHHsHDIcQmw4W4=;
        b=bfuIBTYFCarSc6hXtAId5o5g/+AxfdZz+P1Ire9u4mUYvtcIidWjCRdgCjEdg7qiSK
         6tUy89nLIl3Ro/FUFnQr/bKvBYexJIEWN661zVcUh99R4eqCgXh56mHuxTQVK3pqDc7/
         UDkV2AzC5V+2EoQzn0p/Kps0lJO4G0iCdmJ81pxob5nWtrbtNH6Z3RKqTLrUpzEJw13+
         wjJ0jauCnu9KBDnqOAHh4o8JZ0Pi1C5OYcNrum6WbPA0+c+IcRw2F4AvvBM4CAvncp52
         1AuMO2OIEd2vsYIDhv8yxJS/5upH1kYMi4ZjJ3UoK19wwkyp+MkjOFecYeeL/YWPHZoj
         8jxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248742; x=1794853542;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=54ExQeOShcGppfyJua980qoDBOFtyYHHsHDIcQmw4W4=;
        b=LU1CjaM5TLO7c9KfiUlfnopWhOKBslEtK1qJLIfS2UrEWbAml4X66ohWMz68ZIWbK7
         RMEBjDcyBav0m2AKddJp1KGAiRqeHbHwSnY4EvvN9v+QCaw3szelx9PhCJWjeepTrNvb
         PifwVcTN4O/gLEyBijSzbxUElf9Nw+hE5VEB6BvBpSkbv+U+SJSX1Zs13MDJYHyvUfU8
         Ptze2or4c9R3YDQvjSOC37R+ZvHc1ni/xMsbX0q0aoMDYnf+ISVtb4lEptO7aIN/YgRs
         uYC0SVZhB4gj39uAjklgrtDLTjmd4daK8GV09ky7vYq0FGbJES6hOkGKca6VjAvQ7ceY
         EmzQ==
X-Forwarded-Encrypted: i=1; AL+hErFKvqcLxRmI1uy18q4YK+fcMPo2HoZwznsg+iubhxHnuvz8blypmpIw58NCQOAM2tY7O3lBBA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9MMo4BSlaSXh5IKydbPXbphWuZ7Fs73QBBG710SWKG/hxpYN2h
	bdQfRrS6R2NX4cVRpQ8SINnmcR1WmDkj2qs4NMeft4pB04SY8lL/yCPEJo4K5aNbzLnbU3DSzdf
	EmuaYMA==
X-Received: from ejblh15.prod.google.com ([2002:a17:906:f8cf:b0:c34:bb1f:3bc4])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:c155:b0:c2d:fade:e089
 with SMTP id a640c23a62f3a-c5048c88b3cmr21975766b.0.1794248742269; Mon, 09
 Nov 2026 10:25:42 -0800 (PST)
Date: Mon,  9 Nov 2026 18:25:13 +0000
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
Message-ID: <20261109182533.3594984-6-lrizzo@google.com>
Subject: [RFC PATCH v2 05/25] iommu/dma: Add global cap and shrinker for PISA pages
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

Add two mechanisms to bound the number of unused PISA pages:

 - a global ceiling, pisa.max_pages, on the number of PISA pages pinned
   across all allocators and reservoirs, defaulting to one eighth of RAM,
   with a floor for small machines.

 - a shrinker that, under reclaim, drains the per-node reservoirs first
   and then completely idle pages across all allocators.
   Idle pages are detached under the allocator lock but retired outside
   it, to avoid holding the lock during the expensive unmaps/iotlb flush.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/iommu/pisa-alloc.c | 91 ++++++++++++++++++++++++++++++++++++++
 drivers/iommu/pisa-kunit.c | 15 +++++++
 drivers/iommu/pisa-node.c  | 25 +++++++++++
 drivers/iommu/pisa-priv.h  | 15 +++++++
 4 files changed, 146 insertions(+)

diff --git a/drivers/iommu/pisa-alloc.c b/drivers/iommu/pisa-alloc.c
index 1f1b99023094c..de8009fd6fff3 100644
--- a/drivers/iommu/pisa-alloc.c
+++ b/drivers/iommu/pisa-alloc.c
@@ -4,6 +4,7 @@
  * See Documentation/core-api/pisa.rst for the architecture overview.
  */
 
+#include <kunit/visibility.h>
 #include <linux/atomic.h>
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
@@ -22,6 +23,7 @@
 #include <linux/pgalloc_tag.h>
 #include <linux/rcupdate.h>
 #include <linux/sched/mm.h>
+#include <linux/shrinker.h>
 #include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -40,6 +42,11 @@ static LLIST_HEAD(pisa_free_list);
 /* Dedicated WQ_MEM_RECLAIM workqueue, can run without allocations. */
 static struct workqueue_struct *pisa_wq __ro_after_init;
 
+/* Global count and ceiling on PISA pages across all allocators and reservoirs (0 = 1/8 RAM). */
+atomic_long_t pisa_nr_pages __cacheline_aligned_in_smp;
+unsigned long pisa_max_pages __read_mostly;
+module_param_named(max_pages, pisa_max_pages, ulong, 0644);
+
 /* Max completely idle PISA pages kept per allocator before async release. */
 static unsigned int pisa_max_idle __read_mostly = 1;
 module_param_named(max_idle, pisa_max_idle, uint, 0644);
@@ -81,6 +88,7 @@ static void pisa_release_page_rcu(struct rcu_head *head)
 
 	WRITE_ONCE(meta->pa, NULL);
 
+	atomic_long_dec(&pisa_nr_pages);
 	for (i = 0; i < PISA_BLOCKS(order); i++) {
 		block = page + (i << order);
 		page_ref_unfreeze(block, 1);
@@ -93,6 +101,7 @@ void pisa_release_page(struct pisa_meta *meta)
 {
 	if (!meta->pa) {
 		__free_pages(pfn_to_page(pisa_meta_to_pfn(meta)), PISA_ORDER);
+		atomic_long_dec(&pisa_nr_pages);
 		return;
 	}
 
@@ -688,6 +697,72 @@ bool __pisa_free_page(struct page *page)
 	return true;
 }
 
+/* Shrinker: releases reservoir pages first, then idle allocator pages. */
+static unsigned long pisa_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
+{
+	unsigned long nr = pisa_reservoir_count();
+	struct pisa_alloc *pa;
+
+	read_lock(&pisa_allocs_lock);
+	list_for_each_entry(pa, &pisa_allocs, node)
+		nr += READ_ONCE(pa->num_idle_pages);
+	read_unlock(&pisa_allocs_lock);
+
+	return nr << PISA_ORDER;
+}
+
+/* Detach PISA pages from @list onto @release_list up to @nr_to_scan base pages. */
+unsigned long pisa_shrink_list(spinlock_t *lock, struct list_head *list,
+			       unsigned int *nr, struct list_head *release_list,
+			       unsigned long nr_to_scan)
+{
+	unsigned long freed = 0, flags;
+
+	spin_lock_irqsave(lock, flags);
+	while (freed < nr_to_scan && !list_empty(list)) {
+		list_move(list->next, release_list);
+		(*nr)--;
+		freed += 1UL << PISA_ORDER;
+	}
+	spin_unlock_irqrestore(lock, flags);
+
+	return freed;
+}
+
+VISIBLE_IF_KUNIT unsigned long pisa_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
+{
+	struct pisa_meta *meta, *tmp;
+	struct pisa_alloc *pa;
+	unsigned long freed;
+	LIST_HEAD(release_list);
+
+	freed = pisa_reservoir_shrink(&release_list, sc->nr_to_scan);
+
+	if (freed < sc->nr_to_scan) {
+		read_lock(&pisa_allocs_lock);
+		list_for_each_entry(pa, &pisa_allocs, node) {
+			freed += pisa_shrink_list(&pa->lock, &pa->idle,
+						  &pa->num_idle_pages, &release_list,
+						  sc->nr_to_scan - freed);
+
+			if (freed >= sc->nr_to_scan)
+				break;
+		}
+		read_unlock(&pisa_allocs_lock);
+	}
+
+	/* Retiring must not run under @pa->lock. */
+	list_for_each_entry_safe(meta, tmp, &release_list, list) {
+		list_del_init(&meta->list);
+		pisa_release_page(meta);
+	}
+
+	/* Charge do_shrink_slab() for the full PISA pages reclaimed. */
+	sc->nr_scanned = freed;
+
+	return freed ?: SHRINK_STOP;
+}
+
 static int __init pisa_init(void)
 {
 	const struct {
@@ -698,10 +773,15 @@ static int __init pisa_init(void)
 		{ 2, true },
 		{ SKB_FRAG_PAGE_ORDER, true },
 	};
+	struct shrinker *shrink;
 	int nid, i;
 
 	pisa_node_init();
 
+	/* Default ceiling is 1/8th of RAM (floor of 16 PISA pages). */
+	if (!pisa_max_pages)
+		pisa_max_pages = max(totalram_pages() >> (PISA_ORDER + 3), 16UL);
+
 	/* Preallocate the supported per-node allocators. */
 	for_each_node_state(nid, N_MEMORY) {
 		for (i = 0; i < ARRAY_SIZE(cfg); i++) {
@@ -724,6 +804,17 @@ static int __init pisa_init(void)
 	if (!pisa_wq)
 		pr_warn("pisa: no reclaim workqueue, falling back to system_wq\n");
 
+	shrink = shrinker_alloc(0, "pisa");
+	if (!shrink) {
+		pr_warn("pisa: shrinker registration failed\n");
+		return 0;
+	}
+
+	shrink->count_objects = pisa_shrink_count;
+	shrink->scan_objects = pisa_shrink_scan;
+	shrink->seeks = DEFAULT_SEEKS;
+	shrinker_register(shrink);
+
 	return 0;
 }
 subsys_initcall(pisa_init);
diff --git a/drivers/iommu/pisa-kunit.c b/drivers/iommu/pisa-kunit.c
index bdc52e6497b05..96bc8dbc38fb4 100644
--- a/drivers/iommu/pisa-kunit.c
+++ b/drivers/iommu/pisa-kunit.c
@@ -6,6 +6,7 @@
 #include <linux/gfp.h>
 #include <linux/pisa.h>
 #include <linux/mm.h>
+#include <linux/shrinker.h>
 #include <linux/skbuff.h>
 #include <net/sock.h>
 
@@ -98,8 +99,10 @@ static void test_alloc_and_recycle(struct kunit *test)
 		{ 2, true },
 		{ SKB_FRAG_PAGE_ORDER, true },
 	};
+	struct shrink_control sc = { .nr_to_scan = ULONG_MAX };
 	struct page *p1, *p2, *bulk[3];
 	struct pisa_alloc *pa;
+	unsigned long old_max;
 	unsigned int i;
 
 	KUNIT_EXPECT_NULL(test, pisa_create(first_memory_node, 0, DMA_NONE));
@@ -115,6 +118,7 @@ static void test_alloc_and_recycle(struct kunit *test)
 
 		pa = pisa_node_pa(first_memory_node, order, cases[i].ro);
 		KUNIT_ASSERT_NOT_NULL(test, pa);
+		pisa_shrink_scan(NULL, &sc);
 		KUNIT_EXPECT_NULL(test, pisa_alloc(pa, GFP_KERNEL | __GFP_ACCOUNT));
 		KUNIT_EXPECT_NULL(test, pisa_alloc(pa, GFP_KERNEL | __GFP_DMA32));
 		KUNIT_EXPECT_NULL(test, pisa_alloc(pa, GFP_KERNEL | __GFP_THISNODE));
@@ -155,6 +159,7 @@ static void test_alloc_and_recycle(struct kunit *test)
 
 		if (p2)
 			__free_pages(p2, order);
+		pisa_shrink_scan(NULL, &sc);
 	}
 
 	/* Plain alloc_page() without __GFP_PISA_* comes from the buddy allocator. */
@@ -162,6 +167,16 @@ static void test_alloc_and_recycle(struct kunit *test)
 	KUNIT_ASSERT_NOT_NULL(test, p1);
 	KUNIT_EXPECT_FALSE(test, is_pisa_page(p1));
 	__free_pages(p1, 0);
+
+	/* Global budget cap (pisa_max_pages = 0) refuses new PISA pages. */
+	pa = pisa_node_pa(first_memory_node, 2, true);
+	KUNIT_ASSERT_NOT_NULL(test, pa);
+	old_max = READ_ONCE(pisa_max_pages);
+	WRITE_ONCE(pisa_max_pages, 0);
+	WRITE_ONCE(pisa_reservoir_max, 0);
+	KUNIT_EXPECT_NULL(test, pisa_alloc(pa, GFP_KERNEL));
+	WRITE_ONCE(pisa_reservoir_max, 16);
+	WRITE_ONCE(pisa_max_pages, old_max);
 }
 
 static void test_reservoir_and_scrubber(struct kunit *test)
diff --git a/drivers/iommu/pisa-node.c b/drivers/iommu/pisa-node.c
index 524f0d4457ad7..0f23b94a7a6f8 100644
--- a/drivers/iommu/pisa-node.c
+++ b/drivers/iommu/pisa-node.c
@@ -74,6 +74,10 @@ static struct pisa_meta *__pisa_page_alloc(gfp_t gfp, int nid, bool can_block,
 			return ERR_PTR(-EAGAIN);
 	}
 
+	/* Racy check against global ceiling across allocators and reservoirs. */
+	if (atomic_long_read(&pisa_nr_pages) >= READ_ONCE(pisa_max_pages))
+		return ERR_PTR(-ENOSPC);
+
 	/*
 	 * Long-lived active pages must be unmovable, lowmem, non-compound, and
 	 * must not dip into emergency reserves or trigger OOM/warnings.
@@ -102,6 +106,8 @@ static struct pisa_meta *__pisa_page_alloc(gfp_t gfp, int nid, bool can_block,
 
 	meta = pisa_meta_of_pfn(page_to_pfn(page));
 	memset(meta, 0, sizeof(*meta));
+
+	atomic_long_inc(&pisa_nr_pages);
 	*clean = (gfp & __GFP_ZERO) || want_init_on_alloc(0) || want_init_on_free();
 
 	return meta;
@@ -256,6 +262,25 @@ unsigned long pisa_reservoir_count(void)
 	return nr;
 }
 
+/* Detach up to @nr_to_scan base pages from reservoirs onto @release_list. */
+unsigned long pisa_reservoir_shrink(struct list_head *release_list, unsigned long nr_to_scan)
+{
+	unsigned long freed = 0;
+	int nid;
+
+	for_each_node_state(nid, N_MEMORY) {
+		struct pisa_node *res = &pisa_nodes[nid];
+
+		if (!READ_ONCE(res->nr_pages))
+			continue;
+		freed += pisa_shrink_list(&res->lock, &res->pages, &res->nr_pages,
+					  release_list, nr_to_scan - freed);
+		if (freed >= nr_to_scan)
+			break;
+	}
+	return freed;
+}
+
 void __init pisa_node_init(void)
 {
 	int nid;
diff --git a/drivers/iommu/pisa-priv.h b/drivers/iommu/pisa-priv.h
index f15934ccdeea4..d5ea83745ba47 100644
--- a/drivers/iommu/pisa-priv.h
+++ b/drivers/iommu/pisa-priv.h
@@ -115,6 +115,16 @@ int pisa_meta_ensure_pfn(unsigned long pfn, bool can_block);
 struct pisa_meta *pisa_meta_of_pfn(unsigned long pfn);
 unsigned long pisa_meta_to_pfn(const struct pisa_meta *meta);
 
+struct shrink_control;
+struct shrinker;
+#if IS_ENABLED(CONFIG_KUNIT)
+unsigned long pisa_shrink_scan(struct shrinker *shrink, struct shrink_control *sc);
+#endif
+
+/* Global PISA page budget across all allocators and per-node reservoirs. */
+extern atomic_long_t pisa_nr_pages;
+extern unsigned long pisa_max_pages;
+
 static inline int pisa_sanitize_nid(int nid)
 {
 	if ((unsigned int)nid >= MAX_NUMNODES || !node_state(nid, N_MEMORY))
@@ -149,12 +159,17 @@ static inline struct page *pisa_alloc(struct pisa_alloc *pa, gfp_t gfp)
 	return page;
 }
 
+unsigned long pisa_shrink_list(spinlock_t *lock, struct list_head *list,
+			       unsigned int *nr, struct list_head *release_list,
+			       unsigned long nr_to_scan);
+
 /* pisa-node.c: per-NUMA-node PISA page reservoir and work item */
 extern unsigned int pisa_reservoir_max;
 void pisa_node_init(void);
 void pisa_schedule_reservoir(void);
 struct pisa_meta *pisa_reservoir_pop(int nid, gfp_t gfp, bool *clean);
 unsigned long pisa_reservoir_count(void);
+unsigned long pisa_reservoir_shrink(struct list_head *release_list, unsigned long nr_to_scan);
 
 #endif /* CONFIG_PISA */
 #endif /* _DRIVERS_IOMMU_PISA_PRIV_H */
-- 
2.56.0.542.g3ef89b7020-goog

