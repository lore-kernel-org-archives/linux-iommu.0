Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E6E136E3B
	for <iommu@lists.linux.dev>; Mon,  6 May 2024 07:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714980723; cv=fail; b=lVIjcSeQscN0vOdwYhpuiVqkeqTWQmfMNej6NdonAqvyxcKBHZvJ/ZBAOAhsX8DdjooQcmqBoB1J+co1tSLP5MsdwLgJrR7keQpTU038X/0/vM/esM1HcOgYEx6wl8Hw8owkv+kEWx4Toa6D/2DL8jCb5pzF7OAhdHmXDop26WE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714980723; c=relaxed/simple;
	bh=oVoZDfgNr82I8bS2EAfUVR3JdggOflNEPhrYRWtzN2s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZPSRJAnNZOGaL0cIl+QXgMubH0qFDERnjNPZAiUS37KxKhbpmrI5ALdoVlrBz84pu0PB96HOCJZ/9gU1E/Z1FVl+aLMEvW6YzBaxZyuYpYHQewIEm5yhi2dTAXbbp2yRav7sHScur517YwYYm8VAjj/mkZgOHbDt5BEjUeFvTMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QT1hzGr/; arc=fail smtp.client-ip=40.107.236.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QT1hzGr/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2SViJ4lg8BxH3sGohEixv52JXfo2lnONuUVrfnsia65yzm7Vf4/htcBG/UBFZN/V/bZl9Hcw9L4/CaiwMxZCQnnzdXRhLfTHx/Z7Zh7adN1PMLSH9gu1TuzmMM9SEOLX09xZ3QFphPLRdo0rWUD7KqqEHcsW0on+a2jyzHqjC22DV2cTLO6nORB/3MxcCft7bYv8zkT7/A9GpNiTmvXSHk9JRpaMXYJId19OcEbpKTeZced/0FsvZ8Wc86KslHvKvYTg3okIWH6Q5zzLZ9ofSYJTugpS7/NvylLFQyoVTASnIp9bMHDyN8ELmNjno+Ngj0B7okJH5lVk8isDQgaYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QP5gQ/BPyAf3vHY5H0bGQJCwjnkd6erXoJsQonu7S64=;
 b=OqPF3iweN99VaIqjw8HDUnNhhDyuk2Gqvk2wq0qVFfWDL++oYgiQf995N9+OJpzOpLIq2X2FV6v20kfRo5uD+a5VPqDiQ1UtNh9WZstLi/yEJoZvp9Hxw3zE/ZA4idmwhwNlPdx/O2tvYC6kWu1IgbicmfRkRT44ayxeI1O7plAboPSNfPaLG31VVOqW69WmhrwrShjhMmaB26JLNHFPNHMoKnhP+3J9j+sMsz4+tlHvcfkgA0+7ZhLT0wWl0P4NecKhJvBKCYgEVR+gDKQxyBnwo+llj4CLQZyjNgcxjRv6XvqFRZzAXEJ4tlLbz5UKYos87qxYLLhJLxs4sJuvww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QP5gQ/BPyAf3vHY5H0bGQJCwjnkd6erXoJsQonu7S64=;
 b=QT1hzGr/I1GsjC/JmL+WljxHxHJrdBy9rBdPK2QAfX7ekp0t6aG4iiS14GR3v+QXhBM7twWTtV0gp1AblvGEwbvwpQ90ZJ2jl/ZW1I51GW8TO8ya4Z5kn8Z8Jm+Sv1jvOO7vKTfkzZDJj7dE8ack0C1O5HExVa0345D8IJfCfG8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SJ1PR12MB6338.namprd12.prod.outlook.com (2603:10b6:a03:455::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Mon, 6 May
 2024 07:31:58 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::af7d:5f4f:2139:ebd1]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::af7d:5f4f:2139:ebd1%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 07:31:58 +0000
Message-ID: <3488f733-c920-4e2a-86f7-05dc1779685e@amd.com>
Date: Mon, 6 May 2024 13:01:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/15] iommu/amd: Setup GCR3 table in advance if domain
 is SVA capable
To: Klara Modin <klarasmodin@gmail.com>, iommu@lists.linux.dev,
 joro@8bytes.org
Cc: suravee.suthikulpanit@amd.com, wei.huang2@amd.com, jsnitsel@redhat.com,
 jgg@ziepe.ca, Jason Gunthorpe <jgg@nvidia.com>
