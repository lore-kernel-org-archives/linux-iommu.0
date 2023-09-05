Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2064.outbound.protection.outlook.com [40.107.95.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C805EBC
	for <iommu@lists.linux.dev>; Tue,  5 Sep 2023 06:18:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i37FLaf/CBNr2gP8mUi/I6w1dkDs57Km6K3HgbBZ4cpp1362hnWpitb7YKZczAfqnqrJD7WjtUg+9DEIkNejvluYjjvsQ0Rycn1nVB+0z8yj7OFHskLxNPb5ses+91ob+jkqxbCwiSPzY4zwPLbcnhAA4W115LtYdOmu/54mOPPIm4b425KOhFaDlkrAxV0s85IuLZvfH7wUbrZmP1xmUubJICaFk8WGwgJPctwD+30G6jH6MgWtyq9NrvS+TxnDgeErrHUmr4emMgMburgovTIPSi2UAaGK7fgNWq/Aqdbm403bcUllIzWl53yFX0lGeFdqniul7vdzO91U3URbag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwyNUuUVsV6Ht9lo+lf/dhFQ+Co8woXjpo1q3B92Z1A=;
 b=ZFY6hHA5Uf14kbWvqB/rqORmxUCI3tjEDk8qLjpfaaARFkVuO5FQ9mPOTa6hnkCYtUiOLzG3I6WFChCknXYXsaK1uAS72m780gs4fnJCliLAVeanc/or6cLGs6ZUCAe5DJitZpbUfvgHH1RqKmpb62RhRJd07FqZnlYjULtmnTvStjdkM2ybAJRwNOAFZQYi895+tQRszz3Ly2amKXTU1FXdZ+10DmHCTDLG//zcV2/cS8WXH8YDkREjNx8mzpVM29G4PqqpfSRjIVVS3dTNfYhFIqgEKV2d0mJqMJb9PKgtt2RO2Z4m4FdoYDBErpmEfPuX5+0Mohp7s3nmr29Lxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwyNUuUVsV6Ht9lo+lf/dhFQ+Co8woXjpo1q3B92Z1A=;
 b=RzYzOlbMQl6K1IiV+6WMeE9U0Z7Oq1ZnQ1LJxrLh1bG5QvcEms8EcBbmSa70lCuAz/aPbAKOTPM8ZgsmpQm34NHmJ34KLWrLPH0AT+LnuBLMFtDpsDKHXKgVwUOqe3ibCXhzeNvrNMb8liyANlxVdQ/C+u96KTZ+RxRYcz7yE3s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 BL1PR12MB5923.namprd12.prod.outlook.com (2603:10b6:208:39a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Tue, 5 Sep
 2023 06:18:44 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 06:18:43 +0000
Message-ID: <d64d8066-7cee-46c6-2403-76eaa969fe53@amd.com>
Date: Tue, 5 Sep 2023 11:48:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH RESEND 03/10] iommu/amd: Initial SVA support for AMD IOMMU
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230823140415.729050-1-vasant.hegde@amd.com>
 <20230823140415.729050-4-vasant.hegde@amd.com> <ZOYXoMPBQZ5KK9IJ@ziepe.ca>
 <fc17e0fb-e712-824f-93f9-f9edf5707395@amd.com> <ZO93WJnhxl+sC9zA@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZO93WJnhxl+sC9zA@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0166.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::10) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|BL1PR12MB5923:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b23d17-9164-4b17-03cd-08dbadd7f3f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	stFPrag7FpRyhay3OYzzaHQfev7LmDKvBi/LWsh4KzF4vVRN6fR/2L1ZwAVt7bauN7nsnhbKwVYlsebheDkcKVqqR465LtCMR41K/G5hYXP8W3JlJKE6gJF4Ynv147hvczqE1KhBXW64bKO2rP/VL/c9ZBeNiNXcscNhW8o6ipIYwRwC2qwEuqjvSnTUguUgUr/4Ue/MHWPlv6f0KupHhfCH/hwMzT7F+P5dQSTTYZzCcDjZnKlgCtjpIQli9Z1rrPYTsjfj1Uvw4S+GwlTPUB8w4gAdwlPd8Zn/mVNkVPx2XEnPJpsSjFUMuO9H1lR9HdTJ+FwsojGmJ2oYcFpEapiVvDrFnz52GKItPF3OOlzjDgkXtofLUUGGJ3xPFh5LY6hCqgEAl99ac2b8iMIM1mqK+Blj/2SKbRnbEYAeFbDsEj+kK5zenPb5p/VGazngyqW0rtrUn8KTJdZid0v/9nX6hh8r87GUzR5+T5V/ueVASeS6Nviumr3Xq1uP9vDHMZEGMGCe6wA0nZmCIXke0SleKr1ezDktyJIq+kbaYWQmwMK0ouHp7m7tGu4ApED2KC8WVEIGCC/gdJCgh6Mm6DeuXNJdyZMk3j1bZ6miPXjxekwFiWEqhcy1spYIUYvQmQfwAZj1p5sa29mMOJLIWg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(346002)(39860400002)(396003)(1800799009)(186009)(451199024)(5660300002)(41300700001)(2616005)(26005)(2906002)(86362001)(31696002)(38100700002)(36756003)(44832011)(4326008)(8936002)(8676002)(83380400001)(6512007)(6666004)(53546011)(6506007)(31686004)(6486002)(478600001)(966005)(316002)(6916009)(66946007)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGlQd3RQc0hhSWltZHVRMkJRWUdxRHY4R2RqWDZRRk9iZVlkM1dvUkY4Rllh?=
 =?utf-8?B?QThQU0EzTkk5WXFLNEhsQ0t5VlpTcGJZNmJXSWUwU09RZVVOTnNtSm5LVk81?=
 =?utf-8?B?TlI3bFgvYSs4b2Q3ajJvVnJwTzc4TmpQeUw1VzFJVlg2Q3RoK2tpR0hLV1lT?=
 =?utf-8?B?T3VLdEo1SFZiRGhBckt1c1UzZUVvWmZMcmw5Q3A5d1A1SDU4K2l0Um1YWWRt?=
 =?utf-8?B?d2tBak0wTzhhdmxtRHNHaHRHQkw1ZExWV3lSNkd4SXV1WllERmozZnFCdklk?=
 =?utf-8?B?aXFjVVJlMXV2U21ZL3ZkWVpnTXVuZzhsd2FmampsVWtCb3NiVzJLMGg4WnNs?=
 =?utf-8?B?ejJGWEhUN0VJN29peWowMVNZYko1VlhKZTFyelhMZzR1a2JtdThReWRIR1Ir?=
 =?utf-8?B?d0lPYm9IcmhRdlNzZHdFamxHN2lBY1l4aWxmOVEyWllEUHVQT2YxK1pWK3Ez?=
 =?utf-8?B?akRDQzR5TWtkb2NnRkVRZWJlbkxUTkhqUFVjTjRmaTJVWU5VcEFsTk5PaVI3?=
 =?utf-8?B?bGZHL2VJTmd6endJYTFtb280RDgyVmF5cnJGOW8xVmNMUkhjbzlPOEZrYTFS?=
 =?utf-8?B?UFVzbjJHQmJ5Sy8xcEFvbEZSQlhRWncvZlBTUzYxUjRDRkd1QUxzdUJ6R1Nq?=
 =?utf-8?B?OFpmSkd2N1ZKRkplOVk5SkEzSzZUZ1Jpd1M0aGRWb09BbGx6VEs4NXFkVTBa?=
 =?utf-8?B?d3ZIcmVGRG05M0FmMG9xUFhhejdsL2hSUk91Y3NmeWJuYWgxeHhIVGt3ZzlY?=
 =?utf-8?B?Z0lvUkxUMEkzaURqdDdQZ2VVV3BPOExqd0lOMnROcXJIeG1xNlQ3clRYTlFN?=
 =?utf-8?B?SkU1UEloUXlUV0VXa25ZMUwrMmh6bzlIQVlhWGZUdnpKSzVVN2l0NFhxSnBo?=
 =?utf-8?B?NzRPZ3EwZkJTdktoUytQd3FYTUw3NUgweTVvNXFPVmlBYncwQy84a3hzM05J?=
 =?utf-8?B?ajBNTE80RkJWdlVJLy96M05lSFcrNFMwSnVudFMrUkNxQ1RCZTcvSlF5bnFD?=
 =?utf-8?B?cFloeFNPMENhOXpxU2NjN1dVTytidlV6WXVWVkVodGcxMDFCR2d5bU41ZG0v?=
 =?utf-8?B?dWtIbFhmM1NWdUovejJtc1FQNG1yeW11a1dWQVpPSXZmbkI0UlFkanJmdjMw?=
 =?utf-8?B?bXpmQ3lhM05yQU9RQlY3RFBlK1ptVVdOdzlhUHlPeWtWbVJhRnRNdUJZaU5E?=
 =?utf-8?B?UVE1MnVzeXBURmRVYm1IVzdxL1Y3U0dkUmwwQW1lZWRPdTZLZEpHTytVY0xI?=
 =?utf-8?B?anNJL0pqcWdWZ0lrOGFVdzY3MUVIRHlKbW1lVkFvTXE1c3g4ZTZVVkMwNkx4?=
 =?utf-8?B?YnlWWDI4cCs3SmRmNlVyVFk4eHhXblo0SGFVUjZDWDRITXpRdzFZUUtqSWtY?=
 =?utf-8?B?cjhUV0RoUkl4YStPak1mUlBvMVJLVXllckVEUHE4SEV2cW9mM1lYVEJBWGJt?=
 =?utf-8?B?NTNtcHkxSFJHSFpOT1ZCc1h1UXpNOTYwK0h2VEJSS2ZXbzF2RFhiQUhTdHZw?=
 =?utf-8?B?Q1E5ek90Z0Z0THpvV0I3cUhCejRoenlETkd3K0lPWWwzNHpXRXlHWUNWVmtx?=
 =?utf-8?B?RytFd25hYi9Ua0Izc1lMU1BLclpqUWtTYVpiaHBJS3BMWUNNSGtJYm1iOC91?=
 =?utf-8?B?TG9UQjdWanBnaXNIRDZ5L1dMRk1sOC81bTE1TVhTejlyODRhMWFySjl0ZW1W?=
 =?utf-8?B?NW9pV041M2pUVi9NK0wwWW53UER0anRtK1Y1bm13dDQ4YnJaR3NWTzQzdnlx?=
 =?utf-8?B?QitwRFI2N09vRTl5SmNjOUM5RERSb0krNDVrSkY3M1VxNXhvTHZyWk43cGtG?=
 =?utf-8?B?MTlzMmVOUkpYb013blEwUmY3L3BKWE1kdnZuLyt3aUdRbWdDS3dYdkpETkww?=
 =?utf-8?B?TERFMnpGdW9oejYvb0t0SGJLLzdJY3lpb3lEWGdLQnplZ0JpYkNsOEx5MVNr?=
 =?utf-8?B?TnNxZjY1K1ZSS2orcnRmNUJGcHdDbUdMVGFKV1I2Zjh3OVRvNk9OdDVFZmho?=
 =?utf-8?B?VE1Sbkk1a3dxUnB3Nm96RDZoM3Q4MUlGdEt4a2crQXJieGZGQU5TYlM0enB2?=
 =?utf-8?B?MDB0bmRUM29yOGZvZklIWTZkNWhoMXFkVXJ3T1VDMlU3bWtvOVZ2ci9vUHNi?=
 =?utf-8?Q?Rda2Vd4l5CZ3zfsolFF1t862+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b23d17-9164-4b17-03cd-08dbadd7f3f2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 06:18:42.8632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bS1a2M8iEZmEu0hvusE833lX7+gCue4fo83LqnvCBu7ETXJ1+NiFpnjA0MR1OB9s9NkyYGSnWvbVDQdEMJA7bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5923

