Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEE87A715
	for <iommu@lists.linux.dev>; Sun, 28 Jul 2024 22:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722206716; cv=fail; b=l5g4dar5qGAwH7JAsKyxioqUPGFcIbWizXmKU2SoMbtSVDZKKwkS2QdfIYTsX/S63cS6rWXN6GSHKQ8/NWOBQZNEBLvHl9M03zV3RfBHbElIYM4zmxNi2xwilJifqzHlrXffM9o0MGBTylT+DCBwma4SJn6BU/lwW181zHiPme8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722206716; c=relaxed/simple;
	bh=qwaapivLAl6n71A5v+bwVuc4o0W0t7DrMzkVZju4Wzc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HAjbF2PBY07/6+CY3j1M03S80AnVG9cpdfrNDDSu1dDizaJnBdJxbqwl4cQy+fFUeEEjxZUWQ3+5HQW2yDeP0E5zEsJHfgeDqufXU1Zu0P+mp7iETRnW5ypz+4qUvPqpB3BM8iEuH3siXc7NVlzuOCB944PpMx2aduAPsPNNbhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rwDTo2SZ; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rwDTo2SZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IIf+hzBGrdPwQADjjtZy8N3X++1lo1pdUILNRiZClws/8S2GYJmOHHPz7uwuSdxIQWrinHG/M3cG4+fLZcEs7lcZ3VhI8o/lGHlSB9r7IHZtBEEXbbzVb0+wQR0HP4M5EBIKvV6O3ge4cBbefGOns1Inr8d/9yCGruqSPMcGBER35bZ+2bZiY02jid0G7XP3ylgxZ69GJdtgMZEOJ9nhI5QxaofdEfxakON7JX4uzvmGDbGUK1ashKBVoE5BsCRjB05YqKoq2QV5xUy2CzB3tJ3AZ35pt3aSBSBIDo/jpsngtzEp18FYjGVO2GlCF5zGu5h9+9IF/oTLqTBHFuCGGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+CorPqZ5Rgj/E7HLb5fue3wNMi97HXrFIPFf3cWV0A=;
 b=aIcTuJ5Kw5caqrj56ERCAcRuEh36QRg+SsFbrgqKFvkP+nUyMeoYxL1/xJXNXSiFoZ7aseIyc5uOY5q3uFWt47UXkoepsTXm6gYH2S1FGJzn+3jwuv6RdJ3NTEVWp1hUuNggT0wlBRG2MP0pBlRFcDIt6jFAfOZDIqrH+HXKV4tIWUhq7Lbch810u2Frleu/old5S1cSQVlK6bdgtHcg9457pS/loRnN6sKCOfhfAy4I/H7wczufGLud0q9uwYvIyoFjapae+lueUF5VdB1iCnsMyUNDEnI5Et3SzbI+TRXesqWOn4cpVNR1DWtC+z2mviWSW30EQlGEpwxLgKG0yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+CorPqZ5Rgj/E7HLb5fue3wNMi97HXrFIPFf3cWV0A=;
 b=rwDTo2SZLWeHg8HnAEJRmzjvhOKleTkFDgGHuDX59OJJZ9qGz958PITykX9s+9wTXHpxSbh76MjPv7EPvd+JGUUP1r+mhTmyOThh8aoy1xtBB5YCGTwOmnQsCx/jLX+h9k56OLNX1kXzl6NFRyR56uolpPpxrNh4UfXXEyepiS2pNYmExrRmx5PELzURZ8Q3GCwt1BFul4+4OKK7PRTvJJk4MXIDssfAqm3EqAmTmZJGhHyEMajx15gS0KuTCl0O6RhAwKDZrCGAK9c2k8theC9rlvwMbFmCGvXg9cPrtAeNRrclt3Gknv75B2Up9Rzn/FufvKL4zqg9oRGUxIG+kA==
Received: from PH7P221CA0064.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::18)
 by IA0PR12MB8349.namprd12.prod.outlook.com (2603:10b6:208:407::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Sun, 28 Jul
 2024 22:45:09 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:510:328:cafe::72) by PH7P221CA0064.outlook.office365.com
 (2603:10b6:510:328::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Sun, 28 Jul 2024 22:45:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Sun, 28 Jul 2024 22:45:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 28 Jul
 2024 15:45:03 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 28 Jul
 2024 15:45:02 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 28 Jul 2024 15:45:01 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v10 2/9] iommu/arm-smmu-v3: Enforce arm_smmu_cmdq_build_sync_cmd
