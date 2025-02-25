Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C80266583
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 10:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740480942; cv=fail; b=kvad51itacueI5O2QnO39HXESs+VC1oVM49T7P6URt6lUIMySV+/tv1q6aHkkdEUC0iJdh1PaRXduukWIGsY6oUm1rW4xee6GsxyHDUU7lJhZhsoB2rvIzKunq/Dt3dZA41DiVy+hNnB1+qTRa5cfUWYgMnS2e89Tg0mZjAQOU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740480942; c=relaxed/simple;
	bh=LjppJ/8ROIBXzYMkgJ9M+v2MyCCXFj6qQhT/a/4TYKg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ow69TjRd0FtIxvqzlHY1v5IB/M1s0fiQGTZPpO7codZxD+bzEu27Nzi2Ts0RxIgrsM9bfZyjeDvWMfCO0MIMfdSa0cvzGJm1Q5zvScDSemjE50NMqHsIju/vg6QuV+4nRwjbJDbj3LD48GIhVzHhG9aU33y8O/BKbu5CEEmgUIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kB/hZHtX; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kB/hZHtX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ls/o5m5srZjgqaxgGST3rWaUKnjspXQG1w6w1ewMY73F0bp0VbxbA3xnHsw5P+ynO0/DyNAuy/PIC3abREc7DM/XYutFiIS83EXad3aDexU3Zy5hP987kIDNMYysBG/ztg+RV2cIb83wsmQRLCTYND/y9zs4qxByK6tYHUvlasJgwKs0+xU8YPBtpi8kSsQsoBz/SAOv5U6863viSpad0C1HC1XH6YWQWUnIJsmAYkGx8UUWtjAT6fVOZENZU1lWKMGJYnvFUkGMP+ngi1R+J7Zn8ii0x36/PskoEBQ3I8hpOLCV4v12hwUzE7lVP7d3Lb1W2jR1xyLyHsDzX7yq3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UirPJhq1mzyocvEZbIi9PHhvyLiDpZRltKaoMcZBJZs=;
 b=NO/tjQuo98r1lxNwwC+dJDyV/MctXIUWYsySfFGfqkokYIx20LoCnyYyhWF7hfpqBAcxWKZMjLUXxNNFQdtlj+CPO3afMnxfffXg25yBW/wc+jjpKpyDybQ1fY1bB5nqTqAvnn9+rumtbyN++Ded95SBJcrZ3e5516X4Xabnbg3R2Miu5M74jI6MA+6OLjjOs0+3iqebJN6CDd6mCkmodlHyx8FRj0aOK5vhkWQCJ1oLFYx2GeEJ0wFHUlcT56Yj98L2vD/a/iLK8nXsM7bQGdR3Yuaw+KeHZNFqXXvsyDbSlC4psqPpdUCPRsm4j2DQ6Kqjg6va5jLCGUC6LjPEfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UirPJhq1mzyocvEZbIi9PHhvyLiDpZRltKaoMcZBJZs=;
 b=kB/hZHtXOuf8X96qVxPQuN9ES/o9SZqRI/rzCn+li6q4t4bxECO82bf/ACJwcZnv/BXVZUaUfl9Cb+pfHvNzofFacdyl6Vc3W6ATuI5Pg4aol7Hwdr+NRle4XViFtxAO0B5dMy3mCupQqi+OBfYCQkZJjJHXs14ryYsuHX65HGQ=
Received: from SA0PR11CA0083.namprd11.prod.outlook.com (2603:10b6:806:d2::28)
 by SA1PR12MB7151.namprd12.prod.outlook.com (2603:10b6:806:2b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 10:55:35 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:d2:cafe::da) by SA0PR11CA0083.outlook.office365.com
 (2603:10b6:806:d2::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Tue,
 25 Feb 2025 10:55:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 10:55:35 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 04:55:32 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 6/7] iommu/amd: Remove unused forward declaration
