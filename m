Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9134D43F0AC
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 15:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585382; cv=none; b=ZtP3yUJWnCgQADDtVcd/ex9tCRyQ/eFkENSIAlbOwOrCQFgJ8vZt7qPeff8b2OXg2hmkKBSxdEDYYCaDZNwXaFAxutXcbtXSsr04Rk6McBzZBHNdYE89lRJsaaalpcqGv6P7jNA1VuM1WCRfcR8dzn7/WsGgDwUGH3T2TjXtv2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585382; c=relaxed/simple;
	bh=5NerewdcDfiL8OQ+QV5MZNyPF8loWtco0UZ0C++GWaM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pp/W3LQ0NTHXJXi06TF40Zb5Gwd5Bcv6y9FmXnm50FsrWPuht6VHD01C9NhKtIh/xQrctsfhqqF2gI1ikbj610lmNIwfLF6ksTb7Kf+8M831NpN/vpMNYBbPEUjWofDG9WStMp+08ERTxmMR1GVZpIT7wX5kYigcJpwwz28vCqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fxL/MGfQ; arc=none smtp.client-ip=209.85.208.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fxL/MGfQ"
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6a19d668ba3so5019679a12.1
        for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 08:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787585378; x=1788190178; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a387GiIlsJuzM9aT5OA2RPOtHkxgW7YP7HmPN81inmc=;
        b=fxL/MGfQ6tKL0MkU8cAJy8kzQ7guXw2kU2bvAs8YLHksjN0rkOizpsnpT0q9wIGwSi
         TsLorqeZNr3QMmdi6AeHRRyJf6rPWnWtZEuJfMu+PXpqTL5Bom5tVCLomzQKfs9U+c5N
         xRRyA1tG5EnbTBCjw1YQ4QWInh5XHO+tRvsdTblcqN7JqZE650+Yd1hEM/Pqu1WhEH8r
         bOkGkTa9VKoKQ2MgjGw2cSsNykYNxxgU2vdOCjqgqvR8oGxdFD9eWkQVenklMNKXw6G6
         lmjTDhZSGQteQA3GC9Ya1kC3R55MmjNg82esDzOugkVm80wg8leQKo1OOCQezEHKPo+7
         PFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787585378; x=1788190178;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a387GiIlsJuzM9aT5OA2RPOtHkxgW7YP7HmPN81inmc=;
        b=T3hWECKLVtLBULznshNC0EHaykviIhj8aaNJALLV18GCQjQ+hDheU6lhUzB4b6Nk8T
         V+hzPLerXsbjTLw2A6ygMTCo/mNGcYC/8gvLiCQ291ohsSdIlpT3KXh+TXV4o6Igtavi
         4IphYRxmeRfJGA0wGe+sTHmzyjalPdM76xr03zdzaCSIHZwIFdSrrSu9+z0LEKEPGXcW
         hyX7e+XcVbVPmiBf7FkCxfQ8S8SKennt1wW8RwIiIgba0rx/Zdi+grMlgSvy1ZfPyUk2
         Pt/0Cxebg64c5E+HiMnlFCwz1A96u3ifO1XqM1zKBc/WAWqZGsb7qVlbQZcOEAiPGj74
         o7Kw==
X-Forwarded-Encrypted: i=1; AHgh+RqiBJZXaHRI/VO5+8kOfzVPBotbc3LxI1jwhfGqAl4WZMXWCf+NTq0Ez/AzFrw0XdyzfMRNYQ==@lists.linux.dev
X-Gm-Message-State: AFuF++ncARfCyBHN6IHmzv7RDrdNwAteD4AbSgGNNH7BP19J17zvfXeh
	WNUep/uEY9ZiHVDNpZo2DdjA8QjVSGmxI9GdX/Hw96RDXt2VjtgjorK4T+uQslFqRMV4xh0uTFq
	hGocjcQ==
