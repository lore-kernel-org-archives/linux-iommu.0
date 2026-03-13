Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0FD38F646
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 10:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773398644; cv=none; b=bjf0GKy36N064ntFSp6lPsg4l+bgWA073vKReuyILaeKGBbKK1XSBTNsgJHMS46ewaHEQVi37IVwnmE1M0RzmuiMBgD7z3aAl6/lq1HwqidhbbXKbWdE6Mx5CwDQJ87KXarR4GzRC4G9vIHuR9t/yB2AArAAq90+YVRFcGXlyNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773398644; c=relaxed/simple;
	bh=s9E1dgPYIv/+jCdDQZ3t2aT7FjwOBe5eHugWI9ysL44=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mzG42HXmS+yzgKFBb1488ByhMkFK5AEtgZqzXee5PT3WnUTPtb6JJtKcYX0TeXWwLe7lI71yHR0NJtU35Z06k2enR3erVitUdk5evOlbXrKyq/ul3bbi3rkRiPkDnhMv5IEs84S54FaIw/QF26UKismjW2AboRUJPI+a+Cm+CXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=W/I0E8kL; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="W/I0E8kL"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=UsbiMY794BaOl5FPe8kvLbYBRj7zwFtvYOKADAiSwjI=;
	b=W/I0E8kLnnPTwXmUPV+AH3na4QH1mW3S68tBnguB9ZYttbznvwcmLdp2j+YJlBlSZA3KYoWgi
	Ql58MpteOnioXHia1cHs3gycQjo1Kl1yndPqnd0Py9kKWEo9sJvLpzGltqNvKxltHzpXRnDZPPy
	wBF4yqbAhzLiINFNd1Tl1b4=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4fXLYW57C1z12LJy;
	Fri, 13 Mar 2026 18:38:23 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id F159740363;
	Fri, 13 Mar 2026 18:43:57 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 13 Mar 2026 18:43:57 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jpb@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<xiaqinxin@huawei.com>, <wangzhou1@hisilicon.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>,
	<jonathan.cameron@huawei.com>, <linuxarm@huawei.com>
Subject: [RFC PATCH 2/5] iommu/arm-smmu-v3: Add register display to debugfs
Date: Fri, 13 Mar 2026 18:43:48 +0800
Message-ID: <20260313104351.3502293-3-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260313104351.3502293-1-xiaqinxin@huawei.com>
References: <20260313104351.3502293-1-xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemj200003.china.huawei.com (7.202.194.15)

Add register display functionality to debugfs.This allows reading
and displaying key SMMU register values including control registers
and queue pointers.

The registers file shows:
- CR0, CR1, CR2 control registers
- Command and Event queue pointers

Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-debugfs.c     | 68 ++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c
index 542bd6047f26..f9bf955f3351 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c
@@ -12,11 +12,20 @@
  * - Capability reporting covering all major SMMU features and configuration
  * - Extensible architecture designed for adding future debug functionality
  * - Comprehensive error handling and resource cleanup
+ * - Display of control registers (CR0, CR1, CR2) with bitfield decoding
+ * - Command and Event queue pointer monitoring (PROD/CONS)
+ *
+ * Register Information Displayed:
+ * - CR0: SMMU global control with enable states and queue enables
+ * - CR1/CR2: Additional control and configuration registers
+ * - CMDQ_PROD/CONS: Command queue producer and consumer pointers
+ * - EVTQ_PROD/CONS: Event queue producer and consumer pointers
  *
  * Directory Structure:
  * /sys/kernel/debug/iommu/arm_smmu_v3/
  * └── smmu0/
- *     └── capabilities    # SMMU feature capabilities and configuration
+ *     ├── capabilities    # SMMU feature capabilities and configuration
+ *     └── registers	   # SMMU Key registers
  *
  * The capabilities file provides detailed information about:
  * - Architecture version and translation stage support (Stage1/Stage2)
@@ -24,6 +33,11 @@
  * - Stream table size and command/event queue depths
  * - All feature bits from the SMMU device structure
  *
+ * The register display provides crucial visibility into:
+ * - SMMU operational state (enabled/disabled)
+ * - Queue operation and potential stalls
+ * - Configuration settings affecting all streams
+ *
  * Copyright (C) 2025 HiSilicon Limited.
  * Author: Qinxin Xia <xiaqinxin@huawei.com>
  */
@@ -69,6 +83,54 @@ static int smmu_debugfs_capabilities_show(struct seq_file *seq, void *v)
 }
 DEFINE_SHOW_ATTRIBUTE(smmu_debugfs_capabilities);
 
+/**
+ * smmu_debugfs_registers_show() - Display SMMU register values
+ * @seq: seq_file to write to
+ * @v: private data (SMMU device)
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int smmu_debugfs_registers_show(struct seq_file *seq, void *v)
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
+	seq_printf(seq, "CR0: 0x%08x [%s%s%s]\n",
+		   readl_relaxed(base + ARM_SMMU_CR0),
+		   readl_relaxed(base + ARM_SMMU_CR0) & CR0_SMMUEN ?
+		   "Enabled " : "Disabled ",
+		   readl_relaxed(base + ARM_SMMU_CR0) & CR0_EVTQEN ?
+		   "EventQ " : "",
+		   readl_relaxed(base + ARM_SMMU_CR0) & CR0_CMDQEN ?
+		   "CmdQ " : "");
+
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
+DEFINE_SHOW_ATTRIBUTE(smmu_debugfs_registers);
+
 /**
  * arm_smmu_debugfs_setup() - Initialize debugfs for SMMU device
  * @smmu: SMMU device to setup debugfs for
@@ -120,6 +182,10 @@ int arm_smmu_debugfs_setup(struct arm_smmu_device *smmu, phys_addr_t ioaddr)
 				 &smmu_debugfs_capabilities_fops))
 		goto err_cleanup;
 
+	if (!debugfs_create_file("registers", 0444, smmu_dir, smmu,
+				 &smmu_debugfs_registers_fops))
+		goto err_cleanup;
+
 	pr_info("SMMUv3 debugfs initialized for smmu%pa\n", &ioaddr);
 	return 0;
 
-- 
2.33.0

