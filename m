Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794419984;
	b=bnJKIeGvqyV0hwtG1y5PzXIFR9nMeBTdrIv6Rf5ZwmO6n/GyL0LwcgXI/QaiEE5OGvXo
	 EN1qFm0AFKxnBOnZM35gTrOpmnhaudnVklw38x07HRpt0/uf2BP6GWbtF7wg/OlE2IIde
	 RjdWHzLEAIzylazgTKARI6lRT26ttmP5yhTXZpGp13OaEZW/HLYcYe/g+c2thnUqPBfIL
	 5hf2UwNDKfNi7y1umQ3zEsgQNGzGY7Q8QioDx8RgUQ3y2+w75PL3KMHbUp9k7/wXBlpJ4
	 zLBdM+DucSydbLqX9B8dLNG7Cxci3hLKtzyMgCXq0YvwKxnlsn6/IV4gCgjrXbP0uLw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419984;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=pkaJZSPpw4HX8tGoQuNeTOTO+g5PRUqg4PZdgIWKEx4=;
	b=ZiINRTE3eVbO5Xev8R/cSI457Sbucr2uy86wKHwvH+kzuGSNUH7cUIi91jukqN1KTYdJ
	 wzTqDS1CtWtnFF4mRHP5WQnSJy6Xj1fiFE9WmAAsMaBfc+Fxpcia2omFb8DoSzl18NZst
	 b1sVhRsgmwSXPZi8bcC7bksCmrn8NviItJatYVtGEmoGxJ/Z/1tgP3MTxxWBCJY+0xtsI
	 qVDUQzebLfU17oHGl9LA6PONP/NuYsOL0waiGBSAvk0elRSX2QKi4unCYI4sy/OXnhWTp
	 ezSDMdQjnh6/KzXZSmK/LqM/YNRZQwonLiQiJolafvrDQIk8TOecwL5I3GyrTb8K36Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=BGa3AokV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.32
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011032.outbound.protection.outlook.com [40.107.130.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66624606A887;
	Wed, 11 Nov 2026 17:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66624606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=BGa3AokV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lvY20yreNFnA7SvUMKreH0C4kRBXbS+1bPhvpk8Sptyc1F/Kpm/zl+bD9av/xAb/KhfsTYmiMZP1AeY5zeDEooxwf2Wt7pD5Oxbkt8oVvAAuXgzBHqzE6rPukkbBVKA5QRlNYYfJ6LIS5BZjDAIefs1g5Z9QEJpLiGgPzeits5o7AZHsv77wZXzoU/Hw4ykbygNwdRtBhHdzOiHrHtlWj/4tDca2WD+6uuHZSL7igWwI8BIfu2+GOOWNUlZfLL1KEQweB8JZ5oNs1SjttHT517ZQiVSefDErowYXYoXpkxBuaY/CSm5XH8AdP2k3eF30q1AcOwTprR5CQ5leV4Ogug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkaJZSPpw4HX8tGoQuNeTOTO+g5PRUqg4PZdgIWKEx4=;
 b=eat1BMCQiTWEKkK2Db+l0XfiCD8RpfJ3KVDsv9L6HctQrWWamVXKP3YoCT+4zJtHG2NUR/fukh2tQxsDTsVCX13u3NhxpmsxwYl2Lm/BOb63wXNVCC3yvGYILb9SuwlPJ4u5VEPwsYChrFtJ0QQc3sVz+6NJ6EJ7whi/1hOA9J8i0mmTayauaddFvaw/bwW4sI2NdJOSchX6JsNG5RNTb/fJsx7XvzGXVaUPhvVQeqz0JbUib2MVl4cbi0HXTbQxOTggMMJ6ukR2B1qsfb+QjejDmCPTKGpZayWjlzRp+CMZBMuRXaCI2tgjkSucBJ+UiF1h7zD/6JwIC7CX8fP/+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkaJZSPpw4HX8tGoQuNeTOTO+g5PRUqg4PZdgIWKEx4=;
 b=BGa3AokVZ+BMlp4yH7sdqVwIW1iu0KgiSFlGkVMMig6920xZqgl21dAjv7iJTfcSLxzYpA6EAtRqW+gniseru10e/6OA2nrdpIc1bRlRduhD3jST7Acg6v/0udDuoy04poGGui0KpAmUVQ8VJiFYKa0o/QYwbtJ9tHk/jmW6u4l/CyhSGPIjOYvBMML27o9UbXlmJfg7EtrxHmw9ywJc/eRM5BuBK8qFhshwoqM0wrs+7aOKUgvNnftJ8njcpkDtATPD1/AjPbnkIKwYwogOeeMvFo1IsSth1EgAgF40w5xJTR7BrKDBJn7WfMfsKxu/yDnuJ334o3TbajAalvVsaA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GV1PR04MB10632.eurprd04.prod.outlook.com (2603:10a6:150:206::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 17:59:40 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 17:59:40 +0000
Date: Wed, 11 Nov 2026 11:59:29 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@kernel.org>,
	Larisa IIeana Grigore <larisa.grigore@nxp.com>, imx@lists.linux.dev,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-tegra@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v5 7/7] arm64: dts: imx95: convert eDMA to per-channel
 child nodes
Message-ID: <avStAcZcvCRfDinx@SMW015318>
References: <20261111-edma-iommu-v3-v5-0-2537cebe6ca2@nxp.com>
 <20261111-edma-iommu-v3-v5-7-2537cebe6ca2@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111-edma-iommu-v3-v5-7-2537cebe6ca2@nxp.com>
X-ClientProxiedBy: DS1P222CA0024.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:8:44b::10) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GV1PR04MB10632:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f3de711-a77a-4d2c-9404-08df401d8ea7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|376014|23010399003|1800799024|18002099003|22082099003|261009223027099003|4143699003|11063799006|56012099006|10067099003|261028144727099003|261022105027099003|261102123227099003|261021121427099003|261021123027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	ugENbly/dBR7GjD2am9e5K6dgtGo5UkQl8P8gHd2wJJqmyht0acIpm80xUN8Rck6UG+5zxCFaJTmSMyGJ6zjUvevKYM1oVoS2RBC18gX4KQkNP29/SDZn3zmMdQVrCgeCmGC4myTLD5SDakqke4GzqVd1oy2BSVD7PQ4hpFez28kkeUsWWRJqy4zYqRee9q1gsU3Glf6ABJPzkrzY+UR0AMaseIXjah/xise/+O8ecCP7tBapN8mwECBvXofx22MUbuQSM1OI5DwhLbJtHLeylGVPNglOrD97++WqPjwNeCDCOs/11ukzCANmT9yqjJt0v7mO7e6uOddr+EAk+eiZU14aw5ONsbS7mO+zwy9EOBgyvEH+YHDo/P4UMoUT9497tMhs0cAuC6e/psl1RvYChqTTPR2xAv17eAPozhiH9eTYoG/1cEYbvW0BfE5T0RrwnfMSqoqfd67jXRy3kTG3p7ed2MNAF0cK2PhVCwnYUC8qQkBulpPWxDIXPjBT9iCGzmmU1OybZtTTamE0Iiuj8N0ZIcfXUbgEiR0mazbzaIKaLoZ+LAeu+c/mOdzJdGuQ1FDlO1fbroU+HOcv+q7PcW1TU1pCdm+P5toFfL8QhIGKFm72ImMckUhoCh25DdjE2cplxNK1ryQd5q6weoX2iS7bU9qlTWodrb2AvLP9oQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(261009223027099003)(4143699003)(11063799006)(56012099006)(10067099003)(261028144727099003)(261022105027099003)(261102123227099003)(261021121427099003)(261021123027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CNnAaXIzMaR2unk0ofr9F8OkYTqL7XEUXLEFSkrrszJGD1A0f5p6IT7rx9in?=
 =?us-ascii?Q?14eUKCSFgZYvfuQl5Pc34/zeF5N0BeIg8Fw5nKKynMPVdwju5gewyupejEs8?=
 =?us-ascii?Q?VgCNo1nAngJOlOo0oaC14LlG0lJVnCR2Xa7iYuxQfEKHIHwx5Zrp8d9fsZy9?=
 =?us-ascii?Q?VEg38tsQVGWUmuZ0cyzFpr7OMmsw9Ero+PzRNwm1gp4BELvvxziicTWPRGQj?=
 =?us-ascii?Q?d5ePmcbOtPPzTkGXW1+xJumllSY3s79u+xAa7sAKkmbFMaCAoRGZvqEmAunJ?=
 =?us-ascii?Q?xHJFcGyeBb0PymOMXvxIlZe5V8WSg5PneJdXkjPQiyKs5UBd/ZcbDgahTjTZ?=
 =?us-ascii?Q?VkG21ycrZf2d2ZZ+OVOjDnt2cR1MRZNZFVcf2ZIXgyDjr+r6Y35BtBMiCJX2?=
 =?us-ascii?Q?DAzBa0Tamcp/XKLfeRWsJJ5+D5FFzABJsfnldp4E8prRvIAVqhWTfkBixSRy?=
 =?us-ascii?Q?SeudZdOegVfef+1gC3Q8NXSaMaUJ6P+ljuNRL+gwznJU7fKNC211Su7IZ+Ec?=
 =?us-ascii?Q?5z5UE7XBA8GegktS4Fs3IXh0zCHi6s5zHc/o6pmjEwq+VLD8p1CWQLbdLVZ0?=
 =?us-ascii?Q?fGSawCrg8P6bkXHDBTRKViVl+giz5mW96FCjMzwqKP0gTfwLAoynr/VNVo8R?=
 =?us-ascii?Q?MHTTvEHbraF2ssXiv+EpCpUnTGE/eihBahV4A6VfGHMS6GpO7bT3iKvpgdz6?=
 =?us-ascii?Q?J08d+bkvuk/1e4hGqbGqovnPFyiof8gC/iM8SYbOHRs9GktKpP3dsqa0YGEh?=
 =?us-ascii?Q?Db+jp0Rpbl66pAXaOqDm6p8aGi6MjlGRmZLD8lBPqkOXMqlL7LgGJ0WEiXHL?=
 =?us-ascii?Q?ZkoKFxqB5N3kBxxG7OY4J5ALtmUY+KcvlxhNuDk24tFDIvNCCn2XLLXoSQK4?=
 =?us-ascii?Q?g7lQL3qriZ2gNSBGcfMKUV+2CaXaXikWZbzwD2zeG7woJvevfBiuOOweyiKh?=
 =?us-ascii?Q?xs1y7rxA/lzhfLRBIXiHYZ1pUhBZmbdk4D4wI/fJ/ANNESPM+1WwdqVn0Kj/?=
 =?us-ascii?Q?NvD8o3821Fzd3bpTuf+ZCh77/fZ679Jdkx3wJYgEwGVtxc/BljuoPXlwLbOk?=
 =?us-ascii?Q?3zOt622lq2yjwAUxg4Jm9mA2RlJSfsnKtSF+NT6qLD8jPQuACjizblzICYVS?=
 =?us-ascii?Q?vmdRT6UEDK90mO6j/QivrmunxK4Z2ELfpVO3iiLiLn9SFCHBG09/ze7IsPJ0?=
 =?us-ascii?Q?ayO4M2rEpkX4cUqtp3koUl3d01JZEBwlPKVwi/K/ETEY/++R39QOPcwrMceB?=
 =?us-ascii?Q?pfhMeBc0IDthcu6rXddXMi+kvgKLNuKSdUtMsyggfR5E0FcykKerhEViOsGf?=
 =?us-ascii?Q?M2TbnxPLEr1oBx8Sd1xDk1ywijoew78PgmPSujMiqMHh5iKuPWFfVpEQ0foD?=
 =?us-ascii?Q?C0ToV6FSqcr551+lOjhzkAQXq7cxBy67O4OaB7AJvkXKOK6LammXx+pD5hFD?=
 =?us-ascii?Q?1kyI/26u3uwVNKmkH5jq8LKo+hJRVbwnuS2QjH4PceRDiorpvbSbCTt6Zsim?=
 =?us-ascii?Q?TApwrlH5h6Ond6XmjJ3+bVBwrQkz6ickTDrUEjXElsedfQ9zOEU8Ev9wJn4Y?=
 =?us-ascii?Q?OhRs+V6fyvHwh94u/H0bq5ifJJRxceNeXrXl0Hdug8Tce9RgtPUrL4mb4AmP?=
 =?us-ascii?Q?dNldvwmrzELGEUU5gkiWSeufODeByMDkPHNuKnATb7G4/CEd3rcu3X+h7SPg?=
 =?us-ascii?Q?SKDjBpgiIpS+YO4C+YIJZF4C7NM/sG204NjrQZk/zuCNSnLG7lEmGxIqg9hv?=
 =?us-ascii?Q?Kc8tQsg4togzzUpbnvzvBnWDAOQxw18tWumm8HD1hixDpdpIcNLe?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3de711-a77a-4d2c-9404-08df401d8ea7
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 17:59:40.3234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cuebu3vgK6i4Fzv/JKlBmOZwj+4h/G2A+2MKc/ovBkJ46T1Y1wjbt7GY43lmyZRFu0HkZ/7PdDG+MPoxov2C41oBnKu3SzH0etAwknsIu2/j57R/7lnT5mkX/pcPiQ8h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10632

On Wed, Nov 11, 2026 at 09:47:35PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> Convert edma2 and edma3 from flat interrupt arrays at the parent node
> to per-channel child nodes (dma-channel@<addr>). Each child carries
> its own reg (real per-channel MMIO region) and interrupts property.
>
> edma2 (64 channels at 0x42000000):
>   - Channel N at 0x42010000 + N * 0x8000 (size 0x8000)
>   - Paired interrupts: SPI 128-159, two channels per SPI
>
> edma3 (64 channels at 0x42210000):
>   - Channel N at 0x42220000 + N * 0x8000 (size 0x8000)
>   - Paired interrupts: SPI 256-287, two channels per SPI
>
> edma1 (imx93-edma3, 31 channels with 1:1 non-paired interrupts) is
> left unchanged as it uses a different interrupt scheme.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx95.dtsi | 774 ++++++++++++++++++++++++++-----
>  1 file changed, 646 insertions(+), 128 deletions(-)
>
...
> -					     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>;
>  				clock-names = "dma";
> +
> +				dma-channel@42010000 {
> +					reg = <0x42010000 0x8000>;
> +					interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
> +				};

where iommu informaiton?

Frank
