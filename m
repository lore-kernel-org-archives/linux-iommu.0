Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011055.outbound.protection.outlook.com [40.93.194.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708C43DBD7C
	for <iommu@lists.linux.dev>; Tue,  9 Jun 2026 07:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780990350; cv=fail; b=oZNpMAG505QUQ9V3r1MEpqwQd+pX70v7/H+XgMJc5BUr3DSuQIOW+MkIpwZQrul4cQ5Rk1HeGEwPgKEG7+D5UfRLydz+7VgFrrQDi8iUqoz8zZ6J7sAxrEKAs66CO2fPi4eR9fDLeJ8+nF/6scV5OcZFH5AWP2H8APApYdjH7aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780990350; c=relaxed/simple;
	bh=U1MpG5jNKtjLvPvmgVSW4MGjLSDDixKVjKKcgoSbAMM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=omeVn5ax0IQ2pxEv8MKvJtmRP/nOGMG0xsTUInE3BnEZozZIDxH0DA16uLM6y47xquB8gPmamT7XsZpvRYaTpnMrTqkAUgGNCMFmL3kzKMA8S2HYs8ScAXV9P0RCvEkntM6MNTZzVwYYywwVH1cEfFthtRwiA75Gwlyxo5LcIpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uPxH5XCW; arc=fail smtp.client-ip=40.93.194.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uPxH5XCW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=il6RnVQbPk+BfdjjyW++wa3f2Z9Mn47TcUjWr0T3l/htwzHDw3Tf2rPZ7IOFShmuzFs1kh+TUKIEE2LIx8NPPj4eSXWRyU+RFeteFppXCfDdHsVPUuHETldjXkgP08c4DT0Ekr7StGQAOspARAa6BIcxEbXaCneMwPjnRbgXsCwrJULP6vz8AmHzn7PHiX7SYzUFUx4pQ42S8pC6MXCytGRbK397nXnNFMMPaazQdY4NCPFkz/+B/K6859uLcGbhMDtBKBD4UhhiHyBU7qvBjuxIKFXnYnaS9iJx1jQXJuprYLGRmsWD5hVQp+NuMBN9mmfgtau3yf5COwZyeL3h0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRVo6yLr0xIxq3SEtlM3KmhUjxN3fwxjeXMUCa6XGGo=;
 b=wvnxIHPZVqHiNtv22rNnuIybR31q7sZfef24MujJ3wY/GA6TpKN5HsbOEmwUC+WL7lMrHPqQyZzceuK9+N3RvbDXbjewisNZwnuYNmX9diNfN2QUNoaC88bxX57/LNJrJBKyHyW3zG+Z9m+0SfcQGlo2XF51WbKmPsYUpgu0z+2bTpPIUK3qoZIdGUJCTLJYj4HA/8lkITpgXPJaiBq/+t9D3sr8+6TOyAjZjDyMYb74KRPaBv3ou83d5S5zk+2Xw7FBI5LSajLnaNEg8kSdtxZUdFHUpzRQhA8h1gqz1ZqlyPF27egKTAeU8FXns8UE2LlBhfGVMTrxUFI0s9aSgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRVo6yLr0xIxq3SEtlM3KmhUjxN3fwxjeXMUCa6XGGo=;
 b=uPxH5XCWu3f6YJG9NNSQw8bnKz4syNm45VrNAtu335O6BRjSh8JzI7g8mf+D0t7m/GNeIp7oPply3kYh1+T5ovMwNQFtjDrhfqg4Af4Rkipz++5U/a4KFXyQ75Lb0y3l6YbZXwFhDX3lYxilKV4wkH24VwkPD3DFEnqr7OcOjjRlFqYMD67sYU5lSxjWWAq0N7PHwbsMuS5N+80AM3LKGNtn63fIDDg9xYTnGpRhdW+5GlW8PMlHALTBoz4sVSAU0D1r/Z3jZdL5NKwB7iIMfAG0/8VeYQAI8p022be7UZGWry+eJr9CFzIwXRU2BQ8UxBAW+ZtknSGxYhw5VxjWJA==
Received: from MW4P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::25)
 by LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 07:32:24 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::b) by MW4P221CA0020.outlook.office365.com
 (2603:10b6:303:8b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Tue, 9
 Jun 2026 07:32:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 07:32:24 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 00:32:06 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 00:32:06 -0700
Received: from build-amhetre-focal-20250829.internal (10.127.8.12) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Tue, 9 Jun 2026 00:32:05 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@ziepe.ca>, <nicolinc@nvidia.com>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH v4 0/3] iommu/arm-smmu-v3: Tegra264 invalidation workaround
Date: Tue, 9 Jun 2026 07:32:01 +0000
Message-ID: <20260609073204.1760077-1-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|LV8PR12MB9715:EE_
X-MS-Office365-Filtering-Correlation-Id: b06076ec-3eae-4d82-7233-08dec5f94027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	5ziiQ8lXBbe+ensNFVxc09BxT9sNTd8VpowZcY1h02mRllnyVRv9naIdyKD29sFgN3fJTqycpyWJLie1uOvIyICQeXzPxpaek5VXzmullH9HiDa5SyJEzhpJL7fX47gd+ZUnEoDUJoOgYwSIgAn8T3FSQG65HtGchIMR6mtdh3k60AtEgWzFT7aqoQkNrgRgHZkAEnegHT6CRpTrpnUgQVI/b3XQ8kmSG1VORBySNvG9k2q4IedaO7tKPmzyNzzVUrKVr+1aMm2NHFKTnkQ5kEN6OwUPcVEBaMtB+Q3mxBLPZLOWNRfHi8SVmvYaSc3uVM77OxNIaJT9dmAATrHVmo+gbNqJhZH/sjjmTw8PMNYWRrW5yIltOf/kQFG/QqTCifz9SX6oToWsq9AFj6HibXA9EWAireB8giz1alXGtlsTyBMzwFd4nz17L/tAM2926m3TYYov4vETbeOz5RRnAFhNBt7TRL4Kdn4RZS/eZNiS62cDcP/G6nbn//ubXuj/6FiG3KP1DE/FsnjdeYj2GCQ13n+0UCDC9Ri7NjhgtD46gQOJ6/k/NN+tUSZhYGdj9wkMINiTOD2l9JPHA81CZkcbms+qpckB4HnQMd4UF7iW/KYmsd4feK9NQgugRaVtJ8Pl5BnaBDF+CA4m70gk4KHf0IZFlvRcRh9Q2nuhPJsP/7sEu6E8RPe0XcUVOCjXXPwlxU8WawkbVcSno1PHyuU6p1kuEpfpamVBRG+QMGw=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	acfHH1GqcIN5DVq9WiZSdxuG/naAVlDhMG0c3F0mFNmjtfEi0+hiERbKHxDneZ4mO5+p17S0pC7DuEcUA2sodftJS9u7Ky7wI+iDbq0F4V7qv9X4IWWq7dszDo0ss1OPwXkmT/Zlj10jjmBY8lhPUSdpQDtZnhaLBttuMkEcgzbxWu8aFvZD4Dqrw/uVRayUQAvvjQTV5djXYl+6MPioaLdI+PqnkahJQEldoZ0cKT28Cls2n3FTGsFh86KSaVuDP6At1/mN8qpqIF7qyD01JHgYmDt4B1bbjThDMkLL+OZ0RQEO9daxUjXJqvIxjkqbcYV3SsD2BOEe51Pw9ac5o1JxNKXfKI5ERTPCcnsASf0B/34bvZDiOpY6u5+EtB2baRtcyuBwxtPdmhlG0ef3x74LjfpkvmeXQnmQ04Z7+fl49dkCPxOdrtqmvuK5QepA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:32:24.6130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b06076ec-3eae-4d82-7233-08dec5f94027
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9715

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

