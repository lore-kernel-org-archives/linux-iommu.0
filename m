Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37B63126D7
	for <iommu@lists.linux.dev>; Tue, 11 Aug 2026 05:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786425806; cv=fail; b=JWA91f6NmI1rr/DSWdEegUNzBDjfuvZKF4I1IotWC4llv956SQ9qY2/eN1jNwju1VsIfLLizggZUa/EtpldVRuf1rpefnCzepns5KjHADuGW9uce1zyEwASbTNi8KV8z4djBGuMYFv4QVQTvlkm6TbVs7kHXWYweePeiA1FnGcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786425806; c=relaxed/simple;
	bh=MfeTQDgRuiY1mbmESjsEftroTx5MxloK+OYHN96Rrfo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WqAXwLFCaJsKbKZM1vCpWrswT4AhomkZd42+n+uCviQH/Vpp7Dd0VtON/gPrufdv2fxxKLw4xcFRfHr/gOtKHJQ7B2khiJla8mp1cK71IiGpI2w3v5S2VfsXakX5Sy1F88HB6Fu9a2sZNonI5UWcdI+9kfP/7/5ubc8NnMSHt1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0zwv8XyT; arc=fail smtp.client-ip=52.101.52.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0zwv8XyT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2B0I72v0CyaGZBlq9UcuyrK6IsbKOImpP9V0ybbVV3+9XYWYvZNxYDdfvuuIX8voGetZmttoAHjiPNLhpOBUnsATXmc1BWraxFQf0P6A2xQJjD10gKq0+ub4iOqPeyJVXIekP2iwym6EULNdr53LtXwmzS/VaM73m1icxbG2Cn+sAnqRMwxGcGN9jlF3ni0QNYQm+KHaP4e4MTT+B5Sb3xTeqF5EzbEiqyq3rp+XNAYbQscPGQ5SUODjhjAYtSV5lnnIgDj+jo60eD0ZQESr8Nd6uaOXrRcR1mfSRhPDsdoQMTFhOmqyedXoO5H25721itdC8BrocAZaS0lujmpHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXV9AKN89WR66nEQyWjxxVyAwssfRoUkBKUUvexP3e4=;
 b=f4IVdIRwegBr4exVW0/3ayesjXySlNHexvyvfmWmWFsjsU4CEe5YSRm6GFxklRWgk6K3cscpRPYq44LB2jSd2FK8XnOMk5MsDrMUiyWRJ0qHZaazOD1K7X5x9VD9EdaeATMcbQ87Dyy/dqmdGAqS3qVr0Rte3b1vEhxQvMwfMANFaaohOvmfhvhQhyJHOoNmiG/rtzYO8aeGNwrgeQwpuQOY6UnkEg7scDZ7CUALEglFKDQ2lAwEULZW1E7Qy6su5h5pStGpHLDSHmSdRMXV0We/L20yFzbW+GPNy3isjL6BQZtXh4w6fakuuYJJrxZy8vrJu5GAPIb6fn+UMAtJNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXV9AKN89WR66nEQyWjxxVyAwssfRoUkBKUUvexP3e4=;
 b=0zwv8XyTWz7SMDJrOeGFAuwoBBSxae78nTtOMjLeNBRGx9dgHHrJCWhvEVDHybOE8stI0CP4g11VUsqHW+rUGWEeQ5idkRofNYSJ+3VHpFsqSUvz+x+EO8WtApHZFx4m8JwMk/ut5n0flp0ZcPSoN/HJFn+7/i7eWtetVKwHXPY=
