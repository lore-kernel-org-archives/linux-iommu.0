From: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/5] iommu/amd - Add debugfs support
Date: Fri, 26 Jan 2018 17:52:15 -0600
Message-ID: <151701073560.16448.7715293076458740364.stgit@taos>
References: <151701071164.16448.3611271062222336838.stgit@taos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <151701071164.16448.3611271062222336838.stgit@taos>
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

Create the basic debugfs functions. Expose a count of IOMMU device
table entries that appear to be in use.

Signed-off-by: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/Kconfig             |    9 +++
 drivers/iommu/Makefile            |    2 -
 drivers/iommu/amd_iommu_debugfs.c |  112 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/amd_iommu_init.c    |    7 ++
 drivers/iommu/amd_iommu_proto.h   |    6 ++
 drivers/iommu/amd_iommu_types.h   |    3 +
 6 files changed, 136 insertions(+), 3 deletions(-)
 create mode 100644 drivers/iommu/amd_iommu_debugfs.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index f3a21343e636..7753989b6be7 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -135,6 +135,15 @@ config AMD_IOMMU_V2
 	  hardware. Select this option if you want to use devices that support
 	  the PCI PRI and PASID interface.
 
+config AMD_IOMMU_DEBUG
+	bool "Expose AMD IOMMU internals in DebugFS"
+	depends on AMD_IOMMU && DEBUG_FS
+	default n
+	help
+	  With this option you can enable access to AMD IOMMU registers and
+	  data structures through debugfs. Select this to see information
+	  about the internal state of the device.
+
 # Intel IOMMU support
 config DMAR_TABLE
 	bool
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 1fb695854809..d9e9ed5f6cfc 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -9,7 +9,7 @@ obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
 obj-$(CONFIG_IOMMU_IOVA) += iova.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
 obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
-obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
+obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o amd_iommu_debugfs.o
 obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
 obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
 obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
diff --git a/drivers/iommu/amd_iommu_debugfs.c b/drivers/iommu/amd_iommu_debugfs.c
new file mode 100644
index 000000000000..18f70934961d
--- /dev/null
+++ b/drivers/iommu/amd_iommu_debugfs.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD IOMMU driver
+ *
+ * Copyright (C) 2018 Advanced Micro Devices, Inc.
+ *
+ * Author: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
+ */
+
+#ifdef	CONFIG_DEBUG_FS
+
+#include <linux/pci.h>
+#include <linux/iommu.h>
+#include <linux/debugfs.h>
+#include "amd_iommu_proto.h"
+#include "amd_iommu_types.h"
+
+/* DebugFS helpers */
+#define	OBUFP		(obuf + oboff)
+#define	OBUFLEN		obuflen
+#define	OBUFSPC		(OBUFLEN - oboff)
+#define	OSCNPRINTF(fmt, ...) \
+		scnprintf(OBUFP, OBUFSPC, fmt, ## __VA_ARGS__)
+
+static struct dentry *iommu_debugfs_dir;
+static DEFINE_RWLOCK(iommu_debugfs_lock);
+
+#define	MAX_NAME_LEN	20
+
+static unsigned int amd_iommu_count_valid_dtes(int start, int end)
+{
+	unsigned int n = 0;
+	int i;
+
+	/* Scan the DTE table from entry 'start' through entry 'end' for
+	 * active entries
+	 */
+	for (i = start ; i <= end ; i++)
+		if ((amd_iommu_dev_table[i].data[0] ^ 0x3)
+		     || amd_iommu_dev_table[i].data[1])
+			n++;
+	return n;
+}
+
+static ssize_t amd_iommu_debugfs_dtecount_read(struct file *filp,
+					       char __user *ubuf,
+					       size_t count, loff_t *offp)
+{
+	struct amd_iommu *iommu = filp->private_data;
+	unsigned int obuflen = 512;
+	unsigned int oboff = 0;
+	unsigned int n;
+	ssize_t ret;
+	char *obuf;
+
+	if (!iommu)
+		return 0;
+
+	obuf = kmalloc(OBUFLEN, GFP_KERNEL);
+	if (!obuf)
+		return -ENOMEM;
+
+	n = amd_iommu_count_valid_dtes(0, 0xFFFF);
+	oboff += OSCNPRINTF("%d\n", n);
+
+	ret = simple_read_from_buffer(ubuf, count, offp, obuf, oboff);
+	kfree(obuf);
+
+	return ret;
+}
+
+static const struct file_operations amd_iommu_debugfs_dtecount_ops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = amd_iommu_debugfs_dtecount_read,
+	.write = NULL,
+};
+
+void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
+{
+	char name[MAX_NAME_LEN + 1];
+	struct dentry *d_dte;
+	unsigned long flags;
+
+	if (!debugfs_initialized())
+		return;
+
+	write_lock_irqsave(&iommu_debugfs_lock, flags);
+	if (!iommu_debugfs_dir)
+		iommu_debugfs_dir = debugfs_create_dir("amd-iommu", NULL);
+	write_unlock_irqrestore(&iommu_debugfs_lock, flags);
+	if (!iommu_debugfs_dir)
+		goto err;
+
+	snprintf(name, MAX_NAME_LEN, "iommu%02d", iommu->index);
+	iommu->debugfs_instance = debugfs_create_dir(name, iommu_debugfs_dir);
+	if (!iommu->debugfs_instance)
+		goto err;
+
+	d_dte = debugfs_create_file("count", 0400,
+				    iommu->debugfs_instance, iommu,
+				    &amd_iommu_debugfs_dtecount_ops);
+	if (!d_dte)
+		goto err;
+
+	return;
+
+err:
+	debugfs_remove_recursive(iommu->debugfs_instance);
+}
+
+#endif
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 6fe2d0346073..43856c7f4ea1 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -89,6 +89,7 @@
 #define ACPI_DEVFLAG_ATSDIS             0x10000000
 
 #define LOOP_TIMEOUT	100000
