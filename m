Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37DC10EA
	for <iommu@lists.linux.dev>; Tue, 18 Jul 2023 06:38:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhBXAF9tRJDY3sBySvKKMzBfZWG3YyxK4hwFIeBq589YL4iubI8TO7t8t6Iz2x5ntgHuIxfE+80zNliaxFLGDXw+pklZXVX6DV6e8Td0es25nlqRdRhJwuYo0gaA0H/WtS1tjIiAZjE/ADnsXcpgroc9VW+VtVBwlPlgzmQgW9gPeaPQ2w8WA8etwaTo39TRN/i3pH8++DqWSwS+BLpoNvVEPCHSxV96D8ewJ4s/0qhaBbJLyOHlnPf6ywmWdBUQrKrQJIMhVc242yMUKbTXMQK+nui0slrdmThWFyAsCJn+RgBLoFkviL0QwfqkCiupCMRKg8mgtd4k/VBWcRabUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlsuOFGdd26IR6/C9RFGSl0hfSeNIqobHxeEWfQl9ds=;
 b=XlySv6SFoGQYtWY+CPyBU62S3tdAMeEoYnjyqeDDKlBs84u/ehjTA6YLBA81ShYgCjXy09s6KchHf6+XYYjM64RNRsd/ErZKRtvIFpFil1ur15UUhkJ9ZcsayzPzPT3iCFnJhpmr7qiKHYYAlBoAMQdNtb0ek/ap7xjnjRl/7l2HCLwDQOiTdJmj/CXKuOhQF8EHu+zJSNMGW3y2OO7dYk4jG3mPKwDTYaNifIjqInzgyolYV14g2zUuIz2OqQRKDkYdzOUwqDYjCMOJgiYDu7QhXIzxp2Y9N1YKEDlCQHraqz2P5ln8znJojNcbfBKS/WoVve9OuA9dhN2wT8tYmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlsuOFGdd26IR6/C9RFGSl0hfSeNIqobHxeEWfQl9ds=;
 b=MCYjTgPrcKbKsLMLAJ+jZp30VhkoIMMkYEg4IKW+5XuRyk9sYXSUJKhVLpvUczGoKJRMa/O/HGQpf36v8zGIuFyMW3q1JDvs81vwwYRr7j5+CxEV7jz8U5FJuSjcHEyrfEN8F+CINbJXllWLLGrSOM7NeN7lrLtxDTLApb/TtFs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 CH0PR12MB5331.namprd12.prod.outlook.com (2603:10b6:610:d6::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.32; Tue, 18 Jul 2023 06:38:47 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::12ec:a62b:b286:d309]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::12ec:a62b:b286:d309%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 06:38:47 +0000
Message-ID: <1b5b9a47-0e4c-927c-c19a-9ee05ef66918@amd.com>
Date: Mon, 17 Jul 2023 23:38:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 11/21] iommu/amd: Clean up and enhance protection domain
 flags
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org
References: <20230712141516.154144-1-vasant.hegde@amd.com>
 <20230712141516.154144-12-vasant.hegde@amd.com> <ZLGFH6qERiRbD6cd@ziepe.ca>
 <db7fe0f7-77d9-f898-0503-d6da58cf25c6@amd.com> <ZLUyzrmRKhz4wwQ0@ziepe.ca>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <ZLUyzrmRKhz4wwQ0@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0029.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::42) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|CH0PR12MB5331:EE_
