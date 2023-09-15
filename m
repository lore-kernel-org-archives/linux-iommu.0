Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C520110963
	for <iommu@lists.linux.dev>; Fri, 15 Sep 2023 13:49:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OrPQwYNnQcAbb1nx9CXuikF3/IPJ5GyamgxOXf3BclainqG1fPYDJPohGzy0aYAL1RUObJCLZ0CPV5yOVkYDwRYOymKN1sO7t0M+MUJTvAuNoRw35q7WtCZRXdJ1BKDCSo8EyiVzTcuQ8pzN5/wdAFiQRpGu108ZSPFiVld+UQLkw5Kn4ts6thKtRPyrOc7NzmcBL8cbw114KD6DabyTkEAf1skSQS47kYqEMqTjVvedQN5tRZYDY7cds9u1RMvJZtFjNtCgO0/x1WdcCOsPWiqIl27yelVWJSI3herqG00uPPoTT5Ac5c21f457MDIG2vdzCIYdmSgvB6ByisLVzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xr7gRq9q15FVvsG2x41c3kIqC0jVwIeouvJJKXlroKo=;
 b=msnyQdFRjsdL0ifUMWsJX+pTB/nBOn/4UHA8Gb5X7iwkJs/0UG5T/GDY4VFg/J9a0dkBy0CXciZN5zU16nYYO18WS2w8EjA/yzrhBS8sOGKdLcg9gJV77Oxktm909iNBYmE0EPjAO0+nRG+/EOdX/ssUy8DcJS1MSZhMqypbUXwaB61BoBeQEWHGM1nuPIxogw6QqtVBjoBbbH5s1WepQct0omtSOeiT23td7wb87r0iqn3w+Cs5HGIuV5CGVK1M65tJ5F9jIuNjXYTh7uOtFSrLGnvsL8p5nCO8DewdSX7E/axZ/i2NhcOyF6+ZkQapByFL/bjShFzkQFaewRFZTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xr7gRq9q15FVvsG2x41c3kIqC0jVwIeouvJJKXlroKo=;
 b=Omw508+2jWViDqLWHfsa1icuIbKCc3aT7U7mvgkeQaYcVnnul7v/S4LneyIytu8GoORdJc+Xs93bRjptx5cPz3mb2/AouQSIUsjV06Fq+SJNCJteTo3O6QNF9kTXA2FLdQ1lEq3dQ+wgSq+d/LNvZFuGBoJ/jFdqz7BEZxJ3mtc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH0PR12MB5435.namprd12.prod.outlook.com (2603:10b6:510:ed::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20; Fri, 15 Sep 2023 13:49:01 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::cb74:f20e:dd21:d763]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::cb74:f20e:dd21:d763%6]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 13:49:01 +0000
Message-ID: <46e56a4c-182b-9a34-cf31-c2c1722cda64@amd.com>
Date: Fri, 15 Sep 2023 19:18:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 07/11] iommu/amd: Define per-IOMMU iopf_queue
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230911121046.1025732-1-vasant.hegde@amd.com>
 <20230911121046.1025732-8-vasant.hegde@amd.com> <ZQCY5wyo7WDTz16P@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZQCY5wyo7WDTz16P@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::33) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH0PR12MB5435:EE_
