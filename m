Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891FE356917
	for <iommu@lists.linux.dev>; Wed, 27 Aug 2025 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756304617; cv=fail; b=MOaN1uozSwH2rD1nQIFuYyPTxJbO/ufuPR2WQRARZf+t5VRtl44dRWGaPCCu52NfwaGZ0OSzFT6N0Icm9iZ7CWcKKYCm91x8bAO2ZTLVEZNjcElu9dc7yXSV/+RBatg04LJ0wAUqlkRtrTyXAk+p6+KxaHwrltvspqCIkHsV6yU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756304617; c=relaxed/simple;
	bh=pBCptv/p4qkYjBvNcpja7Xy1nxHKjUbn3/Rib0IgYMA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iu5o7Y77CVggHYmm1iGgjpwkwc77epg0N+Bgf3Gr9uOHbyRdoGjR0SWSg1O+BS4kYGmNHI8w50KT1mninEzdeWHs9ic47E13jCkgTeJnqeJWi0u93t4arBL/syf26w3QgM6o78vm9qvtaV0Y02BTb9vqosN41bVU7Hnto9bofzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t7eVoDIx; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t7eVoDIx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VTSMfSEVd0VajF9hbIPSuNoWyrUlsHjZ3H34D3DvyB0hqT30RLXy7NkYE1yvUlTmqS7kEmpRzjCgWKQVW6tWlzYBGzF0SekzxrbiTf+ZC376rXPNMQ7nXfSqjSuSPQdMydr77mQDrcH2w/3eFLIdkAXV0BTLuYf8mH68jfLEeqsLUoc259ELSeDmJtU41rInUILQMekYLB4GbC0p3PkgpcaucYiQ/ZudqPTA+/CL7SOy5j4F5I2lWiTUHDWxdLTgQoE7tjcSjhCs9Y6aZcMbazrbcgc972W+9gTxT6M6rDQmEoIm4q8xWHg5bd0LdghSZduHiu146+YBQteuutJjVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXybWhlWllq7+XE8x+In0hMV81WkqYVkPHV9qFh92aM=;
 b=sg5DEOvMrnEy5EgL/q4ILnL+hu8OW6B7v7MPVRA1i2oyeTQ5Gt9igFj08Qx6sxR+8+DI+ijzEx2I/i0qL4QVoajlcRBYMBeAOP0D5D3jAZuDQ3nvqbBleCkiqCu+t2tLwHh5f0eILa903gDjnjAyHbwZvesIGfVqSqtztuuTzOM4WxMYgMOjPSFgyGddPLWGLNK6Bph1r+9hDsU/PIutywoB8Fxae12oq7lkf+4uOtb0odXrvfOZ63QxAgWooppBjk8+RSZYRaXvrvhDuffBPGmD9Y/jykAi1Nxi4fPdYYdoOnZnOPXckapvUr9cocEHH/IipIBvtF2hVNonJWP6+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXybWhlWllq7+XE8x+In0hMV81WkqYVkPHV9qFh92aM=;
 b=t7eVoDIxxb5dyUhFJsCQ9Rd8FpSeXDN+JBQeeUY4JfrlaUSSdv+60tB3zdpVOdWw5RT6fyy0IVgvtLSn+upuVrzLzWGTV3AR4EIUB/jcMwlKZIXeg4fqj25HDhcGPRAPnocPgeHTX+fx/Bgs7DCVY/Wf0XjHQPD6hC98ehY0dGY=
Received: from CH0PR04CA0083.namprd04.prod.outlook.com (2603:10b6:610:74::28)
 by PH7PR12MB6762.namprd12.prod.outlook.com (2603:10b6:510:1ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 14:23:32 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::b8) by CH0PR04CA0083.outlook.office365.com
 (2603:10b6:610:74::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Wed,
 27 Aug 2025 14:23:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 27 Aug 2025 14:23:32 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 27 Aug
 2025 09:23:26 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <jgg@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <nicolinc@nvidia.com>,
	<robin.murphy@arm.com>, <will@kernel.org>, <joro@8bytes.org>,
	<kevin.tian@intel.com>, <jsnitsel@redhat.com>, <vasant.hegde@amd.com>,
	<iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v2] iommu/amd: Add support for hw_info for iommu capability query
