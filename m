Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2062.outbound.protection.outlook.com [40.107.95.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7616B8664C
	for <iommu@lists.linux.dev>; Tue,  5 Mar 2024 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709651425; cv=fail; b=amuz+eo9I6GmXuyKY7Som9a4hXqFjgIfYX/N10vx7dF/+H1poPrAQ+4uX4yE7xUauztzCwPhQN6hsewKjtXBBsCKRp+2S9xp34PbGr+RWdfFsOGVzP688iL/SxX8ANrkRsikD7NrCzssDyyHMNVGBMfC3QuYfAMqr3JhYC6ylyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709651425; c=relaxed/simple;
	bh=i2ERTJnixhEG00MWgBSwCOMcxrhOqgEQHA8TiQB5wvs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JAFmntd2idY7AoPzQ5qos9hhIyPyfOQG4lKtJOYAOhe2aVsJjx9OYBNFY/r5qHknLbJT4M8QW6r99kMwOBxpbZyDSqL5WEYdzn0TA3Q1nUG7MXh1Cb2CICHd+VeY9Wq4liE2gQws2RtDkDrKtL39BoAj9gcAHLUmtVk2jUcZrb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oE1yZqTz; arc=fail smtp.client-ip=40.107.95.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oE1yZqTz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDmBzQpXO4twnDeTyr13NBZwQkImAV8QxUVWE9UwR20b64bO6Q9JgtHksrz3bphGByXReITmXmggmF8PZx8vEDo5G6qXhLL/jVBWB/4GBYL7GaptkT1y+wBBnuE8KbDoFvuT5z06YDm6WAkkTe3X5sT9E2VXXqUhzDCID5KEpTWH8a2yriogA+4wiGZlp0Lqf98t5pYXoHtB8P8N6YZeyoVDH5FWvAGgW+Sp9tpY7e75CnH+F1QjS5PrG6XRaplV6YAohYvADv0iIhEf/yQZRGdZiVqaLO4j0cSvHz64Wf2mK4J0zon0gfNKV27Dfx939uVo7mp+T7yYf21szr1ZRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrvoG6XJG9GvrrjFYc0w7yB9sE3S2LVuRgP2ucUWKVE=;
 b=eO0ptMnadTJOYqoLy7t19fJtkO6R4KL2lInqbaMMjRYZ6Os0DTotyJGiJIz+iLzB37xTjatKGRQqs1rQkMF621YGqvfOgtM+J15ohRPv3m4oH5lRY7egp0bIcdN10MrUuUW938yEorjSHFFrQhBXsnD7VmX/f+CfeyZjlav9iXC1iHYiDubrN8/6N2AxJq19M4T5TxOCdT87AiUug3sfEsyWBzYV0RuPZkbAHH4mYih9bSpjQ3/qHblLyq8WisDLZVcw7ziocBs+CeuhQOqGsLnkF7ZbSVs3jeblwLifNqdEog5YqLTyBe84wO4XOZkKphNzqlUR5ul/75x+uxVYNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrvoG6XJG9GvrrjFYc0w7yB9sE3S2LVuRgP2ucUWKVE=;
 b=oE1yZqTzrjIwH4d0/6vMAj3k/rBhYEq5Ko5Sd+QuF+ujVyF4AlwxGpMEV4qdDSeMVT2erE1s5vuL3g2egDlt1VcTBTMohIriBoHh7v9QUqIork3PBnWJzeHlJqAQcYNEQrLFAchtfhrsPywjqF37AiFuSpn2WLOlEW0i5npGFWg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SA1PR12MB7342.namprd12.prod.outlook.com (2603:10b6:806:2b3::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.24; Tue, 5 Mar 2024 15:10:16 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::d709:cb7d:2612:bb27]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::d709:cb7d:2612:bb27%5]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 15:10:16 +0000
