Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441F2215F7C
	for <iommu@lists.linux.dev>; Wed, 27 Aug 2025 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756311818; cv=fail; b=TlSj2V0hFdya6de6SbA7eVoogFKpNOqLlob7rX+xU+a9WFWr1dTMPObji9DhryV4GXo1qRGY6tmohDqJAHFOouRkHSNhhNvKI6lgbrzCAcI3M0TALqCcyJLaaTJOEJP9rCdWqkqJzRhIw+85G5FOQWmI3+8gnrex0sfbKY5tyLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756311818; c=relaxed/simple;
	bh=+mJ2q9sVI6LvS7WqmCRyw+91AVXisNm9sL9Ds/2P7m8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hbCne7CzsswJiUmarc8ML7uPzpcR8fDC2Aj9top0h1MboJkT83tW7RSWEHNLWMquQ7u9JIA79qqXELS9e1HayTMfvtAC3bQ+6Ae7FsqDJsOMI4aKcPiWLQP1epQFyuGa3s0aj3KLzIL6mr5F/lul2FXABg1WSs8TsSITMb+8du8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yUVsO3Q5; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yUVsO3Q5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IvZmiS4VhuwLgdLLy3BvbxB9gT+v9JbFAP2d+KAT5ceHCMJEmIe390VbUr4ek+eyFKl9JR+tcZRsLKrqwuQ5cDSB1pTiqNa1LynIbF6awBzkyopmKWzOFXCOB03U7HoOYiAN/KBz4wIMwMEQBYkFtK/pP4wQUbQZUrD+MXvRA+wPlLkmQL00zQ/K5n0+IRWN3xZHZC9GyW6CZ8JfGOk4eFu7xMYMbOp18nL56k4EFrEL9PFMo1asQoOLx34tVbsVZ8wJM20A50UJXgTgACRY2jWvOjBVE+JpOZkrpKAJQZNc9xuRHd/BX/+Kw1im5xLgxIF6hHBKh/fdoRFIFfudTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSlMfVJgK1kCQy16IH7cJ/lNQlKNpj7UVqgBefCFFKM=;
 b=s8Qi0vadwLpaif29c3DyV1tw0V9D2ttWHQ0yK+0WF/ukXM/K1/cVTFy2qEiu1cDa8H51316GizjJWkHAox8ZkM0IcUSJUBXam2jSha7a97Ayb0jTTerNBcvb+BGGs7tPSlWiGiDUwtNFztqmzziGOrNngjSU1ykK6zvbu5PVFbKBqVTIqM0HnSdtpe4WV/Ldd0ItVNZBtQrqaqlz1/76E5BneJU++9wjzCI8DGD3aeqxXPa44sqh7UtIrcIHWyYzZ87DJ03uQ9QueZ1dzFP1ENW8ETR7kj5Rj71tYEGR+3GOiegPGK+7iS1240hu2Dtf6tz0X2T2bVJcnG5al++WPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSlMfVJgK1kCQy16IH7cJ/lNQlKNpj7UVqgBefCFFKM=;
 b=yUVsO3Q5ImEtRGndEaEHquIPXQzBZVmi+ybDVRX7/Ng7Owp/dUdmU0K+muCl33DRMxPSg4g/wQNn9MfpnrEFdYThFwLzjpBSt3LGCjpLCUF0SkS26mrIWi9litruTW1WhTUW1otj3Dq1a0jCZbuX9ipG4yvKBkCn2ID5dopaAHI=
Received: from SN7PR04CA0204.namprd04.prod.outlook.com (2603:10b6:806:126::29)
 by PH8PR12MB7304.namprd12.prod.outlook.com (2603:10b6:510:217::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 16:23:32 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:126:cafe::c5) by SN7PR04CA0204.outlook.office365.com
 (2603:10b6:806:126::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.16 via Frontend Transport; Wed,
 27 Aug 2025 16:23:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 16:23:32 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 27 Aug
 2025 11:23:26 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <jgg@nvidia.com>, <nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v3] iommu/amd: Add support for hw_info for iommu capability query
