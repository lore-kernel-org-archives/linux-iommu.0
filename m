Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794798064;
	b=fv/tfEgheY6dKLaS4YhpyPILE0uL56FWpHTjY/AYINpAYMv7M44WdNfWiIQzIlvpTZNx
	 OM4H4/xvtWfuUbcOI1wlNTMEHg159PS14+CRdqdvRpOAjRJM2bdDB0u8i5yl/LhWAZf0+
	 f1h6M3wwBpBJx3IorVRsCi6xJbcxiFASlfY/0uzBlwaT7e35EU5Z5IJ3LlNsuVLugAbVD
	 Sg7xUq0PjT1RYz1I2R1HW17YGY71cvugtgc6az6mvA6qC2uV2IQQtrxjdDqyFkp4yWIDC
	 AClCeVjYaC1aRBpdhGDfOl0l1gYNwMOAvzriUhN94Wun652FTpgTybMfdxP9fThogBA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794798064;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ClientProxiedBy:MIME-Version:
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
	bh=m8ym+UYmvT8FDZT03gE/yrhsKKedLQtj9TsIenPnNdM=;
	b=aP3piaZFU4GgvJI4a8Fn/fzVR8s/dcm6UncDOERujxC929Z8K3Ux+Dc1VIOpfGynwwfP
	 /66sRFb2nMmqbhLwoL7hN0OJbdiLSKY1qG0096woewyaHtAWVtXa3tE1ddGA6NpsGf/Zv
	 xiFFQ1Yj1WbwcyoEnzFNvwL/2KeG1bhgTQEMRbU6PgsnbryXnBlX4sOcpbQap23ggWgsZ
	 QX3To3QtkaXd1grpveZBdcCleOgHyjf5APeco/le28mfY1BL6DzjGlTD22LGYcVn4lG/7
	 WH8hLVFSa9mD/bSyvcMNXeo4Hh6ZTac2APCtBfxcDR/YgnPM4GbcCo9ZN5khmguMDPQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=FCw7tljP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.42
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011042.outbound.protection.outlook.com [52.101.65.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF765606A334;
	Mon, 16 Nov 2026 03:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF765606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=FCw7tljP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5uN8mhRqIyS9ZPpwqCf2kR6rKXeDtf+LPDVyTH8whVa9ypdv5SM151TlLEHWeq6KqrLvFDjPHs+6jzGfome6dGpinKYv/lXxlCl6T9nmnTWl1srQU7VG8v6m8/gTxfVzRdwtMumZ0xwiqerEPiAf2+32tgjiS+okscYF+XAfW6QM5V3ktsiHhlNMnv0soC9hPmo64svndt6+hlOIrW+Z9TQwgzMJgND9YWjLmCf37urFfm8T7zXa3i14x5Zj9ThukahheGR0zIvMwes/+eeA2BczDq7hVBZiyAASwf7I2mZRTB7RIGYZrp4d3GuxlpcTCxSWG8pkqvWfs6ZzZNoJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8ym+UYmvT8FDZT03gE/yrhsKKedLQtj9TsIenPnNdM=;
 b=D7ZT8cbfunVwkJ75iA7TZBxgSD9/CxLHgV5WRvrrJWc2qmoTB8RuqaiZyEYtSo9Qh34wgvyBZd55hZ0z4RNTETIn0ELl/OcVPM3DRbAoCcRWadK6osT9+793kq5NkSJmZMMaU43FNz0e7cnKZZDZKXnQ34yc7BUwX7xWc9edA9e+7abt8+XIeShZN89Vf0nvn3WT3YEBI4mkoZUuHrUrcPw0JvhvAHvXBsnxamSeu52Y72/c0xYlCCZVEREcinioj6yWW362Qt207iwaPV2aDRHOI/NPMVDYQdQbx0+kxFQ8boT1lialW48yJZxoXaVN3CS5S7HZOa83rkjJb0MMOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8ym+UYmvT8FDZT03gE/yrhsKKedLQtj9TsIenPnNdM=;
 b=FCw7tljPDSbHc1+EdMLGiM3hZN8ydmb6zolFlIvYlddclTWT2zvPSI5uzfiXh6/dqFnn5EQI2MCLn6hqddvD3sMFnhCvjTnUpAEF1eJ8IG7dxKt76WB0hFoDfZ89GrtBYhAXEPRF/7RgRfqrRXnR/ic+pJwEVPn9eFwhIzEDzuhSW/OZO1NT0e00G3bEeXHtgXt56A0Wu+p8tzIhHB5vVc9yR16QuXaIrBoY3mCzWlx8gsuJZUxCl+3gYRX0XnyQ5Q7YN79f9gAxjhrpHFgd/tLrBgMqxNwtFhch8hEpGmVIkIsThmEQvI2wgweEfE2xAB6XyRkWK/FdVAhNBqCJ9A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PA6PR04MB11778.eurprd04.prod.outlook.com (2603:10a6:102:525::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 03:01:01 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 03:01:01 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 16 Nov 2026 11:05:26 +0800
Subject: [PATCH v7 5/9] dt-bindings: dma: fsl,edma: add per-channel child
 node support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-edma-iommu-v3-v7-5-32794ba8efbf@nxp.com>
References: <20261116-edma-iommu-v3-v7-0-32794ba8efbf@nxp.com>
In-Reply-To: <20261116-edma-iommu-v3-v7-0-32794ba8efbf@nxp.com>
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
X-ClientProxiedBy: SI3PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::13) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PA6PR04MB11778:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc00f69-80aa-49b4-297b-08df438dd874
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|19092799006|921020|10067099003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qFFb12dRV56OuNo7S30lScVw3onuzu9iLSxTEq6pd05x7cEkaV+uyMtpXXeiFzCxiB1lMKrRbvLd0lfej5JMBzrBHisYyUx26WrS1gbDJy4YmO8mu7uWk+v82erAi+EQ4y3Av/g0Oe3Iyz8+Ysqq5VXFzrpY9abh0P2WPd7jj3EWk4jKrCiljQ0jyqSiW9p8l/1V6tatELIOgKnZes+b5l0QKP5Dkl4pFqBk5JyRI5KH+nfn6JgjZzmVuJr23QEcumA9bef3vUYia6t2HZthz8f9HEuyKxCRtIE6SozD8KbwKGY/8EUH7mhiVfkLx2WbQm6XLCYMAiHOC9p95fUviUY5wGpX7kicfUeXCI6bIhyReepe0P5UZbi2foN2dwDDJR9p2SnOXW/7g730ZXV5Cr8rZQ33tzXpIYKsxvuYizxl+fUVkIFGq1ANoAhO1+GMFcrI7oSxyAgBGm6oTuHoAsF0bO7jSsX5ZHEUyOpGaTovRJFCdwuruzTPkMTu4ahi1/LqX9IIAugsihwZp/1WQRjoIsT5ak/9nbT1NXb8p2KMbQk4X7kiCzW/NM+rwgz144XCDeQp2PqmfwAgJP1BUv6vxOzZM4EzcZB1evEkaQ1a5PjYR2z3Ks0QgnWdoMSHKvcjEndXsWd3cJ7Bw51O9xG9z5VG8ktMZW7XbTLPuVPzIKXydY60lkg36SyZCrMEvbxZNIawghX1L9ndyjVeCA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(19092799006)(921020)(10067099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1RQT0U4cUt1eTNyVXFYcFZrN0FRcXRBQkNsRUppeVJuK1RsMG04K2NxOHZK?=
 =?utf-8?B?VlNBd1FJcTJaWjl5eUpwZE5xRERNbUtkeHpSRW53UDZvQ3dUNTJXZjhCMmht?=
 =?utf-8?B?dlgrSWVkUldmVkJUaHYvOE9GV1hWRFBqT0VtT0dRQ0FtQ1RXTTZsSE55bDJE?=
 =?utf-8?B?VzhwU0x6MW1MTzVEODVVaC9mVi9WeGFsZEJsOUhwZEtybEhUMWhvTTBrb3Ax?=
 =?utf-8?B?MExhbnVtQXVpamxscHZRNk9xdzFtamo3TnF5NERqY3ZkOUlSWEsweXZteE1X?=
 =?utf-8?B?V3d0elZoOXdNanBWWkNySnBCZHRmVTN1c0p6eXJiOWFOVHkveUR2VkZNYVRV?=
 =?utf-8?B?dkVYT0djZmVlTzZodDBPKyt4ajJleG5wY2ZtbldrUUs3V3VvbWtuT3BjTDRs?=
 =?utf-8?B?ZkdIZFVqbFpSK1A2U0dQVzFweWtkd3h4dVIyQ3YvQzFHdVVJSWhCbnBJc3l0?=
 =?utf-8?B?TEc3NERocC93OElPZXdKUDVjaTNMMHNmU0xzdmxLTkZjd3dtUWlQVTVERWtU?=
 =?utf-8?B?Z3c4MVBlUEZSWi9nYnI5bEYvRmZkL29qL0Z0Lzl4MWxuRng2T1FOUjFrUHhp?=
 =?utf-8?B?WFBxS25QNVJ0aGNaNzlMVGJMOU1ROCtIQkMvemVtSXRJNjFWbHgwQnBOWnZh?=
 =?utf-8?B?NE55NWZMRCsvSDZJVEF4c0xTaXQ3ZkdHQ2N4cmZIdEd2RFB3WWgyWGxQblZu?=
 =?utf-8?B?aHJOOVVSNHFMOVlheCsxTmhFVGpXd3pEbnlqZkFkd3lEY2p4R04yMG5KU1BW?=
 =?utf-8?B?Z1cvTlF4YXpDY3FoSlRKMU50bFZhUThHV01EanYwZ2lzWEp5M1ltU2R6dktw?=
 =?utf-8?B?KzRqVFd5WTAyMTlJVnpGWlQrdzJpM0N6eWxBU1g4R3NzZk5BYkErV25URE9k?=
 =?utf-8?B?dWRGZGpIZktQYWxLVHZRTk1HejRyN0FreEI2NGttYXViMzNsUWZEUThDWEtB?=
 =?utf-8?B?ZExJWVFxM0VVbWhQaXdJVmpxRjh5ZEdtNHFOWko4ZG15NXRvY21STHhwazZC?=
 =?utf-8?B?eVNLa1pRNGJSU3QwNFAzT1RCZGdLdE5OK2Q2dnd0eXg2MlpYWG1lMU1Xb2Rl?=
 =?utf-8?B?SG5VUW9WQWh0a1RyQy9rb0M2N3ZNTEoweExMVXFyWWcvU2N6OEJpRHlBNFQ0?=
 =?utf-8?B?VnlrYlBjL1prYWtRcXNvVUExTjh0RHo1NjV5eGRyZjlrWWVYM0xrM1pJM3FG?=
 =?utf-8?B?bG81dGNjeXZoM0RUOHlkWkltMnNJZ1B4bXByd0Nzb1I2VW93c0dSb1hvaUVl?=
 =?utf-8?B?YnVpUFZBcHB0ckNibDFoczVnbE1XRlBUUjNwZFZmcndzcDNWeGZDQzU1RGk4?=
 =?utf-8?B?d3hJUXcrWWl2WStTV25wWGRGQVcvOFBtanAzS1E1U3hjUDlaNUZDVURBeWZr?=
 =?utf-8?B?NGpsTnZOU1U3VmdnU2N5UTRaRzc4alJUanFjaFNBRGhLQWNVcEdmWTVkdjJR?=
 =?utf-8?B?Z3J2UW1qV09wdkY2SFJUQ1FVMS9xaDNXcW5GYmEyODVVR3E3YjNNZHlWS3Zi?=
 =?utf-8?B?MlVDcko0dVg2bitBRXVFRHNxdUF5YmJQbE9CRmhkY25YRExuMzIxY0x4V1o2?=
 =?utf-8?B?ZDhzOStjYWx0bmpYL3FVT3MvN1JqaHlHLzBSbFVyN0lHOVRhSlkwK3dXUjJq?=
 =?utf-8?B?dmFwY0VUNHBHRWlrc0NDclhtUnFqRlNRYmx3UXZQbFVSajRMYUw0MjNCNzBZ?=
 =?utf-8?B?dDFvMFJEc2g3QWp2ajJQREp0R3Z5bVpNQ2VoaHVPR0pHWi9IQkg4bys3V1Bl?=
 =?utf-8?B?T0ZLbGtrczhseS9rQW1qRHJHdGV2VHlaVHhUMENVbnJlYVZhM0FRSWV2QWxI?=
 =?utf-8?B?WWtiR1NXSlVNZk4vL0Z3VnAyKzM4c2NweWRlVHBRME14ZVNuL2lXUlpxR1o2?=
 =?utf-8?B?aXRyM1VodUQ0bitIT2lNQVdJTFljaGJJZmlHQ0pvQ1B1bUo5aDFTMWg5L2E3?=
 =?utf-8?B?Rm9nQ01iWWVleUc0TjRrMWFTeG1ld1BGM3dLZXo4a0dReXBDUXBqWGNyanpy?=
 =?utf-8?B?ZWdHWUpYR2tnZEJtZ1p3MFRaWG5qSTc5L09CM213Y0E3NDFhVWZSVGxHcWhB?=
 =?utf-8?B?QkVaYU1xckRqV3ZhOUxvR3huQmcxTEREZnFTLzgrNUpvU291bndNZVd6MHA5?=
 =?utf-8?B?eFBiRko4d1A0VHdlK3BBWnhoQmlFVDNvc1MycFY5clRQR0I3bkV4Zys2UjBz?=
 =?utf-8?B?TnBaWTk2MnZZZGsvcTQ0Q0p1cStpU0xJR2dPcVJ3am5Md3orNVdBdkVoQjh3?=
 =?utf-8?B?a1IrdHNSNVgzRE0wblFtMGZ1UUpCbnRvT3hxMkZ0NnNVUjM5a3lNdjlRTVJ5?=
 =?utf-8?B?R1pGYVBoeWNqUFJxbXdFS2psVG9PVityZ29zaWkwTTV1NGJhZ28renBlSlpp?=
 =?utf-8?Q?dCrt2hxSAeTerxrIXxBZiuzChjgEg7d8hDyFq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc00f69-80aa-49b4-297b-08df438dd874
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 03:01:01.2081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GfqOYk6J5TCJJvmpULsz2msWMNm21bce3qhuwY8efSM0Vxbnd5F7P4mmUXPEOPJU1VxovCByIeNL5gIdmgE7/Ztg0z5vwIrOVyqQu/OK6EDjOUPKart1eGHZdY/jXJMY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11778

From: Peng Fan <peng.fan@nxp.com>

Add support for optional per-channel child nodes (dma-channel@<addr>)
to the fsl,edma binding. Each child node can carry its own reg,
interrupts, iommus, and power-domains properties, describing a real
per-channel MMIO region.

Enables per-channel IOMMU stream ID assignment via the standard
iommus property on each child.

The interrupts property is removed from the required list since
channels with child nodes carry their own interrupts. Existing DTS
without child nodes remains valid.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/dma/fsl,edma.yaml          | 70 +++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
index 0260d177c7d0..65877e78330a 100644
--- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
@@ -104,11 +104,40 @@ properties:
       Bit semantics: 0 means channel available, 1 means channel unavailable
     default: 0
 
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges: true
+
+patternProperties:
+  "^dma-channel@[0-9a-f]+$":
+    type: object
+    additionalProperties: false
+
+    properties:
+      reg:
+        maxItems: 1
+        description: Per-channel register region within the eDMA block.
+
+      interrupts:
+        maxItems: 1
+
+      iommus:
+        maxItems: 1
+
+      power-domains:
+        maxItems: 1
+
+    required:
+      - reg
+
 required:
   - "#dma-cells"
   - compatible
   - reg
-  - interrupts
   - dma-channels
 
 allOf:
@@ -351,3 +380,42 @@ examples:
                       <&pd IMX_SC_R_DMA_3_CH6>,
                       <&pd IMX_SC_R_DMA_3_CH7>;
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    dma-controller@42000000 {
+      compatible = "fsl,imx95-edma5";
+      reg = <0x42000000 0x210000>;
+      #dma-cells = <3>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+      ranges;
+      dma-channels = <64>;
+      clocks = <&clk 0>;
+      clock-names = "dma";
+
+      dma-channel@42020000 {
+        reg = <0x42020000 0x8000>;
+        interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
+        iommus = <&smmu 0x30>;
+      };
+
+      dma-channel@42028000 {
+        reg = <0x42028000 0x8000>;
+        interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
+        iommus = <&smmu 0x30>;
+      };
+
+      dma-channel@42030000 {
+        reg = <0x42030000 0x8000>;
+        interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
+        iommus = <&smmu 0x31>;
+      };
+
+      dma-channel@42038000 {
+        reg = <0x42038000 0x8000>;
+        interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
+        iommus = <&smmu 0x31>;
+      };
+    };

-- 
2.34.1

