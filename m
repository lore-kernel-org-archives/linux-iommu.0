Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011029.outbound.protection.outlook.com [52.101.57.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE63C1F1513
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 01:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789347966; cv=fail; b=e27x8ujEQ5k05El/4/2avpoBDsXR6dyZK6tABzTB1nUyGCGc96nXNqJL+xVmeOmEChpRs0Ni2vmE3NSrMLWZNE/bS1Zu3yPKuvgJRW5ZlTSgNXa1sP2VuD0qAAR23bezwYBHyZzjT7Zw1P+D8xicMa5U70h1GsmSag9LPnsj0dU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789347966; c=relaxed/simple;
	bh=dAhGfHZCpxFpjUupHR8A/J3tz+A61WkDcwd+JE84Sno=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j796B6vJVQ2qMgqnjijFXo/a3u3/UtgvVYjWdLROiYi2j7d2IrZ849cpZqBj8mnc723AC5foGSSTRu/bD4amOoyd0hYf981JoClFDW9xPUBQ78I9tbrbTyQm1DNCpTT20DEj3dZXpLzy2ujAtmYvmuHkpd1Son0cCA9cQhX1o2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0JICu8H1; arc=fail smtp.client-ip=52.101.57.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0JICu8H1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qAKJPK2CIThzhuFqvmc27Vr/+fTBXKWhKzDI8E/xVUCtLBeYl2NXg5D0Mu+ybi0eOQDRgK4GXB1TsIiB1nxNdxqPcTlPJ0SsDUFTJBSSW/ul/m9UfGF4TGicRzh9sK4fl16dluxyIbDf6XrKlQBW8B/zlKeJQWJX3MRQEv1Ah4ams7eV7HWA8xZZ4Xb3v2rFYTiI0hF5VA8HW3F1ypPNuuKeMoRN91fAmdG+Sh5vc7cpgAFVR++1h/mJH3gHrPmGQr/yes99LsJjDYDns8HfkPkvYtaosQ97rSz8Hga2rsKtTqIoyaF7ESszQdstkDYQyg4FXgfDu4tz1gudNZvCLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVN5e88tq0PpfJrGwKts9jyTEadAVS3IY7X5NFL1KRU=;
 b=lzTMC5qn0PP9OZgdYxyJ2a1HKE4ofvAmF7Qn/QpalEUr5FjhwcuaIGLVFg5Z6KWpE/PkeqHb5znVDUopJ6vs4NqiMo+ODnoJJyENpf9l43Oh6Yu0JLBb7j5iABY+Q8lhNjlGA6YTmEHPAXm64X0bk8AhjvGKP01+zMs3/fZzRiD9sXvuBsei6WhK29mlmX4QfX5tHSGRKtcdXWQwUSXJy8JBUVAt6N8kmAGsn03711Vchm6bSSF3gJCgwpjC8NS+Oh6gPZSuEyzZltukPaU4BAZ1CIbVCyBbkJZjV4N2q/92CD2GE684b3QredtzxG4DBUkBlUaPjmwqgu0QoKlIxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVN5e88tq0PpfJrGwKts9jyTEadAVS3IY7X5NFL1KRU=;
 b=0JICu8H1GU8P/YvtTVoibcdI89QFum5VDNav9GuN3+7QxW8W457inU0gSuRYOajXXujI/04V8W52bZ4Efjdvq/3jNYiJxzNSis+W6eeqVySCmjgLSEA68o07H0Tcudpb+q5ShJdRz3ZPAVqcWoAsi1e8LKmhasJUJgz6laytkEE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10) by CH3PR12MB7716.namprd12.prod.outlook.com
 (2603:10b6:610:145::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 01:05:47 +0000
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3]) by SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 01:05:47 +0000
Message-ID: <078f0ae5-7bd6-486f-b260-b8a9ad8d0972@amd.com>
Date: Mon, 14 Sep 2026 11:05:42 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/mm: Don't force unencrypted DMA for IOMMU-backed
 devices
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev
References: <20260908113232.247457-1-aneesh.kumar@kernel.org>
 <da147aa4-79b6-4388-bdf4-d1af28b1ae77@amd.com> <yq5ao6e5a93n.fsf@kernel.org>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <yq5ao6e5a93n.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5PR01CA0046.ausprd01.prod.outlook.com
 (2603:10c6:10:1fc::6) To SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB999228:EE_|CH3PR12MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: 51ea1462-abb8-4a6c-a5d9-08df11fc4f42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|22082099003|18002099003|3023799007|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	VAxwDiGDocF9U7w2uuR/zOBVXiOp3MFNYD1nbLVcYkHNGzCmGJC+5tylCBXLlwpID0EokA3wciKecYGyoyDW/0AmxbrDtWTx0Yh73juudr0PkNtejOS7He9SW52S+Ui7VgxjHjbsklBrPaGMo9artVN+cpBrZPCqROPxhVZbL9dfxTW5Egk/SXuJtiW3qcTpYrOCELqvqntjFTYOoYX3B2wJIoPGgHtwQqSbA0HC2e8nnNLYkbJC7auJ40+dSjCe7mBBV/VGS26sAs6PmTtVvWYc46LrI+NuIKQpqFCoeqR/zruDHOhA/D4LBdQ/+Onvm/CQLvkRtB6s/IuJ2l/vi/az5Ey7FK/ccwM7Z+Up1L1ySoqxdvIlbXB4NXpuQw0tteuclv9c8vlumgBSBu9SaEBhpPlqpEUbnGidsk3J61fFmSp9uLt9LaDqcg5EV6pvV5o6qzchtw5UWSH6GesfyRaY8ZGxpU4m9elPZcERD1Im1rlDCDjAwM4aOQeXMHtBxyChRjxkPHeBXpZdlWeKfcMkkfgkiZzczXcGjjKJLlRRYfhM9o+AyOzHLhdsi4cnrECuj+MT6V3riDJz+jVc87WguIR6R7UFD6+KiWAlR0kbbChyvEF2kFeRW5eBPXSoffEWwUTPFkWlxIrNZEYoziBncIv3axClPQu3FMvET5k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB999228.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(3023799007)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1ozVnF6RnBrWTkvdmF5ZzdvYVIyYVcwSjYrZFNDekI4b1JPMlFnNjdTck9m?=
 =?utf-8?B?U0F4WGtZQXlNZDlpaGJZTGtoTW9hYThURW9hMFZ5cks5WFRHR2lDdzB3SVc0?=
 =?utf-8?B?S3ZzVExVQkRINjZFaGcwN0hCM3B6clllNnF1bGlkYWFwY1U1dm9pQ2Y3Q3FG?=
 =?utf-8?B?L1Zwc2FJbzk5TzRrbnZVTW5FVjdDais3RUJSNXBxaWJiUTZNa3dmMlp6UWZS?=
 =?utf-8?B?RGtWUzVGUlFiOEhua0NOTjdKTEV6MFhrQTNGOTZBVzdWVUlTUDRJN1F6N3FW?=
 =?utf-8?B?emVETnJlRDI4U1NSN1RyWUxXTW1FWWhuZ2VXSHBXRFlWVHhWZ2VidkxlWDhn?=
 =?utf-8?B?RmlSYjN5ZDgzR1VzMEpTNXBFMm1wUHdMNEUvRFQ5c0x2Vmk3bEdDSE1pL0c2?=
 =?utf-8?B?TEtqN0dpc0pDbVRkbWpUY21KRG8xeHV5dWFQNzRZSENKc2Z0c3RGZWdUbEpy?=
 =?utf-8?B?ait0N1dDcjlSNU5YRmxBOHVMMEo2VUJPSUNHK2FDTTl4azQrQ2VNRkZFWDQ3?=
 =?utf-8?B?UFdNVit6Wi9NVmZqM2lrTkYzcU50Q1FhWEZqYkE4a1Zaakl4Yk1sUklqdk1F?=
 =?utf-8?B?ZWdaSk4yOTFVcm5VQ1Y5bmE3TUN1ZnRFd0F4YjlYYVVsWDBtUndBbjhnbmtF?=
 =?utf-8?B?OVpKYWJZS1E0MXZOTisxaDd4SzNTTUJrTVRrM3lML0tINS9qSlQ2UElweEtL?=
 =?utf-8?B?bkltdjFpaTNZeHZZZXF2Q3BvVWYxQ1VHcDUwc1JydDZTcnc5NWpNc09mcHhW?=
 =?utf-8?B?elRVandHaVQwWDZuT3g2bEgwM2o3SkJjOEt5NXBrMVV2WTdyczhlWTNXRG96?=
 =?utf-8?B?T3YzNWJkTkhSMXFQRGZ0QW1HZjVFdEJtTGpKblI3VzFHeFNSanJGYzdMbGxB?=
 =?utf-8?B?VjN6UzRKMzVMWHJzL1BxYkhLcHo5RXlSdy9hTmd6OGxEUGRhQUttcUhWRDV5?=
 =?utf-8?B?Z2w4UzgwRXdsd05qT0ZnaU5kamxRZUJWOFlsdkZWQWlHYXRwSUY2OUFOSngy?=
 =?utf-8?B?bUZHZnE0M2tKS29UMlFvYkhsTzFwa1VyWHpCSnVqSXZ1THFhbXB6UXQ3NHBp?=
 =?utf-8?B?QW5kYU81dTlJZENTS0xVRG1KK0s2azV2TDVvbUIvNWQwRlBCYllTb0NxT3B6?=
 =?utf-8?B?MWtJQ3Z5WngwVEhYanYxVHN5MERjQ0RkNWFNSEN6SmdqUFFvQjBMSlBUQSsy?=
 =?utf-8?B?VVpHZkpwQTJ6bklMcjNJQnEyUVMwZXh5UFpCSGM5T0txK05TcVNXRmltL0th?=
 =?utf-8?B?Q28zSkU2UFVZell6dXBrYnRtVnUzazRNYzhCaW8yeTNmQkErbXo2bURzZTk3?=
 =?utf-8?B?RjA1ekZ4UVd1SlhCOWVnQzdDRWR5Y2RVcEwxbWloMnhueE12Y1h2S3pnanlZ?=
 =?utf-8?B?MUxCaStEQldtV1RJZDFZYzFZaHgyUzhTbi9TMHRPQ29pL2lQSmVId2srVEkv?=
 =?utf-8?B?M0Y1M1c3QkJ2Z2RxVnhDeHhpWmZZZTdqWU9uY09IRlZHdmpZMkl0VjVQQjNy?=
 =?utf-8?B?RHRSaWc3bmZ0dXdRMnpaTVkxY3VOTk45Wmk5WnNuUXdJV1pZT2p3bnFwWkdv?=
 =?utf-8?B?N056aEpEbkxldTcxaUpVQ0J1dFQwY2JhV0YxZEFHUEdOU3kxZy9lNHRJd1Bp?=
 =?utf-8?B?ZUxNNUxxSkRUR0YvQk1iNVdWVU5xWjNITE1acE5qT3JseE91VllySzcvYzA2?=
 =?utf-8?B?UXBwUFF6N0RFaWNERThJaDVYTGlreDMySDU4VFdtQktRVTVGMThTa0luallJ?=
 =?utf-8?B?MlZyRE51eDRKeTVGdTUxMEFsQmliOTVXU01peXM4elFWMGlJajRnTFVIYVlu?=
 =?utf-8?B?TFV0WEFWWEdXUU9VWTFVR0UwaTdtN3JCVEdOYXV0a1I2b0xuZWtQejhJM3ZE?=
 =?utf-8?B?YXdKL1h6SWNQNEhSWG14WGRvbC9rUzJUNjVTWG9CR3BPTjROQjk0SnhVWjM5?=
 =?utf-8?B?ejJiWW9nTklEQkFlUmJMN0tIaGEvNVZSd2dYWE5JcDZ5aU9mbkYrbVlzTm9x?=
 =?utf-8?B?U1dldWZkZjNhQ0UxVXhIQS9yZ3R6L25CM2VXV3NUNm1mR0lGaXdrVlB6VVpr?=
 =?utf-8?B?WnhCR1AyVkI4eGxZTis3MWJNUFNTN2pQUENuUkpRbVlQam9jVlJJU1E4K0Rn?=
 =?utf-8?B?QmdTYzZnYkRocGhla25LK2w3ZFhXL0J4TlJ4UkoyN0VrSGxFN1lwMHFXZFlD?=
 =?utf-8?B?K3ZQcGlWYVhqVXZFLzYvZTV0eVRYNTNRSi9ZNW9xdG9wTHArR3pDSDBXYnhp?=
 =?utf-8?B?TU52TWV3aXNBSW1HN0orTFMwcS84NGdnRjlWUVU5VW05Z3FYaTZmZndxTEJt?=
 =?utf-8?B?cUR0ZzdlV2RYYjVuN3BDb3JvUFBtdEw3NC9vdGF6b3N1YWZpSVZBdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ea1462-abb8-4a6c-a5d9-08df11fc4f42
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB999228.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 01:05:46.9880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: In6/izBrmggweOGvTTaFiYH6UQwkN6/QQQJ/XgF3zKD7za6o4PLb2//dc2m3hW3387rWb7k3pDAqiLivuyzsig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7716

