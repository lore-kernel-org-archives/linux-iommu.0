Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588A32C859
	for <iommu@lists.linux.dev>; Sat, 24 Aug 2024 00:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724458283; cv=fail; b=j7H5DdpOc13xvFJKcMTA13PveVqqFHtIk5fV7/3s7+RvG3mH8WMyc7XyH2sm2mSEBzA6D7B+J3mWPvwbbu2eBHbBs2leUbWhAbWVPaDUr0Wl77gYdICTIGZX+0hudARu0F0W/2KylikNN3gz6Eb7y6KbgEQ53wjx2gOyhXdLi/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724458283; c=relaxed/simple;
	bh=VMWXF5drFTjxQgSyisptpIGoIh2VfBzw+vIXdsYfTqs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EQNX7ufTznhYy8i2aHG4iNUBNdEyl8XBsNY7KlELaU/Aj8zTZQQA8L7w1xTI0G+xLSikVvzEvUz9QykV9Jx6zx+GzDz2W//O5L04cxAOUW2sU7G7qxqnuzKEMnV7wFaTi5H0bq3mkyyjv2VuvBbWc73XvUJ6zfV0ricGYtQo/SQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sv2NRxIV; arc=fail smtp.client-ip=40.107.220.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sv2NRxIV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UL4sBkVxp75M0e+//CEt+mnMhkxMWpQCewHcXK0eyhigMm/yNzQPrntlYCGzsW3YZwEuTWlVH1lBhR+aaxp+jjMzPeHtr56RI2mi2VLvR8BRUp0jbHyf21/S69E2zAdTRgGAL/oEDyVzktlf4LmJG89rtl3j+iHm3nU3wgdKxLcOdK608UuIvPqyWVi3wOSOFIb4ow0afhlhL4905uRZGWpc90+bfumy9CNPhTmCmxOKRSvNQ9EwIzpZVf/5SFONdDfoyJnpHGnmtdj6GbaDsCq8O9NHcyfYfmTcDu4Q837RW3DEYiFF15p1m+r0LmgXFqAdKUUdrb48kXJIsP8whg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAzs7luOvMp+fPl0Ilj5cRodaPlWPrtJPo81FMnxo3I=;
 b=b0oYxwpG6VQqn7af70gZxklbIXD4olZzdIl3uvoam8+hM8bHKeXTp5JYvymoG9MnCL9+woDyAidZLBdAEg+I2uATvgY/D0INBZK1FKrsiZQ+lifDijayISEY0yrF07KRRzKvWfGThYX8wh4vYLeXesSfvSzRaFEUyigNRaKOnfoA5EnQSR3wEqUBbsGF5C/66iu5Im6P4yJRGC8ptysDzVdshyG4kHduVhx5GyaPg0PLTFUdYgUkMVzp8mg3u/GP3vwfco/t4cxPBzGRPILMdGVuGGyNW5t/QeERMeilFgMZrzqp3D8l7S6+DGDQteLk5WQZUvKwHhQp1GeeTUjO3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAzs7luOvMp+fPl0Ilj5cRodaPlWPrtJPo81FMnxo3I=;
 b=Sv2NRxIVRBtw2afZ1874EcDkfYocYd2XZBkhYzuD1cqUvhjvrDxpRhWipEb4zly7cmIWDVi9eKOHOprElLSAqGXOyFSFTLOwd0IybndLZ4bCLvwRotrQJO7L41HvORejIF8VEdm6Bsfyg81asHedVwWTun41HBAznpnJq3WZ5a+tuonFVP3JKGZfeReVqlxLfI9YNPc0FzwEbdFAyR+vaG84v0XgvdpJuIe2ucCKRwUHhb5rZ7F/W7fxljSSpk3I4H0BZrl8q0MZ39SHOCGYTaWOtdDvP/Zw7bzyOw6EulhN97mjeKl3ltiPSC80lBokwxDh3qPLvoQeEU2hBhqbgA==
Received: from CH0P221CA0038.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::24)
 by PH7PR12MB8595.namprd12.prod.outlook.com (2603:10b6:510:1b5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Sat, 24 Aug
 2024 00:11:16 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::3a) by CH0P221CA0038.outlook.office365.com
 (2603:10b6:610:11d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Sat, 24 Aug 2024 00:11:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Sat, 24 Aug 2024 00:11:16 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 17:10:59 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 17:10:59 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 Aug 2024 17:10:58 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v13 10/10] iommu/tegra241-cmdqv: Limit CMDs for VCMDQs of a guest owned VINTF
