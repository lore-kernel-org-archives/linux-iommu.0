From: Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: [PATCH] iommu/iova: Separate atomic variables to improve performance
Date: Wed, 3 Apr 2019 16:35:21 +0800
Message-ID: <1554280521-18375-1-git-send-email-zhangshaokun@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Jinyu Qi <jinyuqi@huawei.com>, Joerg Roedel <joro@8bytes.org>
List-Id: iommu@lists.linux-foundation.org

From: Jinyu Qi <jinyuqi@huawei.com> 

In struct iova_domain, there are three atomic variables, the former two
are about TLB flush counters which use atomic_add operation, anoter is
used to flush timer that use cmpxhg operation.
These variables are in the same cache line, so it will cause some
performance loss under the condition that many cores call queue_iova
function, Let's isolate the two type atomic variables to different
cache line to reduce cache line conflict.

Cc: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Jinyu Qi <jinyuqi@huawei.com>
---
 include/linux/iova.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/iova.h b/include/linux/iova.h
index 0b93bf96693e..28a5128405f8 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -76,6 +76,14 @@ struct iova_domain {
 	unsigned long	start_pfn;	/* Lower limit for this domain */
 	unsigned long	dma_32bit_pfn;
 	unsigned long	max32_alloc_size; /* Size of last failed allocation */
+	struct iova_fq __percpu *fq;	/* Flush Queue */
+
+	atomic64_t	fq_flush_start_cnt;	/* Number of TLB flushes that
+						   have been started */
+
+	atomic64_t	fq_flush_finish_cnt;	/* Number of TLB flushes that
+						   have been finished */
+
 	struct iova	anchor;		/* rbtree lookup anchor */
 	struct iova_rcache rcaches[IOVA_RANGE_CACHE_MAX_SIZE];	/* IOVA range caches */
 
@@ -85,14 +93,6 @@ struct iova_domain {
 	iova_entry_dtor entry_dtor;	/* IOMMU driver specific destructor for
 					   iova entry */
 
-	struct iova_fq __percpu *fq;	/* Flush Queue */
-
-	atomic64_t	fq_flush_start_cnt;	/* Number of TLB flushes that
-						   have been started */
-
-	atomic64_t	fq_flush_finish_cnt;	/* Number of TLB flushes that
-						   have been finished */
-
 	struct timer_list fq_timer;		/* Timer to regularily empty the
 						   flush-queues */
 	atomic_t fq_timer_on;			/* 1 when timer is active, 0
-- 
2.7.4
