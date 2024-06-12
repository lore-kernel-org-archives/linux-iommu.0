Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7305112C46F
	for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 21:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718228765; cv=fail; b=PiploDOX0Wa9ZDGIrnQffLQeGcBnVdPg68ET2HA2Qwy+4S4CCbdO98H3eiHOe6v9mpEJmxeB627KWcmlTDEoh7JHl6thRR8QOVLyDDmC+2kXBGjov+amPcQS3arPaxnuvj0vtjkUoRvDLchsF7CTTNn7oORSmIwXBl0AW55Iovc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718228765; c=relaxed/simple;
	bh=Fd+wCylJzh2iwYuCBNVeceSS6JphZoUV03UJ0wo3xHQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aRtDY+lWOkSBDI8LM5HP5urXh2fFQUdRsJ17k3qlMlkKF83zPGbfdVQMCkknCzqTBdSL1fvvZRHeRLoEuvJlHnNgiBbS7yEz+S1nUhLfJSa2sY/vPsAd2MqVO3WSnj1sNp6NlXSpIjOp+twthODWY384HYMweFOh/CCIKW8VX58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=toODc0f5; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="toODc0f5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXmpaYCeM+e4g1y+wPg3G8qRqO4Mii8csM/5x7rKDSeCadM+Nzbe0b1lWrN75qS7q5PIRL0BQ77FnxnJNZv+GltRHAVWI5nSXpV4y/DdzDy1bFxEQdO6Wa0EJNb0OT7IIpn8f4DZE5pH9oLgKMdRwWiwb3aIDTw57Exicura2/AFpjrFBfsfT+zQFwvlRb3sOl+tFlosRrJxeVEVGrKj4dbljof27bIXWEUfsP81yPoCMpZwJ7HkQJBFKDUXZw4pmvGqInj3Lj+dQMlHhFW2Cfu1cKxVPkv9XCVPwlU8wMuQiVf/ox2J8qzLz2czT5i4YTJPp8Qzf/0d7Aj0xtLMeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p58LBZqAAtAQAjCns4TY81x7+PiDFF0gMFFlkYFgEv8=;
 b=Qjlg6DvoVRGR6phKUE3mhGIMfi3/k9L8Q3vVUgOaUZVlyvFr8mUwHJNYnSSMNtQ13Rq57SZvJtBvJJXrrvUSJ0B76iZLH6Fn80rKCLEINpqNci1agVmmEqRxsKdbOvie2puXfRaetqhljo/rj1xzSjejNE6uupG0GFL9HgOxizL7Zuh8cPi+b/7lEfRYCbMTNIib2Bf36XQ6kD86sByXm1BxD78Xk9/+gkfVALQTpxMrQCHKZocO9VV8zuwsjnVdS6JGUFi46LqDW7C/dzSM72SE1ARNW/QMMZ4YJAd2uqQiDj/D9ynF++4M2Ti3PIZxhSMjrA+v6ASEjpD9dM5DUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p58LBZqAAtAQAjCns4TY81x7+PiDFF0gMFFlkYFgEv8=;
 b=toODc0f5J9/Vuv+0XYAI38eFdfl9cUbCOfsJU6enWZzEOsVFOMgzgJqVGtBDb8Dwf7u3crW7bgFyio3hlrm+Ypf3odPrdSl6TJqphwn/wW8D4sPd8aF6hgDNNT9trcuPHXjIZqqdDag8i/adb3zxfYYe5rnMTzM2fjyuI+kCRCej4ir8mF/pYB/PZ2VHQgr4UaWOIqHzGCoXyqzGwYDc9EefbeiIhbqTO03f9aw5WcOsyqF/WMXAkHGZj6jVkYKBWnHMyKY8s4wSrbLDFxqnVjsJNtcB7nqFmXxq1JAw87zxQuvo4n02xgfQ9snkm9pe7G6ilN2RZkFoUG0xuiEJiw==
