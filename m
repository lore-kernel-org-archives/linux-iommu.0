From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH 05/10] iommu/amd: remove the special case from
	alloc_irq_table()
Date: Thu, 22 Mar 2018 16:22:37 +0100
Message-ID: <20180322152242.12705-6-bigeasy@linutronix.de>
References: <20180322152242.12705-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180322152242.12705-1-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Scott Wood <swood-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

alloc_irq_table() has a special ioapic argument. If set then it will
pre-allocate / reserve the first 32 indexes. The argument is only once
true and it would make alloc_irq_table() a little simpler if we would
extract the special bits to the caller.
The caller of irq_remapping_alloc() is holding irq_domain_mutex so the
initialization of iommu->irte_ops->set_allocated() should not race
against other user.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index a87d2fee68db..a5982a61f181 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3617,7 +3617,7 @@ static struct irq_remap_table *get_irq_table(u16 devid)
 	return table;
 }
 
-static struct irq_remap_table *alloc_irq_table(u16 devid, bool ioapic)
+static struct irq_remap_table *alloc_irq_table(u16 devid)
 {
 	struct irq_remap_table *table = NULL;
 	struct amd_iommu *iommu;
@@ -3651,10 +3651,6 @@ static struct irq_remap_table *alloc_irq_table(u16 devid, bool ioapic)
 	/* Initialize table spin-lock */
 	raw_spin_lock_init(&table->lock);
 
-	if (ioapic)
-		/* Keep the first 32 indexes free for IOAPIC interrupts */
-		table->min_index = 32;
-
 	table->table = kmem_cache_alloc(amd_iommu_irq_cache, GFP_ATOMIC);
 	if (!table->table) {
 		kfree(table);
@@ -3669,12 +3665,6 @@ static struct irq_remap_table *alloc_irq_table(u16 devid, bool ioapic)
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
@@ -3704,7 +3694,7 @@ static int alloc_irq_index(u16 devid, int count, bool align)
 	if (!iommu)
 		return -ENODEV;
 
-	table = alloc_irq_table(devid, false);
+	table = alloc_irq_table(devid);
 	if (!table)
 		return -ENODEV;
 
@@ -4130,10 +4120,26 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 		return ret;
 
 	if (info->type == X86_IRQ_ALLOC_TYPE_IOAPIC) {
-		if (alloc_irq_table(devid, true))
+		struct irq_remap_table *table;
+		struct amd_iommu *iommu;
+
+		table = alloc_irq_table(devid);
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
+			WARN_ON(table->min_index != 32);
 			index = info->ioapic_pin;
-		else
+		} else {
 			ret = -ENOMEM;
+		}
 	} else {
 		bool align = (info->type == X86_IRQ_ALLOC_TYPE_MSI);
 
-- 
2.16.2
