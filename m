Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2042.outbound.protection.outlook.com [40.107.95.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837608F6C
	for <iommu@lists.linux.dev>; Sat, 24 Aug 2024 00:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724458275; cv=fail; b=QRplJB+9vzW4gMtq1ZYXQhtS+kpV5ZAS+XZfmGOd7b9wi+ocGzU3I6eEeDnKwuvE8CjXz5ZupnrHpZa+HtKixKhqQ46fh8WDsZP1lAgd/qs+fQFObsxCQaEyrVsh+00JJO35uE2uCnVoFaUzGBJgvJF2AteCcvD5HMrhunDHzH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724458275; c=relaxed/simple;
	bh=Iwprg8LmFK52dl1W8Z0u69gvI9qeMSVDcf2/b25V5Jw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ta8f2AIEVWRsW7GZhAg5lqVtqqFeC/KhFjgJDYHdGx+O23FGEPF+X9zyYjLH//KbsNnSH4Jztvqp/p8IBO2qL66Ma47pRuc3HUFHMr1vKbVuPAJAEf7HQvaa5kw9SRu0tTv14XS/GnR8T66oUpjR1RhFUq2j8+ABd6l/p0ory2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mMllgpdT; arc=fail smtp.client-ip=40.107.95.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mMllgpdT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ekl7X0SepDpPLgBxf9OIa0oYBOF51DHsKlM10njrsEjZWaEDy+Hyh9ce5ERy5MiCsUMJCyo/Q+ph4vzjAoWf6JrABphj9nTnTHEcRdd4dBiGpQcTRh8GYSNzKSLhCX2SRYstz2Dvrl+ygUBycOpU3AgKt9d1oPv208mYthWAWw8wDd2OvWexwyDKwlGMmsTXFD1IwKbkhI/D9fwjV6Q+BzB8yUO3saiHORwNDJafs78IiQzl98PfbA5PxQsxZC/AKwkZeeQ7+MJ5+ZW9BlN01VuOowmKWwEnA0/AzlCqynYoIq4iBHfNp/KfKexY+rKD/OCtVgbmTdF9pW5nKdJG+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySrMMRUMcCSKY1CSTmR2dOQWVGpglPPfLperTK2vuQg=;
 b=VW9hazTq6QiZltACPyqiJbMlM0XE8x/oAeP2ndqZ3V4t+sZjlwV3E2lqd54pdP/H8j5yDpaMl5rDmzb2KPdW+sF+O6y+1OoYox0kVfzdoXHiEsy4mSJGuXRrR0ESjeFAvRuwNfX5a1kqIeHGPc0kxtE789uqQNf6sOgyRd8xizzotk7wRElgNIp6TOM6FRfKt6oI580ti/WSGaqgC/wq9BdXUAGHLJFY+vH7Odu8Ao96uvEnmRJp9yJ188mJdgg+CQMR57djGqQ+5cNZyMNBK+wxvOyIizaPS2zAx3sBzEhCyAUeojbE/Woi4ChB/CSfGldSgCRHUR2MFyVYEif/5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySrMMRUMcCSKY1CSTmR2dOQWVGpglPPfLperTK2vuQg=;
 b=mMllgpdTeMuylmz/e0Wd3tMa0JEVzBSnozH85IHdRWETYQuqG/G3OwCTrGYyjbDJK+Rg560ECeW3z40q6k6pr5cKyLeLjHDuEqjbC7bN0QlmiQteCRSsV/5zwN90h3moiDq1kfPa0R/+ZctthQM9RHIY/XrA07prq72CjsHYn7ridXJR3PLzhzCeY6LGrfHy7Ts7CALZEL0sZgzWb63FDy9LPgUBsEZ5ZpJtxxUbLrUiH821O0SOoi4E9Lxfp09MXQhwJhc7nu+Ds/VUbHpMXfMmW0+le8pjVMWfy2VuJkN9O0GMqckVXRZ5bNLAkFTJn/9/Cobt3Me17yQ/HULk+g==
Received: from CH0P221CA0048.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::29)
 by CY8PR12MB8066.namprd12.prod.outlook.com (2603:10b6:930:70::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Sat, 24 Aug
 2024 00:11:10 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::51) by CH0P221CA0048.outlook.office365.com
 (2603:10b6:610:11d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Sat, 24 Aug 2024 00:11:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Sat, 24 Aug 2024 00:11:09 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 17:10:55 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 17:10:54 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 Aug 2024 17:10:53 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v13 06/10] iommu/arm-smmu-v3: Add acpi_smmu_acpi_probe_model for impl
