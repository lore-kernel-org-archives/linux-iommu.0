Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012005.outbound.protection.outlook.com [52.101.43.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6922FD66D
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 03:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769483393; cv=fail; b=cq0ssuBLoI4XKEO4ddlaoL6cT0TZ1wg+mWogPcaByGzhtWlG8qW5I5vXIZ3w+dCtIeeUttV/xEs0x3F7skxFaV9p6vQi5eMsj4BF+M/Ut8u5IwQoXJ6S9dtBay32XGOxQtUiqmIvDA+4sq9VGS0m7QrLVXOpAZ1a8ARgXcimRgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769483393; c=relaxed/simple;
	bh=Ly5qZ6yJwjkZyXXQc5jGQo0WOy36/3yixavyD0VNHls=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XVD6Nk+xUG1D0kQYGkAUFMfOlEhT/S8yglMAFRuRtaDDiEBZLVuN+/oCBa3jMSsPIM5YL7I4PPHmT3k/mZMOEiTM5KSmGGeqJr/u9Mq4vw2815Fw520oI+LLDsezNvOIPR8zMBjQLhVP99stNkoxzv/ADHt3WfC7EKwnMkwzGrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M86+NlrH; arc=fail smtp.client-ip=52.101.43.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M86+NlrH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBF6Etx4Hs+9HCjtxLD1Qa5tF+G5sxFyyoasJ/1AEeu7fcCOV5G35YKrvPclrodAU4iZTnkKa85r86lItOuswCi0B3CYbbt+hmrxY20SF0uh/GdIV5Ix6vHW6S9kDXKEWZZ4IRFzXdxNVxesrCPtH3aF1/Xosug7RJJdmkMaSqj9A0Zqb8l4PcXPOhVdb6sAIcr6PuCPN8vipLaieb3Olvmb9oHyAn1aXBnzBiAgFm4uJmtc+VJqygwAIQiefMuZIQ2c0YxL20RPLkQrlHfWdhLw9hSYSAXc3oYcBwt2RMjhJzijckUIAoAzLPbZM+cwwh61LqJigfcb8tl6xSl/tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbNR/cKX1fN/U1IGgXQiuN+UEoG/iEKVAWSJdbySD9w=;
 b=FNm/W9m11es6X8Ud8a/Duj11K9s9NV0c15Tjr5X3q1ACr9B34ovmhZWs3isLyxtjBn/LO+lzpMXEKklnvByB9vQuB13JnNbxgi7jHkEijDtUkJvEpiJ05WimSW2CSbot4dyrXtdcmO3Xi88yqknVUm2Q0o9Iq+HV937Z4al9o2BFc7TYAULrBX9Cp4NkwxpXjnJn3IjaDeckrpDYdzzaJXE4M8egt7supsw3mPLRLZ9zvdnT56hO1BKJYmogkTnaG3Tk9TgUiMtnDiqlZCJTgSuf7ohUevkGTJpCV2HuveKtsjtG1kIWasyaeYUB+GCpT8qHu74nwT4kVZCxLe4k2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbNR/cKX1fN/U1IGgXQiuN+UEoG/iEKVAWSJdbySD9w=;
 b=M86+NlrH0GueiLyfdcQgj1+p6dc1DrsvGdAulzCP5V5EOUaqjxSa6s7Q5W7nuVym40SyC79dcuh/oDZ/4neuNHX3Mee5606DYQ97BVulZAWwdGlLWHQjfXZ/9uGIbtQlDHwBCOpSElANOE8EHYFNBHgEBEd31QGqthpeHX3XIix9dMH3wOe193jdDf/j2c2opy6PBfpa2H9gIy/1tlPyEoSi513RDJa+dTm+yTieiA2jg9hISIXKP8rvRxgjPbjHLQf517K1fgNY2i7YJqCc2h9wxas4iHKEXphelEMGsNeQFzntMXLk4d5rFddCnsmHWF8H8Ays8h7CRzF0ileJHQ==
Received: from BL0PR0102CA0029.prod.exchangelabs.com (2603:10b6:207:18::42) by
 BY5PR12MB4114.namprd12.prod.outlook.com (2603:10b6:a03:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 03:09:44 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:207:18:cafe::fa) by BL0PR0102CA0029.outlook.office365.com
 (2603:10b6:207:18::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Tue,
 27 Jan 2026 03:09:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 03:09:44 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 19:09:33 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 26 Jan 2026 19:09:32 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 26 Jan 2026 19:09:32 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v10 0/8] iommu/arm-smmu-v3: Introduce an RCU-protected invalidation array
Date: Mon, 26 Jan 2026 19:09:11 -0800
Message-ID: <cover.1769476588.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|BY5PR12MB4114:EE_
X-MS-Office365-Filtering-Correlation-Id: 596e5c51-083a-4ef3-f449-08de5d51853d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/yDCMkE7vwhFR5sGKJ4vbLOKPQE1zXYEUs0z4vno06KDAxbqkC/T10bKcJqQ?=
 =?us-ascii?Q?yLQiK+aspueKT5kUKpQs8RigCqfDvqYbML9DsNyk+52MhR/InsdX9cNj3cfV?=
 =?us-ascii?Q?VipR4A1Bb22fX9JgiAcMkJkg7AFHzgBwjAxpvGCZM3Z4xmYcyGgF4kwoJhZ/?=
 =?us-ascii?Q?NnnBBHqX1Wb/PJHhtu0u4fEF6Z/pTZgVzy+7SjrYcjIrKQ0PQXYL02sDXg5E?=
 =?us-ascii?Q?XbrEfjzKBGz6cK2vnRe+WflrvVd6C4Eczx56TEe77tmLNY1MaDVQ3lScdN6z?=
 =?us-ascii?Q?TRFVpNi6Z6HBYBXUNHDI7iniVKs7oE20GmDbxnJcJQG9h7iDfwHBC/mC4hGo?=
 =?us-ascii?Q?hionHclhlLTDA5lN9u9QJ3f++D43lmflhaXiEQ0sr4eTbalXj1y537qY/PDj?=
 =?us-ascii?Q?GsvDo4c/UuSSD3LppX4BWp7B13efVa1xrPm8Gw8gyES7MttUA3Jss/MycHWS?=
 =?us-ascii?Q?CgNX+mCbPmWlODCzsHxSQFOP9HYUzT9mbsbLNdywxZyaEOZQyWRKlhVVMNaG?=
 =?us-ascii?Q?fV9ab0jEqFTt9JSxhOrKLPaDqeipBvV1DlXNvNkFGqTqZTWn+CWo3PxpXAXH?=
 =?us-ascii?Q?78Ugb0WkF7H6WxE4FeMkXaW6lG/jARYDzTlY+gmH+QiR7HoGMKgUzGhINJZS?=
 =?us-ascii?Q?1YzZxxNXw2JCSoTHmwZL+sSl4VtPOVrYqea7Jt4eSCmnz8qh01Tl6vp3QSBj?=
 =?us-ascii?Q?pjd49BattYQe7FplEzf1QYAxJ0CCUXBcotnIACNBi0xTJ6D8ebrqS9UQ4Ha2?=
 =?us-ascii?Q?pOUDJgm+SQhBi9TOoC1FBSv7s4lwWO+jHkiy2T9oqPEDpib0redhTSWJ8WYd?=
 =?us-ascii?Q?0vNXia/gQfU+b9rRF1A167hO8h/6BJMXWZFllLRiBYU3yWf16ghvP9Smt1Gn?=
 =?us-ascii?Q?8DB5CbBEjyQ8ulA436TSaI8Rd4fPdyh3ZnFPaOuzdpP/wY19GiiO6ZDdDCn5?=
 =?us-ascii?Q?ejNXAFp9BE+tA9zKGIPFFIhnB2gUwiHhMnxjFNMj+Qa+ZjyGoD6ESsWCvmIl?=
 =?us-ascii?Q?lJvDqmtCgZSES1J0ZBAgD9Ai19rjVen19xUmgAuONvAGi3twqQ9fo4J4qEt9?=
 =?us-ascii?Q?XOl6MTHQiezUcQBEU3Uakn4x75nS89+zstk36yfTkWRXFKSYCd87ym49sYnu?=
 =?us-ascii?Q?TsKwuTN+4UTrA3WlwkNWIZ8dJucVmtNidlbhexT5d/Xk4FtpjpQVn3TWSu/7?=
 =?us-ascii?Q?F3+UafK+M1dOJ1M7shz2ON9O5l2kJsvlYRBN/F9JnEWp6L5xTOPm31PGuuQI?=
 =?us-ascii?Q?iwj4ePl/Q3/UMPb11qanlOcqHiMMxyr0QEpF1qeqkUyoJS1qKXjSJFySv0Pz?=
 =?us-ascii?Q?8UuT19tQPZLhhtHOLnwSy74UCGSs5S6yaoZRDFGgyltIkeaeRzLajE80gqTb?=
 =?us-ascii?Q?avnFvNGF50xTaZ4pR1nafOuL+F3fsYu/isssApyy1KMTuqcUFwyeoFyrc7Uw?=
 =?us-ascii?Q?OBMIa8vTF4n6YQswdzBYnaDWGxg8Ol53s7I1ceZelKNmGMYa45z0uFrgqry1?=
 =?us-ascii?Q?HPJ0oK/goxb06zupgKhdzQoVVPd8AImtCpg0xMyK4HT0BctdK07sC3M+UXeR?=
 =?us-ascii?Q?Sc5x9xPeEQ203QN5sLbi4N/cLW7D3laarq78N/utl06eZG9O3gbSMTXo2FQc?=
 =?us-ascii?Q?RXbm5HkTukiqT3gsDgv7H5WZO5Z3XMxzbLrzljmjGL5W785Dmkej4c4BjSZz?=
 =?us-ascii?Q?4oTsLQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 03:09:44.0501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 596e5c51-083a-4ef3-f449-08de5d51853d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4114

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
https://github.com/nicolinc/iommufd/commits/arm_smmu_invs-v10

Changelog
v10:
 * Rebase on arm/smmu/updates
 * Add Reviewed-by from Pranjal
 * Fix typo in kdoc and update comments
 * Add dma_wmb() in arm_smmu_write_entry()
 * Drop free_fn from arm_smmu_invs_unref()
 * Replace refcount_t users with WRITE_ONCE/READ_ONCE()
 * Verify num_trashes in arm_smmu_v3_invs_test_verify()
v9:
 * Set cur->ssid correctly in arm_smmu_master_build_inv()
 * Add comments for INV_TYPE_S1_ASID in arm_smmu_master_build_inv()
v8:
 https://lore.kernel.org/all/cover.1766013662.git.nicolinc@nvidia.com/
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

Nicolin Chen (7):
  iommu/arm-smmu-v3: Add a missing dma_wmb() for hitless STE update
  iommu/arm-smmu-v3: Explicitly set smmu_domain->stage for SVA
  iommu/arm-smmu-v3: Add an inline arm_smmu_domain_free()
  iommu/arm-smmu-v3: Pre-allocate a per-master invalidation array
  iommu/arm-smmu-v3: Populate smmu_domain->invs when attaching masters
  iommu/arm-smmu-v3: Add arm_smmu_invs based arm_smmu_domain_inv_range()
  iommu/arm-smmu-v3: Perform per-domain invalidations using
    arm_smmu_invs

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 142 ++-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  35 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  |  92 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 924 +++++++++++++++---
 4 files changed, 1008 insertions(+), 185 deletions(-)

-- 
2.43.0

