Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4846D1AD
	for <iommu@lists.linux.dev>; Fri, 12 Jan 2024 12:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Br6iozxb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdwVq1QS6yPR2f02SLnponU9/oC/9F9J6lQz/bHlrdD1vP1+UyWdt9AspxNhQxBznr7srUnNtQToob8XemniQ9/1DRPSRLuIN764dRzCOn7KT/VGz5zCosR0zfIR/sFujl9rfFvSei6aCDIeS170UaYUpSRi7OVT3TAa+Q9zgG3l2KRsqOeCnc9QFsoDxNUZyC3kUyK27m4VbFTm4dIAoWjOwZcrgUhjNyTOCrJj1Taz4PzYWhG+WPxjzygY8/Xu8WZzKTP2oaJOq4zo6qMHg5bOSJJbVWk7Asn8qvHQzojFCZ62hEy6Tud0W6VVm+aifQybNwhyjkjnuKCx5Uh0RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7A9upHrLR+RPtbZNrdaRJACvj38ZhNeJsbnXnBCKzAI=;
 b=PgyJHim5OPuM3YTalWyYkP5XKsIuX+paD8+x7FT/h7Q5F4VBw6JdEIGuzpeDtoeobrsziqLSeFeQAv+s1uZKeh+RKwQpbBFZU2AI1G6NuNKHM4hhqGi01GBCFrFwyBMRFZISSzfgAS7iOAnWGpGLewyIwTXvZpGNnVHEOvc9mHzG5lMZOXHXdD+WGz30adFbfszBGCUoMPG0AB/MTi2scq8M7Ve/phEDDTh6tTkNoFpPIBklTI2RvcPbTlPQGSg9ms9KLNA1k2XumhRVzbN9FciNNdMEh30GrOFKCQy7ZddkXI+JiuqK8HqbTGx6HNdDq8t4u36V44DfBfPrSsWlWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7A9upHrLR+RPtbZNrdaRJACvj38ZhNeJsbnXnBCKzAI=;
 b=Br6iozxbN3irE+5+Iz3sFkvs2RnOyP6Yof7wzyB21XD9t0Bd2ii1Y0G/fsJKA70iFopbR/DjhuRm+JbfbDR5q8UR6r578roRLAqQWINypyE183Cei0OES8uEnYdDPF3Nt0p07Pb2o/cfXYBQMTQncf+/yn5IIhDPUn5/UK+vN3c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SA1PR12MB7037.namprd12.prod.outlook.com (2603:10b6:806:24c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Fri, 12 Jan
 2024 12:45:15 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb%2]) with mapi id 15.20.7159.020; Fri, 12 Jan 2024
 12:45:15 +0000
