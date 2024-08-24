Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF1F64A
	for <iommu@lists.linux.dev>; Sat, 24 Aug 2024 00:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724458269; cv=fail; b=S5fmOMAwtqG8XXuqXdiXvqld61mEoLM7j0WCT2+TiewV5QwYJH0k/oAAl3nMHsCTfmRhQdGOZW9JWBgNMOq6H9FgF23NqYll/MgMc8Cmxjj2RWJhAA1zSPcDofL8Q6+Dwrr8cCU145qa9GfcNHUX92wUqC0Un6UNrXcd8xGSBYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724458269; c=relaxed/simple;
	bh=hTBCwOLZhUPAQmoFOls1BbrUHpngCui2zdIZcTw01EU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EcKmqpU/nPP+WmlNiYs0fe2T/vJ0dp7GJKy0Ay49jA6xkHf3mPShYFXd0XUrXc2GB1pATwey3Pm2uY9vfqAKIkVeGezA0MBIN0WEb3tNpaoKm5p1nFijzZvMWk36IETLdBCoH67QAedEsTPVCafntjV9k4Rik5PlhtvG3hAgOmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rNBeN0jq; arc=fail smtp.client-ip=40.107.102.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rNBeN0jq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p4hB6GLfjJ5/2rJ8E79OfA2f0Xr2G9OwJsz9LOVUzpllbI19HrQutdPV1obMWsGOSSA5G9IAAxZsahOUCKEt/IYfkg5T/EFqfdvo4Oxi0Zqni9C5pgy2hASC0mgz3RpbjdSs/Lq4hlItExxMQ5QLic1UNp21VdXbMRw5gqqar4cJ9/mISgK82pL3EaSWMgpaoXaPRC+G1tXKAR1s08bjmAfPguDUqel/yW94HxgZIcWHLnpwuuw3JPcXkp7NdwyVXtLzZldCQw0A3W48OZp9PfxjMrTah9fxJK/d3qtYVrrM9Tn1NnlyaKkdnhHgS6KJw/iiQUk64ngSTPZpWOFjQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82sCmg0xd+GZkU4nyb0yKeMgRP/aMKuTfNeCMxfRP28=;
 b=aVEjSO6S0g+q8PsBwwMKWXBY5hFjZdmJ3F19cotqukABLMbsIR42oNvzAN/Z9S0nfhHbvPXYJAEQDWwh6VtNKFGP6rN/rjJpoCrZPmHeVM67F3qyVZVEHjjnV/IPckhvg3b5Y5ciqFP6S07DovEdBMoXpS2QqrU/m4IovG/FO4YBRpsvW3CeIsXeqzv+tVttb/ndEKCqTGeakWrct+Cgbg8p1yploh5r3uT+YjP0OtmB0PJDk6tIzPQgLwqOjuby3FBn0nnj8NOm9R8DTltu5MzTyhyjmksL4k/1RiGdzHwxangLvoo4sdTEIjVNBinnShCpuJEijlgc+8hnwb0yFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82sCmg0xd+GZkU4nyb0yKeMgRP/aMKuTfNeCMxfRP28=;
 b=rNBeN0jqeEJfoY1XJqRpWqSvIfq0YUt377s/uknt/2k0ljLAq1GwdAyZ9O3+zJbItlino9dBvo9GxQvWvPOJgz/tCv3duG7OhrR50b/+qX8urtDIYy0NhyiY4dYN3J6E6VSr3LFfM08CRldDDaz88XJluEwuUA8JMao9StGYdSpOT7LghjesZCBagkr/pwixGi5e6JhjhL9Rhw2ArPQsMfJrEOvkNs4JbRmBHmcsjH3IXlBp1i1BI9Aif7ZIiNZK/qTH6AppDe8qDKg4B+9Ml11jfH7Zz+tlY7+Q+vjhBh8OE5Vo9nE6Ml0tjFneeTUrCAfjGR2Bax4LDKLGLZQm/Q==
