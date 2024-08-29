Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2065.outbound.protection.outlook.com [40.107.96.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB87D156875
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 22:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724970904; cv=fail; b=Wb2qLPY6EPgJgjOYFmTf4y1KkmuE4chJeURCmz7cPlgXhaeG0nPgajBPoM+dWvHJqxu9NLMwkCk8s/eHM5bZey0+7xx2/PpMurl8FRaNf0vvHou3RGQTU+ehPkAVW/m6Ste+J/Z5QsllwU3mj/EOxPlynBwtcrRUcG3LDtJZUJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724970904; c=relaxed/simple;
	bh=gku2xipzsofwM///vru5GDHv4OUSQu1pG2JxRFjtzwU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z0e+dG1pupHzJ4wa9NeACrafSK9OmIymwGPyYwi7gFgDzYNCW5r42Pf7psiI2cQG7dkkLBOGi1spabteRN9wapmaYGzcTpkquoqWDI/R3vhVkRIF5cJojIaeXNlzHQK62kjknXlSA4pzABtgaf5LzN6HX1rP1qBVMrLKIM7+yEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hb+EYo3I; arc=fail smtp.client-ip=40.107.96.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hb+EYo3I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kcTanWTHk9oqRzW1IGn5uEoJzv7DkBb9vyZ7OUn8FSsZKfvETRC997qupcNd6Vbu1bFDOVDoDHhAy4OMw4EPO4tMtzcxY5zvxl79fRtxGZ2wm3G3JlsocR48HfSIBxsuAiFqhk1boUzi6izE1hsXYHERLJze/h9orIFPAbEoPek9ssjfjv44W7uHw5mzzchGafLpT0AfrGeQh6SjuA9TunZ6OA6rSwe0/bZHE0IggsTLCwCg0btsIJxGfXCF1tNqUd7jQZmd2Adge3BhhLTNgEXc3Gczklk90wvYQvpYR0ozTs061Puk5vhzGWsbMhKDlv+Dsp797RSfEkQTfmVy+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19aqTwzdgqdYFuEQNQXvOj4dtyAxmEQgTWKsqqdMYiA=;
 b=U1WOtBPkYuuz2ErlDlr8FqkI49tyL1h3kXZu0tLPiwmVr3023Cq9X7EjcOPAJ0veDiWyqs9ZWL3fob1RUKIgw/yNcGJ84wEDSl3U0EGtGR77pT2T6fpvQfr/udT1aVmxcUqX6lEFDp9sMsakMiSmJ2v3FUcW7krJI8W84aSJ2QYpbj5NvOx/B6m+WFBdjq+xrrTp5y6oKuGQy6eseYbPiRVSQ3pnznTZUAAFVa+YRzePdGDWMRNvrn6ow1z1i/m1WfTGQkZafMDyEtx49PfIDVNlsagTXQN+nBCXaRDCI6GOnRnmil2+mZXF4jqj10wHN1Iy4BQa1hH09sdruidweg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19aqTwzdgqdYFuEQNQXvOj4dtyAxmEQgTWKsqqdMYiA=;
 b=hb+EYo3IsOWAChyYHCybYDST7m1W/1TU+K0nnZMDpjlFcFKaFeklc4PbeM61PknHe+z+NnsLad8pBFDM/bPW8cItze6G5256rkkFhIrrSCZHv78W08l47j+xf3evAbG2eEk6vIE6ra8vUPY9GlVQs5EpgY/nKoOhzp2j9g7ZmT3Bd+F+Od0WkWXih31sWfg87+QndsiBhBtJ5O0CWpUrMeMaQ5TpfrMQmWw45kGn2vkioQ8RKuAxzcRfU2HxsUenT/fAuhvM+fftRpdK2J577aLg3LR4TrGi9igLKUE2hV8iXADLkBEQJIrJXwoaWIjvAynpMwDKYHSmecdXE4uQ1w==
Received: from CH2PR12CA0011.namprd12.prod.outlook.com (2603:10b6:610:57::21)
 by CY8PR12MB7145.namprd12.prod.outlook.com (2603:10b6:930:5f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 22:34:56 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::32) by CH2PR12CA0011.outlook.office365.com
 (2603:10b6:610:57::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28 via Frontend
 Transport; Thu, 29 Aug 2024 22:34:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 22:34:56 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 29 Aug
 2024 15:34:43 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 29 Aug
 2024 15:34:42 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 29 Aug 2024 15:34:41 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v14 00/10] Add Tegra241 (Grace) CMDQV Support (part 1/2)
Date: Thu, 29 Aug 2024 15:34:29 -0700
Message-ID: <cover.1724970714.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|CY8PR12MB7145:EE_
X-MS-Office365-Filtering-Correlation-Id: a725fc4f-a1d6-44bf-2cd2-08dcc87acee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vwC0GPW6OFHOp9Q7m3Y6DhAJqn4FLhoHCtp5DJsQL2TC4+T9RcuG52o8eVhZ?=
 =?us-ascii?Q?c6GVFwIwz7sgpTzpdag+ormYJa5oq27tXKhjHu483M2OXN3+tx1MoISXylgk?=
 =?us-ascii?Q?GROsJ8m88phiVkVPGU1i91SCit7xxF8ef62IkY/dWBZFEeEkB+pi6whmuT8b?=
 =?us-ascii?Q?f9go8ch3Y3VD06nxpfgOU/pexd5fdMiLCOyx6UIuc3JSM3bRxdBOJUVlY3VA?=
 =?us-ascii?Q?yDKVlgclRde7hGsBNQzeC9Jp17zS323HjRdfI1lowYGdez6eD0hPPqOduzcF?=
 =?us-ascii?Q?JengE8XZWseTkcvLgcwEZVGcCFFQ5xYuCeBLzW7bVQo2TmEPkKaV4hV5NKtH?=
 =?us-ascii?Q?buhTSoR11EV+v3tGfmQa/DsitQcl/0EzH8SEqQ5ugWUsaUaFxco5FpW6HoQp?=
 =?us-ascii?Q?WtnFlsdzDaMfthcpIXs5NnY+jGvA/kFonkQiS56ZdQaOSTW1SeZrG2apQsRi?=
 =?us-ascii?Q?5hMeO3E46oZStIlE5Ol/SWe7nwPAp4pwfl4Ff7HCeFkYJ+lBTdNLxXU9WsD/?=
 =?us-ascii?Q?ySHQni+4GMQHtZ21YAvym+xMrlR5oQQyUja+bkhBGn8ocPS5II5v8KJZ9KYb?=
 =?us-ascii?Q?S1t3EShVIcCYH5pKNGctuuul3+LYqKHZguTHIdk6iXRelYgf7BJoLyhs3hPP?=
 =?us-ascii?Q?Duw31q99UqO+pJmAlAnWKwZHGI4rv7CrjXsKGFH9xuOeTwGartc9rbsCN/Yo?=
 =?us-ascii?Q?Xa66VkMyt8Vjpyio/LKhkOMid9EwqNW3KwNsPUKRAFjl4UzuWcY9oVKd3yNv?=
 =?us-ascii?Q?e7Ad8/tebIeRb6xanoNIRESvPhKBFsRULiqQahmXu8idvmjIIT60LBKIvAky?=
 =?us-ascii?Q?r1tCGW6TL2OJ4j6vJVu03LXNd8yrmK3UIIpG0nEytRee57U4GWtfA4crPizi?=
 =?us-ascii?Q?WACvFmhrQsdlZLiUTTMs9rrbn0VeTz+4796yTm3tIB4C1zzEU/mhaEMQXsrT?=
 =?us-ascii?Q?MNSWKaaTvSdjHT8c301vykxMJ04gBjWfDpTMxRrrmyt4XMtaJWffGXy00O9L?=
 =?us-ascii?Q?fp/GRCv/M6S8fZL7AO2uivr6KdvEK5Cz6VshWQALJXikHMO2IgBG8RltjVNf?=
 =?us-ascii?Q?VASIdoTOuTFlf+p0QUACSq8WVm4O7brckIc9X8BiCG/3iU1Fe7ujaps5PSjl?=
 =?us-ascii?Q?pBZ5CRi+HILvsu/QEqjTxz+AO0vePzykBF4/yM/pbbpkn/Ko5/yVVoZufg7C?=
 =?us-ascii?Q?ALxcFJW9xps1Ab9RAyKxd01J84RV3D0Va1DtLBTs4tw4blru1AvSVTzCAwqQ?=
 =?us-ascii?Q?qxEe0EDKk6lFV2NGY53R91U0S/2kB4j/X3mr7xtOfk5jKQd45GYOYITeFJZt?=
 =?us-ascii?Q?79oBDZj14ulofEQ3zI2pDCNlx1yxi5GfRgZYqEKqZFsdEYjPSLTvQyEpmNQx?=
 =?us-ascii?Q?YAV3TUS/yESV9BoSh4uR2LssH71/PwqyfOGf206jyIRol0h7yHAO8whBWSNf?=
 =?us-ascii?Q?aSePPrswTBc941L5kdxqoQARjdgdSxs9?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 22:34:56.0740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a725fc4f-a1d6-44bf-2cd2-08dcc87acee5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7145

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
https://github.com/nicolinc/iommufd/commits/vcmdq_in_kernel-v14

And the part-2 RFC series is also sent for discussion:
https://lore.kernel.org/all/cover.1712978212.git.nicolinc@nvidia.com/

Note that this in-kernel support isn't confined to host kernels running
on Grace-powered servers, but is also used by guest kernels running on
VMs virtualized on those servers. So, those VMs must install the driver,
ideally before the part 2 is merged. So, later those servers would only
need to upgrade their host kernels without bothering the VMs.

Thank you!

Changelog
v14:
 * Rebased on Will's for-joerg/arm-smmu/updates
 * Added a missed kdoc for "dev" in struct tegra241_cmdqv
 * Corrected typo-ed function names in the impl commit message
v13:
 https://lore.kernel.org/all/cover.1724453781.git.nicolinc@nvidia.com/
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
  iommu/arm-smmu-v3: Add acpi_smmu_iort_probe_model for impl
  iommu/arm-smmu-v3: Start a new batch if new command is not supported
  iommu/tegra241-cmdqv: Limit CMDs for VCMDQs of a guest owned VINTF

 MAINTAINERS                                   |   1 +
 drivers/iommu/Kconfig                         |  11 +
 drivers/iommu/arm/arm-smmu-v3/Makefile        |   1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 201 +++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  40 +
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 890 ++++++++++++++++++
 6 files changed, 1101 insertions(+), 43 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c

-- 
2.43.0

