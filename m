Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2051.outbound.protection.outlook.com [40.107.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DC51E7C03
	for <iommu@lists.linux.dev>; Thu,  4 Sep 2025 19:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757014302; cv=fail; b=nwsRiHM8q6b0YoafUEqEFi5vYpqLPnC1tl/PkLvnZpAxM3EGyONe/Spzil9Te252bcV/5Da467MTK0Iq2jxbPt+sgQmx3d0yuMQ4RlkO1l34lLbm/5w/pfequXY1xc5OUVpyc39uYN2Rccf6zS/FySwPkKnEhWVg0qm+Yk8jbVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757014302; c=relaxed/simple;
	bh=Sq15kRNwG9EVtJFfSTbbBWejPS0wjX61WhbzBD7dOSI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l4zxbqz++O6H9BlDuNF3MW8WjYdgVKNFmZCL+JsXM+qyYOPr8Hb5WOBVPLe+IzNdEsTzvnPoe2BCLYbMM7fthQXtkYrf0ildNCDbor1Pjrcr4rJxnNwi1LXXUJD2/82nkTzsSWLZbOrCFJI8zz2A83qC2/JRHAjqyQpC+nTcPfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zH/+NyOA; arc=fail smtp.client-ip=40.107.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zH/+NyOA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zMpIYT9XlW3INCjOQcnn1mu+9qTknSk6DYzJUjPqQP4WnnZbnSTNSeSdeRnc+su2Knwx1cf2ZDXAOaGsxBgXhkb2Fu9tG2M8ivRl+4l7eCNMXsdLK9ivi2vUvYlzhh9r4kUUW34zeEcuvf6UaKK+YjnljTHnmkj7sZWwYp/VLR9MNL5ku0VX7EnmchIagSCP5RnrkhFqWmQRdEZrVEtCCRAXxpB/n+XIcLTG9EFnkzv2e3yW37UnXNlKuUM+bDBK9HAyRXlvTzabB8iBMKJBDFMG8ZhioQw4AUkxBzWY5Q98CS2rXInbA6juOiyyT7GkuwwWYPPJEOWiFILCzz5Q3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FINbIIV+tI4jtqaCzg0cpyiMfsj3gRpTf5nmLJuA86Q=;
 b=flBI0GcUPZwOmttkU8YoAakNpM5sBh3NKJgwZZSuo9P+6S+ex+55kx2wu6GHwH+78nmCzM2Yru2j6SpaYdYsB2ib5LdUgiRNkOn2qoZywALq/1g6pj39XXYqJzC40Li+f9t3mlDXOd/vTy+8G0g1FhhmzSWZIFjTNSLlAesbDUuM/rNerognlCKr7M7G5FLzL8ENmUlhGpuKkrp76VjgdS8alvAfQrIp9yAl3WKpYAsNTxAJt5yyDFgPGiQK3zRVO9H9bgZonGM7e548dFTJYrA3Y0oOvtOzC9zTzrzHIJYmSBkNzPfrOGPxfzB54pJm45AgFelonE+A2iAAYsINGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FINbIIV+tI4jtqaCzg0cpyiMfsj3gRpTf5nmLJuA86Q=;
 b=zH/+NyOAPf3HLi58AIBswPszedhkza5HA7cec+U++n7GhQVXfwNhauLdYV5WAheXqcKiSGubTlEO9jo/wRLk+2XN3XSIeI1TpjqyRY4aly1OZxoBrRmyfZSjezCvR2NOjjoCHD9XBeBXjYWZMwHv2FOjo28VannUNKNH/0yp8MU=
Received: from CH0PR08CA0030.namprd08.prod.outlook.com (2603:10b6:610:33::35)
 by SJ2PR12MB7893.namprd12.prod.outlook.com (2603:10b6:a03:4cc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 4 Sep
 2025 19:31:33 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:33:cafe::d6) by CH0PR08CA0030.outlook.office365.com
 (2603:10b6:610:33::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Thu,
 4 Sep 2025 19:31:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9115.0 via Frontend Transport; Thu, 4 Sep 2025 19:31:33 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Sep
 2025 14:31:33 -0500
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 4 Sep
 2025 12:31:28 -0700
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <jgg@nvidia.com>, <nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v4] iommu/amd: Add support for hw_info for iommu capability query
Date: Thu, 4 Sep 2025 19:31:12 +0000
Message-ID: <20250904193112.7418-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|SJ2PR12MB7893:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df6eef1-c7d0-4785-9974-08ddebe9a7fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oacEigGl80NxLovzmqNq5VMD6hF0VwJ/VMpoIkU8wF1OEo5Rz8QAkBAkAWVM?=
 =?us-ascii?Q?ZfL7Lj/2nHquPhWDaXOqq34E5dsqTvvnGe1EISq1hm2Px9zKcSaFORcTp666?=
 =?us-ascii?Q?GHYoEkB6AHUTRxEUR/LaSHxnC9a5nwkJXaExgk3Gt3iyY4HYW6R997b28Tjg?=
 =?us-ascii?Q?BquOCoHPVH+5HhFrEZCIqkcDoH7WmtPUTwBTtlT3xzKRSr0ZzjEao/8tVxpa?=
 =?us-ascii?Q?7CDCr4LxEtOQjHocEIx+J1SEujDR8SFPMs1D89MTXqEj0jGrAxZabJcozrUA?=
 =?us-ascii?Q?z8BXz4YtL6UaFnYCXWMkeELmRMFCq368wdjKChCS2Hw7rG0OYTgOy+Arf6uP?=
 =?us-ascii?Q?6eM8VQpl+0Q7wiC2IrGsI472mIbRdOPHBAwIFLhUwGV316KVhxJ6jXkb1TmP?=
 =?us-ascii?Q?1izFWBQees7A9kdCAc4pc6VljIS3brmP44fnskrd58HPliJ3MHPniOFjHS4A?=
 =?us-ascii?Q?53ZDylZERc1K+akH+z2RRtWaBILM+ZtzLXsnVedGVX2AAQ+4nk+pLVJsSFYR?=
 =?us-ascii?Q?hgUHAC28duyEVcpADFHtt4uVam1xKjlHymnmaAVGuKo+mD3M+fFmQXlsBAIv?=
 =?us-ascii?Q?rXBC3Iuipymv35Jo3LsGf2o4AjpGU/vR4Ea8mNOJUo9VFv08BKk63/A/AfMq?=
 =?us-ascii?Q?fadAPOj5+wU7SCtJQ3XnoXZw943UddkrAHkUUQmt1XhsEk+WBeKG8Eq0zh33?=
 =?us-ascii?Q?e5jSnvSnCqUFyir7RGXMPa1cCf+OnIflTFq073mP1Y/6OE2H4W7FfGM9Dz8L?=
 =?us-ascii?Q?FfNRqUBLS1ScuY89RwM/k5z9FYuF7UdzDMDdFzLrVh/RBQlMw4ZY+4Fs+Bay?=
 =?us-ascii?Q?onXihKEW3M4oI7Scx8Ss/04vLez/RzTBdvioyjm2kzWx/DkR3le+VtRj+xlO?=
 =?us-ascii?Q?e4n3+FxCNu4de7yAzWpfm+HvVr2GwVw/D9QTB4ehGDHZZ6MebtFEGKE7/yIF?=
 =?us-ascii?Q?SEyaFwdvfSrkplWJy+WCiVuQd8bsuvRMqRt4lBY7pNbizlAjr2EefajsOP9K?=
 =?us-ascii?Q?rDmJtyzEJn+YrBbdgESSyj6Ax7E6WdvYICbXDzHMU7YJ+BhBZHwtjhARbF4k?=
 =?us-ascii?Q?Q80zFqwdiFegnDimQPkx3+n6tLDjWv1mAEmOMvZ0bgVo29DM/gqrebz9B96a?=
 =?us-ascii?Q?iaeDRBQlCb/91Uwm9aiIHM5IYgu4hOe4s45a2jCzMsl2ht5sHoUqrmcoL5wh?=
 =?us-ascii?Q?hflCpF1mk/dsaaGjVN2bl7VvMaEAVN5JOK5l3dikHRp7lLc7zKaVk3f1v32u?=
 =?us-ascii?Q?/ZWUy9AopkkKI46pGF1OenFVitgBlMRyUHwEt7tL+MtahMvHiaapySnLZRdB?=
 =?us-ascii?Q?0+0luXInnAXd7PvduIc3Ccah/+dvyu7KGsjwvqj+ncL0JV8nHzDp09vHa9LX?=
 =?us-ascii?Q?Tje4VUGvBrx6GYW2omu9rqSwAThZRG0CsRgsQ42ONVwkDjo7POHhWp3rNJZ4?=
 =?us-ascii?Q?YqZJnH5rTBV9CI0x4+W32FzFWXpVdlnszO63H2tOcdL2a7gUhzLB4w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 19:31:33.4061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df6eef1-c7d0-4785-9974-08ddebe9a7fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7893

AMD IOMMU Extended Feature (EFR) and Extended Feature 2 (EFR2) registers
specify features supported by each IOMMU hardware instance.
The IOMMU driver checks each feature-specific bits before enabling
each feature at run time.

For IOMMUFD, the hypervisor passes the raw value of amd_iommu_efr and
amd_iommu_efr2 to VMM via iommufd IOMMU_DEVICE_GET_HW_INFO ioctl.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
Change in v4:
 * Add CONFIG_AMD_IOMMU_IOMMUFD
 * Update comment regarding EFR/EFR2 from struct iommu_hw_info_amd.

Change in v3:
 * Remove extern
 * Fix link to IOMMU spec
 * Update kdoc

Change in v2:
 * Do not mask the EFR/EFR2 and simply return the value reported by hardware
 * Move amd_iommufd_hw_info() to drivers/iommu/amd/iommufd.c
 * Also support IOMMU_HW_INFO_TYPE_DEFAULT

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
index 000000000000..8b726482778b
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
+#if IS_ENABLED(CONFIG_IOMMUFD)
+void *amd_iommufd_hw_info(struct device *dev, u32 *length, u32 *type);
+#else
+#define amd_iommufd_hw_info NULL
+#endif
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

