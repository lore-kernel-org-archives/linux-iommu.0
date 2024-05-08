Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDFB171B0
	for <iommu@lists.linux.dev>; Wed,  8 May 2024 05:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715147833; cv=fail; b=evh715RR3qTG+ZLv/vZ4BwhATTriLtbZtPI5MlgC7O28/kCIdi4fYfB0E9smIwCaSmDC5HqtHHRicK9VQV9ROl1bLpoLm96fg4N8F8Fk87JBeMqolGlVG9hBgPsXX+tMWMMMV4QCQWlYPNLzCBSGYksgexFV659tuTWLrWWLlG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715147833; c=relaxed/simple;
	bh=K/h4T9rQFWgIE3klVp88kQT9GbRtTTpE5qIvJ8iQnFI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mKRX6kNg79n0ojhaKo/rgRvtccivnObyHaBnNMngGQzs3DBPurJko4A0kYmIl5PWeYR4hxC7BwWEODJ1fv0WBBScgn9SeOJ3q/BedJMzCsOeu+PrREpCiXJtJfX9FUx0mMIU0VQ+4sTmkbcAofkZ8MM3nwu4nHXAg31wfPeBGZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=svdWBzOu; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="svdWBzOu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKbQytzPuctHUFkhAtYWrlZ8+xND22yN+GbcmPzW/lcrmF/UUpD29JIH5Nu4tKHFg7ygswuXeBj6mNSC9XpogaGg/AR1/F2dVlxIeDaqTAp8CPmiu1FUcAXvt052wl/v37/4r4qNQX2cqr1Ch1eZ60adPgFka6tCsPsTIRWIZr+7Jy/Bz0Bh6QOv4WpQogh6H9BpJRsslCZzP8EzrjtM1fAHMlHgb0lIbtEICfOu8s4uPMaZIR9f3wLJPxQKqr38STNOsWNLwbRgTL5nR+E+BapkL5F4KnqtDRQ82i59ZzoV1GMbOIaWXJTByEr0pEe6GJU6NmxqnTHDhNhA+X2gYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ht4GD7a/XqhBS61GUjyNVvX/Lmeoxq+5KDSFdwZ+7Wo=;
 b=Xj5LtMPf3ZaBhiJxgslymuqgDkqG7REuevNMqWGjy2VGQLGPjHj/QdOMQPszLvruR0JVJ40J+qgt5gDm/WGEtoD9GmPyBNrq9xvTFKD14ZAj1u+Cdhk4QkVryypybOcV9flcSkSRXrpyOfHNtLPWnPNCUv3Y+8xKZE+Dw9xZvxSWzXNhXI4zsJjuKNZXxVkGOl9MoDdbMMWsTMIn/3F8fHUFpabeWUqT7FGpJuc9b8SHnFJKbcjJZv7cKuC66S6JBZ/BK74DC868AYHepwL6T3EGzlzUy3COKe7sRokgVyY+CQRXGU3WSTTRVzme0l9+hxoEk57tv5eJscvRfNa6DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ht4GD7a/XqhBS61GUjyNVvX/Lmeoxq+5KDSFdwZ+7Wo=;
 b=svdWBzOuAuBNk2q5ExpJqjgNdjPZdJkmLQ0pAftdxyYjlM4idSQ9AZdUROpFLP7yOXhgVI0yceH7XcYPEERPnvp9qWRL6RPxH25ltJUD6GmeiBfu2uExTDTMb2/uKlNar4+pf09OtmlMqvrkQ2UdRgE+4hy4ZV77kYJ2wSvKRcwPXsxvANoWYUdmPScS+aewmQCVRPyj5RXm54bNtYzzMn4+gaibpFnnK6iTdJcmqZ8c/2rtVyJsnsJu/iN7sgoxC3cRi/gKUXPSt4Ep3xB2DEsm7mfHAknGiHFg3q20zXTAvfsfgGNxCkvFnAL5Nwf98KAQqC/yQFCckWh9pNu8tg==
