Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEB41D53C
	for <iommu@lists.linux.dev>; Mon,  6 May 2024 08:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714983680; cv=fail; b=jLmz8p4R9Ryd0ue4T+b4MSs6aNbb/gCyBL69aMGo/8eqs+9ndnjODv65pKxfoQ/LfrE9l4TQgYa/JIz3f2zjFy0fQmJ1ZXkeexlafIbdxRJ9k50EPagvkPOcVe4IyXICXpO4hstbQqbVVAArfKC//7dVwCMjTah1+e1+XalF4tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714983680; c=relaxed/simple;
	bh=eXS6Sf8tOuMbaPaN4IGMST2JxVR/XGOPnASwena57d0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=twm/zy3q0z/AK/wQ28l+g3YVKdyMU8bX4XTb9CZZyHub4M0VoShVYi0u77CJAIbhA5SpCucAV/X3F8xrZdKzlfeQ4tOp2C6BGAR8Ty/LxbfGRsjlE4AaGOXVnUyVZ66R6FlszatlU4y0bnVS0t63sLMkRm5HVWklE49LdZkTb7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Hmt236Qt; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Hmt236Qt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnOmdcORTiSiwOSDyEtEKkgcdRnwKrI4eiP4GKl4qJsO3VacHwQiT00TrWDimw8Lj0yoDMyehHYKhbW4xRUHkS2XRa1vQpt9Kwb6fkPb0d/enBYpbjkY+OpzR2d397qnYjpomCyAyMak0R2/X8wTe6Jdfz5VTIM0evT+Q8mQQUnQcuNdiNwmGXSx8YACXKsVUn2okESI1p7WMBeyRpoQYbZ059srcVME1ahtBHXiqzVxwYNdBWSXNd26kcLI2GX0u3YJVQvYm4DUUr5AH4FITInCFfK1rAlOrBy4THvFwVq6cMUgPK12fosVVj0cwAJ71TW3KFGi2q62ZTO/STUQqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVVi/5xBNu03eYei2eo2bfj7fH3kJCGK1q/lGF/aQqU=;
 b=VBEPz0eO9G6p3M8ovtA30/KO24E3kqVFPd0b12LTywNNWOiY53sVUd+PmkAqpX8w7iJzwNZz7pcOzHpAmVXJ37vJpe5wI7THw0gtbkQeSulh8sOOqfsC0QLZaZUa7XCxQR1Ghs3bKJIGr9AqrcR/en+CY5sfu5eIbZF3xcjPuaSLcgtn63Vvego/xLFu1hCKHgrRJJqxfbMORFBVwsHteNvti2bFKU4A18y10N5owzTym0pMRILkV3a0oY2gT8S9XesSwo7lUdO/tWpVk1J7t4ozhm+p0R1p4/S5tSNWYrBDxN0aa4KQvdnYFXdhNjHaZf0hYKivCOVlKvpL4LKUIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVVi/5xBNu03eYei2eo2bfj7fH3kJCGK1q/lGF/aQqU=;
 b=Hmt236QteY/Zsbop7lIcnLKccssz20rRxM4rROxYI4uCLRrWwdCwBCtOXAWsCRuUJx2nfeawQQyFl/g53FCZllEBwLcScApSKO1bgyTiB5KuPlQUssz1RwCSGqlBcgCcawVH8yTZ8PJBNe+MRFSnw5jHgsg6mUmPDBiR9rAWsYU=
