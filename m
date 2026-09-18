Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013087.outbound.protection.outlook.com [52.103.74.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BAA3B8D6D
	for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 03:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789702989; cv=fail; b=Zek8fFLni35+bFtGHPlwE6tjOsZWJbejl2TnfTqLd9FfDqkaFR49SaSHA65mHLUbWzvo0zA56nduvHdmpJ4za6vZzhDb3+iieNUtpSI8k8yllho9CS3WcLgSxQpAsu5eTvOQJwdxCps2tQ9Mr5l2jjRmqs3FeNOKC4iwV6ksTvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789702989; c=relaxed/simple;
	bh=iPkaAdFY4yyvQky+Wf/e105Tzu06aXc6dE47UR17Cbo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eM8oFZMmOA63aNzoTJDPsIt6Euv44Ovos9z/8DLox3G1mK71znA+ZhwoMTf8Ln16mgd+TSlQZcBckgU4HTDcm6NpzQ+dixZZs8QmbCGZsWthuJjNKtv0lsFWpdqxUC8ZGECdauczLZs9jUTTulm+CLtY9/rQ/99kPyVhJ3x+v8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=RZyEAheu; arc=fail smtp.client-ip=52.103.74.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="RZyEAheu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oAV2000+SpCbDs0DU/WKrfy39Uq2AAopRXKchNHr1/4TE7L6ZXsfvA8wUDkyyHoZjolr4C3nbeb8+wQ5hToC8clSCtq4Ebngzsf01GSY/XN/BHT9hBabHwe0aMgMzVN66mn9R3jumGOFfdIt0O+1CJOCThDzr97ZwkS9BX412Ol3isg3vtqxti8wZsuDF7eEcU3yVerUsCNSiZDxkpK6qD3VPjT0r5bouHFQ+++P/NuoX+XixHQlB6Esj1Jvza6uo1Td9ZsvRQr+8G+ljlzZgUma2WDnTQ8Qb65qnusbrXpRbKGtncnJ5tMgHY05ODik4KupWZ7z4q8H3QCNIh1zsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUa4/Njg3abJ2LRZ3CqG/HlIGS4+7+3yyt41mDFTS0Q=;
 b=XapbrEjVSoXqvVCdoF9weS0g/XleFk2MfBo0qcHBow9J0puwAg2tS4p7JHOXpm8WiV73CsBNxPe21LIZOsS6zIojx6lPkoHXw2/IEJpru1zc/Ow4UFhL5kI9VUynx7K2rwvqqjW8kyS+Hd0+ciyW0YzX75Uv4LghcMeGe4kugt2zVDjjh3Anxxprpu40IiyydVIdvfOLKD/R/xayea3K9QA8ZbRzeziTHgGUQl4JcUjpD1Lw8YBn3atU76u+MDtRN3wHEZvnemeXqKpp3SRC0DLCmqjfL/mZ5EsQdJ81PDbIgFvSWMgltLiAKbv+x3YC6K5gllkWOwmltGFtFZ3HvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUa4/Njg3abJ2LRZ3CqG/HlIGS4+7+3yyt41mDFTS0Q=;
 b=RZyEAheut8sSNnpbqT4NfxwGm5gbrpSQm2LgUhQwMu0prL/ncaucEiac8f+QOY5iE+k3Qw0CQyC2DLlkrdipiJhePDSoBXp9bnUpswMpmYU3LOB1M4bcijRWiWVX8efshm5pJCnSQgnI6eqz94wd2qIu5K+R0CNr5mH686Mo0p6GYH4NluEVCXKr07GXTMp5hJBbqKOJqo4ToFjfuYxT47PQO6B2qar+XKKmtqJ1Fai9e1APF+L0OE/So3nFChTie/G1ogUL5yzgccishY8hxjd3KhWnvQh9pTgEMTXYuR+8tXak/OBIwLnVolXxMHAMs5VHXCzdz58f4d4PyZbIjA==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by TYSPR04MB8290.apcprd04.prod.outlook.com (2603:1096:405:c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 03:42:55 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%5]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 03:42:55 +0000
Message-ID:
 <SE3PR04MB8922C1819F7685D7B6FDD2F5F3872@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Fri, 18 Sep 2026 11:42:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 04/10] iommu/riscv: use data structure instead of
 individual values
