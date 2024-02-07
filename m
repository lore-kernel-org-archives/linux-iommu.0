Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81463200C9
	for <iommu@lists.linux.dev>; Wed,  7 Feb 2024 08:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707296305; cv=fail; b=AjOe3iWzau+65NsyH2DYy806Y8OXdZG8ob3XW+nWdHHlcoShWwkzT/vc+wdenNeXeS+iliiKmVwk8R98TpYbgBh2jtRaS62UpU6/juIm/cFz49VW6FgHMbFUbiuT7qJ00FZtjejN1FKXy2ELbZUrzJbN8wtVrQoM55JjbZyx96k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707296305; c=relaxed/simple;
	bh=5P4Yg/bIqR0X8Nd3K4azdN4JBuyFCgOlIjf4sR1Re7o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B2TQ9cGg3giRbgSxq4R/7H0jmmqTlBzDwHhQJLJ1OtPVal01ZC092TkB1oN5xwD78+2/pCKxa7N2dQk6QHOBRFkGBlULA4Dzi6gakSMAeeEf5f2NuTIp/3BWsFX4eLWFe5hkLwfPjj9hKW2BGWrUstu5pwELzXJqgR7ypKdYO94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UV2NnJ9C; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UV2NnJ9C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYFaYrrDoMuS8P+TvCTJVAGQ+/dsdGZBMwxBXaPhBp5DCD72ctGk8Vj6BpULAi4h3XB4J5OdyvFnDY9yB19ze+jSQrH+Fk1II6d3Ft6zrETJ5FA0fZmPu8KRJDfpjDzxdgijlibnLs6g4oFyLXPtXyD/wZvKumoFuWogW9rLl6nmFD6+6RoomvrN9QZWLfYTEi2ogIiVbpHtN3NmOO4COeufoBasmJ1nJjSxfx/jLBvzfBwSqOd+iwnMTTvWEhr0S9DfGE71OC9eG8MakMGOxN3b4wdHUOXJGvHz6KwdcSPFWI5A33l2GSZQaYLkbTTMcNo8T8H8GjWjYW8PIlA0Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHpw9qZFxuiEA0hpQ/PpaBdKp3NuzT07Diyvq0BGq5U=;
 b=Lb7dDB+EwHqIhfauQkZqtoDP6RLgHU0NedHYcZh2ZFqlTqLi1N0bk/5Utud/LwQE/5MvtSkSdKlTQEWA/Ang8at1Agpk64iumknnoU5ZKnf6e6m2L3hMpQ/xt2tyn1NF7y8wBwu1Bg69EPFuuaiZfnOTeU9/4gNBTFuFJ2m+2z3JRg7mMv7yBaHfknlWBWf9Fw1UNNzJKm17ZhqrD2kN7HWiHEL7KLagRbRQhtCJG09hKPXXsN8tPIX7Ll/0qIaKJzWzLN42YLLYj65Oq6bjcf/09nqHHhifUnHSe1RZRKfY33NqI7MB9jjFRWCx0HbKD39B02IF2Kx9vmqCCVhDXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHpw9qZFxuiEA0hpQ/PpaBdKp3NuzT07Diyvq0BGq5U=;
 b=UV2NnJ9CTJ6rJPuIkuGtmORNfQZfXgIykUn3Xheoj7P5DwCkzxWaZKDo+kVBDe5BAygBNZyzir5Bq2OtbszoIu513hhlTZZvMt4ZqZpEtHsD9DXzmyDqRYtv4Nwq3rR/GTFGYB8+nrR+mfc0gHiqqrZo/Fo8g3jBiy4oWMI7tJU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SJ0PR12MB6807.namprd12.prod.outlook.com (2603:10b6:a03:479::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Wed, 7 Feb
 2024 08:58:17 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb%2]) with mapi id 15.20.7270.012; Wed, 7 Feb 2024
 08:58:17 +0000
