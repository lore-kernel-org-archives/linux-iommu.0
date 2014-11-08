From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part3 v3 19/38] iommu/vt-d: Clean up unsued code
Date: Sun,  9 Nov 2014 02:13:19 +0800
Message-ID: <1415470418-10874-20-git-send-email-jiang.liu@linux.intel.com>
References: <1415470418-10874-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1415470418-10874-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Now we have converted to hierarchy irqdomain, so clean up unused code.

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/intel_irq_remapping.c |  187 +----------------------------------
 1 file changed, 1 insertion(+), 186 deletions(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index b0c8113e7a9b..0040d7899285 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -63,35 +63,6 @@ static struct irq_domain_ops intel_ir_domain_ops;
 
 static int __init parse_ioapics_under_ir(void);
 
-static struct irq_2_iommu *irq_2_iommu(unsigned int irq)
-{
-	struct irq_cfg *cfg = irq_cfg(irq);
-	return cfg ? &cfg->irq_2_iommu : NULL;
-}
-
-static int get_irte(int irq, struct irte *entry)
-{
-	struct irq_2_iommu *irq_iommu = irq_2_iommu(irq);
-	unsigned long flags;
-	int index;
-
-	if (!entry || !irq_iommu)
-		return -1;
-
-	raw_spin_lock_irqsave(&irq_2_ir_lock, flags);
-
-	if (unlikely(!irq_iommu->iommu)) {
-		raw_spin_unlock_irqrestore(&irq_2_ir_lock, flags);
-		return -1;
-	}
-
-	index = irq_iommu->irte_index + irq_iommu->sub_handle;
-	*entry = *(irq_iommu->iommu->ir_table->base + index);
-
-	raw_spin_unlock_irqrestore(&irq_2_ir_lock, flags);
-	return 0;
-}
-
 static int alloc_irte(struct intel_iommu *iommu, int irq,
 		      struct irq_2_iommu *irq_iommu, u16 count)
 {
@@ -229,29 +200,6 @@ static int clear_entries(struct irq_2_iommu *irq_iommu)
 	return qi_flush_iec(iommu, index, irq_iommu->irte_mask);
 }
 
-static int free_irte(int irq)
-{
-	struct irq_2_iommu *irq_iommu = irq_2_iommu(irq);
-	unsigned long flags;
-	int rc;
-
-	if (!irq_iommu || irq_iommu->iommu == NULL)
-		return -1;
-
-	raw_spin_lock_irqsave(&irq_2_ir_lock, flags);
-
-	rc = clear_entries(irq_iommu);
-
-	irq_iommu->iommu = NULL;
-	irq_iommu->irte_index = 0;
-	irq_iommu->sub_handle = 0;
-	irq_iommu->irte_mask = 0;
-
-	raw_spin_unlock_irqrestore(&irq_2_ir_lock, flags);
-
-	return rc;
-}
-
 /*
  * source validation type
  */
@@ -875,8 +823,7 @@ error:
 	return -1;
 }
 
