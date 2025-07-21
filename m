Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67680226D04
	for <iommu@lists.linux.dev>; Mon, 21 Jul 2025 19:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753125180; cv=fail; b=CA6/RNHysuStUBeAVM72GsfAIuheD5ZMncNmKxYJCkndzYIkYDVt3sUTRZWD0nD60EiKc8ZiI79gyYCWNnTfyyteJsnZzQtocDr2OyVdOcdNTi/7/d44A/vx6Mzh9U9AGXgSUuPw59GRjR+woMbZPFp5RCJ+S1lSAKJ5PjHFjIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753125180; c=relaxed/simple;
	bh=3U/6D2iIYKkz55T6V7e4rxt4xfbB5iOSLL20xnuD0+Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L7UYqpDfmuQ47q38IdUyG8nDoMnP3WfI1nN5wRN5/IIJfvQkuzepITlYDoh/3RKGjhBCcQ3AVB1vmttGlM7NLb7DtXQCrj36/Ut/MC3Nd8ut+Mr/LG3tfY46bdd9TapUtSaK43u2QyiqJpl0z/J7jpKIpNCY+pRTdV02FLaPDj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sSbYp6ie; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sSbYp6ie"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NbooXBQaAh/UM5P6sT3PWjjxLHYWH7kH/LW6dMVBMiz3P38LTBncQ0hBZJ6NtAEFvXi4frFLpvKXv5y0Ipytsho5jr/bEowbKF2EJZZlCyAtzXTr5/ybS+0Ma2G/LK3+malfb7T5vCyJZ27WlEQTiBCQ8WRl0zLh09FW4OiggdpaThanoP8/zKiGFfinPljrrSrOMaJzPKMzOgIxA7H1CXCEmzj5fFkApn9VKyadGz0BXjT/7ijDbP8seX14GxMOLv2f5QivZc63MCXCxNj6trlN9hpbyXtPPu4JFGKceRHCKkoKaSxk2JynW1qXhOf9peY4UdynBk4zmZtDU+vBHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G50AU86xwES1WC4tq5I7VT2TuMQEheu5mF2Tu3oE0JY=;
 b=Xmy2b3P5Jl5DyTB6qdxFEUYhTSasC/3svtP7CJIKpb3//ZTO7r3+Fmnx6iLnFIBKHrsxEZWMLk6SpOKusfzbMEJLSV+qWZmDzkVQlxGwEUybZXNEjxNc9e5dAT3VMHc0lV8fvyqMGiRzGrUGGzuR2J6L9QrKRJvJ7EhbO5MQndtoGgd1pRp9KU0Y+n+L80ZwNu1CbQ2U4ErA257wV0E9AZK8ELvJO/m5seSmwN7SStd6XS8PEnqozhAsI8UAjDX98H5I+0AiKNv/7kyBX/7iDh1nMcS0HnqPwbVd/mPtsVLer3NmVwGhpWdmqh4DZgthXqpsKmm13X8ENBPfXnXvDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G50AU86xwES1WC4tq5I7VT2TuMQEheu5mF2Tu3oE0JY=;
 b=sSbYp6iesp2nHj6yNOBxcdjo2hk5QAHBMQ1Kz6lG2fqQfDzOwjxj+0XSNheMJl9ErGH4XdCrF+cxHXa6IhKvXrWq5EzC00h+Ly7pGfjziEv+7X6h6qLyVJJk/NgDj1pV/H9Q7LQmQYwxtI9tJXredx/GuX8IswDg0QS/eGTXNxJt9WBZpoZaZ4kHqWvHKfVprf/8ECqpoKruuK796k05nhPwAgDNHPzuBeznsGtln349DHStJYosfDlS4HQHytI+r3NUpIbn8mPlYZp7zplQc9Jkx6mssoG2fh7ykANFXQejV8TtVQHDWng2/XF/HMACqxlmPD7LhDWzQ2Jg2KI5QQ==
Received: from BN0PR04CA0204.namprd04.prod.outlook.com (2603:10b6:408:e9::29)
 by MN6PR12MB8492.namprd12.prod.outlook.com (2603:10b6:208:472::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 19:12:55 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:408:e9:cafe::5a) by BN0PR04CA0204.outlook.office365.com
 (2603:10b6:408:e9::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Mon,
 21 Jul 2025 19:12:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Mon, 21 Jul 2025 19:12:55 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Jul
 2025 12:12:45 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 21 Jul 2025 12:12:44 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 21 Jul 2025 12:12:44 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v2 2/2] iommu/arm-smmu-v3: Replace vsmmu_size/type with get_viommu_size
