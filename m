Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012053.outbound.protection.outlook.com [52.103.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7009414F70
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 03:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790565541; cv=fail; b=UlrTczJAufH1V56ftfTMNsQMBqlDhnFvmayDFRMIO0dp+CVw2jlsLFqgdyaKiYJEG0tEUj11NF0GPirBD3Mordk8Y3N9C6Q/gLPf1XKMC+9oGIq25p+iMck3E7IfCoqv+Qu6EnZXinpTD70ZhMQupUaoC+AVqaV0vv0IUaPI+cA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790565541; c=relaxed/simple;
	bh=opsr57Gk14enkvJnScto0R/vkkf81VpMQ7zXUAmnMk8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C4PhioUdh7BMttK4fARIs1KIEY8ecYl9N4FoGCJHyviVtkqNudIXlS17a0d0JnLd+QQA5J1luVrkoeLmlvk4KPJO45dVig90V1Dk+N8Rlqo1EFwiP/I7Jr8XZL0SpJdaL0sqHPIYGQCMquC4XvFqFgRTaTbrW/D4yHSmXaCbOD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Si8PhKxb; arc=fail smtp.client-ip=52.103.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Si8PhKxb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=apnZk1uawV2toYxvChQLqZbtrcaVq9gyoODtHtETuAK8Ias1GbVyVjVzoC1VcKSrwQ+p0cv+OJv0/TUxp13qBanPa8ObSzR0zgfO8Ov1sf8ZARxlOsKIDr1RPmzx7cxaCppjTD9eCBZTh74bGA7bLVbjfBGc0wCc+KFgGJBZ03VefTP5HYKn75Wv6NPj04tzYsGkpuHn1VOkv7tdZJ1GATtsrAT72d55v5wgSuLcf0QIjjUgvSV3CfSKqTWr3lCCRLQWxMfilk9D25Fd1Ebe2wwQGIgSw5Lb0hB71PwvQpBu2BLnmuzCFxqiffyv+MMImTqIk7eaZPGoFgzFNwo2Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/Zej3E+3NOo93d5TUX/uDsDn07Sx4uKdQFkL3lX4x0=;
 b=p56Gfnlr0ihlJJ9r2UzmzyJdrwMMGt5BnSZsciWO/SJSc3xQYOvOiqVyxYkf/EVSk0po6gW8h8VHDKwnhT94WE2jtdr1EMJOrryoQ69NHlpJ1iPcnpE8IEOti27KagX0oTkLj+HOo6eQCi/PfMrXz6W+ydeXMCz0Z31gpEFLstXVQfNDmBAbw80UTHzo9wY4Rbwc4Iy1/S5Xk73juLWEYc2jSP6mloVhUSiBVEK3+mSUO47OINUjwGgJ1aoyJYpd4ZDCmhZDtofYQzR+STvgcNAp9NSps21PMEtCZGBzIg5wEGmC9Zg07y/bqEJQEjIxcIWirOAt6x0NBdWiaSM+Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/Zej3E+3NOo93d5TUX/uDsDn07Sx4uKdQFkL3lX4x0=;
 b=Si8PhKxblgG/wEJHXBB7dTDmgn5H6eGqwh92Pr0VACWaj7tMDaiFsR8zNLJVjX95GmqX7uwUBhKDXMdPvARl/AHAYi30creYUZR1TfW6X3LYPjOYA1BwU96HlEs5WIhlX96mVJuDGxoNdTE0fwuVKec14CJdt7Czgys6RepwUIwXyjeKVcl32ip8RP2zQA8abOVLcUzh0ZO9bw9dshQlZTlyP1xYHnOgNZpvIDU84ft3Pupw79HOaeyCIX5wIKyyb5jJTVheTYFvxIoSVwrDWzQEP3Qf5iSCqCTUr38gG8gwi5BelPUMAC9W5qjRMJV6B8Eds6LSvgoSlMMCqiS1ZA==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by KL1PR0401MB6611.apcprd04.prod.outlook.com (2603:1096:820:b9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 03:18:54 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 03:18:54 +0000
Message-ID:
 <SE3PR04MB8922E330EAB67C859D9AC7F8F38D2@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Mon, 28 Sep 2026 11:18:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/16] irqchip/riscv-imsic: Support IOMMU MSI address
 lists
To: Andrew Jones <andrew.jones@oss.qualcomm.com>,
 linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
 tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
 anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com,
 fangyu.yu@linux.alibaba.com
References: <20260925151659.419512-1-andrew.jones@oss.qualcomm.com>
 <20260925151659.419512-12-andrew.jones@oss.qualcomm.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260925151659.419512-12-andrew.jones@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0028.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::17) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID:
 <aa744aab-4e23-4f45-84d9-c5d44661e5db@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|KL1PR0401MB6611:EE_
