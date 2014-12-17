From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch v1 16/17] iommu/irq_remapping: Change variable
	disable_irq_remap to be static
Date: Wed, 17 Dec 2014 12:35:47 +0800
Message-ID: <1418790948-22804-17-git-send-email-jiang.liu@linux.intel.com>
References: <1418790948-22804-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1418790948-22804-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Cc: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Change variable disable_irq_remap to be static and simplify the code.

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c      |    6 +-----
 drivers/iommu/intel_irq_remapping.c |    5 -----
 drivers/iommu/irq_remapping.c       |    3 +--
 drivers/iommu/irq_remapping.h       |    2 --
 4 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 970979ecbebb..e430dc8dffdf 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -2014,9 +2014,6 @@ static bool detect_ivrs(void)
 	/* Make sure ACS will be enabled during PCI probe */
 	pci_request_acs();
 
-	if (!disable_irq_remap)
-		amd_iommu_irq_remap = true;
-
 	return true;
 }
 
@@ -2123,8 +2120,7 @@ static int __init iommu_go_to_state(enum iommu_init_state state)
 #ifdef CONFIG_IRQ_REMAP
 int __init amd_iommu_prepare(void)
 {
-	if (!amd_iommu_irq_remap)
-		return -1;
+	amd_iommu_irq_remap = true;
 
 	return iommu_go_to_state(IOMMU_ACPI_FINISHED);
 }
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 9c1aafb26632..78cdd0d15424 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -588,10 +588,6 @@ static int __init intel_prepare_irq_remapping(void)
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu;
 
-	/* First check whether IRQ remapping should be enabled */
-	if (disable_irq_remap)
-		return -ENODEV;
-
 	if (irq_remap_broken) {
 		printk(KERN_WARNING
 			"This system BIOS has enabled interrupt remapping\n"
@@ -600,7 +596,6 @@ static int __init intel_prepare_irq_remapping(void)
 			"interrupt remapping is being disabled.  Please\n"
 			"contact your BIOS vendor for an update\n");
 		add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
-		disable_irq_remap = 1;
 		return -ENODEV;
 	}
 
diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index a0b26ca853ae..c6fdca412e71 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -17,12 +17,11 @@
 #include "irq_remapping.h"
 
 int irq_remapping_enabled;
-
-int disable_irq_remap;
 int irq_remap_broken;
 int disable_sourceid_checking;
 int no_x2apic_optout;
 
+static int disable_irq_remap;
 static struct irq_remap_ops *remap_ops;
 
 static int msi_alloc_remapped_irq(struct pci_dev *pdev, int irq, int nvec);
diff --git a/drivers/iommu/irq_remapping.h b/drivers/iommu/irq_remapping.h
index a8edfea0ab5d..c448eb48340a 100644
--- a/drivers/iommu/irq_remapping.h
+++ b/drivers/iommu/irq_remapping.h
@@ -31,7 +31,6 @@ struct cpumask;
 struct pci_dev;
 struct msi_msg;
 
-extern int disable_irq_remap;
 extern int irq_remap_broken;
 extern int disable_sourceid_checking;
 extern int no_x2apic_optout;
@@ -86,7 +85,6 @@ extern struct irq_remap_ops amd_iommu_irq_ops;
 #else  /* CONFIG_IRQ_REMAP */
 
 #define irq_remapping_enabled 0
-#define disable_irq_remap     1
 #define irq_remap_broken      0
 
 #endif /* CONFIG_IRQ_REMAP */
-- 
1.7.10.4
