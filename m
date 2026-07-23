Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011067.outbound.protection.outlook.com [52.101.52.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B9240DB51
	for <iommu@lists.linux.dev>; Thu, 23 Jul 2026 08:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784796247; cv=fail; b=lNKH8/mFVemC6MxmZlx8RRLBpuTFAR72VUSFf8WSZYzJ1vvlFawoDTqwmQq1Xhv3m+/vKFzNuQ4/W1TJWmXYEw758aha2Q8ElHqUsoEC8TS/vhEzg7cO9M2u84zbABVmhdgb5IaFYPfzedLWVE7R0z1dAv82cSoX5U0eb/xZMVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784796247; c=relaxed/simple;
	bh=+HwpgLuP0MCd0BunU814xAHHYmSvn755Ytp3cXp9j2c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Huqie7sdVGSUnHH00Tmr8dKTkR0rqarfW8hO0bkCds0CkzQU4CbleCcki6ovObFp44TkFdd+y0CimybOn18/3cSM+vmj2n359V8lVWI/KutI5ONGckOQg2LSpin7jdHLrmsDQSMg6s89doigYJRuRthLwQ0AYuXQv4U01+YFB2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=srfTnbEF; arc=fail smtp.client-ip=52.101.52.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="srfTnbEF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mukyfrG8QIMJmaZ+CdUMCZJpT1/weD7HkYFjB5laoX0OHG79Qg10Dqd1mvtMex3eysrSTinqa3H1dN2TJNFGuDaCe/PUb47vt0ChpusEd1M+36x3EEFgXQh3RQAmfhO1QJW04QuyDUJQXMJvLwy/qrCjSuSv4TaN3KR5xinPpaESk4s/Z83lkYrhzSgPsTV7d6EdcwssV49DzEGyenyC0e7QopHwBoNa9qs3v3LF1vvnWcDM8uLJwJxFdWiuJF08e3b/fIcfFSY+WkJAbJypRfJZz1CYc7S5Q6CLmSD9asOz8lQ3TriDRaW6poIWQA04pthHwBFguJObSdWzRCCUQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NT0KB0KTfkNHWfe/OxNpGLM/AkMt43ialeA5rGTanUI=;
 b=bnm3k364CvclF2GABI1XLzmbRcLA/BB4Fx9uukUjQuT8KOTMZzjtIMXtCD3tB2xJkUewurRGEwiDxZk0qbJvNj6MYyATFbks83v2hCFppttG4yFEWQriq3vc3+30nDrZ1OxlKuBq4UZurkCGq7CtZLs1lvCpEPjuVCKT4qfEKR4zU3RWiKD176nT4rE62MIMGaUL8r7FyTsI0b7eNB1RECrl2uSYCcbbjUK3bI5cokxEWch1aRZhjuPXBmRHdvsKHPo5NLrR9S4DWFnP3lsAt51aihRvbRd6Q2PLBmxOj0G5MJem5vO60HtDoRye+2GiARQOu0wQtcx1jvPec6jcLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NT0KB0KTfkNHWfe/OxNpGLM/AkMt43ialeA5rGTanUI=;
 b=srfTnbEFdNPcii2kozogPRC38fUUFxChRhbFbo8+NCc43OHJIgxf3DMSYA0ftXuhX2Aln0IhMdUY2gx/vcUZT+nE7nsWsBMeTRUka1hU0rv3Q4woUH5vSAlSyU9+SX28I5wZMOftCnjTKJMzC4WUaDg+GFkoEXfWREERhMLqTeY=
Received: from MW4PR03CA0012.namprd03.prod.outlook.com (2603:10b6:303:8f::17)
 by CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 08:43:57 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:303:8f:cafe::28) by MW4PR03CA0012.outlook.office365.com
 (2603:10b6:303:8f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Thu,
 23 Jul 2026 08:43:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 08:43:57 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 03:43:53 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Amandeep Kaur Longia <AmandeepKaur.Longia@amd.com>
Subject: [PATCH] iommu/amd: Add SNP page mode 0 support
Date: Thu, 23 Jul 2026 08:43:32 +0000
Message-ID: <20260723084332.11008-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|CH3PR12MB9079:EE_
X-MS-Office365-Filtering-Correlation-Id: bc00412c-16a4-4330-bd82-08dee89688d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|11063799006|10067099003|6133799003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	AfMKpS7f0mX8OvVjYxX9aCx9UAooJmnWBKQu62C6f7mV+XyupM/N1shoA18xmIF6snybSDiFXCqhsYUIZ9/a1RL5ZXeqVGc/ND1wxszRZSnPkle7WL0gLBAMusiB3MoXfzCV34/Y/oUesVuSAP+sIfb57af3SRC8Zj/pw2m2TgMbA6DCoIFFIxk7V1QpTTSSev+oiR+v8cjdoZcat0b/NSVq0rBBPsZPOyFGSlRbi6etQ/fj81cije+2kagG9p3T4Q/PCkDFatNerll+hn59ZhewmlTyBQy1wp3NQmNsvo4ea29CPCw8sQ4eFOnCxj8x1Z43T/+svJwjR4E4bfmJNoxjoUFaMypO3K1lr5RUgsfaX5owmehdP4FK5qsy7tsYHCZoM04WBsuNg+Fu+34zpbwaBnW5IHHdYJS00/opllknf9pgOP4nSC7aC/hoGGImx5b580HDcKzS1Nqjnj+JblAK2mDoXewYCOH8h+jYYaMUd7DtxB3HekQTgNJuJu18b3lkaeFN8USUMFDRHc/Ty2tPv8H4mczH3CCnxL7UnTBCfUzDt35qn4xEdPvopbMRPf5uegCyxUOfLtjQ7s733cbhpOhBmbLpofmlLpFledMbmz+pAhoQIhyXZIw8Ucwyt1jgHaI+jRP3UrMrQR3t8nYHfToL5phhwU/qta8alKVjXUKJxSUV+x8BdTWnKgrBIFrIn1DwUzlVBZZ/NZ+97A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(11063799006)(10067099003)(6133799003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HjcCXvauAhDcn2ie7yfY+phuHHyTaxRIkEetuoPIl3y52uTPaIeBRFfUnwDKnjAq23fa4f6j+d+2tXOZRNZPaVl4/P84wuRI2HQvKP4F/u7rnxUaGxAXXheXvmJPVD8/MT/SKwzpfPwl4eGvwrZLAufKj1yUz4P4Hz8NPH2S4z+6X+amsRq1IIWFgx1us624jHbTuG7NODvzTWV0lLw/76pgZt5DjBb9gQ225RQh06xzM63Fpi1EGwDHz1RbbEcOoN2ZujNuO+2ys5TrG0gQe5eCJnXNgLhr0qKWLYhvVha6P7tB5rH3MXXFYwputaKLmP1NymBciVnt/Jxsf5oyyp/kFx1hxucd431QXO17d5CVsevSzxlUGSny/5sflfzvSdTjoEuS3i/MOh8uj8WrVN/TG5a8G/yP+8SbLzjif/JIHfMSKXBeG40fy9/O29Fa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 08:43:57.0078
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc00412c-16a4-4330-bd82-08dee89688d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9079

Newer AMD IOMMUs supports DTE[Mode]=0 for SNP-enabled system. This is
detected using new feature bit (EFR2[SNP_Page_Mode_0_Sup]). If this
feature is enabled, then IOMMU supports:
  - Passthrough mode (i.e. iommu=pt)
  - amd_iommu=pgtbl_v2: Forcing Linux DMA-API to use IOMMU v2 page table
  - Setting up device for SVA mode in the host.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Tested-by: Amandeep Kaur Longia <AmandeepKaur.Longia@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  4 +++
 drivers/iommu/amd/init.c            | 42 ++++++++++++++++++++---------
 drivers/iommu/amd/iommu.c           | 11 +++++---
 3 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 3c292fdfa95a..d421151e9b7a 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -113,6 +113,7 @@
 #define FEATURE_SNPAVICSUP_GAM(x) \
 	(FIELD_GET(FEATURE_SNPAVICSUP, x) == 0x1)
 #define FEATURE_HT_RANGE_IGNORE		BIT_ULL(11)
+#define FEATURE_SNP_PAGE_MODE0_SUP	BIT_ULL(13)
 
 #define FEATURE_NUM_INT_REMAP_SUP	GENMASK_ULL(9, 8)
 #define FEATURE_NUM_INT_REMAP_SUP_2K(x) \
@@ -416,6 +417,9 @@ extern bool amd_iommu_dump;
 			pr_info(format, ## arg);	\
 	} while(0);
 
+/* SNP page mode 0 support */
+extern bool amd_iommu_snp_mode0_sup;
+
 /* global flag if IOMMUs cache non-present entries */
 extern bool amd_iommu_np_cache;
 /* Only true if all IOMMUs support device IOTLBs */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index e93bcb5eef70..1fdd83a14dfb 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -180,6 +180,9 @@ bool amd_iommu_hatdis;
 bool amd_iommu_snp_en;
 EXPORT_SYMBOL(amd_iommu_snp_en);
 
+/* SNP page mode 0 support */
+bool amd_iommu_snp_mode0_sup;
+
 LIST_HEAD(amd_iommu_pci_seg_list);	/* list of all PCI segments */
 LIST_HEAD(amd_iommu_list);		/* list of all AMD IOMMUs in the system */
 LIST_HEAD(amd_ivhd_dev_flags_list);	/* list of all IVHD device entry settings */
@@ -3365,18 +3368,28 @@ static __init void iommu_snp_enable(void)
 #ifdef CONFIG_KVM_AMD_SEV
 	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
 		return;
-	/*
-	 * The SNP support requires that IOMMU must be enabled, and is
-	 * configured with V1 page table (DTE[Mode] = 0 is not supported).
-	 */
-	if (no_iommu || iommu_default_passthrough()) {
-		pr_warn("SNP: IOMMU disabled or configured in passthrough mode, SNP cannot be supported.\n");
+
+	/* SNP support required IOMMU to be ON */
+	if (no_iommu) {
+		pr_warn("SNP: IOMMU disabled, SNP cannot be supported.\n");
 		goto disable_snp;
 	}
 
-	if (amd_iommu_pgtable != PD_MODE_V1) {
-		pr_warn("SNP: IOMMU is configured with V2 page table mode, SNP cannot be supported.\n");
-		goto disable_snp;
+	amd_iommu_snp_mode0_sup = check_feature2(FEATURE_SNP_PAGE_MODE0_SUP);
+	/*
+	 * If SNP page mode 0 is not enabled, then SNP support requires that IOMMU
+	 * must be configured with V1 page table (DTE[Mode] != 0).
+	 */
+	if (!amd_iommu_snp_mode0_sup) {
+		if (iommu_default_passthrough()) {
+			pr_warn("SNP: IOMMU configured in passthrough mode, SNP cannot be supported.\n");
+			goto disable_snp;
+		}
+
+		if (amd_iommu_pgtable != PD_MODE_V1) {
+			pr_warn("SNP: IOMMU is configured with V2 page table mode, SNP cannot be supported.\n");
+			goto disable_snp;
+		}
 	}
 
 	amd_iommu_snp_en = check_feature(FEATURE_SNP);
@@ -3911,12 +3924,15 @@ bool amd_iommu_pasid_supported(void)
 	    amd_iommu_gpt_level != PAGE_MODE_5_LEVEL)
 		return false;
 
+	if (!amd_iommu_gt_ppr_supported())
+		return false;
+
 	/*
-	 * Since DTE[Mode]=0 is prohibited on SNP-enabled system
-	 * (i.e. EFR[SNPSup]=1), IOMMUv2 page table cannot be used without
-	 * setting up IOMMUv1 page table.
+	 * If SNP page mode 0 is not supported, then DTE[Mode]=0 is prohibited
+	 * on SNP-enabled system (i.e. EFR[SNPSup]=1). IOMMUv2 page table
+	 * cannot be used without setting up IOMMUv1 page table.
 	 */
-	return amd_iommu_gt_ppr_supported() && !amd_iommu_snp_en;
+	return (!amd_iommu_snp_en) || (amd_iommu_snp_en && amd_iommu_snp_mode0_sup);
 }
 
 struct amd_iommu *get_amd_iommu(unsigned int idx)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index fe642e33c87d..8be138c9bec3 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2910,9 +2910,9 @@ static int amd_iommu_identity_attach(struct iommu_domain *dom, struct device *de
 {
 	/*
 	 * Don't allow attaching a device to the identity domain if SNP is
-	 * enabled.
+	 * enabled and SNP Mode0 support is not present.
 	 */
-	if (amd_iommu_snp_en)
+	if (amd_iommu_snp_en && !amd_iommu_snp_mode0_sup)
 		return -EINVAL;
 
 	return amd_iommu_attach_device(dom, dev, old);
@@ -3164,8 +3164,11 @@ static int amd_iommu_def_domain_type(struct device *dev)
 		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
 			return 0;
 
-		/* DTE[Mode]=0 is prohibited when SNP is enabled */
-		if (amd_iommu_snp_en)
+		/*
+		 * DTE[Mode]=0 is prohibited when SNP is enabled and SNP
+		 * Mode 0 is not supported.
+		 */
+		if (amd_iommu_snp_en && !amd_iommu_snp_mode0_sup)
 			return 0;
 
 		return IOMMU_DOMAIN_IDENTITY;
-- 
2.31.1

