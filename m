Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010027.outbound.protection.outlook.com [52.101.193.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893283B3C17
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 06:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790748643; cv=fail; b=UZyKyqJZdYQGaNermwfMAVK2Zcjb03UgMcCgvA4the0G+KDuQkK1KG43KP0/RxhxZ8TK3mnuN7vpfD0I98A8G9KLZyudYvTuMWD+nSq1wMMO4wC89LN3TI7ddYCGaew/rcq2KiAgM6lUzJRYUNvYW5f6VuDBN3f/p6wvwwPF/Ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790748643; c=relaxed/simple;
	bh=EuY3naiaaXnqYHoI84h1U3Ji5J4EZd03y8XeEvZmuQI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o7rESLvnHD7t6khTobtgpcgnYEJz+3r//xE/HEaiStHWer069dwJn9H+nSrPI/wqFoLbeFHtyYxdq+65cIgqEX9Spl/6ZVM38eZYRZ/L2lbyrh9pmxaulZTjyqDxlZFp4TqSaB1setODJpQDf2IXvFWQKmkKihRd1N4lm7Zac5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YquaEx8Q; arc=fail smtp.client-ip=52.101.193.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YquaEx8Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xT86D6QWt+rqcxvaBW9DsE0BEtdCGDNgjqXe9LRp+eiIiLZQZzPAhDDcDkCgMAFN6An0EIhKsn69AkY7T/+SeS6+eQjfvtp+jJSA1LVS2U8guhdhrvqQlpeUTXXfD/4nZipG+PKi9DgfeNqqj9OP8/yQipshzcckscu2TxDrPfKzFDVDR5kETOKd3b1A4rT94rX8pcgHm6a2zt4dm368CPoGyhfpjDsZK21Cc9KDHSgC4Qd4iuJYjU+QADlGs2Mif2aktDwrHCQ3E648CQb9wlSA0hFiyzqxt9+snlGpszDz3IZjgM/iX3THXIkRJqbGMOMCUebx3U/Bl/UgIBR6hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZW/RzFVfKrPTScErVT61BFqAnYm/PJnQ62iMgIKvgl0=;
 b=xuFLgmMXs3f0K2Rl04w/HLGl5OcF/R/zNEuoMpo5AvnpXVWoJRbsX2aKuUwAmDzqIdEfFrBxZG8duHQsz2jmTxXwLuDwwyYUlFdZaIf1hQtah6Sjd3Y9hORIWvgVFm/N+n9HeNcVZQoHhXtGy2JYV7twC3IG9sB/Sh+wqc9KsHh3LkzJkpOtru8qtyB+evoe2kcQJcWYW53KCZfmW6aazcg6mbR0dQxt3H0TPZyPyiTFhKV29lde2Hf1hZrAGOJ4cUsBAJxG6i/kjDlcLb0ex7eWZM2wq4+A5JZVQQq74fYWUPswjAzknRbd1njBw57xYgnp7X5sGNvL2rcpw053BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZW/RzFVfKrPTScErVT61BFqAnYm/PJnQ62iMgIKvgl0=;
 b=YquaEx8QxG+VLPRLSMuoWZ6Cuaghgw5zKI35ed6bczRofgG0ReRv98bErd9d+nHEc+R6Y1Tdr6aGrCcx252ZiUsmLrpY/lsPGiHHqsNg3EJbTYNn3tlBVvqxubJTzw0wDLLL8qiuoRyZN3yBoQdK0isgMJuioR3FZrptvI98hBE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22)
 by IA0PR12MB7628.namprd12.prod.outlook.com (2603:10b6:208:436::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 06:10:37 +0000
Received: from DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19]) by DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19%4]) with mapi id 15.21.0451.026; Wed, 30 Sep 2026
 06:10:37 +0000
Message-ID: <22befca6-e76a-47e6-9985-c5adc2e60bbe@amd.com>
Date: Wed, 30 Sep 2026 13:10:27 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/24] iommu/amd: Program IOMMU DTE with the private
 IPA domain
To: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 Sairaj.K@amd.com, jay.chen@amd.com, Ming.Shu@amd.com, SooJin.Tan@amd.com,
 wvw@google.com, wnliu@google.com, dantuluris@google.com,
 chriscli@google.com, kpsingh@google.com, alejandro.j.jimenez@oracle.com,
 joao.m.martins@oracle.com
