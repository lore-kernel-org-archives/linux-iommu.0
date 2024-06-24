Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B1549656
	for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 08:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719219066; cv=none; b=KU/bgtGPRZLMEUETJ6yZiTYCKlih74D/dvuKWSv/ccgSiM/YIYyewdDTSW/3vfNvHSodTd1PS2lvYsQZEpR6NxSBqxL2X2w7KBx/7jR18WIiVUl7DzocZAMhwyxiqQWe12/O3pt5LfqqwwPO0reSxBY4bNyBjTaEFS6NQJFcA+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719219066; c=relaxed/simple;
	bh=ka4gIJJHm53QZt1MhqOj80xQuE+i2CksGMCkJZ478ZQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CFW/3W8TsF9yIg0kR/geqX0J4y0ONU37NgfCisv1gm0zan/AQKqc72qmAXSP0F32gPLxaDZMhwErlk6HbMwQ1kWmf4SemzrRzr+O7uc4ma23CXtmHOpgQVkPVfzRntG/FoRHk5IZ73bOUx/ZIENKqy30XsAq6yPFsnXH7fI2vaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4W71lz2kMbz1SDX3;
	Mon, 24 Jun 2024 16:46:39 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id B56BB18007C;
	Mon, 24 Jun 2024 16:51:00 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 24 Jun
 2024 16:50:59 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
	<john.g.garry@oracle.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<zhangzekun11@huawei.com>
Subject: [PATCH] iommu/iova: Bettering utilizing cpu_rcaches in no-strict mode
Date: Mon, 24 Jun 2024 16:39:52 +0800
Message-ID: <20240624083952.52612-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf500003.china.huawei.com (7.202.181.241)

Currently, when iommu working in no-strict mode, fq_flush_timeout()
will always try to free iovas on one cpu. Freeing the iovas from all
cpus on one cpu is not cache-friendly to iova_rcache, because it will
first filling up the cpu_rcache and then pushing iovas to the depot,
iovas in the depot will finally goto the underlying rbtree if the
depot_size is greater than num_online_cpus(). Let fq_flush_timeout()
freeing iovas on cpus who call dma_unmap* APIs, can decrease the overall
time caused by fq_flush_timeout() by better utilizing the iova_rcache,
and minimizing the competition for the iova_rbtree_lock().

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/iommu/dma-iommu.c | 22 +++++++++++++---------
 drivers/iommu/iova.c      | 21 ++++++++++++++-------
 include/linux/iova.h      |  7 +++++++
 3 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 43520e7275cc..217b7c70d06c 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -145,7 +145,8 @@ static inline unsigned int fq_ring_add(struct iova_fq *fq)
 	return idx;
 }
 
-static void fq_ring_free_locked(struct iommu_dma_cookie *cookie, struct iova_fq *fq)
+static void fq_ring_free_locked(struct iommu_dma_cookie *cookie, struct iova_fq *fq,
+				int cpu)
 {
 	u64 counter = atomic64_read(&cookie->fq_flush_finish_cnt);
 	unsigned int idx;
@@ -158,20 +159,21 @@ static void fq_ring_free_locked(struct iommu_dma_cookie *cookie, struct iova_fq
 			break;
 
 		iommu_put_pages_list(&fq->entries[idx].freelist);
-		free_iova_fast(&cookie->iovad,
+		free_iova_fast_cpu(&cookie->iovad,
 			       fq->entries[idx].iova_pfn,
-			       fq->entries[idx].pages);
+			       fq->entries[idx].pages, cpu);
 
 		fq->head = (fq->head + 1) & fq->mod_mask;
 	}
 }
 
-static void fq_ring_free(struct iommu_dma_cookie *cookie, struct iova_fq *fq)
+static void fq_ring_free(struct iommu_dma_cookie *cookie, struct iova_fq *fq,
+			 int cpu)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&fq->lock, flags);
-	fq_ring_free_locked(cookie, fq);
+	fq_ring_free_locked(cookie, fq, cpu);
 	spin_unlock_irqrestore(&fq->lock, flags);
 }
 
@@ -191,10 +193,11 @@ static void fq_flush_timeout(struct timer_list *t)
 	fq_flush_iotlb(cookie);
 
 	if (cookie->options.qt == IOMMU_DMA_OPTS_SINGLE_QUEUE) {
-		fq_ring_free(cookie, cookie->single_fq);
+		cpu = smp_processor_id();
+		fq_ring_free(cookie, cookie->single_fq, cpu);
 	} else {
 		for_each_possible_cpu(cpu)
-			fq_ring_free(cookie, per_cpu_ptr(cookie->percpu_fq, cpu));
+			fq_ring_free(cookie, per_cpu_ptr(cookie->percpu_fq, cpu), cpu);
 	}
 }
 
