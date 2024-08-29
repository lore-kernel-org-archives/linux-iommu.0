Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0586F18E745
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 22:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724970912; cv=fail; b=KL1zOzXGIBv6vxqr8ztzlyfo0P16fwc/9o1d8MciZc+7ZFgar1Hr/ezFbvkEqJPx8OXoOTBVqTRkyNWvkuu7QuHvC2Tr4PnLjmCtnNmsGBqHwpGfJDb1xEnJzuQ4ZwTqtYb58wqx9XqxsDuAYINgMGy/CPNDg+4clxd7YDWR7rY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724970912; c=relaxed/simple;
	bh=MtZNAa02R/e7t9ydmerHspqYloiShOtLul5KdViY9Xo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DQi36DGr4rdGRucuc6Eb6vDDF1CXbKrfZ3qyT7l7gDUZsqpI09ukYqwUp+F2Qg3lK48hkcty4SAvS7fxkCo93QkOHeJGcVxwIpw375hvY/Qhi8EacMuAgc9c5j3bkHwi5Cs4bjO3k7Am4nGTDckBkZRjVZquStmHZnBeF7c6JuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WjUG9m2U; arc=fail smtp.client-ip=40.107.220.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WjUG9m2U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZhoI3nAp8XDIIF5YIF3PJLfWBNiF+RcMEIGiA26EaWUAlpK8sSuKJPy3zKkypjEm6fuszAlyYNdP2D7b1tyJFig6is+GpyssiHtn0ylfhpRkb6+emLcLZoSM1USa69muEEk0lQFkq3B/oPrYGLeJsHDgVQwZzDc3yCni6+1CtzCUFBAd6vsh+fg6mzwOxVJtFYXReMU41BQEWy8wROSeiUtFnrhjkTn1F06qezJykGbSEjp3+0UDEqP5C9d4nsrmww9cO32ZtW/Jg4/hxsiQQ1Zju7HEvZfkGqSgYR/e320boa+48uugIo7nxiFzhgBoyu1P1vbdU03yKD3uaTybQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdUMkm7gMnk4eyRTHNDijRNKnh0SqusRiylazFFsU5g=;
 b=gsfSjIjfwhjPnsHn7v8XUoHOxLzJW0MBw4OR6uQ7PjWERt58oe5/47mAbaW86sMjOaTUluGHFQiTBIRiIpDP+SxG54MolIVXoVv4VBKawnU83vhNvNTk4tIrzGvS8JihAypBsfrLLw46XfYVPMtwx6biRGXjANPmMtYXViqmZJBZakRzuaTejszU244Bx7YAUkn2iZS0U5QcDXCcODdXy0ovFSVDftXwKn3W5uaB1BQcpKmn+bbg6rutDeCyEFftBpKADAZStQ0mIIxgFJvLns5+7LERulH3p0YP52meKSmuhzppkMVXHd5adJH8mP+7jy1RQMI4UWfkhXNHRTGd/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdUMkm7gMnk4eyRTHNDijRNKnh0SqusRiylazFFsU5g=;
 b=WjUG9m2U7zFTxywKO1J4zn8WIrQsKD0zmSRFKlrb5jbr7oGfZia9+bABTsKLLKqlFlhxS7A2Cizogu48Q/Hbt4ErJw8p1bUvzntNWtVw/Oeam4xYM14wjRPE2557vZFlvUgBT9H4bTCX3oJr/BmJ35KrwytvtcmWfAmhu5w2JufBrR47jRJF3MYo6kV7FmcTRNgmihuGhzCy5xh/idmuLytejU89p8zrf83j5lX9o27Io/nO6YEaaIOwMnC1yI05Wnj3FDOqxVd73Rd+RPRBuihI7dSCGXdIZzTjXU5HIs8dZ4zbiX4bqR7S1vqj8xr7F99IYJghKFRX86zj0Qvp3g==
Received: from CH2PR14CA0009.namprd14.prod.outlook.com (2603:10b6:610:60::19)
 by IA1PR12MB7565.namprd12.prod.outlook.com (2603:10b6:208:42f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 22:35:04 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::53) by CH2PR14CA0009.outlook.office365.com
 (2603:10b6:610:60::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28 via Frontend
 Transport; Thu, 29 Aug 2024 22:35:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 22:35:04 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 29 Aug
 2024 15:34:54 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 29 Aug
 2024 15:34:54 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 29 Aug 2024 15:34:53 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v14 10/10] iommu/tegra241-cmdqv: Limit CMDs for VCMDQs of a guest owned VINTF
