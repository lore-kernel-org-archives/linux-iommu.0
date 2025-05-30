Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4548E221DA7
	for <iommu@lists.linux.dev>; Fri, 30 May 2025 10:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748600790; cv=fail; b=U/GvGkOAlfyt96rP1dYi99a2KDyHe61J8zLLUXmZbIvehy/1+JVsQuoFcYIE5JK+gQN1fpdxsE1IwQdQGv+CSLsXe0U9elkMOUagT5vVMoj8YBSitq4/9jYecOoWOxczbgcQ+HW2J5lH/0kn5Zq9t49lZlFJCVJZhX7apwb4SbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748600790; c=relaxed/simple;
	bh=F6sZUNxtDVTHX2AYS9OFc56qsDDmRkG3oyuggb0B134=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PSvZcxh0rzaFDkNjFJwgovxBuB42NpPEz3qiEkiEsJUMcINLstJzY4jlXUpRUd+ym6d/Cx7tRh6pEf+SGxmimFgRp0X+PDt+GhJd2AorI/XdGXGgt1xGlwb8ZcT012dFFuojDQz98Lds5xAg74O0qnMTtMC7jHh78NKXTXmjd1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wQynXd3f; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wQynXd3f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zh2xp1KhtV65+qxHj7qCVm1rrfzk7PmKBLuv2T8u5AsCEB9ke7EjZUW3GtiAC3in8pU9NG3QAltLCF8Mg+6fHS85EI0+zx5ZZLw3K8L0tAuE1BUA0SbwcRsq5Bw8+/0MQxp6BJCUirurd7cXBELge12Y82e5zeeeZqoiJrykCSS7gYdsI+7eiIFRy6FVsYT1tiRjhpE/nCTGyC8kyWNvRewt3LVb+vFKjt7RRfNYsHA+YncRtKk7AYU5JrkP3h+vmdvpZMIWD7Y5YTu9U0Jo/JdxoVkBb6/1zdwicdIvfipnH5Y/vRetZGlnom5O3wCXXe4VJ1/2Ud1+UcVJVXlYOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=no9CyBBJatefP5DOIq0O6hK7XOHetTsfejPfJ+xUJGo=;
 b=fOx+t0WE0U4og8m1aUbTFtmgRfp7qLl9FJSfU4XpEfs8mztk8FDPyAnopNntnZW7djIkgIMfzu266xKhDF3sfrurGm3cGqS+/4I5khEaYptCu/wCTV3r40rzA4h7jvinMX0vRHa+NuXwqadB2okHW/H8kfeJ8fvt8867iucZXXUjI2EZ13ELGkZ0J4MyNxD04k1j2necc8gU8/FiBALQpjecUYSjaW5C8KzEBlovTeoquONLcT2yH3OQMYhQgDeuFQrxtA/UsQJ0SRJy6CG1RFT0ZULL7AmrUSUyrTauT010yEFXIOR/Ousx8mamCDUanO6lp8KnuJUMi+t9YTkLHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=no9CyBBJatefP5DOIq0O6hK7XOHetTsfejPfJ+xUJGo=;
 b=wQynXd3fn+RxUF+4bNDUC13A1reyCURh+O7ZO7C7KoNRGRIpsS1LoFafALXwvad5P6B3QgPpV1P1ICYdiXhvt6Fqcj6ECnOPrqnclBFzj8vHhaWx9qde2GwoJDy8ym27yTyukVffKneHwHnPsU84UsOJeY4eEJj8RbGkE/IdkCw=
Received: from SN7PR04CA0118.namprd04.prod.outlook.com (2603:10b6:806:122::33)
 by PH7PR12MB8054.namprd12.prod.outlook.com (2603:10b6:510:27f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Fri, 30 May
 2025 10:26:23 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:122:cafe::1b) by SN7PR04CA0118.outlook.office365.com
 (2603:10b6:806:122::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.30 via Frontend Transport; Fri,
 30 May 2025 10:26:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Fri, 30 May 2025 10:26:23 +0000
Received: from BLRANKISONI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 30 May
 2025 05:26:20 -0500
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>, <joao.m.martins@oracle.com>,
	<suravee.suthikulpanit@amd.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/2] iommu/amd: Add efr[HATS] max v1 page table level
