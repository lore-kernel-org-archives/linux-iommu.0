Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012054.outbound.protection.outlook.com [40.107.209.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FA638E8A9
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 18:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789411727; cv=fail; b=OI4OdfyeAQW+dXwcRzKUDE+MA7leUplkIE/qELG4ncqGOUKSBOgkR4jZdD/Bqh2u7r3bNceWbHrARGVihQ9dbnFAbT/wPpmbek1blJK4Qrw3ec7zDkMbR6OeiLXOqCact9ZrSjRhuiBDIuFjmQuMo+e/Q4kGjYRRh4ib0YDqMxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789411727; c=relaxed/simple;
	bh=EqX4GfhMnOo/mMFjyzcRI4NdFQhdoxYU0Gj5TtJefu8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L/1ZL5BrERgMWnSf2NmQ2jIannWTyHWWXOJ+klwXWZ3NZ9nbeW38YevIjKPrQ3kRlgmfmX1/CILFZD+N9f+y25gSWSr5dNjIyH1HUUipQenJxwlILNsX0mBUxet/D64RrA0zSQ3llMErQvgTm8Z6Xhj8ygQlhzxoS0NFFt+iKKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jHiBmB2R; arc=fail smtp.client-ip=40.107.209.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jHiBmB2R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1ZcW2O14f2JxA4szTJJfu5UdhAJZuIJ0TzBjec0GQ1MFqu7XeWYz8tmqDizDg4IROXVW0Vpc3YWhh861DRo0Yyik3vcWvnxG1b19fLe6RZDMxNwokG4sINR5OAjwDMt/PObdGXN6KRazMlcfAricWdlynbBxKndQPF+vEO2F4kFX7BZ66sPPPVRxr0bbNArGdq2jEIV3LU3mqGD/c92xNTW/tj8lfKBGMv7YoII3lK6B+avitf35VPNt4n2HYapKJL31521kWlRb9aqMfB8iZv3ZaSnG2gxeScYRSSXsJsc4zqHDSahreGuB92BN3pAWDRJWzFOEw0Cfq0h4dtDLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofg8I3QnaSD+dcVpiAmmhj8OO59UyfzPjnZxSOXtQjQ=;
 b=ufyyLZ9QM+b4eWbfC3P2alpxbyYNTd9IZpCr7pQMVQ0qtiDFDqlgaW8fK5soPbSjL+n+a/qFyDEC0jQskLPqJvZtf2bC+9Z5i/gi5fuGEueGkVWpt+uj3SSVx2oiT+XS2tw23I9xebHGrdTAyWbKq+CpALlwFURFrvKkMBT1qv6YDPuw+w0Z5SpqZfGpYLe7JsK+xx5PRoCXQ9jN5qgou1ddrBeytnNwRsbMtNrfmvz2wQrVQWotfsvQfYJel8/SG2HFPLCLrTbIKrben/T8m4PPyXBxbNRpE6ihOV8E+vmGVnI2X0WD3Aq6lz4IMY5j/U2SoHFRCzK7sihquXv11w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofg8I3QnaSD+dcVpiAmmhj8OO59UyfzPjnZxSOXtQjQ=;
 b=jHiBmB2RoFtQC8fZFKH0VbWizMXjXzsGh56YLpCmBkSBmKu8F8QFAihmc+qGuUspIL7Y3JU+8MU0tTzr6yuWbVfdBj6FelufRpWnzwGc5DpcGwqqP/zdYIwkmDR/ph3s7mW2lfH7aEt/aDEwi3uLwCOryGvNLFs0GQiCtgUuO8Q=
Received: from CH0PR03CA0450.namprd03.prod.outlook.com (2603:10b6:610:10e::28)
 by CH2PR12MB4216.namprd12.prod.outlook.com (2603:10b6:610:a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 18:48:34 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::90) by CH0PR03CA0450.outlook.office365.com
 (2603:10b6:610:10e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 18:48:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 18:48:34 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 13:48:28 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <Ming.Shu@amd.com>,
	<SooJin.Tan@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>,
	<guanghuifeng@linux.alibaba.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v5 03/24] iommu/amd: Detect and initialize AMD vIOMMU feature
Date: Mon, 14 Sep 2026 18:47:29 +0000
Message-ID: <20260914184750.222939-4-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914184750.222939-1-suravee.suthikulpanit@amd.com>
References: <20260914184750.222939-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|CH2PR12MB4216:EE_
X-MS-Office365-Filtering-Correlation-Id: 731106aa-82aa-48a9-e78c-08df1290c7b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|23010399003|376014|1800799024|82310400026|56012099006|11063799006|10067099003|18002099003|22082099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	auP4jZPYGvoC+MnUQcUkYBnEuL/P2yZhTosgsP520YcPm3zhiUXeO6tR9Cc3gRKChQhnuoMGSaCDvmV4WjX8rNpr1BsVDlV6g+/hfeyBrnAtH9LaruIddH5FFZx+6Xch7eFK3lZlgDGqAxVdzhHx+xLZFBnmU3L1DN/GWW558LOPGJWbp+8o00UDPzIHSAm9KlD7J019THNj/oQJ/prBadqNfccWRLsBxDiIt5yfQUfoP62I8fpvFtZ0AhdJwt208HPFc2rq2c/PNR2LpJXLZWQulFU/dMWxdhjG/tNF6TYAyXEpA6bAEwCUqY2cODMGoxoAjJpRppo6MYmd5JsA8knVjHk3lQc57hNJ/jZb/HN+mzGm4b3nV9dJGa5wDBPKjOugVt5pQh5pZgnuZZf0Ip2yst7nConYl+fhtncBX0PK0mKRBTIWkuxYgS7tqkXFwTUnbUIwSnFFjkEuMKX/F1oLTfAzRbsfnPmw+VZFKE+C20FaXDFMYalVQwMPV+003fgmVtiQAzR36bjuRA2HvrJOoDBuLJzeSArfcnJ075m6QexGlB6SJfYvlHjb+L2jwJWW6dHye5QriYd+xLOvbocWHdLflJFG2+tyj2VLl9L+eGeUhdRT5lVZYX7l2P5jWfHAJJEyJTwK6eZL/owDVjFHlmlINWnOni8dXVsGngHw/4Tlfy7y2XsEdxKFUi+lO7JUP55Q9JH509u2JDMhjA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(23010399003)(376014)(1800799024)(82310400026)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HxSgniuTFjZ5VGuV2Zd3QKvmCRCY1HKQnmrmC17H8hZcycR90gSiW28y3J+La/5hAbWPa1Pnx4mOHlO052W1fjO1EX0/eQ5oxWniSlF0oAkRSipzsDo7tdccRWNUhMTklfGN5qeccnckjCVSrdGcdDx222aYE269AOwudul8RRMCTDs7hRGY+Lz4Su4ss04w3osGfW5i13sqX3lRflo6E8d/xYFjEEtSOwukMSGAOmbX3fmjl+7GCYg4Oc2Tvg4QgooijihKJVR1KfoMZo2CuFS3cET7KOsVJlTtLs9UIwXOqsZ5QtZv1JTE4OrpCqSwObSocmztmhPukYn78iwH/armZn59N24ESe0Emkxc8m7VJ2Q48qq752aW6u3BuK8LdSGLhWyOVYciZ6hW78T6wP5oUFMphskRnBH4rL+TL6lpu9jqaC+IWc7cGablT7Mm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 18:48:34.4517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 731106aa-82aa-48a9-e78c-08df1290c7b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4216

The feature is advertised w/ EFR[VIOMMUSup]. Please see the AMD IOMMU
specification[1] for more detail.

Gate amd_viommu_init() on this IOMMU's EFR[VIOMMUSup]
(iommu->features) at the PCI init call site. Do not use
check_feature()/amd_iommu_efr; that global mask is the AND of
every IOMMU. Do not fail other IOMMUs when one instance lacks
the bit or init fails.

Set AMD_IOMMU_FLAG_VIOMMU_EN when amd_viommu_init() succeeds.
Log PCI names of IOMMUs that have that flag set.

Forward-declare struct amd_iommu in amd_viommu.h so the header
is self-contained.

When CONFIG_AMD_IOMMU_IOMMUFD is off, the amd_viommu_init() stub
returns 0 so a missing build is not logged as an init failure on
EFR[VIOMMUSup] hardware.

[1] https://docs.amd.com/v/u/en-US/48882_3.11_IOMMU_PUB

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/Makefile          |  2 +-
 drivers/iommu/amd/amd_iommu.h       |  5 +++++
 drivers/iommu/amd/amd_iommu_types.h |  2 ++
 drivers/iommu/amd/amd_viommu.h      | 29 ++++++++++++++++++++++++
 drivers/iommu/amd/init.c            | 34 +++++++++++++++++++++++++++++
 drivers/iommu/amd/viommu.c          | 25 +++++++++++++++++++++
 6 files changed, 96 insertions(+), 1 deletion(-)
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
index 71113e860859..b2ae17e3df34 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -112,6 +112,11 @@ static inline bool check_feature(u64 mask)
 	return (amd_iommu_efr & mask);
 }
 