Message-ID: <0d626c74-aba5-bbb1-5fb4-b9be5577d71f@amd.com>
Date: Wed, 7 Feb 2024 14:28:08 +0530
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
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240206175824.GI31743@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0137.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::22) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SJ0PR12MB6807:EE_
X-MS-Office365-Filtering-Correlation-Id: 56e57f74-52c3-4e44-b9f9-08dc27baed00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cd0cIaGh/GErHEEImPaAFvdwskL1dyNSKq25Nq50m7QJDgd4mJolL/dbDmrzjkJX2rWtYg6/pOqJJX9oB2klFrHb7+rQULk/xxq+mXmabyTiQ1Jg7lfWUR/J2Xwt2VEZM/zvyGpMvOoUN87wDiQ4wVKQknS8OfBCLedr328/EZmGa8sOymKPxxaUk7dZT3TihezPmnCWAYvE+EA0/kF6w/JqeT/EEjkLe0SzEoQj8fDlHceQEqTjRvHSzv/7j/qlhBmSnj7jskpbJmp9uNA/YSaDPSYt0UOJEgjIFUJcPm/Pr329NKanUpLsRflKsjBLffa1HuX+YjOeoggt5zctvQ6caEucMf6pwWNobYWB0kB786AKPkDd8NDk1FD3E1KWIzeMH5U2eEeDjRnpceoraa2eggCNlVqGGvSCQw0Cp5qK9UqEMDkSgBYn04ncz9dncll3M5SshsTvMNeusm7E+et1KaN0i3hFsPcEyE8ipSF9C22wpGCg8l21VnaHVbTEkZWP+i9TUJpUfQ+qB0B3B+h52Rdj0b07RPVCXmz8zSLD+MfgYhc6f4arxGXddoRHW3ynbwT4NbIRnW1O8OT8BLYn6RSsvm48HpNwmQrMnsel67EwZTZyJi8EXfU0YC+laTYFd+TKBvM9ebFoKxYVIA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(26005)(44832011)(83380400001)(4326008)(38100700002)(8676002)(6916009)(2616005)(66556008)(8936002)(5660300002)(316002)(66946007)(66476007)(6666004)(6506007)(53546011)(478600001)(6486002)(6512007)(86362001)(31696002)(41300700001)(36756003)(31686004)(2906002)(66899024)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QW1FVzVZSzdPVS9oZHIzMlRBOTN3Q2tlRzZHbTY5cXlNL1g4WXVFNGlRNnNk?=
 =?utf-8?B?QitLSm9HdlAzUlJBd1FTM0IvbHNnMUFwOFAyNDhUMDFzUndLZmcyYlU2L3Bt?=
 =?utf-8?B?ekpBeXZ6emlXRGhJMjBXQy9HSWpOR3dOWEpWc1hPUDJNUU0wSVBWak9IclNv?=
 =?utf-8?B?WCtueDN6M1pCeTUzRHE4SFdQYUo2Y2hQV2RtT1hRdkdFM3FvYlZyNFgyNWFi?=
 =?utf-8?B?aHdGYzE5RjVhaXh0VUxMTWlJY0FkNlMreGxiKzRSRmY1VUQzVDRjeGFvaXZt?=
 =?utf-8?B?SGhEK25nVXQzVEpHbXdXVGRrei9NN1VwQUxzcWhYeHM5VU9kQTJMTjhkdWlt?=
 =?utf-8?B?cXk4SGhQYkVaTk8rOXdROTlNWnY1eGgrMDc3YUk2Q3J1NERMbzVVOWQ5ZFlj?=
 =?utf-8?B?RHI5SUQxY3hnRTE5ai9MSHhETUEvT0d4UkJGWnUvTEFUY01rQXVDOG5VRkFP?=
 =?utf-8?B?VE9ISmJscWJBZWRnWGNHZVVWNjFGTHBWa2Zlb2tmcDgxNDVRZmFVWnA5VE0y?=
 =?utf-8?B?RGFacjVKbDM4ZGN3bjFmYmlJN1puRlcwNVJFNDJwVEs3MUxRdDRwYjFWNXQz?=
 =?utf-8?B?STNSOUpEMFBKQXZmbEQzUEQ4WCtCSzVDQ2pDSWFJSnhreXlyVFBLTzRhMDlF?=
 =?utf-8?B?L3BxUGUxanFDQjd3OXQ0TE9KU0R6QW9PSm96MUJ4bTl1MWh6YzVrVlpUeUo2?=
 =?utf-8?B?STArdHJLYjFiU1RKKzhtUVpzN2E0Zm52NnZtWnBhY2svZ3JvQVlHSXpLMGZo?=
 =?utf-8?B?anUwelFtdGJVcmNGZTk5Vk5NdFYyU2Z4TDVrZWUwbDgzdFZPVTNhMFF5RGVT?=
 =?utf-8?B?Y0JXSmFhdXVmaXVuVTNDOTJOWlZrTExNMU9lLzV6TXl6OVU1Rkg4WmtORjRz?=
 =?utf-8?B?MTJBWkwvS1pxSzhUU3hFcjlEY2xobTRCUjdyL01WYlY1RjBJb0VIaWgwajZm?=
 =?utf-8?B?MS91WkxkYU1ndC8vOE4rV2l0b0dFVUJGQjZvTEpDdUNDYWlCWG9BYk1wZkxC?=
 =?utf-8?B?bUxPZzg0UHV5dWtqUUprOXpXOU9CdXNIUlVnd1d3SWJNU1R0UGs3Mm11SktE?=
 =?utf-8?B?YlRxN3VZWllxQkJNRkE0Tm9qdFY4bXQweEMzaUdPNlBWN1RTSW1YbEQ4K1J5?=
 =?utf-8?B?WmVXb2RPRzJpc1pCaCsveFB0d3o1dFYwK2tqckxJSlVCNXkrYVA5UXp2TWpM?=
 =?utf-8?B?Q2pjL2lOQzc3ZFdSQWlKeVpPaHdGK1RWZlVlejZSMTFkUDJ1aER3SDNVOTl3?=
 =?utf-8?B?ajN5ODJLYWgrclpjODdERjM2VWdwdmJwdk90UXNFdFJLREhNVDBhWVlGdktD?=
 =?utf-8?B?L0Y0REF1MlZNaFZ2QUVnYkVoczQrMnI4ajBucVFsdm5lV2xqVzRLbCtRMGxD?=
 =?utf-8?B?bVhpRW1FMnJXNWlUbDdNNHhNMFA0QU5wSlJKWkJjcXJFa1h4dHp0MndZOXRq?=
 =?utf-8?B?bEU3OFZ5V0xuZnV0Q3hNOG9TRWx0N3BOYUtWa0RNMzlYWERmVzFHKzNUL3Bu?=
 =?utf-8?B?b3hBN21Sa3FHTy8rZnI4L21jbE1lZDl0V05wVkJIbmJ5NDlMcFZaSjNnVXIw?=
 =?utf-8?B?TzJWZ0dXbFU3U1pPRHluc2VISTBJWm9mQjh3N1hYZ3k1bmhDUytoalVYN21y?=
 =?utf-8?B?ZzZVMGFKM3Zyb2VOM0NuckpxNWQyZ1EyUW9jaGdLSjN0RVFuOFN3WVY4UVE4?=
 =?utf-8?B?a1phcUFDcjBGYWxDd0hCY0xRVGZjKysrYVRJZ2hBN01IbHEwbGNXYkhLNytu?=
 =?utf-8?B?Z0doclhhYVJnalZpMTNRcWFOK01qTk1JajlNSklPejR1V0hIVWVMSU1jNTRS?=
 =?utf-8?B?dG5BVGMxbnBtbDZqMzhHNFJwK3U4Ukx4dnZ0UzhPVGdSVVBuMS9LT0pYRnRK?=
 =?utf-8?B?WGl2S0Z5ZEpSSU5SVVh6K0oxTGswNjNYSUFMOENXUkN0Q1BjVlVUYmRCcE9n?=
 =?utf-8?B?SllPWXYxUE9pb0VzcitMWUV5MWkra0loS0l6U3luNDgyRlpxalRseGJSVms1?=
 =?utf-8?B?TmYyTWFyWGwzaXdKQzk3S2xXRGhBdlNXQmx4TEN5U3J6Wi9ISHJKVGFVakFF?=
 =?utf-8?B?eWdnMDRjeHlCNEVHMEtBVENxaFY2bDNYdWpsSFJVNzhWMmtQeTNYaEtyMmEr?=
 =?utf-8?Q?9am69Na6XVjW7hdjCtCYEMDyA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e57f74-52c3-4e44-b9f9-08dc27baed00
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 08:58:17.6657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8n++ERSWdKMvjpk8aYn5Cv/F9PrfD6yOOlsP8ZMQh/RVAIaHF5QznbMNfcpfT6seHUO2bLWnI9J2VG1D5ialDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6807



