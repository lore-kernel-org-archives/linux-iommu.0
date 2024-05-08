Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D4F2C6B9
	for <iommu@lists.linux.dev>; Wed,  8 May 2024 05:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715147847; cv=fail; b=tY3ksz6uY9BygFktTPJxiU3d56vl5jkl487xHJzCtQld433Chc/MhskNz5w7Uv1JMZDBURHRDurOYCjP5kxWmusHbbBlWvmB3Up7bwwW1ubtcCKHLH8wz3/69WHNYmvx+pFAKr+75DjSbEptFqwgrwWxJpPaz4W4dLhgFjadAzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715147847; c=relaxed/simple;
	bh=8rmgsn/Uma5ojKmC+sMeDCfLlWTjZj8yYjm8/xGp7AM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WlqEepR7wjtAosQX1iex5ittGyVIoodJ+BXe04l35V/pxnZ9c9xAw6ANgE60bfJS6AqglveBysx6VI7IvnICEGozjGkS2nILa8e4/9tstmL440vWLH2PeNRnxC6Tm6bl+cG/YR72NgZvmLU4XzAO3VQCIt4umzFH9yWOqUS5G+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HHr7kSCv; arc=fail smtp.client-ip=40.107.220.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HHr7kSCv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0PnJ5rfr4huMIGqmYWH9TcvhkrG/+Nd70UTxxC3vuehehUrop+nww8kdRx67/J3qIMiiRc+hdIpZvss1eDAPpSn5qnmkoUJ9jmoMlmLnQAEPpnIcjeTc24+7E/Jk1B8phPvASCDTsCkQ268B71zDWxisGzlAkovfwlARhixoKnH7DqNlO0tLfRq292SixPsWa2DeVDFLcMtkqcTw5p3XPb6Gs2ovH2CGIxhz+qYXwj2c0irF28Wv30XDReknTUnQ0XKGFCK7ERjP66pljXEvVder5l0fmdI/L8hzIFSGxU6FRb4qTNqFgWCHnXOZY/NGQL/MK0K9Lws0fLUGJdJ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hubAwb42IIzlbX/lZ4P/PVe3PzfTvMzLwajzqQ75kjs=;
 b=FKb4i83w/XbAzmdjQuUl3AaGqxcH1/yCXvGhOHaH3RGQTrU6wpyogsB+zLmeJsIgV0fp4q4tCw8Yl6U4bPVealD7onMwcNe0GMcyP0fNwLFvyvT1clf2tScLaXyd4C6BF48FSmyXjsNyFSBKX3hF0f1GmO9zF+Ki1eZhSkee7dyB2z5+TJb+QWjxgcHzrdFtX7flhFrPh+YU4CCYnhJmmW1ptyMKS2yu3yCZ4BPF+5lpcV8TPxcQ8xCKGGNY/CkNWmWbNwVuhl/xj2RURQy/FekwsR755xm/eakzZYX0jWkLROylY3k9zrKUbARx8twaOnZnrHPpZjwiB+Qe5vknVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hubAwb42IIzlbX/lZ4P/PVe3PzfTvMzLwajzqQ75kjs=;
 b=HHr7kSCvD9KLsH6IBrEXRdprsc2DeUFLoI6GWYEOidt5vA/Y5ajDukIM5VVr8AEzOuZh6Ic4QjozNyXQs9+Lz1V1vo4CkWDPxDMmEvSq3IHxbVdQRCIp/WDf45+U+QsdIAtZinJ8aAXu6TnuIXLkII3e+XDYicGa+2KB+pDsUBvhGbdItka8+q1ZX5LmPk9IoSmxw7PgDW8fAfMCb1wetn86QoIRWuRaDMbTeuYdpvtddHecABcojvHHXARhSDkb5mlcKUXbSC/Ol68Q0prs0/DQEkQAdWb8T435N3RgCNpzyOPV97Xmo+h35j0xDnKKHznlNzY3Y6vjDsBBVdASpA==
