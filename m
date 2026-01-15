Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012032.outbound.protection.outlook.com [40.93.195.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A749A2D8796
	for <iommu@lists.linux.dev>; Thu, 15 Jan 2026 06:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768457329; cv=fail; b=I6LOLDBNE8vTdmBV1X2bve81kXFh3m967oMz9jCUrQlscgGARYhbND05lF4hPJB7MGpDf1JJRBxoFXFeX58AVbl8HfIlk6EEh33ICt9jDb2PTEAJwurx+IkPcXZOWLLTJjQnAcpq72G0oydhymRpjxVuEY4OuVonrj89iCaD4dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768457329; c=relaxed/simple;
	bh=PI1QUd36k+LrAeSkkS82B1vqUG0k/26ubDhIUtFHg2M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ky8YX80nxkhSwPX4JmQCS5pnE4Pzf/wHAs/eQL0f2mjt0lQhKhGJsQ4ZwSYuWuDZg3t8rQPu1HCj2ZVj9TLMxGYkrkcL3QzFr1vMDoFYdkBvaK4Q4LueUDL9484r7CaxQqb9mPatRHTSOum4dArxrUOjCXeDtWIZAvTO36zJsSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=39YX/qUq; arc=fail smtp.client-ip=40.93.195.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="39YX/qUq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oplIZpdANHAQaT0UK9pxeLYhkqQpbsT5YLN6CZEOFCcUuGsr5cdVtjmLfSx5VATOka6qS2fH90F+Q8DOKxjIAE8MGsBHVUxY0vbjf2TFgQqWEQmxy2bITu/EUfZEgg3RjuHaWLZTK/UgTtgEL6mpMUiXPlHcYIEZ7iYRb3mTcZ2A8JUayOQCSJsz55gPauYKTEqV+UBL0tRv4fuXeAxV3ZpYTBzuUpXzmrACumzLp0cip2YyIk90wk9TjqngADLEYvGzG9VbiUUVvNF5oxZEEGhb8JvnCMoV6eiruX9TQotDfFuF5lRXw87TOGKWQJQ+waoiR2/XWN/NnVA2E3qFKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LzJMJ0OmT4PcZv2tOa6ilmRApJ6PJ+SwjLXVK54mxo=;
 b=o9D0YCEyh2uNTANhyH5GVHHbajVYe9BkoNmciUr/sfh4kIcPBR4G8qtKFSr+Qaeej49wIPdXYyWhEATAOXeazCXIAPnweN1G9enDfaRM+qEn1EFnMNu1XKOa2mi4Sx7UYKOyI96jmQlyWbrmEsSAw+F7GE5mJFrNLapoxsfbe8qWBhzI3cYLUxyeu1eLmk7aXTn5GKZAcW922lM5d4QrcWy9BtvUC++MtGoyl7SyxgBGmI7kJPtZL9rN8nDWdQ2tf1DcQ7Nyn5aCEvMCXQeiX+abEW0+yRujeqTDIwKMHVu2UOslEt7X5XBgUwlgbg2slRlisiRiZqLyPSIpV60A9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LzJMJ0OmT4PcZv2tOa6ilmRApJ6PJ+SwjLXVK54mxo=;
 b=39YX/qUqphZin1mDOYhjAT2RNa2i6ZnGkvUZP3yvzCGSBl9NTEkJ3Zy2czOLWOoYWaAKWerWcmp7DvACajhgotYL8RzFOMyyGP7gyEqdX7tYHqf2bElhSFDtYtW/26LBqA56lI797yn+dcP++NmjnfNXHAtOMnKw77reFvHHzI0=
Received: from SN1PR12CA0046.namprd12.prod.outlook.com (2603:10b6:802:20::17)
 by IA1PR12MB9029.namprd12.prod.outlook.com (2603:10b6:208:3f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 06:08:43 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:802:20:cafe::a3) by SN1PR12CA0046.outlook.office365.com
 (2603:10b6:802:20::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Thu,
 15 Jan 2026 06:08:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 15 Jan 2026 06:08:41 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 15 Jan
 2026 00:08:35 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <jgg@nvidia.com>, <nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v6 01/13] iommu/amd: Add support for hw_info for iommu capability query
Date: Thu, 15 Jan 2026 06:08:02 +0000
Message-ID: <20260115060814.10692-2-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260115060814.10692-1-suravee.suthikulpanit@amd.com>
References: <20260115060814.10692-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|IA1PR12MB9029:EE_
X-MS-Office365-Filtering-Correlation-Id: db888825-ef92-4b2e-983d-08de53fc8843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dHaBUe38lFYUlYm9B/o7JXYvMyS6QVDHi2f536ik2JsDzLhV8uQ2N+XZaAhV?=
 =?us-ascii?Q?YHATw5ZZE/2PeaHJc1j0TNCRGN3/5oDa79qmzAKmFl4BUCJeWlH47qSk8HMf?=
 =?us-ascii?Q?px/hjDVc8kuKdUvJmDGdl6Nfx87ywpajF8rsLoUcJ33TL9Ui82ixChC7gaZ3?=
 =?us-ascii?Q?I/ZofrnNde7Gyam3Txv+DrNF6wYxhsHNJ4EePPSQkc+qbkC9olqZuRLrX9Zc?=
 =?us-ascii?Q?/xrZFhEAxdNPEvj/JMGM278z36VRZlQ+VN0sVAcWkey7p3i1k9gTI69X9wv1?=
 =?us-ascii?Q?w9cyTvHJvXXUQWp2iDH/0fuN6QfD3PIkdVEQAwOqtplDnQbhoRkh/u6cGkEx?=
 =?us-ascii?Q?6lTO+VBug8nRhJsUCILZ+kBLHfQxzs05bQL1thUqT4EhKiHv6Afs6m/KZ6Mn?=
 =?us-ascii?Q?8CuVezD1hAvHLawiqrsy5hTI3n1i1C70MLSin2PBShE7xZyLnx+MEpnMyV3X?=
 =?us-ascii?Q?BNws15IetMA4DNAeAhmAFFJZjyG/kQqHvY3+1hPH3WSBfQa9beRO2HxaXbXH?=
 =?us-ascii?Q?uYOehuT1lq38lj+k0K2lFCCWWbKA8/IGneABnaAFhBdSDzRhqPAjXTnLHum0?=
 =?us-ascii?Q?jLqlAJ7lzWHZV4AgK+ZiU1kpJsihNG4ij7B7vO3U29UNHANC9ILc2vDLuqnz?=
 =?us-ascii?Q?PDZasrWi+v9QfypPSIw55oCqqEhuSj5IEc0FyjLSRbIQ9RcR7R7g5Mq3w+JZ?=
 =?us-ascii?Q?kKX7yb9XMOg55xRnhWJIuB3W4Oxj4K68ZHrcaGTqnPvbUVTLMHSsD88KA/Fg?=
 =?us-ascii?Q?UfxQn9aXBXdu56KQSaG93JlHiiwHd1xGBbVMBWXbFhQFBTM0L3/wWr2Ny23s?=
 =?us-ascii?Q?7N9eaQoqiZTuGQAsmMJwew0xpDW1FiqaCnBxdQ4cD5Z0z2Rp6WOiy8iikywR?=
 =?us-ascii?Q?25Emq3/KFgsFFKPChwWbaus7RC1whtWWN6ox1OcNvH7gCXn9v4Rh7cOiazYq?=
 =?us-ascii?Q?9rUd+trYAyZzx+ylofUsLMGXG1CT2U77vRpCc57wtCu9UVb9TPU+V1tDE08Z?=
 =?us-ascii?Q?JMStX3lu7EZgiknrceCiMuyfvyllo5h/L0dCMe1i1razffHv3uwelqyn09WS?=
 =?us-ascii?Q?L1NNKCyQ+3CgQ6EmA7Cz68wnWPMf4z3FV76Lhf7EoRZv7woRz+/+UbFxlFTC?=
 =?us-ascii?Q?mUirtzcfUQZK2vG12eXJhDArxaljMoqbgCsKxHP39qBidbTi+uSgHh1Zp2Nm?=
 =?us-ascii?Q?13W3+8HaY/+S3mNT3VGhKZrNp6OuxFSNss6AnOcu5DQuMPVE1c6mOKRwioRQ?=
 =?us-ascii?Q?ljlx9ZFO8bC+6o5glC8KdGryflPoLlifK/c9dMLjFta5RLTZMRCiAiNsFISq?=
 =?us-ascii?Q?7JMNAuAnct638T3lzbE4bHy1R5JK4AFEzWm3Ep2prhwTVBUauhzW5pb7JfGq?=
 =?us-ascii?Q?U6htEiZlsy6hPHcVsw4Q2nU9RG4decEbT9dk03Bqxao3T6gw0ITdnGoPmb04?=
 =?us-ascii?Q?xF1sZZnMQRUWhI6gWWBBGEsfMLdNnSvItO6L77a4ScLweXlTXYtIe0+pmQ/v?=
 =?us-ascii?Q?bvErZNnsAMnf+AI9fcwRRD06nESod/8dl1HEwG/n72T12MkMmhix/A1c0odd?=
 =?us-ascii?Q?tMNSlCfANOlwYRLKlyTqmexU9Ps44KK8suxhHBMnggguA6onhBmZ5ApiFivi?=
 =?us-ascii?Q?Tn+ENjM5/6uhf3J3HDrcBdXHB4l3mgY3cCLpPQBb+2fEm7iDriEpy8WdB8yY?=
 =?us-ascii?Q?cEpKag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 06:08:41.5562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db888825-ef92-4b2e-983d-08de53fc8843
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9029

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
index f2acf471cb5d..588355ff7eb7 100644
--- a/drivers/iommu/amd/Kconfig
+++ b/drivers/iommu/amd/Kconfig
@@ -30,6 +30,16 @@ config AMD_IOMMU
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
index 5412a563c697..41f053b49dce 100644
--- a/drivers/iommu/amd/Makefile
+++ b/drivers/iommu/amd/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y += iommu.o init.o quirks.o ppr.o pasid.o
+obj-$(CONFIG_AMD_IOMMU_IOMMUFD) += iommufd.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += debugfs.o
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 5d45795c367a..b6154c73e514 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -43,6 +43,7 @@
 #include <linux/generic_pt/iommu.h>
 
 #include "amd_iommu.h"
+#include "iommufd.h"
 #include "../irq_remapping.h"
 #include "../iommu-pages.h"
 
@@ -3079,6 +3080,7 @@ static bool amd_iommu_enforce_cache_coherency(struct iommu_domain *domain)
 
 const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
+	.hw_info = amd_iommufd_hw_info,
 	.blocked_domain = &blocked_domain,
 	.release_domain = &blocked_domain,
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
index 2c41920b641d..3db37f6042a0 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -623,6 +623,32 @@ struct iommu_hw_info_tegra241_cmdqv {
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
@@ -632,6 +658,7 @@ struct iommu_hw_info_tegra241_cmdqv {
  * @IOMMU_HW_INFO_TYPE_ARM_SMMUV3: ARM SMMUv3 iommu info type
  * @IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV (extension for ARM
  *                                     SMMUv3) info type
+ * @IOMMU_HW_INFO_TYPE_AMD: AMD IOMMU info type
  */
 enum iommu_hw_info_type {
 	IOMMU_HW_INFO_TYPE_NONE = 0,
@@ -639,6 +666,7 @@ enum iommu_hw_info_type {
 	IOMMU_HW_INFO_TYPE_INTEL_VTD = 1,
 	IOMMU_HW_INFO_TYPE_ARM_SMMUV3 = 2,
 	IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV = 3,
+	IOMMU_HW_INFO_TYPE_AMD = 4,
 };
 
 /**
-- 
2.34.1

