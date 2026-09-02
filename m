Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010039.outbound.protection.outlook.com [52.101.201.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B8946D547
	for <iommu@lists.linux.dev>; Wed,  2 Sep 2026 12:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788351404; cv=fail; b=AB4nwTzz4QmytB9N/5jETiLklmjYZXmyksbSNa/AMH6pABJCahAPaFRNW59fBPzepJapJiVJI6/kvsoGuV3oL9HoqTALMg3T+ULx2b9nQ50nEAFcT6DMpRuxIUl3MzecGnhwxaWfglsI17Ph0aQCE0AUNSJLyU42PqH0aDy/fyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788351404; c=relaxed/simple;
	bh=Lc3wLuMJxGViGwZK+wifiBM1c9JfmpmqjdPRJuOTBno=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uNznOGj/ow+7qSJMnqoLKTCLhYqrridJVmc8EqFXiopYUnOadBswx8gZ7Gqt9yBOBIWUgZhbsTEqD9rV69R4VXKKs3WmBTEJ+KFgYyYonGdWi+aKlVS8GNu9SFyLztg4nJztiW54XCCjQ3SVvC1CJz+zbxQNHKa/LAfuaodeFhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WYKrnFgE; arc=fail smtp.client-ip=52.101.201.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WYKrnFgE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oRwmp6sQf45UNj2+XEIQv7b7lMgkZq5UU41I7WddOepXJ2jxSbm5FM812pM22IOGrW+cjG0be8XX7WIgKLHaY/I1nTuAenrQyMTms8xI2pgOxPOwVwA13gVs+RbCmZ+7lOoZSGrMaqaT3F8JbtzB1oAWVoFcsLTFQPm71O+XNmByKylUTi4IL5B9MyXcvw7KvxCIMaWngPTD3pn3IHYQNHgld9ez0wnzb0hRYn57/gU0XJYD/M0o9hyjyW8pt3wJnmtsOUuTLpxvz34tHyZxwO/DEALOnh1B0b0+1YHlBOFRM/HBLoaK3PcNjkWJ5FJJGiq9iy4/NdC6YvSm2E0wSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZi5zpECCMrG+Wlh6c2xPIYqcl2RAtFhA2lImQHL1Uo=;
 b=Ye28uL6Q0dPHhRHv0OLM5KYayYc96oBjDC4s2Cfrl0VkRlZ0cwxSar7ATB02RzJvHByxAainUXxbe+LM0lUx3k9VZjUS1FmkQGH3VqwyusJ9JGSGYzBtQz0sxGBqvhJ6z8v56cAHZPC6pc87O/VNfAWxHTJ977Em9NvBMV1dqbGcMMgkRWFkd7++Adqj3v4/petej4EHcDjES5nomcRwaRWlLQezTNLuTjcssgmttpYjtNCw7LjbCA1tLqc3oYDuCWta2+7QtNKgDaMTfndAsWF5pTtXDOxXtr55mKwie/yWVRlbF25gGjvJ/93VVBHoXJlj36wwfAxX4jOqTfDPAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZi5zpECCMrG+Wlh6c2xPIYqcl2RAtFhA2lImQHL1Uo=;
 b=WYKrnFgE5pDwYx4PUX8A556775o4Lw49F2vqWTRL3WV+F1tIy0jxb2h0YhlbGJNpQYV2YHg2AkeqsUx1AzznZMtLhSH32hs1ol81cpAxmmSTxNWLxEvH42lBs6xSxLob4o47EQYL+3ZYj+jq5IgljAU89Tl2gsdIbnsKgANToCw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22)
 by IA1PR12MB7637.namprd12.prod.outlook.com (2603:10b6:208:427::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 12:16:38 +0000
Received: from DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19]) by DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19%4]) with mapi id 15.21.0382.007; Wed, 2 Sep 2026
 12:16:37 +0000
