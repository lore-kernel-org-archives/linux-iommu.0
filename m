From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH 05/10] iommu/amd: remove the special case from get_irq_table()
Date: Fri, 23 Feb 2018 23:27:31 +0100
Message-ID: <20180223222736.18542-6-bigeasy@linutronix.de>
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

get_irq_table() has a special ioapic argument. If set then it will
pre-allocate / reserve the first 32 indexes. The argument is only once
true and it would make get_irq_table() a little simpler if we would
extract the special bits to the caller.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 72487ac43eef..19de479fe21c 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3588,7 +3588,7 @@ static void set_dte_irq_entry(u16 devid, struct irq_remap_table *table)
 	amd_iommu_dev_table[devid].data[2] = dte;
 }
 
-static struct irq_remap_table *get_irq_table(u16 devid, bool ioapic)
+static struct irq_remap_table *get_irq_table(u16 devid)
 {
 	struct irq_remap_table *table = NULL;
 	struct amd_iommu *iommu;
@@ -3622,10 +3622,6 @@ static struct irq_remap_table *get_irq_table(u16 devid, bool ioapic)
 	/* Initialize table spin-lock */
 	spin_lock_init(&table->lock);
 
-	if (ioapic)
-		/* Keep the first 32 indexes free for IOAPIC interrupts */
-		table->min_index = 32;
-
 	table->table = kmem_cache_alloc(amd_iommu_irq_cache, GFP_ATOMIC);
 	if (!table->table) {
 		kfree(table);
@@ -3640,12 +3636,6 @@ static struct irq_remap_table *get_irq_table(u16 devid, bool ioapic)
 		memset(table->table, 0,
 		       (MAX_IRQS_PER_TABLE * (sizeof(u64) * 2)));
 
-	if (ioapic) {
-		int i;
-
-		for (i = 0; i < 32; ++i)
-			iommu->irte_ops->set_allocated(table, i);
-	}
 
 	irq_lookup_table[devid] = table;
 	set_dte_irq_entry(devid, table);
@@ -3675,7 +3665,7 @@ static int alloc_irq_index(u16 devid, int count, bool align)
 	if (!iommu)
 		return -ENODEV;
 
-	table = get_irq_table(devid, false);
+	table = get_irq_table(devid);
 	if (!table)
 		return -ENODEV;
 
@@ -3726,7 +3716,7 @@ static int modify_irte_ga(u16 devid, int index, struct irte_ga *irte,
 	if (iommu == NULL)
 		return -EINVAL;
 
-	table = get_irq_table(devid, false);
+	table = get_irq_table(devid);
 	if (!table)
 		return -ENOMEM;
 
@@ -3759,7 +3749,7 @@ static int modify_irte(u16 devid, int index, union irte *irte)
 	if (iommu == NULL)
 		return -EINVAL;
 
-	table = get_irq_table(devid, false);
+	table = get_irq_table(devid);
 	if (!table)
 		return -ENOMEM;
 
@@ -3783,7 +3773,7 @@ static void free_irte(u16 devid, int index)
 	if (iommu == NULL)
 		return;
 
-	table = get_irq_table(devid, false);
+	table = get_irq_table(devid);
 	if (!table)
 		return;
 
@@ -4103,10 +4093,26 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 		return ret;
 
 	if (info->type == X86_IRQ_ALLOC_TYPE_IOAPIC) {
-		if (get_irq_table(devid, true))
+		struct irq_remap_table *table;
+		struct amd_iommu *iommu;
+
+		table = get_irq_table(devid);
+		if (table) {
+			if (!table->min_index) {
+				/*
+				 * Keep the first 32 indexes free for IOAPIC
+				 * interrupts.
+				 */
+				table->min_index = 32;
+				iommu = amd_iommu_rlookup_table[devid];
+				for (i = 0; i < 32; ++i)
+					iommu->irte_ops->set_allocated(table, i);
+			}
 			index = info->ioapic_pin;
-		else
+			WARN_ON(table->min_index != 32);
+		} else {
 			ret = -ENOMEM;
+		}
 	} else {
 		bool align = (info->type == X86_IRQ_ALLOC_TYPE_MSI);
 
@@ -4386,7 +4392,7 @@ int amd_iommu_update_ga(int cpu, bool is_run, void *data)
 	if (!iommu)
 		return -ENODEV;
 
-	irt = get_irq_table(devid, false);
+	irt = get_irq_table(devid);
 	if (!irt)
 		return -ENODEV;
 
-- 
2.16.1
