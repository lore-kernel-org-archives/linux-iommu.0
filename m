Return-Path: <SRS0=LkSb=OO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7382AC433EF
	for <iommu@archiver.kernel.org>; Fri, 24 Sep 2021 10:07:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B4946124B
	for <iommu@archiver.kernel.org>; Fri, 24 Sep 2021 10:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2B4946124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F31C2415CD;
	Fri, 24 Sep 2021 10:07:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zxvCj8_S_TTP; Fri, 24 Sep 2021 10:07:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 99157415B9;
	Fri, 24 Sep 2021 10:07:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 777CDC001C;
	Fri, 24 Sep 2021 10:07:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15D89C0027;
 Fri, 24 Sep 2021 10:07:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DD690415B9;
 Fri, 24 Sep 2021 10:07:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z7L2SAX0VvEg; Fri, 24 Sep 2021 10:07:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9950D415A2;
 Fri, 24 Sep 2021 10:07:11 +0000 (UTC)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HG71D48HZz67WFS;
 Fri, 24 Sep 2021 18:04:32 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 24 Sep 2021 12:07:08 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 24 Sep 2021 11:07:05 +0100
From: John Garry <john.garry@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>, <mst@redhat.com>,
 <jasowang@redhat.com>, <robin.murphy@arm.com>
Subject: [PATCH 2/5] iommu: Separate flush queue memories from IOVA domain
 structure
Date: Fri, 24 Sep 2021 18:01:54 +0800
Message-ID: <1632477717-5254-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1632477717-5254-1-git-send-email-john.garry@huawei.com>
References: <1632477717-5254-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: linuxarm@huawei.com, linux-kernel@vger.kernel.org, xieyongji@bytedance.com,
 iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org
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

Only dma-iommu.c uses the FQ, so it is wasteful and slightly disorganised
to hold all the FQ memories in the iova_domain structure.

