Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959C5383327;
	Wed, 13 May 2026 02:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778637803; cv=none; b=tn8b8Wt+lugFwMsaSYFVr471b4Kjdj079Kf+jJTcrCRJycdjxV8SzNpAm3UXvwSxgSbMZT8EuEZLwQDpcjfPnP4orz+1MFdcUlzGzIJjw9RK2QF0DxTGqlpGeixwS1Uk8kEvG84T7Yi1B0QF7M3RnhElJfl+E3+t9FvrDleio24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778637803; c=relaxed/simple;
	bh=yr0uyDeU+CPABX1lp0VGou8MsU3xmqsVX+jMkSUmCj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S8LmQ/4zW014DNM4Ryw3fYqDBgX6xtW3J5eW4GcrQOnbf8eCDHnJNRk3a4z05A1hFMa5eiSHz5uN0vTUxozf90s+KWbv2PYrocVWgkv3VkVBQ2snpvFMFh1S1vFh2/MIYna3ZdCdO+2bAfr6LOgxEvdr8Pqc0pwIWipzukKYU2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=XaX7p0oP; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="XaX7p0oP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=5+2od+2GeT0w7P1FoWyNLqYLXCzvpgp9ZU4fCrRUjcI=; b=XaX7p0oPJ5CdE38vlg2JjNVTyg
	Q/BvyeTmwNqI54bjwE6MCoVzb5u/bomde/loR/BVb8sjRAEsbZbh01onjcmeT7FaReEw+md/myKC5
	XJosQt8qqSWWD2c7d8eDqzRCS2QUarOYw/8D8wx93tCDAQeKX5YF+MHTQARHfwwByJ/KxbfrrWxUh
	nJhPTCBK4jHKcFk+sTQmNrZBATnKGaRA6CQbBWFtwuXY6fVoWwlVO6DRXrOtkrOPv61PbBpskr8Yw
	MxGvnwberzADYRoqDVJN9YmSTicn2skTpZAeq+FipwQQ3IUKLoBNFloQkntEJyYLoIHHM8/QgmdkS
	5VQxV4IA==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1wMywG-0000000022e-3tSv;
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
Subject: [PATCH 3/5] iova: limit_pfn-aware augmentation for log(n) 32-bit alloc
Date: Tue, 12 May 2026 22:00:20 -0400
Message-ID: <20260513020304.1528751-4-riel@surriel.com>
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

The augmented-rbtree port made __iova_search_free_gap O(log n) when
limit_pfn doesn't bind any candidate gap, but degrades to O(n) when
limit_pfn is small relative to the gaps in the tree. The classic case
is a 32-bit DMA allocation on a domain dominated by 64-bit allocations:
the augmented invariant __subtree_max_gap is satisfied everywhere (the
huge gap between the highest 64-bit allocation and the IOVA_ANCHOR
dominates), so pruning never fires, and every node above limit_pfn must
be visited and rejected before falling through to the 32-bit region.

Add a second augmented field that bounds the search by 32-bit-clamped
gap size:

  clamped_gap32(node) =
      0                                if gap_to_prev == 0
      0                                if gap_lo >= dma_32bit_pfn
      min(gap_hi, dma_32bit_pfn-1) - gap_lo + 1   otherwise

  __subtree_max_gap32 = max(clamped_gap32) over subtree

clamped_gap32 is precomputed and stored on each iova whenever
gap_to_prev changes (insert, remove, reserve overlap fix-up), so the
augmented callbacks remain pure functions of the node and don't need
domain context.

The compute helper iova_compute_max() updates both __subtree_max_gap
and __subtree_max_gap32 in one pass; the hand-rolled propagate / copy
/ rotate callbacks (replacing the single-field RB_DECLARE_CALLBACKS_MAX
expansion) maintain both fields per insert/erase. Pruning in
__iova_search_free_gap selects between them based on whether the
caller is doing a 32-bit allocation.

For 64-bit allocations the behaviour is unchanged. For 32-bit
allocations on mixed-DMA-mask domains the search is now O(log n).

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Rik van Riel <riel@surriel.com>
---
 drivers/iommu/iova.c | 153 ++++++++++++++++++++++++++++++++++++-------
 include/linux/iova.h |   6 +-
 2 files changed, 133 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index c358ce981cae..7787da8b2dad 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -35,14 +35,97 @@ static struct iova *to_iova(struct rb_node *node)
 	return rb_entry(node, struct iova, node);
 }
 
