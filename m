Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BFF190077
	for <iommu@lists.linux.dev>; Wed,  7 Aug 2024 02:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722996745; cv=fail; b=GZvaZrp7xUUv/6tMma5B0zXD88KbM/+i5SMH29CLwmXJaUUm6l0R2CotXVjP+OxLqbDfLNMdSLcZBwXHyFz3lxncDGQaC4IKTL3er6YCR1flVZ4+UAYo4ZHWik/sHGkwDOG4XqvMYPjJ81gOxNDYlmafO1Ij6cdq6ggcvFDZhq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722996745; c=relaxed/simple;
	bh=mm9qShw1OpGuRfsK0+zQq3ap6LNaPDVAdVJnhmmhNYc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WJOn1POxW7eGgqCim0KFgnk+FQegKv/gRBtbkrxLFKsPjSgQemVZXfmNU4gctgqnvR4QuL7tifGgRwFH9VBpoVjZXDSGQ6vRhAE80NOTARmbRaJJV/hBpFdi7VlCaC3ftCCQaTEjyzJI1zHFdKnS07RLYXEugISUKJ0HDQdriZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q3ChGv0p; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q3ChGv0p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ykR/av5vVnGUdhKzJACfW7HqTTl4Cjx8fuBqUXkJqCQW3JFR4kMLoeiV1jtaXrFsvocDC4+5q4VbP4/EZBymK4pN0Nv0SHlE1bR2nA1nnojUpqNkbHnr20CNm1Eacv3bcXepG4uiSET16d+nCKfsA0ev27tGh6zBdt9S9Eqronm93VLp0p14I65yRsaf9PIHD/0OBJqqsWeUDOC38ulPWAhRN1qyCrviLcbs2K5InhAzq7DEYvjYaXl5UhY8yTVvjgH+qDs1h/BjSSslSCLnUncV9DE3LkSnIAJbpDnuho2+QJCmDu4PO95kplb8fHuGgBb0AAk9GR6AfwC/NMoGFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MW+zoXnHQz1m/qt5hhvIW2ivhVGYSGhlLVjkDlQRqs0=;
 b=KqyMewwOF5ieGtOyucwUmw1+UgHwkyTaDsSBK3cr3KcSZrvxVSMMe7lBPXKL4RJiVBZ4Y9Cun8JhgJDmrklJnpf5hLWSJxKvs5/o/z/14dzvvWbF6cqVHzXrXJCIS5ls0jkr0KOeDs9yPrSVFAvTjxykOG52l/SYzOAv5n0tHqkbmcxR71yvqrxf5u1jcyMT2sp5Ce8epvdvKrEnhYjx5hKxDM21RqHBg2ZHt0jFcOv/N8EA9bj0iDA+CQK2BP/LxC1faNy1sWu0PJbOEeG+BAhE+pmgax9SAYIe5la8v/OAr8VQ+uGij3en8VStD1pQ20HleNV3KLusrT6f9Fagdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MW+zoXnHQz1m/qt5hhvIW2ivhVGYSGhlLVjkDlQRqs0=;
 b=q3ChGv0pekp56PVrKf1A2Zd2fnbHrkiT4WgLqR33IJMMQhQptj7CH6FyHL8VA7saQNmk3mG17tSfXo//2XxEtyFfm6EQbIO8g4MwIGkygG15RWLQEkyU9c0Lv/tTp1FxWhJj8axsev+2PRKDipGkLbDZV3CGbn/tE8Furua9+pNYOIvV9nY8wI5tAzO4IYuW7qEvrmYS0yoM4gFacmRFgYbFMSPi9LJn9c71MRkuPShk8Wr4TSS8I5Rbayq7hUFgGUyndoWsURR+oPrKi9z5p2nf+nJZqqcKjSTCsHb3lNL/zKRAXBMumM1jdXkMkP7i0Qz/8ceoGlM0F7vDXkrPpg==
