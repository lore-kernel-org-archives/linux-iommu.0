Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011000.outbound.protection.outlook.com [40.107.208.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BB71E834B
	for <iommu@lists.linux.dev>; Sat, 11 Jul 2026 00:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783731199; cv=fail; b=LiYvZOx56pphk8sxoZBrF2QSgk+5T5u4NzIivSeQs8rItDxHjKirXZShRCbxTZcdQtw41jBGUT5AlKOZ5qCASYJsUTZm13wd08C14LXtz1s9gK5vpwZcyPwdiCjDLzuBFGXTZrRp3Juf5bP13oUm9GgZSGK3n27BrZL+YeuaHXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783731199; c=relaxed/simple;
	bh=KcD+QA/1EXfO7W7Ueg+ul6L5QgwDsZKEsbLIXpWH/JE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ObYG1g34q8+XHcOCA2zSbX8IJlJhHmGGW/vQRkuSXf5hER0q1iw97XiVJLu8MH19ltn57JjLtU3qZqu4TRNZQw3I4IVUc1Wa4bgsW1oupzw8g5FEGzk4NrqadAjlReW0JGUT9S3l4cFjkJYYPPt5PVDYDLaap8mS7tCzcvx9apE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BuUQCruj; arc=fail smtp.client-ip=40.107.208.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BuUQCruj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ff6jTLlomYLxhv76pcTTKlQEtjVDculkVjHETmHk1PpLtshxUL0gAySt0GkA5tWn7r92F3/Yf2EzYGah1z93ZpeJzgQ1IfHs7pl10+ZOhGffCLy9uLFz/eFOe2/yK7fks2LV/dEROwkdPpjGTQpbNPhwP6fl1gh93rlXeU2V1hQoHa5r2XEDhHtDt5M/aJlwxgOzIXeMn1H7Az/F3nRPWQuN55jE1CnaiY0uWRfY9xvgOsV+/+JbRoxp7llXpQAwrJ8i5ejTyIEab2ANSe2VnYnKzaZBTyasxZKhsju+RCq1kXSUe3PVSKP597x5Rdzv1I5QI6TzpeeP36vDyIYuxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zpr+UOgYPjNEQl5w0HLUv767bfC2fPzMbeysVdnUSj8=;
 b=bc07Htyhe0QKdImuvGF+s+dwbLw0TMNnEuQmlotc+osYKBB5m7I+wN8yKMlv7HU32SDNLBIYcr4qRcrFLnL/gnskxYebDwE5OpXHsdORAI+/WGUtzV+8DtVxXJM0MJHurWdRZOToLzJr2ARo7n0rmz6RdY/JPDLNUZYK+F74kgmdFGyNwNxPE1gMZkZpTCra0WjKAWbjTyXk0L3TqJVuiZciT/uIMlGD3VQzAkcQfaYqUcuVBE6J2HiCzNaqV+jBYc3abzBpJvjF1kHTrfMIWe7DBxMtFMDw/etXms9aKEXb9MEnbHn/5k/aAYb9Q1acX70NZwGTQ+PFwYiw/W54Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zpr+UOgYPjNEQl5w0HLUv767bfC2fPzMbeysVdnUSj8=;
 b=BuUQCruj/lBP+s/OyvfOFFxC3iy5NiFf5UvljLREWJOCMhYWvp0uPVfJJKOOwJcUuDB4cQBXIIXAWNgHwh69siMepZ/8Y3Pybr5hq/Wf4eQD1QqH3GTwI3pZM9WZwm2r0u5fi5p69MY7hhXIIZrW6QA1Hhd2NEByhovPkPOZIlr03z5kpOnXnZWL6vRQZME1ziVzfS7silJdMHHNqnUTkiJ3IRQh9v19qvw1lDjeFAXq3Q708723MJuYh6sVVL2oVY72PKqa6MLnmel3UA/yaGsjdzEJ7nG+DG5CORno7QfxBD/T4bEEDestZ6voV0RkRSNI4/f9+VuKlHuTdyBt4A==
Received: from PH0PR07CA0021.namprd07.prod.outlook.com (2603:10b6:510:5::26)
 by CH1PR12MB9574.namprd12.prod.outlook.com (2603:10b6:610:2ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Sat, 11 Jul
 2026 00:53:11 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:510:5:cafe::27) by PH0PR07CA0021.outlook.office365.com
 (2603:10b6:510:5::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.14 via Frontend Transport; Sat,
 11 Jul 2026 00:53:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sat, 11 Jul 2026 00:53:10 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Jul
 2026 17:52:55 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Jul
 2026 17:52:55 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 10 Jul 2026 17:52:54 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH v8 0/9] iommu/arm-smmu-v3: Adopt the crashed kernel's stream table for kdump
Date: Fri, 10 Jul 2026 17:52:41 -0700
Message-ID: <cover.1783729633.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|CH1PR12MB9574:EE_
X-MS-Office365-Filtering-Correlation-Id: 457e3bb8-3297-4d46-5b21-08dedee6c7bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|6133799003|5023799004|11063799006|56012099006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	NmvA35CuF4X9BxcPkNm56TElfCABCMtoeavT12nJdyFp46W8mEK1ItjGu7eNj0Nk12OT8yvUunSeSESeZcRsdUdFBflIA+rTPPZXpR5aGts2ru5+ikK8y35HEzJETou4YkBw06vMaALVs/ikPGU7g/6vegiXmyHB59d0YL8xxTi9N1Ian+DQJDkcy56RLes/Dceb+D3Utt+jJr45fwwlzxGTtbICvhNVTozs7tBwDhhOMDrRuLb/hqcyiwMRLU24AxtcYgM6EKWjq2m8q0TcdBRLNgQqwui3U3i8wcYGHjV07ju60zEOeclwbkThT3Lk79iXtcnWOTCv0LqYs3r1GEH2SzpuNst53wWaxJx1Ygi+0vhWX/o6Nz9HtCSBtjws8AyJrrRIm6CO/nEB+hCJzw91EWglsc8RqDeXaW7kMtcvp0kAd6iVPZ2OjdxiiA32mfesPkwXWfVpeJmHLsBdNAv9una0vxw8FSuY9/KW5/1AK/gJeKqGReljvmBTRtCmFK7MYyBc9tTcGlLpEA7zUvY1l/lFm4jqnYcKT3zL6d7d2kfEmwecFqwo6PXH9DRFUk214uHfc2D5zeZzwi8II7Z6mSg14nuZHKo33EYxPbT/C+GEgdfDgRvy2zS+fessmFohOyoY+C5bT9XssLnp3sf3ypbRlQZA7NjMJg5ERB5IpdSr1HEUiy5CSs503LrgJiGrCHdsFdIc1dUpaLfZug==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(6133799003)(5023799004)(11063799006)(56012099006)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ga1mjn4HLkZpFRV7pK/fuXjhKXQi5/keux8vy8PqTMsqgVZsrRtHhqcM/CxdpRvdzS2jcb2i/SmA/cGJ8eY/gqq9nLvuen4MW5bfxdLdh57e/zHyyTUiiIPlXYXW1H3DcL+axks8atBPZK9eNqMYR/X4BQlhkZNd0Cezz0VS1BL8FCzvhWjOl2c7en0ZznCJ4eb9PkKhB02uhQVjeWOhzh4ywQO3QxGWU/xOQ1RAvgl9yUGxtbmoxihtT6xAgFrUyxbAhraxTuxAGRwwJQBd8IFDl3LG/rx5wF5CRfoh9SBv5WgVEdKRXQisidJcXA4T6DDs5bs2XbQZaAR5wtvVMCRi+gXVxQjO00pRhKLM8c90Pa45YcWaOQnfISpJUllsUF0kweQXbtMG06hT8yXdGlh5i9Vo2UGrt4RhZx+a3wLTNV9ihtNDwvdWDmVcCxp2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2026 00:53:10.6658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 457e3bb8-3297-4d46-5b21-08dedee6c7bc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9574

When transitioning to a kdump kernel, the primary kernel might have crashed
while endpoint devices were actively bus-mastering DMA. Currently, the SMMU
driver aggressively resets the hardware during probe by clearing CR0_SMMUEN
and setting the Global Bypass Attribute (GBPA) to ABORT.

In a kdump scenario, this aggressive reset is highly destructive:
a) If GBPA is set to ABORT, in-flight DMA will be aborted, generating fatal
   PCIe AER or SErrors that may panic the kdump kernel
