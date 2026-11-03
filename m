Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793718865;
	b=09wi9Eu9Kxzrp5uMEWFdvEbsKj9lnOMBCpkJx9n7yrDcYK0FmryrEuNivKU7nsABZKPn
	 1hxPrm2uYpYBQ2wDNsO1wLTxvZ6k6lzkpd4D5bksgoY1gs+P8MQxj6ZQst/9IrI3mrdkr
	 0/I41kgP5yJDJ+c/AMGI3uvGqnw6+ZNXIRs23JACcg2HyFV6GyAAqNlf7TsM3WWfHFZvY
	 0RkNFuiNrZv4bSs9ply6hR6+oaURRqhNPUcXRKYvwewaQImCJkL2Iyfqq6XS/02G8swav
	 n1zmyxqr8CUVyyUdiEsdLTbQ10gX6YS/55xV+NA6UyhymEyoooww/OxPM+7nNt5VBZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718865;
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
	bh=sOtX7PkRN1Jyr/oVNrw5aohKf6MVL4ZKej1loldoccM=;
	b=BgfxbbFFlnYWGHmBLekwH4QheISX+oOJAkTWaiBUR98v3KwqvoEMDh3AZSG48yk9ndS2
	 Sl8ggsbHVZj5AKwnSX/azuQm2CEXIrSrLJIk3qSgEfKFRifDUd+WMr5HHL+Wqt+ahGavF
	 X9CWWM5F1pETvLSKJjEILbwsUfqHEJhBxbbLfyTGHJ8/gn/xp8mgxgf7lgR6Ez+NEh41X
	 caAEXeGklXCpi8/+P0BhMOfj1MCCpFQe4qVazOcrlrovNk6GfNXIS6BfRKgEn6jYNOEGk
	 f3foQoTjysX5dhEb5BpeIfCmxcnLJsPEzjzKtwZbcerH+iwI+kVYINNLLieDzHdGG0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Xnl67xUF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.30
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011030.outbound.protection.outlook.com [52.101.70.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B92E606A79D;
	Tue,  3 Nov 2026 15:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B92E606A79D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Xnl67xUF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u2fZ4FCQWPFXW3h97R4GSxAPzEasRdQqJbLZbOGLhwrR863E7N1QS6B0NtJ2iV2Zdr/afwyAG5pXIi81xxi4a0hYf4HxxT/kumSf7W41HWntbZBCypw62YKulSgBW3OfXDJgwlQ3V24/hYSCQ8dfzIlfmkWF/Qr5twpmh4NW2z3SWFsqh5IePR7+WmpGKProedEQ2pMK0qhi6IDnPOfaWYsTzs8MRpnt08HTbJjr3d4sxZCyPWifAC2qfP70FxkeR46bLhIThpo0VlHLLNevcmxUh9ECEyhqYzeZIwYsfvZmpiDYoGJEKUQdIAcT69ACZf9cDGwGo9+Lb2RFNAtUMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOtX7PkRN1Jyr/oVNrw5aohKf6MVL4ZKej1loldoccM=;
 b=iQbedh14eqGKcj8OKXtPl0cSVRdqK9yBuiwzVdwT80AnkbdHQMIVrjIB0mhr5PJ0mwywvxjv6P4pbOie+1qwP1DcbjrUeAN21YNYQ5YIcnO8779bLl/1xlH6+BOrwy2RxjX6XfLLKPSJrlT3mMM3115db9oP1wv/KN2sbMtsEAe0gqsSw2j3SYV2KM10Q1uAJLIcQaZb3lkySWxrsYl1zl6CVSu0w0zIl/LQYdqIwvD7mwi9vQ4MTI4uVtBuJD+fxvexFUW78wNSpUEphu65+y9UxO24yHv7x0gUpFflEJ1Q1NpwzNBK6WtjywnKbFEASWS+vVLmYdt3gOzSOY5JAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOtX7PkRN1Jyr/oVNrw5aohKf6MVL4ZKej1loldoccM=;
 b=Xnl67xUFS5TsdRl2XtIlQUg7TmODhG62MbnEOgVmTmpM5WHYQU4lBuC3dnAoPS+0h8n72xL+7nGGYZVMCfKse6AFvbydVfj/fHCE1LfEU1d0qRkhWkFG6au9o+0omL4WXneiUMCi2WYMRZJmmiTlE8tbp9PhnXQfD5KbqNV3Qg7PhEp+X3G0MBOrO/7q7matngQKbQWs0PwOAGnDjOHG5+PhdWPaFgWycw4AjdjCFGZb2yvS4PxxFNpqBCYKG4nO5JV+eqzolaXu18Vw4HRgt1wUGTbo/tVLtce0Bz3Br1THWTV0UnguhVZcPEbSImtcCCd1kPnm+a6iDCvNtL2Yuw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by MMZPR04MB025562.eurprd04.prod.outlook.com (2603:10a6:190:37::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 15:14:20 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 15:14:18 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v4 0/7] dmaengine: add DMA channel bus and fsl-edma
 per-channel IOMMU support
Date: Tue, 03 Nov 2026 23:18:57 +0800
Message-Id: <20261103-edma-iommu-v3-v4-0-470415d418c5@Example.Com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGH76WoC/3WNQQqDMBREryJ/3ZSYWMWuhNJTFBdRv/WXxkiiw
 SK5e6NdF2bzYObNBg4toYNrsoFFT47MGCE7JdAOanwioy4yCC7yNOWCYacVI6P1wrxkQjR5IYu
 0aPsM4may2NN6+B71j93SvLCdd8neGMjNxn6OQy/33j93DGdlxzEXqrxk2FT3Venpjeeb0VCHE
 L4q2R35vgAAAA==
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
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: d0d1181b-afdc-4fd6-4357-08df39bd2189
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|366016|7416014|376014|1800799024|261021123027099003|261021121427099003|261022105027099003|261009223027099003|261022075727099003|11063799006|921020|5023799004|261026140227099003|261026121527099003|261102124527099003|261028144727099003|10067099003|260925021911599003|56012099006|260925021311599003|260925022911599003|261102123227099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ehI5ZXz0AqCmOrLtyLnutMm46FBeyMvC+Yg2kP8T6c2kre9UCvl5GLrn1hL/1ICgBfbY2YJxtmlrclo2GctcKHmVyQctQ0bnWSl9fcq6DPK/TeGA6EQTDpfUyJPO5HhNrNM4Olp1jjxgssZniP38IdvEif1w4XSwFxFsYrzUtFg3ZOGbcnTOXClPjD+eO/J8W4GXoHA713t5NI/uOXrQQYLdGfkeag14fWSUwJ7LffsZ+6WNQNKyiRig6qoozz0x+xczkI3WL5DgQq3NeSi2nmy0mYBougXYEGKAS5gJLMhidhRRb/5PVc2QRKFI0qc/p8qNn1RO8OXDYRPu6RRjdHXM4Mp+PHGyBRUcBZk3aWYDQgjajzNFj6qFdbz1jxPmqyE4phQLB7h1a4mW0hC1z9+cJO667NVw5KT/eOqJr8ejlzyMsiWD12JMXp2USTcjO707OJBI3adz8aegWtaZdYHvbIfLF5nB+S3sgRbxsal4YjxzNwuvXsy51e2f00qwFpZ+mdx89yClrJ5aFeun3ZfzC4kKD0jdDYAAOL6CJhMF0EZ5LwJiQVEOMDPeQGD8Wn0OaBcKaXYm6zpCxDZxMYHMVYA+STYkKSUXd4AL7eEdnlAoD1b3S6V3ACNmsPZKFh8ncVI7QQAw0dVXiHzpYCsalEBdAhT16I+E8TgFVl0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(7416014)(376014)(1800799024)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(261022075727099003)(11063799006)(921020)(5023799004)(261026140227099003)(261026121527099003)(261102124527099003)(261028144727099003)(10067099003)(260925021911599003)(56012099006)(260925021311599003)(260925022911599003)(261102123227099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzE5VU5TMmJDdGQ0RmFWamxrOWhxS09SalErVjJvUlJHVGE3a0g4WEh1WWw3?=
 =?utf-8?B?a1ZFRTIwNEFvb1RObFVGWG42MVNrdC9qcVNxNUlvU1poRnF1RkV6TzdERExT?=
 =?utf-8?B?dmVmWmQrbzZBbzVsUkZGV3dCN2JuQnF2Q0Z2NG5nWTBJYldJQjVIT0dmdHZl?=
 =?utf-8?B?Y1Q2NjBqaFNJWlZyM3JCVzlyenl1V09DTk9LSDNKN0swV200eEFNR0EzdHFT?=
 =?utf-8?B?ZFloSEdacHZNWUFNZGpIcmtHaW96dmZJZ3BUc3FFOXpuVnFBbXNLY0lHY01z?=
 =?utf-8?B?OFBLZ0MwcFU0NnM4K1BIY2Y4V1NSdUNhcTNPUWwvRTZyVVVlODdUV3VhNm8y?=
 =?utf-8?B?R2tQeHh2SVhBMmdZa2djdVFUTmpkNDg1dDE1cFVtN3RGcHBKOXpySTEyZ2dH?=
 =?utf-8?B?eFNjMnFVWThtS1VISDNTMkRHeDdBZE9SbUxKbisxbjBjMytvRkJudzJUZ25X?=
 =?utf-8?B?YXdaYzdDQVQ1ZS9BU0Iza0hyZlRKMUl6YWFkRmovdkdTYUJ3QjMvQWhBaUpB?=
 =?utf-8?B?Y2liL0RhY3JHODJSRzc1K3IwN1lQZ0hFNGFjUkhOaE50aHhCVnI2Rk40MUUx?=
 =?utf-8?B?b0tISzcwV1o1M1dsdEZQa0tpcythYlVpaElRcitOdUh5ZnRQcktmVEJ5UUo5?=
 =?utf-8?B?aVZCT3FSNnZKR0FzN05LV1FRQ0dlNlpIVWhtcXN1eDJlTU5xdWxMMU1Qem5u?=
 =?utf-8?B?V0hqdis3cWtPeUJwVlNwZkFrb1FPODhYS0QwVjZZeURLRDVjWUNGYUxVb2Yz?=
 =?utf-8?B?akdiOElpZ2R2d3ozL3FONytnNHVSelpVYitZdm8raitDWXB1cTFnZ2hSVDVJ?=
 =?utf-8?B?Wkp6ODgzRkhMblpzWU1PS0p6dDFDRzdMQ3V0Z0ZMV3QrYmY2NVlNSVozM252?=
 =?utf-8?B?ZVdLRnM0Wjc5SktrVGVrRm1IQ21NSjNKNTltditrcFZjK0pKQ1VidXlEQTgz?=
 =?utf-8?B?L0pZMlgxZXdoeVBPSHlVMTJTdDVjNDNrSGFUTWZTaGhZRTlKSnA5UkxqWk51?=
 =?utf-8?B?TVNzUjMwNVlsTko2ZHdiQXdBTjJISFZ0a1JiS2JsS3AvMDhMWmU4ZU5LOW0y?=
 =?utf-8?B?Q2ZqOGU1WjBSOUlZTUI2aVY1WjltNlpYWFE3cWEva25qR0NqdCtkN25QTk9J?=
 =?utf-8?B?NVlhSHdBSGNIU3ZvM2FwQ2o5YmV1emRhU2RGd1ZEd214clhYV2hVNFVmQ2Ri?=
 =?utf-8?B?UEZRcHBaaEpQb2puOGdFTERveVdwZGdxV2JuZmU0R0RJNHpRa2IrMkFQWmxP?=
 =?utf-8?B?WVc5SXYzYy95YWp4MG5kY0dhUmEyV3dqWlhxQlNVMUlzNElFSGtmMklQQ0M0?=
 =?utf-8?B?dkFxdlhCWFl2M0dHUERKQTFqODEvL25EZVFaVEIrUVpxZWpuMkVZaDBTTDIv?=
 =?utf-8?B?c0lLeU5VNjlNTFh5SVJHNDlPbFY4Njk0N1o2bXgwd2U3N1NDL0p1QkdRZk41?=
 =?utf-8?B?R00zdEVYZFBSNUlGYmZKUUFzYStBdFZVei94dDdqTVpoSEpja3k4TXpva1FG?=
 =?utf-8?B?MHQzektHTFlSSlVzZ2psL0kvODVxbTRaTUNIYTlwWFczdG9tNDhMcWVuV2tG?=
 =?utf-8?B?NHhnbmZiQ3ZESUREMUNhbGJDcHpDTUxrWXk3eXQ1WDExQXB4TWhCZTlscUFT?=
 =?utf-8?B?Tk5paDhRd09YSS9vRmdvMHVNMkF3V25jZy92UXdHTGN2a01SZWJTS0RNYWs4?=
 =?utf-8?B?eEdRQXUwTVJydTBJMFN3OU5GTGRPV2xtVFZYWUQ5ekxKS2xXd1V5UXdjLzNU?=
 =?utf-8?B?TzQ2SFZHdEVtRFNLL0RRWEdHWlZPOW1PQUg0d01yUXVQUGQ4OTA1eWlYVkNU?=
 =?utf-8?B?U2IwT1RQcjZRUWsveklWeVZZcENYWXhJekFyVitSTER2VHQ0dUF5OHE3RkxI?=
 =?utf-8?B?a1NEWnVYWDIvdzRTa2duQWVKRnBTQVRYdWMzV204WHY5OEVrbXp1Zk4zYXRV?=
 =?utf-8?B?QzJpYmRVdzRaQlJqaU1Kd0UzSENaLzdQamxzcWNLYW9sYnFDVE8zSlFGWGtS?=
 =?utf-8?B?OUVENXVYeE5aSktOMHhwc0VMWTd6UjNxQ2FsWUt5Z0V3eXRpdGx5YUhrV3pw?=
 =?utf-8?B?N0hrTUk4U0VhMUFTQXF2bXVKbFhBdzRqU0lxT1hzTm5HOEtPMGwzNi9JRGNq?=
 =?utf-8?B?cG9pcUJNTnVuNjY5M2Q4c0JyM0RYYTVUSFBjT0Q5STJxKzFEUTM5MXpqTWE5?=
 =?utf-8?B?MHdLc0NRN01kYXYvSjEwdXh6WENLaTV1TjdIV3Z6c0tXN242UzY1U3FYMmoz?=
 =?utf-8?B?ZnVadnlzN2MweEtlTVdpMUlHTVg0dTFNZ3hmNzl4QmVCa2FyVkcrN29tTnMw?=
 =?utf-8?B?SUVMNUdHa2hFSUJuMU1WWWUvYzBwV1g1aW1iWm9kWjNWOXlzaW5GZGtmeHdU?=
 =?utf-8?Q?l25iiOaxPGFAEmGd2jHQw3HVswVXuCFc2DEl8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d1181b-afdc-4fd6-4357-08df39bd2189
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 15:14:18.7616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oVTgfRqAn2l1fPs5wi0w5xsrXi7B0/4JhfcUYysRtGXSGFHQJyfWvZPNENrSMxRhXpmbuzXV6zb3UHBrIAYKcgHHPO4SxxBRZD1WYM17DLqEnyrmDCDOwAT5tTP7/kJV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR04MB025562

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
 drivers/dma/dmaengine.c                            |  49 +-
 drivers/dma/fsl-edma-common.c                      |  10 +-
 drivers/dma/fsl-edma-common.h                      |   1 +
 drivers/dma/fsl-edma-main.c                        | 241 ++++++-
 drivers/dma/tegra186-gpc-dma.c                     |   1 -
 drivers/iommu/iommu.c                              |   4 +
 include/linux/dmaengine.h                          |   4 +
 9 files changed, 995 insertions(+), 159 deletions(-)
---
base-commit: 2637bdec0535a2044cd830eba9a79363651d9043
change-id: 20261102-edma-iommu-v3-22b673717cf4

Best regards,
--  
OpenCode Assistant <opencode@Example.Com>

