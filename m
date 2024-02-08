Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3281B7F4
	for <iommu@lists.linux.dev>; Thu,  8 Feb 2024 18:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707417449; cv=fail; b=uNUWKaEuAZHjmZHk5CaDPEK6jQo9u2GlBlHAWhoVH7cUYIqIwSTmNsSpd/E81qnxawOOUpyXkKbf5JyVZVUbK3SP2m1mfgbETU318fFnE+AEsAB2C6nJrQE4B374+PFhbdnCjHkqnAvy6iyyyKPWqANbWchSXBYfzaYsXVdjMTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707417449; c=relaxed/simple;
	bh=SuvB+a4Hh02yyI/OIF0GyULryDqdfa/0j5GuyS7hFFw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dqrQYg8ed3UNzBCdgpJtdGnKQSBv83kGCL7n5ols2IKvXiHTc3vQ5YBzExpAClQzV7SABZHQ1QT6oD/SCGxLdTC6Y42w1NRKghnCfKC0/rPHSnOIrQAITj/Ywt7b8ilttpmIWTXKkqw6GYwP5HEBRDeIJ0WqAT5wYtoVSCVuFNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wnuFbYdU; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wnuFbYdU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rxq3vVlgIOniNQuBW6b675UiwVkXTD99/DCqn7JQC5p6X1Uiu5sJWeUmAXFpb2rUL5eGVC1lxMdcBqMSdaLjLcVgTl9yA7h57KSjM/6/+4zyxRJBxzENuBtxjgZzATC91G0TEhnASVvhJ9dlirJK8QnjpIpAkHGAOjOORLfkIA7vc1bv0W4cxD0tz/knnYa0PaDI4WuYJRA64IYiXUGUh/wxFG15FQIuzJ809Ae+o2Fxz46DR8n//EMQWzVNzlK17DjpNSCz4mJoSckwM7BsWs4NQiVAQGA5CJMYldRjnul+jIoEiffRtVWHDaJN2311ey1EtLU7hs9B+S6YTdwUyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47pfTrlYH3dLtqpCPVgJILh8ZeOgR3jOunTYvLIlTGY=;
 b=NZHhYt4VKvbADjWIsz7nZeX7Own3HO5dVUhGuUXhgm1kVvEZ4G+NYGsOMoc+9iu8nq+Jgg14k2ydBKlI3FPycEJfPgGh18acNRQLZR3vwWUPcTBHfyJah75kFDGBAr5x6pwBCPY6fspYWlwzAmMXz8AdaIwdh6oiGmEy5zgv8mgYf5KSbT0VrMBr5NrVXfAF0HPVa5FNc08SsprEIS45rnT2MhdIMqZk/zWOU1mKkrNVcMjNx4L5qwIdh4bZY8pconPIscAw44ukdHCQpuVsXFLvzAk3vyCXC6/jULzxKkZI7tlUMyFyafZ7uxST2lenWGy1w6UyI3027XuwAJQIQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47pfTrlYH3dLtqpCPVgJILh8ZeOgR3jOunTYvLIlTGY=;
 b=wnuFbYdUNdrkUvcAaMSoze7yIgorgcBBsbMwMygUG+nLJiPZ7wRFmOfWK2nqBkX89coo8gTqgGvbecMFz+JH5dpOARgAbyjpSLP6O9sfHmJB0/VcruJPwNEG+ZWGFCFDEBK6i+xw170G3POiFQ54sUffZKMg3zz9FKycwRILh+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA1PR12MB6140.namprd12.prod.outlook.com (2603:10b6:208:3e8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Thu, 8 Feb
 2024 18:37:24 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb%2]) with mapi id 15.20.7270.012; Thu, 8 Feb 2024
 18:37:24 +0000
Message-ID: <beee7947-9c1a-95b6-66d7-88e130fd2956@amd.com>
Date: Fri, 9 Feb 2024 00:07:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 10/14] iommu/amd: Introduce logic to enable/disable
 IOPF
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20240118073339.6978-1-vasant.hegde@amd.com>
 <20240118073339.6978-11-vasant.hegde@amd.com>
 <20240201214949.GT50608@ziepe.ca>
 <9d3579c7-66c3-3752-bad8-a8a8ebc5c74c@amd.com>
 <20240206163657.GG31743@ziepe.ca>
 <873201d4-57d1-e856-87c8-08e2ca71f0a2@amd.com>
 <20240206175824.GI31743@ziepe.ca>
 <0d626c74-aba5-bbb1-5fb4-b9be5577d71f@amd.com>
 <20240208173158.GV31743@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240208173158.GV31743@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0001.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::11) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA1PR12MB6140:EE_
