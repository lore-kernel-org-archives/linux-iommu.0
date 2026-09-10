Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010040.outbound.protection.outlook.com [52.101.201.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BC13ACA79
	for <iommu@lists.linux.dev>; Thu, 10 Sep 2026 04:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789014618; cv=fail; b=IgY7NZuJpqgX6l7BAmBQZa6zNa67731eBUkyuA5pgELP0ckfY7BxZHiKpNSUQMBHV5TsdY6Dxs2XsmyILkLx0l/IxAePfH/n4LL/0YegSb96PF0MU9NmmKbLeiXfHp0yPTPu7AZ25f6smO4bVSgzFORTI2t28MYOxNtbgbdsXZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789014618; c=relaxed/simple;
	bh=Yhx6UwDc/bXgWw3Psv8eiXbuv4z2N5fp0BQWNzaKd20=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mmm0METxI/dmILptpTC4OjZIzYCOnROFLCOaTIGs8V7yjchOBwTkP2yCKh/WDz2p2JY51HJMxf0VzkDh307dAizu9foAD25h+35QQF8l7xlJFS/KTpkz4Q3rGK38hByLAwp3/RDrpV8k85YPInDArDk35zl/jFs8n4Ne7nkMv84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BTbge0hn; arc=fail smtp.client-ip=52.101.201.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BTbge0hn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=taoKKHI3P0MUn9sjcavSJEYvngptWDAKvHPPP0L1Tb/Di8xcLiTnkycLbnBa7e06W8XsnKYBhamk+qe8tY4IqqUZ+yvTSPA/UKv1iIHwmK70TjV4u1hQAh5K0//YXHuEV1rN9hhwbOsKbMZkRUElW/Si/SFGVjNUNjTcUYVRrR/ZLgNPVC0/iZnHZNL8ohTm7VIvi79A0OuSn7f/0QWoHsl68qhaHRzRK3WwRkECAK8nFQyOsX+cy1KQBPJf6brClNqYBiGSshTgN6TN5ospFaBggKGkCTkPq4JI1XtcDG3uR2NjRjkkODjSWJ3+sukpcNxYLXei/9snl/Q1OQy5Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hgDS9M+XnCiRZWhNnqOEwmgcN2kOZBMAAo+uJoRWXg=;
 b=pO01hWEBu1QIQjI2XNC9awIvswhOe613pLfmnqzyQVOu44UiN7upohnZFds1qToGL0LC8C4pe76ezVlwhGsRYQ5sxVGfvVURwwO5gRPPnVTaDYvZm1yvIVsCxpMKBhi527/i2EOqniJrBz8pCOl/H8Gkq75duqdlsF0HWUQ+dyxdr9hAHTg32v6knwdhiLB+YI/iupnQQPVlmyFFuSmWlxpVY8NF3OXqscJlaf+xyGmjgflrktQxOhPwX3KiewUGSSkjg53mu3bbv5FX1mThu9M3yiHSTWTY9x9/1hyUVb0G6vy/rw6iQ5OZehIogKnNzRmbAKvM0y/x+0HFV7AYiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hgDS9M+XnCiRZWhNnqOEwmgcN2kOZBMAAo+uJoRWXg=;
 b=BTbge0hnlXr0nikBqt4Y8YC34asvK9Z3kc1lG0a3VT8+FzZb6083iY9DB1FT1zH6orSwq0fBvNANsrNf/Sb2yMb3JVF5nfEjY2CT+tfpuS/atn/kYjOKVhdVtCumA8mONiXc5IxntL66APdEFv+urjuIkVwWCj6o1XCJZzRw2Lk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10) by DS0PR12MB7727.namprd12.prod.outlook.com
 (2603:10b6:8:135::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Thu, 10 Sep
 2026 04:30:13 +0000
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3]) by SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3%5]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 04:30:13 +0000
Message-ID: <da147aa4-79b6-4388-bdf4-d1af28b1ae77@amd.com>
Date: Thu, 10 Sep 2026 14:30:07 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/mm: Don't force unencrypted DMA for IOMMU-backed
 devices
