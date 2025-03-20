Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE482063E3
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 21:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742506938; cv=fail; b=j/WFlHVr/SNqzsaVT6/xJwavk1XgQZW/Ku+gieregEBwACIGH/+4QsmO3z9duzNF/L9/JbYcbHPq7fJ6Mt31YzL5o1QkKUn/gZA/kPeGXYOBJNoIWpODSu9nEGtaxLf1VuY0vfj5Br/QBjmPzFbD2OY2lMxK2sq7Jf/BWJ6I2f0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742506938; c=relaxed/simple;
	bh=xnP6bw1UWfx76VXhXgOhTjUQrxYuhQ2p75nuLUg5Kdw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ceerG1duFArSsobbdjCrKEkrnmvenSViI9MzKBfMVrZvHT+bpEUUV121wRxPqaseY9urz4E5zNhyZQ591WKjtHk7z/hJwaBviLRxLIP63fZFz+DoCtJ83dG4MJMLpqFBGmCzmBPFVdMLDFlsZ6A3yCSuBGY5wpn/P5GeAr4nXCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZoJAW1Pm; arc=fail smtp.client-ip=40.107.237.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZoJAW1Pm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2QR435jyg57sZwXm9LzZYg7G5Ae5eL5383wghGu41qF/aabj92zfjXrnbrp+rGbBS1EJmefxeORIoaxqjz1kqBBG7TKCFhykWtZddTPK+OjO4SVLJrodZ3QEbTKb19znyxyfMz44+qFZq8mXb5c75GjPlB6/K12xA+ToUdXIGKksTX4tWQtjyVwmpr0tc4PWRjlQB/DM3CVT5xD+LoOgMHOX/4KFNuE8TaZKIFBppg/f1V0tG2ksJo3BjSxSvVjLWzHaZLaJ0R3Wno1mY+iO9TsZzzSTIgVlNMV1cgoD+xruqUtRgwOZkwyQ5YMPKikb7p6IQkU5oatscx4wmGnOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJA1G1lm82l4/hGJhiTKurWe30ZeukU7rN2pY/A/RVE=;
 b=LaVk8aG3pka8RPZS4tyO07YRCWNEqFSkUToXxhNzNUNGa5wsf18pz7Ap4j/UwOyoau1rdolsC4N8cmiyIcdzkV+GbnFqeVXBN7DXZyGnd++YnLlTZJY9CjsJVoAO+/OdxvCScM7IFxK+A0hpMXrFTjcylEsBngE7R32bVjumZfACGRts/CcGfaTqBecJqjwF0shs64KusKZCzHLTWKthVG06UCZvwgbOQarB+2+t0Z9ran5LbRmh9EFnmMLgBluKqWF1ypM9O/rEE0ZoeQi5Vr9WTexrsHbjiTH3GzCshssLBBpL/8Ag463Cv99qtT6vVMyt+TQuu23XN3D2GX6Hwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJA1G1lm82l4/hGJhiTKurWe30ZeukU7rN2pY/A/RVE=;
 b=ZoJAW1PmfSHNZjtAJ7c7qieCI4jj74U/1Db17/YS5ABlEsRGgp8w1j1UXAXb1WSGdGJeujAbyYUe++EvW/SD1NXUo3A/h4AA97GqVpUr8nYsbiMC3o1nRtI48mcNk6I9Zrtyh9xDshiK8L+t2NNB/zP06J609BNc2gKRqo4nOR5lW8owD1yF5Q7AtGaQqy91nPcIePt55gBf3DAX5P7ac3/lkMkKRRMyzfJbXIbBJ6CG8TJ91e4n8UW9lHHAjBPIRHLqJX3rlUCWOBKdPW1VoLuMcCOy87Q+9MQ7EqfkrBOij2t2HAGhMA4nUzX/2T8833/tPpl2vRcZUyYt5TOajA==