Received: from DM6PR06CA0038.namprd06.prod.outlook.com (2603:10b6:5:54::15) by
 MW5PR12MB5599.namprd12.prod.outlook.com (2603:10b6:303:194::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Wed, 8 May
 2024 05:57:22 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:54:cafe::a4) by DM6PR06CA0038.outlook.office365.com
 (2603:10b6:5:54::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45 via Frontend
 Transport; Wed, 8 May 2024 05:57:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 05:57:21 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 May 2024
 22:57:05 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 7 May 2024 22:57:04 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 7 May 2024 22:57:04 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
	<jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: [PATCH v7 6/6] iommu/tegra241-cmdqv: Limit CMDs for guest owned VINTF
Date: Tue, 7 May 2024 22:56:54 -0700
Message-ID: <062cf0a1e2b8ec6f068262cc68498b8d72b04bcc.1715147377.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715147377.git.nicolinc@nvidia.com>
References: <cover.1715147377.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|MW5PR12MB5599:EE_
X-MS-Office365-Filtering-Correlation-Id: dd8457ae-5801-4b26-b006-08dc6f23ba54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W07d5/vOX5OB870IQwkoaBQndbvZ9BTYI3ySjWF4C5sD1QfCNRo5E50yMaI0?=
 =?us-ascii?Q?DNnR5JwAL50L2IJ47uf1wxIH+epKciQNJotbMD80syTkktRC1q503JFWxeGg?=
 =?us-ascii?Q?nw1YF3U2azFwDx2MSxssSDpaMH6cKLNVHxmmZowYTblfYXeaneUpeOVJfqmw?=
 =?us-ascii?Q?HYrJcoGIP65t+mPzv8uWdtiTYZl0PMH6x48d7s/T0EVB5Y3b+sKDq/Dg3MEE?=
 =?us-ascii?Q?g+0tQ3r9OPouHTCjju2Xi63cpe66Q91a9bkBL10M9ti5pu/J/D43m2tpLVwu?=
 =?us-ascii?Q?5Lm5SmDPzl/ESewe4l2HAfWlgbu7yrxflXvPLEbrpzAM0aDNTZC2bA6uNe+a?=
 =?us-ascii?Q?RqPwJmMo3XhZESzA4G71IVLm5ryIfWkaF4FQQnjOpJTxMzEBQc20b2dx7JW1?=
 =?us-ascii?Q?YQiChp7ZdgsjaN8DfFvC88L3Y4dvrrHtGDNLIldJy7Jmt8mGUGglXTYimDQu?=
 =?us-ascii?Q?eZLJix5wC4t4dxvzS99dEdF8/kVC0JJN8QKiLUlIVcHlH1TYEE6vuoYats5f?=
 =?us-ascii?Q?i39PnH2V4lM/GOqaWpI/o72R2rAfSJm7GYHKtTw3G1dMxjTA6AsLRM3ooelV?=
 =?us-ascii?Q?T8Yb0M3HTITQacCAPOPDL5tLnIDdi0pTu1ySy14hje8dI5o+vANJ39EA3GVx?=
 =?us-ascii?Q?nLhWlBa0cg0TjGPh/1c3W4CgepEgH0YBaaVGozDxtli7B5BAHDoOlEYcrIx0?=
 =?us-ascii?Q?YGtprg/Yft0DWmcvLIvpKyUws9M/S9/JrEKJEfGGrQ9ydqRgqvlJ5QaDt6oh?=
 =?us-ascii?Q?paMZsyik4e/kWMZ1Cp+PSZgHEKQuXX6pB+ZnYGspMM6dR4S4eom2IqVTxyXE?=
 =?us-ascii?Q?gXFMxD0cdhSQzES8HvNqgpXt/Dnxlx1wmbAUAbHYMmtz+CvMLXlxqZUy12PF?=
 =?us-ascii?Q?hplpF2P/4HCW150gQAN1tRqBO15703ASKTF2mvwECiRH40P97RxpDBUV8J6e?=
 =?us-ascii?Q?oSfewFaspJpfh3gsT+421YsajGy/s3i5zWwFJXAQNhUojuo73D0uh1MKOLMm?=
 =?us-ascii?Q?fZ2JrR8Zb3YWKdzW2xPFD7Dllal7TUcQDQ5+WYlqhuy5wUrkAwquEOV14rvp?=
 =?us-ascii?Q?+46mxiIuWvZGYdggWgPrWku9HZ1VUmyYFI9SumhBd59EIhZgWCPhsMqlSQHD?=
 =?us-ascii?Q?MYjEpP+nhDLJH10TQAZfbywn3Q2zrBw3EICcQT6cIKR3u0Myqb36PPZfXVC5?=
 =?us-ascii?Q?lwQFXTsUdEvuC5uLRm9EYpm7zW6X+r8ruHiX6SQ8Pp5tjeJE78FgOojAa40b?=
 =?us-ascii?Q?zJYO65hywI2ERJnGt0nIf+LBU2eG8QOpVmO3gV+TylLZMyPwQKDOxo12mwuU?=
 =?us-ascii?Q?CaAR6QnUcaEy+5cA1aNnpQGRxjS9DKpfmVitYF+me+yrpTPmJh1JQ1pYIWB+?=
 =?us-ascii?Q?Hq4ST90dHUkhsYZd8qn2HUMhxWdj?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 05:57:21.9012
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8457ae-5801-4b26-b006-08dc6f23ba54
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5599

When VCMDQs are assigned to a VINTF owned by a guest (HYP_OWN bit unset),
only TLB and ATC invalidation commands are supported by the VCMDQ HW. So,
add a new helper to scan the input cmd to make sure it is supported when
selecting a queue.

Note that the guest VM shouldn't have HYP_OWN bit being set regardless of
guest kernel driver writing it or not, i.e. the hypervisor running in the
host OS should wire this bit to zero when trapping a write access to this
VINTF_CONFIG register from a guest kernel.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 20 ++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  5 +--
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 36 ++++++++++++++++++-
 3 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d1098991d64e..baf20e9976d3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -332,10 +332,11 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 	return 0;
 }
 