-static inline unsigned long iova_gap_value(struct iova *iova)
+/*
+ * Portion of @iova->gap_to_prev that lies strictly below @dma_32bit_pfn,
+ * i.e. the largest contiguous sub-gap that a 32-bit-restricted allocation
+ * could possibly use. Maintained alongside gap_to_prev so the augmented
+ * callbacks can compare against it without needing per-iova access to the
+ * domain's dma_32bit_pfn.
+ */
+static unsigned long
+iova_compute_clamped_gap32(struct iova *iova, unsigned long dma_32bit_pfn)
+{
+	unsigned long gap_lo, gap_hi;
+
+	if (iova->gap_to_prev == 0)
+		return 0;
+	gap_lo = iova->pfn_lo - iova->gap_to_prev;
+	if (gap_lo >= dma_32bit_pfn)
+		return 0;
+	gap_hi = iova->pfn_lo - 1;
+	if (gap_hi >= dma_32bit_pfn)
+		gap_hi = dma_32bit_pfn - 1;
+	return gap_hi - gap_lo + 1;
+}
+
+/*
+ * Recompute @node's __subtree_max_gap and __subtree_max_gap32 from its
+ * own gap fields and its children's subtree maxes. Returns true (for
+ * propagate's early-termination) if neither value would change.
+ */
+static bool iova_compute_max(struct iova *node, bool exit)
 {
-	return iova->gap_to_prev;
+	unsigned long max_gap = node->gap_to_prev;
+	unsigned long max_gap32 = node->clamped_gap32;
+	struct iova *child;
+
+	if (node->node.rb_left) {
+		child = to_iova(node->node.rb_left);
+		if (child->__subtree_max_gap > max_gap)
+			max_gap = child->__subtree_max_gap;
+		if (child->__subtree_max_gap32 > max_gap32)
+			max_gap32 = child->__subtree_max_gap32;
+	}
+	if (node->node.rb_right) {
+		child = to_iova(node->node.rb_right);
+		if (child->__subtree_max_gap > max_gap)
+			max_gap = child->__subtree_max_gap;
+		if (child->__subtree_max_gap32 > max_gap32)
+			max_gap32 = child->__subtree_max_gap32;
+	}
+	if (exit && node->__subtree_max_gap == max_gap &&
+	    node->__subtree_max_gap32 == max_gap32)
+		return true;
+	node->__subtree_max_gap = max_gap;
+	node->__subtree_max_gap32 = max_gap32;
+	return false;
 }
 
-RB_DECLARE_CALLBACKS_MAX(static, iova_gap_callbacks,
-			 struct iova, node, unsigned long, __subtree_max_gap,
-			 iova_gap_value)
+static void iova_gap_propagate(struct rb_node *rb, struct rb_node *stop)
+{
+	while (rb != stop) {
+		struct iova *node = to_iova(rb);
+
+		if (iova_compute_max(node, true))
+			break;
+		rb = rb_parent(&node->node);
+	}
+}
+
+static void iova_gap_copy(struct rb_node *rb_old, struct rb_node *rb_new)
+{
+	struct iova *old = to_iova(rb_old);
+	struct iova *new = to_iova(rb_new);
+
+	new->__subtree_max_gap = old->__subtree_max_gap;
+	new->__subtree_max_gap32 = old->__subtree_max_gap32;
+}
+
+static void iova_gap_rotate(struct rb_node *rb_old, struct rb_node *rb_new)
+{
+	struct iova *old = to_iova(rb_old);
+	struct iova *new = to_iova(rb_new);
+
+	new->__subtree_max_gap = old->__subtree_max_gap;
+	new->__subtree_max_gap32 = old->__subtree_max_gap32;
+	iova_compute_max(old, false);
+}
+
+static const struct rb_augment_callbacks iova_gap_callbacks = {
+	.propagate = iova_gap_propagate,
+	.copy = iova_gap_copy,
+	.rotate = iova_gap_rotate,
+};
 
 void
 init_iova_domain(struct iova_domain *iovad, unsigned long granule,
@@ -64,6 +147,9 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	iovad->anchor.pfn_lo = iovad->anchor.pfn_hi = IOVA_ANCHOR;
 	iovad->anchor.gap_to_prev = IOVA_ANCHOR;
 	iovad->anchor.__subtree_max_gap = IOVA_ANCHOR;
+	iovad->anchor.clamped_gap32 = iova_compute_clamped_gap32(&iovad->anchor,
+								 iovad->dma_32bit_pfn);
+	iovad->anchor.__subtree_max_gap32 = iovad->anchor.clamped_gap32;
 	rb_link_node(&iovad->anchor.node, NULL, &iovad->rbroot.rb_node);
 	rb_insert_color(&iovad->anchor.node, &iovad->rbroot);
 }
