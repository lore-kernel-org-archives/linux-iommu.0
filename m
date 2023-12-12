Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2057.outbound.protection.outlook.com [40.107.96.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EDB156CE
	for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 05:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5Mp8BV6f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVyGoy9wdhKtVHD1nQj2VJ7vZtwYHTrsxgNF7T001y6I6zLLdSeIq4WXq01Kuofg/abMEV1Hyl6ZE2RL8mmYFTML/y5kEXtBx9t689uHtVwLH1nNNgUdBC4+sNv5o0Wff1fwKChEg/kXpZRAsDFa/C5OLyYQHpLEeeFxYVVC9dODyQ/exO7Pm0BVNYoKYncCjUE604ei2ageTdLQcziVQCEW0mEofkExByHFaEosOmCnEwnqnWBvcLDTY3hEX1qFIPWJjpihHQ7BeTMkMfDWBd9+x/f2O/aCDxKWwsn+cZZJpt5x+JTB1xSlLdw6LuiNGxsUUWFU+eotLnS4sgwOjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFUw8+cG7z8osUmekVAOfciCA0QEwlnUE1MHvKAC+O4=;
 b=LJps9pVSgIEWF9tdvubZhL9ttyeOh9VJr2fF7F6L9qUEeBch61nf14/B1Lp1fHR590j/DFXr/SSKg281FrFn/uoldAS8Aha3xE9RC8W+sE9u87kWKNS4c1sygSMZoSPvWNXGuN3JlB+98V2Y1M8h2uLjPSoF+jAlMw3odW/quQ+pJoq9lV/kfb2VCCDGMFiW3E8P9j6f4wGgYi2O0SRw/mF8b2NPP/t8cdflGAl7/Tmp+710X5eCELiXpwgk3+QVa7zxGFZ5xsDXDLzPZq2W2QhjedeSIZEx3uU7C/3RQ3vctfP0jEAuJKQ9Y3DKu4iJtBSQIVBsdRcYuj2+aqk7uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFUw8+cG7z8osUmekVAOfciCA0QEwlnUE1MHvKAC+O4=;
 b=5Mp8BV6fhQbagD51vWtW5aHtOUQC4+THSmo0DV2var6p/DV72w/Rm+DUcR5rBxDw1br0uZbkMb1xv5B4fb/uAkzjgSUDUnBV7kEwdNSNbSkccNW8rcfWqGj0gtrqiaCgmaWBicvWH7M/FXQ9X9rmqff/8nA0j+MFXtgF25nugrw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH2PR12MB4214.namprd12.prod.outlook.com (2603:10b6:610:aa::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.36; Tue, 12 Dec 2023 05:53:25 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af%3]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 05:53:25 +0000
Message-ID: <c86e9505-a5bb-3ca9-e815-7435be6e8af5@amd.com>
Date: Tue, 12 Dec 2023 11:23:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 06/13] iommu/amd: Introduce per-device domain ID to
 workaround potential TLB aliasing issue
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20231013151652.6008-1-vasant.hegde@amd.com>
 <20231013151652.6008-7-vasant.hegde@amd.com> <20231105181604.GH4634@ziepe.ca>
 <a4855a3e-02f5-2ebe-f8c7-92137421418e@amd.com>
 <20231106133644.GJ4634@ziepe.ca>
 <2318eb1e-e62f-7e48-fa43-1d75331a75d9@amd.com>
 <20231107132131.GX4634@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20231107132131.GX4634@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0155.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::13) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH2PR12MB4214:EE_
