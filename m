From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH 09/10] iommu/amd: declare irq_remap_table's and amd_iommu's
	lock as a raw_spin_lock
Date: Fri, 23 Feb 2018 23:27:35 +0100
Message-ID: <20180223222736.18542-10-bigeasy@linutronix.de>
References: <20180223222736.18542-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180223222736.18542-1-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
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
Cc: tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

The irq affinity setting is called while desc->lock is held. The
desc->lock is a raw_spin_lock called with interrupts disabled. The
call chain involves modify_irte_ga() which needs to take the
irq_remap_table->lock in order to update the entry and later iommu->lock
in order to update and flush the iommu.
The latter is also required during table allocation.

I currently don't see a feasible way of getting this done without
turning both locks raw so here it is.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 drivers/iommu/amd_iommu.c       | 30 +++++++++++++++---------------
 drivers/iommu/amd_iommu_init.c  |  2 +-
 drivers/iommu/amd_iommu_types.h |  4 ++--
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index de6cc41d6cd2..04b7d263523f 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1052,9 +1052,9 @@ static int iommu_queue_command_sync(struct amd_iommu *iommu,
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&iommu->lock, flags);
+	raw_spin_lock_irqsave(&iommu->lock, flags);
 	ret = __iommu_queue_command_sync(iommu, cmd, sync);
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	raw_spin_unlock_irqrestore(&iommu->lock, flags);
 
 	return ret;
 }
@@ -1080,7 +1080,7 @@ static int iommu_completion_wait(struct amd_iommu *iommu)
 
 	build_completion_wait(&cmd, (u64)&iommu->cmd_sem);
 
-	spin_lock_irqsave(&iommu->lock, flags);
+	raw_spin_lock_irqsave(&iommu->lock, flags);
 
 	iommu->cmd_sem = 0;
 
@@ -1091,7 +1091,7 @@ static int iommu_completion_wait(struct amd_iommu *iommu)
 	ret = wait_on_sem(&iommu->cmd_sem);
 
 out_unlock:
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	raw_spin_unlock_irqrestore(&iommu->lock, flags);
 
 	return ret;
 }
@@ -3601,7 +3601,7 @@ static struct irq_remap_table *alloc_irq_table(void)
 		kfree(table);
 		return NULL;
 	}
-	spin_lock_init(&table->lock);
+	raw_spin_lock_init(&table->lock);
 
 	if (!AMD_IOMMU_GUEST_IR_GA(amd_iommu_guest_ir))
 		memset(table->table, 0,
@@ -3700,7 +3700,7 @@ static int alloc_irq_index(u16 devid, int count, bool align)
 	if (align)
 		alignment = roundup_pow_of_two(count);
 
-	spin_lock_irqsave(&table->lock, flags);
+	raw_spin_lock_irqsave(&table->lock, flags);
 
 	/* Scan table for free entries */
 	for (index = ALIGN(table->min_index, alignment), c = 0;
@@ -3727,7 +3727,7 @@ static int alloc_irq_index(u16 devid, int count, bool align)
 	index = -ENOSPC;
 
 out:
-	spin_unlock_irqrestore(&table->lock, flags);
+	raw_spin_unlock_irqrestore(&table->lock, flags);
 
 	return index;
 }
@@ -3748,7 +3748,7 @@ static int modify_irte_ga(u16 devid, int index, struct irte_ga *irte,
 	if (!table)
 		return -ENOMEM;
 
-	spin_lock_irqsave(&table->lock, flags);
+	raw_spin_lock_irqsave(&table->lock, flags);
 
 	entry = (struct irte_ga *)table->table;
 	entry = &entry[index];
@@ -3759,7 +3759,7 @@ static int modify_irte_ga(u16 devid, int index, struct irte_ga *irte,
 	if (data)
 		data->ref = entry;
 
-	spin_unlock_irqrestore(&table->lock, flags);
+	raw_spin_unlock_irqrestore(&table->lock, flags);
 
 	iommu_flush_irt(iommu, devid);
 	iommu_completion_wait(iommu);
@@ -3781,9 +3781,9 @@ static int modify_irte(u16 devid, int index, union irte *irte)
 	if (!table)
 		return -ENOMEM;
 
-	spin_lock_irqsave(&table->lock, flags);
+	raw_spin_lock_irqsave(&table->lock, flags);
 	table->table[index] = irte->val;
-	spin_unlock_irqrestore(&table->lock, flags);
+	raw_spin_unlock_irqrestore(&table->lock, flags);
 
 	iommu_flush_irt(iommu, devid);
 	iommu_completion_wait(iommu);
@@ -3805,9 +3805,9 @@ static void free_irte(u16 devid, int index)
 	if (!table)
 		return;
 
-	spin_lock_irqsave(&table->lock, flags);
+	raw_spin_lock_irqsave(&table->lock, flags);
 	iommu->irte_ops->clear_allocated(table, index);
-	spin_unlock_irqrestore(&table->lock, flags);
+	raw_spin_unlock_irqrestore(&table->lock, flags);
 
 	iommu_flush_irt(iommu, devid);
 	iommu_completion_wait(iommu);
@@ -4424,7 +4424,7 @@ int amd_iommu_update_ga(int cpu, bool is_run, void *data)
 	if (!table)
 		return -ENODEV;
 
-	spin_lock_irqsave(&table->lock, flags);
+	raw_spin_lock_irqsave(&table->lock, flags);
 
 	if (ref->lo.fields_vapic.guest_mode) {
 		if (cpu >= 0)
@@ -4433,7 +4433,7 @@ int amd_iommu_update_ga(int cpu, bool is_run, void *data)
 		barrier();
 	}
 
-	spin_unlock_irqrestore(&table->lock, flags);
+	raw_spin_unlock_irqrestore(&table->lock, flags);
 
 	iommu_flush_irt(iommu, devid);
 	iommu_completion_wait(iommu);
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 4e4a615bf13f..904c575d1677 100644
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
index 62d6f42b57c9..1c9b080276c9 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -408,7 +408,7 @@ extern bool amd_iommu_iotlb_sup;
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
2.16.1