Date: Sun, 28 Jul 2024 15:44:47 -0700
Message-ID: <176261860828f690958d93edf53569ca2505680c.1722206275.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|IA0PR12MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: 836de568-628c-49fa-6583-08dcaf56eee7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iEP1nUw6G8yXzQMT0pdPbuojGIMPmhZVs5K48QNxPr6iXNrjONLMReeRUnrE?=
 =?us-ascii?Q?XXlO7MrFZvSMb3LA/ve/kc/QLHX+jVKOe2A4xDHxDJQodNnLyB6RvaxPXJHt?=
 =?us-ascii?Q?Eul1Aj20X30CgdthG0kXyHaOW9gFr4Dnep6OtjPJDO14idwrUlPDlEL0GnqP?=
 =?us-ascii?Q?XPNIA26Pdg/T33xKaSsRgeQ3WYNnxPTejq5QVMwByIxFUSkGFAf3aNHr3FPS?=
 =?us-ascii?Q?cebuLk5s9LDlUC+CkQtYMA2gc4Csv9VBzul2rwND6tvnPGOWgdnlaO3d7Zzb?=
 =?us-ascii?Q?zfG6YkdDf16h+6404aLuOMZLNWWAzSSClobjF3JGd+f9w/iNbAHEFMYre3oo?=
 =?us-ascii?Q?uoT9i0N3mIx2H2zWTI66R5pwQDLqBVth4xV2D4ABKh+4QJzgG44AK6H2s1/8?=
 =?us-ascii?Q?DajzjU9Dli9QoGFLnltyH0HErkPDNXFT8DIOP3/QcsFtXzu3HCzPVZnKVE5W?=
 =?us-ascii?Q?OgdV8RP2fNXKt2p6PEFJxAvRkjLrg0hs33SpiVfFEJnjw9YuQdGthitxp9oM?=
 =?us-ascii?Q?u85gaLF7ALN8tAK8Z7PV2u4ZB6KlK3lSYgKHfc7mBLmkzQ6GsvkKofK3LYqd?=
 =?us-ascii?Q?Sl+DOqt/ZsmW81RJBEKBDDzyDcc1myogrtdanbhegZc59DlyFMjuyjSgD7E3?=
 =?us-ascii?Q?Vsq66vRFpCe541HOATIb770QJR63HOe7l2kkrerr+3Uv5fLGdMszJOOtPNCV?=
 =?us-ascii?Q?m3HE1naBeQDB8LkXyaVFE6IseAWOHkzDJbhgSYEj37IoB1kktCxJWO7FEIUW?=
 =?us-ascii?Q?JFCX/b3k7uIB+GBYy7rBa2OhrID4zO6eYHjQFrW1ujTeyXMWOroOTgu+RFMm?=
 =?us-ascii?Q?76S9XKbNjlx8eteaV6hg8yzKQHnT991Q+bSr1NPyEEVwJlP9oM9E3uw3WxRe?=
 =?us-ascii?Q?S+DMHCyF4n0Xo/IeR+RZzgpRohJPW/RHCKOgOlpL7MCj27aMvLEN+4l3M9ry?=
 =?us-ascii?Q?rtJzCey/jgsGO0IV0m4YLJ1eaBcZ7B+MfMdRU4CbtOFqTpCkqsJCj9nN7HOb?=
 =?us-ascii?Q?lZPAq/q2zIit+zfmWV1O7RVm5MiccU5hSn+DNGlNx6Xw44rFc8OP3z6pclH9?=
 =?us-ascii?Q?kk2yC13qY0dQxQqayrJ1gK39Gck+gyadZPEDAsS/G3fcpY22RKNFAu3fFrJj?=
 =?us-ascii?Q?wqURKSju2fpN2UR2K+r+EZQr9IqOjIxT02RpiW8b1A9gkixNmH6PqWDbx6xK?=
 =?us-ascii?Q?YVojMrnbs16FhuVy55jKO9d+5p4/RYKaGgqZpMnfzU2EG2B22qNxRAt9p0wW?=
 =?us-ascii?Q?OYHBdGM6jqSM/QoyyS/auI5w405TLAlZRtSBw9gLwDWan0qmGe0+4bc2xuUo?=
 =?us-ascii?Q?LqLH8Z29A6bJm3SDibXg97wT5BshxOAhsmcVmwCh/8DIxo7hzpbZkU0kbZz9?=
 =?us-ascii?Q?4msJ+4FfQWMy4uAWNJc35Nv4TAd5bWDbHwVJPPszDFYpjRYEv87akYu1Id+x?=
 =?us-ascii?Q?3g85a0WyLcdLvjKiv/IcpfmK0cHggwYP?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2024 22:45:08.9176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 836de568-628c-49fa-6583-08dcaf56eee7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8349

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
index f409ead589ffc..f481d7be3d4ec 100644
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
index c1454e9758c48..6c5739f6b90f5 100644
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