References: <20240418103400.6229-1-vasant.hegde@amd.com>
 <20240418103400.6229-8-vasant.hegde@amd.com>
 <333e6eb6-361c-4afb-8107-2573324bf689@gmail.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <333e6eb6-361c-4afb-8107-2573324bf689@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0176.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::18) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SJ1PR12MB6338:EE_
X-MS-Office365-Filtering-Correlation-Id: 66e3124c-f957-4a8c-b639-08dc6d9e9c92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXNmbFlndlRlcXpQNWdJSWJCU1IxUEJIZytKbVBpOUhqMlRkUTNGdW5iR2tw?=
 =?utf-8?B?dS9FKzdLc0VXU0QwOE9kR29qRHJNVGlOekE1VWFXZ3JzcmZRbmlYelJIcVYx?=
 =?utf-8?B?Umt4bXNMSUlOcjBZUUVuMnZPMEJMRTRPRGowakIvUlI4S2w5UGsxV1I2VVMr?=
 =?utf-8?B?R1hyQ3NUT1lFVXpsUjB4cVFWTDFja0czcURZV2FPczFoSEpaTHRZVWNIWWEy?=
 =?utf-8?B?Qmh0VmdMb3BDSy9xVnk2UWdtMExzWmtEd0cyaDlLQ2RVOXd5RlZBVy9lL3Vq?=
 =?utf-8?B?ZEw0dk4wK2ZmalZ3MnNPMXJDSHo1L0tYSk1NSlpmeTRWb3ZnUHU5RUFGcUlU?=
 =?utf-8?B?Ymp6STR1UExkL2VyNkZrR0RFL1hJMTh1cWN5b2NNaGtkcGI5bCtLWkI1Q2dR?=
 =?utf-8?B?R0p1THVtejE3L29QRThMZVlUUHBOWHJEMVZwWmFCYnpzakdacCsvaThxcXdS?=
 =?utf-8?B?RURJajh2TUdSclhuVHBGc1B0Z0N5ZDBZV05Lbm9LcTV5cUNraTRtaTdIMGJZ?=
 =?utf-8?B?NlhGMld4eWI5eC8ydENuREUxQVVZcGFYeUUvYTBOOVpFRFRlUnM5ZWxDem0v?=
 =?utf-8?B?N0l4WGg5VXBpMGtyZGFQaUdyK3pPTU1PNlJBajRuS3dPU3hrN2NQTHIxQjZC?=
 =?utf-8?B?UE42dEdhLzNWbmo3Rkdqd0ZnOUFOZC9TMWtjQzV1akpoKzhvYTc1aHdPeFk5?=
 =?utf-8?B?czlWZUdvZ3NNMVVpRzVLK0trc1J6WXV3Y21GQWJpaEEreEsvTHRrZW80ZGN1?=
 =?utf-8?B?VHdwRTVIZUVNL2E0Q3NaSStPaXppNDNiR0oxYVU2N0N2SEtwZ0FmYWpCN2dR?=
 =?utf-8?B?a3JNeHhJb1U3KzVveVJFWUl3VjgwbTFSUDVZb2lmTks3TEJubzM3WFVsdXlP?=
 =?utf-8?B?Y0h5S1FOYmtESEtRZ3MzMWlya3V5Nmx3djQzcFRoSllHZkQ3Z1BlSTlKOTdr?=
 =?utf-8?B?VVhjQ1VUY1dHV3BVSGVLdVNTZVo0TTgvaGlWR1BsV28zeElscS9ScFoxNmwy?=
 =?utf-8?B?S3E2TTBnVGQ3Vm42Vld0VllHV0hOYW9pd1hhQnYwdURPQzdKMC82MmdoUktF?=
 =?utf-8?B?RlZxcXE2VDhLeVhSQzdnRzFpOVVxQkVsbGIxdll6aVJ0dWJ3UGlwYzRSTkpx?=
 =?utf-8?B?TFhUN2xEK2hhRHlqL1hhS2hLSERUTksvSGJqVGo5bGxlYy9OU3pEL3YySjAv?=
 =?utf-8?B?RXk0Z0w2WExVQUJYbWFoVjBBZHBUcStCdEw4RHlkdUJmbDByNEVzYmU0Y216?=
 =?utf-8?B?QkcvRE1jblo3M3BocnpNVmhTSXU1MU9Ec1ZIQ3dIcHNTYmVpTDEyc0xpMi80?=
 =?utf-8?B?bXVWT2t3WU1SaVRaWmhFdTdzNzIyTjlqRUptU3htSXhvd2JmK2hCanpHUUxD?=
 =?utf-8?B?dENaUWJnaWFHZGt6ZzRONTAvTUtOQXFBallwMGkvbnJGR3RwbTczMEJVblhv?=
 =?utf-8?B?ZFlqUFowdTJmOHNCdVpaQWpvYTVJWVdvcUkycjd4R2NXeXloZmdmUDJYRjFM?=
 =?utf-8?B?Z2I4TDAwdjRIZ0hTU2xkTGg0YjF1bXdpbGxOb2QwQm1kWFlsM0h4cGM4eDQy?=
 =?utf-8?B?M1VxdmVRRmRyem4zT1g1dXJac2ZDcEpGMjNvcmdSanlodTZIUmZrU05ZdVhn?=
 =?utf-8?B?TFdSd2x6cFdYazlOUksyT3Bjd3B6dlJEQVU1TitxeEw0UCtrNTdvck5DTk5C?=
 =?utf-8?B?RCtDTWpXcWk2WVd4SlJCM2pjWk15WnZqRkdiKzdVZHZQSFF2MU0wSk5nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTRqWHRWc0s4SmNGb1l2VEp6eC95RDBaN0R4WU82VzlENHViOCtxMFk2cXcr?=
 =?utf-8?B?VHV2STlNNFpmcTNzMWMzZjFXTjZDTzBjdmEwenpWQVJGS041QnM5bU5pTjIx?=
 =?utf-8?B?c3UxYlZ2UjUvcVdGeHdxZkd3ZlMzV2wrMlp0T2Vncnp3U1NOeFdDc0hpKzI1?=
 =?utf-8?B?N1JQNnJlSVQ5WUh4bUFPS0l0dDUxSVgvbkNCb2daUVZpSXpVbkMvMXhWYU03?=
 =?utf-8?B?QURSaU9hSW9IZWx5NHlPTU44TStRaFlQNFB6enVSTWVNdUNWemVvWlZTRHNP?=
 =?utf-8?B?Y2hMVUxGWEkwMVliM2JQZ2wzTll2RzdtbjFBRzdnNUROM3Nzbm1JUzlIWUJu?=
 =?utf-8?B?MWczTmtXOE9PNFgwZGc3OUdIK1lSTURMWFJud2pqcEVZaEFBdmxOTGtOekdS?=
 =?utf-8?B?VXNneG81RHJIT0RmSWMxcDJIaGlSd0x6ZnlRWHNUcWZKbVFmY1FLeWRSMGRS?=
 =?utf-8?B?VnBNSVEwZVZPMTVoVVpmcE5XeXRaUTVmVDNjMEZZV0p5UkxYRFNsRjFIdFU0?=
 =?utf-8?B?RlVwbmFTOGU1SFZvd3NLM2IrcGF0TTlOQzVQQUFMekY0eUpIOUY3V0NLWkF6?=
 =?utf-8?B?LzFlSlpxMGJmRjNOZjRVbnZZdjE5OG5MdGlhaFgzWU44VVdacXJjQjQrek1t?=
 =?utf-8?B?MnA2UUwwS3JPNEtIVkk2K05jc1NhOCtTS2Y2RjhKdStlV0R4RXNEekp3dWdC?=
 =?utf-8?B?VTJ4b3IxME5jN2Y1UGx5TndteVduenl1OXE4WGtWaU1FMWNQVlNvVnMxLzAw?=
 =?utf-8?B?elBZdTJNdEZuVksxTWdLZlUvdFZOaVcxbGUxUGlpRUxCbVdmUFdlUnZjclI0?=
 =?utf-8?B?L3FzNGJ6bFNtRC9ZOHQ0Wm16Z2FXT29XR1JJbmlOQ2lkVk41SmdyZFhHdmh1?=
 =?utf-8?B?OWd1aTNOZUQ4WG04NjFQRk1kYm5MQVhvSXJOV2dJM24xczAwOE9SRWNQS3di?=
 =?utf-8?B?ckpmTjNoQ3doQWlZMjJ1Y3dyQ1dvQ0R1MlBoUEtodjFzWkFpNEE1TGQ2TnZG?=
 =?utf-8?B?R29Oa09pZXBCcmFZOGxEdDlHQkNuUW1CQUdRUnNiWTZiTkdNRSs5UmdSSEE3?=
 =?utf-8?B?K2pPSXlUc3dNamVHTmROWVhNTDZOY0xscWZuRTRtNjZlMXRPQXhjUTZsY3pQ?=
 =?utf-8?B?cXZ5ZlRPcVErRVNQZzZKMHB5TlpRQ01xS2d6WmFWTk1TaUYwNFNjNE8rb2pF?=
 =?utf-8?B?SVp0TTR2TENOSVd3OU9GUGNCRFNWV25LYzlpVXN1K29YQ21jRWVLbjVtM2E5?=
 =?utf-8?B?Y1kwOW1kejZvSTkvR2hYQTBvdlpybDl6WktVUWFLTjZsTk1XRHZkeUFMdGxI?=
 =?utf-8?B?dzZVbjlkNHAzSWl2YXc1Y1pXT2xrd1ZxQTVmVWtQV3FMUG5zeWt6dzJ4dW1T?=
 =?utf-8?B?YXg5OEhmcXJsTVY1TWUzTXhGN0ROZWZjWUt0YzJsYU91ZmtHdHdqaWlCcU9F?=
 =?utf-8?B?clJjRmh1RnMvM0kyZy9wTyt0UHR4RXFna3lHSTBwSmNlakp6Z1dhRGtRSGNR?=
 =?utf-8?B?eHNyRzYwSDR4allLRmZEK2k3YXFRUXdpdFhvYlh6bUMyRytQQ2laUklxZnhM?=
 =?utf-8?B?RTNyem9zL2pRTndtNGdiUDd4SU5VQlFkM05zVHl5d0kvS1l3RXBMSENpaitY?=
 =?utf-8?B?NzE1Zy8rWXdIbmFENkNVMXdMNGR1TmZ2RTBSVkJLaVlPcWJtdDI3dUxPWGdZ?=
 =?utf-8?B?ODdTaGJ4R04xTHFTY1RpTWZGNlZzcldYR3g2U295c1J3ZkxBQUF4WDlqdStW?=
 =?utf-8?B?OFcrOFl1Uzh6cUhCMEV2Um14eWJEWXJuYUN0YUJJKytTSXNuWG1kSkQ3eEtz?=
 =?utf-8?B?UWtGNXlKdjFLYUpHaThjclhTd1BrREk1SUFUeExBQWg1QXNCUVErYUJtbHlL?=
 =?utf-8?B?VFFDalphYjFRR2FjU2JXWUl1L0RocFVxTDZBK0gzallIbGxpUVFnYm14RDdH?=
 =?utf-8?B?UnNIckc1VGU5ZHY4NWxzWDVnVkN2MW1pVkVOS2ZpQVdMcDNsaVRzWmN0WEhw?=
 =?utf-8?B?VGxBYlYxTEkxcTJVVFZ4TkxTeHIzSmtCTVBma3ZBWGQxek9ieGFNVG1MMEJY?=
 =?utf-8?B?dlo1eWM4dWdxWGpmS1lqZWZCUWMvQ3NVYnNxUjY0VCtQK2RiMytNRE1YeGRE?=
 =?utf-8?Q?XskSbMxal+1+VkOBMEqN1/Pg2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e3124c-f957-4a8c-b639-08dc6d9e9c92
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 07:31:58.2669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2A+Hdhd4dyGs2HdrU/lDa6OPgwAGWA/OJ+pZE2Y2Q8gDgDmcjrbb74kwfByJCeIU+zStgErm9D1VAmatKVY2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6338

