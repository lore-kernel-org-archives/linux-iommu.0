Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011015.outbound.protection.outlook.com [40.93.194.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05AD3AFCF8
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 18:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783363669; cv=fail; b=fievnFgf1wQw1kBft6lx1EEGr+I7hK4QkxO0d8GOaSCvpx0Vu1d+/Cl32ZALWz9CqKvJjRiy3mr7mEuWZnVI7g/2nvp1jzRHONHyjotdXaTn8WJqG5ZxFUF5JEeTrv5FVQi6hwsbpEd5mXQmtoSzuzeZ1fpTHvKpdofIKgCbjAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783363669; c=relaxed/simple;
	bh=oDyzxl5nUefOyPKPtssHPEXos3Ni1UyrGn95Du/pfwM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r/dM5SVjNS5/nDx3NAfMRMvhzB+zooS7OnNhVkE4qr+sxbJH6XUU9Vd6nKmO3g/PVjLzG48+gVPiVd6bts55gZd0ikpueQIVPWiuBUEBzfBbET31o9LHWXlSBRfH+K7Czy/mXJYFz6Td7/hlYzmfJqGxqAM351rFnldYy6tz18o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JUArA6G4; arc=fail smtp.client-ip=40.93.194.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JUArA6G4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0jUoUQpgsV1EnKAD4Wnow4VRitN8fT/xnFHE4lxZucFyY6+Laa6CX1Ve/z/lh1kd1LHyO61VIgAHkj4Z1QEQ4ySPx6V8OuZ4O6gAn/ENKZVSH/0AVWBXIm5PruMYGZZypx9b4+WSCIoBs3yEclA/Ya588HlscqihUCny4nJbajLC99Ux2qsojE5xkyzOAvYjSwWLNS+ab2eXw/Opx3AgMl1V1/brd0fFWT7YDXgO+E1CkaL9112ntU9aE/yqAF6LU+uNOa6Xv8HkVC/x81m56BrXHnYc5YJY1mKWFGTej/f3pQz1b5JxxtgVm6+onx9mLE3vCJhOT7Z9OGILJNsWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRR+nEOqFxFJJ3rOjUGVz4gcfeUWVPGDVtzaYrhoq90=;
 b=vPgyTv2dJDzl7DT5TlAGVPfxXvNXQfhIUH4KDYOphypCaWoyyDJ2mE0hJ9mmvRMCQuBSWdpX0AXxO220j+ATXG74/yS3LITcUFC6UwObD+SUYt9zGCN4v3AXEJfxWpYP1Ka6eHn7zEUF4WATHfZL7ZYrsHgu8/4Py/SQ0giHM2nnYudTBjUeRR6N1t4ypbQnTUiWknjb/BteRoF6T5z/GVXWKG9LB1FQvzaPdyhq87CgfXKjdEKFvBpM7pGp9aJjuDnamS6S0j7tM5k8/dtO0CC0uyeWAe8ZTKN10QFDJcSjpAE0bZo8cG+F5T83RqvsHXIY/gYmgscZ/mFzPfsy9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRR+nEOqFxFJJ3rOjUGVz4gcfeUWVPGDVtzaYrhoq90=;
 b=JUArA6G48MXGcmOX7Ilxl1ZkSvsUgIEH6AEvADv10EWp46C6IvKk3G2M6SDL8HY40Ye7DBQM05GCxNanVy5TdkXnXvng1Xkk0pg8APUS8F9BNoP9JkDhUugLbLyGSxqmwLw7pTYnW9I1oP0NHaGB3TLOm8ZxGb7awj57jzhK/ZbTXIV0Caw762FQ3cgdosOZMwgFZn2zNHvUcOY8Eukl4dlzRutjCuGUJFsleh4eDtI4J8Ozo10Qi1ikjIjT9Idspv7EfwGRR891MlKHrluwSrPKBu0zHzzTRSRXM0ZCe9ahIjbPSi0oLRzWnoUYfuCuNE5clyVmtm8gHFOA4ZCKLA==
Received: from CY5PR19CA0086.namprd19.prod.outlook.com (2603:10b6:930:83::11)
 by BN7PPFA8145BD40.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6de) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 18:47:31 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:83:cafe::6d) by CY5PR19CA0086.outlook.office365.com
 (2603:10b6:930:83::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 18:47:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 18:47:30 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 11:47:09 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 6 Jul 2026 11:47:09 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 6 Jul 2026 11:47:09 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, "Kevin
 Tian" <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>
CC: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, David Woodhouse
	<dwmw2@infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/5] iommufd: Iterate the cache invalidation array in the core
