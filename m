Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9583337BE6B;
	Wed, 13 May 2026 02:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778637803; cv=none; b=fvhfYmzOh0t+YLOjbigbW9YWZXogDgyDBWuWWHwP7rx3yfSV7V4LMzcNkWwYIeglwOiQqKPe6BYYqsBG7dhJLGbc4UgxpeJc3VfG/e5pYt5xcfclPaH3fbd9kNzsDGhug3a0DNikGp+gv8pJm4fg3OtUyyV7Gcj/K4L8pcflYdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778637803; c=relaxed/simple;
	bh=/UNGNv99SYYyCkyQIROj0r03jmz125QkHkA/cto5zVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BpF6LKZm6C3VILNNZta/vjSJYvQFC25PpORg8gwBgNqDa5MoIw7EnWOcCSlLcoSM7kTCFV2SvWda9LgsHltrxWDSUEaw8bRYGVjPO3eb41FsDaRY4+8q+krpwQkZqo9GNmBf2dPxTZRq6cyohHpObh/02egyiXKF+BR3F6AhbHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=dvkt/qcg; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="dvkt/qcg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/bacrmtyorJAQIwe0qXADFoM1LPph2PmgFMHDS08SM0=; b=dvkt/qcg89NhJD5TjeRL0o3W6C
	QxUTd5HT5KdifuqmjA8fqbA04NoYfFZEW08s8zn7FwQ3Z+62VI1Usp9B4wnZQqhUdrOrKjSxpZhyy
	UZV7XmgH6xMUdKF6CbBXfY67ewbr3q8HzcAmghX92JGQh0iiBy5YghtPOS4SNTIwnXwxziwVjKW3E
	rJuNY7r1mIuIyqeqL9TjXzw13lAgK3Y4vqapsQcl33OHaHv+V6OZGimnmWKCE8ukcxJhknwB+IXMY
	lwT4Wv+oa1jl2JoAmk3+47OgRjnN735IHVuVXN19YOtFQPvFWse0zCXPe9eJB4yJqiRgjTAwFQG02
	gNtjIhSQ==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1wMywG-0000000022e-3ijl;
	Tue, 12 May 2026 22:03:08 -0400
From: Rik van Riel <riel@surriel.com>
To: linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com,
	joro@8bytes.org,
	will@kernel.org,
	iommu@lists.linux.dev,
	kyle@mcmartin.ca,
	kernel-team@meta.com,
	Rik van Riel <riel@meta.com>,
	Rik van Riel <riel@surriel.com>
Subject: [PATCH 1/5] iova: switch to augmented rbtree for log(n) allocation
Date: Tue, 12 May 2026 22:00:18 -0400
Message-ID: <20260513020304.1528751-2-riel@surriel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260513020304.1528751-1-riel@surriel.com>
References: <20260513020304.1528751-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rik van Riel <riel@meta.com>

The IOVA allocator's __alloc_and_insert_iova_range() walks the rbtree
backwards via rb_prev() to find a free gap, which is O(n) on the number
of allocated ranges. Under heavy fragmentation (e.g. iommu_iova caches
holding hundreds of thousands of ranges) this can take 20+ seconds and
trigger softlockups.

Switch to an augmented rbtree that tracks two new fields per iova node:

  gap_to_prev        - the free gap (in pfns) between this node and
                       its in-order predecessor.
  __subtree_max_gap  - max gap_to_prev over this node's subtree.

