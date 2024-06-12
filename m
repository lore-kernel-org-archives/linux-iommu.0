Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BD112C7F9
	for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 21:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718228769; cv=fail; b=O5ziOQXIMIiB81bRwt6SNJHLs4ThdtaBBeSMS1S+KXpsxRaBbw48UE8YJAubbwNOa85CislBOtprKOjApzDRg7YIvW2uCtnjr1LbZjdEpULKR6TKXuEPSr17iy/itz0FK8Og+rzkAaJ1FM2oBq+QqfzmkDCGkN5L6CFK8xifxCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718228769; c=relaxed/simple;
	bh=xH5s7JvwsiYQLh5gUauFhjPvNmck7XmBLAzXmVrg8tE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fy0u4ZeczvkuUUwm63HSDrVC0y/GwZPhjVrDwTtCVXi820T4WXGptzt8zEztDDdTR+azzbpZt+98ybQsubJ05L+NAtPQILDmE7xUItDmysHYl/dxsepE8Rzzb/TnqCGbKb+H4i4KURBeN/OY0CSGLJjWZd/djFGT6bit7ElKKoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gC6nS954; arc=fail smtp.client-ip=40.107.93.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gC6nS954"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnPNpgoXzxWRtpBj/bVT0neSrRcYJpc4zy45TvTmrthD6Iuv6FaC+4OInGIfY+2vJ90opG0akeUNQgMLV5cAph9R1OzTWDBGDeGt/ZHnc1ss1fTVYq7GfLkox9VvV5T3CkcbxmV45dzst0WXvyZsIAvvMUU1bpED8CWQqspH3Yo532XOuy/FfudkobDYO1oDW0sIDKAz/uiH5nGSplmJH2kWNxL+EoI4Sxxdfq9H+8cytFnCinrNS0Bbe0m4kS+FhDMsI/PGmjlZtqr8tA44UyJraVak39Idn65Its/RAsekpDIOMJ4CG4MrE2CjdAe5oDDcPfe7avzyCfPVG9oQPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMyP21saEB1xdQavsR2dcpHJX3F77VNVbvhPlP2ZKsA=;
 b=JI1PFOCo8PdhixoKdaALsdR/0DufMNqRPO8+J0IlfF3JIGu8Ap5q1auEAnYG9nPHexSJMAB93pcrtXQy0eDTzdz7X8fWP9fk2YgHDojf7B45+aNfO/LLrZfLuKu9pj1HGchWlexqUpiXVZ+xUm3s5KBFMIYouU+8YSXQy4WQm0Q7x/v5wzni635loFfbMRcyxTS1EfY6EIG8kwW7sl02pgOx5f8ettkpbB+s4V5GrLnlCYjQgS6NdeuFnFQ8vqTpvTf8bQLBilZfSDWI0TnzGnLxGjD741tnYKbnHWjQUmu15AaTs96CZe+Y1J/UnW4T2AG73ocAlewMGEmqQx0Fjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMyP21saEB1xdQavsR2dcpHJX3F77VNVbvhPlP2ZKsA=;
 b=gC6nS954Qsgq2/gtzN7zheEvY7L7rx2rwPSqEEJ4QZUAYIvtQrnCjndoZaWNhb/PMSS18tE3XZTbbDo+UeMSmgI4m6SpH/l1rJcXKp6zFK61nDWyh41wn6v2gkbpuJN5T0fCdvRV0NZUklOvWINfZuIiNEemcZU8YPWdSvjTyhWHUauG+uTREvOZcrCdXqB7iUC1zXkC/+SvuRx+62lT12cIrVIACRsV2GU6WnPf/2dW9RRPzJXCHVqyoV3A0m3ussIjYv8b9mmrJVBaeASfZLXYyil7mjIHKX4kGd9ltMdymy/7qwr/jKItPEXL15uxeo5TF7etp3pP0Sir9saD5Q==
