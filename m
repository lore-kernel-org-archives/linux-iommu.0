Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013073.outbound.protection.outlook.com [52.103.43.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E373BBFAA
	for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 03:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787111745; cv=fail; b=X+auHBEhmwcQH9lbGi6JMGZDuq2IVo1BSW5aP/l54T+5lxvmyRWfUd3EYBNWFSk0qJ8pp6JJnUX4GISTOAbsI68DUI4Ds6WVWUsS6bg8JwOdPeDpuQywMdTF2whGZ1BO8h0IDI1+eF/Bl4FCUgFXLM88AzOOIB1bDfMY4FdbmhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787111745; c=relaxed/simple;
	bh=mu8WLTMBRdgnhqFpIRA+NGxYrVj9W8dcl2N9bnWIsqg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q+dh17/5OuMiS1aSbbasbYllaGBJSr/pCaqDukWpMGoO7fw0Ydi0Y4nf7wLkXcmEqeaUWdsB+dYjBafivvX3Uz/B+Mo5I5APY68yOSon4dPQfbkBFJRIgCCBqf3cggof7N32+LZ4c/Tj7RO8BH9lgii0reJXCdZu8hTSYwubyrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=HGE2+/La; arc=fail smtp.client-ip=52.103.43.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="HGE2+/La"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=En6GEgy9qyG06sPT9c92EwG7CehZJ2bA8eUbR1h+HB6cCH1HHZnSoHR7Rf6m2PGbxTXGz3P9fgDGawee/kKR/RjLvNy1Y2NkvPsUWUVSSkSMPykK51TnHoIhDc8JKzoTIKs+/tmvy0G4SqUJ1Pwha4VEunR/h5KRLuppGU6ZS0YsRpn9a6nhvnZZoTKDNdZjFeeOnbbBVfHVotQT7nUF72pMmyY89LZqSZQyn/5X78Ex8aWTcJyDOrb3eT2b9YZ4pk4L6xEm0W5p4MhbHh9q/5jbc4wUyEK0e9I4/Xqf4oLlUhhEF59aqTpZvVdHPxcFcOuGg394nHGUN6Te7/JDpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6zwmfejj1IcYvveBTkOMMEYTj57hz1mQcyQczB4I0I=;
 b=cezA0fslBHRvbiyxfJufJra0DE8GiBmD6FGJMRTPKLHltTTF9VSKBbm/sG8x6m7ZUMj2WDncX7WZBlv7azT/ROY1hSOcI1R49jRtu0n6QauXRrVN8vi8Lda1bqkGee1drlovWAlJKCwf6Gx19rMYss33mpjM+aGlit7u8mK8ciB7WUfgzt1TdcUfAQBXz2p7/ZwcYsnbBEZkv8C6r3jKPxRFTCL2Wa9VqyFuxMsHr1p8D7mI/t0fwvSbsweJnBMy9veI2FoD5+w8BRYLno1TRJaZ9juiRE89MtDL6isLcVvuTtpr0U6DSeOKRNlhFUbnlPNGdq3BjD4jr16fmpSirA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6zwmfejj1IcYvveBTkOMMEYTj57hz1mQcyQczB4I0I=;
 b=HGE2+/LatTNeygyv0hWm6jaPDIN6BYE4M2jMzWfSzP7UJeXUFwWAsjTceFE0a7pdzKoKWOYyUlbtGjQMybxofdq8ZtBTpyj3qY46DLYb9iHhu2ywkuX3Jq7V9HBjdZSoYs2smi4eEMpKs8zjRxiKRKNY1PjAG8lnJLPvvlcLyyyIJr1XP1IzdIs15t8ne3TfwYwssNd4lMrwLFVWUDeaKt5dww0JBTzpdBqqwkzmnAn5rbIRKE7VvOLka33owCoF7jYbKP6lvqT+3HAvqiyJk8VACQ0ZFHkYNd7RRgJLewLgRhC+7Czz6stIlb3zjRedSGSWv0nPOIibW/xRMvEhgw==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by TYZPR04MB6425.apcprd04.prod.outlook.com (2603:1096:400:28b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 03:55:33 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%5]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 03:55:33 +0000
Message-ID:
 <SE3PR04MB892225C3EBCB09734BD2FD16F3A52@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Wed, 19 Aug 2026 11:55:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/generic_pt: Fix the RISC-V supported feature mask
To: Andrew Jones <andrew.jones@oss.qualcomm.com>, iommu@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: fangyu.yu@linux.alibaba.com, tomasz.jeznach@linux.dev, jgg@ziepe.ca,
 oro@8bytes.org, will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
 palmer@dabbelt.com
References: <20260818092444.42755-1-andrew.jones@oss.qualcomm.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260818092444.42755-1-andrew.jones@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0131.apcprd02.prod.outlook.com
 (2603:1096:4:188::6) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID:
 <9d3ab431-62d0-4935-b576-745421daeb68@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|TYZPR04MB6425:EE_
X-MS-Office365-Filtering-Correlation-Id: 9011bed6-7479-4f8a-8fb7-08defda5b7d5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19101099003|15080799012|6090799003|23021999003|8060799015|19110799012|5072599009|22091999003|24121999003|25010399006|4140399003|40105399003|52005399003|26121999007|2607281247196008|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUNrUE1PSkJoYlowbnVnNXpqdnR4WDcveWtoYUVDbkw2NHhuMDF0TnAxb001?=
 =?utf-8?B?YU5ETGoyTXFUWVN5Vkd3VUlmcE9idkNCNGNMdHM2cWNjMjMrUmlFMHgwSWZr?=
 =?utf-8?B?NVR0YWpMWEdIcjAxVlF1dzYycWpDbFZpcEI0TW1aakhlRHhQSHkyOTRVSmYz?=
 =?utf-8?B?clByOERKNCt3eU5QNHJrQmcvVHhUcjluOGUrZWpBc2VqVWxENmZ3MW8vUXQ3?=
 =?utf-8?B?UGJZRUVyUFZIZk5sVHdTU0NqeStNWGpxRWtpSlVQZVd2RW5mM2VzbVVlL1BK?=
 =?utf-8?B?OWtDZWxDamxKY04yRTRlL21pVVZVQy9PMmlpTVVaMTd6MmZNQ1Q4Uk9WQWFU?=
 =?utf-8?B?MkszcVljR09NaVVCdmlXQ1FOM0k0ekl1c1M5aE8wY3l2S3VOb1QvZWt2MDMw?=
 =?utf-8?B?NFlKSHZMcStNNmFEZ1FraHlQVUtrWFBVc0lFNzIvWmV4bXR0V2Q0UzNXK2F2?=
 =?utf-8?B?Z094RHRHSGJnRE02ckhscGxLQnRWVmE3RE5GYlZCOWhGam9CdHJsV0YyUGhs?=
 =?utf-8?B?alFqREVNNXA2N2JGWTVndnA3dU4yM2lBYzc1LzErYis5cDlXV0NGMkp3U2h3?=
 =?utf-8?B?STdCcGFOTUZ0TmhaeHVqQVROVEZZRVZQMGlKTTdaU0ZCZzFoYlVOM29nSDM5?=
 =?utf-8?B?T2t1KzFrdFdpR1lOd21kMVdQWXdMNitIcGdCLy9Kb3lscUdIOHRDMHVNbXgw?=
 =?utf-8?B?S0o4VGVCQjgzM2JpaDBHYzJYWXV5RCtwV0FnMDI4OWhPUm11bkhCWHgxL0NX?=
 =?utf-8?B?N1JJRXVEYmM1RFRkeWUyeHNJaG5ENzd3UTRUZUMxSis4T3RFclJPaG5qQURr?=
 =?utf-8?B?RzFDV0pYaENIMWhtS3NOcjd6dzBKNG82UmpqYkdlWGNYNW5FNkQ3Q0pQT2Z3?=
 =?utf-8?B?K0E3WDNaTGtpYnJKdmZUWjhZWXA4NGpHOERDTWNqeG5idFRCMmtYcGIzbEV0?=
 =?utf-8?B?SUw3cDNDQnB4NU5IbmtJMi9sOFRVeVpHQkhEazU2OVIxZXFsajVQQVA3dnQz?=
 =?utf-8?B?SnJycWtyVFFmTzlZMWJWUU5abTMvdEtJTEFNMlplK2s2a2orMmtCanpxTUZy?=
 =?utf-8?B?WFJUakI2YjFtT3pKUkxMaVFBQVFnYTBKSWQzUFN6aGMvN3MxRm9IT1BNL3ky?=
 =?utf-8?B?aC9WeWRZSG1NMzdjUEhBUUswQWVjMnVlNE9ud2sxMmwrNE1DMjJaY3cwek9F?=
 =?utf-8?B?ZDNWTlpuL21TUlEyczUxd0tqTzJEV3NLRTlmRE9GNjVkZ29rZmJWRlBlKzF6?=
 =?utf-8?B?SkVhUjkwL2JIbnp0aXFXVGg2eWJ3M1ByYXQvbUFsOGZKVG4zTDMreW42WC8r?=
 =?utf-8?B?Vm5uYWhYeExVODZva2xtWUNDdmZJd2gzNVhoRTdaTkpDTEpmdUVLMEkrbmp1?=
 =?utf-8?B?aVBaZENQdkdyZGhWQllnQ0FjejBRNjJGVkVLWDN5SW5hU2xjN2ZaTDJCbTZU?=
 =?utf-8?Q?x8WgLcED?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWlmTkNucU5CaWtZQVd4RlRVaXNLSldJaXZnUnJ5RkdGUWQ5c0NlYTlJRXFO?=
 =?utf-8?B?TlF1TWxSd0c2V3FkbTN4NzNpMFp1aVBHeTdqUmtQREdzM2tWSXdRWkIyUVIz?=
 =?utf-8?B?VXpkV1VsaERIci9xQ2FEcW1WWU9PUTR2NW1ZSVFsRk9DNlVjRURkSkVFTWNo?=
 =?utf-8?B?ZGxNUUJGMGJvbVgzZzdzVDNSUkZ6LzRoUm1zYTNYdEZIV0kzUCtSNE94Syta?=
 =?utf-8?B?OURhY2VFbjlwbHNRUHMyUU43OHFZR1Z4bFFETXd3ZjVKeloySW42UndHTzl1?=
 =?utf-8?B?SFNia21Db2hkUG9VRmcxam9hOExjYkRkT1FKYkUwZXQyc0prcFNkZmlldXdj?=
 =?utf-8?B?SUh5ZWZ6UGp4aHU0U2RhSkxBTGZvNC8wMjdQYW9McThJV2RhZzhXbXBvUTRC?=
 =?utf-8?B?dCswbmplbEswQXNSMTk5TWI0bElncUlXT1BLalVlREhPcHhHMnlEcWxBeFBo?=
 =?utf-8?B?dU80eVZBdEZzQUx3ZkU4dlVYcS9vcWVXT2Z5UDdXRGo2cEUzMDIzVVh2L3V3?=
 =?utf-8?B?ZHVvdTdCNjNkVEtacG9vSU1qQVRQNVdmNjEydWtiQ0tkK1dsaGR3anQ1RHA0?=
 =?utf-8?B?K0tkTEd1Zzc2VlZxelMyc0RSa2x4d1h2dktGSFR5Rm1WQitpeUxFK2RaeVRs?=
 =?utf-8?B?T1pDN3E3Ti84alVkN2hFaFQraHhEOHBWZ1MyRU55L1VGWHBJa2VWdVpScWxs?=
 =?utf-8?B?RGh5MXlKUzNwVzVOR2VRdncxWTUyZ3E2VUVCYlB4K1ZLWThSTkpLeXBxTDMz?=
 =?utf-8?B?ZFM4aU5vNytpMGM0bHdtVmh5REpDM2dyNU9WazNLckF4OHdYM3hDbm50eFNK?=
 =?utf-8?B?UzJkZGQrbVNUQXkrVTVBUFZDWUFsOG0wVmlrZi9aMTRyWDNLcUIwTDNXTnFM?=
 =?utf-8?B?UnpyMDFseUVpYmVCdHhSZWFCRWVDNW5mR2x4dEc2MklRR25GVmM2SHlqMUlE?=
 =?utf-8?B?WUVISHpSTHdwL3RIR2d3Vk42d0srcTVJSVJwMHpvTHd0d2VQWERURW44MDA1?=
 =?utf-8?B?YUFseU9yQTd0L09CeUR0cldnRnNTaDk2VWJ1S09MSTcvVW9DenNMWFJqaWdw?=
 =?utf-8?B?SktiSm1MOEJBaDdubUFpL0t5ODJKMWFKd0NKTU5ISHlEWk04OHY5QXdJd1Nh?=
 =?utf-8?B?R051bGZENkpSR1hSSDVDNHYxVEZQbllXMkJieDZoTkVwNlhDcDBVUDl6UXF3?=
 =?utf-8?B?M0x5VjIrNFV2R1UvemdMaFA1aEc4TUM1d25vMU5Fa3Z5cjlQRTVDWEo4dUlV?=
 =?utf-8?B?TzRNS2FrOUw0WDEwWmpZS2ZkZko5NlFMSlFkVDRWRitKRTZCZmhoZFpURmNH?=
 =?utf-8?B?UDRhcW9oTUwwVFBTZENRUHU0bWZJaDY1RUREVlMxZUtGNm9aTXloTTlRL0s4?=
 =?utf-8?B?bUtrakk0TmpVSjRYTGl6NmFFeGhnN0J2ZmVJcFpZRjlLay9vVFpDODlUOG81?=
 =?utf-8?B?ZkxlbTlKTjRYaTFyUTIvc1JwcWRiTFRZZG1pVm5RLytuUjJHS1NOVlpMTVRN?=
 =?utf-8?B?VUNkQlR1NEJ4K0xvbFc3NnJEaVlGZU9JSXB6Sm5PRG1FZWxmQVlvNDE5RkN6?=
 =?utf-8?B?SVdqNGRGMmJpYklMbCtvNE8ydVpISmNXR2plWjJmWEhFdk1NLzlwMEJjYUJE?=
 =?utf-8?B?ei93cll0RHpCYmZ5b2JKVkllN2dhWFhFZklZQngyNS93SFFuZ3ZvVmpwbGFx?=
 =?utf-8?B?THZFdWdJZlZySmt3MzhzTXZkd09DVTNrWDZteVdhVXJXelAzbWo1bGFWSXVM?=
 =?utf-8?B?alU4WjFHbUZiNXhFZkR0V2gyVDZVTmdPTXNvNUJJTFBKSXBGQThBRy80UVB1?=
 =?utf-8?B?SmFhZWNVczlPekp0cjlrbk81WHNDZEhIajdJWmt4Z2VxWjlwbjBOVTNnMGl5?=
 =?utf-8?Q?gw6s2fy+8eWwN?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9011bed6-7479-4f8a-8fb7-08defda5b7d5
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 03:55:33.7305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6425


On 8/18/2026 5:24 PM, Andrew Jones wrote:
> The RISC-V format advertises Svpbmt to its users, but omits the feature
> from PT_SUPPORTED_FEATURES. Add it there so configurations which enable
> Svpbmt pass generic page-table feature validation.
>
> Fixes: f196a8668797 ("iommu/riscv: Advertise Svpbmt support to generic page table")
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   drivers/iommu/generic_pt/fmt/iommu_riscv64.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/generic_pt/fmt/iommu_riscv64.c b/drivers/iommu/generic_pt/fmt/iommu_riscv64.c
> index b18fc4d109f5..1bb74114fb02 100644
> --- a/drivers/iommu/generic_pt/fmt/iommu_riscv64.c
> +++ b/drivers/iommu/generic_pt/fmt/iommu_riscv64.c
> @@ -7,7 +7,8 @@
>   #define PT_SUPPORTED_FEATURES                                  \
>   	(BIT(PT_FEAT_SIGN_EXTEND) | BIT(PT_FEAT_FLUSH_RANGE) | \
>   	 BIT(PT_FEAT_RISCV_SVNAPOT_64K) |                      \
> -	 BIT(PT_FEAT_DETAILED_GATHER))
> +	 BIT(PT_FEAT_DETAILED_GATHER) |                        \
> +	 BIT(PT_FEAT_RISCV_SVPBMT))
>   #define PT_FORCE_ENABLED_FEATURES BIT(PT_FEAT_DETAILED_GATHER)
>   
>   #include "iommu_template.h"