To: fangyu.yu@linux.alibaba.com, tomasz.jeznach@linux.dev, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, baolu.lu@linux.intel.com,
 jroedel@suse.de, zong.li@sifive.com, andrew.jones@oss.qualcomm.com,
 anup@brainfault.org, jgg@nvidia.com, jgg@ziepe.ca, kevin.tian@intel.com,
 atish.patra@linux.dev, skhawaja@google.com, vasant.hegde@amd.com,
 joerg.roedel@amd.com
Cc: guoren@kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org
References: <20260915032828.11250-1-fangyu.yu@linux.alibaba.com>
 <20260915032828.11250-5-fangyu.yu@linux.alibaba.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260915032828.11250-5-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0022.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::18) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID:
 <11e2b103-8206-4821-910c-b679c6b3f30e@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|TYSPR04MB8290:EE_
X-MS-Office365-Filtering-Correlation-Id: 1abd88a3-a71a-48ab-7507-08df1536ec67
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|23021999003|5072599009|15080799012|55001999006|4140399003|51005399006|8060799015|19110799012|25010399006|19101099003|24121999003|22091999003|41001999006|3412199025|440099028|40105399003|2607281247196008;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZnFSUWhWNC96emFwWDdDQ1lLTWxyczNhcHdYaHJ5M1locHczYWkrSTZzMWxS?=
 =?utf-8?B?TTF1ZmY2NHVSSXVqMSs4cXZpekpmM082MkFLdk1CaGRLTXlxY25Gc3p4ZE5n?=
 =?utf-8?B?M0w1Z1RoNWdoYVNmZStNZFBBWmUwUWFzVldHUWNSM3hDdjQxRG1sV3dXTE1X?=
 =?utf-8?B?bUdpSDJFcHZGQklyQUJiaXVrbnhZTUM0b0YvY3o0NnRJY0EvUFBPUGo3UzVW?=
 =?utf-8?B?Y0lJRGY1bXZHd1JqcTRrVUNBRkdYMjdZWmE0UWxWbnRkY1hXMmlWZkZRMWwx?=
 =?utf-8?B?Mng3L1M5eVpTT2txb3VDbEZiRmJ5ZGlRQXhmNk5HWWRyaUludzcyendqbDdF?=
 =?utf-8?B?dTVPenJrbTFoQjRoaEtKL0ZCMVgrTktuWHQ3VmVyUFM5NFZXTjZ0TUlWQ0Fo?=
 =?utf-8?B?SnNGRWtSQ2xtSVg0WStHUFFJWlZ4N21XK0RqZFFuU2FxMFBMZG9ENnVCTTAz?=
 =?utf-8?B?Um1PT1NYaEVraE9JWjB5NmhhK3dFZVNnRDdrVmZzM0NEOENqODY4SVh4TWVx?=
 =?utf-8?B?V21VVW5LQkFaNEU2VHRDUlFXTU1ZYWFVUHA2aEY1a3JjcUdMcmRZOFp5SW1R?=
 =?utf-8?B?elVCMDA3VUovcDM4RkRaaXUzM0pQenFUUFptQ0hkZm9EdVMvMFZDY2JHNU1p?=
 =?utf-8?B?UmhrWlJCSlRITXVRbDFiZmpGZEdETUpEc3YxVkl4MHAxeEdLRTRKc3VacW1V?=
 =?utf-8?B?SGJnT2hEZzJ3R0dQd0JORUdFcm5KSnhFcjNLbkpWMHgzSXpFOHYwbVoyL3RG?=
 =?utf-8?B?TlhtSlliZFJGcDl6SHFsTDcvL3V0dVQ5N2k2Z0ZpV09PSWlpblBzWmR4UEJW?=
 =?utf-8?B?Nk1CQzJGUFVlL09ZL0xLUFcrbTUxWXpQWTdkMmtqdHduVGkvSTNueHFxR3Ro?=
 =?utf-8?B?bmZENjQyWHkxRWxkbEx4VDhWMUlqV21zM1Z0bnQwZVY4MDJ1Qkc4THN1MGNJ?=
 =?utf-8?B?K2R1bDM0WnBFT0JNbXlzbC91L3ZjVDllc2VMRXZDeWVlWXcvNFJuc3NPKzJp?=
 =?utf-8?B?V3lueE1iOXJ3ejVhRmExaFhwbEhuZG9nQksyeG5iYS9jT0pyUlRIVkh0cHFo?=
 =?utf-8?B?WVJlZmw1UmwwMTBaQTY5N09pMWsrMEx2QmpMcjZISjhCOWVFaUkzank5a1FO?=
 =?utf-8?B?M1cwSnF1SjduTnVhYmprbXZhSW8yRUwyYmZNaVVnYjMwYkZkQjNTY3pNZ1Vw?=
 =?utf-8?B?YktsS3VxQzc5SkltVWsrbFVBc2IxLzVaVDZiRVR3NEVSendPc2tudmNCelN6?=
 =?utf-8?B?MDNNWGVINVdsMFpycFBhWFEybXdJWHRTcUM1WWdIellRM0pVZlVGNjFOOXJv?=
 =?utf-8?B?V2VTR2xxRFlRblNuVzNLZlNYV1FZaGxWVWdYUjFFVWZRM1BpUjZMOWUxM0h3?=
 =?utf-8?B?ZWl3NEdmOG9QNXlxN3VEVmZGT1hjOEVFemZJQ1BvV05Pc2M5N24waEVDa1NE?=
 =?utf-8?B?aGcwbWU3QTErZ29tYitZR0R5UHltakhTVS9DY0t3PT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QncvV2k2TVFkS2IvV3crUWMzTWdQN3hVTFV1V1VkZFdRZ1ZyRTFrWXJmRzBw?=
 =?utf-8?B?b3BVMlF6ZTlSaS9hbnI3aGtOeERMNzdreFZzYStYVE1XZHdGZ0RyWHF0UU5q?=
 =?utf-8?B?bHBhZXRXaHpPVTRSL3o5N2lYODBYalNVY1NXN1ZnZVFjdTVTMXNUcFRzTmRo?=
 =?utf-8?B?WkhDM08rbHExbUZBMEFJZzVUQnJEZXVhTVJibGlDajRPWHl3RkJSem1ONDM1?=
 =?utf-8?B?anBFQzZaQWxhSitUaEoyQ0RTbDJlbThzTHo0VUorOStaK1ZhSVU3SFBmR3Jp?=
 =?utf-8?B?dEErU1hESUFnMnl1NUw1cHowYWo5bUhEeWRJcjVzUVZMZ0s0ME8zaE1TS0RI?=
 =?utf-8?B?cEtuZDhaSFpaMEJieFkzczFFb21rMnZIWStoUE1lWkRmbEVFTmd5U2JEYmtz?=
 =?utf-8?B?Wmc0aEFEY1IxZGlrVWlKaG5pdWNDUS9YajFNNzJuNTlrYm9qQkMvUk5NZE1N?=
 =?utf-8?B?RTNFZlpqbjN0ekxYRzlCOGVVeW9kZWFNZVlsN3FtYzEyQUIzb29vV3BxMGMx?=
 =?utf-8?B?L2h2K2VWckJNb2VPckw4azlKNmpReHlGQkx6V1I5NDQzTVZYYzlXSktvV0ZJ?=
 =?utf-8?B?ak9ZVnZQQjhUM2ZaSWtFT0hoQlZVc29JVi81QkNhY0Q2L0RIdXl1eUdwS1Fq?=
 =?utf-8?B?TEErM3RXbzRGNE4rMHVJMHBqMlBJeDJWbnJ2L3JIbE5HTGVvaEs4OVJlMEZu?=
 =?utf-8?B?cFYzUHBVNzVQRURkdVlMajFkR2ZpSDJrNHdPVWcydUVEQnREdUFYMENaUll6?=
 =?utf-8?B?Nk45SElRT3ZHKzFPV05yNUsrQXZRQUxYRWl6bWkwb3l6bzF4OW1UM0RUS3gr?=
 =?utf-8?B?WGVQTEJ2cG15UHpaemFyTWlYRXVxc2VPV2xWYm4wZVZTTzRSaEU1QUFMcmdl?=
 =?utf-8?B?anVpK3hDUWs3ZEY2ZkxVa3Y5cnFIRHIwTlJna3p4MEdHNXJveElOVzNpdzJC?=
 =?utf-8?B?TFNYY000NWNPeEZLVlVmMmxEN1hqT1ZFaHhiZk10a0FxQ0c4NDd2MDY5eS9K?=
 =?utf-8?B?bFlPZ3JuY2srcGl4MTQvRDkxbFowVUJaT0k2T1BydFVuYWNJbkZQZHY0dThF?=
 =?utf-8?B?enVlY01VNGo4eTFGa0wzMWo2MFBPcXRwbmZuUnRlZldlNjNqK3BFWURsRzJV?=
 =?utf-8?B?Smh1ZDZSTE9icjFtWTE4K0Z1azdwYW4wSE9vNXlzZ0E0WVVDdTh0VDh5U3NI?=
 =?utf-8?B?ejllT3I2Y21RN1k0TGpqRnNIeDc0ekVxRm1naDNIaW1OcU1nbzZweitFTERi?=
 =?utf-8?B?VmdkN2VvcURZRVpmRmkybFZOdmE0aDltNXN6SnQwemlxbUZ0bFJIbkE0NlpK?=
 =?utf-8?B?aEhtT29QRUw1TWJNMzd6K0ZKSlB4aDcyMWE0d2NvWFo0ZTZ1TXo5eWdEWjNZ?=
 =?utf-8?B?RWVXTVVqaVluYlo1OW5nWG5IdDQxTEUrc2ZKb20wYm5LZ1BDaEFZVzliS3V4?=
 =?utf-8?B?b2NWMFVOczJiU2xheWxadnl6ZUppS1EzOTFmYkFhYkRZdUE2WFhMVlprUFRu?=
 =?utf-8?B?dnZWWnBYdFJySjBCdm9NdG5rMmVubXdCajUxU2dsdDI0WmhTQkFBQzFza1do?=
 =?utf-8?B?M05SSXhrVmRCTHRFajhIbkZ5THowNWZJOWRsTzVZdWNrNndTVi9WbVhqaDlH?=
 =?utf-8?B?MlVaQjRadWlrNFkyU21pdU1UZ1VpbU5NS1pSVUFVem8zQWhwaXZLcnBPMi8v?=
 =?utf-8?B?ckhFZmd3OTA1TUdzbGZEYUFnMkJmcGFBV3pvWE9GbGhEUUdlUHd0VWJvWEdN?=
 =?utf-8?B?RFE4R2JvTnJRZXdnRkZ5K1lubHRKeThBZk5yYjU5ejBaVlI2aDVmczk0WDhL?=
 =?utf-8?B?WldhZStoNXR1SzIyaHhFRGhSL0RxWFVncCt6K2JSb0tGanQ3cWRaaU51a1lF?=
 =?utf-8?Q?BDVY+eGr/MTh/?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1abd88a3-a71a-48ab-7507-08df1536ec67
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 03:42:55.5935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB8290


