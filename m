Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C306AD302
	for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 09:45:03 +0000 (UTC)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.53])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RQjr70s2pz1GDTj;
	Wed, 16 Aug 2023 17:43:35 +0800 (CST)
Received: from huawei.com (10.50.163.32) by kwepemm600005.china.huawei.com
 (7.193.23.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 16 Aug
 2023 17:44:54 +0800
From: liulongfang <liulongfang@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
CC: <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<liulongfang@huawei.com>
Subject: [PATCH v13 1/4] vfio/migration: Add debugfs to live migration driver
Date: Wed, 16 Aug 2023 17:42:02 +0800
Message-ID: <20230816094205.37389-2-liulongfang@huawei.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20230816094205.37389-1-liulongfang@huawei.com>
References: <20230816094205.37389-1-liulongfang@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected

From: Longfang Liu <liulongfang@huawei.com>

There are multiple devices, software and operational steps involved
in the process of live migration. An error occurred on any node may
cause the live migration operation to fail.
This complex process makes it very difficult to locate and analyze
the cause when the function fails.

In order to quickly locate the cause of the problem when the
live migration fails, I added a set of debugfs to the vfio
live migration driver.

    +-------------------------------------------+
    |                                           |
    |                                           |
    |                  QEMU                     |
    |                                           |
    |                                           |
    +---+----------------------------+----------+
        |      ^                     |      ^
        |      |                     |      |
        |      |                     |      |
        v      |                     v      |
     +---------+--+               +---------+--+
     |src vfio_dev|               |dst vfio_dev|
     +--+---------+               +--+---------+
        |      ^                     |      ^
        |      |                     |      |
        v      |                     |      |
   +-----------+----+           +-----------+----+
   |src dev debugfs |           |dst dev debugfs |
   +----------------+           +----------------+

The entire debugfs directory will be based on the definition of
the CONFIG_DEBUG_FS macro. If this macro is not enabled, the
interfaces in vfio.h will be empty definitions, and the creation
and initialization of the debugfs directory will not be executed.

   vfio
    |
    +---<dev_name1>
    |    +---migration
    |        +--state
    |        +--hisi_acc
    |            +--attr
    |            +--data
    |            +--save
    |            +--io_state
    |
    +---<dev_name2>
         +---migration
             +--state
             +--hisi_acc
                 +--attr
                 +--data
                 +--save
                 +--io_state

debugfs will create a public root directory "vfio" file.
then create a dev_name() file for each live migration device.
First, create a unified state acquisition file of "migration"
in this device directory.
Then, create a public live migration state lookup file "state"
Finally, create a directory file based on the device type,
and then create the device's own debugging files under
this directory file.

Here, HiSilicon accelerator creates three debug files:
attr: used to export the attribute parameters of the
current live migration device.
data: used to export the live migration data of the current
live migration device.
save: used to read the current live migration device's data
and save it to the driver.
io_test: used to test the IO read and write for the driver.

The live migration function of the current device can be tested by
operating the debug files, and the functional status of the equipment
and software at each stage can be tested step by step without
performing the complete live migration function. And after the live
migration is performed, the migration device data of the live migration
can be obtained through the debug files.

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/vfio/Makefile       |  1 +
 drivers/vfio/vfio.h         | 14 +++++++
 drivers/vfio/vfio_debugfs.c | 80 +++++++++++++++++++++++++++++++++++++
 drivers/vfio/vfio_main.c    |  5 ++-
 include/linux/vfio.h        |  7 ++++
 5 files changed, 106 insertions(+), 1 deletion(-)
 create mode 100644 drivers/vfio/vfio_debugfs.c

diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile
index c82ea032d352..7934ac829989 100644
--- a/drivers/vfio/Makefile
+++ b/drivers/vfio/Makefile
@@ -8,6 +8,7 @@ vfio-$(CONFIG_VFIO_GROUP) += group.o
 vfio-$(CONFIG_IOMMUFD) += iommufd.o
 vfio-$(CONFIG_VFIO_CONTAINER) += container.o
 vfio-$(CONFIG_VFIO_VIRQFD) += virqfd.o
+vfio-$(CONFIG_DEBUG_FS) += vfio_debugfs.o
 
 obj-$(CONFIG_VFIO_IOMMU_TYPE1) += vfio_iommu_type1.o
 obj-$(CONFIG_VFIO_IOMMU_SPAPR_TCE) += vfio_iommu_spapr_tce.o
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index 307e3f29b527..09b00757d0bb 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -448,4 +448,18 @@ static inline void vfio_device_put_kvm(struct vfio_device *device)
 }
 #endif
 
