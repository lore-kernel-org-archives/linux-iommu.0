Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248745;
	b=R0GKkRl4MRGlyT8ywcw7x095Lq/HjNyxUAgsT8nQcQrJpSMXlhfFkteNLirxOWuO58Js
	 6tq27/7Ye6p0QBujnixTIoi7hV9YQTkwLJwt1cSz+DE5Ei76/cCD8vhPQDpdDOv5KeTF3
	 318WKVn6ELdciatdSRmCWXANPqfqizZU11wBZr7VYgfkBIxqPnzOr46pk63UHfa2g1vRY
	 ho4yxXbgIZw6qQ7ukcwU2+I1fYy4AzreqYmy6/pGkQwPNl5Nm6II93s6VOtczmZ5d2nc3
	 grknG2PUJzFWgG6KAluHzOmY7FEzBbD5SqzDF63/657VmhFy0CoFas6bP7tzApLf+3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=0/dvRzQVgjcTxeEJOv62v1t2XC18vtWgl2ABIndXl9g=;
	b=BkW1BAa9za7E4ogB6BepAbNNV9GEA16L5xn6nFRFnLJOUIS/8fHLymdHl0uHD5vr0UWy
	 uYpBnzzGhat15Vz6c0zDn5TKIQizbVgeS92WVgYoPP3ofHPYuqjK5znpQwRgOM9LI81t3
	 k3Xpvesxgt9H7o4TODz+bfdpVVqcn4X3axFHf/5A90RJNyKKfXKETqwsGyiZv1Z0dgR1S
	 C9Xl8vZWTyAdbf6jS573apL8Wp+sbDUqpTW+sPXhghynQ6FpG/xvuDrJ7/CuRlGql47QM
	 aHJxlfkC/ge+MinS319/eBCXd1aNcxvF059xzKkWub1vJ0qfrb+hJfEJ2XUVopatH4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jq+4QQbL;
	arc=none smtp.remote-ip=209.85.218.70
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6901A60A3815
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 18:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6901A60A3815
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jq+4QQbL
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c4cc4254c25so126592966b.0
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 10:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794248742; x=1794853542; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0/dvRzQVgjcTxeEJOv62v1t2XC18vtWgl2ABIndXl9g=;
        b=jq+4QQbLUVvzJfwB8kyZKIfqemLvkjqgs4j9p/S4/Mc/U6PesVcfyTP+RWBjSQtHu4
         lDOYYM/iM/m/Unwqp71ytB0q5aLo3inDYf3Cth6V4CateCdbG0AKQdqAn72R/HAQnAf2
         Wm2+ltoegFbX9p82/KP8/kwW3YblxG4rb76UIEKx96iKNdhSaFxiEk5mtUO9kPvMeiv8
         ZFSFJSaL4lZCvVzNtqLNhuTvAUDE53C89lRxWCepkOW7mx891k6ucLS1qUQ0A2tlfEWR
         BAZoU8Uh1iZWY92BfqGEylhf7wM1YLAnL/SJkBH75nREfm6yy3emqFNvjAynlXqjilEx
         XM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248742; x=1794853542;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0/dvRzQVgjcTxeEJOv62v1t2XC18vtWgl2ABIndXl9g=;
        b=iAPuR1agjiN6M5HZlX9Y+Awh2J0zzacjn90FpIoFJnwV7arS1tirl0UeeUEGkPTurT
         dzAyryf3VLN09+IRkU6lqoNrgZ5OxD3I8cL4L6H3juam1iTOVy9thn44r+nitjsVt3o1
         adSTd74BOFSQiIAUTXj+PmBUfljCZdR12yfgBDPyw3d6oaN4FKrPJead/2q7Rj9ZxmlU
         Vfs0GaPjaHzeQ2L5aor42iEHMRxqj7z/YQ6RXRCi1gaye+1hyLIgHrDiVu7SE/L0Csdm
         FKTeiZ58Vyh/SZM2AfglNPb/VJXpGBVDEFjHU8bb0PA7CaNboKtJ5brvOh0Y5UQIHIv4
         ntGw==
X-Forwarded-Encrypted: i=1; AL+hErEoYyKu8/IKdIRzhPv/N+HJLrjg34KrtU00TG4QP9nrqIfDnR4oReeCPlrwPz3CjOBDQqxpvA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/5XTcZs8HbSpI1CZ50yxSuIXDivTjzoQ87nNbo9VBtynJDrTJx
	D+afxaZB0PYnE/cA+tf/wDNzN2YTd5yP6pBlVqB5UCN7Jq+L/XIhSm28MQt9JUY6SJC6bQU3FvZ
	keXtsQg==
X-Received: from ejkh17.prod.google.com ([2002:a17:906:7191:b0:c31:9855:f7b6])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:3ea8:b0:c40:9b35:ad91
 with SMTP id a640c23a62f3a-c5049654279mr13765666b.13.1794248741532; Mon, 09
 Nov 2026 10:25:41 -0800 (PST)
