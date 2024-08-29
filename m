Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5107418B479
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 22:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724970904; cv=fail; b=upiMYgFqrRzFhl6KJhDcFrQNFdImfQod+BuN5JPl1EVKI1wnQUmQYLlI2Lswc9Q9g3mDgZ+H2gS/OxsH3dmgKdDJuXiJZgN77cEIZynoFqZqeBUUssY0cok8BUZp8XEddSmvyiBnswL8YIn3cx/ALGLBbHTwTTRwxp0H92KwlYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724970904; c=relaxed/simple;
	bh=o/EcfsjWFUlXT/o/lh0Cyc+dvKhr+IxeC+BO2iTW3Sk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SIWpjYfznyTrtwyST/BhQOa6hM5xdnUatyzyi1ryP9vEhh4NxSJRmRq7d9RlZ3R5cDNBnDrtLWnvD4m9TV95IcuEcBEPaGbzACs2jkLyhlHNclMjiauLvYDO/Sutf0XTmQE1De0oN3VQezZxEMKknTwXdapFZAZqNJZpvTuxaRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a11aW5UJ; arc=fail smtp.client-ip=40.107.94.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a11aW5UJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZwLhkfwDgBTbQEzqTXJnZqpb6qng4B52E+hMdXTYY1lfzZeX6jOalczowi7KURcQSmmq5njvFw+BZ+5dh99EQrsmmVjwIprYXEmL+LS+pqaxFJobv+YwSCkhXSaNWDZ0epdTcBb+FvNToAvY20KiTIm1F+AhxjHdQ7/TodCXO5/5mx53CB5geOSfBVtdoaP/kBNo4wcXazQVh5Y+9PA+T2G9XIYNMQn9Yc1tXrtnTkTTbjriFAz153NiRfSqcKAFlasVnS3RQUbGLNB/lG7wa0fih0pUrXtO6PsUrZkvX1EmbC0/Yp1oNm9Bjyo2VArXdKzJDibQ2hhhFX5qmgKLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAsUJurRKJM5zVPOr/GLTeJvugn2Owx6yCpCqhMYtAY=;
 b=fNLyG9nBby4K+4ABmKnFdiMgMDOu3XCSrnxy7/1bV413fCcBahbqz4R8RdUnX2K4XH08HNKCMMk2GdJB7R+/8HPxEKU+8Rx3jJUEIzwuiS2jaZ3N8HxjSEHWJZ5Zs/akOjbCafpi7jqqaWhFnYVo8FlfyUa5FDo7pp/dagc77GwSbSMm9eLUDHRrP8BwDA1k3ir8+Z6tVy2YqxHIJXiEDjmDyW1FeZx+cuJSNA99ijhG3cLF0eeJ0bjcyT0sY3BKnSAU/Je1rgpd149Byr9x/8x0OI6XX3cV2D0XI5dm6Rgn44nGrLAKEwmSmu4O3dV7PJFA+2J3j4wEjGmj0AxWMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAsUJurRKJM5zVPOr/GLTeJvugn2Owx6yCpCqhMYtAY=;
 b=a11aW5UJitJy6Rptl5InjjzVYmaTMd0pqSF270FnyHdwtcEJDJ8lcV9JYTPUjF6gW0nDKd1fL1wuPSqq9/wOS3yBE3uJWFUw+fjbG/+6r86hPALuFSy+WI5pEoU4uyAmmAMFpzRAGpxAbpnFxmrrfAefSfCQF5HedR/gtLc6Tf1v5iX19x4+44dsiL0ph6X/QrueyLuCNFZufHmILrWNJxb0Dy2ClQMPgweEhr8yVExFpyyIF5v12Xuy/RHRNbkXZc0LW/zjEoiCGaX6B3jNp3yG6XxVHNsyEoJObexu31DS/pcxBkobpINkmjFPv4OzKBZx35fA7aonnOMeIn+nyA==
Received: from CH2PR12CA0025.namprd12.prod.outlook.com (2603:10b6:610:57::35)
 by SJ0PR12MB6855.namprd12.prod.outlook.com (2603:10b6:a03:47e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 22:34:58 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::e8) by CH2PR12CA0025.outlook.office365.com
 (2603:10b6:610:57::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20 via Frontend
 Transport; Thu, 29 Aug 2024 22:34:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 22:34:57 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 29 Aug
 2024 15:34:45 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 29 Aug
 2024 15:34:45 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 29 Aug 2024 15:34:44 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v14 02/10] iommu/arm-smmu-v3: Pass in cmdq pointer to arm_smmu_cmdq_build_sync_cmd
