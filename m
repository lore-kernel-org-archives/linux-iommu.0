From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 7/7] iommu/amd: Remove queue_release() function
Date: Wed,  7 Jun 2017 16:58:20 +0200
Message-ID: <1496847500-6781-8-git-send-email-joro@8bytes.org>
References: <1496847500-6781-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1496847500-6781-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Arindam Nath <arindam.nath-5C7GfCeVMHo@public.gmane.org>, Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

We can use queue_ring_free_flushed() instead, so remove this
redundancy.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 2bdfabf..80efa72 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1831,21 +1831,6 @@ static inline bool queue_ring_full(struct flush_queue *queue)
 #define queue_ring_for_each(i, q) \
 	for (i = (q)->head; i != (q)->tail; i = (i + 1) % FLUSH_QUEUE_SIZE)
 
-static void queue_release(struct dma_ops_domain *dom,
-			  struct flush_queue *queue)
-{
-	unsigned i;
-
-	assert_spin_locked(&queue->lock);
-
-	queue_ring_for_each(i, queue)
-		free_iova_fast(&dom->iovad,
-			       queue->entries[i].iova_pfn,
-			       queue->entries[i].pages);
-
-	queue->head = queue->tail = 0;
-}
-
 static inline unsigned queue_ring_add(struct flush_queue *queue)
 {
 	unsigned idx = queue->tail;
@@ -1897,12 +1882,15 @@ static void queue_add(struct dma_ops_domain *dom,
 	queue = get_cpu_ptr(dom->flush_queue);
 	spin_lock_irqsave(&queue->lock, flags);
 
-	queue_ring_free_flushed(dom, queue);
-
-	if (queue_ring_full(queue)) {
+	/*
+	 * When ring-queue is full, flush the entries from the IOTLB so
+	 * that we can free all entries with queue_ring_free_flushed()
+	 * below.
+	 */
+	if (queue_ring_full(queue))
 		dma_ops_domain_flush_tlb(dom);
-		queue_release(dom, queue);
-	}
+
+	queue_ring_free_flushed(dom, queue);
 
 	idx = queue_ring_add(queue);
 
-- 
2.7.4
