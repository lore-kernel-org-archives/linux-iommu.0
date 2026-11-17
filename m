Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794943334;
	b=WhVkggfPj1n4WJBOizEuiVxIAR9w96sAuvBuVY5ptjkcfvw6d4mDRaxNg0JGT1iKsEXY
	 qYN08VH3ndLsi4xKUlkLPNYhRekP62nuPfbhzXcF/Y19TRINhkP9tnGASApEk4qAEFu2q
	 IXEWJj9jyMhAfEP4pOYtBqr4qhXOwgO/TRerCmbYSEZv6/kqtGDjqVl1JsnP+pr2v/e0A
	 CGxGDCjTNoa8Z1gQYM7zEKhcWmIdNrDpBuLTuds0DVGdpgVDUdR46KoqXdWXDNqprYaEd
	 Y8UUYvXjYYhZdCJCsBaj1hIc+utYRQDcDCZ+Lgxvpn5T6htQHQqY31K6CLpKTg9heFg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943334;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-NV-OnPremToCloud:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=mY2IuO/oLv1Q2+41nRB1U7oV3so+q6ZSTNIR5kvl2GQ=;
	b=QGHGcUQd4FcD0TcQgzth8XDoecOb1/2NO8C2q600WhOwC318byBRNSRUVZTTN2XtWEu2
	 hya2vvMINlllj3M7BcCmBnbJqr4WUNvIzkdnhunJUtceGj+Gqi0EmUAoZusSqGErIB1ri
	 q4/eTv7LKWXfKGF0ZGJ43v9hrcoxQotgu4ZmpFuWTQPSBvVaIJAZTNwHxN1WB+w4XSezQ
	 KfmDO3EQUVILBsGaDHHFPInQ1M8s74rtSaAIycfWbkwC/T6MT/CbE9VYG39LnCdjC+D+V
	 3aO1cF/TMZkT9y7oZEvzx6FZMwza+WxJD+VWNHM8rEgWO3YOfcRQi64/SugQvLZubZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="JKCVv+/z";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.3
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010003.outbound.protection.outlook.com [40.93.198.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C27D606A88B
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 19:22:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C27D606A88B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JKCVv+/z
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXsc5rHhDMDVPt7R/N+d4kZxm64AmcxRYDlABV9LlO79XLjZPr3kqghPWVM1tvlD7zuHdUPmA3ZP1hBcuF0VhDGBzTaQVuw3wIWz0+6juU+FXkg617bvAoHaKEvLS25WMPl+d99UXYjl/yOaX9tG8k9rIobyqfu2NbqFuCrEVBPY0y2Xvu/rlUfv5Q1FRlBh+AB4+oezImZ1OLmfEfvMU8UeyF/NztWEEC7hDCO643CAZBJEpTeWaZYwEwFbFVM5P8jsj+7cpOCNmZDPu+wh36AhzX/A7uKpCeaByIyxugTV+QlpxMZxO0AWJxyNmK3Q7niI89kvLFmote9QuanXWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mY2IuO/oLv1Q2+41nRB1U7oV3so+q6ZSTNIR5kvl2GQ=;
 b=FSEY5tlAICOUv5q/kATTjC5sF4VLqFVi3xpqKhHqg4LAqEA1id3u/oMhqN7Pr/Pt07R877y8YdeDapAfzGGYTxB6MmINqyjWETdUCTBntPX6HTf3a3h4mf5PHch2/tVd1old/4zRJ1/GkwJqLg7iT9rU5DVbgre16q+mQLrRjgg3SYuBHM+XgDm/uXUt9ZwbREdrUdmIslw2HYjZzP+b28RYyNpjbYKm+SEelY5tS2XGvsFGdKLHSiQB8xs1r3BgJt5sJw+scQ5EMEpV4ArGKO2jHjNlBmBokf+7T49RL8PfGZ0dtBDEqOsJ41tYMUZBEJaP5kD0joOiEK2+/q5Zbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mY2IuO/oLv1Q2+41nRB1U7oV3so+q6ZSTNIR5kvl2GQ=;
 b=JKCVv+/zvtB/9pH3EsEDDQgEHd3d0kU9j550uCQq/bPANUAU12+UzkPI88uzuc/14FNj51eumgBSDrg2uFAND04+3PuPrq+dcTK3e9lxwG66L1hUALxEmxlhqu36H6uuHVNs7EzIHZ2+Wo67aEVrjwoEwZ9JWKxlwPLlUAZPaSA1Cl9VKRD+EgbwG7I1hC6u/bX17+fGi79hX6K2sd6497q+716TK5PnssjKGshz70AFBIQ0p9CHHUGgUY5vpGaay+hvqeLdYD1WYy5svz2sKQq47oy1Zz6LSdtNWX9mBA2Bt2l/PuStL+GnS3p3w/Ie9FIZrEip1iCDSp7gL1toMw==
Received: from BN9PR03CA0575.namprd03.prod.outlook.com (2603:10b6:408:10d::10)
 by DS4PR12MB9707.namprd12.prod.outlook.com (2603:10b6:8:278::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 19:22:02 +0000
Received: from BN2PEPF0000A993.namprd04.prod.outlook.com
 (2603:10b6:408:10d:cafe::d) by BN9PR03CA0575.outlook.office365.com
 (2603:10b6:408:10d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 19:22:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF0000A993.mail.protection.outlook.com (10.167.248.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 19:22:01 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:21:35 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 17 Nov 2026 11:21:34 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 11:21:33 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <jgg@nvidia.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <praan@google.com>,
	<kevin.tian@intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>, <kas@kernel.org>,
	Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>,
	<xueshuai@linux.alibaba.com>, <john.garry@arm.com>
Subject: [PATCH v13 00/12] iommu/arm-smmu-v3: Adopt the crashed kernel's stream table for kdump
Date: Tue, 17 Nov 2026 11:21:17 -0800
Message-ID: <cover.1794942324.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A993:EE_|DS4PR12MB9707:EE_
X-MS-Office365-Filtering-Correlation-Id: fa0a46b2-db40-4fa9-43ee-08df44e00e9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|23010399003|18002099003|6133799003|5023799004|11063799006|56012099006|261026140227099003|10067099003|261022075727099003|261022105027099003|261026121527099003|261028144727099003|261021135927099003|261021121427099003|261009223027099003|261102123227099003|261021123027099003|260925021911599003|260925022911599003|260925021311599003;
X-Microsoft-Antispam-Message-Info:
	FC8VTmsYGebZOIumu8a2X7+7Jv8qlRX/kRcblYAX9+yA9KGzKfPIlf8/qYT7tiZdZPZfglk+uFvUZKRMjfcd/aiyHhRyX5Us2h/Abp6hHVX6duBiEKYEnVzO1T8EVS4+WKtcTNDLGmx91REH5noUrhA0oCWMskp0u67lTWYjFCYokKzgs95sIdX2O/Jp49l9nMLDXRRhW9lxY5nXYqLTnUwykBt5qI5MPVRvARB9PneKc4epMDR9spVvUi0YDAz04Ag/EFFQa2G5V5ZfPEdxliKhQfnAVmNiD80uprfZ27FrRo70NnsZqJRo+HzTMK1G4RXLjh0K9XoLar1hTCUn/JRB4uYV2JbiNgpHC8ZrgE7aa5dc6L9vDUCZEXBTpkvvRcABpox/9ruie2qdtY3RWXvExVZqrRjvw06QtLDaxzraiDBbnyk2J0Xv62uaf4f46rzsp54Dww7rsOoyUvY1eoZz6e8rBkI6Q5XYbpk3hMIMix6e/8mBrI1RF3gPOQL3AA7WyDWMSjQr+riZagT9o3xJ7irZZGsA23pxL7v39biMngcayaoBr+bEHOTGBHjLN8I4tH8whBbfajrHolgJOH1wdSK+ei6zl5xUufi29Hh1YVS/loo9dm0CtgaRg3hM0xILfnawFaWhFR11przcl46wSl9X1yRcizW41i0mnaOVN9uJ8n9AfZpsvMkNs7j1TC1S4qqH5wKBhOuvE69eiw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(23010399003)(18002099003)(6133799003)(5023799004)(11063799006)(56012099006)(261026140227099003)(10067099003)(261022075727099003)(261022105027099003)(261026121527099003)(261028144727099003)(261021135927099003)(261021121427099003)(261009223027099003)(261102123227099003)(261021123027099003)(260925021911599003)(260925022911599003)(260925021311599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9+lTbgAFj2SR14KIRchtyLjWKBDRybvosUtekmG8hc2qY1Wfn0pv2wCzzzqf/1h9RFN0XCAlhD7SA85GV7drHAoGFESAcsVoSTVb5gXavrgm9Oz5GH9qB0T9PkD+B2tlrPHJIv+WDT3jIifaQFoy/laeT11lS4voE7svNM33QCvZGiVfKGDddodoXVBzkYaAVpCBMoNWLGoFr67Oe+xzN43X1cNXMOJ7ZciDU7Wtmu7gSsfLpDUIdOQmiXyasHs4DPxQsJU2ADhqyR/BEKS3izCbkTiFVtaJDbPd/zMR9MHIxtgCGnX0AzfvIP4a0M/5g7zxXygotJIoqKJsYWqRsNn5jmCMCRPZrRu/0mB6XJ1km90wmiTtU1U2nmaCEROXAAklx7jSk/PAqozzVAVnCQruA/GlA6JR8DNrsLWo5h6JK0oFmeNOKEKbO5ibdVVa
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 19:22:01.6485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0a46b2-db40-4fa9-43ee-08df44e00e9c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A993.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9707

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

Patches here are assisted by LLM. v7.4-rc1 removed the requirement for the
per-patch tag. So, adding a side note here.

This is on Github:
https://github.com/nicolinc/iommufd/commits/smmuv3_kdump-v13

Changelog
v13
 * Add Reviewed-by tags from John
 * Note why a zero SMMU_STRTAB_BASE is adopted
 * Make msi_map an array of enum arm_smmu_msi_index
 * Reword the commit message of the EVTQ/PRIQ disabling
 * Comment what the global arm_smmu_asid_lock serializes
 * Fill msi_map only when MSIs are going to be allocated
 * Rename the msi_index parameter and polish a few comments
 * Prefix the queue-disabling failure message with "kdump:"
v12
 https://lore.kernel.org/all/cover.1793593923.git.nicolinc@nvidia.com/
 * Rebase on v7.4-rc1
 * Add Tested-by from Shuai
 * Drop "Assisted-by: LLM" tags
 * Add Reviewed-by from Jason and Mostafa
 * Add a core patch to fix old_domain for attach_deferred
 * Check IDR0.ST_LVL before adopting a 2-level stream table
 * Look up MSI index instead of swapping EVTQ/GERROR indexes
 * Reuse the L1 descriptor check for the deferred L2 adoption
v11
 https://lore.kernel.org/all/cover.1791226953.git.nicolinc@nvidia.com/
 * Rebase on arm/smmu/updates branch
 * Add Tested-by from Breno and Cristian
 * Add Reviewed/Acked-by from Jason and Kiryl
 * Update commit messages and Assisted-by tags
 * New prep patch: swap EVTQ/GERROR MSI indexes
 * Skip EVTQ's CFG0 write and vector allocation
 * Merge arm-smmu-v3-kdump code into arm-smmu-v3-kexec
 * Fold patches accordingly as static functions require callers
v10
 https://lore.kernel.org/all/cover.1788130528.git.nicolinc@nvidia.com/
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

Nicolin Chen (12):
  iommu: Pass in NULL old_domain when attaching a deferred device
  iommu/arm-smmu-v3: Init the vmid_map ida before the stream table setup
  iommu/arm-smmu-v3: Make the ASID space per SMMU instance
  iommu/arm-smmu-v3: Pack the MSI vectors of the used sources
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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  61 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c | 739 ++++++++++++++++++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |   6 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 292 +++++--
 drivers/iommu/iommu.c                         |   9 +-
 7 files changed, 1020 insertions(+), 91 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