Message-ID: <0215990a-dff1-c6c3-bfa1-c90fa63b0c7b@amd.com>
Date: Fri, 12 Jan 2024 18:15:07 +0530
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
 <d71a2bc0-ed07-53eb-faf1-bd36b6ff6ffb@amd.com>
 <20240111135952.GV50608@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240111135952.GV50608@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0175.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::20) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SA1PR12MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: cf46d970-877c-422d-f95c-08dc136c531e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cT7Fjd+wAOl6CoroWE+UbASD0iy3ktyp2nELsdj8k29a0VXm/M4lhdbmJWea1CeT9RkB2ZczOP/bXB3y1FcectSADaXVJxPR0aSsKT376QyKlN0mZRsqh3pjjF/83MhxDu52cCz9XxCgv8EFZR+GL0UMTre+Cs/NDPP0WCiNV9vMnwxJwVj4w4+vtdbM5RT5Fw9+xRY/i+6Y0c5ePEPg4rvmemoaTRaDxn4pHoQ4tLXlJgiVZhFaUQx1NzHPs9hStPanWSskBh/1K7RC5kW1NOOic8A/SBeFX7J1isWwrXQF9TSFJMvc0W2/U4RAqT36BDpKnk+pPxifutoL0MKcnTTEUC97wMBpwaUlFfcNcwHgraQAe+ZcisJkqMjuofSr/hqgsCPdjMiwiriw+0kiZpnjaVbU5wiaImYjGLK3BB+1zD5oyXKaHKeR9SMct0eoktOjUDv/G0bOzfphecjE+cbHuox17xpDw9DRIBZ13lLL+3gOxdtDaynspGNPKbOzvpZiON3LQlEUdTh/1vSwvxJMo0Rh/8Lxv89eVw9lvL+0tL206JhyzahltXl0i9Lp50+pppQBxlsSgLaOyzYCUtY3bjAr3TgPQqS44FPsNbKPpBe1tr6oq1dEKgMJRXpKKreywv2ww3J67x/F1VG7+g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(366004)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(2906002)(5660300002)(41300700001)(6486002)(83380400001)(2616005)(26005)(478600001)(6506007)(6666004)(6512007)(53546011)(31696002)(31686004)(86362001)(38100700002)(8936002)(8676002)(66476007)(36756003)(66556008)(316002)(6916009)(44832011)(4326008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TE9DYWtDUnJyVitoYms5dGdBVmxRY0FGYUJuOHdQcHhYQllkam9TT1pvOXgx?=
 =?utf-8?B?d3FjeWhXNW9iZU03VG4yYkVRTUgzcVY0bUIvM09KeXhwZnF0Zml1cEl4aEts?=
 =?utf-8?B?R1VWWEJQMWRHQTdpK3pSYVVaL2dJQ1hwdDB1ZUJvUmhZVzUrdU9wTFRBTUJU?=
 =?utf-8?B?V0RBVHozTW1JZ3J6YTRkL0phN01odENBWW4vaWxlQ3loWHozU2tzUFpreVdR?=
 =?utf-8?B?M2NBQjFBTi96MTBGN1ZrY1c3RzE3VFJ1eHBkMTZuT1JxbC9ZeEtXWk0zaXhB?=
 =?utf-8?B?TWwwdFFTNGZBOGlsR3VkSEI4QlpZL21kMlU4QU1oenBYME1BR2VxZ1pBMnMr?=
 =?utf-8?B?R2pvWGl6V2VUQ01mSVJkMlJib2hEMHEwV1kxbk45ZFNOa0E3WWxUMkhBOFla?=
 =?utf-8?B?QXc0TUtFSkJoU0NYYVBXZHVJYlFLNUIzTnBxbHd3UHVHd29GeExQdVhQM1dq?=
 =?utf-8?B?OStCUmdaUnhJWlJxYkRycTk0QnU5dXVTYjRVTEVnSHdNZXJQVVJqd05FYVgw?=
 =?utf-8?B?WlhKVkNnTlJuWUtqYzJTKzVkQnlBdm04bE5PdENkRjhGRkwyeGtzU2VsVDRI?=
 =?utf-8?B?WmV6Z3U1ajZoR0RvR1ZsVi9BVGZJeVo2MzEwYkxUbHByakM4Z0QzU3RCWDJQ?=
 =?utf-8?B?SXpLbzM0NnZ5ai9NdngyNWNCNVJocWEwenFHNklQeDNtbEFqcVBSTGgwVHRm?=
 =?utf-8?B?dy9JUGErNmh6dEhVQ2FnTWJaTGV6djgrSjBhbVdqSnJwK29JRnBZVmpWR2lw?=
 =?utf-8?B?TzFOS201bWgzTE9UQlpDbnp4eGtuM1ZrL2F1b0pxTGplbWREYmVwZHhYMVQ3?=
 =?utf-8?B?SlpjSTNHOXc5dDRZWEZRcStqN2t3QWluYk9VdGlhbkJRSys3K05BOS9NNm9L?=
 =?utf-8?B?NThObXpCWXYyNG1EeVpOUllzL1JCNFAxUm16eDlGN3g1UGxOamRMelVGRGE2?=
 =?utf-8?B?emdWaU9pdnpFY3QvR3JBYUhFN2hWc3JESnoxYXJFK2Fwcmdyb2luZHN2MFdT?=
 =?utf-8?B?VjhVSU5OU3N5bkVpNHpwQlNaMmFOSHc4dkZ1NUc0dVV5dHNFYUlNMFJxR1dB?=
 =?utf-8?B?SjFySUQxV3RMb1hlNWg0d0ZteWZ6dTFpT0lPOXVqY0pxQjZiZDFodDBPc1Z3?=
 =?utf-8?B?L3lJWGNPeWtQRlU3ZE52YU1rVkFlY0xlUzF0dHg2bnA3S0U1TVN0WEtHR2hE?=
 =?utf-8?B?OWNtVjhmblVXT0g1MlJOMVJrM01JKzdGQnRqd05wRkdUUEdWcHlZYUdLcVdh?=
 =?utf-8?B?M2xrN1pnOVRZSXQ2UENaUUhualVFNXRJQ20vODlMd0xna1cwRFFpclhuaVA3?=
 =?utf-8?B?NENGaGtHQlBNNTVuSHoyMm8zb3NRNjhibmx5YXF6OFlzWTgyZEp4b1FwUHpP?=
 =?utf-8?B?MG5VUTJ1UVZ6N05oTjNWWlpiSFgxTFdYSkg0V0JwWGI2N2lyOG9oNDh3YmFT?=
 =?utf-8?B?ZGlsajkweW42WEhNZ00zU2lTL0t1VXprb0o4M0tjS0JHVElMMWNndldnVGEv?=
 =?utf-8?B?U2dpRUorTGZXbVBpWnFoTHlEQ3pQcC9ZbnhtM3B4SWtQYmgxb24rbGYrYnZZ?=
 =?utf-8?B?Y0ovaE5ESStQaHZXZVRPbW5OYkcyOFdDRTZoL2ZPZ2Y2RWJVS1NtajNNeTFV?=
 =?utf-8?B?a2gvdldSM2J6ak94UEl4KzQyeWZoVng5SU1OTnhpeGtHeUc5ZW5wWFdNRUhM?=
 =?utf-8?B?dWtNcm9yL0dQVlB3ekpVV1g0Z2dXY3FJY05HeXI4L3VLTWxacTFlNVRWN3k3?=
 =?utf-8?B?R1Y5anBDUmRqeTNsMFFkbFFlMTNHY2grNWN5V0tFejBqOStIeGE2eDVVemdN?=
 =?utf-8?B?SnlXZ0NzQWpVNlI0alpRRDg1M2FFc2tjTkNHdjFCTk5PUEQ1NUxHV0FCd2FD?=
 =?utf-8?B?U09FTitUa1BEME1DblVSa3pyRlpia3lRSU5SU2szTG5PRGdZaW52TmRJckc4?=
 =?utf-8?B?aFY1QnhUSTlJb2QybjlMSXM5S3pIRGF3c1NLKy9TSyswTkdEZ1Q2WkVNNUdk?=
 =?utf-8?B?MFBCa1lFOE82dFVGVVNjOEZ2QWtQYXU4cURTWkZhQTlKb2V4OXNxNTFnbndL?=
 =?utf-8?B?WWhFM2RKTjkzckc0SDUxV0ZUTWptVFNNUUtoV1hxWTZFVzJtSmNHV2ZkWDVO?=
 =?utf-8?Q?zG7SowbETvoJ4GSomMj5Atact?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf46d970-877c-422d-f95c-08dc136c531e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 12:45:15.5111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qoo1SLHU+Jx87ASVFzqMSmWK96wAlSR/dLjmDBy/Uh9aXL9rqI5PECWF275LU5rYPb/fhzPCHIKssio0zVCy/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7037



On 1/11/2024 7:29 PM, Jason Gunthorpe wrote:
> On Thu, Jan 11, 2024 at 04:48:01PM +0530, Vasant Hegde wrote:
> 
>>> The code seems to be fine, domain_flush_pages_v1() looks optimal?
>>
>> I'd say its optimal for given state. I have a patch to move dev_iommu[] to
>> xarray. I am planning to fine tune and post those patches after SVA. With that
>> changes it will be better.
> 
> I'm not keen on an xarray, that isn't fully addressing the problem and
> when Intel did it they messed up the locking..

In our case it will be simple as we just need to track attached IOMMUs and we
can build list/xarray under protection domain lock. Either xarray or even list
will do.

> 
> I would like to make a shared helper to solve this problem. A rcu
> backed linked list, with a helper API to iterate once per-iommu.
> The RCU is a bit tricky.
> 
>>>> --- a/drivers/iommu/amd/amd_iommu_types.h
>>>> +++ b/drivers/iommu/amd/amd_iommu_types.h
>>>> @@ -842,6 +842,8 @@ struct iommu_dev_data {
>>>>  	u8 ppr          :1;		  /* Enable device PPR support */
>>>>  	bool use_vapic;			  /* Enable device to use vapic mode */
>>>>  	bool defer_attach;
>>>> +	/* Per device domain ID. Used with V2 page table */
>>>> +	u16 domid;
>>>
>>> This should really be put into the 'struct gcr3_tbl_info' - logically
>>> that is the struct the HW cache tag is linked to. ie if the gcr3 table
>>> is the same pointer then the cache tag can be re-used by the HW.
>>>
>>
>> The reason we put it in dev_data is because its per device ID, not specific to
>> GCR3 table.
> 
> But from a HW perspective it is actually linked to the GCR3 table as
> that is the data pointer that is being cached. Two devices that share
> a GCR3 pointer can share a domain ID.
> 
> If you want to optimize the domain ID tagging the logical way to do it
> is to add code to share the GCR3 tables across devices. If the GCR3
> table is the same then the domain ID can be the same.


Right. It makes sense when using V2 page table. But when we are in V1 page table
we don't have GCR3. We will revisit once we finalize some of the vIOMMU stuff.


> 
>>> Then when you want to optimize for the no-pasid case then the right
>>> way to do it is putting a 'struct gcr3_tbl_info' inside the v2
>>> protection_domain.
>>>
>>> The DTE will point at the v2 protection_domain's version of the gcr3
>>> if the PASID table is empty, otherwise the DTE will point at the
>>> struct iommu_dev_data version of the gcr3 table.
>>
>> This makese sense if we are sure we will do per-device-domain-ID only with V2
>> page table. I still need to see how SVA support with vIOMMU works. For now I
>> will keep this in my list. Once I have better picture I will fine tune.
> 
> SVA support is ugly on AMD - you need to flow through the virtual
> domain ID to a consistent physical domain ID even though the guest may
> have a DTEs tagged with the same domain ID but different GCR3
> pointers.
> 
> Most likely the implementation will have the physical domain ID be
> part of the nesting domain to achieve this.

Yeah. This is something to figureout after getting SVA upstream.

> 
>> UNAMANGED Domain and PASID support:
>>   - I was considering this scenario as well. I don't think I understood the use
>> case of and how invalidation is suppose to work here.
>>
>>    Can you explain (again?) the use case and how invalidation is suppose to work?
> 
> Invalidation is no different than any other V2 domain use case. The
> domain ops trigger invalidation. In AMD HW you need to record that an
> unmanaged domain is connected to a domain ID & PASID and push the
> right invalidate. The driver can't just assume the PASID is 0 for V2
> unmanaged domains.
> 
> So the implementation is to track the attacked devices, iommus and
> PASIDs in a linked list and use that linked list to generate
> invalidations. Intel and SMMU (after my patches) both have
> implementations of this. I would like to unify them to a helper
> because they are both kind of bad.
> 
> There are many use cases for PASID mappings without SVA, including
> SIOV-like devices and virtualization modes with non-SVA PRI.

What kind of page table will be attached with non zero PASID? like KVM page table?

> 
>>   - For PASID capable device we will have per-device-domain-ID
>>   - We will have default page table setup (PASID zero in our case) during domain
>> initialization.
> 
> Domain initialization???

Sorry. Its typo. I meant during device attach path.

> 
>>   - We attach PASIDs to same domain. We can add this to list (protection domain
>> device List info - which will have dev_data/PASID). So set/remove PASIDs is fine.
> 
> Right
> 
>>   - iommu_ops->iotlb_sync_map/flush_iotlb_all will flush PASID zero.
>>     Looking into intel driver they seems to be invalidating all PASIDs in this
>> path. I didn't get why it has to flush all PASIDs here.
> 
> You iterate ove the list above and flush every PASID in the list. I
> don't know what Intel is doing, fush all PASID on domain invalidation
> sounds like overkill.

IIUC with UNMANAGED domain with PASID, we will have device/pasid list with
different PASIDs pointing to different page tables.
  ex: PASID 0 with DMA-API mode , PASID1 pointing to some other page table.

This is where the confusion is. Current iommu ops doesn't take pasid as
parameter. So if we go over entire dev/pasid list and flush it becomes overkill
right? -OR- are we planning to add more params to these ops?
Am I missing something here?


>  
>>   - For other PASIDs do we have mmu notifier to invalidate as its attached to
>> some process?
> 
> mmu notifier has nothing to do with PASID.
> 
> The driver should have a general scheme to keep track of a
> iommu_domain's cache tags. This is the per-domain linked list of
> pasid/device/iommu.
> 
> When the page table changes (however that page table is stored) it
> walks that linked list and pushes invalidation commands.
> 
> For an unmanaged domain this common code is called by the
> iommu_domain ops unmap/flush/etc.
> 
> For a SVA domain this common code is called by the MMU notifier
> arch_invalidate_range

Yeah. I got the overall flow.


-Vasant
