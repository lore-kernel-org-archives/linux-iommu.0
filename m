From: Suresh Siddha <suresh.b.siddha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 08/10] x86,
	iommu/vt-d: Clean up interfaces for interrupt remapping
Date: Fri, 30 Mar 2012 11:47:06 -0700
Message-ID: <1333133228-3134-9-git-send-email-suresh.b.siddha@intel.com>
References: <1333133228-3134-1-git-send-email-suresh.b.siddha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1333133228-3134-1-git-send-email-suresh.b.siddha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Suresh Siddha <suresh.b.siddha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>

Remove the Intel specific interfaces from dmar.h and remove
asm/irq_remapping.h which is only used for io_apic.c anyway.

Signed-off-by: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Acked-by: Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Suresh Siddha <suresh.b.siddha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 arch/x86/include/asm/irq_remapping.h |   22 ------------
 arch/x86/kernel/apic/io_apic.c       |   17 +++++++++-
 drivers/iommu/intel_intr_remapping.c |   20 ++++++------
 include/linux/dmar.h                 |   59 ----------------------------------
 4 files changed, 26 insertions(+), 92 deletions(-)
 delete mode 100644 arch/x86/include/asm/irq_remapping.h

diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
deleted file mode 100644
index 0ddfc0b..0000000
--- a/arch/x86/include/asm/irq_remapping.h
+++ /dev/null
@@ -1,22 +0,0 @@
-#ifndef _ASM_X86_IRQ_REMAPPING_H
-#define _ASM_X86_IRQ_REMAPPING_H
-
-#define IRTE_DEST(dest) ((x2apic_mode) ? dest : dest << 8)
-
-#ifdef CONFIG_IRQ_REMAP
-static void irq_remap_modify_chip_defaults(struct irq_chip *chip);
-static inline bool irq_remapped(struct irq_cfg *cfg)
-{
-	return cfg->irq_2_iommu.iommu != NULL;
-}
-#else
-static inline bool irq_remapped(struct irq_cfg *cfg)
-{
-	return false;
-}
-static inline void irq_remap_modify_chip_defaults(struct irq_chip *chip)
-{
-}
-#endif
-
-#endif	/* _ASM_X86_IRQ_REMAPPING_H */
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 3db693b..073edd1 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -58,7 +58,6 @@
 #include <asm/hypertransport.h>
 #include <asm/setup.h>
 #include <asm/intr_remapping.h>
-#include <asm/irq_remapping.h>
 #include <asm/hpet.h>
 #include <asm/hw_irq.h>
 
@@ -87,6 +86,22 @@ void __init set_io_apic_ops(const struct io_apic_ops *ops)
 	io_apic_ops = *ops;
 }
 
