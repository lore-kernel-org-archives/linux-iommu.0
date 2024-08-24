Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A221A1388
	for <iommu@lists.linux.dev>; Sat, 24 Aug 2024 00:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724458271; cv=fail; b=dqtDHuKHkAk81McmnkPmWn0en54kOiRbuzNrgbnCNY595RJFs4IxlIO02a7oxr6DIs3hmeH9JXSeMvrmFkZBSADIFiiWqMza3QXN6dfcj69ze8aS9ztESdstgcWdZNVNkS5LYXFdKTokeqJ/r9YmEoKAloRAB/bf4ETI4KPYJY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724458271; c=relaxed/simple;
	bh=xfiwzhbrMrmol9Yb9U86QnNR7gS++TH52gJE+0IsvPw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A77vkdhB6kIG6I78Y3YjKeNJYRvnKrYSESonkWPtWDGTY7W80xSpObQBSRYK5H6WWML4W/1YEHktijc15MR9XmnjuxRkcRzXlJmH7XcNrO5RxMhejRI/cj2itkOddWMbsciCJh0QZGQ+Zuwop81/d68AK7YWWjnc6fwokGVdDdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ANiR2uwU; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ANiR2uwU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tOS8Pto6VTKRKhAZnyLSSfPZd6/f4pCpJFvncC8Jk0wuLu8aU6ZjBgzM1jZDHetS95HbpfgzsukZUoQo+tdCotTSAkmepKSr4JjTucEEx9ldELoOeUGsmlrdrflVln/yzbakpb7+Kl9yVNjJy6k0rvxw6C3qBxUX+7j7NN6PU0Ivp5zM6dUpoSRL0YUWXc90bguBOAuOOMCB0Yogk+Y9J/6/HA8kiizAON2DAryCl8vpfzwzusC6OLKcmosPCRipQDHtaPvzpHiDfyXlaLf8ruCx1bHF6nGz2QP/3t06UMrf/vhYOggacIGaaeQ5LdOVnwU4ZjvcAXF3Qvp24ZQhAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdzFqrWZJ3PoxnxlBSeOu0QZNneQuA920UmoTnx9dPU=;
 b=C8W3sAtfTlUahyR/Bu19/1Hp8cWEfuBOGI97vQY9AQx+O5BQMZ3z/bNz+hzEGA5PY6L6WNFSQJVvWAfD4PxbAglvz83saVDK+rtsE8yJH6a7uZiKLYdmvT/yrkQ6TthEOeLl2WujebRmVbGcBUD/Uv1vq0dzBnr81TKtuNwnFtTjCynO3DvWG801UHhP8NhLgz7jC2uvGNlWqA81mgTHEM7CgcagSBZldGxNV/Bs33TSSUXLhtlhJYjv2a3NxohtWIk2PwrNIZZSnRpbRFJjT5SHZ/Qq1MW2GJjHpSm9/vnuvmRVcBx8sDFIlm8oBNuVGHRso8ltnDiaFJdETDA2eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdzFqrWZJ3PoxnxlBSeOu0QZNneQuA920UmoTnx9dPU=;
 b=ANiR2uwUmL9G/VdHHV/x+ITy0cTl/HRW/OpTWQlNQ+ULaaF+dShd+O5pHomTEwTjVyaosDYPsgx6vRbWWJYXMVQFu7TzGVi6PTEalgjolyLRgZSHAoz6YbQeWqS3orrjAQqWjPIpjX720OkTO+QXFnner5PPIfjrILYLZwR8DEeoYnZb2eMLj8g6s+pcASLrp8Rtp+c5X0K+r/5YxhAs/Fo7NH0+c/IPWWjnHoaFePkXelnFNJoTQbwOxLvQA4CWqqjMoo178BptGCclOPWngviPc3o8G2J0xshNMs2sPgReo3JKCgA7dmQ0fXc8aXgEMrS7TZ9lCfyvXJY1krPtRQ==
Received: from BYAPR07CA0085.namprd07.prod.outlook.com (2603:10b6:a03:12b::26)
 by CY5PR12MB6081.namprd12.prod.outlook.com (2603:10b6:930:2b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Sat, 24 Aug
 2024 00:11:04 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:a03:12b:cafe::2d) by BYAPR07CA0085.outlook.office365.com
 (2603:10b6:a03:12b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Sat, 24 Aug 2024 00:11:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Sat, 24 Aug 2024 00:11:04 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 17:10:49 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 17:10:48 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 Aug 2024 17:10:47 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v13 01/10] iommu/arm-smmu-v3: Issue a batch of commands to the same cmdq
