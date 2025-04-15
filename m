Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973A127584D
	for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 04:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744693128; cv=fail; b=K3wylLorRSi8O4hVS0Fhb2/URmmZovqHC9HKWacttrMwOPHpgwCiNhC06kuyORFqfV/fToYmfZiiReu6eG+BYC4wrrEhVr7lfYXSKAoS11BYT7mdgQWielSN3hPGou8H9WTmiTKLSMb5qzxEdFtLuyho7gy7WDlV4VvYZZPnIQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744693128; c=relaxed/simple;
	bh=WzdpOKk4H9pwmJDbtNidlsmOeMriX6jVjvURIew8O60=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mt5gmW8OTDWxQrLF2Y3KwgeX7CCdjUqCxoPcbMI43dFXSe2lrZvt1hf68tRkWcXHvKGkeFZ7Ad2/IgHnuvanjY7iM+c6Cr+xwEVGbtzcMfTET5lP4YuHSs6jEmuHIp1Z20O/j2mthKoCtwNkgxpNIiZLy7Hy3ZbyMUX4IGajbxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sa1tXXKM; arc=fail smtp.client-ip=40.107.100.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sa1tXXKM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9/Y5i7PvBkwkb13f4rszRPwY+ffud2NFIBvnlDhn5LUg0cog+wov1sZtK9lYxb8Hxu/LaqORSJj7RT6QJWUOkFHAkE95zPczYpp56xr29FlDe1ic9ydSmhOsBhZPzKi53SmrJkgrHOXzhYAIXxs2mVWonOc60VjcJQtVSSZFbR3aT81ohJlYkVauBpmkolKTS40jfOGYBNYga8A10foKIfPDC/RPGhsxUi0p9vIHqoXlqJ1aX4jx2xwPZJEeDZQLa9BnL87ZJg7el54I1RErmoT/QvhUjEwB4BITBKn9UWiUxOYTMQ2YHZ32e+PSHA45QgTwoq9z0j/CpzqaJ7Vkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPg8r9+qxP3FUQR7JGslU2hw0AcMpptvhuQODcbrUBo=;
 b=qFE4+KQ2XXAcGOMVL03uTNwcVReQ413PVDoyKJDkPvIQGhLieSLTYqttNhJPG3TRFFyl9LL7v/1nKufN9t4T6GuOvpRRGq78CMDUONsSgj1KtmzRTXpbsI4jZOOxuzTdkgmK11AE7gWNNMrfjnkgjI2vBL805nbxwqMPXaxLvRyOuz63HLy0373Sb5XuPXBCAH7l3QXSz0SvguES1SD+Zqjv4nOY/VYIP1VLcEIvO2bhc6UWs4jmRl+I9bsSf/9tOEA1arN8AwY3dDyWVFI9cqs7BClvaeipvRDACxL4D52TSuwjQ5+bNGlMk6obDbFrQpU1ynsrmm0jq2c46+Xy8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPg8r9+qxP3FUQR7JGslU2hw0AcMpptvhuQODcbrUBo=;
 b=Sa1tXXKMyqI48eFANd1PhAgvIhqehlRLDEPgw897nmEYeF6rlwAB8tpbFN5Or6BSWiUDMVHpuf61KI0qP9J+UvOlhWF/R6rOlukGVcBW7gA9ZR38/ZAL0cNb5NLiWzLIk5fvKKwkyWz0YHwnvmLFE4qx+Fv8Cr+ctv8NmfWECXsYJPWsqr/Nr49aSjizECFulaLTifeBUIcidqGx2BFUP7aJmrbnsZ49ALq3cGNRZZ7s+fcj7sO3cGgP0r/dmJ4M49ywZjULh8yMw93Nq5GxX11a510RCIsanOk4RSC/eD/CEpOtO7a0qid2fudNhzHLynU+RYoW2yCHYvPnQ1ujOg==
