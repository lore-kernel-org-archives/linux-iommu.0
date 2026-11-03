Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793718878;
	b=1Ke/YRTfWL9XlEKakoYKLophcb1H/FdphKEoMINsrHP+xnCYcKPRgvCs08mVYC5BCDf3
	 jaC7KHLkiI9OvDWTkZR9BqUEqmSApzF6p8SpK6B8TFWAX4VsruneC2x0Rl5OYMRS+XFpP
	 n5QzqEVwBmxwiP83FCOs3DseO2+cVaKtOAiAPT5B8+lfSUEYCFNiIb323d2mVPmW9Y3AQ
	 Uv0Ze5T7I/ms57I652FAwZT1QpAhvCDglrTO7K0JsgObyruTQNclBYtjW796uIY8rNe9g
	 jOhzNXfp82m/9jy8J6kDa9tcvjFB/rDQkGyN1cAdPiPn0VTxryIPn5JvKs0ZBmEEtCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718878;
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
	bh=nZisPqvp5/dDNoKJLK0SHzpj2UWfNlMI/G8etfpqCMU=;
	b=HWLmkdaryYsbMFn6s/oalgTUWaEpqIgi1IY8Fs+h4Aho0GUngoxeXYOOvITGmV6qEJWV
	 6S3PgQJIJ7XZ3JQ28aSXkDnEnT/RUnjl23JNFiuan71kklBCy9lVXmJu90UeSObX5NxOW
	 JZ5I2v0PILZKknsL1fs11ysPJoObvIZVsbvSThEZH8AL7Evq0YZEPZ8YirqzEN7PwMnju
	 iLISmSOrl7/zrQVHTtvzdPgrSrfrWPj2CdU91pPMkYdbvEKENjFeTEMFmfDbHsaCR13FR
	 wfHmx6g5vYJNP4BLWlOqj11dFSMhkARyXTlC9V6DXcmrEssdlqSeTy+5mx+b4TNTU5g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=VQMEQtd+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.41
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013041.outbound.protection.outlook.com [52.101.72.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB58606D832;
	Tue,  3 Nov 2026 15:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AB58606D832
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=VQMEQtd+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a3jLjhtRTgDkwbROEwZ+h7FyHdyMSlRwcBih/jo9KRBjGlhEHddy40irwjG87Fup/3xI5BuVhlpnpYU2EM+CH17hdVm6oXZu9H7lC0xUFT9YYat/0ugXG18ucNc9Ig1MIipcrrhsscuM/LJ64pFiao0rDYAISplmDKvsVDleBJA7Aj11L7/KEhYPyNawZTEl7tk1/iLCddhfGyJVq3y8CM4ZiyOVqPPIc8VIF+IVWZ9fsHd8zY8HspJni33wcXB1CtMoT1mIv3Y6ct8swtBAOjHjmR3O34App7RM8qVJowDUUoh8vKmAnlw3vRURPntLEHcYGKWYP14AvdPJdXvwOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZisPqvp5/dDNoKJLK0SHzpj2UWfNlMI/G8etfpqCMU=;
 b=f1IxCmkE+U10FItP8mzjlXjPSN/SQkiW/OhpXldvnHysfA8gUr+PMEGhGpeZhaLPu1aJMHbMD27cAVG7SPLhqvgjCWK78/duNpmobV+91XjO0PsDksyW7uWb/8J3Wi0epGXJXnA9aRUyGfRm6XUdBTNSqijIwz0nsncwjTOjANUYMx3X9kUjhvdXxSh3GfZLcyIR8QUWkGfu1d8MOtot+dgulMtbFHRxDs6oIkzAh1jmUvHXWd2jKGlWxXQKxcoeyRm3ORrER0wnW2EPWA9uWI/YsHVP0UHGY2aDephrVzOa8f3AUGhspVErmdssFp2xndkxNWXdVW/Bf1CvvzWxBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZisPqvp5/dDNoKJLK0SHzpj2UWfNlMI/G8etfpqCMU=;
 b=VQMEQtd+YWN7R3+i6+Zti7qlnjBGM32ZrBoUOaVxxoXAAtactnuSLcPjQX+azOdUxQHRYzQW9aWtRrrrwBRm2QpPkpqezTFQyyroRhuoYcNZAfnCJCDhz4GSinM5u4JPODkmHqZixDxKThMD+aNpzWkA+OJH059IdWdTZxOVU9wLJiYgn4dL2vrsbUaCHVNd8nIP//XTFdE3rKIEJkUm5uClSBgQL0QHYQLRp8igOsfktE8JtBbWtQoUutuMb4XsnhgiEpYLDrO0t1Rd+9OqMyv9xGetbkKoglPyG3qUB2shQktmFLMNJOW20P36BCF/iMb/pJFrqTzVY/otcavgbQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by MMZPR04MB025562.eurprd04.prod.outlook.com (2603:10a6:190:37::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 15:14:35 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 15:14:35 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Nov 2026 23:19:00 +0800
Subject: [PATCH v4 3/7] iommu: register the DMA channel bus for IOMMU
 notifications
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-edma-iommu-v3-v4-3-470415d418c5@Example.Com>
References: <20261103-edma-iommu-v3-v4-0-470415d418c5@Example.Com>
In-Reply-To: <20261103-edma-iommu-v3-v4-0-470415d418c5@Example.Com>
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
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|MMZPR04MB025562:EE_
X-MS-Office365-Filtering-Correlation-Id: 69e8cc7e-18dd-4d84-300b-08df39bd2b87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|366016|7416014|376014|1800799024|261021121427099003|261022105027099003|261009223027099003|11063799006|921020|261026140227099003|261026121527099003|261028144727099003|10067099003|22082099003|56012099006|261102123227099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cgducWyi+vux74heAS7sDCV0BQUOuUC8Bu0jxdT5deoJS8bZkXNJspyca7LDy8t30EG8QPO1uub+wmeV+pf8pDzE92ZbjFXlj53FDFodrM8PbTzp1aVotm5ZCAD0zrzvRXVcr/aKOOvLDOyYcpWfqvStrBKyA04MFxLi4j4W/8rVCDeeulic+fE8pTQBJkfUYfwP0cg5cMmjVHx7CqJtZUg8/hKwzJttiX7jnDtGCn61bjvfdTiKd4w65uVDPRq9w8hyoGmgDrkMhfULl6CVjJXUoKTuSZmSgui6skvLRS3jtjZ7jTXvPqgCAXZP+7PlHjoKETWKLq8AG5HQc30qqonb93eXEuO+HrI+QJAROnvoqmMW/P7QQuDgFkzKMU8X5adfqbRpc2zgf20nwGQp2e0E63GoL9HWTGGLbisqR8D2xbgrd8MNcc82ijwFj0qmbfhLixrM2xUvM1rcHx5cQKq2zVP7SPcNL10ghrBpyRRKY7XZXHWVVGrhcdHRpqMF2wafvQ5toiUqLZ/HFnder8sfb3RdFAO10X8Z/6D10PNw7huC4MIV2DgafsKJc+YI9ekW7DbWqJuV9gBFAbNd1oRNB+uqCZv/VMrZvlNXutfzYBKY3G5yTFpci00vcbzQl1tRMkwb/FWOuoA+K8Br61cGLRTFiY6BzayEVV4Kd3j82vtu4WsyOmCs82rhyi4b/sfw1HxdDeA4tkwQFHaAyA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(7416014)(376014)(1800799024)(261021121427099003)(261022105027099003)(261009223027099003)(11063799006)(921020)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(22082099003)(56012099006)(261102123227099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1BJajhISE1MbU05M0JsMGh3V3ZCSXFCMEhLWVZSdEtGczRHU0k3UzZISEF0?=
 =?utf-8?B?RHg5a3k4c2JhcjNEajJSWUdGbDdoY01rbVF2SThnUUh4N2R0c1RMbjBoa0Nz?=
 =?utf-8?B?Uy9adTBadDlla3luenhTNnRnZ29yNW5zZEpicjRSbWdocEZKSUxXazFKK3Ax?=
 =?utf-8?B?ZmxadE1QSTNNUjBaZzdvbk5NRHQxbXVqaXlmcTBFR010cHdVR0kyWFVaRnlM?=
 =?utf-8?B?L1hjWXFOZnhzMzR4Wmh0MHVrbTNwSjZ5dmhlTFE5SEZIelpTZG16SlQzL1V6?=
 =?utf-8?B?cmp4WERnbjBtdk1oUUZ2S0pEU3JHY25PbmRRN0cxaXcyRDBKcUhKK3NqdDRm?=
 =?utf-8?B?MDBRd1hsc3ZJcDNzUm9Ya2pGZUFtTEYxOGt0NEh1OUZST1duL3U4NzRMeEd3?=
 =?utf-8?B?RVEyYjh5UjFUWW1iQkpRaWN5Kzd3RHlHRmhxYVBtNjhITEZrM2NMYTliZ1Rj?=
 =?utf-8?B?UGVoMmkzMTBKTjNlR0txYlV6d3Zzc3RkLzRKS2NEVGNKR21EeUoyVzNRUmJo?=
 =?utf-8?B?VEhxN1lQOU5QQkIzb1gyT1NkWXpzZFNqTFQ2MUV3b2dxTEZBc3J4ZURkUGdz?=
 =?utf-8?B?bm95ekpRZDBCN0N3L1ZMR3d1QWhsQ282L1pkNGRQdkpkTlM1V1FKeU9EYUtI?=
 =?utf-8?B?VDZTb3JPQVg0NHJqcVdqOXY2Vk05eTRFeDcrMU50eHIvYUYzcXNzYm5ZRHhu?=
 =?utf-8?B?WWV5NEtveWlSVG1xUUM3aEppdGRhZjJpeFBqLzRpL0l0R0NBMXhDZkQwZUxZ?=
 =?utf-8?B?S1NNVWJYaFpod3lNdnQyRktJOGtDNHJHdHk3TmcvUit4VVBSUGxnU0lpb0Zr?=
 =?utf-8?B?dFdub1B3ampJOGtlNFhJb3lsY3FaejdhNXpFc3JwNk93cHJaRXp5Y29ST3Jq?=
 =?utf-8?B?bDVjTW05Q0d0QlJCZjRtdW1wMG8rZlIwZlZ2cHMzVUpucnBIeGVTY2Y0d09X?=
 =?utf-8?B?Y3lDaGJIaDJqT1dRZGUyWnpQM3NiMXd3RVlpenduOFUyNGJWdkhWZ2hkdW5Q?=
 =?utf-8?B?WXdySlNUeUNHb0VxcW1vUmx4M2t2c2VQWnZHdWloWE5SbXNVQzlqRmx2Y3dQ?=
 =?utf-8?B?ampHSmw3ckpWdzdjYjBSblQvbUVDSk9MaG9HaU5lMWVGbkw4TmxqVFhnUnRz?=
 =?utf-8?B?Sldldlc2TVlScUJaakc2TUZXMUhWYjJGK0dEd296czZIRzMrNzRRVDlMOHF5?=
 =?utf-8?B?VW9BeHJBcEJrREkxN3Q2ZEQreGdKa05XeTdIUnNWd2lMa2tjVjNLLy9jZTB5?=
 =?utf-8?B?M2JyaXNSL3A5YS9DWlpGNXo2M09teXBBQ212RkxwN3RjdlRka3IxeXQ3TlNu?=
 =?utf-8?B?dWExaXZJYUNJd2VQVFJNcjdxU3JhNEFVU1lhWmRGRkRLMTZKeFExVjBLOEh1?=
 =?utf-8?B?bytudzVETGtOa3NEOEJUYXd6eHhYbEIyckI0MnRvQ2FvNElMS0U5cEZtajc5?=
 =?utf-8?B?NmZhMy9SbGFXUlJYREVOOHNFYW9kV1Job29FUDZlVC8rQWNpdnRuN1A5T3N3?=
 =?utf-8?B?cjUvQjd5N1g4K1N6UXV1R1MweEw2S3Z4ZERVNm54N3hucHRNTit5dVlJdlp2?=
 =?utf-8?B?S0NWdmV5clljOHBoMzFUUnJuUTR2SEltM2ZkOVIxSjZaeUZjOTRNQ1h2T1Ez?=
 =?utf-8?B?OXoxWnNJNlBaSm1mdFdBM01qeDU1UFlsZUZJdGpGMUtvRTVidytsRmc0NTRU?=
 =?utf-8?B?aU9VYUxqYzJDRkZ1UmpNWlVOaHFtZU0rVnFMT2ZoeG5LQjNVWVV3U3NxR0JS?=
 =?utf-8?B?MVpkL0JLTTZJdmpnMWQvRncyNk52U1FpbEJTcjMyZVZWK1pDeDNGV3QrbmxK?=
 =?utf-8?B?TWFUSmppMHl3K1JBa2NwbXRmbUVmNGZCNmMwR252amh0czRxdERZK3ZCWXp3?=
 =?utf-8?B?YndIWldleTZiUFpxdG11MjRuSXAzalpuNElWeXRYUE52bE9ieURtRk9SUVNi?=
 =?utf-8?B?dnNsZ2Fvc2U2aFBteXZGdkx4WEltSWtCbUdhSkJMb0RvSEZUL1dnOXA5V2pE?=
 =?utf-8?B?bXRSUVJ5bjd1cU9VUVpIL1g0WlZrOEhjcmRjbk5razV3TFdsZk5KSFJDY3Q3?=
 =?utf-8?B?VU80TFFlVU9rT29qb2Z1NkZZTm9CTFdJR0pGb0paTGF6bTcvWVNXR3FoZG5H?=
 =?utf-8?B?SzVhTndTZHRzM3IzVzg2aHQrYkdBUk5hdExlbEpZT0hobHBnYmhDQ3lXd2JC?=
 =?utf-8?B?T3JWTEIzeEZCbTdRWFBPVlpVVy9wTHE4MTNzcnA0WFpjekt2ci84ZVIzRG5K?=
 =?utf-8?B?KzFIZnpxMHBncXhUZDdUMzBCZmZaN0hneW5BOFVsaUhtTkRQWjltYkJqaER6?=
 =?utf-8?B?TVY3WUVmZzVXMGJXaHdPa1hOZURMQVRWZjJseFBnMHNUaWRYTGlkNUZSNTJq?=
 =?utf-8?Q?np/HQUozrsYzqGbIBg9pvk06nns2X5+ckwDuz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e8cc7e-18dd-4d84-300b-08df39bd2b87
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 15:14:35.3085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ai7RL6FJmtzLIMfK74afC7jAe+f1RytBQCHz1fBy8J0oadwH0TKtYe5/g9+U19fgnAOHtpzab0vENti4pdQScBV4hWgTorSY80m9p9wAdnXvuxD1IncwgEeI49sxtT3a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR04MB025562

From: Peng Fan <peng.fan@nxp.com>

DMA channel devices are about to be registered on a dedicated DMA channel
bus so that they get a properly balanced bus association before
device_register().

Add that bus to iommu_buses[] so the IOMMU core installs its bus notifier
for it. This allows of_dma_configure() to probe a per-channel IOMMU and,
more importantly, lets BUS_NOTIFY_REMOVED_DEVICE release the IOMMU group
and domain when the channel device is unregistered.

The dmaengine bus is registered from a core_initcall, before any IOMMU
driver can call iommu_device_register(), which iterates iommu_buses[] and
fails if a bus has not been registered yet. Guard the entry with
CONFIG_DMA_ENGINE because the bus does not exist when the DMA engine core
is not built.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/iommu/iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b486b8bbd1fcd..6fa871bbd63ad 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -8,6 +8,7 @@
 
 #include <linux/amba/bus.h>
 #include <linux/device.h>
+#include <linux/dmaengine.h>
 #include <linux/kernel.h>
 #include <linux/bits.h>
 #include <linux/bug.h>
@@ -191,6 +192,9 @@ static const struct bus_type * const iommu_buses[] = {
 #ifdef CONFIG_ARM_AMBA
 	&amba_bustype,
 #endif
+#ifdef CONFIG_DMA_ENGINE
+	&dma_chan_bus_type,
+#endif
 #ifdef CONFIG_FSL_MC_BUS
 	&fsl_mc_bus_type,
 #endif

-- 
2.34.1

