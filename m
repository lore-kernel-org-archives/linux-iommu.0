From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch v1 17/17] iommu/irq_remapping: Normailize the way to detect
	whether IR is enabled
Date: Wed, 17 Dec 2014 12:35:48 +0800
Message-ID: <1418790948-22804-18-git-send-email-jiang.liu@linux.intel.com>
References: <1418790948-22804-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1418790948-22804-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Cc: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Refine code by normailizing the way to detect whether IR is enabled.

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/irq_remapping.c |   38 ++++++++++++++------------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index c6fdca412e71..10f4894a37e9 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -218,7 +218,7 @@ int __init irq_remapping_enable(void)
 {
 	int ret;
 
-	if (!remap_ops || !remap_ops->enable)
+	if (!remap_ops->enable)
 		return -ENODEV;
 
 	ret = remap_ops->enable();
@@ -231,22 +231,16 @@ int __init irq_remapping_enable(void)
 
 void irq_remapping_disable(void)
 {
-	if (!irq_remapping_enabled ||
-	    !remap_ops ||
-	    !remap_ops->disable)
-		return;
-
-	remap_ops->disable();
+	if (irq_remapping_enabled && remap_ops->disable)
+		remap_ops->disable();
 }
 
 int irq_remapping_reenable(int mode)
 {
-	if (!irq_remapping_enabled ||
-	    !remap_ops ||
-	    !remap_ops->reenable)
-		return 0;
+	if (irq_remapping_enabled && remap_ops->reenable)
+		return remap_ops->reenable(mode);
 
-	return remap_ops->reenable(mode);
+	return 0;
 }
 
 int __init irq_remap_enable_fault_handling(void)
@@ -254,7 +248,7 @@ int __init irq_remap_enable_fault_handling(void)
 	if (!irq_remapping_enabled)
 		return 0;
 
-	if (!remap_ops || !remap_ops->enable_faulting)
+	if (!remap_ops->enable_faulting)
 		return -ENODEV;
 
 	return remap_ops->enable_faulting();
@@ -265,7 +259,7 @@ int setup_ioapic_remapped_entry(int irq,
 				unsigned int destination, int vector,
 				struct io_apic_irq_attr *attr)
 {
-	if (!remap_ops || !remap_ops->setup_ioapic_entry)
+	if (!remap_ops->setup_ioapic_entry)
 		return -ENODEV;
 
 	return remap_ops->setup_ioapic_entry(irq, entry, destination,
@@ -275,8 +269,7 @@ int setup_ioapic_remapped_entry(int irq,
 static int set_remapped_irq_affinity(struct irq_data *data,
 				     const struct cpumask *mask, bool force)
 {
-	if (!config_enabled(CONFIG_SMP) || !remap_ops ||
-	    !remap_ops->set_affinity)
+	if (!config_enabled(CONFIG_SMP) || !remap_ops->set_affinity)
 		return 0;
 
 	return remap_ops->set_affinity(data, mask, force);
@@ -286,10 +279,7 @@ void free_remapped_irq(int irq)
 {
 	struct irq_cfg *cfg = irq_get_chip_data(irq);
 
-	if (!remap_ops || !remap_ops->free_irq)
-		return;
-
-	if (irq_remapped(cfg))
+	if (irq_remapped(cfg) && remap_ops->free_irq)
 		remap_ops->free_irq(irq);
 }
 
@@ -301,13 +291,13 @@ void compose_remapped_msi_msg(struct pci_dev *pdev,
 
 	if (!irq_remapped(cfg))
 		native_compose_msi_msg(pdev, irq, dest, msg, hpet_id);
-	else if (remap_ops && remap_ops->compose_msi_msg)
+	else if (remap_ops->compose_msi_msg)
 		remap_ops->compose_msi_msg(pdev, irq, dest, msg, hpet_id);
 }
 
 static int msi_alloc_remapped_irq(struct pci_dev *pdev, int irq, int nvec)
 {
-	if (!remap_ops || !remap_ops->msi_alloc_irq)
+	if (!remap_ops->msi_alloc_irq)
 		return -ENODEV;
 
 	return remap_ops->msi_alloc_irq(pdev, irq, nvec);
@@ -316,7 +306,7 @@ static int msi_alloc_remapped_irq(struct pci_dev *pdev, int irq, int nvec)
 static int msi_setup_remapped_irq(struct pci_dev *pdev, unsigned int irq,
 				  int index, int sub_handle)
 {
-	if (!remap_ops || !remap_ops->msi_setup_irq)
+	if (!remap_ops->msi_setup_irq)
 		return -ENODEV;
 
 	return remap_ops->msi_setup_irq(pdev, irq, index, sub_handle);
@@ -326,7 +316,7 @@ int setup_hpet_msi_remapped(unsigned int irq, unsigned int id)
 {
 	int ret;
 
-	if (!remap_ops || !remap_ops->alloc_hpet_msi)
+	if (!remap_ops->alloc_hpet_msi)
 		return -ENODEV;
 
 	ret = remap_ops->alloc_hpet_msi(irq, id);
-- 
1.7.10.4
