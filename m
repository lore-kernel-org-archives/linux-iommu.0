Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C4EC4708F
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 14:34:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E7F66124B
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 14:34:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E7F66124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 173964028C;
	Tue,  1 Jun 2021 14:34:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EepBaB52TSH0; Tue,  1 Jun 2021 14:34:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id C49474028D;
	Tue,  1 Jun 2021 14:34:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE1AEC000D;
	Tue,  1 Jun 2021 14:34:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8AF2CC0001
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 14:34:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6102040281
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 14:34:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X8S3QSTWt7xh for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 14:34:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E31EC402B9
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 14:34:15 +0000 (UTC)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FvZ9D3HfQz6M4Jc;
 Tue,  1 Jun 2021 22:21:52 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 16:34:14 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 15:34:11 +0100
From: John Garry <john.garry@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
Subject: [PATCH v3 2/7] iova: Allow rcache range upper limit to be flexible
Date: Tue, 1 Jun 2021 22:29:36 +0800
Message-ID: <1622557781-211697-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1622557781-211697-1-git-send-email-john.garry@huawei.com>
References: <1622557781-211697-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org
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

Some LLDs may request DMA mappings whose IOVA length exceeds that of the
current rcache upper limit.

This means that allocations for those IOVAs will never be cached, and
always must be allocated and freed from the RB tree per DMA mapping cycle.
This has a significant affect on performance, more so since commit
4e89dce72521 ("iommu/iova: Retry from last rb tree node if iova search
fails"), as discussed at [0].

As a first step towards allowing the rcache range upper limit be
configured, hold this value in the IOVA rcache structure, and allocate
the rcaches separately.

[0] https://lore.kernel.org/linux-iommu/20210129092120.1482-1-thunder.leizhen@huawei.com/

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/dma-iommu.c |  2 +-
 drivers/iommu/iova.c      | 23 +++++++++++++++++------
 include/linux/iova.h      |  4 ++--
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 7bcdd1205535..f6d3302bb829 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -432,7 +432,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 	 * rounding up anything cacheable to make sure that can't happen. The
 	 * order of the unadjusted size will still match upon freeing.
 	 */
-	if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
+	if (iova_len < (1 << (iovad->rcache_max_size - 1)))
 		iova_len = roundup_pow_of_two(iova_len);
 
 	dma_limit = min_not_zero(dma_limit, dev->bus_dma_limit);
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index b7ecd5b08039..0e4c0e55178a 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -15,6 +15,8 @@
 /* The anchor node sits above the top of the usable address space */
 #define IOVA_ANCHOR	~0UL
 
+#define IOVA_RANGE_CACHE_MAX_SIZE 6    /* log of max cached IOVA range size (in pages) */
+
 static bool iova_rcache_insert(struct iova_domain *iovad,
 			       unsigned long pfn,
 			       unsigned long size);
@@ -877,7 +879,14 @@ static void init_iova_rcaches(struct iova_domain *iovad)
 	unsigned int cpu;
 	int i;
 
-	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
+	iovad->rcache_max_size = IOVA_RANGE_CACHE_MAX_SIZE;
+
+	iovad->rcaches = kcalloc(iovad->rcache_max_size,
+				 sizeof(*iovad->rcaches), GFP_KERNEL);
+	if (!iovad->rcaches)
+		return;
+
+	for (i = 0; i < iovad->rcache_max_size; ++i) {
 		rcache = &iovad->rcaches[i];
 		spin_lock_init(&rcache->lock);
 		rcache->depot_size = 0;
@@ -952,7 +961,7 @@ static bool iova_rcache_insert(struct iova_domain *iovad, unsigned long pfn,
 {
 	unsigned int log_size = order_base_2(size);
 
-	if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE)
+	if (log_size >= iovad->rcache_max_size)
 		return false;
 
 	return __iova_rcache_insert(iovad, &iovad->rcaches[log_size], pfn);
@@ -1008,7 +1017,7 @@ static unsigned long iova_rcache_get(struct iova_domain *iovad,
 {
 	unsigned int log_size = order_base_2(size);
 
-	if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE)
+	if (log_size >= iovad->rcache_max_size)
 		return 0;
 
 	return __iova_rcache_get(&iovad->rcaches[log_size], limit_pfn - size);
@@ -1024,7 +1033,7 @@ static void free_iova_rcaches(struct iova_domain *iovad)
 	unsigned int cpu;
 	int i, j;
 
-	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
+	for (i = 0; i < iovad->rcache_max_size; ++i) {
 		rcache = &iovad->rcaches[i];
 		for_each_possible_cpu(cpu) {
 			cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
@@ -1035,6 +1044,8 @@ static void free_iova_rcaches(struct iova_domain *iovad)
 		for (j = 0; j < rcache->depot_size; ++j)
 			iova_magazine_free(rcache->depot[j]);
 	}
+
+	kfree(iovad->rcaches);
 }
 
 /*
@@ -1047,7 +1058,7 @@ static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad)
 	unsigned long flags;
 	int i;
 
-	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
+	for (i = 0; i < iovad->rcache_max_size; ++i) {
 		rcache = &iovad->rcaches[i];
 		cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
 		spin_lock_irqsave(&cpu_rcache->lock, flags);
@@ -1066,7 +1077,7 @@ static void free_global_cached_iovas(struct iova_domain *iovad)
 	unsigned long flags;
 	int i, j;
 
-	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
+	for (i = 0; i < iovad->rcache_max_size; ++i) {
 		rcache = &iovad->rcaches[i];
 		spin_lock_irqsave(&rcache->lock, flags);
 		for (j = 0; j < rcache->depot_size; ++j) {
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 71d8a2de6635..9974e1d3e2bc 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -25,7 +25,6 @@ struct iova {
 struct iova_magazine;
 struct iova_cpu_rcache;
 
-#define IOVA_RANGE_CACHE_MAX_SIZE 6	/* log of max cached IOVA range size (in pages) */
 #define MAX_GLOBAL_MAGS 32	/* magazines per bin */
 
 struct iova_rcache {
@@ -74,6 +73,7 @@ struct iova_domain {
 	unsigned long	start_pfn;	/* Lower limit for this domain */
 	unsigned long	dma_32bit_pfn;
 	unsigned long	max32_alloc_size; /* Size of last failed allocation */
+	unsigned long	rcache_max_size; /* Upper limit of cached IOVA RANGE */
 	struct iova_fq __percpu *fq;	/* Flush Queue */
 
 	atomic64_t	fq_flush_start_cnt;	/* Number of TLB flushes that
@@ -83,7 +83,6 @@ struct iova_domain {
 						   have been finished */
 
 	struct iova	anchor;		/* rbtree lookup anchor */
-	struct iova_rcache rcaches[IOVA_RANGE_CACHE_MAX_SIZE];	/* IOVA range caches */
 
 	iova_flush_cb	flush_cb;	/* Call-Back function to flush IOMMU
 					   TLBs */
@@ -96,6 +95,7 @@ struct iova_domain {
 	atomic_t fq_timer_on;			/* 1 when timer is active, 0
 						   when not */
 	struct hlist_node	cpuhp_dead;
+	struct iova_rcache *rcaches;	/* IOVA range caches */
 };
 
 static inline unsigned long iova_size(struct iova *iova)
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
