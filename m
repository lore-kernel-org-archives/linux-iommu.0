Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794404579;
	b=KoUTwtQG9kFjt2+X0NUG+riwom4mNaqEFo/BfCVWuoXgd/aZ10ddvMHEYzk9dMWRSH6F
	 vQAidrqOYdPygHcAGacFJde4SvlnX1O8fY3oU1tYRlwuAPJkO8o6K8YqyuiJhmduPoj4N
	 0myo+fHur0VJDnbrwRHcBHctPtJzaRYY9p7I3hzU1qVtdy/9TQz6hInVmLpDprIza39dk
	 BdvhcNgz/WGNaOVd8BCukyuvn/qnx+HQJWRUKz0pNx+7KFCTYMlTq0zbFzlhfL+WiuDTH
	 l3hX9+6kPoLCN0v8PIe6U3rAPBhsWsHKWCv65sQT71yMhBDlEgWmyjUqEFtaVQ2jGGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794404579;
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
	bh=2SOwV+gq/96MupRZON/hP4eDQReNFTMANeDIlOBzue4=;
	b=ylMZwHj4nLrgiEw+BHMUqut873O9IXHMpkInWPQG9KQTPeGLGtn/zq1a3NJ1+vKe/ZIi
	 FZnM72Dh9EPBEftN0Ne2I+6ywf6+cL1Bh66A2B5X/utMDt/xrSVYlvZkBACjCfJWHKSW+
	 ayQrafB4aprgPnZ8TXYTv0yThf/s8H+HcwK19jDlSG35+Sl2VAWXLpxxuk6W0sNJzd2Fv
	 lXsnrHHPwxuWvcbW8PzoaEGS3bf5qqFLSCOlUfK76qWYgHdbagdiWEdq7cR8dPuHYyF0w
	 qsOCmy3FkL6wvZiiQI2G/H2oxpZm+JmZ/3HnbQO9ncTosaey4KAE/ChKviauSdxrkKQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=FxOpsk7e;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.70
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013070.outbound.protection.outlook.com [52.101.83.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98901606A8A4;
	Wed, 11 Nov 2026 13:42:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98901606A8A4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=FxOpsk7e
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMbkawmPKVgLz56z5U4BhcvE4SxG4aN3zjz/y3Wx8duZU5ndHnnODKVk7ooZKk5hTZXWZshVfSYJGLZgXh+k4smV1rS/QiSO0vQhxnNF7CZt2bbuZTN9RlGmh86yZ25euvHn6CSooKK8yunwB3UMhul1PyO0xFUfAT3AXuskRW4jXlaLqkLZBtsI0aHkFy4k0rHXxrhlqQl4o1MqxaSKv2Dse0hL3TXAwMMiEqESewszRVJI7DoHF0WYxCP1G6PCHIQIO2q6PuKQ6u04aJpSr6WHRpAGWkQ2j4+U8h0hsNGaJYogRJGHjwKGFAstWW7dDGEnLQYuW7MClx/HBT6jWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SOwV+gq/96MupRZON/hP4eDQReNFTMANeDIlOBzue4=;
 b=oFcSNTgvx02/vQPTHSWS/sGDzxwfUo9pdvmHDrmrBsqxN1kk/HnGl2ynW2D0zlsteOW7C6HwdmPF7NMUB1X4l3ac+hECWjbh3xAkf9Jpxxy5cGTWkyY7Up4gmGyF0TCJaObopAtXfjkHS8PldcZi44lU4M4uFlIhpf3NyTeIh4YGkRNLbErgo/JS7tpscvE9/MfLzUuOlBu8VOfhhZIbIuk18wMz1NtKG0nihvdNaWa5/9/vCFu+s5O9HHkRf0OSCLtdl+8isr+IcF1ZVFsaLYoHsjie/JBUEXpADYW6NxUKA2rFghDg0SYxLIflgk+oc5eH84ZikTox1qVXPLc91A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SOwV+gq/96MupRZON/hP4eDQReNFTMANeDIlOBzue4=;
 b=FxOpsk7e74r9M0Os4vUrvl9FrazN3nHrdemNODoS4NSRoE6otqjsR1Un4bpmfgtOd6v/StYBXFVC6+A4QwCwrny+VxUZSuOb0AKmwR6AoukzFGf6vPKb23nBwg47GwiiG5J7FDR7xkRCPy607E7j4qcbYSY4KqeM5SAWhSnU0okeV8Jzt5FZPH3ye58NTthyWS++1iCBeBAFZPugpqpcapK93Efkc+VpYIn+Lrj+gk1VbrGzdc82xnTOrCBb2XQe6nrG37e9Zksu9rRNSGUoW4hSm19kwZNxfKHqLD6xz7Vx6HMECzBcyDceehBhwDA4Z8huqYtFicdJxt8E+MQ/6w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by CPHPR04MB721690.eurprd04.prod.outlook.com (2603:10a6:380:104::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 13:42:55 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 13:42:55 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 11 Nov 2026 21:47:31 +0800
Subject: [PATCH v5 3/7] iommu: register the DMA channel bus for IOMMU
 notifications
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-edma-iommu-v3-v5-3-2537cebe6ca2@nxp.com>
References: <20261111-edma-iommu-v3-v5-0-2537cebe6ca2@nxp.com>
In-Reply-To: <20261111-edma-iommu-v3-v5-0-2537cebe6ca2@nxp.com>
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
X-ClientProxiedBy: SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 9f0e2c48-1928-4300-d15c-08df3ff9b08c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|19092799006|921020|10067099003|11063799006|261009223027099003|261022105027099003|261021121427099003|261102123227099003|56012099006|261026140227099003|261026121527099003|261028144727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Ax4SI2i7BrRO4NA0MMloLu9pN97Z3QXjl9tO6y81P/2RNU8uOLZPqy8Eeqmepu/p0847xEX3Nn5bNqQTAUWVgFQ+0rXwsOC/A9SnDCfjX4UDGLo5x6HLdeaqSh6DTzB/tkKjIsNqZRKlV4paskSh6FdZxPRII97bmPfXQNg+e3GIbKFwBvgH6oqG8HA+Kla5/PUORNfuT0KaIomesMAQxEpk+ztkjzXDJP1yiu+JvAgfzIgpcZVSuHGqZtKkjpLQOz2Ll09FJEIm7K6zRU8jeeFCd6IvXaDFwvjkuv/IQUXhe3J5VkEOeXxKY9DWuK4RiX5Tep3ck6YQBoKhTXecgiOApPMC5xj7Nh5K86Urip8oE8PBWWLYNc7pCUCCkuuK6cQI+nob+eI6TpsFKDhdJd1LsCb/rmQpGiy7RHwRMH06fgWeMlhcL86sWRdJX2wxshcOdTBCX+4w4fvcG5jDMcyFNoZlQqHh69m9xs17pV15TPti0CxYJeHC8JoHZ+esnqOpykQMAaIaIHOJWsbmeluUpG0uKymSPRN62reYlr9mc4JSPLWecyQRy8ueGR+XFKIXYT5Zy4cESaD93BffLEBBIlfanLGaR0LAJJE5arY2q05sh0gQmkOztxiaQzvFSjJYIW+hgUsNG/on5mAeSwiwPlVHvVAtmD7j0yTYPR/P0UT7VLuN+w+utOVQda5FgOHkJLNWJinsKcONmQnuXQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(19092799006)(921020)(10067099003)(11063799006)(261009223027099003)(261022105027099003)(261021121427099003)(261102123227099003)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RCsvMktRTVJoYk9GUUwrMGFDN2Y3N0RGYk5vMVM2bXVHQ1BtVk1RTXc4N2Na?=
 =?utf-8?B?UW5Ebmk3R0dkQS9NLzVmaXZjZWJqL3owcDRSeXNIenRrNHI3eEJXdjRLZUdp?=
 =?utf-8?B?UFMxRUlCcDB0blFISEl4UU83WDVXMXJxYVpmbDVBdzdBc2laSlM5QlZSWGYv?=
 =?utf-8?B?WEI1UUltOVNpL0hqdHhBK0U1amxwVk01eXF0ZlFhUUNoY2FMM0o0SnJVbW1F?=
 =?utf-8?B?SldFRXBoSzRSYlN0MHIyL3daN2VGVFZXZWxJSzVUQlNBYlNqUWtSaFhqQ2I4?=
 =?utf-8?B?bnNVRk9tcFhkYlF4L09GM1I3S0FXVW84TW1tS2ErK3JTUUcwbzJZdXBvMUIy?=
 =?utf-8?B?UGZNRG5BaTc4dnJUT2xsWHYvQ3VsS2s3dmpFWHB1c0VkZ0ZpVEhZMG1vSnFG?=
 =?utf-8?B?NWFURnBTUUF0dnpxd3BBcEJaZlpnWXpwV0lNeUo5cnk0cmMzbTEwdDlVTFJO?=
 =?utf-8?B?ZnkyQ0lhVFhZZ3JvVjJOdHVtQVkvTDZwVWlabmZaSWJ6bkpDeWUyOFhwanM5?=
 =?utf-8?B?YjVydXBuekdWYXErc0tZM0ttNTk5d0xoaTl1Zml2N29RdkR5U3VWNnIveWtN?=
 =?utf-8?B?WmtHNENEcmRkbloxNDBPdnRwcTBtNG0va2R5ZUhGNjc4MnFYaCthVnVYemFI?=
 =?utf-8?B?aWdOY3lSTjlRZUFDdjQyb0lqSEN1U0xmR2lRS0V0UUoySXhTTXlEUEhvTVpz?=
 =?utf-8?B?d2hwK0hLWFB6d1JYWjdUOU1zQ1FBYlV5REd6Q3JKUmpMZTNVZXhDbmNuVlp2?=
 =?utf-8?B?aWt2QUlFV0Y1eGJFUFVGOE5RUDB4RmtyTjIwL0JrbXhjVk4xNFN0a2Jham1t?=
 =?utf-8?B?OWdxRCsxaHoxMGlXZis3c2gzRlpHK3kzM0FwSzFPWWZGZmFiSWxtK2pDaWdL?=
 =?utf-8?B?VjNLcmsrNjZXU2pTc1FISGtYaFVrY2lyZVlwWlpJUUVWbFdVVDd0UHRZVFVB?=
 =?utf-8?B?WnN2OE1EZEt0cE1YanZsTndVRWtnNUVTMnBWOTJkbkRIbDdKdHpHcXkwRWM5?=
 =?utf-8?B?b3Izd0Y5dHM1c0o4RG00T0taeXRZdlZuT3dEekgrdUgycnNNd0VxQUUrVXBG?=
 =?utf-8?B?bFI2SlVrMm4yNmVzRlFiN1VsVlpxa3o0cGR5WTdHUjB1YVJjTEY5Mk00eFZX?=
 =?utf-8?B?bExMVWxRQVRBc01jT2thRFdqdDE0Y2RtTzg4cWFIRWZIeWtUSTA5K2U2aVB5?=
 =?utf-8?B?QnpWK3Q5dnJxUERkS3k4dkh0azl3VXBTcytQd2FRWFpUWGM0VFhjTHljdGZz?=
 =?utf-8?B?ME9uc2RnTWFkTDN2c2luV1Q0MXg4ZzJZa2hSWnNDdlVManRucS9NekdWdXMy?=
 =?utf-8?B?SDMvby9RM2I2OEFYVmxMNGpuaE1lU2IwSEd5cWxBc2pPK2NkY29vL01XTDU2?=
 =?utf-8?B?SGtyOXFCbjErRFhmdDI3Z1h4WVNlVFR5Rkd2c2ZSOTkvTFdWSlJFWGNsKyto?=
 =?utf-8?B?eUhURjR4QXRlRmUvZDk4KzROU3o0ODFWVnl3N2pBZmRXcW9aWlhFT3Y4MnFM?=
 =?utf-8?B?TUk0N1gvK3ZRUlZ1cW1xMHF4Y0ZDVjdjaEM0b1FGN1ZNMzdZWWJPVXFLOVQv?=
 =?utf-8?B?Y0xQOEZvdnB6TlI3bG0vYmN5bVBIbUZwRjZVWEFGR2d5dVFWczJEV2pmRVFT?=
 =?utf-8?B?ME9HZDE0eUJncUtzYllsM3dEa1lvNHVTY1JHRCtyTDkzMlJzRWx0bWVWRTJC?=
 =?utf-8?B?RW9taEI3MGg2YkY0MXNRVHpwUE1zL0RKODhLUGF0YXZqNEFLY1M2NEdXRkVW?=
 =?utf-8?B?OHRtQ3oxVVBwQWRzVUVvWVFUclJTK1NHOGVQZEdlTlNHZU9JN3AxYUc1VEh2?=
 =?utf-8?B?c2V1aklYaGdKLzR6cDBhdGxOSmlFbnozMG96T1ZDM2k0MVM5NVlzNkNxNTlr?=
 =?utf-8?B?cG93TEwvZU5tOHhXcUgreGZ5c0tyR2ZINlF2WDQzekxiUC9DVk5FVFVsd05j?=
 =?utf-8?B?cHNPMytzQjZhcmtCTkVzY1Q5WHVtcTBOK29MMXRpU1VWa3JRa3pZa3ZacVV3?=
 =?utf-8?B?cEoyWlJURmRRNEJBT2VLcVNESDRQMk03NmZlcmttR0NQOEtGZndURzBhTzVD?=
 =?utf-8?B?RnVPdXNCalpZV1paQnJkSVV5VXNyMExIK0lKZ1I4ck9xZ0FtY3cyb1h6ZENn?=
 =?utf-8?B?Qnl1clpSNjVkZk0yT1FnRDhTT1BpdGRRV3RNa1M3dGRTb3ZhdXF0VktRUmpH?=
 =?utf-8?B?MFIzblVmTDNKNDhLeGxoY3hEZGhKVW8zV1FYRHZvNHVIQlFtbi8xZFVDbG9I?=
 =?utf-8?B?WnVSM0hXUjh4MlpHVUYrVFFzSXNNT1FNcEFHSmovK0RiMDZyVXhJQ1N0VUNW?=
 =?utf-8?B?cDgxdTcybG9zNThSTTJNaTVEQzNORkRCeDRRTTRjNGdPdmJBUjlwbkFCZ2Mv?=
 =?utf-8?Q?RDNRx4T+CS2I8nsuAI4xn/1fSB6PO1w9Vmxvr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f0e2c48-1928-4300-d15c-08df3ff9b08c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 13:42:55.2485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pisc9+NIuPluyFn9/p5mtEm2CL1MaW+WFQYLk2Bi9jeuP/jq5wXNGlV7DNVOU65ZhMOiqy3pSjzJMUP0JPtAkd/yt69/cpqybTx8H0mvKSNM9nN3htX1GKLuKgHPwuJU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPHPR04MB721690

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
index b486b8bbd1fc..6fa871bbd63a 100644
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

