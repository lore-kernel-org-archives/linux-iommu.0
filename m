Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2040.outbound.protection.outlook.com [40.107.102.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D178C2CA
	for <iommu@lists.linux.dev>; Fri,  4 Aug 2023 16:51:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GO+u9b1fZVRH1yDIprXLn/VuTP5KhCzhiguKGt8fPwt2LrHSLMTq5qHht7Vz6OWKiWsWAQI7ZOaYEOARUISlIRj53H0bkZnzrb66HfTvCZMZ5slWxCkB0Wto9qylcwrCZaVSdXB0iv4rj/JYHjDFyo9Y3kh6IvW8ztup4IsAfSk9c/mx88ueapUHamGT1ncbSo98o5nb+yTbvmeqrUUIthjb6fP1H7TRXzw4SKv9aBqYWnOyDXsbWNEI8RB9ZS/iAXwlbsIBU3Ie59aIMWatDuD1CmeyFOBFIrSomz6oARJYTVY0qMLjixI6PYTkaeFB5KUD128fqcuXFabDYAAqYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KKUAXtDmRIADAPMJ70MoXtqVKASG7y+Syuy9SFMndI=;
 b=IIeUx1R1btYJ7GYf+koCodboFI4YrPXqtmbkKog4p5dofD+5eSzsIhXJBJA/jSTowN+Fzvk8P5KqiZ5TFy3WUwU86BO322ewh+YsyJj4Y1lQStTOoU1Swp1nS7vSFzxJo36/fFUVki7bsefIi9v0pLt8Fc3ZFDVdB1uqrAbgXIYZSaLPqu/FYmsev86rMiQkv7POvprIbUuA05A6h+XfhAwikXnVSlGD+3F/SWWlalTMHTMzaji5xZ8eJZyY4rR5WJAu+9wFjaABdD9NNVFFIzFAXpDbVnTycyTXw1aI2fLS5GfX6+4OtykbAuVofkffukzD0yZz2pOjRLU+0AF0fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KKUAXtDmRIADAPMJ70MoXtqVKASG7y+Syuy9SFMndI=;
 b=cMCFO1l9SqrDoaPGCieqEYQCArsmJZT+xeiBKNF+d2N334zg6R0I4a6D3JtG5zhtJmTLS2QaWCr7y/cXD3hpjLKDNxsadOg0J2jkSyHtG2Rre7ia39KIpMit65FhLLbtdeUHRIPtbgPtweF/WiSrDBg2W0DJCufb35hZXs+SRFk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MW6PR12MB8758.namprd12.prod.outlook.com (2603:10b6:303:23d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 4 Aug
 2023 16:51:55 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6652.021; Fri, 4 Aug 2023
 16:51:54 +0000
Message-ID: <9564429b-e2ce-4ad2-aaf9-5f237bfaf87f@amd.com>
Date: Fri, 4 Aug 2023 22:21:41 +0530
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
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZMz6fyAtKhuTk7HZ@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0123.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::8) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MW6PR12MB8758:EE_
X-MS-Office365-Filtering-Correlation-Id: b588107a-8009-4154-61d0-08db950b1b87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wF8jbY4qnC+6DgRYrNi8bNaqUOBk5LNDzJmH0CgwY+zatjLRdlJCjrECfDw3XvsQiJuu4Pn13abxG43czM2GG6WmoHrlChqNv84R7fylcBSVjRxbskQ/Hv8MKhEWz2f2E+1zRlJ/3CGhvMDaL8/d0iak7FI5PFhqopf8/W3OnR1F2pahc41pqwc+onDva9H6sgAM5OLWEV+YxMBRDV2kcIDf0JE4ILGcdEC1o48ILpQ59Mr8DPCGBNPktnCWQI028lP1IOj8Yk0WBi6Ibs1mmyghz+5ZH59VR72hMWHN6m63N5XqsKdRXXJGJ3EuVfSq6LKeH/Zp+9XzvcDAmk25Q5ODxmYiYjhNPpNIpLNQt2UupwIJ+pFcjjTfsvi150ku2XP+QUiPoEkRiVYaEAd7t8qwxieZ7oQLoFZdNEicNAK1gHczjpZrll32+BNU3YEwJDdIB9YCgC7w1jdKhOYW1r5vEmukdj6ZBayRaEfoPsCFW/YJ49QUKjpMEu/8cXM75XAEWywVIl9IA6CJjPMA18Evc1Uw2XIQtw9brYHDoFEpWZ/Hfwtvlu7jRckJ++SICd8nsi2e27Yjwq9kfM+yAahd5UjVFf/BxSVkA1YOwx+UZexgxHf7hphJDHLI4VA5ElfNOkzSbjpZW50jEb532g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199021)(1800799003)(186006)(31696002)(66476007)(86362001)(38100700002)(6916009)(316002)(31686004)(8676002)(4326008)(8936002)(5660300002)(41300700001)(66946007)(66556008)(478600001)(2906002)(6666004)(53546011)(36756003)(44832011)(6512007)(6486002)(6506007)(26005)(83380400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dytoSGZyc1k2MU5mMXpGYlJKVUdqZjhLanJGbS9lcldLbS9HS1JpdjZWQWtl?=
 =?utf-8?B?ZnhLMjR6aDJUSklKOE9YbjVCV0t0ZmYvdzVMNnQwaDEyVUp0UFNBNVUrQlNv?=
 =?utf-8?B?N1V4Smg3KzdvbzZCd1ZQMktlQUwrNHNpRHVZcjkrbit2UWJPV3QxZXBnK3FB?=
 =?utf-8?B?QkVSMWVNbm8rRVpQZTVCcUw1d3h3dm5xMmI4NWR3dGtTVGc0c3dvRmZNRktp?=
 =?utf-8?B?RE5xLzdLNGxreTRxZkpFc3Jzdkp5ZmJvbFNleTBmWWEwbExFL3dmYmVYR21W?=
 =?utf-8?B?ZDFQdGdXb3B2QXdjbVhzRUU0dUlrNnlLK0xPMmY5cFFUOHFWQWZaM1ZydDhQ?=
 =?utf-8?B?Sk9nL2tyTFNwTXVjYm9kZnBDYzhuaDZtdTA1WEJOMWkyZGliMmNBdzJwMGpU?=
 =?utf-8?B?MnZoa01VSCs0RHFYSVF2USthZHJPUm91eGpiWXFzbTFHOFJqSnltU0NGN2pQ?=
 =?utf-8?B?YzBVbDl6bVB2MFg1ZVVlOGo0N095eU1vRm9pV3o5ZW5zTWJBcW5VTjYzRXNK?=
 =?utf-8?B?ZzJ6MWhJTVRTdEg3UGlhbmhFYy8wNmVlVjVaaEVIVXRKbThnQXNUdHg4RVEv?=
 =?utf-8?B?RVVNWC9GQVhJWjU3RnljaUE2NmRNZm9MaTQrallZWUIrMlp5U0IrV3JjZkxY?=
 =?utf-8?B?SmZHNkkzWU1Ea1VLb29YWUFwdWxJYVB3NTlOWkY2Rk1xT3ZKS0o2d1dpMG45?=
 =?utf-8?B?RE92QUxIYlFTd3VSMWJzZ0d6ZW42VWVQUk5HR3pXc2ErSitiNjhWazMzMVZM?=
 =?utf-8?B?cm9GOTRZUmQ0ZjdVUWFYdmE5dGg3dmpXT0ZWMUR2YWU3bVFrdDExMStoWVFs?=
 =?utf-8?B?ZjdnN2FVVXdVa0xDc21Bc0l3eGd2VEIycjdpODZVUzluWS9DcUhzNlNaWWNn?=
 =?utf-8?B?TWRjdnp1dTJGVkY5bWpTS0s4MWxpaWpNNVRLL3duT2kvcldvd3IrRUcxY2cv?=
 =?utf-8?B?ZExxSC9yMGtvU2FvQWdmdkVhMVVDT3o1VWJkMHFlV1hIQWJjTXpVTng1QkM5?=
 =?utf-8?B?SjU4Mm9hSzlYQTRXVmtZSE4rdXExWWJEdTFSU1RFZzVIRzI0MGJBT3VQSFFn?=
 =?utf-8?B?K0FveXdDOGVhU2M3NTE2NGdoUnp4bDZmd2VCMS9mRnVacTRaU1hnTUgzRFNG?=
 =?utf-8?B?c2JLaHZyRTdFajQrTzZhSFMvM2s4dlZWVzBMWXkzdWxhaUxPTy9wWGZkaGVD?=
 =?utf-8?B?cSsrQUk3c2hDWjRTbzZlUytyTFg2YXc2SlozR1NMZmIzN1ZMRXVWWEx3MXVz?=
 =?utf-8?B?c0tueUpiMFIyQk1ZOSs0TEdUQ3ZRS1dWVmpjaldRVHhlRzZJWUN5bkx3N0Iw?=
 =?utf-8?B?NjF2NmFyWk1pY2NVTnFrUzVGalhyd3VFMmtZWnBRN2F3V1dqN05Hb1hkYjBR?=
 =?utf-8?B?UmVLVFZ6SVIvQW9LeDU3Zk5ZVEcxSDYwdUNaZFc3TzRkc3JLelhVbnpWODBF?=
 =?utf-8?B?b3JRL01UeE9GUEZsOFNnUGFwaXhScTVQam1kNXFwQnlDenlDeWVCM1FuYzBW?=
 =?utf-8?B?b2hVcnByRnd6OGMrUWVDUS9kL2hvT05EYVR6TWhDMXJSeVRQSTJJVGpQTXZD?=
 =?utf-8?B?Y2JnczZjUTVqZDNNMFk0UnN6Qm5VS0k5VmVkVEUxWGc0YUtzS3M3d1FQT3J6?=
 =?utf-8?B?Y1Q5L0xyVmhTRHhidE91TnBwOFA1THBsRWFYcEZTQzBLWEpZOW1vYlNqOTVh?=
 =?utf-8?B?N2lMejcvVW53ZUlud0MvRU5XODR4Z3pVYTdSc1Faa04wYWNvTld3c0RDWkxJ?=
 =?utf-8?B?Mm9mTjk2aGZMakNSTk1oL3BDbGZ2T0VtUkx1THMveWdDa0ViK0xqMFpkak1j?=
 =?utf-8?B?czZtN2VQU2xFOUVpQlp6K3Juclp3bVVVeUV4WTJ5eENmVkp1Ky91OVIydDVm?=
 =?utf-8?B?aVdJdTA5dU5vb0tUSlBWaDdmM3VjeDMwMlZkV2hlZTkzdTFKcHZnOHFIZlNG?=
 =?utf-8?B?alNMSnVlUmZCK1hxMnppdmp3VXRMSTdoeC8vbjV1dXVnZkUwdEVsTURRWS81?=
 =?utf-8?B?eDcxcStlSkY2RU1VTTljVmVPNXRQVjVUbU9tQTkxQzJDMklvdlB4Y1AvYmRR?=
 =?utf-8?B?WWRkU3dOTkRrSzB4NFdwSVZldGdENGs0emg2eXZXczVTMWNyc2pXMVdHWEdz?=
 =?utf-8?Q?EDq5OelzJgQOBqLvP6ahD8Vsi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b588107a-8009-4154-61d0-08db950b1b87
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 16:51:54.6441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: //AuyNwEW7BmtkavSJHMQQbQuJPIry8NtPkdaFfopOQx2RNRftIOk4znTtNnJd1bfWj6+DsTAxYmuJ1gzvcCKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8758

Hi Jason,


On 8/4/2023 6:47 PM, Jason Gunthorpe wrote:
> On Fri, Aug 04, 2023 at 06:42:06AM +0000, Vasant Hegde wrote:
>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>
>> Refactor domain_enable_v2() into helper functions for managing GCR3 table
>> (i.e. setup_gcr3_table() and get_gcr3_levels()), which will be used in
>> subsequent patches. Also re-arrange code and remove forward declaration.
>>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/amd/iommu.c | 66 +++++++++++++++++++++++----------------
>>  1 file changed, 39 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index d5569eec0fe9..135fa087ce47 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -77,7 +77,6 @@ struct iommu_cmd {
>>  struct kmem_cache *amd_iommu_irq_cache;
>>  
>>  static void detach_device(struct device *dev);
>> -static int domain_enable_v2(struct protection_domain *domain, int pasids);
>>  
>>  /****************************************************************************
>>   *
>> @@ -1575,6 +1574,43 @@ static void free_gcr3_table(struct protection_domain *domain)
>>  	free_page((unsigned long)domain->gcr3_tbl);
>>  }
>>  
>> +static int get_gcr3_levels(int pasids)
>> +{
>> +	int levels = 0;
>> +
>> +	if (pasids == -1)
>> +		return amd_iommu_max_glx_val;
>> +
>> +	/*
>> +	 * Number of GCR3 table levels required. Level must be 4-Kbyte
>> +	 * page and can contain upto 512 entries.
>> +	 */
>> +	for ( ; get_count_order(pasids) >= 9; pasids >>= 9)
>> +		levels += 1;
>> +
>> +	return levels;
> 
> You missed to use the DIV_ROUND_UP

Sorry. I wanted to add comment to few patches separately. Somehow it got missed.

In our case,
  00b=GCR3 table is single-level - PASID size 9 bits
  01b=GCR3 table is two-level - PASID size 18 bits
  10b=GCR3 table is three-level - - PASID size 20 bits.

Hence I didn't include DIV_ROUND_UP().

-Vasant