On 10/9/26 16:55, Aneesh Kumar K.V wrote:
> Alexey Kardashevskiy <aik@amd.com> writes:
> 
>> On 8/9/26 21:32, Aneesh Kumar K.V (Arm) wrote:
>>> Commit 8277a12d0d60 ("dma-pool: track decrypted atomic pools and select
>>> them via attrs") exposed an issue with force_dma_unencrypted() on
>>> systems using host memory encryption.
>>>
>>> force_dma_unencrypted() checks whether the device DMA mask can address
>>> the encryption bit and, if not, requires DMA allocations to use
>>> unencrypted memory. However, this check is not applicable when the
>>> device is using the IOMMU. In that case, the device DMA mask constrains
>>> the IOVA seen by the device, not the backing physical address, so it
>>> does not need to cover the C-bit.
>>>
>>> This currently causes dma_alloc_attrs() to set
>>> __DMA_ATTR_ALLOC_CC_SHARED for such devices. iommu_dma_alloc() does not
>>> support that attribute and rejects the allocation, causing DMA
>>> allocations to fail.
>>>
>>> Do not force DMA allocations to be unencrypted when the device is using
>>> the IOMMU. This allows the IOMMU to map the encrypted physical pages as
>>> before and avoids incorrectly requesting CC_SHARED allocations.
>>>
>>> Fixes: 8277a12d0d60 ("dma-pool: track decrypted atomic pools and select them via attrs")
>>> Reported-by: Timo Witte <timo.witte@gmail.com>
>>> Link: https://lore.kernel.org/all/CANB4YXR7h8V5Xp=MXVZeSdvw9UiriSagp=E+ju5RRDNghoPHLQ@mail.gmail.com
>>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>>> ---
>>>    arch/x86/mm/mem_encrypt.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
>>> index 912f22ca838f..a349d8d21569 100644
>>> --- a/arch/x86/mm/mem_encrypt.c
>>> +++ b/arch/x86/mm/mem_encrypt.c
>>> @@ -13,6 +13,7 @@
>>>    #include <linux/cc_platform.h>
>>>    #include <linux/mem_encrypt.h>
>>>    #include <linux/virtio_anchor.h>
>>> +#include <linux/iommu-dma.h>
>>>    
>>>    #include <asm/sev.h>
>>>    
>>> @@ -30,7 +31,7 @@ bool force_dma_unencrypted(struct device *dev)
>>>    	 * device does not support DMA to addresses that include the
>>>    	 * encryption mask.
>>>    	 */
>>> -	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
>>> +	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) && !use_dma_iommu(dev)) {
>>>    		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
>>>    		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
>>>    						dev->bus_dma_limit);
>>
>> if we drop this whole "if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))"
>> chunk, won't dma_alloc_attrs()&co be able to figure out this from
>> dev->bus_dma_limit and other DMA masks we have all over the place? I
>> should probably just try it... Thanks,
>>
> 
> 
> That would imply that, with host memory encryption, no device requires
> unencrypted DMA. IIUC, that is not true. There are three cases:
> 
> 1. Host memory encryption with an IOMMU: unencrypted DMA is not required.

Then this helper returns "false".

> 2. Host memory encryption without an IOMMU, where the device's DMA addressing constraints cannot cover the C-bit: unencrypted DMA is required.

then it goes via swiotlb.

> 3. Host memory encryption without an IOMMU, where the device can address the C-bit: unencrypted DMA is not required.

Then this helper returns "false".

So it should "just work", no? And it seems like it actually does.

-- 
Alexey

