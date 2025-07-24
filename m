Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C7222A808
	for <iommu@lists.linux.dev>; Thu, 24 Jul 2025 22:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753395035; cv=fail; b=W9m0qfBNIYth9I0gcoRzZbLfjdLNtAGMymgNuckUJD6yzgugg1Oa/lUcqdaehOCJZiubsCQ++93TOuywuwPKk9S+B5a3fz6LfP3J21iS+b9sf/gyg/mmL0T4W0ssrbwOsZxOBkOm2gHshAxUhTsfmhiPvQ61d+pMsqzhUA9rrlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753395035; c=relaxed/simple;
	bh=sKXp07ksQ0KpIKO+3266bHR3n3Lj+XUCZWKg4jrA500=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RydAG42oa08JWG8VXqlzYc61epwbifsBiBKWyBh+ZFvpGVpucXoR4CxJBVspT74wHsBjU3psPKLOHkzusshUCTo14uiAlm4y09ovzAGwFi5+pQkkU9stalgDgib7nb8vtlMdrJqxN9Q8Kom9vJ34Hytsn6Ay7euwMPuakbI2X7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kWOeOlCC; arc=fail smtp.client-ip=40.107.94.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kWOeOlCC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SkcfBHUEI+t7iRCzV68SWlHP2dAmfqXA53hxJWRIo7BBkNyxRuTiPu94r0Hx0SnRtPTYPAMZYPHYCFGlF0yBEi2l00KgsPtPO+CdmkzJn7rzL0QcxOyvqqqu4piUVthD8N87KbQUO4AluMtsuDjGsPPjLIwMmaxC7QDoS45dUtDe9PBGrCZwe0tk9cjJPD/IPP+vdTs6Az5Ns5KUc6/zeYjSf7d8l6wsal24yMEoAe84ar+SMfdNpc9mE7u92IyFPcQ+mrnAbRuHJBSjVButnaWvk8PnGAiTeNWvLoaJjhUNh8I2qp+hSZPS841DAlm17WwITEElqBtA6CBSACOpBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmBOkMtJNSaDZdkSjlariyvaD+VtxrrG0Yum/aHYIIA=;
 b=RN+vzasURXT0vjxFtK/rD7VH8zI4MvFAnF9a9S3PPZolrZSoDOvdNqFmipxMa9x/oH3JZdCduP7izRArHLOQG3Ztf8JIpmi0Ab5x6mgfOPOYohoEyP2DJjrYzQHKJfpH/CZr7HlFN+N5eIhFpR7AXpBdyelrZyapnFvBRC6LKihZu1BBmhJZanQHiC+OGuTXrmEx+8otrw7DroPt7Aed2cC/UU6nvCPNnKo2b4tFfunooU194IuT7wgI8OCgsIAyZFEq0Xr43rdNmNYm5C4O/GM0K7MCC/Oge3agfrAw7TyF0mL+VGgmpjAo4BNOel0Tp+/l+hCGWjrww3D2ZfCLMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmBOkMtJNSaDZdkSjlariyvaD+VtxrrG0Yum/aHYIIA=;
 b=kWOeOlCCysH6278XCxYLDW/u/kxvDMbNxrD/eBjwGvSldLt2GpUMopdn7PH0ws3QKNxtPNnJh/y7GjmeRw989hDYpfcASec1TipWGV4ePTpw4zOPm3p/V8veeE22+67sLP5iJH5ctnwQ2/PgN4tuIRzHVcnfWxF4QjX4XPkU0u9Tfup26yyxgHtmFPkK4F20x6jKrFGGWhuyqhN2QfQsayFzmu3TyL2+qDkH59TeEvPGHdMBZwnj5DAeHY4n3xdwKjON01nOamB82dhCo030JbCD6vbLIs5TuehjRcaNOegogLVAHQ1B1YTSOUS8tjgaCYR3m8YarYgDoiMuKDrR4A==
