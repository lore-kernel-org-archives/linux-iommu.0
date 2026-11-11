Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794404561;
	b=ge+bhFx9TwSOdA9PeaNc930m0E0rK0HfK1GMN2aO1Nwr/CzZHiXn4EqazmlDlNZJtKzN
	 1H4BWtWumCtJLAFCYG2GVbIW600C9l8eQ97H76AMsGGiapNWIyxYjXB4Aq1aXf3S93BW+
	 Gwd58nPBLiv5Zsx/uBhHDMHidFWj7TUYryNVNVh8tPAwTZ+jUPYETHlUpLyWoG68dpkig
	 3VfXw+CqoGUPzgwNhnn4SE0eE+eQvpUelb4TocWTH98wAltvUZ3Ncms4lU7yIMsu3ENJF
	 fF+1YYiu7jGsoxgnuvOn9zw37p2g5YRXZyweOmsR4oKhN9Ry07xrrkzZlQmgtE1k7jQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794404561;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Subject:Date:
	 Message-Id:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=h9hO6aM87Hsk/4YfNu2SBKDq9gyEKSrsKR0kSRwoAG4=;
	b=HgT4gmzCkX/vd9xugU+nRtrYp3egek5aORZa8wVsrKooERG68PnNAdVXC9hzdMFqxvri
	 dbsIUE356SX8+rGtJFRyYGXEq5GO7zrYdWgmg3PCxaHQRpEuT8ZZK4nY1o7eRjXf+b6RP
	 WKByo2m7oC1zAPAGj6lUjCKbsl3PPsmXigRkdy5dO3gDSiHR6KjSuwwHsqip8P7aTKs0i
	 Zrew2PP06R8yqNNlv0dWTru58p5ya/+W/TiVHfxg8qiIDDyFhL8PfTizZ016zfPKqBOWY
	 pEhoVBVxFVhEpCM1TmK/Y55zRvcIGNNdcYmDt9cKuRS8IH5CqqwhiVoce9lqs2PeUbw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=knpaFAIT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.67
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013067.outbound.protection.outlook.com [40.107.159.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5B2606A324;
	Wed, 11 Nov 2026 13:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C5B2606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=knpaFAIT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SRYUPLoJXPFPsCvJvdn5hpU2ONYVDfCAVY7UkVPWmQid/A7260f3+blHmUwnjAAQeP0oEmhPFgXJHqehAVhbkw6TohZkkwpjniaLCbM0F2Zk7FALrECa/1ExAXW1kS1HDgELM1kQjp1HUoGVpBonckb1NtWYdFONCP/OKQdqYAK5Lwo5gGSvCYURs0nWNsTQebFUi4TzZA+lpWrNDsaoKCR2zmqVmYH4s6pYSdw283jLZhCPNjt6OrVYWvG+Q2Jb+AcHY9s60ctr/XoXgu99ezIg2MVkKf+Xeac9Woq8Utcx6rmqioHqbP7kWrm9ugRAcem1oM18JW2uC0YECgPtaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9hO6aM87Hsk/4YfNu2SBKDq9gyEKSrsKR0kSRwoAG4=;
 b=mL53dSmWyr//W6Ggd9PzfGf62O5at85GPAY+bzhjuLOn4oDguqWgf05h2RUWyugA7+W55aXkzN+X87y1n4TfHcj5xICDTuXqpOb+b+WsVFdt9U2L1ofnhl7p0ijk1XB7nUxiZWfdXbqKXA7syb6ETWapUsr7jnSf8zqKkb9OKjmppx/qMUYMor6bKlLIHvto2EPTgWjgvFB4bgRrtVYwZRpzHibueMB8QoiFV4CUFEDDnnY9EHj9dOU9eLs3VEQu7F7KnT9qgQk3CxIrD0H5ZkpGiNsvD6zZsc9FJNdLx4dqmWQkigd8vUJwuy8USvNqpY8eDLkO8T0TqLvpc94h2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9hO6aM87Hsk/4YfNu2SBKDq9gyEKSrsKR0kSRwoAG4=;
 b=knpaFAITR9xetWVQH1nR2gORVrjRbQyvgdADNrCPhRRQtmVfmcXOP7h9vt1ppvetDUDR473lDVQ473a2XGtOuBMZ4aZHQuMxOkAWJLfVI8uftc11FHkbQSs4f59s1BSpTCreIgWfV7IV3HNZckfkqPm3jlXWQPNins550D4E91xka1Js0NgPxKwizPexRqYQJcP9sV7GHM/2F85x3AJk5fquAqY2Gw7OLFHTMKDcqGCGjLttRvtGMLlV0emfBnCEnpuXqxef5Yiom+kSDYhv0k9SyTB/qUk6AttjaoUEI5kzjXLZplG2GRQ3XzN0f0rYV5z2eFOvOw6OEZXuKvdFkA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by CPHPR04MB721690.eurprd04.prod.outlook.com (2603:10a6:380:104::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 13:42:36 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 13:42:36 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v5 0/7] dmaengine: add DMA channel bus and fsl-edma
 per-channel IOMMU support
Date: Wed, 11 Nov 2026 21:47:28 +0800
Message-Id: <20261111-edma-iommu-v3-v5-0-2537cebe6ca2@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPBx9GoC/3WNywqDMBREf0Xuuikx8YFdFUq/oriIeq23NEYSD
 RbJvzfadWE2B2bObODQEjq4JBtY9OTIjBHyUwLtoMYnMuoig+CiSFMuGHZaMTJaL8xLJkRTlLJ
 My7bPIG4miz2th+9R/9gtzQvbeZfsjYHcbOznOPRy7/1zx3BWdRwLoao8w+Z6X5We3ni+GQ11C
 OELM71j1r4AAAA=
X-Change-ID: 20261102-edma-iommu-v3-22b673717cf4
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Laxman Dewangan <ldewangan@nvidia.com>, 
 Jon Hunter <jonathanh@nvidia.com>, 
 Thierry Reding <thierry.reding@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Frank Li <Frank.Li@kernel.org>, 
 Larisa IIeana Grigore <larisa.grigore@nxp.com>, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 iommu@lists.linux.dev, linux-tegra@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: SI2P153CA0034.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::17) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|CPHPR04MB721690:EE_
