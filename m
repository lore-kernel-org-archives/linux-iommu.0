Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36143019D6;
	Wed, 24 Jun 2026 03:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782270543; cv=none; b=qBeGZe8AGI+V3UovvavsCJko4UsUveYEzg44+HhgbqmotVlsgOriBxRDTeLonKcU75NsNkTdovr6v3AOKHWiiPSJ5HIXb6tRLbs90XEbsXozWcZtnnlPkUZdFU/+H2e6kMQ2A6VztZ4K7ZRJf5lX+52ggdCx280aL4Bu5K7pOao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782270543; c=relaxed/simple;
	bh=CY5vnT8VYWZNhx5DRU6DKLUgBax0YxS9ELIoRMwgLCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eWLgvvvJXf21grpHy+IZLeqXK50seSyWgUxaaXuOljOVnsmEyBOskbbmGEDLniHNMzcQV/yE+yEIjIR0YL0aN827WHFVykrh6fB1xryi3FNZl28MfV/2NkO97IJ2BXummKOPLYhLfSfK8PkqazjT1rJTOr1wDzqc6lACOGy9RWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=TCG65LUn; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="TCG65LUn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=e0ipzlDgWTs5R+vr6nUQWayB04ggf85ufSHFP4Mmsd4=; b=TCG65LUnDFWqNb6gMBIrhJl7dQ
	t6oVr1vdLcg27FldAP9MF0GKUVcokQVsTbbim8ZgPfJ3f6wMrW9JWNoe9pUzMQ2z5wMtexWcbPc8d
	iahd+cI7oo0+0M6MbMcNpoHIxRUst00QuthAYs7sTHApGft84EnzEoUtOZSW+kOuh0mNyN3vdK+Be
	mLfVmfdGSn/KtaozXmnOWPC3CVEQ75mIb7bxBsKBcBeQyXRhVbxvLx9Eg55SxuKxgxbDdJXAAVQwS
	lRrJeBJQJlHu90Vskt8ZPyxDDpn/vtVcJqG6Pd/fHfFaA01+qTjsx5qP/NXYe1Yp87qlJxGh/uGLT
	FoUSqLFw==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1wcDyy-0000000087q-3JgN;
	Tue, 23 Jun 2026 23:08:56 -0400
From: Rik van Riel <riel@surriel.com>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	robin.murphy@arm.com,
	joro@8bytes.org,
	will@kernel.org,
	iommu@lists.linux.dev,
	jgg@ziepe.ca,
	kyle@mcmartin.ca,
	ashok.raj@oss.qualcomm.com,
	Rik van Riel <riel@surriel.com>
Subject: [PATCH 3/3] iova: defer maple tree erase on GFP_ATOMIC failure
Date: Tue, 23 Jun 2026 23:07:36 -0400
Message-ID: <20260624030853.2340880-4-riel@surriel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624030853.2340880-1-riel@surriel.com>
References: <20260624030853.2340880-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike the old rbtree, where rb_erase() never allocates, removing an
entry from the maple tree can require a node for rebalancing, and
mas_store_gfp(NULL, GFP_ATOMIC) can fail under memory pressure. The
IOVA allocator frees in atomic context (DMA map/unmap may run from
hardirq, softirq, or with spinlocks held), where the erase must not
fail and GFP_KERNEL is not available.

When the GFP_ATOMIC erase fails, overwrite the slot in place with a
marker (IOVA_DEFERRED) and free the struct iova immediately. Unlike
erasing, an in-place store over the entry's existing range changes no
range boundaries, so it needs no node for rebalancing and cannot fail:
storing NULL first runs mas_wr_extend_null(), which can widen the range
and escape the allocation-free wr_exact_fit store type, whereas storing
a non-NULL value over the same range stays wr_exact_fit. The marker is
a non-NULL, non-internal pointer, so the allocator's gap search keeps
the range reserved, while lookups, teardown and the invariant checker
recognise and skip it.

The slots that need a later erase are tracked by a [deferred_lo,
deferred_hi] bounding range in the domain. The deferred erase is
retried, returning the address space for reuse, by the next allocation
in the domain (before it searches for free space) or by the next
successful free, via iova_drain_deferred(), which walks only that
bounding range.

This keeps struct iova at 16 bytes: the rare-path state lives in the
maple tree (the marker) and two unsigned longs in the domain, rather
than a per-iova list node paid by every live mapping. No timer or
workqueue is needed; the erase that can fail is moved off the free path
and onto the allocation path, where running out of memory can simply be
reported to the caller.

