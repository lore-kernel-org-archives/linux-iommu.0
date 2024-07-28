Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2086.outbound.protection.outlook.com [40.107.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B1B7E0F0
	for <iommu@lists.linux.dev>; Sun, 28 Jul 2024 22:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722206719; cv=fail; b=cGzLKk9+WALO0v3lZiLU1g9Zco0U4CCPMLZ4PnHSu/ITYQFdKGBqVWHks6XcnvOCgcfVngNOMMiD5n8XcoLZ9241i/kAvxWQxUcPX+lKHeV9uKCgI2p9wCLlGN0uMrBJTqoQgEUch0bHbw1O/cNwZ4GJ8csAc2TG/t1BBiDkxcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722206719; c=relaxed/simple;
	bh=1x7gkIHK3LnJuU2JwM5AT/xILlkni2pSP4aWlCRgfU8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hDH6K2oIWiELrJjT85PRQx5Q3ApiqV++zk0fqIBHKFLuHxP4tVyoyYDCLIX2Dfbep2C6QNYm47DNM6G8ZuFe+lu6Lkytjz7sE/HDUKBnQLrGKgf257hHa9Bls6Q0NC+c7KU2Z3+W8Q23oJZblIt3ud6cDLx7Ii1FN9KLJuv4JfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qaN1Jd8B; arc=fail smtp.client-ip=40.107.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qaN1Jd8B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oai3bUupdAQ0DS1NLDOiRv4JPKc8SpF2KUK8Ouk464+H09u2vbjIfoxhEF2ZRSnVzEBUbES8h1r4ecBKD2SlJPotKBmTvTFV3zoMQGsyyV8LG5X1QpT/JxwyD5NKlvxTj/+FRuHGScOflgD+iKVYc3L9+H6MAaJFB7gzinegKAoyDj65ezRjbKDlZFTFOYcIlIHQkWAH9noua8GQxkD3lbGGkdTEqGeGirZj45vh/6ogXPONtOqJiU+/3B7gPu4x1HV+Yo6beHcXjF68jGqxEIUkIQCWAojQsIBEP1J7BnjVByx7m+u8xLaiQjzJMUGdWRetXIY5aOlo7CzPLqH7ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pb0uMIkIpQ+ja0981Lebu6N2+gBun1AKMN4dGSg67hU=;
 b=VQXZUiZRyjbYwkSB5lfCXVv9td82EPG9o5F6Q5LKHgLswaPTsw0DZawOIsdzCPtP631Kx8YCR4zo28FluGtSDodrhDX2OYR82P2ftEJWkNAPiKhT0SKTd2KZpHcL2F+KmkNfx5Jchvl+wyAvsmhw1vB0VoaYoJ3CAyaSljbq7ijNjirLyfNlfVYdaSKAM4oviAoZtP2Px9k82S86U6uOHhUGc6sIjbT9H7OZpqQsewng/mdt6Rzllty1qb/X2cc/0n5eyt/Cqt6yuKrLeoUlrp8eT2h2lXW6JZzbHEtoXaJg13ppMaubXklXgnRq+sZU18IES4NcH1DqrRyyzwjXPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pb0uMIkIpQ+ja0981Lebu6N2+gBun1AKMN4dGSg67hU=;
 b=qaN1Jd8BIY1jJ0qHgUhnm6k4IPgIy47Dw1SQAxnrbqSDbgXakuL10+G8bQ2tksJzmKZi5LFJNg1dJIC+p0sUk/y+lrF6ZsVm0+k962DA/rCOzfNtvXaDjjKJuQujIfLM/VEFXHkovj/28Qz8DD6HVqpaD0rNDz/T5lLP63nVCMcEm7lDVm28GWnx9zGOCeKjifxsdVixIIrTZZ6jRUGpLGoBXOLFljiWIxZ8nEssKoK8SumnwFEMGx29Da6XN64rK1vv3C7ugugUIAj2vrp6BGZqemZ1BU4VqEchaxi+d/oiJiNjWz0+6Mz4W3dxbZ5N1LyLebm7NEa+3eRoyFlBiA==
Received: from MW4PR03CA0095.namprd03.prod.outlook.com (2603:10b6:303:b7::10)
 by DS0PR12MB7510.namprd12.prod.outlook.com (2603:10b6:8:132::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Sun, 28 Jul
 2024 22:45:13 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:303:b7:cafe::a2) by MW4PR03CA0095.outlook.office365.com
 (2603:10b6:303:b7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Sun, 28 Jul 2024 22:45:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Sun, 28 Jul 2024 22:45:13 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 28 Jul
 2024 15:45:04 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 28 Jul
 2024 15:45:04 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 28 Jul 2024 15:45:03 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v10 3/9] iommu/arm-smmu-v3: Pass in cmdq pointer to arm_smmu_cmdq_build_sync_cmd
Date: Sun, 28 Jul 2024 15:44:48 -0700
Message-ID: <aca6d7402517409dc6b4db8add0a2e811dff2b4f.1722206275.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|DS0PR12MB7510:EE_
X-MS-Office365-Filtering-Correlation-Id: 2304aece-2ab9-4861-c1e4-08dcaf56f16d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fdJpCxYZYJsbM9pSjsLPoiPnHdudgJBitZRibOYd4z/Dm0oMn7cB5AV5Szh0?=
 =?us-ascii?Q?y92S34k9QwZwrXk1H8CqeFCo4CphGGj3agM7heUnerd53lFURLMIUyb3t2DW?=
 =?us-ascii?Q?od63nEElpriOevfiOZdQgoQ3h5S1m4ifgQ09I6f2GRqnfSMBcLmp3QoNiKxK?=
 =?us-ascii?Q?Zf02BwJDI1oD37zE25H29w5kSYUJEjlJMP2GyXWsNG7zd3eUOIp49tZ83orF?=
 =?us-ascii?Q?2YpbzPJOj8hgh7ucJD9MdMYuqHOXWnZupsRfAGwM/+a2yYqsNhtmE3OwkWsp?=
 =?us-ascii?Q?XGjKi3byYNntjXBjCSYRF4Fxf6+epQxgSJVsB0KG6GbjNIa1LoPPdB6xt2rO?=
 =?us-ascii?Q?lCL8eLLqqPky7Uc9Zr0w+dnwOIMoBiJlw9Q7YCdD7oZtXT55NvFiVK1winLK?=
 =?us-ascii?Q?6FmnVY42pVctY0APu0wLlRJBmOSdw9DPwufW69hQyDSX6Vz6kssN+KbhtWlV?=
 =?us-ascii?Q?Bw7MWNtnhl5KFJtiM0lIOonyocd2b1yhgG2oeLWSqx9uak1dUAVdVSdtmU/8?=
 =?us-ascii?Q?+V1oUoefGlFzQJhZkgCQ1YP2bGx6owlQLvZGJ0P0cwzHJI+ypWH/Z8KzKM4q?=
 =?us-ascii?Q?t4zJC7h98ssvCYYioFNyoqJBjEEDg+tg3Jv2AXxyp5hnp99KK3P11NYTN/Qk?=
 =?us-ascii?Q?TffP5olLYD6Wy14ttOcF6DiZHXSK6CCwqrnhQBHIC4D2df1dVa4fp8Q/ukJv?=
 =?us-ascii?Q?vhELKatC1BOEJmfdFOIm1CRM2SBhhKAVJ4eNp2oXZkVcCyNcyhNfHCAlY4c/?=
 =?us-ascii?Q?6VdTFH0jC3EZS18qdnyxCk8iQ/xpmIEHvq2HVacHSh/YGFiOAqU5ih57dfAL?=
 =?us-ascii?Q?IcXnB+aYZ2mOM3J0DVhD+pI02lfUk8Qh50W3MxvCE2FHPoE4LxFQMrBxtRQl?=
 =?us-ascii?Q?aqml4veIZx8LvP2Nf9w4hBc+JdM50bdqgjJgqgWwbFgLGLxTmVjtW0I9w79T?=
 =?us-ascii?Q?WH6uc/pVsvWR4asQedeyiISqPmwFtTcVnFQkiaNhZcO8s4MG72IrIV2N/zL8?=
 =?us-ascii?Q?Zxmid9t8AmZjXKZ0rcQPCrHC8xeBSDu/IBwoInJ0W9ZJ4EQvURyHafQzQXus?=
 =?us-ascii?Q?HxGvwPbxNe3IOMvTbDNOFKCF1KOyezAvYmbTQccD3LAYeXHPuQFz1AQXylzq?=
 =?us-ascii?Q?VgCbzYavZuE5oe1Aearui3YcpSoTSDjR7x3oAjjmgRDfGGiFXUztMUGR8SwH?=
 =?us-ascii?Q?YG08UDl1n8ypeMg4fxM+f0dXdBGczkgG9AoRDIvBEOyW1XpQ9HIUi/kOKT+6?=
 =?us-ascii?Q?jGCkpTKo04ExwuAz/tTID3B90Kzg8eBNNshj4O7il1luUpLyWMq/B5O5iISw?=
 =?us-ascii?Q?cXSwbQjKFDUUvEO7minn2ZtpEdHkIp4KO0Ae3kUwYrHjThkP0PI6p5tCEgZ7?=
 =?us-ascii?Q?u+W5A/0dOXN+XCQldMODEMM6Irznfcv8hkAqiue9LxYc9aCYNuLfRoexFn0Q?=
 =?us-ascii?Q?3nWitw3VOZ9dlgixo2YBBPB49iTJ48nh?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2024 22:45:13.1380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2304aece-2ab9-4861-c1e4-08dcaf56f16d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7510

The CMDQV extension on NVIDIA Tegra241 SoC only supports CS_NONE in the
CS field of CMD_SYNC, v.s. standard SMMU CMDQ. Pass in the cmdq pointer
directly, so the function can identify a different cmdq implementation.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f481d7be3d4ec..d11362e9fc8a0 100644
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

