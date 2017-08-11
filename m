From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 4/8] iommu/iova: Add locking to Flush-Queues
Date: Fri, 11 Aug 2017 16:41:14 +0200
Message-ID: <1502462478-22045-5-git-send-email-joro@8bytes.org>
References: <1502462478-22045-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502462478-22045-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Robin Murphy <robin.murphy@arm.com>, dwmw2@infradead.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

The lock is taken from the same CPU most of the time. But
having it allows to flush the queue also from another CPU if
necessary.

This will be used by a timer to regularily flush any pending
IOVAs from the Flush-Queues.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/iova.c | 11 +++++++++++
 include/linux/iova.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 47b144e..749d395 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -91,6 +91,8 @@ int init_iova_flush_queue(struct iova_domain *iovad,
 		fq = per_cpu_ptr(iovad->fq, cpu);
 		fq->head = 0;
 		fq->tail = 0;
+
+		spin_lock_init(&fq->lock);
 	}
 
 	return 0;
@@ -471,6 +473,7 @@ EXPORT_SYMBOL_GPL(free_iova_fast);
 
 static inline bool fq_full(struct iova_fq *fq)
 {
+	assert_spin_locked(&fq->lock);
 	return (((fq->tail + 1) % IOVA_FQ_SIZE) == fq->head);
 }
 
@@ -478,6 +481,8 @@ static inline unsigned fq_ring_add(struct iova_fq *fq)
 {
 	unsigned idx = fq->tail;
 
+	assert_spin_locked(&fq->lock);
+
 	fq->tail = (idx + 1) % IOVA_FQ_SIZE;
 
 	return idx;
@@ -488,6 +493,8 @@ static void fq_ring_free(struct iova_domain *iovad, struct iova_fq *fq)
 	u64 counter = atomic64_read(&iovad->fq_flush_finish_cnt);
 	unsigned idx;
 
+	assert_spin_locked(&fq->lock);
+
 	fq_ring_for_each(idx, fq) {
 
 		if (fq->entries[idx].counter >= counter)
@@ -537,8 +544,11 @@ void queue_iova(struct iova_domain *iovad,
 		unsigned long data)
 {
 	struct iova_fq *fq = get_cpu_ptr(iovad->fq);
+	unsigned long flags;
 	unsigned idx;
 
+	spin_lock_irqsave(&fq->lock, flags);
+
 	/*
 	 * First remove all entries from the flush queue that have already been
 	 * flushed out on another CPU. This makes the fq_full() check below less
@@ -558,6 +568,7 @@ void queue_iova(struct iova_domain *iovad,
 	fq->entries[idx].data     = data;
 	fq->entries[idx].counter  = atomic64_read(&iovad->fq_flush_start_cnt);
 
+	spin_unlock_irqrestore(&fq->lock, flags);
 	put_cpu_ptr(iovad->fq);
 }
 EXPORT_SYMBOL_GPL(queue_iova);
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 985b800..913a690 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -60,6 +60,7 @@ struct iova_fq_entry {
 struct iova_fq {
 	struct iova_fq_entry entries[IOVA_FQ_SIZE];
 	unsigned head, tail;
+	spinlock_t lock;
 };
 
 /* holds all the iova translations for a domain */
-- 
2.7.4
