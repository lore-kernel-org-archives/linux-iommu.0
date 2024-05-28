Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F39313C3F7
	for <iommu@lists.linux.dev>; Tue, 28 May 2024 08:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716883815; cv=fail; b=Zxcr2RZA8oQvW5Vym2NxvuJkNTf6je9BnI0zCEzFDI8omDRLC9qkZuQvHQvfcGfEn+CqiboUUwywJw9xHV3q9NM7onc8Wm9wLWkI+0d623iFKc9A/s3U+vDMqkjGbAkaRM36pBs99PppJnpQUWKNaHsCpR+Stqb5FPLidiGshjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716883815; c=relaxed/simple;
	bh=Fd+wCylJzh2iwYuCBNVeceSS6JphZoUV03UJ0wo3xHQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TTLft6acMuLXpN7CdwIWhuMAAHjYlIqRZldeuQqXMfmVgt7/YQTEisdQAtxuAHgYLgl8MnXGvp4E/3YGTN7CklM7DQHTxMYkKVndXwgtbKSF3uMNxunnBeFuE6rzrBMHM4ZIb5nfXL6KHb8R9YPT+V3BP0ZtFTUHFWlZ7A0ki8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ld3ECSUa; arc=fail smtp.client-ip=40.107.102.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ld3ECSUa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YnoryYk8xAQcJNYY2xTWa1vORyVxOkNxUGN8NnmIL28k3SEtCs1PMygERxFaPJOGFqcMy/wowruJodbTpUuPLveOfzAv7L45pjDAVfDkqDHtSbbBPwyOkE+I4T5Y3RGINS4gFUQUkVG406PNLpB/kgL0fRiJIUb9aqj56rjjk8IXnQiwgel7nCdW2DQeicjhBWnMTBOCX9scbh310aCC6/E+BFPXlbQJRb7j08d5P9GFkjQ9+cQVox/8nDZZoz4Sy8NxdRDocPjN5E2V84HkhASRSzbps52IU+983rToid/NAioXHyMz6UktPZ2ko0aY6ipC2DHxpoxqlyz3qkzKeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p58LBZqAAtAQAjCns4TY81x7+PiDFF0gMFFlkYFgEv8=;
 b=nW+7YZgXheL8LokNGFsPwKmbQ5hmapVY60ghHkOsK4CZrA7ubWvv1jSmjf6Cnts4ti4IzRLfTHuSJfdtpC31JUIZOaU9owCDZRLuKFPT5rsk8Pg2beUkoU7q6x324jb2KPAaCwB01wFxRr7pGOk4dGgo5ta1ukfDJis7WMacnOiOHVXmAbex0gs3U4OerNKfwSAskKtcCOgxRBALpuw1LjxLgt8WjcmupY2+TqvLjMqXjNwYsCAc1Co5wy5FFRZFjmYj4/ATo7ljDEphEV/YERU/Di0XfRv6PSCc58baUIcmdB6AjMG0g7PEwNR16IhLNVCpG863a01LAix7UrvalQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p58LBZqAAtAQAjCns4TY81x7+PiDFF0gMFFlkYFgEv8=;
 b=ld3ECSUa/JPG3XLGHvyxzelZIxIJsXNBFydWj5Qy2Jhuz7vuQzEoSYkmYmDD4WPffpO2ekNpahGO81j5leHlrU+ObdBCuPGM6xl9AjZSUkhQcCHeZKfG3PRuuosmRqWSfJJZVdiiXczqsLog36IGLEIQIYljoIiV103kO6eaGnLyuPK5cf06MgJPY1qaMUqRqTUStCwe34H+T1+1C0YVz3bg9NnD9r+BqiIJ9cH5hE/W2/19LcWHNQuO6vN2Pf18beKrinbDB9qG8BaZPs9TnniV42XL+YAXJaP1oqBvuzLuZW9yfmU6dKOmDOmGiL7OaGbTt5GKaLZD+FulSXny9w==