The augmented invariant is maintained via RB_DECLARE_CALLBACKS_MAX from
rbtree_augmented.h, plus explicit propagate() calls on insertion (where
both the new node and its successor get a fresh gap_to_prev) and on
deletion (where the successor's gap_to_prev grows).

The new __iova_search_free_gap() walks right-first to prefer high
addresses (preserving the existing top-down allocation behaviour) and
prunes any subtree whose __subtree_max_gap is smaller than the requested
size. For the typical IOMMU workload (uniform DMA mask per domain, so
limit_pfn never binds against a candidate gap) and unaligned or
small-alignment allocations, the search is O(log n). The
alloc_iova_fast() size_aligned path can still degrade to O(n) when
alignment is large relative to the available gaps; a follow-up patch
in this series addresses that case.

The cached_node / cached32_node fields and their update helpers are
left in place but no longer consulted on the alloc path; a follow-up
can strip them.

The fast-fail max32_alloc_size optimization is preserved.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Rik van Riel <riel@surriel.com>
---
 drivers/iommu/iova.c | 206 ++++++++++++++++++++++++++-----------------
 include/linux/iova.h |   2 +
 2 files changed, 128 insertions(+), 80 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 021daf6528de..953188e296f0 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -13,6 +13,7 @@
 #include <linux/bitops.h>
 #include <linux/cpu.h>
 #include <linux/workqueue.h>
+#include <linux/rbtree_augmented.h>
 
 /* The anchor node sits above the top of the usable address space */
 #define IOVA_ANCHOR	~0UL
@@ -34,6 +35,15 @@ static struct iova *to_iova(struct rb_node *node)
 	return rb_entry(node, struct iova, node);
 }
 
+static inline unsigned long iova_gap_value(struct iova *iova)
+{
+	return iova->gap_to_prev;
+}
+
+RB_DECLARE_CALLBACKS_MAX(static, iova_gap_callbacks,
+			 struct iova, node, unsigned long, __subtree_max_gap,
+			 iova_gap_value)
+
 void
 init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	unsigned long start_pfn)
@@ -54,20 +64,13 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	iovad->dma_32bit_pfn = 1UL << (32 - iova_shift(iovad));
 	iovad->max32_alloc_size = iovad->dma_32bit_pfn;
 	iovad->anchor.pfn_lo = iovad->anchor.pfn_hi = IOVA_ANCHOR;
+	iovad->anchor.gap_to_prev = IOVA_ANCHOR;
+	iovad->anchor.__subtree_max_gap = IOVA_ANCHOR;
 	rb_link_node(&iovad->anchor.node, NULL, &iovad->rbroot.rb_node);
 	rb_insert_color(&iovad->anchor.node, &iovad->rbroot);
 }
 EXPORT_SYMBOL_GPL(init_iova_domain);
 
-static struct rb_node *
-__get_cached_rbnode(struct iova_domain *iovad, unsigned long limit_pfn)
-{
-	if (limit_pfn <= iovad->dma_32bit_pfn)
-		return iovad->cached32_node;
-
-	return iovad->cached_node;
-}
-
 static void
 __cached_rbnode_insert_update(struct iova_domain *iovad, struct iova *new)
 {
@@ -96,49 +99,13 @@ __cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free)
 		iovad->cached_node = rb_next(&free->node);
 }
 
-static struct rb_node *iova_find_limit(struct iova_domain *iovad, unsigned long limit_pfn)
-{
-	struct rb_node *node, *next;
-	/*
-	 * Ideally what we'd like to judge here is whether limit_pfn is close
-	 * enough to the highest-allocated IOVA that starting the allocation
-	 * walk from the anchor node will be quicker than this initial work to
-	 * find an exact starting point (especially if that ends up being the
-	 * anchor node anyway). This is an incredibly crude approximation which
-	 * only really helps the most likely case, but is at least trivially easy.
-	 */
-	if (limit_pfn > iovad->dma_32bit_pfn)
-		return &iovad->anchor.node;
-
-	node = iovad->rbroot.rb_node;
-	while (to_iova(node)->pfn_hi < limit_pfn)
-		node = node->rb_right;
-
-search_left:
-	while (node->rb_left && to_iova(node->rb_left)->pfn_lo >= limit_pfn)
-		node = node->rb_left;
-
-	if (!node->rb_left)
-		return node;
-
-	next = node->rb_left;
-	while (next->rb_right) {
-		next = next->rb_right;
-		if (to_iova(next)->pfn_lo >= limit_pfn) {
-			node = next;
-			goto search_left;
-		}
-	}
-
-	return node;
-}
-
 /* Insert the iova into domain rbtree by holding writer lock */
 static void
 iova_insert_rbtree(struct rb_root *root, struct iova *iova,
 		   struct rb_node *start)
 {
 	struct rb_node **new, *parent = NULL;
+	struct rb_node *prev_node, *next_node;
 
 	new = (start) ? &start : &(root->rb_node);
 	/* Figure out where to put new node */
@@ -156,62 +123,104 @@ iova_insert_rbtree(struct rb_root *root, struct iova *iova,
 			return;
 		}
 	}
