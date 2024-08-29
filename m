Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51541BAECC
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 22:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724970907; cv=fail; b=PD8lBJ6kVrlH2wI5x91BMV3drBcZByD9eTVrg30i/75kHUqG/CfgoF6MYNtWZhTodGpFBi02d0yYTOzN+J5uoZ68xEw5Y7lEqLMie1BhFMLCfySJLWtRs6G3XqClYbiQK+06NUXLu49o7QoVk+rkIwfbxRoBy2P0t22jpel6cTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724970907; c=relaxed/simple;
	bh=QPu63hfWdC9YZW2C+dqdYKZ7sXuLPy4jMZl1cZxHRYo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z8pLa0k49nPLVnq8543OsuxUNho3NenOAcM6zhZZdd9bMfAw6ffvMw3bkFy+NS09xAGqytYkidXs3Vu35A2MlIrlRg9+deTgk4E8Y6Ymu5+tBRI2kT5upsewSbwVeAsCygiS893+imxhSMDg5ihDynTAgnA4rzP1jEdqhWFYGHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iSdVNJV4; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iSdVNJV4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFAuTdwyeHlocDuikSk/5WqGx/ie935mGRId/uBbppapg1Kk9m/gfavdPpQQ2NDXmsx2MEsDG4U+0VJEPRqlAA2UjsL4JQHJ9WErk+dhxQIyZsxRGWfZI7Wr5MDFc5jTfZJCWRKixVe4YYyZK4Sp06iPj0LDVfdCZVxJ0WciJtLm/knDsxwJcNxU94JJTS+jp+CE3VlrbeE/rrYYTuhpOIM6jvoyL7tb8KF6OsAiT5sCQj89UtpIqdVHb5ycp+XR+ZX1mb0C8hqeYtHMZXQ0nKVxM1ABGz/5GAyBRYYHKM8yyE+CSTaQkCGNiS8X/PPqXf7BvFxPeU/Ssqd6suoj2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFPl7DRvp1PI0L8vvlBsH7NoiLE72eQ2ZtecRf7Cldg=;
 b=cNRVtblu7JBrVnkDfZ99VhpVgBxGNPIfulo65n7bTn+fgQjl0wybh8Lgt33CXzjk909JYh0VcoNIpamwdYiRPIaiI626ZWZ1E1fU+u7O2x1BTOwLlhEkUDg+7Ekyr0NS6W/BtoaQAnPkOOObOGAD1N9wkpu95asr6pTxOEgCEdtCrzLAftiWY0uw/U5KDCEk8c3RzLhJTjt0WBCsQF9Mfjyr5jhS15hhg5MtcdeVoMwasvs4n8eYdTAxO1tE+LsIbrMQcPlYxKjcY7nDgRsd8YIvtqAaVeXd+6WG5Wst3Rjw79/+sl8m1JF5mnAo/xGroeEfDFp3yN59nNixW9+lkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFPl7DRvp1PI0L8vvlBsH7NoiLE72eQ2ZtecRf7Cldg=;
 b=iSdVNJV4nMC5vY8X8MRirh8HHFF8YKYFwdfi7dndTFcQ97zKEQmmptQUyEnLhRnd/T1mb+Z6zOhqNANknY5UQeJlG4AibYfVHBvZOY0tosvYVkTvMHGsQUDJGSnVLqFGJ9oILN2GQ9eguFchoP96eupPo/htGqWesGhqHwL5tWpg3TVHJGzlZDITIQG956KdysqvVyTMoU2aUB+dJ4Cd1RPAPTYhgr9EKBEEixtyThkpmcGke7j1ORu6tf4r7AZZzsKpgg4b7SDu6BcfverV8a3+lh777wtO+VLNgUu6mm2VIEbOP1OS6voe5KRMiQ4E3roCWeB+6SQd2Ro5qOj+kg==
Received: from CH2PR14CA0023.namprd14.prod.outlook.com (2603:10b6:610:60::33)
 by IA0PR12MB8906.namprd12.prod.outlook.com (2603:10b6:208:481::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Thu, 29 Aug
 2024 22:35:01 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::94) by CH2PR14CA0023.outlook.office365.com
 (2603:10b6:610:60::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20 via Frontend
 Transport; Thu, 29 Aug 2024 22:35:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 22:35:01 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 29 Aug
 2024 15:34:50 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 29 Aug
 2024 15:34:49 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 29 Aug 2024 15:34:48 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v14 06/10] iommu/arm-smmu-v3: Add acpi_smmu_iort_probe_model for impl