Message-ID: <87abadb2-aa08-3a79-e1a2-4031b2c7e791@amd.com>
Date: Tue, 5 Mar 2024 20:40:08 +0530
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
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240305003219.GC9225@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::20) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SA1PR12MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: 253993e0-86ae-482a-4dc4-08dc3d265d3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LuDKIvzUIiDkdpu3xmPMKHkTwuNfEBCod7EtY6UHdeJoLMl5ReOJCkOfZgzz5MGZr4a+l00k5fJERTij5Y2czdRISueinGyLWKSw08rt00+bhbeohLpOXQGc43C8SayTbfF1ClkuvpyISIV9HQOJY5vQUUgXzvCTYHQvkGPVBc9KhJjqDT7FaoHJIdLAMukQeqojVttmvGFIOl4EjQf4WyETAtEOXDbDfTOx7JcnPi6ujfoBWX9Pdp9d4cnrax6wEOuWnQhF4kIbFjCccid8S/Hqg9hGpSs5wbtEb2pHqOdgCASM6pjaaUSw4WlrSzDyCSYfag2fQzUbXkLbZR+Br8IoKUH7d1h5zhVHhX7Ip+VO+KCsXLIATeuMkYhMtdMqbDgad8jvyS/Og2nesNFsjFBmx0Qo+NxRTOEK2pG2geukwmF8k2Qw/54uW9BSSWy8/N9EUmQzihFPJC4KxCiq1Y+NFsF6b4pO6zAqcktQhyoDESeDMCY/w1rWBG8TB+nWEIj7fCWHXZNq1aocShV2MahzFjfCB9Ydl+FpWnKQH+tYhIm1DpGRtIoCabHWecat632QXdyZnimJ8p/tUpEbnqIjV+63ngPYfbYbUt42XNjxtxT+NMJGh5jkI4nMwBwYxEvO8iGT2RtlPaocdmpYyJGRxIpHtairrPY8MO3+TdI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nk4vbXZ6N0tqRzcxMm5tdVNjRXJrbkZmWnRYTTRyL3M1Y2RtSy9YWDdxdmNL?=
 =?utf-8?B?RDBZQmhncWQzTWkvTEtMWHRWY1NncWVZU2d1bW41SkNzRDRnOWYzZ0dOZHBu?=
 =?utf-8?B?K2lKcXRIekNZUTdJOEFVUjFJZ2U5SUV3YzdUNy9SY21DNy9CSmllTkxKTUVq?=
 =?utf-8?B?MFhBTzhRU0MyNGU5aWlxU3E2cUk3dUw0cFphZFJhZk1qd21rTWVtcjhQY2NF?=
 =?utf-8?B?YitIdWpCMWdBY0FORzl2eUdValgwZ0M3UjFFUURqYXBCZGc0cVZYZXVKZ1VD?=
 =?utf-8?B?TE92R2Q0NjNOckJEckpodExCYkR2Ky9EaVdHTW0yMHRrbzVqMHNBTUtZWTNY?=
 =?utf-8?B?cW9aN2gvN2F0M1gwY2JFdWo3cDVMMU9iWVBLVFRyTVRoWDBzSkN4ZlpnN3l5?=
 =?utf-8?B?M2pBRUNBK3J5NE9MQTRyVzVNR3I2ejR0eEVjeWtvS3AvUE5KRXZEUi9rR3dS?=
 =?utf-8?B?VlBySzhGSXF6WHlOODQvU2l1L0owMzg2YUh3N2dLWk9SMzdxNUhnWDk3RDZY?=
 =?utf-8?B?emUwanhjZEF1UzBXNUwxYnFpUlNrV1ZPSjZxVlBnelk1aFpWL0NVdTliSmds?=
 =?utf-8?B?L3lnRVhHS3ptWVpzSGRuY0F6SUJ0azVxQXFBMjluTml6aWpnRnFzeDA0dnBu?=
 =?utf-8?B?bWVKR1c5MXRCV3VlRUJUeGFpc3BlZlFtQ1BSQ1BUbForY0V5bVNkWklCL2xK?=
 =?utf-8?B?cFAxWU9reUZORUt0bE5yZngwRUJ5VEI4N2dhRktGNnF0T1AvcTBTeVptZWlq?=
 =?utf-8?B?TFlTSnVnc2hZb2FGUDBsd2xVaUQrRTdMY01DMEx1bVo1OGxvVVB1WFUzbnYx?=
 =?utf-8?B?RWNwb3BxSEF1WDdtQmUvbVdicnMrc1ZOM1BrZU9Nd2YvK0Y4emNaUjBmS29T?=
 =?utf-8?B?YTcvRVFZRE4vMkRmeWQrdWNYNnFpb3krSUpVSFBMR1hNZVVXVTZGWGlUQXZK?=
 =?utf-8?B?aEFiNzU0ME1MK0JiM3g2R1M1Mmx3QTZadUh1ZHRGUENpMXdXa1phVmRFcDBw?=
 =?utf-8?B?ZFFGMGFlYTJ4UldZOUpyNHBRbVBZQm9pblBta1pldFEwU2ZLbncrR0I2ZlY2?=
 =?utf-8?B?OENzRGlkbkZreFhTcldQUVJSQnovZXlha3JsdU9DN2RrZzc0eFBaZzd2MkVo?=
 =?utf-8?B?QlEzYkdCejdMMk1pbmR6eXlDNGMvN1VhYWNiRDcwTzMwSWlRZ0dQeFd1N0Z6?=
 =?utf-8?B?R1I2MjV1TzdQWExjNjVud1hqaW5tdHVOTWhMWEtOWGhENE9nMURpakFETFZN?=
 =?utf-8?B?dGRvYUxaem1qdmNocTNoVEVEL2pBc3BXc2U4bDVHUkNNL3oxTnA2ZzVOVHh0?=
 =?utf-8?B?a1VYUFUvK3pFcUFNSXgzUTVrVzJwTm03OGVtZm56cERKb3VtR0RDOUpuNlRO?=
 =?utf-8?B?c3dtZWJaY3hEbGkyY21CRytLUGRjT3o3RXRmRHNRdmc3SGRiU2d5U3hPamc2?=
 =?utf-8?B?WUNvNmRJQ3NhZEpMdDJXUy9BS3JuLzdLbXF0cnpYV0k2aFRnNzJHNDhYbDJx?=
 =?utf-8?B?L1Z6MGV5a2xWNFArbWZWNEl0TFFVR0t4eHNyaHZzcFNUZDYrL2RyOUxqV1pl?=
 =?utf-8?B?N0dGZnU3R0FiYzZOYi9MdnRYNFEzTlU1RXVlam5BUy9zc3lPRUp6a0w1V0FL?=
 =?utf-8?B?RS93S0daRThYT1Q5SHpxRHZGMjRjNlFNckRyc3ltQW82OStVNGJKL2tnT1RS?=
 =?utf-8?B?QjdsdHNjTFpVcE9GcmlBS1RzeExMb1VNeC9HcDQzdGhJd1ZiY1I2QjZoQmQ2?=
 =?utf-8?B?RmE1dVFJYi83V1U1RXBHQStNdFhuYitOS21DNXJnOWhLcFhwaFVHNmZtUEZt?=
 =?utf-8?B?OTJHWGgrTEppSW16SWUwOFptd2l5ZXNZM0tNVGw5Q0VHSmlPQ2VOTVUvYzJR?=
 =?utf-8?B?VDFGQzdpVnlZbi93OVV0UEErM0ZOeHdJMDNCem9tZ2NjN3RHUFVxb1JidnNH?=
 =?utf-8?B?K0NjVW92UmhPbVFvQmQ3eW9mcDY2TDMxbWxYQ09uQW9lYXZyZHNaWVIwN3d6?=
 =?utf-8?B?M0ZZMUhaZTYrR1ZjY0ZsZ3Azeis1Ym5jcFRtYzNFUmU4WDBjRHFqalRtYTli?=
 =?utf-8?B?SElpQnV3bklXcUF6czB0SkFJNnhCNG5pZUdpa2pXb29jZk9oSHhLK1RodlFZ?=
 =?utf-8?Q?KuHtOo0bwcHsCFTsYVzW7Uw4F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 253993e0-86ae-482a-4dc4-08dc3d265d3e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 15:10:16.5965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DHrf5ulEQoPZTOIBZFHxjRzfg2Ys0Y+OugZRuzjwlYHRUNHIy3/5/Mqg9LaY+DMcwLa43/Ik09LPuFLMFsM6iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7342

