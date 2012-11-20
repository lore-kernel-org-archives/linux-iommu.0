From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 16/19] x86, irq: Introduce setup_remapped_irq()
Date: Tue, 20 Nov 2012 14:12:53 +0100
Message-ID: <1353417176-18945-17-git-send-email-joro@8bytes.org>
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

This function does irq-remapping specific interrupt setup
like modifying the chip defaults.

Signed-off-by: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Acked-by: Sebastian Andrzej Siewior <sebastian-E0PNVn5OA6ohrxcnuTQ+TQ@public.gmane.org>
---
 arch/x86/include/asm/irq_remapping.h |    9 +++++++++
 arch/x86/kernel/apic/io_apic.c       |   13 +++----------
 drivers/iommu/irq_remapping.c        |    9 +++++++++
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
index 562db68..b30fca1 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -44,6 +44,9 @@ extern void compose_remapped_msi_msg(struct pci_dev *pdev,
 				     struct msi_msg *msg, u8 hpet_id);
 extern int setup_hpet_msi_remapped(unsigned int irq, unsigned int id);
 extern void panic_if_irq_remap(const char *msg);
+extern bool setup_remapped_irq(int irq,
+			       struct irq_cfg *cfg,
+			       struct irq_chip *chip);
 
 static inline bool irq_remapped(struct irq_cfg *cfg)
 {
@@ -93,6 +96,12 @@ static inline void irq_remap_modify_chip_defaults(struct irq_chip *chip)
 {
 }
 
+static inline bool setup_remapped_irq(int irq,
+				      struct irq_cfg *cfg,
+				      struct irq_chip *chip)
+{
+	return false;
+}
 #endif /* CONFIG_IRQ_REMAP */
 
 #endif /* __X86_IRQ_REMAPPING_H */
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 73f1bf2..391c0b9 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1292,11 +1292,8 @@ static void ioapic_register_intr(unsigned int irq, struct irq_cfg *cfg,
 		fasteoi = false;
 	}
 
-	if (irq_remapped(cfg)) {
-		irq_set_status_flags(irq, IRQ_MOVE_PCNTXT);
-		irq_remap_modify_chip_defaults(chip);
+	if (setup_remapped_irq(irq, cfg, chip))
 		fasteoi = trigger != 0;
-	}
 
 	hdl = fasteoi ? handle_fasteoi_irq : handle_edge_irq;
 	irq_set_chip_and_handler_name(irq, chip, hdl,
@@ -3106,10 +3103,7 @@ int setup_msi_irq(struct pci_dev *dev, struct msi_desc *msidesc, int irq)
 	irq_set_msi_desc(irq, msidesc);
 	write_msi_msg(irq, &msg);
 
-	if (irq_remapped(irq_get_chip_data(irq))) {
-		irq_set_status_flags(irq, IRQ_MOVE_PCNTXT);
-		irq_remap_modify_chip_defaults(chip);
-	}
+	setup_remapped_irq(irq, irq_get_chip_data(irq), chip);
 
 	irq_set_chip_and_handler_name(irq, chip, handle_edge_irq, "edge");
 
@@ -3247,8 +3241,7 @@ int default_setup_hpet_msi(unsigned int irq, unsigned int id)
 
 	hpet_msi_write(irq_get_handler_data(irq), &msg);
 	irq_set_status_flags(irq, IRQ_MOVE_PCNTXT);
-	if (irq_remapped(irq_get_chip_data(irq)))
-		irq_remap_modify_chip_defaults(chip);
+	setup_remapped_irq(irq, irq_get_chip_data(irq), chip);
 
 	irq_set_chip_and_handler_name(irq, chip, handle_edge_irq, "edge");
 	return 0;
diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index 5053482..30884ee 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -300,3 +300,12 @@ void irq_remap_modify_chip_defaults(struct irq_chip *chip)
 	chip->irq_eoi = ir_ack_apic_level;
 	chip->irq_set_affinity = x86_io_apic_ops.set_affinity;
 }
+
+bool setup_remapped_irq(int irq, struct irq_cfg *cfg, struct irq_chip *chip)
+{
+	if (!irq_remapped(cfg))
+		return false;
+	irq_set_status_flags(irq, IRQ_MOVE_PCNTXT);
+	irq_remap_modify_chip_defaults(chip);
+	return true;
+}
-- 
1.7.9.5