X-MS-Office365-Filtering-Correlation-Id: 55d6f092-e8b2-468d-0fe7-08df1d0f3a11
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|55001999006|19101099003|16051099003|41001999006|25010399006|4140399003|23021999003|22091999003|24121999003|15080799012|5072599009|19110799012|6090799003|8060799015|51005399006|40105399003|12091999003|2607281247196008|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1V2d3ZocmZPY29GakFlNkFacENhQUR5ZWdUYlNRZkliSVlEaURXL092RDAw?=
 =?utf-8?B?VlIrTGthUUdFNytvWk5wMUdXRncxczQ4eDJCYTZuNi9Cd1RRVC80NzNjQk5K?=
 =?utf-8?B?MitCSDFzY3RDQktmVFdiSVlCSXozSXRLSmwzOXBvWWkwNEE0MWZsZzhCMG9L?=
 =?utf-8?B?WUdFcmVSWDNvMGF5d2JVQmlkZ0hCM3pVbW1SRy9qKzR2VVVLUTM4MXlEYkJG?=
 =?utf-8?B?ZFk0ZldVMWQrN0x2RmxWdGlPNlFHUTRtbUIzWVZrMTVUTDMyR1MrSDlzeDZs?=
 =?utf-8?B?VEwvanArV2RVNmlzNXdGZEo4Y3l1SjRWaVVGVVQ1TzAwQkpVWk1LMFAxNHQr?=
 =?utf-8?B?dWtKa3Z3enFKLzJwM1I1bng0NWtwcEJOWkxGcVJpWStDcWJ2VkdCSTJyQmxR?=
 =?utf-8?B?dHIrVTZNcVU0UENqVnJzOGJNcW5YREN5bDJnL1dOU1h2UlRPMTJrcUN1QzhZ?=
 =?utf-8?B?UXV1QnJDQ2VLTFJVaUlKRXo1NkUwUFpFM0U5azVDVVdnOGdLYkpZK1AzSmFx?=
 =?utf-8?B?VzBPOUN4Uit3REU2MnBvUnluNHhqN1hZSDNqa2ZyeWNxYmtGd2JXWHV2ZkdO?=
 =?utf-8?B?RHluS0Z5bWFCaXJxZmM1VjJQNThKVjNPakorbXpzMVYybVZYemxIaGFDRzRq?=
 =?utf-8?B?Wmk2eUlKaVMrRWoxNUk4dXVCeU5wdEdjaERDUG5tVk1XK3lRUmdWYUlQTXZ6?=
 =?utf-8?B?RWtaWGJuNlp3THZWWVVNczhCcEUwTGZYWDBoT0xKTWtJSzl4RHlvd1AzSHh5?=
 =?utf-8?B?bk40SWJPZnRka1Vhd0dLVHhPTGxqUEs3Uk9MSU1heUs2V3Rzc0c4bVV3b0RQ?=
 =?utf-8?B?YmtEODJyNnY3MDFSRFhaTUlzQjBYM1Vldy92Y3ZFYldDWkFlaXZsczNkdmVz?=
 =?utf-8?B?RGdMZlFEWnpNMnJ1OG0zcWszL1dPYmM5R2FRY0VuYjZqYkdLclRHVUo1M2NV?=
 =?utf-8?B?MWRZY0J6emdIN1NYVlBZZ2tUbHJoMXlzQyt3Sk90Ylhob3g0VHQveGdHdE9T?=
 =?utf-8?B?VDE0dWlqSmpJOWFNbVdnWlEwVHprK2FpM2pVK2s3UTJxVkdyRDk5Y0ZxTjZz?=
 =?utf-8?B?ZXdpQlJaQlEzbWljRmVSV2IzV2h3TzRxMGNxVjNaZDFEZ0ZPdGlQcVBBNTVo?=
 =?utf-8?B?bGpMOW9tUWJEM2crdFk4T3dsczJvT2Mzb0ZMS0pFbFE0OWk1WGFMV2tDZHZF?=
 =?utf-8?B?cUFxYmUrbXZhQ29QcEZUcngxdW00L09HOHY1SWdWYVpBZXJyOThNOUF0N3lR?=
 =?utf-8?B?ZUNBWmhGZk9QaUtHdzB2bmh4RUJtNXoxNmhYUlRld01MdmdCMVUxQnZ4KzNm?=
 =?utf-8?B?K2V2Y2l2emFraHJIekhrUVowbmJNbEhwbTlsUjNMSjZjV1cyd0M4U1dzNnZ2?=
 =?utf-8?B?WmtVZkZNSGlGVGpKUlR6VzVpS2YrTE9jTUdPRXlsSXV6NTlIM21CR1VxMVdT?=
 =?utf-8?B?UEpSMjN6b0FRQUhaSFZENklWR2ZoSk53NURtVzgwbE9ONmpzekxxTmhSYjJU?=
 =?utf-8?B?RGZSUzFCTlljNnJjaW5sajBkNXNKM3lsQ29ERURjclVmRC9FUE9SVlFYS013?=
 =?utf-8?B?VkRnQT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnVyZGtmVnFRYlI2eXl2K210NXlOUFJpdVZ1Ynl0K1hMYUtzTk1Icm9ZbkV3?=
 =?utf-8?B?dFprWUIxSFBOeHpvVG01TG82K2NsMkNQTzh0QU9yVWVlT1dDczJ6N2NUbitr?=
 =?utf-8?B?ZGpVeTdJWjl4NXIzbjdpUEptOFMzVVdQQ1pZYTBhcWJKR3VFT2NPTGVjbXNx?=
 =?utf-8?B?NlRRc2tNV093VVIvNTdUbDIzSk9YYXpsa1N2YjZRVW1JcjlMbmtLM2RBWi8x?=
 =?utf-8?B?eUdrdE9MYVlyQWhmSytRMkYzRERZYVRrQldQUnh3bjNRZHVjdnB0Tkt0UjZw?=
 =?utf-8?B?ZTFJK2REVUpMRWIyNzBjMWwwOTBsY2lab0JnUUo0N0w2QWNDZS9vc1FsYkMr?=
 =?utf-8?B?alhEYXdVMElkY0E1TVNZM3c3QUl1R0c0WGdQc3VsRkNDc2llS2VrN0FqKzlw?=
 =?utf-8?B?c0hxYmNmSDBVV2d6ZmxMZWNXRWgzNG9mcUJzNlFPRGFpSUpUblAxZlN2NHY3?=
 =?utf-8?B?Vll3TUZCNjFWclNhakJ6V1hLY2c5TXlyK1dmOGRTSXNtOHFYV1B0TEd4MlNu?=
 =?utf-8?B?NHdBN2hRUHBGQldUaldlZXJjbCtFTlZPNHpjYTE5dHNUV2tiOFVPSks5VHVs?=
 =?utf-8?B?dHU3WlBTRVJkY0ZWWEVxMFd3K3l5VlB5TnN5V2l0WEhNNU1jL1VHR3lKZWdZ?=
 =?utf-8?B?WWlxejdTNFY4UlRTUmVRclNHZ0F3MGZ2OVdDK08ydHVwSDl1VkE3dGNtRzEy?=
 =?utf-8?B?dXZOMG9TOWd0T3FVK3hCMFJMT3dZSlhJTjJxTW5OeFBCR1pXQSt6Y3QvMVM2?=
 =?utf-8?B?akl2eTU4cXI1YWMxMWxtRlFXdDJ5cUdBZi9lOUUrNHA0RzBrN3h3Wi9KREQ1?=
 =?utf-8?B?d0w4M1NXOUtET3JOUFhvM2FJanZXQTVWTFBtdWIvKzFBWHdHTzEwSzVLTmJD?=
 =?utf-8?B?U05jSk9LOXROOFM4Q1c5T04zYTBqbXZXSFlJdTJFQ2pFTGpTbm5KUE1IRUc0?=
 =?utf-8?B?d0NtcjVNbndZMUdrZE9NZzdscWl2d2ZRL1VWOWVNcDR1dXNFTkhPY3Y0ZG5x?=
 =?utf-8?B?Mll5a0NpZUdkWmhUeERTSFh6L2JQMmJSV3lHY3BlWmtOOHBSV2dCU2RFbjhN?=
 =?utf-8?B?RXp3Rm5NQllzd2VhZXZpeFh1MUlpZytKcVE1dVUyZG9XamtSb2J5QU5qaG5M?=
 =?utf-8?B?WDh2NGZLSlU3U0ZmVkJKNmx4UDdSaXJZbndtenFEVDJackJHU2NqZzFFSmNt?=
 =?utf-8?B?NjY1UkE1VjNOcnFtc1c5ZVlhNEN6dHVkc0ZxdmhscFlSQ3VISE1GcGRpVzBN?=
 =?utf-8?B?UzkzNk5MNVZRZHcvQzhQSUdzKys1Tk5ZZ2NndXhoU25sSm5ZVzhXZ2lKN1hZ?=
 =?utf-8?B?SmpJOUVsYTVUd1BNeU04UHRxZi96TWN0YzVpaTRWQnE3VlFraTJqamo2aXVG?=
 =?utf-8?B?QkFyeXNxWXEwRllkVDhNRHhxd2VVR21lZHpzSmd5S1MxZGFBY29pSEJibE5h?=
 =?utf-8?B?WGVkdjc3R1czT0RNSFlVd215SlZKVDZpQjR0UHFqMTBMU3hkTW9zSkV5WGJy?=
 =?utf-8?B?dEcyM0xZaFdYOU9WOG5NUDhUY1lWc2xqMVk3dDdkRFR2U2p0VmVMOUxRMUU2?=
 =?utf-8?B?a01CdEhZUmt6dHpFMDk2Rm55b0UwQ2J2RFgzOWpRRzZvTDNXNlJZcEo4b09D?=
 =?utf-8?B?eldTYjJTWUlUWlVkQXJOR1NEcWxrUlpDclVSMGx4dXFDM3FEZm9OZU0vMDVi?=
 =?utf-8?B?a1lvZzloTnQzVFM5YndkQ1RVbTF0NDFSMzVmRVF3YUkzNWpaOEV4Q3NGam5U?=
 =?utf-8?B?NThuNG0xNmxKTFEzWUxtZE4xL01pVWYzTm10MDhLeW1qUHd2Qk9ES3BuSjA5?=
 =?utf-8?B?K1UzMXBraGhaYzdqMEZVYk1UZGptSXRzeXQzcm5pY3JlQWY4TldQMnM1MjZI?=
 =?utf-8?Q?Pg0O9owa7UwWU?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d6f092-e8b2-468d-0fe7-08df1d0f3a11
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 03:18:54.8561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB6611


