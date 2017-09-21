From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v5 6/6] iommu/iova: Simplify cached node logic
Date: Thu, 21 Sep 2017 16:52:47 +0100
Message-ID: <748a2bbb8c7dee79f3faffe6b349d8cdc0743904.1506007392.git.robin.murphy@arm.com>
References: <cover.1506007392.git.robin.murphy@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1506007392.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, thunder.leizhen@huawei.com, nwatters@codeaurora.org, tomasz.nowicki@caviumnetworks.com, dwoods@mellanox.com, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

The logic of __get_cached_rbnode() is a little obtuse, but then
__get_prev_node_of_cached_rbnode_or_last_node_and_update_limit_pfn()
wouldn't exactly roll off the tongue...

Now that we have the invariant that there is always a valid node to
start searching downwards from, everything gets a bit easier to follow
if we simplify that function to do what it says on the tin and return
the cached node (or anchor node as appropriate) directly. In turn, we
can then deduplicate the rb_prev() and limit_pfn logic into the main
loop itself, further reduce the amount of code under the lock, and
generally make the inner workings a bit less subtle.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v5: Make cached nodes always valid

 drivers/iommu/iova.c | 51 +++++++++++++++++----------------------------------
 1 file changed, 17 insertions(+), 34 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 9e04c1f3e740..7b7363518733 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -51,8 +51,8 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 
 	spin_lock_init(&iovad->iova_rbtree_lock);
 	iovad->rbroot = RB_ROOT;
-	iovad->cached_node = NULL;
-	iovad->cached32_node = NULL;
+	iovad->cached_node = &iovad->anchor.node;
+	iovad->cached32_node = &iovad->anchor.node;
 	iovad->granule = granule;
 	iovad->start_pfn = start_pfn;
 	iovad->dma_32bit_pfn = 1UL << (32 - iova_shift(iovad));
@@ -115,22 +115,12 @@ int init_iova_flush_queue(struct iova_domain *iovad,
 EXPORT_SYMBOL_GPL(init_iova_flush_queue);
 
 static struct rb_node *
-__get_cached_rbnode(struct iova_domain *iovad, unsigned long *limit_pfn)
+__get_cached_rbnode(struct iova_domain *iovad, unsigned long limit_pfn)
 {
-	struct rb_node *cached_node = NULL;
-	struct iova *curr_iova;
+	if (limit_pfn <= iovad->dma_32bit_pfn)
+		return iovad->cached32_node;
 
-	if (*limit_pfn <= iovad->dma_32bit_pfn)
-		cached_node = iovad->cached32_node;
-	if (!cached_node)
-		cached_node = iovad->cached_node;
-	if (!cached_node)
-		return rb_prev(&iovad->anchor.node);
-
-	curr_iova = rb_entry(cached_node, struct iova, node);
-	*limit_pfn = min(*limit_pfn, curr_iova->pfn_lo);
-
-	return rb_prev(cached_node);
+	return iovad->cached_node;
 }
 
 static void
@@ -149,11 +139,11 @@ __cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free)
 
 	cached_iova = rb_entry(iovad->cached32_node, struct iova, node);
 	if (free->pfn_hi < iovad->dma_32bit_pfn &&
-	    iovad->cached32_node && free->pfn_lo >= cached_iova->pfn_lo)
+	    free->pfn_lo >= cached_iova->pfn_lo)
 		iovad->cached32_node = rb_next(&free->node);
 
 	cached_iova = rb_entry(iovad->cached_node, struct iova, node);
-	if (iovad->cached_node && free->pfn_lo >= cached_iova->pfn_lo)
+	if (free->pfn_lo >= cached_iova->pfn_lo)
 		iovad->cached_node = rb_next(&free->node);
 }
 
@@ -189,7 +179,8 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 		unsigned long size, unsigned long limit_pfn,
 			struct iova *new, bool size_aligned)
 {
-	struct rb_node *prev, *curr = NULL;
+	struct rb_node *curr, *prev;
+	struct iova *curr_iova;
 	unsigned long flags;
 	unsigned long new_pfn;
 	unsigned long align_mask = ~0UL;
@@ -199,24 +190,16 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 
 	/* Walk the tree backwards */
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
-	curr = __get_cached_rbnode(iovad, &limit_pfn);
-	prev = curr;
-	while (curr) {
-		struct iova *curr_iova = rb_entry(curr, struct iova, node);
-
-		if (limit_pfn <= curr_iova->pfn_lo)
-			goto move_left;
-
-		if (((limit_pfn - size) & align_mask) > curr_iova->pfn_hi)
-			break;	/* found a free slot */
-
-		limit_pfn = curr_iova->pfn_lo;
-move_left:
+	curr = __get_cached_rbnode(iovad, limit_pfn);
+	curr_iova = rb_entry(curr, struct iova, node);
+	do {
+		limit_pfn = min(limit_pfn, curr_iova->pfn_lo);
+		new_pfn = (limit_pfn - size) & align_mask;
 		prev = curr;
 		curr = rb_prev(curr);
-	}
+		curr_iova = rb_entry(curr, struct iova, node);
+	} while (curr && new_pfn <= curr_iova->pfn_hi);
 
-	new_pfn = (limit_pfn - size) & align_mask;
 	if (limit_pfn < size || new_pfn < iovad->start_pfn) {
 		spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 		return -ENOMEM;
-- 
2.13.4.dirty
