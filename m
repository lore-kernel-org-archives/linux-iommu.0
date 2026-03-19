Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012056.outbound.protection.outlook.com [52.101.43.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFB63290BD
	for <iommu@lists.linux.dev>; Thu, 19 Mar 2026 19:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773949972; cv=fail; b=LJL8jbVnCdKrquJSI8DGlAvIpwrc2EDmbA9Udefr1jQImroZvT7DNXgGI2tAYapCzWyz4I+AkAjJwSGalUT0LujqLsUG7unxQDJ996xKQZzGH4tKXgskbo4ZIpnQajQHW/ijb6NnQa2xBWTmb1gD5NEU06RZwdvwWDV6slV3c78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773949972; c=relaxed/simple;
	bh=Tu8u0voBfHezTPcb2aBgUzLCTZ5lbA+p/XHPqHbkfr4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=icw2l8wTiV/+wFITLBrje1l4O5rF6pjtGfS7BYIDg7oqZXkBffvpse/O61N4PUICth3QDp0RgbO4LMvph+cWe3xCeuYBSdZrxJ8BPMot6LB9cTPESsaBOO+Paf+ImkTv+V40xN5sVNRoQi7LWa8aRRVFEM+0ywODGJ+uUV20LOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FK5XBgLt; arc=fail smtp.client-ip=52.101.43.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FK5XBgLt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AThCc8RZX8/HXwfS/5zYtgTz95HKdIT52qol83RvPo5xS53qeqiWOnXa2kd3/BjLydn/t5VIFxsii5YPjNx1R3r919CH6hZQFaJ/VTZny4zUPoTfWhdkUErjAVgolqxYBOVgJ50lQfEETsFwy6qs8aMnkZ7CQmv+6OJLSj5p5hvFQCc2PmVt9UQfOpQm59f9Tu/NaCENUHC2Ab8arZ3IlacTK2ARIi9qrYxrTuT4m5bw0p1oLB5gv5WOQ6t1w/FE7O3xGAxyXu1BSKmrdZvcq5ecBx849m2qjbEsJNXc4x/5pKfNQU685A5f3bsNpbcv5q81sDIY0A/VfgyqF7cOwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+vIiVChDY7e5gsV2EOGPNahv2877hReatJu71vddm4=;
 b=aTxZBHWqdubdMrbTdvlqvYyxMNyimFZggtVDF6oJD8wz/jcfYmXiaQDg57PuZR48eS27Msxkpp0SNGpJhfVxW72Exl7Tg60xVIOMC5QP69HGKJzQCC/3F71ZrYU9Ktg8eTKGaHKHzfTLERwdrOdsJuaXmR/FN+QeV77f0ZURRj0ieYdMdWpJO42r/QcsL6X0DUotIEW41sqNQ+euDMx0m2JRtvvrr0XefsTfFflJ20ymSdcdVMrh06c/3KbvVFEu4mUR2MbR389JJxmHJkqlZTKG40/GNg5BouERVg+EQvoifQ96mk3A6GB/P5Y1OiDGw2G76mRtE3E2wv/9dOhy1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+vIiVChDY7e5gsV2EOGPNahv2877hReatJu71vddm4=;
 b=FK5XBgLtHM3OjtiEmQY3uhJgIlKpekkGt7wgCdbWhWxSYANm7Pt6qoTVCmFKBoILijZglWvCGIPhwhhghTj6WNqSfUE/JWKU4ex9cNrggVMfvu/LLxwbbU5Y+kKag0CYk5fraM4eVCuAL7uNOeveXNv+9rdrQXJbQ3LCYdd9+kCQrJJnv80MUvhA+/fx3v2LnkvuZ4dsFi+j13yfzW2LH6f2jWgcPj5OeRG1pajDKPzCtZsnJDRIQn/5MVo9bhlULAR4kL0m/I+2KZkM8p6+AOSzwTgm8kqw4ZCTR0CNLKECFYqo1IaNSRk7DLd2rsphMfJUrvfWMVE7dqRs+MXOEg==
Received: from BL1PR13CA0180.namprd13.prod.outlook.com (2603:10b6:208:2bd::35)
 by DM4PR12MB6207.namprd12.prod.outlook.com (2603:10b6:8:a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 19:52:33 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:2bd:cafe::56) by BL1PR13CA0180.outlook.office365.com
 (2603:10b6:208:2bd::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Thu,
 19 Mar 2026 19:52:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 19:52:33 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 12:52:13 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 12:52:12 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 19 Mar 2026 12:52:12 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <jgg@nvidia.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jpb@kernel.org>,
	<praan@google.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<jonathan.cameron@huawei.com>
Subject: [PATCH v4 08/10] iommu/arm-smmu-v3: Allocate INV_TYPE_S2_VMID_VSMMU in arm_vsmmu_init
Date: Thu, 19 Mar 2026 12:51:54 -0700
Message-ID: <05dd00dcb2f0d077f59bcbccac1820534ad7b5cf.1773949042.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773949042.git.nicolinc@nvidia.com>
References: <cover.1773949042.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|DM4PR12MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: 679fae10-0aa7-4ea5-ff04-08de85f11006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|56012099003|18002099003|22082099003|3613699012;
X-Microsoft-Antispam-Message-Info:
	NN+n3Om+2muJsQmm2Q8PWfgjs/CynUj5BP2300/FrBXdwZengLQ0g/9cm8BDOxM+ScVFmHd6lcDqvKG8spKrCEQbRb4i67RbqBptr8yUX+35zR68N9as5+twjKAKLxIbVv4ntbub4rhTTXLhWZ/aYXQEFBx7cGi9YD0TP/NEoF3uiBAmYR9uVnJCBdRsWsL1rj4MkRO9dGheKK5XH5JZ+cILTGflCCjfi7LJxWN2nmM5a7thUHCLiy1D/yW8tTi/l14F9L/rAJGXsP5N4zhUp0nxr/4G3BxG5ZTjgSmE8EBfVSkRmzwSvOg2u9zttKEL+mISsGQ/XLPsKz1dpP7FD+N97PouZSEcQXqSxamPrTuCELvbYtT6MBSsi84xyMB4Wit13jhus3r8sZZmN94izhlqYDgDQ5gi3BWunb9QTyqYZJ6BqK5HYuhEx4T+WBpwl9hHUzzkp23Iw1Oj6oqOCR/aWeoR1qXzvi415STlwXPwMhNPXbVPu+VS1WB6TD6tDk1zd5yrUfMMmPXk63oJzIjbzSuaHJ7LhNFRZRk1ZRlBfbRwhG8RcUr4xJ9aU8QQNNh3wxDuu1JoO7RRbZqvvAJKWHvb6s3Hs1aq+MoyFn4dpkN2/pqV6lM6isoGeRc2yfD7+35fW0qbY+BqACAGXFbvRQ+LQ6tedBatQCd87tqyjHFk5XpZZUTe8vIOKgulppN+EIqBPO5A8NpJf6zGNTp8WSmI9UMMU2dzEBuimjd1MAsshBwpYjHe3JYQ7R0hZ/CHGX2dsPkWOMoB9xsJuVjjBg32GrcaAajWBave960l5EhCWkogpM92nur4UpoZFza3uyD3DzAFq2h9QDrzMw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ov1hABvqai/7ZJQgiCUlna7W+udLKSg30S3W2aHasdR1mn9Kn0e7JWifc6XpFo+fVdBSEq9cTiLYDrMTRWqA/0tGeQbcFqIf6r8KZk43CwGTk6IFhmFLHUg1ZA2Tp2EcS8g1C2XT8mge0NCN0HBbJ96I3ViC91Dr0Mqtwl1y0NDcM9r5W7lB6RDkQ8YVoBDOKy3zN8tcW9uddWMt6HmQSEXkABDo4MgfQ9FdlXz6jq20LbfD7cqrrkr1Q/nIEASvsPSeXLATGdydktoe3z/xHY9BKIhhUPRVr9jYsI9ybup8/89JI4G8O3Mm4djCejYB0NJPTnmhwBvdZCZRpbdT9FaI6pjDRdAl2Wy2/HVc3WMcga88bW3vj40jrQtbjbHnNfzozgYvdIh5oGAJgs/dH4u/VCGiCwqTiWBNqhs8oO638huT4s8Kl/y+4l6jetjm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 19:52:33.3702
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 679fae10-0aa7-4ea5-ff04-08de85f11006
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6207

VMID owned by a vSMMU should be allocated in the viommu_init callback for
 - a straightforward lifecycle for a VMID used by a vSMMU
 - HW like tegra241-cmdqv needs to setup VINTF with the VMID

Allocate/free a VMID in arm_vsmmu_init/destroy(). This decouples the VMID
owned by vSMMU from the VMID living in the S2 parent domain (s2_cfg.vmid).

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  1 +
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 26 ++++++++++++++++---
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    |  1 +
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index c722df9b21982..2e5520fdca3c5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1213,6 +1213,7 @@ size_t arm_smmu_get_viommu_size(struct device *dev,
 int arm_vsmmu_init(struct iommufd_viommu *viommu,
 		   struct iommu_domain *parent_domain,
 		   const struct iommu_user_data *user_data);
+void arm_vsmmu_destroy(struct iommufd_viommu *viommu);
 int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
 				    struct arm_smmu_nested_domain *nested_domain);
 void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index a77c60321203c..d17f8cb423b0c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -406,7 +406,19 @@ int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
 	return ret;
 }
 
+void arm_vsmmu_destroy(struct iommufd_viommu *viommu)
+{
+	struct arm_vsmmu *vsmmu = container_of(viommu, struct arm_vsmmu, core);
+
+	/*
+	 * arm_smmu_iotlb_tag_free() must have flushed the IOTLB with the VMID,
+	 * but it did not free the VMID to align its lifecycle with the vSMMU.
+	 */
+	ida_free(&vsmmu->smmu->vmid_map, vsmmu->vmid);
+}
+
 static const struct iommufd_viommu_ops arm_vsmmu_ops = {
+	.destroy = arm_vsmmu_destroy,
 	.alloc_domain_nested = arm_vsmmu_alloc_domain_nested,
 	.cache_invalidate = arm_vsmmu_cache_invalidate,
 };
@@ -456,21 +468,29 @@ int arm_vsmmu_init(struct iommufd_viommu *viommu,
 	struct arm_smmu_device *smmu =
 		container_of(viommu->iommu_dev, struct arm_smmu_device, iommu);
 	struct arm_smmu_domain *s2_parent = to_smmu_domain(parent_domain);
+	int id, ret;
 
 	if (s2_parent->smmu != smmu)
 		return -EINVAL;
 
+	id = ida_alloc_range(&smmu->vmid_map, 1, (1 << smmu->vmid_bits) - 1,
+			     GFP_KERNEL);
+	if (id < 0)
+		return id;
+
+	vsmmu->vmid = id;
 	vsmmu->smmu = smmu;
 	vsmmu->s2_parent = s2_parent;
-	/* FIXME Move VMID allocation from the S2 domain allocation to here */
-	vsmmu->vmid = s2_parent->s2_cfg.vmid;
 
 	if (viommu->type == IOMMU_VIOMMU_TYPE_ARM_SMMUV3) {
 		viommu->ops = &arm_vsmmu_ops;
 		return 0;
 	}
 
-	return smmu->impl_ops->vsmmu_init(vsmmu, user_data);
+	ret = smmu->impl_ops->vsmmu_init(vsmmu, user_data);
+	if (ret)
+		ida_free(&smmu->vmid_map, vsmmu->vmid);
+	return ret;
 }
 
 int arm_vmaster_report_event(struct arm_smmu_vmaster *vmaster, u64 *evt)
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 6fe5563eaf9eb..92845fabd0dec 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -1152,6 +1152,7 @@ static void tegra241_cmdqv_destroy_vintf_user(struct iommufd_viommu *viommu)
 		iommufd_viommu_destroy_mmap(&vintf->vsmmu.core,
 					    vintf->mmap_offset);
 	tegra241_cmdqv_remove_vintf(vintf->cmdqv, vintf->idx);
+	arm_vsmmu_destroy(viommu);
 }
 
 static void tegra241_vintf_destroy_vsid(struct iommufd_vdevice *vdev)
-- 
2.43.0

