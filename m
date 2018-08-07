From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Subject: [PATCH] iommu/iova: Optimise attempts to allocate iova from 32bit address range
Date: Tue,  7 Aug 2018 14:24:37 +0530
Message-ID: <20180807085437.15965-1-ganapatrao.kulkarni@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, robin.murphy@arm.com
Cc: tomasz.nowicki@cavium.com, jnair@caviumnetworks.com, Robert.Richter@cavium.com, Vadim.Lomovtsev@cavium.com, Jan.Glauber@cavium.com, gklkml16@gmail.com
List-Id: iommu@lists.linux-foundation.org

As an optimisation for PCI devices, there is always first attempt
been made to allocate iova from SAC address range. This will lead
to unnecessary attempts/function calls, when there are no free ranges
available.

This patch optimises by adding flag to track previous failed attempts
and avoids further attempts until replenish happens.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
---
This patch is based on comments from Robin Murphy <robin.murphy@arm.com>
for patch [1]

[1] https://lkml.org/lkml/2018/4/19/780

 drivers/iommu/iova.c | 11 ++++++++++-
 include/linux/iova.h |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 83fe262..d97bb5a 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -56,6 +56,7 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	iovad->granule = granule;
 	iovad->start_pfn = start_pfn;
 	iovad->dma_32bit_pfn = 1UL << (32 - iova_shift(iovad));
+	iovad->free_32bit_pfns = true;
 	iovad->flush_cb = NULL;
 	iovad->fq = NULL;
 	iovad->anchor.pfn_lo = iovad->anchor.pfn_hi = IOVA_ANCHOR;
@@ -139,8 +140,10 @@ __cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free)
 
 	cached_iova = rb_entry(iovad->cached32_node, struct iova, node);
 	if (free->pfn_hi < iovad->dma_32bit_pfn &&
-	    free->pfn_lo >= cached_iova->pfn_lo)
+	    free->pfn_lo >= cached_iova->pfn_lo) {
 		iovad->cached32_node = rb_next(&free->node);
+		iovad->free_32bit_pfns = true;
+	}
 
 	cached_iova = rb_entry(iovad->cached_node, struct iova, node);
 	if (free->pfn_lo >= cached_iova->pfn_lo)
@@ -290,6 +293,10 @@ alloc_iova(struct iova_domain *iovad, unsigned long size,
 	struct iova *new_iova;
 	int ret;
 
+	if (limit_pfn <= iovad->dma_32bit_pfn &&
+			!iovad->free_32bit_pfns)
+		return NULL;
+
 	new_iova = alloc_iova_mem();
 	if (!new_iova)
 		return NULL;
@@ -299,6 +306,8 @@ alloc_iova(struct iova_domain *iovad, unsigned long size,
 
 	if (ret) {
 		free_iova_mem(new_iova);
+		if (limit_pfn <= iovad->dma_32bit_pfn)
+			iovad->free_32bit_pfns = false;
 		return NULL;
 	}
 
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 928442d..3810ba9 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -96,6 +96,7 @@ struct iova_domain {
 						   flush-queues */
 	atomic_t fq_timer_on;			/* 1 when timer is active, 0
 						   when not */
+	bool	free_32bit_pfns;
 };
 
 static inline unsigned long iova_size(struct iova *iova)
-- 
2.9.4
