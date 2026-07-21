Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013009.outbound.protection.outlook.com [40.93.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B822471404
	for <iommu@lists.linux.dev>; Tue, 21 Jul 2026 19:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784663353; cv=fail; b=t4QRgV5cer8JstPoBAYmVEPzxwVhz6Mbktii6kyp4B3ieDFy/EirXYtKfZDMfIpyxCsxNyM7YlDghhDIaUsoOgQ5URkuoXuT+q8B4avSMLyyz0bzz9eujA5s+3nPBSzpPhOTtiJ+vDC+kF8uBZ4vrHXBjk4Jj/0N9qGp2FxRSo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784663353; c=relaxed/simple;
	bh=jDv7SO26W36epWHtdiP7mqa6kNhzzmk9zgj/AsJQvCk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CBJCfkpejFqpQsyd9EO4erntvStUI6dPxFVRNf5Cop0/tVsr+q0bcdjoP9F/m0ZTpuUfBCI+3LHTmju90R/wAYh1eqehicb82vse/HnDTIwQIaOEoBbRVQfnJ6fSx7m8X2fGQmX6+4XTlVZ6mQT9mY0a5VaKrKwsixpGBzrYxg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iw9hHmbz; arc=fail smtp.client-ip=40.93.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iw9hHmbz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=am+l1QLVrN2NjDTtMxf763MQ76rmH3gYO4FyFAz7LTGwIe8zO1zOY6sfluoXki7q6VHqqy/ZB0raQsWcHzO7MZ5tNoSBaOtyaPkDh2Een4/+4h8iZXOdFSqAvsSbhZDnEEf3reovLukMPHSPvwfUqKv95KrAumzf3LR5GKa5UXvzCYslJ2g4x6snMwCD4djyv5XCqNjol4l6xbHiIZhfCdjuVqzrX0aQMbSSyCQFxUEeXY45ly9eJhCJolkXFukveVSrjt5Rfy6v3WRQoXlGWHwjDKmCQ1gd+/MwdhjG7L96eXxUPAtKnFOrjGugEeM9mWcP5fNcH1q1v/Ja4vtJbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDqTOEeOxEoxHNaj3sN5TWxJkCnPsLl51DR2wI56fT0=;
 b=Tx4SXSDJfMibyheqsPN54hmTmmTa+tSP9+uvKKNUW8LREqAbnuNEkhTtjzgHJSVfOwLeeJu2iMFSenKlb9jb+UBQQdtcFf/w5qM+2RbvaU7GdRPvBg8UbJDTbYg/c8UKkyUSO41BFsSMSTUlJjZewXd/3/B4vg39g+bwr7TffqRZxuIgwCnJgkZsUwSMajIdae9sY0Zc4x+rkjHMzSRql4Jt9Gurb5nDld0noFrLmW9ApM6F+m/HUGmlW2wI/gTRoWDpU+RhHQark7NNdR2OvLI5nNxkAnLTYsAIMJ4tRyRgxEHH0fSyo/Dr0xN4BkYeN/R3xgpz1hCDvo7gIO8Aww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDqTOEeOxEoxHNaj3sN5TWxJkCnPsLl51DR2wI56fT0=;
 b=iw9hHmbzKJX2msg5UXElfa7wni1xGicBONNcWap/ZpvXcpyUM0QooD/CI8HgAGCC56cwpQGI6FS+wiMX0uM1Uu6yS1WGGVVf4nQ9jhzL291jlOB6DDF6VU1R7y0XY/BvuMtDLftqkT2E9fm+MtDR49fN3cRX3zBp9MsC+vGrvmgjOL3o6z0jX3hkxuIQ4aXNaD0gAwbgzj38MIo0LW5p7Kuxfc+xvdNjVVmBEU7QdIiB++v6vT2g3EpRAmitpnp6X0hi54lr4hpcVD8xa3HQVxeFn+I2YznNgZxn79u6fKMJ5zt1sgoDn23XOUbUvoOsaeFWUa58TzRlzCzXqCou7w==
Received: from PH8P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::33)
 by SJ2PR12MB8112.namprd12.prod.outlook.com (2603:10b6:a03:4f8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 19:49:04 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:510:2d7:cafe::2a) by PH8P222CA0022.outlook.office365.com
 (2603:10b6:510:2d7::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 19:49:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.0 via Frontend Transport; Tue, 21 Jul 2026 19:49:02 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 21 Jul
 2026 12:48:40 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Jul
 2026 12:48:39 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 21 Jul 2026 12:48:39 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH v9 05/12] iommu/arm-smmu-v3: Add ARM_SMMU_OPT_KDUMP_ADOPT for kdump kernel
