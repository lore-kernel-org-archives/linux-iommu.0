Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7AD33EB1B
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 06:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779259050; cv=none; b=GVhDU63tZDk4oRBRGqPZFM2eaUXIpdo9rXZ5fNuJluyE2U46jB+uGEIncAxy7DipVixN7m6eQP4/M34ysTaZPa8EAfIF5+99Bk3G2V96PPJqFWC59L9IifCBg3JnMp9prvS/Yiv7RMEatoLPQI3XCv0I20jw9OpvJEvIql8bKnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779259050; c=relaxed/simple;
	bh=Dr/4xDbrG510OQcjwBL+tFBVj+TL+p3PLRpuroJdcow=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iK2Kin4gZ8EzGTDxWcdL37B40fIT/mpfEekxycu9J1p/52wvV+G6YaBgGukQbWid4JcpRtixCDXkL6sI/mMYjsmEfYzEXgOapgaP3R311BeI1j4Ke/8Y1s4PafJutAOLYCSkwjVYYf/IhCWe4MMGIod7RRU/TwNso1tl4fVgyOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=JP0H/hcb; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="JP0H/hcb"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=A+9GMhHowlViOnH7+R9rmivmHqr2sB1gmzk/fG1Uco0=;
	b=JP0H/hcbSFdYwsZD0y/WqrbQ/tzGa8skOHjGDlyMM26YfHsUUglbpIbKwyZp3qvRLTM/vFpTo
	3HCy15p48E/Drxodqr2XwBNXeS97tlHjEveIXS+m62aOKUO8yxOEOfK+UDypixYU0bCkWRDf4gc
	v5gacV3Ab6oangMQznj6aY8=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gL1qg5S4VzpT03;
	Wed, 20 May 2026 14:30:07 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 5915B4048F;
	Wed, 20 May 2026 14:37:21 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 20 May 2026 14:37:20 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <robin.murphy@arm.com>, <nicolinc@nvidia.com>, <will@kernel.org>,
	<jpb@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<xiaqinxin@huawei.com>, <wangzhou1@hisilicon.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>,
	<jonathan.cameron@huawei.com>, <wuyifan50@huawei.com>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5] iommu/arm-smmu-v3: Add Context Descriptor display to debugfs
Date: Wed, 20 May 2026 14:37:11 +0800
Message-ID: <20260520063714.2440584-5-xiaqinxin@huawei.com>
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

Add Context Descriptor (CD) display functionality to debugfs.
This allow inspecting CD contents for all Substream IDs including:
- CD validity and translation parameters
- TTBR0 and TCR configurations
- Raw CD data

/sys/kernel/debug/iommu/arm_smmu_v3/smmu0/stream_table/
└── <sid>/
    ├─── ste
    ├─── cd
    └─── <dev_name>

Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-debugfs.c     | 101 ++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c
index 9babc7d640fd..567749de5537 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c
@@ -10,6 +10,7 @@
  *     ├── stream_table
  *         ├── <sid>/                                # Stream ID
  *             ├── ste                               # Stream Table Entry
+ *             ├── cd                                 # Context Descriptor
  *             ├── <dev_name>                         # Symlink to device sysfs directory
  *
  * The capabilities file provides detailed information about:
@@ -26,6 +27,12 @@
  * - Stage 1 and Stage 2 context pointers
  * - Raw STE data
  *
+ * CD Information Displayed:
+ * - T0SZ: Input address space size configuration
+ * - EPD0/EPD1: Stage 1 translation enable flags
+ * - TTBR0: Stage 1 translation table base address
+ * - Raw Data: Complete CD structure in hexadecimal format
+ *
  * Copyright (C) 2026 HiSilicon Limited.
  * Author: Qinxin Xia <xiaqinxin@huawei.com>
  */
@@ -303,6 +310,97 @@ static const struct file_operations smmu_debugfs_ste_fops = {
 	.release = smmu_debugfs_ste_release,
 };
 
