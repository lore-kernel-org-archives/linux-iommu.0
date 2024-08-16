Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6442222EE5
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 00:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723769761; cv=fail; b=CvkIxIp0BQBsjhHTENTIHe6RpR8He/LrmNj2PgiYr7Qrb1beLNKVNGv9nmepQJc9Pn3qiiXEgX0IuHYvaGxo/NLG4nzSTWfE1lxtUuKQZ3r2IgoyU0jdJI7TtjlgaZ9E2JJTAEz3dhID9p3HJbxsqRspZFaUoWqpBHupCyADFHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723769761; c=relaxed/simple;
	bh=9ePdthn8wCTly7P6XxrnANYZgwHP20JFvTomXoP8FfY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WgkkrsoR9lPVmbwV+QF3dfp0SlkwN+pnOsaE0KdTBV5JYJTmDH12k/Ta8jIXSQs333ined8Qq3X83XylRUfh0JxMnhXQpBLDyf2IcslQnhAADGSX0xR950ehTUJ+XEoc3ZyVdTNQ5doJM+Uq0wqnkxr569za7wvu7OHH1a3SWe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nqIgpIWa; arc=fail smtp.client-ip=40.107.93.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nqIgpIWa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pvXPtVvmJvbe41836ttpf5AwO4g8fYOxKyflGj0eA1OnuomrhxKMYM9luHdDH0yyebQdrPLnMkkY78g66LtTc5YTP42csqwzdLtSpxXvUjua2BAnEdl8sv2ykCh1QZMbHJzlECfxCLAQwPuyUjy/kkqoRY+i+t7BX/dvVmnGQEwphxTsXPE5nGAoSlaSiPK7o1rcBa5y74k74ur7UHeeUIyxQVh5jK+Sal/rdQHLrf0W7X3A3vp0C6OiXYZj3daB/BceqXIogXboiFmZ6ifMazlAUYIG3XoCz84rENvFOKkmH9vdjUw5Zq4C3suexaFG86dp5Z4DOIyDxtrWQFNKgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoXaBI++pygnxvne1FV1ewwCyaipWWAPRWHuzQHuPNw=;
 b=ljm8dFiC78HZScVDCiRJFJC16HW9XswrvBH0jJn494p0YxPDSyEaknOGqgvkLwsdC2WBo5lxgWpxWdEhVypugJ/umwyqMD3K+0oLLJQaybh3EtwWoxkzINdac7Oj7GdGZYaGqAHWjTpPQ9QEMAcnqrDjgmbf98/D1XrDeqV1HErePZBALRHyfndByNw6vWOl7FilDAriymYvu2sy/c+GudrtXaxAHLLLb/qIuxCUtsJP3kBWZfyI3l063M3KHHzvd6rLhRsH4jt5NJJuWSsBJfGsC1aQ+NrudQdp7QpTs13q0myO43u+Wi7qAk+rrIRjIkpm4D6SFM46Hi2xm173cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KoXaBI++pygnxvne1FV1ewwCyaipWWAPRWHuzQHuPNw=;
 b=nqIgpIWaXmosR5U+0GXjTU1itorlW4ZOntabn2sHrEwhhXOxrtv51ddej1Gil8MMl1QcDYJ5FGPBzk/EgbQkj7u8sPbCqAttGrr6DBygmaf7UhYscSEPtplcmgzpbC8cWqb+zEY8pCD/PFHdGx7kYtuquLMcwH7yRlEKBT2PjeL/MumLwQFrKgIu5tifN4P1pycWnHlLdz4ZZGp4Mds6Pae4euduPfVMlfBPqMyxDLag7eTe8/zDT/00QQSASGFstmGPsGcupkHggO1hNyw6iSSVoCr2UE/FuWRF9ZV/SHfA9stKNspd+YzuNV+04HdlkyZnZ9kDMBoj7p5flTsGBA==