-	/* Add new node and rebalance tree. */
+
 	rb_link_node(&iova->node, parent, new);
-	rb_insert_color(&iova->node, root);
+
+	prev_node = rb_prev(&iova->node);
+	if (prev_node)
+		iova->gap_to_prev = iova->pfn_lo - to_iova(prev_node)->pfn_hi - 1;
+	else
+		iova->gap_to_prev = iova->pfn_lo;
+	iova->__subtree_max_gap = iova->gap_to_prev;
+
+	next_node = rb_next(&iova->node);
+	if (next_node)
+		to_iova(next_node)->gap_to_prev =
+			to_iova(next_node)->pfn_lo - iova->pfn_hi - 1;
+
+	if (parent)
+		iova_gap_callbacks.propagate(parent, NULL);
+	if (next_node)
+		iova_gap_callbacks.propagate(next_node, NULL);
+
+	rb_insert_augmented(&iova->node, root, &iova_gap_callbacks);
+}
+
+/*
+ * Search the augmented rbtree for the highest-addressed free gap of at least
+ * @size pages, with the allocation fitting below @limit_pfn and at or above
+ * @start_pfn. Returns the node whose gap_to_prev is used, or NULL.
+ */
+static struct rb_node *
+__iova_search_free_gap(struct rb_node *node, unsigned long size,
+		       unsigned long limit_pfn, unsigned long start_pfn,
+		       unsigned long align_mask, unsigned long *new_pfn)
+{
+	struct iova *iova;
+	struct rb_node *result;
+
+	if (!node)
+		return NULL;
+
+	iova = to_iova(node);
+	if (iova->__subtree_max_gap < size)
+		return NULL;
+
+	result = __iova_search_free_gap(node->rb_right, size, limit_pfn,
+					start_pfn, align_mask, new_pfn);
+	if (result)
+		return result;
+
+	if (iova->gap_to_prev >= size) {
+		unsigned long gap_lo = iova->pfn_lo - iova->gap_to_prev;
+		unsigned long gap_hi = iova->pfn_lo - 1;
+		unsigned long pfn;
+
+		if (gap_hi >= limit_pfn)
+			gap_hi = limit_pfn - 1;
+		if (gap_hi >= gap_lo && gap_hi - gap_lo + 1 >= size) {
+			pfn = (gap_hi - size + 1) & align_mask;
+			if (pfn >= gap_lo && pfn >= start_pfn) {
+				*new_pfn = pfn;
+				return node;
+			}
+		}
+	}
+
+	return __iova_search_free_gap(node->rb_left, size, limit_pfn,
+				      start_pfn, align_mask, new_pfn);
 }
 
 static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 		unsigned long size, unsigned long limit_pfn,
 			struct iova *new, bool size_aligned)
 {
-	struct rb_node *curr, *prev;
-	struct iova *curr_iova;
 	unsigned long flags;
-	unsigned long new_pfn, retry_pfn;
+	unsigned long new_pfn;
 	unsigned long align_mask = ~0UL;
-	unsigned long high_pfn = limit_pfn, low_pfn = iovad->start_pfn;
+	struct rb_node *gap_node;
 
 	if (size_aligned)
 		align_mask <<= fls_long(size - 1);
 
-	/* Walk the tree backwards */
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
 	if (limit_pfn <= iovad->dma_32bit_pfn &&
 			size >= iovad->max32_alloc_size)
 		goto iova32_full;
 
-	curr = __get_cached_rbnode(iovad, limit_pfn);
-	curr_iova = to_iova(curr);
-	retry_pfn = curr_iova->pfn_hi;
-
-retry:
-	do {
-		high_pfn = min(high_pfn, curr_iova->pfn_lo);
-		new_pfn = (high_pfn - size) & align_mask;
-		prev = curr;
-		curr = rb_prev(curr);
-		curr_iova = to_iova(curr);
-	} while (curr && new_pfn <= curr_iova->pfn_hi && new_pfn >= low_pfn);
-
-	if (high_pfn < size || new_pfn < low_pfn) {
-		if (low_pfn == iovad->start_pfn && retry_pfn < limit_pfn) {
-			high_pfn = limit_pfn;
-			low_pfn = retry_pfn + 1;
-			curr = iova_find_limit(iovad, limit_pfn);
-			curr_iova = to_iova(curr);
-			goto retry;
-		}
-		iovad->max32_alloc_size = size;
+	gap_node = __iova_search_free_gap(iovad->rbroot.rb_node, size,
+					  limit_pfn, iovad->start_pfn,
+					  align_mask, &new_pfn);
+	if (!gap_node) {
+		if (limit_pfn <= iovad->dma_32bit_pfn)
+			iovad->max32_alloc_size = size;
 		goto iova32_full;
 	}
 
-	/* pfn_lo will point to size aligned address if size_aligned is set */
 	new->pfn_lo = new_pfn;
-	new->pfn_hi = new->pfn_lo + size - 1;
+	new->pfn_hi = new_pfn + size - 1;
 
-	/* If we have 'prev', it's a valid place to start the insertion. */
-	iova_insert_rbtree(&iovad->rbroot, new, prev);
+	iova_insert_rbtree(&iovad->rbroot, new, gap_node);
 	__cached_rbnode_insert_update(iovad, new);
 
 	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
@@ -295,9 +304,34 @@ private_find_iova(struct iova_domain *iovad, unsigned long pfn)
 
 static void remove_iova(struct iova_domain *iovad, struct iova *iova)
 {
+	struct rb_node *next_node;
+	struct iova *next_iova = NULL;
+
 	assert_spin_locked(&iovad->iova_rbtree_lock);
 	__cached_rbnode_delete_update(iovad, iova);
-	rb_erase(&iova->node, &iovad->rbroot);
+
+	next_node = rb_next(&iova->node);
+	if (next_node) {
+		struct rb_node *prev_node = rb_prev(&iova->node);
+
+		next_iova = to_iova(next_node);
+		if (prev_node)
+			next_iova->gap_to_prev =
+				next_iova->pfn_lo - to_iova(prev_node)->pfn_hi - 1;
+		else
+			next_iova->gap_to_prev = next_iova->pfn_lo;
+		/*
+		 * Propagate next_iova's new augmented values to the root BEFORE
+		 * the erase. Otherwise rotations inside rb_erase_augmented may
+		 * copy a stale __subtree_max_gap from next_iova to other nodes,
+		 * leaving ancestors in an inconsistent state that the post-erase
+		 * propagate cannot fully repair (early-termination at matching
+		 * intermediate values).
+		 */
+		iova_gap_callbacks.propagate(&next_iova->node, NULL);
+	}
+
+	rb_erase_augmented(&iova->node, &iovad->rbroot, &iova_gap_callbacks);
 }
 
 /**
@@ -527,8 +561,20 @@ reserve_iova(struct iova_domain *iovad,
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
 	for (node = rb_first(&iovad->rbroot); node; node = rb_next(node)) {
 		if (__is_range_overlap(node, pfn_lo, pfn_hi)) {
+			struct rb_node *p;
+			unsigned long gap;
+
 			iova = to_iova(node);
 			__adjust_overlap_range(iova, &pfn_lo, &pfn_hi);
+			p = rb_prev(node);
+			if (p)
+				gap = iova->pfn_lo - to_iova(p)->pfn_hi - 1;
+			else
+				gap = iova->pfn_lo;
+			if (iova->gap_to_prev != gap) {
+				iova->gap_to_prev = gap;
+				iova_gap_callbacks.propagate(node, NULL);
+			}
 			if ((pfn_lo >= iova->pfn_lo) &&
 				(pfn_hi <= iova->pfn_hi))
 				goto finish;
diff --git a/include/linux/iova.h b/include/linux/iova.h
index d2c4fd923efa..52635a72c5c5 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -19,6 +19,8 @@ struct iova {
 	struct rb_node	node;
 	unsigned long	pfn_hi; /* Highest allocated pfn */
 	unsigned long	pfn_lo; /* Lowest allocated pfn */
+	unsigned long	gap_to_prev;       /* Gap (in pfns) to predecessor */
+	unsigned long	__subtree_max_gap; /* Max gap_to_prev in subtree */
 };
 
 
-- 
2.52.0

