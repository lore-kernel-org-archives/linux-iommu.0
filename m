From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part1 v8 17/37] irq_remapping: Clean up unused MSI related code
Date: Mon, 13 Apr 2015 14:11:39 +0800
Message-ID: <1428905519-23704-18-git-send-email-jiang.liu@linux.intel.com>
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
To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Dimitri Sivanich <sivanich-sJ/iWh9BUns@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Cohen <david.a.cohen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Sander Eikelenboom <linux-6SM94LqRVpn6gRhOQ7JHfg@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, David Vrabel <david.vrabel-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Now MSI interrupt has been converted to new hierarchy irqdomain
interfaces, so kill legacy MSI related code and interfaces.

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
Cc: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Link: http://lkml.kernel.org/r/1416894816-23245-18-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Signed-off-by: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 arch/x86/include/asm/irq_remapping.h |   13 ---
 arch/x86/include/asm/pci.h           |    5 --
 arch/x86/kernel/x86_init.c           |    2 -
 drivers/iommu/irq_remapping.c        |  151 ----------------------------------
 drivers/iommu/irq_remapping.h        |   14 ----
 5 files changed, 185 deletions(-)

diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
index 0d3bbd0e2c42..b978c68f5d29 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -48,10 +48,6 @@ extern int setup_ioapic_remapped_entry(int irq,
 				       int vector,
 				       struct io_apic_irq_attr *attr);
 extern void free_remapped_irq(int irq);
