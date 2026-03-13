Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F6938F63B
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 10:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773398647; cv=none; b=Bkrwzo5XW/2GScTbydG9P/j0892yoWlm8+/3as76W07Eoeir8QKBzrGSa+XAMP2iE4HV+UTPJbIR3rnYw5UgibsiCTMyBQ5prUYZ0IaR7oM5suZL0xqQ+jOJP3VO7gTsCGbupwslkn/+hb2QiJ5hxLT9dI3S8LRwS+K9zxq+Mf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773398647; c=relaxed/simple;
	bh=mhRAHWaLn3sYr33SQcaYrpPP874id+Xxg26AdZrAIrk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bNShOtoXmkYHddNF9IWHBDcGH4vUlZSD77nn4dgGRB1xHK69Lke23aFaT37xu7zUap4wKC7F3f53plFkmiw1VTJWutT8FGN2LvKyTI5dg5Ghh7rkkW5RCWY2VPVRxzj4GTvCnvICRWOkrXJuwBMQST509jBcPUol+Q9tUsXAjag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=qqLGyyQj; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="qqLGyyQj"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=lcZZrXAdqn94ZnDjs/X+KlRU4FcdDdVAYMMtG10Pb8c=;
	b=qqLGyyQjUhrMc2GS64tIsSIUdZ2Qru97dJaSrN8+490ySt/R6QLsaAp07/9t9Nb/odHAQPdYI
	xG7nFFqBXWAp4NAttE+Wcl5cBjndGC25Av//Iy4V08b5omxSvc9TZDZguGJtmdANupeCoZBizsA
	ejcTysM3ZQbAEuKNIlly8Is=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fXLZK1JwXzRhQR;
	Fri, 13 Mar 2026 18:39:05 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id F00C840569;
	Fri, 13 Mar 2026 18:44:00 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 13 Mar 2026 18:44:00 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jpb@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<xiaqinxin@huawei.com>, <wangzhou1@hisilicon.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>,
	<jonathan.cameron@huawei.com>, <linuxarm@huawei.com>
Subject: [RFC PATCH 5/5] iommu/arm-smmu-v3: Add Context Descriptor display to debugfs
Date: Fri, 13 Mar 2026 18:43:51 +0800
Message-ID: <20260313104351.3502293-6-xiaqinxin@huawei.com>
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

Add Context Descriptor (CD) display functionality to debugfs.
This allow inspecting CD contents for all Substream IDs including:
- CD validity and translation parameters
- TTBR0 and TCR configurations
- Raw CD data

/sys/kernel/debug/iommu/arm_smmu_v3/smmu0/stream_table/
└── 0000:01:00.0:0/
    ├── ste
    └── context_descriptors/
        └── all

Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-debugfs.c     | 112 ++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c
index f62df02847ac..66ae1228c6ad 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-debugfs.c
@@ -27,6 +27,13 @@
  * - Context Pointers: Stage 1 and Stage 2 translation context addresses
  * - Raw Data: Complete 64-bit STE words in hexadecimal
  *
+ * CD Information Displayed:
+ * - Validity: Active state of the context descriptor
+ * - T0SZ: Input address space size configuration
+ * - EPD0/EPD1: Stage 1 translation enable flags
+ * - TTBR0: Stage 1 translation table base address
+ * - Raw Data: Complete CD structure in hexadecimal format
+ *
  * Directory Structure:
  * /sys/kernel/debug/iommu/arm_smmu_v3/
  * └── smmu0/
@@ -35,6 +42,8 @@
  *     └── stream_table
  *	   └── 0000:01:00.0:0/                    # PCI device with Stream ID 0
  *             ├── ste                           # Stream Table Entry
+ *             └── context_descriptors/
+ *                 └── all                       # All Context Descriptors
  *
  * The capabilities file provides detailed information about:
  * - Architecture version and translation stage support (Stage1/Stage2)
@@ -59,6 +68,8 @@
 static struct dentry *smmuv3_root_dir;
 static DEFINE_MUTEX(arm_smmu_debugfs_lock);
 
