Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012020.outbound.protection.outlook.com [52.101.48.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF1A2FB0BA
	for <iommu@lists.linux.dev>; Fri, 26 Sep 2025 14:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896371; cv=fail; b=k0/ueyL6JDWHEn5++me85zfPSrh/E6gUAdilvCPTwh6eq28atLP+pGtr7m5jjRtwfWnJn8Ikw2R5mhHXh0S9pZBt/dautZMSyaObBX1EOUyFdBejhX+6qMtHO10aLH8VM4gdi5YUNMCfpm5R3nu0LSngFGCrcKgVd1cWQJhGJBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896371; c=relaxed/simple;
	bh=W3LmoNRF/zscYlm9fiOmVD/KNWiavIIUXcdCy0r4bSs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eYjk0dijJ6fAzkAnY035o/J84I9c0+Fuwa8JhzYX7HOq13q1gJYg8TbHFhr2oUcINrPM03sK/xTzr/qUDOqA690axiW7x4l8wZ3AsOzIlPZDrPinEXe7Ke1sTuJTgrNN/UAwelcy5SWrnLv9UomPjkKqKUrrHOraeVacgaPEtgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Wjxe9qOG; arc=fail smtp.client-ip=52.101.48.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Wjxe9qOG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Krq1Dm3vdrYETduMZTBOpQC/XjgMJnlNxTmm7Uzi6dIfvuCwD7pxYr4icSL+2Nams3AHj8sW9wRVK8Ge+9gSt0i68hj6/Qj2f8uppQNBtlo8+zy2xrEZ4/mSX6yRFU89ugOpFdOE1NEv6TOT2DDaHL5M2iCWNMa7U9ubHEOwqrvoFXTUukey1aROi3/nOo+Vo6aqLziiAzt0TyXgoDm1AynqpgJTRU/8cM+9BeuVdYmvRW8lmUtlCdzIwdtWIYT7T0KtMsmZM32Ssb31vvNlIvPB9cvESsC9n1CdAvlCTKJbY1QTeCqfAP5qxmzcQARczWSMAdRPnhaOcH4huJTXRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fNkWcBZcdp7n7OCG6XxsrrOuVgSxtsb5oC/uL4znSo=;
 b=vXVePTPbcbjis9I3g2w/fMi0mJDfPHFuNwQbMTG+/3ccNJM0zwJTSuEOUoVJpMpwolG4HSCLVdmComX9TYmBfJOCTZIYyVYDYHclXss9RloabCMGaIJSmfax/DXuS3vdsmau2NPKatRJqDDzHZIvycx5DOgqup/ssP42BT1a+QlFHq4+RBuhyFmAfJZ272qWK5l48m08N8YXkr8GXEScgoRkm/8X6TS/u5YymoXb5JamNU/XHRXoGtQ7nvFpfG+IA3NNy6PSbLV/nNPXQs62IQMS3Z/g1R0FxmYfTJcHwvreey8O8pwD2G3ACoHQ4vbQtL3E586mMpYkxFta/9Nb+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fNkWcBZcdp7n7OCG6XxsrrOuVgSxtsb5oC/uL4znSo=;
 b=Wjxe9qOGvWp5KerDO667aP6werOnQkyxaosZY+iPq3rWu9eYjUEsu+O9zJm1yTP2FGetsum4t68qolCrIK3DLxUu5aDFgBeWjAXjZqxm0dowNAh6VAEoxtjW+7+cxL8qgMjdU6x2WRBOsh6ygRDJrRKj3ud1WJXQtPwzJFUPc+M=
Received: from CH5P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::20)
 by SA0PR12MB4478.namprd12.prod.outlook.com (2603:10b6:806:9c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 14:19:26 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::1e) by CH5P223CA0011.outlook.office365.com
 (2603:10b6:610:1f3::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.12 via Frontend Transport; Fri,
 26 Sep 2025 14:19:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 14:19:26 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 07:19:21 -0700
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <jgg@nvidia.com>, <nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v5] iommu/amd: Add support for hw_info for iommu capability query
Date: Fri, 26 Sep 2025 14:19:01 +0000
Message-ID: <20250926141901.511313-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|SA0PR12MB4478:EE_
X-MS-Office365-Filtering-Correlation-Id: 19f65d6b-f6d0-4e31-5f34-08ddfd07b2d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y7Xq0rmrAY+PdcXAlDdMpgG+rd5K3eo3wNctXN5S4OeYa8S0M+8ZE67cvVZO?=
 =?us-ascii?Q?yfvVypfUUOvHojoy2UzX756I7fmRmjLmpWg0dxaXIV7GwM7YF2dZ0DrhvQMq?=
 =?us-ascii?Q?Ye94yzvEkbGm5CiEtDMllzByd7MeCjFuv9kHY+gPgfd6YrAhp/uAecGdZT26?=
 =?us-ascii?Q?KJfzZ6D5RdxJdVvfBKalCm5uD/rFrhjYfzNNt7lSYQfG2dmCpSALzSbhEwHW?=
 =?us-ascii?Q?h//ARTH7nru7x06L0sM3KKZy7+FNQNTHYlVKAtLM/DgLcMNz9JXGCKhfYDYp?=
 =?us-ascii?Q?Uollewy5Akuhsxf9tX/B5BgDcGZgGhpssAILRTZkhojBEYrc0wAtzMhIkGeC?=
 =?us-ascii?Q?Hcj2N733p4aKYiMQPHPE1+rPls9QnQc2woRA09zmCGlnB8FBvSw2jucAXfVN?=
 =?us-ascii?Q?Bmzdp8agSMR6Ihi3awHx3ZvLBo9Vm34sz1ZO0/JIt/TxEjEQ+A2ONKrKsgup?=
 =?us-ascii?Q?9YwHWCtL7D/bKfaVXXnzrKcdUSIZLhL5UIJM/y8HQ7pGbJqDZ5S4ZBZFJ3rc?=
 =?us-ascii?Q?PpMMSo3mphSSovP5oOjfxRpBA/WV7PTBKtziDFr9ZRFGAsNS57Xi3Y4s6lQ1?=
 =?us-ascii?Q?fBS3Ybqt4TtACL3m5bV5kjLWsnRY5D6fAsg+ialTuLC1Tvx50Fm1fkrbXmq1?=
 =?us-ascii?Q?7/ClFDG1z2dHqNjnKMdxBEHDuO3nbKYTnXq/lIot4iu0yoB5Kb+aVCfvudQk?=
 =?us-ascii?Q?KGpX4Ff/BALhPO8xTeycaRf6+E1p5RJIJQ6VI2QMBYzGkWdd6kuSHv61fyaH?=
 =?us-ascii?Q?3rLTBB50wsS2YcELjZLNYu0UywS/vM/T/r8UBTOCNQf8yyEwm7S+MyVRAFPm?=
 =?us-ascii?Q?2FiK5J3z/IOXfEQH4Pv1faeWx4ZpnuLQJd70/vfq53BbosYoNTmJzpMzT/5C?=
 =?us-ascii?Q?3Rp2LMbj1S3N2HvHOSvrSyaOG+3JuwSAFJy/UQJLgSbpZtenJ7GUp57ybDpx?=
 =?us-ascii?Q?b0tOgxrDNpHeWV3mjegfiyPzy5/Tq1//uZCqs+4YYNDrBE9wJphnlhLaixji?=
 =?us-ascii?Q?qYrtcfHQPkI7RaUGYUOvI1MjWjbwTEYjU3U+x+KkOZIq/kSabUWeDkuOc4pN?=
 =?us-ascii?Q?VcW1SMWoMkcVBC+UKBe31D7/MIYyY35zJDoUKsI7FltXWGyZpirNUmxvSmeu?=
 =?us-ascii?Q?GebJ4SuwheSI7MPi+3WB/1C+K9HqTdSXXjnmtUe9jJ+82lEokbncMqj8VWGI?=
 =?us-ascii?Q?vrRRImqothao1oancCx7VfcmZL8LTPHp0jlHCc7TdhlPnVQlek0uPOjifXFx?=
 =?us-ascii?Q?XR1hRqYG7Svb9z7EDkKX3nirV94ROQZhqEKHFm/yTpEoRu/2w+FRwU5iXw6A?=
 =?us-ascii?Q?8K1pWibi6BBPKmi+82plEK989I+WjAh693lJH2ZRFGclioVGtsXL80Bndxhk?=
 =?us-ascii?Q?EqfWeSRPGyOuC63bwTnAREIvcd44MMOXjKjDkKXLVoL2YMdA1b68e+gi7lL4?=
 =?us-ascii?Q?Fbf/4dNVT1Uh0bsbPecCTA8G3dG3OlfnxWOOOMJnPWwt+/8Lal3EFQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 14:19:26.2735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f65d6b-f6d0-4e31-5f34-08ddfd07b2d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4478

