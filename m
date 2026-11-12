Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794469717;
	b=ZSfhCQiEe4ZFHrAEXtoAzGmMqif1P+eKIV1Si545n5EZzj2EyM0CJlA7Pxw5R+M1TVkn
	 nIkJpMS+uiXOF6xJpvFEjaX+NeV9uG+clFn9MLPMPG+foDKyZ8kxdqbg4rEzcLFasicUb
	 Ay4/hMoA4NnBd7i4tvf2r7xpgLuPxsS6xtxK7yug5qg5QB6LuyoCrfonwAOjybAvQPoe/
	 iGD6KWgc6B1s5MN3Gta/wk6CQ7cO4aldU5x81hSjn8u0OfWpX2A1JodjE2kJ1WlUUHH1K
	 m+hM/GHU2Qn6MRuRaRSdT94MYL8NYJafMqH2gKb4uxKwMgtSpT83FZWsOlZQ7FYIsBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794469717;
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
	bh=HvgfhQXVjtGpctLrbcMebOzD3UmuBSpXE2bKNWdzuow=;
	b=O2qjpvpgW00c4Z8In90IYJlfF7lvrq4N4cvfDlDDLB/bEvNT+CCQn1TOhCk2w7otm7Dn
	 5hmtUQLbb99g0LfT+qBdNQTWLAcgLf7VlVEggxD0i+8ieP3aAUyYUOFWjllJvIDpjbOJt
	 yfcdyMdl6qyq8gttbR4L9ACroBP9NJPrqtKYPfdzRxCHEJRgagGjo3DjpqaBaTNqLuOyA
	 h9qfIM5bkVo9hrk7uN7AYMCdeqnX/PLHIvmBvUi2ngToS9O0Ix/PHgC+6+9+LQHvP9dY5
	 bsTctg/5gy8uQq4FJBEmr1+R+fUyBrYO+cMjtY5eiPnXRJW9ASSkEVUg4xtWnEq5BGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b="W9bfqpr/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.67
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013067.outbound.protection.outlook.com [40.107.162.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56CA606A321;
	Thu, 12 Nov 2026 07:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D56CA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=W9bfqpr/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxw6f2TeXtepdxLo4+JWkats0Mv6iFrZEL8IEByXblY0zUoXW/F/tvjc8i7GAdFKDBoAGI0+hV8jIhhQ6ILF1Qad0YFWZjCp8O8TraS79wHrE685yR91NWz+woAN9Ttmq8UgIHRogyEbpZMgDgccvdM3QZrsaEqtQQAEnoiIjlp4G2KEOpd7kwOXYbGF6/q8TiULftMg9ckCgrMMJHYNanNDe+BydPwLYXgdiwbs++EObf9gneTxdvPDxdzobnC627y2uR/Pd+1B9HMaedIFSvS5f6xWYkwV4W4acN0IvMex/BjTthjjpBAKFt9dehDB+thXZFvvcj74LY3/Md5CNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvgfhQXVjtGpctLrbcMebOzD3UmuBSpXE2bKNWdzuow=;
 b=sgDrW5s+ZC2E6LHa7p3H80RCYdRXSeW94cRggvGuwbXAJcu0k4FCF2sojuYOyTACCPojNhlKKssrQiPMu2IE01Hsd5vdQvgQYHePdfkNC6bOvpYmmhMCfyaxkE8P7LZxK3wSr/USFbXwjsCAMmKBuaL9h04dWSTflTXnW52KeGImjnvEnx4tVsesEjv2WvVApwAs3Zx/iluvDSfvu8YlXIJZKH4zbpPJIUZomXphuuE01WYGamldjMSXe/WQECbQkhA2TU3k5ZaXrkWlqPcIgYxO2KNUNfJZpRPcCiSmADv1soTlZNZBFp++PzUKB34juTOjv+Z6ZfoMVCZDqXFtrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvgfhQXVjtGpctLrbcMebOzD3UmuBSpXE2bKNWdzuow=;
 b=W9bfqpr/5RAJvbEBkIHdbzfdaAvaijrdjGMYs3xzGEq410nrCWcVVX+jX/n6jxSyQTxQ2dTUiWnkDUkTr3l98UEQ/4+5eojpKiOCkiI1x6Mpw5gJkVgbdghiykRMejkESYzd/I7cElJw4J/aj8u8yu1Os2AEBEIrXjEcmuruWg9qLqXOdluF30DlEwHhhtj9rtmrnwq276Bb5ILlYZRiB4BqgiuzIHLX3Xw2VjVvJfPIBv4ncGwrafFvEn9PoJmwIkvqmdq2DuUhkFbQElL3jR+KA193Nr74qNC35yA4842NH2i5nyNV2DGQvuKChA1bGi8P87xpwtRnXV0k3ZVeEg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAXPR04MB8909.eurprd04.prod.outlook.com (2603:10a6:102:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 12 Nov
 2026 07:48:33 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 07:48:33 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 12 Nov 2026 15:53:05 +0800
Subject: [PATCH v6 2/9] dmaengine: add a bus for DMA channel devices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-edma-iommu-v3-v6-2-b038edb8ce6f@nxp.com>
References: <20261112-edma-iommu-v3-v6-0-b038edb8ce6f@nxp.com>
In-Reply-To: <20261112-edma-iommu-v3-v6-0-b038edb8ce6f@nxp.com>
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
X-ClientProxiedBy: MA5P287CA0359.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:219::10) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PAXPR04MB8909:EE_
X-MS-Office365-Filtering-Correlation-Id: 098c6b13-2a58-4099-d2ba-08df40915a2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|23010399003|376014|7416014|366016|260925022911599003|261026140227099003|921020|260925021911599003|261028144727099003|260925021311599003|261102123227099003|261026121527099003|11063799006|56012099006|261022075727099003|261102124527099003|261021123027099003|261022105027099003|261021121427099003|261009223027099003|261102130727099003|18002099003|6133799003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	nRSPHwbrBuRMOWFtXJL0Hfzz97JySKEruK+26XlCCA3o8fcZnKWXZ3cbQoZzlO6lW53xs2mFGv5IKdf6r1OKNU+WOVhv59wal16s607vGyjtj5eDM9E2bW5LAO12FDDcgMkeg//fKRLLeRJbL1OUfxJEO1sLbGjRQd/0synDtWy8M2DNBQP1LeJSDncNETWzsCRazJ9jve2yUpNBLEUoliRolAs8brG1nsD4eAcTH5jPm65YH7flsLkGsHx8pYhsilKq91Jh3p2ZXAMMeMU2+J2i3UXPVF/IR79B11cq9USanM/TyabLcjuhbgHIEa8xNT139/TVAZnzi1aVsQTxYV5J/rqyYsXRugDvq9Syp5wRtcg8BougQvosCRrAVdBv//cS7D4obCFmBe9QtRveohYdOLQTBGN8TYnWNCqdyj8+5XiB6Cdl5Yt+nMAUYNvq//Eh1mxyWZGQf2eg6xeMxtmtAYNF/mikZZmYXSL0jfxX9y+mjvWu/EJPQQdxEpE8V/M7TA+yJAkh3lD/U+Si94eMcGnnEcp/DK6/Tf4nfxXf6etOCdfuuFqc5riQ80lEEOp2vKmPCLLfF/EhX3GYLCesaSWP9gcuFDnqzyomxtsuqjWqnO0rxkpvmlZJatOJsWpZ6wa47ccSNbyipORt9v1nvnGDJRepewRmYhUPeWu1IkMA5pKahVEc70rUBtprAqshZNdtXA6SB1qvVU0+Zw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(23010399003)(376014)(7416014)(366016)(260925022911599003)(261026140227099003)(921020)(260925021911599003)(261028144727099003)(260925021311599003)(261102123227099003)(261026121527099003)(11063799006)(56012099006)(261022075727099003)(261102124527099003)(261021123027099003)(261022105027099003)(261021121427099003)(261009223027099003)(261102130727099003)(18002099003)(6133799003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTJhbGhQOE1IYWx4YWVyOHJtNU5wSEJXdVp3WWZkZXVCaVVzTURpS2VaZE9z?=
 =?utf-8?B?TUxZYmFqTGRIRXREWDdiSndYaGlrUnZLZmp3N0xmSGpoUWxhR2ZSQXZzVjE0?=
 =?utf-8?B?WmRBT0ptaWdWZktIK1NSa2ZsY2xNSjRsU3NtQjZmaWEybmR1ejN3R3hUdjJS?=
 =?utf-8?B?MXB2MUZWZ3k1OTVJcTFiTkRWK3d1OXZPZGZCUkI3bVZkdEJNdGh3a2xMUk1t?=
 =?utf-8?B?bjUwaUltZzZ5Qm9ibkRiVVY2a2VMUVVwQWY4ODVOenBGUkNaTkppSzQrTk1K?=
 =?utf-8?B?VDEzcjBpeDd1dGN0cVo0ZVNvYUFubXVqYWp3M0thSGUrd090VlpSZXpocFpx?=
 =?utf-8?B?K2lFTHBEdkZhWE5sVUpseHR0L1VsOEpqay9zUjB5M0w4a2s3QTYxQkNQMmZ4?=
 =?utf-8?B?UEgyV01nbk15VFBkVzhmNTVIRkllbWF6aDg4QUhEbGJCOWtqTUdUc00zeTU2?=
 =?utf-8?B?Uy93TWRYdkthTkZXeVlFTi9wTmR5Q1duWW5ZbExVME02aTMwMktzMGxxekZn?=
 =?utf-8?B?clRiaXUwc0NVMlh5V3NFQ2cyQVc5ZzNqbjdRM25NemsxSDhwWUc0OFlWc3JI?=
 =?utf-8?B?SkgxUXU1SE1TV3RTU1p5WFdCUGxqYlFMb0VrNk9aSzI1MFcrZFB2L3gyQVNr?=
 =?utf-8?B?T0ZtdEllVDdweW9MT2VlU0pqcE1vMENUSHJvYVNXaXNRM1U5dVJZbVRJY2xw?=
 =?utf-8?B?UmkyT1pWdkE5QXpKczl3VUloUngwSmR5TDdIdHRzRmZCK2dmWnVzUXVnSHdY?=
 =?utf-8?B?THJMR3VrRGN6NExVa1I4K0crTW1mb3Z4aGlJRkVJMGZZOTdtZXNpdzh5QWpW?=
 =?utf-8?B?R3VmZjdyYVYvbHVoRDR2ZHI5QXl3aEdsL1FCSVhqSHB0Z2dkeGFPOFJLNzRy?=
 =?utf-8?B?SmZMNTVTTjR6OTM0QTFFTWlRRVF4QmlMMGJxQmU2Wjcyd2dQKzRrS1F0a3Rr?=
 =?utf-8?B?Ry9KdU1PSzMvejhxVW5BWE95RkhaYUZLMFBIcHFNM3VNVlhJdzNwOGd0Ri9N?=
 =?utf-8?B?OGVpSzI2VlJ2SzV3ODdCb08rV2txbFlTU2VuZEQ0emoxZGtsai8wVmp0OWl3?=
 =?utf-8?B?bkZVcFhvT1dtdnE1QmUvWkU1ai8wT3JFNXhxN1lDSFU2RjVhdkhjbHBHV2Jn?=
 =?utf-8?B?SHpNMU5VQnN5UDhiOHlrL0N1RDFRTFo3ZGw1YWlTNHBSS0tidnRNZ3Z1TTFK?=
 =?utf-8?B?Sk9NNWNlYTNmaWVYdyt0N2pRbFFqbm5yT05oYzZNQnBmRDVNaHFOSWIxMkJt?=
 =?utf-8?B?aVBmVHdIV0szRTM1cnJLTS9XdGFDQjFrQ2NMUkhsOFFMVUpIcXZZY2xTRXYv?=
 =?utf-8?B?TDhCYzFpa2x4dkRURFlxanFndjR0L3JBUDhNMWhlbDVBcEVhZUxzQTl5b2Mr?=
 =?utf-8?B?QkxKcytjV2tQb2E2NUJRdzhyUmNnTnEwSVBRc1o4Sk1HUUtpNWEvTkVUMFVx?=
 =?utf-8?B?bmFoVUwxUk9BUjBBTThUTE40SlJFME4rd25lTndhQXJRdnM5QVgveTNFbVBa?=
 =?utf-8?B?Zk91UEZmNDFCZklPZksvalh4QWVyRUpDSXdnYTFpZnFwV0tOSGlLNWtTODhr?=
 =?utf-8?B?aEswRGVKT0NQTS9FS3dKZ0pPSE0xakVrQ3llbVhTWTBQc25rQXlmVGNZeGtp?=
 =?utf-8?B?RFJ3NjFLZW1waFRNQi9lakxZalBmQkcwT3pYZS85YktNSVp2Kyt0VlFOUStq?=
 =?utf-8?B?SEVxSzFGVFZhMkM1dXJkMmZVWVdTdVdWZGs1eTZKSEY1cG1PWjFXdnZrOGRY?=
 =?utf-8?B?QlNiSlBYWHl3THNjTDQ0V05mWTNOUUVpVE5tUVVCYm9mNDdFUnI0UzVWQUVy?=
 =?utf-8?B?WWN5Mms1TVpTMnV2dFNnRXVVbzE3Zi9xOGVWa2loTDBhYW9tZWI1bHk1SWxn?=
 =?utf-8?B?S1ViN3lIN1NOUmJSWEc4b0ZiSWJLbDhzZlhBdUJIcVRBaklDem1YRzg2UUpm?=
 =?utf-8?B?UUN0VFZJNWQ5azhVNjJLNHpIa3VUQ0tXVlpBZE1BUlRRbmsrc1N5cTY1VE9j?=
 =?utf-8?B?emVhWHlENjBkZ0FGaGF1MFZPWDBlcnFBK1JOaUtDNjk0TDJuL2wxdE1sVkpS?=
 =?utf-8?B?T3VYUThNbDhPSVU5dC9QQjhBYWFHUTV4QmoyZU9hc1RncFdvYzF2M0JoUi9i?=
 =?utf-8?B?T2VhZ3VuVXZ4MVlBK3d4TlVIMFpCMlVXbWJqSFZQK1BueC9PcG9mcHpxVDFx?=
 =?utf-8?B?TTZoZDB1dnJFK0hWUm9UcXYvSklUZjliTFBlZnhURGV0Q00vRXRFL1Z6c1hY?=
 =?utf-8?B?bEVTOW01NWhpcitnZEJYMTVLTmMrOENNdUhMZXpacVFOTmtUZTlDL095SUpV?=
 =?utf-8?B?TXY5UnZwbEZ6NUNUMW4yTnZVdWFmWGx5bFMvV1VWYitJWUF5MFVMUi9Xek0w?=
 =?utf-8?Q?51El0HK8a1vdvaI1xj2nqhAJNOxZLzqLKSe4k?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 098c6b13-2a58-4099-d2ba-08df40915a2b
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 07:48:33.8611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z3tmur3Jmovq3sQ1+hSj7zt+NwnxCv6jWEvFkWyGcitLsBd2jr5N/oBp33Gr2lzEuVVsGwXlJnGTyE1pBk5H3TOoj8zZTX6kCxOLernYeU6V2l8j+xBmRyUK37jZhvJp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8909

From: Peng Fan <peng.fan@nxp.com>

DMA channel devices are currently created as class devices without a bus.
This works for sysfs, but it prevents per-channel DMA/IOMMU configuration:
of_dma_configure() only probes the IOMMU when dev->bus is set, and the
IOMMU core only installs probe/release notifiers for buses listed in
iommu_buses[].

Drivers that need per-channel IOMMU support currently work around this by
assigning dev->bus after device_register(). That leaves the bus subsystem
reference count unbalanced because bus_add_device() already ran with a NULL
bus, and bus_remove_device() will later drop a reference that was never
taken. For example, tegra186-gpc-dma.c assigns chdev->bus after channel
registration. Review noted that this can underflow the platform bus
reference count and lead to a use-after-free when the device is removed.

Add a dedicated bus for DMA channel devices and register it during
dmaengine initialisation. Use core_initcall so the bus exists before any
IOMMU driver can call iommu_device_register(), which iterates iommu_buses[]
and fails on an unregistered bus. The match callback always reports no
match, so no driver can bind to these devices. A follow-up patch will
register the channel devices on this bus.

Clean up the unmap pools if dmaengine initialisation fails after they have
been allocated.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/dma/dmaengine.c   | 28 +++++++++++++++++++++++++---
 include/linux/dmaengine.h |  4 ++++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 34be53487a21..e1022d297674 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1643,6 +1643,17 @@ void dma_run_dependencies(struct dma_async_tx_descriptor *tx)
 }
 EXPORT_SYMBOL_GPL(dma_run_dependencies);
 
