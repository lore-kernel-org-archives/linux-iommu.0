Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3148F2BB0D
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 00:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723769764; cv=fail; b=d+ri+hNpRY6LhICKG8T2m3RvdxSKgj2Yehf6XDV/BekTQpRkWglWpoeqiDgl0CgEnweJsNc0tiadONicrCwGhsog5cigfMArqPx8WItXaIM3nLZDa8yXogM5iTg9159vnN1AP8KMJjuaEScxA4k1Y4kX5mCiUvyH3dwk/mAMHiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723769764; c=relaxed/simple;
	bh=oM4T3+/J8y2in2AFqLtrlN3CenDx5e712CjvISB+pAc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3W0o+wNSFdS2ahe4iTfXTvAhIKDmCsZ/hvf8cydcXusie5fE51JUArDDizUEjmA59vYzY02ZjVeC26jO9BD2T+zndXpWNqx6dVG6QLpbs71eIByoAMrjq2T1kIyPIbdQ4jE0cVWJvqSBTXsrd6tzoq1XcuK7+qUXjDIXQBC07A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ni2tPoJW; arc=fail smtp.client-ip=40.107.236.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ni2tPoJW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GcG0IZbuzy1JsDGTE4EJsbC8eMSiJeEaBBxwYxfxv8Djni5326jYzCPc/WXDSYpWjtr8fl1/vkNBg8MJqGfERVcUhilDgzvYrjHQbD+P3MbIX9Qe3pgyGFkm3Fi1qzx1FywSjmEUNZvvdt74SVDnl93g/h5G1rrziA5cFMZKTej0L2Ve/JzDAy1T3dF174zs4h/UIH6PnLcKnUayNK5SJC8kAlo4y4GOrO8lZdx2GEq2T6G9OVratz/tQW15J4kEN/cunWsRSQP5QsIJMbxYl9L5oK2vI2r6jyP5lgWBMLp2suv4M11QeZEMaXKHUbS+SLorJ2ZuVtxSQkS0w8POXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGPuiMzEAn7Np2TvbJ8uX9Tve7sSyuQg4+G1wh6FYhI=;
 b=rZMyQHmdCe5FZlQv4HVTjHMta/4fQLGtVALf9KCxTFjaA23IlMfQLxjRcuxUCxrBKhlQrUkN2x+OGANe5835qDGmEOdXGkku7ddeG7tUnJ+jilgTholmefAbkNy0OxdaRj3fm8mm+nVA51xDGRTTzbfE1fEovrofBfdktTFokxuO0/Jb88nsemahAYs6YQYizHBTvwRq2f0wkQ+bPbt/ecXxPD8kdpi4akdnqUxTSpSisUboN2DLQpkAZNxOEFOeudzJN+XNtwEYFGl5EG1DSpaJ3iSkbuePE6jrL1WHNKoeTyw22y1HZNYR7MaxNu3niL5MB5mCnzygMWhRgze0Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGPuiMzEAn7Np2TvbJ8uX9Tve7sSyuQg4+G1wh6FYhI=;
 b=Ni2tPoJWIHgNWz9sJMcW9XdrfSyEPsuRo9+Dd9C2ck5oRqKNz5GN1a8HnqBueBZK5WRbrrmw14Y1IomRrfvPsG45vAoC5qEKdZqbUOzx3smeygAy7bQ/MXGhWDM90QKLlcb+PBZg9uk6K7UAcWx8qQ8GK5FoWANjxsPVsipl9l4iLCUAIRx7GELVKU9MejXC1m+C2O6194rOoP8Pey5hMJHW4vNFkNqjZDXR+/0g7Kol8k7DLrXejlpQlFtzXs7gm8Ffjfa4NKfvVHK501m8fpppyg/LKbxhwPEstpoxkaRRgq1IHJ/jGKzb7ENEhO4uZP2MHLLRngMKojUKJRtDkA==
Received: from BN0PR10CA0014.namprd10.prod.outlook.com (2603:10b6:408:143::12)
 by CYXPR12MB9318.namprd12.prod.outlook.com (2603:10b6:930:de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 00:55:56 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:408:143:cafe::4d) by BN0PR10CA0014.outlook.office365.com
 (2603:10b6:408:143::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.24 via Frontend
 Transport; Fri, 16 Aug 2024 00:55:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 00:55:56 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 17:55:39 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 17:55:39 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 15 Aug 2024 17:55:38 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v12 01/10] iommu/arm-smmu-v3: Issue a batch of commands to the same cmdq