Received: from BN8PR07CA0014.namprd07.prod.outlook.com (2603:10b6:408:ac::27)
 by BL1PR12MB5825.namprd12.prod.outlook.com (2603:10b6:208:394::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 02:12:18 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:408:ac:cafe::c3) by BN8PR07CA0014.outlook.office365.com
 (2603:10b6:408:ac::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27 via Frontend
 Transport; Wed, 7 Aug 2024 02:12:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 02:12:18 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 19:12:01 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 19:12:00 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 6 Aug 2024 19:12:00 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v11 3/9] iommu/arm-smmu-v3: Pass in cmdq pointer to arm_smmu_cmdq_build_sync_cmd
Date: Tue, 6 Aug 2024 19:11:48 -0700
Message-ID: <728977eae3b97466c4afe89111ab0543b0eeb59b.1722993435.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|BL1PR12MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: 75286605-6d1f-4c68-128f-08dcb6865d0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fH/ZpPUvlUzZdzZpZGNNTT0ATGOZp7RL2R2/7OWxONQ7D4K3b35eCRn+N9TP?=
 =?us-ascii?Q?HMou/2ZBGGTbTPnQR2R/xRgQduV73M5Jh4vF0uHtImAOhoVc3ltPU+3n5kjt?=
 =?us-ascii?Q?P4F4GFyP9PdZDrDL8E/iSuhv+i68B5sJXLiMXDRL0Y3hru5iKL5nsQS5oRlX?=
 =?us-ascii?Q?+rLLDYGPRhoxQi8kTRobRWqPPONWonMZwF2MvW3r3LrgeCQhyQRlklkfVb2h?=
 =?us-ascii?Q?GwR+21W/YmP80pibN6kd482rhFBi1R3AXWs8DylkUmurFkqKQ/ILNaxlPAKy?=
 =?us-ascii?Q?22XV8kXprp42VGXHo/wZXgDebHGTiK08BgguEI210VboVcVtli61r/3VlAlH?=
 =?us-ascii?Q?q1Pytxnv0jEWtF0LIJjwKyOHmLfd2On0qKOMN/lzZUed5qYSXo+Bk7KGYOgN?=
 =?us-ascii?Q?4ffs5eYTgWE18jn9Dn3rIhfVz+tcPUHbFZXWkTLntc0js7gKUFezULd1dJJv?=
 =?us-ascii?Q?sSXLU4sdgOEILTvr9TK3B2CtmsFsh9xZ8WUXIe5jrpIChiHfTCeeT3590dUI?=
 =?us-ascii?Q?HA46sCaEDiV1FhqJDSs8jhq5mjZTa/VGnStguMaMm8BdbGtMBZLgq+GE2doh?=
 =?us-ascii?Q?YS/ed3PBKHUDiPGROrCHYAP2+fQvYT2scJrRnoN6nMda5L8BxEcXJ11CMzv4?=
 =?us-ascii?Q?P236REUzNpDeT7/eAN2RbOn2Ezyy6DjBYcGTCh8JwH4lnWAPNL7QghqdwFgg?=
 =?us-ascii?Q?j5wjHSVth48vJNOfYTBBmabKpZf+KM6KPoqs3AuYkraTpQDb27X1tsjvQ1Do?=
 =?us-ascii?Q?GghzS+Ik7I5uvov2YaHRVMDB4zW36YIPPe0UTwrPJLabgZJV2Rt+qRRt1T5o?=
 =?us-ascii?Q?gNG08xJB64u2QRsPRT0gIjDqtkRGVldB6+ja+9SupYu5oIj9ypsOiODQtEes?=
 =?us-ascii?Q?VI+JbdHCqKvxJOTCfYwkSxxDasGXvfxedJJsoNPb5Ns1ZLcJuaZA5RaIIk8W?=
 =?us-ascii?Q?2PelK+Z1Rn283ME1lgBHH4R3nl1ARBymMDNHQxh+2nNXdvp5wvj35EcVSOTS?=
 =?us-ascii?Q?JHfTyJtVH72HpLt0ksIUcXrEfFgGRB+CdFtGQw7QrowUbV0AzvdORqii6cqv?=
 =?us-ascii?Q?BCcg77ewEPQnQWuCPqersnhYcUf9DHrp6ZTdfiqnMPHFV+v2WMWcWSl3iYdt?=
 =?us-ascii?Q?UtiZ49d+1ZB49ZVRRyvA2q49oNtjidfdZB7ntDqG+/1fdl3Wb6rB7eAKDxtg?=
 =?us-ascii?Q?ycoAsu2/eTPO0p1bSomd6S2w9c60/g2l46XS9SAhA1UMplz/qMQ+pC1AyN4G?=
 =?us-ascii?Q?US4379GBlXuqfMtOzX8HJ8STQcNKhOs5p7ouKCslqx1Z7bng0Q7NTt0YPkjq?=
 =?us-ascii?Q?9h4W3XhGr2dTznMPmLKgnfcCXNQEM6k+O17pBtmiblWXmZBGLbBU8HCvVSYO?=
 =?us-ascii?Q?x8dTA0TIZlpKIbkE/fY7w2gthLOs5sujUE7dV7Axm3wekxarWquyCI5FJBFd?=
 =?us-ascii?Q?Zmp5pz09iUvFOvsMo2Ev91PYLgAZSw/9?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 02:12:18.0969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75286605-6d1f-4c68-128f-08dcb6865d0e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5825

