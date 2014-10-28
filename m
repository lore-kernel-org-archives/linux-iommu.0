From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part2 v3 10/24] x86: irq_remapping: Introduce new interfaces
	to support hierarchy irqdomain
Date: Tue, 28 Oct 2014 16:26:28 +0800
Message-ID: <1414484803-10311-11-git-send-email-jiang.liu@linux.intel.com>
References: <1414484803-10311-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1414484803-10311-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Introduce new interfaces for interrupt remapping drivers to support
hierarchy irqdomain:
1) irq_remapping_get_ir_irq_domain(): get irqdomain associated with an
   interrupt remapping unit. IOAPIC/HPET drivers use this interface to
   get parent interrupt remapping irqdomain.
2) irq_remapping_get_irq_domain(): get irqdomain for an IRQ allocation.
   This is mainly used to support MSI irqdomain. We must build one MSI
   irqdomain for each interrupt remapping unit. MSI driver calls this
   interface to get MSI irqdomain associated with an IR irqdomain which
   manages the PCI devices.
3) irq_remapping_get_ioapic_entry(): get IOAPIC entry content rewritten
   by the interrupt remapping driver for remapped IOAPIC interrupt.
4) irq_remapping_get_msi_entry(): get MSI/HPET entry content rewritten
   by the interrupt remapping driver for remapped MSI/HPET interrupt.

Architecture specific needs to implement two hooks:
1) arch_get_ir_parent_domain(): get parent irqdomain for IR irqdomain,
   which is x86_vector_domain on x86 platforms.
2) arch_create_msi_irq_domain(): create an MSI irqdomain associated with
   the interrupt remapping unit.

We also add follwing callbacks into struct irq_remap_ops:
	struct irq_domain *(*get_ir_irq_domain)(struct irq_alloc_info *);
	struct irq_domain *(*get_irq_domain)(struct irq_alloc_info *);
	int (*get_ioapic_entry)(struct irq_data *,
				struct IR_IO_APIC_route_entry *);
	int (*get_msi_entry)(struct irq_data *, struct msi_msg *);

Once all clients of IR have been converted to new hierarchy irqdomain
interfaces, we will:
1) Remove set_ioapic_entry, set_affinity, free_irq, compose_msi_msg,
   msi_alloc_irq, msi_setup_irq, setup_hpet_msi from struct remap_osp
2) Kill setup_ioapic_remapped_entry, free_remapped_irq,
   compose_remapped_msi_msg, setup_hpet_msi_remapped, setup_remapped_irq.
3) Simplify x86_io_apic_ops and x86_msi.