X-MS-Office365-Filtering-Correlation-Id: c634741c-afaf-4707-b207-08db8759a398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mikuvOO57IDWm9COgByvL+o2Mk/4wlMG+GiM9WUNbtg1/HvrWls76sQTGIACjCftbJoqyP3nlvbdQMXIedQSD9sxaBgpaJO9lwdyaAlY/34lrgpMyBcyjjWKyFYtFibLTRkmwtABVG36W4Emq9TUVbvifkIvTjSrbBBNdtanpP/EdHDTvHCmk6LugLmSClAh7zW03svF+OjpXa+Sn7SZVAuj62/dEHoWDJMA/SOUJUsfda263KFYf+UGevdeA0e1Ps/gE4jbVq3jjOK6r+/9IWaE/tcmnqeLVwOmKkXaJmyc0rwqeqUsSeQfuumUHy/WhJBz9ruD5XyHrhouv4Gt8812gQ10ybUDRxp1EYVnFlBMkBm/XNfOgHHPn9RbqSX0VSjQW/So/UubRkTc0SwWlPRSe117qTCRD2gDCzFjhqn/VhaSHSXbYx9b/f2eTZj1lg3EsHlbSuX/tcSUi+c1DHhSc1Bvy/wORIWkHY1VSwQ/o2CV6flRpM8iuPPwuiHHcyEnRZRY99Bw2c0+wW8C0WNV55TkGk5GsZ2TELgIoe1zbwtmCoablyldOnMoZNsOMbmxGtF9IN3hZn0/qal0NGQnlFtTIKGzW9uOq5jJfuTb1wFEqzyGb1qPcpGshSYn0pJz+oR8Q5j0lMGjW3gS2g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199021)(31686004)(6486002)(6666004)(478600001)(83380400001)(2616005)(31696002)(86362001)(2906002)(186003)(6506007)(53546011)(6512007)(26005)(38100700002)(6916009)(66476007)(41300700001)(66946007)(66556008)(4326008)(316002)(36756003)(8676002)(5660300002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dm9qZVgzWFo4ckIwcm1mMk9oNlRPazg0TnRSOFp4T2dEOFZkTjZldDFZZ0Rj?=
 =?utf-8?B?MWpHVkxTeHRBcTNMdGM3WmxPS1NqNVVFc1ZocUVFNDNIcTE1b2JjVm5RcW1u?=
 =?utf-8?B?UE8vUHhHYjk4MFU4NHIxUHJDVkltbzFFVTRQNk9UdDU5cGhKRlJ1K0JYNzZK?=
 =?utf-8?B?WVR3Ti9MLzN3d3dLVGh4b2Q1T2oxWGZIR2dCZXpqMnZXREZWYmZLUlhOSXZu?=
 =?utf-8?B?bStPL1Fhc0RuY1cxQ1hRdUpiUXRVUHdDd0ZRTGxpdlhhSkdBdmVjTVV3dnFn?=
 =?utf-8?B?N0ZpVkQ0TGlPdXV3cnp0MkVjSWxUQ1hIQmZVRkpSK21qUEVUTG9meGFnR3R1?=
 =?utf-8?B?MXJmRHFLQlZMUk1zQXdNZVh4UGZEbzl5VXhFUUNyV0l4c0t5YksxZGNWN2ph?=
 =?utf-8?B?dXNnTWV6VmZYelhHcE55RVpCaUdYdWNHai9hMkFodVVmK1RHdTlvamdvczJx?=
 =?utf-8?B?VkJpNVk0Q2NOd2ZydmtUNksweThwSWVIajdiWm9LZVIwd2lDZU1vVzU0aG5p?=
 =?utf-8?B?VzdZYW1oOVhXZUt1dkJEbWt1dTlrT2Z5RWt3NEd5SUxQNWNhVVRRNzZJRk5w?=
 =?utf-8?B?em5hMUpsNzcyWkJjRFIyaU1sTkRoT3BISS9vYlNaUjRkUnFTVHhwaTUxUXJG?=
 =?utf-8?B?Q0NNS3FGaGh5REFpNS9jc3p1cFJGY3ZSRjlMRHY4azErUmJneE8zMzNNSFF2?=
 =?utf-8?B?dTQ1QkpqZGFCVndKQkpmZ2p0MlZJTnV1dHgwY3FZMnA3U3ROaTAyMERTVk9h?=
 =?utf-8?B?aHA3V3J4ZksyOUpTdm9YVWdZSW9NUG16bUR5VlJiVDVibTRDd1h4SzlWdU5z?=
 =?utf-8?B?RWxwdTViYlFlcFpJd2dYbXpNcWZ4R2IxVDJIZWowOXV4dEsxejV5VVVsUXN1?=
 =?utf-8?B?MUhEeDNjdHR6NGIzbXRDOUxrdG44QjEwRno1RkdjY1pnVEs4ZHpzdkkyT1Jr?=
 =?utf-8?B?c1pYWlh3MVdBOHV1ZkVkcWRKd0tyUkJVT0I0c0R1UnhaM2hHMVM1bWdKY2lK?=
 =?utf-8?B?SXA5VW9xRjB3aHJ3SWp4K0JLZ2JJbGZTRmpwNUh0T2tMRGhPK0VCR3Bnd2o0?=
 =?utf-8?B?NU16cHJZMTVaVGgyc2o0YXovRkQ4ZCtyaFl3YzlIOUVwc1lQaVYxNml5OE9D?=
 =?utf-8?B?RlFWTURpU2VZS0trbFcwa25IVXE0UDVhbTF4UzVaMGh4QitpUi9Jbk1nSWdj?=
 =?utf-8?B?aE9pSzBsM3RiOTVSMHdpVWNJTDFMNm5ST2RhTW9BaGtqc09ucEFJV1M0QVAz?=
 =?utf-8?B?aVZQRlc5bWxLUFNhYU1EQUNtQjZFQTdpQWdXbkN3cEVxQnAxLzViaTJaSGZL?=
 =?utf-8?B?UFduT2xPbnJFcktOa2ZwVDlLQzZ0NnBNSmE3emN4eXRlOEZhYzI4QzNOTnBw?=
 =?utf-8?B?cDFtWkFOc1NUUjN2MFlydHJLbkpOc3NLV2hWSzdkdytMQzlkcHZmQlhnYXdw?=
 =?utf-8?B?RW1Yc0N5WVc5d1VWZHhFZkFOeW9ST2htMHQ2b3RBTnNCSzI1Y08reENDczk0?=
 =?utf-8?B?bWJWaWpYV0tzcnNXU1dVWVdnR1RFbGRXbG4yTDNndUg3WkE1WU80OE1kRXpm?=
 =?utf-8?B?dWNnTVkrKy9WS2RLaVg3ZWFaNW1BSS90U3d4c25wemJYK3ZhemdPYWlwZUZT?=
 =?utf-8?B?aEVvQ2lyN2EvYm9UZGdKa2xjT1p1cWt2QSs2bW5FeDlUTmpmb2lnbFE0NkZR?=
 =?utf-8?B?aGtuNXJyTForNWRGMEc0SWJBdE9VTmYreCtsZ3BONVRUWXRYbmdqUG9sUkNU?=
 =?utf-8?B?TjJXTkJ5K0k1U2FhQnhxOTNWWWtBTjB0eU1wNTlmTFhvTmw5R0xHMFl5RDNK?=
 =?utf-8?B?TFpCZDAwbUZvQStxdlVDa0phcGFKdFAyekNHeXVBTzNTOG9pcGx5enZ6dm53?=
 =?utf-8?B?cllTRFpYWnFpOWdMdDI4R21PclBpTzhCeHd2QlYzazFGdmJRUWtjWXhHY3ha?=
 =?utf-8?B?VEN6VUFWWjZtcEVwemlvc0pvOVRUV3VrZXR0d2grb2VKTjQ3N2dzK3pZVkFH?=
 =?utf-8?B?N1pDTG43QTBaNU9kTCs0QjA2UE8rdkxWOVBxUWFzcUpzV2R1Y0U4ckx4STIw?=
 =?utf-8?B?cXlTenNtODZYZTdJOVBYcDdpbjB2ZUpMMHpyRTJ6eEo1ckRnbGgyRkhFZnVI?=
 =?utf-8?Q?cCK+iJyUmlPW4scaEZf+ydQxX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c634741c-afaf-4707-b207-08db8759a398
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 06:38:47.1321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TbBFUkQdSwd46cY5KMxUw4XsxKVBIml/y0Uus53IfH2FfYsbfU24Hv9Ao20RrHbd9LLAdegik9pc2TiXSAhzYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5331

Jason,

On 7/17/2023 7:23 AM, Jason Gunthorpe wrote:
> On Sun, Jul 16, 2023 at 08:22:37PM -0500, Suthikulpanit, Suravee wrote:
>>>>
>>>> ....
>>>>
>>>> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
>>>> index 346c32343417..907af6e41ae9 100644
>>>> --- a/drivers/iommu/amd/amd_iommu_types.h
>>>> +++ b/drivers/iommu/amd/amd_iommu_types.h
>>>> @@ -443,13 +443,11 @@
>>>>    #define MAX_DOMAIN_ID 65536
>>>>    /* Protection domain flags */
>>>> -#define PD_DMA_OPS_MASK		BIT(0) /* domain used for dma_ops */
>>>> -#define PD_DEFAULT_MASK		BIT(1) /* domain is a default dma_ops
>>>> -					      domain for an IOMMU */
>>>> -#define PD_PASSTHROUGH_MASK	BIT(2) /* domain has no page
>>>> -					      translation */
>>>> -#define PD_IOMMUV2_MASK		BIT(3) /* domain has gcr3 table */
>>>> -#define PD_GIOV_MASK		BIT(4) /* domain enable GIOV support */
>>>
>>>> +#define PD_FLAG_V1DMA		BIT(1) /* DMA-API mode w/ v1 page table */
>>>> +#define PD_FLAG_V2DMA		BIT(2) /* DMA-API mode w/ v2 page table */
>>>
>>> "DMA-API" should not be part of the driver vocabulary. Does this have
>>> anything to do with DMA-API?
>>>
>>> Only "paging" domains should have IO page tables and an IO page table
>>> type.
>>>
>>> Maybe this is just misnamed?
>>
>> These flags are for struct protection_domain in AMD IOMMU driver, and not
>> for the struct iommu_domain.
> 
> I understand that
> 
>> PD_FLAG_V[1|2]DMA flags are used to signify that the domain is using v1 or
>> v2 page table to implement IOMMU_DOMAIN_DMA (which has __IOMMU_DOMAIN_PAGING
>> | __IOMMU_DOMAIN_DMA_API).
> 
> Again, no, drivers should have no sensitivity to
> __IOMMU_DOMAIN_DMA_API, we are trying to get rid of this. Please don't
> add more to the driver.

Ok, no mention of "DMA" in the naming.

>>> Also, shouldn't it be an enum not flags?
>>
>> We use flags instead of enum because we exepect to have combination of the
>> flags. For example
>> * IOMMU_DOMAIN_DMA + amd_iommu=pgtbl_v1 = (PD_FLAG_V1DMA)
>> * IOMMU_DOMAIN_DMA + amd_iommu=pgtbl_v2 = (PD_FLAG_V2DMA | PD_FLAG_GIOV)
>> * IOMMU_DOMAIN_SVA = (PD_FLAG_SVA | PD_FLAG_GCR3)
>> * Domain for v2API = (PD_FLAG_V2API | PD_FLAG_GCR3)
> 
> You shouldn't have these distinctions. There should only be one enum
> that specifies that format the IOPTEs are, and the rest is implied.

Still not quite sure what you meant by "the rest is implied".

Anyhow, instead, we could introduce struct protection_domain.pd_mode as 
enum where:

enum amd_iommu_domain_pt_mode {
     AMD_IOMMU_PD_MODE_PT = 0, /* No page table setup */
     AMD_IOMMU_PD_MODE_V1,     /* IOMMU v1 page table */
     AMD_IOMMU_PD_MODE_V2,     /* IOMMU v2 page table */
};

Then we need a way to distinguish whether the v2 table is:
  * Managed by IOMMU driver for DMA-API, which supports only PASID=0.
  * Bound using the SVA interface
  * Bound using the AMD IOMMUv2 API

What if we introduce a struct protection_domain.gcr3_flags, and use it 
to track information for setting up DTE and GCR3 table for the following 
scenarios.

Considering an IOMMU group containing a PASID capable device.

CASE 1:
-------
When boot w/ "iommu=nopt amd_iommu=pgtable_v2", the device would be 
setup to support DMA-API with AMD IOMMU v2 page table with PASID=0 in 
the GCR3 table for this domain (i.e. DTE[GIOV]=1).

Here, we can set:
   pd_mode    = AMD_IOMMU_PD_MODE_V2;
   gcr3_flags = AMD_IOMMU_GCR3_FLAG_GIOV;   /* bit 0 */,

CASE 2:
-------
Following case 1, the device driver calls 
iommu_dev_enable_feature(IOMMU_DEV_FEAT_SVA) and iommu_sva_bind_device().

Here, we need to maintain DMA-API mapping from case 1. We would keep the 
GCR3 table from case 1, and bind IOMMU v2 page table from mm_struct to a 
non-zero PASID in the same GCR3 table for SVA support. This is possible 
because the kernel manages PASID-space starting from PASID=1.

Here, we can set:
   pd_mode    = AMD_IOMMU_PD_MODE_V2;
   gcr3_flags = (AMD_IOMMU_GCR3_FLAS_GIOV |		/* bit 0 */
                 AMD_IOMMU_GCR3_FLAG_MANAGED_PASID)	/* bit 1 */

Notes:
  - This would also allow non-PASID and PASID capable devices in the 
same IOMMU group to co-exist with full isolation support.

  - The AMD_IOMMU_GCR3_FLAGS_MANAGED_PASID is cleared when the domain no 
longer contain SVA-enabled devices.

CASE 3:
-------
Current default behavior for IOMMU group with PASID/PRI capable device 
is to setup the device in pass-through mode.

Here, we can set
   pd_mode = AMD_IOMMU_PD_MODE_PT;

Subsequently, when calling amd_iommu_bind_pasid(), the IOMMU driver 
would set
   pd_mode    = AMD_IOMMU_PD_MODE_V2;
   gcr3_flags = AMD_IOMMU_GCR3_FLAG_UNMANAGED_PASID;	/* bit 2 */

Notes:
  - Since kernel does not manage PASIDs for v2API, and the device driver 
is responsible for providing a PASID when calling 
amd_iommu_bind_pasid(), we cannot reserve PASID 0 for non-PASID device. 
Therefore, device in this group would set DTE[GIOV]=0.

  - We cannot have case 1 or 2 with case 3 in the same IOMMU group since 
GCR3 table is currently per-group/domain (i.e. one default domain 
per-group).

  - TBD: Despite the upcoming SVA support, we still need to maintain 
support for the existing AMD v2 API (which we might consider deprecating 
in the future and put on bug-fix mode only), and we cannot break 
existing device drivers.

> GCR3 is the "PASID table" right? it should not be part of the
> iommu_domain struct either, SMMUv3 is busy undoing this mistake in
> their design right now.

GCR3 table is the same as PASID table,

Could you please elaborate on this part if it should not be as part of 
the domain? What's the new design for SMMUv3?

>> It helps keeping track of how the IOMMU driver needs to setup DTEs for
>> device in a particular domain.
> 
> Yes, I understand what it is for. It is important that the right data
> be stored in the right places or you will have to redo it all. If it
> does not directly related to describing the format of the IOPTEs then
> it has no business being in the iommu_domain struct or it's driver
> variants like protection_domain. It belongs someplace else.

For AMD IOMMU, GCR3 table is setup in DTE for each device. So, 
technically, it can be setup per device. However, devices in the same 
domain can share the same mapping (e.g. a domain w/ multiple non-PASID 
capable devices would share the same IOMMU v2 page table w/ PASID=0 for 
DMA-API support). This is why we have struct protection_domain.gcr3_tbl 
to avoid duplicate GCR3 table for these devices.

Alternatively, If we don't care about the additional memory to setup 
per-device GCR3 table, we could move gcr3_tbl, gcr3_flags, and any 
related variables to the per-device struct iommu_dev_data, which 
contains device-specific data for AMD IOMMU driver.

>>>> +#define PD_FLAG_GIOV		BIT(4) /* domain enable GIOV support */
>>>
>>> This really shouldn't be a iommu_domain flag, this should be computed
>>> based on what domains are attached where
>>>
>>> Eg this seems like it should be triggered by attaching identity to the
>>> RID with PASID enabled or something like that.

Actually, I am not sure that I understand this point.

>>> Why do you need to set it for the legacy GPU path?

This should not have anything to do with the legacy GPU.

>> The PD_FLAG_GIOV is necessary for when we setup the v2 page table for
>> devices, which cannot support PASID. With the DTE[GIOV] bit set, IOMMU
>> hardware would treat the request from these devices as if it use PASID 0.
> 
> I understand that, but you are supposed to deduce this from having a
> RID bound page table installed into a PASID 0 slot but other logic, it
> is very much not part of the domain itself.

IIUC, the scenarios above should clearly describe when the DTE[GIOV] 
would is determined, and tracked by gcr3_tbl. This information is used 
when setting up DTE for each device.

> (as we all the other variations of this flag when you set an IDENTITY
> domain on the RID while having PASID operating)

I am not sure that I understand this point.

Please let me know if I am missing something, or if you have different 
ideas to share.

Thanks,
Suravee
