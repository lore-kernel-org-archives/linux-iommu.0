Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010043.outbound.protection.outlook.com [52.101.61.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080A3288522
	for <iommu@lists.linux.dev>; Wed, 15 Oct 2025 19:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760557404; cv=fail; b=nnKls5ikaEdGbwKCE6FWGV06RHa2dMQWTvN9vf85/FLT5Uj/srdWm7yxi/sQJ+VADMELxOW+KDnZ3XSBv06sJFZJu+vcBcv+q0pBBtTrrvHmoXYGpXI9vEIkJzQVJsSivJSvVHdZ5HQc+x+E4pC2pyX7XpwEUtqkfP1IObZdWT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760557404; c=relaxed/simple;
	bh=15HXNk4lvcU8ZYDoVCdiq+3+/SDW6xQbrQuqD5y/4OY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TVTaeiAo2snM1nuAGZk774cikayJtEHLtsRjR6UCEcnocNEBrxnPfW5Qb1zHwIU6VMxvZWbAERMkY4EQ+vrYaha5QX5RkbRzFc0Ggf0J8ps4BkdxVZWIY4+VcBseoCw2rVIdskIdU9N56s4AMXisMtExm+Wl6owea1v5EXxHyso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dCbYREyz; arc=fail smtp.client-ip=52.101.61.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dCbYREyz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JdC4ujrAf/gHwfJ/YEaEFe/caml4yXoSUST8H9Sqn8m6K/OhExmGj0MgDUkx/khggNfxzxMLnwS6LlURVkE6SLGamM1HeY2mAmQr1bIz3zr33CLvvSwfX0fCo0j24RyI8zGhv/KgpvdFCEr3LkTl1tv7hMhurGwpM8HQzsAvdxIHNJYNed1K8JJSWCJ73ky5mcUBSPK0vsP52x+O60vj9NRi7pv3C2WTPiowATYlZyl3I3/qRClkwZdR867MvAChpszuHWil1bZdLt8CXWyu0aEeKVkVhst/RVnInDA8JPsIW4vyDcEQOGIylZuBPSW20kulOaMO+imY9M88DhHj+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOzNvI1QfvfagIOvK5yvfRAa7unWIEB2CLMotEda+FU=;
 b=JQXMuee3mJtbm4cIyi1dVKaZ8FNl9W+EZXfZuOMIqYYzKGy6OahP5xURBv1LRWH7++Q5EFr1L7iaGjmqmpHseIKIviaUikfOc9xVUv1tTFmnNxctc43YBseQv98ga7VGNSsx2uXOEpp4BuzsBCNFkVRe9YVPexsvQT/78HXpK/HmxrHUCp9jtmQlgpPy6zcYr8ZRlWXRII5aNQcMBeNyvLOGHV4S9i0pTa4rXWUgj5FDuaChCM/ZsnPVOWkKtzvHzemwP5d+6DraX3sadWF4F93vPNh+dwaSQSyBSwT1H32xBCian28NjJvDixVTeVKkBlYAocgWHCjQFuWehnPNtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOzNvI1QfvfagIOvK5yvfRAa7unWIEB2CLMotEda+FU=;
 b=dCbYREyzMdGBtTWJq/bD8i8Z14SCx4x/0kNXmEPzTulIKcfuGCGYCY6iESHF/zIA0Y61gq3NStQoXI8hB8IUsLgVNelt3fWPT4ZWuFV2HzAKV0U5++BW3uw0mBoVQxt3tCenVava8eN1hmjT98VaWmtM+PTYr5yu2iCl0Up18WL2krzXXPWpgYZEzJd/p38xoHr7N7dXRX2pkK6T+BmYkaBvOX1dF7YJtYf9LgTI2/qpmibGi5ICcDoSxpnb4YB9rPqhb1AG9xZUZfh9aPZ4tN+7E8oswQKK/fU/er5MJanYRy76wOyPuC9L0A744xi9wLnB2+5xuUsX6E8zqB0+sQ==
Received: from BN9PR03CA0797.namprd03.prod.outlook.com (2603:10b6:408:13f::22)
 by IA0PR12MB8983.namprd12.prod.outlook.com (2603:10b6:208:490::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 19:43:18 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:13f:cafe::58) by BN9PR03CA0797.outlook.office365.com
 (2603:10b6:408:13f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Wed,
 15 Oct 2025 19:43:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Wed, 15 Oct 2025 19:43:18 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Wed, 15 Oct
 2025 12:43:01 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Oct
 2025 12:43:01 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Oct 2025 12:43:00 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <jgg@nvidia.com>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<balbirs@nvidia.com>, <miko.lenczewski@arm.com>, <peterz@infradead.org>,
	<kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/7] iommu/arm-smmu-v3: Introduce an RCU-protected invalidation array
Date: Wed, 15 Oct 2025 12:42:45 -0700
Message-ID: <cover.1760555863.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|IA0PR12MB8983:EE_
X-MS-Office365-Filtering-Correlation-Id: 290db740-6d90-4f31-45f4-08de0c2316f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q636Aj92npuXGilsz9FhyK/vt+msQj6KYxbPBb0V4Z8hJXGqYpo6Ywzazal2?=
 =?us-ascii?Q?YexGbP6pGOW55Zd/rOTPCrQnMLrtB+IC2ibM0BVIFuAhG+PMXuLNDYOBtJjN?=
 =?us-ascii?Q?8EXI+daStMwdieiitUNBUm6WOg4Ee2SwCTWNBJWA6NLliupWKu4b1AFewGf9?=
 =?us-ascii?Q?xTQI9xNPClMSla/VlmzzW5CfJcStZcfAoqgU27R4N7AQYRRPtC7piBemOYg4?=
 =?us-ascii?Q?GF8/ncNENccmzz+5cOq0lKWk4OHQ45iHNhCbyEi4o8nf486b7E+r6vJvq3L0?=
 =?us-ascii?Q?Lup9yoZn57gZGqClHOXcDmOSIub1v7GeYucAZkn/QuAB8DojVKd4ctpFYlIb?=
 =?us-ascii?Q?hnNoiYirZQAXTGnN6ViyLWuTA/zuLy0+Z/4G4j21VcsVHleEJrM+/zi6fR9q?=
 =?us-ascii?Q?TC8T5q1+j+MsK+IRo2HsGjCPrdNmu6PcBjpIWVLNJVL21zdIdhVc4u20CsZk?=
 =?us-ascii?Q?0G9Qm0XdDqOnX/AHZxLkPbVVQFf6YK8R7XQfvAf1cttcDXWPI0kKemmWbeUG?=
 =?us-ascii?Q?Rfscev6fEqS1tJwJx7fNymVa/qhnLyb67u7WhkXfQAf7O+UN9dIBvRSAX6dJ?=
 =?us-ascii?Q?1iv/FqZBtz9TKcKG/AtWg3MmhCzEtIAmkSRc8k2pI7xDvTKPwq5ybs1WC3ad?=
 =?us-ascii?Q?wKqAn0WB4wye4Igx4ueFfMggxzewf2TIBSaMFnJFbqwHtEKKfOvkaeae12LC?=
 =?us-ascii?Q?+NQ1r7PMRgSbz47yBde+QTdM7eO7gr00OMIptjDIUCtLEFS0C71U2amO5WU9?=
 =?us-ascii?Q?Iss0Qqdu7vSt60xsN4lRu21dYx6kBa9oITl/oEVF1go8j3n8Ujk1+YzMaiPz?=
 =?us-ascii?Q?Li4mTv248rFkmg2oeSY1un1QZrfdcfkqaa8HOctounQbmVziQ731gYRK9io/?=
 =?us-ascii?Q?7TEJsiaUB9NERFadwzx7BHl3/Fe3/1gdnm2AIKvpYVaGVGekErauI5eo5MJb?=
 =?us-ascii?Q?uBI8i3nPcfgryS9vznN0dKadgyuU4tmEWxV/5Nqbhd7oPnNOe89cdtPnk8GY?=
 =?us-ascii?Q?zWCFEvxrXb4lWynNCgpsU6b7to9yMEaSwikyxom4Zlp1ORL9XVDajrIEXX35?=
 =?us-ascii?Q?p1yIAlAEUz8o9ybR+njyjFtpzGs9PTfwc2AqkUtcNxYiiTEn3TY3NbRXnJmx?=
 =?us-ascii?Q?AdY33TSwupU0VTW0BicKwgnBlLohENqSvclcKAraPhnuAAtZxDANx0sjoBhc?=
 =?us-ascii?Q?R8VZtkwvEQM7a689CcvDrE6MwjL11KtD6D+jEsalEx2GM+CXNyN590jYLXyx?=
 =?us-ascii?Q?f8SXNYuRR4MfPgK5HoedeOCmoHS/Xn9CM6D9InkIENDcxYgpXK1nUkfO3LBk?=
 =?us-ascii?Q?Xmwkk/eZFCcBEPuAiHwq/CvgHBgKxUndgEX7CU9X4FUH1ZPmhIX1tAEJB9/K?=
 =?us-ascii?Q?1Bc3eNTHiGBS+U+73TAHZcKyPICsrYCYqtO2nY3JZN2ztHcQVLmW4i1CaaOB?=
 =?us-ascii?Q?RowR6uQLbO4jBgKIBwFnqkZFnXWBKC5QJYv24kXlUGp2wo+87+LSuJE7K+Vr?=
 =?us-ascii?Q?+GpeZaRmLUx1tr0I35o2EATFf8W+4eJCEGDaCaJ5pqg/p0/JPF/Z/V3tG1h9?=
 =?us-ascii?Q?wSuaTVLkCdTsLvdb/CnhpqRs5rM+Zw/iTflsG8gq?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 19:43:18.0078
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 290db740-6d90-4f31-45f4-08de0c2316f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8983

This is a work based on Jason's design and algorithm. This implementation
follows his initial draft and revising as well.

The new arm_smmu_invs array is an RCU-protected array, mutated when device
attach to the domain, iterated when an invalidation is required for IOPTE
changes in this domain. This keeps the current invalidation efficiency of
a smb_mb() followed by a conditional rwlock replacing the atomic/spinlock
combination.

A new data structure is defined for the array and its entry, representing
invalidation operations, such as S1_ASID, S2_VMID, and ATS. The algorithm
adds and deletes array entries efficiently and also keeps the array sorted
so as to group similar invalidations into batches.

During an invalidation, a new invalidation function iterates domain->invs,
and converts each entry to the corresponding invalidation command(s). This
new function is fully compatible with all the existing use cases, allowing
a simple rework/replacement.

Some races to keep in mind:

1) A domain can be shared across SMMU instances. When an SMMU instance is
   removed, the updated invs array has to be sync-ed via synchronize_rcu()
   to prevent an concurrent invalidation routine that is accessing the old
   array from issuing commands to the removed SMMU instance.

