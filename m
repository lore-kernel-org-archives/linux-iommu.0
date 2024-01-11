Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE8415AD7
	for <iommu@lists.linux.dev>; Thu, 11 Jan 2024 11:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PgweIj1x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJYKH16PijoXUYrVk6R/rI/UJsBGaphGt/yAxe/msQKBzxUoj+z8tT3GPY+5L83yIrsFTAEXdU/ZjrA2voKV/nHsNKs6H7dK+HxGn4zPMLxFD1pxzBw2xmYmHiIJiIr8QRYB25UXW0LihPGKGqMj1gbfBQaeJz3D9MhiYUdIQ46o+Fctn2Nk/XeyjGipmcSJUq5rVgUZDaOtrw1KREKjIuN7pzcT1mkQUzdxQbhGmnW5W7V3D5aN9cyZBUwu7ShXvnFeCn8N3P0sU6B4JgJaSCe26atviLtRjzBDXlx+wdYlwEAlJvAZE+7JtCdjgFkjqFgXDErOTOVnl0lNm2b+mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjNC6Jy+tyWcaAyMsjK4CPJFK8gXC4AJMQI3zAR7hQ4=;
 b=YUxWgUvOQZzOIWUBpOdr2gfAkpFpfIJHKJIbG/3XMLOVAX3mGr+de+tmQkTL60PwCUOFdImGlRQl6UvF/kR6zn/m6fDp5AYExF6YLkArqtCyM1qcv+dxqj2ccKYH0QKTrVYcAexMHZ1vyENdGfR+lS6MLZqyBtdnbmJfs56W+Q34PDZiJMVYfHpv2/yzOkoYoOuGPafcVk3IL/ROhlT7x9cMqvixOGzriEgoOB9/820xIOYMHXb+9Lj7DZHLMk0HC3ekWAXZzNy/CoJ5CPnz2+uq2IETzsjLefu2I+5wsg2C3FsrxZCop5v47E7VFOlmJ0sDKl4NWC4SA4zm7NQOxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjNC6Jy+tyWcaAyMsjK4CPJFK8gXC4AJMQI3zAR7hQ4=;
 b=PgweIj1x77m6EmhJ2kIVrtAaE6EF6Y8x5/+KiCcnXTiYUtyq764XCYJxJZTLLCHnztNqwzDrSo2vhY+Z192cGmRiaCaODr+EwS9/bz2xf+/E6bWASdG1LApstt41OrTyOyYjA+pM9DxBMAr/0KQYCQUg1SeuDUDTQsCaFrKJr8o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH2PR12MB4924.namprd12.prod.outlook.com (2603:10b6:610:6b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.18; Thu, 11 Jan 2024 11:52:10 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb%2]) with mapi id 15.20.7159.020; Thu, 11 Jan 2024
 11:52:10 +0000
