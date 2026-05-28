Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010031.outbound.protection.outlook.com [52.101.61.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13462C11F9
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 05:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779945504; cv=fail; b=fvX/8ob3y8VaLQaOlb0ZkfE0TTbnGt9T8d+YOWtC3iq5Tdhfa1Gult9F9eTXwmhfvNhH+tqb+wBOcufgKD09Fe2X4WQ0DQFjBoo7PuYesnaHXM9Y3lZkrVHalFBJt4Ve1R9mtSI9/ZTK4dIILe8yEsHct4MCvV7JNn89/L3to78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779945504; c=relaxed/simple;
	bh=K+1tNmuKOFLBdKYHTtUZWmKcX25lJvXGj1tIBwux5JQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SyXifqCJ8NSLnwm9BZvlz5boC2C27PSqgw/RVVrfh6JQFxgjM41wkLbp43nrhSMER2eUst46sNz5QG5OUiQx0UBsjUcrYZMG4FG0cqnVT3QlYwGYbyKvi73eQbXOoRLfOsMVcPiHDEgc1ZaOntDGvtjYXeZlH/YPu26EsVyO4hE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qi5GBaX8; arc=fail smtp.client-ip=52.101.61.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qi5GBaX8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PhnP4w+omj9p6u5uffTg7jkP+DkegrjvXE9Q+BZjWtzVIEuXjqPzriFeBbpn4M8KjTSFjTZdj7+iNP6e15vTKlVzeL1t6dLGFITyZ005OU6J12rpC6EwSt7Sge4V0ojs+XdEHqzCVHaaBTsDWV5NId1owurA2L8VoEzrQn8ps5Y0JGpE3ULIGc8+rwmObwK5ED9EJfTRXCFjw5UnQWntLjG2nkxV6TtT3UaKz0xpES3NmInnHFuXhdYN5Dnw45ogXTS6pZC2WYvx1sbzOdWQeK6X0I0g4AayzwZftLmPR/+Vwkwl142Tt3O31iRGFK6iMnK/mECWvexo0GFDAwsyfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJ7yr/9aWp4x0Ijjw6sQZ0oasA/e+Kcq7Zw2G4tNyhE=;
 b=hGnj92rwaIUpOB9tVKD/Ke80mheYGRxeMY2aSLWWPlQCVGVqHwFxN+Zqb6SUMx4glWUJvoXhORWaPJK9RDIxLeDtaPxEbVb31ZwsqeF9TxYbXR9Hcp0Qyr4zmZLx1iGLpLmzZ/TqTyernG0to8dETPouONbRRGmMKPJeqRJYnyfbLBjZwKczJFBLOpQ888Grbt4a5zXsrhRpjMcqyT/pONXTk4c7eCVJUI+1KJF/TU/Y1Ba1bGux1hecL+R6WrvzRdM56XzhutZecWY0GARo/wuRzvX9ZdI9y/woqtveu/3Q6Uxs17GcW7ed+vCSczxL0tLXXFNtu7xRyDInpR2psA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJ7yr/9aWp4x0Ijjw6sQZ0oasA/e+Kcq7Zw2G4tNyhE=;
 b=Qi5GBaX8wrjgRid0dVGBr8C9dy7AvA5nBWibIqaz9XKoRfbLKCixcGSEyKz2gDAj2iMeRzlEXSycMyk6zHvpKQbjTPGloxQnSW41HW/QDB9SSeZMQnNInloVpBx5yN/dLXUTAlt83jEWLqT6jsPMDJk/4l2QDi2phgMy7Fmzw1I=
Received: from PH0P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::21)
 by CH8PR12MB9742.namprd12.prod.outlook.com (2603:10b6:610:27a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 05:18:17 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:510:d3:cafe::a5) by PH0P220CA0022.outlook.office365.com
 (2603:10b6:510:d3::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Thu, 28
 May 2026 05:18:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 05:18:16 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 00:18:11 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 03/26] iommu/amd: Detect and initialize AMD vIOMMU feature
Date: Thu, 28 May 2026 05:17:15 +0000
Message-ID: <20260528051738.596013-4-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|CH8PR12MB9742:EE_
X-MS-Office365-Filtering-Correlation-Id: c4bae7f8-2210-4046-dafe-08debc788642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|6133799003|13003099007|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	6lt/nRWtzHovcLiWmeonz/n39q6PgR1aPcEaVENMsetXLVVN6VkisZlS8YpJ4r74ZWcYAyukstNhi5ceaKonq5ZUsIAwL34D/bsFWt34ATVMGJEeuuvlCoG5X2mE3JmtQZ6dRX2Is2wxtizhO3lWrRiWpP9MuyvnBT963Jx4flXnKfRkIfCnCz8+k5T1f9VPjD5UB8fkKQ3Z7+JrzSAt3SplYr/wnZ/DCUZbhaePzjptH5c088pRNc6OXqoZSXm+WNR9p5WBqFKizvmob9djeXHJMVxYcxUN1ZgexrrV3FsFnT0zJ2u4EMex+MyWd3+VwmuU32nzOmF/I0vrX8uvrS1yKRBwuXxQoiOLUs0p9dwOuS6vVsfASvPUfqCyOMbZ/03pPT7ro6byv8S4RvxlVgYZdLM0VsVdFyjL1ERnF8fbOyGw0Hf2CPZlF39xqdNV6hr0mu0tZwqyqkl0ErJHsydth0WX6KQSNRiNGj+NZjmddjh5ckaidoaLnAQUj+l7jBeLqsFO/318ZuC3VKq3AdPdwmLWC5KWs+ujpliFFDR/11A1ZmcqD3hSwfzKozrQIgA6WWllAUmddSk2VDT22pBl5Oz54+eySc2qeMqaIwMRZtxNC5gG2rit0jqs4iXR/iyCjrQksEEyK9InGj323CgjPlQS5vWfSJnfnNCpWAuQMY/nKRWYKjdE6pZGc3VBJ3Y4yzsZ9H2g/JHhwGln6Ceuxteiqn1TqMOVIWRg3a8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(6133799003)(13003099007)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aronNSBw0wZIfDi7s8FgEjgWpKAN7RiR0lg5OFC2sCc9/NdP/BTDuLVFqRMtH0EXNweT8L8d7v8ejrWfHGpB9b74v1EhtFsXnNVs3KwjAP24ZBZecrzf/0ZRCei+yXp4dnDhj6sgmBGUKRiyH1gZyALI3qoumQQ3kZCNi4KuAFKWuuJY7ItoUwkRmqAE+TjhpmRKNBAv2x+npbwMJbWNIT4PHl5PgGFijJXkdJ193QTGWZPAqHLo9eaNxNrw8TLB/bnGL0QCRW4vQMxVZTnNrNuHPVkxoqU/rJXkS7zQsUudHdqhhDOQbZi7OqBF/EUOt35FUUmhtO6BwOhQI0fBjNiiTdSaggUfr96Ljq5rRPK3RizgfJbkJZNnnNlPyaz34xlFi0du3Q9Nxxss8AjJNHQcqsEk3t0pAZmDmXZ2mvF5XJ5ANZRG1yY7wfhl7Quj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 05:18:16.7463
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4bae7f8-2210-4046-dafe-08debc788642
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9742

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

