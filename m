From: Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
Subject: [PATCH v3 2/7] iommu: per-cpu deferred invalidation queues
Date: Tue, 19 Apr 2016 19:48:47 +0300
Message-ID: <f0b898faee599365ce2a370f2a8a8d324abb5477.1460733778.git.mad@cs.technion.ac.il>
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

The IOMMU's IOTLB invalidation is a costly process.  When iommu mode
is not set to "strict", it is done asynchronously. Current code
amortizes the cost of invalidating IOTLB entries by batching all the
invalidations in the system and performing a single global invalidation
instead. The code queues pending invalidations in a global queue that
is accessed under the global "async_umap_flush_lock" spinlock, which
can result is significant spinlock contention.

This patch splits this deferred queue into multiple per-cpu deferred
queues, and thus gets rid of the "async_umap_flush_lock" and its
contention.  To keep existing deferred invalidation behavior, it still
invalidates the pending invalidations of all CPUs whenever a CPU
reaches its watermark or a timeout occurs.

Signed-off-by: Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
[mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org: rebased, cleaned up and reworded the commit message]
Signed-off-by: Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 133 ++++++++++++++++++++++++++++++--------------
 1 file changed, 92 insertions(+), 41 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index f66a45a..be94444 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -33,6 +33,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/mempool.h>
 #include <linux/memory.h>
+#include <linux/cpu.h>
 #include <linux/timer.h>
 #include <linux/io.h>
 #include <linux/iova.h>
@@ -456,8 +457,6 @@ static LIST_HEAD(dmar_rmrr_units);
 
 static void flush_unmaps_timeout(unsigned long data);
 