Received: from MW4PR04CA0124.namprd04.prod.outlook.com (2603:10b6:303:84::9)
 by IA1PR12MB7685.namprd12.prod.outlook.com (2603:10b6:208:423::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Sat, 24 Aug
 2024 00:11:02 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:303:84:cafe::f8) by MW4PR04CA0124.outlook.office365.com
 (2603:10b6:303:84::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25 via Frontend
 Transport; Sat, 24 Aug 2024 00:11:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Sat, 24 Aug 2024 00:11:01 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 17:10:47 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 17:10:47 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 Aug 2024 17:10:46 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v13 00/10] Add Tegra241 (Grace) CMDQV Support (part 1/2)
Date: Fri, 23 Aug 2024 17:10:34 -0700
Message-ID: <cover.1724453781.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|IA1PR12MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d744bba-062f-46c6-4b9e-08dcc3d13cb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XxMC6xfMHxHcHO20dLg4plykQcNZr/IGMY9PbfNluUFQBamBvYlUi8DRoKo+?=
 =?us-ascii?Q?w+59oxhbHCdtIrlu/iN6aGyzhRcuuSjIIznpRdpaV81UTdrCmcJE0Y/tVO+z?=
 =?us-ascii?Q?nTYbJssaS/ATcWkqWkDviPOQaHcCYLWg5guizc8udAcWX424JnYJWLfv0MyV?=
 =?us-ascii?Q?5axJCB4MeTHmH2JzMY70+Nk408iIMEEKxTzFteKwNekGcLxns4bGCRCzrfnb?=
 =?us-ascii?Q?MVeaNjVACY0lQhJ2rGgnLYO9+U8g5a5mAh9KG0EhvDCUBVZppt6IAfSgyfdG?=
 =?us-ascii?Q?UM1uzAvFWw8iESHVHMFIdPyI7IJ6AzQaEBhelvRtigeatJVPYQv2B43UO+N2?=
 =?us-ascii?Q?GZ1KFJUHT0qX1IfwfKFb8ufofniZVM64ss5O5W5Luu94wZmfW6iz/CNKoKkG?=
 =?us-ascii?Q?7xbBFNCwSlEI5LiHCPM4oUQ3wTI4StCzE2zNIMJx5Mb8iSd/MITX4UX6s291?=
 =?us-ascii?Q?wMapiaA11fWJB07lz7rkqr7CCHC1AjzZ2Kdin3WA/ltvdzkIX972tQ+cUj/p?=
 =?us-ascii?Q?nJlfrb5WAmAEFAYm4iOLGKA0RDwNM5b3SpCBNgPk8a5ThU6UA7VCORFTsw2q?=
 =?us-ascii?Q?YaHUBgo7RQEtc6cB7mONGFG/nbXJZr+z24iMCe0ZyYglam2k+wPzltnwtZ5H?=
 =?us-ascii?Q?VL8lfDQmHLDviLQIW4ib6ehMG92WNvXBBYuKO32/Jjc31i4RdWBUqpJSXxOq?=
 =?us-ascii?Q?2RQc8tEpeGl4jQqOSYvgtIkdqnJC1tCyQQA+/p8+rx+LJ1K99haFshxTyIZj?=
 =?us-ascii?Q?EXhsgikRpqcNafztYi0xLc0MFsp4hT+dd8wQ6rmr2oYnuNf9pjekckNwYqjM?=
 =?us-ascii?Q?U60HH8PJmYcIfuT1egpP8L6/c4vCLz6uZAZ+xgoRB9EBUyi5DWNtmySBlTya?=
 =?us-ascii?Q?FqeNhlcvihKDxIs/Aji2R8eP+ps0m8f9e+84B+o0gJ1Is9bwpnDYdI9cARQM?=
 =?us-ascii?Q?keJi1e3E8jQn3xwgDv04d3RXFi9JjMbnEIHPHbbkDa0uY17pHhxYw7Xy/m52?=
 =?us-ascii?Q?p0EXhYQr+asm1ZElj/64LCFkL3sVE/jSPngoQ0zZ9ZZTOJpcqHJiM/sRgOBG?=
 =?us-ascii?Q?eQ7i35WodQ8hky3zo1npvtq4vnDPV3Y4BBVOM+wJhQqTcK7ZKLh+KaunA9KT?=
 =?us-ascii?Q?xc3qb9sqFGg814dwaDXrTKuV57CBLBIX+Y2LeoXxVil2kTqG57NY2kb/UpO4?=
 =?us-ascii?Q?bd+GIPgNyPMnwkhGNLy8YS/LTxaf3XUV4sKnq9VqUkdDo4TJym7HIZEXh0su?=
 =?us-ascii?Q?FgmqJRUiEFyNKhObaky5fxnW8kNvhUuAbJjE36K7LjgN4x/XSTIivQ5My/sX?=
 =?us-ascii?Q?Fjq/61/GenYEZCMGJDY9LlOd0zus6iMDCupm9gKthKDH0FSK8N71prLYSDrV?=
 =?us-ascii?Q?M+utThAV5bckEAe8fj6h47ifa1A3VkVeg3M+IiDo++u7N39nZ5L0HWgxbcDz?=
 =?us-ascii?Q?pkIYNmwDfjNanDKl9HXyuAmnoBLQELIO?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2024 00:11:01.2497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d744bba-062f-46c6-4b9e-08dcc3d13cb8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7685

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
https://github.com/nicolinc/iommufd/commits/vcmdq_in_kernel-v13

