Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B991F126F10
	for <iommu@lists.linux.dev>; Tue,  5 Mar 2024 14:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650776; cv=fail; b=Qs+68RIgCZKEsnhGxGP5nsyMnt1DdTcT6g+i572XyuI6eUGlIKyrIOvNViKIAsBhvzjN62vB+yaW7euy2HqFljOt5gQRwZuqpxBAIaXDEzUEZpC22UUtFAfsyMcwJlzOSZQpFK+5K4WpJFNyx1fqTsimXcbF7LXdksedsbbqb28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650776; c=relaxed/simple;
	bh=beme+Z3GVwOXEV6yV0KieSKTerhUcQOVXToywxaFvQE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p2HEwbUFTEYrrOD6SW6gbK+lqdSfgnPGw7dzLMYnCN/mZTwGiRvYGY8EKrzw0MtjSzAqffAYgDm/V0laTGCAsiQrm6X5eIFqPagIBQ7v6eydrApCCytPm4/NObHr9AC3CVPArmd9UL2U1j9wPJZWa2j5FaAWaSccmm1a1+ccnXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oyXH5xB2; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oyXH5xB2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qx1TZ6nqL2DB45KI5WVrnr9L9XRAn4K/rRonM3c+z85+VzJjq+skJ+mykZyWjjXMKYDGSILedDvmWVWvjWdRZa1ZOgrODXJjWWQ0fFBAwWXBDF/uIMFSQbE+Jh2m57cdN51CEtxgxKAq9pg2D1ycz0nIM+AtIlP3EPIxoPU/lCIIyV1nZ4hAY3vNCNszJgVsdwGKuRcEj+gSf86agqTcZMSFnsWjET37i/FQrivzArJMMDDykaVTgqrbqZUm6RL3PkDQG1nlRoJagUtv0beR9Gxm3/zlSuJAtV4aERA0WkdMzBHcg3qS9vEz656uotuZ8etCBWqPUdnh7DcTyEhZLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ep4cX9bedpU5ggYs5VXxv940ce1DnSuuu9blCKHjZs8=;
 b=FvQKP7w3sRvIH6KGNMYUKZRP4NLri1+vQEMEaySRZMIeWoUZBW5yMnw4QTsDjDEVoMjgLYWDlMD7rcZjQIQDyL2q2IaNqIHq4Y/T5g/YhXfsz8RVnuK1+GbcJ6YtVShfJ8fvyIYsQpsRWsqUh2p/i6ilYzg8JZy+JAPOFunSdDrobdwSaKjAIDZqTp7c3uk/KQTC3K0b/XSw6j+zl6FUmu1NqLI6K/qsE+VOpwlUPGhMQQ6VVeJSheu94arKICaL3tH9awWFvDkGm6pGVZ7zd9lxyswXn/o8XYwjE19nf/q7enC/ftuudqXfjlxTJrd7fU9IJsJqHf+l918MnOHYxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ep4cX9bedpU5ggYs5VXxv940ce1DnSuuu9blCKHjZs8=;
 b=oyXH5xB2fRv6d581p4y9xLUxVq6LKI4F+8jfzvJh2LPfOEjPMrxcLBiU2KS6OPCGFPxDyj5t3PyUqdVFgdNhb1S5bekvtrEZVp1yD/yBs5yaR48DrDh+J3LQsu/dab6A1E6K5w2qQq56gRIVzez7etnnqu7zWUqKO3KDQD+pETA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM4PR12MB7768.namprd12.prod.outlook.com (2603:10b6:8:102::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.24; Tue, 5 Mar 2024 14:59:32 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::d709:cb7d:2612:bb27]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::d709:cb7d:2612:bb27%5]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 14:59:32 +0000
