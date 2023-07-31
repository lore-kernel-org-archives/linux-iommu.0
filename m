Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199746110
	for <iommu@lists.linux.dev>; Mon, 31 Jul 2023 06:30:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9TRkE4K4S25UtMWWrcZUI8Q6p6FZVYTeYlSe8PjXV61LDS3KR1eODue5S7oXvxmOKBiDbtRZrYfA1+msD+189BR6AXhTadY6ObVwahLa3srMYwM6WVxqW/ZJIt/D3PH43kA6NcWX0O9Rd03TbhkxRNnQEzSOwsgQneMLSsqSXotRGV0nk8ZsmzWZWAXucrZ+mSAv3a77oUC9/I/4oIz2GNbmKGpxUvH+yPwATTZOcluLNnC0jhrxS/PeSoK9Ork8FpWOZzZDqkPUUC25Unc1b+WeDzYI/s0/cH5C7n/59GKOVQPCYyar+S0FxrfzK6riGFOmj/jdpbdClFg5s6+Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JA8iHq52/EPjzT3NMqKE77jibHLY2OCkvkD2V/clnrw=;
 b=Z/9wuIC/B5yhrJCWk7Etiks4hS4JZmeCXsyOwtAcvY5tuzkOW6ii9CwUokmbiZeNHBcbiqb4he+JuH1cdjQ+8bw+QTcsPYCPYoxviHzdJcdqcpgTGOe9obUoiPyy2KO1jQO+6gzM0NNI5QY1ZmRODHWuKh6oRQl/6w6iG4YbImyAoumKA5lzqfI0NiJWq2OobaM3hSEYEMvSpbasJlduGSFPfKpZx5fU3PyZvaO+szV0xiIcFSD/Rs34J5gE5uUoKmB/kWHgX9T7I8f12cc2GR7uGML9jkgDhBWn9+TG6lS03a5UP8y5+T9huxNQj17hFIgErS5+/eg/wREtndUpPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JA8iHq52/EPjzT3NMqKE77jibHLY2OCkvkD2V/clnrw=;
 b=yT3H2bK5A8E+InTthjxDZY3vl8mFzIdvGLJEqM8itNgqy8iGcndrX+rb2MhJnY5QkPmrfBnx/FNgXwqw6zU2lH2dwRBw17teBOdU3PbLO+WZVNp2kpl2qjsGbSAmeWWEt5s1YvWMLUg3goyS0B37YJ/bYlPTFH3JYX/IZb0wMmk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Mon, 31 Jul
 2023 06:30:19 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 06:30:18 +0000
Message-ID: <5c079520-f538-5894-d987-e8e0688979d2@amd.com>
Date: Mon, 31 Jul 2023 12:00:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 04/16] iommu/amd: Refactor protection domain allocation
 code
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230728053609.165183-1-vasant.hegde@amd.com>
 <20230728053609.165183-5-vasant.hegde@amd.com> <ZMPIaG9IktvVqbI1@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZMPIaG9IktvVqbI1@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::20) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH3PR12MB8659:EE_
