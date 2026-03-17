Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012037.outbound.protection.outlook.com [40.93.195.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D133932F0
	for <iommu@lists.linux.dev>; Tue, 17 Mar 2026 07:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773734393; cv=fail; b=eJdwOAl3pfrHsxegB7sZ1NZbuH/mKq7OTesLLmPosc9YOIuMh/M4LmmYB4jCAH2TF6gdao1duLmA8arMTyi50pQxkAQCdi8zYrn8HltxmhIHJPV6ybUCPTCF6XZ6AF7w6P1eKUOAcLZ43kWv+nMFbW22Eh1sX6uX2tJiTYC7Pi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773734393; c=relaxed/simple;
	bh=p7GD+SzXb0jjy+PecmRJpODR3ilLDoN22iQLn+DWSzo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NgtUw0gibPzx+o3MdStBmNHx0Fs3rhZUjiXQPbX/JVkN9z8w9g0hzYF9M5FaNYdoBD9+rq7d1ERM5AzCXlQMP/wrGyv0CxLV50x+6pCVxJBWF4AKmJHyL8L287HZV0HPHfy58CeTAfIDc0pOXUIDKHWp0Xe/ypYpiPgtjb6far0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n3Ztd9IO; arc=fail smtp.client-ip=40.93.195.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n3Ztd9IO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FXK+Xeb5yQJ1I2rJzR6/Tv0FcvSmu81F90JL0b196HJAdiNcogBrqZpEWJ6mAPvQ5t7QljulXH2+mo69EyUfSXPzzLretgvirIgduUmAkQ+pzUoSH9HvZx/y9XzqNe19YLnX4kMkdksQnZsR7V2A6lRA+AEmE38tX7hIi0u6HbwXeSKHYMlo2Ltun08lPbHoHeb3u4pYNnfEAXlBuqBCKcPBIer6J6xDjZWGxyi1uSjdeT5GtNxohPCa5e/VEIk6ipMCZOW7QRsdeo+EkWTJCLgtOmu47FHFJpc1sCTkBcwMa0Aji58iCZIl8cu8wxo6IumYdZfVXD4jOzGsOYl8yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfdNhabI5J2lKgrkvG4GVoyIiizVDtSLYc9stjj2h7A=;
 b=tpknMEsCRK4uEES8NwMa7BBw5XvqLKsIdjBYSTRJavDvOJXygY1w/ldtU63+0hhZ3kuxYjW7z8beLcnYd1oMzMpE4xjqOINlgf/E8CF5Ua2pognvCTrNMQrX0dG4uImZ56KXi5EBjFADwBTQ3W0KQRWQcAT6/+WfP0/paNAqGwN2V2XxHC5/+UQCzsrdwlKz+kX3MmZbOecU/MmciLY08UMfSkJ36abYadlbJ46Gi7YAz/xy2o87snCwd3VXzneY9d+tIonSW86RmrSabE61hcEmCTW75NIYIMFUQbiu1kEvy7BpPLVz8dJeODXK6NKyxbfLj156vW59pZB82wvfsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfdNhabI5J2lKgrkvG4GVoyIiizVDtSLYc9stjj2h7A=;
 b=n3Ztd9IOisMfvhi9rireGZcum/Lt00iX44JkUhVncB/d2RoBRI3N9VtXjxsPoqbqA9X2dyV1t0U1tvGtUchQpVNBj7m6FG5yb8IDHXqPKVZvPcGkNiIxyHJRtveyMa4q/SMFySdbddMrHx3FviZt7+FyUKMjGjlFF8KMO4X6q0OMtOwx88IqzAVmNaHt86FSuLZOmIECbL4G4cV3W0rTnYxccMZkI8zvTKoEWhZ5eNRKPwRQ6ySMuyt35p/VFpDtdY+z8mw8jZMAz6BRKPqbY0lLXQgZBiChbzYRB+pPNwMWHwoIgRzF5R3QOFSww85oscccZ3hy4auamxFiiRAkHA==
Received: from DS7PR03CA0136.namprd03.prod.outlook.com (2603:10b6:5:3b4::21)
 by PH7PR12MB5784.namprd12.prod.outlook.com (2603:10b6:510:1d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Tue, 17 Mar
 2026 07:59:45 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:3b4:cafe::82) by DS7PR03CA0136.outlook.office365.com
 (2603:10b6:5:3b4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Tue,
 17 Mar 2026 07:59:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 07:59:44 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 00:59:30 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 00:59:30 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Mar 2026 00:59:28 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jpb@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <catalin.marinas@arm.com>,
	<praan@google.com>, <miko.lenczewski@arm.com>, <smostafa@google.com>,
	<xueshuai@linux.alibaba.com>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <mshavit@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <peterz@infradead.org>
Subject: [PATCH v13 0/8] iommu/arm-smmu-v3: Introduce an RCU-protected invalidation array
Date: Tue, 17 Mar 2026 00:59:15 -0700
Message-ID: <cover.1773733797.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|PH7PR12MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: 67486e78-add7-486b-d552-08de83fb26e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|7416014|376014|18002099003|56012099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	fsb/OiiinqiK9OaPAlbJmqLK+66M86fB6sekEAcmdosTJo/fY2JBJs8eCXUzrKV4A/6BFp4bQrlmptVSUuN/j6NZUUIlksLSSeZeqLOUDllK3ZOD1HanCIo0AoQi0fbROB0+ECkOeFG9yTYZ5x87LXy/vcIym9S892p8pXmBGgwGuWti3HgbQtT7qZDzrCWw+qoU+yYUzfwf3bmnDxJD0gFFwaRFV9TorXKz5Xm7PR45/K85NZ+wws481HUx7UUx0zP0FCRFUHeJiRChE8xXX3aJNIxqtHqku+JZqpF4ukZ3lbkIZywK4UuutgRqh4qkZqcQzDy7+ED88bvtrU2CfYp6JeVfCYNdjlJDuZmn5OepPdKXgkylLUOeEjK/cUCStK5tqNrO6mL5aJp2TitDxmw5EwkDfUYVPjjgaa4kSHC8dTM+8N+j5IDC1kggixncM/Idmm/+yyE9w6Yv2HFzCxx0STXjzyFCjT6XJy/AHKxQ4V9LcZ93r4uSdfV/6qJfdxfMdX2HCwIp8YexqiFxEOalr/aAhj41uEes7lgb7DxyRWJI6zNsupLVRET5Plb1xzJcCVJ3GcOtj1iIxlRao2EAn+F9214tzj4amTC77Zd++tLF5PjMrTa+3L0H+Bca1c9j/ZBSvgVq+C6Ev1leBjSr8MXIfJl2JwGaYFxsWYRRQkDOB+izyHWZqjMEyOYkgI87nTukCJjXRwAShqjT9DuP9+A+6DIdlu+M3URg+99eeqzHbqTSO4FKaOrDZ3+63mQfaJFTAHTY1IvATiHn9Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(7416014)(376014)(18002099003)(56012099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4Pihkhv8mukFbcWonOKVCdoanCCfk9iW9krsvsnpQn0YQqKm3QBbIOM0KwbTrlBQJPRqX4onTm8Z98nCqcNlhUt2l0VNR80fR4jxi0BpToIEhyjR4VwV7UlTlSle0hh08Cn4ye5jEeeXkWg71kEh1nkJdYJpnh22guNs1dY3RtQTaj4R+8pLh2eRUkQTDK0/Tml0FdsoXWJ13QWRGeF/S3okBbmNyLeevEbNMngvMN+RffRBNypWDw++Tm3dqDeEau34S2pleINlJ9n9vZLeDPHpyV2ch0bhSRDRGbed2emtDnXMPsuthhXtR4gaHP1aT7EByPN6Klj8rSngJgnRRDYAoVKhCEQfjzjCJW3ZZ7CVn14JQ0YmAZqe9eb3k2BbegdWGXOd//VG8Mp8k3cAleimVX0/iu5uXVPO2nzeamS54AYHHr2Qawl//TMdDvAc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 07:59:44.4074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67486e78-add7-486b-d552-08de83fb26e1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5784

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
https://github.com/nicolinc/iommufd/commits/arm_smmu_invs-v13

Changelog
v13:
 * Rebase on v7.0-rc2
 * Fix typos in kdocs
 * Re-init has_ats in arm_smmu_invs_purge()
 * Drop out-of-bound WRITE_ONCE in arm_smmu_invs_unref()
 * Return NULL in arm_smmu_invs_purge() when allocation fails
 * Compare ssid in arm_smmu_inv_cmp() and add ssid test coverage
v12:
 https://lore.kernel.org/all/cover.1771815709.git.nicolinc@nvidia.com/
 * Rebase on v7.0-rc1
v11:
 https://lore.kernel.org/all/cover.1769539310.git.nicolinc@nvidia.com/
 * Use read_lock_irqsave()
 * Pass in iommu_domain to arm_smmu_attach_prepare_invs() to ease a
   followup series
v10:
 https://lore.kernel.org/all/cover.1769476588.git.nicolinc@nvidia.com/
 * Rebase on arm/smmu/updates
 * Add Reviewed-by from Pranjal
 * Fix typo in kdoc and update comments
 * Add dma_wmb() in arm_smmu_write_entry()
 * Drop free_fn from arm_smmu_invs_unref()
 * Replace refcount_t users with WRITE_ONCE/READ_ONCE()
 * Verify num_trashes in arm_smmu_v3_invs_test_verify()
v9:
 https://lore.kernel.org/all/cover.1766174731.git.nicolinc@nvidia.com/
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
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 135 +++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 933 +++++++++++++++---
 4 files changed, 1060 insertions(+), 185 deletions(-)

-- 
2.43.0