+#ifdef CONFIG_DEBUG_FS
+void vfio_debugfs_create_root(void);
+void vfio_debugfs_remove_root(void);
+
+void vfio_device_debugfs_init(struct vfio_device *vdev);
+void vfio_device_debugfs_exit(struct vfio_device *vdev);
+#else
+static inline void vfio_debugfs_create_root(void) { }
+static inline void vfio_debugfs_remove_root(void) { }
+
+static inline void vfio_device_debugfs_init(struct vfio_device *vdev) { }
+static inline void vfio_device_debugfs_exit(struct vfio_device *vdev) { }
+#endif /* CONFIG_DEBUG_FS */
+
 #endif
diff --git a/drivers/vfio/vfio_debugfs.c b/drivers/vfio/vfio_debugfs.c
new file mode 100644
index 000000000000..d903293ed9c7
--- /dev/null
+++ b/drivers/vfio/vfio_debugfs.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023, HiSilicon Ltd.
+ */
+
+#include <linux/device.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include <linux/vfio.h>
+#include "vfio.h"
+
+static struct dentry *vfio_debugfs_root;
+
+static int vfio_device_state_read(struct seq_file *seq, void *data)
+{
+	struct device *vf_dev = seq->private;
+	struct vfio_device *vdev = container_of(vf_dev, struct vfio_device, device);
+	enum vfio_device_mig_state state;
+	int ret;
+
+	ret = vdev->mig_ops->migration_get_state(vdev, &state);
+	if (ret)
+		return -EINVAL;
+
+	switch (state) {
+	case VFIO_DEVICE_STATE_RUNNING:
+		seq_printf(seq, "%s\n", "RUNNING");
+		break;
+	case VFIO_DEVICE_STATE_STOP_COPY:
+		seq_printf(seq, "%s\n", "STOP_COPY");
+		break;
+	case VFIO_DEVICE_STATE_STOP:
+		seq_printf(seq, "%s\n", "STOP");
+		break;
+	case VFIO_DEVICE_STATE_RESUMING:
+		seq_printf(seq, "%s\n", "RESUMING");
+		break;
+	case VFIO_DEVICE_STATE_RUNNING_P2P:
+		seq_printf(seq, "%s\n", "RESUMING_P2P");
+		break;
+	case VFIO_DEVICE_STATE_ERROR:
+		seq_printf(seq, "%s\n", "ERROR");
+		break;
+	default:
+		seq_printf(seq, "%s\n", "Invalid");
+	}
+
+	return 0;
+}
+
+void vfio_device_debugfs_init(struct vfio_device *vdev)
+{
+	struct dentry *vfio_dev_migration = NULL;
+	struct device *dev = &vdev->device;
+
+	vdev->debug_root = debugfs_create_dir(dev_name(vdev->dev), vfio_debugfs_root);
+
+	if (vdev->mig_ops) {
+		vfio_dev_migration = debugfs_create_dir("migration", vdev->debug_root);
+		debugfs_create_devm_seqfile(dev, "state", vfio_dev_migration,
+					  vfio_device_state_read);
+	}
+}
+
+void vfio_device_debugfs_exit(struct vfio_device *vdev)
+{
+	debugfs_remove_recursive(vdev->debug_root);
+}
+
+void vfio_debugfs_create_root(void)
+{
+	vfio_debugfs_root = debugfs_create_dir("vfio", NULL);
+}
+
+void vfio_debugfs_remove_root(void)
+{
+	debugfs_remove_recursive(vfio_debugfs_root);
+	vfio_debugfs_root = NULL;
+}
+
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 902f06e52c48..7f88532d0476 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -309,7 +309,7 @@ static int __vfio_register_dev(struct vfio_device *device,
 
 	/* Refcounting can't start until the driver calls register */
 	refcount_set(&device->refcount, 1);
-
+	vfio_device_debugfs_init(device);
 	vfio_device_group_register(device);
 
 	return 0;
@@ -378,6 +378,7 @@ void vfio_unregister_group_dev(struct vfio_device *device)
 		}
 	}
 
+	vfio_device_debugfs_exit(device);
 	/* Balances vfio_device_set_group in register path */
 	vfio_device_remove_group(device);
 }
@@ -1609,6 +1610,7 @@ static int __init vfio_init(void)
 	if (ret)
 		goto err_alloc_dev_chrdev;
 
+	vfio_debugfs_create_root();
 	pr_info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
 	return 0;
 
@@ -1631,6 +1633,7 @@ static void __exit vfio_cleanup(void)
 	vfio_virqfd_exit();
 	vfio_group_cleanup();
 	xa_destroy(&vfio_device_set_xa);
+	vfio_debugfs_remove_root();
 }
 
 module_init(vfio_init);
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 5a1dee983f17..10cd84a3e31c 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -69,6 +69,13 @@ struct vfio_device {
 	u8 iommufd_attached:1;
 #endif
 	u8 cdev_opened:1;
+#ifdef CONFIG_DEBUG_FS
+	/*
+	 * debug_root is a static property of the vfio_device
+	 * which must be set prior to registering the vfio_device.
+	 */
+	struct dentry *debug_root;
+#endif
 };
 
 /**
-- 
2.24.0