Message-ID: <434bd095-0cbb-8220-66bc-371172a2312f@amd.com>
Date: Thu, 11 Jan 2024 17:22:02 +0530
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
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240105191207.GP50608@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0250.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::15) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH2PR12MB4924:EE_
X-MS-Office365-Filtering-Correlation-Id: c7d27a15-158d-42d2-427a-08dc129bbe75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m3yA9jXXEaLrWmhCvWifZMlgERUXj3RvesD8e9XN9LJCgO0fV1zcM0RdNcPpjjwSnmyvDJUbbtW55c6iFTpuUdNguWRIocSl2Wpql3OKBaXvx7pXDw/u0sEVC5LrGr/B8yt64UUASUZXnp1cPDUUaQPkIA+U+NFPfMmts9kqbwvHT4cxsYBnpbmbPIG5XF1xASPdPbKoIp4thJ6kp7WIboM72yJwBN0DTOH4zgKnVz8mnxFK4KEvSWtrkfa79zN6tr+0Qq2fCofhXBFqc4bowY+JV5v0dJ1OlygCIXC9qxqMh1kDldhtODEvVQa9yTzulbu63/cMNDVIGewk5eZDz1tgCgD6Ga6oZ2pybautp7XRbtQlkdfs67LtHGm/1L/H2Ssy6S3eBSrAyPWYxAxUqM7FAXbeRoVVHAQkIVj3H+JEy/npLe99KKqf5FhFIO7mfUUeTEVkP6zYmRpv0bpDSqVbXaddFC/191eWP1xLqhsIcOavhUE/dhIKBJA2D1McNlb4R2mO88R6/QWBtcZLb75gMl03xQoAMtp8r6iKLyhSKMuzlAcj3N7ocKQCOLCKaj4pe2eeca5NdjpnHifmttaMlqFHkMu8xMTqVVy8e3+Br/gjlWP8pjVUWcZoBbAd+pjFbSqk8xEPfcqKNLSz/A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(39860400002)(346002)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(31696002)(36756003)(41300700001)(2616005)(86362001)(2906002)(26005)(66946007)(66556008)(66476007)(478600001)(8936002)(38100700002)(316002)(6486002)(6506007)(6512007)(5660300002)(53546011)(6666004)(8676002)(6916009)(4326008)(44832011)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzlGSG5lc01kZGV1ZGtDQzRYbGNkQWZSR0l4VlA2MGVOTW55ZXFmbG1ESStD?=
 =?utf-8?B?bUwrUElLakRPNndZSUdIV1BsQU5YUWppSEFWenJuYW1qc255WGpNVkY0VDRF?=
 =?utf-8?B?Unh0V1VPb09qc01mZjN2THdKZjkwemJSbDFIMHB0Z0VTNUV3TngrcnB4Mys4?=
 =?utf-8?B?QVhldDBNTzFvQ25GTzVJR1diUU9Hb2dHTEYvdStNV3dxRm1tNjY5V3NTRnY5?=
 =?utf-8?B?cVRvOXMrSEhtTWVjWlg5K2pxSHpBMXRiamRIUWxDaCtxSFR3VUw3cWEreDFB?=
 =?utf-8?B?ekt4cjRSTXFCKzk4NWI2UStmT1VoNzZwaC9ZUzh6SWhncHA4ZlQzTCtYZXUz?=
 =?utf-8?B?TzBNS0ZjME0vOFNsY0RveVkzbU43c3p6Q2d1NFlVd3lHVGdtVzNyNE9aM3ho?=
 =?utf-8?B?Uzk2ZXRpRE5kQlRYUGlGN2JrVkI5b0lqb1hlYUU3RjlHa095VkpxME5mU3NW?=
 =?utf-8?B?SFl3TFNWQzFXRUNuQUhyOGRUZ1hqaHhsWmdWblZXeHV6R3dkcURoejFocVhB?=
 =?utf-8?B?NndxQ3I5T0FqRDhiOExob0pPZ3JubGE1T2JIS3JlbnJaYmttYjcrOHU1ally?=
 =?utf-8?B?QjNyZlNDODhvZXB0eWx2S2Irdi9kTFdYYWN4N3MrYUYrbFVvaTdEWnFlU2dP?=
 =?utf-8?B?V2s4QjNtcUlIZ2JPTFFobjRJSVpqczREVzVpV2I1eVU3Um1uY25yM3VKUFZq?=
 =?utf-8?B?NllWNHRpSTJlZmFvZHJOZzVFclZSVW9FQ0ZUVUlPMDh4WnRjY0U3V1BvK2NQ?=
 =?utf-8?B?WDg5N1hjZjN6ZjFuL3JEeFBiSDlQM0pQS0I4MlRtV0VKL3NnUGkrQzlVVVpK?=
 =?utf-8?B?ZHd4NzdYV0N6QThlTnNSLzBUY295d1ZUZ0p3N1F1c3VVN1hiUGhpT0p3ZkpE?=
 =?utf-8?B?TTFsRk5DWjRkdmhKbEltWkVQTEFtS0JTZDZNTFJpZmlVSjNJVUNBOUlXd2ZB?=
 =?utf-8?B?V05RRnd5TGM3N1lremhQSndwbGJGeW1XUWhqWjRPbitiQnV6bkVNN1FqeDY0?=
 =?utf-8?B?M3lzWXFUeForWkdYL3RwM3kzdkErc2NMdFNXeThoOHBrVjlwVjFCdDBtSnBr?=
 =?utf-8?B?WUI5QnhyZHBnZFhXVTBFZTV2K1ZsSXZvMEpTY3M1L1BjWGRObzVHVUNlNy9u?=
 =?utf-8?B?bVhDWnFLaVdLVlpuZnU5Q29JVHkrSWxRNTFhZ1Y1dERNTHhJUk5MZjhLOGJn?=
 =?utf-8?B?eGxFUGs1UXQvM29BcllGN3lZeEloNUludHJFWmpwVHNTNEJLRXo1VndDRTZ3?=
 =?utf-8?B?RnJFZmFzbVhjRFRqbXVOcllWNkZrUklObm0zT0JQSXRnZHJSUHFoSUVLNDZq?=
 =?utf-8?B?eS9GSG04eWlFOW1aMlVMa0F3Q2ZJV2RKeWd2MmI3OFFjWjZtdm1MRkhwcFll?=
 =?utf-8?B?R0lKZ25YSEwvc1cvZ1MzQm02TnhLT2IzWWVHRnhOeDBvNEkzVGVMUXJ0dkNq?=
 =?utf-8?B?QTFzYVJaU0xyMTVkR05IRnlwZzhjY3FPdGU4WjlycEdQVFBHd1A5Ti9YVTd5?=
 =?utf-8?B?WHE0TlM0SGNKUWJ2eThkcEhZdTkzWHR1TWhNUllFQkpVc0I1OXhJRzZDbGxB?=
 =?utf-8?B?dkdMSjdDWlJYNFYvSnVrK2M1cG5hK0EyZVVKM0M0U2k5eWpsUVJNTVlWUWtQ?=
 =?utf-8?B?VTd1VDNyL2xKWFlHRWpRVDFqS0d5NTh3dnRvR2dKelZYSCttRGVZVDBzUWNs?=
 =?utf-8?B?OTB6UUpqcjZRcjJmWGZ1SkNML1VZdklyKzArbmRlYmJ0bmpMN0E0U2t3VHEz?=
 =?utf-8?B?VnZZNDRWM0JtT3I5ZURvcGNwNmFneVdQaTVKbjdoLzQrbk9ad1NnZjQ3Rk4r?=
 =?utf-8?B?cGdqdFpEYUlCOXEvaC9Bc2VnRDBFRjkzZTNKV1YvVFdCSDM0a0g1V2oxbm5J?=
 =?utf-8?B?bzkwVmNQSGh3aGE4ME9VcTlpWWpiRnV0QXd1M0ExQkFuWFAza1FkcXh4Z1Rt?=
 =?utf-8?B?TS9vcmc5bytGZWV0cXIveWR1dUJ4UDFvUk1weWcvMktzNDFiRitkWjQ2S044?=
 =?utf-8?B?VjdPWVlkZTdMTk5xbC9GSnd3VlRvbDV1bnB4Y1lLaUJGcldJTys2aEpyOHpD?=
 =?utf-8?B?SXdkVnAxYStrcnVGeXh0aUdlZGxZS25HT0QySFFBTlpCcUFrTWhwUEdrSmY5?=
 =?utf-8?Q?elAeGSNjXHi7KAXTMOMxD3ohr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d27a15-158d-42d2-427a-08dc129bbe75
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 11:52:10.7880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f3ddxIyF8EhJfWR6TWF+i23gjHo79JRlGVE63H2zaD39/RtwGwZWNGPSJjBzQDSKXKkD+8wx6Xm60CBegFLzTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4924