Received: from BN0PR04CA0133.namprd04.prod.outlook.com (2603:10b6:408:ed::18)
 by DS5PPFEAC589ED8.namprd12.prod.outlook.com (2603:10b6:f:fc00::667) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Thu, 24 Jul
 2025 22:10:29 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:408:ed:cafe::d) by BN0PR04CA0133.outlook.office365.com
 (2603:10b6:408:ed::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Thu,
 24 Jul 2025 22:10:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Thu, 24 Jul 2025 22:10:29 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 24 Jul
 2025 15:10:11 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 24 Jul
 2025 15:10:10 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 24 Jul 2025 15:10:10 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<praan@google.com>
Subject: [PATCH v4 2/2] iommu/arm-smmu-v3: Replace vsmmu_size/type with get_viommu_size
Date: Thu, 24 Jul 2025 15:10:02 -0700
Message-ID: <20250724221002.1883034-3-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724221002.1883034-1-nicolinc@nvidia.com>
References: <20250724221002.1883034-1-nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|DS5PPFEAC589ED8:EE_
X-MS-Office365-Filtering-Correlation-Id: 8469a568-855e-4e73-06b7-08ddcafee672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/dPyslMOX+WsAmV2N2hFmkhq3anSpufpv9tiSgdPJ4lz4bZrYYp38pjHbSxC?=
 =?us-ascii?Q?LrpvAlz+TusUD+GVB2dX7V4ztaKoYaDn/MHA2LJPjjy6G6ErBb7CbH+lJZX8?=
 =?us-ascii?Q?Y/wo4oAt8DplO6xeFf4umXt0Fhc26vHrGuqHmwhtcFf8idBstLVYDcGuFfzN?=
 =?us-ascii?Q?R2RVIHDuSuJlbK8gyJhpuCe9yE/ktZ09OYJoIIr3aG+AdBvr2AgiDGQcz8es?=
 =?us-ascii?Q?Zk10sKK4r6CGBty+7Rm+JOLGBXOvWCFbQENEVwnJB016uFez98vtb6//++ET?=
 =?us-ascii?Q?HNG+t6DcqwU2AZTPkI0oTzvYZ8htliOgIbWh/YtzIAdJrox/RhG3gxn4KUid?=
 =?us-ascii?Q?vdt+73G/AiGtz8H984B0nEryhvhW7DA5X5bcEoRN74u5OHdDlXF1iSlvjh/z?=
 =?us-ascii?Q?chHmfr6lyAQYEJqTVJYkSoT5aUFZNcn/gw10CzMMTVjqx9trIlsnd2Zs0MEE?=
 =?us-ascii?Q?WF08Mc1ljAQUm7ZQKcPeLkYuZxWZbhP/vjKEJEWYHztztAAhkj9/YxUMoEw/?=
 =?us-ascii?Q?RqRQz69g2fwVS4Y7aomN5nRFPikyfoTogtpUSoYML3r0G4Kiy6rM0HIPBbBG?=
 =?us-ascii?Q?Ukdoc7MBIQTjzUXcLmjcnILVlUu1PovJtIPy+mP51ycEaBMK43877pvYG/Pe?=
 =?us-ascii?Q?amfvPxkIVHO2/2s2ykFIGIfM6gXK1Q8g0hW5kqcYf8iQjS6nYQvoZWos0eb8?=
 =?us-ascii?Q?cgCmIx3JhI4rM1mvSYPz6lwGFNY84GcRdf3mAoK56QwIXBpBcMd/BKAOvZBl?=
 =?us-ascii?Q?dXiuCZ7RlAE9Gq1OIJ3bA2b6LmR5Dl4W9lsOPsbTQFXRUqm71oTCOTlRfyI9?=
 =?us-ascii?Q?NSOfW/iE7Vr2E6O4+qQg6g4zZ3q9Zs8gA9jpq9k6h18jx/QvMvTNtYmqsa4q?=
 =?us-ascii?Q?MPyj61Fh42uQempd0z6AnYDQrE8eIqlBSe2R4lJaUG7ojfAhE5OnuIwN6xt6?=
 =?us-ascii?Q?VeT9+RK2X9ot16mbiaESiFqk5q8u/Szd92ZbW0gRQcV3Dr+Uaz95/7I4HfuB?=
 =?us-ascii?Q?TEySTuq/8i0ayykZ1+b0l2yZefAh6Ia1i3JJxzdN5JOaPqdXonOifgB7KWDQ?=
 =?us-ascii?Q?kpc8WScf7Ybx+Z96AiuragjtqGKd4dPNUoVmjGLuzaln2bG9M0LPBld0/EsS?=
 =?us-ascii?Q?mDQzidKraDWCZO/JELGNx2nvVH+4KoAGa7md7noynFpgmc8TGunyKgnF92iK?=
 =?us-ascii?Q?8cpSDV5ZteYm6BiRb1rS0ZzBy9UfWBu1M4W2QVrn3QidQsnxfriTzZJOqRZj?=
 =?us-ascii?Q?YNk1UalA6rYuNdm9xr3iP3WkvlJzzWUUt8j8Kdbu0tvgHGGjwlnsmKUjA2O/?=
 =?us-ascii?Q?jVceuE/EIxAP2bOEqqvCwX4ojLTXKduYZIn5NEN9Kc7RmO5wPj7UOcGSH64B?=
 =?us-ascii?Q?VLnZBiYiDVKN4sQ51XICZEWJvReEILHs/h7t5HNt2GsvvyjgltGS1Im4T6M6?=
 =?us-ascii?Q?RRZJ1ZISuju7qhDXt9VlTZp/gPtAyV7C6IUCjm7XaLYwmi3friEcJYhlxQuS?=
 =?us-ascii?Q?z1N1CdWJiya3sdOPbkp4PvH4LHZo/Rlf03KO?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 22:10:29.1350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8469a568-855e-4e73-06b7-08ddcafee672
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFEAC589ED8

It's more flexible to have a get_viommu_size op. Replace static vsmmu_size
and vsmmu_type with that.

Suggested-by: Will Deacon <will@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 11 ++---------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     |  4 ++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     |  3 +--
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c  | 17 +++++++++++++++--
 4 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index b963b9b3de542..8cd8929bbfdf8 100644
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
@@ -451,12 +450,6 @@ int arm_vsmmu_init(struct iommufd_viommu *viommu,
 		return 0;
 	}
 
-	/*
-	 * Unsupported type should be rejected by arm_smmu_get_viommu_size.
-	 * Seeing one here indicates a kernel bug or some data corruption.
-	 */
-	if (WARN_ON(viommu->type != smmu->impl_ops->vsmmu_type))
-		return -EOPNOTSUPP;
 	return smmu->impl_ops->vsmmu_init(vsmmu, user_data);
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9f4ad37058010..f56113107c8ad 100644
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
index 3fa02c51df9f3..e332f5ba2f8a2 100644
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
index 4c86eacd36b16..be1aaaf8cd17c 100644
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
 
@@ -1273,6 +1279,13 @@ tegra241_cmdqv_init_vintf_user(struct arm_vsmmu *vsmmu,
 	phys_addr_t page0_base;
 	int ret;
 
+	/*
+	 * Unsupported type should be rejected by tegra241_cmdqv_get_vintf_size.
+	 * Seeing one here indicates a kernel bug or some data corruption.
+	 */
+	if (WARN_ON(vsmmu->core.type != IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV))
+		return -EOPNOTSUPP;
+
 	if (!user_data)
 		return -EINVAL;
 
-- 
2.43.0