Date: Wed, 27 Aug 2025 16:23:09 +0000
Message-ID: <20250827162309.50401-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|PH8PR12MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a61dd26-5c07-4ddc-3885-08dde586107d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l8deieMX7Jlx70hW462f7JCw/SoD2z/8EJhxD1MjxbIXIb0gP7zZ32oX4z/L?=
 =?us-ascii?Q?2nTTL8Y7pkeaWfoVFr4JYgVApRgfFPmIs8Ga+trwLoG/F2ZZ8SN200WHV/WS?=
 =?us-ascii?Q?v2FK2WPxXVNKEy1+vY12n9Wpr3NhpSmtf0ByRcThRHNB8+sdtArcgMt7TfK9?=
 =?us-ascii?Q?uJ6Y6dpyYtSG6c9iAOjsw2KRMG+HWQ8yKLP14ib+a7Dp64AL2Itld8GgXuOK?=
 =?us-ascii?Q?ERPnibQKOkWCBq5HnRR8YWSDAgacp1uEMvI8pWNB8xySQbjWIM6o+WbJmLNd?=
 =?us-ascii?Q?iVIUPmThDWu8swRBOONH+WGrRVkPktNv6nTFSVSzwCu8VqhjM9tD1gV8Eemx?=
 =?us-ascii?Q?fIC85a5Ii8HByxyfNxIKw0jjhfzfOosGUwEFbNoVJUzjaXnwTYdcZSN6Y50h?=
 =?us-ascii?Q?k7x4X8vKeZnAqM7m0YJ60Yo3AiGJX2BjTDTp2EERMJXVOsAoRSgFrZ+vKRVE?=
 =?us-ascii?Q?g8fVdnw8O215kbF9w0jgJTKnHeuTTbWIb3a2T+bgeXm+sSlgxFkJeDVoSy5N?=
 =?us-ascii?Q?4jTrOI7XgrTa1Gr8R9YCw/fTRi1dm2eW/pxqc83mSQ6zocUsLmUMv5G8vfO0?=
 =?us-ascii?Q?bUxhwMVcQHXbDBJs8/2j1OywcrlseVqXxMWSFBwQKn0NvCCbwX4N0eRTuMIT?=
 =?us-ascii?Q?bBcAjogKkkVAJ0QDjU3OsJ+v3IWzHLE0V86ZjDxw5Wyhho1f2b0FRHcnIfh+?=
 =?us-ascii?Q?WYp1omL7EQd7d5xp46Mh1GEZ5yf8y4VG5myE4dSTKeAexrrWrg7MigQduI6T?=
 =?us-ascii?Q?ntoX0CF6TmRKrQBmsNLkLq6yM43G+PGszy6bFWyNRCZ19S5vIp9s4GEoVda4?=
 =?us-ascii?Q?l+YfFT18Z45Ah19+w139jj0q5nBS0Udw6i/N+2tLftXMfU8kiXLLP3ezs+hS?=
 =?us-ascii?Q?Hst8rnd+LfUy6hwRktsm+hTCXDytLbqRwx69dVVFGRjNdIogA7mXcJ5gDhvJ?=
 =?us-ascii?Q?M7dV+KqKB59svmfOoIR/dLUiorlTyT9/JG4bj9aTpqQcoEBGGOg5xiJOcEgj?=
 =?us-ascii?Q?ympHp8uQzN8ECY89BIb8Sb5N2LtNxlTgYTHi6w1OlEUVmtbIe5a8BHq3eZ5i?=
 =?us-ascii?Q?izJwJzkadVQcpyN8yRocHyjGzsV64Oh2VfzYNX7Cz8iDx21MUGOfX+NUeTMz?=
 =?us-ascii?Q?j5sM/bhcYHMWyyO2PxMr0CaCL17ohdjymQlZtA62Wuv5BGSKm0vk03TaZQE+?=
 =?us-ascii?Q?FOLxAOlsjiyNTT0TJR3wJgOY6XfBClSg3R9b+KgARzBAazRSehJtkGxEbgVn?=
 =?us-ascii?Q?CWAAfB+DVoXHX8Thmn1jxAwJVtQvQCsI9rOADd283Yul2pAeBPqvptxxe/e4?=
 =?us-ascii?Q?I3MSBgU30MXvXe1MR6Qhh54u0LfRbbgRHjJ1LL/rXNbqKh7bnBeYvnhv85gY?=
 =?us-ascii?Q?ZT92BlRh7gkhWkIanK8Rtt71RtWETHsyxsr2zTYc737X7J6KL4kuKfPLNpkh?=
 =?us-ascii?Q?RG2wFEWSiJPC6HWGbfMzEqHaZC3aOwJUleF468kRwxUAmqFzdd5LL0XVISi2?=
 =?us-ascii?Q?PsUEvAAPsnOeNt8oEN+4elvmZy/wOV4Y2pkFkBMfaRtic4awdul3Eu/n7w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 16:23:32.0843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a61dd26-5c07-4ddc-3885-08dde586107d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7304

AMD IOMMU Extended Feature (EFR) and Extended Feature 2 (EFR2) registers
specify features supported by each IOMMU hardware instance.
The IOMMU driver checks each feature-specific bits before enabling
each feature at run time.

For IOMMUFD, the hypervisor passes the raw value of amd_iommu_efr and
amd_iommu_efr2 to VMM via iommufd IOMMU_DEVICE_GET_HW_INFO ioctl.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
Change in v3:
 * Remove extern
 * Fix link to IOMMU spec
 * Update kdoc

Change in v2:
 * Do not mask the EFR/EFR2 and simply return the value reported by hardware
 * Move amd_iommufd_hw_info() to drivers/iommu/amd/iommufd.c
 * Also support IOMMU_HW_INFO_TYPE_DEFAULT

 drivers/iommu/amd/Makefile   |  2 +-
 drivers/iommu/amd/iommu.c    |  2 ++
 drivers/iommu/amd/iommufd.c  | 34 ++++++++++++++++++++++++++++++++++
 drivers/iommu/amd/iommufd.h  | 11 +++++++++++
 include/uapi/linux/iommufd.h | 20 ++++++++++++++++++++
 5 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/amd/iommufd.c
 create mode 100644 drivers/iommu/amd/iommufd.h

