Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010020.outbound.protection.outlook.com [52.101.56.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085D0457E46
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 13:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789391847; cv=fail; b=fdypWblmKX4vKNjbadjsMJbOdNfJvp0j1cQjOCeP7xlkLY6MlWh8hCHaTKV6EpunWkXwTOr+WxKfh/MR2znCYCqaF7eBboAcOpWBKInuLIbYUQ5A9PX40g4O1SrryYQYQMSytjL2A1QGb3vrFq4ZKcF7Qk0Hhp8/PLPCFkEMxgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789391847; c=relaxed/simple;
	bh=B/D/qGGXNyUeeVqJ+YbLvEWIlgnLc8ehbRuJkyKf4Jc=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Oe42A9lCWUV/45yXd9uJA6F2tYVbOsklaa8dkVuRAAJoRuLPANNn4te4bKq2iFtPU2sbsDzLSNExs1kE1naJ9RnrIBNJSpDrD3DmNhE5Lc8hKKGfvVzjLvDFJgeqW5jiauFCq76my2WCuKfhr0Y6z87GtO0Aq5pGmQteIFzDslA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u8fkJGR3; arc=fail smtp.client-ip=52.101.56.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u8fkJGR3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMSPBDEJYsHbtYoaNdWlORpfEF/SYsi0GUhhvvDwZWaZ3zXDfOdPyhTip78dxM7FseRRJWkAc2DRUAHlW6N6mvA7LmXOTVqEA4JpP/H0yX+yKQnNA7d8NG6N8gx6TLRibYcX8Qgm/gG8GvagVS0NcVpJxp5/qfHuwYCEh1mjxcOhnNP2EOVYgJ99lD/s1n6MNuw36KBTnm4I/pSD2g7qyTlPDNNlmmSc+TqeHXkUWg1x6dxhf9eEQBCoeETv5QaHD7jPtDnmVTJkN21CdJvgG88jNdquTCZ/yfNAVeXhT4uS1EOBLnla7k9wH5sVuD94iz87tlqCLMsCzbUmyJSzHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3s3AhVKfJnK1CPAODgbWiJNwel50Wg8maa5LQEcjWZE=;
 b=bFC//7fBk8KT/pcs3/xZZqFJ5maWa5vC3UAbrf3QzUmxxdTjlibRz2RTfD9WTBpz5vqE810zqrkS+Smxl/4mhj83OeK7AyHqx5mcxyF6qbD/uzx65mlcb+s52qnTu3FtALWCMij8HlUZCwXxPguVsKnL4HANANe5zM6XgF43h/mt4+jC5QEI6/R4VVYpV64WddSqrF6lMgVPkz+9ePfRnx82zeZWEIvalbmc1XAQJT6IVSQecmXqRDlMekbLtsWelue/Ii0LIGVqAjrtmk+RV4jxaSSk/viAfHBseMFmBb9d6eaNmPz3D6/dMeQw9v/SF8NXsBIbDsQ58JYY8ME/XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3s3AhVKfJnK1CPAODgbWiJNwel50Wg8maa5LQEcjWZE=;
 b=u8fkJGR3j2D9J5FqwQzoElNloV8wguReh3f6ZVVCuISoIss1OV1alwxVkvQaFvbqiQTpv0SwpR8GDc+kBY53t/m/O/5KfJPsuNJeFovQKY5GW4KNXvcASQMxiBNXpuAo6duscGxf4QiiCQhoIuzUP9SkJbhioKxlaPWZ39M8F44=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12)
 by DSVPR12MB999286.namprd12.prod.outlook.com (2603:10b6:8:41a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 13:17:22 +0000
Received: from SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::c2dd:62c5:67fe:aa46]) by SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::c2dd:62c5:67fe:aa46%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 13:17:22 +0000
Message-ID: <df4209bb-0bfb-4f19-9de1-2b03148846fc@amd.com>
Date: Mon, 14 Sep 2026 08:17:19 -0500
User-Agent: Mozilla Thunderbird
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH] x86/mm: Don't force unencrypted DMA for IOMMU-backed
 devices
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Mostafa Saleh <smostafa@google.com>, Alexander.Deucher@amd.com,
 Vasant.Hegde@amd.com, Timo Witte <timo.witte@gmail.com>,
 Alexey Kardashevskiy <aik@amd.com>
