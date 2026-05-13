Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9579F37A494;
	Wed, 13 May 2026 02:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778637803; cv=none; b=ZaA6Z00ZD7EK1qa1ciis1BY04sFeYcPs86CdiENvtfaTbELfHCEBDu9MV3XHJwWwi+L5ZigAwYU+Kq99Oh4eVlEP0Z2fRFIbOr9MjFa20jDUTrwV2jCGULxb8Ubrmz/gP14VHiZkss2ECJMUWrCeuZPZammOSEFkSBDTXSvZdOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778637803; c=relaxed/simple;
	bh=EkeUf+jwV0orsuixqtfCqEcLphGVVp9g5ROQvcnY+Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LaIrd9PjbKfdRTvSXNrXlAQQJmgT3xF36IL9sZty8wV+QBa+DiDB9cYGxQQXttVjy9mOqQtM/iLq9bxnm/ygfylVMcrA/ItJbkqVoHYbp4KyiS6mWTq8/VLS3DEhMI9cgVSobI5BYVAl5LfqdZlgcwHCZGZhjFO0f9ZemiBQm+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=np8tuy7U; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="np8tuy7U"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=STKTIaA0zUdKDPKtHxdM0Rg8/7A21LDJqEbHedbnIhc=; b=np8tuy7U6mFAuab7mKO7XYfU+R
	/CD/N35l3lBiPSi2It/lfYNVJ1M73z3HlnSIofHe5dJhNs6I+ZPrv+QLcSgrwM7Sv71i/g/KtQOFc
	PGoGWWQ3/bmHY9SDU86YF8VT4T5PF86lfJ7grqrw+5+AVO876+wneGhVo9U/gGze2ZL5pU1zSGxhu
	1AWrufrX8B/6bqy+WoyFm6VzQQt9A/C0xWHFSVJTNU5rs4SGWkr64U2Y66rOg5foAh0TNdUjRLMGS
	LVuIpSn8gWVPPD7Mykp0VVynMaNqOCDzqEjAG57tz2hwGBjrOkPNVkvrzwSv1PKu/rHZDXVQ+l3kC
	UPLo0qpQ==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1wMywG-0000000022e-3zX6;
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
Subject: [PATCH 4/5] iova: alignment-aware two-phase search for log(n) aligned alloc
Date: Tue, 12 May 2026 22:00:21 -0400
Message-ID: <20260513020304.1528751-5-riel@surriel.com>
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

After the limit_pfn-aware augmentation, __iova_search_free_gap is
O(log n) for both 64-bit and 32-bit alloc paths -- but only when
ignoring alignment. The augmented invariant prunes by gap size; it
doesn't know about the per-call align_mask. A subtree whose
__subtree_max_gap >= size can still contain only borderline-sized gaps
that fail the alignment check, forcing the search to visit every node
in the subtree.

For a request of S pages with alignment A (a power of two), a gap of
size G is GUARANTEED to contain an aligned-fitting position iff
G >= S + A - 1. (Worst case: the highest aligned position
roundDOWN(gap_hi - S + 1, A) loses up to A-1 pfns to rounding.)

Two-phase search:

  Phase 1: prune by S + A - 1. Every visited node either prunes its
           subtree or descends into one whose subtree_max guarantees a
           fitting candidate. Strict O(log n).
  Phase 2: only if phase 1 returned NULL. Prune by S, the existing
           behaviour. Catches fortuitously-aligned borderline gaps.
           O(n) worst case but only triggers when no comfortable gap
           exists anywhere in the tree.

For typical IOMMU workloads (alloc_iova_fast rounds size up to a power
of two, so A == S, and most allocations are 1-16 pages) phase 1
succeeds and the search is one O(log n) descent. The borderline case
is the network/storage workload that fragments small power-of-two
allocations and statistically misaligns half (size 2), 75% (size 4),
or more (size 16) of the marginal gaps -- exactly where phase 2 is the
fallback.