AMD IOMMU Extended Feature (EFR) and Extended Feature 2 (EFR2) registers
specify features supported by each IOMMU hardware instance.
The IOMMU driver checks each feature-specific bits before enabling
each feature at run time.

For IOMMUFD, the hypervisor passes the raw value of amd_iommu_efr and
amd_iommu_efr2 to VMM via iommufd IOMMU_DEVICE_GET_HW_INFO ioctl.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
Change in v5:
 * Fix build error

 drivers/iommu/amd/Kconfig    | 10 ++++++++++
 drivers/iommu/amd/Makefile   |  1 +
 drivers/iommu/amd/iommu.c    |  2 ++
 drivers/iommu/amd/iommufd.c  | 31 +++++++++++++++++++++++++++++++
 drivers/iommu/amd/iommufd.h  | 15 +++++++++++++++
 include/uapi/linux/iommufd.h | 28 ++++++++++++++++++++++++++++
 6 files changed, 87 insertions(+)
 create mode 100644 drivers/iommu/amd/iommufd.c
 create mode 100644 drivers/iommu/amd/iommufd.h

diff --git a/drivers/iommu/amd/Kconfig b/drivers/iommu/amd/Kconfig
index ecef69c11144..f4b9b1d1c3c7 100644
--- a/drivers/iommu/amd/Kconfig
+++ b/drivers/iommu/amd/Kconfig
@@ -27,6 +27,16 @@ config AMD_IOMMU
 	  your BIOS for an option to enable it or if you have an IVRS ACPI
 	  table.
 