Date: Fri, 23 Aug 2024 17:10:35 -0700
Message-ID: <5f149f299eafa4dace1fda56f0759e5805b3ed83.1724453781.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|CY5PR12MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 8854fc68-542f-4f66-5627-08dcc3d13e61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g9DL5WIdGkHAPY+OurXouEpZrYYL5vcQ8uL0dhC1+PcIQbKzVizz5y1uxjCj?=
 =?us-ascii?Q?qw8kj8Dlt/sUq2+svBfmEeSyKIGKrgeBtmAvROLerUSzH5akNA/sB7YkwxW4?=
 =?us-ascii?Q?LLSX7ed6nq7/oLLcotY8v2bhBlyXM7euikcZWw9a18KTP1x6YeGp4UaSkJTY?=
 =?us-ascii?Q?Aq9hG4RybLJstzXn2qSEy3aRKhtcNo0+ygCvaV27E3nrkcw5drH1eA7Zh8Wy?=
 =?us-ascii?Q?bnjiyzEHD1RNCoWkbTOxRJmrLpXfQ78/RiHAbgphFYrSUjbcLS7exVr0MBty?=
 =?us-ascii?Q?wqrDQ7SVdZdUgcu2JFn7E/UORHlwHXvoK/Z2x/XjKHnK/cndMVXD/5p6Pyei?=
 =?us-ascii?Q?p8XADyWZBF7XXGMu9vEtcBbeNePvv7ojwuTUOoLA105jtviacvMs+QURrHzc?=
 =?us-ascii?Q?HtNRQ6F31vq9UatGBn5M1M73TO2LEExIahklvWjs8aukf9h5LWD/vCaHLTNZ?=
 =?us-ascii?Q?LZ5wZQrC5qDCaaws1YTb/SwFwaroHT112tAEk6IYhVR46qSuBjTEogeqvTDs?=
 =?us-ascii?Q?cvROXsmmEEqgnL+rUiytDonbb8Dl/Ivt7Qn4lEDCW2i9RHFfWKozpTv/3Qvs?=
 =?us-ascii?Q?lsKOLi1h2fcvfOtf08pfoglO2JCL52Ew6Lxge+JDXcbSOMgFhx5PHCBi/aQn?=
 =?us-ascii?Q?+VaIP+L8Q4f7j515jg2MM0eUWYhoMRXYBOINlACC6WaKOWqWMGC4zVCqtGDs?=
 =?us-ascii?Q?nBw/5PQ0JGxiD5Yll5VuTl0PHvhj/NLjJwoqLrkCghPKmSd9r1grHZ8jvR9S?=
 =?us-ascii?Q?kEADzh7ht7IEFac5obJ9BTfgFiGU90/t5wtwPzvg7ByJw/7ObigIkwZbw9XW?=
 =?us-ascii?Q?xxKp0YbhC1OAgFKw9ixoXABX/Z+0nh3HVAftzoUhxXOtuA3rqfT0p0aDh/aE?=
 =?us-ascii?Q?rIh07bDO9U7EBXOk6GdFOIPUpE1R13yGgcUxEV8boTY5osgZDMh87MojSKFm?=
 =?us-ascii?Q?yVcGqIFcduKVAJQhF9ukbmhaNXvGB+xWZdWiHgCpj/AwxKxxkrNltljAv2cs?=
 =?us-ascii?Q?eUuE+YzVtKnTgZUo600IzCRgaqdkxn+24scdcoCKeVBWxudpwRW1vHYnRZwC?=
 =?us-ascii?Q?pigGPCccKkbzalrp+B9l7GROb6wg1TDdkxxIYA4CSIOMA+7vJIl4FSGAJXmX?=
 =?us-ascii?Q?uet3KWwg4+9qoRI4wmV4shAQ5GOedb9Jgx+6fOMsoj4WtRckYxzO7PI+aSLj?=
 =?us-ascii?Q?bSmmhx3Knv6OmB0QdeIbrk8vbHsMd8lPywIfDjoCFjXlLlpoSVUMjUENg5wF?=
 =?us-ascii?Q?DsyzygSLIeD9+X6Cp+23sMxSEYonnHWWTW7RnsOTUc5VoZeo7L6UGz2swill?=
 =?us-ascii?Q?nrdRjEfJkGiAAmcgGP3NICx7h561tgUOoLBV4wO+UPPT9X4WzzNfwnUXU/QU?=
 =?us-ascii?Q?yhpG7+TatcDEdlrrN1bbiy+LhK2TMELg7mXswec6W96SpAehuoJ+RM9KfjoG?=
 =?us-ascii?Q?CSO1+0uSTTbFmHEsYXa3UI63f2nNs8H4?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2024 00:11:04.0196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8854fc68-542f-4f66-5627-08dcc3d13e61
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6081

