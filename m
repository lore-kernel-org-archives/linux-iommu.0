Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911DE156C1
	for <iommu@lists.linux.dev>; Thu, 11 Jan 2024 11:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fBj2N9Jm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=miyGDRZuwyJBgCzFs9aaHq46bH2UibS1bINkjzU86QefHI7DchkYNjRb/s9gZeJKJ+nWtbrQN50ncK9cyupgNYleNCXWOTGQy51e9GpL6UrxBePaC78muBPCCRKVA6JECs7roX3ZSNDaeejElmUJ2piZKi7Nh7HKvxttoFCUOnPBgh+rj1KI8PFrTFvmpX0H+mF0Etg2eVH+GJYIoQPiPee78jgdOexS2uVU1nk+JDbxYq5xPVZI71SpfMXNgb18IGAj0KaTQO4YjJy4v2Jtgm95XdRkPF/2I9ap+c1ioxmaQvfjwDTDa4tYJKw/shBJVDe0DS0vr7NOWAe4H4wqDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1hDZJ5SqsbkP+TSrzXiggvcAHSYliNN3EO31KIgXEQ=;
 b=G3jU+GvdP1uSDFmp2Rh20G0nsuFTzf8JXI+T1iZuNu5NKUKh609WIv2lnwmWK8Rzc2Rg5o5TyU3KaJgLeO6URBL/41oMVQd4gDpOglV69RR4aQ0dvrzHO4BiLsTuYW+p43cKGt4sJatNWslW4TJAXT3swAIYp7LFUbp28hGyKdO6AKrHYtPXFAGMhmBp/Nzz6ABPc/SPIPPY/x6iADywbFyEYfnIL0BQFABod8PfizgdZhdxsSZOLlkF9uZPtkQi8jj96s0hJda/GBOoJ3XrZoo12bfbxypewb/u+BFCC2CG9wHCjU2D148D4f1n0K8G+j+CtkNsq9fBR3iI262hfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1hDZJ5SqsbkP+TSrzXiggvcAHSYliNN3EO31KIgXEQ=;
 b=fBj2N9JmtIC2IZZUxKrFKbqXnL1a73k0q4GKUtwQ3Fum1xU7McT96/5kTuct3S5fNcWoTO81AoFoB/WzQe71uaTu2sAngPJTo+Wa+LRR0jyJl5oqJKbXwxHdKADLuKYKL3SOSjwvhKFaIzOQpQQQZl4cRoXF1OH+nideJGzsdPg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SJ2PR12MB8876.namprd12.prod.outlook.com (2603:10b6:a03:539::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Thu, 11 Jan
 2024 11:18:09 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb%2]) with mapi id 15.20.7159.020; Thu, 11 Jan 2024
 11:18:09 +0000
