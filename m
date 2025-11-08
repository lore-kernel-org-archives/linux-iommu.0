Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010002.outbound.protection.outlook.com [40.93.198.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4C32D5C74
	for <iommu@lists.linux.dev>; Sat,  8 Nov 2025 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762589317; cv=fail; b=Re/Tsq0+iWua1KR9nGqQ8JxXw49qwPxMfsQpwqoEOFoYEQm59mpBzSflpDkik9FO20me7wM+e0HJ0x2yZ39FP9fP1thOH0OUMfqfSYunR6KjphzhHdT3bXI48PvyAQ9P3hRSkn6UF1BHBCxKAsttITZhM4hEmxBk8oCFo4ODE80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762589317; c=relaxed/simple;
	bh=29gZpcUKkk90AAZfiW14XY9WtSZb5S43z+VOnUjccZU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kfDLf7pqWvgPB3OMqWiX7eDOpPIuUEXVt17rw+ugWRC1n8waYgUtdx3y40jXshGVPe9Qw6M0UusEN3M3G6LbUcfmSedfi1gB3o89RkPS7gpZdAiK7S0Cfp/JFI8+HpEu/UPvJ2HZI7Z1Bdj+VZ3AVp/dE1U/fYTdHIE5l0C+3Z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qPuIEBqx; arc=fail smtp.client-ip=40.93.198.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qPuIEBqx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URKVVJLz1l8o964P/OQApiAkjaNsMR0Ftk6OfSfOKT+XV9X3mGXKdFCPClk7bi8rFnAjdLELfheOFf5dQQIY7rTIaFxUil94vXWxElIi7GLECPcg9I1hEPORCm+gz1kKzlpWu6D7X+8zpgTwqc4MDv5U3LPrWK9qREk9Qp/r6/9s15gXK6SOhBygxtBaiFpJE1PKWfgFx0XYFW2g4TSe8qMbxvMUFtyVFyC+FZ2Wu0pcKBvUlig2k8ibqYt8uVXMotZZDZosOv6Q5z7R3/GcBwwtH8jsT0urBhkA1yiRPXMh9xQhWAtu/FREiy/NYuIu8NoMz8XGFvMXK99XtK5UQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WntbdIqXQeClGgADyJjZkeY0DnofnVh5rlH83peLj30=;
 b=ZunYREHFC+o4eRWJDGx8OTlufHGJATTxbuSXs7HBDT7k+ykQYpVrZE5pnrBJ3yMbE87enj6T36Ba0MNw0NfZJevrJ733HGsGiRbklKvtQoQ/CYtkl1i+6/2ppA0pEMfv05ISCr+Sp8ltE1fi13hYKUIoWFhc3hcoAZG4T7r/9YJ7EtujucytatfBcRKFgsTXShfxmg6lgpkoQnPfiZoZM1X+mr/7N7hHqr4o6kCr1Ep95YZ8/CDHB6LRGGQPZ91GPqH7ASXxAbDtew8YErkP/ZHSKf3SslyGCHVrVgNKY71xRfzLBrqocrQ4W3X79P1Phjb8DN7TtlSKVEzMDPphCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WntbdIqXQeClGgADyJjZkeY0DnofnVh5rlH83peLj30=;
 b=qPuIEBqxvcXOVwl54HT8utsqrgNbTpItJqAHPCugdRJon0OY1OAQGPOCmPXNyfiwMiIHwx/hejQ/u+DLfbTn5cJoVRiM7DKysyLjMyj525ZbtDUcpZmpArgOp/3QLz1CQSBL8cQ8TeizUgjFBUZ7e7Xkwor+VzYBMN9p2u8kCjKuYqo+txJ/yPtxS2Z1T30SFc77MB0mq1gbxmxh69XSKQWvdTMCFKKhzH+20wmnPOLLGo0zrBCXt+Ox0jE3mBDwQQYNlNl1zmM9LPp4MgYw8v9yNx9kiUmoQuq6P2tHTEs8Ge7mv5bdaV8sxuwKpYe0oMvSf+VS2h6UeH5qWeMGug==
Received: from MN2PR14CA0012.namprd14.prod.outlook.com (2603:10b6:208:23e::17)
 by IA0PR12MB7699.namprd12.prod.outlook.com (2603:10b6:208:431::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Sat, 8 Nov
 2025 08:08:31 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::b7) by MN2PR14CA0012.outlook.office365.com
 (2603:10b6:208:23e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.15 via Frontend Transport; Sat,
 8 Nov 2025 08:08:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Sat, 8 Nov 2025 08:08:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 8 Nov
 2025 00:08:17 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 8 Nov
 2025 00:08:17 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sat, 8 Nov 2025 00:08:16 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v5 0/7] iommu/arm-smmu-v3: Introduce an RCU-protected invalidation array
Date: Sat, 8 Nov 2025 00:08:01 -0800
Message-ID: <cover.1762588839.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|IA0PR12MB7699:EE_
X-MS-Office365-Filtering-Correlation-Id: a262a100-a709-4fa1-850a-08de1e9e0169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zD+Ag9ybhRY2lR9E3/j7xBP7ZIpA8iNpc5fL/BcOAHTYGovaRTXfzIaDfzgz?=
 =?us-ascii?Q?RCCQgHHic789nj5vAl+FzK7XOOkbvwNImJEYYyEhKMn/ouVkYkcIdT8fcnj0?=
 =?us-ascii?Q?dtHAt9RdmYhKlstui4XW9LgzrWojSJAd9oXPob4p1hiJJujvHYnmgF21r1EA?=
 =?us-ascii?Q?qXSgfxNVNdjvRvrIZIitL0+qzffvtsbRKkOsY95XhHfUelglgAh9ppr9qsRJ?=
 =?us-ascii?Q?oN+0DkewS+x0r5RWErwQMdRgdo5sQWDRA5rUzCOBrFTN+EBVhHDBeXglA9M/?=
 =?us-ascii?Q?L/EtbmO+fAkJqxJxiHekSWKM2sihwaeynvFFpX8M2wrJJRUzwf1hUyuHKDvl?=
 =?us-ascii?Q?etO7O7fcjtMb5MPlg0NuDncZHowKpOBABL4O3/1o0P0dJOg91oHyUFnFZNTi?=
 =?us-ascii?Q?XOSr/lFVzv7JzWykmH6tZ/4zhzU0ByLqKANHREpPWuIw+8kkmaSbCKPH1d+9?=
 =?us-ascii?Q?3P56IPmP48Trs5192d9L2yfLE0cdBHr0QLTQqMNx/6MsHO4XobrekDfNIOhF?=
 =?us-ascii?Q?tufa6kxnPTK8fWUj9Q4PojEMUVfiBm+L4QRM1L29+ssieJhaKx1ADTnhwbXp?=
 =?us-ascii?Q?qjM5A5KbE0UOgVLXmTSi+0YKbU/nE9MvY0KCSnTmluXfIXs8ojLCqj/G+ovC?=
 =?us-ascii?Q?C2p4oXxkG+C7fYwKIYPSJrR2alXWyVRbuY3rkJ4ZBRO3KzBT8VRAF6n2NqSc?=
 =?us-ascii?Q?8q9ONFyTvyyen0U5FmLSd7DQUBcqp43x5FblHnouB4Clx42QhmRxTLX+T7hU?=
 =?us-ascii?Q?0RHi7UvWGlCZi7NlFbU6gJXeJ/xPtRSo8WPY5eweCrNe7zOBiU6Yn2964j/f?=
 =?us-ascii?Q?e++IuWR6Odhqh/R6LqPCKQZdnh9ZaUMdnYTOPdzJz2vYQKQqdkggQFQZBjnE?=
 =?us-ascii?Q?S74L96MCX8Xr4/zUvVKpTwvV68DMjSGBOFYHF862hIEekz92OR9finLw1Xa0?=
 =?us-ascii?Q?1oxeZyxF/nabB//i3aNVSiBGZcw77FHZMW9wyPE/leLYRFP6lrP1FGJpM2nj?=
 =?us-ascii?Q?NxLAFOAfzDrkz9vryEfoU4XQ5wbReHkQ//VhjvrKvqxtT6OJAh7XlVHX9ltM?=
 =?us-ascii?Q?wCl3G3d39cBiVe6s7TFr2hvzSQJQSh7wfBvGdF38U8CO+U6f/ePPcpgjOON5?=
 =?us-ascii?Q?adL5QJHRI3aW68czOPMabFG49Nv92rlMKz0CUOfOd60s62ZiNXlWZFipSs2X?=
 =?us-ascii?Q?sd6XDJHdRtzcEDACihZSeLqQaN6nFYtiuznImLqJ8aJndVH9jB9UAcfeDcC1?=
 =?us-ascii?Q?MV2M9lMm95befsnxQLD7soFBJfZt2q8N7SEc//y46q/qJiiTcR62nuOKQxsE?=
 =?us-ascii?Q?PZZKVxW0ujWS5l6B7YYAxlRzsn92Z7YBATtenGnkFk67Rc9u7D2djmkk8TOn?=
 =?us-ascii?Q?XA6SMvIwqnWl2ZU6B8BmPd+VTqJmEpuP3zm21MQ5JC2c6Prc+S6E+a4YM96H?=
 =?us-ascii?Q?s00khVQoFUWOEpr2/qRcLHhy2HqZlMqNN9Nq1aDkIVblFtFjDBWpu1Q8c9tt?=
 =?us-ascii?Q?gT/27e9+WHu1vzRU47TaRLbZa3nAqN9xLJGpdhM/nT6L+g/TDn9qjS2fDH0c?=
 =?us-ascii?Q?GVJl86kpJq/OYDtcANj+xw67Lciuf0US1bJpBHp6?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 08:08:30.8658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a262a100-a709-4fa1-850a-08de1e9e0169
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7699

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
https://github.com/nicolinc/iommufd/commits/arm_smmu_invs-v5

Changelog
v5:
 * Add Reviewed/Acked-by from Jason and Balbir
 * Add two inline comments
 * Move cmp after the trash entry validation
 * Batch commands in arm_smmu_inv_size_too_big case
 * Replace kfree_rcu() with kfree() in arm_smmu_domain_free()
v4:
 * Fix build errors with CONFIG_KUNIT=n
 * Fix uninitialized cmp in arm_smmu_invs_unref()
 * Add missing "__rcu" in struct arm_smmu_inv_state
 * Add missing rcu_derference_protected() in arm_smmu_domain_free()
 * Bisect two paths for the conditional lock in arm_smmu_domain_inv_range()
   to fix a sparse waring
v3:
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

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 136 ++-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  32 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  |  93 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 851 +++++++++++++++---
 4 files changed, 937 insertions(+), 175 deletions(-)

-- 
2.43.0

