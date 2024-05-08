Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DE5179A8
	for <iommu@lists.linux.dev>; Wed,  8 May 2024 05:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715147834; cv=fail; b=QzF/HtSotN3r0dnsVg/Px0rXszwlcsqF1ww56mm7Kg7bEAi5ofFdv+K/5jtQfaCnvf+8wiphG9WRONdBZthWN3p4BdPMlRwbnZsUMg7Pqh/+wBPD6FtQFEkKXqi3LyKlJ98BUwO3cyyjd9Qlp6tqQZO6Bm5fOAS5R0juqItrMD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715147834; c=relaxed/simple;
	bh=qsoTBh3BuYM9qODjOTP9a4NKPxYJfk+TZ+j72MgPVKA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iIQ73RSn6q9EbmjWAc4ghYopqtUu6qq+asLLxaOSbFmXZ7ifDGyXjyPtFAENdDqio7I2wWwEGELzStZoDY+SVP9lxX/IdssQRiegQQlqm5R2FNHQmas4JeUoPwqIWgi3ogdFd3rmpd16+4HPXyZZvuqh2HNGRyD5KOlgg1+53tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hxeIXEoA; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hxeIXEoA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+Ztnp60jTT2wHg8SBl90TOmsrfdmQ5TAoqUvHm1vcoofMtnIgekihrg/Y8AIOFGdL/FRzBmw/JXwcv+oJfNx1aG+fMZxtoIjK6zTn/umrsdASMyKIEEIfkLG00INh2eN8fInut1gCVQxrcuWRUkXY0jBfxB57hUBjBqd1ORFMXluY8JxNJnhSSjJOsW+FBwmQgh/hbiFKHA0jCR7S8azmKmJWVJo44YLjBgWaySC0i90e9Mv/CIYrFCRZGW1NC3ZDxHs14L6fkscvsWzHPJf8QQGTWU9voOatiJIF7+5/U4TAq24lTqNXzKYmkxiuavzh84DRpi7gSex2NHf1hr5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/tmEJmXg0E+Sfc2jtKhgYxnVnL1eJjiqNTIjC4+B/c=;
 b=Dx9yqtbN7yLUsdFhJktjH/rLuQ7W29WbKx+IZkwCyaoyck0bN5JDS6SEB80LrphKuwrY6KX2t84o1LlAgpsQgGZNtjwIj7yz9XGMzirK6Z8YOKsze38Bx867pMUv+tOT9VjGspHn/RZrnxOVjPi7WYFAUKrkwjIg/oLfpFMouXKgos3jiX/CMeQ9TFVElkPC05oZdx6dhGv8vcFCk+JaivGQ65Yf0UfUOvDSxX77/RR+Tpsj6dxL1+/+blzJTDei26X50f7J9OQM2X827Q+RxZdZPYGaswSxqvrJGGx/L+tqWltkny0ok1QTbcT9r47DwTVMu3UEjPMYWKbRlBXzEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/tmEJmXg0E+Sfc2jtKhgYxnVnL1eJjiqNTIjC4+B/c=;
 b=hxeIXEoABC62AenziWq/zpphPa2PQvIupAfXpesk4xeceBn9Ib1C+AoRJDyZs6MfChlIUkaEtm9h+OCMl0TeiDqwX7Albr0eEeet20P+UM+neSRO9T2qq7rZEToH4wXxxRCw1tDpKN6AVZlcGcigP1sb0crectZgPtwxIyP1yAHIbCzTH+vrrh/95EtZnmkMfKt0oueig6nJN1Lqdf3IIzP7xoNcOrVdM7JOghBq2f//9RwZJ5l+WkKJP3R2RDmtQ5eZxTDJWRGpSzKS/kw/hqJIn94pA01R3WyYMuknLUx2rPUvnb2wGU0UisQag/RjNWIpZ2qTCaJ3Zlvge7qhIg==
