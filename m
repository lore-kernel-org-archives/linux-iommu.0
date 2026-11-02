Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793601921;
	b=sQMJz+0UvTMp+A4CrZdaW2QhuIuVj52vY5TyICkDb5SujC0A74lfaAeT1EETBKhH/HEQ
	 Z+mQiGxrSOPHU4fksxzOF5GnYjtfhwPO2rCu6H1wziOObsmzMbOkgcSAKisg3A5OgoQ8b
	 PczoOJ9xzxtPhPbTrSkmTJtwSU9RUnt5LsKoII2Saxi1YvSo4x8LcFGGEB55t0uP0nNQQ
	 jhNJsHzOOtW8EOuyMG4ROMdkL1qDZRQnvYpQ/foh5DThTl+9fMQtvCmczGEQS5v0tdBES
	 LSp/r05/BFBZIeOSSTfVsCllv7fhfMSgUaxLDskWPBGf6d38THYn2YA4xRAfHuVRZKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793601921;
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
	bh=kg4Mv56US9j2Pms6QIIiLHOfv5UgF+nDrGF3WCu1P7M=;
	b=ikVtIXAuVMKvN4JZjPuXqK28EZOjrnI9PXEESE5cW98cII6x10MlYULvMWM5UiHBulbN
	 s7Rae+wncnf1KYNQBGUFk9u3/W2vaLnvIJVn/q9GZRh7J40yimEYrZ9DHcRC0Wnyd6J40
	 R84G23fPQ4TvOdn7FDU37MmJ5uazzOfptRRqq/gU+Xq4llsxOiyTlv98twCiz5QKR3kcv
	 KpldvM4LHeBZkG4OggxfQUVylneSo7V6+7+91dLq2bkTx2Y9DWolPE42avVQCc8JnSF2V
	 c1sz6/6GS7lzXQ2UBbkEhv5upUFEBpS3EgaLFPg56v5qRiwPGrh/EWM82MnEVbUE38g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=EegodASc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.11
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012011.outbound.protection.outlook.com [52.101.66.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C99E606A329;
	Mon,  2 Nov 2026 06:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C99E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=EegodASc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ryzNvn1jRzQY6vzF/ooQx/uyWmAMG36DMkic1TubKjsFWjx7qvsW/u2Uq4hcI08psAKTKKMcGz/JcWh7ijo8ua34EEShA2XTdCAksgLeEgKk+MEk5KW7v9hucTUAO/khc73XiUxlscbbco0fQd/bQuiP1u+S7mp0K9Y4C3DDPM9dv0KXJG2yleAOZBQeGXDbxk+/HPnr7fBevoGw0F0himWfd9Zexs0KMYHfCSFFeoQQ9+Cs7LL+00B32lylZB5HUdCug+MURPgWDU96UDcNRiS/nD1OJIc1lfJr8BAJKpEzBBUT2tyhMbzKdv+7K7WmdtZBRPy0fqyVXbhV/f+A1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kg4Mv56US9j2Pms6QIIiLHOfv5UgF+nDrGF3WCu1P7M=;
 b=A/TNwllwOQyUzupiv6QVV0D1RhtFcZWYorkduXfxZXy0ccoFgXq2wGXkU51Ge0gveQki7rxBsskXrkC+fHdpXU3PU0hPz/OFXZ1Z+bvq9exETLCkW6vMybWRDbfbT15iqg7ibQFP6GYvPNmidd3NB6ofPTywcx5zYMuSHo+M3y2vV472IADPL1l4AV9eMhwHG9XYvGaZgG6R5vOKyMJQaaaoq42K0pM8cBjnGWseYx+HpP2WT8f2WgwqawyvPv5gUArAeJo8Xmn+/lN4hdgrmUlg3f7Vw65LI3gjVPOOdyUP0UyyaGagRDIatRwJGcjz/iShg6UCq7NXiwamB2qJnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kg4Mv56US9j2Pms6QIIiLHOfv5UgF+nDrGF3WCu1P7M=;
 b=EegodAScRntppTf0fDWLgwKg0QYyOtlbqVrdIukghIWVzNOjld2UCZrPjJguhuVq0Oov1kdA1EFMUllHB9lEEeLTsdoXyGXePp5+1v0xPyK8S2jrga1tBSWd8KZRkn6LrXAu5slo0zxyhTkY/fXI2rbmkO2nmIZUZVsUVpR2z0Bi/cvDWf0CDRMkBC7OZsBh06SEE3VXIp+MM1eb9AH4qSf8Jjx/uA/iOTa/5ZGpX8UJ/PZcEsl0skUHnMVp4GSjGOMWmZz1tFdtumJvMmy6bqgDYzEJB+Jp7ayPoevaUYfApocvRgJSdvPYWcpWJXgZ9JzKVhwfFWKg6g3iRTnQ4g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by VI0PR04MB10096.eurprd04.prod.outlook.com (2603:10a6:800:24c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 06:45:17 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 06:45:16 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v3 0/7] dmaengine: add DMA channel bus and fsl-edma
 per-channel IOMMU support
Date: Mon, 02 Nov 2026 14:49:54 +0800
Message-Id: <20261102-edma-iommu-v3-v3-0-9d0e62a954eb@Example.Com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJIy6GoC/yXMQQ5AMBBA0avIrE2iU9HEVcSCGoykSItIxN0Vy
 7f4/4LAXjhAmVzg+ZAgyxyh0wTs2MwDo3TRQBkVSmWE3LkGZXFux0MjUVsYbZSxfQ6xWT33cn6
 /qv4d9nZiu70TuO8HHyh9RnEAAAA=
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|VI0PR04MB10096:EE_
X-MS-Office365-Filtering-Correlation-Id: b02c4b65-2d46-4cfb-f8af-08df38acdaa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|19092799006|921020|261021121427099003|260925022911599003|260925021911599003|260925021311599003|5023799004|11063799006|56012099006|261009223027099003|261028144727099003|261021123027099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	dNScl4aeNHfaAfAMMlHDU73Vlj+/Q/v2AV8NaqZHPAPri+bfxuNCYcx70DvCHqBjIwoa/swkXE0oZIFZGXWF2uRvkg0KVp5J69Xfx3yzXOISd/mqSyArQ/7CAZCoAWQXW9/ZhkCwxPfyC6JmUDIhbdJOb3LkkXIoZ7dMbfo5OuFMfdefiyHUQTrSbnAnCJh83czXgBO/ZNh4DbCYeF2jpXwnQ5JeRHhSDrwaRlUqITzzYdVAjHMhDebX5FLNKuf+HW59OO8FH90D7nQoPe1eJ1g/6GMHrFt+pyVhR4zU2aVZtnjxVnkRCEZumOLkeGOXR1tUGNDmUnxKBOaOuMrY6ag4OeqQ7o5AxM4MfwrM9K/Ny/8muFge8NcrTS7Asa2v4iZOOc1Zj1jY4SYrBu4CBrqAWEjKFsBXHi71DPb3lZlT/5YmQioqZA0nyrKhcmNPuQpakITq9EwmGdvnt2VWKmER7oXMg3NLNEPuY+04OIRdzxx6tavZQKn1bKy36DYSIlb5gzkPObZ0YidKJAmlzol/gmhkgTpeT1Cak0m7NFvUf1S1L3RKTi+SZSkk0J8bynvrMc+u0ymAyOfKSVeL2DiOfPL/Iog8tO/q+26HdeJwI+oWLe+6/YTRElSgjs25NSyn78vVt/ljYb9y9N4+t6z9B1EA0HseDtSjbWE6/l8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(19092799006)(921020)(261021121427099003)(260925022911599003)(260925021911599003)(260925021311599003)(5023799004)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021123027099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVNWTUl2SXdhZ0JmNlpxV0loOGFXelVmdHNHcEVIL2xJb1FiaEFERVBVUjFv?=
 =?utf-8?B?ZUd5MW1rTEh3VWVKa0ZpUWtOeW9Yc2lOSjcwSExHRkhuYUdLckpnL0NNcmlx?=
 =?utf-8?B?R3c3bkF1MDVHeTVZRFdOM3l0bXdKWXhOOVBTTkduUjJyMkhRM252QXJPSXo4?=
 =?utf-8?B?eTJOZDBCU2RTT0ZRM1h2cC9Yd1VwSU8ySFFpOUJhcExSMXlCN1pJSkh0RGx1?=
 =?utf-8?B?RHM5OGFJSEo0UTlOZ3d0ZmVhVGwxSmZSbTlGZklTSVZHY0dzT25lbmUrT21n?=
 =?utf-8?B?R0dERmQ2ZGZUNkwwS1VhK09PZ3ZpdW1kSmdQREtSK1VEWE56TnBBVmNEeS9n?=
 =?utf-8?B?cDczQlkzSWlGV3VFck9jMGM3NjdCY2QxNkcvcHhUNUNGQWw0bWdxdVFIbDI4?=
 =?utf-8?B?dkdUVSszZ2dDRzMwVFdmcDlxQ1JpK2p4VzVTMlZtcEpmVlpqTnlUVk5UWnVB?=
 =?utf-8?B?OGZhd0ZLblBKYTdRVDA5WWt6Rk9GRENES2RteGRwK2RMeW5xRVJ6clpnZk9I?=
 =?utf-8?B?c3k1c05icCtaNUpZQ0Z6eFZCYXZBV09MMmRjZE56Nm8xaVprWHVNOEg5U0JP?=
 =?utf-8?B?NWowRVRveG9BMHJyb296bmdtdW95ZUcxc1Z3bTQxOFhnR2RQbytxbERlWWh4?=
 =?utf-8?B?RHNmeEd1SjQzV2VKMWhwZ1ZsMWpXS2QxZ0RLTE5FbTZMNFRtREp0cU1NSkdo?=
 =?utf-8?B?SG1VZXFPWUtMcGFlSXlBUS90c0hNM25xdWRjUzd2emlHUnpxNGE3OXFKbFNa?=
 =?utf-8?B?enI0VFp6enRyQnhpWG5IK2d2bEx5YUVNZDVwMlZHdDN4em5iOW9TQzd2RDEz?=
 =?utf-8?B?NkErdklpUVBoanhZUkxONUZaMmdnYU5ZaTlQUm1maldzTlZPY3FuOWxxMVgy?=
 =?utf-8?B?cUQ5b3BoZ3VyU0RWWFFTcGpLSWxPWEN1TzRhZUx1cjVmc1dMTnRYeDNVOVlH?=
 =?utf-8?B?WE9tQTNvZVpNck1kY2F4M2tFN1VvUi9UaHN2VSsxSW9zZTRKNWpUZFdMdEwr?=
 =?utf-8?B?b0IrbmZjcHlhUUJiczlTNEJvRG1jSlNoMDhqT2RqeEFVQVBpQzQ1Q3FuSFl6?=
 =?utf-8?B?eUViVFVTZnF6QUNWL2pRaWJOTnRteU9KclBkYStYcE5WSmdQcFpKZ2s4K2tY?=
 =?utf-8?B?MzBpV0huRnI5VjZzTSt2Rnd6V0Rhcm5XU3BFWnpzeVM1LzM2Q1NnZE1yakQ0?=
 =?utf-8?B?SjFDZzA3R3l4M1RjV0pXeHpUd0x3RzZCNU1CTDViUWQzNWJpaElmYXkxU2pa?=
 =?utf-8?B?QkhsWjZXV3VsVDI0eXRuK1VXYzdnSml3d1BxZ2UyS2tqa2R2c2laWE5ybVVL?=
 =?utf-8?B?dHdmUzNCOHVZQzJxZTJOMGh4NWZxQURxcXFYQk9kRW94N3k3aHFxYkYvWDlO?=
 =?utf-8?B?SnlWd3lmZ0dZdTZWOEJ2eXlnM1ZaTXVnanhXMldOOUFjazdGbGVOdTNNZzFv?=
 =?utf-8?B?TURaNzRyU3pvaUptcWJxT0k4R0ZQNFRHZlBhQWpBNDUzWnlpNjFxZHhBcmdS?=
 =?utf-8?B?WUxOVDZDaGJPUWg2M09vL0tDa2t4cDlFNXhBQ29XRXJPUXdKNjI0T2JMV3Yw?=
 =?utf-8?B?RkNhTHlsT1pzOEl5Rkx2bWxUMTdaa1JYS2lidmc5cEN6bHdjcFlSYm5ZMlZC?=
 =?utf-8?B?R0NVMEl6b3pxTFd2V3NKZ0J1eG14V3lwekV2MWk5TjhxQnJISU1laC91U1lM?=
 =?utf-8?B?dFVqRFBNcFFYS00xY3ZPSXJBVmZGYlBRU25XUXpNU1FaRGRXQTZqWStzYkYy?=
 =?utf-8?B?Q0ZVc2dwSVhKVzF0eC9wZVVmcUY5R2RnYlhJQ0ZKRlZ4S21VSHY1VkJRbDhE?=
 =?utf-8?B?WXI0Z3VuWHlqTnFHTmFzV1JoMkN4eVd4R0FNUm80S1VsR3RNeEVveVA5NnVL?=
 =?utf-8?B?VndkWUxGOGREY3hGdE9KR04yTmdBY2dRdkt0NHo1ejFKU1VJYXZ6SXlUNmNB?=
 =?utf-8?B?UngrMVZHdzZHYSt3K1pyaEtFcVVKellLcWVVRkJzZ21LbkNrUTBiUUJvanR3?=
 =?utf-8?B?L2N0dHR3ZjVBZ2tFOFJKclY2VWpzVTliUUlvT0ZxZkxPN2wzOXZNSzY2bHRI?=
 =?utf-8?B?TnlRY05CR3E5U2wxTDZnbVcwMmgzQ25NK3NhZlo0bkhjczlPQTZETHV4SVVh?=
 =?utf-8?B?eG9BV2NEbGlVRW5VbE8vbUxYdHBheWhDWDZjejNsTU5DWE52cjdXUnNmb0ZW?=
 =?utf-8?B?cGkwaXJRc0RHWVhxRFB4bEpBcWNoZ2hHbUVZQlVCU2FXdWVkZytJYUpuQnRG?=
 =?utf-8?B?OVNRcnMxek9mZ0UzOVlLaldodUxFWjV1eERwSzZ3MElnVWJoNjQra0JRUDBo?=
 =?utf-8?B?OXNjcEExUjdycFlRaEl5Y3JyNVRZWjNHVU5manNwS2tHZDFVbTNrUm5yYVcv?=
 =?utf-8?Q?oCFS/NoHT35cMz8c3HJKe3kf4WjAHYP6pxRb6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b02c4b65-2d46-4cfb-f8af-08df38acdaa8
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 06:45:16.7659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VPdC2xtIAMDQK0G+kMtjiUXKSA9cUb9JS6IVyl2HrrF0Rq3to/gnKo5U+T9Pb4oIJExqLipHUl7D9XJDYgb8jSvZGjHbcKISAEbG6+9XGjFUm7gLLHRe0jKsFBuDHY5w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10096

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
 drivers/dma/dmaengine.c                            |  43 +-
 drivers/dma/fsl-edma-common.c                      |  10 +-
 drivers/dma/fsl-edma-main.c                        | 164 ++++-
 drivers/dma/tegra186-gpc-dma.c                     |   1 -
 drivers/iommu/iommu.c                              |   4 +
 include/linux/dmaengine.h                          |   4 +
 8 files changed, 919 insertions(+), 151 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261102-edma-iommu-v3-22b673717cf4

Best regards,
--  
OpenCode Assistant <opencode@Example.Com>

