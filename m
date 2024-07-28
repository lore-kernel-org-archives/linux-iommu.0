Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970FF78C99
	for <iommu@lists.linux.dev>; Sun, 28 Jul 2024 22:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722206707; cv=fail; b=JYL3TqGuO6rmOE8ybPzVsACrxE7er7hZlQj1b+6PTXW/2isA9WBbGlW7v/m3br0dQwQl1LzqMOAgbZbEAlkHzT0IFLA7/zTLiPBadd6d8uew//aEMEIhj+8epRjxQXncHhtnkGixqnwkLpklNIDPprh0t2fVnyNKSwon9DRO2QI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722206707; c=relaxed/simple;
	bh=SWIn9yUFWAOPugRLnbXN6H8tSBYXvuT1iv1VDJm3wWY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GeMOo39ResVN4BQv4YpK9lyOnBqMgRVkEGSoLC8rsUszkPV7i/AOoLhrguQgbxKg+da92NxwRvA0sw0biVXYiqwik3ifdjY/aZd7aXtnRMXR6OL1iZFiEN8ztofeP5n2qdrCv7VJ3tcn5rtiadfYcX7SGeMGQ57UjoYHwFfUGus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tR8UVdvH; arc=fail smtp.client-ip=40.107.92.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tR8UVdvH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bUbIGUeZeb155GJ9UuzFVTpYO8CFGpy5iUgpknuT+0gXjE5YB0Fm7dDG4zZbD96r7MUDBxb3HqfW6n46vEG451SQnPm7UJ9Uor5qFbyNoblrJmAKSrK8f/O1Ladopatx/ef3FgLmETw089/zvTdeQPoE+O2YC3gzSsUD2xb+cWQQ7h5ijYhyDnY97nn7cxx1VfggrTOuINH0qG6FzHwMZwQMWbPXm88TsBmj1hRjYsRLLzBd0ZoDY484Pwqkwo6nC14gVTVmUhR0MwW9V0nD0dgiyxJnOsgcYzpr9O6PPXY0VmpmbxnIejFvV1823QMi9coV4hsJdsQMzv88LHVdhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=syLkA5aejnk8gtyQUeRI9psTwAu1dQmMNEPD4kuqTjA=;
 b=plR+hwZ1tNT9cdNLTTNm/6N9trXrUsQJlveqprsdeajzumKaIe0amP7pPQIcNRYQGdLM+6cWBkJLteC4jlco5IU91h6RAz+5LiSWTO+z3td7IoAtbr3bxfIuEV6QqAsqA8tuX8qhLKYmJyy5JOn5DgHw8qtTVcoK0km1zOyQtrAtY71BBxPSy9yCHHNLiakCC8oMuJiWIE9aFvb7Vu/Iwgj3U1k8MYKtvGZ/nJQbkEUukE5xu6QAAruYtAGGFQvW3tSRAt8a+WYB/s3xjIRkThnq9PXNlOHG9wdqRuvd5TKL+GkG870cNqKRdHeNWeeN+J6L8Z8ZcO572d/kb8lNQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syLkA5aejnk8gtyQUeRI9psTwAu1dQmMNEPD4kuqTjA=;
 b=tR8UVdvHGIesMemSMJ1+n8l2sR7s3c3DAXbBWdWs+GlVqLSkGnUsf8VUsjfr7u1Uojb3YXG4ADoDnupQrmS3yt8Ze+RDKuufMH2zIV+Fb2TtOG/PQUx5aNp/rlBQmLCjSgpX2zYm8C1/ye+RNq1LN2YbjafrPZ6gs4HXcdFPY+ROF8JFBql13zXxNYxq6+Ht8ctllhMWOr/r+w1pUI2yZWirDHrWHXO+LeYU1zgSmNrVXcbOZmPOVrqFSDCOzvHD1AutjEUkVaxAvHKaeubUiZv7KpMVf+T9v7axR23ve4DrLmGEAWUczD1KWXDgqqluZJEI/DnBI04qBf0yC0yH+w==