On 2/6/2024 11:28 PM, Jason Gunthorpe wrote:
> On Tue, Feb 06, 2024 at 10:59:03PM +0530, Vasant Hegde wrote:
>> On 2/6/2024 10:06 PM, Jason Gunthorpe wrote:
>>> On Tue, Feb 06, 2024 at 09:49:36PM +0530, Vasant Hegde wrote:
>>>
>>>>> This dte change is in the wrong place. When the domain is first
>>>>> attached we know if it requires PRI or not. At that moment the DTE
>>>>> should be set properly, it should not be set wrong and then changed
>>>>> later.
>>>>
>>>> We want to enable PPR support only after setting up the handler.
>>>
>>> That's backwards. It means error handling can't really be sane..
>>
>> Why do you think enabling feature only when we are really going to
>> use it backwards?
> 
> Because you touch the DTE twice, it means the domain is installed in
> an inconsistent state where it is not actually working
> properly. Domain updates should not "tear" like that.
> 
> You already know what is going to happen at the very start of attach,
> you don't need to "enable it after" just do it right the first time
> through.

First time we will not know whether device will actually use fault handler or
not. All we will know is whether IOMMU and device is capable of PRI or not.

We can make assumption that it may use and just enable it.


> 
> There is a clear protocol and ordering requirement for the PRI
> enablement. Lu described it in a comment, make sure you follow it.

