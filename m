Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE3622DA0B
	for <iommu@lists.linux.dev>; Fri, 18 Jul 2025 23:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752882520; cv=fail; b=XjamjfYkTDkQb2MVHjVTjeb0MbP6WqtUO0JpDBTgVN9OznmZBo4uByH6H4AWsJKUp4diHSEA59C+Wh/vNCfonTGrj9nTPZztz/LfrEKIyChzcfMskPIvwIhAppGAuArCBv+Oxq+wFkepZVuuhyb1u36O/KUsnjzWfIOBzx3qqSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752882520; c=relaxed/simple;
	bh=L1IFWFI6yghglV1vXuCUDPqpGQT8inFvsg6kPljylYg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lEWmqXw5KSq7ybSdFpv17eZGwelOBtnR7Ck+CHgQ7UU68fa/Ec2+66yftm6bQscstGzXmxAWuGV58Yq+Y6Rq6wIon9tmDOTn3MbGyLTD15dgiA4LrXaX2f9wSvI2S+T0u/c72rfaRYNXgGlJSthw8YLHzGkhPvN+ZO9GzzQAUZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZMxgbVxv; arc=fail smtp.client-ip=40.107.236.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZMxgbVxv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xOIA5ugX93kVDCR1QjIYdMnm/S2/Pm490eBl/TE70W+ze0EVelTo0cRimJvrbExgNadAgqEYs1jdxWL4Moxnl2LjIzYi6etdhSX8C3A+fh9KIQ3XGfCEa6SshsaCftZDH7EkY8nIeIDOEDcU8iDbsBQOTIhwDsNJZAeJFoRhh6WuBfUO+JcyaGS5OWNrizXVo20ICbOxTrawOTv7q4JXpofj6kDqAt7RJp6uSBOiMOI6oW2m3Njvd9Zb1OfAX/7Ff7i6clTzMiPkPOqwUwtwyOxQGylFakqq0m/ptPubJ2yZz80hHw0lNahGXFogqG6Pkp/V7hM1NAGpjxnwC84Vpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zd6wzIu9cgEa535XW8ssyYBNaBO2WTM0mZVzpP+xZ84=;
 b=n9PxvvFk/WmNsMI1k7r3Ik4QbQB8xqqU5vq/jrNbsc4hni9bQi6MsNFa7X6NwfThblE/2jcRBDlvTd3C8ApOPSzixU0I06qckDF7br4GH7r5Ldx+FFLmwUga8A10j8kmcQG33u0AdwDfXqWPKOIiyxd9qoGxRh+pvvizPRdaLzB+FxeeLq6w4lSTIvmcbjKeQikSH1nqad28Q2YXWKefvn0QnTG5B4BoYTZfyVtUdUICetibN1CiW5VgirMHva8egkrBRJP/eJpt0qayf0FgK/Iq2tIYmYYdfmnkf6kwtljECRCpUUDq4s8VDiJkxYNZO7EkzGkjnHLcyKn2i4noWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zd6wzIu9cgEa535XW8ssyYBNaBO2WTM0mZVzpP+xZ84=;
 b=ZMxgbVxvDdDP8139E+JqWRWxTo2ZQOEgIrFP7x9lHtrnK+QPnZ4tolbsbFURgRR4t5p0KdXHEdjTrdnTjK67m1IdVxt2YbFe7DljsWNagsfOYQaKX0Xs3s4Oq9KZC7EojsQ7fxcJEgpaIzqsXkyQoaseSbyyonOjTKm2GCgQQOSTR764LGieQsXv2q/YyMGRMcsmFJBRdnfNXFC32ype8jVGiI6obdKR/HSf6Nv7G/Y/I8KDGgRBTJlSh5/qpDxLCS4ZHqTM4HBN+19ZKa/kr6JFpyIfNbQDA+X6ICCA8oeOxfUI9WxApio49X4+AGMtj36VATvY33y7ExLxvWtNBg==
