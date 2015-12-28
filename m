From: Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
Subject: [PATCH 7/7] iommu: introduce per-cpu caching to iova allocation
Date: Mon, 28 Dec 2015 18:17:43 +0200
Message-ID: <20151228161743.GA27929@cs.technion.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: serebrin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, dan-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org, omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>

This patch introduces global and per-CPU caches of IOVAs, so that
CPUs can usually allocate IOVAs without taking the rbtree spinlock
to do so.  The caching is based on magazines, as described in "Magazines
and Vmem: Extending the Slab Allocator to Many CPUs and Arbitrary
Resources" (currently available at
https://www.usenix.org/legacy/event/usenix01/bonwick.html)

Adding caching on top of the existing rbtree allocator maintains the
property that IOVAs are densely packed in the IO virtual address space,
which is important for keeping IOMMU page table usage low.

Signed-off-by: Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
[mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org: rebased, cleaned up and reworded the commit message]
Signed-off-by: Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
---
 drivers/iommu/intel-iommu.c |  12 +-
 drivers/iommu/iova.c        | 326 +++++++++++++++++++++++++++++++++++++-------
 include/linux/iova.h        |  21 ++-
 3 files changed, 302 insertions(+), 57 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index c2de0e7..7e9c2dd 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3282,11 +3282,11 @@ static unsigned long intel_alloc_iova(struct device *dev,
 		 * from higher range
 		 */
 		iova_pfn = alloc_iova(&domain->iovad, nrpages,
-				      IOVA_PFN(DMA_BIT_MASK(32)), 1);
+				      IOVA_PFN(DMA_BIT_MASK(32)));
 		if (iova_pfn)
 			return iova_pfn;
 	}
-	iova_pfn = alloc_iova(&domain->iovad, nrpages, IOVA_PFN(dma_mask), 1);
+	iova_pfn = alloc_iova(&domain->iovad, nrpages, IOVA_PFN(dma_mask));
 	if (unlikely(!iova_pfn)) {
 		pr_err("Allocating %ld-page iova for %s failed",
 		       nrpages, dev_name(dev));
@@ -3447,7 +3447,7 @@ static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 
 error:
 	if (iova_pfn)
-		free_iova(&domain->iovad, iova_pfn);
+		free_iova(&domain->iovad, iova_pfn, dma_to_mm_pfn(size));
 	pr_err("Device %s request: %zx@%llx dir %d --- failed\n",
 		dev_name(dev), size, (unsigned long long)paddr, dir);
 	return 0;
@@ -3502,7 +3502,7 @@ static void flush_unmaps(struct deferred_flush_data *flush_data)
 				iommu_flush_dev_iotlb(domain,
 						(uint64_t)iova_pfn << PAGE_SHIFT, mask);
 			}
-			free_iova(&domain->iovad, iova_pfn);
+			free_iova(&domain->iovad, iova_pfn, nrpages);
 			if (freelist)
 				dma_free_pagelist(freelist);
 		}
@@ -3593,7 +3593,7 @@ static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
 		iommu_flush_iotlb_psi(iommu, domain, start_pfn,
 				      nrpages, !freelist, 0);
 		/* free iova */
