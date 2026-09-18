Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012059.outbound.protection.outlook.com [52.103.66.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E357538AC6A
	for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 03:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789702793; cv=fail; b=iYeyDENa6LkyHf9cAa4CpFZOuHt+Z6H0rD3P7DaU9H2yRnAprglPFE7wlbHKWKafajzqbeDE6Qs0yDNb8w/7Y67npHTF4a4BE3C97dWRRTMyvdcHp9elCZGTI0yfnXRrZRqIAy7Vf1/md7qLDyFdpZjLlpKs8c/2kW93CmxCsfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789702793; c=relaxed/simple;
	bh=px0OhpqWoIPuRSHACnThUWAFzojKKdwRxuox/FD4Tf4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h0Kev9vIxb4Q16Aj9nw80CAbOvXSZgByUl0Qgos3A2wpEvYGgFUag13eN7ncAUflGmlXg4Fng7Ij4NNG3y6nMmuW2sZqB+FHnJKlLv8Jg/JwVCmZhCH6EaonMsORVGDr1SIlTEEpEJCWPhzfRp0oib+MaUsLCEAMYytuCvSQivI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=ASjhrxRT; arc=fail smtp.client-ip=52.103.66.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="ASjhrxRT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGOj4ODPRheIZkSDuHK8aJI3FxMROWSgKpziXflbWjU4K596z3MRE2cLI9tXWsWtZK+Q8ER90wwJWAwdRtL4GzUeRg6CKQGl6EzehPdL42HQNjtqxevAh6wozNEt4WdN21b5mvA1tSKSjth1av7NWYUtvma9IxO2p8okvGQNX3/Lxj3d2W02YVjJ0wq5rsBH25Lh0gTyzSQS6bBcVJ6lUtFja7J4c+cHFcCGdIWkpUpwLEs7L2/4YgHr/As21FGfENxBzq5ko236sqfm94YsawaF0CVmjV67Ej7H3ubvU53wrBDqlKO6gcT7l9DD2Yp5HpwMSnQpp+U/5es9WX1FZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQR9lADKHi8PvY/685xEyi55VSO5pV6EUt1WcHvhGQo=;
 b=V3qVw721qHXlNXBhtJ+GZSZZHt81buRtbv0pwmwZjYpPwa+M7nMAZ/lw0eYW8XcWGJjuIb9nfNw3zqH25iE/GadQ4lf5CVibJCtk6zkWlp/9GU5hpsNVYuTPJnFaVpgJeJdMZ6qD3zQuAvVwzFyaphZcQiBulHj12CUQBuC58UpHGVzJNA+sxvm6apOAlpNsUHlUJu8ecpcBcbAE7K86gfeNWpBZNJOjXDdRizNdspVEPnRsSnbcL/OdyIp9ziWkuGqSHu9YKwONxVzp+MDwPFw5F1cPUUqw1b82shChutv2DhBBNrY/pMXEcV59RjcrSV/OyxNjhOrWF0NFcFf5bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQR9lADKHi8PvY/685xEyi55VSO5pV6EUt1WcHvhGQo=;
 b=ASjhrxRTHuY6xavHu+MGCIH2CFZpjnn6OjLyhpeQ/tM3zBmMH0r0hTBCupaiUSdPUZcvcYL6n/mfDsRYgxQ6YYSk6KxE6gs7tQA6pqiF2xGfm5ghZHSJjowRGtohWYNUAzheOgFGhMJKBbi9RNLCw9Y9TwcPjSHanYOQQZLIgspqH33/905mno4MS8RwDJl1Hx26TXXliZzvnCvjN13TO1oyU/tObowsDRUQRgvtBYayG5HHgoBylS2IDi9MaBERrV3nS339SVglM4QaX3mVqMbDDuykCuUcrIRmGNuUMpeRqIJNg3TJwOO7JSuuF/Pkiifz3VWmB9iJR4CqEAh33Q==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by TYSPR04MB8290.apcprd04.prod.outlook.com (2603:1096:405:c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 03:39:42 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%5]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 03:39:42 +0000
Message-ID:
 <SE3PR04MB89225D0D13DE77F5BF65B8E2F3872@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Fri, 18 Sep 2026 11:39:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 03/10] iommu/riscv: report iommu capabilities
