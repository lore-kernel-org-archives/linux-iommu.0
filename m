Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC232CA6D
	for <iommu@lists.linux.dev>; Tue,  5 Sep 2023 14:39:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iH2sN6Z3BgIsOxx4vwzJVSwqX2C6u0Dyw97WerRyE7LeR2Gl8auSoU+7rpVQGD07h5LSXG/qjlNQrG6MP8brbkYKq+fGAVw7zCRq54IAOzox+Sb4mUZH1Wdau8oLrcur7eLgE/67I5N9qS+2XPC0QZ2CreJFEJF+PoSmDBuv8pIVslEz4WPhv1ptks/91/pAp2wwUpZE0owWNJHQtCeDYQ+olI5NVnMnDWHgw9h7PYWHlTTqkFwIxDQnOequ9f9i22TSiUXoTGbraY8R3sswf0VdL5cyL1+9PavOe9R07u5lFFQnB2z3pb+ufdle8ruJAWXg/Oz0TcVSt55ECSsnqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzrfMUrQMLKvjCZOW7Vvb/mtsDFaCS88HTvvsZ8qkt4=;
 b=T9ig0v1Mv48V8ug2EzB3cAeFNf6s5f5CUIsZk8Inw/Tzwrm3Hsq58CCgRFNKMMXXXYt6EvQHVyC3ah0kcXm1DAYHu1meox/HYsA0VRnRdcLdQi6sf/ZYqcyZhG5INsOm6XRZo5KSX50oBxIt6JCydk9t3tjpGdaVnKzrYJCgono1h0hGiTqNKo5Fae2+3SnEsq6jzNpG8z7aNvX1Kka0HEmbt4E/IblQH0p03aWju6CjuXlUEd+0NCV+yovBC4ovzMu8xbxJY7Ld/ILG5t1MnU/g1KkHqh5FBXdz5N663JusGxl0+2as5CrHBtOFyxdPZxJy4CoZG5zEQ1BrPsHI9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzrfMUrQMLKvjCZOW7Vvb/mtsDFaCS88HTvvsZ8qkt4=;
 b=B/IkpafWT8JOZiKT3JX/kcAfXAcz8KwRlbNZCIq2gwCC6wyV3xng5bcttRJsNCrhgI7f7pP7iL7VsHcowoe2jy+n/ec6n4Tg8EmiP38OKfTKTt35L2ffu6pY1j3AGWxEZj8fb+mZCy7qwcRy5JQmja9+K00cpCjp3It/bnSyhdw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CY8PR12MB8241.namprd12.prod.outlook.com (2603:10b6:930:76::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.32; Tue, 5 Sep 2023 14:39:52 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 14:39:52 +0000
Message-ID: <38845842-d535-b621-1e6b-16d8db52a1bb@amd.com>
Date: Tue, 5 Sep 2023 20:09:39 +0530
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
 <d64d8066-7cee-46c6-2403-76eaa969fe53@amd.com> <ZPcejmNW153rcRFA@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZPcejmNW153rcRFA@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0110.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::7) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CY8PR12MB8241:EE_
