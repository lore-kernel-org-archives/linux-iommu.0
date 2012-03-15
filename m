From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 5/9] iommu/vt-d: Convert IR ioapic-setup to use remap_ops
Date: Thu, 15 Mar 2012 18:39:47 +0100
Message-ID: <1331833191-25779-6-git-send-email-joerg.roedel@amd.com>
References: <1331833191-25779-1-git-send-email-joerg.roedel@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1331833191-25779-1-git-send-email-joerg.roedel-5C7GfCeVMHo@public.gmane.org>
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
Cc: Suresh Siddha <suresh.b.siddha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

The IOAPIC setup routine for interrupt remapping is VT-d
specific. Move it to the irq_remap_ops and add a call helper
function.

Signed-off-by: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
---
 arch/x86/include/asm/intr_remapping.h |   15 +++++-
 arch/x86/kernel/apic/io_apic.c        |   68 +------------------------
 drivers/iommu/intel_intr_remapping.c  |   89 +++++++++++++++++++++++++++++++++
 drivers/iommu/intr_remapping.c        |   12 +++++
 drivers/iommu/intr_remapping.h        |    8 +++
 5 files changed, 125 insertions(+), 67 deletions(-)

diff --git a/arch/x86/include/asm/intr_remapping.h b/arch/x86/include/asm/intr_remapping.h
index 55aa892..a22e1f1 100644
--- a/arch/x86/include/asm/intr_remapping.h
+++ b/arch/x86/include/asm/intr_remapping.h
@@ -24,6 +24,9 @@
 
 #ifdef CONFIG_IRQ_REMAP
 
+struct IO_APIC_route_entry;
+struct io_apic_irq_attr;
+
 extern int intr_remapping_enabled;
 
 extern void setup_intr_remapping(void);
@@ -33,6 +36,10 @@ extern int intr_hardware_enable(void);
 extern void intr_hardware_disable(void);
 extern int intr_hardware_reenable(int);
 extern int intr_enable_fault_handling(void);
+extern int intr_setup_ioapic_entry(int irq,
+				   struct IO_APIC_route_entry *entry,
+				   unsigned int destination, int vector,
+				   struct io_apic_irq_attr *attr);
 
 #else  /* CONFIG_IRQ_REMAP */
 
@@ -45,7 +52,13 @@ static inline int intr_hardware_enable(void) { return -ENODEV; }
 static inline void intr_hardware_disable(void) { }
 static inline int intr_hardware_reenable(int eim) { return -ENODEV; }
 static inline int intr_enable_fault_handling(void) { return -ENODEV; }
-
+static inline int intr_setup_ioapic_entry(int irq,
+					  struct IO_APIC_route_entry *entry,
+					  unsigned int destination, int vector,
+					  struct io_apic_irq_attr *attr)
+{
+	return -ENODEV;
+}
 #endif /* CONFIG_IRQ_REMAP */
 
 #endif /* __X86_INTR_REMAPPING_H */
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 6c00161..4746ba1 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1323,77 +1323,13 @@ static void ioapic_register_intr(unsigned int irq, struct irq_cfg *cfg,
 				      fasteoi ? "fasteoi" : "edge");
 }
 