@@ -205,6 +208,7 @@ static void queue_iova(struct iommu_dma_cookie *cookie,
 	struct iova_fq *fq;
 	unsigned long flags;
 	unsigned int idx;
+	int cpu = smp_processor_id();
 
 	/*
 	 * Order against the IOMMU driver's pagetable update from unmapping
@@ -227,11 +231,11 @@ static void queue_iova(struct iommu_dma_cookie *cookie,
 	 * flushed out on another CPU. This makes the fq_full() check below less
 	 * likely to be true.
 	 */
-	fq_ring_free_locked(cookie, fq);
+	fq_ring_free_locked(cookie, fq, cpu);
 
 	if (fq_full(fq)) {
 		fq_flush_iotlb(cookie);
-		fq_ring_free_locked(cookie, fq);
+		fq_ring_free_locked(cookie, fq, cpu);
 	}
 
 	idx = fq_ring_add(fq);
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index d59d0ea2fd21..46a2188c263b 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -20,7 +20,7 @@
 
 static bool iova_rcache_insert(struct iova_domain *iovad,
 			       unsigned long pfn,
-			       unsigned long size);
+			       unsigned long size, int cpu);
 static unsigned long iova_rcache_get(struct iova_domain *iovad,
 				     unsigned long size,
 				     unsigned long limit_pfn);
@@ -423,12 +423,19 @@ EXPORT_SYMBOL_GPL(alloc_iova_fast);
 void
 free_iova_fast(struct iova_domain *iovad, unsigned long pfn, unsigned long size)
 {
-	if (iova_rcache_insert(iovad, pfn, size))
+	free_iova_fast_cpu(iovad, pfn, size, smp_processor_id());
+}
+EXPORT_SYMBOL_GPL(free_iova_fast);
+
+void
+free_iova_fast_cpu(struct iova_domain *iovad, unsigned long pfn,
+		   unsigned long size, int cpu)
+{
+	if (iova_rcache_insert(iovad, pfn, size, cpu))
 		return;
 
 	free_iova(iovad, pfn);
 }
-EXPORT_SYMBOL_GPL(free_iova_fast);
 
 static void iova_domain_free_rcaches(struct iova_domain *iovad)
 {
@@ -762,13 +769,13 @@ EXPORT_SYMBOL_GPL(iova_domain_init_rcaches);
  */
 static bool __iova_rcache_insert(struct iova_domain *iovad,
 				 struct iova_rcache *rcache,
-				 unsigned long iova_pfn)
+				 unsigned long iova_pfn, int cpu)
 {
 	struct iova_cpu_rcache *cpu_rcache;
 	bool can_insert = false;
 	unsigned long flags;
 
-	cpu_rcache = raw_cpu_ptr(rcache->cpu_rcaches);
+	cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
 	spin_lock_irqsave(&cpu_rcache->lock, flags);
 
 	if (!iova_magazine_full(cpu_rcache->loaded)) {
@@ -799,14 +806,14 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
 }
 
 static bool iova_rcache_insert(struct iova_domain *iovad, unsigned long pfn,
-			       unsigned long size)
+			       unsigned long size, int cpu)
 {
 	unsigned int log_size = order_base_2(size);
 
 	if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE)
 		return false;
 
-	return __iova_rcache_insert(iovad, &iovad->rcaches[log_size], pfn);
+	return __iova_rcache_insert(iovad, &iovad->rcaches[log_size], pfn, cpu);
 }
 
 /*
diff --git a/include/linux/iova.h b/include/linux/iova.h
index d2c4fd923efa..91e4e3d5bcb3 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -93,6 +93,8 @@ struct iova *alloc_iova(struct iova_domain *iovad, unsigned long size,
 	bool size_aligned);
 void free_iova_fast(struct iova_domain *iovad, unsigned long pfn,
 		    unsigned long size);
+void free_iova_fast_cpu(struct iova_domain *iovad, unsigned long pfn,
+			unsigned long size, int cpu);
 unsigned long alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
 			      unsigned long limit_pfn, bool flush_rcache);
 struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
@@ -134,6 +136,11 @@ static inline void free_iova_fast(struct iova_domain *iovad,
 {
 }
 
+static inline void free_iova_fast_cpu(struct iova_domain *iovad, unsigned long pfn,
+				      unsigned long size, int cpu);
+{
+}
+
 static inline unsigned long alloc_iova_fast(struct iova_domain *iovad,
 					    unsigned long size,
 					    unsigned long limit_pfn,
-- 
2.17.1

