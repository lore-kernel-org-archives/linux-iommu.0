Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7116285283
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 22:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723846655; cv=fail; b=tGi4NPIPuxLe312Q0e3S6EhGPnYGznxlwx8ymbo7h7fjdBjY5w1IJnRKW8ddyPdrUZO/PwRlbnN6NZ/r4hBGSc+cVeHNHFB1AMEDrofgncr2QtUI7R238k2J0gdOR6gteDEi4W3Ypm9kIysX8r2YdmJ199pI96ZZAyvZEoBkEM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723846655; c=relaxed/simple;
	bh=3C66i7STm38DyRFh8X7fMmvUFal1LeKC7kccde5HolQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sqLGzVibyMsmTbC3DjW9fFuFeOrO9c4ocqf3mgG4EyP88MDDURRfBOXYuklkT2OZdAUDy1+dVBo7BWlBpgVy4zMQFubwYKRk39ahrX6VKBwHlOYfwzZhDH44bQkIOCw5eKU3w3YgtmUWGg4BHpxGG4vkfUUGXzRHJ75dr4dfTW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s0q0TyEL; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s0q0TyEL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RyUZhv6J2I65c0L5K3fZk1LVZPuasHBVtr8fdoT+149EHnRWLJJo0R5rJ5gTyVeqxhwXhqg3VcdU6e0DiKP+wI/fApqkOUW+qTdQRbJRd01XxG1RAurWybdnGGpV5hiM+zoXEg8kXOYdEOyb9PdHqsnFsz8T+AOKoQD/T3KNGAFYS/ugULRN17ai/a9+7CjMkg4MtCwGpoMyLxvw0wHe5sfWXEa/0F8k2Rii9Vmdpam5U/EzV2ZJo1hxh31RqkSfKzsjEDQXKYi2rrE9PC0vL5VqHRP7UswDRnUMYiy6w5Yb/tvx+QUcAvxkWqNSckAaItz8dxwDAFINKAA9WanxWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enpq0OzrfY8LXs6+M2a6YNn7bVQ4UBUCfN4O8w6QFpA=;
 b=Hng8/X/ddeyngP1Ca4j/6dYdX0L1VgE9UyEJ2VX1647VNMbij5+ChPDkXu5hwpW3UMt9idbEVJyimidz5+Hlpsqi2QUU05EC0I29G7O8J8rVlblEjq9qdhJOaGJ4dcVOs8OI4MVoQVQaz4CbWW5VJJ4Q/kloxf3eJWZq/P53wtRRzJGN5yBCf4beq5VgKFDegLypPOkBuO+kq5Y8EkwYQ3nRIqHgYLwbBZ0Zu+Iu5PaKzoDH3yS2iqrrJQFcCTuGdVWxz91i55D5nqJUBLejHv1NMlTZjEfvXWKzH+15Pk60wFNL2tTF26KtLKQbExxZVLQXKCF5ScGXnD8a+X4qvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enpq0OzrfY8LXs6+M2a6YNn7bVQ4UBUCfN4O8w6QFpA=;
 b=s0q0TyELbKgFyqG9gU+sVtm4C6tKJBo5y3/h8SALFiPgdEdiSYgd8gFcVS3Gp0Q83zGgLW+84obUlnU0bFPbibp0tdvDPPXpIBWLqFKRJylbbp0dFVTFa6kwyB/uCiM9W/1KNAUDFnp0DIGcbtkWKEXT292VFpvDuSHAkI3HErg=
Received: from DS7PR03CA0330.namprd03.prod.outlook.com (2603:10b6:8:2b::22) by
 CY5PR12MB6370.namprd12.prod.outlook.com (2603:10b6:930:20::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.19; Fri, 16 Aug 2024 22:17:29 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:8:2b:cafe::e2) by DS7PR03CA0330.outlook.office365.com
 (2603:10b6:8:2b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20 via Frontend
 Transport; Fri, 16 Aug 2024 22:17:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 22:17:28 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Aug
 2024 17:17:25 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jon.grimm@amd.com>, <santosh.shukla@amd.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH V2] iommu/amd: Update PASID, GATS, GLX, SNPAVICSUP feature related macros