-		free_iova(&domain->iovad, iova_pfn);
+		free_iova(&domain->iovad, iova_pfn, dma_to_mm_pfn(nrpages));
 		dma_free_pagelist(freelist);
 	} else {
 		add_unmap(domain, iova_pfn, nrpages, freelist);
@@ -3751,7 +3751,7 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 	if (unlikely(ret)) {
 		dma_pte_free_pagetable(domain, start_vpfn,
 				       start_vpfn + size - 1);
-		free_iova(&domain->iovad, iova_pfn);
+		free_iova(&domain->iovad, iova_pfn, dma_to_mm_pfn(size));
 		return 0;
 	}
 
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 9009ce6..38dd03a 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -20,11 +20,24 @@
 #include <linux/iova.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/smp.h>
+#include <linux/bitops.h>
+
+static bool iova_rcache_insert(struct iova_domain *iovad,
+			       struct iova_rcache *rcache,
+			       unsigned long iova_pfn);
+static unsigned long iova_rcache_get(struct iova_rcache *rcache);
+
+static void init_iova_rcache(struct iova_rcache *rcache);
+static void free_iova_rcache(struct iova_domain *iovad,
+			     struct iova_rcache *rcache);
 
 void
 init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	unsigned long start_pfn, unsigned long pfn_32bit)
 {
+	int i;
+
 	/*
 	 * IOVA granularity will normally be equal to the smallest
 	 * supported IOMMU page size; both *must* be capable of
@@ -38,6 +51,9 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	iovad->granule = granule;
 	iovad->start_pfn = start_pfn;
 	iovad->dma_32bit_pfn = pfn_32bit;
+
+	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i)
+		init_iova_rcache(&iovad->rcaches[i]);
 }
 EXPORT_SYMBOL_GPL(init_iova_domain);
 
@@ -100,7 +116,7 @@ iova_get_pad_size(unsigned int size, unsigned int limit_pfn)
 
 static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 		unsigned long size, unsigned long limit_pfn,
-			struct iova *new, bool size_aligned)
+			struct iova *new)
 {
 	struct rb_node *prev, *curr = NULL;
 	unsigned long flags;
@@ -120,8 +136,7 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 		else if (limit_pfn < curr_iova->pfn_hi)
 			goto adjust_limit_pfn;
 		else {
-			if (size_aligned)
-				pad_size = iova_get_pad_size(size, limit_pfn);
+			pad_size = iova_get_pad_size(size, limit_pfn);
 			if ((curr_iova->pfn_hi + size + pad_size) <= limit_pfn)
 				break;	/* found a free slot */
 		}
@@ -133,15 +148,14 @@ move_left:
 	}
 
 	if (!curr) {
-		if (size_aligned)
-			pad_size = iova_get_pad_size(size, limit_pfn);
+		pad_size = iova_get_pad_size(size, limit_pfn);
 		if ((iovad->start_pfn + size + pad_size) > limit_pfn) {
 			spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 			return -ENOMEM;
 		}
 	}
 
-	/* pfn_lo will point to size aligned address if size_aligned is set */
+	/* pfn_lo will point to size aligned address */
 	new->pfn_lo = limit_pfn - (size + pad_size) + 1;
 	new->pfn_hi = new->pfn_lo + size - 1;
 
@@ -263,24 +277,30 @@ EXPORT_SYMBOL_GPL(iova_cache_put);
  * @limit_pfn: - max limit address
  * @size_aligned: - set if size_aligned address range is required
  * This function allocates an iova in the range iovad->start_pfn to limit_pfn,
