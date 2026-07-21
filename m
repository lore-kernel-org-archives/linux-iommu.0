Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010063.outbound.protection.outlook.com [40.93.198.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FE5470426
	for <iommu@lists.linux.dev>; Tue, 21 Jul 2026 19:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784663350; cv=fail; b=U4k3xs6n/r5jiUOVsRk/zvWCO9IWiEjiKnQ0QHVW+4yD2YEKSVYrsl/sllIlkfX7t5Ogppw068WwaLlhxsnMDD47xx+ykcaqBMjMOoX3WZww9NfIn5fY0fADoZ/QTybwizi3h/HTiRfvklnV4dvSR0Kpr9NkKDpvidIBiRrPOQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784663350; c=relaxed/simple;
	bh=Rs7DvUeGH7QMmpEDpD8+3Hv4FOSEKNfgTAi+cEEcdHU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FoWKWmLwKP6QZ4WfH2aBx0W28SSNIdIazDFHqxz3zTvI+2vLbzG33cigfbHPSliiFrUXhsVTP91EU1XXCg0G/dh+b3P+H+ye7JGoyEpSmZLQ4IHJ8rYhzImRChUAJuNuohXWcLJT6r+cpX1JW9rcQ+2xROEyRUk8U/u2TuS7TYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YleU4jbM; arc=fail smtp.client-ip=40.93.198.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YleU4jbM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ScXZ/0cNwxMYCMYCDET8Tz2EArXaH/8aMHaFzG1Bo6YJPrkm9lMwvlWV8g/KkO49VYKLLa21lpuijnCIInsYM6AA0t1QKt2W9d4ywgPjgGERCJqGB3VTGscu0hpkLMlAQq1PsZZSG/mO+zi3YonLVLnQoe1Z8X4wdHfFdTbW44QhumuWKclDBkIrrKE1JdOlWJWNf2+gXqnlnktcBG3vK//oDoie0YVrAbPVWnXTHKyMUZWm5ftGbPXRkz9H95H+ta4IyD+pYXEMNVS1nVvMv4ay8eok6N3HUDSikEiRFQGP/j/NjqIeAZzygKQ2anPUsos3H1UolrEZ/Uuo6lt4eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aG2TJvRvZPJ8B/BBpe3JwiMLSypwzwR6aIG99oBYahY=;
 b=D5KkPaPh728bz7FaAlAF5O7YtOOU4ov15P0nDDql7MzuY3I+WVXf4SG1NoPcsob2gjPLmbPI8S+7V4m3t6mbbD5biRin0oGkWWxYZPEJ7LAddnA9YoJqPyIXaDVVwlbBtEIqmJj9seSzsLTPdUvTQzzMKPf7Y3wl+8HfXq+G2ZIdaX8emenYhU8uxNKnGFkewuf0CdsQMQkK7oqW7UONY5hRN+ADaFvKDHF6mDnURqzzvjIPoAU859KWzy1DkXS0Tx+5JMZlGi4benE/+C482/gRdqWffmQKXK8/OirUCgLuLSYBRs0/O058YQwmS6XNvzC4HcbMlJFTUsKLXSdxaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aG2TJvRvZPJ8B/BBpe3JwiMLSypwzwR6aIG99oBYahY=;
 b=YleU4jbMliYQGmtpjheYspb2X6qEsomUluBg1phzPiOX5k6xjFDek1TcFSgOB7IZrEvEQJPtk34PXMVjcL677/g5B8QIqPULaqF+6wXkdmJnfvN86e7PG+JHIQcc+9yJQ1wZJHLo1Q700mZOaKaCog8f+FxNfgSOfTgpyAFavkagG4LpfifKtujuyRI5tVzw17b/if9dquuOEF3OO1ouJRDADNCafPD9z7RFc11jG9ZKCwL/8M/APJi2WLzisglwpmruWIxOTUGg5XKtw1DBEdf6unyBLP4U2vZo5E+6BlJdyS3uyD/Z1qIvSqoPN28Fl/6IOphJoAeEF/+8NlpWXw==
Received: from MW4PR04CA0138.namprd04.prod.outlook.com (2603:10b6:303:84::23)
 by LV8PR12MB9360.namprd12.prod.outlook.com (2603:10b6:408:205::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 19:49:01 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:303:84:cafe::a1) by MW4PR04CA0138.outlook.office365.com
 (2603:10b6:303:84::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 19:49:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.0 via Frontend Transport; Tue, 21 Jul 2026 19:49:00 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 21 Jul
 2026 12:48:38 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Jul
 2026 12:48:37 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 21 Jul 2026 12:48:37 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH v9 03/12] iommu/arm-smmu-v3: Add strtab parse helpers to a new arm-smmu-v3-kexec.c
Date: Tue, 21 Jul 2026 12:48:12 -0700
Message-ID: <c6a0e50e73989b48d3669bdb342027c612794cd4.1784663184.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1784663183.git.nicolinc@nvidia.com>
References: <cover.1784663183.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|LV8PR12MB9360:EE_
X-MS-Office365-Filtering-Correlation-Id: 64d995ed-4a05-46ef-823d-08dee7611c3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|5023799004|56012099006|11063799006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	C+J0pzNjg51OZvTFmiqvV5mewXoLOULbPjEzfYA/QphHhs2riwxTOCIZk5r869phCZxLQDzYciXt3wqwazIbnqjLChQVX+USCsDmUDZ7p1fpjct8dlpus3NNSs+LpB4hCrXxlys1tCT1KIhok82ER0w5OzwX9NQ6yqwTnCa79erKLVV7cT8vjNQaq+pvts1/88vyZMoWQJ5lmKIbM66njbSk0G1dN4CxN2hmUbep+YNBTAJgLc3BVYZSnrC2Qe7ayhK0bAAi3CCyP3e2t8KmQ/7ZZ9xsY00QbSoV057Rh6zVd8BwctNeCxyogqBDFKKnRds3f2yIO1+6OuEuVRR7K8rCZEutB1ZDtefj6kE+ijN1FJ9miwzaMfzrgWD45ACBmV+FuFeT6hKFiIWvOv95lmzDd9mAm4Bi6wwiqc1HsRlpReiVXA4GRmMrXR/Y3zXUxCgfAmdvaRQzxNxVLBtjC7t72Bswld5qpGWMgNJ8EIFk33rVmSTB7MbyntwheGaFQsp8E3/u7OcR+POVfINdVAiCbgi7KTqRw4Hv7zrXGcAkz/wAlwYpW4Tkht1azLaomoB82eU+9fLfbHpQKutJ4E1m5jRfxc57QNFmZaAvxpRN2EZX2DRrL7qZYsR7qyk9jyrpKERHN1BvzSwXRe57I+AkAF2Aa4JjByuJ8/2vvR3lpx4Zs3v6nc8ztTkWHdFJUgHKj+L5k/0uMl0/y+xO8Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(5023799004)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fRbbgYD4nqdWGJINoHkPMbD/bnl3p2hgO4T+G6iGhFabwiYqyBYeeiQP/ze30VctwuW92uzCXyQq6YUoiO2LbN7B3D0TA/+tR3TuL2+G5jTvUAo8ZT12nqFlgxal6l7s+Xv2f1AgQANTF8bisKb63ByVoJ1qTrZIoZm2Yr7zbjSZavRW0rH/A/2k39nYoD+qBWANAGj1xb2Dx7rbaUnyP6atBzh/Q20f/RuG7bITopAckK8kc/kGQ3wQnv5cD4ONks4sqf5IUlj+jet4anUNcvqsJBdnuclp1rGQ5QfUUqlsFOiohFHtkl5ZqxbNp4L14DcrCXni8XGmAAup9X2K4M9N17ftIkzobBY/IRx2t+su3y6qZsdNxhs95g6wfhvq5ls6MnmRJI8HAlZmugLIdbpJcRA4ndKcVNKB8H6ysA96up0/FFIPtm93NcTyT7V5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 19:49:00.3398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d995ed-4a05-46ef-823d-08dee7611c3b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9360

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
Assisted-by: Claude:claude-fable-5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/Kconfig                     |   4 +
 drivers/iommu/arm/arm-smmu-v3/Makefile        |   1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  11 ++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c | 159 ++++++++++++++++++
 4 files changed, 175 insertions(+)
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
index c909c9a88538b..d37492ff08fb3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1239,6 +1239,17 @@ tegra241_cmdqv_probe(struct arm_smmu_device *smmu)
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
index 0000000000000..5346132529427
--- /dev/null
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
@@ -0,0 +1,159 @@
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
+	num_ents = 1U << (log2size - split);
+	if (num_ents > STRTAB_MAX_L1_ENTRIES) {
+		dev_err(smmu->dev, "l1 entries %u exceeds max %u\n", num_ents,
+			STRTAB_MAX_L1_ENTRIES);
+		return -EINVAL;
+	}
+
+	size = num_ents * sizeof(struct arm_smmu_strtab_l1);
+	/*
+	 * HW aligns the base down to the L1 table size (min 64 bytes), so any
+	 * unaligned base would make this kernel read a different table.
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
+	 * HW aligns the base down to the table size, ignoring the low bits, so
+	 * an unaligned base would make this kernel read a different table.
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

