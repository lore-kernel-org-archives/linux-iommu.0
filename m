Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8AB2D879E
	for <iommu@lists.linux.dev>; Sat, 28 Mar 2026 10:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774693033; cv=none; b=cdjEL6XxtuQDBdvBMsaFIO1Q6VB201IXfLVb+uOMTrDZ7Dm8XAR+FFtVpfz+te7T50prtvDptQbqc4F+nZ0uVk9WyOAYesUDI0OoZ2JtKK+lPrZvHyRZ2DDRJ2lp51leInHsSghzeUDP6cL4w5s7yjui7nv9reAT1GQ12ZYk8JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774693033; c=relaxed/simple;
	bh=Mf2WFfrzzjOwk7K+HOXIUoaFrrMBOtEQaFqOlsrhDjE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bNni4e7EhbwmEs6QkQYpkqdJiuUZfHqs8uAT22ob2cLHgykdbVqAkKdwcqCegSZchkCmpzI3VaR3X+ozo4xHH8hefrOrCJh5MXHy284V+8rgRWCxYSFG+jZYgqE61secBvEqkXsvNzvk1qMMkv3ELaHDoZzNcK8Rm8QL1uyAU1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=uoKHXFTc; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="uoKHXFTc"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ZnIb1phbbkJLVpwig4N8wgnO3nIMPPVdE3hAilxo4TU=;
	b=uoKHXFTciWUyMCOXmCGNm1/koksYcY1khsgZyfK3aRLSyOMmQe/p86zwiW1C4RyBU7dMhtAyO
	fBmUka9KwSkCl5hvZbxru630bhVJ5qNLg44g1yHuP9pw+qItdJpz4Znll4QNU33QHciXQKxY5BM
	zZe5XZTXYH8UEWQdYuIs1X4=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4fjYFC6fqLzcZxr;
	Sat, 28 Mar 2026 18:11:11 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 4976540575;
	Sat, 28 Mar 2026 18:17:09 +0800 (CST)
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
Subject: [RFC PATCH v2 3/5] iommu/arm-smmu-v3: Add Stream Table Entry display to debugfs
Date: Sat, 28 Mar 2026 18:17:04 +0800
Message-ID: <20260328101706.3448655-4-xiaqinxin@huawei.com>
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

Add Stream Table Entry (STE) display functionality to debugfs.
This allow inspecting STE contents for each device stream including:
- STE validity and configuration
- Stage 1 and Stage 2 context pointers
- Raw STE data

/sys/kernel/debug/iommu/arm_smmu_v3/smmu0/stream_table/
└── <sid>/
    └─── ste

Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-debugfs.c     | 224 +++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  18 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  17 ++
 3 files changed, 256 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c
index cfd296aebc9f..70623b480d64 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c
@@ -6,7 +6,10 @@
  * /sys/kernel/debug/iommu/arm_smmu_v3/
  * └── smmu<ioaddr>/
  *     ├── capabilities    # SMMU feature capabilities and configuration
- *     └── registers	   # SMMU Key registers
+ *     ├── registers	   # SMMU Key registers
+ *     └── stream_table
+ *	   └─── <sid>/                                # Stream ID 0
+ *	       └── ste                                # Stream Table Entry
  *
  * The capabilities file provides detailed information about:
  * - translation stage support (Stage1/Stage2)
@@ -17,6 +20,11 @@
  * - CR0, CR1, CR2 control registers
  * - Command and Event queue pointers
  *
+ * The STE Information Displayed:
+ * - STE validity and configuration
+ * - Stage 1 and Stage 2 context pointers
+ * - Raw STE data
+ *
  * Copyright (C) 2026 HiSilicon Limited.
  * Author: Qinxin Xia <xiaqinxin@huawei.com>
  */
@@ -162,6 +170,218 @@ static const struct file_operations smmu_debugfs_registers_fops = {
 	.release = smmu_debugfs_registers_release,
 };
 
