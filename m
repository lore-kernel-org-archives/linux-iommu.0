Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A8A254874
	for <iommu@lists.linux.dev>; Wed,  2 Jul 2025 09:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449512; cv=fail; b=gbhtWgrpzn/U6uFV/OqzK0i75c/GB/5qCEiJbzlP0w2wXoEmR8jNPXdePyNbZrq6ZhD5cOJUyoeI9no6kWRd5sXPHjVmjfb8fcWEEonIhBp7UIIc8vymplnYsLSEem9W3hm1JDs9gjh3BeUXeGQpx4+wB5R4cuk4TUKtkxkBil4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449512; c=relaxed/simple;
	bh=4i9SqKP9egU62CLbc8J0O7CGQqKNFUq65F4LFrLNCH8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YKnByMP8tWbcCKSKbB1eB4HrHLessVQQnjDG29NuoR+iBcQhEBofRSlFUMnqQks9Jc8y5gGTn4DUp/6rJ15tDLNaORyXxkk7H0ySbQh0+8yabMHCXQUHE0ZDUTmWbU6woPgIg5MIoAgEIVUReMu+h1aap6mHA/V7z3U+QNogCuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0lYWb11D; arc=fail smtp.client-ip=40.107.237.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0lYWb11D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EeOk3tmZY4JTuODwnJ/z+KjikGv2dcpZTduaIVSlSHLXp9aKGAL/4wFMDXNewuWOpsAJjhjhP2G751xz2DQBwID425NmX2g6qeVaSvGTGMgvsWjHi4gcwt2MY04yiLIqvXi23OGZbS4Lv1VdHuf9ZnICjqcCjcCcq8GeTT27MYJMzEGBfiIVTFiuO0TmsOMWwan4oF0FXccGbBJrOOMQ7VHj1ZDhzBN4JaUpoSF71dW8qX9fYGiCLdRg+kt/vnRQKIqBZqSLByoH4WpI3HHwn+RzSARtShccEFOUGGdg4CqpYD4TsqB1PYelysXFl4L766yEFN5agIt+ioAP0B1Vug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8LJ+4uCjtV6W2ZzUUmy+EkSbODZ0ojMlqBV8YBUN8A=;
 b=uTaeSSpBzzldUN+40JOipEXKRZm2ZItrZMgxucBjb67sgpg2Gd5di6oNE5b4BT0VP9L8IWJitBN1xNJ6NWhGiPM2q0oHpaNP3Ea7LKNpffN617yLxX3v0XLYWTWvzPw/l0bqbcfDOnjdtOn/Wpr+tgM+0Fguz4LkJhdeoOYc2qLcvodrFl9j5jTUoGHmXad1P/6Lg1YflgTA5o+i3dWX/w/kvEjfeZzeoT7FOrVeXmSHOfGcyFjgwNWZJ9SwKzuocgoizF/fUZ5FT0g4RDmNf3n99MyTVLkA/j5KjrRPatMlirosPaUgvuzn5TDdO4+PP77yLrlKomLbvLAx/U4s7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8LJ+4uCjtV6W2ZzUUmy+EkSbODZ0ojMlqBV8YBUN8A=;
 b=0lYWb11DsWKiXHHWcOIyUKu7a85RBK2Kam43SleR/XHu8ywCGMivrbOy4jPos7xZhCzSuS4hmNxpzZR/YfZCBvYXPEMzajB20iJDAQFp/50b6dOWfvRnRNQTFWgCGy9uU1BTqU1TmBsYU0xu60urrtbSGBKHouxeYLcfd334Kxg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5163.namprd12.prod.outlook.com (2603:10b6:408:11c::7)
 by SJ0PR12MB6880.namprd12.prod.outlook.com (2603:10b6:a03:485::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Wed, 2 Jul
 2025 09:45:07 +0000
Received: from BN9PR12MB5163.namprd12.prod.outlook.com
 ([fe80::61ca:6d43:a98d:3b7f]) by BN9PR12MB5163.namprd12.prod.outlook.com
 ([fe80::61ca:6d43:a98d:3b7f%4]) with mapi id 15.20.8880.026; Wed, 2 Jul 2025
 09:45:06 +0000
Message-ID: <bdeb6955-9288-41ec-ba36-56fc48127c0e@amd.com>
Date: Wed, 2 Jul 2025 15:15:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/8] Introduce debugfs support in IOMMU
To: Vasant Hegde <vasant.hegde@amd.com>, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, will@kernel.org, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20250604163647.1439-1-dheerajkumar.srivastava@amd.com>
 <b3500475-f6e8-42fe-85bb-baca2b67d7a6@amd.com>
