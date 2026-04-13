Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010002.outbound.protection.outlook.com [52.101.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9534B28469B
	for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776091633; cv=fail; b=iwcXEDWMO2eH2cOOwr93F3oTgPcfmlAcAXD66/Ixy1juCYhkopQSbN9rwuhVMWi4+H/iX8tiNRiEqf4c91qnYHG7TzPY+E1n2NhY517ocdetbRGytfr8tjU6Q9aW5xaC4W+f+jIPJVfWPGtysA3/vjASLy6y3Q5Vwe/GCA6wPNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776091633; c=relaxed/simple;
	bh=2lzbzujy6hfcDVy8JoyV4li/VYMz7hxgC2z01rLpwUg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LwoH8MMvtrirOIqQf1mLE5ZJ+XRdxUoHX1TgdqjA+wbGVl1IfkL2NsH2SS0jN784mwMHLNQFQXxKQrBFgBPswWttjPxEdHXrczAN5oy8NULKkB0ofnqZZbrIv1fm8sEI8ypGvHHEilP+SZAPXNNu89WXRbso04NGIbdAApV67yM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NcrdESQU; arc=fail smtp.client-ip=52.101.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NcrdESQU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XjF4uCKKQ/XJ4TbyzEfghg0bwyfhLRYXc9IsXDPZBtUip2nVMYE47X3kL3i2YMVFaYfOOUz2iRPlRrL492Mr9LcvvBTIohgCFEBRjGV+wxRt7gtUB4x3Z1rCFda7SIOcF9OfIupWqiYbvce7N2U5uiOBow8TnTmbcEQT9P7+H4xp+ybqG42XDmmx0sfCo0gH2xRf6qNSMXSJWxC9L3YgzcfAuylBHrU9LdSFMZgsXfOzLGXSLGkO9mdby/9uJY/++o4OP9cKvJLRwis3ZvxOzQpKld3TJ+8dt7mF2ZZ9tjBu83iErG5NL+sjntCSz6iqQY2S/F9lQ1s2zity25+J0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bidcYRQU1gsKoST20xMV1wt7Ww3RkNqewVjbg0yrmn0=;
 b=fbGBV1++02NPHe6pLC+sGBS/Wp9y1+38IZmXluXqpUT2VCWSw/bgThyNhNawdv0XcqGXWXeUYWnHzvUlmlrpXr+NWzWxphZWIjEyaceqM5PmQ3k4KtVhG/rIvfZDkDsbsHmW91LH+57oL34uZWpVN+WiyLtuTffk4+X+avVU+Y+E83tOu/VrJsU17WzNpHt3i1ptQj6buA7wJOYGRWPR1BwUVYd3uVZ6lJ56TBmp0i3QwADtjnrp7L8b10bJrjAjuGx3U1OlESOzdC4BmUVu1vxKJKTaCNfNC3a+D6Koa1sIWx74FGCynMwf0NtPagYq/kP4cu+LExfr5u94zkQv7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bidcYRQU1gsKoST20xMV1wt7Ww3RkNqewVjbg0yrmn0=;
 b=NcrdESQUXTYuL8e7xETbJ+oN2+faXqB9bXH/bIQsxWc79YC+PNEnyCa9pDZIseElvfyGE6RyGNkaLCdfCaZB6uszXbvj6/16+ejfR4DXYXY91738sgfFEDgeIAGdr/CLibFzZspqcqLsX1iTBGK0XVdyo+dNLsZ4f7AiugvtLnE=
Received: from CH0PR04CA0072.namprd04.prod.outlook.com (2603:10b6:610:74::17)
 by SA5PPF3C36BFCB5.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.34; Mon, 13 Apr
 2026 14:47:00 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:74:cafe::62) by CH0PR04CA0072.outlook.office365.com
 (2603:10b6:610:74::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 14:47:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.0 via Frontend Transport; Mon, 13 Apr 2026 14:47:00 +0000
Received: from BLRANKISONI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 09:46:56 -0500
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>,
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>, <jgg@ziepe.ca>
Subject: [PATCH v5 4/4] iommu/amd: Adhere to IVINFO[VASIZE] for address limits
Date: Mon, 13 Apr 2026 14:45:21 +0000
Message-ID: <180ff283b9024dff4d8de39499623c749de56c89.1776075533.git.Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1776075533.git.Ankit.Soni@amd.com>
References: <cover.1776075533.git.Ankit.Soni@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|SA5PPF3C36BFCB5:EE_
X-MS-Office365-Filtering-Correlation-Id: ec55cbd4-6cef-415d-f54f-08de996b84de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	XMUtBNlbRBET2rqeRiCsZNSNnVjh4fuF1KEMahgkwrj4purKBDzIaB7ZMvV3UHXtOl/4yG4KgRXl0SrN1KAAJWz+8K8Cqhgf2Sq+2ckcZBSb/HJGIyo6xGwZzit8PEOjAZE6OFefrBKPRBAGd7kPBFajHNTwHa7g15MkO54LmJqH9s9o1Rd1UbxN/n3cFVcUqAd0kj0SpaxEWlth/bngDtGwR1KbXmDBPU4QtiPArE9OsSLjZAQ3R8SPkDIyiy/vbJtxxA3Aqqg0Sc/9K9MzAV+Wnh2gZp/ScRFbGf1q/p3NhWicheQZPY5fwcABqR5ph0kQvcC0SrjIQFDChwNB5gov41C+8D6rLHG71p8uaAM6gpoOTjZZwT74DR0+eSrgvrLXstb1xRN46ZhsVZ8sJTj1m3fXSZHiUzME7PEkFz/vCNfaNNWYGkNKaEiG9HqjsPtb57W/prfdA7OmGA37zac49qQZ9rQEXIrM0xwDTBgvYutGl1hm+Ivn2htLTrRSd2TJV2IEDd01K7RT/kiLoMOkQKg553GZEVkwBVBPmDjTi1PXZlfgXJo7NVVb1gSOi+nsCTGvR84jsyiglDTc5wYKaqkpPYyEDVFMf4FnzGsQXaRoE/OcQ7x4fzPjOLciQ9Si6ATlDnTyGxf+k4HBBnYRDumBIDKXMgYC4fcf/zSH5wD0aePYydAoxvYiRcLOYs20PgK8St2A9EJ6ZH2b7f/5VHUjveLxl6AHmGWd87B6Wu334yP0JeiK3uwIwfjhc8REnkTKGu1XBRZ147MX0w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	h75C4+RGfL9y0mCLw6IQrcVmcz81SX2twOT5fQb/81G8oRdxp3Lf0YKDkGvFDHlX1Fnt3rIAZpjz63JFwznYBxAvlQb+2Rp0lundYKKemBsde8+cphVdGlgXq2l+8C9e+WNUIqIhH+ZyCRTRCGhCuW6jrcRSX25Vq7N+2I/MmjnTCpA4yPWwsHg+fsSCWo/tseDRPG8DTbiosbnBHuCC8NeDCg8DQJ8XqRuPIBsGIe46+XdxqxPj3zftrmZCemur3WgnXedMM9hhBLk1d5TxauaCs9YUCClb6mqjZlMtcu/U4RxHQGTkyma+IfMUIlxDe7JL5cNB+xgLIxCIRIkMWtzFE8czNLzjp8DpxfvqCbrffxKgn7etVdBhnabitM3pklhWx75ccjLhi6uqP/7uYy04yWyHW7Cn5NDXs3O0ZFVMnoh9BWvpSw7kwP13Bt6b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 14:47:00.2410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec55cbd4-6cef-415d-f54f-08de996b84de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF3C36BFCB5

ACPI IVRS IVHD’s IVINFO field reports the maximum virtual address
size (VASIZE) supported by the IOMMU. The AMD IOMMU driver currently
caps this with pagetable level reported by EFR[HATS] when configuring
paging domains (hw_max_vasz_lg2). On systems where firmware or VM
advertises smaller or different limits, the driver may over-advertise
capabilities and create domains outside the hardware’s actual bounds.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  2 +-
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/init.c            | 13 +++++++++----
 drivers/iommu/amd/iommu.c           |  3 +--
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 1342e764a548..f915938a3a08 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -41,7 +41,7 @@ int amd_iommu_enable_faulting(unsigned int cpu);
 extern int amd_iommu_guest_ir;
 extern enum protection_domain_mode amd_iommu_pgtable;
 extern int amd_iommu_gpt_level;
-extern u8 amd_iommu_hpt_level;
+extern u8 amd_iommu_hpt_vasize;
 extern unsigned long amd_iommu_pgsize_bitmap;
 extern bool amd_iommu_hatdis;
 
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index c685d3771436..6a85a38d34bd 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -395,6 +395,7 @@
 #define IOMMU_IVINFO_OFFSET     36
 #define IOMMU_IVINFO_EFRSUP     BIT(0)
 #define IOMMU_IVINFO_DMA_REMAP  BIT(1)
+#define IOMMU_IVINFO_VASIZE	GENMASK_ULL(21, 15)
 
 /* IOMMU Feature Reporting Field (for IVHD type 10h */
 #define IOMMU_FEAT_GASUP_SHIFT	6
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index f3fd7f39efb4..e874a4135d5c 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -152,8 +152,8 @@ bool amd_iommu_dump;
 bool amd_iommu_irq_remap __read_mostly;
 
 enum protection_domain_mode amd_iommu_pgtable = PD_MODE_V1;
-/* Host page table level */
-u8 amd_iommu_hpt_level;
+/* Virtual address size */
+u8 amd_iommu_hpt_vasize;
 /* Guest page table level */
 int amd_iommu_gpt_level = PAGE_MODE_4_LEVEL;
 
@@ -3188,7 +3188,7 @@ static int __init early_amd_iommu_init(void)
 	struct acpi_table_header *ivrs_base;
 	int ret;
 	acpi_status status;
-	u8 efr_hats;
+	u8 efr_hats, max_vasize;
 
 	if (!amd_iommu_detected)
 		return -ENODEV;
@@ -3218,6 +3218,10 @@ static int __init early_amd_iommu_init(void)
 
 	ivinfo_init(ivrs_base);
 
+	max_vasize = FIELD_GET(IOMMU_IVINFO_VASIZE, amd_iommu_ivinfo);
+	if (!max_vasize)
+		max_vasize = 64;
+
 	amd_iommu_target_ivhd_type = get_highest_supported_ivhd_type(ivrs_base);
 	DUMP_printk("Using IVHD type %#x\n", amd_iommu_target_ivhd_type);
 
@@ -3240,7 +3244,8 @@ static int __init early_amd_iommu_init(void)
 		 * efr[HATS] bits specify the maximum host translation level
 		 * supported, with LEVEL 4 being initial max level.
 		 */
-		amd_iommu_hpt_level = efr_hats + PAGE_MODE_4_LEVEL;
+		amd_iommu_hpt_vasize = min_t(unsigned int, max_vasize,
+					 (efr_hats + PAGE_MODE_4_LEVEL - 1) * 9 + 21);
 	} else {
 		pr_warn_once(FW_BUG "Disable host address translation due to invalid translation level (%#x).\n",
 			     efr_hats);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 760d5f4623b5..c18252a2c857 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2712,8 +2712,7 @@ static struct iommu_domain *amd_iommu_domain_alloc_paging_v1(struct device *dev,
 	else
 		cfg.common.features |= BIT(PT_FEAT_FLUSH_RANGE);
 
-	cfg.common.hw_max_vasz_lg2 =
-		min(64, (amd_iommu_hpt_level - 1) * 9 + 21);
+	cfg.common.hw_max_vasz_lg2 = amd_iommu_hpt_vasize;
 	cfg.common.hw_max_oasz_lg2 = 52;
 	cfg.starting_level = 2;
 	domain->domain.ops = &amdv1_ops;
-- 
2.43.0

