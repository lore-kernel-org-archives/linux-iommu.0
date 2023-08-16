Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194231840
	for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 06:42:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEColRyrWTDEjCuD+WiSLzLrQiTHz+S8eXiwQtnoztRKwguqLvF1czLC5+mCUBc9D5Pgn0U2QFrUBWV1+t0d5HWNCwuTFURMl82Br2DdiqiXMYfnqgdVyoHT5ywA1gYJscCMQXmFWUzO0+PBYKBO4S1iSZssR8wXZY5tKkjFi2vIxHcLrZaqAwwJHMJHGwt493lrxxKakwyLJ+D03lzZWHp734Cl35kK0472qUMyY2amDZdXYZERgdgoMuomWTPWqvFHHnoBnNztUFwZko3PEbQy2LYiBQnfHE0fTDZBHL5Zsz8/LFY1yf6SkXI00HiTOTQiXL48jSgSfIog9CQdRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEj4CKH4qf7zyOPpnPyzcXtQv2uc2RnNuU3USBdP6H4=;
 b=kk21dI/ag5X2+zvirdOU2dDVicpgrPDjGh8l+Py/0xxDUqo3mG+2M54sWFoLO9A4j+PmgBYaCLYAkGnZOOtXUmouS7T13W5783dd3Rezpb/+G8Tqvn8gxFMNVnGNFNufxGqaDz2tAAl5KolJ2sn4NYZGKETERcg3wcuo2rz5NqN43cDhhtGtTO5+wezPB8JJGrUO/GUKc+b+fikRVd2f732H3ho5U4aa75MXPZUyi6HwysQn7EpFJ3nIYdXNYCf8LOUqu7LKOmjMT7o0L9906iB2WvoI466LMH6vMlkWVzQZIafjQu+PkoQy3tyJjD19zYe7xF29qBC868mj8VQSgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEj4CKH4qf7zyOPpnPyzcXtQv2uc2RnNuU3USBdP6H4=;
 b=ydq9wvkZAlOzJCMce1qd6vK1I1ug+owyN1lYKcRFk3DQbVISZsvXps7WgX5vu96JTuPwhIMbfel0hYoimd/TYmtvQuhcHlj2nxvbCWS46O3M7wFVHkRf5axJltPVpMA+ZdKdSldPGUVDHCB5EryOoTjxvo5kA30+emx/oJWnNs0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS0PR12MB7780.namprd12.prod.outlook.com (2603:10b6:8:152::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.29; Wed, 16 Aug 2023 06:42:52 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 06:42:52 +0000
Message-ID: <aa1d48a7-9991-f32f-191a-2e71c623e532@amd.com>
Date: Wed, 16 Aug 2023 12:12:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 08/14] iommu/amd: Consolidate feature detection and
 reporting logic
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230815102202.565012-1-vasant.hegde@amd.com>
 <20230815102202.565012-9-vasant.hegde@amd.com> <ZNvEjom6RD9v8Abc@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZNvEjom6RD9v8Abc@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0197.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::6) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS0PR12MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: 677d1e1a-9c99-467f-595c-08db9e2403b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	M0tyf2VBhq5SPeEXOeLtZloU3HJW7R/yQ9cJWFGz4bBAv4Eh9BEuiT77lVKXppENIPBKSK5dnI8yXv2Yr5FAr4zTbVYLMYihcVb8N5sLGAiSO8hRgIjI5yT1DdfRn/IEFHLLTApcMEUGTDGg2sqZfxYVniuYkjv1ReReOIsbqKLcxw82IMTkk2cetYjfepCPvrFgjAF3anZB/CzRtDpFQO+r8mjhQO15cHcRjq/2zDUOkIKbzAuiJiHy8hAH+GXg/zE7CufA8VRdk2qMxb1tQoLHm8eNjZV1gH+gXIeh0s3tbGpVZ+QuKN/WjeJBUMtRvHDkPJiEVX3gz5ghDgoPr0JM+QNA+OJ0qBzfGE/t64BX0FuLuCboiozda7B/DJK19WNfx+5vUSt9cd/4lZcDEQX15crtpXg2K9qdMxgYXPg70RChEe6jEDeTxWuvgEO/KlT/hZOat+VsE2Ph6VYrH1zsH3/T0SQD2MYItXdBOt5oxSHIXCZyD6aeOckELxHDODb9dH5Dv/RNs0S9i76WXfltpnpwOw6s5gtpmPXBgY4EyPDU3T1piICvurksV83dxB/xzM1du1cB1kEQ87ncfM9zdkmuZ95/ui8XIROw6rGLWqs9uHJ01zIfo6Ma9b98FTGV7lD/ODr1a6X9+ycDsw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(346002)(136003)(1800799009)(451199024)(186009)(6666004)(31686004)(66476007)(66556008)(66946007)(6512007)(6486002)(6506007)(2906002)(478600001)(26005)(6916009)(5660300002)(2616005)(41300700001)(316002)(44832011)(53546011)(8936002)(4326008)(8676002)(38100700002)(36756003)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkM3eGwzYjRvcXV2MlJweC95SkJyNTRPYWFrVGo4aE5tMlVBc045S0thdEhi?=
 =?utf-8?B?d0NrWThXMUlXekJaZ1ZwR01Ya3pQVnZ5NExGdFR5eFdETTNiMGFQdnJlMnA2?=
 =?utf-8?B?VjAwcVl0ZzFOZnNWdm10bWhWRnZvZnFDaUxNZ2xqNnk4c1k3OTZZZkcvaUly?=
 =?utf-8?B?UmtKTm9pL1cvWXduYlhtZnJKbVhwTk01NFF1akpzNFBIeWF0QitIVnJwNlhP?=
 =?utf-8?B?SDN3NmVld3oyckROZ0pYWVFpY2VXd0pnNE5WVTE3eXRNbGhsekJ2TVBoNGVw?=
 =?utf-8?B?ZmdzaHY2cGpVZk00bXZtNkd4N2JramNTMDRFcXJrTnV3REdsZXp4eWRGNkcx?=
 =?utf-8?B?dElJWHJnVGNhMGhhUVJ6ZjRXYStGUWZNdmN5L2J6dE1rbkNCb3phR3dKN0VX?=
 =?utf-8?B?cVd5aSsvV2VmcGlEckhUUUk3ZE9USGUwYWhzdUpxU2hYUGlWOFprTmRsY1VD?=
 =?utf-8?B?MDVZdVIxU01CeGIvdFpWaUxmejhESDFwL1Bhbk10L01UL0VGSTdDb2wzanUw?=
 =?utf-8?B?UEF3d05NUXRyRFlONWE0UDJNRm1BYTh2Rnd1aStVWUxQWVRiV0E3WUZNVU5t?=
 =?utf-8?B?QTJ3OEZPa3ZUNTNXS1VMTFloK001RWNtRFYraGFaQS81TnR4RDRaTGJwWmFn?=
 =?utf-8?B?Mit2T1BSZHZxWnBUSXZWMEkyY2xUdHYyRUhYR2FDUTI2aGwyVmxlYm85b3E1?=
 =?utf-8?B?aS9SQkNvZzQ1Qkd2U0lROVYvVXRnaWxIQ2wwVk9PbkNFaTZqaFUvb0loQzdL?=
 =?utf-8?B?V2RvL1dRUmUrMEZtQ3RCWThVZmVJWDdIczB6SG55ekpzbUpDREFRcEI3VjZ1?=
 =?utf-8?B?OGpPbUdnaEpVbE8zclBieFo0clJjU2tiREt4VXVFRTFFekhyaVcvbUVlTmJE?=
 =?utf-8?B?OFM0M0ZGVFhNSStMQW9HMzcyN1dJb0tYZTJuMXE4VHFoRlhhVVVGVlQ0NEpx?=
 =?utf-8?B?eU42dHJHZXZ4MCtiWGJzMkxJbzdlY3NwcXE5aHNBME5acFZvOU5BMEpDVmRw?=
 =?utf-8?B?K293MDBzaXdKVGllU1M3S3NqV2FjcVdRbVh3cVA0eE9rUmpxaE4rbGZIMEYx?=
 =?utf-8?B?MXNodGhhN1d4c0FUcWZLUlhUc1RQc0JacHNKcHFETXhnUnBWMHBEMXpWNWpV?=
 =?utf-8?B?MndEM3JWSEh0M1FWbWlYa3Fsa1Ntamozb256dE8vYUN2WUZ2dGJCSWpyZ2Mx?=
 =?utf-8?B?Q3RadmJGT0dTM3YzZllFSmd1RWtKczlCbG8xRUxwWHZNemgwcGY0bHBGQUF6?=
 =?utf-8?B?Q2Mrbk9JRFlaVklaUGFRV2ZwQW1xV1h0TlJMclhlYWhKdHk5LzlFZ0VIWC9l?=
 =?utf-8?B?UWYxeVdSNXg5WXowa3NMeWc1eHJxR3VGakdyZVMydnBvdW95SDVXS2JvRDhC?=
 =?utf-8?B?S2xraGU3dGpvOHpxQTQ1MTdCeFVYeWQvSm00ZWJvK0puYjhuZm9hV0JyNHh5?=
 =?utf-8?B?UVl5YkszUnFuSnV6eWJQS0hrYXpWcjdGVm1wRUlWM2o4U1huSjNsc3R4S3dI?=
 =?utf-8?B?NHJEbTdEaXVNNmZuR3k4dTRCWHVhbHlQS21MU3o4aEM1aXJIRVRnMnhFOW8x?=
 =?utf-8?B?TXFhLzBrY2g5ekorRngxMGpKWFVMSGcyaHltQU9BVjQwUXl1c1k3aW9pV05x?=
 =?utf-8?B?WjFza29lbEYyS2pVMEFNVTk3OG9lbUo1N282b3NUcGhjTWNIdzhNZ3N6YlpV?=
 =?utf-8?B?Q21SYU9BMVMvSFhNVURtelFXRkF4T3FucndpcVQ1UmVpZTdHUkZHRWF0L1hs?=
 =?utf-8?B?bXhYRE9ub3BDWjkxbEJPaHZBeVJvaWtPMXJZWUU3VW4wbVRXeUpaUVIydUYv?=
 =?utf-8?B?bGYrZTlReXJ1NUZQK1Naa2NLZWhTWEhqc2YxelBNSkcxNGM0cFBKbGEwelJu?=
 =?utf-8?B?bHVxU0k3dWpXTnkzV1pZelZ4MzBpY01UQkhCQUxwdmc1WVNmL0xxL2lSNTNp?=
 =?utf-8?B?R1UvM01DSWFXM0xJWTU0enVJYXo5UGFpTWxOWVFoMGlZeUlCU0x3d3NBcWty?=
 =?utf-8?B?czcyMEE1eHhCNktKRXl6U0Exdm5nMFErTzFCU01QeVZ6RWo5MGNJRkJOYUJN?=
 =?utf-8?B?b1dWVmxERzdsNkViOU5CMjRXOUtDZ3g3ajRsdmo5b0ZCTng1MVVjWXB3SmND?=
 =?utf-8?Q?tPUhksdpC8kf0tfAUDgorsPoi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 677d1e1a-9c99-467f-595c-08db9e2403b2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 06:42:52.4795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kpy/mH2Nlcmb/3E7DDMJLqYeVhg71WkNq5xPNG2pe/u2GHlhP7LismFQdNQvk67e2n21AtRtFS+4Ep90MFOWfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7780