Date: Mon, 6 Jul 2026 11:46:50 -0700
Message-ID: <cover.1783363477.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|BN7PPFA8145BD40:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cb51e9a-241b-495b-e499-08dedb8f08cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|11063799006|5023799004|56012099006|18002099003|3023799007|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	AeF5W54swNunUnH4NPK9wmor9jAjTJZw8IZ8S73L9gYVkkNARJ9VIYYP/47y0N5SrEagJcVqkFc7wWXr9tSmAWih0gn2tIngVgyzqLTE3Xo5pVZt0ZQQWBEbxZLJ6xkiHrBlgjq1Q4oGumq7okjRMbAL2JyDgH6X2QslBsoo4K+fGJL/kConmuaCuviihZ96eOJC9CLeGUTxuDBXiyqnBKK5TmKrQJw+nFjl+VTiq2gEJ8k6z29MVFAe9L1k/XJK+wG+N/n2nENWwMnaP7XXt981cUpO86J+PTuZHH4/Blfh/RYqOQtWJuEUjTC97uSGcYmmevsYfxoy8iIEi2YUg0velw0pq1oFsbJpe2JfFHZGgKdwXrl9fCyT1D/MAEg0pcL6tVN5A2F0Evgs7gGepGo6nUKRfrZv3JL7kEy6Zo6YMM9lqtHhprpFJLv/ZeUdKCjQnYoDceaYV8mHGzyyoNJt3nkmbtDAOP6OJilLEothQo2QJmFcCJP/IL+PoNKDaV0PaLTY6TO+4vt4N+Jhlhex78UyqAguwGOOQGt2N8pR+aUzpVGmapbRmWgLg+g+yTJHwivg4STzLIiGkzMFt/g7TfQWnnP4bFGzs5kXclkFFSGOJ6em185d91zwELA30RX6T3/fb+vQ2Yzg1M/At+MVP2UnZPhpO1o6PCiCpWijNixqNkTu0jFISCcvX+M0QYUJaaJ8vul9OHbrAOlA9g==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(11063799006)(5023799004)(56012099006)(18002099003)(3023799007)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mv6UQFX0WpDHe1L/wM0bKnekp8fZyfoXqIhpIr2//OlwrXRGRSqQ3g8/r6EroFLnhc5q6wUrVFwUwWl4gJxhD7OpyRHauY55K1oOpqaw6yVlm07vuwig0ijxQe4yntTPoe8O3J3Gb5kAW1uRmp9NOjYBOwSFaMVWoXApl3o4piqrUuQkdiN1v6s83GTc0/84vsTNKPQ29wZ0sULjwESyw3jbjk+4oiVheGSmFJh0nOm1YGd+bcf58UBMirptJM0rHMKAZqg8zvK3B1iZdjbm8Fz0N6mk7gGPRAXELx7ByZt1X8ZHGlaYdV8DryChNUkoHsz1732cN/CGBVEu16tKG+mtIYzNbDcttAz2N7Yp87bbuS44JIufQ5vqIc/hagDPDYdKJDMKyHZi9MLdXugGv9U8eFO2RAwTe1tOhLOcE5G0h4G9npDIPVM9oyu3Wmyk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 18:47:30.6421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb51e9a-241b-495b-e499-08dedb8f08cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFA8145BD40