b) If GBPA is set to BYPASS, in-flight DMA targeting some IOVAs will bypass
   the SMMU and corrupt the physical memory at those 1:1 mapped IOVAs.

To safely absorb in-flight DMA, the kdump kernel must leave SMMUEN=1 intact
and avoid modifying STRTAB_BASE. This allows HW to continue translating in-
flight DMA using the crashed kernel's page tables until the endpoint device
drivers probe and quiesce their respective hardware.

However, the ARM SMMUv3 architecture specification states that updating the
SMMU_STRTAB_BASE register while SMMUEN == 1 is UNPREDICTABLE or ignored.

This leaves a kdump kernel no choice but to adopt the stream table from the
crashed kernel.

In this series:
 - Introduce an ARM_SMMU_OPT_KDUMP_ADOPT
 - Skip SMMUEN and STRTAB_BASE resets in arm_smmu_device_reset()
 - Skip EVENTQ/PRIQ setup including interrupts and their handlers
 - Memremap the crashed kernel's stream tables into the kdump kernel [*]
 - Reserve the crashed kernel's in-use ASIDs and VMIDs, preventing any TLB
   aliasing with the kdump kernel's own domains
 - Defer any default domain attachment to retain STEs until device drivers
   explicitly request it.
Most of the kdump code is added to a new arm-smmu-v3-kdump.c that is only
built when CONFIG_CRASH_DUMP is enabled.

