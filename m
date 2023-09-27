Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0185C13FF1
	for <iommu@lists.linux.dev>; Wed, 27 Sep 2023 06:21:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgW2d6q7O9UngQKX3AEAzyb9oqk8mTh+mqIWYzsLtaza5nTE8UQazqi4WPHfqUcdUcCk0WNW80c1+TBhfeY7dJ4f7W+t3/nCnWGs2C5fEKtcxG9foz6uEmEuZs4GTyV+ULm0GpNE0vEF8AGFy/B9E5enSVOaSx5bANZNuH1wTDoSirvp0Lo3OmDRFS424E7DeyQeaoUEfU40Y/f8l0oyK9KlYQfbECrjyr4qpFQ9mXKo9aECfu4UqUo7ivKDsOwJWuPkifv1reNGuCWpCBzlnAoHIB11l5wKfg7gFXsokorVpSIBkmdvzgaZhU3QTCyv2QBHoqLAu4Jza3RojaXI8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXK7RRQN9HPbxQSLvShrJt0Sbkf4+fiZyQtKjIF1GPY=;
 b=Pj/f/jS6/V6N0GMOxGY/BqW5j+D/6qmpgEenVAJEMipJLe6ci7HfqrWoLhLHZT+FteUe31DPZmoFRG9OrYBlO/snfoqQxMJRg9rDp4/Jykkfx8AQft9V/qPDnyc7OOSbQ6eYKk5/Eo5sxsQ9r+z4j8Teu5+zJtJT9kSDB4UmxvHEsP4ZWuwGdbMLX1TgHyrBSiMvTBEMRZW/fP6ZrY6luLQE5dfGEoWwK6NMuwCzeh/fWQEGq/tp5K2A1yKAyQb7Lzi4JW2Dvuc5Lhw5jH+IwO5eUIER6gFjmH2cUCr0W24TnPzYdfSr+GMg+uKiZLRIgGsSld8Clob5hAGzlQRxUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXK7RRQN9HPbxQSLvShrJt0Sbkf4+fiZyQtKjIF1GPY=;
 b=S0X3BncHsORi8i1Omu+ZFkm1SKMtUGV4NNH4LKXE0NzCLfRUcPPLjM0z6iYehuJpKTaFOCTXMWjFbdjrZ19oipurzIVW+XI0WBlEa/WPBNlfm7qkkdV6tFR8JoCm6m+E0FidaOM7j3kwU4n1R3blNU9rJORDiuPu6PU2oSwpgNY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA1PR12MB6282.namprd12.prod.outlook.com (2603:10b6:208:3e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 27 Sep
 2023 06:21:33 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::cb74:f20e:dd21:d763]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::cb74:f20e:dd21:d763%7]) with mapi id 15.20.6792.026; Wed, 27 Sep 2023
 06:21:33 +0000
