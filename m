Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57906C433F5
	for <iommu@archiver.kernel.org>; Tue, 23 Nov 2021 14:11:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EB3AD4000B;
	Tue, 23 Nov 2021 14:11:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4PSbIyo6txzi; Tue, 23 Nov 2021 14:10:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 51F2A40401;
	Tue, 23 Nov 2021 14:10:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9B8FC0037;
	Tue, 23 Nov 2021 14:10:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 225F6C0012
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 14:10:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 050F740288
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 14:10:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R4ZVePrILaPM for <iommu@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 14:10:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 13D1A40275
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 14:10:56 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5857A106F;
 Tue, 23 Nov 2021 06:10:56 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 336B63F66F;
 Tue, 23 Nov 2021 06:10:55 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH 2/9] iommu/iova: Squash entry_dtor abstraction
Date: Tue, 23 Nov 2021 14:10:37 +0000
Message-Id: <b0b01425f638e13f3663903b73e7ca4f9fb1f20f.1637671820.git.robin.murphy@arm.com>
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

All flush queues are driven by iommu-dma now, so there is no need to
abstract entry_dtor or its data any more. Squash the now-canonical
implementation directly into the IOVA code to get it out of the way.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 17 ++---------------
 drivers/iommu/iova.c      | 28 +++++++++++++++-------------
 include/linux/iova.h      | 26 +++-----------------------
 3 files changed, 20 insertions(+), 51 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index b42e38a0dbe2..fa21b9141b71 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -64,18 +64,6 @@ static int __init iommu_dma_forcedac_setup(char *str)
 }
 early_param("iommu.forcedac", iommu_dma_forcedac_setup);
 
-static void iommu_dma_entry_dtor(unsigned long data)
-{
-	struct page *freelist = (struct page *)data;
-
-	while (freelist) {
-		unsigned long p = (unsigned long)page_address(freelist);
-
-		freelist = freelist->freelist;
-		free_page(p);
-	}
-}
-
 static inline size_t cookie_msi_granule(struct iommu_dma_cookie *cookie)
 {
 	if (cookie->type == IOMMU_DMA_IOVA_COOKIE)
@@ -324,8 +312,7 @@ int iommu_dma_init_fq(struct iommu_domain *domain)
 	if (cookie->fq_domain)
 		return 0;
 
-	ret = init_iova_flush_queue(&cookie->iovad, iommu_dma_flush_iotlb_all,
-				    iommu_dma_entry_dtor);
+	ret = init_iova_flush_queue(&cookie->iovad, iommu_dma_flush_iotlb_all);
 	if (ret) {
 		pr_warn("iova flush queue initialization failed\n");
 		return ret;
@@ -479,7 +466,7 @@ static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
 	else if (gather && gather->queued)
 		queue_iova(iovad, iova_pfn(iovad, iova),
 				size >> iova_shift(iovad),
-				(unsigned long)gather->freelist);
+				gather->freelist);
 	else
 		free_iova_fast(iovad, iova_pfn(iovad, iova),
 				size >> iova_shift(iovad));
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 9e8bc802ac05..982e2779b981 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -92,11 +92,9 @@ static void free_iova_flush_queue(struct iova_domain *iovad)
 
 	iovad->fq         = NULL;
 	iovad->flush_cb   = NULL;
-	iovad->entry_dtor = NULL;
 }
 