Received: from BY3PR10CA0015.namprd10.prod.outlook.com (2603:10b6:a03:255::20)
 by PH7PR12MB6586.namprd12.prod.outlook.com (2603:10b6:510:212::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Wed, 12 Jun
 2024 21:45:55 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::c) by BY3PR10CA0015.outlook.office365.com
 (2603:10b6:a03:255::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21 via Frontend
 Transport; Wed, 12 Jun 2024 21:45:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 12 Jun 2024 21:45:55 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Jun
 2024 14:45:43 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 12 Jun 2024 14:45:43 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 12 Jun 2024 14:45:42 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: [PATCH v9 3/6] iommu/arm-smmu-v3: Enforce arm_smmu_cmdq_build_sync_cmd
Date: Wed, 12 Jun 2024 14:45:30 -0700
Message-ID: <44195cf7acee6372e85474e15154e05183d5d9e6.1718228494.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718228494.git.nicolinc@nvidia.com>
References: <cover.1718228494.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|PH7PR12MB6586:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b541a81-90fa-4fe2-2f36-08dc8b290a07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|376008|1800799018|82310400020|36860700007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HGU5TjU6BTaWLQF99dbViQc2xIckdmhRKkVmNkuOHKv7yplp0ZgkOIW4ocAZ?=
 =?us-ascii?Q?CvW11fRlW9Bs6BpNUDLtaunF7/ZdiMcy5bWGZxK0FwEOV1v4uEGp7pAhSxir?=
 =?us-ascii?Q?YbarShkrQJmkOQsAFUBSSi86fffST3MXp+TjkbD3AWo7j/GNQ2g2t8L2wT10?=
 =?us-ascii?Q?PCZcCWDXQb96+qacE8HLHYlYcZe6NNeiWMOJ+U7GyhmLeHx/jsrzXdFEwPl6?=
 =?us-ascii?Q?zUbZ8xWENwQYDPBPQ27qtczEnJF7tBEQsvs7TKOwvQSULnZ2MXUnLQYUclj1?=
 =?us-ascii?Q?umDekOTcEUP9t+HvjuT9OpsQxmI9llUNrcb03Q9BvizsZFUeBOVHNjKNQ1gr?=
 =?us-ascii?Q?h2OQJLQMpeox24fbPN+aaAVuWhc3mRd06VWkwo6VX1w15Ief9Txo000IF5AK?=
 =?us-ascii?Q?F4gwy4oLW5aV1i7AK+WwGXQnmrstV8jBEBM0TTqJaYLa3Ef4fpup15P6Lpwg?=
 =?us-ascii?Q?ib5p92MxKqpqdLc2BcIST9j0tlyQ5jkVgs+YdieVWfsUfu8/E+RWZ4IB84jV?=
 =?us-ascii?Q?VGdtWe8ODWseSAQ2suEVi/L11LHvw8v7rhIXvMdeQ3X6mEaO7+I1dl5qTODx?=
 =?us-ascii?Q?WRZN9qchfT0eNK1vN8S4gLsQgv/OG0UiaBH+6imSA6i5HQFLmpU2ujBnUqqb?=
 =?us-ascii?Q?ibhNkQhS4baKNRIvRGxFMflvL2H5hs/FqM2Gu4Y+EopGQM3bYyvPkFoJQSDf?=
 =?us-ascii?Q?WmWhtvjKaqSTSqn/he+cR23P0cA3lyeyTJZnPd7xbqziV4NDjdjw22tq0bnC?=
 =?us-ascii?Q?zqS7ngRtx4207EPSt7tvhqIlfWYroFyGY7t6pUBrUbvV4yuaIQk+71RnPG7B?=
 =?us-ascii?Q?C0Ksx+PmdFJBbnM1w9UCy2JHLdbZManYyV9HfKsx8aA2sAmssRqhcc4HS+2C?=
 =?us-ascii?Q?XbQDQYaVbdRW3PSpTMueS1nq0I+YQ0xgjRRFrV0shz1d7qWmRb381HlBO9ti?=
 =?us-ascii?Q?+DbHmylostR+87T/aettLhjPsh0Lk6w8PTYkWsOGzBz9/mRr4/mKoMyF0p91?=
 =?us-ascii?Q?HHdH4mXDDRQcIQ+ucWZwK+6RpZoGWJW9EG37og92OCJ3K/xtttVqjsJNSVOI?=
 =?us-ascii?Q?yTAS01xFQjTSYdF8R9tC4OQPBIgDHqYkeQC3drIHt2UICn8kskQ9CI+8Nunu?=
 =?us-ascii?Q?YsMmld437QF8P6sM2TF7qClpvaNEHjH4VRqLEm5e1KRbFXMN65Uzfn5AaWGb?=
 =?us-ascii?Q?/JX3xmYaKCDnFooKv0sH1K1XfZs4MZSrDg/RWrdsGYrCTQG/8VB2/pQW0Yvu?=
 =?us-ascii?Q?NiwSJgTQoZl/QudOMFtWGoagCLK4xkBa/eE4vtCZFnjgkwont4+17dh/IaQo?=
 =?us-ascii?Q?4913jInqBIuOu08pSQNkbFVfpmeD1cbpfmTbKAz1Rxaw5KBMfcrUHeRerdWf?=
 =?us-ascii?Q?PueTaeKj14zQE3bUJ0joQsT/9Lvm9lBGAD8sK/oWiP9vcr3Wiw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230034)(376008)(1800799018)(82310400020)(36860700007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 21:45:55.7618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b541a81-90fa-4fe2-2f36-08dc8b290a07
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6586

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

