Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C360C38E12B
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 10:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773398646; cv=none; b=ebykEC/WRsh2Nwtfqk51ho6FgJ8NIYkBL9Bgv4wZyWKFjodL/5xWr2YBop5tqBbbZ39ClWJYHbf49DW4mo0IT2+QOSsB8aSZmMZiDEfpFuGBfeq8NfW9HH7fOeAPnCsVwZKgdHNOJpAMBskokrwdhhmOUGPqvpzijGA0sG88G/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773398646; c=relaxed/simple;
	bh=A+mLGQFuPzH7+V/HgD4m3DwlTwztL5K5Mn6iX8AV+1s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cIWiPFQ0zlsT0u7JxnD5ivX09kwnlUpfoFQYv66veRjyLhLsUK3rm2JSHYJUqAocN5M3FZwG/6564WECpG1Qg03wRUv6s9QiKPmDOAZ5Xx+aHGLLtqZPfVs7U4U6l46I9hiJxpCLE+miB2jc6Js3+dbSIXj52UKBz+z/tnXa+Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=zTq7r9i5; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="zTq7r9i5"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=6JlJWXnd6PSGJ0PQ4pykXiKEa6QH+dIPCA/i7m77POk=;
	b=zTq7r9i5Gt9fIM4K9vtKMj/Q7zPheJCNBa58zp3uvy6oFJxBqA9OoNOKRdQ06QDv/PixfjREM
	iFZfYon2Sbu+J01j4tlBtieqLuJIjQ/HLytHq2GruBao6uJtDBT1mWggE7cuKYXIPZCvNEKB5p7
	RdeqCGLc6aopIMHv80v2zCo=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4fXLZK54JPz1K97Z;
	Fri, 13 Mar 2026 18:39:05 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id ED5EB40563;
	Fri, 13 Mar 2026 18:43:59 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 13 Mar 2026 18:43:59 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jpb@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<xiaqinxin@huawei.com>, <wangzhou1@hisilicon.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>,
	<jonathan.cameron@huawei.com>, <linuxarm@huawei.com>
Subject: [RFC PATCH 4/5] iommu/arm-smmu-v3: Add stream table directory structure to debugfs
Date: Fri, 13 Mar 2026 18:43:50 +0800
Message-ID: <20260313104351.3502293-5-xiaqinxin@huawei.com>
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

Add stream table directory structure creation to debugfs
This organizes debugfs entries by device and stream ID:

/sys/kernel/debug/iommu/arm_smmu_v3/smmu0/stream_table/
└── 0000:01:00.0:0/
    └─── ste

Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-debugfs.c     | 80 ++++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  3 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  4 +
 3 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c
index d7f3defd94a3..f62df02847ac 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c
@@ -31,7 +31,10 @@
  * /sys/kernel/debug/iommu/arm_smmu_v3/
  * └── smmu0/
  *     ├── capabilities    # SMMU feature capabilities and configuration
- *     └── registers	   # SMMU Key registers
+ *     ├── registers	   # SMMU Key registers
+ *     └── stream_table
+ *	   └── 0000:01:00.0:0/                    # PCI device with Stream ID 0
+ *             ├── ste                           # Stream Table Entry
  *
  * The capabilities file provides detailed information about:
  * - Architecture version and translation stage support (Stage1/Stage2)
@@ -324,5 +327,78 @@ static int smmu_debugfs_ste_show(struct seq_file *seq, void *v)
 	smmu_debug_dump_ste(seq, dev);
 	return 0;
 }
-
 DEFINE_SHOW_ATTRIBUTE(smmu_debugfs_ste);
+
+/**
+ * smmu_debugfs_create_stream_table() - Create debugfs entries for stream table
+ * @dev: device to create entries for
+ * @smmu: SMMU device
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int smmu_debugfs_create_stream_table(struct device *dev,
+				     struct arm_smmu_device *smmu)
+{
+	struct dentry *stream_dir, *cd_dir, *dev_dir;
+	struct dentry *ste_file, *all_cds_file;
+	struct iommu_fwspec *fwspec;
+	char name[64];
+	int i, ret = 0;
+
+	if (!smmu->debugfs->stream_dir) {
+		stream_dir = debugfs_create_dir("stream_table",
+						smmu->debugfs->smmu_dir);
+		if (!stream_dir)
+			return -ENOMEM;
+		smmu->debugfs->stream_dir = stream_dir;
+	} else {
+		stream_dir = smmu->debugfs->stream_dir;
+	}
+
+	fwspec = dev_iommu_fwspec_get(dev);
+	if (!fwspec)
+		return -ENODEV;
+
+	for (i = 0; i < fwspec->num_ids; i++) {
+		u32 sid = fwspec->ids[i];
+
+		if (dev_is_pci(dev)) {
+			struct pci_dev *pdev = to_pci_dev(dev);
+
+			snprintf(name, sizeof(name), "%04x:%02x:%02x.%d:%u",
+				 pci_domain_nr(pdev->bus), pdev->bus->number,
+				 PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn),
+				 sid);
+		} else {
+			snprintf(name, sizeof(name), "%s:%u", dev_name(dev),
+				 sid);
+		}
+
+		dev_dir = debugfs_create_dir(name, stream_dir);
+		if (!dev_dir) {
+			ret = -ENOMEM;
+			goto cleanup;
+		}
+
+		/* Create STE file */
+		ste_file = debugfs_create_file("ste", 0444, dev_dir, dev,
+					       &smmu_debugfs_ste_fops);
+		if (!ste_file) {
+			ret = -ENOMEM;
+			goto cleanup_dev;
+		}
+
+		/* Success for this stream ID, continue to next */
+		continue;
+
+cleanup_dev:
+		debugfs_remove_recursive(dev_dir);
+cleanup:
+		if (ret) {
+			debugfs_remove_recursive(stream_dir);
+			break;
+		}
+	}
+
+	return ret;
+}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 211a0c87507a..c57897e5f644 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3133,6 +3133,9 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev,
 
 	arm_smmu_attach_commit(&state);
 	mutex_unlock(&arm_smmu_asid_lock);
+#ifdef CONFIG_ARM_SMMU_V3_DEBUGFS
+	smmu_debugfs_create_stream_table(dev, smmu);
+#endif
 	return 0;
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 247f27426f6b..e9cd24c1ab3c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -737,9 +737,13 @@ struct arm_smmu_impl_ops {
 struct arm_smmu_debugfs {
 	struct dentry *root_dir;
 	struct dentry *smmu_dir;
+	struct dentry *stream_dir;
 	struct arm_smmu_device *smmu;
 };
+
 int arm_smmu_debugfs_setup(struct arm_smmu_device *smmu, phys_addr_t ioaddr);
+int smmu_debugfs_create_stream_table(struct device *dev,
+					struct arm_smmu_device *smmu);
 #endif
 
 /* An SMMUv3 instance */
-- 
2.33.0

