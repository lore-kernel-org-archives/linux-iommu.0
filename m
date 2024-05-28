Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EBC13C801
	for <iommu@lists.linux.dev>; Tue, 28 May 2024 08:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716883818; cv=fail; b=r1PryJzjyOkttHykOQIIsfT4Pxlivq1FqiiOjFSFCoH4l4aafeCH7NAoP0zaesuEiohLHb7OjEZkrFws/Y9wOTrUtiMDwcblZrAHFwecESFF6HTZM5W/CwTg66uTlTg9OmohHMuv+PWzgdkoTZWPKFDBOMBWmPVyRSL0I08GxjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716883818; c=relaxed/simple;
	bh=Elev43n3Ex41i8c8cGqw7ytf56dSEA+j4EQIu22IX94=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qDHgZIyFdQhlLNTB09wTgvihZL6ITldikVQC0j9E8eLAOI9xczFrH0rp1XvuqeSAaR33WWBENJardBNTtUrDnAJaN/ncoDDTlEUKVbYs25yDeFymKADbwR1MEp/Mm9KV1Ci/XadXJJt1Wwenxb/TrmL7sGEMY5Ol+SWhW0eZUDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kEUiImQO; arc=fail smtp.client-ip=40.107.93.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kEUiImQO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BgFlVDKd6VTzIugoLSQDq4TwxVlRQ+FtFYplGYqtiBbunRfRkufQf7mARPduRiYAOIGVaJbbVnqnzMBSLOepMhPAnmpSPkRSx0f7OHCRWKAw5Sq8rpXuqfQJL7CYruGXX0685Bp1Ys9Wf+CujUa2SNUpeTeKxOdNww1o1cWBXji6AjW4+O7MJViN5jKkE4dHTWgr9rWk+xe5HnAuVpAQ6NW06dd9HWbLK8Tv0+WcXD59zfx6PSq0yeUrYx4fUfhmcixiheP9i6qcTLdVW7okJxOh0UmKozAeUp6c9lZFuAOeltPDCaQHcIQOMmf62vOR8cYfpX0yncub2jxSzk3WEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1CNvsGwc2hW261nt8obtGsLqIggtQvD/xfHAhj7bao=;
 b=e5JseA8IUOhtc4Pxjdg7vlCYlcZmu09k3mPCrxRxIt+Ycwd2lbEi4Ize3wQdFjmYY4uredMeIk1igaREeFRM3PMmx1T1urPX7fmgwQ8CJ3aFFG82SeBmyrSOh6fagGBZbwWPrHENcEYnl5tyJ7uzgCfxMSukYQAhfqFNLIDPdvzvncsKvlu2MTwDvMQ5nS+gJ/2Nmmz6nHZtQaGHHDSVY89buukwtfne54X5/2MGOlbbmI+DY2UVsFqPXaEzlqnhnze+avQLvsI4XFMM5YFvlO1/c9Z50SSfWUIOZwEuLBf6faphknqxC8PGSfD91dWNZXGnqA7KRLHBRwIuN/DWrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1CNvsGwc2hW261nt8obtGsLqIggtQvD/xfHAhj7bao=;
 b=kEUiImQOIJyH0fM1M9lJxP8YDR70O2I0DPPzMN9rLPa3flPSoz8ZzJ4tMl6w1LfcuJ9Vrj25hXwFp/X9FFAbE99hrmiOiHN5aJDxaxPzFrWaHKlfmEqcBzzamrZkW+FmdoA/ybrFLDf2ubI3922lPrBml79kxkDOKYtScBW+dDYgtkQzb5icPiABpIFYW6ZswAnoWqqIiLfhpssN8cUQsHmN1SjL2hogA8mSjo5mvYs0Ie8BnUxGmbXE1zn1UA5Mw7z8ypqz1h2Mp//MBAgtEIrWWTBeltCydGDuaLUYcYFHuWxGVCSHugcUHHDKiri1KZ2+b0ek2AulR4dCvJhXcA==