+/**
+ * smmu_debugfs_ste_show() - Dump STE details to seq_file
+ * @seq: seq_file to write to
+ *
+ * Errors are reported via seq_puts, the function always returns 0
+ */
+static int smmu_debugfs_ste_show(struct seq_file *seq, void *unused)
+{
+	struct ste_context *ctx = seq->private;
+	struct arm_smmu_master *master = ctx->master;
+	struct arm_smmu_device *smmu;
+	struct arm_smmu_ste *ste;
+	u32 sid, cfg;
+	int i;
+
+	if (!master) {
+		seq_puts(seq, "No SMMU master data\n");
+		return 0;
+	}
+
+	smmu = master->smmu;
+	scoped_guard(mutex, &smmu->streams_mutex) {
+		sid = ctx->sid;
+
+		if (!arm_smmu_sid_in_range(smmu, sid)) {
+			seq_printf(seq, "Invalid Stream ID: %u (max %u)\n",
+				   sid, (1 << smmu->sid_bits) - 1);
+			return 0;
+		}
+
+		ste = arm_smmu_get_step_for_sid(smmu, sid);
+		if (!ste) {
+			seq_printf(seq, "STE not available for SID %u\n", sid);
+			return 0;
+		}
+
+		seq_printf(seq, "STE for Stream ID %u\n", sid);
+		seq_printf(seq, "  Valid: %s\n",
+			   le64_to_cpu(ste->data[0]) & STRTAB_STE_0_V ? "Yes" : "No");
+
+		seq_puts(seq, "  Config: ");
+
+		cfg = FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(ste->data[0]));
+
+		switch (cfg) {
+		case STRTAB_STE_0_CFG_BYPASS:
+			seq_puts(seq, "BYPASS\n");
+			break;
+		case STRTAB_STE_0_CFG_S1_TRANS:
+			seq_puts(seq, "only S1_TRANS\n");
+			break;
+		case STRTAB_STE_0_CFG_S2_TRANS:
+			seq_puts(seq, "only S2_TRANS\n");
+			break;
+		case STRTAB_STE_0_CFG_NESTED:
+			seq_puts(seq, "S1+S2_TRANS\n");
+			break;
+		case STRTAB_STE_0_CFG_ABORT:
+			seq_puts(seq, "ABORT\n");
+			break;
+		default:
+			seq_puts(seq, "UNKNOWN\n");
+		}
+
+		if (le64_to_cpu(ste->data[0]) & STRTAB_STE_0_CFG_S1_TRANS) {
+			seq_printf(seq, "  S1ContextPtr: 0x%016llx\n",
+				   le64_to_cpu(ste->data[1]) & STRTAB_STE_0_S1CTXPTR_MASK);
+		}
+
+		if (le64_to_cpu(ste->data[0]) & STRTAB_STE_0_CFG_S2_TRANS) {
+			seq_printf(seq, "  S2ContextPtr: 0x%016llx\n",
+				   le64_to_cpu(ste->data[3]) & STRTAB_STE_3_S2TTB_MASK);
+		}
+
+		/* Display raw STE data */
+		seq_puts(seq, "  Raw Data:\n");
+		for (i = 0; i < STRTAB_STE_DWORDS; i++)
+			seq_printf(seq, "    STE[%d]: 0x%016llx\n", i,
+				   le64_to_cpu(ste->data[i]));
+	}
+		return 0;
+}
+
+static int smmu_debugfs_ste_open(struct inode *inode, struct file *file)
+{
+	struct ste_context *ctx = inode->i_private;
+
+	if (!ctx || !get_device(ctx->master->dev))
+		return -ENODEV;
+
+	return single_open(file, smmu_debugfs_ste_show, ctx);
+}
+
+static int smmu_debugfs_ste_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq = file->private_data;
+	struct ste_context *ctx = seq->private;
+
+	single_release(inode, file);
+	if (ctx)
+		put_device(ctx->master->dev);
+	return 0;
+}
+
+static const struct file_operations smmu_debugfs_ste_fops = {
+	.owner   = THIS_MODULE,
+	.open    = smmu_debugfs_ste_open,
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = smmu_debugfs_ste_release,
+};
+
+/**
+ * arm_smmu_debugfs_create_stream_table() - Create debugfs entries for stream table
+ * @dev: device to create entries for
+ * @smmu: SMMU device
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int arm_smmu_debugfs_create_stream_table(struct device *dev,
+					 struct arm_smmu_device *smmu)
+{
+	struct dentry *stream_dir, *dev_dir;
+	struct arm_smmu_master *master;
+	struct ste_context *ctx;
+	char name[64];
+	u32 sid;
+	int i;
+
+	scoped_guard(mutex, &arm_smmu_debugfs_lock) {
+		if (!smmu->debugfs->stream_dir) {
+			stream_dir = debugfs_create_dir("stream_table",
+							smmu->debugfs->smmu_dir);
+			if (!stream_dir)
+				return -ENOMEM;
+
+			smmu->debugfs->stream_dir = stream_dir;
+		} else {
+			stream_dir = smmu->debugfs->stream_dir;
+		}
+	}
+
+	master = dev_iommu_priv_get(dev);
+	if (!master || !master->num_streams)
+		return -ENODEV;
+
+	for (i = 0; i < master->num_streams; i++) {
+		sid = master->streams[i].id;
+		snprintf(name, sizeof(name), "%u", sid);
+		dev_dir = debugfs_create_dir(name, stream_dir);
+		if (!dev_dir)
+			continue;
+
+		/* Create STE file */
+		ctx = kzalloc_obj(*ctx);
+		ctx->master = master;
+		ctx->sid = sid;
+		spin_lock(&smmu->debugfs->stream_lock);
+		list_add_tail(&ctx->node, &smmu->debugfs->stream_list);
+		spin_unlock(&smmu->debugfs->stream_lock);
+		debugfs_create_file("ste", 0444, dev_dir, ctx,
+				    &smmu_debugfs_ste_fops);
+
+	}
+
+	return 0;
+}
+
+/**
+ * arm_smmu_debugfs_remove_stream_table() - Remove debugfs entries for stream table
+ * @dev: device to remove entries for
+ * @smmu: SMMU device
+ *
+ * This function removes the debugfs directories created by
+ * arm_smmu_debugfs_create_stream_table().
+ */
+void arm_smmu_debugfs_remove_stream_table(struct device *dev,
+				      struct arm_smmu_device *smmu)
+{
+	struct dentry *stream_dir, *dev_dir;
+	struct arm_smmu_master *master;
+	struct ste_context *ctx, *tmp;
+	char name[64];
+	int i;
+
+	/* Check if stream_table directory exists */
+	if (!smmu->debugfs || !smmu->debugfs->stream_dir)
+		return;
+
+	stream_dir = smmu->debugfs->stream_dir;
+	master = dev_iommu_priv_get(dev);
+	if (!master)
+		return;
+
+	/* Remove directories for each stream ID */
+	for (i = 0; i < master->num_streams; i++) {
+		snprintf(name, sizeof(name), "%u", master->streams[i].id);
+		dev_dir = debugfs_lookup(name, stream_dir);
+		debugfs_remove_recursive(dev_dir);
+	}
+
+	/* Free stream context */
+	spin_lock(&smmu->debugfs->stream_lock);
+	list_for_each_entry_safe(ctx, tmp, &smmu->debugfs->stream_list, node) {
+		if (ctx->master->dev == dev) {
+			list_del(&ctx->node);
+			kfree(ctx);
+		}
+	}
+	spin_unlock(&smmu->debugfs->stream_lock);
+}
+
 /**
  * arm_smmu_debugfs_setup() - Initialize debugfs for SMMU device
  * @smmu: SMMU device to setup debugfs for
@@ -201,6 +421,8 @@ int arm_smmu_debugfs_setup(struct arm_smmu_device *smmu, const char *name)
 	}
 
 	debugfs->smmu_dir = smmu_dir;
+	INIT_LIST_HEAD(&debugfs->stream_list);
+	spin_lock_init(&debugfs->stream_lock);
 	smmu->debugfs = debugfs;
 
 	/* Create capabilities file */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index cbb3fccc501b..6be132b2f3f0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2654,7 +2654,10 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
 	return 0;
 }
 
