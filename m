From: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v5 1/2] iommu - Enable debugfs exposure of IOMMU driver
	internals
Date: Mon, 07 May 2018 15:02:03 -0500
Message-ID: <152572332370.3235.16541462864315443906.stgit@sosxen2.amd.com>
References: <152572281179.3235.11484188869064303333.stgit@sosxen2.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <152572281179.3235.11484188869064303333.stgit-tq90VzyE+wXkLsZ8J5Uweg@public.gmane.org>
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
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Provide base enablement for using debugfs to expose internal data of an
IOMMU driver. When called, create the /sys/kernel/debug/iommu directory.

Emit a strong warning at boot time to indicate that this feature is
enabled.

This function is called from iommu_init, and creates the initial DebugFS
directory. Drivers may then call iommu_debugfs_new_driver_dir() to
instantiate a device-specific directory to expose internal data.
It will return a pointer to the new dentry structure created in
/sys/kernel/debug/iommu, or NULL in the event of a failure.

Since the IOMMU driver can not be removed from the running system, there
is no need for an "off" function.

Signed-off-by: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/Kconfig         |   11 +++++++
 drivers/iommu/Makefile        |    1 +
 drivers/iommu/iommu-debugfs.c |   64 +++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c         |    2 +
 include/linux/iommu.h         |    8 +++++
 5 files changed, 86 insertions(+)
 create mode 100644 drivers/iommu/iommu-debugfs.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index f3a21343e636..ff511fa8ca7d 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -60,6 +60,17 @@ config IOMMU_IO_PGTABLE_ARMV7S_SELFTEST
 
 endmenu
 
+config IOMMU_DEBUGFS
+	bool "Export IOMMU internals in DebugFS"
+	depends on DEBUG_FS
+	default n
+	help
+	  Allows exposure of IOMMU device internals. This option enables
+	  the use of debugfs by IOMMU drivers as required. Devices can,
+	  at initialization time, cause the IOMMU code to create a top-level
+	  debug/iommu directory, and then populate a subdirectory with
+	  entries as required.
+
 config IOMMU_IOVA
 	tristate
 
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 1fb695854809..74cfbc392862 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_IOMMU_API) += iommu.o
 obj-$(CONFIG_IOMMU_API) += iommu-traces.o
 obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
+obj-$(CONFIG_IOMMU_DEBUGFS) += iommu-debugfs.o
 obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
diff --git a/drivers/iommu/iommu-debugfs.c b/drivers/iommu/iommu-debugfs.c
new file mode 100644
index 000000000000..d82a10b2478b
--- /dev/null
+++ b/drivers/iommu/iommu-debugfs.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IOMMU driver
+ *
+ * Copyright (C) 2018 Advanced Micro Devices, Inc.
+ *
+ * Author: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
+ */
+
+#include <linux/pci.h>
+#include <linux/iommu.h>
+#include <linux/debugfs.h>
+
+static struct dentry *iommu_debugfs_dir;
+
+/*
+ * Provide base enablement for using debugfs to expose internal data of an
+ * IOMMU driver. When called, create the /sys/kernel/debug/iommu directory.
+ *
+ * Emit a strong warning at boot time to indicate that this feature is
+ * enabled.
+ *
+ * This function is called from iommu_init, and creates the initial DebugFS
+ * directory. Drivers may then call iommu_debugfs_new_driver_dir() to
+ * instantiate a device-specific directory to expose internal data.
+ * It will return a pointer to the new dentry structure created in
+ * /sys/kernel/debug/iommu, or NULL in the event of a failure.
+ *
+ * Since the IOMMU driver can not be removed from the running system, there
+ * is no need for an "off" function.
+ */
+void iommu_debugfs_setup(void)
+{
+	if (!iommu_debugfs_dir) {
+		iommu_debugfs_dir = debugfs_create_dir("iommu", NULL);
+		if (iommu_debugfs_dir) {
+			pr_warn("\n");
+			pr_warn("*************************************************************\n");
+			pr_warn("**     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **\n");
+			pr_warn("**                                                         **\n");
+			pr_warn("**  IOMMU DebugFS SUPPORT HAS BEEN ENABLED IN THIS KERNEL  **\n");
+			pr_warn("**                                                         **\n");
+			pr_warn("** This means that this kernel is built to expose internal **\n");
+			pr_warn("** IOMMU data structures, which may compromise security on **\n");
+			pr_warn("** your system.                                            **\n");
+			pr_warn("**                                                         **\n");
+			pr_warn("** If you see this message and you are not debugging the   **\n");
+			pr_warn("** kernel, report this immediately to your vendor!         **\n");
+			pr_warn("**                                                         **\n");
+			pr_warn("**     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **\n");
+			pr_warn("*************************************************************\n");
+		}
+	}
+}
+
+struct dentry *iommu_debugfs_new_driver_dir(char *name)
+{
+	struct dentry *d_new;
+
+	d_new = debugfs_create_dir(name, iommu_debugfs_dir);
+
+	return d_new;
+}
+EXPORT_SYMBOL_GPL(iommu_debugfs_new_driver_dir);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d2aa23202bb9..350819f1c5e1 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1747,6 +1747,8 @@ static int __init iommu_init(void)
 					       NULL, kernel_kobj);
 	BUG_ON(!iommu_group_kset);
 
+	iommu_debugfs_setup();
+
 	return 0;
 }
 core_initcall(iommu_init);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 19938ee6eb31..6bdfe942068b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -698,4 +698,12 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 
 #endif /* CONFIG_IOMMU_API */
 
+#ifdef CONFIG_IOMMU_DEBUGFS
+void iommu_debugfs_setup(void);
+struct dentry *iommu_debugfs_new_driver_dir(char *);
+#else
+static inline void iommu_debugfs_setup(void) {}
+struct dentry *iommu_debugfs_new_driver_dir(char *) {};
+#endif
+
 #endif /* __LINUX_IOMMU_H */
