Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6CF1BDEF
	for <iommu@lists.linux.dev>; Fri, 13 Oct 2023 15:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MhmwkmYX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFjhEfE/O+W8YKiYoQKtte7ur9oMnsN76/mEPTLUqS+bhVdgFbzMaXpx2tUSQsgQqHKDdF5RbqLINJSsK8qzPRzKVMovyx28ja/Q2dfeziCw/ajgJXCR6e1el6wG07IV2brDQ6PCEpTKXQ5domDDqYMD6qyoGAQ+BObXnxNlchhszI5iDandBEMk7Q2zBn4eMKt9kx2su+tKtfSwaUtK2PFjJj/H+fIqTe1FuzI3CYuASlkCd04cXj6BoZe6uV6TnCvpNNridTB26jLqC6WhgaxcX2fXerCWZNHIpFDYpLWASp8N9WZmRQuJDPdL5wa8Wt9E+obCAzaXAwYWc8QLcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sGiyhhwIdjGQleLRI4Y5wbjr758uNNP57vYbQBlgek=;
 b=TEgu/zSvfvPRR3nAlKH/RoLqJpvjO9y2+fEOqDnfqc28xkzn05XVBfZPGe+je6vjg4PKLlEO0X7+6t/W3g0UuFoI5jkXTUrUnYMklv3BsFm8PuOavVjMEwzcHNWi4AIgvHAc0LeohtoWInQuQPAiuqQUxLcnPd+h6A5PXNrp+bHHhgYFtixGoPFKuutbqaLB+fJtw8FUD8s99PpxXgvOPS+HTfDrCle3V4kKEY0COoh2gi4+dTjNAesA72e8Wn67M/PH6lhGtt57N88oexczgCuKO6Ee3hTBfMzvb26Zdxy7RCn4bFIUSWG9Gy67mrhTRWWjCEH8++AfdqZ/1NVppw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sGiyhhwIdjGQleLRI4Y5wbjr758uNNP57vYbQBlgek=;
 b=MhmwkmYXPn4GuGjQUGEnAu815IM1fuFMv+3JSLOWPMG7CqiRK1dYYt4mnRO53RAXrQ0aUG/0BaTveUTAb0fbHCQElokgB700/c2yesSVxe8uKexVtfv+zhURcG70qVdU2pIzf+f6Gw2nsCQHhFlhi/tgf1olgr+ZaPLBsW9zjA8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MN2PR12MB4552.namprd12.prod.outlook.com (2603:10b6:208:24f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 15:52:33 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::726d:296a:5a0b:1e98]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::726d:296a:5a0b:1e98%4]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 15:52:31 +0000
Message-ID: <019ab268-fee3-215e-b805-cc3f19e0f634@amd.com>
Date: Fri, 13 Oct 2023 21:22:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 04/11] iommu/amd: Initial SVA support for AMD IOMMU
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230911121046.1025732-1-vasant.hegde@amd.com>
 <20230911121046.1025732-5-vasant.hegde@amd.com> <ZQCWMFFgbbcBN+0n@ziepe.ca>
 <2d863928-6ffa-4bf7-d4d6-689d779ad701@amd.com>
 <20230918125328.GD13795@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20230918125328.GD13795@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0194.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::19) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MN2PR12MB4552:EE_
