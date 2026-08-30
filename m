Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011017.outbound.protection.outlook.com [52.101.62.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C119433F8BC
	for <iommu@lists.linux.dev>; Sun, 30 Aug 2026 22:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788128851; cv=fail; b=mULjWZGF7FAEzfGBKjfjMnBcoFncYybQ8ku1FbkACqn+SitMfl0FK2xp1nf4LWFpelIdzgXFVwgWOKWYaup4PcnBP1ygk7D50j+RLB9z7Z6sRCT4XxLhBLltmujzn+Row9L8C0vEZ16BUmKegdVwoufcu6BDyo2H+WChWb6o3Vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788128851; c=relaxed/simple;
	bh=snYZNgV++t6IOfzYO1ZGBA+HjrMNakLdUkCQOSnkKv4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cNj8qHHoyzA3VHEWjyxWCJkrEIhfJTm/ykHuP/XMdeWlL1F44I/YtwrfP939z9ICVmcKwjGRKTM+zddv5cTlIjb3OqnevcaDvCqWYsObnKdVZDfjmM3eV6ZiZ2erY56mgObUS+uCr2xnjkK/05g8kng9PNglrTGg4c8pNUhMbw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jBYCspxK; arc=fail smtp.client-ip=52.101.62.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jBYCspxK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pdVy6ON6Heg/0I3ScxXHcAXRsdaJE0INB0PDHTk9S5hmtxBOWwr9ud8IXQi8vlT71T2FKyY9QWBFSI+G5wV5NLdt4Ri0dlQ/MDgiobGJGM1pONd6ynSDMUlDiehyDopRG2HltZHO17kbpK6QpVGQHtC+9la7GhwrAzWXM0BDC/fGWth8iF834CV4OD0wp3HLDoany+vTMgsWfONmaUCkylE0qjHO2jeyTGH1xMQi1YUllQ3MCo6QjEZNorReLeBIN0s7qxfQcgjRFcaSFAT7jWrk+EQg1eMhYkdQ/4SRdeGQIAm/BD8/Wmlmtf8chjH6jUHtY8yYCZBUONLH+TqFCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2T6mBFNEAUZcXJM4qMp2b9R09tZf0ScPg4e8GV0TWFY=;
 b=ZP/+0sRGqkwJatztUGwibLx8kPs3u3K71ENROl2h/UJW3bqXIG9lMM30ukENQRFu989+ejP34gxidj5HIVbVZ42mgkUgsG7+pO2j4qItfo0nDMr2lbuGjjJ+8ZPUuntbDRoPRgxp6NyAEzdq5+X5i60efjXXYQp9U7zHNHC4M0sJ1cOJTJsqC6ZzJUSD5gj9sc/GQ5CpwBSEXeLPK4SVG7bSqho+SWhxjKsAMixSIKmDXagUPa+eEBs3oLBxvHV35ZuUr89t68BQV+NM1/xUc2/jvJ2zcXEmyz7yB3iG1pETptd+DKuof3RnVUawCzk/82N7lnPGU9dyDwEwBlad3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2T6mBFNEAUZcXJM4qMp2b9R09tZf0ScPg4e8GV0TWFY=;
 b=jBYCspxKo4G9ZtRvWo66+mraFqlveQoL2kY5+wRfutrIj4AL8rEdIcl+NPTJPGshRj0BT0fgPKZKE2jI2IgTgSQTBwxbb1hgQrd0VAc3PTtufC4TPloqygl8G/Icvz6564eW2PVgpFtjXCOwnj/VBBhOx0HkVfcMgcj9T8TwK7300UQD12Rw1ZAV8mhQRSiB6RIfGOr3f0n41+TJ4l+eFAO9qLu8nCtYRnFLLRNwAQqfSFC/alYSq8wFqISewJVoqdgP0RA4zWXcOBUttUY9QXOYDViwAIAzBVdP5P94Tjlz07U6ehVCmbXCejSPwBzXxiEwpNBS/WDly7hLpNhuQg==
Received: from CH0PR03CA0299.namprd03.prod.outlook.com (2603:10b6:610:e6::34)
 by DM6PR12MB4060.namprd12.prod.outlook.com (2603:10b6:5:216::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 30 Aug
 2026 22:27:24 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::48) by CH0PR03CA0299.outlook.office365.com
 (2603:10b6:610:e6::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Sun,
 30 Aug 2026 22:27:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Sun, 30 Aug 2026 22:27:23 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 30 Aug
 2026 15:27:15 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 30 Aug 2026 15:27:14 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Sun, 30 Aug 2026 15:27:14 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
CC: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, Kevin Tian
	<kevin.tian@intel.com>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Pranjal Shrivastava
	<praan@google.com>
Subject: [PATCH v6 0/5] iommufd: Iterate the cache invalidation array in the core
Date: Sun, 30 Aug 2026 15:26:37 -0700
Message-ID: <cover.1788127877.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|DM6PR12MB4060:EE_
X-MS-Office365-Filtering-Correlation-Id: ccbd1cc0-f760-48d7-e925-08df06e5dd4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|7416014|376014|6133799003|18002099003|13003099007|56012099006|3023799007|11063799006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info:
	ACsPOf8xumtJ0+/9Mz3Y7x99hiXHJG7Xl/UCzi7wtx4P1EPDgdGN5HUJYHPiA1uKIpPE6WLoMVBIeMPsiSC13gYzmu1AQrWAGQlO3htAyyJ8pkOuXL6PJFBjSIJHhd5VZrsymiMizGjoDn1Aapy3hKraJNuyWdcKzFd81BXRcBbATGwnw3RXXpPPRdvbrAB/nIM9lYHUaZ0PFz1dA406r+FcZHCVbBBoFhFh987FgV6QYbDcB2BNMRLy64HtcsUYEx2QzzN1wqEhLuUxRPlDP2Hp6V6Zf9+xF7K2xVBYcvZAWCxXkixI107NdoIwwF6f5ECFlSCe0czTZb7+HJWERuamP8IacKDIuJQWuJ6JkY3/ooLZGnhOioAnzmEACDBRBymxZUapncnsPwPGJTA78MdeBUXWpdTYdPAgNSDsljHd43mFVbWNd0qBclbMLC1WiO5ycTm+qNwGqLAOb3KbvD6s16B/iJmkENtE/z5LXXruMNdiaXFsZ19LwOIgoGitVrg1VV3h/IyFregwscIZNKBmgkDjF41GwQMkwohgHNPza2o0U3NVJytodIAVwzXT7gRe/7lItEztMcntWkWE2rE4Z6dqcre022jUFMaW37YDR5SY9G9EZ2Jf2GtVHnc52RFL34IoORy6nU/ChJJ8y2O0EoJ1kVelzYjTg4pIfXScC7R4oqoapAEK6FWz+G8X5FYv29dX7Fvlo/ETd4t2rw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(7416014)(376014)(6133799003)(18002099003)(13003099007)(56012099006)(3023799007)(11063799006)(5023799004)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ja77Hojq824P/VPXaKf2Vb6+HAJmNzX3fZQXAa6EYPHM93hq6Zyc229Qx/KKQTyJy/00fm728pHTBbL6otFFJgXPI/A2k8o5pfJsFxazdOmH0yyZmMfvG/2g6Gh/1Zc5Amlumog51LRqVdzna/KTqvopbBqmNacBmQT85OO72uWkjVaUwcl6rArj0UsMqZSaxIHgqvjO1F5ZuPMtrF0JyfeIbwZ6QFTQK1WEfmFwHwmOa7yrzT1a3aNVt9E7x9comk4qF2vtB20rM56PzrNDf/ii99JbFJ+7hdR7nHTDiJFQedn4AJFwNmTbEnsEZ0w3aU99fvli1m961tdf7JqDU0olXQ9PPMlUUtd7zVvLFl0x27p/wqkwVhPozZMSInihnlPQFMtXEkSsNqsQuDqlepyTEsbMAlta5NkvP9yK02N0fdCxwrj0VcQlMusftdHO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 22:27:23.8478
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccbd1cc0-f760-48d7-e925-08df06e5dd4b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4060

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
https://github.com/nicolinc/iommufd/commits/iommufd_invalidation_loop-v6

Changelog
v6
 * Rebase on top of v7.3-rc1
 * Drop the merged IDR5.DS patch
v5
 https://lore.kernel.org/all/cover.1785258826.git.nicolinc@nvidia.com/
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
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 197 ++++++++++++++----
 drivers/iommu/intel/nested.c                  |  54 ++---
 drivers/iommu/iommufd/hw_pagetable.c          |  25 ++-
 drivers/iommu/iommufd/selftest.c              | 147 +++++++------
 7 files changed, 282 insertions(+), 153 deletions(-)


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.43.0

