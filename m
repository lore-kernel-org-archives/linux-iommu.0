Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDB11BA28A
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 22:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724970907; cv=fail; b=sTJDOU/Fc78adeA9qng52pHVeACpd4lZx1O5KAPfUX+JHhsZBuVg4eXCTXQlLSwfI/b/271GSEdxyE+YP1X4QJQx1ICqjtniU1Ylj+jiSAt2YIc/qgBrcAe0DIx2gR79j7rshUkmXAC/mpiDhtbBAWZLbkjhECd8btJpYXMmgzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724970907; c=relaxed/simple;
	bh=NqVZMfYRTHzadcoDNeqqn5OGiZJxXIrngNklRYv3bno=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=USEQnmJBc8lPiOGlfnN7225V92xvGJ6F5FQRzO2ucfMAyKqap0oKD0yvAYSbgB1DpSuornPKcCtHEvND3RurH5ynxcwhzMDWK4HFzo6UJZBrKt8nde9/+Cvbe4mNRTNskJEo137mH/0qg7w2jQbTnvz55pJ03YFc0vw8xa4j0+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F8XfmbEY; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F8XfmbEY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wP/adsaLJkvzDUr8uXF8X6PDwbwIBPRhh7Rw+taKksfB290LUubGNbbG0Vq5yuSXPVn2NoCODZJ6WWw72nkffTUoZ7Qo4mZvjZnDaSuapAQOUprvdhijLgRvakPd0OGmQKfBYiiUCCzwRMJb4dXtwgwk/1xGPzMHVkDWkmt4Qb7byKOA6ye/ABc9iFXL6jwwC7u60XpyxltUowtp2rxJIwvnQv6+CeSC3OUEYoTSwALMvV+f4+PVxWQ6IAUddh//A0g1twWdeuyuV0oyNESzi7i/QpvWrve7FTXzCqLNstlm77DXvp58KOHkf0wfw/K6afIoFgL2IDa/ddjKHBXYBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZuFK0XvQpx97/P7+5Ic7Q/BWyovG8QDu3uWec1NTE1s=;
 b=koZbn1A+FIslJREGQTxZoBBcftaHl7RLfAcRk8JWPCDJGx1NlPT1JT2rJDYXMp2lk7mBGJ4JOVJbnDDDyju07EaAJbhWVTFc+INqbI+n3ktMNcqJ/Ielu51sQNP1WWNFwbGJXKV39s3ie976y/NeIpath1Y//Idq1N+NSkP5wersMWyEnv/wKQKMx87oSfoel2NCiooJewGMSFdeXzjqQHyCF1QoqtKIIr0/G943OMdvya403H76JKII9NMGJIMadIwr02EXqWUOjs8NRyPgY32ZIst1hEjwhRnKVvng3gXBh2716cw17IJB76xOb9ZzIKlTAJgWJocV8PZ4oTrYoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZuFK0XvQpx97/P7+5Ic7Q/BWyovG8QDu3uWec1NTE1s=;
 b=F8XfmbEYXqjdFD3t/qjzFMjQxtLCTSo1qjEMg0nD6Vm3FSvJOJO1NC8Boc2faC+5APNGB8BY0fPnoMOmEY+QBEgpC7UquafxXj7X084zGFTc0PQerj/5QkWeGiw2PDEzJLaI787wUUXaTa0qmPVw4YPogNniMtsGLW1VyOc3exmZxRxrulythT9iWnziwe3f1d/QmI67UZ+yiQN/BDmVV+3ha+DNlE9KA1gTa7T5yLcW59Aagg8w0eHnnnpuvXVh4O/fTRn6GOneyQtp810QnnoZ9awQZQb+Q+tuRXYx1fq3/g/KZAPGn37xNKtWaVhqvNKqbgAR2v4on/2Nl+zQow==
Received: from SA9P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::29)
 by SJ0PR12MB7006.namprd12.prod.outlook.com (2603:10b6:a03:486::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 22:34:59 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:25:cafe::e0) by SA9P221CA0024.outlook.office365.com
 (2603:10b6:806:25::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28 via Frontend
 Transport; Thu, 29 Aug 2024 22:34:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 22:34:59 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 29 Aug
 2024 15:34:44 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 29 Aug
 2024 15:34:43 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 29 Aug 2024 15:34:43 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v14 01/10] iommu/arm-smmu-v3: Issue a batch of commands to the same cmdq
