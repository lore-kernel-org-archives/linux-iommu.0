Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D33B229B0F
	for <iommu@lists.linux.dev>; Fri, 18 Jul 2025 23:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752882523; cv=fail; b=oLTEdQ9piyxyQ0wLolh9ZjA8UnMM+91tbmRkNpNf+cbK07sa+Pg33LgBRlSPI7TJahT5q+WbhetJ8i9ua39E9W7R/HLbaMbWVXf0zq5ImJryvQyVjofnE4nDL3CscqmihXXxXJ6qeFEUAPVPY74Foe16R+lNdlfR1jwygDIdx5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752882523; c=relaxed/simple;
	bh=/hlOFEH9SfbonkUYLAnrzz+Gjz7sAZKyo23b0CCq/n4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lIYBeibCTMws0liuymZjA/LGox+RZy3yamv2H5Sc9Uk1KIO/tElqSTIBque4AU0kgCBsidn6DAQp/AjATOhPZfOovsnRWjkB9vnP+co2ZxHKX/oQCsB1Oy5gngheXNA0ogMVjwGcCX0VXqcXU1EB/yVgO2r0hC37HDiPCysqnkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GuTRrP0u; arc=fail smtp.client-ip=40.107.223.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GuTRrP0u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhBA0+VExTDZHQKBnUjxU35cSX3yWJ4qmUrMxzdGjnFRmqCFKKKJ3O2tHV+m8Zm6fIBQfdPWM58QBp23iGItFjntemQxy4J/Yvkj0/OHj5s1jh/ZCxjbUF367icOT3Zsd7OhXWWoxiBm2kw/GBm5L27OjpEIYgBi9I59//o+69CXOpj5crSBYEcxoQHwIiGKYbeCi25gmgg6cagPCj7CA3DPTwsgd8VnmQC7i+vbIjUKnwxKG2iIYnlB4JQNozcJfJEN6AqhAz98rztOrBBuT5fifkmzj/qODr0FRetJ6LuWOyzakBqtt83XYjF6fiGWW9GYWVthNp5/GgvyQvILpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3/KFvraHS5VNfSPc8DiJuxfRT4j94KBl5xLC9gkMsk=;
 b=LVeGVJl2MVChQolWKIlDIeTOvtit5Isw4SLjXkxIpyONfqnkTD23qqtfYnsTNaevrQj3WUDrc2Nke7K8xNiEck532hnjfcrrhPjZeXBzQilkXXy81HETd+SgdskdIqlmdAyUSV3b+9HEyJy78zhD0EkZNiSIgcy/+dJMssXLwP0imH/6qH/ZsQQcCeNG62L3M2D+Q4b7VlPbnZkg/fKLEJIfAGmnoizMUh0E5Pas4WDYcMFe0aHCEy5O0JYrPdULgExc5GLFdevAfkZfUiIiUX5CXudiglJUpyvERvCdsV4p5cKu+ABkYZURplKwSOjR9PtU85AgXv8urF/NYJjVHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3/KFvraHS5VNfSPc8DiJuxfRT4j94KBl5xLC9gkMsk=;
 b=GuTRrP0uiNiRpQHOW+VmtG/Y96H9N/6T1HfIFBDCIVHv43SNRXp7lpmwZq+RL8GaNhkGWObPt6e0onOsRvwfD5zkb6T7LsUJ6lOhAHFiSMpxEHD/FqSHN/MlWdHG2//Z5B+cC6Fjv4feeBBFBHiNSNms5O5y5cSXbvUrmQn3VfhQm0k5IHWScgYTrzzZN5kTLdG18pgMKkRYaMVhc36iuk51dtgZW/zjKL3zchsXtswDEtfgXiYnDZoLHHkxOcxblWVuTkKW9aiboYsikY+ASxBIwfCjpSY5NpM9qkupLreKE79c2GRSuKS55KR8v1m9Ipaav91RFuKDfN88UVRFrQ==
Received: from SN7PR04CA0154.namprd04.prod.outlook.com (2603:10b6:806:125::9)
 by MW3PR12MB4364.namprd12.prod.outlook.com (2603:10b6:303:5c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 23:48:36 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:125:cafe::49) by SN7PR04CA0154.outlook.office365.com
 (2603:10b6:806:125::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Fri,
 18 Jul 2025 23:48:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 23:48:35 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 18 Jul
 2025 16:48:26 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 18 Jul 2025 16:48:26 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 18 Jul 2025 16:48:25 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH 2/2] iommu/arm-smmu-v3: Replace vsmmu_size/type with get_viommu_size