Date: Thu, 15 Aug 2024 17:55:22 -0700
Message-ID: <fbd1c20e81a923df174d766467fd15d3e05a8099.1723754745.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723754745.git.nicolinc@nvidia.com>
References: <cover.1723754745.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|CYXPR12MB9318:EE_
X-MS-Office365-Filtering-Correlation-Id: 4453ce09-b1e7-4bc7-9142-08dcbd8e2fb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PSoP5663fWop8Lb6PTf6aTQUUNMH6oF8OVpOsyEAxR1eLXHeam/gN343/3hA?=
 =?us-ascii?Q?RjpywosuMHD8klD4eAld9A/njnQw86IKSn3+c8WmnauoA3d5sKYdnFt9gMIL?=
 =?us-ascii?Q?1CajrUxALsk5+Q5tVx9wBGD3GPBYJl++vccLTNqC067cFBuXEuH23uRL4tGh?=
 =?us-ascii?Q?vc1MVOUeaegFNG9au3JI34qxPVFtxlU9+R/Z0C7jgX3czBsYvqCAJLRkJWww?=
 =?us-ascii?Q?DLSBYxIJekn8DNCcqSg4Bn8B0eoJr5cJecZSdyEeE7g5EpjYWqvwlv13nJrf?=
 =?us-ascii?Q?kcwE0E/9nQomrXG3Xyzl6h2I7UjmCBowaWlhcgjBSb92/lmqY6ki3fr7ngYv?=
 =?us-ascii?Q?3cen0DfGVV07ECbMpuLEWB0qPnuKdOsN1Xt/gvUZDAOIO/P5iGGErM80uzp4?=
 =?us-ascii?Q?sxksCHf13YBHWdrKiikkb6D9gKmls9G70Iji3xX6sLuQaKF1XuH3kiqYQ1sc?=
 =?us-ascii?Q?j7cko2LnOe4AmCGtf/lf5157l5EkFf+YolnE21r1Sen1yKIvVQvYO3NhqDdz?=
 =?us-ascii?Q?ByCyNkTf4xVXUqpanFHAUBqyBpSAQAhOqh26gu5kuGIhzHk8D5H60WjxeziR?=
 =?us-ascii?Q?dqiXsJSxdUvo1her5B682CohkjGSbWEiplmuh0P8//7pjhnKFX6i7SuIwFTk?=
 =?us-ascii?Q?VHCu/5sD71IDKKhWQE4tGmKCeKEifctfIVd1axt2BVdRNd6P5duW8R4A0lxe?=
 =?us-ascii?Q?6exNeOrWwq3b8GV23HxbTA2OzkaBQu9yKnjHaZvSl1zMWgny3sZhR9KBBRuL?=
 =?us-ascii?Q?lBZAowMPD43RW/xf3NJ+zqrgO19U2JWlGhJyO4FEFVvEd/kld8evpu9lU76D?=
 =?us-ascii?Q?whFYbHFaF1VhlikI3GctzqrIUe59SfaGpORf+MoNaiqhdb/7dEboUdgscSBg?=
 =?us-ascii?Q?tHzdwltfTLI6bnZtBNILZuGQvTe/goM0/Z6VMDIFquEt6uu3QfZxxXS1y14s?=
 =?us-ascii?Q?/HJ+7RMn151tpzD3cPc2DTEjspfr73GVtqSv7mxr3grNvAJFB92MqKuHpb3B?=
 =?us-ascii?Q?/FwE/IxMbIkVlkr6G9SvRaMwxDn0sMjJyO6CsEkdfsbKrUEYYmmzQW5tBHdk?=
 =?us-ascii?Q?iaoefliKleu4FbJsGACKdJNksALmusSPRWTRZ9irRn2nPNnMPKxtIAQEe9ui?=
 =?us-ascii?Q?JVZMU0r7QGbvC0qczHDsIqamCuqkItg7098t70AojVG+r2Ka7wJmYXKxraWn?=
 =?us-ascii?Q?1Ua+xHRNB/fsm0XdOVCUqOmZrbWRZ6D2/K5G9BPY5sIDIE747wqZq42nUBHC?=
 =?us-ascii?Q?zEJDOqKFP5aYxaVuqIFyeUJLokDJ1Skon49ymyYBEvDYBFTZkQMLvRCe/Ksq?=
 =?us-ascii?Q?guooNMwe9//CekETkKS1WHW1Xrs0LJG/1/dkn9gwFY6YvzJcK9xobY3NFwrY?=
 =?us-ascii?Q?uUBjBjzybni4U0kygW7Cs0h3eDlpROwdMyzmMQ4ar7XkxJu0mkBvePsQDDov?=
 =?us-ascii?Q?VvYK9jf61xYFD4zP9F7GB4BVpuRxpicI?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 00:55:56.1195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4453ce09-b1e7-4bc7-9142-08dcbd8e2fb3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9318

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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 44 +++++++++++++--------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 2 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a31460f9f3d4..f409ead589ff 100644
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
@@ -897,12 +906,14 @@ static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
 
 	if (cmds->num == CMDQ_BATCH_ENTRIES - 1 &&
 	    (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC)) {
-		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, true);
+		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
+					    cmds->num, true);
 		cmds->num = 0;
 	}
 
 	if (cmds->num == CMDQ_BATCH_ENTRIES) {
-		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, false);
+		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
+					    cmds->num, false);
 		cmds->num = 0;
 	}
 
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

