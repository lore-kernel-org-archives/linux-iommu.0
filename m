Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7CE0C433F5
	for <iommu@archiver.kernel.org>; Fri, 17 Dec 2021 15:31:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 692EC41F63;
	Fri, 17 Dec 2021 15:31:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NhWfspzMU3Zm; Fri, 17 Dec 2021 15:31:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 454D941F37;
	Fri, 17 Dec 2021 15:31:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 208B8C002F;
	Fri, 17 Dec 2021 15:31:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C1BCC0012
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 15:31:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5B64541F5D
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 15:31:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EBPAPm0THeRl for <iommu@lists.linux-foundation.org>;
 Fri, 17 Dec 2021 15:31:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8750A41F4A
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 15:31:23 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21F491595;
 Fri, 17 Dec 2021 07:31:23 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C66853F774;
 Fri, 17 Dec 2021 07:31:21 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v3 7/9] iommu/iova: Consolidate flush queue code
Date: Fri, 17 Dec 2021 15:31:01 +0000
Message-Id: <b0dd4565e6646b6489599d7a1eaa362c75f53c95.1639753638.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
In-Reply-To: <cover.1639753638.git.robin.murphy@arm.com>
References: <cover.1639753638.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, hch@lst.de
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

Squash and simplify some of the freeing code, and move the init
and free routines down into the rest of the flush queue code to
obviate the forward declarations.

Reviewed-by: John Garry <john.garry@huawei.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iova.c | 131 +++++++++++++++++++------------------------
 1 file changed, 58 insertions(+), 73 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index a0250cebcdcf..c19f9a749070 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -24,8 +24,6 @@ static unsigned long iova_rcache_get(struct iova_domain *iovad,
 static void init_iova_rcaches(struct iova_domain *iovad);
 static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
 static void free_iova_rcaches(struct iova_domain *iovad);
-static void fq_destroy_all_entries(struct iova_domain *iovad);
-static void fq_flush_timeout(struct timer_list *t);
 
 static int iova_cpuhp_dead(unsigned int cpu, struct hlist_node *node)
 {
@@ -73,60 +71,6 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 }
 EXPORT_SYMBOL_GPL(init_iova_domain);
 
-static bool has_iova_flush_queue(struct iova_domain *iovad)
-{
-	return !!iovad->fq;
-}
-
-static void free_iova_flush_queue(struct iova_domain *iovad)
-{
-	if (!has_iova_flush_queue(iovad))
-		return;
-
-	del_timer_sync(&iovad->fq_timer);
-
-	fq_destroy_all_entries(iovad);
-
-	free_percpu(iovad->fq);
-
-	iovad->fq         = NULL;
-	iovad->fq_domain  = NULL;
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
-		struct iova_fq *fq;
-
-		fq = per_cpu_ptr(queue, cpu);
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
 static struct rb_node *
 __get_cached_rbnode(struct iova_domain *iovad, unsigned long limit_pfn)
 {
@@ -585,23 +529,6 @@ static void iova_domain_flush(struct iova_domain *iovad)
 	atomic64_inc(&iovad->fq_flush_finish_cnt);
 }
 
-static void fq_destroy_all_entries(struct iova_domain *iovad)
-{
-	int cpu;
-
-	/*
-	 * This code runs when the iova_domain is being detroyed, so don't
-	 * bother to free iovas, just free any remaining pagetable pages.
-	 */
-	for_each_possible_cpu(cpu) {
-		struct iova_fq *fq = per_cpu_ptr(iovad->fq, cpu);
-		int idx;
-
-		fq_ring_for_each(idx, fq)
-			put_pages_list(&fq->entries[idx].freelist);
-	}
-}
-
 static void fq_flush_timeout(struct timer_list *t)
 {
 	struct iova_domain *iovad = from_timer(iovad, t, fq_timer);
@@ -669,6 +596,64 @@ void queue_iova(struct iova_domain *iovad,
 			  jiffies + msecs_to_jiffies(IOVA_FQ_TIMEOUT));
 }
 
+static void free_iova_flush_queue(struct iova_domain *iovad)
+{
+	int cpu, idx;
+
+	if (!iovad->fq)
+		return;
+
+	del_timer_sync(&iovad->fq_timer);
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
 /**
  * put_iova_domain - destroys the iova domain
  * @iovad: - iova domain in question.
-- 
2.28.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