The CMDQV extension on NVIDIA Tegra241 SoC only supports CS_NONE in the
CS field of CMD_SYNC, v.s. standard SMMU CMDQ. Pass in the cmdq pointer
directly, so the function can identify a different cmdq implementation.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f481d7be3d4e..d11362e9fc8a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -342,8 +342,10 @@ static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
 }
 
 static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
-					 struct arm_smmu_queue *q, u32 prod)
+					 struct arm_smmu_cmdq *cmdq, u32 prod)
 {
+	struct arm_smmu_queue *q = &cmdq->q;
+
 	cmd[1] = 0;
 	cmd[0] = FIELD_PREP(CMDQ_0_OP, CMDQ_OP_CMD_SYNC) |
 		 FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH) |
@@ -364,7 +366,7 @@ static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
 }
 
 static void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
-				     struct arm_smmu_queue *q)
+				     struct arm_smmu_cmdq *cmdq)
 {
 	static const char * const cerror_str[] = {
 		[CMDQ_ERR_CERROR_NONE_IDX]	= "No error",
@@ -372,6 +374,7 @@ static void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
 		[CMDQ_ERR_CERROR_ABT_IDX]	= "Abort on command fetch",
 		[CMDQ_ERR_CERROR_ATC_INV_IDX]	= "ATC invalidate timeout",
 	};
+	struct arm_smmu_queue *q = &cmdq->q;
 
 	int i;
 	u64 cmd[CMDQ_ENT_DWORDS];
@@ -410,14 +413,14 @@ static void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
 		dev_err(smmu->dev, "\t0x%016llx\n", (unsigned long long)cmd[i]);
 
 	/* Convert the erroneous command into a CMD_SYNC */
-	arm_smmu_cmdq_build_sync_cmd(cmd, smmu, q, cons);
+	arm_smmu_cmdq_build_sync_cmd(cmd, smmu, cmdq, cons);
 
 	queue_write(Q_ENT(q, cons), cmd, q->ent_dwords);
 }
 
 static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
 {
-	__arm_smmu_cmdq_skip_err(smmu, &smmu->cmdq.q);
+	__arm_smmu_cmdq_skip_err(smmu, &smmu->cmdq);
 }
 
 /*
@@ -780,7 +783,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	arm_smmu_cmdq_write_entries(cmdq, cmds, llq.prod, n);
 	if (sync) {
 		prod = queue_inc_prod_n(&llq, n);
-		arm_smmu_cmdq_build_sync_cmd(cmd_sync, smmu, &cmdq->q, prod);
+		arm_smmu_cmdq_build_sync_cmd(cmd_sync, smmu, cmdq, prod);
 		queue_write(Q_ENT(&cmdq->q, prod), cmd_sync, CMDQ_ENT_DWORDS);
 
 		/*
-- 
2.43.0