Message-ID: <d71a2bc0-ed07-53eb-faf1-bd36b6ff6ffb@amd.com>
Date: Thu, 11 Jan 2024 16:48:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 07/16] iommu/amd: Introduce per-device domain ID to
 workaround potential TLB aliasing issue
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com, Baolu Lu <baolu.lu@linux.intel.com>
References: <20231212085224.6985-1-vasant.hegde@amd.com>
 <20231212085224.6985-8-vasant.hegde@amd.com>
 <20240105185549.GM50608@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240105185549.GM50608@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::18) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SJ2PR12MB8876:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c0dcb2f-673b-4c4a-7118-08dc1296fd7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4hy+HE55a5v/q3jXqZfrWTWyFudg7Dzuelh6xvPxzrrkkq4wlaPwie8NAw9yOi2fLiS1uB9+xEfRrXedoXrehfB29k2d+QXhKB09o0TB5MyYLkh8PcIn29N6iTbae8ULxSp7SpTGSzMYdVD0/CG2wPG1Q+iGuUNko2pdMnOZRIbcqugVLNUk7/svGi4EP/+Xlm9V6d3K+hUoU+GJtRC5ZiHUvjz9PUsbTVAyq5tfKMK9RPysXhm8AP82ucWsO82nEf7fw7B5pFMP+6MRNgmVIidcipL8fVTP7v+zXxTE1H63OV25Qc1PGrNYTMbPl6NlG/cFsfBG2a1RYkD/ciWbCWFf5sCRyay4RTLn/L0VKbMzMEHeUfI70UfA0tGzl+gnTSp7mYbTltk11SIyTpvayghQdiZ0Sn5LrzjlvdeGRQQHuGSDAD+4ZF9hGwAxfHyCF96wlIr2i0WeMhflpRVqSUk7VLuayJmF3EBd4BzY7IR5i7KXnfCmTV2eR0C3SCXN4F6YheGdznmYnaA4WdZcri+reRMJLAM8bXO/XkNWIV9dBbnwYrahssg/dAFGYKq57H4SxMYYDT3HTaClp1Jr4wmWyEyfHMyW5GXEYwUcJT0YUxO7ALEFuqvqtpPKAH77lHBOBwRWYEYWJ6gVHZQ9hw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(346002)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(2906002)(5660300002)(66899024)(41300700001)(6666004)(83380400001)(478600001)(6486002)(26005)(38100700002)(2616005)(6506007)(31686004)(6512007)(53546011)(31696002)(66556008)(44832011)(8676002)(8936002)(36756003)(4326008)(6916009)(66946007)(66476007)(316002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlNoYUJpNlV3RGUrZEE4TzFMNEpXd1dKNDNLVy9TUXRjOGRYdnpGOElsUlJv?=
 =?utf-8?B?RTZmM0ZHblNXT3JxZ2R6Q2RVT3RoeHB4Q2ZKYllHR3JzVHRCUUk2Ynh6NTZ0?=
 =?utf-8?B?anBZcEVGNjBXUkIyd2x6N0VaL3AvdXJWc1pyeVhDU2VrYVVSNlZyakp5QjVC?=
 =?utf-8?B?Q0NONTBNdnZqc1FsVkFOZG8zQWczeFZFM1YrT2h6ZVFmaS85MjhuVTRNVVgv?=
 =?utf-8?B?WXUrWEJXZHlMTG5LWnV2REJrTDJiTDI0MERmVitJNWJWSDJ4ZHB1ZTNFNDZI?=
 =?utf-8?B?SWIrNVBnS2c1d243VGxHN25jbTdYWnBJSnhOOXNvbjZlaG9rMWNJZTdaU3Z6?=
 =?utf-8?B?NENSWEtyTG5TZXVTREVDamFlUEZkM3NhUTRXSlM0M2x0WTYyaTlzdFlQalFL?=
 =?utf-8?B?WUQ0WFVxcWUyZGZGUVNIQThhTWV1NlRDbnl2cEN0MlhOcTRZOUF4ekZwci9j?=
 =?utf-8?B?bEMxUjZNLzJJdWVVSmNXNkUvNjlwL3RjMXUwbUVnanErU0tITmQ3MDdZL2NY?=
 =?utf-8?B?Y3VVU3BrQ1lHU1Fxc0xNRjRBeTRTM0l4VU9TUU55MFJWYW5rNmh0bm9SbzNG?=
 =?utf-8?B?cVpoR0xqTkFkT1A5NVdOc0dqcFJ4SlE3dFFRZmpkakhxZG1XUVVnMWM5cEti?=
 =?utf-8?B?aEhXdDgxZlFDY3NrNGczNi9pZVRvTUYxenVOUENXeXNzRU1JdjdBVHpxNDRw?=
 =?utf-8?B?TTJWUlkzR0pFalJXZStDcm5RK0dzYWhrc21XUXJsL3VvTUpML2s3RmFCdTJw?=
 =?utf-8?B?NDREQ0hhb3ZydzlEZ2VtbUg2ZHJzTjNtS1JpUklaUUhiQkdteWY4WDdNbVJS?=
 =?utf-8?B?VE5TWHQyeU5uMHRQd0Jldy9ZTEhHUDJnNWp6VHFaL2JWQitLMWE4aHNzbldV?=
 =?utf-8?B?NzBLKyt2ay9wU29SNVdCMHV5VkFNM3h0VGcrUGt1cTJmTy9DZ1hsWlp3cmh0?=
 =?utf-8?B?Y2xCLzRwU2JyWnZISS9Uak5ZeFpCemkzcENSbG5peGc0dk5uSng2T0h5MytR?=
 =?utf-8?B?TXNaSkFQTW1qMTBvNTJreUVWOVhxU3dTU0NBRW9hOWVLQk5GU3hja0s4VkNi?=
 =?utf-8?B?TTQyNEtxdzZObyt2OGlPTFNEV2lxTlRUb1krSGV6OXFYNmZYNlgwRFU0UDh6?=
 =?utf-8?B?N21URXNsMnpYV1czU3A3a2EyWlJZRHhyeHVuMUExN21RS3R5c2taNERITHZK?=
 =?utf-8?B?b3VnZWFRZ3g5UlBsT1VuNXgwd2tZTUo5V3E1ZGNQRjZOdjI3OGtKK3grQ0pG?=
 =?utf-8?B?dTlSUlhCSmYwVTNJV0kwb1lOQkpXK01sb1pwQXI3bWNwdlQrUk12cDhZZlFR?=
 =?utf-8?B?cElSYlZVRlkreEJQY0RnRG5ET29mOWRneXpRVlExMUNtaDk1MDc1dmRVeWhr?=
 =?utf-8?B?WnhLeGFGYy9qNE5nUkt2bVdqeDNkMjc5YTdLSmlsRVRmMUd3a1J2MmtISTNZ?=
 =?utf-8?B?ZHVUNlpHNVpTcWJlNVJCZmVDNXBKL2FkWDQyL0NFUXVFNkNxdThMU1BleUx6?=
 =?utf-8?B?OWphN1VvMGtzdU5WZTg4R1FCQnFySlJMaEpudHZDQ2VuM0xnRVQvdDJWWldh?=
 =?utf-8?B?VWxUQ082QjhUWVNSLzluejZFSkpRaWpSejN1VkJLR2NuVGFtK2I2cWovcFQ2?=
 =?utf-8?B?Q0dRSXJoQlE1M3NpcXJodWFuQUVmMFVwUVNTVEZ6U29TMlVpT1BieUxESEs0?=
 =?utf-8?B?Tzl1Z3ZVSk5VUFJmTGJaT1NnK2N2cnVKUU9wWitRNWcza0xsUDBCWXdhOU1w?=
 =?utf-8?B?ajAxZFpBTlpPa0dyUEZXKzIvenJldGNTOU54cEI0ck4yNk5BdUR2am45S2FS?=
 =?utf-8?B?NWFWekxxUGpTTG5EckxCOXpQbjJ3T3VqMjJsR05UeFN2MkZpRmdHUzdOWS92?=
 =?utf-8?B?TzRsT2F4WUJxalhJQXFVdzM0TjhZM05UMVdNQlgwU25WN1NDb0xjN1l3MG9w?=
 =?utf-8?B?YWMzL1BmS3Y0YWtPK1AzYUVuMzJaelo2K3dtbDNwVy9hUE83ZUl3Z0c4bkFr?=
 =?utf-8?B?SnhMWmczN0pKN2ErWk9wOTBLUVpaNW5rSlJLVFEwdWg5YkZmdzFkRms2UlBr?=
 =?utf-8?B?VzZYaXZoMUxqTlRBdG4wZjE1cEhEckFpTTR1ODFoUjRqdlpzcElMaGNQSEx0?=
 =?utf-8?Q?Cy2MkLUkgmPh1Hivl65fr8xRb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c0dcb2f-673b-4c4a-7118-08dc1296fd7f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 11:18:09.0897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WokR4BlWmuaC9WLgvHEv16MUHlV2FOc8JFkAz8QYL2ZiELlNlqBI4Nizwn6c4fZ5Q5nuIWn+kDmk/hPro3fqRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8876

Joson,

[+ Baolu - adding as I have some question around PASID support for UNMANAGED domain]

On 1/6/2024 12:25 AM, Jason Gunthorpe wrote:
> On Tue, Dec 12, 2023 at 08:52:15AM +0000, Vasant Hegde wrote:
>> With v1 page table, the AMD IOMMU spec states that the hardware must use
>> the domain ID to tag its internal translation caches. I/O devices with
>> different v1 page tables must be given different domain IDs. I/O devices
>> that share the same v1 page table __may__ be given the same domain ID.
>> This domain ID management policy is currently implemented by the AMD
>> IOMMU driver. In this case, only the domain ID is needed when issuing the
>> INVALIDATE_IOMMU_PAGES command to invalidate the IOMMU translation cache
>> (TLB).
>>
>> With v2 page table, the hardware uses domain ID and PASID as parameters
>> to tag and issue the INVALIDATE_IOMMU_PAGES command. Since the GCR3 table
>> is setup per-device, and there is no guarantee for PASID to be unique
>> across multiple devices. The same PASID for different devices could
>> have different v2 page tables. In such case, if multiple devices share the
>> same domain ID, IOMMU translation cache for these devices would be polluted
>> due to TLB aliasing.
>>
>> Hence, avoid the TLB aliasing issue with v2 page table by allocating unique
>> domain ID for each device even when multiple devices are sharing the same v1
>> page table. Please note that this workaround would result in multiple
>> INVALIDATE_IOMMU_PAGES commands (one per domain id) when unmapping a
>> translation on the shared v1 page table.
> 
> Huh? This is a typo? "the same v2 page table"  "unmapping a
> translation on the shared v2 page table" ??

Its typo. Will fix it.

> 
> The code seems to be fine, domain_flush_pages_v1() looks optimal?
> 

I'd say its optimal for given state. I have a patch to move dev_iommu[] to
xarray. I am planning to fine tune and post those patches after SVA. With that
changes it will be better.


>> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
>> index fead9033796f..51daf5dd4729 100644
>> --- a/drivers/iommu/amd/amd_iommu_types.h
>> +++ b/drivers/iommu/amd/amd_iommu_types.h
>> @@ -842,6 +842,8 @@ struct iommu_dev_data {
>>  	u8 ppr          :1;		  /* Enable device PPR support */
>>  	bool use_vapic;			  /* Enable device to use vapic mode */
>>  	bool defer_attach;
>> +	/* Per device domain ID. Used with V2 page table */
>> +	u16 domid;
> 
> This should really be put into the 'struct gcr3_tbl_info' - logically
> that is the struct the HW cache tag is linked to. ie if the gcr3 table
> is the same pointer then the cache tag can be re-used by the HW.
> 

The reason we put it in dev_data is because its per device ID, not specific to
GCR3 table.

> Then when you want to optimize for the no-pasid case then the right
> way to do it is putting a 'struct gcr3_tbl_info' inside the v2
> protection_domain.
> 
> The DTE will point at the v2 protection_domain's version of the gcr3
> if the PASID table is empty, otherwise the DTE will point at the
> struct iommu_dev_data version of the gcr3 table.

This makese sense if we are sure we will do per-device-domain-ID only with V2
page table. I still need to see how SVA support with vIOMMU works. For now I
will keep this in my list. Once I have better picture I will fine tune.

> 
> Naturally this will optimize the lifecycle of the domain_id.
> 
> Then put the domain_id alloc/dealloc inside the functions that
> alloc/free the memory under the struct gcr3_tbl_info - ie it is part
> of the gcr3 layer.

Domain ID is part of domain/device not specific to gcr3 layer. In V1 we don't
have GCR3 stuff.

> 
>> +/*
>> + * Allocate per device domain ID when using V2 page table
>> + */
>> +static inline bool domain_id_is_per_dev(struct protection_domain *pdom)
>> +{
>> +	return (pdom && pdom->pd_mode != PD_MODE_V1);
>> +}
> 
> Under that view this function probably would make more sense as:
> 
> domain_requires_gcr3(pdom)
> 
> But frankly I'd just stick with pdom_is_v2_pgtbl_mode().
> 
> Also pdom should never be null when this is called, right?

Right. Will fix it.

> 
>> -/*
>> - * TLB invalidation function which is called from the mapping functions.
>> - * It invalidates a single PTE if the range to flush is within a single
>> - * page. Otherwise it flushes the whole TLB of the IOMMU.
>> - */
>> -static void __domain_flush_pages(struct protection_domain *domain,
>> +static int domain_flush_pages_v2(struct protection_domain *pdom,
>>  				 u64 address, size_t size)
>>  {
>>  	struct iommu_dev_data *dev_data;
>>  	struct iommu_cmd cmd;
>> -	int ret = 0, i;
>> -	ioasid_t pasid = IOMMU_NO_PASID;
>> -	bool gn = false;
>> +	int ret = 0;
>>  
>> -	if (pdom_is_v2_pgtbl_mode(domain))
>> -		gn = true;
>> +	list_for_each_entry(dev_data, &pdom->dev_list, list) {
>> +		struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
>> +
>> +		build_inv_iommu_pages(&cmd, address, size,
>> +				      dev_data->domid, IOMMU_NO_PASID, true);
>> +
>> +		ret |= iommu_queue_command(iommu, &cmd);
>> +	}
> 
> This is fine for where things are here, but what you want to get to
> long term is what I've been talking about of having the attachment
> list on the protection_domain.
> 
> Each attachment entry would hold:
>   struct device *dev;
>   unsigned int pasid;
> 
> Keep the list sorted by (iommu, gcr.domain_id).
> 
> Then optimized invalidation is simply this:
> 
> for_each:
>   if (get_amd_iommu_from_dev(entry->dev) == last_iommu &&
>       get_gcr(entry, pdom)->domain_id == last_domain_id)
>      continue;
>   build_inv_iommu_pages(..)
>   last_iommu = get_amd_iommu_from_dev(entry->dev)
>   domain_id = get_gcr(entry, pdom)->domain_id;


I have done a prototype something in this line. Basically we will eventually
have single API for invalidation :
  domain_flush_pages(pdom, addr, size)

.. and internally it will decide to flush host/guest page table.


[Slightly unrelated topic]

UNAMANGED Domain and PASID support:
  - I was considering this scenario as well. I don't think I understood the use
case of and how invalidation is suppose to work here.

   Can you explain (again?) the use case and how invalidation is suppose to work?

  - For PASID capable device we will have per-device-domain-ID
  - We will have default page table setup (PASID zero in our case) during domain
initialization.
  - We attach PASIDs to same domain. We can add this to list (protection domain
device List info - which will have dev_data/PASID). So set/remove PASIDs is fine.

  - iommu_ops->iotlb_sync_map/flush_iotlb_all will flush PASID zero.
    Looking into intel driver they seems to be invalidating all PASIDs in this
path. I didn't get why it has to flush all PASIDs here.

  - For other PASIDs do we have mmu notifier to invalidate as its attached to
some process?


> 
> And this algorithm matches what Intel and SMMU need and I'm strongly
> thinking about making a driver utility library to handle it, so
> we can revisit this later on.

If things are common across drivers then it makes sense. We can consider common
set of functions.


> 
>> +static int domain_flush_pages_v1(struct protection_domain *pdom,
>> +				 u64 address, size_t size)
>> +{
>> +	struct iommu_cmd cmd;
>> +	int ret = 0, i;
>>  
>> -	build_inv_iommu_pages(&cmd, address, size, domain->id, pasid, gn);
>> +	build_inv_iommu_pages(&cmd, address, size,
>> +			      pdom->id, IOMMU_NO_PASID, false);
>>  
>>  	for (i = 0; i < amd_iommu_get_num_iommus(); ++i) {
>> -		if (!domain->dev_iommu[i])
>> +		if (!pdom->dev_iommu[i])
>>  			continue;
> 
> Right, iterate over every iommu

As explained above I believe this will be better once I move this to xarray.

-Vasant
