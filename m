From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 4/7] iommu/amd: Add locking to per-domain flush-queue
Date: Wed,  7 Jun 2017 16:58:17 +0200
Message-ID: <1496847500-6781-5-git-send-email-joro@8bytes.org>
References: <1496847500-6781-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1496847500-6781-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>, Arindam Nath <arindam.nath@amd.com>, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

With locking we can safely access the flush-queues of other
cpus.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 6a5c858..9aa2735 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -144,6 +144,7 @@ struct flush_queue_entry {
 struct flush_queue {
 	struct flush_queue_entry *entries;
 	unsigned head, tail;
+	spinlock_t lock;
 };
 
 /*
@@ -1773,6 +1774,8 @@ static int dma_ops_domain_alloc_flush_queue(struct dma_ops_domain *dom)
 			dma_ops_domain_free_flush_queue(dom);
 			return -ENOMEM;
 		}
+
+		spin_lock_init(&queue->lock);
 	}
 
 	return 0;
@@ -1780,6 +1783,8 @@ static int dma_ops_domain_alloc_flush_queue(struct dma_ops_domain *dom)
 
 static inline bool queue_ring_full(struct flush_queue *queue)
 {
+	assert_spin_locked(&queue->lock);
+
 	return (((queue->tail + 1) % FLUSH_QUEUE_SIZE) == queue->head);
 }
 
@@ -1791,6 +1796,8 @@ static void queue_release(struct dma_ops_domain *dom,
 {
 	unsigned i;
 
+	assert_spin_locked(&queue->lock);
+
 	queue_ring_for_each(i, queue)
 		free_iova_fast(&dom->iovad,
 			       queue->entries[i].iova_pfn,
@@ -1803,6 +1810,7 @@ static inline unsigned queue_ring_add(struct flush_queue *queue)
 {
 	unsigned idx = queue->tail;
 
+	assert_spin_locked(&queue->lock);
 	queue->tail = (idx + 1) % FLUSH_QUEUE_SIZE;
 
 	return idx;
@@ -1812,12 +1820,14 @@ static void queue_add(struct dma_ops_domain *dom,
 		      unsigned long address, unsigned long pages)
 {
 	struct flush_queue *queue;
+	unsigned long flags;
 	int idx;
 
 	pages     = __roundup_pow_of_two(pages);
 	address >>= PAGE_SHIFT;
 
 	queue = get_cpu_ptr(dom->flush_queue);
+	spin_lock_irqsave(&queue->lock, flags);
 
 	if (queue_ring_full(queue)) {
 		domain_flush_tlb(&dom->domain);
@@ -1830,6 +1840,7 @@ static void queue_add(struct dma_ops_domain *dom,
 	queue->entries[idx].iova_pfn = address;
 	queue->entries[idx].pages    = pages;
 
+	spin_unlock_irqrestore(&queue->lock, flags);
 	put_cpu_ptr(dom->flush_queue);
 }
 
-- 
2.7.4
