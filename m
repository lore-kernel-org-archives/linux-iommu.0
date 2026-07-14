Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79453812FE
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 03:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783999548; cv=none; b=FMMGt7684sgvc6Yu+QN/yVxwokciSihGYubYO2kqdbz9HM9BwfvrRa+G6wGwgwjLU6C3Wm6L9vFic/Dw8KfV2VN7Sfff24Xs5UTzmHPynjpaKPLCCAI9HIIqDenq1PilhvLcP1n0TZcX8/saAFZ3nL/CyRT3CBaiupY4CnjfSv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783999548; c=relaxed/simple;
	bh=jOdn7UTBgY2phBbMHnlhwqr1ZT77wXny2YADsIndDFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mauZIn7HR1g4y6k+OF9/wHkZg9Pubzu5RunZYpMWLr1YdOEhERSU7/Ef5+/i2nwO22GiQassOqhTgd5OYJm4L5Xkk85ilCYKnAGBNlO0OhAEUobWWbEGMzV9uE1lPO/djQkGlvRCm9BJnd62tg7yfpcRbo08rns0aP5Ja4SDU8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=bU/+N/TP; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="bU/+N/TP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=+n
	Eb+WyoimJppanfUCbOf7pNZFAH1VXUny4LwRn7Elg=; b=bU/+N/TP+ILdl+iPy3
	vmfExR0yn1r1P4CJeMevYKsloXzxNozgNvwXsJKUIkgpJcroZlak5/bG5EIBnpOD
	i9dWZyWKyHYlcLpBzyQEpav5ZAZeMGeEQfSFx8k0BmCQ0RWTW5gMMDX1LaGiQuNB
	DTzPLzyNq5V4jFKMA9pk4lWcE=
