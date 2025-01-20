Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F9D1B4F02
	for <iommu@lists.linux.dev>; Mon, 20 Jan 2025 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737388561; cv=fail; b=J/zSmppmIneg5hgho++3buZlcgRsNFahyjRUAuyimOrT4ZH+NMGmmvgCI7t3IMvd7d3nlLNYV/dJtFZ3vrUamKSuYcyw9FUC/yKfSQxkfE6O+OAgoQdv8TvtMe/W1lTxhECTZOG4oO+TgV8iO/h17Ud+vNvRCz4EMwkjmgDelcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737388561; c=relaxed/simple;
	bh=i1MMv7486CMwNVLHiSwscwSG1Mm54yQOdznNeo20H5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ay5TyIAVh/eOajAiE9vzGjFprGGdEUjaNH50n8BHAo91c08pvOF4SES+XpIk1z3F23eZUsOB8QWZBTepPZJCygM6Pn91kn6Iicu+j5hUI9lOkICKOXvZ36OZwVquee+s9vS6ywFCXsWo9ikPCrlQ0XrHQzbRRJ9W2gFUbG3FlK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RkG/Q8m6; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RkG/Q8m6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F8+TuRY8qDgtKHih8tgIz91+X921l7W4XWa5mkmnrS53GDs4BOJP5vAI8JlUBqG5HoNZlfDCFTD4g30+tAD7izChqZmXwIgyPTGFzFNOrChxkWgefNUkYeKo5J0uAtOuEWrHgFLDAEcN5ylGSO2X8MG1hgQEZfAYz+Kh9RmFgfLK28wNs8u9sZataeHM9vdz5OUz9h2VIU482Tf+RzJ4hqcV4Wc2hDhipDGgf9+/oAdb4N5q60zsjGAsxMyBPkw3K9CCx8M5TOX34S8CJfvxaDvdWtAfHDycz7nOhRstWe1k0byLUhhVdkGgLWKd7PLVhckzikArW2SlHkBXl9i67w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYcjAiiKW4LXCmMVAS1e3EBZtAt0wvK1tii+ZoiOl0c=;
 b=YYsgF1W3tW41wE2ekpSXnAOlx4n+FznjpBcNRhdlyLgAErZHanxCDRPylRDH//n/1iqHvS5Ba7xDkpn1vGTPzOzeo5tAoaiE2/0/H/5xSPsbgDZpx5Y0+NQjJgVwkaFVcm2y6q6DpyH3lTLSqf8Qx48d0MwpxN8MXEIa2JMg1qPZN0nGHyC9VPKOfZAQzQY2vkAA2fXQ6yQb8npDcay6CNoVzuQuYS4s08VjP+/LELmQofIwQApg0hrgbLYGKi6X5gHwG+cHcWodSNICAfyxrrTPuz7h1/2sjTovOfRqvBZlqrmJ0n0/jCj/S3/e5NNPizwnKrL6lst5EXiuvzK4OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYcjAiiKW4LXCmMVAS1e3EBZtAt0wvK1tii+ZoiOl0c=;
 b=RkG/Q8m6HGBqIPyplOW+9O6NMruBD3dYNardq7V/47vlCPxbJ4cRLeFDvofdgjvD+xQtwOREWIfMCLnqOAOTQRJ+38UUTXU0dhjmnYTXdKegcsY7kVKkL7HYm7cz2L9btcmLkEt9YYMCgZfi4hZYtNgjlexoLBv2Ittu/6ox24Flsv/xpV4uCbyJtu5/rySkSTFXvK/jyyT9tKJU9SjgBVH+rSQwMpmEiplF8M2IH30opB6G0IumirSXjOgGUDgL7CyRoAeeQLEpocoPOH++aQShX8TzrL9AzvoURK7PPOvHD9sdJs4W6Ijml3d7P8seKJimrIwL0GYR6uW1EfzDlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB5808.namprd12.prod.outlook.com (2603:10b6:510:1d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Mon, 20 Jan
 2025 15:55:55 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8356.010; Mon, 20 Jan 2025
 15:55:55 +0000
Date: Mon, 20 Jan 2025 11:55:35 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, kevin.tian@intel.com, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, jacob.pan@linux.microsoft.com,
	robin.murphy@arm.com, nicolinc@nvidia.com, will@kernel.org
Subject: Re: [PATCH 1/2] iommu: Store either domain or handle in
 group->pasid_array
Message-ID: <20250120155535.GK5556@nvidia.com>
References: <20250120030840.4171-1-yi.l.liu@intel.com>
 <20250120030840.4171-2-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120030840.4171-2-yi.l.liu@intel.com>
X-ClientProxiedBy: BN7PR06CA0044.namprd06.prod.outlook.com
 (2603:10b6:408:34::21) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: 2708bc22-186a-4f87-31d2-08dd396ae11f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?56/w9yHUhyP0zlTFhWfN4oBP4jJQC+CusGlFAm2hTiqahWYlrhgl3epruGge?=
 =?us-ascii?Q?9hGYfLPw+2d67U0/yESbOD7r7dgL3yiv25bsKqhI3S2jwazkd/COx5pRts9V?=
 =?us-ascii?Q?A+5vohPJWOQWDZ2fNGTBL9KSf9MoG8+EXLDpZ+BI1vDZotdYH54EN52tZWBr?=
 =?us-ascii?Q?8zdgQ1LjpPB0td8xZ2DSStHGiLoV4+kHf9YY6Ry3XH1GN8Sqbwp42KhyGz3K?=
 =?us-ascii?Q?fpYrvlCcAoKWtALEXNTiL0C+No4xXa6r/ePS5iCD7akbURwGu80vJS/+sjVj?=
 =?us-ascii?Q?OhulxIkNCx8NG4neo/mBXZiHPLd7+5QyTRfUa3kEacKgY/WZHuMqmKYgKppv?=
 =?us-ascii?Q?fuzdxRhjAyBjVPV0bZb0Hr/+siV79kv3bp14jV27TiSEpNcssEGj62aHFUIM?=
 =?us-ascii?Q?8udZN/91XHqdAK8oPQG14mULIOzRjfCWCcd/fY3VTUsN1kSZ6Qw8IuRum9Zd?=
 =?us-ascii?Q?ttbUKgX0dcy3yTETdBQWQqqXAjU9U8uvlC6ee4c+Oa2502DLYj1+AuT5ZLTY?=
 =?us-ascii?Q?7/riD4OXsOGBcuHwxfq32LqMGPZd0xcVESLWGuFLAGKRINeDl5t0cwpeh7CV?=
 =?us-ascii?Q?gOUP/awIEafffX+cGKbm7lueRPyl0Qc54ssZu5JWnf+QRcoIklCY1KbbbHTi?=
 =?us-ascii?Q?x0s0ktMJ8Pb0JCz0a+z+k7kCcHkkRaKjnR5e1bse246+QS11u1A3m912XwI5?=
 =?us-ascii?Q?GhQNSvtmxIMc/Jv1duMBeY31ylwhPtUgtLpF+cSBu8z/JKc69dzYYrBvGqwr?=
 =?us-ascii?Q?izoOxoA0so7FMUZyPXprF9arw8bOFRXngGMinjVCrsK5VRU8WsLQG2DQ+Ct5?=
 =?us-ascii?Q?pdo8bqCxRYU6o/JMT24eqwf+QmuPb2vOvk196TRDNWGs9ONBsEdNxbubpP5U?=
 =?us-ascii?Q?AC6CVqPQ18+baTQYFWedyW9L2065cxg5BqouKt4Nih3qW9q6s2QrWKbE+mzY?=
 =?us-ascii?Q?V+vkUa6y5Z4FXIKd/EyMujT44OG1E29mH44/wlmBBkTtDHojuCX494KGcrCd?=
 =?us-ascii?Q?eIBII6C4M/2NEmLB5czNUWKy5INxt7MUviM/KibrvzhuDN40VU1K+Dy4Rtru?=
 =?us-ascii?Q?xrAxEx+/szGAzode3BdLuAopmYkkF/wEYp3t0yodQXZFIkytFEvk+DlnE4lI?=
 =?us-ascii?Q?ZsrSaCXRp09z13Oj6lZfSK3inyM+Rir5jIHtSrz8f/Xxz53S5s0GVMGudVd6?=
 =?us-ascii?Q?XYE3gB6XIKlVjdXmrwOmUXLLgQUmZWjDv/ULH/0Xol+5VpP5xPzqWL6k+UrN?=
 =?us-ascii?Q?1fO2UPBTRxKeROWMwKJDOwOrr0qyLriqMfjpV2ydB/kO6wk5V/puHIld5R3s?=
 =?us-ascii?Q?7XVuG4aX8cVpBqmXn++D+ZYVGnIH0CK/rHCVGiiM9ZShU/tei2lMShs69Qnj?=
 =?us-ascii?Q?RimMM0u5b7ft71OpXwsjPwtvkkr6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x/lqHwgOwhZV5HW16/LYZGlWL12VEi1eUgyHTawnX/3eXG21bKcb04B4C3H5?=
 =?us-ascii?Q?SJuN9GjbjDYDCuF/wKzOcXxNU/AoWo4ea0zLVuruV6MU2ydgSWiTu49RxcE/?=
 =?us-ascii?Q?uJu6D2heOa0uTkomkB5fddkstLrCCccViRnCcg7/4oh4+/XxyaF1TFuNl76j?=
 =?us-ascii?Q?fhE/scELd9GAPbwCuaz9tQCjzIRIfNX8dPg/I1umY+9rBxtLCiqCK3FHbm0a?=
 =?us-ascii?Q?D/fa8YP5J724uB6giGZ7nIXnY39V3X6n6oWpP1kLVPbkORGWt5l/V9J3y1vX?=
 =?us-ascii?Q?cDNb6ISUaiy14/i5NhG6n++RiSdE3cLH2cYZReby/JQiME5yM8TtYgQEMTkY?=
 =?us-ascii?Q?7HmkIadIryE+sZdzOHXeBSVuritpAIqdITGOnlHwwzVqM14WNyg5r2ye/jdd?=
 =?us-ascii?Q?23XmdOqMmR4Qpqj7L6mkEHK9Y51oDORzTh3FAfPTjKa8jUduPTnURHGO7nMH?=
 =?us-ascii?Q?d9HTUuHPxh/sdQCFstaV4MoYMhX72bCk3sCU5Pqie811+Re8EnoJnZxXcwtq?=
 =?us-ascii?Q?iOtqbpjrdHH5aIzCGLH+FDGU6MW0lQT4SvD6Ca2wTEa+I4XUxOkjB5dXlbsa?=
 =?us-ascii?Q?1lo2MJD4kRRLh90nKsFkl4bTBrdwStdVaXTxAwAjk6yUL7BofyqWUZxtax5I?=
 =?us-ascii?Q?keIxWP1vxp1LcUchzsRyqCJkukerHhlByfxNoGagBbavSgEDWYtwZv6RpXi5?=
 =?us-ascii?Q?ISPekk2CHTISTbqaSBXix5fH5fThY/G5s+84J0AonWjfv3FPrLyc9QGQ2egY?=
 =?us-ascii?Q?u7XhgnIblll2ZzGTwYKpUpNyCVfT41EXGQytBrSzvMCFgi/AKArxU+U4zPX6?=
 =?us-ascii?Q?+PGzmy2nv3BOOH9pi/9aJyg0S2W4ODjHIAT1jlgOmAM8y+AsY/3tRic5EWw8?=
 =?us-ascii?Q?zb9hKsWrD2YDTF7vPpCZaafqJIMTaR57cqGrDYDIpi9hEQ728YvMUzdjVLwR?=
 =?us-ascii?Q?HIp1PGEfCAgGZsVwwKgPGopReXx+bxjPNCYkcUnpy1DczIx4vcD87GPJWuMy?=
 =?us-ascii?Q?LjHp7kJIUh8kZIYlKcbedsfAaF1b6SA7iL8ghu4M950I4jQodVYnE1wTyJ8H?=
 =?us-ascii?Q?jqITwlReSY8/mfL02mi7Oio6F1P2BN5bp1DQ+YDHUM+E2t8zxrrfoUc72VhG?=
 =?us-ascii?Q?WDE+C3nU8XfuJBVjA/cycSN7DFFnFmXud5hDKFKYgYkb24SJOqpYtrnW8c58?=
 =?us-ascii?Q?X74rX8Lt86NkgCV2FYWvmH4yCSoNALx5ZsgzK+TADI8XJPhtvSQkHTuvuZnl?=
 =?us-ascii?Q?dxwD/aHB0ffLYm9W8Ahuvh6kpbeDr0quJzfEcMipyfpIEtqSk42m7eVFLjxG?=
 =?us-ascii?Q?Use7b39CIUDf2fY+a/QdqaAhvKC0DMZvUQuylGfriCKv7QcRHsRc9ZFXZbLU?=
 =?us-ascii?Q?P616wJydPMu7Y7j+ej/2S9K+Rnia+JzThpsH7E9iz81NusMNHdHrXGKOT92r?=
 =?us-ascii?Q?BB0HvWotnIY3g05B1KWwKbd5HiqH+RAAhMS/MhdQTi5/Z2F3KI96iV4Lksjh?=
 =?us-ascii?Q?DZ3s/r2JMW+X9xolVbDprNj1T+WBCgc5JhIFTxoWlqzVl9HXnyR2j13mDAUb?=
 =?us-ascii?Q?Pfdyh+M7OUhC7oRJnSA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2708bc22-186a-4f87-31d2-08dd396ae11f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 15:55:55.6375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +lbJacLa7jgD4ucQhlG10ESunvhqw30SBiLIhH4M/j/41CRNV1VOBl7hXW0Nf6wO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5808

On Sun, Jan 19, 2025 at 07:08:39PM -0800, Yi Liu wrote:
> iommu_attach_device_pasid() only stores handle to group->pasid_array
> when there is a valid handle input. However, it makes the
> iommu_attach_device_pasid() unable to detect if the pasid has been
> attached or not. To be complete, let the iommu_attach_device_pasid()
> store the domain to group->pasid_array if no valid handle.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommu.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 28ffd836592b..278c4eb8f225 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -45,6 +45,8 @@ static unsigned int iommu_def_domain_type __read_mostly;
>  static bool iommu_dma_strict __read_mostly = IS_ENABLED(CONFIG_IOMMU_DEFAULT_DMA_STRICT);
>  static u32 iommu_cmd_line __read_mostly;
>  
> +enum { IOMMU_PASID_ARRAY_DOMAIN, IOMMU_PASID_ARRAY_HANDLE };

Since xarray says:

 * @tag: Tag value (0, 1 or 3).

I would initialize those enums and add a small comment

/* tags used with xa_tag_pointer() */
enum { IOMMU_PASID_ARRAY_DOMAIN = 0, IOMMU_PASID_ARRAY_HANDLE = 1 };

> @@ -3397,10 +3400,14 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
>  		}
>  	}
>  
> -	if (handle)
> +	if (handle) {
>  		handle->domain = domain;
> +		xa_entry = xa_tag_pointer(handle, IOMMU_PASID_ARRAY_HANDLE);
> +	} else {
> +		xa_entry = xa_tag_pointer(domain, IOMMU_PASID_ARRAY_DOMAIN);
> +	}

What about iommu_attach_group_handle() ?

	mutex_lock(&group->mutex);
	ret = xa_insert(&group->pasid_array, IOMMU_NO_PASID, handle, GFP_KERNEL);
	if (ret)

And iommu_replace_group_handle() ?

	curr = xa_store(&group->pasid_array, IOMMU_NO_PASID, handle, GFP_KERNEL);

I think it should be consistent and it should call xa_tag_poiner() too
(even though it implicitly always is since the domain is stored in the
group)??

Jason
