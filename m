Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010068.outbound.protection.outlook.com [52.101.193.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC623AF64F
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 08:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860182; cv=fail; b=gtIhanMfyWrh4sf71+tS/1cGJ8lFpd9rXVgAx1KJKpL7Ha5o0x7V07bohHHvnGjeLA8fyd1U2MgpL67UC+TDOoVp0bktif4U2Bet2pFM7J8svbU1YmyqPmpiHH+68gIDCNyIUtMbspYMiKGMZ49oEgakEG5Yf05Z6ONl6qw1QpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860182; c=relaxed/simple;
	bh=7mGeofOMudvB3WIQ1xuccfbfFyo4GQu5+TQAJjz519c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GcglxV5yNNzOdfXLWmiLf0IEJk3ZC+gAjuihujG3vPxE56LnOuSIoKwRer5IUgsZOCy/LEFOPeCmp8NJZ0A+7iMiL7q7QGsva3itbv3gsa/GFSjxSS+HL8kHqazVDdSDj4SyqDrpyRhDvSg4uTzK6yOnsZ0rNMVMdhh6rQeH7bI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EKvQ1P+v; arc=fail smtp.client-ip=52.101.193.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EKvQ1P+v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T5cqCKgfUrwd1i2ltbiUL3MWieN4puP11HTaPmsPyRZt5Xf4auoHr2HZvso9Q2CbVbkOpvTimFbUsgSSO3skMRVOUIh57jXhEs/jIIN58BUw0qB87On2WTePRIaR2pVDJNvDVJGElh+bDTnB/zH4V3oWwff2eB3H/wN0SNWWcPAx8YSo9i38u96Tek1N8S8LtmMOTvJoTNScnckeyAj8VMwaieb9l8SO7qMjkr+IxoHhdKOZWi8xYoTAGW/FDOrfuUc0zqk4rPUBQuQI0/qViZMEI/QC1vpzFu3R2A9vPsc2Kj/EY1XU3k/Bx8YWln6mlpA45maCFSoG+GAV9rlpZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EcoCwmh0PhKGyah+yMCqJcLkIwvP+TaYVA/hvA1aS+I=;
 b=w45i+PBeFtOGBtjEzxbSVwPvpcknGeoFgclffGaxxl1LlsdFBxaHnUwWYX/P0iWZXPqKtAAQG/CNu+MP4Jsx9psjqG7SfufLWDtAdBSyc7zRnjbR7SxjEp/PJYSE8mynQFON1d9mKzn2uevBQj56MmEhY2STiGFRS1gu8m2mv8WkQuIYTzLjdfjAV/bUVm/pS/lcDDWAdmtadhFDO4K7FkzRhfTfeuY2F/gRrjUbPdK0J93t6s7rZJ39fFDr4WQwnQF1E8vWqJoT6j6JTapgDC6J95So35ZukLQqdEmmHpdpUwlkskTOohpLmw4hKYU9rVcXJbackb8vhhhWzB/qoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcoCwmh0PhKGyah+yMCqJcLkIwvP+TaYVA/hvA1aS+I=;
 b=EKvQ1P+v77KLL+P2YNivF3wJJ6MW52EtSkb/a49RGuk6r45Kh8xjZUaVC+O6TtOHH0NGnHx2FIm10uGAcFK2RY+ANDkH7w/NhermcVP6NjTyd6GWamoTfblX5dO32UWinP/3kFQDpAdnr1HdP8ya1nENNZqEg6BO1pPbSHwmuLA=
Received: from DM6PR04CA0017.namprd04.prod.outlook.com (2603:10b6:5:334::22)
 by DS0PR12MB7780.namprd12.prod.outlook.com (2603:10b6:8:152::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 08:42:55 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:334:cafe::af) by DM6PR04CA0017.outlook.office365.com
 (2603:10b6:5:334::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 08:42:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 08:42:55 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 03:42:49 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 03/22] iommu/amd: Detect and initialize AMD vIOMMU feature
Date: Mon, 30 Mar 2026 08:41:47 +0000
Message-ID: <20260330084206.9251-4-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330084206.9251-1-suravee.suthikulpanit@amd.com>
References: <20260330084206.9251-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|DS0PR12MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: 74add950-1d8e-4540-5fa7-08de8e385657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|13003099007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	agXWt8ZDaWLdkJkmxALaY2fDioX6G6kldqxwyQhppGl8WAS7MlUStjEO2uK/fQ+XjGGZY/UHiXrv5Ba9FbGv8KfoIXhHHp7J7dqUsJy0p5Vhvb7FWIn9JUumHomj15JBDfOzDd+UI8vanbsLoziovewBNEp/KJHra9cNrR408kiqpDf4c4oTvXnPPs0TiIm3/vKErXShOlz4ZDeDGIVnweU8qgPmPTUXAdZC48yp/CMveG4nhFohfm5zk7GKUkcOb63sFTzUC0nrM4mRY03wpvDIoV6thRjTMsJ1qV7CNAS2MNuEYQxaOILRe9Seuj7zqC0uq5LXsFCj2PJzKhlTEyaGJUKptYsMdW+NpQoMmG09a1qtlvmrnywGXH8x00TivJ1jDpiJVg1BWiszuaobo/rRvY/DoMXgY2M93xaAKGMhDxtyPMM9n6QHPy0CtmcPzIyr2BNoaaNe+1QpA/jSPVxU5zOvCclDZqMBJf4TXC0jf5gI+roGbppTF1mKYUSdCyjQIytMTpt25+GZfTdSUuyv25xWtwQ/QaxzJISg/JsruP+Cnyy9IZvuu1RUEcN0MQs9kVzo9DGr8yPF+TmfPGPfUzjf1Y4K0aJYmdS9prMtgLGwszX7ZbN7/5l1fiiqyGlrzFjLyHtu83ECfuIMGPfwEgbIW/782OqE35H9QS46crU05G0+uHTRMWjXhFX5mLRTdK22G4c+47vAfkVW7fN4wasvEiqoidgUgq9U30M=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(13003099007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uI1bPzWxngpHiOMIOm3bIKXFpbs7BNXiA9mk7WrhnQsT4n4e0xjT3uySEUBROj0qPkF2sDRlM+bjFZFKAVaVi/rUoqnpxIMpHZBRQoAjHUV4/Uw9QAGJiRg7ZT9YNS7vqWxpiIvWGYlixu2BJZrteUoq86nU/zsTeS+fgfteG7zkgd1a/rbSITRIfH9qWzh6amE9qHZKFpe9gukeSA2tyjdfi53Spb3w8WFPLavtZdLeQpeI8GZ+jQKfvZ9B7RIHN/FTuBo5QZIrvwo3l0aLfUifLw7C6kru/oE0ddJKzagqvaFzl9Qfk+QbqsyKlq2v6mDwwbtbdOz0+n2a7lQybmtmsbZG1AMzeUYJPuc0GcPH+2OHYHYj42ZZ+FY7vd0VwabhMNrfd+DgQEqqxaWm5FmxIglEeWXjflMaAF3b9P0AinCAnCerPGrgpxT3B9s6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 08:42:55.0259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74add950-1d8e-4540-5fa7-08de8e385657
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7780

The feature is advertised w/ EFR[VIOMMUSup]. Please see the AMD IOMMU
specification[1] for more detail.

Introduce a new global variable amd_iommu_viommu, which is used to
control the feature enablement in the driver. Currently, the feature
is default to disabled. Once the feature is fully supported, it will be
changed to enabled by default along with a command-line option to disable
if needed.

[1] https://docs.amd.com/v/u/en-US/48882_3.10_PUB

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/Makefile          |  2 +-
 drivers/iommu/amd/amd_iommu.h       |  2 ++
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/amd_viommu.h      | 22 ++++++++++++++++++++++
 drivers/iommu/amd/init.c            | 13 +++++++++++++
 drivers/iommu/amd/viommu.c          | 29 +++++++++++++++++++++++++++++
 6 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/amd/amd_viommu.h
 create mode 100644 drivers/iommu/amd/viommu.c

diff --git a/drivers/iommu/amd/Makefile b/drivers/iommu/amd/Makefile
index 94b8ef2acb18..e1e824b9c7b0 100644
--- a/drivers/iommu/amd/Makefile
+++ b/drivers/iommu/amd/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y += iommu.o init.o quirks.o ppr.o pasid.o
-obj-$(CONFIG_AMD_IOMMU_IOMMUFD) += iommufd.o nested.o
+obj-$(CONFIG_AMD_IOMMU_IOMMUFD) += iommufd.o nested.o viommu.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += debugfs.o
diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 7308c6f1835c..c440f2745b38 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -33,6 +33,8 @@ void amd_iommu_debugfs_setup(void);
 static inline void amd_iommu_debugfs_setup(void) {}
 #endif
 
+extern bool amd_iommu_viommu;
+
 /* Needed for interrupt remapping */
 int amd_iommu_prepare(void);
 int amd_iommu_enable(void);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 31f7f426bab6..c5f779d76fc4 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -106,6 +106,7 @@
 #define FEATURE_HASUP		BIT_ULL(49)
 #define FEATURE_EPHSUP		BIT_ULL(50)
 #define FEATURE_HDSUP		BIT_ULL(52)
+#define FEATURE_VIOMMU		BIT_ULL(55)
 #define FEATURE_SNP		BIT_ULL(63)
 
 
diff --git a/drivers/iommu/amd/amd_viommu.h b/drivers/iommu/amd/amd_viommu.h
new file mode 100644
index 000000000000..45c2b71af4ba
--- /dev/null
+++ b/drivers/iommu/amd/amd_viommu.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2026 Advanced Micro Devices, Inc.
+ */
+
+#ifndef AMD_VIOMMU_H
+#define AMD_VIOMMU_H
+
+#if IS_ENABLED(CONFIG_AMD_IOMMU_IOMMUFD)
+
+int amd_viommu_init(struct amd_iommu *iommu);
+
+#else
+
+static inline int amd_viommu_init(struct amd_iommu *iommu)
+{
+	return 0;
+}
+
+#endif /* CONFIG_AMD_IOMMU_IOMMUFD */
+
+#endif /* AMD_VIOMMU_H */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index b1c344ed7dbd..a1cc6aa6f7dc 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -34,6 +34,7 @@
 #include <linux/crash_dump.h>
 
 #include "amd_iommu.h"
+#include "amd_viommu.h"
 #include "../irq_remapping.h"
 #include "../iommu-pages.h"
 
@@ -193,6 +194,9 @@ bool amdr_ivrs_remap_support __read_mostly;
 
 bool amd_iommu_force_isolation __read_mostly;
 
+/* VIOMMU enabling flag */
+bool amd_iommu_viommu;
+
 unsigned long amd_iommu_pgsize_bitmap __ro_after_init = AMD_IOMMU_PGSIZES;
 
 enum iommu_init_state {
@@ -2198,6 +2202,10 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 	if (check_feature(FEATURE_PPR) && amd_iommu_alloc_ppr_log(iommu))
 		return -ENOMEM;
 
+	ret = amd_viommu_init(iommu);
+	if (ret)
+		pr_err("Failed to initialize vIOMMU.\n");
+
 	if (iommu->cap & (1UL << IOMMU_CAP_NPCACHE)) {
 		pr_info("Using strict mode due to virtualization\n");
 		iommu_set_dma_strict();
@@ -2291,6 +2299,9 @@ static void print_iommu_info(void)
 		if (check_feature2(FEATURE_SEVSNPIO_SUP))
 			pr_cont(" SEV-TIO");
 
+		if (check_feature(FEATURE_VIOMMU))
+			pr_cont(" vIOMMU");
+
 		pr_cont("\n");
 	}
 
@@ -2303,6 +2314,8 @@ static void print_iommu_info(void)
 		pr_info("V2 page table enabled (Paging mode : %d level)\n",
 			amd_iommu_gpt_level);
 	}
+	if (amd_iommu_viommu)
+		pr_info("AMD-Vi: vIOMMU enabled\n");
 }
 
 static int __init amd_iommu_init_pci(void)
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
new file mode 100644
index 000000000000..f4b5f96d4785
--- /dev/null
+++ b/drivers/iommu/amd/viommu.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 Advanced Micro Devices, Inc.
+ */
+
+#define pr_fmt(fmt)     "AMD-Vi: " fmt
+#define dev_fmt(fmt)    pr_fmt(fmt)
+
+#include <linux/iommu.h>
+#include <linux/iommufd.h>
+#include <linux/amd-iommu.h>
+#include <uapi/linux/iommufd.h>
+
+#include <asm/iommu.h>
+#include <asm/set_memory.h>
+
+#include "iommufd.h"
+#include "amd_iommu.h"
+#include "amd_iommu_types.h"
+#include "amd_viommu.h"
+
+int __init amd_viommu_init(struct amd_iommu *iommu)
+{
+	if (!amd_iommu_viommu ||
+	    !check_feature(FEATURE_VIOMMU))
+		return 0;
+
+	return 0;
+}
-- 
2.34.1

