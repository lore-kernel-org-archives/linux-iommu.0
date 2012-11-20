From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 17/19] x86, msi: Introduce x86_msi.compose_msi_msg call-back
Date: Tue, 20 Nov 2012 14:12:54 +0100
Message-ID: <1353417176-18945-18-git-send-email-joro@8bytes.org>
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

This call-back points to the right function for initializing
the msi_msg structure. The old code for msi_msg generation
was split up into the irq-remapped and the default case.

The irq-remapped case just calls into the specific Intel or
AMD implementation when the device is behind an IOMMU.
Otherwise the default function is called.

Signed-off-by: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Acked-by: Sebastian Andrzej Siewior <sebastian-E0PNVn5OA6ohrxcnuTQ+TQ@public.gmane.org>
---
 arch/x86/include/asm/io_apic.h  |    4 +++
 arch/x86/include/asm/x86_init.h |    4 +++
 arch/x86/kernel/apic/io_apic.c  |   59 ++++++++++++++++++++-------------------
 arch/x86/kernel/x86_init.c      |    1 +
 drivers/iommu/irq_remapping.c   |    9 ++++--
 5 files changed, 46 insertions(+), 31 deletions(-)

diff --git a/arch/x86/include/asm/io_apic.h b/arch/x86/include/asm/io_apic.h
index 36fb5ab..1838e88 100644
--- a/arch/x86/include/asm/io_apic.h
+++ b/arch/x86/include/asm/io_apic.h
@@ -158,6 +158,9 @@ extern int native_setup_ioapic_entry(int, struct IO_APIC_route_entry *,
 				     struct io_apic_irq_attr *);
 extern void eoi_ioapic_irq(unsigned int irq, struct irq_cfg *cfg);
 
+extern void native_compose_msi_msg(struct pci_dev *pdev,
+				   unsigned int irq, unsigned int dest,
+				   struct msi_msg *msg, u8 hpet_id);
 int io_apic_setup_irq_pin_once(unsigned int irq, int node, struct io_apic_irq_attr *attr);
 
 extern int save_ioapic_entries(void);
@@ -242,6 +245,7 @@ static inline void disable_ioapic_support(void) { }
 #define native_io_apic_print_entries	NULL
 #define native_ioapic_set_affinity	NULL
 #define native_setup_ioapic_entry	NULL
+#define native_compose_msi_msg		NULL
 #endif
 
 #endif /* _ASM_X86_IO_APIC_H */
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 17da29c..c9f87be 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -181,9 +181,13 @@ struct x86_platform_ops {
 };
 
 struct pci_dev;
