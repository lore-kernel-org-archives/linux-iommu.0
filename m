Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011001.outbound.protection.outlook.com [40.93.194.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386E51D61A3
	for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 01:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764119462; cv=fail; b=Q3K8K7v8AFpVpm5NC+yhhwIeIZeRDBjY3a7dVCWeQWPJJ1wir7CWa3/cCvMUxnjkHxwhzL4G/ekTXJEhZF+dkkTlF6KQrbM6xQZ1gJ96/f5wKC7vNHeXKFXl059+CQ3v6jTfnPU+O/gsa3RGvEhGvWpI+0ZkpunMtZXlBwM611U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764119462; c=relaxed/simple;
	bh=+5i7UXKN6D3/1+20+lwtIU05T3CJzOkKTCO5Zruroog=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h5tc4Cs/3KIAPtkWhXdim+/WPGaqB/NuE2KoE5ASZuWZLl7i2kVjJQ5TliBVwPl4YrR8oGwhhV+YMVXyhQknAqWsFFYj5z6EUXNyDx/mJHnU+TP0FHNXEAJxDK3sl0MsMYtdhypLf/ZMTNOJ7sK67kHsAlmDl5ceF5ZjW8yrbAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rCgpSKmu; arc=fail smtp.client-ip=40.93.194.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rCgpSKmu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uq00pCF6D/x56+4lBUJN0399IysRFRTBIe2BU5WY2sfSeHkAWcn/IkHIh0Lx9YSK5IOgCd6mJfQk4lP1lOkxABrweYvtz3dXbZZ+ebr6ektHo20qPTHYV411YE4X5lUQMaihUjKjTlFePQp2RZPimX4aF/HkKU/51Jg1oXfol7Fsy5xNAixXjz2ayVErxc5Mh+cDAEooru8q8/q627Mb5i2/CFFf/yYf1TG28m41qSJz7rRihjpmG2DgzcaAsOQN+8vjZrsZY4TaqJSuzaxAKl6ZDVYEPwNSzeCqLYirIVfKVShYuHwnSTzfVJMqrosM4CBr7ZVKW3XePqVj5rhFPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMPSGie7aelFs3vO3DA4C5AIjA8G4VSE/0vzDGZDxt0=;
 b=k4zPszF2G4hAwogN5HSxnzw9DR27ziIYPlqQNBrQWS8PTG6B96HMfypG/5hCLUiUZ+BXph9sNdrJqWgulqA8CsRlPN1jgsmOKwdotnDrPd8qwlIGN0u76lwOcBPv92CmLiVeGZvaX5EK92nvKifaoQtziXeOpMh4zMELews1j7Y5WimTfdzbwWzVygfFQ13C7/OE3aMCc4+N6HXQPqLFaEt8epSOD3jLTqokNM5feK+exiTKSaT63pPUt/BpJ8vFD1JPDT2U/6XHLPWGtHA3gdyCviw2p2u5KsvRKLmKB5DziWwIzV2kZVnoRzu4ZqVAt94maAKcZClphTlWw8Y4rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMPSGie7aelFs3vO3DA4C5AIjA8G4VSE/0vzDGZDxt0=;
 b=rCgpSKmuqbQD2iqkmAcGbIUBuwh6YYk1AYPNd+xs1MQhOMYX9ozjzNEcPmLSs3M1HwZgo/JCPD0+Y8pDwfheDSDXJFLCvyOoxo/sE+rvR0JOLwajTxJU7brsoQqSiH5OUZwwwCL8iwQMcz6t/Zvv/1qmfgrhbXOuryVShf+S8TkqF0PX408pZqspw/qTOCuSJDLNo1gr1kqH1vuniPZsfGkFxc0IY3IGdP38o7KsMQGvihy2R9vfzSF3uF2LS4vXZdrercC2Mbqy6HgQePW3hKpMmBLqIiTdbeZ7Gsae6tmGsjnIo1cTZnMtMawcgV+1h8ui3wHLDBPgtlwbxgvA6Q==
Received: from DS7PR05CA0042.namprd05.prod.outlook.com (2603:10b6:8:2f::29) by
 SN7PR12MB7934.namprd12.prod.outlook.com (2603:10b6:806:346::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 01:10:56 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::73) by DS7PR05CA0042.outlook.office365.com
 (2603:10b6:8:2f::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.11 via Frontend Transport; Wed,
 26 Nov 2025 01:10:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 01:10:53 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 17:10:37 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 17:10:37 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 25 Nov 2025 17:10:36 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v6 0/7] iommu/arm-smmu-v3: Introduce an RCU-protected invalidation array
Date: Tue, 25 Nov 2025 17:10:05 -0800
Message-ID: <cover.1764119291.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|SN7PR12MB7934:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eb0561e-14b0-4f00-ee1a-08de2c88a5a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q2rhvLAAH8XBqY0ivo1DkxkF9PODzvOcea1iYfhRC8M92wersQ7N4R85hfil?=
 =?us-ascii?Q?92BEatfcYt3T3rNNxsR9KHnBvfYwrJzqLgJSIVeEOO+wJ+lk6sQNfaTBuPvs?=
 =?us-ascii?Q?zPGer2IrXg0pltkZ0GJbi5vLuU+FqOpsQJGT8zo+0yfSJ0Co7T/wnOk1sanU?=
 =?us-ascii?Q?bpS2HkUAmJ0GXPnyDpHY2lAeL52nfZNwq4VZnPeLiLUuJCMWQhMVUVTCHExZ?=
 =?us-ascii?Q?hFnMMmJs4U7ew/9hL/m35sGDpMAq8AXAxpB0rG/CNsLxXz4+MdmXMov5R8Er?=
 =?us-ascii?Q?NugDzTgLQNPDVmaQRu8pPwTa7sT5j9nyDD2bOj7JThz10JlClKLrqFTNYByK?=
 =?us-ascii?Q?LCBVE80SwFPMq5upRxqGu4LRdlIrOUxsbT5oguvY9aobIsWb4jo8I1mu76nu?=
 =?us-ascii?Q?1zIeX8r7MatXjz2Pg3Id/1IwNtEtZWevJCF6SKLxyhfoLkvykGoH3yRdF9H7?=
 =?us-ascii?Q?tEdACeg/LuijG5iMgieWYmcvnUW6ZopNqNossSCewrSHplvpOwKbFVDZ3iNm?=
 =?us-ascii?Q?NNqNYo0pZmQSZVztc9KMDxfr7XQePmLzeVCj4MzArnjqm+HYbdMS9i3uszBW?=
 =?us-ascii?Q?hjM4Je/dXe4N7VdwYI9nqvU1kZMtMRfZ2Vf3kUSL19JKYvC8OCuCd4XdhYur?=
 =?us-ascii?Q?xwhSqwsFL7bzCs8elfSebotAylGl4zQuIi662C1LIJHxtgiuk6qNNPLSCCNy?=
 =?us-ascii?Q?fJKx8+0b1ptELnq9VburCet2pjvZIThodgCLe67jJvWBoHUTwCxrU9RCXwns?=
 =?us-ascii?Q?iqd5LKv+f10+7llZVbZthOm9f9DZwJZWXEUXyJ+Z2NqAzJ2Xq13MP4Ceertq?=
 =?us-ascii?Q?YKrRKRwYM+fBZBP50D6NZ7LTz89yNd9M3NTUBAdZYkm6uhAzRLLWKAB8zKqL?=
 =?us-ascii?Q?x7B1IryCUhK5n5+LhiUK/jLvAEY+Sxweboi1VsnJvKnuu/RqUJmJ9Ox7dRQd?=
 =?us-ascii?Q?bUfBuCpxtL4raJ/hkAYK5ctNmg6P+X43RIzfXq6vrZ1kNC5vDumWAZnBsQct?=
 =?us-ascii?Q?QdfzEKohhPc6wjyHMwT4oAyJzJoHTI7+9MfNdN2tOygkxnQL3pWXX5Z/6tYN?=
 =?us-ascii?Q?WRD/KIL270BOoELNa+bP3GtGLXabHtpb/AhuOWyGuVNxwGcOT3S0v1hxYmLV?=
 =?us-ascii?Q?WourSl3Szhthl5MTx0v2irCEMQ7a0qX6HOg68u+zMzm85F2JlM5D8qEy1yd4?=
 =?us-ascii?Q?+OssLAZ0rdT1BvZz+t1zo9Z/L+6b2eIo1OK1jNASAlaI4EynqaGbXMyP2PZL?=
 =?us-ascii?Q?uPzmyxpBlPhNND4n/I8aL0noALIP6Mhr9UidhBD4RSqNVOe0OGLy9bBSi7RT?=
 =?us-ascii?Q?NGq5lGElgPQv6KMAyF25exPYvoDZ5QKzMPdOQL47v2zWFKWH82JGzI8tFUEK?=
 =?us-ascii?Q?HTdXLcty2Uq9+iZAnLpMFOZKlNhy63pegPhSxac1sfsgGKUj5z6c4fv+RJ2L?=
 =?us-ascii?Q?6WWn6uMFEeRwzgE+DL8W2Zo5OwUXAyJJ2ur7H/bQPEF+UK1Kz699Vph8B++i?=
 =?us-ascii?Q?W5OYqhFngEbhMnpYv/oAUs1n4W15svvv81fcq/Apngtf/iw94K3oTQ4Kdxis?=
 =?us-ascii?Q?N1azGtiw37E+SxbLmXAuYT7ITP7Tp0RZigacNRSQ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 01:10:53.8116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb0561e-14b0-4f00-ee1a-08de2c88a5a7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7934

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
https://github.com/nicolinc/iommufd/commits/arm_smmu_invs-v6

Changelog
v6:
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

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 142 ++-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  35 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  |  92 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 889 +++++++++++++++---
 4 files changed, 978 insertions(+), 180 deletions(-)

-- 
2.43.0

