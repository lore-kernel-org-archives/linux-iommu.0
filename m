From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part2 v5 19/31] PCI/MSI: Simplify PCI MSI code by initializing
	msi_desc.nvec_used earlier
Date: Thu,  6 Nov 2014 22:20:32 +0800
Message-ID: <1415283644-2559-20-git-send-email-jiang.liu@linux.intel.com>
References: <1415283644-2559-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1415283644-2559-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Simplify PCI MSI code by initializing msi_desc.nvec_used and
msi_desc.msi_attrib.multiple when creating MSI descriptors.

Also remove redundant checks in IRQ remapping drivers, PCI MSI core
already guarantees these.

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Acked-by: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/irq_remapping.c |    8 --------
 drivers/pci/msi.c             |   40 +++++++++++++++-------------------------
 2 files changed, 15 insertions(+), 33 deletions(-)

diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index 176ff4372b7d..32fe5b1322d0 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -69,19 +69,13 @@ static int do_setup_msi_irqs(struct pci_dev *dev, int nvec)
 	unsigned int irq;
 	struct msi_desc *msidesc;
 
-	WARN_ON(!list_is_singular(&dev->msi_list));
 	msidesc = list_entry(dev->msi_list.next, struct msi_desc, list);
-	WARN_ON(msidesc->irq);
-	WARN_ON(msidesc->msi_attrib.multiple);
-	WARN_ON(msidesc->nvec_used);
 
 	irq = irq_alloc_hwirqs(nvec, dev_to_node(&dev->dev));
 	if (irq == 0)
 		return -ENOSPC;
 
 	nvec_pow2 = __roundup_pow_of_two(nvec);
-	msidesc->nvec_used = nvec;
-	msidesc->msi_attrib.multiple = ilog2(nvec_pow2);
 	for (sub_handle = 0; sub_handle < nvec; sub_handle++) {
 		if (!sub_handle) {
 			index = msi_alloc_remapped_irq(dev, irq, nvec_pow2);
@@ -109,8 +103,6 @@ error:
 	 * IRQs from tearing down again in default_teardown_msi_irqs()
 	 */
 	msidesc->irq = 0;
-	msidesc->nvec_used = 0;
-	msidesc->msi_attrib.multiple = 0;
 
 	return ret;
 }
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index fb2ccb536324..afe974600c7d 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -85,19 +85,13 @@ int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
  */
 void default_teardown_msi_irqs(struct pci_dev *dev)
 {
+	int i;
 	struct msi_desc *entry;
 
-	list_for_each_entry(entry, &dev->msi_list, list) {
-		int i, nvec;
-		if (entry->irq == 0)
-			continue;
-		if (entry->nvec_used)
-			nvec = entry->nvec_used;
-		else
-			nvec = 1 << entry->msi_attrib.multiple;
-		for (i = 0; i < nvec; i++)
-			arch_teardown_msi_irq(entry->irq + i);
-	}
+	list_for_each_entry(entry, &dev->msi_list, list)
+		if (entry->irq)
+			for (i = 0; i < entry->nvec_used; i++)
+				arch_teardown_msi_irq(entry->irq + i);
 }
 
 void __weak arch_teardown_msi_irqs(struct pci_dev *dev)
@@ -353,19 +347,12 @@ static void free_msi_irqs(struct pci_dev *dev)
 	struct msi_desc *entry, *tmp;
 	struct attribute **msi_attrs;
 	struct device_attribute *dev_attr;
-	int count = 0;
+	int i, count = 0;
 
-	list_for_each_entry(entry, &dev->msi_list, list) {
-		int i, nvec;
-		if (!entry->irq)
-			continue;
-		if (entry->nvec_used)
-			nvec = entry->nvec_used;
-		else
-			nvec = 1 << entry->msi_attrib.multiple;
-		for (i = 0; i < nvec; i++)
-			BUG_ON(irq_has_action(entry->irq + i));
-	}
+	list_for_each_entry(entry, &dev->msi_list, list)
+		if (entry->irq)
+			for (i = 0; i < entry->nvec_used; i++)
+				BUG_ON(irq_has_action(entry->irq + i));
 
 	arch_teardown_msi_irqs(dev);
 
@@ -556,7 +543,7 @@ error_attrs:
 	return ret;
 }
 
-static struct msi_desc *msi_setup_entry(struct pci_dev *dev)
+static struct msi_desc *msi_setup_entry(struct pci_dev *dev, int nvec)
 {
 	u16 control;
 	struct msi_desc *entry;
@@ -574,6 +561,8 @@ static struct msi_desc *msi_setup_entry(struct pci_dev *dev)
 	entry->msi_attrib.maskbit	= !!(control & PCI_MSI_FLAGS_MASKBIT);
 	entry->msi_attrib.default_irq	= dev->irq;	/* Save IOAPIC IRQ */
 	entry->msi_attrib.multi_cap	= (control & PCI_MSI_FLAGS_QMASK) >> 1;
+	entry->msi_attrib.multiple	= ilog2(__roundup_pow_of_two(nvec));
+	entry->nvec_used		= nvec;
 
 	if (control & PCI_MSI_FLAGS_64BIT)
 		entry->mask_pos = dev->msi_cap + PCI_MSI_MASK_64;
@@ -606,7 +595,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
 
 	msi_set_enable(dev, 0);	/* Disable MSI during set up */
 
-	entry = msi_setup_entry(dev);
+	entry = msi_setup_entry(dev, nvec);
 	if (!entry)
 		return -ENOMEM;
 
@@ -677,6 +666,7 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
 		entry->msi_attrib.entry_nr	= entries[i].entry;
 		entry->msi_attrib.default_irq	= dev->irq;
 		entry->mask_base		= base;
+		entry->nvec_used		= 1;
 
 		list_add_tail(&entry->list, &dev->msi_list);
 	}
-- 
1.7.10.4