Date: Thu, 29 Aug 2024 15:34:39 -0700
Message-ID: <8160292337059b91271045800e5c62f7295e2c24.1724970714.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|IA1PR12MB7565:EE_
X-MS-Office365-Filtering-Correlation-Id: 60e8dffd-fae6-4f79-e501-08dcc87ad3ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?belr1NGC4Dntzg5x8UBYtDSXw7K3/ncXlW9dcX2tZTYmXst+PTdoQgbz5w1A?=
 =?us-ascii?Q?/Xl3h6Yd0lI4pbehLMmkerU35MQ5ToHZGgCqLDSv/GspP7Uf3xwPF6VWdPxS?=
 =?us-ascii?Q?2Tsqp2uFwM+7NNMGYlkTqCe1izEZnaSvp0zxKDST08S/654kZEwkAyhgo15i?=
 =?us-ascii?Q?O3sx3DSFIMoYdpoGZjwXCPyBljqcyCVviDnqpLs6Mmp9EtkwQqYTqfh+A1dG?=
 =?us-ascii?Q?rAM8gkwgN9lb1vZtL+xM92Zj1/w09VIVYVtc1KTEQxupHRTnf+FF/gftfjLS?=
 =?us-ascii?Q?BkvzsA/avAi9wI6im7FtfsdGz0iQKRc9fkeUdEcpLou8mW2YbKlheTmBrwQ9?=
 =?us-ascii?Q?5QC91/gHoq3MxkWJnG38jhh5qVg6TJ4NTZ1725PJjPwiA5VYGQopsloQlvUZ?=
 =?us-ascii?Q?LcFUGcD+R58PiYP584ClnNg4ZgRRxUi6qgsKUClXn3fWm488VqjwrY1nApT9?=
 =?us-ascii?Q?z7YO91ZL7qGSidEIZLIXxBkrzbbteTLlxnPy9CzxHdLLDNfJ4bMxN8o8zvjv?=
 =?us-ascii?Q?sQC5vNcrT9jW0/PGLZz+mgT5YlBygKc/LzpNUe2azc2OVFGBZu1Hjb2oy67v?=
 =?us-ascii?Q?BOx9yWGuclPkq+pA/TCU52WJ46H9GxYTMmY8jpmcYoNZSXkSmcyt1n3s6Jkl?=
 =?us-ascii?Q?czDxDCwVG2OERYEHwcXm0Zv25DkYgR40R+CQeyLSxYAXmSVaTKX9p1C7m/yq?=
 =?us-ascii?Q?a5CMVxS5mNGIysPM/Q0FuOGI3lJ6vRFddHOPHa1kuuFcGo4Nm3l2Tgsmg+lC?=
 =?us-ascii?Q?QXsKhF8LR/tU0qbPn+zPR28ANNF+lmvEr2NpZc5ji3dfrfPvvWBZEtxt4rZq?=
 =?us-ascii?Q?4FvyULdNeTpSEOHFx4S5hl+1yl0Pobqv0d29JPQoVDhTdXXapXzuYbzFBOWO?=
 =?us-ascii?Q?F8bOlAibJ8ho+okhuERpNpuEO/+7iSMfEzU9FUu9RHjClzskJu/HXCjL+0ne?=
 =?us-ascii?Q?nw5DyKvUCsfsG7ObvkVlNyA78cjPNNXX43qzyo7Y2g2OkBy2MpD+f4Z2R9IV?=
 =?us-ascii?Q?vpqLW9IrIWLa9LnID7NjLUdwQaJtzo+iKbMC+TTKbgkcAdZldEDCPryA2+N7?=
 =?us-ascii?Q?TXFp6+cjSWzOg6LaVZEz65r7LuO7GdH1jOuujkQo8bcIwaD7y9+X9SfB6dID?=
 =?us-ascii?Q?n9qUrznoWiL//4L0ec2nC8hUhSyd8gPkG3i8RlG7TYj5tLhAlgbIDJHvdRrX?=
 =?us-ascii?Q?+3oAsqtzwldiaYS9dPh5xM5RVmgFopSrg/L1QO/GzgS1XcEv/DehLNe+L8kN?=
 =?us-ascii?Q?TJHJ4R/s4uTGcA+abxhVbYEXqOMkvvKau5QkbZf0qcUpcmBDXtdX4gmHcXNU?=
 =?us-ascii?Q?X+xdRdUcxLvWQZpZaJULOLEc+4HqeYJnHYyHhcwGpjg/cVTooYZioqQkpxCl?=
 =?us-ascii?Q?AYRB8JCktjYQ0PDjjvyReKDNXP8WkNaCDwnjG+Igl6CydXvsACqjo4iB1Q34?=
 =?us-ascii?Q?nN+lTCiopt6EB12R51lvXgGDIG7ychUW?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 22:35:04.1381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e8dffd-fae6-4f79-e501-08dcc87ad3ae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7565

