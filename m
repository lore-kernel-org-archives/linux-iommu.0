From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 04/16] iommu/amd: Check if IOAPIC information is correct
Date: Fri, 28 Sep 2012 14:23:54 +0200
Message-ID: <1348835046-3262-5-git-send-email-joerg.roedel@amd.com>
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

When the IOAPIC information provided in the IVRS table is
not correct or not complete the system may not boot at all
when interrupt remapping is enabled. So check if this
information is correct and print out a firmware bug message
when it is not.

Signed-off-by: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/Kconfig          |    2 +-
 drivers/iommu/amd_iommu_init.c |   27 ++++++++++++++++++++++++---
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 9f69b56..e39f9db 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -42,7 +42,7 @@ config AMD_IOMMU
 	select PCI_PRI
 	select PCI_PASID
 	select IOMMU_API
-	depends on X86_64 && PCI && ACPI
+	depends on X86_64 && PCI && ACPI && X86_IO_APIC
 	---help---
 	  With this option you can enable support for AMD IOMMU hardware in
 	  your system. An IOMMU is a hardware component which provides
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index db100c5..3f0b68f 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -33,6 +33,7 @@
 #include <asm/gart.h>
 #include <asm/x86_init.h>
 #include <asm/iommu_table.h>
+#include <asm/io_apic.h>
 
 #include "amd_iommu_proto.h"
 #include "amd_iommu_types.h"
@@ -1572,6 +1573,23 @@ static void __init free_on_init_error(void)
 #endif
 }
 
+static bool __init check_ioapic_information(void)
+{
+	int idx;
+
+	for (idx = 0; idx < nr_ioapics; ++idx) {
+		int id = mpc_ioapic_id(idx);
+
+		if (get_ioapic_devid(id) < 0) {
+			pr_err(FW_BUG "AMD-Vi: IO-APIC[%d] not in IVRS table\n", id);
+			pr_err("AMD-Vi: Disabling interrupt remapping due to BIOS Bug\n");
+			return false;
+		}
+	}
+
+	return true;
+}
+
 /*
  * This is the hardware init function for AMD IOMMU in the system.
  * This function is called either from amd_iommu_init or from the interrupt
@@ -1658,9 +1676,6 @@ static int __init early_amd_iommu_init(void)
 	if (amd_iommu_pd_alloc_bitmap == NULL)
 		goto out;
 
-	/* init the device table */
-	init_device_table();
-
 	/*
 	 * let all alias entries point to itself
 	 */
@@ -1683,6 +1698,9 @@ static int __init early_amd_iommu_init(void)
 	if (ret)
 		goto out;
 
+	if (amd_iommu_irq_remap)
+		amd_iommu_irq_remap = check_ioapic_information();
+
 	if (amd_iommu_irq_remap) {
 		/*
 		 * Interrupt remapping enabled, create kmem_cache for the
@@ -1706,6 +1724,9 @@ static int __init early_amd_iommu_init(void)
 	if (ret)
 		goto out;
 
+	/* init the device table */
+	init_device_table();
+
 out:
 	/* Don't leak any ACPI memory */
 	early_acpi_os_unmap_memory((char __iomem *)ivrs_base, ivrs_size);
-- 
1.7.9.5