-
-static int setup_ir_ioapic_entry(int irq,
-			      struct IR_IO_APIC_route_entry *entry,
-			      unsigned int destination, int vector,
-			      struct io_apic_irq_attr *attr)
-{
-	int index;
-	struct irte irte;
-	int ioapic_id = mpc_ioapic_id(attr->ioapic);
-	struct intel_iommu *iommu = map_ioapic_to_ir(ioapic_id);
-
-	if (!iommu) {
-		pr_warn("No mapping iommu for ioapic %d\n", ioapic_id);
-		return -ENODEV;
-	}
-
-	index = alloc_irte(iommu, irq, 1);
-	if (index < 0) {
-		pr_warn("Failed to allocate IRTE for ioapic %d\n", ioapic_id);
-		return -ENOMEM;
-	}
-
-	prepare_irte(&irte, vector, destination);
-
-	/* Set source-id of interrupt request */
-	set_ioapic_sid(&irte, ioapic_id);
-
-	modify_irte(irq, &irte);
-
-	apic_printk(APIC_VERBOSE, KERN_DEBUG "IOAPIC[%d]: "
-		"Set IRTE entry (P:%d FPD:%d Dst_Mode:%d "
-		"Redir_hint:%d Trig_Mode:%d Dlvry_Mode:%X "
-		"Avail:%X Vector:%02X Dest:%08X "
-		"SID:%04X SQ:%X SVT:%X)\n",
-		attr->ioapic, irte.present, irte.fpd, irte.dst_mode,
-		irte.redir_hint, irte.trigger_mode, irte.dlvry_mode,
-		irte.avail, irte.vector, irte.dest_id,
-		irte.sid, irte.sq, irte.svt);
-
-	memset(entry, 0, sizeof(*entry));
-
-	entry->index2	= (index >> 15) & 0x1;
-	entry->zero	= 0;
-	entry->format	= 1;
-	entry->index	= (index & 0x7fff);
-	/*
-	 * IO-APIC RTE will be configured with virtual vector.
-	 * irq handler will do the explicit EOI to the io-apic.
-	 */
-	entry->vector	= attr->ioapic_pin;
-	entry->mask	= 0;			/* enable IRQ */
-	entry->trigger	= attr->trigger;
-	entry->polarity	= attr->polarity;
-
-	/* Mask level triggered irqs.
-	 * Use IRQ_DELAYED_DISABLE for edge triggered irqs.
-	 */
-	if (attr->trigger)
-		entry->mask = 1;
-
-	return 0;
-}
-
 static int setup_ioapic_entry(int irq, struct IO_APIC_route_entry *entry,
 			       unsigned int destination, int vector,
 			       struct io_apic_irq_attr *attr)
 {
 	if (intr_remapping_enabled)
-		return setup_ir_ioapic_entry(irq,
-			 (struct IR_IO_APIC_route_entry *)entry,
-			 destination, vector, attr);
+		return intr_setup_ioapic_entry(irq, entry, destination,
+					       vector, attr);
 
 	memset(entry, 0, sizeof(*entry));
 
diff --git a/drivers/iommu/intel_intr_remapping.c b/drivers/iommu/intel_intr_remapping.c
index 610b75b..f495eba 100644
--- a/drivers/iommu/intel_intr_remapping.c
+++ b/drivers/iommu/intel_intr_remapping.c
@@ -31,6 +31,7 @@ struct hpet_scope {
 };
 
 #define IR_X2APIC_MODE(mode) (mode ? (1 << 11) : 0)
+#define IRTE_DEST(dest) ((x2apic_mode) ? dest : dest << 8)
 
 static struct ioapic_scope ir_ioapic[MAX_IO_APICS];
 static struct hpet_scope ir_hpet[MAX_HPET_TBS];
@@ -814,6 +815,93 @@ error:
 	return -1;
 }
 
