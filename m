Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84801B8EA0
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723824053; cv=fail; b=c/D7htoPVtlsgGd4cuJ2PzsRp9DPleG6mImM+gCUoOFst6Sib3jJ201/j/mtq7nBgyaKH9BF/2fMh76/lFTkKVTagiZXhdOCPyDDfeuLziJ2YY+lU+3FoPsQpVFtcuRgQosEl+JM+aA1E/dNH2QssvW/frT/Emki+5KaPm1Vk/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723824053; c=relaxed/simple;
	bh=t+IL+ZZWxLM50wjZFqVMTL0rkgHCLnmO97Qr9VWkAyo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pNG9lFF25ICk1WzFuiZybRRgsPZN/GCW9pX9y0iw+L85NknqWZLDgeB3bPNj24NW0xENpxltkuaCilGKXWF09MePJ3VvM8feuHbatc6+KbLBNY+QmMRxH/tlmMWSCOs7rHGvdbTh3Op8D0jtw67oVN4TNaCHwj6/Z7Df41bwU+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fip9Zxlr; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fip9Zxlr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hiO9oZK6abq5P7WtXHk7/nQgbyeBM9r6LvcjPmHznrduauRlFQZzBvjMl+d9Wwkkj94N0LRhMY4Ec//Ss70Ogni18UNkyYuKSJ3ZCq03xj8ZoUB7Ii1OuVtqXJoI0mVWhCWknosLq9GN5ehcQAe3vWF/T4wQBdppkzWasDTyfsS8u1QPP+343L6MjNIvHvGrXjUlc2FoKnFK5+TKJyNVfi7OC0uneWle+ZDzp72f2RoQgNAKfTB0lLIAcbCZzTyjwOzwhJ9mouso2Y1rcqakw1B379jI0UqWi5t8VPNwLz6YwhVTSfVBRUoMxB0o91t/u3qVdj6TPDa+KSt9yXgTpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMZo8itQNpP3L052tRLB9M4IvUt3u6lyWubzTo8BPkU=;
 b=lrnEcX2e6iDK2Z6Yr183UK1kAscIq3eemNmeTJlAaZSfn8DaaBbZnkTndlpFl94ssFzeBlFEn8TlZGct5yW4rEdZo2JkxiFJQAqB2b5YKf4G+0AsOO4kmof7pWk0DivPshriYcYE+vDnb5g5hIBMzJkSioTsZsL0PJD5LgNkh13zwcf8s2DamtEBXDnhZJw72zmV9LmUJLi5OTrD4Pp86J2coar4HIdccoZeM9siaVC68fy1jmTAPeBAhzgiomXLWNnmudDdvu/+gKluQmI5mVNmb+nM9fpjSCPRhz/ZsmOK+Jtr7GUSBXG8T7AUUf8y8sd/7oHgcAKLAB2J5xwk8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMZo8itQNpP3L052tRLB9M4IvUt3u6lyWubzTo8BPkU=;
 b=fip9Zxlr3pUnxiUOVZBogf2DcEFwpOylHOOI9LgDskY8G4x9e7n7o+yKE9HndVRPSd4MHThmiq7BCpJWhOMCJLRPB8pYg1P2M1oL4iSkHPJqvCBhaGgyHDPUlnDTqRoP58JAqaUplsdkYBqvaOpAbkOYbAcSumKCHcuoRkqt938=
Received: from DM6PR07CA0063.namprd07.prod.outlook.com (2603:10b6:5:74::40) by
 SJ0PR12MB8166.namprd12.prod.outlook.com (2603:10b6:a03:4e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Fri, 16 Aug
 2024 16:00:46 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:74:cafe::8a) by DM6PR07CA0063.outlook.office365.com
 (2603:10b6:5:74::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Fri, 16 Aug 2024 16:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 16:00:46 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Aug
 2024 11:00:42 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jon.grimm@amd.com>, <santosh.shukla@amd.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH] iommu/amd: Update PASID, GATS, and GLX feature related macros
