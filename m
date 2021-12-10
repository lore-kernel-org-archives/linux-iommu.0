Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10A5C433EF
	for <iommu@archiver.kernel.org>; Fri, 10 Dec 2021 17:55:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 88F7141290;
	Fri, 10 Dec 2021 17:55:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 93hE-EPiiOL4; Fri, 10 Dec 2021 17:55:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 269DA4055A;
	Fri, 10 Dec 2021 17:55:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02EE0C002F;
	Fri, 10 Dec 2021 17:55:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8811C0039
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 17:55:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 916DB827BA
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 17:55:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hdRdYbgrfGee for <iommu@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 17:55:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id B13318278F
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 17:55:20 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33D4612FC;
 Fri, 10 Dec 2021 09:55:20 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F218A3F73B;
 Fri, 10 Dec 2021 09:55:18 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v2 09/11] iommu/iova: Consolidate flush queue code
Date: Fri, 10 Dec 2021 17:54:50 +0000
Message-Id: <ea0142c046f89c2f917554988b243b130bd23bd2.1639157090.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
In-Reply-To: <cover.1639157090.git.robin.murphy@arm.com>
References: <cover.1639157090.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org,
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

Squash and simplify some of the freeing code, and move the init
and free routines down into the rest of the flush queue code to
obviate the forward declarations.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: Rebase with del_timer_sync() change

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