Jason,

On 8/16/2023 12:01 AM, Jason Gunthorpe wrote:
> On Tue, Aug 15, 2023 at 10:21:56AM +0000, Vasant Hegde wrote:
> 
>> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
>> index 6bf55de9fbeb..242e25ba2f93 100644
>> --- a/drivers/iommu/amd/amd_iommu.h
>> +++ b/drivers/iommu/amd/amd_iommu.h
>> @@ -90,9 +90,19 @@ static inline bool is_rd890_iommu(struct pci_dev *pdev)
>>  	       (pdev->device == PCI_DEVICE_ID_RD890_IOMMU);
>>  }
>>  
>> -static inline bool iommu_feature(struct amd_iommu *iommu, u64 mask)
>> +static inline bool check_feature(u64 mask)
>>  {
>> -	return !!(iommu->features & mask);
>> +	return !!(amd_iommu_efr & mask);
>> +}
>> +
>> +static inline bool check_feature2(u64 mask)
>> +{
>> +	return !!(amd_iommu_efr2 & mask);
>> +}
> 
> You don't need the !! when returning a bool

Sure. Will fix it.

> 
>> @@ -2012,8 +2002,8 @@ static ssize_t amd_iommu_show_features(struct device *dev,
>>  				       struct device_attribute *attr,
>>  				       char *buf)
>>  {
>> -	struct amd_iommu *iommu = dev_to_amd_iommu(dev);
>> -	return sysfs_emit(buf, "%llx:%llx\n", iommu->features2, iommu->features);
>> +	return sysfs_emit(buf, "EFR:%llx, EFR2:%llx\n",
>> +			  amd_iommu_efr, amd_iommu_efr2);
>>  }
>>  static DEVICE_ATTR(features, S_IRUGO, amd_iommu_show_features, NULL);
> 
> Can't do this, sysfs is ABI (and it should have not have returned two
> values in the first place, Greg would reject it)

Correct. Its existing ABI. Will fix it.

-Vasant