Message-ID: <6a1b4600-a27c-9dca-7ba4-c8f6a6df0811@amd.com>
Date: Tue, 5 Mar 2024 20:29:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 00/15] iommu/amd: SVA Support (Part 4) - SVA and IOPF
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20240209112930.63663-1-vasant.hegde@amd.com>
 <20240305005253.GI9225@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240305005253.GI9225@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0033.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::8) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM4PR12MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: 3be1adbf-4e45-4176-3fea-08dc3d24dd07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XcuiPaekrSlRI7grUYT5pmhYvaw6SiDCrKPjyIH6najcjSOU3v0xJyWNq08bjz7R1VTc8IsY5UpuH8WQFKp7pbg5rdAFirSzgTFEXGdMALIZldGlDCyOkKiTmGbwGxxAOWdSlb3wb24eXy2eUr11BMuKtekXFJ/eb82u/RR/cvoQRqiDHZKO+e8csPZ3gV7nzur79i0ShUL0OZLord5AtbP+/FwQSS7izM/r2k9PsrcV3iBlINnbBwF7JZA6xvOugHL8LgzYHMiQeDSdlMAYpurhx5omvZ0xFeE2zrPRwVEh6oC6RalDo/NexO5TuIV5rRRC6ViD5c/fZ1P3RGz3EWCQO5vJFUdSkBQx0TdNvTM1xIW4HuA1mWPbXc4oinzSpZaSjHtYirBrMKHQDZebNg1bz2A9I4gjDDWDJymc3jCMujvFDybZyFHUwc10lx2Eq0/KnObmqmk/DAQXP7EVjxAWg6e+I2AKfM1RxwJBMiX7fokr9L76ZLV6bvcEUP4nwPO4AlV/ALWk6Slx+j+sTz8m3rfUgaRgmk+qvQj/GKlyXiaSdhMfr2tdEJCGnr4qCFYpQYnUYUVo/XCqF+5szxLTY1Pxbmk92IXS1NgY18JBpkeU83v996y9RrC+B6KV/af5/8PBAkxNdPPeTtlysxMZEzWCEw8qkCodmNzUSHQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHNlV2pXYVhUNnJXRndydTZWR3FaN2ZyOVoyRGJQOXVReHdjVHY5NjBPb3d0?=
 =?utf-8?B?RkdlUkVGdCt1bENDcFFueXJZUWQ2bnlXbGNrczU5MzlQV0FIM29iSmtrdnNu?=
 =?utf-8?B?MmNHNHY4Tm5GYUJmbytlMXE2MVlRZ0kxUW1EN3kvYVRKRlVVdGNSRGI3am1O?=
 =?utf-8?B?OTZXeWxRNFQwNVJFc3Eyd1lwbUdRajFmdUdvY2owUElXVGtMaEorQ0tiM1pV?=
 =?utf-8?B?NVh2dkpvTDloYWk4bU03ckRIQkFoZ0hZUURENUFSOVYrVWcrc1J5N3RUdTRT?=
 =?utf-8?B?c1M0WFJVSzJpVUQ5dzc2S1pGSksrbVdTMWhQNlNsUU4rcnhhTVFVU0pJTTRz?=
 =?utf-8?B?UlMzbFFjNDF4WUhoaXd5Yyt5N0tIRWp3Zm83RlJWS210S0h4Sk1qRm9JMVd0?=
 =?utf-8?B?MHNOVm92MDNaWDBsU1J5Vkkyd053NkpNTnVQeG16ZUFBZ0ZJNFZyRU9oTjgw?=
 =?utf-8?B?bkRSV3hySkdOZjdBNS84TXI4bDVvY1lTb2FyOUdBY3J1dkZNRHM2WHRSWGdo?=
 =?utf-8?B?ME41QjJVWnZvZzNZRFhyVDBhWlNZUUo5eGNKOXoyN2FhSG5vRlFUam0wbHZG?=
 =?utf-8?B?a2JkSkxNVnJ4ZFpWWCs0eUdJc3Vjay92Sk8rdTRMUHZrZmcxSWtNTVM3TkhN?=
 =?utf-8?B?R3hRMkZmWWdIVmRCZW4yY1QwTXZUbnNBQkZONXV2Mlk0OWJXakp2VklRZEJB?=
 =?utf-8?B?eFNmd00ycGp0K2s5YUFZVDhQSFVHTEhHSlFlOTAxWDcxdGg1MGxnN1orSmNX?=
 =?utf-8?B?QW5YcmM0c00rdGFmMVpIZm96Vy9XMFZXV3BsNW8yeVE2ay91RnNWMDFDcml3?=
 =?utf-8?B?TG1NaFpISmk5b1h2VVNiL3FENVZxU3dHNWFFU29tNEpKVUFhT3c2MlYzbWFN?=
 =?utf-8?B?am9vY3FOQVF0a01td0lBS1M2TGU1MVF5bEI5bEJ5eVBIVHVGTDZxQ05oUkFj?=
 =?utf-8?B?a2lGVmxnN3BiTk5MSHJ2Mm4rakl6cFRpY2xTOTE1ZzRLYlMvTEgwN2Z3WUps?=
 =?utf-8?B?ZEc2VWdKOHp5SXZjUE1hQ0NiTWdRbkU3RTlOamI4alBjNlg3RERBbnYyd1Yr?=
 =?utf-8?B?Y3Mxc09zUVNVUFNYdFJIeElRamhuelUycTUyM0FJaCs3dkFrUDJRUUFTWWp6?=
 =?utf-8?B?ajdQU1FZOXdiTjBvWksxN2lGa0ZONzRYWU5lRXUrU1VRa2UrR1h2TVZ2Q0gz?=
 =?utf-8?B?U3p6YU1WQ3RBYzE3VzJ6QmNvWnJGS1NjTWYxaFRYV2FlUVExNUdhM3hmVFhp?=
 =?utf-8?B?cUtkYXNTd0JJamlmT0ZScXN6OGRMNXp1YUcvOVZENm0yRG1uVHl1SjVGalBP?=
 =?utf-8?B?bi8zYjQ5dnN0eGNsUWI3c3NPSm9LTzJZRmRUcVdYR3lOZktBVFFSUTJSdlU3?=
 =?utf-8?B?VTZWa3Bxb2QwQzJtdDNZUUtaMGZ0a1RIb2c5WEZtRE9tTHRoZ3dvMWpZVGY1?=
 =?utf-8?B?cjZIYVdyS0FCa2FPWC9HdjdpUVl4OWhacHI1WExVa0xPZzB1N254YkJGRXlS?=
 =?utf-8?B?YUN4byt5YXBvUnNCTE54RU1xWEp0VDVSMmNDMnZxaDBnRER4a1BINXpCY0Fi?=
 =?utf-8?B?ZnppOHZJR2FqRnIyLzFndU5xalpxRzE5N1VhNFY1R2tPbjd6NG9JeS9OTVhh?=
 =?utf-8?B?U2Z6MW1lT2VBMGhTL1NrZmk3Q2U2WE1zd1lpZkhmdFNxejgwMFdtd1NCYW5X?=
 =?utf-8?B?NWZob2hnZ09aSW01ZHlDZDZPeU1jRUxoMkZnZW5vbWYrcko2aDVhV1hRRHor?=
 =?utf-8?B?OU0zRy9SZHd5dDZGR1JMeHpyMnp5OVRtb2NEay9Na3FiN3VoQ2VIM1ArYkta?=
 =?utf-8?B?MG1MT2JQc1g1Nk5tbWRZTTdLeXZjenlyZm1jMEhtRTZhbE5qWDFNZzlsTVFq?=
 =?utf-8?B?YjdmV0hVVW52VCtXd1BwUGoxTDZZOHZMVldzNG45TTUyZ3BaV2Rvak5yaGdK?=
 =?utf-8?B?L1JVSUhMK3ROeVRvM1RHRitpVkpzL2VBOVF2QnJra2ZDcVV4NFBhVjRzcmRr?=
 =?utf-8?B?NzJxeGY5TjRJWGM3UnhrRzhNbVZUTVhVbVVXL3pRZmNrOFFkN3E2a3VNK1RC?=
 =?utf-8?B?ZGxnaGRpUTd5TXVpejFKU29DYnVWbjlRcllOWlZzOFp3Z1diTEl1OEFlWHNM?=
 =?utf-8?Q?xRmr23YrO70gf59I3XyhXdxvD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be1adbf-4e45-4176-3fea-08dc3d24dd07
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 14:59:31.9884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSGnLnSiPCv/wIcYWWLEy5Oa0AC2gthlasJF2kaie9LEa8WnJqYyoBw5PZ167egxWQTDLZc9YCjJAOeeLyuFsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7768