Date: Mon, 21 Jul 2025 12:12:36 -0700
Message-ID: <20250721191236.1739951-3-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721191236.1739951-1-nicolinc@nvidia.com>
References: <20250721191236.1739951-1-nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|MN6PR12MB8492:EE_
X-MS-Office365-Filtering-Correlation-Id: d48919f4-af57-47e7-f29b-08ddc88a98de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+7gVL69WL3kARjsL9y8t44X2XWMz+Cb+Q85lSsxAJ6AvMvzXLhkupv4glfiW?=
 =?us-ascii?Q?kfhqqVsuJEzNRrFX/j2oGvkk0icLw/a7iK2WRJDSgbhGOy3L1rGVv3lbwZzg?=
 =?us-ascii?Q?+oWfhl6XXtR4ucABX6QvCXIg6Xu6pEO/gXtuyvm3TZDvcCuree7vdpRiTUPJ?=
 =?us-ascii?Q?pBUKYDlftJILdtJmSSAV7CbWRiWaUOZM0L3Hb75p0kwIdP5OPr5IPr7KrKpq?=
 =?us-ascii?Q?9jlCT55b9K3h6r5jTV9roi5eGVotfOOj44J5HajkiaSeY1TQRm5P59h6DcWd?=
 =?us-ascii?Q?Pj2HGwdxhzGCnzwNlGEmJQpI1ctI3dMe2JMDyGTVZ3/Hxje/IrN+B3t2fZME?=
 =?us-ascii?Q?/qxuSTyloAUKSadSJ9bLozVqCBjAQcDow5PDJVojVuLHEQQTAyaAg+FwRX+Z?=
 =?us-ascii?Q?tAujCx25fJD1lQljYZIZ5kUQiO2iL2kVzT+QbmyZvXmktgJ8uzH+ijRhx9yy?=
 =?us-ascii?Q?bFf/6feNEgmDMsJ0XPMe2NgYcBhp5WPnpq9b8g2CqN2rW89pLC6DOp9VL3jZ?=
 =?us-ascii?Q?N+NmN/MuAAXNNFaqL8Uh/6vS0LBj/E1Y0/yfyFl/n1tS+gVB1B2732KX0ah4?=
 =?us-ascii?Q?nnEt+P8X1ba577dBWqrEYEWJd7DpRh9INujzlc/vWddLYizGHfw6NLx/fyQ/?=
 =?us-ascii?Q?d/QEi9sURbXhi7Ik7xoLkedu3dA65Vj0eF96ZYAocQ89jB9Y/AAWlPGi4IcJ?=
 =?us-ascii?Q?0lxcvTyggcwqMF/W72Hhgw5MGtO3+NyMBL+VClMp2GZNtwb/4Hvm6i3Vxgu9?=
 =?us-ascii?Q?iKAngAJtmzUPfaBqOBirG126djplKEDljXZxOpKbdOUVIbS6VUEifcB6Qd/I?=
 =?us-ascii?Q?S4sjZoqAs51Z6cLSjGfjlYRxTVtKzVjrpTl1EEe95RNr9gYM9ldERlS+b7a7?=
 =?us-ascii?Q?L/GndX3CqKEfK9aeFX+2oQDs+bZ5reEgzLTzV3xWLq9SzxyZzBFSSBc45R5F?=
 =?us-ascii?Q?EgRokZL7x17rgx7Oc12WlADTvwonBUWGv9CiRQ7JPTzhwRftac1yBLtLm400?=
 =?us-ascii?Q?8q3MhhzAAJAg3wIkEFnG2EWrXEbzkybPFwNomYCaDBDbGQsGyTE64howuBzn?=
 =?us-ascii?Q?KxlcmRfh19UgT3jB2qI9/LcgDM2FwzdwMKKoxgE5Su3QGlkITkiQRO6NGI3a?=
 =?us-ascii?Q?+XEWkUv+OYg+/PpEL1TJHRPBN61IW2l60v1qapk49FdwpQkhig76Sks62alt?=
 =?us-ascii?Q?pUQOk1Gs4hq7pUeJ2nKP9OyPmPrwy3ORreeFUGc4dYKPQptuSByeXGxRr/E/?=
 =?us-ascii?Q?7zcyX5eWq288AHsZPeASsIdaWT7uZ7TTDR3V3lh2HOfu1bj/Qk1IVR9gS6l7?=
 =?us-ascii?Q?jpDOruvenKnmEPrE3HppPvGciEQ4iNtp0pMX/kSFIuuUeiZy3gvgy9zMsVCD?=
 =?us-ascii?Q?9Td6BG426d+bVlE57NAVrsaKeaSyfKTVSNUVx7l7R9xV+suiz6S4f3nZIStP?=
 =?us-ascii?Q?rBmVA/XBpwpfpaFxHfX3vVlE+SqTof1q+lgBf5XQ/7UVRKv8yddvKLCguO99?=
 =?us-ascii?Q?wkAh58gIn1mPWN0JKQ64Dvq0ksBHKbuBCZKp?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 19:12:55.0555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d48919f4-af57-47e7-f29b-08ddc88a98de
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8492

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
index dfe7f40fac35..b593617446b4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4716,8 +4716,8 @@ static struct arm_smmu_device *arm_smmu_impl_probe(struct arm_smmu_device *smmu)
 
 	ops = new_smmu->impl_ops;
 	if (ops) {
-		/* vsmmu_size and vsmmu_init ops must be paired */
-		if (WARN_ON(!ops->vsmmu_size ^ !ops->vsmmu_init)) {
+		/* get_viommu_size and vsmmu_init ops must be paired */
+		if (WARN_ON(!ops->get_viommu_size ^ !ops->vsmmu_init)) {
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

