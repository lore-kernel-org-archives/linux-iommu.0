Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4FD27127E
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756280; cv=fail; b=XLqr8PwpEFxhBk95gWqm+nx1fgNHbv+gW2WR8iGqcn1mgAY3Pf6IrxNmh6zC40rnr6X9EEtUijdKcbLp3qD5bnytHS20Y9Wai+P/y7yAYPaFSHfVFFz5NOg4ZyAHwqNEkApQ9O+0wr9SS5mIz0756C6B8l7TwjEKhtu9qkVrB0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756280; c=relaxed/simple;
	bh=RCi39h+85e5Afll3P13KdPbERvdvJ3sDGxCW0VygkS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WTZQxFZ1iwTRpMi9OsMJKZthE40JxQBXwvWxQJkoI/MkXZF4zCoCV3nCU9NRaUVBR6ba3fNTwAqV+Wi39DBJPV2cWH/wyF2c4OPGpka0EvAoylvOsYE+ZGvQr75rfOJ5dVr6XVRsAEAkQcdOPsey8zpihIwa/6iA0ZsSiRVSviA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PNRNSaGI; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PNRNSaGI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pVp8Ipib/V6PD7t73B9LAhmKcGkv2ivCBIwhgEFkTHXqAl6aYnaNiLEnQ2+eoOdPUjFhBWaiaoy0fOPBIIg3JK5po2oRKm20rlNU7VX+Z4XRJU7sNOS/faokWQfPAM/O0m/wU4yfF4H9AG3qM7ZYP2HfSHudKhfndO1cXxM0C9urjuedaIIuReBvZJ7020RQ8axhuJud0T9fNZR2kjp8IFQU/B9hPv4vz05xqga+XCe1jyTPLTDFktOBmEvkePWHVSiZBMU8u6HoqGJmcxNoBOop79BJL2NRLrx8t1DXkLGidgG+gq26M7BeHenYcE0IxRsWK2qwADP0NvAKup/R9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tl1dgaiozxzGVjSLkycbniZqMJlqNe8pGHKAD09SyfM=;
 b=f+s87SY+QgMCxS8/d4A2HrBKaOE7Nr25BJ2TyJZxqCPOWD63owgzLsMrxw58TmFrsUIVyYhk1fWDgMO91DsVqROCRW+G4xjIJd03bgoH8N9FJN4uDnDATmGMAsCdwpuCOUyp878EbUZ1SUTRlE7yHvAplGhKOPvrfX3OAU5SVa/vqczPKdQmUjQLtxOEr3IhPJptsJ3c7AWAOgRrrj7twaRDikfOg8G1lW+q5BChATCidRw7tq6q9ZFJ/XnODPcil+nq+FTnWsNiUT8AKrasgd01Q2Y+uz4Vakbhipgww1qV2HQpotf9bnKE5GoSEUh3RiK+kOUas4GSieyOBVk9Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tl1dgaiozxzGVjSLkycbniZqMJlqNe8pGHKAD09SyfM=;
 b=PNRNSaGIYULyi9DWap6u5VZKZgxmJRHJIg9oYExbRj4MRzCzVIRmdw1qk8j+FLCWwU/QVjdKp+Dl9hALfPUru2uhq8uFmnFaRUjP84ebyxAq4NrmruhZshLNQoNaKP1N+xn5PaMunyHi6oP8bWuTyeoYNrtVq6n5qFN9K/ZfCyyT3aU8LWrY64Q5lMZKYtSiKwZPuegGVUq/o7J77YP7a2l97zbIZC3opDh/4lz/YAzMaXgNXhdyqA5Eoe+qtOeq1Ncna16Ys0yWt3McF3wP4wW+9M+hoBP9wCzBLlMpKHAmbhT/xNqyclaAvHs+FwczfRVHZN9Z83j7NraYt1eAsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB8266.namprd12.prod.outlook.com (2603:10b6:930:79::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.20; Fri, 28 Feb
 2025 15:24:35 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 15:24:35 +0000
Date: Fri, 28 Feb 2025 11:24:34 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, nicolinc@nvidia.com
Subject: Re: [PATCH v8 04/12] iommufd/device: Only add reserved_iova in
 non-pasid path
Message-ID: <20250228152434.GW39591@nvidia.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-5-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226114032.4591-5-yi.l.liu@intel.com>
X-ClientProxiedBy: BLAP220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::6) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB8266:EE_
X-MS-Office365-Filtering-Correlation-Id: ed96d3fe-3c53-4046-e410-08dd580c01e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x5PENwSLZtqc1KB6MmFlDJyEE5ZDk53V3qykHKqBvX3lcvMB3bqI79plE6su?=
 =?us-ascii?Q?grgf+64QdYUzFyPkoM0zNYAh2miL/kfwhz5Iqt2H+gQmIKSCDY0Y/NE5bZcP?=
 =?us-ascii?Q?0vf80Dn2bNJmJqS8f3L7cFBRZ6PEDinNdcw/JFPet6AfuHmKT4yypNPVQPWw?=
 =?us-ascii?Q?x4bOFFRbByWoSs4yUnIm7l9DE2J2F+xTAqet0Lz7sSq6xs4HJXu1T2plHFKI?=
 =?us-ascii?Q?oWoV9rmaa/7dvYT1WBisi+HNHHVOGdRHE8G0Y39NdNgkRwc/OexhgY2QYsnP?=
 =?us-ascii?Q?2t4ma23HfVcO+JASef3Ayc7q3mhckSNozUpA/SgCDzraobUOdiPWSVimbKcL?=
 =?us-ascii?Q?l90II2JGmFPItGzWnE6Oywr0TQXAwFoKHrpuSGzZGT78mDSwBsPwhZmK7yPo?=
 =?us-ascii?Q?v2rkvShVH6L/Iihj+S2HAPf5t3c4ZTRcszxe1VNWHxFMOT8BtjA8cuLnl65Z?=
 =?us-ascii?Q?mtuJ4XgtTE0dB0PkPKKOyiruRrT0wR/R2VLrq5kHnW7ewmJOMYsWodXL4Up3?=
 =?us-ascii?Q?qAyCzB1zapqgFkVy5fDKbWRuFtCoNw8nEnCr/8X9FUoix0HnEqXtLXu4dtAo?=
 =?us-ascii?Q?DrUqoWnUKbJ8OIF2eXtvVwKeaNMGG2J4teI9Qxnt4pWJcWvuIAON+ViUMVtc?=
 =?us-ascii?Q?qbRFFwzVnfENJnXvUQczPX/G8/CHRCcaPY55Z0pmOA172NgNmsiFY7Oit4px?=
 =?us-ascii?Q?87J3EwOrdV0KwH/O7mHR2t3BC2VXehyXaSoBDpW2aIJK2LA79pkLKcbMIlJT?=
 =?us-ascii?Q?UvDrUYhNBES50owwOYRO+enepO82m+WHiDHXC55TqFMLBfpZmIvw/oV16apo?=
 =?us-ascii?Q?2a4x9la/JUJcrQMChnwjRm6dakx5iMVCdL7BqIN9oCWtzzdpnNVcwiOFj13d?=
 =?us-ascii?Q?WMrjwuXYi8TV8GctDR3EMMXE1Hk6JKmENfLq/V4KUiy8nO7puQ9ma5yuHrv/?=
 =?us-ascii?Q?RhPadHhGQFxAAp7i/8mT7gxgbWdMMKZbBHXgYvweS2gQD9qwvTYNwVAq5Hoj?=
 =?us-ascii?Q?uB8RKbxA7sVK9xl0JFZ/Qq6UH/YMFN1rFcgSdB1rqgrkjnvFpc27/pFqQkGs?=
 =?us-ascii?Q?SdDrWFS9kOFRnmDkGJounsU64fiN5ju0Y9LshwPmbQkwN4Ta7jeNQu+DnPfN?=
 =?us-ascii?Q?LcUrLljAY45BBO3SiuSqtzPIIr99hvs20iZyw2vzNPjFkZQTiCbypnhaF6UE?=
 =?us-ascii?Q?KqGlqsoZcKDfDqCe/pw62EVm+t7EcjM0/2I/r1AZghn8SlEbM/bJf+ylWyEF?=
 =?us-ascii?Q?qLjR/hljlHSNKqOhdbo1x31M3r8rh1QS2dCb9FWw/AmE/GsqIII1O5s61d+v?=
 =?us-ascii?Q?kUbgjCwUVz3BYk9hon0WWuAzhWi1GTvbGzOFcyr2INUKoGL7CxEXLdtPmxeC?=
 =?us-ascii?Q?u2gAoSl0zr2DcHSZba/pMGyMnB9R?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LjzptbGXbSLCevha3hPxDZLLUT8RZbHlbQY0+EkzFZ/+7UacZ18qE7pU9sj7?=
 =?us-ascii?Q?ZscbYigH6vLcsbuJfy+B34nOqM56k7q7WZ8Eac/TYk8lquynJiqJnq2FlVxa?=
 =?us-ascii?Q?AUOsScxqU675hqTxv/f4x+IW2T25t/HpuJK6gnhq+tCz0ps7GQ9grVgjqQ5G?=
 =?us-ascii?Q?E5wDYSanfoN0GV6M14eaeYCp9ws3j8seLDlj8MelOslWAoWD2rPXGDqPNOr2?=
 =?us-ascii?Q?n1S6M2a2vfiPrj9KfK5gaG++tpT6IrOnfwEENcnf7F4srd1d1sSeUjykVvp0?=
 =?us-ascii?Q?+tsEtDkkMm+3tgnZPjRGnDMFGCDOFCF0UssnvRfDZiZe5RLmORT/UP2KLFnt?=
 =?us-ascii?Q?a3dbxav8a/q3BUa5Ojxwd0GMT+W6ZHS5aBRBCmGGy3xJ2aU6xw8ijYCqn6se?=
 =?us-ascii?Q?OQWMdXqBRhziR17RfWQXi4bX1K6p+tAgLmy4CxEZZPSOtijPLz199eXFatSc?=
 =?us-ascii?Q?mIuEihfx9C1bJBk5E00SWT4EvDf8GU0zsy+53pQrg0ZonEDoA4w+4EFRoAlo?=
 =?us-ascii?Q?pXPx5uti1e9VW1eJgcO5wNV88aMtg1tVX9TFcxAx81cTSZVWMqVPcQ/FYc1x?=
 =?us-ascii?Q?ut5Q2v6i6y3/kcZJCvlX9Ik/zH4ITqVVjIYT9xUjE4CS+zEsGQsV4pxJ9Crq?=
 =?us-ascii?Q?YHWYKQENlGEUCaGObUhlyCD9/zqQQSRcFWXXNLLIi7FDVM/wF6XSFjtJyihR?=
 =?us-ascii?Q?CxlXtuv6x79SR52efmFXoZKxT6MDO+QjPpAPnyozApPTgwW008+jcFFxBycN?=
 =?us-ascii?Q?XpmXsv4YtQNoqgzoSUAp5pJqWLcGA3YTbKSpOmaM68oGbtUkYhBz2U8/LKPM?=
 =?us-ascii?Q?rmrJTZ1DRIdCE2mF9eQzSwRdPeZNcvyCenkYzV7WIsC9nLzTpU6/MUb0TZBT?=
 =?us-ascii?Q?uWytDAEiZpoCiJv6cequLHd5w+xlzX7GRNJIzUoIokNFIgq+0ZLXo3sDRKew?=
 =?us-ascii?Q?X+fKGhDY5S7dX2nU+7HYr/Fc1S78ENCl7Nt09koW35IsJ3BXvxCMCEOFVdIA?=
 =?us-ascii?Q?N7MkXzRVrg5CdtavJiX2QblAFlANq4Ag2Ml6tMF3F/wT4bUOKX304ZK1wAQm?=
 =?us-ascii?Q?bJaBk5kskqDSbD8QV8Pr2cmHs84R14nBc27DykjFUoezQEFeaK4B1l/xtTJP?=
 =?us-ascii?Q?rsejXnm7NFctQgCnUP1JGzdxBMTqV7F6aJ1MMJn/JU93CvMIsZLF2uJG1Q5y?=
 =?us-ascii?Q?7RfPqHCKXZWz4SAP0w1l9q9i9ugWCjI8V08pcE4UOph3ymA3T8NOBxKtE/Kg?=
 =?us-ascii?Q?b64rrDo+NylJQOeamXoA8zwmrsAUbViyDp0/zF/8H2jOMTLbojYEZoPLeZFl?=
 =?us-ascii?Q?Nbb0osjDb08bQf27WFLzxsjqn9UzZH2CWxsGPqV8185E2xHRZ6lQ+VYNAq4r?=
 =?us-ascii?Q?ZHYDWptbakoaf+aQswwKbQEAuRuYjGWrJ87mmHLuwhFGKyud7kg6KI7Xj5k0?=
 =?us-ascii?Q?B0VTZQYT5+NG/AVE8743jcBsDuph5uqg+Ug5AT3uet55xfItKGcpyw3efS6g?=
 =?us-ascii?Q?pJHlHrBr+UH0/fUmKnTI80Rw7tURZLYc0bkFyVzwpow+rE31jFPUdx+Pa6jH?=
 =?us-ascii?Q?ZsRkryfuWaTq9TNf+k2ry/fj1A+Nm4p50zFTkNe0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed96d3fe-3c53-4046-e410-08dd580c01e1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 15:24:35.2765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p2w6Dc4RvHDD4XQDEClnc3odJvoDKm66PrLKArZpxfTsYb9zjsebcR2EzzRDLp49
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8266

On Wed, Feb 26, 2025 at 03:40:24AM -0800, Yi Liu wrote:

> @@ -471,6 +471,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
>  				ioasid_t pasid)
>  {
>  	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
> +	bool add_reserved = !!(hwpt_paging && pasid == IOMMU_NO_PASID);

The !! is unncessary. !! is a trick to booleanize a value:
 - Assiging or casting to bool already implicitly does !!
 - && is already a boolean operator

> @@ -590,6 +591,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
>  			  struct iommufd_hw_pagetable *hwpt)
>  {
>  	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
> +	bool add_reserved = !!(hwpt_paging && pasid == IOMMU_NO_PASID);

Here too

Otherwise

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