-int init_iova_flush_queue(struct iova_domain *iovad,
-			  iova_flush_cb flush_cb, iova_entry_dtor entry_dtor)
+int init_iova_flush_queue(struct iova_domain *iovad, iova_flush_cb flush_cb)
 {
 	struct iova_fq __percpu *queue;
 	int cpu;
@@ -109,7 +107,6 @@ int init_iova_flush_queue(struct iova_domain *iovad,
 		return -ENOMEM;
 
 	iovad->flush_cb   = flush_cb;
-	iovad->entry_dtor = entry_dtor;
 
 	for_each_possible_cpu(cpu) {
 		struct iova_fq *fq;
@@ -539,6 +536,16 @@ free_iova_fast(struct iova_domain *iovad, unsigned long pfn, unsigned long size)
 }
 EXPORT_SYMBOL_GPL(free_iova_fast);
 
+static void fq_entry_dtor(struct page *freelist)
+{
+	while (freelist) {
+		unsigned long p = (unsigned long)page_address(freelist);
+
+		freelist = freelist->freelist;
+		free_page(p);
+	}
+}
+
 #define fq_ring_for_each(i, fq) \
 	for ((i) = (fq)->head; (i) != (fq)->tail; (i) = ((i) + 1) % IOVA_FQ_SIZE)
 
@@ -571,9 +578,7 @@ static void fq_ring_free(struct iova_domain *iovad, struct iova_fq *fq)
 		if (fq->entries[idx].counter >= counter)
 			break;
 
-		if (iovad->entry_dtor)
-			iovad->entry_dtor(fq->entries[idx].data);
-
+		fq_entry_dtor(fq->entries[idx].freelist);
 		free_iova_fast(iovad,
 			       fq->entries[idx].iova_pfn,
 			       fq->entries[idx].pages);
@@ -598,15 +603,12 @@ static void fq_destroy_all_entries(struct iova_domain *iovad)
 	 * bother to free iovas, just call the entry_dtor on all remaining
 	 * entries.
 	 */
-	if (!iovad->entry_dtor)
-		return;
-
 	for_each_possible_cpu(cpu) {
 		struct iova_fq *fq = per_cpu_ptr(iovad->fq, cpu);
 		int idx;
 
 		fq_ring_for_each(idx, fq)
-			iovad->entry_dtor(fq->entries[idx].data);
+			fq_entry_dtor(fq->entries[idx].freelist);
 	}
 }
 
@@ -631,7 +633,7 @@ static void fq_flush_timeout(struct timer_list *t)
 
 void queue_iova(struct iova_domain *iovad,
 		unsigned long pfn, unsigned long pages,
-		unsigned long data)
+		struct page *freelist)
 {
 	struct iova_fq *fq;
 	unsigned long flags;
@@ -665,7 +667,7 @@ void queue_iova(struct iova_domain *iovad,
 
 	fq->entries[idx].iova_pfn = pfn;
 	fq->entries[idx].pages    = pages;
-	fq->entries[idx].data     = data;
+	fq->entries[idx].freelist = freelist;
 	fq->entries[idx].counter  = atomic64_read(&iovad->fq_flush_start_cnt);
 
 	spin_unlock_irqrestore(&fq->lock, flags);
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 71d8a2de6635..e746d8e41449 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -40,9 +40,6 @@ struct iova_domain;
 /* Call-Back from IOVA code into IOMMU drivers */
 typedef void (* iova_flush_cb)(struct iova_domain *domain);
 
-/* Destructor for per-entry data */
-typedef void (* iova_entry_dtor)(unsigned long data);
-
 /* Number of entries per Flush Queue */
 #define IOVA_FQ_SIZE	256
 
@@ -53,7 +50,7 @@ typedef void (* iova_entry_dtor)(unsigned long data);
 struct iova_fq_entry {
 	unsigned long iova_pfn;
 	unsigned long pages;
-	unsigned long data;
+	struct page *freelist;
 	u64 counter; /* Flush counter when this entrie was added */
 };
 
@@ -88,9 +85,6 @@ struct iova_domain {
 	iova_flush_cb	flush_cb;	/* Call-Back function to flush IOMMU
 					   TLBs */
 
-	iova_entry_dtor entry_dtor;	/* IOMMU driver specific destructor for
-					   iova entry */
-
 	struct timer_list fq_timer;		/* Timer to regularily empty the
 						   flush-queues */
 	atomic_t fq_timer_on;			/* 1 when timer is active, 0
@@ -146,15 +140,14 @@ void free_iova_fast(struct iova_domain *iovad, unsigned long pfn,
 		    unsigned long size);
 void queue_iova(struct iova_domain *iovad,
 		unsigned long pfn, unsigned long pages,
-		unsigned long data);
+		struct page *freelist);
 unsigned long alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
 			      unsigned long limit_pfn, bool flush_rcache);
 struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
 	unsigned long pfn_hi);
 void init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	unsigned long start_pfn);
-int init_iova_flush_queue(struct iova_domain *iovad,
-			  iova_flush_cb flush_cb, iova_entry_dtor entry_dtor);
+int init_iova_flush_queue(struct iova_domain *iovad, iova_flush_cb flush_cb);
 struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
 void put_iova_domain(struct iova_domain *iovad);
 #else
@@ -189,12 +182,6 @@ static inline void free_iova_fast(struct iova_domain *iovad,
 {
 }
 
-static inline void queue_iova(struct iova_domain *iovad,
-			      unsigned long pfn, unsigned long pages,
-			      unsigned long data)
-{
-}
-
 static inline unsigned long alloc_iova_fast(struct iova_domain *iovad,
 					    unsigned long size,
 					    unsigned long limit_pfn,
@@ -216,13 +203,6 @@ static inline void init_iova_domain(struct iova_domain *iovad,
 {
 }
 
-static inline int init_iova_flush_queue(struct iova_domain *iovad,
-					iova_flush_cb flush_cb,
-					iova_entry_dtor entry_dtor)
-{
-	return -ENODEV;
-}
-
 static inline struct iova *find_iova(struct iova_domain *iovad,
 				     unsigned long pfn)
 {
-- 
2.28.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
