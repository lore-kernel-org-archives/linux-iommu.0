From: Sagar Arun Kamble <sagar.a.kamble@intel.com>
Subject: [PATCH 2/2] iommu: Remove cpu-local spinlock
Date: Thu,  2 Jun 2016 17:15:30 +0530
Message-ID: <1464867930-28588-3-git-send-email-sagar.a.kamble@intel.com>
References: <1464867930-28588-1-git-send-email-sagar.a.kamble@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464867930-28588-1-git-send-email-sagar.a.kamble@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Intel-gfx-trybot@lists.freedesktop.org
Cc: Chris Wilson <chris@chris-wilson.co.uk>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

From: Chris Wilson <chris@chris-wilson.co.uk>

By avoiding cross-CPU usage of the per-cpu iova cache, we can forgo
having a spinlock inside the per-cpu struct. The only place where we
actually may touch another CPU's data is when performing a cache flush
after running out of memory. Here, we can instead schedule a task to run
on the other CPU to do the flush before trying again.

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
---
 drivers/iommu/iova.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index e23001b..36cdc8e 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -390,6 +390,11 @@ free_iova(struct iova_domain *iovad, unsigned long pfn)
 }
 EXPORT_SYMBOL_GPL(free_iova);
 
+static void free_this_cached_iovas(void *info)
+{
+	free_cpu_cached_iovas(smp_processor_id(), info);
+}
+
 /**
  * alloc_iova_fast - allocates an iova from rcache
  * @iovad: - iova domain in question
@@ -413,17 +418,12 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
 retry:
 	new_iova = alloc_iova(iovad, size, limit_pfn, true);
 	if (!new_iova) {
-		unsigned int cpu;
-
 		if (flushed_rcache)
 			return 0;
 
 		/* Try replenishing IOVAs by flushing rcache. */
 		flushed_rcache = true;
-		preempt_disable();
-		for_each_online_cpu(cpu)
-			free_cpu_cached_iovas(cpu, iovad);
-		preempt_enable();
+		on_each_cpu(free_this_cached_iovas, iovad, true);
 		goto retry;
 	}
 
@@ -647,7 +647,6 @@ struct iova_magazine {
 };
 
 struct iova_cpu_rcache {
-	spinlock_t lock;
 	struct iova_magazine *loaded;
 	struct iova_magazine *prev;
 };
@@ -729,7 +728,6 @@ static void init_iova_rcaches(struct iova_domain *iovad)
 			continue;
 		for_each_possible_cpu(cpu) {
 			cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
-			spin_lock_init(&cpu_rcache->lock);
 			cpu_rcache->loaded = iova_magazine_alloc(GFP_KERNEL);
 			cpu_rcache->prev = iova_magazine_alloc(GFP_KERNEL);
 		}
@@ -749,10 +747,8 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
 	struct iova_magazine *mag_to_free = NULL;
 	struct iova_cpu_rcache *cpu_rcache;
 	bool can_insert = false;
-	unsigned long flags;
 
 	cpu_rcache = get_cpu_ptr(rcache->cpu_rcaches);
-	spin_lock_irqsave(&cpu_rcache->lock, flags);
 
 	if (!iova_magazine_full(cpu_rcache->loaded)) {
 		can_insert = true;
@@ -780,7 +776,6 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
 	if (can_insert)
 		iova_magazine_push(cpu_rcache->loaded, iova_pfn);
 
-	spin_unlock_irqrestore(&cpu_rcache->lock, flags);
 	put_cpu_ptr(rcache->cpu_rcaches);
 
 	if (mag_to_free) {
@@ -813,10 +808,8 @@ static unsigned long __iova_rcache_get(struct iova_rcache *rcache,
 	struct iova_cpu_rcache *cpu_rcache;
 	unsigned long iova_pfn = 0;
 	bool has_pfn = false;
-	unsigned long flags;
 
 	cpu_rcache = get_cpu_ptr(rcache->cpu_rcaches);
-	spin_lock_irqsave(&cpu_rcache->lock, flags);
 
 	if (!iova_magazine_empty(cpu_rcache->loaded)) {
 		has_pfn = true;
@@ -836,7 +829,6 @@ static unsigned long __iova_rcache_get(struct iova_rcache *rcache,
 	if (has_pfn)
 		iova_pfn = iova_magazine_pop(cpu_rcache->loaded, limit_pfn);
 
-	spin_unlock_irqrestore(&cpu_rcache->lock, flags);
 	put_cpu_ptr(rcache->cpu_rcaches);
 
 	return iova_pfn;
@@ -866,17 +858,11 @@ static void free_cpu_iova_rcache(unsigned int cpu, struct iova_domain *iovad,
 				 struct iova_rcache *rcache)
 {
 	struct iova_cpu_rcache *cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
-	unsigned long flags;
-
-	spin_lock_irqsave(&cpu_rcache->lock, flags);
-
 	iova_magazine_free_pfns(cpu_rcache->loaded, iovad);
 	iova_magazine_free(cpu_rcache->loaded);
 
 	iova_magazine_free_pfns(cpu_rcache->prev, iovad);
 	iova_magazine_free(cpu_rcache->prev);
-
-	spin_unlock_irqrestore(&cpu_rcache->lock, flags);
 }
 
 /*
@@ -910,16 +896,13 @@ void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad)
 {
 	struct iova_cpu_rcache *cpu_rcache;
 	struct iova_rcache *rcache;
-	unsigned long flags;
 	int i;
 
 	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
 		rcache = &iovad->rcaches[i];
 		cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
-		spin_lock_irqsave(&cpu_rcache->lock, flags);
 		iova_magazine_free_pfns(cpu_rcache->loaded, iovad);
 		iova_magazine_free_pfns(cpu_rcache->prev, iovad);
-		spin_unlock_irqrestore(&cpu_rcache->lock, flags);
 	}
 }
 
-- 
1.9.1