On 9/15/2026 11:28 AM, fangyu.yu@linux.alibaba.com wrote:
> From: Zong Li <zong.li@sifive.com>
>
> The parameter will be increased when we need to set up more
> bit fields in the device context. Use a data structure to
> wrap them up.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   drivers/iommu/riscv/iommu.c | 27 +++++++++++++++++----------
>   1 file changed, 17 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index a6c8307e82ea..c5b6214ee672 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -1165,7 +1165,7 @@ static void riscv_iommu_iodir_iotinval(struct riscv_iommu_device *iommu,
>    * interim translation faults.
>    */
>   static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
> -				     struct device *dev, u64 fsc, u64 ta)
> +				     struct device *dev, struct riscv_iommu_dc *new_dc)
>   {
>   	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>   	struct riscv_iommu_dc *dc;
> @@ -1204,10 +1204,10 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
>   	for (i = 0; i < fwspec->num_ids; i++) {
>   		dc = riscv_iommu_get_dc(iommu, fwspec->ids[i]);
>   		tc = READ_ONCE(dc->tc);
> -		tc |= ta & RISCV_IOMMU_DC_TC_V;
> +		tc |= new_dc->ta & RISCV_IOMMU_DC_TC_V;
>   
> -		WRITE_ONCE(dc->fsc, fsc);
> -		WRITE_ONCE(dc->ta, ta & RISCV_IOMMU_PC_TA_PSCID);
> +		WRITE_ONCE(dc->fsc, new_dc->fsc);
> +		WRITE_ONCE(dc->ta, new_dc->ta & RISCV_IOMMU_PC_TA_PSCID);
>   		/* Update device context, write TC.V as the last step. */
>   		dma_wmb();
>   		WRITE_ONCE(dc->tc, tc);
> @@ -1288,22 +1288,22 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
>   	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
>   	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
>   	struct pt_iommu_riscv_64_hw_info pt_info;
> -	u64 fsc, ta;
> +	struct riscv_iommu_dc dc = {0};
>   
>   	pt_iommu_riscv_64_hw_info(&domain->riscvpt, &pt_info);
>   
>   	if (!riscv_iommu_pt_supported(iommu, pt_info.fsc_iosatp_mode))
>   		return -ENODEV;
>   
> -	fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, pt_info.fsc_iosatp_mode) |
> +	dc.fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, pt_info.fsc_iosatp_mode) |
>   	      FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, pt_info.ppn);
> -	ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid) |
> +	dc.ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid) |
>   	     RISCV_IOMMU_PC_TA_V;
>   
>   	if (riscv_iommu_bond_link(domain, dev))
>   		return -ENOMEM;
>   
> -	riscv_iommu_iodir_update(iommu, dev, fsc, ta);
> +	riscv_iommu_iodir_update(iommu, dev, &dc);
>   	riscv_iommu_bond_unlink(info->domain, dev);
>   	info->domain = domain;
>   
> @@ -1378,9 +1378,12 @@ static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
>   {
>   	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
>   	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
> +	struct riscv_iommu_dc dc = {0};
> +
> +	dc.fsc = RISCV_IOMMU_FSC_BARE;
>   
>   	/* Make device context invalid, translation requests will fault w/ #258 */
> -	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, 0);
> +	riscv_iommu_iodir_update(iommu, dev, &dc);
>   	riscv_iommu_bond_unlink(info->domain, dev);
>   	info->domain = NULL;
>   
> @@ -1400,8 +1403,12 @@ static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
>   {
>   	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
>   	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
> +	struct riscv_iommu_dc dc = {0};
> +
> +	dc.fsc = RISCV_IOMMU_FSC_BARE;
> +	dc.ta = RISCV_IOMMU_PC_TA_V;
>   
> -	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, RISCV_IOMMU_PC_TA_V);
> +	riscv_iommu_iodir_update(iommu, dev, &dc);
>   	riscv_iommu_bond_unlink(info->domain, dev);
>   	info->domain = NULL;
>   
