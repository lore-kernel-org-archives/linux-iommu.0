Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794469723;
	b=cL4QWTq+e3Jcq8RDxCbul+zkwd68c+CMuRftKmbLfKoZx/7OeiLm+Bimpm9jSj+AAMmP
	 RBykbCcShkAczrKMV71j8Xs0Eu7rHY2wcQrfkLFcG/aaiPEX1dfu1z90L2/BdLJ7o1enf
	 AlWeG8wauis92HXdMLIBPbVU5NmNGe1TA6IClcFuc10AgqHuE+Z9fGk/w5BGqIbJI5Syh
	 KDLtDrJTjtnh2NHVrNgygaK92abq0fCAIqEbsx6eZyBStpC5dCmfkTFtWhqdTO23c3umg
	 Bk2Z7LTZi2/Cd+/x8o2+BaygzSvmsGpKrtCejYXEMoCyecVQp4g0cnUaorN1M/39Obw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794469723;
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
	bh=ikQCnHOHFP2+XUglJTUtpFT7+r2FgjUaBXBBrRH9h9Q=;
	b=znUNDonX3cDnHpBLfGMisSrfkq5/iHM7lq61pvsq14h3j2GqwfeAtHBGakFp/D+GJhiA
	 HC+byDAvIwP5FiomEula06FKy+Y43z8A23tGOEhdUcQwLRCyS/paPodOpic+qJoa1pDNw
	 mYsXysESjZ1fds6XvxkCwVoqQdNba2rihbuoOklRIE3HpQcPTS8l5SBtDTdfI5PCwRupp
	 2XGB2xBBmdbRmKtw8YqAzJ2SCFmnAszmgfnDoN2xnmtZCrUgXDwaWUtb0Ojo6/iYmcBz8
	 RHhtlvxwN04conldH0cYtbbmYv+5hBXvArawAhNsYUzjEMHZfQrXLKU6mmjH67G4LZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=oLmZ9MIO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.21
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013021.outbound.protection.outlook.com [52.101.72.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CFE606A88B;
	Thu, 12 Nov 2026 07:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58CFE606A88B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=oLmZ9MIO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PbUpRv9S8+ixF1tVG3Sc5XfAIEgYXol+GnCyLcZ3rMwbeLEe2uLUbkeNmTLK+Zbm5pfrhf/KO5rdpp76IG2Xx5dqTgZBG1a5Qhlnxbpjx0WzEW6l0478uvL/UbchEGQPkGwkqyK56+MYGbj+w4k05968iJkIfZuwdP/spP18nW/5yfQaoFBL3MSNdQGoiebfEQNauB0ljR3krGo3ufm5zPrfHOo1WyPJ85MRSrCkaetkOMDh7iklDKxCLJCKQkgcmAWMz/O6PsZETJhN457ijHmd8bvCFCb2tYLTG3PgMrpfZRalSU1B2Z/+axkVui187VreR8k4thJKDghRdbpeyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikQCnHOHFP2+XUglJTUtpFT7+r2FgjUaBXBBrRH9h9Q=;
 b=Ddw4roTMEAsn4v0jFfmMXgoKrpPc2gtxaGbnflwOQ3N6TbWJ1FwiwHBADZhc7Tug5Xva6+lMG8NT8B2CCGDPWfMpbVxj1TbRWXUHvpyWHdURPUwTG+KktnV5psYyo1nmlYyWhI/w4CGQ6SwAsimWcY2el29oTtvfR3nsUFTrF1GniLlQNT7FRpe8q/gbvkr70KIpefG1NHhWTQTFptS7GonpfhHBRsIQlo/TDEpn7feDJXDEjSZtTH6lZiecSy8+U6dPHXfcKWsIcQl3lJcufQPDEUPAeKQOlF+WlH0lt/XAJDpW0xWenESqi03zlp6ib/9j6UN2EbFDq7vhQBuTOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikQCnHOHFP2+XUglJTUtpFT7+r2FgjUaBXBBrRH9h9Q=;
 b=oLmZ9MIOoQKjI1BkJbs/UZsmSuuy/fM+pR7xU/VQAfq2Zhrebyezj+yWwpwVeEIlgTtMfKjmD6w16IjgczmYZujfSaOvh+T90Y/eVQH/yC1yuTwHyL5Uw2bQOiYrDj+znb+QpeqCSrBIpeQPQNmI+a+Nd4z0kdpwz5pGb+792ptPmpJaw5ctczT4QGfQAxJuYCm4opu3oHpQc6d4VpyL+d4vGhOmjS7K1ZV610Op0mvoomGytADSGzpIHSIrhoSi8qoZ12JwRHUa5+xLmXcE1iOHjoozT7sUBI76zyyGT7nP1b9WNK3K3Nz0fNb9J4iZxKt0T73Ev3Yfey/iwpC1DA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAXPR04MB8909.eurprd04.prod.outlook.com (2603:10a6:102:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 12 Nov
 2026 07:48:40 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 07:48:40 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 12 Nov 2026 15:53:06 +0800
Subject: [PATCH v6 3/9] iommu: register the DMA channel bus for IOMMU
 notifications
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-edma-iommu-v3-v6-3-b038edb8ce6f@nxp.com>
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
X-ClientProxiedBy: MA5P287CA0253.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f1::7) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: d3e4960e-5073-4eaf-f61d-08df40915de0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|23010399003|376014|7416014|366016|261026140227099003|921020|261028144727099003|261102123227099003|261026121527099003|11063799006|56012099006|261022105027099003|261021121427099003|261009223027099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	IuEnwNrpRcveTdTgIWBQ2cW9CGuDRH5DZm8kV3hUmtsr1aUTKMQ7nTrAXQ7WVjTxpw79bYtRXoZPfK7f57LVg8ZA6BUmQP+Oh2/bKLUtIkgFW+ALyKTAdp0E8U3K1Oi597Mf7VgcCbWxNlvRfUHmdKDD9wCwUMtZj6Y1QnfW/QsN63Htiu9VN1Lrmp11ro1bSQaUFAEpeRyupHZilMq8gy/UsKaWb3Kib4HRJ8zYDNS52UhIVSOaeL8QW9Td+BCqBBZUz+U61CwFAhXMCHXuNpO7j1+4NjeA/Jb9Gcyq7mldC6rVBwugw7C4FN2bFfrgl6OFi6yj8RQfQerJuULQ8oDrDlkGmOh+uqvOA/19o87aUD52RrFiuaoTGySXu/MZaE939AzDAs0zgPAJF5lPu9L8HS74YmFYPQzVzvAxthSD0vXYB1Gwqf4zeuwl7jgDYUDNkzvxdMR21HXz0L+n9mmRfe1XfNyMs5ncXNh2jcKhXkiWt2NsVzjIQP3h5DL/f01GLPZ/+k4amgFdLwZuhUnJO+lWEl9E8V50+IFmFkWGbmWz3PpjbDZRn05av4Efy7i7cri0s0oLvRkfWEwFTMFCZAEjI+OqfXgrnER07aTkpDrHXgh+WI7BBLLRqrvKi4+davV5XS1pRSpw+j6ATmTFUZD9TMNdD0M7+wVp8IJ1ZcqmTQEXJqZajzz73OMa+qCTxa112zu3meAbJAlPVA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(23010399003)(376014)(7416014)(366016)(261026140227099003)(921020)(261028144727099003)(261102123227099003)(261026121527099003)(11063799006)(56012099006)(261022105027099003)(261021121427099003)(261009223027099003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anl6NDR4MnVxV3ZRNnMwT0JMckRJZWUxY0srZ2V1RWpQL1Y2YytKc05Xd1U3?=
 =?utf-8?B?dXdJa2FUTG50Q1pIVHphV1U4akF3cS9vZGpDQmE4UzR3aVB6RmU2MlRSTE4w?=
 =?utf-8?B?U0JDQVF0dERBc1VsWDFuRURodUR5M1R3OG1VWHFFT3JIOXdTUmFzZVpvOTQ1?=
 =?utf-8?B?TjBLSjViRXhqNWd4TGR4RVdUcWkvcEZpTW02N0RHWEUyc3c2WkRxT09FUmFr?=
 =?utf-8?B?VUpWMkw0UUF1NzRPaCtFdThiaFMrVHE1L0t0Z3hkblJYaGRzN2FVaXJyVllK?=
 =?utf-8?B?RGpBaFAzSmwvY0FCNENUOVpEN0ZKWDZGK3Bvbng4b3hkOGpOODc1SGQ5NDlj?=
 =?utf-8?B?SWVsMTJHZ2tUcWRkWE50UjhuWjlRcmEyaUR3M2hTMGZqOXZURVc1c1BXQUtL?=
 =?utf-8?B?MDNhN2JnMlN3cHoyVnlRTmcwalRZZWF6czJ0MTdJWUVQZVBDREovdjB4aDY0?=
 =?utf-8?B?bGFJQXBGNnY1blludFJ3aXFxRG1LUFhlM09nVDJXZ2NVOFRLMW93amE1WkdL?=
 =?utf-8?B?dGg4WUdyOTQ4N0dkQnhiaCtWWFZEMmkvSFJ0Wk8yUFoya0huVEVkYjc4WXJY?=
 =?utf-8?B?cDhIanpKZ25TVTFTV1ZYdC82Smtvc0ZFQWs2dFVTb2RhL2tqNW1ESnR0Ym1x?=
 =?utf-8?B?aHNIM3p4aHBhd1VIeHQ4OTJBZWdzQ3lsblpFSVBQUVJDNkNxQjU0YnJJODFF?=
 =?utf-8?B?cHZCQm1OSjVNZmJQSGVsalF5TFJhTUw1S3ZTVVBHd0hzVmpnOGVNMGxHVkRm?=
 =?utf-8?B?NlV2UjNWMlZYNFgzTWI1RDd6aCsxR3NCaVdod3kxQW5VcTF5OC9TOTFVMTVi?=
 =?utf-8?B?MWRHcWg4aXdXaU1FeXJNcnJBTk1oZFo1NnJFYWYvNjVGZ3IzNHRXa2NnaDdF?=
 =?utf-8?B?enhoMmJXc0hWRTA3eHNiY1pvNDcydjMxdWx2Mnh5RkRST0VudVMzL3IwSS9N?=
 =?utf-8?B?bUdrYmtURVhReU5OZjBYRkFJYzh0SWdHZ2t3cCtPNGJoQUx0bVlyMlFIbWs1?=
 =?utf-8?B?bzMvL0NQYUU1UCtUckpJMnF4Qk13bHRxQ1VIN3d5cUdHSzZWemI4b3NMak9s?=
 =?utf-8?B?aHBUa1JteVg5dDJwcnJyVUlXaUVFTS90azcxUTR4VGwyL1haeEtKekpnakg1?=
 =?utf-8?B?aWpyRjJBTExCNzhQcU1tWjA3TWRYQkE2dE5ETUN2Q0NsU1NPb3IvQ1ROR3Fn?=
 =?utf-8?B?eDJFSW54OHpSNC9iN1VqaWFpcTRvR3ZPTUN6R0M2T3hEQ08rdU9HaWRvbVAz?=
 =?utf-8?B?MGhZTTdzS09pVmlOTnFRakV4YnM0WWpwYTR5WStvZTUxc1p2UGRGb09JR29k?=
 =?utf-8?B?ckdLN3lVWWZIZktGaVlOQWVGRFpvVFhiMlo0NVJnMXhhdHc1ZU9RNHpuWWRG?=
 =?utf-8?B?eEhwMXFhWUFRaFc4cDR5V3A3cmJsdE5xVHFnc3paVGZZSWcrMTdFaEsvR1Jh?=
 =?utf-8?B?RE1mZjB2dStGdDBhTzdLNW1Fcjg2OGVyUGtneWZxOWZjSkZiV21xR2JlNmNL?=
 =?utf-8?B?ZHEzTHI0QVhBVWhSRGVpNE1JRkp4Vk1raFliK2hrQlJhUUhaNnpiZi9LWEJo?=
 =?utf-8?B?dFh1Rm1XakpxaDd2VnFydlNCbzkyMUpPL1I2b1BxejZ1Si81UjluVVBBMGlD?=
 =?utf-8?B?TTdzcDNvTEVEQlBlYUhHcys4Y3BQQVVoY0xNNFRxd205dEdTTWltTzR1Qld4?=
 =?utf-8?B?dWdweGU4SVhZZDFsTmRDVDdjVlFaMW5BMms4ZGQyVUYrOGw4WGpCOEFTNk1D?=
 =?utf-8?B?Q2Q0eHd0Sk5tQTc3K0tTNDAydjFBZUd0bk11SzNneVFCWkN2VDZETEZlUXl1?=
 =?utf-8?B?WURsUVhSODBVZnljSU9ITW9WZlo5YjVlRkZLRUZuSWxiZCtkOHVQVCtISzdM?=
 =?utf-8?B?UlNDMWVvS3JnY09YWmNxV1I5TmtXWmNrY3lyVnV0TFdLdnJ0MHl5NjVpbWlW?=
 =?utf-8?B?Ymc3emxnQmVlbmYzOC90blkreFhuSzBja2hrdXl0YWxOOXVEaU5sK2lIMk9w?=
 =?utf-8?B?MU1CZHdpOTVGMFhnV0ZtZkIrZm5NdHRueGN4ZlFEVWpPOHhKU2h2c0NNVXJh?=
 =?utf-8?B?NEczenExSFVHTk5nUVg2TkVpVXBQeVFYVi9ZNngwNENBLzBMUlk1M2pvMGVC?=
 =?utf-8?B?RVYwZTY5cUNIV0I5Nlk0WldOcHJRVFU3TFg1VmI0bWlXdHVZK3ZxNG1GQWRC?=
 =?utf-8?B?MHVOOEhsLzcvbVNXNUxncUhmZjZDNVZkYmEySThtTVZ5MjRZdVhSZDl6U3V2?=
 =?utf-8?B?cGF3TFBUMHp4citaU0IvOU1IWEIvQ2VSZW5JUUVUQ3RCV1dFc29GU01qNmFD?=
 =?utf-8?B?UVZXYURualdWMU93aEFmaUxhWnNaZlE4SkpCSU90TC9iZzE1UlI5eWR1eVBq?=
 =?utf-8?Q?ToFqLHx/PATddCQgad2BxsIZJTdwfgDaGhslf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e4960e-5073-4eaf-f61d-08df40915de0
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 07:48:40.0585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k95t8ixE0mVcbrTa9+3oBaNEQjnvNnytEQN3aiohO34F+ndSqHNIo9anN4ALO7NBSi/Os4PNZDiflEBOYH4rWCt4YN1XMXYSee01UE/TuftDbQfZANfhwYjcg4FPzCBX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8909

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
index b486b8bbd1fc..ab31cd15d1d5 100644
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
+	&dmaengine_chan_bus_type,
+#endif
 #ifdef CONFIG_FSL_MC_BUS
 	&fsl_mc_bus_type,
 #endif

-- 
2.34.1

