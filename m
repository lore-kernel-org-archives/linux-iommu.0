Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011049.outbound.protection.outlook.com [40.107.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CFB3E63A8
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 10:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783937623; cv=fail; b=GDCW8yRlzBNp2xcPnWgywmVJUkryOgnYNid7/g1iyPWJiw4j4vnmi9CoxqHClHLzCeq6FLrzJ+VVdEPLecP7e1s2uCB+ZH+GQHXtjCJkki919lX5wpLtX+gJlgNNVI7C0NhiHz9nSdFgtuKYGNOFLhz8O8jOJ2dF5FAKF56bz2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783937623; c=relaxed/simple;
	bh=wZZY58ZHyZQN03UcXOTWVChlTCv33G8lk3x9RoI5q4c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=afZ0UcXESScxc3qygh3p4S/p6ya49fU+0C5sf3mWe/aHDd5qgscLfgldlxV8En51lmQyPiTLKXX8kiUxV8PfZBcq2nLxEpFYn+BrAeti8VKq2oPcd+DGaIMDKD1pOyBNZcr8Ldk3Blg14WOI6Bwjz1hGmZ0ON41lCvhwpCnvkFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xpU+yrOe; arc=fail smtp.client-ip=40.107.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xpU+yrOe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JXPUb2l6lvHru5roYOcJsACGJS83XUIqp8ZNUQLVwxMl3nI4U2GZYYhyilbo5svp6A8lEFAQnNeS+fsg1ESJBZe/ucSxQPwPH6++Q/TlEq7/AIJBg2T8S8djISOSrFYn1PlDIr7px0eHuaRIM25CF+Lp7mHtKueQq3KDDiKo+cvmDhpCxPBRSA/A1Us5BjbbSGI86Pq+EMzKAl6NWuhx3vWnZ8hg/AdUa/0MFGotzaDljsjUh5p+PPOLduZ1uo2OP3ZuRh1DtFD1OWqRjCz9tZcxMXqlZqCiAVboU2rjwIoCW9e/gsZ8sKnvErqs0X2cyYHMdAfdUs+JEPSvKSJ9og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjOZcMfa56RChXSIZED5fTNY+2namciR6WMYxucM3UY=;
 b=qU/gKRLT2OH19oL6eTZaESNLigNTQ+6hvkWtLvYAxC/WD5FD6cfwp0T+ILZGRRkoYVSJet/PSCGYKhiy33ZszxS0b87hlt+QWKIEAMYJKdZZESY8fPNxA+AFbz6K7oNpDI3sUecrHiPIKreNENPKOH5Gc0yIKeWr2Ae6513jwCTGrUUfODwWbl82ltqtVfdHQaYWehRnbmPIkUM7rmsZ3B4yioguaZA/HxrHLAc/8EJJRINUKn+Vb3PiDpjx8rUeUtzSJH9PUWj2oRobQGRffDJdRitMNWI7+2EL1+AI5YTR9Kfdc/n36VupBk295b1gQZ54kOaACFwrsU94+PV2dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjOZcMfa56RChXSIZED5fTNY+2namciR6WMYxucM3UY=;
 b=xpU+yrOeNxAR9I+1erV0Pgmk3bNumU3mewZqDbRyPdKN+qAo+ckyErP6eqyL+outRKlvz747wZGx5Xi13W9HaGvM44rYWqEmIwQ0TcGOAHJrLvzON9Ilf6O7x1a6RBYQjdN2sBvIi4Pb27apK5mXYm0tWCtYLUP8G7Ug/POs/jk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 10:13:33 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%4]) with mapi id 15.21.0202.018; Mon, 13 Jul 2026
 10:13:33 +0000
Message-ID: <5538f1c3-a665-42c9-ae96-89e2867ab470@amd.com>
Date: Mon, 13 Jul 2026 18:13:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/dma: simplify dma_iova_destroy() and drop the
 free_iova helper
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, Ray.Huang@amd.com,
 robin.murphy@arm.com, joro@8bytes.org, will@kernel.org, leonro@nvidia.com
References: <CGME20260703033750eucas1p21cd9472b9cd02f6611e8eeacf6e1610c@eucas1p2.samsung.com>
 <20260703033729.455358-1-honghuan@amd.com>
 <8c254797-a349-47a0-be4a-86a8ad09cf56@samsung.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <8c254797-a349-47a0-be4a-86a8ad09cf56@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0060.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::15) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|BL4PR12MB9505:EE_
