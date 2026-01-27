Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012042.outbound.protection.outlook.com [52.101.43.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A1D2FD1B6
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 03:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769483391; cv=fail; b=XpJ9635PPdMmalX3jwJODH0RVH5F3E3tU9s6t8PGae0qPiAHgfwb6i7MMIX7E/5uTTo2RRaSF2nDfK8UsoexhPyAgcoekm9isf+nMar6HC3PE8D6458mczkF1b2CEj9MDgHOCvTRPdDn4Bl0dyD/v+MhjPFLoG/yIbl2qv4LEx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769483391; c=relaxed/simple;
	bh=/Zmmdbf2RP+Mzk6BaK+3ZN9TpfLi6P6DOgpbG7bI/qE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JzDTviIJh7546Cm/wkPhRY1eyFGAg4mTd2JLxQnBqmLy8VRpXbBWuIuVhIrET+dU/8EIw9NQZ95ZZ3bbu4LI7DkE+o8BcaPxOxstDCs37zODhZryGsRNwtyM8EmykKqrYJcP9SCAlOQQmSQ2eBUtj6q0N1pytpGcwGmMJ7BhBxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d+I6NhrF; arc=fail smtp.client-ip=52.101.43.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d+I6NhrF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+f7MEYy1QauNKE0TWFHoef7aq5+joHuEp2O/8BvYwehXXBR90MxSD9EoC5Vmkh7ppXpOeXF93nmah+W7NCbrp7947NRtRi5k6UV5O/1BHKNN9IKMCg6Ct6GWGrV6oBtUXf51Zorrbw+F9aeq1wsDViKtSpFLdBBQL3Z+psWxHcwS3+6FatxMOV0EGt/j7eu1+rQ6P4dKoOQLDTzctyzugSazrRLGNYABdVoXT47N/9vipm4Pr2i2Kw42tehwBVahMgSmyGC0cOYTNfJmuQnaH6m5IRnm3aleolfzJVKQFEw3Vkd8JI/t4bIs4lNB4QCyjE/zaocmFXakf0Vj6yyQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gg7O4T6+DcumjFbxgHM0BeoJlMr/0VGkrnBfw7zDC9k=;
 b=TO1mGKQIbM9tFI9dryyL/hpfGM8ujAjyeW+siJl8S23nycD7rAIsad0QpXOie9fOewCHFUdN6Q4ulhC0l+Dn189+ONI8QeTse4dDPFGukX5t3IfC87juu8gHe46aTi/M15F3rfTCRsDwhhiUodmVx6RmqPNQ30Q+Ank4lE7ZhmlGF2J9nhV12hoquEjPiSP1MMYz81mCX6nA+ZQePzbZSR/GUmn3i6rxGRLcEbOMIE9pnvNsLAPcseiV0KC9B1XlMXbiDZxFqoltqJwljGLFcdxbXYvpX+6R1qBnBwbB7x173CPc6QK7PQds09aCWa9WyHJbVokLHR96fqmr12gj8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gg7O4T6+DcumjFbxgHM0BeoJlMr/0VGkrnBfw7zDC9k=;
 b=d+I6NhrFtCYdg+NJvEfrpx5NPB1HxEh2aGgW4SWH22XPLuZ+YDNScNOsl/DcA3RvLPTzFQzyZLk19tTfg0YcTF0iBoATQWHcUtarSmU5E3o+LU+lVdSpw1Hb0fzAnDkRW/kaFE5jwkR8BpkCQa2Td0FVrRieAbB4F3OrEUluUyWioYxEX9c6DkpuxQHoFtMKXiiOJEElu3ExFJz/WNJVYyP2hisrDU82TafEVmW8nnGetUXAC/1pRUhGCYcBZI74DBZd6Yl9LJYUdPpYzVn6+lgf3QAByhXdVTTXW9wL39LHwobtcqpWNQ2sxX3r9oNU3JQrBhUWrGirju+PF84B8Q==
Received: from LV3P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::18)
 by SN7PR12MB8817.namprd12.prod.outlook.com (2603:10b6:806:347::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 27 Jan
 2026 03:09:46 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:234:cafe::c1) by LV3P220CA0009.outlook.office365.com
 (2603:10b6:408:234::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Tue,
 27 Jan 2026 03:09:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 03:09:46 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 19:09:35 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 26 Jan 2026 19:09:34 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 26 Jan 2026 19:09:34 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v10 2/8] iommu/arm-smmu-v3: Explicitly set smmu_domain->stage for SVA