Date: Tue, 25 Feb 2025 10:53:44 +0000
Message-ID: <20250225105345.52143-7-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250225105345.52143-1-vasant.hegde@amd.com>
References: <20250225105345.52143-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|SA1PR12MB7151:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aafdbbf-0a6e-41c1-37fc-08dd558aee79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5Y3mhxkzk0ZFBgV0NKMNYlLQNT6zjCFA/c3lesTWOSN13RHhpn5d48HbeMZj?=
 =?us-ascii?Q?sPp2y6vViQ6lbhEj+ZLyw5E6DNtpJxoOaWMfhdKwmahV3bc8oWIAOfbdIkZG?=
 =?us-ascii?Q?Zbql5G0zYehY0avOtPQmySJkRipdlgMbEBca82QGV7Tc/8QSOBcg7nKPRW5j?=
 =?us-ascii?Q?ccFyZZGT/xJfqTgy++UkzssUSWiwhNHhz1Ru3nHIK/zu1YwjynOnSU9E5Y/m?=
 =?us-ascii?Q?Wtkmv43RjwF1pfTtpcgaoNwRo7su2Jw17jTDbP1HEQZp6iGKH9/p+DhJ+Hl5?=
 =?us-ascii?Q?dQMUP4ep+/o2DTPOl4rPth3az5GDljJsoXBbgM97B9EwRwh37Azl/byc7GIf?=
 =?us-ascii?Q?cW0A2FmXnWMES4bwPM35NocN/seGMXmlH9eht0ZBUpgKyfG43ajUvtIMhR12?=
 =?us-ascii?Q?VWFTL4y3HIpI7836o+IeXgAAZMcOi6wYfb5l/7niB7CKrcUqNL462us7unME?=
 =?us-ascii?Q?0RbW7SZPMzk3Z9B9745Gh7nVYikoHxRk9KkTTOmvhXSaxTxx/Mi/VUTkofcY?=
 =?us-ascii?Q?et2ruhojF8e2emyQLZ5ka2i+EVOAkHzJuGbx9BnNLja8eYcDaTTA+bYnuDiE?=
 =?us-ascii?Q?wwlSYxNdhvf/n3m+gznxTXXmxTHUuKVkFZp+IoOAQ3vSLAbD4TJJI3WLLJMn?=
 =?us-ascii?Q?ybXo923Kaciosg51RRQfjTv+bCW6S2jQk07Apf879NzFL5a7sPCUvlNmIx1J?=
 =?us-ascii?Q?ATfu15dAl2J3MmmCXJp0bk0NVtMkq4Cl7IkNlfzbOEBZ5hjtB+JTFGklrRoG?=
 =?us-ascii?Q?8EMnSmJqhT7BAADtA8Sn/owKpgp0oc+euWzC8ylyVG8tFCifbiKMRRJ6qpxS?=
 =?us-ascii?Q?SN3TD4l81J3W7Tx4bOsZhYPPCxPs4g8G8jCe0/hDg5ue/qXKJj9bOH40MMod?=
 =?us-ascii?Q?/D63dxQRr9eTq/VR3rbzBhkkygnkua09sczQRxpXu2c0lFB0nnc/sK2z5jlK?=
 =?us-ascii?Q?fDIRlhapSksoqmcLcfLajfUv7qMRUrygXvkE/gqyxV8YT1jEQA8TH+vHCxqs?=
 =?us-ascii?Q?tU5E363pqRxx4Y355UfIdtjZk1+Gl/xXcNo4XWhIIJOsn+u9f2feJUMgbhhK?=
 =?us-ascii?Q?VPt+eIMeggtPsj4lKoiTwfxuf3xvrqZpe24tgvZ2xYdqLKXDXiJJkPXgmGGm?=
 =?us-ascii?Q?pL7T0IiqZ13NJ4FqSx3hFxllwXRGDi5WD6XOSP38yaScSCjcXgDkz9GYu873?=
 =?us-ascii?Q?gpWSH9MFJ/mgNkJP56snw2jw9j213Tlj4N1x306NmxwZ4yh9BXOX8k9vqWoW?=
 =?us-ascii?Q?qxqF0iNwPdvW5EQUsVPuy6QUcXVnBkCVkc/pMFED2s+C/TvNohv4HVIeCHGV?=
 =?us-ascii?Q?mFp3bOELK/JTDZr+UZ2PTMm/ZM3m+wIeXwVMue5wXKN6RA4XLiSJBIJfb4Vw?=
 =?us-ascii?Q?e6WTv1E6WGrb+vLHgkw3ivZJUOtSNrBG6b3wY6v49sMqmTo/+sYjreNPNITL?=
 =?us-ascii?Q?i4k+egIazxI8m95PVe4goXPrx3MvpU9FKAMoxrAMFIsKwaaTzcL0Q5ZI63RA?=
 =?us-ascii?Q?DQABLc/7eBPivYw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 10:55:35.0466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aafdbbf-0a6e-41c1-37fc-08dd558aee79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7151

Remove unused forward declaration.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index cb536d372b12..94aaa4b2a903 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -219,7 +219,6 @@ static bool __initdata cmdline_maps;
 static enum iommu_init_state init_state = IOMMU_START_STATE;
 
 static int amd_iommu_enable_interrupts(void);
-static int __init iommu_go_to_state(enum iommu_init_state state);
 static void init_device_table_dma(struct amd_iommu_pci_seg *pci_seg);
 
 static bool amd_iommu_pre_enabled = true;
-- 
2.31.1

