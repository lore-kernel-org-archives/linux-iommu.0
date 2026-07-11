Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010042.outbound.protection.outlook.com [52.101.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B30F242D6B
	for <iommu@lists.linux.dev>; Sat, 11 Jul 2026 00:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783731203; cv=fail; b=fV5AdOY6VFC2BYzB/VG2Pz5OW2FwON7S3e6+p7XK3sYvZyrI09xxdQKyApfqjwHP1qumh305vIakp/I0gJ5dyaJvv2TDHP3BKoT7DhhvzkmoCr9rI854M6c/nW5pG9ajC9C8rJSSdeFMqGUPARPbUCV3/BU6xN8uXQxTh7+P2JM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783731203; c=relaxed/simple;
	bh=ESMC929LrlEMmfF7JXIQJXlKMO15I8ahvUDZBO0K+ws=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=svtY+K9NPb7lI/zomdYS3zi0inHmfzFAKaBtPmRqAHWV10wP0dLPDawitw0EN8KzMuA+ijueD9f9N1opecxFBEADRJYVuMN+2DyKnaZhvdoqkuvAMzl76CkB0A1nchVP1MoOFrrxG2NrmwUKHu8wEcbUvbVAwHxZMLe1GO8htAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Pj36cRk/; arc=fail smtp.client-ip=52.101.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Pj36cRk/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/WU4N8Rs7AHmnKgDfvORLffC1r+UTj7b7VrQT0mVQiQSg/hAO8Oi1kotzoHm3aP9M3wSHibCtP9PeUu3fGXM8L/BIYBy5ZxipPIh3F8RuwKAt3Y+37ZJQNfP9PLvMsFAF3DccZBZnEJ62mTAsX4poTmNfF3EWgk+W56h6I4eDz4uZEUtDKJ1D/eA5mxFzYo9/MMp5FcvNNzIGC0MctwcDRPHojPvLVdWLHnj7RrM2cXp+yGtgSF3fJkKsLy9Lkll8NHOa4TUtlY2B1cGvlP68+66cDAklhzEi96PP4vYU9W8e1v7I9LkTHCysLW4jhHfxCBsk5NCoozrIG7B0GBMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcpQzHirXjVA3s20X6yf7ol7dMGdJhP1ou8A/GUkTzQ=;
 b=Go8Zm4hHf87754gJdlqdZfCXsKezA+IndOHUwWQkav9koNUMj7K8Z3TkmwXgXz5WcCzlfoSCsr5Q4BOhQ6ooHJ/3IVnLCVLM17yPf7QIsgdJwFX4KXVydJkdlZJUs59KJaU/skrW8S0n9QojFCWp+vKfugjZ22TzrpQD8tWqpviLuK1xxyAHNmNNYSkrU0R64jvpHr9iYS2N6fAWgUtPSKrYCZcxOnIuVw+WBPID33TnKgso3pgcAvhXbG0iEcUcfPsW4mxgjBIxpuouJrQPSPRzEvW5Dn4v1LMfW1vF0Df1SHD4bicDoRUSMod0RuFY/PXtepoMUaoV1N2r5lcynQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcpQzHirXjVA3s20X6yf7ol7dMGdJhP1ou8A/GUkTzQ=;
 b=Pj36cRk/o+H7Qq7aj9F2F8NkFgcxj1QkV7vTfG0SK3bSlht6C0udtU/pAq1XN421vSySlKhqADLs5G+/GeEWj1610TatZJR9hHZ+i+ibJW9hwrmR1uJctYGzuBUmx5PicF7GJVnzkVq2scvH+2oCicvTHPl1jJ8gVRRSqwa8ziXBoyjP4+CmWTQwwl//Awdjh6poxrHOTvkZZjGATYbw74R3QvI9TC2IFYaLK0tySiZlwu8PIFGOMz4CkUhaxUxXEIRXuqa6KXE9PTBaIwXz1VGJVOuBAbdHlwMZ1PrDS/kPcSoB5QvHfoL2qeqHC+MeYul7sX5cWNUcq446uw59fQ==
Received: from PH7P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::34)
 by IA1PR12MB6235.namprd12.prod.outlook.com (2603:10b6:208:3e5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Sat, 11 Jul
 2026 00:53:13 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:510:32a:cafe::5d) by PH7P221CA0023.outlook.office365.com
 (2603:10b6:510:32a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.13 via Frontend Transport; Sat,
 11 Jul 2026 00:53:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sat, 11 Jul 2026 00:53:12 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Jul
 2026 17:52:59 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Jul
 2026 17:52:58 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 10 Jul 2026 17:52:57 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH v8 3/9] iommu/arm-smmu-v3: Add ARM_SMMU_OPT_KDUMP_ADOPT for kdump kernel