-static void prepare_irte(struct irte *irte, int vector,
-			 unsigned int dest)
+static void prepare_irte(struct irte *irte, int vector, unsigned int dest)
 {
 	memset(irte, 0, sizeof(*irte));
 
@@ -896,135 +843,6 @@ static void prepare_irte(struct irte *irte, int vector,
 	irte->redir_hint = 1;
 }
 
-static int intel_setup_ioapic_entry(int irq,
-				    struct IO_APIC_route_entry *route_entry,
-				    unsigned int destination, int vector,
-				    struct io_apic_irq_attr *attr)
-{
-	int ioapic_id = mpc_ioapic_id(attr->ioapic);
-	struct intel_iommu *iommu;
-	struct IR_IO_APIC_route_entry *entry;
-	struct irte irte;
-	int index;
-
-	down_read(&dmar_global_lock);
-	iommu = map_ioapic_to_ir(ioapic_id);
-	if (!iommu) {
-		pr_warn("No mapping iommu for ioapic %d\n", ioapic_id);
-		index = -ENODEV;
-	} else {
-		index = alloc_irte(iommu, irq, irq_2_iommu(irq), 1);
-		if (index < 0) {
-			pr_warn("Failed to allocate IRTE for ioapic %d\n",
-				ioapic_id);
-			index = -ENOMEM;
-		}
-	}
-	up_read(&dmar_global_lock);
-	if (index < 0)
-		return index;
-
-	prepare_irte(&irte, vector, destination);
-
-	/* Set source-id of interrupt request */
-	set_ioapic_sid(&irte, ioapic_id);
-
-	modify_irte(irq_2_iommu(irq), &irte);
-
-	apic_printk(APIC_VERBOSE, KERN_DEBUG "IOAPIC[%d]: "
-		"Set IRTE entry (P:%d FPD:%d Dst_Mode:%d "
-		"Redir_hint:%d Trig_Mode:%d Dlvry_Mode:%X "
-		"Avail:%X Vector:%02X Dest:%08X "
-		"SID:%04X SQ:%X SVT:%X)\n",
-		attr->ioapic, irte.present, irte.fpd, irte.dst_mode,
-		irte.redir_hint, irte.trigger_mode, irte.dlvry_mode,
-		irte.avail, irte.vector, irte.dest_id,
-		irte.sid, irte.sq, irte.svt);
-
-	entry = (struct IR_IO_APIC_route_entry *)route_entry;
-	memset(entry, 0, sizeof(*entry));
-
-	entry->index2	= (index >> 15) & 0x1;
-	entry->zero	= 0;
-	entry->format	= 1;
-	entry->index	= (index & 0x7fff);
-	/*
-	 * IO-APIC RTE will be configured with virtual vector.
-	 * irq handler will do the explicit EOI to the io-apic.
-	 */
-	entry->vector	= attr->ioapic_pin;
-	entry->mask	= 0;			/* enable IRQ */
-	entry->trigger	= attr->trigger;
-	entry->polarity	= attr->polarity;
-
-	/* Mask level triggered irqs.
-	 * Use IRQ_DELAYED_DISABLE for edge triggered irqs.
-	 */
-	if (attr->trigger)
-		entry->mask = 1;
-
-	return 0;
-}
-
-/*
- * Migrate the IO-APIC irq in the presence of intr-remapping.
- *
- * For both level and edge triggered, irq migration is a simple atomic
- * update(of vector and cpu destination) of IRTE and flush the hardware cache.
- *
- * For level triggered, we eliminate the io-apic RTE modification (with the
- * updated vector information), by using a virtual vector (io-apic pin number).
- * Real vector that is used for interrupting cpu will be coming from
- * the interrupt-remapping table entry.
- *
- * As the migration is a simple atomic update of IRTE, the same mechanism
- * is used to migrate MSI irq's in the presence of interrupt-remapping.
- */
-static int
-intel_ioapic_set_affinity(struct irq_data *data, const struct cpumask *mask,
-			  bool force)
-{
-	struct irq_cfg *cfg = irqd_cfg(data);
-	unsigned int dest, irq = data->irq;
-	struct irte irte;
-	int err;
-
-	if (get_irte(irq, &irte))
-		return -EBUSY;
-
-	err = assign_irq_vector(irq, cfg, mask);
-	if (err)
-		return err;
-
-	err = apic->cpu_mask_to_apicid_and(cfg->domain, mask, &dest);
-	if (err) {
-		if (assign_irq_vector(irq, cfg, data->affinity))
-			pr_err("Failed to recover vector for irq %d\n", irq);
-		return err;
-	}
-
-	irte.vector = cfg->vector;
-	irte.dest_id = IRTE_DEST(dest);
-
-	/*
-	 * Atomically updates the IRTE with the new destination, vector
-	 * and flushes the interrupt entry cache.
-	 */
-	modify_irte(irq_2_iommu(irq), &irte);
-
-	/*
-	 * After this point, all the interrupts will start arriving
-	 * at the new destination. So, time to cleanup the previous
-	 * vector allocation.
-	 */
-	if (cfg->move_in_progress)
-		send_cleanup_vector(cfg);
-
-	cpumask_copy(data->affinity, mask);
-
-	return 0;
-}
-
 static struct irq_domain *intel_get_ir_irq_domain(struct irq_alloc_info *info)
 {
 	struct intel_iommu *iommu = NULL;
@@ -1079,9 +897,6 @@ struct irq_remap_ops intel_irq_remap_ops = {
 	.disable		= disable_irq_remapping,
 	.reenable		= reenable_irq_remapping,
 	.enable_faulting	= enable_drhd_fault_handling,
-	.setup_ioapic_entry	= intel_setup_ioapic_entry,
-	.set_affinity		= intel_ioapic_set_affinity,
-	.free_irq		= free_irte,
 	.get_ir_irq_domain	= intel_get_ir_irq_domain,
 	.get_irq_domain		= intel_get_irq_domain,
 };
-- 
1.7.10.4