X-Received: from edxn5.prod.google.com ([2002:a05:6402:5c5:b0:6a1:4f77:f704])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:4613:b0:698:9e5e:5df8
 with SMTP id 4fb4d7f45d1cf-6a42f1aca88mr27508443a12.7.1787585377536; Mon, 24
 Aug 2026 08:29:37 -0700 (PDT)
Date: Mon, 24 Aug 2026 15:29:29 +0000
In-Reply-To: <20260824152932.1583506-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260615234220.3946885-1-lrizzo@google.com> <20260824152932.1583506-1-lrizzo@google.com>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260824152932.1583506-3-lrizzo@google.com>
Subject: [PATCH v2 2/5] swiotlb/mm: Implement SWIOTLB nocopy page allocator
From: Luigi Rizzo <lrizzo@google.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Luigi Rizzo <lrizzo@google.com>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dragos Tatulea <dtatulea@nvidia.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, netdev@vger.kernel.org, linux-mm@kvack.org, 
	iommu@lists.linux.dev, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Introduce swiotlb_alloc_pages() and swiotlb_free_pages() to allocate
and release compound pages directly from the default SWIOTLB pool.

The allocator is restricted to slots in the static default pool,
with caller-specified percentage limits on pool occupancy.

This will be used for kernel data (e.g. socket buffers) in
nocopy confidential computing.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 include/linux/swiotlb.h |  24 ++++++
 kernel/dma/swiotlb.c    | 187 ++++++++++++++++++++++++++++++++++++++--
 mm/page_alloc.c         |  51 +++++++++++
 3 files changed, 255 insertions(+), 7 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 3dae0f592063e..4661e361c60e4 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -169,6 +169,23 @@ static inline struct io_tlb_pool *swiotlb_find_pool(struct device *dev,
 	return NULL;
 }
 
+bool swiotlb_pool_is_nocopy(struct io_tlb_pool *pool, phys_addr_t paddr);
+
+static inline bool swiotlb_addr_in_default_pool(struct device *dev,
+						phys_addr_t paddr)
+{
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
+
+	return mem && paddr >= mem->defpool.start && paddr < mem->defpool.end;
+}
+
+static inline bool swiotlb_is_nocopy_addr(struct device *dev, phys_addr_t paddr)
+{
+	if (!swiotlb_addr_in_default_pool(dev, paddr))
+		return false;
+	return swiotlb_pool_is_nocopy(&dev->dma_io_tlb_mem->defpool, paddr);
+}
+
 static inline bool is_swiotlb_force_bounce(struct device *dev)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
@@ -178,6 +195,13 @@ static inline bool is_swiotlb_force_bounce(struct device *dev)
 
 void swiotlb_init(bool addressing_limited, unsigned int flags);
 void __init swiotlb_exit(void);
