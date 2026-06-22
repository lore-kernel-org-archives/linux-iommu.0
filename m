Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9651C272E53
	for <iommu@lists.linux.dev>; Mon, 22 Jun 2026 12:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782130852; cv=none; b=EiaXUG1+ih9OrO9wLdIQ2XF/pZJFGo0GIvttis/g+k4AMj3d+qSCuQz+t/rdGG5k2Yzrrskn4bPGUA+kobZmZgLc/g4k2y6hXK7neVph4TTVThT2KJxRW66cp6SUyAonviwnek0wepBazQRheAPIIvnbiU5sF7lasFbEblvKO80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782130852; c=relaxed/simple;
	bh=uRpSmM/o2zjMPJAx9wZLhdjcls72pYh1Z+gPtJ2JZsA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QifvBuIN4us4o9M0IODw4WR2NtV1LvHKu1VXpMLp3PMc3J4iyaSZoY0ivJTlnMfIQFgvsObImD7O0Yp2RbyP76GvRzhoXGUdatOc5tbXeQAWroQ+m/slTjkoqZ2iDO++qlCVGtx9aRFTu2u/jnJ8mTYtgSA7zeicoG4cuNBV3Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nXKfTC5B; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nXKfTC5B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782130850; x=1813666850;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uRpSmM/o2zjMPJAx9wZLhdjcls72pYh1Z+gPtJ2JZsA=;
  b=nXKfTC5BFednjGEnikhP/hB9fAV7QHpIuS7gt5tAj5We5hG/hKJKjuW3
   DS6LwYBesHzCFEPUf9Bu13qYL/qH1RHaARvPuhIOzDxYUylWKQdHejU9T
   sAVIYyo777ttZpSpqO6QziRFQUTLfvtpy/0gNBS/Gwho3MVfYkMQgcp+u
   0d7sVl6ulc0L+3+tyWWp3a3xMNxXToieQzabHZbUWIzLaLEOg/uN0u4ud
   uwVhjKC4JrA11pLPHXrnizqB0f4r43NxcfZQljZABrukciiPUWeCepcDm
   0Jp1Dsn7/nLgktzNpYWPkSe+bHqyFsWzvI/tkuYhSlWm/++ecIQVYXtNe
   Q==;
X-CSE-ConnectionGUID: yLu3cMDLTO6LTlVNdsf/lQ==
X-CSE-MsgGUID: sCJ1YNERQKmQfawU084Uuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="81960563"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="81960563"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 05:20:49 -0700
X-CSE-ConnectionGUID: 9cMsU2XtS026UE8KW4se8Q==
X-CSE-MsgGUID: DsjIvwPQS8e0fZFhZ/URtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="272916506"
Received: from ubuntu.bj.intel.com ([10.238.152.72])
  by fmviesa002.fm.intel.com with ESMTP; 22 Jun 2026 05:20:47 -0700
From: Jun Miao <jun.miao@intel.com>
To: m.szyprowski@samsung.com,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	chenhgs@chinatelecom.cn,
	fan.du@intel.com,
	jun.miao@intel.com
Subject: [PATCH] swiotlb: eliminate per-map atomic contention on used/hiwater tracking
Date: Mon, 22 Jun 2026 20:21:14 +0800
Message-Id: <20260622122114.2563254-1-jun.miao@intel.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Under heavy concurrent DMA traffic, inc_used_and_hiwater() performs an
atomic_long_add_return() plus a CAS loop on the global used_hiwater, and
dec_used() performs an atomic_long_sub() on total_used.  All CPUs contend
on the same cacheline, causing measurable throughput degradation at scale.
Both counters are debug-only (CONFIG_DEBUG_FS).

Move hiwater tracking into struct io_tlb_area, where area->used is
already maintained under area->lock:

- Add unsigned long used_hiwater to struct io_tlb_area.  Update it
  inside the existing area->lock critical section in
  swiotlb_search_pool_area() immediately after area->used is
  incremented, at zero additional synchronisation cost.

- Remove atomic_long_t total_used and used_hiwater from struct
  io_tlb_mem; make inc_used_and_hiwater()/dec_used() empty stubs.

- Unify the two CONFIG_DEBUG_FS / !CONFIG_DEBUG_FS versions of
  mem_used() into a single implementation that sums per-area used
  counts with READ_ONCE().

- Rewrite io_tlb_hiwater_get() to sum area->used_hiwater across all
  areas (locklessly with READ_ONCE()); rewrite io_tlb_hiwater_set() to
  reset each area under its own spinlock.

Result: zero global atomic operations on the DMA map/unmap hot path.