Date: Mon,  9 Nov 2026 18:25:12 +0000
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
Message-ID: <20261109182533.3594984-5-lrizzo@google.com>
Subject: [RFC PATCH v2 04/25] iommu/dma: Add PISA block allocation
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

Add block allocation (pisa_alloc_bulk(), pisa_alloc())
and split_page_compound(), which splits a newly acquired 2MB PISA page
into blocks of the allocator's order, frozen at refcount 0.

Introduce __GFP_PISA_RO and __GFP_PISA_RW GFP flags and hook
__alloc_frozen_pages_noprof() and alloc_pages_bulk_noprof() so callers
can allocate from per-node PISA allocators (pisa_nodes[nid].pa[ro][order])
using standard page allocation APIs.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/iommu/pisa-alloc.c     | 345 +++++++++++++++++++++++++++++++++
 drivers/iommu/pisa-kunit.c     |  78 +++++++-
 drivers/iommu/pisa-priv.h      |  24 ++-
 include/linux/gfp_types.h      |  17 +-
 include/linux/pisa.h           |  25 +++
 include/trace/events/mmflags.h |  11 +-
 mm/page_alloc.c                |  40 +++-
 7 files changed, 527 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/pisa-alloc.c b/drivers/iommu/pisa-alloc.c
index cf559ee86d6f9..1f1b99023094c 100644
--- a/drivers/iommu/pisa-alloc.c
+++ b/drivers/iommu/pisa-alloc.c
@@ -14,13 +14,19 @@
 #include <linux/gfp.h>
 #include <linux/list.h>
 #include <linux/llist.h>
+#include <linux/memcontrol.h>
 #include <linux/mm.h>
 #include <linux/moduleparam.h>
 #include <linux/mutex.h>
+#include <linux/page_owner.h>
+#include <linux/pgalloc_tag.h>
 #include <linux/rcupdate.h>
+#include <linux/sched/mm.h>
+#include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
+#include <net/sock.h>
 
 #include "pisa-priv.h"
 
@@ -328,6 +334,318 @@ static void pisa_return_block_locked(struct pisa_alloc *pa, struct page *block,
 	*release |= pisa_place_meta(meta);
 }
 