X-MS-Office365-Filtering-Correlation-Id: fa89e334-f79d-4e50-b1d4-08df3ff9a545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|19092799006|921020|260925021911599003|260925021311599003|260925022911599003|10067099003|5023799004|11063799006|261009223027099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|261102124527099003|56012099006|261026140227099003|261026121527099003|261028144727099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	jdHu4HLS1flN+gUiRjAypTBCZPd6tdFMGnEnbxdPXTt5ZDBTmCtIbF9bFcCnsRk5rdCe5sXZ3tHakzAewDVEa1rlPjGqOk18rS0EXoTMoAwV5RLKSWrDOSb9TmNzYOJ5Hq/JWkd3hvemJ9Xd0pFPJiAfVDPQ7NHH5/7UC+cY8iwy+jGQ76ume1xNsYb4WhaCn9g7I1pGqEsCn96WEXX6PP/yXpt/L89UFzsklr0d9tYSWieg4GGaxwSlv9vWGV7JUgExbyD9nrVfeuQEkA6b8bokLLZiVJsDJXTLmJNMX7pAJiRSi7Pq1/wE5DEW6emSQqZyJqCEWBJAHCNretPpnsXQED93Uld8UYpRnU9IXZwpPz3V1m0TBDxxZT0rvfGElVR2KmZb8b0Woi+F0nb3VtDkO2t7tM23ucleClJwgq0K2cTnYrWzsQWSy7lqKGU3oVXJi6FCTbe3X8KJdKmD3oNu1WWKkINyHu8qtgHg4lNl/dGloyqnPeVbZwLyjkXo/lyLTrpuJlIf5zI9zMi61dyNP32PVI3xPHjjMKQsFSZwmj/f6TdNWv0+0q4NyJAQXcagNQsaS21Y+ZOmNy/utwvhtef+wrFA0KMB07XY+bMXuKhH8ehpxcadR/zZA6+xF0fn+r23lnW1xlALyYjOHDU6mtrUs49bW3cIZhKmxL0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(19092799006)(921020)(260925021911599003)(260925021311599003)(260925022911599003)(10067099003)(5023799004)(11063799006)(261009223027099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261102124527099003)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnkvdENJQk5KMllkR3JDT28zaGJCK0NieUd3YWF2dmlTWUdaam5FdEFLQnEr?=
 =?utf-8?B?dnlXNVZsVnZ1MkhNK3d5NjVGZE5FeFM3VHpTS0lUNDU3NTZSbk4vVVRLNk5P?=
 =?utf-8?B?Y0NEdm16dU9tNFlkSE1iYUJXa3MxYld1aEJCdHZRaGpxdGN1ZVNSbllrYkc1?=
 =?utf-8?B?YjVVdHFkc01kK1ZIeTRkTTVxVDNMdGFJU1p4S1hPNUVOZkZuN1lvTXZTSjUz?=
 =?utf-8?B?OG5icXlBUDNSaGE1N214SWdoVngraEJVc2xpTDJRUUtSK2wxcHZ2V0RGaGtv?=
 =?utf-8?B?ekhxeko1L0dCenpjYWtKd0JEMmVxZk12aFhCdzRXSzNTRk8rMHlHWEJUNmll?=
 =?utf-8?B?UXFuVmlMd2taRVZwNWQyTXZaSmczdHdHblNwUFcva2YzeEg2SnU5bTlOa2JS?=
 =?utf-8?B?ZStZaVpCaGw0ajNYb1V4L2labkJ0NXozOWJka29PSnlsS0luSVl0YU5URS9Y?=
 =?utf-8?B?bUlac1hJTjRCOFBkUjlPUEJjdXlLRzBrRjVJUEl3M2dQRE0vQSt0bllVSERT?=
 =?utf-8?B?RGtocm5namQweDZEeVF0ckJ2S1RBdTdPcEI0eUw2WHljcE9mcHhrVWh0alJk?=
 =?utf-8?B?TUdaeE5QMXFGRXF5ODN3R3VOdldkV0VUdlFsK29BY0FHQ1A5bGd2N2htWlJ2?=
 =?utf-8?B?V01ESlVSK3FIbjBRZXcxeU9nc3grQUJpSXdSdjZkbVlybFh6RkN4V2s0YUlm?=
 =?utf-8?B?REpqQ0VHdzBid3JncjZPYkkvSWV0NnBqQ2RoanpLVjhNeXFMLy9MZGkyZHl3?=
 =?utf-8?B?emp6ejRhSzM3Sms3NlMwVGdaNzNNdnBrc0hSYUpkVlBRSmtjTTJZMElaeXhp?=
 =?utf-8?B?K2h0L0VwZlpkQnhHYUQ5TVRlZlpFQm5IMmV3TWVLR1k4bzF5b1FvZUt5V2ZG?=
 =?utf-8?B?QVg5K2tZcks0dzJtTzAzbG5lZ1ZVakFBZXk3c1FlMm9PaWpQakp5NFl0ZzBv?=
 =?utf-8?B?VW9ZdzQ5bTFxK1VnN0tVcW91YWhWTjVRbCtoSnB3RzFCSDJ2VEVUWmJPVTBL?=
 =?utf-8?B?eDJjc1ZLV0oxVEVHMXh3MUJkTTIybyt6aytTWVVHT3ZVWExNdzlhUFZCRm5k?=
 =?utf-8?B?cVhCckFNODhCb3Q3cktqblBPQm5IZWRWOVVUdm9zVkhGQjlieWduRFZyUy9q?=
 =?utf-8?B?VHpKV2s0OTY0Tmc1eEYrRGZ2Y295dWhmbFB0ZFhtMmpqNW5GajhzQm5JMnIw?=
 =?utf-8?B?Ym4rb0ljNkJrcTdZcFB4aXFhdUlrV1daeFZ5V0ZEK1lqNm5jOUlmTERrMTJK?=
 =?utf-8?B?YitJaXl5M3dWcWk5MWxWMUE5UUxBUVF1RGZ2aTVuVFRIYkg4dlBHaDFBVEMz?=
 =?utf-8?B?dTl0VEVsanBCYVVDeGhzT3hsM3AzWWpwYzBkZUh6WjNlT1VyRlZ0c2dFb1lq?=
 =?utf-8?B?ay9kY1BFa2JBTWdRd3NSbStUWm43Q2JKV3RXSUpoQmRSclk4ak8rSk91ZjlK?=
 =?utf-8?B?M3JSdXZyaTc2VWtMbkZ5THJnT0doMjJsd0JKaFR5NEttYmQ1R05GK1IraEV3?=
 =?utf-8?B?aDFnb3dGcjY1azFpZjNCRm9KdzI3VW8zdFVCTHB4OVArRFpTZFNZUUgvYVhi?=
 =?utf-8?B?RkQxOFpsWFgwYWpQY2thanJ0a0tSWm9kVXV3bEwxcHQvejNaRE41NHBsMWZT?=
 =?utf-8?B?OTlabUZVK0htdGUvTm1JdG4rSWdrYnJhRjhlQUVjRWsyVVhhYzVVWVFrcGk0?=
 =?utf-8?B?ektkOTFVakJ2SXJBY1hReTBYbzVEZGRqeU5WUDFNQllMODM5RnkvMGVmNnFK?=
 =?utf-8?B?ZHkzS1d1UGdIN2NiTEFkQUhpQ3JPMUR1dE96RG54c0dreVZWK3NRcVRWL2JH?=
 =?utf-8?B?bjdoSDQ3b2daMVFXS2ZjemZWaWFJVm0xTjRyZEhZN294alcwVGxxRklXMUU3?=
 =?utf-8?B?NEMyMjhIZHd4RlpjbENCUWMwNCsxUkhqQmhVMUUzTGFwaDNEb0c4L1RQalVp?=
 =?utf-8?B?UkdCaHFHY1NqZ3hwRmdwbzBBYVJROTVtWGZNQXN2MzUrRnBxQTh1SkMrSzJU?=
 =?utf-8?B?Vk9Eak5BdTNOYWtHeHpzQU9mUWduNlc5dDJSR0RlelZGMnhQUFc3dzRuWUFI?=
 =?utf-8?B?VXJYTjVRdENSUUZyelhsSm9NU0pIZjJMWm1ZWHBpZnZMN1B6MlpTYkFQZy9u?=
 =?utf-8?B?b25nc3luQ0d2dm9PbkVlN0EzWWRBWS9tR2w4SUp5UmpJUVpPSFV3VFl5dGVn?=
 =?utf-8?B?eG56UnVFRjgzdGFCT2NBU2ZwYXU4aFJhOEpGdWRqMlcybWxJREMvd1lqOWJZ?=
 =?utf-8?B?YklZY28yOUFwY2N5Y0Z1d1pzazJqMnR5SkxZUHNZamx2REJzcWs4WnY2M2xk?=
 =?utf-8?B?N2d6bGE0b1B4U2QzcmZXeHFldlFMYUNOQW1FWHovWVJuei9jMWJ3VGVPL0RM?=
 =?utf-8?Q?MLExEI5/Uv2xdo7bR1upD+hAs5VF9zdQIJOrU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa89e334-f79d-4e50-b1d4-08df3ff9a545
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 13:42:36.4637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rkp/MZEET5BH3ZBTMgfRfu9ab5sI7LPbgHuzHeZJrxrY+JeHD+2avq8SQTpW6e9SRrd90sQNj74/kf/ovf387U2hcJr9QeGi3nD3r5rrNFlsU5B9vcK/gxYKvo6gxekC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPHPR04MB721690