Received: from CYXPR03CA0045.namprd03.prod.outlook.com (2603:10b6:930:d2::25)
 by MW6PR12MB8733.namprd12.prod.outlook.com (2603:10b6:303:24c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 05:23:20 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:d2:cafe::54) by CYXPR03CA0045.outlook.office365.com
 (2603:10b6:930:d2::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Tue,
 11 Aug 2026 05:23:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 05:23:19 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 00:23:16 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Amandeep Kaur Longia <AmandeepKaur.Longia@amd.com>
Subject: [PATCH v2] iommu/amd: Add SNP page mode 0 support
Date: Tue, 11 Aug 2026 05:22:57 +0000
Message-ID: <20260811052257.9247-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|MW6PR12MB8733:EE_
X-MS-Office365-Filtering-Correlation-Id: f8ef437b-b03b-4798-4802-08def768a7ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|6133799003|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7Et2CYYxbWdlaBxxwCIV1OyIDvgj6SwN16LC/jWexncGydsefNLHDf4hhvGo1ZeJlxnatW9XRchl8RkUcpPSHKDG6Jj4K6qBn2f1fsEGMfXvNhuDC0fpMq5fGyn+LGwDOwHp/FTNmoeh+koENB2/Q0yZ1iBjXbHxr0aM9SHo4yo9K6V7+Xi/mDlibM1lq8BcUwwv9ONKdUVLBvBo1BoGVddiR9LE1GnE9ckx6l5q8PidRkl2DbfR3cE1ixhhkV4vBbzhWhi1HthNR34YUv66me5pyLMzyLlCH8jh6RHwwvawT0/G2/hOcIZEQdqrtKUJ1seJXjvHuLSpyZc6S0SPENnr/uJa89l7N0h1wp9uiktlzOxMrTDRDvW/Yli9Vf9B0EoqFwMtMgapkCLUW1zTC/QDKyNFqQkRud6UUtBBFSp2Cmlulqgxmk+EPFbMauEk7elcXtCg4p78yD/uM4+A+0S4zKdoHYwh274/QHxcmaoQ5zXe5y8PEvU4cVTjuXPBxY2+UxmDixFz9czW36O97h+Quf/SpfaviuTs17Dy3G70VRtEe+kg+bgJgOGJZruoH0aWM6MrRrYbS4i9uxM/AEMVpEjmSKlnHst2JmEAfI9WRV7iDHvti6IUgE+ffSLRdSBHId8XAbS79CbULNIqOfG3QZFFlcAmPoBsYwrgqSxU4RVbFNsSUzh3Es0onaK6HM2mqiIzvJh/PlRCK5casQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2LMgCJhxJysdxkeIVI+USaIg1yTxiw9Ipc8h2XVMMfMMZViJnkMXDu7+VBAoBAHceR/iW8PlvjG0fJE/vdHUXSCzJoDISzGZI1vbLZKIm7A8VqUKYTCOfNKEI7INAWJumEumTa5fZF5WveAwbDvxb4nhMwFta356otSuIZgbiWuRzxW24WGTI6+cH4nfvZxSWjpLyJwsb6iIZUlFVfMhlIpa8ktGRhcQwCZyPUtMhQnYclJ+uf37SqguoEQcfy41GxfLRDF2Xj1UthF57xtgb/Ws+IFFp1PU87j2Qm+6/i4qc6HcrFAixke2FD8DhICl9kwo930Ds4RsvEj3WJ23XkmT2Z6H3Dcy0radtC3hbX5bqFEeRcyHyRVTAIdzxszQOWVllYuKMt52TnOwW3qQ/fxAu1HQ3Yoz5Z8xq4IWDZV/xyYGxTGXQ/0t94jPi+K4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 05:23:19.4066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ef437b-b03b-4798-4802-08def768a7ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8733

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
Joerg,
  I have rebased this on top of amd/amd-vi branch and it should apply
  cleanly.

  Sorry. I missed to include this one along with PRI series. I think
  think one is ready. Can you please pick this up for 7.3

-Vasant

 drivers/iommu/amd/amd_iommu_types.h |  4 +++
 drivers/iommu/amd/init.c            | 42 ++++++++++++++++++++---------
 drivers/iommu/amd/iommu.c           |  4 +--
 3 files changed, 35 insertions(+), 15 deletions(-)

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
index c0748521dff8..a1f85d44f2a4 100644
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
@@ -3394,18 +3397,28 @@ static __init void iommu_snp_enable(void)
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
@@ -3940,12 +3953,15 @@ bool amd_iommu_pasid_supported(void)
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
index 563f9c2672d5..d8f626d7f784 100644
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
-- 
2.31.1

