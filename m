Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAC68C06
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 00:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723769765; cv=fail; b=FrP8oIn29HnBXDQGWlQyirvOv6iBwAehbDT8eWkWQOSRNUS2D3lsIbg/9oY979NXewuCAdoq0OTwUZhsHvE8WtTnOGqXVPINmbAr8Og0cUYUfiwxKnF/bvYr070hMi8mPU2CrENLmvJbnS4qEcBtC4uSC2mIy6kMoDPPQqWRyJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723769765; c=relaxed/simple;
	bh=Zin+oMlBsydzN70EkRuUAvJz4PT2WGZ0fIkrrXdqYSk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hw5gh/ldtN5BHvaULBH84sH/y9Q1p28C7ZAmc3OXwnDqXQZ7nRAy9udcmWEtnHxU+VHzq9LhKlHTCa7OWUvbME04pNmZH90D5DirJzfdgPnZBzUXTvzA4jA0Q09JQttLyIUvb2npfI5m+IF7Yc0f7v4k4/r314gqEjqCs9BWAo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r29eXyMe; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r29eXyMe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TuUG91qbCUjsrA0vejr1VwWtXnqhZnoQTqA75SwjhkvE8F1/tA4Z2x4H8CqT5p07nIx42zBATLK53Xwb2p4swToIVPwFHjXN8xCDzZ4wFzuqs4gR47dy0vs8/Ir5n8OGgngMJMG3/Tpyl63sDhSnFo/82ycMdF49YXXH88p6ESNEMl95/l898bgIq82Uj6kdiaDEIT1DZqJovmIyWdOdjuxpFKtsykyrD2OPKSn6SIm7oToJWp/Rtw6z3FigfgdHJGCm+z9Xp1+qnGrB4u1zNh44JFMRXsVq7gkEjopJrRwEyneTIcHBN0gTyQswjrXm/2JNsSM2csZNW5GECIhYbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ryt9tmoEJuaLpkvYiyq3ueHbmGpTzI0M1d74hJIoy3o=;
 b=LbIPd4fBVPnErkt2NeB1sGy6NupLKkXSzYf7Ugv119sy0Ic4xsWTgaCme8eXrTIJ2GjrqhGn/L/dYVas2BKfkPtSiaWarGMUxHBvRt4sebyhxh/1p5XF7RiRXFknB9LmUzR7wql3d+mHT5N5rLTIRHHwfkBBP8FkSVaOlGFWDfGNWhilK7PMxAig0iYxnIO0fj0e8HcdgRN4AFhB6Pdlnupl31JlXVGN9komx7nrmfezJsAXVp3IQ+hzWk+znmjUwiFESZeQhcKxfOeF1f2vo8UAEYwFKF3qxKcTvQ0/5MHhg5b9eWjs14W9ilawQCa9kTxBikCq1IybWKuOJUVVnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ryt9tmoEJuaLpkvYiyq3ueHbmGpTzI0M1d74hJIoy3o=;
 b=r29eXyMeYEyXj9tCxFXUo5UubVkaIJYSd+IlSJgqD3uRcXmOsNm/wiH8OciTm/ru4bRRAFiWBlVGTisO3gTusdRdorqmtVY4kace3EoWs06mE0FoyNsJ/x6TKUcrmQU2no6aDYkqFi2HYMr5ie95qBGWNt+XPSHitwghYP4pbBepMQfBrTpJCJlUGbkgn1bXLa41q/+D3PRN1s038UViMOa9Y2T9X+FeuUPYKvA2shGlWi32dNpOnQjVJY/V9Wkg8loZb28gAaz8Q0F1yMdzRFzbAb5SEvhD4IxHdScndJjlOXtKIMrVfHy6cXUb5S5tzW0bxjqI0uHVNtWtuUjy6w==
Received: from BN9PR03CA0939.namprd03.prod.outlook.com (2603:10b6:408:108::14)
 by SJ1PR12MB6097.namprd12.prod.outlook.com (2603:10b6:a03:488::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Fri, 16 Aug
 2024 00:55:57 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::e0) by BN9PR03CA0939.outlook.office365.com
 (2603:10b6:408:108::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Fri, 16 Aug 2024 00:55:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 00:55:56 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 17:55:41 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 17:55:41 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 15 Aug 2024 17:55:40 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v12 03/10] iommu/arm-smmu-v3: Pass in cmdq pointer to arm_smmu_cmdq_build_sync_cmd
