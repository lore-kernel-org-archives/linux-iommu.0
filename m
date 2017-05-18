From: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v3 2/6] iommu/iova: insert start_pfn boundary of dma32
Date: Thu, 18 May 2017 15:59:53 +0800
Message-ID: <1495094397-9132-3-git-send-email-thunder.leizhen@huawei.com>
References: <1495094397-9132-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1495094397-9132-1-git-send-email-thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Sudeep Dutt <sudeep.dutt-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ashutosh Dixit <ashutosh.dixit-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Xinwei Hu <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Zefan Li <lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Tianhong Ding <dingtianhong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Reserve the first granule size memory(start at start_pfn) as boundary
iova, to make sure that iovad->cached32_node can not be NULL in future.
Meanwhile, changed the assignment of iovad->cached32_node from rb_next to
rb_prev of &free->node in function __cached_rbnode_delete_update.

Signed-off-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/iova.c | 63 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 333a9cc..d0c19ec 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -32,6 +32,17 @@ static unsigned long iova_rcache_get(struct iova_domain *iovad,
 static void init_iova_rcaches(struct iova_domain *iovad);
 static void free_iova_rcaches(struct iova_domain *iovad);
 
+static void
+insert_iova_boundary(struct iova_domain *iovad)
+{
+	struct iova *iova;
+	unsigned long start_pfn_32bit = iovad->start_pfn;
+
+	iova = reserve_iova(iovad, start_pfn_32bit, start_pfn_32bit);
+	BUG_ON(!iova);
+	iovad->cached32_node = &iova->node;
+}
+
 void
 init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	unsigned long start_pfn, unsigned long pfn_32bit)
@@ -45,27 +56,38 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 
 	spin_lock_init(&iovad->iova_rbtree_lock);
 	iovad->rbroot = RB_ROOT;
-	iovad->cached32_node = NULL;
 	iovad->granule = granule;
 	iovad->start_pfn = start_pfn;
 	iovad->dma_32bit_pfn = pfn_32bit;
 	init_iova_rcaches(iovad);
+
+	/*
+	 * Insert boundary nodes for dma32. So cached32_node can not be NULL in
+	 * future.
+	 */
+	insert_iova_boundary(iovad);
 }
 EXPORT_SYMBOL_GPL(init_iova_domain);
 
 static struct rb_node *
 __get_cached_rbnode(struct iova_domain *iovad, unsigned long *limit_pfn)
 {
-	if ((*limit_pfn > iovad->dma_32bit_pfn) ||
-		(iovad->cached32_node == NULL))
+	struct rb_node *cached_node;
+	struct rb_node *next_node;
+
+	if (*limit_pfn > iovad->dma_32bit_pfn)
 		return rb_last(&iovad->rbroot);
-	else {
-		struct rb_node *prev_node = rb_prev(iovad->cached32_node);
-		struct iova *curr_iova =
-			rb_entry(iovad->cached32_node, struct iova, node);
-		*limit_pfn = curr_iova->pfn_lo - 1;
-		return prev_node;
+	else
+		cached_node = iovad->cached32_node;
+
+	next_node = rb_next(cached_node);
+	if (next_node) {
+		struct iova *next_iova = rb_entry(next_node, struct iova, node);
+
+		*limit_pfn = min(*limit_pfn, next_iova->pfn_lo - 1);
 	}
+
+	return cached_node;
 }
 
 static void
@@ -83,20 +105,13 @@ __cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free)
 	struct iova *cached_iova;
 	struct rb_node *curr;
 
-	if (!iovad->cached32_node)
-		return;
 	curr = iovad->cached32_node;
 	cached_iova = rb_entry(curr, struct iova, node);
 
 	if (free->pfn_lo >= cached_iova->pfn_lo) {
-		struct rb_node *node = rb_next(&free->node);
-		struct iova *iova = rb_entry(node, struct iova, node);
-
 		/* only cache if it's below 32bit pfn */
-		if (node && iova->pfn_lo < iovad->dma_32bit_pfn)
-			iovad->cached32_node = node;
-		else
-			iovad->cached32_node = NULL;
+		if (free->pfn_hi <= iovad->dma_32bit_pfn)
+			iovad->cached32_node = rb_prev(&free->node);
 	}
 }
 
@@ -142,7 +157,7 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 		unsigned long size, unsigned long limit_pfn,
 			struct iova *new, bool size_aligned)
 {
-	struct rb_node *prev, *curr = NULL;
+	struct rb_node *prev, *curr;
 	unsigned long flags;
 	unsigned long saved_pfn;
 	unsigned int pad_size = 0;
@@ -172,13 +187,9 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 		curr = rb_prev(curr);
 	}
 
-	if (!curr) {
-		if (size_aligned)
-			pad_size = iova_get_pad_size(size, limit_pfn);
-		if ((iovad->start_pfn + size + pad_size) > limit_pfn) {
-			spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
-			return -ENOMEM;
-		}
+	if (unlikely(!curr)) {
+		spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
+		return -ENOMEM;
 	}
 
 	/* pfn_lo will point to size aligned address if size_aligned is set */
-- 
2.5.0
