Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793718891;
	b=hmGaXwyyTcncE/3iSLvrLKTBxVz0A36ed/xNVjQHX+9++7RTJFcZJP8mqRK3F2HyMBuv
	 nwNxDYncbvMtfmncBwWyAsxczxu80/rlTDOk2qEyy08ioX/hMd3Dv4AFk+TKHQ64A1Oiw
	 fqBdOsC6OvHmaCYssIMLvuglfmxWs+nFvt5iLTybM/80cHgU19GANdMvMhIdZtbkMy5we
	 3f5rBVpmhyYm8f2rVWLfhgWdvXC+9S74N1Ow6JkboTSA6L+ZRR9eS5PxhXKTfp0rz9m/w
	 7i8SK/jUE0692ScwUWHvpx8CvslTAHUN1yNFWxVxKPL3AifQbQblMYiitDzAMc/TFFA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718891;
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
	bh=nfYtahTkQWtAMURhK9hqS5NWUEpE9ray61Q/0s6SXvw=;
	b=jLTPu+PQu5nVll4KgXmnmE/xBbu2oin5+0BLez/qbjd5xBckAWf0c+GLI0jvtr6stCqT
	 UPtYCIr1/OBcXVHzgbIH54C2//feyPgDLkWBmRIPMBQpDOwBplEo0GZih7YwYJZeU6RbN
	 ojmqccVBIZMz3r8eXS7rVsiXewoNZbKI4gIK2FG/B/5upXMexHsBnyq4QvjIrrTxK0W0T
	 6HPYzflPkRgZx/nMlIksj5IFcY/X6kkKdLXcCD+jf5OIB2ljQtq1zptoeMoKgyCi9AxPF
	 wrIgF5XiZ/VMa8/9hBypb4e0g+dYdhlHOmLM/PfDc4wwckw0gY3TdklMlaGPjTtltOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b="vKMZ/Vy2";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.44
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010044.outbound.protection.outlook.com [52.101.84.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7160A606EE8E;
	Tue,  3 Nov 2026 15:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7160A606EE8E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=vKMZ/Vy2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rryzXrLlXNGrcCtgs798MFJ4NSnlf5gXgGUB/GzS2sw7ILYDBGV3FT7uTyaz3JajXjFejlgr91Sez6JRIt8oUStmSZxo7qj9if2SDkiTJ6iWoR68PkcEYZKPQzkAavrtnP3QOI0pS1nJyDe0/jucmFsNaWDagkZp3RqaJD65XLJnMSsIG7ClfySNsW1tOza+L67HFTlIRSTdpN7gjMVI/bWwisPZIq2e+EnsZKGEom6GaRYO8a13uIrsHzRi2fiIAxwwlR7l1aSgt8N/j31bJzc90WIUnLa89OOojqDcbxui31qzmrHz4ADTV79EH5xGKejjmrLtIJG4gkqfZf2ucg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfYtahTkQWtAMURhK9hqS5NWUEpE9ray61Q/0s6SXvw=;
 b=h5b+SL4lXpRFE0jgD1kNSGiNQeocNYx9tT3RdDrxETOdZCmxAmCHRgmpk5eqv301jI2CZ+mqk/qEWSBXzawY3jHTR7jkUT7rsETykzmDT/CVa3DeMbGoTW+/NVG+ZbXWPX9iZ0dGCsAOX9sxCmaVhsXNf9Xjnz1uA+TZmNNQ/887s3D2inA+wPa2eY8lkie5bPW/tzYkN5/RSEYWr30ma3PSO8VpkjN9+RPAGaGEOsPk0GHL1aOpxgZSU5b8Hg+suDTjM6Yv3yYbrfh5NpsHgr9vgg5VEgwYI9XbI0fXFKo4szt+p7uJ8QXx+yxoOgT/LiEDLJOgusZLGjrLZtVxhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfYtahTkQWtAMURhK9hqS5NWUEpE9ray61Q/0s6SXvw=;
 b=vKMZ/Vy2I5LTAHtdT7VSxd3I0JuWqZxukvTIzpM6bH0yDzuxT2pXhVgq5EdcI9rpDAztoq5/MCYnFTVr4+3pJGep/enkZ/BQfTnfoHFCZp4tr6c5RpXBdUR6E7JOCAK11UcYXyasUEVZwCZFL4ShV7NcBgSgxq8HLaCnDVzIZQURjESoWtLyFLCmrGCexUPVZnUUPcDX3bv8I+2WHXSb5F04AU2ViJvs+p+Z/TYPcbQpNHVVsG68zxkev9Ao3ukpxM28tAk4cY0/OQNk0RT+X1WIUMu4tIMJzrIbfqSbY3/RgxifPHOVuxQEl+QcnnyqSwpQY0u2wYYi48PFQYN1cQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AS8PR04MB8037.eurprd04.prod.outlook.com (2603:10a6:20b:2ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 15:14:47 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 15:14:47 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Nov 2026 23:19:02 +0800
Subject: [PATCH v4 5/7] dt-bindings: dma: fsl,edma: add per-channel child
 node support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-edma-iommu-v3-v4-5-470415d418c5@Example.Com>
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
X-ClientProxiedBy: SI3PR03CA0006.apcprd03.prod.outlook.com
 (2603:1096:4:297::8) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AS8PR04MB8037:EE_
X-MS-Office365-Filtering-Correlation-Id: 00f302f8-e481-401d-a4ae-08df39bd32cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|19092799006|921020|261026140227099003|56012099006|11063799006|261009223027099003|261028144727099003|261022105027099003|261021123027099003|261021121427099003|261026121527099003|10067099003|18002099003|22082099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	APFc/Gl524MNS9k+7RgG6AYAC6EK0Pll5ZmdTccYEYA73+IEVBDCmQkqcmukuxGmTlUwQAgZpGEfLUVoJzRdXM9c3qRhaf7O+XNzmsPY1gznfMfJcATCD3clZWosvgTtgR2etyBPaocnaG3k+AZnF6hSMh4BM3QKkbo9fp/3C9wBo650ftVOWETPVyYmVALRZ7SOgskqDsTJax1Pf35sH03J2IZhytId/+bdvvWSNZ7rzvgDrP97Ok/1f2U6DC4cRFhcb5pK1zmKfvytAUOnBzj5L9DlWQyI1VPnV29wI8aKJHJuXQdP1xJ/TE1VpwCQ3LW0QnHtCAhJPWyQ21qPRzDK5nGSHQT4k4yNVY2FW7WkBCAinrVLviXnHnz4qZ5bRtu0wxmwu6iEaDnVTRHT8GWn89EgIXjf9BlbO0aDsZG4cqnaAHazFFHYO6BTQ4fKDzkgzibJ2OhRaXPwG393r+R9+juj9sLPGMgJQ2ePXrI+FtHym6p2GBP+h++NoxbrHwWV/bRQYbWg66aagoTEeh1e6jYQ45ThTv099SvQz6UKAe2TC+gaabViLpXVv4DvTJfcaStGVqYJT84pLEhPfQSKBUSJ5ZIsdx4yzrF/VPt+drPVmUPG7RVLA4qWAUc9uYeP2W0w2DZHAnBduUDIjWIBAkt0VD1p3z+WjIv71swsprI9lf/paq44p1A9HnHSlYudUY/Kedg6/mUbycYgTQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(19092799006)(921020)(261026140227099003)(56012099006)(11063799006)(261009223027099003)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026121527099003)(10067099003)(18002099003)(22082099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFN3UzdHdWFLdzNGQnJEZFJTeVM5RDRYQXV6SzR6a0ovdW40c04rZVIzZy82?=
 =?utf-8?B?S2w1Zk40SnhJNlRldm5kWVhoSGZ1cncyOEEzcUxzdmVpdFVpMkVER05OTytj?=
 =?utf-8?B?NFZaY2dsSW8vMHFQSGtlWGY5RG10Z3MwYklEY1RWNUU0aUNQbGUzck51RzVo?=
 =?utf-8?B?bFFUc2NqWVJhK0haZzV6L3lKbElBOFEvMS9MNUVnM0wwaGsydkZ0ZXJSYldK?=
 =?utf-8?B?NVE5b3pJT0Qvdm00Y2huR24wSGRWSFlheE1nZWNUQzdxUW1WUGVCcmVmWUM2?=
 =?utf-8?B?bjkrSjcwekE5dVA4dzA4eDNhQXZoZzRqdTNaMUlSQmhJdWNFelBwSjVyRlRG?=
 =?utf-8?B?SFU5RDhIWXd0MTBqKzBxc2R6NnRPdHQzOWxUS2Nvb3dRSzJISGRJT25hV2Rr?=
 =?utf-8?B?dFhTSWZtQTRlL2pVRngyQ3NNTkkvdWp3WW9lcHRQNjRxV2s3cDhPWU1IbXNk?=
 =?utf-8?B?SWc0Mk1zZFBaT2NVckc5UzZ3SFF6ZmV1REMycDZZRUIxSnZyZ0h5Y1paQlVo?=
 =?utf-8?B?bGFVN1ppdU8yR1UwM0VsWm9IZThoeldXWURTaTFFYmFBVklNYTNzSlpOa2d0?=
 =?utf-8?B?UWZQQ3JSWGkvdks2RGlCaW51QlZlUW9lMGFBZ0dIN3l6ZnBQYVVqNjhDTkdC?=
 =?utf-8?B?bG9OSVJ5MzFQdVlQWnBxbU5xS3ZnWnJXa2VuWEZDVDU1aVNjaDdXVzkzL0NZ?=
 =?utf-8?B?NkRySHVWUFloQmJrRStBZHdBOTJkZmx3NzUvSkdhTXlxbWVzeVJ2SElpenIr?=
 =?utf-8?B?cGkrRFRuMS9UZHZkb3NyT21hNTlBSFNrS3ZIU1dFMFdJYjhOcE41MXI1bklQ?=
 =?utf-8?B?WjNCQ1FWVk5XcVNkTWp2SGlMNDBZUGtIZnR3clVmZTNGKzY2aDlmS1pVcHZG?=
 =?utf-8?B?WDBoZUJrWTVoNW44aWpSU05VcHVpb1dLSENscFpTT0xubnNGTENSamF6QzdD?=
 =?utf-8?B?SmhOZjdkNElYUEpMWHpJWmppM3JaY1h5ZHRMWW1qNUIwd2FzU3hXdTRzYWZs?=
 =?utf-8?B?WFJzUzQ2L0ljOWt4WXJDUzhQallKM2tnVDk3b3NhZnZGcnhhY3JneGp0SWFK?=
 =?utf-8?B?Ynd4cEdBYXRLN0JMZFVJMEVKQkJHRzJxYUdUVGZrZENKcUdCeHdoOTlBVmwr?=
 =?utf-8?B?dDVBQi8zcFpoNEM5V25XZHFhcjNvM0c5YWozdzlocDduTC9lbnNLNUNPSVVK?=
 =?utf-8?B?WityUE5yN2hkQTI0bm5BdU1mVVNoQXdXWnpqMllDanRkSjJWU2VtM3NBcjU1?=
 =?utf-8?B?Z3Y0bGR3cHFOUlVaTHRITE1rQ3psQk1CR2VDQVk1Qjh1WHA5Ujh2RmxvcVM4?=
 =?utf-8?B?Sm5oZG1pUFU3NXF3Ty9aK3kxOTRFRTBVK3V6U0ovOGxHUmloZHJoaXFFKzZx?=
 =?utf-8?B?SmpTbDVjR2c4SEx5VHdicHVjYXhZaTFWTExiRE1QbzFodFMwaXNJZ3FjemlH?=
 =?utf-8?B?RlJkb3RHbzBvcDdqMFJnK2lIclgwMU9ZTHNwdGtQTGdLV3JjZDBSL1ZSdUU1?=
 =?utf-8?B?R1BPazJ4UjRCQmszYW9tTFBUUDV4UW1YVFFUcVlVbHZtVWQ3SkI0Z0RqZjBM?=
 =?utf-8?B?VjJuZ0hlekNUODhnSS9TOU9FZTc4RUVROTM1dC9jc1oySGlaRlphRUVSSFhP?=
 =?utf-8?B?b3ZLUWlQTEdzc0U2OHUwT0pOaE90bzViV1czVHFjdUQ3eWpSNzlCVUovMWxo?=
 =?utf-8?B?T3NXR2twTFJ2RFBXY2RkMVFDMjNDU3gwMVYySUNtZzhrVWUzUTVLREVsMk92?=
 =?utf-8?B?UFBNeVV3SmpVS0tUdDBqUkVURm9ldXpGNzBXWVBjZVBVVUJRWFY1VFFLUUxL?=
 =?utf-8?B?c0xHT21QdDVsZ2MrbmFpWTBmUmE4V2wwZktWbi9QWVRhK2xRb3Q4Yk5NOFNz?=
 =?utf-8?B?OFZyS1Jac0t0amVlOWU1WFNjVWtpTFZPSXhWMngzZzJucTF5TUdDNURXc3RI?=
 =?utf-8?B?OCtGdzd6ajJCY3JSS0lwRzRYS2FNUHp2SzF3NnVlZmhKU2Y4bTE5cFQ4QjIy?=
 =?utf-8?B?cDQzVzdzQ2pUTU5GNDhVZk9peE90Qmd6azVJaDZ1T0dBUXU5aDNKRnZYaGhm?=
 =?utf-8?B?Z25lTmtGZVN5T21ZZmh3RFZnQXpreFJEVnREbVhNVVpxbGJwTlJISGpvUjN4?=
 =?utf-8?B?djRjbE9oK2dWdVVzNnh5emE1T3k4dmIva29EQnNIQWhnRDV4YzJMMS8wd0Vm?=
 =?utf-8?B?bnRZYy9iUkR0SU9BcXluUU5WMG5xb3ZHTG44dHdITjlaNjR1TkR6Rk9PK3NB?=
 =?utf-8?B?Zy9aR2hGaWQ3ajk2ZDkzTlhBRFh5UW9EMDk2UTFIVDFIdEsySVJDMlBlbzZ4?=
 =?utf-8?B?WXVoV0x0YlJrMDNYVVZkSnFTaG1Xc1k0cStYL20vaTBNUWovYzF5cG5pdWlG?=
 =?utf-8?Q?qred2nvp7AuSBULEJO8h3G8/WXwRZcBa2UqEi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f302f8-e481-401d-a4ae-08df39bd32cf
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 15:14:47.4953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pCQSvZlXBFe5ZBtkOZLUiWDplb83TSDsLqQD8BGAxci04VuXTA/ou4e1isGtBxxd7UTzKiOVk8Gb+z8KZgscQr/YFa0atLv/R1Q4q8S7Yj1Ss8LPR80U3WuOcw61sJAI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8037

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
index 0260d177c7d04..65877e78330ad 100644
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

