Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF73191476
	for <iommu@lists.linux.dev>; Wed,  7 Aug 2024 02:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722996752; cv=fail; b=Xg/V921S7KKc+JWn9q+QO9bTH0eptHjfTRZP0HBLh74m7BOm1Nv51lgVDrK9NVZHxXoL9D4wJ8EsVAXq0QU/6pWdVt+D2vxBb61vEJEmQc7ZUadrtrx9k2YrYCwuRnZtURmoW3bPCeMXOG5LE8iguOdUg6asfeBgfU3bVLBBeR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722996752; c=relaxed/simple;
	bh=IZ5JTqVCgypSWHwf4Zzu1bGCNuC+QEpQ6F6AMwpGqT4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C0tgQuRww+HwQ0IJfIyVAja2ub3WPkca+9cnfzgP3SXX4JAGmQ8oT9w7pkO8MBCHh2jgCvp1SrtdnWSVv4FbkTTavGgjMtMGc9EomennTv7nR7UYDHVIpjCR0L4pFNYntJAxLWlMBYCHDlRxYXPASZU4b5PMPXEGtCY/u6rULFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SBCEpVFF; arc=fail smtp.client-ip=40.107.92.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SBCEpVFF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L98TkQrQ3uQlKXbpgAsmItEgXym02C6L7kT8qnKd46Z1K7dhyopgRS6W3diReK4Kr98LSVaD2fzYA5Vijt6/kIeQFGsPmvC5x/Pu/aQcqV+6en3c2kYcpHfi1gMyTAt8wp52LN8Fy6ZPsFw5XFpCHvx2SCqA7n1KCCCrRYGl1VlE9A6IE/K8behEBeqC7nfV61LnxIdO0yG9bYZ17dyZ27vq5M9saF7bTBmUy6jc5B2DQOHHaas/L0WM0mR/1f/P5wOk9Ovjfu6V3L0yG8wpS4wqfSSHUTPDuU2MsNhtBlpF/yDm28XMPDfE88RDnFYIkH92qjuvehjVFlKJknAYYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrpYVZQgaJzBIbY7T5XauWjoxxatf5Mp4XTTwRlRP/s=;
 b=ZG89IacdP7QN5YJfxtuxPpcd9AV4FbSW2dQpVWxut46qmmsQKTc1l8wqN9oHKP8juUbWRbsK1G6dJtDRMYG4YiOTvV7WfOJW7bNZ/Jok5dFoJfMg8hNk3CZqum77oKSupFX2zX1wcpdSReaJf4BY8B8/xtjWZdmyqEfiAqtAtIk2sPpNkDViMJ0y3YD9XBObznFtagfb1ztsY7sZSCQ07rM4MaUGuooyYTCL6oDpWPcrNNWkKXHgBo26lp0mEpIpaZ3Frmx3H9HjYMxNIhEZ7wchTRr+nwSLXSb0dMtxhHsUl2r++/tdXKsVHvMF2+gg7iL7PAjthR7yYTPGvIB23g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrpYVZQgaJzBIbY7T5XauWjoxxatf5Mp4XTTwRlRP/s=;
 b=SBCEpVFFnLObtqPuROb78rCgTgJJsGKjomB9cz3ATyK44BhNwtsViaPPvd5Y3/1Wn2PqwyZf7jU0EP5Mcvg64wzzHJ8quNnK7vDxj5gaK9OdCVNccQCVyn2cv9yuF0HYtb2j8p+3eBxKC64XPRnCzAI8QaOe+DyCNfCHnrJ/kQXK+I1i1lnDdcJOjDJhisdhYPR0S/DyufzzPHlcCqR0kVAvm2vT/CeS81GABHu1TXrIgymGNf6bfeEohTUYH4EJOl/1PTh1EoVjDfHWDqKSL97BCwFlIodYlQyd7xUzYCcKRIO42wGn9UE8dmjgN1HuNCgrGKZtH0z+r6hv2irdhQ==