Date: Fri, 30 May 2025 10:25:40 +0000
Message-ID: <24a6b06e1c23344fed80ea11e4bc6bf257cc3ff8.1748599144.git.Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1748599144.git.Ankit.Soni@amd.com>
References: <cover.1748599144.git.Ankit.Soni@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|PH7PR12MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: 955b1027-f744-4b34-0baa-08dd9f646d63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zNwPBknn/Ik+7EqB5KJ1AdSQWqyPjvfVR3mX8DkHxdQYnosnIXMk26wJqzY0?=
 =?us-ascii?Q?95ZYFpF7hpL2nwnH7xJq5JUw/x/cg4kGzjfhekZu9c7E9P/zT86VU+nsrwGr?=
 =?us-ascii?Q?5Jep/tpuf80Og2L+u5DoBlkYCxVsck/6RKU7V7QNe0BLZouoBs7pdYYJEGdp?=
 =?us-ascii?Q?fxIdtq/yBWR+AN1w4d5NQ5Xclyp3N8Aj8SaCTgot1LxxMIl9iyfyz6Eb0IAG?=
 =?us-ascii?Q?fL0fUDHML8Vy9IrkgSjI+LVla0C2CORsr83hlb5/WYyDuppJlXHZb7fRuWPT?=
 =?us-ascii?Q?rdP+SrtMtdZSNDAeQ44YL++7ecIF2NnhYT4Y2DR4eNSixVeElDeKcW2sn3ho?=
 =?us-ascii?Q?7aUMpXV7zE8w/KHYUqyjhlFO0gXtio+ziI43ZRaB2eTcNbL0csjlsJvxiAxz?=
 =?us-ascii?Q?o3+KgnL7eNeXHKrwFHxhiHTn4tkMxSdIfulhLryDS8TnyOjNJhV+TNVTJB4n?=
 =?us-ascii?Q?qJieaepgxRYBSrJTOf3wMPISta+9oOe85fBags3zwa/2IO46If5YYfZ9Lu6N?=
 =?us-ascii?Q?1lRjJdE3b6RtDB1xn1XHyA30leoevZahv+SYTm90eZIVnNrqA+91WPIwtEMG?=
 =?us-ascii?Q?gd2vVKFrOXDT2+LkPpvLP1cY811p+3RTibpyl3UenUQTpfUY+nZrKDcnFQUa?=
 =?us-ascii?Q?7TMVG++lqPpnY6QhX1alt6FAripOABVnaa7QoYo2lRVz7OqCfINHy78BW42v?=
 =?us-ascii?Q?StykucTzO89XxoX4g+XX0e8/qmrtoMTKHcsXCNXynQUxi4tlEUSYpj/5T0qh?=
 =?us-ascii?Q?Bq62D7PKap6Y02Ks0GWmRFuIrpOrE8S96RCA6rg+nOY62ACeFpuIjE6IUwom?=
 =?us-ascii?Q?vB2alVUiTBOZR22c+ADjpJ42i1sYUr3hAkZ4aSzxo2yg5egq3jfYdXVOSDB1?=
 =?us-ascii?Q?Yw2ahVbswrRv8q8UtdrYnQ2ggB4VWBSo/s/zxEEUb513EDIOp5Y0jLg4Lnhv?=
 =?us-ascii?Q?vaZf0/rqq2u9ho2f1ISJ4+LIxbYgbotW6WRLW1qIX4byyPPJdZqyp+QgUhjJ?=
 =?us-ascii?Q?cRy7qRkaBhed2KpJLgtRUg0fs6/aLYFW7LYHA7IhzfPiyecvgSfQjWZU2Oc8?=
 =?us-ascii?Q?sIJOVRugR5bTm2BBfCms9HSTDtE2IJt0NAMxv7opY26E6k1l6pZG9S/OnREK?=
 =?us-ascii?Q?IMJRFKdBFF/YKA2l0JLirdFV3lQWcT4X4aMMY9ixG4EeEzvIg+Gke5iYFofb?=
 =?us-ascii?Q?FKkRGjHQtjb+vA7TS1UwNUPZURejCS12K1OTn0hPHRoqMNFrQ0HR6htwsVaY?=
 =?us-ascii?Q?RsK/771MlT5GdVOJMNpAYLrg17n+0Ry8HycTI7QbJUfsvkAjFSfEXnQZr1Hn?=
 =?us-ascii?Q?hMEZWvmu9ZWIddN/+sk3x+Z7kmcIfyI0SLnLrw7oyIocUW4jfQMr0bGf+3qO?=
 =?us-ascii?Q?UOZ59RcsV0MRfAxQMmpm9NNUK+LSnfjpGU/B2CnolybDk7dkeu3qKDbWOVV+?=
 =?us-ascii?Q?+VWs53RThTCrY2m5/jC1Kkc/t7wB3iUl+lE7ZOs19w9f21e/xOI5Op3xlk36?=
 =?us-ascii?Q?c/S+6G464MPyYk0s8NkPysoGVZsYILRFpn9x?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 10:26:23.6510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 955b1027-f744-4b34-0baa-08dd9f646d63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8054

