Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012000.outbound.protection.outlook.com [52.101.48.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B685427A16
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 15:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747725; cv=fail; b=Ea+ZHPzmBaQwzYoaTWzVXTXilFZT4rvd/OogOHPqdo+XrOJkxH/RkkQxbpL1N8MZ8J4uQH7PZjazqbIJGx7fEiTti72G7bVro5g2dQ+FNXDFIn/+BbEJ8aRGy98phv7RAN9xEGCf1xPXB9KFZT/Y4/xY2TegLyzdhMWAaXS6VRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747725; c=relaxed/simple;
	bh=EPP0u+2xKWMNKyNMo0oEe6XuDZEpbpa53BVUWVp3zYk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i51MfWWnT43mc6p8sma54+Q8Ryx8o1hbxved0xE3GfmbsJJ5ob+PPzV12IlsCVz+uI+9fJt6ZOZiDoRb7EOvQxVI94CVuLZ15q5m8mX0/OYvqR0xnZAhJlTeWU1cAcARBBRiGuEU+T9R10QrO87VcIZiYba0wd1HLKZ+XnCAPjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q8/6Wm0z; arc=fail smtp.client-ip=52.101.48.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q8/6Wm0z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=If3LM7QSK6011NfU6Yt3bDDSHUhmKlk5dDNKVtlTMkVabH0QEmRU0iYHhY7/9kZiHQLNHKWV5LEsdNpxoc5CQXeTGRGwUKtugW5mUvo80bThb04kI2j8Z1KLjMufOq0mcPmf+tsDSyKF5hDqPyssNTLdhssdEDBi2u7xp2mYVR3Sm0BaLUBxTvggWZ9QkeW8oY/MrJooKt3wBXW6JQEnoRh83NGUcyl/VdBRcW7gjUDqR5JfgW43LOTSJExTTcq5xBYuESMSUYnF7GPBGeyEhTBsa4jmpVw+PcJzS3V56TMWyQSYFqh5KEnuf9KjgI3SrXZ523KAD+ZIRKn2LjPOlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmia6YxVNdPDP0mmguNRwosajBniQt5DJTE/NMEYgJA=;
 b=Oj+AruaciWYmktkMvOfOzQWbkLaViF7h4Uh0syZqA/IwtYvxxYXAfCEUGk00k5pT1W+/6sGfqMbpmedV9fyZcnpkpwKoZ1XwvoBZIMz1F2M1UUdc2N0vUJraZSAAqq5AeY5rWylH3Hoy8voxFio2n0BP1gWgznuPzJjIY5WvPhcmEeQZ2mbqLr4SO/bbkZmd/0iJig6YDw3MGr8cSKdv71M0JsaEaX43bc1z4WnTGeioTHck+nGhj/sZqUJCoGbSWeczIgZQC4Blna+RpH/LvqnwxShFsdPYHKXE/T89IRrKJB5aoPNq0gtmSkeL3PnK0FtoywODCZ3Mo2VeHcOWWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmia6YxVNdPDP0mmguNRwosajBniQt5DJTE/NMEYgJA=;
 b=Q8/6Wm0zOP9RYhYKBYQp9AS0buGXLCS73BJ4kHjP7D0TvKDiWbsBRWtOqGazLxUCnI9LERGRo7VWYHW/tuV8ByGIIS9ly118CMBwQHXdu3cV9SYmGKZ/LEq7w5ycZIfR0VsVnnxGgZflp+6LOHu+FAN0UQST0PXCZVsxWyWJIh8=
Received: from SJ0PR13CA0171.namprd13.prod.outlook.com (2603:10b6:a03:2c7::26)
 by PH7PR12MB9223.namprd12.prod.outlook.com (2603:10b6:510:2f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 15:41:48 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::a5) by SJ0PR13CA0171.outlook.office365.com
 (2603:10b6:a03:2c7::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Mon, 29
 Jun 2026 15:41:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 15:41:48 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 10:41:33 -0500
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 08:36:06 -0700
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 03/22] iommu/amd: Detect and initialize AMD vIOMMU feature
Date: Mon, 29 Jun 2026 15:35:16 +0000
Message-ID: <20260629153535.15775-4-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
References: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|PH7PR12MB9223:EE_
X-MS-Office365-Filtering-Correlation-Id: 277e6693-3007-4a0d-2a7a-08ded5f4ee86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700016|1800799024|23010399003|6133799003|22082099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	bwduiya0q6BNNkZILIK8BrfW8ONXhdyOhkuoJUEolzITlCyPNqyvq3ahmhfLd8jP2VlqNrlUW+HTtNKLsNyyqWEAYV5sWsOC9RFYKjQim53XJ28g5Pgl7umGkSvfJkVW3idTrtJJnd3VuJ7p4MW/veXKuzidzmu5SO1/Tx0qVN3re3d26qG0qEKp7D73rZeMsAdo+UfV+eofKj27diJe0h1J5+Nr7N9URbsRAw+7/9g1/qVuJJOu1NMQC8muz8OXShfSUOO9PVwHdNz4JXPBYxkGG4l/3uK9bJapg9CGa2bJeQxbJdrf1Yexexfwp7uXkuSXJoADfPPW3XR7bJOJF6U5HUb6q5+lQfP0L7MaphlH+tR9yU6LOZmu6K9v2BBa9AWpdAgJsxO6b4F43D/pJZ2Mc6zzhz98pEpSZyElFI66rTAe6K2AW3qyKn53G3FNazXz422cbSrve5pTlVMG1UrTK4LIcTJLFAS6FqvqhM0z96X29il1v01WLxasqJsAL1d++eaW9+qY1EMHX8a4najDtl/wPg0f8DBP8v0CckoNj5HV1l2iBqB9bosJ88zAsbV271omo6cFMBiH7NojOKyewLbmRWKOwyN3q8TEXCrxCcUJ0dE9ZyhTfccszMvs0yC+ENRQI+iLad10ZYQhXYPDEuHe8aDBB/DSn4I6ICaksz6zBYeC1qQgodxGuBP1/cz0Jv4uFOUgrB6Vn6k+Bw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(1800799024)(23010399003)(6133799003)(22082099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gK+lWHO0rnk719Ohlwf9HoU3az1BTuHY6SDUrVZSZYedBdRasPMZhRAxIVh4NBcYrhhaGalcc8omGXoZ0KhlSyKJoV28MwCGpFv7YRzSgBoaCA9+0Pqx5HTqNmbJyEe2WLo2vI0YEUL/N5Oh43NLoIAYwcTwWDVZ6LoY9xLVKE5Hy6mdbzy9z+N2wCDVrBSkJdgZetyn8x5dkC+fnEbqU4/up42MW7Y9si3EhJOllrWJSl4qCCsRVmH1XmQrLXpuRWIOeWL5AABLxNUPVyGiK5Q7aZfaR6SKiJD+bI3ytx6btO/JF+5sVu6NamhXidJ1lFsQI6wmaV567ENcVj5dz/zlMo9iIW2Du9ffut9koUgDd5KRU0iaB7X50k7yCZiL79yLjgxqjBudRUHI9kYIxyRdOOxhBvrYaiV1b31UCKsdF95ds+AzbhS9GrQGzhmP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:41:48.2412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 277e6693-3007-4a0d-2a7a-08ded5f4ee86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9223

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