+struct page *swiotlb_alloc_pages(struct device *dev, unsigned int order, gfp_t gfp,
+				 unsigned int percent);
+bool swiotlb_free_pages(struct page *page, unsigned int order);
+void swiotlb_nocopy_inc_ref(struct io_tlb_pool *pool, phys_addr_t phys);
+void swiotlb_nocopy_dec_ref(struct io_tlb_pool *pool, phys_addr_t phys);
+void swiotlb_prep_compound_page(struct page *page, unsigned int order);
+void swiotlb_destroy_compound_page(struct page *page, unsigned int order);
 void swiotlb_dev_init(struct device *dev);
 size_t swiotlb_max_mapping_size(struct device *dev);
 bool is_swiotlb_allocated(void);
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 8e4bd9d47735a..6b86a1e955fb4 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -66,17 +66,59 @@
 /**
  * struct io_tlb_slot - IO TLB slot descriptor
  * @orig_addr:	The original address corresponding to a mapped entry.
+ * @nocopy_refcnt:	Lockless atomic refcount for Nocopy buffers.
  * @alloc_size:	Size of the allocated buffer.
  * @list:	The free list describing the number of free entries available
  *		from each index.
  * @pad_slots:	Number of preceding padding slots. Valid only in the first
  *		allocated non-padding slot.
+ * @flags:	Slot attributes (e.g. SWIOTLB_SLOT_NOCOPY for Nocopy buffers).
+ *
+ * The slot descriptor has states identified by @list and @flags (SWIOTLB_SLOT_NOCOPY):
+ *
+ * 1. FREE (list > 0):
+ *    Linear sweep free slot.
+ *
+ * 2. USED (list == 0, SWIOTLB_SLOT_NOCOPY flag is NOT set in @flags):
+ *    Allocated SWIOTLB bounce buffer.
+ *    Fields used: @list, @pad_slots, @orig_addr, @alloc_size.
+ *
+ * 3. USED_NOCOPY (list == 0, SWIOTLB_SLOT_NOCOPY flag is set in @flags):
+ *    Allocated Nocopy SWIOTLB buffer.
+ *    Fields used: @list, @nocopy_refcnt, @alloc_size.
+ */
+#define SWIOTLB_SLOT_NOCOPY	BIT(0)
+
+/*
+ * SWIOTLB nocopy allocations (swiotlb_alloc_pages()) do not have an original
+ * physical address to bounce, but need to pass a caller-specified pool usage
+ * limit (percentage) down to the area search logic.
+ *
+ * To avoid adding a parameter to swiotlb_find_slots(), swiotlb_search_area(),
+ * and swiotlb_search_pool_area(), the desired percentage (0..90) is encoded
+ * into the orig_addr parameter in the reserved high address range starting at
+ * INVALID_PHYS_ADDR (~0ULL).
+ *
+ * - NOCOPY_PCT_TO_ADDR(pct): Encodes a percentage into an orig_addr.
+ * - IS_SWIOTLB_NOCOPY(addr): Identifies a nocopy allocation request and
+ *   restricts slot search to the static default pool.
+ * - NOCOPY_ADDR_TO_PCT(addr): Extracts the percentage to cap max_usable
+ *   slots in swiotlb_search_pool_area().
  */
+#define NOCOPY_PCT_MAX	(90u)
+#define NOCOPY_PCT_TO_ADDR(pct)		(INVALID_PHYS_ADDR - min(pct, NOCOPY_PCT_MAX))
+#define IS_SWIOTLB_NOCOPY(addr)		((addr) >= INVALID_PHYS_ADDR - NOCOPY_PCT_MAX)
+#define NOCOPY_ADDR_TO_PCT(addr)	((unsigned int)(INVALID_PHYS_ADDR - (addr)))
+
 struct io_tlb_slot {
-	phys_addr_t orig_addr;
+	union {
+		phys_addr_t orig_addr;
+		atomic_t nocopy_refcnt;
+	};
 	size_t alloc_size;
 	unsigned short list;
 	unsigned short pad_slots;
+	unsigned int flags;
 };
 
 static bool swiotlb_force_bounce;
@@ -300,6 +342,7 @@ static void swiotlb_init_io_tlb_pool(struct io_tlb_pool *mem, phys_addr_t start,
 		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
 		mem->slots[i].alloc_size = 0;
 		mem->slots[i].pad_slots = 0;
+		mem->slots[i].flags = 0;
 	}
 
 	memset(vaddr, 0, bytes);
@@ -869,12 +912,17 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 			   enum dma_data_direction dir, struct io_tlb_pool *mem)
 {
 	int index = (tlb_addr - mem->start) >> IO_TLB_SHIFT;
-	phys_addr_t orig_addr = mem->slots[index].orig_addr;
 	size_t alloc_size = mem->slots[index].alloc_size;
-	unsigned long pfn = PFN_DOWN(orig_addr);
 	unsigned char *vaddr = mem->vaddr + tlb_addr - mem->start;
+	phys_addr_t orig_addr;
+	unsigned long pfn;
 	int tlb_offset;
 
+	/* Nocopy swiotlb buffers do not need bouncing. */
+	if (mem->slots[index].flags & SWIOTLB_SLOT_NOCOPY)
+		return;
+
+	orig_addr = mem->slots[index].orig_addr;
 	if (orig_addr == INVALID_PHYS_ADDR)
 		return;
 
@@ -904,6 +952,7 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 		size = alloc_size;
 	}
 