- * searching top-down from limit_pfn to iovad->start_pfn. If the size_aligned
- * flag is set then the allocated address iova->pfn_lo will be naturally
- * aligned on roundup_power_of_two(size).
- */
+ * searching top-down from limit_pfn to iovad->start_pfn. Allocated addresses
+ * will be aligned on roundup_power_of_two(size).
+*/
 unsigned long
 alloc_iova(struct iova_domain *iovad, unsigned long size,
-	unsigned long limit_pfn,
-	bool size_aligned)
+	unsigned long limit_pfn)
 {
+	unsigned int log_size = fls_long(size - 1);
 	struct iova *new_iova;
 	int ret;
 
+	if (log_size < IOVA_RANGE_CACHE_MAX_SIZE) {
+		unsigned long iova_pfn =
+				iova_rcache_get(&iovad->rcaches[log_size]);
+		if (iova_pfn)
+			return iova_pfn;
+	}
+
 	new_iova = alloc_iova_mem();
 	if (!new_iova)
 		return 0;
 
-	ret = __alloc_and_insert_iova_range(iovad, size, limit_pfn,
-			new_iova, size_aligned);
+	ret = __alloc_and_insert_iova_range(iovad, 1UL << log_size,
+			 limit_pfn, new_iova);
 
 	if (ret) {
 		free_iova_mem(new_iova);
@@ -291,33 +311,16 @@ alloc_iova(struct iova_domain *iovad, unsigned long size,
 }
 EXPORT_SYMBOL_GPL(alloc_iova);
 
-/**
- * find_iova - find's an iova for a given pfn
- * @iovad: - iova domain in question.
- * @pfn: - page frame number
- * This function finds and returns an iova belonging to the
- * given doamin which matches the given pfn.
- */
-struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn)
+static struct iova *
+private_find_iova(struct iova_domain *iovad, unsigned long pfn)
 {
-	unsigned long flags;
-	struct rb_node *node;
+	struct rb_node *node = iovad->rbroot.rb_node;
 
-	/* Take the lock so that no other thread is manipulating the rbtree */
-	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
-	node = iovad->rbroot.rb_node;
 	while (node) {
 		struct iova *iova = container_of(node, struct iova, node);
 
 		/* If pfn falls within iova's range, return iova */
 		if ((pfn >= iova->pfn_lo) && (pfn <= iova->pfn_hi)) {
-			spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
-			/* We are not holding the lock while this iova
-			 * is referenced by the caller as the same thread
-			 * which called this function also calls __free_iova()
-			 * and it is by design that only one thread can possibly
-			 * reference a particular iova and hence no conflict.
-			 */
 			return iova;
 		}
 
@@ -327,29 +330,35 @@ struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn)
 			node = node->rb_right;
 	}
 
-	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(find_iova);
 
 /**
- * __free_iova - frees the given iova
- * @iovad: iova domain in question.
- * @iova: iova in question.
- * Frees the given iova belonging to the giving domain
+ * find_iova - find's an iova for a given pfn
+ * @iovad: - iova domain in question.
+ * @pfn: - page frame number
+ * This function finds and returns an iova belonging to the
+ * given doamin which matches the given pfn.
  */
-void
-__free_iova(struct iova_domain *iovad, struct iova *iova)
+struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn)
 {
 	unsigned long flags;
+	struct iova *iova;
 
+	/* Take the lock so that no other thread is manipulating the rbtree */
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
+	iova = private_find_iova(iovad, pfn);
+	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
+	return iova;
+}
+
+static void private_free_iova(struct iova_domain *iovad, struct iova *iova)
+{
 	__cached_rbnode_delete_update(iovad, iova);
 	rb_erase(&iova->node, &iovad->rbroot);
-	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 	free_iova_mem(iova);
 }
-EXPORT_SYMBOL_GPL(__free_iova);
 
 /**
  * free_iova - finds and frees the iova for a given pfn
@@ -359,13 +368,23 @@ EXPORT_SYMBOL_GPL(__free_iova);
  * frees the iova from that domain.
  */
 void
-free_iova(struct iova_domain *iovad, unsigned long pfn)
+free_iova(struct iova_domain *iovad, unsigned long pfn, unsigned long size)
 {
-	struct iova *iova = find_iova(iovad, pfn);
+	unsigned long flags;
+	struct iova *iova;
+	unsigned int log_size = fls_long(size - 1);
 
-	if (iova)
-		__free_iova(iovad, iova);
+	if (log_size < IOVA_RANGE_CACHE_MAX_SIZE) {
+		if (iova_rcache_insert(iovad, &iovad->rcaches[log_size], pfn))
+			return;
+	}
 
+	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
+	iova = private_find_iova(iovad, pfn);
+	WARN_ON(!iova);
+	if (iova)
+		private_free_iova(iovad, iova);
+	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 }
 EXPORT_SYMBOL_GPL(free_iova);
 
@@ -376,9 +395,13 @@ EXPORT_SYMBOL_GPL(free_iova);
  */
 void put_iova_domain(struct iova_domain *iovad)
 {
+	int i;
 	struct rb_node *node;
 	unsigned long flags;
 
+	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i)
+		free_iova_rcache(iovad, &iovad->rcaches[i]);
+
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
 	node = rb_first(&iovad->rbroot);
 	while (node) {
@@ -550,5 +573,214 @@ error:
 	return NULL;
 }
 
