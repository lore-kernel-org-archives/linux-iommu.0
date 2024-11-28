Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DAE59B71
	for <iommu@lists.linux.dev>; Thu, 28 Nov 2024 04:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732766733; cv=fail; b=V/ej6kew5p/IsmMjECAY2pSRN0d/w7Mc+5kj38ZhtfF7cr1wqYu+ozyplxH69jMVLkGN/wXNRgN9hv5i97fMsiiECUuvxASw0FZF5shklHb9dBEGJSnWL7KosnYX+0jV6n2hJs3tRYTfhF/09ftftupA5k8xS4dodUcrzrwmGCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732766733; c=relaxed/simple;
	bh=f40S8r6wyjsUO9sPa7vuMJ3ZK7VbyS/eAn6VYiVTa1w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJRwHOtVUcTD0RojgVuXyJZ751e490dZVFWpwyvk/4+qeJOlN7xzaRS7QMcQEyC7cFjQDU+m/vOAy8ckXd4pgSJQvTUOzNYRXZ6xtcZmXRUdByDzWop+l77VktGKhccHhaZWED/k3oytcug5Zz9lEy5adwWNa9GbuCs+D8+/AYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qY/hWeGS; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qY/hWeGS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UAdVHODAFzsHp35MQB4DaMU5Q8evtXqWmiM3NCQHs2/iISUCZjcy6A2QMtsAccIdokfd7S63D8k4rsZanlRzv+lAjaIdeNzKpSLg6Kp9+LNdstPmiBgk9xstp3maBV1WWEUvd3WMemIaqAsGHwJq3Y1o8zSntZ9uEmWewQr3qr22rrR3xEOdNvsCt4/+n5QdS5XCzA7Bi9pX0oFAvmjdXcPeBb1h3T64FlSlXr6qUAEjW7VjXHl88KgLivR94U3YaftJizsF8SsOn6pC7BRFbrtmzG8W1oMO806vUKYbRgOAbzH9au8mQkhZE3wymd2qrvu+3S8aZ0Q0HeLNiEVnLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQcC5AyGjZ0uWY4W3I9YwimZSpBZYyaoMGe4WI/HDqs=;
 b=qCyRy27y9dnTzYBXJD6kSaNs8XOUqT1q4sESH9PvdqFAqd6UTAv/d4f+DmDXYZtVWJ2Tnp4EyO9AlVscigEGMAYqxGSG11pR7Eni1JAOojW4NudLP3/aTBChiDZ+mM66GTvTYDIjW2AALAFf/G0l6OnG04QtwpKZ7k0wJ3VnlwlBMG42nis6cey8UMHrtBjymXWUd3ISwoDXCPSyMIMPam0wTPVy4Y/4L5zi+Wrd9+1q55uUiPpaw7cfAVU09rE/j44xkX2xxqOliWa3+Rkg02lqsB+9t6YjqjJwX3lHrsMV7u5sfvfoRgtxQRBZ+XyV7ZZkiCC6sdMdiHAm3NyUMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQcC5AyGjZ0uWY4W3I9YwimZSpBZYyaoMGe4WI/HDqs=;
 b=qY/hWeGSvhfRUsjiuTiih8dRtWiI1iI+NG+Lt7k7aBjpwSs5NEkHCzRBgt/S+WqX+wvlCqKmydMW4mIY/q7KT3flEAVoHA6FjkW6d2KFWCz8B+yBFm0NEXw8byT2oUamAPWOCFqYdlovrip495+crW17P27vUwnM3rqkyK7tJxoRaDwoXTtiBK0qdfTyvYGV1FcpAvSJ75j3u1qMMFukPUjmxmdX37DYPwdAEoaoYUXnSX9/QootpHINlMZIMmjk8hAT/NVkAx36qNMcCntV7r7jVNmPlrK1xatxaRe6QwYdfeW9dJrHy5UJpx7eXszwJIdYaIdZleJXqVJ6xED6FA==
