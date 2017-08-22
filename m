From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v3 3/4] iommu/iova: Extend rbtree node caching
Date: Tue, 22 Aug 2017 16:17:44 +0100
Message-ID: <1d9ddb73def3b6f7439d0e1e5f448e7c68253222.1503412074.git.robin.murphy@arm.com>
References: <cover.1503412074.git.robin.murphy@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1503412074.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, thunder.leizhen@huawei.com, ard.biesheuvel@linaro.org, nwatters@codeaurora.org, ray.jui@broadcom.com
List-Id: iommu@lists.linux-foundation.org

The cached node mechanism provides a significant performance benefit for
allocations using a 32-bit DMA mask, but in the case of non-PCI devices
or where the 32-bit space is full, the loss of this benefit can be
significant - on large systems there can be many thousands of entries in
the tree, such that traversing to the end then walking all the way down
to find free space every time becomes increasingly awful.

Maintain a similar cached node for the whole IOVA space as a superset of
the 32-bit space so that performance can remain much more consistent.

Inspired by work by Zhen Lei <thunder.leizhen@huawei.com>.

Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v3: Fix potential null dereference on deletion 

 drivers/iommu/iova.c | 61 ++++++++++++++++++++++++++--------------------------
 include/linux/iova.h |  3 ++-
 2 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index d094d1ca8f23..b208f656f6a4 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -46,6 +46,7 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 
 	spin_lock_init(&iovad->iova_rbtree_lock);
 	iovad->rbroot = RB_ROOT;
+	iovad->cached_node = NULL;
 	iovad->cached32_node = NULL;
 	iovad->granule = granule;
 	iovad->start_pfn = start_pfn;
@@ -57,48 +58,48 @@ EXPORT_SYMBOL_GPL(init_iova_domain);
 static struct rb_node *
 __get_cached_rbnode(struct iova_domain *iovad, unsigned long *limit_pfn)
 {
-	if ((*limit_pfn > iovad->dma_32bit_pfn) ||
-		(iovad->cached32_node == NULL))
+	struct rb_node *cached_node = NULL;
+	struct iova *curr_iova;
+
+	if (*limit_pfn <= iovad->dma_32bit_pfn)
+		cached_node = iovad->cached32_node;
+	if (!cached_node)
+		cached_node = iovad->cached_node;
+	if (!cached_node)
 		return rb_last(&iovad->rbroot);
-	else {
-		struct rb_node *prev_node = rb_prev(iovad->cached32_node);
-		struct iova *curr_iova =
-			rb_entry(iovad->cached32_node, struct iova, node);
-		*limit_pfn = curr_iova->pfn_lo;
-		return prev_node;
-	}
+
+	curr_iova = rb_entry(cached_node, struct iova, node);
+	*limit_pfn = min(*limit_pfn, curr_iova->pfn_lo);
+
+	return rb_prev(cached_node);
 }
 
 static void
-__cached_rbnode_insert_update(struct iova_domain *iovad,
-	unsigned long limit_pfn, struct iova *new)
+__cached_rbnode_insert_update(struct iova_domain *iovad, struct iova *new)
 {
-	if (limit_pfn != iovad->dma_32bit_pfn)
-		return;
-	iovad->cached32_node = &new->node;
+	if (new->pfn_lo > iovad->dma_32bit_pfn)
+		iovad->cached_node = &new->node;
+	else
+		iovad->cached32_node = &new->node;
 }
 
 static void
 __cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free)
 {
 	struct iova *cached_iova;
-	struct rb_node *curr;
+	struct rb_node **curr = NULL;
 
-	if (!iovad->cached32_node)
+	if (free->pfn_hi < iovad->dma_32bit_pfn)
+		curr = &iovad->cached32_node;
+	if (!curr)
+		curr = &iovad->cached_node;
+
+	if (!*curr)
 		return;
-	curr = iovad->cached32_node;
-	cached_iova = rb_entry(curr, struct iova, node);
+	cached_iova = rb_entry(*curr, struct iova, node);
 
-	if (free->pfn_lo >= cached_iova->pfn_lo) {
-		struct rb_node *node = rb_next(&free->node);
-		struct iova *iova = rb_entry(node, struct iova, node);
-
-		/* only cache if it's below 32bit pfn */
-		if (node && iova->pfn_lo < iovad->dma_32bit_pfn)
-			iovad->cached32_node = node;
-		else
-			iovad->cached32_node = NULL;
-	}
+	if (free->pfn_lo >= cached_iova->pfn_lo)
+		*curr = rb_next(&free->node);
 }
 
 /* Insert the iova into domain rbtree by holding writer lock */
@@ -135,7 +136,6 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 {
 	struct rb_node *prev, *curr = NULL;
 	unsigned long flags;
-	unsigned long saved_pfn;
 	unsigned long align_mask = ~0UL;
 
 	if (size_aligned)
@@ -143,7 +143,6 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 
 	/* Walk the tree backwards */
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
-	saved_pfn = limit_pfn;
 	curr = __get_cached_rbnode(iovad, &limit_pfn);
 	prev = curr;
 	while (curr) {
@@ -173,7 +172,7 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 
 	/* If we have 'prev', it's a valid place to start the insertion. */
 	iova_insert_rbtree(&iovad->rbroot, new, prev);
-	__cached_rbnode_insert_update(iovad, saved_pfn, new);
+	__cached_rbnode_insert_update(iovad, new);
 
 	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 
diff --git a/include/linux/iova.h b/include/linux/iova.h
index e0a892ae45c0..0bb8df43b393 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -40,7 +40,8 @@ struct iova_rcache {
 struct iova_domain {
 	spinlock_t	iova_rbtree_lock; /* Lock to protect update of rbtree */
 	struct rb_root	rbroot;		/* iova domain rbtree root */
-	struct rb_node	*cached32_node; /* Save last alloced node */
+	struct rb_node	*cached_node;	/* Save last alloced node */
+	struct rb_node	*cached32_node; /* Save last 32-bit alloced node */
 	unsigned long	granule;	/* pfn granularity for this domain */
 	unsigned long	start_pfn;	/* Lower limit for this domain */
 	unsigned long	dma_32bit_pfn;
-- 
2.13.4.dirty
