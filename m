Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010064.outbound.protection.outlook.com [52.101.46.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBC2305948
	for <iommu@lists.linux.dev>; Wed, 15 Oct 2025 19:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760557406; cv=fail; b=LjJfJnLU3utqVI5BgdtXBeE/Zy7xHyHsFgyg8x30hAp/8iP0xvr///ONeTqXq7N2QqA3oCdWNFIWHrWLX/dSiBUcV1N5AGE4+7hcE4ZUDFchU6lL21IiWVf+WkYoRJl5WOiVQFCwbt1nQD92kv7/91++4KR8eHJvdnTWnTIF+SQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760557406; c=relaxed/simple;
	bh=xgzFpVrLkzYdxQafr/ZsDBol0x3vUnokHIREs/O0aLE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fI9lf3//q3EBXGL2YvARPRKe5Hq297JJAUsGiUirJvTk1F2jqCb2DbWdEXUVtGwo4LQI9fxEOCTE4+W7ExIHR/46FMzU3Xui6UiMARmzKtKyLOzb+N9xG4PHu/FdfKZayCh7N7+VsLBBBqCC4ViU7CWaVfOPoha+n8aMNtD1nhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e6KzIyk/; arc=fail smtp.client-ip=52.101.46.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e6KzIyk/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oRybnZhTSY8VidBkBk8tLXtVQXw1TtJm8GAFuKFgEcYbqsSAkux+tbyHjzMV1u4QJ6ScLrFkwJUraTbApq05XdSZvBz0tmDjkeq5OV8W3YJR9Cs5MJv22XQrNA3rRaXNmbc44TSvF8lbxCBW6HKKsdoOcmBVAxwdGOPP+nhAGq0vgHR9yJ4P0IJIdUyGnMSxDUkTYAMm9SFU1UlixVTw1IsP05kAAXv8DXP19dZGcLEUivi996RwlxEVmdUElymF2oePXbzSkx5Q4rGLAvj197q3X3YnepgCe8DEsXBwew6vEQsowAHDCsLfrdGDvOjCossLsafobnn91avS1SRFxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyp2uxdJSaWI/GLKYnSpX8UVcm+Vvxd+5Dyzn0Jm0eA=;
 b=hxkHDQJTTJUJBir4ILcLdtRGo8uueZ1RNfqGE74deSLuaXnULgTP1M//eIJqPFjRs3UVY4Isidqr64KhBQfVFv5Y4WlPx8Hogcxv5YXOaHf/7cQEjL2uYofzbEgrd9W2a//mheBAZJyGnQEg2RZKABO4SjWqe9bKZ2UjpCgMMOdPmq6U/D0HWieRgZZGAQ3ETKFGYUXXhxaU7X0QG2SsbXNNbsNIi27bBX9Guh1Ag+E/WPwnQ9rwLL651dqn99WLgI1c2cv8/sRMZpZcxeykxNN7eWfmzWPLmmRehKCyOBZU5xCou5MfhMSHfr4wbWqxxHbPlZehE1DVoRjrWfpd9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyp2uxdJSaWI/GLKYnSpX8UVcm+Vvxd+5Dyzn0Jm0eA=;
 b=e6KzIyk/hm3L7UvR/xtOiQjU4cpWaSx+zAr6iOq3TTK7MEyNv92LT+wn4FgGDHjGccR4bhKhhkwFnLdVpoRFsqDxeda149Kcv92fP+nf0xurfX1I5az1bxRd/UbMy0YpnC1rV+NdobECLuhOWAIzJnBPO9VpHW3xTygcJ/nDVht+AjVFBqUCHdkMCFLJ9leochJuHqKcc/VovL9CmJjFIVSgYnvvQPEuJORKuJfsEIgPnTPKSlLjJVaeYWDCXzcxMwaP4KdtxERm2G5IZFGfuu9XC90zxKlucUuMKzpb/OykEu+RAo30QJBBHrzWbtjFzdsUuE5a1ndc0yQMBf3hsw==
Received: from SJ0PR13CA0018.namprd13.prod.outlook.com (2603:10b6:a03:2c0::23)
 by PH0PR12MB7093.namprd12.prod.outlook.com (2603:10b6:510:21d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 19:43:19 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::f8) by SJ0PR13CA0018.outlook.office365.com
 (2603:10b6:a03:2c0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.9 via Frontend Transport; Wed,
 15 Oct 2025 19:43:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Wed, 15 Oct 2025 19:43:18 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 15 Oct
 2025 12:43:02 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Oct
 2025 12:43:02 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Oct 2025 12:43:01 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <jgg@nvidia.com>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<balbirs@nvidia.com>, <miko.lenczewski@arm.com>, <peterz@infradead.org>,
	<kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/7] iommu/arm-smmu-v3: Explicitly set smmu_domain->stage for SVA
Date: Wed, 15 Oct 2025 12:42:46 -0700
Message-ID: <b543555be99dc6afa4a9dd61c211f42862b46ac2.1760555863.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1760555863.git.nicolinc@nvidia.com>
References: <cover.1760555863.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|PH0PR12MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: a3422b21-ed98-469f-5aeb-08de0c231756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4gxgW6eAduGuNITHPjpXnOnSXYnUPQuqxo+IeFDr0c6szpTW/21rSN2iQfvM?=
 =?us-ascii?Q?NzI9Me5HS/pdyXqHj8WarEz5HssUquGP9TOS8yhfaUomJe+3ndVZulkWYOCe?=
 =?us-ascii?Q?jlXyiSLUwYHXzlsP2Vnq4CeMj+nfy4b5hjlHn5Bn479YHvhBgcYCZKhdSRV6?=
 =?us-ascii?Q?Ep1XO37KWgOjtKo/FbFs2MBuIfony8ZUTpW9b/cv3cU7OP+d6C2X8m+eLFDS?=
 =?us-ascii?Q?UrR6UHvyfoT8DNbRR7YTeN4ci3MPmF+v6zuz5KHJwEULNFCCJ4O9sJEppNz2?=
 =?us-ascii?Q?9mVwk4ou0oRr5z+kPXy1yW4M7Dk+lVjjyMdx4Y8XgKuQYTv6bLfnVNOu78MZ?=
 =?us-ascii?Q?CmXF11NNfSxMJPilWbvW2IuCdEnx2B/Xr5/0ZjhI85wACQeZyE0q6GDLlTnM?=
 =?us-ascii?Q?4Kl/eCeXDk41xAX+lI8sDXyOnnAGjh9cSMnDhLoOrTzRmSnDqjQtF5JJB8Ha?=
 =?us-ascii?Q?c0qlznx+mQzJn9hKIj/z5CTnju/jrmJ1rxMXmbmT+3uZNO6hQ0VXrM4I9ee+?=
 =?us-ascii?Q?0tFCXxkx+TE1tQCTusVc6mDcD/sXlMxLG8qRxg8MuuoEIn4UXrMPiKFC+Ytc?=
 =?us-ascii?Q?yVhbbePe9vZjawbamL/gaKwkW3RQyX+/UoHlFItDAHterMr1N8aqPuG0zIxW?=
 =?us-ascii?Q?zIqA+hdb+xgz+CD0tijLXJmU/UcX1agSGSXW4KLiSTfvqZRTjRNe1JdnV13v?=
 =?us-ascii?Q?aR4yfJpXbUBR2+qlxTo+5EKNcMAi9pTrVISWe1VJN13RliVEewGB9D514/Sq?=
 =?us-ascii?Q?6Gs08IBy74izoTQ+n+WIxGlbMUUt+RzuUd/IzHt6NoqwgI3bjXRw0XgWEjIR?=
 =?us-ascii?Q?cgo70IriExC7SgdALczYSc+P9SCveSiUPyYarGi73RGlhRqq5YLpIizBl9X+?=
 =?us-ascii?Q?3xnfIscjog5u8i7gtjo1SDP0Srz8TlI7wZ/ZGSNsK/5UVDHORsx29qCR4bUQ?=
 =?us-ascii?Q?lktQk4K85qJMuEqtsfnNd+buL4hBoGGQ24HoNAsccGChEx0wqz4SwGlULpEI?=
 =?us-ascii?Q?yMgoUdnjzX2eGTK6se7rc8o8/MgXc1ONDgkhGZgbVPHo5e84T8J6fEfEC93r?=
 =?us-ascii?Q?BePgrFqFl1Vj7ZitG453xRVFX51Jwo8XkIMuwoTWKRVLwTllr35fyX1bLjjo?=
 =?us-ascii?Q?VpeDS+D/GVBuKaOz+ffIxUuDBMGIgxLyTeuLbeOi4aIVx7PskTtxaoYoPxIE?=
 =?us-ascii?Q?rqGb6Y1C2tJU2/rzTVHieXsj5YglrO74h/9idXC8G2jdrGXAEvFsV4Bp6045?=
 =?us-ascii?Q?9HPjcgLD1YfgQHbU6vwVP/Pe0u/dckoZLGFNAF3LcyTvFaClEgOqTQzuzThw?=
 =?us-ascii?Q?lnJ2w7qiD5UcbkqsHB0lbTmmsbNnBspG/oeaosmFlCFe3vkF6zbVCSFtQOWF?=
 =?us-ascii?Q?gJdJ4H6S6+bbbXuCyS5NU8fNPg9Vr/BcG3ZWB8ZzVhzDRvXjd2ehBD3TuxsU?=
 =?us-ascii?Q?l5NJQtMQaQSNnNwZoqHkRXBzKSysREwridMpFAL/fycTMGer8ds5G5oLC6eC?=
 =?us-ascii?Q?RHajVFp+IJstUV9OQqQcQMtBB8IsxfOVXzbu8pcXuYu8QpLoJypkG2kn7xpn?=
 =?us-ascii?Q?K0sFXNprzKxVmyo7/50=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 19:43:18.6613
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3422b21-ed98-469f-5aeb-08de0c231756
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7093

Both the ARM_SMMU_DOMAIN_S1 case and the SVA case use ASID, requiring ASID
based invalidation commands to flush the TLB.

Define an ARM_SMMU_DOMAIN_SVA to make the SVA case clear to share the same
path with the ARM_SMMU_DOMAIN_S1 case, which will be a part of the routine
to build a new per-domain invalidation array.

There is no function change.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Balbir Singh <balbirs@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index ae23aacc38402..5c0b38595d209 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -858,6 +858,7 @@ struct arm_smmu_master {
 enum arm_smmu_domain_stage {
 	ARM_SMMU_DOMAIN_S1 = 0,
 	ARM_SMMU_DOMAIN_S2,
+	ARM_SMMU_DOMAIN_SVA,
 };
 
 struct arm_smmu_domain {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 59a480974d80f..6097f1f540d87 100644
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
index 2a8b46b948f05..0312bb79f1247 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3064,6 +3064,9 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
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

