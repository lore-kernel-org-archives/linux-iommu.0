Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794444749;
	b=tvXHGKbZEUttfGtddAV/BziitPifKlys5VM6WsAXaX8kOMh8fHSSifOaZHi4gAWB4wpb
	 H9fUBo1sI/ILD1GGD+R8SwDZ8UQYLXrATlL5MDLPW1Y7masB+XVlax/hSGgdhWw6c2bfq
	 THpFmXrp1mliKM/0fjTSJk/ZAZCDUuZWaVv7ftTM9SqaX+3UFQaQhn9P9cuS2DrYrRaJL
	 EsngdPBlRQq+LLyVQ8AE6nsq4EBvDgvEbKiPbMU0NoHhPV9ykHy4mrISZyzzgdkwS1NIz
	 ECxipB+/DZ1ywhCyTelIUwuxK0kgM5imaXbPOdszauX0SSi9plfS340yBQGJthqCx9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794444749;
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
	bh=c+2q7v4zk7sUEO3AP+fJXIMJIKsmq59pOCIkKtKvzIU=;
	b=p59Ymw88dbArr7QW5f2FBW5YSSddhkstVIjt3OCMqWkQ2yr4bcL7f12AWhh+IDcDaudZ
	 V1AmYLzk1tdAS8NCSibHYf8jmbj0gfEAuGkR+2Rx1V38N8difpSQ13KAd963keGyHl2b0
	 iKP8cnsGbTox+vD3AUe0foQ7qpAUoP2ZBmWUAjV2S78s57ROD6ICqmzhVU7SANEtQPDIC
	 HniqndvSld4fKB3UGVo2E4e79pi4+asLC2PfXzF9nv+5gT7Yd4DCMOCeLy9XzuA5J6NHQ
	 fKOezX4g7KnB38hKYmkYzuu9vDtteFnhwFQQ7oQ/8qIdiNcCSf+wYHTHmOtS5l6bW1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=LIPnamAG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.42
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013042.outbound.protection.outlook.com [52.101.72.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FC3606A330;
	Thu, 12 Nov 2026 00:52:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7FC3606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=LIPnamAG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BgE6kSC/K7GMWKF4igQ31+Y1ACCt7vgXERMfw3tJuItPDUKf2m7jsHmjFiGX4s1hJ7KaKWMCS9q+FX+LCUVAdksm1xqHKtcgcDBFrrk1pAGQU7Fe1sRDQc+bXT1vN0R4d5Ukp58Ft7llWu7ksv056wm3kchg530/jz5Xzz1VPnPuqVeOqusA3HeG8dMuw0NCBu9n5+S1DB49sq29W4ns3dlGan3ndoTjtXsppFEw+X0I16fTbmeg5kHcVh9LF5KvdwEELQud51w5RMOV0oPXWLFhkt8hfLGm1ucdjWu8LWInMzg3iEPUr/RoHK3jnlTve1eQBshtSh8iEjd0ZmaNlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+2q7v4zk7sUEO3AP+fJXIMJIKsmq59pOCIkKtKvzIU=;
 b=UNK06VUqif+aAJjCifoZi0hMr+8wm04v0RLNde0ctXp2a2MyfZOWKDbEW1Kp1hfyOP/DWvDTapMROV8ylJANa38r0SCAL+QVXaPlFzNSc8iyYsOnhRvw9GC+ECPnWBi3hIkVuTYMFs6Dc5MJhw437W4Y6gd2naLb7eRzhK0rne5JEyUMMbE61Q+kmUuKeX/AGeqFVBzC/qRA4DEGWqqZmRu6OvrljxWLzNwTE0aBTVHQAnTlpVJses2/+kDSJU2aiDJmbVOoSCDwcXcAmvcHqOh7qYTN/BjM2qsJN8cJKJFme9T3r0PNQ19m1MorqI8gbA32TlLF3QhugwmJ4ha52w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+2q7v4zk7sUEO3AP+fJXIMJIKsmq59pOCIkKtKvzIU=;
 b=LIPnamAGBpxU9n/8QYpzh0rkD4ZAQZStK/3eWM0MlDG7mFFk9mdFeu8EPX3QMve6TZ8BGEuLNSttb2IcAish4RHdE51887qxUoLVnb4UKL7e4HfHdGRZeeJsCUqcy2u4eBDT+90QLnvK5Pe4p07R1e4K0JfVd70qn/9Z86gPgHgj16tS7RxTE2PAL6DGvvsnnPXKVCwvIlGnTHDdYNqOh1cI7hfW0LkuOqLPGzr9B7dK7DHYZX7IbaihyksjVr3E3G1Xga+tLcr1vmHjNKx4YsEFCVxscaOMvf2OMunoYWzBH+BYAgcxHnOPQVFOOKHvg4iz199zTfCuO+r6v9omeg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by WA4PR04MB775339.eurprd04.prod.outlook.com (2603:10a6:1d0:2d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 00:52:25 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 00:52:24 +0000
Date: Thu, 12 Nov 2026 08:57:20 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Frank Li <Frank.li@oss.nxp.com>
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
Message-ID: <avUO8DSIP03qpTkS@shlinux89>
References: <20261111-edma-iommu-v3-v5-0-2537cebe6ca2@nxp.com>
 <20261111-edma-iommu-v3-v5-7-2537cebe6ca2@nxp.com>
 <avStAcZcvCRfDinx@SMW015318>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avStAcZcvCRfDinx@SMW015318>
X-ClientProxiedBy: SG2PR04CA0216.apcprd04.prod.outlook.com
 (2603:1096:4:187::18) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|WA4PR04MB775339:EE_
X-MS-Office365-Filtering-Correlation-Id: f3ba3f1a-8d6f-466b-d610-08df40573772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|23010399003|376014|366016|7416014|18002099003|22082099003|11063799006|4143699003|261102123227099003|261021123027099003|261026140227099003|261028144727099003|261021121427099003|56012099006|261022105027099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	up6I7xbTWMQb3eFgws04VpMxi1GEExFoBsciFNfvfuwFWYspCfXB5rKtyYp363qEi0NoR8fy7h1tkhTsw49HQK1ULSp7TjPt5Im0CukP2OYWON6iUupUQ4Rr8hSJ0z/JgzUsCa3MThuD3bK7VGsNiqRmbq4s4WiRlygKgXjpgLobdmelP7seDPuwy6coBU1QmwIkFl2t/6Dg4H5GHOuOGs4IddHsyOjyPFV9XzqLyIcI8tAXgxeC6+v+73tV5OVQ77xLGrNiN5Mu5yPooS0NEtUcCkJeZftov9Ah1+ZGxhMgP9Lc3N0J9wHkaze9gqSDNwhcSwFpQX2BbRUcK2ixREr1ZMOFtj/iryhk9uIq1AgInzHCTAF288+kiyWkXrMFOXOpP5UgKXl1AeT9Z/YbqYblVjWL6x3XJKR3HwEwV/BjEa6MZ9eWb+UiNLMJdB2fzJviKWRlgyWTquyRBN6k4iC5Vr32BCUo5umXfp0CckRC3LubHuqaeB/tXlAX9bWKd91B/YLkcX4W8ALkqUX7bAIDIQAxzd/II+5UL/U9bZhzCvUikvgaEeRqrxJx6ZHiKAnj+JiJvC0eVQDIZTfc4GmGg9kL5YocgwRDZoF8m+8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(23010399003)(376014)(366016)(7416014)(18002099003)(22082099003)(11063799006)(4143699003)(261102123227099003)(261021123027099003)(261026140227099003)(261028144727099003)(261021121427099003)(56012099006)(261022105027099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6eBHEWqh+Nc6uoMftBr+F6aIl3SnjLe5M8LcqAtoBna66btN8lcpZWjPVNzP?=
 =?us-ascii?Q?8Uu6gJJpdAEfgaqm7eWTBiPFEOtgITRYOLrI2DA39WCuiIM7c7auMp/q6XA5?=
 =?us-ascii?Q?UYVDqqSVI9ZvsL6dZPWQiaLPq6x1tbrYQVhCjAZ8IqFTx6Fx43ikyI6lIi6C?=
 =?us-ascii?Q?fQcNK1ztgNw3234FuqTsFYvU9PAvOcVlCwZPLLVQ1JVMFRy/ZreGkamYdxNO?=
 =?us-ascii?Q?xcY2iUisZdA3flLCPDFshG528Nn4kVPf/vNHGKrHAXktn1ZBdMTJBBUT1gsv?=
 =?us-ascii?Q?cUvT4WxrWr4wqpKhwQrqHqVkWcyXX0DMX6HBwUWqf5jhfJaAn4Vw1GikLhpP?=
 =?us-ascii?Q?feaxW5/q/zCazitr0CS9pKRzDP88XUIyNUDKNhLwpBGAX258Uo1iQM/6X0J7?=
 =?us-ascii?Q?WF2gQzFryQ3oKoM0j8J5pAHy3iZ2J3jLBaUBI+8rCtI8kdo1KwWsHNPQZue/?=
 =?us-ascii?Q?nQpqaTcJRwRWiibRuHxj8blsfJJjhaBFUFT8KBsLlNdjfSsJ7l/GGpq6DaKg?=
 =?us-ascii?Q?1UVRVywvmIIOo0p23Xav2/Pqi9zQMphdhAREdQJtfmlcUttfSLXxDCXjTjCO?=
 =?us-ascii?Q?2S/eTZzxN8ZJXhFaqqFqpGQj5MipwnGW234P3L12sonJ3RUZtfOzCDSFaY8J?=
 =?us-ascii?Q?MVf05SmjxhyLyIjHyeR20YEJGh+bQA8v89syKjHaAdipHzmQ54nRsJyvpfJg?=
 =?us-ascii?Q?MG5O6VfdCLxrogrvcyo2kTCxlSbD0Xej59KPx1s4JQhKQ23Nx2JnAt8jNbVD?=
 =?us-ascii?Q?nv7tGw4p3LMgNwHJA6i3/+F59fQkopxm+GILKIotfk/YjVt8jDnCaZ+Tmrg/?=
 =?us-ascii?Q?i3ESzYk1Zhp9z4C1bZAMYSNYqQyEMLnbIE/esgzw7hgtHBFYsFFgiYdubov0?=
 =?us-ascii?Q?y95J1+tnCOYYLU13creeulGVm8KwU8Raz2lCnvWV/XfYzTsXPJeYw0BaK6GO?=
 =?us-ascii?Q?yNzqV/Zv2nEpi4sKTfjp8LgmH/+Z57W9VwyWC32RiGX1+rpumg2Gm0EoNoxJ?=
 =?us-ascii?Q?R4MgFvtONUmeQrppmIGajH8OgpAkxQUTJdTJv7TSpNkmqQ9xVxyfV8ymrCEn?=
 =?us-ascii?Q?HNkhC+H9iofEej+WErdFeXZzK750HvWS5vMw6hcyevDnkEHQyHSZJV/Tzcdv?=
 =?us-ascii?Q?M914ynwQBH4iQP+6wrx/8KcCMddCA+d2zTOBdIYc7eHjh7C8bp+NIYBNbRp7?=
 =?us-ascii?Q?3peFLJVqRUjyPqH2cvzzz6mHemM8xxgQiEtgx9ZOYIU8Xud7oMV4HtgFY03n?=
 =?us-ascii?Q?QNnKC07QCU9l/WSJNIkh3JEVMCuXH/haX6aBdyNHjYefJpcnj00CnP27oFXx?=
 =?us-ascii?Q?/n4uGBAwNxRTtNKwHu3YbgGoluS/mNwuU2DTGO4d3GGKlbOOdgKGJ54HBcIt?=
 =?us-ascii?Q?SCVgXeRA6eKAo8Blz+hH5eio0Nv7g2TK5VQSCYsojNUNiCulpVEma5OX+dMx?=
 =?us-ascii?Q?SdCYWwRk48YIgNu78yoI9oTFHMZuk3fslloeVV7q9tjMUwaohMZGExYfyTcm?=
 =?us-ascii?Q?i5O2MbvXR/j7DSdhCqYofxvpJkEAkZmV0a0GsJvi9ECkfxRBGBCk/TmekgSe?=
 =?us-ascii?Q?xCz9zgbAtKdxE/kYcSkxHWJdLovHaGZUu8QvboC6BV+l4rWPs0haw3HW88Te?=
 =?us-ascii?Q?z/OemyJG0TKSb1is68g6hBxtcJi6QK5c9ZPeIyHnSBEvPtjV0dZGL8T0kyjC?=
 =?us-ascii?Q?0tDO258oNPXM35JiphGe4H01m/VG4JGYbCdFD2xLQp/ieekTYl+tv/fIoXsR?=
 =?us-ascii?Q?1iG6jwa3NhsuqtgUddECubyvqBUm/rhrRhIK5lcyS+TGCgQ33Dva?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ba3f1a-8d6f-466b-d610-08df40573772
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 00:52:24.8066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3lLwbt0nwBDPluuvC8sPeH1wFqNBZTUx4JttmvujYgjr4aXHlPhG2F83Kb4P7zsZgyHBXxR1ZYxN2Zn4+LPsQx8aTHgyiC2b5uhybExCnRy2EP7m8A7rvWWxIBxsymZM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA4PR04MB775339

On Wed, Nov 11, 2026 at 11:59:29AM -0600, Frank Li wrote:
>On Wed, Nov 11, 2026 at 09:47:35PM +0800, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> Convert edma2 and edma3 from flat interrupt arrays at the parent node
>> to per-channel child nodes (dma-channel@<addr>). Each child carries
>> its own reg (real per-channel MMIO region) and interrupts property.
>>
>> edma2 (64 channels at 0x42000000):
>>   - Channel N at 0x42010000 + N * 0x8000 (size 0x8000)
>>   - Paired interrupts: SPI 128-159, two channels per SPI
>>
>> edma3 (64 channels at 0x42210000):
>>   - Channel N at 0x42220000 + N * 0x8000 (size 0x8000)
>>   - Paired interrupts: SPI 256-287, two channels per SPI
>>
>> edma1 (imx93-edma3, 31 channels with 1:1 non-paired interrupts) is
>> left unchanged as it uses a different interrupt scheme.
>>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>  arch/arm64/boot/dts/freescale/imx95.dtsi | 774 ++++++++++++++++++++++++++-----
>>  1 file changed, 646 insertions(+), 128 deletions(-)
>>
>...
>> -					     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
>> -					     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
>> -					     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
>> -					     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
>> -					     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
>> -					     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
>> -					     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
>> -					     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
>>  				clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>;
>>  				clock-names = "dma";
>> +
>> +				dma-channel@42010000 {
>> +					reg = <0x42010000 0x8000>;
>> +					interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
>> +				};
>
>where iommu informaiton?

The shared stream id patchset [1] is still under reviewing, so not add iommus
property.

But the two patchsets are orthogonal. This patchset just needs [1] to test
shared stream IDs, otherwise stream IDs will be exhausted.

[1]https://lore.kernel.org/all/20261030-smmu-shared-sid-ver7-2026-10-26-v7-0-961726ebd6ab@Example.Com/

Thanks
Peng

>
>Frank
>
>
