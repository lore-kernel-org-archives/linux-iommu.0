Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6CEC95C
	for <iommu@lists.linux.dev>; Fri, 10 Mar 2023 09:00:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dixsiKUiePSqZhbfsRxj+wQHoPRo5tXXC4NnhNap0UnXZ2NRJk0IByHM5Xt8Xts/nG4NMf3So8Z/d2ZZyaQKjIugqD9QTkzCnfJjDbiCQ5vp9WNRhfV7/Czb3JXCDweasxwDRIZ53NTOuDoOHmV7BMX87/avFROSaNYI4K6J90qcSc3vvFGo4p4SGwy/iuvYefC8thBRkB7rnECVVfUTdCMWYMxvVv2y1QRpHPwZNcit3u9o98I7N2ufLNL0Y6yRE3AWV8BsysdH+91FxfRa1jh2E1YyxUNfuyo/w5ihVul30VOodZAeAtqRrrOle4f6ndXKbFtoIiGEgScAHdO8xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgpNgXa/RWQgokRiAgmoagN59NSHA7rdBNO0y1ToVlE=;
 b=NSMfij55rnkkcRyv15eZIgvRMJGzdBGA4X91VxhkY3q9M2jivcvao2zzC3gR00mSTAMCfyLhXNKeW1r6KhwOLBx/Wt9ccg/U/al9+Qw0IQiSxaMlPhPO3Vw4/frrZUrG6DfcnoFifDIr5KskSCf1zGcRDDACKk+ifzyjtmbFreVnb62vIh2ygl5mEy07T7mAetpX2Ls/doFcg9xO6FV1TR+wU9esM7i1QiKPY37Fq6dL0QTteisohWaWPqXsDw9H9F4Js6LfNWbwYf4HOfzzzOc92FwwVGJmHvPCeazI93TzcTFAoR+Ea7RY2K88alhcM+4dUVw6i8LazsAouj5YNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgpNgXa/RWQgokRiAgmoagN59NSHA7rdBNO0y1ToVlE=;
 b=thoOHR+yh0Jfb12tDeRUbiuwoURMB1KHf5vrWa0deyS8wg0epsRpp0kdFty7Ea+0CiIDf+Ex/cHIkzFuCnQWUqsUys0SQ+1/YYqGg1KjXLTOyKxCGNjKE1x4U5R7GwU7qkX/qfagBoCEs1lJDeXpLsq4njMKfPbYPodxMAPz7/g=