Implementation: __iova_search_free_gap takes a separate prune_size
distinct from the size used for fitting and pfn computation, so phase
1 can prune more aggressively while still returning the correct
top-aligned pfn within whichever gap it finds. The non-aligned alloc
path (size_aligned == false, A == 1) collapses to a single phase since
strict_size == size.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Rik van Riel <riel@surriel.com>
---
 drivers/iommu/iova.c | 65 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 49 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 7787da8b2dad..4f3465d8ee16 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -210,18 +210,29 @@ iova_insert_rbtree(struct iova_domain *iovad, struct iova *iova,
 }
 
 /*
- * Search the augmented rbtree for the highest-addressed free gap of at least
- * @size pages, with the allocation fitting below @limit_pfn and at or above
- * @start_pfn. When @is_32bit, prune by the 32-bit-clamped subtree max so
- * that 32-bit-restricted allocations on a domain dominated by high-pfn
+ * Search the augmented rbtree for the highest-addressed free gap that fits
+ * @size pages with @align_mask alignment, below @limit_pfn and at or above
+ * @start_pfn.
+ *
+ * @prune_size is the threshold compared against the augmented subtree max:
+ *   - If @prune_size == @size, every subtree containing any size-fitting
+ *     gap is descended (lax search; can visit O(n) nodes when alignment or
+ *     limit_pfn rejects most candidates).
+ *   - If @prune_size == @size + alignment - 1, only subtrees containing a
+ *     gap big enough to GUARANTEE an aligned fit are descended (strict
+ *     search; O(log n) but may miss borderline-sized fortuitously aligned
+ *     gaps).
+ *
+ * When @is_32bit, prune by the 32-bit-clamped subtree max so that
+ * 32-bit-restricted allocations on a domain dominated by high-pfn
  * allocations stay O(log n) instead of degrading to O(n). Returns the node
  * whose gap_to_prev is used, or NULL.
  */
 static struct rb_node *
 __iova_search_free_gap(struct rb_node *node, unsigned long size,
-		       unsigned long limit_pfn, unsigned long start_pfn,
-		       unsigned long align_mask, bool is_32bit,
-		       unsigned long *new_pfn)
+		       unsigned long prune_size, unsigned long limit_pfn,
+		       unsigned long start_pfn, unsigned long align_mask,
+		       bool is_32bit, unsigned long *new_pfn)
 {
 	struct iova *iova;
 	struct rb_node *result;
@@ -233,11 +244,12 @@ __iova_search_free_gap(struct rb_node *node, unsigned long size,
 	iova = to_iova(node);
 	subtree_max = is_32bit ? iova->__subtree_max_gap32
 			       : iova->__subtree_max_gap;
-	if (subtree_max < size)
+	if (subtree_max < prune_size)
 		return NULL;
 
-	result = __iova_search_free_gap(node->rb_right, size, limit_pfn,
-					start_pfn, align_mask, is_32bit, new_pfn);
+	result = __iova_search_free_gap(node->rb_right, size, prune_size,
+					limit_pfn, start_pfn, align_mask,
+					is_32bit, new_pfn);
 	if (result)
 		return result;
 
@@ -257,8 +269,9 @@ __iova_search_free_gap(struct rb_node *node, unsigned long size,
 		}
 	}
 
-	return __iova_search_free_gap(node->rb_left, size, limit_pfn,
-				      start_pfn, align_mask, is_32bit, new_pfn);
+	return __iova_search_free_gap(node->rb_left, size, prune_size,
+				      limit_pfn, start_pfn, align_mask,
+				      is_32bit, new_pfn);
 }
 
 static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
@@ -268,11 +281,24 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 	unsigned long flags;
 	unsigned long new_pfn;
 	unsigned long align_mask = ~0UL;
+	unsigned long strict_size = size;
 	struct rb_node *gap_node;
 	bool is_32bit;
 
-	if (size_aligned)
-		align_mask <<= fls_long(size - 1);
+	if (size_aligned) {
+		unsigned long align_shift = fls_long(size - 1);
+
+		align_mask <<= align_shift;
+		/*
+		 * For an A-aligned allocation of S pages, a gap of size G is
+		 * guaranteed to contain a fitting aligned position iff
+		 * G >= S + A - 1. Use that as the strict pruning threshold for
+		 * a fast O(log n) first pass; if it fails, fall back to a
+		 * pruning threshold of just S to catch fortuitously-aligned
+		 * borderline gaps.
+		 */
+		strict_size = size + (1UL << align_shift) - 1;
+	}
 
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
 	is_32bit = limit_pfn <= iovad->dma_32bit_pfn;
@@ -280,8 +306,15 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 		goto iova32_full;
 
 	gap_node = __iova_search_free_gap(iovad->rbroot.rb_node, size,
-					  limit_pfn, iovad->start_pfn,
-					  align_mask, is_32bit, &new_pfn);
+					  strict_size, limit_pfn,
+					  iovad->start_pfn, align_mask,
+					  is_32bit, &new_pfn);
+	if (!gap_node && strict_size > size) {
+		gap_node = __iova_search_free_gap(iovad->rbroot.rb_node, size,
+						  size, limit_pfn,
+						  iovad->start_pfn, align_mask,
+						  is_32bit, &new_pfn);
+	}
 	if (!gap_node) {
 		if (is_32bit)
 			iovad->max32_alloc_size = size;
-- 
2.52.0

