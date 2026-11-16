Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794798092;
	b=V22Ei7dI2OjMgKK0FoZKgZ9TXUmmoqwBEbSQSl2cruUUC7OjM6hQr71XYZTDN15kB7q1
	 vcLehq5r5nLuZORXqckvLVUNEjEZ33S4rd+YG706C78CgZHojuaBxRAeFj7a3baOxe+TC
	 iRUX21d3I/o37E8gwTBj7KEela1nZUm2FbVpla6BmNMyOGYbIrwFX8WYZjcbB3nTdlTnt
	 DGfdlPGF9GRPNT7DcgW1P4AXB11zMo0HoXe2lludSEKGyDln+JjLwti7kL8c5u7mgZHzH
	 uNMlmCrq7myrGzZtR2k7WDL5zrofpI0DqNpSp8WPBwZUzN8+y2j/5hVO+tJILvn3YXg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794798092;
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
	bh=mKYYQ27MTtrrNZha95pQu8ZURoZIIyu3o1V9iakQjNg=;
	b=fSlTeHHFvg+h4BbUj2tcN+rqjk1gREPLOGqdZTcUZN/jLd4OnnWyaNCqE4NMBySLIwpG
	 SPfoyHccC4VWzRfJHhjyTNJSMrHpNPref6mpy/0oZA+kzxkOmmYt8zyDivHX1e0LmszdO
	 +25godhcY8/qqFBCGaCU1aKjNEhp6QbM3bnkcXRnnhgZvsTo3KIDjibRjqb94smjirvcf
	 iIySz3riDVCs3zWSAwIJ+So1c04SmrGF/h/8Pt8bQZDpGiKJVEkAw0UVU4+DCgdQ8n3+d
	 siAcZg+HNizP7mWEWfmwCAgEBE0BcGuXnal91TFWv86ikXfeLRBdlc6n9BHTme/1eUw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=gRcd2QpR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.51
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013051.outbound.protection.outlook.com [52.101.72.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E1F606A335;
	Mon, 16 Nov 2026 03:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00E1F606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=gRcd2QpR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QLxy4PFcIdYk6MVbg7hVzX9WW7uVa4BPQUgKWig7GDlbAP0eUZeSft2N0+YYI0gfR3q0faDWcv/rOBJpK62XiGbOyShgCIGQmvWQeFZ8T47fDbtbBWTJ/e42zSmYpUR1jZPIAlMLy4aTzpxlRgd9iTuiF0op8jG7V0KOKPYavgqmsPJ0/jTRTKavPc6CtJJuzE/UKHwIFxfv6d2AzDq+VnRdqs8TpATtYtX3xFtNJvtuKqP38NNh1ETLGv6E1Ajt/jDHs00LZi74OkPpVPf6cqeCTnW31IQs+qfYkZ2xI9MevfTS4gtQy9LWfUX0iUu4PwnFKkiMFe/lRBUGJSmpjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKYYQ27MTtrrNZha95pQu8ZURoZIIyu3o1V9iakQjNg=;
 b=qVWY7uPXwtkhWsfOuQ8pjanj1HLZnfB1GQbYOy3OeaG/cpV8IKow2MnCu/tgiiLMifAYvQWzmnTpLN8AeQ79LqV2mrhW5xM/67Tz6AVmeHRv2svcHR7XufeGPsjuOHFW1zuEC4vriorVKPfnsK79geA6bDK9fSWlsHLqlH50TcIdJq0AQhEFAucGcOeOuaxuvrLuJqGTckB+nwREGzkO7WdLZHkPd8fG0ooYsxvc1jqxDm/daZrCr/eGQYGYCp31JfOtIQ6nMgc9g7QGYf9XpuWnInvFpZ3WOCqHnUch7hTraPsumh6kR1LD79NU79ODjre/UTHgYRPYrKdVc7s/mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKYYQ27MTtrrNZha95pQu8ZURoZIIyu3o1V9iakQjNg=;
 b=gRcd2QpRhBHF/8jwiUQpLxuVRNFZm/9cUQThq5IpyQBnlGb5hSzVyIW3hyv5+dMKLga0cudBJqMtXW+VaQvaeuS6f98QbayHvFAH3n/APKGCeor1jATYYdj7uIW15HS9p3Nrpkp7QPG7vry+ngBmB+8c7YrGgCFlEKnPOe2tfYN6ioqz7swq5XWLZRAqbNq7o//9XB57ffT5gremq9w++IYJyAQO3h/YFOzGbufaagHD/f8gu/CVWYecEGCES9+Mf9jne4/Sgn8gam4+NcpRNEss2I9gqD6ZdN8Z6NpFse2AeSiTgxz81HKX0AI+CbsoOZgedqXV5Jj/CfDd23aj/g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PA6PR04MB11778.eurprd04.prod.outlook.com (2603:10a6:102:525::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 03:01:26 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 03:01:26 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 16 Nov 2026 11:05:30 +0800
Subject: [PATCH v7 9/9] arm64: dts: imx95: convert eDMA to per-channel
 child nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-edma-iommu-v3-v7-9-32794ba8efbf@nxp.com>
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
X-ClientProxiedBy: SI2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:196::21) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: bf47ce93-2780-49fe-36f6-08df438de728
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|19092799006|921020|10067099003|11063799006|56012099006|261026140227099003|261028144727099003|261022105027099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	FkfRHTu509BTbjBLRi7pTvZY9/zQ0VhGTw+x4I6DuZVoSZh97w9BRWzufIqFUg3cuygbBKmT64Xmt75fgGiT5jZQUozWQYwsE43X1puQhjqSYbhK21VS5N+isISZX2aQXAchugmZi7pXDSKYeRa7pvAhXgMDnFzhY9crnCdCGmOefWoSETXFYUWO0PAV1PGwRJ1Lhp/FoC40Hg9M8r7cbtFKwUWzd+mvoWEZmibKGGh8dCM+TTT6CjCDUgjT1g9oTT0Ik/iUXPwBWUCekg+xF0ufH0ttWbxsB6x3oZhFQiLRXOx9ZUhgpljAAcblHJmbgOVohHkjRHeZF89QQ8B2fKaR2xdy4g0+6b5NFaj+BUnLS+zxjBQ+TYarQzqxRTeV7IComjA2V0hByrdbDyBI4vjG69gJmxUPM5HleeqHZ/DfwGimgfRW1+itU36ofZK7dr4L8MNyTXQ4pPVhgET5m6FcUmAqFyA/DP/8kNlvazA2ahY6pkegK8vppEwe1jeffVsatuoAD9DKOtcd+GELBVTQ+AODtFxWTRGjCudtt/uvrT/2xetBc7U7LoXvCMpNPV5AjIw2MgcO/4w5iKI5hpNJSH6x5bnffBiXKQMplKwVkd9JhRVoZI+hwX51Yz9PAKjcCbuEbkhDXse3rSCgAWTPyqYMmAywOEQ3Xsp5kt/uNhbH80SV8hEf1HhsQgZBfYTHV6elkVsfIZlChHQX3A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(19092799006)(921020)(10067099003)(11063799006)(56012099006)(261026140227099003)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0lYaXIyMnN5MTNNdkRkNlVWQzJzQ1I5aFJZUFJhaGZCU051eGJiejliaThk?=
 =?utf-8?B?K3hLeENHQk9SZU50Rll3L1NRTGRzS3NYUWg5Z2k1UVVCNW5sVWNPSHUrT1pw?=
 =?utf-8?B?ZkF1eDZ3RmFVNklBeW1uMWRIS3hjbzFQMWdSSm8rQUUxazF2bVpPcThWZjB6?=
 =?utf-8?B?Q3lZcVB2UnJDMEYvSm9zRXk4T2RQWnNYeXFHV0FtTXhIRUcwRHNoMC84MnFK?=
 =?utf-8?B?ZW02eWIrN3hmK1U5Rm5obmtaNGJaTmhlWU96ZjJ6ZFRvOGNoVGRYMUh2MG4x?=
 =?utf-8?B?aHBGZGUvV0FVQmR2bmhoR0ZpUk1ZdFZhMWY3UEFKYXNERE5nVXRPUVk1cUE4?=
 =?utf-8?B?NHhWWW93bjZHeVRqc3ZPTy9BNVYrUDArbG1YRXl5N2ZJK0d6Uk50aEhoUXJl?=
 =?utf-8?B?QUhCTVJPWHBFMThuS0FGcnBPOEkvVnZDUkZIUDcxRDZPdEttbG1kd3VKcjFR?=
 =?utf-8?B?c3dSVUFGTXR0WEVObEdCRE1SYmYzZUVFTVk3Q3J5cUx5V1ZzVDlGSFpSUDc5?=
 =?utf-8?B?WWRvWUlxekp0d0Jyd0syblU5WDdYOXlxV3Uwc1ZERE84bldiWjZvTS9tYU4z?=
 =?utf-8?B?R0RsZVNnZ29LYURjMjlrQ0xCcjkrZDYrdmhUY0JieTVBQUJ1YzlHS1F6SkF4?=
 =?utf-8?B?cktqc2pRZWpiODJCN0NxTkRJTEZyekQ4T29qbFg0eEU1Nm0yT3FycG4zdldn?=
 =?utf-8?B?czRFS3g0TUdhTlNlQ1RLTTNRYzJ4QmJQVEo4NmxGYWRVTG5ta2pGTkFLTnFu?=
 =?utf-8?B?NTZvL3ZXY0QwU1VqSTU3dEhoRlV5ZHU5eGhrU2I0eFRKeDVjZStJR1dyYVBl?=
 =?utf-8?B?VTh4d1ZCb1p5S0pkMnVvRjR0Nml0VzFBN241c0hHWDBHWTdvVktod2I3Z2Zp?=
 =?utf-8?B?SEZ4ZFIrL0cxWkVVR1F0VUR4bzRNeHJoQmhMZXpvU0NUVDVCdHQ1RXA1TlhT?=
 =?utf-8?B?aW5yK0VXRjVsNzZoc28ybU04OVJ2OE80VUk5b0QvSmZ1bENYaEJ0anEzU2Zs?=
 =?utf-8?B?M0E4aDArVzExSFVOWlhZdUR6WnVLeVNHMk9uM0xGU3hia3FDR2F3c1ZlVTFr?=
 =?utf-8?B?cGdzdmhSN2xIY3p5cFZsRUwvNE8xdWM4b0pKSW9Ma3hYOG9kZkJNQUFXMm5a?=
 =?utf-8?B?K2oyVE9YTE1lNWNYeVFrVFkyZDJSdXZvUTNlL3hLc3doWGhJemQxaDBrZ05q?=
 =?utf-8?B?WFNRRDNYdmhoT2tQd0hzL2ZLKzZEZG96eFFmQTdiNVdtRVZoL3dsZ2djblBn?=
 =?utf-8?B?UkdsRXlwVU4zOGlGQzlUV1orMCtJdmZnL2hudVVsUHgwUVl6bnZTR2JSdml4?=
 =?utf-8?B?Rlh2SmVrVkUxditjN3hXWEFiWTVNT2RyZ0Vnb0sxd05oejJlbmgzMGRUVnk5?=
 =?utf-8?B?V2dWS0NuTyszelZ0dHlEUkFEaVhCejk3dDVBbUZNcE1nZG9DVUh2d0FVWGQ5?=
 =?utf-8?B?NjJtb1NHNEE4TGkrRnMwejVEa2RHeWw1WTVPcitKM2FHNGJENC94NWFEM3VC?=
 =?utf-8?B?LzJyaDBDSVdmQjZkdWxkcER6ankvdEhORFdhb3MyWlRUanBCWUNLVnJoS0s3?=
 =?utf-8?B?Q1ZKaXVwOHExRWMvbFNCNWt1WHFiUER3MHNiSHlmMExoTnFRWFZ6eXdXVEFn?=
 =?utf-8?B?K0xwWmRNZkhwMmxOZUNvTE5DQko1eUcrc2FYbFF5K3lnaDc0bGZVN1VyUG1m?=
 =?utf-8?B?K283Zkw2REIxV1MxaXBvYkRBaXBFUWRONHdkaElZdWVzZlpiZlB1anRGQkht?=
 =?utf-8?B?L003eXV0VTFINXhZeTVqUWlWai81VkVtbUw5UStibFJhaFdrdGJjN3JPWklv?=
 =?utf-8?B?aWM1cXFiM3diUVpyQk8wUzdUcHlSbHdULzdFYisvQUhYNkc3QlBkakZsTnVr?=
 =?utf-8?B?c2FFWnVjR2IySUFBa1F4RHlKYWJuKzF5Y2w1OU9Nd2d6L1ZZai85VXNjVGZl?=
 =?utf-8?B?c2tOeEZ1Sk9yejZrd3VzTDR4NUdVTU9ZN3VJOURIUHFlbStFT3JwWGdIK3pv?=
 =?utf-8?B?d0lPVXhucGtGUVRMeGUxeFVVS05YRi9NTDh4Wi9HWnhMQ09jYnRIYnhlVWVU?=
 =?utf-8?B?c2dmWGF5WUR3Vk90bnhmUkZkODRhWnUxZ3FxTTJCdTdLdTF5ZnFNOUlYQnFH?=
 =?utf-8?B?T2s1dlM5azZGeUUvUjhCZzI4emZqMkhPa0c4VkZsd1FoOTdTMXdnNldPSGU2?=
 =?utf-8?B?UlNpWENaYmhCWURZTkw2N1dISld2WVFWRHJhcFlrQkdQMGFLNjhkQ1hvYnhi?=
 =?utf-8?B?QzRFY0NYdVoyODBoRTFGeHE3RjZqL0pZbjZCYS9GRnN4TmJVUUt2aWc4ajA4?=
 =?utf-8?B?KzlUdVZMaFFSelZmeGg2dEQ5SmQraUErZTdXRzNzUFRjdmRHcnNsYVlFRWhD?=
 =?utf-8?Q?djow6fQmcVkm6vsvVq+e7K/pV0QvBgNKqGisd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf47ce93-2780-49fe-36f6-08df438de728
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 03:01:26.0320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6nv1pHRho3RcwoNEMia/JoRghxgN+RN367BlimL66Od/LuGHQ/bTvV2mQAAk10/f2s7HmqGE1XMTcmyGW6jvmjvo5+ichuz7toaACzCkeOGBUQ8feGbwHE12y4Z4BVE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11778