We could achieve a much more clear architecture with all these changes
applied.

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 arch/x86/include/asm/hw_irq.h        |   36 +++++++++++++++-
 arch/x86/include/asm/irq_remapping.h |   74 ++++++++++++++++++++++++++++++++
 drivers/iommu/irq_remapping.c        |   78 +++++++++++++++++++++++++++++++++-
 drivers/iommu/irq_remapping.h        |   17 ++++++++
 4 files changed, 203 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index 1300702adb1e..545460d470bd 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -113,9 +113,43 @@ struct irq_2_irte {
 #ifdef	CONFIG_X86_LOCAL_APIC
 struct irq_data;
 struct irq_domain;
+struct pci_dev;
+struct msi_desc;
+
+enum irq_alloc_type {
+	X86_IRQ_ALLOC_TYPE_IOAPIC = 1,
+	X86_IRQ_ALLOC_TYPE_HPET,
+	X86_IRQ_ALLOC_TYPE_MSI,
+	X86_IRQ_ALLOC_TYPE_MSIX,
+};
 
 struct irq_alloc_info {
-	const struct cpumask *mask;	/* CPU mask for vector allocation */
+	const struct cpumask	*mask;	/* CPU mask for vector allocation */
+	enum irq_alloc_type	type;
+	union {
+		int		unused;
+#ifdef	CONFIG_HPET_TIMER
+		struct {
+			int		hpet_id;
+			int		hpet_index;
+			void		*hpet_data;
+		};
+#endif
+#ifdef	CONFIG_PCI_MSI
+		struct {
+			struct pci_dev	*msi_dev;
+			struct msi_desc *msi_desc;
+		};
+#endif
+#ifdef	CONFIG_X86_IO_APIC
+		struct {
+			int		ioapic_id;
+			int		ioapic_pin;
+			u32		ioapic_trigger : 1;
+			u32		ioapic_polarity : 1;
+		};
+#endif
+	};
 };
 
 struct irq_cfg {
diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
index 230dde9b695e..f5f624529386 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -22,6 +22,8 @@
 #ifndef __X86_IRQ_REMAPPING_H
 #define __X86_IRQ_REMAPPING_H
 
+#include <linux/irqdomain.h>
+#include <asm/hw_irq.h>
 #include <asm/io_apic.h>
 
 struct IO_APIC_route_entry;
@@ -30,6 +32,7 @@ struct irq_chip;
 struct msi_msg;
 struct pci_dev;
 struct irq_cfg;
+struct irq_alloc_info;
 
 #ifdef CONFIG_IRQ_REMAP
 
@@ -58,6 +61,42 @@ extern bool setup_remapped_irq(int irq,
 
 void irq_remap_modify_chip_defaults(struct irq_chip *chip);
 
+extern struct irq_domain *irq_remapping_get_ir_irq_domain(
+				struct irq_alloc_info *info);
+extern struct irq_domain *irq_remapping_get_irq_domain(
+				struct irq_alloc_info *info);
+extern int irq_remapping_get_ioapic_entry(struct irq_data *irq_data,
+					  struct IR_IO_APIC_route_entry *entry);
+extern int irq_remapping_get_msi_entry(struct irq_data *irq_data,
+				       struct msi_msg *entry);
+extern void irq_remapping_print_chip(struct irq_data *data, struct seq_file *p);
+
+/*
+ * Create MSI/MSIx irqdomain for interrupt remapping device, use @parent as
+ * parent irqdomain.
+ */
+static inline struct irq_domain *
+arch_create_msi_irq_domain(struct irq_domain *parent)
+{
+	return NULL;
+}
+
+/* Get parent irqdomain for interrupt remapping irqdomain */
+static inline struct irq_domain *arch_get_ir_parent_domain(void)
+{
+	return x86_vector_domain;
+}
+
+static inline void irq_remapping_domain_set_remapped(struct irq_domain *domain)
+{
+	domain->flags |= IRQ_DOMAIN_FLAG_ARCH1;
+}
+
+static inline bool irq_remapping_domain_is_remapped(struct irq_domain *domain)
+{
+	return domain->flags & IRQ_DOMAIN_FLAG_ARCH1;
+}
+
 #else  /* CONFIG_IRQ_REMAP */
 
 static inline void setup_irq_remapping_ops(void) { }
@@ -101,6 +140,41 @@ static inline bool setup_remapped_irq(int irq,
 {
 	return false;
 }
+
+static inline struct irq_domain *
+irq_remapping_get_ir_irq_domain(struct irq_alloc_info *info)
+{
+	return NULL;
+}
+
+static inline struct irq_domain *
+irq_remapping_get_irq_domain(struct irq_alloc_info *info)
+{
+	return NULL;
+}
+
+static inline int irq_remapping_get_ioapic_entry(struct irq_data *irq_data,
+				struct IR_IO_APIC_route_entry *entry)
+{
+	return -ENOSYS;
+}
+
+static inline int irq_remapping_get_msi_entry(struct irq_data *irq_data,
+					      struct msi_msg *entry)
+{
+	return -ENOSYS;
+}
+
+static inline void irq_remapping_domain_set_remapped(struct irq_domain *domain)
+{
+}
+
+static inline bool irq_remapping_domain_is_remapped(struct irq_domain *domain)
+{
+	return false;
+}
+
+#define	irq_remapping_print_chip	NULL
 #endif /* CONFIG_IRQ_REMAP */
 
 extern int dmar_alloc_hwirq(void);
diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index 63886bafed9f..3a7f62c8becb 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -377,7 +377,7 @@ void panic_if_irq_remap(const char *msg)
 		panic(msg);
 }
 
-static void ir_ack_apic_edge(struct irq_data *data)
+void ir_ack_apic_edge(struct irq_data *data)
 {
 	ack_APIC_irq();
 }
@@ -388,6 +388,19 @@ static void ir_ack_apic_level(struct irq_data *data)
 	eoi_ioapic_irq(data->irq, irqd_cfg(data));
 }
 
+void irq_remapping_print_chip(struct irq_data *data, struct seq_file *p)
+{
+	/*
+	 * Assume interrupt is remapped if the parent irqdomain isn't the
+	 * vector domain, which is true for MSI, HPET and IOAPIC on x86
+	 * platforms.
+	 */
+	if (data->domain && data->domain->parent != arch_get_ir_parent_domain())
+		seq_printf(p, " IR-%s", data->chip->name);
+	else
+		seq_printf(p, " %s", data->chip->name);
+}
+
 static void ir_print_prefix(struct irq_data *data, struct seq_file *p)
 {
 	seq_printf(p, " IR-%s", data->chip->name);
@@ -409,3 +422,66 @@ bool setup_remapped_irq(int irq, struct irq_cfg *cfg, struct irq_chip *chip)
 	irq_remap_modify_chip_defaults(chip);
 	return true;
 }
+
+/**
+ * irq_remapping_get_ir_irq_domain - Get the irqdomain associated the IOMMU
+ *				     device serving @info
+ * @info: interrupt allocation information, used to find the IOMMU device
+ *
+ * It's used to get parent irqdomain for HPET and IOAPIC domains.
+ * Returns pointer to IRQ domain, or NULL on failure.
+ */
+struct irq_domain *
+irq_remapping_get_ir_irq_domain(struct irq_alloc_info *info)
+{
+	if (!remap_ops || !remap_ops->get_ir_irq_domain)
+		return NULL;
+
+	return remap_ops->get_ir_irq_domain(info);
+}
+
+/**
+ * irq_remapping_get_irq_domain - Get the irqdomain serving the MSI interrupt
+ * @info: interrupt allocation information, used to find the IOMMU device
+ *
+ * It's used to get irqdomain for MSI/MSIx interrupt allocation.
+ * Returns pointer to IRQ domain, or NULL on failure.
+ */
+struct irq_domain *
+irq_remapping_get_irq_domain(struct irq_alloc_info *info)
+{
+	if (!remap_ops || !remap_ops->get_irq_domain)
+		return NULL;
+
+	return remap_ops->get_irq_domain(info);
+}
+
+/**
+ * irq_remapping_get_ioapic_entry - Get IOAPIC entry content rewritten by
+ *				    interrupt remapping driver
+ * @irq_data: irq_data associated with interrupt remapping irqdomain
+ * @entry: host returned data
+ *
+ * Caller must make sure that the interrupt is remapped.
+ * Return 0 on success, otherwise return error code
+ */
+int irq_remapping_get_ioapic_entry(struct irq_data *irq_data,
+				   struct IR_IO_APIC_route_entry *entry)
+{
+	return remap_ops->get_ioapic_entry(irq_data, entry);
+}
+
+/**
+ * irq_remapping_get_ioapic_entry - Get MSI data rewritten by interrupt
+ *				    remapping driver
+ * @irq_data: irq_data associated with interrupt remapping irqdomain
+ * @entry: host returned data
+ *
+ * Caller must make sure that the interrupt is remapped.
+ * Return 0 on success, otherwise return error code
+ */
+int irq_remapping_get_msi_entry(struct irq_data *irq_data,
+				struct msi_msg *entry)
+{
+	return remap_ops->get_msi_entry(irq_data, entry);
+}
diff --git a/drivers/iommu/irq_remapping.h b/drivers/iommu/irq_remapping.h
index fde250f86e60..fd0270b7a351 100644
--- a/drivers/iommu/irq_remapping.h
+++ b/drivers/iommu/irq_remapping.h
@@ -30,6 +30,8 @@ struct irq_data;
 struct cpumask;
 struct pci_dev;
 struct msi_msg;
+struct irq_domain;
+struct irq_alloc_info;
 
 extern int disable_irq_remap;
 extern int irq_remap_broken;
@@ -81,11 +83,26 @@ struct irq_remap_ops {
 
 	/* Setup interrupt remapping for an HPET MSI */
 	int (*alloc_hpet_msi)(unsigned int, unsigned int);
+
+	/* Get the irqdomain associated the IOMMU device */
+	struct irq_domain *(*get_ir_irq_domain)(struct irq_alloc_info *);
+
+	/* Get the MSI irqdomain associated with the IOMMU device */
+	struct irq_domain *(*get_irq_domain)(struct irq_alloc_info *);
+
+	/* Get IOAPIC entry content rewritten by interrupt remapping driver */
+	int (*get_ioapic_entry)(struct irq_data *,
+				struct IR_IO_APIC_route_entry *);
+
+	/*  Get MSI data rewritten by interrupt remapping driver */
+	int (*get_msi_entry)(struct irq_data *, struct msi_msg *);
 };
 
 extern struct irq_remap_ops intel_irq_remap_ops;
 extern struct irq_remap_ops amd_iommu_irq_ops;
 
+extern void ir_ack_apic_edge(struct irq_data *data);
+
 #else  /* CONFIG_IRQ_REMAP */
 
 #define irq_remapping_enabled 0
-- 
1.7.10.4