Jason,


On 3/5/2024 6:02 AM, Jason Gunthorpe wrote:
> On Fri, Feb 09, 2024 at 11:29:23AM +0000, Vasant Hegde wrote:
>> Commit eda8c2860ab ("iommu/amd: Enable device ATS/PASID/PRI capabilities
>> independently") changed the way it enables device capability while
>> attaching devices. I missed to account the attached domain capability.
>> Meaning if domain is not capable of handling PASID/PRI (ex: paging
>> domain with v1 page table) then enabling device feature is not required.
>>
>> This patch enables PASID/PRI only if domain is capable of handling SVA.
>> Also move pci feature enablement to do_attach() function so that we make
>> SVA capability in one place. Finally make PRI enable/disable functions as
>> static functions.
> 
>> @@ -2036,6 +2038,7 @@ static int do_attach(struct iommu_dev_data *dev_data,
>>  		     struct protection_domain *domain)
>>  {
>>  	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
>> +	struct pci_dev *pdev;
>>  	int ret = 0;
>>  
>>  	/* Update data structures */
>> @@ -2050,10 +2053,16 @@ static int do_attach(struct iommu_dev_data *dev_data,
>>  	domain->dev_iommu[iommu->index] += 1;
>>  	domain->dev_cnt                 += 1;
>>  
>> +	pdev = dev_is_pci(dev_data->dev) ? to_pci_dev(dev_data->dev) : NULL;
>>  	if (pdom_is_sva_capable(domain)) {
>>  		ret = init_gcr3_table(dev_data, domain);
>>  		if (ret)
>>  			return ret;
>> +
>> +		if (pdev)
>> +			pdev_enable_caps(pdev);
> 
> But here we are turning PRI on for an IDENTITY domain and for a v2
> domain that doesn't have a PRI handler. This is not technically what
> we want to see, the PRI capability at the device should only be turned
> on when a PRI handler is available in the SW side. Otherwise PRI
> should be off and non-present ATS responses should fail in the device.

We are setting up handler right after enabling capability for both IDENTIFY and
v2 domain as both can support SVA mode.

> 
> ATS is not like that, ATS should be enabled whenever the system iommu
> can support it. For AMD I guess that is always?

Yes. If device supports ATS then its enabled always.


> 
> Also, PASID enablement looks like the wrong spot too, it should be
> done in the probe_device() callback and stay enabled. The bit is set
> if the IOMMU HW can decode the PASID TLP. Ie don't enable it on old
> IOMMU HW that can't understand PASID.

Our V1 page table is not compatible with PASID. Hence currently its done in
attach_device path.

> 
> However all of this is basically pre-existing problems at this point
> and this patch is improving things as they are so

Correct. I will revisit some of these code paths later.

-Vasant

> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Jason