Jason,


On 3/5/2024 6:22 AM, Jason Gunthorpe wrote:
> On Fri, Feb 09, 2024 at 11:29:15AM +0000, Vasant Hegde wrote:
>> Jason Gunthorpe (1):
>>   iommu: Add ops->domain_alloc_sva()
>>
>> Suravee Suthikulpanit (3):
>>   iommu/amd: Move PPR-related functions into ppr.c
>>   iommu/amd: Define per-IOMMU iopf_queue
>>   iommu/amd: Add support for page response
>>
>> Vasant Hegde (9):
>>   iommu/amd: Rename amd_iommu_v2_supported() as
>>     amd_iommu_pasid_supported()
>>   iommu/amd: Introduce per device DTE update function
>>   iommu/amd: Fix PPR interrupt processing logic
>>   iommu/amd: Introduce iommu_dev_data.max_pasids
>>   iommu/amd: Setup GCR3 table in advance if domain is SVA capable
>>   iommu/amd: Enable PCI features based on attached domain capability
>>   iommu/amd: Add support for enable/disable IOPF
>>   iommu/amd: Initial SVA support for AMD IOMMU
>>   iommu/amd: Add SVA domain support
>>
>> Wei Huang (2):
>>   iommu/amd: Add support for enabling/disabling IOMMU features
>>   iommu/amd: Add IO page fault notifier handler
> 
> There is still more to be done in the drievr, but this looks

Yep. I am hoping to post some of the cleanups and other stuff like BLOCKED
domain soon.


> structured well now that it should go ahead. I think you need to
> rebase this on the Joerg's latest tree?


> 
> Either way, fingers crossed for this cycle, sorry to have been so late
> with this.

Thanks for the review. I will rebase it and post it soon.



-Vasant
