Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012029.outbound.protection.outlook.com [52.101.53.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A903E5EDC
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 11:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783941372; cv=fail; b=DXS6APIXiPEhlBg2BWRxLx7Wn31LGR5MHPf+HANuO5My53EDJ4YWYSBC0Z9J/Dkrea7EESWSxbEA5M2zbTw4eNASZa+EVZT4rKZYdLbspTSJOLhYBjkEEf1rC2ji6ncTdcMZTt9u71nS36i4hzMBihNsED+PNHCkCirzlKv6yzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783941372; c=relaxed/simple;
	bh=hEGfrcizFr9RNGtv4JKdNgeEW8vI1mRKrAfqFDa3BaU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=REN7lLlnwHjBQMptwytR9nmykwCe1pkoDLikZo/ys53UL+eAe2hmANncX3C6ynWruAxW93nhkJdA5p1csOknpeSiN2OdYB3CpLENkAlh+6EP6TuT0hJhqVlzSMAKoSgX8LktJfeCxd6JygyeNvRkAseF7c2gCFsU8sHrf3RtjeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aTzp3UF/; arc=fail smtp.client-ip=52.101.53.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aTzp3UF/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eOIQIjlTSCJ4S452JrilLqSPkubzMfZPL7eIG13l94J7G/TyXKcn2VoCTROFIeWbjRw1GHr2NRG4oW157HUdbWJOTR5a7BscF/FxzQrS0vPWCxcXqvHP/UfnLBExqFEBMdIaQ26OuEAnIeXGzh/aGbzKNUwTV+7uKEiBScBgMDjdOz/Rc03Xh7GZxQtmVDrnK2wATve1Uapi55BWK1dZvRp0ToucDL5JWQiQB6anBphPcouGN7QkF+BtpxYzSNgT+AcEFo30VbHSccvNbeWZadqk9nfry5MzXdhQsCgnbrUP0aziyy+qjehJuSJ8QqVT1Ao0+JRY9QQ5+5RrcVgY9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8weBf1fyxSXgmQEWM5cu/8KhBigfrYFJ7T/OfI1jX8M=;
 b=KCAPXoXS6UbZJrSMlY8sUZ4VDVvPq3IhpSYbZgB1guJVjD1CWeD+V2U3XGezuPbAumGzX+8zx9M9FxLN1sAX+Td+6w/MOpdulPPJSUzey/hvfBUT7eSXKiZADYGjxgffdOuKCv7crG8BLDEEbCmZe5d8ef086ok8HLmJ1F6r39SwLntmR5neowO+v2/676iniq0X1KM8NMGiP724LGfMDgwr/bYM0DrJalT3bo2n9b2aRf9MDbAZvcBjHb0sLAzBoxD3rpN+5noNlO+iHYSdp6f7/nWHAZKsd4swT+aU5Yj30dofmKrjoM+sKxBOzHD84nwXNpj4+7SIGvQ+b7Sxxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8weBf1fyxSXgmQEWM5cu/8KhBigfrYFJ7T/OfI1jX8M=;
 b=aTzp3UF/wLWiP1HSVnbov3eHCjL0ViHqimD8giNj+wgdzHt7Cvh56WkTCl3SL0eGFyA8VurZNISX0NzIhq92EkZB0aYyigjBEz9OVSPz+NqlYsBCYOPdIu5PKQbVTefggQi5nl7jV+MdEk03ptp1Tzjf5dxVrvY/ZXT76IoN4zomqKHqRNHg//i0fa491zM56q1VlSkz5nGpKX1JeQHnh7H+BhkSWJCHUiGJ7bA8WsWgQJ5DTQE+Z2bXWHYd77smruBWGWubCfuz9OaSkIvxVsTGND5weQn8x5NjJJv/2IcrQsDYBAXtWx2JpFcOPwSQHGvlISUR6Jimn0M6qw9jPg==
Received: from CH0P223CA0016.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::34)
 by DS0PR12MB7945.namprd12.prod.outlook.com (2603:10b6:8:153::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 11:16:02 +0000
Received: from DM2PEPF00003FC7.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::95) by CH0P223CA0016.outlook.office365.com
 (2603:10b6:610:116::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 11:15:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM2PEPF00003FC7.mail.protection.outlook.com (10.167.23.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 11:15:59 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 04:15:46 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 04:15:46 -0700
Received: from build-amhetre-focal-20250829.internal (10.127.8.12) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Mon, 13 Jul 2026 04:15:45 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<nicolinc@nvidia.com>, <jgg@ziepe.ca>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>, Ashish Mhetre <amhetre@nvidia.com>
Subject: [PATCH v6 0/3] iommu/arm-smmu-v3: Tegra264 invalidation workaround
Date: Mon, 13 Jul 2026 11:15:39 +0000
Message-ID: <20260713111543.1462161-1-amhetre@nvidia.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC7:EE_|DS0PR12MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: eb7a7450-308a-4d80-2740-08dee0d01de9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|7416014|82310400026|23010399003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	uPtJ36HziNEDSteegfoPFiHYy+MSDbfuSQ+p7p+jWlBxGotYLYHMjJHGjl9dbMzbJhCFeUmvs9x7Yo0jU/sE/clD0jzrblbmORFX2SSeWkLypnu1DlmzaY1+hYiJOsn9x1MLh4mDwkXhRW2cW3byRqgX15bN+cQdPUDugIOStNTfoyhxayaa5JIe+GGMFN+IQXM7grfyYDKzXhoTt7uCMp7cVYbUa7S9SKqiUrSPbgSpqgcO0NqbHsdT0Gndu9VucqHhgnp7CrkZbgFrL2OkAlxyb+FQBF8Z58ulNjvNq9D+31fPVT3elNmCTpksZswbGqeV92dZA2+wI3BLz/o+6xEcY+xtzfonKaerlRZYTEq12/efjsjIFCl2gYKyZ6k4+SkT9co9Jk8RtO6jBzbURDa9Rk6wxstGBNZFUdmIz/ViqROZy1o3sxTCDbJaKu6UTrauE/I2yhjQ5yRU+25qfda8IKpHqC79MWzTqWWErxUZY8sSKbnHNzeZEj/eGmR/TSep8cvPE8muUrtLVm9mMLaWCl/dyhj/3fQXzaP4pcFOe7ApHzEpB6cQ5qLkdb+3JkmYU7SumOR8fAeK9g/ZVbWShPb1OEc6ob83wgvabbNJyLyob2DercQXHBBWPb385oBOgL/50ONLqITmNfO7ldnBZJi1V+aljkx3m55galOsdbCiTiVPIaVa79JjE31vB11vU7lejXN8R9LmUljqLA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(82310400026)(23010399003)(18002099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DI7mXy9ow7+DVANVcwNi5qSyIUatQmHcTZbVj5w379DLJ/WlafTK6ti+9WF5BSYzbI8ouL3RfhgvxtxFJtkkfPze8HqldzPtdiYL3z7n8gigOv0mVqkMUdgiQ+7fKiqOic/2CLbpYf0JREfiqn6T70pM8QPw0d1ymIvrrqj1qgTaiAajmoTlgZ1tuV6zCSMeWZprvrz/HOf+lbT9sjS29Bv/Z9imjH7eQdd1xPgW6XnQ6kEFlPqIhTH+/rD4jKqjYWeEnufbDD+U8Amsys95Ge1wUCcA1+bkJCsLPpl3gTP+Dkntarc590JtR84OXckpBGJwQZt6AzNYoF+M69PpJfatboDkjZLgwmZw7J9fWpWb3C2JqVk1anWLwV0pVIR2HilIEu8i8xy/66NtMyoZHLEsVVmW8S/vtbad4UfdQNfjL6ez0fAexey1Kee5yhPK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 11:15:59.1283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7a7450-308a-4d80-2740-08dee0d01de9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7945

Nvidia Tegra264 SMMUs are affected by an erratum where a TLB entry can
survive an invalidation that races with concurrent traffic targeting
the same entry. The hardware-recommended software workaround is to
issue every CFGI/TLBI command (each followed by CMD_SYNC) twice.
The second issue must execute only after the first issue's CMD_SYNC
has completed, giving the sequence:

    TLBI/CFGI ... CMD_SYNC TLBI/CFGI ... CMD_SYNC

ATC_INV is not affected and must not be doubled.

The erratum is not flagged by any SMMUv3 IDR/IIDR register, so it
cannot be detected from hardware ID. Tegra264 is device-tree-only
(no ACPI/IORT support), so detection is purely by compatible string.

This series is structured as a small refactor + infrastructure + enable
sequence so that each step is reviewable in isolation:

 1/3 Pure refactor (no functional change): lift the existing
     force-sync conditions out of arm_smmu_cmdq_batch_add_cmd_p()
     into a new arm_smmu_cmdq_batch_force_sync() helper, so that
     adding another condition (in patch 2) is a one-line addition.
     Authored by Nicolin Chen.

 2/3 Add the workaround infrastructure without enabling it. Defines
     the file-local arm_smmu_erratum_repeat_tlbi_cfgi_key static key
     with an inline erratum description, the shared
     arm_smmu_erratum_cmd_needs_repeating() predicate, the
     arm_smmu_cmdq_issue_cmdlist() wrapper that can re-issue matching
     cmdlists, the batch-helper force-sync condition, and the iommufd
     batching split for mixed command classes.

 3/3 Enable the workaround for the existing "nvidia,tegra264-smmu"
     compatible and document the erratum in silicon-errata.rst.

The series applies cleanly on linux-next/master (base-commit below).

Changes since v5:
 - Move arm_smmu_erratum_cmd_needs_repeating() into arm-smmu-v3.c
   and leave a declaration-only stub in arm-smmu-v3.h. Make
   arm_smmu_erratum_repeat_tlbi_cfgi_key file-local static and drop
   jump_label.h from the header.
 - Add an inline erratum/workaround description at the static key,
   referenced from arm_smmu_cmdq_batch_force_sync().
 - Drop the misleading !n comment above arm_smmu_cmdq_issue_cmdlist();
   keep the defensive !n guard.
 - Remove the unused smmu parameter from the predicate.
 - Tweak 2/3 commit-message wording ("commit" vs "patch").
 - Add Reviewed-by: Nicolin Chen on 3/3.

Changes since v4:
 - Drop ARM_SMMU_OPT_REPEAT_TLBI_CFGI entirely: the option bit was
   set and read on the exact same "nvidia,tegra264-smmu" compatible
   as the static key, so it added no per-instance signal that the
   static key did not already carry. The predicate now gates purely
   on arm_smmu_erratum_repeat_tlbi_cfgi_key.
 - Reorder the series so the compatible-string detection lands
   last, once all the infrastructure exists:
     1/3  factor out force_sync helper (unchanged)
     2/3  add static key + WAR functions (no functional change)
     3/3  enable the key on nvidia,tegra264-smmu + silicon-errata
   Split the old v4 "Detect" and "Issue twice" patches accordingly.
 - Update the /* See ARM_SMMU_OPT_REPEAT_TLBI_CFGI */ comment inside
   arm_smmu_cmdq_batch_force_sync() to reference the static key
   description instead.

Changes since v3:
 - Drop the cmds->num == 0 early-return so the refactor is
   truly "no functional change".
 - Rename ARM_SMMU_OPT_TLBI_TWICE -> ARM_SMMU_OPT_REPEAT_TLBI_CFGI
   and rephrase its kdoc to be hardware-agnostic.
 - Rename arm_smmu_cmd_needs_tlbi_twice() ->
   arm_smmu_erratum_cmd_needs_repeating() and drop the kdoc
   above it.
 - Replace the explicit opcode switch with a single range check
   opcode >= CMDQ_OP_CFGI_STE && opcode < CMDQ_OP_ATC_INV.
 - Introduce arm_smmu_erratum_repeat_tlbi_cfgi_key static key:
   the predicate gates on it first so unaffected kernels pay
   only a single static_branch_unlikely() check.
 - Drop the verbose Tegra264-specific comments above
   arm_vsmmu_can_batch_cmd() and inside the batch helper.
 - Document the erratum in
   Documentation/arch/arm64/silicon-errata.rst.
 - Guard the repeat path in arm_smmu_cmdq_issue_cmdlist() with
   an n > 0 check so cmds[0] is never inspected on an empty
   cmdlist.
 - Drop the carried Reviewed-by tags now that the patch
   shape has changed; re-review appreciated.

Changes since v2:
 - Split into a 3-patch series (refactor / detect / apply) to keep
   each step small and bisectable.
 - Move the classifier to arm-smmu-v3.h as static inline so the
   iommufd file can share it.
 - Add arm_vsmmu_can_batch_cmd() to split iommufd batches at
   "needs repeating" transitions so the per-batch decision based
   on the first command stays correct under mixed user input.
 - Spell out in the commit message why detection is via DT and
   not via IIDR/ACPI.

Changes since v1:
 - Detect the erratum from the existing "nvidia,tegra264-smmu"
   compatible instead of adding a new property.
 - Centralise the doubling at the CMDQ submission layer and only
   apply it to CFGI/TLBI (not ATC_INV).
 - Drop the binding/dtsi patches accordingly.

Ashish Mhetre (2):
  iommu/arm-smmu-v3: Introduce CFGI/TLBI-repeat workaround
    infrastructure
  iommu/arm-smmu-v3: Enable CFGI/TLBI-repeat workaround on Tegra264

Nicolin Chen (1):
  iommu/arm-smmu-v3: Factor out CMDQ batch force-sync conditions

 Documentation/arch/arm64/silicon-errata.rst   |  2 +
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 15 +++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 75 ++++++++++++++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  1 +
 4 files changed, 81 insertions(+), 12 deletions(-)


base-commit: bee763d5f341b99cf472afeb508d4988f62a6ca1
-- 
2.50.1