Received: from CH0PR03CA0033.namprd03.prod.outlook.com (2603:10b6:610:b3::8)
 by IA0PR12MB8976.namprd12.prod.outlook.com (2603:10b6:208:485::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Fri, 18 Jul
 2025 23:48:33 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::18) by CH0PR03CA0033.outlook.office365.com
 (2603:10b6:610:b3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Fri,
 18 Jul 2025 23:48:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 23:48:33 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 18 Jul
 2025 16:48:25 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 18 Jul 2025 16:48:25 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 18 Jul 2025 16:48:25 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH 1/2] iommu/arm-smmu-v3: Do not bother impl_ops if IOMMU_VIOMMU_TYPE_ARM_SMMUV3
Date: Fri, 18 Jul 2025 16:48:21 -0700
Message-ID: <20250718234822.1734190-2-nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|IA0PR12MB8976:EE_
X-MS-Office365-Filtering-Correlation-Id: 7444ad89-fd1e-43bc-500e-08ddc6559b42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g+dYLeQFoTpig64x91IP+4u0QSWmtDGScu1iu2NHqn63FeSNfDTZzM5Dw69N?=
 =?us-ascii?Q?F2Rryape86u0akWDi9Al77M49eWQBSNRsSkGh7MvapoLJQK5f1589N5oVcIB?=
 =?us-ascii?Q?CyOeXZ6XDOrjgTsCSNQRFQESVx75m9Q3IH0j5A4SlL1WVY7qj4c4ojrEIXbV?=
 =?us-ascii?Q?4P8Tx6cAv+3fQKSPwoQWx//9xNrBjyPNonhmGK/BLA3BUC0cCLUxu9FPP6Jy?=
 =?us-ascii?Q?n5DCoI61mbeRlqx3R21jGeCoanqrP2K7gF8Kod/QpgsheOagnTMUGUrLxJHM?=
 =?us-ascii?Q?u6Vzr3hryXyLswTY2poWxR5+CUmAMZ5mO4H9KpaKsPLvazAWbMjS9Gq0CARx?=
 =?us-ascii?Q?q2V1rxZVBF/e8LWlPZEZrrtKG+72dU4PNtIjcHSzhFvN1p9Kvq6fsGW7Rk+Q?=
 =?us-ascii?Q?P1EOmt+CYtSKBJuYoBJWgwxPqAhxX9OnezZ1iMqxpcWyl6uGebjJBvRkKQqJ?=
 =?us-ascii?Q?AdgrJKx3+rn0m8TPKxakGMaHX/8oFryaSFnTqj7xgNZcQiv4Itm8FJXQE8uc?=
 =?us-ascii?Q?CzW9rQi0fvxEFu9aJPWklHO0j7jlH2nzWrwPW8xe6fXC59udkQcbVwEi7MAd?=
 =?us-ascii?Q?3diKBBhEekQTEdLo8NjgJgyUhaRyI75RHL+4LB8x0U3UNq2NuJ+cMa7zXQLX?=
 =?us-ascii?Q?yGRVbGFTCcYZCXFWr+HIoLZ5ZsYbplU9R4D6QWqDA7yR0tIu6OauTFGAZntq?=
 =?us-ascii?Q?GjmGe6NWqQJsTmxlUVliSJkBd5pciSBichqVzmoWHEfnficnpybR1VM/5tRb?=
 =?us-ascii?Q?DYuea5Mrtmc5gLsgyP64Su+jIXkioaDuy5Q/fm98+nF4/ZT2BnHcOk6+94UB?=
 =?us-ascii?Q?S4iVmqljkELw+idb9oeSZCT7zo3BBAmEpNU92Nh+S7Cg1u+a0GbjJvwK2gKN?=
 =?us-ascii?Q?/OzIj/KUVZtm2toXPQGtOmm9kDIugG3bIKmYwCCos6X8YYdOQHOQv0hj06ZU?=
 =?us-ascii?Q?vdFibGlUv8Lve8m8SdWuveV3byz1jYAti95PzU50vvRenfUKJLTQnPRRWSGg?=
 =?us-ascii?Q?SRzHC8tno/eyNExCbeZGCwsmgdbz1nY1hukoeIClINFFh2q0U9/oQ3a9vdpK?=
 =?us-ascii?Q?sDliiE/e9fMIrVdNO9UTpiwUQE+31/c5dOevN7GyzOWkkYGDXzGCo0YisDgj?=
 =?us-ascii?Q?KGSv3lkt2KpsL9XDK0ALoQvIk8qjmHYG+KME0ajZ2yvBT+WBrrPSf7f2bDDj?=
 =?us-ascii?Q?5kLwEtvsmL7mgMLihy6L1CNG6X8DYweA5HhggmhdjTtHHYBF7jC3oFKJPxGs?=
 =?us-ascii?Q?0eY/NPYBzeo955TV7nfDZKIAsb4Fgpq+Xjs6K73CPDmf982LJRNEqLI3qdEO?=
 =?us-ascii?Q?GEWM3PQsyAVv/G1SYrSIQ+RaXrNpxUEshCLT3yDMhyJzlxNGI8ZPVlSC8feh?=
 =?us-ascii?Q?cU/u+A6HzMRtUNBqGzcFRy7XXYY7IjYTpCxmEGzSjJXI0qvMwVMqf0vDG771?=
 =?us-ascii?Q?8hmpNWdkK05dRdDeE36VXtIOPWrn7cUYpyPCH+3uAl05kSf2N6nqjb9Uz9R4?=
 =?us-ascii?Q?JMaxRgOAirpK0fMMmQbyJgexQDpqb0i24CcH?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 23:48:33.4190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7444ad89-fd1e-43bc-500e-08ddc6559b42
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8976