X-MS-Office365-Filtering-Correlation-Id: 185048de-d1fc-46a2-0a56-08dbae1df6ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DKJDy5h0OejcY5cdp/XrqYgCQxeXcTn5GWftzQhsGBxxUoVgdsayYREDL+DmyjUUq21xeKj0OMa4xeLkdK9a+AxMPLlz2JCfhbMFz1w5AAay52XscEAlYS+eH81eMuOVzTNnQQ15IM6vwv3jz8bag4dY5wstMeupcgbVatk0BPcWjwP66QddrnEoKVWNEXlMgoHNmnASHzf53DdtMk4Xnn8j5Zz+3Y0i1re13jgQkthkYRKfEeEKKlzh2Y8hCsaoZ5sxbbZUyq7k7QtPA8G0qwa7AQVljUMVFg6zRGlsYxlUODixVvQRAxWdtVgeWiT9bvxX0OJC4Xxb75gEVug+BXnVaohCbgVzJlzT5exRHxwREFlO8Nx4Eu8yzpJz0qANg53SVQKaDyuKC91uLA3P6OqGFC6HyVvRX4jaAuvvHalKrV1kNJbQMs0r4DUTHNULutknwxsAzecqYODpy50C/7lBaA9SmtPCMzYEerEacb2THaCkwNFVejZJ9HZMkQef82t0jXxpUqTDHiQpyzlEWGYeK7HMMyLzBYH9CpbUKLX+8iq9bvt0/y6u4+ajCzkL+C7e6eqerNntnsbD9+0KjRIu2zz3ubY3T+Id91Jqot149Bta2UyFrRJLIPwp3+LmhDS334lQkCy6oEeP5KzQCg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(39860400002)(136003)(186009)(1800799009)(451199024)(41300700001)(478600001)(6666004)(86362001)(31696002)(38100700002)(2616005)(83380400001)(6512007)(53546011)(6506007)(6486002)(26005)(66946007)(66476007)(2906002)(36756003)(66556008)(316002)(6916009)(8936002)(8676002)(5660300002)(31686004)(44832011)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blhqMHdLQ05sUUxMRjNuQUhKMkxiUHQ3NzVPZUp3MkljRFVydVhiOUQ4Vnk2?=
 =?utf-8?B?aHdVRUZJOS9NTTJVOFVkNVRLOHVwMHNIRUhEd2kwcEhNcFRYMUd1T1VMWXhq?=
 =?utf-8?B?NjB4Y05YRG1rWVVXS1ZSQTdxV3lTczg0bFZ0R1RYbVR0NTNMbnNySHhUUjdv?=
 =?utf-8?B?K0FXTkJ1OTJZRVl4dUZreDgzU0Q5dTBwRWR5bDdpU1hndVNtRkwvblp2bUVT?=
 =?utf-8?B?Tm90QVN2dGdic3Vyc1ZhZm5OZm94S2R0dEp2eXVtM1YxZkYyVC9JOEtTdDVm?=
 =?utf-8?B?Uml4RVplVTBvM3pJWml3TkxXYmxybHliazl0WnhMNWx0OEtmWG1mL2JZWnYw?=
 =?utf-8?B?UVRjNHc5UXRyaDJnbW43bVZWRmdsRXJSRlhiUmxvVStMWXJRNmNvcjVGNXMz?=
 =?utf-8?B?K3VYbW4wWk9jMlRvcnlibnQxQ0xYZGRpNEZnREY1VTN5a0dDN08vNkhOeTVH?=
 =?utf-8?B?OGgrb2k5cUlOTlR2c0pBT0hUVHR2MEtnSW16RC9sYjJqMklOajRHZEhLRzF4?=
 =?utf-8?B?ZDZMczNjRjRmeWRtTTZPRFJncDQrY1hLY3VsUXlXYjZpYTc1RnNFOFJJVkpL?=
 =?utf-8?B?aFNNc1VpYkF3SHhMN0EwWUR2S1IvcVArQVlYTGIrMnc4cGVIL1gvc002bjZH?=
 =?utf-8?B?c3BTVi9OWnpLVnZML2x6NWV0VlJsakkzYlZtYjFUV0YzcHNEV1FjbGdwdm9D?=
 =?utf-8?B?dnI0dGFKUk9WL3hDMURWWElPV3pxRjZYaU14SFJXVEtBQkFtSHFVTDkzdjBK?=
 =?utf-8?B?elRPTm9PRlpDU3d2Rk0rVWNRQmQ4UVBZNjVuSWhiNkFWanBBUzFTZ3JsWTN6?=
 =?utf-8?B?N1U5clJBeUhLWG90TlF0enlDeGJGTUhoM0NWTEM4R0I3Vlg0bGRKcFA3Kzgr?=
 =?utf-8?B?VjZ2VTBCbUc4TTlWZUFYOVBkWUdxczg1Z3pvSUJNMXRKbFFNUndjVmlacHgw?=
 =?utf-8?B?Um9Xbi9kZld1eDlHVzVjWDczMGZqdS94b0piS1liOVp5bldJSEE1ZGl0V0hE?=
 =?utf-8?B?RVhmSFZkbUtFUStaRmJ0bWZZaXdoMlpuTTV1UitRbUlEbVVrY0UxZk44ZEpN?=
 =?utf-8?B?blhEVFl2a2d3Tjl1ZjhRNEV4YUF4ME1oS0hRRFJ5WEFlR2lIQi9xcWN5cTNY?=
 =?utf-8?B?MUdMdVI1K1p0aVVxRXo0ZkFVbjMxYmpwTVZJOXhxeExwdDVDSlhIS0YvZW01?=
 =?utf-8?B?ZTZOTC84MGRvRGprcFNFWDBFYUpiSWRIYytxTVRJT0h2K1RXUTkzTDRiTmM2?=
 =?utf-8?B?ZStNQUtXQUt1TnE5OUd5dklRT1ZnTEdzb1AwZmZTRmg2QklnZ2pMNlhOQXdl?=
 =?utf-8?B?N084VDZhNFdoVmhIc3czNTNKZ2RGb05mbjgwMzQ1NEVKUUlBa1FkNDJSdndB?=
 =?utf-8?B?MkMveXJGd3JDcTBCQ3czOUZEUXBCOEc1L2Ywa1laK01UdUtCVnBaSWNQWU11?=
 =?utf-8?B?MXo5d2FLVGtvY3dsaGYrRzVRWmNvSjRTR3h6Zzk3ZUNNNlZaZ2x3Um54dWRp?=
 =?utf-8?B?bWlQbzdzeG9WYmJFcUMrblRmRzVmUVk0d1VIakl3UzNCdFAxaHd6TWl0dlVE?=
 =?utf-8?B?YTl6UE9wZHBTYlFpOEVTSndJSTNaUGJNQTllemlnNFFaVjFHbUQrcG42d29j?=
 =?utf-8?B?SWtpL202alkzS2Z3dE41VXpqRTZ5d0Zxcnh2Rjl5RlpMdFhoaWVMZjBMd1Rp?=
 =?utf-8?B?N3dpbjd5TFA1bzlMeW5oWStaRHBBLzgycXZKQ095L1BzKzh0blJ4TnFEY0pm?=
 =?utf-8?B?bm0wMDVORW5ESDhvQ1l4WjJHRHByclJPTDRQcm1pTVlrNHBMbFViOUhCZGFu?=
 =?utf-8?B?YWRPWEYyWEN5QlUramlyMys4TGxIWE9QcHJ0Z0NTbVBIL25JZ0VNVVBKdmRn?=
 =?utf-8?B?SUJZckRtbmZKV1NLOTN3dytwMjJrQU9acEc1c3FBb3NmOHpBSnByaG9JdUpw?=
 =?utf-8?B?eDEzYWtld2hLbDFRbk1yREJkUzV6K0g1c0tTNExoZWRaT0NKTzZUd2ZIbTlN?=
 =?utf-8?B?MjhPcnR1a3ZVRm82TEtiZnF6NGc4bCtPZEJ6U3RZUVdyZy80MHVTZW9INldR?=
 =?utf-8?B?Nk1lYTUvdlZzaXFwZk5lUHBwMG1PbTFxVTR1aHRTNnhxZHBCVFFydlg3c0lv?=
 =?utf-8?Q?P9FHzhbY9X/+fi/zhoQfWPmz+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 185048de-d1fc-46a2-0a56-08dbae1df6ed
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 14:39:52.6890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 94RRGryJ/CI0HAVVZc2HL/6PRIY519guwqMaxppwyxyEKyBLY54V407h6VvJSNW6H/KboxLrc+2mXHTgXbgNDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8241