@@ -71,9 +157,10 @@ EXPORT_SYMBOL_GPL(init_iova_domain);
 
 /* Insert the iova into domain rbtree by holding writer lock */
 static void
-iova_insert_rbtree(struct rb_root *root, struct iova *iova,
+iova_insert_rbtree(struct iova_domain *iovad, struct iova *iova,
 		   struct rb_node *start)
 {
+	struct rb_root *root = &iovad->rbroot;
 	struct rb_node **new, *parent = NULL;
 	struct rb_node *prev_node, *next_node;
 
@@ -101,12 +188,18 @@ iova_insert_rbtree(struct rb_root *root, struct iova *iova,
 		iova->gap_to_prev = iova->pfn_lo - to_iova(prev_node)->pfn_hi - 1;
 	else
 		iova->gap_to_prev = iova->pfn_lo;
+	iova->clamped_gap32 = iova_compute_clamped_gap32(iova, iovad->dma_32bit_pfn);
 	iova->__subtree_max_gap = iova->gap_to_prev;
+	iova->__subtree_max_gap32 = iova->clamped_gap32;
 
 	next_node = rb_next(&iova->node);
-	if (next_node)
-		to_iova(next_node)->gap_to_prev =
-			to_iova(next_node)->pfn_lo - iova->pfn_hi - 1;
+	if (next_node) {
+		struct iova *next_iova = to_iova(next_node);
+
+		next_iova->gap_to_prev = next_iova->pfn_lo - iova->pfn_hi - 1;
+		next_iova->clamped_gap32 = iova_compute_clamped_gap32(next_iova,
+								      iovad->dma_32bit_pfn);
+	}
 
 	if (parent)
 		iova_gap_callbacks.propagate(parent, NULL);
@@ -119,25 +212,32 @@ iova_insert_rbtree(struct rb_root *root, struct iova *iova,
 /*
  * Search the augmented rbtree for the highest-addressed free gap of at least
  * @size pages, with the allocation fitting below @limit_pfn and at or above
- * @start_pfn. Returns the node whose gap_to_prev is used, or NULL.
+ * @start_pfn. When @is_32bit, prune by the 32-bit-clamped subtree max so
+ * that 32-bit-restricted allocations on a domain dominated by high-pfn
+ * allocations stay O(log n) instead of degrading to O(n). Returns the node
+ * whose gap_to_prev is used, or NULL.
  */
 static struct rb_node *
 __iova_search_free_gap(struct rb_node *node, unsigned long size,
 		       unsigned long limit_pfn, unsigned long start_pfn,
-		       unsigned long align_mask, unsigned long *new_pfn)
+		       unsigned long align_mask, bool is_32bit,
+		       unsigned long *new_pfn)
 {
 	struct iova *iova;
 	struct rb_node *result;
+	unsigned long subtree_max;
 
 	if (!node)
 		return NULL;
 
 	iova = to_iova(node);
-	if (iova->__subtree_max_gap < size)
+	subtree_max = is_32bit ? iova->__subtree_max_gap32
+			       : iova->__subtree_max_gap;
+	if (subtree_max < size)
 		return NULL;
 
 	result = __iova_search_free_gap(node->rb_right, size, limit_pfn,
-					start_pfn, align_mask, new_pfn);
+					start_pfn, align_mask, is_32bit, new_pfn);
 	if (result)
 		return result;
 
@@ -158,7 +258,7 @@ __iova_search_free_gap(struct rb_node *node, unsigned long size,
 	}
 
 	return __iova_search_free_gap(node->rb_left, size, limit_pfn,
-				      start_pfn, align_mask, new_pfn);
+				      start_pfn, align_mask, is_32bit, new_pfn);
 }
 
 static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
@@ -169,20 +269,21 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 	unsigned long new_pfn;
 	unsigned long align_mask = ~0UL;
 	struct rb_node *gap_node;
+	bool is_32bit;
 
 	if (size_aligned)
 		align_mask <<= fls_long(size - 1);
 
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
-	if (limit_pfn <= iovad->dma_32bit_pfn &&
-			size >= iovad->max32_alloc_size)
+	is_32bit = limit_pfn <= iovad->dma_32bit_pfn;
+	if (is_32bit && size >= iovad->max32_alloc_size)
 		goto iova32_full;
 
 	gap_node = __iova_search_free_gap(iovad->rbroot.rb_node, size,
 					  limit_pfn, iovad->start_pfn,
-					  align_mask, &new_pfn);
+					  align_mask, is_32bit, &new_pfn);
 	if (!gap_node) {
-		if (limit_pfn <= iovad->dma_32bit_pfn)
+		if (is_32bit)
 			iovad->max32_alloc_size = size;
 		goto iova32_full;
 	}
