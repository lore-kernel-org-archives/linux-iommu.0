Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794469761;
	b=iAxsk31/ijVuF9/jmz91UZNOTiaJDBCNoQ/ogVW9rhbp4EyujurdMCxjKM6gNAUhSZsa
	 56RN+Z7EkJIcmWMKy/MW3rfSbJ4du/fHw+KQhNmwKLe1sZyKKTwuRoyvpsIEdRGZc+csq
	 ugm+iNsc4ZFBJPUy0ggKKPHocEDTEWuIEQN5op7+MbWCOomeVZxSghoiHcXSAWVt+glXC
	 cXEnhSh4Z+v+OJSajRABw0hKnaAx5mDFnppYhuIzKaJDbwTp5c88y6YLpihT7Hv67fLAf
	 K0OEgYJodpGJ01/koXUNcK70w+/3AHJSChbkYBrRyDDSz4+rlkn85iJHhGyzbbYAdzg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794469761;
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
	b=YpG1IQckl2FTtAvIqLD3GDtO8XXIAKJLmN9EC4LxVbCIii+LKrHO40fCxYfdyMOZNxB9
	 TScaRZtKhTsCYgwPv28IlVVVArYFO3Ju8gWqKEYptF1SwTkLvNrEEY5SNqnyZ9ysu07SV
	 wuhm+wP4c34JvuzSzuIZJ6n50sEgTkl5yXNfddYXBFgDzr9xCRLx+0vCrVG8fUYU/wL3+
	 zpSncV5frLVa3iH58taCgfR2xYv/alAJf7VNZ/AUQHCiVbk9m7u7GyBOPicv+go8LQwu+
	 F0Ckv/NSxn2bA3nuOMDxZ27mtM03gS0SwslUtDYGQx76sn5f4CsdcPZTPBF576uv/cg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=CC8sap8B;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.70
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013070.outbound.protection.outlook.com [52.101.72.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6A560A5BDA;
	Thu, 12 Nov 2026 07:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C6A560A5BDA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=CC8sap8B
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cIaeft3HjHeut8KnEXR7CvT7aHkgKBl58GpMuZEpKAySWFdvwPxhsAB3Tse3yPTZ1zGT0cSxK97b9fwfJ1BV30CCzxie++gZ26wqFJ7640WGceWTEXrpQAtT8BhfTj97tYv6u3zTBK6qcFO23vVBEfp3vIACjDRGXhpTw3LAC7JMza/kucKfo8tzMVBdbBBukojGpfBNo/KxXKDdpKMguMIrO/7BtiZ7zVnkPDiu0ZEW0byUS6ORYA7oMQB6GlG+1Au5Rosv0sjbQuV6+ZlyO8luJ4ttjY+xEsTs46gbHspSRYiitmyeLhiMi2L5hkPmcUOTDbbPSp/hygBRVP624Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKYYQ27MTtrrNZha95pQu8ZURoZIIyu3o1V9iakQjNg=;
 b=VxHHMD+tehMHr1RsY4fvnu6RoLZ+8dBYblzAFEtrXwoTCKx2kET+RhCRl5k06yudrl5EY3qDoOne0j3KzwknRF3nKiJYy878Of4Sm1NnRNuBEogGlUbHz+lXnJVEfWd5CcuMRQuCMiUcT2zhYq3LeJRERdLU4Enovf3EoZ1je8ZkX295w6Doq3e9q2rQykzlG3WLZsQ0b6o27etSGcnnm8hJU9tPg02xasHToqO7P2mY8970v4yZMeQfAE3khtQzTi5nKmoioS7dr4gVWqU938IiOizVW5qMM5ArG7c0HMXL1+f2xxzFot/ofXIWlEov+PrVMndN0nfbBoNpmuxSWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKYYQ27MTtrrNZha95pQu8ZURoZIIyu3o1V9iakQjNg=;
 b=CC8sap8BLi2GG8zIkAuYtmk5yg5cqWhfYixe4qKLpKaucMSPN0jjFM+1wzRXKB7S3EXB0y7iA1A+6fseR6JM4SrLkcHc1Ab36dbSNVNdOcIxmGDUyRO1RKUuPyVKn1q3piCSxEB10Dys3V+a91h0rVXctdzdt+ZDQ/MYSrR2/r2tSuOYn47GvxzHVzk47rZOxvpSdJ9kmWY9HTPu219nA6XKMNHf30JN+BSsbtYFL3zZEyR2P8pcmzykUwmP8fRReL5xvqAhT7l9yY5wHxysmf9wDuY3kJNEgaxClNBln7hHA/FitfuhN7f8EdIcjw7z2GKSE050XS9XxjOocFWjdQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DB9PR04MB9645.eurprd04.prod.outlook.com (2603:10a6:10:309::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 07:49:17 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 07:49:17 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 12 Nov 2026 15:53:12 +0800
Subject: [PATCH v6 9/9] arm64: dts: imx95: convert eDMA to per-channel
 child nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-edma-iommu-v3-v6-9-b038edb8ce6f@nxp.com>
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
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DB9PR04MB9645:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f4ce156-d3ae-4d41-4a5a-08df40917426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|19092799006|23010399003|366016|921020|10067099003|11063799006|56012099006|261022105027099003|261028144727099003|261026140227099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZYLibfQhfdCM+iFHd+bweNWToIpPdR/wYCYErqi0EBbUT2VcDofHLVF86WouJT2DdiRyApbJa29mpPrrDwoED4hTJEEy+foAGgL6OtRGKTD38r8QIZEc7pTfiFH3fdKv354l9Vjf5IPMofYIORQOoMRNKZhLWPTCDt/lK3Fw2DHL8tIADV5xdHm1TBtnCWCjVmVdrJiiZPz8Ng0lCUtV2qro5Ze9QqEfMcJfNp7E9AWCqw3rxMxOm+h9D6uJI5P9FJLMHzk6qzfyJeDoR7eZOR2nODFd9lS8EsA2V2n64++QMkN07Dn/msfAG+yG5s4XjKF3Dj81JDlVso2O1dbL7UGkxmDNmnKRBRpjQvUkVpQxwCduL06udNA6tfyPH/sMfmzNiMSFlX41jVa9H4Cys7KJKK/wlhOvNJsQpPl1DLc8VMR/EpMdTfifyxwpLY4N6JyEjS6IfliChE6fvnSdKdXlS7Y3YwhHrFK6bux1KBbWgpJhvIVmEGksJOQI5OHxMVo11zNniIGOuIaHHP25KHXbM03J55DuDGLXm9RsEvc5lzw5uO9Y+Ib2JL60qZxY52EwnuDNN4meBXImgVJaA7su73szJox7AO1Drp3noDRLGtwGhokXi9hYT2kghRGCHBfQPS5ocHHRuqpX4TNSuUEbnZci/sVCftyeSi8EA23AruF8zAagyFRORHN1bYrXFtc6lv1zFN+SkhJPscCLEg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(19092799006)(23010399003)(366016)(921020)(10067099003)(11063799006)(56012099006)(261022105027099003)(261028144727099003)(261026140227099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTI4QUhMTzExM1ZJMEE4ajZVUnRlV0l6bVJYYjdPQ3ZJREdBUkJuU3lHK214?=
 =?utf-8?B?bjlpTjZuaXYzVUxzRWEvcGJsVjcxYWVrKzZVcVpycCt5UlFuVTZORXd6dmU4?=
 =?utf-8?B?UzU5MTFFcW5QZnd2VXhZd2tCNUU5bEJ3MXhVdjJrUjhCaEU3Yy9LdkIxSWFa?=
 =?utf-8?B?dXR3VURVMk5EZDlHOFh6V2pGS0JBazNpcmNTTVArQ3lSTzRWWGQ2MlVxUjNK?=
 =?utf-8?B?bEw2TDBWWlY1aU5pSWVXdkJBcEwzSmdZNXNHYS9BV3JjWitMZGR0N3kvbW14?=
 =?utf-8?B?UllZVUthdnU3YnJRQk9sTzJ0YnQxbjRIemxkR3VZalkyU0pwc09Dc2kvUXAw?=
 =?utf-8?B?YnRFaGI5NFNOVGk1b091d3FVZ0M1N0JZU2JGL3UwUG5jY1hvVzBvaysyTWFz?=
 =?utf-8?B?a2Y0RGpRWlNsV1dkenAyczlyT09tdzhnY2M5QTJkaVI1a0h3NTNQVDh5WjNC?=
 =?utf-8?B?a1ZsaG0vM3hEeDNGM0pyR2pNU3oyOXZOYnladkF4VER6SjJPZHExUHdxWlJM?=
 =?utf-8?B?elRDYmsvRGJXZkt4ZkwzenlLSGYyamF6WnJMaDVLbWd2OERjN3ZuR2t2eVpz?=
 =?utf-8?B?b3MzQXgwWWUzMC8rTmJNWmxNWW9hTWJVMFYzQktjSGNRbTJqeHJqM2xnK0Fv?=
 =?utf-8?B?YkRBc0MrT3UwSXhRaStEZ2xiM3RJbzZUcDJmTEY1U0VTR3MxOVJsT1BKbVJX?=
 =?utf-8?B?dEJYeG5DRlNaci9UQ2RHeER1Ulh5WkpmUnVabkNSMU0zN1AwZG04ekRWRW5T?=
 =?utf-8?B?YUMvZkdCVUZsdnQ0WVVpNE1JUTJONnVHSmFlV3d5N1hvOXZrdTVjaGZBS0Rv?=
 =?utf-8?B?eUlxNUFRSkV5Tm5BWkZCUjM0cGZ6OXZoZ0wzdzFsNHZoa3FJQ1dwS092UkVj?=
 =?utf-8?B?K3NiSmJkQks4L0plS2JpRmU2a3VZRlBTS3A3SlhyUXhSL1hudzhZUXhuaE91?=
 =?utf-8?B?Z0tEOGtlS2NBNzVaSmdtVmh4bVZ0cjVCWWR5ZXd5MXg5K25OMGVDZHdmbWNl?=
 =?utf-8?B?WXVwRWNXc05EejVqSHJYVHpCUGUxemtmUEFVNVJVRHAxQUNpOUd3QldQRjcy?=
 =?utf-8?B?MDlQN21JR3BtbTdtcUdncll6N0NaTUt5ZEl2c3A2a2ZZVXdHM3ZDSWxVR1Ax?=
 =?utf-8?B?Um00Z2prMTB3WkM2OG04czZkVHhCSUhQaWhmc2dxSWRqWWJLSWNrU0FQK0Q0?=
 =?utf-8?B?TzlPNEFLR0J6UVE4ODVrYm1xQnZISDZmMEluUFFRRWQydlpNOEI0T3VqVE05?=
 =?utf-8?B?U29MWHlEcnJVVFdGbUlrWXpUVWJ5c0ZXN2l6aENhNEJFQmYzVGlGa2NQbXg4?=
 =?utf-8?B?aEhtczA1ZGh0TklUNEt1SHdPTmcxVXpoc29UWG5IK3ExZFd6YWVxUnZlSi91?=
 =?utf-8?B?ZDhxRkgxeUtHNElSQysxN0x3NnBzbDNMS05VR0haayt2MmR3VXpabVVJMGVv?=
 =?utf-8?B?THA1TXE1SWgzTkw4cVdIUzhkQWpaZXhNSEJUSTZ1Q0loNlNGaDg0RVMrMTVa?=
 =?utf-8?B?Nk9zMW1yMm5RRzFYYVBISjM5SVdKaFMvQjdWVnZHZmZEUHJnTVBQSEo5NjJh?=
 =?utf-8?B?dStBc3ZPZkRYb3NHaTN0WlNHNFdmVkZIN2RQMXQxalFLbjhtMnRoN3AxZHZZ?=
 =?utf-8?B?UXlISUwvR09rbDQvRGQrOVJwZDlkNlB0enAwMFV0ZkMvNXJBdUJmT3A4SGc1?=
 =?utf-8?B?N2JueWZiTG1MZldaaW9CbmVGcDRJTjlrTUQrM3BndWFyc2xTV3Era0ZtMWF2?=
 =?utf-8?B?VHF0bVlvNk1hZVlwb2lRN2I0TllUT0Mrek1mcWtTVzQ5bHZNeFVvSXVLS3Jo?=
 =?utf-8?B?NEEydU9FVUNuQW1pRkZUb0wreFRlVzZ0TlFERE43OHZqTGxyUnRlWldHY3FZ?=
 =?utf-8?B?c24xbGFOOTNXOW5PaGc1eTZEaER4N1l2T2xNQmprK2YxU0FsM0VxUEFlYVRp?=
 =?utf-8?B?NUFUMmFTOW5tUlVlNUpWQjRHanhnNkdYWEt3N216RkdNdThPa1B0QnNzbjhU?=
 =?utf-8?B?ajV3Q3JzbDFsZGo3WGU3V3kwbGJlUlRnczJaQ0w2WUYwRFZ4Y1lybWUrSnFx?=
 =?utf-8?B?ckV2SVA1T2ZjS1duU2RnWmlPSjMrTzdwVmE4SWlWaEppbkt6dy9acE50eWJ6?=
 =?utf-8?B?M2V4VnliOGY1RXJvUGdRak10QXBKaGNaQmlXWlJvUVU4bHBDbi9xUjBDOXJw?=
 =?utf-8?B?TERoYVVPZngzbXQvWDMwdWxWSVF5c0pjSS9yalNQV2x5MDlvSHRRSkZjYzFN?=
 =?utf-8?B?SUlod1hiOGNGazVMT1FncURrTm4vbzd0ZFFhNTB3S0NFNnp5WEZCV1JWelMx?=
 =?utf-8?B?dmpRMUJuU1Z3WFkzNjUzVS92dFRjSXpXVE1uKzl6MmVhU0hPcHFoY0hrbnNX?=
 =?utf-8?Q?aSwDz+tBQFt9eWkg8OpV3ux9HbxXGQAfgj00i?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4ce156-d3ae-4d41-4a5a-08df40917426
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 07:49:17.5930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8yzGAkcv6nAwfWb/jYZiNWHp4h9wJ9Pf3B/B0odSvcn82VcHFAABTz73wH7GKHoWiN0eJkKTQH9kICDRp+RTfdCzb25+EEZfeRfWFKKZ8VmIAi3ArR3lNcbpYkN0nN2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9645

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

