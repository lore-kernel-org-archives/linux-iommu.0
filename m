From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [PATCH 2/9] VFIO_IOMMU_TYPE1: workaround to build for platform devices
Date: Wed, 11 Dec 2013 21:58:26 +0100
Message-ID: <1386795513-32426-3-git-send-email-a.motakis@virtualopensystems.com>
References: <1386795513-32426-1-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1386795513-32426-1-git-send-email-a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: "open list:VFIO DRIVER" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This is a workaround to make the VFIO_IOMMU_TYPE1 driver usable with
platform devices instead of PCI. A future permanent fix should support
both. This is required in order to use the Exynos SMMU, or ARM SMMU
driver with VFIO.

Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
---
 drivers/vfio/Kconfig            |  2 +-
 drivers/vfio/vfio_iommu_type1.c | 22 ++++++++++++++++++----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
index 26b3d9d..bd50721 100644
--- a/drivers/vfio/Kconfig
+++ b/drivers/vfio/Kconfig
@@ -11,7 +11,7 @@ config VFIO_IOMMU_SPAPR_TCE
 menuconfig VFIO
 	tristate "VFIO Non-Privileged userspace driver framework"
 	depends on IOMMU_API
-	select VFIO_IOMMU_TYPE1 if X86
+	select VFIO_IOMMU_TYPE1 if X86 || ARM
 	select VFIO_IOMMU_SPAPR_TCE if (PPC_POWERNV || PPC_PSERIES)
 	help
 	  VFIO provides a framework for secure userspace device drivers.
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index ad7a1f6..81e65f4 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -30,7 +30,8 @@
 #include <linux/iommu.h>
 #include <linux/module.h>
 #include <linux/mm.h>
-#include <linux/pci.h>		/* pci_bus_type */
+#include <linux/pci.h>			/* pci_bus_type */
+#include <linux/platform_device.h>	/* platform_bus_type */
 #include <linux/rbtree.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
@@ -47,6 +48,8 @@ module_param_named(allow_unsafe_interrupts,
 		   allow_unsafe_interrupts, bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(allow_unsafe_interrupts,
 		 "Enable VFIO IOMMU support for on platforms without interrupt remapping support.");
+static struct bus_type *iommu_bus_type = NULL;
+static bool require_cap_intr_remap = false;
 
 static bool disable_hugepages;
 module_param_named(disable_hugepages,
@@ -785,7 +788,8 @@ static void *vfio_iommu_type1_open(unsigned long arg)
 	/*
 	 * Wish we didn't have to know about bus_type here.
 	 */
-	iommu->domain = iommu_domain_alloc(&pci_bus_type);
+	iommu->domain = iommu_domain_alloc(iommu_bus_type);
+
 	if (!iommu->domain) {
 		kfree(iommu);
 		return ERR_PTR(-EIO);
@@ -797,7 +801,7 @@ static void *vfio_iommu_type1_open(unsigned long arg)
 	 * the way.  Fortunately we know interrupt remapping is global for
 	 * our iommus.
 	 */
-	if (!allow_unsafe_interrupts &&
+	if (require_cap_intr_remap && !allow_unsafe_interrupts &&
 	    !iommu_domain_has_cap(iommu->domain, IOMMU_CAP_INTR_REMAP)) {
 		pr_warn("%s: No interrupt remapping support.  Use the module param \"allow_unsafe_interrupts\" to enable VFIO IOMMU support on this platform\n",
 		       __func__);
@@ -914,7 +918,17 @@ static const struct vfio_iommu_driver_ops vfio_iommu_driver_ops_type1 = {
 
 static int __init vfio_iommu_type1_init(void)
 {
-	if (!iommu_present(&pci_bus_type))
+#ifdef CONFIG_PCI
+	if (iommu_present(&pci_bus_type)) {
+		iommu_bus_type = &pci_bus_type;
+		/* For PCI targets, IOMMU_CAP_INTR_REMAP is required */
+		require_cap_intr_remap = true;
+	}
+#endif
+	if (!iommu_bus_type && iommu_present(&platform_bus_type))
+		iommu_bus_type = &platform_bus_type;
+
+	if(!iommu_bus_type)
 		return -ENODEV;
 
 	return vfio_register_iommu_driver(&vfio_iommu_driver_ops_type1);
-- 
1.8.3.2
