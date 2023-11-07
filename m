Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2639E39C
	for <iommu@lists.linux.dev>; Tue,  7 Nov 2023 04:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HZTGbLE0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ads2xwzOLNufH4AgWTqUG/WJwisR+sXcgYa6c1oDCvZyBQ/dpWgCc7+BdtejyN/HityjW6aa+NlUFFti3T9kNJoMmkbBhsEiskf9jKOgKBfRtW1Ps4dXPv2INqyfTA4/mNSZOJEyFOyRuQYSFxU5dn7c9HwI+afSh0PoPPMMghQ5i3HviAm6Gcp8mwdng34KSkCc2juwUYVwmXFpJJfR69J/xqcGGd4RGw76F6b7EQKgKaYb4bGXDBT94CYDR3vdXDdZkXvnirNSiZ341oAizcuNh/p9nmkMyxoucIqq/icT6Uquu46/vnXCs/enwFxS5VSwAdJ4y5AX5eUjGOe5aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xL0EUvQIb+8fZsZbAw7QZaq3ASocK5WitqnLMxgXDA=;
 b=j4S/B5SGhb9hofiqeNMKirK4pk7ddPZwLJ/U0mH+WaUNVbdYwTcjt4G9+GJe42XleHJWqdLLt4r17XdC7VoCrMpcaUEv3Q2uw6L7ZCopLysuCBnxhpkMK4Jrqk6vCaptnFycXEOC2mLAVwY1e+0k0bfAwcUXPQ2Bb7qHP/dXx5SPYVB9+p9By4/qZiL3Vt4mPAHSD9Wx1kz9VcThxRM56Fx+dMt+laLj/A7vv0/6CrQHhSTPUHZnN2z2ETV0UwHlRz/xXSoYWvAxoIme9Utszc7ly6UlrVb86hpsShm4j9QH6QrklI8dOBLdwNNhquuWQ/FTDCXynQM+Kvy3iToCEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xL0EUvQIb+8fZsZbAw7QZaq3ASocK5WitqnLMxgXDA=;
 b=HZTGbLE0y95G9GuVSttzT4ymK2K7+c1Xt6LOj79vCXKnNgCAvlL+uFPqxi71FpUREeqXI2/obesrCrlHhrB9HhrX0nkQM+xvzaxjNLaoFZJ0x9njbwxewA6YRtktIg3e0/SGIwVbTwC2kM6FCQjaSjaBlDuQSAry8oJEssOhfs8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 BL1PR12MB5125.namprd12.prod.outlook.com (2603:10b6:208:309::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 04:53:23 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af%3]) with mapi id 15.20.6954.029; Tue, 7 Nov 2023
 04:53:23 +0000
Message-ID: <219f8020-68c5-358d-b101-db1f84468db1@amd.com>
Date: Tue, 7 Nov 2023 10:23:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v1 09/13] iommu/amd: Refactor domain flush global function
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
References: <20231006101624.5912-1-vasant.hegde@amd.com>
 <20231006101624.5912-10-vasant.hegde@amd.com>
 <20231105175228.GI223197@nvidia.com>
 <e4f69ac2-579a-ab71-653f-81af3c3bb3fb@amd.com>
 <20231106130139.GF4488@nvidia.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20231106130139.GF4488@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0226.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::9) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|BL1PR12MB5125:EE_