On 1/6/2024 12:42 AM, Jason Gunthorpe wrote:
> On Tue, Dec 12, 2023 at 08:52:18AM +0000, Vasant Hegde wrote:
>> +static int __set_gcr3(struct iommu_dev_data *dev_data,
>> +		      ioasid_t pasid, unsigned long gcr3)
>> +{
> 
> IMHO you've got the ATS layering wrong here.. The ATS invalidation
> should be pushed out by attach/detach functions and has to be
> carefully sequenced with the ATS disable bit in the PCI control
> register. I don't think you can do all of this right with things
> organized like this. Indeed this looks like it over invalidates the
> ATS quite a bit.

Currently if device is capable of ATS we just enable it. Then we invalidate
while setting/clearing GCR3. This is extra invalidation if we always clear the
PASID before using it (as clear path would have invalidated IOTLB).


> 
> You should only need to invalidate prior to doing the enable and when
> a GCR3 value is changed while ATS is turned on, which is something
> that the attach op can caculate.
> 
> So, these functions should have a signature of:
> 
> (struct amd_iommu *iommu, struct struct gcr3_tbl_info *gcr3_info, ...)

Not sure I understood this. This path is adding PASID to devices GCR3 table.
Hence I pass device_data. It will set GCR[PASID] and invalidates TLB (Because
its per device things, we can get the iommu details from dev_data itself).

> 
> [and the locking can implicitly rely on the core's group lock, don't
> need more locks]

I was waiting for group->mutex to export so that I can add lockdep_asset with
that and remove device lock here. May be I can just remove it and expand the
description.

> 
>> +static int __clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
>> +{
>> +	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
>> +	u64 *pte;
>> +
>> +	lockdep_assert_held(&dev_data->lock);
>> +
>> +	pte = __get_gcr3_pte(gcr3_info, pasid, false);
>> +	if (pte == NULL)
>> +		return -EINVAL;
>> +
>> +	*pte = 0;
>> +	amd_iommu_dev_flush_pasid_all(dev_data, pasid);
>> +
>> +	return 0;
>> +}
> 
> What is the point of clear? By the time the attach ops will want to do
> clear it is already certain that a non-zero value was installed in
> pasid, and this doesn't free any memory, so what is the point of
> 'alloc=false'?

This will fetch GCR3[PASID] and clears it.

We use same __get_gcr3_pte() in set/clear path. Hence alloc=false is passed.

-Vasant

> 
> Just do set with a 0 value?
> 
> Jason
