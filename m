Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2080.outbound.protection.outlook.com [40.107.212.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2777917E8
	for <iommu@lists.linux.dev>; Mon,  7 Aug 2023 06:13:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuDODUuLD60SgocCmMIrLbn1tXJmPAiEf6CuXthl0aVNImapS2yONOL6Qr8/WhOgNyAEX5bxBNKO4gv1eRlbHN8ARzTb8PTNH9ImPoQjUAIhsP0QamYLduKgMKvTkRNnzCHdnd0LMDSzASgR4iWaDcYObmBraf+ItqVferjztmtsGdGHCgVDAHte+f7TSzP0TV+MG/WeG0W/t7c7TdtN/MAgpHiG1vdz//9rQVqywhi3rgqEZfwaFxb3Pwd305Dof7YDO0bQ8bFVmK3c9NsihsKOi1Q15vJC39Z/hs4kK9SK4gINdfpgmek53c0v6CTuFw9GiFAvj67wJLgNQRmuVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3c4WAzI4KMjU8eEteFn9IssYGXdFzeXkgqK51L5fbw=;
 b=bRkqHRu1yox6zdotEcvWhb8bcX4oMnX9e8rNtFOnHBFEzuGh0aIkFclqpZqyQwgDdsFWEN3qdAKRf2LbqDx0x9khzkp3ouFJUyV7cOjJr/R0CktFe6EQSxbVa/Sg5l9fuYFH0eRH7mf7cT1+XboR8b6ty4zRYxlQ8jHwDt6ZYyNbElPHs5jz3mhxNAxb8CNVhwbfTYtxrkjRAMz4bebmCZJTM24qn3NHuqE+SnyNf7OlaviZHhuIpZatT/3UcpfOjW5dX3KLIr3GS6mMyeTCCWhK3eiomqx/9yXfhsotoRanPg1hIYGXZoK72y5t3GuTGu0jDwgp+gQPgWi+cCU/yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3c4WAzI4KMjU8eEteFn9IssYGXdFzeXkgqK51L5fbw=;
 b=D2ar/+mgR91QdQgwtNsqRkrZg8Ccq1QzQDwtm4+D6eEyQCInNYtPoa8s6bT/Ie2AI2kKsBaSaWWXd3xOzZ85FnDzOVcMnDaRkfBn1X25AtoyjaZAFXnXkIBaPyYMLEWtBWjT5VugL0RC0HjknZnPtGNfSdtPj4apHaeb5Z4SHrM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS7PR12MB8250.namprd12.prod.outlook.com (2603:10b6:8:db::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.26; Mon, 7 Aug 2023 06:13:35 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 06:13:35 +0000
Message-ID: <0e737d9c-7e21-18e2-3800-2dc62627b20a@amd.com>
Date: Mon, 7 Aug 2023 11:43:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 06/16] iommu/amd: Introduce helper functions for
 managing GCR3 table
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230804064216.835544-1-vasant.hegde@amd.com>
 <20230804064216.835544-7-vasant.hegde@amd.com> <ZMz6fyAtKhuTk7HZ@ziepe.ca>
 <9564429b-e2ce-4ad2-aaf9-5f237bfaf87f@amd.com> <ZM0/s6EkkT7eaehF@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZM0/s6EkkT7eaehF@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0194.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::21) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS7PR12MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: ddfece81-2a84-4162-d8d1-08db970d6e96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pzBllRYUBuvysgyS+y0yLLxiSOdebCK+EKSMjisJ0WbcTn+cAG0iazq9KFkNwNHey2HgHrh+NXWaZi5tL2f1uumsAZLlb3cJ9a0yanWLWJ8OSwGtgNfsAtvdnA9q8jnWGPYmgLwSONq1gnKaU6Ih81ULFHMkyOMCqhIPEfCXI0PVqkH5prCofrkCVnWrkDyZkNFfC/2EkU/hNXsPD32V/OcWnv/+Iy8NrehajTf7rdNnuNaLHlGBjdxDOPwLFNXnDhclfW3gUTQkrLosANT8xDE2VYOxeLIOPlbI5nEvG0MfUpBfsIb4ANpr8NpI3YX42m76UMRI7xYUNWi8LjtDtBGrNSug/pZSdRAsuzUZoR07RHAdsEgbgyiiinGY2DE+TxmorQz4s2EDR3meJMoEzJ+7DShZ1lq4auZEZb+T80Cedbg4JGJ4rnRNYI6xg9AoqPTHVHtThoaVfHBNcvF82Fw/ZFGrFxhAT2sNr+OpfAux0KJlIQgHl8BnFQl0TJPgMUv+rZcoNGaESvimMuMgvxI1xZWgOtsk4DqQtDyqTfHyCgsvgpI0QeHAXrxaZIFamznhLXJ5ZMVXXla9lplpr2vDA78/d570YIIg9Ejic6v+tNi1viUJzoEWT6yF98EPlcd2fDLcItc/wtypzgmUww==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(451199021)(186006)(1800799003)(2616005)(36756003)(6512007)(4326008)(316002)(6916009)(86362001)(478600001)(38100700002)(6666004)(66946007)(6486002)(66556008)(66476007)(31696002)(53546011)(6506007)(41300700001)(26005)(8936002)(8676002)(2906002)(83380400001)(5660300002)(31686004)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGlYRTNKS0FFaUVZbFczVWM0b2tVbmFoNFNnUXVFREk4WnV4ZXI5NVBQWHJL?=
 =?utf-8?B?TzZwUU0yS3pNZXhndFlXbzdoYjBHQWgrWmVqV2J6VmtPaU9leXJIUFdBNnZk?=
 =?utf-8?B?UVJHYU9iWHBYVlE3dkRkSHNYWGpJcnN0UyswUXZGWXNhTUNFdjFYOUd1UFcv?=
 =?utf-8?B?Q2RwMitUODhEUEZPeU5tckpvVTJuNlFXV2F1Q1Y3a0xCc1RDVHdjZUJxWFBm?=
 =?utf-8?B?NWpvVE9qVXhLeGprMjRqUUxJalovY1RIeFZRMzZEbHlqZmcxaFNhcGNvT080?=
 =?utf-8?B?TTRuWEVHbGk2MTMzNzgwNG9ZbmRKV0JuMmE2cVBVV3NtRlhoa2tmdEF1MU5a?=
 =?utf-8?B?aWtjUWNDbkVHQ3F1bjkzMmViZVBIL1FlcE0vMjZlRFRzYTVqNWdIVU9pbmVV?=
 =?utf-8?B?dzhaYjc0Y1ZJcHJXK21CWEhWWGxTOTBSVy94RnB2c0tMQXpFdG5CYWlkcDlM?=
 =?utf-8?B?RE1vdFhCREdob1pWOFFKd3hHa3YweHlnR1pETklMMm9GMFB1RWtsVXFaV0FZ?=
 =?utf-8?B?VnVrQnpXUllmS2NDaEgyWGY2bHowT0tNT2lDMEpxRVdmQ0dJQ2ltMXRJeURx?=
 =?utf-8?B?ZkMzVy9icTBHalVLMHlXYWJzTVFnVU90dWRsM3dzbmJuOXRybWVXbFd5U0cv?=
 =?utf-8?B?cWxzUlBQaXFIZktHNXBheEdHYThieVNpSzI4Yy84MkNPaHJFMnVIdm9JOFdW?=
 =?utf-8?B?TmNvMHdZZ2tWeVE1eU1qOHFsY0JBRWFiY285OWkwZjVjRTFBTWlzdTZWYWpH?=
 =?utf-8?B?Y1JmRFhXV3Q0ODMvK1J4aUt5Y1NpZ0t5QnRzMWR5enl4Ynk2cVljZE9XYnRE?=
 =?utf-8?B?V1BwMHcvWmNiNmZhdU1wekp3R1YrZmJqR2tlNmRrVmEvVkEwVkN5blBsZDhy?=
 =?utf-8?B?dm0zZ21oaktEcDZudWp2cDZnci9CV1NXNlYxV3luNlJKZmZsWll3ZHZRdTMx?=
 =?utf-8?B?TUxtQ0p1T1lWaHp4cGJWdU1pZmV2OUpBc2M0ZXZJZWtyUWVIN1ViUUlKS1g5?=
 =?utf-8?B?Q0x2YlpRYW94SWpvRG55eENXd3o2WHNkR1JGbWF1N0pFUG9oSkRzbHpsMCtl?=
 =?utf-8?B?R2ZXcWhyZElDZGF2K3AwaThubzhsdkRITWJCVDFzb0NkODZLeENvdTQxUVZ1?=
 =?utf-8?B?Ri92MTBENStvMDVzQmtMM3dlT1VNVXJDakErNWJGZmdqaDNyV25MZzRzNEFN?=
 =?utf-8?B?YUVCMGNNOXJjNXgwbnNtaUQwRVNjREZhdlBOMWZoZnFrQUx4bEUvSGh3cE41?=
 =?utf-8?B?NDM1MUtSY1BYdmZoVEx0YXhBYnFmVmpLVlNZTDhZNHJRcVdVcU1Nd25WY0Iy?=
 =?utf-8?B?cXl3YlliUkFOeml3SWFPZFFQLzk0UDJJN2NJSzJrRWdGQjgveG15VlB1OGU1?=
 =?utf-8?B?WHVpdWI2U09zcHBpY003VWd5Z2o1d0k4VE13Z2ozQmJQbHlFYk5BTVZxL09S?=
 =?utf-8?B?S3BGTVhoeGpJSGd4MTQ5RldOZVp1azZhVVk2YXZjMGJTYTQ3NHd5aE9EVkpG?=
 =?utf-8?B?UUhZZnVlc2tPamlKQ0dDbEdsNExHTm9DcklIL2E1R0xVMjZCNVdZTFNPbE1W?=
 =?utf-8?B?S3BLaDNCWlMvWE9vL0xvRkZZSVl1VTFFZldJRDNHN013STVrdXhYZnhaVnUx?=
 =?utf-8?B?T2hPT0N5ZnFwSlFCNWVLV2pKY1orVjZOK3Rha2ZyaGxqcjh1bk54TVFieDkr?=
 =?utf-8?B?aUE1VVorbWd0cDFHSVU2L3NWdmZ0VEE1QUVsLzRRVlFLc0dDTkJwS3BHK2ZS?=
 =?utf-8?B?SitnOThzZStQRFRya3ZhREFjVjJ5dFhneXVtOTBpNXhTVFNzSFNxQVJ3RjJM?=
 =?utf-8?B?VDk0MFVQNzBuNDNERkdJN2o2Rm1KeFIyblBzQTYyMVV6eU4yQ2VXSm9waVk5?=
 =?utf-8?B?OVdaUVcrUHo4dEM3MDRHaElyUjB2bE5aZmFqVURISjdZb2ZzaEoraTcwMmVZ?=
 =?utf-8?B?eWl0dWxnM3hRS0JxektoVmhJbWNDcVF5eXZGMzNHemJBTU5QNC9FMHVkbWJK?=
 =?utf-8?B?cnVNeUFMNGlvL2oxR0NyNktEc3V2R1Z2eE5BWUpuaklReEZqNktqclRkQWIw?=
 =?utf-8?B?Q2FEenVMbDhMV29uZXJVZmg1a1MzR1o4K3M3VkRqK3dDbEdEVHRUclNoRG1s?=
 =?utf-8?Q?u7feqwH17nwK1Zf0QXEeKzpST?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddfece81-2a84-4162-d8d1-08db970d6e96
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 06:13:35.3169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iq9YFib0WSsHWM5g0mNnAKqMHPChcXhL9fEEyepWHuMIaEmL5q9a26pMY+QwsQBSWevfId4tbRco7nMity0ZwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8250