Date: Fri, 23 Aug 2024 17:10:40 -0700
Message-ID: <8a2629bb98cabb1be72b32c120bb5ed0114b21bc.1724453781.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|CY8PR12MB8066:EE_
X-MS-Office365-Filtering-Correlation-Id: af602404-b91a-448a-6c39-08dcc3d141ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6Pb1DZCPGXIXWwZItLTzsnMCnd6n1zejJ4JMJ42wZnCQ4ezWhOU6VDW2MPyE?=
 =?us-ascii?Q?SPwDJctyv3zANW3RUua29M3N3ymavdPggfKcTRInaJjZ3JGbWO7neeITqlx4?=
 =?us-ascii?Q?uEYpg2/8rPVh/59Wdmfdmbfd427M6aMVS3Erjkpqe9wqzpW3/MTujPGnyHxi?=
 =?us-ascii?Q?TnwXfmVO4zNVf29V5FBCA7sGVugxujOoFCyv02559WyDgYj+SXm7DvRttKKW?=
 =?us-ascii?Q?/+rCRwmp+COpYXTq2MLfAhbW4bAj6iN7CW0LywXRi58ty0uCC6O3TaA3IDiv?=
 =?us-ascii?Q?RLouHU/tOIZU2zY86gD7KfYEgI/aqCKbG+ZSRJrXHamxF5SBphutDAJ5wBqA?=
 =?us-ascii?Q?6YlgmHb1zAKCaYbiD3eUqfewGKcadw6yLcShUxC01yAEn7GQoTeu0vrY/U0c?=
 =?us-ascii?Q?XnwgSRegkKbq5X0qvvEbMEEtzXwNlwmWo60Jfs1LVTlicJ1YqqGMZfh4Hlwj?=
 =?us-ascii?Q?Eu/cZdm5aPW9SnxIYnDcIFWLfqhNDQ4ZriMDbbvvmtbyo/o3sC5gr6VLK3vC?=
 =?us-ascii?Q?GnpjFXcj2WHHt6xVQahVbntLaWhdb+tcZzvas9Ge81oj627k3kVvFFhgSwjj?=
 =?us-ascii?Q?9aH+bxyngiiAmsmwgtn/n7DdabPvbFXXbWPRPCkr3O1wfG2kvD/Qo/36K5h7?=
 =?us-ascii?Q?a/+8u3g1uE9/Lbl68z4lwriLdEhGsi4bK4NCshRwmzI2wM6hawzxNk4S2KUp?=
 =?us-ascii?Q?Z/GaN9mpKBspvC8vsh4Xe+eGyqONlIh51KnsSnCNeQhYds1kK5mv6zyJq3m9?=
 =?us-ascii?Q?IXuoPjp3N4cPZVi2eMHe9r69X1RSbJycUEMdC2HUBu5FnbhSQBGIGFxJqTD4?=
 =?us-ascii?Q?sy7U8VUkPyVbqeRSOCtBxKlq603nXtxx2anTJxm0BTdkjZ7RK2d0h4l9mZlY?=
 =?us-ascii?Q?SaZUhi7FjC9ElP31iWdJ197zInThT8rDAluy3hQDo5hgjyS49qBNsf49h1CP?=
 =?us-ascii?Q?8gRQdka/FZaolOpqozrdViuhYFQVGJ66lqZSCWIh1SK9c0bxypzsLFJWaEyQ?=
 =?us-ascii?Q?eVUVHtvAcAxs3AIB5ieq9udw7d/b1BziT2se83GRNgyApd4rKxV1WLGi3I3+?=
 =?us-ascii?Q?vSH1PuHqt8a+/J7LAyXFiBMNguUJvG5xJ1GisP+BxPQ1bmJA6le85Qy4mYGm?=
 =?us-ascii?Q?DbWPVT6TvpFmeBcOI5cqIE+lAguOu5Wc2oGvOJq5MwToJe/9GYFfR+GfvZw/?=
 =?us-ascii?Q?rnL38Y3WpyDSv6+OAV9+QXL6oiBIyQP5QX/X/n047n7qgy1gp/8yfcDktIxZ?=
 =?us-ascii?Q?3xRI17QXcyHDQCLwTi/3dGNm/wNZSWC9Kz9Z4Gzqbok4UrGRWVQLmHsodlRO?=
 =?us-ascii?Q?TlBvbm6ilLed64693MWjGuj1BYXHk3e6C+fUfUsJ4eGIdvl2gSw5jOdXIjJA?=
 =?us-ascii?Q?nLuBLgZccMkURcseLK6vnYHafJeLe8qPd919TCVO6uFWjMnLaCknsx5usXEO?=
 =?us-ascii?Q?yonppRGlsYC+WQDfVXRcjD2sR1p/swt5?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2024 00:11:09.5449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af602404-b91a-448a-6c39-08dcc3d141ac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8066

For model-specific implementation, repurpose the acpi_smmu_get_options()
to a wider acpi_smmu_acpi_probe_model(). A new model can add to the list
in this new function.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index afdb8a76a72a..ceb31d63f79b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4341,18 +4341,28 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 }
 
 #ifdef CONFIG_ACPI
-static void acpi_smmu_get_options(u32 model, struct arm_smmu_device *smmu)
+static int acpi_smmu_iort_probe_model(struct acpi_iort_node *node,
+				      struct arm_smmu_device *smmu)
 {
-	switch (model) {
+	struct acpi_iort_smmu_v3 *iort_smmu =
+		(struct acpi_iort_smmu_v3 *)node->node_data;
+
+	switch (iort_smmu->model) {
 	case ACPI_IORT_SMMU_V3_CAVIUM_CN99XX:
 		smmu->options |= ARM_SMMU_OPT_PAGE0_REGS_ONLY;
 		break;
 	case ACPI_IORT_SMMU_V3_HISILICON_HI161X:
 		smmu->options |= ARM_SMMU_OPT_SKIP_PREFETCH;
 		break;
+	case ACPI_IORT_SMMU_V3_GENERIC:
+		break;
+	default:
+		dev_err(smmu->dev, "Unknown/unsupported IORT model!\n");
+		return -ENXIO;
 	}
 
 	dev_notice(smmu->dev, "option mask 0x%x\n", smmu->options);
+	return 0;
 }
 
 static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
@@ -4367,8 +4377,6 @@ static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
 	/* Retrieve SMMUv3 specific data */
 	iort_smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
 
-	acpi_smmu_get_options(iort_smmu->model, smmu);
-
 	if (iort_smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE)
 		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
 
@@ -4380,7 +4388,7 @@ static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
 		smmu->features |= ARM_SMMU_FEAT_HA;
 	}
 
-	return 0;
+	return acpi_smmu_iort_probe_model(node, smmu);
 }
 #else
 static inline int arm_smmu_device_acpi_probe(struct platform_device *pdev,
-- 
2.43.0