Date: Fri, 16 Aug 2024 22:16:50 +0000
Message-ID: <20240816221650.62295-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|CY5PR12MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: d78f8baa-fe20-42d3-e6fe-08dcbe413753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6SdnHPF6j0Km6tFXIqV+/7hjvhlb8TsJuq6B2scy0IlJipQYnblCPvfakwlb?=
 =?us-ascii?Q?dZF24OZdQ9gvO0ZXcC9A4WdqbhXk2Xbqus6sLTaqcQrdORCnj/d+ogDEZ/wt?=
 =?us-ascii?Q?r/L+nBk6BNJgPf5sUUXd2XMWmV7uvrwoFnZo5oBvIbnKX8lRIMp+hdccoNz8?=
 =?us-ascii?Q?J6JxIuXdvWigB9dHe0VMUpN3gqPyYKFg8FBv4XOZLmK72G6ZHidQfnWguZoB?=
 =?us-ascii?Q?ukboJ/6LhbJZv552mqjOr7CYmrC6yCN1d5fLlbvmUxGsvXxvVcc4fNjmmrJG?=
 =?us-ascii?Q?72RdN3/09quipiDFt8Snq0hMCVeELb4WDH+O9iIv2FvC0/WHQ/wk/EdPt9Qk?=
 =?us-ascii?Q?H9K3Ln+nQ0n2ka03aQqhBHtu2ClPpts/UHVFw5hHiD9opI3mdGNnlHogsjpD?=
 =?us-ascii?Q?vmdHOhe37C9mH1rG+0UjFZfMrtsMvetzL42Ru4JQIALBbsIC9TcQ5WgfFgoN?=
 =?us-ascii?Q?cdGrltMIZUvrBx7p75vbFN2M+Nfd1+Pw/CFjvRT5bORkRBlgQgiJycmKLqqN?=
 =?us-ascii?Q?nZFMRCbzNs+r2fLY9Zj7tCshAShxynL7+vt8uXARnjDRqGqG5SSi0ZVYInBl?=
 =?us-ascii?Q?fO6oss9zVBS5kpsy3/wmiJdyDgdeAJErOuIf+SRcJOX6LMDxaCfK2V1hsAbi?=
 =?us-ascii?Q?ShNlK1/vHnzzHzgvQPtL0NbtDZsL3zUK38QYfu6n+lMhKuyQYkeA5w1yRWNj?=
 =?us-ascii?Q?x24b9WeKk3OcsKgHzfXtLVUdp7auDVkZG25lZTUOrXU+5jqBiV3O0ZWWBhHw?=
 =?us-ascii?Q?cdOxPTvZXgkLEuObZqNFsFEFlE3XglUEddGIQYOinQA+KzdEMCsMpuJM/Iqr?=
 =?us-ascii?Q?PPLNJuoNPmKCUjq4FgxCPzwfPhZqqpqpzUAiUOvf4IZ3Yyo5rKKEgIch1eRl?=
 =?us-ascii?Q?CdfBGYh/jIOHFV2Dih0litZp14kwSGerB+jtk8UfrI6Khs8l90V8qTI3V52x?=
 =?us-ascii?Q?0PiAnGUd8RO/vshS5Z63Br6fJ1/OSGiWVXPoKxHPzALi2yEr6Cmn9zDNWi8o?=
 =?us-ascii?Q?9USsXU3poIcj1wC3LLcyyWqn6Qd/rRVglH2cS3dgiEwa+fzlYi0kG07LdP8U?=
 =?us-ascii?Q?/tTk4NFN43Zrqs+6S0aMY2S/wqQxaRvPps6zORuBIqk4nrF3F+caNTAVP6su?=
 =?us-ascii?Q?y7vhABJpoxXLg9nmxdx5qj6XKNk4LbrN8wjZj3UbjY7YoIAccJzK6qMIJHZA?=
 =?us-ascii?Q?OThPPemb95I0uP+Bh94jY1pBIFqTmNwpn0tjFK27feV0zkfXu9Yk0UZq1ZEf?=
 =?us-ascii?Q?Bu4eLlygDzn/H7vbMjDjiCyPQDgrqUNyC1cIPClWDmx3j/7bxpQQquRHM4Vl?=
 =?us-ascii?Q?kZBS+cX+LBHvqOQqJucPcD12cu8/L0XAGTeTxxak3P+qsSexXmxKVzl5hBAF?=
 =?us-ascii?Q?9Fmq6aiK0AGM916fFzU+h8/3/esXrXqHZLGxCLorodsWUlUXiv095eIZGNHD?=
 =?us-ascii?Q?jxiU3HyYoLCChb+1SQCD8WMXJz/XsAY3?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 22:17:28.9227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d78f8baa-fe20-42d3-e6fe-08dcbe413753
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6370

