Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D4F433C8
	for <iommu@lists.linux.dev>; Wed,  7 Aug 2024 02:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722996740; cv=fail; b=N0sEidhHn3nxM35rnchJeIMKZGO7tA7SvNVtrcr7DSyhYcq2RkNv53tObqCQKfhP38IBJexyYELmgz4nOsalDvbQURY2DEOjz7Q4SxF4U2RLH2xplIrUzl9uiOLUsXtdQkJ7dUqjpczksDS7c8XNBocsRDjQnFPVkhXVj5VJEh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722996740; c=relaxed/simple;
	bh=9JVv5wpOW+KnXOu60yk5XUwKIouiVliwPUePTFLjkPs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pPWTcMVbzl4eQUpBy42rZx18WfM7V2RGeiYW2snTtl+b+vBvglngH9tP+3vxgWharEQ3IzRuvPtsC2B2YBfJ1QFOhgMcQn/wFcJmZQWjoe2fCD54hQEoQWy4859UQlIp04EdMii+NMzWr3/lmJI6UqsFQmLGgAsEgUEcmernfTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EwAsMig1; arc=fail smtp.client-ip=40.107.92.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EwAsMig1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2UzBBLlY0zKTSC+5nYDvJpZdJZzqdF5koL/DC3MqwHH5JGRgNAFQOKWAZKw3g9IPWfDqgbBkz2ycUszlLDWeDPn4/kth6Q2kPzylFNexI9buARua22TmQ/YZAXrH4kk0ullhYSmMgJokNljwclwnh4IPRUIfWhs8/+7ZQ7HrVEGEY5HxtvWTI3AWHWgbAu7QEGPQXqMh1xXTmTt+EXSbDsKLSFB3vO36kOHI2fEc3yApKE77dzzZE0GgZ6DEyoTaXGESilRn36wY31vbHlHDBrdRIZpnMgYMGGaEL8wL9uz5Mn2kPtXC/9C3xPjB9+drQDIdN9uDkTAhpTGd1Jcrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZytuDAePASyrbT69qaP95OOcwIh/3f/lQNIQzMbhhU=;
 b=qh4Jlx4D2RcoK1rLnKYnK+kGwCUO3SE1EAkjfGk81a7HzeddISRCWMI00LzfHfc+L4wWQ1qxHgczR8RyOVqP2bAykCC6VSozQ5PgYIBoRjYmhex57JJ+Bp2F3LBI9zPtYQqH6lkceYyO2EG8lQW0FYY+1tSZfjGoznf/giOK+25J3Zj+Rs+CN0S0SA/tV7ZlNqbSho0g/46rLk4IhtI+2FKE2MMxXb1g/MeuGGgqwTm2oJpLhGBDjF0n4vC89PW6ZLUXBEs54b0Na0aQD4/RkGAGjMqNyS3cJjJvoEkLf1l1ftwa32evGRZiJIfkHZgTHPMYhxRLkIEfFn9B/MwtRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZytuDAePASyrbT69qaP95OOcwIh/3f/lQNIQzMbhhU=;
 b=EwAsMig1fHIOI2pqmKhDql/FeFEdWEl40ACjAStKCUNJf+JR/IELbdC3R9IOxY/nzLeWxcJrrMrMf1ZHu9aT5+Sahgj0MicNiEUN3CQnPUzuRVr4UzdEoxez6/yN/5439bbAmklKHvhL5dvF7B3JJPBziyJryDsmUl9/Iy02pd+bDuPewNft9Pt5Pc++VreEVWPFG9hRAP1n0hE2lZkxCri0eXl63JphPSiNbbbaTfLGc0Z74pZCnMqSiXTX9jIW2OGjZYIHcYSM44sYteILUZLfrMVlhlsJ3dgKSq9gZge1aN5U50YAKYU6KU2KCDOwZTdhC/g0sqPhl7iWXn44bw==
Received: from PH0PR07CA0011.namprd07.prod.outlook.com (2603:10b6:510:5::16)
 by SN7PR12MB6789.namprd12.prod.outlook.com (2603:10b6:806:26b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Wed, 7 Aug
 2024 02:12:14 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:510:5:cafe::76) by PH0PR07CA0011.outlook.office365.com
 (2603:10b6:510:5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.12 via Frontend
 Transport; Wed, 7 Aug 2024 02:12:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Wed, 7 Aug 2024 02:12:13 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 19:12:00 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 19:11:59 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 6 Aug 2024 19:11:58 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v11 2/9] iommu/arm-smmu-v3: Enforce arm_smmu_cmdq_build_sync_cmd
