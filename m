Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55902846F
	for <iommu@lists.linux.dev>; Mon, 11 Mar 2024 10:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710151347; cv=fail; b=vBtkThMPcZyTgPss7aMjpBoYyOLJFPm5GGLgpaoFjBZGRR/Ljx0wqOzTTWC2/uE7/Gkc2Vdbop9Gf9XIfCKtDylzKpLXP9h4n2V7Keud8ZhZLXZeKmdkiipcFdVxKCvM32EAUs1/HuawJkvnHiRfHe6Z502ZlSNkPlXhfNZbQOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710151347; c=relaxed/simple;
	bh=ibXbK7RgzrsOY/x08ndZURZh9Qv/Wxp4+97FVq4E5nA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XwDycf8rIYTyEFHSftnUwxJmYyD1nfBgE8SemosmmM6P8Fe4TojS6PmIj6QWteUR/S6tfZd2z8p5yY4yf5coGX5vOmoId+KNvpN+t8bvz+3w5kaJYBjnnkvHKSvFwAD5ExaM9xAW6TP7EJeUTlM9LshFKe9gwUyPBD29myNjpyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OOHN0Gli; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OOHN0Gli"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwTT2sD4SLFkrORYosncBoAaddAddaKGleEdMisLq1IK3NnHXhhn/IqC+1EayRUKZdmHM9HYYC678Cl5vEBBrTi2su/IwCq5C5MZ0RsikoMHCydt8i78AGriqKyq0yuz7VzbAwgeOdCUT8+ywMtT6ScSS5/Xgmo/oiOf0/nwAPznob0duBqaBZjCAO1o2+noWb7puqLLvx1FqH82eg/uRsbbHFFn4YvRJjh3JGLkihRtyDUlr2uwrcAmqIl2VZtN36spnwLLdFxx7fkCwmXYT50Ij5fM4Vk35fZs60AT08FEL/3P1KSDapSfLkCN8T0ein57jlVuSNOVhoYIqvXczg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eoG71otUH9PaKE3IbX3io7HjI/3y1OAza/24Z+bbFE=;
 b=A2CqkJs3wofUKiQKmvvILUb/3l3++nqHoSVtCP5XAA4ESrRpQiIEJkdoTVZo9ABlKCwwuHpAtKlja392P4ufaSzT+3+3iIWnSYvxIkiC9PcF5W/IW5+9mBF+JafPyg1E3eBGOf3jqN9P1Dbq0lrLPYT1j9oP5eXP3zbUwbI+Bk1H88mpX2mLNE4PHqaqxAUsUUeH2f7HDDAIl1Yy+0+rbH1F8MvJP8CxcAC0sw/c5BzBUKj0scvHbpp3P0+RtPqAifBMLnse5ChdMl+h3zjVxZSShJQmD+DNOi7S9h4OdbMLrQT7Bw+H91MumYihuw9XY9ffhVWoKvDCIcv3G9uYUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eoG71otUH9PaKE3IbX3io7HjI/3y1OAza/24Z+bbFE=;
 b=OOHN0GliJd8tJIdMl5Tdggf0cqQ0tkqxGgq2XYq21AXpNVb1yJJ8taPsIUljaQKCNZzbRfBgqBfTt6+FP/3olUZLZOYek8TqvTL9wd42x1TOQvbmnrczcYCzczcZllFQHUG2Dpdqt5yQ95cPB33pkNvpi5B52l7I3b+ZHSVSdCA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SA1PR12MB5640.namprd12.prod.outlook.com (2603:10b6:806:23e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.34; Mon, 11 Mar 2024 10:02:21 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::d709:cb7d:2612:bb27]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::d709:cb7d:2612:bb27%5]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 10:02:20 +0000
Message-ID: <396ddcaf-f674-1f27-a700-2f93fd7b9cd4@amd.com>
Date: Mon, 11 Mar 2024 15:32:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 08/15] iommu/amd: Enable PCI features based on attached
 domain capability
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20240209112930.63663-1-vasant.hegde@amd.com>
 <20240209112930.63663-9-vasant.hegde@amd.com>
 <20240305003219.GC9225@ziepe.ca>
 <87abadb2-aa08-3a79-e1a2-4031b2c7e791@amd.com>
 <20240305160108.GJ9225@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240305160108.GJ9225@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0241.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::12) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SA1PR12MB5640:EE_
