Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010022.outbound.protection.outlook.com [52.101.85.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42BF31A55E
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 03:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783049897; cv=fail; b=kaItYx7de+VFXNS66F9SuTTED1dwo35XPYQs0temKT6m2cfEgc7eC2cggJmgSkM7nBKJdAbKTfCiFk4nLAHuo9jKk2gAwIegIrg/dCE3wRR/MnRNRJpT3W5+r0JVWTKIL99EIwKSfWdmjq/7+R0kUOcRF0Kslt7cTGNG0dgHC+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783049897; c=relaxed/simple;
	bh=J9q212cs8F6axjps5LrZmDrvqZDfuVpL9aeAR5glO1g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kJwqa0AwpFs+HI5M3k4/mOJA8MUHgD/E7mgN+VGFHhw/WI2BncrEx9XPsqSOePYSYZUAkjyp4mNkghzA6eWRyePdZlHJ2UZpxmeVOVcRmj+BPjNRI8w3FLm+5po0RwiLIvzkVW40TDPHQjVq+curgd6sOUuIRXpddQbOsOWSF6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sc8VpUP/; arc=fail smtp.client-ip=52.101.85.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sc8VpUP/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VgrOF84dfrxnBzCY9S+oJfZytcxmI3oxg0nlAj5EeCNRFOnyJr3pWu22phM/lki2FKWyfNuNDTThV1zwjXfuC1EL+kjnkc6hPTdr4TKOBlwMoq+MJCJYTLtmNOw9IngaxNSzSxP6NSAIFUBS5efftdfPAVNxQf3FYyjUnrj9KnJ2XXYg1yQ3LfXRM9nyYNYX4jv5DW6GORHdEyWwtIVsZYeU49LCBs2WG6ATXI3y9RNfHin3EqCMAk+AQWnjH+PJdr3IqAR5OIwg8eylL6U9GX9myGAfuoVAxvxXXXfLq8OIaGtbijlHBzkjU8nDPCcIlymCsRcWx8QyiGzOUU3HxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emWRk5arihgZr+IEWkV1lOalBdclIHDrG1fnGxsDAqQ=;
 b=MHwTYt8ok+ZF7WerSKsj+6IwjMuwLLoI+W2Rep90nAiTG+SIeACNvsn3/jCANr/z1ZGmkv2z5zCgUtcxm4kLmz88jpUKxokR2TRPY2qGspFZVViuwVPd5aTlxyvWEiAeDwXWyymLYQTcb5Kocpeb+HkciQLilYQggHWv96JE1ubA6cAO3VcT+E6gMSBVSA7ymeAKYFwNYWg4kjYUoVmsrxon4kAcjgnksRkiCPxVei/1zYnYWTcQRDrchpnsmR84SjeP4QJNL7EYFirseOJH/N0uFX3rCttiYAd/64egkQxcpV20+0rlA+futYthRFqzRN1nES4gn7k8RPe7SZQLKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emWRk5arihgZr+IEWkV1lOalBdclIHDrG1fnGxsDAqQ=;
 b=sc8VpUP/kCr9wIFtOkwWvlYgLPERtSFYn3rgfFth2ZP7XIwC/TkVioo7FfSCMjA27tw64vMDfGlUmNuJQTcDR/kA+JC4x1zUjm2YTBw0A8vpiAw7YkT4+fHqSj3klOCbpUhcBeVzFhckkyXb8omEbxBxBqMrkVp3ytqwi6zlexU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by DS7PR12MB5815.namprd12.prod.outlook.com (2603:10b6:8:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 03:37:59 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%4]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 03:37:58 +0000
Message-ID: <2a875f28-e334-4349-84a0-51998baf1f40@amd.com>
Date: Fri, 3 Jul 2026 11:37:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/dma: free the entire IOVA reservation in
 dma_iova_destroy()
To: Leon Romanovsky <leonro@nvidia.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, will@kernel.org,
 m.szyprowski@samsung.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Ray.Huang@amd.com
References: <20260701092033.422867-1-honghuan@amd.com>
 <20260702102453.GE65299@unreal>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <20260702102453.GE65299@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0019.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::6)
 To CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|DS7PR12MB5815:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d24dfe9-34d5-4c53-3687-08ded8b479df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|3023799007|4143699003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	r/HQ2sV+0n5XeJF9+hqO+nOn7TUHXp5ga5PUUd6TL0LPouYkOSYV/7Os2R7dgUhRYwdFc2UcS5BASQouimBtVTRIbA0WI1AscTuVAPYyKIgkXtTlJEI3uk1pk/3ySG7qoUfxSInjgdQuDU9Q/i7jd8Yv1ecGh4RTXW6ei+mPXsg1ntaWRAbWrU1a1z+ol45HwxUF0xhV+c1STX2yVJP9imO4WjbVut5Oskmx9CKMure5uefI3mELIi5SXJdWb2fnX9/kDEUVt0bmduUTv1aqVz8epuyhRxP5TPQdKruKprkeuB7+dPpmW0hGNta898QniScK30yZ4MkL1jlGeH4P4kzNK4gCp9GSJXbuFj+57C/Xscoe+/s8IUiESHJXhRZMaqtezEhcVf12+wz6C4vbtFm/MGaMTDgZzeCW2p8JKVdW0KSaHQAt5Kd0E3leXi1YQfAECpw+KRDSHiObsbAZmwjvvb+KZiRWd5bRctul1l15SWki5FAgHVSNjLdmBjcOvU+1DLqrN7XJx10egBBtCJtQhBW1/yxab+UAhNeHeIYK14OVF8vkyfBSgNiUNrUic6Nts/8JJ+Ea8i0A8JzB4OvUmpCqQqqS1uFNbCc5ioxw98wSEA/hcnp0CgYoWL3q2y3X0Rhhg8ET5Dd5KlfR4ynlJHaDkgGSVqbzxkIUBxA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7170.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(3023799007)(4143699003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWRCdGVQc2MzV3pIdE9WUHZyVlpoZnVlZmx0L3ZuWmlSakY0VWNhelRhdDc2?=
 =?utf-8?B?RzFPT2hYWW1UWWY3c2ZoRFl1Ty9Uejg2YXl4NHAwUy8vQS94czBsRFJoR3RP?=
 =?utf-8?B?b3NEaitLN0lETk93WTVBcHR0a1Q2WVVVUWFYUXlOV1pGQXFaWFlwUkZEQ2dz?=
 =?utf-8?B?UlUrK0VFK0xmZzU4ckJyU25BR0tndTc0aklibFdHZWFzaVc5VXBuY3hNelpM?=
 =?utf-8?B?NkpRaGpnYmpnZzE1Skx3ZjRWcGpPSFJmSXhyTGlMZ3kyUDF1TFdBYVV3TThC?=
 =?utf-8?B?dURucVZLNldzOHpLS3NOS2xBVUQ1Vk5Gc2lGOHpvT05taWtDMmxodktyUnBw?=
 =?utf-8?B?UmpVUmFLUUdybDcrUHVDSW1GM1YvdDZvUy9MREEyUjJqdm9YNGJtNy9wZjdY?=
 =?utf-8?B?NjNCdVNwNlZsclNNWWpCQkdMam9jYW9TSWgzU2U4c21JSG1Ca09XdGp0Y0tJ?=
 =?utf-8?B?RlFIVkJJa2ZveU1HQm9Wa2tiL2xQSk9CbUFiZWdzaFdoOTA5T2x6RnJ4MTBm?=
 =?utf-8?B?REtReEdFZjRkKzAvejdCZnpIVTJPMkxISDVHR0Jyd0NFNFBPSlVBeWRQWXgv?=
 =?utf-8?B?MnVBYWVGaVFYMEV3Q1doYTVlQjZjK2pQOFk5QlFOTVNsd2NxSThZYm92MUNC?=
 =?utf-8?B?dE9OYk9iN0RYNWxqMElUN0dmdkJPNXBFTVZlUHpYcFloSWl6MVJ6MWZkQW43?=
 =?utf-8?B?Nzd5UU8rWE91NEhPKzdSbUk4UjBPcGh5Y3B0eUxPYmg2OGtkdENhczYraW52?=
 =?utf-8?B?K3draUJjelREeUU3Sm9RbzZuR3U3ZmJ3ODltQ3Y0Y3pJRHgwOXpaUy9ORTZQ?=
 =?utf-8?B?T0J2ZDAyWkRlZlByMnNOSi9LNlFFclUvWWgvTlRVVFdReTB5NWdwT2ZEdjc2?=
 =?utf-8?B?RFh3eXRJa04zdzVjcU43MmJFd0NLUEJqWjJGT0R4ZHRnK1FJYW5SRGY2R3VG?=
 =?utf-8?B?NkgwU0liK3VSTTNrRXBmMnkvRkwyeUQrNzQ1VHFYUjgzMmM1ejZZczcwa25k?=
 =?utf-8?B?Ym5lU0FuT2ZRZUdmQ1dDY05tQ0FzenV6eUdSbkZibXp6NE5IM3NSR1U4VGJF?=
 =?utf-8?B?TzBDRVZGM2czekxzQzQyb25JZWZzVjdEd0JUc0cxK2V3c1lkWDJTTjlzRjdV?=
 =?utf-8?B?bE9CK1FvckhGdHFodnNNNlphbnoxQWVPOGkwd0xWKzhTMWJzTndkeGhIOVRD?=
 =?utf-8?B?NDlrc2tDeHpneW5xeHNXeW5QM2lxMjdFTkVhSXJ1TEdTeUkxTWV6V1J3aWU0?=
 =?utf-8?B?R05BVnpCaDlzcFBRckN5bno3VnVVaUJLKzRyMFZDVkxZRnF4bnd1ZCtoZ0xE?=
 =?utf-8?B?NjF3UWtieHN3Wi9JTnU4Wng2dEptdWVHY0RSSWt4cVl6cU9iUTRIVXhIdjJ2?=
 =?utf-8?B?MFcvNzlmOEtmVGI1b2E1VWFsbTRWMXRlVm4xdmJIUy9mQXhMSzFvaUtWaTY4?=
 =?utf-8?B?bHVxdktPbzUxeDl1OTNZMXF6UURTRFdSTVllN3ZUekxWbXptUDJreUVTcnZX?=
 =?utf-8?B?UVFTQzQ0NVpXWVdkZ3BVdmYwVG5KRlZiSnV0RUlFbXE1QjhDZU1ZeGcyWVRZ?=
 =?utf-8?B?RUM4U3VsSnBCVy9HOTd6QTlZdWFpeWRDNVg2Q0cwMUZZQXlVZkhSdHI5cmtF?=
 =?utf-8?B?WlRKbDgrL0Uwam9WK3pneEVGMmIzMFRFb29PZVBjdzU0QkYxOUNHQzdDRHRo?=
 =?utf-8?B?bThVQ2paWGNRVlIrSlplRFpBVHE0ejRlWmowbkR0MlZwMWhnbW5RNzZkWVlC?=
 =?utf-8?B?ZkVwRjl4RXloM2xIRXZFOEVLVTZmSnRldTVBMFZETE5HNWJ0RzREVVdISzgr?=
 =?utf-8?B?WnYvKzExb1cyUEdIMUVHZzRHTjdxUExNWkRWVzBPTGlmZGhWRW0vaGN4SWpa?=
 =?utf-8?B?OW1IeWExNUM0eS9QQTZKOUJ1UWxCQkZidHFZTElydUQ5YzFCMGhLTnZJeko1?=
 =?utf-8?B?SkE4YmxIRjBiZHRKZlU1ajRIb0FHalJxK3NYaUxwdUM3bzhLZ3hMcnY4Nkds?=
 =?utf-8?B?a1VXOEtkMENHWG5JZlVBeFZscStMSzY2WFVvVVNPTHVwaEF3WG1sZHJ5TmVD?=
 =?utf-8?B?Tm9wb1BhUEx0R093eXJFWGtNd0hPNVpKOWQwRDNLcGMzQTNuZ05pK2dFMW1T?=
 =?utf-8?B?dmhvQ0p5NGdBaGlZdU9wVUJkUHpMS3BVdTJRd0ZITXQ1amVkbWxabGJudU5M?=
 =?utf-8?B?bENLRHBMRmd0MW9WSXNaMXQxRitHRjZRZk0zNUc5VHRaZ211RmROT1NYK0Nl?=
 =?utf-8?B?NlpaUkQ1NW5tbXhPcCtKVEZrN1RPYVBWS3Q4WkFUL0ErYUFRVk1zUkJmUTdN?=
 =?utf-8?Q?hOESIkfrtnrVutv7fM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d24dfe9-34d5-4c53-3687-08ded8b479df
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 03:37:58.8080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qNksJSm/fE1dXyOkxVnlzGcc1BKLwIIaPVODz0Z4RMccoLWE0qJl5GAuoa89KoFd4F4Mno0Frmrw0v6rhXnVmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5815



On 7/2/2026 6:24 PM, Leon Romanovsky wrote:
> On Wed, Jul 01, 2026 at 05:20:33PM +0800, Honglei Huang wrote:
>> dma_iova_try_alloc() reserves IOVA for the whole requested size and
>> records it in state->__size, but callers may subsequently link only a
>> part of that reservation, for example the drm_gpusvm mixed range case,
>> where a device page range is linked incrementally.
>>
>> The doc for dma_iova_destroy() is:
>>
>>    "Unlink the IOVA range up to @mapped_len and free the entire IOVA
>>     space."
>>
>> However __iommu_dma_iova_unlink() computed the amount of IOVA to free
>> from @mapped_len rather than from the full reservation. When the
>> reservation is larger than the linked length, the tail
>> [mapped_len, reserved size] is never returned to the allocator and
>> is leaked, contrary to the documented contract.
>>
>> Free the whole reservation using dma_iova_size(), mirroring
>> dma_iova_free(). The unmap step still operates on @mapped_len only, and
>> the same iotlb_gather is reused so a single IOTLB flush is performed.
>>
>> Fixes: 433a76207dcf ("dma-mapping: Implement link/unlink ranges API")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> ---
>>   drivers/iommu/dma-iommu.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 9abaec0703e..bb29c82d1c8 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -2096,8 +2096,11 @@ static void __iommu_dma_iova_unlink(struct device *dev,
>>   
>>   	if (!iotlb_gather.queued)
>>   		iommu_iotlb_sync(domain, &iotlb_gather);
>> -	if (free_iova)
>> +	if (free_iova) {
>> +		/* Free the whole reservation, not just the linked @size. */
>> +		size = iova_align(iovad, dma_iova_size(state) + iova_start_pad);
>>   		iommu_dma_free_iova(domain, addr, size, &iotlb_gather);
>> +	}
> 
> Probably the best change will be something like this:

Thanks for the review and for the shown rework, that's much cleaner
than my original approach.

Based on the your code, I have made some modifications to the 
compilation issues and will send V2.

And the v2 is essentially your diff, I wasn't sure which attribution 
you'd prefer:

   - Suggested-by, what I used in v2
	or
   - Co-developed-by: + your Signed-off-by.

Just let me know, will adjust in V3.

Regards,
Honglei


> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 9abaec0703ef..56173e24c8cc 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -2068,10 +2068,20 @@ static void iommu_dma_iova_unlink_range_slow(struct device *dev,
>   		arch_sync_dma_flush();
>   }
>   
> -static void __iommu_dma_iova_unlink(struct device *dev,
> -		struct dma_iova_state *state, size_t offset, size_t size,
> -		enum dma_data_direction dir, unsigned long attrs,
> -		bool free_iova)
> +/**
> + * dma_iova_unlink - Unlink a range of IOVA space
> + * @dev: DMA device
> + * @state: IOVA state
> + * @offset: offset into the IOVA state to unlink
> + * @size: size of the buffer
> + * @dir: DMA direction
> + * @attrs: attributes of mapping properties
> + *
> + * Unlink a range of IOVA space for the given IOVA state.
> + */
> +void dma_iova_unlink(struct device *dev, struct dma_iova_state *state,
> +		size_t offset, size_t size, enum dma_data_direction dir,
> +		unsigned long attrs)
>   {
>   	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> @@ -2096,26 +2106,6 @@ static void __iommu_dma_iova_unlink(struct device *dev,
>   
>   	if (!iotlb_gather.queued)
>   		iommu_iotlb_sync(domain, &iotlb_gather);
> -	if (free_iova)
> -		iommu_dma_free_iova(domain, addr, size, &iotlb_gather);
> -}
> -
> -/**
> - * dma_iova_unlink - Unlink a range of IOVA space
> - * @dev: DMA device
> - * @state: IOVA state
> - * @offset: offset into the IOVA state to unlink
> - * @size: size of the buffer
> - * @dir: DMA direction
> - * @attrs: attributes of mapping properties
> - *
> - * Unlink a range of IOVA space for the given IOVA state.
> - */
> -void dma_iova_unlink(struct device *dev, struct dma_iova_state *state,
> -		size_t offset, size_t size, enum dma_data_direction dir,
> -		unsigned long attrs)
> -{
> -	 __iommu_dma_iova_unlink(dev, state, offset, size, dir, attrs, false);
>   }
>   EXPORT_SYMBOL_GPL(dma_iova_unlink);
>   
> @@ -2136,14 +2126,13 @@ void dma_iova_destroy(struct device *dev, struct dma_iova_state *state,
>   		unsigned long attrs)
>   {
>   	if (mapped_len)
> -		__iommu_dma_iova_unlink(dev, state, 0, mapped_len, dir, attrs,
> -				true);
> -	else
> -		/*
> -		 * We can be here if first call to dma_iova_link() failed and
> -		 * there is nothing to unlink, so let's be more clear.
> -		 */
> -		dma_iova_free(dev, state);
> +		dma_iova_unlink(dev, state, 0, mapped_len, dir, attrs);
> +
> +	/*
> +	 * We can be here if first call to dma_iova_link() failed and
> +	 * there is nothing to unlink, so let's be more clear.
> +	 */
> +	dma_iova_free(dev, state);
>   }
>   EXPORT_SYMBOL_GPL(dma_iova_destroy);
>   
> 
>>   }
>>   
>>   /**
>>
>> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
>> -- 
>> 2.34.1
>>

