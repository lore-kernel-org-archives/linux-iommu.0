Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236FC15B2
	for <iommu@lists.linux.dev>; Tue, 20 Jun 2023 05:11:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGysnu7u1GzHDwOvjInXO/Ow8WQTcuf+2sFpNnD7Ih+WucAbzkdpRU9z+mJMXG2afZ0PYIYJL5NliXT/oWaq8zcbYm1J1iyDsP+gTQwcb2GjuitFd2c0Sb8Rra6m8T8sUyP8stNnVpNnMzajcjO+q7/it/YQBlaFvVWpDAZXP77j6PL+zzKi165ufs2JlgZ3OkZ6cxrl+5Q5PDridT/eSwn0o7AfNmVnoLy1TRdGFKVvtR+pywcBebTVZe4ol08udaopcUM3d9jL9/Us1rWsTk0xaqryfrTMke33aeVcZU2uAdQzOdqenK4Y30ObjoSg9TcTXKdjIQrelT7dBT9nXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amy52c5vocDPDc+44T/K/2rj7fDYiay5icaC26fKrmo=;
 b=K1UTeB+hoGVXbtmXHlImGScclRHOHcsMXytDHIQ06Q2TeaY80rUSDMYh98/8Bng4vnSSQCIkJvrhAJ07J/pKXyYD+aOKQ8Apr2UcDQZ6RRGKqpU56vxtWsX6jaxNpdG2SpVeK41PGxIImWU+ae1VHlDgS0NXFjTpd7HHdZc2yovzfJbTIC/voEzX5Jbz19yaaQMAMSombZjSK+Wh1yBd6wk6KKAn6ZFtvGl2VMMcjT6FEf5H2MFhugShGC7JKO0qAZx8LJ0/Mx1/bPh2AcTQ1Gh7YRU/KcVlxJN3Ioer+xbMm9pUSfff/7NPsu9c/k7LY8QY0kPCvLMef4/R/rZjCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amy52c5vocDPDc+44T/K/2rj7fDYiay5icaC26fKrmo=;
 b=lCom8dtvkS71mlQhFPp79nbRb40u6tx+YyCPMyRQDyAZ610xA2l7y3XjDtbeKRVHtek5Mk4sqy+8yMInnxPjvXmZ7VbufcfqXizMZOEz2AiKByz3FhRxzd2vQZKCNNXS9u7rUGv9HvyBjBeWdoOFgHARyBz1AvgxQe5FK1SEOZg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 BL0PR12MB4994.namprd12.prod.outlook.com (2603:10b6:208:1ca::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 05:11:27 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::7cbf:236a:55b:2c99]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::7cbf:236a:55b:2c99%4]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 05:11:27 +0000
Message-ID: <43ff556d-4a09-59ab-9b62-71e3a84241d3@amd.com>
Date: Tue, 20 Jun 2023 10:41:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 iommu/next] iommu: Fix default domain setup
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 baolu.lu@linux.intel.com,
 Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
References: <20230619084945.6427-1-vasant.hegde@amd.com>
 <ZJA8kDBSuNfbMPxr@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZJA8kDBSuNfbMPxr@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::18) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|BL0PR12MB4994:EE_