Date: Fri, 16 Aug 2024 16:00:20 +0000
Message-ID: <20240816160020.5525-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|SJ0PR12MB8166:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b7c2130-2703-4175-f97f-08dcbe0c9709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m3W+BmrStUNekhmNn4gus22Yp1ZhvWuWH4X35iQWsfeOxMSwV7MRZIiP9f9a?=
 =?us-ascii?Q?XbiFxWff8Vao5k4yrbdH4IETWyVz801w47I7FZ22b0XWFRc7knbJbQRxcCJp?=
 =?us-ascii?Q?9MXSZVOd6LFO4Mc567nHVOl7qcyJLtg6vAUO3LpL0qaY6D5Hb5GqVSIwpAT9?=
 =?us-ascii?Q?2v/1sX/HdueJacLbEL/CMAmNNaie5teqbuWLg4A+5eKWxkRO1jY2zJKqpRlX?=
 =?us-ascii?Q?jA1kfqq39cF8s2B1+OmdJ4CIYJ3lgJMDGYj70Ke7rSC77L+ixltfLL7bLVCA?=
 =?us-ascii?Q?j1y6mrwCRn86ZN1TUTjlWGmwUEGuu0eZwFirwePJXBZvIgyADL0JCTY1TNHO?=
 =?us-ascii?Q?dkq01u+xaK32aKMybyZfEDWTyajNx0Z6dVmdmJBBts8IxJl199+EICwmW20w?=
 =?us-ascii?Q?JQn8eqJ4Fkqrk2Ks1pwt/BQ+XwTJddL85ddA9TrhXvUuKDKqap8j2w/GZEqU?=
 =?us-ascii?Q?Hdnebhbtf0AETLE8GAK8lRHDBAfdnnjA4blt1ZJvf9assOIpHUGz2pqBVwmW?=
 =?us-ascii?Q?24Qz7yfcXR9aLM5JrNubqVtzV0xaT4aPhCIQO5Zf0U36Df8aZ/OwFssNNWBH?=
 =?us-ascii?Q?oH0+7O5SkE0qnf6kS6P6kFf5kMG36Zm2Vn0dANPs3/FEt4t7+XxpkUvbPJWk?=
 =?us-ascii?Q?TmuqoM2kME1KC6gFZf0V6nCFaUCEkXrILRLRCaiYdT7BElwJnDOLpWCSeJwU?=
 =?us-ascii?Q?qF6bSQSkDRGKa8+wOv2ER/bSYjpSQ2oP31eaTILu9jyYQNsaNR2muJccWAW6?=
 =?us-ascii?Q?ug42KTu9I2tS3F9+/HVZGkv1GJmRev8NKPgJsBb1NALO9dmG32zQJ6a0nVRD?=
 =?us-ascii?Q?43WDr6mUh6V5VQ+YZzEiYXuyjGMRNqxjV7jF5HvQKyaWJSDwM9YySrNcPq1f?=
 =?us-ascii?Q?Eom1jIu7+JoDto4BpNLQIw5BB4DKOfs6DBTCSGldBIhxkJFS1aYX53TciQdC?=
 =?us-ascii?Q?qr02gSOr4B7C1FnZSsQxOPoLo6lT62gjm/MQj1ZveqkY474QN+Ci755EBK/c?=
 =?us-ascii?Q?53WzG1iQtCIjTdF7IUHw7D8Fz2DNw5FM9QcUnyBaPNhutJSY/T6V2IWzS/f2?=
 =?us-ascii?Q?l/OiAROo7DGoZFSd2STt0ntF2UBrtYNL0g5VyAmtdYV/P/UnILpAG7AD9O35?=
 =?us-ascii?Q?UOzgjI8PMet8CGMD2rEhkekFLEEx5U4Frxozz+yDSSSqbnDh7BupAAKkojXv?=
 =?us-ascii?Q?ZK2fz+KRCFzIy2Wi5KZhY3ucM05JeeUcZJ6IJYrApfhgjVkl2Tn8n/fpZzzI?=
 =?us-ascii?Q?49SovWArR7N5MbnkaHTPFeqwX+AD+5KBnPneHPEFCKQQFPz3+LPgt+24+1RD?=
 =?us-ascii?Q?ta5yKWssBFs7iQ1J2oVK2UitrpInHPy2fcbbawwJviax2s8E0weUM0cSnckJ?=
 =?us-ascii?Q?0IvfyWMIrbA0hX6EcZtCoCvmWZQU0tKzh9e9qsZdojUhT2iEH9jeLphRmVlC?=
 =?us-ascii?Q?bI/vgUplLg7IZDhPnf/NVPZXHbUgJeFH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 16:00:46.1103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b7c2130-2703-4175-f97f-08dcbe0c9709
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8166