+/*
+ * Magazine caches for IOVA ranges.  For an introduction to magazines,
+ * see the USENIX 2001 paper "Magazines and Vmem: Extending the Slab
+ * Allocator to Many CPUs and Arbitrary Resources" by Bonwick and Adams.
+ */
+
+#define IOVA_MAG_SIZE 128
+
+struct iova_magazine {
+	int size;
+	unsigned long pfns[IOVA_MAG_SIZE];
+};
+
+struct iova_cpu_rcache {
+	struct iova_magazine *loaded;
+	struct iova_magazine *prev;
+};
+
+static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
+{
+	return kzalloc(sizeof(struct iova_magazine), flags);
+}
+
+static void iova_magazine_free(struct iova_magazine *mag)
+{
+	kfree(mag);
+}
+
+static void
+iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
+{
+	unsigned long flags;
+	int i;
+
+	if (!mag)
+		return;
+
+	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
+
+	for (i = 0 ; i < mag->size; ++i) {
+		struct iova *iova = private_find_iova(iovad, mag->pfns[i]);
+
+		BUG_ON(!iova);
+		private_free_iova(iovad, iova);
+	}
+
+	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
+
+	mag->size = 0;
+}
+
+static bool iova_magazine_full(struct iova_magazine *mag)
+{
+	return (mag && mag->size == IOVA_MAG_SIZE);
+}
+
+static bool iova_magazine_empty(struct iova_magazine *mag)
+{
+	return (!mag || mag->size == 0);
+}
+
+static unsigned long iova_magazine_pop(struct iova_magazine *mag)
+{
+	BUG_ON(iova_magazine_empty(mag));
+
+	return mag->pfns[--mag->size];
+}
+
+static void iova_magazine_push(struct iova_magazine *mag, unsigned long pfn)
+{
+	BUG_ON(iova_magazine_full(mag));
+
+	mag->pfns[mag->size++] = pfn;
+}
+
+static void init_iova_rcache(struct iova_rcache *rcache)
+{
+	struct iova_cpu_rcache *cpu_rcache;
+	int cpu;
+
+	spin_lock_init(&rcache->lock);
+	rcache->depot_size = 0;
+	rcache->cpu_rcaches = __alloc_percpu(sizeof(*cpu_rcache), 64);
+	if (rcache->cpu_rcaches) {
+		for_each_possible_cpu(cpu) {
+			cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
+
+			cpu_rcache->loaded = iova_magazine_alloc(GFP_KERNEL);
+			cpu_rcache->prev = iova_magazine_alloc(GFP_KERNEL);
+		}
+	}
+}
+
+static bool iova_rcache_insert(struct iova_domain *iovad,
+			       struct iova_rcache *rcache,
+			       unsigned long iova_pfn)
+{
+	struct iova_magazine *mag_to_free = NULL;
+	struct iova_cpu_rcache *cpu_rcache;
+	bool can_insert = false;
+
+	preempt_disable();
+	cpu_rcache = this_cpu_ptr(rcache->cpu_rcaches);
+
+	if (!iova_magazine_full(cpu_rcache->loaded)) {
+		can_insert = true;
+	} else if (!iova_magazine_full(cpu_rcache->prev)) {
+		swap(cpu_rcache->prev, cpu_rcache->loaded);
+		can_insert = true;
+	} else {
+		struct iova_magazine *new_mag = iova_magazine_alloc(GFP_ATOMIC);
+
+		if (new_mag) {
+			spin_lock(&rcache->lock);
+			if (rcache->depot_size < MAX_GLOBAL_MAGS) {
+				rcache->depot[rcache->depot_size++] =
+						cpu_rcache->loaded;
+			} else {
+				mag_to_free = cpu_rcache->loaded;
+			}
+			spin_unlock(&rcache->lock);
+
+			cpu_rcache->loaded = new_mag;
+			can_insert = true;
+		}
+	}
+
+	if (can_insert)
+		iova_magazine_push(cpu_rcache->loaded, iova_pfn);
+
+	preempt_enable();
+
+	if (mag_to_free) {
+		iova_magazine_free_pfns(mag_to_free, iovad);
+		iova_magazine_free(mag_to_free);
+	}
+
+	return can_insert;
+}
+
+/*
+ * caller wants to allocate a new IOVA range of the size 'size'; can
+ * we satisfy her request from the 'cache'? if yes, return a matching
+ * non-NULL range and remove it from the 'cache'.
+ */
+static unsigned long iova_rcache_get(struct iova_rcache *rcache)
+{
+	struct iova_cpu_rcache *cpu_rcache;
+	unsigned long iova_pfn = 0;
+	bool has_pfn = false;
+
+	preempt_disable();
+	cpu_rcache = this_cpu_ptr(rcache->cpu_rcaches);
+
+	if (!iova_magazine_empty(cpu_rcache->loaded)) {
+		has_pfn = true;
+	} else if (!iova_magazine_empty(cpu_rcache->prev)) {
+		swap(cpu_rcache->prev, cpu_rcache->loaded);
+		has_pfn = true;
+	} else {
+		spin_lock(&rcache->lock);
+		if (rcache->depot_size > 0) {
+			iova_magazine_free(cpu_rcache->loaded);
+			cpu_rcache->loaded = rcache->depot[--rcache->depot_size];
+			has_pfn = true;
+		}
+		spin_unlock(&rcache->lock);
+	}
+
+	if (has_pfn)
+		iova_pfn = iova_magazine_pop(cpu_rcache->loaded);
+
+	preempt_enable();
+
+	return iova_pfn;
+}
+
+/*
+ * reset entire cache data structure; typically called when updating
+ * corresponding /proc file.
+ */
+static void free_iova_rcache(struct iova_domain *iovad,
+			     struct iova_rcache *rcache)
+{
+	unsigned long flags;
+	int cpu;
+	int i;
+
+	for_each_possible_cpu(cpu) {
+		struct iova_cpu_rcache *cpu_rcache =
+			per_cpu_ptr(rcache->cpu_rcaches, cpu);
+
+		/* No one else touches core caches when they're freed */
+		iova_magazine_free_pfns(cpu_rcache->loaded, iovad);
+		iova_magazine_free(cpu_rcache->loaded);
+
+		iova_magazine_free_pfns(cpu_rcache->prev, iovad);
+		iova_magazine_free(cpu_rcache->prev);
+	}
+
+	spin_lock_irqsave(&rcache->lock, flags);
+	free_percpu(rcache->cpu_rcaches);
+	for (i = 0; i < rcache->depot_size; ++i) {
+		iova_magazine_free_pfns(rcache->depot[i], iovad);
+		iova_magazine_free(rcache->depot[i]);
+	}
+	spin_unlock_irqrestore(&rcache->lock, flags);
+}
+
 MODULE_AUTHOR("Anil S Keshavamurthy <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/iova.h b/include/linux/iova.h
index efecee0..ce4213a 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -23,6 +23,19 @@ struct iova {
 	unsigned long	pfn_lo; /* IOMMU dish out addr lo */
 };
 
+struct iova_magazine;
+struct iova_cpu_rcache;
+
+#define IOVA_RANGE_CACHE_MAX_SIZE 8	/* log of max cached IOVA range size */
+#define MAX_GLOBAL_MAGS 32	/* magazines per bin */
+
+struct iova_rcache {
+	spinlock_t lock;
+	int depot_size;
+	struct iova_magazine *depot[MAX_GLOBAL_MAGS];
+	struct iova_cpu_rcache __percpu *cpu_rcaches;
+};
+
 /* holds all the iova translations for a domain */
 struct iova_domain {
 	spinlock_t	iova_rbtree_lock; /* Lock to protect update of rbtree */
@@ -31,6 +44,7 @@ struct iova_domain {
 	unsigned long	granule;	/* pfn granularity for this domain */
 	unsigned long	start_pfn;	/* Lower limit for this domain */
 	unsigned long	dma_32bit_pfn;
+	struct iova_rcache rcaches[IOVA_RANGE_CACHE_MAX_SIZE];	/* IOVA range caches */
 };
 
 static inline unsigned long iova_size(struct iova *iova)
@@ -73,11 +87,10 @@ void iova_cache_put(void);
 
 struct iova *alloc_iova_mem(void);
 void free_iova_mem(struct iova *iova);
-void free_iova(struct iova_domain *iovad, unsigned long pfn);
-void __free_iova(struct iova_domain *iovad, struct iova *iova);
+void free_iova(struct iova_domain *iovad, unsigned long pfn,
+		unsigned long size);
 unsigned long alloc_iova(struct iova_domain *iovad, unsigned long size,
-	unsigned long limit_pfn,
-	bool size_aligned);
+	unsigned long limit_pfn);
 struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
 	unsigned long pfn_hi);
 void copy_reserved_iova(struct iova_domain *from, struct iova_domain *to);
-- 
1.9.1