X-MS-Office365-Filtering-Correlation-Id: 67e0472d-f12e-42dc-ec55-08dee0c764de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|4143699003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	gTsBflkpkbf31BgQmxEBGumMycJPWAPnYB0cfze7WM7X/4pE6sprrVXWf1MXVIcT3yMJjI9k3iInoWv3xc8QnszEPh1d26DOBUH0atxuwJrtEkzCYvjfhIi/iown4OPdxNkTKBTgvRg0uCrP/DA/8U+th9Xw6WMn8ItKnwfdtoYGjbaQSelgy0zl9jtVSwPLCUxdPUYm3hN4Oa4YE0N21/vY616qeslLmYbbCzrNw1f3KMDLQojZw2ogg7+OkaECCDkSF4mjlqzqfiAiXevv8kq2zjHzujO414ASRlFNuiI/5HJC9mHV8CDFs4UnHOsW+EUTjqWEUEN9CmIjhUGXcy+VdmMeddq6zxWuh+EwoMr4vMUbRI2AxhEQVsYkfeLACWbNLVFUP82Cd3NnYJfm2cwaOeSlNJHBi3Vs9z5apHyKp4oBLyTX39biwdE3XyGdxnHQan491J56VW2Jl2NgSqKW06SDMjm0XL5XHEU7YzWnwXYXkwW45dmmuenViLNsxF6PLMr4vhi+Ku++ffZAm7uiaZtSeE6ETm8qkyb9f8ur593Xzgh7KK7MmCAAMq46KHksbEMcS30Bcmedsa4mnyZWRZwWVpZ0VgjQTMTAkH4S2cS/oss5Pela/DXYubwK9B3kRl2dzlzZPnABzcSD8SoytjA7goqU9/HaxWVHQ5s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7170.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2RRelRKUFQrVjM3Ukt1aHRaMDFLS0twaFRNWlhZaGlKTmdic1ZwMHZuWHFG?=
 =?utf-8?B?TW5zVk9ENWlBbEVFVEhydHlKb3Z3alJBdW5reE9Kd2JsRVpYRXkwT0Q3UzA3?=
 =?utf-8?B?L3NyekdCZWNXTEVYRm5HY3VYUWFZbXZxQjdDM1BqVFVrTWxGZlZsTjIvb3Ux?=
 =?utf-8?B?eGY1TklEb0JGVFpQa2Nra00raVdySWJLcmpRUmUwdnBIcGkxK0ZTak85UnRW?=
 =?utf-8?B?V2EyZVlkMFRZVkd0dzVTa0RBTTh6TElFdEFHMGx3ZTVmSGV4RGRweG8yNTRa?=
 =?utf-8?B?akRsRjR3TlVPY2UrdXVOMmZEckdsQ3hQQmlUWjRhNjBvbVBzTEFXN0d4RkhX?=
 =?utf-8?B?c3BQa3N4QXNMK29qUVRoUkdDWWhRSytQNFdHcTFUNVdHTUZiSGtWSzI5RXo3?=
 =?utf-8?B?cG9sTS9FbW1DMzhqTGUrNkgwRW9QM3lsK01xQUVaWjBOVVNGY0dDc1NtNVpq?=
 =?utf-8?B?S05MNE1sUUkrWnl5OFdXVTUycys3b2F3NlB5aHpCT3dyTGNxVHJHZ2ZUNnE0?=
 =?utf-8?B?WVB0UE10d282ei9vRUQxTDQ2UXZEdGdmSGQ0UjJRZmpnZ0lJN3U4STVJQWJC?=
 =?utf-8?B?Vno5enZ6dW1LYndXOUx3cHNQS2hiN1ltUjZ0c1FHcnVmeW44NWc2VnNoYlJt?=
 =?utf-8?B?Ky9kMk9mOVhRbmNNNEFLWmVXUzQxMFVnMC9RWi9YcUpNTHMzQk1rZlhBa3lu?=
 =?utf-8?B?UGZDUW9RaW02akpjMHlKbTM5NmRWMWtGUkw4RDA2WmFsODZCR01pQzRWNEd3?=
 =?utf-8?B?R3ptaEpmdmxnRzdQRlJYSCtLRFpWOUthdnBBNUtSNkdyVjJmR294cEQ5ekIw?=
 =?utf-8?B?cmloNzEza1lTNHowbE0zTHFHa0VlbllzVkxYWEV4NEZsR1ZobGdSMFJhcndW?=
 =?utf-8?B?WVRCVTU0VzVaaWFxcGx2VFVIOTZhaStTTFFwQ2tHWEoybzRSM3VoeWFwaXc4?=
 =?utf-8?B?WTUzenFUaDBqR2h6VFh1RGtuTmhIQVNjSzdGdWNoZ0E0bWt4NjRTQkV6RDY0?=
 =?utf-8?B?V2JkRy8yamljd1VrUDJVd3JzSVdYa1N1SEF5NDl0c3NPd3k0dW9UVGxCMThJ?=
 =?utf-8?B?dTVIOTRxWG8wVVZwVHNBSEhnYkdMS1N2a0VsNTVLbHEreUxXTHgrSFNhR0Q5?=
 =?utf-8?B?SGZ3OThuOFZoRHZqcmF4TC9BMUt4OGx6MXpEOUNaRFRKVmlJeWVwcEVYUytR?=
 =?utf-8?B?RTl4RXNISmFPb3F2d3RybFhVOFJCdFlObkpIRXBPcE5sVGZ4K20xcGhxdFVY?=
 =?utf-8?B?UERKRm80d0U0cGlYZmxVUnRvUlB2TWpud2ZhQnJwYk1kNEU0YzJMYUF0dzhI?=
 =?utf-8?B?bW1DdXRRTlMxL0F6S1RicmJ6eDljUWZ1QkUvSFUzYVkzMnhacHNKSDlNcGRG?=
 =?utf-8?B?ZCszd25TWDJhTXV6YTZDeXV5TW1zNEp5ZHZCMFd3ZGNNWVVTN0k4REU2ZEM2?=
 =?utf-8?B?KzVPR3d1SFFtL1lmRmV2ZkduTngwQ2o1c1FRN0ZpbDhLb0l5dUNOWlFFRXhK?=
 =?utf-8?B?QTI3VXlxNTY3dXRCcndhVVVFYUZmejYzK3I1aStrbHkvR3ZZbWNTTzVCR3FN?=
 =?utf-8?B?aDd3bzdCeGZZeXBqaElCdGJMOVJ4MWlFNUp4ME9rWHYzQnVTMU44dWk4SW5E?=
 =?utf-8?B?MGNETExsRmRwM1I5VjhicmJRWVRKQS9JZEh3UkhqK0FsUEk1amJna21MekhJ?=
 =?utf-8?B?TG5FYmxzZ2RFVkEwNWhqWDJaS281VnBCbjM2MXp3SmdTUHdUUUd4ZmdDeno3?=
 =?utf-8?B?ZHZBUS9mNEEweE5DL0dpc3Jkd3NGeXorOHg0MHZ6SnpXTGxTeVh5OGlEbGRv?=
 =?utf-8?B?c05DSWFCWG13eDlzSUdyMExrQTRuSUY2YVNDYmw4RHJ0UzYya0xjUkR5MmJ4?=
 =?utf-8?B?Z0tpeFNOcS9lbnVOU0F4NGppcmpFVlZLQTlpWk44Y3BHZjVVRURVZXlNM3FO?=
 =?utf-8?B?ZnRNMmFJT3NMWXVIWXhWQmhsU2FueW9HeVpnc3N5VUF4UVZrd01EcWphNzQ4?=
 =?utf-8?B?ZXZzVTNyazRYU2NXNW1keHY1eFVNUHBFZ2Vyd2ZxWEpaUVdkWlhYcmxzbXp4?=
 =?utf-8?B?Zis3ZmZvdHpON2JIZlVXLzZiaHRpbDVPVkRXb3ZqbHg1SnF2VjUyTkJqQkY1?=
 =?utf-8?B?cTJsRUNzK1Jlc0pWeGdBWUY4NW14cHlJVWpMVnlvbmkxc3c3MHBaZlZVL1N4?=
 =?utf-8?B?dCtiNGR6K3lNRVFQTUU4NERxYVdKYnhmK3dOWitqdFFFU0VFK0tuMWxLa2Rh?=
 =?utf-8?B?SGc0eXIzZlhqNnBVd0REKzZ6UVYybjY2VW1xSC9rNkRFN0lVSENtN1J3REM5?=
 =?utf-8?Q?q15yDCvNiZLq8SvBfI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e0472d-f12e-42dc-ec55-08dee0c764de
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 10:13:33.1120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJ4/s1UCSwHMpwJbxfdhSTgqyEYgfn2ny7/qC9OPZkltJc1NkDMeXk1qWFBgBaM8yl/LL0yGHuN2HQuXTrUKBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9505



