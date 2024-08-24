Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69B180B
	for <iommu@lists.linux.dev>; Sat, 24 Aug 2024 00:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724458270; cv=fail; b=X7idkXC2rpmXDte/EDK1z346ReQHT+QsVuWSEVMnEaeq6Zr3WQ/fhegRk+Q/dVil+Ju28qHF4XcR7/xmm00XjhCDjbjnnhddmXPJvuVUMzFDyUHDPY1ymAONwzEI5yK9TwHbhX/fHdSIkheWIhBq+QDlRPxjqiG5+vdNm7vG3sU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724458270; c=relaxed/simple;
	bh=pwxy9JEJMM1Ol+xFDHipUT5EDbpzPP9f2b2Dh5y3AuI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=op3Tu93t4OAK5fdfxDGHWfl3uPfsapqSuEIFWMOOQXs2o7cvGTMPcC6fqfkJqxRy5HPQ1+jytWyyy6kFTBjoSBMzQRAp2sG1kD20p6MkTOfiZ8R6vqNMyLbtlU0lE3ZJfRi87UTCPRRrOmvB7GMAFvobcm5utLFOwu0ZTzk/a6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jVqpK0LF; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jVqpK0LF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPAoQefNPQ/QuE2HEaWAiN2WtZxuhpltSvGrg7IJC3fKUW3PCushfqkipce5ass313mvAx3SefcHyiwiWHNRKR+p+h9vVjSWYT3FdUkEjR6lF7NIJYDiVbGjNIIbnWm159h/TPO2MH+z2R8cA1W17ZhCL6GeBvCRfuwK1Jd4rZPu0lavtrX7W2y79dLYJIAn5f96b8Bp3IdJq2ZxTG0N6BuPS1attn8RA1WWc9dbm7XhrfKGz8o0GKPWdB1BK2bRq3OkBmql9hUjXV5Xnyo6lQ20t8VKRluwzYSMVJ09mbf+/z3GqvQpt/UjAPtWokzDBslkuohWET0FPllK7OBzHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aY6fh2MFt5hgzoQfbDXuDfJ6rJkTSoVCDuPW8XVeu6U=;
 b=G6I8Zkj7vc8UfqcviYTm7F2FP1J6jC3b3kp+rh5zqy64rJ90RkSSiwxdbhZa5yG9kU0sH3Q40MvN2fdF8VVEvJmewmEDT4WM4ac7xZ22qOnYfqqFauR9C9JxuN2+qbhCXkl6TJ2PGn7qty3lpRs/VEFvazK8QauBmM4pkDxvCAiNprTz/nlZYkJNxOHWnMIJCPjs4lvKuuA2xDa1J6fGG8KpwihUpguw+DOgzGwuskhc78DO6TTBqrzIMVfJqCLIkUNB9GEXawAofFR5eij8EE46Dsv88XW8S3/avOxGvA/dmGq/q9bbR7CMPW4WIFGXSn22stiygQsT9wTaSLJasQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aY6fh2MFt5hgzoQfbDXuDfJ6rJkTSoVCDuPW8XVeu6U=;
 b=jVqpK0LFfiJ1ivyTKxPbVKLUv4xmpN79fI4WyEpMI3oEFV1sdW8dlwAMDhHH8Ahk/MmdkBBHNlkuBbf3WuX5v96gbVMMEZCURm4y9uABSsp7Uymb6i1B2TIOmpUghM38VRSkpY599Gy5RZUGHuJXXtbdAtiPJZFXOYVfK48k7C4VKLvlGk8HIrbfyt4O1Dzguq4QqwT0g/DlvRCP/LbyrXO+hVqr/VqHa3ic6sl0UFxWVBd/0IzbaOh2dzxLM2gxfyinr94II+WXzp2pif9emmLpn7G2lIOpMOkfU5tJoqxhWlrlZHUS02+xRKuDFmxuOYGIlc2mSKVk6n92HsvdTw==
