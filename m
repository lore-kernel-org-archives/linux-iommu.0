Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010008.outbound.protection.outlook.com [52.101.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD8F4F55AB
	for <iommu@lists.linux.dev>; Mon, 19 Oct 2026 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792415330; cv=fail; b=abWjAmz3S+IiZxgFQqwWz3kGruHofil9oLIARioejrKHY8dd2Tc2fdoUK+YjeKlr3Dp5xcL7HWpU7flQjQbpBpPbzk2XeW4MAXqcnn4GtXQnpo5/GXsGHncHieNxG1JvddYCQB5Y4Y1gb30fg0N1wZ3WeTZK0e1bG3UTf1If4MM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792415330; c=relaxed/simple;
	bh=Di9NLDCBHikRT3enWVpRvZydgdoFVpuTrCBd9uUrXIY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uhfXjGo421sDhUScj2n+oxECfL/NYWJCxYtT2IWiT2MOdfq7uLXhc1pJv4ywx3SOnC7jTZw4qRv8JB50eM+VrQEsLEPjIsW+/3QnJU0JxdOGQQDy9+2to0W0fgsaAG3LlgdXkflut5iUcD0GMdFfBuA5n3hlgy7b+H2Zc5Cb5lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cqgkDfBR; arc=fail smtp.client-ip=52.101.201.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cqgkDfBR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U18IQhX7SvE876Sg/ucjHR/7YDR8RKW9PtdMdltITfaSNbtWEOMKF2LEq8Mu1c3FQxe4sZeeVJlGurUcp+hINRE/zIXtgV7MDnO1++Hc+CvCIEIyS+byAA3UHUQJS1PiQS9A6pedQiQfMXUQD8ZYzBImsuNBFwrwpoY3Uc6v53IB+i0mIrFVxbTdiB64hGz44dFM1WopqNx06M6iPUkQpd94mLweViOjWJJHUw7pqq3u8LiUJHC0WnbHAHqXR32q8LVcDBAy4NC8V40YLpITyJWCpQ1iqv/22WAkVbAFJgJjA//w8jGn/ASnoQHUG0RwIou+1HvYt2CrJS5Cwm/6qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFlpmdbBzUv9s2j2f2lbUP9bgXxGMcl++OXI++ElY2o=;
 b=cDMeKxo1xy++/crhU25573tZYqKssegqtvM9IIhgzABVInCjECR4SOXR+UxWdoUAS7nrxqFLrErQx6a337mKUjab3i679JlxOX9G4ON3oSTFV1XJmZMs+WtrDlKjouQ7w2QhgfrNaZhZgqpB/DfozHcHxAVw1kYR/vgV1V37uCc0ZzsUBfTQwxrDmq9vIA8CEtPOk8gkhnSy5+yvdlCKaVp5Ti/zl7qdv5sFdoXuUshdevuYxUOWDoSxO5s12p3cArconvW4FxPtr6uHPpT31tsV6owWEUkvhGi8AN/UgO+hw59o7w3TmnRbAseslK89jp/KPkgtQFlqGWmDYVN2Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFlpmdbBzUv9s2j2f2lbUP9bgXxGMcl++OXI++ElY2o=;
 b=cqgkDfBRlu/0+lKLuAf9NEfTErcVx+li1xU6RjGy3mo/fwhjRzE0zuUZH2cqTQf7kviTy6++wJxHc/XGxxVa+fZ/Du/ueCJ8vtzTGD1jyOkStYLZbYVCq0R2pH85LKdQYgHtlb+OuvzOEaLkNOGjUQxPyuMJQWVFB3zNyvljtr0=
Received: from BN9PR03CA0987.namprd03.prod.outlook.com (2603:10b6:408:109::32)
 by IA0PR12MB8974.namprd12.prod.outlook.com (2603:10b6:208:488::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Mon, 19 Oct
 2026 13:08:44 +0000
Received: from BN5PEPF0004698A.namprd02.prod.outlook.com
 (2603:10b6:408:109:cafe::a) by BN9PR03CA0987.outlook.office365.com
 (2603:10b6:408:109::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Mon, 19
 Oct 2026 13:08:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN5PEPF0004698A.mail.protection.outlook.com (10.167.245.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 13:08:44 +0000
Received: from BLRANKISONI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 08:08:31 -0500
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>,
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] iommu/amd: Move page-table setup into init_pgtable_params()
Date: Mon, 19 Oct 2026 13:08:01 +0000
Message-ID: <e41769912ec11799e1d4bdd3b892412da5ffb466.1792156095.git.Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792156095.git.Ankit.Soni@amd.com>
References: <cover.1792156095.git.Ankit.Soni@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN5PEPF0004698A:EE_|IA0PR12MB8974:EE_
X-MS-Office365-Filtering-Correlation-Id: 5082d171-6d1e-41d8-92ce-08df2de21a84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|6133799003|18002099003|22082099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	rgmMA3hMikhJ8+6DoLVzYgtIP7jvg6tRq/vzuFBVhHqfxZ+MfZCS+fwf2nqwalWrZwk9fqI84J0ODkayPYFsm8Bbc74ztSKt9eCYMAcBg6ogiqR7jT1FYgPLsb+rtOJv0743Wrkt40fSBXtlqloZfPqhPgfKip99gHWwxdWWraIbuB7oa3YH1kqEICrizp7MncxymG0WXxpFR6QCP/NYMqGcfwRKCliVdnQPlmFngbQM1GC80CfxRZSKR6SKzGKlaIdkttKFctstfCzPBdjlKXVoESSV47kdOkFDpdDqjqfPUDJ5QxM4JAQ2o0L1oetQrlLzZeBI5H2JVLaciL/KMMCz53Kj7fKxjZWucZsyussgJf5P+ZCD7Q31smbZZS81Zfz/hgcdKhO4PAPcrBuw4ob52KbZLGPzwNlg8lzHyVGjzUCbL7gbyKL4aYwvuGOCiRI0Em+olhNdV6TaZZk7jgjKxnUjfjb0RSYF8I+0HpWfjH+NSH+OFM7M6bhdiLOnzYftwcrzHbzhBMC+6QTYIub2RJ0gJx7hXq582Fr4AzhQ/fGzSqhVWKrZ7jV0Ud4PNPmzAcCPIK8PKbAAfNI/Q0bqZ8urQi75ZtpOS3wRDjkmhYv0otofAFGPyO2FrtV1CXLePWZe74k6PudH4bCK2NByve3DfbYe+FzubdMyFxI/0subt1Nqh5qAfwR+KMNpRw91Ze0ZH+axT3NckVY0PQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(6133799003)(18002099003)(22082099003)(10067099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KleYjQpT/rSprOwv0IIQIajO5+xo3ZcvydfS+15rkqZ+OOsPdxNZMS9L76vopDcTg91mkNdsZPh+q18GOhXuxvNt4RNL8WJQlj82/lQddfK02CqX5YogoeFnEM4SoPJfPS5HXTsD1WCn02cBO5gquB6Z5BEsgXJf5qZPG9yMs7LNhb1TSMPVHsUf7zWKIRQo7dt6LJyY4Z/8ix18oP/oea0d3PAxe6hceicjxk8uQywWEl4jJsr3pjs9mnZc3EM7gCQqItqWcw3V/J0GpO4ukw9A5V/uR0qZXOXNKnzoc8miTeDnbedQULAuMfpiApxhbRL3hWryJCBkZzeS94Fzcm2zuMerPEr1c86DZqAYWLaNxe5zfg6kr+uAigfrzp3tTi6Fuwo4yZcfoshElGYbUtmuA8F40333xg7GsgbaaHFd2csVZCh4OcztTIikBRaH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 13:08:44.0204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5082d171-6d1e-41d8-92ce-08df2de21a84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN5PEPF0004698A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8974

early_amd_iommu_init() currently sets guest page-table level, host
address size, and v1/v2 fallback inline after the IVHD walk. That
clutters the function.

Move the page-table setup into a separate function. No functional
change.

Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
---
 drivers/iommu/amd/init.c | 88 +++++++++++++++++++++-------------------
 1 file changed, 47 insertions(+), 41 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index edcc187b8f14..89da993d7d15 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3194,6 +3194,52 @@ static void __init ivinfo_init(void *ivrs)
 	amd_iommu_ivinfo = *((u32 *)(ivrs + IOMMU_IVINFO_OFFSET));
 }
 
+static void __init init_pgtable_params(void)
+{
+	u8 vasize, efr_hats;
+
+	vasize = FIELD_GET(IOMMU_IVINFO_VASIZE, amd_iommu_ivinfo);
+	if (!vasize)
+		vasize = 64;
+
+	/* 5 level guest page table */
+	if (cpu_feature_enabled(X86_FEATURE_LA57) &&
+	    FIELD_GET(FEATURE_GATS, amd_iommu_efr) == GUEST_PGTABLE_5_LEVEL)
+		amd_iommu_gpt_level = PAGE_MODE_5_LEVEL;
+
+	efr_hats = FIELD_GET(FEATURE_HATS, amd_iommu_efr);
+	if (efr_hats != 0x3) {
+		/*
+		 * efr[HATS] bits specify the maximum host translation level
+		 * supported, with LEVEL 4 being initial max level.
+		 */
+		amd_iommu_hpt_vasize = min_t(unsigned int, vasize,
+					 (efr_hats + PAGE_MODE_4_LEVEL - 1) * 9 + 21);
+	} else {
+		pr_warn_once(FW_BUG "Disable host address translation due to invalid translation level (%#x).\n",
+			     efr_hats);
+		amd_iommu_hatdis = true;
+	}
+
+	if (amd_iommu_pgtable == PD_MODE_V2) {
+		if (!amd_iommu_v2_pgtbl_supported()) {
+			pr_warn("Cannot enable v2 page table for DMA-API. Fallback to v1.\n");
+			amd_iommu_pgtable = PD_MODE_V1;
+		}
+	}
+
+	if (amd_iommu_hatdis) {
+		/*
+		 * Host (v1) page table is not available. Attempt to use
+		 * Guest (v2) page table.
+		 */
+		if (amd_iommu_v2_pgtbl_supported())
+			amd_iommu_pgtable = PD_MODE_V2;
+		else
+			amd_iommu_pgtable = PD_MODE_NONE;
+	}
+}
+
 /*
  * This is the hardware init function for AMD IOMMU in the system.
  * This function is called either from amd_iommu_init or from the interrupt
@@ -3226,7 +3272,6 @@ static int __init early_amd_iommu_init(void)
 	struct acpi_table_header *ivrs_base;
 	int ret;
 	acpi_status status;
-	u8 efr_hats, max_vasize;
 
 	if (!amd_iommu_detected)
 		return -ENODEV;
@@ -3256,10 +3301,6 @@ static int __init early_amd_iommu_init(void)
 
 	ivinfo_init(ivrs_base);
 
-	max_vasize = FIELD_GET(IOMMU_IVINFO_VASIZE, amd_iommu_ivinfo);
-	if (!max_vasize)
-		max_vasize = 64;
-
 	amd_iommu_target_ivhd_type = get_highest_supported_ivhd_type(ivrs_base);
 	DUMP_printk("Using IVHD type %#x\n", amd_iommu_target_ivhd_type);
 
@@ -3271,42 +3312,7 @@ static int __init early_amd_iommu_init(void)
 	if (ret)
 		goto out;
 
-	/* 5 level guest page table */
-	if (cpu_feature_enabled(X86_FEATURE_LA57) &&
-	    FIELD_GET(FEATURE_GATS, amd_iommu_efr) == GUEST_PGTABLE_5_LEVEL)
-		amd_iommu_gpt_level = PAGE_MODE_5_LEVEL;
-
-	efr_hats = FIELD_GET(FEATURE_HATS, amd_iommu_efr);
-	if (efr_hats != 0x3) {
-		/*
-		 * efr[HATS] bits specify the maximum host translation level
-		 * supported, with LEVEL 4 being initial max level.
-		 */
-		amd_iommu_hpt_vasize = min_t(unsigned int, max_vasize,
-					 (efr_hats + PAGE_MODE_4_LEVEL - 1) * 9 + 21);
-	} else {
-		pr_warn_once(FW_BUG "Disable host address translation due to invalid translation level (%#x).\n",
-			     efr_hats);
-		amd_iommu_hatdis = true;
-	}
-
-	if (amd_iommu_pgtable == PD_MODE_V2) {
-		if (!amd_iommu_v2_pgtbl_supported()) {
-			pr_warn("Cannot enable v2 page table for DMA-API. Fallback to v1.\n");
-			amd_iommu_pgtable = PD_MODE_V1;
-		}
-	}
-
-	if (amd_iommu_hatdis) {
-		/*
-		 * Host (v1) page table is not available. Attempt to use
-		 * Guest (v2) page table.
-		 */
-		if (amd_iommu_v2_pgtbl_supported())
-			amd_iommu_pgtable = PD_MODE_V2;
-		else
-			amd_iommu_pgtable = PD_MODE_NONE;
-	}
+	init_pgtable_params();
 
 	/* Disable any previously enabled IOMMUs */
 	if (!is_kdump_kernel() || amd_iommu_disabled)
-- 
2.43.0