X-MS-Office365-Filtering-Correlation-Id: d42d3ab0-8e96-4d2c-eac2-08dbcc0468cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KYyiJeI9TuOaBu+txELXa+dztz5bZxf//MtDJ4wEd5iASiBpkWMT+ZrnVeHny9WGbMSPBDkonw8SpB6kVoBlHUXsnpbiQ4rm6pDyYBI793l4XzH9XK6U2rZPnd3C/yW/noibeoipehdKIpxWW+QQIdLTA6Ijc46EcqIIQZAYXHcicpv/UsGPfOpRIkTQQMq9tH5M+w+ST5GAYLW/rwpb4zFXG3lhHAxv64xuOI8ae2riWqxOAKNPpvAL+to6VVHnd5vAEAtYlEa4HHqLKTW/qYw9M5njRxiPMC4DueulNG06aV8e4GvIvvQJK7BWAFAnkI4lhFv/KdjHBzv1WkgG1SUhl1z6qOzddUeuPlfrhKYw5NEz9drA3qvkLxOu2SdoMqHv55+BnnQYKtfIYR2ZCM+m8L2CUdlh+G6VzHyZAyx6xrRkJi8TT2fr2MSyK/SMQpsGOhCg6jLvk29AC+lRGlf4nMpsNQXHe+avCPPz286do7Z4ZuxqNHFk2e8QYIse0UlghUZyxXtCEP2UZ8VCz+3gUe4ZxuVbDCQaaJ8yAb2BFHtyMIPrxr/OnVj2RsWixKyUN/aehfUcvcd0+fJkpSD4IqZ+F6WDNA9Cv5nX+SS1aN2/vgpJj/iFw0Vvl1u8YRXkIVWth4WIzno3Wx7Jbw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(136003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(2616005)(6506007)(53546011)(6666004)(41300700001)(2906002)(66476007)(66556008)(66946007)(4326008)(44832011)(31686004)(26005)(478600001)(5660300002)(6512007)(6486002)(83380400001)(66899024)(316002)(6916009)(36756003)(8676002)(38100700002)(31696002)(86362001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnYwRUlYbFVSMlowbEpkdkJIVkRQUEFVY2RlNjJWNGF1S3ZTeXp0dnBZU2c0?=
 =?utf-8?B?ZkxLS0JwUDJZZ3RQSjJVVVE0QVVwL3JnQnJiSW9lVFQ5MVNKT0MvUHF2ZE5W?=
 =?utf-8?B?aUJFVFMrZEZWN0NxRlo1c0hEbU5HWndsU0p4em5CUWt4Q2ZraS84WGd3WUFK?=
 =?utf-8?B?MFJ4emkrYTg5TDVyVXFMR2ZjWkQ5WVZLTE5WYnFhR3hCemxoZ05VUjV0bFNL?=
 =?utf-8?B?VjNrRG9NVG0vTjVsZ3g4cXRwamU5MUdIZUZ0a1NUTURvVVNCQ0FmK01iZ1dB?=
 =?utf-8?B?TmZWSm5HaXpUZ1pzZjg4bUs2N1JsV0sxT1J0ZEw2Q1h5V2tKdWJjZ1hoeHlk?=
 =?utf-8?B?NDdkT2ZKbExhdk1CcE95WmNycHFkd0FneUhOMzltWnArbkNlZGErbWdXWkdQ?=
 =?utf-8?B?NXhZWFYySGRIeUNDdVpVVmMyajd1cTh6NWNsblBPRXJFQ2E3M3pUdmhkUnZ5?=
 =?utf-8?B?SDBFRDBkdDFIUzhZZ0l1RTdDelR2dVJhWm5oUDNwNFpvWGZldkg0QTFWUEV5?=
 =?utf-8?B?ZmFBTlJtaDBhdDBUMEdhTG5MaWlqTnhLeSt0cjVxbFhvZUJrR3RzbEZFSVJU?=
 =?utf-8?B?cEt4dldBUEdVcjh1NGdQaWFDOUNNbStncHdySHgvTG90MU1jNXhZeDZudVk3?=
 =?utf-8?B?OVp6Mk5XcTkxSmhTR21zV1FzNzJZZ2JSenVyZkpXSEkvNlcrdDAyUUxQK2Rv?=
 =?utf-8?B?MExRcWdZeDdaTFpXclNTMENmS1kvdUowd3M5SFR4SjBIS0tDek80ODlBY1VH?=
 =?utf-8?B?Ry9ZNU5ubERFVmZ2ZW5KclcyNVgwR2dnTUV0dXo4TDdhYlNLcGdaRGExTERx?=
 =?utf-8?B?TTluWkRmYkpxS21pTGY3VTlmWXl2T0I1cE83RDJOVjhDVEtwV3VzTHlqdVF5?=
 =?utf-8?B?aEorOVZqODN5WWNXRDNKd1lhZVVJVWFPOXN2UWhhQ1JIaVNXYVNPd0J1ZDd2?=
 =?utf-8?B?OUJUNThsYUZMTHdDQkxCYkxTb0JzbUxPb1ZZcW45TFMrbGxIdnMwVTNpZ1hY?=
 =?utf-8?B?NGlhaHhPNVJ5dkFoM1BKZ2FFLzFJUnVPWnZPbjVSWlRjL1g1R3V3aWt2UlRF?=
 =?utf-8?B?aWZMNkgyZHduNzNyUGE0ekpib2pBczR2aXEzSTAwbkhHbGZxZWFQaHFyUlJ6?=
 =?utf-8?B?YmY2OFRiWExlRmdhQ0JuSTRpTGVMaFU4bFFFaDZid1UrcG1OdXRCVS9jZFdy?=
 =?utf-8?B?alhDYWFwUFQ4d3VCeDJGWURKR2xJVUdZNSswcVRtUkNYcVZBZ3ZHNGh0d3Rw?=
 =?utf-8?B?WmZJU0tGTlBwMHJvOWVCUk45ckNVYXcvRGhVNGlYeWpUVXZ0UG41SWpsdTJ3?=
 =?utf-8?B?Yk4zYW16d0NRMWVMY3dHbzZob2pTallLKzJtM21qWEtzRHFoMWhhYldYQits?=
 =?utf-8?B?L2ZNMmtjN0J3a1JQem1oSTBsQmJwa3BBcitNQzVHNkdYbHo4bUNzMUdKcHlH?=
 =?utf-8?B?OExRN3V2U2ZnV0I4T3VmUXVrZ3FsZlBqUEZaSjhVUGlOM0l4MURLbnlSU3Rl?=
 =?utf-8?B?cFdYUHpqbFUvWHdmYVVrTTIvQ2ZPQXFiaGNUYnMvY0kwczVHRDEzQ2J4Yk5P?=
 =?utf-8?B?cFJyc3NKKzZUWG5ZM3g4ZjcvK3BubC9MQlIvN0xabjl0TmtTWDgrcWJRM2hZ?=
 =?utf-8?B?QjZuSVczbXp1VEtCS2hzMnNuQ21EQ2lzaUNMVlVUalFaSVMzNzREa3NXK25s?=
 =?utf-8?B?RmlaUEQ1QzVBSEdEdU83allWWFNQQ1J0SmFlcFROSFhVRFQ0Z1ZQYnE5SllG?=
 =?utf-8?B?V21QejFxTXJ6SG5oU2JIRER2RldSbnR3OVlPVEdJY2ZUNEU4MjBuZUdyclR3?=
 =?utf-8?B?OXhXUWJSYzZQZDFtakw5ZitxdkJZc1R4N0M1bHhoMjlkazRiejd2UjAxYlBG?=
 =?utf-8?B?b1JsZit2cWZQY2U3aWh0N1BsUTNXSFdjcWNHTm9SL0xrYlNOR2hlT2x4OGNv?=
 =?utf-8?B?ajdGK0tjaThRTkErNGwvMDJLOGpDdGlKdzJ1YlowZUxxWTgyRER5MGF4bmxj?=
 =?utf-8?B?VmF2eGNaRTBGckhETDFSeHdFeU5MN0d4ZytvQm42YkllSnpZUm00c2VJZWZu?=
 =?utf-8?B?Qjh0UW1ZdU9xeUFpZXg1NUtvTm9kdFk5a0FMQks1ZXpaQnhFQ1Zqdm1nYUdx?=
 =?utf-8?Q?DhR4RGaEsnCpFWBeCkbWCYPDD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d42d3ab0-8e96-4d2c-eac2-08dbcc0468cd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 15:52:31.6809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eHj3PvpZGmE/qnwYuwm9LU0c7Q8k+A8Et3zwuNHbYib6lt13SkglwNnHRsOsQd1UmlooS04Ywz8KOEdLW9m6HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4552



