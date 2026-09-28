Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012058.outbound.protection.outlook.com [52.103.66.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07878376A1A
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 03:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790566044; cv=fail; b=P6yixuWE5wmNdIZ0oPIsZOVp9VKRVQAQuNN82xngDutX8sTcIEqzcjlDcR1KVTS2gj/O0h300fudyi8rH2LejjWB0cjlKT2iuj50TV04xdmPQ8z7IsDzvVMMsUlbTibv3jC6PsNi8CJVjVaPpZx7XD8Y2XAO5oH2G3McqdiPiQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790566044; c=relaxed/simple;
	bh=N7VsMGNL1Yr4fN7WgQFdAA1BBYUMW+xKO+H6RCpE28g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fZ5GdmLCdZ1Khvo+YvGQNnHGvmT3cPgY2eD4wKxqWE1H/QRtk5BlOVgpWh4Z3pf2ZLlXIoTBCwryNV+VjQNWgc6voYuIeEY+qdjXd/MrIMuD3fzvBJXhuDmwNPMF6i1ZNHWR6NY6y0lm1KNYws++rFfwt/sh1AVl9YtafNaQFS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Z2rcfnT9; arc=fail smtp.client-ip=52.103.66.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Z2rcfnT9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sSKmuglKRh+S+nfem49Oo++ycRgAZxIj+ZAlU9m1bOiUlpQEHttM8PWSApnG+UZ1jzKz9fbpQgP+GZc5PwomUX59reg/1twbCvQmFLBSAK4poMZ/gXCvy6SS5AXLf6GQWC70jDpqMKWWLqkczkhNx7LNEcBpnbp705F3kQJ2lZjhL+BfR54wrP7nX4iBetA6ftRivmRC3TVu35dBGO/+0AYnDWFZy3+ZhvA6AX/ACYvRA5Fn6tecwNG1cYMDkc38ITlikBt5152beBaF6KHDy9j0g+n7/Qu93uC/1G+wBQq8rf1WBwHKo+JXBze31YPsLwxqBzDeSpwULLptC6eEgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoseFYjIi8BX1PA2m1hJy94hjfNc7RYevB7/KmgNiNg=;
 b=uDMYs1Dtkp2p+oNzjJlGBuIQ96eV+00xQ9/tJEINvPrkRRVOL7KZ3/A9mxtHHc2wGjRfLQTTVHXs7kTiTzWpi6pCszkM1gXko+LDLCjZ12N/ZrcmmyKBv+xYUsnHJibm+YKK60iKUIsBv7eQX8vwWkFrwMEyZcUADQWE24gHw9QUB/BX+nxxQX0YHdl1Zy8PnwkXQCGRAYXfGViDQ0dSsXO748UtoOFvkrFfeCRpJSTTKOdv+eelgJzO3ktgP4gyhVAIk50dz5DHml7U6hqAdqfh4edPnJ0qzMTGEAPw6CKsGLXlodv5ZLX/C38CxHkhpyRpQ/Q9Eqp0rGkTMK8nXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoseFYjIi8BX1PA2m1hJy94hjfNc7RYevB7/KmgNiNg=;
 b=Z2rcfnT9buoM5XVSDfi1+Y/qMqBCHNYtJhWToFfsUKvBaHZm4iKhFr42kYFgVeBBXj9j9c0229mQHG/ytiQncj8SnWULwqBTdbyAJsKMMJB9W0UWjPMkbA7h0mTm93UjT/K+1mfea1MXUV1nvshne0R6hfpiV+rIF+MbqQpVGaeVxjG/3nY7aariY24bf1E6VFAryVTzD490pEE11YS7LMEIVWQXVTybzaI2kJeq40LEeFEIJ8C+9yicCRvsxJsyDkfnj4Afhhlqyw4304LEaljlTM0jmrsSiZd4TTqnL2nacnyNfztMDt5jFYw9qsj0p9rlGqMvw8ewCnVvjb2MwQ==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by TYZPR04MB7100.apcprd04.prod.outlook.com (2603:1096:400:45f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 03:27:12 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 03:27:12 +0000
Message-ID:
 <SE3PR04MB89221E41244375A0EFA2A7F8F38D2@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Mon, 28 Sep 2026 11:27:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/16] irqchip/riscv-imsic: Add MSI address list
To: Andrew Jones <andrew.jones@oss.qualcomm.com>,
 linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
 tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
 anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com,
 fangyu.yu@linux.alibaba.com
References: <20260925151659.419512-1-andrew.jones@oss.qualcomm.com>
 <20260925151659.419512-11-andrew.jones@oss.qualcomm.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260925151659.419512-11-andrew.jones@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0024.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::13) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID:
 <4b40670e-280c-4caa-b474-3ffc673cd115@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|TYZPR04MB7100:EE_
