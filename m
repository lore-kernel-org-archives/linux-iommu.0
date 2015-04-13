From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part1 v8 11/37] irq_remapping/amd: Enhance AMD IR driver to
	support hierarchy irqdomain
Date: Mon, 13 Apr 2015 14:11:33 +0800
Message-ID: <1428905519-23704-12-git-send-email-jiang.liu@linux.intel.com>
References: <1428905519-23704-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1428905519-23704-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Dimitri Sivanich <sivanich-sJ/iWh9BUns@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Cohen <david.a.cohen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Sander Eikelenboom <linux-6SM94LqRVpn6gRhOQ7JHfg@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Vrabel <david.vrabel-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Enhance AMD interrupt remapping driver to support hierarchy irqdomain,
it will simplify the code eventually.

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Acked-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Link: http://lkml.kernel.org/r/1416894816-23245-12-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Signed-off-by: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 drivers/iommu/amd_iommu.c       |  329 ++++++++++++++++++++++++++++++++++++++-
 drivers/iommu/amd_iommu_init.c  |    4 +
 drivers/iommu/amd_iommu_proto.h |    9 ++
 drivers/iommu/amd_iommu_types.h |    5 +
 4 files changed, 341 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 48882c126245..db974bd348a1 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -33,6 +33,7 @@
 #include <linux/export.h>
 #include <linux/irq.h>
 #include <linux/msi.h>
+#include <linux/irqdomain.h>
 #include <asm/irq_remapping.h>
 #include <asm/io_apic.h>
 #include <asm/apic.h>
@@ -3857,6 +3858,16 @@ union irte {
 	} fields;
 };
 
+struct amd_ir_data {
+	struct irq_2_irte			irq_2_irte;
+	union irte				irte_entry;
+	union {
+		struct msi_msg			msi_entry;
+	};
+};
+
+static struct irq_chip amd_ir_chip;
+
 #define DTE_IRQ_PHYS_ADDR_MASK	(((1ULL << 45)-1) << 6)
 #define DTE_IRQ_REMAP_INTCTL    (2ULL << 60)
 #define DTE_IRQ_TABLE_LEN       (8ULL << 1)
@@ -3950,7 +3961,8 @@ out_unlock:
 	return table;
 }
 
-static int alloc_irq_index(struct irq_cfg *cfg, u16 devid, int count)
+static int alloc_irq_index(struct irq_cfg *cfg, struct irq_2_irte *irte_info,
+			   u16 devid, int count)
 {
 	struct irq_remap_table *table;
 	unsigned long flags;
@@ -3972,15 +3984,12 @@ static int alloc_irq_index(struct irq_cfg *cfg, u16 devid, int count)
 			c = 0;
 
 		if (c == count)	{
-			struct irq_2_irte *irte_info;
-
 			for (; c != 0; --c)
 				table->table[index - c + 1] = IRTE_ALLOCATED;
 
 			index -= count - 1;
 
 			cfg->remapped	      = 1;
-			irte_info             = &cfg->irq_2_irte;
 			irte_info->devid      = devid;
 			irte_info->index      = index;
 
@@ -4225,7 +4234,7 @@ static int msi_alloc_irq(struct pci_dev *pdev, int irq, int nvec)
 		return -EINVAL;
 
 	devid = get_device_id(&pdev->dev);
-	index = alloc_irq_index(cfg, devid, nvec);
+	index = alloc_irq_index(cfg, &cfg->irq_2_irte, devid, nvec);
 
 	return index < 0 ? MAX_IRQS_PER_TABLE : index;
 }
@@ -4272,7 +4281,7 @@ static int alloc_hpet_msi(unsigned int irq, unsigned int id)
 	if (devid < 0)
 		return devid;
 
-	index = alloc_irq_index(cfg, devid, 1);
+	index = alloc_irq_index(cfg, &cfg->irq_2_irte, devid, 1);
 	if (index < 0)
 		return index;
 
@@ -4283,6 +4292,72 @@ static int alloc_hpet_msi(unsigned int irq, unsigned int id)
 	return 0;
 }
 