Received: from MW4PR04CA0259.namprd04.prod.outlook.com (2603:10b6:303:88::24)
 by MW4PR12MB7032.namprd12.prod.outlook.com (2603:10b6:303:20a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Fri, 10 Mar
 2023 09:00:53 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::8f) by MW4PR04CA0259.outlook.office365.com
 (2603:10b6:303:88::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20 via Frontend
 Transport; Fri, 10 Mar 2023 09:00:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.19 via Frontend Transport; Fri, 10 Mar 2023 09:00:52 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 03:00:47 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Wei
 Huang" <wei.huang2@amd.com>
Subject: [PATCH] iommu/amd: Add 5 level guest page table support
Date: Fri, 10 Mar 2023 09:00:00 +0000
Message-ID: <20230310090000.1117786-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT068:EE_|MW4PR12MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: d0796f15-f982-4107-35fd-08db2145f353
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TzpqtZw74bgU7drXTwfZ/XRoAXODpQbDj9GXkuhQVEPlyXJYCDTWW9Kja/BqC1NIcfZMgcQxJZ62SMx/TORTbxupA4yWnfNj5TJLgVl83ZgNPJ9amp9zcTGAFgujpPUIwd5dQN8NoZRhEUtB6NosUnMYXq+j3ylIWSfHPcwMhbl3j7+TbmZKeWz4B6NA7bN+Xgg3vi9gknRPvoLkfSnxTjw6/VgxNLm1NpGaTrhf275eGy9g0+JjUU7K753I0AT2TT0Tm2319+/fIUBFa0+SBR7bS3CNG5RA38OcEsJO6+jNAFCHnoE2ukkfOLtZEdUByiIPPfafHRLvADpiQrHy/5RFhPZfO7Skdqb12h425yEyY3i9vjcrPhudCIPQKyLrvYkMHPCZiQ+Yh+7zk7YqbYyqrSc3l9KmsHw/7Pg6lDoCzZJpAb8pArTdAzAylTVhdDf1v7/QsdhbQOy+LRsn41GdyFMJHXa/wXzYLpBwH09SfoBkFitYKhs1ysUVRMR0bWs7J+QAE/qdKeSRLomdHhSOlGwcynWW+QFUAxaND6x3jrxikfoeSCbQpvbswYd8FrlAU3VTphMporzV2AXgbzfnyxptRkJ21HmbCTOhFA0cBLz3dMV8rHDEP2EZGqeGL4SFiRsoCMNLntMLPTDP7VluWlhrG8+4MCxhzA2DYlTwRa1IraCheYjGJEoeVDuvu8ZLTvHf2RJKOzksEr0Q14CHJ5mFbzH/6ppMng43g/I=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(8936002)(426003)(47076005)(81166007)(7696005)(5660300002)(82310400005)(478600001)(36860700001)(356005)(36756003)(16526019)(186003)(110136005)(83380400001)(40480700001)(54906003)(44832011)(336012)(41300700001)(2616005)(2906002)(316002)(26005)(1076003)(70586007)(86362001)(8676002)(6666004)(4326008)(82740400003)(40460700003)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 09:00:52.0271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0796f15-f982-4107-35fd-08db2145f353
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7032

Newer AMD IOMMU supports 5 level guest page table (v2 page table). If both
processor and IOMMU supports 5 level page table then enable it. Otherwise
fall back to 4 level page table.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  1 +
 drivers/iommu/amd/amd_iommu_types.h |  7 +++++++
 drivers/iommu/amd/init.c            | 23 +++++++++++++++++++++--
 drivers/iommu/amd/io_pgtable_v2.c   |  9 ++++++---
 drivers/iommu/amd/iommu.c           |  5 +++++
 5 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index c160a332ce33..1db1c30aeed4 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -34,6 +34,7 @@ extern int amd_iommu_reenable(int);
 extern int amd_iommu_enable_faulting(void);
 extern int amd_iommu_guest_ir;
 extern enum io_pgtable_fmt amd_iommu_pgtable;
+extern int amd_iommu_gpt_level;
 
 /* IOMMUv2 specific functions */
 struct iommu_domain;
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 3d684190b4d5..27f0d6499996 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -93,6 +93,8 @@
 #define FEATURE_GA		(1ULL<<7)
 #define FEATURE_HE		(1ULL<<8)
 #define FEATURE_PC		(1ULL<<9)
+#define FEATURE_GATS_SHIFT	(12)
+#define FEATURE_GATS_MASK	(3ULL)
 #define FEATURE_GAM_VAPIC	(1ULL<<21)
 #define FEATURE_GIOSUP		(1ULL<<48)
 #define FEATURE_EPHSUP		(1ULL<<50)
@@ -305,6 +307,9 @@
 #define PAGE_MODE_6_LEVEL 0x06
 #define PAGE_MODE_7_LEVEL 0x07
 
+#define GUEST_PGTABLE_4_LEVEL	0x00
+#define GUEST_PGTABLE_5_LEVEL	0x01
+
 #define PM_LEVEL_SHIFT(x)	(12 + ((x) * 9))
 #define PM_LEVEL_SIZE(x)	(((x) < 6) ? \
 				  ((1ULL << PM_LEVEL_SHIFT((x))) - 1): \
@@ -398,6 +403,8 @@
 #define DTE_GCR3_SHIFT_B	16
 #define DTE_GCR3_SHIFT_C	43
 
+#define DTE_GPT_LEVEL_SHIFT	54
+
 #define GCR3_VALID		0x01ULL
 
 #define IOMMU_PAGE_MASK (((1ULL << 52) - 1) & ~0xfffULL)
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 19a46b9f7357..f7f975462fe2 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -153,6 +153,8 @@ bool amd_iommu_dump;
 bool amd_iommu_irq_remap __read_mostly;
 
 enum io_pgtable_fmt amd_iommu_pgtable = AMD_IOMMU_V1;
+/* Guest page table level */
+int amd_iommu_gpt_level = PAGE_MODE_4_LEVEL;
 
 int amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_VAPIC;
 static int amd_iommu_xt_mode = IRQ_REMAP_XAPIC_MODE;
@@ -306,6 +308,11 @@ static bool check_feature_on_all_iommus(u64 mask)
 	return !!(amd_iommu_efr & mask);
 }
 