X-MS-Office365-Filtering-Correlation-Id: 024d854c-bf23-4b6f-08a7-08dbdf4d7897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VEUlSmt1hCinwoGwXGYHPAZ4Obv04ok3KcU5W/corVt5MfarAtKs9HZMDoByYHBiu4gwDXiDNfA14kgVIvOhOrehs5uOrFxQynMmRtIJV6Tlw0nNZhj5HUf7u2m1ZEDzhFPFLvN3nDhiTelaplwW2gBAJVV/aYjIJUPk5UOZsEcXXWgfZkJPi/yMYIPjKu0MyNH8ep7TWnkBxy99oaYgvaHESo7lb03RZT2nptd1x3uufNlY1riButDpDQRCAynb23xu/YeSnaGvUamoru8/yJGr9nd7LfhTPUyawyD+Gy/KEZqMSEhpat9YVcU7sauujwQewr32Y32MKD7jcBDg4ekLQs18cBwpq1q6WwYNWAvgSG1dfw0vB2UqAMccuUNyKdXyTeUWHxvFGf5HEHxU3keZdWdmkYnXsNWShTtjbm/Hb3hlhCfrrLPnUUqRNROHYOSnq9IP9eAEsN2zOZoeRmeeR72PttTLp1G6Ck6/Nzuw1a0ZgX5m8L//3Q+ApTj6yl7eCf/MpCBGglX9iUSt85rmRSkVt9Ofd7I60nk9B5jOlTzWo5KFybMS5TRFviGRZCaSVdq8iiB63Egc/T5YPgQq0mvwV4rlkzNjeV+WKPJEbGomHijT19ggAFQb3OBMpL3ufqFYsPrMvk8ij+ghSg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(376002)(136003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6666004)(86362001)(31696002)(6486002)(478600001)(6512007)(5660300002)(53546011)(6506007)(316002)(66476007)(66556008)(6916009)(66946007)(41300700001)(44832011)(38100700002)(8676002)(4326008)(36756003)(8936002)(31686004)(2906002)(26005)(2616005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWRUUkFSZ1JaaS85a1JCcGtuRTVsUWJiNjhBTUFyTXc0bDdmakhSQnJhY3ht?=
 =?utf-8?B?aEVvc2JnUHFybjJtY3FLN05QY1ArK2VHS1N0dEkyRmYrK0QzYTB6SktxM3c4?=
 =?utf-8?B?VmZEMjNJWTFaSDQ2RG85cE5sODhpSnV1Ri9CVGgzN3pUaDdiWjlCT2JxM0lV?=
 =?utf-8?B?N3drSEhpOFNtdjE3cEcyN1hscnJTZkNHMWowS2c3eVdXcU5BR0x6Qmc4UW0w?=
 =?utf-8?B?eHJENkxJcytCVGFXZytEeGxaK3dUYVVIOU4zL2d0WkJ6dExQM3JvWTQxMWtW?=
 =?utf-8?B?T3h5aytDSmNleVdlQ09VZ050QlYycUpLbVJNTmU5Y1M1NHpSNWE3VlB2aHpq?=
 =?utf-8?B?c00ybmVSWkxvTy9kbE5KR1lGTEJkSTk2TG9BVGQ3Qm90NUZBRXZLS0lIZ3Vy?=
 =?utf-8?B?UW1XcGdDaXEyYVJmTU1LL20zNzRpSTMxM3lreE1rU0FnclAxR3A2bGsvQ1g3?=
 =?utf-8?B?Z1YyOCttdWhJa1ZwOGc1UkdUV29QU1NQNkZUN2RVWG1aK0ZlMDNLbXRoT1Nu?=
 =?utf-8?B?THFRbk1ZWHp1dXdkTnd5NFdBd1dyMWhscGRYRWNCNnVBQUZ6ak9LVGM4bXp0?=
 =?utf-8?B?TzIxTlU3WnhDRXFMRG9jTVpEMXk0Ri93dDVucU1MY2tYcXJHRUF4YUsyUlZm?=
 =?utf-8?B?WjdpRU9BN1hTaVZpWis0cEF4RnMyTGxXeDdkQnpwRFNRZXZyMXM4U3k5R0lQ?=
 =?utf-8?B?Y1dRQ2YyZHdqbnRFcFdjZ29XQkV0a0hWTUliNU5TTk5YOUlMMnRQS2xUVEVx?=
 =?utf-8?B?UXpVZTYvcGIxN1NNYTRpUC9NRWlSOUJZZ0hKZUR1dk0zZ0h4M2h1ckYzeHZi?=
 =?utf-8?B?d2tVNVZTeDQrWDBhVXFpL1kzN3ovYnMvUjRVa0M3Y0M0VnNaZnJOR0VMTnd3?=
 =?utf-8?B?V2pKcElXaFlHeDc1cTN5OXBIVXcxMDhmVHVteElEOFU4VG1QOS9kRldxeGRW?=
 =?utf-8?B?UE5HY0ppNlhyanFRSm03TlVodnltWTdWUkNzZnBDbGo5RXd4M0lISTc2NjBT?=
 =?utf-8?B?Z2FUTzUrUkQweTlDRkZ5d3NVZUliQjdMUFlmZ0dMKzZ0bW95UnVlalBkRXc5?=
 =?utf-8?B?Y0JreGl3V3RmeDFNb0F2SHFoeC92ZFM4ejRrMXZHSW9OMWJGMFN5Njd3RVBu?=
 =?utf-8?B?VVdhM20yWVpwRU5MUXIweEZ5MGltNytIU1d3ajV1Qld5Mi9yeGl2MzgyOGdr?=
 =?utf-8?B?dVVtbloyNnZmM1FkaitKeDFCSEFhRzRiYzIzVFAvZUVYZTNGa1BxeFVCa2Vx?=
 =?utf-8?B?UkFObzlWejlSNERpUnE5QnIzN0ZoTlhUNW5TZHBsZ05EbjF1SlNUVjZNN09H?=
 =?utf-8?B?cllqeG1yQ2xsVFBWNDlMQmVDanRrWktVNnB0M2lDQWVVYzBTSmV3eDlwZita?=
 =?utf-8?B?UUZrTExnREVqRVJuYUh2QVpHaXlMOHFtK3RpOFd3R1BLKy81SGlJRzdjTEI3?=
 =?utf-8?B?VDYrbW1lQ045VFUvUTV6MndoYkdxeWtpSk1VQlRUVlhlOHpLUlJzVDB6Q21B?=
 =?utf-8?B?c1psK1BzclhOZC96N3o4NXRnWWJOY3ovMlFnWTlGNTJ6UEpZeUJYU0J4TUhk?=
 =?utf-8?B?RjQrOHNSdlFnN2hoSEU2VnZMc1Vyd3hHL1NiOGdQbnZaL2NJcEtiL1VWNkRM?=
 =?utf-8?B?d0xCd3BLOGRsOWJqdjdXM2hxQTlYVjQ0NEZBeWxYQjVjZlg1K3JGakVtbmhB?=
 =?utf-8?B?Q01wUjJsZ0tBYS9PcUNvakN1ZHBkdWZVYUp0U054b0JpMjBOYW9BWWpwbmhR?=
 =?utf-8?B?TmFOM3V5RTJPUUdRV3lsWlcwOGtxUjMrYWY4UjdVN0FsNy9FSFhxUDZiRlc1?=
 =?utf-8?B?VDJOQUJQUEpmQVZieFY0Ry9Fa2d6UEg3cHl4Z1JnK05NU2kxWktyZmF5Vmll?=
 =?utf-8?B?RmdGTzB3YmxCOHdub083ZyswblU3N2lDYW9jdjAvMmRKQW1PQkcwUnJmRG5N?=
 =?utf-8?B?Q2ozc1M1dFplRlMvVlRXMmRPNWR6aU1xY1F4aFBWRTBEYkJsVnkvNUlvNG1G?=
 =?utf-8?B?ZXhRT0ZySDl5dWU1Ky8xdmdURUhPcFRqVmxYQnJvL0tPb1BrSzJZTlErZVVF?=
 =?utf-8?B?cGVzdGsyN0pZUnZGZFNNbzhMd3Y4OG1JWGx1L1NLcEoxUEhjVEU1TkdlcWdr?=
 =?utf-8?Q?ratXCgGgqKLGZak8P0uz/WjM8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 024d854c-bf23-4b6f-08a7-08dbdf4d7897
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 04:53:23.5145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eRlDY9sUpoWELR85JycoU9CcamB2pZQ7W42c0zfwcfFNyd7RnjtF2C0+XxTWS7bFhbmhDVilL2gUhGTG2LhMdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5125



