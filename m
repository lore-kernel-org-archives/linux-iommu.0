Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012013.outbound.protection.outlook.com [52.101.53.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6946A330D2A
	for <iommu@lists.linux.dev>; Mon, 27 Oct 2025 18:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761591303; cv=fail; b=SpO93bIpE8PiesABEWFfYJvtA7NwrmOxkSHeNZReGPgrrKla7ip3NvD+vJKK+JpOEcHKkYmJ5su5co/SG40I71oLgvZpuXn/oUkWUU9Kkv0WgqnGjtWLNYdo086lNGM6c+1IqJl9ZSHe4758+C0kxWKrFEMGL/F9fJ+Ys6XnFrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761591303; c=relaxed/simple;
	bh=bl9IEwTIppFoEihuKPuVbkAYKHU8Jwkgj5JTimSpaGE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k0dE8RGBZvSw/uUykZ/JjXDvK1+yOAEAPWyXbIE93LwcMaag8Od0UY7bPCSm8Cd8KbiZ53DdldYv63Cp52Fy6GXgolveX1tPYCpC0lXsR2C4dwoJRu6U7NsEUYY+4DS6ChW1qOvMU5iQ9dfra/6Z9EkEfC4USFAG2o5zZRpKbww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VUARv4b1; arc=fail smtp.client-ip=52.101.53.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VUARv4b1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gtIa5+HvglHyAtjjtw1TExmF1i2MEmxQ2MXoxaPdB2aYRm8b5a2V3LaWRHpuZyPuHlcN1KGiHQNzPmt8sYvfPs/sJqg/3msIAalM6MtitjV/Rqcy4ZcVlo53okkRA/NmZpAXycFGyZ3BhL/pZmAK1U/slRnBxFs4Fvg7jCPDqI4/sz2U0bZt+jk4xdCtNwTs1U2gYWNWQNZeB/5J/jiIUY9qRM+NTGA0VMhZ5BHzxjAUkZs7Faavy6ibk8Z8xBPkCPswT+TPLSCDyxjeANVU+zDCGeBWIAJubTcGcKN7DDO2xFk7uwaiadxQO32q0S1HuoOnRa+q+nqef6id/147pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4g0VVzLyXGV0fvnY7szZTrctHrqCHmUf0gj0rCNkJ0=;
 b=xUE8Z7D0CBwYi7v/geGXrozxogqfT4Bc5Sx3oyBbuyrGlMDucmN2ca62IDoN1wad/fiQwuHytOuc3OTzcj7mh6N71e31lw2hlSF+cyEzIStbOQ6DXCcrABCovX0sCdYkNAvYVGzFNo7QCCpgMhVf06o+wnq5eINeoHFGfKGuNyn1XXE+09Ov4IT7ctcwHWNbBOh6Nkfv/vkbJnLbamvBBMGGDGgj02ZZvEBUU2i7Ezejd0caw2qlMGAJvJi4zptcSda0Ix1M3dlfhPxeYP0ksZkqYWt2EOJFQ6JdR2jrcjYhBqolVRUcT9wKh921d64mOEmaZw5T6bnd95C/bEf28A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4g0VVzLyXGV0fvnY7szZTrctHrqCHmUf0gj0rCNkJ0=;
 b=VUARv4b1OgC3DCRQYJnYokj7riSbj/VCZ0iegiqwLr3UNGhcjQluor+Uxgp64GLv6bVBjC0fJv4PGVcKyTFO2jwHFXgib+u1X74YQBaZhLb0C8gEsbpbSHAGuzxxWSmTk7wR3OoaxgXHvP/W0vbiWZ1LVtrzGeLRO7Dndr2IZT1yjiEPV2rWUnzRzCkL4Y2nzSm4VxrcAPYxrWz2ar+kaRisvZn/EhYTrdytnNPgBVoChp+tHUnJsyDAS7cgFYvmuzRcxqJU46HYfZQuYuMRNz0tRJypMZkGvp0WBQLvHTf64YfPk8x/HQJzZfxm8hI/zrp+B92csoPFca6DVb2h4A==
Received: from BL0PR02CA0103.namprd02.prod.outlook.com (2603:10b6:208:51::44)
 by MN2PR12MB4208.namprd12.prod.outlook.com (2603:10b6:208:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Mon, 27 Oct
 2025 18:54:57 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:51:cafe::ae) by BL0PR02CA0103.outlook.office365.com
 (2603:10b6:208:51::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.19 via Frontend Transport; Mon,
 27 Oct 2025 18:54:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 18:54:55 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 27 Oct
 2025 11:54:35 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 11:54:35 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Oct 2025 11:54:34 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <jgg@nvidia.com>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<balbirs@nvidia.com>, <miko.lenczewski@arm.com>, <peterz@infradead.org>,
	<kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/7] iommu/arm-smmu-v3: Add an inline arm_smmu_domain_free()
Date: Mon, 27 Oct 2025 11:54:16 -0700
Message-ID: <a4febbb5533127a20f61796e1afc21bc4a132203.1761590851.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1761590851.git.nicolinc@nvidia.com>
References: <cover.1761590851.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|MN2PR12MB4208:EE_
X-MS-Office365-Filtering-Correlation-Id: 67715ddc-4a7b-41cd-c796-08de158a51c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AFXdLZHp8kyIkcv/TS6Bjs/OS8b1yj29M0aO4Eaqc9iJoM6hxSSrAuBuRntm?=
 =?us-ascii?Q?3DZmBgGOYDdNxhAwYKetkYmFg1dZMaujHCUCIP9XDfNBnai+P+Hn/+XS2aWo?=
 =?us-ascii?Q?tjDQTSfQG1NEqM/yQ519lnCKWQUn+y0YR+rMRFgNYLRQzMcSnIf5NNfOEHSN?=
 =?us-ascii?Q?tW7tCPjyacp+bOlgHXeqoZHhNiJ/tnkTwStJMV1fSPgXOKDeT1Be3ki4sRIy?=
 =?us-ascii?Q?kk9OMbuFT6bgyBHp6yxVPQi2l/wwDVVyGfSjqfW+qKAzdt8gPDk5LV7YaohA?=
 =?us-ascii?Q?CEo4BYZWLhtiu/74i28Lzmc+Bb20AC1t/pw49Tpgo0RvcHfo8ovGDrJKb601?=
 =?us-ascii?Q?zQxgh47w9b6tZcv+86QihfwLxBiGUhGKC0qQ4RP4xAPgH4JMOsjpFrnE3DkT?=
 =?us-ascii?Q?diEpTYndfraX3I/d9mh+cT7+ZHYdqPHt4B64emhOOGvPAQoFGsrfWostKqRo?=
 =?us-ascii?Q?26aPoN3foWVQb1Jlqsvn2sRgS4iRJCegAGG747W4YtFyn/eAM0KxgEdFMwV3?=
 =?us-ascii?Q?vuIY4zkmZGDPWJ+T3f+H5e9qpb/GcgAF7KkIHMa3QkX9G1ExIjaSoWWsC343?=
 =?us-ascii?Q?Cww99yGvtmwNAXmIcxlIYUv2hTc+J1YRws5jjr1LEzRFid//IY+Bwqm4IZAA?=
 =?us-ascii?Q?uXKsOqjgSyhaFkgbKBqtkg2Kj4UwMnw6uxK4dCM0e7a9aoXCG8DztBTMMO6W?=
 =?us-ascii?Q?Z5GWarKpCgLYUVKBv1LP/iouyOYkuttLnVlUZyu173SwnlPYh8wM8B2bagSh?=
 =?us-ascii?Q?gtVLFd/+FJ3yj6xAr8cSwTbS1Ekn3bQ2skiBbcAi5tv3vdvuQrFUvVp7dWIT?=
 =?us-ascii?Q?igb/6d8IoGdMKSmNT1zTvejuxrg7KiTrC98zd+W1H45NIv+h9peEF5MXzqn6?=
 =?us-ascii?Q?GMYE3MyvLCY4sSRWQR+GDmdKOklRFyzs2Z8XrPOvEKn0CPb7zU6GxgZR3E9P?=
 =?us-ascii?Q?nGPT3Fj4zy29ikA/jh25fMkZ3w1tfV8fA6Iy4NDqfjSmj1kYv4dafIJYOlLr?=
 =?us-ascii?Q?MZY0UvvHTwh8tflVYuwCtq+sZJ9yhd8YWJx5gsvFAmE5mi1WxURcvrMyvCoE?=
 =?us-ascii?Q?ytQTKB4T2M6acmYA6Z+ePNWYoqB7JYMdFl3fq2s/9JZbPPowaR51U/hyz5u6?=
 =?us-ascii?Q?Sysz9zZEuwxOZVqXaFt58nFcIChayVX9SuUxEwUwjcuGledU23ml3shkyNVd?=
 =?us-ascii?Q?xVcZ/271Cpd9yFFt3xosmpETVXtiHlFGPdS7JSX8LJY9C75MvmulMtc9Z33+?=
 =?us-ascii?Q?Gk1bjm5PbP+I8+d6IAPkjMlHlMS+c1WNDyJK7m51gurZdfjICmd7UWLrf82Y?=
 =?us-ascii?Q?iIWEfWRv6Ckz3dxOeBNHF+lEmV1gM9oduFDoBjLZS9kQda8ST6J1a6A7RTIY?=
 =?us-ascii?Q?DAm7XhCvdwKpVW92CrEiR+cgKzkjlQ3umpWcFMzVJNzLiJGuWjr3x4HhibYC?=
 =?us-ascii?Q?7Mtl+bGPueVNFMlYdVNUaXWGXLlqBErXsYuvTyuvZZZ9VW3vK+AxhaqAGdDD?=
 =?us-ascii?Q?zcSK/Ix7Ns8vgn3oOtAq0IBNBih3IFGFd/GGpknM6zbERJjlPrTQgun4WDP/?=
 =?us-ascii?Q?qAHSCBznMY+rOZ7MFo0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 18:54:55.2731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67715ddc-4a7b-41cd-c796-08de158a51c3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4208

There will be a bit more things to free than smmu_domain itself. So keep a
simple inline function in the header to share aross files.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 5 +++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 4 ++--
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 5c0b38595d209..96a23ca633cb6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -954,6 +954,11 @@ extern struct mutex arm_smmu_asid_lock;
 
 struct arm_smmu_domain *arm_smmu_domain_alloc(void);
 
+static inline void arm_smmu_domain_free(struct arm_smmu_domain *smmu_domain)
+{
+	kfree(smmu_domain);
+}
+
 void arm_smmu_clear_cd(struct arm_smmu_master *master, ioasid_t ssid);
 struct arm_smmu_cd *arm_smmu_get_cd_ptr(struct arm_smmu_master *master,
 					u32 ssid);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 6097f1f540d87..fc601b494e0af 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -365,6 +365,6 @@ struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
 err_asid:
 	xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
 err_free:
-	kfree(smmu_domain);
+	arm_smmu_domain_free(smmu_domain);
 	return ERR_PTR(ret);
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 0312bb79f1247..00d43080efaa8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2492,7 +2492,7 @@ static void arm_smmu_domain_free_paging(struct iommu_domain *domain)
 			ida_free(&smmu->vmid_map, cfg->vmid);
 	}
 
-	kfree(smmu_domain);
+	arm_smmu_domain_free(smmu_domain);
 }
 
 static int arm_smmu_domain_finalise_s1(struct arm_smmu_device *smmu,
@@ -3353,7 +3353,7 @@ arm_smmu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 	return &smmu_domain->domain;
 
 err_free:
-	kfree(smmu_domain);
+	arm_smmu_domain_free(smmu_domain);
 	return ERR_PTR(ret);
 }
 
-- 
2.43.0

