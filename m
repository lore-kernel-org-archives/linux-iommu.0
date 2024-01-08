Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF38579E0
	for <iommu@lists.linux.dev>; Mon,  8 Jan 2024 06:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lCk4F8Ye"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704696420; x=1736232420;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FLlzzDMh8/4Xw8Oj0xqYfDGeUWllBtB3XIQQ+oQZ7bU=;
  b=lCk4F8Ye/yO5cikOdN4GPGAOSspGPPCIekG06Ee/3HjqcQs+HWww3od6
   p9DJ3h66+s+EU272PW/0jeWH/7QnrO46JRa4n1uYQnQjdVsBK/zmfEPBF
   uKoNj35vBHD+WvGG8SVloICFfe9LOiduPXUJwMGAxjp5ft4zQYO2iQesi
   IWw5buIxUF328a2cfA39ZoSYYQ20aaIeorJzEZzVr/dg8nyNhPYcIYmJz
   PNL5GFjCMlHJTe+BQHynw2g4fQxJf4WignGKq3FO+dEiK44dUlZfVonjo
   3q39KM7n7oxWGjbqdiDdZElkXkvMuU7yHOpMKd7AOVdqC+h6mevscHv3p
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="396687805"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="396687805"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 22:46:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="904711160"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="904711160"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jan 2024 22:46:33 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Jan 2024 22:46:32 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 7 Jan 2024 22:46:32 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Jan 2024 22:46:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWOiyA1zuJbmUfX9bXk2VSKp+ZqQ1j4lkqktnHlkiy8GSEYoN4D9TorUyG9U30ygSUK8hu/EA+uaDCa0i3gXZb1eEU1jDFV6Ly9awDe9MnD6ksylnasWZrssbHb4sbPBBHjepEXW5Jr0FBZ2PXD4bjgL8jLb/Gh846dzUThAeQwiC6B+K6Aq1BIA1l8xUqnKp1Eu9CO+bCjPs4KryOPy8L3y+jYQja7oxc1aXgxZur5oMKovvT5AcnF+rxhvSAidg+5xX/HUn/Dx7tVi1XScuhkGbfTqE0hgbflB+u9ePT2vLW/V6ISLT50T+OEP8dZ/Iaomrb60j21WMYf7QL1JXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqnLzn/a6qtq5DI2/hzi9cQO3YV4ezRhbI2jUws8ZaE=;
 b=JbYhLBIXu6g40id/Ex9txBMs1Sq5RK7fsy4wwC+zfowM1mJ271KMz94ijZgLXXIk8f9928MEQuwLF8uuNc04QmqPin7yT0PsY7HoKugUA2o6NdfgUhsgFWd0FuSCDFrTpd7e5hnx/czgg1i46jHRDUbXO8j3KpfDX6VTMG3njs4OUzOFCbMdsT3uKovwmPkXm5PLRHFLUWpwgvCTiYEvxoXt8NifxMSVEeCLmQPHMsLVeIjD+HE+1/PdTLD4s3Ey+ty/mjKKP60XUaced09YH/n+eNCKOVJaFq2EZn5mE8uUoSExotmSb5LjlxmPe0QvxrW6foYK4Q5OL9anxyMmrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by MN0PR11MB6110.namprd11.prod.outlook.com (2603:10b6:208:3ce::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 06:46:30 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::1de8:63f0:d4aa:ff6c]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::1de8:63f0:d4aa:ff6c%6]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 06:46:30 +0000
Message-ID: <51ef352a-59e5-414a-9f0e-d32de3b10cac@intel.com>
Date: Mon, 8 Jan 2024 14:46:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/14] iommu: Add ops->domain_alloc_sva()
To: Vasant Hegde <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Jason Gunthorpe <jgg@nvidia.com>
References: <20231221111558.64652-1-vasant.hegde@amd.com>
 <20231221111558.64652-14-vasant.hegde@amd.com>
