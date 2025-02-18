Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98021E51E3
	for <iommu@lists.linux.dev>; Tue, 18 Feb 2025 19:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739908684; cv=fail; b=SpYqWKhHeaXEbxE6qDOKucGIQSZrJ9l7DOHtl2fGO/nWbKGndDwxqerhN4tNCmJdyeAxrERJgUnIsESD7GRLv5sTyiNZUFYL/Q6o83WhHTUDcr8qspLZco3PEGqcwKN77QIECw1OB6qIMg+q8XeliEr64NnTaFwf5M/YZOjUS0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739908684; c=relaxed/simple;
	bh=3OxuWdbeuvSQcWvt/iorxV/k1uQufx8Y4UZh318AGCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VsFGl/qMF+Q9O5YVzcez4/abBCL9wyNu3rZMI4cS+i9jo4pYUSYJfuEGxyF8TChiFZt9bESmgbBCP36fy++axGpSyJlKPfvBTkwKn5BWQEWeYZViucBLO7Pfb+xmU0McBC3xlJFprEW97A9hGO54mmUg16hEqp+Vc/VO8bDmbp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YvNCasl5; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YvNCasl5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJ7QuzVpwlzF+SjRERRaX7dQOw03DHGHHqh47laCK+rLIpIuNi4vsjbmQlAAI2SbKpbsROTVmr+I/5i0fkFReVMPgwOCLNMFEXt3JgECA5ZSanvKLhmi5FKSoqxtvFpzQ+KvgTB1PfTOObNDxApIdu0FsW9ou+NywY9S9URb7cothR+dIRAixS5ednLwHnODFC1r+/85BkiDwdIL9O9T/NsqvTwbWF4/r+y4mEBV79GpKHDCZ9+cm3nAY4/2f9IZ26Uz14OANd7UTfXtUXU0RQ9ilzGbiL7wHU9sSMo/YDiXUTvLS/5Fd+93BSfTmZwPTk/yXOxAZNIjX+R6bPuZ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nI9AAXp1OR9hc2LI4FKGIJtYhKW4ycZtb2lSkJ2bN8=;
 b=hF5cU37Bt5D+pftaB8yPtlTNNO+7u3CqFAHFY02BEZ9F1rcpq/BdpIYUp9hmvZg1hRvgjxqEJq4w20+gKAghDlcT2jsNZ1DhEWKeNGQoa9Uh/KnZoTuyk1jZVEPvd0X1182zGpR/Gfxd/8bevBhP0iZKFCLCHpnXTtZE4CH1Ptsm4TMtDLCCGlCnJTeyjGosA5ZeNOc+MWe1FgozRRFFRSv2gR73uCGyYeKxlDNbcgtrYADeCIXLIy8+Zoi++RP06A7aOIQlE3CpXIPxedASVNimHoxgPLm4YLhb1wMII5LSb8gTOwtkCh5iDv5d4Yw4G/kFTTSzOKiMCZUPLIbArQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nI9AAXp1OR9hc2LI4FKGIJtYhKW4ycZtb2lSkJ2bN8=;
 b=YvNCasl5wbMicy2f/L2iCXWwECkWGaCu9fz1sIIUDBQ07GGJ4YpvOM+3QkdBmRs+SxdY9AudVmuuWmubdABwDmoXyk15iGe2xBRR64eZv0shILnX03i5UQSv6dmEejqM1Ksz5GJHcYe5p7eXAvYochqLjf2ZrZ79QBsDavcdwCycxLjW1rcOvygb6Dqvwjrqu+xH4FYJezv2iPmPjpjFRH89Z7xF6+V9n783HHPHl2y4HMk499WcCgMV3Apg8angLYK5tad+kKCpKgzHSHjoc6FSynY++/F4BG5YMuPJzZ4M+sJkFyI42nNgHDZEXZ30qzA0sqFY37KUtoQR+fsFXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PR12MB7674.namprd12.prod.outlook.com (2603:10b6:208:434::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 19:57:57 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8445.019; Tue, 18 Feb 2025
 19:57:57 +0000
Date: Tue, 18 Feb 2025 15:57:56 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, kevin.tian@intel.com, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, robin.murphy@arm.com, nicolinc@nvidia.com,
	will@kernel.org
Subject: Re: [PATCH 5/5] iommu: Retire group->domain
Message-ID: <20250218195756.GG4183890@nvidia.com>
References: <20250212060540.261436-1-yi.l.liu@intel.com>
 <20250212060540.261436-6-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212060540.261436-6-yi.l.liu@intel.com>
X-ClientProxiedBy: MN2PR01CA0039.prod.exchangelabs.com (2603:10b6:208:23f::8)
 To CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PR12MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d663778-de05-45d2-d437-08dd505689f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XHU69jowJXpLr4nUyn9AWHE6LO91IC60xtxxSz68N6gxZtMG5MGRdBwil8yE?=
 =?us-ascii?Q?XRZe8PdirBXxvLbDVEhnJdhFFMySasstCwdDjPtehbYaMJGwq0C1jAeUdRhB?=
 =?us-ascii?Q?4neyrCPVpPBbfa+aaOpOaUZASDasDXkEPCKQvC849zWGo3nK+98dAYB/uVsG?=
 =?us-ascii?Q?ZoMAAHSdJDP5RWPaD0YiZ7bWhzMkDExrCOxIC2npHRKTyteI0FUdH9FZHErW?=
 =?us-ascii?Q?1uj54QWdTL8xB4593YVaLKzQbFoZ57GbV0+EgIqH/K9ta4EdymriWlyI5Ai/?=
 =?us-ascii?Q?vVuDt6JEImi4va8a6y91BeNqIBjWod+lxxeFMKGCuiDJYsHyrBM2v/gUYryX?=
 =?us-ascii?Q?rdh5QhKwrHggscfNnFCA0wzNJ9l2ixauonWMQSgqmKmTd8wZ0V7AAQuYMtXv?=
 =?us-ascii?Q?HoV1PctbtwmFsjthknf+Me6O3q2Tw5WFcewMXJJPQB/TvGf+Y8Z+fei056z0?=
 =?us-ascii?Q?Rvk3tTNREcBXTO9wZlmRiNDQ4I8z07G/1ZDPOuCq/Hj0LlP2Wd6q5zUofvsI?=
 =?us-ascii?Q?Blv07UJAgSMyLowGIQv8VAZ57iXzNguyEHhB7FcsBrbb/EQGwdnM7IHJp7oE?=
 =?us-ascii?Q?ntdO4IKdd5+Uso8AOMzckZKeZbg7VOs101QbvGFzEUimWMSAdG1qrx4TH7gy?=
 =?us-ascii?Q?TEilIM1/q0KJt9TQESyr6EOpvPV6T+E2pAGkGQ1oIw3ncT6aclHK+a00txmf?=
 =?us-ascii?Q?utZqonoXypx60atBMfYOhTMqVTvawOA7ZoiaeHpGrt6Z+XhdoL3GRURxdyvk?=
 =?us-ascii?Q?J0kzMaZh964FYRsfT7rcXjTXUjG03H7y91PcDnRFrnGjNPkWmLzmAlG6GPWb?=
 =?us-ascii?Q?WCtciVLGaLCKQ255R6mHwmdSngtb7h81pc3IPJRSLsgGHW0WyZVXHjM9zYGc?=
 =?us-ascii?Q?mZriv+xF73p2Mme837SIaLksLSfV9l0dl+LG7lPoV2Hg3ZEdZVS1omIxac7c?=
 =?us-ascii?Q?K2AHE8CHA2f3XQCHP3U0DXjKFMMfe3hOLOzBfcTQECrRk/T44W6WalenxMgp?=
 =?us-ascii?Q?eD09CFTmOzZ8Pi/vdJvbIJhPCsPK0fqiJtxL07VDicHCpUJNVKwbdk9+cHBV?=
 =?us-ascii?Q?6d1VPeawb20OpqvXWCoannABdVPKP+pU7tpH+FOzu6WX0LRSw6Y0vduQ//CO?=
 =?us-ascii?Q?CIPH/zPMx3sg9535MIxJan4puA3RTBrjqQAmKVOa9T92L8ebbpnikz2A8SVb?=
 =?us-ascii?Q?WhtUvTgEWdLxqSXL9TGvVN/ZPKrGnhyZHe9hixmSWiJittEEM/ZRCSeiSh0f?=
 =?us-ascii?Q?jkuJcBOzQ51RhE/woDIA+1ojGikOM6YKN9foKnwZfjxFglka5h0n3v4DT9k7?=
 =?us-ascii?Q?spjCTmzU7djFutQftCTXoQ3rdLQyrdJM3WEIRWN02RNihkT02EoJYcYiQSdd?=
 =?us-ascii?Q?8vIjl+JcRRYTz+e3i48VtGeIrXVW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uhFVVVAo8xWDnajA4hIxm8bqKYzBbHhjykQNLDN4/1a+i+QqIKroKm5cOIte?=
 =?us-ascii?Q?kLUEIE9Q1+hUsPRu7YllDgAOzK3iwIz5AwCfzKRrhHBismuklpA8/1N2lIoT?=
 =?us-ascii?Q?6IjNteWsgfla9DFBdPGJBPuLnuyAWG4Bzy21ehCxhhKMGsoWUZlZk6531sUb?=
 =?us-ascii?Q?dP3mF68anC0fg9BNUGutya/j+jjTBmMT6QihGUoa+cfiaH9LQIh/oDdgHgxt?=
 =?us-ascii?Q?uLqmCPPbihxQws23y00DSBIVx+8jzjK2iMqRwOWDgO2s+SlONSMTdx1vwFUb?=
 =?us-ascii?Q?URB+7UV3iKlsCp5vfWvvXHKKg11l5auDKzfoTlR9NogcKdPcQ+PeWOSNdglZ?=
 =?us-ascii?Q?kmsEw1M3hDWLQZ8bNC8qieqrb0D06C+ozqEhjY0qgtayP+YBzrP4lxWfrs85?=
 =?us-ascii?Q?gDLZAAvGe5nNV2GPPNmWtrY4pQdXhpD4iFsiEQ16CBj7+aS6MctEnTVPeuS+?=
 =?us-ascii?Q?graXrgsiVIBevKSGj6AgIZtAOQ0avoVxW07fS457q4/0Tx363JgmH6Q5Pl6d?=
 =?us-ascii?Q?0TBzEYB2jVlKYavVnuaRHEmCtsvP1OQpO1gFKvdtsN9V+WvSZxU4paq0vv4f?=
 =?us-ascii?Q?6NeQivMxmR+jcuj909X8JQcIQZpH7IvKGjPvoGXJJUqMIw2rDmj/wWoDOhhh?=
 =?us-ascii?Q?ZNJ89JvKGDD9rRPf4b7a1y1Z+ZGmdZCjA8yrSnHpvNlIu0yYQ+dIJgbqsfe6?=
 =?us-ascii?Q?UbyNHRdxkDxU6I0m9PjeMA1YCapk6LTBgCYRKJVXzJzP/IdvpVDl/0zm4WuN?=
 =?us-ascii?Q?PSQQCMS7EbH/H7l8jQvSSI5wIH0cD4pUNXXaGdTZp60nwYZMwIdXMXEzB77D?=
 =?us-ascii?Q?zlE5MFCuXYb7uT3/YKLdYxLKpU0qmGW9ti//5DRHQE2BUJsBGLBigWfc8fHp?=
 =?us-ascii?Q?5iEdMQxPHMMrSBMTXCaXStC4NYF4AmW8G/xGPkSlomTtKW+1othrl8o/1MY9?=
 =?us-ascii?Q?kXGxkwC9eejY9lNthMyxElpiOXm2e0sJZal12Y3P+OsSKCSbK0AfU/kXhfR9?=
 =?us-ascii?Q?DGX8r6TeyyqsWrrdWKcsaQikBH8NizpDXMgK3RXP8BLxklGyi7mM3/ZfQKFf?=
 =?us-ascii?Q?l87u3/Z5Egt+dghBWw8829GGPVInOZAw3+NIuHDRF8H3d3/DMMA/yKZt8BmT?=
 =?us-ascii?Q?BdU6leAD+1D78VCjRfq7M9uJa7O34MGlDBELo7Vlwqck09vz5T0zeDLRhLLn?=
 =?us-ascii?Q?deBl8BP/3ykKEkwkXpkdlZHgXoua8g11wmbRCaklPJivwO/OSH9NLVb6DJlM?=
 =?us-ascii?Q?TmgFQ+jac8FBuQFawWBuhkj75iBxdm/3royMzElJcH/VQPTu1aC7TUB3tOg/?=
 =?us-ascii?Q?QUx75sfAhSu2FIgSk2WJ2+B0Io6e9zK8+o3b1GML1P3D4XpPZoMhHycx3CU3?=
 =?us-ascii?Q?vKJbEzYyWPYc4wRgxXrEprAK5vg5cQWGfb9PlHXuRNaxgbyCSkXQbfEGfda5?=
 =?us-ascii?Q?qmAkcVt8JImiUPWV9UCuZawzf/oTLU3IS9k8uH2myryEw3OYYJ7Zv90sqSkS?=
 =?us-ascii?Q?fBPtpqUYRCUM7o/kxqTts1kI2wdObQlfgwWKi6+1iwMsJhCs2NYpZlQZCVIe?=
 =?us-ascii?Q?MNraWv83TvfTDDHwHn/umJLVEB6w36HFvm6NyHXO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d663778-de05-45d2-d437-08dd505689f8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 19:57:57.0463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jNLQIz56StinV7+KaSS3uAig/VnDmYqu/3rFO+DEg4cupzju1zfwLZguH8bsUNeU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7674

On Tue, Feb 11, 2025 at 10:05:40PM -0800, Yi Liu wrote:
>  static int __iommu_attach_device(struct iommu_domain *domain,
>  				 struct device *dev);
>  static int __iommu_attach_group(struct iommu_domain *domain,
> -				struct iommu_group *group);
> +				struct iommu_group *group,
> +				struct iommu_attach_handle *handle);

