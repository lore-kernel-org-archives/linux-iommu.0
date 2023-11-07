Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E091FD2
	for <iommu@lists.linux.dev>; Tue,  7 Nov 2023 05:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RcTmPUxa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awGExvEuP+g16O1DCD9AEgkMHRKhP+qHOYAswJtNlRK5vgfQST0gWkjNeL3HyhDaXUbLzgcOYFt2cDAe4Tb4m9sQX7Y1Wj9upVXYDWndRhZw2ijdigxqjpRyb5CnqISw8mg4uCzPCtL4+SHdlxEGDrbZReWNA6mb0AAp2rsi/BxwLqcOxISWs3YQT7EMxS9m2tc+J7AXqv4hse0658ZLrhF17P5nUvfCzMr1LixYvN1nvz+D2itp8MfU+1RcTIzXP/VWDdZbY4PRksuHo2rD0Dnr/BqHva/GP556kRPuDw21oLBLGnlwdJdbKJFg/Of8aAMt0kUwlUQ9Bd8qYigF7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdY/kJ5sU/QQpvj0FqBqEllPBuZszLEs+9pWpE5GJfw=;
 b=PI5Y34CuRm4yVaywagjl9l3kFD//gAqukEZnBnxHpt1m+Hnt862tT/qL6gmE6PokE6gLuYFxC/fY3JByDZ9LJ4Gue3yfDC3voMFELNj00+H/UhvjlX9gaZ75GqVG7zHXKuLD1wsLSNu8vj09+Jzpsr1IJdUTlxGZCQ9ppd2CmczZvV998YAZq4+CFjuNG/+kkQOydWW4OdUyUJSn6U2qSC4f9Dykcgs9JMJqBD/9lWFqPI1SDQHPHCG6wZzuSlN0i9bImFzxXn12bmknXF+ygFRsXFPUdUb+5GDteAJeCvon31M1ZPlLK9ESoamXmjgQxjWmidln3JLRdoUS68+qWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdY/kJ5sU/QQpvj0FqBqEllPBuZszLEs+9pWpE5GJfw=;
 b=RcTmPUxa5+H3tgGKzLRTvVctK++9yn+KTithm+qaMy8kfYJzN1B2hRQ/qvbgRee1qqKZj9mN4W6H9ZR1G5sUj4MJ/snIxkMX8w8if4uMxxPbc+xoT5Ka/MLvy+yPjosaCG4986qUnfIhToqXV37DaVNHERjCLPNXEWwnkPfw5Og=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SN7PR12MB7274.namprd12.prod.outlook.com (2603:10b6:806:2ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Tue, 7 Nov
 2023 05:55:57 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af%3]) with mapi id 15.20.6954.029; Tue, 7 Nov 2023
 05:55:57 +0000
