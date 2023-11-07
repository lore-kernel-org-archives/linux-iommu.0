Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2E220E7
	for <iommu@lists.linux.dev>; Tue,  7 Nov 2023 05:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jRbXlZqM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUBey/Yx8ukVOfkOGJ4+imDqNABzxO4x8GTPCz9e8VSoWJmZXTDC0IgvhpcT+oEgTPq9wEwlle4+ujxpFMVdjdfTpW0DKbMq5RC8SBW+UD+jbpDztCrdKzzc3GP11R+5njluOhI6XRGmyK8wtOrfwiMDY0HHfVAToRmuZDqxL/HGV4ks93IaSzdGAiOLfn6eD2ExhSiRw2kMoj0fgWIb4HTJgczMoFbQE/NLcobwt4rUiETQYCLF0NT/vicspE/3oo/ZkN2hsFNhWjKv1NTa4ejtm/nZdOqiohRGOQH6/sswwrWutLzysTqszx2uy67fIwL4PQPJB3ERfNGJoVi++g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jwAyKKAnuo9LFMkWsxYPDQCy3qKgWmGSlYuYxvcxfI=;
 b=nkd0j5ej6svVP1pkSnL/YznsPFf/kpuiYgBmQsrlb8FOXP8PPFa66GoKjxqInOfguMrAnpeS3LzmeTIeM9xEzIMRcGCh54Vt+qMKTi4VFpb6VtSTlIKpFMdMovA4J8fo8xMjjUu7r9HDyFST1IngdOsqNSvqC8qwj8VeuYnRuELeulSRRGi/9lBwW6py0NvsgNnloUeWj5Ai4/HpSVVhW+pJNTN3Uf0wBmNaZuhAvQPhgihO89iOPGYDvSCmxXPzw3l85hqwm7VtjqqSvdqP3nW1xIg9qFKd9tYY/HXd8Ba10E0TGjHz610FNtNBOfJfqtbKqJ68P4BkNiqBvKGD3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jwAyKKAnuo9LFMkWsxYPDQCy3qKgWmGSlYuYxvcxfI=;
 b=jRbXlZqMBXHrhxqxFKcagYL2P222jkrrJIuVj+szKuKECrFaHq245pAsaGSg3FbLMTr16HqMBDhN2pK0rnQBxmIYl13yRxz/oKFCMn/VU2TptMYcPoM72qZcoMyOSEC3eiOR18aM2kiYGaMXK3v26DA+ZxP724br+3JlxZANqoE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH0PR12MB5347.namprd12.prod.outlook.com (2603:10b6:610:d6::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.28; Tue, 7 Nov 2023 05:30:27 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af%3]) with mapi id 15.20.6954.029; Tue, 7 Nov 2023
 05:30:27 +0000
