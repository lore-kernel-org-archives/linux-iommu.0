Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012045.outbound.protection.outlook.com [52.101.43.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8B2332EAD
	for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 17:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785260058; cv=fail; b=dircQeN30N0TJJYVC2yqk6McjYMaiQeFT4H7mIlMAwqL75AFzWaA0lkJkmtTEU5ZmKv+x2hcVvAXf0l6WCtNEdvGgzY7ydkm6MccUPYVeOa/m5EV40PBWyM6d8x8PKsOSD8eFJSbDbZnoMiQI3erIkd8zes2IhfmQvFEN/iU0oQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785260058; c=relaxed/simple;
	bh=ml+4xuSWkrwJrmIuvgsggTfvDRYKnMfZlOAxCgs1lfY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y0qKVDBhtWYETi4enmtiabR0yQqmyB7S7iVDTx5MD8vtKV9Uta2qBMsP6s2Y3sI4/U+4ZxNujHN87if7g4loT8ZBr2NAVuuaoU/BtaYb1aWdeXVooJCbaKdtwXNz92YMxgFw8YDyH8ac384ygHMARoScdAFFUSHzmyhmR+prAvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hIrC+tCn; arc=fail smtp.client-ip=52.101.43.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hIrC+tCn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PgHyjB2gcCluxt7Btrnmb2MFpFMBPpJzCeHMGmOFtb9/OdV5zoNYOXhn/9+dErEBhnS/QMqAKZReGGEghkIpdhxxIRkW8d+gyCVB16VSo2f79Y4io6t1IVCrAh8SEm8S9mtDHzK/meGtPHxK0bf53YoYs/M/TBM1cgOwBt4Vay/OWKvHGY6zcPskjV/2JoSbxHyV3PpZtpPCnz/njYYt8C+ParsqR6o5UrUbDe4iABGXtggfLe63BFWHmhAAuRNSN0GN0TtIpqBnqkCYh/FizFArWpkY5Bvk6aWabFcZ5L5XSiGCFmHw+fK2l1X78Hl3UcE/Rn5qBiEEGerf47DXNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4ouknJ6ouyObU/Wmuf/u96aJ0ihFHT18F8q5urg/Lw=;
 b=u/zwCbYPXqYMlgAs8GzqgTFT+tyk1CL7VuxQlTXkRok9yQ764tSj13cFIuCOIBcMOBhgz33H9hlh4EQ1jj8DfyQ1nqoYvozuVQKFEn6NYNxiV+IyFbRpJlTDC9Uv5GlmCrOYY0CvDPPNwpMHg7LylWMEoP3ZkvtjBl0PhQfZs+sM/z8vp0i4/TzpQTCA1C5O7BrQpelvbjpEhW7YiSMkW2OuuOzF1wYa0UY6dMnJHSi59ngiwky0Ra4QACzDUjXtDRkFfXNSAlswlcUvk5zcRdOpPQm4mzFF/2JOz0ARKrS6w9728xEBze4kd38xe2bgH8MiuT9bI27Au2854oHrLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4ouknJ6ouyObU/Wmuf/u96aJ0ihFHT18F8q5urg/Lw=;
 b=hIrC+tCnwYkcQvRuWFAcKZes+4fO9ZaG0swUvn0hC5bqv4OBvvWg2w0EpqT9WWIkafJB2j7MlTuLde2I4jXMnmjDQ/EzggXGBXCXS6qFYhgiHlhvm0ORzjX4OLk10IothTQ2ZVMyj2LYQBth7s0rNi+Vx4/eGMWLTOsyQxh+p2/jqXawQRZnrKcfZNVA2cNmz5fq7+EvDWWVQ04N2QTrqWv7yxk0nh37RKR7EDaLjezxx/lM0t4n/CL0YiBmjxlOTckMGcsi/dpXjXLHkilkUR1caf+0VIeYg4skh6sIYMSidRc3m9Py9C08ZM4vS34+yRkaq6dLkTMHmQwzkvJ95Q==
Received: from DS1PR07CA0019.namprd07.prod.outlook.com (2603:10b6:8:44d::10)
 by DS7PR12MB9525.namprd12.prod.outlook.com (2603:10b6:8:251::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 17:34:07 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:8:44d:cafe::94) by DS1PR07CA0019.outlook.office365.com
 (2603:10b6:8:44d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Tue,
 28 Jul 2026 17:34:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 17:34:07 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 28 Jul
 2026 10:33:45 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Jul
 2026 10:33:45 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 28 Jul 2026 10:33:44 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
CC: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, Kevin Tian
	<kevin.tian@intel.com>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Pranjal Shrivastava
	<praan@google.com>
Subject: [PATCH v5 0/6] iommufd: Iterate the cache invalidation array in the core
Date: Tue, 28 Jul 2026 10:33:32 -0700
Message-ID: <cover.1785258826.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|DS7PR12MB9525:EE_
X-MS-Office365-Filtering-Correlation-Id: 961779af-b158-4e55-5e71-08deecce6d64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|7416014|376014|36860700016|56012099006|5023799004|11063799006|10067099003|6133799003|18002099003|3023799007|13003099007;
X-Microsoft-Antispam-Message-Info:
	cqjTbUYC1lR+7oT6djks0bUiXFdrHmNVP4Q6hM8YqCgmZ+QNAbbHyG/ZTclPmLgiPOsRTXbO1oS4aw4QBvLcwayGW/7LD+OBzoEZHJFwXPkeyhxg/0NUCuarMqrAiGlN57jgacwciKmm1WzN89sdYpsqHU0jIcGGB7GD0/NrWEm7H9g0CVd76X8E39660pTKk6r6fBeLfPBNTf4c2t42gyxf5FnXf5gSaCw/Wjsrg7cHsHhruB1jK3obqk050UVc1iz/1WNSksbgsWXl+UDvb9J8WOnAqjbr2lgPQPaHLfdFOX92P9HkYQgjMBjyrOzdx1m/KaDQDwA6P7xSHHf/ZzxRYqEdgZY2jPZ2xpurulA+/95yLTOpU8Q2THrN2h+YRcwtVcg7liY2/dHJcTzjRw404yNoudcf3MBPcCoJ31pkFjPbQSq5+bHYEFEqb/kK95sKMx8co0QIzsjMMIyYz5x0fxfRroASgtK7bux9S9CiRhp31Hbekv5r8JQ7QAxdCUhzVmRvnfxGNqTEBAmHucHRnoRsSxcD4unaAZKkYBng3+G9jqZUHSGmEjWkleVjTa1sWsin71ekl7xGlAf7VgmBeBMbNF3XZjE5jvB9h4Te6NCAiNKT9tE3rzZhKIRi4NzlbdfSBbIfcUeGqWiR33g+xxnuxsdRcrN1aVUMQzUU7uiGGyDWhTPiLbJciEYDAEwmzVTtvwa8HeoHr1T9wA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(7416014)(376014)(36860700016)(56012099006)(5023799004)(11063799006)(10067099003)(6133799003)(18002099003)(3023799007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Gx6qzoqvPExTM8SkRIr3Raw/i2/gYQEND+NJiZVNLQg8GzQR6PnZRg6ZFTUeP6wKnOeXlFn4MIeHY5TLuSODDLcVFdb3fNXdyAF9hMoD3dQu7oMIzlgpH2iY3QHBNT1Gv/owiGQvZbSkZNjK2rnJkksJB2uoznDdTp+Kgu7dvgQkWnx8Ynd9yBAL/MwPayU6giCVMlKDZjgAurysF4fO8ewE49CWFGhiXVfJ+EYzLvVgz5VtqgyY0A4ySfB1MRKzEVgV3K4DhaPEA9yCUb9u3I9reyOmjDmLxTEFWL5Di1cp49zIhfMnaGBg+kBnUXjsP92oYIw8I7/yhUkuzeluoPn3gUYS2f/zKQZVg/wNm1JzR9pa5r6mGfns8GfFsL3Kr0frLbZ7+qAcnF9Umiwn85o+5Zvprcawt/5WhwDBcdeI7fOCsQidrHfBpIKw/aTP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 17:34:07.4467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 961779af-b158-4e55-5e71-08deecce6d64
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9525

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

All the bugs fixed here are long-standing ones rather than regressions in
this cycle, so the series targets for-next, not for-rc. The stable tag on
the second patch takes care of the backport.

This is on Github:
https://github.com/nicolinc/iommufd/commits/iommufd_invalidation_loop-v5

[Note to Jason and Will]
This is based on the arm/smmu/updates branch, which integrates Ashish's
CFGI/TLBI-repeat series. I've run Sashiko locally: v5 is still clean.

Changelog
v5
 * Rebase on top of arm/smmu/updates branch
 * Add "Reviewed-by" from Jason and Pranjal
 * Patch-1: Drop the Fixes and Cc stable tags
 * Patch-2: Reject an unsupported opcode in the validation helper
 * Patch-2: Add an explicit NSNH_ALL case to the allowlist switch
v4
 https://lore.kernel.org/all/cover.1784054606.git.nicolinc@nvidia.com/
 * Add "Reviewed-by" from Baolu and Pranjal
 * Split the DS support out of the reject patch into a new patch-1,
   also listing DS in the iommu_hw_info_arm_smmuv3 kdoc
 * Patch-2: Add "!!" to the bool range assignment
 * Patch-2: Factor the allowlist into arm_vsmmu_validate_user_cmd()
v3
 https://lore.kernel.org/all/cover.1783539724.git.nicolinc@nvidia.com/
 * Patch-1: Add a minimal FEAT_DS detection and allow the two DS-only
   range encodings on a DS-capable SMMU
 * Patch-1: Mask the host's scale value to keep its 5-bit truncation
v2
 https://lore.kernel.org/all/cover.1783363477.git.nicolinc@nvidia.com/
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

Nicolin Chen (6):
  iommu/arm-smmu-v3: Support IDR5.DS and widen the TLBI SCALE field
  iommu/arm-smmu-v3-iommufd: Reject unsupported bits in invalidation
    commands
  iommufd: Iterate the cache invalidation array in the core
  iommufd/selftest: Convert cache invalidation mocks to the core array
    loop
  iommu/arm-smmu-v3-iommufd: Convert cache invalidation to the core
    array loop
  iommu/vt-d: Convert nested cache invalidation to the core array loop

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   4 +-
 include/linux/iommu.h                         |   6 +-
 include/linux/iommufd.h                       |   2 +
 include/uapi/linux/iommufd.h                  |   8 +-
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 197 ++++++++++++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   6 +-
 drivers/iommu/intel/nested.c                  |  54 ++---
 drivers/iommu/iommufd/hw_pagetable.c          |  25 ++-
 drivers/iommu/iommufd/selftest.c              | 147 +++++++------
 9 files changed, 292 insertions(+), 157 deletions(-)


base-commit: a86c36163c9722545d27e92bdad8418fdcaa8b1d
-- 
2.43.0

