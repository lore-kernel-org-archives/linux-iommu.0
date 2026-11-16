Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794798035;
	b=kDKK6bPoY1DxbUHexO7z6aYk123FEYo5YyF/izgLfr4zrx6Qvcuf5QRJv6h+dtFtcMXA
	 KBiyuSroXEnm5T7bu1rh0SWhJQZLm/2aUQUlsg7lv0ZptiMlZIabof/6HI5mpyU1TR80r
	 bf00UsmLqn8Wk5VBzbvhUGSdLd+xrgGihnTfil3gXgSFq9RIG5ws6LjKL2BXqtW1YpTKo
	 MFblmqgclrX/oJJ9Vb+6SHrohDUYgf2OJOpDVap20WfffO2vuuPS+kJ4/v9ElbXZ41usX
	 InuvSTZv0LBpIgp2NsgbIwHf5bPzyyoIyT3nlvKRo9XvbCQWOpkueuk2Wrt5gs0keiA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794798035;
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
	bh=qZxuOMJlS99jMJY8/NJ9eY2uVqvvmrpsOu0oaCbRvCc=;
	b=Gi85B/iBfa4fcocjK95dtKTT9YylTAQBoM3qhtTTa1jDz2kWzgbfzJgI0NIrHNkiOHTk
	 6fXtTilN1agb5aadh8VOGI4B1MeaDeiEdkzdBxMkAQn2/3RiteY6x6Rmfv0ryq9rrjd3A
	 kwT6fz10ixPpIknvyW3vvkD70hypRTbGXuf+zSMrbkaQYYry8J+aejEWPDHRl3w2mH8XP
	 K12VOGqgAJ9/BnXa+ju4Tddii3Bc0EJaKJQGco62pR7AVoi/66+SzGj5FMswb0ZEG7yCt
	 TdxaFSYtkHoz/3lKqlfbDoxr52q3R8nQNCeVf1QbPEKq3PQ8J9iORAAWm2fB2sok+hQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b="L/EU/bo/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.63
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013063.outbound.protection.outlook.com [52.101.83.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE104606A323;
	Mon, 16 Nov 2026 03:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE104606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=L/EU/bo/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ntI9f64CGX8jmOrGVFemmKQptEGurC/KLJRAg+58EP/SPMamtQk1i7HeqDmEqTJQq+gPCFdwusfH6QXJrNRiNyssXSJwfOxh8xidoqaC0go5qY2BVZ3O/9NuysH6s+YoShDtBkLpT+wQkF8e2W3lsDQwtOW1Wu7KN342ZVAdWzqEQ6IsQI42Uv+u18i4u3RjkKELtd07CShn/Xi+Wv/LOJQieUV4o/cAoG/ohLrCV6ixQ93avIlpvIF6GlqTHaxBLnfULcx11k59EZ3vMNjYGUYTJQgPMWs9hC7VZo6WLlhnQ+HZj7kL+Z8YaWbdj+2Ef9fNAvqbQ0ixkffKj5p8Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZxuOMJlS99jMJY8/NJ9eY2uVqvvmrpsOu0oaCbRvCc=;
 b=PXkQGopfG5PrQgxg9fhdEA1OJpmuDFRupU6BwlIICjASuibZChCGOkwoJOw3lbIC5PSuNcAAfFcc9Tz9Ft5/BSd1poC3XuYfJyVQP7YsUATVIDjdb3ijgM2KHuW+cWqLGCv+Sm5/tnU9C/pcua/2XMk/R4yDrRu0q60ESmFF8kUycHqrDCy5Mp3b0MaRcRRW0QX+OQVSv3FYb/YK05rlixLwLbWVHBakFlxAy3baO1dMiL3p0UbhTv74TbXgSwj1V90+N4TcP3swTdv3tBEZbgejYiTKSm17eIFaPlDRnpGehQQxF+Qy7dGudW9g07RuHiy8CUTpepsZCCzGNUM9VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZxuOMJlS99jMJY8/NJ9eY2uVqvvmrpsOu0oaCbRvCc=;
 b=L/EU/bo/SWdXVXC1CHi1UWaL6DWe8YuRIEQZEmKnPJLMLBctFnhGMHoXD1PxNMG791s6e5ITmGY9GPYXANwQLy6CtWPpL/bOzy7YSLDJb/5Y1+ZFY+YiLn0t5c7QbHChgL1aXfdZDpLoqAfkGCQE76nj5DOXM+QIHHBlT+hMtEvfFCet6iZhD4ysVoY5r2PHRasy2ozZCqQWUq+GLRrO4Ssvhot+Z1a//mUY0jeHeoCr6k6CMoxlJWHx3NzuC0zfpmdXZ7qPKwgoHjoRBOftCG7WZSCrMnbwxUE7xBsyGXeW9atVna3ldrjufwu2JtvycfdRF7GW7EsxLTPHljvz+g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PA6PR04MB11778.eurprd04.prod.outlook.com (2603:10a6:102:525::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 03:00:30 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 03:00:30 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v7 0/9] dmaengine: add DMA channel bus and fsl-edma
 per-channel IOMMU support
Date: Mon, 16 Nov 2026 11:05:21 +0800
Message-Id: <20261116-edma-iommu-v3-v7-0-32794ba8efbf@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPFy+moC/3WNUQuDIBRG/8rweUZaKu0pGPsVYw9qt+WYGVnSi
 P77tL2MweC+HPjOuSvyMBrw6HRY0QjBeOP6COJ4QLqT/R2waSIjmlNOSE4xNFZi46ydcSgwpYq
 LQhCh2xJFZxihNcveu94+7Gf1AD2lSFp0xk9ufO0PQ5F2/9rxclw1OXAqK1aCqi+LtMMTsrOzK
 NUD+/IJ+fVZ9CkrhAYFXEta98uQ6eRu2/YGmgCfD/oAAAA=
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
X-ClientProxiedBy: SG2P153CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096::26) To
 AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
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
X-MS-Office365-Filtering-Correlation-Id: 4c7b23ae-bf63-4b18-4fae-08df438dc621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|19092799006|921020|10067099003|5023799004|11063799006|56012099006|260925022911599003|260925021911599003|260925021311599003|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261102124527099003|261102123227099003|261009223027099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	wfL+PpEh4wA/Nxm/SRQulC3gKB5KZzC5bUISeeNfA/apHssf7gqEw1jxaBtjwGe+2z1QkJDqy/7HmZD117fsotf+5h95Js2y6pmL0Shh6H8J8BwFspof0Z2bKFeqIQA8Oebkvke6M6/Om0B7nB0AbkVTL9qEK08ukhz1FVXxe5ZXN/aL1mhUdsBb//YTQMtL8zeso8Ghflv69QjYN1tAkYjjdalNxIBR+iEN330BDd0pQ7YYqYXXLLf5I0jDT7BBBC3nIYw+JEcJgeZE6J3NHlF0YSw4AriDeBh28IkwhNLf/wVkfgqE9iL6fl6IPGqkRlB4wGJHDcH0Fzhw1a+LVkF6kdRiNnMCYN6ssd1MMaPszgJXpmA2eaz30SyoeBfvglXaFhPqBlrdwkMbWuF7kOynAPSpRHHKGtTGb7mrrFPVDzvBsPuvYz5uWU9Jd9p2/STePkBvYTocFSeg2TgYXRnZC/BjXSpXnfG6pm4LuwVbyBTkcy40nhi4xpHXcXhny6hteZnUxUmqJgWK7TbJRr+Iu0q50ibVoYm0N+7+iGE8fEl3YMKBEzDpCSc/0JZaUimzozLM5v045F0mdbq0PxHym6lJ1zqyQTltEtX9mkFgILphRzdUmRQFJjT/MbfGzbl2H4fWXCGj8zljTHpaZ4Egh2svcKq86uS70aeVOJQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(19092799006)(921020)(10067099003)(5023799004)(11063799006)(56012099006)(260925022911599003)(260925021911599003)(260925021311599003)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102124527099003)(261102123227099003)(261009223027099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bENRVHNlQXBMZ2lFMWZlQ0gvOHpCK250V2xsWmNFNHhQUGRGUXUyeUpyMW5r?=
 =?utf-8?B?OENIM1NYbTdaL3F6c1RCMGt3Y2QzN21DTWUrcFpselJVK2ZhYmkzRndKOHdN?=
 =?utf-8?B?ME1FTUoxWFBUV2JaWlhqWlRWcjUxK21VVFdVS0pjMHBUTEdYdWRpWDJXNlZ1?=
 =?utf-8?B?eEx5V3pCVVRvSXUrQzYyZ2gyMXQ2Um43V2FhMFNHU1VqRTVtS2xEdFZuVHJC?=
 =?utf-8?B?Q0lnVEVuaXRkaDBKZzlpdHRTQWQwMHZqRVl4cVJGRW96YmROTVNRU2dFVEYr?=
 =?utf-8?B?OFFiaVQ4UzdRZE5vUUplWjZWS1o1VGFXK2JQMGpMZDFTMGFtNUptT2IveHRl?=
 =?utf-8?B?ZFgyUVRoWlZkTDVXbnloUGZsUVV2M2pBN3Nycm96ZGt4VzJ4NUlvdkM3dFhE?=
 =?utf-8?B?a1hOaVJLUmp4ZVBJdGFiTjdRZXZKREFLOVd6T3dXZ29pa2l4dW9YZzVrNnZ4?=
 =?utf-8?B?elpFNEdiU1QraXZJVlRzQ3hqMmV3eEhvWnlmd2U4dTV0UEtBN2FFejlKeHpR?=
 =?utf-8?B?M2pWejBBNkZLc3RJN0RvQzZHN2Q4NjBSaEZVSkVvQ1FvcjBjWmVEZzRsOE9w?=
 =?utf-8?B?U20zNGt4MmdkK3M0RE5qUFBBVHUwUXhTUVcyMjdtZ1lacExnWnRIalRacmgw?=
 =?utf-8?B?cjRHOFVvcUNWV3pWdlZ1dG0xTENWcTFiK240SXJDRXVzWDdnR1FCNEZ4NEQw?=
 =?utf-8?B?dUlGMmhpSmwwTUR5TFVhRGNLRjNZa25adGcycDBSYWhCMEdvcmdxSS83OHRi?=
 =?utf-8?B?NUxHZDhEbENEQlMzZlY2ZUdrcjU3WXkvMFlXeEU2RTE0OG1RaVdiOSs4d2tV?=
 =?utf-8?B?UVFhRGxTb1E5a2cwVjYzZ2NHM1JEU2s4ME9mZFFrSXgzemRPNk1EUkxhQVEy?=
 =?utf-8?B?eXJEY3BBYitVKy9qNmlvRVB0MmlYUVRWQlVnczFsQmxqcHBQTUVRbUtRNURW?=
 =?utf-8?B?V0ZKSFlNa1d2b3FRZXZ3aVFlV3JEcml1UmllWGdHR0dZK2NXYjdxRjFsUm05?=
 =?utf-8?B?OG9NaWNHQkFaMkNMZWF2cFNjS2hyQ09oYzZvMFJ2dGQvUXZjSWczOTAweWNr?=
 =?utf-8?B?MWdXTW9FeU94aE5PdlZIMjF6dklYQ3FLUGdzOUFma29BaDV2TmlyTlhsU0FH?=
 =?utf-8?B?QWhIaFlJN2ZHdkhtOGNWcGMzY29rUTBEOWdxVVNISWtVRW5zcE00eTFZNXY1?=
 =?utf-8?B?S09NUUg2QWh1ZUVYOFkwYmcrZVJqVS9kOVNaZ2lKeFBzTU54Zjd4dFVhSGtS?=
 =?utf-8?B?aDR1VmY2Y1FabXVGaGI1aTV0OExYNkRzNHFpdmVKczlRa2dDYkhXZUo4WktB?=
 =?utf-8?B?ano2UStUUG90NGtmY3hUc1lzT0RXVFBMc0xjRnJQQ2MwT3FjWjE4U0gxYW02?=
 =?utf-8?B?Z0JTV0dnZkR3UTVCTXRZT1Y1SVprNlQxeHJHd01xbk9MMXVqRytlMXhUNDli?=
 =?utf-8?B?NEwxdzRMaEV5dEt6S1hBYlAreDJ3bDRsY0Q2Rnd0aitXZWwzVys1TVlTUC8y?=
 =?utf-8?B?SzA3RzZvU1JPNERRWnU3UHRMN2NPV2FwMGpRN3ZzNXo3SmEvcGlTeUhQQVY2?=
 =?utf-8?B?eWFRMklpNFYvK2pRVXZ2Zk80RUhrTHR3MkNIWkFiWEYrV0VpQnVRM2dicHMz?=
 =?utf-8?B?dFFHeW0zekJFQnBZVFJaNkQzKzZrMklvdEViV2hZbmhzSUNYUTJwbHB5RStJ?=
 =?utf-8?B?VDdzdDRCWm8zQW9tdXBvblVrZDMyUGlGYWN5UllLaVY4c2EyT0tBTWIzV3U3?=
 =?utf-8?B?TmkyUWhUMk01SUpreE90QVNKOExCOXJCdWZvTm1jcG91aVV6RHdvcVo4S3hz?=
 =?utf-8?B?d29xTE9hNkRnN2xVaXl5RmZWUFc2bXVzS1o0Qjl4NHozbEQ2R0RKb04yVjZI?=
 =?utf-8?B?VGlpZk5kTS9oaUcrc2Y0VXZ2YjQ5U2R4TSt3aUpzU2NrM3d5NFpuSlFQWDd2?=
 =?utf-8?B?bktwVUFEbC9jbmgzUVFVVnFkWVVQMUV0NkF0YlBEelhNbWU4eGgxTEtGZThy?=
 =?utf-8?B?VGRYRTI4bmt2L0VaM1pRcTFjaC91VTJWa2JNWXZ5a2hMMXFKd3lpV21RNjJW?=
 =?utf-8?B?UjdxMWZkT0dkVk9UczdkQ3o4c08zejBHRnIvNTRLSW42UHdWY1BGZ1oxZFor?=
 =?utf-8?B?WWpUODg2M3FKVXdrSUU1alhtOXgxZ1NRUzhsTVVkSkNXZGh0TkYzbDAzcWl6?=
 =?utf-8?B?eUxYNndYSUp2eGM4VkxOTnBZak1RMy84T1ZFbmFTcTZtK3V3RTdGYUU3VEVV?=
 =?utf-8?B?VnB3bUJsTk13QW9oanF5ZHptU1dRaXFGZGlaK1FEQVRSUEpQSjIxOGQ0N1No?=
 =?utf-8?B?K0FaU0hkMi9qWjFHZjJOWlFiQk45WkxDRnE5WldmZXhuQlpadU4wVUpSNElF?=
 =?utf-8?Q?6BKIiZl2aW2tuaTb8LMpbGgw27G1dieA4IGhQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7b23ae-bf63-4b18-4fae-08df438dc621
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 03:00:30.5072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cgJDaXnAodgKsRn5KP8uN9rLBI0gK6wCoPNaJfHqdcLFHwIGNnUfjUQQlj5OlYnZt9ul15cjMmVyvhd6bArax63Awo3RwAIW8mkISLeHSYytRWfKO2LMMzRiXQzyk0+n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11778

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

