Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013071.outbound.protection.outlook.com [40.93.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17444248DC
	for <iommu@lists.linux.dev>; Tue, 21 Jul 2026 19:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784663346; cv=fail; b=Ns6cLGsOfcmDwVo/BpTR+wVupJYf9kzfExmHUIvEb1TzqcRK7r75TPtlaZk0wJGRK8IGORa6uq2GobV3ntxs7ZKrNdwj0sxnAL5wcTdnCW4v8t/Yqwy5ABmoDK9e8uDFarsG1ZJ3lTxs1WyKcrQX9cnZzJV39XcKVM55ACLmaGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784663346; c=relaxed/simple;
	bh=IknR+cXfiKUzNFiq9/5Jm+GbGI1y90HliYbldUF0sKs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TEGznFoUITCt5r8BtN6J0uulrLK9+4/RyfcRIk+Dk+iN9HBQ3OYX8E0F1BxhgVqRoXnEc4LN/h+UMSc7O4s/Fo6w4ejjNSQ2kctmioWKxEzySEoiiaLvjY5mcII8t6jC9cEhW+SSINqIyFp80pPETzLjRjIhdfn3j53/liH4kuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gvKMlH2H; arc=fail smtp.client-ip=40.93.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gvKMlH2H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nrr09kZhqlxJMbhe6xkESc1DwjnmVX2ZG3BU18Vpxz1NfZBid4BqVZrSZC6TjIo6dnvyuA1qgWlLZhXdYxlMXLFFH7jXCuQ/n7ye8FeCoqceph8524hLzr1EW8LaI5cheQAXPCvOvUdJJAfZczG0ACD2o2JqfGxyb/cYPUucArF4wD0MwtZdukDvcD2KEvqf2fyre6qzmywa6eQUTNAFYO0AFH4wsmNaeAP2APuqWVEaejQGb9ACWWPvjmsyCQKaYPMq3LGpheWVdYatqaoEqACqfEATB3BkLK9GVpJlNYBIjv2rIJ+WVTMEnyMONRX/1uMIQW7jD8GdhDNaXNtZIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M6rZs+hOibA/EJa25VIt3kt2fy9cz5CRdSR4CHdUyr8=;
 b=DpIcBvkyiqeGJut7yrfc2XNumg9Gl5h6PheaD0yFLpRrcokIH65M0TQRf/d15eWY7kTBv3Pa05uk9IiFYfGds4Q/gjV2D46IcirXxdpZ3knWjrn2AYU8tKZRYKBTPXOm7aogubsON4demrPOnT3i6n/ANAfYgHOaWhTqwkbdTilXBSfjQI7l1vgYdkHbHix/5yPaUqttJRF3237JL5VNqr+MgmWWxW3EqxfeUedhvXq/uEZajUOFkhnSKsVVew4SsvSfO6F5fVjKzQD19oK+LLik25mv+PzSToyhoMNUyRl2h73le6XVSDSfZK95BEs/FGrKYUVNmO/d5U/IOIhwag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6rZs+hOibA/EJa25VIt3kt2fy9cz5CRdSR4CHdUyr8=;
 b=gvKMlH2HjLkkulgdoDL6ydvRgXxxmH2nrAMjdGQtkL8RwpsAKwjZKweBpDEtGmrwaKiX2HhLOiNyyG2Y4R/o6OaMqFFdb/bItCceH2ox/rk0lbhCZ5An+Q/iwX9fx7vvxAt2LVgffH2VXvRit+2hVtclmpoR1LM54qWASS5H4uWk8vW8lBdpAdHryTx7su/mOziP8AIp55PBp0CPnvXeh7MXdvoOvLyhZG5RKf4MxUZr7svSBq9B5npYHyXYlQ7D+oCIb0UJiN79sVOyUhzmG9sPpwIgrzlmIbp8XRnn7X57K1xCpB0s5lFK0SLUWssELLNkUOJi6k6OvV2/JUSk3Q==
Received: from DS1PR03CA0011.namprd03.prod.outlook.com (2603:10b6:8:450::13)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 19:48:57 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:8:450:cafe::29) by DS1PR03CA0011.outlook.office365.com
 (2603:10b6:8:450::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 19:48:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.0 via Frontend Transport; Tue, 21 Jul 2026 19:48:54 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Jul
 2026 12:48:35 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Jul
 2026 12:48:35 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 21 Jul 2026 12:48:34 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH v9 00/12] iommu/arm-smmu-v3: Adopt the crashed kernel's stream table for kdump
