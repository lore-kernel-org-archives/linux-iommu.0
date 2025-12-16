Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013054.outbound.protection.outlook.com [40.107.201.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A622DC32C
	for <iommu@lists.linux.dev>; Tue, 16 Dec 2025 02:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765851016; cv=fail; b=t52rutBQ/FbS7Kgld0GQvExhvEyOB0iSZF7iJeSPTKP9D9W7k4MSqV4PPmN07kOcqL0T50ZCi80EjCaEr9moBag5qse0KYwJFTd8K0t75WjCs16x8ccH9TmiFI3XycSBdP7hOpe1+DAylZ1GQP21nfA+FUwf/LbetU+XJXMc1Fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765851016; c=relaxed/simple;
	bh=PG8FV3CDeNPZzLXvgw6Q7A4IX/gUgzyAhF+MN5k2gpA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gw2G77bx3Ya1t+r1EBsZlxC2Xum7y3MWZhPQJ9ATrtgWVQR0otH+zsFm18vey1aD42RPrHOL8O7ChOOITL+joEQ4G6cfXTpVgMbK5br9yTG3sClGkVp6NFn90wGYZzmC5v962zNjyo3fBB05/3ODGbATg5XglcOv/AdW9EIEa1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q7NHapNj; arc=fail smtp.client-ip=40.107.201.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q7NHapNj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ba8/xoHS5EEgp3m6dstNWYtT+Id1k5F5LD/xpBOhEZ92uP6U46dumRDge0eKBT+BcFLByW2hWUVP99JsRSisQRH2bsfjup5NmkeX05oQM6FtoydW4oHlJtiK0RpU09D2Rz6mDKV22E8iYBifmuPY06Khjwc14o1ZWOdJyuMLrjJTjHXBSAeb0G8ejVAf9b/gzIiOVJpmvEwnPOj+1XyZyPcYCZDj9nVR6nqKXPSEVb1X1sGXDhIKNWMH5kD4u3EvLeMHvTYT9U4yLLfbSnLNk/Vng+ACnOZUpwvcnV5XIfYjPpw+flFaaMI4cNs6x2n5T3ZiAs19eQZe8e0/7XREhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jplZxuVe4zX9IRNQ2VVFvPCGGSdGAGFp/Ji8G5VKQEU=;
 b=slm70WpvFPNTy1gqxr/qagvYckQKqbTn6Gwn/PuKO5Ofmun7Y9ysIEle/lXaD7ZHDS+KXb1y5rn6L8JG4hoP7avMBAI5TRPFTFd5Jrs1NwL+ow9BORmwc6S3twW1qPuIKwYK3ZTRd6QiaWyyqK0Mn/zgSUXUUimPkUGRKVvKMVj1D6xtgzeDeCgvXKBEIFSEtPk52htX6WgNhX/CJiYBysmdthUVw+L2kBF00DWS7lbSfM7S7uZRkAIGH4SrRjJfrbTtO/mQd8tigSj3jFN73wd7/dZZPB8N7h89j21YJa+wpp5DPJ1fFd7RDw0BKkuLnDhkSlnSO0n0C0iw1fnifg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jplZxuVe4zX9IRNQ2VVFvPCGGSdGAGFp/Ji8G5VKQEU=;
 b=Q7NHapNjHpq+lV1ueMZMIyD2N4fPnsQVXAVCWlSE8JQpeHxJuNrBtgiY+Oa/RpKoQeMSlLabZq5vr89q2P+rDOJf0FwV3Wh5qWjQrY8Dw9zSfWx7JeggOYSU0T2O6fN2pA4gUHMfsK/Ah+rCuTIcXFT0MN4YPdeDBCcsndqeJQdMWWcJSkT4TW6za9DQDL6lKxumBTUgSRNo0DDmmBG2EjtBDtlYH31Eafj0XQAXD6YiWf2GIOupZdD2YawTfy0JAIIr+qQszciQeevlztQE0ToBjPOJO3hBsCmR/j/mQZVJXkz5UPeBY4eEZZGofLfk3QOUfl+9HIy53vfcJcXUtQ==
Received: from CH0PR04CA0011.namprd04.prod.outlook.com (2603:10b6:610:76::16)
 by DS0PR12MB6630.namprd12.prod.outlook.com (2603:10b6:8:d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 02:10:09 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::7b) by CH0PR04CA0011.outlook.office365.com
 (2603:10b6:610:76::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Tue,
 16 Dec 2025 02:09:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 02:10:09 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 15 Dec
 2025 18:10:00 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 15 Dec
 2025 18:09:59 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 15 Dec 2025 18:09:58 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v7 0/7] iommu/arm-smmu-v3: Introduce an RCU-protected invalidation array
Date: Mon, 15 Dec 2025 18:09:29 -0800
Message-ID: <cover.1765850465.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|DS0PR12MB6630:EE_
X-MS-Office365-Filtering-Correlation-Id: 68cfd252-5ccd-4ebe-b2cd-08de3c483d2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e5ksGPM3EWL4sZSFO+ygMSMED3NokWQEisy7s2E7kZFS7n21k5HBXObtA1HN?=
 =?us-ascii?Q?vUcedOpEUQ2cpWLyfJ2PzH0sz+rXpFUeBbhxaXL/g1ezjPNMMhNt66HeMF/Z?=
 =?us-ascii?Q?8dgRqfnQpxIdSwt5BUOf6yDV/opL4ZyDhMoBY8K+g+7gh7x5B46jsIuPShN4?=
 =?us-ascii?Q?10LNC49Ctr7r6Pkq7J+BwtzJjvzQ3s9MXodZIQK5xHcoMrUITes5y3CVGH2+?=
 =?us-ascii?Q?f39BggFf/VGRJfDvzOuSJ8M1XFaAM0SliVOJbFxzMJhIpJNUBw2n4dWybgik?=
 =?us-ascii?Q?E3UXjWBT+FAseivSB833LvT2t6EnB8psznxgV6JnzjezckOAAa8H2mYJuniS?=
 =?us-ascii?Q?fmwBNvzQxgAcvyotFWEXAfSNnt3aQEn0ZvkOKC5UrTFkUy6JRKxatGbWHD4K?=
 =?us-ascii?Q?fUaLdROriXxa9+ikRw21CJu1ipifZLYp5PmTPTNFWh2iLDw1fFVTvxFRCev/?=
 =?us-ascii?Q?881ySR6guLXGxtyl5YMiowEPENrJlpnv9vi4KNwYm5v2xaNl5k957yLt3TvL?=
 =?us-ascii?Q?2zPMynmTV9HNWp2E5jNH5Vhu35Rqa2gs6aSZ5CAuD8JxdZ+MkIiCuFBNnD9/?=
 =?us-ascii?Q?oNb9K4gkhzvSd/7W/ZorjId8DagI6+uSgEz0Mqv54l6Ck/f9Szvw+Dphqhrh?=
 =?us-ascii?Q?xR7Oxazb3vIYtUxJ1rx4TIxXjNaku8CSVQNWojDmquTgcUVtinWClqoO7IxH?=
 =?us-ascii?Q?vIqJIhsNLMe8be5HRMtYwHPiAk+9IH3lTAUlEcasmmapCzIC6DBEUlJvRPPS?=
 =?us-ascii?Q?HsiX0qkwoPT/8E7S1wQF6QlkH55QX47vR2N+GMN5IeD5O4wMgIGRfNuLpRPr?=
 =?us-ascii?Q?ofKnFUflZMRdVvhFp6m41Vm73sFBDUYznT86/7bRJ/FOM3lPnddz0wUFxI8g?=
 =?us-ascii?Q?Zhet7pFz5a9WWzG6d4HazB6FSmlIHFrJoqmwl6tmQXKT3ghDbK3r/N0Qyn8r?=
 =?us-ascii?Q?HoQUC2jWxf4xQBp2X8TPY3XKo3Jis6gjpWO6qjEclh7XHXsiOK1Q3COBYGIi?=
 =?us-ascii?Q?SsKnegBwjt6iZgcFM0Q3OmcK4JZ8Ab3GCv1unSAdi3PRwKfbV87Y7FMw0Dtm?=
 =?us-ascii?Q?tTpoSZVOuGDsfe2ugvuwYT4Btcy/tHFTrg6CGq88b/MF/HIfmCS6MHbLQt5q?=
 =?us-ascii?Q?2Cil2MkjZ/rQi4X3Lwnsqre48jMDgH3Fej1fJw3Hsyshz/LB242e8Q05GujU?=
 =?us-ascii?Q?03dqwqXkumqnuZHEM0WoEjsO23pM6S7LwLs/ihMQo5z5RUDoVgO5r1L2dHGF?=
 =?us-ascii?Q?nFdTFQrtuwcpbQZ+6E3RIrV/7rqqQhcJXs9GdlUK3ISy4lTWOqN7kVpuM4Rk?=
 =?us-ascii?Q?a7oR9fKo/aWZPL3QgjJef1Dh1i872wA6DrYK9mBu/+QjvakUu7fAPW2FMXsW?=
 =?us-ascii?Q?OKIqiKTp2yXyn4SCIjgrToKqWkPRhHr3+QWXcnfpVBdz0Y50SN5vQQvsw0Gi?=
 =?us-ascii?Q?b/NZioUY7RGITFcTtYFzMFsmr7o1k3QxZ+8aGQcilQmLGi18uUO7H/AedyMn?=
 =?us-ascii?Q?SwVUbIHI1CKbSmzhOyH/U6DisNGDJGsCBT8oIIL5UbZiUaNJLXzPQ8Xixj//?=
 =?us-ascii?Q?joCwuXcEhTL2xoswbCkycz/ZfPkBbBavBzA1DWwy?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 02:10:09.3586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68cfd252-5ccd-4ebe-b2cd-08de3c483d2b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6630

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
https://github.com/nicolinc/iommufd/commits/arm_smmu_invs-v7

Changelog
v7:
 * Rebase on v6.19-rc1
 * Fix has_ats in arm_smmu_invs_merge()
 * Fix re-attach case with a different ats_enabled
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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 898 +++++++++++++++---
 4 files changed, 988 insertions(+), 180 deletions(-)

-- 
2.43.0

