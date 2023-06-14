Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E763FE6
	for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 09:45:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jj+XlghEtlbzJeGF1Sv9AeavsEMwdv8hlSyBkhY+ZryoZbU+GlQ0vm/MNU0eFajazuo5yvdSurVOhmR7+fCfWk1Ay0YAQKaM46EUCFAKgVseHiy+N5He+4bmY65WsVGX1eSWzaAmZ/dgAGl7siZPuoUXn3h0Zfb0NBj7+P9IC73t8UFctDnaDBB6KawT7RzlhfmWfXxfICjJlp6BYqEfn8X+f+DFtx+lBE5XaVam8ZmSe5IWLdBU2wIPMv8V/hmF7EHLl+7hfUsG7bWlyxLFnzAeOQkBGOXkOe4pUPLJa9VPwSthvGb7L0Ika52ObD8Imx09QsOzxZtxmum7nNR34Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CL9idNsgRvRHFX4S27wQg07JyCxB4sXzOQWgLFfOb9c=;
 b=K7e7TAkM0Im0jpLGzdSnje95WWYmlPam31pwFKos+Hri2tWRRnowqdrng3TZbMGuLd+77v6ODlxkrWAitzvIHIT2falnuzew5u6TPuaEh5sfs78yipPByKWbRlve1UhBaSoQUpX6F0PA21Tg2TlcoQ75mZZ3NDBDTqgA6ZIzCIZatGWVUynnBbf6XWZBwTUNGkdb6EDk046h9Mze9GHsBbIvruQWZe7xHp4DmAzSsx2qCDqbPz7F27aKlX+WU4EpeGJsssbNGdqchyHrc1keK+PnI6doHf7MXYG8/Fsewsh3cs12fj14oXmcHgW80XuIQOhADMp+6YxrcwVOpk6VBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CL9idNsgRvRHFX4S27wQg07JyCxB4sXzOQWgLFfOb9c=;
 b=0Tt3onheaNCA6JujRzsjPyKjqMNry/V2CLeTBcSJPQOj2N6q5DBUltL2n7GJFAKsbFwVUGfOSceh9vduQX61vk25yS3ct1ynEacIiio7HWDrieoRtYcqXyFbA16G3OM35wDUyBDDdd7rBwdneSfyWiAoFihzI6b0LKKV0/iSAGU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SN7PR12MB7934.namprd12.prod.outlook.com (2603:10b6:806:346::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.38; Wed, 14 Jun
 2023 09:45:52 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::7cbf:236a:55b:2c99]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::7cbf:236a:55b:2c99%4]) with mapi id 15.20.6477.028; Wed, 14 Jun 2023
 09:45:52 +0000
Message-ID: <d52a7650-8c14-371c-e88d-d60f391786e4@amd.com>
Date: Wed, 14 Jun 2023 15:15:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] iommu/amd: Use BIT/BIT_ULL macro to define bit fields
Content-Language: en-US
To: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 Yazen Ghannam <yazen.ghannam@amd.com>
References: <20230609090631.6052-1-vasant.hegde@amd.com>
 <otpf4apjgppcdkm7k7jfq36k7l72l4gqm45lrrimza2d46t45e@6wm5d3jmfxu3>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <otpf4apjgppcdkm7k7jfq36k7l72l4gqm45lrrimza2d46t45e@6wm5d3jmfxu3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0208.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::16) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SN7PR12MB7934:EE_