Without this patch, the inc_used_and_hiwater() accounts for the most time
from perf assembly record as following log:

       | spin_unlock_irqrestore():
       | - call    _raw_spin_unlock_irqrestore
       | swiotlb_area_find_slots():
 10.38 |   mov    $0x60(%rsp),%rax
  0.00 |   mov    $0x2b8(%rax),%rcx
       | arch_atomic64_add_return():
  0.00 |   mov    %r15,%rax
  0.00 |   lock    xadd    %rax,0x58(%rcx)
 66.74 |   lea    (%r15,%rax,1),%rdx
       | arch_atomic64_read():
  0.14 |   mov    $0x60(%rcx),%rax
       | inc_used_and_hiwater():
 19.74 |   cmp    %rdx,%rax
       |   jae    43f
       | arch_atomic64_try_cmpxchg():
       |   lock    cmpxchg %rdx,0x60(%rcx)
       |   jne    432
       | swiotlb_area_find_slots():
  0.07 |   mov    %ebx,%eax
  0.04 |   jmp    289
       | wrap_area_index():
       |   xor    %edx,%edx
       |   jmp    3fb

Suggested-by: Fan Du <fan.du@intel.com>
Co-developed-by: Chenhgs <chenhgs@chinatelecom.cn>
Tested-by: Chenhgs <chenhgs@chinatelecom.cn>
Signed-off-by: Jun Miao <jun.miao@intel.com>
---
 include/linux/swiotlb.h |   7 ---
 kernel/dma/swiotlb.c    | 109 +++++++++++++++++-----------------------
 2 files changed, 45 insertions(+), 71 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 3dae0f592063..a92496786cb5 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -97,11 +97,6 @@ struct io_tlb_pool {
  * @lock:	Lock to synchronize changes to the list.
  * @pools:	List of IO TLB memory pool descriptors (if dynamic).
  * @dyn_alloc:	Dynamic IO TLB pool allocation work.
- * @total_used:	The total number of slots in the pool that are currently used
- *		across all areas. Used only for calculating used_hiwater in
- *		debugfs.
- * @used_hiwater: The high water mark for total_used.  Used only for reporting
- *		in debugfs.
  * @transient_nslabs: The total number of slots in all transient pools that
  *		are currently used across all areas.
  */
@@ -119,8 +114,6 @@ struct io_tlb_mem {
 	struct work_struct dyn_alloc;
 #endif
 #ifdef CONFIG_DEBUG_FS
-	atomic_long_t total_used;
-	atomic_long_t used_hiwater;
 	atomic_long_t transient_nslabs;
 #endif
 };
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 1abd3e6146f4..9b4130e3f8e8 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -107,12 +107,15 @@ static unsigned long default_nareas;
  * This is a single area with a single lock.
  *
  * @used:	The number of used IO TLB block.
+ * @used_hiwater: Per-area high-water mark of used slots. Updated under
+ *		@lock; read locklessly for approximate debugfs reporting.
  * @index:	The slot index to start searching in this area for next round.
  * @lock:	The lock to protect the above data structures in the map and
  *		unmap calls.
  */
 struct io_tlb_area {
 	unsigned long used;
+	unsigned long used_hiwater;
 	unsigned int index;
 	spinlock_t lock;
 };
@@ -959,40 +962,6 @@ static unsigned int wrap_area_index(struct io_tlb_pool *mem, unsigned int index)
 	return index;
 }
 
-/*
- * Track the total used slots with a global atomic value in order to have
- * correct information to determine the high water mark. The mem_used()
- * function gives imprecise results because there's no locking across
- * multiple areas.
- */
-#ifdef CONFIG_DEBUG_FS
-static void inc_used_and_hiwater(struct io_tlb_mem *mem, unsigned int nslots)
-{
-	unsigned long old_hiwater, new_used;
-
-	new_used = atomic_long_add_return(nslots, &mem->total_used);
-	old_hiwater = atomic_long_read(&mem->used_hiwater);
-	do {
-		if (new_used <= old_hiwater)
-			break;
-	} while (!atomic_long_try_cmpxchg(&mem->used_hiwater,
-					  &old_hiwater, new_used));
-}
-
-static void dec_used(struct io_tlb_mem *mem, unsigned int nslots)
-{
-	atomic_long_sub(nslots, &mem->total_used);
-}
-
-#else /* !CONFIG_DEBUG_FS */
-static void inc_used_and_hiwater(struct io_tlb_mem *mem, unsigned int nslots)
-{
-}
-static void dec_used(struct io_tlb_mem *mem, unsigned int nslots)
-{
-}
-#endif /* CONFIG_DEBUG_FS */
-
 #ifdef CONFIG_SWIOTLB_DYNAMIC
 #ifdef CONFIG_DEBUG_FS
 static void inc_transient_used(struct io_tlb_mem *mem, unsigned int nslots)
@@ -1132,9 +1101,10 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
 	 */
 	area->index = wrap_area_index(pool, index + nslots);
 	area->used += nslots;
+	if (area->used > area->used_hiwater)
+		area->used_hiwater = area->used;
 	spin_unlock_irqrestore(&area->lock, flags);
 
-	inc_used_and_hiwater(dev->dma_io_tlb_mem, nslots);
 	return slot_index;
 }
 
@@ -1295,29 +1265,12 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 
 #endif /* CONFIG_SWIOTLB_DYNAMIC */
 