I think I would split this particular transformation and it's related
into its own patch, it would shrink this alot. It is principally about
sharing the handle and non-handle paths..

> @@ -563,11 +591,12 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>  	 * iommu_setup_default_domain()
>  	 */
>  	list_add_tail(&gdev->list, &group->devices);
> -	WARN_ON(group->default_domain && !group->domain);
> +	gdomain = iommu_group_domain(group);
> +	WARN_ON(group->default_domain && !gdomain);
>  	if (group->default_domain)
>  		iommu_create_device_direct_mappings(group->default_domain, dev);
> -	if (group->domain) {
> -		ret = __iommu_device_set_domain(group, dev, group->domain, 0);
> +	if (gdomain) {
> +		ret = __iommu_device_set_domain(group, dev, gdomain, 0);
>  		if (ret)
>  			goto err_remove_gdev;
>  	} else if (!group->default_domain && !group_list) {
> @@ -625,6 +654,8 @@ static void __iommu_group_free_device(struct iommu_group *group,
>  {
>  	struct device *dev = grp_dev->dev;
>  
> +	lockdep_assert_held(&group->mutex);
> +
>  	sysfs_remove_link(group->devices_kobj, grp_dev->name);
>  	sysfs_remove_link(&dev->kobj, "iommu_group");
>  
> @@ -637,7 +668,7 @@ static void __iommu_group_free_device(struct iommu_group *group,
>  	 */
>  	if (list_empty(&group->devices))
>  		WARN_ON(group->owner_cnt ||
> -			group->domain != group->default_domain);
> +			iommu_group_domain(group) != group->default_domain);

You could also probably put the conversion of locked group->domain
into iommu_group_domain() into its own patch (though not using the
xarray to start), that conversion looks like 9 hunks.

> +static void *iommu_make_pasid_entry(struct iommu_domain *domain,
> +				    struct iommu_attach_handle *handle);

Should move the helper to the top of the file in the patch that
introduces it

>  static int __iommu_group_set_domain_internal(struct iommu_group *group,
>  					     struct iommu_domain *new_domain,
> +					     struct iommu_attach_handle *handle,
>  					     unsigned int flags)
>  {
>  	struct group_device *last_gdev;
> +	struct iommu_domain *gdomain;
>  	struct group_device *gdev;
> +	void *pasid_entry;
>  	int result;
>  	int ret;
>  
>  	lockdep_assert_held(&group->mutex);
>  
> -	if (group->domain == new_domain)
> +	gdomain = iommu_group_domain(group);
> +	if (gdomain == new_domain)
>  		return 0;

This is not quite right anymore, we could replace a domain with a
handle or viceversa.

Probably like this:

	if (WARN_ON(!new_domain))
		return -EINVAL;

	pasid_entry = iommu_make_pasid_entry(new_domain, handle);
	curr = xa_cmpxchg(&group->pasid_array, IOMMU_NO_PASID, NULL,
			  XA_ZERO_ENTRY, GFP_KERNEL);
	if (xa_is_err(curr))
		return xa_err(curr);
	if (curr == pasid_entry)
		return 0;
	gdomain = decode_pasid_entry(curr);

> @@ -2290,7 +2343,10 @@ static int __iommu_group_set_domain_internal(struct iommu_group *group,
>  			goto err_revert;
>  		}
>  	}
> -	group->domain = new_domain;
> +
> +	pasid_entry = iommu_make_pasid_entry(new_domain, handle);
> +	WARN_ON(xa_is_err(xa_store(&group->pasid_array,
> +				   IOMMU_NO_PASID, pasid_entry, GFP_KERNEL)));

Ah, this flow uses the same as I suggested a few messages ago already!

> @@ -2302,16 +2358,17 @@ static int __iommu_group_set_domain_internal(struct iommu_group *group,
>  	for_each_group_device(group, gdev) {
>  		/*
>  		 * A NULL domain can happen only for first probe, in which case
> -		 * we leave group->domain as NULL and let release clean
> +		 * we leave domain in pasid_array as NULL and let release clean
>  		 * everything up.
>  		 */
> -		if (group->domain)
> +		if (gdomain)
>  			WARN_ON(__iommu_device_set_domain(
> -				group, gdev->dev, group->domain,
> +				group, gdev->dev, gdomain,
>  				IOMMU_SET_DOMAIN_MUST_SUCCEED));
>  		if (gdev == last_gdev)
>  			break;
>  	}
> +	xa_release(&group->pasid_array, IOMMU_NO_PASID);

This does not seem right, the prior flow left group->domain unchanged
here. IMHO just drop it, the xarray is always populated and almost
never has NULL.

Jason