[*] For verification reasons, this series only fixes coherent SMMUs.

For non-ARM_SMMU_OPT_KDUMP_ADOPT cases, keep a status quo since the commit
3f54c447df34f ("iommu/arm-smmu-v3: Don't disable SMMU in kdump kernel"):
full reset followed by driver-initiated reattach, potentially rejecting any
in-flight DMA.

Note that this series is no longer treated as a bug fix, since it has grown
fairly big and most of the kdump code now resides in a separate file. For
folks interested in back-porting the change: a v6.12+ kernel (since commit
85196f54743d ("iommu/arm-smmu-v3: Reorganize struct arm_smmu_strtab_cfg"))
would be still compatible with this series.

This is on Github:
https://github.com/nicolinc/iommufd/commits/smmuv3_kdump-v8

Changelog
v8
 * Move the kdump code into a new arm-smmu-v3-kdump.c
 * Move the EVTQ/PRIQ patches to the front of the series
 * Prefix "kdump: " to prints via dev_fmt in the new file
 * Add a prep patch destroying the vmid_map ida via devres
 * Reject valid-span L1 descriptors with a null L2 pointer
 * Document notes/limitations at the top of arm-smmu-v3-kdump.c
 * Rename arm_smmu_kdump_adopt_l2_strtab() to a deferred variant
 * Add a new patch reserving the crashed kernel's ASIDs and VMIDs
 * Make arm_smmu_get_step_for_sid() a static inline in the header
 * Validate alignments of the adopted stream table base addresses
 * Retarget to the merge window; drop the Fixes and Cc-stable tags
 * Rename the kdump probe function to arm_smmu_device_kdump_probe()
 * Document that a disabled event queue discards new events silently
 * Add a common arm_smmu_is_attach_deferred() calling a kdump helper
 * Document that acking SFM_ERR is defined but does not exit the SFM
 * Document that CR0 queue enables can be cleared while SMMUEN is set
 * Clear only the CR0 queue enables in kdump reset, keeping other fields
v7
 https://lore.kernel.org/all/cover.1782799827.git.nicolinc@nvidia.com/
 * Rebase v7.2-rc1
 * Add Reviewed-by from Pranjal
 * Reword the linear stream table adoption comment
 * Use dev_dbg for the stream table adoption message
 * Document why the lazy L2 adoption uses devm_memremap()
 * Drop redundant FEAT_COHERENCY checks in the adopt functions
 * Use feature bit instead of STRTAB_BASE_CFG in adopt cleanup
 * Skip CR0_ATSCHK update in adopt mode to retain the crashed policy
 * Restore FEAT_2_LVL_STRTAB if the cleanup action fails to register
