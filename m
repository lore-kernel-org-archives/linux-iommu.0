Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010036.outbound.protection.outlook.com [52.101.46.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFE14DE72E
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609571; cv=fail; b=sGrs5fqmLyoCHqVfE7Rvt5px7LZVgsZvhcMb0DqgfSjHr8Rk7Qj9ICPHoCj+l4HmQE5gOHU/BubapHHNLc+5aHkd4pXdzOVbbk5MHbK6dI8z69SR/+sGY67V4XjYZz9ajFDc4qj5uxAbB3vn64jix+nSRIpXqqq7VuJ1ZYVR8RY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609571; c=relaxed/simple;
	bh=0lbt/fcLcOZiAqXRiPdmpEj/slwnlzY14Wo41yAnW7Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D7TZQpUXmcofad5LEoI3SWiOIHEjVtp1NeFJos3FT9yZfXDOyZ5xYdjTO/mTXghiU8KapY9jazSspiDS41fi42tY9dqFi1Vx/W1lvW1zZU4uborq29NDsyu71IA0O6jp9UMhjV9f0i56ApVypwQzZyEhe9/aMtEw0H5CE8lOnng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HkSJy59J; arc=fail smtp.client-ip=52.101.46.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HkSJy59J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHXABjvpMOyssgKL4RAjz/P+4ubOfOj4rKUSUYXOXgW77KBojINnkYMpT0r+lSQHWVsRrY3YzZgP+bwtCxoaWtzdj4SVzAzpgwr43F/IO7jQKnQ6MmHVF7qk5Pqxz2ReYejZsFnKfRBG6wh2EFIsHMWYYJE7AZ019Ir/YX6Ae7vUMHB2YkAMUdLQzsaeN++aTOskzt22db8SdKvLM0UeUD0g8tmcIWdwd+B8/ei38vVf6SYoY5aVHvTmWvPrciSb/USLSlNbrejHLF47m0tHEjg1ATfa7scdTaFIpjebFllnrCHLnRruHt0Yif6qAO611DDyz+yX6KYvyBxVFaJ/RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkxTFNIi830q1uLVXgN31K2N3yNuCOpOXh3DR2aS6pU=;
 b=m433QFFJ9SyDTO58K4Ml5ObF5MVJmcViUg0zToFHjZps6VALYgySia9dtBCoxxIV8oyuWq+5yF2Pch2nYquwXi3JuNjSssggCJKUY5JLsdGam8bSvixLxsoHjuX5bfeYpqu58Xu8ooocY/e0d/zVaxMDHXzz/86U6/taYS2H4i48Mpk6IldbOIGkqYUMPDRGfxgblyU412TQgBlDzgMNInYKgikqYpmYJCpBHKpMZiD1p3TAUtfzISFrG3a0LBifAjO+41/n0BlDr0e/mXby+nUdtayovY95W8ahu4AupuotuFWnyZqCEec0jZ2fClJGqpoTQ1LryotWseFZcOYz0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkxTFNIi830q1uLVXgN31K2N3yNuCOpOXh3DR2aS6pU=;
 b=HkSJy59JCiq4yvr04yVJ+VjD3kVyKWr9xVjyrD7s0hxTkGeUOD7Jyr41VS1c1ONgBGj5BETZMoCbWUyjsoKN/oKYhjpRbklCiR2JR6Zjd2M5q3m7MP7zzKeHiNip1MmON2PoXPmM+pxQjcU7bJDg8+QeyY7tQnyX3jjv0uhIt9E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SA1PR12MB7317.namprd12.prod.outlook.com (2603:10b6:806:2ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 15:32:44 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 15:32:44 +0000
Message-ID: <34bcdf7a-82b1-43cb-8409-735ebef3fa97@amd.com>
Date: Mon, 28 Sep 2026 10:32:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] iommu/amd: Add PerfOpt IOMMU performance
 optimization support
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>, Mario Limonciello <superm1@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>, Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx@lists.freedesktop.org,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>,
 Jatin Kataria <jkataria@netflix.com>, Boqun Feng <boqunf@netflix.com>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>
References: <20260908041207.38113-1-mario.limonciello@amd.com>
 <20260908041207.38113-2-mario.limonciello@amd.com>
 <20260924225018.GB16465@ziepe.ca> <arYf3iJW7hfTua__@8bytes.org>
 <20260925122848.GD163130@ziepe.ca>
 <4560d7d3-4d67-457d-bcd7-2176bd850bd4@amd.com>
 <20260925223928.GE163130@ziepe.ca>
 <ab1cdd64-3390-480a-8d41-a942e8b2e120@gmail.com>
 <20260928120831.GF163130@ziepe.ca>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260928120831.GF163130@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0312.namprd03.prod.outlook.com
 (2603:10b6:610:118::21) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SA1PR12MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: da1a1c91-4c45-4128-5d42-08df1d75bdd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|10067099003|11063799006|4143699003|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	DQum4l5JzKzBQx2nJ+2Mua7HyyoK2X2UPxWvkzZ4E/TqOyYsK5sXPQsimSE65jTrj3rMe2+AU5F7md6ZPeQyM3itFxxQ55gHY+do3qH0o6+oKCE1bGQceRXEWzqGBp91qkhEduRShWOZ4DEy2hv5x+Mi57pvC7ZfpS4uQW9R5z85N1dS3V2X1CimlfOBgcRDAPXSQSeZa0l5s6rMbYqE18357PrcaLvpIl9i9ZyKRCAuobo8KB2/nk9hjdbtVmK1eVUDG4yDkJeYPRXdBzBZNRTm8qPAvZZihL7GxYBVEqM31pAujhR7MWaYg1p0HMrN7ZgU3/AystweT8slDmXcRc1Vo5qkDnUXNiZ2GDAhuZE+cLTQYz6B7SqyzK0NXZryoWu79QbyEv8xVEw8ZNB5x9/YBfiYfnvx91GI40pqDc7cSD0OTLe6ifKw/QdksjtDjbBs9oO5k9W6l5bYCR+ck4uHJjZORU0klHNMwXQZz9xxH0PNPvsgd6rINZuHVXVeAPg86BnH7h3ingzAr17byYkSLNEhKcsPR+7gZ60sgZA71/E9AH/y+EdeMd7JwyFkrqUCzwS6QjdSQIX8LTEwIUNlzLDWBli/V2UWGzS5Slt+fCo9gSJ9okELRdk62MGV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(10067099003)(11063799006)(4143699003)(18002099003)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bENWSm1VZE1FbUxHUzdWUm9OeTNMS2JlSTBZbllDL1RXU3M5REdCS3RuTWx5?=
 =?utf-8?B?b21nZ1pCTkNXQjRDRmxxNG9DdlB5Q2lUKzRIcWtkaDQvODkxWjdhcmlkam5U?=
 =?utf-8?B?djNWSHI5ZDVReUtuMnhsbnE3c0ZLZzVBb1NWU0RTSDJzTXdnTmQ0SGkvQ2Zy?=
 =?utf-8?B?RlVjM3dhdmJaeUxwemhPb216Vy8weG9RZzFTUUZOc1d6WFBIVXNPOHd1NTJK?=
 =?utf-8?B?anlYVHVqZHArZkF3UVd1WkdQcjdjM296NFRsZXVRVEltZERJanF4V2g5N0ha?=
 =?utf-8?B?R3VqdEtyOW1FZStnYVB5SGZJR0lwME5jMzJyalBVajNvVmJVR2dCMWFEeU5l?=
 =?utf-8?B?QWhwTk96YjFyalFON1J0dXI0QklacFJCUDdMWElYazVKMEkwL280OUhUTnRQ?=
 =?utf-8?B?bHZBRmI2aTl1emNnbkJONVoxVVJza0J6dENTWmVYNGE4OWlnV1dsa0JGUVlE?=
 =?utf-8?B?aWdFNzduZjRBYVpQeXVhcm1ZREtlVGQ3U1M2MkRLM1gveEw1ZTNscTBrK1JG?=
 =?utf-8?B?VHhnYlZjQnQ0VmhwWFFmd3hsOFhZQkJEZ1lab1FCNDRnOExSVU5XNVBCSnlZ?=
 =?utf-8?B?TTliZG5jTHBsMk1pVXFrRzdQaTBRTi8xWmQzZzBIc1lxMkt3OFJRV3lGaDVz?=
 =?utf-8?B?MkxlNlRFbDJ3Z0FTa1RDTEdsTWN1VlMvdzB3a1VKay9tRmZMZERJZWI5Y0l4?=
 =?utf-8?B?MktYcVNERHFGT1d5RWgrQ3dhdFE2NW1vaEQ3cExqODVKejhhVDJWWkIyUjF0?=
 =?utf-8?B?alhoUFlobWtUblk4ZHpPcDBSeFgvSzg4SS90K0krNnR4QTFQbmtxUk5PTVBY?=
 =?utf-8?B?VHNFblhNUUxFRUhkc3NYY0NOUVFoU2lSU1doM3JHeVZ5anZWcmtBRUdxYk1x?=
 =?utf-8?B?Y1lXVkMwRWJxdlQ5c3JlTitpMzdObTN4V1lzc2ZzbjdTYU1CSEQ3d0tUZE5C?=
 =?utf-8?B?cFZZU1FsMS8zOVdVRTlWb1JMWmhYbmwrM2NOcXVzZmRsbC96T3daSzNuZnVW?=
 =?utf-8?B?eFNXT2ZVamRrTnBaWlNualBpK3RlYVBtK0QxTDI3alBLQndhZUx2WXJnNzBF?=
 =?utf-8?B?WHY1aTVvVVpubjZKTVF0MWxqazQ3c1dvTjlxUHYrY3M5b29Fd0IyMmdxRFp6?=
 =?utf-8?B?YkxvRFpLYVVhZzN3Nlk0ZXFoeVRrWi9XUDh1NGxKelJKMkRScTR0M0theWhQ?=
 =?utf-8?B?dERmVkdpS040NVIvOE0zMkhOWUw3NkQ5VlZqeFh2amhxUzhYZm42RWYzV2xM?=
 =?utf-8?B?QkFsQWdRSm5oV1VZSEF6QTV1VWQ4MG9HeUdvZ0pkU29VTFZJTXI1MkxBamQ5?=
 =?utf-8?B?MExXSC9mTWludTJBUXhSL2tnSXpNQ0Zob05rdXBRdGp5a3YyTStvRE1yMFFT?=
 =?utf-8?B?dmN0U2pyY1hPSndvS04xRDV1WFdkT0E1d204aldpZE02S2NHMlIydnhpQ1ZP?=
 =?utf-8?B?QzBialZNZ3p3d1V6NHJEcGViOTNVZEhPdXozRHdsa3l3eUpXNmUzZ0RpSHBk?=
 =?utf-8?B?NTljYVA5dldsK2NTR1ZhSmhVbnRmb2hOVmZJYTdFLzB4NURmQWxNeUNOUkdn?=
 =?utf-8?B?V0EvVE1PRHZRRFBJc3JTTzNUMVhVVzZZTzhlcFg5MDJvU0ZJa2pOQ1lEZHcy?=
 =?utf-8?B?RnFibXZobS9kc1BtOWNIZG5Ic0p1eEdjSGlLaG9jbURwSmpPcTM4cDNSeFZQ?=
 =?utf-8?B?UDVIbEdoc1M3VGxWWmdNKzRZU21QbnZRb2p1NjFtM2k5M0FoNWFJbUdrRmRy?=
 =?utf-8?B?VWpwcDlGekRmdUxFNHhUMVpVYy80RE1hZGpzQ2QzbTRtMzM5M3NhbjJxYXla?=
 =?utf-8?B?MkNaOUlnQ0gvc0xXM0UwaXI4RERQM1ZwRUNzYmttWFNJYlhYNDJTaml5L1VR?=
 =?utf-8?B?WnlpeXBGV081WEtVVEFvK3FHSXRhNENlYldkclM3VHN4b3U1d1R5L01kdUNu?=
 =?utf-8?B?Y0o4bjNHWElKL0I0UFdCR25OdC80a05FS1FjV04zclhzKzFEdzlCbGxKV0hN?=
 =?utf-8?B?THdGa2JpaFU4SWNDcWhLZ09HRTZYcTFmcXBPaVd4c291Ym1kR2RVdkdwS3NK?=
 =?utf-8?B?UkUyOXFyRVNhODRPa0pNaXRzWUNMWnQxTHgxTHpIS01zTkNNZlY4QkovTWdu?=
 =?utf-8?B?U1RNMzl3VTZ4ZjFHdWU0L2QvV3JaMzhpaUhXRHU0TFhlTVR3MVhtOWVLMnNp?=
 =?utf-8?B?R0diWUhzVUhQcFdJc0tQNVAzSmQxY00yZkd6aEhONVFwaWtRUEpGamMya1A5?=
 =?utf-8?B?M0NRT21raGUzQ09nanBNT0N0N2g4TUpSYWQyenQ0ZU5WRHZBR1ZCWlRmRDZR?=
 =?utf-8?Q?7Zwira5YKwdbpo0Heb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da1a1c91-4c45-4128-5d42-08df1d75bdd1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 15:32:44.4753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: amJGEmKiCKyuIMe1SUJ9oh14jln0YDL2U6yNqV8d+8zV0QvyRRsytukdFR//gKuIlQU/86ymWiHb49F6yRSqHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7317



On 9/28/26 07:08, Jason Gunthorpe wrote:
> On Fri, Sep 25, 2026 at 07:33:08PM -0500, Mario Limonciello wrote:
>>
>>
>> On 9/25/26 5:39 PM, Jason Gunthorpe wrote:
>>> On Fri, Sep 25, 2026 at 08:11:41AM -0500, Mario Limonciello wrote:
>>>>
>>>>
>>>> On 9/25/26 07:28, Jason Gunthorpe wrote:
>>>>> On Fri, Sep 25, 2026 at 09:20:02AM +0200, Joerg Roedel wrote:
>>>>>> On Thu, Sep 24, 2026 at 07:50:18PM -0300, Jason Gunthorpe wrote:
>>>>>>> Why does the GPU driver have to request this? Why can't the iommu
>>>>>>> driver know that this is a special device that can use this magic fast
>>>>>>> path and then auto set it when identity is asked for?
>>>>>>
>>>>>> This is a layering violation either way. Either the IOMMU driver needs to poke
>>>>>> into device details and their relations or the device driver needs to poke into
>>>>>> IOMMU details.
>>>>>
>>>>> There are no device details, this is just a module option in the gpu
>>>>> driver.
>>>>
>>>> Well the GPU driver has knowledge whether it's a GPU inside of an APU to
>>>> decide if it's valid.  That information is part of the discovery table
>>>> setup.
>>>
>>> Where was that in patch 2?
>>
>> amdgpu_device_use_perfopt()
> 
> Ah, sneaky, that looks like it just decodes from a a giant list of PCI IDs

Actually; no.  amdgpu has migrated away from PCI IDs and probes based on 
the "ATI vendor" + "display class" instead.  As part of the probe 
sequence there is something called an IP discovery table pull from the 
platform that identifies all IP blocks in the hardware.

This IP discovery table will indicate graphics IP and that is mapped to 
relevant driver code.  So for example GC 11.5.1 is what you find in a 
Strix Halo APU.  If a future APU had exactly the same graphics IP but a 
different display IP it would still be GC 11.5.1.

This design was implemented about 4 years ago, and all SoCs (APU, dGPU 
and accelerator) since then use it.
>   
>>> The right way for this to work is to quirk it through the iommu driver
>>> so it can choose the fast mode, and not involve the GPU driver at
>>> all. Like we've done for every other GPU weirdness. And AMD should be
>>> making this work better by providing ACPI support so the iommu driver
>>> can understand how it should work without inspecting PCI IDs.
>>
>> There is a heuristic that Vasant added recently that we detect APU from the
>> IOMMU driver.  We might be able to use that for now.
>>
>> I'll take a look at what an incremental patch looks like on top of
>> iommu/next that I think reworks all these paths the way you want.  I should
>> be able to post something next week.
> 
> ACPI is the right answer to these kinds of problems.
> 
> Jason

I'll discuss this with architects for the future programs.

For now as promissed I've worked out a patch [1] that keeps it all in 
iommu/amd per your suggestions.  It is using the existing APU heuristic.

https://lore.kernel.org/linux-iommu/20260928045050.955165-1-superm1@kernel.org/ 
[1]