From: Peng Fan <peng.fan@nxp.com>

Convert edma2 and edma3 from flat interrupt arrays at the parent node
to per-channel child nodes (dma-channel@<addr>). Each child carries
its own reg (real per-channel MMIO region) and interrupts property.

edma2 (64 channels at 0x42000000):
  - Channel N at 0x42010000 + N * 0x8000 (size 0x8000)
  - Paired interrupts: SPI 128-159, two channels per SPI

edma3 (64 channels at 0x42210000):
  - Channel N at 0x42220000 + N * 0x8000 (size 0x8000)
  - Paired interrupts: SPI 256-287, two channels per SPI

edma1 (imx93-edma3, 31 channels with 1:1 non-paired interrupts) is
left unchanged as it uses a different interrupt scheme.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 774 ++++++++++++++++++++++++++-----
 1 file changed, 646 insertions(+), 128 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index d20c2498b9aa..64570703ce6c 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -635,148 +635,666 @@ edma2: dma-controller@42000000 {
 				compatible = "fsl,imx95-edma5";
 				reg = <0x42000000 0x210000>;
 				#dma-cells = <3>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
 				dma-channels = <64>;
 				/* channels 0 and 1 reserved for V2X fast hash */
 				dma-channel-mask = <0x3>;
-				interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>;
 				clock-names = "dma";
+
+				dma-channel@42010000 {
+					reg = <0x42010000 0x8000>;
+					interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42018000 {
+					reg = <0x42018000 0x8000>;
+					interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42020000 {
+					reg = <0x42020000 0x8000>;
+					interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42028000 {
+					reg = <0x42028000 0x8000>;
+					interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42030000 {
+					reg = <0x42030000 0x8000>;
+					interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42038000 {
+					reg = <0x42038000 0x8000>;
+					interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42040000 {
+					reg = <0x42040000 0x8000>;
+					interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42048000 {
+					reg = <0x42048000 0x8000>;
+					interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42050000 {
+					reg = <0x42050000 0x8000>;
+					interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42058000 {
+					reg = <0x42058000 0x8000>;
+					interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42060000 {
+					reg = <0x42060000 0x8000>;
+					interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42068000 {
+					reg = <0x42068000 0x8000>;
+					interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42070000 {
+					reg = <0x42070000 0x8000>;
+					interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42078000 {
+					reg = <0x42078000 0x8000>;
+					interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42080000 {
+					reg = <0x42080000 0x8000>;
+					interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42088000 {
+					reg = <0x42088000 0x8000>;
+					interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42090000 {
+					reg = <0x42090000 0x8000>;
+					interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42098000 {
+					reg = <0x42098000 0x8000>;
+					interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@420a0000 {
+					reg = <0x420a0000 0x8000>;
+					interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@420a8000 {
+					reg = <0x420a8000 0x8000>;
+					interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@420b0000 {
+					reg = <0x420b0000 0x8000>;
+					interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@420b8000 {
+					reg = <0x420b8000 0x8000>;
+					interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@420c0000 {
+					reg = <0x420c0000 0x8000>;
+					interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@420c8000 {
+					reg = <0x420c8000 0x8000>;
+					interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@420d0000 {
+					reg = <0x420d0000 0x8000>;
+					interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@420d8000 {
+					reg = <0x420d8000 0x8000>;
+					interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@420e0000 {
+					reg = <0x420e0000 0x8000>;
+					interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@420e8000 {
+					reg = <0x420e8000 0x8000>;
+					interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@420f0000 {
+					reg = <0x420f0000 0x8000>;
+					interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@420f8000 {
+					reg = <0x420f8000 0x8000>;
+					interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42100000 {
+					reg = <0x42100000 0x8000>;
+					interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42108000 {
+					reg = <0x42108000 0x8000>;
+					interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42110000 {
+					reg = <0x42110000 0x8000>;
+					interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42118000 {
+					reg = <0x42118000 0x8000>;
+					interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42120000 {
+					reg = <0x42120000 0x8000>;
+					interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42128000 {
+					reg = <0x42128000 0x8000>;
+					interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42130000 {
+					reg = <0x42130000 0x8000>;
+					interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42138000 {
+					reg = <0x42138000 0x8000>;
+					interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42140000 {
+					reg = <0x42140000 0x8000>;
+					interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42148000 {
+					reg = <0x42148000 0x8000>;
+					interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42150000 {
+					reg = <0x42150000 0x8000>;
+					interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42158000 {
+					reg = <0x42158000 0x8000>;
+					interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42160000 {
+					reg = <0x42160000 0x8000>;
+					interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42168000 {
+					reg = <0x42168000 0x8000>;
+					interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42170000 {
+					reg = <0x42170000 0x8000>;
+					interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42178000 {
+					reg = <0x42178000 0x8000>;
+					interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42180000 {
+					reg = <0x42180000 0x8000>;
+					interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42188000 {
+					reg = <0x42188000 0x8000>;
+					interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42190000 {
+					reg = <0x42190000 0x8000>;
+					interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42198000 {
+					reg = <0x42198000 0x8000>;
+					interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@421a0000 {
+					reg = <0x421a0000 0x8000>;
+					interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@421a8000 {
+					reg = <0x421a8000 0x8000>;
+					interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@421b0000 {
+					reg = <0x421b0000 0x8000>;
+					interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@421b8000 {
+					reg = <0x421b8000 0x8000>;
+					interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@421c0000 {
+					reg = <0x421c0000 0x8000>;
+					interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@421c8000 {
+					reg = <0x421c8000 0x8000>;
+					interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@421d0000 {
+					reg = <0x421d0000 0x8000>;
+					interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@421d8000 {
+					reg = <0x421d8000 0x8000>;
+					interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@421e0000 {
+					reg = <0x421e0000 0x8000>;
+					interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@421e8000 {
+					reg = <0x421e8000 0x8000>;
+					interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@421f0000 {
+					reg = <0x421f0000 0x8000>;
+					interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@421f8000 {
+					reg = <0x421f8000 0x8000>;
+					interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42200000 {
+					reg = <0x42200000 0x8000>;
+					interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42208000 {
+					reg = <0x42208000 0x8000>;
+					interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
+				};
 			};
 
 			edma3: dma-controller@42210000 {
 				compatible = "fsl,imx95-edma5";
 				reg = <0x42210000 0x210000>;
 				#dma-cells = <3>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
 				dma-channels = <64>;
-				interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>;
 				clock-names = "dma";
+
+				dma-channel@42220000 {
+					reg = <0x42220000 0x8000>;
+					interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42228000 {
+					reg = <0x42228000 0x8000>;
+					interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42230000 {
+					reg = <0x42230000 0x8000>;
+					interrupts = <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42238000 {
+					reg = <0x42238000 0x8000>;
+					interrupts = <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42240000 {
+					reg = <0x42240000 0x8000>;
+					interrupts = <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42248000 {
+					reg = <0x42248000 0x8000>;
+					interrupts = <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42250000 {
+					reg = <0x42250000 0x8000>;
+					interrupts = <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42258000 {
+					reg = <0x42258000 0x8000>;
+					interrupts = <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42260000 {
+					reg = <0x42260000 0x8000>;
+					interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42268000 {
+					reg = <0x42268000 0x8000>;
+					interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42270000 {
+					reg = <0x42270000 0x8000>;
+					interrupts = <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42278000 {
+					reg = <0x42278000 0x8000>;
+					interrupts = <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42280000 {
+					reg = <0x42280000 0x8000>;
+					interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42288000 {
+					reg = <0x42288000 0x8000>;
+					interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42290000 {
+					reg = <0x42290000 0x8000>;
+					interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42298000 {
+					reg = <0x42298000 0x8000>;
+					interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@422a0000 {
+					reg = <0x422a0000 0x8000>;
+					interrupts = <GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@422a8000 {
+					reg = <0x422a8000 0x8000>;
+					interrupts = <GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@422b0000 {
+					reg = <0x422b0000 0x8000>;
+					interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@422b8000 {
+					reg = <0x422b8000 0x8000>;
+					interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@422c0000 {
+					reg = <0x422c0000 0x8000>;
+					interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@422c8000 {
+					reg = <0x422c8000 0x8000>;
+					interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@422d0000 {
+					reg = <0x422d0000 0x8000>;
+					interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@422d8000 {
+					reg = <0x422d8000 0x8000>;
+					interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@422e0000 {
+					reg = <0x422e0000 0x8000>;
+					interrupts = <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@422e8000 {
+					reg = <0x422e8000 0x8000>;
+					interrupts = <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@422f0000 {
+					reg = <0x422f0000 0x8000>;
+					interrupts = <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@422f8000 {
+					reg = <0x422f8000 0x8000>;
+					interrupts = <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42300000 {
+					reg = <0x42300000 0x8000>;
+					interrupts = <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42308000 {
+					reg = <0x42308000 0x8000>;
+					interrupts = <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42310000 {
+					reg = <0x42310000 0x8000>;
+					interrupts = <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42318000 {
+					reg = <0x42318000 0x8000>;
+					interrupts = <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42320000 {
+					reg = <0x42320000 0x8000>;
+					interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42328000 {
+					reg = <0x42328000 0x8000>;
+					interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42330000 {
+					reg = <0x42330000 0x8000>;
+					interrupts = <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42338000 {
+					reg = <0x42338000 0x8000>;
+					interrupts = <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42340000 {
+					reg = <0x42340000 0x8000>;
+					interrupts = <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42348000 {
+					reg = <0x42348000 0x8000>;
+					interrupts = <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42350000 {
+					reg = <0x42350000 0x8000>;
+					interrupts = <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42358000 {
+					reg = <0x42358000 0x8000>;
+					interrupts = <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42360000 {
+					reg = <0x42360000 0x8000>;
+					interrupts = <GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42368000 {
+					reg = <0x42368000 0x8000>;
+					interrupts = <GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42370000 {
+					reg = <0x42370000 0x8000>;
+					interrupts = <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42378000 {
+					reg = <0x42378000 0x8000>;
+					interrupts = <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42380000 {
+					reg = <0x42380000 0x8000>;
+					interrupts = <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42388000 {
+					reg = <0x42388000 0x8000>;
+					interrupts = <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42390000 {
+					reg = <0x42390000 0x8000>;
+					interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42398000 {
+					reg = <0x42398000 0x8000>;
+					interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@423a0000 {
+					reg = <0x423a0000 0x8000>;
+					interrupts = <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@423a8000 {
+					reg = <0x423a8000 0x8000>;
+					interrupts = <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@423b0000 {
+					reg = <0x423b0000 0x8000>;
+					interrupts = <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@423b8000 {
+					reg = <0x423b8000 0x8000>;
+					interrupts = <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@423c0000 {
+					reg = <0x423c0000 0x8000>;
+					interrupts = <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@423c8000 {
+					reg = <0x423c8000 0x8000>;
+					interrupts = <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@423d0000 {
+					reg = <0x423d0000 0x8000>;
+					interrupts = <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@423d8000 {
+					reg = <0x423d8000 0x8000>;
+					interrupts = <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@423e0000 {
+					reg = <0x423e0000 0x8000>;
+					interrupts = <GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@423e8000 {
+					reg = <0x423e8000 0x8000>;
+					interrupts = <GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@423f0000 {
+					reg = <0x423f0000 0x8000>;
+					interrupts = <GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@423f8000 {
+					reg = <0x423f8000 0x8000>;
+					interrupts = <GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42400000 {
+					reg = <0x42400000 0x8000>;
+					interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42408000 {
+					reg = <0x42408000 0x8000>;
+					interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42410000 {
+					reg = <0x42410000 0x8000>;
+					interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42418000 {
+					reg = <0x42418000 0x8000>;
+					interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
+				};
 			};
 
 			mu7: mailbox@42430000 {

-- 
2.34.1

