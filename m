Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACA12040B7
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 13:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741095680; cv=fail; b=hb0iPNqXDfeRGqceU7vwocqia9FNX63gNTJJuIMCW0jrEZhqMA9ajp4XIHSp/iJ0Ec/fM6le8E9sJW7ccnqx625epb0N98bBOsf0EEa2kSuRKC/O0y5aXR2bvTgmbu0EFKJRf6b7JTeh7SE1Zpz2kV8KVuwE/4YbOnxiDGs4t9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741095680; c=relaxed/simple;
	bh=nZ0ktepstYR+i2Zi3sVHNQlSx2V5arbRGHErmlxz1SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M+8RY8OkQo1kJpYIEfpx2qmEsMT8vmSncupcrqBZvIjcemvl/cu/u7s66CZIkEJr8LIgXJ6alwk4Xn8JCdoxj5klTB+QwS0z8qjkt7DlEgA1XCGJbHfQxlQPBiX06oq6oEAJkzAN9455eaovtg2mVoVIb9SSm4uCrktfripAnps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RGkiGMc+; arc=fail smtp.client-ip=40.107.236.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RGkiGMc+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VyGCT8YtQfgqmirLeelif9+yP8lcp6cf/Nf5GW3NVJKF5r0UPHCucwkw7tBsjq8J0r3vp2GFpWImOvLWmLEcmSoIBMxM/09zOArpsYcM98sgUf2Q4K8nFvdIYH0theiQJuG/1vYrEY4PMKBRwAVgqRBkbFBpCbIZjYSwZKDwFUf0ca4Z9WlALExa14eeCIRFdJk/aiEOZw2SuNT2hYN9S0oYQPMNITK0d4yQSI5/bA176yfh7bEaE15dioxyh8UMvclq4TQ1ooN0ne66uJsGXQuD1jiMPuAs6CMAV5eBtAMkwsz59Hvg3vCbb0iHTQIicwPTdWoTbAp/AHRFXKxepg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OFDpUVSXBzdgCpkoei12psezyA8U2cezzz9B6LKuZc=;
 b=nOrzpgBWugsz6o51VIb6+GhwbIktsNZBD+YrryKJj8+Qpi7EMXd1zC56w2PaYnxtl3zUXkNL4IM8fb01cOdtJwU1BDpsBsXEU7/R1nzHTpM8dvIWuxO2vqlgR0FGZAdKI2D53N6P843WoRXXpJnLPELDnXKydEz1Ce4LQgjlx0D94/QeyKFxp4q8CG2vf6MbZjVtg9+o9Pk1ldRucZt7FzNifU2l4DEk1kNZQyfHiDZOuxfsbj6msfHe1Htu36GeO6fG/4cN2PMpJ2Wlj/FwmkIyVt1hnCgjwM1MAZul6Lu0yZewocP/inNBPdZb26MHPV1gRQsx0UzcVm6H/i2vrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OFDpUVSXBzdgCpkoei12psezyA8U2cezzz9B6LKuZc=;
 b=RGkiGMc+Yov76O9fMg33fXU0boOiaHG+0r5X7z8l+Obycj3l1H/GP7Z4rHOZeo3Mc2vBvZm302KBeBnrz4H9Hm+NFHpbwRwU6KWFHxhjYsKtUw6Qx6gxAqjQU/uDPaeHNVP2nB1EcwqPbC4hLmF5Ere14S6Iu+MjOHW2EY0wqNchg5ftRXkuBdsLy/YG3ADKXshMXwJB6BYV6ukxFNURY63D2IRWoWLlJj4BKZb2LkjRs9XxXw4DARxxSbJ/y/CePgzFSZJ7FpBXyWPZBWCfTR5BBEKRyp7fDj16POaBa0I314e6OG7PoZgiWL0Av6n6ORZOTl0QJBne4gIm81UrqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB7203.namprd12.prod.outlook.com (2603:10b6:806:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 13:41:15 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 13:41:15 +0000
Date: Tue, 4 Mar 2025 09:41:13 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommufd: Fix uninitialized rc in iommufd_access_rw()
Message-ID: <20250304134113.GJ133783@nvidia.com>
References: <20250227200729.85030-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227200729.85030-1-nicolinc@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0300.namprd03.prod.outlook.com
 (2603:10b6:408:f5::35) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: 150508e1-da3b-4337-5f22-08dd5b223c57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w/+zoysdgHHo1/DhPXtEN+ZsSrIYKxRbAPnenMAYfQt0JgImn1Ic24uoeoeS?=
 =?us-ascii?Q?GYdHXfzZ/NCPWHpTklE8i4BXi2Kxnp+M+W2YsGZP1bYMbr6tUwSQA7x6DWH4?=
 =?us-ascii?Q?PAO9cAnCEv6ZLyoxaoorKD5gBcVhWC5ZYJtCg6wFYOb4Q8rikzTegZA1jr7/?=
 =?us-ascii?Q?MLUlnhMyExKrMmUU1QpI/8h2qkYPCLQJgKdGCEXg59fH1mpZ2uU+jA/bVwI7?=
 =?us-ascii?Q?naRBoCoh/dPLpi6VRvRi0Y9j2pdnovajuUfiDyDTmnsbXMq8xUoLcxRbqmzF?=
 =?us-ascii?Q?DcuIkDcfId6dqpUnYVhRQNztgrz3rlvsSk8+WcmIn5E5rcD8YvmAZe7eHI04?=
 =?us-ascii?Q?X1fgQ0+5t3+ob5P8l5tp+GkqZS484afD6F38OIQXAHCk7Pitk3NYGi0H4Lxr?=
 =?us-ascii?Q?hDRHyB+CTczerVFaDKJz30/H7uUxQcpJoIWWjV3PSUoI1gQvxV4VH06P00Jc?=
 =?us-ascii?Q?i1xpVdgIWGYw4lAbnpVvdR+XeKW0iFiFBw8XH86cX9SH6HG78C4h8XRIJU4z?=
 =?us-ascii?Q?e1wsnkRKdgq2yhKU6Gu8RlqHWfXeJQWabe34qy2nuYYNcYL6lAQGFyE9v9oy?=
 =?us-ascii?Q?/grWEtBiGROUxRig+8vVFfYwaNrU+8npmjoUMphEt3NxksBmdfIfJLuVn4YD?=
 =?us-ascii?Q?g3/vXyRolnAVj/HICUO6b43kLfw1D1jV7JVY+lD3dEjKFPMQO6mzl4tlwVyN?=
 =?us-ascii?Q?EH6lHTnI718lqrzW9o884hCdcyv/O36snkA8MdXB9npVysj118gwaEGFCuDm?=
 =?us-ascii?Q?Wec1aGmkz2XRStOHWVCK4AaupWaOBHZhAwgQWoF00nkg4u5JlLDlB57SIF6B?=
 =?us-ascii?Q?jzmJMA7ichcF24pRXXL1+cNZs0EGeCa2LWRG//LMGVPwG2bf03ys5MNISC2B?=
 =?us-ascii?Q?Cggg8NR2i5g3pArPn4XvZMBJ2uSu+23jJ2cyQJXN79apZM2c+hryhNCKRPbf?=
 =?us-ascii?Q?O7+XgQGO95+S9XgHG/8JE5zoBedxbg9ZtO0KX5udsWw+4e8Y/imjRuEcEvXu?=
 =?us-ascii?Q?ngtZvhvVb38EukH0t2fknwUEP/ML48r/6lvO7HK7j1Vc3uRzHzqpcNzo9QFm?=
 =?us-ascii?Q?7V4NGQSYWQvRJrfgEoIp51zqxqoyyXM1kd68UhNhG3YVepyBofJ1kfvas7MH?=
 =?us-ascii?Q?O4cV0tYSEPL7ip5U+WzbeYStMba78pD4vOGhiQiZYkpm1XGcYDWbtMhCDrgm?=
 =?us-ascii?Q?LR4SSwBPf/KF4vIpUuTP0FzIPLHPzh0EedNrKzdyBlV2RlAuz6t1CUMkSo9Z?=
 =?us-ascii?Q?I17mWarBdQNaVRcUQPpC4Y0p/c6iWg6+GjdvJB+qKm5thPVmbZsmkQ2h9PKF?=
 =?us-ascii?Q?7+hTBdD+U3PQLYzh1FgHCak6JBPRF/B0CQT3B6a1rerb3sYVqUDYpUaHaA03?=
 =?us-ascii?Q?lM6gJuJioRILpfTHEJUadoR8M5m1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dvqyxZqmCuZn8AOrCkt5jtEHwXeARz7lzvLWu+Br5sOnUsyorWemsgE+BQ6Y?=
 =?us-ascii?Q?xnT0XIaD4DijhyV/hmAaggEurcd8/Kpe1Qz7TcaFujCe9xj5IQhMdIDQouQ4?=
 =?us-ascii?Q?22auxy3QfvVZ6RZrwHX23NYmz1TRwCq0eS8uzY3CkBnov3esx7E4km0/dDyn?=
 =?us-ascii?Q?n435pqaYqJjI8pl6QjdnWvAgHLH+QF8euuOOl3HmX/fLP1+LKPia8/VPjmDz?=
 =?us-ascii?Q?HuhuEQyxJKwuszLmw+KeswGEjwM9syiZrLCa5CCWTJHU/7SQJ8jDHsnRiA4w?=
 =?us-ascii?Q?c5e2Vz6rU+S9QoKBzAfXKHtKqOjk+Ec0XT7x+nmqvw4tnF0YqSiRbW6xhFq/?=
 =?us-ascii?Q?ERiK5mnQs9cyWcxPLSkuLYr05vmwHGSeGTJ6CpL5TKTXsGPh5b99v6k33Qp8?=
 =?us-ascii?Q?eQzXXL1z4eFnVeTglLlEDk9pMoX3IRsQU+NskM7b1ZzzFO7XbKQgjwgo7uwx?=
 =?us-ascii?Q?lHLa5FfACnSaEzlRlkaR1IWOIMgyAIQHjc6M1sPWdXk8fkXlneGzEph7oJe2?=
 =?us-ascii?Q?Ug7cVkkONJ/aGKYT49QFYv9Oxsb4SgO6CcmrJ8d1Ng1E92Npvnr/bzbnbmMh?=
 =?us-ascii?Q?mL2ditXuGfniL2HzaAixbSEDFnAjswadvRBtzHkLoaK3dtoMB3HUC6+G4Wfr?=
 =?us-ascii?Q?sZ9h1oxISODqFz9GwP4Fjeq/Voci7Vrd0FMYOvgDsifin2+FdultSbx2mZd+?=
 =?us-ascii?Q?eqQv869643wGKKXrq0g2XUXWFs99645AUaZVsfZYcqOIwNeZxtqR1IzFbVrO?=
 =?us-ascii?Q?HKV2GM+OXRWu7M7HRtnltElb7nRhyFoRsbuHtNj/2kVWnMOrehvxsUgw0fUM?=
 =?us-ascii?Q?vQz66J1Spf8YruragLOkXfIe7jnPNsdyYCzK8KDFE7yFpug2l+bfN1EfHret?=
 =?us-ascii?Q?y3dshskahU6cRqNxrapqQDrxHFpoaMNnngG8kKe1JT6qJMrhwidyVwsxht6F?=
 =?us-ascii?Q?/3/GtV9N2aRa13dHsV3/Iw0AoG58KQu6Z2HI8s4ojeAld0tTlcnqNO5OoK3a?=
 =?us-ascii?Q?CmjTKV8OR0scxXAmkOHrQZ0WtaEn7oBrWasa1RqbL0rtfZAM6BS8kS9SzG+b?=
 =?us-ascii?Q?aCwaSEQwstzbqCLgMzQwFmI0/oKTUj0pkz/fESPOTHepEalbC/4FoYGgeqJS?=
 =?us-ascii?Q?ThVHXyfGAGKPUdNSMUreFsr07Hm9SR14KsU3soPnmpHjFyl0ui/4Is/LbIkl?=
 =?us-ascii?Q?EsmGSozN2gfeEdSDNQzd4Ui4NJ3MiHqGMlODMNzZM5EcPbg0FnAjlvYfdaFa?=
 =?us-ascii?Q?B/hkIm7+ea9RnRCw06dFLvcQ1uWrDGKlD4Mi5BC7atCLDEP54QkGAeMeS749?=
 =?us-ascii?Q?EJy5COZuN+6HSaH2rr9DbWdfouro3hufCFNJhOen9z4GYhJ2D7TFONv1Zwti?=
 =?us-ascii?Q?FXQai5gRwD6T8JQaMxSrH3UWTZ6pZVOmBPrSLyvxAC0ROyg99S/MYNGmh/i1?=
 =?us-ascii?Q?HVWuU+MtLcN0xKYH5/ZXtyobpwqPs/u/Dm3W8uDEbXVoUYtODnrtiHbyDTg1?=
 =?us-ascii?Q?vYQ99TDIheJodj1NSUz+P+ezSeeB7iXblWYbLFrC+tHAQ3qXts3OGpdRFPjd?=
 =?us-ascii?Q?jjJwzyy4r+srm5ecvJ4mx4NnyQt8J8jzyIweCoc5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 150508e1-da3b-4337-5f22-08dd5b223c57
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 13:41:15.7851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kHzKiBV1k9wvQW6pL0pRp8fDmJoHpQJ881zmEG9jYaCwLhw9Sn04SzSApRWTd39c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7203

On Thu, Feb 27, 2025 at 12:07:29PM -0800, Nicolin Chen wrote:
> Reported by smatch:
> drivers/iommu/iommufd/device.c:1392 iommufd_access_rw() error: uninitialized symbol 'rc'.
> 
> Fixes: 8d40205f6093 ("iommufd: Add kAPI toward external drivers for kernel access")
> Cc: stable@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202502271339.a2nWr9UA-lkp@intel.com/
> [nicolinc: can't find an original report but only in "old smatch warnings"]
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 6dccbf7217f5..b812ae40f382 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -1348,7 +1348,7 @@ int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
>  	struct io_pagetable *iopt;
>  	struct iopt_area *area;
>  	unsigned long last_iova;
> -	int rc;
> +	int rc = 0;

This is a smatch error but it can't actually happen because:

  	if (!length)
  		return -EINVAL;

And:

	if (!iopt_area_contig_done(&iter))
		rc = -ENOENT;

Prevents an empty loop for iopt_for_each_contig_area()

And each loop does:

		rc = iopt_pages_rw_access(

Which will zero rc.

If for some reason rc was used uninitialized then it would be an error
so it should be rc = -EINVAL. I fixed it up.

Jason