Received: from frank-pc.bbrouter (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3B7YlrFVqtlSFDQ--.32903S2;
	Tue, 14 Jul 2026 11:25:26 +0800 (CST)
From: Frank Chen <frankchen158@126.com>
To: mhklinux@outlook.com,
	hch@lst.de,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com
Cc: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	fan.du@intel.com,
	jun.miao@intel.com,
	chenhgs@chinatelecom.cn
Subject: [PATCH] dma/swiotlb: make high watermark tracking boot-time opt-in
Date: Tue, 14 Jul 2026 11:25:20 +0800
Message-Id: <20260714032520.1058536-1-frankchen158@126.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622122114.2563254-1-jun.miao@intel.com>
References: <20260622122114.2563254-1-jun.miao@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3B7YlrFVqtlSFDQ--.32903S2
X-Coremail-Antispam: 1Uf129KBjvJXoWfGr4DAFWDuw48GFyDuw1Utrb_yoWDWw1kpF
	y5Jw1DtF4DXF10kFWDC348GF1ayw4S939xWrW5Kr9aq3Zxtrn3XFn2yrWYvFW5JrW8ZF4a
	qFya9FyrCrsrCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UAHUkUUUUU=
X-CM-SenderInfo: xiud0yxfkh0iivy6ij2wof0z/xtbBogYktmpVrCbgRgAA3l

From: chenhuguanshen <chenhgs@chinatelecom.cn>

Under heavy concurrent DMA traffic on CoCo VMs, inc_used_and_hiwater()
performs an atomic_long_add_return() plus a CAS loop on the global
used_hiwater, and dec_used() performs an atomic_long_sub() on total_used.
All CPUs contend on the same cacheline, causing measurable throughput
degradation at scale.

Historically these counters were only compiled in under CONFIG_DEBUG_FS,
which means production kernels with debugfs paid the atomic overhead
unconditionally once the symbols were present. Make the tracking
boot-time opt-in instead so that it is disabled by default with near-zero
overhead via static_call, and can be enabled via "swiotlb=track_hiwater"
parameter on demand for debugging.

Changes:

- The previous inc_used_and_hiwater() maintained a separate atomic
  total_used counter for accurate hiwater updates. This is replaced with
  mem_used() which sums across areas. While less precise (no cross-area
  locking), the result is adequate for high watermark statistics and
  avoids the overhead of maintaining total_used on every alloc/free.

- Refactor high watermark tracking to use static_call, allowing it to be
  enabled at boot via the swiotlb=track_hiwater parameter when
  CONFIG_DEBUG_FS is set. When disabled (the default), the static_call
  resolves to a no-op function, ensuring near-zero overhead.

- Remove the total_used atomic counter from io_tlb_mem since it is no
  longer needed. The debugfs "io_tlb_used" file already uses mem_used()
  to report current usage.

Suggested-by: Fan Du <fan.du@intel.com>
Signed-off-by: Jun Miao <jun.miao@intel.com>
Co-developed-by: Fan Du <fan.du@intel.com>
Signed-off-by: Fan Du <fan.du@intel.com>
Tested-by: chenhuguanshen <chenhgs@chinatelecom.cn>
Signed-off-by: chenhuguanshen <chenhgs@chinatelecom.cn>
---
v1 -> v2:                                                                                                               
 - Change the patch title.                                                                                              
 - Doing the exact hiwater calculation is dynamic and defaults to "off",                                                
   dynamic config would replace being under #ifdef CONFIG_DEBUG_FS                                                      
 - The mechanism used for dynamic config needs to be one that is selectable                                             
   on the kernel boot line so that the exact hiwater mark during boot is easily available.

---
 .../admin-guide/kernel-parameters.txt         |   3 +-
 include/linux/swiotlb.h                       |  10 +-
 kernel/dma/swiotlb.c                          | 125 +++++++++---------
 3 files changed, 68 insertions(+), 70 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b2d7d3540ded..bb60c55383a0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7485,7 +7485,7 @@ Kernel parameters
 			Execution Facility on pSeries.
 
 	swiotlb=	[ARM,PPC,MIPS,X86,S390,EARLY]
-			Format: { <int> [,<int>] | force | noforce }
+			Format: { <int> [,<int>] | force | noforce | track_hiwater }
 			<int> -- Number of I/O TLB slabs
 			<int> -- Second integer after comma. Number of swiotlb
 				 areas with their own lock. Will be rounded up
@@ -7493,6 +7493,7 @@ Kernel parameters
 			force -- force using of bounce buffers even if they
 			         wouldn't be automatically used by the kernel
 			noforce -- Never use bounce buffers (for debugging)
+			track_hiwater -- Track high watermark of swiotlb buffers
 
 	switches=	[HW,M68k,EARLY]
 
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 3dae0f592063..e308792243cc 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -97,11 +97,8 @@ struct io_tlb_pool {
  * @lock:	Lock to synchronize changes to the list.
  * @pools:	List of IO TLB memory pool descriptors (if dynamic).
  * @dyn_alloc:	Dynamic IO TLB pool allocation work.
- * @total_used:	The total number of slots in the pool that are currently used
- *		across all areas. Used only for calculating used_hiwater in
- *		debugfs.
- * @used_hiwater: The high water mark for total_used.  Used only for reporting
- *		in debugfs.
+ * @used_hiwater: The high watermark of used slots. Can be enabled at
+ *              boot time via swiotlb=track_hiwater.
  * @transient_nslabs: The total number of slots in all transient pools that
  *		are currently used across all areas.
  */
@@ -119,9 +116,8 @@ struct io_tlb_mem {
 	struct work_struct dyn_alloc;
 #endif
 #ifdef CONFIG_DEBUG_FS
-	atomic_long_t total_used;
-	atomic_long_t used_hiwater;
 	atomic_long_t transient_nslabs;
+	atomic_long_t used_hiwater;
 #endif
 };
 
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 1abd3e6146f4..5828163c15f7 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -180,8 +180,55 @@ static unsigned int limit_nareas(unsigned int nareas, unsigned long nslots)
 	return nareas;
 }
 
-static int __init
-setup_io_tlb_npages(char *str)
+#ifdef CONFIG_DEBUG_FS
+static unsigned long mem_used(struct io_tlb_mem *mem);
+
+/*
+ * Track the total used slots to determine the high watermark.
+ * Unlike the previous total_used atomic counter which provided
+ * exact values, mem_used() iterates areas without cross-area
+ * locking and may return imprecise results under concurrent
+ * alloc/free. This is acceptable for high watermark statistics
+ * and avoids the overhead of maintaining a dedicated atomic
+ * counter on every allocation and free.
+ */
+static void account_hiwater_real(struct io_tlb_mem *mem)
+{
+	unsigned long old_hiwater, new_used;
+
+	new_used = mem_used(mem);
+	old_hiwater = atomic_long_read(&mem->used_hiwater);
+	do {
+		if (new_used <= old_hiwater)
+			break;
+	} while (!atomic_long_try_cmpxchg(&mem->used_hiwater,
+					  &old_hiwater, new_used));
+}
+
+static void account_hiwater_nop(struct io_tlb_mem *mem)
+{
+}
+
+DEFINE_STATIC_CALL(swiotlb_account_hiwater, account_hiwater_nop);
+
+static __always_inline void account_hiwater(struct io_tlb_mem *mem)
+{
+	static_call(swiotlb_account_hiwater)(mem);
+}
+
+#else
+static __always_inline void account_hiwater(struct io_tlb_mem *mem)
+{
+}
+#endif
+
+/*
+ * The tracking of used slots high watermark can be enabled
+ * by appending "track_hiwater" to the swiotlb= boot parameter.
+ * When disabled the tracking functions are no-ops with near-zero
+ * overhead via static_call.
+ */
+static int __init setup_io_tlb_npages(char *str)
 {
 	if (isdigit(*str)) {
 		/* avoid tail segment of size < IO_TLB_SEGSIZE */
@@ -194,10 +241,21 @@ setup_io_tlb_npages(char *str)
 		swiotlb_adjust_nareas(simple_strtoul(str, &str, 0));
 	if (*str == ',')
 		++str;
-	if (!strcmp(str, "force"))
+	if (!strncmp(str, "force", 5)) {
 		swiotlb_force_bounce = true;
-	else if (!strcmp(str, "noforce"))
+		str += 5;
+	} else if (!strncmp(str, "noforce", 7)) {
 		swiotlb_force_disable = true;
+		str += 7;
+	}
+#ifdef CONFIG_DEBUG_FS
+	if (*str == ',')
+		++str;
+	if (!strncmp(str, "track_hiwater", 13)) {
+		static_call_update(swiotlb_account_hiwater,
+				   account_hiwater_real);
+	}
+#endif
 
 	return 0;
 }
@@ -959,40 +1017,6 @@ static unsigned int wrap_area_index(struct io_tlb_pool *mem, unsigned int index)
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
@@ -1134,7 +1158,7 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
 	area->used += nslots;
 	spin_unlock_irqrestore(&area->lock, flags);
 
-	inc_used_and_hiwater(dev->dma_io_tlb_mem, nslots);
+	account_hiwater(dev->dma_io_tlb_mem);
 	return slot_index;
 }
 
@@ -1295,24 +1319,6 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 
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
@@ -1357,8 +1363,6 @@ static unsigned long mem_used(struct io_tlb_mem *mem)
 #endif
 }
 
-#endif /* CONFIG_DEBUG_FS */
-
 /**
  * swiotlb_tbl_map_single() - bounce buffer map a single contiguous physical area
  * @dev:		Device which maps the buffer.
@@ -1508,8 +1512,6 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr,
 		mem->slots[i].list = ++count;
 	area->used -= nslots;
 	spin_unlock_irqrestore(&area->lock, flags);
-
-	dec_used(dev->dma_io_tlb_mem, nslots);
 }
 
 #ifdef CONFIG_SWIOTLB_DYNAMIC
@@ -1531,7 +1533,6 @@ static bool swiotlb_del_transient(struct device *dev, phys_addr_t tlb_addr,
 	if (!pool->transient)
 		return false;
 
-	dec_used(dev->dma_io_tlb_mem, pool->nslabs);
 	swiotlb_del_pool(dev, pool);
 	dec_transient_used(dev->dma_io_tlb_mem, pool->nslabs);
 	return true;
-- 
2.34.1

