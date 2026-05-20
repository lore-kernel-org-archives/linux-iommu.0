Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD6E3382E1
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 06:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779259049; cv=none; b=Iwrdympw4RSF3LuX/1s+Qwc49SDbpg7BmkzXChL7kUwWtmLmtV1peMLvOF5kLGD+O8XKBSuczG+qVQwvQ3sqi1JSF+OygLvPuSZKmzP4/mscPH/1znqwJ/jlZJ/TkFeF2lHZJKdHyUm36nrK+UIqBhUWjaDsTCYr4kncawqnRTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779259049; c=relaxed/simple;
	bh=vMHh8OXTHaHYXC4EputxpzkylZJd5ittKyjt+2GhsPY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJUn571yK0WrNY2GJAB5xXoWCCP0yOYZmdOC9bPtWZCi+znoIwnhR7b5hcQf3sisKiyYmll73TjC8Ojp8jFAgDYMIBE9A9qr/k120tAwwtHZhsph/d2QuTlEU3mebUEDboSVmUqjGxJiiNWJ8BV6iYpNsStcAB8Q2K1mmGmn0ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=e/ehfqYc; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="e/ehfqYc"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=IMkepDCVc2TLY2VZbej5xOqxbCMgq8RcQd0nxJHbH2o=;
	b=e/ehfqYcuRj5vCkhJu+aFkoz6KYv3jLv2fDoFIQtEt73SO1JwX3M+SEtxaamrD55m0QphFpbY
	BgG+OFcQHH6rc2vpas0AFiUfJ8EigVHJwaUxqY4xOr5PKINa9FigAk7HPBeb7n7zpkUMYfX39Z1
	C+R5q6eVm8GgT1I46IeRW5g=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gL1q33dCrzmV7Z;
	Wed, 20 May 2026 14:29:35 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 04C8940561;
	Wed, 20 May 2026 14:37:18 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 20 May 2026 14:37:17 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <robin.murphy@arm.com>, <nicolinc@nvidia.com>, <will@kernel.org>,
	<jpb@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<xiaqinxin@huawei.com>, <wangzhou1@hisilicon.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>,
	<jonathan.cameron@huawei.com>, <wuyifan50@huawei.com>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 2/5] iommu/arm-smmu-v3: Add register display to debugfs
Date: Wed, 20 May 2026 14:37:08 +0800
Message-ID: <20260520063714.2440584-2-xiaqinxin@huawei.com>
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
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemj200003.china.huawei.com (7.202.194.15)

Add register display functionality to debugfs.This allows reading
and displaying key SMMU register values including control registers
and queue pointers.

The registers file shows:
- CR0, CR1, CR2 control registers
- Command and Event queue pointers

Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-debugfs.c     | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c
index 1fc2cd1651b4..a541476b7427 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c
@@ -6,12 +6,17 @@
  * /sys/kernel/debug/iommu/arm_smmu_v3/
  * └── smmu<ioaddr>/
  *     ├── capabilities    # SMMU feature capabilities and configuration
+ *     ├── registers       # SMMU Key registers
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
@@ -95,6 +100,80 @@ static const struct file_operations smmu_debugfs_capabilities_fops = {
 	.release = smmu_debugfs_capabilities_release,
 };
 
+/**
+ * smmu_debugfs_registers_show() - Display SMMU register values
+ * @seq: seq_file to write to
+ * @unused: unused parameter
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
+		   smmu->page1 ? readl_relaxed(smmu->page1 + ARM_SMMU_EVTQ_PROD) : 0);
+	seq_printf(seq, "EVTQ_CONS: 0x%08x\n",
+		   smmu->page1 ? readl_relaxed(smmu->page1 + ARM_SMMU_EVTQ_CONS) : 0);
+
+	return 0;
+}
+
+static int smmu_debugfs_registers_open(struct inode *inode, struct file *file)
+{
+	struct arm_smmu_device *smmu = inode->i_private;
+	int ret;
+
+	if (!smmu || !get_device(smmu->dev))
+		return -ENODEV;
+
+	ret = single_open(file, smmu_debugfs_registers_show, smmu);
+	if (ret)
+		put_device(smmu->dev);
+
+	return ret;
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
@@ -142,6 +221,9 @@ int arm_smmu_debugfs_setup(struct arm_smmu_device *smmu, const char *name)
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

