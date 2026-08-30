Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010002.outbound.protection.outlook.com [52.101.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCA1356751
	for <iommu@lists.linux.dev>; Sun, 30 Aug 2026 23:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788131937; cv=fail; b=SubTAer5lIbGqOJGrAcWYs8+iCyCNSZGfkl4gGrV+oOpzSez64SllKnNAICYMsRrGdH7AVPJoTW1ed59Wl/kTKWC9DXchHOYPoJpZ/mWWv3Q3GepC05Jh6kj2gRpSeEnQDbx0a4pifHldzCIs/WiKf+n6FzuCK+wSPcA//cXn3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788131937; c=relaxed/simple;
	bh=Y0FJE5203W4tW187iLgqsWBboaiYtwUD6N9C2MkK+es=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EWZY/cCHAxZNByYLNwSeEsmbc+sNPR1Yq9IFbPmXltuv5fVUqsQp7aYNiqdkxhq0h6jvh0bMkATZbQuJawHrIRt6oWCet9eHfd6uvx3KO4aepUZKqzPyzD/GcBth2Fm/jUEDh2J7qOqWH+3uzwzrg/YbwWonXFl5bchkPs8v0EA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ORLuWVdX; arc=fail smtp.client-ip=52.101.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ORLuWVdX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sEjsz28ZGgouVDKRW2BZc0FG9VM7xRqMW2TpcBdzYCTLvkfeA7PvbbtEXHLQOOfzh7/tdI9wOiKatHiTt9jFpCmMCyeZI+c6C4wht8LK2t+fGMOhGlUz7q8IcsMlxDRSPtaRAR53YkvnLHwyLS9wnZdHv5qFxa+wX0XZkPMVUvv1Z5e6ap1UmMiiTQL1CwYpl4hlYouhD1xQKvRKBND7lrcu8jmcwA+vY6KqUzKNcSHEUzC/SZ5OVvpsQViGyxyLx3l9+vDE8tZUTgYWHZTLkFmYWlF3GqNMHy2vWQKhBqdP9eRPd1ddUYHCeyp5rFSg/LVcbdmnwagVnWdLPQUkCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iADgSC6B7FBsxhVvUt7uwOGrkfIBSBd7oPtcE7MfK7g=;
 b=TzsThS6a/rjwyP725//B6Ad3o1tWtYkRh7FpRq3wQJYeQEfnEIXZhYKXrqEXMqe1L/HwfdkoSlWtDY09puA7QAj/58ZIwK3j+8asW6+lwGBQ/3C4X5wxfcVw1+lAIMdaK4j4+D7zGE/N/laAORQHmWaqt8291502x6M0kJKRig2VMRkYzN+kbb9DgHfEHak4BJKQYGS65JD/4Jc+4mfpNyH+pYptKFUJKduS5Y7WMRfOvIfsur4DXbhZ7b8Wlx0iR7ubjfNQRlc6ihJpqXUA3CUQYJ4rDvIIQ+bzfnX/a5WtcO1Gb8W4kvVYdOIwPpI2uvKGP5sKerGDTvhQMBAYCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iADgSC6B7FBsxhVvUt7uwOGrkfIBSBd7oPtcE7MfK7g=;
 b=ORLuWVdXF0JOvMcHxue5XDW9cyQcNo71oK+xEnFVUakj+RtzdovopJxEdUU1SeWKIOn98oXIbmgWv1Pm/GbHBV9TLgEirQLPEpB40H+9yNSPuUOT/IPOMdbo1zou57QiBMSzQFMX9NaheJgBauKDjP3hZYbG+kua8vnL2mmOKNClMdMGVFcjkLYOIZVtNEZ6vK33xnmSuf1L4x1vzGRgO/ShTtRyGsLNWn85TCHdcDsAilNV4H6/JLj0PJIC49Za/Gy04VrsN5axTARnvxxOqsznlrGkKrchkYeRIzpDwu59B1/nALnzEX/JKQLE/oVEY9O8xStr0nF77KA8/zAx5Q==
Received: from CH0PR04CA0120.namprd04.prod.outlook.com (2603:10b6:610:75::35)
 by DS7PR12MB8276.namprd12.prod.outlook.com (2603:10b6:8:da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 30 Aug
 2026 23:18:40 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::12) by CH0PR04CA0120.outlook.office365.com
 (2603:10b6:610:75::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Sun,
 30 Aug 2026 23:18:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Sun, 30 Aug 2026 23:18:39 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 30 Aug
 2026 16:18:31 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 30 Aug 2026 16:18:31 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Sun, 30 Aug 2026 16:18:30 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>,
	<kas@kernel.org>
Subject: [PATCH v10 00/13] iommu/arm-smmu-v3: Adopt the crashed kernel's stream table for kdump
Date: Sun, 30 Aug 2026 16:18:01 -0700
Message-ID: <cover.1788130528.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|DS7PR12MB8276:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ff18a22-885c-4b2d-f876-08df06ed06b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|7416014|376014|82310400026|10067099003|5023799004|11063799006|56012099006|6133799003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	ZVladL+LrX96H7RSW5N198YJ3aCdDS/NvYDYobMvhIg+S35f+rOqZVwlXOi8rwf9IbYXRtxkVZhfLHgMlrjp05/20qDy1MbcF68b+wsab9HKXbSLX4bch/hE31tzYqTH9i6kmNxbOoii704lpAabtumzC8Fy/ThYmfd/Cm6eFRTCxBzrMaI2KsdVqfqU9stDJYBTPDZ8m08BR3ONNQRhcW34vtc7PmAkeQRTczJTEnRL5KIgf9HzwvYa4AA47GwMo1GoLavOtJt5o575GOAGbhbu9JOzUBomitEK//Ka2UTs3wYWprEbnodM9TERvwKF4cyIrpG0iilQnc9kr5ZBxyQes4QVCdo1MQPIOTgObI54dujxp5YnedcgetqnSHM54OGyahcmztbTLrwBbyearC62w6uWKzLctJA3oOLuZgQ8IrECMs6gcfjuhNaGfWJ5NwxzrN3UFOik8+uPNqmnoD3Vq3YP/lA1XseBGvLXPOZF0dH0xZWcEP7vi2xoXe+xAoXFUfUzCi2ADXmifzgtaEfOflWhIXufd0NI9Wed4x9RmvzXElVU77qbaKXJukaJCO2EzkRqeY1h2dFzAmak7HPN1N2zlfRstV7wtvKFLVINLHeThppd70XATJdEp4ShSKWkf1x+B6vROtq3bOx4+4CT+kKtQfMWWz0dDjScRom9c2aGsQzLqJp+gXLVO9xmVUc9sp8DMLcGTY5SY0UryQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(7416014)(376014)(82310400026)(10067099003)(5023799004)(11063799006)(56012099006)(6133799003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CZY5PGV++Xa1QJVlcgu2xzRcj3WTPaa22u08odhoqF0TFKX0k5BpsSwaTzmJKA+ve3+qqXBY8tnIC4vAq3n0df2X1vc/U0A/qxoJsL6ObpqpgJxAFj7s65ImYwFRzkgQh084/Dgp9uKQpwqhzXXjUQ/aivmsO82NPhvHziw7KtgtB9dRDpH0CovgwbfZ+We/6qSeelgHFEPBOWil3VvFfWbPHsdeqAG1NM+7KEhb0vgJgJRDJZxE25+dOU0xdX5ctAqq3H4jVzIr/taqA8cCbfz0cbHFIqcJysI7BtLOpY7s5kaA0ju0B1pBEQ+W/wGZqsxOVXWMNoB3RHA7qUrUP6cMO9ljKzvzttNakFFZwh6UzRu31OMd7UYnS3NhI3jlT7WvPrs535u+NCuplZx8AVTYrBC8dzKW/aUo9jhoBv82jKOsdmeqbqgr5ul6Jg/g
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 23:18:39.8747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff18a22-885c-4b2d-f876-08df06ed06b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8276

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
https://github.com/nicolinc/iommufd/commits/smmuv3_kdump-v10

Changelog
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

Nicolin Chen (13):
  iommu/arm-smmu-v3: Init the vmid_map ida before the stream table setup
  iommu/arm-smmu-v3: Make the ASID space per SMMU instance
  iommu/arm-smmu-v3: Add ARM_SMMU_FEAT_EVTQ for the event queue
  iommu/arm-smmu-v3: Disable the EVTQ and the PRIQ in a kdump kernel
  iommu/arm-smmu-v3: Add strtab parse helpers to a new
    arm-smmu-v3-kexec.c
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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  68 ++-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c | 285 +++++++++++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c | 458 ++++++++++++++++++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |   6 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 247 +++++++---
 7 files changed, 999 insertions(+), 71 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.43.0