Date: Tue, 21 Jul 2026 12:48:14 -0700
Message-ID: <6fbd503d7476f01455fb61d8d9dae6188ec1739f.1784663184.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|SJ2PR12MB8112:EE_
X-MS-Office365-Filtering-Correlation-Id: 09dad02e-2a3b-4aa5-ebc8-08dee7611dcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|5023799004|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Q8ejTCexLFTzuzIhbDyMwnqpkYjRY8d9uP3e+zBBWljorT3GvKDOtATUXOwTocYckQ7SdeAxo9uVnMNG01TTJj55bFaEC54gDyCjWy0PP5fG5ecrlpAqQFjxQJ/v27ZEkzXG3Frg/kzYkpEhViQAVASw2hC8vHi2OwjEdw1UbDiEsIoDvkOWoNWAN3T2oVpRcIU2ukLdHSjAOWXizIYYp1vz8klWqnKNZeDTIY9DqPSngH33QF3sMD1dl2QCF1WEi4nWdQxkgx9GbGK7IIoCw2edYGRA+0gfkxaaNBp48POElx5TeJgEkvwOYQnSe2luhe5kbHNVZEBvxcJy9/l7nUj7X5lNtBm3rszouC1nA1mfM0B6+dBN+APZuP7PcFORIieyRE4cCrIuDwksOYy2s28suZz92CAKvP3r/VS7NNc76GXnvuQP6xzjQVKorRsNyRpIPy5ahrbPcjnmQgRHyxvLLIZjyBlKpL+DHsy+HO5v1tx3xpaOnFNKb0nCdFfuHe81Ewy555bKDK970IWwAv4Z4KXzacMCKyRMD5AOtmYuYVMQmbEqlHnjyBPykkBzpJeIDADqdmTxOp/Y9mi+SLhmCll3QKplszcJzXbDeldYkG0amHfaW4tnNTYcUJCbprgMDdjkyNtD8h9I7SXqMvk6nRlbrrWgZT4A1qWORcPvJR2NMG/U/WCwnuiN5Yzn/34M2j4duOKP0yRDOPfKMg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(5023799004)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OF30FguaUVO9VAXK1nJuniIGqi0UJdL0kgnZkW14INFlrNKi70EhJwB+bpATlc0946kWV3lBTtPriYkKq7F9UKaCliTBvUrQ+bvgbk2LnA2nuN/VxmHpFm8nZGw4bdivHPEv+t8ylCqle2F2bKCSHBIYhfSiL4Zjm42nRS+bt9rQ2Prs2jTx2iVvOyP36MHMuAOY7ilMWg/UhrzHQCWUB0nrljVrLp1E/3PKIjYy+AwTg/i0dCyH11dQeVD7H2nlRfAQTFXZfeqP/P3hUIB+TKhZ84W/6TQGRiipwVAEWMJ9nW4EUgRue/UQJpaSlQHXoTh2TcIni3vZM5kBUdXzh+jbCjLoUh0hSE91BBZrP3fhKVt0RRYoHiZ7mLSgm2Bqt4eOG9FDE/OttpxtfVR7M85Q5Y/Z7IxGCFp/cRsfElpPOqOWRSUiwM/0oxVBAOfo
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 19:49:02.9613
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09dad02e-2a3b-4aa5-ebc8-08dee7611dcb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8112

When transitioning to a kdump kernel, the primary kernel might have crashed
while endpoint devices were actively bus-mastering DMA. Currently, the SMMU
driver aggressively resets the hardware during probe by clearing CR0_SMMUEN
and setting the Global Bypass Attribute (GBPA) to ABORT.

