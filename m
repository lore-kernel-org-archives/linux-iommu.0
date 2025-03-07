Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D384120C47E
	for <iommu@lists.linux.dev>; Fri,  7 Mar 2025 09:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741341600; cv=fail; b=gn+CybeCABBuj0OlbQyKEc2+GYaLFGS5moCUpX2TXyVUs0PMbNtse0zpuhAaaiYmCo2Q9bWOmIzU3PfHozoP95JfJm+lYoYrtXmiwwRUBwqLJEjFbk5LYsezSl1BMES6o0pI5BJJAdnupJfLAkfJgvELukYYdazK0z5kQZtVf4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741341600; c=relaxed/simple;
	bh=sBQsMEpGygzPmV6AAS+e9pyRPdE5Tt4ds5lszKiyouI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K3ndoTBsN3X26wK+TJtDl/0P4Ud2b3Rke0chRE+2LplsXA8ARriOuzrx4Me7fpm+J2tFo5UT9gCS1h922uYY7mhKnD8MaUlZWtfd0fA5TYJnOAd9YDwaK8WUXUQMZFWC5GZ39zB1SpXTMkaA2bgELGKgo8z9a+Y3sp1TK2BKcB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gejd1g3i; arc=fail smtp.client-ip=40.107.220.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gejd1g3i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3xMWO8w7X5jjJajIp+ggLsDki5EkLS+oxemvwyoZ4V0lJK/3PN26vkV3PGYSaVY32BhPi6KHuRyz1DIyTKVAFQnqfRtACIFE5Ns330wNnMYPnPipLZzKG1CF+kVxRJWI59quvwrDjsRSJaJOgGsIinMC9firC8wT4RJBl+SeM7NQV0oafv9PWuph42F6qWH+FiWDtsYxBXnuGa7s0mQmRueoiSR8382K3SlldM/d9Q1kS6/Tolk9MU1TEjMwNmio37pzhQsFaMnUBTpsDQNFEVWqXEyr2+mUubuNh+H0PFc1Qm9FQcNIUaPs4VmRCkcy8ahDZfl464117Nwjh1x7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWqh3mA5v3+ydVUaibbSjkBhvERnt6cFL98LvLzgda4=;
 b=hqUUw6pCsc3W7tA3JS5XgCL7Ng9JK79M9WfNZwfr+wujsK9G0VApQpCtcQrSV/90CUI5bty8bB05ERsXSFhhvrBayj7lpcRTKY6BBI8Ty8Em105zs3L7aVB6/jGcJGAIZR4udsQy846sE8Usro4H5gIw7PWr3KbdC4IxScTbjaxF7OcE1ycL5P8Ult02PjKBGia4cPAAkX6mluiYLcMgVyPOHtU7FnCQLTKPnsrVVkMDkWQHBOOThb5fr+0uAe8fn8rQKesNiWKPISUoFey9+woxB0IejV6ZdD62ZjRp/I6pJDWX2N7mO24rH4FWZPkaG292c8j2vyPp0kX1Ny5nYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWqh3mA5v3+ydVUaibbSjkBhvERnt6cFL98LvLzgda4=;
 b=Gejd1g3i01ttY+io1B+auFPd1Q8F7HCg8y2RBJx8uqKhr33CQwIyUdAwpiOVA6lZi4wUQZGkwK1lI+wHOJlz0LJIsnZEgxH+yWH7Xn8NRXX08ZmYZrAgqcY7g932r8S6wMi/F3Fbcghay1pWXhXb2wwayJe85WMPhYg0xdNOjQg=