On 7/13/2026 3:33 PM, Marek Szyprowski wrote:
> On 03.07.2026 05:37, Honglei Huang wrote:
>> dma_iova_destroy() frees the IOVA space through __iommu_dma_iova_unlink()
>> using a "free_iova" boolean, which duplicates the IOVA free logic in
>> dma_iova_free(). And it frees using the unmapped @mapped_len, which for a
>> partially linked reservation is smaller than the reserved size. This
>> results in a benign waste as pointed out by Robin, not a leak. So this is
>> a cleanup, not a fix.
>>
>> Drop the duplicated free path. Fold __iommu_dma_iova_unlink into
>> dma_iova_unlink and remove the free_iova parameter so it only unmaps.
>> dma_iova_destroy then unlinks the mapped range if mapped_len is set and
>> unconditionally calls dma_iova_free, which frees the whole reservation
>> via dma_iova_size. The freed size now always matches the reserved size,
>> and destroy reads as unlink then free.
>>
>> Note that dma_iova_destroy() no longer routes the free through the flush
>> queue; teardown now unmaps synchronously and frees directly, matching
>> dma_iova_free().
>>
>> No functional change intended for callers.
>>
>> Suggested-by: Leon Romanovsky <leonro@nvidia.com>
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
> 
> 
> Applied to dma-mapping-for-next. Thanks!