Jason,


On 9/5/2023 5:56 PM, Jason Gunthorpe wrote:
> On Tue, Sep 05, 2023 at 11:48:31AM +0530, Vasant Hegde wrote:
> 
>> Reading through the discussion so far again and the other series, my
>> understanding is :
>>   - set_dev_pasid() will check the compatibility and bind device/pasid only if
>> its compatibility. In AMD case we will check against protection domain. Ex:
>>  If we have two devices (devA and devB) in two different protection domain then:
>>    set_dev_pasid(sva_domain, devA, pasidX) - SUCCESS
>>    set_dev_pasid(sva_domain, devB, pasidX) - Compatibility check fail

Here I expect it to fails as devB is in different protection domain. From
invalidation point of view, devA and devB are not compatible. Hence I think it
should fail binding.


>>    Core will allocate new SVA domain (sva_domain_new)
>>    set_dev_pasid(sva_domain_new, devB, pasidX) - SUCCESS
> 
> I don't expect a compatability check to ever fail on an AMD driver -
> what condition do you imagine where re-allocating a SVA domain will
> make it work with a device?

In above scenario. Essentially we will have 1 x 1 mapping between SVA domain to
device protection domain (Here I am referring to the domain that we attached in
attach_device() path).



>>   - We will track mmu notifier and other data required for invalidation in SVA
>> protection domain.
> 
> Yes
>  
>>   - During invalidation, we will retrieve SVA protection domain using mmu
>> notifier. Use device protection domain which was tracked in this SVA domain for
>> invalidation.
> 
> The iommu_domain/protection_domain must NOT be 1:1 with a device. The
> driver must maintain a list of devices attached to the domain, and the
> per-device-attachment parameters like PASID/cache tags/etc.

We want to track SVA protection domain to device protection domain link. So that
invalidation becomes straight.
If we track dev/PASID then I am not sure how we can solve duplicate invalidation
issue that we have today (i. e. if we have two devices within same protection
domain and if we track dev/pasid combinatin, then will call invalidation twice).


> 
> This is very important.
> 
>>> It is not the same, you have this weird sva_pasid thing in here. PASID
>>> is NOT part of the SVA layer.
>>>
>>> The API expects UNMANAGED domains will support PASID attach as well,
>>> that is a significant use case.
>>
>> Can you elaborate the use cases you are referring here?
>>
>> We do have use cases for PASID and PASID+PRI. But I am not aware of any use case
>> for UNMANAGED domain.
> 
> The iommu API is evolving so there are only a few domain types:
> BLOCKED, IDENTITY, PAGING, SVA, OPAQUE
> 
> PAGING is what we today call UNMANAGED/DMA/DMA_FQ

Ok.


> 
> PAGING domains need to support PASID+PRI, in today's language that
> means UNMANAGED domains.
> 
> We have many use cases for PRI support with generic PAGING domains.

What is that usecase? That's what I am trying to understand it better.

> 
> SVA is a special case of a PAGING domain where there is no map/unmap/invalidate
> API and the IO page table comes from a mm_struct.
> 
> Start by making UNMANAGED (aka PAGING) domains work with PASID + PRI
> and then SVA is a very small incremental step.

If there is a real use case then why not? We can do that. But for now we want
the proper SVA to go first.

-Vasant