-#ifdef CONFIG_DEBUG_FS
-
-/**
- * mem_used() - get number of used slots in an allocator
- * @mem:	Software IO TLB allocator.
- *
- * The result is accurate in this version of the function, because an atomic
- * counter is available if CONFIG_DEBUG_FS is set.
- *
- * Return: Number of used slots.
- */
-static unsigned long mem_used(struct io_tlb_mem *mem)
-{
-	return atomic_long_read(&mem->total_used);
-}
-
-#else /* !CONFIG_DEBUG_FS */
-
 /**
  * mem_pool_used() - get number of used slots in a memory pool
  * @pool:	Software IO TLB memory pool.
  *
- * The result is not accurate, see mem_used().
+ * Returns the sum of per-area used slot counts. The result is approximate
+ * since there is no locking across areas.
  *
  * Return: Approximate number of used slots.
  */
@@ -1327,7 +1280,7 @@ static unsigned long mem_pool_used(struct io_tlb_pool *pool)
 	unsigned long used = 0;
 
 	for (i = 0; i < pool->nareas; i++)
-		used += pool->areas[i].used;
+		used += READ_ONCE(pool->areas[i].used);
 	return used;
 }
 
@@ -1335,8 +1288,8 @@ static unsigned long mem_pool_used(struct io_tlb_pool *pool)
  * mem_used() - get number of used slots in an allocator
  * @mem:	Software IO TLB allocator.
  *
- * The result is not accurate, because there is no locking of individual
- * areas.
+ * Returns the sum of per-area used slot counts across all pools. The result
+ * is approximate since there is no locking across areas.
  *
  * Return: Approximate number of used slots.
  */
@@ -1357,8 +1310,6 @@ static unsigned long mem_used(struct io_tlb_mem *mem)
 #endif
 }
 
-#endif /* CONFIG_DEBUG_FS */
-
 /**
  * swiotlb_tbl_map_single() - bounce buffer map a single contiguous physical area
  * @dev:		Device which maps the buffer.
@@ -1508,8 +1459,6 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr,
 		mem->slots[i].list = ++count;
 	area->used -= nslots;
 	spin_unlock_irqrestore(&area->lock, flags);
-
-	dec_used(dev->dma_io_tlb_mem, nslots);
 }
 
 #ifdef CONFIG_SWIOTLB_DYNAMIC
@@ -1531,7 +1480,6 @@ static bool swiotlb_del_transient(struct device *dev, phys_addr_t tlb_addr,
 	if (!pool->transient)
 		return false;
 
-	dec_used(dev->dma_io_tlb_mem, pool->nslabs);
 	swiotlb_del_pool(dev, pool);
 	dec_transient_used(dev->dma_io_tlb_mem, pool->nslabs);
 	return true;
@@ -1710,20 +1658,53 @@ static int io_tlb_used_get(void *data, u64 *val)
 static int io_tlb_hiwater_get(void *data, u64 *val)
 {
 	struct io_tlb_mem *mem = data;
+	unsigned long hiwater = 0;
+	struct io_tlb_pool *pool;
+	int i;
 
-	*val = atomic_long_read(&mem->used_hiwater);
+#ifdef CONFIG_SWIOTLB_DYNAMIC
+	rcu_read_lock();
+	list_for_each_entry_rcu(pool, &mem->pools, node)
+		for (i = 0; i < pool->nareas; i++)
+			hiwater += READ_ONCE(pool->areas[i].used_hiwater);
+	rcu_read_unlock();
+#else
+	pool = &mem->defpool;
+	for (i = 0; i < pool->nareas; i++)
+		hiwater += READ_ONCE(pool->areas[i].used_hiwater);
+#endif
+	*val = hiwater;
 	return 0;
 }
 
 static int io_tlb_hiwater_set(void *data, u64 val)
 {
 	struct io_tlb_mem *mem = data;
+	struct io_tlb_pool *pool;
+	unsigned long flags;
+	int i;
 
 	/* Only allow setting to zero */
 	if (val != 0)
 		return -EINVAL;
 
-	atomic_long_set(&mem->used_hiwater, val);
+#ifdef CONFIG_SWIOTLB_DYNAMIC
+	rcu_read_lock();
+	list_for_each_entry_rcu(pool, &mem->pools, node)
+		for (i = 0; i < pool->nareas; i++) {
+			spin_lock_irqsave(&pool->areas[i].lock, flags);
+			pool->areas[i].used_hiwater = 0;
+			spin_unlock_irqrestore(&pool->areas[i].lock, flags);
+		}
+	rcu_read_unlock();
+#else
+	pool = &mem->defpool;
+	for (i = 0; i < pool->nareas; i++) {
+		spin_lock_irqsave(&pool->areas[i].lock, flags);
+		pool->areas[i].used_hiwater = 0;
+		spin_unlock_irqrestore(&pool->areas[i].lock, flags);
+	}
+#endif
 	return 0;
 }
 
-- 
2.32.0

