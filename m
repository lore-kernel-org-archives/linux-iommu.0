From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 12/16] iommu/amd: Add initialization routines for AMD
	interrupt remapping
Date: Fri, 28 Sep 2012 14:24:02 +0200
Message-ID: <1348835046-3262-13-git-send-email-joerg.roedel@amd.com>
References: <1348835046-3262-1-git-send-email-joerg.roedel@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1348835046-3262-1-git-send-email-joerg.roedel-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Add the six routines required to setup interrupt remapping
with the AMD IOMMU. Also put it all together into the AMD
specific irq_remap_ops.

Signed-off-by: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu.c       |   16 +++++++++++++++
 drivers/iommu/amd_iommu_init.c  |   42 +++++++++++++++++++++++++++++++++++++++
 drivers/iommu/amd_iommu_proto.h |    8 ++++++++
 drivers/iommu/irq_remapping.h   |    1 +
 4 files changed, 67 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index af245f4..6fe4ad7 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -45,6 +45,7 @@
 
 #include "amd_iommu_proto.h"
 #include "amd_iommu_types.h"
+#include "irq_remapping.h"
 
 #define CMD_SET_TYPE(cmd, t) ((cmd)->data[1] |= ((t) << 28))
 
@@ -4226,4 +4227,19 @@ static int setup_hpet_msi(unsigned int irq, unsigned int id)
 	return 0;
 }
 
+struct irq_remap_ops amd_iommu_irq_ops = {
+	.supported		= amd_iommu_supported,
+	.prepare		= amd_iommu_prepare,
+	.enable			= amd_iommu_enable,
+	.disable		= amd_iommu_disable,
+	.reenable		= amd_iommu_reenable,
+	.enable_faulting	= amd_iommu_enable_faulting,
+	.setup_ioapic_entry	= setup_ioapic_entry,
+	.set_affinity		= set_affinity,
+	.free_irq		= free_irq,
+	.compose_msi_msg	= compose_msi_msg,
+	.msi_alloc_irq		= msi_alloc_irq,
+	.msi_setup_irq		= msi_setup_irq,
+	.setup_hpet_msi		= setup_hpet_msi,
+};
 #endif
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 202b2b7..42db810 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -34,6 +34,7 @@
 #include <asm/x86_init.h>
 #include <asm/iommu_table.h>
 #include <asm/io_apic.h>
+#include <asm/irq_remapping.h>
 
 #include "amd_iommu_proto.h"
 #include "amd_iommu_types.h"
@@ -1894,7 +1895,48 @@ static int __init iommu_go_to_state(enum iommu_init_state state)
 	return ret;
 }
 
+#ifdef CONFIG_IRQ_REMAP
+int __init amd_iommu_prepare(void)
+{
+	return iommu_go_to_state(IOMMU_ACPI_FINISHED);
+}
+
+int __init amd_iommu_supported(void)
+{
+	return amd_iommu_irq_remap ? 1 : 0;
+}
+
+int __init amd_iommu_enable(void)
+{
+	int ret;
+
+	ret = iommu_go_to_state(IOMMU_ENABLED);
+	if (ret)
+		return ret;
 
+	irq_remapping_enabled = 1;
+
+	return 0;
+}
+
+void amd_iommu_disable(void)
+{
+	amd_iommu_suspend();
+}
+
+int amd_iommu_reenable(int mode)
+{
+	amd_iommu_resume();
+
+	return 0;
+}
+
+int __init amd_iommu_enable_faulting(void)
+{
+	/* We enable MSI later when PCI is initialized */
+	return 0;
+}
+#endif
 
 /*
  * This is the core init function for AMD IOMMU hardware in the system.
diff --git a/drivers/iommu/amd_iommu_proto.h b/drivers/iommu/amd_iommu_proto.h
index 1a7f41c..c294961 100644
--- a/drivers/iommu/amd_iommu_proto.h
+++ b/drivers/iommu/amd_iommu_proto.h
@@ -32,6 +32,14 @@ extern void amd_iommu_uninit_devices(void);
 extern void amd_iommu_init_notifier(void);
 extern void amd_iommu_init_api(void);
 
+/* Needed for interrupt remapping */
+extern int amd_iommu_supported(void);
+extern int amd_iommu_prepare(void);
+extern int amd_iommu_enable(void);
+extern void amd_iommu_disable(void);
+extern int amd_iommu_reenable(int);
+extern int amd_iommu_enable_faulting(void);
+
 /* IOMMUv2 specific functions */
 struct iommu_domain;
 
diff --git a/drivers/iommu/irq_remapping.h b/drivers/iommu/irq_remapping.h
index 624d360..95363ac 100644
--- a/drivers/iommu/irq_remapping.h
+++ b/drivers/iommu/irq_remapping.h
@@ -82,6 +82,7 @@ struct irq_remap_ops {
 };
 
 extern struct irq_remap_ops intel_irq_remap_ops;
+extern struct irq_remap_ops amd_iommu_irq_ops;
 
 #else  /* CONFIG_IRQ_REMAP */
 
-- 
1.7.9.5
