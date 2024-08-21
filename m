Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833911A287F
	for <iommu@lists.linux.dev>; Wed, 21 Aug 2024 13:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724247389; cv=fail; b=Gr72eSc35cbzsjxus+1VglyMkrTT9x5T3s6R12LYSyK4t9SgiblkpospG+nV3yRLOalfMWW26MALEMOrWqi5LmxSFXL2PWMWHHmkR0vlBLt9Jv0cylhsPa3sSx0wXs5G4lN3HQFYJ5pkVywipgnsQ9n9vxDmyfoOr4gmv6caXEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724247389; c=relaxed/simple;
	bh=y71CJdVPwlqPZGtMUebKXKAwDf9KCcJe/sWzJz5um0Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rQaE2LBuZv65qvsiKMbKDQViAh6p6LLs6/8ww2o8rt1CIk4WQJ95qjpbcrGdeMJwi/XrS1NxrOV3x19vj7jC+o0YYYRSI2MaXsvRFwuHt4Tdu4RKJxrwPl4gLeZVDvqWOp7GDs5P8HJpb/DViJqKFgBTolTroFloeyXYYP8n7uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WECLkpUL; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WECLkpUL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ypoSZunlRu6X9mCi0JhQFkwT/h8lb8sQLMFHk6rEFDBQAZowNHHGCLd2DIht48M7yGGFF1C+VuTKjbvW2rZ85eFddSD8uNBGHLnxshzvez9dCqzoKIZUqX6XKPIgQdlSv2XyfzPZH4IDp5DkeXxXO2bi7OZb1e0FwbvW7bJ5+seFBociw/8VrbenDuhNIEE/T19PMOcW5emXccUpjJ42Abl1NlzhJ//n0bKGGl7TH252+lkAZ4Hv6k/n2PmLBAKcZqafaysGwrIKQ1rd+fd5cj+KQhz3bcYRE5uLBV3en8E8GhBPlpgjMyloHBtjqIwkNc3o9di3gDOtDG0sHAfwVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tLtRkont51PFkiOWJ0zuIX3n7/PmaD2LWJCccedXtM=;
 b=VsJslzZAHluy1FDa5lboAk+Z5t0n31soaAjE2NoR53gjPyTRn8FSw91nEdRTLulnt6mD3WUPx5sJzbiU95qvhbFwWOC3PY7GGijfh0Pi3JsbPsznmzaU8caNpNAvbccX8LikPA57ysQB2b1K5EPZIDTp1Ew17DoYeEiVgLQJ1zfzgJDldzp9nPfATFWOS6vWJjURXH30Pdwj2aJTjRO2UhXQHvxRFweWuRxfOyhWwiYlM6Wdcv8P+C9dIAKNhrn4oMpNOT+EWTJQdC7xQ9Q65CJamxxAcwg7031s3Ur6u6G2n77NYLM3OJTKpiccNMR6qnKsoGx/bdeeh3kgu/5KpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tLtRkont51PFkiOWJ0zuIX3n7/PmaD2LWJCccedXtM=;
 b=WECLkpULtVMd5oLA6vr0P89kzIZEyvnpwRlCD9dhGmoOMKX6KSuUiIXeoOSOlgOL0Us299AQWr8qkFOUslWlPnFTJL+NfkiMWWt6AKadlItQVTPDJCP1ZVLKtJqfhSIGVAaoaLxbP5o/pxNhQShXsmINDJSQ9Guif3shgm9I/6I=
Received: from BN9PR03CA0128.namprd03.prod.outlook.com (2603:10b6:408:fe::13)
 by SJ2PR12MB8110.namprd12.prod.outlook.com (2603:10b6:a03:4fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 13:36:24 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:fe:cafe::e0) by BN9PR03CA0128.outlook.office365.com
 (2603:10b6:408:fe::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Wed, 21 Aug 2024 13:36:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.4 via Frontend Transport; Wed, 21 Aug 2024 13:36:23 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 08:36:19 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH 0/5] iommu: Domain allocation enhancements