Date: Thu, 29 Aug 2024 15:34:30 -0700
Message-ID: <2cbf5ddefb6ea611e48d67c642271bd24421eb21.1724970714.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|SJ0PR12MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: 9478ebd6-6662-4ab6-845e-08dcc87ad0a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FTuPLFVCPPCQxIVbF5NySQYySHTphEyAfCD66krhAihE6XLcG3aAT8lt/LFJ?=
 =?us-ascii?Q?WUI2W6ZO4574uTFI2G9aVqIsd69wYarafHD6OKbibC5wDIGmR0pD3AuA635U?=
 =?us-ascii?Q?RiLvpMJ8pZcE0Y5YKKRwybZ8SQhweSL5Ee+VzEkubpeRrpg2Az/whbio/zBd?=
 =?us-ascii?Q?+g+f8/AnjUUJPDMWXw0hcFmMNFORnu/Gd7BgdEPS9dfnd3t4gYltlm+TIjL6?=
 =?us-ascii?Q?eamMyHjMXmMM5KjE4QOrIo2JDWL5Kv74zuP3tgtDKGqUubUoDvBFyzkZ2JJh?=
 =?us-ascii?Q?RqP2xgeI8n/kZO+2HPhbm7a8jg0lTVPrXmCpl0r8A5wY1n3zaGguv6oBkXkM?=
 =?us-ascii?Q?7yUiH0NACnG9M/CXnlLtBtlmUdBn9K48KkoDfq8w7G39rstTySO9Lu8flr5e?=
 =?us-ascii?Q?cpQjCbqYVEIJiHjhRn2+cZMeggEJ25rgJdMooqftdo7CDbp3iRvPObLLDWb5?=
 =?us-ascii?Q?D5iy8sghNvqFSRTD3thC1za+Hgv8AQ7RN/fl0qBKOVCM/BpEkY00xowBCibq?=
 =?us-ascii?Q?IFqcuKRx1YFufkS+MP3phu83W+EMPO7sNv270OdrXps6gSPBX35hQ08sUo+c?=
 =?us-ascii?Q?m7YJ1DKHHG3IF9yRloBGe6AT1ti6oXeLChXI49D5pMbBrYOhpwMsZ6fbPavW?=
 =?us-ascii?Q?P0lI2wL9URrUlJA0ew0Cry6Gaz5vgbVlgZyOasi3/7XCaCbq0JfVoeyoDXul?=
 =?us-ascii?Q?4BmQi+MBUqkxMCV2ue/j3bxG8Fjigoa1DkVgRQHtoCrxlcau077gGRKXGlJv?=
 =?us-ascii?Q?cQO8z8JbiFCl7Hn/WdfxQ5nezT3YcSZvlKC05PvHJFx1wnfJHJWsJmu+4n7n?=
 =?us-ascii?Q?pXi1HtoL4gdOM6nEVWkcgzvGdSoLgVy+yHk43gkDEQkvmFbTMXZu6GJpiQky?=
 =?us-ascii?Q?FOZzwaDH8Y+yQsNP3so1CNxMCzO1OvHjhRh+IrfJFFDb1spTdB+JleFfbkMz?=
 =?us-ascii?Q?h012VxNoz6BpQQZRYgz5iK4wHeXh0UwePpbHIyHxHQ3pzGdAUn174aNZkBu+?=
 =?us-ascii?Q?OMA4JaXCzAteUIO1nbmkt9Un1u40nh0GprUo/8n/RLxjeyiFkbWuwa39ZWcf?=
 =?us-ascii?Q?U0xND1Fh3cto0+yM8lZxgfEEGyuA81PuLz2tsqeRZtX0KEo4QRCoMOc8bw6l?=
 =?us-ascii?Q?Kd3AOe83zFG8kWujcnYasTaRatf9TWiHNtLyFnh+jv9+LlF8sqcs7aNXLL/7?=
 =?us-ascii?Q?g9GuxedGq0oPM53j09RA9wAJwCblrcn2aQLZUIHq2w5Pp3VRHx82wjVEmDx0?=
 =?us-ascii?Q?LXjljFMU2ETuJu1jE9PgB/x296RfHjf8MJZklSV1DaU3Yi9vcsFbQ20j07uR?=
 =?us-ascii?Q?sE5bGkjzuALSoGKnYLq/k5JC5e6YDK2V7buGzNJKRg7zyeIt6NE5cmKP/fLc?=
 =?us-ascii?Q?JFUBjqIS0bXslvi2+zjeDWMTqYUp26AMTQVsjjjfiwXm6SjKIvvGp48IccOq?=
 =?us-ascii?Q?56Y44e1VuiMKGv1er4RBrzxJH3bnUMOV?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 22:34:59.0016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9478ebd6-6662-4ab6-845e-08dcc87ad0a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7006

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
index ac6c1597fb2d..7213ec538887 100644
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
index c425c878bbd4..ba24f9efc5c9 100644
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