Date: Fri, 18 Jul 2025 16:48:22 -0700
Message-ID: <20250718234822.1734190-3-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250718234822.1734190-1-nicolinc@nvidia.com>
References: <20250718234822.1734190-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|MW3PR12MB4364:EE_
X-MS-Office365-Filtering-Correlation-Id: 8272b248-1d2c-42db-6364-08ddc6559ca1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DORCNXWjkBvoksLp4lgHeX688CPM29yzorzIX0YllpM4x8DoTOboTN3BLlh1?=
 =?us-ascii?Q?0hn6kn+aIRN7zuVxFFfbbKXer2gobfeyGXp8AOeZjUyyAE3Z7pSpOXghxj1V?=
 =?us-ascii?Q?gQTE0ntfBxwbFBUskrjaBVfhn1BbncsyIN58V2VID5D0sDNV9vMKj7x+0gy3?=
 =?us-ascii?Q?Tqev2ytySGzad6EuiFH/okjuG6/Yy/nBqAuOPwKTRRbo0PUJZGejSmMh7srr?=
 =?us-ascii?Q?sbC4o4YH9lCuKcjJc8F6H6Weu8vWoRl03umRIlEWmslR70aHsh4Y8uWJ/Un7?=
 =?us-ascii?Q?qJJoFLfOWgEXWAS2QnTy+XrC6tKJ0miUby/rt6s2vPMMrOK1nIpPv6H/Y5rc?=
 =?us-ascii?Q?fqVKb4xx5xWQYltwMGIISFPks+BQWrUN/TZlcwYUco0CHDLD0Vts/3rKaPDc?=
 =?us-ascii?Q?PzyKCTvLbjQe6+331ma/0AqbQWJJBNNEO3wmEC2hCZIuhwMORgfFYFJX+Pnk?=
 =?us-ascii?Q?Rt+NJhLRuRHiJh4A4fVOvg2+7hntYKfcdoskyDbHxoztDhW42GHzR0Wn1t5+?=
 =?us-ascii?Q?7RtTfq+hI+BBix9lbZneKTITWiFumc+YD4QrU9PrsD+mk6TlC798a3LX5Fmj?=
 =?us-ascii?Q?L/jHyybx36wRe2zoK3s+U9ltkEZQvjBFKVQmD2UmkjfWdMlr+MRn4she3723?=
 =?us-ascii?Q?9Zc+gqpdeWKTUKBXmAT/tFjWfziZbKDbLN3H41iyglXLE0uVyOP4tHRgpa8g?=
 =?us-ascii?Q?c/h+ArO+ESLUudP+i5ZqLcrxv8NFd+qotn/AgR79tjNgLUTjRl+A2oUdUtzn?=
 =?us-ascii?Q?gaE7+4x6z9DKozW/F5AfoUGf+SEXHon207lLQa/WFl5anFqjbyV5hRtQLNJ+?=
 =?us-ascii?Q?dDcXFFervAhqN3wM/+5ghpAShT7HTljJ9rbchnA8Y2yetMk0XJcv6SzLbpJM?=
 =?us-ascii?Q?K+M2s620RODcE9e++PYSAHJ3G0AeAv26mGuZq6x0Hz2pzXiJb4uk8TAUlmg+?=
 =?us-ascii?Q?d36qUUyLGP2pVQZCICdcR29ZTECtX3Bun7R1DTv+TEeGmF3fVJgqP3GrlQv3?=
 =?us-ascii?Q?QMeEnte/Y/P6hp0+exLMp+ktRxqWiRVtTh23n2DNvG3CCMfyYHJF+6Ean6an?=
 =?us-ascii?Q?zp10HPETO4zyBEu12JyQyd/dgNaglt6klp+f5TsixrM3Byh9HSEuzmawy4U4?=
 =?us-ascii?Q?FlJSLgTBkRtR7KChqa8fpbGl5D9pyMY+AToaT9uaSMSbcbCRjow/m2WIAMvY?=
 =?us-ascii?Q?GIxtPtt/8FHXhpVXZtbfcrUj4r/68XYpfV2K1WCPVUQnZBZ/KdqiJrQXMUx0?=
 =?us-ascii?Q?ySYwGEtXs6yGyHBHbstdycY8M9+u7JSSHQ1kGtzE50QcmuFc7Qyozu81CT/s?=
 =?us-ascii?Q?jSJ+7sgDwxYDKnuzfMYvF3N2bDK00Fgm5IKvHj8DGuE1UZI7Jop0yBc4wsoO?=
 =?us-ascii?Q?2YZFiC/75aO4F83f1rdH+NwGsEm8pvwsUQyccFRHZEVnQbNem1wYATO1nggc?=
 =?us-ascii?Q?DQQ4CcFOFLA1BXDKA8Gw4nAZ3biCTibv/yPJZdak2jECL+lpX1RjAAQY96ID?=
 =?us-ascii?Q?4nUwWqP2uk9p5gZY6mI0asUHgFF2EEO8EeMI?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 23:48:35.7488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8272b248-1d2c-42db-6364-08ddc6559ca1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4364

