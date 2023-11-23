Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FF3405E8
	for <iommu@lists.linux.dev>; Thu, 23 Nov 2023 17:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d0x54ZXn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CoI9eF63JMAt0YkSh2VdFISIKXDjxU1wUOGLm3Lj80+s97OBM5xsGp58pvGqRzhxGzUNiVhO8dl/MywKczoM88Y2f4ZuQk9IpuTwj2x33JWDOKf4MkJzN1S/l54IaXHn/E0htMlc5oWLsp16wM/cfYs4V0et9WF5/r0wSd44VvBdZqGjUDWvhwWtHNn1SBjTIEqd1v9ptqyvzh4MLBQb5X7nDyQ5GmlOKfYcJ9BSDhnXv2HhOE1uuRbukJMXOifGPEtD7HUWhhZ4gcGUpAif87+HLC/FLYdaOxFxhlSQsRJGdWVptpsGw+rWAutwRM8SK+v8KaX8Myyltq4Cos221Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TESsp9Bg7ujYpT0kksfiYMB9MSTf2MQUjA4KvIsRgKk=;
 b=CpFg9AHGh7lPBa8w3h3I0RpSL3QoqnBT70cLUJHjRUg1mB3p2eepJ96cxAEnTb52utJrk6p7lE60Z0XWCCe0KAjeXsB41cp/THm/fphJIuN2V8OfQ/FLlqG4T+7rV8qqCNyIlc54jMMm/DmM6+FgkST0mCSCQYK4xa02GGXOkjBocznbGRhc7EKMUHBkY0nSoZNSExeloJ5gqWod5M7rz0+KXYLK3OMARN4eH5N9W3OQ0m7bBY1Ro3SdynEoZbbcbLJXUsQKikx4sHo35dB26Iw4BUTHEFcBmtKruGGWmiiHHBPEUTfOx3VW9mbqY4lux7tmdUQQ0ksEvijxUpK/wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TESsp9Bg7ujYpT0kksfiYMB9MSTf2MQUjA4KvIsRgKk=;
 b=d0x54ZXnLQAo4ByUry+uHyBzQPg+nTw5z1xZqg9HqxO2bkZNovGaFoiabbyrPvYwMNJcN8ezgncnGDfDDRymr9FUlU/YSjHYfhxaJuZL1PNk26M7rqlE7CL4PkrHnncNbOR3+/Kw+3f009HW0r1mY110IHar640x4jWRfQs5gvk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SN7PR12MB6862.namprd12.prod.outlook.com (2603:10b6:806:265::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Thu, 23 Nov
 2023 17:39:28 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af%3]) with mapi id 15.20.7025.017; Thu, 23 Nov 2023
 17:39:27 +0000