Received: from BL0PR02CA0076.namprd02.prod.outlook.com (2603:10b6:208:51::17)
 by PH8PR12MB6844.namprd12.prod.outlook.com (2603:10b6:510:1cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 04:58:39 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2603:10b6:208:51:cafe::e9) by BL0PR02CA0076.outlook.office365.com
 (2603:10b6:208:51::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Tue,
 15 Apr 2025 04:58:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 04:58:39 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Apr
 2025 21:58:23 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 14 Apr
 2025 21:58:23 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 14 Apr 2025 21:58:22 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<nathan@kernel.org>, <yi.l.liu@intel.com>, <peterz@infradead.org>,
	<mshavit@google.com>, <jsnitsel@redhat.com>, <smostafa@google.com>,
	<jeff.johnson@oss.qualcomm.com>, <zhangzekun11@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 11/11] iommu/arm-smmu-v3: Allow to share S2 nest_parent domain across vSMMUs
Date: Mon, 14 Apr 2025 21:57:46 -0700
Message-ID: <e6a808167d61bc254aea397cbe75622e02e9d703.1744692494.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744692494.git.nicolinc@nvidia.com>
References: <cover.1744692494.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|PH8PR12MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e74d588-f5c6-4b84-e04d-08dd7bda302d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Feaa/PIdfZS7IN2u+8jdzgbMB9CLJef1g+Jv48viimOzb1pXetgTyKELurvL?=
 =?us-ascii?Q?RsxJty1LuByEKRo2P2iAzB4I8sYWamCPo0ClYex9Nd+pjsInFtsXUN/wWyfy?=
 =?us-ascii?Q?OzwTn5fD/t2GEKK7XHVetN6w8VrQhJNYnQgD4Q4grvNPOJyYEuYwAJsmEqDp?=
 =?us-ascii?Q?QUhqsiM2x4KXGk4tZn6/bC4HjrfhYiIZA30qgHXRKEdhZ9FJ3M5BKrTrnPlU?=
 =?us-ascii?Q?O7KZFI86zGW6rzC2Vp0VXYlOm94vgOLGmWGsabce4aryRfAlFmvkoQW/jeap?=
 =?us-ascii?Q?uISb8VWmT9F5lbZywz9vaV3A+DskcXfVZwqoqSsRv+r+4jNmRXwxbDQyh53T?=
 =?us-ascii?Q?M5phJZ7eRZ6DVc0jNUpObaZfa8wRMJKgwpMkbn3NZGv/GPxD9fHcOCiEc+x4?=
 =?us-ascii?Q?3FEm8WhYfwv/KoZTqZZlVI/GSnNiFNUONdrCEeiRWpx4JBmnB7m9lD4W47ma?=
 =?us-ascii?Q?sjjbSvYS2xIAgDH0byUdmJBHfpulwfSkCSedzpZMg7h0XrfCahfb5DvcZ6Re?=
 =?us-ascii?Q?z+ZZLzY6b2itsfqrtb41Gnbu6P2Wx1TFRc8D4RFUa3yb6smp49V5ozmkYZM4?=
 =?us-ascii?Q?QFsWqBgua98AXvMKSFPTDdMNM4I5SdrTwamu3u9SL4XnA70qQJ2LNyD7yVrb?=
 =?us-ascii?Q?l7QAV6i2w+GYz7d2Hv++/6v2SJ3e9BtGznkg8nGacZkouKDLiK3zXvEZWiIq?=
 =?us-ascii?Q?bL2EaeAyl0zDHBxQZ9+xxBYg/SVG7jxxzbh0ILsFn6LkdyD/TFTEcgD+YcWW?=
 =?us-ascii?Q?dxqr5MtFO06S3mGMaQx3TOsdnMBhuorGTwN+z5hGA+bh+j08/vRUX971MNYu?=
 =?us-ascii?Q?BtPK/Ip/TSZJPwHdIKyvc9KleqRnnyjfT2jY1P7i4dnqXtlZ+1kh2Fp3a1xB?=
 =?us-ascii?Q?0OPGGHxb3GT/hyBwTeQMqiTCL8li0XKWA+lwPIN4ZayqaKwH1qSeUdVIubrf?=
 =?us-ascii?Q?Wrdee1H5d3m8LpYFzVPqvufuH78vr7yX5GATffHVTlGuWALc9RjLrXlwPd/3?=
 =?us-ascii?Q?KdKtHCHKov+wU6/mk6yLt/8Ndd+l9tepWxa9nPL6SCZix2EY6KM1dN1lSZo5?=
 =?us-ascii?Q?Yx/xKKT1SF3+kql5tvzSlcZginL19drxucBRf8Qcy/Jt+Q16++ov/i8UgsAf?=
 =?us-ascii?Q?REWx23hXw9KFTqF9Uq6hZD1A3dpqe3k60RaWhWvkZB4M2eEkJ4j61X5cyZpN?=
 =?us-ascii?Q?uNxyCr2mRyExCPgy/ohtI3599IvcmHU25XgxzEXdJuaxcs3h2S7FhVrqlPX8?=
 =?us-ascii?Q?vHBej67TJWOLeEZg3Omku+boNkQFHfoyETjBOP1k+U37qekUoJI2KVHCfpGW?=
 =?us-ascii?Q?XF/QuuZfxWeThU2+a4TPjKL3cvcwDtkDfAfLi3Sp6HoxUihaJZCIiwk7CtJC?=
 =?us-ascii?Q?gNazix7LkdhxqIG0AfE8R8JngVXHC7etd4Z/iMdPD9lmPTzF4HAdH8+IBw5h?=
 =?us-ascii?Q?4C5eO/JADJq0OOJUGw3KAl1ocvSq2LG0ppia3K05kXy+ZV9ChyFDHs/4DwLU?=
 =?us-ascii?Q?Afb5itbq4ghgiWnrWe+2uaP7zBStPwQ+Q+ej?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 04:58:39.6003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e74d588-f5c6-4b84-e04d-08dd7bda302d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6844