Received: from PH7P221CA0087.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::23)
 by DS0PR12MB6485.namprd12.prod.outlook.com (2603:10b6:8:c6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7807.27; Sun, 28 Jul 2024 22:45:01 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:510:328:cafe::5c) by PH7P221CA0087.outlook.office365.com
 (2603:10b6:510:328::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Sun, 28 Jul 2024 22:45:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Sun, 28 Jul 2024 22:45:00 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 28 Jul
 2024 15:45:00 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 28 Jul
 2024 15:44:59 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 28 Jul 2024 15:44:59 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v10 0/9] Add Tegra241 (Grace) CMDQV Support (part 1/2)
Date: Sun, 28 Jul 2024 15:44:45 -0700
Message-ID: <cover.1722206275.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|DS0PR12MB6485:EE_
X-MS-Office365-Filtering-Correlation-Id: 05e7b9d0-b9e5-4ad0-aca2-08dcaf56ea22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vl3bKPRg7d0qoSHchiLXHULShaywrPU2PtIGnDKTPtFTQJii/6M73Zc9yYJA?=
 =?us-ascii?Q?/g/ScBnoer9YkJQ1pEOHKA1EhaxGPVE29NU0sT1vFwXES2vqG1NnSsG65Pe/?=
 =?us-ascii?Q?xI3AOmVNtfCFBJ+1UxFiBrzTusqeuMqiSQpZnUVSZ2O67YmyWAhzN9ggQ+K1?=
 =?us-ascii?Q?kEGaWW7FZQ5yPM5gO92jHl6QGGxofwLBrO9S7f9dex0LN6rIeuSy16WSU0sq?=
 =?us-ascii?Q?ClfuIcqwZeWQG9GCg8TGCEK+w162jch+y0UTtO/bxgOS+gguGyrArObKkpNo?=
 =?us-ascii?Q?1Z8XvcgbIp4R6QJV7f3uC7B25wNc9lo3g7vZDCUb3dfNIzgawWLdZt10GG6e?=
 =?us-ascii?Q?hVmCHxaIos5aRXL/MVm40CXVpTstZbZ+jfwb70cWE6D8hUZzWa2Kn1ISt/zF?=
 =?us-ascii?Q?2cT/zl65/PFnHvQe2Dp8qbquvGsF0h4d6htOz2pw0YGx/3ri2jRJkt5Idf7v?=
 =?us-ascii?Q?37EvucOE/4itQjUKFAlmilBVzYcWd8axrm5kHBHHi63e9irU0Tj4GMWwnv98?=
 =?us-ascii?Q?1JNxKkpYLeoi/yniRfcmg7NitDZsDMwBPVsKXb4NX6i6m7RS40+xzusflKWH?=
 =?us-ascii?Q?LCMmPr+JsKXnOC3ecRpiFqw7znIqHtdTB7GOX2CbQGbKD335xdMtB5crYeg8?=
 =?us-ascii?Q?g8G3h7Nz6HYCpdufWZl92Aon1ri5AwQAQoLM+26o5ckQel0zC4yUS+PP7z1W?=
 =?us-ascii?Q?wulpC4POTe+WP7bou9MJptZ5KLEib/9WiGbGFlJ/kFsLGOftkDGhN/198FQJ?=
 =?us-ascii?Q?AKfzC55m5DV9ZbfrCJFhLhbhxMGu88ERoflhEMZbLs9rCms64inY24Czmwjy?=
 =?us-ascii?Q?b7hYuivlEKbtXhpZkCPAWO486gRWsLMooieaksuG4QX0slPT2ApuC5km0+gi?=
 =?us-ascii?Q?8uYtDCYLcvKaiTV6SK2NpWtPh/st+lmu0CS90pp+smLFQ1pk64iy9uGR1wyw?=
 =?us-ascii?Q?GFFayOlrHD2oFERzwHEZYeH0ly8mby5pw9PMZf8AbwYbVZ0BeR5YKf8rlBLB?=
 =?us-ascii?Q?f4MT6Q80IrJnvljoK3E7Xl4kXz1guQixzrvTdHBkUAGID9kVca2q/MuwwYzu?=
 =?us-ascii?Q?Co4kYKMlE/8ytXK4vtULG1jubcUvnEB36RUUD96gqcySOHdeeSG4vU0UF0zk?=
 =?us-ascii?Q?sX3sFc14wNIBIXal8evaFuCmaR+JEee9pfBSYtZG+0/qS4Z/CL611+A4uUDY?=
 =?us-ascii?Q?sGG8ZfJ+874jn0yhvf/kI4GNePvP0EKAgyrngpx5Y+cQtKTTNQlFN7DvSp0O?=
 =?us-ascii?Q?zEf8Nswn7ru1uDLjIs0SwExGhiKJ2TKZblOIc2yy+3F278aRxi2tpeSO5QJC?=
 =?us-ascii?Q?4Oy/bScMvK40qL+1rkMwBRRFsdem0XhU41u5qfJt3i5AuKaCJUs4kgC/bEEJ?=
 =?us-ascii?Q?MZWymF/zRHmIqVcxiZHQxZPctOKr5z3T+EuZsVuzAVsoXjtg2xsOuw7MQ7OG?=
 =?us-ascii?Q?L1Y9Mv2c06YvNYmQxMgTpbAA5oGEtkqCP2b9Yhv9cGK+cyS6+THy/A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2024 22:45:00.9175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e7b9d0-b9e5-4ad0-aca2-08dcaf56ea22
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6485