+	pfn = PFN_DOWN(orig_addr);
 	if (PageHighMem(pfn_to_page(pfn))) {
 		unsigned int offset = orig_addr & ~PAGE_MASK;
 		struct page *page;
@@ -1052,7 +1101,8 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
 	unsigned long max_slots = get_max_slots(boundary_mask);
 	unsigned int iotlb_align_mask = dma_get_min_align_mask(dev);
 	unsigned int nslots = nr_slots(alloc_size), stride;
-	unsigned int offset = swiotlb_align_offset(dev, 0, orig_addr);
+	unsigned long max_usable = pool->area_nslabs;
+	unsigned int offset;
 	unsigned int index, slots_checked, count = 0, i;
 	unsigned long flags;
 	unsigned int slot_base;
@@ -1061,6 +1111,13 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
 	BUG_ON(!nslots);
 	BUG_ON(area_index >= pool->nareas);
 
+	if (IS_SWIOTLB_NOCOPY(orig_addr)) {
+		max_usable = (pool->area_nslabs * NOCOPY_ADDR_TO_PCT(orig_addr)) / 100;
+		orig_addr = 0;
+	}
+
+	offset = swiotlb_align_offset(dev, 0, orig_addr);
+
 	/*
 	 * Historically, swiotlb allocations >= PAGE_SIZE were guaranteed to be
 	 * page-aligned in the absence of any other alignment requirements.
@@ -1087,7 +1144,7 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
 	stride = get_max_slots(max(alloc_align_mask, iotlb_align_mask));
 
 	spin_lock_irqsave(&area->lock, flags);
-	if (unlikely(nslots > pool->area_nslabs - area->used))
+	if (unlikely(area->used + nslots > max_usable))
 		goto not_found;
 
 	slot_base = area_index * pool->area_nslabs;
@@ -1164,6 +1221,9 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
  * Search one memory area in all pools for a sequence of slots that match the
  * allocation constraints.
  *
+ * If IS_SWIOTLB_NOCOPY(orig_addr) is true, the search is restricted to only the
+ * default pool, which is what swiotlb_alloc_pages() is allowed to use.
+ *
  * Return: Index of the first allocated slot, or -1 on error.
  */
 static int swiotlb_search_area(struct device *dev, int start_cpu,
@@ -1177,6 +1237,9 @@ static int swiotlb_search_area(struct device *dev, int start_cpu,
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(pool, &mem->pools, node) {
+		/* Only search the default pool (first in mem->pools) for nocopy allocations. */
+		if (IS_SWIOTLB_NOCOPY(orig_addr) && pool != &mem->defpool)
+			break;
 		if (cpu_offset >= pool->nareas)
 			continue;
 		area_index = (start_cpu + cpu_offset) & (pool->nareas - 1);
@@ -1229,6 +1292,13 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 			goto found;
 	}
 
+	/*
+	 * Passing a nocopy orig_addr restricts the search to only the
+	 * default pool, so do not attempt dynamic pool expansion.
+	 */
+	if (IS_SWIOTLB_NOCOPY(orig_addr))
+		return -1;
+
 	if (!mem->can_grow)
 		return -1;
 
@@ -1468,11 +1538,16 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	return tlb_addr;
 }
 
+/*
+ * called with dev == NULL from swiotlb_dealloc_pages(), in this case force offset
+ * and align_mask to 0, pad_slots is also 0, and assume the pages come from the
+ * default system pool.
+ */
 static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr,
 				  struct io_tlb_pool *mem)
 {
 	unsigned long flags;
-	unsigned int offset = swiotlb_align_offset(dev, 0, tlb_addr);
+	unsigned int offset = dev ? swiotlb_align_offset(dev, 0, tlb_addr) : 0;
 	int index, nslots, aindex;
 	struct io_tlb_area *area;
 	int count, i;
@@ -1506,6 +1581,7 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr,
 		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
 		mem->slots[i].alloc_size = 0;
 		mem->slots[i].pad_slots = 0;
+		mem->slots[i].flags = 0;
 	}
 
 	/*
@@ -1519,7 +1595,7 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr,
 	area->used -= nslots;
 	spin_unlock_irqrestore(&area->lock, flags);
 
-	dec_used(dev->dma_io_tlb_mem, nslots);
+	dec_used(dev ? dev->dma_io_tlb_mem : &io_tlb_default_mem, nslots);
 }
 
 #ifdef CONFIG_SWIOTLB_DYNAMIC
@@ -1912,3 +1988,100 @@ static const struct reserved_mem_ops rmem_swiotlb_ops = {
 
 RESERVEDMEM_OF_DECLARE(dma, "restricted-dma-pool", &rmem_swiotlb_ops);
 #endif /* CONFIG_DMA_RESTRICTED_POOL */
+
+static inline int swiotlb_nocopy_head_index(struct io_tlb_pool *pool, phys_addr_t phys)
+{
+	return (page_to_phys(compound_head(phys_to_page(phys))) - pool->start) >> IO_TLB_SHIFT;
+}
+
+/**
+ * swiotlb_dealloc_pages() - Actually release Nocopy slots and page metadata
+ * @pool:	SWIOTLB pool containing the buffer.
+ * @parent:	Slot index of the buffer head.
+ */
+static void swiotlb_dealloc_pages(struct io_tlb_pool *pool, unsigned int parent)
+{
+	unsigned int order = get_order(pool->slots[parent].alloc_size);
+	phys_addr_t paddr = pool->start + (parent << IO_TLB_SHIFT);
+	struct page *head = phys_to_page(paddr);
+
+	swiotlb_destroy_compound_page(head, order);
+	swiotlb_release_slots(NULL, paddr, pool);
+}
+
+struct page *swiotlb_alloc_pages(struct device *dev, unsigned int order,
+				 gfp_t gfp, unsigned int percent)
+{
+	struct io_tlb_pool *pool;
+	struct page *page;
+	int index, nslots, i;
+
+	if (WARN_ON_ONCE(!dev || !dev->dma_io_tlb_mem))
+		return NULL;
+
+	if (dev->dma_io_tlb_mem != &io_tlb_default_mem)
+		return NULL;
+
+	index = swiotlb_find_slots(dev, NOCOPY_PCT_TO_ADDR(percent),
+				   PAGE_SIZE << order, (PAGE_SIZE << order) - 1,
+				   &pool);
+	if (index < 0)
+		return NULL;
+
+	nslots = (PAGE_SIZE << order) >> IO_TLB_SHIFT;
+	page = phys_to_page(pool->start + (index << IO_TLB_SHIFT));
+	swiotlb_prep_compound_page(page, order);
+	for (i = 0; i < nslots; i++)
+		pool->slots[index + i].flags |= SWIOTLB_SLOT_NOCOPY;
+	atomic_set(&pool->slots[index].nocopy_refcnt, 1);
+	return page;
+}
+EXPORT_SYMBOL(swiotlb_alloc_pages);
+
+bool swiotlb_free_pages(struct page *page, unsigned int order)
+{
+	struct io_tlb_mem *mem = &io_tlb_default_mem;
+	struct io_tlb_pool *pool = &mem->defpool;
+	struct page *head = compound_head(page);
+	unsigned int parent;
+	phys_addr_t paddr;
+
+	paddr = page_to_phys(head);
+	if (paddr < pool->start || paddr >= pool->end)
+		return false;
+
+	parent = swiotlb_nocopy_head_index(pool, paddr);
+	if (!(pool->slots[parent].flags & SWIOTLB_SLOT_NOCOPY))
+		return false;
+
+	if (atomic_dec_and_test(&pool->slots[parent].nocopy_refcnt))
+		swiotlb_dealloc_pages(pool, parent);
+
+	return true;
+}
+EXPORT_SYMBOL(swiotlb_free_pages);
+
+void swiotlb_nocopy_inc_ref(struct io_tlb_pool *pool, phys_addr_t phys)
+{
+	int head_idx = swiotlb_nocopy_head_index(pool, phys);
+
+	atomic_inc(&pool->slots[head_idx].nocopy_refcnt);
+}
+EXPORT_SYMBOL(swiotlb_nocopy_inc_ref);
+
+void swiotlb_nocopy_dec_ref(struct io_tlb_pool *pool, phys_addr_t phys)
+{
+	int head_idx = swiotlb_nocopy_head_index(pool, phys);
+
+	if (atomic_dec_and_test(&pool->slots[head_idx].nocopy_refcnt))
+		swiotlb_dealloc_pages(pool, head_idx);
+}
+EXPORT_SYMBOL(swiotlb_nocopy_dec_ref);
+
+bool swiotlb_pool_is_nocopy(struct io_tlb_pool *pool, phys_addr_t paddr)
+{
+	int index = (paddr - pool->start) >> IO_TLB_SHIFT;
+
+	return pool->slots[index].flags & SWIOTLB_SLOT_NOCOPY;
+}
+EXPORT_SYMBOL_GPL(swiotlb_pool_is_nocopy);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 083cbcb5bddec..ea148562a76d0 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -16,6 +16,7 @@
 
 #include <linux/stddef.h>
 #include <linux/mm.h>
+#include <linux/swiotlb.h>
 #include <linux/highmem.h>
 #include <linux/interrupt.h>
 #include <linux/jiffies.h>
@@ -711,6 +712,56 @@ void prep_compound_page(struct page *page, unsigned int order)
 	prep_compound_head(page, order);
 }
 