An S2 nest_parent domain used by one vSMMU can be shared with another vSMMU
so long as the underlying stage-2 page table is compatible by the physical
SMMU instance.

There is no direct information about the page table from the master device,
but a comparison can be done between the physical SMMU that the nest_parent
domain was allocated for and the physical SMMU that the device is behind.

Replace the smmu test in arm_vsmmu_alloc() with a compatibility test, which
goes through the physical SMMU parameters that were used to decide the page
table formats.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 21 ++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 5d05f8a78215..f654e665739a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -501,6 +501,25 @@ static const struct iommufd_viommu_ops arm_vsmmu_ops = {
 	.cache_invalidate = arm_vsmmu_cache_invalidate,
 };
 
+static bool arm_smmu_s2_parent_can_share(struct arm_smmu_domain *s2_parent,
+					 struct arm_smmu_device *smmu)
+{
+	struct arm_smmu_device *s2_smmu = s2_parent->smmu;
+
+	if (s2_smmu == smmu)
+		return true;
+	if (s2_smmu->iommu.ops != smmu->iommu.ops)
+		return false;
+	if (s2_smmu->ias > smmu->ias || s2_smmu->oas > smmu->oas)
+		return false;
+	if (s2_smmu->pgsize_bitmap != smmu->pgsize_bitmap)
+		return false;
+	if ((s2_smmu->features & ARM_SMMU_FEAT_COHERENCY) !=
+	    (smmu->features & ARM_SMMU_FEAT_COHERENCY))
+		return false;
+	return true;
+}
+
 struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 				       struct iommu_domain *parent,
 				       struct iommufd_ctx *ictx,
@@ -520,7 +539,7 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 	if (!(smmu->features & ARM_SMMU_FEAT_NESTING))
 		return ERR_PTR(-EOPNOTSUPP);
 
-	if (s2_parent->smmu != master->smmu)
+	if (!arm_smmu_s2_parent_can_share(s2_parent, master->smmu))
 		return ERR_PTR(-EINVAL);
 
 	/*
-- 
2.43.0