The vIOMMU cache_invalidate() and the nested-HWPT cache_invalidate_user()
ops are each handed the full user invalidation array and must report, via
array->entry_num, how many of its entries they handled. That makes every
driver open-code the same array walk, with real downsides:

 - each driver carries its own loop and sub-array bookkeeping;
 - the ARM SMMUv3 driver allocates a buffer sized to the whole array just
   to iterate over it;
 - hand-rolling the loop left the ARM SMMUv3 driver with two long-standing
   bugs:
    1) on a conversion failure it counts commands that it converted but
       never issued, so user space skips invalidations that never reached
       the cmdq;
    2) it rejects a zero-length array, which the uAPI documents as a valid
       request that only probes the data type.

The walk is identical for every driver, so move it into the iommufd core.

The core now drives the iteration:

 - it invokes the op on a sub-array starting at the first not-yet-handled
   entry;
 - the op handles one chunk from the front of that sub-array and reports
   the count via array->entry_num;
 - the core advances and re-invokes until the whole array is consumed or
   the op returns an error.

A driver then only has to handle one bounded chunk per call, e.g. the ARM
SMMUv3 op copies a single cmdq batch into a fixed on-stack buffer and drops
its whole-array allocation. An op still handling the entire array in one
call keeps working, so each driver converts independently.

These are long-standing corner cases, so this targets for-next, not for-rc.

This is on Github:
https://github.com/nicolinc/iommufd/commits/iommufd_invalidation_loop-v2

[Note to Jason and Will]
This has some conflicts with Ashish's ARM_SMMU_OPT_REPEAT_TLBI_CFGI series:
https://lore.kernel.org/all/20260609073204.1760077-1-amhetre@nvidia.com/

Changelog
v2
 * Add "Reviewed-by" from Kevin to patches 2-5
 * Patch-1: Allow the ATC_INV Global bit gated on ssid_bits, correcting
   the wrong every-device claim: per the spec it only broadens a single
   device's invalidation across its PASIDs
 * Patch-1: Move the FEAT_ATS check into the allowlist switch
 * Patch-1: Gate the TTL range field on FEAT_RANGE_INV too
 * Patch-1: Accept only asid_bits of the ASID field
 * Patch-1: Reject Reserved range field value combinations
 * Patch-1: Reject an ATC_INV Size above 52
 * Patch-1: Add local smmu and data variables to simplify the long lines
 * Patch-1: Document the valid-command contract in the uAPI header
 * Patch-1: Note that unchecked out-of-range values are UNPREDICTABLE
 * Patch-1: Note that SSID/Global are IGNORED, not RES0, when SSV == 0
 * Patch-2: Consolidate the two invalidation loops into one
 * Patch-2: Multiply by the size_t entry_len to avoid a u32 overflow
 * Patch-3/5: Return 0 directly on a zero-length array
 * Patch-4: Use a processed counter and an out label like the mock driver
v1
 https://lore.kernel.org/all/cover.1782767398.git.nicolinc@nvidia.com/

Nicolin Chen (5):
  iommu/arm-smmu-v3-iommufd: Reject unsupported bits in invalidation
    commands
  iommufd: Iterate the cache invalidation array in the core
  iommufd/selftest: Convert cache invalidation mocks to the core array
    loop
  iommu/arm-smmu-v3-iommufd: Convert cache invalidation to the core
    array loop
  iommu/vt-d: Convert nested cache invalidation to the core array loop

 include/linux/iommu.h                         |   6 +-
 include/linux/iommufd.h                       |   2 +
 include/uapi/linux/iommufd.h                  |   4 +-
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 179 ++++++++++++++----
 drivers/iommu/intel/nested.c                  |  54 +++---
 drivers/iommu/iommufd/hw_pagetable.c          |  25 ++-
 drivers/iommu/iommufd/selftest.c              | 147 +++++++-------
 7 files changed, 264 insertions(+), 153 deletions(-)

-- 
2.43.0