Received: from PH7PR10CA0016.namprd10.prod.outlook.com (2603:10b6:510:23d::8)
 by IA0PR12MB8862.namprd12.prod.outlook.com (2603:10b6:208:48e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.25; Wed, 7 Aug
 2024 02:12:25 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:510:23d:cafe::76) by PH7PR10CA0016.outlook.office365.com
 (2603:10b6:510:23d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13 via Frontend
 Transport; Wed, 7 Aug 2024 02:12:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Wed, 7 Aug 2024 02:12:25 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 19:12:08 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 19:12:07 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 6 Aug 2024 19:12:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v11 9/9] iommu/tegra241-cmdqv: Limit CMDs for guest owned VINTF
Date: Tue, 6 Aug 2024 19:11:54 -0700
Message-ID: <153fb887cf4bf6318c6f313a4be9b40a25a24e7d.1722993435.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|IA0PR12MB8862:EE_
X-MS-Office365-Filtering-Correlation-Id: 77224e20-6fc4-4563-779f-08dcb6866141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xfqEr86p82Pyei4DOExo1qLb7XeSnUEK58nZUiZAUiuehJDbAckd8nlBG03u?=
 =?us-ascii?Q?I3HIUEvja0xxrEDkI8ot7mChpXqn4+unlrmZ54DHq78NwjsLSi001n9WVF0n?=
 =?us-ascii?Q?wG/xrDYyAqkC68PVgVT5HlIh336hFqlvzi8M5iFgzbM4mFvtXMUciKoyKZRj?=
 =?us-ascii?Q?qzIYZ4aXDXEVKLBK5RMi5Wi2bz3y4rrgqom2CmjjBt5Hxc6aD4AKgdGlxi5z?=
 =?us-ascii?Q?nSTIZhPvune4+8Hwxgm69/yXZQSGYCGIZzWi1M6nYzY5+KtJjSYndCDXQQ/f?=
 =?us-ascii?Q?Ib+GI1doyEUIh9xwdqIhB3MX39uR2gNfiIA73U9efXTz4TtSqJenEev/Jjcj?=
 =?us-ascii?Q?tRFsyG80Kif0TPixNkSY7ZOejbBnqZBHyDQzMhTXjxYFGAntihHd/MDdToU0?=
 =?us-ascii?Q?s0xD95gsyOlcGd7pkNX0LBfGR8gVdBByLifqqxX9rEhs4eF7+TXTL8b7mpA4?=
 =?us-ascii?Q?/ylOmNyDB7pGjFtU7s/wDTlVoQJPIdtUH8EAfn69C/RhbZvxVPE9gcvsR5g5?=
 =?us-ascii?Q?DavZoyqZtDm4qZwJqvDpbTicwqVZK4xvnMXD5Sh4OjEtSIX5vitNhsSvVTjM?=
 =?us-ascii?Q?uVAP5jM0akHRzVJr5kTTjWlB7cpoKU/Y0l1yQsuGz6f8egrslJzkV2b/i3Ah?=
 =?us-ascii?Q?UdMu8S+fftpIyR+W971beGMmoXn3krju9AIwQO2k051su3Q9wvvvfBly6/Kh?=
 =?us-ascii?Q?o28Rl9Hu8d24FrAvHQ29MmVQ9NE5iF2lguSqWDY2RXug0ocSOzQavON3/aMU?=
 =?us-ascii?Q?W7rmWpq9WGIdC1cF8LOEXRtq9W8j3uyzSl5EIyiIvQmLHr4LElAn+LiICOje?=
 =?us-ascii?Q?dIm/65JvxTGADz3t/omo2D3lp/DiF2Ht/DGktMHm/t15LmPv4J1ulXyipQTB?=
 =?us-ascii?Q?9RpCIuYE0GJUWHuyokA080Tczujp7P2OWqGZIr5kGYIx+Kp7hmZ0mTM06r8S?=
 =?us-ascii?Q?YWu11g158d3+4rvqupHuyesun7zjV/B0+jCflXHsZQb0dsG+b8pRAa2THQ38?=
 =?us-ascii?Q?9HqiiZyhQVAve/Xi5iD2H+9MTyCA1EH5xjlE0BMFEXfNC5JISA63loxTvALo?=
 =?us-ascii?Q?XJgpPcwXddIB2WRZQz7ZZuE6U0WrrneXcETXqx/uKr1LioHwy4GsLV77DGQ+?=
 =?us-ascii?Q?q5yyxUY1/VClVec3vpN0JR93T7efrn8vGC9pvEI50B1qY06+LPpnDH92g6P3?=
 =?us-ascii?Q?QlPB3QMU9KnYzErN7BTU6AeeSw1T1BAn2t2zGhGg+ar3sTSTj/caoAmZ3TXC?=
 =?us-ascii?Q?qTbvT3j/ivLdzeh/hRqCZPnHjyo9NrwmucpVxAUbwSC+Eg2krpuQAweGIKKv?=
 =?us-ascii?Q?eLpiwIRYCQMaPLFqo7okQZZyCAefAr8o46ldEX0DWGvFD8+wRTbVkp6UeUYF?=
 =?us-ascii?Q?SAmIWlj26FgiTSt+KG9iZsqxPj9xd1hf1MIkCjHoYBeQWGueTDlRAnfJzg1J?=
 =?us-ascii?Q?YZdF1xEBgwU2iMYWSjLwN9Auzn2gjDx/?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 02:12:25.1914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77224e20-6fc4-4563-779f-08dcb6866141
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8862