Date: Wed, 27 Aug 2025 14:22:50 +0000
Message-ID: <20250827142250.5594-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|PH7PR12MB6762:EE_
X-MS-Office365-Filtering-Correlation-Id: 13486e47-cac2-42fe-a5b1-08dde5754cf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PfjgpO4KP0o61tDBScRiiQG/1o6VxmWuF8yAdstYsw8TAnHD/JR5vDrIPm/9?=
 =?us-ascii?Q?Nn3GRZ0cgo98OabnomXlyinfcbreh9BCT57I8bBiGkOp9p2EYMlqDe9FjhjA?=
 =?us-ascii?Q?FtT+AfTm/9XnDLXk1bt+4WsVHI9BKjv9A8OORGqUgoN5GVH4pbkoItqfot71?=
 =?us-ascii?Q?Vp8zB4M7M47lbKiRSeGivr9HpdKTsbsIq7gssEbNBlGIgSFRavjjGLS8gt/P?=
 =?us-ascii?Q?cibY/PUAeRuRSLsA15FjyG6axIMLUkAjZuTlE/CO7V1aBrCqZPIPY576Vyun?=
 =?us-ascii?Q?3FD1l9HBlndysCPz0Q/j3g4HzlFhlgZLUS2Yx2n9w9B/YErRzMentx9u7h1s?=
 =?us-ascii?Q?CEWsSUDCIh2snvPr7f+R+k6kN4dx4BYCyUKEz+dcgIBn9U0a21Mdyy3sjNAp?=
 =?us-ascii?Q?xDb1JI8MGoj48lK/CVmhk/ShxEK3j4Gwxjwp4kkevLnr2dA9y1U8vzZ/5+aR?=
 =?us-ascii?Q?l0IxOBs3hqrgbVJNH5VRdi5ieYsOl6NITU3LdH37JSjylCBAPiXLILIxiH+B?=
 =?us-ascii?Q?/Wt0nh8y+BiwHog5TDEXB1zsunfmTACvUDCmJYcLRe+fXNTYjolt4vtC76xt?=
 =?us-ascii?Q?x2egRIlK6FqhSnAt70AdasS60OiHZ7f72YN/Bw3my+ubl1o2KdMManyrLi3Q?=
 =?us-ascii?Q?TNwrU2/fjWmDmaYtdH2TOQkMj00ZTzvPxS2gHst6KGKIq+u7bTa+t4JtXGzP?=
 =?us-ascii?Q?flgOUutBScLulTemCiIbWejaTNVZmkBrkyhJKpSNuGsrXc6caWpqnH6b5zWJ?=
 =?us-ascii?Q?F/n4jieun/btbIFH+bv+YZri5vv+GUk+UqqiL3hIOHuJzuUgRyLSTixriPjM?=
 =?us-ascii?Q?nUUMlY4mZaWGQtTKAUNPGN5l2S7Lw9R6qoTFIfR1Rl/btVASsxdJx7cSjTRj?=
 =?us-ascii?Q?FdHiihA4hugaAjbw1OlmhbatvoJQ6jNeuoW86wJdpR7K7sVBxnY5FOK6DKXH?=
 =?us-ascii?Q?y47dPrRMPFyHfkt0N1RESLcSJBz2MpCDGPmt0BDgT/Dg+mAYrGKUL13FVszv?=
 =?us-ascii?Q?vAVyta1cVyOQ7IaWjobuG7qye45TgbC/E/BEApUP0bHbQ6FXu0RmwABwjPDK?=
 =?us-ascii?Q?gm964Czv4CgI42wLT4BwnhYwINuETZbcCr6bkpugbEERYhpmH//R6JgUxmpa?=
 =?us-ascii?Q?rLowd8TGV4+ic1ozURYXG0AHs6LN3tzk0psmL28QZuPblw4RD3IYumtcp0ei?=
 =?us-ascii?Q?qUkBfrRROTl51aksr4dPMuvlAI9nJyQx1LSl/v8LsmvTDW0d3pKWpkT6sD7l?=
 =?us-ascii?Q?MwxvN4VG8dQOCetx2y/JoBlPXQsaFQtl/+FAn2Dg1DzC+rdgrKEfNdGeozh/?=
 =?us-ascii?Q?/l1G/+tgSNoOIqL/sQOktZ2l0sYNadECZOQ4wJ2mEBgHzpUmGoDT7W2/tLMC?=
 =?us-ascii?Q?9HCCrZmb4oJffjes3o9Rx1rWV8OjXN0U1kWEbfQqMOhTQp9AskZJGGbsG7sM?=
 =?us-ascii?Q?r5q84K5ZQrmybHmNyRRWHu8MQxIUBP6gHnWztee3PTHEzaFGu9CyFucjYFwy?=
 =?us-ascii?Q?EDKrjNNM/ai5LPWH89BCqhQoAahG0IFzpCwkdTOVCdTohhZSwlp8iUEbbA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 14:23:32.1074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13486e47-cac2-42fe-a5b1-08dde5754cf6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6762

AMD IOMMU Extended Feature (EFR) and Extended Feature 2 (EFR2) registers
specify features supported by each IOMMU hardware instance.
The IOMMU driver checks each feature-specific bits before enabling
each feature at run time.

For IOMMUFD, the hypervisor passes the raw value of amd_iommu_efr and
amd_iommu_efr2 to VMM via iommufd IOMMU_DEVICE_GET_HW_INFO ioctl.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
Change in v2:
 * Do not mask the EFR/EFR2 and simply return the value reported by hardware
 * Move amd_iommufd_hw_info() to drivers/iommu/amd/iommufd.c
 * Also support IOMMU_HW_INFO_TYPE_DEFAULT

 drivers/iommu/amd/Makefile   |  2 +-
 drivers/iommu/amd/iommu.c    |  2 ++
 drivers/iommu/amd/iommufd.c  | 34 ++++++++++++++++++++++++++++++++++
 drivers/iommu/amd/iommufd.h  | 11 +++++++++++
 include/uapi/linux/iommufd.h | 19 +++++++++++++++++++
 5 files changed, 67 insertions(+), 1 deletion(-)
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
index 000000000000..7c30dcc66a59
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
+extern void *amd_iommufd_hw_info(struct device *dev, u32 *length, u32 *type);
+
+#endif /* AMD_IOMMUFD_H */
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index c218c89e0e2e..1adbcc89eccf 100644
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
+ * (https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf)
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
@@ -629,6 +647,7 @@ enum iommu_hw_info_type {
 	IOMMU_HW_INFO_TYPE_INTEL_VTD = 1,
 	IOMMU_HW_INFO_TYPE_ARM_SMMUV3 = 2,
 	IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV = 3,
+	IOMMU_HW_INFO_TYPE_AMD = 4,
 };
 
 /**
-- 
2.34.1

