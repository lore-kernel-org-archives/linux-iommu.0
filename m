Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7391415AA
	for <iommu@lists.linux.dev>; Wed, 13 Jul 2022 04:07:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhwyjgRuRQCdK8XoPUEZiPQqEILMsvHSNbrVAbas3UHnRH7ZOBC0dvLeG5mtZShNJJwBejn1Qu0AsWUFGzFnHW7xNAxmLnDzfh5kLcIlippgclZJDK43QI3rl0ptIBYv/9GwMnHefLsOtK6tsmfH7YIdmAHbq9npDSXqFF2gOmjyu8rbZRhkgsjBoyKvMaFRFVAA0RMRkUF8ivlwqSZCtZJ4gSQaSSTGaM9vyX+1bAhlXKirAVARJbJdR0kUzmnDrjvyCw2dWMz1tNjykHxMvTAtjhl8minteQTQoBIqaxKE59JzC0bPjnfaayAQxLitNXIF8hL37ySZDmvrkE6hlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woXKr5ds1bWByjc9k0R33OTRcery66YlEaVUkjMQFQE=;
 b=AX1k3/Y7NwzpnWtBfHubDY3gomOOKr1mi68L5dPcTUYg8w/q9K49zLlYbazeuY2rlnvsRpxYSDC9puidqTE3QVykiyaDm+ART6B4KBSByb3nsZb4XdMLuZFXG5Yp6b5zQjG+O7WKT9PoUumBbGcYVnpa46N64w24xFPyztPDEeWj/lk4aVqihbIAkXpVJap8mJACoZ/AfeMdclBwngeM36VU4w1Mg7QNJLUWuVudyoCBflzqxWgiXNKuA01MbfPCnFq45mfwcfOebZY/U68HOqsssX1MdGZjmNfSYXW4fhEX2gL6uVdaCilqSK1nwKyh/EfOb/kadUIx2AkelEdneA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woXKr5ds1bWByjc9k0R33OTRcery66YlEaVUkjMQFQE=;
 b=1X5Ah5zugaI5M8d4+0SdU2+OeLw3NAUKLiilNkrUGcKSo4StqI3hQlWvjN8Oal2dYECUXIzTNEIQKtI+/bDhqPUeypEfjsbE/DsdK8xcfeKhd5POwHSAXrdEV6DobWz/DX6Knxg2B2GfhffgzQVcRvrZLL+Zd6PUzDuMemPobHw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20)
 by BN9PR12MB5211.namprd12.prod.outlook.com (2603:10b6:408:11c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Wed, 13 Jul
 2022 04:07:26 +0000
Received: from IA1PR12MB6043.namprd12.prod.outlook.com
 ([fe80::4c24:3f6e:e133:c324]) by IA1PR12MB6043.namprd12.prod.outlook.com
 ([fe80::4c24:3f6e:e133:c324%9]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 04:07:26 +0000
Message-ID: <15337b9f-48d7-d956-5d6c-b40319ba38ad@amd.com>
Date: Wed, 13 Jul 2022 09:37:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v1 3/7] iommu/amd: Fix sparse warning
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev
References: <20220603112107.8603-1-vasant.hegde@amd.com>
 <20220603112107.8603-4-vasant.hegde@amd.com> <YrQeXdR8yPOyv957@8bytes.org>
 <82767d0d-a04b-4432-0e7e-77bcca095e09@arm.com>
 <403e6853-86ac-a81f-42a0-2d896163ab81@amd.com>
In-Reply-To: <403e6853-86ac-a81f-42a0-2d896163ab81@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0148.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::33) To IA1PR12MB6043.namprd12.prod.outlook.com
 (2603:10b6:208:3d5::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 517dc11e-4e0d-49fc-3bff-08da6485314a
X-MS-TrafficTypeDiagnostic: BN9PR12MB5211:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ckKrqDKeLuCTEYh/TBRn+eiM4cw3NPSYUMQClFw+HMfOo2lS9bI9+nleOhzrjnTWE6KOq6sYf1UxXbhKF+CoLdsBE7DA9qUqhE6maR1BzVtJ2nSgAqRPoGzmqCBU/2xFbOptojDRm4GTXLwKAdi6keT7cxUGyY3izo0pWqo0AsNKqNRkOSEpLoKl4ekYCvo9KbVP897YcSFNIDB3+BSEKl3bkWfSCIK6GkTnnZadF6n+NeGsdVWpHOcaGGVW6g5k/aNwzYrF7dWPDadKjKOzKaCej56uswODzljDFmA7JPKo8ldkd0pzkAvzCiSP4sFJy9goM+GXAJJV+0Uwl6yt3WMSO+MW09P0vnuznkMPD2ubZksbDYa3PFum1zCQg2wrpafreayBCYueBHi9n3haWROmThCJb8rGP9uGBH4Hppgx1R6TKhUVMAS8KFmRjm96+3pduO8eF8zd5fwX88tWXdLa24ChKibrLj9wwBk1hJZLJFJzc72wt6DAy5sY+Vxrg2hPn08Zrss8fi9V3m/lgMVsx2FGSvMASz0Nn+IwEj10rlD56C9LQ/QPudZEKoSpQaWQDH8+pENsg3KLLlMcAEdB9Ru59HXm01KWe+1S7pnBRKRPbG85oG+7HqxnLGwDLXL3SQJq0bzxFGw1jx52RGfXvRba65McthXzKh5auEFSPevKaWLHaspiKcvAVaZPWAtlt1O87L5Tte/WV5Vb8UMJODxn+jbLfKeGyHKJGaJt2Sq68MhuBgjQceuPo+8cD6SHqmY9llePghTQz74bzQi6jyUYJVKaVuWbYYAkdIa4pkMelBZLd0Tg7OBQmZzdlNnMVtL4aFjEtPVawaRAB6rouprkcWHW1QW06S4UTJM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6043.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(2616005)(186003)(41300700001)(4326008)(8676002)(66476007)(86362001)(316002)(6486002)(31696002)(6666004)(66946007)(6512007)(2906002)(478600001)(66556008)(36756003)(31686004)(44832011)(38100700002)(26005)(6506007)(5660300002)(110136005)(53546011)(8936002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SW0ybDdMbXpVNllQNVUzM3VzK2dzY3FtYTJ0UXVYVXZ1UkRrU1NkeTdBTWw3?=
 =?utf-8?B?cHdvelRTYms2MWxXbGtVbTZiRzVIRUp0RWJUWlVWVGxLTHh4UHErTW9yZVB4?=
 =?utf-8?B?bi9VWWI5OVVEWkxPdFZjN094RGJzNEs5Y2hnbXdxRkRHTE5xNElYd0g3Wnpo?=
 =?utf-8?B?cmtvaW84UWZuQ0hJNkMvU2xHU2JPZ0ZGMFZISjNOV0V3SW9Rb2VDeG50VGJI?=
 =?utf-8?B?M2lRSEdUV1VweGZvcU9hTzREeFpzY2RWYzlpRFl5d0tobFNRVURRdzhja1lL?=
 =?utf-8?B?RzEvc2MvNkhUbTZFdTlMajJsYXV2WHRmWnJiaytBK1JjK2s2eGs0VVlJckc5?=
 =?utf-8?B?a2N5VWVPOFhqeVRFK2Qza0RHSllwUVdvSGQ5TXErcWVIVy9PanJJQmE5Tk5M?=
 =?utf-8?B?TWZDUlpkMjVYMWp4eXhxRjNEVVBsdG1DUHN6MDFHSzIxZGxlYVlNeFpuY1pJ?=
 =?utf-8?B?RXlpWHVFVm0wRWEvUlYxUHZ5ZlR3bEtLYnNMUVI0WFNuYk4rc3BBdC9ObVNm?=
 =?utf-8?B?WTZmUGVSamd1czRoeERzbDdIZGtmdXZiVFU2a3VOSlVQVnh4NGVJajRqVEFh?=
 =?utf-8?B?TFR5Y1JJTUd0NjhPTTJ4TXk1VjBER3hHY1NtVUd1ZHY4aE9VbUFGcEN6WVVP?=
 =?utf-8?B?elltNzhwaWR3VFkxVnI3K2ZVd1lrTXIrTFZQekdWdkVwem9ERzFwd2JKS2VJ?=
 =?utf-8?B?SWxnemhaREw4RWM3bnJEUlRCSXloNnBCd1c1d1FCN2t2MDZwVEsyNVIxbW5N?=
 =?utf-8?B?TlJrMEQwZHhLell0b3JUZTNYVUFyLzhxbTZwVUNRai9LMTc5S0VtNjZKSE45?=
 =?utf-8?B?bjJOVnFsWDZNeGljZGthaVUzTkx6ZW4rOFA2ZU1GT1lnZndKWGRvWEFEMHp5?=
 =?utf-8?B?N2E3VGk3MitXRE1GaE9FYTd2RmJySUpDMnZ3eVhYWjFtbDVrN1ZDS0dEemla?=
 =?utf-8?B?aTBJbm5NSTRiZVlqWU0wbG5PempCT0tITGRBTXdWNnRwcVhsSlpkWXV4M3pS?=
 =?utf-8?B?dXN5aUhIak41VDRoNG4wa21obUMzdTEydmV5bmYzUUx2eDhNZ3pqMTRuUFVY?=
 =?utf-8?B?Q2RTM1NRSXFFQXd6QkxTT2VBSXp0SURFR0dSdndLN2p2aW5NczEzU1UvcTJO?=
 =?utf-8?B?M0psN3QwOUVUUFYybDd0WndxRGd2N0hic1ovUmNCUkl5MkJzTFFqa2ZZbFc2?=
 =?utf-8?B?cXBWVlJqWUlCb3NsVVRSUjFHMW5wWTdzTTBSVjFUNy9RZzZHOGIzK0RsaWxF?=
 =?utf-8?B?NnkyRXZVNkQ0c3R3NXVERCtqM2FkMTBRWFI5RTdSZUpaek9WN3VNWkpFSERP?=
 =?utf-8?B?YVBiSnlZZElJWWZSVGdkOUNZUHFScms3Qi8vMnZCQmh2ejV2ZVNQTkl2RDZH?=
 =?utf-8?B?Tyt1LzU1WlFmQ1JwWWNwTk9mc2lBVkxIbFd1anBZVjZHYmdGREY2bTFIV0NC?=
 =?utf-8?B?ZWRjRXpBVDJlQXJZL1VNVTc3QU1qcXJ0UFFCaGV5V3k0N0Q3TWQyK1hudnNi?=
 =?utf-8?B?alBHOUtidzZQUTJxMFZzTjh6N3JyaTJUU0hWYy9KRllpVVpZR3g3cXJBWHZ1?=
 =?utf-8?B?cXl6T2ZDemhBZ2hhRGZWMTQ4OU5VQkV6TlZJRjgwK2xyUjZjSFJTRHZqRENE?=
 =?utf-8?B?dnhOc1lRN3F1TXM0cmgwVXoxeVRMVnFsNFJXNTUvazNnMjcrcW0vclNwMCtz?=
 =?utf-8?B?K0NxWUhsbWNkUmJmZHBITEloa1U5RGdDQmdHOHlocWF4NHBvZXV2UnhlZGc2?=
 =?utf-8?B?d2hjc3VJeDd4dGhJYnZjcFAwcXpaUzVCREtwQStRUU9MQnBhVnB5ZjROYS9G?=
 =?utf-8?B?RU5NMm5DMnlIKzdKWXgvYlJZN2hqMldjMFhpNndIYjdab1NjTkVabFk0bllZ?=
 =?utf-8?B?c0lxeFRvdmFPL3N4UThEUXRFay9OOUZUR1BBdDhWZGNMWDdFa0lFMGdxdS9H?=
 =?utf-8?B?NG5SbjRXc2k1K2YwRzFnRE0vaWxURDdmWFJHWWFYZ3lURGlhaVpoRENPRGVC?=
 =?utf-8?B?TDRrVUNUdjU2eEVHemwzYktITy9RWG5HOTBpQ3hiay9tNmVVSWNhdy9TbFJB?=
 =?utf-8?B?MWJkU2gyajdUcWFacHNyZ25uZFJPUzg2b2p1aFhBRkdNZXA5YXJIekxXd2VP?=
 =?utf-8?Q?dA6byLrr4qRPViMlUp8V0rN68?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 517dc11e-4e0d-49fc-3bff-08da6485314a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6043.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 04:07:26.5031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U7dVpFEaivY3T1afV9aNkmCMZhDKQwfv7FlmRW0OV/mj+1HWt/AQ2s0VW83cuR0WWlOzCOab36jcXaoEWZeg8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5211


Hi Robin,

On 6/27/2022 3:59 PM, Vasant Hegde wrote:
> 
> 
> On 6/23/2022 3:12 PM, Robin Murphy wrote:
>> On 2022-06-23 09:03, Joerg Roedel wrote:
>>> On Fri, Jun 03, 2022 at 04:51:03PM +0530, Vasant Hegde wrote:
>>>> Fix below sparse warning:
>>>>    CHECK   drivers/iommu/amd/iommu.c
>>>>    drivers/iommu/amd/iommu.c:73:24: warning: symbol 'amd_iommu_ops' was not declared. Should it be static?
>>>>
>>>> Also we are going to introduce v2 page table which has different
>>>> pgsize_bitmaps. Hence remove 'const' qualifier.
>>>
>>> I am not a fan of removing the consts. Please use separate ops
>>> structures for v2 page-tables and make then const as well. This probably
>>> also has some optimization potential in the future when we can make the
>>> ops call-back functions page-table specific.
>>
>> TBH it's probably time to retire iommu_ops->pgsize_bitmap anyway. At the very least it would be logical to move it to iommu_domain_ops now, but maybe we could skip ahead and just rely on drivers initialising domain->pgsize_bitmap directly in their .domain_alloc?
>>
> 
> Robin,
> 
> Something like below? If yes, I will cleanup and get proper fix.

Ping.


Will you be cleaning up pgsize_bitmap -OR- do you want me to cleanup (I can do that as separate
series)?

-Vasant

> 
> 
> -Vasant
> 
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 840831d5d2ad..32dd84a7c1da 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -1916,6 +1916,7 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
>  			return -ENOMEM;
>  	}
>  
> +	domain->domain.pgsize_bitmap	= AMD_IOMMU_PGSIZES;
>  	amd_iommu_domain_set_pgtable(domain, pt_root, mode);
>  
>  	return 0;
> @@ -2282,7 +2283,6 @@ const struct iommu_ops amd_iommu_ops = {
>  	.get_resv_regions = amd_iommu_get_resv_regions,
>  	.put_resv_regions = generic_iommu_put_resv_regions,
>  	.is_attach_deferred = amd_iommu_is_attach_deferred,
> -	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
>  	.def_domain_type = amd_iommu_def_domain_type,
>  	.default_domain_ops = &(const struct iommu_domain_ops) {
>  		.attach_dev	= amd_iommu_attach_device,
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 847ad47a2dfd..73cfba6a6728 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/ iommu/iommu.c
> @@ -1915,8 +1915,6 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>  		return NULL;
>  
>  	domain->type = type;
> -	/* Assume all sizes by default; the driver may override this later */
> -	domain->pgsize_bitmap = bus->iommu_ops->pgsize_bitmap;
>  	if (!domain->ops)
>  		domain->ops = bus->iommu_ops->default_domain_ops;
>  
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 5e1afe169549..0c028aa71b96 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -255,7 +255,6 @@ struct iommu_ops {
>  	int (*def_domain_type)(struct device *dev);
>  
>  	const struct iommu_domain_ops *default_domain_ops;
> -	unsigned long pgsize_bitmap;
>  	struct module *owner;
>  };
>  
> 
> 
>> (and FWIW I'm leaning towards the same for the domain->ops as well; the more I look at ops->default_domain_ops, the more it starts looking like a stupid mess... my stupid mess... sorry about that)
>>
>> Robin.
