Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CD42BB09
	for <iommu@lists.linux.dev>; Wed,  7 Aug 2024 02:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722996740; cv=fail; b=Lz4HnVfSRz9aZTOaqSSr2NaBTgw/Q/erG03GKh4uixUj8eSNl3v2r0n1+N4ejTQqJfPToOD4QLx1ITNniIbJt5EJiSSHC0OdddoWpzy7bMYVaEsJVZrF9L5yKvrGSEIvLmyCaa1g4c3To5kTuKTclkDpcb1wf2PoZZ8GDFbgdl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722996740; c=relaxed/simple;
	bh=ioS8E6CBw9x8q6KLoJ/Myv+kkMnoQHzGrmo2dQv73pg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uHNcfBONUaiovyCgizwLdSsWt7G1DNoVV7npub/Zd+SV88gOUz/iuxjvjXj+s/hZi+yoJLM/zfW8r99+hqJvW6WYZJZprvIPLnx7yFvMdAVeNe5KbMkObgmi2atSsXRle2Wr41iEvc1wI+DkV6vdI0C4k7pFfWzrX8iIofB1WbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GjO9UE1T; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GjO9UE1T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZm1XnWrC8pDOZeRcUGcD/m3BpCj2znbkDiQIwxuRJElXqwWvtS1Xhrw5Ms7OGAnTqCjO4Co8LJyww/zd3YFoQCDLt7HWxciq8GlBl687vF4NMWO8Oy7396ZzuWx/14ObrMzR2IAM5GsPMibGdVtG6iCr5En1I73xwZUYHdwMOSQAyEB5yG8NvGX+PFLiYxv/S0wjprZTvHh6i8RPBjBAaNfgf/v+IcE8NelM35aZGoVY00I3uzGGoUkbkWWH8E6F6Wno84NhR/SNMkyuV3wnk5GvMO7W+MlkLaUF1xkcztRJeW8OCILIbrRXqR9xP+6GrUqCrypry0lli7j/z4exA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ME3lqSijuKjY6D5f/l41jzaeOlrGkcM+XCKih3NxBdI=;
 b=cO15yDB1JT+biPSDKKBMF+ExaF21egg6wgf1rcmnBJ31rb4N8un4CPLxhXoEjykL7cMIw0XXsHSHFJKyLpTVGbMZJMPFWi1WA3Kz2DI/nscSWdefQ6MKCAbiIub1Nl3ZGPT/uK3FxL05zFXXTChptl+GugNLGL/PzEzjl0AsGcaAsqoPV3dyAH5F0IN6crerSqQzygBJtbz21MUUiKLTG7C8j7qER/k9R+3V49hsuAXgqG8nuueJnjy0UwCL0hpyXv7cIablW95nPSxQ95FWre6nLFXIH1ZHPud5wLv3m9prCWzy4jJj5LT4ZT0Xw2I3AAxeV4FH6jVZEbdMFd+jMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ME3lqSijuKjY6D5f/l41jzaeOlrGkcM+XCKih3NxBdI=;
 b=GjO9UE1TdZ+djsCqhCuQwPUyVgceMfw4qTeSMJLvPISNfDgd1NkgIOfJ7F7+VDiy8Uj9SCdcxyUQeMHiy6CY3irMjpL66K1CUDM1ZDRq6wtRlx1CCTOML6JH98BBEj84WF5l0Tj53EfE/uOH0jJC5PBz3/Dnp6WKbpZhZQgVaBCp68wSc55/8Z3U7i/x9tZuJOTFtCFRxlreOtpge83QCKCnGG7jx5OsShpTjC6Acz8CaOlsQ1XSco4OIQ6kJabTtj20L1Xga97vE1Hhi/WW+nVqgu7oOqdk362dazJYydlmaU6B00rQBE6T8mecPXSc6dqQzlD16yrclraf14jMbQ==
Received: from PH7P221CA0048.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::8)
 by PH0PR12MB8776.namprd12.prod.outlook.com (2603:10b6:510:26f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Wed, 7 Aug
 2024 02:12:11 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:510:33c:cafe::ee) by PH7P221CA0048.outlook.office365.com
 (2603:10b6:510:33c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29 via Frontend
 Transport; Wed, 7 Aug 2024 02:12:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Wed, 7 Aug 2024 02:12:11 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 19:11:57 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 19:11:57 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 6 Aug 2024 19:11:56 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v11 0/9] Add Tegra241 (Grace) CMDQV Support (part 1/2)