Received: from SJ0PR05CA0183.namprd05.prod.outlook.com (2603:10b6:a03:330::8)
 by DM4PR12MB6011.namprd12.prod.outlook.com (2603:10b6:8:6b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Wed, 8 May
 2024 05:57:07 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::59) by SJ0PR05CA0183.outlook.office365.com
 (2603:10b6:a03:330::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43 via Frontend
 Transport; Wed, 8 May 2024 05:57:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 05:57:07 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 May 2024
 22:57:00 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 7 May 2024 22:57:00 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 7 May 2024 22:56:59 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
	<jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: [PATCH v7 0/6] Add Tegra241 (Grace) CMDQV Support (part 1/2)
Date: Tue, 7 May 2024 22:56:48 -0700
Message-ID: <cover.1715147377.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|DM4PR12MB6011:EE_
X-MS-Office365-Filtering-Correlation-Id: 08a6f84c-95c7-4e95-58eb-08dc6f23b1d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gwMJSz46HCFoXrCc9kmuSyM9XAxeUSUtrPKKnKA/4JQViVPXgR5aw01GAqd+?=
 =?us-ascii?Q?VgwwjuujnmWo3nfYtWt6PLqi4f+CsklErKzcH50T3PQZSQLdmS/Azyb8oRL9?=
 =?us-ascii?Q?QjkGgLwi9OeROK2ZtOvNZh274fH0Ia6wRkox9GDf6XjI8+YFL2xfn3W4teLC?=
 =?us-ascii?Q?0ieFKCubQOWa9rnaRa16ieVw6cFUB+cInBljMfnb/xCwT4vZUIXLAAj6CeOI?=
 =?us-ascii?Q?WokkfsuD1p/rO7yf0wsmsuuFWACydZ/NWaSLKtpjiknvc9mVvYMaQlPb4EGB?=
 =?us-ascii?Q?YlI3KkSpVWMf26ChJz2IE1KeNrdeZicb9OHgh1CJzC96cCF9fisUR71yur8b?=
 =?us-ascii?Q?GcgjKgjCxaMidK+x5XDaEwK7L+33nkCEG4LaaxZc8eSBBoSaIYfVmTzAg3gH?=
 =?us-ascii?Q?FlkMvONG9mo+twPw7K3eGdus0zVrDPiMDCNy2A4/ix0Cgyqar+tI1oUOJf1R?=
 =?us-ascii?Q?MCf2gCr2r2+7I/ZU/a7NldqU3YjuKzNZcrpgahcZMszSeXx53CS+Jf2BGM12?=
 =?us-ascii?Q?hXhLZjK8DbwGGQj6VSu4f00oTeH1bX7jkAhIL2S/rsDfdY/8ayatUqzMaBKW?=
 =?us-ascii?Q?F79VKU4hrlk089yTn/EcW2AtRgqQGtDeyvOwNdsAwjoBBDPiwRs5RXCLjWJD?=
 =?us-ascii?Q?QQqAqUvRym0Z7aGU5vQZDs+/L4j5X/96ayABfq9KmYhqqTxVW9dAx3hqO0B7?=
 =?us-ascii?Q?8kenDCOMxOmSuLwakJ3YObdQJMbW2HKjoEHLDnXG9pGkARwczYnsUgtVm9RP?=
 =?us-ascii?Q?FPEuiqG6Xwwq+gmH6dE2OaqFbIAOCBVS/+Z9quX+aZm8W/RWFdLR4FPPmTmA?=
 =?us-ascii?Q?eEjAwnfXsKfCK4H2+scxDZ/UQqH9SjhNy1ascmU92hfOTNCn3Se8hgA/xVWd?=
 =?us-ascii?Q?fA7TQLZlN+9NdC9nGj5FImmmL7Z9dJvm0sETAIuiuvlO5yd1CJ7kZlApzgjs?=
 =?us-ascii?Q?eF0SCfZO8RLU0bgO9X1Sbmt99iM0FKkNI3kuandbNUnLRjQL2GbcS8Gxixev?=
 =?us-ascii?Q?d4ntGf39NHqFMN0OZyEK/qS8gIM6b30KY7/VA/wNDCh1ZsscT8eZeeoZrMY1?=
 =?us-ascii?Q?2PA57cPL8xdopkHxKwYLcMeokV7Y38AoJu/EpO5UTSwe5b41kZ2ATPP7D6ZT?=
 =?us-ascii?Q?9baGKudKpd8ziqowUTdl71mbgiJm0bH52r54nMYvr8Vm/FYEeajxs/KUmFqW?=
 =?us-ascii?Q?7cnwBUDggn++cSSfjgkGMG1uVkwqXoY0ZmpbFoZhzFYvXzvA1hvBDZgUpbGN?=
 =?us-ascii?Q?fVLi0BTJ8Fyyq8HsHFiNkFtg8JYt2LVFc8IGVJYtoaQ6E2LyBxAFd0pgM+if?=
 =?us-ascii?Q?VOkz+E1DyCnL0mpf7m4pvu1VMFXTjuNCw3XY55TI2xO7geL9XL7bGAlGNPxj?=
 =?us-ascii?Q?xlZJQ7hFRsdKcAkD2bNIfD10SfcD?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 05:57:07.7452
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a6f84c-95c7-4e95-58eb-08dc6f23b1d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6011

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
https://github.com/nicolinc/iommufd/commits/vcmdq_in_kernel-v7

And the part-2 RFC series is also sent for discussion:
https://lore.kernel.org/all/cover.1712978212.git.nicolinc@nvidia.com/

Note that this in-kernel support isn't confined to host kernels running
on Grace-powered servers, but is also used by guest kernels running on
VMs virtualized on those servers. So, those VMs must install the driver,
ideally before the part 2 is merged. So, later those servers would only
need to upgrade their host kernels without bothering the VMs.

Thank you!

Changelog
v7:
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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 164 ++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  67 +-
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 911 ++++++++++++++++++
 6 files changed, 1088 insertions(+), 67 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c

-- 
2.43.0

