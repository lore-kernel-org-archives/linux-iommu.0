Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722AA23A9B3
	for <iommu@lists.linux.dev>; Mon, 21 Jul 2025 20:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753128323; cv=fail; b=L9wlK+GhZnqTWXoDh0sLDrbpIXNqiMx/w1+6UVQ1ct5mJUvwAIQya3PmGuCkJyLvvuy9ZezcJ5W/7ep69DTNwnm5NN6RUY+NC/tEA1D8GtVhdUsBtiIKsmira6Udj9gdpfOZn8EU/+UDd5MXDlZMTKLnner3xPdtd0IU2veR5Ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753128323; c=relaxed/simple;
	bh=//81EW72FbyHBeUSoqSeCTSDKJHXYxKWokLH6rFt7Cg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f32NhuFU5xA33RDyc9wjo2nxcvBQppQAstl8+zU+26JBNfavaHsP/m0qj6YhN0fea5Mb2yOiiwQeDEgh8pIMTDWBwsCfiSDH34FdICivKvhDsJKFtZSZ62c/qiLuQmzN99rcHbnlTVcn1h+oqNnaxmbXcnKYpEq4L/j3t4+t3N4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AE4ibYzC; arc=fail smtp.client-ip=40.107.212.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AE4ibYzC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yzVK+wH4wB3w/QqN9ae/6M4VtMA3E2WEsIGYBnUbNe4R5vynpH01xvePmjyGWiBVHOvNHrKxrAC4RRtFxAZafjF17K88jmUZs0t9MdWXgyfJRaZDhg985yr+wyDXKvqquanwxA5Ze90ZD6tyheQoaHUvOsCBaNmh2zb6Zisi2/L7IaeV2Ef27L6gafihVj+02+2b5h+ArMkcniz15pvt8FJChOmFTLX2Q1Qa2WT0KQL+9Miy+Sak8nTCKGTHy5zZVIz5e4FoskUXn8Utfo/kEGBfSt60cFwbysM1Sz2l2SMKoUqJPoGJf/is/Vx0c2vypQkpMMfN58yuTvEUzgsUtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wbMiWsmfGjUfhXCXATyJqAqZm+lcfL7JnN0xFiyQfw=;
 b=CSwuQJDhYXBMDX8Wecvb/h3XcNJRWdumAaXpxxUZMVWWSugXUu5G2N8Psdjz7K8TpKTezS80kfoaQHEB1a4lwBulAgszOi9/oPg5kJpZ4LUfd9zAu1ErtfLPLqKRfCP+AKqcFh/S2XTXgYaQZg/8XLzw93jvGZGqdU/0Vqei6lq20YcaaY43vsJWyNTkMAX8U839zm8LHVNwDYnqkABUo0lUn4rrCkQnnlPrDNidjWHDwgCI9tjT5+Mpj9hJXaLxbXgmU4qvIaL0jEUq1IxoO7ZNOvl8Sh3j7ucE0Ev0/1n/dwNiBVAcwRIiIeAyE5D5kGsXeQc/Z/O7xXe6wcKRUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wbMiWsmfGjUfhXCXATyJqAqZm+lcfL7JnN0xFiyQfw=;
 b=AE4ibYzCXLQ6L5roaJjJSDHXO51TJWVq62u/F1RVqBwxtiERpBpRo/sLJW5TzL/CxETgA3YT/sSjAWuoVYEmu4VIvbEDqx3lc8dAidZltbS8VARKQoDxrBy9ad2FPP0rdphmg8kIY+jQd1qwVRtaZUBnEwKukjxeU1BCyvM+Zsv27Qiz/OMo5px2h5Y/IydFe8Xgn8AhPilRkA3g6TYIfOMtPa7XtrdGNrFvmIJZ/Ip0zXjaZDXp/lmvawQNcSDLjipyFPtWzqo3yrbF0fMxWMYdlWg8+gs2KHcLugR8gvzIjFLG2QGy4u6OJuPg9N+WGO9ZtkEjHMU1MGzWAJqtsA==
Received: from BY3PR04CA0004.namprd04.prod.outlook.com (2603:10b6:a03:217::9)
 by LV2PR12MB5750.namprd12.prod.outlook.com (2603:10b6:408:17e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 20:05:14 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::f1) by BY3PR04CA0004.outlook.office365.com
 (2603:10b6:a03:217::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Mon,
 21 Jul 2025 20:05:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Mon, 21 Jul 2025 20:05:11 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Jul
 2025 13:04:57 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 21 Jul 2025 13:04:57 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 21 Jul 2025 13:04:56 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v3 2/2] iommu/arm-smmu-v3: Replace vsmmu_size/type with get_viommu_size
