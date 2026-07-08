Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013067.outbound.protection.outlook.com [40.93.196.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC2B3C9EF1
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 19:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783539894; cv=fail; b=sJwCraI/ryQOfvYiCXqszrzoOtkB0lFeon/LkFNe1TUOe5zB7eX4h0c5/q25p8At//iBqli+dtvnJYquaCv/f3Tj8Ot1otCB6peXssjJPuvSMljV+ifDJiAA2R7OyX7SOhAqfieyJ8HFnQNEWLvwsEzdwB0vmePcmVcWc8vnckg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783539894; c=relaxed/simple;
	bh=hxQAhs3gi5Fo9oudRu1HYYOuTtbJwf+1eWkUo4BINGc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oOkDd8Ax1sKYh+unXdJCrZniyCrjM/UcGPmy9qPLZ2EtrXlW2E/faNxXgyerdUAGfYEX05pg6YFl3jjmrOE9kXnism+TB2grij4A/tRBQRbwGYAzkhD1zy+VDIzRkuGu/sTXxEX+/yeWuf7EAVXvU6t9fWFBZOtzbR3HrMt5tuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OqfseUjH; arc=fail smtp.client-ip=40.93.196.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OqfseUjH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QK4ek/0f3PkEpIbpCPikq3GZ463AzIUVgnegeROwpIim5zux2HuQTcFrKLfUsuHvJ+K0lSOEJ9W3X+oueOpIfLNfrMhVTeEtthXp9aiYd8fQDaMxp2fktIxhoi52ITrLQ7yZFby1OY/OM3blAIOG6kAwxWHIBkNtU+b0SdmxJ6tWTyvrzBjWsSh4aJ9bebDi6Nf0GuFJiiopq/fqx/wYNLON7r8Ef8ugwsdLFRBUNWsKhwVqMKkSotaO/vt2rhTHjLGfy9kAAB5xsoA3jdrfWGPxjQLwr48q/5BIjOP0ek1LOT/+K2l/i9zwzxulfyiCKXmqf3AZSDij+RjsRQifgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZBoTcs3ezYbPSytzS3l8XD2Fl6Xu8nUOkkFEWLyLRk=;
 b=TIG1miTm2zFEx7YIQTER+snuhsoiFjW6m41ZzwRbalO3rOj5g/Sa5/qdJHu7DBnBkQswJ+QQ0hTva2Fy+qlwAWYypCP3hVwaDhf0LIXWZAobuWjhRR/UkSvQjsCxrTrCOYULML4fshavY2pm81Yu0zFDk7xdwqRrFK1NQMimbGkmSVUcFc5DgR7HpniFBxtQqFt14tIdJBs3fIuhTjiTk14Vo8+FBDP+Er+0KExgQb8j2eN4iWYIPWfFtDpaJz9gNixYjUT8Qnx0jj57JS1k1vBQxo6+B8xpU4DZW1bpWFQkUIrwDv577eh23km15FRgLOhCSsMuhShz38ggGmIt5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZBoTcs3ezYbPSytzS3l8XD2Fl6Xu8nUOkkFEWLyLRk=;
 b=OqfseUjHl5AP0l8Nb4RP4v7mLfDCWagESlZMy3C5hZtqFnq7dIz8z0U7c+YrVI7lEysRCVTOu/kCSXvJwjSDRnT3IKchYB4z4edDaTRDukyag6zMtTiN/oW4TBjF4ULkZlPS6TeX6Wwi7264dpl9QP0ZJOmkhv5z/BB1TNZM3MAGHQpmXGgS0bGRVwb7xfi7C3ZUw702QNktj+kUrIRUc0ZR0Xqa0x0belQHO2WNeMQC2goErfhPwHITyerv4qOr/rdOQNH8l+FQw9Bm3EdliWDwuVisc7ubk//X3TlnfU1XKynFiHMy1e4DR6tf781abYP573LJXmSTbZ4rKgYobA==
Received: from SJ2PR07CA0003.namprd07.prod.outlook.com (2603:10b6:a03:505::26)
 by DSVPR12MB999173.namprd12.prod.outlook.com (2603:10b6:8:38a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 19:44:47 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::18) by SJ2PR07CA0003.outlook.office365.com
 (2603:10b6:a03:505::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 19:44:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 19:44:47 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 8 Jul
 2026 12:44:38 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 8 Jul 2026 12:44:37 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 8 Jul 2026 12:44:36 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, "Kevin
 Tian" <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>
CC: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, David Woodhouse
	<dwmw2@infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/5] iommufd: Iterate the cache invalidation array in the core
Date: Wed, 8 Jul 2026 12:44:15 -0700
Message-ID: <cover.1783539724.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|DSVPR12MB999173:EE_
X-MS-Office365-Filtering-Correlation-Id: e060b27a-b367-403f-203e-08dedd295e08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|3023799007|6133799003|56012099006|5023799004|11063799006|13003099007|18002099003;
X-Microsoft-Antispam-Message-Info:
	6Mc1cM6U+N6zoVcftI2dXNRvPh38W+4/bu4euaiHqyM6Iy/2bPOBD+6CD9E0+4phPlt0B7cMM6o1cUYV+LRWc8Khmuk2waCiOZBbClyyiD11GAleIhHLeWE1QSF55bdtrsAvk9KoRnPFYGpsVVAtD7l0BB2CM/SJ1cVSugFCjRGsys4SOIrq/850Dq1KjgqolODZPd0XpY16JP7wxbSsFc1FR7B8SX2Vc+3XpAOa4KZA0buM4emz4GYtCG/0aN7k9wTatTzcvpeto9i5fUEooi8zLqLXpLC1xt/yK8LyAjRQ/tkErqBndlqkbPSvprCWj0Brn0gmEQ+UiEKGu/Grg7004FnYDQyeWBn1kT2g9U6t41ytkBoQ5XfjotK5ohvu5x+uNA82QCOr8PNPY0ysDpUJQTAsoPsQh7b2iOWC6pqt57e4LvVY9FhIkZBGY+VwQ02ve7Dq3B3hd5Ew/8tpCEDhcoahjCH0cAigTyp0ecjDcZvkx4tRURkgXKuiz8mWQljBrKG0fhyymcIcLeUP1F0Ol2rO2CC+2lFso/AVGnDr+ZKEQRqhQ44p8QAJAHV2dgu+jGB3mYd2o/PYR1MdZ5BzfjKZGib6DdpjKhwMhCYhNzx0jsKe+Jo1KSNgcXj3BkyKopPHjy0EzNletljTxXzHb/I52sN3zFOBlQS2KiK54if+eASmEk9IVp78uKV8cn5/zaqFqABvXXz4Jo/B7A==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(3023799007)(6133799003)(56012099006)(5023799004)(11063799006)(13003099007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YOqLKN13DCtZg6xdg/XEA9t2P4QKzZ99i725jf5kM0O6dA6pZWpzeSAkjpfwQwFMfE3kssLgVdAHUV2YHc/m/gXx4+4H8pQaXC5FauxA4zcdpy+d4Qvs9DftlmMj6ejLwJIvswSmnq06MLnuQJJgVAfq7f2cN3+UOpoo4cZI6JvLgBQLcp+zK9aI+Vv3PxdvOhChix5fkK+PLKXraxSyCfseQ2z0102c/wywbP0+YjvbYsAVfR3Ue9rga4eES77htlyssWPalSw5mRQLtfHaIeGMLlyLeMlXEl8Ye2Wgszc2U0bKjh+OAK4eQZsBGQfP1h7Q3aT4kF8LHq9sJ7VZeabq2jh1gpu/CV+s8LVEj29uumm0l/DyTder9nhvXWmp00MGCBw7NRakm+a7YrsqVZR9dVHswokpDN1fiQOBq59pu2NhYScNthHd/u1qZ3QM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 19:44:47.3921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e060b27a-b367-403f-203e-08dedd295e08
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999173

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
v3
 * Patch-1: Add a minimal FEAT_DS detection and allow the two DS-only
   range encodings on a DS-capable SMMU
 * Patch-1: Mask the host's scale value to keep its 5-bit truncation
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

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   4 +-
 include/linux/iommu.h                         |   6 +-
 include/linux/iommufd.h                       |   2 +
 include/uapi/linux/iommufd.h                  |   4 +-
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 184 ++++++++++++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   6 +-
 drivers/iommu/intel/nested.c                  |  54 ++---
 drivers/iommu/iommufd/hw_pagetable.c          |  25 ++-
 drivers/iommu/iommufd/selftest.c              | 147 +++++++-------
 9 files changed, 277 insertions(+), 155 deletions(-)

-- 
2.43.0