-static DEFINE_TIMER(unmap_timer,  flush_unmaps_timeout, 0, 0);
-
 struct deferred_flush_entry {
 	struct iova *iova;
 	struct dmar_domain *domain;
@@ -470,17 +469,19 @@ struct deferred_flush_table {
 	struct deferred_flush_entry entries[HIGH_WATER_MARK];
 };
 
-static struct deferred_flush_table *deferred_flush;
+struct deferred_flush_data {
+	spinlock_t lock;
+	int timer_on;
+	struct timer_list timer;
+	long size;
+	struct deferred_flush_table *tables;
+};
+
+DEFINE_PER_CPU(struct deferred_flush_data, deferred_flush);
 
 /* bitmap for indexing intel_iommus */
 static int g_num_of_iommus;
 
-static DEFINE_SPINLOCK(async_umap_flush_lock);
-static LIST_HEAD(unmaps_to_do);
-
-static int timer_on;
-static long list_size;
-
 static void domain_exit(struct dmar_domain *domain);
 static void domain_remove_dev_info(struct dmar_domain *domain);
 static void dmar_remove_one_dev_info(struct dmar_domain *domain,
@@ -1922,8 +1923,12 @@ static void domain_exit(struct dmar_domain *domain)
 		return;
 
 	/* Flush any lazy unmaps that may reference this domain */
-	if (!intel_iommu_strict)
-		flush_unmaps_timeout(0);
+	if (!intel_iommu_strict) {
+		int cpu;
+
+		for_each_possible_cpu(cpu)
+			flush_unmaps_timeout(cpu);
+	}
 
 	/* Remove associated devices and clear attached or cached domains */
 	rcu_read_lock();
@@ -3081,7 +3086,7 @@ static int __init init_dmars(void)
 	bool copied_tables = false;
 	struct device *dev;
 	struct intel_iommu *iommu;
-	int i, ret;
+	int i, ret, cpu;
 
 	/*
 	 * for each drhd
@@ -3114,11 +3119,20 @@ static int __init init_dmars(void)
 		goto error;
 	}
 
-	deferred_flush = kzalloc(g_num_of_iommus *
-		sizeof(struct deferred_flush_table), GFP_KERNEL);
-	if (!deferred_flush) {
-		ret = -ENOMEM;
-		goto free_g_iommus;
+	for_each_possible_cpu(cpu) {
+		struct deferred_flush_data *dfd = per_cpu_ptr(&deferred_flush,
+							      cpu);
+
+		dfd->tables = kzalloc(g_num_of_iommus *
+				      sizeof(struct deferred_flush_table),
+				      GFP_KERNEL);
+		if (!dfd->tables) {
+			ret = -ENOMEM;
+			goto free_g_iommus;
+		}
+
+		spin_lock_init(&dfd->lock);
+		setup_timer(&dfd->timer, flush_unmaps_timeout, cpu);
 	}
 
 	for_each_active_iommu(iommu, drhd) {
@@ -3295,8 +3309,9 @@ free_iommu:
 		disable_dmar_iommu(iommu);
 		free_dmar_iommu(iommu);
 	}
-	kfree(deferred_flush);
 free_g_iommus:
+	for_each_possible_cpu(cpu)
+		kfree(per_cpu_ptr(&deferred_flush, cpu)->tables);
 	kfree(g_iommus);
 error:
 	return ret;
@@ -3501,29 +3516,31 @@ static dma_addr_t intel_map_page(struct device *dev, struct page *page,
 				  dir, *dev->dma_mask);
 }
 
-static void flush_unmaps(void)
+static void flush_unmaps(struct deferred_flush_data *flush_data)
 {
 	int i, j;
 
-	timer_on = 0;
+	flush_data->timer_on = 0;
 
 	/* just flush them all */
 	for (i = 0; i < g_num_of_iommus; i++) {
 		struct intel_iommu *iommu = g_iommus[i];
+		struct deferred_flush_table *flush_table =
+				&flush_data->tables[i];
 		if (!iommu)
 			continue;
 
-		if (!deferred_flush[i].next)
+		if (!flush_table->next)
 			continue;
 
 		/* In caching mode, global flushes turn emulation expensive */
 		if (!cap_caching_mode(iommu->cap))
 			iommu->flush.flush_iotlb(iommu, 0, 0, 0,
 					 DMA_TLB_GLOBAL_FLUSH);
-		for (j = 0; j < deferred_flush[i].next; j++) {
+		for (j = 0; j < flush_table->next; j++) {
 			unsigned long mask;
 			struct deferred_flush_entry *entry =
-						&deferred_flush->entries[j];
+						&flush_table->entries[j];
 			struct iova *iova = entry->iova;
 			struct dmar_domain *domain = entry->domain;
 			struct page *freelist = entry->freelist;
@@ -3542,19 +3559,20 @@ static void flush_unmaps(void)
 			if (freelist)
 				dma_free_pagelist(freelist);
 		}
-		deferred_flush[i].next = 0;
+		flush_table->next = 0;
 	}
 
-	list_size = 0;
+	flush_data->size = 0;
 }
 
-static void flush_unmaps_timeout(unsigned long data)
+static void flush_unmaps_timeout(unsigned long cpuid)
 {
+	struct deferred_flush_data *flush_data = per_cpu_ptr(&deferred_flush, cpuid);
 	unsigned long flags;
 
-	spin_lock_irqsave(&async_umap_flush_lock, flags);
-	flush_unmaps();
-	spin_unlock_irqrestore(&async_umap_flush_lock, flags);
+	spin_lock_irqsave(&flush_data->lock, flags);
+	flush_unmaps(flush_data);
+	spin_unlock_irqrestore(&flush_data->lock, flags);
 }
 
 static void add_unmap(struct dmar_domain *dom, struct iova *iova, struct page *freelist)
@@ -3563,28 +3581,44 @@ static void add_unmap(struct dmar_domain *dom, struct iova *iova, struct page *f
 	int entry_id, iommu_id;
 	struct intel_iommu *iommu;
 	struct deferred_flush_entry *entry;
+	struct deferred_flush_data *flush_data;
+	unsigned int cpuid;
 
-	spin_lock_irqsave(&async_umap_flush_lock, flags);
-	if (list_size == HIGH_WATER_MARK)
-		flush_unmaps();
+	cpuid = get_cpu();
+	flush_data = per_cpu_ptr(&deferred_flush, cpuid);
+
+	/* Flush all CPUs' entries to avoid deferring too much.  If
+	 * this becomes a bottleneck, can just flush us, and rely on
+	 * flush timer for the rest.
+	 */
+	if (flush_data->size == HIGH_WATER_MARK) {
+		int cpu;
+
+		for_each_online_cpu(cpu)
+			flush_unmaps_timeout(cpu);
+	}
+
+	spin_lock_irqsave(&flush_data->lock, flags);
 
 	iommu = domain_get_iommu(dom);
 	iommu_id = iommu->seq_id;
 
-	entry_id = deferred_flush[iommu_id].next;
-	++(deferred_flush[iommu_id].next);
+	entry_id = flush_data->tables[iommu_id].next;
+	++(flush_data->tables[iommu_id].next);
 
-	entry = &deferred_flush[iommu_id].entries[entry_id];
+	entry = &flush_data->tables[iommu_id].entries[entry_id];
 	entry->domain = dom;
 	entry->iova = iova;
 	entry->freelist = freelist;
 
-	if (!timer_on) {
-		mod_timer(&unmap_timer, jiffies + msecs_to_jiffies(10));
-		timer_on = 1;
+	if (!flush_data->timer_on) {
+		mod_timer(&flush_data->timer, jiffies + msecs_to_jiffies(10));
+		flush_data->timer_on = 1;
 	}
-	list_size++;
-	spin_unlock_irqrestore(&async_umap_flush_lock, flags);
+	flush_data->size++;
+	spin_unlock_irqrestore(&flush_data->lock, flags);
+
+	put_cpu();
 }
 
 static void intel_unmap(struct device *dev, dma_addr_t dev_addr)
@@ -4508,6 +4542,23 @@ static struct notifier_block intel_iommu_memory_nb = {
 	.priority = 0
 };
 
+static int intel_iommu_cpu_notifier(struct notifier_block *nfb,
+				    unsigned long action, void *v)
+{
+	unsigned int cpu = (unsigned long)v;
+
+	switch (action) {
+	case CPU_DEAD:
+	case CPU_DEAD_FROZEN:
+		flush_unmaps_timeout(cpu);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block intel_iommu_cpu_nb = {
+	.notifier_call = intel_iommu_cpu_notifier,
+};
 
 static ssize_t intel_iommu_show_version(struct device *dev,
 					struct device_attribute *attr,
@@ -4641,7 +4692,6 @@ int __init intel_iommu_init(void)
 	up_write(&dmar_global_lock);
 	pr_info("Intel(R) Virtualization Technology for Directed I/O\n");
 
-	init_timer(&unmap_timer);
 #ifdef CONFIG_SWIOTLB
 	swiotlb = 0;
 #endif
@@ -4658,6 +4708,7 @@ int __init intel_iommu_init(void)
 	bus_register_notifier(&pci_bus_type, &device_nb);
 	if (si_domain && !hw_pass_through)
 		register_memory_notifier(&intel_iommu_memory_nb);
+	register_hotcpu_notifier(&intel_iommu_cpu_nb);
 
 	intel_iommu_enabled = 1;
 
-- 
1.9.1