The driver calls in different places the arm_smmu_get_cmdq() helper, and
it's fine to do so since the helper always returns the single SMMU CMDQ.
However, with NVIDIA CMDQV extension or SMMU ECMDQ, there can be multiple
cmdqs in the system to select one from. And either case requires a batch
of commands to be issued to the same cmdq. Thus, a cmdq has to be decided
in the higher-level callers.

Add a cmdq pointer in arm_smmu_cmdq_batch structure, and decide the cmdq
when initializing the batch. Pass its pointer down to the bottom function.
Update __arm_smmu_cmdq_issue_cmd() accordingly for single command issuers.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 48 +++++++++++++--------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 2 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a31460f9f3d4..ebd1a808a2cc 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -592,11 +592,11 @@ static void arm_smmu_cmdq_poll_valid_map(struct arm_smmu_cmdq *cmdq,
 
 /* Wait for the command queue to become non-full */
 static int arm_smmu_cmdq_poll_until_not_full(struct arm_smmu_device *smmu,
+					     struct arm_smmu_cmdq *cmdq,
 					     struct arm_smmu_ll_queue *llq)
 {
 	unsigned long flags;
 	struct arm_smmu_queue_poll qp;
-	struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu);
 	int ret = 0;
 
 	/*
@@ -627,11 +627,11 @@ static int arm_smmu_cmdq_poll_until_not_full(struct arm_smmu_device *smmu,
  * Must be called with the cmdq lock held in some capacity.
  */
 static int __arm_smmu_cmdq_poll_until_msi(struct arm_smmu_device *smmu,
+					  struct arm_smmu_cmdq *cmdq,
 					  struct arm_smmu_ll_queue *llq)
 {
 	int ret = 0;
 	struct arm_smmu_queue_poll qp;
-	struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu);
 	u32 *cmd = (u32 *)(Q_ENT(&cmdq->q, llq->prod));
 
 	queue_poll_init(smmu, &qp);
@@ -651,10 +651,10 @@ static int __arm_smmu_cmdq_poll_until_msi(struct arm_smmu_device *smmu,
  * Must be called with the cmdq lock held in some capacity.
  */
 static int __arm_smmu_cmdq_poll_until_consumed(struct arm_smmu_device *smmu,
+					       struct arm_smmu_cmdq *cmdq,
 					       struct arm_smmu_ll_queue *llq)
 {
 	struct arm_smmu_queue_poll qp;
-	struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu);
 	u32 prod = llq->prod;
 	int ret = 0;
 
@@ -701,12 +701,13 @@ static int __arm_smmu_cmdq_poll_until_consumed(struct arm_smmu_device *smmu,
 }
 
 static int arm_smmu_cmdq_poll_until_sync(struct arm_smmu_device *smmu,
+					 struct arm_smmu_cmdq *cmdq,
 					 struct arm_smmu_ll_queue *llq)
 {
 	if (smmu->options & ARM_SMMU_OPT_MSIPOLL)
-		return __arm_smmu_cmdq_poll_until_msi(smmu, llq);
+		return __arm_smmu_cmdq_poll_until_msi(smmu, cmdq, llq);
 
-	return __arm_smmu_cmdq_poll_until_consumed(smmu, llq);
+	return __arm_smmu_cmdq_poll_until_consumed(smmu, cmdq, llq);
 }
 
 static void arm_smmu_cmdq_write_entries(struct arm_smmu_cmdq *cmdq, u64 *cmds,
@@ -743,13 +744,13 @@ static void arm_smmu_cmdq_write_entries(struct arm_smmu_cmdq *cmdq, u64 *cmds,
  *   CPU will appear before any of the commands from the other CPU.
  */
 static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
+				       struct arm_smmu_cmdq *cmdq,
 				       u64 *cmds, int n, bool sync)
 {
 	u64 cmd_sync[CMDQ_ENT_DWORDS];
 	u32 prod;
 	unsigned long flags;
 	bool owner;
-	struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu);
 	struct arm_smmu_ll_queue llq, head;
 	int ret = 0;
 
@@ -763,7 +764,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 
 		while (!queue_has_space(&llq, n + sync)) {
 			local_irq_restore(flags);
-			if (arm_smmu_cmdq_poll_until_not_full(smmu, &llq))
+			if (arm_smmu_cmdq_poll_until_not_full(smmu, cmdq, &llq))
 				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
 			local_irq_save(flags);
 		}
@@ -839,7 +840,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	/* 5. If we are inserting a CMD_SYNC, we must wait for it to complete */
 	if (sync) {
 		llq.prod = queue_inc_prod_n(&llq, n);
-		ret = arm_smmu_cmdq_poll_until_sync(smmu, &llq);
+		ret = arm_smmu_cmdq_poll_until_sync(smmu, cmdq, &llq);
 		if (ret) {
 			dev_err_ratelimited(smmu->dev,
 					    "CMD_SYNC timeout at 0x%08x [hwprod 0x%08x, hwcons 0x%08x]\n",
@@ -874,7 +875,8 @@ static int __arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
 		return -EINVAL;
 	}
 
-	return arm_smmu_cmdq_issue_cmdlist(smmu, cmd, 1, sync);
+	return arm_smmu_cmdq_issue_cmdlist(
+		smmu, arm_smmu_get_cmdq(smmu), cmd, 1, sync);
 }
 
 static int arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
@@ -889,6 +891,13 @@ static int arm_smmu_cmdq_issue_cmd_with_sync(struct arm_smmu_device *smmu,
 	return __arm_smmu_cmdq_issue_cmd(smmu, ent, true);
 }
 
+static void arm_smmu_cmdq_batch_init(struct arm_smmu_device *smmu,
+				     struct arm_smmu_cmdq_batch *cmds)
+{
+	cmds->num = 0;
+	cmds->cmdq = arm_smmu_get_cmdq(smmu);
+}
+
 static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
 				    struct arm_smmu_cmdq_batch *cmds,
 				    struct arm_smmu_cmdq_ent *cmd)
@@ -897,13 +906,15 @@ static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
 
 	if (cmds->num == CMDQ_BATCH_ENTRIES - 1 &&
 	    (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC)) {
-		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, true);
-		cmds->num = 0;
+		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
+					    cmds->num, true);
+		arm_smmu_cmdq_batch_init(smmu, cmds);
 	}
 
 	if (cmds->num == CMDQ_BATCH_ENTRIES) {
-		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, false);
-		cmds->num = 0;
+		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
+					    cmds->num, false);
+		arm_smmu_cmdq_batch_init(smmu, cmds);
 	}
 
 	index = cmds->num * CMDQ_ENT_DWORDS;