Message-ID: <2318eb1e-e62f-7e48-fa43-1d75331a75d9@amd.com>
Date: Tue, 7 Nov 2023 11:00:18 +0530
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
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20231106133644.GJ4634@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0158.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::11) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH0PR12MB5347:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c856f34-807b-46d0-8fcf-08dbdf52a5ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g/wt9MHkfE8KJeHyfYfllSfAb0JHHb4HUwoRnklvBbY6ur3rKCwN8HCCiFmIxmk9mUxS9erfuGppUwAv/b2MDPC3RdpElLc74tGVa7w0E61MPfiPlcdcVGkuib+1/BcHsMIwP7iZpg4NEVTnXRvGmoKau0d/63sFIiNKWq6ggnvd6JO2uBXglz7nCoyXTvr2ZHihaWvEI4pTIORDyAoVsTnKJI9TSUJih7HVIjkNuXywGKRVVgMqtmVwztoPxZlQQ07W9i3CUFg6/nSUOjvZBhcbdlpmQNLLde2KROE/7VwdRRx/wstOkNU6TM0107FDhZet2WzgjG1YG3fEVYpHGda3HM0KGoGSET3pAQv5/bu8MsNclanUMdxn2/YDUxJHssGJEeVbf5BbZKreiS9nqMaYBB5UayxN4FLLoWbt6lOKRzIySruSOaXIKLY7X0SI5BSsGhV2uMPK4yCaWT6vsqMi9AcYW+2PWb7LYFSB9EUowqj9gLWrA24GrlJSQb6Y7+AOKjdZ3ndcPVT4e9E/Dcvd7/lWmGO4BjXxB4rwiF6HV/Ctp0A+L/eMjog5SQEBlNeRej2YIdCyUzTns60yxpqbpWUIkg4w1GENyrEqSKVORGkI86lH4oNORWy6W0f+8koYy49WXrh29r9FpidF0g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39860400002)(346002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(2906002)(38100700002)(31686004)(4326008)(8676002)(41300700001)(83380400001)(5660300002)(86362001)(31696002)(44832011)(6512007)(8936002)(2616005)(66946007)(316002)(66556008)(66476007)(6916009)(6506007)(53546011)(6666004)(6486002)(26005)(478600001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3BKbmZ4UXRQQ09lL0crakpyRkMyeXUxalpQbmRUcU82bFdDc2UvOVFuVnRP?=
 =?utf-8?B?VXNIM2M0WHhjaENtcHJHcU1iMHRNQmc4SGgzaGpEVlY0WHZGVzZLRTNrWEdS?=
 =?utf-8?B?Y1kvT2J1eVM0QVc0aVN2UlRTUGVKUHZhZmE2bHpPd0ZaekQ5NUEwNUQ2TnJ4?=
 =?utf-8?B?Q2RHUGthNFh1TC9rbXg2aW9ZQTc1S2dQYTNPQXFaODNTMmpJOTVUZU5qb2JV?=
 =?utf-8?B?VVhRbXZmdnBiM056T3dRN0p1TkNDM2h0aGZQT2dMQ3l5VGtleVQxQ29jSjA0?=
 =?utf-8?B?SVlacnhtanl0SEplaXQrTkRyOGo3azc2WkRmMFh2YWplcldyRFVLZ1JweklK?=
 =?utf-8?B?YzJ5dGV6VVNOc3hiMnRGRVQ2SzIxNUZiVEFELzdZSzhhcnJwTTkvMGo4OVhh?=
 =?utf-8?B?YjFtTmorMlVWa2IvaS9OT201WVZyNU8za3lqSUhRK1VkYVdubTJ2L1BiNmlB?=
 =?utf-8?B?ODV0cU9JZEJ4a1pEL2c4RDArbDIzYm56cVBZc3lEK0gycEVRRmJpQnRVdGV4?=
 =?utf-8?B?aDZSN3FXQktITXNFYTVxTWFBQ0RsRUVmdEc5ZVprSXhNT09WVTdBcGkrVkE1?=
 =?utf-8?B?dllndVc1ampoN1MrZUtZVkVPQlBlMjQxQlIrSzg2S1oyTnZhUjd3SmQ0OXE2?=
 =?utf-8?B?YjVuRE9jRFJHMURiM2wzeXYrYWtEQ2Q5OUZ6TGxraHI4b3dTQ0pVcUFkQlNM?=
 =?utf-8?B?d3BWWU0yMGpnVnFwM3FGRjNSY1UzUjExckwxR0VSblZzcDJURXdwaUxjK2c3?=
 =?utf-8?B?WFhPcUs2NFVVck1hbE43a0pyN09HVFdEZllZWmEwOUh0R1ZwSzBHaUcyMmJ4?=
 =?utf-8?B?YktyQnd1QUNWdi82bTdoSlltSjJLMkJ6NXpzUWRmVG1ZRUpuMXkyVzJsOGpK?=
 =?utf-8?B?bXpmcnBZd21JWUhrMkhmVTMzUkhiTVJMTG5ES0Q4ZzFPTVB6WjJtczdJdEQ0?=
 =?utf-8?B?azNoZGIrZ3kzeEh3VHUxRDd5b0xxYlJYT2hZYmozUDNHV0hmQ1cwTklNRFhx?=
 =?utf-8?B?SVQ1c1hSMWoyMzlYb0RyUlhlTmNRZ1dpcmdROWVrQVNDaS9jdE9BUXFCY2Vz?=
 =?utf-8?B?ajROYlFvRk1OODdqcUppMzBlblJVSnNwbzluMG1STmJJQjRuWDFqd0RXODFo?=
 =?utf-8?B?Wk5nSHozWkhKRThnaW9xNG5YSFlQRGVlZkUxbnV6YnQwWitYK0RmWWpGYy9H?=
 =?utf-8?B?Rk5XODJPazJ4cG1OS29RaG1NYjdxSWxHTVo4dStkb2lnWitQeko0cEg3ZmdO?=
 =?utf-8?B?OFpVSE12a2ZIYWs3enN4Nmh4a1dzODJ6ekthd29oSTN3bkNWc3NOYm9pV0R4?=
 =?utf-8?B?cTNJcm50Nm1NaW1WM2locWlVdS9ORmlrRitLZ1h6Smh0S1ZpMjAzdWR4Unpw?=
 =?utf-8?B?OFUvak9EM3lBSzAvUWpjZHBsNnJNcGVwN1pHSVR6UHAyNTFjZVZQZW5SSFBv?=
 =?utf-8?B?bGM1cXhFS0JaRjNCOUMzdDNpdTBua0JreDVZUCs1ekp6Q3lPNUthZEJub1NP?=
 =?utf-8?B?U1p4VVRPN2JkT1lsNEljVU1vcmE4Vi9TVHlqTjRSMWhzRjNRVmZLN0h0Slhv?=
 =?utf-8?B?Q0J3TnRKK3ZJSkJHN0ExT2xmeTZwdStNZE5MKzUzVExmSVRHSXNLWnNkcWhW?=
 =?utf-8?B?S0NBRGk3NHFqRjJwY3l1VmsvUGh5Y3pxRGJRaGxSUjczWlROdU1Nci9nb084?=
 =?utf-8?B?QnNXQ3FaeDVkSEFWWnNMUUxobEtMRjc0aWo2V0RQQ05Ea21rdlJ4bk5YZHZK?=
 =?utf-8?B?MzZrb2VqQ05XUkVIamhCMDZjS3ZzN1QvZENHS1RCZVk2UElJZjJ3TTUwYjdC?=
 =?utf-8?B?VDRGQ250aVZSdWdUY0xoT0QxRE1qQWVyaFNrOTc5LzhHYUs1eXMxSUFyUUNk?=
 =?utf-8?B?Wm9nbkVWK2hrS0lOaE9LdG1JTEdxQzJ6ZGhsYjRSRmlBQ0kxRFhYQlJxTHJP?=
 =?utf-8?B?bStHRldrN05OVmRvQ3l0ZGpEZ1VYekpaZFRvcUMrSml2dFNHZWF3QmFiMWsw?=
 =?utf-8?B?b3R5V3JuUThNMzFqQkdRb3dDMU52YW9xVTBwaFBJSU9wenRhQmdJR3ZnNk9P?=
 =?utf-8?B?eEJlbU1uVnZ5RHBYL0xCcGo3MEN5dkkvcjA2VWtIU1hoSnM3Y0ZicnQxa3l2?=
 =?utf-8?Q?5vo36e0UQu+GCVkHM1xpOgCvV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c856f34-807b-46d0-8fcf-08dbdf52a5ed
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 05:30:27.0295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LtxZKK1iGWHyHXVwBceqLhV5mr3hdyJ+BRTN3+S1ydB3MHOIWjApDOIAZARbFECxUYF+xjewfGgyJO4GvxgGPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5347



On 11/6/2023 7:06 PM, Jason Gunthorpe wrote:
> On Mon, Nov 06, 2023 at 06:09:47PM +0530, Vasant Hegde wrote:
> 
>>> I think this driver really suffers from not having the right
>>> data structures to handle everything cleanly.
>>>
>>> In smmuv3 I added a 'master_domain' structure that linked the PCI
>>> device to the iommu_domain. ie when attach is done you'd create a new
>>> master_domain that essentially stores the parameters required to do
>>> invalidation.
>>>
>>> For what is going on here I would say to do that an then put the
>>> "domain id" inside the "master_domain". Decide when the domain is
>>> attached if the domain id should by taken from the iommu_domain
>>> (device does not support PASID) or from the device (device does
>>> support PASID)
>>
>> We still have single domain concept (at least until we introduce
>> vIOMMU). All we are changing is how we allocate domain ID.
>>
>> Having another domain for each device just to keep invalidation info is
>> complicates things. Also IMO its unnecessary.
> 
> It is not another domain, it is cleaning up the mess of keeping track
> of what caches need to be invalidated for a single domain.
> 
> Today we have this:
> 
> struct protection_domain {
> 	struct list_head dev_list; /* List of all devices in this domain */
> 	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
> 
> (and I'm sorry, but using a global array of iommus and this dev_iommu
> thing is an insane design)

Devices behind different IOMMU can be attached to same domain (like VFIO case).
We do need to track the IOMMUs and as part of invalidation we have a requirement
to send `completion` command to each IOMMU. So this links domain to IOMMUs.

Array is not a best thing here. I have it in my TODO list to change this to
xarray or something. But that's after SVA series as we are already making too
many changes to fundamental data structure in this series.

> 
> Now this adds a new concept domain_id_is_per_dev(), and it still
> doesn't support PASID properly!
> 
> Instead write it like this:
> 
> struct attachment {
>     struct list_head attachments_item;
>     struct amd_iommu *iommu;
>     struct iommu_dev_data *device;
>     ioasid_t pasid
> }
> 
> struct protection_domain {
>     struct list_head attachments;
> 
> 
> Where every ops->attach_dev allocates a new struct attachment and
> threads it on the liked list of the protection_domain.


We support PASID only in V2 page table mode. V1 does not have PASID stuff. So we
just have list of devices in the domain. Then each device has PASID table (that
what this series does).

Also as mentioned above we have the requirement of `completion wait` call for
each IOMMU. Hence we track the IOMMU list. Having it per device like above
increases completion wait calls which is not good. IMO above changes
unnecessarily complicates stuff.

> 
> Then the invalidation logic become completely straightforward, no
> confusing mess:
> 
> invalidate_iotlb_v1:
>    list_for_each_iommu(elm, domain->attachments)
>        build_cmd_v1_invalidation(&cmd, domain->cache_tag,  ...);
>        iommu_queue_command(elm->iommu, &cmd);

Ours is domain based invalidation. So our flushing logic is
	Flush IOMMU TLB for each IOMMUs
	If device has ATS
		Flush device IOTLB

	For each IOMMU (dev_iommu list)
		call completion wait
		

> 
> invalidate_iotlb_v2:
>    list_for_each_iommu(elm, domain->attachments)
>        build_cmd_v2_invalidation(&cmd, device->gcr3_cache_tag, elm->pasid, ...);
>        iommu_queue_command(elm->iommu, &cmd);

From driver point of view, fundamentally V2 invalidation is not too different as
we have single invalidation command. All we need is few extra param to tell its
guest page table invalidation with PASID.



> 
> invalidate_ats:
>    list_for_each(elm, domain->attachments)
>        if (!elm->device->ats enabled)
>              continue
>        build_cmd_atc_invalidation(&cmd, elm->device, elm->pasid, ...);
>        iommu_queue_command(elm->iommu, &cmd);


Driver already does this.

> 
> Where list_for_each_iommu de-duplicates the iommus from the sorted
> list, Michael had a series that showed how to do this for SMMU.
> 
> Basically you precalculate exactly the invalidations required and
> store it in a list associated with the domain. When it is time to do
> an invalidation then you just walk the list and do exactly what it
> says.

I think we have most things already in protection domain. Only extra check we
have is checking `pdom->dev_iommu[i]` which will be fixed separately.

-Vasant
