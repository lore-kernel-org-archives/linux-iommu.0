Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011036.outbound.protection.outlook.com [52.101.65.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944A0328B56
	for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 14:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789740491; cv=fail; b=dheD2dyCeROrMVsqpVPbg3KHwej21MfsrMSsqndhgX8yeB5GBamZ4GLrPiuIk+NS+qQTd+PUjTlZbZ3OkX/zva20niyg8flgk5tnCzlWxfteSUSlLrWouoifV9DFwZC7moj+suIGnC0oS+Pzb1/OAcgF24/rCxLa2DBqztS2hr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789740491; c=relaxed/simple;
	bh=DgQC/VhrmKMMt20PF57uipg1rzE7PI5VsNsEn5YQQKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BX0F+YubfvCwbQ5dlGFa+6oIDVKB6ZNsDIH6JtNdNE0sHTJn/BvPvYurlm809F+mS9iviZlssTPLdjKIq7EAk0KkXEQeWAY4PAI/nf/VhDQK9E0FiwYbUL/KXRqtNHYizeqpR5dvouX2IAWv6MyR3uZwZ10YmF/1cnuf/1ZRKU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=rxLAVR7t reason="signature verification failed"; arc=fail smtp.client-ip=52.101.65.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rxLAVR7t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uoR/Go2rBSUB+KSxqtaYbSlQjHjJwAzbM6KDh/uI3KymsOjjQDUglZGPW/TFu3M4lpryCMkrhfAPOUAralnDgM+MVmswplkGS7/IhHZ9IDTmxaZ/dIaNn7LypJKMPXp/K1Ne8OFJ5zvwunHOsQiKH69TXNjGyWRAavp91dXvPzwIheVQpIyMId/h69NZnu6xgl6S94J4QonbdkkK+MGty/5slqG2fv2EdYsENbdvTLm90oG+BFfNa0gm8k87kuggHbQ/WT0pT0Act8bN2XDC//HSX2guHRB7isjSa7k82oWxear5grSYeA9L+tjE4Y9yzsbUzWdzzoqUD0xEsvdQLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6OIQ47BKAq/fzchBzulUB3oFRjIhXFvUWYkurc54CI=;
 b=B/KxZOQlmF/HRuHTPA2aqjU8V1ZjkhyJiVADWWQPEDtP2HOqzdLMwVTDJ3vFcYQmeQBYtvzEpGfgKVPDLLfIxoiOPjOXohOyfCKbqOgyWTyHTuKbN3wjjd7MynaB3b2XWfk1DNeT3YjAzZPxQsPH2ztEyBIwTbiQ75jHvovvqLj/sn+XCr4dPFsClOMDddFMrH8Bw/8+ORkpYXRvv3ymA6onkvtNztFbpIrEP4zfjgIO+KoLGlcQqHr1bmHByq7Iens8b1rG3f2shGTlgzq3khEoKWWas6cH0l3w0dKaj/l0Dy4+8q0UVNCE6sr3htcnXKOHDVW6ZYjC9B0Bv+sKXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6OIQ47BKAq/fzchBzulUB3oFRjIhXFvUWYkurc54CI=;
 b=rxLAVR7tv/XJymU3NabBj51sa009Vj8YtcQesG/OkjmXpplj4hVnvBlPMgseB3BsGBeMaVoOJYOu5q8B9EQ9ToCqI2WRiwpOeU6EBrMQi0PuTANBwOY4gODt9TKaWWaPGIxvFp9E7pb7vYj3dYycze/+dkL2DBI13GhbnCY8HKI9wkEMgfpFUBciDWjWvMMMvTz3HgIozLqwD0R5eobfUR8oL9Q2boDQ866bQ5ObGhSryQ2VO1HUq2TcLKj1mxOjnSVBlR0UYfjNCsyHAQEXcRTS1WyiJWd27Xl9zdpcIBhdGbbBEilXtqcnCdM0PGv6OBFGIkTkid529cIjX3i1OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PA4PR04MB7776.eurprd04.prod.outlook.com (2603:10a6:102:c4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 14:08:05 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 14:08:05 +0000
Date: Fri, 18 Sep 2026 22:12:24 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC 0/2] iommu/dma: Fix DMA_ATTR_MMIO swiotlb rejection
Message-ID: <aq1GyO3vv8W6Adlr@shlinux89>
References: <20260916-iommu-dma-fix-v1-0-a59a0c45ec5b@nxp.com>
 <20260918123736.GW13683@unreal>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260918123736.GW13683@unreal>
X-ClientProxiedBy: MA0PR01CA0097.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::14) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PA4PR04MB7776:EE_
X-MS-Office365-Filtering-Correlation-Id: 4196e794-472a-40b5-d99d-08df158e4279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|19092799006|366016|18002099003|22082099003|11063799006|10067099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	BXvllwDmhYqxtxOTNNA7MS4e7hK7MEF9eg8F/KJv5lDEpgRsaNoZlDZhKUzDs1bCei1Go6qBfhvuOrekH47DLlRr6AicFcbV8yu8xa3X9BRNy2IrsG28zxCbym/jgt16cLEEvFr81+6uu8iJ+MfC+rG3hY7yu2Q10IHxIQpiYb85Fu1mRFjtBJQZBtUQLm0YI0oC4LLNnKKlbjl2tTIF3fbDsa+qLvIeWvi2U8fvVLf4CuOj5DTHUQ1qVzT1E50jzTgSwaX/A8zxPeYFCUgezUkzZpHfCboNvy+4AMN+GBjllrmkAZ5evljxNivREH/4PoQfZE1JDtdKbi0vd5BGRLv1dBRQN+3aKebuQch/fvxZhcJwLGCW0rviEpw/uIMJ7mL/OXS8QWNiDv/Bh3peslGdiMlL9b4PmKD+p3vsRi82XdJdp1dWOxTiG8dxz3a4ygV+zmcDlTtjN5Xh4I/A5tpQTYNPKwtUdbgjmvtdI7hZGtjPoyR3assZMTr99fEJkQrJiJdfgQL5jNuv/OdE102lSjcLjIh3cKJN8pRpKcp/5790wly/T9VpIAydlhnfCMIVnbPcytIGQToE5QTWhmgjiHk/nm1so+NyWDMy31dW0tKyOicrbZNXjAoMOSyDV/BdLjEE+wSRMaQf3wBBKXmm+CJl8Ukek/4LVPk1Nwk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(19092799006)(366016)(18002099003)(22082099003)(11063799006)(10067099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?PadpIumFyeLQ/vT5dAmTYFwP2ldgQ9qtWDt7cdkidFqSCERoQvxiEfH2vz?=
 =?iso-8859-1?Q?MQfW5J06L+d9AKYxQkwx67mz/bA2lmUlpotTwARmKjPk1M2cW8ipIlJSIG?=
 =?iso-8859-1?Q?KACGjHJA6lNLCghsNK7Itr+jn0dUFuHp7rRzwYJYxdqPht1cVfkO5YokL9?=
 =?iso-8859-1?Q?KeITTGLR6MLCvcbNLqxQkZDU6z61MEtmfEUhepkdd8a1MQSj97cPlBMS5I?=
 =?iso-8859-1?Q?O67xDMqtHfxSKgjYCWzPMuWMVDsxQakXLRBE4861BvwpwU/mirEu+MVVUj?=
 =?iso-8859-1?Q?DAnxpnqujtQ5HDaSQwRxlD66Yf2EMOjqa+9ckHkhddLRY8zey5yLt5Jgz6?=
 =?iso-8859-1?Q?gob/MGPq1foe50XAONj/ZQWTNlClx8w6FRjv2Fi97+L+R9+T/zWv+M4KzH?=
 =?iso-8859-1?Q?Vn/pn2QKIfAHZAJlhppEFKWPazyLBz9vgIFS7zmz11B3TSkr0s4ysu8vL5?=
 =?iso-8859-1?Q?+UVeGE4vEV9TawpNn1mOlLWUG4hckpiiIDk0D1Vm45jbYo6zsZamcyCaaY?=
 =?iso-8859-1?Q?q7QpKab0U9JkBedwPo/sP1HWN3n1wuYlQCniPOBNRdyg68lF4EyayEiqDv?=
 =?iso-8859-1?Q?z5WBNgYbg7hBxFwuWGGuWO0T/PEFL518djnGAyxO+46pe2E5pX1l1tS0v8?=
 =?iso-8859-1?Q?X5g78V68dn2iriHC0Zna5vMZeBHT/M4Z40Yo4o9OD/vUdmWHFIfEnAGYPx?=
 =?iso-8859-1?Q?rT1ZgubmO90Pjj7LWtjwXR4GEv+rt+dDUo6Mu/cQ8Uvbm+eU3uW1tmUckY?=
 =?iso-8859-1?Q?XanMENZsV6bSrX/2IqEnhfb9pHL4oP8h1Uz22+GBrc8n0owbi27Wa/Qnr1?=
 =?iso-8859-1?Q?Dr1KT1p0hsRcLQZdhgVZY4/+zazLReJvvgqNfu2KaVlyxarHLHI7l1SwdL?=
 =?iso-8859-1?Q?jcS6YQqBmPsSEmGMp8QWaHsgxMeBdN3r+j6Lz+lr0sItmz6yh3HlPRqmX8?=
 =?iso-8859-1?Q?w5rzYq5cBDBSAVrF40QcQEzBvjyoWTZu8uYZCc0fHalL+etZ6eJakg8Qot?=
 =?iso-8859-1?Q?O0OJ273NRPfthtGLmWHvpSUR6rT+jZmAgY7iPSFnNTXwW4Ig/OPkI3yvaA?=
 =?iso-8859-1?Q?/iOzONuZz/HEvCoc4zRVGILwJ5t2U7hfVyr3iXbOmWlG5barDmCo+o3N0M?=
 =?iso-8859-1?Q?4mJ8t2f9zAaolOsA715DA3s+B+k1rNAlNhtgNjU54fLY2hXY0XBzSTHQad?=
 =?iso-8859-1?Q?HjIwd0XKCu26Dd4dnigknV/2lL/dWBkvnwCCRyl7PywKzW/nwb24lhyq9M?=
 =?iso-8859-1?Q?z0CEo+a7H+LWZ5EtD5TgKqFf1ElLgVs4IOw3y2AAkJsCTlMmkDfE7jQ9Ui?=
 =?iso-8859-1?Q?b3OlrU3GhNKxeBZUOzxzW+8gsp7hRmLSXKQNe2c4emX9YxbuRQl8SE2nb4?=
 =?iso-8859-1?Q?TBCUBcOyDZRWhrZ8lK5dAOb6tGdZqSYhYzpVU3FOQFCEbB8QC4bckSgpQA?=
 =?iso-8859-1?Q?AAZKnSDJrQbGv/c8DOSStAJ/zXUZZ9pFISR8NknGB4HoxOJOZb9s5o7dy7?=
 =?iso-8859-1?Q?IHnpkzKlohHDazP46poZ25lw9i/X8O2HTNrgY24WTW0pNgukEZEn+8p6wz?=
 =?iso-8859-1?Q?9ZEy6ohPTtNyxtFMVZ6BFjGHtB+SxfBXvWOI1SS/D2yUDpmqDWBQrb2KFA?=
 =?iso-8859-1?Q?rECvV2jkuzSUGqghls+7zOOb6+yGcb2I2ObKojOFXsKHqcqXYezjiG+lBp?=
 =?iso-8859-1?Q?aEqI8rmYaE9OkQTEyitFzg+CIx4F6GFkN3q4s/CH3Jdu12R69x+fkX4D0S?=
 =?iso-8859-1?Q?4SZZ+hkBhqPvpnTY/fwNFFOaCHV0DLKM6tNj1TR0+zWqjLBRjOD8oRYKHT?=
 =?iso-8859-1?Q?tD65Oj/OOUCeg9NPdutr+WtA4NX3wjqB5dfU3/SA5sP0SdZ8QghQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4196e794-472a-40b5-d99d-08df158e4279
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 14:08:05.6321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dtJSSWJ4akPxnxgWXXHRPLdgpYdjQIoiVuRMnlEnJDBYwpK24AIiWpeD3414M5FHsidQNBH7xV41hlK046wuqqsTNrtPqsZgJ99Il7Ht5w0nPiaAs1rwOvbRZH3eWexT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7776

Hi Leon,

On Fri, Sep 18, 2026 at 03:37:36PM +0300, Leon Romanovsky wrote:
>On Wed, Sep 16, 2026 at 11:23:32PM +0800, Peng Fan (OSS) wrote:
>> Commit f9374de14c0e8 ("iommu/dma: implement DMA_ATTR_MMIO for
>> iommu_dma_(un)map_phys()") and commit c288d657dd515 ("iommu/dma: implement
>> DMA_ATTR_MMIO for dma_iova_link().") added DMA_ATTR_MMIO support to skip
>> swiotlb bouncing and cache flushing for MMIO resources. However, both
>> implementations placed the DMA_ATTR_MMIO check inside the swiotlb bounce block,
>> causing non-page-aligned MMIO mappings to be rejected outright instead of
>> skipping the bounce and proceeding to create the IOVA mapping.
>> 
>> This breaks dma_map_resource() for any non-page-aligned device register when
>> behind an IOMMU: DMA controllers that map peripheral FIFO addresses
>> (e.g. SPI controller TX/RX data registers) through an IOMMU for per-channel
>> isolation.
>> 
>> Both patches move the DMA_ATTR_MMIO check before the swiotlb block so MMIO,
>> resources skip the entire bounce path and fall through directly to the IOMMU
>> mapping function.
>
>While I understand the rationale behind the first patch, why do we need the
>second one? Do we want to allow unaligned addresses for the _link_ as well?
>Current users don't need it.

My intention with the second patch was to make the DMA_ATTR_MMIO handling
consistent with iommu_dma_map_phys(), since MMIO cannot be bounced by
SWIOTLB in either case.

However, I don't have a dma_iova_link() user that requires an
unaligned MMIO address, so no need to relax the existing restriction there.
 
I'll drop the second patch and keep this fix scoped to iommu_dma_map_phys()
in v2. Does that sounds good to you?

BTW, does patch 1 look good to you?

Thanks,
Peng

>
>Thanks
>
>> 
>> Tested on NXP i.MX95 with ARM SMMUv3 where the fsl-edma DMA controller maps
>> SPI peripheral FIFO registers (non-page-aligned) via dma_map_resource()
>> through per-channel IOMMU domains. Only the iommu_dma_map_phys() path was
>> exercised; the dma_iova_link() fix is by code inspection of the same pattern.
>> 
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>> Peng Fan (2):
>>       iommu/dma: skip swiotlb bounce for DMA_ATTR_MMIO in iommu_dma_map_phys
>>       iommu/dma: skip swiotlb bounce for DMA_ATTR_MMIO in dma_iova_link()
>> 
>>  drivers/iommu/dma-iommu.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>> ---
>> base-commit: e6e35979777d646fe3c7c94dca7dd32fb25d45f4
>> change-id: 20260916-iommu-dma-fix-9f55af1beb46
>> 
>> Best regards,
>> --  
>> Peng Fan <peng.fan@nxp.com>
>> 
>> 
>
>