To: iommu@lists.linux.dev
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
References: <20260908113232.247457-1-aneesh.kumar@kernel.org>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <20260908113232.247457-1-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P300CA0107.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:248::23) To SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB999228:EE_|DS0PR12MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a88198c-d5fa-44d6-2586-08df0ef434c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vVbxN/wLz9xskBkQ0m5pMKWucQpWyBHrV9UskKrR2h4wRVJnktSGSHzL2tESIo2fP7PIVdy3TNUb6VGL+xZdFB6ka05x6WjehLolwgc/dtS1W0MmAerish/o10XAJUY5EB3kzqObyf8rq5AEeSX8IYRBaCIZhyq7xEjyb9BqiUn8W3Fn/a8aAsHCyLDpYg9ZCtfvTs8Vpo3mBngYwjeYaBJHKGaTpBzInbWK64JM8kjnC3bKz2WnueX1vE9RbQ/bCtKbDrgin8EDteojhXGl2QY22DROUCVrYNtS1jHIXoi1fFdyTJdLYDPjiADCKPcJXgir3yHgiw7d8L7r48frWtVNFFzjNNm8J0lArCdwz2ta6ay6EvzukyfmP0VdUXUk4KZby/9r+nu9zQNXELA3MwplbvHyWE86fRmdRPIbVWUb9xrpUqlSDQNqMoC/I5wSQIsk47gWAG5dL0RrwnvKRjHIN90hN+24mKrVjXhI31H9HGVRKNTePh8tlOrbfJBCDN4aUB05RE6h3BBLMixgDMd4te7+cHpPKgjxANh7UyZryGwUWRDx4RUErNoio8f3EWL6dxS95N9alY9KxaEFIQl5UMJjqQ5jG3ACya3ap8y517z3z7nxLdp2PK3NIQU1l3NunIrGI87kIlyreCE7a7ctC37VdBYjsLr5+deSNNI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB999228.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDBnNHhEejd6b3k3QVR6dmtRM1gyaUJQQ1B1bkVRRzlsRVVqaHFmZytEWHFs?=
 =?utf-8?B?TWI5SGZDS0NxL3paUHVhUjFrZUpNRzZSMnNTNlJrZTh0TlQrcjU2dmJZT0FR?=
 =?utf-8?B?Ly8rLzFvNFZjSTRDZmI0OXB1Rjl6c3J6WGs2MFZhM2dyM284MTlmanp1T3J3?=
 =?utf-8?B?bU5ERlZBWloyajd0emh1MjVReDhjdGxXcEkxTWF5TkZ3UVhwQ2hJRWJiZkhJ?=
 =?utf-8?B?QzUyUktpSzRxK0hTVkFDL2puSEZDSUhhYnp6aElmVWU3SWFDZEtCNFpSTkNt?=
 =?utf-8?B?ekFndkxkeUY3YUMvMmMzZzE0TTd3b3psQjJzSDhIRW9JZ21uUjdCNnlENDhV?=
 =?utf-8?B?WUJ3TlNXVDBEdzJ6Wit1WGpFZEtmMjQvVGxvd0xnaUJ2L2NhblhQVTZ4Tzc1?=
 =?utf-8?B?LzBNdEVRa3UzbnNsbzI0SGNMQk1yYXZEWUUrU0lOajhQR3dmVThaRE4wa2lQ?=
 =?utf-8?B?dVZiV1ZXRVNIOVRiQ3pDWlIxZ3dPdWY1THlVU0ZvNXd6Q0JpeVJOT1RIdlBO?=
 =?utf-8?B?WVVYVGIxVmZhRERMVFQ2NUM2UFd2ZmRGYlpMOFJ1TUhLZGtRM2NoZitvU3FJ?=
 =?utf-8?B?aXVHU2J4Rkl5RTkrbG42ZzZ2N3RSbnRXMGJQMGsxSEwxdHlTMXN3YUtQenVE?=
 =?utf-8?B?Y3BqR2MybHhnZFhqcnExNDB0SzB5SThIVElDY05NR2poZXIrSVVLV1dkTnNj?=
 =?utf-8?B?RXpRK3J1dC9MY3E4anNKNS80TGVtNFVULzRCSjQxQWlicHV5TE1RanNrejkz?=
 =?utf-8?B?a1o1czd4bHVHS1BtY2FPREgzOXJ3YytncVR6MXJidnJvSTRNTTY1NlVSRjla?=
 =?utf-8?B?aTNIM0V5aWR3NXdVbFNxWS9nS1FLUkx4Mmk1Qk5qQUc2bWxvREJrVjlvcXov?=
 =?utf-8?B?WUJHNFBXb1JjMlR0b29VZGk4TlhJTWswVVozc0NsL29JbVZRdGsyYmpyR2o3?=
 =?utf-8?B?UHdTZU9YY2VycTF6ZG9ETGEzMHA0QlMxdzdLUHpNblo0UkowVmZMeVlLeUVO?=
 =?utf-8?B?K0Z3QkRSMTRPb1pNTC90RGQ4NlRGZm5POTRRL0hNMUg4TFlLbWcwRzA3SUps?=
 =?utf-8?B?aDNWWmNFcTY5UFM3dGN0WTQwZmIzVXNqR1NXY1VEa20zMnpheElZTlpvRGtu?=
 =?utf-8?B?RWs5dlUzVzBBL01LOFlHZkRpeGpVNC85VXhCWXdHRU5ycHJnVEZvZSthMHJS?=
 =?utf-8?B?R0ZJdktoSUVhRW5KWVZPbjhZdWt5QlRrOW9jSk9PWCs4L1FIWTVVQXd3dmwy?=
 =?utf-8?B?bjVaaHhkZnFVVTU4UEMrRmw2K05xZEY5bXZqR3Z4emVpY1hKYXFVOVdOQzJi?=
 =?utf-8?B?dDREbW1TRmdzYU1McU9rOXNuR1JTckRwWTFucDIxbjZGd0UzVStPdzNpT0l0?=
 =?utf-8?B?Z0Qyd2h4LzM3ZW9JNWxpNjdEd3ZGdHQ4NG5rWGkrMUVnS0lTWFMwOE1VRE91?=
 =?utf-8?B?VUpESlByTUR2R0NScEErdjVFZkdiemY4NHIyTkJYSEtpSnVpNGVNdU9hWWlX?=
 =?utf-8?B?elhJRklWVGFmT1dyK2J5R1pEQ291TXgzTFd3REYzcEd1MEx1Vm1NOTRPUzE2?=
 =?utf-8?B?T0VRcHhPQTdaVzJnSHpRR016TFp4UUJqYTdhWHlhb09ZSU54RkZOQ29Cb3Bh?=
 =?utf-8?B?U2EvR1Y1QzhrM0I3RnpzMEZWQ1FCaGVYMUUwY21hc2xkeFhpaGZUSTQ0TWpw?=
 =?utf-8?B?ckxHTWExQklKRnZCUmhHSGg3TDRDcnpiNTVYTENaeDRBVW1RVFEyTWU5ZHRy?=
 =?utf-8?B?ZzlacllINWZHYkFiUXRVTFhIZ3ZScWh2d2ZsNEpVdW9KbGtueVlNcTY4VVpw?=
 =?utf-8?B?OGdtakdudEJJaERaSTlCWDlSYkVINXVqYnIxWXJYMC8yc01TVXo5bEovRjNH?=
 =?utf-8?B?QkF5MlZFQkZaWWdlSTdCWmVrMWFURlpnV1ArZ0V5VnJYOFZ1ZlBXMldzM2Nr?=
 =?utf-8?B?cCtvUGw1WG9jNTloTitmcEJhQWE2bzJkMXVNNVFwNWg4Nm9kVFR4ZGczNkVE?=
 =?utf-8?B?RDBPQWJPY1cxc1I5TVBZVjBQeFZ0Y2F5eFF0czNvcXV6WG5BVUtwQ2tTVjFm?=
 =?utf-8?B?dGlpcXlRdzgrdXl6YXJTVW1heVBia0gxa244clNvclpmSGprK1lLS3QrNmpH?=
 =?utf-8?B?WFpoM2duNndXYVBzSno1TnIvM041VGZ0N2w2ZHp0eWtCbkJaaENBbUhzNU5M?=
 =?utf-8?B?c3JBUm0yb0laTFFxRlFLdGJCdmhHSGJ2SHprOGVxQkF2Z2ZlTU4rSCtPbzJG?=
 =?utf-8?B?WFBkVnlGeEM1eHpINlh5aFFXYmp0cm9mRUQ2aXYxZHZFVVVxWjkrUkNsbmJP?=
 =?utf-8?B?T25rN2w2Z25wNlM2aFdxeEFzOHpBS2FtTTY4eTJoTDhkZkFlMkdTdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a88198c-d5fa-44d6-2586-08df0ef434c1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB999228.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 04:30:13.2064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rUFvFVdk/hT9QxqiFqKdvgKbQhuae97s0XxsutqVr7vhzhLhqlwYgS097Z3vPvnO3epkiEwniUmizNw7zu86OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7727

