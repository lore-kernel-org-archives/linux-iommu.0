Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013078.outbound.protection.outlook.com [52.103.74.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE06234964
	for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 02:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776048919; cv=fail; b=Uw4k8JGbki7lr1KcFsNnGaRQCsxfv9ZczXls21NEWxNQ1pNhdasr1FwiCnq4Sq6jrWAIhZqNA5hxGkHsGP9ryQfpvZoZT6H0pz9pK5Mo7PDrdbempGWR73+j7+YAkL9Slvses1Hiy7St6N0/jDFTQBPGGyFbGRdkfnAC++XkOjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776048919; c=relaxed/simple;
	bh=acQ5RwLTKW/9GurEDplyCEKXdWZ/eLGzPmtL8hVwdoc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dtsOs77hr33c1CY0rA309yj4P8ZfRcNtjUVXgSw0+Xcl3a5sejr0/QmoKbIQ+10IJyaho43HkphEodrdBQomEVmcmP+KuQRGfU9KwTUGEgWlBbTo9jByRloPeKj6nq2JmIB6VWWZEWjoABFrtlusbwW48L8Sm2NlpHB5ZWQPQTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=gdECFVHv; arc=fail smtp.client-ip=52.103.74.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="gdECFVHv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bl01qvqDzwIg5B5hH8KGXQBRDLf01m5aDjALt7G4LlfazRkAT4wY7snLb3bEJFLAcFpUkO/V5OQpQlBRqmk9XMwTVrpLtyAyzyQS0Afv3kIOmcTkLhSxjxsLOPXT5fCNXizulvV0Ou6FTCY9Ja8oprGX+HOsE6EP3kPkNeRL0u6chZGcTwEndXrl47HuXcelOsskWbC/n0LF2m/QzN+zHtDD+S5f3HHYHWPPaQNxc4CDY45lvJ9PkPnRkBGZ+VtKOrVeSYofxv3FRP3mjdG7T5oI8WIAyI8XSuls1e7aKoKHXJHCrSb9NDUfjjgG9KrNNIdaPJX7AjOwcHwwn5Y1lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OiDO5dqHatO8RZVXSDKsR4RMubL1NUya9TtfQN2k87E=;
 b=SNsN0BbSbJDiH+PujGB3MPwx2//XqzRoCbgGW+mqHHy32y3YR0Z0aq+JnjcGXwraZs/6FKPYBOzvC6qvR8vT3Z5ukc43Qk3HImtk4ZnF4PjrqY0MWyUEuU4C/8u9mr/OqS5qzgo5Z9uRtn4En3WXUUI6JeQhdoZhaDBVhmg+Xf5sb331yWH4XY/udjzY3f1F+hhh04KbtEOP094SmoLzk+9XYtYfE5NjnVG4hMF1tT2ZXtlYRL9KIEHQHeoysvQvIVyTTXoG1Ma1kZeTF2CkI73EgN0lYGbyn8koSEdsfyES2Y9yM1F/IVV2/LEiKTpe39NoP/Te+ENaImKoORWhog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiDO5dqHatO8RZVXSDKsR4RMubL1NUya9TtfQN2k87E=;
 b=gdECFVHv4nNM285CpdP9R0G99jl+xbeSpR3zzOMDfjG59mg13zdLd1hvcDXgLUC7ucizyK9QVDTdVCcw90xPGoyv2mZuIQ0BWCKh04Ow9msfNtNzb/tH9D1P7N30mf6BDZ77QqkzBtRqwwtGXioBXh04lW86M7UbWIejP8iIPa3Uw2rPetKFismsN9sFietvdVphXLzRkTOt8GloQNBsBI+So4wb/HUVx8EPct4A7M/UdXuu3n6rYnEnRxFmhYS2wUWwii9KUIWxNl4pbq9lYGlg2U1qllBP+n3K9k+4fls53tQSV/8QmrGuUOL7PuX4JPv8qLJHktX8ZYO9EhzCHQ==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by SEZPR04MB6124.apcprd04.prod.outlook.com (2603:1096:101:99::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 02:55:11 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%6]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 02:55:11 +0000
Message-ID:
 <SE3PR04MB8922CA375D76D5BB58633E1DF3242@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Mon, 13 Apr 2026 10:55:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu/riscv: Advertise Svpbmt support to generic page
 table
To: fangyu.yu@linux.alibaba.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, tjeznach@rivosinc.com, jgg@ziepe.ca,
 kevin.tian@intel.com, baolu.lu@linux.intel.com, vasant.hegde@amd.com
Cc: guoren@kernel.org, iommu@lists.linux.dev, kvm-riscv@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260411022223.91029-1-fangyu.yu@linux.alibaba.com>
 <20260411022223.91029-2-fangyu.yu@linux.alibaba.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260411022223.91029-2-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::24)
 To SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID:
 <3f24dc6f-9ff8-4c09-8c90-1b1fce8b2649@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|SEZPR04MB6124:EE_