NVIDIA's Tegra241 (Grace) SoC has a CMDQ-Virtualization (CMDQV) hardware
that extends standard ARM SMMUv3 to support multiple command queues with
virtualization capabilities. Though this is similar to the ECMDQ in SMMU
v3.3, CMDQV provides additional Virtual Interfaces (VINTFs) allowing VMs
to have their own VINTFs and Virtual Command Queues (VCMDQs). The VCMDQs
can only execute a limited set of commands, mainly invalidation commands
when exclusively used by the VMs, compared to the standard SMMUv3 CMDQ.

Thus, there are two parts of patch series to add its support: the basic
in-kernel support as part 1, and the user-space support as part 2.

The in-kernel support is to detect/configure the CMDQV hardware and then
allocate a VINTF with some VCMDQs for the kernel/hypervisor to use. Like
ECMDQ, CMDQV also allows the kernel to use multiple VCMDQs, giving some
limited performance improvement: up to 20% reduction of TLB invalidation
time was measured by a multi-threaded DMA unmap benchmark, compared to a
single queue.

The user-space support is to provide uAPIs (via IOMMUFD) for hypervisors
in user space to passthrough VCMDQs to VMs, allowing these VMs to access
the VCMDQs directly without trappings, i.e. no VM Exits. This gives huge
performance improvements: 70% to 90% reductions of TLB invalidation time
were measured by various DMA unmap tests running in a guest OS, compared
to a nested SMMU CMDQ (with trappings).

This is the part-1 series:
 - Preparatory changes to share the existing SMMU functions
 - A new CMDQV driver and extending the SMMUv3 driver to interact with
   the new driver
 - Limit the commands for a guest kernel.

It's available on Github:
https://github.com/nicolinc/iommufd/commits/vcmdq_in_kernel-v10

And the part-2 RFC series is also sent for discussion:
https://lore.kernel.org/all/cover.1712978212.git.nicolinc@nvidia.com/

Note that this in-kernel support isn't confined to host kernels running
on Grace-powered servers, but is also used by guest kernels running on
VMs virtualized on those servers. So, those VMs must install the driver,
ideally before the part 2 is merged. So, later those servers would only
need to upgrade their host kernels without bothering the VMs.

Thank you!

Changelog
v10:
 * Rebased on 6.11-rc1
 * Added impl design mimicing arm-smmu (v2) driver
 * Replaced the CS_NONE quirk with a new smmu option
 * Fixed misaligned 64-bit register reading in the isr()
 * Explicitly assign opcode to arm_smmu_cmdq_batch_init() where
   cmd/ent might potentially not be initialized.
v9:
 https://lore.kernel.org/all/cover.1718228494.git.nicolinc@nvidia.com/
 * Rebased on 6.10-rc3
 * Replaced "base + offset" in write_config() with REG helpers
 * Added "Reviewed-by" line from Jason, to the remaining PATCH-5