+struct msi_msg;
 
 struct x86_msi_ops {
 	int (*setup_msi_irqs)(struct pci_dev *dev, int nvec, int type);
+	void (*compose_msi_msg)(struct pci_dev *dev, unsigned int irq,
+				unsigned int dest, struct msi_msg *msg,
+			       u8 hpet_id);
 	void (*teardown_msi_irq)(unsigned int irq);
 	void (*teardown_msi_irqs)(struct pci_dev *dev);
 	void (*restore_msi_irqs)(struct pci_dev *dev, int irq);
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 391c0b9..d146a04 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -3002,37 +3002,16 @@ void destroy_irq(unsigned int irq)
 /*
  * MSI message composition
  */
-#ifdef CONFIG_PCI_MSI
-static int msi_compose_msg(struct pci_dev *pdev, unsigned int irq,
-			   struct msi_msg *msg, u8 hpet_id)
+void native_compose_msi_msg(struct pci_dev *pdev,
+			    unsigned int irq, unsigned int dest,
+			    struct msi_msg *msg, u8 hpet_id)
 {
-	struct irq_cfg *cfg;
-	int err;
-	unsigned dest;
-
-	if (disable_apic)
-		return -ENXIO;
-
-	cfg = irq_cfg(irq);
-	err = assign_irq_vector(irq, cfg, apic->target_cpus());
-	if (err)
-		return err;
-
-	err = apic->cpu_mask_to_apicid_and(cfg->domain,
-					   apic->target_cpus(), &dest);
-	if (err)
-		return err;
+	struct irq_cfg *cfg = irq_cfg(irq);
 
-	if (irq_remapped(cfg)) {
-		compose_remapped_msi_msg(pdev, irq, dest, msg, hpet_id);
-		return err;
-	}
+	msg->address_hi = MSI_ADDR_BASE_HI;
 
 	if (x2apic_enabled())
-		msg->address_hi = MSI_ADDR_BASE_HI |
-				  MSI_ADDR_EXT_DEST_ID(dest);
-	else
-		msg->address_hi = MSI_ADDR_BASE_HI;
+		msg->address_hi |= MSI_ADDR_EXT_DEST_ID(dest);
 
 	msg->address_lo =
 		MSI_ADDR_BASE_LO |
@@ -3051,8 +3030,32 @@ static int msi_compose_msg(struct pci_dev *pdev, unsigned int irq,
 			MSI_DATA_DELIVERY_FIXED:
 			MSI_DATA_DELIVERY_LOWPRI) |
 		MSI_DATA_VECTOR(cfg->vector);
+}
 
-	return err;
+#ifdef CONFIG_PCI_MSI
+static int msi_compose_msg(struct pci_dev *pdev, unsigned int irq,
+			   struct msi_msg *msg, u8 hpet_id)
+{
+	struct irq_cfg *cfg;
+	int err;
+	unsigned dest;
+
+	if (disable_apic)
+		return -ENXIO;
+
+	cfg = irq_cfg(irq);
+	err = assign_irq_vector(irq, cfg, apic->target_cpus());
+	if (err)
+		return err;
+
+	err = apic->cpu_mask_to_apicid_and(cfg->domain,
+					   apic->target_cpus(), &dest);
+	if (err)
+		return err;
+
+	x86_msi.compose_msi_msg(pdev, irq, dest, msg, hpet_id);
+
+	return 0;
 }
 
 static int
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 06db44f..ee4a17c 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -113,6 +113,7 @@ struct x86_platform_ops x86_platform = {
 EXPORT_SYMBOL_GPL(x86_platform);
 struct x86_msi_ops x86_msi = {
 	.setup_msi_irqs		= native_setup_msi_irqs,
+	.compose_msi_msg	= native_compose_msi_msg,
 	.teardown_msi_irq	= native_teardown_msi_irq,
 	.teardown_msi_irqs	= default_teardown_msi_irqs,
 	.restore_msi_irqs	= default_restore_msi_irqs,
diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index 30884ee..7055847 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -95,6 +95,7 @@ static void __init irq_remapping_modify_x86_ops(void)
 	x86_io_apic_ops.setup_entry	= setup_ioapic_remapped_entry;
 	x86_msi.setup_msi_irqs		= irq_remapping_setup_msi_irqs;
 	x86_msi.setup_hpet_msi		= setup_hpet_msi_remapped;
+	x86_msi.compose_msi_msg		= compose_remapped_msi_msg;
 }
 
 static __init int setup_nointremap(char *str)
@@ -240,10 +241,12 @@ void compose_remapped_msi_msg(struct pci_dev *pdev,
 			      unsigned int irq, unsigned int dest,
 			      struct msi_msg *msg, u8 hpet_id)
 {
-	if (!remap_ops || !remap_ops->compose_msi_msg)
-		return;
+	struct irq_cfg *cfg = irq_get_chip_data(irq);
 
-	remap_ops->compose_msi_msg(pdev, irq, dest, msg, hpet_id);
+	if (!irq_remapped(cfg))
+		native_compose_msi_msg(pdev, irq, dest, msg, hpet_id);
+	else if (remap_ops && remap_ops->compose_msi_msg)
+		remap_ops->compose_msi_msg(pdev, irq, dest, msg, hpet_id);
 }
 
 static int msi_alloc_remapped_irq(struct pci_dev *pdev, int irq, int nvec)
-- 
1.7.9.5