Received: from SJ0PR05CA0193.namprd05.prod.outlook.com (2603:10b6:a03:330::18)
 by DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.19; Fri, 16 Aug 2024 00:55:54 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::d0) by SJ0PR05CA0193.outlook.office365.com
 (2603:10b6:a03:330::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.15 via Frontend
 Transport; Fri, 16 Aug 2024 00:55:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Fri, 16 Aug 2024 00:55:54 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 17:55:38 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 17:55:38 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 15 Aug 2024 17:55:37 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v12 00/10] Add Tegra241 (Grace) CMDQV Support (part 1/2)
Date: Thu, 15 Aug 2024 17:55:21 -0700
Message-ID: <cover.1723754745.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|DS0PR12MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: decbb9ce-7b6b-4e41-2187-08dcbd8e2e8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DzWnrNMtl3QnkpO/yxE8oCHO+o/JR2hq9rnjmHgILfZ7aiugaBdobA25yPQ7?=
 =?us-ascii?Q?fZLocqVOddbKMZIwV436gcBBzPmuLNrz80CWtO8nqqH3d/GbAofclh8KH4NX?=
 =?us-ascii?Q?TQrGhPBx/GwKKK2dAG63hNxWdMsMK2Wil6ZUcXqj1TkSU6tP/Nvm2SxM4y47?=
 =?us-ascii?Q?G4exHa3iB0l0GDOkw0rpY4pRX7GA7qcAyyXA/Jon0pgPsFqz/oDytKhZ4vmA?=
 =?us-ascii?Q?Xm+s+8iOP3kdECDXNyX2V5jhgZO7U3kTF53tmqtpUyiq5CBezDwnXiLpYa2C?=
 =?us-ascii?Q?eYWY+YbLWOes1DYwFQ7JkzNzoXsD7zC44X+F0QB8TQ5d6UlWsP9t5qRpVIQu?=
 =?us-ascii?Q?3tTH7pFxEnuPZhWvUUuEg1c+JeIjNHapyhpkFePFB2mYQteBYcvm5iak8iL4?=
 =?us-ascii?Q?JByyS7mugfbi19/zt/4OtlY7SC6SpswXrCh3qERSXX8R4vvaSzGrcKbyRt9V?=
 =?us-ascii?Q?4fa/+0yPn8MVQOfBbdnVi97shfNHE82bDuJmdjtv1XSbAJ1+2jfNxROx+XB4?=
 =?us-ascii?Q?Qn6Ea0C3wPKq43XluBBL86i4UKp9+QC3ZtgEdPw+qYvuTmi3t4kOizbg5opA?=
 =?us-ascii?Q?Vp8UImrYojVZv70mk1SdJ01KwSEitVBxxKa7Z7Ndw5vEP3ROCsttjBJ/ceYS?=
 =?us-ascii?Q?1Fu2G3R/+NyHRwwx/a0opmckr0XHwOj11XDo4NfJ0KIyzud4h+ky08d1gB2Q?=
 =?us-ascii?Q?Nf8niPYA9tAnYV1mdXQH04ypvWdgDy4YD+K6cVvOJGov7nkn+uj3FEY2ZVu0?=
 =?us-ascii?Q?f1u4bRxlyueymgmmY7GX/ZyFGAAy6a5M533WhGYmVVhrmCofN2rJ86lSx/SH?=
 =?us-ascii?Q?R7JWbFtcKoJXCsTMuUPj789geBP1VALjfmY8AR82uarultM87zeVqyGoJ3wG?=
 =?us-ascii?Q?QkLdbBTKD/ESR7QGEdF0hp4WMYwUA2NInsn1CAwvi0XYWFrTDYM+XU2nZQth?=
 =?us-ascii?Q?stpPjsHnsl/0Fok3l5EvFWb5J1aDw9OXAj3q36B5J7SdWcPA4PrG7Ov6Vunu?=
 =?us-ascii?Q?QuSSIUeqS2359lvEit8XbfNtHMNlRDto/yGunRlTkDdPUZlCJkeKFV1o9kgB?=
 =?us-ascii?Q?xKbfc5v04LIuwp08QDu8Qbpa8KLqwhoEJ3/JOJoslDbC+OrSwQtonbYT/PSu?=
 =?us-ascii?Q?UO8w2xFFlv+K2cRr1oTgRD7xutzDvxMQ6RPBNpkqrq/wkwjo4OcIcmyQ+sxm?=
 =?us-ascii?Q?0nbcTGLw/fIJ8T1B0sfv2iOy5Ad345sEUKkSVkA2efUgyHPQJ/mnHi/srBAh?=
 =?us-ascii?Q?ZdLmqIQMqbDbJQqnzKqG+09CRkbtUyam98TE86eJ/deBfaVtXhvCTMj9FaRr?=
 =?us-ascii?Q?LQDbX0YWl7m1aL1Rc/yS8gFzoL3li1TioXBUVPFd5s7ow8tQemXF6ZdyZpLo?=
 =?us-ascii?Q?hWVBRm69KGmttgvv1ePdl841KmkVY/qCFI42rwJW9omY0dcVh51yzExhANOu?=
 =?us-ascii?Q?Nyd08zeV4e4OSSDYEEvQRtGtWgwvQ4zc?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 00:55:54.2837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: decbb9ce-7b6b-4e41-2187-08dcbd8e2e8d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6559

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
https://github.com/nicolinc/iommufd/commits/vcmdq_in_kernel-v12