When VCMDQs are assigned to a VINTF owned by a guest (HYP_OWN bit unset),
only TLB and ATC invalidation commands are supported by the VCMDQ HW. So,
implement the new cmdq->supports_cmd op to scan the input cmd in order to
make sure that it is supported by the selected queue.

Note that the guest VM shouldn't have HYP_OWN bit being set regardless of
guest kernel driver writing it or not, i.e. the hypervisor running in the
host OS should wire this bit to zero when trapping a write access to this
VINTF_CONFIG register from a guest kernel.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 28 ++++++++-------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  3 +-
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 34 ++++++++++++++++++-
 3 files changed, 51 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9cd0e8fd78eb..bd05fe6a98ac 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -346,12 +346,13 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 	return 0;
 }
 
-static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
+static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu,
+					       struct arm_smmu_cmdq_ent *ent)
 {
 	struct arm_smmu_cmdq *cmdq = NULL;
 
 	if (smmu->impl_ops && smmu->impl_ops->get_secondary_cmdq)
-		cmdq = smmu->impl_ops->get_secondary_cmdq(smmu);
+		cmdq = smmu->impl_ops->get_secondary_cmdq(smmu, ent);
 
 	return cmdq ?: &smmu->cmdq;
 }
@@ -897,7 +898,7 @@ static int __arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
 	}
 
 	return arm_smmu_cmdq_issue_cmdlist(
-		smmu, arm_smmu_get_cmdq(smmu), cmd, 1, sync);
+		smmu, arm_smmu_get_cmdq(smmu, ent), cmd, 1, sync);
 }
 
 static int arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
@@ -913,10 +914,11 @@ static int arm_smmu_cmdq_issue_cmd_with_sync(struct arm_smmu_device *smmu,
 }
 
 static void arm_smmu_cmdq_batch_init(struct arm_smmu_device *smmu,
-				     struct arm_smmu_cmdq_batch *cmds)
+				     struct arm_smmu_cmdq_batch *cmds,
+				     struct arm_smmu_cmdq_ent *ent)
 {
 	cmds->num = 0;
-	cmds->cmdq = arm_smmu_get_cmdq(smmu);
+	cmds->cmdq = arm_smmu_get_cmdq(smmu, ent);
 }
 
 static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
@@ -931,13 +933,13 @@ static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
 	if (force_sync || unsupported_cmd) {
 		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
 					    cmds->num, true);
-		arm_smmu_cmdq_batch_init(smmu, cmds);
+		arm_smmu_cmdq_batch_init(smmu, cmds, cmd);
 	}
 
 	if (cmds->num == CMDQ_BATCH_ENTRIES) {
 		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
 					    cmds->num, false);
-		arm_smmu_cmdq_batch_init(smmu, cmds);
+		arm_smmu_cmdq_batch_init(smmu, cmds, cmd);
 	}
 
 	index = cmds->num * CMDQ_ENT_DWORDS;
@@ -1205,7 +1207,7 @@ static void arm_smmu_sync_cd(struct arm_smmu_master *master,
 		},
 	};
 
-	arm_smmu_cmdq_batch_init(smmu, &cmds);
+	arm_smmu_cmdq_batch_init(smmu, &cmds, &cmd);
 	for (i = 0; i < master->num_streams; i++) {
 		cmd.cfgi.sid = master->streams[i].id;
 		arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
@@ -2056,7 +2058,7 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
 
 	arm_smmu_atc_inv_to_cmd(ssid, 0, 0, &cmd);
 
-	arm_smmu_cmdq_batch_init(master->smmu, &cmds);
+	arm_smmu_cmdq_batch_init(master->smmu, &cmds, &cmd);
 	for (i = 0; i < master->num_streams; i++) {
 		cmd.atc.sid = master->streams[i].id;
 		arm_smmu_cmdq_batch_add(master->smmu, &cmds, &cmd);
@@ -2071,7 +2073,9 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 	struct arm_smmu_master_domain *master_domain;
 	int i;
 	unsigned long flags;
-	struct arm_smmu_cmdq_ent cmd;
+	struct arm_smmu_cmdq_ent cmd = {
+		.opcode = CMDQ_OP_ATC_INV,
+	};
 	struct arm_smmu_cmdq_batch cmds;
 
 	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_ATS))
@@ -2094,7 +2098,7 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 	if (!atomic_read(&smmu_domain->nr_ats_masters))
 		return 0;
 
-	arm_smmu_cmdq_batch_init(smmu_domain->smmu, &cmds);
+	arm_smmu_cmdq_batch_init(smmu_domain->smmu, &cmds, &cmd);
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_for_each_entry(master_domain, &smmu_domain->devices,
@@ -2176,7 +2180,7 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 			num_pages++;
 	}
 
