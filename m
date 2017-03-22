From: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 6/7] iommu/iova: move the caculation of pad mask out of loop
Date: Wed, 22 Mar 2017 14:27:46 +0800
Message-ID: <1490164067-12552-7-git-send-email-thunder.leizhen@huawei.com>
References: <1490164067-12552-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1490164067-12552-1-git-send-email-thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
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

I'm not sure whether the compiler can optimize it, but move it out will
be better. At least, it does not require lock protection.

Signed-off-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
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