X-MS-Office365-Filtering-Correlation-Id: 36e069c9-0ba6-4467-6d10-08db918f9bdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bLvx/22mHwZmG/xJEic9JOMGWTnZJsRQrgmSsVYZ/PhgSwDiXjaR3VFms0ut5Ss4gImL/vvQylnzM8v23y26kyousrx6c014tB7/PEF+y2RLRP22/IuvN1JVzwoERl9Fs/bPeKPXVa4Z1BrkCEu0wb5nCqf/I07TS4IL6RGApBIFb5M1ugDPojOMl6H7MlWEwneAQzLvTchu2nOaCUuaMb55hVEJnrBgwWfOOZeRtrQM8iMAX3/O/mwDCfJEylzJfJmj1lo8wI1bD9tkp/2r7JBZ6LvhjRQPayDjpsN5Sky4JGYpWT0wAPU4YhXOhknHjhq4Z/LkpjrD6WFyedpYMV74CTVjjAnequP6MM4vz9bCRVMdmdN3CHMJydjlUyn8Q9jW5msylMxbfpOxNZof6bpN7b/V1W5Wcfa7RgEkeiVvnFaw81EUFkvq4t05lcZ5BQa7lGr+AxyW+TQd43MAz1t/HofyLkvGp9t8ycABIercQS5CXu/LwjcpC/UiO1ttdR1UJ3hr7yufLvEFKHioyJVmfARiEKL6qYkHahBsXhHs/g8M/qqnNn29nCnHMF0fYqp8xPu0VWPqzVHdFBs6vJzBariK4YgxVF+sH0An4lfrGIyxlbgXMgCNvQmnHMgTVwFXWlEHmOFKxmtxhwVdgQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199021)(478600001)(316002)(66476007)(66556008)(6916009)(31696002)(66946007)(86362001)(4326008)(31686004)(6512007)(6486002)(6666004)(41300700001)(26005)(6506007)(186003)(53546011)(44832011)(83380400001)(5660300002)(8676002)(38100700002)(8936002)(2616005)(2906002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXBuanF1WUxRSmRSK25wQVV5SzJtZk90a25MZklTMHE3ZHdrVXhQYkNXNlJ1?=
 =?utf-8?B?RmtnK1F3OGpSUjUxSGlneTFOY0lNY3FsZHVnMytFT3lkVGc2R2FpZmlTZmxp?=
 =?utf-8?B?cndQZnljdWRGOG1VVUdXcjRLRVhKMkpZOXRZNHBxdHp6VDB1QlBJVlZQcTZn?=
 =?utf-8?B?RHc4YjgyK3ZDbURmNU1ub1k3YlJTYm4xbEpIa2ZiS3Z6Tjd2UDVmdDJYSU1P?=
 =?utf-8?B?eUlpcE13bHE2Q1d3eXllZVRXdUpaZER2TXdmWlBuQnZXcmtuWkdzbk0rN3p0?=
 =?utf-8?B?andoQnlGNHcrU00wa3JwSitNK0tMcy9yYSs2Ykd1aGQ5NEk0MzJkQmpka3lR?=
 =?utf-8?B?SDhWaGJYZ3Y5OWRReHkvQnBqTnFtZjBTUVFnbDJJWGM3YUwzMGVnK1p1OUVT?=
 =?utf-8?B?bnhSdXdlM05ML1V5RkVHd2xWVWgzb2NTSm9rZC80RnZKNHNEM1MzWEFPMDdk?=
 =?utf-8?B?Njlha0ZVU2xsNWpnaEFjNEErT09LdlJ0bXA2TXF4bDB6VGxZTTVVdE1FS0RO?=
 =?utf-8?B?MWxXck5kS1o3Unh0ZjM5cmJJVEJkaTdYZFBNVWE0Zkl2NjRiWFRhT3BlRHls?=
 =?utf-8?B?N3Q3S29ydUVZQkJrMCtNT2JpUWR0dUE5cGs2RTVzemdxMmtXZjJRa3gwMGNn?=
 =?utf-8?B?bW5jdEE3RERISm1OSDJ3VEVRVURLd2lSUzdJdnJXeS9MMkhHYkV2TjJGTS9B?=
 =?utf-8?B?akwzSU5IamFCbjMvWHJzZ2k4d211b0NyZVliT1lGeWZPbnRTajJWR3ExNkRM?=
 =?utf-8?B?dDNtUnI1S3RsMTU5QS9rN1RDTlNyam9PUTBlZmlRWTVnRVdOZWxkWlhBSzd2?=
 =?utf-8?B?bUMvQStVYjV3MUZ4cGdVa0I0KzZRcEJ2Y1h4TWtNOERVNmdXMDhoWkp2NUZr?=
 =?utf-8?B?ZzNNaHl3eTVHcHVRSFNJQ1dkVTdzeFkrcXI2Um00WCsrVTNmYjRkUWpCOTBJ?=
 =?utf-8?B?emlDeTRtbTl5dTIvRU5EVDBTWUJPK3V5MWlBRFhtZms1Qk9CcDl6cmpsdHRn?=
 =?utf-8?B?SHBvOTNHRzhvWnZCWktUY3pieVdpWHluRHRTYkFBdE9HbVlTYWhYckNZQnRt?=
 =?utf-8?B?aC9LMGJWMFlXaDJuM3QyQTE5TDNlMm5RTHVRUFZySkRhcm5VTStFVUl3bzN6?=
 =?utf-8?B?dHYzdUlacnI3VlBOa2VQbjBPdndWU2RKRGJLVytMbStlU2xxNzhmOGZIekZp?=
 =?utf-8?B?VEFBb3VETk0zNFNsZHZ0M2tXV0RnRjN6T0w2MzRUZllDT2JBYmd3L2Z5clNw?=
 =?utf-8?B?OHphQ2JXVm05K0Uwb1NKME1VWk52WjYvTDhOY0ZsdGQxSzNsSzI0U2x2U1dx?=
 =?utf-8?B?UU9iTTFKSjUwcy9CdkhOZVpGN040MFZTM2tQcUQ2L0ZQaC8zUlUyZVhqTTdw?=
 =?utf-8?B?aGtEUU5sc2g4NVlIV1lOK0t3eFQzZnNwenZuRExIb3dqcDFEeTYrSDl5cjd1?=
 =?utf-8?B?bWladUs4ZVVFaVlLdHJ3Q1M0VUl0UllaQzdJNE5oRUl4ZEVmY2RvbGtBdW56?=
 =?utf-8?B?dEVDc1FuZmFyenlVUXJJQXp6b2FwYjZ6TlZBUDd2dG9hM295MHVkV1pEMVNF?=
 =?utf-8?B?VUdTU3Jsa1lTa0U0TUxFZmh5RCtNSU1VNzl0aHhtL1R2KzF0akxkUkloWmUx?=
 =?utf-8?B?a3lnWDU0TThPcEFDVzZQd2hZMHRWS3Y2aWJiWStoN1kvcHcrcXlVVWpZNGZQ?=
 =?utf-8?B?dUg4ditNOWNzL1I2cFBPMlFCajg0MmNtd2NSQkFnd2ZvL0ZBTjVpYUZoT0RQ?=
 =?utf-8?B?ZEY0Z3Y0amVDYTR0V2doV0liVk5JWFo3RE02c1ZZcUQ2NHkrQ01UOUxOZUFi?=
 =?utf-8?B?Rk1HbHJOQ2p2anROVUJQVmF6RER1Yk9veG13WmhzWDliWUtVVHgwSGRtcGR1?=
 =?utf-8?B?UTllUEFWRnVZUFBWSmszaElsYjMyQWsrQlNibnMyczloTGFaNjEwL3lOa014?=
 =?utf-8?B?M0NJZzFVOTFSdFE5ZVlNVzRXejNFcHp1RnplNXJzU1NaUlJwZ1lBK1RNcUFr?=
 =?utf-8?B?WUFleUhYOXRNVkpHQXpIUURxS3dFMWxnYmM5RmVoQ280cktqekVaTHVkbGth?=
 =?utf-8?B?cTFUOE1jUXlhVlB3TE1ZM0c5NDVhU0VES3pWZ0xKcXhUbmhFclhyRUFXTWlE?=
 =?utf-8?Q?Gwtn+tR61nVlpJIZcs0ICyNOV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e069c9-0ba6-4467-6d10-08db918f9bdf
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 06:30:18.8676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: inOB6aNR4Jq7hXb+IdxlpJkm7te8v35a85wuWQGvDgCHOXB8tlrOV5f7EP+zpasXKKB4RTdLbBlQxhEtsv7AYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8659

Hi Jason,

On 7/28/2023 7:23 PM, Jason Gunthorpe wrote:
> On Fri, Jul 28, 2023 at 05:35:57AM +0000, Vasant Hegde wrote:
>> To replace if-else with switch-case statement due to increasing number of
>> domain types.
>>
>> No functional changes intended.
>>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/amd/iommu.c | 46 +++++++++++++++++++--------------------
>>  1 file changed, 23 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index c2cb541b0553..09749ad4445c 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -2078,24 +2078,8 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
>>  	struct io_pgtable_ops *pgtbl_ops;
>>  	struct protection_domain *domain;
>>  	int pgtable;
>> -	int mode = DEFAULT_PGTABLE_LEVEL;
>>  	int ret;
>>  
>> -	/*
>> -	 * Force IOMMU v1 page table when iommu=pt and
>> -	 * when allocating domain for pass-through devices.
>> -	 */
>> -	if (type == IOMMU_DOMAIN_IDENTITY) {
>> -		pgtable = AMD_IOMMU_V1;
>> -		mode = PAGE_MODE_NONE;
>> -	} else if (type == IOMMU_DOMAIN_UNMANAGED) {
>> -		pgtable = AMD_IOMMU_V1;
>> -	} else if (type == IOMMU_DOMAIN_DMA || type == IOMMU_DOMAIN_DMA_FQ) {
>> -		pgtable = amd_iommu_pgtable;
>> -	} else {
>> -		return NULL;
>> -	}
>> -
>>  	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
>>  	if (!domain)
>>  		return NULL;
>> @@ -2106,27 +2090,43 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
>>  
>>  	spin_lock_init(&domain->lock);
>>  	INIT_LIST_HEAD(&domain->dev_list);
>> +	domain->nid = NUMA_NO_NODE;
>> +
>> +	switch (type) {
>> +	/* No need to allocate io pgtable ops in passthrough mode */
>> +	case IOMMU_DOMAIN_IDENTITY:
>> +		return domain;
>> +	case IOMMU_DOMAIN_DMA:
>> +		fallthrough;
>> +	case IOMMU_DOMAIN_DMA_FQ:
> 
> you don't need the fallthrough there, just put the two cases together,
> the compiler recognizes the pattern

Sure. Will fix it.

> 
>> +		pgtable = amd_iommu_pgtable;
>> +		break;
>> +	/*
>> +	 * Force IOMMU v1 page table when allocating
>> +	 * domain for pass-through devices.
>> +	 */
>> +	case IOMMU_DOMAIN_UNMANAGED:
>> +		pgtable = AMD_IOMMU_V1;
>> +		break;
> 
> I've been wondering why this was done, it really should not be
> done. Unmanaged and DMA should be the same. The driver should pick the
> one with the highest performance.

This is to make sure in guest we can use V2 page table.


> 
> Otherwise it looks fine
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks

-Vasant

