Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93A87BAEC
	for <iommu@lists.linux.dev>; Sun, 28 Jul 2024 22:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722206710; cv=fail; b=SGDjn9gKOXNrthuXAnK7uqlk92OCckOVrvErbd24e1AQOPNDxOA79yArF2tCCgSSkxvfIb3XqBxD1lKwXd9+QHUi28r+xpldvcalKz1eKeAmJNCvscB84VrbNUAoxYHTotl4PdQpVX+vYm32u0Q4nNfucJEjDsp2Isu3Wgt8YcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722206710; c=relaxed/simple;
	bh=6IHx3tvJEQWkDsVcgGvHuGuW6HP05TvkHD7iGHqRXzo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t4HKGddh6eqvwoYB3SyJsqhXWsEpgWfDyVAG24FSgB/Ex5Kf443pWDezTZlekoLUkeRJSjW5+WPZDdSMASZ7t6aTS+JDyCpt5FjVapTKSMruwn/8BJIW/fI9mYazr6b7xxwhgnOrFsBKs5l800knadaSSIERHyWpHITNP03Zb2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bF37lCbG; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bF37lCbG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFJehGSGdt3t52EVRx01phhtd6s+2eCovJqzSa2VWsjoWcaLtdVIJTdc9WtI3hBaiTfwyFO6extt8A3+O77squA8wgBwJoFiLwQH96zlSlzdRXlMdmHrtVXN4oz7sasDLQq600LwKPc71jM+2BgeL12tFpbrKTeT2plyJId+vy4TDVceXt2+bCQPX/jFBg69q0sTEdLoJURZmN3jkIxBMlL9bvVAhKymnFaYagELq10sRTJtSFu2iW1vuWEoNen6KgBGHL0xGmlik2ICmCW+GmP5TPrxnaqEoddeZ9Hvhv1wId4O4fEUeO1sHQT4Sc6GlDS48fY6vBGATy+2dmDhQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Szvf8FNNaJdmb3wTPkXL69Q1ICFOtriSCanDluqqtW8=;
 b=YtPDo36C4fuAJpXCHOr/rQ/fsQGsSDBOR5kZK8J22gZ5TJpXzU9qWoETh7i8P37YiyfrJZMek0II7LVJMhI8TxwCmTzy/ec4KNqAbE98I9Tn72SGKnQetP6UwdAdf4e407LqUXidEeQKI5OONtM75s+TYnzCSBifU5VP2vwLEkja20T6EBa81Jtn2EJQkcIr7NGFRYbJLzHEN8kV+bxJ3lx9JgeZSJ3GrvETzktebM/jyuhXGRDexiKRrouoLSM+S1l8jpMCdBSekVQxD5Svq8ZATXYu+tn1UqVUOcI764mgwutABD026WJ9xf4s2wlsK2/3x+fk8Jo03FnmcjxG2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Szvf8FNNaJdmb3wTPkXL69Q1ICFOtriSCanDluqqtW8=;
 b=bF37lCbGRKsi4ieE46QXbgqvvkx159rDlGGcol3pUUsh9JzW+03Uvry/bvzNzZXq5vp5xgXfwWztw9pb+e2uiK66HdRwFSEicCQjruz2RpfcWOnmj/nq83IOp13ShcY1UVIvI2OiO5y0jwZZ3/sTRWOv8jBEAtdSP1k1/q7QLu/JN3hguuSrnhkNOKeM9ipP5a76EiBOnJdRGrx+nRKXvDp1kDDFdHbG0B94E46FDVpHrtuSexRriiEpbqW4Gizc/eHJxzaHKb9X3lRvMsabqUioorvFk9bCr4f1zkWcZyZJkulJkYz9ESdfpXojj/iCVNWa/2mZuBo37ep+xecuMA==
Received: from PH7P221CA0064.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::18)
 by CY8PR12MB7489.namprd12.prod.outlook.com (2603:10b6:930:90::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Sun, 28 Jul
 2024 22:45:04 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:510:328:cafe::72) by PH7P221CA0064.outlook.office365.com
 (2603:10b6:510:328::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Sun, 28 Jul 2024 22:45:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Sun, 28 Jul 2024 22:45:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 28 Jul
 2024 15:45:01 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 28 Jul
 2024 15:45:01 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 28 Jul 2024 15:45:00 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v10 1/9] iommu/arm-smmu-v3: Issue a batch of commands to the same cmdq