+/*
+ * Return the predefined per-node allocator for (@nid, @order, @ro), or NULL.
+ */
+struct pisa_alloc *pisa_node_pa(int nid, unsigned int order, bool ro)
+{
+	if (order > PISA_ORDER)
+		return NULL;
+	nid = pisa_sanitize_nid(nid);
+
+	return pisa_nodes[nid].pa[ro][order];
+}
+
+/**
+ * pisa_alloc_pages_bulk - Allocate pages from a per-node __GFP_PISA_* allocator
+ * @gfp: GFP flags (must have __GFP_PISA_RW or __GFP_PISA_RO set)
+ * @order: Page order
+ * @preferred_nid: Preferred NUMA node (or NUMA_NO_NODE)
+ * @nodemask: Allowed NUMA nodemask (declined if non-NULL)
+ * @nr_pages: Total entries in @page_array
+ * @page_array: Output array of page pointers (populated entries are skipped)
+ * @frozen: Leave allocated pages frozen at refcount 0 if true
+ *
+ * Return: Number of populated entries at the start of @page_array.
+ */
+unsigned long pisa_alloc_pages_bulk(gfp_t gfp, unsigned int order, int preferred_nid,
+				    nodemask_t *nodemask, int nr_pages,
+				    struct page **page_array, bool frozen)
+{
+	struct pisa_alloc *pa = NULL;
+
+	if (unlikely(nr_pages <= 0))
+		return 0;
+	if (likely(!nodemask) && (!order || (gfp & __GFP_COMP)))
+		pa = pisa_node_pa(preferred_nid, order, !(gfp & __GFP_WRITE));
+	return pisa_alloc_bulk(pa, gfp & ~__GFP_PISA_RW, nr_pages, page_array, frozen);
+}
+
+/*
+ * Split a non-compound page of @old_order into 1 << (@old_order - @new_order)
+ * pages of @new_order (compound if @new_order > 0), all frozen at refcount 0.
+ * Fails with -EBUSY if a speculative PFN walker holds a reference to @page.
+ */
+static int split_page_compound(struct page *page, unsigned int old_order, unsigned int new_order)
+{
+	unsigned int i;
+
+	if (WARN_ON_ONCE(PageCompound(page) || !page_count(page) ||
+			 new_order > old_order ||
+			 folio_memcg_charged(page_folio(page))))
+		return -EINVAL;
+
+	/* Freeze @page[0] (1 -> 0) so all resulting pieces start at refcount 0. */
+	if (!page_ref_freeze(page, 1))
+		return -EBUSY;
+
+	if (new_order < old_order) {
+		split_page_owner(page, old_order, new_order);
+		pgalloc_tag_split(page_folio(page), old_order, new_order);
+	}
+
+	/* Subpages of non-compound pages are already initialized as order 0. */
+	if (new_order == 0)
+		return 0;
+
+	for (i = 0; i < (1U << old_order); i += (1U << new_order))
+		prep_compound_page(page + i, new_order);
+
+	return 0;
+}
+
+/* Obtain and split a new PISA page on @nid into blocks of @order. */
+static struct pisa_meta *pisa_alloc_split_page(unsigned int order, gfp_t gfp, int nid)
+{
+	bool can_block = gfpflags_allow_blocking(gfp), clean;
+	unsigned int bpp = PISA_BLOCKS(order);
+	struct pisa_meta *meta;
+	struct page *page;
+
+	/* __GFP_DMA/__GFP_DMA32 were already declined by pisa_alloc_bulk(). */
+	meta = pisa_reservoir_pop(nid, gfp & ~__GFP_ZERO, &clean);
+	if (IS_ERR(meta))
+		return meta;
+
+	page = pfn_to_page(pisa_meta_to_pfn(meta));
+
+	/* Fails with -EBUSY if a concurrent PFN walker holds a speculative ref. */
+	if (split_page_compound(page, PISA_ORDER, order)) {
+		pisa_release_page(meta);
+		pisa_alloc_backoff(nid, can_block);
+		return ERR_PTR(-EBUSY);
+	}
+
+	INIT_LIST_HEAD(&meta->list);
+
+	if (clean) {
+		bitmap_set(meta->clean_bitmap, 0, bpp);
+		meta->nr_clean = bpp;
+	} else {
+		bitmap_set(meta->dirty_bitmap, 0, bpp);
+		meta->nr_dirty = bpp;
+	}
+
+	return meta;
+}
+
+/* Reset fields normally cleared by prep_new_page()/post_alloc_hook(). */
+static void pisa_block_prep(struct page *block)
+{
+	set_page_private(block, 0);
+	clear_page_pfmemalloc(block);
+}
+
+/*
+ * Collect up to @want blocks from @meta's dirty or clean bitmap. With
+ * @unfreeze they get refcount 1; otherwise they stay at refcount 0.
+ */
+static unsigned int pisa_scan_bitmap(struct pisa_meta *meta, bool dirty,
+				     unsigned int want, struct page **out, bool unfreeze)
+{
+	unsigned long *bitmap = dirty ? meta->dirty_bitmap : meta->clean_bitmap;
+	u16 *countp = dirty ? &meta->nr_dirty : &meta->nr_clean;
+	struct pisa_alloc *pa = meta->pa;
+	unsigned int idx, got = 0, used = 0;
+	unsigned long base_pfn;
+
+	if (!*countp || !want)
+		return 0;
+
+	base_pfn = pisa_meta_to_pfn(meta);
+	for_each_set_bit(idx, bitmap, PISA_BLOCKS(pa->order)) {
+		struct page *block = pfn_to_page(base_pfn + (idx << pa->order));
+
+		__clear_bit(idx, bitmap);
+		used++;
+		if (!pisa_block_poisoned(pa, block)) {
+			pisa_block_prep(block);
+			if (unfreeze)
+				page_ref_unfreeze(block, 1);
+			out[got++] = block;
+		}
+
+		if (used == *countp || got == want)
+			break;
+	}
+	*countp -= used;
+	return got;
+}
+
+/* @zero: prefer PISA pages with blocks in @meta->clean_bitmap. */
+static struct pisa_meta *pisa_pick_meta(struct pisa_alloc *pa, bool zero)
+{
+	struct pisa_meta *m_dirty, *m_clean, *meta;
+
+	if (zero) {
+		/* Clean blocks first: the head of @partial, then of @idle. */
+		if (!list_empty(&pa->partial))
+			return list_first_entry(&pa->partial, struct pisa_meta, list);
+		meta = list_first_entry_or_null(&pa->idle, struct pisa_meta, list);
+		if (meta && meta->nr_clean) {
+			pa->num_idle_pages--;
+			WRITE_ONCE(pa->idle_jiffies, jiffies);
+			return meta;
+		}
+	}
+
+	m_dirty = list_first_entry_or_null(&pa->partial_dirty, struct pisa_meta, list);
+	m_clean = list_first_entry_or_null(&pa->partial, struct pisa_meta, list);
+	if (m_dirty && m_clean) {
+		bool dirty_dense = m_dirty->on_list == PISA_LIST_PARTIAL_DIRTY_DENSE;
+		bool clean_dense = m_clean->on_list == PISA_LIST_PARTIAL_CLEAN_DENSE;
+
+		if (dirty_dense != clean_dense)
+			return dirty_dense ? m_dirty : m_clean;
+		return pisa_meta_avail(m_dirty) <= pisa_meta_avail(m_clean) ?
+		       m_dirty : m_clean;
+	}
+	if (m_dirty)
+		return m_dirty;
+	if (m_clean)
+		return m_clean;
+	if (!list_empty(&pa->idle)) {
+		meta = list_last_entry(&pa->idle, struct pisa_meta, list);
+		pa->num_idle_pages--;
+		WRITE_ONCE(pa->idle_jiffies, jiffies);
+		return meta;
+	}
+	return NULL;
+}
+
+/* Extract up to @want blocks from @meta under @pa->lock. */
+static unsigned int take_blocks(struct pisa_meta *meta, unsigned int want,
+				struct page **out, bool zero, bool frozen)
+{
+	unsigned int avail_before = pisa_meta_avail(meta), got = 0, used;
+	struct pisa_alloc *pa = meta->pa;
+
+	lockdep_assert_held(&pa->lock);
+
+	if (zero) {
+		unsigned int dirty, i;
+
+		/* First choice are clean blocks, followed by dirty */
+		got += pisa_scan_bitmap(meta, false, want, out, !frozen);
+		dirty = pisa_scan_bitmap(meta, true, want - got, out + got, false);
+		for (i = got; i < got + dirty; i++)
+			set_page_private(out[i], 1);
+		got += dirty;
+	} else {
+		/* First choice are dirty blocks, followed by clean */
+		got += pisa_scan_bitmap(meta, true, want, out, !frozen);
+		got += pisa_scan_bitmap(meta, false, want - got, out + got, !frozen);
+	}
+
+	used = avail_before - pisa_meta_avail(meta);
+	/* If counts disagreed with bitmaps, zero them so @meta moves to @pa->full. */
+	if (WARN_ON_ONCE(!used)) {
+		meta->nr_clean = 0;
+		meta->nr_dirty = 0;
+	}
+	pisa_place_meta(meta);
+
+	return got;
+}
+
+/* Allocate @nr_pages blocks from @pa. */
+static unsigned long __pisa_alloc_bulk(struct pisa_alloc *pa, gfp_t gfp, unsigned long nr_pages,
+				       struct page **pages, bool zero, bool frozen)
+{
+	unsigned long n, flags, i;
+	struct pisa_meta *meta;
+	unsigned int want;
+
+	/* Held across bitmap scans; dropped around slow-path pisa_alloc_split_page(). */
+	spin_lock_irqsave(&pa->lock, flags);
+	for (n = 0; n < nr_pages; n += take_blocks(meta, want, &pages[n], zero, frozen)) {
+		want = min_t(unsigned long, nr_pages - n, PISA_BLOCKS(pa->order));
+		meta = pisa_pick_meta(pa, zero);
+		if (meta)
+			continue;
+
+		/* Fallback to a new allocation */
+		spin_unlock_irqrestore(&pa->lock, flags);
+		/* With @zero, fresh dirty blocks are zeroed below. */
+		meta = pisa_alloc_split_page(pa->order, gfp, pa->nid);
+		if (IS_ERR(meta))
+			goto out;
+		spin_lock_irqsave(&pa->lock, flags);
+		meta->pa = pa;
+		/* Set PISA_ACTIVE after @meta is fully set up. */
+		WRITE_ONCE(meta->flags, meta->flags | PISA_ACTIVE);
+	}
+	spin_unlock_irqrestore(&pa->lock, flags);
+
+out:
+	for (i = 0; zero && i < n; i++) {
+		/* Dirty blocks for a zeroing caller were marked with page_private = 1. */
+		if (!page_private(pages[i]))
+			continue;
+		set_page_private(pages[i], 0);
+		memset(page_address(pages[i]), 0, PAGE_SIZE << pa->order);
+		if (frozen) /* Order zeroing before caller publishes the page. */
+			smp_wmb();
+		else
+			page_ref_unfreeze(pages[i], 1);
+	}
+	return n;
+}
+
+/**
+ * pisa_alloc_bulk - Allocate up to @nr_pages blocks from @pa
+ * @pa: Allocator to allocate from
+ * @gfp: GFP flags (requests with __GFP_THISNODE, __GFP_DMA, __GFP_DMA32, or
+ *	__GFP_ACCOUNT are declined)
+ * @nr_pages: Number of entries in @page_array (populated entries are skipped)
+ * @page_array: Output array of page pointers
+ * @frozen: Leave allocated pages frozen at refcount 0 if true
+ *
+ * Return: Number of populated entries at the start of @page_array.
+ */
+unsigned long pisa_alloc_bulk(struct pisa_alloc *pa, gfp_t gfp,
+			      unsigned long nr_pages, struct page **page_array, bool frozen)
+{
+	unsigned long i = 0, n, got;
+
+	if (unlikely(!pa ||
+		     (gfp & (__GFP_DMA | __GFP_DMA32 | __GFP_THISNODE | __GFP_ACCOUNT))))
+		goto skip;
+
+	while (i < nr_pages) {
+		if (page_array[i]) {
+			i++;
+			continue;
+		}
+		/* Fill the run of @n NULL entries at @i. */
+		for (n = 1; i + n < nr_pages && !page_array[i + n]; n++)
+			;
+		got = __pisa_alloc_bulk(pa, gfp, n, page_array + i,
+					want_init_on_alloc(gfp), frozen);
+		i += got;
+		if (got < n)
+			break;
+	}
+	return i;
+
+skip:
+	/* Declined: report the populated prefix, as alloc_pages_bulk_node() does. */
+	while (i < nr_pages && page_array[i])
+		i++;
+	return i;
+}
+
+
 /**
  * __pisa_free_page - Recycle a freed block back into its PISA allocator
  * @page: Block being freed (called from __free_pages_prepare() under RCU)
@@ -372,8 +690,35 @@ bool __pisa_free_page(struct page *page)
 
 static int __init pisa_init(void)
 {
+	const struct {
+		u8 order;
+		bool ro;
+	} cfg[] = {
+		{ 0, false },
+		{ 2, true },
+		{ SKB_FRAG_PAGE_ORDER, true },
+	};
+	int nid, i;
+
 	pisa_node_init();
 
+	/* Preallocate the supported per-node allocators. */
+	for_each_node_state(nid, N_MEMORY) {
+		for (i = 0; i < ARRAY_SIZE(cfg); i++) {
+			unsigned int order = cfg[i].order;
+			bool ro = cfg[i].ro;
+			struct pisa_alloc *pa;
+
+			if (order > PISA_ORDER || pisa_nodes[nid].pa[ro][order])
+				continue;
+			pa = pisa_create(nid, order, ro ? DMA_TO_DEVICE : DMA_BIDIRECTIONAL);
+			if (!pa)
+				continue;
+			pisa_set_name(pa, "pisa%s_o%u_n%d", ro ? "_ro" : "", order, nid);
+			pisa_nodes[nid].pa[ro][order] = pa;
+		}
+	}
+
 	/* Dedicated WQ_MEM_RECLAIM workqueue so reclaim never blocks behind system_wq. */
 	pisa_wq = alloc_workqueue("pisa", WQ_MEM_RECLAIM, 0);
 	if (!pisa_wq)