I used iommu-map for eDMA, but iommu experts rejected it:
"Using iommu-map to describe synthetic dma_chan_dev devices that the
kernel creates is the same kind of DT abuse from over here:"
More info: https://lore.kernel.org/all/20260917144804.GI3196566@ziepe.ca/

So I followed here [2] as Krzysztof wrote for QCOM VPU:
"Thanks Jason for context and detailed arguments. Robin did not chime in
yet, but from what I understood the DT-child-node approach will be the
way we should go here.

I accept above point of view and I am fine with this, thus Vishnu and
Vikash - please go ahead with DT-child-node solution we had some time ago."
[2] https://lore.kernel.org/linux-iommu/c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.org/

This series adds per-channel DT child node support to fsl-edma and, as a
prerequisite, introduces a proper bus for DMA channel devices.

The fsl-edma change allows each channel to carry its own reg, interrupts,
iommus and power-domains properties. Parsing the child nodes is
straightforward, but per-channel IOMMU configuration is not: the DMA engine
currently creates struct dma_chan_dev as a class device without any bus, so
of_dma_configure() has no bus to probe the IOMMU with, and the IOMMU core
does not have a bus notifier for DMA channel devices.

Drivers that need per-channel IOMMU support currently work around this by
assigning dev->bus after dmaenginem_async_device_register().  That is unsafe
because bus_add_device() already ran with bus == NULL and did not take a bus
subsystem reference.  When the channel device is later unregistered,
bus_remove_device() drops a reference that was never acquired, leading to a
reference count underflow and a potential use-after-free.  Using
platform_bus_type is also wrong: platform_match() and platform_uevent()
expect the device to be embedded in a struct platform_device.

