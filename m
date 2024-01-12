Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A1456B97
	for <iommu@lists.linux.dev>; Fri, 12 Jan 2024 09:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FG5VTZqg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fa79vYg63LO+KDnZSUBUp85uZiWqOr0jY9IOjzdWs79LuxatQVMg3Q4Qj2CMS8UmXTiwKWHh78XBJqSIvKmBvO8nmFEvyzRGldppnhdDmvlK6ghsNdqPMZCJ4wA9e7JmXFSX8xL7ewZpDt56kpPX6m1wxQKv3T2Wz5mydDuNGg+G+LnjHWch9XCA+N5zkHjqX25CptlV1qROFn195gNrpG/E9SEdLnA1kyR/35g+kNp+MpCBYneGnJQxaq6axc7pWpAksqXsxqvIUwPlHIJBmCrPjfnHaDcj4z1nPZMhllZSPKVlO/Sld4k22qd/VEOEwgNYYopxjv1VV45jl1csUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbhJeMCeYUJAHw4WpCSu8Cb9+W+io1QT7vyPOMVJmuA=;
 b=OAMuw9QJY2ONZKWtAwNOWpxI+gePljngKUwlRGUUshEsyHwvhayAZ7DqizILg9ADbUrEhzKb4toDNtRBtfUtdM4K+joMlf/mSbEz/YkWMhMsGARZwxQM9Lc69kqGGntlRxsr3E8UtJWaJdWvxigtIvb7YG7daf4dY6i+JR09GN/w2FKEHfBUJi8p4bPx4BtcvfPbxtLcQGHZuCrNDWIepWzKLoCKEP9BdDnLCQWVRa5pTYy6BaXLdMfQtWIUEFMvcbVIBW2kltQyERKaAKvQbcbAiOVYDj1pyVaFBsZLyNAT9lYNZfBvKkCPV74e0pD9RogW2Ow4FoyvnFpRbzzGpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbhJeMCeYUJAHw4WpCSu8Cb9+W+io1QT7vyPOMVJmuA=;
 b=FG5VTZqgrlMsHlQSrGJMC5bcQ1c0vwL75VPgFSVYUCBcqk/KUsby82Vg8hZGz6Y5V/dnpYyXAQ7+vOyMTWpsusGRGGAuPxUH1kpQm0jPY5HCYNAJSJst8Wjl7YgDkNpcl+Npdw0XDwnfnvkWeMDfu48f65BRHgPyYML0Csa6h2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM6PR12MB4299.namprd12.prod.outlook.com (2603:10b6:5:223::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.17; Fri, 12 Jan 2024 09:00:38 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb%2]) with mapi id 15.20.7159.020; Fri, 12 Jan 2024
 09:00:38 +0000
