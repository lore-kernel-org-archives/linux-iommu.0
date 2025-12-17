Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012065.outbound.protection.outlook.com [52.101.43.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1056B25776
	for <iommu@lists.linux.dev>; Wed, 17 Dec 2025 23:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766014840; cv=fail; b=H0TmLBIyCLAMp40gWz6GCpZa439UT2FkOW9uKqKrrWJOLKlyx1at0PlWZHt7ljGI2fjpFQp9LcmkjjWvOyu6yj2kINKqU8HENHPkRr8hgnF/CatCgseB/a2UljdfAacRuU0mgcA8InKAH3EGtOQcxJ+2+crONwpw65hW/Yzf7lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766014840; c=relaxed/simple;
	bh=Yoz+2L9a9GHCwBB0NSWBSEuJgUClm5ZYLbErZia2opY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=swvxzrvkaR1GZg5DlpVEOLMMtG+yiLp16QeIm4DcP77vwgiJGWckhGbKlX7IpDvaSXCplLCBQ/8DTFLW8i2/LHkb/UGH+l0M7l9KD3nNElK2ekX+GO/fg5dT2mo1EJPGZoH7W4Czej97XzstW+G7gj/W8DiS31YpIHr8e8YCelA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UTm2zeer; arc=fail smtp.client-ip=52.101.43.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UTm2zeer"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBLbCWymk3OFYEwcj+g7X/ssijF/HHFqWJ9gGhsCt2ql6KJYnPhKQG09cznp7oo1xDegRNcLgXGiXs9M11WjMpJt2q6DRG6P/+xAuqtbM/FQ+tNn4R++HLy4/ZwTgelZk5D33Dnirac/to9l9MY3t+yRbDoLSnNchWFNGjzlg9I5rFULPRZGoAn5Sa8dH/wD7bbru243FgG27SAWigvK+wcdWeIWdgozvvFFuHQehVXROKCR0p6RwCPA6cqj7kF+UdejCR6Xh2fiS3cupaBcW0Rpsqsz99UX49Mf2vNgfzgfXZT1PFvx/k0AhK05Y7/FYKYlzZX6ld/IB+rkXJN23A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfCehx75bV5FgwLMbzrDwlxeMZKpfdatjqATs1J9dUs=;
 b=UojqbXSGE38zLtyLUHCUiX2WYjF8kS5mToPKBTvpLrZ0GWp/u39Yfwx/kpzdqY6B1HxD5NTVYCMs62pQ0LJ4Evnr8WTxEI3XH5hn28Xy7lZK67hOgTnU7XTgJAr0uB0QLi3QkknCZ3JabbId9Mwmw/e4FfE8zF5aDT72KmzsA1v444WHThPI9XpFsJfo55wB7QBQ1ALoR7uhp9zkVAuhh5ImbX5ptuZoUyJ4XujllC2TWLXg9VKByTPgHtX70KPzqAVd3Xj6e62AtBM4oylf2l/DruBYx+N35EZMtMGcVygDaiCKMZs6OqBYWENVhs0SvN6gL1W4R7Ky/mhdRqRSWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfCehx75bV5FgwLMbzrDwlxeMZKpfdatjqATs1J9dUs=;
 b=UTm2zeerx4e0ucyWxJvXBB3IuseUXcuVtt/xCSk42eTZ3Cl6DF4guk/Ls4cRA+q7abYExi7jEOh46xAq6nu88gaJIzVruL6NQmmEZM11wppOVoERtdslWIyg3DWEVeZ4A1IYCXTf8dPvCIvzjyw6nOFGm44XNGDs/+HdkXEXEUl/5/qNfDs6W2qpJVDNeX7rIVJ6TzhCCTKhc8RN7yKG88rAZ7//narkSNrG2jBHy65g95F1WD0WgTuiHwIPMQrbm5ik3vvyFVt25gxmJDtXR/wvzanWU6xplxRIXPWX/Yq7HNYsyNJldXIBngu1qDObUXYEZhdAOG9trFFbpiFvvg==
Received: from BL1PR13CA0368.namprd13.prod.outlook.com (2603:10b6:208:2c0::13)
 by IA1PR12MB6260.namprd12.prod.outlook.com (2603:10b6:208:3e4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 23:24:58 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:2c0:cafe::ae) by BL1PR13CA0368.outlook.office365.com
 (2603:10b6:208:2c0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 23:24:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 23:24:58 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 17 Dec
 2025 15:24:45 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 17 Dec
 2025 15:24:44 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 17 Dec 2025 15:24:44 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v8 0/7] iommu/arm-smmu-v3: Introduce an RCU-protected invalidation array
Date: Wed, 17 Dec 2025 15:24:25 -0800
Message-ID: <cover.1766013662.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|IA1PR12MB6260:EE_
X-MS-Office365-Filtering-Correlation-Id: df136e29-861a-4731-9619-08de3dc37ebb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hN22QdSw+DAMkWffP5XNfJzH+VQUhdFadS4Nekw/vry22IP7qFGA/tv6XrQ8?=
 =?us-ascii?Q?/So5B4EhWmBZtsw8/ynX0UOeXxBCIBuNH1sPFECKty4c9wTxSv9cIa8eueUz?=
 =?us-ascii?Q?LHc0RnA5uHD7OZLKAw/wtxFswiFGvw4mmokF4voI5YmxW2cbivfHlKDwptIN?=
 =?us-ascii?Q?jwXJyNbmaSvP4kyYoHvuaBWujeOJLyYl1DwuWD1Im5NJB9xuVTeMaX/INh/T?=
 =?us-ascii?Q?2DMGB0zR/hkn1NWVoNatYAo3B/R83Ltr4XQmAff1WBFjmOrlzlpK4anBLImv?=
 =?us-ascii?Q?ZcFTIM4RbDGJ73nigX+wBVYI/MqfQnjzlSG0/iJaXTHA8BQJFM/44FWpUT4n?=
 =?us-ascii?Q?LrxYbpBsyDLzOwWLEkk7wMgO6GUPSc+8qiXykvdcIWrU68myK9yUu5cqqTKL?=
 =?us-ascii?Q?xOCqD7PlES9cRuM/wSU3m2mF+h7i8vkJPkfXIuguQpOzrtQF4EdMz3sQqVL2?=
 =?us-ascii?Q?jLHz0mylbtW4gyExYMF0GkCQ68WHHnK2O1K49bsC7cMOHKplP0mgtokSwUBX?=
 =?us-ascii?Q?AUGQMPVHp8V13O5YlYWh3RMUVhpL1tW47IEGCzxf2S36YNV954mgrvBSogT4?=
 =?us-ascii?Q?gyTYvPXj3t3lCDL00/ErrQoAE/b0+gPn/i5RH9nLOki8GylGLTGrJ+ytOcsZ?=
 =?us-ascii?Q?phmiSFcA4TE5ujMDoMIYt/VMoKaz/E1VGLq0EKw07j9zMBt4pcvQSSOwmTt9?=
 =?us-ascii?Q?Yy8G3MHPD+5Nie1xT0AiPwQ4ZZqgBxoOUAhKlI0h5TM7cVGATk4xV0xyhES5?=
 =?us-ascii?Q?Mmqx3DzvxB9FzY9WWJx5G6srtIPplxWRHQWbfRRxn0fYUND9KmYyj9fpQ0Vc?=
 =?us-ascii?Q?ALdqb6k1Ba3uIMLEuQeIJLtTXMOXTtdv1QHduC8j3bbVkGWT5QKxyjiVUV6d?=
 =?us-ascii?Q?OwANL+H5Z08iT0eC9f6iLsD52PxS9OqS0sf50RIB//WyoPyw3IdewghkEK7q?=
 =?us-ascii?Q?/o9Gb69VKYJM4cBxFwHp/O9qxv8RLGC5dCypcglHgsN81vT6mHB9+jowMPaO?=
 =?us-ascii?Q?ntzR18cHHvTp7laQHzjG7HzntUmFPMS1NCY0zgdNRCAOJUx3kEDJBnw3vwcB?=
 =?us-ascii?Q?ZTUWAh28hxOWKvDlwWQb5TNPQpgIKhBT16pyzSea3gyfm3y+wvNDUzD9tB6/?=
 =?us-ascii?Q?mDZVjqcTZ2tq/MSt3na1rLicl7J0q+CvpE1xNMhAJGiExY/74e7k8DUGYirF?=
 =?us-ascii?Q?1Fru6QvjrXpIMtbZMs81x9mbrqWRU3l4IhYL5JQvCf8K+ivMizGNQ0+UqLVk?=
 =?us-ascii?Q?P0KPR95asr429Cue0++OsZ0lad/kA30o+llp6vozYQzrxfXn96pGBkDul1mH?=
 =?us-ascii?Q?Y4nv1D+/q3zpoCIw//DDeSa9l0Jra6XOuqth6DCsyuEOVOBBxbuFzsjZerrt?=
 =?us-ascii?Q?IjmOP8lVsQvWmG1bqYTflKKRPPYGKV5izpIIRi0Gn5DJd4L1AlM28Raf2C6N?=
 =?us-ascii?Q?I8Oj6EIAMUngqDqK+cru7Hfq9NhTkWn3qEoHue4FRabck3cBuoq85hCGWQHP?=
 =?us-ascii?Q?w/GqY8Au2uOBWjgpZzEbxCo3SQ+r4OjtHC5D6ukYosyt1l6rtOubxihLTQPS?=
 =?us-ascii?Q?9dJ7tzrgivstIhnpCyphrkXOm10MIsnjl+rF84tN?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 23:24:58.5437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df136e29-861a-4731-9619-08de3dc37ebb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6260

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
https://github.com/nicolinc/iommufd/commits/arm_smmu_invs-v8

Changelog
v8:
 * Update comments for smp_mb() in arm_smmu_install_new/old_domain_invs()
v7:
 https://lore.kernel.org/all/cover.1765850465.git.nicolinc@nvidia.com/
 * Rebase on v6.19-rc1
 * Fix has_ats in arm_smmu_invs_merge()
 * Fix a re-attach case with a different ats_enabled
 * Constify the inv parameter in arm_smmu_inv_is_ats()
 * Update kunit test data to be closer to real-world use cases
 * Clean up SVA domain's invs in arm_smmu_blocking_set_dev_pasid()
v6:
 https://lore.kernel.org/all/cover.1764119291.git.nicolinc@nvidia.com/
 * Fix typo in kdocs
 * Fix arm_smmu_domain_free() in SVA
 * Add arm_smmu_master_build_inv() helper
 * Add max_invs and __counted_by(max_invs)
 * Return NULL if arm_smmu_invs_alloc() fails
 * Sort master->streams instead of fwspec->ids
 * s/flush_fn/free_fn (prepare for future patches)
 * s/arm_smmu_invs_flush_iotlb_tags/arm_smmu_inv_flush_iotlb_tag
 * Define arm_smmu_invs macros and helpers to reduce duplications
 * Save num_trashes in "struct arm_smmu_invs" (to avoid a re-scan)
 * Move smp_mb() in install() to PATCH-6 that adds the pairing barrier
   and description
v5:
 https://lore.kernel.org/all/cover.1762588839.git.nicolinc@nvidia.com/
 * Add Reviewed/Acked-by from Jason and Balbir
 * Add two inline comments
 * Move cmp after the trash entry validation
 * Batch commands in arm_smmu_inv_size_too_big case
 * Replace kfree_rcu() with kfree() in arm_smmu_domain_free()
v4:
 https://lore.kernel.org/all/cover.1761590851.git.nicolinc@nvidia.com/
 * Fix build errors with CONFIG_KUNIT=n
 * Fix uninitialized cmp in arm_smmu_invs_unref()
 * Add missing "__rcu" in struct arm_smmu_inv_state
 * Add missing rcu_derference_protected() in arm_smmu_domain_free()
 * Bisect two paths for the conditional lock in arm_smmu_domain_inv_range()
   to fix a sparse waring
v3:
 https://lore.kernel.org/all/cover.1760555863.git.nicolinc@nvidia.com/
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

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 143 ++-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  35 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  |  92 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 920 +++++++++++++++---
 4 files changed, 1010 insertions(+), 180 deletions(-)

-- 
2.43.0