X-MS-Office365-Filtering-Correlation-Id: a4a85765-349f-4902-cefa-08db714cccdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mIih0TCYj6Ltt/ucNtq4/mUNm/+/xGOGsnNM5MOf/koE72eTO5dMIDUGZXbe/vKUruPLVndQ5V5QGh3jKu2ykTNSliik2SksY2Fq0XZ1Srf+hcfYPpSvaob3oOjczzsSPKfp2KKdeevym48Pc83JhFrmwlkTlS2eh5oYBmUJ/FaWTxnJSOHDPrlqbrOTCjFrUSIhNMApmGhS9lZ+GHaxF/et0D5tIeAGnuUmtxyPXlwgaKbKt7k6DWmS+2CDWP6U+lQ1qy/qaVfzXY8DTmiIPex15S9x5jjqXAXIdZ6TNfj2fkdSM+Ssqa02S/DUdaQt1DMX2etMnQq4L1wDX718NTOCqfvDpFu1ufq7fKCzrdW1F/1UGaSIxYabcL+c+diSoxgd9dvaeKp34B+KyCJ8/lZQELapQjH3+LcIWVfA7Z3eFRdP40Amiu5FIaz9YOXLBVpLn+ALdP3TaDzJUSvSkFKBlKbg99fUBLqeve9SpeCKedYtjUjrGpBA2R/CAhIIUFyAhFZCGtKpHF7lJnmp7amdFLsmnj7fn7cHez6ohW7/+sSFu48nh54v2WMVsptaAtGLSg4X5BWp6DLTka21iRI5TOg8+XAuAipxdYgIKZ2gUq8Mo3k2kX4YYBzh+sfK4j+NOymQWJ6H5wM7YDcUww==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(451199021)(6486002)(478600001)(6666004)(83380400001)(2616005)(53546011)(6506007)(6512007)(26005)(186003)(2906002)(5660300002)(44832011)(36756003)(38100700002)(4326008)(66946007)(31696002)(316002)(86362001)(8936002)(8676002)(41300700001)(66476007)(6916009)(66556008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnFSZUZOelA1NjNyWEI2WnFVK1lKQW9KT05wazNMWWtqa3oxV2NuL3IxQVpY?=
 =?utf-8?B?Z2I0TnVwMW1FS0ZHYVYxOC9ZeFBjYXJJVXY3MnhUTjB2TlBmZGpqRExzZmo0?=
 =?utf-8?B?UEtMajdidzFDZy96UUxCeUNEYlNocE1rT0hNcWg5RFd6ajk3UFczMWU3MEFa?=
 =?utf-8?B?V2Q0SDErVDRvNHllTVpoMnZVelBhK053emd6cERFYTM5bE40U09Yd013akZ4?=
 =?utf-8?B?aFpHMDFYQWVCVFk1ZENxZ2tnY1h2RXlwMGQ5aXptcG1kWktsUVFkZm5IbXR6?=
 =?utf-8?B?MEx5bVRVdnNGY1BERmU1aTFieWdCVURFOXg1UnNjRy8wOVpKK2IvNE13Ym1Q?=
 =?utf-8?B?OWpXM3pYT0x4NGx0QzdCdllvTGFUU1FKSXI0SVlYTjl2T0t4L3ZaWFBKWXNy?=
 =?utf-8?B?RGd4QWk4NS9YWTRudk5SenNvQzNqd2ZFTEl2NElGY291U2tQeHF5VS9XYkhV?=
 =?utf-8?B?TVlYTjdLQ055V1ZseHFsSEltV1RCYVA4anEzeG1QVGMzQVZWNVMvczI3WUFM?=
 =?utf-8?B?d2tTQUVqUGEyMmh6UnNGZitmdUdPbWFYZzVITEZCbERSa1FCd0N4RFpCdE1w?=
 =?utf-8?B?a3kxWm5URXEyQ0gwRlVLZVh2MkJVNjBPQ0RpT3VRWGcxRkxSbzhVOVVreXhp?=
 =?utf-8?B?WHpFSFZkdDZiQ0h0VG9GNnVQZExiMVR5aU9ON3AvR01qUnRoeHNZalMwajRs?=
 =?utf-8?B?cHdaM3JXcm9OU2pLQ0drQlRDUk1Db0tqUkxxRlMvN2RGQ0ZDZGtrbjdKemZy?=
 =?utf-8?B?b1U2N1J1TGk0ZWV4M243SThSTWsySmJtZmtDc3gwb014SENmaFYrbHo3Qms2?=
 =?utf-8?B?VUM4enNscDlyTGpiWW1JbXFiUkQ1Y2NsZm1aK0pVbWFzblBISjd4OUYxQTdO?=
 =?utf-8?B?S1Q5ckd2am1KTjZWUHBnb29UZGxyNkJIWjh5ZjF4dm1Nc2YvdDV6TnBFeWFH?=
 =?utf-8?B?dW9mMlRHVS9JVnBIYWp6Nzl6OENhR3NCOTFHOUxMbVF1VC81cXh3U2srVDZE?=
 =?utf-8?B?dWdMbUR0UFR2dFpTc2N0TEVTOTBXbHI4NXdjRTc3VmV3Mld2dWhDdW16VzJk?=
 =?utf-8?B?M3JzeFl0d21KeTZQR0ViQThGd1MwUVRuNGNvTFBKZmRHODRNSjlEYU05clZx?=
 =?utf-8?B?WXN5enNlMURlWWJUUHlDVE9waFJ3ZVZYVzlyR1JRSFk0UVFROHZIUi9xYjFW?=
 =?utf-8?B?ZEJxQXJMOXhsUE5KTWlPbDhLTFdkNDNxRU5xT0UxTEtPV05aV094aHBDTkw3?=
 =?utf-8?B?RWJUYnlhSXZJYlRaaHExUDNJRThjOTQzU3Urb1pJdUVzOUtQWDFuYi9QNkRR?=
 =?utf-8?B?UXcrd1h6RkxLM1dML0lyYm1SelltNWRPcWM4R0dtNTdGNjlkN2xQL1JVSGRV?=
 =?utf-8?B?Zzhva1Y0UXJPenI2dEdMcTVFNkl0Y3hlbFl1eEgzMmo4Rkp0S25uakdSUE55?=
 =?utf-8?B?SkVDVjB3RlhpSldETnBxK21aMW5tMEYzK0NxSHJiT1IrSmFJbUFaRThPRm55?=
 =?utf-8?B?eVlKV3pxVzdhNnhFK3FVbU9CaUthTXZmNWU2dlMxeDZkUXNRN05NN1FiZlI2?=
 =?utf-8?B?YUM0OUxuN3lGVWY1N1JqUFJqZXJ4SEx4ZjdHcnBtMGhxaEN2OEhFMkVhQVh5?=
 =?utf-8?B?NHRtNStlNDRkRmVvYjhqSTJ0MXF1OG0rQ0pLTWNGVXI3djBtWSt1MmM4NVF5?=
 =?utf-8?B?a1JIaHJXZ1JqeFFEWVByZktydXRkK1dhWGRmU1YrNGY1Sm1BMDFpQ3VYMURC?=
 =?utf-8?B?azhlZHorSW90bjMrM3B6MmRkVlM3a0psQVJaWHRsdERPNEpMTm82dlNiWUt5?=
 =?utf-8?B?YnF2dGJrWk1jYTdNY1JxNHI0MllHS1dTZk52eUsxWjhkY0wzOW9pOHIrOVVS?=
 =?utf-8?B?M0J6SWIzZjFlbmxmb0JtcnVFcWxBVkNyR2xucmduWEluVGJRNjRRVE5iN0Vp?=
 =?utf-8?B?SXowN0lFRWZUajhXei83VHFxWXZ1TzZvTzJHR2dkckdQZTlaN2dLMXRCdlV5?=
 =?utf-8?B?UjdhTEVwUVhkMGhQTjZJUTFiMEhGS0N1RHlOZDRIREdUMUEyQmppanoyc1Ez?=
 =?utf-8?B?dm5FOEpyaXlXUXIrU0JDZnZhc0gvdlh4RzdzVzRJc3JsM2FYeEYvenY2VGFq?=
 =?utf-8?Q?8LsP57yMy1FRBGegplB82CgED?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a85765-349f-4902-cefa-08db714cccdb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 05:11:27.5421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8S/RQHpPj+qypAyW5VoOompWGH5Ro6uzOrBnIQ5dey6ZkFlrNY2Rr76ELyzDV184lIaEMQQD+HdBdESu58DtVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4994

Hi Jason,


On 6/19/2023 5:01 PM, Jason Gunthorpe wrote:
> On Mon, Jun 19, 2023 at 08:49:45AM +0000, Vasant Hegde wrote:
>> Commit 1000dccd5d13 ("iommu: Allow IOMMU_RESV_DIRECT to work on ARM")
>> accidently restored "group->domain" to "old_domain" while keeping
>> "group->default_domain" to new domain. Also freed new domain.
>>
>> This works fine during boot as 'old_domain' is NULL. But if we try
>> change domain via sysfs using below command then kernel crashes with
>> "kernel NULL pointer dereference".
> 
> There is more wrong here then.. The error unwind should work even if
> we do it at the wrong time.

Agree. Unwind should work all time. But I'm not sure what's wrong with my patch.
Are you saying you prefer `goto` in all error path?


> 
> Like this?

This also fine.

-Vasant


> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 8f3464ba204498..6fb4533905c37b 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2960,14 +2960,11 @@ static int iommu_setup_default_domain(struct iommu_group *group,
>  		ret = __iommu_group_set_domain_internal(
>  			group, dom, IOMMU_SET_DOMAIN_MUST_SUCCEED);
>  		if (WARN_ON(ret))
> -			goto out_free;
> +			goto out_free_old;
>  	} else {
>  		ret = __iommu_group_set_domain(group, dom);
> -		if (ret) {
> -			iommu_domain_free(dom);
> -			group->default_domain = old_dom;
> -			return ret;
> -		}
> +		if (ret)
> +			goto err_restore_def_domain;
>  	}
>  
>  	/*
> @@ -2980,21 +2977,25 @@ static int iommu_setup_default_domain(struct iommu_group *group,
>  		for_each_group_device(group, gdev) {
>  			ret = iommu_create_device_direct_mappings(dom, gdev->dev);
>  			if (ret)
> -				goto err_restore;
> +				goto err_restore_domain;
>  		}
>  	}
>  
> -err_restore:
> -	if (old_dom) {
> -		__iommu_group_set_domain_internal(
> -			group, old_dom, IOMMU_SET_DOMAIN_MUST_SUCCEED);
> -		iommu_domain_free(dom);
> -		old_dom = NULL;
> -	}
> -out_free:
> +out_free_old:
>  	if (old_dom)
>  		iommu_domain_free(old_dom);
>  	return ret;
> +
> +err_restore_domain:
> +	if (old_dom)
> +		__iommu_group_set_domain_internal(
> +			group, old_dom, IOMMU_SET_DOMAIN_MUST_SUCCEED);
> +err_restore_def_domain:
> +	if (old_dom) {
> +		iommu_domain_free(dom);
> +		group->default_domain = old_dom;
> +	}
> +	return ret;
>  }
>  
>  /*