To: fangyu.yu@linux.alibaba.com, tomasz.jeznach@linux.dev, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, baolu.lu@linux.intel.com,
 jroedel@suse.de, zong.li@sifive.com, andrew.jones@oss.qualcomm.com,
 anup@brainfault.org, jgg@nvidia.com, jgg@ziepe.ca, kevin.tian@intel.com,
 atish.patra@linux.dev, skhawaja@google.com, vasant.hegde@amd.com,
 joerg.roedel@amd.com
Cc: guoren@kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org,
 Tomasz Jeznach <tjeznach@rivosinc.com>
References: <20260915032828.11250-1-fangyu.yu@linux.alibaba.com>
 <20260915032828.11250-4-fangyu.yu@linux.alibaba.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260915032828.11250-4-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0028.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::17) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID:
 <72cf6afa-47cf-4971-84d9-6913ffff58ac@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|TYSPR04MB8290:EE_
X-MS-Office365-Filtering-Correlation-Id: 47a08b6a-b2e0-44d1-4165-08df153678f0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|23021999003|5072599009|15080799012|55001999006|4140399003|51005399006|8060799015|19110799012|25010399006|19101099003|24121999003|22091999003|41001999006|3412199025|440099028|40105399003|2607281247196008;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnlzekNjcVhjeTB0amZackF3R0p0TksvbllUN2xmRGwwcHVwUW85R2o2TWMv?=
 =?utf-8?B?UkVFdnNGcVVBUnRSTHlkT0VIb2pwRm9jVjRvTDlIQjlZd3A0V0l1MkFsanlC?=
 =?utf-8?B?c0cvWHlWbjduRWlEOHAwSDJPcXZraEM0RDRsc3lXbTQ5azZOamcvNjQvVGcy?=
 =?utf-8?B?dFEvNkVRUVJqMVlzRndUMXlMK3luNVczd1RDNWtmd2V6WjJmMUoyUG9RVEhq?=
 =?utf-8?B?RHo5UDN3SkhmbzJCU0NhcnEwTlZlanNBOE1CZnZjaW9lUktIQ0FDdTBkZFBL?=
 =?utf-8?B?NFdHMTlFaXRoMEg1alNKM2Eza3JpQUxaUDZLczJrbFlFYkZjV3lhVW1iZGxy?=
 =?utf-8?B?Z1BJZ3V3SkNKeUo3OUhBalAxM1VvSTNoNHFNaytDOVZWdlhEbkhVR1JOTUt4?=
 =?utf-8?B?cVkyamVtYVNjcDluZ0JFQjVuVDJuZjBmTFJuR1A0b1drQWhseXFxRE5PTVgx?=
 =?utf-8?B?cmZFSjRVK210ZUt4ekNyL0Noa2tlZnBMVEdtTFloclo3Q2ZHN2NoeURkckF1?=
 =?utf-8?B?ZytoeUp3VDk0VlZJaE9ZR014TkMwbFd1V1dWbGZUUEUxOExsK044cjdkeEky?=
 =?utf-8?B?TXBiWjlDL2dtcHdwcEJHbTFLMzlIVmYvOGFlTUV0S2lYZVBTM0ZPUVcwb01Z?=
 =?utf-8?B?dkhWazdPUHNJcmV3dUFxNkhoVjZvT0d1RW1qbHI4dWFOYkMzWkRjZlBmNTJY?=
 =?utf-8?B?NjFKQ3BTZDU0Z0g2S2ltTGgyazZvNzNUNDQ5NFl1UTFSNDlmWEttSGJiSVpC?=
 =?utf-8?B?S1B0bGluVmp1VitVaEZqUFQ3bnVxd2VvcFdWSE9QclE1NkJ4R3Z1cnk2T0ds?=
 =?utf-8?B?aUJKZnFRUUQrdFBhT2dpZVVmRE5hdHdpRGFibytVR1M1ekxkclUyMVN6cG4r?=
 =?utf-8?B?UDRReHdYVldYYnBBV1R2ZlRCdzVqd054ZFRKNkR3ZnE5NHloQUtORStKU0Zi?=
 =?utf-8?B?eHdkdE5aUWYrRDNKdEdabWkrdTVNbUp6T1BqSldCcENDUGhuK3MwUDJYMWZX?=
 =?utf-8?B?elZTU3hRM1gwZGlPeGJCQTUwRzVOcEhTdlltUi9JancvNzkwWkREc0N4cSs4?=
 =?utf-8?B?dzJmaHV5ZnFvcVQ0UWFKVlJjUHEzYmw5MjE1V0pEa05VdVcxNjRoa0grcXY0?=
 =?utf-8?B?NVB5OFIraW9QNjg4ZFVNT0t4UGZ0WFpjWit2NDg3MlVCMHhkVGs3YjlxWDBl?=
 =?utf-8?B?R2k1b2xkRlU5VStuQWpndXdQWmprTkRRaTZRZ3d5dHRTNlpMV2VPU09xTHhH?=
 =?utf-8?B?WWRUa0hsdDl5YVIyQnFTbXZWWGxUbldHa1pwdUsxZG1lWThUOThjTHduQWlL?=
 =?utf-8?B?bWpRMTVlbTVuSkF1T0dOZ2R3SzBWNEh1NzRaNjdOZzVNZVQrQUJIK0ozS2ZS?=
 =?utf-8?B?TzNuaUdYWEI0bWN5MUtkeEdibjY1SGYrdEh1emkrZjdFaU5mVVZnbEFMK0s4?=
 =?utf-8?B?UnlmQjBtbjZYOG9ISHNVaDhCeExXbTVzQ2YzWWt3PT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGVVWHRhdnlpSXU0M21TL0Zvd2dDSmlPeldBNGVGa3lwSFRQOGtWcVNPY0Vn?=
 =?utf-8?B?SDluVjJMaldBemRBR0l3WWUzZWJabXo0MnpDVEdpM1ZveXFwcll5Y1l0eFp1?=
 =?utf-8?B?RVpaQTIwdW5hSFJlb1VMeEJSMmF0ckgzb3lVU0dxT2M2d3FEcEhUUnRqbWtW?=
 =?utf-8?B?eGhpSnZEUTMzT3pGd0VFWC9Rb1gwcmpjaFV5UTBVUW80OG41bFNRY05qNzJQ?=
 =?utf-8?B?RGJKK05RamFYTVRxRlVlNU5oUjBuS1I3VWowblRscUNYcEhJQVJqWVpoUjBM?=
 =?utf-8?B?cEpJbWFHcHlIMk1IbVRrY1dxbkx2V2U3dW43aHZtWUJ2Z2NzeGdaU3VvSjda?=
 =?utf-8?B?OW9vOVA5U2xKSGpjeFF3a3NoSnpPbEtGMitWQ3M5cHVtd25qd1BiVmdBcUFo?=
 =?utf-8?B?TGcrTEN2WUJsaUdSU0x6WHd0NUpnR3dXVnp2bkhkQnlWTy9DZ0NFNXlEMzAr?=
 =?utf-8?B?cVhFV2ZvdnVDZVBvcnU4c3hRcE9tNEs0MU04UGJ0clVSL0NzOXpHYW1iUjhP?=
 =?utf-8?B?SkRZSnB2bzlsVlo0akRhb25WZ3piWElTNDl1Q2pOSWJRNmZMclRTbnFQS3lU?=
 =?utf-8?B?ZWdjLzd0Smg3RncvVHJlK2c4aXpDR0R5V05XUzNRR2lDYlNvamhTdDdEMFFO?=
 =?utf-8?B?bEVTeG45WkdrZzVCUGdHTmVOMzlGRVpBL1pCNW12NHBRd2FDb3BVS1NLanBw?=
 =?utf-8?B?ZGl6enJMTHByeU9YQzNIVDR0eVVxOGZvS3kyQUNFb3Y2cjYzWUJjT1phUUhq?=
 =?utf-8?B?UjZBTWpvaERHNGJsMUF3KzV4YWJRZFR2VGJwMlNERFRiQ2Ntd1R4c3J3ZVFy?=
 =?utf-8?B?R2U5MlMxbnFjWDVkUWlDb3k0K1I1VE43TzYzaXpOODloU3FEemhpazE3VDJF?=
 =?utf-8?B?WDJESldrMjlDY2lKY3hWZzRQbjFMeUlHRUgwYm9xSGFVRUxRUFpVVlk4N2o1?=
 =?utf-8?B?TmFFZXdvK0tRTWlONC9sR21GMmlFaHFHODhUMTVJTFBaSW1adGxpa3VYL1NF?=
 =?utf-8?B?c0p4bElMK0Y0QWh2OExSSitBY1BzSHhCdjRtUnlUdmhJWlR1NmJmWkQ2dnRE?=
 =?utf-8?B?S2FmQmJ6L0pqMW1PU1JyejZRdHI2QzJqbmZKZTMwT2J1QTBqZHdYSXJRSDc2?=
 =?utf-8?B?VFpBNklsc0JLWXR2Z1UvN3ROYVBhWk8rb0RZd1FpbktlN2ZSd2tMVEdVK0dt?=
 =?utf-8?B?eHpuLzNlVkFhVmtMRU5yU1NRd0x1bEVkMFVqdHRvSHNiZURwbU91VmxoWStx?=
 =?utf-8?B?ZlhmN1pMZnFkNE9KNlVLd1o2VktsakhvMHltbHhSTDA1UFI0bWlRZjhVOUlD?=
 =?utf-8?B?QnVZOUNNUExsaEJZaThVVkV2WnRKV1lsN0RiVWpGZEQ2aUovcTR1UGxRSzhH?=
 =?utf-8?B?enhZdmlIYTl3ZEZUYm9OSnA3MnZwcW9NVEdrTWppcEVXSHg3aW54b2lNS3Zx?=
 =?utf-8?B?NUR4NmRsVjFHam1aVmV4aUJnWW0vbmFxNVRMM1NjdHZiaVFYYlZDNEZwd3lE?=
 =?utf-8?B?eHZKcjZ6RHRzV016Lzl4WE03VUd4SyszUjVLUFBZTXo2d0thMGZUYkxlaEtq?=
 =?utf-8?B?VkRHNUNZcmRaY2E2OTNDcTZKR2xXZEpVNzBXYjA2bXI0TzdyUmhTYW1zTEh2?=
 =?utf-8?B?eXNtemZyOGxOUVRXdlMwd0RvREdjZElWeDcrWUk4SXpjcVQxajdBZDljV0xr?=
 =?utf-8?B?NFpHZVZMdlJJV0xiN3VRL0dZNHZBbzNGTGFyTXI0WmhTUHNZcW1Hbjlvb0F5?=
 =?utf-8?B?Ty8yOFhteUxHUUFHVzJtR2FrUG03SmRmaitzc2N0Q3VIdFZDMDUxS0x1ZDZu?=
 =?utf-8?B?S0pMNkIxZVNhRVNhUElmWDR6MG9zR1MrQ3l2MTV5ZTBNNm5ST1FpUGpZbk1y?=
 =?utf-8?Q?scfZWG29kST8T?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a08b6a-b2e0-44d1-4165-08df153678f0
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 03:39:41.7390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB8290


