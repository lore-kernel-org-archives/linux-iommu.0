Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013047.outbound.protection.outlook.com [40.93.196.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5E64779BC
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 09:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760276; cv=fail; b=pnwcTFVYj85BtPQMvSwU2diyttB8W1ptibFUI7xipRsS3jXQkoKG5Pj7lTopVL/7bxbTdopo5s4zAgjprZYXBxI1ud8kxnf/ljvEqGhNOZy8aoJpdte3cnXjCsr41fG5AbXPDbJnTzG4Smug3suPY6jIKnGnDOR+rKE/S4EX8ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760276; c=relaxed/simple;
	bh=EqX4GfhMnOo/mMFjyzcRI4NdFQhdoxYU0Gj5TtJefu8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sFu0J0oPuXzNzcnVKKdCKTpYV0c8xEmCVDVOiTbs5i1JJC1KcysRqkw2ZrAP2xHnMuoc/1VqWbFafXohvi1X+I2XfpCELL2iSFCtGRnnXxfQ6aMeZCSiTIPjNjlhKAEfVffDav6aPV7NG4Pb7s8QnxKMcSoVuYTzaYR614QU+Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o+S+Joi0; arc=fail smtp.client-ip=40.93.196.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o+S+Joi0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOadt+nP5EXl09TFa9xJqeDa/wfd3qEoTVCl4lbkzHcv8Pghludot5ItN4frmJPZwzc+BkcMJcxerP8miEFL8PaM+bOV/HWyEHE362sWzhu/ey3S15xvGh6gv44eBNRJ6DBU1dThk62AumtIGMSpgjrN3U+kH0l8FC1EAR6FsJEi3D80Ta6/JO1Gv7rUxWI3LeT1mYASHrQ9pxgxTBypQWE5+IaQgjK1iPHC1FrzevAe5B8RVg21M+B76pN7iS/gwpGvV+ZDtP/qHUQWGRn5AQd36KSJnWpTatIoJ0I1d7G+vlvoirCWfFPRlyEfHOC8e4itYNMJV/bQYWNgJN+2iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofg8I3QnaSD+dcVpiAmmhj8OO59UyfzPjnZxSOXtQjQ=;
 b=ZS6UqqlolqTjYNf1wtc3AtK/vUz+ZLLDgAyb1zgf4K506LkIxLvQvEutjd5P49y+rUicXuHd9+93334vUIsznf2kKerchgwFIplq8pj4rKT7seKIN7+0WhYSrimEe7dPdn4u6pKI65AKX4skNAAkhGOXWt4gfiG+9MW1Gwt/R7jONj1wlpcSV9tku35H/sZQVaX42zFeiK+M2uG2Xt70IM24gGUAWVhnxUBjKs7UMW3K+6gH/yb3R4KzY11hcqRPzWmanTiYTDiqT/jiZTdS2yfL9CMLXlPmkyPYCC0Jh2KHkq2ufpF8dRaTJ9ullxUJ3CtwJBggUT1c53pRo8pKsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofg8I3QnaSD+dcVpiAmmhj8OO59UyfzPjnZxSOXtQjQ=;
 b=o+S+Joi0lnXIfULkXrL6H6tK/VIWcNdXoey9/LAvxhacFfqNamcrtFSDPXvt8bFOtJXRFyt6GEF+cy9mvd+MWqgxtQ7EeEmL6ucE5J0cw7bUTYJxRceV9zqw9b99e4g6G54Z50xOPuhN2TYZSYfua/8IPVKU0N49CMWV6zrYsxc=
Received: from CY8PR10CA0003.namprd10.prod.outlook.com (2603:10b6:930:4f::24)
 by DS7PR12MB6192.namprd12.prod.outlook.com (2603:10b6:8:97::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.22; Wed, 30 Sep 2026 09:24:25 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:930:4f:cafe::ad) by CY8PR10CA0003.outlook.office365.com
 (2603:10b6:930:4f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 09:24:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 09:24:23 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 04:24:17 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <Ming.Shu@amd.com>,
	<SooJin.Tan@amd.com>, <chrisl@kernel.org>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>,
	<guanghuifeng@linux.alibaba.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v6 03/24] iommu/amd: Detect and initialize AMD vIOMMU feature
Date: Wed, 30 Sep 2026 09:23:23 +0000
Message-ID: <20260930092344.5616-4-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
References: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|DS7PR12MB6192:EE_
X-MS-Office365-Filtering-Correlation-Id: f7808a63-49ed-456d-0944-08df1ed49d9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|7416014|13003099007|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	d68o3r9ChMR1A8Z2o+cU0QOAH4ZJlbMjN+isqcSEF5yehVta7fW9XnW8KA0PqnBzpmqXdZ6HjIIpgGLtZLwAdBtxeMrpqxbJhBX5Isli6q65ZpxQtogK/1Ghfkil4HVSmMPXmpfNyeTl/V8aJQp5Jf6IusRlhFfd/aasksO14YuplqcpyjCeg3nFqJmAoJhX8soN6sAFutzZcAjZFtaak5KWbSfbycbFS6gOEjkVL1AroX3K7DWzNEECfb1StG7tBCncoONnQuOL1p4ZZr0Fd9PO8ROK2OIFuFe6st80m4nKyVtwTcg1J9bByWR1TXNkKQ4QFgfrZW0W8rtDZjEAJ8OWlCTsGEdcIa2LmLx9eOAwPEntDp/nnqAqLcOocug2cDO/IRQ80cPtfIzcqXh+tvkVw1A0ERE1dR3TnqBlHv23UmL2xDsL+k66bQB6WJ0SaFXyzO5EyiOgBGE3ZFyyf3b8HH1ow4g5H5iidSytSLimbjUhoZ7sM7EcltMtW22wQdDSu7QkTqy8BqHDUyacv4gbbPz189XN4SDJwv/OTOg6j1fKn0tVBn/OzZL+8LZVRPafpoKxvQ+KXBipMCCMS23WFbxWaUKkGd/02Gjmpdd5Wro6wdugS5FdBe2xf7vPTL9YvDR1dPdFTG50lxZ6cdo9IEA7AvtaqgRfHIok4+TAWxifnju2w/JBELu4WMtSWTf9H2a0IYn9FKauzQn7Nw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(7416014)(13003099007)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0F4zMjhK37Q2OL4s+cf89UAPK9rhpaDcngX9nKYWZ7wDy9DTlS7xi/XKYDKglOV5jil47YK+jA0gMWliintJGulrOKdmmH9vbid/+iMkp3NDJEvogGW0qQfCvFSA4s4DRv8pfZEI1yM31ysuNZJgqKRa9t7piuwFQOdRMXQV0xWK6M3xe8GjAHxKtB2GSZ7S3uTJTNrQBrytmXeN0344Y3AubujBbe0B/bc4tHMn7aQg9y8+2/TqTae0vXmb614nKsbZZBHTP1IKCFwwry3VZSbTgsM/n3frssV0UyUn+ijGevMJjp2bUZBms+/Se3BgJbAQPisjY90EldicOZfAU9/FjaDg+Spisu5uFav4nk/SN4S00RZjkPKHeMWZVn38SJT1162wnUfw12skqdGC9YEL/N0+tLN//97gIa6YnLr2sbeXkDj8kllz+7ta49O7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 09:24:23.5267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7808a63-49ed-456d-0944-08df1ed49d9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6192

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

