Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5123806AD
	for <iommu@lists.linux.dev>; Sat, 28 Mar 2026 10:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774693033; cv=none; b=hQA0B8E/YJGyhP7flLyMzOpbA0ywx3WouDjwxf4/u73iqZAfAna1f7KWH/K5yn3QX3pfD6sy9FT2ABLl3tgIrMjXkie7Y877Ks9x215sqifxhsDJOz/gAe/sKHiYv/SZWiW95tw724mjX462mfBnwW2LoDmdIEONumDY/witcsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774693033; c=relaxed/simple;
	bh=tMpsqkWHwctUtjUBix8WOcZFBJl6RMPLX7Ts0aGzTnk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EAKJvYlXLtwLzF8lZ7ZNk3LbTdrOtlvC/uQseL8bF3l5GGV7VN53Eu/Da9eYRQHFXm/UOIMFkjoqLIJVKniRXYf6leawfe5c1cOclS5KA7X++lEmMJ9MV1XT6ZBpHku806f5dgSbXohE3zt8b0/A4acAuWcKUjIxcgjumt/O+Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=DoIa/Uji; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="DoIa/Uji"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wHU5+KqunB9+hNX5vubJwM9ZUSxN3Zdyf6nPKCwwUJg=;
	b=DoIa/UjiXs/6lsETax8Fox9fC9DPXWNqGUGrti5agC3zcwpU0NxaGnpM+NzMYEPGqMDaagYWh
	yyk9MoFkFBlqOub8Jot78omoKzJH9/i2/FLpF72ePGJZhFzaea7YaddjI5LKJWMiHzDhfvo7vdZ
	kjhGTaJl+ss7aeR0nhJQzmA=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fjYDy3bLwz1prx6;
	Sat, 28 Mar 2026 18:10:58 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id B0AF640569;
	Sat, 28 Mar 2026 18:17:08 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 28 Mar 2026 18:17:08 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <robin.murphy@arm.com>, <nicolinc@nvidia.com>, <will@kernel.org>,
	<jpb@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<xiaqinxin@huawei.com>, <wangzhou1@hisilicon.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>,
	<jonathan.cameron@huawei.com>, <wuyifan50@huawei.com>, <linuxarm@huawei.com>
Subject: [RFC PATCH v2 2/5] iommu/arm-smmu-v3: Add register display to debugfs
Date: Sat, 28 Mar 2026 18:17:03 +0800
Message-ID: <20260328101706.3448655-3-xiaqinxin@huawei.com>
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

Add register display functionality to debugfs.This allows reading
and displaying key SMMU register values including control registers
and queue pointers.

The registers file shows:
- CR0, CR1, CR2 control registers
- Command and Event queue pointers

Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-debugfs.c     | 78 ++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c
index c764b28e5cfb..cfd296aebc9f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c
@@ -5,13 +5,18 @@
  * Directory Structure:
  * /sys/kernel/debug/iommu/arm_smmu_v3/
  * └── smmu<ioaddr>/
- *     └── capabilities    # SMMU feature capabilities and configuration
+ *     ├── capabilities    # SMMU feature capabilities and configuration
+ *     └── registers	   # SMMU Key registers
  *
  * The capabilities file provides detailed information about:
  * - translation stage support (Stage1/Stage2)
  * - System coherency, ATS, and PRI feature availability
  * - Stream table size and command/event queue depths
  *
+ * The registers display provides crucial visibility into:
+ * - CR0, CR1, CR2 control registers
+ * - Command and Event queue pointers
+ *
  * Copyright (C) 2026 HiSilicon Limited.
  * Author: Qinxin Xia <xiaqinxin@huawei.com>
  */
@@ -89,6 +94,74 @@ static const struct file_operations smmu_debugfs_capabilities_fops = {
 	.release = smmu_debugfs_capabilities_release,
 };
 
+/**
+ * smmu_debugfs_registers_show() - Display SMMU register values
+ * @seq: seq_file to write to
+ *
+ * Errors are reported via seq_puts, the function always returns 0
+ */
+static int smmu_debugfs_registers_show(struct seq_file *seq, void *unused)
+{
+	struct arm_smmu_device *smmu = seq->private;
+	void __iomem *base;
+
+	if (!smmu || !smmu->base) {
+		seq_puts(seq, "SMMU not available\n");
+		return 0;
+	}
+
+	base = smmu->base;
+
+	seq_puts(seq, "SMMUv3 Key Registers:\n");
+
+	/* 32-bit control registers */
+	seq_printf(seq, "CR0: 0x%08x\n", readl_relaxed(base + ARM_SMMU_CR0));
+	seq_printf(seq, "CR1: 0x%08x\n", readl_relaxed(base + ARM_SMMU_CR1));
+	seq_printf(seq, "CR2: 0x%08x\n", readl_relaxed(base + ARM_SMMU_CR2));
+
+	/* 32-bit queue pointer registers */
+	seq_printf(seq, "CMDQ_PROD: 0x%08x\n",
+		   readl_relaxed(base + ARM_SMMU_CMDQ_PROD));
+	seq_printf(seq, "CMDQ_CONS: 0x%08x\n",
+		   readl_relaxed(base + ARM_SMMU_CMDQ_CONS));
+	seq_printf(seq, "EVTQ_PROD: 0x%08x\n",
+		   readl_relaxed(base + ARM_SMMU_EVTQ_PROD));
+	seq_printf(seq, "EVTQ_CONS: 0x%08x\n",
+		   readl_relaxed(base + ARM_SMMU_EVTQ_CONS));
+
+	return 0;
+}
+
+static int smmu_debugfs_registers_open(struct inode *inode, struct file *file)
+{
+	struct arm_smmu_device *smmu = inode->i_private;
+
+	if (!smmu || !get_device(smmu->dev))
+		return -ENODEV;
+
+	return single_open(file, smmu_debugfs_registers_show, smmu);
+}
+
+static int smmu_debugfs_registers_release(struct inode *inode, struct file *file)
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
+static const struct file_operations smmu_debugfs_registers_fops = {
+	.owner   = THIS_MODULE,
+	.open    = smmu_debugfs_registers_open,
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = smmu_debugfs_registers_release,
+};
+
 /**
  * arm_smmu_debugfs_setup() - Initialize debugfs for SMMU device
  * @smmu: SMMU device to setup debugfs for
@@ -134,6 +207,9 @@ int arm_smmu_debugfs_setup(struct arm_smmu_device *smmu, const char *name)
 	debugfs_create_file("capabilities", 0444, smmu_dir, smmu,
 			    &smmu_debugfs_capabilities_fops);
 
+	debugfs_create_file("registers", 0444, smmu_dir, smmu,
+			    &smmu_debugfs_registers_fops);
+
 	dev_dbg(smmu->dev, "debugfs initialized for %s\n", name);
 	return 0;
 }
-- 
2.33.0

