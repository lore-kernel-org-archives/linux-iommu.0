Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240E9D302
	for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 09:45:58 +0000 (UTC)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RQjph2zCPztRny;
	Wed, 16 Aug 2023 17:42:20 +0800 (CST)
Received: from huawei.com (10.50.163.32) by kwepemm600005.china.huawei.com
 (7.193.23.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 16 Aug
 2023 17:45:56 +0800
From: liulongfang <liulongfang@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
CC: <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<liulongfang@huawei.com>
Subject: [PATCH v13 3/4] hisi_acc_vfio_pci: register debugfs for hisilicon migration driver
Date: Wed, 16 Aug 2023 17:42:04 +0800
Message-ID: <20230816094205.37389-4-liulongfang@huawei.com>
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
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected

From: Longfang Liu <liulongfang@huawei.com>

On the debugfs framework of VFIO, if the CONFIG_DEBUG_FS macro is
enabled, the debug function is registered for the live migration driver
of the HiSilicon accelerator device.

After registering the HiSilicon accelerator device on the debugfs
framework of live migration of vfio, a directory file "hisi_acc"
of debugfs is created, and then three debug function files are
created in this directory:

data file: used to get the migration data from the driver
attr file: used to get device attributes parameters from the driver
save file: used to read the data of the live migration device and save
it to the driver.
io_state: used to get the IO read and write state for the driver.

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 194 ++++++++++++++++++
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.h    |   3 +
 2 files changed, 197 insertions(+)

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index 242ad319932a..83db5ce68289 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -15,6 +15,7 @@
 #include <linux/anon_inodes.h>
 
 #include "hisi_acc_vfio_pci.h"
+#include "../../vfio.h"
 
 /* Return 0 on VM acc device ready, -ETIMEDOUT hardware timeout */
 static int qm_wait_dev_not_ready(struct hisi_qm *qm)
@@ -606,6 +607,18 @@ hisi_acc_check_int_state(struct hisi_acc_vf_core_device *hisi_acc_vdev)
 	}
 }
 