Received: from BY5PR13CA0024.namprd13.prod.outlook.com (2603:10b6:a03:180::37)
 by SJ2PR12MB8847.namprd12.prod.outlook.com (2603:10b6:a03:546::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Wed, 8 May
 2024 05:57:09 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::20) by BY5PR13CA0024.outlook.office365.com
 (2603:10b6:a03:180::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43 via Frontend
 Transport; Wed, 8 May 2024 05:57:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 05:57:09 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 May 2024
 22:57:02 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 7 May 2024 22:57:02 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 7 May 2024 22:57:01 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
	<jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: [PATCH v7 3/6] iommu/arm-smmu-v3: Enforce arm_smmu_cmdq_build_sync_cmd
Date: Tue, 7 May 2024 22:56:51 -0700
Message-ID: <52845c9fdfdd7f38a694e7727f3eabbd10e9f8ee.1715147377.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|SJ2PR12MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: a42c33d5-bb45-47bb-67d1-08dc6f23b319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TOyMw3N7k5IxgQwuPTsIkeKVvN7U3kg1wRSD2LK/v1Y/BPzNPmwJWp/V1SCY?=
 =?us-ascii?Q?FU6u3S1OQJyyN84WFxYx54RhP39XxfHwkwfVfaymaMJnsUaIT9FUFyIH2L3W?=
 =?us-ascii?Q?FvQqRB2D2i2azkggcG16qcgyV0VM/QrlfI5ZAGLXUMmqZMDDfcMSRrUEikmX?=
 =?us-ascii?Q?kYROH3TPDkghfqkEu8dbvbwPfkt6oiOu3VszwXITe0CmpniaaDj4IvnIXcbs?=
 =?us-ascii?Q?M5IVi3Suo1t9KrAeu+wvxsINZbQVGWoSSaEBy4IPDySCKxjrqzOfBW7J1EHn?=
 =?us-ascii?Q?ZFIwnIOrQxGl/qu4GZj2a30qtU80TjFS0oF2WNkQnqVvMeEZXG+HttHPUOcu?=
 =?us-ascii?Q?lrhGNMV+XVRlPS5SeMppBRVSrrzrUyKeEhdJjDsdt8Gh9Fdc2yoTT512gWuB?=
 =?us-ascii?Q?zbZU7tvK5uZ7Rfs1PuCefkWQVtsf9g3/zysXtnjlfiDTkdAxv4/1D73IdMF/?=
 =?us-ascii?Q?SCM1/2DEDOLon1okjHyw2iKGRJ1AFWh60p9Y9d2ZPEmuRMY6qTI+o8kMe1Yo?=
 =?us-ascii?Q?+qmsNbZ4iyN6v84V8PgFoJweXqErqRnkVddBDjWZN4D+Fa+vdLnu/aB10Fyl?=
 =?us-ascii?Q?rkoLTpkbUOP4y69Bg7rIAnWT7IML2JywlyT7huzSZbLB5na7qerjC1NYLiid?=
 =?us-ascii?Q?inVOkOfIpSmMNWwv2q8GVECdUHGEnGygRmfT6NBAOitjdQdIkLmwQefuP50J?=
 =?us-ascii?Q?k4GbL5vg2MphYY7ZLB18D3xgLsHyKOvpCRfmLpoKPnfEGV4kzNRWhPHFBuX2?=
 =?us-ascii?Q?TeDojImXZ3lWDk7z/WP0GOZdn6gKFJInI/XBVLJPJieSSpcpopjse+Mi6pDk?=
 =?us-ascii?Q?CZcHugkGh8KofNe4xc4Yn8LZSWBbY3Wjk1LPcMXK8uX23bmwasKPTDjUpZki?=
 =?us-ascii?Q?7haOAwIfra0S3XUr1HQ6lwdSVYhvl6WH8H0ulUFl7TcexmGXn84cp5P+izLt?=
 =?us-ascii?Q?8K3Zaey5QSZNH44pee1BPIzXX6LCnY148hTk2Xte1UG0kMRKQzvxGldxlK2r?=
 =?us-ascii?Q?U0WZzf31tuGj3R3VPeXCMriBcY1tKJ0u5rmbRIYKrDPclcTaEvhNrVuHupkH?=
 =?us-ascii?Q?V67VgbzD1ynUh/MZYTmog4hvp9mspkIMo0jqY1cMNdPSZ9NQ1meZygOBGdjL?=
 =?us-ascii?Q?23r/XWIc0+Y1lIZkH6RF6XXwG2rEZEnX9zetV4UUqEA5shuVwI429FjN0G8F?=
 =?us-ascii?Q?np0K3ijQVZaNH4CYNirdYHiBzrZYJVoE/Fjss+McZDYGspB7+bmjisj8QSJn?=
 =?us-ascii?Q?FtrzlIGxMaqqBkv9TBcSc9Hn+xlcV7Y6nFwa+U2QLpTjnMhHSDA/OaX2CFp0?=
 =?us-ascii?Q?yyXFVwJse+dxNpWuTKerBDyIcTLqRrrBGKINpDdIDYrkUPycIXXE0RNvz7W5?=
 =?us-ascii?Q?hFH7VymBivry5pNzZOJt5JxOkM/D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 05:57:09.8780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a42c33d5-bb45-47bb-67d1-08dc6f23b319
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8847

There is an existing arm_smmu_cmdq_build_sync_cmd() so the driver should
call it at all places other than going through arm_smmu_cmdq_build_cmd()
separately. This helps the following patch that adds a CS_NONE quirk for
tegra241-cmdqv driver.

Note that this changes the type of CMD_SYNC in __arm_smmu_cmdq_skip_err,
for ARM_SMMU_OPT_MSIPOLL=true cases, from previously a non-MSI one to an
MSI one that is proven to still work by a hacking test:
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
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 36 ++++++++-------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 --
 2 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 3d2962f6dbda..569bca1a8a1f 100644
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
+	memset(cmd, 0, 1 << CMDQ_ENT_SZ_SHIFT);
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
+	cmd[1] = (q->base_dma + Q_IDX(&q->llq, prod) * q->ent_dwords * 8) &
+		 CMDQ_SYNC_1_MSIADDR_MASK;
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

