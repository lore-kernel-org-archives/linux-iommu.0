Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBDE4399C4
	for <iommu@lists.linux.dev>; Sat,  3 Oct 2026 21:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791062596; cv=none; b=W9k61whmIUqjdTdQqZKPGKYhE/1xhD3ETFSR4LCrZXilkiFkLJCBwe6523L4pOjwtTXurrVnslL1XSQQE9V7eMyX8RCysl2rbISjs3RIxHHTytA4iqCURIhOor5331akEXsL5MLGPtcNxezDhRSAARu7omRTHuC6k0bmik60K/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791062596; c=relaxed/simple;
	bh=7u9qTwVAWXI5MAFgewGcoaTlYcgOYP37j0/7wZFdjLA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SFE2OoJfS2CIp/oBbG4WH29H/V/QX3k4/upI8JP1G+688xA/7VU1dCXDCKkhJ2jKjpaiXDO/XNRRx7t2EOg3VFqOgW3GErSQ+G5Yod1telUWUvPfIcg4FwrPrF4ZZ5xIthjS9hMWmoIqu5jiivwMrCqUkQtGqt7wegFObnpG1+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DW2rpagM; arc=none smtp.client-ip=209.85.218.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DW2rpagM"
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c29bc25836fso82801866b.3
        for <iommu@lists.linux.dev>; Sat, 03 Oct 2026 14:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791062588; x=1791667388; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ruiMF87Q7JhX4xV02dgR8MOgre7MI5p5T6AzJckpwRA=;
        b=DW2rpagMSAkqRw3IcUeQNm8YptMG2tb0Qp5BvWk6DxYitRZJiGSuYJfnKHFGu2zW73
         e8XbRW4zv+eQtrJsADZUQcTXfJHWsNB4+4MKTHO8mMtJ+RNukE/X+HbPi1W6kHCTqFOs
         CQIbWklFHwr0IjUocxsAAPNQ6NirDhRdoJe0uYPeomHh5/I3HrjDpVJj77G2hGrnj+eG
         6U6aG7Bfe603I3jDzgvTEhjTvT/nmN9QJvlUKwdoUVgm+NhkDBQRKQ2KQyW9g1AG6GuE
         NRUwJfmOuWGlPdOGOEYjXIX4u7Zxfx2snjpR6ujnUSGPrlsH5YQlClc2ei+l2sirtQnE
         1MXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791062588; x=1791667388;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ruiMF87Q7JhX4xV02dgR8MOgre7MI5p5T6AzJckpwRA=;
        b=YBdaZVWl9ATN1kszb4cPlQ/E3SVCmzyvpsB0OJDaLQapVKodKD4B/90cEWVV8Cgmw3
         WeDOTFBTHZmu2N2jz2wSBLMQ/sjbmWCvQE/ieGYvGFI2bDiIlgONqckor3GdwVxRS/J0
         KSFg1VUKI8eEj1xUCVOnDc4cEmQL8T+EMUtHf6tvCR4QjP/FrAloImBMUAST2VAcLil7
         RR+Cyxc3T353e/btQfH2SzCGb8iaHHRdu/f6b++Q2zcXTGTcAZouOBWiaD13y8bCE9j0
         0OEfsvyahtJg6MGUKwYHTZEGbXHkwuQEaXyFQjW5ILdYQrdEx1apP1NwFPeCNE391Dqr
         hezQ==
X-Forwarded-Encrypted: i=1; AKwUvByBrYemSKjC91i1ClwA4iS1t+eWR2SdgomnnWRNbwGzY6pzWmFsEQ9Mup4uyzAtiESmtiR8Pg==@lists.linux.dev
X-Gm-Message-State: AFuF++nxxTmqrHvYSPDSJj+q103gJzhNajaxq2L6xGpgkgo9vDMyWPfe
	h6QuaotSy0SQqfP0e4KvOiy6rCBUt0jSjQJplEO9Adzlgt8BZebICIpbO4OKFfJwl9Yl2UmetLh
	i6r0aeQ==
X-Received: from ejra7.prod.google.com ([2002:a17:906:4687:b0:c2e:7ffa:c615])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:cf86:b0:c26:19de:9ad3
 with SMTP id a640c23a62f3a-c2e4af70e4emr531232766b.43.1791062587675; Sat, 03
 Oct 2026 14:23:07 -0700 (PDT)
