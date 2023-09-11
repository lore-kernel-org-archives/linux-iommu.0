Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9CBE554
	for <iommu@lists.linux.dev>; Mon, 11 Sep 2023 12:16:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLRx6iTvaDhdwl9e/2TiUMCvIg9aZRZc/C3+4dlfBFO2yuhK7k0OQLHJNF4+vW6EhlulTEVAyAorCEwFz+PjQMm2sUkXe+JlLNR90o8/47C3L2B0Z8wqNd7kzZEbO6n4gUE9qkcvueUD7sysm+vX2g0vfLE6lwhSlkabPhG6qgITuV6Pa4erMprGXZuM0kJiJz0LmSjcI3BJhuGdPCOB8QgwOb9St5Oe7UsEDdAuN/aWDc0zmjcWF0JLrCEKhSABUagZkq6+VFcobACQsy6o8J9/TsNIeLeAYbbluQUKINf0iWggNHVHCtK0Dx+13v6+VnYT9XXJc/n+clsTtYluXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQDBcN7V0pw2KhCs409zv9w2BTMqcUfwyXakGesXv0Y=;
 b=avPtPgzDroi9uWMntnjosyiDyVMQ71hL1PyWrlCFjRUI6dFXDnR5+m1/9naZOqXUiVrp8CAZ9YCpNbyXW22m0RQXEacZHqvj0hcastvR90+y30Aq1H4og3yO/0bcbnrrahDsVswUKILfw0aql4hFMXwT9z/c2CHcEY/xAmEkBOsq65pqOUo8UXBKwX8nLMapg+qVyaB7HYzrDYCLRf2Uc/NcXu0zMLkxMIxxuaS/s/xTSLOtlBtbMWSMmDZWWt3uwR65fSM5bQk2xlrKHU/QFprKPECMNNngHwPQ9cMMJz8t/Ft6Js4ILEtYptTjdoDyOn9nPItFOqHwBEsIYtSzDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQDBcN7V0pw2KhCs409zv9w2BTMqcUfwyXakGesXv0Y=;
 b=ByEMuGAvmFaNAVjRsxk1j0MJt2s9iTEmAfOyWCqgHz4h2gzaS8ToTihkadkaO2Fx/uKxSiZhDEmLycKzTeXLP2Lfdzg1r+bHxrmU9FcTxKDqaE+J2BuSg3wZQC0mkC6UZXn4v/F6qaBsKyUmwMo0/rS4AojUCN0eJqUirVNN7xA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS0PR12MB8319.namprd12.prod.outlook.com (2603:10b6:8:f7::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.34; Mon, 11 Sep 2023 12:16:52 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::cb74:f20e:dd21:d763]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::cb74:f20e:dd21:d763%6]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 12:16:51 +0000
Message-ID: <14ab1dbd-26f1-3935-65d7-1d1835cb062d@amd.com>
Date: Mon, 11 Sep 2023 17:46:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From: Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH RESEND 03/10] iommu/amd: Initial SVA support for AMD IOMMU
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230823140415.729050-1-vasant.hegde@amd.com>
 <20230823140415.729050-4-vasant.hegde@amd.com> <ZOYXoMPBQZ5KK9IJ@ziepe.ca>
 <fc17e0fb-e712-824f-93f9-f9edf5707395@amd.com> <ZO93WJnhxl+sC9zA@ziepe.ca>
 <d64d8066-7cee-46c6-2403-76eaa969fe53@amd.com> <ZPcejmNW153rcRFA@ziepe.ca>
 <38845842-d535-b621-1e6b-16d8db52a1bb@amd.com> <ZPdv8P4zTNJODcXD@ziepe.ca>