Content-Language: en-US
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
In-Reply-To: <b3500475-f6e8-42fe-85bb-baca2b67d7a6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0117.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::21) To BN9PR12MB5163.namprd12.prod.outlook.com
 (2603:10b6:408:11c::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5163:EE_|SJ0PR12MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: 512ff3a6-f303-4c90-1b11-08ddb94d206f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SFB2RTR5a1hZblY1aU1INE40NU9sck9xMkdzY0ltWk16bVlVWmk5RlJ2VkMx?=
 =?utf-8?B?R2VzSnpGVTAremgvdmFPMDh3QWNxZmYrcGFKcC93NmJSWkMxSkxVOFdzakRN?=
 =?utf-8?B?QURMaGZhalduT0Y2SEhWaEcwMnplUEp5OWJQV2p4Rk5GOEdyTTlqcFNabFE4?=
 =?utf-8?B?bFRGTVRKRVZ5UUdsRzRJRFhSMloyZTB1QkZoZTRCWUVjeFdSbEs3b2NkcWpm?=
 =?utf-8?B?SW5tQTU4WmsxT3JrWnRGSFBtTVBkRGtDc3AxSklYL0N3Z25ldFZpZmg4YUJr?=
 =?utf-8?B?UmpiV1VaM2NPdDFYM2dxSzkzaUVXNVR3YmpmV0IxdHBSVEZSVEFMU3F0L3FY?=
 =?utf-8?B?Qk9jTE5jbUI4UmhDOEZtNDVOYm1ldWNpVEorbGRSSXhLSStPQlFnSE9qbjl2?=
 =?utf-8?B?VkV3ZE9OVCt2WFlwam45MVJyUEZVVEh2MWtOVUVBQ3BEb1NSdzdPd3JZVjRx?=
 =?utf-8?B?QWpFRmx1d254bEpoYUdnajFqcHU5elR1UE1sQ3RhcjFncVdVRVFHQmMzc1l4?=
 =?utf-8?B?eVJJbDBRSjI0djFqcXpzWENteFRDT0NVL2JjcnFCZDlNbjVxV2drYXk5Y1hP?=
 =?utf-8?B?UGpNS2NpcVlxWGd6eG56VGRiVTJ1Qno2Nkdha1AzbkRGSDluMkZSZWZHVjZ2?=
 =?utf-8?B?Wi9vR0lFWUN5Nm50Z0tjSGorVHYrQnlQbDdHTjVub2FKeTc2RXp6Z3ZEc29i?=
 =?utf-8?B?VE12UzdTdk5vdm9LWUZQV09BQWZWVFJvVC9DdWNTY1BIZGt3OG8zSDMwOFFn?=
 =?utf-8?B?MXlpNHdPMmJVWFh3MFJISW9SZHhhRW52a0tDeFdGS2xsZFdYVkloSkdNWHhZ?=
 =?utf-8?B?TEpKQ1pGcDBuMi9BWitYMUx3UTdJM01mWGs1dmR4dzduTHJmMEYyOXhWN2oy?=
 =?utf-8?B?blZpeGhodVY2VWhaT3FMbzR1bTIxNEFLMHZCMnhHYmExenFZNElXV3lGMDdQ?=
 =?utf-8?B?YVdWQkcvd044Q3VvWTFkK2IwbGpXN01FN0xUcG5JYnpFZEpjU1FicWhTaHBz?=
 =?utf-8?B?bmsvSkFSd3hMcUgxWXlkVG50dHB5QkpydDVOSFRIdHJreHRMaitTMTFWN09T?=
 =?utf-8?B?dnpHUS9MOHRjcktyMTJoM1QzNmdUa3A1M1hseFBvZHlibm9kKy9lOEkwSzZn?=
 =?utf-8?B?blMzTnRpcklGbnEzaEFnemZPTmdVT1p1NW8yU013MFJNdk5WUVUwUkd1czZh?=
 =?utf-8?B?b1BpRndNdnQ4ZDF4SkI4aGM1b2V3T2c2VjYvRXhEVzBJNnJUNC9oUHZyM0dO?=
 =?utf-8?B?amFRTDR2cVAxdCtlbVUvZWdOcEZjN25LOTdiNFpra1FpWWRGV29BVWpUTGQ4?=
 =?utf-8?B?QnNPU3JJQjRYT1BhVDh0TTdMeTNkdnpNV0xCcnlNUnlJZi8yQjhoNHAvM2d4?=
 =?utf-8?B?NE5zNHVDS1FubTU1SDBvVldBdVJ4UHU0dDdMWmVxRVJnclBKNUFFOVJxUkMy?=
 =?utf-8?B?cmdRNWhCQkxsMjcvZE8yZXdTMkVTdEtmcmdCYVRudmgza0w5bWpQUFJKU0J0?=
 =?utf-8?B?RDhtV1ZKNXYzUHV3MmV3N2hJd01qenBuZ2pmRCtGRUw5Wk1SblNUTFA4N3Rs?=
 =?utf-8?B?UWtlWkFkck0zMWZLQm9VcjdmWUNrRllDM0F4WU5LUTFyV3c5djNuKytnNEc0?=
 =?utf-8?B?TGtiamw3OWFjWnBnWEZGcmFrc1FJM0dETVBpVnRTdVRKRElVMkF0ajViSnRu?=
 =?utf-8?B?T2xna09BRDg4WmIxS2hzSUxhaGYrU0FNV1pUTmVaTm5uREJvZFdPTWFScjFP?=
 =?utf-8?B?R2R3cFZKUTVPRzFjeDRQdVFVT1hDNDZEdnkwTllNMGlBNGVId3NBMElzWmRL?=
 =?utf-8?B?eVZaY21LNzRmWVA4OEZRSGZlK3NtcjRUeXNFTXRJMFJLTkZpMmYzV21EWC9l?=
 =?utf-8?B?Q2ExZFZPR1duWHE2VWxSbVE0YmhyZExIaWVwYnBDTnJRRWZvak1veVRNY2pB?=
 =?utf-8?Q?5mvr8dHADf4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bk93V1NodWd1RFNEV1F4WXdjdDd0Z29tV2NYNlhERTJFZVh5QzlYWHZienVW?=
 =?utf-8?B?Vm9CempmRGVWZUFHcW1XdkIrSFpCQlduTnNqSS9oTzV6a01CMEV3dEpwNXVI?=
 =?utf-8?B?SXNQWGpSSlMxcmNLSWdxN2xPZmRkT2VqNENpZWpYQTZCQ0xxcGNreDAwdWVD?=
 =?utf-8?B?RUJLR2pVdjZnbktzQ0xjVXU2NE0vNzd6bGIrekY0YmgvSXZuZ2VueWs2ZGRX?=
 =?utf-8?B?ZUVHNjBFaUd0djVnZXViNFpscjJBM1ZCY0l1NTBLMFVia09vOTJ3cEpEQS9L?=
 =?utf-8?B?Qjdmc2xkMzdBUVY4TXNQSUlEMVB5OTVJNHNCUURhWDFSS2JjcmNVZmNGeEl1?=
 =?utf-8?B?RmlFU01NQzEzaGp1VmwzYTdiUWhodHpmenBlVzVZS1h1S0xRYmFHVS9WUVQ4?=
 =?utf-8?B?ZFlWNDlpMXBTbzNSNGpxNUxocHBhcnJjVnJWZk9WN2cvZThROStpZFluV2Fx?=
 =?utf-8?B?aktjcGxLSnNuNHhXa3JYUFI3QmIrNUlQOW9yQTFQMGZhQmUyMG50cFpxdm9S?=
 =?utf-8?B?TmFNeTArQUU0dlFKcU9jUjdSQlRyNWdTc3Y3cWZiVlAvWk1TMU9mWUxKZEUw?=
 =?utf-8?B?am15VGYzdkdjU05RK3Zyc0tENWxzN3FjOEZYQkVJRnpoc3hkSm93ZjNReXRt?=
 =?utf-8?B?dFpNeE1QNkRBT1cyenRXL3d5UXV2cU5vTDZCREwyd2NrSFdneEl0MDRqQ3RL?=
 =?utf-8?B?MFZ3NHFBT3RMdVpPeTVSS1dROElEYmdoVUdYRnJpY08ycER0Zi9icmJIdU9S?=
 =?utf-8?B?eUlIelA4TWVwajBmVnJMRGVCZ1o1SzhZUXJ1N1ZxdS91cTZ2dlNjSWNNYkdU?=
 =?utf-8?B?WXhVK2tnSmRHbXhHRHQ0RHpNOVdBUmovMXBQTm1sQTdFVThUaGFBakE4NWVz?=
 =?utf-8?B?ZXdKUUN2aDArM25ORWsrTXNaVjhCcUpUSm1ieE5FclNwODdWdUd1Zmw3OTJF?=
 =?utf-8?B?NGhyZTUzNG5IekJ2QlFCQk0xVFNIWlUvY0x2OU01d0VSZ0xqVFAvc2E0akJz?=
 =?utf-8?B?TnhoUFU0MzdvRlE1c2NEN2xNQ2xPVGtYU1MvbHE2emNWQVZpTHVaYkw0azR4?=
 =?utf-8?B?SHdzN09WWGhqM3hEZHgwQTdIQ2krQUNIaUE3dmViT1lvSi9IczlwWVZzQnlP?=
 =?utf-8?B?MXdGVGRUTllxUUZld3hRM21OL1UvclNzQ2FZYVNGc3pmcGIvSHU5WnJDWUxK?=
 =?utf-8?B?TW5mUmNHdHhBOXFwcXZ0aWgyV2N5VzZsSmRtbEQyQmdzcHZUZVJvSS9qdlNp?=
 =?utf-8?B?bHZyUHNxUFc5ZmVPVDhtM09zU0p0ZGNIQWl5VVBUeG5Lck0yenJ5a1hoQjIy?=
 =?utf-8?B?MUJTbGtiQUthdm9BY2tvbERRZk1hU29pNmwremtMWjU5REprRlRrakpmR3cr?=
 =?utf-8?B?eDdCbDVha3dXcitjcjRkeG1yR2drZTlwRW1FZUR5NSsvOWZiUzlHUkkvaVQv?=
 =?utf-8?B?aHBwVmJOV3YwY0VuOElVbmVOaGFkNkh1OElzM0lBbkcwaEg1RFhCNWFscGtR?=
 =?utf-8?B?RFJPSmZpZnNvcnh1REdqNk1rZklJQTBQRm9SWDZKTTVWNWhDVnQ0VFJHZ3NJ?=
 =?utf-8?B?RjhpRmFRV2pQZ3Y3OTUvOXU2WDduQ1FuOUJOUGcwN2tieTdFakp1cVlkd3lq?=
 =?utf-8?B?RWpldTJ6aUNmOFlTUUNrempBanNTUCtnKy9JcnhJcVBjbFArbEtpaXNIWkk3?=
 =?utf-8?B?N3BTbzVGdk4vcXRaeFBmY0YzNmhyVTZYb2s3Q09qL0JQQlhTaFlVdy9uVVhE?=
 =?utf-8?B?Z1BnWXp4SUVna3I4MnJxMVZDaUdWYitjVkxrT0R1dDI2cWRybFlLekdnK2xs?=
 =?utf-8?B?T3FsYlVJQU5sRmlSdThFUEF3SkRIeCtwN2lkTXk5V1JVNGpHTXZQZ2kzVlA4?=
 =?utf-8?B?OGpsbU8wc2Vzd2RhVTJZdlVha2liUmEzVlc4TlNDd0pPTFlWbldQNXFvY3BZ?=
 =?utf-8?B?d1IvWjRqMzdIN0RGeDJBQ20zbXNhdWF1Y09Hbm4rQjBoRHhpTzlWSjRNU2ky?=
 =?utf-8?B?OUVrYm5QNnNWdU0zc3hxbkpBNUJXMzBlNUl3Rmp2dnVMS05jaitIR01mWDVJ?=
 =?utf-8?B?UFpGSGkxNkMxaVNDcU9rZEZpSWRNaUZlK000cVMwa3JJRE94ODZadEE1SkRK?=
 =?utf-8?Q?F6AsSfc5buBv2MHvwq9chRChJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 512ff3a6-f303-4c90-1b11-08ddb94d206f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 09:45:06.8249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UpfObTMWtCBSZx2eHQ9M8540kAQRka3wmRN+lTUatDlvRke+tlaQePNu5BsOACGdTsi6eV4Mf2hRvC3lIRmzgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6880

Hi Vasant,

On 6/29/2025 11:24 AM, Vasant Hegde wrote:
> Dheeraj,
> 
> 
> On 6/4/2025 10:06 PM, Dheeraj Kumar Srivastava wrote:
>> Introducing debugfs support in AMD/IOMMU driver that will allow
>> userspace to dump below IOMMU information
>> 1) MMIO and Capability register per IOMMU
>> 2) Command buffer
>> 3) Device table entry
>> 4) Interrupt remapping table entry
>>
> 
> Overall this series looks good to me. I have done some level of testing and its
> all fine. I still have few minor comments. Please address them.

Addressed all your review comments on v6 series and posted v7 series. 
Please review.

Thanks
Dheeraj

> 
> -Vasant
> 
> 
> 
> 
> 