Date: Fri, 10 Jul 2026 17:52:44 -0700
Message-ID: <516bf5912ea0f673939595228457aff1863ade17.1783729633.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783729633.git.nicolinc@nvidia.com>
References: <cover.1783729633.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|IA1PR12MB6235:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ebd1eed-2336-476d-2efc-08dedee6c91d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|18002099003|22082099003|5023799004|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	6D4TJsZCjKTfmPu83wGCCzugQ98m6xTjPpZ5Ndi6umnZBECtuQQlQPQISLImKTEvRXhVWgaaZDKjI9uqlertbyZlrZhUScJ0l2+x/4iHsXoWeYAClvR66GK2fv6i7S8HP8TfaFjaVLjvEjwFqClmyHWIeUejncM8KtKQRGLJB4gG7s3VKph+YqmgqN5aBcb8BQwHJH47hU1/k2zLjWs8DhzA/eYWKwgBV5V77yIF11EGPdS+vadrC+WRVpM7ww/AWgDhOWzGKoYbgkEoVXZw6aRNYP3+ycUIuT1VoGNaUvBrhXUxwdrEtGT+aVs5dJN+xJ+cPYdgNkUUcgFqtB77MJXBnj927f01DaZNqDPslKNhPFb1VDmXLlxqwUUQKlzNLrLkDSMv5s1yDCbbgA7WhYrIdKZ2IMAzVcjXsdv4VjU5BWFKplzOkc0uycZA08DkK//9p8JrzK0wTuTHB33PgxNfXf0/GClxopF/zcavNd7zuRXULvQqBiTZCrnT8EBHh0eZWMOcmr4FfOOcToemAS1KKHEw8dtBi1V9No6gox4fVOfVQX8vAZBluQMbzcGL78GoKyzmVg73Vuqg58vqeIhq73pK7xv9n9RhkMwYpg97L2Q2WYLy1Y43kQHEfGiNkkJwaYeaNxxZZOseEQdyoXFtH4/86YQssNZmHjbQ02i8RI2WbjwhzRcG3xhu/+qllPSLTbowEX505ybBFm099w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(18002099003)(22082099003)(5023799004)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nh1gmIkRudVFoSXVzrgM/KSntn9/xORDQZrFGXIzuBlnJ+SfjobXUAqYTyqIVU6u02SvzUDIoKoFjjod+kJtwnBu/85Cls2jtqvkDMkx9gaeAV55WlNiP1njMSnnQRBD+FFmxSu7xNyupdlyin8yOh7sTlhEQbQC+oED/hdJ/Tfazp37xf9lAvG7v6AKSj2bOIBYbVUuqi0dF7H+ukeOeONhnEnYXnwQc2Oxc2LsWiolSHND81e4Muy/gW8IYYgnJhKpEht/SoN1h/yXYi1SjdU2PoAjoaCbZIvqqPcFt71i1jfNNg5BhaCdOia6R4LE2GrveoHfnpsSBQ0WuhmsQiltO82df7I22A2WsJ8X2cSYPs+oSXV7aXS2oJ6t91DiLSYmZonp7tJG5oPX6cxbXh1ldU3ofcIaqZyS9YmhFcrlvu5vAg9qHuAx105zTMWs
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2026 00:53:12.9684
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebd1eed-2336-476d-2efc-08dedee6c91d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6235

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
a new arm-smmu-v3-kdump.c, which is only built when CONFIG_CRASH_DUMP is
enabled.

Note that the adoption of the crashed kernel's stream table follows certain
strict rules, since the old stream table might be compromised. Thus, apply
some basic validations against the values read from the registers. If tests
fail, it means the stream table cannot be trusted, so toss it entirely. To
avoid OOM due to a potentially corrupted stream table, the memremap for l2
tables is done on the kdump kernel's demand.

The new option will be set in a following change, once the device reset and
the RMR setup are reworked not to overwrite the adopted stream table, and
the crashed kernel's in-use ASIDs and VMIDs are reserved.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Assisted-by: Claude:claude-fable-5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/Makefile        |   1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  21 ++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c | 279 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  22 +-
 4 files changed, 320 insertions(+), 3 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c

diff --git a/drivers/iommu/arm/arm-smmu-v3/Makefile b/drivers/iommu/arm/arm-smmu-v3/Makefile
index 493a659cc66bb..ba307283a0978 100644
--- a/drivers/iommu/arm/arm-smmu-v3/Makefile
+++ b/drivers/iommu/arm/arm-smmu-v3/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_ARM_SMMU_V3) += arm_smmu_v3.o
 arm_smmu_v3-y := arm-smmu-v3.o
 arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_IOMMUFD) += arm-smmu-v3-iommufd.o
 arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_SVA) += arm-smmu-v3-sva.o
+arm_smmu_v3-$(CONFIG_CRASH_DUMP) += arm-smmu-v3-kdump.o
 arm_smmu_v3-$(CONFIG_TEGRA241_CMDQV) += tegra241-cmdqv.o
 
 obj-$(CONFIG_ARM_SMMU_V3_KUNIT_TEST) += arm-smmu-v3-test.o
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index c909c9a88538b..e567be11f2d56 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -928,6 +928,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_OPT_MSIPOLL		(1 << 2)
 #define ARM_SMMU_OPT_CMDQ_FORCE_SYNC	(1 << 3)
 #define ARM_SMMU_OPT_TEGRA241_CMDQV	(1 << 4)