diff --git a/drivers/iommu/pisa-kunit.c b/drivers/iommu/pisa-kunit.c
index 079f6220e742a..bdc52e6497b05 100644
--- a/drivers/iommu/pisa-kunit.c
+++ b/drivers/iommu/pisa-kunit.c
@@ -6,6 +6,8 @@
 #include <linux/gfp.h>
 #include <linux/pisa.h>
 #include <linux/mm.h>
+#include <linux/skbuff.h>
+#include <net/sock.h>
 
 #include "pisa-priv.h"
 
@@ -28,6 +30,7 @@ static void test_meta_init_and_roundtrip(struct kunit *test)
 
 	KUNIT_ASSERT_EQ(test, pisa_meta_ensure_pfn(pfn, true), 0);
 	m_pfn = pisa_meta_of_pfn(pfn);
+	KUNIT_EXPECT_PTR_EQ(test, pisa_meta_of_pfn(base_pfn), m_pfn);
 	KUNIT_EXPECT_EQ(test, pisa_meta_to_pfn(m_pfn), base_pfn);
 }
 
@@ -37,7 +40,7 @@ static void test_meta_invalid_phys(struct kunit *test)
 
 	KUNIT_ASSERT_EQ(test, pisa_meta_init(), 0);
 
-	meta = pisa_meta_of_pfn(PHYS_PFN(PHYS_ADDR_MAX));
+	meta = pisa_meta_of_pfn(ULONG_MAX >> PAGE_SHIFT);
 	KUNIT_ASSERT_NOT_NULL(test, meta);
 	KUNIT_EXPECT_EQ(test, pisa_meta_to_pfn(meta), ULONG_MAX);
 	KUNIT_EXPECT_FALSE(test, is_pisa_pfn(ULONG_MAX >> PAGE_SHIFT));