Date: Tue, 6 Aug 2024 19:11:45 -0700
Message-ID: <cover.1722993435.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|PH0PR12MB8776:EE_
X-MS-Office365-Filtering-Correlation-Id: 885715eb-93dc-49fb-a2ff-08dcb68658f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iN0/g1KrqHpyasZxXIRYQQ+fg37wNx+S93WiOYe5vFtCB3ihzM+Eha1KZUik?=
 =?us-ascii?Q?M2arl3Aq41pVuw2h/658a18MGuN4y0GCL+p5+1oQ4nhA2tV9dwAbY6t6ZkaY?=
 =?us-ascii?Q?xzk/aQSyOUX6Po3ZZiTbzU/irP1GBsOILgpjGeVEj+2vCPqvJ6gEMNfEhzs1?=
 =?us-ascii?Q?rAMo1UbseG7ISLJsBUJMp2yJwT4TBjA0Wmx1FzSOH4srxncHcoM/wTiPEwMm?=
 =?us-ascii?Q?8u2lhutX0vbn8Adv8BC1ZUle81EPTWsl18l5FVOvEOOgKyuo0qVzG2zrFiQq?=
 =?us-ascii?Q?uEpDZf3pMtS5GiDiFrNjZoqks/7PZsV2CEZHyi5oMV7MThlkec+1OHgbkWJB?=
 =?us-ascii?Q?7Tk5DJaLFtHq/NKbH1pidFRBYWhmNw0FrNrjc3FzxQpFbepxdWaM8v9xK/Sm?=
 =?us-ascii?Q?uObBtmU+Yso8xlUP0l+uxb5HTVwwTU/7OgswxxyVhuqcgkyr40xy+9BOyoLO?=
 =?us-ascii?Q?DC1nfgBQ913dghVKpdNuZxkEll9j0E44vZGNe5luZ5DPss8WO7O5OHxwH4AW?=
 =?us-ascii?Q?Gtaeu2KBRv1BLcPUKL4MlUvmUDD1QK44Gw6DplpVEkKmeBd4T9Hr7cNehcW5?=
 =?us-ascii?Q?/T01YPWjrzvSFXFmWX/XWdtjRkX3l96UPh7QjX9JTRPGQSe+ADjSyhCZmlaU?=
 =?us-ascii?Q?qbLdWVOX12qCWTslIhvjXAlkFbi1KeBAwrQoBLovCxhgQKfDB7qmMwZKXdjs?=
 =?us-ascii?Q?maQpOLYpOCWz2uRcvw8r86v+7a+TaYIoY+Ltw5y76PVyoxd7qBbsKjHnaG8P?=
 =?us-ascii?Q?/sE1AXJPxOzKpnMHmNmYQKROm9KiBqEvuHMgDo/i5ucUgHLI2K1V81qwWO9W?=
 =?us-ascii?Q?lH2eT/YI+3w/+E4MI1j3Ucwqo2lQRNrHPt0nNXFojf6OPjwQM3n+Q61DIhtd?=
 =?us-ascii?Q?pkCv4/Z7MQ+I0pS6JHWq5k7ITAsfOeGRzCxrAtskhAxsL45C+kEYL4g4NuWm?=
 =?us-ascii?Q?+Jv1lKZuXrjKe/uMMwsegTL3/wgaRn6jtzrCHNYmOXvDInycZ154c/DEkW4P?=
 =?us-ascii?Q?QUjwC46/D30fDeDEElN6WnLCGYowUfofM887/eSuC0igIbLWpnzk3PTYqLvf?=
 =?us-ascii?Q?laYMYooTg6isfnFpUBassA52dIh20PYP3+9gxSXLj6vEaR7psqAdcY+DMWPZ?=
 =?us-ascii?Q?eDHG3rvWJThMzPHJIP/wP9XwqtWv+vG2jqDqnCd3SCPUiAO006QdTZD+pX4k?=
 =?us-ascii?Q?YMUVStZk0B8nvpiVRgELCRRe/eyEORd4/e2x4fAPqyKTzjiMP2tC7rdz44/C?=
 =?us-ascii?Q?7M/manr3snYN+aRdsTKclSkHWmQRR8PhB2GnpGZCtNireU2ZqtvRpLBXyajt?=
 =?us-ascii?Q?Lgwi6kvAYt3F31g88tHaqfrP5woK+pVi5QN/NhhkbFk/3H5rSuXeLEJ/ecBn?=
 =?us-ascii?Q?3kb4kW1rRTNtf61Ch/Jvpx0Kgih+y2KixZsys2nrd93Nlwy//h/JGbpuRlXH?=
 =?us-ascii?Q?3WHVt3lmBSpNGBNrLI5K2sG46b5McQP6?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 02:12:11.2399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 885715eb-93dc-49fb-a2ff-08dcb68658f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8776

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
https://github.com/nicolinc/iommufd/commits/vcmdq_in_kernel-v11

And the part-2 RFC series is also sent for discussion:
https://lore.kernel.org/all/cover.1712978212.git.nicolinc@nvidia.com/

Note that this in-kernel support isn't confined to host kernels running
on Grace-powered servers, but is also used by guest kernels running on
VMs virtualized on those servers. So, those VMs must install the driver,
ideally before the part 2 is merged. So, later those servers would only
need to upgrade their host kernels without bothering the VMs.

Thank you!

Changelog
v11:
 * Rebased on 6.11-rc2
 * Fixed "vtinfs" typo in kdoc
 * Maxed out the max_n_shift to hardware allowed value
v10:
 https://lore.kernel.org/all/cover.1722206275.git.nicolinc@nvidia.com/
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
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 901 ++++++++++++++++++
 6 files changed, 1090 insertions(+), 74 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c

-- 
2.43.0

