From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 03/28] x86/irq: Use irq_remap specific print_IO_APIC paths
	only on Intel
Date: Thu, 5 Jul 2012 14:36:23 +0200
Message-ID: <1341491808-23083-4-git-send-email-joerg.roedel@amd.com>
References: <1341491808-23083-1-git-send-email-joerg.roedel@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1341491808-23083-1-git-send-email-joerg.roedel-5C7GfCeVMHo@public.gmane.org>
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
Cc: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Suresh Siddha <suresh.b.siddha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

The VT-d IOMMU requires a special setup of the IO-APIC to
remap its interrupts. Therefore the print_IO_APIC routine
has seperate code paths to accout for that and print out the
special setup. This is not required on AMD IOMMU systems, so
make these path really Intel specific.

Cc: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Suresh Siddha <suresh.b.siddha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
---
 arch/x86/include/asm/irq_remapping.h |    2 ++
 arch/x86/kernel/apic/io_apic.c       |    4 ++--
 drivers/iommu/intel_irq_remapping.c  |    2 ++
 drivers/iommu/irq_remapping.c        |    1 +
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
index 5fb9bbb..228d5e5 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -27,6 +27,7 @@
 #ifdef CONFIG_IRQ_REMAP
 
 extern int irq_remapping_enabled;
+extern int intel_irq_remap_debug;
 
 extern void setup_irq_remapping_ops(void);
 extern int irq_remapping_supported(void);
@@ -55,6 +56,7 @@ extern int setup_hpet_msi_remapped(unsigned int irq, unsigned int id);
 #else  /* CONFIG_IRQ_REMAP */
 
 #define irq_remapping_enabled	0
+#define intel_irq_remap_debug	0
 
 static inline void setup_irq_remapping_ops(void) { }
 static inline int irq_remapping_supported(void) { return 0; }
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index d5bccc0..260cf8f 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1559,7 +1559,7 @@ __apicdebuginit(void) print_IO_APIC(int ioapic_idx)
 
 	printk(KERN_DEBUG ".... IRQ redirection table:\n");
 
-	if (irq_remapping_enabled) {
+	if (intel_irq_remap_debug) {
 		printk(KERN_DEBUG " NR Indx Fmt Mask Trig IRR"
 			" Pol Stat Indx2 Zero Vect:\n");
 	} else {
@@ -1568,7 +1568,7 @@ __apicdebuginit(void) print_IO_APIC(int ioapic_idx)
 	}
 
 	for (i = 0; i <= reg_01.bits.entries; i++) {
-		if (irq_remapping_enabled) {
+		if (intel_irq_remap_debug) {
 			struct IO_APIC_route_entry entry;
 			struct IR_IO_APIC_route_entry *ir_entry;
 
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 29411ed..845f60f 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -621,6 +621,8 @@ static int __init intel_enable_irq_remapping(void)
 		goto error;
 
 	irq_remapping_enabled = 1;
+	intel_irq_remap_debug = 1;
+
 	pr_info("Enabled IRQ remapping in %s mode\n", eim ? "x2apic" : "xapic");
 
 	return eim ? IRQ_REMAP_X2APIC_MODE : IRQ_REMAP_XAPIC_MODE;
diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index 40cda8e..7a880c3 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -5,6 +5,7 @@
 #include "irq_remapping.h"
 
 int irq_remapping_enabled;
+int intel_irq_remap_debug;
 
 int disable_irq_remap;
 int disable_sourceid_checking;
-- 
1.7.9.5
