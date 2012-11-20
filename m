From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 06/19] x86,
	msi: Use IRQ remapping specific setup_msi_irqs routine
Date: Tue, 20 Nov 2012 14:12:43 +0100
Message-ID: <1353417176-18945-7-git-send-email-joro@8bytes.org>
References: <1353417176-18945-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1353417176-18945-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Cc: Suresh Siddha <suresh.b.siddha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sebastian Andrzej Siewior <sebastian-E0PNVn5OA6ohrxcnuTQ+TQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Use seperate routines to setup MSI IRQs for both
irq_remapping_enabled cases.

Signed-off-by: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Acked-by: Sebastian Andrzej Siewior <sebastian-E0PNVn5OA6ohrxcnuTQ+TQ@public.gmane.org>
---
 arch/x86/include/asm/irq_remapping.h |   12 -------
 arch/x86/include/asm/pci.h           |    2 ++
 arch/x86/kernel/apic/io_apic.c       |   26 ++--------------
 drivers/iommu/irq_remapping.c        |   57 ++++++++++++++++++++++++++++++++--
 4 files changed, 59 insertions(+), 38 deletions(-)

diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
index 5fb9bbb..0ee1e88 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -47,9 +47,6 @@ extern void free_remapped_irq(int irq);
 extern void compose_remapped_msi_msg(struct pci_dev *pdev,
 				     unsigned int irq, unsigned int dest,
 				     struct msi_msg *msg, u8 hpet_id);
-extern int msi_alloc_remapped_irq(struct pci_dev *pdev, int irq, int nvec);
-extern int msi_setup_remapped_irq(struct pci_dev *pdev, unsigned int irq,
-				  int index, int sub_handle);
 extern int setup_hpet_msi_remapped(unsigned int irq, unsigned int id);
 
 #else  /* CONFIG_IRQ_REMAP */
@@ -83,15 +80,6 @@ static inline void compose_remapped_msi_msg(struct pci_dev *pdev,
 					    struct msi_msg *msg, u8 hpet_id)
 {
 }
