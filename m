Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013050.outbound.protection.outlook.com [40.93.201.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D9E3DE420
	for <iommu@lists.linux.dev>; Tue,  9 Jun 2026 07:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780990354; cv=fail; b=o49Pj6wQBrOKUohfJU17sUEyhhcc9t8Owb1ibZxrjHM7w9eHLDa8G9K3HxkphCPY/ojZ/WnuDIws8fwdu/nwu9xXEFlee6xsIT9F14dXuLbDchr6jf9vAGKPP5ZBev6A9yvcAz7GFLeFS/D26z8i2lmd67q8o3nWNHgfyNV5mc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780990354; c=relaxed/simple;
	bh=nstEDKDJeZpY50n8TBgy3fAtviCOXofp7+s3EqlLgw4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QvM6TkZMgwZqATEjR8WIvziQa4iFw9XkHCxSmpULdO5Go2kxCdpclZdiUE5ccR8wJCBuWz2iBbja6tGw42kWiTaziyjqKmNzqEBLkqM03+OUFLwsuQKev52/NtO/b4GGI7d3aBp92UGh/4JmZ1NBqvP2983y9LpSSyo7bK0GAX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jD/S5Fiu; arc=fail smtp.client-ip=40.93.201.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jD/S5Fiu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MA69uYuBQJf25VLf22dMMvXgPPrK0DS/QOeGXeuNCv8f5HakjXZhiXzizdwqV5khEeVq8D9cVSzCrBqdLk2sQgAXjvK8/twDbW9XgLgkL1d7U/4v7tID7TSGLp4EzrYF/jsH9a3M1tJ0pN69GBuTGFfnzKplcocTS8kaJUfE91z6BRQmyazKjCEwn/s3JAR0ABFG7EXTCXwBW6w2/98xtyM2eju/pxR4c0xIhw2IyCV82MM1JLa2gWPgC39eYMKuhBw92bG+FagJpu9VTM8r1qYYW+UjDtWBaY/a481zXuperG9T0XKJA+vDEVLwIQZzCSX8zs6o/Wi2t44f7n6TQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RMEKfOOXWABl/OB7w9sMWEc09wb3jg+KsxGPyobtO0=;
 b=fVBuZb75SwW/3sbmwCXqpgSP3x6raac4Vm3Ed7XWcPpzQlQ369DeyBwY/bYWDvxJ3012UDnQ9UYxVJGDouXUMMYJ66nOghArK/lSA92Wneyw515wA7kN+IPREITszikySU1yydk37Bl3e4HJc8XwQz8nz3zFEDoPKf9aDv2Iyi7s09yslQfp8ViGyZc2VYIzu2TVVYMgFXVe21srRsBbozwBWe8FEpaDa34nLf1a5owbC3PHg4Jr6hPiFnO8U1a3KjAUdIZak6q+jqIglf9gdRvLwwK/XaI3fHtRUvEjyUWXLSaEOBry8haJT7w9nffXkifqFRbDU5CG3RA7pKQbWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RMEKfOOXWABl/OB7w9sMWEc09wb3jg+KsxGPyobtO0=;
 b=jD/S5FiuC2s8ys4UeQuc7Zon8DqJQES98i/zWDW9jE8IIKoDdc5t8zd6eXFdGH7+q9h3eHNOI9PsUC6ZFl6u4ztswty2ZPqx+K/IekCJ/LpoHnCC774RGSEyfFYNxubLwQYcDrNt+gST8Hcv2KhxZJJCT7I2EdTrHXnoL9O9CZdB7osVcjRGSRhD986BSWf6Sc4icSg71CFaK98lzVIOuhjbyFqRPWnN8Dm2HShxgcIn0+VgB1NbktEObZ88iUuUAUaWSxq0IQ3jvRt9G7Ukrc6FlATVg2UuQv/TOfOPc3mcQxVtvSrxZfCnfOd+7LUZ+Px9yEfUrXDKl9YRY22qOw==
Received: from MW4PR03CA0340.namprd03.prod.outlook.com (2603:10b6:303:dc::15)
 by MN0PR12MB6126.namprd12.prod.outlook.com (2603:10b6:208:3c6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 07:32:27 +0000
Received: from CO1PEPF00012E62.namprd05.prod.outlook.com
 (2603:10b6:303:dc:cafe::5d) by MW4PR03CA0340.outlook.office365.com
 (2603:10b6:303:dc::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 07:32:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00012E62.mail.protection.outlook.com (10.167.249.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 07:32:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 00:32:11 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 00:32:10 -0700
Received: from build-amhetre-focal-20250829.internal (10.127.8.12) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Tue, 9 Jun 2026 00:32:10 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@ziepe.ca>, <nicolinc@nvidia.com>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH v4 3/3] iommu/arm-smmu-v3: Issue CFGI/TLBI twice on Tegra264
Date: Tue, 9 Jun 2026 07:32:04 +0000
Message-ID: <20260609073204.1760077-4-amhetre@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260609073204.1760077-1-amhetre@nvidia.com>
References: <20260609073204.1760077-1-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E62:EE_|MN0PR12MB6126:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d300576-e725-48ef-2c26-08dec5f9412a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|56012099006|3023799007|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KIfxrWO0oNPthpQ3QmzVVNa1XWfiZsxv9+8LglFPyDRmZY0X3WeAOXe5YjX78U9ZCiyhPemUEuY6XxzZntHT9yi3X2X6vH9PwXImA4ccTS0/jYZgBCkFLWeI2Dza4uJRtM3vPyJu5wnwxKx7JjtYE2+hlCUBkay++3m81dHvVkzITb839NnVDeyPtYXg9ynuNVdnZ0Xd8OLch2iwGRG/3G2APyT6YjUAYxYDuhhzdXs0TpQj9Y1pzj1FSyHigLw3Cw5fwU11DvcljL92dGrPJ1YDHT0qcZykPDMUI68C2SwV7i8HysiEH0HAbhfCBQjLJslRAx0WD7Dxkm9ocDp6J5M5Z3r4U7gYDnTDzNKmg9JpZgNfYqX9aUBt4DmEbm8y/8NUqeMMMfZ7ccl0xeJNoPBtcO3jt+3ZnsGQUe93fRr0bD4eS56ujRFq81p/AHiZFqYKgQw+2ZR2Mptz696A7ROHyy7Zv/h3PnpUzB8jw0iM/z3Yut1eNLPYtWXZ2AdjAl33zMs7vvDAa0CWyGRrR/3hqQA6yucJvRx72IKwZilrX4m5ZlnY4myyEi4dzgSoJ8JlqsauEv88ANoe6GzpbL4fSRBNUAr2ESDR3VVUGQuQVu1ERd56u0zUny+YXEskSl73JYxDgVCKsWskGUB24hCUAmF2ZDn/2FQFhrBdA9YJ5O2xAMGm//I51CPsHa2tely+uaKUoNKQNsYhiQK+n015RDGcgSjWk1gfqP9cFNQ=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099006)(3023799007)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	v83q4IXRw0MRbfqWBGMdPKCHHyE2Dc3KlufYeWeGEBfRkZq5xRGYOmMVUe6Dzz2+MChqI0YvOvCyBghGE5JA/Ymx2FGOW8T2Xte0AOmCh8gpF2kgB3vOx7qFLE12YiA4c54SVJSp9AnFwUhQ/Y8uoma/rpA+s4jlqubFCOveq2dMWzAkry/yBjDmmiZK+ShI2og1Fyp+uno5q5Hs6dFd+NZwBEir6GPyFX5CQRE2DRb6lC2zBqBV6P1XdGvMLVgPMOyLPIluTE382bPFOoCSx7lrV2Vmbt10WdJBeajVNSTOtTv6eGqYOaLFKQQt4rskWM11R7QeIgGwGEu0wmeaqKowOxhRGJq17UWCObt7GLd30j9qa+VcmV43lEdtyYiN3keBRue6I8LFpuXE7E+/spJdLrahxiCv4ytCEJEakhyxuCfcQ/QgC8ovCUZWtaen
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:32:26.3084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d300576-e725-48ef-2c26-08dec5f9412a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E62.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6126

Apply the workaround for Tegra264 erratum ARM_SMMU_OPT_REPEAT_TLBI_CFGI
by issuing every CFGI/TLBI cmdlist twice on affected SMMU instances,
with CMD_SYNC after each. The erratum requires this exact sequencing:

    TLBI/CFGI ... CMD_SYNC TLBI/CFGI ... CMD_SYNC

Rename the existing arm_smmu_cmdq_issue_cmdlist() to
__arm_smmu_cmdq_issue_cmdlist() and add a thin wrapper that, on
affected SMMUs and when @sync is true with @n > 0, re-issues the
same cmdlist a second time when arm_smmu_erratum_cmd_needs_repeating()
is true. The @n > 0 gate is needed because arm_smmu_cmdq_batch_add_cmd_p()
can call arm_smmu_cmdq_issue_cmdlist() with @n == 0 and @sync == true
to flush a bare CMD_SYNC when the next command is not supported by
the batch's pre-selected cmdq; the repeat path must not inspect
cmds[0] in that case. The static-key gate inside the predicate means
the wrapper compiles to a single tested branch on unaffected kernels.

For the in-tree batching path, register the new condition with
arm_smmu_cmdq_batch_force_sync() so that a full batch carrying
CFGI/TLBI commands flushes with sync=true.

For the iommufd VSMMU path add an arm_vsmmu_can_batch_cmd() predicate
that splits the iommufd batch at every "needs repeating" transition,
so the wrapper's per-batch decision based on the first command stays
correct even when userspace mixes opcode classes.

Also document the erratum in Documentation/arch/arm64/silicon-errata.rst.

Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 Documentation/arch/arm64/silicon-errata.rst   |  2 ++
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 15 +++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 35 ++++++++++++++++---
 3 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index 046a7fa47063..96050886a7d6 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -268,6 +268,8 @@ stable kernels.
 |                |                 | T241-MPAM-4,    |                             |
 |                |                 | T241-MPAM-6     |                             |
 +----------------+-----------------+-----------------+-----------------------------+
+| NVIDIA         | T264 SMMU       | T264-SMMU-3     | N/A                         |
++----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585         |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 1e9f7d2de344..11d22acae613 100644
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
+	return arm_smmu_erratum_cmd_needs_repeating(smmu, &last->cmd) ==
+	       arm_smmu_erratum_cmd_needs_repeating(smmu, &next_cmd);
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
index 599c835c50d8..041e188b3b30 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -700,10 +700,10 @@ static void arm_smmu_cmdq_write_entries(struct arm_smmu_cmdq *cmdq,
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
@@ -822,6 +822,28 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	return ret;
 }
 
+int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
+				struct arm_smmu_cmdq *cmdq,
+				struct arm_smmu_cmd *cmds, int n,
+				bool sync)
+{
+	int ret = __arm_smmu_cmdq_issue_cmdlist(smmu, cmdq, cmds, n, sync);
+
+	/*
+	 * arm_smmu_cmdq_batch_add_cmd_p() can flush its current batch with
+	 * sync=true and n=0 (bare SYNC) when the next command is not
+	 * supported by the batch's pre-selected cmdq, so the repeat path
+	 * must not inspect cmds[0].
+	 */
+	if (!n || ret || !sync)
+		return ret;
+
+	if (arm_smmu_erratum_cmd_needs_repeating(smmu, &cmds[0]))
+		ret = __arm_smmu_cmdq_issue_cmdlist(smmu, cmdq, cmds, n, sync);
+
+	return ret;
+}
+
 static int arm_smmu_cmdq_issue_cmd_p(struct arm_smmu_device *smmu,
 				     struct arm_smmu_cmd *cmd, bool sync)
 {
@@ -862,6 +884,11 @@ static bool arm_smmu_cmdq_batch_force_sync(struct arm_smmu_device *smmu,
 	    (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC))
 		return true;
 
+	/* See ARM_SMMU_OPT_REPEAT_TLBI_CFGI */
+	if (cmds->num == CMDQ_BATCH_ENTRIES &&
+	    arm_smmu_erratum_cmd_needs_repeating(smmu, &cmds->cmds[0]))
+		return true;
+
 	return false;
 }
 
-- 
2.50.1