On 9/15/2026 11:28 AM, fangyu.yu@linux.alibaba.com wrote:
> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>
> Report RISC-V IOMMU capabilities required by VFIO subsystem
> to enable PCIe device assignment.
>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   drivers/iommu/riscv/iommu.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index cec3ddd7ab10..a6c8307e82ea 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -1422,6 +1422,16 @@ static struct iommu_group *riscv_iommu_device_group(struct device *dev)
>   	return generic_device_group(dev);
>   }
>   
> +static bool riscv_iommu_capable(struct device *dev, enum iommu_cap cap)
> +{
> +	switch (cap) {
> +	case IOMMU_CAP_CACHE_COHERENCY:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>   static int riscv_iommu_of_xlate(struct device *dev, const struct of_phandle_args *args)
>   {
>   	return iommu_fwspec_add_ids(dev, args->args, 1);
> @@ -1483,6 +1493,7 @@ static void riscv_iommu_release_device(struct device *dev)
>   
>   static const struct iommu_ops riscv_iommu_ops = {
>   	.of_xlate = riscv_iommu_of_xlate,
> +	.capable = riscv_iommu_capable,
>   	.identity_domain = &riscv_iommu_identity_domain,
>   	.blocked_domain = &riscv_iommu_blocking_domain,
>   	.release_domain = &riscv_iommu_blocking_domain,