The fsl-edma change allows each channel to carry its own reg, interrupts
and iommus properties.  Power domains remain attached at the parent level.
Parsing the child nodes is straightforward, but per-channel IOMMU
configuration is not: the DMA engine currently creates struct dma_chan_dev
as a class device without any bus, so of_dma_configure() has no bus to probe
the IOMMU with, and the IOMMU core does not have a bus notifier for DMA
channel devices.

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
DMA bus. The bus is named "dmaengine-chan" to avoid colliding with the SuperH DMA
bus, which is also named "dma". The uevent SUBSYSTEM and "subsystem" link
therefore use "dmaengine-chan", while /sys/class/dma is unchanged. dma_dev_groups
moves from the old class to the bus, and chan_dev_release is installed
directly as the device release callback.

While testing controller unbind, a pre-existing fsl-edma ordering bug was
found: fsl_edma_remove() removed all channels from dma_dev.channels before the
managed dma_async_device_unregister() action ran, so the channel devices and
their IOMMU groups were never released. Patch 1 fixes that ordering, which is
needed to make the bind/unbind lifecycle test meaningful.

Runtime-tested on i.MX95: repeated controller bind/unbind cycles with a
local DT based on the child-node conversion removed and recreated the
channel devices as expected, with no refcount, BUG, WARNING or suspicious
kobject diagnostics.  The per-channel IOMMU path was exercised with a local
DT adding iommus; that DT update is not part of this series.

