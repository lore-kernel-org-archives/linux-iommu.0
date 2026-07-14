Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012037.outbound.protection.outlook.com [40.107.200.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A47836A358
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 10:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025746; cv=fail; b=iXMgbg7Q9Z2KQ0AnYFR41mbL6+Wxii4RTE15IOXeuFTBr4QJ8Ley1lZ5DYrDYAfPeDanbyKwCWwiCR1QxC+zjFkgyNG0jd2taVzNMouUU/D65Zej0QVr7mVX6WOpVZRCtQi23ZGUbLCPOf79vilSHxVVvOM6PbohUsJFPUe4JDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025746; c=relaxed/simple;
	bh=tDSIAleWQkrx2k3jRA9G3sco6Hxom6NwC8B/9kc9HX4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ls41in72YzRJc5gUcfIoJUY8EuE+6QJExFSJFRVisdFYweoxCFhnhVSCFM3Q+BVL/1qdxnXfpbOFgP5AalIuZgF0whA5MBAABUY+Av+Qoq+EXyOfNrrlSEF+igmHVXBY7itFjPfJm6fmnLQA0ereLiDfzLX4TN6BEaxWNlQtXKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sMMegLzS; arc=fail smtp.client-ip=40.107.200.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sMMegLzS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLF6kWpYQhHFtKUsZx2/x8XqkhDjVomj+WhIiLLrH7b2bPgSqc931hmDyOLEDGkK8Amw6FkPcKxK9ry4H9TXD0y+s2/b05KIwxSqs7pyTy8N+GfQ8MR0VKwS/kxzSMiRPxjqkqGgSFRcP8TACFFsLNvubXOhmgjXx58T0bjOUH+6J350/ICo8UgI+BB1o6+b5pASLt8uTLOV/B06xQZj+2P6PKAKqQD5t+ehJ9MYrkK3QSEDMLFPqVd8vgeBLqM1e2MmbDSOYaemys/siY6rJOV5trED/vu0BVJaWhTA7rue22YwFF/vYwkLHk52xD9LNwtPyzHdmH8oW6f4MaZLdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nFGjx2hP82JEkaFIq8Q3IgCQ/KznPSMk0LX8YWYitQ=;
 b=pI2E29pApB/lRC/6bo25mbfgCGPuOJY2cG3n27DXurJ0RvHu1aLp0O5DXvpEF7FHbqPEqIGbb6wANHDL31djXIx+Z8PtrR6iAe8JbwNz/nQpaNQwpsfNr/e8FN47O9hGH0RLuR1mPJfbJQoD/ujx7jnlkiWCs+4J0NNYWHq3kuFCaNCZcdMuENdqhgVHoE5JZVidxcfxvlRZejV4fWMwxIhs0k0iYso/WvTv7+IgptQ5VOwWpjIxAaCQ6qdt9X2h/lEcpTkYlhzXMRchTi/SvqXRmbdxq1OFH7Cjb3RGh0QTmo2BTp5ok2rg0WrywFFW45qnshrGJrc/imxj+YweKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nFGjx2hP82JEkaFIq8Q3IgCQ/KznPSMk0LX8YWYitQ=;
 b=sMMegLzSJiazTggjx0hQMPRPwnFh46TyiQ6pXyvcHx0y4RYapTC8WHgfM6lzf+RitS19+//p2AlW1JvgsbGTtHz1I2JZKTLmejDkz/jSrBMYPQdIyKdYDRnKbIQhGXnk5+kVf5zL4KbqdxTSs1yvhTb4OIyvyGbPMv+zEYhr4lSl+P9QzHxXftNbirLymYl7ojSW9+4GXsuYaze1jDFWQktLQsSHqP/VO9nX91QEzV64fi/l/gk7GiPO7EgLGsrAlkV5v9LgghLZsKcHka5ihwGnCcNJvonaq0uUt9WLHK3SC0kE1mnQFfqgQA7hVsxWHamNum9/QR2RuYc22l95zw==
Received: from SJ0PR05CA0176.namprd05.prod.outlook.com (2603:10b6:a03:339::31)
 by DS0PR12MB9275.namprd12.prod.outlook.com (2603:10b6:8:1be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 10:42:17 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::ae) by SJ0PR05CA0176.outlook.office365.com
 (2603:10b6:a03:339::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9 via Frontend Transport; Tue, 14
 Jul 2026 10:42:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 10:42:16 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Jul
 2026 03:42:04 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 14 Jul 2026 03:42:04 -0700
Received: from build-amhetre-focal-20250829.internal (10.127.8.12) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Tue, 14 Jul 2026 03:42:04 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<nicolinc@nvidia.com>, <jgg@ziepe.ca>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>, Ashish Mhetre <amhetre@nvidia.com>
Subject: [PATCH v7 0/3] iommu/arm-smmu-v3: Tegra264 invalidation workaround
Date: Tue, 14 Jul 2026 10:41:59 +0000
Message-ID: <20260714104202.1664187-1-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|DS0PR12MB9275:EE_
X-MS-Office365-Filtering-Correlation-Id: c22f5fd3-4acb-49b3-cf3a-08dee19492f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|7416014|376014|1800799024|82310400026|6133799003|56012099006|11063799006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	WqddxghuX3ND3gXF4jqCT07qKV+hS4XTG8LjATs/UvZ0SZNfLTkH/3FTyqrKs53mdxgk7EMe0NEcN4Exdevi9harH4btF/YzZ9Ht32C6dBhZwtIesneh++jjf/RG9/Zg7i9uNQIDY0CVb+VoIM3vctu4roKdlukE4J11g4ezNUTSUYEXq51bNxMy3ndDxiJPgBRn3t55OcQiJmtUryGQQB4hYKCX9tl3ZeGA1c0ij/j4pzp0/fF4R9hT76qOXze41xcHhI/pQYz9qNzc+PZKhAp6e3GwEC8ishqPCkTvnjA2lGRou+P2wKWid++zz8Ziz+BYA94F1t47eOr7HrTuG/U7/pgu2q2lilCo+SqzfPZx5+mHtbS+aOs37wFPkG3YGvcHEFteyel4O+Fo8dDNASdkEdVYgJ1fFJ1grUbfG+B9uEKdfFZQBw7xTKCmCuboAgTOt4a0AE5fCqWM13ujCw4aWXwX7naKxdOtRw6Mw1+1u+thViy0M4SlAGYtZ2TG7c22CTFtQXp2llvJq3qjf2cL7jBDMO0t6Qq+Xk8EBOswZuQkM9JFCTtfbEemGyiDFoM4kC4dFYUYiVFMNhrGCF8svyqGlXL93p0sWpsRRBUw0LxpR03UBmJ+4MBllnzQBl0YJT5R1fOU8hS6mrEM0EXJe5MgNBk+4M2eZeFuAAHMDDSXuVRaz5OZvlJenwFiE3xuseaA3ZVqgYHW26pymw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(7416014)(376014)(1800799024)(82310400026)(6133799003)(56012099006)(11063799006)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IJ6d5PuvewapO8lLZyTqMKLfWtMeJ9xCLfbz27J7hzPhhZRhegB15D8PKmDtvWjT5LLday+t3YBWI4NVYrIOaWZckTq2JzcajO8g9IgVQYo5qWrfu3q/dcn3HaN6cVEMCsl4YC4JfIsyn4yDA/thaK4ZpulohusMbVwzxWvKoiZjFAXU+QEMrCHOs8ZnVNTnW+OymfVM7QOeHk+x9fZepmNdECt0r33zmLb7xCfi65JvGvhihPrJTA921G08jVoMlFknKGqlQBE0yyf/m9tLH2WvUU+F9xp6QFT8FriiBiy9r6Ba3oJIFgFUVg87xOmH0dEmvp9ZqjbPvDbRPeo+peZhFRhg+f1yS0XAJVdo+tQxAJU9EbNJ+tH7yInu94rEZPMNDnZGJoP6kEdPClUgLFzUWY9uJeQoFdp+0XKsPKbZFMFW+9QjQ2+FA2Lmazjr
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 10:42:16.9698
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c22f5fd3-4acb-49b3-cf3a-08dee19492f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9275

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
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 14 +++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 84 ++++++++++++++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  1 +
 4 files changed, 89 insertions(+), 12 deletions(-)


base-commit: bee763d5f341b99cf472afeb508d4988f62a6ca1
-- 
2.50.1