Message-ID: <b6305743-ca4b-45f3-a5f1-f0b291af6211@amd.com>
Date: Wed, 2 Sep 2026 19:16:28 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/24] iommu/amd: Map vIOMMU VF and VF Control MMIO BARs
To: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 Sairaj.K@amd.com, jay.chen@amd.com, wvw@google.com, wnliu@google.com,
 dantuluris@google.com, chriscli@google.com, kpsingh@google.com,
 alejandro.j.jimenez@oracle.com, joao.m.martins@oracle.com
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-7-suravee.suthikulpanit@amd.com>
 <59ce731f-8514-43fb-b9f1-96b4599478c2@linux.alibaba.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <59ce731f-8514-43fb-b9f1-96b4599478c2@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::8)
 To DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999171:EE_|IA1PR12MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: fbf254bc-2858-4323-b236-08df08ec0967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|6133799003|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	EttYFo9ACtUXMiJl5amqnqUxBfaKgOUTr8P9Q4ws4TcUfNTRS+GWUoaStC3whShOJnKp47psGQhbkacIeegf3ywCJ40WM5oviqpXzDUoqD+rY6GwXTnIkj8Co6/G9r+xulBCPEJxG0P5og6AV7nm7b/MHzDlweZa8kqSrpeOqDW+4wPdGctF86RdlgAgl6N8Iz9/dX2bWuPopWBv50UzRWN50frEYCGZaKuwIQHY/NeWE57Z5/lUjHM+IMpKCasG+wqTYjBpozTddl5iqr16l+iYDREz2LbT3vmaI9CvvbY9zoCqE/a3SJK4DFhlWM07ShzALPjJj4OjxPS0M3eLc86SxKtmK8plwQosHW3sAXXhDVBWBcYBcTM8xEu8RLkG7yHBeGd4glxZYmYAICDfaVuPiA5yfe3E0rcxMcOdsh+YjUGPd7CaGgy4xVBUNiTVWagLRPMNOV0Ueg2wtwNnKtH5Dxtfb6wVQythBydB70GvlIbhcSQ5IpcB5NRcCERianTocq5yvIiBaZrE6R0zwf1qBdLXEtQCHd2xtg/onMvINREWSHtk+SwhB0EG39smJkrAV0lkkBS0PEatuXL8Xa6xK7isJs0NGGk8/UrhZ9+XHp7iygWl5GOYLAC78Z8oMGPMay4k+LBjD+EQSqPwqGmPv9jPjXHCBpNSSAKFPfg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzVGc0xoOTZhL0tUMHVHMUl5cEFxNmJPOUgwdlFLcUEzcE5IekVHbENsaysr?=
 =?utf-8?B?QWtwWUN2a3dlaUpMQ1FRNTVxY3hlTkhEbjhVYTBJSnFKNFlNaDdyalo0U3dk?=
 =?utf-8?B?ZHZBYWgyVmhaRlh2UjVJSTRjR2VaMXpTc0ZxVWdPMll4UFBoaVd2OFdIWlR5?=
 =?utf-8?B?dUZOZ2RBc25KSVdqVnhjRWNBVkltZzNHK3doMDVmVXI5NkQ4MEpncEF1YXRa?=
 =?utf-8?B?dTlJajQyaERVZXRvMGhDT09TVkptSDYyRi8xajJmL0ZRNFhVeTQ5V2hWVFFJ?=
 =?utf-8?B?THNZUUxiaFRuSTYvN09jWXpIRXVjUDRaZzlRanV1TWw0eGNiNStsYXlnQW5W?=
 =?utf-8?B?V3JsalBDQU1Sa1FaOU55b2tZaWE3NUZOMmV4R2NaQW91VnpYNTA3ajNzeDhM?=
 =?utf-8?B?SHpncEViYzVYWGxTTXp5RW9QN0Z1MXAxeDFKbGIrQzdoQnJ3N1g2K0pqSmtl?=
 =?utf-8?B?bjFwRmllWGM2LytLbXJ0OExMWFhSVnJZM3p4N0tISDh3YnB4STk5YlEvd245?=
 =?utf-8?B?UmZBczdjVkcxWGNaQi9Eb1lkcEJnTWJwdC9KMWQyWFJhZVRadWZSajk1WmZN?=
 =?utf-8?B?TjdTM2FHM1FyWG9CaTBDQVVEUFExYWRuYlpwbHpyMEdFUG1odTJZVDdVazVi?=
 =?utf-8?B?NE9KSjBJUXFVWERHYSs2LzhYU05TYmx1MW1TU1Q3ZVR1bFpoVG5ocGd5NnBh?=
 =?utf-8?B?QVZiWUdZYmMzbGgwQ3gwUitncys5T0ROd1F6TEY2dDc0M09kM3p1V2FlTWxh?=
 =?utf-8?B?YVpEV1YxbmE2Yy9vd213SkJZNVJOUGJXWlVrQVJhZERmRHdUcEtWVjZVKzFU?=
 =?utf-8?B?UDBtakdScnBySzhyMlFTUlNUSDlmZHNPMU96Y09kWUJYZk11cWNrWjVHUXg0?=
 =?utf-8?B?dmVNdkJkbmtzbExENXErRTc2U0JKNk91RG1JSEFtbmVCK293dHhzNjZZZUw0?=
 =?utf-8?B?eldYTVh1VC9GUXNveW5mdC9qakhxK1pWeUtwTm9NejRacm9Vc05pZEdQV2pq?=
 =?utf-8?B?VVIySDZZNlJxTDNYZ3lZcGZSaHBZcWpDeTNVdjhMWnRkZGRjQVhvTGp0MmI1?=
 =?utf-8?B?eXp6Q3k3c1VOaGNPV241blpMR1Jta0lBYXVxQVA0OG9iL1JmRmUwbDZ1UjNq?=
 =?utf-8?B?SFY5dFVUU2F1NCtVMmFEL3ZTZU1oZGluOFJxSFNRUVN3YWRPczZNQ3F0d01U?=
 =?utf-8?B?OTZwUW9McVlNUEtpT3JwSUJVb1BsSU1IL2tNd21mc0NIWGUvV1dYS2V5cFhv?=
 =?utf-8?B?TDlrSGR5S0pWT21kYVRnL2s3cmNRNCsrcXowaktrOWZ5alRHNys5Y01OdWpS?=
 =?utf-8?B?Ykdlb1pLUmw5WnN3NU1NazArZkNTejRXNE5PQ1dIRHVDRklEZUtTOU5RZU5H?=
 =?utf-8?B?V0QyZ0hqeXlSNkh6TUVqZHVHYlNYT3ROcXo0ZDdEYjZjYzVQL295NFV0bzhN?=
 =?utf-8?B?UkZabDdYOHl2eVZtdCtwUjUwdDE3aWVhc3I2VUwrMmVMdWdvbkRoeStEQm56?=
 =?utf-8?B?NVI0ZlpDbHV4TnBJdVRWeUxsM1VKS2FqM1VkU0FGM2pWY2ZxUEwrakIwT254?=
 =?utf-8?B?R0dQWjhwSndUR3U1VjFUTk9hUjIvMDgvNVcveXJaNlNVZXY3VlI4MkNxZzFv?=
 =?utf-8?B?SDhLMnRWVlFwc05TSTJNa3FGUlZJbEM4eTkvdzhCNityQ20rYlVmZ0FVNkRK?=
 =?utf-8?B?OUpTSUdUdzlRRm9idVg0ZjdMcEtIcVhKSHg1dFhQTURyUGc0dGdiVDlENHlm?=
 =?utf-8?B?WUNidzNMSjhkY3pCMkpEZGlWSXVKTlppTnNkQ1MxRVVmUlVDUW5TV0dUb2x0?=
 =?utf-8?B?N09Sczg4b2FGS0k1RnhRUzJBK0dwK1VoV0tuKzlQRHhuaExYMDlVTVlGNnR5?=
 =?utf-8?B?aXZaOFBLTDBYOFhDUFVuMFVxS2VZeW5HbmdmM0FId09RbXpNMjUxbEdzbEUz?=
 =?utf-8?B?Tk5iSkdpOTg3aFNseE9oelduS1plSDBrTU1JQkJFVXl3L3F4ZlhhM3g5UDJ6?=
 =?utf-8?B?Rm1RRTJGZUVnUWRGUUVnVlQ2eUNxRXFmNEpmQ24yUUNWVklhcVVUSFpoWDNm?=
 =?utf-8?B?azRQOXI4MUxuWWI0WVI5aXlBVUFZWEpVczdPL2xsUTFEa1l3aGFKdjFWb21t?=
 =?utf-8?B?VEhEYzZjeGFQVnBNaG9vL283bkNDMHU1eGxlQ3c5NGo3dzVkMUpVbTJaMkZt?=
 =?utf-8?B?a015Qnk0T1p6SDRZYlVtaHBBQ2YzTk4zL2p4c2F2dDRJNE1EQ2dibE1yVlc5?=
 =?utf-8?B?ditrbnp1WTZ2VUhBZnN1Nitwb0ljMlltY3N3TGR1VlJ0a3l1QVJoQlAwdnBj?=
 =?utf-8?B?bEFWaUVLTlk2TzI2aGRGUWxSZ1A5aUt1RGNPaGFER2lCNklHTGVLQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf254bc-2858-4323-b236-08df08ec0967
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 12:16:37.4763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KpZ8Q2U3P5S/s21yt35J+diynUQ7tGIot0RfUJC+EL73X9IL5RMRL/2fr/k/tISTJm1WgmYXw9OCjXQmCrZqyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7637



