From: Gary R Hook <gary.hook@amd.com>
Subject: [PATCH v9 1/2] iommu - Enable debugfs exposure of IOMMU driver
 internals
Date: Tue, 12 Jun 2018 16:41:21 -0500
Message-ID: <152883968097.1936.10168344980897538230.stgit@taos>
References: <152883965482.1936.13657625103232933481.stgit@taos>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <152883965482.1936.13657625103232933481.stgit@taos>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
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

Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 drivers/iommu/Kconfig         |   10 ++++++
 drivers/iommu/Makefile        |    1 +
 drivers/iommu/iommu-debugfs.c |   66 +++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c         |    2 +
 include/linux/iommu.h         |    7 ++++
 5 files changed, 86 insertions(+)
 create mode 100644 drivers/iommu/iommu-debugfs.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index c76157e57f6b..f9af25ac409f 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -60,6 +60,16 @@ config IOMMU_IO_PGTABLE_ARMV7S_SELFTEST
 
 endmenu
 
+config IOMMU_DEBUGFS
+	bool "Export IOMMU internals in DebugFS"
+	depends on DEBUG_FS
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
index 000000000000..3b1bf88fd1b0
--- /dev/null
+++ b/drivers/iommu/iommu-debugfs.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IOMMU debugfs core infrastructure
+ *
+ * Copyright (C) 2018 Advanced Micro Devices, Inc.
+ *
+ * Author: Gary R Hook <gary.hook@amd.com>
+ */
+
+#include <linux/pci.h>
+#include <linux/iommu.h>
+#include <linux/debugfs.h>
+
+struct dentry *iommu_debugfs_dir;
+
+/**
+ * iommu_debugfs_setup - create the top-level iommu directory in debugfs
+ *
+ * Provide base enablement for using debugfs to expose internal data of an
+ * IOMMU driver. When called, this function creates the
+ * /sys/kernel/debug/iommu directory.
+ *
+ * Emit a strong warning at boot time to indicate that this feature is
+ * enabled.
+ *
+ * This function is called from iommu_init; drivers may then call
+ * iommu_debugfs_new_driver_dir() to instantiate a vendor-specific
+ * directory to be used to expose internal data.
+ */
+void iommu_debugfs_setup(void)
+{
+	if (!iommu_debugfs_dir) {
+		iommu_debugfs_dir = debugfs_create_dir("iommu", NULL);
+		pr_warn("\n");
+		pr_warn("*************************************************************\n");
+		pr_warn("**     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **\n");
+		pr_warn("**                                                         **\n");
+		pr_warn("**  IOMMU DebugFS SUPPORT HAS BEEN ENABLED IN THIS KERNEL  **\n");
+		pr_warn("**                                                         **\n");
+		pr_warn("** This means that this kernel is built to expose internal **\n");
+		pr_warn("** IOMMU data structures, which may compromise security on **\n");
+		pr_warn("** your system.                                            **\n");
+		pr_warn("**                                                         **\n");
+		pr_warn("** If you see this message and you are not debugging the   **\n");
+		pr_warn("** kernel, report this immediately to your vendor!         **\n");
+		pr_warn("**                                                         **\n");
+		pr_warn("**     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **\n");
+		pr_warn("*************************************************************\n");
+	}
+}
+
+/**
+ * iommu_debugfs_new_driver_dir - create a vendor directory under debugfs/iommu
+ * @vendor: name of the vendor-specific subdirectory to create
+ *
+ * This function is called by an IOMMU driver to create the top-level debugfs
+ * directory for that driver.
+ *
+ * Return: upon success, a pointer to the dentry for the new directory.
+ *         NULL in case of failure.
+ */
+struct dentry *iommu_debugfs_new_driver_dir(const char *vendor)
+{
+	return debugfs_create_dir(vendor, iommu_debugfs_dir);
+}
+EXPORT_SYMBOL_GPL(iommu_debugfs_new_driver_dir);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 63b37563db7e..d227b864a109 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1748,6 +1748,8 @@ static int __init iommu_init(void)
 					       NULL, kernel_kobj);
 	BUG_ON(!iommu_group_kset);
 
+	iommu_debugfs_setup();
+
 	return 0;
 }
 core_initcall(iommu_init);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 19938ee6eb31..7447b0b0579a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -698,4 +698,11 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 
 #endif /* CONFIG_IOMMU_API */
 
+#ifdef CONFIG_IOMMU_DEBUGFS
+extern	struct dentry *iommu_debugfs_dir;
+void iommu_debugfs_setup(void);
+#else
+static inline void iommu_debugfs_setup(void) {}
+#endif
+
 #endif /* __LINUX_IOMMU_H */