+#define MAX_SSIDS	32	/* Reasonable limit for SSID enumeration */
+
 /**
  * smmu_debugfs_capabilities_show() - Display SMMU capabilities
  * @seq: seq_file to write to
@@ -329,6 +340,90 @@ static int smmu_debugfs_ste_show(struct seq_file *seq, void *v)
 }
 DEFINE_SHOW_ATTRIBUTE(smmu_debugfs_ste);
 
+/**
+ * smmu_debug_dump_cd() - Dump Context Descriptor details to seq_file
+ * @seq: seq_file to write to
+ * @dev: device associated with the CD
+ * @ssid: Substream ID
+ */
+static void smmu_debug_dump_cd(struct seq_file *seq, struct device *dev, u32 ssid)
+{
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_cd *cd;
+	u64 data;
+	int i;
+
+	if (!master) {
+		seq_puts(seq, "No master data\n");
+		return;
+	}
+
+	cd = arm_smmu_get_cd_ptr(master, ssid);
+	if (!cd) {
+		seq_printf(seq, "CD not available for SSID %u\n", ssid);
+		return;
+	}
+
+	seq_printf(seq, "CD for Substream ID %u:\n", ssid);
+
+	/* CD 0 */
+	data = le64_to_cpu(cd->data[0]);
+	seq_printf(seq, "  Valid: %s\n", data & CTXDESC_CD_0_V ? "Yes" : "No");
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
+/**
+ * smmu_debug_dump_all_cds() - Dump all valid Context Descriptors for a device
+ * @seq: seq_file to write to
+ * @dev: target device
+ */
+static void smmu_debug_dump_all_cds(struct seq_file *seq, struct device *dev)
+{
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	u32 max_ssids, ssid;
+
+	if (!master) {
+		seq_puts(seq, "No master data\n");
+		return;
+	}
+
+	max_ssids = min_t(u32, 1 << master->ssid_bits, MAX_SSIDS);
+
+	seq_printf(seq, "Context Descriptors for device (max SSIDs: %u):\n",
+		   max_ssids);
+
+	for (ssid = 0; ssid < max_ssids; ssid++) {
+		struct arm_smmu_cd *cd = arm_smmu_get_cd_ptr(master, ssid);
+
+		if (cd && (le64_to_cpu(cd->data[0]) & CTXDESC_CD_0_V)) {
+			seq_printf(seq, "\n--- SSID %u ---\n", ssid);
+			smmu_debug_dump_cd(seq, dev, ssid);
+		}
+	}
+}
+
+/* All CDs debugfs file operations */
+static int smmu_debugfs_all_cds_show(struct seq_file *seq, void *v)
+{
+	struct device *dev = seq->private;
+
+	smmu_debug_dump_all_cds(seq, dev);
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(smmu_debugfs_all_cds);
+
 /**
  * smmu_debugfs_create_stream_table() - Create debugfs entries for stream table
  * @dev: device to create entries for
@@ -388,9 +483,26 @@ int smmu_debugfs_create_stream_table(struct device *dev,
 			goto cleanup_dev;
 		}
 
+		/* Create CD directory */
+		cd_dir = debugfs_create_dir("context_descriptors", dev_dir);
+		if (!cd_dir) {
+			ret = -ENOMEM;
+			goto cleanup_dev;
+		}
+
+		/* Create "all" file to show all valid CDs */
+		all_cds_file = debugfs_create_file("all", 0444, cd_dir, dev,
+						   &smmu_debugfs_all_cds_fops);
+		if (!all_cds_file) {
+			ret = -ENOMEM;
+			goto cleanup_cd;
+		}
+
 		/* Success for this stream ID, continue to next */
 		continue;
 
+cleanup_cd:
+		debugfs_remove(cd_dir);
 cleanup_dev:
 		debugfs_remove_recursive(dev_dir);
 cleanup:
-- 
2.33.0

