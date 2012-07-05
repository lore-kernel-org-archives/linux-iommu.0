From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 21/28] iommu/amd: Add IOAPIC remapping routines
Date: Thu, 5 Jul 2012 14:36:41 +0200
Message-ID: <1341491808-23083-22-git-send-email-joerg.roedel@amd.com>
References: <1341491808-23083-1-git-send-email-joerg.roedel@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1341491808-23083-1-git-send-email-joerg.roedel-5C7GfCeVMHo@public.gmane.org>
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
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Add the routine to setup interrupt remapping for ioapic
interrupts. Also add a routine to change the affinity of an
irq and to free an irq allocation for interrupt remapping.
The last two functions will also be used for MSI interrupts.

Signed-off-by: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu.c |  119 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 6ec44ab..dc2e699 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3935,4 +3935,123 @@ static void free_irte(u16 devid, int index)
 	iommu_completion_wait(iommu);
 }
 
+static int setup_ioapic_entry(int irq, struct IO_APIC_route_entry *entry,
+			      unsigned int destination, int vector,
+			      struct io_apic_irq_attr *attr)
+{
+	struct irq_remap_table *table;
+	struct irq_2_irte *irte_info;
+	struct irq_cfg *cfg;
+	union irte irte;
+	int ioapic_id;
+	int index;
+	int devid;
+	int ret;
+
+	cfg = irq_get_chip_data(irq);
+	if (!cfg)
+		return -EINVAL;
+
+	irte_info = &cfg->irq_remap_info.irq_2_irte;
+	ioapic_id = mpc_ioapic_id(attr->ioapic);
+	devid     = get_ioapic_devid(ioapic_id);
+
+	if (devid < 0)
+		return devid;
+
+	table = get_irq_table(devid, true);
+	if (table == NULL)
+		return -ENOMEM;
+
+	index = attr->ioapic_pin;
+
+	/* Setup IRQ remapping info */
+	irte_info->devid = devid;
+	irte_info->index = index;
+	cfg->remapped    = true;
+
+	/* Setup IRTE for IOMMU */
+	irte.val		= 0;
+	irte.fields.vector      = vector;
+	irte.fields.int_type    = apic->irq_delivery_mode;
+	irte.fields.destination = destination;
+	irte.fields.dm          = apic->irq_dest_mode;
+	irte.fields.valid       = 1;
+
+	ret = modify_irte(devid, index, irte);
+	if (ret)
+		return ret;
+
+	/* Setup IOAPIC entry */
+	memset(entry, 0, sizeof(*entry));
+
+	entry->vector        = index;
+	entry->mask          = 0;
+	entry->trigger       = attr->trigger;
+	entry->polarity      = attr->polarity;
+
+	/*
+	 * Mask level triggered irqs.
+	 * Use IRQ_DELAYED_DISABLE for edge triggered irqs.
+	 */
+	if (attr->trigger)
+		entry->mask = 1;
+
+	return 0;
+}
+
+#ifdef CONFIG_SMP
+static int set_affinity(struct irq_data *data, const struct cpumask *mask,
+			bool force)
+{
+	struct irq_2_irte *irte_info;
+	unsigned int dest, irq;
+	struct irq_cfg *cfg;
+	union irte irte;
+
+	cfg       = data->chip_data;
+	irq       = data->irq;
+	irte_info = &cfg->irq_remap_info.irq_2_irte;
+
+	if (!cpumask_intersects(mask, cpu_online_mask))
+		return -EINVAL;
+
+	if (get_irte(irte_info->devid, irte_info->index, &irte))
+		return -EBUSY;
+
+	if (assign_irq_vector(irq, cfg, mask))
+		return -EBUSY;
+
+	dest = apic->cpu_mask_to_apicid_and(cfg->domain, mask);
+
+	irte.fields.vector      = cfg->vector;
+	irte.fields.destination = dest;
+
+	modify_irte(irte_info->devid, irte_info->index, irte);
+
+	if (cfg->move_in_progress)
+		send_cleanup_vector(cfg);
+
+	cpumask_copy(data->affinity, mask);
+
+	return 0;
+}
+#endif /* CONFIG_SMP */
+
+static int free_irq(int irq)
+{
+	struct irq_2_irte *irte_info;
+	struct irq_cfg *cfg;
+
+	cfg = irq_get_chip_data(irq);
+	if (!cfg)
+		return -EINVAL;
+
+	irte_info = &cfg->irq_remap_info.irq_2_irte;
+
+	free_irte(irte_info->devid, irte_info->index);
+
+	return 0;
+}
+
 #endif
-- 
1.7.9.5