Date: Wed, 21 Aug 2024 13:35:49 +0000
Message-ID: <20240821133554.7405-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|SJ2PR12MB8110:EE_
X-MS-Office365-Filtering-Correlation-Id: b0945fca-f99c-4ba3-b7e4-08dcc1e63fea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G8UMDfrXeZIYvJdS+pp76DwIFKFa9P8f1BEX19MKIGswPcGYNX7XAhb6PyNo?=
 =?us-ascii?Q?/z2pzoWw4fLRJiM7lcHMzwalAI77ALfl56tk2lto3n264yydsdvEoDM4Ajie?=
 =?us-ascii?Q?EQ7kXZn8h216myIBIbgs/KOiFcK7Fiy4IPv5YTYwmOv9QE/vf1EbfOHglY8P?=
 =?us-ascii?Q?3sqNhM22rugdfkT3goHZjgcak0BEw6jLhyeETkb42G6MlxQlAZ3eqMsLzrA6?=
 =?us-ascii?Q?VX+MILCSplxlSbBNzfTc/V+Vug4a5x9JuHEk3Pm27WYT311HHC5TpynnSBtY?=
 =?us-ascii?Q?0wSOQbHRR08TyYGCEUiDIU548qb32Rd9YyGt0usZ+ac29kjzfx6e/08uNEKH?=
 =?us-ascii?Q?YZL6v1aRqfb10Y8O6Lo/8re65tZU/7PsJFtO74/jrMNWaMNepRJIGOh5XGso?=
 =?us-ascii?Q?NpsTqH+7GlLrRZ1tAAtvP8X8EA489GoIT1tSmfaT2u1KCnaG1jN4SxnXtL/k?=
 =?us-ascii?Q?zSjcLeknH8dcU/3q5302klfwiXCc2TU6OYBg9fZN6gVhkfVNP812aZDVP0Y/?=
 =?us-ascii?Q?9vx733YBfi5L5UBaBnPjjqBv3vK5VXc3NO5je4xvbo3YkxQ7Wj7T8KaOKLpq?=
 =?us-ascii?Q?0+36nFxotEjF2p1Ku5WaHVqTAnfh/p8YPkFbX5NaD/j/Dl5Cv972VX0fRvBT?=
 =?us-ascii?Q?lRR7pnqmE6ZP8iCd/ByYShXMU/1KcFi6zmKthX0/8GcfnjkX6y6L6UVJ/kY/?=
 =?us-ascii?Q?TJL62UOMsJSFwpijSnVMGoa/ueCUPiF95mG+EGW9QJ9Z2Xb3E/PFwF4w1Wfl?=
 =?us-ascii?Q?L0hzJ2C6XLRW1WfNix5+vKzfchXu9nXcuHwnmfZX/mA7AM8/3rcKX41pkoct?=
 =?us-ascii?Q?u2H4JlunJRUmZStdezC8N+mIH6OPGRW9WWNTwkIAgzy/0ssfg4+jEvDkk5Ug?=
 =?us-ascii?Q?x6vFRrdYh7ac3q8gUnTlWjNmd3bsMB+iGj9YMr+DIMU+UmbAH/aD/pffTWKy?=
 =?us-ascii?Q?Bz+FQUX0pl6Ms+0ngp+uBPuoCtJaDUNb6jK5AqxNJlr0QdLlNNC6hGeObuzw?=
 =?us-ascii?Q?q5WWHGktjdq4YAgPiDg9PVkN2BLK/SzGUD9nf+5JgYZAyMqTrJgnU3/6g+7c?=
 =?us-ascii?Q?92iRyNMd/Ukvvi1UOYfrB2KdvkS/Vu9QW5w/vHOkOEHNBTtNlHCnwTmWS1GD?=
 =?us-ascii?Q?M+D3b3JS5eDZSljYD9IMimaBySpLPx+rJoyy/yvEoz4Z/72AF4tOBqK3g3OR?=
 =?us-ascii?Q?QU2bvTkfUq464S3wJLyXMyqXvZ7U0OI8yiq7mfxtbMsXVDlUYBszahn2DCtF?=
 =?us-ascii?Q?yZENddDQt8pz5GsHkl8CdLrBALq3Mg/wp4GHMs7Tp1T62gaARgCZIEFSz1AH?=
 =?us-ascii?Q?MxSZj+q6uaXF7XpGP9K2hcxDKO9b7DJJMMV5Xlqac2B5jQxiBTnUcjsgeRqB?=
 =?us-ascii?Q?aoB/kksf34EYNJ8c29nTsMZcbNgH20l2wH7vwvni9Yf966rJ0w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 13:36:23.8128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0945fca-f99c-4ba3-b7e4-08dcc1e63fea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8110

This series adds iommu_paging_domain_alloc_flags() which takes flags to
pass additional details for domain allocation (like domain with PASID
support).

Also updates AMD IOMMU driver domain allocation code. With this by
default it will allocate domain with V2 page table for PASID capable
device and v1 page table for rest of the devices.

@Baolu,
  With this changes (patch 1), to allocate PASID capable domain, core
  will call domain_alloc_user() interface. Do we need any changes to
  intel driver?

@Yi,
  I think we can look into iommufd related changes once this serires is
  finalized.

RFC v2: https://lore.kernel.org/linux-iommu/fc8715e4-fb44-433b-a42a-7804118ebc57@amd.com/T/#t

RFC v1 : https://lore.kernel.org/linux-iommu/7e249bc6-c578-40f0-aca7-835149a0ad39@amd.com/


Jason Gunthorpe (1):
  iommu: Enhance domain allocation code to take additional flags

Vasant Hegde (4):
  iommu/amd: Separate page table setup from domain allocation
  iommu/amd: Pass page table type to pdomain_setup_pgtable()
  iommu/amd: Enhance domain_alloc_user() to allocate PASID capable
    domain
  iommu/amd: Add iommu_ops->domain_alloc_paging support

 drivers/iommu/amd/iommu.c    | 104 ++++++++++++++++++++++-------------
 drivers/iommu/iommu.c        | 103 ++++++++++++++++++++++++----------
 include/linux/iommu.h        |  16 +++++-
 include/uapi/linux/iommufd.h |   6 ++
 4 files changed, 159 insertions(+), 70 deletions(-)

-- 
2.31.1