X-MS-Office365-Filtering-Correlation-Id: 1caf01d9-0895-4fe7-c48c-08df1d10627d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24121999003|23021999003|25010399006|22091999003|4140399003|51005399006|19110799012|8060799015|6090799003|5072599009|19101099003|55001999006|16051099003|41001999006|15080799012|40105399003|12091999003|2607281247196008|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnVkQjIwZWJKV2huUXorWjNJN0oyMzczc2hxSmlVcDlQOG9yMFVOSlkrRlhV?=
 =?utf-8?B?MVQzSzVCa0VyWjF1ZHZhL21COUNqN1RpbEJXNldTZkR2ZlMwdS9qV0x0eWZU?=
 =?utf-8?B?aDV4UGFkcGdTdFBOTk9ZNFFzR1Q4LzBZYWNSTmhPYzdOMEJuejNMd3F1WWxX?=
 =?utf-8?B?emYwVnhIUm44L3NLQVVSWWdRcThkRFh5bEhhRiswVkU4OWhqT1FSRDU4NUdo?=
 =?utf-8?B?QU00TnlPakh0Z3ZscXQyeEhGNDZQZnpwZWFpK0xRRERwTTJ1cDhrNVdnUU9K?=
 =?utf-8?B?Y204bHlXdnNFNHFOMU9sNmZXQUdVcXJtSC9SVlpzbVlWOFEwbW9ucGQ2azJL?=
 =?utf-8?B?WE43eDZUbWZLUUFycm53aW40Yjc3a3Y1L3phWVhyckl2c3hROEl6VFkzUnlk?=
 =?utf-8?B?NDRlRmZQRWk5VzdEZ3lpTjVaUnd6dG0wVlhTU0ZvR0o2TWF4NHRnRU1BZHN4?=
 =?utf-8?B?WjVoQ1h2dmRHTm1OeHlKU1pVQUZYdUZvUUFjczFZUGdWNCtmUkcrZlVzUU9V?=
 =?utf-8?B?VlQ3SGY0REZMRXVZY0l3SlBsbXlwS2hFOEJOS2Y3bVBYNVdHS1M0SVluQzFi?=
 =?utf-8?B?N0htZFpqY3kzQ24vRUxkWWwyWmZKWHdranorOEIzWWJXdzlsNkdyeUNES2lC?=
 =?utf-8?B?ZVNoNThsSGN1dkREa2RpSXc3YTVIVjlSd3pnRG4xNklsdmxoUU9yYndIM3Q4?=
 =?utf-8?B?OE9GdUxPblZ5RHNrR2M5RUllQjRrTjZkLzIzNkt4NVIvTXBDbW9uVDVrdmtW?=
 =?utf-8?B?bnBnMDR6RVZ1QWxLMStOTXVQd2h2Zm9MdURsNitUR2ZxV3NhNjFkQ1piVGk4?=
 =?utf-8?B?MFpVQnhMT25CN3pFTjB6WUtLcGJwQlpod05CZUwrckRMWFR3bzdjQkl3Q0V2?=
 =?utf-8?B?RzBnUzhSY1Ayc3ZDM0JNbDBJaTV2ZXpBUzV1a3JTR1dvREtYL09ZN1JMazhQ?=
 =?utf-8?B?Q2VPcEdGR2FCYnE3Tm1kamhqTTVKTlU0OFFCTVUzaHRKUW5US2IySlA2U3dW?=
 =?utf-8?B?STZCN3pGRitiWkJUd2o3WUJZaU5iVmhKRTEvOHc5RjdlN0dtUnZrcGwzQW1v?=
 =?utf-8?B?NnJ5OFlKbTRpWFdudkxaOVVLcU1tbWZGb0NEK0ZvOGh1cmY3dkxjb2tqdXU4?=
 =?utf-8?B?SWtSQ2k0ckJxaG45TDdVR3UybllSZEs3N0htZHBGT0MxV3dXMzkySGo4bTlY?=
 =?utf-8?B?bURBUlYwS1VFSk0vU3NudmFOTlVCbWVGaTlFbjZOWkVwYWQvOTdUeElDbGtu?=
 =?utf-8?B?VjhYNFRodmRkRlZFb0hPVDJKcDlhbldsSS9CSEF3SDhzOWRab3FJYjZEcTRt?=
 =?utf-8?B?QVhRc1J4Vmg0cGFVQitjQkZ5NlhJMlpZQ2xZa0FJRm9mM1lmdEJpNzFDN0VD?=
 =?utf-8?B?VnRwM0oySy8zbU04NXpCKzVEaXQycFpvbWJFemtmMi82QmVTdE1BZFk0Zity?=
 =?utf-8?B?WW8wSk9Vb2JHOUQ4RktMTWlIbER5d2Z2RGhvVDdLS1dnRk1ObnVJU0dKeGJR?=
 =?utf-8?B?aWVrT21vRVV3QnhoQVNNaUcra3dVSmlZMkswbHRrZWdNak01eFVLbGFuWjhn?=
 =?utf-8?B?SEhtQT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnAwVHMwNDVuUlVQb05iSmZ4SGc5K0lFS3RaYm10dS9yS3pib0lVMENlbERr?=
 =?utf-8?B?b08zQ1UxT0tRSjlrektoc2FhMmhZeGdrMjJCTSs1TW9qMlEyL1ZNTHVWc3ZM?=
 =?utf-8?B?Y3hNdVRhTDAyT1Q4cmVmV3dDNDZTdzEyTE42WGFkSmpPUnRDcXpZNzU1N1lE?=
 =?utf-8?B?a1dXbXI1Skl2U2xsWEpTZWJWNkYyODk0MlBsaHlRZG82VkxnV2xmeFl6QjRP?=
 =?utf-8?B?YU5QSDNibmF6WGRNK2tYdEREdmN4YW55MTZrMms5SjhmVWVZT2wzbDY1VGNo?=
 =?utf-8?B?UUs2V2NQYk9EaER5RG1FcDZmK3RINVllV0puN1pPSnpDbXF5eExmQW0vblRi?=
 =?utf-8?B?c29ZTzBtN0laazdFRnRrYXZPMlJkM1hXaWMzTmFPWnRta1RobmdjRGh2TU04?=
 =?utf-8?B?QnVFUnpvWkJGYTRqYXhIUVkvSGJsVHRIY2VpamZxTWgyTVAvTHIrYUd1UTRZ?=
 =?utf-8?B?MVo1bEp1WllOR01mTHZPN05QL0ZJaENxalNSZGYzclArZ1NsRW9Tb3dpZlZx?=
 =?utf-8?B?TUZ0cEZDdlZFR2wxVnVPQWlaazVDV2R3MFlmcGlIME1obkVhMEhlSlVVN2FU?=
 =?utf-8?B?dG9FY05taXNPNEdXZmZOVlVCbm8rSWxWZGVoWGJvQUgrTms1TFYweWtiWTJ3?=
 =?utf-8?B?NEtUdHVjUWpoRjFkQzRYTFhGUXVDYjdWdUJtdFpwYVpFUnV6WERZbEpyYzdY?=
 =?utf-8?B?YytUNzAwQzd1N1lGalY4RWRnbXdMaUxublAwcng1UnFBTU12YjR0YUlLdTla?=
 =?utf-8?B?YUM3RmVEeXZYWGp6YXphTUtmMDRKQjhPaVIzRmdWbmc1SWZSdFlvUEJ0K0dv?=
 =?utf-8?B?TlQ5RXV4K0wrTHhQWGFKQ0g4NE9lRDhDY3JXZTFZT2JVTWQ2dVU2czhQYlg5?=
 =?utf-8?B?bUdPUEZ3TEVJKzFZMVIvWEFPWktCcDh3Y2orWHhaV2FvZ3hQTE9xSUVwd3FS?=
 =?utf-8?B?YWhYOG0vbStvaU5rajFOcldNU3I3bnBTVVBmR3ZaMS85WDNNaDYwMjZUTzFw?=
 =?utf-8?B?RDloSVNCeGdZbUd5d2RGUktwM3F2emVjeHpWWXFXMHpTVDQ4V29WRTNpOStI?=
 =?utf-8?B?M0R2WCtsOE9IaEk2NWVITUJOUzFFSXZ1aDZPOVVPMmlUaTFvYVJGNkduR085?=
 =?utf-8?B?SVhidjRxS3NJdFJ2OExMelNwbXRabTU0djkxQkVkazJ2SmhmQ01aYk9WUXhK?=
 =?utf-8?B?Z2xQMXdGd0lUaU0xQUVQc1c1bEl4RnAySnhybnowWEtVT05MMktLLzVuSm9K?=
 =?utf-8?B?SE0vU20zSVJObjNVNEJSMHlIRUtVeSs1cVlhcFJxVWxPK0xDYWNGcjlsbzJi?=
 =?utf-8?B?aVVqQTFZV3UzZ2lEaWhlMDJzMHNrc1c2ZkVqVlJJU1Z0VFBSM3V2aHRjcnlj?=
 =?utf-8?B?ajY1QnFzeG80TTNOY3JldnYrMkFUMW9rdStkMEEvMk15RXM0OWcxZ00yU0dW?=
 =?utf-8?B?WG9pZm9tQkhqcVJNaGVnNFozMkJOTUZKbkxTeHdoYUlzcU9seVpiTHNyeDds?=
 =?utf-8?B?ZWdkRDkzazkrbzF2bGJkMVN5dnJURk04YnM3MHZnb1FPR2QrOTBXQ1EyRS9s?=
 =?utf-8?B?SG9SUFZFcTJYU1k0cTF6WTBUcEk1Y1F2dGZ2ZHZxOEZTS0ZDelAwTWZYemQw?=
 =?utf-8?B?b2ovNi9KLzF2QVV4ZmZtaENESWVSNlJ1OHp4S3kycFAwY3VjZXFxNlk2T2U5?=
 =?utf-8?B?NEs2TlhTK1djYjF1NW80M3dWZ05hYkl6T3Q2eGVyT2R0ckxTN0c3MDhZSk5w?=
 =?utf-8?B?RFFqdFpqVHRlREMyeENPc3huVGczSWYrVDRQNlY4NktOTWFyREt3N2p5eEFN?=
 =?utf-8?B?OWlPV2ZIVENpN2NMZ2lidEI3ejhmL0UrNTBFSmNVSDJhcTRWWngrZFdYTFM4?=
 =?utf-8?Q?jIdk9YziZX/TB?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1caf01d9-0895-4fe7-c48c-08df1d10627d
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 03:27:12.2481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7100