Message-ID: <0d47919e-cc2c-d151-f020-e2090fd1c287@amd.com>
Date: Wed, 27 Sep 2023 11:51:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 06/10] iommu/amd: Refactor helper function for setting
 / clearing GCR3
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230816174031.634453-1-vasant.hegde@amd.com>
 <20230816174031.634453-7-vasant.hegde@amd.com> <ZQHRTwYN4doUte5E@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZQHRTwYN4doUte5E@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0057.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::8) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA1PR12MB6282:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bc99e36-46b9-4d2c-2e1e-08dbbf21fe74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mFWR5/cYxhcpgRFp/1BTcN+ypbIO+KVrZj98VqF21fQoWhnxUErBB3EQ8RgoD/LkL2/XCZfBc6tHURYCkkHKnp1okfZ0cl3mcxOxOQb/4PR3udsAFQiE726rPz4DKPie0qrvepsRpAjMRmEytUrUNIETYV2Jey3UEHaBqYDpSIUCkX68+6fS8+E0CsfsgmV3HTNikkK8QXEfzOmDTJbHcg9ytMD5N3Ddw57Lm000sMhcdGjle4ksLuzQKe3D/44L4sBW3mFgUhg5Wj4/gkOaT/umHvAlu3PumwAU3GEG7Sam8IxCpDtGxNbS/j33fayj044W9NujGTsjqA7gdukAiINsY5xpAm251coqKRLYNd/pyy4hCePvS6uCYR4E8pd15UaKlRQ3QKqKGugf+bxvaiNceOTl5dSUwth7tuVxQDZ1kLyVUMnmycB4j7iUWP0zY8++y/oAoYkJTjcerHrFgaHHEw2jm/Wrb7bDR86DS1dmr7VhAEE53vvT6KAJt64ut+I71kK+ycKD1Im7q9vALVkN4bNfErMzoYNIYs2rjuQf6nVaKy8NANGHlU3PJLKloloDREtdTJqSevP1LFe4WryvIMDy4pJc2O/hG1w4VC/0vcwAWOeKUY19BTTFv8eHezxZOAFcmUkzELt4LPo9QQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(396003)(136003)(230922051799003)(186009)(1800799009)(451199024)(31696002)(36756003)(6506007)(6916009)(6666004)(478600001)(26005)(53546011)(41300700001)(6512007)(2616005)(66556008)(38100700002)(66476007)(316002)(66946007)(31686004)(6486002)(2906002)(83380400001)(4326008)(5660300002)(8676002)(86362001)(8936002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3oxbTV4Y1htbDZuNVo2OEpTT09CaWVqb1o1enE4V0VmVGFGVFhGQm1KM2Ir?=
 =?utf-8?B?R2I5cFZWb1lnbzdPcElGMVA4VWkrZytRNlZTY0NOemVRQU00ZGE2L1Z3VlZJ?=
 =?utf-8?B?K3JVNmlveGdVa2RtUWxZVmYxM1ZaWGN2TG9XSkJiMDdya1lZa1ZkdFg2Y3Np?=
 =?utf-8?B?VlplZEtDVUVTa2E1MHdkb2h1ZE4xU3JaSGZvOGljVFVCbFNSTkYwemtUeWda?=
 =?utf-8?B?bE1SR3Z3VjlLZHdaUnUzK294ejdtZmp2VGh2ZnJTaU9OUVIzZEVwNlA0czR0?=
 =?utf-8?B?RVNveGV2bnZrK1lOMG1NWi9qUUxjSmJYQS9DaWVSYUIwOUxDOXk3aWl2Umdi?=
 =?utf-8?B?ek5kS0ttWkJHQ2k4UWFYV2JjcGRScC9rUDZLaUNROENPQTNRQ2NNaGdoL1J6?=
 =?utf-8?B?dnVqbFMwMldFZ0k2K015UDk2UUJUVXNzYm9DSXMrdXZJa0RZUHZoaXFHZVdu?=
 =?utf-8?B?cDNYSW41R3djbjQvZzRnNGErNXRIMjhHWk8rYit4TjA0dE9VV0xScmdYQTBi?=
 =?utf-8?B?dXZWWXpBWm1vVkxZM053citxSTBIQU1nRU02TURxUzkrc2YrR3d3WHFHTkEz?=
 =?utf-8?B?b2NkYTJ1Tkk0QTNSbHZhQ2tnbFhwaHIxSmhLMW9kSWs1dUZnbkE2ODZkcjJh?=
 =?utf-8?B?YzM2Y0d6azR6TjRPSXgycWZUaU8vTkd0U2YrNnVyZ0hqWG04dTB5S0p2VkxC?=
 =?utf-8?B?S3drRHlCMXBvbVYrOW52Ti9Nc2E4TGxqTU1ITU1JK1RXdnBZMUxpakh6Y0pz?=
 =?utf-8?B?U0VORVl3RG5ZK3YzeDNtc3VicDdGRjZuRnV0L3ZsZGEzREE1V25zck1yLzg3?=
 =?utf-8?B?cFljNldMeFdybS9vUHhSLzRJY3l6YW92OGRlcTVGajg4dHpVUXg0WGJnT2xx?=
 =?utf-8?B?Ui9kR1RZNXg3dXppZFVnVm5FWjBnUjBHT1dXazk2RDFXUFZQUEtlQmJ5ZVgz?=
 =?utf-8?B?NFZtRWozRm85TUQwT0hKVzUxNlpTUmtZNWtwMVY3dGFCZmFjbDdhelJJMTU0?=
 =?utf-8?B?SDNzVUEzdFRrVG9TQWNkc0h1R1lzemVMOXU2V0Z6UmdYeC9nRGpCc05vL1Fv?=
 =?utf-8?B?K3VCYjJ5cmpFTTJRRHNjOTNkUEJrZUk4SGc4dENkeFUzTldqWUdOeHVubkJv?=
 =?utf-8?B?S0JJTXpkK1NtT3Z2cUl5Smc4c3VjUkRTL1FMY0ZZSmVBcXA4K0gzMU1RNVlm?=
 =?utf-8?B?L3RDdjU3NDNmdDNTYkt6WVFzeWJRWFFBK1JOOHpkWGlocUVxdzFzWTk4Ynps?=
 =?utf-8?B?d2dhTDF5Mk5OZWZZc1lzY3krUGZpZStmRTVtZ1NsckhDZFB2M203RThtcXpM?=
 =?utf-8?B?cXljUHJyWnpZVUJ1cGVsNlhFZmhoOHozNHR1K3NGaEdCTG9LRlZXUmJMN0sz?=
 =?utf-8?B?NXJ4Q3N6RE9vaGYyeXFnWERVNjZ0NWlLZFhQRTJlWTZndDQvdU1XWTcreW9a?=
 =?utf-8?B?M1dnZGhlb3JhU3M5RTZKNjlyR1JZSkhWemM5WnIzTURSYk9XdkR0aC8yKzdW?=
 =?utf-8?B?U01JQXhkTHNJNEJBRGxIbXhtQUx4UmQ5Vis0MW9OUDlCaVZMOWRkb1o5RjIz?=
 =?utf-8?B?bHVLZHhsZ3hIeXk0MG42d0ZjTVRuWTFqVXBaV2hwT0FHRnUwYmVwelJrMXJl?=
 =?utf-8?B?Y05vNENVVWYvT2dnYzJnOHdUbjdVUnBJV1Q1ejJLVk56NHNnUG85OGovVXZF?=
 =?utf-8?B?MGxEOVBETURoeDBLamRybHN3UzVOR3VIS2Z6T3pTd2Vod01JSm4rTlVkNXVC?=
 =?utf-8?B?ZUFiU0R5ditvb3JtcERKZE5udlFlalRUcWdrRG5pYkJDaVgvRnZ2dXVTMncr?=
 =?utf-8?B?UEpoVFhBc0lRdW92T0diSDZadmhFVERySk5iRG1taFRreU1UbFY4dU8yWVVh?=
 =?utf-8?B?Y2o5MUdqWi9zOTFCTkJsbldKMFl6ejVWdU96dlR0OFphb3IvazZrUDd6TFdL?=
 =?utf-8?B?cERVeDhmeG9kcTJwMmRBd2s0dHZsc05WSTVOOVpjUUxPVHRMVUgzMk5GY3ZR?=
 =?utf-8?B?SDZ3TTY4MHVPQ3k5bDZPTDdVNWk5ZTBueEFkRDhsYU5MV0poWlNmRnhDb2JR?=
 =?utf-8?B?VjNBTVF4Q2w3Mmx1b2dOc1V3K1hCWXN1NFVSNGNTMkZMVWNMc0xsdk4zK2VE?=
 =?utf-8?Q?zWTKT2Hbb1ncEh3/dxwJf82VT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc99e36-46b9-4d2c-2e1e-08dbbf21fe74
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 06:21:33.0523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z8G1nQFPYYLnOZPpbxJQpXsONfnbkD9HPcc7offBVcRvWEOQWqrP1WnN62kQhFauD4eVq8b2VnhpM1cSdcrBdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6282

Jason,


On 9/13/2023 8:42 PM, Jason Gunthorpe wrote:
> On Wed, Aug 16, 2023 at 05:40:27PM +0000, Vasant Hegde wrote:
>> @@ -2651,61 +2656,71 @@ static u64 *__get_gcr3_pte(u64 *root, int level, u32 pasid, bool alloc)
>>  	return pte;
>>  }
>>  
>> -static int __set_gcr3(struct protection_domain *domain, u32 pasid,
>> -		      unsigned long cr3)
>> +static int __set_gcr3(struct iommu_dev_data *dev_data,
>> +		      u32 pasid, unsigned long gcr3)
>>  {
>> +	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
>>  	u64 *pte;
>>  
>> -	if (domain->iop.mode != PAGE_MODE_NONE)
>> -		return -EINVAL;
>> +	lockdep_assert_held(&dev_data->lock);
>>  
>> -	pte = __get_gcr3_pte(domain->gcr3_tbl, domain->glx, pasid, true);
>> +	pte = __get_gcr3_pte(gcr3_info->gcr3_tbl,
>> +			     gcr3_info->glx, pasid, true);
> 
> It would be a nice touch to change these kinds of functions to take in
> the struct gcr3_tbl_info instead of two parameters

Agree. But that is kind of not relevant to this patch. Hence I didn't make that
change. I intend to re-arrange the code within this file little bit after this
series. I will address this along with re-arranging code.


> 
>>  	if (pte == NULL)
>>  		return -ENOMEM;
>>  
>> -	*pte = (cr3 & PAGE_MASK) | GCR3_VALID;
>> +	*pte = (gcr3 & PAGE_MASK) | GCR3_VALID;
>> +	__amd_iommu_flush_tlb(dev_data->domain, pasid);
> 
> This flushing doesn't seem to make sense to me, it shouldn't take in a
> domain parameter.
>
> I'm reading the spec here so I may get this wrong but.. It looks like
> the IOTLB cache is tagged by (DTE.domain_id, PASID)?
> 

Yeah. It works, but name is confusing.
I don't wanted to touch invalidation code in this series. But on second thought
I am thinking of getting invalidation series on top of Part2 and then rebase
this series on top of that. I will add function to something like

amd_iommu_device_flush_pasid_all(dev_data, pasid)
{
	// Flush domain
	// Flush single device ATS
}


> So in v1 mode PASID is always zero and DTE.domain_id should refer to
> a per-domain ID.
> 
> In v2 mode PASID can vary and many DTEs in the system can have
> aliasing PASIDs. ie DTE A and B may have different translations for
> PASID 0.

PASID 0 GCR3 is shared by all devices in the domain. So it should be fine.

> 
> Understand that the core iommu code does not provide a guarentee that
> PASID is non-aliasing. It is perfectly allowed that the same PASID can
> point to different translations on different devices.

Sure.

> 
> So this looks broken to me. The RID domain should not provide
> DTE.domain_id in v2 mode. DTE.domain_id needs to reflect a global set
> of non-aliasing PASIDs.

In our case domain ID is per device, not per PASID. Also when we enable PASID we
will have single PASID capable device in the group (ACS requirement). So it
works fine.


> 
> The naive way to make this work is to have DTE.domain_id be per-GCR3
> table (eg per-device) when in v2 mode. This will obviously make the
> cache tag work correctly.

This will impact the performance as have to do unnecessary invalidations.

-Vasant