References: <20260914184750.222939-1-suravee.suthikulpanit@amd.com>
 <20260914184750.222939-14-suravee.suthikulpanit@amd.com>
 <6198fec2-05c2-4627-978d-d9e7348364dd@linux.alibaba.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <6198fec2-05c2-4627-978d-d9e7348364dd@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KUZPR04CA0023.apcprd04.prod.outlook.com
 (2603:1096:d10:25::13) To DSVPR12MB999171.namprd12.prod.outlook.com
 (2603:10b6:8:388::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999171:EE_|IA0PR12MB7628:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d93006d-6c8c-4e01-a81e-08df1eb98b97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|56012099006|11063799006|4143699003|18002099003|10067099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2Mt/HfDGpnf0QCtDC2MrPsnE15/QpseN93TEVbA0gEAWuo72o46B9gdGHiCzbtZhhmEzDS0CGCnkjCws/DOf6tZT1E/WaqjgVChJtRMOSdrxzEJcgW0S1NQWodiYGd4fXgPlzVfVPwWmAgKI2tv4z0DJF99r/ad++ozk6aIoqm898qFIPMkog3xRUPgfJoPO/80SjiAMMdJywJGjTtBqPooJ/s0tmR6klaAJkE2sZHDbSU+HbiwguADwDNHWhRf03VXTd7bx1oo9dxxg6SxNqraszOo+rLwICWcMiCbLhkh8bxk53EgeRvI1PdFgZXLz+BbpfMdEhotMNJvk+KXufHTFX2aFQYpi7Qvii/vaNcRsY1jStZXAMjhP4SuL264a5Wdo6tT3C0aa5cq/fwkhA8RuHfEVZZlJaGjAg8iT7Va+fasAM1LEWPUAw162rAOVsX+z15zeIokXzA7+ZUrRw9ditvFpU3bx4MQbNOkghDyKGCcv/Yc1UYuBEBo2uofTkMgD3FFfCdUSoVI8bjQKYssEqQgfwnKk9klQSER+TcJH7qzG0z+ks0KUu07AG4ykBcFacDupqNVnZ7E8qNFtUGsRHVpf7QtaJzXY6SwqSw9GshXcV75Q08dI4eaMekMSox+/JzJD+a1rJb1bYdLP3C4rHkG0U9mVgzaapqi8y3Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(56012099006)(11063799006)(4143699003)(18002099003)(10067099003)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEdFM3dVbFhJUmE2MzFEME5ndVY0UDY5STJzTWxnVWI2dyt5TitFRXpHVmYw?=
 =?utf-8?B?eHYxWndiYk9tT1liYnN3dFlPRGhwZ2x4Z3dUOHJvK2ZITmloR3FHaE0vWW04?=
 =?utf-8?B?dG15dWhJaGc0S3Jqa2Vyb2ZIMnFaQUJxYVl4WlAzY1EyQ1ZlUE1OZ3VwaDBJ?=
 =?utf-8?B?VDU4RVplZ2owTVRKNHJ1amxnSGFoVGZSYm5zRWFJS0l2bXNldkU1ZE1vRmxq?=
 =?utf-8?B?R3c4ejlJbUs4UnhwVkdGN0VUNk9Zb0xYMDM1RU44WGxpeHVscW1pTHkwYnBB?=
 =?utf-8?B?R0JQN0xDVzZXNHhkbjA2ekZDRWwvZGR6QVJmUnRzSy9wNllmU0F4eVFHMVFI?=
 =?utf-8?B?dnJURmJoRXN4YXRMQXRvc2xXdHIvZUhtL2h6SURIY1lmUHRzc3NFTGRqblVH?=
 =?utf-8?B?NWVaNDZ4K0FVdEY5UlA5VDJOWk4zNC95Nm1valRudU5YTUNLRklKY0ZXZEw4?=
 =?utf-8?B?NzVTOEsxM0kxUHpvc251WERCbWpOTnlFcVl5U2lxbEZVaDRVeFV0U21RZlhI?=
 =?utf-8?B?aE1STjEvMTZaRlFjODQrVHdGS2I2Y0JHYXJCL3FwTDZaN1k3S0E2Wlc2STRZ?=
 =?utf-8?B?OEx0YThwR3paOUFlL2lqK2x0aEEyMDRINjNRa0hJMHQ2VE9OSHNGYlNZYkM0?=
 =?utf-8?B?bkRtUGI3aXFRa0kyVGUwS0VBMExOalBKRWNtdVc4NVZGRU9lZkZpRG1xK0ZU?=
 =?utf-8?B?MzdGMXh2TlpldGc0OVhZZCs5NTJpV2U5dVp1WUlZY1FPSnhTRC9nRjhYc3Yz?=
 =?utf-8?B?cU4vRGZXa2daTUpUWmRkRkNKZEtQaXBVZDZnQ0tid2wyMWpiblp1NlI3SWdW?=
 =?utf-8?B?Vkk3VUNUM0loeFFWMGZSNndKcHZqZHllUDZBZlNDK21OSytRUWlrU0x6b29o?=
 =?utf-8?B?TFdCVXVwQWtEU0RTZS81WnlWUjNkZkZiU1JRVHB4WVZuN0hlVjY3ZnZ3SEVr?=
 =?utf-8?B?YTFyTFpBcU43dlh2ajJEOE51TTI0OVF0QURnMCs3SHJ4OUl6Q3dLbjZ5MzJZ?=
 =?utf-8?B?UDRxd3pRMW13Y3NqUlVJSUg4dnhxd3dhR1ZHTGRsSXVSOU1jUDFpdVpSTHQy?=
 =?utf-8?B?RkduZVYxZEJOS3pKNFUrdzFWL0VaQkRTeXJoRWFTbW5GTHFmOUEvU0F0c1Rj?=
 =?utf-8?B?M01kRjRQV2tLVTJPTGQ5allFNHdyOUNWRTExOHZxbkMxeVJEZGx6V1FSd2FQ?=
 =?utf-8?B?WDNMM2RaQ3FzTkw5KzVTMkNFWVpLemxkV2VyNHFrOC8zejdNdk5wNy9kcXpP?=
 =?utf-8?B?NUcxSktRc3pWVXRHTlg2akxzQ05rSmFjU2dnUmRNd0lCWG5hQ0NtUmFZN3hv?=
 =?utf-8?B?K1NvcDBJRDFzZ25Rd1VhNHMxOHFxZjhJYStxMHJ0aGd6Z2k0Mis1RVNVeXZq?=
 =?utf-8?B?TmFFck8ycXBwaFFNMkNnNEFjTEFqdHJUN2VXaDhYVjlIbW1ZNFAvSzVGajg1?=
 =?utf-8?B?VlVWL3l3aThMTVQvQkVzS200azVUNlh3QThUYWM5U3hPSkpaeFJ5NVJSd2sx?=
 =?utf-8?B?LzJKWXo4Tk1ZSHpUUjNacGR6K0lRQnFWYS9SdjdRUjNjTU1YUG92MURUVzVH?=
 =?utf-8?B?aFBwWmZyQUdZdVNqeHFONHUxczVnS3BMSGNRdWx3VWJIQktnMktLeXFTeDVm?=
 =?utf-8?B?eE0zblViZjlidnRRdmJRT1NOZVJOSFVjbW1za1MxRjZnOUQ4OXloay9FN0dS?=
 =?utf-8?B?ZkZ1dU1QMzJUckFNVFQ2dTV2U04xdGtDSlBzNzRHSm5FOHVXdnVJbmNvMVFw?=
 =?utf-8?B?LzlKYzdtTTdYVWEzM1FqdDkzcS91dTVSU2ZxQm9RME5FSjBWVnhpVEQzaXNq?=
 =?utf-8?B?WW1TT0t4SHpDa2hOTHJsTDZKTWpVMWRWSTRVR2FZYk5GUmpvNEVWeDZ0MDV1?=
 =?utf-8?B?ZVdHeGpSTE5HdldUT3FUZ3RoTCtOcVVCTjIwN1dVUHJQMm5SWi9lcllodDBR?=
 =?utf-8?B?ZStlK1puKzlSR1hTVmhYVlJPVHhSMjZodHhHM2hVNHduUldaRWphc0NTR3Rj?=
 =?utf-8?B?LytZeUxPZkJkVHhwVy9RaUgzSEhmWVlIeTJaL3ZEaEg0Q01ORE9aYkppSDZq?=
 =?utf-8?B?T1U3cXNDRFNERGp1VTZoUXV0NnJEa2dzblRvZW1CejBRSGppTWIrYldlUDJK?=
 =?utf-8?B?emcrT2ROdzlxR2VMbEZWQUxuUUwwMVdpVktvdkJ3Sk9icGJNZUYyMXlRVmdj?=
 =?utf-8?B?Vm9PbjRWN2ZSWm1HRTJtbU04MmV1Q3JNYU1hSVY5RDd4ZDVXdzZZWGluY0ds?=
 =?utf-8?B?RkhOdmM0ZEtyckkzaGlQTkVjVFVtVXFYNlNMc3lvZ3hXa3h2THA5MWxHYm5q?=
 =?utf-8?B?RHpYeTNoQytmNlpCSlBkMk5UUWxqU3ZKSWU5WTdVYk9RbENKb01ZQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d93006d-6c8c-4e01-a81e-08df1eb98b97
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 06:10:37.2890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LjSNZUlfdKZXW8yt0ghKIoSUMXeMoRKDWVpFJcMIx5OQW+D0uCw8ZG4Uwo1yGghtEDjVuAF17U1gOa+75LF75w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7628



On 9/19/2026 10:26 PM, guanghuifeng@linux.alibaba.com wrote:
>> @@ -2770,6 +2810,51 @@ static spinlock_t 
>> *amd_iommu_get_top_lock(struct pt_iommu *iommupt)
>>       return &pdom->lock;
>>   }
>> +#if IS_ENABLED(CONFIG_AMD_IOMMU_IOMMUFD)
>> +/*
>> + * The vIOMMU private IPA domain programs a synthetic DTE for the
>> + * IOMMU's own requester ID so hardware can DMA to backing store.
>> + * That object is not on pdom->dev_list: it is not an IOMMU-API
>> + * attach, and walkers such as rlookup and clone_aliases assume a
>> + * real struct device.
>> + *
>> + * amd_iommu_change_top() therefore misses it. Early maps fit under
>> + * the initial page-table top (PT_FEAT_DYNAMIC_TOP). Later DevID and
>> + * DomID maps at high IPA call increase_top(); the old root stays
>> + * live as a child of the new one, but the self DTE still holds the
>> + * old MODE and would not translate those IOVAs.
>> + *
>> + * Walk iommu_array (from amd_iommu_pdom_bind_iommu()) and rewrite
>> + * iommu->viommu_dev_data when this domain is that IOMMU's private
>> + * IPA table. set_dte_entry() skips clone_aliases() because the
>> + * synthetic DTE has no struct device.
>> + */
>> +static void update_viommu_self_dte(struct protection_domain *pdom,
>> +                   phys_addr_t top_paddr,
>> +                   unsigned int top_level)
>> +{
>> +    struct pdom_iommu_info *pdom_iommu_info;
>> +    unsigned long i;
>> +
>> +    lockdep_assert_held(&pdom->lock);
>> +
>> +    xa_for_each(&pdom->iommu_array, i, pdom_iommu_info) {
>> +        struct amd_iommu *iommu = pdom_iommu_info->iommu;
>> +
>> +        if (iommu->viommu_pdom != pdom || !iommu->viommu_dev_data)
>> +            continue;
>> +        set_dte_entry(iommu, iommu->viommu_dev_data, top_paddr,
>> +                  top_level);
>> +    }
>> +}
> 
> Self DTE Mode maybe does not comply with spec requirement of Mode=100b
> 
> At initialization time, only the 8MB General Backing Storage region (IPA 
> 0x0 - 0x800000) is mapped, so the page table top is likely level 1 or 2, 
> resulting in Mode = 010b or 011b.
> 
> However, spec Section 2.10.1 states explicitly:
> "The DTE for the IOMMU's DeviceID must be set with V=1, TV=1, GV=0, 
> Mode=100b."
> 
> This is a hard requirement ("must"), not a recommendation. Mode=100b 
> means 4-level page table (48-bit address space), which is necessary 
> because the private IPA address map extends up to 48'h0050_0000_0000 
> (~5TB), well beyond the 39-bit limit of a 3-level table.

For GstBufferTRPMode=0, the largest IOMMU Private Address = 
48'h0050_0000_0000 (39-bit address)

For GstBufferTRPMode=1, the largest IPA = 48'h0028_0000_0000 (38-bit 
address)

In both cases, DTE[Mode]=011b (39-bit GPA space) should be sufficient. 
I have discussed this with AMD IOMMU hardware designer, and has been 
confirmed that 011b should be sufficient. I have also experimented with 
DTE[Mode]=011b with the highest possible GID (i.e. 0x7FFF) and do not 
see issues.

Please note also that:
* Linux default to 3-level page table initially, and grow the table 
level automatically as higher IOVA are mapped.
* Linux supports GstBufferTRPMode=1 only.

The AMD IOMMU spec should restrict to DTE[Mode]=100b. The spec will be 
updated in the next revision. I am also adding comment to describe in 
patch series v6.

Thanks,
Suravee
