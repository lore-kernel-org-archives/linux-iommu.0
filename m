From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part1 v7 16/38] irq_remapping/amd: Clean up unused MSI related
	code
Date: Tue, 20 Jan 2015 11:08:19 +0800
Message-ID: <1421723321-8386-17-git-send-email-jiang.liu@linux.intel.com>
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
Link: http://lkml.kernel.org/r/1416894816-23245-17-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Signed-off-by: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 drivers/iommu/amd_iommu.c |  115 +--------------------------------------------
 1 file changed, 2 insertions(+), 113 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 83ed2fdad4ef..c3efde454220 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3961,8 +3961,7 @@ out_unlock:
 	return table;
 }
 
-static int alloc_irq_index(struct irq_cfg *cfg, struct irq_2_irte *irte_info,
-			   u16 devid, int count)
+static int alloc_irq_index(u16 devid, int count)
 {
 	struct irq_remap_table *table;
 	unsigned long flags;
@@ -3988,11 +3987,6 @@ static int alloc_irq_index(struct irq_cfg *cfg, struct irq_2_irte *irte_info,
 				table->table[index - c + 1] = IRTE_ALLOCATED;
 
 			index -= count - 1;
-
-			cfg->remapped	      = 1;
-			irte_info->devid      = devid;
-			irte_info->index      = index;
-
 			goto out;
 		}
 	}
@@ -4192,106 +4186,6 @@ static int free_irq(int irq)
 	return 0;
 }
 
-static void compose_msi_msg(struct pci_dev *pdev,
-			    unsigned int irq, unsigned int dest,
-			    struct msi_msg *msg, u8 hpet_id)
-{
-	struct irq_2_irte *irte_info;
-	struct irq_cfg *cfg;
-	union irte irte;
-
-	cfg = irq_cfg(irq);
-	if (!cfg)
-		return;
-
-	irte_info = &cfg->irq_2_irte;
-
-	irte.val		= 0;
-	irte.fields.vector	= cfg->vector;
-	irte.fields.int_type    = apic->irq_delivery_mode;
-	irte.fields.destination	= dest;
-	irte.fields.dm		= apic->irq_dest_mode;
-	irte.fields.valid	= 1;
-
-	modify_irte(irte_info->devid, irte_info->index, irte);
-
-	msg->address_hi = MSI_ADDR_BASE_HI;
-	msg->address_lo = MSI_ADDR_BASE_LO;
-	msg->data       = irte_info->index;
-}
-
-static int msi_alloc_irq(struct pci_dev *pdev, int irq, int nvec)
-{
-	struct irq_cfg *cfg;
-	int index;
-	u16 devid;
-
-	if (!pdev)
-		return -EINVAL;
-
-	cfg = irq_cfg(irq);
-	if (!cfg)
-		return -EINVAL;
-
-	devid = get_device_id(&pdev->dev);
-	index = alloc_irq_index(cfg, &cfg->irq_2_irte, devid, nvec);
-
-	return index < 0 ? MAX_IRQS_PER_TABLE : index;
-}
-
-static int msi_setup_irq(struct pci_dev *pdev, unsigned int irq,
-			 int index, int offset)
-{
-	struct irq_2_irte *irte_info;
-	struct irq_cfg *cfg;
-	u16 devid;
-
-	if (!pdev)
-		return -EINVAL;
-
-	cfg = irq_cfg(irq);
-	if (!cfg)
-		return -EINVAL;
-
-	if (index >= MAX_IRQS_PER_TABLE)
-		return 0;
-
-	devid		= get_device_id(&pdev->dev);
-	irte_info	= &cfg->irq_2_irte;
-
-	cfg->remapped	      = 1;
-	irte_info->devid      = devid;
-	irte_info->index      = index + offset;
-
-	return 0;
-}
-
-static int alloc_hpet_msi(unsigned int irq, unsigned int id)
-{
-	struct irq_2_irte *irte_info;
-	struct irq_cfg *cfg;
-	int index, devid;
-
-	cfg = irq_cfg(irq);
-	if (!cfg)
-		return -EINVAL;
-
-	irte_info = &cfg->irq_2_irte;
-	devid     = get_hpet_devid(id);
-	if (devid < 0)
-		return devid;
-
-	index = alloc_irq_index(cfg, &cfg->irq_2_irte, devid, 1);
-	if (index < 0)
-		return index;
-
-	cfg->remapped	      = 1;
-	irte_info->devid      = devid;
-	irte_info->index      = index;
-
-	return 0;
-}
-
 static int get_devid(struct irq_alloc_info *info)
 {
 	int devid = -1;
@@ -4367,10 +4261,6 @@ struct irq_remap_ops amd_iommu_irq_ops = {
 	.setup_ioapic_entry	= setup_ioapic_entry,
 	.set_affinity		= set_affinity,
 	.free_irq		= free_irq,
-	.compose_msi_msg	= compose_msi_msg,
-	.msi_alloc_irq		= msi_alloc_irq,
-	.msi_setup_irq		= msi_setup_irq,
-	.alloc_hpet_msi		= alloc_hpet_msi,
 	.get_ir_irq_domain	= get_ir_irq_domain,
 	.get_irq_domain		= get_irq_domain,
 };
@@ -4468,8 +4358,7 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 		else
 			ret = -ENOMEM;
 	} else {
-		cfg = irq_cfg(virq);
-		index = alloc_irq_index(cfg, &data->irq_2_irte, devid, nr_irqs);
+		index = alloc_irq_index(devid, nr_irqs);
 	}
 	if (index < 0) {
 		pr_warn("Failed to allocate IRTE\n");
-- 
1.7.10.4
