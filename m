Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4A86BFD4
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 00:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723769770; cv=fail; b=F28ub096faTfgdMDZKfG3houHqEUQOrlJ/AyYPZcCrtgLz7tC9kGlH5g1BvZ2M6ke3AHTJWZSYF4SR99PD/xU4jDBoaQd9VAWZ36/zMYQ7almGpmPiqxxcqNNqytB/ly7S3XRhORsAq7CpTTOR/R6Y16DT0e60CzMllLV8QrgG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723769770; c=relaxed/simple;
	bh=9JVv5wpOW+KnXOu60yk5XUwKIouiVliwPUePTFLjkPs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ugWRDYEcu0AUFTk1g1g/5d3tXSqWe7CtjcAWwf1hLGBzMiI8SgNNNG1XyB5SRGEDEDMBkrB735j87QielCTHZAVQXcBBrZUJIFLds4d205s2mENWKAOte8ioq13CgO2FkX96WgzTZcRhWMeBZTn2VXpvO6hEETrqtaG6CC7J4U4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HJq//d2n; arc=fail smtp.client-ip=40.107.212.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HJq//d2n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDfUCSTJnT8f0RXxDxIb6fXbK+bWDspB1QT1FEYtGtL+b3bmBfrVRWSe8E8Y2usG/eoOz9eABgpheV171+zJ8ZjQQTw5y1J0Us2dVi9daYU2NSjITz6ga5IW4RskQ2TIap34B78CR5UPofnl1920dSVvxNyBgJOPBmobZvpEnfNXHI/9/hb75XLcayAM0oN/4p04wjikPnXSRAWAO8R26Y3AICvLf6oTDs8cypwLMUSh+k439tD/mWC5GjRAy4ASbzdb9KS1GVYd7GZrNcs6d4gbFa3ZGjjlo0XKMp3HRtGTkaDKyIGXszk/AdaECreZ3E15tGKMGBYe5XPgZXOw1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZytuDAePASyrbT69qaP95OOcwIh/3f/lQNIQzMbhhU=;
 b=Qi2R6MUJXa9uAR3dBbuaxVYew4Kvz8jZ5BCvW6pINi8vRcMrw7tIrUEDwEoyblpFezCb7MpqQHlbj/VK6Xh7TmrIMnIfhG+qD0+7/xJryNyw63AV+sGabIpTQ65JzGr6GGIPt4dNAtMpt46xN95sKOt5AAv6nheNZihqN3+sObhcb4gmDd34j52IrrjCiCiZAcMkxPE0c3In6Hr3LxIsGBWDAjF/3YoRm0m1Ct6CikusLmnlPBcyEnAmcifaTinmDkxzkl+1/FhRXVNIQRWfYb3LHR5OnPFSaiiJvANc0hXMcgp94mXto+Zd5JH56sxwRHVkfoDVFsDBMayPUrGAWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZytuDAePASyrbT69qaP95OOcwIh/3f/lQNIQzMbhhU=;
 b=HJq//d2nNK8o/InWBWl/p+0ohFcSPNfx1GiR+DxlqroqV5jC3z54jngxsUg/mFa0D5dWEl3O4E05AjbF6v2wP7G+Fcg6mIU6LGR8IgI9AitRJMfPJ2WhRvSG/peVnRcutlE8abHssZDvbqPtQEy6Ng97Y0QU+I30f1gRStzl59138KDd0HcoOAAacNTsQfp+9YL4xrn+lb/mMtus8fcayWnyTBzhKJGpCFhvYNGLY7R3haMWwbQGIo0BW9cqHCgaHf2lrVAQWzLp5dBpGI1BdRHpqBd4ZDBFxVbCMkeHON9lcpoG4H982soYUtgBgzDguisSqqoJyPwsPJbYz/J6XA==
Received: from SJ0PR05CA0202.namprd05.prod.outlook.com (2603:10b6:a03:330::27)
 by DM4PR12MB6423.namprd12.prod.outlook.com (2603:10b6:8:bd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.19; Fri, 16 Aug 2024 00:55:59 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::c0) by SJ0PR05CA0202.outlook.office365.com
 (2603:10b6:a03:330::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.15 via Frontend
 Transport; Fri, 16 Aug 2024 00:55:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Fri, 16 Aug 2024 00:55:58 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 17:55:40 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 17:55:40 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 15 Aug 2024 17:55:39 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v12 02/10] iommu/arm-smmu-v3: Enforce arm_smmu_cmdq_build_sync_cmd
