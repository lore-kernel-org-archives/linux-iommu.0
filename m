Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012030.outbound.protection.outlook.com [52.101.48.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FC32356D9
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159029; cv=fail; b=uOO6MKhcmr6l4yf7xF7cRAbK4tB4yoiBy1uhx3XJ0drQzBg8FE1hcQ6GW4GmE8yD/OG7O5FWyEeIhYI3FWJRPucro7rCGq6wmN57HvMS4T7zQkLmfKyNSUijRF5M6rQxDNfiwkv2lQ/ENAjdV1UyhaIR1v67MQAzKquEuyx/X5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159029; c=relaxed/simple;
	bh=EPP0u+2xKWMNKyNMo0oEe6XuDZEpbpa53BVUWVp3zYk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DFPS9ONb8xud+3JM1Jy+ZqaD9lS3dPIOF5x3qSUEd5tokh2ZgC43z55HXG/FBHW6bPKXD3zGfi25Rt+msDU2KSAbKU6BUUaPrHUaYNokGUfGaCmIy7d34gIbhIWvMtYeRfotZlGsAiRiNdPW/gU1gps4Os4sXOoUqaJpMygU1RQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2eItWy0r; arc=fail smtp.client-ip=52.101.48.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2eItWy0r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AGIc9/wSLArm0XoVcrmB/HnvWDhN7JAMna0TIXzTG0pik70oiKZkXxJNRAF6BLSpPxIqL9Uh1poLnuhhFO7GPvSN5u6paCaiDEyaFuiOok0EJor8gfjAKzR/xRXK8L1c4mSacXDhGwGL1pDBiROyFP6rWSFAjY+8o6j67/5L6s45Kl2VL65L95OVdi8VwrQTg/lK4hllt5xF38Fnx2hYGHTYH4DQoACGu6zThcPD5kC8aS+Qfef7ndic0Qho/vGReYFS60JPnww7yfkE+gFjsg8dqYkQDuyvFpWGCOOLtBOZexGFiJCo+/nd4TtVhDkCKQaUe8v2ZEitPKDNZlQiNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmia6YxVNdPDP0mmguNRwosajBniQt5DJTE/NMEYgJA=;
 b=FdUHt4KAj200w61DLxm1pFBj2OGbeJw/GnJcDxs9z2FpXtDT52ugM97irY1Nsd6IMGMqTqGUilVMs99iHXM81/ueWmsIs/jw4x8ayQgHuRYJ+Q80ISjSYpMvD2YwxwxNiauSlQBWQu//7oUXF6ub0Z/Y6e4/dgnivc/TcMeg3SurZ0U+crysF6c71WbmBwBF1/qTYRabVwpVPOEe6xvOEKw9Q4APZbW0X/dvATAL2s65ZgALVe4EnG+EQsYykEn52sNFnmQitbiTp1Pr+Q/+2tw7BZi1E5rYpqJLvtVtko5mVkshwtHxSFK8Xsbym5HPjxf+umycdE7di36/McQ/cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmia6YxVNdPDP0mmguNRwosajBniQt5DJTE/NMEYgJA=;
 b=2eItWy0rpikOeZZp7TCRbbM3OGzsSDbazoilQshAepOY/pHfhokdC+lGA8fhLvfxVCfaPYkTm1yUZJsSuP3rXreQVXVh8t8+5BTKzU2/Z9BQpQnh8gCUAVKOk72jNJiof7IBqenic+4ouCaHawkgVjAvTX3Ad1AxVBzeVIaSsp8=
Received: from PH8P220CA0035.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::7)
 by BL3PR12MB6378.namprd12.prod.outlook.com (2603:10b6:208:3b1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 13:30:22 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:510:348:cafe::34) by PH8P220CA0035.outlook.office365.com
 (2603:10b6:510:348::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 13:30:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 13:30:21 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 08:29:46 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>
Subject: [PATCH 03/24] iommu/amd: Detect and initialize AMD vIOMMU feature
Date: Mon, 27 Jul 2026 13:28:52 +0000
Message-ID: <20260727132913.22475-4-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|BL3PR12MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: 7925ccde-d9e2-4f11-6364-08deebe3355c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|7416014|82310400026|36860700016|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	k9O3qSIOxOOhiER09MuMB+LQGhDR5Xgkgr8e8Hg45plCGOxH4OWThT9BIm/pfr8a+4dT8pDxTDiydTp6UPiI3YTBRzEwrwpkl8LXjOgUXpNrLjvmwiDH3BMsp01E5bwFajEDy0UxgKj8YQrO+6P9CBcWCzH/B+wQopP+fa0js6AmFV/oVofQax8z9w5VkabQk5FS4XKAtmEUk+bTUIPH5r9APJqwg78/NkoSoX93F7ihg4fTgoNa1J3h0dfALj6Xm5UkUvxzcsQaou+7XqL+KwDFeeM3tlUsXBOZnt9tTvJImR9lKoWabSGmvnz/N0Oeum8VQO620l4Ki7tyxeNdsVDB5Vl2PPqg1AM63uJFxoRKwFfpQwNqcHZyDHB7A0Iz3A6K6n1lSdjvZmlo1HWY4R9GC+3i1g+pVA39Gh2nhnQPTEmI7fi10YV9ZWVxEF+h9PMFQUvUribi8Rft7S8ESbUtqAJyeuvgE49/GH1noV/IogFr2cmPRMtE6Il+2szilf7kyvWQEOXhAXsKuA+V1OTDXVofHSoeCt5X+E1gL+9Pr7jJpa9uPbIbK9vFF4/0y3GTFsSchpYI9pIx4oBwppraX/Enr0xhMEN6w/iEtTB9X9Rjhsw0WUUJk/gL/A2mZo/BIDCCMmBHvczgFSTohTNtLlDzxH14B0ztguklRV24Eh9QoJZ36wBsXiLfHA+mYAEhYzT73VD205DDPCUBug==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(7416014)(82310400026)(36860700016)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fx2kmGQifWpg8o1nmHOXyEYUrWUjap6Dh5OTvoVgq8fmzH0X/3CpoMTAAcMiiJ2Znd/dPnk0mrqTeRKC1rK2TKu0v0EXmAzk6qTc/WJmmbLKmVu2Yf3xo4q3fjv7jAljhml87mNBL8FoRRr1SFNHSdqjYeY5z3Et8Zw1rnPY9AC7skvfRd7zttKk9XUT4DA0oBOBYihR7gElkIA8EHCCYf6n+OJqiztOZj9E/ATbZ22epwdgH/9+uhvnZyxH6WboAW8ckMvao8eOC3+rJqvDfI/880u7vxbqRP1NOdHrJkg7d5OOcUhgujIj3hybwnZnq2uc/FWxSYZjYUbPlidDZCrVqFqLzY+0yOHxjNsSsHBgt5EjEhFY4/iLUKAU7mGkQ3VvBBYMdWHSgzkzjXo08NJwSVPeL2P0bFgUQ3l8ZPE3ZjZpVe4rhp5/c8ydA3Fl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 13:30:21.8080
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7925ccde-d9e2-4f11-6364-08deebe3355c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6378

The feature is advertised w/ EFR[VIOMMUSup]. Please see the AMD IOMMU
specification[1] for more detail.

Introduce a new global variable amd_iommu_viommu, which is used to
control the feature enablement in the driver. Currently, the feature
is default to disabled. Once the feature is fully supported, it will be
changed to enabled by default.

[1] https://docs.amd.com/v/u/en-US/48882_3.11_IOMMU_PUB

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/Makefile          |  2 +-
 drivers/iommu/amd/amd_iommu.h       |  2 ++
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/amd_viommu.h      | 22 ++++++++++++++++++++++
 drivers/iommu/amd/init.c            | 15 +++++++++++++++
 drivers/iommu/amd/viommu.c          | 29 +++++++++++++++++++++++++++++
 6 files changed, 70 insertions(+), 1 deletion(-)
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
index 9f961ccbe3b4..17fc0b5b3fa8 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -35,6 +35,8 @@ void amd_iommu_debugfs_setup(void);
 static inline void amd_iommu_debugfs_setup(void) {}
 #endif
 
+extern bool amd_iommu_viommu;
+
 /* Needed for interrupt remapping */
 int amd_iommu_prepare(void);
 int amd_iommu_enable(void);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 4df6a50128de..b5327bf6814b 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -103,6 +103,7 @@
 #define FEATURE_HASUP		BIT_ULL(49)
 #define FEATURE_EPHSUP		BIT_ULL(50)
 #define FEATURE_HDSUP		BIT_ULL(52)
+#define FEATURE_VIOMMU		BIT_ULL(55)
 #define FEATURE_SNP		BIT_ULL(63)
 
 
diff --git a/drivers/iommu/amd/amd_viommu.h b/drivers/iommu/amd/amd_viommu.h
new file mode 100644
index 000000000000..f08ab9ef23a9
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
+	return -EOPNOTSUPP;
+}
+
+#endif /* CONFIG_AMD_IOMMU_IOMMUFD */
+
+#endif /* AMD_VIOMMU_H */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index d4dc9b2a50f3..5ac883429ced 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -34,6 +34,7 @@
 #include <linux/crash_dump.h>
 
 #include "amd_iommu.h"
