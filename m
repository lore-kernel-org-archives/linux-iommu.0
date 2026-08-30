Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010040.outbound.protection.outlook.com [52.101.201.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CE3356754
	for <iommu@lists.linux.dev>; Sun, 30 Aug 2026 23:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788131940; cv=fail; b=X5rZkUMqqIBIO+9eKX5AwimL+KRMwbw2pfaFpgXeSNfdsjUmlE80aVNegXLbltxTYG9goGlbzks43LPJKZgNNjMwJwWQPRENPbXJHzFIuGyH87zfXh/CCCAoEXd9jqtSaQBYKMNQfyZhpAo6vda0Phy83hm1z3l1HGupPFV8woU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788131940; c=relaxed/simple;
	bh=MLMQ0g+Z6fSV6oRJI1YjSkMnu7Got5kev+4cXXSDULI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YpxrDYPF7aFe0ujmqvd0PL65t/IFCnVihKgI/ST/XShBrU9XLg+5nucClxVQD0PVPlDxhiwCNHdSlnjUA9iyPbegnWS3jzsNSBv3rd85JckMYr3AtnoiFZPMuOQOXlsjbP+AGQiW26VQQhxFtafcv8VwdnUgQc0gW8+gZjy49lE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AuWHRhpe; arc=fail smtp.client-ip=52.101.201.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AuWHRhpe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0NgcbWHj47JPiIGs+kJf8IFfSHJUYCdcF1gIDwDDDWlzdPNFaMbiCtiVrVhzTc0LZaG1vMNO8TE0hQqEzTLIY/axs3fLchCJBKffOqBrhc9koOy2tAZRTWAdA+cIAerpLoNrtonS30UOfaYvyNMvvfi1xalYqXW+AwhIF/zLRer32u7IQRinM1uEJt4j3sHlzkSKhxCngglI58VAadptnA7bohHchA7pE6V3DwLcGm0D12hkNmMMFuXwPoY8CyeUKYn8qcx3jod6OYy/FIk0tNBR91Tv39y9zgFZ+eoI7JI0tUiJI2kO9kO3Gss/Mlr6lcutYn4MWYs0c4NLlJ3KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXxWzoIM73dGMO0ab7fN4SbodpXrTW7ED6+9FFIiHEE=;
 b=DgM9AYvEvcyXzIIRQtNLYD7E7IZu0e2lR9otUhfOiywbyHYGlZ50+1R4i1ORr0JfxKQxOTi1V5m8gTxTYzQ8g3fcs4QGyYMAgIst2wF7PiPsRO3oJv9NN4DWJWg/6DA008vLz3QanAO2jbmve4jtU0JVW/91cdzq3STrpb4XM0VW1dfsHOaYfOrdNX8mjmmHO+IwwnZ9seXCbAWB67hi4qkxnLN2cyIUxEElCAmA0kXMTDQdIhPQxxIjkF497ksA78CNE7HqfrtBfklnEWQ0whRB/3j5ays6zBup2ITyKv+UB0d/0a1yCmiK4ynsnsZQxV/btRgBkasEnOftraNfvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXxWzoIM73dGMO0ab7fN4SbodpXrTW7ED6+9FFIiHEE=;
 b=AuWHRhpedVOxp67LGBFtuc2PidWYHv3p7w39tvztNLgK31FW9uFXqBkwHC4CGk9DPBdr6WHkdhKgjmW5UTFXQrh7a04x5D5kv+UHKusQaGlQpelqGow4q/JY2GrgA8svF4nZGNNyD3uNriQDzcEcjhRONVN8n4JwG5A7HaHobjq0NFP8B4j0j9Y86WsXWE0OT6iP+ErwGebXKZzzto8ugZ2ncGOywipsthMmHWAkgJNaE5GllFZDR9oz+IFGD4DPxsVg9qzVBFV2FF5UQdl+sA363SKSWRecV3v0p/rOcMuIhipTamT9pY0zAwvEyJh/Od/0WwyCA0HlgpWhl1vVLQ==
Received: from BN0PR04CA0055.namprd04.prod.outlook.com (2603:10b6:408:e8::30)
 by BL3PR12MB6547.namprd12.prod.outlook.com (2603:10b6:208:38e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 30 Aug
 2026 23:18:41 +0000
Received: from BN3PEPF00022BD8.namprd03.prod.outlook.com
 (2603:10b6:408:e8:cafe::2c) by BN0PR04CA0055.outlook.office365.com
 (2603:10b6:408:e8::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Sun,
 30 Aug 2026 23:18:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF00022BD8.mail.protection.outlook.com (10.167.248.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Sun, 30 Aug 2026 23:18:41 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 30 Aug
 2026 16:18:37 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 30 Aug 2026 16:18:36 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Sun, 30 Aug 2026 16:18:36 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>,
	<kas@kernel.org>
Subject: [PATCH v10 06/13] iommu/arm-smmu-v3: Add ARM_SMMU_OPT_KDUMP_ADOPT for kdump kernel
Date: Sun, 30 Aug 2026 16:18:07 -0700
Message-ID: <d661395d986d3aa78af200f55e43740996ee8a0f.1788130528.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD8:EE_|BL3PR12MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: db097d10-ae0a-41a2-a083-08df06ed07d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|23010399003|36860700016|6133799003|18002099003|22082099003|56012099006|10067099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	Jek1uWSXiSP7cmYqguTa7nsPD+diA87F1ru+iNDfgmt96/m3H1HBc1s5Ql40JCGssRWLKhx2lMHeZrHN5FLSPAf1exjmwsIVjbf4dM2BAVAuFRsGmE/28YkLUVCbJMd0FAzCglaEQun8MUNtYzRCf6j+BazETTOu0aCoNZGWrgFp6EDwt1oHEV+QUpqe6FLH+RLqp5bBDNezcQ2WFZ10OKBC86SZs750otI4uUxYZGgFMpjaOGqHD0VLWnTQmGe/dYjEftD6bVMMUd0bb7I7UW3uU55c+UI6NrMi9fW0Xhy3iDP8assnEdLpILY2vbS53ytY4269o927xycdrgpsY0o/bNJE6Jr/Mjw2cw2wtpxFcXajG81QEF1oUSFklHiQZSmot/yOyKillPmCtM8SUZH8/NY99TDET8xa3QRkPQe8FJwkaCO99AQfRF84OMSev8q/cDauqreI/RxIq333wFKKM5HLEZSYh6W6ylVWMGnFP9HFis9MmG4nhuL4e4wlfneGjLU17keJ6k7i1QRFWzk3lyeecuyC7NBAtgIIcncIqrZ6rF0r9J1//NWAd0W69x+HDvlR6Lc4v44xbrw5Tg3CDqizkNzwGEn4NiB3DPX7LXHQs0iui7mERjpsA20AzWuiCPpFFYycySyBqgBpSrkgF5MsYexkVRA8VAZ3nm1owtfyP91fkdug9DDw4LJhOUA8dLZWt4AtxUKCIkhflg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(23010399003)(36860700016)(6133799003)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5sfYHM/suQRP0EBRluCAPaz4Zje3+24oKI8p9r1fb5uzCk/CvlmbABN8X4MJzyq7AYX+Q1zLHi5S2JUSrv3kpu/rxaAkACEK/JcmfcNlw/X6VIAWewHkCAW+QVmCwLNxw+m+XrkX6zmIxgnskDNfGJoD0yz1u+mdtmuxS/9lHbntRGxXhxcWN7T480Yfvz+WCaj5Bkfjsj0aibmajnY84pI6gSYAeugOM6rUgmAJpZ6UsheXxnRkwLrWVU17xxwv55MwpEzJgvugA0E8jzYRMWEbW+kaYyCUoL8xBpzOs4Tdr+M+PM5i2dwwFvMSsPLMwJzixd/AE6+TeQFwPVwpujVWPh/yJMgXVUtfJsx7eq65kzqguHqJ/CTZGDuXxul529CrncV/Tl8jZLH2dBj1lstyzFwB+Ywwbeo4afXn5hrntYB1d6yXCZyijxGUsGj7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 23:18:41.6164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db097d10-ae0a-41a2-a083-08df06ed07d0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BD8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6547

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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
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
index dd71d758defd3..41d7a907b9ba2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -935,6 +935,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_OPT_MSIPOLL		(1 << 2)
 #define ARM_SMMU_OPT_CMDQ_FORCE_SYNC	(1 << 3)
 #define ARM_SMMU_OPT_TEGRA241_CMDQV	(1 << 4)
+#define ARM_SMMU_OPT_KDUMP_ADOPT	(1 << 5)
 	u32				options;
 
 	struct arm_smmu_cmdq		cmdq;
@@ -1262,6 +1263,26 @@ int arm_smmu_kexec_check_strtab_l1_desc(struct arm_smmu_device *smmu,
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
index 7b9ef1ad1f688..971b12517941f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2002,11 +2002,23 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
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
@@ -2018,8 +2030,7 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 
 	arm_smmu_init_initial_stes((*l2table)->stes,
 				   ARRAY_SIZE((*l2table)->stes));
-	arm_smmu_write_strtab_l1_desc(&cfg->l2.l1tab[arm_smmu_strtab_l1_idx(sid)],
-				      l2ptr_dma);
+	arm_smmu_write_strtab_l1_desc(&cfg->l2.l1tab[l1_idx], l2ptr_dma);
 	return 0;
 }
 
@@ -4611,6 +4622,10 @@ static int arm_smmu_init_strtab(struct arm_smmu_device *smmu)
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