+config AMD_IOMMU_IOMMUFD
+	bool "Enable IOMMUFD features for AMD IOMMU (EXPERIMENTAL)"
+	depends on IOMMUFD
+	depends on AMD_IOMMU
+	help
+	  Support for IOMMUFD features intended to support virtual machines
+	  with accelerated virtual IOMMUs.
+
+	  Say Y here if you are doing development and testing on this feature.
+
 config AMD_IOMMU_DEBUGFS
 	bool "Enable AMD IOMMU internals in DebugFS"
 	depends on AMD_IOMMU && IOMMU_DEBUGFS
diff --git a/drivers/iommu/amd/Makefile b/drivers/iommu/amd/Makefile
index 59c04a67f398..5ae46d99a45b 100644
--- a/drivers/iommu/amd/Makefile
+++ b/drivers/iommu/amd/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y += iommu.o init.o quirks.o io_pgtable.o io_pgtable_v2.o ppr.o pasid.o
+obj-$(CONFIG_AMD_IOMMU_IOMMUFD) += iommufd.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += debugfs.o
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2e1865daa1ce..b57a6993179d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -43,6 +43,7 @@
 #include <uapi/linux/iommufd.h>
 
 #include "amd_iommu.h"
+#include "iommufd.h"
 #include "../dma-iommu.h"
 #include "../irq_remapping.h"
 #include "../iommu-pages.h"