v8:
 https://lore.kernel.org/all/cover.1716883239.git.nicolinc@nvidia.com/
 * Added "Reviewed-by" lines from Jason
 * Replaced memset with a simple "cmd[1] = 0"
 * Replaced MMIO read/write helpers with REG_* macros
 * Dropped the racy static string in lvcmdq_error_header()
 * Added a few lines of comments to arm_smmu_get_cmdq at the line
   calling tegra241_cmdqv_get_cmdq()
v7:
 https://lore.kernel.org/all/cover.1715147377.git.nicolinc@nvidia.com/
 * Moved all public symbols into one single patch
 * Enforced a command batch to use the same cmdq
 * Enforced the use of arm_smmu_cmdq_build_sync_cmd()
 * Reworked the tegra241-cmdqv driver patch
   - Dropped logging macros, cmdqv->dev, and atomic
   - Dropped devm_* and added tegra241_cmdqv_device_remove()
   - Moved all structure allocations to cmdqv's probe() from
     device_reset() where only register configurations remains
   - Switched the config macros to inline functions
   - Optimized ISR routine with 64-bit reading MMIO
   - Scan once per batch against command list
   - Reorganized function locations
   - Minor readability changes
v6:
 https://lore.kernel.org/all/cover.1714451595.git.nicolinc@nvidia.com/
 * Reordered the patch sequence to fix git-bisect break
 * Added a status cache to cmdqv/vintf/vcmdq structure
 * Added gerror/gerrorn value match in hw_deinit()
 * Minimized changes in __arm_smmu_cmdq_skip_err()
 * Preallocated VCMDQs to VINTFs for stablility
v5:
 https://lore.kernel.org/all/cover.1712977210.git.nicolinc@nvidia.com/
 * Improved print/mmio helpers
 * Added proper register reset routines
 * Reorganized init/deinit functions to share with VIOMMU callbacks in
   the upcoming part-2 user-space series (RFC)
v4:
 https://lore.kernel.org/all/cover.1711690673.git.nicolinc@nvidia.com/
 * Rebased on v6.9-rc1
 * Renamed to "tegra241-cmdqv", following other Grace kernel patches
 * Added a set of print and MMIO helpers
 * Reworked the guest limitation patch
v3:
 https://lore.kernel.org/all/20211119071959.16706-1-nicolinc@nvidia.com/
 * Dropped VMID and mdev patches to redesign later based on IOMMUFD
 * Separated HYP_OWN part for guest support into a new patch
 * Added new preparatory changes
v2:
 https://lore.kernel.org/all/20210831025923.15812-1-nicolinc@nvidia.com/
 * Added mdev interface support for hypervisor and VMs
 * Added preparatory changes for mdev interface implementation
 * PATCH-12 Changed ->issue_cmdlist() to ->get_cmdq() for a better
   integration with recently merged ECMDQ-related changes
v1:
 https://lore.kernel.org/all/20210723193140.9690-1-nicolinc@nvidia.com/

Nate Watterson (1):
  iommu/arm-smmu-v3: Add in-kernel support for NVIDIA Tegra241 (Grace)
    CMDQV

Nicolin Chen (8):
  iommu/arm-smmu-v3: Issue a batch of commands to the same cmdq
  iommu/arm-smmu-v3: Enforce arm_smmu_cmdq_build_sync_cmd
  iommu/arm-smmu-v3: Pass in cmdq pointer to
    arm_smmu_cmdq_build_sync_cmd
  iommu/arm-smmu-v3: Pass in cmdq pointer to arm_smmu_cmdq_init
  iommu/arm-smmu-v3: Make symbols public for CONFIG_TEGRA241_CMDQV
  iommu/arm-smmu-v3: Add ARM_SMMU_OPT_SECONDARY_CMDQ_CS_NONE_ONLY
  iommu/arm-smmu-v3: Add struct arm_smmu_impl
  iommu/tegra241-cmdqv: Limit CMDs for guest owned VINTF

 MAINTAINERS                                   |   1 +
 drivers/iommu/Kconfig                         |  11 +
 drivers/iommu/arm/arm-smmu-v3/Makefile        |   1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 199 ++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  51 +-
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 900 ++++++++++++++++++
 6 files changed, 1089 insertions(+), 74 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c

-- 
2.43.0

