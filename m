Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 068B1C433F5
	for <iommu@archiver.kernel.org>; Tue, 23 Nov 2021 14:11:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 96188403B5;
	Tue, 23 Nov 2021 14:11:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aYWRr4ureXyX; Tue, 23 Nov 2021 14:11:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4AFED4029F;
	Tue, 23 Nov 2021 14:11:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23FBBC0031;
	Tue, 23 Nov 2021 14:11:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77C79C0012
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 14:11:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5633D40417
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 14:11:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AnSOhOa2LLxM for <iommu@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 14:11:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9B57B40424
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 14:11:08 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9A5B106F;
 Tue, 23 Nov 2021 06:11:07 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CEB7D3F66F;
 Tue, 23 Nov 2021 06:11:06 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH 8/9] iommu/iova: Move flush queue code to iommu-dma
Date: Tue, 23 Nov 2021 14:10:43 +0000
Message-Id: <602ebc127bcc7034352a0025568d297c2b0748ba.1637671820.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
In-Reply-To: <cover.1637671820.git.robin.murphy@arm.com>
References: <cover.1637671820.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, willy@infradead.org,
 iommu@lists.linux-foundation.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Flush queues are specific to DMA ops, which are now handled exclusively
by iommu-dma. As such, now that the historical artefacts from being
shared directly with drivers have been cleaned up, move the flush queue
code into iommu-dma itself to get it out of the way of other IOVA users.

This is pure code movement with no functional change; refactoring to
clean up the headers and definitions will follow.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 179 +++++++++++++++++++++++++++++++++++++-
 drivers/iommu/iova.c      | 175 -------------------------------------
 2 files changed, 178 insertions(+), 176 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f139b77caee0..ddf75e7c2ebc 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -64,6 +64,181 @@ static int __init iommu_dma_forcedac_setup(char *str)
 }
 early_param("iommu.forcedac", iommu_dma_forcedac_setup);
 