Date: Sat,  3 Oct 2026 21:22:35 +0000
In-Reply-To: <20261003212241.3432303-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261003212241.3432303-17-lrizzo@google.com>
Subject: [RFC: DMA_PMD 16/22] iommu/dma: Add per-NUMA-node PMD page reservoir
From: Luigi Rizzo <lrizzo@google.com>
To: Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, David Hildenbrand <david@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, iommu@lists.linux.dev, netdev@vger.kernel.org, 
	linux-mm@kvack.org, driver-core@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a per-NUMA-node reservoir of pre-allocated, pre-zeroed, and
pre-prepared 2MB pages (dma_pmd_reservoirs[MAX_NUMNODES]) refilled in
process context by a background worker (dma_pmd_reservoir_work):

- Controlled by dma_pmd.reservoir_max (default 16 PMD pages = 32 MB per
  N_MEMORY node, subject to the global dma_pmd_max_pages ceiling).
- dma_pmd_add_page() first tries dma_pmd_reservoir_get(nid) (preferring
  the target NUMA node and falling back to other N_MEMORY nodes),
  avoiding blocking or failing order-9 buddy allocations on pool misses.
- When a node's reservoir drops to <= reservoir_max / 2 (or on pool
  creation), dma_pmd_reservoir_work is scheduled to refill in the
  background.
- Integrate the reservoir with dma_pmd_shrink_count() and
  dma_pmd_shrink_scan() so reservoir pages are reclaimed first under
  memory pressure.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/iommu/dma-pmd-pool.c | 307 +++++++++++++++++++++++++++++++----
 1 file changed, 277 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/dma-pmd-pool.c b/drivers/iommu/dma-pmd-pool.c
index d774cd05347b8..d48c8e19741ab 100644
--- a/drivers/iommu/dma-pmd-pool.c
+++ b/drivers/iommu/dma-pmd-pool.c
@@ -21,6 +21,7 @@
 #include <linux/mm.h>
 #include <linux/moduleparam.h>
 #include <linux/mutex.h>
+#include <linux/nodemask.h>
 #include <linux/rcupdate.h>
 #include <linux/seq_file.h>
 #include <linux/set_memory.h>
@@ -62,6 +63,18 @@ static atomic_long_t dma_pmd_nr_pages __cacheline_aligned_in_smp;
 static unsigned long dma_pmd_max_pages __read_mostly;
 core_param(dma_pmd_max_pages, dma_pmd_max_pages, ulong, 0644);
 
+/* Target number of pre-allocated PMD pages per NUMA node in reservoir. */
+static unsigned int dma_pmd_reservoir_max __read_mostly = 16;
+module_param_named(reservoir_max, dma_pmd_reservoir_max, uint, 0644);
+
+struct dma_pmd_reservoir {
+	spinlock_t		lock;	/* protects @pages and @nr_pages */
+	struct list_head	pages;
+	unsigned int		nr_pages;
+};
+
+static struct dma_pmd_reservoir dma_pmd_reservoirs[MAX_NUMNODES];
+
 /* All live pools. */
 static LIST_HEAD(dma_pmd_pools);
 static DEFINE_MUTEX(dma_pmd_pools_lock);
@@ -69,6 +82,7 @@ static LLIST_HEAD(dma_pmd_dead_pools);
 
 static void dma_pmd_schedule_reclaim(void);
 static void dma_pmd_schedule_scrub(void);
