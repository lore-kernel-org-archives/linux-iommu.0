Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4050115D5DA
	for <iommu@lists.linux.dev>; Wed,  7 Aug 2024 02:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722996742; cv=fail; b=rlmgVfZezX9WMxwQ/ipaOaFkqljbqzVXQTTGDC/Z2VGuI10+bWo9tc7iX/2l0C3HxMz/IMmMo/mQ3hWzERnn+H3DhsWuWbYGxw4Wgjbt+jXJVDJHTalM/QU5tOCGL7Vjp/v0XeKihsj1Hy2/jyiDAWY3OzluS6XaC/5YXkqSgRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722996742; c=relaxed/simple;
	bh=oM4T3+/J8y2in2AFqLtrlN3CenDx5e712CjvISB+pAc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NIpfRrx0xdRvLv81TB2kcw9UPEtPbVZLoNrP4KtYQZlTb9G/kGLc7GudhD3ERYyFa+23ZCWwN8Xg6EO+9375g2AjJgc90Q/iVS76z8eRDPM064Coycq5/EAg4j+7J8mCdutNbAzise7CSmZgwSn+5f+tFkDs2RJ6WjMhmydcO4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ebehpE2d; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ebehpE2d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vYaxLGEaswLd2bS/VlXpA84+UU3Q3qYz/wgG8mTCfsE+4hE9DZALFuZytinc1nhMnR5mFdEos6QtobTgjV1e54CI+ja/+9C4Ub99kt22C0If1P3clRG2deXmR8hpb0ZRhzoKKsZoNT7pPeltxjNQnZ9g/Dbm6KEPWKzt/nla9pHsh+PJmYTvipuOqoMAhThY4Bwu/s3/qTurLUvKpKFzwTMXmEutb0wYJUq4YyV6VnjqHQAigNzF6p2UbWKritWcNf1pu8g17/XETdH81zIdhfTZRPZgJJwgXXFJSBt4o7NFA92J3XJOawzU3F/GLKppbDRZUmccP+VopnjoHYXtEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGPuiMzEAn7Np2TvbJ8uX9Tve7sSyuQg4+G1wh6FYhI=;
 b=mbWcH99NOxn35rDeTQi1kOxe7w5k2a41lBCKdGHL2LWl99VR5MjNap//MkWspEe1XSYTDsn/7ds9TpCqSg8gA+kIUKBjhWZ3QE6q/p8O5xUcuuhJ4fGBa4wo4yy4FqKKYhvsV8djSD5qH22zI8fXCme2q/x2PejDKIvcuMLNk3JgNuynuJcJBwJwK+uLc1/ge+TqONdjHYGv3jw+m626Xyu61c5agHMCt4Xr84VM4z90boQL2kJhonyZG1ZkvOSJllg6tSLe05BoJrnKKAdPwqE82PjhDOMzL3BAGLRogasIylesrvdIrTxqcDMDx4LAstviymVSxTB4emQgOPJ1xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGPuiMzEAn7Np2TvbJ8uX9Tve7sSyuQg4+G1wh6FYhI=;
 b=ebehpE2dMrADeH/Pc6R2tjEyVJRfW9bU6X/iL0c78Xo2C/7fsXr1roYeLKNMXkVVSeOfs4zb6ihO2dc8XYregb4hE6l/yYQh6eLFgE9uP/xgWrEryJnEpZS68XrwnmCrQ5EibWhHY+HQTv3ympNI9zqU/+U5eYfWVP5qhU/F8WCXGwD/UokhlbrOgmqYkAFkL4Li6rX8+uKWpDmAE3HM0hdZh2dIaQDQ7kmy/cQzbCqwVeIY2Pzyqw+jYUJCVIzAaRlFDKVnp5BsQJFYvPDL8wlX7llVhNsX0lSDCRSgHeTRRaxo0dctD2/+5Azia04ym8JsTxvh7Xg3356vVxxk1g==
Received: from BN9PR03CA0646.namprd03.prod.outlook.com (2603:10b6:408:13b::21)
 by PH7PR12MB5904.namprd12.prod.outlook.com (2603:10b6:510:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 02:12:16 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:408:13b:cafe::ae) by BN9PR03CA0646.outlook.office365.com
 (2603:10b6:408:13b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.28 via Frontend
 Transport; Wed, 7 Aug 2024 02:12:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 02:12:15 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 19:11:58 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 19:11:58 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 6 Aug 2024 19:11:57 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v11 1/9] iommu/arm-smmu-v3: Issue a batch of commands to the same cmdq
