Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AA237F755
	for <iommu@lists.linux.dev>; Sat, 28 Mar 2026 10:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774693033; cv=none; b=mqJYJaSpg/RDxfYWefAfuR7XJAbPTUIVp69TnRykFZ2jGPag/hw0OLNN42kzNH6j/yLJ7Ukg74w7Tq/KgjC7TXN2Kv+2A7VfcY+FYfiPTrIHwvq4RWpSzSHSjns/ZcbEfJUDeVhWM5lhALkC4EAm4I7kILnVsKw90QHBSCFn3Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774693033; c=relaxed/simple;
	bh=rvKrTy8TIj2J967JYqQy24DGSKbUKxs55K3kLTiLdS0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a2FUJ91sasH702px0Kn8FJDawETEcaSg90p0bhlzkLAQcqXzmBDYXavA2czyHUhKDPBuKl02TFyvgL8zyYy75QaDcCGJ+xJm2m7ZRVTg3B0IgGSSD6Dcw3LszjUfJMYumx4AZnqi1kBaKkzB0rla1aOD9M97H60VXPG9b8OJOTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=mh9GHLGi; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="mh9GHLGi"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=hK3rN2DXT7UpSz7XNNpD/ir+xO00JejsvsPuYH74cf0=;
	b=mh9GHLGiUavV2lHmLkEvJ0favYOQtibHH9mkyUbmvw6VoAlxraKyFqMjP+VvE1MMwDHOYnuc7
	TzRLlo2jkFgrCYCn7LIKk1s0e9H91gFDJ2/kDhpx7a5JPcZEKOd1RVWzkLFzUFLLyQoO9BkUbkU
	cvCFHQOVpqFvWy55EGvKsYU=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4fjYF30JPgz1K968;
	Sat, 28 Mar 2026 18:11:03 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 29A3040561;
	Sat, 28 Mar 2026 18:17:08 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 28 Mar 2026 18:17:07 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <robin.murphy@arm.com>, <nicolinc@nvidia.com>, <will@kernel.org>,
	<jpb@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<xiaqinxin@huawei.com>, <wangzhou1@hisilicon.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>,
	<jonathan.cameron@huawei.com>, <wuyifan50@huawei.com>, <linuxarm@huawei.com>
Subject: [RFC PATCH v2 1/5] iommu/arm-smmu-v3: Add basic debugfs framework
Date: Sat, 28 Mar 2026 18:17:02 +0800
Message-ID: <20260328101706.3448655-2-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260328101706.3448655-1-xiaqinxin@huawei.com>
References: <20260328101706.3448655-1-xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemj200003.china.huawei.com (7.202.194.15)

Add basic debugfs framework for ARM SMMUv3 driver.This creates the
root directory structure and provides capability display functionality.

The debugfs hierarchy is organized as:
/sys/kernel/debug/iommu/arm_smmu_v3/
└── smmu<ioaddr>/
    └── capabilities

Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 drivers/iommu/Kconfig                         |  11 ++
 drivers/iommu/arm/arm-smmu-v3/Makefile        |   1 +
 .../arm/arm-smmu-v3/arm-smmu-v3-debugfs.c     | 163 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  15 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  15 ++
 5 files changed, 205 insertions(+)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index f86262b11416..f28f09adba03 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -93,6 +93,17 @@ config IOMMU_DEBUGFS
 	  debug/iommu directory, and then populate a subdirectory with
 	  entries as required.
 
+config ARM_SMMU_V3_DEBUGFS
+	bool "ARM SMMUv3 DebugFS support"
+	depends on ARM_SMMU_V3 && IOMMU_DEBUGFS
+	help
+	  Expose ARM SMMUv3 internal state via debugfs for debugging and
+	  diagnostics. This creates /sys/kernel/debug/iommu/arm_smmu_v3/
+	  with detailed information about SMMU configuration, stream tables,
+	  and context descriptors.
+
+	  Say N unless you are debugging SMMU issues.
+
 choice
 	prompt "IOMMU default domain type"
 	depends on IOMMU_API
diff --git a/drivers/iommu/arm/arm-smmu-v3/Makefile b/drivers/iommu/arm/arm-smmu-v3/Makefile
index 493a659cc66b..787538fb7054 100644
--- a/drivers/iommu/arm/arm-smmu-v3/Makefile
+++ b/drivers/iommu/arm/arm-smmu-v3/Makefile
@@ -4,5 +4,6 @@ arm_smmu_v3-y := arm-smmu-v3.o
 arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_IOMMUFD) += arm-smmu-v3-iommufd.o
 arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_SVA) += arm-smmu-v3-sva.o
 arm_smmu_v3-$(CONFIG_TEGRA241_CMDQV) += tegra241-cmdqv.o
+arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_DEBUGFS) += arm-smmu-v3-debugfs.o
 
 obj-$(CONFIG_ARM_SMMU_V3_KUNIT_TEST) += arm-smmu-v3-test.o
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c
new file mode 100644
index 000000000000..c764b28e5cfb
--- /dev/null
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM SMMUv3 DebugFS Support
+ *
+ * Directory Structure:
+ * /sys/kernel/debug/iommu/arm_smmu_v3/
+ * └── smmu<ioaddr>/
+ *     └── capabilities    # SMMU feature capabilities and configuration
+ *
+ * The capabilities file provides detailed information about:
+ * - translation stage support (Stage1/Stage2)
+ * - System coherency, ATS, and PRI feature availability
+ * - Stream table size and command/event queue depths
+ *
+ * Copyright (C) 2026 HiSilicon Limited.
+ * Author: Qinxin Xia <xiaqinxin@huawei.com>
+ */
+
+#include <linux/cleanup.h>
+#include <linux/debugfs.h>
+#include <linux/slab.h>
+#include "arm-smmu-v3.h"
+
+static struct dentry *smmu_debugfs_root;
+static DEFINE_MUTEX(arm_smmu_debugfs_lock);
+
+/**
+ * smmu_debugfs_capabilities_show() - Display SMMU capabilities
+ * @seq: seq_file to write to
+ *
+ * Errors are reported via seq_puts, the function always returns 0
+ */
+static int smmu_debugfs_capabilities_show(struct seq_file *seq, void *unused)
+{
+	struct arm_smmu_device *smmu = seq->private;
+
+	if (!smmu) {
+		seq_puts(seq, "SMMU not available\n");
+		return 0;
+	}
+
+	seq_puts(seq, "SMMUv3 Capabilities:\n");
+	seq_printf(seq, "  Stage1 Translation: %s\n",
+		   smmu->features & ARM_SMMU_FEAT_TRANS_S1 ? "Yes" : "No");
+	seq_printf(seq, "  Stage2 Translation: %s\n",
+		   smmu->features & ARM_SMMU_FEAT_TRANS_S2 ? "Yes" : "No");
+	seq_printf(seq, "  Coherent Walk: %s\n",
+		   smmu->features & ARM_SMMU_FEAT_COHERENCY ? "Yes" : "No");
+	seq_printf(seq, "  ATS Support: %s\n",
+		   smmu->features & ARM_SMMU_FEAT_ATS ? "Yes" : "No");
+	seq_printf(seq, "  PRI Support: %s\n",
+		   smmu->features & ARM_SMMU_FEAT_PRI ? "Yes" : "No");
+	seq_printf(seq, "  Stream Table Size: %d\n", 1 << smmu->sid_bits);
+	seq_printf(seq, "  Command Queue Depth: %d\n",
+		   1 << smmu->cmdq.q.llq.max_n_shift);
+	seq_printf(seq, "  Event Queue Depth: %d\n",
+		   1 << smmu->evtq.q.llq.max_n_shift);
+
+	return 0;
+}
+
+static int smmu_debugfs_capabilities_open(struct inode *inode, struct file *file)
+{
+	struct arm_smmu_device *smmu = inode->i_private;
+
+	if (!smmu || !get_device(smmu->dev))
+		return -ENODEV;
+
+	return single_open(file, smmu_debugfs_capabilities_show, smmu);
+}
+
+static int smmu_debugfs_capabilities_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq = file->private_data;
+	struct arm_smmu_device *smmu = seq->private;
+
+	single_release(inode, file);
+	if (smmu)
+		put_device(smmu->dev);
+
+	return 0;
+}
+
+static const struct file_operations smmu_debugfs_capabilities_fops = {
+	.owner   = THIS_MODULE,
+	.open    = smmu_debugfs_capabilities_open,
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = smmu_debugfs_capabilities_release,
+};
+
+/**
+ * arm_smmu_debugfs_setup() - Initialize debugfs for SMMU device
+ * @smmu: SMMU device to setup debugfs for
+ * @name: SMMU device name
+ *
+ * This function creates the basic debugfs directory structure for an SMMU device.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int arm_smmu_debugfs_setup(struct arm_smmu_device *smmu, const char *name)
+{
+	struct arm_smmu_debugfs *debugfs;
+	struct dentry *smmu_dir;
+
+	/* Create root directory if it doesn't exist */
+	scoped_guard(mutex, &arm_smmu_debugfs_lock) {
+		if (!smmu_debugfs_root) {
+			/* Once created, it will not be removed */
+			smmu_debugfs_root = debugfs_create_dir("arm_smmu_v3",
+							       iommu_debugfs_dir);
+			if (!smmu_debugfs_root)
+				return -ENOMEM;
+		}
+	}
+
+	/* Allocate debugfs structure */
+	debugfs = kzalloc_obj(*debugfs);
+	if (!debugfs)
+		return -ENOMEM;
+
+	/* Create SMMU instance directory */
+	smmu_dir = debugfs_create_dir(name, smmu_debugfs_root);
+	if (!smmu_dir) {
+		kfree(debugfs);
+		smmu->debugfs = NULL;
+		return -ENOMEM;
+	}
+
+	debugfs->smmu_dir = smmu_dir;
+	smmu->debugfs = debugfs;
+
+	/* Create capabilities file */
+	debugfs_create_file("capabilities", 0444, smmu_dir, smmu,
+			    &smmu_debugfs_capabilities_fops);
+
+	dev_dbg(smmu->dev, "debugfs initialized for %s\n", name);
+	return 0;
+}
+
+/**
+ * arm_smmu_debugfs_remove() - Clean up debugfs entries for an SMMU device
+ * @smmu: SMMU device
+ *
+ * This function removes the debugfs directories created by setup.
+ */
+void arm_smmu_debugfs_remove(struct arm_smmu_device *smmu)
+{
+	struct arm_smmu_debugfs *debugfs;
+
+	scoped_guard(mutex, &arm_smmu_debugfs_lock) {
+		debugfs = smmu->debugfs;
+		if (!debugfs)
+			return;
+
+		/* Remove the entire SMMU instance directory */
+		debugfs_remove_recursive(debugfs->smmu_dir);
+
+		/* Free the debugfs structure */
+		kfree(debugfs);
+		smmu->debugfs = NULL;
+	}
+}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 4d00d796f078..cbb3fccc501b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4904,6 +4904,15 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	/* Check for RMRs and install bypass STEs if any */
 	arm_smmu_rmr_install_bypass_ste(smmu);
 
