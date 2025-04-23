Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2069.outbound.protection.outlook.com [40.107.101.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253BD274FED
	for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 06:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745391062; cv=fail; b=enh+aaP2VWpVtgGBnSl7OmwfvuDK2pY7U03miChTjDqYRjZCGwziiiViL+FishWEo00mWv387Hu3OTWevuly0VUGdviVwAidWjkhHdguIofgZqx0KEibs7mG4fKbacAlFCbD4Orn8KceuRnPwOEhqkNhptpLTDgWRHEuEoeLtgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745391062; c=relaxed/simple;
	bh=CGXF527jwST44nhOoAZmnIgYp+YjbqbrkPBOCQV5BUw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p5l0M7D7ocyfDTmWJl1UcAnFHycOYgyN2imDSbj1Tu6tW7TVHL4hbk5OFte0oZYWl5YoSwiqiUKx6FxJCUqUVExKomeDSTIgaOkyuLQaLy3JE9hMOSpj8PyWDDTf4nghqvOyHP2VNtcnuF0XjZ358B/6qNrUV225RVrOdcr7S2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o79OWXYz; arc=fail smtp.client-ip=40.107.101.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o79OWXYz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2N/sZTadGzw8DWVa00pr8T3MD50IowZwM+P5J/BqyLsKWn0RMbTxk6ti8bk3Yec30thS10k8eE+sGiZoiNVHc/aoxe2/AJGLvBZYDhKbWOjiaXQv9vVZvPnri+nhzzuReSVneVTBdr9QF0VCWInKKv8FovW7bsF7jIrDsxP/mwkCZlt/bMTGpz1or8bbtAXzzeKnBO6Yy0sKCZCzkOzNYd5JtLaqFZ68N9VY/iasFghK0ezeSxGyoQNPqSCZHvp7uNxE7QiKD6yYTnq0TZoIo9cH1Ed029VrhoEn19zU6hyCqjNK5tATM0gZhq0Nkzkv2xVVviqHQvpTDDRGAPt6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2j7sgfxE4Vpm+CvqSYWdOPuu+4/vjhj8dCllilcVfk=;
 b=YJ0grSxTG2U8SDh5fTBoz2Aoy7ZVvsX5YNNiwnzfpHSWJaxIOoaMedq8+MsTyJ4SP19lIzBkLl4IaLLgyPgHNPEoJkkUjDZcvwMlaItzHvUSuIvuX/wQnjjihQX0u+ZuE3kOwB+xwlcH88iz+9GtbCJj7+NZx420OXPZ6oLEgu5pgjnFMB/8hT3qFA/5KsT/oxzsk9w7K0mwrRYG9505O09xcN+MF1C5t6vRP0OrGz6zhHNvmIrOW96ENTvXicL94SUnphHTWdqNbhhxRtdjCDXln5yVoTFsPuXj3CqygTGTLAOe6j17H0OqlcwJot920MRoiaq16vXDM3rRpKZehg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2j7sgfxE4Vpm+CvqSYWdOPuu+4/vjhj8dCllilcVfk=;
 b=o79OWXYz3UMg/OLgK0YNd3ayleinbvO6SVlDgwNZzPALiZHphdItGKBH/eWZUukEKCR56Xsq5qqqrCClVSjBqlKH5BccfNZWfZj+p2ktGoiedY6jL3abML4DcWQSnjF0JBtTW+jU1WxHhomzELUV3lgoANU2+Ko4rOGKD04IOug=
Received: from CH2PR18CA0002.namprd18.prod.outlook.com (2603:10b6:610:4f::12)
 by IA0PPF84D37DD5C.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.34; Wed, 23 Apr
 2025 06:50:55 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::ec) by CH2PR18CA0002.outlook.office365.com
 (2603:10b6:610:4f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Wed,
 23 Apr 2025 06:50:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 06:50:55 +0000
Received: from BLRANKISONI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Apr
 2025 01:50:51 -0500
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>
CC: <suravee.suthikulpanit@amd.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] iommu/amd: Add efr[HATS] max v1 page table level
Date: Wed, 23 Apr 2025 06:50:03 +0000
Message-ID: <e11bcff900090636a547f03c77baeb35b43234f7.1745389415.git.Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745389415.git.Ankit.Soni@amd.com>
References: <cover.1745389415.git.Ankit.Soni@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|IA0PPF84D37DD5C:EE_
X-MS-Office365-Filtering-Correlation-Id: e133491d-c662-4316-cfb3-08dd82333231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4vrQmtSCwvaZlMU91kIofwqI7IglXf7rNuJodAMoxWLxCUD7VCFgkmt+fWk0?=
 =?us-ascii?Q?0GobyolvoLUBBPmbatO+/6ZeL5pIP8JALUXyCoaybO43B5fEFGceI1xT/Z3m?=
 =?us-ascii?Q?WQxFMvC0eACkxL/E+61ttyULnGCu31PNjB2yGff6/+jnhRz96U/7R5gf9hmw?=
 =?us-ascii?Q?wcSIp+Gl7R4+9m0CiD5SfcSr2R02IpYXopOGhO3ZjQL89Ic4spZXGS/E49Ab?=
 =?us-ascii?Q?7gg5dkE8FsQtxJ/uOphfIplQBO4//0Q7NjYjsLPiMASWCy3jbbXHrArSCeTH?=
 =?us-ascii?Q?tRquY6nZ9uJhWOV4nL58BpiYGndUltDRKry2ccVsMHmkL7e/Q72ALewwqKUM?=
 =?us-ascii?Q?ADY0yyX1uIo5rpLBsmmutyAJryK4+C/Lj7VWlgmAYylvePnkPtlFj4+Pcipi?=
 =?us-ascii?Q?B9H9siVgBWIMszeB5JvoKb6gdAg9XcKsNxF0GbRnRQUN5E3c17HMy4PO+Edi?=
 =?us-ascii?Q?Wm4aXnGvRSzN44xCsBIYELRVIjMc8CNVYnyKnL6XKe4y/0S5TWr7tjlPn82j?=
 =?us-ascii?Q?ilvwxIPjIKY4Warrbu8PycHFMVje5A20+snuayo8p+mjbfHeSrS5QSNBtcB3?=
 =?us-ascii?Q?kr85N1JjJ6eslOT1lKhBZBdl1SR7+nR9SsSqHKzpZBwrQWTY/+aOtmqIs+il?=
 =?us-ascii?Q?u7Pv+HX+KfgiT4UyhEiX+LiwfH+oRX2SnSJ01ucIRZ+j6uJ7MCZPlwcx5Tgi?=
 =?us-ascii?Q?hNO8w/UKmWpuCSE91HwmzT+H71PkLFmakyvsKplxMeztRmxR2f643XEstSZS?=
 =?us-ascii?Q?ShmvDIL7AkPtkiPzzbxHaLmLnj2mYN9KUSRislx0Gn68G2Q0f3PKipyAv5eW?=
 =?us-ascii?Q?iy1L/DIuGbiO5EC1g4oA96TgoNLbuxZ4ccOaToPwb7H0Zi/obQcLW9ama0p0?=
 =?us-ascii?Q?erPbKXjLkRKdJ7lIZlq39IlkkVnBNg1qnHjy4A4NG85ZuVecdr32Nqaswtgd?=
 =?us-ascii?Q?io5QFduYhJ3+zB4+PYT8Ad7xjU8KXctxNTtuSAK7/yfJBclNlNEdDsONlYCa?=
 =?us-ascii?Q?RMBEKO4od5hlNPFONnF440Dryg+VLmSM++JlCK+jsW6QdHVlno4ReymZ6sQU?=
 =?us-ascii?Q?H72YGoe67wqubBDaBvOfPFsyiYSwbPyR7DyPMf//jOpPSV2bBOu6op44KWMF?=
 =?us-ascii?Q?B3wGslj2ZzU/ENbVmuUlwnRwOxS8A8QEnYw85dKRo7Rew8WTXntt6mjWGHJ6?=
 =?us-ascii?Q?R4Cfj7DQfuMV60sFDAUiZjZdKM9RsBgz5Tb2OcFfXgsXsbnG1PqC8yEEG7EF?=
 =?us-ascii?Q?JwTmY9QcC9FXyLt4K1NeStAtvYp3QmWoZj5uQSIstVYEOoJrb2JHC1n6sJAc?=
 =?us-ascii?Q?6zXvmMFGgnumILBUinTFAShSMCc8CO+EAYHTxdV8iouVisHwseyNtnxr3L8N?=
 =?us-ascii?Q?itkGUBAqguCec/zWdaf1Ovb6AnMbpRWIKn3IZS+tWMurXzg8YktKPvWM7h15?=
 =?us-ascii?Q?uG/AWWKYYEPiDc1wiPMilh111UUf8AP6I1q5zM2EV9JB+yUk4UZjKiQIp8Vo?=
 =?us-ascii?Q?E6EafVZNO/gyzI5ryAg0WchcM4N5YJr8oqqk?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 06:50:55.2609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e133491d-c662-4316-cfb3-08dd82333231
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF84D37DD5C

The EFR[HATS] bits indicate maximum host translation level supported by
IOMMU. Adding support to set the maximum host page table level as indicated
by EFR[HATS]. If the HATS=11b (reserved), the driver will attempt to use
guest page table for DMA API.

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
index f71b236c2af2..c713756fa44e 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -152,6 +152,8 @@ bool amd_iommu_dump;
 bool amd_iommu_irq_remap __read_mostly;
 
 enum protection_domain_mode amd_iommu_pgtable = PD_MODE_NONE;
+/* Host page table level */
+u8 amd_iommu_hpt_level;
 /* Guest page table level */
 int amd_iommu_gpt_level = PAGE_MODE_4_LEVEL;
 
@@ -3052,6 +3054,7 @@ static int __init early_amd_iommu_init(void)
 	struct acpi_table_header *ivrs_base;
 	int ret;
 	acpi_status status;
+	u8 efr_hats;
 
 	if (!amd_iommu_detected)
 		return -ENODEV;
@@ -3096,6 +3099,19 @@ static int __init early_amd_iommu_init(void)
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
+		pr_warn_once("Disable host address translation due to invalid max level (%#x).\n",
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
index 0ebc264726da..a2f957ee9110 100644
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