-static struct arm_smmu_ste *
+#ifndef CONFIG_ARM_SMMU_V3_DEBUGFS
+static
+#endif
+struct arm_smmu_ste *
 arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
 {
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
@@ -3489,7 +3492,10 @@ struct arm_smmu_device *arm_smmu_get_by_fwnode(struct fwnode_handle *fwnode)
 	return dev ? dev_get_drvdata(dev) : NULL;
 }
 
-static bool arm_smmu_sid_in_range(struct arm_smmu_device *smmu, u32 sid)
+#ifndef CONFIG_ARM_SMMU_V3_DEBUGFS
+static
+#endif
+bool arm_smmu_sid_in_range(struct arm_smmu_device *smmu, u32 sid)
 {
 	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
 		return arm_smmu_strtab_l1_idx(sid) < smmu->strtab_cfg.l2.num_l1_ents;
@@ -3635,6 +3641,10 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 		pci_prepare_ats(to_pci_dev(dev), stu);
 	}
 
+#ifdef CONFIG_ARM_SMMU_V3_DEBUGFS
+	arm_smmu_debugfs_create_stream_table(dev, smmu);
+#endif
+
 	return &smmu->iommu;
 
 err_free_master:
@@ -3648,10 +3658,14 @@ static void arm_smmu_release_device(struct device *dev)
 
 	WARN_ON(master->iopf_refcount);
 
+#ifdef CONFIG_ARM_SMMU_V3_DEBUGFS
+	arm_smmu_debugfs_remove_stream_table(dev, master->smmu);
+#endif
 	arm_smmu_disable_pasid(master);
 	arm_smmu_remove_master(master);
 	if (arm_smmu_cdtab_allocated(&master->cd_table))
 		arm_smmu_free_cd_tables(master);
+
 	kfree(master);
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index a54d72fb9e07..d9ea803a2e4e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -734,13 +734,30 @@ struct arm_smmu_impl_ops {
 };
 
 #ifdef CONFIG_ARM_SMMU_V3_DEBUGFS
+struct ste_context {
+	struct arm_smmu_master		*master;
+	u32				sid;
+	struct list_head		node;
+};
+
 struct arm_smmu_debugfs {
+	struct list_head		stream_list;
+	spinlock_t			stream_lock;
 	struct dentry			*smmu_dir;
+	struct dentry			*stream_dir;
 	/* Reserved for future extensions */
 };
 
 int arm_smmu_debugfs_setup(struct arm_smmu_device *smmu, const char *name);
 void arm_smmu_debugfs_remove(struct arm_smmu_device *smmu);
+int arm_smmu_debugfs_create_stream_table(struct device *dev,
+					 struct arm_smmu_device *smmu);
+void arm_smmu_debugfs_remove_stream_table(struct device *dev,
+					  struct arm_smmu_device *smmu);
+
+struct arm_smmu_ste *
+arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid);
+bool arm_smmu_sid_in_range(struct arm_smmu_device *smmu, u32 sid);
 #endif
 
 /* An SMMUv3 instance */
-- 
2.33.0