And the part-2 RFC series is also sent for discussion:
https://lore.kernel.org/all/cover.1712978212.git.nicolinc@nvidia.com/

Note that this in-kernel support isn't confined to host kernels running
on Grace-powered servers, but is also used by guest kernels running on
VMs virtualized on those servers. So, those VMs must install the driver,
ideally before the part 2 is merged. So, later those servers would only
need to upgrade their host kernels without bothering the VMs.

Thank you!

Changelog
v13:
 * Rebased on 6.11-rc4
 * Fixed the lidx calculation in the isr()
 * Dropped the arm_smmu_get_iort_node from v12
 * Dropped the WARN_ON_ONCE in arm_smmu_cmdq_batch_init()
 * Replaced ARM_SMMU_OPT_SECONDARY_CMDQ_CS_NONE_ONLY with
   ARM_SMMU_OPT_TEGRA241_CMDQV for impl-level probe
 * Split the minimal cmdqv dsdt probe part from the tegra241_cmdqv
   to the common driver since it might run on other platforms too
 * Added an impl_dev to forward the device node to cmdqv driver so
   it can use it for prints and HW resources probe
 * Switched to the open-code approach provided by Will, replacing
   the patch "Enforce arm_smmu_cmdq_build_sync_cmd"
 * Added a supports_cmd op in the struct arm_smmu_cmdq, so as to
   scan the command at each arm_smmu_cmdq_batch_add call
v12:
 https://lore.kernel.org/all/cover.1723754745.git.nicolinc@nvidia.com/
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

Jason Gunthorpe (1):
  iommu/arm-smmu-v3: Add struct arm_smmu_impl_ops

Nate Watterson (1):
  iommu/arm-smmu-v3: Add in-kernel support for NVIDIA Tegra241 (Grace)
    CMDQV

Nicolin Chen (8):
  iommu/arm-smmu-v3: Issue a batch of commands to the same cmdq
  iommu/arm-smmu-v3: Pass in cmdq pointer to
    arm_smmu_cmdq_build_sync_cmd
  iommu/arm-smmu-v3: Pass in cmdq pointer to arm_smmu_cmdq_init
  iommu/arm-smmu-v3: Make symbols public for CONFIG_TEGRA241_CMDQV
  iommu/arm-smmu-v3: Add ARM_SMMU_OPT_TEGRA241_CMDQV
  iommu/arm-smmu-v3: Add acpi_smmu_acpi_probe_model for impl
  iommu/arm-smmu-v3: Start a new batch if new command is not supported
  iommu/tegra241-cmdqv: Limit CMDs for VCMDQs of a guest owned VINTF

 MAINTAINERS                                   |   1 +
 drivers/iommu/Kconfig                         |  11 +
 drivers/iommu/arm/arm-smmu-v3/Makefile        |   1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 201 +++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  40 +
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 889 ++++++++++++++++++
 6 files changed, 1100 insertions(+), 43 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c

-- 
2.43.0