+static void prepare_irte(struct irte *irte, int vector,
+			 unsigned int dest)
+{
+	memset(irte, 0, sizeof(*irte));
+
+	irte->present = 1;
+	irte->dst_mode = apic->irq_dest_mode;
+	/*
+	 * Trigger mode in the IRTE will always be edge, and for IO-APIC, the
+	 * actual level or edge trigger will be setup in the IO-APIC
+	 * RTE. This will help simplify level triggered irq migration.
+	 * For more details, see the comments (in io_apic.c) explainig IO-APIC
+	 * irq migration in the presence of interrupt-remapping.
+	*/
+	irte->trigger_mode = 0;
+	irte->dlvry_mode = apic->irq_delivery_mode;
+	irte->vector = vector;
+	irte->dest_id = IRTE_DEST(dest);
+	irte->redir_hint = 1;
+}
+
+static int intel_setup_ioapic_entry(int irq,
+				    struct IO_APIC_route_entry *route_entry,
+				    unsigned int destination, int vector,
+				    struct io_apic_irq_attr *attr)
+{
+	int ioapic_id = mpc_ioapic_id(attr->ioapic);
+	struct intel_iommu *iommu = map_ioapic_to_ir(ioapic_id);
+	struct IR_IO_APIC_route_entry *entry;
+	struct irte irte;
+	int index;
+
+	if (!iommu) {
+		pr_warn("No mapping iommu for ioapic %d\n", ioapic_id);
+		return -ENODEV;
+	}
+
+	entry = (struct IR_IO_APIC_route_entry *)route_entry;
+
+	index = alloc_irte(iommu, irq, 1);
+	if (index < 0) {
+		pr_warn("Failed to allocate IRTE for ioapic %d\n", ioapic_id);
+		return -ENOMEM;
+	}
+
+	prepare_irte(&irte, vector, destination);
+
+	/* Set source-id of interrupt request */
+	set_ioapic_sid(&irte, ioapic_id);
+
+	modify_irte(irq, &irte);
+
+	apic_printk(APIC_VERBOSE, KERN_DEBUG "IOAPIC[%d]: "
+		"Set IRTE entry (P:%d FPD:%d Dst_Mode:%d "
+		"Redir_hint:%d Trig_Mode:%d Dlvry_Mode:%X "
+		"Avail:%X Vector:%02X Dest:%08X "
+		"SID:%04X SQ:%X SVT:%X)\n",
+		attr->ioapic, irte.present, irte.fpd, irte.dst_mode,
+		irte.redir_hint, irte.trigger_mode, irte.dlvry_mode,
+		irte.avail, irte.vector, irte.dest_id,
+		irte.sid, irte.sq, irte.svt);
+
+	memset(entry, 0, sizeof(*entry));
+
+	entry->index2	= (index >> 15) & 0x1;
+	entry->zero	= 0;
+	entry->format	= 1;
+	entry->index	= (index & 0x7fff);
+	/*
+	 * IO-APIC RTE will be configured with virtual vector.
+	 * irq handler will do the explicit EOI to the io-apic.
+	 */
+	entry->vector	= attr->ioapic_pin;
+	entry->mask	= 0;			/* enable IRQ */
+	entry->trigger	= attr->trigger;
+	entry->polarity	= attr->polarity;
+
+	/* Mask level triggered irqs.
+	 * Use IRQ_DELAYED_DISABLE for edge triggered irqs.
+	 */
+	if (attr->trigger)
+		entry->mask = 1;
+
+	return 0;
+}
+
+
 struct irq_remap_ops intel_irq_remap_ops = {
 	.supported		= intel_intr_remapping_supported,
 	.hardware_init		= dmar_table_init,
@@ -821,4 +909,5 @@ struct irq_remap_ops intel_irq_remap_ops = {
 	.hardware_disable	= disable_intr_remapping,
 	.hardware_reenable	= reenable_intr_remapping,
 	.enable_faulting	= enable_drhd_fault_handling,
+	.setup_ioapic_entry	= intel_setup_ioapic_entry,
 };
diff --git a/drivers/iommu/intr_remapping.c b/drivers/iommu/intr_remapping.c
index 9aabed7..739148a 100644
--- a/drivers/iommu/intr_remapping.c
+++ b/drivers/iommu/intr_remapping.c
@@ -98,3 +98,15 @@ int __init intr_enable_fault_handling(void)
 
 	return remap_ops->enable_faulting();
 }
+
+int intr_setup_ioapic_entry(int irq,
+			    struct IO_APIC_route_entry *entry,
+			    unsigned int destination, int vector,
+			    struct io_apic_irq_attr *attr)
+{
+	if (!remap_ops || !remap_ops->setup_ioapic_entry)
+		return -ENODEV;
+
+	return remap_ops->setup_ioapic_entry(irq, entry, destination,
+					     vector, attr);
+}
diff --git a/drivers/iommu/intr_remapping.h b/drivers/iommu/intr_remapping.h
index 2744c9a..e8994f2 100644
--- a/drivers/iommu/intr_remapping.h
+++ b/drivers/iommu/intr_remapping.h
@@ -24,6 +24,9 @@
 
 #ifdef CONFIG_IRQ_REMAP
 
+struct IO_APIC_route_entry;
+struct io_apic_irq_attr;
+
 extern int disable_intremap;
 extern int disable_sourceid_checking;
 extern int no_x2apic_optout;
@@ -46,6 +49,11 @@ struct irq_remap_ops {
 
 	/* Enable fault handling */
 	int  (*enable_faulting)(void);
+
+	/* IO-APIC setup routine */
+	int (*setup_ioapic_entry)(int irq, struct IO_APIC_route_entry *,
+				  unsigned int, int,
+				  struct io_apic_irq_attr *);
 };
 
 extern struct irq_remap_ops intel_irq_remap_ops;
-- 
1.7.5.4