Received: from CH0PR03CA0214.namprd03.prod.outlook.com (2603:10b6:610:e7::9)
 by SN7PR12MB8603.namprd12.prod.outlook.com (2603:10b6:806:260::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Thu, 28 Nov
 2024 04:05:27 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::75) by CH0PR03CA0214.outlook.office365.com
 (2603:10b6:610:e7::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12 via Frontend Transport; Thu,
 28 Nov 2024 04:05:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.12 via Frontend Transport; Thu, 28 Nov 2024 04:05:26 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 27 Nov
 2024 20:05:11 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 27 Nov
 2024 20:05:11 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 27 Nov 2024 20:05:10 -0800
Date: Wed, 27 Nov 2024 20:05:08 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Randy Dunlap <rdunlap@infradead.org>
CC: <linux-kernel@vger.kernel.org>, Eric Auger <eric.auger@redhat.com>,
	"Vasant Hegde" <vasant.hegde@amd.com>, Joerg Roedel <jroedel@suse.de>, Jason
 Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
	<iommu@lists.linux.dev>
Subject: Re: [PATCH] iommufd: fix typos in kernel-doc comments
Message-ID: <Z0fr9LhAL9digKCl@Asurada-Nvidia>
References: <20241128035159.374624-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241128035159.374624-1-rdunlap@infradead.org>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|SN7PR12MB8603:EE_
X-MS-Office365-Filtering-Correlation-Id: 1852a0b8-b0bd-41c1-d79b-08dd0f61e3f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9poN5tyGRO1YxoJmfAETSPsII1ukzHYNXkjyB+hxgbbGiAY7DUHcL8/rotfa?=
 =?us-ascii?Q?MXY5+SU9v4Ld6FnjSIErJgrrnDRGsWiHbLy4y0/al0KDMiwptPozgIUoVCze?=
 =?us-ascii?Q?2XKft4eMNqxncQco9QM2Wk/V3EHdlbZl5idOlCxEzWhz4Bn08i9eSKfEGUx7?=
 =?us-ascii?Q?wrC4ZLDGx6l+IAU6HKrHetAX9aIiKZkpbNNM8CiFDrt/uPwSuVX+7lPQpJY/?=
 =?us-ascii?Q?oiKWGtnu+30tTB6sTVh8Ar0aY8ExsdhfhFzbU95DYHNHaeEFY1Rf3mtRt9S4?=
 =?us-ascii?Q?BbbpofQY8ni8vYpVxoSGKZ/0equBT3NgSThABJQOUbnNSeFBsxKLP+CbR8AN?=
 =?us-ascii?Q?NJ99n9mGCr5oeSMeTFFHzt5ljfCyVSvhIFaLXjwxQXtZIEOp5Rd8RGT1B9ss?=
 =?us-ascii?Q?5Oajwl666vGNJ8Rn3WzkwPrGAtA3YhUk5DDzwBPLHILujpaNujRJQhUxqhel?=
 =?us-ascii?Q?a2GWW/t50hiUFOlFBc/44R5GylJ5gP5VESJfOKGRfUcnwKRsGpUiCfvrFt+C?=
 =?us-ascii?Q?YCybsBkAUUUFhdoG6p9DFnRm5Bthqgkuy3NHSYc+LvjQKOA+3TgWrn18ammS?=
 =?us-ascii?Q?D/GWJvX0/93YUS3qtyfG4Nd1FcQQAWdAKOtwfXppNaeQIIkXDbyim0RXZ864?=
 =?us-ascii?Q?w5NhvKIz1WRt46sIfSpS6HP6bEtes4xFSVVcg+hHqmWNFqIu3yyLx9cPkr5I?=
 =?us-ascii?Q?aeq/yMcbj22dK6/GI0Z60hvFSe6eG9y/+hz48QCap2x2RIWCAyVFwCjCXBJc?=
 =?us-ascii?Q?fLqhnsAokpq+qNO0Fyb4AD/EGu/LO2yL03E23c9dGZdaFQSmLuWh9PE9J/PK?=
 =?us-ascii?Q?AM4WyRKhoHKQfp+aaoUl0gyYDwbaYsubGmhvHAk5ZhoEyhBLqLMEL0kZSlRa?=
 =?us-ascii?Q?F4S+eQGqAYxj2YSbR8wnSdHnauX5FKmh6jWA5i7ckboQbkvxxBcG+I00Mxwy?=
 =?us-ascii?Q?lW66+OG5YnhlSEr7902dSj0v6q607GkYa1xwomf7ZRfHPFJILLpUab7apWJ/?=
 =?us-ascii?Q?30BXBA2EaQs8KEtCHF84JLB9PAMr0yY8iJYyE6rtr+fA9APZc/pYN8EZzQ/z?=
 =?us-ascii?Q?/n1ZTm1V+6OC2g0D4yufjw2y3kb/K6tnEieuJmoMRtyel7FF+JeYJTXRzgL8?=
 =?us-ascii?Q?nCRcFaAzMp3RVFH0eNzmfdkaPj0b7GFY9i9n48fNmk+rP0AucHLnsqFF3RDF?=
 =?us-ascii?Q?b8MCYQwC/KvRJL37UtN4Ao0dor3UzUiWyqI5pD8FOm0j/2zp23IVCytyaMrr?=
 =?us-ascii?Q?OyfUIo1plUyeXazEeDulQRfv8ptIti1upq4EqiAQiCz620G2HxfZ/A7hfpD/?=
 =?us-ascii?Q?xxi2RCDk+taUE6fsA2YfgCOmkrPsWKIzTRGwTpep2MqnntaIflXC0O4KVJFd?=
 =?us-ascii?Q?dK1d39LEEgNNR29qMMltd918LNvs6tCuNWfpOPOp2jlU10Gtem3YdE9NaUQC?=
 =?us-ascii?Q?89F5EmuqfHiRX9Jd1/+tYLhc5QVWO0Ii?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 04:05:26.5437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1852a0b8-b0bd-41c1-d79b-08dd0f61e3f1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8603

On Wed, Nov 27, 2024 at 07:51:59PM -0800, Randy Dunlap wrote:
> Fix typos/spellos in kernel-doc comments for readability.
> 
> Fixes: aad37e71d5c4 ("iommufd: IOCTLs for the io_pagetable")
> Fixes: b7a0855eb95f ("iommu: Add new flag to explictly request PASID capable domain")
> Fixes: d68beb276ba2 ("iommu/arm-smmu-v3: Support IOMMU_HWPT_INVALIDATE using a VIOMMU object")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Nicolin Chen <nicolinc@nvidia.com>

Acked-by: Nicolin Chen <nicolinc@nvidia.com>

Thanks!

> Cc: Vasant Hegde <vasant.hegde@amd.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: iommu@lists.linux.dev
> ---
>  include/uapi/linux/iommufd.h |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> --- linux-next-20241125.orig/include/uapi/linux/iommufd.h
> +++ linux-next-20241125/include/uapi/linux/iommufd.h
> @@ -297,7 +297,7 @@ struct iommu_ioas_unmap {
>   *                       ioctl(IOMMU_OPTION_HUGE_PAGES)
>   * @IOMMU_OPTION_RLIMIT_MODE:
>   *    Change how RLIMIT_MEMLOCK accounting works. The caller must have privilege
> - *    to invoke this. Value 0 (default) is user based accouting, 1 uses process
> + *    to invoke this. Value 0 (default) is user based accounting, 1 uses process
>   *    based accounting. Global option, object_id must be 0
>   * @IOMMU_OPTION_HUGE_PAGES:
>   *    Value 1 (default) allows contiguous pages to be combined when generating
> @@ -390,7 +390,7 @@ struct iommu_vfio_ioas {
>   * @IOMMU_HWPT_ALLOC_PASID: Requests a domain that can be used with PASID. The
>   *                          domain can be attached to any PASID on the device.
>   *                          Any domain attached to the non-PASID part of the
> - *                          device must also be flaged, otherwise attaching a
> + *                          device must also be flagged, otherwise attaching a
>   *                          PASID will blocked.
>   *                          If IOMMU does not support PASID it will return
>   *                          error (-EOPNOTSUPP).
> @@ -766,7 +766,7 @@ struct iommu_hwpt_vtd_s1_invalidate {
>  };
>  
>  /**
> - * struct iommu_viommu_arm_smmuv3_invalidate - ARM SMMUv3 cahce invalidation
> + * struct iommu_viommu_arm_smmuv3_invalidate - ARM SMMUv3 cache invalidation
>   *         (IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3)
>   * @cmd: 128-bit cache invalidation command that runs in SMMU CMDQ.
>   *       Must be little-endian.