In a kdump scenario, this aggressive reset is highly destructive:
a) If GBPA is set to ABORT, in-flight DMA will be aborted, generating fatal
   PCIe AER or SErrors that may panic the kdump kernel
b) If GBPA is set to BYPASS, in-flight DMA targeting some IOVAs will bypass
   the SMMU and corrupt the physical memory at those 1:1 mapped IOVAs.

To safely absorb in-flight DMAs, a kdump kernel will have to leave SMMUEN=1
intact and avoid modifying STRTAB_BASE, allowing HW to continue translating
in-flight DMAs reusing the crashed kernel's page tables until the endpoint
device drivers probe and quiesce their respective hardware.

However, the ARM SMMUv3 architecture specification states that updating the
SMMU_STRTAB_BASE register while SMMUEN == 1 is UNPREDICTABLE or ignored.

This leaves a kdump kernel no choice but to adopt the stream table from the
crashed kernel.

Introduce ARM_SMMU_OPT_KDUMP_ADOPT and adopt functions memremapping all the
stream tables extracted from STRTAB_BASE and STRTAB_BASE_CFG. Add them in
a new arm-smmu-v3-kdump.c, which is only built when CONFIG_CRASH_DUMP=y.

Note that the adoption of the crashed kernel's stream table follows certain
strict rules, since the old stream table might be compromised. Thus, apply
some basic validations against the values read from the registers. If tests
fail, it means the stream table cannot be trusted, so toss it entirely. To
avoid OOM due to a potentially corrupted stream table, the memremap for l2
tables is done lazily on the kdump kernel's demand.

The new option will be set in a following change, once the device reset and
the RMR setup are reworked not to overwrite the adopted stream table, and
the crashed kernel's in-use ASIDs and VMIDs are reserved.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Assisted-by: Claude:claude-fable-5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/Makefile        |   1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  21 ++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c | 229 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  21 +-
 4 files changed, 269 insertions(+), 3 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c

diff --git a/drivers/iommu/arm/arm-smmu-v3/Makefile b/drivers/iommu/arm/arm-smmu-v3/Makefile
index 89a27de8dd2f0..2bc52473d960e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/Makefile
+++ b/drivers/iommu/arm/arm-smmu-v3/Makefile
@@ -4,6 +4,7 @@ arm_smmu_v3-y := arm-smmu-v3.o
 arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_IOMMUFD) += arm-smmu-v3-iommufd.o
 arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_SVA) += arm-smmu-v3-sva.o
 arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_KEXEC) += arm-smmu-v3-kexec.o
+arm_smmu_v3-$(CONFIG_CRASH_DUMP) += arm-smmu-v3-kdump.o
 arm_smmu_v3-$(CONFIG_TEGRA241_CMDQV) += tegra241-cmdqv.o
 
 obj-$(CONFIG_ARM_SMMU_V3_KUNIT_TEST) += arm-smmu-v3-test.o
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index d37492ff08fb3..6ef307335d80c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -928,6 +928,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_OPT_MSIPOLL		(1 << 2)
 #define ARM_SMMU_OPT_CMDQ_FORCE_SYNC	(1 << 3)
 #define ARM_SMMU_OPT_TEGRA241_CMDQV	(1 << 4)
+#define ARM_SMMU_OPT_KDUMP_ADOPT	(1 << 5)
 	u32				options;
 
 	struct arm_smmu_cmdq		cmdq;
@@ -1250,6 +1251,26 @@ int arm_smmu_kexec_check_strtab_l1_desc(struct arm_smmu_device *smmu,
 					phys_addr_t *l2_base);
 #endif /* CONFIG_ARM_SMMU_V3_KEXEC */
 