Received: from PH7P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::20)
 by CH0PR12MB8578.namprd12.prod.outlook.com (2603:10b6:610:18e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.35; Thu, 20 Mar
 2025 21:42:11 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:510:32a:cafe::e7) by PH7P221CA0016.outlook.office365.com
 (2603:10b6:510:32a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Thu,
 20 Mar 2025 21:42:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 21:42:10 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Mar
 2025 14:20:38 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 20 Mar
 2025 13:42:29 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 20 Mar 2025 13:42:29 -0700
Date: Thu, 20 Mar 2025 13:42:27 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v10 11/18] iommufd: Support pasid attach/replace
Message-ID: <Z9x9sy7s2u18wVrG@Asurada-Nvidia>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-12-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250320134744.5777-12-yi.l.liu@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|CH0PR12MB8578:EE_
X-MS-Office365-Filtering-Correlation-Id: b239aed9-c4ae-449a-65da-08dd67f811e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+hXAy+uybumnLDueiEgtFbcQc4DDRXqOZKdMkpGQ7PjQ22rmFj3duDjbIzeb?=
 =?us-ascii?Q?szbWh0zhgp23gRawqxILH2BDhP4u9+d0gTjq+a8/XdHS6xu1nwS75nDKyPjp?=
 =?us-ascii?Q?Lv/c8MtyvlSj+hVWjhhxgbf1PeL/mhpjv+4nYWT5D0KzfcqOwCEks0PRpRne?=
 =?us-ascii?Q?N+RpVu144GrMh0KgceXWxLfMuCDdkeXnZvabgC+QeUHJDvG+l/XDYyIIrhXK?=
 =?us-ascii?Q?sOhDwfKTTz0qxS0LI2nnpSiAluSGJJTkXAdkH9YNqlaxgtf4xXolzU4hf56X?=
 =?us-ascii?Q?hQHKiAjw4bm1XQ8deuRW5Y/XZyQ/8CmEbO82t+odVmDvkIKlYRqSuSQ3Mhbc?=
 =?us-ascii?Q?UA6dTwkD6EyMhvWfcRESWa/gqirCjJZw6KSL2yiqK5fyb4FnAyI1nspOERfw?=
 =?us-ascii?Q?pHEZ53xp9jc+hbc+SQnp3ZZ4ixRlcqHAPnvI1noF8poLoY8JikVIfdjFQzxR?=
 =?us-ascii?Q?JVmG9aC2Q2CyduUwdWVzebq3/w833Ly6iLJ0XkbH4mqLxo0GL4GWGwkusRkT?=
 =?us-ascii?Q?A66p1OxIUa/YBtTjDZQryA0F9Y7DupqMy4Ed/NAC0HZq8l83Gx1fGa4RlaUL?=
 =?us-ascii?Q?3Vcd+FLhGvVOh+aSawvIRkGrdriGa4vh6LU6hOQvnNnMncgp7k2p7YQIvldi?=
 =?us-ascii?Q?rqVa6Z+hCbaw9ORYG+2eqqW5AOpKlICNHPSGeeFwLuoc9sPRXDycuv/DJ0eo?=
 =?us-ascii?Q?u/KwwpxoFpFreb7xqZclK1OT4Z+BznVHoyjBgddF2lEiyIR6m2fqPg2EqY12?=
 =?us-ascii?Q?T5+8Sa1UubAHetCsGszWumoqtCA9Q2+9cah/I3R5ubSNe7LbBMiSLRaED5bE?=
 =?us-ascii?Q?+BfTzcCSrG9Mjuj1qoz4SR3hJv/EUf/AQY7IUE5KEuNkcf712P87SMwPHabx?=
 =?us-ascii?Q?+HphdlkNCpeWZZtcfKTFWWAz1FEYtMjvEURcEv08AImG5bNArzzwaqp8sw8m?=
 =?us-ascii?Q?xkCK1S2+culgwTDfGNmXhmWtK4grPMA4tUTcFcJM35DS6y5zvvbyzVQag0UG?=
 =?us-ascii?Q?AYDSxGIydOdqi+hOY00dvl0imQJImSbmD9JEYA6f7Zr9kvma+kpxlDbhFcmt?=
 =?us-ascii?Q?ju4/3vsm1NqrKqQ85J9ABA6fhkzQ5fmzTDaQZ0cK9OUDh77ULsNkvwZ6qr9F?=
 =?us-ascii?Q?IOsiAe99QIYdZFRb1WMaxbx7Ax2xj+HPhwpKGArTmj+XhLY36uOeDRhbM+ke?=
 =?us-ascii?Q?Fl+L985R0OaHWYj0RUvR9DulTvVj1HeCYprH+ojK25lOJx/R6SUJQ1PhZj8u?=
 =?us-ascii?Q?ofw6FzOvhaNa7ml6XB1Kjpk/pW9ij+bbq5PsPKC0pEg/46rOkJYP9+yDvMtk?=
 =?us-ascii?Q?o8M7YrHGN9yBbYoBriAn7DONJgDGmTiTn+u0VH+mfyfJ7hJD56TE0Q1J8xLZ?=
 =?us-ascii?Q?k/cz1KiKMlR6Kg/XfJ6ETerCHMixArdr3oPBU9tDFivXdoqMmFgpFGzGVyec?=
 =?us-ascii?Q?XKvyknPTBdVNGTQMQsPP279fUt+7bpcXxtikXtclxNb/P+aofKmpRQjzaBKR?=
 =?us-ascii?Q?zNsMD2XtCEk/TDE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 21:42:10.5050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b239aed9-c4ae-449a-65da-08dd67f811e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8578

On Thu, Mar 20, 2025 at 06:47:37AM -0700, Yi Liu wrote:
> @@ -579,10 +582,12 @@ static void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
>  {
>  	struct iommufd_attach_handle *handle;
>  
> -	WARN_ON(pasid != IOMMU_NO_PASID);
> +	if (pasid == IOMMU_NO_PASID)
> +		iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
> +	else
> +		iommu_detach_device_pasid(hwpt->domain, idev->dev, pasid);
>  
>  	handle = iommufd_device_get_attach_handle(idev, pasid);
> -	iommu_detach_group_handle(hwpt->domain, idev->igroup->group);

This changes the sequence of these calls?

Is it correct to do iommufd_device_get_attach_handle() after
iommu_detach_group_handle()?

Otherwise,
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