On 8/19/2026 8:18 PM, guanghuifeng@linux.alibaba.com wrote:
> 
> 在 2026/7/27 21:28, Suravee Suthikulpanit 写道:
>>
>> .....
>>
>> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
>> index 5ac883429ced..6e69b3dd8b1e 100644
>> --- a/drivers/iommu/amd/init.c
>> +++ b/drivers/iommu/amd/init.c
>> @@ -459,7 +459,7 @@ static void iommu_disable(struct amd_iommu *iommu)
>>    * mapping and unmapping functions for the IOMMU MMIO space. Each 
>> AMD IOMMU in
>>    * the system has one.
>>    */
>> -static u8 __iomem * __init iommu_map_mmio_space(u64 address, u64 end)
>> +u8 __iomem * __init iommu_map_mmio_space(u64 address, u64 end)
>>   {
>>       if (!request_mem_region(address, end, "amd_iommu")) {
>>           pr_err("Can not reserve memory region %llx-%llx for mmio\n",
>> @@ -471,7 +471,7 @@ static u8 __iomem * __init 
>> iommu_map_mmio_space(u64 address, u64 end)
>>       return (u8 __iomem *)ioremap(address, end);
>>   }
> 
> iommu_map_mmio_space() calls request_mem_region() before ioremap(),
> but if ioremap() fails it returns NULL without releasing the region
> it just reserved. Please make iommu_map_mmio_space() release the
> region on ioremap() failure
> 
> 
This is unrelated to this series. I'll fix this separately.

Thanks,
Suravee