On 9/18/2023 6:23 PM, Jason Gunthorpe wrote:
> On Fri, Sep 15, 2023 at 02:20:32PM +0530, Vasant Hegde wrote:
> 
>>>> +		dev_data = pasid_data->dev_data;
>>>> +
>>>> +		if ((start ^ (end - 1)) < PAGE_SIZE) {
>>>> +			amd_iommu_flush_page(dev_data->domain,
>>>> +					     pasid_data->pasid, start);
>>>> +		} else {
>>>> +			amd_iommu_flush_tlb(dev_data->domain,
>>>> +					    pasid_data->pasid);
>>>> +		}
>>>
>>> It is baffling why dev_data->domain would be used here, and it isn't
>>> locked properly so this is a problem.
>>>
>>> Looking into __flush_pasid it doesn't really make sense. The PASID
>>> domain definately can't assume that the RID domain has the the same
>>> set of iommus. Most likely the SVA domain has a wider set of iommus,
>>> at least I didn't notice any logic preventing this in set_dev_pasid.
>>
>> Right. SVA protection domain will just add dev/PASID combination without
>> worrying device protection domain/iommu.
>>
>> In invalidation path, I walk the `pasid_list` from SVA protection domain, get
>> dev_data/PASID info and use those for invaliation. Since invalidation needs
>> device protection domain I have to refer dev_data->domain.
> 
> See my other email, this area looks quite troubled.
> 
>>> Also, didn't you say you wanted to de-duplicate the IOTLB and ATC
>>> invalidations like ARM is doing?
>>
>> I don't have the understanding of ARM. But our invalidation
>> interfaces needs improvement. Like current code does unncessary
>> complete_wait() calls. Those will be fixed along with other
>> invalidation cleanup.
> 
> Future fix is fine
>  
>>>
>>>> +static const struct mmu_notifier_ops sva_mn = {
>>>> +	.invalidate_range = sva_mn_invalidate_range,
>>>> +	.release = sva_mn_release,
>>>> +};
>>>
>>> Why an empty release function?
>>>
>>> That can't be right, when release is called the driver has to stop
>>> using iommu_virt_to_phys(domain->mm->pgd)) because it will be freed
>>> memory. It should replace it with a global empty pgd and flush caches
>>> before release returns.
>>
>> In remove_dev_pasid() its already removed PASID from GCR3 table, flushing IOMMU.
>> Also if its last device unbind, then it also does mmu_notifier_unregister().
>>
>> I thought remove_dev_pasid() always gets called before mmu notifier releases.
>> Is there any chance of mmu notifier relase() getting called before
>> remove_dev_pasid().
> 
> Yes it can be called in that order. An empty release function here is buggy.