Date: Sun, 28 Jul 2024 15:44:46 -0700
Message-ID: <573c571ab9162d5fc13200f21bfcb9dc7b54e0b6.1722206275.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722206275.git.nicolinc@nvidia.com>
References: <cover.1722206275.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|CY8PR12MB7489:EE_
X-MS-Office365-Filtering-Correlation-Id: b6aa034d-ba75-42e8-22a5-08dcaf56ebfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PbTsBcaZzXy6EHtmuVl8T0b1Vgv2uQFkHntzENmWHakFuKVR/IrETHF3X+uG?=
 =?us-ascii?Q?p3ZmiEnrE8SjsILEsiQ5vNgvpLbW0tdDTUBp2jBCXmuwuQsDkNady3TuSFeU?=
 =?us-ascii?Q?KfRBsUzXTHjog/IDNzPr56fu54jc7DC4ZoiDTsHTjoQbeh3Tu4mlLoOXOKWL?=
 =?us-ascii?Q?A8kH8ONDMqlYsJjInEONeR0voFB7/VaYv3VxINPvZ8+e7jJlagWY9DaLuipk?=
 =?us-ascii?Q?8PjX82G0rFaf79igKoOsXy/gcqiH1I72iSxB3X+Q4tktc4k0ifN0hvNANqE6?=
 =?us-ascii?Q?tz8NrDng/f7YSa645p+nFPHtlHCZEQLgizLJn7D1ftTi/z4aXJSxPD2fOPFQ?=
 =?us-ascii?Q?L+pJa6+uSPnQoill562zv7NDU5bWZrhDPRSAxcB0Z9fk/WH0OPUqu454ARcu?=
 =?us-ascii?Q?Wvu5ChFbBE0hp88ltFG2PO81eGN+slR10oYfJ47c0SRnzWIAZZ63OuJh4p6A?=
 =?us-ascii?Q?h+vDejUreEFWD0VO/QQg9Moa+bcITcJNSvreTRko4+IhjvFJh/QBHLKcSJCG?=
 =?us-ascii?Q?gb9XKMLIBndDQoi1Jjh5zCYagNMjVlFImDxNxqSL1PQPZyT16Uqd1cIc1ouO?=
 =?us-ascii?Q?kmf44K/YJP9x91KJnRHDP/Q6Pf6Rsg3nshPbnBSfTex/lwcejQH5U/VBjox3?=
 =?us-ascii?Q?kb/DPLOP1YDRRrYljR3WKcEZLF853fUIvHGm/YTU4XO4mzNPgJFVGPPXPBJo?=
 =?us-ascii?Q?44AdR4GktKRVvsmZ57zj3Km+epi4M9WkBS5W9+mY6o01Vv5iHtld1W1VnoKI?=
 =?us-ascii?Q?7fB69z0+iD/3sUY1VJjIxTMxtb46oIkgN6EoLqyfr9K9EE79mz2lGLqev2We?=
 =?us-ascii?Q?R7xUvcAlvKnY0kipwwBNQDxlgngGCMwDXsKqOXSgD7mjl7dK253VwQzRpTN5?=
 =?us-ascii?Q?TYF6A43NCEgYxsn4SnuEXSMrwjTUJzXV6mL7LHKPFdK8RAKGTqYQOoUiGkap?=
 =?us-ascii?Q?Hy7pxEQFVO1YV9na20IsXfhrEKxLuGcV+EZlQXhEqVmId6a19aHgr/oJxz8U?=
 =?us-ascii?Q?Hvg8e8JLZy3F4SWxZPhlCgm7WrGwyPpH8H1f61w07oj8ioTU/17rovYhmVR6?=
 =?us-ascii?Q?XWC71bpXP2jW9nfJ6X/Yg1/DPWWwCofF7ts3pHdz1fa2MR1nscmDLRPRkxRO?=
 =?us-ascii?Q?i3YrdrVl1g5IhQwlqHY5Nj0aF61ly+6YYg5OAr8SbA3eVQBCZDDnasFvSeQf?=
 =?us-ascii?Q?D6WZtgGtkgiK6xZBwp1N04yFlwSH9Bbh+J2Gg1ESDxcIxVTKXa6IKqyoGqIn?=
 =?us-ascii?Q?nptKDlnpvBN0jy9n86pjBLmu276wPz62zVj9506tIfp+YRzVvOkD2rgtJlnX?=
 =?us-ascii?Q?sgewaARZi6Sbh8x4JIJGG6xWoj7bbubwXep23ywL+VHkkUeRjOL+r6IIEw7L?=
 =?us-ascii?Q?bzfaUuoe8A+tUihbRsCWGqbNfxamsqgs6VCDd2EoMVgGxe7ezgmLGotDidVg?=
 =?us-ascii?Q?optYH2mhszlRS44bVkEP/pWKIpUtQcDH?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2024 22:45:04.0270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6aa034d-ba75-42e8-22a5-08dcaf56ebfd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7489

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
index a31460f9f3d42..f409ead589ffc 100644
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
index 14bca41a981b4..c1454e9758c48 100644
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

