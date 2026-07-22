Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011055.outbound.protection.outlook.com [40.93.194.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884D84C77CA
	for <iommu@lists.linux.dev>; Wed, 22 Jul 2026 10:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784715667; cv=fail; b=gY72/x61VyCYZwAhB6p9NDSu8sEH0X/3aet4sfQMp5nWVcjhJc8ZS2HVD9Q2k6BUjH8QLnbT2aSxQ1MihV5V+BbsXK6JQ7Z/CduHBoSpx/NA/wturFfDeYqbbnBj7CfA2vlcZh61TWX1kPXCE8i/gXr9h+kQKNiUQ2pPQd5K15E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784715667; c=relaxed/simple;
	bh=lbGvNNYGeYcfuO/AaBw9QC2rLexz6fjJlug0Gu5W6Og=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qKHAAKuG5L8vBleVGQLwrOQ0tC/4euhjSFGACLpKl0Vq/3Xi4g7wg2D3Ag45szPTOBg1WC+5YfGaqlaS2jcTvmeooY2ivWu2/Et1LysoeKZuk1m75f3RHsaDmi3Vr6MzPN5qjAF/hc7gzON/BXygXSge3EWyuTgE9COhk8gVJfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SnTDwiyq; arc=fail smtp.client-ip=40.93.194.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SnTDwiyq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqjV8tBaNfrWVVdVNQcPQyTzMTgUBqosnBd7pLFDtPlUZvr97kpzK0/3YUFpsqL/DPk71lL4plmT1JS2D5kujeCHcv2P3Lla13K9EOZwYRAbMz9XmORuboyq70YiMF2EkfV6UHzDeKkjuhQ/p70yHRHww2srKlFEw0ZpoI1fPVXj6EizUYYdOaAHe56KgRXzepqdq8e+bFxsmCEKfYJgy0Ax++3hxWSTDmwr3Fw0zOdXwJg3ISWgklTz+5BTIEcfZNj2DAXJNo9VrA6Q04XSBUJZMavZ0YaQ1fTMoDR9QAkM/02B91POhGuWRZyhLlaHNu/aaLn7rVn986KBYYGyHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTGUvwO/a8Xh8ojo+oTIpBEPkFLXw65olgE7AZ8diDw=;
 b=BEDCz59HGp1H+HP739DTS0ewbtJtlDFm+3pCP6VsvZNwCnyIIu7JZvDry/Kdw6BXGdyqBdPMeVnns6jrDiAR6CCn7EMPHb0HN9yGaFeo70TM2jfwnUqFx9ntm420igJDBiw1Prr7KsLkZzaQp9pBZ9H14u8jDq4yAObMgbzpTB01JiNTyEkPoHlScxZErxnpT912+7Cc+wkQshQuNa6UOy7Ilr3zeDndbUpHc8hA2SkcaTP/Z+PQXtBR/7OLXq6PUwx8pnLhHRVwQJTOgED4RRMrLo2x9tmb2xghiiNNgPLlZx44HHCU86DS3IjmjISjZay8CBaUsIeQnk5s8D4vdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTGUvwO/a8Xh8ojo+oTIpBEPkFLXw65olgE7AZ8diDw=;
 b=SnTDwiyqmXoxgSHH+VQCXXVsAgqlp1bD6Pe8rwSnGiq5JJltDpWfQN5AknHTJSYKpPKD2sBeXtHLkMeObRyUfkWo3Hp1ZduBYTPcj++0W/ZMQUxUAu9s4b9jZld6bKNFy7NEmR67+xaz/16C7Yqk4pDEXOSt1PVHdvNBpewsEbHDqquUGO/Jc2h+GOIDpNnq9wnOE5PpMV/Ewp8GBjmNEcTSsuJu06v86830t9dS8080KWvwM+oolHTufNGIXdgvsiFwr3sU+Py78/YP8a/WNvXyEnWNXeHxLKcpo+ojlY4WjTYG3npuAa7C0ecf3VIKKCEDnSqSaxnE5hUsxFUquA==
Received: from CH2PR03CA0012.namprd03.prod.outlook.com (2603:10b6:610:59::22)
 by PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 10:20:47 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::48) by CH2PR03CA0012.outlook.office365.com
 (2603:10b6:610:59::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend
 Transport; Wed, 22 Jul 2026 10:20:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 10:20:46 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 22 Jul
 2026 03:20:35 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Jul
 2026 03:20:35 -0700
Received: from build-amhetre-focal-20260716.internal (10.127.8.12) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Wed, 22 Jul 2026 03:20:34 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<nicolinc@nvidia.com>, <jgg@ziepe.ca>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>, Ashish Mhetre <amhetre@nvidia.com>
Subject: [PATCH v8 0/3] iommu/arm-smmu-v3: Tegra264 invalidation workaround
Date: Wed, 22 Jul 2026 10:20:30 +0000
Message-ID: <20260722102033.1122277-1-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|PH7PR12MB7210:EE_
X-MS-Office365-Filtering-Correlation-Id: 74557c53-a493-4f47-3846-08dee7dae55c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|7416014|3023799007|11063799006|56012099006|10067099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	C//sweGzGGkDV1r+EtguxOBcoLPRlCmU202eU0myw0rnyV13n0lZWySClfLlZIPgTxe4Rr/JvcmE7WjbhlfsRkLXyLmqrRPcfAXpVOtO+0EHPe9WSlcEpFaA+K3SohpJxm8LewjjygwvoqAaF+9AE0sI/CbI0ncI8cSpfDQoAFl3XbZyy+CsqQb6eFmym8vzwGkpLH7Rq8YtwOoW4/XpkM367Y0reEBD9niLmXf3hXzUCWPYXnXdr0psD1X/W2pNlMqU/xNWtiwYay6IpTCGmrm1smS+wXODzuKsKvGWbxp4oY8WIXOcHcQKyuolugWH6ZV93LwG03X8p7WWCK+TqiJO/RkdINx3YdkeNurSAcf68Ghmm3hx8GpHVkyAcKeLW5zotDh/S8M9ttqGE+P9umaCgPqOWGQFGlhMvBL+Vf06XbuHLu3sJhyCH84CZvlLPlVVh1c4DfGOwYWJA6dINSv0bSN4Bs6blaHwVf49d0GLulJikXMzeAUWkgfQ3nSq8GQf6x2lFJKYg2ToKbSVS55gHUGM6sY0wek+8ePtuv9SqgCTS7PjGl3NHETTWvoFzUBwhO12W046qZRkUd3ljh4QEDTJm93F25IRyp6q4kkQRmnkFTAmXsnkg1marPYH+Ayl36W6p5dpvOZXqzbs9h33H6HKurcymSnQR3kjG6stPfFkTLrsPiHH3hMzuxs2vRMrKHd79Plr/AnzbkB66w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(7416014)(3023799007)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PDeGwzC/9Xy+hvcvxNTYtJFb2uXhSzbCRVCqVEErfaEUN3vJ0NdLwbLWzDuWwgQyzLGkEC+aDu6Uc0lMcvea/YO5fZ07/kRrTA/eoe/KAd6eMr1q5/rlENpHCc7FWi0MdpFkGznnf8j/66ky03YN68XYY/GaNKI/YZUhoF0AhNSY8aglEq0P4rf8thNyk3twgeeIH/Y59hPuVucSFnEiWuuqH02b6IjWcingx2C8+TXazPnwlH2vJScgj5dMcSb+vp24w+O1a5FCsB+ElTmBn2iJw7LA+RjwR787AcOJxlJGq6QAcJfdxcOugkJLtPU99ahH0uN23EjA8dtxmpJn6siYHQaFouqWfxWRvzK4I+NiwwxuEEMecoIWTa2Oi+yZCZYsnwLciUX/uiIYDoIGoShj5E9GTu3viTZI53VylK1/nad0VqesCBBrR2KZzItR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 10:20:46.8801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74557c53-a493-4f47-3846-08dee7dae55c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7210

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
     arm_smmu_cmdq_issue_cmdlist() wrapper that re-issues matching
     cmdlists for host-internal callers, and the batch-helper
     force-sync condition. The iommufd user-invalidation path keeps
     issuing user commands exactly once via the raw
     __arm_smmu_cmdq_issue_cmdlist().

 3/3 Enable the workaround for the existing "nvidia,tegra264-smmu"
     compatible, document the erratum in silicon-errata.rst, and
     report it to user space via a new
     IOMMU_HW_INFO_ARM_SMMUV3_ERRATA_REPEAT_TLBI_CFGI hw_info flag so
     a VMM/guest can apply the workaround to its own invalidations.

The series applies cleanly on linux-next/master (base-commit below).

Changes since v7:
 - Rework the nesting/iommufd handling to report the erratum to user
   space and stop repeating user-issued invalidations in the host.
 - 2/3: drop arm_vsmmu_can_batch_cmd() and the iommufd batching split
   it added. Expose __arm_smmu_cmdq_issue_cmdlist() and make
   arm_vsmmu_cache_invalidate() call it directly.
 - 3/3: add the uapi flag + enum, report it from arm_smmu_hw_info()
   via a new arm_smmu_erratum_repeat_tlbi_cfgi() accessor.
 - Carry Jason Gunthorpe's Reviewed-by on 1/3 and 2/3, and Nicolin
   Chen's Reviewed-by on 2/3. Drop earlier tags from 3/3 since it
   gained the uapi/hw_info change; re-review appreciated.

Changes since v6:
 - Add #include <linux/jump_label.h> now that the static key is
   defined in arm-smmu-v3.c.
 - Drop the unused smmu parameter from arm_vsmmu_can_batch_cmd().
 - Expand the arm_smmu_cmdq_batch_force_sync() comment to note that
   batches never mix CFGI/TLBI with other commands, so checking
   cmds[0] alone is enough.
 - Note in 3/3 that a guest kernel enabling CMDQV on Tegra264 must
   also apply this workaround, since guest-level VCMDQs issue
   commands directly to the hardware.
 - Carry Reviewed-by: Nicolin Chen on 2/3 and 3/3.

Changes since v5:
 - Move arm_smmu_erratum_cmd_needs_repeating() into arm-smmu-v3.c
   and leave a declaration-only stub in arm-smmu-v3.h. Make
   arm_smmu_erratum_repeat_tlbi_cfgi_key file-local static.
 - Add an inline erratum/workaround description at the static key,
   referenced from arm_smmu_cmdq_batch_force_sync().
 - Fix (rather than drop) the misleading !n comment above
   arm_smmu_cmdq_issue_cmdlist(); keep the defensive !n guard.
 - Remove the unused smmu parameter from the predicate.
 - Tweak 2/3 commit-message wording ("commit" vs "patch").

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
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  7 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 89 +++++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  6 ++
 include/uapi/linux/iommufd.h                  | 12 ++-
 5 files changed, 102 insertions(+), 14 deletions(-)


base-commit: 0718283ab28bc3907e10b61a6b4be6fefa1cbb2f
-- 
2.50.1