Date: Mon, 21 Jul 2025 13:04:44 -0700
Message-ID: <20250721200444.1740461-3-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721200444.1740461-1-nicolinc@nvidia.com>
References: <20250721200444.1740461-1-nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|LV2PR12MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: f96cc8f0-2a41-4174-798a-08ddc891e66e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OG7FuAT++5NL4JRu3q41nYY2cqRJS2yotxdxcqVH7uYqtpAV02AioIPbF81C?=
 =?us-ascii?Q?tfI8OzOhauUF2/yUN9hr7g1XKKDJbCc7yw+Ktg+VRSzazhEmHGagjMp1vucx?=
 =?us-ascii?Q?PF8OcWtZMR3WKuJ9fbgo2G38q7K8PcVSXv0QmS062gleXfEp/BTlkGoiDaix?=
 =?us-ascii?Q?FM6Y4O0Sikw/s30S3r9nSJX/hlz0DTfCO9KNC8BLTZ3rtbNFVayBSS6fDLIK?=
 =?us-ascii?Q?koS/9q+pjRdaXtSehW882DYK+7XT6zSl0d/INuoCumbkXgjVxN0y8SVTHrUJ?=
 =?us-ascii?Q?ik6Gisp0GL9nJMPHxlzi/zDHSAb6Zq6X3yBAmwrFVdCy7ZwlLpuVhCt3bVnC?=
 =?us-ascii?Q?Gn55C9s9NEmNt54+i79Ze2W8Ymf7dyE8FqtaalcG3VEX4vcd0HHmMlA+yvPk?=
 =?us-ascii?Q?OtuGUnQIfHt9FNeniCn8hVLZ0JfI38FjDE7eiifZUcn9LSr5woPYdHCSQ9oa?=
 =?us-ascii?Q?DIGZ4B4taCVW6ZDTZYjr7EBJsfTZVNzQvA7U1KuHm69f1RUKXRaipnyLZi5R?=
 =?us-ascii?Q?Wc1a+kEOp+m7ORyXBXTeH75rqcGyD0VOLfAFumaj+v4FdO5jEDU02koYl4yb?=
 =?us-ascii?Q?7PqjsnHn5Sa5G6FGLaZc1VwzY97ys1RD1F40pTRTOqUVniA3jZiCHE4cqhIE?=
 =?us-ascii?Q?fYGLFacLticr4H+CvjiseOIOnOnriDxoLSKLhWyNAoxQUQW4w4PhsQodu+Sx?=
 =?us-ascii?Q?9/bHN4w+Z9PQmj2cNdja3DzG1UOX9dYyR45pRUm9rf9IFSO0vIWKNTNBpDWh?=
 =?us-ascii?Q?i14MJtp2qYlKoVdkCguAYRsXm7FHYClzJwDfhjp7AjsKTSVbS0VREeR9TyV/?=
 =?us-ascii?Q?j4glRxjsSv1CuAglh0MR3gM23wSfGw6OhMFbs0KExkSAVoTmvnyQeF71WFHW?=
 =?us-ascii?Q?zxCAbSVnMTNaT6qlUfXG8KYeCOi9+5uhkcptYbM4Q+0A6hJxQZcV1Yx6qWNK?=
 =?us-ascii?Q?+zZzi1bkI/mIW7gcqSdrr0/wsKqvT/4Xbl/C7JGRWpO6C0/nsOSxbWdYdmjB?=
 =?us-ascii?Q?8SfgkxswGVopJSs/xeDosQ/POJr7yXOBXSAhbu2j9/y2ByrRH0SLcC7aWQle?=
 =?us-ascii?Q?qA+2otjJeYWRjO0zt8e7CuRPwDS/8VxpIChQuFTCxyi4KSzXCnG2Fr/C4wRy?=
 =?us-ascii?Q?NJNkeCB1CTAX9HdikWxX8DAkGOC4rbhXt5UZlA3vtqxu4sy3zSP0MBa2zWK3?=
 =?us-ascii?Q?hpp6DF6LHHMwvleVyUIVKzIiKM4BPBdRPa6vjWRV7ygq3nSuXF2ShxBwvnF5?=
 =?us-ascii?Q?+5EkLNtVfb2buSYY1BHHlAnyb7Tio/VW2+fWcBPkJD+5CEf09HgRDErRUlY1?=
 =?us-ascii?Q?SJdSSSHehs0GtFdaqkQjtNFc3VNeZrWuDVu9DCFVrHD0+Vbh8IYkxxelIDEm?=
 =?us-ascii?Q?nYOSB9a+apRV9ppqptbp0/AxCpJIHMIPuGBdmGM/qdrV6hBwaY9rTMOnfSFx?=
 =?us-ascii?Q?eJE/uT3vw4mGofmy+SbXOlZvoAXGckKYwWf7U8r+aX9xJFtt6Zd0hY72xKWC?=
 =?us-ascii?Q?3RbJACl1fwjPyZkagv9/6T8yGQd3d0bf+wPq?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 20:05:11.7941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f96cc8f0-2a41-4174-798a-08ddc891e66e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5750

It's more flexible to have a get_viommu_size op. Replace static vsmmu_size
and vsmmu_type with that.

Suggested-by: Will Deacon <will@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c    |  8 ++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        |  4 ++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |  3 +--
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c     | 14 ++++++++++++--
 4 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index c034d6c5468f..8cd8929bbfdf 100644
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
@@ -451,9 +450,6 @@ int arm_vsmmu_init(struct iommufd_viommu *viommu,
 		return 0;
 	}
 
-	/* Unsupported type was rejected in arm_smmu_get_viommu_size() */
-	if (WARN_ON(viommu->type != smmu->impl_ops->vsmmu_type))
-		return -EOPNOTSUPP;
 	return smmu->impl_ops->vsmmu_init(vsmmu, user_data);
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9f4ad3705801..f56113107c8a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4716,8 +4716,8 @@ static struct arm_smmu_device *arm_smmu_impl_probe(struct arm_smmu_device *smmu)
 
 	ops = new_smmu->impl_ops;
 	if (ops) {
-		/* vsmmu_size and vsmmu_init ops must be paired */
-		if (WARN_ON(!ops->vsmmu_size != !ops->vsmmu_init)) {
+		/* get_viommu_size and vsmmu_init ops must be paired */
+		if (WARN_ON(!ops->get_viommu_size != !ops->vsmmu_init)) {
 			ret = -EINVAL;
 			goto err_remove;
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