In practice GFP_ATOMIC erase failures are rare: the slab allocator
keeps emergency reserves, the common erase case needs no node
allocation at all, and the first allocation attempt is backed by
per-CPU caches. This mechanism is a safety net for the exceptional
case.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Rik van Riel <riel@surriel.com>
---
 drivers/iommu/iova-kunit.c |  70 ++++++++++++++++
 drivers/iommu/iova.c       | 168 +++++++++++++++++++++++++++++++++----
 include/linux/iova.h       |   9 ++
 3 files changed, 233 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/iova-kunit.c b/drivers/iommu/iova-kunit.c
index bf37c5102e6e..317b46a45e5e 100644
--- a/drivers/iommu/iova-kunit.c
+++ b/drivers/iommu/iova-kunit.c
@@ -413,6 +413,74 @@ static void test_fragmented_32bit_search(struct kunit *test)
 		__free_iova(&ctx->iovad, iova);
 }
 
+/*
+ * Exercise the deferred-erase path: remove_iova() failing to erase under
+ * GFP_ATOMIC leaves an IOVA_DEFERRED marker in the tree and frees the struct
+ * iova immediately. iova_kunit_defer_erase makes that failure deterministic.
+ * Verify that while marked the range looks free to lookups yet stays reserved,
+ * that invariants hold, and that the next allocation drains the marker and
+ * reuses the space.
+ */
+static void test_deferred_erase(struct kunit *test)
+{
+	struct iova_test_ctx *ctx = test->priv;
+	struct iova *a, *b;
+	unsigned long pfn;
+
+	a = alloc_iova(&ctx->iovad, 1, TEST_LIMIT_32BIT, false);
+	KUNIT_ASSERT_NOT_NULL(test, a);
+	pfn = a->pfn_lo;
+
+	/* Free 'a', forcing the erase to be deferred (marker left behind). */
+	iova_kunit_defer_erase = true;
+	__free_iova(&ctx->iovad, a);
+	iova_kunit_defer_erase = false;
+
+	/*
+	 * The erase was deferred, not performed: a marker now occupies the slot,
+	 * so the backlog records the deferral and the pfn looks absent to lookups,
+	 * while the tree stays consistent with the marker present.
+	 */
+	KUNIT_EXPECT_TRUE(test, iova_domain_has_deferred(&ctx->iovad));
+	KUNIT_EXPECT_NULL(test, find_iova(&ctx->iovad, pfn));
+	KUNIT_EXPECT_TRUE(test, iova_domain_verify_invariants(&ctx->iovad));
+
+	/*
+	 * The next allocation drains deferred markers before searching, so the
+	 * backlog clears and the marked range is reclaimed; a top-down size-1
+	 * alloc reuses exactly the pfn that was freed.
+	 */
+	b = alloc_iova(&ctx->iovad, 1, TEST_LIMIT_32BIT, false);
+	KUNIT_ASSERT_NOT_NULL(test, b);
+	KUNIT_EXPECT_FALSE(test, iova_domain_has_deferred(&ctx->iovad));
+	KUNIT_EXPECT_EQ(test, b->pfn_lo, pfn);
+	KUNIT_EXPECT_TRUE(test, iova_domain_verify_invariants(&ctx->iovad));
+
+	__free_iova(&ctx->iovad, b);
+	KUNIT_EXPECT_TRUE(test, iova_domain_verify_invariants(&ctx->iovad));
+}
+
+/*
+ * Tearing down a domain that still holds an undrained IOVA_DEFERRED marker must
+ * skip the marker (it is static storage, not a heap iova) and not crash or
+ * double-free. Leave a marker live for iova_test_exit()'s put_iova_domain().
+ */
+static void test_deferred_erase_teardown(struct kunit *test)
+{
+	struct iova_test_ctx *ctx = test->priv;
+	struct iova *a;
+
+	a = alloc_iova(&ctx->iovad, 4, TEST_LIMIT_32BIT, false);
+	KUNIT_ASSERT_NOT_NULL(test, a);
+
+	iova_kunit_defer_erase = true;
+	__free_iova(&ctx->iovad, a);
+	iova_kunit_defer_erase = false;
+
+	/* Marker left live; the suite's exit -> put_iova_domain must cope. */
+	KUNIT_EXPECT_TRUE(test, iova_domain_verify_invariants(&ctx->iovad));
+}
+
 static struct kunit_case iova_test_cases[] = {
 	KUNIT_CASE(test_size_aligned),
 	KUNIT_CASE(test_top_down_preference),
@@ -424,6 +492,8 @@ static struct kunit_case iova_test_cases[] = {
 	KUNIT_CASE(test_stress_random),
 	KUNIT_CASE(test_full_space_search_time),
 	KUNIT_CASE(test_fragmented_32bit_search),
+	KUNIT_CASE(test_deferred_erase),
+	KUNIT_CASE(test_deferred_erase_teardown),
 	{}
 };
 
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index ca8d82417699..e0680de5311f 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -26,6 +26,24 @@ static unsigned long iova_rcache_get(struct iova_domain *iovad,
 static void free_iova_rcaches(struct iova_domain *iovad);
 static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
 static void free_global_cached_iovas(struct iova_domain *iovad);
+static void iova_drain_deferred(struct iova_domain *iovad);
+
+/*
+ * Placed in a maple-tree slot when an erase had to be deferred because a node
+ * allocation failed under GFP_ATOMIC (see remove_iova()). Overwriting a slot in
+ * place needs no allocation, so this marker can be stored even when the erase
+ * itself could not. It is a non-NULL, 8-byte-aligned (hence non-internal to the
+ * maple tree) pointer, so the allocator's gap search keeps the range reserved,
+ * while lookups, teardown and the invariant checker recognise and skip it.
+ * iova_drain_deferred() erases it once a node allocation succeeds.
+ */
+static const unsigned long iova_deferred_marker;
+#define IOVA_DEFERRED		((struct iova *)&iova_deferred_marker)
+
+static inline bool iova_has_deferred(const struct iova_domain *iovad)
+{
+	return iovad->deferred_lo <= iovad->deferred_hi;
+}
 
 void
 init_iova_domain(struct iova_domain *iovad, unsigned long granule,
@@ -52,6 +70,8 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	iovad->start_pfn = start_pfn;
 	iovad->dma_32bit_pfn = 1UL << (32 - iova_shift(iovad));
 	iovad->max32_alloc_size = iovad->dma_32bit_pfn;
+	iovad->deferred_lo = ULONG_MAX;
+	iovad->deferred_hi = 0;
 }
 EXPORT_SYMBOL_GPL(init_iova_domain);
 
@@ -73,6 +93,9 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 	}
 
 	spin_lock_irqsave(&iovad->iova_lock, flags);
+	/* Reclaim any deferred frees so their address space becomes available. */
+	if (unlikely(iova_has_deferred(iovad)))
+		iova_drain_deferred(iovad);
 	/*
 	 * Fast-fail a 32-bit request once one of the same-or-larger size has
 	 * already failed, without searching. The hint is read under the lock
@@ -175,21 +198,117 @@ static struct iova *
 private_find_iova(struct iova_domain *iovad, unsigned long pfn)
 {
 	MA_STATE(mas, &iovad->mtree, pfn, pfn);
+	struct iova *iova;
 
 	assert_spin_locked(&iovad->iova_lock);
-	return mas_walk(&mas);
+	iova = mas_walk(&mas);
+	/* A deferred-erase marker is not a live iova; treat it as absent. */
+	if (iova == IOVA_DEFERRED)
+		return NULL;
+	return iova;
 }
 