@@ -919,7 +930,8 @@ static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
 static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
 				      struct arm_smmu_cmdq_batch *cmds)
 {
-	return arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, true);
+	return arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
+					   cmds->num, true);
 }
 
 static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused,
@@ -1170,7 +1182,7 @@ static void arm_smmu_sync_cd(struct arm_smmu_master *master,
 		},
 	};
 
-	cmds.num = 0;
+	arm_smmu_cmdq_batch_init(smmu, &cmds);
 	for (i = 0; i < master->num_streams; i++) {
 		cmd.cfgi.sid = master->streams[i].id;
 		arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
@@ -2021,7 +2033,7 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
 
 	arm_smmu_atc_inv_to_cmd(ssid, 0, 0, &cmd);
 
-	cmds.num = 0;
+	arm_smmu_cmdq_batch_init(master->smmu, &cmds);
 	for (i = 0; i < master->num_streams; i++) {
 		cmd.atc.sid = master->streams[i].id;
 		arm_smmu_cmdq_batch_add(master->smmu, &cmds, &cmd);
@@ -2059,7 +2071,7 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 	if (!atomic_read(&smmu_domain->nr_ats_masters))
 		return 0;
 
-	cmds.num = 0;
+	arm_smmu_cmdq_batch_init(smmu_domain->smmu, &cmds);
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_for_each_entry(master_domain, &smmu_domain->devices,
@@ -2141,7 +2153,7 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 			num_pages++;
 	}
 
-	cmds.num = 0;
+	arm_smmu_cmdq_batch_init(smmu, &cmds);
 
 	while (iova < end) {
 		if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 14bca41a981b..c1454e9758c4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -570,6 +570,7 @@ struct arm_smmu_cmdq {
 
 struct arm_smmu_cmdq_batch {
 	u64				cmds[CMDQ_BATCH_ENTRIES * CMDQ_ENT_DWORDS];
+	struct arm_smmu_cmdq		*cmdq;
 	int				num;
 };
 
-- 
2.43.0

