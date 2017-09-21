From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v5 5/6] iommu/iova: Add rbtree anchor node
Date: Thu, 21 Sep 2017 16:52:46 +0100
Message-ID: <2d78b05d4fa2beed3fe7f1b4e91370d982a29aac.1506007392.git.robin.murphy@arm.com>
References: <cover.1506007392.git.robin.murphy@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1506007392.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, thunder.leizhen@huawei.com, nwatters@codeaurora.org, tomasz.nowicki@caviumnetworks.com, dwoods@mellanox.com, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Add a permanent dummy IOVA reservation to the rbtree, such that we can
always access the top of the address space instantly. The immediate
benefit is that we remove the overhead of the rb_last() traversal when
not using the cached node, but it also paves the way for further
simplifications.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v5: No change

 drivers/iommu/iova.c | 15 +++++++++++++--
 include/linux/iova.h |  1 +
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 65032e60a5d1..9e04c1f3e740 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -24,6 +24,9 @@
 #include <linux/bitops.h>
 #include <linux/cpu.h>
 
+/* The anchor node sits above the top of the usable address space */
+#define IOVA_ANCHOR	~0UL
+
 static bool iova_rcache_insert(struct iova_domain *iovad,
 			       unsigned long pfn,
 			       unsigned long size);
@@ -55,6 +58,9 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	iovad->dma_32bit_pfn = 1UL << (32 - iova_shift(iovad));
 	iovad->flush_cb = NULL;
 	iovad->fq = NULL;
+	iovad->anchor.pfn_lo = iovad->anchor.pfn_hi = IOVA_ANCHOR;
+	rb_link_node(&iovad->anchor.node, NULL, &iovad->rbroot.rb_node);
+	rb_insert_color(&iovad->anchor.node, &iovad->rbroot);
 	init_iova_rcaches(iovad);
 }
 EXPORT_SYMBOL_GPL(init_iova_domain);
@@ -119,7 +125,7 @@ __get_cached_rbnode(struct iova_domain *iovad, unsigned long *limit_pfn)
 	if (!cached_node)
 		cached_node = iovad->cached_node;
 	if (!cached_node)
-		return rb_last(&iovad->rbroot);
+		return rb_prev(&iovad->anchor.node);
 
 	curr_iova = rb_entry(cached_node, struct iova, node);
 	*limit_pfn = min(*limit_pfn, curr_iova->pfn_lo);
@@ -242,7 +248,8 @@ EXPORT_SYMBOL(alloc_iova_mem);
 
 void free_iova_mem(struct iova *iova)
 {
-	kmem_cache_free(iova_cache, iova);
+	if (iova->pfn_lo != IOVA_ANCHOR)
+		kmem_cache_free(iova_cache, iova);
 }
 EXPORT_SYMBOL(free_iova_mem);
 
@@ -676,6 +683,10 @@ reserve_iova(struct iova_domain *iovad,
 	struct iova *iova;
 	unsigned int overlap = 0;
 
+	/* Don't allow nonsensical pfns */
+	if (WARN_ON((pfn_hi | pfn_lo) > (ULLONG_MAX >> iova_shift(iovad))))
+		return NULL;
+
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
 	for (node = rb_first(&iovad->rbroot); node; node = rb_next(node)) {
 		if (__is_range_overlap(node, pfn_lo, pfn_hi)) {
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 953cfd20f152..c696ee81054e 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -75,6 +75,7 @@ struct iova_domain {
 	unsigned long	granule;	/* pfn granularity for this domain */
 	unsigned long	start_pfn;	/* Lower limit for this domain */
 	unsigned long	dma_32bit_pfn;
+	struct iova	anchor;		/* rbtree lookup anchor */
 	struct iova_rcache rcaches[IOVA_RANGE_CACHE_MAX_SIZE];	/* IOVA range caches */
 
 	iova_flush_cb	flush_cb;	/* Call-Back function to flush IOMMU
-- 
2.13.4.dirty
