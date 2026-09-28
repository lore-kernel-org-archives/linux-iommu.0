Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012055.outbound.protection.outlook.com [52.103.66.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B51F3783AD
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 03:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790565490; cv=fail; b=HCgUFUHlmMnkNh4TI7bdH6GitEOoD/onzTRJBeskQARz9u65KKkw+FpH/PBO/37lR06mG9j95+XSlSxPzvg8NWfYK9CaulFQnpEQzPGvbgFJFajH3a/IXM6uOftoCQhBajjk6nH+7II/XcD/maYC2yKbHVwZoQ3oSk9SewbNc6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790565490; c=relaxed/simple;
	bh=mhbU0ys/hz0FdNcz80r9w0xKg5F/0/gJhxfsaOMrFrk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XTH6X7xdTnKv+6gc8uy2bAGw3GXCRC75EYu1Vezrf9p3eIZ6kSNpWgQzbicx4GzRQByfmRxEefoH7IbmILnE4tzt+XJRLhfWNJqA2SaY6QGFoJUrFndJMUqxcaWpTwhtCBVzzyQUcBwNL5GP6vo7c4Mico4DlOIwXDRwGsJIHa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=N2tP5qI6; arc=fail smtp.client-ip=52.103.66.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="N2tP5qI6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MERBpGGA1bucOA/RRuZuuMkW9Qs4icQYbRstJIq4qUBPQdZ59cMqWzTEoDyFSIByoGvE0B2U1T2OLhqvD4TO6N1o2MMeaXTn+izm+yhanj3DGzG/3Qsi2T3B8xXU50VWH7OwJ3Gk/uTK6W+iOV9nrlzK/9yQ9x7moHEg2y7MmhyWWiOlTTlbnGJTFAN3r07jgYGauYmbUg2SdvSdI3lAgR3vcxOsOmRqo2FxfJeATK0KjJGb7FN2I6/z1yAcPG9WJz0/P+FJte/GxW3A2G9S6yQlGv4pIDlA0dxfSTgmUMpPL3fmywayw6sxX4AKuC05ZmiRVIhwH+C/+sl8jI8fDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3KamL3CbmqnmogWZyRR6oI5uXvraO7OfqEL76IKwwQ=;
 b=G5eEVhNr/BKJIJCZA/df7P668XtU+9KSgAqYsoKk5AkoH17x2qQb0QppM+P80iAFW5M2SVqeIZHslm3ppRLsCAAlbPS5bCRTtdRKFnHO0GpABfx5DkHLx97UAqVdwpUq6Dq1wGK8b5CWhfOgGwZzZINsl6uWa7s+7GIUBeQoyOcPTYmB1IiXpPzYljbNnuyzttsIe1G9i4gqGs8yt1NzLFmIqu1xjyUzg/2RQZaOv1vnsB/pzkUYq/mUtf8BbsJx5BiDO8eTDGRsPma0OXHMIH7uX0iue2vG2DBKZu8uAM5vFfsHfC7ZlGd/N6BPXGTr21uhZGFrzl1+yN4ROIPSvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3KamL3CbmqnmogWZyRR6oI5uXvraO7OfqEL76IKwwQ=;
 b=N2tP5qI6dSWnhFTHvBWmdLyIHgjJ2hYV5ccc/tNTl91MCbp5mhDlZQXF+nN5EO7BQvIChlP+xBr+JipzJJk4pQOQhrLv2YNwbV5s4JwHuEKlxusiwOmfIwnurI0wo7C53ROw3LEaNQWh4DLpT563uKQiLq3uLrKcwjADhsRZsiGyIA1dB9UlnVw7Qvrt2i1q/iWaUoynSOj5gfvDtwyFtW/BXPhFuqcgQ7y+uqqyyiXDqRNL/5updRv/zz9OffoXyjVR50Otltk8Fcg82rQtCLpYJU0L0SJU0xYkhY0r983lyhojqgLZtx3PpfGCIgIy+Ao1mmUK2TJBH7IZbwC/Og==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by KL1PR04MB7553.apcprd04.prod.outlook.com (2603:1096:820:123::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 03:17:58 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 03:17:57 +0000
Message-ID:
 <SE3PR04MB8922EC70F03E7D5C6BA57C0AF38D2@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Mon, 28 Sep 2026 11:17:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/16] iommu/dma: Enable IOMMU_DMA for 64-bit RISC-V
To: Andrew Jones <andrew.jones@oss.qualcomm.com>,
 linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
 tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
 anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com,
 fangyu.yu@linux.alibaba.com
References: <20260925151659.419512-1-andrew.jones@oss.qualcomm.com>
 <20260925151659.419512-13-andrew.jones@oss.qualcomm.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260925151659.419512-13-andrew.jones@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0023.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:a::7)
 To SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID:
 <7d0436af-f8b5-49fe-93a9-02cc9d6320c6@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|KL1PR04MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b35973-fc11-4e00-4e86-08df1d0f17a6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|8060799015|19101099003|25010399006|22091999003|4140399003|51005399006|24121999003|55001999006|15080799012|23021999003|6090799003|5072599009|40105399003|2607281247196008|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0lHVEhxY3QxRG8vT1RZTEV3cFRVbHRCTzVqZ2Jkc1dOVWp1L2t6WmFXZmxn?=
 =?utf-8?B?TitBaXorM1plVjdnUEtxRjJrV25VS2tlcStNc0lGS2xzWTZIREJLWHJqSXVX?=
 =?utf-8?B?ZlkzY2ZzUlNoT0pyMUtCVG5mai9heThpMlcxS1IyVW95empYNi9IN0ZzYVhi?=
 =?utf-8?B?SzIrTWtnQjVjQzZXM0NWUnRVcWVmcHRSdlJCOC9NNnRvdEFaQzg4SzRTeHVu?=
 =?utf-8?B?SVNoTjQvU25uRFZXUXI1enFIR0w2ZmZOK2ZHNmx6QVdoNlN3ZDJPak5PSEJv?=
 =?utf-8?B?N0VFaWJDVktjblVlWTA2b2ZmQmxyOFlTT1hoYVZCZWI3Q1NZVExZYURIQVl6?=
 =?utf-8?B?Y2djTXF6WlVJbnR2S2RGNC9VZnNwdHBTT1ZxZE15NUZ2dys5ZW42K0VNbFJS?=
 =?utf-8?B?UXBhTGRiN2VncDBROC9RQlRkUnZJK1IySWdtREVhNGhRNjZTbnpUTCs2amlQ?=
 =?utf-8?B?UjBtQ25wbW9idGoyaEtvQ1RHYTV1OFQzeGpIc3E4dkg3VUY1eDJBZm9HeTky?=
 =?utf-8?B?cm9GUThzTXBXM3lmT0d4V0ZmWnBudHhnMlJJZm1DN0gvZlh6a1ljeU9Ubm4z?=
 =?utf-8?B?T2VHckRocXYwZUR1RmtmdkhtNDBtZFNmZW9KWUZSSFl3UytlYjY3WThld3Uw?=
 =?utf-8?B?R2xDMFF0MlViS0w2bllFYVRjdHJjZUM2RzJuRk5vL0xtUVp5V2VQUGx4dE9t?=
 =?utf-8?B?dmh3VDQ1Y3Z3SDVWa2wyeUdZWjJwS1VhUDN1WTBNU05xVVU2NW9yM1dhRzQ4?=
 =?utf-8?B?K0JIT2diaWlWWUZwaWsxSWNtc050SENoTVN0V3RxSkZmZXFwa1BBNGRBbVFh?=
 =?utf-8?B?M2FzZDJicTlvd3k4NndKUzBNNGhYbUF2TVFsNWZTT0VoVjUyNTZXaXJlMzZi?=
 =?utf-8?B?OGJnRVQveFE2VmlNcUE4eXJqU1dZK2JTSDE1a1B2R0lXeGdWSG5Xa3d6MGVq?=
 =?utf-8?B?enp2MjhiMFk1Tll5ejQrRENhRHJoeGMvRi9OVEFIc1g2YW83THRucFdraExQ?=
 =?utf-8?B?Z1lRb1ZKdFd4T2g3aFh4NG5zTndTNVFvaGphbnQrcHI5bmpqUWx2cUFrT1JP?=
 =?utf-8?B?WVFTby9La3A0aHRLSU1aN0lLdGNpZDhnbjY2N1ZTSS9jaStaRFdHV1VFK1FR?=
 =?utf-8?B?aGJOcGEzNnJYeUNQQ1NVQ210Nk9GOFNTVmFZc24vZGtuMWFFNTVaNENMSEpQ?=
 =?utf-8?B?Y2FuUmJBV0s4Q1pOWmlMakh6c1o0T3pFVnZXVWZuZ1lzMEJzQ3luVEpiUVk0?=
 =?utf-8?B?citVQkgvRGNsbHkraUdnR2RKclZBOWprMXF2ZnRTT1QvaGUydi96Nkd2MXBN?=
 =?utf-8?B?QXpUdUl1OEdVdWF1N1FnOGJlemhzb1lKWHJFRVBxR0lYMW1wb05ZTEdMU3dy?=
 =?utf-8?B?anRGdm95U3M3UlJMd28zVXIyQ2dnKzN2aSt1OXlNanZzTkxHMGtFb0dvZkgw?=
 =?utf-8?Q?9ycqxYfJ?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3JZSjd6bVcvT0FWRk80dDU2WmZPV3VSWEFwT3hES3I1L1VPWkk3N3RGTUox?=
 =?utf-8?B?bkt1a0h1NEo3U2djZjV5dEhuTkNmd0phYktzcDNwSFQxNlNnSHY2UzJjVGo1?=
 =?utf-8?B?UlN6dHplTmJrZCtxbFc3dnVUVGQ0NjMxcE5CRkpvR2d4VlZiVW8rUURBWkRL?=
 =?utf-8?B?Wjl1SmFMQ1UzNVFWWDFxWUNPb2VOamxpWjVxMXMzVldCZ1k3VVR2SmQwRHcz?=
 =?utf-8?B?VTA2dC9wbjkzRVZuQUxoT1RRaWRwZlhtVUJWdy9Xa1pET0o5ZC9MRDJjM3dl?=
 =?utf-8?B?a3VoRk5VajhtTmZRZXNlTzA5dVRrWWIyMXpQSGl5R0wxR0RwcmpPem5WMCty?=
 =?utf-8?B?VG9YOE1hMnJCTHhPVDFkTnVDK2RSZVZhTG80dlR5RTdPRTM4MGZBQzhiQmNJ?=
 =?utf-8?B?WnRjWk5OTEVDOFEzemVTMDkxa1lrRzE1MnhyR1JFNnJ6Vm9EclBUWGZUZWkz?=
 =?utf-8?B?K1RGaEg4YWcwU0w5TDJVRXlVMXFvRmd1RW0wcEdKcnYwbjJaUU5aQnlDOC8w?=
 =?utf-8?B?N3BSSzYxTlNQUng2TkZEdTAwazJZMmpyUDh5ZWZwOUlHRHZHTHY1eTZZYmNW?=
 =?utf-8?B?MExVWUtMRmNqMVR5WEQveE9nempMQUlZYWtVNmxPMG4xU1dzZm5yRU5lelpE?=
 =?utf-8?B?VTJCdFJjZVlxZEs3VitpUGdxemZ0YUVhMzl2bE9nZStHdXdhZVAxT2cxcVQr?=
 =?utf-8?B?a0VGMUw4aDIyUnZ6Szlxd3FwZWxXQ2RnWko4emZ3TDliMXVEVmV3UEdicEVQ?=
 =?utf-8?B?RW4zdmVpSGxuYnBWbmVENDNUR1hWU3lLbWV6dXFDK09GZnR3OU1UbmJpaU03?=
 =?utf-8?B?RHhRWUo1eE5wclpSbWV4dk1GWFROVENLVXhzWm1nOEV6S0MwaGZkdjJCeGUw?=
 =?utf-8?B?bmRVT2JLcGNQb1Fib0ZhamcxWXN6aGZHMnpaTG8xUWJaeDJiMm12djN4Rngv?=
 =?utf-8?B?TDZFZmpEbHBNZEdwcElYUUxPakJtY28wTWR1TVZEdUMwczRUQWlIN1FuSDZi?=
 =?utf-8?B?U2lIelVlMjV1K1M4VFd3NTYycDNXcFlqMEE1NTB1L3o5Q3RrL0NkQzFSc0pW?=
 =?utf-8?B?aFFrVHJPZGVhNWZqTjZQQ0FGaDluTnlKV0FnL3hlK1NsekZFNlRPTWUxdTR4?=
 =?utf-8?B?K2ZxUytzR0liWnZGakNMbTNORmQxUHNJUlgwTG50VGVhNG1lZG1KcHQyTGtL?=
 =?utf-8?B?RENEd1F3MjYxWm5kUnJUMi81RHFSL1JHb1F5RXZ6ZUp5SXoyS0ZDYmhkemwx?=
 =?utf-8?B?dDdHZ0E2NE85MGRGUEhsWDdCTjlseTBlY2NFckxBUHJ0V05EUVd2eHZ6ZWo2?=
 =?utf-8?B?eEZPN2ZqQ0UxdUZXTDJPVVVqS216TG1NNmdKeG1KUHBleGRKbUF3ZlkyYWNI?=
 =?utf-8?B?Q1JCLzd4WU9zbVdZVmJmVklDZ29tNFVzcG9SV3ZuQzdIUUpEYmpnclBkV1Rk?=
 =?utf-8?B?NWg1dTB5WkozZm5vaER6MHVsaFJnQjdHUUE1NDZqcTVzdEpjUjNraU5Zdld2?=
 =?utf-8?B?d0VoZGlDNVBObnBtZjAzbDNJQWxsRWhxWkthcHc2NXNidlhIbDJTSFRTODhy?=
 =?utf-8?B?MnRiK3F0VXVXVW1hKzVZbXZaVEJ3REFGM2cxeEZhNktOWUdnbExEM1Y0cGk5?=
 =?utf-8?B?VEErd3NVSjB4U3dhYjJuTmRHc3hkYmRLSFg2eG5DWGNCSnpaZ3dUZTVEekFR?=
 =?utf-8?B?L3o3OWcwMlZpVGczdTg5cUlCcnVyL2NuVkxkTWJQTmU4M2FPdlRsQ045OVpH?=
 =?utf-8?B?ZnBmamRqY2lycER5b2FQU1k5Sjd5VFA3bWFQQjh6eFZtcmt6ZTJpanBFaWxv?=
 =?utf-8?B?WWs0RzZoUjY1YStzdllYK0tGcXVweVRFUUpuV1lJcmhWZE1OK0dUQnJRTnRC?=
 =?utf-8?Q?zHTNHqQr/YGhj?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b35973-fc11-4e00-4e86-08df1d0f17a6
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 03:17:57.2494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7553


On 9/25/2026 11:16 PM, Andrew Jones wrote:
> From: Tomasz Jeznach <tomasz.jeznach@linux.dev>
>
> Enable IOMMU_DMA for 64-bit RISC-V now that the RISC-V
> IOMMU driver supports MSI remapping.
>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   drivers/iommu/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 27954f462582..2d38d5b5accd 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -151,7 +151,7 @@ config OF_IOMMU
>   
>   # IOMMU-agnostic DMA-mapping layer
>   config IOMMU_DMA
> -	def_bool ARM64 || X86 || S390
> +	def_bool ARM64 || X86 || S390 || (RISCV && 64BIT)
>   	select DMA_OPS_HELPERS
>   	select IOMMU_API
>   	select IOMMU_IOVA