-static inline int msi_alloc_remapped_irq(struct pci_dev *pdev, int irq, int nvec)
-{
-	return -ENODEV;
-}
-static inline int msi_setup_remapped_irq(struct pci_dev *pdev, unsigned int irq,
-					 int index, int sub_handle)
-{
-	return -ENODEV;
-}
 static inline int setup_hpet_msi_remapped(unsigned int irq, unsigned int id)
 {
 	return -ENODEV;
diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index 6e41b93..11540a8 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -121,9 +121,11 @@ static inline void x86_restore_msi_irqs(struct pci_dev *dev, int irq)
 #define arch_teardown_msi_irq x86_teardown_msi_irq
 #define arch_restore_msi_irqs x86_restore_msi_irqs
 /* implemented in arch/x86/kernel/apic/io_apic. */
+struct msi_desc;
 int native_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
 void native_teardown_msi_irq(unsigned int irq);
 void native_restore_msi_irqs(struct pci_dev *dev, int irq);
+int setup_msi_irq(struct pci_dev *dev, struct msi_desc *msidesc, int irq);
 /* default to the implementation in drivers/lib/msi.c */
 #define HAVE_DEFAULT_MSI_TEARDOWN_IRQS
 #define HAVE_DEFAULT_MSI_RESTORE_IRQS
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index ca01f42a..a2cb0e9 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -3148,7 +3148,7 @@ static struct irq_chip msi_chip = {
 	.irq_retrigger		= ioapic_retrigger_irq,
 };
 
-static int setup_msi_irq(struct pci_dev *dev, struct msi_desc *msidesc, int irq)
+int setup_msi_irq(struct pci_dev *dev, struct msi_desc *msidesc, int irq)
 {
 	struct irq_chip *chip = &msi_chip;
 	struct msi_msg msg;
@@ -3175,9 +3175,9 @@ static int setup_msi_irq(struct pci_dev *dev, struct msi_desc *msidesc, int irq)
 
 int native_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 {
-	int node, ret, sub_handle, index = 0;
 	unsigned int irq, irq_want;
 	struct msi_desc *msidesc;
+	int node, ret;
 
 	/* x86 doesn't support multiple MSI yet */
 	if (type == PCI_CAP_ID_MSI && nvec > 1)
@@ -3185,36 +3185,16 @@ int native_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 
 	node = dev_to_node(&dev->dev);
 	irq_want = nr_irqs_gsi;
-	sub_handle = 0;
 	list_for_each_entry(msidesc, &dev->msi_list, list) {
 		irq = create_irq_nr(irq_want, node);
 		if (irq == 0)
 			return -1;
+
 		irq_want = irq + 1;
-		if (!irq_remapping_enabled)
-			goto no_ir;
 
-		if (!sub_handle) {
-			/*
-			 * allocate the consecutive block of IRTE's
-			 * for 'nvec'
-			 */
-			index = msi_alloc_remapped_irq(dev, irq, nvec);
-			if (index < 0) {
-				ret = index;
-				goto error;
-			}
-		} else {
-			ret = msi_setup_remapped_irq(dev, irq, index,
-						     sub_handle);
-			if (ret < 0)
-				goto error;
-		}
-no_ir:
 		ret = setup_msi_irq(dev, msidesc, irq);
 		if (ret < 0)
 			goto error;
-		sub_handle++;
 	}
 	return 0;
 
diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index 0baad3b..bc94fd2 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -4,6 +4,8 @@
 #include <linux/cpumask.h>
 #include <linux/errno.h>
 #include <linux/msi.h>
+#include <linux/irq.h>
+#include <linux/pci.h>
 
 #include <asm/hw_irq.h>
 #include <asm/irq_remapping.h>
@@ -21,6 +23,10 @@ int no_x2apic_optout;
 
 static struct irq_remap_ops *remap_ops;
 
+static int msi_alloc_remapped_irq(struct pci_dev *pdev, int irq, int nvec);
+static int msi_setup_remapped_irq(struct pci_dev *pdev, unsigned int irq,
+				  int index, int sub_handle);
+
 static void irq_remapping_disable_io_apic(void)
 {
 	/*
@@ -34,9 +40,54 @@ static void irq_remapping_disable_io_apic(void)
 		disconnect_bsp_APIC(0);
 }
 
+static int irq_remapping_setup_msi_irqs(struct pci_dev *dev,
+					int nvec, int type)
+{
+	int node, ret, sub_handle, index = 0;
+	struct msi_desc *msidesc;
+	unsigned int irq;
+
+	/* We don't support multiple MSI yet */
+	if (type == PCI_CAP_ID_MSI && nvec > 1)
+		return 1;
+
+	node		= dev_to_node(&dev->dev);
+	irq		= get_nr_irqs_gsi();
+	sub_handle	= 0;
+
+	list_for_each_entry(msidesc, &dev->msi_list, list) {
+
+		irq = create_irq_nr(irq, node);
+		if (irq == 0)
+			return -1;
+
+		if (sub_handle == 0)
+			ret = index = msi_alloc_remapped_irq(dev, irq, nvec);
+		else
+			ret = msi_setup_remapped_irq(dev, irq, index, sub_handle);
+
+		if (ret < 0)
+			goto error;
+
+		ret = setup_msi_irq(dev, msidesc, irq);
+		if (ret < 0)
+			goto error;
+
+		sub_handle += 1;
+		irq        += 1;
+	}
+
+	return 0;
+
+error:
+	destroy_irq(irq);
+	return ret;
+}
+
 static void __init irq_remapping_modify_x86_ops(void)
 {
 	x86_io_apic_ops.disable		= irq_remapping_disable_io_apic;
+	x86_msi.setup_msi_irqs		= irq_remapping_setup_msi_irqs;
 	x86_msi.setup_hpet_msi		= setup_hpet_msi_remapped;
 }
 
@@ -186,7 +237,7 @@ void compose_remapped_msi_msg(struct pci_dev *pdev,
 	remap_ops->compose_msi_msg(pdev, irq, dest, msg, hpet_id);
 }
 
-int msi_alloc_remapped_irq(struct pci_dev *pdev, int irq, int nvec)
+static int msi_alloc_remapped_irq(struct pci_dev *pdev, int irq, int nvec)
 {
 	if (!remap_ops || !remap_ops->msi_alloc_irq)
 		return -ENODEV;
@@ -194,8 +245,8 @@ int msi_alloc_remapped_irq(struct pci_dev *pdev, int irq, int nvec)
 	return remap_ops->msi_alloc_irq(pdev, irq, nvec);
 }
 
-int msi_setup_remapped_irq(struct pci_dev *pdev, unsigned int irq,
-			   int index, int sub_handle)
+static int msi_setup_remapped_irq(struct pci_dev *pdev, unsigned int irq,
+				  int index, int sub_handle)
 {
 	if (!remap_ops || !remap_ops->msi_setup_irq)
 		return -ENODEV;
-- 
1.7.9.5