Content-Language: en-US
In-Reply-To: <ZPdv8P4zTNJODcXD@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1P287CA0016.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::33) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS0PR12MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: 97f9e4bd-5398-48d3-0432-08dbb2c0fadb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+1PfpgKW+z8ooRmzSIuejO6exkelyF7/auhn1W2x35aupHur0OU3rPqEDK1rxyY7uQe0YLXpCgQMfG4dcMVlSPblu71zZsocjgu0MLNs90RM71LBT0Fn2b5rSl85Dl58tpGE61yCbBdbHYGkgrVoG+sFIVSvadPO1A1HKbFBYWmRc5zuEBvBh+9qvob80JM4zn/xYKy3+Xez3Sk9Pzp2r2Nzx+shP6eierSA0whXIUdcmejeLgB1llkvi7s9pWr2EAgIHOoZQEetOrzfLR3IEUGy69MMq/BrR5d+3brwtBJEQgpuVtIhVFdMp4ekfk1FdfrZFrgBY/n0J0u+FzkyxyH7Um9bdMTu96/UHXlSn6zb8vNz9GSqU+F1q8SmNCtbWiAW7z9/4zDAbKxFOJ1VBXxGTTguY00eqjTe49pAnohDj0YDJBdTd45glXFlOsAZKKjv+rK0PL6PuhkNW3lEmQCbNCSgwAO4+/Exyq7u5jzQPKHKw9V8PjZ57StKMcP+tmNxUy6PBPlzDrDOx30Mo+f9/4cdwqs9gup9aLskrm3afFpgkZvDrci8beyh/96hc13MRT3xPQlvytRu3P9LEfU2mlxJD6X77n1w4Ajzru+5u5ss6AVGpxWptfD1nQdqhm/PfDSqv6m2GzrgL4f+aQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(376002)(396003)(346002)(1800799009)(186009)(451199024)(6666004)(6506007)(6486002)(53546011)(966005)(6512007)(478600001)(83380400001)(2616005)(2906002)(26005)(44832011)(66476007)(66556008)(66946007)(6916009)(316002)(5660300002)(4326008)(8936002)(8676002)(36756003)(86362001)(31696002)(38100700002)(31686004)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UG5qZmcwQURRbDFjVGFOeld6QU1XdkdGUGpWbmxFTWg1VkhndFBteENnRDUw?=
 =?utf-8?B?QWJ6a1hHcFQxa0ZpZkoxaU13NmpYV0ZuRll0M0RneUJsbEFKZUl0TzRIbENw?=
 =?utf-8?B?MDhnczJRd0cxSTVkSkZrVzh4R0F4UllJaFJkbFR2Tm1IZy8zRmdmekluUFRp?=
 =?utf-8?B?a0Q3eXhra0psVU11dGRHYVh1WWE2cEtQZDEzK2J3TG8yd0Q2c0Rpa1MrWmVr?=
 =?utf-8?B?bU9QU28vODFENHFPVW05N1FOVmlDYUxNUHE5UUN4SU8vV2Qxdi9rUndoZGhP?=
 =?utf-8?B?dVNsYUlSZnp4U2lpY25PNzBWRUQ5bkx5dG1aai9QV0pENHJxUHYrVmNZZndH?=
 =?utf-8?B?WWVaamNBcVNXTS9rZTl4SDVYaXpYRnZMbnNEUDBGdm93SHhlaXArTUZ6Nkho?=
 =?utf-8?B?eVRLc1RzUjZkM3ErNk9IV2RWclhxcUlMaG5CTzMvZnBsVW9BMjY5RjlUNmpk?=
 =?utf-8?B?dFJUU1JyS0NkUU9lT0Y0NnFaUEdxWE1BNnVuallwZlQyVnRhWUIrcEgzdjg0?=
 =?utf-8?B?eDd4ZE9PVkl1eThycXlYZDdEa2FzMG01cTdyTWhUMmxvZjdpTVQ4UEwrY05G?=
 =?utf-8?B?MUlaVml6QStkbE90dUxXMjQ0c0N3S013UDI1VVN6ZGlFeTVWbGwxQXo4K2hF?=
 =?utf-8?B?VURiV2NtODVFSldjd3hMT0VXeDFuN0NoRk81Sm9wT25OWmFCTXNjQlRQb0RY?=
 =?utf-8?B?Z3FxdDcvZm5MMkNwLzhVaHlGWG5wb0MzZFdvbHRhd2lpTXZ0RUVJSFdEK0Uz?=
 =?utf-8?B?aHJEUGJrN3JEcGl2ZnZYVVFjTXFDWXZha0svOHZIOFhMY1Z3UExZZE5DVDU4?=
 =?utf-8?B?TUFPVVNGZjhrNHdZamtCenNHOTFXeWh2ZVBvREh3SFVCOVduY2FtMGtPaGMx?=
 =?utf-8?B?bFozdnRnZFRNVWk2UWtqdzI0dmJnTVhjaHlzeWdpRE1kbHMyb0FOdDQ1TFJQ?=
 =?utf-8?B?K2ExRmxlaFdCUEUvWERCZjJwcHc0d1RZMndPdUVoeVRaajR1UEJlazZVL2Jz?=
 =?utf-8?B?eFoydFhUdkgycTh0N240cGlMNkZTaDZnWGpqTVpaQUpFdWZDdnJ2bEppYWFN?=
 =?utf-8?B?UHlMRENQSHQvYmdHMnRCSSs3MEFSNElGRlowaWdjUVdVYTlIMnVVZ0RiMEQ4?=
 =?utf-8?B?S2JoNkZWWFF0YVZVdHlmeXVaVTRuTTFPUjMwQTZaZHZNVFlrVituOWpCalVQ?=
 =?utf-8?B?d1hoRnZjVlNLN3IvcXdxcWFpK1BxNW1vOFZHTVVYN3JvWEl2dFJzemY2bith?=
 =?utf-8?B?OCtacVJ5dFhtaWlhWS94VVN4cWFDbU5wTTUyZHQ2NTBQeXZFL01HRU1SVVk5?=
 =?utf-8?B?am5NWmxUa0k2VjV4dEptWU1LTFJPc0JPMGFMWEdEVVM4dzloUGtsa0hpUHZZ?=
 =?utf-8?B?ZWlic3FjdVU5aS9KcVFoQmlSUWhiZG1KTGxFSTlqVWhoTU1uYTczSU40S081?=
 =?utf-8?B?WGt2WGFLM0hzcXN6K1FOOElJU1BvK3ArQUlSemhFdW5DelNOME1IeXN4ZTZr?=
 =?utf-8?B?VmY4bGVHVDBKd2dvZU41Qnp2NXN2eFZ0NzV1ckN0bkVMcmlScWlXNzhwNzFE?=
 =?utf-8?B?bmtid0FsUmo0U095NEgxcmxDaXJHTnovbGxNSG1jWVhEVWhCRGowUlV6bjRv?=
 =?utf-8?B?V0p3eGlPYUhTWTQ2UVRJOWpMQzdHN0FJeE9INnArakg1K2lYZHRvNlNaSCs4?=
 =?utf-8?B?bXhSNnNwekNISVBHcDJVazhiK2pidWNuVEJrWk41dnFrSlIzK1RqS04vcERm?=
 =?utf-8?B?WVFwd0IvNGU4SnJDWi95enllS0tHVVlwV005OGtrZkZWZ3BqRzFtMURjR1hr?=
 =?utf-8?B?MFpOOFluK0JJSFlrLzlmUEV4ME0wNkdHRmMxME5wVklYZTYzUGFicnNjZ1hw?=
 =?utf-8?B?TXVjUmxpem5qbUQ5ZVd2eStsRndRMENJZ29kNXJCRWRzTkNpaTZGTlNMbGo1?=
 =?utf-8?B?TGR3dnUreGZRRE1EWFk5LzBKSVdmSEcwczdKZUtZSERxNzZKbHpkSURZNmNX?=
 =?utf-8?B?dkxYOGJ1MDgwZ3RkUDQzTjNOVFBvak1vMXp2QnZUVW1YVWV3bnRFb0pnazBO?=
 =?utf-8?B?NlJ3cGtITkdWZkxaTUdoZHh2c005R3pYZUtKZnZlaklGMjYvZHNHVlViYjBQ?=
 =?utf-8?Q?Vq02Hugn+B69E5QkrUcMYkM8h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f9e4bd-5398-48d3-0432-08dbb2c0fadb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 12:16:51.8987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hjQntTlkx3xCJ5u7q2+W1gXQXx9wd58Pog7YXNBVzO+sFUnL8ud3mi41WoevVwMpGKQE7GTOutU2z/1DDcRvlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8319

