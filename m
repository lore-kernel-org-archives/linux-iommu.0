From: Scott Wood <swood-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2] amd/iommu: Use raw locks on atomic context paths
Date: Sun, 21 Jan 2018 03:28:54 -0600
Message-ID: <20180121092854.28290-2-swood@redhat.com>
References: <20180121092854.28290-1-swood@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180121092854.28290-1-swood-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "Luis Claudio R. Goncalves" <lgoncalv-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Clark Williams <williams-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Myron Stowe <myron.stowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Scott Wood <swood-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Several functions in this driver are called from atomic context,
and thus raw locks must be used in order to be safe on PREEMPT_RT.

This includes paths that must wait for command completion, which is
a potential PREEMPT_RT latency concern but not easily avoidable.

Signed-off-by: Scott Wood <swood-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu.c       | 30 +++++++++++++++---------------
 drivers/iommu/amd_iommu_init.c  |  2 +-
 drivers/iommu/amd_iommu_types.h |  4 ++--
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 8ead1b296d09..213f5a796ae5 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1055,9 +1055,9 @@ static int iommu_queue_command_sync(struct amd_iommu *iommu,
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&iommu->lock, flags);
+	raw_spin_lock_irqsave(&iommu->lock, flags);
 	ret = __iommu_queue_command_sync(iommu, cmd, sync);
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	raw_spin_unlock_irqrestore(&iommu->lock, flags);
 
 	return ret;
 }
@@ -1083,7 +1083,7 @@ static int iommu_completion_wait(struct amd_iommu *iommu)
 
 	build_completion_wait(&cmd, (u64)&iommu->cmd_sem);
 
-	spin_lock_irqsave(&iommu->lock, flags);
+	raw_spin_lock_irqsave(&iommu->lock, flags);
 
 	iommu->cmd_sem = 0;
 
@@ -1094,7 +1094,7 @@ static int iommu_completion_wait(struct amd_iommu *iommu)
 	ret = wait_on_sem(&iommu->cmd_sem);
 
 out_unlock:
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	raw_spin_unlock_irqrestore(&iommu->lock, flags);
 
 	return ret;
 }
@@ -3626,7 +3626,7 @@ static struct irq_remap_table *get_irq_table(u16 devid, bool ioapic)
 		goto out_unlock;
 
 	/* Initialize table spin-lock */
-	spin_lock_init(&table->lock);
+	raw_spin_lock_init(&table->lock);
 
 	if (ioapic)
 		/* Keep the first 32 indexes free for IOAPIC interrupts */
@@ -3688,7 +3688,7 @@ static int alloc_irq_index(u16 devid, int count, bool align)
 	if (align)
 		alignment = roundup_pow_of_two(count);
 
-	spin_lock_irqsave(&table->lock, flags);
+	raw_spin_lock_irqsave(&table->lock, flags);
 
 	/* Scan table for free entries */
 	for (index = ALIGN(table->min_index, alignment), c = 0;
@@ -3715,7 +3715,7 @@ static int alloc_irq_index(u16 devid, int count, bool align)
 	index = -ENOSPC;
 
 out:
-	spin_unlock_irqrestore(&table->lock, flags);
+	raw_spin_unlock_irqrestore(&table->lock, flags);
 
 	return index;
 }
@@ -3736,7 +3736,7 @@ static int modify_irte_ga(u16 devid, int index, struct irte_ga *irte,
 	if (!table)
 		return -ENOMEM;
 
-	spin_lock_irqsave(&table->lock, flags);
+	raw_spin_lock_irqsave(&table->lock, flags);
 
 	entry = (struct irte_ga *)table->table;
 	entry = &entry[index];
@@ -3747,7 +3747,7 @@ static int modify_irte_ga(u16 devid, int index, struct irte_ga *irte,
 	if (data)
 		data->ref = entry;
 
-	spin_unlock_irqrestore(&table->lock, flags);
+	raw_spin_unlock_irqrestore(&table->lock, flags);
 
 	iommu_flush_irt(iommu, devid);
 	iommu_completion_wait(iommu);
@@ -3769,9 +3769,9 @@ static int modify_irte(u16 devid, int index, union irte *irte)
 	if (!table)
 		return -ENOMEM;
 
-	spin_lock_irqsave(&table->lock, flags);
+	raw_spin_lock_irqsave(&table->lock, flags);
 	table->table[index] = irte->val;
-	spin_unlock_irqrestore(&table->lock, flags);
+	raw_spin_unlock_irqrestore(&table->lock, flags);
 
 	iommu_flush_irt(iommu, devid);
 	iommu_completion_wait(iommu);
@@ -3793,9 +3793,9 @@ static void free_irte(u16 devid, int index)
 	if (!table)
 		return;
 
-	spin_lock_irqsave(&table->lock, flags);
+	raw_spin_lock_irqsave(&table->lock, flags);
 	iommu->irte_ops->clear_allocated(table, index);
-	spin_unlock_irqrestore(&table->lock, flags);
+	raw_spin_unlock_irqrestore(&table->lock, flags);
 
 	iommu_flush_irt(iommu, devid);
 	iommu_completion_wait(iommu);
@@ -4396,7 +4396,7 @@ int amd_iommu_update_ga(int cpu, bool is_run, void *data)
 	if (!irt)
 		return -ENODEV;
 
-	spin_lock_irqsave(&irt->lock, flags);
+	raw_spin_lock_irqsave(&irt->lock, flags);
 
 	if (ref->lo.fields_vapic.guest_mode) {
 		if (cpu >= 0)
@@ -4405,7 +4405,7 @@ int amd_iommu_update_ga(int cpu, bool is_run, void *data)
 		barrier();
 	}
 
-	spin_unlock_irqrestore(&irt->lock, flags);
+	raw_spin_unlock_irqrestore(&irt->lock, flags);
 
 	iommu_flush_irt(iommu, devid);
 	iommu_completion_wait(iommu);
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 6fe2d0346073..e3cd81b32a33 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1474,7 +1474,7 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 {
 	int ret;
 
-	spin_lock_init(&iommu->lock);
+	raw_spin_lock_init(&iommu->lock);
 
 	/* Add IOMMU to internal data structures */
 	list_add_tail(&iommu->list, &amd_iommu_list);
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 6a877ebd058b..da886b0095aa 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -408,7 +408,7 @@
 #define IRQ_TABLE_ALIGNMENT	128
 
 struct irq_remap_table {
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	unsigned min_index;
 	u32 *table;
 };
@@ -490,7 +490,7 @@ struct amd_iommu {
 	int index;
 
 	/* locks the accesses to the hardware */
-	spinlock_t lock;
+	raw_spinlock_t lock;
 
 	/* Pointer to PCI device of this IOMMU */
 	struct pci_dev *dev;
-- 
1.8.3.1