+static int dma_chan_bus_match(struct device *dev,
+			      const struct device_driver *drv)
+{
+	return 0;
+}
+
+const struct bus_type dmaengine_chan_bus_type = {
+	.name  = "dmaengine-chan",
+	.match = dma_chan_bus_match,
+};
+
 static int __init dma_bus_init(void)
 {
 	int err = dmaengine_init_unmap_pool();
@@ -1650,10 +1661,21 @@ static int __init dma_bus_init(void)
 	if (err)
 		return err;
 
+	err = bus_register(&dmaengine_chan_bus_type);
+	if (err)
+		goto err_destroy_unmap_pool;
+
 	err = class_register(&dma_devclass);
-	if (!err)
-		dmaengine_debugfs_init();
+	if (err)
+		goto err_unregister_bus;
 
+	dmaengine_debugfs_init();
+	return 0;
+
+err_unregister_bus:
+	bus_unregister(&dmaengine_chan_bus_type);
+err_destroy_unmap_pool:
+	dmaengine_destroy_unmap_pool();
 	return err;
 }
-arch_initcall(dma_bus_init);
+core_initcall(dma_bus_init);
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 805668fbe437..be9308739676 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -412,6 +412,10 @@ struct dma_chan_dev {
 	bool chan_dma_dev;
 };
 
+#ifdef CONFIG_DMA_ENGINE
+extern const struct bus_type dmaengine_chan_bus_type;
+#endif
+
 /**
  * enum dma_slave_buswidth - defines bus width of the DMA slave
  * device, source or target buses

-- 
2.34.1