+#ifdef CONFIG_CRASH_DUMP
+int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu);
+int arm_smmu_kdump_adopt_deferred_l2_strtab(struct arm_smmu_device *smmu,
+					    u32 sid, phys_addr_t base, u32 span,
+					    struct arm_smmu_strtab_l2 **l2table);
+#else /* CONFIG_CRASH_DUMP */
+static inline int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int
+arm_smmu_kdump_adopt_deferred_l2_strtab(struct arm_smmu_device *smmu, u32 sid,
+					phys_addr_t base, u32 span,
+					struct arm_smmu_strtab_l2 **l2table)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_CRASH_DUMP */
+
 struct arm_vsmmu {
 	struct iommufd_viommu core;
 	struct arm_smmu_device *smmu;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c
new file mode 100644
index 0000000000000..a074d59ce3445
--- /dev/null
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Implementation of the kdump stream table adoption for ARM SMMUv3
+ *
+ * When the crashed kernel left the SMMU enabled with in-flight DMAs, the kdump
+ * kernel adopts the crashed kernel's stream tables, instead of doing a regular
+ * reset, to keep in-flight DMAs translating until the endpoint device drivers
+ * re-probe and quiesce their devices.
+ *
+ * Note:
+ *  - Adoption only starts on an SMMU that the crashed kernel left enabled, as a
+ *    disabled SMMU (CR0_SMMUEN=0) could hold meaningless register values.
+ *  - Values read from the crashed kernel's registers get structural validation
+ *    only (format, size, span, alignment, and ID range); the physical addresses
+ *    are not vetted, as the kdump kernel has no record of which pages held the
+ *    tables.
+ *  - A structural inconsistency at adoption time tosses the entire adoption and
+ *    makes the SMMU fall back to a full reset blocking in-flight DMAs.
+ *  - L2 stream tables are adopted lazily at master-inserting time, to bound the
+ *    peak memory use against a corrupted L1 table; any lazy L2 adoption failure
+ *    rejects that device alone, as its blast radius is bounded to the bus.
+ *  - Only a coherent SMMU (ARM_SMMU_FEAT_COHERENCY) is supported, as the stream
+ *    table adoption is done by memremap with MEMREMAP_WB, which is verified on
+ *    the real hardware. Callers of these functions are responsible for gating
+ *    ARM_SMMU_FEAT_COHERENCY once during the probe.
+ */
+
+#define dev_fmt(fmt) "kdump: " fmt
+
+#include <linux/io.h>
+#include <linux/slab.h>
+
+#include "arm-smmu-v3.h"
+
+int arm_smmu_kdump_adopt_deferred_l2_strtab(struct arm_smmu_device *smmu,
+					    u32 sid, phys_addr_t base, u32 span,
+					    struct arm_smmu_strtab_l2 **l2table)
+{
+	struct arm_smmu_strtab_l2 *table;
+	size_t size;
+
+	/*
+	 * Retest the span in case the L1 descriptor has been overwritten since
+	 * the adopt. Reject this master's insert; panic or SMMU-disable would
+	 * either lose the vmcore or cascade aborts. Do not try to fix it, as it
+	 * would break all other SIDs in the same bus (PCI case). The corruption
+	 * blast radius is already bounded to that bus range.
+	 */
+	if (span != STRTAB_SPLIT + 1) {
+		dev_err(smmu->dev,
+			"L1[%u] span %u changed since adopt (was %u)\n",
+			arm_smmu_strtab_l1_idx(sid), span, STRTAB_SPLIT + 1);
+		return -EINVAL;
+	}
+
+	size = (1UL << (span - 1)) * sizeof(struct arm_smmu_ste);
+
+	/* Same live-corruption check as the span; reject an overwritten base */
+	if (!base || !IS_ALIGNED(base, size)) {
+		dev_err(smmu->dev, "L1[%u] bad l2 table base %pa\n",
+			arm_smmu_strtab_l1_idx(sid), &base);
+		return -EINVAL;
+	}
+
+	/*
+	 * This L2 table is mapped lazily per master; devres frees it at unbind,
+	 * as with the dmam_alloc_coherent() used for a fresh L2.
+	 */
+	table = devm_memremap(smmu->dev, base, size, MEMREMAP_WB);
+	if (IS_ERR(table)) {
+		dev_err(smmu->dev,
+			"failed to adopt l2 stream table for SID %u\n", sid);
+		return PTR_ERR(table);
+	}
+
+	*l2table = table;
+	return 0;
+}
+
+static int arm_smmu_kdump_adopt_strtab_2lvl(struct arm_smmu_device *smmu,
+					    u32 cfg_reg, phys_addr_t base)
+{
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+	u32 num_l1_ents;
+	size_t size;
+	int ret, i;
+
+	ret = arm_smmu_kexec_parse_strtab_2lvl(smmu, cfg_reg, base,
+					       &num_l1_ents);
+	if (ret)
+		return ret;
+
+	cfg->l2.num_l1_ents = num_l1_ents;
+
+	size = num_l1_ents * sizeof(struct arm_smmu_strtab_l1);
+	cfg->l2.l1tab = memremap(base, size, MEMREMAP_WB);
+	if (!cfg->l2.l1tab)
+		return -ENOMEM;
+
+	cfg->l2.l2ptrs =
+		kcalloc(num_l1_ents, sizeof(*cfg->l2.l2ptrs), GFP_KERNEL);
+	if (!cfg->l2.l2ptrs)
+		return -ENOMEM;
+
+	for (i = 0; i < num_l1_ents; i++) {
+		u64 l2ptr = le64_to_cpu(cfg->l2.l1tab[i].l2ptr);
+		phys_addr_t l2_base;
+
+		ret = arm_smmu_kexec_check_strtab_l1_desc(smmu, l2ptr, i,
+							  &l2_base);
+		if (ret < 0)
+			return ret;
+
+		/*
+		 * If the crashed kernel's l1 descriptors are deeply corrupted,
+		 * blindly memremapping every l2 table here could lead to OOM.
+		 *
+		 * Defer the l2 memremap to arm_smmu_init_l2_strtab(), so peak
+		 * memory is bounded by the kdump kernel's actual demand.
+		 */
+	}
+
+	return 0;
+}
+
+static int arm_smmu_kdump_adopt_strtab_linear(struct arm_smmu_device *smmu,
+					      u32 cfg_reg, phys_addr_t base)
+{
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+	u32 num_ents;
+	size_t size;
+	int ret;
+
+	ret = arm_smmu_kexec_parse_strtab_linear(smmu, cfg_reg, base,
+						 &num_ents);
+	if (ret)
+		return ret;
+
+	/*
+	 * We might end up with a num_ents != sid_bits, which is fine, since the
+	 * ARM_SMMU_OPT_KDUMP_ADOPT case bypasses arm_smmu_write_strtab().
+	 */
+	cfg->linear.num_ents = num_ents;
+
+	size = num_ents * sizeof(struct arm_smmu_ste);
+	cfg->linear.table = memremap(base, size, MEMREMAP_WB);
+	if (!cfg->linear.table)
+		return -ENOMEM;
+	return 0;
+}
+
+static void arm_smmu_kdump_adopt_cleanup(void *data)
+{
+	struct arm_smmu_device *smmu = data;
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+
+	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
+		kfree(cfg->l2.l2ptrs);
+		if (cfg->l2.l1tab)
+			memunmap(cfg->l2.l1tab);
+	} else {
+		if (cfg->linear.table)
+			memunmap(cfg->linear.table);
+	}
+}
+
+int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu)
+{
+	u32 cfg_reg = readl_relaxed(smmu->base + ARM_SMMU_STRTAB_BASE_CFG);
+	u64 base_reg = readq_relaxed(smmu->base + ARM_SMMU_STRTAB_BASE);
+	bool was_2lvl = smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB;
+	phys_addr_t base = base_reg & STRTAB_BASE_ADDR_MASK;
+	u32 fmt = FIELD_GET(STRTAB_BASE_CFG_FMT, cfg_reg);
+	int ret;
+
+	dev_dbg(smmu->dev, "adopting crashed kernel's stream table\n");
+
+	if (fmt == STRTAB_BASE_CFG_FMT_2LVL) {
+		/*
+		 * Both kernels run on the same hardware, so it's impossible for
+		 * kdump kernel to see the support for linear stream table only.
+		 */
+		if (WARN_ON(!(smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)))
+			ret = -EINVAL;
+		else
+			ret = arm_smmu_kdump_adopt_strtab_2lvl(smmu, cfg_reg,
+							       base);
+	} else if (fmt == STRTAB_BASE_CFG_FMT_LINEAR) {
+		/*
+		 * The kdump kernel need not match the crashed kernel. An older
+		 * crashed kernel that predates two-level stream table support
+		 * may have used a linear table on 2-level-capable hardware, so
+		 * enforce the same format here to match the adopted table.
+		 */
+		ret = arm_smmu_kdump_adopt_strtab_linear(smmu, cfg_reg, base);
+		if (!ret)
+			smmu->features &= ~ARM_SMMU_FEAT_2_LVL_STRTAB;
+	} else {
+		dev_err(smmu->dev, "invalid STRTAB format %u\n", fmt);
+		ret = -EINVAL;
+	}
+
+	if (ret) {
+		arm_smmu_kdump_adopt_cleanup(smmu);
+		goto err;
+	}
+
+	ret = devm_add_action_or_reset(smmu->dev, arm_smmu_kdump_adopt_cleanup,
+				       smmu);
+	/* devm_add_action_or_reset ran the cleanup upon failure */
+	if (ret) {
+		dev_warn(smmu->dev, "failed to set up cleanup action\n");
+		goto err;
+	}
+
+	return 0;
+
+err:
+	dev_warn(smmu->dev, "falling back to full reset\n");
+	/*
+	 * Undo the linear adoption's clearing of FEAT_2_LVL_STRTAB so that the
+	 * full-reset fallback uses the hardware-supported format.
+	 */
+	if (was_2lvl)
+		smmu->features |= ARM_SMMU_FEAT_2_LVL_STRTAB;
+	memset(&smmu->strtab_cfg, 0, sizeof(smmu->strtab_cfg));
+	smmu->options &= ~ARM_SMMU_OPT_KDUMP_ADOPT;
+	return ret;
+}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 0df6c17a53173..b768080c04db4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1938,11 +1938,23 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 	dma_addr_t l2ptr_dma;
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
 	struct arm_smmu_strtab_l2 **l2table;
