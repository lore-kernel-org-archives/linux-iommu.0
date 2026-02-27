Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010003.outbound.protection.outlook.com [40.93.198.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF0D33A71C
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 16:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772211521; cv=fail; b=Zgxt3XRJBwfnCdqp1rzOO9dk1nnPD8Y4NWgTgnj2GAKYJHNJcQjlCCY01tpMd3Yw4nSaEBH+29q0evXzuqLRmAR/++pIahvYO6r9O6esA7XRrZLOT0fZyhRnIfOUdVBxZphCYm1y+DAOPCaU/yCDozQsy/6GyUb5tRN5BGswby0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772211521; c=relaxed/simple;
	bh=G0rY8Lj6K2onj8CK46VyRZsfKw7keSrPh0sNyx/19Is=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ocVQEN7eyTbjleO2tXDrvvLXd+HA4o7jXcHkjw/X0EzV84KXcPOtSMep3drrhK3GItnuGziS6qEkgcoMrhkd7hl8uL+IRneopDSjikWNx+bVIUMrKb8CREZPeh2VF/44i3BMWP3eAvQl+37u3PF01ERwRwAD6yhDSk/AJenp4UI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zoqWdnzS; arc=fail smtp.client-ip=40.93.198.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zoqWdnzS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZDM5MxGScdQbH5bhQwbFN+S00nQmMzjv+qHBPuzsNRjpGLU2T13kvv71stEmeo7IxLRt7Srn3dHHuIWSZw/yWRJCz4PeVod9UN2ISw6h4P3+1exi8iY+7c+OuN1is1m4zfeVsDmBOWc+D1DJgtfVXhEwEYbKUNevfUo1FzGRPB7+a77MkAOxVi6hXNy8VlWoZox37zec+HiXMRhO5CA7VeLnmOSUMMqAckNeve2NIZWqmFHlXq/6e6QOBt68a9876qAuUlIrzNcaRewOOrj7C/LCiKPMR0iL+kwG2kZK0lFrtVGTUS/TW2bZYfiSTs+/4eYOEGjjV8dtNDuJo6YHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOfWdkoi5hqEGbeTksQzJeLurDKYl9OYEUU33tIqRUs=;
 b=WhTVHO+K4WmXObuZgDgXHVCrVLsOMyO3/TikVcpi7c2q4uFeiEsbeE1lsLGSwGnlSAb52XX3wY8Y3R3UXLf4+KkhUZzBoJ66HOLkYelhfD1/BVe1sgkFfYyIrfu057AKrek3tPS3p6sVdbutLkmQqBto0LMoHzVCTfooe7KZr1HhJyIa6kbjpy1AG6A++VpE6ibAwziwc9qT6rQxLHo+Ja0/Edn/qN0WJ1IaAwR/aP8tvC32eD8m+IwIYZutr1QpeDhgN01h9TbzCFSmuh2+UXIaI85i/ASS7PflXO38HitBtpjqmlf1xWy3ICZ0p9W/QdWe6srWFZmdtAXiK2JUxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOfWdkoi5hqEGbeTksQzJeLurDKYl9OYEUU33tIqRUs=;
 b=zoqWdnzS0UvWJk+huv9fYhf2TZLGW5oebR1O6Qu+0gZShM+/ZTeGD84Tpr408sdl6j/AxIP503GvNy6OZ0iA8mvclI1YIs8M/+tb+zjA3Vc+A98c4LtChVo61CK+w1wEliNdjlXESBe0fS7meHWjPO3j08wnCQuJPsZ1OM0QdHE=
Received: from BY5PR17CA0059.namprd17.prod.outlook.com (2603:10b6:a03:167::36)
 by SA5PPFCB4F033D6.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 16:58:23 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:167:cafe::f0) by BY5PR17CA0059.outlook.office365.com
 (2603:10b6:a03:167::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Fri,
 27 Feb 2026 16:58:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 16:58:23 +0000
Received: from BLRANKISONI.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Feb
 2026 10:58:19 -0600
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>,
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] iommu/amd: Adhere to IVINFO[VASIZE] for address limits
Date: Fri, 27 Feb 2026 16:58:04 +0000
Message-ID: <cf1a1e3d96c3571ac5caa528caa84751d40be1bc.1772208939.git.Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|SA5PPFCB4F033D6:EE_
X-MS-Office365-Filtering-Correlation-Id: aa58f8d5-b736-4da7-270d-08de76216b2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	TpW5Fk44g329oKt0kgBsyZhAx4dmxpc8nQuOF2ra1qpL6kFF3Dhe2dZhrzvXHhproCWm3QJnc+w4By4mVCwHwpcLehUoiBZpjYuLi8zXn8nHSCc55dCbKveZ8E6TKSdp2RKaQjzApczo9K6F7NehBBf2nwW37wpnOxEM40JVhRS/k++4q9n0o0ur21dSZ1cF08biV6kbY4E20hNIhyn/ICuvLY4gn09QAzTj90QSfiq+DVruwq8NH303wJxbfx+dGl6pSbuQIlaL7Vizxw2BYNnukMIy4ZqCoD9/7wFQMkFAe3CaaUqLAHVGGWXXKbtMM8MwSz4XcxH6Boed263FHFBezps8Ydb0EdKPi8E8b8RyfswKM/ijfJg0AUJxt/wyZ/VJBCD9l7Dx6nnxBznAUq0pre6OTWZlCSdSxBU5Jpa9HN/SKUTLNoD0b9qN2KbJCWyiCZh6073LnyWbP0vsaip++/XqJjyPFNU9OgPV3ZfKR7b+ZW30dfCV0+6aj91JCmqvehfAMc1emPcVKmykanhns7iehAR2KCaD8yW7iXjH3HU5h8mtqMbvEG0jRtmAykbOAcjiislxiNIY1mTMTw2iQ9u+Wx3Rn3jt0TVUopWL6meqg0iKEY15xLJRXsAcP1jmDluHlzK3cTyuQF7gWUpW0VOVkoJ+Y+OxParsTri5ZDKYlbYJgqX+tQjhVZ3Kz6X72MhunTzvFW9wTWQ+3Ng1gO7ZEtbyvT+sfz80+Rb0MuDP3KGJvLs2Pg2Fu9k/6XhAgT7ozkIu93YEGXPhK6b6WfszTPGj2BUoC2rMSovIcj2ET+ZVf2y/Klw4OD6Y
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GKSyb+6pVsHM17JjSFaooR8V9Lc3fHoc4uegVcoIuwJjGovLMLaYFzP4rcm1oTBCFVR/eidBIkb3rm33K8Iu46tU1zhId3O2VHz3PEiKuxKg9cyu8AdStF7ugP8bbRqLFZ2T5ccAQQT3tlSTvFo2Gs/zNw1Z1w0KwA1Pe2jBcI6quwPlZPtDBwgTfWSNpBlcWKcMo7BKh7VGq0Den/pMGohk06bLUcU70t4qwv6wcN3z2EYDzgkIi4onzS3XAzv4rgocekBVy/fze07GG2dxqHhyy1IzjTjfXb2X9Iix0eJe1rudOJPfBosU87Z+mrsdcxVMANfYr29AZFgsdsf9o4pLqkj1ztWXcgl8mYaRaCB74iRd0FFDvJt4ak4dDmt+2xcqEyjuSixua8H1FGx/GvHGb8rhyMxPBcqQyhjPrBqUaFogNdeqnheUUXVA2JeK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 16:58:23.6441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa58f8d5-b736-4da7-270d-08de76216b2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFCB4F033D6