@@ -190,7 +291,7 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 	new->pfn_lo = new_pfn;
 	new->pfn_hi = new_pfn + size - 1;
 
-	iova_insert_rbtree(&iovad->rbroot, new, gap_node);
+	iova_insert_rbtree(iovad, new, gap_node);
 
 	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 	return 0;
@@ -291,13 +392,15 @@ static void remove_iova(struct iova_domain *iovad, struct iova *iova)
 				next_iova->pfn_lo - to_iova(prev_node)->pfn_hi - 1;
 		else
 			next_iova->gap_to_prev = next_iova->pfn_lo;
+		next_iova->clamped_gap32 = iova_compute_clamped_gap32(next_iova,
+								      iovad->dma_32bit_pfn);
 		/*
 		 * Propagate next_iova's new augmented values to the root BEFORE
 		 * the erase. Otherwise rotations inside rb_erase_augmented may
-		 * copy a stale __subtree_max_gap from next_iova to other nodes,
-		 * leaving ancestors in an inconsistent state that the post-erase
-		 * propagate cannot fully repair (early-termination at matching
-		 * intermediate values).
+		 * copy a stale __subtree_max_gap or __subtree_max_gap32 from
+		 * next_iova to other nodes, leaving ancestors in an inconsistent
+		 * state that the post-erase propagate cannot fully repair
+		 * (early-termination at matching intermediate values).
 		 */
 		iova_gap_callbacks.propagate(&next_iova->node, NULL);
 	}
@@ -493,7 +596,7 @@ __insert_new_range(struct iova_domain *iovad,
 
 	iova = alloc_and_init_iova(pfn_lo, pfn_hi);
 	if (iova)
-		iova_insert_rbtree(&iovad->rbroot, iova, NULL);
+		iova_insert_rbtree(iovad, iova, NULL);
 
 	return iova;
 }
@@ -544,6 +647,8 @@ reserve_iova(struct iova_domain *iovad,
 				gap = iova->pfn_lo;
 			if (iova->gap_to_prev != gap) {
 				iova->gap_to_prev = gap;
+				iova->clamped_gap32 = iova_compute_clamped_gap32(iova,
+										 iovad->dma_32bit_pfn);
 				iova_gap_callbacks.propagate(node, NULL);
 			}
 			if ((pfn_lo >= iova->pfn_lo) &&
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 3c4cc81e5182..d262c6d88d6c 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -19,8 +19,10 @@ struct iova {
 	struct rb_node	node;
 	unsigned long	pfn_hi; /* Highest allocated pfn */
 	unsigned long	pfn_lo; /* Lowest allocated pfn */
-	unsigned long	gap_to_prev;       /* Gap (in pfns) to predecessor */
-	unsigned long	__subtree_max_gap; /* Max gap_to_prev in subtree */
+	unsigned long	gap_to_prev;         /* Gap (in pfns) to predecessor */
+	unsigned long	clamped_gap32;       /* gap_to_prev portion below dma_32bit_pfn */
+	unsigned long	__subtree_max_gap;   /* Max gap_to_prev in subtree */
+	unsigned long	__subtree_max_gap32; /* Max clamped_gap32 in subtree */
 };
 
 
-- 
2.52.0