Hi Jason,

On 8/4/2023 11:43 PM, Jason Gunthorpe wrote:
> On Fri, Aug 04, 2023 at 10:21:41PM +0530, Vasant Hegde wrote:
>> Hi Jason,
>>
>>
>> On 8/4/2023 6:47 PM, Jason Gunthorpe wrote:
>>> On Fri, Aug 04, 2023 at 06:42:06AM +0000, Vasant Hegde wrote:
>>>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>>>
>>>> Refactor domain_enable_v2() into helper functions for managing GCR3 table
>>>> (i.e. setup_gcr3_table() and get_gcr3_levels()), which will be used in
>>>> subsequent patches. Also re-arrange code and remove forward declaration.
>>>>
>>>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>>> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
>>>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>>>> ---
>>>>  drivers/iommu/amd/iommu.c | 66 +++++++++++++++++++++++----------------
>>>>  1 file changed, 39 insertions(+), 27 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>>>> index d5569eec0fe9..135fa087ce47 100644
>>>> --- a/drivers/iommu/amd/iommu.c
>>>> +++ b/drivers/iommu/amd/iommu.c
>>>> @@ -77,7 +77,6 @@ struct iommu_cmd {
>>>>  struct kmem_cache *amd_iommu_irq_cache;
>>>>  
>>>>  static void detach_device(struct device *dev);
>>>> -static int domain_enable_v2(struct protection_domain *domain, int pasids);
>>>>  
>>>>  /****************************************************************************
>>>>   *
>>>> @@ -1575,6 +1574,43 @@ static void free_gcr3_table(struct protection_domain *domain)
>>>>  	free_page((unsigned long)domain->gcr3_tbl);
>>>>  }
>>>>  
>>>> +static int get_gcr3_levels(int pasids)
>>>> +{
>>>> +	int levels = 0;
>>>> +
>>>> +	if (pasids == -1)
>>>> +		return amd_iommu_max_glx_val;
>>>> +
>>>> +	/*
>>>> +	 * Number of GCR3 table levels required. Level must be 4-Kbyte
>>>> +	 * page and can contain upto 512 entries.
>>>> +	 */
>>>> +	for ( ; get_count_order(pasids) >= 9; pasids >>= 9)
>>>> +		levels += 1;
>>>> +
>>>> +	return levels;
>>>
>>> You missed to use the DIV_ROUND_UP
>>
>> Sorry. I wanted to add comment to few patches separately. Somehow it got missed.
>>
>> In our case,
>>   00b=GCR3 table is single-level - PASID size 9 bits
>>   01b=GCR3 table is two-level - PASID size 18 bits
>>   10b=GCR3 table is three-level - - PASID size 20 bits.
>>
>> Hence I didn't include DIV_ROUND_UP().
> 
> You literally coded a for loop to open code division :(
> 
>    levels = DIV_ROUND_UP(get_counter_order(pasids), 9) - 1;

Ok. Will fix it.

-Vasant
