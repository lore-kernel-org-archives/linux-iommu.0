Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAD9136331
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 10:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729680161; cv=fail; b=alEEqOfp4tGIGJVOh1aVcWQJiwNRrBLBO1sv8yMNZtZkhW9+73Jv2QWzcv5kdvkwODGzG/Ar2CtP+V5MfS2ruP+UHMChno+aFgmt+SlHa40qTR3Nm+DcWB0VyoUpYqxFIYfJ5LHDrm8qTTjE+jB8F4JSi4VKKCvHd78zR5hVIl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729680161; c=relaxed/simple;
	bh=noOrO1vc/IsDsMThcX8rxLQWuu6qb/jsUg8pZLUiROQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vEGInGn2IYWynhAPRmmUH/J2eM2BZWWjD5RB7RWCxFcw6ZVaucxwfpO7uoo8pcu/FYOm3QTkQpWbu5IEyU2wpBWRYPkduibzJU45iFHp5tDqalyfimKhA69Nkuj0iWSZ3NZ5lo/flL7G5liojthubTwiqaCVrJ04Sz0BcaYEHas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Og688C+C; arc=fail smtp.client-ip=40.107.100.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Og688C+C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uki9cXbDklLcmSbZvJZEQtfOoQv5CgZQrzT9UgQdhZcgnz0gqekdFrgVD4lwMpDXHGyf1J1REv4fKjeSK6xkWSm2TDVeVX4Y0YaQvkugYU9a/dNJcGR4jC62vmHTsIeTNA/LmjfenKBvqvYlh9OLFF+83MAjP3WOQQuoTOY2ZKZnolalflLNNd5GYOZfO+wJ9qc5RrJKUK0gX58ZVc1WzNO8A43LAT3qVd0a4WETywzzLiZpYwYkYRfWHpExw6sh3ZEHOLW2KjHH18tuSrPGDLRNIfQqyE4cXsfzA3eEGRh9Ad6YuJfzXHnvWsyL3jDZ2XAsQJnlbuhx/BCUEGHbvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwzamxzmoikoSll5DE9vbrv5lieDKNMJVhtCpmLs5Ig=;
 b=Cgsyj8mU96sjHKs8bJ3a1lRHYyDPP2vr/AXn+xkyiC54BnKjQNhbUf1vjReLryPj07nLDXpKlx98LC9asM5B/25/OFQ4oY2nqIXKUO5bA0VcN0bQI1f5QxuidKYyL/9xqmQbFRf+g0QiyN6hIGDlL9I3D+0SfXazHNjH9kfizrt1sjEBtFGMj0Mk3tUtPPDf9FpjbGHe/Ay6253UsqWQM6fKN28vha+oFpkAZ9ne7nH8x24iph1OuuudHj6Qdq1HiTaNNpBLilE2PZ+w6XuXzry752yKKWd3RXzPL64Jf5J23Jn6x4uLZE7yGkzizLQQI45bS8LkyqyHsGRkLkFWlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwzamxzmoikoSll5DE9vbrv5lieDKNMJVhtCpmLs5Ig=;
 b=Og688C+CnqEmRtHSx/rasvxijSTr5XOhEO9ypLDRGnqhyVEsMuQzzTCtFetl1yam8OR6lmefkgRyURi29j0OKzOjhUiuJNg3SuJUGuLDLt456vFiX0AldOdms6W+e5n6JQDvM1+qTQqKpT7Dya81WuKf2ifD18nhA6d9Njj1voc=
Received: from CH0PR03CA0088.namprd03.prod.outlook.com (2603:10b6:610:cc::33)
 by CY5PR12MB6597.namprd12.prod.outlook.com (2603:10b6:930:43::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 10:42:35 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::5e) by CH0PR03CA0088.outlook.office365.com
 (2603:10b6:610:cc::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Wed, 23 Oct 2024 10:42:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 10:42:35 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 05:42:31 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v4 00/12] iommu: Domain allocation enhancements
