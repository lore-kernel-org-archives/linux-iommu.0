Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013044.outbound.protection.outlook.com [40.93.196.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1834B35836E
	for <iommu@lists.linux.dev>; Sun, 30 Aug 2026 23:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788131943; cv=fail; b=P2Ud9nJdc8a5zCQTX/H6aCbJOjCm2QZyUkAwa1lFVic5jffSMvVkKfcDLaExPxOrs5nLjN67GwNYcVA1ZELO7d99Pn67cTrlDJhXLmhbiy5C7vkwGKibN8RPWmxPerrWqdy5liwV/cVNyfHeWkvnmIPgp1kjThUUj31aeK7drh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788131943; c=relaxed/simple;
	bh=PyA4Scc/WW3DuV4gzmJYHhZMmkXcxNF4y8ZNFpxSskM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tLOP6jO4GOyw1dpm+l29eoPKLoIv7Nc7K1NlM5Cq3exbItSpOxBxU/m0seCjmPevHZ1o+jHVleFP4mUCSb4ARYi0f0Drgz54KGnyy1/sTjpc+1/LB06mwDIP62DiipIcSh8S+abj4jLC95wqskczlP5Yj1rG7Ij97axkE3MZfxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kxBasZvp; arc=fail smtp.client-ip=40.93.196.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kxBasZvp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SHOM+/jvDpYGV0wsnD4ptYZSnfr80j0NmRk+5D2dh0/mR46PcmNJgJQMlYacA8Ax8iNfWxtTP7zDrIYRqaggwfUh/Z/Mq052hEVA2d1fKb7eOGjj/w5Ygwso5M8c7tJZo5P4E2sVcvn9VePUL+y3vlVeeBwZxICXTsTgc0QK2ZDQ8C4wUINcdrmvWqnXDrgiYt0y3hJjXeQSKFuTOrpKydo8ojkdR9VNvJOEfxy/aORqS8c5KIKvmoWNSqshQpLiV3aGEllP376kSr6Wote0LzPeMsmQ2vUAX3qu8vTxJ/Xag29x0MEaqaB5Qmr5DWBQTHCo+8zJRj4rJs515GmIMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82Q1gLRTbcJ4tT1d8XLW9YLJyU9MoCWge0+52qY1CDI=;
 b=BwQd+WjtvDHgNc6rqRSXdziCYWPWhWKkanaZMwyxgeRKACDUCoczNztHyilkJoqnE/K4xfVitf3hBJAMcP7QlqZ8mMkhGei8nC2NYBM3nWAxcaHxjKdB2cZ+51QH9Tdi+4VV4sLfT33H+j5m37J+D46sdrahRzMlDyBZgRN6KLUZE4qVrZKNFtdGFsZ4OBkilQLQ/uu0Xo/JMtwBW/ZqT+Uw5G7Jz0gqRBTLLZA2sFJ94aVHC2q+Ql4D8OJPYeUp2bsW1dfN+YQ+BvNhuNKNPMM+sC07zrvcVNUDvMRzy8cvVJJxLCkaBUJxFdUVuKfag2LMq+muWpFHhKEQXNgByw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82Q1gLRTbcJ4tT1d8XLW9YLJyU9MoCWge0+52qY1CDI=;
 b=kxBasZvpYv/Q6Y+NB35FOybfl6AuY5dYu/VpkVrTfe4fgw01AGIxqGJ4erB+4J5Xba+0HQAq1C028oElYjjfGkX4Ef/jb8s7/KB8/yp09mr5d7AlUf4GLj7eKZtN8KJIf2hKp4outU4/r3kcvsmmbfmhKIYXi+KnwfVdzM5wk8e45WCEisb+L7Dr0WpVQqyngsHMKJi3xFGgY9GTGPuiCiNTINrfAEK+TqqI9dpK+OcDv4JUuXBcVeLd3DiuWVK3AH2cdSv8PvP0gBzjnZGTYDy5xitsNHNpMqbplKdDka6Kg8ES0t1r/aVugsByILi1z47d0tSQEOrV/QntLjsiIw==
Received: from DS7P220CA0097.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25a::6) by
 DM4PR12MB8450.namprd12.prod.outlook.com (2603:10b6:8:188::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Sun, 30 Aug 2026 23:18:46 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:8:25a:cafe::83) by DS7P220CA0097.outlook.office365.com
 (2603:10b6:8:25a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Sun,
 30 Aug 2026 23:18:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Sun, 30 Aug 2026 23:18:46 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 30 Aug
 2026 16:18:36 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 30 Aug 2026 16:18:35 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Sun, 30 Aug 2026 16:18:35 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>,
	<kas@kernel.org>
Subject: [PATCH v10 05/13] iommu/arm-smmu-v3: Add strtab parse helpers to a new arm-smmu-v3-kexec.c
Date: Sun, 30 Aug 2026 16:18:06 -0700
Message-ID: <c7c7a4246654e29d5323339fb592d3c1b98e0f3f.1788130528.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788130528.git.nicolinc@nvidia.com>
References: <cover.1788130528.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|DM4PR12MB8450:EE_
X-MS-Office365-Filtering-Correlation-Id: 9623860b-f54d-4848-63aa-08df06ed0a91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|36860700016|82310400026|56012099006|10067099003|11063799006|5023799004|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	UeQyNBbdkG9OvWeaCVzEFMSOd0bc4rz6Zgtg8rUdTmNQJYN+sne35Pzr1Dv5aqIAKPoYtshzuEck1CN6SHl8V1kbbLdjDs58qfHtF9SlSN8rd8TCjRgc8wlQiL3VAWf8rWhDztJDI+MxbRg5lEEJnTZrlcPg2LJMe2sMEID0fcZCgIezTiXPVuDwzw63TEIU/+Z9Oj0j9VPwsu3VVE1XHaNGfz/xZWmKwQIvD8HDGN9f3YC/1UtvMgLovKrwTwx3EbbT+U2gzuGvhvPfFlyaznWe8cTXCU8AiKLcFF5F6JpBwpeCDM/+8ydELmLKRo/kJlqcGNh6LUMjHYvznGM9GHqypBKraBTd+BXGBoHOjnXL35+WCzcJ8gmoIUoQ0ER2/JXaS3ZtEdV2Xo2ma2Y6xPigsVP8hdBJ7yxNwWnw/mIdRVUNHEzS+srKCjM7egDh13xZebMbXx52TGJ/PvPDR/DRiwzD1LwZvex6SlaYclwsfqNfn6Bsddo6+YlRT6cE+1VgWHMbzJ3Jwb6+2jaMAVkg2oOq3N3j1yd/wDtpCHd4IOnZw/qsHQZSBhnOA7jOX39SZ3/PrP8RLCsj+8vV8btg2djVpvInUL+tMSLPTXadWSnTPEefKbi+KIm9Vl/fCR3G/0CuasxtbIEeVEDShytGhOa1yxJU0ls8zEyb9d8Ed0NoUqRJVcgv42Ii7DeVzScEDWGBWmmgLePHv1AzxA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(36860700016)(82310400026)(56012099006)(10067099003)(11063799006)(5023799004)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cYWql1DZ+KY1bIkvni6AQat6oz+7dSJtAJHqUwMNt6izXm7XXsYvW5Y2cI4Atd3LaoXK0YA5g+pXs+r+gx1hLmVgPSy458k6FeYp9piZbP04VP0lU83Vz39eu8CLlci5CCHMU534eiRfq83gIR7K7G40tFkUIAXDuSdAIT9nYPkSH5Bo1a7JFIedNBs8TIahgkZI241zb+9Pk4wFk5aRD2o+1vmD13KUKHv0mEZDf2O1G2SkSqOV3ikNt59GEee94i99w6CvvkJ54nHckDPjNpK4ThPyykf67csLr+5yPbgSbUsCSErJPeKcJd0kLo9XxA+1vsjdIykpg31ruB0uqd+gUeMrTWpq09nAICOFsSPIOAdkFeqJjI/yZYNt+yZHFezUKCGavJxIAx7heYfO4BIgxPL7vptZEuQJWVmI0JRXq5GcKJiA69RUSGfZm9vS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 23:18:46.2865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9623860b-f54d-4848-63aa-08df06ed0a91
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8450

When booting after a kexec, both the kdump adoption and also the in-flight
SMMUv3 live-update restoration built on the Kexec Handover (KHO) framework
need to parse the previous kernel's STRTAB_BASE/STRTAB_BASE_CFG registers,
in order to retain the stream table translating any in-flight DMAs.

Add a new arm-smmu-v3-kexec.c holding the common read-only helpers:
 - arm_smmu_kexec_parse_strtab_2lvl()
 - arm_smmu_kexec_parse_strtab_linear()
 - arm_smmu_kexec_check_strtab_l1_desc()

These helpers only validate the previous kernel's values against this very
kernel's own limits, taking no ownership of the tables: a kdump kernel will
adopt the tables via memremaps, while a live-update kernel will claim them
using the KHO restore API.

Build this new file under a hidden ARM_SMMU_V3_KEXEC Kconfig symbol, which
is, for now, merely a CRASH_DUMP. Then, the coming live-update series would
need to append its own user to this symbol, e.g. "|| IOMMU_LIVEUPDATE".

Suggested-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Assisted-by: Claude:claude-fable-5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/Kconfig                     |   4 +
 drivers/iommu/arm/arm-smmu-v3/Makefile        |   1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  11 ++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c | 166 ++++++++++++++++++
 4 files changed, 182 insertions(+)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c

diff --git a/drivers/iommu/arm/Kconfig b/drivers/iommu/arm/Kconfig
index 5fac08b89deea..04b05d49abf76 100644
--- a/drivers/iommu/arm/Kconfig
+++ b/drivers/iommu/arm/Kconfig
@@ -109,6 +109,10 @@ config ARM_SMMU_V3_IOMMUFD
 
 	  Say Y here if you are doing development and testing on this feature.
 
+# Common helpers for a kexec'd kernel, e.g. kdump adoption and live update
+config ARM_SMMU_V3_KEXEC
+	def_bool CRASH_DUMP
+
 config ARM_SMMU_V3_KUNIT_TEST
 	tristate "KUnit tests for arm-smmu-v3 driver"  if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/drivers/iommu/arm/arm-smmu-v3/Makefile b/drivers/iommu/arm/arm-smmu-v3/Makefile
index 493a659cc66bb..89a27de8dd2f0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/Makefile
+++ b/drivers/iommu/arm/arm-smmu-v3/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_ARM_SMMU_V3) += arm_smmu_v3.o
 arm_smmu_v3-y := arm-smmu-v3.o
 arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_IOMMUFD) += arm-smmu-v3-iommufd.o
 arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_SVA) += arm-smmu-v3-sva.o
+arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_KEXEC) += arm-smmu-v3-kexec.o
 arm_smmu_v3-$(CONFIG_TEGRA241_CMDQV) += tegra241-cmdqv.o
 
 obj-$(CONFIG_ARM_SMMU_V3_KUNIT_TEST) += arm-smmu-v3-test.o
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 75e768b3d66d8..dd71d758defd3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1251,6 +1251,17 @@ tegra241_cmdqv_probe(struct arm_smmu_device *smmu)
 }
 #endif /* CONFIG_TEGRA241_CMDQV */
 
+#ifdef CONFIG_ARM_SMMU_V3_KEXEC
+int arm_smmu_kexec_parse_strtab_2lvl(struct arm_smmu_device *smmu, u32 cfg_reg,
+				     phys_addr_t base, u32 *num_l1_ents);
+int arm_smmu_kexec_parse_strtab_linear(struct arm_smmu_device *smmu,
+				       u32 cfg_reg, phys_addr_t base,
+				       u32 *num_ents);
+int arm_smmu_kexec_check_strtab_l1_desc(struct arm_smmu_device *smmu,
+					u64 l1_desc, u32 idx,
+					phys_addr_t *l2_base);
+#endif /* CONFIG_ARM_SMMU_V3_KEXEC */
+
 struct arm_vsmmu {
 	struct iommufd_viommu core;
 	struct arm_smmu_device *smmu;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
new file mode 100644
index 0000000000000..b15e23df11b6d
--- /dev/null
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Common helpers for a kexec'd kernel to parse, validate, and walk through the
+ * previous kernel's SMMU table structures, shared by the kdump adoption and a
+ * future live-update restoration.
+ *
+ * All of the helpers are read-only against the previous kernel's structures: a
+ * table that is not yet mapped by this kernel gets a transient memremap during
+ * a walk, followed by an immediate memunmap. They never allocate memory or take
+ * ownership of the previous kernel's tables; the callers make those decisions.
+ */
+
+#include <linux/io.h>
+
+#include "arm-smmu-v3.h"
+
+/**
+ * arm_smmu_kexec_parse_strtab_2lvl() - Validate a 2-level stream table
+ * @smmu: SMMU device of this kernel
+ * @cfg_reg: STRTAB_BASE_CFG register value set by the previous kernel
+ * @base: stream table base address extracted from the STRTAB_BASE register
+ * @num_l1_ents: pointer to return the number of L1 entries
+ *
+ * Validate the 2-level stream table geometry in @cfg_reg and @base's alignment
+ * against this kernel's hardware limits.
+ *
+ * Return: 0 on success with @num_l1_ents set, or -EINVAL on a bad geometry
+ */
+int arm_smmu_kexec_parse_strtab_2lvl(struct arm_smmu_device *smmu, u32 cfg_reg,
+				     phys_addr_t base, u32 *num_l1_ents)
+{
+	u32 log2size = FIELD_GET(STRTAB_BASE_CFG_LOG2SIZE, cfg_reg);
+	u32 split = FIELD_GET(STRTAB_BASE_CFG_SPLIT, cfg_reg);
+	u32 num_ents;
+	size_t size;
+
+	if (log2size < split || log2size > smmu->sid_bits) {
+		dev_err(smmu->dev, "log2size %u out of range [%u, %u]\n",
+			log2size, split, smmu->sid_bits);
+		return -EINVAL;
+	}
+	if (split != STRTAB_SPLIT) {
+		dev_err(smmu->dev,
+			"unsupported STRTAB_SPLIT %u (expected %u)\n", split,
+			STRTAB_SPLIT);
+		return -EINVAL;
+	}
+
+	/*
+	 * Bound the entry count before the shift, as a log2size wider than what
+	 * this kernel itself supports would overflow it.
+	 */
+	if (log2size - split > ilog2(STRTAB_MAX_L1_ENTRIES)) {
+		dev_err(smmu->dev, "l1 entries 2^%u exceeds max %u\n",
+			log2size - split, STRTAB_MAX_L1_ENTRIES);
+		return -EINVAL;
+	}
+
+	num_ents = 1U << (log2size - split);
+
+	size = num_ents * sizeof(struct arm_smmu_strtab_l1);
+	/*
+	 * According to spec (6.3.24), HW aligns the base down to the L1 table
+	 * size, i.e. min 64 bytes, so an unaligned base would make this kernel
+	 * read another table.
+	 */
+	if (!IS_ALIGNED(base, size)) {
+		dev_err(smmu->dev, "unaligned l1 stream table base %pa\n",
+			&base);
+		return -EINVAL;
+	}
+
+	*num_l1_ents = num_ents;
+	return 0;
+}
+
+/**
+ * arm_smmu_kexec_parse_strtab_linear() - Validate a linear stream table
+ * @smmu: SMMU device of this kernel
+ * @cfg_reg: STRTAB_BASE_CFG register value set by the previous kernel
+ * @base: stream table base address extracted from the STRTAB_BASE register
+ * @num_ents: pointer to return the number of STEs
+ *
+ * Validate the linear stream table geometry in @cfg_reg and @base's alignment
+ * against this kernel's own limits.
+ *
+ * Return: 0 on success with @num_ents set, or -EINVAL on a bad geometry
+ */
+int arm_smmu_kexec_parse_strtab_linear(struct arm_smmu_device *smmu,
+				       u32 cfg_reg, phys_addr_t base,
+				       u32 *num_ents)
+{
+	u32 log2size = FIELD_GET(STRTAB_BASE_CFG_LOG2SIZE, cfg_reg);
+	unsigned int max_log2size = smmu->sid_bits;
+	size_t size;
+
+	/* Cap the size at what this kernel itself would have allocated */
+	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
+		max_log2size = min_t(
+			unsigned int, max_log2size,
+			ilog2(STRTAB_MAX_L1_ENTRIES * STRTAB_NUM_L2_STES));
+
+	/* num_ents is limited to a u32, so cap log2size at 31 */
+	max_log2size = min(max_log2size, 31U);
+	if (log2size > max_log2size) {
+		dev_err(smmu->dev, "unsupported log2size %u (> %u)\n", log2size,
+			max_log2size);
+		return -EINVAL;
+	}
+
+	size = (1U << log2size) * sizeof(struct arm_smmu_ste);
+	/*
+	 * According to spec (6.3.24), HW aligns the base down to the table size
+	 * and ignores the low bits, so an unaligned base would make this kernel
+	 * read a different table.
+	 */
+	if (!IS_ALIGNED(base, size)) {
+		dev_err(smmu->dev, "unaligned stream table base %pa\n", &base);
+		return -EINVAL;
+	}
+
+	*num_ents = 1U << log2size;
+	return 0;
+}
+
+/**
+ * arm_smmu_kexec_check_strtab_l1_desc() - Check one stream table L1 descriptor
+ * @smmu: SMMU device of this kernel
+ * @l1_desc: L1 descriptor value from the previous kernel's stream table
+ * @idx: index of the L1 descriptor, for diagnostics
+ * @l2_base: pointer to return the L2 table's physical address
+ *
+ * Return: 1 if the descriptor is unused, 0 if it is valid with @l2_base set, or
+ * -EINVAL if it is malformed
+ */
+int arm_smmu_kexec_check_strtab_l1_desc(struct arm_smmu_device *smmu,
+					u64 l1_desc, u32 idx,
+					phys_addr_t *l2_base)
+{
+	phys_addr_t base = l1_desc & STRTAB_L1_DESC_L2PTR_MASK;
+	u32 span = FIELD_GET(STRTAB_L1_DESC_SPAN, l1_desc);
+
+	/* L1STD.L2Ptr is invalid */
+	if (!span)
+		return 1;
+
+	if (span != STRTAB_SPLIT + 1) {
+		dev_err(smmu->dev, "L1[%u] unsupported span %u (vs %u)\n", idx,
+			span, STRTAB_SPLIT + 1);
+		return -EINVAL;
+	}
+
+	/*
+	 * A valid descriptor never carries a null pointer. Also, HW aligns the
+	 * pointer down to the L2 table size, so an unaligned pointer would make
+	 * this kernel read a different table.
+	 */
+	if (!base || !IS_ALIGNED(base, sizeof(struct arm_smmu_strtab_l2))) {
+		dev_err(smmu->dev, "L1[%u] bad l2 table base %pa\n", idx,
+			&base);
+		return -EINVAL;
+	}
+
+	*l2_base = base;
+	return 0;
+}
-- 
2.43.0