This series is structured as a small refactor + detect + apply
sequence so that each step is reviewable in isolation:

 1/3 Pure refactor (no functional change): lift the existing
     force-sync conditions out of arm_smmu_cmdq_batch_add_cmd_p()
     into a new arm_smmu_cmdq_batch_force_sync() helper, so that
     adding another condition (in patch 3) is a one-liner.
     Authored by Nicolin Chen.

 2/3 Detect the erratum and provide the classifier. Adds the
     ARM_SMMU_OPT_REPEAT_TLBI_CFGI per-instance option, a global
     arm_smmu_erratum_repeat_tlbi_cfgi_key static key, and the
     arm_smmu_erratum_cmd_needs_repeating() predicate. The static
     key means the wrapper compiles to a single tested branch on
     unaffected kernels.

 3/3 Apply the workaround: factor arm_smmu_cmdq_issue_cmdlist()
     into a thin wrapper around __arm_smmu_cmdq_issue_cmdlist()
     that re-issues the cmdlist a second time when the predicate
     fires; register the same condition with the batch helper so
     full batches of CFGI/TLBI flush with sync=true; and add
     arm_vsmmu_can_batch_cmd() so iommufd does not mix command
     classes inside a single batch. Also documents the erratum
     in silicon-errata.rst.

The series applies cleanly on linux-next/master (base-commit below).

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
   an n > 0 check so we never inspect cmds[0] on the bare-SYNC
   flush emitted by arm_smmu_cmdq_batch_add_cmd_p() when the
   next command is unsupported by the batch's pre-selected
   cmdq.
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
  iommu/arm-smmu-v3: Detect Tegra264 erratum
  iommu/arm-smmu-v3: Issue CFGI/TLBI twice on Tegra264

Nicolin Chen (1):
  iommu/arm-smmu-v3: Factor out CMDQ batch force-sync conditions

 Documentation/arch/arm64/silicon-errata.rst   |  2 +
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 15 ++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 65 +++++++++++++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 24 +++++++
 4 files changed, 94 insertions(+), 12 deletions(-)


base-commit: 7da7f07112610a520567421dd2ffcb51beaefbcc
-- 
2.50.1