Date: Thu, 15 Aug 2024 17:55:23 -0700
Message-ID: <e7755500582768cb06a512ef96f9e3c866a66d9c.1723754745.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723754745.git.nicolinc@nvidia.com>
References: <cover.1723754745.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|DM4PR12MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: d11da687-0a65-457f-3cfb-08dcbd8e3151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mh/8+Mf9/svXoiuGQ5CMTdhMfq5+Y+ivMJ7w7FBPguKmEWC0MdQNuKNSn32O?=
 =?us-ascii?Q?p4ZBs6rdrOGQCvYhzWTlYx980NBfvAmOn4rv4EEQPbtuoyUWCQsm5XAqkFQT?=
 =?us-ascii?Q?iuDKyG6JVAFRoYSdlHsauddQUbZmIfX+i7G+7ojRfqwtp1aspRuzGxqx9LKp?=
 =?us-ascii?Q?Y48vhgGXBolkptvJ+QBZr5dW9vPCv8N6OWjHI2y7gy4kn5SOdCbD4O0mmxHW?=
 =?us-ascii?Q?KdyOfPu2G8cyYF3dMBan3bAfSTEJrKqfQX1UndJZgyR+TraVelpd689f6e8J?=
 =?us-ascii?Q?zUpdnKahFyNRuF549z3cYfqWEvbO3+Nd6dr0ymRaP8NN4mJabf5rs5GClQ6Z?=
 =?us-ascii?Q?omDY+25t3OAEED7LLt+gzJrg2B4sRURVlIGVPAZIviIiL1SDfiDSBtW+xPpf?=
 =?us-ascii?Q?8cyNB3X3abzlRthWMTRxu9EwZdc59UDfFz/4ctKZVg6lu6jbOxDgvze81B3Z?=
 =?us-ascii?Q?M8H5jY2aI7wCvjb12M3ZUXX7MeaJ5psq66zmyrCv3fymJYLEbuhdwuqLlWqt?=
 =?us-ascii?Q?UiV+0SK0fkjgCW8WYG3/TKus3wkD39fCAurZQWSrGn0MI7DEKWcThC85J9Ec?=
 =?us-ascii?Q?gic2gV/EcQdIOcHAC/TMDLvV/TiJOWUacG7NWkYH8W3PtlUQcbd4A+wwd4Ug?=
 =?us-ascii?Q?khwzFvtrAItt8ZOJ7cQOfMsRksQPimCEZ/xVDKjZxQuhwjmpVCnRcP54R6sC?=
 =?us-ascii?Q?II7JXz5fRRpRgmThGgkWnaVKtYRkwoJvb5XGIcwlSeFSMuPDY/8Gflli1z48?=
 =?us-ascii?Q?PeV2ip3S5ri1NaQPGr5GVEy22NKoaAWLkNx7t1ZDmemJ1EKsg7Rm0BmqxaHi?=
 =?us-ascii?Q?PdLKnoJsLWcJ6oaBev8qcHHfTPCEndrKk60JbYggdKPlofowOwPqeFRSSDa0?=
 =?us-ascii?Q?swrgyiAopriuGBv1R81I2a7L4uGdi78eF3JQrLj/cQU/snoYOntzd47pN4Uk?=
 =?us-ascii?Q?6kQmHyRx4kpX1+aqr07IxjwXcxjhh7shW9SnEik2UFdaG70+/IALgi67pUu2?=
 =?us-ascii?Q?meHDa2GwxLHGrcdpma+zhk3UJZDXeqfq9FKE7bwEvAZdLzmZV9kqu7iTbRas?=
 =?us-ascii?Q?gSZwVWc/aATB8OzIXSPdzncxK7/r62w+kkZoWWMBOe8hlJhPg/wSoFpqRWCh?=
 =?us-ascii?Q?dJCzLSPK27JpHG9x/R8GcdfFplEh1BMu4xQnZoiom2QQUZC5cxdart7NYgxx?=
 =?us-ascii?Q?R52azaNJrqTO54Kd4z/31bIF6tNt+gFdJK5XZ4QGUHTDsiKT5+LybhQw+y7v?=
 =?us-ascii?Q?NExuj8WGPZnnn8xFwdmBro65qxOhuMwAgWT4jXkElPu/TRqgVaRS9Ieixn3i?=
 =?us-ascii?Q?gi+8z+3Hp+18aeV0aqYXb9Xrg857lkbhcAhvIB+rZUJi+Tbm/aR5e3W8nX2o?=
 =?us-ascii?Q?cqovZJoNk58Q1Hjfg2cJ7nzi2vocQeVZBpYKkyPdwtJ17hbDr9DQXmhBgMfb?=
 =?us-ascii?Q?HzjqvixrsC+aJ3m9ysjWBz/Z7KPJqt+2?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 00:55:58.8618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d11da687-0a65-457f-3cfb-08dcbd8e3151
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6423

