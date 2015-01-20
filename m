From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part1 v7 15/38] irq_remapping/vt-d: Clean up unused MSI
	related code
Date: Tue, 20 Jan 2015 11:08:18 +0800
Message-ID: <1421723321-8386-16-git-send-email-jiang.liu@linux.intel.com>
References: <1421723321-8386-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1421723321-8386-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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

Now MSI interrupt has been converted to new hierarchy irqdomain
interfaces, so kill legacy MSI related code.

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
Link: http://lkml.kernel.org/r/1416894816-23245-16-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Signed-off-by: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 drivers/iommu/intel_irq_remapping.c |  144 -----------------------------------
 1 file changed, 144 deletions(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index f2dbb0d54d17..91c0fc65713d 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -145,44 +145,6 @@ static int qi_flush_iec(struct intel_iommu *iommu, int index, int mask)
 	return qi_submit_sync(&desc, iommu);
 }
 
-static int map_irq_to_irte_handle(int irq, u16 *sub_handle)
-{
-	struct irq_2_iommu *irq_iommu = irq_2_iommu(irq);
-	unsigned long flags;
-	int index;
-
-	if (!irq_iommu)
-		return -1;
-
-	raw_spin_lock_irqsave(&irq_2_ir_lock, flags);
-	*sub_handle = irq_iommu->sub_handle;
-	index = irq_iommu->irte_index;
-	raw_spin_unlock_irqrestore(&irq_2_ir_lock, flags);
-	return index;
-}
-
-static int set_irte_irq(int irq, struct intel_iommu *iommu, u16 index, u16 subhandle)
-{
-	struct irq_2_iommu *irq_iommu = irq_2_iommu(irq);
-	struct irq_cfg *cfg = irq_cfg(irq);
-	unsigned long flags;
-
-	if (!irq_iommu)
-		return -1;
-
-	raw_spin_lock_irqsave(&irq_2_ir_lock, flags);
-
-	cfg->remapped = 1;
-	irq_iommu->iommu = iommu;
-	irq_iommu->irte_index = index;
-	irq_iommu->sub_handle = subhandle;
-	irq_iommu->irte_mask = 0;
-
-	raw_spin_unlock_irqrestore(&irq_2_ir_lock, flags);
-
-	return 0;
-}
-
 static int modify_irte(struct irq_2_iommu *irq_iommu,
 		       struct irte *irte_modified)
 {
@@ -1127,108 +1089,6 @@ intel_ioapic_set_affinity(struct irq_data *data, const struct cpumask *mask,
 	return 0;
 }
 
-static void intel_compose_msi_msg(struct pci_dev *pdev,
-				  unsigned int irq, unsigned int dest,
-				  struct msi_msg *msg, u8 hpet_id)
-{
-	struct irq_cfg *cfg;
-	struct irte irte;
-	u16 sub_handle = 0;
-	int ir_index;
-
-	cfg = irq_cfg(irq);
-
-	ir_index = map_irq_to_irte_handle(irq, &sub_handle);
-	BUG_ON(ir_index == -1);
-
-	prepare_irte(&irte, cfg->vector, dest);
-
-	/* Set source-id of interrupt request */
-	if (pdev)
-		set_msi_sid(&irte, pdev);
-	else
-		set_hpet_sid(&irte, hpet_id);
-
-	modify_irte(irq_2_iommu(irq), &irte);
-
-	msg->address_hi = MSI_ADDR_BASE_HI;
-	msg->data = sub_handle;
-	msg->address_lo = MSI_ADDR_BASE_LO | MSI_ADDR_IR_EXT_INT |
-			  MSI_ADDR_IR_SHV |
-			  MSI_ADDR_IR_INDEX1(ir_index) |
-			  MSI_ADDR_IR_INDEX2(ir_index);
-}
-
-/*
- * Map the PCI dev to the corresponding remapping hardware unit
- * and allocate 'nvec' consecutive interrupt-remapping table entries
- * in it.
- */
-static int intel_msi_alloc_irq(struct pci_dev *dev, int irq, int nvec)
-{
-	struct intel_iommu *iommu;
-	int index;
-
-	down_read(&dmar_global_lock);
-	iommu = map_dev_to_ir(dev);
-	if (!iommu) {
-		printk(KERN_ERR
-		       "Unable to map PCI %s to iommu\n", pci_name(dev));
-		index = -ENOENT;
-	} else {
-		index = alloc_irte(iommu, irq, irq_2_iommu(irq), nvec);
-		if (index < 0) {
-			printk(KERN_ERR
-			       "Unable to allocate %d IRTE for PCI %s\n",
-			       nvec, pci_name(dev));
-			index = -ENOSPC;
-		}
-	}
-	up_read(&dmar_global_lock);
-
-	return index;
-}
-
-static int intel_msi_setup_irq(struct pci_dev *pdev, unsigned int irq,
-			       int index, int sub_handle)
-{
-	struct intel_iommu *iommu;
-	int ret = -ENOENT;
-
-	down_read(&dmar_global_lock);
-	iommu = map_dev_to_ir(pdev);
-	if (iommu) {
-		/*
-		 * setup the mapping between the irq and the IRTE
-		 * base index, the sub_handle pointing to the
-		 * appropriate interrupt remap table entry.
-		 */
-		set_irte_irq(irq, iommu, index, sub_handle);
-		ret = 0;
-	}
-	up_read(&dmar_global_lock);
-
-	return ret;
-}
-
-static int intel_alloc_hpet_msi(unsigned int irq, unsigned int id)
-{
-	int ret = -1;
-	struct intel_iommu *iommu;
-	int index;
-
-	down_read(&dmar_global_lock);
-	iommu = map_hpet_to_ir(id);
-	if (iommu) {
-		index = alloc_irte(iommu, irq, irq_2_iommu(irq), 1);
-		if (index >= 0)
-			ret = 0;
-	}
-	up_read(&dmar_global_lock);
-
-	return ret;
-}
-
 static struct irq_domain *intel_get_ir_irq_domain(struct irq_alloc_info *info)
 {
 	struct intel_iommu *iommu = NULL;
@@ -1285,10 +1145,6 @@ struct irq_remap_ops intel_irq_remap_ops = {
 	.setup_ioapic_entry	= intel_setup_ioapic_entry,
 	.set_affinity		= intel_ioapic_set_affinity,
 	.free_irq		= free_irte,
-	.compose_msi_msg	= intel_compose_msi_msg,
-	.msi_alloc_irq		= intel_msi_alloc_irq,
-	.msi_setup_irq		= intel_msi_setup_irq,
-	.alloc_hpet_msi		= intel_alloc_hpet_msi,
 	.get_ir_irq_domain	= intel_get_ir_irq_domain,
 	.get_irq_domain		= intel_get_irq_domain,
 };
-- 
1.7.10.4