+#define ARM_SMMU_OPT_KDUMP_ADOPT	(1 << 5)
 	u32				options;
 
 	struct arm_smmu_cmdq		cmdq;
@@ -1239,6 +1240,26 @@ tegra241_cmdqv_probe(struct arm_smmu_device *smmu)
 }
 #endif /* CONFIG_TEGRA241_CMDQV */
 
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
index 0000000000000..1ca0d7ef7dabe
--- /dev/null
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c
@@ -0,0 +1,279 @@
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
+	u32 log2size = FIELD_GET(STRTAB_BASE_CFG_LOG2SIZE, cfg_reg);
+	u32 split = FIELD_GET(STRTAB_BASE_CFG_SPLIT, cfg_reg);
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+	u32 num_l1_ents;
+	size_t size;
+	int i;
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
+	num_l1_ents = 1U << (log2size - split);
+	if (num_l1_ents > STRTAB_MAX_L1_ENTRIES) {
+		dev_err(smmu->dev, "l1 entries %u exceeds max %u\n",
+			num_l1_ents, STRTAB_MAX_L1_ENTRIES);
+		return -EINVAL;
+	}
+
+	cfg->l2.num_l1_ents = num_l1_ents;
+
+	size = num_l1_ents * sizeof(struct arm_smmu_strtab_l1);
+	if (!IS_ALIGNED(base, size)) {
+		dev_err(smmu->dev, "unaligned l1 stream table base %pa\n",
+			&base);
+		return -EINVAL;
+	}
+
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
+		phys_addr_t l2_base = l2ptr & STRTAB_L1_DESC_L2PTR_MASK;
+		u32 span = FIELD_GET(STRTAB_L1_DESC_SPAN, l2ptr);
+
+		if (!span)
+			continue;
+
+		if (span != STRTAB_SPLIT + 1) {
+			dev_err(smmu->dev,
+				"L1[%u] unsupported span %u (vs %u)\n", i, span,
+				STRTAB_SPLIT + 1);
+			return -EINVAL;
+		}
+
+		if (!l2_base ||
+		    !IS_ALIGNED(l2_base, sizeof(struct arm_smmu_strtab_l2))) {
+			dev_err(smmu->dev, "L1[%u] bad l2 table base %pa\n", i,
+				&l2_base);
+			return -EINVAL;
+		}
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
+	u32 log2size = FIELD_GET(STRTAB_BASE_CFG_LOG2SIZE, cfg_reg);
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+	unsigned int max_log2size;
+	size_t size;
+
+	/* Cap the size at what the kdump kernel itself would have allocated */
+	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
+		max_log2size =
+			ilog2(STRTAB_MAX_L1_ENTRIES * STRTAB_NUM_L2_STES);
+	else
+		max_log2size = smmu->sid_bits;
+
+	/* cfg->linear.num_ents is unsigned int, so cap log2size at 31 */
+	max_log2size = min(max_log2size, 31U);
+	if (log2size > max_log2size) {
+		dev_err(smmu->dev, "unsupported log2size %u (> %u)\n", log2size,
+			max_log2size);
+		return -EINVAL;
+	}
+
+	/*
+	 * We might end up with a num_ents != sid_bits, which is fine. In the
+	 * ARM_SMMU_OPT_KDUMP_ADOPT case, arm_smmu_write_strtab() is bypassed.
+	 */
+	cfg->linear.num_ents = 1U << log2size;
+
+	size = cfg->linear.num_ents * sizeof(struct arm_smmu_ste);
+	if (!IS_ALIGNED(base, size)) {
+		dev_err(smmu->dev, "unaligned stream table base %pa\n", &base);
+		return -EINVAL;
+	}
+
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
+		/*
+		 * Undo the linear adoption's clearing of FEAT_2_LVL_STRTAB so
+		 * the full-reset fallback uses the hardware-supported format.
+		 */
+		if (was_2lvl)
+			smmu->features |= ARM_SMMU_FEAT_2_LVL_STRTAB;
+		goto err;
+	}
+
+	return 0;
+
+err:
+	dev_warn(smmu->dev, "falling back to full reset\n");
+	memset(&smmu->strtab_cfg, 0, sizeof(smmu->strtab_cfg));
+	smmu->options &= ~ARM_SMMU_OPT_KDUMP_ADOPT;
+	return ret;
+}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 175964b923716..a1a91b6635129 100644
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
 
@@ -4498,6 +4509,10 @@ static int arm_smmu_init_strtab(struct arm_smmu_device *smmu)
 {
 	int ret;
 
+	if ((smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) &&
+	    !arm_smmu_kdump_adopt_strtab(smmu))
+		goto out;
+
 	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
 		ret = arm_smmu_init_strtab_2lvl(smmu);
 	else
@@ -4505,6 +4520,7 @@ static int arm_smmu_init_strtab(struct arm_smmu_device *smmu)
 	if (ret)
 		return ret;
 
+out:
 	ida_init(&smmu->vmid_map);
 
 	return 0;
-- 
2.43.0