+
+#define fq_ring_for_each(i, fq) \
+	for ((i) = (fq)->head; (i) != (fq)->tail; (i) = ((i) + 1) % IOVA_FQ_SIZE)
+
+static inline bool fq_full(struct iova_fq *fq)
+{
+	assert_spin_locked(&fq->lock);
+	return (((fq->tail + 1) % IOVA_FQ_SIZE) == fq->head);
+}
+
+static inline unsigned fq_ring_add(struct iova_fq *fq)
+{
+	unsigned idx = fq->tail;
+
+	assert_spin_locked(&fq->lock);
+
+	fq->tail = (idx + 1) % IOVA_FQ_SIZE;
+
+	return idx;
+}
+
+static void fq_ring_free(struct iova_domain *iovad, struct iova_fq *fq)
+{
+	u64 counter = atomic64_read(&iovad->fq_flush_finish_cnt);
+	unsigned idx;
+
+	assert_spin_locked(&fq->lock);
+
+	fq_ring_for_each(idx, fq) {
+
+		if (fq->entries[idx].counter >= counter)
+			break;
+
+		put_pages_list(&fq->entries[idx].freelist);
+		free_iova_fast(iovad,
+			       fq->entries[idx].iova_pfn,
+			       fq->entries[idx].pages);
+
+		fq->head = (fq->head + 1) % IOVA_FQ_SIZE;
+	}
+}
+
+static void iova_domain_flush(struct iova_domain *iovad)
+{
+	atomic64_inc(&iovad->fq_flush_start_cnt);
+	iovad->fq_domain->ops->flush_iotlb_all(iovad->fq_domain);
+	atomic64_inc(&iovad->fq_flush_finish_cnt);
+}
+
+static void fq_flush_timeout(struct timer_list *t)
+{
+	struct iova_domain *iovad = from_timer(iovad, t, fq_timer);
+	int cpu;
+
+	atomic_set(&iovad->fq_timer_on, 0);
+	iova_domain_flush(iovad);
+
+	for_each_possible_cpu(cpu) {
+		unsigned long flags;
+		struct iova_fq *fq;
+
+		fq = per_cpu_ptr(iovad->fq, cpu);
+		spin_lock_irqsave(&fq->lock, flags);
+		fq_ring_free(iovad, fq);
+		spin_unlock_irqrestore(&fq->lock, flags);
+	}
+}
+
+void queue_iova(struct iova_domain *iovad,
+		unsigned long pfn, unsigned long pages,
+		struct list_head *freelist)
+{
+	struct iova_fq *fq;
+	unsigned long flags;
+	unsigned idx;
+
+	/*
+	 * Order against the IOMMU driver's pagetable update from unmapping
+	 * @pte, to guarantee that iova_domain_flush() observes that if called
+	 * from a different CPU before we release the lock below. Full barrier
+	 * so it also pairs with iommu_dma_init_fq() to avoid seeing partially
+	 * written fq state here.
+	 */
+	smp_mb();
+
+	fq = raw_cpu_ptr(iovad->fq);
+	spin_lock_irqsave(&fq->lock, flags);
+
+	/*
+	 * First remove all entries from the flush queue that have already been
+	 * flushed out on another CPU. This makes the fq_full() check below less
+	 * likely to be true.
+	 */
+	fq_ring_free(iovad, fq);
+
+	if (fq_full(fq)) {
+		iova_domain_flush(iovad);
+		fq_ring_free(iovad, fq);
+	}
+
+	idx = fq_ring_add(fq);
+
+	fq->entries[idx].iova_pfn = pfn;
+	fq->entries[idx].pages    = pages;
+	fq->entries[idx].counter  = atomic64_read(&iovad->fq_flush_start_cnt);
+	list_splice(freelist, &fq->entries[idx].freelist);
+
+	spin_unlock_irqrestore(&fq->lock, flags);
+
+	/* Avoid false sharing as much as possible. */
+	if (!atomic_read(&iovad->fq_timer_on) &&
+	    !atomic_xchg(&iovad->fq_timer_on, 1))
+		mod_timer(&iovad->fq_timer,
+			  jiffies + msecs_to_jiffies(IOVA_FQ_TIMEOUT));
+}
+
+static void free_iova_flush_queue(struct iova_domain *iovad)
+{
+	int cpu, idx;
+
+	if (!iovad->fq)
+		return;
+
+	del_timer(&iovad->fq_timer);
+	/*
+	 * This code runs when the iova_domain is being detroyed, so don't
+	 * bother to free iovas, just free any remaining pagetable pages.
+	 */
+	for_each_possible_cpu(cpu) {
+		struct iova_fq *fq = per_cpu_ptr(iovad->fq, cpu);
+
+		fq_ring_for_each(idx, fq)
+			put_pages_list(&fq->entries[idx].freelist);
+	}
+
+	free_percpu(iovad->fq);
+
+	iovad->fq = NULL;
+	iovad->fq_domain = NULL;
+}
+
+int init_iova_flush_queue(struct iova_domain *iovad, struct iommu_domain *fq_domain)
+{
+	struct iova_fq __percpu *queue;
+	int i, cpu;
+
+	atomic64_set(&iovad->fq_flush_start_cnt,  0);
+	atomic64_set(&iovad->fq_flush_finish_cnt, 0);
+
+	queue = alloc_percpu(struct iova_fq);
+	if (!queue)
+		return -ENOMEM;
+
+	for_each_possible_cpu(cpu) {
+		struct iova_fq *fq = per_cpu_ptr(queue, cpu);
+
+		fq->head = 0;
+		fq->tail = 0;
+
+		spin_lock_init(&fq->lock);
+
+		for (i = 0; i < IOVA_FQ_SIZE; i++)
+			INIT_LIST_HEAD(&fq->entries[i].freelist);
+	}
+
+	iovad->fq_domain = fq_domain;
+	iovad->fq = queue;
+
+	timer_setup(&iovad->fq_timer, fq_flush_timeout, 0);
+	atomic_set(&iovad->fq_timer_on, 0);
+
+	return 0;
+}
+
+
 static inline size_t cookie_msi_granule(struct iommu_dma_cookie *cookie)
 {
 	if (cookie->type == IOMMU_DMA_IOVA_COOKIE)
@@ -144,8 +319,10 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 	if (!cookie)
 		return;
 
-	if (cookie->type == IOMMU_DMA_IOVA_COOKIE && cookie->iovad.granule)
+	if (cookie->type == IOMMU_DMA_IOVA_COOKIE && cookie->iovad.granule) {
+		free_iova_flush_queue(&cookie->iovad);
 		put_iova_domain(&cookie->iovad);
+	}
 
 	list_for_each_entry_safe(msi, tmp, &cookie->msi_page_list, list) {
 		list_del(&msi->list);
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 159acd34501b..6673dfa8e7c5 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -481,179 +481,6 @@ free_iova_fast(struct iova_domain *iovad, unsigned long pfn, unsigned long size)
 }
 EXPORT_SYMBOL_GPL(free_iova_fast);
 
-#define fq_ring_for_each(i, fq) \
-	for ((i) = (fq)->head; (i) != (fq)->tail; (i) = ((i) + 1) % IOVA_FQ_SIZE)
-
-static inline bool fq_full(struct iova_fq *fq)
-{
-	assert_spin_locked(&fq->lock);
-	return (((fq->tail + 1) % IOVA_FQ_SIZE) == fq->head);
-}
-
-static inline unsigned fq_ring_add(struct iova_fq *fq)
-{
-	unsigned idx = fq->tail;
-
-	assert_spin_locked(&fq->lock);
-
-	fq->tail = (idx + 1) % IOVA_FQ_SIZE;
-
-	return idx;
-}
-
-static void fq_ring_free(struct iova_domain *iovad, struct iova_fq *fq)
-{
-	u64 counter = atomic64_read(&iovad->fq_flush_finish_cnt);
-	unsigned idx;
-
-	assert_spin_locked(&fq->lock);
-
-	fq_ring_for_each(idx, fq) {
-
-		if (fq->entries[idx].counter >= counter)
-			break;
-
-		put_pages_list(&fq->entries[idx].freelist);
-		free_iova_fast(iovad,
-			       fq->entries[idx].iova_pfn,
-			       fq->entries[idx].pages);
-
-		fq->head = (fq->head + 1) % IOVA_FQ_SIZE;
-	}
-}
-
-static void iova_domain_flush(struct iova_domain *iovad)
-{
-	atomic64_inc(&iovad->fq_flush_start_cnt);
-	iovad->fq_domain->ops->flush_iotlb_all(iovad->fq_domain);
-	atomic64_inc(&iovad->fq_flush_finish_cnt);
-}
-
-static void fq_flush_timeout(struct timer_list *t)
-{
-	struct iova_domain *iovad = from_timer(iovad, t, fq_timer);
-	int cpu;
-
-	atomic_set(&iovad->fq_timer_on, 0);
-	iova_domain_flush(iovad);
-
-	for_each_possible_cpu(cpu) {
-		unsigned long flags;
-		struct iova_fq *fq;
-
-		fq = per_cpu_ptr(iovad->fq, cpu);
-		spin_lock_irqsave(&fq->lock, flags);
-		fq_ring_free(iovad, fq);
-		spin_unlock_irqrestore(&fq->lock, flags);
-	}
-}
-
-void queue_iova(struct iova_domain *iovad,
-		unsigned long pfn, unsigned long pages,
-		struct list_head *freelist)
-{
-	struct iova_fq *fq;
-	unsigned long flags;
-	unsigned idx;
-
-	/*
-	 * Order against the IOMMU driver's pagetable update from unmapping
-	 * @pte, to guarantee that iova_domain_flush() observes that if called
-	 * from a different CPU before we release the lock below. Full barrier
-	 * so it also pairs with iommu_dma_init_fq() to avoid seeing partially
-	 * written fq state here.
-	 */
-	smp_mb();
-
-	fq = raw_cpu_ptr(iovad->fq);
-	spin_lock_irqsave(&fq->lock, flags);
-
-	/*
-	 * First remove all entries from the flush queue that have already been
-	 * flushed out on another CPU. This makes the fq_full() check below less
-	 * likely to be true.
-	 */
-	fq_ring_free(iovad, fq);
-
-	if (fq_full(fq)) {
-		iova_domain_flush(iovad);
-		fq_ring_free(iovad, fq);
-	}
-
-	idx = fq_ring_add(fq);
-
-	fq->entries[idx].iova_pfn = pfn;
-	fq->entries[idx].pages    = pages;
-	fq->entries[idx].counter  = atomic64_read(&iovad->fq_flush_start_cnt);
-	list_splice(freelist, &fq->entries[idx].freelist);
-
-	spin_unlock_irqrestore(&fq->lock, flags);
-
-	/* Avoid false sharing as much as possible. */
-	if (!atomic_read(&iovad->fq_timer_on) &&
-	    !atomic_xchg(&iovad->fq_timer_on, 1))
-		mod_timer(&iovad->fq_timer,
-			  jiffies + msecs_to_jiffies(IOVA_FQ_TIMEOUT));
-}
-
-static void free_iova_flush_queue(struct iova_domain *iovad)
-{
-	int cpu, idx;
-
-	if (!iovad->fq)
-		return;
-
-	del_timer(&iovad->fq_timer);
-	/*
-	 * This code runs when the iova_domain is being detroyed, so don't
-	 * bother to free iovas, just free any remaining pagetable pages.
-	 */
-	for_each_possible_cpu(cpu) {
-		struct iova_fq *fq = per_cpu_ptr(iovad->fq, cpu);
-
-		fq_ring_for_each(idx, fq)
-			put_pages_list(&fq->entries[idx].freelist);
-	}
-
-	free_percpu(iovad->fq);
-
-	iovad->fq = NULL;
-	iovad->fq_domain = NULL;
-}
-
-int init_iova_flush_queue(struct iova_domain *iovad, struct iommu_domain *fq_domain)
-{
-	struct iova_fq __percpu *queue;
-	int i, cpu;
-
-	atomic64_set(&iovad->fq_flush_start_cnt,  0);
-	atomic64_set(&iovad->fq_flush_finish_cnt, 0);
-
-	queue = alloc_percpu(struct iova_fq);
-	if (!queue)
-		return -ENOMEM;
-
-	for_each_possible_cpu(cpu) {
-		struct iova_fq *fq = per_cpu_ptr(queue, cpu);
-
-		fq->head = 0;
-		fq->tail = 0;
-
-		spin_lock_init(&fq->lock);
-
-		for (i = 0; i < IOVA_FQ_SIZE; i++)
-			INIT_LIST_HEAD(&fq->entries[i].freelist);
-	}
-
-	iovad->fq_domain = fq_domain;
-	iovad->fq = queue;
-
-	timer_setup(&iovad->fq_timer, fq_flush_timeout, 0);
-	atomic_set(&iovad->fq_timer_on, 0);
-
-	return 0;
-}
-
 /**
  * put_iova_domain - destroys the iova domain
  * @iovad: - iova domain in question.
@@ -665,8 +492,6 @@ void put_iova_domain(struct iova_domain *iovad)
 
 	cpuhp_state_remove_instance_nocalls(CPUHP_IOMMU_IOVA_DEAD,
 					    &iovad->cpuhp_dead);
-
-	free_iova_flush_queue(iovad);
 	free_iova_rcaches(iovad);
 	rbtree_postorder_for_each_entry_safe(iova, tmp, &iovad->rbroot, node)
 		free_iova_mem(iova);
-- 
2.28.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