X-MS-Office365-Filtering-Correlation-Id: 05c46ebe-d9f6-4d98-353c-08db6cbc2461
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c5swtV2WsTucXyUsf+PRSAywuwu+S8Xv7SgJqsz7jgAveYGcA0tyXxlWo0aWcwI1UTR3SDvizaXeo8TtIcXhsXh9G+q1aRwfZZsFMxQpejAmHR6gdFt7HOpePjxC1j2cev0CNYOU7x/+hKjLEpwO0r5vv5LJHat0H0/l0DH6tyV45m6cQOU4CWuVhUD95npNP8ax2RokiJtyEeStvT7jj+lrSo6weBC7S6/zwihKBGpDNfndZje1+fvQShdwXKRP0CaQTucI+L33DCSSv8ilJ0LR8zg4vdp2V42BhAus+X0WtGOLtqNESIreAeKXUC5mfMiFNX0BVeZJPBS9tpGKveb3vSDI/5ZlInw0PdWJfQREziFJnQO3zTA4ipK9+gApdBNubXfOMowRvU9Uutg4CIcwvewRYDxg4piG8DhfbD4th1GbnygKrv0NEOzFsNUPsWUOcb7BghTLCL+aQzYjKgVE7FLPtT4LtwWO8GsHiMxhV/i7zN08smu5qTqLypRQYdUKRigbC1gMiKlqq2HwyuSvzBjZvc1go/PuezN3XbQRMszJDjkDsqbWpF/RkYX8N+htVNGzdFdVVqmlmCnj+ML7ou3FA/+lJHc1npHboLjppga/oY+MrEHepMH53YXlCihO9mhy4tczIPcvr9/a6Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(451199021)(5660300002)(478600001)(31686004)(8936002)(41300700001)(6486002)(316002)(8676002)(53546011)(186003)(6916009)(4326008)(66476007)(66556008)(66946007)(6666004)(44832011)(6506007)(6512007)(26005)(83380400001)(31696002)(2906002)(36756003)(2616005)(38100700002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3RGNUdoaitFZm9LU0FKbHFOY3E0cnpLYmhaY1M4WSsxSVEycDUyS0NOU2NJ?=
 =?utf-8?B?NXF0RU9MaCsyamVjcCtaZlVjSkRnbGp0VWxEaCswb29MalY4dzdhSERNVExm?=
 =?utf-8?B?YjlvTkRkWTZpUUM2NVI1djExZC91NE53Q2hpK2tGamhsZ2xYYmkzcFYrYjdW?=
 =?utf-8?B?RW9xYk1MdWlBVG9OR1gvMG12SmdvR0FVZ3psR3E0dW1lbGkxQjgvVkY5dTlJ?=
 =?utf-8?B?YzR4OGc5c05ncGlsSWRiSmRwOFBKbGNHc1RaMml0K0dIRlFvbTVzeHFpZEk3?=
 =?utf-8?B?QU5STXYrQVNmMHBJbmtKZEpqWjFhSjRYamlXbkJnNTkwMTZhc2htTjZzNjFM?=
 =?utf-8?B?c2dXSkRla3p1MEpwTzFTYW0veHNyKzlYNE55blhId0lsN2drcllEenBwQ3By?=
 =?utf-8?B?SVgrdGhkRTREdVpjVHF3ckhnc1A1QVk2akttbkdaZGlaa2daenJqMlk2MEhC?=
 =?utf-8?B?TG9QZC9CZGZxc203MElNUERIMVdUWmQ2T2hOQ2JGK0o5RkFCLzc5ZllmaW5R?=
 =?utf-8?B?TGhwRSs1N2JsNHZxSzF5dXd1Mk9zMGE3bDNzbGIzNEh6M21hS25WbVlHOU9o?=
 =?utf-8?B?aHBzMDhIOFdYOTQrbE1PNlhOYUhiMkpubzRTSHZWam5jOEVqbThBL3dnM2JY?=
 =?utf-8?B?N2EvWG84MVRDUFdzSlJZVVFkdld5bzBPZ20rcWJuL2NUTjI4MkV0ekY2UkNm?=
 =?utf-8?B?a29UbWJxb1dJa0N5SzlSTHY3b1ZlZC9BemRuWjRoSGl6bmt2MnFKa3A4cG9n?=
 =?utf-8?B?WU5QeEVQSTE1dlJ2RDVMYnlZbFNlSkU1N3ErZDhvUk43MzZiWTRJVzFybXl3?=
 =?utf-8?B?VjhiZ1lTa2ZxbCtMd2RjaUU0Y0Y3VjBYV3I2T0dlaVEwSmQvV2g5WlhKZWVr?=
 =?utf-8?B?UHlXOTFIZVBaOExTLzJ1ZHRjYnc0UDZJbHRIaDRXZWgrczIyT1FoWmg3ck5E?=
 =?utf-8?B?OXpyWUhmckxSRzJZY0hvVGR6a2ViZnRESEowbUxhZ1IrRUNvWkRtVlBjNVNI?=
 =?utf-8?B?UG81WjNxRGhLckMwR3JBR3RmWDc4MU13VHQ4VW13Wkl3djlSSFpiUys1K3JG?=
 =?utf-8?B?WFFIdWxlbWRyYXRTSjE1bktJMXk0dFY4L2haR05SUTl4YTdKMmhVWTAvMXpv?=
 =?utf-8?B?NWFnVW04TXcvdmMrNFFrd3ZCNDU0ZkRWemNTMk4rRjdIZDBrVno4YmVoZi9K?=
 =?utf-8?B?d2Vaa21Ka2Yrd1g5SXYyUWh6Z3hQeVpYbHhwTUg2OWFIcytQSG93UUQ2QkZk?=
 =?utf-8?B?MW93UXNtZmMrSXc5WXVmeGgwNmhUeFZVSVp0eXVDb0w2dmJKcklJLytkdGl0?=
 =?utf-8?B?cFc5OHZJMnZiK0dxaTVzZWUrRjBXbTcrWGZqV2MyK285NWRWVUtGWmhYdjk5?=
 =?utf-8?B?Z1J5ZXZ3K0l0Y2ZQenZmOWtXbHhhSGhseTZFdGFNV2wwN1RxMTI2WE5SUFRU?=
 =?utf-8?B?VFN5clZsZllFM1VKWG9hUldlUnBFN1J3WVNpMjg3RWxrTVlJdGhzZEtzakdF?=
 =?utf-8?B?bnY1TzBZSDVlaTdoQ042d3NxNGlteDdTTEhiMVNyQ25taDJ5bldQUUVsUUtV?=
 =?utf-8?B?enF0WjBoOU5MbTBKcW9QWFBuS0lLbUJjeE5oeWdzR3c3b2gwNGl5ZmJaQ3g4?=
 =?utf-8?B?TEowdVdvVFVvMTdtWkRRU0lmcWhyblFLL2hOZ282TjRBeXJpT1o5SWFXTGFy?=
 =?utf-8?B?amQwUnczUjA5eFpUVmVRVFp2OURpa2Jtb2dyRW9HL3p2eldYL200QlpJY3ZW?=
 =?utf-8?B?RXM0TEV1VWNtTU5aUFc3dnh3TDZvRmRYOENNSG9EKzZScWcvdXJEQVd1N2ll?=
 =?utf-8?B?SFFDZE8raGFuaTFGOUVmSWlJWWlmUTFHYWV4c0xsKzZ6alF6K0poMlZpZTRQ?=
 =?utf-8?B?R3p3ZXBwUkNHS2tMMjZ3aEJIUm1jS3MxU1ZPNGRtRSt0RmhaS0FhQTlkNGZP?=
 =?utf-8?B?bkIzN04yNmNsVmJzcWY5Q2NOSWl6U29KSWRYdkp6Z2w3U0xaWGtqREtIdHlW?=
 =?utf-8?B?WFIwaVVmTHl5ZjFJVzBZUkxOV2krL1dCdFBsMWR5bkJpR1NTRGxvank3UkJp?=
 =?utf-8?B?WGN2VEtXb2l5N2FQL0Z5bnVidnhVZVF3M2dsUGZYTUk5cG1QVWk4Y014blpz?=
 =?utf-8?Q?SuVqoFATN6LqldsPWsHQx6q6i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c46ebe-d9f6-4d98-353c-08db6cbc2461
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 09:45:52.6789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PhqjnzoNPnUkcNvh5G3aFtUzm4vmBA3zJeAFxL9AU+p7b0aogxnLCuIoiJBMW5UTEHJoutz/oqGNTMVM7YXiog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7934

Jerry,


On 6/13/2023 12:25 AM, Jerry Snitselaar wrote:
> On Fri, Jun 09, 2023 at 09:06:30AM +0000, Vasant Hegde wrote:
>> Make use of BIT macro when defining bitfields which makes it easy to read.
>>
>> No functional change intended.
>>
>> Suggested-by: Yazen Ghannam <yazen.ghannam@amd.com>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/amd/amd_iommu_types.h | 76 ++++++++++++++---------------
>>  1 file changed, 38 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
>> index ae0edeb379d4..a49cc2258a76 100644
>> --- a/drivers/iommu/amd/amd_iommu_types.h
>> +++ b/drivers/iommu/amd/amd_iommu_types.h
>> @@ -84,21 +84,21 @@
>>  


.../...

>>  /*
>>   * Bit value definition for DTE fields
>>   */
>> -#define DTE_FLAG_V  (1ULL << 0)
>> -#define DTE_FLAG_TV (1ULL << 1)
>> -#define DTE_FLAG_IR (1ULL << 61)
>> -#define DTE_FLAG_IW (1ULL << 62)
>> -
>> -#define DTE_FLAG_IOTLB	(1ULL << 32)
>> -#define DTE_FLAG_GIOV	(1ULL << 54)
>> -#define DTE_FLAG_GV	(1ULL << 55)
>> +#define DTE_FLAG_V	BIT_ULL(0)
>> +#define DTE_FLAG_TV	BIT_ULL(1)
>> +#define DTE_FLAG_IR	BIT_ULL(61)
>> +#define DTE_FLAG_IW	BIT_ULL(62)
>> +
>> +#define DTE_FLAG_IOTLB	BIT_ULL(32)
>> +#define DTE_FLAG_GIOV	BIT_ULL(54)
>> +#define DTE_FLAG_GV	BIT_ULL(55)
> 
> Minor thing, but would it make sense to group these according
> to which 64-bit word they are in? DTE_FLAG_IOTLB is in the
> second 64-bit word of the DTE, and the rest are in the first.

Sure. I will fix it in next version.

-Vasant