+/*
+ * Erase the deferred-removal markers left by remove_iova() when a GFP_ATOMIC
+ * node allocation was unavailable. The markers lie within the bounding range
+ * [deferred_lo, deferred_hi]; walk it erasing each one. A failed erase means no
+ * atomic memory is available right now, and no reclaim can happen under the
+ * lock, so the remaining erases would fail too: stop and keep everything from
+ * that point up still deferred, to be retried by a later allocation or free.
+ *
+ * Caller must hold iova_lock.
+ */
+static void iova_drain_deferred(struct iova_domain *iovad)
+{
+	unsigned long hi = iovad->deferred_hi;
+	void *entry;
+
+	MA_STATE(mas, &iovad->mtree, iovad->deferred_lo, hi);
+
+	assert_spin_locked(&iovad->iova_lock);
+
+	while ((entry = mas_find(&mas, hi)) != NULL) {
+		unsigned long lo = mas.index, last = mas.last;
+
+		if (entry == IOVA_DEFERRED) {
+			mas_set_range(&mas, lo, last);
+			if (mas_store_gfp(&mas, NULL, GFP_ATOMIC)) {
+				/*
+				 * No atomic memory now; further erases under
+				 * this lock would fail too (no reclaim happens
+				 * here). Everything from here up is still
+				 * deferred; retry on a later allocation or free.
+				 */
+				iovad->deferred_lo = lo;
+				iovad->deferred_hi = hi;
+				return;
+			}
+			/* The store may move the iterator; re-anchor past it. */
+			mas_set(&mas, last + 1);
+		}
+
+		if (last >= hi)
+			break;
+	}
+
+	/* All markers erased: the backlog is empty. */
+	iovad->deferred_lo = ULONG_MAX;
+	iovad->deferred_hi = 0;
+}
+
+#if IS_ENABLED(CONFIG_IOMMU_IOVA_KUNIT_TEST)
+/*
+ * Test hook: when set, force remove_iova() down the deferred-erase path as if
+ * the GFP_ATOMIC node allocation for the erase had failed. Lets the KUnit suite
+ * exercise the IOVA_DEFERRED marker and iova_drain_deferred() deterministically.
+ */
+bool iova_kunit_defer_erase;
+EXPORT_SYMBOL_GPL(iova_kunit_defer_erase);
+#else
+#define iova_kunit_defer_erase false
+#endif
+
+/*
+ * Remove an IOVA entry from the maple tree and free it.
+ *
+ * This runs in atomic context (DMA map/unmap can be called from hardirq,
+ * softirq, or with spinlocks held) and must not fail. Erasing an entry can
+ * require a maple tree node for rebalancing, and mas_store_gfp(NULL,
+ * GFP_ATOMIC) can fail under memory pressure. When it does, overwrite the slot
+ * in place with IOVA_DEFERRED -- an in-place store needs no node allocation and
+ * so cannot fail -- which keeps the address range reserved (the allocator's gap
+ * search treats the non-NULL slot as occupied) and lets the struct iova be
+ * freed now. The marker is erased later by iova_drain_deferred().
+ */
 static void remove_iova(struct iova_domain *iovad, struct iova *iova)
 {
-	MA_STATE(mas, &iovad->mtree, iova->pfn_lo, iova->pfn_hi);
+	unsigned long pfn_lo = iova->pfn_lo, pfn_hi = iova->pfn_hi;
+
+	MA_STATE(mas, &iovad->mtree, pfn_lo, pfn_hi);
 
 	assert_spin_locked(&iovad->iova_lock);
 
-	if (iova->pfn_lo < iovad->dma_32bit_pfn)
+	if (pfn_lo < iovad->dma_32bit_pfn)
 		iovad->max32_alloc_size = iovad->dma_32bit_pfn;
 
-	mas_store_gfp(&mas, NULL, GFP_ATOMIC);
+	if (iova_kunit_defer_erase || mas_store_gfp(&mas, NULL, GFP_ATOMIC)) {
+		/* Erase failed: mark the slot in place and defer removal. */
+		mas_set_range(&mas, pfn_lo, pfn_hi);
+		if (WARN_ON_ONCE(mas_store_gfp(&mas, IOVA_DEFERRED, GFP_ATOMIC)))
+			return;	/* in-place store cannot fail; entry stays put */
+		if (pfn_lo < iovad->deferred_lo)
+			iovad->deferred_lo = pfn_lo;
+		if (pfn_hi > iovad->deferred_hi)
+			iovad->deferred_hi = pfn_hi;
+		free_iova_mem(iova);
+		return;
+	}
+
+	free_iova_mem(iova);
+
+	/* A successful erase means memory is available; clear any backlog. */
+	if (unlikely(iova_has_deferred(iovad)))
+		iova_drain_deferred(iovad);
 }
 
 /**
@@ -225,7 +344,6 @@ __free_iova(struct iova_domain *iovad, struct iova *iova)
 	spin_lock_irqsave(&iovad->iova_lock, flags);
 	remove_iova(iovad, iova);
 	spin_unlock_irqrestore(&iovad->iova_lock, flags);
-	free_iova_mem(iova);
 }
 EXPORT_SYMBOL_GPL(__free_iova);
 
@@ -244,13 +362,9 @@ free_iova(struct iova_domain *iovad, unsigned long pfn)
 
 	spin_lock_irqsave(&iovad->iova_lock, flags);
 	iova = private_find_iova(iovad, pfn);
-	if (!iova) {
-		spin_unlock_irqrestore(&iovad->iova_lock, flags);
-		return;
-	}
-	remove_iova(iovad, iova);
+	if (iova)
+		remove_iova(iovad, iova);
 	spin_unlock_irqrestore(&iovad->iova_lock, flags);
-	free_iova_mem(iova);
 }
 EXPORT_SYMBOL_GPL(free_iova);
 
@@ -342,8 +456,14 @@ void put_iova_domain(struct iova_domain *iovad)
 	if (iovad->rcaches)
 		iova_domain_free_rcaches(iovad);
 
+	/*
+	 * Free the iovas. We can skip the IOVA_DEFERRED markers, because
+	 * __mt_destroy() will tear down the maple tree nodes without regard
+	 * for special leaf node values.
+	 */
 	mas_for_each(&mas, iova, ULONG_MAX)