Jason,

On 9/5/2023 11:44 PM, Jason Gunthorpe wrote:
> On Tue, Sep 05, 2023 at 08:09:39PM +0530, Vasant Hegde wrote:
>>>>   - set_dev_pasid() will check the compatibility and bind device/pasid only if
>>>> its compatibility. In AMD case we will check against protection domain. Ex:
>>>>  If we have two devices (devA and devB) in two different protection domain then:
>>>>    set_dev_pasid(sva_domain, devA, pasidX) - SUCCESS
>>>>    set_dev_pasid(sva_domain, devB, pasidX) - Compatibility check fail
>>
>> Here I expect it to fails as devB is in different protection domain. From
>> invalidation point of view, devA and devB are not compatible. Hence I think it
>> should fail binding.
> 
> No, that isn't the best thing to do - you could do this, but it will
> be more inefficient.

What inefficiency are you referring? Allocating extra SVA domain -OR- mmu
notifier getting called for each SVA domain -OR- something else?

> 
> The domain should represent the ioptes not the target of invalidation.

I agree with this and I have done SVA domain implementation for AMD driver in v2
[1].


Then I am wondering why not just create single SVA domain for a PASID and let
individual driver handle underneath requirement like target invalidation? Am I
missing here?


> 
>>>>   - During invalidation, we will retrieve SVA protection domain using mmu
>>>> notifier. Use device protection domain which was tracked in this SVA domain for
>>>> invalidation.
>>>
>>> The iommu_domain/protection_domain must NOT be 1:1 with a device. The
>>> driver must maintain a list of devices attached to the domain, and the
>>> per-device-attachment parameters like PASID/cache tags/etc.
>>
>> We want to track SVA protection domain to device protection domain link. So that
>> invalidation becomes straight.
>> If we track dev/PASID then I am not sure how we can solve duplicate invalidation
>> issue that we have today (i. e. if we have two devices within same protection
>> domain and if we track dev/pasid combinatin, then will call invalidation twice).
> 
> Look at what Michael is doing for SMMUv3, they have a per-smmu
> instance cache tag and a per-device ATC invalidation they need to
> issue. They keep a sorted list of device attachments and simply do one
> invalidation per-smmu instance and one invalidation per entry.
> 
> It is pretty simple logic.
> 
>>> PAGING domains need to support PASID+PRI, in today's language that
>>> means UNMANAGED domains.
>>>
>>> We have many use cases for PRI support with generic PAGING domains.
>>
>> What is that usecase? That's what I am trying to understand it better.
> 
> iommufd will require this for generic vSVA in all paths that don't use
> nesting.
> 
> We have use cases to share a KVM page table with PRI.
> 
> Google apparently has some usecase since they are fixing it in ARM.
> 
> Besides that, it is the IOMMU API, drivers have to implement it, you
> don't get to pick and choose.