Then I misunderstood this part. Will fix it in v3.

> 
>>>> +	pasid_data->pasid = pasid;
>>>> +	pasid_data->dev_data = dev_data;
>>>> +
>>>> +	/* Setup GCR3 table */
>>>> +	ret = amd_iommu_set_gcr3(dev_data, pasid,
>>>> +				 iommu_virt_to_phys(domain->mm->pgd));
>>>> +	if (ret)
>>>> +		goto out_free_pasid_data;
>>>> +
>>>> +	if (list_empty(&sva_pdom->pasid_list)) {
>>>> +		sva_pdom->mn.ops = &sva_mn;
>>>> +
>>>> +		ret = mmu_notifier_register(&sva_pdom->mn, domain->mm);
>>>> +		if (ret)
>>>> +			goto out_clear_gcr3;
>>>> +	}
>>>
>>> Looks to me like mmu_notifier_register() should be done before
>>> amd_iommu_set_gcr3() so we don't have a risk of stale iotlb data.
>>
>> Actually we need to update GCR3 table with PASID before registering mmu
>> notifier. So that hardware is ready to handle the invalidations. Otherwise we
>> will have a redudant invalidations.
> 
> If you register the mmu and the paslid_list is empty (or locked) then the
> invalidation handler does nothing. So this cannot be a concern.

Yeah. With all these changes I think changing order is fine.

> 
> Putting it out of order like this creates an edge case where the HW
> could concivable cache a translation and miss a notification. It is
> definately wrong.
> 
>>>> +void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
>>>> +{
>>>> +	struct pdom_pasid_data *pasid_data;
>>>> +	struct protection_domain *sva_pdom;
>>>> +	struct iommu_domain *domain;
>>>> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>>>> +	unsigned long flags;
>>>> +
>>>> +	if (pasid == 0 || pasid >= dev->iommu->max_pasids)
>>>> +		return;
>>>> +
>>>> +	/* Get protection domain */
>>>> +	domain = iommu_get_domain_for_dev_pasid(dev, pasid, IOMMU_DOMAIN_SVA);
>>>> +	if (!domain)
>>>> +		return;
>>>> +	sva_pdom = to_pdomain(domain);
>>>> +
>>>> +	/* Ensure that all queued faults have been processed */
>>>> +	iopf_queue_flush_dev(dev);
>>>> +
>>>> +	spin_lock_irqsave(&sva_pdom->lock, flags);
>>>> +
>>>> +	pasid_data = get_pdom_pasid_data(sva_pdom, dev, pasid);
>>>> +	if (!pasid_data) {
>>>> +		spin_unlock_irqrestore(&sva_pdom->lock, flags);
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	list_del(&pasid_data->pdom_link);
>>>> +	kfree(pasid_data);
>>>> +
>>>> +	/* make it visible */
>>>> +	smp_wmb();
>>>> +
>>>> +	/* Update GCR3 table and flush IOTLB */
>>>> +	amd_iommu_clear_gcr3(dev_data, pasid);
>>>> +
>>>> +	spin_unlock_irqrestore(&sva_pdom->lock, flags);
>>>> +
>>>> +	if (list_empty(&sva_pdom->pasid_list))
>>>> +		mmu_notifier_unregister(&sva_pdom->mn, domain->mm);
>>>
>>> Can't drop the spinlock before doing this, it is racy.
>>
>> Yeah. Its racy. But we cannot call mmu_notifier_unregister() with spinlock held.
>> May be I will introduce some lock to handle notifier.
> 
> If you reoganize things so the notifier is always registered then you
> don't need to have the spinlock protecting it anymore. this requires
> putting the unregister in the domain deallocation routine.

Yeah. I will put unregister in de-allocation path instead of adding another lock.

-Vasant