+#ifdef CONFIG_ARM_SMMU_V3_DEBUGFS
+	char name[32];
+
+	snprintf(name, sizeof(name), "smmu3.%pa", &ioaddr);
+	ret = arm_smmu_debugfs_setup(smmu, name);
+	if (ret)
+		dev_warn(dev, "Failed to create debugfs!\n");
+#endif
+
 	/* Reset the device */
 	ret = arm_smmu_device_reset(smmu);
 	if (ret)
@@ -4926,6 +4935,9 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 err_free_sysfs:
 	iommu_device_sysfs_remove(&smmu->iommu);
 err_disable:
+#ifdef CONFIG_ARM_SMMU_V3_DEBUGFS
+	arm_smmu_debugfs_remove(smmu);
+#endif
 	arm_smmu_device_disable(smmu);
 err_free_iopf:
 	iopf_queue_free(smmu->evtq.iopf);
@@ -4938,6 +4950,9 @@ static void arm_smmu_device_remove(struct platform_device *pdev)
 
 	iommu_device_unregister(&smmu->iommu);
 	iommu_device_sysfs_remove(&smmu->iommu);
+#ifdef CONFIG_ARM_SMMU_V3_DEBUGFS
+	arm_smmu_debugfs_remove(smmu);
+#endif
 	arm_smmu_device_disable(smmu);
 	iopf_queue_free(smmu->evtq.iopf);
 	ida_destroy(&smmu->vmid_map);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 3c6d65d36164..a54d72fb9e07 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -733,6 +733,16 @@ struct arm_smmu_impl_ops {
 			  const struct iommu_user_data *user_data);
 };
 
+#ifdef CONFIG_ARM_SMMU_V3_DEBUGFS
+struct arm_smmu_debugfs {
+	struct dentry			*smmu_dir;
+	/* Reserved for future extensions */
+};
+
+int arm_smmu_debugfs_setup(struct arm_smmu_device *smmu, const char *name);
+void arm_smmu_debugfs_remove(struct arm_smmu_device *smmu);
+#endif
+
 /* An SMMUv3 instance */
 struct arm_smmu_device {
 	struct device			*dev;
@@ -803,6 +813,11 @@ struct arm_smmu_device {
 
 	struct rb_root			streams;
 	struct mutex			streams_mutex;
+
+#ifdef CONFIG_ARM_SMMU_V3_DEBUGFS
+	/* DebugFS Info */
+	struct arm_smmu_debugfs		*debugfs;
+#endif
 };
 
 struct arm_smmu_stream {
-- 
2.33.0