Received: from BL0PR02CA0072.namprd02.prod.outlook.com (2603:10b6:207:3d::49)
 by SN7PR12MB7300.namprd12.prod.outlook.com (2603:10b6:806:298::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 08:21:16 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:207:3d:cafe::8b) by BL0PR02CA0072.outlook.office365.com
 (2603:10b6:207:3d::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Mon, 6 May 2024 08:21:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 08:21:15 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 03:21:13 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Klara Modin <klarasmodin@gmail.com>
Subject: [PATCH] iommu/amd: Enable Guest Translation after reading IOMMU feature register
Date: Mon, 6 May 2024 08:20:39 +0000
Message-ID: <20240506082039.7575-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|SN7PR12MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: 68c610d2-6ee5-4c3d-8baa-08dc6da57fb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oDdYA/j25DPISe5S7gCJnve0oZGha0FfVtn2M7DZjPP7OI5UECVPk3JoLpBs?=
 =?us-ascii?Q?1KHpZJj9XWoQJAhcyG7GSkWq+OJYDCjwYduCOSO3NQ1XKpSRHe0qjKMq+ZkF?=
 =?us-ascii?Q?5NJF2r4i+ooRUpXAA2MQ7I93GzHGU51seYlw2jwoXXe2Iys4F2iCQdj1G5S+?=
 =?us-ascii?Q?J4lmXOxtEv+FcylPvcRJdZr0rRQBKLk+Mddw2T+TDNnqFjE1XstTnDsVQ6X6?=
 =?us-ascii?Q?pLHwLkKhyj6g1FOhWeLx0cFfgYp5nDxLu8VybIat/GP+1qb2njkTg4PyVvmI?=
 =?us-ascii?Q?GUUIhOOV8U8BL/UfYZie/Cm5PUI7ekZpnIqE6z6yqW8KakJlbO754xuXw+Lt?=
 =?us-ascii?Q?2N+dxF1AosepRvodv9GpXoKMgAbKOZmxhEA8oxpMRLWJM9xZ9fwTsxjpbjGI?=
 =?us-ascii?Q?vki5FuBrUN2dIBB4kCZ+GLQPpPOrPS4lM0prD9VAvGsndLBdRFnYSttyUnWB?=
 =?us-ascii?Q?+nRDwk9rT9jTNSepU2UlCRJxqnWGQT7AcCGWZgNCqzcMQffVInGG1vPVyMWN?=
 =?us-ascii?Q?lJRwUZMQx2HlpA8ZL0AumbRz5/+NYyx9J0Hc6ntU6u/KdPHGegEuZ+K3DdHj?=
 =?us-ascii?Q?dYfnRY1g5WFJ6JssioAgk/6wK4NHSkjDVtu8+I0Mur3PAjHh1ahC3KvOaCWq?=
 =?us-ascii?Q?BC7fS7Ytrm7ix0i1zeikal/X4ShNFHSvL1QenzIRzq05QvuFYs2EwOi0LzNO?=
 =?us-ascii?Q?/ybCs2GDy7QXB4GF9WYUBlIXPyUVmR5y+C8jL9/O4zm542gfDwb/YL7LBuHN?=
 =?us-ascii?Q?bi/rLPh+6TJDIaDar8McARiblx9yaMu7dAlauw9ljydnSbQcK4lU5RCYVrou?=
 =?us-ascii?Q?tnZByGoeJouJkMT+rqHB5NwtXWqd+O/yV/ajn6GHeH/atM6VJCO7/+2L06fy?=
 =?us-ascii?Q?zPYv8MyKjjxIiQdexzQHmOAX3vq/q0yX9OiqKf0upQhYqLo8aRzV0b8UVsSF?=
 =?us-ascii?Q?+k5TGH+RRgYtLDP6mcam8W1oQ8AiNnlHu5bFA2J1d4EaP3S3ElcVuJC6pdzm?=
 =?us-ascii?Q?UcWbzyBdlwvh1MT64Y+Me0tKX/ndjRKA9+DUHZVOOGBYAp6qlDEeuDw3UmEw?=
 =?us-ascii?Q?TLJt7BHPGtE9Z+IGQV1MMyJzkq+W5AcW9ocWzvza5aZDV2m7DYIH3xHzyPAF?=
 =?us-ascii?Q?2Yp/AxGDEexJcTzanCpa3H5QhSfmeYN00uJHARPZhTYXhCw3mWjHfTTIFHUj?=
 =?us-ascii?Q?7qRCJQkYzLlrYCGSCtOV3uuBrSXVuLNqWKClbWpZZGwDHw/YBWV3ZnIWQXRD?=
 =?us-ascii?Q?zFsWGQekqQjQvwCENsHr7q+M/aUWxTXCpr34QB5Okea9CfrTWJ0dILtQR4rN?=
 =?us-ascii?Q?9glEwIuTkjl5Wr3LzbdLKLXn+4fj8PgUDNpHGD1f22OqOTMRaFKZNyCdS9sS?=
 =?us-ascii?Q?layeVIQ+bA25NZe2XpcAn/b2htFD?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 08:21:15.8606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c610d2-6ee5-4c3d-8baa-08dc6da57fb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7300

Commit 8e0179733172 ("iommu/amd: Enable Guest Translation before
registering devices") moved IOMMU Guest Translation (GT) enablement to
early init path. It does feature check based on Global EFR value (got from
ACPI IVRS table). Later it adjusts EFR value based on IOMMU feature
register (late_iommu_features_init()).

It seems in some systems BIOS doesn't set gloabl EFR value properly.
This is causing mismatch. Hence move IOMMU GT enablement after
late_iommu_features_init() so that it does check based on IOMMU EFR
value.

Link: https://lore.kernel.org/linux-iommu/333e6eb6-361c-4afb-8107-2573324bf689@gmail.com/
Fixes: 8e0179733172 ("iommu/amd: Enable Guest Translation before registering devices")
Reported-by: Klara Modin <klarasmodin@gmail.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Tested-by: Klara Modin <klarasmodin@gmail.com>
---
 drivers/iommu/amd/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index fd3e76e43699..b292181995b7 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2046,6 +2046,8 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 			amd_iommu_max_glx_val = glxval;
 		else
 			amd_iommu_max_glx_val = min(amd_iommu_max_glx_val, glxval);
+
+		iommu_enable_gt(iommu);
 	}
 
 	if (check_feature(FEATURE_PPR) && amd_iommu_alloc_ppr_log(iommu))
@@ -2732,7 +2734,6 @@ static void early_enable_iommu(struct amd_iommu *iommu)
 	iommu_enable_command_buffer(iommu);
 	iommu_enable_event_buffer(iommu);
 	iommu_set_exclusion_range(iommu);
-	iommu_enable_gt(iommu);
 	iommu_enable_ga(iommu);
 	iommu_enable_xt(iommu);
 	iommu_enable_irtcachedis(iommu);
@@ -2789,7 +2790,6 @@ static void early_enable_iommus(void)
 			iommu_disable_irtcachedis(iommu);
 			iommu_enable_command_buffer(iommu);
 			iommu_enable_event_buffer(iommu);
-			iommu_enable_gt(iommu);
 			iommu_enable_ga(iommu);
 			iommu_enable_xt(iommu);
 			iommu_enable_irtcachedis(iommu);
-- 
2.31.1

