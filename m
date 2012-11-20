From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 09/19] x86,
	io_apic: Move irq_remapping_enabled checks out of check_timer()
Date: Tue, 20 Nov 2012 14:12:46 +0100
Message-ID: <1353417176-18945-10-git-send-email-joro@8bytes.org>
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

Move these checks to IRQ remapping code by introducing the
panic_on_irq_remap() function.

Signed-off-by: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Acked-by: Sebastian Andrzej Siewior <sebastian-E0PNVn5OA6ohrxcnuTQ+TQ@public.gmane.org>
---
 arch/x86/include/asm/irq_remapping.h |    5 +++++
 arch/x86/kernel/apic/io_apic.c       |    6 ++----
 drivers/iommu/irq_remapping.c        |    6 ++++++
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
index f1afa04..fb99a73 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -45,6 +45,7 @@ extern void compose_remapped_msi_msg(struct pci_dev *pdev,
 				     unsigned int irq, unsigned int dest,
 				     struct msi_msg *msg, u8 hpet_id);
 extern int setup_hpet_msi_remapped(unsigned int irq, unsigned int id);
+extern void panic_if_irq_remap(const char *msg);
 
 #else  /* CONFIG_IRQ_REMAP */
 
@@ -75,6 +76,10 @@ static inline int setup_hpet_msi_remapped(unsigned int irq, unsigned int id)
 {
 	return -ENODEV;
 }
+
+static inline void panic_if_irq_remap(const char *msg)
+{
+}
 #endif /* CONFIG_IRQ_REMAP */
 
 #endif /* __X86_IRQ_REMAPPING_H */
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index ed43e90..edaa528 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2789,8 +2789,7 @@ static inline void __init check_timer(void)
 	 * 8259A.
 	 */
 	if (pin1 == -1) {
-		if (irq_remapping_enabled)
-			panic("BIOS bug: timer not connected to IO-APIC");
+		panic_if_irq_remap("BIOS bug: timer not connected to IO-APIC");
 		pin1 = pin2;
 		apic1 = apic2;
 		no_pin1 = 1;
@@ -2822,8 +2821,7 @@ static inline void __init check_timer(void)
 				clear_IO_APIC_pin(0, pin1);
 			goto out;
 		}
-		if (irq_remapping_enabled)
-			panic("timer doesn't work through Interrupt-remapped IO-APIC");
+		panic_if_irq_remap("timer doesn't work through Interrupt-remapped IO-APIC");
 		local_irq_disable();
 		clear_IO_APIC_pin(apic1, pin1);
 		if (!no_pin1)
diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index 6662ae9..3514604 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -266,3 +266,9 @@ int setup_hpet_msi_remapped(unsigned int irq, unsigned int id)
 
 	return remap_ops->setup_hpet_msi(irq, id);
 }
+
+void panic_if_irq_remap(const char *msg)
+{
+	if (irq_remapping_enabled)
+		panic(msg);
+}
-- 
1.7.9.5