Date: Wed, 23 Oct 2024 10:41:55 +0000
Message-ID: <20241023104207.5894-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|CY5PR12MB6597:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f5e1916-729b-43ad-9d7b-08dcf34f67f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8TVFIOdypcpR/l77Y4FR6o7YdOkiCWycGusTab20e5jJVAqVm/dP+B3LpbDY?=
 =?us-ascii?Q?Jw9tpP+2HUCH10iGIFEKBYet1d3gif1DkG/zUrhXWHBvP1HlOlYsuYzhsExb?=
 =?us-ascii?Q?oIUl0HENkmbruf9BKfq2khapUWgoIf2nOhtWTjdZIn54VGaL+8nn25BcSOhe?=
 =?us-ascii?Q?U5g0jKxAa4dOc13hZbFR5EuOkWbA2CiyxAMuDwR1xC4ZPHoBpFwelZnqh+sa?=
 =?us-ascii?Q?WDrmp9DHU7JdTLq7fnNUxs5oUZGJ9NZ5quwwK5agKFiePo4Nyn2+X4zb1jbi?=
 =?us-ascii?Q?Ys1yl0zO+y+2azMJ/qPHtX9vntQa0prRoSreJHUywF3V2l+ktFysWD+1r22G?=
 =?us-ascii?Q?uWV+JTj2tj1usLH3qi7vXfoyUijbfQoEpwYXzHdBeGK17d541PX3zqhSOYdU?=
 =?us-ascii?Q?J0c4NYwTsxncD/zHA4Hmd5/Ot+24VbEwZXqBZOyarJvyG9PfCBFw4jmbN6bI?=
 =?us-ascii?Q?0tmNYGOboXOIUGAiGi8bDiHoQ6HxX+jKivSIdEnAZZiH+QupKha8Mgn/3by1?=
 =?us-ascii?Q?mDZRefIBebtShFr+pUwdXdFpOmQ6l/gNbfmzw7PJtelza5zT7xRsAfrTqGwi?=
 =?us-ascii?Q?Jtg+KGydi98VcYbZXiJHpT4TjMIr50jV8fD8xCB7uoYPsVLVH3RNDapEqZif?=
 =?us-ascii?Q?TmzKwBxHYa0rtghEyr9AGdtgNDvbzk1C3ZHXg32OFOtkOKwRsVwmgM1AYH0P?=
 =?us-ascii?Q?hdFFKWmwwiQIpSjmC7DFGtTK6E43Kp+0RFyZzT2veV34J/SKFqXd/oNkbTLG?=
 =?us-ascii?Q?MDLEhZlYPLrWtrZQviRwkmK1hWBS66PMJuqhfpcob0Xk7l9BrKk/DCoOBZ8s?=
 =?us-ascii?Q?jAx4qZMq22gH+tGQ3T79COu538oGlhAmGgHCnGAvjoZ2ZHHBkavPrB0Lbsk8?=
 =?us-ascii?Q?Z/reRFI39z6XzUNzaEMnDAb+n6n84/kbHNZ9/DJ1h64c5AQkaXBPpczHQH+N?=
 =?us-ascii?Q?wY0Zc5BXyz1xXcTPz9TYa/cdPnNaf6R04qS7RNEcHIApSOaRjUbB9K9LF8ot?=
 =?us-ascii?Q?up3H2Py35BSU/CMMHoTqvl0gpxHzk4+BslqnkBoDgY9MC2L8xx5Cggxfce7w?=
 =?us-ascii?Q?kgzOVxnsH6aU2CCuE2NANC9BPo70cKM0oKzVjfj1hhSZUdjyc6qTWC1OGC4u?=
 =?us-ascii?Q?4KFGxNPRc6cTw4xe6mgPPtY4WD6SVoIUTDJPHjtvuFblTsV/sIoNXwpJjXe4?=
 =?us-ascii?Q?PplLVatC1qlScdh4xJ48Evr79WKnG2EK4SxttDNjRZMzZYWap4z6edspU19H?=
 =?us-ascii?Q?WYkxXI91vsoqweDt2uicBo5v5ejEI8+GQD+Utc4Edser8UqFq2LS86NTs+VH?=
 =?us-ascii?Q?JBuGZSU0gS1gHXkGNX/ssx7EI2EAjdaPVHjM8jM8uo3LQsVtN4BtJSlB0T42?=
 =?us-ascii?Q?mobJY1LNNv4r+qN95/1gc+0fpp6DbK3hUQ+XiqyoF/XKAcrimSxFvtruXSdb?=
 =?us-ascii?Q?BfFkgEo2RnM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 10:42:35.0905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f5e1916-729b-43ad-9d7b-08dcf34f67f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6597