2) When there are concurrent IOPTE changes (followed by invalidations) and
   a domain attachment, the new attachment must not become out of sync at
   the HW level, meaning that an STE store and invalidation array load must
   be sequenced by the CPU's memory model.

3) When an ATS-enabled device attaches to a blocking domain, the core code
   requires a hard fence to ensure all ATS invalidations to the device are
   completed. Relying on RCU alone requires calling synchronize_rcu() that
   can be too slow. Instead, when ATS is in use, hold a conditional rwlock
   till all concurrent invalidations are finished.

Related future work and dependent projects:

 * NVIDIA is building systems with > 10 SMMU instances where > 8 are being
   used concurrently in a single VM. So having 8 copies of an identical S2
   page table is not efficient. Instead, all vSMMU instances should check
   compatibility on a shared S2 iopt, to eliminate 7 copies.

   Previous attempt based on the list/spinlock design:
     iommu/arm-smmu-v3: Allocate vmid per vsmmu instead of s2_parent
     https://lore.kernel.org/all/cover.1744692494.git.nicolinc@nvidia.com/
   now can adopt this invs array, avoiding adding complex lists/locks.

 * The guest support for BTM requires temporarily invalidating two ASIDs
   for a single instance. When it renumbers ASIDs this can now be done via
   the invs array.

 * SVA with multiple devices being used by a single process (NVIDIA today
   has 4-8) sequentially iterates the invalidations through all instances.
   This ignores the HW concurrency available in each instance. It would be
   nice to not spin on each sync but go forward and issue batches to other
   instances also. Reducing to a single SVA domain shared across instances
   is required to look at this.

