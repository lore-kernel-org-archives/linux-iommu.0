From: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v3 4/6] iommu/iova: to optimize the allocation performance of
	dma64
Date: Thu, 18 May 2017 15:59:55 +0800
Message-ID: <1495094397-9132-5-git-send-email-thunder.leizhen@huawei.com>
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

Currently we always search free iova space for dma64 begin at the last
node of iovad rb-tree. In the worst case, there maybe too many nodes exist
at the tail, so that we should traverse many times for the first loop in
__alloc_and_insert_iova_range. As we traced, more than 10K times for the
case of iperf.

__alloc_and_insert_iova_range:
	......
	curr = __get_cached_rbnode(iovad, &limit_pfn);
		//--> return rb_last(&iovad->rbroot);
	while (curr) {
		......
		curr = rb_prev(curr);
	}

So add cached64_node to take the same effect as cached32_node, and add
the start_pfn boundary of dma64, to prevent a iova cross both dma32 and
dma64 area.
	|-------------------|------------------------------|
	|<--cached32_node-->|<--------cached64_node------->|
	|                   |
    start_pfn         dma_32bit_pfn + 1

Signed-off-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/iova.c | 46 +++++++++++++++++++++++++++-------------------
 include/linux/iova.h |  5 +++--
 2 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 1b8e136..711b10a 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -37,10 +37,15 @@ insert_iova_boundary(struct iova_domain *iovad)
 {
 	struct iova *iova;
 	unsigned long start_pfn_32bit = iovad->start_pfn;
+	unsigned long start_pfn_64bit = iovad->dma_32bit_pfn + 1;
 
 	iova = reserve_iova(iovad, start_pfn_32bit, start_pfn_32bit);
 	BUG_ON(!iova);
 	iovad->cached32_node = &iova->node;
+
+	iova = reserve_iova(iovad, start_pfn_64bit, start_pfn_64bit);
+	BUG_ON(!iova);
+	iovad->cached64_node = &iova->node;
 }
 
 void
@@ -62,8 +67,8 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	init_iova_rcaches(iovad);
 
 	/*
-	 * Insert boundary nodes for dma32. So cached32_node can not be NULL in
-	 * future.
+	 * Insert boundary nodes for dma32 and dma64. So cached32_node and
+	 * cached64_node can not be NULL in future.
 	 */
 	insert_iova_boundary(iovad);
 }
@@ -75,10 +80,10 @@ __get_cached_rbnode(struct iova_domain *iovad, unsigned long *limit_pfn)
 	struct rb_node *cached_node;
 	struct rb_node *next_node;
 
-	if (*limit_pfn > iovad->dma_32bit_pfn)
-		return rb_last(&iovad->rbroot);
-	else
+	if (*limit_pfn <= iovad->dma_32bit_pfn)
 		cached_node = iovad->cached32_node;
+	else
+		cached_node = iovad->cached64_node;
 
 	next_node = rb_next(cached_node);
 	if (next_node) {
@@ -94,29 +99,32 @@ static void
 __cached_rbnode_insert_update(struct iova_domain *iovad, struct iova *new)
 {
 	struct iova *cached_iova;
+	struct rb_node **cached_node;
 
-	if (new->pfn_hi > iovad->dma_32bit_pfn)
-		return;
+	if (new->pfn_hi <= iovad->dma_32bit_pfn)
+		cached_node = &iovad->cached32_node;
+	else
+		cached_node = &iovad->cached64_node;
 
-	cached_iova = rb_entry(iovad->cached32_node, struct iova, node);
+	cached_iova = rb_entry(*cached_node, struct iova, node);
 	if (new->pfn_lo <= cached_iova->pfn_lo)
-		iovad->cached32_node = rb_prev(&new->node);
+		*cached_node = rb_prev(&new->node);
 }
 
 static void
 __cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free)
 {
 	struct iova *cached_iova;
-	struct rb_node *curr;
+	struct rb_node **cached_node;
 
-	curr = iovad->cached32_node;
-	cached_iova = rb_entry(curr, struct iova, node);
+	if (free->pfn_hi <= iovad->dma_32bit_pfn)
+		cached_node = &iovad->cached32_node;
+	else
+		cached_node = &iovad->cached64_node;
 
-	if (free->pfn_lo >= cached_iova->pfn_lo) {
-		/* only cache if it's below 32bit pfn */
-		if (free->pfn_hi <= iovad->dma_32bit_pfn)
-			iovad->cached32_node = rb_prev(&free->node);
-	}
+	cached_iova = rb_entry(*cached_node, struct iova, node);
+	if (free->pfn_lo >= cached_iova->pfn_lo)
+		*cached_node = rb_prev(&free->node);
 }
 
 /* Insert the iova into domain rbtree by holding writer lock */
@@ -262,7 +270,7 @@ EXPORT_SYMBOL_GPL(iova_cache_put);
  * alloc_iova - allocates an iova
  * @iovad: - iova domain in question
  * @size: - size of page frames to allocate
- * @limit_pfn: - max limit address
+ * @limit_pfn: - max limit address(included)
  * @size_aligned: - set if size_aligned address range is required
  * This function allocates an iova in the range iovad->start_pfn to limit_pfn,
  * searching top-down from limit_pfn to iovad->start_pfn. If the size_aligned
@@ -381,7 +389,7 @@ EXPORT_SYMBOL_GPL(free_iova);
  * alloc_iova_fast - allocates an iova from rcache
  * @iovad: - iova domain in question
  * @size: - size of page frames to allocate
- * @limit_pfn: - max limit address
+ * @limit_pfn: - max limit address(included)
  * This function tries to satisfy an iova allocation from the rcache,
  * and falls back to regular allocation on failure.
 */
diff --git a/include/linux/iova.h b/include/linux/iova.h
index e0a892a..2d34112 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -40,10 +40,11 @@ struct iova_rcache {
 struct iova_domain {
 	spinlock_t	iova_rbtree_lock; /* Lock to protect update of rbtree */
 	struct rb_root	rbroot;		/* iova domain rbtree root */
-	struct rb_node	*cached32_node; /* Save last alloced node */
+	struct rb_node	*cached32_node; /* Save last alloced node, 32bits */
+	struct rb_node	*cached64_node; /* Save last alloced node, 64bits */
 	unsigned long	granule;	/* pfn granularity for this domain */
 	unsigned long	start_pfn;	/* Lower limit for this domain */
-	unsigned long	dma_32bit_pfn;
+	unsigned long	dma_32bit_pfn;	/* max dma32 limit address(included) */
 	struct iova_rcache rcaches[IOVA_RANGE_CACHE_MAX_SIZE];	/* IOVA range caches */
 };
 
-- 
2.5.0