X-MS-Office365-Filtering-Correlation-Id: 2807c014-269d-47f0-5c03-08dbb5f28449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YS9wHeCEerI/rkeI011+6YGm3XXuxf0yBmGglGGKABrcfq1B+iMp8v4Hw1eoRQpJMHtWW8oecUuqa8xUp/eF+mRslsqQucbgJB7S0alsRwCr0HVwLb2+8ACEJZgnd+ZSGAHXNEZ1tMfycJ8CAPImFD8gImTDVLJdcADNpi7jolx6bb1yaxpXA3HQPphxrNg3xYyS0HYHrpCIHysoqB1UxNK6UFYo1kHH0VpBXjAWt9rlwaOecuGWmXxdavPIE5//EuaRdxgpOOOPnYMcKNTmyJ38pdfiynQ3TwptPGjvRrG2rACiVJEW6nYRm4gX3y9nSe/xOBEZ2dugy8x1nwMVerwzeaqfNeXx9Tqxnbp89dA9fh/g05C5p1e/BReEL2NQGIdGXmYsgG26DzEw+uy64e3mHFPa11CJvdZaxcU+UXY5fl3/2AmKhk7w5paWPV7ldCQ4kLvXAcrK1E+x60qFkkuAEouN5VpclSSb7+BTgzSRIR3TFyMwilZTvKYpMxooCjpd2k5k6H3Z6IlC2I6c7HVt6KdqtJEOikSjBhjV2e/fOMQAuldlLIR6qwp1z5v1WhO5+tWEOUmmWL1xmOaWF6Xz1mk3/UBN0imJP8GjJ3cTanES0biv8ATH1UiiLXU1cn6LSg3oh3cQjQyEShQW5Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(39860400002)(396003)(376002)(186009)(1800799009)(451199024)(66556008)(316002)(66946007)(66476007)(6916009)(6486002)(6666004)(26005)(53546011)(2616005)(83380400001)(36756003)(6506007)(6512007)(86362001)(31696002)(38100700002)(478600001)(2906002)(31686004)(5660300002)(41300700001)(4326008)(44832011)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmkwM3VlekRGQjhydUZKWGxOSTVSU2FKZ3hnZ2x2NnZzcFZQRmt4V2ZpLzJs?=
 =?utf-8?B?cEtNM0h6UzJEK21wSE9tQTZiOW5FYXNVNS9IT1VFdDJtRGcrSjNBTUhKOU5s?=
 =?utf-8?B?MHhYSEhsTnpnQ2NLSFN1WklMeVc4SjJyYmdHTEI3cTdMb2dsYWhycTNzOU5V?=
 =?utf-8?B?dWtOSTZxb0JwRjNxdmVqWHdxQ2VNU2hIeWV0a1NRaW5nUzNhNkVJVGxJNitW?=
 =?utf-8?B?amdJUjZORzdUazB0ZUdkUloxVVBPbGpReU5ZRGwzTHhMckhuR3pZT2F4S2Ry?=
 =?utf-8?B?TWhkdWprOWQrNkZHekE4UnNOb2k2SUFUSEJVNFMvSTVmeFppVCt2Q3ZUNXVU?=
 =?utf-8?B?ZVltb0I1ODhZZEtrTlFXckFxbDBwUWh0SVBRYXdvMUt4dGJ4Q21zVGw4RUVq?=
 =?utf-8?B?cXpKRmg1ZFFXblp2MjcyREl2dGRCVUZYeXR3RGZFSlRuL2d2NmFDK0xYMTd5?=
 =?utf-8?B?UXVKRERFTFIzYlAwK3lMY0lzaVFkSlZFVm5Lcmw1eUZXQXBoOXFqWE5NWWRs?=
 =?utf-8?B?dWl1OXgwdXBPeFo3TmRsdHlnazdadWFMNjhPV01WSDFBYW8vcGwzcmswYjVI?=
 =?utf-8?B?OGorczNpd2tuREJnR1RIVDdEYlBMMkNGVGoxczdOejFJUExqY0lOWEZTY3RI?=
 =?utf-8?B?ZWVFS3J2SlViSHN3VFNoRm5WQ0RUNmtCOVpLTnJiTytoeC8vbDVySFhnbit3?=
 =?utf-8?B?VklkMGpuZllOWncwZHVpOFZacVJycGMwbXNiSnNnaVpkWDFzaTFkNm4wdVVy?=
 =?utf-8?B?bVR1cGVtVUZkQ0tUeFhCUkplajVoTDluRUZjS3ptMXlKU0JialhSNEU0Rzhj?=
 =?utf-8?B?eTRxOHV4RHpraU81MGZ6d1lzeHZ1TjhLaFFUK2ZaU0dIemhrWG02cElESmN1?=
 =?utf-8?B?TEc5L2JuQzZxYnZRU000WS9saGsvTFh1THpoczlFTHorUkVsWGFxSGFFdXp1?=
 =?utf-8?B?d1pGV1N3cEpBeklMUFpyZWxsNnk1cXRwbWdxRzgyVlMxTkVxOGhHTTNnRW0v?=
 =?utf-8?B?R3Z3ZzdoaUN6RnFISExIUnVQeDZWRk1sRFV4dDJBRE5rdXhXYXlzeWJia01p?=
 =?utf-8?B?K3loaFU5S2dxNjVKT2RyejBINWU5djV6NDA2OUpYZ09SS05ZNG50ZUVHVGs1?=
 =?utf-8?B?U1Z4MTNtcnBxM1VmVmNSTTl0NzRHUTZtdHVJTzBPcGRiYXZTQVd4U3dWSEJB?=
 =?utf-8?B?KzNiMGRqL3pBVitvL2htZHFIRG9FWHY4eHdkTmhMSksxUmVuZlZPVk9kMWhl?=
 =?utf-8?B?UDU4TEk2cWdVSTIyRnJ5bVJkcjl0czVjRWliMmVkak5hRWNBM2RULy9kVXQx?=
 =?utf-8?B?SHVZSjg4bEpiU2g4M0dCYk5WTjZaR0kzMkgwQTJmQ3JYMjJVSWhqWHAvVVky?=
 =?utf-8?B?UG5takQ4d0VKd0VtZXR4K3BhYVZEOGdJeXpMR2JTSW4zWXlVcGlMdnpKYkZk?=
 =?utf-8?B?QndiSTlhT2ExbC84dGNScFFNTWphMEhmcE9VbFkxY05LQzYybTBXaEZVVzE4?=
 =?utf-8?B?OWVkZ1RQZTJRbFRKOWg1cHMzZXdjUnhmb0M1MVd1c3EwdlZXa0JIVTQxWTk1?=
 =?utf-8?B?UitXai9xUlZVRnc2WnNHd044UEVQbGFQMkJyci83KzE0MW5GcEJkcFJUaXNB?=
 =?utf-8?B?NlFYenE0NUloZHVMUStWUGRmYWdEMUFGSnp6c1NUSkRycEVRRHlDT1F3NUl2?=
 =?utf-8?B?QTB0L3lYbU9lajFZaHBnRkhlMzFSQy9rNW9rWUgybm9sUlI4blRHVTJYQUVB?=
 =?utf-8?B?RG83Z09zanVMU1lRcU5mQ01ST29NWmhRNXQ5Yk9JcnNJQ1Z1bzBUajJCMmhv?=
 =?utf-8?B?TEpCYmUveVlBNFlSd1MxbUp0aE8wdllUYzJRdWFnRTdhUmhoTlNrSVlDZzIv?=
 =?utf-8?B?TURiS3FVYUdybXpPTDRZbGhZWGYrV2N4Z3I5MUJCVTJqT01Pc0ExVHQ0VWNm?=
 =?utf-8?B?ZzNuN1ZLb241aTVCT01VOFpiZzFUY01lRGRHZndDdTJzQmhhcUl6K3VCY29R?=
 =?utf-8?B?UmdCWFBZd2tXcUI3RXQ5R3daMEVRL0JDT1FwNnNTaHZJZjdNdklmOEY1NnBm?=
 =?utf-8?B?Q0VDYlgrTTZFdUlSd0NZUGw2RkU3Um9NNURhL3dsSTlPOTRYM0NtUlFvSGJO?=
 =?utf-8?Q?o2ViDXZqnCS4SJlpB18fIf0vk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2807c014-269d-47f0-5c03-08dbb5f28449
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 13:49:01.2868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qAMH1nO2gpv2P0rCNNDr3nSpv/hp+ACIwx9vz8LJattXjb5545iKs6P7zLHrMMTUSP2qZcZcXYNNOrCXkDQ9Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5435

Jason,


On 9/12/2023 10:29 PM, Jason Gunthorpe wrote:
> On Mon, Sep 11, 2023 at 12:10:42PM +0000, Vasant Hegde wrote:
>> +
>> +/**************************************************************
>> + *
>> + * IOPF handling stuff
>> + */
>> +
>> +/* Setup per-IOMMU IOPF queue if not exist. */
>> +int amd_iommu_iopf_init(struct amd_iommu *iommu)
>> +{
>> +	unsigned long flags;
>> +	int ret = 0;
>> +
>> +	raw_spin_lock_irqsave(&iommu->lock, flags);
> 
> Dare I ask why this is a raw spinlock??

Looking into git history,

commit 27790398c2ae (iommu/amd: Use raw locks on atomic context paths)
    Several functions in this driver are called from atomic context,
    and thus raw locks must be used in order to be safe on PREEMPT_RT.

    This includes paths that must wait for command completion, which is
    a potential PREEMPT_RT latency concern but not easily avoidable.


> 
> You could also do this when the first PRI domain is attached and save
> a bit of memory..

Its true that it can save bit of a memory. But not sure its really worth to do
so many things in bind path.

For now I think will keep it in init path and revisit this later.

-Vasant