When viommu type is IOMMU_VIOMMU_TYPE_ARM_SMMUV3, always return or init the
standard struct arm_vsmmu, instead of going through impl_ops that must have
its own viommu type than the standard IOMMU_VIOMMU_TYPE_ARM_SMMUV3.

Given that arm_vsmmu_init() is called after arm_smmu_get_viommu_size(), any
unsupported viommu->type must be a corruption. And missing a pairing impl's
vsmmu_init should be a driver bug too. Warn these two cases.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 30 ++++++++++++-------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index d9bea8f1f636..0b2acb80f41b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -420,14 +420,13 @@ size_t arm_smmu_get_viommu_size(struct device *dev,
 	    !(smmu->features & ARM_SMMU_FEAT_S2FWB))
 		return 0;
 
-	if (smmu->impl_ops && smmu->impl_ops->vsmmu_size &&
-	    viommu_type == smmu->impl_ops->vsmmu_type)
-		return smmu->impl_ops->vsmmu_size;
+	if (viommu_type == IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
+		return VIOMMU_STRUCT_SIZE(struct arm_vsmmu, core);
 
-	if (viommu_type != IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
+	if (!smmu->impl_ops || !smmu->impl_ops->vsmmu_size ||
+	    viommu_type != smmu->impl_ops->vsmmu_type)
 		return 0;
-
-	return VIOMMU_STRUCT_SIZE(struct arm_vsmmu, core);
+	return smmu->impl_ops->vsmmu_size;
 }
 
 int arm_vsmmu_init(struct iommufd_viommu *viommu,
@@ -447,12 +446,21 @@ int arm_vsmmu_init(struct iommufd_viommu *viommu,
 	/* FIXME Move VMID allocation from the S2 domain allocation to here */
 	vsmmu->vmid = s2_parent->s2_cfg.vmid;
 
-	if (smmu->impl_ops && smmu->impl_ops->vsmmu_init &&
-	    viommu->type == smmu->impl_ops->vsmmu_type)
-		return smmu->impl_ops->vsmmu_init(vsmmu, user_data);
+	if (viommu->type == IOMMU_VIOMMU_TYPE_ARM_SMMUV3) {
+		viommu->ops = &arm_vsmmu_ops;
+		return 0;
+	}
 
-	viommu->ops = &arm_vsmmu_ops;
-	return 0;
+	/*
+	 * If a non standard type was supported in arm_smmu_get_viommu_size() by
+	 * an implementation, a pairing vsmmu_init op must exist.
+	 */
+	if (WARN_ON_ONCE(!smmu->impl_ops || !smmu->impl_ops->vsmmu_init))
+		return -EOPNOTSUPP;
+	/* Unsupported type was rejected in arm_smmu_get_viommu_size() */
+	if (WARN_ON(viommu->type != smmu->impl_ops->vsmmu_type))
+		return -EOPNOTSUPP;
+	return smmu->impl_ops->vsmmu_init(vsmmu, user_data);
 }
 
 int arm_vmaster_report_event(struct arm_smmu_vmaster *vmaster, u64 *evt)
-- 
2.43.0