Date: Thu, 29 Aug 2024 15:34:35 -0700
Message-ID: <79716299829aeab2e55b8c7932f2634b209bb4d5.1724970714.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724970714.git.nicolinc@nvidia.com>
References: <cover.1724970714.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|IA0PR12MB8906:EE_
X-MS-Office365-Filtering-Correlation-Id: c337b563-99df-466e-4dfd-08dcc87ad221
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KJfko4SeoIStjMb0R6/fZOIn41zIGid3yCPQxpmdqkq7gJ19biNNgoVrqb23?=
 =?us-ascii?Q?A9pNXNa5HqSHwJSaUtAh24hVj8VQ8+cmti+uI1/CdwF9Mh3a3mTsRf1G5anM?=
 =?us-ascii?Q?XHfkj5MZvcbvcBFyPslPwljfHYS5GlNpY0Acs/lZFMqJUb6y+jU7B0HA6qJW?=
 =?us-ascii?Q?hJNLlydb9yxSV+V+6D7slhutNKVEG853sXuIqW8dn0MM4cmRyCnmPyh5kN/q?=
 =?us-ascii?Q?4TCnKitKr/u9twMLPpfxEVchXxt2sMkG0VtZVKB5AjxSs5jXCTXjTNs+mW0o?=
 =?us-ascii?Q?IvV+uDe4S996cdIJmmE43TSzbJ9eqk4FaVrwRabwUL/OqUGlgOXjat70c6SW?=
 =?us-ascii?Q?57uf4usw+m9qMLy+FwUDnm1fEpwXgBmfTVMYJQaeP+YfPojXotsZfAOl7B1P?=
 =?us-ascii?Q?IJgkn2adJHOFXo6xSNUJ/03zDZxA7pSunn5mYn0Q4qVP8aaX6o1oqOQlfEk4?=
 =?us-ascii?Q?kub+Uqvvb6C/3vkUAp49K2U49Ne2V3eDx+Ey1WjSRL1R4gTG5QZFNg/P0aAt?=
 =?us-ascii?Q?MRO7zpOImoh0jEOOsCiAwjPZ0RpsriwjyNyz9oxj3OtfGI4CzNEkPkgZtOaI?=
 =?us-ascii?Q?NGbiaTOUG5PBk5cL2s5QR+KYBa7tHyCexqblYral1eo3TC8+uvckkG5Cmt1V?=
 =?us-ascii?Q?mv87Cn+sEBmNvENU9+5vq1BpxqWTaSio09UtS1PfpBO4RzgML1fFxLr17aVt?=
 =?us-ascii?Q?ObenvisvR6qMQJlPDE1Djp7TSxGeCeEohlC8iVobeKCy9aPdeGAqXbAKWGh3?=
 =?us-ascii?Q?ynCAAGkXpcxwsm0Uhw2tFEhmZwpIxxu3wuDBbWskGlOghgozm39AXa0Wc2YM?=
 =?us-ascii?Q?QPzaLDGLlakgpqk43k1BMmJJdfFV4lXuI9hedztvaWlCCwcNg4cQ3aqIVDNW?=
 =?us-ascii?Q?vJM+PGTiZaGFJ330Nh31mFBIlvaVf5bdZIDWH3Q5DXOMPjJBgYb0pNyri82k?=
 =?us-ascii?Q?eev6IVSx6BOaWaQXg3eHHoe1hTT8PhWC+mRC17L7ylKR3sag+y4laaqtxN2Q?=
 =?us-ascii?Q?Lwc2n41fkstS5TJ8GdaJ79pgXFSltpKl+/7yayPpfbSGIjU6Dh6jmwgY/k8j?=
 =?us-ascii?Q?1t5xfzZDtIP9cHrWe7VXERLR3BBZ/ariTTn7H1GEXdqs0dO3VYmCr9dObTEa?=
 =?us-ascii?Q?x4WIxvetU2bT3UScrq3xWKs/Dpw9++cICxGeAxBy/SSXpe6QylV73yFsZP+T?=
 =?us-ascii?Q?CeNj6ALs43fcsOFMPEBqOSU81qHMWke6/SVVbDfJ3ydsbpNOxhzbcYktwOtu?=
 =?us-ascii?Q?bVGcnYN9C1vK1I9//KbUY+QIUdg2OkjBxiha3pgObjVvWQAggSL6Uzm0+cd2?=
 =?us-ascii?Q?k+LALkCOgos9gcT1MqXebcJE3JTMgYTaxYT0SHneQl+6CIsWkSK2oDyjdY5n?=
 =?us-ascii?Q?2G1nQD4V6DbD+wRQAdxKMCoCHpV15TndFIIf7sWMJL+eeJrCBasAjCQrvhSg?=
 =?us-ascii?Q?Lz3i5AD5W7c+EjQTDim8ib1lWMCBsoNY?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 22:35:01.5012
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c337b563-99df-466e-4dfd-08dcc87ad221
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8906

For model-specific implementation, repurpose the acpi_smmu_get_options()
to a wider acpi_smmu_acpi_probe_model(). A new model can add to the list
in this new function.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 816f5937345a..8b1437240ce5 100644
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