+	u32 l1_idx = arm_smmu_strtab_l1_idx(sid);
 
-	l2table = &cfg->l2.l2ptrs[arm_smmu_strtab_l1_idx(sid)];
+	l2table = &cfg->l2.l2ptrs[l1_idx];
 	if (*l2table)
 		return 0;
 
+	/* Deferred adoption of the crashed kernel's L2 table */
+	if (smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) {
+		u64 l2ptr = le64_to_cpu(cfg->l2.l1tab[l1_idx].l2ptr);
+		phys_addr_t base = l2ptr & STRTAB_L1_DESC_L2PTR_MASK;
+		u32 span = FIELD_GET(STRTAB_L1_DESC_SPAN, l2ptr);
+
+		if (span)
+			return arm_smmu_kdump_adopt_deferred_l2_strtab(
+				smmu, sid, base, span, l2table);
+	}
+
 	*l2table = dmam_alloc_coherent(smmu->dev, sizeof(**l2table),
 				       &l2ptr_dma, GFP_KERNEL);
 	if (!*l2table) {
@@ -1954,8 +1966,7 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 
 	arm_smmu_init_initial_stes((*l2table)->stes,
 				   ARRAY_SIZE((*l2table)->stes));
-	arm_smmu_write_strtab_l1_desc(&cfg->l2.l1tab[arm_smmu_strtab_l1_idx(sid)],
-				      l2ptr_dma);
+	arm_smmu_write_strtab_l1_desc(&cfg->l2.l1tab[l1_idx], l2ptr_dma);
 	return 0;
 }
 
@@ -4510,6 +4521,10 @@ static int arm_smmu_init_strtab(struct arm_smmu_device *smmu)
 	if (ret)
 		return ret;
 
+	if ((smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) &&
+	    !arm_smmu_kdump_adopt_strtab(smmu))
+		return 0;
+
 	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
 		ret = arm_smmu_init_strtab_2lvl(smmu);
 	else
-- 
2.43.0

