From: Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
Subject: [PATCH v3 7/7] iommu: introduce per-cpu caching to iova allocation
Date: Tue, 19 Apr 2016 19:49:44 +0300
Message-ID: <0923752fb142601d6c2b58bcf7cdceea6ec9305e.1460733778.git.mad@cs.technion.ac.il>
References: <cover.1460733778.git.mad@cs.technion.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <cover.1460733778.git.mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: serebrin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, dan-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org, omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org, shli-b10kYP2dOMg@public.gmane.org, gvdl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, Kernel-team-b10kYP2dOMg@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>

IOVA allocation has two problems that impede high-throughput I/O.
First, it can do a linear search over the allocated IOVA ranges.
Second, the rbtree spinlock that serializes IOVA allocations becomes
contended.

Address these problems by creating an API for caching allocated IOVA
ranges, so that the IOVA allocator isn't accessed frequently.  This
patch adds a per-CPU cache, from which CPUs can alloc/free IOVAs
without taking the rbtree spinlock.  The per-CPU caches are backed by
a global cache, to avoid invoking the (linear-time) IOVA allocator
without needing to make the per-CPU cache size excessive.  This design
is based on magazines, as described in "Magazines and Vmem: Extending
the Slab Allocator to Many CPUs and Arbitrary Resources" (currently
available at https://www.usenix.org/legacy/event/usenix01/bonwick.html)

Adding caching on top of the existing rbtree allocator maintains the
property that IOVAs are densely packed in the IO virtual address space,
which is important for keeping IOMMU page table usage low.

To keep the cache size reasonable, we limit caching to ranges of
size <= 128 KB.  Overall, a CPU can cache at most 32 MB and the global
cache is bounded by 4 MB.

Signed-off-by: Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
[mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org: rebased, cleaned up and reworded the commit message]
Signed-off-by: Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
---
 drivers/iommu/intel-iommu.c |  47 +++--
 drivers/iommu/iova.c        | 416 +++++++++++++++++++++++++++++++++++++++++---
 include/linux/iova.h        |  23 ++-
 3 files changed, 448 insertions(+), 38 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 3c3ccd9..1f495dd 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3357,7 +3357,7 @@ static unsigned long intel_alloc_iova(struct device *dev,
 				     struct dmar_domain *domain,
 				     unsigned long nrpages, uint64_t dma_mask)
 {
-	struct iova *iova = NULL;
+	unsigned long iova_pfn = 0;
 
 	/* Restrict dma_mask to the width that the iommu can handle */
 	dma_mask = min_t(uint64_t, DOMAIN_MAX_ADDR(domain->gaw), dma_mask);
@@ -3370,19 +3370,19 @@ static unsigned long intel_alloc_iova(struct device *dev,
 		 * DMA_BIT_MASK(32) and if that fails then try allocating
 		 * from higher range
 		 */
-		iova = alloc_iova(&domain->iovad, nrpages,
-				  IOVA_PFN(DMA_BIT_MASK(32)), 1);
-		if (iova)
-			return iova->pfn_lo;
+		iova_pfn = alloc_iova_fast(&domain->iovad, nrpages,
+					   IOVA_PFN(DMA_BIT_MASK(32)));
+		if (iova_pfn)
+			return iova_pfn;
 	}
-	iova = alloc_iova(&domain->iovad, nrpages, IOVA_PFN(dma_mask), 1);
-	if (unlikely(!iova)) {
+	iova_pfn = alloc_iova_fast(&domain->iovad, nrpages, IOVA_PFN(dma_mask));
+	if (unlikely(!iova_pfn)) {
 		pr_err("Allocating %ld-page iova for %s failed",
 		       nrpages, dev_name(dev));
 		return 0;
 	}
 
-	return iova->pfn_lo;
+	return iova_pfn;
 }
 
 static struct dmar_domain *__get_valid_domain_for_dev(struct device *dev)
@@ -3536,7 +3536,7 @@ static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 
 error:
 	if (iova_pfn)
-		free_iova(&domain->iovad, iova_pfn);
+		free_iova_fast(&domain->iovad, iova_pfn, dma_to_mm_pfn(size));
 	pr_err("Device %s request: %zx@%llx dir %d --- failed\n",
 		dev_name(dev), size, (unsigned long long)paddr, dir);
 	return 0;
@@ -3591,7 +3591,7 @@ static void flush_unmaps(struct deferred_flush_data *flush_data)
 				iommu_flush_dev_iotlb(domain,
 						(uint64_t)iova_pfn << PAGE_SHIFT, mask);
 			}