Clean up and reorder them according to the bit index. There is no
functional change.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  2 +-
 drivers/iommu/amd/amd_iommu_types.h | 13 +++++++------
 drivers/iommu/amd/init.c            |  8 ++++----
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 2d5945c982bd..478b4e7b4bf2 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -123,7 +123,7 @@ static inline bool check_feature2(u64 mask)
 
 static inline int check_feature_gpt_level(void)
 {
-	return ((amd_iommu_efr >> FEATURE_GATS_SHIFT) & FEATURE_GATS_MASK);
+	return ((amd_iommu_efr & FEATURE_GATS_MASK) >> FEATURE_GATS_SHIFT);
 }
 
 static inline bool amd_iommu_gt_ppr_supported(void)
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 9be761ba0214..c6350a764d8f 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -95,8 +95,6 @@
 #define FEATURE_GA		BIT_ULL(7)
 #define FEATURE_HE		BIT_ULL(8)
 #define FEATURE_PC		BIT_ULL(9)
-#define FEATURE_GATS_SHIFT	(12)
-#define FEATURE_GATS_MASK	(3ULL)
 #define FEATURE_GAM_VAPIC	BIT_ULL(21)
 #define FEATURE_GIOSUP		BIT_ULL(48)
 #define FEATURE_HASUP		BIT_ULL(49)
@@ -104,11 +102,14 @@
 #define FEATURE_HDSUP		BIT_ULL(52)
 #define FEATURE_SNP		BIT_ULL(63)
 
-#define FEATURE_PASID_SHIFT	32
-#define FEATURE_PASID_MASK	(0x1fULL << FEATURE_PASID_SHIFT)
+#define FEATURE_GATS_SHIFT	12
+#define FEATURE_GATS_MASK	(0x03ULL << FEATURE_GATS_SHIFT)
 
-#define FEATURE_GLXVAL_SHIFT	14
-#define FEATURE_GLXVAL_MASK	(0x03ULL << FEATURE_GLXVAL_SHIFT)
+#define FEATURE_GLX_SHIFT	14
+#define FEATURE_GLX_MASK	(0x03ULL << FEATURE_GLX_SHIFT)
+
+#define FEATURE_PASMAX_SHIFT	32
+#define FEATURE_PASMAX_MASK	(0x1FULL << FEATURE_PASMAX_SHIFT)
 
 /* Extended Feature 2 Bits */
 #define FEATURE_SNPAVICSUP_SHIFT	5
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index c89d85b54a1a..39c6b59c0fa7 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2042,14 +2042,14 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 		int glxval;
 		u64 pasmax;
 
-		pasmax = amd_iommu_efr & FEATURE_PASID_MASK;
-		pasmax >>= FEATURE_PASID_SHIFT;
+		pasmax = amd_iommu_efr & FEATURE_PASMAX_MASK;
+		pasmax >>= FEATURE_PASMAX_SHIFT;
 		iommu->iommu.max_pasids = (1 << (pasmax + 1)) - 1;
 
 		BUG_ON(iommu->iommu.max_pasids & ~PASID_MASK);
 
-		glxval   = amd_iommu_efr & FEATURE_GLXVAL_MASK;
-		glxval >>= FEATURE_GLXVAL_SHIFT;
+		glxval   = amd_iommu_efr & FEATURE_GLX_MASK;
+		glxval >>= FEATURE_GLX_SHIFT;
 
 		if (amd_iommu_max_glx_val == -1)
 			amd_iommu_max_glx_val = glxval;
-- 
2.34.1