X-MS-Office365-Filtering-Correlation-Id: cf9e9289-b469-46b5-1219-08dc41b25723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ekkt1h6/pEdQZdv9pLvAPiTbS0qE6JwvjUov+sSJjTF3BHM3yhE5RwQ5Sj94gtvB/HYoanT7VqhmYBNZjHiO7X9qpztZ3EDB/U8MxqoQi37KAd9hQZ9c22Zw55XZiX5lEhh5DVhpkBdlgF/f7K+CEwImwliN9qHDxmJzo52cMv9Ajuw8KPjD6ZJ1sjACQB7bJa5FB953O+KEmNV48kvHzUhRjtA1KLn3l+i6dYrVGSyeWddHxwfRU3kSGmxXHtSuSe7xMuMpIWHSuqOoqT5YYCsEPuKgix7sSbReGLtTrEEVKTzrzINwOsVxr1tuNq4b13J4DuR6gqT+I5nubqnEWJslKVxCGNA6up8lTTAmPukyF3ImePVg2xlYAZbIsfqBaRba+xN9IERCaO7tenj+5CBNWwh0TdstyDijD0AI9I9hhKeU7ZUepnJCE0I7wzNe44GywZhEseGxU6tYy4okgbhohWkj24dY1cqbuxERUHiiPCyCe4bATXb7ntapDIuO6jwVI2U5oZG8zS2fAum3r8i8kgRE6gpdncJ7D07UBs/qA1sv+FsurZ5qYEQspNeqtIlcNrgYaWxPYoICEkDCX+9a/o9hbjoCxs4LC13Z2QzDrHNZLOhmrVLWqnLuXn63SdkTr6cB1dSHQ15toyhhXIwJCIrq0kXYcA7me5ZTBq0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFdxT2VubzNEUDYvOEdlOUprcmR5Smk1MVpFeVdhUUdoYWQ4Y1VrdmNQb0Qx?=
 =?utf-8?B?QzR2cW16RnVJL0RObi9jODh6a1NzZEt0Q1dyQ0NJR0pOclRlWnA2cHlHRmJu?=
 =?utf-8?B?Nm0xUjFBZWdyUzRsZzRLbGFBUFpLYmNBa0JyVGxQTmxTYlBVUE9HZ2FBZmM3?=
 =?utf-8?B?YnQ1UFJzUDY1U1EycDVUK05COVVyWE1qU2IyQTlRWE1rNnFtWlNhSWwyOFZH?=
 =?utf-8?B?YjRmLzUzVUVhQkhzSWJwZzFWNGZaTUU0eDhsMUkxMG1ralREVzNzZTZmYVBs?=
 =?utf-8?B?MkppSDdnUHoyNFFNMThYRXg0eEUyZWtFcTRUMGFhbzhOZlJLNEJRNU02RHpI?=
 =?utf-8?B?TEpwTGNTQzFicDVPTDN4Z2tobTVnOUp5cnI2Rk1DSkxjellCLzdzK2pMWEFC?=
 =?utf-8?B?UXR3TmFJMGROa3dRQ1ZWeHRVNmNyczlqaU83Z3FYZGpnNGhzbzdIRXlTVDR1?=
 =?utf-8?B?WE15UTArOEpLTGROenl6Q2Z0alJZWmtPcDBpYjh2K2M5eW1FaGZVcUVoaEFL?=
 =?utf-8?B?blBHZkJjY2c3UlR1bTRHdUFCTXJQcXo1OEhJeFU5TjFlcVZ0WVVVZEo3RTdp?=
 =?utf-8?B?RWgrQml0UUhta29NRVhLN1Z0SWM4d2JKNDMxL1lmd0NGRHZxRmZiVHFyV1Yy?=
 =?utf-8?B?ZFdQSDZ5MGJ6MXQ0amdKNlE4M3NBS05NSWM5RS9JaHppdnZBcDBJWm9VY1N1?=
 =?utf-8?B?NXJCejhiNlJ3RWhHU25SZHNhWWdGbWNNZWN1UktxUUNobUJ1WTRqNnBrTlJ6?=
 =?utf-8?B?eks1TVJYUkgxWkVLOEZZZmVkL3BjL3cwRzVQU0VkUmJsQlNrQUhSbXJHUnNW?=
 =?utf-8?B?QmVKUWk2SHJ1c242OWpCamVzU3BDTDdISXM5S1l2SzVVS0NoWWN0MkYxOFpq?=
 =?utf-8?B?YjkxQktLR0k4dTJUU1JST0xkRzEvNzVDR2lvdituWjR5bGhMc016VGVxWUVk?=
 =?utf-8?B?b0M3OXJ5L1RyajJHL2RuMFNqQkREQTVvS3JXR0dKdTBMUEVjUDdtUjBFTjdx?=
 =?utf-8?B?ZURlWHdpTTJ5cEFlTVM2NVJlczhKc2ZRbUYyU2pwNmltTGcxeFBiYW1xeW91?=
 =?utf-8?B?L2FSVnNaYmJ1Q2luYXB1TERobTBsTTlYUGtFNzMxcFR1UVFNaThyVVlzSjFE?=
 =?utf-8?B?aXFMTU1VNXRmWFJRWjY3eVlVWlZUcit1M3pYZ0dWclhOcVVEaTZ2UVRxRno4?=
 =?utf-8?B?UEhqRk9SWjBFb1NkM2ttdVdJRk9Gb2FjTnVWc3Y2azlSU2pqTXdQOUwwaWl5?=
 =?utf-8?B?dFFHaC94TGtqU0hwMjl6Ym5BN09rTCtBV21TWTJ6WkFhZzFBSmRoY0lHTm43?=
 =?utf-8?B?SVZpV1owM1hSTFZCcSs4MVNGcEwwMmVtQUhDWjE0K2xuR0FGVkl0Tml1bmFB?=
 =?utf-8?B?NG1MZ3F4enNzeGloZlVGL0xLNE1CMndNbktrQlgwV0syZk5zQis0TVZBMEU3?=
 =?utf-8?B?Y0NiR1dzWXdBUXFlUjM3ZWxTeDFNMjJnMHJnSzhKNk1uS1ZWWVNqa0I1Skx6?=
 =?utf-8?B?OUxpWmozNzk4cGRYSEFWZ2lHc2dOeW9jVndROWtqRitVTGVsNEtCQlhEaHFa?=
 =?utf-8?B?Y3IrYlprdlErK2FLd29VeTRpQVlBY29kSWl4bGR4MUd1OWx4TlRWWWwycFNk?=
 =?utf-8?B?bW1WMjhoVXlLWFkwZXVKUk80WkRuZjRhRmpSM21qd2FGZVJGQWlOZFk2VUl3?=
 =?utf-8?B?NllFTjh2azZqNWtrVVFJUVpzT1hWNEtySmlILzJUS2pWUTFybnM2VUljeXZ0?=
 =?utf-8?B?WnB1YnlXb1ZuN255eDViSFhVRE1wZTZTUGptei9RVklsWUNMbkMyUHFjVGRX?=
 =?utf-8?B?LytDWG1USWh5WWpvN2JObE1MTzdMNndmd2dab05vL3ZBOWdFMFpPTEhsVlhX?=
 =?utf-8?B?bS9OV2ZrMVVKbHVPN3k0VDNVQUMyTEhEMHRuWDJmOWFuaG0wQUk3c0ZMa1dz?=
 =?utf-8?B?dnNLd1JTOWV0TjJkTGtlMGlNalpYd21BUU11QkNxMnlVSjRvU1JCVlRXUUVh?=
 =?utf-8?B?RGNBQkM5SkUzc0tWdkJrTHZxeXZycWpOZ1JYVEtRU3Zza0hIb1FVQktaOE50?=
 =?utf-8?B?WjRLYkUzcnFKdG5MK3UxendZTzlMaXZGOW9iMzRpM3hNME95Y0lkNmh6b2hQ?=
 =?utf-8?Q?UxrIa+KmCuqkI9LGtF0iMrKYG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9e9289-b469-46b5-1219-08dc41b25723
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 10:02:20.5828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nwpg+LWV35DbzBebsv737QnO40DUug1kGd994JINcf1XtZYgHO5tVIUIO+5LKp8LIIHb9Co2ILRpQEpGnxSJYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5640

