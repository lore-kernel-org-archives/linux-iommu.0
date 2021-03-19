Return-Path: <SRS0=1/OX=IR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDECC433E9
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 13:30:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC5F464F3B
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 13:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC5F464F3B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 76A2A40132;
	Fri, 19 Mar 2021 13:30:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id totDnU5vIY1s; Fri, 19 Mar 2021 13:30:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id D766240136;
	Fri, 19 Mar 2021 13:30:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8BA8C0012;
	Fri, 19 Mar 2021 13:30:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48841C0001
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 13:30:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2852660712
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 13:30:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O9nL921_k07j for <iommu@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 13:30:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6EF3E60701
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 13:30:22 +0000 (UTC)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F24T25CSXzPk0h;
 Fri, 19 Mar 2021 21:27:50 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Fri, 19 Mar 2021 21:30:07 +0800
From: John Garry <john.garry@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>, <jejb@linux.ibm.com>,
 <martin.petersen@oracle.com>, <hch@lst.de>, <m.szyprowski@samsung.com>,
 <robin.murphy@arm.com>
Subject: [PATCH 3/6] iova: Allow rcache range upper limit to be configurable
Date: Fri, 19 Mar 2021 21:25:45 +0800
Message-ID: <1616160348-29451-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1616160348-29451-1-git-send-email-john.garry@huawei.com>
References: <1616160348-29451-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-scsi@vger.kernel.org, linuxarm@huawei.com
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
This has a significant effect on performance, more so since commit
4e89dce72521 ("iommu/iova: Retry from last rb tree node if iova search
fails"), as discussed at [0].

Allow the range of cached IOVAs to be increased, by providing an API to set
the upper limit, which is capped at IOVA_RANGE_CACHE_MAX_SIZE.

For simplicity, the full range of IOVA rcaches is allocated and initialized
at IOVA domain init time.

Setting the range upper limit will fail if the domain is already live
(before the tree contains IOVA nodes). This must be done to ensure any
IOVAs cached comply with rule of size being a power-of-2.

[0] https://lore.kernel.org/linux-iommu/20210129092120.1482-1-thunder.leizhen@huawei.com/

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/iova.c | 37 +++++++++++++++++++++++++++++++++++--
 include/linux/iova.h | 11 ++++++++++-
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index cecc74fb8663..d4f2f7fbbd84 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -49,6 +49,7 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	iovad->flush_cb = NULL;
 	iovad->fq = NULL;
 	iovad->anchor.pfn_lo = iovad->anchor.pfn_hi = IOVA_ANCHOR;
+	iovad->rcache_max_size = IOVA_RANGE_CACHE_DEFAULT_SIZE;
 	rb_link_node(&iovad->anchor.node, NULL, &iovad->rbroot.rb_node);
 	rb_insert_color(&iovad->anchor.node, &iovad->rbroot);
 	init_iova_rcaches(iovad);
@@ -194,7 +195,7 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 	 * rounding up anything cacheable to make sure that can't happen. The
 	 * order of the unadjusted size will still match upon freeing.
 	 */
-	if (fast && size < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
+	if (fast && size < (1 << (iovad->rcache_max_size - 1)))
 		size = roundup_pow_of_two(size);
 
 	if (size_aligned)
@@ -901,7 +902,7 @@ static bool iova_rcache_insert(struct iova_domain *iovad, unsigned long pfn,
 {
 	unsigned int log_size = order_base_2(size);
 
-	if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE)
+	if (log_size >= iovad->rcache_max_size)
 		return false;
 
 	return __iova_rcache_insert(iovad, &iovad->rcaches[log_size], pfn);
@@ -946,6 +947,38 @@ static unsigned long __iova_rcache_get(struct iova_rcache *rcache,
 	return iova_pfn;
 }
 
+void iova_rcache_set_upper_limit(struct iova_domain *iovad,
+				 unsigned long iova_len)
+{
+	unsigned int rcache_index = order_base_2(iova_len) + 1;
+	struct rb_node *rb_node = &iovad->anchor.node;
+	unsigned long flags;
+	int count = 0;
+
+	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
+	if (rcache_index <= iovad->rcache_max_size)
+		goto out;
+
+	while (1) {
+		rb_node = rb_prev(rb_node);
+		if (!rb_node)
+			break;
+		count++;
+	}
+
+	/*
+	 * If there are already IOVA nodes present in the tree, then don't
+	 * allow range upper limit to be set.
+	 */
+	if (count != iovad->reserved_node_count)
+		goto out;
+
+	iovad->rcache_max_size = min_t(unsigned long, rcache_index,
+				       IOVA_RANGE_CACHE_MAX_SIZE);
+out:
+	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
+}
+
 /*
  * Try to satisfy IOVA allocation range from rcache.  Fail if requested
  * size is too big or the DMA limit we are given isn't satisfied by the
diff --git a/include/linux/iova.h b/include/linux/iova.h
index fd3217a605b2..952b81b54ef7 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -25,7 +25,8 @@ struct iova {
 struct iova_magazine;
 struct iova_cpu_rcache;
 
-#define IOVA_RANGE_CACHE_MAX_SIZE 6	/* log of max cached IOVA range size (in pages) */
+#define IOVA_RANGE_CACHE_DEFAULT_SIZE 6
+#define IOVA_RANGE_CACHE_MAX_SIZE 10 /* log of max cached IOVA range size (in pages) */
 #define MAX_GLOBAL_MAGS 32	/* magazines per bin */
 
 struct iova_rcache {
@@ -74,6 +75,7 @@ struct iova_domain {
 	unsigned long	start_pfn;	/* Lower limit for this domain */
 	unsigned long	dma_32bit_pfn;
 	unsigned long	max32_alloc_size; /* Size of last failed allocation */
+	unsigned long	rcache_max_size; /* Upper limit of cached IOVA RANGE */
 	struct iova_fq __percpu *fq;	/* Flush Queue */
 
 	atomic64_t	fq_flush_start_cnt;	/* Number of TLB flushes that
@@ -158,6 +160,8 @@ int init_iova_flush_queue(struct iova_domain *iovad,
 struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
 void put_iova_domain(struct iova_domain *iovad);
 void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
+void iova_rcache_set_upper_limit(struct iova_domain *iovad,
+				 unsigned long iova_len);
 #else
 static inline int iova_cache_get(void)
 {
@@ -238,6 +242,11 @@ static inline void free_cpu_cached_iovas(unsigned int cpu,
 					 struct iova_domain *iovad)
 {
 }
+
+static inline void iova_rcache_set_upper_limit(struct iova_domain *iovad,
+					       unsigned long iova_len)
+{
+}
 #endif
 
 #endif
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
