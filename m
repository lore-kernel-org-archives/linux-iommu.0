From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v4 3/6] iommu/iova: Add rbtree anchor node
Date: Tue, 19 Sep 2017 17:31:54 +0100
Message-ID: <46313121569c2a386d4c918db4dd85cbf0e1f629.1505829018.git.robin.murphy@arm.com>
References: <cover.1505829018.git.robin.murphy@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1505829018.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, thunder.leizhen@huawei.com, nwatters@codeaurora.org, tomasz.nowicki@caviumnetworks.com, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Add a permanent dummy IOVA reservation to the rbtree, such that we can
always access the top of the address space instantly. The immediate
benefit is that we remove the overhead of the rb_last() traversal when
not using the cached node, but it also paves the way for further
simplifications.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v4: New

 drivers/iommu/iova.c | 15 +++++++++++++--
 include/linux/iova.h |  1 +
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 20be9a8b3188..03b677afb109 100644
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
@@ -54,6 +57,9 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	iovad->dma_32bit_pfn = pfn_32bit + 1;
 	iovad->flush_cb = NULL;
 	iovad->fq = NULL;
+	iovad->anchor.pfn_lo = iovad->anchor.pfn_hi = IOVA_ANCHOR;
+	rb_link_node(&iovad->anchor.node, NULL, &iovad->rbroot.rb_node);
+	rb_insert_color(&iovad->anchor.node, &iovad->rbroot);
 	init_iova_rcaches(iovad);
 }
 EXPORT_SYMBOL_GPL(init_iova_domain);
@@ -112,7 +118,7 @@ __get_cached_rbnode(struct iova_domain *iovad, unsigned long *limit_pfn)
 {
 	if ((*limit_pfn > iovad->dma_32bit_pfn) ||
 		(iovad->cached32_node == NULL))
-		return rb_last(&iovad->rbroot);
+		return rb_prev(&iovad->anchor.node);
 	else {
 		struct rb_node *prev_node = rb_prev(iovad->cached32_node);
 		struct iova *curr_iova =
@@ -246,7 +252,8 @@ EXPORT_SYMBOL(alloc_iova_mem);
 
 void free_iova_mem(struct iova *iova)
 {
-	kmem_cache_free(iova_cache, iova);
+	if (iova->pfn_lo != IOVA_ANCHOR)
+		kmem_cache_free(iova_cache, iova);
 }
 EXPORT_SYMBOL(free_iova_mem);
 
@@ -680,6 +687,10 @@ reserve_iova(struct iova_domain *iovad,
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
index d179b9bf7814..22dc30a28387 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -74,6 +74,7 @@ struct iova_domain {
 	unsigned long	granule;	/* pfn granularity for this domain */
 	unsigned long	start_pfn;	/* Lower limit for this domain */
 	unsigned long	dma_32bit_pfn;
+	struct iova	anchor;		/* rbtree lookup anchor */
 	struct iova_rcache rcaches[IOVA_RANGE_CACHE_MAX_SIZE];	/* IOVA range caches */
 
 	iova_flush_cb	flush_cb;	/* Call-Back function to flush IOMMU
-- 
2.13.4.dirty