On 9/25/2026 11:16 PM, Andrew Jones wrote:
> Upcoming RISC-V IOMMU interrupt remapping needs to map every possible
> host IMSIC target into one contiguous MSI IOVA range. MSI message
> composition then uses the target CPU's position within that range.
>
> Build an IMSIC physical address array indexed by logical CPU.
> Require every possible CPU to have an initialized IMSIC page before
> publishing the array. This preserves physical address zero as a valid
> target and guarantees the array has num_possible_cpus() entries.
>
> The array size and each target's index can therefore be derived
> directly, without storing duplicate count or per-CPU index metadata.
>
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   drivers/irqchip/irq-riscv-imsic-state.c | 32 +++++++++++++++++++++++++
>   drivers/irqchip/irq-riscv-imsic-state.h |  3 +++
>   2 files changed, 35 insertions(+)
>
> diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
> index df38a7670a89..abd1cdb640ea 100644
> --- a/drivers/irqchip/irq-riscv-imsic-state.c
> +++ b/drivers/irqchip/irq-riscv-imsic-state.c
> @@ -709,6 +709,31 @@ static int __init imsic_get_mmio_resource(struct fwnode_handle *fwnode,
>   	return of_address_to_resource(to_of_node(fwnode), index, res);
>   }
>   
> +static int __init imsic_init_msi_pa_list(void)
> +{
> +	struct imsic_global_config *global = &imsic->global;
> +	phys_addr_t *msi_pa_list;
> +	unsigned int cpu;
> +
> +	msi_pa_list = kcalloc(num_possible_cpus(), sizeof(*msi_pa_list), GFP_KERNEL);
> +	if (!msi_pa_list)
> +		return -ENOMEM;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct imsic_local_config *local = per_cpu_ptr(global->local, cpu);
> +
> +		if (!local->msi_va) {
> +			kfree(msi_pa_list);
> +			return -ENODEV;
> +		}
> +
> +		msi_pa_list[cpu] = local->msi_pa;
> +	}
> +
> +	imsic->msi_pa_list = msi_pa_list;
> +	return 0;
> +}
> +
>   static int __init imsic_parse_fwnode(struct fwnode_handle *fwnode,
>   				     struct imsic_global_config *global,
>   				     u32 *nr_parent_irqs,
> @@ -959,6 +984,12 @@ int __init imsic_setup_state(struct fwnode_handle *fwnode, void *opaque)
>   		goto out_local_cleanup;
>   	}
>   
> +	rc = imsic_init_msi_pa_list();
> +	if (rc) {
> +		pr_err("%pfwP: failed to initialize MSI address list\n", fwnode);
> +		goto out_local_cleanup;
> +	}
> +
>   	/* Initialize matrix allocator */
>   	rc = imsic_matrix_init();
>   	if (rc) {
> @@ -984,6 +1015,7 @@ int __init imsic_setup_state(struct fwnode_handle *fwnode, void *opaque)
>   out_free_local:
>   	free_percpu(imsic->global.local);
>   out_free_priv:
> +	kfree(imsic->msi_pa_list);
>   	kfree(imsic);
>   	imsic = NULL;
>   	return rc;
> diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/irq-riscv-imsic-state.h
> index c42ee180b305..e51c61dcced3 100644
> --- a/drivers/irqchip/irq-riscv-imsic-state.h
> +++ b/drivers/irqchip/irq-riscv-imsic-state.h
> @@ -50,6 +50,9 @@ struct imsic_priv {
>   	/* Global configuration common for all HARTs */
>   	struct imsic_global_config		global;
>   
> +	/* MSI target physical addresses indexed by logical CPU for IOMMU mapping */
> +	phys_addr_t				*msi_pa_list;
> +
>   	/* Per-CPU state */
>   	struct imsic_local_priv __percpu	*lpriv;
>   
