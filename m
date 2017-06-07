From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 5/7] iommu/amd: Add flush counters to struct dma_ops_domain
Date: Wed,  7 Jun 2017 16:58:18 +0200
Message-ID: <1496847500-6781-6-git-send-email-joro@8bytes.org>
References: <1496847500-6781-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1496847500-6781-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>, Arindam Nath <arindam.nath@amd.com>, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

The counters are increased every time the TLB for a given
domain is flushed. We also store the current value of that
counter into newly added entries of the flush-queue, so that
we can tell wheter this entry is already flushed.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 9aa2735..1ad2866 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -139,6 +139,7 @@ static void detach_device(struct device *dev);
 struct flush_queue_entry {
 	unsigned long iova_pfn;
 	unsigned long pages;
+	u64 counter; /* Flush counter when this entry was added to the queue */
 };
 
 struct flush_queue {
@@ -158,6 +159,27 @@ struct dma_ops_domain {
 	struct iova_domain iovad;
 
 	struct flush_queue __percpu *flush_queue;
+
+	/*
+	 * We need two counter here to be race-free wrt. IOTLB flushing and
+	 * adding entries to the flush queue.
+	 *
+	 * The flush_start_cnt is incremented _before_ the IOTLB flush starts.
+	 * New entries added to the flush ring-buffer get their 'counter' value
+	 * from here. This way we can make sure that entries added to the queue
+	 * (or other per-cpu queues of the same domain) while the TLB is about
+	 * to be flushed are not considered to be flushed already.
+	 */
+	atomic64_t flush_start_cnt;
+
+	/*
+	 * The flush_finish_cnt is incremented when an IOTLB flush is complete.
+	 * This value is always smaller than flush_start_cnt. The queue_add
+	 * function frees all IOVAs that have a counter value smaller than
+	 * flush_finish_cnt. This makes sure that we only free IOVAs that are
+	 * flushed out of the IOTLB of the domain.
+	 */
+	atomic64_t flush_finish_cnt;
 };
 
 static struct iova_domain reserved_iova_ranges;
@@ -1749,6 +1771,9 @@ static int dma_ops_domain_alloc_flush_queue(struct dma_ops_domain *dom)
 {
 	int cpu;
 
+	atomic64_set(&dom->flush_start_cnt,  0);
+	atomic64_set(&dom->flush_finish_cnt, 0);
+
 	dom->flush_queue = alloc_percpu(struct flush_queue);
 	if (!dom->flush_queue)
 		return -ENOMEM;
@@ -1816,22 +1841,48 @@ static inline unsigned queue_ring_add(struct flush_queue *queue)
 	return idx;
 }
 
+static inline void queue_ring_remove_head(struct flush_queue *queue)
+{
+	assert_spin_locked(&queue->lock);
+	queue->head = (queue->head + 1) % FLUSH_QUEUE_SIZE;
+}
+
 static void queue_add(struct dma_ops_domain *dom,
 		      unsigned long address, unsigned long pages)
 {
 	struct flush_queue *queue;
 	unsigned long flags;
+	u64 counter;
 	int idx;
 
 	pages     = __roundup_pow_of_two(pages);
 	address >>= PAGE_SHIFT;
 
+	counter = atomic64_read(&dom->flush_finish_cnt);
+
 	queue = get_cpu_ptr(dom->flush_queue);
 	spin_lock_irqsave(&queue->lock, flags);
 
+	queue_ring_for_each(idx, queue) {
+		/*
+		 * This assumes that counter values in the ring-buffer are
+		 * monotonously rising.
+		 */
+		if (queue->entries[idx].counter >= counter)
+			break;
+
+		free_iova_fast(&dom->iovad,
+			       queue->entries[idx].iova_pfn,
+			       queue->entries[idx].pages);
+
+		queue_ring_remove_head(queue);
+	}
+
 	if (queue_ring_full(queue)) {
+		atomic64_inc(&dom->flush_start_cnt);
 		domain_flush_tlb(&dom->domain);
 		domain_flush_complete(&dom->domain);
+		atomic64_inc(&dom->flush_finish_cnt);
 		queue_release(dom, queue);
 	}
 
@@ -1839,6 +1890,7 @@ static void queue_add(struct dma_ops_domain *dom,
 
 	queue->entries[idx].iova_pfn = address;
 	queue->entries[idx].pages    = pages;
+	queue->entries[idx].counter  = atomic64_read(&dom->flush_start_cnt);
 
 	spin_unlock_irqrestore(&queue->lock, flags);
 	put_cpu_ptr(dom->flush_queue);
-- 
2.7.4
