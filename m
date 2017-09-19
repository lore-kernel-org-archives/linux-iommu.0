From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 1/3] iommu/iova: Simplify domain destruction
Date: Tue, 19 Sep 2017 14:48:39 +0100
Message-ID: <05b024899683b0e1e86d5b7a1e75e434ba53d219.1505827369.git.robin.murphy@arm.com>
References: <cover.1505827369.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1505827369.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

All put_iova_domain() should have to worry about is freeing memory - by
that point the domain must no longer be live, so the act of cleaning up
doesn't need to be concurrency-safe or maintain the rbtree in a
self-consistent state. There's no need to waste time with locking or
emptying the rcache magazines, and we can just use the postorder
traversal helper to clear out the remaining rbtree entries in-place.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/iova.c | 50 ++++++++++----------------------------------------
 1 file changed, 10 insertions(+), 40 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index a6cf775f75e0..35dde0fc7793 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -588,21 +588,12 @@ EXPORT_SYMBOL_GPL(queue_iova);
  */
 void put_iova_domain(struct iova_domain *iovad)
 {
-	struct rb_node *node;
-	unsigned long flags;
+	struct iova *iova, *tmp;
 
 	free_iova_flush_queue(iovad);
 	free_iova_rcaches(iovad);
-	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
-	node = rb_first(&iovad->rbroot);
-	while (node) {
-		struct iova *iova = rb_entry(node, struct iova, node);
-
-		rb_erase(node, &iovad->rbroot);
+	rbtree_postorder_for_each_entry_safe(iova, tmp, &iovad->rbroot, node)
 		free_iova_mem(iova);
-		node = rb_first(&iovad->rbroot);
-	}
-	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 }
 EXPORT_SYMBOL_GPL(put_iova_domain);
 
@@ -995,46 +986,25 @@ static unsigned long iova_rcache_get(struct iova_domain *iovad,
 }
 
 /*
- * Free a cpu's rcache.
- */
-static void free_cpu_iova_rcache(unsigned int cpu, struct iova_domain *iovad,
-				 struct iova_rcache *rcache)
-{
-	struct iova_cpu_rcache *cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
-	unsigned long flags;
-
-	spin_lock_irqsave(&cpu_rcache->lock, flags);
-
-	iova_magazine_free_pfns(cpu_rcache->loaded, iovad);
-	iova_magazine_free(cpu_rcache->loaded);
-
-	iova_magazine_free_pfns(cpu_rcache->prev, iovad);
-	iova_magazine_free(cpu_rcache->prev);
-
-	spin_unlock_irqrestore(&cpu_rcache->lock, flags);
-}
-
-/*
  * free rcache data structures.
  */
 static void free_iova_rcaches(struct iova_domain *iovad)
 {
 	struct iova_rcache *rcache;
-	unsigned long flags;
+	struct iova_cpu_rcache *cpu_rcache;
 	unsigned int cpu;
 	int i, j;
 
 	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
 		rcache = &iovad->rcaches[i];
-		for_each_possible_cpu(cpu)
-			free_cpu_iova_rcache(cpu, iovad, rcache);
-		spin_lock_irqsave(&rcache->lock, flags);
-		free_percpu(rcache->cpu_rcaches);
-		for (j = 0; j < rcache->depot_size; ++j) {
-			iova_magazine_free_pfns(rcache->depot[j], iovad);
-			iova_magazine_free(rcache->depot[j]);
+		for_each_possible_cpu(cpu) {
+			cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
+			iova_magazine_free(cpu_rcache->loaded);
+			iova_magazine_free(cpu_rcache->prev);
 		}
-		spin_unlock_irqrestore(&rcache->lock, flags);
+		free_percpu(rcache->cpu_rcaches);
+		for (j = 0; j < rcache->depot_size; ++j)
+			iova_magazine_free(rcache->depot[j]);
 	}
 }
 
-- 
2.13.4.dirty