On 11/6/2023 6:31 PM, Jason Gunthorpe wrote:
> On Mon, Nov 06, 2023 at 04:23:10PM +0530, Vasant Hegde wrote:
>>
>>>> @@ -1553,10 +1553,18 @@ static void domain_flush_pages(struct protection_domain *domain,
>>>>  	amd_iommu_domain_flush_complete(domain);
>>>>  }
>>>>  
>>>> +/* Flush range of IO/TLB for a given protection domain */
>>>> +void amd_iommu_domain_flush_pages(struct protection_domain *pdom,
>>>> +				  u64 address, size_t size)
>>>> +{
>>>> +	return domain_flush_pages(pdom, address, size);
>>>> +}
>>>
>>> What is the point of having this maze of functions? Just rename
>>> domain_flush_pages?
>>
>> Later patch adds PASID check to this function.
> 
> I saw that, I still think it is a maze.
> 
>>>> @@ -1859,7 +1867,7 @@ static void do_detach(struct iommu_dev_data *dev_data)
>>>>  	device_flush_dte(dev_data);
>>>>  
>>>>  	/* Flush IOTLB and wait for the flushes to finish */
>>>> -	amd_iommu_domain_flush_tlb_pde(domain);
>>>> +	amd_iommu_domain_flush_all(domain);
>>>
>>> This is weird.. The cache tag for a domain shouldn't necessarily be
>>> flushed from the iotlb when a domain is removed from a dte, should it?
>>
>> In this path we need to flush IOMMU cache along with device IOTLB.
> 
> The iommu cache only needs to be flushed if the IOPTEs associated with
> the cache tag change, and that doesn't happen during "detach".
> 
> Some of this is confusing because we've largely removed the word
> 'detach' from the iommu language, we now just have attach, eg replace.

But we still need detach() function inside our driver so that we can safely
remove it from current domain and attach it to new domain.

> 
> When the driver has to replace an iommu_domain translation to a PCI
> RID with a new translation it should run a sequence depending on how
> it is using cache tags.
> 
> Cache tag shared in the domain - eg the cache tag is stored in the
> iommu_domain struct:
> 
>  - Load the DTE/GCR3/etc with the new translation
>  - Invalidate any RID -> Cache tag caches (at this point ATS requests
>     see the new translation)
>  - Invalidate the ATC
>  
>  The cache tag is flushed when the domain is freed and the tag
>  returned to the allocator
> 
> Cache tag is unique to the device, replacing the translation continues
> to use the existing tag:
> 
>  - Load the DTE/GCR3/etc with the new translation
>  - Invalidate any RID -> DTE/Cache tag caches (at this point ATS requests
>     see the new translation)
>  - Invalidate the cache tag, since we changed the translation
>  - Invalidate the ATC
> 
>  The cache tag is flushed when the GCR3 table is freed and the tag
>  returned to the allocator
> 
> I agree it does not need to be in this series, but there is a logic to
> how all this should flow that should be captured in the APIs. Bundling
> all kinds of IOTLB and ATC invalidation into one call chain is not
> consistent with where things should end up.

As mentioned earlier this needs investigation and will look into it later.

-Vasant