-			free_iova(&domain->iovad, iova_pfn);
+			free_iova_fast(&domain->iovad, iova_pfn, nrpages);
 			if (freelist)
 				dma_free_pagelist(freelist);
 		}
@@ -3691,7 +3691,7 @@ static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
 		iommu_flush_iotlb_psi(iommu, domain, start_pfn,
 				      nrpages, !freelist, 0);
 		/* free iova */
-		free_iova(&domain->iovad, iova_pfn);
+		free_iova_fast(&domain->iovad, iova_pfn, dma_to_mm_pfn(nrpages));
 		dma_free_pagelist(freelist);
 	} else {
 		add_unmap(domain, iova_pfn, nrpages, freelist);
@@ -3849,7 +3849,7 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 	if (unlikely(ret)) {
 		dma_pte_free_pagetable(domain, start_vpfn,
 				       start_vpfn + size - 1);
-		free_iova(&domain->iovad, iova_pfn);
+		free_iova_fast(&domain->iovad, iova_pfn, dma_to_mm_pfn(size));
 		return 0;
 	}
 
@@ -4588,6 +4588,28 @@ static struct notifier_block intel_iommu_memory_nb = {
 	.priority = 0
 };
 
+static void free_all_cpu_cached_iovas(unsigned int cpu)
+{
+	int i;
+
+	for (i = 0; i < g_num_of_iommus; i++) {
+		struct intel_iommu *iommu = g_iommus[i];
+		struct dmar_domain *domain;
+		u16 did;
+
+		if (!iommu)
+			continue;
+
+		for (did = 0; did < 0xffff; did++) {
+			domain = get_iommu_domain(iommu, did);
+
+			if (!domain)
+				continue;
+			free_cpu_cached_iovas(cpu, &domain->iovad);
+		}
+	}
+}
+
 static int intel_iommu_cpu_notifier(struct notifier_block *nfb,
 				    unsigned long action, void *v)
 {
@@ -4596,6 +4618,7 @@ static int intel_iommu_cpu_notifier(struct notifier_block *nfb,
 	switch (action) {
 	case CPU_DEAD:
 	case CPU_DEAD_FROZEN:
+		free_all_cpu_cached_iovas(cpu);
 		flush_unmaps_timeout(cpu);
 		break;
 	}
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index fa0adef..dbcb923 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -20,6 +20,17 @@
 #include <linux/iova.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/smp.h>
+#include <linux/bitops.h>
+
+static bool iova_rcache_insert(struct iova_domain *iovad,
+			       unsigned long pfn,
+			       unsigned long size);
+static unsigned long iova_rcache_get(struct iova_domain *iovad,
+				     unsigned long size,
+				     unsigned long limit_pfn);
+static void init_iova_rcaches(struct iova_domain *iovad);
+static void free_iova_rcaches(struct iova_domain *iovad);
 
 void
 init_iova_domain(struct iova_domain *iovad, unsigned long granule,
@@ -38,6 +49,7 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	iovad->granule = granule;
 	iovad->start_pfn = start_pfn;
 	iovad->dma_32bit_pfn = pfn_32bit;
+	init_iova_rcaches(iovad);
 }
 EXPORT_SYMBOL_GPL(init_iova_domain);
 
@@ -291,33 +303,18 @@ alloc_iova(struct iova_domain *iovad, unsigned long size,
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
+
+	assert_spin_locked(&iovad->iova_rbtree_lock);
 
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
 
@@ -327,9 +324,35 @@ struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn)
 			node = node->rb_right;
 	}
 
-	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 	return NULL;
 }
+
+static void private_free_iova(struct iova_domain *iovad, struct iova *iova)
+{
+	assert_spin_locked(&iovad->iova_rbtree_lock);
+	__cached_rbnode_delete_update(iovad, iova);
+	rb_erase(&iova->node, &iovad->rbroot);
+	free_iova_mem(iova);
+}
+
+/**
+ * find_iova - finds an iova for a given pfn
+ * @iovad: - iova domain in question.
+ * @pfn: - page frame number
+ * This function finds and returns an iova belonging to the
+ * given doamin which matches the given pfn.
+ */
+struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn)
+{
+	unsigned long flags;
+	struct iova *iova;
+
+	/* Take the lock so that no other thread is manipulating the rbtree */
+	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
+	iova = private_find_iova(iovad, pfn);
+	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
+	return iova;
+}
 EXPORT_SYMBOL_GPL(find_iova);
 
 /**
@@ -344,10 +367,8 @@ __free_iova(struct iova_domain *iovad, struct iova *iova)
 	unsigned long flags;
 
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
-	__cached_rbnode_delete_update(iovad, iova);
-	rb_erase(&iova->node, &iovad->rbroot);
+	private_free_iova(iovad, iova);
 	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
-	free_iova_mem(iova);
 }
 EXPORT_SYMBOL_GPL(__free_iova);
 
@@ -370,6 +391,63 @@ free_iova(struct iova_domain *iovad, unsigned long pfn)
 EXPORT_SYMBOL_GPL(free_iova);
 
 /**
+ * alloc_iova_fast - allocates an iova from rcache
+ * @iovad: - iova domain in question
+ * @size: - size of page frames to allocate
+ * @limit_pfn: - max limit address
+ * This function tries to satisfy an iova allocation from the rcache,
+ * and falls back to regular allocation on failure.
+*/
+unsigned long
+alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
+		unsigned long limit_pfn)
+{
+	bool flushed_rcache = false;
+	unsigned long iova_pfn;
+	struct iova *new_iova;
+
+	iova_pfn = iova_rcache_get(iovad, size, limit_pfn);
+	if (iova_pfn)
+		return iova_pfn;
+
+retry:
+	new_iova = alloc_iova(iovad, size, limit_pfn, true);
+	if (!new_iova) {
+		unsigned int cpu;
+
+		if (flushed_rcache)
+			return 0;
+
+		/* Try replenishing IOVAs by flushing rcache. */
+		flushed_rcache = true;
+		for_each_online_cpu(cpu)
+			free_cpu_cached_iovas(cpu, iovad);
+		goto retry;
+	}
+
+	return new_iova->pfn_lo;
+}
+EXPORT_SYMBOL_GPL(alloc_iova_fast);
+
+/**
+ * free_iova_fast - free iova pfn range into rcache
+ * @iovad: - iova domain in question.
+ * @pfn: - pfn that is allocated previously
+ * @size: - # of pages in range
+ * This functions frees an iova range by trying to put it into the rcache,
+ * falling back to regular iova deallocation via free_iova() if this fails.
+ */
+void
+free_iova_fast(struct iova_domain *iovad, unsigned long pfn, unsigned long size)
+{
+	if (iova_rcache_insert(iovad, pfn, size))
+		return;
+
+	free_iova(iovad, pfn);
+}
+EXPORT_SYMBOL_GPL(free_iova_fast);
+
+/**
  * put_iova_domain - destroys the iova doamin
  * @iovad: - iova domain in question.
  * All the iova's in that domain are destroyed.
@@ -379,6 +457,7 @@ void put_iova_domain(struct iova_domain *iovad)
 	struct rb_node *node;
 	unsigned long flags;
 
+	free_iova_rcaches(iovad);
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
 	node = rb_first(&iovad->rbroot);
 	while (node) {
@@ -550,5 +629,294 @@ error:
 	return NULL;
 }
 
+/*
+ * Magazine caches for IOVA ranges.  For an introduction to magazines,
+ * see the USENIX 2001 paper "Magazines and Vmem: Extending the Slab
+ * Allocator to Many CPUs and Arbitrary Resources" by Bonwick and Adams.
+ * For simplicity, we use a static magazine size and don't implement the
+ * dynamic size tuning described in the paper.
+ */
+
+#define IOVA_MAG_SIZE 128
+
+struct iova_magazine {
+	unsigned long size;
+	unsigned long pfns[IOVA_MAG_SIZE];
+};
+
+struct iova_cpu_rcache {
+	spinlock_t lock;
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
+static unsigned long iova_magazine_pop(struct iova_magazine *mag,
+				       unsigned long limit_pfn)
+{
+	BUG_ON(iova_magazine_empty(mag));
+
+	if (mag->pfns[mag->size - 1] >= limit_pfn)
+		return 0;
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
+static void init_iova_rcaches(struct iova_domain *iovad)
+{
+	struct iova_cpu_rcache *cpu_rcache;
+	struct iova_rcache *rcache;
+	unsigned int cpu;
+	int i;
+
+	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
+		rcache = &iovad->rcaches[i];
+		spin_lock_init(&rcache->lock);
+		rcache->depot_size = 0;
+		rcache->cpu_rcaches = __alloc_percpu(sizeof(*cpu_rcache), cache_line_size());
+		if (WARN_ON(!rcache->cpu_rcaches))
+			continue;
+		for_each_possible_cpu(cpu) {
+			cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
+			spin_lock_init(&cpu_rcache->lock);
+			cpu_rcache->loaded = iova_magazine_alloc(GFP_KERNEL);
+			cpu_rcache->prev = iova_magazine_alloc(GFP_KERNEL);
+		}
+	}
+}
+
+/*
+ * Try inserting IOVA range starting with 'iova_pfn' into 'rcache', and
+ * return true on success.  Can fail if rcache is full and we can't free
+ * space, and free_iova() (our only caller) will then return the IOVA
+ * range to the rbtree instead.
+ */
+static bool __iova_rcache_insert(struct iova_domain *iovad,
+				 struct iova_rcache *rcache,
+				 unsigned long iova_pfn)
+{
+	struct iova_magazine *mag_to_free = NULL;
+	struct iova_cpu_rcache *cpu_rcache;
+	bool can_insert = false;
+	unsigned long flags;
+
+	cpu_rcache = this_cpu_ptr(rcache->cpu_rcaches);
+	spin_lock_irqsave(&cpu_rcache->lock, flags);
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
+	spin_unlock_irqrestore(&cpu_rcache->lock, flags);
+
+	if (mag_to_free) {
+		iova_magazine_free_pfns(mag_to_free, iovad);
+		iova_magazine_free(mag_to_free);
+	}
+
+	return can_insert;
+}
+
+static bool iova_rcache_insert(struct iova_domain *iovad, unsigned long pfn,
+			       unsigned long size)
+{
+	unsigned int log_size = order_base_2(size);
+
+	if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE)
+		return false;
+
+	return __iova_rcache_insert(iovad, &iovad->rcaches[log_size], pfn);
+}
+
+/*
+ * Caller wants to allocate a new IOVA range from 'rcache'.  If we can
+ * satisfy the request, return a matching non-NULL range and remove
+ * it from the 'rcache'.
+ */
+static unsigned long __iova_rcache_get(struct iova_rcache *rcache,
+				       unsigned long limit_pfn)
+{
+	struct iova_cpu_rcache *cpu_rcache;
+	unsigned long iova_pfn = 0;
+	bool has_pfn = false;
+	unsigned long flags;
+
+	cpu_rcache = this_cpu_ptr(rcache->cpu_rcaches);
+	spin_lock_irqsave(&cpu_rcache->lock, flags);
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
+		iova_pfn = iova_magazine_pop(cpu_rcache->loaded, limit_pfn);
+
+	spin_unlock_irqrestore(&cpu_rcache->lock, flags);
+
+	return iova_pfn;
+}
+
+/*
+ * Try to satisfy IOVA allocation range from rcache.  Fail if requested
+ * size is too big or the DMA limit we are given isn't 32-bit or 64-bit.
+ */
+static unsigned long iova_rcache_get(struct iova_domain *iovad,
+				     unsigned long size,
+				     unsigned long limit_pfn)
+{
+	unsigned int log_size = order_base_2(size);
+
+	if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE)
+		return 0;
+
+	return __iova_rcache_get(&iovad->rcaches[log_size], limit_pfn);
+}
+
+/*
+ * Free a cpu's rcache.
+ */
+static void free_cpu_iova_rcache(unsigned int cpu, struct iova_domain *iovad,
+				 struct iova_rcache *rcache)
+{
+	struct iova_cpu_rcache *cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
+	unsigned long flags;
+
+	spin_lock_irqsave(&cpu_rcache->lock, flags);
+
+	iova_magazine_free_pfns(cpu_rcache->loaded, iovad);
+	iova_magazine_free(cpu_rcache->loaded);
+
+	iova_magazine_free_pfns(cpu_rcache->prev, iovad);
+	iova_magazine_free(cpu_rcache->prev);
+
+	spin_unlock_irqrestore(&cpu_rcache->lock, flags);
+}
+
+/*
+ * free rcache data structures.
+ */
+static void free_iova_rcaches(struct iova_domain *iovad)
+{
+	struct iova_rcache *rcache;
+	unsigned long flags;
+	unsigned int cpu;
+	int i, j;
+
+	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
+		rcache = &iovad->rcaches[i];
+		for_each_possible_cpu(cpu)
+			free_cpu_iova_rcache(cpu, iovad, rcache);
+		spin_lock_irqsave(&rcache->lock, flags);
+		free_percpu(rcache->cpu_rcaches);
+		for (j = 0; j < rcache->depot_size; ++j) {
+			iova_magazine_free_pfns(rcache->depot[j], iovad);
+			iova_magazine_free(rcache->depot[j]);
+		}
+		spin_unlock_irqrestore(&rcache->lock, flags);
+	}
+}
+
+/*
+ * free all the IOVA ranges cached by a cpu (used when cpu is unplugged)
+ */
+void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad)
+{
+	struct iova_cpu_rcache *cpu_rcache;
+	struct iova_rcache *rcache;
+	unsigned long flags;
+	int i;
+
+	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
+		rcache = &iovad->rcaches[i];
+		cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
+		spin_lock_irqsave(&cpu_rcache->lock, flags);
+		iova_magazine_free_pfns(cpu_rcache->loaded, iovad);
+		iova_magazine_free_pfns(cpu_rcache->prev, iovad);
+		spin_unlock_irqrestore(&cpu_rcache->lock, flags);
+	}
+}
+
 MODULE_AUTHOR("Anil S Keshavamurthy <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 92f7177..f27bb2c 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -19,8 +19,21 @@
 /* iova structure */
 struct iova {
 	struct rb_node	node;
-	unsigned long	pfn_hi; /* IOMMU dish out addr hi */
-	unsigned long	pfn_lo; /* IOMMU dish out addr lo */
+	unsigned long	pfn_hi; /* Highest allocated pfn */
+	unsigned long	pfn_lo; /* Lowest allocated pfn */
+};
+
+struct iova_magazine;
+struct iova_cpu_rcache;
+
+#define IOVA_RANGE_CACHE_MAX_SIZE 6	/* log of max cached IOVA range size (in pages) */
+#define MAX_GLOBAL_MAGS 32	/* magazines per bin */
+
+struct iova_rcache {
+	spinlock_t lock;
+	unsigned long depot_size;
+	struct iova_magazine *depot[MAX_GLOBAL_MAGS];
+	struct iova_cpu_rcache __percpu *cpu_rcaches;
 };
 
 /* holds all the iova translations for a domain */
@@ -31,6 +44,7 @@ struct iova_domain {
 	unsigned long	granule;	/* pfn granularity for this domain */
 	unsigned long	start_pfn;	/* Lower limit for this domain */
 	unsigned long	dma_32bit_pfn;
+	struct iova_rcache rcaches[IOVA_RANGE_CACHE_MAX_SIZE];	/* IOVA range caches */
 };
 
 static inline unsigned long iova_size(struct iova *iova)
@@ -78,6 +92,10 @@ void __free_iova(struct iova_domain *iovad, struct iova *iova);
 struct iova *alloc_iova(struct iova_domain *iovad, unsigned long size,
 	unsigned long limit_pfn,
 	bool size_aligned);
+void free_iova_fast(struct iova_domain *iovad, unsigned long pfn,
+		    unsigned long size);
+unsigned long alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
+			      unsigned long limit_pfn);
 struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
 	unsigned long pfn_hi);
 void copy_reserved_iova(struct iova_domain *from, struct iova_domain *to);
@@ -87,5 +105,6 @@ struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
 void put_iova_domain(struct iova_domain *iovad);
 struct iova *split_and_remove_iova(struct iova_domain *iovad,
 	struct iova *iova, unsigned long pfn_lo, unsigned long pfn_hi);
+void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
 
 #endif
-- 
1.9.1