-	arm_smmu_cmdq_batch_init(smmu, &cmds);
+	arm_smmu_cmdq_batch_init(smmu, &cmds, cmd);
 
 	while (iova < end) {
 		if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 4deb40cfe2e1..4d5af5ac8a63 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -642,7 +642,8 @@ struct arm_smmu_strtab_cfg {
 struct arm_smmu_impl_ops {
 	int (*device_reset)(struct arm_smmu_device *smmu);
 	void (*device_remove)(struct arm_smmu_device *smmu);
-	struct arm_smmu_cmdq *(*get_secondary_cmdq)(struct arm_smmu_device *smmu);
+	struct arm_smmu_cmdq *(*get_secondary_cmdq)(
+		struct arm_smmu_device *smmu, struct arm_smmu_cmdq_ent *ent);
 };
 
 /* An SMMUv3 instance */
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 5ac3032ee6dd..9eb9d959f3e5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -142,6 +142,7 @@ struct tegra241_vcmdq {
  * struct tegra241_vintf - Virtual Interface
  * @idx: Global index in the CMDQV
  * @enabled: Enable status
+ * @hyp_own: Owned by hypervisor (in-kernel)
  * @cmdqv: Parent CMDQV pointer
  * @lvcmdqs: List of logical VCMDQ pointers
  * @base: MMIO base address
@@ -150,6 +151,7 @@ struct tegra241_vintf {
 	u16 idx;
 
 	bool enabled;
+	bool hyp_own;
 
 	struct tegra241_cmdqv *cmdqv;
 	struct tegra241_vcmdq **lvcmdqs;
@@ -301,8 +303,21 @@ static irqreturn_t tegra241_cmdqv_isr(int irq, void *devid)
 
 /* Command Queue Function */
 
+static bool tegra241_guest_vcmdq_supports_cmd(struct arm_smmu_cmdq_ent *ent)
+{
+	switch (ent->opcode) {
+	case CMDQ_OP_TLBI_NH_ASID:
+	case CMDQ_OP_TLBI_NH_VA:
+	case CMDQ_OP_ATC_INV:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static struct arm_smmu_cmdq *
-tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
+tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu,
+			struct arm_smmu_cmdq_ent *ent)
 {
 	struct tegra241_cmdqv *cmdqv =
 		container_of(smmu, struct tegra241_cmdqv, smmu);
@@ -328,6 +343,10 @@ tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
 	vcmdq = vintf->lvcmdqs[lidx];
 	if (!vcmdq || !READ_ONCE(vcmdq->enabled))
 		return NULL;
+
+	/* Unsupported CMD goes for smmu->cmdq pathway */
+	if (!arm_smmu_cmdq_supports_cmd(&vcmdq->cmdq, ent))
+		return NULL;
 	return &vcmdq->cmdq;
 }
 
@@ -406,12 +425,22 @@ static int tegra241_vintf_hw_init(struct tegra241_vintf *vintf, bool hyp_own)
 	tegra241_vintf_hw_deinit(vintf);
 
 	/* Configure and enable VINTF */
+	/*
+	 * Note that HYP_OWN bit is wired to zero when running in guest kernel,
+	 * whether enabling it here or not, as !HYP_OWN cmdq HWs only support a
+	 * restricted set of supported commands.
+	 */
 	regval = FIELD_PREP(VINTF_HYP_OWN, hyp_own);
 	writel(regval, REG_VINTF(vintf, CONFIG));
 
 	ret = vintf_write_config(vintf, regval | VINTF_EN);
 	if (ret)
 		return ret;
+	/*
+	 * As being mentioned above, HYP_OWN bit is wired to zero for a guest
+	 * kernel, so read it back from HW to ensure that reflects in hyp_own
+	 */
+	vintf->hyp_own = !!(VINTF_HYP_OWN & readl(REG_VINTF(vintf, CONFIG)));
 
 	for (lidx = 0; lidx < vintf->cmdqv->num_lvcmdqs_per_vintf; lidx++) {
 		if (vintf->lvcmdqs && vintf->lvcmdqs[lidx]) {
@@ -493,6 +522,9 @@ static int tegra241_vcmdq_alloc_smmu_cmdq(struct tegra241_vcmdq *vcmdq)
 	q->q_base = q->base_dma & VCMDQ_ADDR;
 	q->q_base |= FIELD_PREP(VCMDQ_LOG2SIZE, q->llq.max_n_shift);
 
+	if (!vcmdq->vintf->hyp_own)
+		cmdq->supports_cmd = tegra241_guest_vcmdq_supports_cmd;
+
 	return arm_smmu_cmdq_init(smmu, cmdq);
 }
 
-- 
2.43.0