X-MS-Office365-Filtering-Correlation-Id: cadc71ef-bd90-41bd-8451-08dc28d4fde6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dRS6D1ElX5btR0PMG48k4Db9LhB0hqGQiRN8Lx8XBEuR1xrLFx4DkNd0uJKuOgDCYTXEFTo4+mqGUftK/5DxvpEtEArVuv6UP20zkNHC2VPn4JUODNvUt3GxUrWiHLxLFzpHSIClMxbs91ctJMfea3Mi6OUXiOSu9CFdof8eVY03ArzyFbq0YVScw4srCDkq3NP8CHqgM2bHMnlRpoptkbotPM7PCE/bf1Jg2MIk0tJVHz14IYb3LoPLI2EqrzOikUWcgjtpJ/7E/sn1HjZ2KHrekmYQJP/dA4Vzaj6LA89uoL1yZa14vEczyPjAbrHpsc1BAhdxbZV7z7jDjPib5eQ5rZ+1HMFMoJuDOmvOCP82ZPwYKfxOqsLqEurL3CzT/pbD804T1ZanJFtQyAvVU22xpwGKq+1TAbfpEUjtR9RCLkFzOxIIlJ7x2CuR+X3jYMpG1oF3c+6twUr0GEC3oNvBKet7MjDGOGw5OvDU5KnWUOumWorKhBwqD7b9O+8fMdFzVxKkASnvRMDu4YONi21D+Tg3YPIz0Rgu4wQy+SSj+pD1YZlDiPuWfUqiY3NZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(136003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6512007)(316002)(83380400001)(5660300002)(6916009)(31686004)(2616005)(66946007)(31696002)(6486002)(6506007)(6666004)(53546011)(26005)(478600001)(2906002)(4326008)(44832011)(8676002)(66556008)(86362001)(36756003)(8936002)(38100700002)(66476007)(66899024)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3Q1UVJ4SHZNVVBYcmhpTEVEMlg2N0tjV0QySVdTbWJaL1U2OXk0KzYwNGg1?=
 =?utf-8?B?WHM3R1J2dm1HUFd2Q085dmFwQmZLMTEzWEhoWlBYZVRJRlJzS0VENGJrSElB?=
 =?utf-8?B?a0ZBUHpXdm9tVkx2RlFES0IyV2pLWFNVbTFlZGxYelo4eDVTU2RRQmtlV0lF?=
 =?utf-8?B?S2NURFM1Qm5OOWJaWURIL1VKenRuSGhGTUNDT1hwL3VtVFh5SnlPMjdmNG02?=
 =?utf-8?B?RjJSZkVHT1pNV1JnTmd4YnlrY0NjeUc2WXh1Tk5BQWFSb0dTMVNYR1ovNFdK?=
 =?utf-8?B?bFA4UXhrYUpwek0rcFdKUnJ5aGFxaTJXZ21GQmgxeCsyU1hzaVJaWjduZUZM?=
 =?utf-8?B?azdlOXliMzl2UWdxd2l2K1p5cmpqdlh2T1o5RmZMZmFpRHJTWXIwNmdVVFFj?=
 =?utf-8?B?TGc2d0R4eWtPUDVwWllEbTVOTFhQVkYveWVSeVBXa1RqMHlYY1ZtOTd0WllZ?=
 =?utf-8?B?c0F2TzlJU3dYejZlcVd5TThqeWE5NWl0TlRKa0IranJyY1FKVXVGYUozZXdV?=
 =?utf-8?B?OUswTWd3eXZWVnMwSy92RnU2MjRXZlFnY1ZjdzU5TWxLeERHVDU1dFcxNW9R?=
 =?utf-8?B?aVpvbnFTclBEZjlZeDc5TDNaUU9qWmZoY2VYbGV0ZTFnaDIyVHh2Z29IejQ0?=
 =?utf-8?B?UGUrTTNRR2hYMjNsTThxUnRXUXhwWTFhd1lldEdsR1BhT2ZFRTJyYTNaNFQ5?=
 =?utf-8?B?Vm9zbWIvVkVzZzUxY3UxTHFSaFVqakl1RnhCTEh5OG1GM09PN2hsd0dpQ0xi?=
 =?utf-8?B?b1dCekxuTTZ2OEJ3S0VESjQyU1hZTVdDTWU3V1VBNFdLaVEvRmgwRG40R2d6?=
 =?utf-8?B?dEZ6VDFueWVBSWI1UzJER3JlTURTNUkxVEVNbGlIYTZrNVhiZkhmT3N4MHhj?=
 =?utf-8?B?eXg3NVJuMllFTk5vMVZaK2dyS0FtRFAwVTl1eTdQdlVXYllIVUxPeG9zaGRQ?=
 =?utf-8?B?SHVOUXhLNlpvUmpuWnhTc2pEdXpvb2F6ZTRkQjRkZE9iL2xwajJPVTZTS0tU?=
 =?utf-8?B?c1B0YmhoZEhEWXR4dkxGWGxTTmIxL2FVRXd4dmFtckVWV3dWbnVyUW9FRjZQ?=
 =?utf-8?B?S1VDYzBtd01vRkF5M1ljOGZISjRsZ2huZForWkNFMklSTEljdVhxcElSL3ox?=
 =?utf-8?B?ZWxMd21XVXBEang5Wno0TUI2UTByanNud0QzQ1hySEd4UXNMZElkNUx4T0VU?=
 =?utf-8?B?Vzg0bWpURnBscUVRWUR3SmZjY0sxOVdEK2pPdnhoQXRpOGs4MHdqanZVQ2h3?=
 =?utf-8?B?MnViU1UyeFVpUjFHRi85d2JNVTJOT0JycnRNbWhnM2tNNkUycFNCRytvY2JZ?=
 =?utf-8?B?T0FUVE9QYXBmcUx2VzEzSURTUUhXbFBnMmk2ZjNDZnV2eTlhWDIvZHM2dzgw?=
 =?utf-8?B?MjIxSCt5bzlkNDhZUFV2azV4RzhyOEpLTHQzMGJXcnBzQnBiZy95UkJNMlNG?=
 =?utf-8?B?dmVJRlF0K3l1NmthalhGNDg2a1FhS2FBcXlmNTN6NVdYbXd5RlZEcFFBKzhp?=
 =?utf-8?B?aTZOelF0S3VSZmd5SzJ1cU5PR0hGNXQrOG1ENGZmQ2lxcXR5c2NsZVhvWU5n?=
 =?utf-8?B?TVl0VVFoYXpXdjlndmxEVnVYK1BleEJtbURsQURaaEIrY2lVc2dvMXc0MXZN?=
 =?utf-8?B?cU51U0dwR0JhUy9zKy9vYjBGaVFjWTJEUjVqUm9TMlhjeVQvUUVwbE13MThE?=
 =?utf-8?B?NjVoSmJncXYyMzhXZnE2UGF0bk9kUUU1TStOci9MWDJiY3FKR25LQ1l3Zk5B?=
 =?utf-8?B?bzhaSkgzR1gvMmp6UlFzUEg1eTBvNEJJUFpndy9yYVhoNThvd3hadDNlMC9x?=
 =?utf-8?B?Z1VqOWtuemlBR3FDNWZkN0dBWlZYU0hTMHZkNUZXSStTSEJQYmxwZzY2UjRV?=
 =?utf-8?B?cWUrZjRjS05ZK3pVRkxscDROY21pa3I4b09rSzBpY3JybG1HZElRdnNaUVYv?=
 =?utf-8?B?RHhSWVJoaG9SeitKeFRqTnZseDVKcGdMUXJpV0NaRlFtZXNhZmhiUzA1dlBF?=
 =?utf-8?B?ZW1YL1VQQ2RtbElNRHNZUkpxSDA2ODNPTzBZaEZZc3phby9hMGs2MWlGOElm?=
 =?utf-8?B?Q0c2RGFSQ1V2VjN1aStzME9hcGZtRncrZGpqcFlzek9lZTB0WnU5eUovbmph?=
 =?utf-8?Q?Ae0H108Lk8MT2VDIVrCqLsk+a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cadc71ef-bd90-41bd-8451-08dc28d4fde6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 18:37:24.1071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ejrnKmdxESeuZr7es8ZGcPsA2UfMxyZkk01hdgcFRLp59EuE6X/FdLGSNR1USUAu4QAn5x9sTCgbdBw5SPYunQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6140