Received: from CH5PR02CA0006.namprd02.prod.outlook.com (2603:10b6:610:1ed::16)
 by CH3PR12MB7642.namprd12.prod.outlook.com (2603:10b6:610:14a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 08:10:10 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:1ed:cafe::3c) by CH5PR02CA0006.outlook.office365.com
 (2603:10b6:610:1ed::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.31 via Frontend
 Transport; Tue, 28 May 2024 08:10:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7656.0 via Frontend Transport; Tue, 28 May 2024 08:10:10 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 01:10:01 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 28 May 2024 01:10:01 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 28 May 2024 01:10:00 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
	<jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: [PATCH v8 3/6] iommu/arm-smmu-v3: Enforce arm_smmu_cmdq_build_sync_cmd
Date: Tue, 28 May 2024 01:09:51 -0700
Message-ID: <a31b8c73ad31e9d61ac3fc9ba1d56b2439bcef0c.1716883239.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|CH3PR12MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ffbd68e-a013-493c-fdf8-08dc7eed985c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|82310400017|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e01tgyz0fSHVSoPc8dlMFt+D50IZxWQPGcHuXTDujouf2mCOYyGAyR0nPOQ0?=
 =?us-ascii?Q?kTEXacIWZLXD5ZajS15T/4el2ty8He9x4M1I4xhDAdtM08g/lcrC9xcCP4Vb?=
 =?us-ascii?Q?qiw1y4AdWya6jhayDRpRlPN/qgvp/eQG3yITdTaoMC1/Lt7Uz4WcbHdGqJWO?=
 =?us-ascii?Q?XN0GjocIGh2R7Z1M5cgOQ7C+M4bV+g5K/LAqxe8e5QHlf+u7TAlxloOr8K+w?=
 =?us-ascii?Q?WAYYLhCukFMr3dVd0O9gQB6af6rhFVzZt0TaYsNq5EujQxY/KqrVTQGuqv5Q?=
 =?us-ascii?Q?+7pbuqPuxmWJytGzK4GTItOGUM/xwfcCSMX/F+aGtRaon2bjoVFcIqJas498?=
 =?us-ascii?Q?dH9ASRC9INdfilKJRF0Q+r80wKV6JCfMSLgc8YZl7FZ+Eg4XPckfcdd8JRfg?=
 =?us-ascii?Q?U81JPW7cTGLJLLKKlXuCtqjltUD0tZjnMQBbrAlFMW0gnw/oweFFPQBUTQVS?=
 =?us-ascii?Q?sbV6yH0lU1YhwNRTAB1piQMsC6lV0EKZU0T9Y0B59fBxuPxmv2CngB1qEltx?=
 =?us-ascii?Q?8MMr6YkbLKF6clYhQNjSCYF1D8j5ZmwoU3j8O8uks76zkukZtIbS+2nNQE0E?=
 =?us-ascii?Q?AtK5lXfzscU0xzPgaqvtXDnrhmQ9brJU6u5n0Itu9WJ6HtmVk8aR890g6egC?=
 =?us-ascii?Q?h0N/A1rGVQP9pwTaVbtNESDMVp5HTUanj2XlK3S3YL94S5R4KRj3ODr6481S?=
 =?us-ascii?Q?OOZuIy0mTXcXyiRjBMWXIttet1aI/orZfW1OXNQRgmBuzqYskM0nF2bV4AaF?=
 =?us-ascii?Q?h9HvxgU+yUa0uPpSYziMvE3jnjb/wh11jaazRkZmdQjL86hBVaLiYLLNLqHx?=
 =?us-ascii?Q?NhsXJL8aoSeG2fE+O33Sq6NTm/O5pVkKsox74kuyTl8h7xkwjhQGKEurvr0H?=
 =?us-ascii?Q?tlo0X1kqMsRWbmJ493LJORA+FLwx/FsMJhlbEt2Kp4StMNXLlHXGET1lmj1n?=
 =?us-ascii?Q?Xd+6sGhzaw2TgzGFobRcURAOC67Nz69dsvx4fXS8Adjjn8eO/zdC9VsffEKu?=
 =?us-ascii?Q?8Hs4cae3ms82pikdbvmXiA7pK4NjQh+IrX7YbmG4LeHW4VrA5Z/vlNjFWRP0?=
 =?us-ascii?Q?mSFDQTyXRql7VVib1CpNrsjB4RaiIMmXe4sPKV8XmgOUNyvv/g/X6n6t3TJr?=
 =?us-ascii?Q?jvy2VnCD+J8KNTpin6Xts4UYE4ku+NUmJ/2mzsppexAvGOa5K0+WrCStZRBY?=
 =?us-ascii?Q?KI2LhP7wSajaDobZoQ0LSaXYm+CTwKw+IXEPHbkx1lWTsPi4X9PJeKIjnDFY?=
 =?us-ascii?Q?zGZT6V+NwvNPO41g96s5sIJ5uGw0boWHtO8HeNVYMx+tsH7KRgZOC5MO1XK7?=
 =?us-ascii?Q?GxR/GBxOgOWQkZ0aNMWR7X9X2/TRrq+w45fJ1Z6HxJB1C44/GBcPDeszdPsG?=
 =?us-ascii?Q?RtPLKkO3NLrxkG3I3WzlKP+Q1CoQ?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400017)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 08:10:10.6785
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ffbd68e-a013-493c-fdf8-08dc7eed985c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7642

There is an existing arm_smmu_cmdq_build_sync_cmd() so the driver should
call it at all places other than going through arm_smmu_cmdq_build_cmd()
separately. This helps the following patch that adds a CS_NONE quirk for
tegra241-cmdqv driver.

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
index dc8e9a48fe62..c864c634cd23 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -325,16 +325,6 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
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
@@ -350,20 +340,23 @@ static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
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
 
 void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
@@ -380,9 +373,6 @@ void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
 	u64 cmd[CMDQ_ENT_DWORDS];
 	u32 cons = readl_relaxed(q->cons_reg);
 	u32 idx = FIELD_GET(CMDQ_CONS_ERR, cons);
-	struct arm_smmu_cmdq_ent cmd_sync = {
-		.opcode = CMDQ_OP_CMD_SYNC,
-	};
 
 	dev_err(smmu->dev, "CMDQ error (cons 0x%08x): %s\n", cons,
 		idx < ARRAY_SIZE(cerror_str) ?  cerror_str[idx] : "Unknown");
@@ -416,7 +406,7 @@ void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
 		dev_err(smmu->dev, "\t0x%016llx\n", (unsigned long long)cmd[i]);
 
 	/* Convert the erroneous command into a CMD_SYNC */
-	arm_smmu_cmdq_build_cmd(cmd, &cmd_sync);
+	arm_smmu_cmdq_build_sync_cmd(cmd, smmu, q, cons);
 
 	queue_write(Q_ENT(q, cons), cmd, q->ent_dwords);
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 8e4fbf4f50f3..180c0b1e0658 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -512,9 +512,6 @@ struct arm_smmu_cmdq_ent {
 		} resume;
 
 		#define CMDQ_OP_CMD_SYNC	0x46
-		struct {
-			u64			msiaddr;
-		} sync;
 	};
 };
 
-- 
2.43.0

