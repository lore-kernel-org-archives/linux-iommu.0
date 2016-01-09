From: Shaohua Li <shli-b10kYP2dOMg@public.gmane.org>
Subject: [PATCH V2 2/4] iommu: free_iova doesn't need lock twice
Date: Fri, 8 Jan 2016 16:44:47 -0800
Message-ID: <8e2da5b4b78d77ea262e0b953432105403585879.1452297604.git.shli@fb.com>
References: <cover.1452297604.git.shli@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1452297604.git.shli-b10kYP2dOMg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Kernel-team-b10kYP2dOMg@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

cleanup the code a bit. free_iova doesn't need lock twice.

Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Shaohua Li <shli-b10kYP2dOMg@public.gmane.org>
---
 drivers/iommu/iova.c | 62 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 5c86c5c..bb8a328 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -362,35 +362,17 @@ alloc_iova(struct iova_domain *iovad, unsigned long size,
 }
 EXPORT_SYMBOL_GPL(alloc_iova);
 
-/**
- * find_iova - find's an iova for a given pfn
- * @iovad: - iova domain in question.
- * @pfn: - page frame number
- * This function finds and returns an iova belonging to the
- * given doamin which matches the given pfn.
- */
-struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn)
+static struct iova *__find_iova(struct iova_domain *iovad, unsigned long pfn)
 {
-	unsigned long flags;
 	struct rb_node *node;
 
-	/* Take the lock so that no other thread is manipulating the rbtree */
-	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
 	node = iovad->rbroot.rb_node;
 	while (node) {
 		struct iova *iova = container_of(node, struct iova, node);
 
 		/* If pfn falls within iova's range, return iova */
-		if ((pfn >= iova->pfn_lo) && (pfn <= iova->pfn_hi)) {
-			spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
-			/* We are not holding the lock while this iova
-			 * is referenced by the caller as the same thread
-			 * which called this function also calls __free_iova()
-			 * and it is by design that only one thread can possibly
-			 * reference a particular iova and hence no conflict.
-			 */
+		if ((pfn >= iova->pfn_lo) && (pfn <= iova->pfn_hi))
 			return iova;
-		}
 
 		if (pfn < iova->pfn_lo)
 			node = node->rb_left;
@@ -398,9 +380,33 @@ struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn)
 			node = node->rb_right;
 	}
 
-	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 	return NULL;
 }
+
+/**
+ * find_iova - find's an iova for a given pfn
+ * @iovad: - iova domain in question.
+ * @pfn: - page frame number
+ * This function finds and returns an iova belonging to the
+ * given doamin which matches the given pfn.
+ */
+struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn)
+{
+	unsigned long flags;
+	struct iova *iova;
+
+	/* Take the lock so that no other thread is manipulating the rbtree */
+	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
+	iova = __find_iova(iovad, pfn);
+	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
+	/* We are not holding the lock while this iova
+	 * is referenced by the caller as the same thread
+	 * which called this function also calls __free_iova()
+	 * and it is by design that only one thread can possibly
+	 * reference a particular iova and hence no conflict.
+	 */
+	return iova;
+}
 EXPORT_SYMBOL_GPL(find_iova);
 
 /**
@@ -432,11 +438,17 @@ EXPORT_SYMBOL_GPL(__free_iova);
 void
 free_iova(struct iova_domain *iovad, unsigned long pfn)
 {
-	struct iova *iova = find_iova(iovad, pfn);
-
-	if (iova)
-		__free_iova(iovad, iova);
+	unsigned long flags;
+	struct iova *iova;
 
+	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
+	iova = __find_iova(iovad, pfn);
+	if (iova) {
+		__cached_rbnode_delete_update(iovad, iova);
+		rb_erase(&iova->node, &iovad->rbroot);
+	}
+	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
+	free_iova_mem(iova);
 }
 EXPORT_SYMBOL_GPL(free_iova);
 
-- 
2.4.6