A dedicated bus for DMA channel devices solves this.  The channel devices are
converted from class devices to bus devices:

  - the bus is registered early, before iommu_subsys_init() consumes
    iommu_buses[];
  - the match callback always reports no match, so no driver binds to a
    channel device;
  - channel devices are registered on the bus before device_register(), so
    bus_add_device() and bus_remove_device() are balanced;
  - the bus is added to iommu_buses[], so the existing IOMMU notifier
    handles per-channel IOMMU probe and release.

The existing /sys/class/dma interface is preserved with class_compat, the
mechanism provided by the driver core for converting a class device family to
bus devices. A compatibility class named "dma" keeps
/sys/class/dma/dmaNchanM available, while the devices themselves live on the
DMA bus. The uevent subsystem name remains "dma" because the bus has the same
name as the old class. dma_dev_groups moves from the old class to the bus,
and chan_dev_release is installed directly as the device release callback.

While testing controller unbind, a pre-existing fsl-edma ordering bug was
found: fsl_edma_remove() removed all channels from dma_dev.channels before the
managed dma_async_device_unregister() action ran, so the channel devices and
their IOMMU groups were never released. Patch 1 fixes that ordering, which is
needed to make the bind/unbind lifecycle test meaningful.

Patch breakdown

1/7 dmaengine: fsl-edma: unregister channels before vchan cleanup

    Keep the vchan cleanup, but run it from a devres action that is ordered
    after the managed dma_async_device_unregister().  This restores proper
    channel device and IOMMU group removal on controller unbind.