Content-Language: en-US
From: Tina Zhang <tina.zhang@intel.com>
In-Reply-To: <20231221111558.64652-14-vasant.hegde@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::14) To MW5PR11MB5881.namprd11.prod.outlook.com
 (2603:10b6:303:19d::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5881:EE_|MN0PR11MB6110:EE_
X-MS-Office365-Filtering-Correlation-Id: 5affee8b-90d6-4f44-f85b-08dc10158b7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FY2mm74OJyRvcUpoRTsgxQkk3dSqXW2vp1hnv0r7AF8l5LykfhqW96gC3Mdo6giYR+ScX6R6eTV+sFlZi3t3qLGcPHdZ3u3D180ty5utyye+HePONHh254CUX93nG5F26WedE8rEXJ4IWWkY7pD+cqLbEHRaaajoxi4+q2QzZ9Z0OBRAkcdzFA7YGz0S+ks9ZukuS3e9uCAXgXmhPcyjI5IpYprR15bGX2mwAE/2alxku3laq/sPpPOw2tebkACl7HMbZDB8YL+DSJH2jP5grd9pfQYYClqMzyhenP913BYHIokq7tbptjDDFBpbDg1fWmej2HUjk7aqJuXyI9C3u+MArkGfF4KkwxQEpTsVDTo+HeF4yLViZkhrsjy8aQJx2uCJa45/rX16qUsi6p0V7t3SIcW/+vWCPr1t8DH8RYK3bOrdhqTa7u1DApiFSvcgZz9RW/uDig13umcZWulzbpo2x4C1ulhzsPXVtTKFdMMwwrwoSF9Pcm93GkFv6EZIenp7nFqxbkkmPqIxMKppuYvorWDSpX6tTmsJtNf5K+AB32UQ8dHadphiz5Z7d0BW2875i6uXBHnVqDVLMavmeRoTqm4DSF8H5zKoJU4wmIwu3Jw2e9YTACJG6qZ37jC5bibi8Kh/VYlIfsNhgR0gJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(376002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(41300700001)(82960400001)(86362001)(6486002)(8676002)(8936002)(31686004)(31696002)(2906002)(5660300002)(2616005)(26005)(36756003)(66476007)(66556008)(66946007)(316002)(478600001)(6512007)(83380400001)(53546011)(6666004)(6506007)(38100700002)(44832011)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlFmNGdtZUhhYm9FL3FNQ2J5YVNxZEM3RjFCcnQ4SEdBcFdXUEpQNFU1WUtw?=
 =?utf-8?B?SDFIN01rWVNWSHVvRHVjWTh6T21tVlI5cHk1dDBGSHNjTUR4YU5jbGdtY0x4?=
 =?utf-8?B?WXRpK1FQWTFnOW9PWjQwdWl5Ty8wVjk3UWNQdVRqeHlNY2FNb09KZy9OV0N6?=
 =?utf-8?B?SUpxdkRKbEM0VTRmR3NWSWExUUdmTkxNWUpwZVE0YVhDYTlFM1JMbUZVZkRG?=
 =?utf-8?B?Q0l5d0xTR1grclZyM2Z4SUsxQWYwL09ycnA0VUF2NUNRL2pLM004UFV0MERz?=
 =?utf-8?B?ci93c1FTQ3kzL2VNTkNzcFlkdldXSXdablVPVnExYlhpaVFqZ1NHV0NlYXVQ?=
 =?utf-8?B?SmRoR08yRnR5NVhaMWFleDFuNUl1Mnk5RmJGVk5sbFlUSXhMbU93d1VjVFRz?=
 =?utf-8?B?Y1VuNUc3SE0wb0M3U0h3cXRrVlJ6YldqV2RvbW9Ec2FRa1lKNGVPS25WV0xu?=
 =?utf-8?B?aDVMY3ZuVWhtTlpPdTFxeUU3L3poVlFOMUtyVjRYMHJLblBrNlV0aXMwVS9K?=
 =?utf-8?B?c1E3c1B1VDdsckJrVGlxWlgxc0JsMDlERkZUZHYrMXBxSzZoalhKRDd0VWJQ?=
 =?utf-8?B?SWRET2J6N2hIL1pmbk5CajFuNC9NSWt4QzBPNGRaa3UwbXVSUmx6QWhHQVBM?=
 =?utf-8?B?S0haZlAzenZhUzY3Q1kydnAwaUFjOHp4OXhtQWcvZ1h1TW9NL1hnUDNoYzEz?=
 =?utf-8?B?UkVwcEdMdFdKVXhaTzlUM053YklwNXlmd0h3WDAraVZWYTQvYjVjb2VLWkNX?=
 =?utf-8?B?dWFOMjRiR2pRNnhIN0FNRWM5dEhvdlZ6R1NrT1UrWE1zT2tUMGdYOXp0eDJ0?=
 =?utf-8?B?c3QvZHlPMWYvajNwa1NPQkZwZ081R05WcnJnZWwvSXZHNXdZNWhmWnQvNlBh?=
 =?utf-8?B?RjBrRE0reEFlZlJZK0tXaE1mYm0vbDd6RmcwVVVacWNMMHUyTFhTbVArL1B3?=
 =?utf-8?B?YWJYcWJRUGRYdWZ1RExrUVpucThQOU1RZ3htdXhNR240eUVXTGdiam9RdzYv?=
 =?utf-8?B?eDJDc0xWUEltUk9XMzJqei9PT3JockUySEgveTE0U0o2UDlSa0lpZzlkZFMx?=
 =?utf-8?B?OU1NYVdUMzlYT1lqUWp5MVVWZWk0cGU5dEt5SFBtTk5OV2JkOUtJMG5hdXho?=
 =?utf-8?B?WGxXT0NjR0hybjhMcHV4NUM1U21WYlVDcFp6SmpiV0xWMnJqb09EL3BxVmxr?=
 =?utf-8?B?MUpJNVU1NnlwZWswemNBQjdCL1ZoVk94L3RNUHNJaUI4N0ErTFNYZDdNdWVD?=
 =?utf-8?B?dytPNEtzeHAxVlpVajJQRlArL0MwUmYwODVGd0VRTDdPVGNCaEJIcEFCcUtq?=
 =?utf-8?B?dnpYNTcrcEFBRWZvaHdQWXo2T3ptY2F3R2dDNnlvKzJqWFFrMGxzRVlWNGlI?=
 =?utf-8?B?azZWV0NMVUIwdVNRK3VCeFFDNGwvbFAzS3VXRUcvWGM1TFFEYWY5V2dSTVJN?=
 =?utf-8?B?bWN6alZkT1gxMDJRN1ErTDAyaHNVdDVoRjR6QWZlTWxabG8wVUlFOEF5WjdY?=
 =?utf-8?B?T2RCa0lIbG5TelY1NWNRTUx2Ykp1U09xenVTQXprN1BMVmppQ2VVYnVRdGVo?=
 =?utf-8?B?dnZjYTRSOWJBWFd2RmpuTVFwREU1cGRMelV5RnJZb0RVN295NUtud0MzT2t1?=
 =?utf-8?B?b1RaOTAyYzJYWEUyVkE4SzY0WVNLQlpnSE5CM2JaR0xzYlQraEo1ZmpwQ3hT?=
 =?utf-8?B?cThyZ0N6L2IvT1dabFVxMUFkWGxiWFZnQ2VqSmoyYnVSR1ROMldwUFNwbU53?=
 =?utf-8?B?MS9FMlYxUjJ6cVFIZjYvZzlkZ3FPTUZNM01CSVVFakgwaXBOanpXU1BBR092?=
 =?utf-8?B?L2JRcDRGdXVqd3V5eVQ1dUFpRTcrT1E2VXQ2aVpuaE5ZRWRzKzdhTmlzVERv?=
 =?utf-8?B?YTJMUTRvTnFyRS9BVEFXZmd0c1B2SnVVY1c2eUNYUlNxUW43UzFEdGJEK0Q5?=
 =?utf-8?B?ekxvTTZrN0tlaGxZTy9TNGlpb0hoZ2ZPd0ZYMzJDYnAzTi83dXF6Ukc4alp1?=
 =?utf-8?B?dzB2cFB6MWRiVkZCaVdkQkl5Tm5EODJFeS9lUy96U3dac2taODFYZzR0Mkxu?=
 =?utf-8?B?RWNhMTk1Wlhudm5LNzdCSGgxTDJZTXdsWEZJSy9vYWd3YnhRRFhKTHpYM0FF?=
 =?utf-8?Q?mTdiu8JryK7TcTb5uvADu56Fw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5affee8b-90d6-4f44-f85b-08dc10158b7e
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 06:46:30.3438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uSQLiJd4wcDA2mPax45ilaDc+61QK4tvpWUASL4tMvqwvbI1I+hNNYY1fNTxCjvkz8IpOwx+oS6eQM2kCyOMDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6110
X-OriginatorOrg: intel.com



On 12/21/23 19:15, Vasant Hegde wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> Make a new op that receives the device and the mm_struct that the SVA
> domain should be created for. Unlike domain_alloc_paging() the dev
> argument is never NULL here.
> 
> This allows drivers to fully initialize the SVA domain and allocate the
> mmu_notifier during allocation. It allows the notifier lifetime to follow
> the lifetime of the iommu_domain.
> 
> Since we have only one call site, upgrade the new op to return ERR_PTR
> instead of NULL.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> [Updated domain owner and removed smmu3 related changes - Vasant]
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>

Reviewed-by: Tina Zhang <tina.zhang@intel.com>

Regards,
-Tina

> ---
>   drivers/iommu/iommu-sva.c | 17 ++++++++++++-----
>   include/linux/iommu.h     |  3 +++
>   2 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index b0e069562bb8..0d78d7c92d79 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -99,8 +99,8 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>   
>   	/* Allocate a new domain and set it on device pasid. */
>   	domain = iommu_sva_domain_alloc(dev, mm);
> -	if (!domain) {
> -		ret = -ENOMEM;
> +	if (IS_ERR(domain)) {
> +		ret = PTR_ERR(domain);
>   		goto out_free_handle;
>   	}
>   
> @@ -270,11 +270,18 @@ struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
>   	const struct iommu_ops *ops = dev_iommu_ops(dev);
>   	struct iommu_domain *domain;
>   
> -	domain = ops->domain_alloc(IOMMU_DOMAIN_SVA);
> -	if (!domain)
> -		return NULL;
> +	if (ops->domain_alloc_sva) {
> +		domain = ops->domain_alloc_sva(dev, mm);
> +		if (IS_ERR(domain))
> +			return domain;
> +	} else {
> +		domain = ops->domain_alloc(IOMMU_DOMAIN_SVA);
> +		if (!domain)
> +			return ERR_PTR(-ENOMEM);
> +	}
>   
>   	domain->type = IOMMU_DOMAIN_SVA;
> +	domain->owner = ops;
>   	mmgrab(mm);
>   	domain->mm = mm;
>   	domain->iopf_handler = iommu_sva_iopf_handler;
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index b3b48e347c3d..0b18f1bd8b8a 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -450,6 +450,7 @@ static inline int __iommu_copy_struct_from_user(
>    *                     Upon failure, ERR_PTR must be returned.
>    * @domain_alloc_paging: Allocate an iommu_domain that can be used for
>    *                       UNMANAGED, DMA, and DMA_FQ domain types.
> + * @domain_alloc_sva: Allocate an iommu_domain for Shared Virtual Addressing.
>    * @probe_device: Add device to iommu driver handling
>    * @release_device: Remove device from iommu driver handling
>    * @probe_finalize: Do final setup work after the device is added to an IOMMU
> @@ -490,6 +491,8 @@ struct iommu_ops {
>   		struct device *dev, u32 flags, struct iommu_domain *parent,
>   		const struct iommu_user_data *user_data);
>   	struct iommu_domain *(*domain_alloc_paging)(struct device *dev);
> +	struct iommu_domain *(*domain_alloc_sva)(struct device *dev,
> +						 struct mm_struct *mm);
>   
>   	struct iommu_device *(*probe_device)(struct device *dev);
>   	void (*release_device)(struct device *dev);