+static inline bool amd_iommu_viommu_enabled(struct amd_iommu *iommu)
+{
+	return iommu && (iommu->flags & AMD_IOMMU_FLAG_VIOMMU_EN);
+}
+
 static inline bool check_feature2(u64 mask)
 {
 	return (amd_iommu_efr2 & mask);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 704b4c8acdc5..688cd9240790 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -91,6 +91,7 @@
 #define FEATURE_HASUP		BIT_ULL(49)
 #define FEATURE_EPHSUP		BIT_ULL(50)
 #define FEATURE_HDSUP		BIT_ULL(52)
+#define FEATURE_VIOMMU		BIT_ULL(55)
 #define FEATURE_SNP		BIT_ULL(63)
 
 
@@ -465,6 +466,7 @@ struct irq_domain;
 struct amd_irte_ops;
 
 #define AMD_IOMMU_FLAG_TRANS_PRE_ENABLED      (1 << 0)
+#define AMD_IOMMU_FLAG_VIOMMU_EN              (1 << 1)
 
 struct gcr3_tbl_info {
 	u64	*gcr3_tbl;	/* Guest CR3 table */
diff --git a/drivers/iommu/amd/amd_viommu.h b/drivers/iommu/amd/amd_viommu.h
new file mode 100644
index 000000000000..864e7b283cff
--- /dev/null
+++ b/drivers/iommu/amd/amd_viommu.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2026 Advanced Micro Devices, Inc.
+ */
+
+#ifndef AMD_VIOMMU_H
+#define AMD_VIOMMU_H
+
+struct amd_iommu;
+
+#if IS_ENABLED(CONFIG_AMD_IOMMU_IOMMUFD)
+
+int amd_viommu_init(struct amd_iommu *iommu);
+
+#else
+
+/*
+ * CONFIG_AMD_IOMMU_IOMMUFD is off: host vIOMMU is not compiled in.
+ * Succeed as a no-op so iommu_init_pci() does not pr_err on
+ * EFR[VIOMMUSup] hardware.
+ */
+static inline int amd_viommu_init(struct amd_iommu *iommu)
+{
+	return 0;
+}
+
+#endif /* CONFIG_AMD_IOMMU_IOMMUFD */
+
+#endif /* AMD_VIOMMU_H */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 8a410d4aa370..c80872ce0b60 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -34,6 +34,7 @@
 #include <linux/crash_dump.h>
 
 #include "amd_iommu.h"
+#include "amd_viommu.h"
 #include "../irq_remapping.h"
 #include "../iommu-pages.h"
 
@@ -2196,6 +2197,19 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 	if (check_feature(FEATURE_PPR) && amd_iommu_alloc_ppr_log(iommu))
 		return -ENOMEM;
 
+	/*
+	 * vIOMMU is advertised in this IOMMU's EFR[VIOMMUSup]
+	 * (iommu->features). Do not use check_feature()/amd_iommu_efr;
+	 * that global mask is the AND of every IOMMU and can hide the
+	 * bit on mixed systems.
+	 */
+	if (iommu->features & FEATURE_VIOMMU) {
+		ret = amd_viommu_init(iommu);
+		if (ret)
+			pr_err("Failed to initialize vIOMMU on %s\n",
+			       pci_name(iommu->dev));
+	}
+
 	if (iommu->cap & (1UL << IOMMU_CAP_NPCACHE)) {
 		pr_info("Using strict mode due to virtualization\n");
 		iommu_set_dma_strict();
@@ -2264,6 +2278,25 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 	return pci_enable_device(iommu->dev);
 }
 
+static void print_viommu_info(void)
+{
+	struct amd_iommu *iommu;
+	const char *sep = "";
+
+	for_each_iommu(iommu) {
+		if (!amd_iommu_viommu_enabled(iommu))
+			continue;
+		if (!sep[0])
+			pr_info("vIOMMU enabled: ");
+		else
+			pr_cont("%s", sep);
+		pr_cont("%s", pci_name(iommu->dev));
+		sep = ", ";
+	}
+	if (sep[0])
+		pr_cont("\n");
+}
+
 static void print_iommu_info(void)
 {
 	int i;
@@ -2301,6 +2334,7 @@ static void print_iommu_info(void)
 		pr_info("V2 page table enabled (Paging mode : %d level)\n",
 			amd_iommu_gpt_level);
 	}
+	print_viommu_info();
 }
 
 static int __init amd_iommu_init_pci(void)
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
new file mode 100644
index 000000000000..53f3302f7cc6
--- /dev/null
+++ b/drivers/iommu/amd/viommu.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 Advanced Micro Devices, Inc.
+ */
+
+#define pr_fmt(fmt)     "AMD-Vi: " fmt
+#define dev_fmt(fmt)    pr_fmt(fmt)
+
+#include <linux/iommu.h>
+#include <linux/iommufd.h>
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
+	iommu->flags |= AMD_IOMMU_FLAG_VIOMMU_EN;
+	return 0;
+}
-- 
2.34.1

