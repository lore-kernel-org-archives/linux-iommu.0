Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B98E4A15
	for <iommu@lists.linux.dev>; Sat, 24 Aug 2024 00:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724458273; cv=fail; b=LkQuEoU/1qGXc002Bgt2PyLnGfADcKCMbV/ow/TRdg0L6ylRV3hBcL/8cdP6piIHiALCRWcxMIDIvYUy5Rop8QLdfxaY7wKLLdjYVDuJnJqXCMQ0+pdMrRr+zcTjD+ETPeHSNxR40kErYRPjbRXTjHrMqriEVcTWAp+bWtEhSdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724458273; c=relaxed/simple;
	bh=7RSf9cNKg4FdyWNDXjBzFLtYyU2FVqpfNhwoXjB2YkA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJ4aJRtAzm6XqR9KXxrviRth9lL+/KtnmIXkyBSWzQyveiBcic5GCadLeNBnd+CH3v80Un/pcLuzjkbDlnvYoFvyCFgvUe94tILP9iTHkUMY2Q/wt8MX0xjdzpCOYnSCZvKPR7Se0UiMmL9m9P1QL2ec12nUdu8M6e7doVJm+BI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z1txM8X+; arc=fail smtp.client-ip=40.107.92.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z1txM8X+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJfBvkQDoDqxNswSTFeAwKLTzPcuGRzx59KZ4XGD1HXm5GwnYMGDTIhwR/KmhepTXiVvBhM8g4Q6ydsNnzfVD2cGrxQuhGqgkFbt4TWCSHlmhBe0PNfUeDmJcv/akdIbdjT04gtnLf/TSuIHouaZbBMgKdCxcbqNHiQTkG2RWph5daCDaEj13UKWSGGeBe7KlSfDnGzA0h4/mJTkDBie6kDZcTztnCg60rJt7U1XZVsXaJ6fub308ym6WRtN39QP2oexiBqb/vi+Op27CxQ6HxLSaepeq3YwaEqrE9L0wbWgtTkkUNP2N251OgAlMeAlJYqMjUyoWls24A3BzJCqWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORK+NSsqSHnOkiY9lx3HWzYdW5csIHnAXDVni86Phfs=;
 b=y/o+0nfWVgNYdHmhJkl4t/iNfmsgJDFZ89szT/fDS9E3u4fEyd0kWUDZH5xbnq/WuFhY1aDwjVxjR7MqtRr4rmxmkX+MC5U0KdVb5CINTsm5P+/1LIhmz/meTg0MQvuBNHoZzEFPKdzzZ+qQ6RXZQ8EO+EqHM/Y7QE4O2gOis7KtC1XcEtElgAyBr6Mq/WUvxG2WlATZRU0Q9kXoAraMawhBilSLtIqt1vqir3AUfSnnMVEoqljYfQsAXa4MRoYp34HfMXdYB6XUfKmEKFlbTJK7Qk9mj4fT/WZ3qdcDxE7NNEOdecli8mfm2dr+DdaVAVVdJYgAbAvjP3gEQk/IdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORK+NSsqSHnOkiY9lx3HWzYdW5csIHnAXDVni86Phfs=;
 b=Z1txM8X+ft6sFRjFSzzB6OV46qVSMA5QjuOWMQiRogOAN4AY/f3+jtB+k+a8qHd4XGEkeyVhxkgPin1XWQdkYdFVod81jeDutvznf+5mjtjEoxMf3e7RbMC9MQ20WRfVUD+4hWRSaKFwmOaJp3eQPCTCNk4qs2BMeZzA1ksppgusZDrG9k6VPO4VWAq3VBLqTH7wNrVMy2G80CTFc2ybwihCBp6yX7U81tOxKLZp2Z+/GgoDJCfZZkpqdW86DBSFnlHQwjJhmou/SW4V/uS38cWcjz6rr2nnCfUf7OZH+qsPlJju+pDDPCvGyn/SO7QOAAcvmEWV+iRxhF5i8s/SOw==
Received: from BYAPR07CA0076.namprd07.prod.outlook.com (2603:10b6:a03:12b::17)
 by CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Sat, 24 Aug
 2024 00:11:07 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:a03:12b:cafe::f) by BYAPR07CA0076.outlook.office365.com
 (2603:10b6:a03:12b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16 via Frontend
 Transport; Sat, 24 Aug 2024 00:11:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Sat, 24 Aug 2024 00:11:06 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 17:10:51 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 17:10:51 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 Aug 2024 17:10:50 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v13 03/10] iommu/arm-smmu-v3: Pass in cmdq pointer to arm_smmu_cmdq_init
