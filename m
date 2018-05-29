From: Gary R Hook <gary.hook@amd.com>
Subject: [PATCH v8 2/2] iommu/amd: Add basic debugfs infrastructure for AMD
 IOMMU
Date: Tue, 29 May 2018 13:23:23 -0500
Message-ID: <152761820371.2654.4551405686504157036.stgit@sosgrh1.amd.com>
References: <152761784341.2654.8609366076331539902.stgit@sosgrh1.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <152761784341.2654.8609366076331539902.stgit@sosgrh1.amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Implement a skeleton framework for debugfs support in the
AMD IOMMU. Add a hidden boolean to Kconfig that is defined
for the AMD IOMMU when general IOMMY DebugFS support is
enabled.

Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 drivers/iommu/Kconfig             |    4 ++++
 drivers/iommu/Makefile            |    1 +
 drivers/iommu/amd_iommu_debugfs.c |   39 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/amd_iommu_init.c    |    6 ++++--
 drivers/iommu/amd_iommu_proto.h   |    6 ++++++
 drivers/iommu/amd_iommu_types.h   |    5 +++++
 6 files changed, 59 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/amd_iommu_debugfs.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index f9af25ac409f..ec223f6f4ad4 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -137,6 +137,10 @@ config AMD_IOMMU
 	  your BIOS for an option to enable it or if you have an IVRS ACPI
 	  table.
 
+config AMD_IOMMU_DEBUGFS
+	def_bool y
+	depends on AMD_IOMMU && IOMMU_DEBUGFS
+
 config AMD_IOMMU_V2
 	tristate "AMD IOMMU Version 2 driver"
 	depends on AMD_IOMMU
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 74cfbc392862..47fd6ea9de2d 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_IOMMU_IOVA) += iova.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
 obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
 obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
+obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += amd_iommu_debugfs.o
 obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
 obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
 obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
diff --git a/drivers/iommu/amd_iommu_debugfs.c b/drivers/iommu/amd_iommu_debugfs.c
new file mode 100644
index 000000000000..6dff98552969
--- /dev/null
+++ b/drivers/iommu/amd_iommu_debugfs.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD IOMMU driver
+ *
+ * Copyright (C) 2018 Advanced Micro Devices, Inc.
+ *
+ * Author: Gary R Hook <gary.hook@amd.com>
+ */
+
+#include <linux/debugfs.h>
+#include <linux/iommu.h>
+#include <linux/pci.h>
+#include "amd_iommu_proto.h"
+#include "amd_iommu_types.h"
+
+static struct dentry *amd_iommu_debugfs;
+static DEFINE_MUTEX(amd_iommu_debugfs_lock);
+
+#define	MAX_NAME_LEN	20
+
+void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
+{
+	char name[MAX_NAME_LEN + 1];
+
+	mutex_lock(&amd_iommu_debugfs_lock);
+	if (!amd_iommu_debugfs)
+		amd_iommu_debugfs = iommu_debugfs_new_driver_dir("amd");
+	mutex_unlock(&amd_iommu_debugfs_lock);
+
+	if (amd_iommu_debugfs) {
+		snprintf(name, MAX_NAME_LEN, "iommu%02d", iommu->index);
+		iommu->debugfs = debugfs_create_dir(name,
+						    amd_iommu_debugfs);
+		if (!iommu->debugfs) {
+			debugfs_remove_recursive(amd_iommu_debugfs);
+			amd_iommu_debugfs = NULL;
+		}
+	}
+}
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 904c575d1677..031e6dbb8345 100644
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
index 640c286a0ab9..a8cd0296fb16 100644
--- a/drivers/iommu/amd_iommu_proto.h
+++ b/drivers/iommu/amd_iommu_proto.h
@@ -33,6 +33,12 @@ extern void amd_iommu_uninit_devices(void);
 extern void amd_iommu_init_notifier(void);
 extern int amd_iommu_init_api(void);
 
+#ifdef CONFIG_AMD_IOMMU_DEBUGFS
+void amd_iommu_debugfs_setup(struct amd_iommu *iommu);
+#else
+static inline void amd_iommu_debugfs_setup(struct amd_iommu *iommu) {}
+#endif
+
 /* Needed for interrupt remapping */
 extern int amd_iommu_prepare(void);
 extern int amd_iommu_enable(void);
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 986cbe0cc189..cfac9d842b0f 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -594,6 +594,11 @@ struct amd_iommu {
 
 	u32 flags;
 	volatile u64 __aligned(8) cmd_sem;
+
+#ifdef CONFIG_AMD_IOMMU_DEBUGFS
+	/* DebugFS Info */
+	struct dentry *debugfs;
+#endif
 };
 
 static inline struct amd_iommu *dev_to_amd_iommu(struct device *dev)