diff --git a/drivers/iommu/amd/Makefile b/drivers/iommu/amd/Makefile
index 59c04a67f398..b74384465594 100644
--- a/drivers/iommu/amd/Makefile
+++ b/drivers/iommu/amd/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y += iommu.o init.o quirks.o io_pgtable.o io_pgtable_v2.o ppr.o pasid.o
+obj-y += iommu.o init.o quirks.o io_pgtable.o io_pgtable_v2.o ppr.o pasid.o iommufd.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += debugfs.o
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index eb348c63a8d0..344364ef94f8 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -42,6 +42,7 @@
 #include <uapi/linux/iommufd.h>
 
 #include "amd_iommu.h"
+#include "iommufd.h"
 #include "../dma-iommu.h"
 #include "../irq_remapping.h"
 #include "../iommu-pages.h"
@@ -3040,6 +3041,7 @@ static const struct iommu_dirty_ops amd_dirty_ops = {
 
 const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
+	.hw_info = amd_iommufd_hw_info,
 	.blocked_domain = &blocked_domain,
 	.release_domain = &release_domain,
 	.identity_domain = &identity_domain.domain,
diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
new file mode 100644
index 000000000000..08deccf9d35a
--- /dev/null
+++ b/drivers/iommu/amd/iommufd.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/iommu.h>
+
+#include "iommufd.h"
+#include "amd_iommu.h"
+#include "amd_iommu_types.h"
+
+void *amd_iommufd_hw_info(struct device *dev, u32 *length, u32 *type)
+{
+	struct iommu_hw_info_amd *hwinfo;
+
+	if (*type != IOMMU_HW_INFO_TYPE_DEFAULT &&
+	    *type != IOMMU_HW_INFO_TYPE_AMD)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	hwinfo = kzalloc(sizeof(*hwinfo), GFP_KERNEL);
+	if (!hwinfo)
+		return ERR_PTR(-ENOMEM);
+
+	*length = sizeof(*hwinfo);
+	*type = IOMMU_HW_INFO_TYPE_AMD;
+
+	hwinfo->efr = amd_iommu_efr;
+	hwinfo->efr2 = amd_iommu_efr2;
+
+	pr_debug("%s: efr=%#llx, efr2=%#llx\n", __func__,
+		 hwinfo->efr, hwinfo->efr2);
+
+	return hwinfo;
+}
diff --git a/drivers/iommu/amd/iommufd.h b/drivers/iommu/amd/iommufd.h
new file mode 100644
index 000000000000..992fc5cba21b
--- /dev/null
+++ b/drivers/iommu/amd/iommufd.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2025 Advanced Micro Devices, Inc.
+ */
+
+#ifndef AMD_IOMMUFD_H
+#define AMD_IOMMUFD_H
+
+void *amd_iommufd_hw_info(struct device *dev, u32 *length, u32 *type);
+
+#endif /* AMD_IOMMUFD_H */
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index c218c89e0e2e..6ec6b82674ac 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -613,6 +613,24 @@ struct iommu_hw_info_tegra241_cmdqv {
 	__u8 __reserved;
 };
 
+/**
+ * struct iommu_hw_info_amd - AMD IOMMU device info
+ *
+ * @efr : Value of AMD IOMMU Extended Feature Register (EFR) reported by hardware
+ * @efr2: Value of AMD IOMMU Extended Feature 2 Register (EFR2) reported by hardware
+ *
+ * Please See description of these registers in the following sections of
+ * the AMD I/O Virtualization Technology (IOMMU) Specification.
+ * (https://docs.amd.com/v/u/en-US/48882_3.10_PUB)
+ *
+ * - MMIO Offset 0030h IOMMU Extended Feature Register
+ * - MMIO Offset 01A0h IOMMU Extended Feature 2 Register
+ */
+struct iommu_hw_info_amd {
+	__aligned_u64 efr;
+	__aligned_u64 efr2;
+};
+
 /**
  * enum iommu_hw_info_type - IOMMU Hardware Info Types
  * @IOMMU_HW_INFO_TYPE_NONE: Output by the drivers that do not report hardware
@@ -622,6 +640,7 @@ struct iommu_hw_info_tegra241_cmdqv {
  * @IOMMU_HW_INFO_TYPE_ARM_SMMUV3: ARM SMMUv3 iommu info type
  * @IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV (extension for ARM
  *                                     SMMUv3) info type
+ * @IOMMU_HW_INFO_TYPE_AMD: AMD IOMMU info type
  */
 enum iommu_hw_info_type {
 	IOMMU_HW_INFO_TYPE_NONE = 0,
@@ -629,6 +648,7 @@ enum iommu_hw_info_type {
 	IOMMU_HW_INFO_TYPE_INTEL_VTD = 1,
 	IOMMU_HW_INFO_TYPE_ARM_SMMUV3 = 2,
 	IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV = 3,
+	IOMMU_HW_INFO_TYPE_AMD = 4,
 };
 
 /**
-- 
2.34.1