ACPI IVRS IVHD’s IVINFO field reports the maximum virtual address
size (VASIZE) supported by the IOMMU. The AMD IOMMU driver currently
caps this with pagetable level reported by EFR[HATS] when configuring
paging domains (hw_max_vasz_lg2). On systems where firmware or VM
advertises smaller or different limits, the driver may over-advertise
capabilities and create domains outside the hardware’s actual bounds.

Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  2 +-
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/init.c            | 34 +++++++++++++++++++++++++----
 drivers/iommu/amd/iommu.c           |  3 +--
 4 files changed, 33 insertions(+), 7 deletions(-)

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
index f3fd7f39efb4..03013189b983 100644
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
 
@@ -3156,6 +3156,29 @@ static void __init ivinfo_init(void *ivrs)
 	amd_iommu_ivinfo = *((u32 *)(ivrs + IOMMU_IVINFO_OFFSET));
 }
 
+static u8 ivinfo_vasize_bits(void)
+{
+	u8 vasize;
+
+	vasize = FIELD_GET(IOMMU_IVINFO_VASIZE, amd_iommu_ivinfo);
+
+	/*
+	 * IVINFO[VASIZE] encodes the log2 of the maximum virtual address
+	 * processed by the IOMMU.
+	 */
+	switch (vasize) {
+	case 32:
+	case 40:
+	case 48:
+	case 64:
+		return vasize;
+	default:
+		pr_warn_once("IVRS: IVINFO[VASIZE]=0x%x is invalid, defaulting to 64‑bit VA\n",
+			     vasize);
+		return 64;
+	}
+}
+
 /*
  * This is the hardware init function for AMD IOMMU in the system.
  * This function is called either from amd_iommu_init or from the interrupt
@@ -3188,7 +3211,7 @@ static int __init early_amd_iommu_init(void)
 	struct acpi_table_header *ivrs_base;
 	int ret;
 	acpi_status status;
-	u8 efr_hats;
+	u8 efr_hats, max_vasize;
 
 	if (!amd_iommu_detected)
 		return -ENODEV;
@@ -3218,6 +3241,8 @@ static int __init early_amd_iommu_init(void)
 
 	ivinfo_init(ivrs_base);
 
+	max_vasize = ivinfo_vasize_bits();
+
 	amd_iommu_target_ivhd_type = get_highest_supported_ivhd_type(ivrs_base);
 	DUMP_printk("Using IVHD type %#x\n", amd_iommu_target_ivhd_type);
 
@@ -3240,7 +3265,8 @@ static int __init early_amd_iommu_init(void)
 		 * efr[HATS] bits specify the maximum host translation level
 		 * supported, with LEVEL 4 being initial max level.
 		 */
-		amd_iommu_hpt_level = efr_hats + PAGE_MODE_4_LEVEL;
+		amd_iommu_hpt_vasize = min(max_vasize,
+					   (efr_hats + PAGE_MODE_4_LEVEL - 1) * 9 + 21);
 	} else {
 		pr_warn_once(FW_BUG "Disable host address translation due to invalid translation level (%#x).\n",
 			     efr_hats);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 81c4d7733872..e8d15ac9b2bd 100644
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

