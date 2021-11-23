Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE769C433F5
	for <iommu@archiver.kernel.org>; Tue, 23 Nov 2021 14:11:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F98C40385;
	Tue, 23 Nov 2021 14:11:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2vzS3XsqHd06; Tue, 23 Nov 2021 14:11:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3599640275;
	Tue, 23 Nov 2021 14:11:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F0ACC002E;
	Tue, 23 Nov 2021 14:11:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2502EC003C
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 14:10:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 21DD360727
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 14:10:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hrVUYHJtbE_4 for <iommu@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 14:10:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 49FF3606F2
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 14:10:58 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9678147A;
 Tue, 23 Nov 2021 06:10:57 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8B2643F66F;
 Tue, 23 Nov 2021 06:10:56 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH 3/9] iommu/iova: Squash flush_cb abstraction
Date: Tue, 23 Nov 2021 14:10:38 +0000
Message-Id: <2cb94bc3bd04fb24a1f92d5c192744801c5dcda2.1637671820.git.robin.murphy@arm.com>
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

Once again, with iommu-dma now being the only flush queue user, we no
longer need the extra level of indirection through flush_cb. Squash that
and let the flush queue code call the domain method directly.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 13 +------------
 drivers/iommu/iova.c      | 11 +++++------
 include/linux/iova.h      | 11 +++--------
 3 files changed, 9 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index fa21b9141b71..cde887530549 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -282,17 +282,6 @@ static int iova_reserve_iommu_regions(struct device *dev,
 	return ret;
 }
 
-static void iommu_dma_flush_iotlb_all(struct iova_domain *iovad)
-{
-	struct iommu_dma_cookie *cookie;
-	struct iommu_domain *domain;
-
-	cookie = container_of(iovad, struct iommu_dma_cookie, iovad);
-	domain = cookie->fq_domain;
-
-	domain->ops->flush_iotlb_all(domain);
-}
-
 static bool dev_is_untrusted(struct device *dev)
 {
 	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
@@ -312,7 +301,7 @@ int iommu_dma_init_fq(struct iommu_domain *domain)
 	if (cookie->fq_domain)
 		return 0;
 
-	ret = init_iova_flush_queue(&cookie->iovad, iommu_dma_flush_iotlb_all);
+	ret = init_iova_flush_queue(&cookie->iovad, domain);
 	if (ret) {
 		pr_warn("iova flush queue initialization failed\n");
 		return ret;
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 982e2779b981..7619ccb726cc 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -63,7 +63,7 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	iovad->start_pfn = start_pfn;
 	iovad->dma_32bit_pfn = 1UL << (32 - iova_shift(iovad));
 	iovad->max32_alloc_size = iovad->dma_32bit_pfn;
-	iovad->flush_cb = NULL;
+	iovad->fq_domain = NULL;
 	iovad->fq = NULL;
 	iovad->anchor.pfn_lo = iovad->anchor.pfn_hi = IOVA_ANCHOR;
 	rb_link_node(&iovad->anchor.node, NULL, &iovad->rbroot.rb_node);
@@ -91,10 +91,10 @@ static void free_iova_flush_queue(struct iova_domain *iovad)
 	free_percpu(iovad->fq);
 
 	iovad->fq         = NULL;
-	iovad->flush_cb   = NULL;
+	iovad->fq_domain  = NULL;
 }
 
-int init_iova_flush_queue(struct iova_domain *iovad, iova_flush_cb flush_cb)
+int init_iova_flush_queue(struct iova_domain *iovad, struct iommu_domain *fq_domain)
 {
 	struct iova_fq __percpu *queue;
 	int cpu;
@@ -106,8 +106,6 @@ int init_iova_flush_queue(struct iova_domain *iovad, iova_flush_cb flush_cb)
 	if (!queue)
 		return -ENOMEM;
 
-	iovad->flush_cb   = flush_cb;
-
 	for_each_possible_cpu(cpu) {
 		struct iova_fq *fq;
 
@@ -118,6 +116,7 @@ int init_iova_flush_queue(struct iova_domain *iovad, iova_flush_cb flush_cb)
 		spin_lock_init(&fq->lock);
 	}
 
+	iovad->fq_domain = fq_domain;
 	iovad->fq = queue;
 
 	timer_setup(&iovad->fq_timer, fq_flush_timeout, 0);
@@ -590,7 +589,7 @@ static void fq_ring_free(struct iova_domain *iovad, struct iova_fq *fq)
 static void iova_domain_flush(struct iova_domain *iovad)
 {
 	atomic64_inc(&iovad->fq_flush_start_cnt);
-	iovad->flush_cb(iovad);
+	iovad->fq_domain->ops->flush_iotlb_all(iovad->fq_domain);
 	atomic64_inc(&iovad->fq_flush_finish_cnt);
 }
 
diff --git a/include/linux/iova.h b/include/linux/iova.h
index e746d8e41449..99be4fcea4f3 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -14,6 +14,7 @@
 #include <linux/rbtree.h>
 #include <linux/atomic.h>
 #include <linux/dma-mapping.h>
+#include <linux/iommu.h>
 
 /* iova structure */
 struct iova {
@@ -35,11 +36,6 @@ struct iova_rcache {
 	struct iova_cpu_rcache __percpu *cpu_rcaches;
 };
 
-struct iova_domain;
-
-/* Call-Back from IOVA code into IOMMU drivers */
-typedef void (* iova_flush_cb)(struct iova_domain *domain);
-
 /* Number of entries per Flush Queue */
 #define IOVA_FQ_SIZE	256
 
@@ -82,8 +78,7 @@ struct iova_domain {
 	struct iova	anchor;		/* rbtree lookup anchor */
 	struct iova_rcache rcaches[IOVA_RANGE_CACHE_MAX_SIZE];	/* IOVA range caches */
 
-	iova_flush_cb	flush_cb;	/* Call-Back function to flush IOMMU
-					   TLBs */
+	struct iommu_domain *fq_domain;
 
 	struct timer_list fq_timer;		/* Timer to regularily empty the
 						   flush-queues */
@@ -147,7 +142,7 @@ struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
 	unsigned long pfn_hi);
 void init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	unsigned long start_pfn);
-int init_iova_flush_queue(struct iova_domain *iovad, iova_flush_cb flush_cb);
+int init_iova_flush_queue(struct iova_domain *iovad, struct iommu_domain *fq_domain);
 struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
 void put_iova_domain(struct iova_domain *iovad);
 #else
-- 
2.28.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
