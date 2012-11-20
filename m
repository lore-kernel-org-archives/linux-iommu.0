From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 08/19] x86,
	io_apic: Convert setup_ioapic_entry to function pointer
Date: Tue, 20 Nov 2012 14:12:45 +0100
Message-ID: <1353417176-18945-9-git-send-email-joro@8bytes.org>
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

This pointer is changed to a different function when IRQ
remapping is enabled.

Signed-off-by: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Acked-by: Sebastian Andrzej Siewior <sebastian-E0PNVn5OA6ohrxcnuTQ+TQ@public.gmane.org>
---
 arch/x86/include/asm/io_apic.h  |    5 +++++
 arch/x86/include/asm/x86_init.h |    5 +++++
 arch/x86/kernel/apic/io_apic.c  |   14 +++++---------
 arch/x86/kernel/x86_init.c      |    1 +
 drivers/iommu/irq_remapping.c   |    1 +
 5 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/io_apic.h b/arch/x86/include/asm/io_apic.h
index a744cbb..71f5f08 100644
--- a/arch/x86/include/asm/io_apic.h
+++ b/arch/x86/include/asm/io_apic.h
@@ -149,6 +149,10 @@ extern int io_apic_set_pci_routing(struct device *dev, int irq,
 void setup_IO_APIC_irq_extra(u32 gsi);
 extern void ioapic_insert_resources(void);
 
+extern int native_setup_ioapic_entry(int, struct IO_APIC_route_entry *,
+				     unsigned int, int,
+				     struct io_apic_irq_attr *);
+
 int io_apic_setup_irq_pin_once(unsigned int irq, int node, struct io_apic_irq_attr *attr);
 
 extern int save_ioapic_entries(void);
@@ -232,6 +236,7 @@ static inline void disable_ioapic_support(void) { }
 #define native_disable_io_apic		NULL
 #define native_io_apic_print_entries	NULL
 #define native_ioapic_set_affinity	NULL
+#define native_setup_ioapic_entry	NULL
 #endif
 
 #endif /* _ASM_X86_IO_APIC_H */
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 20d9f97..17da29c 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -190,6 +190,8 @@ struct x86_msi_ops {
 	int  (*setup_hpet_msi)(unsigned int irq, unsigned int id);
 };
 
+struct IO_APIC_route_entry;
+struct io_apic_irq_attr;
 struct irq_data;
 struct cpumask;
 
@@ -203,6 +205,9 @@ struct x86_io_apic_ops {
 	int		(*set_affinity)(struct irq_data *data,
 					const struct cpumask *mask,
 					bool force);
+	int		(*setup_entry)(int irq, struct IO_APIC_route_entry *entry,
+				       unsigned int destination, int vector,
+				       struct io_apic_irq_attr *attr);
 };
 
 extern struct x86_init_ops x86_init;
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 1d6e45c..ed43e90 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1319,14 +1319,10 @@ static void ioapic_register_intr(unsigned int irq, struct irq_cfg *cfg,
 				      fasteoi ? "fasteoi" : "edge");
 }
 
-static int setup_ioapic_entry(int irq, struct IO_APIC_route_entry *entry,
-			       unsigned int destination, int vector,
-			       struct io_apic_irq_attr *attr)
+int native_setup_ioapic_entry(int irq, struct IO_APIC_route_entry *entry,
+			      unsigned int destination, int vector,
+			      struct io_apic_irq_attr *attr)
 {
-	if (irq_remapping_enabled)
-		return setup_ioapic_remapped_entry(irq, entry, destination,
-						   vector, attr);
-
 	memset(entry, 0, sizeof(*entry));
 
 	entry->delivery_mode = apic->irq_delivery_mode;
@@ -1384,8 +1380,8 @@ static void setup_ioapic_irq(unsigned int irq, struct irq_cfg *cfg,
 		    attr->ioapic, mpc_ioapic_id(attr->ioapic), attr->ioapic_pin,
 		    cfg->vector, irq, attr->trigger, attr->polarity, dest);
 
-	if (setup_ioapic_entry(irq, &entry, dest, cfg->vector, attr)) {
-		pr_warn("Failed to setup ioapic entry for ioapic %d, pin %d\n",
+	if (x86_io_apic_ops.setup_entry(irq, &entry, dest, cfg->vector, attr)) {
+		pr_warn("Failed to setup ioapic entry for ioapic  %d, pin %d\n",
 			mpc_ioapic_id(attr->ioapic), attr->ioapic_pin);
 		__clear_irq_vector(irq, cfg);
 
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 2ca3475..06db44f 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -127,4 +127,5 @@ struct x86_io_apic_ops x86_io_apic_ops = {
 	.disable		= native_disable_io_apic,
 	.print_entries		= native_io_apic_print_entries,
 	.set_affinity		= native_ioapic_set_affinity,
+	.setup_entry		= native_setup_ioapic_entry,
 };
diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index f2bf8ed..6662ae9 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -91,6 +91,7 @@ static void __init irq_remapping_modify_x86_ops(void)
 {
 	x86_io_apic_ops.disable		= irq_remapping_disable_io_apic;
 	x86_io_apic_ops.set_affinity	= set_remapped_irq_affinity;
+	x86_io_apic_ops.setup_entry	= setup_ioapic_remapped_entry;
 	x86_msi.setup_msi_irqs		= irq_remapping_setup_msi_irqs;
 	x86_msi.setup_hpet_msi		= setup_hpet_msi_remapped;
 }
-- 
1.7.9.5