Received: from SJ0PR05CA0071.namprd05.prod.outlook.com (2603:10b6:a03:332::16)
 by SN7PR12MB6982.namprd12.prod.outlook.com (2603:10b6:806:262::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Fri, 7 Mar
 2025 09:59:55 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::de) by SJ0PR05CA0071.outlook.office365.com
 (2603:10b6:a03:332::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.11 via Frontend Transport; Fri,
 7 Mar 2025 09:59:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 09:59:55 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Mar
 2025 03:59:51 -0600
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <vasant.hegde@amd.com>, <sarunkod@amd.com>
Subject: [PATCH 4/4] iommu/amd: Enable support for up to 2K interrupts per function
Date: Fri, 7 Mar 2025 15:28:22 +0530
Message-ID: <20250307095822.2274-5-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250307095822.2274-1-sarunkod@amd.com>
References: <20250307095822.2274-1-sarunkod@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|SN7PR12MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f684409-c139-437c-6a9a-08dd5d5ed02f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ttyRdcnueJ2KN8ckP5rfTv4JUKEQ1gv9niUNf99YsoE9uOMtGe8rmOn3Y38m?=
 =?us-ascii?Q?gXEAwyxaDbJ41Vw8jUzEZLoy8ehKMH4TbeFFtpxxUttQk7FO+L2QqNETuynH?=
 =?us-ascii?Q?kpAm2kVcxd7Yb37DFALvybuagIxtJYNSC/WMjiKWG7B32Ic5rHLKvfNSG1Vz?=
 =?us-ascii?Q?1AAzfgjs5uqUP0WrGgg2NjGPbGdyFGyQRYIo0Uio4Ci4hNJltfbCddnf8xkC?=
 =?us-ascii?Q?uvG0C9CEs3y+qNyku1AIZuZk5mmgudBqTZdL1xnNZNRzrvkIcCEECeOBIhIT?=
 =?us-ascii?Q?1T6xJeDvVL9VIGxu8cAePZ2BGg1+nULD6iCsrMlzSiYKKqVjZvZ2qBL3wd2s?=
 =?us-ascii?Q?x2X055XBdXto3qevhk7Eeyk2Aa/GaTXa3XTe1WUWB+zUj/zddId+1TUPLSbe?=
 =?us-ascii?Q?hMS97YpWYXXp3o6IXqXqU6h/kTQiePWUzrdL/g8KoF10m/vvFQkVDOf92txm?=
 =?us-ascii?Q?NN3myM1us/X52Y/2CIe14K29wVRE94dPEjW6slgIX7oPjz+gf9V0Zu7FGTC3?=
 =?us-ascii?Q?KP6j+xN7VC1DvIoFRczA4wH7JV4sFIwAwBIBFhd/2n6UH1OPrV1+9JLN11PD?=
 =?us-ascii?Q?SAMbpwx0q2vyidXuAQC/sODOUod0OQ/X8MmA2ZiGUW8PzH0018SADB7jiQwq?=
 =?us-ascii?Q?fyWGzSkvX2LhkgBoWfZujsDAVRosfnT+zBPTXfOfvVu/55AQ1X8gtM+S1S+h?=
 =?us-ascii?Q?VIiAKQrqYnH0AE1o9QIusk2gKDwkoTxum8kR/1ncTWdnEy48bmEuRlNLKrsm?=
 =?us-ascii?Q?34t8BL9PwIAP4dY83Qi73+7kaWVMWJtcgpYDIRErJKsZZUHWFElcQfxCek/l?=
 =?us-ascii?Q?FyY7HxGkXZNq5WWL6gXtCbALso8MQQB6zCLUrgereSo35mQHikXCZuoEk4PE?=
 =?us-ascii?Q?XY/13PZVUzdRqtcAG608JorBHxJbl2smiqDUXwCTOeDumkVKQGQijlKgdzXT?=
 =?us-ascii?Q?dkaMI0qQGtG43HpY+GCHFHTITLZZ+WlQPJI85HvMR+WIEDfJ0Fw+js3UKLnf?=
 =?us-ascii?Q?RHMvtYNF9mCrJYU2+nJxklbY6kIbbMkRCQG237VVMfO5TJrZjAnWR9VyKTgm?=
 =?us-ascii?Q?hYjDC9tvdibaV6zPz2CCTLQ88D/8ojkV7CrC4mcMJOF63+QbF/78HAgtJDgY?=
 =?us-ascii?Q?BdsRThlH5ZK8Dw/XTw6NFYbKDrLIb0rhmtk8HsXq1L2Zz93rVo6hBt+EO72j?=
 =?us-ascii?Q?8lKjrT/Upm022Rius9gylKJz3TTDuoNKs4N2VjvtdxdODxKzaMQRHOIrfuaT?=
 =?us-ascii?Q?e7fHQZtLs1Uhf42KH9nIi+AvVwUvEotbWfbYFQKaeXYn0mOq99R76c68wJha?=
 =?us-ascii?Q?0NgT5m/1uHN+jux+1FzGHxM5aQkIZwQMLzFHNnvf9aZW/Oclwv0LN+wJPyf6?=
 =?us-ascii?Q?WA+qmnGk7nQZ13ER/66jv3yqLVVHQpUTIgbm7XSsAsAPto7dmkkgGpm0FhKy?=
 =?us-ascii?Q?dDetf1QC+XpF8f+sx3jO+KTiNuQnIqpHaGP5BOeTUyf4az9UgHhblu8/R21I?=
 =?us-ascii?Q?jLrQ0eOy6TCyjx4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 09:59:55.5837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f684409-c139-437c-6a9a-08dd5d5ed02f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6982

From: Kishon Vijay Abraham I <kvijayab@amd.com>

AMD IOMMU optionally supports up to 2K interrupts per function on newer
platforms. Support for this feature is indicated through Extended
Feature 2 Register (MMIO Offset 01A0h[NumIntRemapSup]). Allocate 2K IRTEs
per device when this support is available.

Co-developed-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Kishon Vijay Abraham I <kvijayab@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 15 ++++++---
 drivers/iommu/amd/init.c            | 16 +++++++++-
 drivers/iommu/amd/iommu.c           | 48 +++++++++++++++++++++++------
 3 files changed, 65 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 2efb47dba270..78821d45669d 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -112,6 +112,10 @@
 #define FEATURE_SNPAVICSUP_GAM(x) \
 	(FIELD_GET(FEATURE_SNPAVICSUP, x) == 0x1)
 
+#define FEATURE_NUM_INT_REMAP_SUP	GENMASK_ULL(9, 8)
+#define FEATURE_NUM_INT_REMAP_SUP_2K(x) \
+	(FIELD_GET(FEATURE_NUM_INT_REMAP_SUP, x) == 0x1)
+
 /* Note:
  * The current driver only support 16-bit PASID.
  * Currently, hardware only implement upto 16-bit PASID
@@ -175,6 +179,9 @@
 #define CONTROL_GAM_EN		25
 #define CONTROL_GALOG_EN	28
 #define CONTROL_GAINT_EN	29
+#define CONTROL_NUM_INT_REMAP_MODE	43
+#define CONTROL_NUM_INT_REMAP_MODE_MASK	0x03
+#define CONTROL_NUM_INT_REMAP_MODE_2K	0x01
 #define CONTROL_EPH_EN		45
 #define CONTROL_XT_EN		50
 #define CONTROL_INTCAPXT_EN	51
@@ -309,14 +316,13 @@
 #define DTE_IRQ_REMAP_INTCTL    (2ULL << 60)
 #define DTE_IRQ_REMAP_ENABLE    1ULL
 
-/*
- * AMD IOMMU hardware only support 512 IRTEs despite
- * the architectural limitation of 2048 entries.
- */
 #define DTE_INTTABLEN_MASK      (0xfULL << 1)
 #define DTE_INTTABLEN_VALUE_512 9ULL
 #define DTE_INTTABLEN_512       (DTE_INTTABLEN_VALUE_512 << 1)
 #define MAX_IRQS_PER_TABLE_512  BIT(DTE_INTTABLEN_VALUE_512)
+#define DTE_INTTABLEN_VALUE_2K	11ULL
+#define DTE_INTTABLEN_2K	(DTE_INTTABLEN_VALUE_2K << 1)
+#define MAX_IRQS_PER_TABLE_2K	BIT(DTE_INTTABLEN_VALUE_2K)
 
 #define PAGE_MODE_NONE    0x00
 #define PAGE_MODE_1_LEVEL 0x01
@@ -847,6 +853,7 @@ struct iommu_dev_data {
 	struct device *dev;
 	u16 devid;			  /* PCI Device ID */
 
+	unsigned int max_irqs;		  /* Maximum IRQs supported by device */
 	u32 max_pasids;			  /* Max supported PASIDs */
 	u32 flags;			  /* Holds AMD_IOMMU_DEVICE_FLAG_<*> */
 	int ats_qdep;
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 9a311c627090..c99b2e34f3b4 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1061,7 +1061,8 @@ static bool __copy_device_table(struct amd_iommu *iommu)
 		int_tab_len = old_devtb[devid].data[2] & DTE_INTTABLEN_MASK;
 		if (irq_v && (int_ctl || int_tab_len)) {
 			if ((int_ctl != DTE_IRQ_REMAP_INTCTL) ||
-			    (int_tab_len != DTE_INTTABLEN_512)) {
+			    (int_tab_len != DTE_INTTABLEN_512 &&
+			     int_tab_len != DTE_INTTABLEN_2K)) {
 				pr_err("Wrong old irq remapping flag: %#x\n", devid);
 				memunmap(old_devtb);
 				return false;
@@ -2737,6 +2738,17 @@ static void iommu_enable_irtcachedis(struct amd_iommu *iommu)
 		iommu->irtcachedis_enabled ? "disabled" : "enabled");
 }
 
+static void iommu_enable_2k_int(struct amd_iommu *iommu)
+{
+	if (!FEATURE_NUM_INT_REMAP_SUP_2K(amd_iommu_efr2))
+		return;
+
+	iommu_feature_set(iommu,
+			  CONTROL_NUM_INT_REMAP_MODE_2K,
+			  CONTROL_NUM_INT_REMAP_MODE_MASK,
+			  CONTROL_NUM_INT_REMAP_MODE);
+}
+
 static void early_enable_iommu(struct amd_iommu *iommu)
 {
 	iommu_disable(iommu);
@@ -2749,6 +2761,7 @@ static void early_enable_iommu(struct amd_iommu *iommu)
 	iommu_enable_ga(iommu);
 	iommu_enable_xt(iommu);
 	iommu_enable_irtcachedis(iommu);
+	iommu_enable_2k_int(iommu);
 	iommu_enable(iommu);
 	amd_iommu_flush_all_caches(iommu);
 }
@@ -2805,6 +2818,7 @@ static void early_enable_iommus(void)
 			iommu_enable_ga(iommu);
 			iommu_enable_xt(iommu);
 			iommu_enable_irtcachedis(iommu);
+			iommu_enable_2k_int(iommu);
 			iommu_set_device_table(iommu);
 			amd_iommu_flush_all_caches(iommu);
 		}
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 1063c4988dca..fc420fdf8539 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2392,8 +2392,14 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 	}
 
 out_err:
+
 	iommu_completion_wait(iommu);
 
+	if (FEATURE_NUM_INT_REMAP_SUP_2K(amd_iommu_efr2))
+		dev_data->max_irqs = MAX_IRQS_PER_TABLE_2K;
+	else
+		dev_data->max_irqs = MAX_IRQS_PER_TABLE_512;
+
 	if (dev_is_pci(dev))
 		pci_prepare_ats(to_pci_dev(dev), PAGE_SHIFT);
 
@@ -3079,6 +3085,13 @@ static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
 	raw_spin_unlock_irqrestore(&iommu->lock, flags);
 }
 
+static inline u8 iommu_get_int_tablen(struct iommu_dev_data *dev_data)
+{
+	if (dev_data && dev_data->max_irqs == MAX_IRQS_PER_TABLE_2K)
+		return DTE_INTTABLEN_2K;
+	return DTE_INTTABLEN_512;
+}
+
 static void set_dte_irq_entry(struct amd_iommu *iommu, u16 devid,
 			      struct irq_remap_table *table)
 {
@@ -3093,7 +3106,7 @@ static void set_dte_irq_entry(struct amd_iommu *iommu, u16 devid,
 	new &= ~DTE_IRQ_PHYS_ADDR_MASK;
 	new |= iommu_virt_to_phys(table->table);
 	new |= DTE_IRQ_REMAP_INTCTL;
-	new |= DTE_INTTABLEN_512;
+	new |= iommu_get_int_tablen(dev_data);
 	new |= DTE_IRQ_REMAP_ENABLE;
 	WRITE_ONCE(dte->data[2], new);
 
@@ -3174,13 +3187,14 @@ static inline size_t get_irq_table_size(unsigned int max_irqs)
 }
 
 static struct irq_remap_table *alloc_irq_table(struct amd_iommu *iommu,
-					       u16 devid, struct pci_dev *pdev)
+					       u16 devid, struct pci_dev *pdev,
+					       unsigned int max_irqs)
 {
 	struct irq_remap_table *table = NULL;
 	struct irq_remap_table *new_table = NULL;
 	struct amd_iommu_pci_seg *pci_seg;
 	unsigned long flags;
-	int order = get_order(get_irq_table_size(MAX_IRQS_PER_TABLE));
+	int order = get_order(get_irq_table_size(max_irqs));
 	int nid = iommu && iommu->dev ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
 	u16 alias;
 
@@ -3242,13 +3256,14 @@ static struct irq_remap_table *alloc_irq_table(struct amd_iommu *iommu,
 }
 
 static int alloc_irq_index(struct amd_iommu *iommu, u16 devid, int count,
-			   bool align, struct pci_dev *pdev)
+			   bool align, struct pci_dev *pdev,
+			   unsigned long max_irqs)
 {
 	struct irq_remap_table *table;
 	int index, c, alignment = 1;
 	unsigned long flags;
 
-	table = alloc_irq_table(iommu, devid, pdev);
+	table = alloc_irq_table(iommu, devid, pdev, max_irqs);
 	if (!table)
 		return -ENODEV;
 
@@ -3259,7 +3274,7 @@ static int alloc_irq_index(struct amd_iommu *iommu, u16 devid, int count,
 
 	/* Scan table for free entries */
 	for (index = ALIGN(table->min_index, alignment), c = 0;
-	     index < MAX_IRQS_PER_TABLE;) {
+	     index < max_irqs;) {
 		if (!iommu->irte_ops->is_allocated(table, index)) {
 			c += 1;
 		} else {
@@ -3529,6 +3544,14 @@ static void fill_msi_msg(struct msi_msg *msg, u32 index)
 	msg->data = index;
 	msg->address_lo = 0;
 	msg->arch_addr_lo.base_address = X86_MSI_BASE_ADDRESS_LOW;
+	/*
+	 * The struct msi_msg.dest_mode_logical is used to set the DM bit
+	 * in MSI Message Address Register. For device w/ 2K int-remap support,
+	 * this is bit must be set to 1 regardless of the actual destination
+	 * mode, which is signified by the IRTE[DM].
+	 */
+	if (FEATURE_NUM_INT_REMAP_SUP_2K(amd_iommu_efr2))
+		msg->arch_addr_lo.dest_mode_logical = true;
 	msg->address_hi = X86_MSI_BASE_ADDRESS_HIGH;
 }
 
@@ -3591,6 +3614,8 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 	struct amd_ir_data *data = NULL;
 	struct amd_iommu *iommu;
 	struct irq_cfg *cfg;
+	struct iommu_dev_data *dev_data;
+	unsigned long max_irqs;
 	int i, ret, devid, seg, sbdf;
 	int index;
 
@@ -3609,6 +3634,9 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 	if (!iommu)
 		return -EINVAL;
 
+	dev_data = search_dev_data(iommu, devid);
+	max_irqs = dev_data ? dev_data->max_irqs : MAX_IRQS_PER_TABLE_512;
+
 	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
 	if (ret < 0)
 		return ret;
@@ -3616,7 +3644,7 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 	if (info->type == X86_IRQ_ALLOC_TYPE_IOAPIC) {
 		struct irq_remap_table *table;
 
-		table = alloc_irq_table(iommu, devid, NULL);
+		table = alloc_irq_table(iommu, devid, NULL, max_irqs);
 		if (table) {
 			if (!table->min_index) {
 				/*
@@ -3637,9 +3665,11 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 		bool align = (info->type == X86_IRQ_ALLOC_TYPE_PCI_MSI);
 
 		index = alloc_irq_index(iommu, devid, nr_irqs, align,
-					msi_desc_to_pci_dev(info->desc));
+					msi_desc_to_pci_dev(info->desc),
+					max_irqs);
 	} else {
-		index = alloc_irq_index(iommu, devid, nr_irqs, false, NULL);
+		index = alloc_irq_index(iommu, devid, nr_irqs, false, NULL,
+					max_irqs);
 	}
 
 	if (index < 0) {
-- 
2.34.1