Message-ID: <f23aaa41-b22e-b274-5774-6317ba643e8a@amd.com>
Date: Tue, 7 Nov 2023 11:25:49 +0530
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
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20231106172931.GM4634@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0022.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::23) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SN7PR12MB7274:EE_
X-MS-Office365-Filtering-Correlation-Id: a38e9906-0fc4-465a-5a6c-08dbdf5635ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BX0vWDU607pGcsGf+C/IJ0LxZgsTWmVZwA/DeP5w3cPrNGp7kKwQ3SxTHkf49JLM1xN46hFV7Faq68srv5HSZbLQsm0OpJ3y2JIomBRKHOm6M81VlQgabWPGvN9TUBHGtLSc+2l4USDxevc6TOk47bSwU1SoLNrqgrhUUDIGbCcD65zKD/QIxLtPkUzknVnwaoyH39estmTjv+YTTs/9OJsU81ZuYfsAKQJmvpJgiQVOH8s/vRemU1jr/+hPkqQZwZOnC2z4DDgmtXHYfq2lo4cLImdYrWWOfH2oGS+cS6Y3I9fefVLfg8oWO8Tu+y/iXOEKx37xx6kSSlmC9qHYOAeBUyhOqcS0/1UKAVCjeZLH38nz9bOE2QdLx8lilzbuDhaBKRKa1Px73TpvQzs9DjyhCShtsu5WaTVtqutX8TS8ALq2UUHXlfXF8JQOEZOyBsTd1/Y1PBZIfC/uWIEAAWixKBbd4gDJFP1u1yXUdSO7+4VNg1EEeDJMWy9jsyAgsebUoWsm30kbEI/gFdwlwICbK/DicAurDcPFMRNS2j9Hral2W5BCqtYsHeq8Qv7QpOv0vL00QMZvTP/SAMvmzwXLIhNbi7Yllma13QSV3SJt6UhUOPvn63JiKhLbR9ZfjkOVkqvpqjJQaW4T4pEpeA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(366004)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(38100700002)(6666004)(6506007)(53546011)(83380400001)(31686004)(6512007)(4326008)(2616005)(36756003)(2906002)(41300700001)(86362001)(31696002)(5660300002)(6486002)(8936002)(6916009)(66476007)(66556008)(66946007)(44832011)(316002)(26005)(478600001)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnFrSDFWUkk0NHpXdTh4bGtvUFlOTmt1cmpxRmVrOFU3QUFLWWhXY0VySEVV?=
 =?utf-8?B?VG1rdFVZN3Y5dExuc1hUalBvMGVjYWk3czAvTU9xcGUvbGxtV1Z1M25qQVdz?=
 =?utf-8?B?aEFGZjBrdXZTZG5XNENzV0dWb0VFSXFyV2lMRVc1QjBUbm5BSGdwYU5QTUJ0?=
 =?utf-8?B?UkNPYWIxT2lINlhVckFSUkUyeG10cmNqV3NBbGxoejFDRy94bjJGUnJ3VWg4?=
 =?utf-8?B?Zk44TXlDV3RUckZUcWI4M0JMcnIyckYzNnNrUUFKV09NUmtUdUp4b1JCN3ht?=
 =?utf-8?B?U0dtYzNWZjlWMngzTFlVc3hSTlFXd3lMenBQMmovQm5wRFNuYjVmU213MnBJ?=
 =?utf-8?B?YkpSck1lOFVHWU9CMGRndmYzVzgxeUl1Smw3MTFwVWRVOFFMMUQrZGtuV0Iy?=
 =?utf-8?B?THZtT0JjUndMeGtwOVlkSjlramZQNVNTejFtUUtuYXoxMkRrVXJ0ZElaVUxn?=
 =?utf-8?B?Vjg5VER4TWt1WnUzaW9uRkRMc2dmSDBWekJGY1NoVWlWd3kyRVp6SlpmZzRl?=
 =?utf-8?B?NStKbWRGOVN4YU1VMWN1dDh0Vk5FSHZLWXdVa1pYZWpzaU1UTng4Qk1uakls?=
 =?utf-8?B?V3FoYUZMVlBtSk93THVSNUdpdzd5eG1GZzRlRzlsS2R1c3YyaTZrU3VNcFRT?=
 =?utf-8?B?d1dNdkxqVUlrWXlUZjY3QWswWnFCRlZaYTJ0S3Nsc1JNcTZvWWdIOW1mcUQv?=
 =?utf-8?B?Vm9rRS9YUWdXSHk2YTBWYm5uR2t3dS9OdGhoMGVqV242dDE1TjIzNk1DV3Vp?=
 =?utf-8?B?a2UrNFVYRkwveHFHRWh2aTNialVuTk5iSS81OTVwb3JRUThZdFk1em5zZHBN?=
 =?utf-8?B?YktMTWVvd25tQlZGOGZpYzIybUZDYXhmZm8xR2hkcmdCNzhJV3BadHFSZWNh?=
 =?utf-8?B?THJuWUFxMTdrSGhGaURnalVvdll6MytoVTlqWXV6cWlQT3RFVis4bWVVbnJi?=
 =?utf-8?B?TERud21zWUEvR1JLYnBodncvUEhEMEd4eGsyRittR245V2ZPbkQxZE9lb2JK?=
 =?utf-8?B?NmtEYjdrY3Z0cHFuN1ppSElPald4NzdlSVAvenhsWUpaKy83YWxVS1lVd2Q1?=
 =?utf-8?B?YzVYbXQ3VXI5Nkh3WVFLTXBxQW5tRGdlMlB6RWIwKzRtL1U4QTJMT21CSWZ3?=
 =?utf-8?B?YXdPcTdPYTE4eE1ERkZTZktGNXhrK2VrOXRGMkJQbFVxV3lBTm04UnhUeXdi?=
 =?utf-8?B?UjNSd1gwWjhxWmhhb045Ky9JSVkxVzlNeGZzbmswVkd6aGpTSW15U0lTS05t?=
 =?utf-8?B?ZHQzYk9GbUNveWZmeVVpanl0b1crbWNoejVRblVDNTY3NXZiV2FnYk0rM1Fk?=
 =?utf-8?B?MFIycGtucG9qVFRsTFA2dTd1Rk81V3QvSHZQa1F5dVBvdTNwOWFYdXBHOVpp?=
 =?utf-8?B?ckNXQk5TaDVyV3dvam9ldEQ3TW43Rks3T1ZhNi9Da1hlQzBzWHZ5UDNGdWpF?=
 =?utf-8?B?OXZxRVB0SVJzWUNzdVJ1OTkvL204dSs1UHE4VkhRdTZTWVZPdXhkL2VIOXE0?=
 =?utf-8?B?aWJmd2piRm9aL1FBSXhEVDkvNFZDZERGRWk0dm8rUURXVDlKdE9VcTZ0Tkti?=
 =?utf-8?B?Q093cXg3V21XSlNWVnA3NUZJdWRHbFI1Zkc4Q0dhaFVJZXhBc1RBczdpaVVU?=
 =?utf-8?B?b2FDaG9XcENBWUp2b3dIdW1kZGMzNlV6QllqRkJOcm5JU0FabE9YaTgxV2cr?=
 =?utf-8?B?UnpQOTNVS2pUNW1pSHRtcExuRWRmUVFIcVZwZk81U1ZUUHBDWVg3L2JRYlQv?=
 =?utf-8?B?YVVDTW1aRWI5c2hkZ01oaXVuRHdpeXlZU2hwcXM1RTJXNENCc010QkdWZHNv?=
 =?utf-8?B?eUlYbG1RZmRzMXVCdkRtT2c5WkZMeWdmRU8wbTR2UnpOdk9TM0lnVm9LbjYv?=
 =?utf-8?B?VmxQTzM3SXB3ZWd6cHNlS245M1lzRmtUMUZRelgzdUFvbTBlekhueHlJUThj?=
 =?utf-8?B?Z1RkMVJwcFpRTkJCT2Q5M0xCSlpCV3dDWFE2eXhpd2J0eVRlQnEzRnluOE5s?=
 =?utf-8?B?VVlUdGhSa3ZrRHFrM2o5YnhHWUxiOFRJNTZONDROUEdQTGZJWUY0L2ltWnB5?=
 =?utf-8?B?SDFvSE5CUUlobzNUM1FSN2w2NzFhTEhWR3p2QnZRelhrL2VOOVVETGxtRFdq?=
 =?utf-8?Q?ITlhusFP9aKbwtylWtuNhzPcz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a38e9906-0fc4-465a-5a6c-08dbdf5635ec
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 05:55:57.1041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: la63t+p3FP7ITSQX1d387M3wCXXLHd54aGcYldv+c6YqDXR16qziVx5p4zI5yhF4ilpquztQC2puEElkHrr6Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7274