+#ifdef CONFIG_SWIOTLB
+/*
+ * Prepare a SWIOTLB page (potentially compound).
+ *
+ * We explicitly initialize the head page refcount to 1 because recycled
+ * SWIOTLB pages might have a refcount of 0.
+ *
+ * If order > 0 (compound page), we must explicitly set all tail page
+ * refcounts to 0. This is because SWIOTLB pages might have a boot-default
+ * refcount of 1, but the core memory management subsystem expects tail pages
+ * of a compound page to have a refcount of 0.
+ */
+void swiotlb_prep_compound_page(struct page *page, unsigned int order)
+{
+	init_page_count(page);
+	if (order > 0) {
+		for (int i = 1; i < (1 << order); i++)
+			set_page_count(page + i, 0);
+		prep_compound_page(page, order);
+	}
+}
+
+/*
+ * Destroy a SWIOTLB compound page and restore page refcounts.
+ *
+ * When pages are returned to the SWIOTLB pool, we restore the refcount of
+ * all constituent pages (head and tails) to 1. This resets them to their
+ * clean boot-default state, ensuring they are ready for reuse either as
+ * individual order-0 pages or as part of a new compound allocation.
+ */
+void swiotlb_destroy_compound_page(struct page *page, unsigned int order)
+{
+	if (order > 0) {
+		struct folio *folio = (struct folio *)page;
+
+		__ClearPageHead(page);
+		page[1].flags.f &= ~PAGE_FLAGS_SECOND;
+#ifdef NR_PAGES_IN_LARGE_FOLIO
+		folio->_nr_pages = 0;
+#endif
+		for (int i = 1; i < (1 << order); i++) {
+			page[i].mapping = NULL;
+			clear_compound_head(&page[i]);
+			set_page_count(page + i, 1);
+		}
+	}
+	set_page_count(page, 1);
+}
+#endif /* CONFIG_SWIOTLB */
+
 static inline void set_buddy_order(struct page *page, unsigned int order)
 {
 	set_page_private(page, order);
-- 
2.55.0.766.g2966f0265a-goog