Date: Fri, 23 Aug 2024 17:10:44 -0700
Message-ID: <88516ae4d03cd37033957f7ddd9707aa4a3cce65.1724453781.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|PH7PR12MB8595:EE_
X-MS-Office365-Filtering-Correlation-Id: 86dfe51b-41ad-4f91-6712-08dcc3d14593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K9pNIcccNFaW1eYmgZc2ORj1X+YsmeQChP+R/shn/ERvwVLehVnIfR7ZiGlT?=
 =?us-ascii?Q?ym2H//ryoHr+WoczOfBK5bFYkusLWzZmuPEptxJdMoW15B2UXPGxd/+tgqTo?=
 =?us-ascii?Q?R1pK78kFJtae7BqT5s9zZZ4D3JxF9LAzyBu7q+DQCOF9s1OQwvr8EFIUcvMi?=
 =?us-ascii?Q?7xnl0Gpn2pfSVjCltIX4rzhRgIezlDqacQoYFM7i4mk249mBcY5PLfm16oz1?=
 =?us-ascii?Q?dT2iZlE2JHCojignQ8TGfAmlodSlzJ+7kGx3nW1uM+tTKDz3IuVki3O9eg3t?=
 =?us-ascii?Q?FxXKyLu+toqy16F4lannIzhKPo/jwBTQMJaHmzua+DANE0Le+AS0wxU9FJfW?=
 =?us-ascii?Q?vG7Uis4JgbHqO2LEhosyAbcix9wkHb0z+G/bWdP9dvoH1QrwEujf82elBc5g?=
 =?us-ascii?Q?Y3nZrEOl691awuJ/g/QQSnLC81WJ0uqeo8hEb9+lLDpU+OGmSZrkI4ERcaBc?=
 =?us-ascii?Q?4b62Wobkkw0H9X0F/IvevnNQ9Su5vnXqaaeJADt/0tzNJD4pfjjdWLfn+GRh?=
 =?us-ascii?Q?LwcDjuMIsAyv4hNX02JpgxCZCMQ89uDbkDmHS9gZSHZiRhCkGiHt7T9QS9xF?=
 =?us-ascii?Q?5Ycn3jAduJdOwjM05r19wvWag3T4JOSWZ22OX+JaXdXPmQS0Wa6lGSJCNU5k?=
 =?us-ascii?Q?2teJBXj+1khNnBH479zXV3JJoBZ+Rqvw61um0A0ehqX19KwidESLzukU5cOw?=
 =?us-ascii?Q?MwkpWPM7ReBMMbR2k7MIYSBWSTeq94opn222Waoui24o5HW896z1VF00xBec?=
 =?us-ascii?Q?L5Z+l0EDJDNP57RcC94RwJnMtZsBniqT9UDzyXgO1bvl15iI1Hf4tonnjX5r?=
 =?us-ascii?Q?u1tJkrbxO+TjMcnue7v7k2Q4H2tX7GuorBptQRK1zwBcFf7FN1as8UbftWm0?=
 =?us-ascii?Q?X9dv2udaRiAcnClgQ/xo7snCsh5x3XlAhnL7tTMMAC6Y7B7Udf45HmvRmrwr?=
 =?us-ascii?Q?jZMwLZgVMP+AXFt+NmUQn3C6CqQSmpYvyiarbZNra8XpWtcQNKCygRAeWNa/?=
 =?us-ascii?Q?C+D/GXfjE4f5U+TWTcPHVQ718RuAuSkGGeZB0HEsFLuIcT9LxQEZBQsDAWaU?=
 =?us-ascii?Q?9KP105ocluoZKcdLDYWZNddjfPeNfi1adpatbqcwJaro0ollPQ3C0lLyYEzQ?=
 =?us-ascii?Q?WX4A5t+fanio61KKwPl8m126+8JLs8p53ePpbjmcdTeuOgVVwWkCfL+eXA5m?=
 =?us-ascii?Q?eysOivrUmMss5F0brKGsjvg6E0jByIcEZuWpo3bcBplaAyljLuhQS0R9PCVD?=
 =?us-ascii?Q?7gwTY/0/Ma8CmsXQxXBAkQ8ThR7DFHerjeMqevPzsvcjZf02SuCxr9pPROcs?=
 =?us-ascii?Q?XrQbBRIGU2EYv3H+smK3yYlVo/ElfX6yFrpHHIKwCRt1V6bLdYHQor/uJ60C?=
 =?us-ascii?Q?P5NGnu9oBy4C+xpzN0FrpZuAVL1T084cmuRy7JrUiMQus1DOsDMG4bo89goz?=
 =?us-ascii?Q?2OsR9oDhDLqUmeUXIyVP9Ece5pq77VZM?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2024 00:11:16.0918
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86dfe51b-41ad-4f91-6712-08dcc3d14593
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8595

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
index 40dc5b9afa00..7e4359181094 100644
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
index d4e5a22408e3..003330b23946 100644
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
index b794a4dcbce1..1846bbd0df59 100644
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
@@ -300,8 +302,21 @@ static irqreturn_t tegra241_cmdqv_isr(int irq, void *devid)
 
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
@@ -327,6 +342,10 @@ tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
 	vcmdq = vintf->lvcmdqs[lidx];
 	if (!vcmdq || !READ_ONCE(vcmdq->enabled))
 		return NULL;
+
+	/* Unsupported CMD goes for smmu->cmdq pathway */
+	if (!arm_smmu_cmdq_supports_cmd(&vcmdq->cmdq, ent))
+		return NULL;
 	return &vcmdq->cmdq;
 }
 
@@ -405,12 +424,22 @@ static int tegra241_vintf_hw_init(struct tegra241_vintf *vintf, bool hyp_own)
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
@@ -492,6 +521,9 @@ static int tegra241_vcmdq_alloc_smmu_cmdq(struct tegra241_vcmdq *vcmdq)
 	q->q_base = q->base_dma & VCMDQ_ADDR;
 	q->q_base |= FIELD_PREP(VCMDQ_LOG2SIZE, q->llq.max_n_shift);
 
+	if (!vcmdq->vintf->hyp_own)
+		cmdq->supports_cmd = tegra241_guest_vcmdq_supports_cmd;
+
 	return arm_smmu_cmdq_init(smmu, cmdq);
 }
 
-- 
2.43.0

