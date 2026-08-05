Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ABE3C1F45
	for <iommu@lists.linux.dev>; Wed,  5 Aug 2026 02:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785897041; cv=none; b=lbznd725SVe1KOC+cGgomwFJuFw4esSeiVfQpDJ9GKNRb6x7uHbXDiLJRJ4ru8DH+rCTTctL7ynTXAT7nM5laZFJMMNg2BIXQjGfUEdQMR2n9MMiyYyT+mL00/H2ksR4UwQxK8vcNoMPdYRAV0vQIkpC7rE/izF5UOoMLuKEkPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785897041; c=relaxed/simple;
	bh=mZOsPX3LTAbFOnotC8RG9IiDi4oOEO9jyo1DP7zLsXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OweilCMxH16MrI1DSZEm+0r5eb+P5P913PKn3BkON+bS5ClWKhBVi8IE105MjDh/5djJHTU4f5XLjyX0AgPjpVTe+Hl7Kec9JNVjp5Q70rVcVftxueWn7qNC6usxFhqdW6Yb5N/fOpt7TXKqGYiI+ExMY2bJ9GKfpKSbIdloUd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=TGrPVF8d; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="TGrPVF8d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=QT
	4LZgJnE++k4dRz7RjOmpCzQVDpjTDENxgozO1BMXc=; b=TGrPVF8dRRYVWPEt+9
	NlEgrE7WGndTRAI5hQo5KcggXzhU8s4s5dl4MGwKs6IRUSjers8qyGSdekQLXNOB
	r6Jb3yiNGXVYQlZDCq/PK8S9xV1aYIbku1MinrFS1B6SkO2BEcdPLDi7BDsopfSH
	DokvgZmRpwf9hMmbWHJxUmE5I=