+#include "amd_viommu.h"
 #include "../irq_remapping.h"
 #include "../iommu-pages.h"
 
@@ -196,6 +197,9 @@ bool amdr_ivrs_remap_support __read_mostly;
 
 bool amd_iommu_force_isolation __read_mostly;
 
+/* VIOMMU enabling flag */
+bool amd_iommu_viommu;
+
 unsigned long amd_iommu_pgsize_bitmap __ro_after_init = AMD_IOMMU_PGSIZES;
 
 enum iommu_init_state {
@@ -2188,6 +2192,12 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 	if (check_feature(FEATURE_PPR) && amd_iommu_alloc_ppr_log(iommu))
 		return -ENOMEM;
 
+	ret = amd_viommu_init(iommu);
+	if (ret) {
+		pr_err("Failed to initialize vIOMMU.\n");
+		amd_iommu_viommu = false;
+	}
+
 	if (iommu->cap & (1UL << IOMMU_CAP_NPCACHE)) {
 		pr_info("Using strict mode due to virtualization\n");
 		iommu_set_dma_strict();
@@ -2281,6 +2291,9 @@ static void print_iommu_info(void)
 		if (check_feature2(FEATURE_SEVSNPIO_SUP))
 			pr_cont(" SEV-TIO");
 
+		if (check_feature(FEATURE_VIOMMU))
+			pr_cont(" vIOMMU");
+
 		pr_cont("\n");
 	}
 
@@ -2293,6 +2306,8 @@ static void print_iommu_info(void)
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