References: <20260908113232.247457-1-aneesh.kumar@kernel.org>
Content-Language: en-US
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 WiyqywZI5g==
In-Reply-To: <20260908113232.247457-1-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0276.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::11) To SN7PR12MB8131.namprd12.prod.outlook.com
 (2603:10b6:806:32d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8131:EE_|DSVPR12MB999286:EE_
X-MS-Office365-Filtering-Correlation-Id: 10cf0045-9aaa-49bc-f457-08df12628306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	D0Z0iTFdDPhNAgVsovLiTlp4GYba3id38TXBuFz65KA0lmGDktcIICuWM84OohQuvXwiwpXNKngeHPJFIxUkQxDohpVq32ZzogCK51Y0a7129TS2aS6jm2EEdFNNjONKiwCR3L3Jaq/KgYbDx4KXH1U/tlY1h4JwxWS6QWdwvhlKo3+QWOmMt/lKr2/gvEj7cyVEAjLo1754BiMv0rRpmgrihVpsWbW6MrQ/ZIlZ5TUiX+V75jTll/E/xIdLNSU96NhQbSOKKwYNYA/eKD7cFNKePtW2gg4jhBdBaN58OSJkVjE2kRQWHtuR6IrX7Pq3szvQBdo1dRHuBGIfqrABFOvGlB7SLeRIena7ghA0Lx4ehqlPQtM7A9J1ZOrP/KX1MYwcj4e/K2XuEm87N82ju+cCqD9E+GzqAeoMcaVhYHD9ocLTb5CUJNyorYba/h79kXshZjNbWRiRNdxJm1/D4gfugVRl3XWsHkAl11We3PGQUZr8TmYExGK1aMQgZjeEclksHUSrcSzmdmlVOa4O+3+ZG4Vxou6zQBpH5WC++ceQkaiir7rU5PT0i2jVJcr/4cbWdA8wlP/ZMlUcHhAHkxIWOjfaV045YISAQMj12bAioe1QZwJGUrnT6UIcJWP6SfqUecgyhYDznYeHKBF0CDMbe4zzwVnkLkkKfRIx+EE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8131.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnFNQU9Nc2xRVjFQL1BrcjNLaloraVBOdUdlRmNTa1pmOWhpenJzV1RBdU1y?=
 =?utf-8?B?SkJwcUtvU1BVQ3AwYVEwSGVuR1ptOStkYWlPYUh5cHp4RXQ3aTNkckg1MEdW?=
 =?utf-8?B?UTNsbTQ5KzNHR09zaHFiN2d6bGtudmNlbURINGRpMlNEL1JHY3I2Y3ZrWUpI?=
 =?utf-8?B?RU5rU0VtbGFTYTkyTEJpVWM5NjhETC91Si9RZmozdTBLMWFnakhYbTRsZ3ZE?=
 =?utf-8?B?YnZzR1I3ZmpmbUxXQW11cjBLOXhORXpnZFJOQ21kK2NaalR5VkRBZDFYZEtC?=
 =?utf-8?B?ZHY1Sk9nMUxEWEJZcFNyTnk4RGZkc1M5bGd5OVA1TzVnVFRVbGQ4SnZzY1h5?=
 =?utf-8?B?UFhocnZBVE1DV3BTZ21rNG9PaHovUWFwbTZHNWR4UzF1d3Qrb1JMSmtramNp?=
 =?utf-8?B?U2cxOFhFQU5VYXArSmZuTCtvOXRrLzNoUUJCYWF5VlNjWENxVVZSMVpTYW5t?=
 =?utf-8?B?eTFtWkJUZWI4R1lGN1hNL1paY3VXcnRKd0xJcVZQYmQ2SlFwWml4NjV6SzZW?=
 =?utf-8?B?WGRDMkZKLzlFeEtEWTBORmJpNFlFNzdMR05NeEoycEM3WHhPS2pxSFJiaTU3?=
 =?utf-8?B?dXMyUDI1ZHkrUC9ualZqTjNQbm1tNytEY0RZL3pOWVpJOFAxZEhhZHIvUXVP?=
 =?utf-8?B?Q0FmNHdVSjVPZkRENDRXVjhCcXV0dzBNaEExZ1FTa3BuQ1dsSWx0eUg2TFFh?=
 =?utf-8?B?RkwvWFVESWlkWmdQM3pNbW1rbVk5czRRNCsyVkxYcmZPdkJsTVRodmRlUTZi?=
 =?utf-8?B?MTVMUTFXOFNEaHVaYk1hVDBqRWk0TGtjSTg2dzBqNWRJWXFlUTE3V2VlRVlZ?=
 =?utf-8?B?VXpDc3BCclF0Yk9HZk9BenV6bklyRzZFL20rME5tVXp2eHE5NmRlUk5lOEpV?=
 =?utf-8?B?V085N09NVGttR21zT0ZPdHp0ZDJ1YVgwZDZQQmJaOVBnSG5sSERZVE5UZnpv?=
 =?utf-8?B?WFhVL0J3ZjhoWkJIbmNDaXgva21FS3c4Y0tyT0lwNXN2N2ltYk9uZGRyV1BV?=
 =?utf-8?B?OWgzTzVIaXdNakxpQ1FSN2lTWjRNaGVQcGNEYzRTT1JvYS83MmtDcEZKRHRG?=
 =?utf-8?B?ek1sT3U2UWlEeVBvT1ZUTlRlYTFCNWFTSmcwa0hYeVh3Zi9FeXhROEFMMUtF?=
 =?utf-8?B?VXF1bXhRQVVEYnRrSEp2UnhwVUVIaVNuRjlsamFmYnE3dGhtYXJtVHNhQ2VT?=
 =?utf-8?B?VkpVMjcvTzlVM3RCWG11YVBibXNxTUxKSExyQUF4ejdRVWhJTlZUYllUSXBs?=
 =?utf-8?B?bmtCOGdISGhHdk9SdUdGTlNCOW9MOW1abFBzQjAxYzdsNUFseFhPY3hIdzBK?=
 =?utf-8?B?bENtSUM1U3FHekFYUHd6SWowSHJzWHZFRkFEN2U2dWVZeGpPN2lSM0J3czdp?=
 =?utf-8?B?cGRQTE5MS1NPR21vdUVQWW00N21WemxiV2ZoWGJsbmx4Sk5xQndXRVdhTll5?=
 =?utf-8?B?YnFOblVRbFZjbVNWa1Nab2FkVWNndmRkOUhCdzgrYXFTemNWdFhvRkUzZDRF?=
 =?utf-8?B?M3BoR0VjQ0FTcGFZVEZkZ1BRRDhGbmdmTXQreEZlYnh2dnh0YXVaODVnU1Ix?=
 =?utf-8?B?ZGVxSVJ1N2QydlgycUtHZURUbExSS1RzSk9IcEhhb2NGZlR4Y1gvUnpFeURw?=
 =?utf-8?B?VDhNcnJDNEtqdDlUWDZMVjFtM1N3bVoxdDIxakJHaHRYZy9xdmh3dGZiU1V2?=
 =?utf-8?B?cGFFbFZMMTFicXpFWklFQU14Vm1FY2MvdWNYU2UwQlZyRXowWFVLUWtRM0NJ?=
 =?utf-8?B?UFp2UWxQOTB0OVo3Q3dNVDQ3eGZtOUl0K3JkK3dsWDdDUEJmZXZ1bjhkK24w?=
 =?utf-8?B?ZEt3S0JrUVFMajJpQWR4S1J3cjBRRWY1LysxQllhZnNaQ1lKU0RpdTZwZTRL?=
 =?utf-8?B?TXkwdDA5VVBmYXhOZDBCdHAxQVRNOEFUdC9PKzJxa3hTOXE0YkM5ODdUQzRF?=
 =?utf-8?B?bFg2SnZSSHBYRkRCWEpFeUlJdVBNR3VKa0tLMzZwMkJqMEJRdnZ6Ym40eThZ?=
 =?utf-8?B?Mkw1ZjRNeFdnY3lQWGxpSzJDTE5mUllacU52ejlPUWk5VWFYV0crQ0NMb1h0?=
 =?utf-8?B?ZTNLTndRazZtejlhdU9GMmY4ZHZwVU01dHAwRU84TnhFdlMwYjIwTmxBS0hv?=
 =?utf-8?B?NW42cjE0MVpPR0lheVFXUUd4YklGamI4OWpFV3BDa3VMdGpGSzYyN29yZkNm?=
 =?utf-8?B?WVBTU0EzZDZXTkV1NGVFTXFlMm1SOTVLZnZCem9yNS85R29IOVc3SDVKbHZn?=
 =?utf-8?B?Sk00R2ZoZ3NnMUZpTGYzYTFGUENyWVdjbDA2M0E2SGdHbmpGWnlnV25XaWVi?=
 =?utf-8?Q?zURmu8R8m3/1bSQjg8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10cf0045-9aaa-49bc-f457-08df12628306
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8131.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 13:17:22.6923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xdRjpW1ZTjwwdEopMte/cimMt7qqOwI/45937Dl5NNIqfMRR5AcdSzRlgTUdAa2AUD0LVIGr0f7hd+VLAhqkWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999286

On 9/8/26 06:32, Aneesh Kumar K.V (Arm) wrote:
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
>  arch/x86/mm/mem_encrypt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index 912f22ca838f..a349d8d21569 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -13,6 +13,7 @@
>  #include <linux/cc_platform.h>
>  #include <linux/mem_encrypt.h>
>  #include <linux/virtio_anchor.h>
> +#include <linux/iommu-dma.h>
>  
>  #include <asm/sev.h>
>  
> @@ -30,7 +31,7 @@ bool force_dma_unencrypted(struct device *dev)
>  	 * device does not support DMA to addresses that include the
>  	 * encryption mask.
>  	 */
> -	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
> +	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) && !use_dma_iommu(dev)) {

When this support was originally added many years ago, this function was
not called if an IOMMU was active and generating IOVAs. So if this
function is now called even when an IOMMU is performing the DMA mapping,
then this is appropriate. Although, it would seem that if an IOMMU is
performing the mapping and this function is still being called, checking
use_dma_iommu(dev) and exiting early from force_dma_unencrypted() at the
very beginning is more appropriate, right?

@Alexey, would that impact your TIO/TDISP support at all?

Thanks,
Tom

>  		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
>  		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
>  						dev->bus_dma_limit);