Message-ID: <0fc37c70-b5c4-9765-6b75-7c0c06ef20e9@amd.com>
Date: Fri, 12 Jan 2024 14:30:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 10/16] iommu/amd: Refactor helper function for setting
 / clearing GCR3
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20231212085224.6985-1-vasant.hegde@amd.com>
 <20231212085224.6985-11-vasant.hegde@amd.com>
 <20240105191207.GP50608@ziepe.ca>
 <434bd095-0cbb-8220-66bc-371172a2312f@amd.com>
 <20240111132623.GU50608@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240111132623.GU50608@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0161.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::31) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM6PR12MB4299:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c5df368-ec28-473e-b758-08dc134cf21c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GUHJ07usxaazYuQpwZxYA+PYl853ayJl8uWaO5X9poEHO+GbJ2BhKhO2oc3+5Wmie/+LOrDY6gjtBXhKGYGfCNqebctfchTXdNbIhucpevVcy/44UOZ2RCagbzX4inS7mzIjYyMaLpRD+xtqrz0nFC0d4RRqIXLKG2nJm5jvVkzuHvPdDjRPGXlSp5rVL+7XYf9RI2jxifPhMgdEued/f0Yyjdm+jyDvs33PcrlvbK9C+BG65cd0HnJBprXz8bNRXO29WIs/piGtv0u1Y8WLL8RFQd2f+2CJlYFuq7ZkesIHanri9WcJfAc11yvoyGvfDyQikDSaOGaWin62b0sAKMIP/+IqgdUcYj32AotO4BNG+losn95FfZ0iKU+6mwM1dU5SxAg1vLdy0TpmJQ3F85ld9a8PtI9Gdg7jnT5e6P6F7J6m0SlAYvKwZOkpf8dY7O6/lem4nuXoePa+zS3Rq5gLGbRFykq+HWedI3d4ARpn8wEIZjI812WvXVR630PrBZTJYNn9ubcK28+cdB9UgJTqaumgCzjujILNHE+elw2zIIJAMwuKLjpAc0+B/GqufQZ4khHqd43UtW9AdNukx4N6+RyiW+d+pvD4bYyu+6v5I6iul8c9xMNyIiEK5Q9upx7DDv5u6YKTm+mWAvTymQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(6916009)(478600001)(66476007)(66556008)(316002)(66946007)(6506007)(53546011)(6666004)(26005)(2616005)(4326008)(44832011)(6486002)(2906002)(5660300002)(83380400001)(8936002)(31686004)(6512007)(8676002)(38100700002)(31696002)(41300700001)(36756003)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEgyRCtySnl3ZVlYbnc1aXYxc0RoMjJFbHRLWlp5NEdzMGE4MWoveWpLaE51?=
 =?utf-8?B?Q1I5UnRaT2hCV042QlFUenYvWTY3UU9QcEI0QStxSlBPZ21TeDdnanNxVm1n?=
 =?utf-8?B?U0Z2MzVlT0RtL1NSMG1pbXFWN2g5a0xmRXJJcFZRVHJWR3F4NGdOQXNSVldh?=
 =?utf-8?B?a1VBaFBCS2tVS3pNZTlCRE5WUkpPWXQzdGJaRklHdHBMZ3dGZlRZeEV6UU5E?=
 =?utf-8?B?aDVhdHlsUU5UNmw2QlJKOEF6UUJ3bXRpaWlUcmFTbGtYQ1MyS3VoRTlvcUZI?=
 =?utf-8?B?cHh2RTZCbHFPQ0RuT1A1TUNZZ0I5eFlVNi9VL2lPZTNzOVJTV0R2WCt6VTQy?=
 =?utf-8?B?WFVIQUZWQXBVK0svczZWdjQ2b1FiY1YrazhkR3EwdWlwUmVUQThPUG9aWWxJ?=
 =?utf-8?B?Vm5VNzVXMG9QTXVjTkk4RHY2NUN1VGpVZStMSnRweUNabyt2cVJ4ckF2RHNl?=
 =?utf-8?B?bTFtZFZTM05UME1YdW5QV2gyT2J2L2tOOXZLVFI2TTZoSTMzUEU3THlXODhJ?=
 =?utf-8?B?RUZCaGRsUkh6MG9xZnh3a2E0M1hIZzN6dVMxalJxUzJjbCtmLzRQWDMwOWdM?=
 =?utf-8?B?d3J2NC9keXRmdEs4anhEMUlhRDliYkpZUGJwU0hmSkJ1Rzg5NzJHSzYyWHVw?=
 =?utf-8?B?NFBBT0RuYmdnMjRmMjFtUWVYc0YvZGNBOVFMMWYrZUdVc2phMGJqS0dkbVR2?=
 =?utf-8?B?SDYweDRrWDlrZ0pIU2ppQm4xcS9XekVsM2dnV3FwMUdZVUJFNVVsbnNGcXoz?=
 =?utf-8?B?bUhQRjhjSVlMNWs3TlRFRDNIVTZqdm40eCtOUlkrSDY5Z2ZVOWJIVk1OR09R?=
 =?utf-8?B?Y1I2QVc2Z0hkc3BWYjdUeGgyOVBraENxR2JhcURxNVdMNjRGNEw2VHNpZEd4?=
 =?utf-8?B?R09HWjQ3OUM4SlZxVnFvcU1kYjhwbWNVbG9kY3o3SkVBdk5ZWTVySkNuT2hC?=
 =?utf-8?B?ek5TT3k0Z0pyYWpSZFBpOFZDNXlEdWQ5cmJXVG0wMkt6amlJUGh6bTk3ZXRO?=
 =?utf-8?B?Nk9jcVJtNStzekdLM3RiTkVQYmlDeWxDWFlRcEUyeGhINGZtdENxTnFxUkt1?=
 =?utf-8?B?TGVucUw4cng0WTZ3bkhmWk55aGZJcEVoakVUMjV6Nk0zZXpQWEdLOHJWbVV3?=
 =?utf-8?B?TG1hem5NOTErcm1UVUM3Y3JuVndLYkgvaWdOeFk0MUlKckJrc2FJN2pFZTBN?=
 =?utf-8?B?WE82N2FLbUlibkZIZWtXK05ocmtyTjBmWjMyMDdxTTUvMGxTRHN2MlhXQ1k5?=
 =?utf-8?B?VFBxd0tUQlI3Vy9uN25DM2RSYkx4c0FPZTNEQWJZcEVKQmRpdFpXeTNhaGlD?=
 =?utf-8?B?dzB2aWhWUmVqcTFFMmkwVmZ6R1hMK3c1L29idlNybUc4eEJKUlpxWktXTzVD?=
 =?utf-8?B?alAvcGFFSkVKaVFPTzlXZ0R3TWhXTVlNZmhyc1U4KzVCbytxMGh4ZnBSQkxJ?=
 =?utf-8?B?di9mRzQxckFvTG9rbk9pa0pTVXZ0bUkyLzZZaHFVSkI1ak93TnJLMGdoUTVn?=
 =?utf-8?B?ckRTZ1MraGRlSmZaWWJvTnB0cXBWaU9ZK2J5cXFJcDN4alBiTnk2NVo4Qkd3?=
 =?utf-8?B?eWZGRjAzU3hlNFpoSEY3MU9kbWtVbUFEbzdqSGRkTHdEM3Q1NTBDaTdNaGFZ?=
 =?utf-8?B?bkxnQ0lUQmtHaTlUN3E0RnEwaW42TWowWUtXZG1UOVpaMitaOW9PQjZXN3NR?=
 =?utf-8?B?cmJPcmozZ0ppYTQzSm9NbzdqZWhzSU44a0d4TVk5NERodTFKbHl1T3RTTVl0?=
 =?utf-8?B?VklYSTZPSnRhdE1MT2J4d1RyOXdteHAwak1EODVoVG5yWTRtVTI3Z1EraG82?=
 =?utf-8?B?VmE2RGlwRXBDSkxyb2FacStXbDk4ejU1WGtZbStFejhsbWhYdk1tQXdPek9l?=
 =?utf-8?B?dk9WZEwxamdJc1N2c2ZPNXp0aVV5bTZpVEZEWStJajR3cnVqVEJ5Ykd3ZjZB?=
 =?utf-8?B?eStSYVdUMlFUQWxQTzhETVNvOVYyU3ZjenNmL05ZeEZMY0RLQ3RMTnMyOXh4?=
 =?utf-8?B?MXlZZHk2ak1kMVh2YlJUUjlEZ3QzMGxSRG8wRkF6eVdLZ2MrblZYTExHY2Ni?=
 =?utf-8?B?ZUNWWGtjc2VydURGdkR4UUlSWjRsZTVBVHpyWU93blpDVFE3VllZbGFJWEk3?=
 =?utf-8?Q?F+vSPPBQiD7e6qR5jIZ27JHfr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5df368-ec28-473e-b758-08dc134cf21c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 09:00:38.3461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PWL1KL+6Xm5+HXDwuStF5IqvP1wGoGA7yD7/ncqVH8ws2N83iC3mroF81+zSd17NLriZaMeEFg7zqOvcQE8teA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4299