X-MS-Office365-Filtering-Correlation-Id: 893e54a9-94e6-4311-2189-08dbfad6a7cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PtoMXhyZlcf3jFjOeviVpUdaUsiTH730z0IqR5V7BSr40byoOyhoamu3GKXxAwDc5Pkc1TyLuKxQsZDty1Ycu/z8NeBRBEPAEatF0JKJd+uqP/kKVe/AfM6zE3umv7Yyl1REQjZZboWKqk7ajhq5AObhVer8VGvH0tSetPG00d+ONGf8M3Tuq3ylC2wReAg/wR1LJ2CKlRdr5Y0MIxaDZ0k5g4fMvfWHaTc3CUBjmO3G6nh0ikDA3GmNHKAaQdnft5PGnWBUDkfVuc2Kwz4kbya8M0sLdE97AwR1uKdzzCx33f62JQLk3RQUoc3TCLNz1xglLCCtq9Qdvo4PFE51P44a9BfHrV1X0Stc+jQqHqE3iu1BThdmMWjwK79JkHIr/G9sbGK5mC860C4NcI8vIj5khDFDvKwANC08NOZGSwfasbAEdvm5gHlNpkDUj1ApiuJO4/fsFr5PeunhKaj7RaN5hsOuIWXoA+09lbC9js/TBSLKIS+Xx1Xqedp9mP9daLyhiayBqDQCN26joR+XSapQg5XHST9p7IrLcP7nPHKqkopxk5snb8XmaHU4R/q/fgtt8lY7BlXs5aPptemOdTO6Jjj8t3DbC3eaq49OyzShDHU2aglWFkLVhq9v3WY4Q8SRmMfTJJNF0KQSf9M6SQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(136003)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(8676002)(4326008)(8936002)(31686004)(2906002)(44832011)(6916009)(316002)(5660300002)(66556008)(66476007)(66946007)(478600001)(6486002)(26005)(36756003)(6506007)(6512007)(6666004)(53546011)(41300700001)(2616005)(83380400001)(38100700002)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXJzak1EbzUxSlVzczFBMnVDdTE2amZ5UTg4Nnkxd0Job0VHcDFxczlVSUdU?=
 =?utf-8?B?UFZBYy9hcXJobjVMeVBDUUJoVVIrTTU1MHJUeFhrNHBwS09PVzJGZlFLeVlq?=
 =?utf-8?B?Y0lKMDkyZTJwTkZuTWcyRVZYcE9Yem5JTkdRanduTTdnaExZS1FreHFOV3Qz?=
 =?utf-8?B?d2QxaHRISHA0SjBFRU5tT29VVisrSEdOekpSbHJNWVVSdWdQTFJmVmFQa1VI?=
 =?utf-8?B?MXdyaHFEVit5dmRwbFJaWlk2Z096bThzckJyelVYaUlmamNXVDVIK3VxWDJa?=
 =?utf-8?B?WWFMODNLampMV05SLzFSN0NlSkVMb2UxZzJaVGtwTmxGUnVuYzk2VG5Nekdz?=
 =?utf-8?B?QnBNRW1IdzROeDU2c3dUdkxDK21yeW8yODhKNU1lQklCdU9yakVDTTY4VUM4?=
 =?utf-8?B?NVgxTFg5RU9BaWQ5VCtKZEFEejRCeUdmWWI5Z2Z3L2JxdG1tN0pXRFVvR09G?=
 =?utf-8?B?WVBvY0hRZXROSW5DT1grV3ZjUGpWWkh1Zkwycm1WcEI2Zk9oajIwdnVuQ24x?=
 =?utf-8?B?ZWNWWXh6N1ZuNFdFbVVoNHN1b1dqSlhEbzh6dWFlaHBoMmxhVXlYSGdpZ2V0?=
 =?utf-8?B?MlEwelRyMXEvbTlmR3o5Q0NFR21mN3h3d3VFa1kxRWJaMzB6ZE1UckZRbjhJ?=
 =?utf-8?B?ejl2TlhZcXVMVExjVzN0YldzNmNIclpUaDE1K0ZsRVIrU0ZnRnpQVWdnTXQx?=
 =?utf-8?B?QXQwUHFjQzlXcXJLN2ZmYURhNWhJR0hKZlZZbjhoVW5PWWVuWGFrbWwwd0hR?=
 =?utf-8?B?RHlvMGh4VnJLU1NWU2xaSjZWTDRTcHdSMjRRVHRpM3Q2MGEvTUE0bzIxcUtn?=
 =?utf-8?B?T2VrNlM1M1pRU0hlYnBweWcwVGI5NTNmMmsrZDJrV1RMM3hWbWdaalF4Qkhr?=
 =?utf-8?B?T1VickRUN1liUzNINTZYblNOajN1WmN4RE0zTzZqQ2l6TVhEd0w0RUpBY1R1?=
 =?utf-8?B?VTNCa0NPcEhjaWRkNkNINFFtb1ZZYTJ2RStHZGxqSnZBQlJSUmo1ZG1pODdw?=
 =?utf-8?B?NE1oeCtlTkhKNkNtME1tdlFETlBSazJkY04xZFR4SHNOYkhWcXlURmFlUHBh?=
 =?utf-8?B?djJyR0FCT1VKNXVSUmNBRlY4eFo5T0ZIUkNQV1EwNXd2enAvSUNpUHNGYm1K?=
 =?utf-8?B?Qkt1SDN1dTI3U2xua3dKTnBVY2xBNzlkN2poWlg2aGFZdGdyYlFIdVB3Y29k?=
 =?utf-8?B?ZmNyZWNad0JSZk9OaC92bjNuVFFBbjlwMS90MHZzVUNMU01EVGZJR05NRExh?=
 =?utf-8?B?TlVUekhUazJTelJ2clBod2p4UWZVQkZxTUFHbzBBV2lnK0JVZkhla2pXV0dP?=
 =?utf-8?B?S0EwOS9yMVNlVmVuRHlyUUpXVmluT3A4c1ZFQnEzMWIzKzc2UEtXcWlCUjh4?=
 =?utf-8?B?UjU2WFI5cThDVXM5eVIwMkY5a3JFNVM2NklPUFRkMHV1ZkV1a0JoQktLYjhy?=
 =?utf-8?B?YUdaR0Q4WVhqRDkwY3g2bTRubzd5eUNyUkpHM3FUQ1dMS29EMVdGVlp3SnBL?=
 =?utf-8?B?c0t2bC9TdmJiTFZjUWN4NUc5b2xHdUVISlg2SDhUT3ZNRTNZbit3cWg0S0p0?=
 =?utf-8?B?Sml1NUE5Tlh6ckpsK2VmNm5vRGdRYTdiQW9YWGRGU1VpUWJ4alpYU2crUmpN?=
 =?utf-8?B?U3dSWUNIa0dxenZOOHBYVjlJMmc5cU9taUQrWnBxL0c3Tnd5dFB3ejlicmhJ?=
 =?utf-8?B?NmV4WUllVFZ6cHUwVVJWbmVvSWY5bFVkT2pFYTBVeTNONkNlOGxUQWdnbzVT?=
 =?utf-8?B?KzhSN1ptM3cxamNRbnRLN0dEdWpzUzF3aGdWOXRMdGlQT1ZnK1JaUmg2V2V6?=
 =?utf-8?B?OElzVks4Q1dlVFlFU25kaU1Vb29xRVc0SzY2ajIvWWdhY2tkWWpUdUxNUjBj?=
 =?utf-8?B?dHdPN2NCMkpmZGNKN2pxS2RuMVpWMTRXOTlyYThjaWlSbzVBYmFTV25WYlpD?=
 =?utf-8?B?RzF6U0toRXRFRUF0OTVOK0FjYXBtMUdkOW9OZncwRHRDeDZNREszQVUxOVNz?=
 =?utf-8?B?Ym1iMFdNVXp3d3MzbUFDeHZkMG1HTFdscFAzN3FENlBuWllYWTlsZVZJVzlW?=
 =?utf-8?B?RGduei9MUkVYL3dULzBETlFaYmdlcjl2WHlZWTZQcGpRWFdpa1plMzlMZGRm?=
 =?utf-8?Q?IqEg6ENAG8IwPJqxFY4TjAT2M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 893e54a9-94e6-4311-2189-08dbfad6a7cd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 05:53:25.1677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lEYpqU9BUMCX5CLQx3AWaJvH726GD8KpaHCO7OO4yv10tL33gcWHxvSD+q2bzxcaGKsKKaZpjO6myNAYPF8fVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4214



