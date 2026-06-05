Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013000.outbound.protection.outlook.com [40.107.201.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8FE38886B
	for <iommu@lists.linux.dev>; Fri,  5 Jun 2026 14:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670517; cv=fail; b=WPhfmfEXCYS8BMv7AGlROD2v/sLwTNSrWppiD+qhqGVy6/FeBY3EwfXOMcC1a6NLkcTZ6PzBg9k0uEoHnAgDkjeTIZ21i4ehICQOydHSFgrae4zlqxnA8nJTmIwlwb9IMCm79aY97GFrMsrx3NZDlNhzNlNvdyHHXwInOc8eib4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670517; c=relaxed/simple;
	bh=pW0JMft9H+mjxfk/9f2a/R1ovwKbyljnlwgzaESvGPE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tRQoaBqWMVWcU1Mxsb4keB/AVW8VVgPpgdUhByL86/68EX8E7tvV69FIvPz12XV0IF8TnznZjgqaBgdA0VsRjJPnb4GOlzp8jBPfK9Z5aP33cz9auTsd9MHyUA4dtqNqAm2k4rx5cspkgn1UCf5NepYCwWf+K6IiX9iHd0tQuvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kfLRavjx; arc=fail smtp.client-ip=40.107.201.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kfLRavjx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V569v7JCXY0UjU1AouL1+Ojgm64tHohsTtnXfA4D+RUABAZx1ydlC1GhTtn7uO37DmqxEUMmGQj3clTud5lIhImbfg7jfs7VZIdn9IrvuMSdA7bG3l/Y0pDLTcqUEoQXpq1ygl7QfAFV0LDOPewwxPJBnhZIN58puTEdBgXFFCCad7zXkiraxMa1upf6SPKrsK37nUdIW+SYCBQF3tyUWYmRKe8IMVhwlaXrPOaCAlppVQFDCEU3qlnO683bFjCR1/ECI3xPvOkxzNPtVhVaiYAkrKpOCJFPX97Mj8COzuX1Ip2oTdjrFqI4zbYnCZuoFQIzfAP/o+UM2/epLoLBQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unalq8zmiM9EGQSJqac2dIMrAg7S+V5bbfwLq+p1rvk=;
 b=jyO8VAvGI3+9Q37SmO41Z8zNPX3F+e7HbPo5ZQ5tGd8oNTFMPrxS0c0zq3HcDsz9YPwyVW6n6jkri2Z4geRJ6P519/asY/NiFU+mKXOf+Wsh6/QgvVI7ogjdj/A/SJovV/lbmqqiOTpruFIFndA3nPMhyNKampA5je+j5xpugMnnHv4vVT5UavHnWEP3G36K7D2jJDIgavm3QpC677E5GJjWWrrCfhVrfvoHNMQowyXpl3AMbaBPqhxEwj01BUpR/PBi+O40l99/oznoa/ntT93yBzlFZ/DPeghAQB7osCf8t3zeb9sFx/CV47kty9sAzy9yGCuyVIErqlJoGsx2Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unalq8zmiM9EGQSJqac2dIMrAg7S+V5bbfwLq+p1rvk=;
 b=kfLRavjxsK0YB0zv+2UFwA6OODQ0WSjTw4UwouIpc7FA4BRWSBYwkUQHfFe9OIdQX7jfRjoPLEMMhVG+Pw6Hu3MhVebRYAofACVymQktk6+d+3ohV4ItJG0l5GEXssaBRD13ClKUVAYQbg1BbiySDq/DRTX048kZ7hV4JtTLkqIexT81p1oAIPGAE92jWwcWY8LKuq86LJqdoNKH0rSj1EDB3XUEKTWXe5W+f6Ul5GEbzIu9yjo4UMOtLOye3Fhe2wH6QkDr8T4kEWR6xR0n0fivA2XDHeuRkjbNEG5a41QrI6e0nWqoRyA2KWhLOpifVEGpV36ATsky9DFxyiLivw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 by PH0PR12MB8029.namprd12.prod.outlook.com (2603:10b6:510:26c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 14:41:50 +0000
Received: from BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c]) by BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 14:41:50 +0000
Message-ID: <743497d9-b5b8-4de1-a1d4-9d2243b57aeb@nvidia.com>
Date: Fri, 5 Jun 2026 20:11:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] iommu/arm-smmu-v3: Issue CFGI/TLBI twice on
 Tegra264
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: robin.murphy@arm.com, joro@8bytes.org, nicolinc@nvidia.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20260601104845.995005-1-amhetre@nvidia.com>
 <20260601104845.995005-4-amhetre@nvidia.com>
 <ah87dzHOOTNGBBmt@willie-the-truck> <20260603010114.GO2487554@ziepe.ca>
 <aiAQ9ApqfTsdweRg@willie-the-truck>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <aiAQ9ApqfTsdweRg@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0143.namprd03.prod.outlook.com
 (2603:10b6:303:8c::28) To BN5PR12MB9511.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PR12MB9511:EE_|PH0PR12MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: ba20f9ab-1d67-4227-ad43-08dec3109409
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|4143699003|56012099006|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FSeWh7RCZYNvhK3LF6iArZw4lFxaDrJQ6iy8+jzmKgrBtMt+x6SmkLhdg6z82yHe4WB0FSuLruGNIB+V5W6GgwrggdNhjW8aODqxm8FNZ0DGV0sVpdFLs/rqwEwDyIW2GMslZ35zEcQ7InHoHLZEP4nSAGAd+T2+pFlP0HowuY4w6D4hHiVURfswpM2dRzGmmB31033YAVzZdOs2yqOgK5p5jjdmpofO+DG7TiaivaLgd0OF5IukHG14Ppqv5j68LCcpvVE29eQBXTfBPwNVDQYNjUDgMjdYSCzcU7ySAnmKkEuUXEImC3InWpd+hYLvJRVLgOvAY0jmdAQMVh0FY2viFTAPmuM8ynSyENfmEBRSeWQtWUziV1mhDOQQzcMYJS/5eeEJgn3BiTz44oOhnVuyZzgnMC/7pCRWmrV0HM9vMqVil3CIVizaByNwDHw7nUB8lycs7gDCt3PQXqQNWxkAT2HLrimxLsqGO8qogm93AJ/o8c0pA/MujDBBmc2HHfuz0olkMl6IGn78Q5lbzZudfEeLJon8vt7sFgBr8rJY/rkCzdluPR+vxqTM/+6VogzgTW9OskFzSmtelrWLS2IJBnfpmqY7JZAjUFlIBsDKSmJ00TzD0l7BYeI089LUn7wcWLm2jhD6FZ+BjBWb1LpLY3XeDV2FEF1NxKekWcMJv5jvFxR9Rg2DfVyWyHi2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN5PR12MB9511.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(4143699003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmZOY3p1a1RiSTRvcVBMMkI4K3dXRUVTS1B1VHY2ZVhsYXZGZk5YWitYaUg3?=
 =?utf-8?B?NE0rU0dQVTcrVVlZQSt5czBQOUFDcExmeGRFNzE4b1JmTDdNWm1MS3c5ejFa?=
 =?utf-8?B?R2p4dG5yR2lFdnJ5aE9nWTNzc0c2V2Y3T0Y3a1pwK256emx2Vi80UFJNZDVu?=
 =?utf-8?B?VkdNcmdlSllRMDFocW9lTERJajAyNExWTUErVkxGWVFWZWNMTlhVM3Z0Ym5p?=
 =?utf-8?B?U2hMWVI4aWJkbUpIWlFxYnFXcy83Zkc5TVJaTlpyZWFLQ2xsenhnTlZoeUkw?=
 =?utf-8?B?OXI1bzNHS0RMNzRvSkdQVmNYNzNmNmVLSHFCcWRrSWpPRGMyc1RpcWpBc1k5?=
 =?utf-8?B?MkFiQjZHZzBqeXZITzh4SDNJcG4wbGZidEdxM2J3ODI0aCtudERHKzlQbU5J?=
 =?utf-8?B?SXdvR21qVUJlY2h5M3lWTkx4VWVGQWEzZk9xZy9tZjB2YlZxcW5INVR0VFAv?=
 =?utf-8?B?WWRtZG00UVZxOFN5a1pFRkMxaERzcThMWURvNytXUlpFcWNSLzRIdmdaQmpF?=
 =?utf-8?B?VU4rRVE2djVSSDFJZi9OeXh2YVFuQkV1S05wcW1xeTRKR1NOOEIwNXR2YTN1?=
 =?utf-8?B?OHBIaS9ldmZiM2YrZElpUXpGdElUcEpNZEdaQUNUWHh6QzVGNmR4Q1RUeCtD?=
 =?utf-8?B?aHJMU1FMTDE0ZmNzY3FtQmRTTExBVTBpaXV5STV3ZERBclJsa1VKMlFXNm5i?=
 =?utf-8?B?TzJyM1BhTklqa2wxMEo5djFMM0I4bmhwUVk2dzFZK3hIRFYvZEpIVEk5RnNY?=
 =?utf-8?B?V2dUa0xwSE43dDl0UDNyWGlicGtsRWsyL3Zoc3V3TmV4SmYreXo1cUhsQW1G?=
 =?utf-8?B?eERsbENrckNlZTFxQUI3NnhWRmdkMVdxR1hSaXB2Z2NFdnpFVG9VYjN0YUZu?=
 =?utf-8?B?cG8zREd4dHUwUDRMUktsUzFWYSt6OWl0NVpZa1pkTGUvRExKWDY4STg5T0Jk?=
 =?utf-8?B?QnVKVEhlUEpuSHVzNjdLdUFMZkVFNDg4VzIyNW5ETmFodnZRaEFteUpQQXZF?=
 =?utf-8?B?U1VKd1dsaTNSamR0SXdXTE96SkxQTlp5N2RMRzVIK1EyRmZSUWZIL3RGVC9O?=
 =?utf-8?B?UUc5REl0T2xKZFU5b1dXV3UvZmkxS0NKMGJMWXRUdXJsa1c1YU1TcThWL3pt?=
 =?utf-8?B?RTZ0VHNUcG9yWXdZUUc1Rjl1WG52eWp1dEpJUitoVDU3VG84SWVIWHZMc3Fr?=
 =?utf-8?B?cEk4ZWhuVWhYcVNvdG9HUWtOaHQvK2JFQlloNkJPMkJuQ2tQM2FmV0E5cUZw?=
 =?utf-8?B?WnJRNmNZVFBFUVNraTlTT0lUNTBOMXo5NVZZeExMSFBSc3MwY3haVGxOeTY0?=
 =?utf-8?B?MXl5Z3ZZQzVPVUVtL1lCMlRoTmM2QkZLNXNJYWcxVkxGRlhZelByVWZsZld3?=
 =?utf-8?B?c0thQnRrZW5oamxSbjFYZHFNOEpycDJGWmFaUC8rSldDQmhDRWNDbmhkTGg0?=
 =?utf-8?B?VkNncjVjeUFSbmphb1YwQ1RpSnZ0WXpjd2VyM0pCTGNZM0VPV2hJdDk5Mzg0?=
 =?utf-8?B?WXRCVklHL3BtT2VETnZ1ZGJTWk9hdDdyRW9SRnplWHk2NlI1RnE5SjFzNjg5?=
 =?utf-8?B?ZHdBK29USWNGOTJoRjZjWGkvRmNRb0ZON2NlamsrVXNNbUdPdExyRlBZaFdD?=
 =?utf-8?B?WkN5ZGowbFkyblgxSEFSL1F3dXZ5RWtxTllFaDNiQXBGTlhBZDU1cTMxa0V3?=
 =?utf-8?B?NWNVYzZLNzh1dnYvYjZWVzNBQUJ3R0tQNVZISFVjdmp2U1FlRVdWcml4S01a?=
 =?utf-8?B?ODBxSGR4eWlONHo2RGc3RTJqaEk1WlRnMjgvV0c4L2tKWllweG1lWHc3SURX?=
 =?utf-8?B?YW0xRjB2WlNWN3dzejd1bFlHTWRXQU5IYWFNZTJBdHZBZjZBUTZMeFhRaUtJ?=
 =?utf-8?B?YUN4cVZJUTY0WVpqdFRyZFZWdjdjTVZqUDNGbVNwRCtEdXFYMENCbW85bmlC?=
 =?utf-8?B?Z0p5UkZYWER1NDQ5bnYrVVRmTmhlc1V6eXlwc0FIR29DcWhReEtyQmliQ0U1?=
 =?utf-8?B?dmFMTHllRmRLazVLMmJwR0RJWjZCbS9nMEZhc003bVhObUxoVloycm5laGQv?=
 =?utf-8?B?cVhKNmZXalNqcnNGa2NteFRTVDAxTzB5ekR0WlllTExEUm1RelJ4K1ptZXVR?=
 =?utf-8?B?ZlVDVk4vSkI3QWhUU1R3TzZGNWhGZlUzWmtncGRkMGNqTUVSQ2dQNFcyZmtQ?=
 =?utf-8?B?RDcvTDdXQU1rczc1MUd0TC9Ec0JwQWgzcm1ZTGJNMmFLcEZJZkV3VGx6WnVY?=
 =?utf-8?B?akpGTC9IejExSDZEZ0ZlZXlHWjljWXN6S0E0MmV6VHdzeDJ0akwzZnU2UmlP?=
 =?utf-8?B?NXgxTmpzbkRpdlc5U0NoQ2piVE43TTBzQVpzMzU0d2tJMW0yQmhPdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba20f9ab-1d67-4227-ad43-08dec3109409
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 14:41:50.4779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CV8ZR1OEWiRvZTt70+vuXEGFJXHx3bBdxJCOj+UngZ/HNJiCx44LuH2lDAP1DPvE/xjv7wgLQFwW/ng81AwGcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8029



On 6/3/2026 5:03 PM, Will Deacon wrote:
> External email: Use caution opening links or attachments
>
>
> On Tue, Jun 02, 2026 at 10:01:14PM -0300, Jason Gunthorpe wrote:
>> On Tue, Jun 02, 2026 at 09:22:15PM +0100, Will Deacon wrote:
>>>> + /*
>>>> +  * On Tegra264 (see ARM_SMMU_OPT_TLBI_TWICE) re-issue the same
>>>> +  * cmdlist with another CMD_SYNC to satisfy the erratum.
>>>> +  * Callers must ensure the batch carries a uniform opcode class
>>>> +  * so that checking the first command is enough; the iommufd
>>>> +  * VSMMU path enforces this with arm_vsmmu_can_batch_cmd().
>>>> +  */
>>>> + if (!ret && sync && arm_smmu_cmd_needs_tlbi_twice(smmu, &cmds[0]))
>>> Can you move the arm_smmu_cmd_... part to the start of the conjunction,
>>> please? If you make it a static key as I mentioned previously, then
>>> hopefully that should mean everything else is moved out of line.
>>>
>>>> +         ret = __arm_smmu_cmdq_issue_cmdlist(smmu, cmdq, cmds, n, sync);
>>> Sashiko is also unhappy here if n == 0 because we probably shouldn't
>>> be inspecting the command array in that case.
>> That seems like an AI mistake though, we shouldn't actually ever pass
>> in 0 sized batches? 'zero streams' should fail probe, not get into
>> this code, that might be missing but I wouldn't add checks here..
> I was wondering about the case where the first command in a batch is
> unsupported. Can we issue a bare sync in that case?

Seems a valid case. But considering the static branch approach, will
it be fine to add "n != 0" check before arm_smmu_cmd_needs_tlbi_twice() 
? Something like: int ret = __arm_smmu_cmdq_issue_cmdlist(smmu, cmdq, 
cmds, n, sync);
if(!n) return ret; if (arm_smmu_erratum_cmd_needs_repeating(smmu, 
&cmds[0]) && !ret && sync) ret = __arm_smmu_cmdq_issue_cmdlist(smmu, 
cmdq, cmds, n, sync);
> Will

Thanks,
Ashish Mhetre
