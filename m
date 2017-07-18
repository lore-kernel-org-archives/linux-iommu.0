From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 2/4] iommu/iova: Optimise the padding calculation
Date: Tue, 18 Jul 2017 17:57:20 +0100
Message-ID: <eb5f8875f6429dd5826996576b7b506213ffb959.1500396007.git.robin.murphy@arm.com>
References: <cover.1500396007.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1500396007.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, ray.jui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>

The mask for calculating the padding size doesn't change, so there's no
need to recalculate it every loop iteration. Furthermore, Once we've
done that, it becomes clear that we don't actually need to calculate a
padding size at all - by flipping the arithmetic around, we can just
combine the upper limit, size, and mask directly to check against the
lower limit.

For an arm64 build, this alone knocks 16% off the size of the entire
alloc_iova() function!

Signed-off-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
[rm: simplified more of the arithmetic, rewrote commit message]
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/iova.c | 40 ++++++++++++++--------------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 8f7552dc4e04..d094d1ca8f23 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -129,16 +129,6 @@ iova_insert_rbtree(struct rb_root *root, struct iova *iova,
 	rb_insert_color(&iova->node, root);
 }
 
-/*
- * Computes the padding size required, to make the start address
- * naturally aligned on the power-of-two order of its size
- */
-static unsigned int
-iova_get_pad_size(unsigned int size, unsigned int limit_pfn)
-{
-	return (limit_pfn - size) & (__roundup_pow_of_two(size) - 1);
-}
-
 static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 		unsigned long size, unsigned long limit_pfn,
 			struct iova *new, bool size_aligned)
@@ -146,7 +136,10 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 	struct rb_node *prev, *curr = NULL;
 	unsigned long flags;
 	unsigned long saved_pfn;
-	unsigned int pad_size = 0;
+	unsigned long align_mask = ~0UL;
+
+	if (size_aligned)
+		align_mask <<= __fls(size);
 
 	/* Walk the tree backwards */
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
@@ -156,31 +149,26 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 	while (curr) {
 		struct iova *curr_iova = rb_entry(curr, struct iova, node);
 
-		if (limit_pfn <= curr_iova->pfn_lo) {
+		if (limit_pfn <= curr_iova->pfn_lo)
 			goto move_left;
-		} else if (limit_pfn > curr_iova->pfn_hi) {
-			if (size_aligned)
-				pad_size = iova_get_pad_size(size, limit_pfn);
-			if ((curr_iova->pfn_hi + size + pad_size) < limit_pfn)
-				break;	/* found a free slot */
-		}
+
+		if (((limit_pfn - size) & align_mask) > curr_iova->pfn_hi)
+			break;	/* found a free slot */
+
 		limit_pfn = curr_iova->pfn_lo;
 move_left:
 		prev = curr;
 		curr = rb_prev(curr);
 	}
 
-	if (!curr) {
-		if (size_aligned)
-			pad_size = iova_get_pad_size(size, limit_pfn);
-		if ((iovad->start_pfn + size + pad_size) > limit_pfn) {
-			spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
-			return -ENOMEM;
-		}
+	if (limit_pfn < size ||
+	    (!curr && ((limit_pfn - size) & align_mask) < iovad->start_pfn)) {
+		spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
+		return -ENOMEM;
 	}
 
 	/* pfn_lo will point to size aligned address if size_aligned is set */
-	new->pfn_lo = limit_pfn - (size + pad_size);
+	new->pfn_lo = (limit_pfn - size) & align_mask;
 	new->pfn_hi = new->pfn_lo + size - 1;
 
 	/* If we have 'prev', it's a valid place to start the insertion. */
-- 
2.12.2.dirty