Jason,


On 3/5/2024 9:31 PM, Jason Gunthorpe wrote:
> On Tue, Mar 05, 2024 at 08:40:08PM +0530, Vasant Hegde wrote:
>> Jason,
>>
>>
>> On 3/5/2024 6:02 AM, Jason Gunthorpe wrote:
>>> On Fri, Feb 09, 2024 at 11:29:23AM +0000, Vasant Hegde wrote:
>>>> Commit eda8c2860ab ("iommu/amd: Enable device ATS/PASID/PRI capabilities
>>>> independently") changed the way it enables device capability while
>>>> attaching devices. I missed to account the attached domain capability.
>>>> Meaning if domain is not capable of handling PASID/PRI (ex: paging
>>>> domain with v1 page table) then enabling device feature is not required.
>>>>
>>>> This patch enables PASID/PRI only if domain is capable of handling SVA.
>>>> Also move pci feature enablement to do_attach() function so that we make
>>>> SVA capability in one place. Finally make PRI enable/disable functions as
>>>> static functions.
>>>
>>>> @@ -2036,6 +2038,7 @@ static int do_attach(struct iommu_dev_data *dev_data,
>>>>  		     struct protection_domain *domain)
>>>>  {
>>>>  	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
>>>> +	struct pci_dev *pdev;
>>>>  	int ret = 0;
>>>>  
>>>>  	/* Update data structures */
>>>> @@ -2050,10 +2053,16 @@ static int do_attach(struct iommu_dev_data *dev_data,
>>>>  	domain->dev_iommu[iommu->index] += 1;
>>>>  	domain->dev_cnt                 += 1;
>>>>  
>>>> +	pdev = dev_is_pci(dev_data->dev) ? to_pci_dev(dev_data->dev) : NULL;
>>>>  	if (pdom_is_sva_capable(domain)) {
>>>>  		ret = init_gcr3_table(dev_data, domain);
>>>>  		if (ret)
>>>>  			return ret;
>>>> +
>>>> +		if (pdev)
>>>> +			pdev_enable_caps(pdev);
>>>
>>> But here we are turning PRI on for an IDENTITY domain and for a v2
>>> domain that doesn't have a PRI handler. This is not technically what
>>> we want to see, the PRI capability at the device should only be turned
>>> on when a PRI handler is available in the SW side. Otherwise PRI
>>> should be off and non-present ATS responses should fail in the device.
>>
>> We are setting up handler right after enabling capability for both IDENTIFY and
>> v2 domain as both can support SVA mode.
> 
> It is enabling PRI when the device can enable PRI but before any
> driver has actually asked for any PRI features. It is technically too
> early.
> 
> It should be enabled when a SVA domain is first attached.
> 

That's true.

That's what I did in one of the iteration (Initially it was in
feature_enable(IOPF), then moved to set_dev_pasid() path and eventually I did it
in attach device path).


> Like we don't want the HW to generate PRI faults from a VM
> deliberately banging on non-translated page table memory. This is a
> pure DOS attack on the hypervisor kernel and should be prevented by
> having PRI turned off.

Currently for passthrough devices we use v1 page table. So its fine for now.
Domain allocation code needs some rework. We will consider this scenario when we
touch that code.


> 
>>> Also, PASID enablement looks like the wrong spot too, it should be
>>> done in the probe_device() callback and stay enabled. The bit is set
>>> if the IOMMU HW can decode the PASID TLP. Ie don't enable it on old
>>> IOMMU HW that can't understand PASID.
>>
>> Our V1 page table is not compatible with PASID. Hence currently its done in
>> attach_device path.
> 
> What does "compatible" mean exactly?
> 
> The PASID cap on the device is only about the IOMMU HW ability to
> properly *parse* PASID, it can fail every PASID tagged TLP and it
> would still be fine to turn it on at the device always.
> 
> v1 is clearly not able to route PASID to different translations, but
> as long as a v1 DTE fails every single PASID tagged TLP you can always
> turn PASID on at the source just fine.
> 
> It would be a very weird design if v2 HW makes the DTE in v1 mode just
> discards the PASID and translates everything with the v1 table. I'd
> also wonder if the identity/blocked cases are similarly weird?

Passthrough is fine. We will set GCR3 and GV bits.

I am still not sure about BLOCKED domain (needs to investigate) as it needs TV
bit to be set to zero.


> 
> IOW, I would expect to see probe_device check if the HW supports V2,
> if it does it knows the HW can parse the PASID in the TLP and will
> abort PASID's without translations (ie v1 DTEs). Then you turn on
> PASID support always. If the HW supports only v1 then assume it
> doesn't know how to parse the PASID and will ignore it and fold all
> PASID requests into the RID. Leave PASID always off.

Ok. I will revisit this later.

-Vasant