Date: Tue, 6 Aug 2024 19:11:47 -0700
Message-ID: <9e59a460c969357a98b3434ed5007ddf9381899b.1722993435.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|SN7PR12MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: d9d8f44e-3594-4203-7728-08dcb6865a73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JlGxJVC3kBttyqQ4hkp3UXOuIq299k8XWlOyv2PWqjYeVjKntf45CDPRGt0V?=
 =?us-ascii?Q?+4ppXxYHaGol2pIrIqDtEDcJ9cttBuPgWo/0+QyQapApvoJigJsAYrheYsx6?=
 =?us-ascii?Q?rXyHaqq12jhHyTR73b6cJ5Fzw4hZVyg7XTtH0PcqH9qvx6fj5JV15olvxaNQ?=
 =?us-ascii?Q?aiyfvmBfDyc2v4nyH+VjVaKzLwDLxxd3skrl64HruV/pk58dAUk5KgBxmmrc?=
 =?us-ascii?Q?miHT4sl/zPze8kRptWeWr2DHtfchesD3jjw4t1nggkt0ufalHcul87Andyvk?=
 =?us-ascii?Q?u0X5TEp0ZA6LXWAzs0LobNEVFv9V5jDoaKRGF/uw2IV3dkjgVoys9cUsb56x?=
 =?us-ascii?Q?G4UhRl9ylJkjTwQZgp3UJLLzH9JhmN4i7WfWJT75+Sii/n4OeXBDwxCpi8gW?=
 =?us-ascii?Q?hIM/MBnQlsZ7kUQQ/saR+qNxhQL6oNd+3U28KfgrYOr1IyXaj15PNZNT+blO?=
 =?us-ascii?Q?YMLibzqqMo/pqi0N2z4ULki7d/s2YdgbYC+fYt0YgZQEZtLFeoRIxCl5J+Je?=
 =?us-ascii?Q?54dkjPjb3riqtLlL4I6Vp6QGkVH+vsk+Qo6XF4D+z1qSyublR+AzBD4uhanV?=
 =?us-ascii?Q?W3AnSg6TV/bgWsLx/JmWetpWNiEUzIq7QDb9z1D4DI8b+qUy4J7Git5EJuT4?=
 =?us-ascii?Q?CDPc2CrbovEcSXGXRIMKAaYtFt4hWOwdd8rcghoCTNVTbIkaCkkRt+gRXj8R?=
 =?us-ascii?Q?w51PEnbhg+NwUqIrjWzKBsle3jMvEZSs4fw5X+aw5Qwp/R1EcLPucT0G/JB7?=
 =?us-ascii?Q?Qs+qYWOxN30Lbml+uUja0O1Y2swhvIiusEm6AknxeNnDGYUHv/U8AOWltAVx?=
 =?us-ascii?Q?dS5N634x7rtz6gLYjc4xkfKNwKnFBAvx5VyZ8OmAcIkeqvW9JF5lQBwoi8Dp?=
 =?us-ascii?Q?QAXY85bDe90WnmcN3VtXgghPp/mOsyl/G1YRapsUpTLpQNGISeG9LJorOil1?=
 =?us-ascii?Q?NpQIph0G6MLMKg/EtzWeSEK4BWgPz/tE3sotfSbSsUgaaR8W+wo4QESzFnQu?=
 =?us-ascii?Q?o3UnA2QKAIrHHkklynuyqQ+nsi2nFD09wweSmI9/dizOeuI2VuRdBRb50doU?=
 =?us-ascii?Q?ANQ/6SbyhlG48zTAXyFhv4UF6ushUSzdHcMw0DTb55yVSqLEPjGnGuOyiP8x?=
 =?us-ascii?Q?WqaUU8bD/hgTJVMQuQ7WXpwykOdedJ1Ua0DXKixZrviY+UMSBG/tTkEzpeB2?=
 =?us-ascii?Q?e0ZTW1WjQKJ2kwgtBa7g+qhGgiRQxyjdgTD908Oqp+A0XWB+rnK3ql/z8vN1?=
 =?us-ascii?Q?jxguxM38EtViA3pR2YeaC2yD6uTxTgsVPXEPFjVstdYrNn1BWef3DF2EybBa?=
 =?us-ascii?Q?TrJrXCFz1yl7wXoGCZu9WEbG4ESRc/yRkilZ2Ng5rcglNHs/pagZGxVk28N0?=
 =?us-ascii?Q?AG1WBhKR1tqZRFlBSD92nToJfH3XwUgMzCuIvpp8j/92dk2Vw84PWF8yj+B7?=
 =?us-ascii?Q?ozPXsoGuxH5qU2mHisMP+pVr4GF7gKCs?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 02:12:13.7751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d8f44e-3594-4203-7728-08dcb6865a73
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6789

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