-		free_iova_mem(iova);
+		if (iova != IOVA_DEFERRED)
+			free_iova_mem(iova);
 	__mt_destroy(&iovad->mtree);
 }
 EXPORT_SYMBOL_GPL(put_iova_domain);
@@ -391,12 +511,22 @@ reserve_iova(struct iova_domain *iovad,
 
 	spin_lock_irqsave(&iovad->iova_lock, flags);
 
+	/* Resolve any deferred erases so the walk below sees only live iovas. */
+	if (unlikely(iova_has_deferred(iovad)))
+		iova_drain_deferred(iovad);
+
 	/*
 	 * Compute the range covering all overlaps, but do not free the
 	 * overlapping iovas yet: the merged store below can fail, and freeing
 	 * before a failed store would leave dangling pointers in the tree.
 	 */
 	mas_for_each(&mas, overlap, pfn_hi) {
+		/*
+		 * A deferred-erase marker isn't a real iova; the merged-range
+		 * store below spans and overwrites it, so skip it here.
+		 */
+		if (overlap == IOVA_DEFERRED)
+			continue;
 		/* Fully covered by an existing reservation: hand it back. */
 		if (pfn_lo >= overlap->pfn_lo && pfn_hi <= overlap->pfn_hi) {
 			iova = overlap;
@@ -425,7 +555,8 @@ reserve_iova(struct iova_domain *iovad,
 
 	mas_set_range(&fmas, merged_lo, merged_hi);
 	mas_for_each(&fmas, overlap, merged_hi)
-		free_iova_mem(overlap);
+		if (overlap != IOVA_DEFERRED)
+			free_iova_mem(overlap);
 
 	mas_store_prealloc(&mas, iova);
 out:
@@ -515,7 +646,6 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
 			continue;
 
 		remove_iova(iovad, iova);
-		free_iova_mem(iova);
 	}
 
 	spin_unlock_irqrestore(&iovad->iova_lock, flags);
@@ -900,6 +1030,9 @@ bool iova_domain_verify_invariants(struct iova_domain *iovad)
 
 	spin_lock_irqsave(&iovad->iova_lock, flags);
 	mas_for_each(&mas, iova, ULONG_MAX) {
+		/* Deferred-erase markers occupy a slot but aren't real iovas. */
+		if (iova == IOVA_DEFERRED)
+			continue;
 		if (mas.index != iova->pfn_lo || mas.last != iova->pfn_hi) {
 			pr_err("iova_verify: maple index [%lu,%lu] != iova [%lu,%lu]\n",
 			       mas.index, mas.last, iova->pfn_lo, iova->pfn_hi);
@@ -922,6 +1055,13 @@ bool iova_domain_verify_invariants(struct iova_domain *iovad)
 	return ok;
 }
 EXPORT_SYMBOL_GPL(iova_domain_verify_invariants);
+
+/* Test accessor: is there an outstanding deferred-erase backlog? */
+bool iova_domain_has_deferred(struct iova_domain *iovad)
+{
+	return iova_has_deferred(iovad);
+}
+EXPORT_SYMBOL_GPL(iova_domain_has_deferred);
 #endif /* CONFIG_IOMMU_IOVA_KUNIT_TEST */
 
 MODULE_AUTHOR("Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>");
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 6fc070a4f58e..1f54ff3e2fb4 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -31,6 +31,13 @@ struct iova_domain {
 	unsigned long	start_pfn;	/* Lower limit for this domain */
 	unsigned long	dma_32bit_pfn;
 	unsigned long	max32_alloc_size; /* Size of last failed allocation */
+	/*
+	 * Bounding range of slots whose erase was deferred because a node
+	 * allocation failed under GFP_ATOMIC; deferred_lo > deferred_hi when
+	 * there are none. See remove_iova()/iova_drain_deferred().
+	 */
+	unsigned long	deferred_lo;
+	unsigned long	deferred_hi;
 
 	struct iova_rcache	*rcaches;
 	struct hlist_node	cpuhp_dead;
@@ -100,6 +107,8 @@ struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
 void put_iova_domain(struct iova_domain *iovad);
 #if IS_ENABLED(CONFIG_IOMMU_IOVA_KUNIT_TEST)
 bool iova_domain_verify_invariants(struct iova_domain *iovad);
+bool iova_domain_has_deferred(struct iova_domain *iovad);
+extern bool iova_kunit_defer_erase;
 #endif
 #else
 static inline int iova_cache_get(void)
-- 
2.53.0-Meta