-static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
+static struct arm_smmu_cmdq *
+arm_smmu_get_cmdq(struct arm_smmu_device *smmu, u8 opcode)
 {
 	if (arm_smmu_has_tegra241_cmdqv(smmu))
-		return tegra241_cmdqv_get_cmdq(smmu);
+		return tegra241_cmdqv_get_cmdq(smmu, opcode);
 
 	return &smmu->cmdq;
 }
@@ -871,7 +872,7 @@ static int __arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
 	}
 
 	return arm_smmu_cmdq_issue_cmdlist(
-		smmu, arm_smmu_get_cmdq(smmu), cmd, 1, sync);
+		smmu, arm_smmu_get_cmdq(smmu, ent->opcode), cmd, 1, sync);
 }
 
 static int arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
@@ -887,10 +888,11 @@ static int arm_smmu_cmdq_issue_cmd_with_sync(struct arm_smmu_device *smmu,
 }
 
 static void arm_smmu_cmdq_batch_init(struct arm_smmu_device *smmu,
-				     struct arm_smmu_cmdq_batch *cmds)
+				     struct arm_smmu_cmdq_batch *cmds,
+				     u8 opcode)
 {
 	cmds->num = 0;
-	cmds->cmdq = arm_smmu_get_cmdq(smmu);
+	cmds->cmdq = arm_smmu_get_cmdq(smmu, opcode);
 }
 
 static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
@@ -1167,7 +1169,7 @@ static void arm_smmu_sync_cd(struct arm_smmu_master *master,
 		},
 	};
 
-	arm_smmu_cmdq_batch_init(smmu, &cmds);
+	arm_smmu_cmdq_batch_init(smmu, &cmds, cmd.opcode);
 	for (i = 0; i < master->num_streams; i++) {
 		cmd.cfgi.sid = master->streams[i].id;
 		arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
@@ -2006,7 +2008,7 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
 
 	arm_smmu_atc_inv_to_cmd(IOMMU_NO_PASID, 0, 0, &cmd);
 
-	arm_smmu_cmdq_batch_init(master->smmu, &cmds);
+	arm_smmu_cmdq_batch_init(master->smmu, &cmds, cmd.opcode);
 	for (i = 0; i < master->num_streams; i++) {
 		cmd.atc.sid = master->streams[i].id;
 		arm_smmu_cmdq_batch_add(master->smmu, &cmds, &cmd);
@@ -2046,7 +2048,7 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 
 	arm_smmu_atc_inv_to_cmd(ssid, iova, size, &cmd);
 
-	arm_smmu_cmdq_batch_init(smmu_domain->smmu, &cmds);
+	arm_smmu_cmdq_batch_init(smmu_domain->smmu, &cmds, cmd.opcode);
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
@@ -2123,7 +2125,7 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 			num_pages++;
 	}
 
-	arm_smmu_cmdq_batch_init(smmu_domain->smmu, &cmds);
+	arm_smmu_cmdq_batch_init(smmu_domain->smmu, &cmds, cmd->opcode);
 
 	while (iova < end) {
 		if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 604e26a292e7..2c1fe7e129cd 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -879,7 +879,8 @@ struct tegra241_cmdqv *tegra241_cmdqv_acpi_probe(struct arm_smmu_device *smmu,
 						 struct acpi_iort_node *node);
 void tegra241_cmdqv_device_remove(struct arm_smmu_device *smmu);
 int tegra241_cmdqv_device_reset(struct arm_smmu_device *smmu);
-struct arm_smmu_cmdq *tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu);
+struct arm_smmu_cmdq *tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu,
+					      u8 opcode);
 #else /* CONFIG_TEGRA241_CMDQV */
 static inline bool arm_smmu_has_tegra241_cmdqv(struct arm_smmu_device *smmu)
 {
@@ -903,7 +904,7 @@ static inline int tegra241_cmdqv_device_reset(struct arm_smmu_device *smmu)
 }
 
 static inline struct arm_smmu_cmdq *
-tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
+tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu, u8 opcode)
 {
 	return NULL;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index ec4767e3859e..e7a281131e5d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -181,6 +181,7 @@ struct tegra241_vcmdq {
  * struct tegra241_vintf - Virtual Interface
  * @idx: Global index in the CMDQV
  * @enabled: Enable status
+ * @hyp_own: Owned by hypervisor (in-kernel)
  * @cmdqv: Parent CMDQV pointer
  * @lvcmdqs: List of logical VCMDQ pointers
  * @base: MMIO base address
@@ -189,6 +190,7 @@ struct tegra241_vintf {
 	u16 idx;
 
 	bool enabled;
+	bool hyp_own;
 
 	struct tegra241_cmdqv *cmdqv;
 	struct tegra241_vcmdq **lvcmdqs;
@@ -326,7 +328,25 @@ static irqreturn_t tegra241_cmdqv_isr(int irq, void *devid)
 
 /* Command Queue Selecting Function */
 
-struct arm_smmu_cmdq *tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
+static bool tegra241_vintf_support_cmd(struct tegra241_vintf *vintf, u8 opcode)
+{
+       /* Hypervisor-owned VINTF can execute any command in its VCMDQs */
+	if (READ_ONCE(vintf->hyp_own))
+		return true;
+
+	/* Guest-owned VINTF must Check against the list of supported CMDs */
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
+struct arm_smmu_cmdq *tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu,
+					      u8 opcode)
 {
 	struct tegra241_cmdqv *cmdqv = smmu->tegra241_cmdqv;
 	struct tegra241_vintf *vintf = cmdqv->vintfs[0];
@@ -340,6 +360,10 @@ struct arm_smmu_cmdq *tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
 	if (!READ_ONCE(vintf->enabled))
 		return &smmu->cmdq;
 
+	/* Unsupported CMD go for smmu->cmdq pathway */
+	if (!tegra241_vintf_support_cmd(vintf, opcode))
+		return &smmu->cmdq;
+
 	/*
 	 * Select a LVCMDQ to use. Here we use a temporal solution to
 	 * balance out traffic on cmdq issuing: each cmdq has its own
@@ -432,12 +456,22 @@ static int tegra241_vintf_hw_init(struct tegra241_vintf *vintf, bool hyp_own)
 	tegra241_vintf_hw_deinit(vintf);
 
 	/* Configure and enable VINTF */
+	/*
+	 * Note that HYP_OWN bit is wired to zero when running in guest kernel,
+	 * whether enabling it here or not, as !HYP_OWN cmdq HWs only support a
+	 * restricted set of supported commands.
+	 */
 	regval = FIELD_PREP(VINTF_HYP_OWN, hyp_own);
 	vintf_writel(vintf, regval, CONFIG);
 
 	ret = vintf_write_config(vintf, regval | VINTF_EN);
 	if (ret)
 		return ret;
+	/*
+	 * As being mentioned above, HYP_OWN bit is wired to zero for a guest
+	 * kernel, so read it back from HW to ensure that reflects in hyp_own
+	 */
+	vintf->hyp_own = !!(VINTF_HYP_OWN & vintf_readl(vintf, CONFIG));
 
 	for (lidx = 0; lidx < vintf->cmdqv->num_lvcmdqs_per_vintf; lidx++) {
 		if (vintf->lvcmdqs && vintf->lvcmdqs[lidx]) {
-- 
2.43.0

