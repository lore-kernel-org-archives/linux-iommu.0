Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2084.outbound.protection.outlook.com [40.107.101.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB9B13C3D5
	for <iommu@lists.linux.dev>; Tue, 28 May 2024 08:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716883815; cv=fail; b=K7rG0ptxcT8dk3+js3d4mS/40/eebhe0vD26HUf/CwS7XlqvazlPE4rC2kDhhR6svL/hmqRFrn9hNQkUPBnRNryISbX5HXkUPE3Bv+kk1aWZ2l/1MpLpYbEXKc011y0ab1/UoIdDGu6CddecnxYqH5FUdyWLV9oN48Z8r1HMO/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716883815; c=relaxed/simple;
	bh=MJkK1UK5UInpMkE+zv7fsYuYjE1sswCWk5qKBcSWoEk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+G5zxB7FigjWXmZN0D38Td00TeGH5WOMsIYv4h2Ueodw40m/O2dDgXdf/gCAwT5Zi4aEWdIBSxQS7a8cRT70ISrTZQ2+9XCKG/UEX9+JHWNpsrLuGVhmK0geUTZJysrAEFywo9CoeZW3yqmsA856KREDYCkjH88/3OFLj0pn1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F1vK/BtI; arc=fail smtp.client-ip=40.107.101.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F1vK/BtI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSKJT0o8SiM4Drr41LUydayX9gI+SrdgklSVwxd380kQ7pP63Blp/ewXh3l0cN5LLeBOf+ljgEPNojm/bfIDII5ZyHw9tdX8c6tKvoqq7R6XvbARcq2p0i8/Yv0ccSXnu/l7IsHJDeqdKrH4aYNk+2tL+MfOhorwufiW+qsSoZ2K6BjiThHhIUidroLES8sMD+9g1ct3bjZBJpeF5AEWnm4NvXt6jr6bepEN5cPCwCvCCE1sJYZMqtKj2OeFJ+vGkoJG+qBJzxv7tQM/OrggpTDdg+fdvqO6fZsc2AL0fxZnO3SQOHK5RZds2SLowEKJpPxmq6VuUrRqxGy4m7LTYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLyCLptQSPtxghgeXB9dWIE3s4hLgYmEWpn/L3pWCOY=;
 b=Qg9LmV9bEzHxqOE9fV4RLV3KdYXLo7AKr71O4/fNSXk4v7XTtIHEwHBrSqXsXlgWXgU9BZ844GagzzgIEMTshOyI91giFQUbt4TaPYNkOq75+40cYj7fQ/uW73P88bTUhpv6R0r7BjOJQ3B+qKVGzJE1J8Tab7gh/Z7uPH4p6aRMHFMiNnicVFrMIuku+TbMAankGEFmaWMy4R9ys5r0pO0XCQe/mJOyB6IeSGyZdAxBXpryNzqtEHsY8DvHpYRSVdiK6NDgQ4CErZ1Bmf1NZPY2xjfHUjKCP+aGxfxLwRzvFOC56SwawsPl5jF8NM8k7iDvRSp0RetL0tpC4lKWKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLyCLptQSPtxghgeXB9dWIE3s4hLgYmEWpn/L3pWCOY=;
 b=F1vK/BtI6vQ/CeQrfFtbUW6w7t4KsLHhJx8//nuCiyv/oOYmVezU5LJZ4Iwz8AULoGenhEqdrioE5mQ9ZORlzXrSr1FU7RjIBmJWOO99cr7O7yTqccXRVA3+fnDbEexDiR9h1PZi1ps078odOViTzcOXWBSq8ew0Lf3QfDaQshfQOcIh1V4CelVTwUOoysadlfN6RYue5A78A19wXo7eRqkcJI3lfVepIxwhpidxKKY+e3JCZSS70phigoQgtvXpWvkmj+whG7g210Trb1u2upUob+YyCFNgmxKmDD5iBXscnMlqONy/sKRnzYlBYakmRU7m8UisIlrrvt6znRN8Og==
Received: from CH5PR02CA0017.namprd02.prod.outlook.com (2603:10b6:610:1ed::19)
 by MW4PR12MB8612.namprd12.prod.outlook.com (2603:10b6:303:1ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.28; Tue, 28 May
 2024 08:10:10 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:1ed:cafe::9b) by CH5PR02CA0017.outlook.office365.com
 (2603:10b6:610:1ed::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Tue, 28 May 2024 08:10:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7656.0 via Frontend Transport; Tue, 28 May 2024 08:10:09 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 01:10:00 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 28 May 2024 01:10:00 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 28 May 2024 01:09:59 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
	<jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: [PATCH v8 2/6] iommu/arm-smmu-v3: Issue a batch of commands to the same cmdq
Date: Tue, 28 May 2024 01:09:50 -0700
Message-ID: <eac050505b5eb1c85749f78ba5b58a092c27dd54.1716883239.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1716883239.git.nicolinc@nvidia.com>
References: <cover.1716883239.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|MW4PR12MB8612:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e2eabba-a714-47c9-52f5-08dc7eed97d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BF0crs11NBiWePaKVr0NLaoJ6K7ML+MRC0r3sujfqdbzhzTBgG4B8J4b2AZq?=
 =?us-ascii?Q?an35ZITQXJ/JQFXmhFGinWXrgEMHla2o28Vpr3G1ccgG+VPp+PO9N/XrQfH8?=
 =?us-ascii?Q?8+yoRpVvHVoRyxa2Pz8W3FeEEuo4Kq+csCeKq7px/sNPvy4LWXaT1rVDFucx?=
 =?us-ascii?Q?+wZEJ6lbTIPnVK2siNqZeWjrv9cInrdkofX2dS0zWrmc9unKi323qC9TWPM+?=
 =?us-ascii?Q?cH6nCpzYaSGITUNlFglNXhjFYXh9bCghI1IiCzdXOL+HLjvQY/SD+0lMAhBE?=
 =?us-ascii?Q?Nb0XKeEZVp15XG/kP+1NzVW2KdnsBTCxMdGzC3L4NrHo3tcK+uN+bK7j9gTu?=
 =?us-ascii?Q?OIpI3UOlgl1WC1H0mPIiMXEkB+skvem8pQpP8377JPQu7zWaoTHeC8S/OQGk?=
 =?us-ascii?Q?vbUjEuptGp8kMr68cT1AfYqCkjIaTjFwfd8113pljRaWc0GPtHiK7x2wsvo3?=
 =?us-ascii?Q?Bp500EvzlLaFhyHtcb9WOupmOCOU+hmo02RKltmIGW3VA2V3TH/egiVQAlKX?=
 =?us-ascii?Q?077NrIiUwHHZ3Cp1pMBG6o27CVlDow+zqSh/v6/KKsD1g9T1BbrGMdhlkGlb?=
 =?us-ascii?Q?sFkQtOVrrJprQXfKkrytzWN1LBB3vsnDcdI1IeTBDEWGDLZGE5QVTIjwsaGp?=
 =?us-ascii?Q?mPvddnszqqCsbLgZxSHgA5HTFuEwSG9HGtsEVjKqfdwttbJNKb8MFmsoee+T?=
 =?us-ascii?Q?zjHDaURmdodyMk8qfWgC2Gnayo3gwWGn/7tqdPDIRH2l1bYP+S3Rzbl/ufKF?=
 =?us-ascii?Q?RTWfaDkO/4qWv4AaDN75NQasvqzZZOQwLsYcNQQcuqlLuqsXDD8vW4gJLHhh?=
 =?us-ascii?Q?C8op9nY1p4min/HZwKfFIzobaDgOvgZB44HBvNoRpoQx8RnBmvYD+Pvx99+3?=
 =?us-ascii?Q?tSpPkYbSF94/jSuW+serAOeiUSdTZ94Dl4IPr+XiaJb3Oa+tLSgTuyInqTAn?=
 =?us-ascii?Q?42O9aoBlh+zLWuAVRJSYZplgpaQbTD6avh1npjVw2dBJxMQcnld9ecxtpkM6?=
 =?us-ascii?Q?hr7t1sZ8X9yb3j3snNuKc3kKtx6pgUoyAUHHhB8fogJQH+7ok6tUDnIcL6jJ?=
 =?us-ascii?Q?rBPoMVrIfPosfvePwoZzGWtbRZU42xlzSQ1u0N4jqKMqnNOvmeaw7ql+KKS6?=
 =?us-ascii?Q?iaB+3qJto0rib6bo5Cq+n+LDOSZW/jpe3jrOOFoVf19b878IRfVnhp7C1Knh?=
 =?us-ascii?Q?DWhjjL8TiG4Jh1lXRZqrkj38jnVd4RQQmkGmPeYtULKkHUAfoygYd/gmhdzH?=
 =?us-ascii?Q?omQnvGsnYiwz7lVNwCPCqxhuusGLK4VGc5dV14xg03cXwxdJtL0TfDalhd1y?=
 =?us-ascii?Q?r8HsRzpMbGAJI1tecxAE0FAvhRlyuU1FrS3jvr0Z0LcuBAH9ZN7wjWeEZN7k?=
 =?us-ascii?Q?K5fuKcc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 08:10:09.7566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2eabba-a714-47c9-52f5-08dc7eed97d0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8612

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
index 21878d4467da..dc8e9a48fe62 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -588,11 +588,11 @@ static void arm_smmu_cmdq_poll_valid_map(struct arm_smmu_cmdq *cmdq,
 
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
@@ -623,11 +623,11 @@ static int arm_smmu_cmdq_poll_until_not_full(struct arm_smmu_device *smmu,
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
@@ -647,10 +647,10 @@ static int __arm_smmu_cmdq_poll_until_msi(struct arm_smmu_device *smmu,
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
 
@@ -697,12 +697,13 @@ static int __arm_smmu_cmdq_poll_until_consumed(struct arm_smmu_device *smmu,
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
@@ -739,13 +740,13 @@ static void arm_smmu_cmdq_write_entries(struct arm_smmu_cmdq *cmdq, u64 *cmds,
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
 
@@ -759,7 +760,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 
 		while (!queue_has_space(&llq, n + sync)) {
 			local_irq_restore(flags);
-			if (arm_smmu_cmdq_poll_until_not_full(smmu, &llq))
+			if (arm_smmu_cmdq_poll_until_not_full(smmu, cmdq, &llq))
 				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
 			local_irq_save(flags);
 		}
@@ -835,7 +836,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	/* 5. If we are inserting a CMD_SYNC, we must wait for it to complete */
 	if (sync) {
 		llq.prod = queue_inc_prod_n(&llq, n);
-		ret = arm_smmu_cmdq_poll_until_sync(smmu, &llq);
+		ret = arm_smmu_cmdq_poll_until_sync(smmu, cmdq, &llq);
 		if (ret) {
 			dev_err_ratelimited(smmu->dev,
 					    "CMD_SYNC timeout at 0x%08x [hwprod 0x%08x, hwcons 0x%08x]\n",
@@ -870,7 +871,8 @@ static int __arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
 		return -EINVAL;
 	}
 
-	return arm_smmu_cmdq_issue_cmdlist(smmu, cmd, 1, sync);
+	return arm_smmu_cmdq_issue_cmdlist(
+		smmu, arm_smmu_get_cmdq(smmu), cmd, 1, sync);
 }
 
 static int arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
@@ -885,6 +887,13 @@ static int arm_smmu_cmdq_issue_cmd_with_sync(struct arm_smmu_device *smmu,
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
@@ -893,12 +902,14 @@ static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
 
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
 
@@ -915,7 +926,8 @@ static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
 static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
 				      struct arm_smmu_cmdq_batch *cmds)
 {
-	return arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, true);
+	return arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
+					   cmds->num, true);
 }
 
 static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused,
@@ -1158,7 +1170,7 @@ static void arm_smmu_sync_cd(struct arm_smmu_master *master,
 		},
 	};
 
-	cmds.num = 0;
+	arm_smmu_cmdq_batch_init(smmu, &cmds);
 	for (i = 0; i < master->num_streams; i++) {
 		cmd.cfgi.sid = master->streams[i].id;
 		arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
@@ -2003,7 +2015,7 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
 
 	arm_smmu_atc_inv_to_cmd(IOMMU_NO_PASID, 0, 0, &cmd);
 
-	cmds.num = 0;
+	arm_smmu_cmdq_batch_init(master->smmu, &cmds);
 	for (i = 0; i < master->num_streams; i++) {
 		cmd.atc.sid = master->streams[i].id;
 		arm_smmu_cmdq_batch_add(master->smmu, &cmds, &cmd);
@@ -2043,7 +2055,7 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 
 	arm_smmu_atc_inv_to_cmd(ssid, iova, size, &cmd);
 
-	cmds.num = 0;
+	arm_smmu_cmdq_batch_init(smmu_domain->smmu, &cmds);
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
@@ -2120,7 +2132,7 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 			num_pages++;
 	}
 
-	cmds.num = 0;
+	arm_smmu_cmdq_batch_init(smmu, &cmds);
 
 	while (iova < end) {
 		if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 67b0ca0b1b79..8e4fbf4f50f3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -564,6 +564,7 @@ struct arm_smmu_cmdq {
 
 struct arm_smmu_cmdq_batch {
 	u64				cmds[CMDQ_BATCH_ENTRIES * CMDQ_ENT_DWORDS];
+	struct arm_smmu_cmdq		*cmdq;
 	int				num;
 };
 
-- 
2.43.0