@@ -3041,6 +3042,7 @@ static const struct iommu_dirty_ops amd_dirty_ops = {
 
 const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
+	.hw_info = amd_iommufd_hw_info,
 	.blocked_domain = &blocked_domain,
 	.release_domain = &release_domain,
 	.identity_domain = &identity_domain.domain,
diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
new file mode 100644
index 000000000000..72eaaa923d04
--- /dev/null
+++ b/drivers/iommu/amd/iommufd.c
@@ -0,0 +1,31 @@
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
+	return hwinfo;
+}
diff --git a/drivers/iommu/amd/iommufd.h b/drivers/iommu/amd/iommufd.h
new file mode 100644
index 000000000000..f880be80a30d
--- /dev/null
+++ b/drivers/iommu/amd/iommufd.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2025 Advanced Micro Devices, Inc.
+ */
+
+#ifndef AMD_IOMMUFD_H
+#define AMD_IOMMUFD_H
+
+#if IS_ENABLED(CONFIG_AMD_IOMMU_IOMMUFD)
+void *amd_iommufd_hw_info(struct device *dev, u32 *length, u32 *type);
+#else
+#define amd_iommufd_hw_info NULL
+#endif /* CONFIG_AMD_IOMMU_IOMMUFD */
+
+#endif /* AMD_IOMMUFD_H */
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index c218c89e0e2e..efb52709c0a2 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -613,6 +613,32 @@ struct iommu_hw_info_tegra241_cmdqv {
 	__u8 __reserved;
 };
 
+/**
+ * struct iommu_hw_info_amd - AMD IOMMU device info
+ *
+ * @efr : Value of AMD IOMMU Extended Feature Register (EFR)
+ * @efr2: Value of AMD IOMMU Extended Feature 2 Register (EFR2)
+ *
+ * Please See description of these registers in the following sections of
+ * the AMD I/O Virtualization Technology (IOMMU) Specification.
+ * (https://docs.amd.com/v/u/en-US/48882_3.10_PUB)
+ *
+ * - MMIO Offset 0030h IOMMU Extended Feature Register
+ * - MMIO Offset 01A0h IOMMU Extended Feature 2 Register
+ *
+ * Note: The EFR and EFR2 are raw values reported by hardware.
+ * VMM is responsible to determine the appropriate flags to be exposed to
+ * the VM since cetertain features are not currently supported by the kernel
+ * for HW-vIOMMU.
+ *
+ * Current VMM-allowed list of feature flags are:
+ * - EFR[GTSup, GASup, GioSup, PPRSup, EPHSup, GATS, GLX, PASmax]
+ */
+struct iommu_hw_info_amd {
+	__aligned_u64 efr;
+	__aligned_u64 efr2;
+};
+
 /**
  * enum iommu_hw_info_type - IOMMU Hardware Info Types
  * @IOMMU_HW_INFO_TYPE_NONE: Output by the drivers that do not report hardware
@@ -622,6 +648,7 @@ struct iommu_hw_info_tegra241_cmdqv {
  * @IOMMU_HW_INFO_TYPE_ARM_SMMUV3: ARM SMMUv3 iommu info type
  * @IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV (extension for ARM
  *                                     SMMUv3) info type
+ * @IOMMU_HW_INFO_TYPE_AMD: AMD IOMMU info type
  */
 enum iommu_hw_info_type {
 	IOMMU_HW_INFO_TYPE_NONE = 0,
@@ -629,6 +656,7 @@ enum iommu_hw_info_type {
 	IOMMU_HW_INFO_TYPE_INTEL_VTD = 1,
 	IOMMU_HW_INFO_TYPE_ARM_SMMUV3 = 2,
 	IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV = 3,
+	IOMMU_HW_INFO_TYPE_AMD = 4,
 };
 
 /**
-- 
2.34.1

