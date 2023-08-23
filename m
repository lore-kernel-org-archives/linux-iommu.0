Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA564C75
	for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 10:48:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WADSWMKHSzMoVU3QTNjUJfM5728qQ3WVkYqJXCKL+6dxAjXkg72Pvd7VQgdyk3eWuDnjE7BLVcsUPHsC5FHfuxwcTYknVE875PuSERwokScATQ81nxzDw0+u7694qFcUyhf39m15MmwMgl9x8hc8kVeDTgOxm+vfeaQkzPvfqYOzyFWpnroY3X6irk5ClMjoF5SRxJjOCaY4Cb1lQY0juFcft1vnfGHAso1dSoK0FN1Ua4tsaEA+u99b7kCeFftDk89Rak1EfUNk8SxgGyv8aPz1lyByZgvxn8I99aGwIXI9Mi+jlS4N/dga5FDkHL52VwVrVeppLk5RWRvhyJLoZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykBkZyGb5o7ploD5O5uJ/SyrTM/sBcRM5WB2jhi/SVg=;
 b=PNkyVHQAjCSplo7iQyeEnOwli2Qq88QumZWtG/pD93XZ2Y3ZPUqYbpjvhRlDt2NeSLnrvIJnLtXXpJzRSvVmbA7UNW6d8/WtI6Fs0AM1LPrKa3zyEXxKzktakYNSkiQOQte3N8Qnh1ILxQl9FfxpjVGzgJYxH+MyFb+XsewHObdR3+uTnrYgLYC5scopfOkaJZWAkKQnf35wxY2NyCG9I5Wao3UCNOarvnC7MWpYIC9Nk/rmFXztbTVHhWOu/+LqA9GYXt+r9/LTfLl9Y8i12lHO4RRea9/TYM/jY+ZJoEekgDTBlyumCQGql9jei7l5gzuHVXRfxjRUnLjSKihR0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykBkZyGb5o7ploD5O5uJ/SyrTM/sBcRM5WB2jhi/SVg=;
 b=hLvJOIr/jfxGgf5ewhVXVW3vpSG7hP28b6m4QQE/887k5HZnedNqcFwFGfbGQ1EDp8uYhp+KX+9iUsl4O/qRnDiAqS3NyPJBkVBeXnBc1sndP9MAn+iaR/iCbj9oD7UmTQvIERtk4dSqUlQBx2wwN9h3cx6RJ77i+xzv5MWYsJg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SA1PR12MB8886.namprd12.prod.outlook.com (2603:10b6:806:375::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.25; Wed, 23 Aug 2023 10:48:24 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 10:48:24 +0000
Message-ID: <d67d016c-fe8b-ce2e-e335-02d4e598d6e6@amd.com>
Date: Wed, 23 Aug 2023 16:18:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 04/14] iommu/amd: Refactor protection domain allocation
 code
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 joro@8bytes.org
Cc: suravee.suthikulpanit@amd.com, wei.huang2@amd.com, jsnitsel@redhat.com,
 jgg@ziepe.ca, Jason Gunthorpe <jgg@nvidia.com>
References: <20230821104227.706997-1-vasant.hegde@amd.com>
 <20230821104227.706997-5-vasant.hegde@amd.com>
 <4e785061-b35b-774b-be06-2f2529de7774@arm.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <4e785061-b35b-774b-be06-2f2529de7774@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::17) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SA1PR12MB8886:EE_