Date: Thu, 29 Aug 2024 15:34:31 -0700
Message-ID: <723288287997b6dfbcd2a904d2c11e9b23f82250.1724970714.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724970714.git.nicolinc@nvidia.com>
References: <cover.1724970714.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|SJ0PR12MB6855:EE_
X-MS-Office365-Filtering-Correlation-Id: 08c2b92b-2979-4e1a-98bc-08dcc87acfd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?movTb436d7+mTRd6erde10Ob0fE9VjFFRA3kX2uZc7WnZNSaN+kNcpWqzpB1?=
 =?us-ascii?Q?C2oGgy9FKYj/F3vE6zlzTYfegI8ieG1Vv3wLjCYrH1fKpEjOoGszT2A8oLBH?=
 =?us-ascii?Q?6Cw92/p/lwvHRcV1iHf2VvJyyjlb0pxL4JdsvwL47zI8hiYR/bGMn/CcoshR?=
 =?us-ascii?Q?BcgQ2vfSLizZCPnf8pBGG+rwP6ya2tOgwcfNAj7yJpngfMfY+77Xfe7t8LIK?=
 =?us-ascii?Q?1MsaE37bKQQXNusAoFelc7GaQeMdtuuHpMHmJzIMLpSRzWaZqiDUpPHN6Nr+?=
 =?us-ascii?Q?kAfJSEkrRxeyEAXO7LzSuwUsz6vJQtvcC8kWEzFU/MKvd4q8keoW7FGeXDLY?=
 =?us-ascii?Q?XwzBcqeGgLV4yPRubElnL10iZWVuXa+VlH6kP8DGWBnmtS6ouTYccIcz6PHX?=
 =?us-ascii?Q?ZL/SL5pON1sazl40gBEAs1QAENuexrbjI+cxLZn45SSNs7ArK5IeUAU9dxUC?=
 =?us-ascii?Q?2+0gjuUX5nSLdqcHJPpiUpkeo4A60t92WDEzF544g3mwt9WVx44YJqgA1Ng4?=
 =?us-ascii?Q?/b9fS8T+v7SYsMt2jbhDlydfRYX+TfNoud4eQWd2rlxRPLRS7kYLFcmoJYAt?=
 =?us-ascii?Q?1EjUtBUI5RB7U/4yWiunXejv7+yvgIqvEp530YSoKKouhsvxTN9B6MCYvYuk?=
 =?us-ascii?Q?QOgJ8yY7Y/u7p/O5mxqGcAkPdsXM7QuDMLbpWEzc3XnEz0zFu6vl9WR7UfIR?=
 =?us-ascii?Q?YjtPWbTVR8JHzH34Z2MHkP5p8Ey8QNO7LAwvDCNXV6pZba6XwtfUtYV5JDSe?=
 =?us-ascii?Q?d21awjsr497Hc8K38li4gD3yWVlE3yMDpil5TjScp0599QahTa5YIeY074JZ?=
 =?us-ascii?Q?jLzmInuCAYLvs4eWBMgE7BnR+DKS8XSZml8f2Zfugjtq6fsXtWK9NZ0dVLPR?=
 =?us-ascii?Q?6W8UxY0+UQsRMX3mqd3Z+sk8Bp6ij4RKmNUe8MCbRD+w5BN/t0xAfAOVkqmP?=
 =?us-ascii?Q?7Rol7yIXRskDG8EgKV9njJcho0eark3+yM+PPsomNa4YnpC7ols/Bv4GVi12?=
 =?us-ascii?Q?T4l94qHzFi7jA1dLFzIHL8FqxUlTmn7jtGYz0BEgK8NtgJ3wKSveDs3KvSQC?=
 =?us-ascii?Q?MGhcNth3fGuACnQ+P+k2ZL6nReAiil++M3AEXPW+2Hjn9GT9b3lU6Dl2PEpC?=
 =?us-ascii?Q?YMB3EsTvZWDeFhMF0ybYccMln18Gg/MQiyIfZV9AWawGumnK+pYiwNOL/Mkc?=
 =?us-ascii?Q?48gUa6/m90VhXlJ457PArAIYGGfz6bhzs8z4QRFs++GeDFOajKZFMnVf+lgp?=
 =?us-ascii?Q?3/P5arDSb/4lz+E9tc82a+EFefmInD5QhBiYDFEG5ibBOAyz6Nkrq4TeGp9Y?=
 =?us-ascii?Q?NFb8BPdoh8Pkl7smUsNPgT5Npe908JYthtu6EatoDZlO/2vQKKQZ/Fw09GLK?=
 =?us-ascii?Q?7z7uzI3voo/uMAYSveJJNLI11/FCDHtRdz82wQLmRbWO7yru/GYWvo5sgpC3?=
 =?us-ascii?Q?d9fOOKAPg2TfHLS+RnYMo+nhP/ZZxibP?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 22:34:57.6521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c2b92b-2979-4e1a-98bc-08dcc87acfd3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6855

The CMDQV extension on NVIDIA Tegra241 SoC only supports CS_NONE in the
CS field of CMD_SYNC, v.s. standard SMMU CMDQ. Pass in the cmdq pointer
directly, so the function can identify a different cmdq implementation.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 7213ec538887..4a28cd2dc47a 100644
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

