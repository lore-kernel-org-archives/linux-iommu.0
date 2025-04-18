Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3F122D4C5
	for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 20:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745007850; cv=fail; b=lyBa9PXS4yAySM2bcVZLx2Vgrp7UTL4pLMMvPmLr2wmQhJj8jKV5ZnAdfOyV/JZl1MYJczaiK+LOUfOsHdnI5cZ1oGVyZ+w01hOx83MyQCp5t68AIsNAx3xVCZ2ncYUpN0kx4NLznGca5ip+OEqXA9oIrV5lpqC4EwYlp7EjX94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745007850; c=relaxed/simple;
	bh=infpXwaQKGUftxZPv7ZsUoT4M2LV9hRcETGPEcHWd1E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmVsPmIZnlCBsLNt5IZTKzLuQ8AWMMpF7oWfXe4KZNsdiWjIjB0hfXcY8MxmHq10pqLjmhRS4DKeA8KhGS1yp/+DU+zS8Q/K1Fm8JZmxGDz5nRDY3pHjnojwv3cxiu7jR7lZS0uJaG2GA8n27RWNm+3gdSgbArZFMjG3Td6aot8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fDyjG/1w; arc=fail smtp.client-ip=40.107.223.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fDyjG/1w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=irkHhLD8eBFSODFL4nyua+72X1V7Aud3mWnXchY/fPlmTkhbDF01D7Fy6TByz5Tr1H8Plp9cVCIsOIId0zLqjeVkjwgyAqTIOq6KwkrovT/EjbNXXrkzOmX/MYwMT19gX4iZFg4zv948oiJcmfBgLB13BIoJEyAmSdZImgnZHflKKGOw9/suBBBIGe4JCdXdCyDfWGEJfyTTx0dErvRM13KxS6hkNLt5nvKrl/3SJ7EGw+eLVYymPba5IUtnLxZbiO79OzdF0G8Kn+VK9JTPeS6agyVNIB+aanmCfLpjSaWBfjQD5WQzuR0rBPHPfIBsC5iSwqJMsgxQMTIA4Z/isA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRBxIA33n9JWs5UOQaSiqS5T+llSw6kv8LBKRQzKeqQ=;
 b=HH9s5adTz/jYzLYPeJnJ5uwYedcNJvDau7IUQ2A3A84oXE0DlEVQgMtmxO1Po08Hyw36UzKtHEUdJCiFcZBIW/XKfQddM8SKq6jiK3IzFSyo1nBLOHB4vRrzJIHmiYNufwqZZPJKIQuDK7FOLV4tFKlptOCJtd2onsvRkxYMjIebDKhG5PJEhsUdchJii8uv7DdsSXjxkmjIsm+sJtDjI4h1Qz5v7A5rjRCNe/GWtltVO/zXw4OTADm/sE+SRPmyBfa2AwD31Wx/CfBaZu27d6SsZl2QNofukNuVPSrfVfykp2b5O+UWtKcTEoNJ0ipVhmYWjJeSOd7zlQZ27Sagrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRBxIA33n9JWs5UOQaSiqS5T+llSw6kv8LBKRQzKeqQ=;
 b=fDyjG/1wEl/m3g9H+zllIsn7GbiWNY4qds9c4er2X0q2xsxcP2BmMBg8gG6hbq79EkcEQjnFQPyS5m3bIc5Qb1cIf0jFiWVGVAklrWFbe2M9CX9GYHu8R2NS8Fofz7u9vGW6qzRCD0YsO+1iCsnALOsnXe5WbVSy3d4eBwxsZlJVQCfswYvNJr6Klg6vl+hfItcizy00XqCJ2OftJvEIXTdKgeFJLVgjAQUbsFf9y2paY+Jv6Dm286+Diq0zaw+8XyVc1v3J4WkjZDE7VNIDK85F1UL8s3ztb7kYYO8n2BWNXC1fm+JeFzh0bODB5g/KPmtSntVGub9I1pKVehlgQw==