Clean up and reorder them according to the bit index. There is no
functional change.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  5 -----
 drivers/iommu/amd/amd_iommu_types.h | 16 ++++++----------
 drivers/iommu/amd/init.c            |  8 +++-----
 3 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 2d5945c982bd..52e18b5f99fd 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -121,11 +121,6 @@ static inline bool check_feature2(u64 mask)
 	return (amd_iommu_efr2 & mask);
 }
 
-static inline int check_feature_gpt_level(void)
-{
-	return ((amd_iommu_efr >> FEATURE_GATS_SHIFT) & FEATURE_GATS_MASK);
-}
-
 static inline bool amd_iommu_gt_ppr_supported(void)
 {
 	return (check_feature(FEATURE_GT) &&
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 2b76b5dedc1d..c9f9a598eb82 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -8,6 +8,7 @@
 #ifndef _ASM_X86_AMD_IOMMU_TYPES_H
 #define _ASM_X86_AMD_IOMMU_TYPES_H
 
+#include <linux/bitfield.h>
 #include <linux/iommu.h>
 #include <linux/types.h>
 #include <linux/mmu_notifier.h>
@@ -95,26 +96,21 @@
 #define FEATURE_GA		BIT_ULL(7)
 #define FEATURE_HE		BIT_ULL(8)
 #define FEATURE_PC		BIT_ULL(9)
-#define FEATURE_GATS_SHIFT	(12)
-#define FEATURE_GATS_MASK	(3ULL)
+#define FEATURE_GATS		GENMASK_ULL(13, 12)
+#define FEATURE_GLX		GENMASK_ULL(15, 14)
 #define FEATURE_GAM_VAPIC	BIT_ULL(21)
+#define FEATURE_PASMAX		GENMASK_ULL(36, 32)
 #define FEATURE_GIOSUP		BIT_ULL(48)
 #define FEATURE_HASUP		BIT_ULL(49)
 #define FEATURE_EPHSUP		BIT_ULL(50)
 #define FEATURE_HDSUP		BIT_ULL(52)
 #define FEATURE_SNP		BIT_ULL(63)
 
-#define FEATURE_PASID_SHIFT	32
-#define FEATURE_PASID_MASK	(0x1fULL << FEATURE_PASID_SHIFT)
-
-#define FEATURE_GLXVAL_SHIFT	14
-#define FEATURE_GLXVAL_MASK	(0x03ULL << FEATURE_GLXVAL_SHIFT)
 
 /* Extended Feature 2 Bits */
-#define FEATURE_SNPAVICSUP_SHIFT	5
-#define FEATURE_SNPAVICSUP_MASK		(0x07ULL << FEATURE_SNPAVICSUP_SHIFT)
+#define FEATURE_SNPAVICSUP	GENMASK_ULL(7, 5)
 #define FEATURE_SNPAVICSUP_GAM(x) \
-	((x & FEATURE_SNPAVICSUP_MASK) >> FEATURE_SNPAVICSUP_SHIFT == 0x1)
+	(FIELD_GET(FEATURE_SNPAVICSUP, x) == 0x1)
 
 /* Note:
  * The current driver only support 16-bit PASID.
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index c89d85b54a1a..6b15ce09e78d 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2042,14 +2042,12 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 		int glxval;
 		u64 pasmax;
 
-		pasmax = amd_iommu_efr & FEATURE_PASID_MASK;
-		pasmax >>= FEATURE_PASID_SHIFT;
+		pasmax = FIELD_GET(FEATURE_PASMAX, amd_iommu_efr);
 		iommu->iommu.max_pasids = (1 << (pasmax + 1)) - 1;
 
 		BUG_ON(iommu->iommu.max_pasids & ~PASID_MASK);
 
-		glxval   = amd_iommu_efr & FEATURE_GLXVAL_MASK;
-		glxval >>= FEATURE_GLXVAL_SHIFT;
+		glxval = FIELD_GET(FEATURE_GLX, amd_iommu_efr);
 
 		if (amd_iommu_max_glx_val == -1)
 			amd_iommu_max_glx_val = glxval;
@@ -3088,7 +3086,7 @@ static int __init early_amd_iommu_init(void)
 
 	/* 5 level guest page table */
 	if (cpu_feature_enabled(X86_FEATURE_LA57) &&
-	    check_feature_gpt_level() == GUEST_PGTABLE_5_LEVEL)
+	    FIELD_GET(FEATURE_GATS, amd_iommu_efr) == GUEST_PGTABLE_5_LEVEL)
 		amd_iommu_gpt_level = PAGE_MODE_5_LEVEL;
 
 	/* Disable any previously enabled IOMMUs */
-- 
2.34.1