v6
 https://lore.kernel.org/all/cover.1779265413.git.nicolinc@nvidia.com/
 * Rebase v7.1-rc3
 * Add Reviewed-by from Jason
 * Replace dma_addr_t with phys_addr_t
 * Drop arm_smmu_kdump_phys_is_corrupted()
 * Skip threaded IRQ handlers for EVTQ and PRIQ
 * Bypass arm_smmu_rmr_install_bypass_ste() in kdump case
 * Drop devm_ for adopt-time allocations; set up cleanup function via
   devm_add_action_or_reset()
v5
 https://lore.kernel.org/all/cover.1778416609.git.nicolinc@nvidia.com/
 * Add Reviewed-by from Kevin
 * Drop READ_ONCE on lazy-attach L1 read
 * Split "Skip EVTQ/PRIQ setup" into two patches
 * Tighten kdump probe comment and dev_warn message
 * Use MEM + BUSY in arm_smmu_kdump_phys_is_corrupted
v4
 https://lore.kernel.org/all/cover.1777446969.git.nicolinc@nvidia.com/
 * Rebase v7.1-rc1
 * s/arm_smmu_adopt/arm_smmu_kdump_adopt
 * Revert alloc/memremap/fmt on fallback
 * Reorder patches to avoid bisect regression
 * Use IRQ_NONE for spurious evtq/priq entries
 * Cap linear log2size by kdump's allocation bound
 * Defer clearing FEAT_2_LVL_STRTAB on linear adopt
 * Add arm_smmu_kdump_phys_is_corrupted() validation
 * Defer l2 stream table memremap till master inserts
 * Re-validate L1 desc on master insert with READ_ONCE
v3
 https://lore.kernel.org/all/cover.1777150307.git.nicolinc@nvidia.com/
 * s/OPT_KDUMP/OPT_KDUMP_ADOPT
 * Do not adopt if GERROR_SFM_ERR
 * Retain CR0_ATSCHK beside CR0_SMMUEN
 * Clear latched GERROR bits (e.g. CMDQ_ERR)
 * Assert ARM_SMMU_FEAT_COHERENCY in adopt functions
 * Add STE.Cfg check in arm_smmu_is_attach_deferred()
 * Fix validations on return codes from devm_memremap()
 * Sanitize crashed kernel register values in adopt functions
 * Drop unnecessary l2ptrs guard in arm_smmu_is_attach_deferred()
 * Don't enable PRIQ/EVTQ irqs and guard the irq functions for combined
   irq cases
v2
 https://lore.kernel.org/all/cover.1776286352.git.nicolinc@nvidia.com/
 * Add warning in non-coherent SMMU cases
 * Keep eventq/priq disabled vs. enabling-and-disabling-later
 * Check KDUMP option in the beginning of arm_smmu_device_reset()
 * Validate STRTAB format matches HW capability instead of forcing flags
v1:
 https://lore.kernel.org/all/cover.1775763475.git.nicolinc@nvidia.com/

Nicolin Chen (9):
  iommu/arm-smmu-v3: Do not enable EVTQ/PRIQ interrupts in kdump kernel
  iommu/arm-smmu-v3: Skip EVTQ/PRIQ setup in kdump kernel
  iommu/arm-smmu-v3: Add ARM_SMMU_OPT_KDUMP_ADOPT for kdump kernel
  iommu/arm-smmu-v3: Destroy vmid_map ida via devres
  iommu/arm-smmu-v3-kdump: Reserve crashed kernel's ASIDs and VMIDs
  iommu/arm-smmu-v3-kdump: Implement is_attach_deferred()
  iommu/arm-smmu-v3: Retain CR0_SMMUEN during kdump device reset
  iommu/arm-smmu-v3: Skip RMR bypass for kdump adoption
  iommu/arm-smmu-v3: Detect ARM_SMMU_OPT_KDUMP_ADOPT in probe()

 drivers/iommu/arm/arm-smmu-v3/Makefile        |   1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  48 ++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c | 579 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 246 ++++++--
 4 files changed, 806 insertions(+), 68 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c

-- 
2.43.0