Received: from DS7P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::30) by
 IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.25; Fri, 18 Apr
 2025 20:24:04 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::cd) by DS7P222CA0002.outlook.office365.com
 (2603:10b6:8:2e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.22 via Frontend Transport; Fri,
 18 Apr 2025 20:24:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Fri, 18 Apr 2025 20:24:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 18 Apr
 2025 13:23:54 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 18 Apr
 2025 13:23:54 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 18 Apr 2025 13:23:53 -0700
Date: Fri, 18 Apr 2025 13:23:51 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian
	<kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>, Vinod Koul
	<vkoul@kernel.org>, Fenghua Yu <fenghuay@nvidia.com>, Zhangfei Gao
	<zhangfei.gao@linaro.org>, Zhou Wang <wangzhou1@hisilicon.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Jason Gunthorpe
	<jgg@nvidia.com>
Subject: Re: [PATCH v5 8/8] iommu: Remove iommu_dev_enable/disable_feature()
Message-ID: <aAK010Tb+1AYp8F1@Asurada-Nvidia>
References: <20250418080130.1844424-1-baolu.lu@linux.intel.com>
 <20250418080130.1844424-9-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250418080130.1844424-9-baolu.lu@linux.intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|IA1PR12MB9030:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a676c4d-d1ad-43d9-2216-08dd7eb6f662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PsKsGkxnDkPtYenyxg2ceH66Zts0VUN4PFhhYY6It602Ou4QL4rVSvmM/jtJ?=
 =?us-ascii?Q?YtgMxdJjD2Pomu15FRGgaKlFMfw54ItkNL8XNW1u0dnIPwLSo8CAG4VQthUf?=
 =?us-ascii?Q?Mh0SSoS7izWTx3KxqDo+0OPOxout5XO0ppdqXJL+T9WpM+poE/KZkm8QlMcK?=
 =?us-ascii?Q?rm2ojLwElt+Xlf3kF3wkdtGmPPlEUacH44Zp4kqeLNvfMp3HVLvUZBx5QkFo?=
 =?us-ascii?Q?DDVcBtHn5v36qvvMWWLSIzizXwi4m4+tJ/zA2cCDhRXkTJzVsTumxHE4Z0Am?=
 =?us-ascii?Q?YRol6GlZuvJDH8v3NqG7UBo9zZwvSZJknLh+r9MOSzwnDR8udwp25JLBUW8h?=
 =?us-ascii?Q?hz+GBj9JlKF2sxumIK/dvMgD/cSq0V3d6SH8X0fgb8uLqdcwTcPdEhQHmsKp?=
 =?us-ascii?Q?PuarY/wbyHJ1f6o5hSdYe0I6WBV1nsLnETNonM0DKvFacaf1IO4EWv/WFXDW?=
 =?us-ascii?Q?V9KKZeqQiaYwuJ2/FOqgp7pfXL+SZ8FvUPjBMV9NGBZ3CcRk0yo57cWUG7D3?=
 =?us-ascii?Q?WUsdNHhxbeTfgp/EZ9O1rrpyAg5BRF6yQCjt2/NFeKqQwIkuupxANcZepPr1?=
 =?us-ascii?Q?o9mjo09U2bWxOZo5w0YY0GApRqZeAiEV02YJOn4piNTftYlGfMzlwCY5r/wj?=
 =?us-ascii?Q?OYgcOxZMnJlH0WtJmmluk/rMDT//GtYdNgR4orxfsq/kM5m3SbM6n8bTV4nh?=
 =?us-ascii?Q?NkTIrEOM7gUkGubzSgqB0cK2fy0UdGy0mLHY33hopzenx/iYRCKbGXdVqMo5?=
 =?us-ascii?Q?H1tXfnAaUSijp61g3CHki8OddliFj4qEofZ74jcDyri0f2NZQ3266rcKjGK1?=
 =?us-ascii?Q?Vk9DlQfTbfkyPjSxXHkuRnnN6UMRxUi9I2FfChm5spTs0stg2W/5Pwp2SCL/?=
 =?us-ascii?Q?l6JSvGlPSyaA519YAmE1e+XEdgqZaHw/lKcrE92qXpTjcSL+nNyxUUBCjOtp?=
 =?us-ascii?Q?Rzk39eopVe2AWfMqoBOZM6//BfaHrgIDlJJ2entv2WjmSJRIrXw4xSHzHh1S?=
 =?us-ascii?Q?3Vs1O+pcKsToNl/nLx2Mm86G9LzqHaZ5iQYEHl/DuwnuukJfxbWWtykflF/H?=
 =?us-ascii?Q?t5SKL/xV9GxFk+jZKcAc8dj0lJ7/gWPqCRQG7uQZoep0s9ywNA5e7MYgCyjL?=
 =?us-ascii?Q?BajyLN51FahsXss5eMGXOTlNsQ5WpUa878rznXOo5x6P3fmp6bGa+UjDtn6S?=
 =?us-ascii?Q?zk+iSEO1np/BZi4zIgqzqH4SLaPg45i1ry74fy0GnSy4cp3gy035ShsyiTyX?=
 =?us-ascii?Q?ajwR2mUbla5yAw3TKyTH8hHRCoPzxWPI5cY3cJeMnfqn67jAEhq0CZoBT/q/?=
 =?us-ascii?Q?7UGB0M+HnWN9mP/DXwdiFFCHMJ28z2AQ+7h3700+ris4FC7mCRSkGT78QH/e?=
 =?us-ascii?Q?5+B/Ub93kXOqeFPQG3cN0s5e7gSpG3c0bqmtJCz2gLBsm0UJTBRswDBor91S?=
 =?us-ascii?Q?wMUDCF/ra1sI2GV0LhvY4U4a29tU0PQYeaHk/tBMuc25fASfE5N/PNaoZPuq?=
 =?us-ascii?Q?JWoTstg3BvfSFEWd7CTJSGTjLmPLH1/gkmqB?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 20:24:03.7846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a676c4d-d1ad-43d9-2216-08dd7eb6f662
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9030

On Fri, Apr 18, 2025 at 04:01:30PM +0800, Lu Baolu wrote:
> No external drivers use these interfaces anymore. Furthermore, no existing
> iommu drivers implement anything in the callbacks. Remove them to avoid
> dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

With the following:

> @@ -657,9 +647,6 @@ struct iommu_ops {
>  	bool (*is_attach_deferred)(struct device *dev);
>  
>  	/* Per device IOMMU features */
> -	int (*dev_enable_feat)(struct device *dev, enum iommu_dev_features f);
> -	int (*dev_disable_feat)(struct device *dev, enum iommu_dev_features f);

They should be dropped in the kdoc too.