Date: Mon, 26 Jan 2026 19:09:13 -0800
Message-ID: <444724fc12a62f3746b6ad38d04e88c2872ec9a0.1769476588.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769476588.git.nicolinc@nvidia.com>
References: <cover.1769476588.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|SN7PR12MB8817:EE_
X-MS-Office365-Filtering-Correlation-Id: 26a52b20-b3d7-400f-cab7-08de5d5186aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dVblUuzNlXIjxatoPMv3Vpf8+W+3hPGKlnV5dmQpGKgTi5NS4WFFjXZrCh5V?=
 =?us-ascii?Q?t2E5kZ4j5w19X0tNer/7Nlw9PUCGskWFeO1t/c77m++v9Kg8lbY+f+kNBeMZ?=
 =?us-ascii?Q?45D8aVpIW8dJoNNNYN1W2+9fey3y3+09czPzHekhRW+Zzr4RIasyhox69nIr?=
 =?us-ascii?Q?zH8DN9oiGnS6XY5y0bBUg2sqqlwU1ho+rpgwupAAg0m9f+8wz4lCBuK3/sWG?=
 =?us-ascii?Q?poa/xsPMAmTC9fOy8zRBhqPYJJcI5wlSZOw24SNlCfvQx532JHvxkJP9y4OG?=
 =?us-ascii?Q?iK1/CyruOM8c6DMJzKV2y9ogXtRvBzic90m4sxe59bIjrrFcKzxsyFwVs2Z+?=
 =?us-ascii?Q?pqx0KAxosuOTcInZu6GJaUz7mFbvWCSFgSRb5uqi9pTV8jk6DR7EwjBOd/m9?=
 =?us-ascii?Q?veqP9ukB8R3oElrWE3mtkW8PYaJ1CsaE/qvQhIJB2LFLhoEmceokMonLHZmB?=
 =?us-ascii?Q?jWt2f5Xk5PqYFS7OjUJFRjB518YkKLYhiXS1Z6MAzqc337HqI97Yz9EeoOlY?=
 =?us-ascii?Q?Z2nuBd4mlRHajJhl0cYjjBiI3As5uHMizyVEqQtawAUraXwvDZTmul4NwIw5?=
 =?us-ascii?Q?FwPXcDHxF999c23Qw+taCgi44eimchAzAQVkmvwfQbJ1Z0VjfCN1BcS+L1Ix?=
 =?us-ascii?Q?Dm3/CXUuoFi3on2IzuXFgEFBjA+kvx8SkGF9m0srAziMIzcXQf8f9QBS2jFr?=
 =?us-ascii?Q?kgonB5bCE8EJgK0XeLlQp9I/BiTrbq4AvlU+3874RHjvW0A9l/nuUQiM2nYS?=
 =?us-ascii?Q?BiI6YeE3pAUyJiXOMwakKlYKCWbZZPbkSMcEN0OOBPEHbefMgB8onFdCHU8P?=
 =?us-ascii?Q?XdvQjQT5qDxH+obR3Wb4tcZrK0HFeUWbBzUkSWYHx7mqtU3mxp1LF510tOla?=
 =?us-ascii?Q?MMh0KsYmZbdxAPMpMPhSxeZ19Kaq7313oqWkBsdgJmSkpEdEKFl6yjjIkmDW?=
 =?us-ascii?Q?WUdLIQKSNFei9aG9rqb8VNKPl7qU5bCAN5Se7wLkekPiZHN7VLDgshRBhl9E?=
 =?us-ascii?Q?SYua7+1rFHEBWVq0oftBwA+KBAiv9AdwuIBaNAqkhZSV+aLzZ00JljPQdyIG?=
 =?us-ascii?Q?BBKCr2EA7cClHRX2snCRKsKZ3/33VA0XWz/xpmRKFW2rpbHWlF93pI+N0irz?=
 =?us-ascii?Q?MWykUO39oN0p1Nl9RGn1cjLGb+mEGBJ9CaVVUCvYP8x6kSvNr4t1+FI0ug8k?=
 =?us-ascii?Q?THnb6gFaWF5IFRbgdCCtZhasw7t9V+OEgcUuNI+omiD7/iOWfxls7OUZzUi4?=
 =?us-ascii?Q?gHnUMuQ44eKVYth4RqcmsSTDL9DLKZvwxmYGZ4mspDScSEyf+q/OkM7ozaQ3?=
 =?us-ascii?Q?WVXVIt8vZkLWyIUi61o3JRmSn7U1Za5oaUwA83U/MhsCRBPCgoKEHilwOsuW?=
 =?us-ascii?Q?+hqq2dhlLlEHjTvIv+XGFgjHqbbzceuOFEiWWYSLCLuAZA7yLiVHPk1JXMvV?=
 =?us-ascii?Q?cJyNpNGm4Z7OhIn2dR0Tc92ZGHXTq8k1U+hCisTaW5XX63cHq7A15npl90ry?=
 =?us-ascii?Q?D2JS0FlFv5U6dAXFeRXx8jqxPE54a0EQxGA371G44BsslsdtLapUVLAIDuqd?=
 =?us-ascii?Q?tObzBdyvj+uh5yfZCIpMBhUqvBcATnEitBnmiXb9p6E2y2xtCrFToKxsExna?=
 =?us-ascii?Q?SWKY7ian8bb8kq0RMBn9fSjeHnEEWMeC8ttt3fmyMfLZgtgr2LKvNefVzbtM?=
 =?us-ascii?Q?8i4bkA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 03:09:46.4500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a52b20-b3d7-400f-cab7-08de5d5186aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8817