+static inline int check_feature_gpt_level(void)
+{
+	return ((amd_iommu_efr >> FEATURE_GATS_SHIFT) & FEATURE_GATS_MASK);
+}
+
 /*
  * For IVHD type 0x11/0x40, EFR is also available via IVHD.
  * Default to IVHD EFR since it is available sooner
@@ -2155,8 +2162,10 @@ static void print_iommu_info(void)
 		if (amd_iommu_xt_mode == IRQ_REMAP_X2APIC_MODE)
 			pr_info("X2APIC enabled\n");
 	}
-	if (amd_iommu_pgtable == AMD_IOMMU_V2)
-		pr_info("V2 page table enabled\n");
+	if (amd_iommu_pgtable == AMD_IOMMU_V2) {
+		pr_info("V2 page table enabled (Paging mode : %d level)\n",
+			amd_iommu_gpt_level);
+	}
 }
 
 static int __init amd_iommu_init_pci(void)
@@ -3025,6 +3034,11 @@ static int __init early_amd_iommu_init(void)
 	if (ret)
 		goto out;
 
+	/* 5 level guest page table */
+	if (cpu_feature_enabled(X86_FEATURE_LA57) &&
+	    check_feature_gpt_level() == GUEST_PGTABLE_5_LEVEL)
+		amd_iommu_gpt_level = PAGE_MODE_5_LEVEL;
+
 	/* Disable any previously enabled IOMMUs */
 	if (!is_kdump_kernel() || amd_iommu_disabled)
 		disable_iommus();
@@ -3556,6 +3570,11 @@ __setup("ivrs_acpihid",		parse_ivrs_acpihid);
 
 bool amd_iommu_v2_supported(void)
 {
+	/* CPU page table size should match IOMMU guest page table size */
+	if (cpu_feature_enabled(X86_FEATURE_LA57) &&
+	    amd_iommu_gpt_level != PAGE_MODE_5_LEVEL)
+		return false;
+
 	/*
 	 * Since DTE[Mode]=0 is prohibited on SNP-enabled system
 	 * (i.e. EFR[SNPSup]=1), IOMMUv2 page table cannot be used without
diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io_pgtable_v2.c
index 8638ddf6fb3b..0a302138b488 100644
--- a/drivers/iommu/amd/io_pgtable_v2.c
+++ b/drivers/iommu/amd/io_pgtable_v2.c
@@ -37,8 +37,7 @@
 
 static inline int get_pgtable_level(void)
 {
-	/* 5 level page table is not supported */
-	return PAGE_MODE_4_LEVEL;
+	return amd_iommu_gpt_level;
 }
 
 static inline bool is_large_pte(u64 pte)
@@ -383,6 +382,7 @@ static struct io_pgtable *v2_alloc_pgtable(struct io_pgtable_cfg *cfg, void *coo
 	struct amd_io_pgtable *pgtable = io_pgtable_cfg_to_data(cfg);
 	struct protection_domain *pdom = (struct protection_domain *)cookie;
 	int ret;
+	int ias = IOMMU_IN_ADDR_BIT_SIZE;
 
 	pgtable->pgd = alloc_pgtable_page();
 	if (!pgtable->pgd)
@@ -392,12 +392,15 @@ static struct io_pgtable *v2_alloc_pgtable(struct io_pgtable_cfg *cfg, void *coo
 	if (ret)
 		goto err_free_pgd;
 
+	if (get_pgtable_level() == PAGE_MODE_5_LEVEL)
+		ias = 57;
+
 	pgtable->iop.ops.map_pages    = iommu_v2_map_pages;
 	pgtable->iop.ops.unmap_pages  = iommu_v2_unmap_pages;
 	pgtable->iop.ops.iova_to_phys = iommu_v2_iova_to_phys;
 
 	cfg->pgsize_bitmap = AMD_IOMMU_PGSIZES_V2,
-	cfg->ias           = IOMMU_IN_ADDR_BIT_SIZE,
+	cfg->ias           = ias,
 	cfg->oas           = IOMMU_OUT_ADDR_BIT_SIZE,
 	cfg->tlb           = &v2_flush_ops;
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 5a505ba5467e..a79a6862b493 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1611,6 +1611,11 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 		tmp = DTE_GCR3_VAL_C(gcr3) << DTE_GCR3_SHIFT_C;
 		flags    |= tmp;
 
+		if (amd_iommu_gpt_level == PAGE_MODE_5_LEVEL) {
+			dev_table[devid].data[2] |=
+				((u64)GUEST_PGTABLE_5_LEVEL << DTE_GPT_LEVEL_SHIFT);
+		}
+
 		if (domain->flags & PD_GIOV_MASK)
 			pte_root |= DTE_FLAG_GIOV;
 	}
-- 
2.31.1