Received: from CH2PR18CA0044.namprd18.prod.outlook.com (2603:10b6:610:55::24)
 by PH7PR12MB5709.namprd12.prod.outlook.com (2603:10b6:510:1e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Sat, 24 Aug
 2024 00:11:03 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::1a) by CH2PR18CA0044.outlook.office365.com
 (2603:10b6:610:55::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.21 via Frontend
 Transport; Sat, 24 Aug 2024 00:11:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Sat, 24 Aug 2024 00:11:03 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 17:10:50 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 17:10:49 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 Aug 2024 17:10:49 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v13 02/10] iommu/arm-smmu-v3: Pass in cmdq pointer to arm_smmu_cmdq_build_sync_cmd
Date: Fri, 23 Aug 2024 17:10:36 -0700
Message-ID: <50bd0237e8399496955c2db2c8fde5bb0c564343.1724453781.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724453781.git.nicolinc@nvidia.com>
References: <cover.1724453781.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|PH7PR12MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: 29a31f22-d23f-44b5-b54c-08dcc3d13dd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+FPOAR+OsueeTd8ArfDAhorUvE2tZz9bo6JBWTQDoRE0BtoSzqND/yq4BjHC?=
 =?us-ascii?Q?FJE3/S+kTUDbKrEwkU12Xnno9hmUCvXejweFeaWQtxOv37Q2lQZKewyb+h9Z?=
 =?us-ascii?Q?IfYRi/pexh/HHLP63bOH5JUzwVIZoyLe/lketXvUDSAdGn6YAocG8lNxK/4O?=
 =?us-ascii?Q?myQd6UgHdVlvpZ/PoKOZzWDtbPmJvatQ5hrYXURgRITKjmmKaTd1NBsC0FYA?=
 =?us-ascii?Q?qcipsLS3vrFuZ+eThUB0dMm4VJ659LVFOYvCe1yF++ofg/Ao5+G/RzKLCpeH?=
 =?us-ascii?Q?9W92nzUxisdpz6JtBlZxJq60NJOeoXb5uAopzhmePG8dRmAHDPYPAxF8/wKE?=
 =?us-ascii?Q?8hldsw+qMALo+DDIsCJuyblAXlHFgkefjolTGkC66rGAA6J78aD5ctnG5fmO?=
 =?us-ascii?Q?l3QVXhhy+XAS9vxEljfMBflIZjgyPPwhoTar+2+iATT0jCASXPn3DeG0q8hf?=
 =?us-ascii?Q?sPTF5mWJ9ZlSYSfOnHl4BJatoiR5SL+uqhFyOHlS5r7CKNgrpaXFB1FDmpP5?=
 =?us-ascii?Q?QXh+sGJ+fJ+lH5KyGe3lES3BGjEjMA2kAc2n2c6qG8e4s/RjuhZBbRtwfUxe?=
 =?us-ascii?Q?JJRIvWxhcvBmKSEi/azodsnUrqP7xI1Ays+wZySLdpU2wiznmQCx7QxHEww4?=
 =?us-ascii?Q?sZT+HvqdKszah6UG8mY5JBCLQ8N8HMVnEUyemzm9iaSGVqThEFDnJC1skafw?=
 =?us-ascii?Q?1jzZackMLcaxmGjbwfzfLJ7Iz45IQQ/MA7YYWpCsUBu6Hk8+v0LAUZFIE7A5?=
 =?us-ascii?Q?krcSdT3IkhTlcuvwO5/HoYWBO6vofIQ7ixJcnkARfVr8JdTYlA9C/zl4jh7n?=
 =?us-ascii?Q?dOnDQhJRrhx8zEO/0csjBVubey+kyYt89GTkdeSDBo2rtNAzVQYBSvsQTPX1?=
 =?us-ascii?Q?Rmu6M+0+x9Phs9yA7LYlakrrADZBIxeBY7pL+ObDmcUfp45ap8HPEcqyU+/t?=
 =?us-ascii?Q?qDNDJ0lLk83PuMjIylM4OYhaUKmSjX9yZT79FITEmIIUBPUKsJE92O7vEBPq?=
 =?us-ascii?Q?vqEUuUTGKY+UBHjwic8Vrsj+9azu6Jjah1NjnuY9CVoJga4yd4BCSKW0q+VU?=
 =?us-ascii?Q?yhtMlmBS7YlzRG/gj94oTUe/Qt2eHkfvublqevWRrlwJUuj2w+us2038Nr1P?=
 =?us-ascii?Q?PJB9UVwiKY9VuCFjSqK/tkVrNrv0l8BXIwZ28i+GD0Z0F5xZjiFxsmBU8SCJ?=
 =?us-ascii?Q?5o8OMgMndjDuxz1hYMdVZK/VEzu2ibTq9Z/SbYyUnEsS6HDLpQXqrsCl0tvi?=
 =?us-ascii?Q?T2jj92FJeiP9UmJLVmWYQhIryMrLTL5pey6whfArT16q/Tb/30OMZIcNFJu+?=
 =?us-ascii?Q?9lRZIJ1fNyYiAz/jFHrUBWpcRic2CJnNNrC4pR7NkikOkejUTUF+bskhlvEG?=
 =?us-ascii?Q?xhB810kzE/6E/Lil2EhCnfaxy0RZaN3FHCWNYk0nvF9nsL7rayulza7/0RfS?=
 =?us-ascii?Q?WqWNTfBrWqU/Is/uhhqL5OvUOTxUwVV6?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2024 00:11:03.0874
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a31f22-d23f-44b5-b54c-08dcc3d13dd0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5709