Date: Thu, 15 Aug 2024 17:55:24 -0700
Message-ID: <48cc52863e8a076c62a5c6bc6c7ccc7836de1648.1723754745.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|SJ1PR12MB6097:EE_
X-MS-Office365-Filtering-Correlation-Id: dab52d22-5b49-49fb-0201-08dcbd8e3039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mhh+w+K1W4GwObnt1ARTbPcKsi7P1mhDZG/IANbfaINIzd+Et+E3DNi5FrmT?=
 =?us-ascii?Q?ioieT/cw8u6Mimlcs0tLzWw7ECvV840P7jHsonXRDwi1meBWPH8uybetc0Nt?=
 =?us-ascii?Q?4eTouNSf3wYN8qgnXoJ6NUNu0I4c/Zf2DWQ/ymw9Q6rAey/LrWgyclygkpAE?=
 =?us-ascii?Q?hUayoJzVTaECfkyBzyY7F6S6eUhviJs2sKIO4w+mWgFlt5opqtpIMbxd5guT?=
 =?us-ascii?Q?SLbDxDEnZVWD+AYgGpuT5NIXaY98LIR+A6R2X00ICsSEFMT8wMIMl0RG3S0K?=
 =?us-ascii?Q?QexdUi6W0KjgsyppvXx1RKgtVZD6PfIGtQ0++3itO7zdomEuY4yNd2WC5Fdn?=
 =?us-ascii?Q?firlXmOahT7sAp0+FSm4ro6Za48yM4feHfkjA3ZcHxxS8ZjU//Ap8xlZWY/p?=
 =?us-ascii?Q?4fWhFgJoHoXd2BmZLeuwmkpgNZyv607rQNIuKdLHp1o3Ce7dOSMrAfQhgL14?=
 =?us-ascii?Q?D0WNb7IUSEplWyYMsOmapuj4CZUPCvTkGV6Zm1EP6SK/FN8BgjWNqJ7A8YHY?=
 =?us-ascii?Q?IhMZPbdlBul7P18AYH0qPAIzxPsZR7tBjH/HuWxgBDI7dnwZh14Sg0KJUvlP?=
 =?us-ascii?Q?2K2c4ucacjIAQCyqBrKUjL3qScdvUGrVEOcf4znWTuL2egz4WdW1VWZsahn5?=
 =?us-ascii?Q?zfb3tu6qyi4zEZunizonT7sKBnmBGU1yE4ErH20cYDd/GrnYsrXtiw8+BWOn?=
 =?us-ascii?Q?J6yGkl3ml6vmgWsa22hhyyxWDxhMWJT6rCrbwotix+kp9HfvNot6+bO/WEl7?=
 =?us-ascii?Q?Bed7OrKPED99bLl6onXC4mmyxRwus66MhzIRWs+DhFfPZy6GjiRj9SlHYKmv?=
 =?us-ascii?Q?nB9TWHjeaM2774EmWKpe270Ovw2JFyNAUx3A3YrK9afRQIgPNfEYQDd/+jGw?=
 =?us-ascii?Q?fmgvyddP4MHQ6ksnExTcZw8iLjFerudJMzWOJ0CFab1Z5SOvIkZYAkmGkXGF?=
 =?us-ascii?Q?Wmu/RwYyQsz77BlcSorIy19lNagH1ech3f3RtHY48vi29L05toaViSxtL4g9?=
 =?us-ascii?Q?iimyP4aihy/9XjHm0qH68nPylbkrBg5p8QFHgSm4uLN4VFVFbKpEtapqdymS?=
 =?us-ascii?Q?8I4GzgOhkYRnoATb/+Cr7RMlOxsdJkPsTe0CvK7V64vM0EsCbKqJrlRuvi+D?=
 =?us-ascii?Q?nazC1IEt8PlC7zj9qhHfs4/g1Y+p9nb4JiRq70X/6QbQnYPfMRuThUxg8LcI?=
 =?us-ascii?Q?aYj7d3rtq158HnHQin6InFuRbA+ZNh+SILIuhU00vbIxYvKXCXSp+sSP4MP4?=
 =?us-ascii?Q?YY5o36YSJoJkvG1Va5jZbo5hJYuDiOa5DJrAewm3PNRgkc5ZOVerFVMWoIgg?=
 =?us-ascii?Q?NTXPy3jAkcJrkYxWi+MNxcWPrlMle+6bXMhqyOmfeqauVph2ofJFhklSG4Oi?=
 =?us-ascii?Q?XN8cK6HaeL3cx3zsZH5AGj905xpFd3QBPqpzrOYwR/Jl3SaGvImMMc7fcpa7?=
 =?us-ascii?Q?7QcgTMYxacXOJwmUI4K/txtVEzc37GxC?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 00:55:56.9940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dab52d22-5b49-49fb-0201-08dcbd8e3039
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6097

The CMDQV extension on NVIDIA Tegra241 SoC only supports CS_NONE in the
CS field of CMD_SYNC, v.s. standard SMMU CMDQ. Pass in the cmdq pointer
directly, so the function can identify a different cmdq implementation.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
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