Where? in intel driver? (they seems to be using feature_enable() path)

I did look into latest "iommu: Prepare to deliver page faults to user space"
series. I don't see anything specific to PRI enablement flow.


> 
> You also have to think about what happens during detach and what
> happens on all the pairs of attach -> attach.

ok.

> 
> The error unwinds are tricky, the only way I could make it all be
> correct for ARM was to fix the attach handling so that there is no
> failure scenario after the DTE is updated. ie the attach functions
> either do nothing or fully succeed.
> 
> The situation where attach fails and leaves the HW in an unknown state
> is really hard to deal with - and without the reliable global blocked
> domain the core code can't 100% rescue it either.

If attach fails we throw error message and skip updating DTE. I believe core
layer understands that driver failed to attach device and puts device/group to
its original domain. So things should work fine.

> 
>>>>> (and again the whole dte setting flow needs cleaning, I think you
>>>>> should do that before trying to build more complex stuff on top)
>>>>
>>>> Yeah. I want to fix few things in that path. But that's outside this series.
>>>
>>> I was looking at it and there are many security bugs in here now that
>>> iommufd can change the DTE at any time. The current design assumes DMA
>>> will be stopped and ignores the spec guidance on how to do a safe DTE
>>> update :(
>>
>> What security issues are you referring? Can you elaborate?
> 
> The DTE is not updated correctly. The HW can read inconsistent
> versions of it with unpredictable - and possibly security bad -
> results.
> 
> Like it doesn't even write the two qwords of the DTE in a predicatble
> order! Let alone worrying about the 3 qw update or being correct with
> races during an ITE touch :(
> 
> This doesn't matter so much if there is no DMA active while the DTE is
> being changed, which could sort of reasonably be assumed up till
> iommufd allowed it to happen under userspace control.
> 
> Now a driver cannot make the assumption that DMA is halted. It must
> follow all the protocols to ensure that HW observes only exactly the
> DTEs/etc it is trying to build and not something random.
> 
> The documentation is pretty clear how this is supposed to work. It is
> the same as ARM. Use atomic 64/128 bit stores, rely on 'ignored
> behavior' or use the valid bit.
> 
> This also means, broadly, you can't allow the DTE to evolve during the
> operation of attach/detach as the in-between states may become
> userspace visible and may be harmful in some way.

We make DTE changes in set_dte() function only (except dirty bit change that
will be consolidated).


> 
>>> I'm really not comfortable with adding more stuff here until the
>>> security issue is solved. Especially if the more stuff is drifting
>>> further from being correct. If you can keep the updates in set_dte
>>> then maybe with some reluctance. But not like this with random touches
>>> to the DTE all over the place.
>>
>> Currently all DTE update is happening inside set_dte only (dirty bit enable is
>> an exception that may need to moved inside set_dte). This patch just invokes
>> that set_dte and invalidates cache.
> 
> So then why all this strangeness?? Just set dev_data->ppr earlier in
> attach and order the handler setup properly.
> 
> It should be really simple:
> 
>  // All protected by the core's group mutex
> 
>  if (domain->needs_pri)  {
>      dev_data->ppr = true;
>      if (!dev_data->num_pri_domains)

What is PRI domain?

If I have to enable PRI in attach path then I don't need to track number of
domain stuff. I can simply do something like
	if (pdom_is_sva_capable(pdom))
		// enable PRI in IOMMU
		// enable device PRI

and in detach path,
	if (PRI is enabled)
		// disable IOMMU/device PRI stuff


-Vasant

>        // enable fault queues for the device
>      dev_data->num_pri_domains++
>  }
> 
>  if (old_domain->needs_pri) {
>      dev_data->num_pri_domains--;
>      if (!dev_data->num_pri_domains) {
>          dev_data->ppr = false;
>          disable pri at PCI()
>      }
>  }
> 
>  set_dte()
> 
>  if (domain->needs_pr)
>     enable pri at PCI()
> 
> The order here is really important too!
> 
> Since PRI can only be supported when a GCR3 is present, this should
> all be part of some generic 'install GCR3 table DTE' routine that is
> called on all the attach paths.
> 
> Jason