X-MS-Office365-Filtering-Correlation-Id: a9a78b42-cdb6-4542-0305-08dba3c6799f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jh7/w6pKt2MN+U3Jnp0ImBm5CDxse7Gx/+AyKNtyA2AGI7LQKO9Rd9NMqxUz/EUF+iLthaXWCVnuWZpC+qj4nj/GbMDL3DIg6Hb25gJHG5yhRF2wLCs8EehWiUwSiJOTmtzzC2xa+eLieWYMu25PVTwHA05+PaWCOEg7EG9UYPnvnV6LK9VYH1+uIC4FIRZJTJO438bkoetoe8BPSlwEI/RM4TVvl48KovAF+pSnRWK/KErWOubbYQLaCIDPVRosckJQ6f1Xlg1DEgw9K7SOQrGbIx87v1KFjk+G3HmD5HHikTXWBf6XPZOnXDiBcAqVX2/S0hTuTWAf7aVXc/JnooBxnhpD4ibc+h6kaSlkQEzKxVL7wGwH82eNnss3510qau5MG3zyOb0yo0M7VXFahKFfBSqqkVyVzFGuv9LLcFhN6suAeI5vcutKRs6/Q2FFLa61bKh5e7n6z6RlPVh4DG8uaJbHJbw5LGe1O+T0p519jd00KkCPhtHat/j+Dz18V3/33u2azFMObjgEmWmmJ/tv0P1JwAfA9UWoaezQdxMOMV6d61Yk/QXv1J5ebezD3V/iQ56bTGKiDPIVWSnPpHWchZAMlnTtIJR0dVETuuYrVTPCR11Km4O/aCy0lLGQ8ZW6i6er9oT/8oKcaxWIjg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(39860400002)(136003)(366004)(186009)(451199024)(1800799009)(5660300002)(2616005)(6486002)(6506007)(53546011)(316002)(4326008)(8676002)(8936002)(66556008)(66946007)(66476007)(6512007)(41300700001)(26005)(44832011)(6666004)(478600001)(31686004)(83380400001)(31696002)(86362001)(36756003)(2906002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkNiVXhOOGYxZzNDaUk4L2hBMXlDcm9sNlBpckxXWFNjNFJRd29VL04vSTNE?=
 =?utf-8?B?cFh5OCs4VHpvaEV0bXUxbERXMFJYbzFyaGJ4UzVlMncwd1hEQ3RNa0VRWHZW?=
 =?utf-8?B?dnV6OFhka29hakhjdnBXcS91RXdvU3A5WkZ2OCtTQU5QeS9GUWpOVGFzM0Uy?=
 =?utf-8?B?dGEvOVB5TmMyQVBrU2p2SGNmZHJwbGF2UGdPL3RPRFhyWlVSUmcyVmxOblFx?=
 =?utf-8?B?b1UxVm1VV0cwMjNHOC9qekF2ZWJzcDQweUtYTElGSGE4dm5KSTI5QzhZai9n?=
 =?utf-8?B?dkY2OHhFVUttd2F1Qm4wK0srQkQvTEJHTTN6Z3lhV25lSkF6Ry9xM3pyUm9q?=
 =?utf-8?B?dXZETDFvZ3JENjhYYWR4cXBISlFJZGgyN0NBVGRDWE13ZEdoREtXcFBEU1g2?=
 =?utf-8?B?RnpnUTFwQUVHcEZkSDExbE9YUHBOa0tzL3ZrL091Y0hsVEcwL1d4YWNpZVpv?=
 =?utf-8?B?Uk5ScERVcFdiaFgwKzB5U2crSnVVdXpDbE1kOXUxZHFvem5VclpkSTFrNzBq?=
 =?utf-8?B?OU1EbFRGZ2gxdUljSGhNOEppS1BBSGdkWVJZWCtYenlJRzgrWGgybUhTWGxQ?=
 =?utf-8?B?SUxWdVlnb0JCaEg1RU5aTEZ1bUE3VGZUcE52NFd5ODlPWCtMWlowcmUzWkE5?=
 =?utf-8?B?K28zSnNlWGx6NGdIcG1ENFNuTWttZFZ4UWtONk1wTkhIcVM5VGhWeVVsOXhl?=
 =?utf-8?B?dkxOVkFnNnl3UnJXQklzQ25aV1YvYWdMcXkrMFI3c0EvS1RHS2tyUHdQTHVj?=
 =?utf-8?B?Rkh5NjRoRm00amRibVYyVzN0ZFJKSE9BcWIrQjVBMnJYK0hSdFdUOE9ILzI1?=
 =?utf-8?B?cFo2SGsrWEJqOGNwL1FoR0M4Rzc4K2ZuVEhrSWlqWGEwdnlXYjBCeHdBNjVK?=
 =?utf-8?B?bllXTENnSlpqenBlT2RQeGl6Z0VhRkNXS1RTWlgrRCtvOVZNQjh5L1h6R2ht?=
 =?utf-8?B?ZzFBV2pjOTBZWFlqdjZuSEQzNlkwMmpSVFZjNFFSUG1SRGQ2RitOdlErQTIr?=
 =?utf-8?B?ajV0ZVZIOUdaUlNOdnVNWThyYmFlVDczZkZYR0hrNFhPckVTOTF5YTNVR2tD?=
 =?utf-8?B?ZmxUanRJdEVvM0Y4cEdLMjU1LzZHbDJXV1FuYkROVGRTR0xFR2JQUWtuV0Fj?=
 =?utf-8?B?dXdMbytTdWRKTFZSK2MvQ0oycWlJRGt3Uzd2Y2dMTGI4S0RKUE0wUFIyeVNF?=
 =?utf-8?B?cHNhM2VnMWtPNFg3Q2NTeElMVzI5M0VDcTZzdXZ1MG1JSVZtYmttVVV1bFRo?=
 =?utf-8?B?VTRkR2tuQ3NhSUptZ3Z6STc5U21WTTZsejNYYnp2THFvMTM2Ulo3Q2Nna0t4?=
 =?utf-8?B?UytNRkM5U0M1dS8rSUVBTEE0cldGSnVUS1h1dGQvZUxiRnE2c2lha29US29k?=
 =?utf-8?B?S3Uyc0Y2WWc5ekJGeko4TzlnNTJ1cTdlOE5vck9NdjVIUkgvMzM5MU8va2Y1?=
 =?utf-8?B?enZwNWxTR2loNFVkeTNUd2hQN1JwNEhvZGRUaEJKQzMyOVptWWhBc2pyN3Na?=
 =?utf-8?B?aEtKTjFxOFZYczZHNmY4R3VPVDN4b3NMK3AweEowbTBBTGpxaW1GaEZ6U1g1?=
 =?utf-8?B?NlcyZHBVSGNCYkk1R1RTNW05b1ZMQjNOOVlrNHFNZkJOVVJsMHlqZW5oSUc0?=
 =?utf-8?B?NHdleld2VzBZUGQvTXdqdUltazJsNFdtQUtkV1plczhoSmtNOXpGVG1kZTIv?=
 =?utf-8?B?SXNvMFQ5ck1TMGZmMmVmUTFEL2JRZE9FWGFvTTR4U25NQzROaHYwK0VaZENM?=
 =?utf-8?B?REF3WUZVZDhrbGVEcU1JeGhXQ0JXSUh2TWhxa3NOOXhkTlVXNk5DeThPU1ZP?=
 =?utf-8?B?QXlEUTJNOFNFRHFrMzhtZVdqbFc0WFp0NGhHUTQxUWxtREplelZMWTdBZTdy?=
 =?utf-8?B?djVaUW0rYm9panlXYXQvblFjak9FY1FDdEpCVy9HVTJJMERLem9xUExNOTRh?=
 =?utf-8?B?OUpmZk1RbHEvVVZDNWxqVklFd04vTEhZajNnbjhiU2dWVjkwbHk2cjY0b2x1?=
 =?utf-8?B?M0RjVVJZZkw0QS9XWjlYV3ExbGRXeDVTb3E4WnorU1RWZDBkSTh5SFZ3TzBN?=
 =?utf-8?B?VW95elMrVWJMcS9wRkFoVmN3SnA1aDk5eGYrVjVwVnFkQit3dk5yaWlFcVFn?=
 =?utf-8?Q?COOnS3Xu1mLlnPtuYZRNew1UP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a78b42-cdb6-4542-0305-08dba3c6799f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 10:48:24.6648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqSpBTHZ54w9xrP1NJ/59X7eYTb47ci7n37eiKLcMBsozvqpEJiucWAJgYlhZQadeRG6NONTpy6OOd+SV6yOrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8886

Hi Robin,


On 8/22/2023 1:36 PM, Robin Murphy wrote:
> On 2023-08-21 11:42, Vasant Hegde wrote:
>> To replace if-else with switch-case statement due to increasing number of
>> domain types.
>>
>> No functional changes intended.
>>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
>> ---
>>   drivers/iommu/amd/iommu.c | 45 +++++++++++++++++++--------------------
>>   1 file changed, 22 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index c2cb541b0553..d5569eec0fe9 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -2078,24 +2078,8 @@ static struct protection_domain
>> *protection_domain_alloc(unsigned int type)
>>       struct io_pgtable_ops *pgtbl_ops;
>>       struct protection_domain *domain;
>>       int pgtable;
>> -    int mode = DEFAULT_PGTABLE_LEVEL;
>>       int ret;
>>   -    /*
>> -     * Force IOMMU v1 page table when iommu=pt and
>> -     * when allocating domain for pass-through devices.
>> -     */
>> -    if (type == IOMMU_DOMAIN_IDENTITY) {
>> -        pgtable = AMD_IOMMU_V1;
>> -        mode = PAGE_MODE_NONE;
>> -    } else if (type == IOMMU_DOMAIN_UNMANAGED) {
>> -        pgtable = AMD_IOMMU_V1;
>> -    } else if (type == IOMMU_DOMAIN_DMA || type == IOMMU_DOMAIN_DMA_FQ) {
>> -        pgtable = amd_iommu_pgtable;
>> -    } else {
>> -        return NULL;
>> -    }
>> -
>>       domain = kzalloc(sizeof(*domain), GFP_KERNEL);
>>       if (!domain)
>>           return NULL;
>> @@ -2106,27 +2090,42 @@ static struct protection_domain
>> *protection_domain_alloc(unsigned int type)
>>         spin_lock_init(&domain->lock);
>>       INIT_LIST_HEAD(&domain->dev_list);
>> +    domain->nid = NUMA_NO_NODE;
>> +
>> +    switch (type) {
>> +    /* No need to allocate io pgtable ops in passthrough mode */
>> +    case IOMMU_DOMAIN_IDENTITY:
>> +        return domain;
>> +    case IOMMU_DOMAIN_DMA:
>> +    case IOMMU_DOMAIN_DMA_FQ:
> 
> Nit: drivers won't see DMA_FQ any more, so you don't need it here (looks like
> the addition of the original line above crossed over with me removing it from
> other drivers).

Thanks Robin. I will have follow up patch to drop DMA_FQ.

-Vasant
