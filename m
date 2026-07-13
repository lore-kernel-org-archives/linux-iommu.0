Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011035.outbound.protection.outlook.com [40.107.208.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DBF38947F
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 11:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783941368; cv=fail; b=ikHDSr4sfQpdrXk7G/A1PqBg/SVrDLk4OA8WQa1m6l/eNc3OW0FMS5rkEObyjuFmqe5zBTwL1ofKfABtEGiQPCbxbFgz45olHoANP5w8pgm1f2UXXMpWTsDd8J7jCbdyXRxQ5NNKIt3vJ6gFbYMzz8NU1U6g6wPOz3I/ABejN70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783941368; c=relaxed/simple;
	bh=r+CmkB+Oph2MnvZ2Az1yYshjL4WkI7oyEOgFgOWQvzg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/SKBTorgfikgmrwislQk/WQfU0u6ZPABRH3iI62f1zj9ko123JGKhnFnw11lF2Oa+EFfIN6KyJkvQ9R7YBdQQx1qPL/g1FgxN/txc0+J9HCZ9gc0Gq5axZGj/LU2TVA7vPtsFDqyt3NRO8xWGd4ezulliEnen/mW/vmYiGYuc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wsnw32vF; arc=fail smtp.client-ip=40.107.208.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wsnw32vF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uaNOxn7yLaZHkLtvIFIz3USwEidSBsjcPRHtmkst3PlYFGrU4bRNaa+ytkqJtB/WIDqqXKiYRSeQHT1fD+F1OH93QLrKqfBG62P5tr5RzoSvmR9lmf0vUPYAtr3A2+BJakUwOF1Als/CyxnWCLDAxuLFBayDgTfzYo+fkCjFKKgD83BpcXKIDxdJsVOuOckcaHzRjRKxdBGavk8lPe8Apv8BsFgtI/RljpirmWm+lqH6HYGtuZRX8u3nX3yMnux47vvvgqT9zusIBrf2vnowH8oWhf1QjqhJlQSkreGt2HQTkn6SSimw6dFjWmBpow2lyeJ7Dv0OSlePO3fP/7XogA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGYP57qEvGSrXPuRDa4poOgepPcrrOCZjA6r91rDtSw=;
 b=uOPg+E7LcYpZIDlAhl3kSDi5pdwSiHjLfnC9tc/UVVH46rl4jEHCGGLAgu1za2FU/+VGH5CBDv1kfY5Psx8b5EJl2DeX22ArL94TxMvHCGtveYK9VuIsX5kFnFk92ENHMD1OOLTvLD5l5ginhlQXpZZMi2kQkOTozvT2PITXHfOW7i2L1mc7W9IKIE0xknbaghPeuZ/08UJeLHSlY5+b1qbgt85wigPF1wUP51iXZnPAY++Lokgv77h+Mv/X5mCaF4FIoe32QRSqK49wzko+qLPlKcKitzQEMhcKWIZQotKXU13URl3Y7JYZnOVqbUtvc6rW5HhYqHtRrXPf3j2MDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGYP57qEvGSrXPuRDa4poOgepPcrrOCZjA6r91rDtSw=;
 b=Wsnw32vFQ+oi1y4p44VsLhQHfjkcTBunlq5xpqHwwD40n0Gm6o+AWJIaCdocjlvXhBthQi26gMsp/Us6wMYBOlieqsvmzF/om9wAuDL8qQvYm3NVqYfCwjiTefMJBZpdRi0U4+rHEtWGGVHh4uNrUoIjgrTjIU9Bb9GDxUdSPwKKqiNAsERWeyYwP193WMW2rw7BtCl4/MhqjjnX3HB5DXz75wDPaPhOUy8VYO6zg8VdjZOcFTXWcCbG2cJduoZAAFoFV1gOiW8Sn63xiH3JYmSo07rtklN9kvoZRPqbop/kn/VLi39+C4hGOuDdF6CqAHhqRdJFhvPKzzi9tkjS9g==
Received: from BN9PR03CA0141.namprd03.prod.outlook.com (2603:10b6:408:fe::26)
 by CY5PR12MB6372.namprd12.prod.outlook.com (2603:10b6:930:e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 11:16:01 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:fe:cafe::63) by BN9PR03CA0141.outlook.office365.com
 (2603:10b6:408:fe::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 11:16:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 11:16:00 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 04:15:48 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 04:15:47 -0700
Received: from build-amhetre-focal-20250829.internal (10.127.8.12) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Mon, 13 Jul 2026 04:15:47 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<nicolinc@nvidia.com>, <jgg@ziepe.ca>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>, Ashish Mhetre <amhetre@nvidia.com>
Subject: [PATCH v6 2/3] iommu/arm-smmu-v3: Introduce CFGI/TLBI-repeat workaround infrastructure
Date: Mon, 13 Jul 2026 11:15:41 +0000
Message-ID: <20260713111543.1462161-3-amhetre@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260713111543.1462161-1-amhetre@nvidia.com>
References: <20260713111543.1462161-1-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|CY5PR12MB6372:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b3fe5ff-fa2a-4fd3-a750-08dee0d01ef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|7416014|376014|36860700016|1800799024|3023799007|6133799003|18002099003|22082099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	FO4GDTSvXmpIFd21KldAcOMXKqwkMVy2BPa2xEKs2SU1quW7Oy/7wntMrvbQaVyqXD0wgMPT0ceOZ178FD5sZCjscAisFThacV9aulFTEse0ccYNrXgOI9tCdKY6k7TrB3ErcmNSjZAhsEPJ8xU25khp4rei4csKXjUwtXruRiwHgFr5dOhfuDWt54Dghp5+0wsHA5Niy0pJTz8e3tMbhXDncIYjwNdWCr5kt5G1cfG4gCYzZc3mz9q0scc0eVkmyJFCy+4fs/rwwaH9TGRLeIwSPMSK2ETQVKa7AJYRIhjU15KZxtgVpQViBcqTn4VX59d5OZFjPcR3FHaKOyJX6ukZdOlTdhDKlLsuzD3A3GKdz/01YvvDNtZ+74mbpScSPHR7vL0/lyiRE/u8PFqab6KilkDHxPQ8696sR205cSJLR08fPAGD1tafFb6908E2AscuyNBOInIGTjAWoDJ8s5iuT1hCXQUqbN60CzIAXD9S1r3sJd+dhPg/+/xGGq+tXmdkL80IiQCSf7shmSVz0PcLA4fjUDT9JEdxNz1XHCy60goCWQ0+2yVXIcRebHMJ/MOPV1PhDvFQDWvBgva2z+LA7u8aguVSQEPkM/KLlPd6o4AKDfVL2AxxGUmakXSd4rXaZ6NbzyYSd6UyJ5jiDVnELJ6vsZJ18LtCxMcElJdcY3hSM41akfdPjBXxDbaA46zFujCpYAwGCXQCQsbbmg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(7416014)(376014)(36860700016)(1800799024)(3023799007)(6133799003)(18002099003)(22082099003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MEtFDCsIZkLElvL2sQZ/kzOVwB9XH8+M99zepsi23pHFW0DwliYEBx6ykoyndkMh4ENQtKnFP4fXM9W1hNz0xp/H9KnN39kRajANN3lsbhN/qDziYImKJUNqCOreflWAeLlVgiDIxw7WPgi15XullemK//H9xcJOu1Pkb9SK5UhyreJvsWkidqDBU5QzRrgCHweBVx+22tkgIFgawUtfHQ81UihcVy/yLMN8OtQ+5cRRXIQUb5JVztEl/5EQHVDiX4cEpQCLrHusdxvKpmeeK60KMFdMGM6oWlUQFONzdjQGyiG5LtUZM7xzlvYIPwqu+3cxwT2yxc5c40uKAMBH4ujCRQ8jDmdWNDgv2VcsiPoylP7rjibTGij88T+GctGg/J+oK6tvoPOsxfSx9NIAbF2RbswTUB/k5K3a+5U5Bz3+bhdWxGsMmttKLzq1ZYGE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 11:16:00.8211
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3fe5ff-fa2a-4fd3-a750-08dee0d01ef2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6372

Tegra264 SMMU instances need every CFGI/TLBI command sequence issued
twice, with the second issue executing only after the first issue's
CMD_SYNC has completed:

    TLBI/CFGI ... CMD_SYNC TLBI/CFGI ... CMD_SYNC

ATC_INV is not affected and must never be doubled.

Add arm_smmu_erratum_repeat_tlbi_cfgi_key and an
arm_smmu_erratum_cmd_needs_repeating() helper that gates on the static
key first and then range-checks the opcode (CFGI_STE .. ATC_INV), so
subsequent changes wiring the workaround into the CMDQ submission and
iommufd batching paths can share a single predicate.

Rename the existing arm_smmu_cmdq_issue_cmdlist() to
__arm_smmu_cmdq_issue_cmdlist() and add a thin wrapper that re-issues
the same cmdlist a second time when the predicate fires. Register the
new condition with arm_smmu_cmdq_batch_force_sync() and add
arm_vsmmu_can_batch_cmd() so iommufd batches split at every "needs
repeating" transition.

No callers enable the static key yet, so there is no functional change.
A subsequent change will enable the key on affected instances.

Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 15 +++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 53 +++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  1 +
 3 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 1e9f7d2de344..e8061c14c391 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -350,6 +350,18 @@ static int arm_vsmmu_convert_user_cmd(struct arm_vsmmu *vsmmu,
 	return 0;
 }
 
+static bool arm_vsmmu_can_batch_cmd(struct arm_smmu_device *smmu,
+				    struct arm_vsmmu_invalidation_cmd *last,
+				    struct arm_vsmmu_invalidation_cmd *next)
+{
+	struct arm_smmu_cmd next_cmd = {
+		.data[0] = le64_to_cpu(next->ucmd.cmd[0]),
+	};
+
+	return arm_smmu_erratum_cmd_needs_repeating(&last->cmd) ==
+	       arm_smmu_erratum_cmd_needs_repeating(&next_cmd);
+}
+
 int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
 			       struct iommu_user_data_array *array)
 {
@@ -382,7 +394,8 @@ int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
 
 		/* FIXME work in blocks of CMDQ_BATCH_ENTRIES and copy each block? */
 		cur++;
-		if (cur != end && (cur - last) != CMDQ_BATCH_ENTRIES - 1)
+		if (cur != end && (cur - last) != CMDQ_BATCH_ENTRIES - 1 &&
+		    arm_vsmmu_can_batch_cmd(smmu, last, cur))
 			continue;
 
 		/* FIXME always uses the main cmdq rather than trying to group by type */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index dd7475c50afc..eb8374cfce2a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -42,6 +42,14 @@ MODULE_PARM_DESC(disable_msipolling,
 static const struct iommu_ops arm_smmu_ops;
 static struct iommu_dirty_ops arm_smmu_dirty_ops;
 
+/*
+ * Repeat every {CFGI,TLBI};CMD_SYNC command sequence so that the second
+ * issue executes only after the first issue's CMD_SYNC has completed.
+ * Does not apply to ATC_INV. The key is global and is enabled from DT
+ * probe on affected hardware (currently Tegra264 only).
+ */
+static DEFINE_STATIC_KEY_FALSE(arm_smmu_erratum_repeat_tlbi_cfgi_key);
+
 enum arm_smmu_msi_index {
 	EVTQ_MSI_INDEX,
 	GERROR_MSI_INDEX,
@@ -698,10 +706,10 @@ static void arm_smmu_cmdq_write_entries(struct arm_smmu_cmdq *cmdq,
  *   insert their own list of commands then all of the commands from one
  *   CPU will appear before any of the commands from the other CPU.
  */
-int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
-				struct arm_smmu_cmdq *cmdq,
-				struct arm_smmu_cmd *cmds, int n,
-				bool sync)
+static int __arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
+					 struct arm_smmu_cmdq *cmdq,
+					 struct arm_smmu_cmd *cmds, int n,
+					 bool sync)
 {
 	struct arm_smmu_cmd cmd_sync;
 	u32 prod;
@@ -820,6 +828,38 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	return ret;
 }
 
+bool arm_smmu_erratum_cmd_needs_repeating(struct arm_smmu_cmd *cmd)
+{
+	u8 opcode;
+
+	if (!static_branch_unlikely(&arm_smmu_erratum_repeat_tlbi_cfgi_key))
+		return false;
+
+	opcode = FIELD_GET(CMDQ_0_OP, cmd->data[0]);
+	return opcode >= CMDQ_OP_CFGI_STE && opcode < CMDQ_OP_ATC_INV;
+}
+
+int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
+				struct arm_smmu_cmdq *cmdq,
+				struct arm_smmu_cmd *cmds, int n,
+				bool sync)
+{
+	int ret = __arm_smmu_cmdq_issue_cmdlist(smmu, cmdq, cmds, n, sync);
+
+	/*
+	 * A bare CMD_SYNC can be issued with n == 0 (e.g. an empty
+	 * batch_submit()), in which case there is no cmds[0] to inspect
+	 * and nothing to repeat.
+	 */
+	if (!n || ret || !sync)
+		return ret;
+
+	if (arm_smmu_erratum_cmd_needs_repeating(&cmds[0]))
+		ret = __arm_smmu_cmdq_issue_cmdlist(smmu, cmdq, cmds, n, sync);
+
+	return ret;
+}
+
 static int arm_smmu_cmdq_issue_cmd_p(struct arm_smmu_device *smmu,
 				     struct arm_smmu_cmd *cmd, bool sync)
 {
@@ -860,6 +900,11 @@ static bool arm_smmu_cmdq_batch_force_sync(struct arm_smmu_device *smmu,
 	    (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC))
 		return true;
 
+	/* See the description at arm_smmu_erratum_repeat_tlbi_cfgi_key */
+	if (cmds->num == CMDQ_BATCH_ENTRIES &&
+	    arm_smmu_erratum_cmd_needs_repeating(&cmds->cmds[0]))
+		return true;
+
 	return false;
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index c909c9a88538..e175dedf7c77 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1211,6 +1211,7 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 				struct arm_smmu_cmdq *cmdq,
 				struct arm_smmu_cmd *cmds, int n,
 				bool sync);
+bool arm_smmu_erratum_cmd_needs_repeating(struct arm_smmu_cmd *cmd);
 
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
-- 
2.50.1