Jason,


On 1/11/2024 6:56 PM, Jason Gunthorpe wrote:
> On Thu, Jan 11, 2024 at 05:22:02PM +0530, Vasant Hegde wrote:
>>
>>
>> On 1/6/2024 12:42 AM, Jason Gunthorpe wrote:
>>> On Tue, Dec 12, 2023 at 08:52:18AM +0000, Vasant Hegde wrote:
>>>> +static int __set_gcr3(struct iommu_dev_data *dev_data,
>>>> +		      ioasid_t pasid, unsigned long gcr3)
>>>> +{
>>>
>>> IMHO you've got the ATS layering wrong here.. The ATS invalidation
>>> should be pushed out by attach/detach functions and has to be
>>> carefully sequenced with the ATS disable bit in the PCI control
>>> register. I don't think you can do all of this right with things
>>> organized like this. Indeed this looks like it over invalidates the
>>> ATS quite a bit.
>>
>> Currently if device is capable of ATS we just enable it. Then we invalidate
>> while setting/clearing GCR3. This is extra invalidation if we always clear the
>> PASID before using it (as clear path would have invalidated IOTLB).
> 
> It is simpler if ATS can just be left on, but I'm not sure you can
> actually do that when you get to nesting.
> 
> The guest and the hypervisor need to agree on the ATS state, if the
> guest thinks ATS is off then the guest will not generate ATC
> invalidations, which means the physical ATS has to be off too.
> 
> Thus all this needs to be carefully sequenced to be dynamic, and this
> doesn't look layered well for that.

Yeah. That's another complicated stuff. We will look into it later.


> 
>>> You should only need to invalidate prior to doing the enable and when
>>> a GCR3 value is changed while ATS is turned on, which is something
>>> that the attach op can caculate.
>>>
>>> So, these functions should have a signature of:
>>>
>>> (struct amd_iommu *iommu, struct struct gcr3_tbl_info *gcr3_info, ...)
>>
>> Not sure I understood this. This path is adding PASID to devices GCR3 table.
>> Hence I pass device_data. It will set GCR[PASID] and invalidates TLB (Because
>> its per device things, we can get the iommu details from dev_data itself).
> 
> I think it is wrong layering to make the GCR3 table linked to the
> device, it should be an object indepdent of the device. Any place you
> are passing a device into a gcr3 layer function looks suspect to me.
> 
> This is why I said you should put the domain_id in the gcr3 table,
> because that is the proper layers for the objects and data.
> 
>>> [and the locking can implicitly rely on the core's group lock, don't
>>> need more locks]
>>
>> I was waiting for group->mutex to export so that I can add lockdep_asset with
>> that and remove device lock here. May be I can just remove it and expand the
>> description.
> 
> If you want to use it just add a 'iommu_group_mutex_assert(dev)'. It
> is a couple of lines

Done. I have added a patch to export group mutex from core layer and dropped
dev_data lock.

> 
>>>> +static int __clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
>>>> +{
>>>> +	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
>>>> +	u64 *pte;
>>>> +
>>>> +	lockdep_assert_held(&dev_data->lock);
>>>> +
>>>> +	pte = __get_gcr3_pte(gcr3_info, pasid, false);
>>>> +	if (pte == NULL)
>>>> +		return -EINVAL;
>>>> +
>>>> +	*pte = 0;
>>>> +	amd_iommu_dev_flush_pasid_all(dev_data, pasid);
>>>> +
>>>> +	return 0;
>>>> +}
>>>
>>> What is the point of clear? By the time the attach ops will want to do
>>> clear it is already certain that a non-zero value was installed in
>>> pasid, and this doesn't free any memory, so what is the point of
>>> 'alloc=false'?
>>
>> This will fetch GCR3[PASID] and clears it.
>>
>> We use same __get_gcr3_pte() in set/clear path. Hence alloc=false is passed.
> 
> Just call set with 0 - again there is no point in having alloc=false
> since this isn't called in any case where we don't already know the
> that the entry was already allocated.

I will replace set/clear function with update_gcr3 for now.

> 
> Also, most likely this eventally needs splitting up like SMMU did so
> that allocating memory to get an entry pointer is separate from
> setting that entry pointer as a driver should strive for "fail means
> no change" implemenation of their domain attach function.
> 

That needs some more rework in attach device path as well. We will look into it
later.

-Vasant