Thanks for the merging!

Regards,
Honglei

> 
> 
>> ---
>> Changes since v1:
>>   - Reframed from an IOVA-leak fix into a cleanup; dropped Fixes:/Cc: stable.
>>   - Fold the free_iova helper into dma_iova_unlink() according to Leon's
>>     diff, so destroy is unlink + dma_iova_free(). Added Suggested-by: Leon.
>>
>>   drivers/iommu/dma-iommu.c | 57 +++++++++++++++------------------------
>>   1 file changed, 22 insertions(+), 35 deletions(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 9abaec0703e..5598ed4bff7 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -2068,10 +2068,20 @@ static void iommu_dma_iova_unlink_range_slow(struct device *dev,
>>   		arch_sync_dma_flush();
>>   }
>>   
>> -static void __iommu_dma_iova_unlink(struct device *dev,
>> -		struct dma_iova_state *state, size_t offset, size_t size,
>> -		enum dma_data_direction dir, unsigned long attrs,
>> -		bool free_iova)
>> +/**
>> + * dma_iova_unlink - Unlink a range of IOVA space
>> + * @dev: DMA device
>> + * @state: IOVA state
>> + * @offset: offset into the IOVA state to unlink
>> + * @size: size of the buffer
>> + * @dir: DMA direction
>> + * @attrs: attributes of mapping properties
>> + *
>> + * Unlink a range of IOVA space for the given IOVA state.
>> + */
>> +void dma_iova_unlink(struct device *dev, struct dma_iova_state *state,
>> +		size_t offset, size_t size, enum dma_data_direction dir,
>> +		unsigned long attrs)
>>   {
>>   	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>> @@ -2087,35 +2097,13 @@ static void __iommu_dma_iova_unlink(struct device *dev,
>>   		iommu_dma_iova_unlink_range_slow(dev, addr, size, dir, attrs);
>>   
>>   	iommu_iotlb_gather_init(&iotlb_gather);
>> -	iotlb_gather.queued = free_iova && READ_ONCE(cookie->fq_domain);
>>   
>>   	size = iova_align(iovad, size + iova_start_pad);
>>   	addr -= iova_start_pad;
>>   	unmapped = iommu_unmap_fast(domain, addr, size, &iotlb_gather);
>>   	WARN_ON(unmapped != size);
>>   
>> -	if (!iotlb_gather.queued)
>> -		iommu_iotlb_sync(domain, &iotlb_gather);
>> -	if (free_iova)
>> -		iommu_dma_free_iova(domain, addr, size, &iotlb_gather);
>> -}
>> -
>> -/**
>> - * dma_iova_unlink - Unlink a range of IOVA space
>> - * @dev: DMA device
>> - * @state: IOVA state
>> - * @offset: offset into the IOVA state to unlink
>> - * @size: size of the buffer
>> - * @dir: DMA direction
>> - * @attrs: attributes of mapping properties
>> - *
>> - * Unlink a range of IOVA space for the given IOVA state.
>> - */
>> -void dma_iova_unlink(struct device *dev, struct dma_iova_state *state,
>> -		size_t offset, size_t size, enum dma_data_direction dir,
>> -		unsigned long attrs)
>> -{
>> -	 __iommu_dma_iova_unlink(dev, state, offset, size, dir, attrs, false);
>> +	iommu_iotlb_sync(domain, &iotlb_gather);
>>   }
>>   EXPORT_SYMBOL_GPL(dma_iova_unlink);
>>   
>> @@ -2136,14 +2124,13 @@ void dma_iova_destroy(struct device *dev, struct dma_iova_state *state,
>>   		unsigned long attrs)
>>   {
>>   	if (mapped_len)
>> -		__iommu_dma_iova_unlink(dev, state, 0, mapped_len, dir, attrs,
>> -				true);
>> -	else
>> -		/*
>> -		 * We can be here if first call to dma_iova_link() failed and
>> -		 * there is nothing to unlink, so let's be more clear.
>> -		 */
>> -		dma_iova_free(dev, state);
>> +		dma_iova_unlink(dev, state, 0, mapped_len, dir, attrs);
>> +
>> +	/*
>> +	 * We can be here if the first call to dma_iova_link() failed and
>> +	 * there is nothing to unlink, so let's be more clear.
>> +	 */
>> +	dma_iova_free(dev, state);
>>   }
>>   EXPORT_SYMBOL_GPL(dma_iova_destroy);
>>   
>>
>> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> 
> Best regards

