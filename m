Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012062.outbound.protection.outlook.com [40.93.195.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63655212F89
	for <iommu@lists.linux.dev>; Sat,  8 Nov 2025 08:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762589307; cv=fail; b=QdkY27INL+9E5xlwIajhdkqll+SwzsAmyF55q3dRbabBSTeGyeCut3PW4f1mAiMQK2i1F4KnWheJD/3KANvVWWXHmkm8mBBBUzGPT4dJTMRfYCHyptyGrApyauYbYN5SppaI3ytkCpP5pX2TaI2nlFxqm/mR9mhHzJ0dnSk/X/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762589307; c=relaxed/simple;
	bh=KZIZIWn1zQChJgTIOl+S6E7L57MRaogqPgwFyGpOb6k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f4k+Txi6oOciUCaHBdHg41KPidSuH5zSHRkyrPVpADJxCBTiG+Bf+mxj82+Llry7if30wZuW6bxQYL17vgWetOT/pwFflF8b+XzR0FUCKYdDz+YsJJh2LHxDLZdNTqG6oPBBPhYok/GNbNzXtwnINbzGHOYTKDTOH7SS6nOGHIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FO3nMoFQ; arc=fail smtp.client-ip=40.93.195.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FO3nMoFQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKEsmggk0DcnkaCN2p9VIh0SDjc49HS9pNnQBjN5uXfzze1Uk7QD9qQfCEiV5eIv69PCsU+SMdXq8iUMevjlqo9WaX9Me9THnx+gh25onCTtUFnhxTSBzPdSA8FfjrbiLVIWR0xd1VN74WMun00rlU6EQrtoJWcG1k+iwh1UaAJZ/tQmjKEJ9f7CiEBy9LuJ+rxj1EW4AKfW+5uXKF5lOjlb6fCEQPV+XrUtHbFDVKTeTEkI9VOPIkEyERiBHEZB9M9P/dMLC66T5BHLAovv4QCh/5icPWRVoHOSQ9U8HDBZuvdru0DhU3buENFKPeUPWtrwsYLmW/M332yqnKRqPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BTa8QmYcLNHh7ScbSBZc6eV9icoFmX+5SNT1U2iCBc=;
 b=V7EWVC8Q1jvJJUrEM1701qAwqkM0y+an0q4oPmfYU+f1Tx/IDXLWv0CzzsDa45FbegSByEZYjO0AO0juiVpyO7cYbDAooVybTUk4YPMpXU1JDcO3bwLJAEy7ciEOifvhYIegbmYiRMFfzepaWx5vWp8lWdJRVTPFbG8GJU3PxUU1nnO4CdYoVnA5uCCTInMfMLADL/4k98OjCff0/IkjBnoKlAcwJdUhx2kjlYriszwv4XET7MRMTanmPIBl6dTvZnA1ERF8e4A74NF62m2ylXh9Wae7/Vhclirzi/h5fUoGFNSdTtXKk5DkeiD+I91vVPhabN0ll8oX7QKC+o+8Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BTa8QmYcLNHh7ScbSBZc6eV9icoFmX+5SNT1U2iCBc=;
 b=FO3nMoFQsKGXeFGf29J1OdKBAHSiO7BTe7ywN+BnF3ISTiTPE3kjGlxnwut/QMzZCPZQ1RdgfUFmy8l5XLAIqm2EhUXK0cE04bDpfyBRHw95Xu58WWdmbGENVCGQbywUx+gcuO/3J+o7v+xM3cRkv5HjMdyrKM/msHcjk+ibrVq3u6u7+7H3ug279s3gbGpir+YUj3IKxRd19JnKRqmqg33cwy9n36L6jKGnN4CTFVeOq1JoqNlexg8xLlmC/h1DENxRXQNYtrwq2vqHO/s2GKLGJAn0+uxk38gJXk6jXp16pnEY3L4MRAHqmW5fVb1XSEJANFkBnC6mXeVcsfGpGg==
Received: from SJ0PR03CA0297.namprd03.prod.outlook.com (2603:10b6:a03:39e::32)
 by DM4PR12MB8499.namprd12.prod.outlook.com (2603:10b6:8:181::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Sat, 8 Nov
 2025 08:08:22 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::fb) by SJ0PR03CA0297.outlook.office365.com
 (2603:10b6:a03:39e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.14 via Frontend Transport; Sat,
 8 Nov 2025 08:08:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Sat, 8 Nov 2025 08:08:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 8 Nov
 2025 00:08:19 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 8 Nov
 2025 00:08:19 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sat, 8 Nov 2025 00:08:18 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v5 2/7] iommu/arm-smmu-v3: Add an inline arm_smmu_domain_free()
Date: Sat, 8 Nov 2025 00:08:03 -0800
Message-ID: <a59f02438362cac212d3ea5f3bfdc3aec27f74ca.1762588839.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762588839.git.nicolinc@nvidia.com>
References: <cover.1762588839.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|DM4PR12MB8499:EE_
X-MS-Office365-Filtering-Correlation-Id: c3d8357a-0bad-4a7f-ee79-08de1e9dfc1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+3qLre1b/t2id0ZBLRpqcGudmqDIPBioCFBR8WizKe+PKKzUhcxZkoQIejyN?=
 =?us-ascii?Q?W8IXtdnuGgOI9ciZZ5FxcLS9haO6BU7gHC91E41wZyZA7nm8rcKTZeLZsjpF?=
 =?us-ascii?Q?EYvaG2XGdqYZd8VISu0tjYOksyw0Dg2LLvZz/vD0nEoY8Y/D19CBikk1GIxQ?=
 =?us-ascii?Q?xFSDCgthYjnHthu2FxYwChGEJrm3U4k+Omp66HK/ETVIwpb4Ay6o4DXoFWX6?=
 =?us-ascii?Q?ZtmojylT6+tb0RBLo2EWyWg+ye2JqMS6Q7NAdRynkZH5L4CbC96Hwvq3pExK?=
 =?us-ascii?Q?/c1LZ8ef+KLAWedexOVGmfrA9c6u7+3vkR0LfBRXni+cXJ20t20wdCzwILv8?=
 =?us-ascii?Q?XceIm/fPgAJ6sTvPWPN4dqGDOKjw1pkava8Fvz4YXFirwstkxbhlihl33lNt?=
 =?us-ascii?Q?cZoSJ+W+HJOlEmPPcNy0dsR0ar6Jp/GSaisz5XWRh9xoHc3+F+OhYKIS4Q2o?=
 =?us-ascii?Q?RPuySbQ3SDeOi8Rc1uZ5bmlK10VJgqQca6+tx9BoFg+cvuExdcurgSWj5rjA?=
 =?us-ascii?Q?e87JrkWjlh/CAOamY7t15hdKmblVDWqtnx9o/P3hApS+ASipDAi+45E3Y+Jw?=
 =?us-ascii?Q?/B0THnJsR021E0tbTPIDM7sGNxj9F4DPXjuqmGsGm6jz5yLJUjYTHwr3CtPd?=
 =?us-ascii?Q?Ej7VQwboovBqFSFY30uyz9KUll27doopyKa7cFvLGcB2HKtK51OLS5efaUn5?=
 =?us-ascii?Q?wj6+/GfAa2QeoQYMrJG2qYjl8R2cmA6EshifaNc06sLW0r7/6MJInFr4ohNo?=
 =?us-ascii?Q?c8nVhCVuqI3tbJ4GvOkwXB18cYy9IQHo2IbzbXMLgNStRj2Wvn3qzdMR3UoJ?=
 =?us-ascii?Q?B+zR7TYzxDxjqkVy0umcJWHeySvhU7/a+81Ty9csIKbjKi8tBiHl87F+wYyC?=
 =?us-ascii?Q?uRib9PRwykID+221ubrCJA2Qvru3+/IZJk1QIyy6ScLJbwOLf/82wIsMK9Hd?=
 =?us-ascii?Q?fLAQG/YfAfYvKj9wWveVVYUw7q8WwkgDSSzaKCIJX6Xj+jV3MIy9Lliejuh9?=
 =?us-ascii?Q?yZf+03xFbjzvGmm8Q4JiGNATHCW45IMGIcElitz3pWqfYKiqE9fseWi5cHwl?=
 =?us-ascii?Q?2rgQtAd5pruoTootMwgkpkIUwsiIHE6l01IQllcNjh8zfpLHGQAKfBGau/qi?=
 =?us-ascii?Q?w6DTacvGdjA5lpt/dOsxlM+1kVwLLBZuAU1eWxK9FGgtciIf14ElxbNX/wQ8?=
 =?us-ascii?Q?vmOz52Iat/j7efB1CHbhaLK9M2BPWFGOcQ4Mbfl0SLOHa0EWDARKA0v1+V5Q?=
 =?us-ascii?Q?PDzU2JlAvwICPIbqpTu4ypxUsShH/oCFJC4Uo853FBRzkB6fYbfE0HoRD/wM?=
 =?us-ascii?Q?o+m7QMBlFpptIhYXmFutqY7Sd26NJXiR2CrjBq5/OUV2YXLXt6SIr3bkuF7Z?=
 =?us-ascii?Q?R2o+D+7+XYV2sx/gcPZo6WHy3aKStvqVIEh+S4mbtUMhxhqtNlipEBkc+hdR?=
 =?us-ascii?Q?eJSSBK7hOMH9/gI6T0nggtYRmY7WDdWXoCrxIAgR5Ka75+a2t3Lzuha2HTBO?=
 =?us-ascii?Q?dUr+J5PrX/MmT+IupI0C6ItH8ZjsIXYAwPIkv3lf6AYOdclGERrM2mcbT07N?=
 =?us-ascii?Q?swijV0ttC2GbBrOGY5I=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 08:08:22.1088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d8357a-0bad-4a7f-ee79-08de1e9dfc1a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8499

There will be a bit more things to free than smmu_domain itself. So keep a
simple inline function in the header to share aross files.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Balbir Singh <balbirs@nvidia.com>
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