This series adds iommu_paging_domain_alloc_flags() which takes flags to
pass additional details for domain allocation (like domain with PASID
support). Also adjusts core code to handler variuos domain allocations.

Also updates AMD IOMMU driver domain allocation code. With this by
default it will allocate domain with V2 page table for PASID capable
device and v1 page table for rest of the devices.

Thanks everyone who reviewed previous version and provided valuable feedbacks.

This series is based on top of v6.12-rc3.

This is also available at github :
  https://github.com/AMDESE/linux-iommu/tree/iommu_paging_domain_v4

Changes from v3 -> v4:
  - Added Review-by tags
  - Updated Patch3 to handle -EOPNOTSUPP and allocate non-PASID domain
  - Updated amd_iommu_domain_alloc_user() to do flags check first
  - Few other minor fixes based on review comment


V3 : https://lore.kernel.org/linux-iommu/20241017140137.6028-1-vasant.hegde@amd.com/T/#t

Changes from V2 -> v3:
  - Added Review-by tags
  - Fixed warnings reported by 0-DAY CI
  - Added patch to enhance arm_smmu_domain_alloc_user() to support IOMMU_HWPT_ALLOC_PASID flag
  - Added new patch to check GIOSUP/GTSUP
  - Added patch to move V2 page table check to early_amd_iommu_init()
  - Added patch to adjust blocked/identity domain allocation in core layer
  - Dropped "iommu/amd: Add iommu_ops->domain_alloc_paging support"

V2 : https://lore.kernel.org/linux-iommu/20240911101911.6269-1-vasant.hegde@amd.com/T/#t

Changes from v1 -> v2:
  - Rebased on top of iommu/next
  - Split patches into smaller patches
  - Added global static identity domain support

V1 : https://lore.kernel.org/linux-iommu/20240821133554.7405-1-vasant.hegde@amd.com/

RFC v2: https://lore.kernel.org/linux-iommu/fc8715e4-fb44-433b-a42a-7804118ebc57@amd.com/T/#t

RFC v1 : https://lore.kernel.org/linux-iommu/7e249bc6-c578-40f0-aca7-835149a0ad39@amd.com/

Jason Gunthorpe (5):
  iommu: Refactor __iommu_domain_alloc()
  iommu: Introduce iommu_paging_domain_alloc_flags()
  iommu: Add new flag to explictly request PASID capable domain
  iommu: Put domain allocation in __iommu_group_alloc_blocking_domain()
  iommu: Create __iommu_alloc_identity_domain()

Vasant Hegde (7):
  iommu/arm-smmu-v3: Enhance domain_alloc_user() to allocate PASID
    capable domain
  iommu/amd: Add helper function to check GIOSUP/GTSUP
  iommu/amd: Move V2 page table support check to early_amd_iommu_init()
  iommu/amd: Separate page table setup from domain allocation
  iommu/amd: Pass page table type as param to pdom_setup_pgtable()
  iommu/amd: Enhance amd_iommu_domain_alloc_user()
  iommu/amd: Implement global identity domain

 drivers/iommu/amd/amd_iommu.h               |   8 +-
 drivers/iommu/amd/init.c                    |  18 +-
 drivers/iommu/amd/iommu.c                   | 129 +++++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   6 +-
 drivers/iommu/iommu.c                       | 186 ++++++++++++++------
 include/linux/iommu.h                       |  14 +-
 include/uapi/linux/iommufd.h                |   8 +
 7 files changed, 261 insertions(+), 108 deletions(-)

-- 
2.31.1