On 9/25/2026 11:16 PM, Andrew Jones wrote:
> RISC-V IOMMU host interrupt remapping maps every possible host IMSIC
> target into one contiguous IOVA range. MSI message composition therefore
> needs each target's position within that range.
>
> Prepare the complete IMSIC address list while allocating an IRQ. The
> list is guaranteed to exist after IMSIC state initialization. The IOMMU
> backend maps the pages and caches the contiguous base IOVA in the MSI
> descriptor when translation is needed.
>
> When the descriptor has an IOMMU MSI mapping, use the selected logical
> CPU directly as the page index within the IOVA range. Use the same path
> for initial composition and affinity updates. A zero iommu_msi_shift
> means no MSI address translation is required, so keep physical messages.
>
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   drivers/irqchip/Kconfig                    |  1 +
>   drivers/irqchip/irq-riscv-imsic-platform.c | 24 +++++++++++++++++++---
>   2 files changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 20b77fbc51ee..a038e1121be3 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -651,6 +651,7 @@ config RISCV_IMSIC
>   	select IRQ_DOMAIN_HIERARCHY
>   	select GENERIC_IRQ_MATRIX_ALLOCATOR
>   	select GENERIC_MSI_IRQ
> +	select IRQ_MSI_IOMMU
>   	select IRQ_MSI_LIB
>   
>   config RISCV_RPMI_SYSMSI
> diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
> index 643c8e459611..ddb2bb570cdc 100644
> --- a/drivers/irqchip/irq-riscv-imsic-platform.c
> +++ b/drivers/irqchip/irq-riscv-imsic-platform.c
> @@ -10,6 +10,7 @@
>   #include <linux/cpu.h>
>   #include <linux/interrupt.h>
>   #include <linux/io.h>
> +#include <linux/iommu.h>
>   #include <linux/irq.h>
>   #include <linux/irqchip.h>
>   #include <linux/irqdomain.h>
> @@ -69,8 +70,10 @@ static void imsic_irq_ack(struct irq_data *d)
>   	irq_move_irq(d);
>   }
>   
> -static void imsic_irq_compose_vector_msg(struct imsic_vector *vec, struct msi_msg *msg)
> +static void imsic_irq_compose_vector_msg(struct irq_data *d, struct imsic_vector *vec,
> +					 struct msi_msg *msg)
>   {
> +	struct msi_desc *desc = irq_data_get_msi_desc(d);
>   	phys_addr_t msi_addr;
>   
>   	if (WARN_ON(!vec))
> @@ -79,6 +82,12 @@ static void imsic_irq_compose_vector_msg(struct imsic_vector *vec, struct msi_ms
>   	if (WARN_ON(!imsic_cpu_page_phys(vec->cpu, 0, &msi_addr)))
>   		return;
>   
> +	/* A zero shift means no IOMMU MSI mapping is needed. */
> +	if (desc->iommu_msi_shift) {
> +		msi_addr = (desc->iommu_msi_iova << desc->iommu_msi_shift) +
> +			   vec->cpu * IMSIC_MMIO_PAGE_SZ;
> +	}
> +
>   	msg->address_hi = upper_32_bits(msi_addr);
>   	msg->address_lo = lower_32_bits(msi_addr);
>   	msg->data = vec->local_id;
> @@ -86,7 +95,7 @@ static void imsic_irq_compose_vector_msg(struct imsic_vector *vec, struct msi_ms
>   
>   static void imsic_irq_compose_msg(struct irq_data *d, struct msi_msg *msg)
>   {
> -	imsic_irq_compose_vector_msg(irq_data_get_irq_chip_data(d), msg);
> +	imsic_irq_compose_vector_msg(d, irq_data_get_irq_chip_data(d), msg);
>   }
>   
>   #ifdef CONFIG_SMP
> @@ -94,7 +103,7 @@ static void imsic_msi_update_msg(struct irq_data *d, struct imsic_vector *vec)
>   {
>   	struct msi_msg msg = { };
>   
> -	imsic_irq_compose_vector_msg(vec, &msg);
> +	imsic_irq_compose_vector_msg(d, vec, &msg);
>   	irq_data_get_irq_chip(d)->irq_write_msi_msg(d, &msg);
>   }
>   
> @@ -225,7 +234,9 @@ static struct irq_chip imsic_irq_base_chip = {
>   static int imsic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>   				  unsigned int nr_irqs, void *args)
>   {
> +	msi_alloc_info_t *info = args;
>   	struct imsic_vector *vec;
> +	int ret;
>   
>   	/* Multi-MSI is not supported yet. */
>   	if (nr_irqs > 1)
> @@ -235,6 +246,13 @@ static int imsic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>   	if (!vec)
>   		return -ENOSPC;
>   
> +	ret = iommu_dma_prepare_msi_list(info->desc, imsic->msi_pa_list,
> +					 num_possible_cpus(), IMSIC_MMIO_PAGE_SZ);
> +	if (ret) {
> +		imsic_vector_free(vec);
> +		return ret;
> +	}
> +
>   	irq_domain_set_info(domain, virq, virq, &imsic_irq_base_chip, vec,
>   			    handle_edge_irq, NULL, NULL);
>   	irq_set_noprobe(virq);