+/**
+ * smmu_debug_dump_cd() - Dump a single Context Descriptor
+ * @seq: seq_file to write to
+ * @cd: pointer to the Context Descriptor to dump
+ */
+static void smmu_debug_dump_cd(struct seq_file *seq, struct arm_smmu_cd *cd)
+{
+	u64 data;
+	int i;
+
+	/* CD 0 */
+	data = le64_to_cpu(cd->data[0]);
+	seq_printf(seq, "  T0SZ: 0x%llx\n", data & CTXDESC_CD_0_TCR_T0SZ);
+	seq_printf(seq, "  EPD0: %s\n", data & CTXDESC_CD_0_TCR_EPD0 ? "Yes" : "No");
+	seq_printf(seq, "  EPD1: %s\n", data & CTXDESC_CD_0_TCR_EPD1 ? "Yes" : "No");
+
+	/* CD 1 */
+	data = le64_to_cpu(cd->data[1]);
+	seq_printf(seq, "  TTBR0: 0x%016llx\n", data & CTXDESC_CD_1_TTB0_MASK);
+
+	/* Display raw CD data */
+	seq_puts(seq, "  Raw Data:\n");
+	for (i = 0; i < CTXDESC_CD_DWORDS; i++)
+		seq_printf(seq, "    CD[%d]: 0x%016llx\n", i,
+			   le64_to_cpu(cd->data[i]));
+}
+
+static int smmu_debugfs_cd_show(struct seq_file *seq, void *unused)
+{
+	struct device *dev = seq->private;
+	struct arm_smmu_master *master;
+	u32 max_ssids, ssid;
+
+	guard(mutex)(&arm_smmu_asid_lock);
+
+	master = dev_iommu_priv_get(dev);
+	if (!master) {
+		seq_puts(seq, "No master data\n");
+		return 0;
+	}
+
+	max_ssids = 1 << master->ssid_bits;
+	seq_printf(seq, "Context Descriptors for device (max SSIDs: %u):\n",
+		   max_ssids);
+
+	for (ssid = 0; ssid < max_ssids; ssid++) {
+		struct arm_smmu_cd *cd = arm_smmu_get_cd_ptr(master, ssid);
+
+		if (cd && (le64_to_cpu(cd->data[0]) & CTXDESC_CD_0_V)) {
+			seq_printf(seq, "\n--- SSID %u ---\n", ssid);
+			smmu_debug_dump_cd(seq, cd);
+		}
+	}
+
+	return 0;
+}
+
+static int smmu_debugfs_cd_open(struct inode *inode, struct file *file)
+{
+	struct device *dev = inode->i_private;
+	int ret;
+
+	if (!dev || !get_device(dev))
+		return -ENODEV;
+
+	ret = single_open(file, smmu_debugfs_cd_show, dev);
+	if (ret)
+		put_device(dev);
+
+	return ret;
+}
+
+static int smmu_debugfs_cd_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq = file->private_data;
+	struct device *dev = seq->private;
+
+	single_release(inode, file);
+	if (dev)
+		put_device(dev);
+	return 0;
+}
+
+static const struct file_operations smmu_debugfs_cd_fops = {
+	.owner   = THIS_MODULE,
+	.open    = smmu_debugfs_cd_open,
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = smmu_debugfs_cd_release,
+};
+
 /**
  * arm_smmu_debugfs_create_stream_table() - Create debugfs entries for stream table
  * @smmu: SMMU device
@@ -373,6 +471,9 @@ int arm_smmu_debugfs_create_stream_table(struct arm_smmu_device *smmu,
 				kfree(full_path);
 			}
 		}
+
+		/* Create CD file to dump all valid Context Descriptors */
+		debugfs_create_file("cd", 0444, dev_dir, dev, &smmu_debugfs_cd_fops);
 	}
 
 	kfree(path);
-- 
2.33.0

