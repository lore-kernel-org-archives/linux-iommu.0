Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013063.outbound.protection.outlook.com [40.93.196.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B63377AAD
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 18:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054983; cv=fail; b=BQzA3atljiwsYgye+sjMPdPjTjXZsXA+RHf+1LNleZ4N6B0atLMMfKqep5LPWF6eGXMjv1NJwine/IzBo2yMvlMMhIPpyODUoJTv+QcYmYo1OrwnBODqvAak0WK4iFxQuDtOgqXCyaguo9InX2X3OAkBOwQnGZwYT0f1pX0SB5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054983; c=relaxed/simple;
	bh=vx4Q2vJ0ZRDmRLdOqaAyzzwxSL3qJPECCDsZQbSf9Sw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=otsnFWdbq3e3zmdU2OlwkJu5iXOTpPB07q3dSblIzbNTAXWvWXnZP270oXWwnc6kdof6SvieQqvN/Vw/Fb5ZfGAIzgSOnLCG7qb+ylBTSqK0Td/vts0s9XT+FQDqEUUTZYSlrzWT3z+Jrdiil9zG/F1HRH/r5NwMrdrA3iTQjMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YUSRamVl; arc=fail smtp.client-ip=40.93.196.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YUSRamVl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJyx2XimlLLa41H4YyGet/HILB1DG1yeSKo1fvr/6kdZHO5MU/9Hd+JPaD5HQWdgeTe0CYEZw2KnKCD/mfXomGFNWbDTlY99/MJdBRlJJkMlACXWNvb7w1Y3jvYlhsK2n+tyh6Ng9QJI8Ea9S/kU3EoJhs+XeCrqH+8xKunlbzeOKhirulvayw1l28GrD7TGFJ0u1CASHm6sf/EANV6KpMsvB5LflbaI34QB1HpaC9qigxXdbG5n+A1OKslKaktAsJ/lwsxrSQFioUOchj+2CQ4lw8z6lnz20+6r8KmtJMLEoj7RAmtRrIYtEAuEQcvIVjurGp/7qjhqrfBqDC2dLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wkq1Nb1lU9K7cQI2kIitqXui7JPVgq0XSDzXsobfloc=;
 b=qNkOuWNdrWnuCWKNepjTwRISTNm0ZaH5BHSr5oEtGOqlZaGfGqBFAMy2MDfnyBswweV8Hbxkbyez8wbaSbJqJLKoTTVPLUsJH43FS7uDijoSb92SD1lTp6KWxmilzkxH4OmURg3rkLMyTsWSSrW4UGm4bjx8uj89IozcQtqEhhHhoepX7mnz1SC0XT3uFSfdtFh2bPyEB5sljVROUfU8200GGurWl3ygfSRP9zQiKhtth2j+fhy11xdi2AwC1paHRuPG9ad0Es9FpwdGQYq2bggdcGlk/+xkHDZ9ArifeojvxJNWqzyvwTP4UtIq0cu9Yv4lNgNCYqSSaH0qsNgOaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wkq1Nb1lU9K7cQI2kIitqXui7JPVgq0XSDzXsobfloc=;
 b=YUSRamVlkP3VQAjXwITOXmfnd1JKJaqaKLc43Ba8+QZ6Q4FRGWWf7/jOtUGdJ20Hegg/KGV5n1heaSRFwGhuGIx3+b1bXeikBma4lD/MZ5HBPSPnCkPYm9KEKUdUInpj1DJIz9OBLbMRLPZWU4b/pF2tfud/S+n54tPK32HDmrFJ0chgIzT6tEdfBYtc9VhCPzPFngZfS52vTkgl/Qf/9x4L+XsTBGZzOf2tLuqL0HDWhrq+GoFrzMV7UIhggWOL8lpLHUav+qYwUdcallOQ+hNe3MvXXismdUEBtmNwCH0UOl14KlF4Cd8g2YJpgHhQ7Bno7mXnS+fdIcpEOJCotQ==
Received: from BY1P220CA0039.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::7)
 by CY1PR12MB9557.namprd12.prod.outlook.com (2603:10b6:930:fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 18:49:33 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:59e:cafe::9) by BY1P220CA0039.outlook.office365.com
 (2603:10b6:a03:59e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 18:49:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 18:49:33 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Jul
 2026 11:49:15 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Jul
 2026 11:49:14 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Jul 2026 11:49:13 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, "Kevin
 Tian" <kevin.tian@intel.com>
CC: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, David Woodhouse
	<dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Pranjal Shrivastava <praan@google.com>
Subject: [PATCH v4 0/6] iommufd: Iterate the cache invalidation array in the core
Date: Tue, 14 Jul 2026 11:48:46 -0700
Message-ID: <cover.1784054606.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|CY1PR12MB9557:EE_
X-MS-Office365-Filtering-Correlation-Id: aa9f5a74-db2c-403b-9b2d-08dee1d8a509
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|82310400026|36860700016|3023799007|18002099003|11063799006|56012099006|6133799003|5023799004|13003099007;
X-Microsoft-Antispam-Message-Info:
	6xm30RsY99Hv8PtN7mUKYBY1amFbKFGRdt0g5KZpS7ALTTswZ1CoAfLSTJw9aMfLKq+1lFaHDdFAPY8Gft79cQER/xzeErYIDxrEzI0tzjQf41fNwwonItTzGqRttrQH/dLqSHsMTLP1DS4LXSe+9Mt5WDb0aBrFT8rWm7Mx80uODOgrlly9QX4lbiofd1pfM6Kb7afSIIqq1LZ9FLDLdOXDJdE0xr/4/SY6kCwgR8snTUu5A/KpkVSbhTdgdiyEFvL70d2XJhPptI8W7sg28amYLgyrZtc0b5E/pmBkY8emGBw+MLicn74QszrPgNaiEETe92dSk+77Pwmr1nxd/qFFonvQ0aT2BVWlkrws2x66Fqrn5SKLEMKFnfA37XyjlImAhaTALB362uqSTFgGdlF7EI2OvohBJJXxfCCN9KcHFWtp2ToeJ+o8MjtTQoF5yeA9WJsTCAXQ72sTVf+BuGimf5wFbCFVTGrYg7Ubn1X0hXtG1PBEh2K9a4e6InzdUU4OKd0z+NgTpUjWwt8uE0uB53gDGNPRfQ7Qu1TgHELbuw6ouxkfPK77mn0cbQpbP+tbmiA2hwnI3tyH9PWBJPv+p+3CrThky55L60JPXB+8yQ/6SYNa4zWjWKRZMxoA5vHmlv2aKMLjqOtzM23jOaEiyCSiTUGlppbVyZX8xTNdn9w/nfbrPjZpGiG2RkjbdHhfaU5QeBll/HnNfWK0FQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(82310400026)(36860700016)(3023799007)(18002099003)(11063799006)(56012099006)(6133799003)(5023799004)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IBr1VIQ1o8HGwO8lKr+pKc8hK1TQ+7WwcEjcmfBf3NRHuVQVaGy57j54zpkVbcmH+iCTaj6Yvlb7yXYwiEg23HWc5S86nFCg2qSWkjPrDmAv5HZVmp8dfeLEEGROR8ovSjxDjNc9L5XSz8Mw4X2bLeNK4OK1I9Moy/kPbjYljj31aNOJbTrSJGYz+LlOUayWtHrCVAhf/q1p7efvFDUsM6kwv3tAWTPOq2zvZQH3y/K2NN5SmbfL0TfKSh3KCwx1iqUx5MuvZ6BAqptL+1XylnYGpe/FM+aC0KGZUvBIZhmhy0v5bFHm0imxP9eyk9BNFg4uSJbJa0vw4G/BguyEq89fCzj4oH9+aC222N0n2oX7b1Ghv2IrY6kq6nNJn/UBBWsgw8KvYQMjyaSC1meNW4fFUYcrE5hGJ2M0S28QzQ7ctRRZob4hX72A8Bh+kg8Y
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 18:49:33.0260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa9f5a74-db2c-403b-9b2d-08dee1d8a509
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9557

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
this cycle, so the series targets for-next, not for-rc. The stable tags on
the first two patches take care of the backports.

This is on Github:
https://github.com/nicolinc/iommufd/commits/iommufd_invalidation_loop-v4

[Note to Jason and Will]
This has some conflicts with Ashish's ARM_SMMU_OPT_REPEAT_TLBI_CFGI series:
https://lore.kernel.org/all/20260609073204.1760077-1-amhetre@nvidia.com/

Changelog
v4
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
 https://lore.kernel.org/all/cover.1783539724.git.nicolinc@nvidia.com/
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
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 193 ++++++++++++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   6 +-
 drivers/iommu/intel/nested.c                  |  54 ++---
 drivers/iommu/iommufd/hw_pagetable.c          |  25 ++-
 drivers/iommu/iommufd/selftest.c              | 147 +++++++------
 9 files changed, 288 insertions(+), 157 deletions(-)

-- 
2.43.0