2/7 dmaengine: add a bus for DMA channel devices

    Add dma_chan_bus_type and register it from dma_bus_init().  The match
    callback never matches.  There is no functional change yet.

3/7 iommu: register the DMA channel bus for IOMMU notifications

    Add dma_chan_bus_type to iommu_buses[] under CONFIG_DMA_ENGINE.
    dma_bus_init() is an arch_initcall and runs before iommu_subsys_init(),
    so the bus is registered before the IOMMU core consumes iommu_buses[].

4/7 dmaengine: move channel devices to the DMA channel bus

    Register each dma_chan_dev on the DMA bus before device_register(),
    install the release callback directly, attach dma_dev_groups to the bus,
    and switch the /sys/class/dma view to class_compat.  Remove the manual
    post-registration bus assignment from the Tegra GPC DMA driver.

5/7 dt-bindings: dma: fsl,edma: add per-channel child node support

    Document optional dma-channel@<addr> child nodes with reg, interrupts,
    iommus and power-domains properties.

6/7 dmaengine: fsl-edma: support per-channel DT child nodes

    Derive the channel index from the child MMIO address, populate the
    per-channel IRQ, propagate -EPROBE_DEFER from of_irq_get(), and
    configure the per-channel IOMMU on the channel device using
    of_dma_configure().  Existing DTS without child nodes keeps working.

7/7 arm64: dts: imx95: convert eDMA to per-channel child nodes

    Describe the per-channel register regions and interrupts for i.MX95
    eDMA.  The iommus properties are not added yet; they will be submitted
    separately once the stream ID assignment is finalized.

The only user-visible change from the bus introduction is that the device's
"subsystem" link now points to /sys/bus/dma instead of /sys/class/dma. The
/sys/class/dma/dmaNchanM path itself is unchanged, and both the bus and the
compatibility class are named "dma".

Patches 2-4 can be merged separately if preferred, but the fsl-edma patches
depend on them. Patch 6 deliberately does not touch dev->bus; it relies on
the DMA engine core registering the channel device on the DMA channel bus.

The binding and driver support per-channel iommus, but patch 7 does not add
them to the i.MX95 DTS yet. That DT update will be sent separately when the
shared stream ID support are finalized.