Received: from SA1P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::33)
 by MW4PR12MB7215.namprd12.prod.outlook.com (2603:10b6:303:228::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 21:45:57 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:22c:cafe::a5) by SA1P222CA0015.outlook.office365.com
 (2603:10b6:806:22c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21 via Frontend
 Transport; Wed, 12 Jun 2024 21:45:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 12 Jun 2024 21:45:56 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Jun
 2024 14:45:44 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 12 Jun 2024 14:45:44 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 12 Jun 2024 14:45:43 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: [PATCH v9 4/6] iommu/arm-smmu-v3: Add CS_NONE quirk for CONFIG_TEGRA241_CMDQV
Date: Wed, 12 Jun 2024 14:45:31 -0700
Message-ID: <d20dc9939523fac490bc02e57d7836f680916a36.1718228494.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|MW4PR12MB7215:EE_
X-MS-Office365-Filtering-Correlation-Id: 25e9788e-575d-4828-06d6-08dc8b290a7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|36860700007|376008|1800799018|82310400020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fV1M2gXZ5jpmDUn+JOkVD5JoHFIzjBIP+Tz4TIgZopJQ06bj4IQIAk85BSyE?=
 =?us-ascii?Q?EIqvd+55a2CUPe2iS0r8QdQKLu7VLywtP1+OuCwtkI0hpZEEcBBvVv4U6t65?=
 =?us-ascii?Q?T7L3as53xmoxiPDuInQt/V3ygiIqJDm0ZRMFH7Ps3wdetVkdn+BnQ+Zd8NrY?=
 =?us-ascii?Q?9Ulkk7YKYTmfSZtLNlS502WPYPvVTIJTsq/DUgGiuk1RHKvnZxYWMLdZG2xv?=
 =?us-ascii?Q?F5qWsb2Ba6neS56rx5o80UpmVzFuEJapMYFNvkN+rjrCb+DoO9Igz0P5G7us?=
 =?us-ascii?Q?v5FfKYW8NwaZNs9DSJvfbAsvvJRc48hnYmWOw/JkXSnez19YpyrK1k51L641?=
 =?us-ascii?Q?WK2Y2teFtm+sLoD6tpQGQxtshs5hFDQOr/uBs0qBqDw13g1NxY9w1HnHBSHs?=
 =?us-ascii?Q?lnqDMwN0TMpNq8SAu1H42hwWr9AA2aP/8lM9In+M4MCb5mg5gJF3JaXEJfk0?=
 =?us-ascii?Q?nNr7RoKZYEPvLee4hKuHqoucHKk2Nrs/28U+JC1njBWZ0XiThE0EiAuUY3CJ?=
 =?us-ascii?Q?24lph6dP/TXi6Dg314rv4uVf9iPgiYCQ+bl27CXqheGklV7lgNyeSyA2vvZE?=
 =?us-ascii?Q?zIVNwgVvmQk1KvsTmb/sMO8qI2cDgQHJoZ4sTjdwmQwHP6WvXcB6sDwWv5cC?=
 =?us-ascii?Q?HDsQFKZb6ySQzGCEcw/hpqZrU6Fao6LMUylVhQ+vwb4mrTZ5q6mEeHP/RJvy?=
 =?us-ascii?Q?4D0WkWrOMisiNGU4J1TG2syU5vl261+U3lobfeRKNGJn4H1an78h9o7yJhch?=
 =?us-ascii?Q?hZcHQ3xFEoXvPbIzcbZTP/xmVWXSR/S9LSeNKR3jDz8ojIE1jYJW3RRil7YG?=
 =?us-ascii?Q?n2LzDLP2KXAdY6db8/yk+EajZqPLdvDRF4sukZsvCZjZDugiOlfaCMoq9e6u?=
 =?us-ascii?Q?k7Eo48lxF70sX6u+99NwLxHrqN/4PC7sW/YcpO8nvwueLyEO+V34W+3CV+Vh?=
 =?us-ascii?Q?MN4EDYXfgupPEDhExISm8oKubadSFn0TBCQewjatijN+HJCbChPlPOwiux4A?=
 =?us-ascii?Q?KZxUOrtdcmEzS63946K3DfDo3OCA2OceA5anwwfQhA/fjquwEJ/Hmok7W32N?=
 =?us-ascii?Q?e05gBzQ8+KtHBMoTltZ6ay0BKZja64tZZcijsPLIPH3w9aB3akKvoTw8yYAh?=
 =?us-ascii?Q?FD4zTbUWdvR1Y2lFjytzpujMgh+R9681CQ5qULeo/dGDPMewfo1lT3zVnQ90?=
 =?us-ascii?Q?tl8naU09RNNA23UlJ8cU0m9/sQEdC/8X2kWdlTImJvtNoyn0ye2KxLRaYPQh?=
 =?us-ascii?Q?wKZfOKYk23WgoC3VVD7SDXrRT9yPo6WXFzHhaYEJPU3L6y/Polr5+5CAffQV?=
 =?us-ascii?Q?Y/QrKdAD3MLKNuNsnGZ6VFL9mpR8wZLL23ChHP2E2DT1lee+d0iHtuupi/G3?=
 =?us-ascii?Q?xbR3Vp9+hVQcp4snSDAdPBoHwbJFFSHtTH3nqTbPYxLdi42mGQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230034)(36860700007)(376008)(1800799018)(82310400020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 21:45:56.4847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e9788e-575d-4828-06d6-08dc8b290a7f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7215

The CMDQV extension in NVIDIA Tegra241 SoC only supports CS_NONE in the
CS field of CMD_SYNC. Add a quirk flag to accommodate that.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 +++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 3 +++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index c864c634cd23..ba0e24d5ffbf 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -345,6 +345,11 @@ static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
 		 FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH) |
 		 FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
 
+	if (q->quirks & CMDQ_QUIRK_SYNC_CS_NONE_ONLY) {
+		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_NONE);
+		return;
+	}
+
 	if (!(smmu->options & ARM_SMMU_OPT_MSIPOLL)) {
 		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
 		return;
@@ -690,7 +695,8 @@ static int arm_smmu_cmdq_poll_until_sync(struct arm_smmu_device *smmu,
 					 struct arm_smmu_cmdq *cmdq,
 					 struct arm_smmu_ll_queue *llq)
 {
-	if (smmu->options & ARM_SMMU_OPT_MSIPOLL)
+	if (smmu->options & ARM_SMMU_OPT_MSIPOLL &&
+	    !(cmdq->q.quirks & CMDQ_QUIRK_SYNC_CS_NONE_ONLY))
 		return __arm_smmu_cmdq_poll_until_msi(smmu, cmdq, llq);
 
 	return __arm_smmu_cmdq_poll_until_consumed(smmu, cmdq, llq);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 180c0b1e0658..01227c0de290 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -543,6 +543,9 @@ struct arm_smmu_queue {
 
 	u32 __iomem			*prod_reg;
 	u32 __iomem			*cons_reg;
+
+#define CMDQ_QUIRK_SYNC_CS_NONE_ONLY	BIT(0)	/* CMD_SYNC CS field supports CS_NONE only */
+	u32				quirks;
 };
 
 struct arm_smmu_queue_poll {
-- 
2.43.0

