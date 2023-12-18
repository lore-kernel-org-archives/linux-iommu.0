Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607456FA4
	for <iommu@lists.linux.dev>; Mon, 18 Dec 2023 05:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X60/YJ5b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbXbqxxZX4LM3YD9ougITo35upTjV4kUAeAXGeKOtonb80/nT/FFLy6LBN8ernVr0++7raMp7ycuowL/EeKd0KJf0Vj71Ui+3OLo3OWh/VZbMrXD4kOmQ9+NGzEe282ci/lv1hUmnXG2xMWMv+66+bV1GOeYu7Km1KdTHjyLR/ayHDdEEoNRA6hgblM81eO0PK7vG2a87MOUf9Gz/Z8bV75EnaDw3x2/zk8gxsr22dyVK1FLpTV20PoRxRlwM3pN7WATx8TLfuKTy87dWcb71oNVXs8akx7m57PN0pAZpcUHEuK4iPVYo4vM2YrF3WOPdQMKs2jZcmJm0Et7SQtt5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TMa45bKckvRurshno2XjLcO7R9JLmCeCAzMEn+FJHY=;
 b=N0j0FKdZlfD3OtiAHJce6jovJ+QSCEqRzo2dZbdPYoY9JSBnQXrYqdT0uwOOmMvKkZfB1/rkAdLawfTh3lVm+fcxfPnosdzMQpLQ4SDSXn/IWSkbdKDvdHgkR/gB8KYPJI/S00mKuLSu7zR6umsiOVdfp4NM8LLQzzWjsXhu5buXungsVsXknWkZeNqPI1miLskLinZ5cEBCQDYZ9qcs2PdYFUquq0lxz7digoBxELWqRN93f433xjA25KMHm8Y2oWz7Lz+oX5gIBYRrUHi98BGGvtElews2jorLmRiOvw7hdojjE5zdqBuHEasjFdVWDeTdgkvXWoo/TlQJ/zDDNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TMa45bKckvRurshno2XjLcO7R9JLmCeCAzMEn+FJHY=;
 b=X60/YJ5brPuiYib4t9JyAomYZV3y6+NL2qbAYpf7rKVkCWlJC0rn/W722fthprXiOI1QpLrUSKJ0IHJbQJsE4oiR0tqw0PytUFRpLZkTQwOwh2zP6gArRmNzgbi05fDERu5laH1wSbuxLev+HjbjMp2yUOSvVBbLcVGOeSjTXbM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 BN9PR12MB5242.namprd12.prod.outlook.com (2603:10b6:408:11f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 05:17:18 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af%3]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 05:17:18 +0000