Jason,


On 8/30/2023 10:37 PM, Jason Gunthorpe wrote:
> On Mon, Aug 28, 2023 at 04:09:16PM +0530, Vasant Hegde wrote:
> 
>>>> +static void *sva_pasid_private_find(u32 pasid)
>>>> +{
>>>> +	return xa_load(&sva_pasid_array, pasid);
>>>> +}
>>>
>>> No PASID stuff in SVA code at all please, all of this is wrong.
>>
>> This is based on upstream code!
> 
> Yes, and we are changing all of this because how wrong the drivers
> went with stuff like this. :(
> 
>>> No per-PASID struct. AMD enablement should go after this series:
>>>
>>>  https://lore.kernel.org/linux-iommu/20230808074944.7825-1-tina.zhang@intel.com/
>>>
>>> Put the mmu_notifier directly into the protection_domain. Assume you
>>> have a single protection_domain per mm.
>>
>> Actually we have protection domain for each IOMMU group (or multiple group in
>> case of VM). 
> 
> Why would you do that for SVA? That is not the direction we are going.
> One iommu_domain per mm, managed by the core code.
> 
> Driver assumes this and optimizes based on it.
> 
> If driver needs per device/pasid/whatever data then it keeps only that
> data in a list hanging off the single iommu_domain.
> 
> It should be *exactly the same* data that an unmanaged domain needs to
> manage its invalidations and ATC.
> 
>>> Also amd_sva_dev is not appropriate, the list of PASIDs (and masters)
>>> a domain is associated with is part of the generic PASID support in
>>> the protection_domain itself.
>>
>> You mean to say, we maintain PASID list in device protection_domain
>> and then in
> 
> yes, a linked list of devices RID and PASIDs that the domain is
> attached to.
> 
> This is mandatory to issue any form of invalidation, an UNMANAGED
> domains should use the same list, and same mechanism to invalidate
> their PASID attachments as well.
> 
>> invalidation path (somehow) we retrieve protection domain and use it
>> for
> 
> Yes, obtain the domain trivially via container_of(mmu_notifier). Store
> the notifier in the SVA iommu_domain's driver struct
> (protection_domain) to do this.

Reading through the discussion so far again and the other series, my
understanding is :
  - set_dev_pasid() will check the compatibility and bind device/pasid only if
its compatibility. In AMD case we will check against protection domain. Ex:
 If we have two devices (devA and devB) in two different protection domain then:
   set_dev_pasid(sva_domain, devA, pasidX) - SUCCESS
   set_dev_pasid(sva_domain, devB, pasidX) - Compatibility check fail
   Core will allocate new SVA domain (sva_domain_new)
   set_dev_pasid(sva_domain_new, devB, pasidX) - SUCCESS

  - We will track mmu notifier and other data required for invalidation in SVA
protection domain.

  - During invalidation, we will retrieve SVA protection domain using mmu
notifier. Use device protection domain which was tracked in this SVA domain for
invalidation.

Does above flow makes sense? I do have a code based on above flow. I will try to
post soon.



> 
> This is why the core code helps the driver by de-duplicating the SVA
> domains, it can assume the iommu_domain is already minimal and it can
> then safely place the notifier there. The drivers should not try to
> de-duplicate the notifier with refcounting/etc.
> 
>>> These details would be clearer if you start from enabling PASID
>>> support for an UNMANAGED domain.
>>
>> We don't support PASID with V1 page table.
> 
> I didn't say V1 page table, I said enabling PASID support for
> UNMANGED domains. This means you need a flavour of UNMANAGED domain
> that is V2 page table. Just like ARM does. You already have this
> support in the driver.
> 
>>>> +static void sva_mn_invalidate_range(struct mmu_notifier *mn,
>>>> +				    struct mm_struct *mm,
>>>> +				    unsigned long start, unsigned long end)
>>>> +{
>>>> +	struct amd_sva_pasid *sva_pasid;
>>>> +	struct amd_sva_dev *sva_dev;
>>>> +
>>>> +	rcu_read_lock();
>>>> +
>>>> +	sva_pasid = container_of(mn, struct amd_sva_pasid, mn);
>>>> +	if (!sva_pasid) {
>>>> +		rcu_read_unlock();
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	list_for_each_entry_rcu(sva_dev, &sva_pasid->dev_list, list) {
>>>> +		if ((start ^ (end - 1)) < PAGE_SIZE)
>>>> +			amd_iommu_flush_page(sva_dev->dev_data->domain, sva_pasid->pasid, start);
>>>> +		else
>>>> +			amd_iommu_flush_tlb(sva_dev->dev_data->domain, sva_pasid->pasid);
>>>> +	}
>>>
>>> SVA invalidation should be the same as normal PASID invalidation. You
>>
>> Its same (Currently we have two different functions based on PAGE_SIZE. We have
>> a separate series to improve our invalidation logic).
> 
> It is not the same, you have this weird sva_pasid thing in here. PASID
> is NOT part of the SVA layer.
> 
> The API expects UNMANAGED domains will support PASID attach as well,
> that is a significant use case.

Can you elaborate the use cases you are referring here?

We do have use cases for PASID and PASID+PRI. But I am not aware of any use case
for UNMANAGED domain.


> 
>>> Use container_of(mn) to get back to the SVA protection domain and then
>>> you can access the protection domains list of PASIDs & masters.
>>
>> I don't think I understood this. Even with Tina's patch series, we can get the
>> SVA domain list. But we don't have a way to get device base protection domain.
> 
> Tina's patch series allows you to place the mmu_notifier struct
> directly in the protection_domain struct.
> 
> When you get the invalidate() callback you go back to the
> iommu_domain/protection domain that is affiliated with this MM.
> 
> From there you have all the information you can possibly need:
> 
>  - Global information in the protect_domain shared by all the devices
>    (eg ARM uses this to put the shared cache tag)
> 
>  - Per attachment information (RID & PASID/etc) for each attachment.
>    Iterate over this list to get the PASID/etc.

Got it. Thanks.


> 
>>>> +static int sva_bind_mm(struct device *dev, struct mm_struct *mm)
>>>> +{
>>>> +	struct amd_sva_pasid *sva_pasid;
>>>> +	struct amd_sva_dev *sva_dev;
>>>> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>>>> +	int ret = -EINVAL;
>>>> +
>>>> +	sva_dev = sva_dev_alloc(dev);
>>>> +	if (!sva_dev)
>>>> +		return ret;
>>>> +
>>>> +	sva_pasid = sva_pasid_private_find(mm->pasid);
>>>> +	if (!sva_pasid) {
>>>> +		sva_pasid = sva_pasid_alloc(mm);
>>>> +		if (!sva_pasid)
>>>> +			goto out_sva_dev;
>>>> +
>>>> +		ret = sva_pasid_private_add(sva_pasid->pasid, sva_pasid);
>>>> +		if (ret)
>>>> +			goto out_sva_pasid;
>>>> +
>>>> +		ret = amd_iommu_set_gcr3(dev_data, sva_pasid->pasid,
>>>> +					 iommu_virt_to_phys(sva_pasid->mm->pgd));
>>>> +		if (ret)
>>>> +			goto out_pasid_remove;
>>>> +
>>>> +		ret = mmu_notifier_register(&sva_pasid->mn, mm);
>>>> +		if (ret)
>>>> +			goto out_clear_gcr3;
>>>> +	}
>>>
>>> The mmu_notifier should be setup when the domain is allocated, not
>>> during bind.
>>
>> We need to program (at least with AMD IOMMU) device PASID table before it can
>> handle the invalidation notifications. Not sure how it will work if we move mmu
>> notifier setup to domain allocation path.
> 
> The device list will be empty so there will be no PASIDs to
> invalidate at this point. There will be seperate locking to protect
> the device list, ensure that locking properly covers populating the
> device list and setting up the HW to respond to the PASID.
> 
>>>> +void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
>>>> +{
>>>> +	struct iommu_domain *domain;
>>>> +
>>>> +	if (pasid == 0 || pasid >= dev->iommu->max_pasids)
>>>> +		return;
>>>
>>> We should probably have the core code pass in the old domain to this
>>> function, it is looking more like a mistake we didn't do that.
>>
>> I don't think I understood this. Well, honestly I never understood why
>> remove_dev_pasid() is part of iommu_ops while set_dev_pasid is part of domain ops.
> 
> Yeah, that is a bit weird, not sure there is a good reason
> 
> Regardless, the API should take in the current domain parmeter and
> drivers shouldn't call the core to look it up in the xarray if that is
> what drivers need to do.

Yeah. All I care is retrieving SVA domain. Using SVA domain I can get the
protection domain and do rest of the stuff.

With all new changes, it makes sense to pass sva domain to remove_dev_pasid.

-Vasant