On 11/6/2023 10:59 PM, Jason Gunthorpe wrote:
> On Fri, Oct 13, 2023 at 03:16:49PM +0000, Vasant Hegde wrote:
>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>
>> To use the new helper function for setting up GCR3 table.
>>
>> If system is booted with V2 page table then setup default GCR3 with
>> domain GCR3 pointer. 
> 
> Lets stop talking about "booted with V2 page table" - "If the domain
> uses the V2 format then setup a GCR3 table in the device to point to it"
> 
>> +static int _init_gcr3_tbl(struct iommu_dev_data *dev_data)
>> +{
>> +	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
>> +
>> +	/* By default, GCR3 is set to support non-PASID devices. */
>> +	gcr3_info->giov = true;
> 
> I admit I find it really hard to read the AMD spec here.. In terms of

Sorry. I can't help.

> the SW model what modes are actually supportable by HW?
> 
> No PASIDs being used:
>  RID domain=IDENTITY - yes [V=0]

That's still valid. DTE[V]=1

>  RID domain=BLOCKED - yes [V=1, TV=1, GV=0, mode == 0]

May be TV=1 is valid here, but I am not too sure. I am yet to explore this one.
Rest of the flags are fine.

>  RID domain=v1 - Yes [V=1, TV=1, GV=0, mode != 0]
>  RID domain=v2 - Yes [V=1, TV=0, GV=1, GIOV=1]

TV=1. Rest of the flags are fine.


> 
> Some kind of PASID in use:
>  RID domain=v2 & PASID - Yes [V=1, TV=0, GV=1, GIOV=1]

Correct.

>  RID domain=V1 & PASID - No??

Correct. No PASID support.

>  RID domain=IDENTITY & PASID - ?? [V=1, TV=1 GV=1, mode=0, GIOV=0] (Section 2.2.7.1?)

This is supported.

>  RID domain=BLOCKED & PASID - ?? [V=1, TV=0, GV=1, GIOV=1 with GCR3 entry 0 being non-valid] 

I haven't thought this scenario. Why do we even need this case?

> 
> Did I get it right? If so GIOV should ultimately be deduced based on
> what domain the RID has?
> 
> Look at how the SMMUv3 stuff ended up. Their STE is the same purpose
> as the AMD DTE. There are alot of combinations here, it was hard to
> make a code flow that was clean. It turned out pretty good when the
> DTE was generated in the ops->attach based on a calculation of exactly
> what the current configuration is, because we already know what we are
> in alot of detail at that point.
> 
> eg we know if we are attaching an identity domain and PASIDs are in
> use that a single specific DTE should be created. So just call a
> function directly to get the required DTE.
> 
> IOW - I'm not sure it really makes logical sense to store giov in
> gcr3_info.

We had a choice of having a giov flag inside gcr3_info as it tells how to
configure GCR3 related bits in DTE -OR- having a extra logic to calculate it
every time. I can be calculated.


> 
>> +static int do_attach(struct iommu_dev_data *dev_data,
>> +		     struct protection_domain *domain)
>>  {
>>  	struct amd_iommu *iommu;
>> +	int ret = 0;
>>  
>>  	iommu = get_amd_iommu_from_dev(dev_data->dev);
>>  	if (!iommu)
>> -		return;
>> +		return -EINVAL;
> 
> iommu can't be null here, have a dev_data.

Fixed.

> 
>>  	dev_data->domain = domain;
>> @@ -2080,11 +2103,27 @@ static void do_attach(struct iommu_dev_data *dev_data,
>>  	if (domain_id_is_per_dev(domain))
>>  		dev_data->domid = domain_id_alloc();
> 
> At some point this is the wrong place to put this, the domain ID is
> logically associated with the gcr3 table, it should never be used if
> there is no gcr table allocated, and it should be freed once the gcr3
> table is freed.

Domain ID is decided based on page table type (and may be based on PASID later).
 That's why I have a function to decide whether to allocate ID or not and it
should be done in this path only. So that we can configure DTE.



> 
>> +	/* Init GCR3 table */
>> +	if (domain->pd_mode == PD_MODE_V2) {
> 
> Is there a case where domain_id_is_per_dev() but we are attaching a v1
> table?

Not today.

-Vasant
