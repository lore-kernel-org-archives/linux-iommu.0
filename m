From: Suresh Siddha <suresh.b.siddha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 03/10] iommu/vt-d: Convert missing apic.c intr-remapping call
	to remap_ops
Date: Fri, 30 Mar 2012 11:47:01 -0700
Message-ID: <1333133228-3134-4-git-send-email-suresh.b.siddha@intel.com>
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

Convert these calls too:

	* Disable of remapping hardware
	* Reenable of remapping hardware
	* Enable fault handling

With that all of arch/x86/kernel/apic/apic.c is converted to
use the generic intr-remapping interface.

Signed-off-by: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Acked-by: Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Suresh Siddha <suresh.b.siddha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 arch/x86/include/asm/intr_remapping.h |    6 ++++++
 arch/x86/kernel/apic/apic.c           |    6 +++---
 drivers/iommu/intel_intr_remapping.c  |    7 +++++--
 drivers/iommu/intr_remapping.c        |   24 ++++++++++++++++++++++++
 drivers/iommu/intr_remapping.h        |    9 +++++++++
 include/linux/dmar.h                  |   18 ------------------
 6 files changed, 47 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/intr_remapping.h b/arch/x86/include/asm/intr_remapping.h
index 207c605..55aa892 100644
--- a/arch/x86/include/asm/intr_remapping.h
+++ b/arch/x86/include/asm/intr_remapping.h
@@ -30,6 +30,9 @@ extern void setup_intr_remapping(void);
 extern int intr_remapping_supported(void);
 extern int intr_hardware_init(void);
 extern int intr_hardware_enable(void);
+extern void intr_hardware_disable(void);
+extern int intr_hardware_reenable(int);
+extern int intr_enable_fault_handling(void);
 
 #else  /* CONFIG_IRQ_REMAP */
 
@@ -39,6 +42,9 @@ static inline void setup_intr_remapping(void) { }
 static inline int intr_remapping_supported(void) { return 0; }
 static inline int intr_hardware_init(void) { return -ENODEV; }
 static inline int intr_hardware_enable(void) { return -ENODEV; }
+static inline void intr_hardware_disable(void) { }
+static inline int intr_hardware_reenable(int eim) { return -ENODEV; }
+static inline int intr_enable_fault_handling(void) { return -ENODEV; }
 
 #endif /* CONFIG_IRQ_REMAP */
 
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 7fbeaa7..846f3b6 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1443,7 +1443,7 @@ void __init bsp_end_local_APIC_setup(void)
 	 * handling for interrupt remapping.
 	 */
 	if (intr_remapping_enabled)
-		enable_drhd_fault_handling();
+		intr_enable_fault_handling();
 
 }
 
@@ -2177,7 +2177,7 @@ static int lapic_suspend(void)
 	disable_local_APIC();
 
 	if (intr_remapping_enabled)
-		disable_intr_remapping();
+		intr_hardware_disable();
 
 	local_irq_restore(flags);
 	return 0;
@@ -2244,7 +2244,7 @@ static void lapic_resume(void)
 	apic_read(APIC_ESR);
 
 	if (intr_remapping_enabled)
-		reenable_intr_remapping(x2apic_mode);
+		intr_hardware_reenable(x2apic_mode);
 
 	local_irq_restore(flags);
 }
diff --git a/drivers/iommu/intel_intr_remapping.c b/drivers/iommu/intel_intr_remapping.c
index 9c742fb..610b75b 100644
--- a/drivers/iommu/intel_intr_remapping.c
+++ b/drivers/iommu/intel_intr_remapping.c
@@ -764,7 +764,7 @@ int __init ir_dev_scope_init(void)
 }
 rootfs_initcall(ir_dev_scope_init);
 
-void disable_intr_remapping(void)
+static void disable_intr_remapping(void)
 {
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu = NULL;
@@ -780,7 +780,7 @@ void disable_intr_remapping(void)
 	}
 }
 
-int reenable_intr_remapping(int eim)
+static int reenable_intr_remapping(int eim)
 {
 	struct dmar_drhd_unit *drhd;
 	int setup = 0;
@@ -818,4 +818,7 @@ struct irq_remap_ops intel_irq_remap_ops = {
 	.supported		= intel_intr_remapping_supported,
 	.hardware_init		= dmar_table_init,
 	.hardware_enable	= intel_enable_intr_remapping,
+	.hardware_disable	= disable_intr_remapping,
+	.hardware_reenable	= reenable_intr_remapping,
+	.enable_faulting	= enable_drhd_fault_handling,
 };
diff --git a/drivers/iommu/intr_remapping.c b/drivers/iommu/intr_remapping.c
index 670c69a..9aabed7 100644
--- a/drivers/iommu/intr_remapping.c
+++ b/drivers/iommu/intr_remapping.c
@@ -74,3 +74,27 @@ int __init intr_hardware_enable(void)
 
 	return remap_ops->hardware_enable();
 }
+
+void intr_hardware_disable(void)
+{
+	if (!remap_ops || !remap_ops->hardware_disable)
+		return;
+
+	remap_ops->hardware_disable();
+}
+
+int intr_hardware_reenable(int mode)
+{
+	if (!remap_ops || !remap_ops->hardware_reenable)
+		return 0;
+
+	return remap_ops->hardware_reenable(mode);
+}
+
+int __init intr_enable_fault_handling(void)
+{
+	if (!remap_ops || !remap_ops->enable_faulting)
+		return -ENODEV;
+
+	return remap_ops->enable_faulting();
+}
diff --git a/drivers/iommu/intr_remapping.h b/drivers/iommu/intr_remapping.h
index d6df732..2744c9a 100644
--- a/drivers/iommu/intr_remapping.h
+++ b/drivers/iommu/intr_remapping.h
@@ -37,6 +37,15 @@ struct irq_remap_ops {
 
 	/* Enables the remapping hardware */
 	int  (*hardware_enable)(void);
+
+	/* Disables the remapping hardware */
+	void (*hardware_disable)(void);
+
+	/* Reenables the remapping hardware */
+	int  (*hardware_reenable)(int);
+
+	/* Enable fault handling */
+	int  (*enable_faulting)(void);
 };
 
 extern struct irq_remap_ops intel_irq_remap_ops;
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index 6d66c9c..f2bd87f 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -115,9 +115,6 @@ struct irte {
 };
 
 #ifdef CONFIG_IRQ_REMAP
-extern void disable_intr_remapping(void);
-extern int reenable_intr_remapping(int);
-
 extern int get_irte(int irq, struct irte *entry);
 extern int modify_irte(int irq, struct irte *irte_modified);
 extern int alloc_irte(struct intel_iommu *iommu, int irq, u16 count);
@@ -179,21 +176,6 @@ static inline int set_msi_sid(struct irte *irte, struct pci_dev *dev)
 	return 0;
 }
 
-#define intr_remapping_enabled		(0)
-
-static inline int enable_intr_remapping(void)
-{
-	return -1;
-}
-
-static inline void disable_intr_remapping(void)
-{
-}
-
-static inline int reenable_intr_remapping(int eim)
-{
-	return 0;
-}
 #endif
 
 enum {
-- 
1.7.6.5