X-MS-Office365-Filtering-Correlation-Id: cc4265de-29b9-4b22-d182-08de990813c9
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|15080799012|23021999003|19110799012|461199028|5072599009|51005399006|6090799003|3412199025|440099028|26121999003|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnVKdkZiNWYvTG9leHRRbmdpZlJ0TGpqam1BY2lVODFqakFSYmx1VmlXQm0w?=
 =?utf-8?B?OFlsazRUcllidlBneXgrdm4rbVZpMGpBOVV6LzRuZFk1STZxNE5pSFZkd29l?=
 =?utf-8?B?NFRPZWVURVh4Rmc1Y2tyR0Q0SFBwZExRUUwxR0ozREFtMVk2aXlXcXhDL1ha?=
 =?utf-8?B?TlpXWTFnK2JWR21KSk9XTmNsQUJ1bTJOTnNLUUY5MmxjQWpma2pDZm9KamFy?=
 =?utf-8?B?VFQzcjBJNVlEZHBaU0xwRG1QYW5oNmxnYUZRTnFrSnpHcDhxQXdzQ2JxM2t6?=
 =?utf-8?B?M3Q0TTR1dWV4bHEvakZDRHU0czUycUNPM05SSVZBQVFwNENxVlBJNlVzNHdy?=
 =?utf-8?B?ZXJOWEVGbW8yT1UwZTBwSlJBS3JLUUdwTldFQUVnbUhCeCt2RjJ6YkZ6QUph?=
 =?utf-8?B?UzZHTENoemdiUWJmN3lZcjNZOXJhaE9jMXhOYmZkWTN6RFRndlNuY2x5VEt6?=
 =?utf-8?B?WVlLTEZUMmdGSTlaRFE0QUMwWlpEVzN0YnRDS0taMFZRNE4wR1pBZEtvRHJn?=
 =?utf-8?B?cWNURlR2OFhJWDNNK0t3WThGWWw4OEZiV1FUTWhwcTU4endMSVpaL0xpK3kx?=
 =?utf-8?B?QlRITzkva0VSRDU0Z0lOZzQ0SW45Z3hINjMwbVhxSEtvRk1FNnFOZTBoU0E4?=
 =?utf-8?B?Y0JDeDA5QTRORVdOVk42OG5WNVppRExHdlAvcnFvZTcvZTg4MGJKeVRCVUNa?=
 =?utf-8?B?T3VHZTBPWElmU1NJeExUOFZ0OXBwdE5WaWx2dlFxNEFDaTE1alM4dVljWnJa?=
 =?utf-8?B?K2pEdWNBRFdTeFhCNkZiblY2UUlvZzhhZzJlWFk4NmpUR2RTWWlGckZFOThp?=
 =?utf-8?B?SW0zU1pGbGxVYkZUb3NvUSt0RVIzeUpuZkpEM1RCaWtZcVY4NVR0TVJOcUJh?=
 =?utf-8?B?RVVaTHVHM2hpQno2R2NuOHB5MkZiS0xKY0xiOVdUTkwzc0ZMNHV2S3hRaStS?=
 =?utf-8?B?ZVNabituVDRCRzV3SXorUytKd0t0ZkdTK0h3Q2hjemtLOG8zdEJBVDBySWNw?=
 =?utf-8?B?Z2h2NWxzL3RYc2NiRGFGejNoVC9FSXJzaUtJYzhFdzgzKzNmM09BcXJSUUI5?=
 =?utf-8?B?SFZRcjJ0OWllMGkzM0lOR0VyUU5jOHJ0ajlTQjhlYS9SaXFzU2pPM0VqWnMy?=
 =?utf-8?B?ei9xVUNlSXUvS0xMZ0l4S1AzdzN3aGlUVlRzY2x3WXlHUWVxUHYvSjlwdnFr?=
 =?utf-8?B?bUpFeHdCamdXWTBZOC8rbFRzWjF1b1hBL0tRZGlOTGxsdEI5MFN5WXRXdHUv?=
 =?utf-8?B?ZFpHRnh6dFJXWTc3aFJWNW8zT2V2ZUpVWjRyTG4xaXI4WDlGZz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L20wTjJCK0xzc015cE9valBXblkyRTRUMUt1dXAzNWFzeWEva0creVhzVU9P?=
 =?utf-8?B?SkhUZysrRlNacnNQNDBucVgrWUNvZyt5b0k1clFTZTBneGlrMGpZWHZmZktL?=
 =?utf-8?B?WVhoeWEvcDM0UEZWSFJXWGZMbFJ0bm5ISVp2b3BDUVJaalZWVnJmdU9zYllv?=
 =?utf-8?B?QmlHMmNKaCtvS2Q1Y1RUNFUwRVBDYVBSaXBwSmY4TVJOSm9xTVczRW1kVnR0?=
 =?utf-8?B?a1FKcnc0YkVCWnhwZGZTQ3pzTXJYNjNEYTcxWTNheUJ6NFh5K1hRMkt0TEZQ?=
 =?utf-8?B?bUFnaWhIVFV3Y0t0a2VoR1FrMDBCVkZ1aVhFdHY0WTd3SEVNbWtEWjlMbjRh?=
 =?utf-8?B?S3BjVGIrSkUvMWhWb2VoS3lPNjM3UWpGZmE4OEVUaXFqVzJrTFZnV045U29I?=
 =?utf-8?B?SGhJbDRodGVQekpmT3Z2NXVIVElGNnVWZEtRUFA1dWFaTm93cUpJaEQwYktK?=
 =?utf-8?B?OE9ZaGV2Z0YrMGdGcDJ1VnhlcjNtNFU4VU9sdnFsMlJ6UUpVN3o5QVcxSzV0?=
 =?utf-8?B?OEl6RFNjemNOY1JNZlMvVTlaRGl3QitsUTZqRkpPR3lZWlZoQWZOcFlKT1pH?=
 =?utf-8?B?SGRIbysrQmh1VXhoRENkbTZidDhVY1Q1U2JrT1BuVnpoZ0ttcHhZOTEwSmh3?=
 =?utf-8?B?UWsyY0VZc2VqTk1zL3dVc0FTT08vOFpPWE5WSkpqK1g2cG5HSUV2WXJDZUZM?=
 =?utf-8?B?a2FXUmZXTENlTFZxM2VzNDF3SUdpUHE3RmZNemkzMG9wbWdzR25oMnYyVzc1?=
 =?utf-8?B?QUlJVU44S1RUelVzVTd5MForS0l4R3dhQmVCbXBQRjI4Q3MzMVN2eFpHM1hj?=
 =?utf-8?B?cHUvbTJZOVJOUm41b2NvbC9BN2xoeHljTUQ0NGFPajhFSkxZT3AvRkFOc2xN?=
 =?utf-8?B?c3o5K2RsSm9pUm80blFiS3M1WmxnRGp2WEFaR0xFM3U2cmVpcjhQUUZUa2FR?=
 =?utf-8?B?blUxZ01xN1RjV2ZTY25ueG5hUXIvRU9TTXl2OWVKVEZ2WjZ5dFo4TWVrT0d6?=
 =?utf-8?B?alNtZFdqWmhhRWFROXJQNW1acXBEVzVmVVpLcSszc1cxMGR2QktoZlBoc3JJ?=
 =?utf-8?B?ekd3UW9MTnp6REU5MDgxNmNJeit0dnVsK3NKZlZmVlRBT2EvOWVnSkF6enBU?=
 =?utf-8?B?TEZUeW1Zc3VROE5yQnBDME5TbC9PZkNDc2hVc0tGRmViQ0V1eGhNdWY3MzJm?=
 =?utf-8?B?TFlzTFJVQ2dVV09GMUFxUTh2SDhXQ2pEZkliSjBiOEo3dTNHSjZJenFvb0px?=
 =?utf-8?B?Nmp0c3NQNEFPVkdMdEkxZ2l1Y2pINzl0aVZ2dDM0RWtORzFONWlyWStzekNq?=
 =?utf-8?B?SlN0Y2NJOHlGeDBySEJsVGRoRTVwWkxkVWRSQ3J5VGovQmJoRjFpY0ZZdHdZ?=
 =?utf-8?B?d0NrWElyWVErZjFIYkJacHN3ajRHaGpieXNpY1Z6QStQM3cyTk56NDhsZ2Fa?=
 =?utf-8?B?T0JYUkhUd2NyMzBWT2dNbW8wY1pUT05yMk02cVBHaWI1UWwrV1JhMDVhS2E5?=
 =?utf-8?B?NW80LzNic0JwZE9ITWdMdVJhckVhK2RSa3p5U0YzN0JWR1hCM0UwZ3RRMW1l?=
 =?utf-8?B?eVpVZFhLWkpZUnZRSldnczJJTmhBeTMwd0FHcGl0NFhWaUxEU2d3d01nQ3RB?=
 =?utf-8?B?V0g0TDBWanlNZ3FVdzh2dzRxOFl6WVppWE9kalBqRGY4MFZCbnNQSGFBajdL?=
 =?utf-8?B?RDJmRm5TTnR5NjFQQkpxUmVDTWJxbzErSDREWGZxcG1ocVhDUkxsbkVMSFhm?=
 =?utf-8?B?U0MyZjBjdUVIZ2VZK2N3dHU1QTlRM2JuS005SmM0Q2Y3Ukh1M045Q0ZjRTZi?=
 =?utf-8?B?dnVROXZRNE9qdlNDcVBzd1Y0NmlUTzk2RmZiZU1HdXd3WHdkQm5EWjZrNkZW?=
 =?utf-8?Q?skDlTIOzju4LX?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4265de-29b9-4b22-d182-08de990813c9
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 02:55:10.9645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6124


On 4/11/2026 10:22 AM, fangyu.yu@linux.alibaba.com wrote:
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>
> The RISC-V IOMMU can optionally support Svpbmt page-based memory types
> in its page table format. When present,the generic page table code can
> use this capability to encode memory attributes (e.g. MMIO vs normal
> memory) in PTEs.
>
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> ---
>   drivers/iommu/riscv/iommu.c       | 2 ++
>   include/linux/generic_pt/common.h | 1 +
>   2 files changed, 3 insertions(+)
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