Is there any documentation on the mentioned use case and the required IOMMU API
because this is new to me. I would like to understand things better before
making the change in AMD IOMMU driver.


> 
>>> SVA is a special case of a PAGING domain where there is no map/unmap/invalidate
>>> API and the IO page table comes from a mm_struct.
>>>
>>> Start by making UNMANAGED (aka PAGING) domains work with PASID + PRI
>>> and then SVA is a very small incremental step.
>>
>> If there is a real use case then why not? We can do that. But for now we want
>> the proper SVA to go first.
> 
> You are not going to get SVA without also properly doing all
> infrastructure to enable paging and unmanaged - I won't support
> another shortcut hackjob for SVA that needs unwinding like ARM has.

The goal of this series is to introduce the SVA support for AMD IOMMU driver.

So far we have been accommodating all the review comments.
  - Dropping iommu_v2 module before getting SVA
  - Reworking SVA top of Tina's series
  - Reworking IOPF on top of Baolu's IOPF enhancement

Adding PASID support for the unmanaged domain is a new requirement and not
relevant to this series. It will also require a considerable amount of changes
in AMD IOMMU driver that we need to further investigate to better understand.
For now, we would like to stay focus on getting SVA support in upstream before
moving on to add PASID support for UNMANAGED domain.


I just posted v2 [1]. Please take a look.

[1]
https://lore.kernel.org/linux-iommu/20230911121046.1025732-1-vasant.hegde@amd.com/T/#u


> 
> PASID and PRI must not be tightly linked to SVA.

Its not. Patchset already supports PASID and PASID+PRI combination.

-Vasant