Message-ID: <d99a1d56-6b29-53e8-1d2b-564a56548009@amd.com>
Date: Thu, 23 Nov 2023 23:09:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 10/13] iommu/amd: Refactor helper function for
 attaching / detaching device
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20231013151652.6008-1-vasant.hegde@amd.com>
 <20231013151652.6008-11-vasant.hegde@amd.com>
 <20231106172931.GM4634@ziepe.ca>
 <f23aaa41-b22e-b274-5774-6317ba643e8a@amd.com>
 <20231107132827.GY4634@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20231107132827.GY4634@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::23) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SN7PR12MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ba570d5-53bd-4e54-f80c-08dbec4b2415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CM132iDJItRwqJFwfh6uDVoQa7s69ipsTHGfwVaQvgtcIsZ2Tj+wbn5K37cdbSgwZbtz2gMe3EDLIMz/9XR4PTe/AaaF2T5VeKPW+62e7VuZGcXlbEVCuOe6Hh70CLJVJMA5T1u0L4tnNEWDhhMHOQWQNuxpkI2YEeFB6JjnkQ5gc/JJaaVHtH8GmRNvVbYnn/fQ8cAaXdWMQrol4MGcIyxBMTXS/6Lssfkb0+pE1kSJZLwRk324uxGoUi+3hVCt+BtLk3Xm3FA+41aetaOS372qQnyRoe/dCmcvgZ7ZNFETVNhWuejs3qzKEgREbVQq0xaWj2OsqTxsuOBDroHOyV1FZmkt3+G29tUDbEIQJl4Sa4W1lCpbylLydI255gMl8BaHfZZXgp9JBWK+oZXJJBxh2QZu7j0nU5beT1J5HBDxp9rP996XEWTjx30RKB2uj9PQA+99njQKZygvKS4UK3rJLZaOrweDEa71FcnVMKRFmvBMBrt0V+fuOI0GHptyWsHBRrjh6tC/NjpOtMvTCZyFxxq8qeSdhZbpoDKJdTfrlxjVIIhle5C+sY1dk9QwXhhIErq8XEJKcN3kATsvVpQRPa+vW4sVM9ePYuqvE8PZTEWW24UpVu67XFyPVN51TwLP+4k4oyaDDeLFNQWRtw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39860400002)(396003)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(6486002)(83380400001)(478600001)(6506007)(6512007)(31686004)(6666004)(26005)(53546011)(2616005)(38100700002)(6916009)(66946007)(316002)(66556008)(66476007)(31696002)(86362001)(5660300002)(2906002)(44832011)(41300700001)(4326008)(8936002)(8676002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGdlNkcwNTVtUTRSVkt1elZnRkNqYjhzNlRLU0toTUhSVi9sRXc2cHZla2Ft?=
 =?utf-8?B?ZlJ1bUFQVGM2eVhub1ZhVkk5cUZYTit3U1FqMWlVb3hyR0FpcDBmeVJiTGwz?=
 =?utf-8?B?bFJPYjhubHoyMWxMaGNjb0k5bjZ1ZGlUK0d0elVLcElnSDVQbXJ3azZYM2M4?=
 =?utf-8?B?b3piY1Y4aVcxeDg0enl0UnVXbUJtaHY0MnNuSWNQb3E1azlnek12V1V1eFFr?=
 =?utf-8?B?TUl0UTc5QmE3ajZqTDdRaDZqK2tTM0kwOXRjNHBuOFdBZ05qQ3BNQlJRVllm?=
 =?utf-8?B?RzR6R3BnNzhsZktEblg3SG44SEJXdzZIZkVmVEJ3dngyd3dKaXN5ODMraG8w?=
 =?utf-8?B?alE3U0p1L3pUbVJTVHRCUE11MjZ6ZjBKSkpZSDZFSVc3SG5FZ0Z2TFFYZjZT?=
 =?utf-8?B?ancxR3JoTERDTGtLRWhyZVpnSU1IU25DRHlIdS8yWU0vQndQWjA3TWpQVm5p?=
 =?utf-8?B?SjZWK001QWFOejh0bDRlYkJrOG1rdVZaUG1nVkhvUVA5VmUrYnFNbzNreHpW?=
 =?utf-8?B?Ymc1V1FvQlFhaGRld01VbHpnNHZoaGRGMVNuV3p5YmJSTVFNbmFEYU1wNDZ0?=
 =?utf-8?B?Q0dySkYyazdGNXJZYU04L2xyTjNVTlJ4MWVIeiswSUhnNmhXdlVxeks4UTlo?=
 =?utf-8?B?elh2NUNWakJrWGRuNnhFSGlwSHlza3pVeDc1Wkt4WTVBWTAwL0taTnJYbXV0?=
 =?utf-8?B?L2tTTWZKc29lMVIxdnh0SDlINzdzc01VVDIwVUJSZXU0VTBvbkVDNzBKay92?=
 =?utf-8?B?NUFUU2dQVjJ0S09SelFVRTUveFBxQnZNVUw0Y05kM3FxOXdndGpzd241c253?=
 =?utf-8?B?YXpmUk1aTnBncG55T0VYN2ppK1k5S01SMFBlNHpFUFpiTHlwYUxmSkZSSU5Q?=
 =?utf-8?B?OEpUVVkxcDFHajdQM3R3OHFCS1c4U1hRejhXajBrd0xCRDA1cUFaTzhIOHJD?=
 =?utf-8?B?ZWtGczNJVFQxQmxUQTliT1Y5UjBtM296aEZvS2l4ZCtvVEVXZWdlTWJoMzNM?=
 =?utf-8?B?UHZTeVhDeS9vWFJ3THVjWERYY3lQaFA1QysxeXpnWndtUU1tRUs5czhEN0lH?=
 =?utf-8?B?QlNkSlNwU1BFcjlHdUhBSTdHT25DVUtBRFdteHptK1JGNWRSc0RxUGNkU1VG?=
 =?utf-8?B?b3h0RElEV3FEM2cyZ0d2R1VNTktpUWRpS1dOVUVTUkdWOHdOZDhQaW5lZURT?=
 =?utf-8?B?eVdHQXBYU2xVdDJ5WFNPRGJLN2Q4dUZyRXMxc25BRDBQZTh1bTFSNHIwYkx4?=
 =?utf-8?B?K25wdi92MTI3WStFUXo3cDhzcFd3L290K2pBRXlwV3dET21FZHRla21lYkVQ?=
 =?utf-8?B?TU8xK0lrSzJ5WTErdWllcFJ3RnF0K2gvR2k0MkpkZVBQTmgvQ0YwRHNJaE5r?=
 =?utf-8?B?Tm1xKzlsb2xpTWk0UGdWdDFkU1lmQlNGZ1hIRXRtamJnMkJsQzBGdVlOTW1m?=
 =?utf-8?B?VWhjTDRNdytYNHZsVDM3WDNadENlVW8yZ3k2MVNXZDQ2QkcwelhkcFZpNTEr?=
 =?utf-8?B?dTFtRjFUaEZmUkcvWURuUEhUaDY3ZzdmOEtXZzg5TUN5dForRXI5WGhGcnNv?=
 =?utf-8?B?OHhQSWtDbjFxelRDSUFyUXY1SnV4UHI4ZmR1emgrRVpWbElFZ2VsRmJ2cWJV?=
 =?utf-8?B?R1FIQ1JtN0o1WllFZXl3N3d0MHF2bkVJQjlNazFKTkZENlR2Umc0RDdXSnNT?=
 =?utf-8?B?V2NnbERETWgxa25qQjhOY05MTGFRQThjaFNnSUhVN1g0YW1ET3RNMEM4Ym1U?=
 =?utf-8?B?T0J3dWtDMU5OSUhsaER5c3JoN3BGS08xazZTZE9LVEZEcnVraUQzeVNVTjdO?=
 =?utf-8?B?TGRZM0RUY0RKUExwN09HYXJQWmU1WHBJSkN0dXNHbTlzbHI1ZENWVVBSZjNN?=
 =?utf-8?B?Q24xaGg0VzFqZWJxU0FZNXFmUENjRmwxWTBiZkVpNmU3ZVhNdkdwaDliWU1a?=
 =?utf-8?B?RzVqTm9rRDIxQzFlQWc4NTh3bkdQVDNWZ3YyUEZQdzR1TlFkM2Fqekw3UFhE?=
 =?utf-8?B?UnlmRWJVN3NBeS9EeHlvcmgwM2ZMKzE2c3AzZlA3Q3lxdlpjWXpvM0xYeWE0?=
 =?utf-8?B?ZXY4RlYxU25MbmRRNC90R3lZaE5oaWxrOVlUTGdzaGMyV3BBR2xraVFwZEtZ?=
 =?utf-8?Q?cTbMfkU1D5SEDxKrt0cYkrMDh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba570d5-53bd-4e54-f80c-08dbec4b2415
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 17:39:27.8324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y/TFHS5JKrnBaCsL+efAu32fVZK+xU40mLx3a69FMhgkAK0bGLtWuKN7D6fMbNavxmsYoo2dyUIGTtFP9qV0Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6862



On 11/7/2023 6:58 PM, Jason Gunthorpe wrote:
> On Tue, Nov 07, 2023 at 11:25:49AM +0530, Vasant Hegde wrote:
> 
>>>  RID domain=BLOCKED & PASID - ?? [V=1, TV=0, GV=1, GIOV=1 with GCR3 entry 0 being non-valid] 
>>
>> I haven't thought this scenario. Why do we even need this case?
> 
> It is triggerable by iommufd, it has to be supported.

You mean PASID support with BLOCKED domain?

> 
> You understand I'm going to insist that *all* of this is fixed before
> you can progress with any new iommufd features, right? We must have

I have seen those part of code and it makes sense to have BLOCKED domain
implemented. Its in our TODO list. I intended to look into domain allocation
path more closely once we finish SVA series.

> drivers implement the APIs correctly when they are exposed to
> userspace. I sent patches fixing SMMUv3, we will have to make the same
> fixing for AMD and Intel too.
> 
>>> Did I get it right? If so GIOV should ultimately be deduced based on
>>> what domain the RID has?
>>>
>>> Look at how the SMMUv3 stuff ended up. Their STE is the same purpose
>>> as the AMD DTE. There are alot of combinations here, it was hard to
>>> make a code flow that was clean. It turned out pretty good when the
>>> DTE was generated in the ops->attach based on a calculation of exactly
>>> what the current configuration is, because we already know what we are
>>> in alot of detail at that point.
>>>
>>> eg we know if we are attaching an identity domain and PASIDs are in
>>> use that a single specific DTE should be created. So just call a
>>> function directly to get the required DTE.
>>>
>>> IOW - I'm not sure it really makes logical sense to store giov in
>>> gcr3_info.
>>
>> We had a choice of having a giov flag inside gcr3_info as it tells how to
>> configure GCR3 related bits in DTE -OR- having a extra logic to calculate it
>> every time. I can be calculated.
> 
> The codepath that determines the DTE will know already what the value
> should be. Again look at how SMMUv3 turned out, the GIOV is very
> similar to S1DSS.

I have removed `giov` variable. Instead I have page table check.

> 
>>>>  	dev_data->domain = domain;
>>>> @@ -2080,11 +2103,27 @@ static void do_attach(struct iommu_dev_data *dev_data,
>>>>  	if (domain_id_is_per_dev(domain))
>>>>  		dev_data->domid = domain_id_alloc();
>>>
>>> At some point this is the wrong place to put this, the domain ID is
>>> logically associated with the gcr3 table, it should never be used if
>>> there is no gcr table allocated, and it should be freed once the gcr3
>>> table is freed.
>>
>> Domain ID is decided based on page table type (and may be based on PASID later).
>>  That's why I have a function to decide whether to allocate ID or not and it
>> should be done in this path only. So that we can configure DTE.
> 
> The page table type determines if the GCR3 table is loaded, the domain
> ID is needed if the GCR3 table is loaded.

For now I'd prefer to keep it in do_attach/detach path. I want to rework
per-device-domain-ID after SVA series (i.e. allocate per-device-domain-ID only
when its needed).

-Vasant