The CMDQV extension on NVIDIA Tegra241 SoC only supports CS_NONE in the
CS field of CMD_SYNC, v.s. standard SMMU CMDQ. Pass in the cmdq pointer
directly, so the function can identify a different cmdq implementation.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ebd1a808a2cc..43ce8b9a517f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -352,8 +352,9 @@ static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
 }
 
 static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
-					 struct arm_smmu_queue *q, u32 prod)
+					 struct arm_smmu_cmdq *cmdq, u32 prod)
 {
+	struct arm_smmu_queue *q = &cmdq->q;
 	struct arm_smmu_cmdq_ent ent = {
 		.opcode = CMDQ_OP_CMD_SYNC,
 	};
@@ -371,7 +372,7 @@ static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
 }
 
 static void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
-				     struct arm_smmu_queue *q)
+				     struct arm_smmu_cmdq *cmdq)
 {
 	static const char * const cerror_str[] = {
 		[CMDQ_ERR_CERROR_NONE_IDX]	= "No error",
@@ -379,6 +380,7 @@ static void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
 		[CMDQ_ERR_CERROR_ABT_IDX]	= "Abort on command fetch",
 		[CMDQ_ERR_CERROR_ATC_INV_IDX]	= "ATC invalidate timeout",
 	};
+	struct arm_smmu_queue *q = &cmdq->q;
 
 	int i;
 	u64 cmd[CMDQ_ENT_DWORDS];
@@ -427,7 +429,7 @@ static void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
 
 static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
 {
-	__arm_smmu_cmdq_skip_err(smmu, &smmu->cmdq.q);
+	__arm_smmu_cmdq_skip_err(smmu, &smmu->cmdq);
 }
 
 /*
@@ -790,7 +792,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	arm_smmu_cmdq_write_entries(cmdq, cmds, llq.prod, n);
 	if (sync) {
 		prod = queue_inc_prod_n(&llq, n);
-		arm_smmu_cmdq_build_sync_cmd(cmd_sync, smmu, &cmdq->q, prod);
+		arm_smmu_cmdq_build_sync_cmd(cmd_sync, smmu, cmdq, prod);
 		queue_write(Q_ENT(&cmdq->q, prod), cmd_sync, CMDQ_ENT_DWORDS);
 
 		/*
-- 
2.43.0