Both the ARM_SMMU_DOMAIN_S1 case and the SVA case use ASID, requiring ASID
based invalidation commands to flush the TLB.

Define an ARM_SMMU_DOMAIN_SVA to make the SVA case clear to share the same
path with the ARM_SMMU_DOMAIN_S1 case, which will be a part of the routine
to build a new per-domain invalidation array.

There is no function change.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Balbir Singh <balbirs@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 3c6d65d36164..24894b163004 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -856,6 +856,7 @@ struct arm_smmu_master {
 enum arm_smmu_domain_stage {
 	ARM_SMMU_DOMAIN_S1 = 0,
 	ARM_SMMU_DOMAIN_S2,
+	ARM_SMMU_DOMAIN_SVA,
 };
 
 struct arm_smmu_domain {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 59a480974d80..6097f1f540d8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -346,6 +346,7 @@ struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
 	 * ARM_SMMU_FEAT_RANGE_INV is present
 	 */
 	smmu_domain->domain.pgsize_bitmap = PAGE_SIZE;
+	smmu_domain->stage = ARM_SMMU_DOMAIN_SVA;
 	smmu_domain->smmu = smmu;
 
 	ret = xa_alloc(&arm_smmu_asid_xa, &asid, smmu_domain,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f0e3b407c293..a55f9ae95411 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3133,6 +3133,9 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev,
 		arm_smmu_install_ste_for_dev(master, &target);
 		arm_smmu_clear_cd(master, IOMMU_NO_PASID);
 		break;
+	default:
+		WARN_ON(true);
+		break;
 	}
 
 	arm_smmu_attach_commit(&state);
-- 
2.43.0

