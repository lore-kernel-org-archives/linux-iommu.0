From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v3 3/6] iommu/iova: adjust __cached_rbnode_insert_update
Date: Thu, 18 May 2017 15:59:54 +0800
Message-ID: <1495094397-9132-4-git-send-email-thunder.leizhen@huawei.com>
References: <1495094397-9132-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1495094397-9132-1-git-send-email-thunder.leizhen@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, iommu <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>, Sudeep Dutt <sudeep.dutt@intel.com>, Ashutosh Dixit <ashutosh.dixit@intel.com>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Zefan Li <lizefan@huawei.com>, Xinwei Hu <huxinwei@huawei.com>, Tianhong Ding <dingtianhong@huawei.com>, Hanjun Guo <guohanjun@huawei.com>, Zhen Lei <thunder.leizhen@huawei.com>
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

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/iova.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index d0c19ec..1b8e136 100644
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
@@ -159,12 +163,10 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 {
 	struct rb_node *prev, *curr;
 	unsigned long flags;
-	unsigned long saved_pfn;
 	unsigned int pad_size = 0;
 
 	/* Walk the tree backwards */
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
-	saved_pfn = limit_pfn;
 	curr = __get_cached_rbnode(iovad, &limit_pfn);
 	prev = curr;
 	while (curr) {
@@ -198,11 +200,10 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 
 	/* If we have 'prev', it's a valid place to start the insertion. */
 	iova_insert_rbtree(&iovad->rbroot, new, prev);
-	__cached_rbnode_insert_update(iovad, saved_pfn, new);
+	__cached_rbnode_insert_update(iovad, new);
 
 	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 
-
 	return 0;
 }
 
-- 
2.5.0