When VCMDQs are assigned to a VINTF owned by a guest (HYP_OWN bit unset),
only TLB and ATC invalidation commands are supported by the VCMDQ HW. So,
add a new helper to scan the input cmd to make sure it is supported when
selecting a queue, though this assumes that SMMUv3 driver will only add
the same type of commands into an arm_smmu_cmdq_batch as it does today.

Note that the guest VM shouldn't have HYP_OWN bit being set regardless of
guest kernel driver writing it or not, i.e. the hypervisor running in the
host OS should wire this bit to zero when trapping a write access to this
VINTF_CONFIG register from a guest kernel.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 22 +++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  3 +-
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 35 ++++++++++++++++++-
 3 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 18d940c65e2c..8ff8e264d5e7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -336,12 +336,13 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 	return 0;
 }
 
-static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
+static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu,
+					       u8 opcode)
 {
 	struct arm_smmu_cmdq *cmdq = NULL;
 
 	if (smmu->impl && smmu->impl->get_secondary_cmdq)
-		cmdq = smmu->impl->get_secondary_cmdq(smmu);
+		cmdq = smmu->impl->get_secondary_cmdq(smmu, opcode);
 
 	return cmdq ?: &smmu->cmdq;
 }
@@ -889,7 +890,7 @@ static int __arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
 	}
 
 	return arm_smmu_cmdq_issue_cmdlist(
-		smmu, arm_smmu_get_cmdq(smmu), cmd, 1, sync);
+		smmu, arm_smmu_get_cmdq(smmu, ent->opcode), cmd, 1, sync);
 }
 
 static int arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
@@ -905,10 +906,13 @@ static int arm_smmu_cmdq_issue_cmd_with_sync(struct arm_smmu_device *smmu,
 }
 
 static void arm_smmu_cmdq_batch_init(struct arm_smmu_device *smmu,
-				     struct arm_smmu_cmdq_batch *cmds)
+				     struct arm_smmu_cmdq_batch *cmds,
+				     u8 opcode)
 {
+	WARN_ON_ONCE(!opcode);
+
 	cmds->num = 0;
-	cmds->cmdq = arm_smmu_get_cmdq(smmu);
+	cmds->cmdq = arm_smmu_get_cmdq(smmu, opcode);
 }
 
 static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
@@ -1195,7 +1199,7 @@ static void arm_smmu_sync_cd(struct arm_smmu_master *master,
 		},
 	};
 