There is an existing arm_smmu_cmdq_build_sync_cmd() so the driver should
call it at all places other than going through arm_smmu_cmdq_build_cmd()
separately. This helps the following patch that adds a CS_NONE option.

Note that this changes the type of CMD_SYNC in __arm_smmu_cmdq_skip_err,
in ARM_SMMU_OPT_MSIPOLL=true case, from previously a non-MSI one to now
an MSI one that is proven to still work using a hacking test:
  nvme: Adding to iommu group 10
  nvme: --------hacking-----------
  arm-smmu-v3: unexpected global error reported (0x00000001),
               this could be serious
  arm-smmu-v3: CMDQ error (cons 0x01000022): Illegal command
  arm-smmu-v3: skipping command in error state:
  arm-smmu-v3:  0x0000000000000000
  arm-smmu-v3:  0x0000000000000000
  nvme: -------recovered----------
  nvme nvme0: 72/0/0 default/read/poll queues
   nvme0n1: p1 p2

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 36 ++++++++-------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 --
 2 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f409ead589ff..f481d7be3d4e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -329,16 +329,6 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 		cmd[0] |= FIELD_PREP(CMDQ_RESUME_0_RESP, ent->resume.resp);
 		cmd[1] |= FIELD_PREP(CMDQ_RESUME_1_STAG, ent->resume.stag);
 		break;
-	case CMDQ_OP_CMD_SYNC:
-		if (ent->sync.msiaddr) {
-			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_IRQ);
-			cmd[1] |= ent->sync.msiaddr & CMDQ_SYNC_1_MSIADDR_MASK;
-		} else {
-			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
-		}
-		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH);
-		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
-		break;
 	default:
 		return -ENOENT;
 	}
@@ -354,20 +344,23 @@ static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
 static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
 					 struct arm_smmu_queue *q, u32 prod)
 {
-	struct arm_smmu_cmdq_ent ent = {
-		.opcode = CMDQ_OP_CMD_SYNC,
-	};
+	cmd[1] = 0;
+	cmd[0] = FIELD_PREP(CMDQ_0_OP, CMDQ_OP_CMD_SYNC) |
+		 FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH) |
+		 FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
+
+	if (!(smmu->options & ARM_SMMU_OPT_MSIPOLL)) {
+		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
+		return;
+	}
 
 	/*
 	 * Beware that Hi16xx adds an extra 32 bits of goodness to its MSI
 	 * payload, so the write will zero the entire command on that platform.
 	 */
-	if (smmu->options & ARM_SMMU_OPT_MSIPOLL) {
-		ent.sync.msiaddr = q->base_dma + Q_IDX(&q->llq, prod) *
-				   q->ent_dwords * 8;
-	}
-
-	arm_smmu_cmdq_build_cmd(cmd, &ent);
+	cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_IRQ);
+	cmd[1] |= (q->base_dma + Q_IDX(&q->llq, prod) * q->ent_dwords * 8) &
+		  CMDQ_SYNC_1_MSIADDR_MASK;
 }
 
 static void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
@@ -384,9 +377,6 @@ static void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
 	u64 cmd[CMDQ_ENT_DWORDS];
 	u32 cons = readl_relaxed(q->cons_reg);
 	u32 idx = FIELD_GET(CMDQ_CONS_ERR, cons);
-	struct arm_smmu_cmdq_ent cmd_sync = {
-		.opcode = CMDQ_OP_CMD_SYNC,
-	};
 
 	dev_err(smmu->dev, "CMDQ error (cons 0x%08x): %s\n", cons,
 		idx < ARRAY_SIZE(cerror_str) ?  cerror_str[idx] : "Unknown");
@@ -420,7 +410,7 @@ static void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
 		dev_err(smmu->dev, "\t0x%016llx\n", (unsigned long long)cmd[i]);
 
 	/* Convert the erroneous command into a CMD_SYNC */
-	arm_smmu_cmdq_build_cmd(cmd, &cmd_sync);
+	arm_smmu_cmdq_build_sync_cmd(cmd, smmu, q, cons);
 
 	queue_write(Q_ENT(q, cons), cmd, q->ent_dwords);
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index c1454e9758c4..6c5739f6b90f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -518,9 +518,6 @@ struct arm_smmu_cmdq_ent {
 		} resume;
 
 		#define CMDQ_OP_CMD_SYNC	0x46
-		struct {
-			u64			msiaddr;
-		} sync;
 	};
 };
 
-- 
2.43.0