+static void hisi_acc_vf_migf_save(struct hisi_acc_vf_migration_file *dst_migf,
+	struct hisi_acc_vf_migration_file *src_migf)
+{
+	if (!dst_migf)
+		return;
+
+	dst_migf->disabled = false;
+	dst_migf->total_length = src_migf->total_length;
+	memcpy(&dst_migf->vf_data, &src_migf->vf_data,
+		    sizeof(struct acc_vf_data));
+}
+
 static void hisi_acc_vf_disable_fd(struct hisi_acc_vf_migration_file *migf)
 {
 	mutex_lock(&migf->lock);
@@ -618,12 +631,16 @@ static void hisi_acc_vf_disable_fd(struct hisi_acc_vf_migration_file *migf)
 static void hisi_acc_vf_disable_fds(struct hisi_acc_vf_core_device *hisi_acc_vdev)
 {
 	if (hisi_acc_vdev->resuming_migf) {
+		hisi_acc_vf_migf_save(hisi_acc_vdev->debug_migf,
+						hisi_acc_vdev->resuming_migf);
 		hisi_acc_vf_disable_fd(hisi_acc_vdev->resuming_migf);
 		fput(hisi_acc_vdev->resuming_migf->filp);
 		hisi_acc_vdev->resuming_migf = NULL;
 	}
 
 	if (hisi_acc_vdev->saving_migf) {
+		hisi_acc_vf_migf_save(hisi_acc_vdev->debug_migf,
+						hisi_acc_vdev->saving_migf);
 		hisi_acc_vf_disable_fd(hisi_acc_vdev->saving_migf);
 		fput(hisi_acc_vdev->saving_migf->filp);
 		hisi_acc_vdev->saving_migf = NULL;
@@ -1303,6 +1320,176 @@ static long hisi_acc_vfio_pci_ioctl(struct vfio_device *core_vdev, unsigned int
 	return vfio_pci_core_ioctl(core_vdev, cmd, arg);
 }
 
+static int hisi_acc_vf_debug_check(struct seq_file *seq, struct vfio_device *vdev)
+{
+	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
+	struct hisi_acc_vf_migration_file *migf = hisi_acc_vdev->debug_migf;
+
+	if (!vdev->mig_ops || !migf) {
+		seq_printf(seq, "%s\n", "device does not support live migration!");
+		return -EINVAL;
+	}
+
+	/**
+	 * When the device is not opened, the io_base is not mapped.
+	 * The driver cannot perform device read and write operations.
+	 * The lock of device.igate is used here to ensure mutual exclusion.
+	 */
+	if (!vdev->open_count) {
+		seq_printf(seq, "%s\n", "device not opened!");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int hisi_acc_vf_debug_io(struct seq_file *seq, void *data)
+{
+	struct device *vf_dev = seq->private;
+	struct vfio_pci_core_device *core_device = dev_get_drvdata(vf_dev);
+	struct vfio_device *vdev = &core_device->vdev;
+	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
+	struct hisi_qm *vf_qm = &hisi_acc_vdev->vf_qm;
+	u64 value;
+	int ret;
+
+	mutex_lock(&hisi_acc_vdev->core_device.igate);
+	ret = hisi_acc_vf_debug_check(seq, vdev);
+	if (ret) {
+		mutex_unlock(&hisi_acc_vdev->core_device.igate);
+		return 0;
+	}
+
+	ret = qm_wait_dev_not_ready(vf_qm);
+	if (ret) {
+		mutex_unlock(&hisi_acc_vdev->core_device.igate);
+		seq_printf(seq, "%s\n", "VF device not ready!");
+		return 0;
+	}
+
+	value = readl(vf_qm->io_base + QM_MB_CMD_SEND_BASE);
+	mutex_unlock(&hisi_acc_vdev->core_device.igate);
+	seq_printf(seq, "%s:0x%llx\n", "debug mailbox val", value);
+
+	return 0;
+}
+
+static int hisi_acc_vf_debug_save(struct seq_file *seq, void *data)
+{
+	struct device *vf_dev = seq->private;
+	struct vfio_pci_core_device *core_device = dev_get_drvdata(vf_dev);
+	struct vfio_device *vdev = &core_device->vdev;
+	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
+	struct hisi_acc_vf_migration_file *migf = hisi_acc_vdev->debug_migf;
+	int ret;
+
+	mutex_lock(&hisi_acc_vdev->core_device.igate);
+	ret = hisi_acc_vf_debug_check(seq, vdev);
+	if (ret) {
+		mutex_unlock(&hisi_acc_vdev->core_device.igate);
+		return 0;
+	}
+
+	ret = vf_qm_state_save(hisi_acc_vdev, migf);
+	mutex_unlock(&hisi_acc_vdev->core_device.igate);
+	if (ret) {
+		seq_printf(seq, "%s\n", "failed to save device data!");
+		return 0;
+	}
+	seq_printf(seq, "%s\n", "successful to save device data!");
+
+	return 0;
+}
+
+static int hisi_acc_vf_data_read(struct seq_file *seq, void *data)
+{
+	struct device *vf_dev = seq->private;
+	struct vfio_pci_core_device *core_device = dev_get_drvdata(vf_dev);
+	struct vfio_device *vdev = &core_device->vdev;
+	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
+	struct hisi_acc_vf_migration_file *debug_migf = hisi_acc_vdev->debug_migf;
+	size_t vf_data_sz = offsetofend(struct acc_vf_data, padding);
+
+	if (debug_migf && debug_migf->total_length)
+		seq_hex_dump(seq, "Mig Data:", DUMP_PREFIX_OFFSET, 16, 1,
+				(unsigned char *)&debug_migf->vf_data,
+				vf_data_sz, false);
+	else
+		seq_printf(seq, "%s\n", "device not migrated!");
+
+	return 0;
+}
+
+static int hisi_acc_vf_attr_read(struct seq_file *seq, void *data)
+{
+	struct device *vf_dev = seq->private;
+	struct vfio_pci_core_device *core_device = dev_get_drvdata(vf_dev);
+	struct vfio_device *vdev = &core_device->vdev;
+	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
+	struct hisi_acc_vf_migration_file *debug_migf = hisi_acc_vdev->debug_migf;
+
+	if (debug_migf && debug_migf->total_length) {
+		seq_printf(seq,
+			 "acc device:\n"
+			 "device  state: %d\n"
+			 "device  ready: %u\n"
+			 "data    valid: %d\n"
+			 "data     size: %lu\n",
+			 hisi_acc_vdev->mig_state,
+			 hisi_acc_vdev->vf_qm_state,
+			 debug_migf->disabled,
+			 debug_migf->total_length);
+	} else {
+		seq_printf(seq, "%s\n", "device not migrated!");
+	}
+
+	return 0;
+}
+
+static int hisi_acc_vfio_debug_init(struct hisi_acc_vf_core_device *hisi_acc_vdev)
+{
+	struct vfio_device *vdev = &hisi_acc_vdev->core_device.vdev;
+	struct dentry *vfio_dev_migration = NULL;
+	struct dentry *vfio_hisi_acc = NULL;
+	struct device *dev = vdev->dev;
+	void *migf = NULL;
+
+	if (!debugfs_initialized())
+		return 0;
+
+	migf = kzalloc(sizeof(struct hisi_acc_vf_migration_file), GFP_KERNEL);
+	if (!migf)
+		return -ENOMEM;
+	hisi_acc_vdev->debug_migf = migf;
+
+	vfio_dev_migration = debugfs_lookup("migration", vdev->debug_root);
+	if (!vfio_dev_migration) {
+		kfree(migf);
+		dev_err(dev, "failed to lookup migration debugfs file!\n");
+		return -ENODEV;
+	}
+
+	vfio_hisi_acc = debugfs_create_dir("hisi_acc", vfio_dev_migration);
+	debugfs_create_devm_seqfile(dev, "data", vfio_hisi_acc,
+				  hisi_acc_vf_data_read);
+	debugfs_create_devm_seqfile(dev, "attr", vfio_hisi_acc,
+				  hisi_acc_vf_attr_read);
+	debugfs_create_devm_seqfile(dev, "io_state", vfio_hisi_acc,
+				  hisi_acc_vf_debug_io);
+	debugfs_create_devm_seqfile(dev, "save", vfio_hisi_acc,
+				  hisi_acc_vf_debug_save);
+
+	return 0;
+}
+
+static void hisi_acc_vf_debugfs_exit(struct hisi_acc_vf_core_device *hisi_acc_vdev)
+{
+	if (!debugfs_initialized())
+		return;
+
+	kfree(hisi_acc_vdev->debug_migf);
+}
+
 static int hisi_acc_vfio_pci_open_device(struct vfio_device *core_vdev)
 {
 	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(core_vdev);
@@ -1323,6 +1510,7 @@ static int hisi_acc_vfio_pci_open_device(struct vfio_device *core_vdev)
 	}
 
 	vfio_pci_core_finish_enable(vdev);
+
 	return 0;
 }
 
@@ -1331,7 +1519,9 @@ static void hisi_acc_vfio_pci_close_device(struct vfio_device *core_vdev)
 	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(core_vdev);
 	struct hisi_qm *vf_qm = &hisi_acc_vdev->vf_qm;
 
+	mutex_lock(&hisi_acc_vdev->core_device.igate);
 	iounmap(vf_qm->io_base);
+	mutex_unlock(&hisi_acc_vdev->core_device.igate);
 	vfio_pci_core_close_device(core_vdev);
 }
 
@@ -1422,6 +1612,9 @@ static int hisi_acc_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device
 	ret = vfio_pci_core_register_device(&hisi_acc_vdev->core_device);
 	if (ret)
 		goto out_put_vdev;
+
+	if (ops == &hisi_acc_vfio_pci_migrn_ops)
+		hisi_acc_vfio_debug_init(hisi_acc_vdev);
 	return 0;
 
 out_put_vdev:
@@ -1434,6 +1627,7 @@ static void hisi_acc_vfio_pci_remove(struct pci_dev *pdev)
 	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_drvdata(pdev);
 
 	vfio_pci_core_unregister_device(&hisi_acc_vdev->core_device);
+	hisi_acc_vf_debugfs_exit(hisi_acc_vdev);
 	vfio_put_device(&hisi_acc_vdev->core_device.vdev);
 }
 
diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
index dcabfeec6ca1..93f44bcf53ee 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
@@ -113,5 +113,8 @@ struct hisi_acc_vf_core_device {
 	spinlock_t reset_lock;
 	struct hisi_acc_vf_migration_file *resuming_migf;
 	struct hisi_acc_vf_migration_file *saving_migf;
+
+	/* For debugfs */
+	struct hisi_acc_vf_migration_file *debug_migf;
 };
 #endif /* HISI_ACC_VFIO_PCI_H */
-- 
2.24.0

