From: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v4 1/2] iommu - Enable debugfs exposure of the IOMMU
Date: Mon, 30 Apr 2018 14:58:49 -0500
Message-ID: <152511832970.8963.10801049423048266747.stgit@taos>
References: <152511783026.8963.5818249217042882958.stgit@taos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <152511783026.8963.5818249217042882958.stgit@taos>
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

Provide base enablement for using debugfs to expose internal data of
an IOMMU driver. When called, create the /sys/kernel/debug/iommu
directory.  Emit a strong warning at boot time to indicate that this
feature is enabled.

This patch adds a top-level function that will create the (above)
directory, under which a driver may create a hw-specific directory for
its use. The function

	iommu_debugfs_setup()

returns a pointer to the new dentry structure created for
/sys/kernel/debug/iommu, or NULL in the event of a failure. An IOMMU
driver should call this function first, and then create a directory
beneath it. A driver implementation might look something like:

static struct dentry *my_debugfs;

	struct dentry *d_top;
	if (!my_debugfs) {
		d_top = iommu_debugfs_setup();
		if (d_top)
			my_debugfs = debugfs_create_dir("vendor", d_top);
	}

Since the IOMMU driver can not be removed from the running system, this
patch only provides an "on" function.

Signed-off-by: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/Kconfig         |   11 ++++++++
 drivers/iommu/Makefile        |    1 +
 drivers/iommu/iommu-debugfs.c |   55 +++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h         |    4 +++
 4 files changed, 71 insertions(+)
 create mode 100644 drivers/iommu/iommu-debugfs.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index f3a21343e636..81a6c281e69f 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -60,6 +60,17 @@ config IOMMU_IO_PGTABLE_ARMV7S_SELFTEST
 
 endmenu
 
+config IOMMU_DEBUGFS
+	bool "Enable IOMMU internals in DebugFS"
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
index 000000000000..409691ca0ff9
--- /dev/null
+++ b/drivers/iommu/iommu-debugfs.c
@@ -0,0 +1,55 @@
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
+ * This top-level function that will create the (above) directory, under a
+ * driver may create a hw-specific directory for its use. The function
+ *
+ *     iommu_debugfs_setup()
+ *
+ * returns a pointer to the new dentry structure created for
+ * /sys/kernel/debug/iommu, or NULL in the event of a failure. An IOMMU
+ * driver should call this function first, and then create a directory
+ * beneath it. A driver implementation might look something like:
+ *
+ * static struct dentry *my_debugfs;
+ *
+ *    struct dentry *d_top;
+ *    if (!my_debugfs) {
+ *        d_top = iommu_debugfs_setup();
+ *        if (d_top)
+ *            my_debugfs = debugfs_create_dir("vendor", d_top);
+ *    }
+ *
+ * Since the IOMMU driver can not be removed from the running system, there
+ * is no need for an "off" function.
+ */
+struct dentry *iommu_debugfs_setup(void)
+{
+	if (!iommu_debugfs_dir) {
+		iommu_debugfs_dir = debugfs_create_dir("iommu", NULL);
+		if (iommu_debugfs_dir)
+			pr_warn("WARNING: IOMMU DEBUGFS SUPPORT HAS BEEN ENABLED IN THIS KERNEL\n");
+	}
+
+	return iommu_debugfs_dir;
+}
+EXPORT_SYMBOL_GPL(iommu_debugfs_setup);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 19938ee6eb31..e5657c70f90c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -698,4 +698,8 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 
 #endif /* CONFIG_IOMMU_API */
 
+#ifdef CONFIG_IOMMU_DEBUGFS
+struct dentry *iommu_debugfs_setup(void);
+#endif
+
 #endif /* __LINUX_IOMMU_H */