+
 /*
  * ACPI table definitions
  *
@@ -2720,6 +2721,7 @@ int __init amd_iommu_enable_faulting(void)
  */
 static int __init amd_iommu_init(void)
 {
+	struct amd_iommu *iommu;
 	int ret;
 
 	ret = iommu_go_to_state(IOMMU_INITIALIZED);
@@ -2729,14 +2731,15 @@ static int __init amd_iommu_init(void)
 			disable_iommus();
 			free_iommu_resources();
 		} else {
-			struct amd_iommu *iommu;
-
 			uninit_device_table_dma();
 			for_each_iommu(iommu)
 				iommu_flush_all_caches(iommu);
 		}
 	}
 
+	for_each_iommu(iommu)
+		amd_iommu_debugfs_setup(iommu);
+
 	return ret;
 }
 
diff --git a/drivers/iommu/amd_iommu_proto.h b/drivers/iommu/amd_iommu_proto.h
index 640c286a0ab9..f2a978dbcff7 100644
--- a/drivers/iommu/amd_iommu_proto.h
+++ b/drivers/iommu/amd_iommu_proto.h
@@ -33,6 +33,12 @@ extern void amd_iommu_uninit_devices(void);
 extern void amd_iommu_init_notifier(void);
 extern int amd_iommu_init_api(void);
 
+#ifdef	CONFIG_DEBUG_FS
+extern void amd_iommu_debugfs_setup(struct amd_iommu *iommu);
+#else
+static inline void amd_iommu_debugfs_setup(struct amd_iommu *iommu) {}
+#endif
+
 /* Needed for interrupt remapping */
 extern int amd_iommu_prepare(void);
 extern int amd_iommu_enable(void);
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 6a877ebd058b..43c008dc7ade 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -593,6 +593,9 @@ struct amd_iommu {
 
 	u32 flags;
 	volatile u64 __aligned(8) cmd_sem;
+
+	/* DebugFS Info */
+	struct dentry *debugfs_instance;
 };
 
 static inline struct amd_iommu *dev_to_amd_iommu(struct device *dev)
