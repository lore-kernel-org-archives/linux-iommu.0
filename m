Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44A44DA13
	for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 21:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718228759; cv=fail; b=uyw2wdT5P9nZ2AzkKpiCkKEtzRMF/qo7y+1muHybJbkEppvjv0uLH5kTBQGb1Uuf+18wZLjIYcprJHcmkIs3YK0PX5XXePBvYeqqJC0htP492DFOHQsu/D7kiEkRW7YZTjAOrkJ4lwwxr3UDY2siexnmUCnfkxKPCb5iUJ5Defk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718228759; c=relaxed/simple;
	bh=4985+R0dO2SNmQUR7mD7q4Q14rmGGoBwds64hVHzb00=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z7VqYUxGXaCZRT44vpk5zwxODdPu5QCTTMVb4J1KeOs1opy4ishHYL2MU49/yr0BN5Y3q84IgOBfJA5lzfRGqRtWsheH9lMYBtXiVq/hJom9MTiLnwn1jdzrEJ80SFUN5quLKNIxhoVfTyc1h6IX+LDppLcc5GO2frArF6lZabc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GQcb3ESl; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GQcb3ESl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iANobw43hlIeob3nc7EApowCKwdOt8qYMl9xA24FozN7lqBFDmZSFB6ieU3RprUKkm2Ktxk5XR2iShOhxkGjAgHQPvzpxZZqPnnfO0sntTmbZ1elxm2WxIbmQK8RA5kqhqgqgCOxof2j4y/YEvnew3lRpizkM/RQSupUl9oTXKCAEU3IlzW0zwz2oyOoh3cRpSyJ8YIlgXznpF5gFDcFmdICPa8Rk9fEZu46JFAeY0J1/lw0okZgx5xefFSJ1Rf0fIuRWpyi4IlR9+8AHUh0aXiV7Y/0AcXebcGhtJMUSVoKuqG/Rys6iLtAJBjhRyrqDKZuEbhJpgPwWnIsJ752tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNfXnv15dYstH4E3gkyObausqvXuRVuLWPLnnVMYI8E=;
 b=AoHDKT+5Q621FCuPfgOofWUqS8LP4AYVND4see2XyPYESPMrq0A1URcd2fMcWe8CUb7ldEl8NP6WVm4Y+lxH0MZbyJNQTPgBIehiEiyAS7v0K7/OxRRCOCrL8YLyvw1nGASD9pliXh9mSLvVr2UvouiQfxIraqPHd3odA/OCgZGbV9Xz4WFVdSuHuC5+ggS65LtxfQS6REv48H1sycIAkjMdPecPowTKRmJkQ/CdAE6ZL9mmOCggHatiiXGe2pMOFC/rez+dGf4nj/0XjyEyHT+BMCo52lIvq0PKvt2sq7YEQ/BXRbBOICyyAdJuHjYzKlvpeHcgkvMycUAYyZdjwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNfXnv15dYstH4E3gkyObausqvXuRVuLWPLnnVMYI8E=;
 b=GQcb3ESlA0lYOAWQKta3Ls9son7yk7DNM4DvqOfh2FfO//hGF/FQnVbzDCP2qtr1WsfqZR7HGgjsg03scCr6NP4WqvQ/f/Qjfz5/rBkOm0dDW3IzGuEABghEqPjmqqvIcXUVZbAbCtMhESfwHrgoSMJE+oMY6Q8IypxS5jGrevFuR12Eg30+x4iz/HDz2aonEisOy1vvhROm9QG0VhtG+39Vn19LmmClJkewjV8MUt2mkudEAc3682q9Jz/2Ijq71dP+KVcrHvIiRXuz2yjpnYEPDtfO1YSYFd5UgK6+DSvERb856elA3A7O65wL57DRz/hvsS2or15voSntDv0Q7g==
