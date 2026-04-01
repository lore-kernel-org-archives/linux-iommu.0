Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012046.outbound.protection.outlook.com [40.93.195.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FDF4534BB
	for <iommu@lists.linux.dev>; Wed,  1 Apr 2026 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054692; cv=fail; b=lj4CnBvBVKhXHwASpUvwbNL8JfUo/pw6ixNY+4VW2ezISJ+rVhbLwj/fI+oUO3O4ZPJO6fr61ERAArMIhWWtFrH2Mhld7r6SYDEyTKNRQKardeEIDu7wF+Hb8tu0HeQYxqMR7sKaUrHVmsEB9aZKDEqHJbQhSrvUs1HuZS//ZqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054692; c=relaxed/simple;
	bh=iXc7FVXWXRKnpPpbffl9xKW6hT2jetr/ar17IHjO6hc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pCDezyY6ajR+piSIASMRN/r/CFs6Wuj0TqAOR+3NBflu7fSOR2Dee39T5ENA5iQuzr8SrplCi+KFR/TM6rCynjukij8eQ8gTz7ngeYAn9irG9fV26L2wY/Iyge8rkEqCNU5fymepUiNbByCjEoOHyqz4lXvn49pThP/4zBuI2ZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hJlcN19F; arc=fail smtp.client-ip=40.93.195.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hJlcN19F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=By25Cf3M6oKqjhH9hdxUviZgm5A1jPtMofYW29w5QkOsuv3G8R2TWM8cn6ZGiTJ+vNpp4kzQyLtbU/3EbpoycjqJaFsjABg3EHYCnsfOXeMDkHMZku7NzefXhfffiXhHyt7yZIoxKlqz6Hb9ZIC7VukKUjrrSH/yi6VXTBTN0ItkYQBqIEojyC6KimbmdOZwHoEPnAxALsDj4vfzWFW1dQAdjpsQ1sX9a1veY4/+dzDsiPxd6/dXdB445qiqIIMzppBy6JSIoNHUY0AD7WH5G3fis0njKDZ588nuPIdzU+jzKgT1bY681zmqgg7/vhuwrTWK9ikhhst56aBnAPUHAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Mi0Cu9/v4ZkvEpVxYTCGQ+TC3HaTjJmd2Cm2oRpe1E=;
 b=c+lLlj15ZdUhOr16tUdxt9Ldn2wT/L7lqn5DdIV9DJH4PoYzF1pG9Q8WqYvi2TWcTam3zYOluCcXtDu14L9p/KErxcQdRBfPZm3gpOp1h55ud0BgNmMa9S1QMtFIWScIIsCm1KtjAE0y0Vvlp7bP2Qp82cNGHzrGHbyUvtoGXxj/acvThkVZF0p9KSqGFGBgmQv2DPKVT2h+RIup3THAbef+evQTDdcWk4bjVWgWtJEUsv16tU0/41jvFNAuFPoJ00IUWk+OrAkCZbGTA6ogJm8tQzkY18jqAUYgwxM6JXS/ESdinJLxWeddS3HpUHXHDri9v01pRr70UctwC30utg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Mi0Cu9/v4ZkvEpVxYTCGQ+TC3HaTjJmd2Cm2oRpe1E=;
 b=hJlcN19FadqWyjldxEGrTF6SSadwRcpDHbz4o6DdckWZBI4c4lpccR3lHOUeNJayMq0TwQd5uyleiTfpvZ0s76yzxu4//ySMefaki/XpX4bgvodhtthNDlmLIDZrD25XVlq5Hx1t/Xb73Mf2RKY2Z3fq7ssTam15E3Tqt5NzK84=
Received: from MN2PR16CA0062.namprd16.prod.outlook.com (2603:10b6:208:234::31)
 by PH7PR12MB6882.namprd12.prod.outlook.com (2603:10b6:510:1b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 14:44:47 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:234:cafe::47) by MN2PR16CA0062.outlook.office365.com
 (2603:10b6:208:234::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 14:44:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 14:44:45 +0000
Received: from BLRANKISONI.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 09:44:41 -0500
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>,
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>, <jgg@ziepe.ca>
Subject: [PATCH v4 1/3] iommu_pt: support small VA for AMDv1
Date: Wed, 1 Apr 2026 14:43:55 +0000
Message-ID: <62cb55fdc5e08dceeb6d740cb73f75c6bce36226.1775045213.git.Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1775045213.git.Ankit.Soni@amd.com>
References: <cover.1775045213.git.Ankit.Soni@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|PH7PR12MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ec7f486-486f-4deb-249d-08de8ffd37c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	h4XP+K5/BTDIIhNhxs7+8MlmlR9QtQewe7abf/uHPw8i/MssT/FyIHtMUt2Det14E7Vm5SLFHtEWrVTAWJJXwN6OzkqPLq9mJeebrtA+FHYFdvIztl1G93zxbpHapN8zzKWzok2yS4co/GDogpXxsivufScJMD7etNi6XHwY7Supw0NLFDac7WUl1gJdHfXHw3fjMjGPm9ry84l95oNk1TS3kAGaXAwtXZ64NZRvvqK8H2jyCYD+0Os8O0v4CbXIBpcCKmNd0HGy+eOXBqKbgAezP8U7HLDAphp2KIiJGKxXZYu1gBWGBAtkLGFhKkoBGI6gTDNya24cBvpI0AQOr98Ib3mGngjjfEC/m2CAvOOhhmmq52a/S9h8CtjA5qHUP8GwEOdqOq74H8eB01+32sMHysB+jTqn1GxRCeqKWxj562rY3SVNMDt918yPGZ+86CbRvWZz5oNd+YTcOj4CVkHG3n3FF3/vm58spJhhyIE9IN3XRRj+Hk99y8zHNVv7/ZWuD0/sOdmtclucCzA1h8FQ5Cj9QyTIwRMIKHfijMkWeS+5jz/JjHSXBSkRGDJP9F4gkDftQHvGEbG2TgYPWDFNyNdYFgB5oaAtEKLEhR8X/pWc3LswM2th3TThDHCRdT1hUOchAAiLmwhW2q/IiKRVtIczjNHUTRhd4WYK3y1s3WqZxYkjEHmLja2+vl6J55Jj3dLRIaXl6YHdca6HMVlJH+CngYzVw8nhqShpoYTDE0WWW42w3Hd1pSQVrnxVTzCqD0peT0pbjmYEyEZdVw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DwXUCDR4TvYfFH/rszM4IBjcS6ktC6B1yM9v1lvDC5MP2FP+ayC2O7j4kC3XwdNCZJLz0uW6mhV+0X9pxYwsmJ3sfweOl2sEfr/px0sYflHnhUKCXW/HPhVD4F2WVsAal8NMwlsXAzcFbjnLt9H98WNo0PaMuT5a/dK1eO8BhZMb2ZqUncwiuzomeHDjzLxjOy6iHMtLJW6reNVO3f1C07U7Tno7rwWUGUplLKepZzxTeVIVRoY/pH4SKS200rHN/YPdMxKCpQChwJnF1enUV4kybitWg1KWWKeHVOhu4BwhBl9UICTzhCEGSXA7Yw31I/NVBipw0ehEJDaflyLVw/TjzVLlkeF9qcmmZOMBmCn4dyyGmpx29HnN52pnlnPwpw9BmO85Rqomwsoncf9gS9cZ+8kObJ+oAJ7qVAYw7ClZHOiZYVTLpwXy4EHl3pG8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 14:44:45.8099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec7f486-486f-4deb-249d-08de8ffd37c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6882

When hardware/VM request a small VA limit, the generic page table code
clears PT_FEAT_DYNAMIC_TOP. This later causes domain initialization to 
fail with -EOPNOTSUPP.
To properly enforce the domain VA limit, clamp amdv1pt_possible_sizes
using the requested max_vasz_lg2.

Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
---
 drivers/iommu/generic_pt/fmt/amdv1.h | 4 +++-
 drivers/iommu/generic_pt/iommu_pt.h  | 4 ----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/generic_pt/fmt/amdv1.h b/drivers/iommu/generic_pt/fmt/amdv1.h
index 3b2c41d9654d..bc04d482c12f 100644
--- a/drivers/iommu/generic_pt/fmt/amdv1.h
+++ b/drivers/iommu/generic_pt/fmt/amdv1.h
@@ -156,6 +156,7 @@ static inline unsigned int amdv1pt_num_items_lg2(const struct pt_state *pts)
 static inline pt_vaddr_t amdv1pt_possible_sizes(const struct pt_state *pts)
 {
 	unsigned int isz_lg2 = pt_table_item_lg2sz(pts);
+	pt_vaddr_t raw;
 
 	if (!amdv1pt_can_have_leaf(pts))
 		return 0;
@@ -168,8 +169,9 @@ static inline pt_vaddr_t amdv1pt_possible_sizes(const struct pt_state *pts)
 	 * 512GB Pages are not supported due to a hardware bug.
 	 * Otherwise every power of two size is supported.
 	 */
-	return GENMASK_ULL(min(51, isz_lg2 + amdv1pt_num_items_lg2(pts) - 1),
+	raw = GENMASK_ULL(min(51, isz_lg2 + amdv1pt_num_items_lg2(pts) - 1),
 			   isz_lg2) & ~SZ_512G;
+	return fvalog2_mod(raw, pts->range->common->max_vasz_lg2);
 }
 #define pt_possible_sizes amdv1pt_possible_sizes
 
diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index 3e33fe64feab..a3dc5cf14aeb 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -1125,10 +1125,6 @@ static int pt_init_common(struct pt_common *common)
 	if (PT_WARN_ON(top_range.top_level > PT_MAX_TOP_LEVEL))
 		return -EINVAL;
 
-	if (top_range.top_level == PT_MAX_TOP_LEVEL ||
-	    common->max_vasz_lg2 == top_range.max_vasz_lg2)
-		common->features &= ~BIT(PT_FEAT_DYNAMIC_TOP);
-
 	if (top_range.max_vasz_lg2 == PT_VADDR_MAX_LG2)
 		common->features |= BIT(PT_FEAT_FULL_VA);
 
-- 
2.43.0