The EFR[HATS] bits indicate maximum host translation level supported by
IOMMU. Adding support to set the maximum host page table level as indicated
by EFR[HATS]. If the HATS=11b (reserved), the driver will attempt to use
guest page table for DMA API.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  1 +
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/init.c            | 16 ++++++++++++++++
 drivers/iommu/amd/io_pgtable.c      |  4 ++--
 drivers/iommu/amd/iommu.c           |  2 +-
 5 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index bb14c4800dd0..0286120ad4a5 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -42,6 +42,7 @@ int amd_iommu_enable_faulting(unsigned int cpu);
 extern int amd_iommu_guest_ir;
 extern enum protection_domain_mode amd_iommu_pgtable;
 extern int amd_iommu_gpt_level;
+extern u8 amd_iommu_hpt_level;
 extern unsigned long amd_iommu_pgsize_bitmap;
 extern bool amd_iommu_hatdis;
 
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 284ff4309660..6bf81197c2c8 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -96,6 +96,7 @@
 #define FEATURE_GA		BIT_ULL(7)
 #define FEATURE_HE		BIT_ULL(8)
 #define FEATURE_PC		BIT_ULL(9)
+#define FEATURE_HATS		GENMASK_ULL(11, 10)
 #define FEATURE_GATS		GENMASK_ULL(13, 12)
 #define FEATURE_GLX		GENMASK_ULL(15, 14)
 #define FEATURE_GAM_VAPIC	BIT_ULL(21)
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index aa28cddd3337..4bb8cb23bc68 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -152,6 +152,8 @@ bool amd_iommu_dump;
 bool amd_iommu_irq_remap __read_mostly;
 
 enum protection_domain_mode amd_iommu_pgtable = PD_MODE_V1;
+/* Host page table level */
+u8 amd_iommu_hpt_level;
 /* Guest page table level */
 int amd_iommu_gpt_level = PAGE_MODE_4_LEVEL;
 
@@ -3054,6 +3056,7 @@ static int __init early_amd_iommu_init(void)
 	struct acpi_table_header *ivrs_base;
 	int ret;
 	acpi_status status;
+	u8 efr_hats;
 
 	if (!amd_iommu_detected)
 		return -ENODEV;
@@ -3098,6 +3101,19 @@ static int __init early_amd_iommu_init(void)
 	    FIELD_GET(FEATURE_GATS, amd_iommu_efr) == GUEST_PGTABLE_5_LEVEL)
 		amd_iommu_gpt_level = PAGE_MODE_5_LEVEL;
 
+	efr_hats = FIELD_GET(FEATURE_HATS, amd_iommu_efr);
+	if (efr_hats != 0x3) {
+		/*
+		 * efr[HATS] bits specify the maximum host translation level
+		 * supported, with LEVEL 4 being initial max level.
+		 */
+		amd_iommu_hpt_level = efr_hats + PAGE_MODE_4_LEVEL;
+	} else {
+		pr_warn_once(FW_BUG "Disable host address translation due to invalid translation level (%#x).\n",
+			     efr_hats);
+		amd_iommu_hatdis = true;
+	}
+
 	if (amd_iommu_pgtable == PD_MODE_V2) {
 		if (!amd_iommu_v2_pgtbl_supported()) {
 			pr_warn("Cannot enable v2 page table for DMA-API. Fallback to v1.\n");
diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 26cf562dde11..0d8bc06f63d7 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -132,7 +132,7 @@ static bool increase_address_space(struct amd_io_pgtable *pgtable,
 		goto out;
 
 	ret = false;
-	if (WARN_ON_ONCE(pgtable->mode == PAGE_MODE_6_LEVEL))
+	if (WARN_ON_ONCE(pgtable->mode == amd_iommu_hpt_level))
 		goto out;
 
 	*pte = PM_LEVEL_PDE(pgtable->mode, iommu_virt_to_phys(pgtable->root));
@@ -531,7 +531,7 @@ static void v1_free_pgtable(struct io_pgtable *iop)
 
 	/* Page-table is not visible to IOMMU anymore, so free it */
 	BUG_ON(pgtable->mode < PAGE_MODE_NONE ||
-	       pgtable->mode > PAGE_MODE_6_LEVEL);
+	       pgtable->mode > amd_iommu_hpt_level);
 
 	free_sub_pt(pgtable->root, pgtable->mode, &freelist);
 	iommu_put_pages_list(&freelist);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4e9a57377b8c..f7e641571127 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2503,7 +2503,7 @@ static int pdom_setup_pgtable(struct protection_domain *domain,
 static inline u64 dma_max_address(enum protection_domain_mode pgtable)
 {
 	if (pgtable == PD_MODE_V1)
-		return ~0ULL;
+		return PM_LEVEL_SIZE(amd_iommu_hpt_level);
 
 	/* V2 with 4/5 level page table */
 	return ((1ULL << PM_LEVEL_SHIFT(amd_iommu_gpt_level)) - 1);
-- 
2.43.0