Received: from SJ0PR13CA0079.namprd13.prod.outlook.com (2603:10b6:a03:2c4::24)
 by CH3PR12MB9283.namprd12.prod.outlook.com (2603:10b6:610:1cd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Wed, 12 Jun
 2024 21:45:53 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::1e) by SJ0PR13CA0079.outlook.office365.com
 (2603:10b6:a03:2c4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20 via Frontend
 Transport; Wed, 12 Jun 2024 21:45:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 12 Jun 2024 21:45:52 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Jun
 2024 14:45:41 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 12 Jun 2024 14:45:40 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 12 Jun 2024 14:45:40 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: [PATCH v9 0/6] Add Tegra241 (Grace) CMDQV Support (part 1/2)
Date: Wed, 12 Jun 2024 14:45:27 -0700
Message-ID: <cover.1718228494.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|CH3PR12MB9283:EE_
X-MS-Office365-Filtering-Correlation-Id: 41ce9db8-6673-45e2-7db6-08dc8b29084d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|36860700007|376008|1800799018|82310400020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SKvHjee2zA4h5WPaL0OLOroKl+Dn44Xgm95sXID5WsE1XNMuHtnlDNoix0mq?=
 =?us-ascii?Q?KK9k8VVovlgSQipGXkHjb3dnC56uxCt+Pd/O7qbgvbT0X1Dk0oYN4rk3H6QF?=
 =?us-ascii?Q?D2KqztMRSTdYsbx7rG4vKutqrx+dORjp/y/4nN77WEp0YwD1JrDivyZzDkIo?=
 =?us-ascii?Q?KGvUiAVASJeZCtY80LTtVnSSXWIE5zrEv2qvU/fSshe5fccfUqDDHeSWitwv?=
 =?us-ascii?Q?16p9rVy6jNcbnaU23jX0pXJCuwfensGhr7hYmSiGCGT7eQcOmYXMyvwzOf0N?=
 =?us-ascii?Q?MMtkPLixQkzAc4U+JXrXkC6L5SQYzJ8MwQ5R31Q+yGbGkVc+v09mFHzdy4s6?=
 =?us-ascii?Q?2ADKthkKaSBErB2KqXuXcQu7E78AunobOD0UqYA7lEDmumfAtQWAC8IOUFmK?=
 =?us-ascii?Q?QKJLBgCpICokSZ9AmXfhaTypjzyhVAuO6lx7RKoVcPpNpQDgfFHP2HvTAGc8?=
 =?us-ascii?Q?3EviDnYKxlFqgbFf106uVtOc5U75FQEl3GzuCHdngP9ZBq8nbbAGy8yFPFUr?=
 =?us-ascii?Q?zATe/w1f67KQo5CvEXW/Da/bENc8vDFmHY8rp54Ms8Cj0TZ3+af7HzoP4xQC?=
 =?us-ascii?Q?iEvKBs4uJ5pbKctfo4hYSrDa08zAhd3kWekvOC804NTCwUzYKWStD+ZFQUsw?=
 =?us-ascii?Q?edzE1QHkw3X5NTFv1cGkRXhHYoB638BuNbJ2Zf5+NKvDuAoOrmlx48VjS0cl?=
 =?us-ascii?Q?O92yQ1fOi1q5FLbTUP8Gm28+z06dC0rHvAlA6eFF5+KakwQZOvF5fZXOzW/F?=
 =?us-ascii?Q?tf1Ri+dbAa1UMBOTiuhxtoenrLFR2Wi2X23T38W8J4c0mb9fKj7dCu5DoqSU?=
 =?us-ascii?Q?ICPCFIBPEqr6vOubleImJH4yL0o5stAvobu4dCfhasLHyIxRe52nj5OD5G/Z?=
 =?us-ascii?Q?3GqES4seSu80xDEylF9YjkbYDGlKNcdTp76U0IwPRztRx0/zs0qxN/QqgShD?=
 =?us-ascii?Q?s+7+ESgRPnBxz3HCuWFe1DdoIyap2rnmjQ/lgXCLkJz9niGFpbgQh1lBNKSX?=
 =?us-ascii?Q?G14TgQPAHF07DCOpOFkmpNOgaEG018PfG9+i2bGG7lh7CUkinhv23nZYd6Eu?=
 =?us-ascii?Q?W49Mtjoti50JBZjPKoWIdXTQ3w17BecA3SfeyTR5zsIIokITfyNsBb1cUtbo?=
 =?us-ascii?Q?ZGv8TZGpN0tgohCvNB948t549TcO6lO7DOml1OS3UyVjp9+EuhI14ILD707S?=
 =?us-ascii?Q?fxX03ECiM9fV1onT+wB865vrioMYXNXww+Tedk+KbRnGTOgyYITLlpI6qxME?=
 =?us-ascii?Q?suOkD1OiZcblyRSRBIgTX5xZOmaMbzjzP+3mLAK15gZzia8gFYhIJw2RVov9?=
 =?us-ascii?Q?utrI+F4UlQuWouzaqsMW0fZcZ33zUNHmKeV29JDK1mcI8gPz1Zcpul9EPGYn?=
 =?us-ascii?Q?eSygRgJzgCKfdqAg0/nsZJV2bxkBH8XupqFf3V2j0kXO12P8zUvK0Rtz7ynG?=
 =?us-ascii?Q?OEsza3R+5KY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230034)(36860700007)(376008)(1800799018)(82310400020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 21:45:52.8827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ce9db8-6673-45e2-7db6-08dc8b29084d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9283

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
https://github.com/nicolinc/iommufd/commits/vcmdq_in_kernel-v9

And the part-2 RFC series is also sent for discussion:
https://lore.kernel.org/all/cover.1712978212.git.nicolinc@nvidia.com/

Note that this in-kernel support isn't confined to host kernels running
on Grace-powered servers, but is also used by guest kernels running on
VMs virtualized on those servers. So, those VMs must install the driver,
ideally before the part 2 is merged. So, later those servers would only
need to upgrade their host kernels without bothering the VMs.

Thank you!

Changelog
v9:
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

Nicolin Chen (5):
  iommu/arm-smmu-v3: Make symbols public for CONFIG_TEGRA241_CMDQV
  iommu/arm-smmu-v3: Issue a batch of commands to the same cmdq
  iommu/arm-smmu-v3: Enforce arm_smmu_cmdq_build_sync_cmd
  iommu/arm-smmu-v3: Add CS_NONE quirk for CONFIG_TEGRA241_CMDQV
  iommu/tegra241-cmdqv: Limit CMDs for guest owned VINTF

 MAINTAINERS                                   |   1 +
 drivers/iommu/Kconfig                         |  11 +
 drivers/iommu/arm/arm-smmu-v3/Makefile        |   1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 175 ++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  67 +-
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 876 ++++++++++++++++++
 6 files changed, 1064 insertions(+), 67 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c

-- 
2.43.0