Date: Fri, 23 Aug 2024 17:10:37 -0700
Message-ID: <9aaee7729d6aa373a2729a8284601f6b0194fa58.1724453781.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724453781.git.nicolinc@nvidia.com>
References: <cover.1724453781.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|CYXPR12MB9337:EE_
X-MS-Office365-Filtering-Correlation-Id: af100c15-832a-44c4-1b1c-08dcc3d1400c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IIWY+S7xaZt7493w3HNjsPmdQ6XW99UHdllX4h2O8P+mmDVgo/A8AIKsw32C?=
 =?us-ascii?Q?vRtuAm7gE3XYHqGDBdBK7Je2vK2EDcYCORkzU9qvlY9q82rzRURAzAadOPDH?=
 =?us-ascii?Q?27Fq98dYwEWnHYBNs6XV7t3QBpqQIQwEM1tIPljcpDE1awBtX8mgBEIkKjcF?=
 =?us-ascii?Q?BKMJjI+XJVa/U+5wItYdx1vw+RhBtv8caatCyhXo/dvBU1G8v4ERo6WYynCp?=
 =?us-ascii?Q?y8nWKqWm0sR9v8TcxgGZVnIQ4GRKAuHrjr9AIppNjQuce9iOY/dOeJQckOET?=
 =?us-ascii?Q?rxLqweGI1PCiq62tFYslufWKhDKeRZ1ZVL4T6MXRKgXHM4iIu+p4HUV2qpoR?=
 =?us-ascii?Q?aT7xMiJCTXHPPBh9OqlFBkVOIRNQDfpoADhafJmRpqgg5EymirQOWN0l0o30?=
 =?us-ascii?Q?LooEM8S+sTdt87SioTR1AvDJI0poMQ+xQ3X8sM/bsxKXaJfkePM/m+GEPpNu?=
 =?us-ascii?Q?51vJTNcF3wUnmsQDd3SKbcK1j3/yqL7bx9xgL7eCUzT4yDpdvcf8iqkzNKVs?=
 =?us-ascii?Q?W5nFOjDJ/Hg5IXwALkxCAVFBPRJhhaCXTVc7KRWaYSoU5BtO8LwWuLAF1Lc/?=
 =?us-ascii?Q?idM0e8OJD9KthSAN6jW9FCsSGey2dkXoh6E3hHaPlIsnO61ziwWCnW74Yngv?=
 =?us-ascii?Q?bdwGfv+6UVjzuQWTSj3dexbynT3vNmvJmq/d+7Rai85VpyyQ7J78FTIPcuG1?=
 =?us-ascii?Q?8B1IHInqVjGyuKXyVC06ORryNlXSci0iLZ4Sdoh9bQ+07BRQbfZYC4/qfZJb?=
 =?us-ascii?Q?0QGgbjbUgWG2enlNGaoBCPqqh1MoA5s9FtHG0q3OpqU48Ov5jiVDCRUmK+Qq?=
 =?us-ascii?Q?fTyPP/d9Sk/TiUt4JRKpBR/RtrBFOohMAfF0WFHlt8cleUI9aJerXdsm6SPc?=
 =?us-ascii?Q?JfS6Hnlf462ZhW95GnqRnoIBDbgJ7x81Oc3gfRrerBCJ20cDHAmYLc7DGsmV?=
 =?us-ascii?Q?zoYTnQd7uhiJzmGA10sm89Ws7rs5e+3mWOfTQYohFhaandZ4nS7Fnm4Tw2bq?=
 =?us-ascii?Q?r9fmp1OmTSEKkm7VO4/z5sntkOJQj00bnLSn2AYAmyGQ/or1MY1XiNp495pG?=
 =?us-ascii?Q?GMOoLFvUVKBfCrzsn1Pmu3ZMYW3jepyUJS1GpT49pXlQbYeErnokpxFfteD3?=
 =?us-ascii?Q?ipwgoZICh9W+b/tMFiZJV1jUspnOW2NiREpF5nFcXHU8fVRe50poo597zPxZ?=
 =?us-ascii?Q?3FC3rOY5jmToRObmMSrNOoIHqCXNLR3aP32A1KUJvXFO/vskTPPgd2PJ1nJy?=
 =?us-ascii?Q?zT229fksUuK1nVpPD1RQG+bzFBifI3ryodco7WiBlNUSwOUHJRK8MlQGLhjU?=
 =?us-ascii?Q?GsAJWodSVheI3t6ckBecIB6HBB9V4iLzpJhy7Y2rajHmKpR+E4qd/C51/BRw?=
 =?us-ascii?Q?Hjlvtohh3fuKVQJI7RzvIzrNtYlf0qrgAx7gvnqPeCN37XyCyBFwrjrW9Dm4?=
 =?us-ascii?Q?7nCcNCWA4szVhB1anWo6v8bbk4W67hfy?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2024 00:11:06.8321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af100c15-832a-44c4-1b1c-08dcc3d1400c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9337

So that this function can be used by other cmdqs than &smmu->cmdq only.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 43ce8b9a517f..803789bb4cff 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3564,9 +3564,9 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 	return 0;
 }
 
-static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
+static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
+			      struct arm_smmu_cmdq *cmdq)
 {
-	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
 	unsigned int nents = 1 << cmdq->q.llq.max_n_shift;
 
 	atomic_set(&cmdq->owner_prod, 0);
@@ -3591,7 +3591,7 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 	if (ret)
 		return ret;
 
-	ret = arm_smmu_cmdq_init(smmu);
+	ret = arm_smmu_cmdq_init(smmu, &smmu->cmdq);
 	if (ret)
 		return ret;
 
-- 
2.43.0

