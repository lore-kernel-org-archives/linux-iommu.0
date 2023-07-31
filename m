Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD4C18B09
	for <iommu@lists.linux.dev>; Mon, 31 Jul 2023 16:04:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWn4eaVdj+P+2JyWhK/vWsH4yQ7FTpKlmJJ8FA5QJGVdIxyEE/scEkkDq/6++XaWcGFGi0tJkRHi99+M5B2RWObo9hsj386mtzV/Ylr0d0Ekbnwyui78nv5F3MlUFgTakx9mhanMxQry04OSwNobJcuzOgFjPkYkJpra6XWAQEP2kzaZEv6BcVmr39V3Kme+4q83iOKLRtSmoeBsrDYnNBr9Lz6lp6qACeWOzlBtLQSOhn1ntVDcIyfLMqV6SeSa0gPqvFE94R9Yxenaf6pZSguu3U91Ztx2w9O2zmGft1Epra03rbK+cTwDQ64Lc1Bz6t37WaoNb2Im87ytGcbVZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQzwIjJiIr7rGJwUm+8TEyjyWwrwdu7xVXhsFRZaE3I=;
 b=E9CT5CUeMclFjg/xpuI3e6nxh8cpfbQrtl4VGTC3wUZKtI0BPuQGiTOiLHnx54uvr/Q0bPH0QKh/TGbUeS5MkZ450bKSFLoXBlCiuXYnn4VPNyb2g7kiyYGA6bK+arMEk/SGtUdIz5Sojg9lAjdz+cD5HKDkoEmAn79VwzgxtikhlzJTm5JG9ib6BJFZq5QDmjWRVfaP0vOsb/tJcKu8fpCXQRp1c2QviDndFKAKcSelRd7zbYtrQ2s5KRKGxOvrNHqUHcjG4Wm3+4WAiEeW9wTJKQT49PG89qSrFwR44o9NAynbKZPNR+J+fs0u4uXDVDGIjddGC1KERyn2wwVhSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQzwIjJiIr7rGJwUm+8TEyjyWwrwdu7xVXhsFRZaE3I=;
 b=eRqFk6LMhZfSymL1Oa/puWvSKyGG9Pz4wuRBGJhYZ7D6ha8FfwPtLyE3EQeGP+/VCufB8pg43LUce+2zf5rVAQ0sHzFqupHx+0ry6J4/wZzdtlQqLYLWmD5sClxfwyr/cvV0QN6cDjFzwu8CnDttmqowmUL+JYpeEhqzBVnNK/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH2PR12MB4120.namprd12.prod.outlook.com (2603:10b6:610:7b::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.44; Mon, 31 Jul 2023 16:04:43 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 16:04:43 +0000
Message-ID: <965e5cf2-6a29-0d5b-ad3b-ecabdc3923d4@amd.com>
Date: Mon, 31 Jul 2023 21:34:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 15/16] iommu/amd: Initialize iommu_device->max_pasids
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230728053609.165183-1-vasant.hegde@amd.com>
 <20230728053609.165183-16-vasant.hegde@amd.com> <ZMPUufoPxZgFwx0w@ziepe.ca>
 <b5bb3e1e-a933-a04c-53e5-bb05c3ad38c1@amd.com> <ZMej6GCFu6TJgOY/@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZMej6GCFu6TJgOY/@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0085.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::30) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH2PR12MB4120:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b12f4b1-6666-42a1-215c-08db91dfda2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zobVyXvqpqz/KB78L4qggaoMg1dx5qsYTtLnxeNTiF0NBx23U/QDbFhn4IX5OXyZPn1GpRKItGLZTjJQZJeREb/BHlTLnRnjKqLb5aNIC2vdupu2xNXRqSx7ltRRmtQsLCbDSwOjAPeDV8njzb+zemDBBMYic34idCDMfE1Y35tTg/FbZDegjNr4bMoTcWzKP5hI+0tTfK7yObcSHaZqxP0F7GnsFNbxd7K3otHDaPcCV8nKCNKnVudcmbPjejQb3YjxlYbQkPtH2Af9+AVAiJiaUaaApBEKv6yD6+UMemGOLP0IAFfk0G23n08PqhYqrLSZqU5gwF33PNzt5VyoJQJhUmVUE6x3iwfDfneJxIySLlAvlbNkA6i+jdiSmZQjlW5NgAlHqBHdwtRbgwjg9oeP8CA8g3k+PHAF/4t3tWwAifCpYWcphTE64jdtTLzsN39dRvjl9lTLPaaTb7ui1LA/Ie7lke4kOAFTrntbsYVVXnBKGn1BUpQ5sQbBzNWK+sLLzp+dsokZ/Sf+WURzu3qnYY/w5nqjINb2Jlb5c0Isw0MkoAd1XK2jWX2WcMfBmG/CVpg/M3oQrjVKLer9Q/uMdOwLw5BNUMOhrfUlr/8T2Udxcw8YZWdERn8AQFfI6kKFBz0Y8F8Fp8YOWqAOig==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(451199021)(31686004)(6506007)(53546011)(186003)(26005)(2906002)(38100700002)(36756003)(44832011)(66556008)(66476007)(66946007)(6916009)(4326008)(316002)(6512007)(2616005)(478600001)(6486002)(86362001)(41300700001)(31696002)(8676002)(5660300002)(6666004)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkVYOSt6UXpHSzRtMmtzb0t6NmVDM3dJRWlBUVMvNjV2STREL0gzUzhDdU93?=
 =?utf-8?B?Zzk4bjlKRFc3UGVkeUhXZzl2U1VpMDlITi9ZMmJSaDBLcEpnT1o4RTAyU001?=
 =?utf-8?B?YmNJdWxqU005bjI3aEszYUtNbkVHYXdQblZxOEp3Rk94ZjhLSHVmSm5ERzYz?=
 =?utf-8?B?V21rRWZyeXcxTldYUXRKWko0c2Z4SVQxQnlrbzk1QmtlK0kzTzdrdzVJTVJz?=
 =?utf-8?B?NkV6WWF3aHA4TCtIRTRpQTZ2NHAyakNRTkwvZWQwcExNcTE0eTR4LzN4Z1Ax?=
 =?utf-8?B?Ujk4Z1VBa2hpbkpSbFR6M2FRT01EemJ1VkJZc2FTZDN6emxzQ2xHY0swTmZI?=
 =?utf-8?B?eVd5VVZOenVRcmtmdW5iTzNUb2dDOVpKZHd3bTF4VU5NaGNrN3VtOEtxbWpK?=
 =?utf-8?B?L0c0R2FqNXdaZzZ1Q2hKUEFscWNOMHBqSnJkcjRTb2k3RS9US2pYbExrZE96?=
 =?utf-8?B?U0l5KzVRZHhLdkVkNG51aXdlSTBSd0NZYVdDZEJYYTIwZmc4UGhFdFYvNGIy?=
 =?utf-8?B?cVBNbFQxSGUvbGxDOGRMMURBMDViendkRnJ5MTIzZjBoZWUwaFc2bUthMno4?=
 =?utf-8?B?dlFPbzVhY0JENkpkckZEdEF3cTJXaFo1SGlRT04zYjEvQ2h4TVdLU2c2Yjh6?=
 =?utf-8?B?bnE1RTVtcitaeStSUHl6N0Zib0F6L044eXFTeWF0VEVZa0p2V09iSlhiK2ox?=
 =?utf-8?B?YzBLUFQ1b2hJRTdxYXlkU2dsMGdjTDJUSHZiajNWaE1MU1BBMHlNS24rOWd0?=
 =?utf-8?B?NHUwaWczR1Flc2U5L3k1cmllMTdCaDJNbTRkcjAxc3FNbEJYMDJRQURGUUtq?=
 =?utf-8?B?QmZ2K1M0dFFmT3BHMkwzZUJHaUxySWJtQ25udW9jZDdtQUxVSEdvYWNDNHAz?=
 =?utf-8?B?L0E5MmhBclRLZEJ5bnAwZUEyNEhvWWVQYjJMSEoyZDIvQkdmR1cxV2FTb2tj?=
 =?utf-8?B?KzJjTUpDS2I0alVQbXR2Z2Q3R3ZoOCtNcCtOaWZabEJTRkdRejJkUktpbWpn?=
 =?utf-8?B?TlJTUlZ2akI0dFBGV2NhNzVLVVVNMDdyWVBkQ2RnSFBnRlprbVZ6V0F0YlNB?=
 =?utf-8?B?cm5xdEVyc08rM2pDZ29kRFRSQ0pHZFRlRGxncUdrdk9VbWsyOWpIWm0veHhU?=
 =?utf-8?B?NXN3ZloxSjFaM0o1YmZ0REhCU1hUdFBKYUNLTVkxVy9yYUoxSFNSb1o3OGI3?=
 =?utf-8?B?MjlUMTl3WkoyUktmTkYzeEJ3N05tV3kzUEtiK05VYitLVHFSek42THg3SmNX?=
 =?utf-8?B?SE9Zd1VNK2xGb2JtUWN5bVAwN0M0U2I0QTZtdkF4NVhqMEZTNE5qWE56NC9U?=
 =?utf-8?B?RlBTbXRabmhjelhWcEp4NE00WFUxV3RUd2VOZGthVFptWmZzcWl3OG9zaGVR?=
 =?utf-8?B?VUQyTnYzMnZHbFdJclVCUnE0d3VYdW9YeXRIL3pVeE1xK0wwZTNDMTVMRGYw?=
 =?utf-8?B?YVNBemhzYUcyT25GampzL2twaXV0Z25reUt3Qm9SR3gyWEQxcmNaRzBVRDc2?=
 =?utf-8?B?SFZGckFUdG5hbHN5bkxaSDRybm95blMzZGt3enh1WnozcUVOaWJCM3I0UG02?=
 =?utf-8?B?VzVKZlp1YkVrYVBxUEhmZ2RYbERyTHhhSHlYeHVSTXRXREs4dHhuMjRKaXM1?=
 =?utf-8?B?YzZXWkljY0ZWZVoxUENnMjQzcFBkUElsOHJnSkUxRjdkcG5aSkdDSlBBcFpR?=
 =?utf-8?B?VXYvMVZUQXBMSHloYmgrTWM1TUluT0NhWEYwbXJxc2NxU29SZHNzTllIWE4z?=
 =?utf-8?B?cFFGeXpOL3E2OS9qSXVvZ0QyOTE4M1BNSTRQamFVeVNTaHA4S3FFN1VUQVIz?=
 =?utf-8?B?Z1NVU203eHluT2syVUtPWUp2MHplK3FlYXZSM2thME1YZjdFMzlkUm1JVURi?=
 =?utf-8?B?NWp6VVZOZVlBRWVUcnJOUFdVNnlCUzBtQWdXTE5qNFN1bGRLVjlXdmVRZW8v?=
 =?utf-8?B?aDlrb1ViY0lVTzJ6Ni9LR282Y0N5NjRFVmlMOVplSGtJcmVGazByaG1uVEYz?=
 =?utf-8?B?emhreHI2U21KbktJb0JJWVlDMkUvQUYzVXBGd3Q0M3EzdmxXMHZ1dEk0YU1G?=
 =?utf-8?B?RjRsaTEvUExyYjZieHppV2ZmZXk2c0dXcllZWTkzTjZZOU52cUNFRndOQnZJ?=
 =?utf-8?Q?EEzC2GkXy/AoFVbgDk+8mhNKf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b12f4b1-6666-42a1-215c-08db91dfda2a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 16:04:43.1197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hD4TSnRtyABGlWwZKzGa6jIaem2av4oWhXxtE0GJ9ok56j178ZhbtB9QuImVwc1UQyEbIgXq7ci4s0NLYmJegA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4120