The binding and driver support per-channel iommus, but patch 9 does not add
them to the i.MX95 DTS yet. That DT update will be sent separately when the
shared stream ID support are finalized.

I put all the patches in one patchset to give people a full picture.
If need to separate patches into multiple patchsets, I could do that
in next version.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v7:
- Collect R-b for patch 2,4,6,7 (Frank)
- Patch 8:
  Remove uneeded common sense sentence in commit log. (Frank)
  Simplify IRQ error handling with dev_err_probe. (Frank)
  Use a bitmask instead of a per-channel loop. (Frank)
  Merge the duplicated IRQ and IOMMU child parsing. (Frank)

Changes in v6:
- Patch 2:
    Update commit message include more info regarding bus introduction. (Frank)
    name the DMA channel bus "dmaengine-chan" instead of "dma-chan" (Frank).
- Patch 6: new prep patch converting chan_masked tests from BIT() to
  BIT_ULL() for channels 32-63 (Frank).
- Patch 7: new prep patch converting fsl-edma to dmaengine_get_dma_device() (Frank).
- Patch 8: Use scoped api, avoid scan channel twice. (Frank)
- Link to v5: https://patch.msgid.link/20261111-edma-iommu-v3-v5-0-2537cebe6ca2@nxp.com

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
Peng Fan (9):
      dmaengine: fsl-edma: unregister channels before vchan cleanup
      dmaengine: add a bus for DMA channel devices
      iommu: register the DMA channel bus for IOMMU notifications
      dmaengine: move channel devices to the DMA channel bus
      dt-bindings: dma: fsl,edma: add per-channel child node support
      dmaengine: fsl-edma: use BIT_ULL for 64-bit channel mask
      dmaengine: fsl-edma: use dmaengine_get_dma_device()
      dmaengine: fsl-edma: support per-channel DT child nodes
      arm64: dts: imx95: convert eDMA to per-channel child nodes

 .../devicetree/bindings/dma/fsl,edma.yaml          |  70 +-
 arch/arm64/boot/dts/freescale/imx95.dtsi           | 774 +++++++++++++++++----
 drivers/dma/dmaengine.c                            |  49 +-
 drivers/dma/fsl-edma-common.c                      |  10 +-
 drivers/dma/fsl-edma-common.h                      |   1 +
 drivers/dma/fsl-edma-main.c                        | 185 ++++-
 drivers/dma/tegra186-gpc-dma.c                     |   1 -
 drivers/iommu/iommu.c                              |   4 +
 include/linux/dmaengine.h                          |   4 +
 9 files changed, 935 insertions(+), 163 deletions(-)
---
base-commit: aaa2f954c21b205a0bcd0961e5b2be4e82e58455
change-id: 20261102-edma-iommu-v3-22b673717cf4

Best regards,
--  
Peng Fan <peng.fan@nxp.com>