-extern void compose_remapped_msi_msg(struct pci_dev *pdev,
-				     unsigned int irq, unsigned int dest,
-				     struct msi_msg *msg, u8 hpet_id);
-extern int setup_hpet_msi_remapped(unsigned int irq, unsigned int id);
 extern void panic_if_irq_remap(const char *msg);
 extern bool setup_remapped_irq(int irq,
 			       struct irq_cfg *cfg,
@@ -91,15 +87,6 @@ static inline int setup_ioapic_remapped_entry(int irq,
 	return -ENODEV;
 }
 static inline void free_remapped_irq(int irq) { }
-static inline void compose_remapped_msi_msg(struct pci_dev *pdev,
-					    unsigned int irq, unsigned int dest,
-					    struct msi_msg *msg, u8 hpet_id)
-{
-}
-static inline int setup_hpet_msi_remapped(unsigned int irq, unsigned int id)
-{
-	return -ENODEV;
-}
 
 static inline void panic_if_irq_remap(const char *msg)
 {
diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index 4e370a5d8117..d8c80ff32e8c 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -96,15 +96,10 @@ extern void pci_iommu_alloc(void);
 #ifdef CONFIG_PCI_MSI
 /* implemented in arch/x86/kernel/apic/io_apic. */
 struct msi_desc;
-void native_compose_msi_msg(struct pci_dev *pdev, unsigned int irq,
-			    unsigned int dest, struct msi_msg *msg, u8 hpet_id);
 int native_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
 void native_teardown_msi_irq(unsigned int irq);
 void native_restore_msi_irqs(struct pci_dev *dev);
-int setup_msi_irq(struct pci_dev *dev, struct msi_desc *msidesc,
-		  unsigned int irq_base, unsigned int irq_offset);
 #else
-#define native_compose_msi_msg		NULL
 #define native_setup_msi_irqs		NULL
 #define native_teardown_msi_irq		NULL
 #endif
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 234b0722de53..b094d691f2fe 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -111,11 +111,9 @@ EXPORT_SYMBOL_GPL(x86_platform);
 #if defined(CONFIG_PCI_MSI)
 struct x86_msi_ops x86_msi = {
 	.setup_msi_irqs		= native_setup_msi_irqs,
-	.compose_msi_msg	= native_compose_msi_msg,
 	.teardown_msi_irq	= native_teardown_msi_irq,
 	.teardown_msi_irqs	= default_teardown_msi_irqs,
 	.restore_msi_irqs	= default_restore_msi_irqs,
-	.setup_hpet_msi		= default_setup_hpet_msi,
 };
 
 /* MSI arch specific hooks */
diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index d77e3711c2aa..3eaa822c30a9 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -25,9 +25,6 @@ int no_x2apic_optout;
 static int disable_irq_remap;
 static struct irq_remap_ops *remap_ops;
 
-static int msi_alloc_remapped_irq(struct pci_dev *pdev, int irq, int nvec);
-static int msi_setup_remapped_irq(struct pci_dev *pdev, unsigned int irq,
-				  int index, int sub_handle);
 static int set_remapped_irq_affinity(struct irq_data *data,
 				     const struct cpumask *mask,
 				     bool force);
@@ -50,109 +47,6 @@ static void irq_remapping_disable_io_apic(void)
 		disconnect_bsp_APIC(0);
 }
 
-#ifndef CONFIG_GENERIC_IRQ_LEGACY_ALLOC_HWIRQ
-static unsigned int irq_alloc_hwirqs(int cnt, int node)
-{
-	return irq_domain_alloc_irqs(NULL, -1, cnt, node, NULL);
-}
-
-static void irq_free_hwirqs(unsigned int from, int cnt)
-{
-	irq_domain_free_irqs(from, cnt);
-}
-#endif
-
-static int do_setup_msi_irqs(struct pci_dev *dev, int nvec)
-{
-	int ret, sub_handle, nvec_pow2, index = 0;
-	unsigned int irq;
-	struct msi_desc *msidesc;
-
-	msidesc = list_entry(dev->msi_list.next, struct msi_desc, list);
-
-	irq = irq_alloc_hwirqs(nvec, dev_to_node(&dev->dev));
-	if (irq == 0)
-		return -ENOSPC;
-
-	nvec_pow2 = __roundup_pow_of_two(nvec);
-	for (sub_handle = 0; sub_handle < nvec; sub_handle++) {
-		if (!sub_handle) {
-			index = msi_alloc_remapped_irq(dev, irq, nvec_pow2);
-			if (index < 0) {
-				ret = index;
-				goto error;
-			}
-		} else {
-			ret = msi_setup_remapped_irq(dev, irq + sub_handle,
-						     index, sub_handle);
-			if (ret < 0)
-				goto error;
-		}
-		ret = setup_msi_irq(dev, msidesc, irq, sub_handle);
-		if (ret < 0)
-			goto error;
-	}
-	return 0;
-
-error:
-	irq_free_hwirqs(irq, nvec);
-
-	/*
-	 * Restore altered MSI descriptor fields and prevent just destroyed
-	 * IRQs from tearing down again in default_teardown_msi_irqs()
-	 */
-	msidesc->irq = 0;
-
-	return ret;
-}
-
-static int do_setup_msix_irqs(struct pci_dev *dev, int nvec)
-{
-	int node, ret, sub_handle, index = 0;
-	struct msi_desc *msidesc;
-	unsigned int irq;
-
-	node		= dev_to_node(&dev->dev);
-	sub_handle	= 0;
-
-	list_for_each_entry(msidesc, &dev->msi_list, list) {
-
-		irq = irq_alloc_hwirqs(1, node);
-		if (irq == 0)
-			return -1;
-
-		if (sub_handle == 0)
-			ret = index = msi_alloc_remapped_irq(dev, irq, nvec);
-		else
-			ret = msi_setup_remapped_irq(dev, irq, index, sub_handle);
-
-		if (ret < 0)
-			goto error;
-
-		ret = setup_msi_irq(dev, msidesc, irq, 0);
-		if (ret < 0)
-			goto error;
-
-		sub_handle += 1;
-		irq        += 1;
-	}
-
-	return 0;
-
-error:
-	irq_free_hwirqs(irq, 1);
-	return ret;
-}
-
-static int irq_remapping_setup_msi_irqs(struct pci_dev *dev,
-					int nvec, int type)
-{
-	if (type == PCI_CAP_ID_MSI)
-		return do_setup_msi_irqs(dev, nvec);
-	else
-		return do_setup_msix_irqs(dev, nvec);
-}
-
 static void eoi_ioapic_pin_remapped(int apic, int pin, int vector)
 {
 	/*
@@ -170,8 +64,6 @@ static void __init irq_remapping_modify_x86_ops(void)
 	x86_io_apic_ops.set_affinity	= set_remapped_irq_affinity;
 	x86_io_apic_ops.setup_entry	= setup_ioapic_remapped_entry;
 	x86_io_apic_ops.eoi_ioapic_pin	= eoi_ioapic_pin_remapped;
-	x86_msi.setup_hpet_msi		= setup_hpet_msi_remapped;
-	x86_msi.compose_msi_msg		= compose_remapped_msi_msg;
 }
 
 static __init int setup_nointremap(char *str)
@@ -295,49 +187,6 @@ void free_remapped_irq(int irq)
 		remap_ops->free_irq(irq);
 }
 
-void compose_remapped_msi_msg(struct pci_dev *pdev,
-			      unsigned int irq, unsigned int dest,
-			      struct msi_msg *msg, u8 hpet_id)
-{
-	struct irq_cfg *cfg = irq_cfg(irq);
-
-	if (!irq_remapped(cfg))
-		native_compose_msi_msg(pdev, irq, dest, msg, hpet_id);
-	else if (remap_ops->compose_msi_msg)
-		remap_ops->compose_msi_msg(pdev, irq, dest, msg, hpet_id);
-}
-
-static int msi_alloc_remapped_irq(struct pci_dev *pdev, int irq, int nvec)
-{
-	if (!remap_ops->msi_alloc_irq)
-		return -ENODEV;
-
-	return remap_ops->msi_alloc_irq(pdev, irq, nvec);
-}
-
-static int msi_setup_remapped_irq(struct pci_dev *pdev, unsigned int irq,
-				  int index, int sub_handle)
-{
-	if (!remap_ops->msi_setup_irq)
-		return -ENODEV;
-
-	return remap_ops->msi_setup_irq(pdev, irq, index, sub_handle);
-}
-
-int setup_hpet_msi_remapped(unsigned int irq, unsigned int id)
-{
-	int ret;
-
-	if (!remap_ops->alloc_hpet_msi)
-		return -ENODEV;
-
-	ret = remap_ops->alloc_hpet_msi(irq, id);
-	if (ret)
-		return -EINVAL;
-
-	return default_setup_hpet_msi(irq, id);
-}
-
 void panic_if_irq_remap(const char *msg)
 {
 	if (irq_remapping_enabled)
diff --git a/drivers/iommu/irq_remapping.h b/drivers/iommu/irq_remapping.h
index 3e109b1ea688..16b7d814e6fe 100644
--- a/drivers/iommu/irq_remapping.h
+++ b/drivers/iommu/irq_remapping.h
@@ -66,20 +66,6 @@ struct irq_remap_ops {
 	/* Free an IRQ */
 	int (*free_irq)(int);
 
-	/* Create MSI msg to use for interrupt remapping */
-	void (*compose_msi_msg)(struct pci_dev *,
-				unsigned int, unsigned int,
-				struct msi_msg *, u8);
-
-	/* Allocate remapping resources for MSI */
-	int (*msi_alloc_irq)(struct pci_dev *, int, int);
-
-	/* Setup the remapped MSI irq */
-	int (*msi_setup_irq)(struct pci_dev *, unsigned int, int, int);
-
-	/* Setup interrupt remapping for an HPET MSI */
-	int (*alloc_hpet_msi)(unsigned int, unsigned int);
-
 	/* Get the irqdomain associated the IOMMU device */
 	struct irq_domain *(*get_ir_irq_domain)(struct irq_alloc_info *);
 
-- 
1.7.10.4