+static int get_devid(struct irq_alloc_info *info)
+{
+	int devid = -1;
+
+	switch (info->type) {
+	case X86_IRQ_ALLOC_TYPE_IOAPIC:
+		devid     = get_ioapic_devid(info->ioapic_id);
+		break;
+	case X86_IRQ_ALLOC_TYPE_HPET:
+		devid     = get_hpet_devid(info->hpet_id);
+		break;
+	case X86_IRQ_ALLOC_TYPE_MSI:
+	case X86_IRQ_ALLOC_TYPE_MSIX:
+		devid = get_device_id(&info->msi_dev->dev);
+		break;
+	default:
+		BUG_ON(1);
+		break;
+	}
+
+	return devid;
+}
+
+static struct irq_domain *get_ir_irq_domain(struct irq_alloc_info *info)
+{
+	int devid;
+	struct amd_iommu *iommu;
+
+	if (!info)
+		return NULL;
+
+	devid = get_devid(info);
+	if (devid >= 0) {
+		iommu = amd_iommu_rlookup_table[devid];
+		if (iommu)
+			return iommu->ir_domain;
+	}
+
+	return NULL;
+}
+
+static struct irq_domain *get_irq_domain(struct irq_alloc_info *info)
+{
+	int devid;
+	struct amd_iommu *iommu;
+
+	if (!info)
+		return NULL;
+
+	switch (info->type) {
+	case X86_IRQ_ALLOC_TYPE_MSI:
+	case X86_IRQ_ALLOC_TYPE_MSIX:
+		devid = get_device_id(&info->msi_dev->dev);
+		if (devid >= 0) {
+			iommu = amd_iommu_rlookup_table[devid];
+			if (iommu)
+				return iommu->msi_domain;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return NULL;
+}
+
 struct irq_remap_ops amd_iommu_irq_ops = {
 	.prepare		= amd_iommu_prepare,
 	.enable			= amd_iommu_enable,
@@ -4296,5 +4371,247 @@ struct irq_remap_ops amd_iommu_irq_ops = {
 	.msi_alloc_irq		= msi_alloc_irq,
 	.msi_setup_irq		= msi_setup_irq,
 	.alloc_hpet_msi		= alloc_hpet_msi,
+	.get_ir_irq_domain	= get_ir_irq_domain,
+	.get_irq_domain		= get_irq_domain,
+};
+
+static void irq_remapping_prepare_irte(struct amd_ir_data *data,
+				       struct irq_cfg *irq_cfg,
+				       struct irq_alloc_info *info,
+				       int devid, int index, int sub_handle)
+{
+	union irte *irte = &data->irte_entry;
+	struct irq_2_irte *irte_info = &data->irq_2_irte;
+	struct msi_msg *msg = &data->msi_entry;
+	struct IO_APIC_route_entry *entry;
+
+	irq_cfg->remapped = 1;
+	data->irq_2_irte.devid = devid;
+	data->irq_2_irte.index = index + sub_handle;
+
+	/* Setup IRTE for IOMMU */
+	irte->val = 0;
+	irte->fields.vector      = irq_cfg->vector;
+	irte->fields.int_type    = apic->irq_delivery_mode;
+	irte->fields.destination = irq_cfg->dest_apicid;
+	irte->fields.dm          = apic->irq_dest_mode;
+	irte->fields.valid       = 1;
+
+	switch (info->type) {
+	case X86_IRQ_ALLOC_TYPE_IOAPIC:
+		/* Setup IOAPIC entry */
+		entry = info->ioapic_entry;
+		info->ioapic_entry = NULL;
+		memset(entry, 0, sizeof(*entry));
+		entry->vector        = index;
+		entry->mask          = 0;
+		entry->trigger       = info->ioapic_trigger;
+		entry->polarity      = info->ioapic_polarity;
+		/* Mask level triggered irqs. */
+		if (info->ioapic_trigger)
+			entry->mask = 1;
+		break;
+
+	case X86_IRQ_ALLOC_TYPE_HPET:
+	case X86_IRQ_ALLOC_TYPE_MSI:
+	case X86_IRQ_ALLOC_TYPE_MSIX:
+		msg->address_hi = MSI_ADDR_BASE_HI;
+		msg->address_lo = MSI_ADDR_BASE_LO;
+		msg->data = irte_info->index;
+		break;
+
+	default:
+		BUG_ON(1);
+		break;
+	}
+}
+
+static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
+			       unsigned int nr_irqs, void *arg)
+{
+	struct irq_alloc_info *info = arg;
+	struct amd_ir_data *data;
+	struct irq_data *irq_data;
+	struct irq_cfg *cfg;
+	int i, ret, devid;
+	int index = -1;
+
+	if (!info)
+		return -EINVAL;
+	if (nr_irqs > 1 && info->type != X86_IRQ_ALLOC_TYPE_MSI &&
+	    info->type != X86_IRQ_ALLOC_TYPE_MSIX)
+		return -EINVAL;
+
+	/*
+	 * With IRQ remapping enabled, don't need contigious CPU vectors
+	 * to support multiple MSI interrupts.
+	 */
+	if (info->type == X86_IRQ_ALLOC_TYPE_MSI)
+		info->flags &= ~X86_IRQ_ALLOC_CONTIGOUS_VECTORS;
+
+	devid = get_devid(info);
+	if (devid < 0)
+		return -EINVAL;
+
+	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
+	if (ret < 0)
+		return ret;
+
+	ret = -ENOMEM;
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		goto out_free_parent;
+
+	if (info->type == X86_IRQ_ALLOC_TYPE_IOAPIC) {
+		if (get_irq_table(devid, true))
+			index = info->ioapic_pin;
+		else
+			ret = -ENOMEM;
+	} else {
+		cfg = irq_cfg(virq);
+		index = alloc_irq_index(cfg, &data->irq_2_irte, devid, nr_irqs);
+	}
+	if (index < 0) {
+		pr_warn("Failed to allocate IRTE\n");
+		kfree(data);
+		goto out_free_parent;
+	}
+
+	for (i = 0; i < nr_irqs; i++) {
+		irq_data = irq_domain_get_irq_data(domain, virq + i);
+		cfg = irqd_cfg(irq_data);
+		if (!irq_data || !cfg) {
+			ret = -EINVAL;
+			goto out_free_data;
+		}
+
+		if (i > 0) {
+			data = kzalloc(sizeof(*data), GFP_KERNEL);
+			if (!data)
+				goto out_free_data;
+		}
+		irq_data->hwirq = (devid << 16) + i;
+		irq_data->chip_data = data;
+		irq_data->chip = &amd_ir_chip;
+		irq_remapping_prepare_irte(data, cfg, info, devid, index, i);
+		irq_set_status_flags(virq + i, IRQ_MOVE_PCNTXT);
+	}
+	return 0;
+
+out_free_data:
+	for (i--; i >= 0; i--) {
+		irq_data = irq_domain_get_irq_data(domain, virq + i);
+		if (irq_data)
+			kfree(irq_data->chip_data);
+	}
+	for (i = 0; i < nr_irqs; i++)
+		free_irte(devid, index + i);
+out_free_parent:
+	irq_domain_free_irqs_common(domain, virq, nr_irqs);
+	return ret;
+}
+
+static void irq_remapping_free(struct irq_domain *domain, unsigned int virq,
+			       unsigned int nr_irqs)
+{
+	struct irq_data *irq_data;
+	struct amd_ir_data *data;
+	struct irq_2_irte *irte_info;
+	int i;
+
+	for (i = 0; i < nr_irqs; i++) {
+		irq_data = irq_domain_get_irq_data(domain, virq  + i);
+		if (irq_data && irq_data->chip_data) {
+			data = irq_data->chip_data;
+			irte_info = &data->irq_2_irte;
+			free_irte(irte_info->devid, irte_info->index);
+			kfree(data);
+		}
+	}
+	irq_domain_free_irqs_common(domain, virq, nr_irqs);
+}
+
+static void irq_remapping_activate(struct irq_domain *domain,
+				   struct irq_data *irq_data)
+{
+	struct amd_ir_data *data = irq_data->chip_data;
+	struct irq_2_irte *irte_info = &data->irq_2_irte;
+
+	modify_irte(irte_info->devid, irte_info->index, data->irte_entry);
+}
+
+static void irq_remapping_deactivate(struct irq_domain *domain,
+				     struct irq_data *irq_data)
+{
+	struct amd_ir_data *data = irq_data->chip_data;
+	struct irq_2_irte *irte_info = &data->irq_2_irte;
+	union irte entry;
+
+	entry.val = 0;
+	modify_irte(irte_info->devid, irte_info->index, data->irte_entry);
+}
+
+static struct irq_domain_ops amd_ir_domain_ops = {
+	.alloc = irq_remapping_alloc,
+	.free = irq_remapping_free,
+	.activate = irq_remapping_activate,
+	.deactivate = irq_remapping_deactivate,
 };
+
+static int amd_ir_set_affinity(struct irq_data *data,
+			       const struct cpumask *mask, bool force)
+{
+	struct amd_ir_data *ir_data = data->chip_data;
+	struct irq_2_irte *irte_info = &ir_data->irq_2_irte;
+	struct irq_cfg *cfg = irqd_cfg(data);
+	struct irq_data *parent = data->parent_data;
+	int ret;
+
+	ret = parent->chip->irq_set_affinity(parent, mask, force);
+	if (ret < 0 || ret == IRQ_SET_MASK_OK_DONE)
+		return ret;
+
+	/*
+	 * Atomically updates the IRTE with the new destination, vector
+	 * and flushes the interrupt entry cache.
+	 */
+	ir_data->irte_entry.fields.vector = cfg->vector;
+	ir_data->irte_entry.fields.destination = cfg->dest_apicid;
+	modify_irte(irte_info->devid, irte_info->index, ir_data->irte_entry);
+
+	/*
+	 * After this point, all the interrupts will start arriving
+	 * at the new destination. So, time to cleanup the previous
+	 * vector allocation.
+	 */
+	if (cfg->move_in_progress)
+		send_cleanup_vector(cfg);
+
+	return IRQ_SET_MASK_OK_DONE;
+}
+
+static void ir_compose_msi_msg(struct irq_data *irq_data, struct msi_msg *msg)
+{
+	struct amd_ir_data *ir_data = irq_data->chip_data;
+
+	*msg = ir_data->msi_entry;
+}
+
+static struct irq_chip amd_ir_chip = {
+	.irq_ack = ir_ack_apic_edge,
+	.irq_set_affinity = amd_ir_set_affinity,
+	.irq_compose_msi_msg = ir_compose_msi_msg,
+};
+
+int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
+{
+	iommu->ir_domain = irq_domain_add_tree(NULL, &amd_ir_domain_ops, iommu);
+	if (!iommu->ir_domain)
+		return -ENOMEM;
+
+	iommu->ir_domain->parent = arch_get_ir_parent_domain();
+	iommu->msi_domain = arch_create_msi_irq_domain(iommu->ir_domain);
+
+	return 0;
+}
 #endif
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 450ef5001a65..c17df04d7a7f 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1124,6 +1124,10 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 	if (ret)
 		return ret;
 
+	ret = amd_iommu_create_irq_domain(iommu);
+	if (ret)
+		return ret;
+
 	/*
 	 * Make sure IOMMU is not considered to translate itself. The IVRS
 	 * table tells us so, but this is a lie!
diff --git a/drivers/iommu/amd_iommu_proto.h b/drivers/iommu/amd_iommu_proto.h
index 72b0fd455e24..0a21142d3639 100644
--- a/drivers/iommu/amd_iommu_proto.h
+++ b/drivers/iommu/amd_iommu_proto.h
@@ -62,6 +62,15 @@ extern u8 amd_iommu_pc_get_max_counters(u16 devid);
 extern int amd_iommu_pc_get_set_reg_val(u16 devid, u8 bank, u8 cntr, u8 fxn,
 				    u64 *value, bool is_write);
 
+#ifdef CONFIG_IRQ_REMAP
+extern int amd_iommu_create_irq_domain(struct amd_iommu *iommu);
+#else
+static inline int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
+{
+	return 0;
+}
+#endif
+
 #define PPR_SUCCESS			0x0
 #define PPR_INVALID			0x1
 #define PPR_FAILURE			0xf
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index c4fffb710c58..e2972a38c1ea 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -392,6 +392,7 @@ struct amd_iommu_fault {
 
 
 struct iommu_domain;
+struct irq_domain;
 
 /*
  * This structure contains generic data for  IOMMU protection domains
@@ -574,6 +575,10 @@ struct amd_iommu {
 	/* The maximum PC banks and counters/bank (PCSup=1) */
 	u8 max_banks;
 	u8 max_counters;
+#ifdef CONFIG_IRQ_REMAP
+	struct irq_domain *ir_domain;
+	struct irq_domain *msi_domain;
+#endif
 };
 
 struct devid_map {
-- 
1.7.10.4