On 11/7/2023 6:51 PM, Jason Gunthorpe wrote:
> On Tue, Nov 07, 2023 at 11:00:18AM +0530, Vasant Hegde wrote:
>>
>>
>> On 11/6/2023 7:06 PM, Jason Gunthorpe wrote:
>>> On Mon, Nov 06, 2023 at 06:09:47PM +0530, Vasant Hegde wrote:
>>>
>>>>> I think this driver really suffers from not having the right
>>>>> data structures to handle everything cleanly.
>>>>>
>>>>> In smmuv3 I added a 'master_domain' structure that linked the PCI
>>>>> device to the iommu_domain. ie when attach is done you'd create a new
>>>>> master_domain that essentially stores the parameters required to do
>>>>> invalidation.
>>>>>
>>>>> For what is going on here I would say to do that an then put the
>>>>> "domain id" inside the "master_domain". Decide when the domain is
>>>>> attached if the domain id should by taken from the iommu_domain
>>>>> (device does not support PASID) or from the device (device does
>>>>> support PASID)
>>>>
>>>> We still have single domain concept (at least until we introduce
>>>> vIOMMU). All we are changing is how we allocate domain ID.
>>>>
>>>> Having another domain for each device just to keep invalidation info is
>>>> complicates things. Also IMO its unnecessary.
>>>
>>> It is not another domain, it is cleaning up the mess of keeping track
>>> of what caches need to be invalidated for a single domain.
>>>
>>> Today we have this:
>>>
>>> struct protection_domain {
>>> 	struct list_head dev_list; /* List of all devices in this domain */
>>> 	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
>>>
>>> (and I'm sorry, but using a global array of iommus and this dev_iommu
>>> thing is an insane design)
>>
>> Devices behind different IOMMU can be attached to same domain (like VFIO case).
>> We do need to track the IOMMUs and as part of invalidation we have a requirement
>> to send `completion` command to each IOMMU. So this links domain to IOMMUs.
> 
> I understand how it works.

Great.

> 
>> Array is not a best thing here. I have it in my TODO list to change this to
>> xarray or something. But that's after SVA series as we are already making too
>> many changes to fundamental data structure in this series.
> 
> 'unsigned dev_iommu' is the problem not the array.

I know. I will fix this after SVA series.

>  
>>> Now this adds a new concept domain_id_is_per_dev(), and it still
>>> doesn't support PASID properly!
>>>
>>> Instead write it like this:
>>>
>>> struct attachment {
>>>     struct list_head attachments_item;
>>>     struct amd_iommu *iommu;
>>>     struct iommu_dev_data *device;
>>>     ioasid_t pasid
>>> }
>>>
>>> struct protection_domain {
>>>     struct list_head attachments;
>>>
>>>
>>> Where every ops->attach_dev allocates a new struct attachment and
>>> threads it on the liked list of the protection_domain.
>>
>>
>> We support PASID only in V2 page table mode. V1 does not have PASID stuff. So we
>> just have list of devices in the domain. Then each device has PASID table (that
>> what this series does).
> 
> Doesn't matter, v1 uses the dev_iommu and the point is to consolidate
> alll of this.
> 
>> Also as mentioned above we have the requirement of `completion wait` call for
>> each IOMMU. Hence we track the IOMMU list. Having it per device like above
>> increases completion wait calls which is not good. IMO above changes
>> unnecessarily complicates stuff.
> 
> It is not per device, it is still done per-iommu. I wrote:
> 
>     list_for_each_iommu(elm, domain->attachments)
>         build_cmd_v1_invalidation(&cmd, domain->cache_tag,  ...);
>         iommu_queue_command(elm->iommu, &cmd);
> 
> Which is the same work as iterating over protection_domain->dev_iommu,
> the iommus are extracted from the device list which is needed anyhow
> for ATS, PASID, and V2. So just use it everywhere.
> 
>>> Then the invalidation logic become completely straightforward, no
>>> confusing mess:
>>>
>>> invalidate_iotlb_v1:
>>>    list_for_each_iommu(elm, domain->attachments)
>>>        build_cmd_v1_invalidation(&cmd, domain->cache_tag,  ...);
>>>        iommu_queue_command(elm->iommu, &cmd);
>>
>> Ours is domain based invalidation. So our flushing logic is
> 
>> 	Flush IOMMU TLB for each IOMMUs
>> 	If device has ATS
>> 		Flush device IOTLB
>>
>> 	For each IOMMU (dev_iommu list)
>> 		call completion wait
> 
> This is what I wrote.
> 
>>> invalidate_iotlb_v2:
>>>    list_for_each_iommu(elm, domain->attachments)
>>>        build_cmd_v2_invalidation(&cmd, device->gcr3_cache_tag, elm->pasid, ...);
>>>        iommu_queue_command(elm->iommu, &cmd);
>>
>> From driver point of view, fundamentally V2 invalidation is not too different as
>> we have single invalidation command. All we need is few extra param to tell its
>> guest page table invalidation with PASID.
> 
> From a SW perspective it is totally different because V1 invalidates a
> single domain id per IOMMU and V2 invalidates a domain_id&PASID for
> every device.

Right. I'd prefer to do it in steps. I would like to limit this series to
current form. (GCR3 movement and domain ID). Then will have separate series for:
  - reworking protection domain structure
  - Handle domain allocation path (adding BLOCKED domain, some cleanup etc)
  - Fix attach/detach path
  - Other enhancements like PASID table expansion support, per-device-domain-ID
improvement

-Vasant

> 
>>> invalidate_ats:
>>>    list_for_each(elm, domain->attachments)
>>>        if (!elm->device->ats enabled)
>>>              continue
>>>        build_cmd_atc_invalidation(&cmd, elm->device, elm->pasid, ...);
>>>        iommu_queue_command(elm->iommu, &cmd);
>>
>>
>> Driver already does this.
> 
> The SVA series had code like this, I'm saying you need to generalize
> it.
> 
>>> Where list_for_each_iommu de-duplicates the iommus from the sorted
>>> list, Michael had a series that showed how to do this for SMMU.
>>>
>>> Basically you precalculate exactly the invalidations required and
>>> store it in a list associated with the domain. When it is time to do
>>> an invalidation then you just walk the list and do exactly what it
>>> says.
>>
>> I think we have most things already in protection domain. Only extra check we
>> have is checking `pdom->dev_iommu[i]` which will be fixed separately.
> 
> You have it but it is not structured in a logical way, that is why
> this series has introduced nonsensical things like a PASID for a
> domain, encoding the V1/v2 state ina PASID/etc, and then did a half
> version of this list anyway to make SVA work.
> 
> Bring the list from the SVA series into this series, use it
> consistently, remove the weird stuff and then it will make sense.
> 
> Do not have a list *and* a bunch of weird stuff, that is moving
> further away from what it needs to look like..
> 
> Jason