Date: Tue, 6 Aug 2024 19:11:46 -0700
Message-ID: <e83e98db8b1cceb46fcccd38a5add040eb0709f3.1722993435.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722993435.git.nicolinc@nvidia.com>
References: <cover.1722993435.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|PH7PR12MB5904:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c3b0b9b-1598-42c8-ef9d-08dcb6865ba3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ncxH5LvUhrPKxBm0Vw2h0tQbtcsAqzfJhh13rF2+F8JQGjfuJAZsrfbZXz8O?=
 =?us-ascii?Q?KZAqBM35JlKQTZs9916nOjnu/lsaV+d3poQ17R81bXgLl7DIASF+BUhappQQ?=
 =?us-ascii?Q?VxppY3kIpwZEeC8+mxEn2B8Kedt7yLOoafnQx6UxhA8ovFCAtaeLC6rdzLpw?=
 =?us-ascii?Q?nFqI0dA7iMpCIBml2BVx4YhV/+mE8LxFLVBks9RhwpSX5MNjqMkTKV9YdCut?=
 =?us-ascii?Q?RkoUT2b2e6f5EdrPUzyuRudAeefcnJc3b5ZxP5pSqU+sD2JsO7k6xmUvbLqX?=
 =?us-ascii?Q?D9IUB5oTTQRo63PGpYYSRrSMk8M8ZZtRJ3UhlE3IjG3TYH1Xv1EIdgMRNXG9?=
 =?us-ascii?Q?1Nyr7YmXRw3hODv11U7IOHP8yeyk9rGZuxHZiKhvjjLmpdo9SfUgTq57MKnv?=
 =?us-ascii?Q?vqQNgfjR6htMKkd5ImGzLJvLTXQ+mfo2CLThsl/FoyGyPkYQBg+GZiFt2zAY?=
 =?us-ascii?Q?6of7VL6oJmLLqXAdPBmIcL+73E0DNiiUwCxk9rdjBhgXAnSfTtFvPxWxIdLZ?=
 =?us-ascii?Q?xN5n+xEgwP0QghClBfFJEUOCwVyfD8tW0HaVm3M0N0oYLNRpNK9y9nw4Z8IB?=
 =?us-ascii?Q?nZYGvniJBSrtQ4tcaV/AxaPHFpaTRytL9fngHdpgArbl4Aj/HrCasR6mXT3F?=
 =?us-ascii?Q?UbRyX6YyK9nkdxV6bNDuSe2MV0cQNYCkUNKcX7CzZMvzl1PcAdnpc/Ybj8jO?=
 =?us-ascii?Q?QsY8iMURMJ/cSGaOu2pg6dkhlSomyXmWwjQs+lz6PLip12TqjS4gzyofmhM0?=
 =?us-ascii?Q?mq/YmxNGmPmXBS7f1UI0y+5RMTDyQExHOlDAnkn+s0BGerXTS+CYAZso7S99?=
 =?us-ascii?Q?6PKfBHWVevp1s0RC+lDLUbIa0aLC/4jsPp/dQzGjR4tbpQjhFYAtAgs7spKk?=
 =?us-ascii?Q?PDRBuxD4ThXn7jPrqNfCKigheCxID7kDMk/zQ3K7ZA6JJgK1eFVMMnqN1z+s?=
 =?us-ascii?Q?dZphoQpI3FaSw0vSCC4Lx0aQCIbXgEipZfz51wn+aHaI9p9B72Z3u7swHKQ5?=
 =?us-ascii?Q?iWOvWvaHpsYZPEJzhRxf5cw6hq77jpT5/RCpndT16tieSYtZ9bZlDr/ZNJ5G?=
 =?us-ascii?Q?0jXs07uWELiTec9l4+DJxuX2neCWdDq8kKowfQGqRl610gCo2Mx9j+p4gyZH?=
 =?us-ascii?Q?/Soqyeb1dlKMrMjhfxe/+6H6y2YPPHQS+uFXug0TRPzDuJkbcWo76l0pDtqw?=
 =?us-ascii?Q?G5QbPPxRe3FRcyUntVB96OjbQZ8VSzkrPoj6QhMLin7IwxpQmYC2FFz7RT3I?=
 =?us-ascii?Q?ZVZry/meih2si3MLc3Yxzvm80kXf24wkF+vuLjNPaulirjyiRFmZSR10QxLi?=
 =?us-ascii?Q?Qww1N9POAMGX/EQ8JjAhwilha6nDLPDweJQCCyXlOJPXBpZ0KhSr3byDShaj?=
 =?us-ascii?Q?/VIiu5GBFteXZam7xkKNasGpmBZfqSu1dYVoOSP3OiOTinVZN7QjvC6mNXj/?=
 =?us-ascii?Q?WmoghNjw8ydBHFC0QUWRkRXipU/dSqR4?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 02:12:15.7079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3b0b9b-1598-42c8-ef9d-08dcb6865ba3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5904

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

