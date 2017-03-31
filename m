From: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 4/7] iommu/iova: adjust __cached_rbnode_insert_update
Date: Fri, 31 Mar 2017 11:24:22 +0800
Message-ID: <1490930665-9696-5-git-send-email-thunder.leizhen@huawei.com>
References: <1490930665-9696-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1490930665-9696-1-git-send-email-thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
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

For case 2 and 3, adjust cached32_node to the new place, case 1 keep no
change.

For example:
case1: (the right part was allocated)
	|------------------------------|
	|<-----free---->|<--new_iova-->|
	|
	|
   cached32_node

case2: (all was allocated)
	|------------------------------|
	|<---------new_iova----------->|
	|
	|
   cached32_node

case3:
	|-----------------------|......|---------|
        |..free..|<--new_iova-->|<not enough iova space>
        |                              |
        |                              |
   cached32_node(new)             cached32_node(old)

Signed-off-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/iova.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index b5a148e..87a9332 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -91,12 +91,16 @@ __get_cached_rbnode(struct iova_domain *iovad, unsigned long *limit_pfn)
 }
 
 static void
-__cached_rbnode_insert_update(struct iova_domain *iovad,
-	unsigned long limit_pfn, struct iova *new)
+__cached_rbnode_insert_update(struct iova_domain *iovad, struct iova *new)
 {
-	if (limit_pfn != iovad->dma_32bit_pfn)
+	struct iova *cached_iova;
+
+	if (new->pfn_hi > iovad->dma_32bit_pfn)
 		return;
-	iovad->cached32_node = &new->node;
+
+	cached_iova = rb_entry(iovad->cached32_node, struct iova, node);
+	if (new->pfn_lo <= cached_iova->pfn_lo)
+		iovad->cached32_node = rb_prev(&new->node);
 }
 
 static void
@@ -131,12 +135,10 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 {
 	struct rb_node *prev, *curr;
 	unsigned long flags;
-	unsigned long saved_pfn;
 	unsigned long pad_size = 0;
 
 	/* Walk the tree backwards */
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
-	saved_pfn = limit_pfn;
 	curr = __get_cached_rbnode(iovad, &limit_pfn);
 	prev = curr;
 	while (curr) {
@@ -197,11 +199,10 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 		rb_link_node(&new->node, parent, entry);
 		rb_insert_color(&new->node, &iovad->rbroot);
 	}
-	__cached_rbnode_insert_update(iovad, saved_pfn, new);
+	__cached_rbnode_insert_update(iovad, new);
 
 	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 
-
 	return 0;
 }
 
-- 
2.5.0
