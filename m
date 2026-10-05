Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012046.outbound.protection.outlook.com [40.93.195.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DC030DD00
	for <iommu@lists.linux.dev>; Mon,  5 Oct 2026 19:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791228689; cv=fail; b=rhPqhKiar7ldNJZKvDxTrBMW4Efmf4ZuiZdUFxyP4TuCiTnPezt4gZwXyGRn1RQxG+aOY7AUlscOgpd2z3qCtIF+ofNVBW8waS3arWpJ1X0wmVIDf5ZI3Q++OkA9iuzBhneaJdXm0WcmEk6h5BGlo0sD7kiorvicDXv4Bj0Ftdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791228689; c=relaxed/simple;
	bh=vFoYf8tUFzcJIW0LFSw5N+o+gIHOVyjyBgyvnrFjrPM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yq9WU0ksNuDCpPIjvOjViUBVc+W8/bBXNQlgVRovj2RALl6OTjbfZIVE3oiSfXHtCL/XR0Ml1Zh9CQ0t228MboyWUabvWdAU2zT1DPD8LrHPG81OdEDjHUS8AYjgTviVd3F+4Bm/ZvaED2hxxBsyyeX2NH4PD/9Y3+fhohXX5xE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bNvOejhY; arc=fail smtp.client-ip=40.93.195.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bNvOejhY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8gSwUmmPVU/smdDy0kQ0m0z4q57ebqraxagWBo0+Po6LyBw7z33V5Gzr4DWQECz18D+/Eyu1bACBwRR/DhaeqefWgZFkhKyc6T35XXE0Avxa5L+/P0zKvwA2IXkc5GymH4RW1ZjadfU/OqG4wt0iCF7K1sad30KjcSZp+5TaNuZDIx+49EBd1DtpK2/xqDV5ZgEqvA3zeQBtzm41382r/0HNg9RnOR5ewAwDYXlMyLJjTGjOjffjr+U7aKBOBfWxWSoG2hNaE8zOuyRfeLHxP7gAeMK/VYQh599hL1PUAMMd9lOd/RyLgqRetW7kSWl3sm2mjNY2aSfjwG3AZWHyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfA0EvR/T2Qs1YLs1twGWrV5lf0QTqOhxS0v4Smuh5I=;
 b=zHIJ/Tn/bN2GRfOy1PKEg9fmEvK6A8sGxUnmd+x2+w5fSQgbIUSc+PVP9GSejxudsygOZjb15T8XYBGXCDQVNO/J0nxd82fY9ZpdgCW2N8FagTgkgIIllt1EbwBGdk4kkDLvZWj1AeTi87Kmg+cuzqgfbCKxDk0mTemthcPDmCTeVIivIAFYtcVN0LFyG7hUwZmtscJ9GH38x08eG2iYOQAfq/rYfRtHEebDC1wPOXBudlKufsCwF1J+Bjz/kfITfXZMI0Ka2AJLpaUHa2gOt4+g9ARZirdsZjN+M7gdw0qBPvtwNYE9rmDETjIY3D4MQY/prTB/1aF0KIENB2DBdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfA0EvR/T2Qs1YLs1twGWrV5lf0QTqOhxS0v4Smuh5I=;
 b=bNvOejhYVGMKeGGc202haMIdEPDRNEyb4ZmfHYBt9eY8MnXciTGG5kff/huWkxjmDPjrCXWAy6p2LOXuU3dDJn7VO4R1qsp/9ze274PeBCNmEwqKpyvxZJMjkOYhvUeO9XYGZ1KR5l1obi6m5bdBPK44QoX0dH7oPbf+7y8kZWNNazKrlo8qxhJVOOfy7tzzSOdmz/a9JC/vtwyBQ2JXYCE67usivfSJM31sHvNNzPLPIH7Yx0jkOblEKR/2Lelc4oITvF9uzPgWbkLpEqdtyjSoIT7POwo/aoHhrXINlXf6bUdqKxTYhXL3mup5fEskS8ViGqQVhrSIFYvOZ792CQ==
Received: from SJ0PR03CA0234.namprd03.prod.outlook.com (2603:10b6:a03:39f::29)
 by MN2PR12MB4376.namprd12.prod.outlook.com (2603:10b6:208:26c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 19:31:21 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:39f:cafe::5d) by SJ0PR03CA0234.outlook.office365.com
 (2603:10b6:a03:39f::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 19:31:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Mon, 5 Oct 2026 19:31:21 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 12:31:00 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 12:31:00 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 5 Oct 2026 12:30:59 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<praan@google.com>, <kevin.tian@intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>, <kas@kernel.org>,
	Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>
Subject: [PATCH v11 00/11] iommu/arm-smmu-v3: Adopt the crashed kernel's stream table for kdump
Date: Mon, 5 Oct 2026 12:30:43 -0700
Message-ID: <cover.1791226953.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|MN2PR12MB4376:EE_
X-MS-Office365-Filtering-Correlation-Id: 3123a19f-319d-49d2-754a-08df23173c76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|7416014|376014|11063799006|5023799004|6133799003|260925021911599003|260925021311599003|260925022911599003|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Vs7KKYe9sxtUrhZJolFTAhFrTEL7Vcm1aPV1jnxkdxUbC2mxUcBvsY6cvw8Mq+oMOzy2QZ//zVnLHOa2+gzoXrBQtb7ilvyNZJugqe6XqNV3zD6u1Uaw60DOOdHu5THHJWtwYfyeZ+e2pTCNKE4ivgSVi6DDsXZdy8VehTXuX6Z56UL9z0Qf/gjBuyoS8mJziSkuMc2h4B1S97h1oe3AkfTKTEAkTvVxp2GK++s85xq5Frcx2JlNZugoTdIAbbY0dR/fjFDyeGr4ip9VAkGWeUtm/KUe+UaGKWl4DRp6qyWu5qY319/RhIIs3szfnrukgXaSw/yXnBohxIrUPrzQUHiAzoHcO8hhOfRPdFoRLNNpwMOMw2L9t70K+vsNja3V1ezI7ikXVFdZtw5ssdWkyy+RExBTqKXJ3pVDEv9jxKRQS8iuiCsllvaUddUwWIUh3GGWY/SuNNSPsXEYkEZhwmU+DOe8I8/4Ez1VpirHkU3nypgrJh3/NKnf5Itdo30+7PfQM1OgXwRM1+Kc7P9qwxk0OTDh79RWpdsdvgeg0DqMT2YToWopKr/qqTqpM3tCa4TtHNCQqLQsujPPQ8SdFxoWYg93Sru/bJqCcFDTfzFDoGllnL2694fMhkf3LG3Az4pFgmLp5I7XEO8Z8Dv32GE7yXU9cJjFPBzMjbALzmww8/pu1MCA+T7nK0rOCroQ9LJpENqOpzbLTPaxreFNwQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(7416014)(376014)(11063799006)(5023799004)(6133799003)(260925021911599003)(260925021311599003)(260925022911599003)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CbVGcaz54wMsVbnG9sQgro8TTzDmGpUfWNoIpmT3ATV8Q2OvVlGyN+29jd8CUgaVu1cfwNuIthRJjEtk0fMkOhoZvhXxUZeBgVRAJJea8Ntibg+Gubv5rvtyRTDrry9L31yWqfJ3X3ameRbKie5drXdIv2JFfQneZbxMu8rv0ngjxPc4U9OKHkWmPB4JCMkqYFBy2o/0BkOd2wwBxSNWmnmoPU/6fJkf5M7HAS4ULqxOXuOJgYOdk0e/8T5uT2PN2gjT9dIOykKDbLnsFFdvPxWOYaWcU9i6OKlXeXmmmXtjDpaTJQBtlPHtR3kem2qrwb58zPuA36P71EFr1yxdUJmcbpL/SBaIlu75MEWbUcjmQCOMeqYQBZQToLLrBs4eI4LBRM2wdd1nQJ1Hm3Kuyd7XXvA3ED3eb570QOPbx2H7D6+6am6Mg+UZOVzl2DX5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 19:31:21.5285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3123a19f-319d-49d2-754a-08df23173c76
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4376

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
Most of the new code is in arm-smmu-v3-kexec.c. A hidden ARM_SMMU_V3_KEXEC
config symbol (def_bool CRASH_DUMP) controls its build.

The common helpers parse and walk the crashed kernel's stream/CD tables and
reserve its in-use IDs. The kdump code is guarded by CONFIG_CRASH_DUMP. The
helpers can also support the proposed SMMUv3 Live Update work:
https://lore.kernel.org/all/20260929071950.2710070-1-praan@google.com/

[*] For verification reasons, this series only fixes coherent SMMUs.

For non-ARM_SMMU_OPT_KDUMP_ADOPT cases, keep a status quo since the commit
3f54c447df34f ("iommu/arm-smmu-v3: Don't disable SMMU in kdump kernel"):
full reset followed by driver-initiated reattach, potentially rejecting any
in-flight DMA.

Note that this series is no longer treated as a bug fix, since it has grown
fairly big and most of the kdump code now resides in a separate C file. For
folks interested in back-porting the change: a v6.12+ kernel (since commit
85196f54743d ("iommu/arm-smmu-v3: Reorganize struct arm_smmu_strtab_cfg"))
would be still compatible with this series.

This is on Github:
https://github.com/nicolinc/iommufd/commits/smmuv3_kdump-v11

Changelog
v11
 * Rebase on arm/smmu/updates branch
 * Add Tested-by from Breno and Cristian
 * Add Reviewed/Acked-by from Jason and Kiryl
 * Update commit messages and Assisted-by tags
 * New prep patch: swap EVTQ/GERROR MSI indexes
 * Skip EVTQ's CFG0 write and vector allocation
 * Merge arm-smmu-v3-kdump code into arm-smmu-v3-kexec
 * Fold patches accordingly as static functions require callers
v10
 * Rebase on v7.3-rc1
 * Bound the 2-level entry count before the shift
 * Drop the vmid_map devres action that landed upstream
 * Validate the CD table base alignments during the scan
 * New prep patch: make the ASID space per SMMU instance
 * Gate the EVTQ/PRIQ on feature bits, so kdump skips both entirely
v9
 https://lore.kernel.org/all/cover.1784663183.git.nicolinc@nvidia.com/
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

Nicolin Chen (11):
  iommu/arm-smmu-v3: Init the vmid_map ida before the stream table setup
  iommu/arm-smmu-v3: Make the ASID space per SMMU instance
  iommu/arm-smmu-v3: Swap EVTQ_MSI_INDEX and GERROR_MSI_INDEX
  iommu/arm-smmu-v3: Add ARM_SMMU_FEAT_EVTQ for the event queue
  iommu/arm-smmu-v3: Disable the EVTQ and the PRIQ in a kdump kernel
  iommu/arm-smmu-v3: Add ARM_SMMU_OPT_KDUMP_ADOPT for kdump kernel
  iommu/arm-smmu-v3-kexec: Reserve crashed kernel's ASIDs and VMIDs
  iommu/arm-smmu-v3-kexec: Implement is_attach_deferred()
  iommu/arm-smmu-v3: Retain CR0_SMMUEN during kdump device reset
  iommu/arm-smmu-v3: Skip RMR bypass for kdump adoption
  iommu/arm-smmu-v3: Detect ARM_SMMU_OPT_KDUMP_ADOPT in probe()

 drivers/iommu/arm/Kconfig                     |   3 +
 drivers/iommu/arm/arm-smmu-v3/Makefile        |   1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  52 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c | 746 ++++++++++++++++++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |   6 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 273 +++++--
 6 files changed, 1001 insertions(+), 80 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c


base-commit: 2888520bdcbe0599cfc77b2fad8dc6c95505a3cb
-- 
2.43.0