So create a new structure, fq_domain, which is a new separate member in
iommu_dma_cookie for DMA IOVA type.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/dma-iommu.c | 37 ++++++++++-----
 drivers/iommu/iova.c      | 98 +++++++++++++++++++--------------------
 include/linux/iova.h      | 30 ++++++++----
 3 files changed, 94 insertions(+), 71 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index a99b3445fef8..279ee13bceb2 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -41,7 +41,10 @@ struct iommu_dma_cookie {
 	enum iommu_dma_cookie_type	type;
 	union {
 		/* Full allocator for IOMMU_DMA_IOVA_COOKIE */
-		struct iova_domain	iovad;
+		struct {
+			struct iova_domain	iovad;
+			struct fq_domain	fq;
+		};
 		/* Trivial linear page allocator for IOMMU_DMA_MSI_COOKIE */
 		dma_addr_t		msi_iova;
 	};
@@ -162,8 +165,10 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 	if (!cookie)
 		return;
 
-	if (cookie->type == IOMMU_DMA_IOVA_COOKIE && cookie->iovad.granule)
+	if (cookie->type == IOMMU_DMA_IOVA_COOKIE && cookie->iovad.granule) {
+		iova_free_flush_queue(&cookie->fq);
 		put_iova_domain(&cookie->iovad);
+	}
 
 	list_for_each_entry_safe(msi, tmp, &cookie->msi_page_list, list) {
 		list_del(&msi->list);
@@ -301,12 +306,12 @@ static int iova_reserve_iommu_regions(struct device *dev,
 	return ret;
 }
 
-static void iommu_dma_flush_iotlb_all(struct iova_domain *iovad)
+static void iommu_dma_flush_iotlb_all(struct fq_domain *fq_domain)
 {
 	struct iommu_dma_cookie *cookie;
 	struct iommu_domain *domain;
 
-	cookie = container_of(iovad, struct iommu_dma_cookie, iovad);
+	cookie = container_of(fq_domain, struct iommu_dma_cookie, fq);
 	domain = cookie->fq_domain;
 
 	domain->ops->flush_iotlb_all(domain);
@@ -321,17 +326,21 @@ static bool dev_is_untrusted(struct device *dev)
 int iommu_dma_init_fq(struct iommu_domain *domain)
 {
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	struct fq_domain *fq = &cookie->fq;
 	int ret;
 
 	if (cookie->fq_domain)
 		return 0;
 
-	ret = init_iova_flush_queue(&cookie->iovad, iommu_dma_flush_iotlb_all,
+	ret = init_iova_flush_queue(fq, iommu_dma_flush_iotlb_all,
 				    iommu_dma_entry_dtor);
 	if (ret) {
 		pr_warn("iova flush queue initialization failed\n");
 		return ret;
 	}
+
+	fq->iovad = &cookie->iovad;
+
 	/*
 	 * Prevent incomplete iovad->fq being observable. Pairs with path from
 	 * __iommu_dma_unmap() through iommu_dma_free_iova() to queue_iova()
@@ -359,11 +368,13 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	unsigned long order, base_pfn;
 	struct iova_domain *iovad;
+	struct fq_domain *fq;
 
 	if (!cookie || cookie->type != IOMMU_DMA_IOVA_COOKIE)
 		return -EINVAL;
 
 	iovad = &cookie->iovad;
+	fq = &cookie->fq;
 
 	/* Use the smallest supported page size for IOVA granularity */
 	order = __ffs(domain->pgsize_bitmap);
@@ -392,6 +403,9 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 		return 0;
 	}
 
+	fq->flush_cb = NULL;
+	fq->fq = NULL;
+
 	init_iova_domain(iovad, 1UL << order, base_pfn);
 
 	/* If the FQ fails we can simply fall back to strict mode */
@@ -468,15 +482,16 @@ static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
 	struct iova_domain *iovad = &cookie->iovad;
 
 	/* The MSI case is only ever cleaning up its most recent allocation */
-	if (cookie->type == IOMMU_DMA_MSI_COOKIE)
+	if (cookie->type == IOMMU_DMA_MSI_COOKIE) {
 		cookie->msi_iova -= size;
-	else if (gather && gather->queued)
-		queue_iova(iovad, iova_pfn(iovad, iova),
-				size >> iova_shift(iovad),
-				(unsigned long)gather->freelist);
-	else
+	} else if (gather && gather->queued) {
+		queue_iova(&cookie->fq, iova_pfn(iovad, iova),
+			   size >> iova_shift(iovad),
+			   (unsigned long)gather->freelist);
+	} else {
 		free_iova_fast(iovad, iova_pfn(iovad, iova),
 				size >> iova_shift(iovad));
+	}
 }
 
 static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index ff567cbc42f7..262a08eb547f 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -24,7 +24,7 @@ static unsigned long iova_rcache_get(struct iova_domain *iovad,
 static void init_iova_rcaches(struct iova_domain *iovad);
 static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
 static void free_iova_rcaches(struct iova_domain *iovad);
-static void fq_destroy_all_entries(struct iova_domain *iovad);
+static void fq_destroy_all_entries(struct fq_domain *fq_domain);
 static void fq_flush_timeout(struct timer_list *t);
 
 static int iova_cpuhp_dead(unsigned int cpu, struct hlist_node *node)
@@ -63,8 +63,6 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	iovad->start_pfn = start_pfn;
 	iovad->dma_32bit_pfn = 1UL << (32 - iova_shift(iovad));
 	iovad->max32_alloc_size = iovad->dma_32bit_pfn;
-	iovad->flush_cb = NULL;
-	iovad->fq = NULL;
 	iovad->anchor.pfn_lo = iovad->anchor.pfn_hi = IOVA_ANCHOR;
 	rb_link_node(&iovad->anchor.node, NULL, &iovad->rbroot.rb_node);
 	rb_insert_color(&iovad->anchor.node, &iovad->rbroot);
@@ -73,43 +71,44 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 }
 EXPORT_SYMBOL_GPL(init_iova_domain);
 
-static bool has_iova_flush_queue(struct iova_domain *iovad)
+static bool has_iova_flush_queue(struct fq_domain *fq_domain)
 {
-	return !!iovad->fq;
+	return !!fq_domain->fq;
 }
 
-static void free_iova_flush_queue(struct iova_domain *iovad)
+void iova_free_flush_queue(struct fq_domain *fq_domain)
 {
-	if (!has_iova_flush_queue(iovad))
+	if (!has_iova_flush_queue(fq_domain))
 		return;
 
-	if (timer_pending(&iovad->fq_timer))
-		del_timer(&iovad->fq_timer);
+	if (timer_pending(&fq_domain->fq_timer))
+		del_timer(&fq_domain->fq_timer);
 
-	fq_destroy_all_entries(iovad);
+	fq_destroy_all_entries(fq_domain);
 
-	free_percpu(iovad->fq);
+	free_percpu(fq_domain->fq);
 
-	iovad->fq         = NULL;
-	iovad->flush_cb   = NULL;
-	iovad->entry_dtor = NULL;
+	fq_domain->fq         = NULL;
+	fq_domain->flush_cb   = NULL;
+	fq_domain->entry_dtor = NULL;
+	fq_domain->iovad      = NULL;
 }
 
-int init_iova_flush_queue(struct iova_domain *iovad,
+int init_iova_flush_queue(struct fq_domain *fq_domain,
 			  iova_flush_cb flush_cb, iova_entry_dtor entry_dtor)
 {
 	struct iova_fq __percpu *queue;
 	int cpu;
 
-	atomic64_set(&iovad->fq_flush_start_cnt,  0);
-	atomic64_set(&iovad->fq_flush_finish_cnt, 0);
+	atomic64_set(&fq_domain->fq_flush_start_cnt,  0);
+	atomic64_set(&fq_domain->fq_flush_finish_cnt, 0);
 
 	queue = alloc_percpu(struct iova_fq);
 	if (!queue)
 		return -ENOMEM;
 
-	iovad->flush_cb   = flush_cb;
-	iovad->entry_dtor = entry_dtor;
+	fq_domain->flush_cb   = flush_cb;
+	fq_domain->entry_dtor = entry_dtor;
 
 	for_each_possible_cpu(cpu) {
 		struct iova_fq *fq;
@@ -121,10 +120,10 @@ int init_iova_flush_queue(struct iova_domain *iovad,
 		spin_lock_init(&fq->lock);
 	}
 
-	iovad->fq = queue;
+	fq_domain->fq = queue;
 
-	timer_setup(&iovad->fq_timer, fq_flush_timeout, 0);
-	atomic_set(&iovad->fq_timer_on, 0);
+	timer_setup(&fq_domain->fq_timer, fq_flush_timeout, 0);
+	atomic_set(&fq_domain->fq_timer_on, 0);
 
 	return 0;
 }
@@ -568,9 +567,9 @@ static inline unsigned fq_ring_add(struct iova_fq *fq)
 	return idx;
 }
 
-static void fq_ring_free(struct iova_domain *iovad, struct iova_fq *fq)
+static void fq_ring_free(struct fq_domain *fq_domain, struct iova_fq *fq)
 {
-	u64 counter = atomic64_read(&iovad->fq_flush_finish_cnt);
+	u64 counter = atomic64_read(&fq_domain->fq_flush_finish_cnt);
 	unsigned idx;
 
 	assert_spin_locked(&fq->lock);
@@ -580,10 +579,10 @@ static void fq_ring_free(struct iova_domain *iovad, struct iova_fq *fq)
 		if (fq->entries[idx].counter >= counter)
 			break;
 
-		if (iovad->entry_dtor)
-			iovad->entry_dtor(fq->entries[idx].data);
+		if (fq_domain->entry_dtor)
+			fq_domain->entry_dtor(fq->entries[idx].data);
 
-		free_iova_fast(iovad,
+		free_iova_fast(fq_domain->iovad,
 			       fq->entries[idx].iova_pfn,
 			       fq->entries[idx].pages);
 
@@ -591,14 +590,14 @@ static void fq_ring_free(struct iova_domain *iovad, struct iova_fq *fq)
 	}
 }
 
-static void iova_domain_flush(struct iova_domain *iovad)
+static void iova_domain_flush(struct fq_domain *fq_domain)
 {
-	atomic64_inc(&iovad->fq_flush_start_cnt);
-	iovad->flush_cb(iovad);
-	atomic64_inc(&iovad->fq_flush_finish_cnt);
+	atomic64_inc(&fq_domain->fq_flush_start_cnt);
+	fq_domain->flush_cb(fq_domain);
+	atomic64_inc(&fq_domain->fq_flush_finish_cnt);
 }
 
-static void fq_destroy_all_entries(struct iova_domain *iovad)
+static void fq_destroy_all_entries(struct fq_domain *fq_domain)
 {
 	int cpu;
 
@@ -607,38 +606,38 @@ static void fq_destroy_all_entries(struct iova_domain *iovad)
 	 * bother to free iovas, just call the entry_dtor on all remaining
 	 * entries.
 	 */
-	if (!iovad->entry_dtor)
+	if (!fq_domain->entry_dtor)
 		return;
 
 	for_each_possible_cpu(cpu) {
-		struct iova_fq *fq = per_cpu_ptr(iovad->fq, cpu);
+		struct iova_fq *fq = per_cpu_ptr(fq_domain->fq, cpu);
 		int idx;
 
 		fq_ring_for_each(idx, fq)
-			iovad->entry_dtor(fq->entries[idx].data);
+			fq_domain->entry_dtor(fq->entries[idx].data);
 	}
 }
 
 static void fq_flush_timeout(struct timer_list *t)
 {
-	struct iova_domain *iovad = from_timer(iovad, t, fq_timer);
+	struct fq_domain *fq_domain = from_timer(fq_domain, t, fq_timer);
 	int cpu;
 
-	atomic_set(&iovad->fq_timer_on, 0);
-	iova_domain_flush(iovad);
+	atomic_set(&fq_domain->fq_timer_on, 0);
+	iova_domain_flush(fq_domain);
 
 	for_each_possible_cpu(cpu) {
 		unsigned long flags;
 		struct iova_fq *fq;
 
-		fq = per_cpu_ptr(iovad->fq, cpu);
+		fq = per_cpu_ptr(fq_domain->fq, cpu);
 		spin_lock_irqsave(&fq->lock, flags);
-		fq_ring_free(iovad, fq);
+		fq_ring_free(fq_domain, fq);
 		spin_unlock_irqrestore(&fq->lock, flags);
 	}
 }
 
-void queue_iova(struct iova_domain *iovad,
+void queue_iova(struct fq_domain *fq_domain,
 		unsigned long pfn, unsigned long pages,
 		unsigned long data)
 {
@@ -655,7 +654,7 @@ void queue_iova(struct iova_domain *iovad,
 	 */
 	smp_mb();
 
-	fq = raw_cpu_ptr(iovad->fq);
+	fq = raw_cpu_ptr(fq_domain->fq);
 	spin_lock_irqsave(&fq->lock, flags);
 
 	/*
@@ -663,11 +662,11 @@ void queue_iova(struct iova_domain *iovad,
 	 * flushed out on another CPU. This makes the fq_full() check below less
 	 * likely to be true.
 	 */
-	fq_ring_free(iovad, fq);
+	fq_ring_free(fq_domain, fq);
 
 	if (fq_full(fq)) {
-		iova_domain_flush(iovad);
-		fq_ring_free(iovad, fq);
+		iova_domain_flush(fq_domain);
+		fq_ring_free(fq_domain, fq);
 	}
 
 	idx = fq_ring_add(fq);
@@ -675,14 +674,14 @@ void queue_iova(struct iova_domain *iovad,
 	fq->entries[idx].iova_pfn = pfn;
 	fq->entries[idx].pages    = pages;
 	fq->entries[idx].data     = data;
-	fq->entries[idx].counter  = atomic64_read(&iovad->fq_flush_start_cnt);
+	fq->entries[idx].counter  = atomic64_read(&fq_domain->fq_flush_start_cnt);
 
 	spin_unlock_irqrestore(&fq->lock, flags);
 
 	/* Avoid false sharing as much as possible. */
-	if (!atomic_read(&iovad->fq_timer_on) &&
-	    !atomic_xchg(&iovad->fq_timer_on, 1))
-		mod_timer(&iovad->fq_timer,
+	if (!atomic_read(&fq_domain->fq_timer_on) &&
+	    !atomic_xchg(&fq_domain->fq_timer_on, 1))
+		mod_timer(&fq_domain->fq_timer,
 			  jiffies + msecs_to_jiffies(IOVA_FQ_TIMEOUT));
 }
 
@@ -698,7 +697,6 @@ void put_iova_domain(struct iova_domain *iovad)
 	cpuhp_state_remove_instance_nocalls(CPUHP_IOMMU_IOVA_DEAD,
 					    &iovad->cpuhp_dead);
 
-	free_iova_flush_queue(iovad);
 	free_iova_rcaches(iovad);
 	rbtree_postorder_for_each_entry_safe(iova, tmp, &iovad->rbroot, node)
 		free_iova_mem(iova);
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 71d8a2de6635..4975b65ab810 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -36,12 +36,13 @@ struct iova_rcache {
 };
 
 struct iova_domain;
+struct fq_domain;
 
 /* Call-Back from IOVA code into IOMMU drivers */
-typedef void (* iova_flush_cb)(struct iova_domain *domain);
+typedef void (*iova_flush_cb)(struct fq_domain *fq_domain);
 
 /* Destructor for per-entry data */
-typedef void (* iova_entry_dtor)(unsigned long data);
+typedef void (*iova_entry_dtor)(unsigned long data);
 
 /* Number of entries per Flush Queue */
 #define IOVA_FQ_SIZE	256
@@ -74,6 +75,12 @@ struct iova_domain {
 	unsigned long	start_pfn;	/* Lower limit for this domain */
 	unsigned long	dma_32bit_pfn;
 	unsigned long	max32_alloc_size; /* Size of last failed allocation */
+	struct iova	anchor;		/* rbtree lookup anchor */
+	struct iova_rcache rcaches[IOVA_RANGE_CACHE_MAX_SIZE];	/* IOVA range caches */
+	struct hlist_node	cpuhp_dead;
+};
+
+struct fq_domain {
 	struct iova_fq __percpu *fq;	/* Flush Queue */
 
 	atomic64_t	fq_flush_start_cnt;	/* Number of TLB flushes that
@@ -82,9 +89,6 @@ struct iova_domain {
 	atomic64_t	fq_flush_finish_cnt;	/* Number of TLB flushes that
 						   have been finished */
 
-	struct iova	anchor;		/* rbtree lookup anchor */
-	struct iova_rcache rcaches[IOVA_RANGE_CACHE_MAX_SIZE];	/* IOVA range caches */
-
 	iova_flush_cb	flush_cb;	/* Call-Back function to flush IOMMU
 					   TLBs */
 
@@ -95,7 +99,7 @@ struct iova_domain {
 						   flush-queues */
 	atomic_t fq_timer_on;			/* 1 when timer is active, 0
 						   when not */
-	struct hlist_node	cpuhp_dead;
+	struct iova_domain *iovad;
 };
 
 static inline unsigned long iova_size(struct iova *iova)
@@ -144,7 +148,7 @@ struct iova *alloc_iova(struct iova_domain *iovad, unsigned long size,
 	bool size_aligned);
 void free_iova_fast(struct iova_domain *iovad, unsigned long pfn,
 		    unsigned long size);
-void queue_iova(struct iova_domain *iovad,
+void queue_iova(struct fq_domain *fq_domain,
 		unsigned long pfn, unsigned long pages,
 		unsigned long data);
 unsigned long alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
@@ -153,8 +157,10 @@ struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
 	unsigned long pfn_hi);
 void init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	unsigned long start_pfn);
-int init_iova_flush_queue(struct iova_domain *iovad,
+int init_iova_flush_queue(struct fq_domain *fq_domain,
 			  iova_flush_cb flush_cb, iova_entry_dtor entry_dtor);
+void iova_free_flush_queue(struct fq_domain *fq_domain);
+
 struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
 void put_iova_domain(struct iova_domain *iovad);
 #else
@@ -189,7 +195,7 @@ static inline void free_iova_fast(struct iova_domain *iovad,
 {
 }
 
-static inline void queue_iova(struct iova_domain *iovad,
+static inline void queue_iova(struct fq_domain *fq_domain,
 			      unsigned long pfn, unsigned long pages,
 			      unsigned long data)
 {
@@ -216,13 +222,17 @@ static inline void init_iova_domain(struct iova_domain *iovad,
 {
 }
 
-static inline int init_iova_flush_queue(struct iova_domain *iovad,
+static inline int init_iova_flush_queue(struct fq_domain *fq_domain,
 					iova_flush_cb flush_cb,
 					iova_entry_dtor entry_dtor)
 {
 	return -ENODEV;
 }
 
+static inline void iova_free_flush_queue(struct fq_domain *fq_domain)
+{
+}
+
 static inline struct iova *find_iova(struct iova_domain *iovad,
 				     unsigned long pfn)
 {
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