@@ -87,9 +90,78 @@ static void test_meta_active_toggle(struct kunit *test)
 
 static void test_alloc_and_recycle(struct kunit *test)
 {
-	KUNIT_EXPECT_NULL(test, pisa_create(NUMA_NO_NODE, 0, DMA_NONE));
-	KUNIT_EXPECT_NULL(test, pisa_create(NUMA_NO_NODE, PISA_ORDER + 1, DMA_BIDIRECTIONAL));
+	const struct {
+		unsigned int order;
+		bool ro;
+	} cases[] = {
+		{ 0, false },
+		{ 2, true },
+		{ SKB_FRAG_PAGE_ORDER, true },
+	};
+	struct page *p1, *p2, *bulk[3];
+	struct pisa_alloc *pa;
+	unsigned int i;
+
+	KUNIT_EXPECT_NULL(test, pisa_create(first_memory_node, 0, DMA_NONE));
+	KUNIT_EXPECT_NULL(test, pisa_create(first_memory_node, PISA_ORDER + 1,
+					    DMA_BIDIRECTIONAL));
+	KUNIT_EXPECT_NULL(test, pisa_node_pa(first_memory_node, 1, false));
+	KUNIT_EXPECT_NULL(test, pisa_node_pa(first_memory_node, 0, true));
+	KUNIT_EXPECT_NULL(test, pisa_node_pa(first_memory_node, PISA_ORDER + 1, false));
 	pisa_set_name(NULL, "ignored");
+
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		unsigned int order = cases[i].order;
+
+		pa = pisa_node_pa(first_memory_node, order, cases[i].ro);
+		KUNIT_ASSERT_NOT_NULL(test, pa);
+		KUNIT_EXPECT_NULL(test, pisa_alloc(pa, GFP_KERNEL | __GFP_ACCOUNT));
+		KUNIT_EXPECT_NULL(test, pisa_alloc(pa, GFP_KERNEL | __GFP_DMA32));
+		KUNIT_EXPECT_NULL(test, pisa_alloc(pa, GFP_KERNEL | __GFP_THISNODE));
+
+		p1 = pisa_alloc(pa, GFP_KERNEL | __GFP_ZERO);
+		KUNIT_ASSERT_NOT_NULL(test, p1);
+		KUNIT_EXPECT_TRUE(test, is_pisa_page(p1));
+
+		/* Freeing p1 returns it to the allocator; next allocation reuses index 0. */
+		__free_pages(p1, order);
+		p2 = pisa_alloc(pa, GFP_KERNEL);
+		KUNIT_ASSERT_NOT_NULL(test, p2);
+		if (!want_init_on_alloc(GFP_KERNEL) || want_init_on_free() || order == PISA_ORDER)
+			KUNIT_EXPECT_PTR_EQ(test, p1, p2);
+
+		if (order == 0) {
+			/* Bulk alloc skips already populated entries. */
+			bulk[0] = NULL;
+			bulk[1] = p2;
+			bulk[2] = NULL;
+			KUNIT_EXPECT_EQ(test,
+					pisa_alloc_bulk(pa, GFP_KERNEL, 3, bulk, false),
+					3UL);
+			KUNIT_EXPECT_PTR_EQ(test, bulk[1], p2);
+			KUNIT_EXPECT_NOT_NULL(test, bulk[0]);
+			KUNIT_EXPECT_NOT_NULL(test, bulk[2]);
+			/* Declined GFP reports populated prefix length. */
+			KUNIT_EXPECT_EQ(test,
+					pisa_alloc_bulk(pa,
+							GFP_KERNEL | __GFP_ACCOUNT,
+							3, bulk, false),
+					3UL);
+			if (bulk[0])
+				__free_pages(bulk[0], 0);
+			if (bulk[2])
+				__free_pages(bulk[2], 0);
+		}
+
+		if (p2)
+			__free_pages(p2, order);
+	}
+
+	/* Plain alloc_page() without __GFP_PISA_* comes from the buddy allocator. */
+	p1 = alloc_page(GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, p1);
+	KUNIT_EXPECT_FALSE(test, is_pisa_page(p1));
+	__free_pages(p1, 0);
 }
 
 static void test_reservoir_and_scrubber(struct kunit *test)