-	arm_smmu_cmdq_batch_init(smmu, &cmds);
+	arm_smmu_cmdq_batch_init(smmu, &cmds, CMDQ_OP_CFGI_CD);
 	for (i = 0; i < master->num_streams; i++) {
 		cmd.cfgi.sid = master->streams[i].id;
 		arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
@@ -2046,7 +2050,7 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
 
 	arm_smmu_atc_inv_to_cmd(ssid, 0, 0, &cmd);
 
-	arm_smmu_cmdq_batch_init(master->smmu, &cmds);
+	arm_smmu_cmdq_batch_init(master->smmu, &cmds, CMDQ_OP_ATC_INV);
 	for (i = 0; i < master->num_streams; i++) {
 		cmd.atc.sid = master->streams[i].id;
 		arm_smmu_cmdq_batch_add(master->smmu, &cmds, &cmd);
@@ -2084,7 +2088,7 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 	if (!atomic_read(&smmu_domain->nr_ats_masters))
 		return 0;
 
-	arm_smmu_cmdq_batch_init(smmu_domain->smmu, &cmds);
+	arm_smmu_cmdq_batch_init(smmu_domain->smmu, &cmds, CMDQ_OP_ATC_INV);
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_for_each_entry(master_domain, &smmu_domain->devices,
@@ -2166,7 +2170,7 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 			num_pages++;
 	}
 
-	arm_smmu_cmdq_batch_init(smmu, &cmds);
+	arm_smmu_cmdq_batch_init(smmu, &cmds, cmd->opcode);
 
 	while (iova < end) {
 		if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 367f5e160af4..c7f34a5c31f3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -633,7 +633,8 @@ struct arm_smmu_strtab_cfg {
 struct arm_smmu_impl {
 	int (*device_reset)(struct arm_smmu_device *smmu);
 	void (*device_remove)(struct arm_smmu_device *smmu);
-	struct arm_smmu_cmdq *(*get_secondary_cmdq)(struct arm_smmu_device *smmu);
+	struct arm_smmu_cmdq *(*get_secondary_cmdq)(struct arm_smmu_device *smmu,
+			       u8 opcode);
 };
 
 #ifdef CONFIG_TEGRA241_CMDQV
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index c1e85c95fb99..c20e54aeec99 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -144,6 +144,7 @@ struct tegra241_vcmdq {
  * struct tegra241_vintf - Virtual Interface
  * @idx: Global index in the CMDQV
  * @enabled: Enable status
+ * @hyp_own: Owned by hypervisor (in-kernel)
  * @cmdqv: Parent CMDQV pointer
  * @lvcmdqs: List of logical VCMDQ pointers
  * @base: MMIO base address
@@ -152,6 +153,7 @@ struct tegra241_vintf {
 	u16 idx;
 
 	bool enabled;
+	bool hyp_own;
 
 	struct tegra241_cmdqv *cmdqv;
 	struct tegra241_vcmdq **lvcmdqs;
@@ -301,8 +303,25 @@ static irqreturn_t tegra241_cmdqv_isr(int irq, void *devid)
 
 /* Command Queue Function */
 
+static bool tegra241_vintf_support_cmd(struct tegra241_vintf *vintf, u8 opcode)
+{
+       /* Hypervisor-owned VINTF can execute any command in its VCMDQs */
+	if (READ_ONCE(vintf->hyp_own))
+		return true;
+
+	/* Guest-owned VINTF must check against the list of supported CMDs */
+	switch (opcode) {
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
+tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu, u8 opcode)
 {
 	struct tegra241_cmdqv *cmdqv =
 		container_of(smmu, struct tegra241_cmdqv, smmu);
@@ -317,6 +336,10 @@ tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
 	if (!READ_ONCE(vintf->enabled))
 		return NULL;
 
+	/* Unsupported CMD go for smmu->cmdq pathway */
+	if (!tegra241_vintf_support_cmd(vintf, opcode))
+		return NULL;
+
 	/*
 	 * Select a LVCMDQ to use. Here we use a temporal solution to
 	 * balance out traffic on cmdq issuing: each cmdq has its own
@@ -406,12 +429,22 @@ static int tegra241_vintf_hw_init(struct tegra241_vintf *vintf, bool hyp_own)
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
-- 
2.43.0