Hi Jason,


On 7/31/2023 5:37 PM, Jason Gunthorpe wrote:
> On Mon, Jul 31, 2023 at 12:33:18PM +0530, Vasant Hegde wrote:
>> On 7/28/2023 8:16 PM, Jason Gunthorpe wrote:
>>> On Fri, Jul 28, 2023 at 05:36:08AM +0000, Vasant Hegde wrote:
>>>> Commit 1adf3cc20d69 ("iommu: Add max_pasids field in struct iommu_device")
>>>> introduced a variable struct iommu_device.max_pasids to track max
>>>> PASIDS supported by each IOMMU.
>>>>
>>>> Let us initialize this field for AMD IOMMU. IOMMU core will use this value
>>>> to set max PASIDs per device (see __iommu_probe_device()).
>>>>
>>>> Also remove unused global 'amd_iommu_max_pasid' variable.
>>>>
>>>> Finally current code restricts max PASIDs to 16 bits and calls BUG_ON if
>>>> max PASID is more than 16bit. This patch replaces BUG_ON with WARN_ON
>>>> as system can continue to work with 16-bit PASID.
>>>
>>>>  		pasmax = iommu->features & FEATURE_PASID_MASK;
>>>>  		pasmax >>= FEATURE_PASID_SHIFT;
>>>> -		max_pasid  = (1 << (pasmax + 1)) - 1;
>>>
>>> This can be up to (1<<32)-1
>>>
>>>> -
>>>> -		amd_iommu_max_pasid = min(amd_iommu_max_pasid, max_pasid);
>>>> +		iommu->iommu.max_pasids = (1 << (pasmax + 1)) - 1;
>>>
>>> So why not
>>>
>>>    	iommu->iommu.max_pasids = min((1 << (pasmax + 1)) - 1, PASID_MAX)
>>
>> Because some older chips had support upto 16bit PASID only.
> 
> Sure, but I mean why not just directly cap it to PASID_MAX and not
> bother with the WARN? If you WARN then a new chip reporting > 16 bits
> of PASID support will cause pointless WARN_ONs at boot time even
> though the driver will run fine?

Sure. I can get rid of WARN_ON and make it work.

-Vasant
