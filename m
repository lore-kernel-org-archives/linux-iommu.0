From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 6/7] iommu/iova: move the caculation of pad mask out of loop
Date: Fri, 31 Mar 2017 11:24:24 +0800
Message-ID: <1490930665-9696-7-git-send-email-thunder.leizhen@huawei.com>
References: <1490930665-9696-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1490930665-9696-1-git-send-email-thunder.leizhen@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, iommu <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>, Sudeep Dutt <sudeep.dutt@intel.com>, Ashutosh Dixit <ashutosh.dixit@intel.com>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Zefan Li <lizefan@huawei.com>, Xinwei Hu <huxinwei@huawei.com>, Tianhong Ding <dingtianhong@huawei.com>, Hanjun Guo <guohanjun@huawei.com>, Zhen Lei <thunder.leizhen@huawei.com>
List-Id: iommu@lists.linux-foundation.org

I'm not sure whether the compiler can optimize it, but move it out will
be better. At least, it does not require lock protection.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/iova.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 23abe84..68754e4 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -127,23 +127,16 @@ __cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free)
 		*cached_node = rb_prev(&free->node);
 }
 
-/*
- * Computes the padding size required, to make the start address
- * naturally aligned on the power-of-two order of its size
- */
-static unsigned long
-iova_get_pad_size(unsigned long size, unsigned long limit_pfn)
-{
-	return (limit_pfn + 1 - size) & (__roundup_pow_of_two(size) - 1);
-}
-
 static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 		unsigned long size, unsigned long limit_pfn,
 			struct iova *new, bool size_aligned)
 {
 	struct rb_node *prev, *curr;
 	unsigned long flags;
-	unsigned long pad_size = 0;
+	unsigned long pad_mask, pad_size = 0;
+
+	if (size_aligned)
+		pad_mask = __roundup_pow_of_two(size) - 1;
 
 	/* Walk the tree backwards */
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
@@ -157,8 +150,13 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 		else if (limit_pfn < curr_iova->pfn_hi)
 			goto adjust_limit_pfn;
 		else {
+			/*
+			 * Computes the padding size required, to make the start
+			 * address naturally aligned on the power-of-two order
+			 * of its size
+			 */
 			if (size_aligned)
-				pad_size = iova_get_pad_size(size, limit_pfn);
+				pad_size = (limit_pfn + 1 - size) & pad_mask;
 			if ((curr_iova->pfn_hi + size + pad_size) <= limit_pfn)
 				break;	/* found a free slot */
 		}
-- 
2.5.0