+static void dma_pmd_schedule_reservoir(void);
 
 static void dma_pmd_pool_free_kref(struct kref *kref)
 {
@@ -81,8 +95,10 @@ static void dma_pmd_pool_free_kref(struct kref *kref)
 static int dma_pmd_page_prepare(struct page *page, struct dma_pmd_meta *meta,
 				bool can_block)
 {
-	bool want_decrypt = READ_ONCE(dma_pmd_decrypt);
-	bool want_pin = READ_ONCE(dma_pmd_pin);
+	bool want_decrypt = READ_ONCE(dma_pmd_decrypt) &&
+			    !(meta->flags & DMA_PMD_DECRYPTED);
+	bool want_pin = READ_ONCE(dma_pmd_pin) &&
+			!(meta->flags & DMA_PMD_PINNED);
 	void *vaddr = page_address(page);
 	int ret;
 
@@ -142,6 +158,16 @@ static int dma_pmd_page_unprepare(struct dma_pmd_meta *meta)
 	return 0;
 }
 
+static void dma_pmd_free_reservoir_page(struct dma_pmd_meta *meta)
+{
+	struct page *page = pfn_to_page(dma_pmd_meta_to_pfn(meta));
+
+	if (!dma_pmd_page_unprepare(meta)) {
+		__free_pages(page, PMD_ORDER);
+		atomic_long_dec(&dma_pmd_nr_pages);
+	}
+}
+
 /*
  * Releasing an idle PMD page proceeds in three stages:
  *
@@ -226,8 +252,12 @@ static void dma_pmd_reclaim_work_fn(struct work_struct *work)
 	struct dma_pmd_pool *pool, *ptmp;
 	struct dma_pmd_meta *meta, *tmp;
 
-	llist_for_each_entry_safe(meta, tmp, node, llnode)
-		dma_pmd_release_page(meta);
+	llist_for_each_entry_safe(meta, tmp, node, llnode) {
+		if (meta->pool)
+			dma_pmd_release_page(meta);
+		else
+			dma_pmd_free_reservoir_page(meta);
+	}
 
 	node = llist_del_all(&dma_pmd_dead_pools);
 	if (node) {
@@ -463,6 +493,186 @@ static void dma_pmd_schedule_scrub(void)
 		schedule_work(&dma_pmd_scrub_work);
 }
 
+/*
+ * Per-NUMA-node PMD page reservoir
+ * --------------------------------
+ * Order-9 (2MB) buddy allocations can compact/reclaim and fail or stall in
+ * atomic context (such as NAPI RX refill or softirq TX), and CoCo decryption /
+ * hypervisor pinning cannot run in atomic context at all.
+ *
+ * Each NUMA node maintains a small reservoir of up to @dma_pmd_reservoir_max
+ * (default 8 = 16 MB/node) pre-allocated, pre-zeroed, and pre-decrypted/pinned
+ * PMD pages. On a pool miss, dma_pmd_add_page() pops a ready PMD page from the
+ * target node's reservoir in O(1) under a spinlock (falling back to other
+ * nodes before calling alloc_pages_node() directly).
+ *
+ * A background worker on system_wq refills nodes whenever a node's count drops
+ * to or below half of @dma_pmd_reservoir_max, on a reservoir miss, or when a
+ * new pool is created. Pages held in the reservoir count toward the global
+ * @dma_pmd_nr_pages budget and are reclaimable by the shrinker under memory
+ * pressure.
+ */
+
+/**
+ * dma_pmd_reservoir_refill_node - Refill node @nid's reservoir up to @max
+ * @nid: NUMA node ID
+ * @max: Target number of PMD pages to hold in @nid's reservoir
+ *
+ * Cost: Slow path; allocates order-9 pages with GFP_KERNEL | __GFP_RETRY_MAYFAIL,
+ *       populates metadata, decrypts/pins if configured, and zeroes 2MB per page.
+ * Locking: Process context (system_wq); sleeps during buddy allocation, CPA
+ *          decryption, and cond_resched(). Takes @res->lock briefly to enqueue.
+ * Frequency: Rare (when reservoir drops to <= @max / 2 or on pool creation).
+ */
+static void dma_pmd_reservoir_refill_node(int nid, unsigned int max)
+{
+	gfp_t gfp = GFP_KERNEL | __GFP_THISNODE | __GFP_NOWARN | __GFP_RETRY_MAYFAIL;
+	struct dma_pmd_reservoir *res = &dma_pmd_reservoirs[nid];
+
+	while (READ_ONCE(res->nr_pages) < max) {
+		struct dma_pmd_meta *meta;
+		unsigned long flags;
+		struct page *page;
+
+		if (atomic_long_inc_return(&dma_pmd_nr_pages) >
+		    READ_ONCE(dma_pmd_max_pages)) {
+			atomic_long_dec(&dma_pmd_nr_pages);
+			break;
+		}
+
+		page = alloc_pages_node(nid, gfp, PMD_ORDER);
+		if (!page) {
+			atomic_long_dec(&dma_pmd_nr_pages);
+			break;
+		}
+
+		if (unlikely(!dma_pmd_meta_ensure_pfn(page_to_pfn(page), true))) {
+			__free_pages(page, PMD_ORDER);
+			atomic_long_dec(&dma_pmd_nr_pages);
+			break;
+		}
+
+		meta = dma_pmd_meta_of_pfn(page_to_pfn(page));
+		memset(meta, 0, sizeof(*meta));
+		spin_lock_init(&meta->map_lock);
+
+		if (dma_pmd_page_prepare(page, meta, true)) {
+			__free_pages(page, PMD_ORDER);
+			atomic_long_dec(&dma_pmd_nr_pages);
+			break;
+		}
+
+		if (!(meta->flags & DMA_PMD_DECRYPTED))
+			memset(page_address(page), 0, PMD_SIZE);
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
+static void dma_pmd_reservoir_work_fn(struct work_struct *work)
+{
+	unsigned int max = READ_ONCE(dma_pmd_reservoir_max);
+	int nid;
+
+	if (!max || !dma_pmd_meta_base())
+		return;
+
+	for_each_node_state(nid, N_MEMORY)
+		dma_pmd_reservoir_refill_node(nid, max);
+}
+
+static DECLARE_WORK(dma_pmd_reservoir_work, dma_pmd_reservoir_work_fn);
+
+static void dma_pmd_schedule_reservoir(void)
+{
+	if (READ_ONCE(dma_pmd_reservoir_max) &&
+	    !work_pending(&dma_pmd_reservoir_work))
+		schedule_work(&dma_pmd_reservoir_work);
+}
+
+/*
+ * Pop one pre-prepared PMD page from node @nid's reservoir.
+ *
+ * Cost: O(1) list pop under @res->lock.
+ * Locking: Acquires @res->lock (irqsave). Safe from any context (IRQ, softirq,
+ *          process). Never sleeps.
+ * Frequency: Only on pool miss (dma_pmd_add_page()).
+ */
+static struct dma_pmd_meta *dma_pmd_reservoir_pop_node(int nid, unsigned int max)
+{
+	struct dma_pmd_reservoir *res = &dma_pmd_reservoirs[nid];
+	struct dma_pmd_meta *meta;
+	unsigned long flags;
+	bool refill = false;
+
+	if (!READ_ONCE(res->nr_pages))
+		return NULL;
+
+	spin_lock_irqsave(&res->lock, flags);
+	meta = list_first_entry_or_null(&res->pages, struct dma_pmd_meta, list);
+	if (meta) {
+		list_del_init(&meta->list);
+		res->nr_pages--;
+		refill = res->nr_pages <= max / 2;
+	}
+	spin_unlock_irqrestore(&res->lock, flags);
+
+	if (refill)
+		dma_pmd_schedule_reservoir();
+
+	return meta;
+}
+
+/**
+ * dma_pmd_reservoir_get - Obtain a pre-prepared PMD page, preferring @nid
+ * @nid: Preferred NUMA node (or NUMA_NO_NODE for local node)
+ *
+ * Tries @nid's reservoir first, then falls back to other memory nodes and
+ * schedules an async refill if a fallback or empty reservoir is encountered.
+ *
+ * Cost: O(1) on local node hit; O(MAX_NUMNODES) lockless checks on miss.
+ * Locking: Acquires @res->lock (irqsave) on non-empty node. Safe from any
+ *          context. Never sleeps.
+ * Frequency: Only on pool miss (dma_pmd_add_page()).
+ *
+ * Return: Metadata pointer of a ready PMD page (not yet compound-split or
+ *         bound to a pool), or NULL if all reservoirs are empty.
+ */
+static struct dma_pmd_meta *dma_pmd_reservoir_get(int nid)
+{
+	unsigned int max = READ_ONCE(dma_pmd_reservoir_max);
+	struct dma_pmd_meta *meta;
+	int target_nid, n;
+
+	if (!max)
+		return NULL;
+
+	target_nid = (nid == NUMA_NO_NODE) ? numa_mem_id() : nid;
+	if (target_nid >= 0 && target_nid < MAX_NUMNODES) {
+		meta = dma_pmd_reservoir_pop_node(target_nid, max);
+		if (meta)
+			return meta;
+	}
+
+	for_each_node_state(n, N_MEMORY) {
+		if (n == target_nid)
+			continue;
+		meta = dma_pmd_reservoir_pop_node(n, max);
+		if (meta) {
+			dma_pmd_schedule_reservoir();
+			return meta;
+		}
+	}
+
+	dma_pmd_schedule_reservoir();
+	return NULL;
+}
+
 unsigned int dma_pmd_pools_forget_domain(int idx)
 {
 	struct dma_pmd_pool *pool;
@@ -538,6 +748,7 @@ struct dma_pmd_pool *dma_pmd_pool_create(unsigned int order, unsigned int max_id
 	}
 	list_add(&pool->node, &dma_pmd_pools);
 	mutex_unlock(&dma_pmd_pools_lock);
+	dma_pmd_schedule_reservoir();
 
 	return pool;
 }
@@ -616,10 +827,18 @@ static struct dma_pmd_meta *dma_pmd_add_page(struct dma_pmd_pool *pool,
 	 */
 	bool can_block = (gfp & GFP_KERNEL) == GFP_KERNEL;
 	unsigned int nr = DMA_PMD_BLOCKS(pool->order);
+	bool from_reservoir = false;
 	struct dma_pmd_meta *meta;
 	gfp_t alloc_gfp, base_gfp;
 	struct page *page;
 
+	meta = dma_pmd_reservoir_get(nid);
+	if (meta) {
+		page = pfn_to_page(dma_pmd_meta_to_pfn(meta));
+		from_reservoir = true;
+		goto prepare;
+	}
+
 	/*
 	 * A high-order allocation is expensive when it fails, and under fragmentation
 	 * it fails on every pool miss. For GFP_ATOMIC, back off briefly.
@@ -687,9 +906,10 @@ static struct dma_pmd_meta *dma_pmd_add_page(struct dma_pmd_pool *pool,
 
 	meta = dma_pmd_meta_of_pfn(page_to_pfn(page));
 	memset(meta, 0, sizeof(*meta));
-	meta->pool = pool;
 	spin_lock_init(&meta->map_lock);
 
+prepare:
+	meta->pool = pool;
 	if (dma_pmd_page_prepare(page, meta, can_block)) {
 		__free_pages(page, PMD_ORDER);
 		atomic_long_dec(&dma_pmd_nr_pages);
@@ -705,8 +925,8 @@ static struct dma_pmd_meta *dma_pmd_add_page(struct dma_pmd_pool *pool,
 		return NULL;
 	}
 
-	if (zero || (meta->flags & DMA_PMD_DECRYPTED)) {
-		if (!(meta->flags & DMA_PMD_DECRYPTED))
+	if (from_reservoir || zero || (meta->flags & DMA_PMD_DECRYPTED)) {
+		if (!from_reservoir && !(meta->flags & DMA_PMD_DECRYPTED))
 			memset(page_address(page), 0, PMD_SIZE);
 		bitmap_set(meta->free_bitmap, 0, nr);
 		meta->nr_free = nr;
@@ -1042,14 +1262,17 @@ static unsigned long dma_pmd_shrink_count(struct shrinker *shrink,
 {
 	struct dma_pmd_pool *pool;
 	unsigned long nr = 0;
+	int nid;
 
-	if (!mutex_trylock(&dma_pmd_pools_lock))
-		return 0;
+	for_each_node_state(nid, N_MEMORY)
+		nr += READ_ONCE(dma_pmd_reservoirs[nid].nr_pages);
 
-	list_for_each_entry(pool, &dma_pmd_pools, node)
-		nr += READ_ONCE(pool->num_idle_pages);
+	if (mutex_trylock(&dma_pmd_pools_lock)) {
+		list_for_each_entry(pool, &dma_pmd_pools, node)
+			nr += READ_ONCE(pool->num_idle_pages);
 
-	mutex_unlock(&dma_pmd_pools_lock);
+		mutex_unlock(&dma_pmd_pools_lock);
+	}
 
 	return nr << PMD_ORDER;
 }
@@ -1062,34 +1285,50 @@ static unsigned long dma_pmd_shrink_scan(struct shrinker *shrink,
 	unsigned long freed = 0;
 	LIST_HEAD(release_list);
 	unsigned long flags;
-	int srcu_idx;
+	int srcu_idx, nid;
 
-	if (!mutex_trylock(&dma_pmd_pools_lock))
-		return SHRINK_STOP;
+	for_each_node_state(nid, N_MEMORY) {
+		struct dma_pmd_reservoir *res = &dma_pmd_reservoirs[nid];
 
-	srcu_idx = srcu_read_lock(&dma_pmd_srcu);
-	list_for_each_entry(pool, &dma_pmd_pools, node) {
-		/*
-		 * Every PMD page on @idle is a candidate, so this detaches one
-		 * per iteration and stops as soon as the reclaim path has
-		 * what it asked for: the IRQs-off section is bounded by the
-		 * work done, not by how many PMD pages the pool holds.
-		 */
-		spin_lock_irqsave(&pool->lock, flags);
-		list_for_each_entry_safe(meta, tmp, &pool->idle, list) {
+		if (!READ_ONCE(res->nr_pages))
+			continue;
+		spin_lock_irqsave(&res->lock, flags);
+		list_for_each_entry_safe(meta, tmp, &res->pages, list) {
 			if (freed >= sc->nr_to_scan)
 				break;
 			list_move(&meta->list, &release_list);
-			pool->num_idle_pages--;
+			res->nr_pages--;
 			freed += 1UL << PMD_ORDER;
 		}
-		spin_unlock_irqrestore(&pool->lock, flags);
-
+		spin_unlock_irqrestore(&res->lock, flags);
 		if (freed >= sc->nr_to_scan)
 			break;
 	}
 
-	mutex_unlock(&dma_pmd_pools_lock);
+	srcu_idx = srcu_read_lock(&dma_pmd_srcu);
+	if (freed < sc->nr_to_scan && mutex_trylock(&dma_pmd_pools_lock)) {
+		list_for_each_entry(pool, &dma_pmd_pools, node) {
+			/*
+			 * Every PMD page on @idle is a candidate, so this detaches one
+			 * per iteration and stops as soon as the reclaim path has
+			 * what it asked for: the IRQs-off section is bounded by the
+			 * work done, not by how many PMD pages the pool holds.
+			 */
+			spin_lock_irqsave(&pool->lock, flags);
+			list_for_each_entry_safe(meta, tmp, &pool->idle, list) {
+				if (freed >= sc->nr_to_scan)
+					break;
+				list_move(&meta->list, &release_list);
+				pool->num_idle_pages--;
+				freed += 1UL << PMD_ORDER;
+			}
+			spin_unlock_irqrestore(&pool->lock, flags);
+
+			if (freed >= sc->nr_to_scan)
+				break;
+		}
+		mutex_unlock(&dma_pmd_pools_lock);
+	}
 
 	/*
 	 * Retiring is done outside both locks: dma_pmd_release_page() unmaps
@@ -1103,8 +1342,10 @@ static unsigned long dma_pmd_shrink_scan(struct shrinker *shrink,
 		if (meta->flags & (DMA_PMD_DECRYPTED | DMA_PMD_PINNED)) {
 			llist_add(&meta->llnode, &dma_pmd_free_list);
 			dma_pmd_schedule_reclaim();
-		} else {
+		} else if (meta->pool) {
 			dma_pmd_release_page(meta);
+		} else {
+			dma_pmd_free_reservoir_page(meta);
 		}
 	}
 	srcu_read_unlock(&dma_pmd_srcu, srcu_idx);
@@ -1128,6 +1369,12 @@ static unsigned long dma_pmd_shrink_scan(struct shrinker *shrink,
 static int __init dma_pmd_init(void)
 {
 	struct shrinker *shrink;
+	int nid;
+
+	for (nid = 0; nid < MAX_NUMNODES; nid++) {
+		spin_lock_init(&dma_pmd_reservoirs[nid].lock);
+		INIT_LIST_HEAD(&dma_pmd_reservoirs[nid].pages);
+	}
 
 	/*
 	 * Hard ceiling on memory diverted from the buddy allocator into 2MB
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