Received: from DM6PR06CA0034.namprd06.prod.outlook.com (2603:10b6:5:120::47)
 by MW4PR12MB7438.namprd12.prod.outlook.com (2603:10b6:303:219::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 08:10:10 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:5:120:cafe::8f) by DM6PR06CA0034.outlook.office365.com
 (2603:10b6:5:120::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Tue, 28 May 2024 08:10:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 08:10:10 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 01:09:59 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 28 May 2024 01:09:58 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 28 May 2024 01:09:58 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
	<jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: [PATCH v8 0/6] Add Tegra241 (Grace) CMDQV Support (part 1/2)
Date: Tue, 28 May 2024 01:09:48 -0700
Message-ID: <cover.1716883239.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|MW4PR12MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: acb4d57c-08e2-4a43-0efc-08dc7eed9808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g3SfhJx8W3Q1Ms72MMFc+JYBcVGAVZXCMs+uCS0ZMFHJZiSUjC6jfoa+DBy0?=
 =?us-ascii?Q?EJwVMh14Z9zlIuczQS4WC3l+e1ZrrqwIlWmt8w3XqFbGlpngjYdcvng2gvYX?=
 =?us-ascii?Q?jXJLsIQbONf1MaECWVMEapZhVzxtq0gxcT84BVvGuWc2E9O3LTRSmsxXYxs+?=
 =?us-ascii?Q?F4JMo+p0btPb4pNt7Clw+GrO0hQKal1SIJeInttMxh11GInhcfUSh6sGVZ0c?=
 =?us-ascii?Q?BMmEUAlc9sx7HV/+lFjIikSq5NXhBj+CNEshxWf6FK22/iKmmAMsQE+VHEiJ?=
 =?us-ascii?Q?o20AuEERGUEwzDJ2ZYwmz6srzgFZnznJmntKw4l0Ktl+0vzUS8a4Auwc6ciw?=
 =?us-ascii?Q?/Wi4HFpHoXqYIqvKrm9coh4Jt6NUO93AclwzxJ6TtSW3jXEm+x01JmRSox1Q?=
 =?us-ascii?Q?W4IrcmNVwjSk+D43xGYq27twG6ip27O3fLbZReZ9fUmkvBJhXehajFCduL3C?=
 =?us-ascii?Q?Mv5XjT0xRbtR1bIpSlrD9N8+vNgSnR0sHct+hYoqUPdWl11cipWyiJMw78Nm?=
 =?us-ascii?Q?hG3Ihi9uz7eiCxnUzXgzpjezP6m71bMvns7qAGBCsVmJwtTes97N4rY3qQRL?=
 =?us-ascii?Q?HYrE+kAxI+KBRrGfIg779spN8KtaOmuKB9PV1aDz5ZO4lq9a8jevWAS2855M?=
 =?us-ascii?Q?OW/eXcv8UwJs5eRAzKwgM4fD5rxuRtsaK082+iBRN+8QWf775xfyzxelx6mW?=
 =?us-ascii?Q?0g2cic/xLqJZe3+WaeQVWmNZPAhwBnF+i/QeotRBMRMjjEUqkwlh5qf21G9L?=
 =?us-ascii?Q?p9NKISCzZ4r9wQD1L2LDSnaLUdYZ4r4urmhTjO6iaD45fh7Hc5UfHWElYY2s?=
 =?us-ascii?Q?/SyNBmRNE6j+jlHswSWehsNw4HwzHRb0awDcHjqx38Eo+UhQz9OkMsPaC01v?=
 =?us-ascii?Q?F74v+JujpEJU+NIpKSl69B/B0SI/CxyjPrzQRvksP/TdlYPDF34unStCZslC?=
 =?us-ascii?Q?Linuv41ixtcr8a/yTqa/lB+8rsbszfoVlvkgfgakzKfY4SQbZ+V1c6tF997S?=
 =?us-ascii?Q?G4Lu7L10IGoWhRN2vptZQWaxKxLvhxFDAVCiqvqnkkk713HTAdOTQqhTh6cg?=
 =?us-ascii?Q?5xCzOxCdR4GsLgmylRWUSzK0AOTG95DvAqV1dZc8ii7bKtdc8/0AvqGfZCL5?=
 =?us-ascii?Q?G54dofGDrTbVwJMY0TqHua5AIcmcaZ/LPc8qqcrZc1DerhK9lEI5XBQ4Ml8j?=
 =?us-ascii?Q?XTtub7zrAYxV21AzHR0kv2Y/WK/AIrCq5IYb3cYi/hR4z2xHDJzjE77LpPm7?=
 =?us-ascii?Q?Wk3V2SnvRacV7TgyKedUkYdOhMgJCDss6/YS0XzUMQUoWsxtsVygQI5O9gCb?=
 =?us-ascii?Q?gpiMF625wyZpvhVRD3LytiFC3Sa8O6YAR9jS6JGzWKE/A1ofeNUbe6TMRluK?=
 =?us-ascii?Q?T4y/CtB54m7lhbEu3e0j5aOPpnN+?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 08:10:10.1688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acb4d57c-08e2-4a43-0efc-08dc7eed9808
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7438

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
https://github.com/nicolinc/iommufd/commits/vcmdq_in_kernel-v8

And the part-2 RFC series is also sent for discussion:
https://lore.kernel.org/all/cover.1712978212.git.nicolinc@nvidia.com/

Note that this in-kernel support isn't confined to host kernels running
on Grace-powered servers, but is also used by guest kernels running on
VMs virtualized on those servers. So, those VMs must install the driver,
ideally before the part 2 is merged. So, later those servers would only
need to upgrade their host kernels without bothering the VMs.

Thank you!

Changelog
v8:
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

