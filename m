Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794404595;
	b=V6svEbgUws3TZUF8WlJrS7koijZQ6rEQBnCsV0n1Fr3p6niHuacvFyMP3pmzHZ3bspKy
	 Njx1hVzAsC37+BPasZ2kW4fhCijvikFgOW/jFWjbiyJ0fny7FBA21yrvDPReOP69wdGZN
	 WeavrXUfH609dbq5KbUtrQxpJVt5N64WEVXrcav1jsxOoOHl1EKhGyXpgXLt8yxYa+Tzj
	 hlvns0KYmBg7njNVZCRjdGurR1xa9Sqn0UrCxkefBRyHM5XpR/mM1sAONi12LWy9lSPHk
	 Ixl3r8LoThhVc85vld+Y8blNC4erEl5xTTFFDx0btjcbd7sO+0fiTfPV9JBA39gkD3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794404595;
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
	bh=0uRGnGYWtVsLx30X/f5FNKOnsr1AG3Qpo7q24CGjgzs=;
	b=l6giX70LTl7YRkid9/akiVGwWv7daxm3oSeT7AWDTm780FYdAiVcwSs4JaavjagAINiw
	 YZCP4YDluKqddzKOXK6LLk49BjHtaIMLeF8NDP7KFcP7hCeZzdLk4VdRdcZsaYzLuXD9b
	 7LkuY25acwqTmPxNL9t9qEqGTMl1sMwLTrlm+59WEE9z2iTe4I2JKq71V2oadGRtN5Rtl
	 vWpuMFJcQoGdfKzXypGgN88Ciu8NkIOznogYNvae2zkRlsxWVrKHbcIsl2JyV3UZomaAG
	 vkuSAI6XCzYe9wBhkrU+MG3Dm32sLsYgBvrkA7RwJi+S9sqTVqAJHZRmkqvpCRCF8Mg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=YaRNaPiR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.30
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013030.outbound.protection.outlook.com [40.107.162.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59387606A339;
	Wed, 11 Nov 2026 13:43:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59387606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=YaRNaPiR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S50GVTevGZ2Ecbf4rw1i8lTtqM47/UsP40aIwafLxdH7Qm2dHgU34SQZz6SOlejt40xP1fOab5aAW5W3WIxkueoecgvRM4SbsM4xewvX5PscjdzWcAGtvBqEbNB4QeFpULizvTp68qgf5dUniXKWYD62DagCjssZQICEUpw17Wc7re8aJa+U5B8xfSRQGAldhnHrThEa4ODeqISdhA7r0yOrWuhZFeerxv003rkrRilvnsIAcYw+3sUwu5+Gv1MgVE/bDIgAjj+qZHImyx6B5InNCu0nYEda5JPFBnzeprxxLVMr38iJmS7W7ooxH5WOE3L03/s2JYSp4pjRPyTwoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uRGnGYWtVsLx30X/f5FNKOnsr1AG3Qpo7q24CGjgzs=;
 b=BBMdaiKemYSTsebNjHUGQg8yQ1OAig+8hyG0Ht06qmQ1qo8KP/lrsjh5DaKKfHtoK+BZdQePPyjMBrqO2Wc+rfb+Qonsn+3fvsnWjbTvsQXrPYXZbEovQip2bC/2R+Gt/g1zBbUuCoiw3TkVyaC52pQEp9PGURF2UzAxgqZNGJqspBH64UXmIEtF3ys9goczG2AaOW5nI7HsXWkWfdNwrqX3OFUOc47QB80PBCOCjOUmY4ZO32+iSnUJ1VU2K/r1Ki4TM5RTDDowAWYx1JzP9xTlZ+M7a4COeeUhx0d1dd77lKw4RTyNAfi9F7bCijqv8LyxCb1cVHWe9N5jg5S9Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uRGnGYWtVsLx30X/f5FNKOnsr1AG3Qpo7q24CGjgzs=;
 b=YaRNaPiRW62oW9AHoDl2mbW+hi0bLMIr8WWRN6XgkEd1U74CUa3CmNHD3H/PdBDy7qzdqdoczJ4a6o/MpcB0dqCEGEGnB/J/mYKGwPIXQ9YMjnOAdcni8FWm7lo7EyAcwB8DxtbaejEA7z8yjCGFAq2np5Y/m5FQUjk2YE2XrClqlnhoITWX60GtVppvf5BfPzi7T4DM/yT3KEv5mEE47XdAGxpzOEXYIC54rCkiIYMMLBS/ibH0x5Mfq+epAiMB/7OeZ/7ZplmXeEYGNAAQl8tMFeM4XJs+eQG2zDRa/YUj0NMoOUr2WeFWn919p3XhxaorBqwQk+j9wLDlexGtQw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by CPHPR04MB721690.eurprd04.prod.outlook.com (2603:10a6:380:104::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 13:43:11 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 13:43:11 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 11 Nov 2026 21:47:34 +0800
Subject: [PATCH v5 6/7] dmaengine: fsl-edma: support per-channel DT child
 nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-edma-iommu-v3-v5-6-2537cebe6ca2@nxp.com>
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
X-ClientProxiedBy: SI2PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::15) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 4e141e43-323f-42bc-43a7-08df3ff9ba4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|19092799006|921020|10067099003|11063799006|261009223027099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|56012099006|261026140227099003|261026121527099003|261028144727099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	T9nxlE4uJcN8lmROgWQxoG1NS7KiHHTSD22FAcZCzkmbkDuEjf6KtQtaOnpYmc8QYgDF5/83HXLkjG7a34BjTnLMeFSTdmxwsDeAbShNmXoQxHRDu0KFRuACVQ619z2UIYz9dj/yfkYho3lrJcEOf9O1oVx3eTPGKR1zrsKzssZtLpGq8ZmRol2AoVvb+61qfY2aJT3Eqqq/ThXpSSInzYghTHgtQonzEpDNwhH6kQ7jERFNKCfS3pnsKrycqFWrOvjyL+PnF1+0Rfsj/JIU/yrPZgmzo8/iD7+6Bhmj5cExUnFdiHkt6Gip8CiA7U5NRPt0wwesfZRnczlnHl0Wklbs5AniybKCn2qLJ2/cDChpK6zBuPkFgyiaa0lFestaNLjAmXiWgmhCi3vbEpwAcNd50oTRSJscBCCtCm4rTYOoonhk0ZaySFw1Bn0l6KSQmLbxidCBunQUq3DFmIeCrJZx0d36C64C27ejhCWPDkAQMU6My+XAsYyCZ4pw34tm/rjW4RCBZGluhrg0nY7KxmImTwfN8VSb05LlYoLMAXY9huZyBIa0h/S73l7hV70eC5hYvfQcm8GvtDcLqkj8JYneU10SUjzB1auJQATa6AuKnDt3SwJzIZu6NiAaIM/CrgcC7G1TaO06/R/euqM4Hm4nbsecpncZN0wG3TqEQ5Abw5kHihlkFIHP+pQ/SUO2KiXFBe5s4FIYqLfMJS4RKw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(19092799006)(921020)(10067099003)(11063799006)(261009223027099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmgxNU5jS0RyeHRjOXlzWExHQVFqOWFTRWdNNCtRbTdLLy9PdXpYOStQVkNE?=
 =?utf-8?B?YVBDc2dORTk5SjVxcnhXYmM1WE1lcENzSUR4TWZTSEloWDlZMEY0ZWFnNmM2?=
 =?utf-8?B?MW1JUzVSUTFJUWZ5M2ZRWkYvRWw0bEczSWlkUUY5dlhLMVUxRnJCQmhRSlpV?=
 =?utf-8?B?ZGVncllhbCtZdGd2RFMrOE5MT1B6Rm5vKzEvZ1hQSC9leWVJdFdOdHJLU1FS?=
 =?utf-8?B?RjlqWFhPRVJkc0tlNWNvU3A2MitNMWNHc3l6cjZ3azBOak45TE1DSGUvS0hE?=
 =?utf-8?B?Q1pVQ21JeTNKN0NVamtZbS9ScmtaUm5QR0JraUl3QmoyeEFxczJlK3NDSk5K?=
 =?utf-8?B?cC96OHUrTEl0UUg3VXI0eCt0SHBDV21BMGgycjJ5Q0xGbDNCYzlDd1VKRm1G?=
 =?utf-8?B?SU83ZEdkTlYwWmJad0lhVHdTUHBUTW95NTBFaWhsbUxNSEtWRjlMQmppb1Fy?=
 =?utf-8?B?UnBsV29BMmxudWhmOTJTeVRkVEIxZkp5eGFrS09IcVRUL1h3UDd0d2xTN1Yz?=
 =?utf-8?B?SDhLMVhWa0hsdmIwV1V0MVR4Zy9XRklOZkdsSEQxSXdWNWpjckJEdis0dG1P?=
 =?utf-8?B?d29PVXZNdE40bkx5M3ViNUJmeEhNMWU2dUw1dlNiR1p3V2R4V214aEd3dXY1?=
 =?utf-8?B?WlJpY2Zha2c2ejVsUm1HbXhFY0NBeHlBazFaVHBGTkM1OGw5RmttR2txNEpU?=
 =?utf-8?B?RnlyVjlyaVNHTjRydUlCeEJYSUlQZ3Q1T2srR3FXMGxCdEFGYUxWcFdXMmZW?=
 =?utf-8?B?cGZXbVNVTXFub1pMaElWSG9lNS9NdldzTlZ5cDlQa2pyWHFBZUtoaDc5QUlX?=
 =?utf-8?B?aExaRE51YTA0YXBIUXYwaFV2aFB3ckRaeERVQjg2cEs4WUt6ZFRMRjVDZ1R4?=
 =?utf-8?B?UjZyVmtRRnhwcktqZXlMcitxdDlXRnJSUFQwckRnUzI2MXFBVmZlNU5LK3VV?=
 =?utf-8?B?SGZobDdJU3RpUDBDbG1vVGZRcjJJaGxXMk9KdURCSi96U2dXdExtU0xqczNw?=
 =?utf-8?B?ODNiM0RMOUVvbEZIdDVxbDNiV21SVitpdjlCa2lBeTFxb0pzTGJhWTUxR3g3?=
 =?utf-8?B?aE00bGlnZEZDMWltY2NmQ1U5M013TGVHd2xSTmZzOGdoTFdSdi9Pdk0rVlVE?=
 =?utf-8?B?WDVOeDRyQUVCSkhNd0lxc2tVb3YzcGxGUGNtR1JtVFFUZHZvejNtc0V0L29K?=
 =?utf-8?B?OTBFSGhHc0RqdTF3a21udkMrUGduNmVscTdDVU1ObUNCcElCUzNDWkpzWU9U?=
 =?utf-8?B?cmc3N3h0a1JQRGVxeGplaklkK0dGcGdYQjk0ZmZPYkNpRVFmOUpvMHRJeXRS?=
 =?utf-8?B?SzNLbkJWZW5KM0RtdTlhOERzcSs5SEVLL1o0N3V6YURuMkRCdFdZOU5GUmhz?=
 =?utf-8?B?TXYydllVNzBGejNIT3lxWXFqZEN1dFNnMU1kOUp3WkZOeHdqdmNGQTg5VHc1?=
 =?utf-8?B?RzllRVBEeW9sWjhuNWkzRWlCaVFhNWVQdFphSG0wWXdXd1N1dVhTbEJBd1h0?=
 =?utf-8?B?VldPTW1teVBkaUtpRUlzdmpNZmttRXlLUW9ybGlEZGZKZGZTbzhrUXhCT3BY?=
 =?utf-8?B?L21TU3d0QWhpMGRBeFFnZmxMZ2t4eWp2bXpnVXpYN0VMWUM2amp3ZEg1ay9k?=
 =?utf-8?B?UTBEZ0lXRFJ3MHp2YVFGd08xZTR6Tit6M2FBRnJNblZDcDByZC9SbnNDQ2pV?=
 =?utf-8?B?Q1hxM243Mzl6bHNlbWsrZ1RVbVgrL3FlRlZ1cnovcXhWVGpvSWgwZDgyLzhs?=
 =?utf-8?B?RlByOGJ0Vm5EdVp5QzdkWFVTNTl5eS9Lc2U3UkdnOHAzbU1JcGtRZDdMa0JK?=
 =?utf-8?B?TUtsZnRkamJoOEpmRWVvMTJUckNDVnZzWk93aDV3aFVTNFBDYVBVZGd2NERV?=
 =?utf-8?B?RFJpVDR2cVphZzN4V2tPWGhqU2tCdGE3dEVFaWVaVUhTYXVESnJDTWUyODRD?=
 =?utf-8?B?aHlwTGRHNUg2SHRrWm9iY0NEVTZXYjgvbXIwZnRYUEtCanRRYlZHa1M2QTFz?=
 =?utf-8?B?d2VJZmYwU2VFLzFlcURwbUtuS04vSTArdkUxSisyZG1HL1lCcTJKR2pSUzdQ?=
 =?utf-8?B?M2U2N3NSV21vcVE2cHhCVjBpRmtLbDR2U1VnREY5dGVJRU5NQzFsdlJ2WGlZ?=
 =?utf-8?B?bU1IRmh5NGVJUnF5WFd5cXdkakZheDhTK0MvamVoWkpJaSsyQW1INHc4QUV3?=
 =?utf-8?B?cnMvbUxhZ2Qydlg4WUZtT3psMkZwalNWTmU1NFIrTHZNUm1Ed1V5QnRJOVp3?=
 =?utf-8?B?OHJKdkhoaGlSWUNOU3JhTW1ncEgvcG43YU54WHUvUlg3SEUrOTZvRjFLKzRT?=
 =?utf-8?B?Qm1IcW9QNDhGU1dHVE9renI1M0ZrbDFnekt0eldqcXI0RXJURnh3ZElrd1ZE?=
 =?utf-8?Q?MKE4vdwQZhpNjXbJYu2qsrv6CmBfGet/+vykl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e141e43-323f-42bc-43a7-08df3ff9ba4e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 13:43:11.6674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d8CkngmreVOIrUCiKSiEcwfCeqvDp5F3h7sj7zlKF6NQoXoOIYcKzo3YLRbdj/kYAoPFTXGB2j4U7IpvKcumtSdOutwFghSZzDinMzfow5DFmIZQM0C7Y9gU3SRo/0Am
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPHPR04MB721690

From: Peng Fan <peng.fan@nxp.com>

Add support for parsing per-channel child nodes from devicetree.
Each child node can carry its own interrupts and iommus properties.
Child power-domains are not handled here; power domains remain attached
at the parent level.

The implementation is split into three functions:

- fsl_edma_child_to_chan_id(): derives the channel index from the
  child MMIO address relative to the parent base.  Validate that the
  child resource is contained in the controller resource and aligned to
  the channel register spacing, and use div_u64_rem() to compute
  the quotient and alignment remainder together.

- fsl_edma_configure_chan_from_dt(): called before setup_irq() to
  populate per-channel txirq from child interrupt properties.
  fsl_edma3_irq_init() is updated to skip platform_get_irq() for
  channels that already have an IRQ assigned from their child node.

- fsl_edma_configure_chan_iommu(): called after
  dmaenginem_async_device_register() to configure per-channel IOMMU
  by calling of_dma_configure() on each dma_chan_dev and setting
  chan_dma_dev so dmaengine_get_dma_device() returns the per-channel
  device.  Propagate the controller dma_parms to the per-channel device
  so the DMA segment size limit is preserved.

Child nodes beyond the configured dma-channels are ignored, which allows
boards to reduce dma-channels without disabling every unused child node.
If child nodes are present, every unmasked channel must have a child node
with a valid interrupt; otherwise probe fails with an error asking for
dma-channel-mask.  In child-node mode fsl_edma3_irq_init() does not fall
back to the parent's flat interrupt array.

The shared error IRQ remains a parent-node interrupt.  A child-node-only
DTS without that entry simply has no shared error IRQ.

Use BIT_ULL() for the 64-bit chan_masked bitmap, and use dev_err_probe()
so -EPROBE_DEFER is not logged as an error.  Reject a channel whose iommus
property did not result in an IOMMU mapping.

Existing DTS without child nodes continues to work unchanged.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/dma/fsl-edma-common.c |  10 +-
 drivers/dma/fsl-edma-common.h |   1 +
 drivers/dma/fsl-edma-main.c   | 229 +++++++++++++++++++++++++++++++++++++++---
 3 files changed, 222 insertions(+), 18 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 513b0f4e5be2..62cd60179bc6 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -310,10 +310,10 @@ int fsl_edma_resume(struct dma_chan *chan)
 
 static void fsl_edma_unprep_slave_dma(struct fsl_edma_chan *fsl_chan)
 {
+	struct device *dev = dmaengine_get_dma_device(&fsl_chan->vchan.chan);
+
 	if (fsl_chan->dma_dir != DMA_NONE)
-		dma_unmap_resource(fsl_chan->vchan.chan.device->dev,
-				   fsl_chan->dma_dev_addr,
-				   fsl_chan->dma_dev_size,
+		dma_unmap_resource(dev, fsl_chan->dma_dev_addr, fsl_chan->dma_dev_size,
 				   fsl_chan->dma_dir, 0);
 	fsl_chan->dma_dir = DMA_NONE;
 }
@@ -321,7 +321,7 @@ static void fsl_edma_unprep_slave_dma(struct fsl_edma_chan *fsl_chan)
 static bool fsl_edma_prep_slave_dma(struct fsl_edma_chan *fsl_chan,
 				    enum dma_transfer_direction dir)
 {
-	struct device *dev = fsl_chan->vchan.chan.device->dev;
+	struct device *dev = dmaengine_get_dma_device(&fsl_chan->vchan.chan);
 	enum dma_data_direction dma_dir;
 	phys_addr_t addr = 0;
 	u32 size = 0;
@@ -1090,7 +1090,7 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_CHCLK)
 		clk_prepare_enable(fsl_chan->clk);
 
-	fsl_chan->tcd_pool = dma_pool_create("tcd_pool", chan->device->dev,
+	fsl_chan->tcd_pool = dma_pool_create("tcd_pool", dmaengine_get_dma_device(chan),
 				fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_TCD64 ?
 				sizeof(struct fsl_edma_hw_tcd64) : sizeof(struct fsl_edma_hw_tcd),
 				32, 0);
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index cbb077e98f55..8843dd5661fb 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -271,6 +271,7 @@ struct fsl_edma_engine {
 	int			txirq_16_31;
 	int			errirq;
 	bool			big_endian;
+	bool			per_chan_irqs;
 	struct edma_regs	regs;
 	u64			chan_masked;
 	struct fsl_edma_chan	chans[] __counted_by(n_chans);
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 7f82dcb7831d..e9a7592ef076 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -12,11 +12,15 @@
 
 #include <dt-bindings/dma/fsl-edma.h>
 #include <linux/bitfield.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/clk.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/of_dma.h>
+#include <linux/of_irq.h>
 #include <linux/dma-mapping.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_domain.h>
@@ -123,7 +127,7 @@ static irqreturn_t fsl_edma3_err_handler_shared(int irq, void *dev_id)
 	unsigned int ch;
 
 	for (ch = 0; ch < fsl_edma->n_chans; ch++) {
-		if (fsl_edma->chan_masked & BIT(ch))
+		if (fsl_edma->chan_masked & BIT_ULL(ch))
 			continue;
 
 		fsl_edma3_err_check(&fsl_edma->chans[ch]);
@@ -397,15 +401,24 @@ static int fsl_edma3_irq_init(struct platform_device *pdev, struct fsl_edma_engi
 
 		struct fsl_edma_chan *fsl_chan = &fsl_edma->chans[i];
 
-		if (fsl_edma->chan_masked & BIT(i))
+		if (fsl_edma->chan_masked & BIT_ULL(i))
 			continue;
 
-		/* request channel irq */
-		fsl_chan->txirq = platform_get_irq(pdev, i);
-		if (fsl_chan->txirq < 0)
-			return  -EINVAL;
+		if (fsl_chan->txirq <= 0) {
+			/*
+			 * In child-node mode, missing child nodes are rejected
+			 * by fsl_edma_configure_chan_from_dt(); do not fall
+			 * back to the parent's flat interrupt array.
+			 */
+			if (fsl_edma->per_chan_irqs)
+				continue;
 
-		fsl_chan->irq_handler = fsl_edma3_tx_handler;
+			fsl_chan->txirq = platform_get_irq(pdev, i);
+			if (fsl_chan->txirq < 0)
+				return fsl_chan->txirq;
+
+			fsl_chan->irq_handler = fsl_edma3_tx_handler;
+		}
 
 		if (!(fsl_edma->drvdata->flags & FSL_EDMA_DRV_ERRIRQ_SHARE)) {
 			fsl_chan->errirq = fsl_chan->txirq;
@@ -415,7 +428,11 @@ static int fsl_edma3_irq_init(struct platform_device *pdev, struct fsl_edma_engi
 
 	/* All channel err use one irq number */
 	if (fsl_edma->drvdata->flags & FSL_EDMA_DRV_ERRIRQ_SHARE) {
-		/* last one is error irq */
+		/*
+		 * The shared error IRQ remains a parent-node interrupt at
+		 * index n_chans.  A child-node-only DTS without that entry
+		 * simply has no shared error IRQ.
+		 */
 		fsl_edma->errirq = platform_get_irq_optional(pdev, fsl_edma->n_chans);
 		if (fsl_edma->errirq < 0)
 			return 0; /* dts miss err irq, treat as no err irq case */
@@ -641,7 +658,7 @@ static void fsl_edma3_detach_pd(struct fsl_edma_engine *fsl_edma)
 	int i;
 
 	for (i = 0; i < fsl_edma->n_chans; i++) {
-		if (fsl_edma->chan_masked & BIT(i))
+		if (fsl_edma->chan_masked & BIT_ULL(i))
 			continue;
 		fsl_chan = &fsl_edma->chans[i];
 		if (fsl_chan->pd_dev_link)
@@ -669,7 +686,7 @@ static int fsl_edma3_attach_pd(struct platform_device *pdev, struct fsl_edma_eng
 	dev = &pdev->dev;
 
 	for (i = 0; i < fsl_edma->n_chans; i++) {
-		if (fsl_edma->chan_masked & BIT(i))
+		if (fsl_edma->chan_masked & BIT_ULL(i))
 			continue;
 
 		fsl_chan = &fsl_edma->chans[i];
@@ -703,6 +720,184 @@ static int fsl_edma3_attach_pd(struct platform_device *pdev, struct fsl_edma_eng
 	return -EINVAL;
 }
 
+static int fsl_edma_child_to_chan_id(struct fsl_edma_engine *fsl_edma,
+				     struct device_node *child,
+				     struct resource *parent_res)
+{
+	const struct fsl_edma_drvdata *drvdata = fsl_edma->drvdata;
+	struct resource child_res;
+	u64 offset, ch_id;
+	u32 rem;
+	int ret;
+
+	ret = of_address_to_resource(child, 0, &child_res);
+	if (ret)
+		return ret;
+
+	if (!resource_contains(parent_res, &child_res))
+		return -EINVAL;
+
+	if (child_res.start < parent_res->start + drvdata->chreg_off)
+		return -EINVAL;
+
+	offset = child_res.start - parent_res->start - drvdata->chreg_off;
+	ch_id = div_u64_rem(offset, drvdata->chreg_space_sz, &rem);
+	if (rem)
+		return -EINVAL;
+	if (ch_id > INT_MAX)
+		return -EINVAL;
+
+	return ch_id;
+}
+
+static int fsl_edma_configure_chan_from_dt(struct platform_device *pdev,
+					   struct fsl_edma_engine *fsl_edma)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct resource parent_res;
+	struct device_node *child;
+	u64 child_mask = 0;
+	bool has_children = false;
+	int i, ret;
+
+	ret = of_address_to_resource(np, 0, &parent_res);
+	if (ret)
+		return ret;
+
+	for_each_available_child_of_node(np, child) {
+		struct fsl_edma_chan *fsl_chan;
+		int ch_id, irq;
+
+		has_children = true;
+
+		ch_id = fsl_edma_child_to_chan_id(fsl_edma, child,
+						  &parent_res);
+		if (ch_id < 0) {
+			dev_err(&pdev->dev, "invalid channel in %pOFn\n", child);
+			of_node_put(child);
+			return -EINVAL;
+		}
+
+		if (ch_id >= fsl_edma->n_chans)
+			continue;
+
+		if (fsl_edma->chan_masked & BIT_ULL(ch_id))
+			continue;
+
+		child_mask |= BIT_ULL(ch_id);
+
+		fsl_chan = &fsl_edma->chans[ch_id];
+
+		irq = of_irq_get(child, 0);
+		if (irq == -EPROBE_DEFER) {
+			of_node_put(child);
+			return -EPROBE_DEFER;
+		}
+		if (irq <= 0) {
+			dev_err(&pdev->dev,
+				"channel %d child node has no valid interrupt; add interrupts or disable it with dma-channel-mask\n",
+				ch_id);
+			of_node_put(child);
+			return irq < 0 ? irq : -EINVAL;
+		}
+
+		fsl_chan->txirq = irq;
+		fsl_chan->irq_handler = fsl_edma3_tx_handler;
+	}
+
+	if (!has_children)
+		return 0;
+
+	fsl_edma->per_chan_irqs = true;
+
+	for (i = 0; i < fsl_edma->n_chans; i++) {
+		if (fsl_edma->chan_masked & BIT_ULL(i))
+			continue;
+		if (child_mask & BIT_ULL(i))
+			continue;
+
+		dev_err(&pdev->dev,
+			"channel %d has no dma-channel child node; add one or disable it with dma-channel-mask\n",
+			i);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int fsl_edma_configure_chan_iommu(struct platform_device *pdev,
+					struct fsl_edma_engine *fsl_edma)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct resource parent_res;
+	struct device_node *child;
+	struct dma_chan *chan;
+	int ret;
+
+	ret = of_address_to_resource(np, 0, &parent_res);
+	if (ret)
+		return ret;
+
+	for_each_available_child_of_node(np, child) {
+		struct fsl_edma_chan *fsl_chan;
+		int ch_id;
+
+		if (!of_property_present(child, "iommus"))
+			continue;
+
+		ch_id = fsl_edma_child_to_chan_id(fsl_edma, child,
+						  &parent_res);
+		if (ch_id < 0)
+			continue;
+
+		if (ch_id >= fsl_edma->n_chans)
+			continue;
+
+		if (fsl_edma->chan_masked & BIT_ULL(ch_id))
+			continue;
+
+		fsl_chan = &fsl_edma->chans[ch_id];
+
+		list_for_each_entry(chan, &fsl_edma->dma_dev.channels,
+				    device_node) {
+			struct device *chdev;
+
+			if (to_fsl_edma_chan(chan) != fsl_chan)
+				continue;
+
+			chdev = dmaengine_chan_dev(chan);
+			chdev->dma_parms = pdev->dev.dma_parms;
+			if (fsl_edma->drvdata->flags & FSL_EDMA_DRV_TCD64)
+				dma_coerce_mask_and_coherent(chdev,
+					DMA_BIT_MASK(64));
+			else
+				dma_coerce_mask_and_coherent(chdev,
+					DMA_BIT_MASK(32));
+			ret = of_dma_configure(chdev, child, true);
+			if (ret) {
+				dev_err_probe(&pdev->dev, ret,
+					      "IOMMU config failed for channel %d\n",
+					      ch_id);
+				of_node_put(child);
+				return ret;
+			}
+
+			if (!device_iommu_mapped(chdev)) {
+				dev_err_probe(&pdev->dev, -ENODEV,
+					      "channel %d is not behind an IOMMU\n",
+					      ch_id);
+				of_node_put(child);
+				return -ENODEV;
+			}
+
+			chan->chan_dev->chan_dma_dev = true;
+			break;
+		}
+	}
+
+	return 0;
+}
+
 static int fsl_edma_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -797,7 +992,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		struct fsl_edma_chan *fsl_chan = &fsl_edma->chans[i];
 		int len;
 
-		if (fsl_edma->chan_masked & BIT(i))
+		if (fsl_edma->chan_masked & BIT_ULL(i))
 			continue;
 
 		snprintf(fsl_chan->chan_name, sizeof(fsl_chan->chan_name), "%s-CH%02d",
@@ -835,6 +1030,10 @@ static int fsl_edma_probe(struct platform_device *pdev)
 			clk_disable_unprepare(fsl_chan->clk);
 	}
 
+	ret = fsl_edma_configure_chan_from_dt(pdev, fsl_edma);
+	if (ret)
+		return ret;
+
 	ret = fsl_edma->drvdata->setup_irq(pdev, fsl_edma);
 	if (ret)
 		return ret;
@@ -897,6 +1096,10 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, ret,
 				     "Can't register Freescale eDMA engine.\n");
 
+	ret = fsl_edma_configure_chan_iommu(pdev, fsl_edma);
+	if (ret)
+		return ret;
+
 	ret = devm_of_dma_controller_register(&pdev->dev, np,
 			drvdata->dmamuxs ? fsl_edma_xlate : fsl_edma3_xlate,
 			fsl_edma);
@@ -927,7 +1130,7 @@ static int fsl_edma_suspend_late(struct device *dev)
 
 	for (i = 0; i < fsl_edma->n_chans; i++) {
 		fsl_chan = &fsl_edma->chans[i];
-		if (fsl_edma->chan_masked & BIT(i))
+		if (fsl_edma->chan_masked & BIT_ULL(i))
 			continue;
 		spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
 		/* Make sure chan is idle or will force disable. */
@@ -953,7 +1156,7 @@ static int fsl_edma_resume_early(struct device *dev)
 
 	for (i = 0; i < fsl_edma->n_chans; i++) {
 		fsl_chan = &fsl_edma->chans[i];
-		if (fsl_edma->chan_masked & BIT(i))
+		if (fsl_edma->chan_masked & BIT_ULL(i))
 			continue;
 		fsl_chan->pm_state = RUNNING;
 		edma_write_tcdreg(fsl_chan, 0, csr);

-- 
2.34.1