I put all the patches in one patchset to give people a full picture.
If need to separate patches into multiple patchsets, I could do that
in next version.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v5:
- Patch 2: Rename bus name to dma-chan per report from Sashiko.
- Patch 6: Address the issue reported by kernel bot:
  symbol '__udivdi3' undefined, using div_u64_rem
- Rebased to next-20261110
- Link to v4: https://lore.kernel.org/all/20261103-edma-iommu-v3-v4-0-470415d418c5@Example.Com/

Changes in v4:
- Patch 1, patch 4 and patch 5 are unchanged.
- Patch 2:
  Register the DMA channel bus from core_initcall so it exists before any
  IOMMU driver can call iommu_device_register(), which iterates
  iommu_buses[].
  Clean up the DMA unmap pools if dmaengine initialisation fails.
  Clarify that the bus match callback always reports no match.
- Patch 3:
  Update the ordering rationale for IOMMU drivers that register before
  arch_initcall. No functional change beyond patch 2's initcall move.
- Patch 6:
  - Validate child register resources: require them to be contained in the
    controller resource and aligned to chreg_space_sz.
  - Use div_u64() for the channel index calculation and reject values that
    do not fit in an int, avoiding 32-bit __aeabi_uldivmod/__udivdi3 issues.
  - Ignore child nodes beyond dma-channels, so imx95-navq.dts with
    dma-channels = <30> still probes.
  - Use BIT_ULL() for the 64-bit chan_masked bitmap, including channels
    32-63 on 32-bit builds.
  - Set chdev->dma_parms to the controller dma_parms so the per-channel
    device keeps the 0x7fff segment size limit.
  - Use dev_err_probe() for of_dma_configure() failures.
  - Reject channels for which iommus did not result in an IOMMU mapping
    instead of setting chan_dma_dev = true silently.
  - If child nodes are used, require every unmasked channel to have an
    available child node with a valid interrupt; otherwise fail probe with
    an error asking for dma-channel-mask.
  - Do not fall back to the parent flat interrupt array in child-node mode.
  - Keep the shared error IRQ on the parent node.
  - Clarify that child power-domains are not handled by this patch.
- Patch 7:
  - No functional change. The out-of-range child nodes used by
    imx95-navq.dts are handled by patch 6.
- The i.MX95 DTS still does not add per-channel iommus; that update will be
  submitted separately.
- Board test overlays are kept out of the upstream series.
- Link to v3: https://patch.msgid.link/20261102-edma-iommu-v3-v3-0-9d0e62a954eb@Example.Com

Changes in V3:
- Patch [1-4] are new patches
- Add R-b for patch 5
- Patch 6: handle of_irq_get() -EPROBE_DEFER, drop the explicit bus
  assignment to "chdev->bus" which is resolved by patch [2-4].
- Rebased to linus/master v7.4-rc1
Changes in V2:
- Switch to add child node for dma channel.
- Link to V1: https://lore.kernel.org/dmaengine/20260916-edma-iommu-v1-0-e1731968081e@nxp.com/

---
Peng Fan (7):
      dmaengine: fsl-edma: unregister channels before vchan cleanup
      dmaengine: add a bus for DMA channel devices
      iommu: register the DMA channel bus for IOMMU notifications
      dmaengine: move channel devices to the DMA channel bus
      dt-bindings: dma: fsl,edma: add per-channel child node support
      dmaengine: fsl-edma: support per-channel DT child nodes
      arm64: dts: imx95: convert eDMA to per-channel child nodes

 .../devicetree/bindings/dma/fsl,edma.yaml          |  70 +-
 arch/arm64/boot/dts/freescale/imx95.dtsi           | 774 +++++++++++++++++----
 drivers/dma/dmaengine.c                            |  49 +-
 drivers/dma/fsl-edma-common.c                      |  10 +-
 drivers/dma/fsl-edma-common.h                      |   1 +
 drivers/dma/fsl-edma-main.c                        | 241 ++++++-
 drivers/dma/tegra186-gpc-dma.c                     |   1 -
 drivers/iommu/iommu.c                              |   4 +
 include/linux/dmaengine.h                          |   4 +
 9 files changed, 995 insertions(+), 159 deletions(-)
---
base-commit: 793807ca13bf3072fc6d16ce6d90e9ab9beff2a5
change-id: 20261102-edma-iommu-v3-22b673717cf4

Best regards,
--  
Peng Fan <peng.fan@nxp.com>

