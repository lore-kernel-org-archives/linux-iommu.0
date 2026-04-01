Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010058.outbound.protection.outlook.com [52.101.201.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB155478849
	for <iommu@lists.linux.dev>; Wed,  1 Apr 2026 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054729; cv=fail; b=jX/kiPAYp1Gc8wWQl0OSkCaz/2ga++ixs70Yl8Id7JxSdzUmSZkR3b+qwh0WGfFj99DT2g5utxGm1HmaAZlMal63Rr6ciw3ch2M0xiAcH0C3G96036+nErzS5L9PJ5/oGbBbbibwF5silPifRjpqodm8BiEIlPzW+wuWrUhxuyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054729; c=relaxed/simple;
	bh=2lzbzujy6hfcDVy8JoyV4li/VYMz7hxgC2z01rLpwUg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EgFZX3QLeMlNii/7jvnWthY9XRBIn9Gl7OExgOvWfRNY9BPwc3e4IWXpZLcQ3F+Lq8aDKr+bxyn7mNCqQg3U7R5uEqgD1bFDSxNZ/1nCZEqRh75jbK2Ck5ejCrFC8/VduqrkTF0GyiruXh0Kqjdib8tqqpYNBhqV7VpiDFYGNxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V44MaoX0; arc=fail smtp.client-ip=52.101.201.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V44MaoX0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQSEVnhCZyO7JHK59kqxOXRBWGsT1JllsBk0wOBEObFNm1oZ1y5miIoPyiamS19CXeYaiFL0Uw8GdcUf6B6DnKrUn1SwPwVfBKntH0NedC4bCfTQ4NrnarDi3AWs5pZj5O9bPa3ZbTMaswuJG8vOlOq4Dhw9EiQ7oTq3i9mHfKtEEkxFLBE1mNn4k6fVlT8fMmCdW78xVw3XrWJuHk4qvNP12QPdiWXny8lONbpDG5Ilm0T4+JTPaaFNi7U4MbpWD5OycYfye1NkpX2upS8h3mBrPczofYqmpBcDNLGNmeLG5rFGxxKexRlZSVtr5+cCtucepFn3pwCA6CcFmWbcog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bidcYRQU1gsKoST20xMV1wt7Ww3RkNqewVjbg0yrmn0=;
 b=WMoQEPTF5Mf5urgKGC18JgJP74/YTm1kIbU6w5Nv04gCjSPJx3TAFAfaPtnJTZuKAeaCkGfUP/DQ+Fu9k0PtmaTujSYCdxhqNhYkvUkXyBHgOC8P89K0BfvNaHipZrIOmtxAXVymqh5LKQqrpiAUYPBWTyOA49yAgXx9rvjBnRnw10yhKyrOfZ0by+bvaVLZoXELAewEHMVlXK0wC8aIXLleKDucmkwboZmFWIzvMOdVPjMyeYvyh1qq3DJ+K2oZqMuC0oHBlNdKUa92K/Ta9Um51l7cpVlNIg3VaSZtUrVhWL2GAwpr1UnDPGDvmgaHu9W5YYaQJd/R699yzx/PfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bidcYRQU1gsKoST20xMV1wt7Ww3RkNqewVjbg0yrmn0=;
 b=V44MaoX0SV1XPzqbO7b/NeJ1dzs2xnv9uyXkvKe+6PTAxiq5xTDuWsTHFxrLhmGlqvzoDuxomSvzb2tyHWajl1UxJ2VXkGje3ivtMh+7bNZMmv1Rz74HJyHhFxglHce53w31v1Bzl/JTx+Q1X0r1HdFwtffiPuo6yj4xjSRd/uU=
Received: from MN0PR03CA0010.namprd03.prod.outlook.com (2603:10b6:208:52f::7)
 by SJ2PR12MB8717.namprd12.prod.outlook.com (2603:10b6:a03:53d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 1 Apr
 2026 14:45:24 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:52f:cafe::b3) by MN0PR03CA0010.outlook.office365.com
 (2603:10b6:208:52f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.31 via Frontend Transport; Wed,
 1 Apr 2026 14:45:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 14:45:24 +0000
Received: from BLRANKISONI.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 09:45:19 -0500
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>,
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>, <jgg@ziepe.ca>
Subject: [PATCH v4 3/3] iommu/amd: Adhere to IVINFO[VASIZE] for address limits
Date: Wed, 1 Apr 2026 14:43:57 +0000
Message-ID: <61a1bbd81b2437ac96e0c26f50e07d136bbfa6ee.1775045213.git.Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1775045213.git.Ankit.Soni@amd.com>
References: <cover.1775045213.git.Ankit.Soni@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|SJ2PR12MB8717:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f1bf036-e3f1-40e2-b0eb-08de8ffd4eb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ocKmWqB+xR/rfCB3489uCX04YSliTmTjdptYLHa8yfkWzGYwe5YRmWJfw0XZQKD1N0bVr7no3Ou3RDwYzlSaMEvFDVJpNHhFTFGC+DkrQP0HdArqED8Lijz1IWqDuxuBp0QOc7l5d7RVv4+U92HrshxXnS5/eY9sIzMCENPJNOTirFKxken0Q8AbJ55eiOUisNoQlwruh/s1TtuCwu5nehPm+zcgno97tDJqTsEFCAlPOtVqwq7NA8o9H6ViMkwXqz6ukvQwvrQUdDm+BI98/McNLNdXttDLdaHFnJFjkNt/9ZJmPtxGXUuv2ImisOR6jxuMKFWnVh56I7HofIjCvyKoHeH8tmbiheD4K9d0KdS2EOMQUjL4QHTdoX7+zvekDBWHmCwn8qLKiruueCecRDborWm2f9K3j3VsJ6Qh7klieVwmmLZb+UB1jIccILzs1G5/P6xSWuerkytoFt3xW9N2EPfGPcGNNR6GdrQUG9OvcUoFjrVxPvkZun2SGHUbLvbEaKcToTfvK2oU9G19MIhXJXarOevszeysQmQ/SS4sb97wlPoNC7TBjv7taraODw5P/4kq8r2748CAsOGJdPtn8622TCWfoTdruC79YR4rMoYXxdS2Bfkc54p/khijBfrdOKYqvogQVaQduQdDbmDObmoVntxqRqRdwaYyB0Crx6VWZ1b4lYbtejhnCib4aPbFwbKFiilQCmTcJ+XEkVDVxLn1ONE3C0dEWP63Nt2gseiaq6uJQ5csovTRM+8888ChHsBMSw9iOJquFjAaqg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	62DVe9geD/i2oWhnc7hJy751iB8neLLUp3VhAUdAuLRjRd9kJWnlmCPE8It+gKDMVTNIAdr0Cwz34C8BN9EurWsmOoKDEh4RF/fTbskNOiAhLOfeMxpWcunMUIlXhA1vUOElH0IcA/Ufltjqd0dRyA7Bi1PTEq7qob0RcVJP2Qzoo4LzBDPIh9AxuVRjoTRgQ+AQFQkTQwTTh7WJIJV21T0no0iN06QC6XPp8V0G42yYzcp/eL1W9BYAnRA0DzLyYvkrSXYWRbx26bo0vd84XMnMgvQTqDO1vfEGn3POH0g5KI7estx3uHKi7yiR+0Hnl64WiIOl3tjqhYx8TvgHFDKqFPP2X23JTH4Ffmmypl8fU84aAkg0Iw6Omf1u8SZd2f8XDPUmd43+tQ99CzfaWWvoiQ8tA942Hmuc9ROOWYRoYro8zAW98xBk5T7WT1Qv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 14:45:24.2643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f1bf036-e3f1-40e2-b0eb-08de8ffd4eb3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8717

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