Received: from frank-Vostro-3671.bbrouter (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDn9040oHJq42ZtEQ--.33985S2;
	Wed, 05 Aug 2026 10:30:12 +0800 (CST)
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
Subject: [PATCH v3] dma/swiotlb: decouple high watermark tracking from CONFIG_DEBUG_FS
Date: Wed,  5 Aug 2026 10:29:58 +0800
Message-ID: <20260805022958.329840-1-frankchen158@126.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260622122114.2563254-1-jun.miao@intel.com>
References: <20260622122114.2563254-1-jun.miao@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn9040oHJq42ZtEQ--.33985S2
X-Coremail-Antispam: 1Uf129KBjvJXoWfGr43AFykKw45Jr47uFyDZFb_yoWkGr17pF
	y8Jw1UtF4DXr10kFWUC34xGF1ayws3Ca9xWrW3Kr9ag3ZxtrnaqFnakrW5ZFW5JrW8ZF43
	Xa43uryrCrsrCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UpuWJUUUUU=
X-CM-SenderInfo: xiud0yxfkh0iivy6ij2wof0z/xtbBsBRs-mpyoDSHSwAA32

From: chenhuguanshen <chenhgs@chinatelecom.cn>

Under heavy concurrent DMA traffic on CoCo VMs, inc_used_and_hiwater()
performs an atomic_long_add_return() plus a CAS loop on the global
used_hiwater, and dec_used() performs an atomic_long_sub() on total_used.
All CPUs contend on the same cacheline, causing measurable throughput
degradation at scale.

Historically these counters were only compiled in under CONFIG_DEBUG_FS,
which means production kernels without debugfs paid the atomic overhead
unconditionally once the symbols were present. Make the tracking
boot-time opt-in instead so that it is disabled by default with near-zero
overhead via static_call, and can be enabled via "swiotlb=track_hiwater"
parameter on demand for debugging.

Changes:

- Introduction of static_call infrastructure: Under CONFIG_DEBUG_FS, real
  tracking functions and no-op stubs are defined, with DEFINE_STATIC_CALL
  defaulting to the stubs, making overhead near-zero when disabled.

- Parsing the track_hiwater boot parameter: setup_io_tlb_npages() is updated
  to recognize track_hiwater, which triggers static_call_update() to dynamically
  replace the stubs with the real tracking implementations.

- Removal of old compile-time-gated definitions: The old #ifdef/#else block
  defining inc_used_and_hiwater()/dec_used() is deleted, as its logic is now
  replaced by the static_call approach.

- Unification of mem_used() implementation: The two separate debugfs/non-debugfs
  versions are merged into one function that checks track_hiwater_enabled at
  runtime to decide whether to return an accurate or approximate value.

- Update of struct field comments: Comments on total_used and used_hiwater are
  changed from "used only in debugfs" to "enabled via swiotlb=track_hiwater boot
  parameter and exposed via debugfs".

- Documentation of the new boot parameter: The kernel-parameters documentation
  adds track_hiwater as a valid option for swiotlb= with its description.

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
   on the kernel boot line so that the exact hiwater mark during boot is
   easily available.

v2 -> v3:
 - When track_hiwater is enabled, we keep the original precise hiwater
   calculation backed by the global total_used atomic counter. If disabled,
   we switch to the approximate approach that sums per-area counters to
   derive the total used slot count.
---
 .../admin-guide/kernel-parameters.txt         |   3 +-
 include/linux/swiotlb.h                       |   8 +-
 kernel/dma/swiotlb.c                          | 153 +++++++++++-------
 3 files changed, 100 insertions(+), 64 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b5493a7f8f22..2caa9c0b3d7a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7477,7 +7477,7 @@ Kernel parameters
 			Execution Facility on pSeries.
 
 	swiotlb=	[ARM,PPC,MIPS,X86,S390,EARLY]
-			Format: { <int> [,<int>] | force | noforce }
+			Format: { <int> [,<int>] | force | noforce | track_hiwater}
 			<int> -- Number of I/O TLB slabs
 			<int> -- Second integer after comma. Number of swiotlb
 				 areas with their own lock. Will be rounded up
@@ -7485,6 +7485,7 @@ Kernel parameters
 			force -- force using of bounce buffers even if they
 			         wouldn't be automatically used by the kernel
 			noforce -- Never use bounce buffers (for debugging)
+			track_hiwater -- Track high watermark of swiotlb buffers
 
 	switches=	[HW,M68k,EARLY]
 
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 3dae0f592063..008f169e4006 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -98,10 +98,10 @@ struct io_tlb_pool {
  * @pools:	List of IO TLB memory pool descriptors (if dynamic).
  * @dyn_alloc:	Dynamic IO TLB pool allocation work.
  * @total_used:	The total number of slots in the pool that are currently used
- *		across all areas. Used only for calculating used_hiwater in
- *		debugfs.
- * @used_hiwater: The high water mark for total_used.  Used only for reporting
- *		in debugfs.
+ *		across all areas. Used only for calculating used_hiwater via boot
+ *		parameter swiotlb=track_hiwater and exposed via debugfs.
+ * @used_hiwater: The high water mark for total_used.  Can be enabled at boot
+ *		time via swiotlb=track_hiwater and exposed via debugfs.
  * @transient_nslabs: The total number of slots in all transient pools that
  *		are currently used across all areas.
  */
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 1abd3e6146f4..799eee3bf9cf 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -180,6 +180,74 @@ static unsigned int limit_nareas(unsigned int nareas, unsigned long nslots)
 	return nareas;
 }
 
+#ifdef CONFIG_DEBUG_FS
+/*
+ * Track the total used slots with a global atomic value in order to have
+ * correct information to determine the high water mark.
+ */
+static void inc_used_and_hiwater_real(struct io_tlb_mem *mem,
+				      unsigned int nslots)
+{
+	unsigned long old_hiwater, new_used;
+
+	new_used = atomic_long_add_return(nslots, &mem->total_used);
+	old_hiwater = atomic_long_read(&mem->used_hiwater);
+	do {
+		if (new_used <= old_hiwater)
+			break;
+	} while (!atomic_long_try_cmpxchg(&mem->used_hiwater,
+					  &old_hiwater, new_used));
+}
+
+static void dec_used_real(struct io_tlb_mem *mem, unsigned int nslots)
+{
+	atomic_long_sub(nslots, &mem->total_used);
+}
+
+static void inc_used_and_hiwater_nop(struct io_tlb_mem *mem,
+				     unsigned int nslots)
+{
+}
+static void dec_used_nop(struct io_tlb_mem *mem, unsigned int nslots)
+{
+}
+
+DEFINE_STATIC_CALL(swiotlb_inc_used, inc_used_and_hiwater_nop);
+DEFINE_STATIC_CALL(swiotlb_dec_used, dec_used_nop);
+
+static __always_inline void inc_used_and_hiwater(struct io_tlb_mem *mem,
+						  unsigned int nslots)
+{
+	static_call(swiotlb_inc_used)(mem, nslots);
+}
+
+static __always_inline void dec_used(struct io_tlb_mem *mem,
+				     unsigned int nslots)
+{
+	static_call(swiotlb_dec_used)(mem, nslots);
+}
+
+static bool track_hiwater_enabled __read_mostly;
+
+#else
+
+static __always_inline void inc_used_and_hiwater(struct io_tlb_mem *mem,
+						  unsigned int nslots)
+{
+}
+
+static __always_inline void dec_used(struct io_tlb_mem *mem,
+				     unsigned int nslots)
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
 static int __init
 setup_io_tlb_npages(char *str)
 {
@@ -194,10 +262,24 @@ setup_io_tlb_npages(char *str)
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
+
+#ifdef CONFIG_DEBUG_FS
+	if (*str == ',')
+		++str;
+	if (!strncmp(str, "track_hiwater", 13)) {
+		track_hiwater_enabled = true;
+		static_call_update(swiotlb_inc_used,
+					inc_used_and_hiwater_real);
+		static_call_update(swiotlb_dec_used, dec_used_real);
+	}
+#endif
 
 	return 0;
 }
@@ -959,40 +1041,6 @@ static unsigned int wrap_area_index(struct io_tlb_pool *mem, unsigned int index)
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
@@ -1295,24 +1343,6 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 
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
@@ -1335,13 +1365,20 @@ static unsigned long mem_pool_used(struct io_tlb_pool *pool)
  * mem_used() - get number of used slots in an allocator
  * @mem:	Software IO TLB allocator.
  *
- * The result is not accurate, because there is no locking of individual
- * areas.
+ * When trace_hiwater and CONFIG_DEBUG_FS is enabled, the result is accurate
+ * because the total number of used slots is tracked in mem->total_used.
+ * Otherwise, the result is not accurate, because there is no locking of
+ * individual areas.
  *
- * Return: Approximate number of used slots.
+ * Return: Number of used slots.
  */
 static unsigned long mem_used(struct io_tlb_mem *mem)
 {
+#ifdef CONFIG_DEBUG_FS
+    if (track_hiwater_enabled)
+	    return atomic_long_read(&mem->total_used);
+#endif
+
 #ifdef CONFIG_SWIOTLB_DYNAMIC
 	struct io_tlb_pool *pool;
 	unsigned long used = 0;
@@ -1357,8 +1394,6 @@ static unsigned long mem_used(struct io_tlb_mem *mem)
 #endif
 }
 
-#endif /* CONFIG_DEBUG_FS */
-
 /**
  * swiotlb_tbl_map_single() - bounce buffer map a single contiguous physical area
  * @dev:		Device which maps the buffer.
-- 
2.53.0

