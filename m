From: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v3 1/5] iommu/amd - Add debugfs support
Date: Wed, 14 Mar 2018 18:04:55 -0500
Message-ID: <152106869537.67212.11927240111825397411.stgit@sosxen2.amd.com>
References: <152106836233.67212.15861879210675477690.stgit@sosxen2.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <152106836233.67212.15861879210675477690.stgit-tq90VzyE+wXkLsZ8J5Uweg@public.gmane.org>
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

Expose the IOMMU MMIO registers and device table

Signed-off-by: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/Kconfig             |    7 ++
 drivers/iommu/Makefile            |    1 
 drivers/iommu/amd_iommu_debugfs.c |  122 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/amd_iommu_init.c    |    6 +-
 drivers/iommu/amd_iommu_proto.h   |    7 ++
 drivers/iommu/amd_iommu_types.h   |    3 +
 6 files changed, 144 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/amd_iommu_debugfs.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index f3a21343e636..8b2a5b8707c6 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -135,6 +135,13 @@ config AMD_IOMMU_V2
 	  hardware. Select this option if you want to use devices that support
 	  the PCI PRI and PASID interface.
 
+config AMD_IOMMU_DEBUG
+	bool "Expose AMD IOMMU internals in DebugFS"
+	depends on AMD_IOMMU && DEBUG_FS
+	help
+	  Provides debugfs access to IOMMU data such as registers and device
+	  table entries.
+
 # Intel IOMMU support
 config DMAR_TABLE
 	bool
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 1fb695854809..64fba8b1ca4f 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_IOMMU_IOVA) += iova.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
 obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
 obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
+obj-$(CONFIG_AMD_IOMMU_DEBUG) += amd_iommu_debugfs.o
 obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
 obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
 obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
diff --git a/drivers/iommu/amd_iommu_debugfs.c b/drivers/iommu/amd_iommu_debugfs.c
new file mode 100644
index 000000000000..4f0f05a89a41
--- /dev/null
+++ b/drivers/iommu/amd_iommu_debugfs.c
@@ -0,0 +1,122 @@
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
+#include <linux/debugfs.h>
+#include <linux/iommu.h>
+#include <linux/pci.h>
+
+#include "amd_iommu_proto.h"
+#include "amd_iommu_types.h"
+
+/* DebugFS helpers
+ *
+ * This is intended to shrink the scnprintf statements used to produce
+ * debugfs output. Each function that uses OSCNPRINTF will need to declare
+ * local variables:
+ *
+ *	unsigned int obuflen = <max size>;
+ *	unsigned int oboff = 0;
+ *	char *obuf;
+ *
+ * wherein obuflen is the expected buffer length needed for the output text.
+ * Every statement then reduces to
+ *	oboff += OSCNPRINTF(<format>[, <arg1>[, ...]]);
+ */
+#define	OBUFP		(obuf + oboff)
+#define	OBUFLEN		obuflen
+#define	OBUFSPC		(OBUFLEN - oboff)
+#define	OSCNPRINTF(fmt, ...) \
+		scnprintf(OBUFP, OBUFSPC, fmt, ## __VA_ARGS__)
+
+static struct dentry *iommu_debugfs_dir;
+static DEFINE_MUTEX(iommu_debugfs_lock);
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
+	for (i = start ; i <= end ; i++) {
+		if ((amd_iommu_dev_table[i].data[0] ^ 0x3)
+		    || amd_iommu_dev_table[i].data[1])
+			n++;
+	}
+	return n;
+}
+
+static ssize_t amd_iommu_debugfs_dtecount_read(struct file *filp,
+					  char __user *ubuf,
+					  size_t count, loff_t *offp)
+{
+	unsigned int obuflen = 64;
+	unsigned int oboff = 0;
+	unsigned int n;
+	ssize_t ret;
+	char *obuf;
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
+
+	if (!debugfs_initialized())
+		return;
+
+	mutex_lock(&iommu_debugfs_lock);
+	if (!iommu_debugfs_dir)
+		iommu_debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
+	mutex_unlock(&iommu_debugfs_lock);
+	if (!iommu_debugfs_dir)
+		goto err;
+
+	snprintf(name, MAX_NAME_LEN, "iommu%02x", iommu->index);
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
index 4e4a615bf13f..a03142fd6179 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -2721,6 +2721,7 @@ int __init amd_iommu_enable_faulting(void)
  */
 static int __init amd_iommu_init(void)
 {
+	struct amd_iommu *iommu;
 	int ret;
 
 	ret = iommu_go_to_state(IOMMU_INITIALIZED);
@@ -2730,14 +2731,15 @@ static int __init amd_iommu_init(void)
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
index 640c286a0ab9..db5872d3d40f 100644
--- a/drivers/iommu/amd_iommu_proto.h
+++ b/drivers/iommu/amd_iommu_proto.h
@@ -33,6 +33,13 @@ extern void amd_iommu_uninit_devices(void);
 extern void amd_iommu_init_notifier(void);
 extern int amd_iommu_init_api(void);
 
+#ifdef	CONFIG_AMD_IOMMU_DEBUG
+extern void amd_iommu_debugfs_setup(struct amd_iommu *iommu);
+#else
+static inline void amd_iommu_debugfs_setup(struct amd_iommu *iommu) {}
+#endif
+
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