On 8/9/26 21:32, Aneesh Kumar K.V (Arm) wrote:
> Commit 8277a12d0d60 ("dma-pool: track decrypted atomic pools and select
> them via attrs") exposed an issue with force_dma_unencrypted() on
> systems using host memory encryption.
> 
> force_dma_unencrypted() checks whether the device DMA mask can address
> the encryption bit and, if not, requires DMA allocations to use
> unencrypted memory. However, this check is not applicable when the
> device is using the IOMMU. In that case, the device DMA mask constrains
> the IOVA seen by the device, not the backing physical address, so it
> does not need to cover the C-bit.
> 
> This currently causes dma_alloc_attrs() to set
> __DMA_ATTR_ALLOC_CC_SHARED for such devices. iommu_dma_alloc() does not
> support that attribute and rejects the allocation, causing DMA
> allocations to fail.
> 
> Do not force DMA allocations to be unencrypted when the device is using
> the IOMMU. This allows the IOMMU to map the encrypted physical pages as
> before and avoids incorrectly requesting CC_SHARED allocations.
> 
> Fixes: 8277a12d0d60 ("dma-pool: track decrypted atomic pools and select them via attrs")
> Reported-by: Timo Witte <timo.witte@gmail.com>
> Link: https://lore.kernel.org/all/CANB4YXR7h8V5Xp=MXVZeSdvw9UiriSagp=E+ju5RRDNghoPHLQ@mail.gmail.com
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>   arch/x86/mm/mem_encrypt.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index 912f22ca838f..a349d8d21569 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -13,6 +13,7 @@
>   #include <linux/cc_platform.h>
>   #include <linux/mem_encrypt.h>
>   #include <linux/virtio_anchor.h>
> +#include <linux/iommu-dma.h>
>   
>   #include <asm/sev.h>
>   
> @@ -30,7 +31,7 @@ bool force_dma_unencrypted(struct device *dev)
>   	 * device does not support DMA to addresses that include the
>   	 * encryption mask.
>   	 */
> -	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
> +	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) && !use_dma_iommu(dev)) {
>   		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
>   		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
>   						dev->bus_dma_limit);

if we drop this whole "if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))" chunk, won't dma_alloc_attrs()&co be able to figure out this from dev->bus_dma_limit and other DMA masks we have all over the place? I should probably just try it... Thanks,


-- 
Alexey