Hi Klara,


On 5/2/2024 6:46 PM, Klara Modin wrote:
> Hi,
> 
> On 2024-04-18 12:33, Vasant Hegde wrote:
>> SVA can be supported if domain is in passthrough mode or paging domain
>> with v2 page table. Current code sets up GCR3 table for domain with v2
>> page table only. Setup GCR3 table for all SVA capable domains.
>>
>>    - Move GCR3 init/destroy to separate function.
>>
>>    - Change default GCR3 table to use MAX supported PASIDs. Ideally it
>>      should use 1 level PASID table as its using PASID zero only. But we
>>      don't have support to extend PASID table yet. We will fix this later.
>>
>>    - When domain is configured with passthrough mode, allocate default GCR3
>>      table only if device is SVA capable.
>>
>> Note that in attach_device() path it will not know whether device will use
>> SVA or not. If device is attached to passthrough domain and if it doesn't
>> use SVA then GCR3 table will never be used. We will endup wasting memory
>> allocated for GCR3 table. This is done to avoid DTE update when
>> attaching PASID to device.
>>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>> ---
>>   drivers/iommu/amd/iommu.c | 86 ++++++++++++++++++++++++++++++++-------
>>   1 file changed, 71 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index 7daf6d75d964..288cf7485306 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -89,6 +89,21 @@ static inline bool pdom_is_v2_pgtbl_mode(struct
>> protection_domain *pdom)
>>       return (pdom && (pdom->pd_mode == PD_MODE_V2));
>>   }
>>   +static inline bool pdom_is_in_pt_mode(struct protection_domain *pdom)
>> +{
>> +    return (pdom->domain.type == IOMMU_DOMAIN_IDENTITY);
>> +}
>> +
>> +/*
>> + * We cannot support PASID w/ existing v1 page table in the same domain
>> + * since it will be nested. However, existing domain w/ v2 page table
>> + * or passthrough mode can be used for PASID.
>> + */
>> +static inline bool pdom_is_sva_capable(struct protection_domain *pdom)
>> +{
>> +    return pdom_is_v2_pgtbl_mode(pdom) || pdom_is_in_pt_mode(pdom);
>> +}
>> +
>>   static inline int get_acpihid_device_id(struct device *dev,
>>                       struct acpihid_map_entry **entry)
>>   {
>> @@ -1964,6 +1979,58 @@ void amd_iommu_dev_update_dte(struct iommu_dev_data
>> *dev_data, bool set)
>>       iommu_completion_wait(iommu);
>>   }
>>   +/*
>> + * If domain is SVA capable then initialize GCR3 table. Also if domain is
>> + * in v2 page table mode then update GCR3[0].
>> + */
>> +static int init_gcr3_table(struct iommu_dev_data *dev_data,
>> +               struct protection_domain *pdom)
>> +{
>> +    struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
>> +    int max_pasids = dev_data->max_pasids;
>> +    int ret = 0;
>> +
>> +     /*
>> +      * If domain is in pt mode then setup GCR3 table only if device
>> +      * is PASID capable
>> +      */
>> +    if (pdom_is_in_pt_mode(pdom) && !pdev_pasid_supported(dev_data))
>> +        return ret;
>> +
>> +    /*
>> +     * By default, setup GCR3 table to support MAX PASIDs
>> +     * supported by the device/IOMMU.
>> +     */
>> +    ret = setup_gcr3_table(&dev_data->gcr3_info, iommu,
>> +                   max_pasids > 0 ?  max_pasids : 1);
>> +    if (ret)
>> +        return ret;
>> +
>> +    /* Setup GCR3[0] only if domain is setup with v2 page table mode */
>> +    if (!pdom_is_v2_pgtbl_mode(pdom))
>> +        return ret;
>> +
>> +    ret = update_gcr3(dev_data, 0, iommu_virt_to_phys(pdom->iop.pgd), true);
>> +    if (ret)
>> +        free_gcr3_table(&dev_data->gcr3_info);
>> +
>> +    return ret;
>> +}
>> +
>> +static void destroy_gcr3_table(struct iommu_dev_data *dev_data,
>> +                   struct protection_domain *pdom)
>> +{
>> +    struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
>> +
>> +    if (pdom_is_v2_pgtbl_mode(pdom))
>> +        update_gcr3(dev_data, 0, 0, false);
>> +
>> +    if (gcr3_info->gcr3_tbl == NULL)
>> +        return;
>> +
>> +    free_gcr3_table(gcr3_info);
>> +}
>> +
>>   static int do_attach(struct iommu_dev_data *dev_data,
>>                struct protection_domain *domain)
>>   {
>> @@ -1982,19 +2049,10 @@ static int do_attach(struct iommu_dev_data *dev_data,
>>       domain->dev_iommu[iommu->index] += 1;
>>       domain->dev_cnt                 += 1;
>>   -    /* Init GCR3 table and update device table */
>> -    if (domain->pd_mode == PD_MODE_V2) {
>> -        /* By default, setup GCR3 table to support single PASID */
>> -        ret = setup_gcr3_table(&dev_data->gcr3_info, iommu, 1);
>> +    if (pdom_is_sva_capable(domain)) {
>> +        ret = init_gcr3_table(dev_data, domain);
>>           if (ret)
>>               return ret;
>> -
>> -        ret = update_gcr3(dev_data, 0,
>> -                  iommu_virt_to_phys(domain->iop.pgd), true);
>> -        if (ret) {
>> -            free_gcr3_table(&dev_data->gcr3_info);
>> -            return ret;
>> -        }
>>       }
>>         /* Update device table */
>> @@ -2009,10 +2067,8 @@ static void do_detach(struct iommu_dev_data *dev_data)
>>       struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
>>         /* Clear GCR3 table */
>> -    if (domain->pd_mode == PD_MODE_V2) {
>> -        update_gcr3(dev_data, 0, 0, false);
>> -        free_gcr3_table(&dev_data->gcr3_info);
>> -    }
>> +    if (pdom_is_sva_capable(domain))
>> +        destroy_gcr3_table(dev_data, domain);
>>         /* Update data structures */
>>       dev_data->domain = NULL;
> 
> This change seems to interact poorly with the amdgpu driver. It fails to
> initialize properly (monitors go to sleep).
> 
> The full log is attached, this snippet happens immediately before the first
> warning:
> amdgpu 0000:2d:00.0: amdgpu: STB initialized to 2048 entries
> [drm] Loading DMUB firmware via PSP: version=0x02020020
> [drm] use_doorbell being set to: [true]
> [drm] use_doorbell being set to: [true]
> [drm] Found VCN firmware Version ENC: 1.30 DEC: 3 VEP: 0 Revision: 4
> amdgpu 0000:2d:00.0: amdgpu: Will use PSP to load VCN firmware
> iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:2d:00.0
> pasid=0x00000 address=0x11c300000 flags=0x0080]
> AMD-Vi: DTE[0]: 7d80000000000003
> AMD-Vi: DTE[1]: 0000100011700014
> AMD-Vi: DTE[2]: 0000000000000000
> AMD-Vi: DTE[3]: 0000000000000000
> r8169 0000:05:00.0 enp5s0: Link is Up - 1Gbps/Full - flow control rx/tx
> amdgpu 0000:2d:00.0: amdgpu: PSP load kdb failed!
> [drm:psp_v11_0_ring_destroy [amdgpu]] *ERROR* Fail to stop psp ring
> [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear memory with ring
> turned off.
> 
> Please let me know if this is the wrong place to report this or there's anything
> else you need.

Thanks for the report.

Looking into the attached dmesg :

2024-04-29T10:35:05+02:00 soda.int.kasm.eu kernel: AMD-Vi: Using global IVHD
EFR:0x0, EFR2:0x0

--> This means BIOS didn't setup the EFR flags in ACPI IVRS table (its BIOS issue).

Commit 8e0179733172 (iommu/amd: Enable Guest Translation before registering
devices) changed GT feature enablement in control register.

Now it tries to enable CONTROL[GT] flag before reading IOMMU feature register
(late_iommu_features_init()).

In attach device path, it assumed GT is supported (based on IOMMU EFR register
value) and enabled DTE[GV]. Hence we hit ILLEGAL_DEV_TABLE_ENTRY error.


Can you please try below fix?


-Vasant

---


diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index fd3e76e43699..b292181995b7 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2046,6 +2046,8 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 			amd_iommu_max_glx_val = glxval;
 		else
 			amd_iommu_max_glx_val = min(amd_iommu_max_glx_val, glxval);
+
+		iommu_enable_gt(iommu);
 	}

 	if (check_feature(FEATURE_PPR) && amd_iommu_alloc_ppr_log(iommu))
@@ -2732,7 +2734,6 @@ static void early_enable_iommu(struct amd_iommu *iommu)
 	iommu_enable_command_buffer(iommu);
 	iommu_enable_event_buffer(iommu);
 	iommu_set_exclusion_range(iommu);
-	iommu_enable_gt(iommu);
 	iommu_enable_ga(iommu);
 	iommu_enable_xt(iommu);
 	iommu_enable_irtcachedis(iommu);
@@ -2789,7 +2790,6 @@ static void early_enable_iommus(void)
 			iommu_disable_irtcachedis(iommu);
 			iommu_enable_command_buffer(iommu);
 			iommu_enable_event_buffer(iommu);
-			iommu_enable_gt(iommu);
 			iommu_enable_ga(iommu);
 			iommu_enable_xt(iommu);
 			iommu_enable_irtcachedis(iommu);