It's more flexible to have a get_viommu_size op. Replace static vsmmu_size
and vsmmu_type with that.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c    |  8 ++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |  3 +--
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c     | 14 ++++++++++++--
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 0b2acb80f41b..d4b7affaa480 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -423,10 +423,9 @@ size_t arm_smmu_get_viommu_size(struct device *dev,
 	if (viommu_type == IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
 		return VIOMMU_STRUCT_SIZE(struct arm_vsmmu, core);
 
-	if (!smmu->impl_ops || !smmu->impl_ops->vsmmu_size ||
-	    viommu_type != smmu->impl_ops->vsmmu_type)
+	if (!smmu->impl_ops || !smmu->impl_ops->get_viommu_size)
 		return 0;
-	return smmu->impl_ops->vsmmu_size;
+	return smmu->impl_ops->get_viommu_size(viommu_type);
 }
 
 int arm_vsmmu_init(struct iommufd_viommu *viommu,
@@ -457,9 +456,6 @@ int arm_vsmmu_init(struct iommufd_viommu *viommu,
 	 */
 	if (WARN_ON_ONCE(!smmu->impl_ops || !smmu->impl_ops->vsmmu_init))
 		return -EOPNOTSUPP;
-	/* Unsupported type was rejected in arm_smmu_get_viommu_size() */
-	if (WARN_ON(viommu->type != smmu->impl_ops->vsmmu_type))
-		return -EOPNOTSUPP;
 	return smmu->impl_ops->vsmmu_init(vsmmu, user_data);
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 3fa02c51df9f..e332f5ba2f8a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -728,8 +728,7 @@ struct arm_smmu_impl_ops {
 	 */
 	void *(*hw_info)(struct arm_smmu_device *smmu, u32 *length,
 			 enum iommu_hw_info_type *type);
-	const size_t vsmmu_size;
-	const enum iommu_viommu_type vsmmu_type;
+	size_t (*get_viommu_size)(enum iommu_viommu_type viommu_type);
 	int (*vsmmu_init)(struct arm_vsmmu *vsmmu,
 			  const struct iommu_user_data *user_data);
 };
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 4c86eacd36b1..46005ed52bc2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -832,6 +832,13 @@ static void *tegra241_cmdqv_hw_info(struct arm_smmu_device *smmu, u32 *length,
 	return info;
 }
 
+static size_t tegra241_cmdqv_get_vintf_size(enum iommu_viommu_type viommu_type)
+{
+	if (viommu_type != IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV)
+		return 0;
+	return VIOMMU_STRUCT_SIZE(struct tegra241_vintf, vsmmu.core);
+}
+
 static struct arm_smmu_impl_ops tegra241_cmdqv_impl_ops = {
 	/* For in-kernel use */
 	.get_secondary_cmdq = tegra241_cmdqv_get_cmdq,
@@ -839,8 +846,7 @@ static struct arm_smmu_impl_ops tegra241_cmdqv_impl_ops = {
 	.device_remove = tegra241_cmdqv_remove,
 	/* For user-space use */
 	.hw_info = tegra241_cmdqv_hw_info,
-	.vsmmu_size = VIOMMU_STRUCT_SIZE(struct tegra241_vintf, vsmmu.core),
-	.vsmmu_type = IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV,
+	.get_viommu_size = tegra241_cmdqv_get_vintf_size,
 	.vsmmu_init = tegra241_cmdqv_init_vintf_user,
 };
 
@@ -1273,6 +1279,10 @@ tegra241_cmdqv_init_vintf_user(struct arm_vsmmu *vsmmu,
 	phys_addr_t page0_base;
 	int ret;
 
+	/* Unsupported type was rejected in tegra241_cmdqv_get_vintf_size() */
+	if (WARN_ON(vsmmu->core.type != IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV))
+		return -EOPNOTSUPP;
+
 	if (!user_data)
 		return -EINVAL;
 
-- 
2.43.0

