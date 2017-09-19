From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v4 4/6] iommu/iova: Simplify cached node logic
Date: Tue, 19 Sep 2017 17:31:55 +0100
Message-ID: <54b408eb56aa02d66468ec39026632e065459406.1505829018.git.robin.murphy@arm.com>
References: <cover.1505829018.git.robin.murphy@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1505829018.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, thunder.leizhen@huawei.com, nwatters@codeaurora.org, tomasz.nowicki@caviumnetworks.com, linux-kernel@vger.kernel.org
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

v4: New

 drivers/iommu/iova.c | 42 ++++++++++++++----------------------------
 1 file changed, 14 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 03b677afb109..c93a6c46bcb1 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -114,18 +114,12 @@ int init_iova_flush_queue(struct iova_domain *iovad,
 EXPORT_SYMBOL_GPL(init_iova_flush_queue);
 
 static struct rb_node *
-__get_cached_rbnode(struct iova_domain *iovad, unsigned long *limit_pfn)
+__get_cached_rbnode(struct iova_domain *iovad, unsigned long limit_pfn)
 {
-	if ((*limit_pfn > iovad->dma_32bit_pfn) ||
-		(iovad->cached32_node == NULL))
-		return rb_prev(&iovad->anchor.node);
-	else {
-		struct rb_node *prev_node = rb_prev(iovad->cached32_node);
-		struct iova *curr_iova =
-			rb_entry(iovad->cached32_node, struct iova, node);
-		*limit_pfn = curr_iova->pfn_lo;
-		return prev_node;
-	}
+	if (limit_pfn <= iovad->dma_32bit_pfn && iovad->cached32_node)
+		return iovad->cached32_node;
+
+	return &iovad->anchor.node;
 }
 
 static void
@@ -192,7 +186,8 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 		unsigned long size, unsigned long limit_pfn,
 			struct iova *new, bool size_aligned)
 {
-	struct rb_node *prev, *curr = NULL;
+	struct rb_node *curr, *prev;
+	struct iova *curr_iova;
 	unsigned long flags;
 	unsigned long saved_pfn, new_pfn;
 	unsigned long align_mask = ~0UL;
@@ -203,29 +198,20 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 	/* Walk the tree backwards */
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
 	saved_pfn = limit_pfn;
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
 	}
-
 	/* pfn_lo will point to size aligned address if size_aligned is set */
 	new->pfn_lo = new_pfn;
 	new->pfn_hi = new->pfn_lo + size - 1;
-- 
2.13.4.dirty
