From: Shaohua Li <shli-b10kYP2dOMg@public.gmane.org>
Subject: [PATCH V2 1/4] IOMMU: add a percpu cache for iova allocation
Date: Fri, 8 Jan 2016 16:44:46 -0800
Message-ID: <70737e183cb7b683ef355ed39a0cdaff5d6e9ce6.1452297604.git.shli@fb.com>
References: <cover.1452297604.git.shli@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1452297604.git.shli-b10kYP2dOMg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Kernel-team-b10kYP2dOMg@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This adds a percpu cache for small size iova allocation. For allocation
size is bigger than 64k, the cache is bypassed. The cache allows iova
allocation batched, so dramatically reduce iovad lock contention. In
test, the the lock contention becomes very tiny. The cache has 5 classes
of size (4k, 8k, 16k, 32k, 64k), each will cache 512K dma address. Each
cpu will cache 512k * 5 dma address at most. For an IOMMU system, the
cached dma address is quite tiny, so we don't bother draining cache for
CPU hotplug.

Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Shaohua Li <shli-b10kYP2dOMg@public.gmane.org>
---
 drivers/iommu/iova.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++-----
 include/linux/iova.h |  9 ++++++
 2 files changed, 89 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index fa0adef..5c86c5c 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -25,6 +25,7 @@ void
 init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	unsigned long start_pfn, unsigned long pfn_32bit)
 {
+	int cpu;
 	/*
 	 * IOVA granularity will normally be equal to the smallest
 	 * supported IOMMU page size; both *must* be capable of
@@ -38,6 +39,13 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	iovad->granule = granule;
 	iovad->start_pfn = start_pfn;
 	iovad->dma_32bit_pfn = pfn_32bit;
+	iovad->percpu_cache = alloc_percpu(struct iova_cache);
+	for_each_possible_cpu(cpu) {
+		struct iova_cache *cache = per_cpu_ptr(iovad->percpu_cache, cpu);
+		int i;
+		for (i = 0; i <= ilog2(MAX_CACHE_SIZE); i++)
+			INIT_LIST_HEAD(&cache->cache_lists[i]);
+	}
 }
 EXPORT_SYMBOL_GPL(init_iova_domain);
 
@@ -103,12 +111,10 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 			struct iova *new, bool size_aligned)
 {
 	struct rb_node *prev, *curr = NULL;
-	unsigned long flags;
 	unsigned long saved_pfn;
 	unsigned int pad_size = 0;
 
 	/* Walk the tree backwards */
-	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
 	saved_pfn = limit_pfn;
 	curr = __get_cached_rbnode(iovad, &limit_pfn);
 	prev = curr;
@@ -135,10 +141,8 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 	if (!curr) {
 		if (size_aligned)
 			pad_size = iova_get_pad_size(size, limit_pfn);
-		if ((iovad->start_pfn + size + pad_size) > limit_pfn) {
-			spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
+		if ((iovad->start_pfn + size + pad_size) > limit_pfn)
 			return -ENOMEM;
-		}
 	}
 
 	/* pfn_lo will point to size aligned address if size_aligned is set */
@@ -177,9 +181,6 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 	}
 	__cached_rbnode_insert_update(iovad, saved_pfn, new);
 
-	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
-
-
 	return 0;
 }
 
@@ -256,6 +257,69 @@ void iova_cache_put(void)
 }
 EXPORT_SYMBOL_GPL(iova_cache_put);
 
+static void refill_percpu_iova(struct iova_domain *iovad, int index)
+{
+	struct iova_cache *cache;
+	struct iova *new_iova;
+	unsigned long flags;
+	int ret;
+	int count = 0;
+
+	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
+	cache = this_cpu_ptr(iovad->percpu_cache);
+
+	if (!list_empty(&cache->cache_lists[index]))
+		goto out;
+
+	while (count < (MAX_CACHE_UNIT_SIZE >> index)) {
+		new_iova = alloc_iova_mem();
+		if (!new_iova)
+			goto out;
+		ret = __alloc_and_insert_iova_range(iovad, 1 << index,
+			iovad->dma_32bit_pfn, new_iova, true);
+		if (ret) {
+			free_iova_mem(new_iova);
+			goto out;
+		}
+		count++;
+		list_add(&new_iova->sibling, &cache->cache_lists[index]);
+	}
+out:
+	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
+}
+
+static struct iova *alloc_percpu_iova(struct iova_domain *iovad,
+	unsigned long size, unsigned long limit_pfn)
+{
+	int cache_index;
+	struct iova_cache *cache;
+	struct iova *iova;
+	bool refilled = false;
+
+	if (size > MAX_CACHE_SIZE || limit_pfn < iovad->dma_32bit_pfn)
+		return NULL;
+	cache_index = order_base_2(size);
+
+again:
+	preempt_disable();
+	cache = this_cpu_ptr(iovad->percpu_cache);
+	iova = list_first_entry_or_null(&cache->cache_lists[cache_index],
+		struct iova, sibling);
+	if (iova)
+		list_del(&iova->sibling);
+	preempt_enable();
+	if (iova)
+		return iova;
+
+	if (!refilled) {
+		refill_percpu_iova(iovad, cache_index);
+		refilled = true;
+		goto again;
+	}
+
+	return NULL;
+}
+
 /**
  * alloc_iova - allocates an iova
  * @iovad: - iova domain in question
@@ -274,13 +338,20 @@ alloc_iova(struct iova_domain *iovad, unsigned long size,
 {
 	struct iova *new_iova;
 	int ret;
+	unsigned long flags;
+
+	new_iova = alloc_percpu_iova(iovad, size, limit_pfn);
+	if (new_iova)
+		return new_iova;
 
 	new_iova = alloc_iova_mem();
 	if (!new_iova)
 		return NULL;
 
+	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
 	ret = __alloc_and_insert_iova_range(iovad, size, limit_pfn,
 			new_iova, size_aligned);
+	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 
 	if (ret) {
 		free_iova_mem(new_iova);
@@ -389,6 +460,7 @@ void put_iova_domain(struct iova_domain *iovad)
 		node = rb_first(&iovad->rbroot);
 	}
 	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
+	free_percpu(iovad->percpu_cache);
 }
 EXPORT_SYMBOL_GPL(put_iova_domain);
 
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 92f7177..1386a7b 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -21,6 +21,14 @@ struct iova {
 	struct rb_node	node;
 	unsigned long	pfn_hi; /* IOMMU dish out addr hi */
 	unsigned long	pfn_lo; /* IOMMU dish out addr lo */
+	struct list_head sibling;
+};
+
+#define MAX_CACHE_SIZE 16 /* 16 * 4k, only cache <= 64K allocation */
+#define MAX_CACHE_UNIT_SIZE (512 / 4) /* 512k total cache size */
+
+struct iova_cache {
+	struct list_head cache_lists[ilog2(MAX_CACHE_SIZE) + 1];
 };
 
 /* holds all the iova translations for a domain */
@@ -31,6 +39,7 @@ struct iova_domain {
 	unsigned long	granule;	/* pfn granularity for this domain */
 	unsigned long	start_pfn;	/* Lower limit for this domain */
 	unsigned long	dma_32bit_pfn;
+	struct iova_cache __percpu *percpu_cache;
 };
 
 static inline unsigned long iova_size(struct iova *iova)
-- 
2.4.6