This is on Github:
https://github.com/nicolinc/iommufd/commits/arm_smmu_invs-v3

Changelog
v3:
 * Add Reviewed/Acked-by from Jason and Balbir
 * Rebase on v6.18-rc1
 * Drop arm_smmu_invs_dbg()
 * Improve kdocs and inline/commit comments
 * Rename arm_smmu_invs_cmp to arm_smmu_inv_cmp
 * Rename arm_smmu_invs_merge_cmp to arm_smmu_invs_cmp
 * Call arm_smmu_invs_flush_iotlb_tags() from arm_smmu_invs_unref()
 * Unconditionally trim the invs->num_invs inside arm_smmu_invs_unref(),
   and simplify arm_smmu_install_old_domain_invs().
v2:
 https://lore.kernel.org/all/cover.1757373449.git.nicolinc@nvidia.com/
 * Rebase on v6.17-rc5
 * Improve kdocs and inline comments
 * Add arm_smmu_invs_dbg() for tracing
 * Use users refcount to replace todel flag
 * Initialize num_invs in arm_smmu_invs_alloc()
 * Add a struct arm_smmu_inv_state to group invs pointers
 * Add in struct arm_smmu_invs two flags (has_ats and old)
 * Rename master->invs to master->build_invs, and sort the array
 * Rework arm_smmu_domain_inv_range() and arm_smmu_invs_end_batch()
 * Copy entries by struct arm_smmu_inv in arm_smmu_master_build_invs()
 * Add arm_smmu_invs_flush_iotlb_tags() for IOTLB flush by last device
 * Rework three invs mutation helpers, and prioritize use the in-place
   mutation for detach
 * Take writer's lock unconditionally but keep it short, and only take
   reader's lock conditionally on a has_ats flag
v1:
 https://lore.kernel.org/all/cover.1755131672.git.nicolinc@nvidia.com/

Thanks
Nicolin

Jason Gunthorpe (1):
  iommu/arm-smmu-v3: Introduce a per-domain arm_smmu_invs array

Nicolin Chen (6):
  iommu/arm-smmu-v3: Explicitly set smmu_domain->stage for SVA
  iommu/arm-smmu-v3: Add an inline arm_smmu_domain_free()
  iommu/arm-smmu-v3: Pre-allocate a per-master invalidation array
  iommu/arm-smmu-v3: Populate smmu_domain->invs when attaching masters
  iommu/arm-smmu-v3: Add arm_smmu_invs based arm_smmu_domain_inv_range()
  iommu/arm-smmu-v3: Perform per-domain invalidations using
    arm_smmu_invs

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 135 ++-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  32 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  |  93 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 839 +++++++++++++++---
 4 files changed, 924 insertions(+), 175 deletions(-)

-- 
2.43.0