diff --git a/drivers/iommu/pisa-priv.h b/drivers/iommu/pisa-priv.h
index 0d097c665c790..f15934ccdeea4 100644
--- a/drivers/iommu/pisa-priv.h
+++ b/drivers/iommu/pisa-priv.h
@@ -100,6 +100,7 @@ struct pisa_alloc {
 /* Per-NUMA-node PISA state. */
 struct pisa_node {
 	unsigned long		next_alloc;	/* atomic alloc backoff jiffies */
+	struct pisa_alloc	*pa[2][PISA_ORDER + 1]; /* [0]=RW, [1]=RO by order */
 
 	spinlock_t		lock;		/* protects @pages and @nr_pages */
 	struct list_head	pages;		/* reservoir */
@@ -114,11 +115,6 @@ int pisa_meta_ensure_pfn(unsigned long pfn, bool can_block);
 struct pisa_meta *pisa_meta_of_pfn(unsigned long pfn);
 unsigned long pisa_meta_to_pfn(const struct pisa_meta *meta);
 
-struct pisa_alloc *pisa_create(int nid, unsigned int order, enum dma_data_direction dir);
-__printf(2, 3)
-void pisa_set_name(struct pisa_alloc *pa, const char *fmt, ...);
-void pisa_release_page(struct pisa_meta *meta);
-
 static inline int pisa_sanitize_nid(int nid)
 {
 	if ((unsigned int)nid >= MAX_NUMNODES || !node_state(nid, N_MEMORY))
@@ -135,6 +131,24 @@ static inline void pisa_alloc_backoff(int nid, bool can_block)
 		WRITE_ONCE(pisa_nodes[nid].next_alloc, jiffies + DIV_ROUND_UP(HZ, 100));
 }
 
+/* pisa-alloc.c, also used by the per-node code in pisa-node.c */
+struct pisa_alloc *pisa_create(int nid, unsigned int order, enum dma_data_direction dir);
+struct pisa_alloc *pisa_node_pa(int nid, unsigned int order, bool ro);
+__printf(2, 3)
+void pisa_set_name(struct pisa_alloc *pa, const char *fmt, ...);
+void pisa_release_page(struct pisa_meta *meta);
+unsigned long pisa_alloc_bulk(struct pisa_alloc *pa, gfp_t gfp,
+			      unsigned long nr_pages, struct page **page_array, bool frozen);
+
+static inline struct page *pisa_alloc(struct pisa_alloc *pa, gfp_t gfp)
+{
+	struct page *page = NULL;
+
+	if (pa)
+		pisa_alloc_bulk(pa, gfp, 1, &page, false);
+	return page;
+}
+
 /* pisa-node.c: per-NUMA-node PISA page reservoir and work item */
 extern unsigned int pisa_reservoir_max;
 void pisa_node_init(void);
diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index c1331bf0b2398..65fbfca3e08d1 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -33,7 +33,7 @@ enum {
 	___GFP_IO_BIT,
 	___GFP_FS_BIT,
 	___GFP_ZERO_BIT,
-	___GFP_UNUSED_BIT,	/* 0x200u unused */
+	___GFP_PISA_RO_BIT,
 	___GFP_DIRECT_RECLAIM_BIT,
 	___GFP_KSWAPD_RECLAIM_BIT,
 	___GFP_WRITE_BIT,
@@ -68,7 +68,11 @@ enum {
 #define ___GFP_IO		BIT(___GFP_IO_BIT)
 #define ___GFP_FS		BIT(___GFP_FS_BIT)
 #define ___GFP_ZERO		BIT(___GFP_ZERO_BIT)
-/* 0x200u unused */
+#ifdef CONFIG_PISA
+#define ___GFP_PISA_RO		BIT(___GFP_PISA_RO_BIT)
+#else
+#define ___GFP_PISA_RO		0
+#endif
 #define ___GFP_DIRECT_RECLAIM	BIT(___GFP_DIRECT_RECLAIM_BIT)
 #define ___GFP_KSWAPD_RECLAIM	BIT(___GFP_KSWAPD_RECLAIM_BIT)
 #define ___GFP_WRITE		BIT(___GFP_WRITE_BIT)
@@ -95,6 +99,11 @@ enum {
 #else
 #define ___GFP_NOLOCKDEP	0
 #endif
+#ifdef CONFIG_PISA
+#define ___GFP_PISA_RW			(___GFP_PISA_RO | ___GFP_WRITE)
+#else
+#define ___GFP_PISA_RW			0
+#endif
 
 /*
  * Physical address zone modifiers (see linux/mmzone.h - low four bits)
@@ -289,6 +298,10 @@ enum {
 /* Disable lockdep for GFP context tracking */
 #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
 
+/* Allocate from per-node PISA allocators (fall back to buddy on failure) */
+#define __GFP_PISA_RO			((__force gfp_t)___GFP_PISA_RO)
+#define __GFP_PISA_RW			((__force gfp_t)___GFP_PISA_RW)
+
 /* Room for N __GFP_FOO bits */
 #define __GFP_BITS_SHIFT ___GFP_LAST_BIT
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
diff --git a/include/linux/pisa.h b/include/linux/pisa.h
index dddcedb8c93f6..18ba1c83bd6d3 100644
--- a/include/linux/pisa.h
+++ b/include/linux/pisa.h
@@ -7,6 +7,7 @@
 #include <linux/bitops.h>
 #include <linux/jump_label.h>
 #include <linux/mm.h>
+#include <linux/numa.h>
 #include <linux/rcupdate.h>
 
 #ifdef CONFIG_PISA
@@ -72,6 +73,11 @@ static inline bool pisa_free_page(struct page *page)
 	return ret;
 }
 
+unsigned long pisa_alloc_pages_bulk(gfp_t gfp, unsigned int order,
+				    int preferred_nid, nodemask_t *nodemask,
+				    int nr_pages, struct page **page_array,
+				    bool frozen);
+
 #else /* !CONFIG_PISA */
 
 static inline int pisa_meta_init(void)
@@ -91,8 +97,26 @@ static inline bool pisa_free_page(struct page *page)
 	return false;
 }
 
+static inline unsigned long
+pisa_alloc_pages_bulk(gfp_t gfp, unsigned int order, int preferred_nid,
+		      nodemask_t *nodemask, int nr_pages,
+		      struct page **page_array, bool frozen)
+{
+	return 0;
+}
+
 #endif /* CONFIG_PISA */
 
+static inline struct page *
+pisa_alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
+		 nodemask_t *nodemask)
+{
+	struct page *page = NULL;
+
+	pisa_alloc_pages_bulk(gfp, order, preferred_nid, nodemask, 1, &page, true);
+	return page;
+}
+
 static inline bool is_pisa_phys(phys_addr_t phys)
 {
 	return is_pisa_pfn(phys >> PAGE_SHIFT);
@@ -102,4 +126,5 @@ static inline bool is_pisa_page(const struct page *page)
 {
 	return is_pisa_pfn(page_to_pfn(page));
 }
+
 #endif /* _LINUX_PISA_H */
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 3c153b3ad8450..65331bd8f0315 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -54,10 +54,18 @@
 # define TRACE_GFP_FLAGS_LOCKDEP
 #endif
 
+#ifdef CONFIG_PISA
+# define TRACE_GFP_FLAGS_PISA			\
+	TRACE_GFP_EM(PISA_RO)
+#else
+# define TRACE_GFP_FLAGS_PISA
+#endif
+
 #define TRACE_GFP_FLAGS				\
 	TRACE_GFP_FLAGS_GENERAL			\
 	TRACE_GFP_FLAGS_KASAN			\
-	TRACE_GFP_FLAGS_LOCKDEP
+	TRACE_GFP_FLAGS_LOCKDEP			\
+	TRACE_GFP_FLAGS_PISA
 
 #undef TRACE_GFP_EM
 #define TRACE_GFP_EM(a) TRACE_DEFINE_ENUM(___GFP_##a##_BIT);
@@ -65,7 +73,6 @@
 TRACE_GFP_FLAGS
 
 /* Just in case these are ever used */
-TRACE_DEFINE_ENUM(___GFP_UNUSED_BIT);
 TRACE_DEFINE_ENUM(___GFP_LAST_BIT);
 
 #define gfpflag_string(flag) {(__force unsigned long)flag, #flag}
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 48df87a19d312..b8e1f0fcb3f41 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1302,17 +1302,40 @@ static inline void pgalloc_tag_sub_pages(struct alloc_tag *tag, unsigned int nr)
 /*
  * pisa_free_page() in __free_pages_prepare() recycles a PISA block into
  * its allocator before the rest of that function runs. __pisa_free_page() calls
- * this to apply the buddy allocator's checks.
+ * this to apply the buddy allocator's checks, and to clear the order-0 state of
+ * blocks that were user pages (see drivers/iommu/pisa-user.c).
  *
  * Return: false if the block is in a bad state (already reported): leak it.
  */
 bool free_page_prepare_pisa(struct page *page, unsigned int order)
 {
+	struct folio *folio;
+	unsigned int i;
+
 	if (!IS_ENABLED(CONFIG_PISA))
 		return true;
+
+	folio = page_folio(page);
+
+	if (!order) {
+		if (unlikely(folio_test_mlocked(folio))) {
+			__folio_clear_mlocked(folio);
+			zone_stat_mod_folio(folio, NR_MLOCK, -1);
+			count_vm_events(UNEVICTABLE_PGCLEARED, 1);
+		}
+		folio->mapping = NULL;
+	}
 	if (is_check_pages_enabled() && free_page_is_bad(page))
 		return false;
 	page_table_check_free(page, order);
+	for (i = 0; i < (1U << order); i++)
+		page_kasan_tag_reset(page + i);
+	kasan_unpoison_range(page_address(page), PAGE_SIZE << order);
+	if (!order) {
+		page_cpupid_reset_last(page);
+		page->flags.f &= ~PAGE_FLAGS_CHECK_AT_PREP;
+		page->private = 0;
+	}
 	return true;
 }
 
@@ -5223,6 +5246,14 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	while (nr_populated < nr_pages && page_array[nr_populated])
 		nr_populated++;
 
+	if (unlikely(gfp & __GFP_PISA_RO)) {
+		nr_populated = pisa_alloc_pages_bulk(gfp, 0, preferred_nid, nodemask,
+						     nr_pages, page_array, false);
+		gfp &= ~__GFP_PISA_RW;
+		if (nr_populated == nr_pages)
+			goto out;
+	}
+
 	/* No pages requested? */
 	if (unlikely(nr_pages <= 0))
 		goto out;
@@ -5457,6 +5488,13 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
 		fastpath_alloc_flags |= ALLOC_WMARK_LOW;
 	}
 
+	if (unlikely(gfp & __GFP_PISA_RO)) {
+		page = pisa_alloc_pages(gfp, order, preferred_nid, nodemask);
+		if (page)
+			return page;
+		gfp &= ~__GFP_PISA_RW;
+	}
+
 	gfp &= gfp_allowed_mask;
 	/*
 	 * Apply scoped allocation constraints. This is mainly about GFP_NOFS
-- 
2.56.0.542.g3ef89b7020-goog