+#ifdef CONFIG_IRQ_REMAP
+static void irq_remap_modify_chip_defaults(struct irq_chip *chip);
+static inline bool irq_remapped(struct irq_cfg *cfg)
+{
+	return cfg->irq_2_iommu.iommu != NULL;
+}
+#else
+static inline bool irq_remapped(struct irq_cfg *cfg)
+{
+	return false;
+}
+static inline void irq_remap_modify_chip_defaults(struct irq_chip *chip)
+{
+}
+#endif
+
 /*
  *      Is the SiS APIC rmw bug present ?
  *      -1 = don't know, 0 = no, 1 = yes
diff --git a/drivers/iommu/intel_intr_remapping.c b/drivers/iommu/intel_intr_remapping.c
index a3bae67..7472634 100644
--- a/drivers/iommu/intel_intr_remapping.c
+++ b/drivers/iommu/intel_intr_remapping.c
@@ -64,7 +64,7 @@ int get_irte(int irq, struct irte *entry)
 	return 0;
 }
 
-int alloc_irte(struct intel_iommu *iommu, int irq, u16 count)
+static int alloc_irte(struct intel_iommu *iommu, int irq, u16 count)
 {
 	struct ir_table *table = iommu->ir_table;
 	struct irq_2_iommu *irq_iommu = irq_2_iommu(irq);
@@ -136,7 +136,7 @@ static int qi_flush_iec(struct intel_iommu *iommu, int index, int mask)
 	return qi_submit_sync(&desc, iommu);
 }
 
-int map_irq_to_irte_handle(int irq, u16 *sub_handle)
+static int map_irq_to_irte_handle(int irq, u16 *sub_handle)
 {
 	struct irq_2_iommu *irq_iommu = irq_2_iommu(irq);
 	unsigned long flags;
@@ -152,7 +152,7 @@ int map_irq_to_irte_handle(int irq, u16 *sub_handle)
 	return index;
 }
 
-int set_irte_irq(int irq, struct intel_iommu *iommu, u16 index, u16 subhandle)
+static int set_irte_irq(int irq, struct intel_iommu *iommu, u16 index, u16 subhandle)
 {
 	struct irq_2_iommu *irq_iommu = irq_2_iommu(irq);
 	unsigned long flags;
@@ -172,7 +172,7 @@ int set_irte_irq(int irq, struct intel_iommu *iommu, u16 index, u16 subhandle)
 	return 0;
 }
 
-int modify_irte(int irq, struct irte *irte_modified)
+static int modify_irte(int irq, struct irte *irte_modified)
 {
 	struct irq_2_iommu *irq_iommu = irq_2_iommu(irq);
 	struct intel_iommu *iommu;
@@ -200,7 +200,7 @@ int modify_irte(int irq, struct irte *irte_modified)
 	return rc;
 }
 
-struct intel_iommu *map_hpet_to_ir(u8 hpet_id)
+static struct intel_iommu *map_hpet_to_ir(u8 hpet_id)
 {
 	int i;
 
@@ -210,7 +210,7 @@ struct intel_iommu *map_hpet_to_ir(u8 hpet_id)
 	return NULL;
 }
 
-struct intel_iommu *map_ioapic_to_ir(int apic)
+static struct intel_iommu *map_ioapic_to_ir(int apic)
 {
 	int i;
 
@@ -220,7 +220,7 @@ struct intel_iommu *map_ioapic_to_ir(int apic)
 	return NULL;
 }
 
-struct intel_iommu *map_dev_to_ir(struct pci_dev *dev)
+static struct intel_iommu *map_dev_to_ir(struct pci_dev *dev)
 {
 	struct dmar_drhd_unit *drhd;
 
@@ -312,7 +312,7 @@ static void set_irte_sid(struct irte *irte, unsigned int svt,
 	irte->sid = sid;
 }
 
-int set_ioapic_sid(struct irte *irte, int apic)
+static int set_ioapic_sid(struct irte *irte, int apic)
 {
 	int i;
 	u16 sid = 0;
@@ -337,7 +337,7 @@ int set_ioapic_sid(struct irte *irte, int apic)
 	return 0;
 }
 
-int set_hpet_sid(struct irte *irte, u8 id)
+static int set_hpet_sid(struct irte *irte, u8 id)
 {
 	int i;
 	u16 sid = 0;
@@ -367,7 +367,7 @@ int set_hpet_sid(struct irte *irte, u8 id)
 	return 0;
 }
 
-int set_msi_sid(struct irte *irte, struct pci_dev *dev)
+static int set_msi_sid(struct irte *irte, struct pci_dev *dev)
 {
 	struct pci_dev *bridge;
 
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index 7a207a3..b029d1a 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -114,65 +114,6 @@ struct irte {
 	};
 };
 
-#ifdef CONFIG_IRQ_REMAP
-extern int get_irte(int irq, struct irte *entry);
-extern int modify_irte(int irq, struct irte *irte_modified);
-extern int alloc_irte(struct intel_iommu *iommu, int irq, u16 count);
-extern int set_irte_irq(int irq, struct intel_iommu *iommu, u16 index,
-   			u16 sub_handle);
-extern int map_irq_to_irte_handle(int irq, u16 *sub_handle);
-
-extern struct intel_iommu *map_dev_to_ir(struct pci_dev *dev);
-extern struct intel_iommu *map_ioapic_to_ir(int apic);
-extern struct intel_iommu *map_hpet_to_ir(u8 id);
-extern int set_ioapic_sid(struct irte *irte, int apic);
-extern int set_hpet_sid(struct irte *irte, u8 id);
-extern int set_msi_sid(struct irte *irte, struct pci_dev *dev);
-#else
-static inline int alloc_irte(struct intel_iommu *iommu, int irq, u16 count)
-{
-	return -1;
-}
-static inline int modify_irte(int irq, struct irte *irte_modified)
-{
-	return -1;
-}
-static inline int map_irq_to_irte_handle(int irq, u16 *sub_handle)
-{
-	return -1;
-}
-static inline int set_irte_irq(int irq, struct intel_iommu *iommu, u16 index,
-			       u16 sub_handle)
-{
-	return -1;
-}
-static inline struct intel_iommu *map_dev_to_ir(struct pci_dev *dev)
-{
-	return NULL;
-}
-static inline struct intel_iommu *map_ioapic_to_ir(int apic)
-{
-	return NULL;
-}
-static inline struct intel_iommu *map_hpet_to_ir(unsigned int hpet_id)
-{
-	return NULL;
-}
-static inline int set_ioapic_sid(struct irte *irte, int apic)
-{
-	return 0;
-}
-static inline int set_hpet_sid(struct irte *irte, u8 id)
-{
-	return -1;
-}
-static inline int set_msi_sid(struct irte *irte, struct pci_dev *dev)
-{
-	return 0;
-}
-
-#endif
-
 enum {
 	IRQ_REMAP_XAPIC_MODE,
 	IRQ_REMAP_X2APIC_MODE,
-- 
1.7.6.5