Jason,


On 2/8/2024 11:01 PM, Jason Gunthorpe wrote:
> On Wed, Feb 07, 2024 at 02:28:08PM +0530, Vasant Hegde wrote:
> 
>>> You already know what is going to happen at the very start of attach,
>>> you don't need to "enable it after" just do it right the first time
>>> through.
>>
>> First time we will not know whether device will actually use fault handler or
>> not. All we will know is whether IOMMU and device is capable of PRI or not.
> 
> I don't understand this, you should know all of this before you get to
> setting the DTE. What is missing?

In attach path we will know the device capabilities (like PRI) but we will not
know whether device is going to use it or not. Its like device has capability,
let us enable it without assuming device may use it.

IMO enable_feature() was better place as device had a control and we would have
enabled only when its needed.

Anyway for now I have moved device PRI and IOPF handler to attach device path.
Will try to post it soon.

> 
>>> The situation where attach fails and leaves the HW in an unknown state
>>> is really hard to deal with - and without the reliable global blocked
>>> domain the core code can't 100% rescue it either.
>>
>> If attach fails we throw error message and skip updating DTE. I believe core
>> layer understands that driver failed to attach device and puts device/group to
>> its original domain. So things should work fine.
> 
> It is not just the DTE, the whole thing including changing PCIE config
> space and so forth has to be kept correct.
> 
>>> This also means, broadly, you can't allow the DTE to evolve during the
>>> operation of attach/detach as the in-between states may become
>>> userspace visible and may be harmful in some way.
>>
>> We make DTE changes in set_dte() function only (except dirty bit change that
>> will be consolidated).
> 
> Sure, but set_dte doesn't take care to sequence the update.
> 
>>>>> security issue is solved. Especially if the more stuff is drifting
>>>>> further from being correct. If you can keep the updates in set_dte
>>>>> then maybe with some reluctance. But not like this with random touches
>>>>> to the DTE all over the place.
>>>>
>>>> Currently all DTE update is happening inside set_dte only (dirty bit enable is
>>>> an exception that may need to moved inside set_dte). This patch just invokes
>>>> that set_dte and invalidates cache.
>>>
>>> So then why all this strangeness?? Just set dev_data->ppr earlier in
>>> attach and order the handler setup properly.
>>>
>>> It should be really simple:
>>>
>>>  // All protected by the core's group mutex
>>>
>>>  if (domain->needs_pri)  {
>>>      dev_data->ppr = true;
>>>      if (!dev_data->num_pri_domains)
>>
>> What is PRI domain?
> 
> Right now it is only a SVA domain, it is a domain that wishes to use
> PRI. Quite soon we are going to expand this to PAGING domains as well.
> 
>> If I have to enable PRI in attach path then I don't need to track number of
>> domain stuff. I can simply do something like
>> 	if (pdom_is_sva_capable(pdom))
>> 		// enable PRI in IOMMU
>> 		// enable device PRI
>>
>> and in detach path,
>> 	if (PRI is enabled)
>> 		// disable IOMMU/device PRI stuff
> 
> Each PASID can have PRI on or not, so you need to keep track of how
> many PASIDs are using PRI at any moment and keep things in sync that
> way.
> 
> If there are no PRI handlers installed then the PCI config space
> should disable PRI and all the PRI bits flushed and disabled.

If we don't have handler then PRI is disabled in attach device path only.

So in detach path, if number of PASIDs are zero then we are good to disable PRI
(at least for the current usage model).

> 
> At some point you need to determine if any PASIDs have domains that
> need PRI. A counter is a simple solution.

That we can implement it as use case evolves.

-Vasant