And the part-2 RFC series is also sent for discussion:
https://lore.kernel.org/all/cover.1712978212.git.nicolinc@nvidia.com/

Note that this in-kernel support isn't confined to host kernels running
on Grace-powered servers, but is also used by guest kernels running on
VMs virtualized on those servers. So, those VMs must install the driver,
ideally before the part 2 is merged. So, later those servers would only
need to upgrade their host kernels without bothering the VMs.

Thank you!

Changelog
v12:
 * Rebased on 6.11-rc3
 * Added Jason's Reviewed-by
 * Added an arm_smmu_impl_probe helper
 * Added an arm_smmu_get_iort_node helper
 * Slightly updated the CMDQV acpi probe()
 * Added a static_assert() for smmu in struct tegra241_cmdqv
v11:
 https://lore.kernel.org/all/cover.1722993435.git.nicolinc@nvidia.com/
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

Jason Gunthorpe (2):
  iommu/arm-smmu-v3: Add an arm_smmu_get_iort_node helper
  iommu/arm-smmu-v3: Add struct arm_smmu_impl_ops

Nate Watterson (1):
  iommu/arm-smmu-v3: Add in-kernel support for NVIDIA Tegra241 (Grace)
    CMDQV

Nicolin Chen (7):
  iommu/arm-smmu-v3: Issue a batch of commands to the same cmdq
  iommu/arm-smmu-v3: Enforce arm_smmu_cmdq_build_sync_cmd
  iommu/arm-smmu-v3: Pass in cmdq pointer to
    arm_smmu_cmdq_build_sync_cmd
  iommu/arm-smmu-v3: Pass in cmdq pointer to arm_smmu_cmdq_init
  iommu/arm-smmu-v3: Make symbols public for CONFIG_TEGRA241_CMDQV
  iommu/arm-smmu-v3: Add ARM_SMMU_OPT_SECONDARY_CMDQ_CS_NONE_ONLY
  iommu/tegra241-cmdqv: Limit CMDs for guest owned VINTF

 MAINTAINERS                                   |   1 +
 drivers/iommu/Kconfig                         |  11 +
 drivers/iommu/arm/arm-smmu-v3/Makefile        |   1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 188 ++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  51 +-
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 905 ++++++++++++++++++
 6 files changed, 1090 insertions(+), 67 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c

-- 
2.43.0