Date: Tue, 21 Jul 2026 12:48:09 -0700
Message-ID: <cover.1784663183.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: 80decd36-44a2-4b83-3f4a-08dee76118a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|6133799003|5023799004|10067099003|56012099006|11063799006|13003099007|18002099003;
X-Microsoft-Antispam-Message-Info:
	uSkzghVnOMBE4o1pEPqPxwCdtEUi4Hx5jlWDMU+dnpDO0pZgmGivpFsVln9NE4pAPx5Neasf2kUt35FV3OSERpZXUNX2FVynJrpqhfwv6DvnJMErgApvfZ0CatPlfzZtKmqe1NgzIJSBKhaqtweA3cLskdjjhF5CC5g6vfQCrGcg/BnaE8PliYh6MFFYhcXbL7N+/afJhfn+vZe9yCeurtvvTjurUbCJxg2e/UOlJu17jc4+JuvgNkxthSPZPub7Uy+gMA4FiABowYDJ1SrWpDw82K0tWSjeY5tWtTOh7N1FpFtfMlLDY0yJyohI9/RiKgEyN3650gLot5OfNMHgfi3UamAYkdBWfknz5alHbQp+l81qWG+HxfYzR+rOV1TVsAXMj58lihzP6RM2axwPHWeLlc6L6dIQlIg7UfTdVIX4CBmVVrCq0y6MlWizFwQzMySD+Cq61H22LV2DUYiVI/U5Gg9GFtHZ3g1THQrEeZTSa6meraQuSlElwnkl48eLk2iiChd2sVJAO1f/beyt1NBcFCGbyroOnO366psz8vdxuEv6i9eFMUb5ABRPuQUmLLFH5roOSsPOws/mRqGsRarOli903u5EmYKtMgzjdTPT5T3Q0aLZttxVpZ78wGBeogh3X7A3dCvWM9U9m2EwyE/+A6Gte2EnnM02LG98HDGu20LywuMSlzrtO0nc4lnoArCWprQeU/9Cc8Xs5RSHPg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(6133799003)(5023799004)(10067099003)(56012099006)(11063799006)(13003099007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pawHaIzHMX4kcXF74I52m350R8MvWgjZbIuTn52JDq9/jnKJxj920+bMyOFos0oKzV0j8ml+YXOE0gnNnrEqcda3xYGLLjwHUh+bLwk1TniO+zlIyF2CrdzXQiAHMwrgtxU6HcCdbwIhovKID70TgMSwh1EVOuTrSZq5TVXCQcaNDuxLSOxGRtVrhDizNw5dzNvAdV+lf0cRh9nTMSCRUskffBNJiKmPO2PTv2FEQZ7c6Yz0UVP0/H5q/eauGJMZKXoa5YCOrToMFOj9N++ANl+sepOby4Rqb8Edl0Mn4hMbn+gOTcSBEUIPCmvI5+BXbOivUJfQY4LNcqYG4kXTBhq+GApygvprPmd8sdnPaXsxNBlOKp9grXqHpoySq6RC9p9XGeZc/acT1huHu01I8o+yEJWlUCBct6j6USXSscBz51lh+WFby05lrmoX6UIB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 19:48:54.2956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80decd36-44a2-4b83-3f4a-08dee76118a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293

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
Most of the new code is added to two new files: arm-smmu-v3-kexec.c holds
the read-only helpers that parse and walk the crashed kernel's stream/CD
tables and reserve its in-use IDs, guarded by a hidden config symbol named
ARM_SMMU_V3_KEXEC (def_bool CRASH_DUMP); arm-smmu-v3-kdump.c then builds
the kdump adoption on top of those helpers, which are meant to be shared
with the proposed SMMUv3 Live Update support:
https://lore.kernel.org/all/alqh_NVatGn84o0i@google.com/

[*] For verification reasons, this series only fixes coherent SMMUs.

For non-ARM_SMMU_OPT_KDUMP_ADOPT cases, keep a status quo since the commit
3f54c447df34f ("iommu/arm-smmu-v3: Don't disable SMMU in kdump kernel"):
full reset followed by driver-initiated reattach, potentially rejecting any
in-flight DMA.

Note that this series is no longer treated as a bug fix, since it has grown
fairly big and most of the kdump code now resides in separate files. For
folks interested in back-porting the change: a v6.12+ kernel (since commit
85196f54743d ("iommu/arm-smmu-v3: Reorganize struct arm_smmu_strtab_cfg"))
would be still compatible with this series.

This is on Github:
https://github.com/nicolinc/iommufd/commits/smmuv3_kdump-v9

Changelog
v9
 * Reject valid CD L1 descriptors carrying a null L2 pointer
 * Move the ida devres prep before the stream table adoption
 * Reject a 2-level CD table on hardware without FEAT_2_LVL_CDTAB
 * Cap the linear table log2size by sid_bits on 2-level capable HW
 * Add a hidden ARM_SMMU_V3_KEXEC config for Live Update to extend
 * Factor the table walkers and ID reservation into arm-smmu-v3-kexec.c
v8
 https://lore.kernel.org/all/cover.1783729633.git.nicolinc@nvidia.com/
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

Nicolin Chen (12):
  iommu/arm-smmu-v3: Do not enable EVTQ/PRIQ interrupts in kdump kernel
  iommu/arm-smmu-v3: Skip EVTQ/PRIQ setup in kdump kernel
  iommu/arm-smmu-v3: Add strtab parse helpers to a new
    arm-smmu-v3-kexec.c
  iommu/arm-smmu-v3: Destroy vmid_map ida via devres
  iommu/arm-smmu-v3: Add ARM_SMMU_OPT_KDUMP_ADOPT for kdump kernel
  iommu/arm-smmu-v3-kexec: Add a CD table parse helper
  iommu/arm-smmu-v3-kexec: Add ASID/VMID reservation helpers
  iommu/arm-smmu-v3-kdump: Reserve crashed kernel's ASIDs and VMIDs
  iommu/arm-smmu-v3-kdump: Implement is_attach_deferred()
  iommu/arm-smmu-v3: Retain CR0_SMMUEN during kdump device reset
  iommu/arm-smmu-v3: Skip RMR bypass for kdump adoption
  iommu/arm-smmu-v3: Detect ARM_SMMU_OPT_KDUMP_ADOPT in probe()

 drivers/iommu/arm/Kconfig                     |   4 +
 drivers/iommu/arm/arm-smmu-v3/Makefile        |   2 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  66 +++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c | 288 +++++++++++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c | 461 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 246 +++++++---
 6 files changed, 999 insertions(+), 68 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c

-- 
2.43.0