Message-ID: <dc09cd83-05be-bebd-1855-7393151f6d33@amd.com>
Date: Mon, 18 Dec 2023 10:47:10 +0530
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
 <d99a1d56-6b29-53e8-1d2b-564a56548009@amd.com>
 <20231130175523.GH1394392@ziepe.ca>
 <246e909b-e020-f1f5-deb0-f48d68cad537@amd.com>
 <20231212145912.GB3013885@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20231212145912.GB3013885@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0133.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::15) To IA1PR12MB6043.namprd12.prod.outlook.com
 (2603:10b6:208:3d5::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|BN9PR12MB5242:EE_
X-MS-Office365-Filtering-Correlation-Id: 24850ca2-9c78-476e-cda6-08dbff889a0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bNm4gK6Aapowiand8U1W9JXeB2NFi9qvY2jPr2eChO/ug+lMfnud5HpjNTksahn9XdLoMttQ/lKDLs4TyonO0wl2mAz1tWyYrqlf9OK5wvQkyM/pUI4C9sXtnqKph9wChlDG1eRvdcD/NeQzmyOkryLD5PyVVVejaGGkdTbUHyZTGwEKgVZgAMCkIWm9FZ7vr+K/l8N94crtg+7kztLEW0/6IYZyzQZHKAUTfJeK3y/QLCMzLv86iUtIOwVJQITsef3jSiuypPrn1aOF8vdLY//O18aqa6cxyh2gYe6bqZVrwmy6b77V4Zvf3+TzofYrE6V7ECuaI8HFCjdJjzR2BU5kc3DNacw1RiwCE/N4BfwELVvLyxFqsJMYcnL9iWHwPVHoPCYQ+9jyytsJiHmlF7+c7yPH2LcezQtrPw/BraOyqWnFX9CfUWjmZD/zZzmx0SK50Tf/PQ7mMpSys+bw1eE2fDVKBhtlxlpCnfr8agqtN2VAbc0i7uzNOxvkfG9317Mqw6S+0j4VYjMxUFrmscpiLYE6YtEzuYR+KFc9JqD9bMexXWBInXx0cviRt/imQZXQ/J5OxjOPQE/CoZSUU8G2qeHwRp4yCMYaTTLmfRygam4wlHroV34HYNO/zwKcxopLPhYtsnfXBuxZ5s7RCg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(376002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(26005)(2616005)(36756003)(31696002)(86362001)(38100700002)(83380400001)(44832011)(5660300002)(6512007)(53546011)(6506007)(6666004)(8936002)(8676002)(4326008)(66556008)(66946007)(6486002)(316002)(6916009)(66476007)(2906002)(966005)(41300700001)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUlIL0hUeUNOUTdpTWZPSHM5TlVvMW9odTFQdk1LSm1XMW43cy9JeU4zbTJQ?=
 =?utf-8?B?eFVLdmJIbkl5Q29GM1ZXbjgyWHlNYTVZZGRhczFSTm92MGFNV1RaTkJoTEhi?=
 =?utf-8?B?SElieVNwOU9md09NZG1aNFZ5SEZvRnRjSjhFcmFQVEFwZHBsaWVIQzRVVitJ?=
 =?utf-8?B?QU9MQmgxVFN4TmNBclF0bmRNTmloT2c0U1VXc1dMU0NjQ0FzNnhTQ0VQMXBx?=
 =?utf-8?B?RkZROHJQbHc4ZHFBbEd4RWd3OC9iYTJQd1BzMjRvZE93QW5BV0tIbHhsSnhu?=
 =?utf-8?B?cjRTUkRKM2ZWTmNOQnZ3c2FkT0djUEwxcUtFQUlXTnppN3g5Q01xMHZCYjVi?=
 =?utf-8?B?K3VpZE54d2ZpM2crUHdMT2ZPMXRSVXFBNnFNVnN3QWd5NXNYM0R2ejNzVmVP?=
 =?utf-8?B?Nms4TEpyYmF2SlJHaHpkNVlrUGJ2bnZDalE4QytCNVFRdUc3UlY5TjVSOWRG?=
 =?utf-8?B?Y0RNWWtTQy92dEJ5akZrSDlnNFVDN0RXS21VUFE2WVJwRTgwSzJLejllc0JF?=
 =?utf-8?B?SG96dHQ1amtQL1RPNnNFbUN6RUQ0Y1pvTXhOMWo5VlZ3VTJWcWV0QjFWbGNj?=
 =?utf-8?B?UmZ1RWRXMmNQRkhNT1o1NDhPYWE2UEV2cVdTUVM3NURNMWlLV095M0ZjUzRE?=
 =?utf-8?B?TVdnS0dWTG1KN3FRamx6UitYL2R1eWdxdTJsZ2RBRjdia3VqckxLM0s0bUhV?=
 =?utf-8?B?MnlSODl3aTNuRHBUeHNhVjNXY0VaNGxLTnpEKzg0d3M2WFF3QVFXYmsvOHZC?=
 =?utf-8?B?cE1MZ0JHTHpES0o4MlI3OWh6aWJHV1NzNEZIT3BwSVVXMkh4cFVZY1JuR2d5?=
 =?utf-8?B?KzJyWm9mVG1kTXdacy9lWklpQVdPdWJ4TVlybUQ1NWxPc0hBUGd0cUxzaHFj?=
 =?utf-8?B?ZEM4MUN2U0JGczVLTzFzelEzdDhIbGNqdFF3Znlra1BoUnNLYXp6RWxwT1I5?=
 =?utf-8?B?RE4zZU4vOFBFeSs1bEtZbzF2K1Z4eDZZMXVpQ0FsdUhhUStWcXlNS05TWUFQ?=
 =?utf-8?B?bFBDNEJNQzc1TFA0aXl3YXRxTGdaSXdFTUFiQlNPYVdJaFhuTVNTdHUxUU9l?=
 =?utf-8?B?QVJBVmYvSzNVYWJSWTFvaSszUmNMUGxuUVhPZTBackhkRnBzeTlHVjRUTCs3?=
 =?utf-8?B?NHgwb3Q1eFZMK3ZZNXdPWEw4ejE1VDFTdHVkVUwyMzU2c1B4WXdPeExONVZh?=
 =?utf-8?B?SC9lUFhOdlk5ZFlleXBLYTYyNTB0Z2ZiNTJzejliNTU3Tnh6ZW5PTmRUTlpN?=
 =?utf-8?B?MVlYNWF5OHkwYW1zeHFaTzVUaTRHN25XcmJ6bVIvdFZWdWtrUjI3bW9raVd6?=
 =?utf-8?B?M1Mra1JjSTRGN3BSZ1RtejJmQ0NUSFZNLzl0bXEyYXdIWk1za3ZIWnZHOU41?=
 =?utf-8?B?NHlpeFlwZzcwQm9DVGxjRW1yN1dsbzFRRUM5VmRxRGFtTGcwYkxSby9BbXh5?=
 =?utf-8?B?b1FDeEVsY2RnQ2gwaGtycnZ2S3djVktqcHBIUU9WbU00WFBVelA2OGovZ3BR?=
 =?utf-8?B?S0pIVGpIN09TT1ZJL3k5TVlLZHh6TFVqV2RNS0NPL0M1dUFteSsxYks2cmZa?=
 =?utf-8?B?dCtqU0pLK0l6dVg5d3VBSEV6VXc0QXRWY3p5T2dEVERISVlJMHZGK0pqS2I2?=
 =?utf-8?B?ZXR2bzFEeW9Rb0lqRW0xNkI0UVJ0Y2hpemlNZDlxRzlYVXMwdS9pS1I5T0Y4?=
 =?utf-8?B?NFB2TmFNRThvRC9rYWFkbUQwN2xMUnBlNGFVTUJvQStoNHF1dVI4Vy91VjFr?=
 =?utf-8?B?REMrWWNlTXN6eUhvVFZqNnRXVEFxY3lrMGZMZkRyc09OQmRaT0R4YzhzMkxu?=
 =?utf-8?B?ZXBjZ0lLMWdIbnlpS2JrQUpIMmgxRk54cXhZUUg4ekxUUWlicG5oNGJoL0ZT?=
 =?utf-8?B?LzBDcmRFemhrZ201QmtGaVU1aER2OGVSRVh5cHM4YUJnazIxTXRzTVhMbURO?=
 =?utf-8?B?OUMwNzdjZTRCT0ZSTS9UTUVmRWNDTlRrNU9NZjBPS3ZkOXUreDJKL1h5eXhO?=
 =?utf-8?B?a295ZHVXRjZJbmpQNG85di9jK0thUE9kV3Q5c1lzYTEvdEludVlJR3FWbXFS?=
 =?utf-8?B?K3R4SytLWlM0Y29LeFFjZnZ0c29UZjg1dnlKWVYrK2ZVUWFIVjNDL2g3ajBi?=
 =?utf-8?Q?Y1JYElnC7+qjpBF2DugILiNLU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24850ca2-9c78-476e-cda6-08dbff889a0d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6043.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 05:17:17.9479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5WUtnFW5M5Jf8YKmZhH+M2wHuQ83R/S5upB3Jq2D1pacxAJRDUt/2eZHJt/n8b3VeXt3jy7tG1HSjzEEN2l2nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5242

Jason,


On 12/12/2023 8:29 PM, Jason Gunthorpe wrote:
> On Tue, Dec 12, 2023 at 11:11:24AM +0530, Vasant Hegde wrote:
>> Jason,
>>
>>
>> On 11/30/2023 11:25 PM, Jason Gunthorpe wrote:
>>> On Thu, Nov 23, 2023 at 11:09:20PM +0530, Vasant Hegde wrote:
>>>>
>>>>
>>>> On 11/7/2023 6:58 PM, Jason Gunthorpe wrote:
>>>>> On Tue, Nov 07, 2023 at 11:25:49AM +0530, Vasant Hegde wrote:
>>>>>
>>>>>>>  RID domain=BLOCKED & PASID - ?? [V=1, TV=0, GV=1, GIOV=1 with GCR3 entry 0 being non-valid] 
>>>>>>
>>>>>> I haven't thought this scenario. Why do we even need this case?
>>>>>
>>>>> It is triggerable by iommufd, it has to be supported.
>>>>
>>>> You mean PASID support with BLOCKED domain?
>>>
>>> Yes, that is API possible.
>>
>> This will be tricky as we set DTE flags per device, not per PASID. This needs
>> more investigation. We will implement BLOCKING domain first then we can look
>> into PASID with BLOCKED domain support.
> 
> You can look at how the smmu stuff ended up for some inspiration, it
> is quite similar.
> 
> It is what I keep saying about properly structuring things so the DTE
> content is decided high up and then flowed down to programming
> logic. Then you don't get stuck with "we set DTE flags based on the
> device" which is not actually workable.

Agreed. That's the ultimiate goal. Just that we want to do it in stages so that
its easy to manage. I have posted v4 last week. Please take a look.

[1]
https://lore.kernel.org/linux-iommu/20231212085224.6985-1-vasant.hegde@amd.com/]


-Vasant

