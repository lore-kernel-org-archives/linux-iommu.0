Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793601928;
	b=VOzrJjFrQZvT7pEtLtAxN3Zjsil5sTz1es+m0MMNCXDy1bQ64yopG7lVcPpSBb0HGddc
	 xCm1oBmEGFex5ntmiZ6O4N+SgKqqfYwCMKaEGiW0e5fsaNyRQL/PNw1fT433LciOHGcC0
	 QyP6TDQEo0Z3I8sbOxawZ7/EhSpQfPemXXeGxwpRJUs2+Lo1mOheKqhf5h9LdxEfWr43E
	 XT/a/x/uwfv6ThL+J88cjkaq3Yq991W25dl75vvmjil3yz/irivM5C0HsugqjzI/xm98N
	 H/A8Lpu0809zd3L+fQnMSEFmcx2NuRCrq/vHLv7M+Pk8/ONScrpvttQain/svBQcHvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793601928;
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
	bh=5K4KLkTkwJbdSe8VZn1LAj04sB2Giiu60O7ovFGPvqA=;
	b=kvCTzbej7XfHjhTzcfHKTZA53m+HeuDo+suBW7ejQXtZuAm2us1gFVeRflUQYWAB/dd4
	 TykuHYl4JHI66qZHQpJi8IxwRXTLDEXwm201yNwb5tOf7zagD5ICARo7GlKwAzlzenQIz
	 tcokbhX2GiGOEHNaN1T+KjoNs84454ZAO1t3TjfXz0vkQMxNHhxkIN0EpPNEfjFUIr/yP
	 GHIuYoiO50CFd1HsxBFr9pFpqEoloFSbLz2X9xhdyITqDbo/1tZy9kJNESSqhI5XinySp
	 VPAcUm9MWnwgSxyog+WDDM9JNvgZBM+zvrKqqcy/j+zH+FDuwLFOpAW1kQNj6nb4/8A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=J9kgE5pp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.16
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010016.outbound.protection.outlook.com [52.101.84.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC04606A329;
	Mon,  2 Nov 2026 06:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACC04606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=J9kgE5pp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jcQ0d5Mc49yB/DCJIFiW4gi3gk9iijA4qdSTO6/MjtTp/BjJ+PJK5+uVjHYAOVS9KK6BkZiwsqIxtsHURE5c3TQH6asYJS8X2TLh8Ul69xXaFjT9snFKzyiBtiw8vFW9TCDjP4QWRtP0JaCxIc8bD5QNBYY2Tt1rNhxEu5OgAEdoLxtRFzIyClUni3SAo18+8WoWMvmegQiE6PsQHtWWI8zEA+L/uZB0XCaPctOS7SQ0mUJZlCh32+/qWWwNBN32xlJF3wcBV1FVP32Im4K4Ir4N/8I7599K0VrFxBA0cQcwhhTTN+8V+Gj6Nqsm/QyoC/uL5J9OPGhhu/UD54K66g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5K4KLkTkwJbdSe8VZn1LAj04sB2Giiu60O7ovFGPvqA=;
 b=NwuVXIeScTloti1J5z0wTMA57L4YmWAfVrLFigGTdT4dPCR6ygiVdOzHErElrJA8A13DFaHSs1b5LzSRLt7+gYF0MKEShYSWQVQMzemQ3EpsXjQcVSyXl7IijclyuZfNA9yWvN1j/Ndp22hZIbne2laHGoegYXtRJLfQqPjZY/MkcN8YAalSZrHdYtcUkmm+3RRYJvsiXixEY10b0Z+fHV+vjXHTT97rwP2kaFqtuyCjXyChYjo+KbmGYYnBhTNvYd6oxhBuF75mr+Z0em8AM5GV9HB9dChDPmFbsUKQesx6eP6ktbNxNNzqgLt/AzbYdeK7hxF+D/9uOO2ixX0uUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5K4KLkTkwJbdSe8VZn1LAj04sB2Giiu60O7ovFGPvqA=;
 b=J9kgE5ppoTyrDpR17GRz7rlXLqr9Lfnx9++AY5uoEuFtxsVjLR6Gz/EVXNOD14+O92LUncK6dW9IhXfkNgC06q6TieuiGlMzfZ2ZahgKx5HIBXXfQIjD+1eQgHa7E1kylzIB5Gb5wKkJPz9rVYwWwhGj3iE1vFjrRz/ItL1pQxeH7SZi1WigvTdiEzk1ICGwhdFRbLlIRFIL0YDSKcAv3IfWIt4lews4M9a8DfoJLU5c0gjV50EaAIZoMF/ya9r8IPElBE7g2f+AoZmEjuVVhYWJqfG1kszjzWMoPUCYsM0dIVOArz6GRI6Xab0cfEpP9Nj2UtT0hu+H1xk+IvxlMQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by GV4PR04MB11426.eurprd04.prod.outlook.com (2603:10a6:150:29b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 06:45:24 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 06:45:23 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 02 Nov 2026 14:49:55 +0800
Subject: [PATCH v3 1/7] dmaengine: fsl-edma: unregister channels before
 vchan cleanup
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-edma-iommu-v3-v3-1-9d0e62a954eb@Example.Com>
References: <20261102-edma-iommu-v3-v3-0-9d0e62a954eb@Example.Com>
In-Reply-To: <20261102-edma-iommu-v3-v3-0-9d0e62a954eb@Example.Com>
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
X-ClientProxiedBy: SI2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:194::13) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|GV4PR04MB11426:EE_
X-MS-Office365-Filtering-Correlation-Id: f149288a-95ff-42e9-4418-08df38acdedb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|366016|376014|7416014|261021123027099003|261021121427099003|261022105027099003|261009223027099003|921020|261026140227099003|261028144727099003|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SJpCM4a+8d8v45WOruzOmbwGUTzCjRPU6TMbs7za4HGZCoxiPIoisiLmI7Hps6OCfNFP/vV2sZy9q/cwu8uKu0L0KWAliYO/BcHm9PlLUMc723zZL9ZI1vkRqcoaoJn1e2aI+rCqtL82pQmGpqaHBDV+6npKl03G3ZKq/KqyB6UTMWp0AEK0ijOCF8CTOyuKU2UkkbMsDa7EdJkZK3B7yKLxzx5gXRVzWmk0JeBRY4h+fKQFUoDLzpnu/gS9l4t9e03596LOw+Z1QdH+Y1F9JOhGx8LkI2CAdjc1O4ZtoDJ/SyS39NBzbBdkjmNmsQyHpVfOoT7Hc2nQ+yXGzGpdzTG4rs11Wx2CFI7/RBNiIJpGMX0Kevm52SbpZ3BIvGUX0ZiaJ1cJ6nlc0s9yJzbImlJ687005S8xpQB+jfOp3nLhMYMe9C02FlAwgJaGeR+jtWPH/VQhadIcwyI12b7euU5HQBNDn4GI3dhEg22pEX6799V35wE9jNTbmdiWVDi11D26RViIu+cxweCPb/igJEKFJ5hrm8ANOrDi0yNGG98TKlMxAjsVWvqEvccblNlG77nBeWTXMaudPx7iMu65k3QjkazWIHgeEI0xAI7e1l6Tk2nqMmglWs5s6p3Y20bCXxwdDoFZ6YfHmepCNoZmRMc1KYxePJu+nfi4n3Z63lM4C+GdLYDvNZO4Y5wHvvxXkqYvmyjnG/5wttxdDk19Tg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(366016)(376014)(7416014)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(921020)(261026140227099003)(261028144727099003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWNzRlRXZHMvTGJLOWZ1eWZWUlpuOFVIVEtYdjZlYkxEdk42Q0FXT0hHRVFB?=
 =?utf-8?B?M3NESUwzVHlTbkRsSU5Yc2Y3ZVlVTGExTFdZbmMxdjlOU1g3di9LL1NSNmZy?=
 =?utf-8?B?U0ZvYnFHOGNWVjdJN3kyNXNSTi82SWJlcEtJWXFwYk1WV0lFajBsd2ZFVEJp?=
 =?utf-8?B?b2grOHRrcmMxTko1WFJlR0FUVWxrb3BQWmVrVEN6K3RXWTlrQTNTWlBvMkE4?=
 =?utf-8?B?U0J4aGc0MHZCWklHQXE3dExKMDhObkdab2VzdGR6WDBQeGtXTWpsSzNNZnd1?=
 =?utf-8?B?K0RWNDU5RExjQUNNS0huL0hjVng2OXUvNzNZY0lZU3ozSTVlQnF5bGkvN0NM?=
 =?utf-8?B?TFNWWk92MHlKNlYzWGVreDBqMlV3Sm0vNjZ3YitVNUF2ZXhkaEEzSzJNdGRQ?=
 =?utf-8?B?dmw5N3dwbStGMWJMeTFwd3hRdTFGbnJocWhlQkZzbHI1SnZSckpmYUlyUVdu?=
 =?utf-8?B?MFkzSVBoeGZJd2g1Vm9adjR6YmdVbSs4QTVvWDU3Qys0S1JRZjZhZTJvUk5U?=
 =?utf-8?B?MVpVMEhXdGRFdVBIZ3kzcS9ZU0s3SXg3dHFqUXQyODRVTEFUWTljeWdlbkxG?=
 =?utf-8?B?Z2RhWXV3cU1ZaW4vSjRXdGJTR2I3Qno5Y1FNV1dSVEFwQ2I4RjlNQ1Z1bGhS?=
 =?utf-8?B?MElYTjhoQXJTdis2cjAwMDkva1J1eVhvcnVDWHRqUFl1cENsQnowNmdKUUF2?=
 =?utf-8?B?U0txaE9sZVJyTGh2M0VNVW9zdHZRVGp3WVBJMlBsenpQL015U25GZlIrNmhs?=
 =?utf-8?B?ZUY3STk4ZVA3YlBWd1NFZFJCU3F5Vi80Y2JCTlZkb1hIMm4rTDRuQ2h0UHlt?=
 =?utf-8?B?SG82SllmYTdSSzkydlJCTlBmd2F3NkwzS1dWOUovMTNtQkZyK0ltVm8xdU8y?=
 =?utf-8?B?MHFpSVRNSkJhZi9mUzE1Wi92OWwzN0NsLzYzWEswNEcrT3J2QXByczcxbFhu?=
 =?utf-8?B?VWhhUk0zVjNwM2hHeG1sam5panFHazZFT2NMV1RGVTNodncxSEdyLzRMaDlO?=
 =?utf-8?B?RUFhdm04R0VWRzBIUmV4aEp0c1pnS21tR1hML1U4Q2ZVT2U5SkxxNS9IYjEy?=
 =?utf-8?B?UDcxNG04NjVqM3QzNk9vNEpucllYcG9FbnI0OHJxVHNZSG1IaEZKbnhOMGda?=
 =?utf-8?B?b0o2bkZZaU1lazhzdlBUa0VYOTZPT3N4TFBiMi9Mdi93WWZqTCt3WW5QRStt?=
 =?utf-8?B?c2ljOFBRMitZa0pZbEdkUG5jR2JhTmVZVm50UUgwNytURDkvMml5N0dPMitk?=
 =?utf-8?B?anAyZUZVNTlZT0l3bUFscHhtalZ6NEtveGUxNjlYSmxCM0c3YW9CZ1FTd0Ju?=
 =?utf-8?B?T0w5dGdrVDF6VzJOWFFuZm5nejJuSFppS3J1aDF6NGJWVW0xM1l6K29OZFhK?=
 =?utf-8?B?TG94ZlRZUmN6TjEwbGhTVGRrdkptQ01XV3llemlFK3lTTEhmRVBiYXpnbU91?=
 =?utf-8?B?YU9zV3I2bVM0VEpHSnd3QlVvOXpmOUluWkRGelh0T3d1WUlCSXFkd29pS29t?=
 =?utf-8?B?MmJ2NnpXaWVRTmhIaEVBdmltQytZZDZveEtZM1FnM2syaWU2WktaKzdkUkRu?=
 =?utf-8?B?UUpWMGxxVTlNQVZPb0RmTDJVTlR3RUJMRWt1L1Q3YktSVzV3RzZZNVZYdE1n?=
 =?utf-8?B?R1BaT09yRVU1QytnMVA3eU8vNENpWXlzdEgxdEgvamNNRHZUTkh5cFBDOXdq?=
 =?utf-8?B?RzZ6ZjdkT1FXeStSNVdKRjJHczQ5Rllxdm1JbTEyZHlnSFlhVkJUQ1dBVXBK?=
 =?utf-8?B?TzdkTTZGQ0R3STlVMDBRSGxZc0UwTUtrTERTZXdIbTk3Z2pybHZSNS8vNmpB?=
 =?utf-8?B?cFgyZ1luUEo1cVBkT01kMlNXYVFsU2srYzBldE9IN2NBaXhVR2JoZjdDdm8z?=
 =?utf-8?B?cjNsN2habGJFTytka2ZEQUwzNmZFSVNxdURMbjA1VUMwb3drK1A1WHE1WmhT?=
 =?utf-8?B?cVBtWHNzelRpUTlHUTZCeVNKa2l3ZlNtWnVZeVkybU5aT21vcjJLaUUwZlpu?=
 =?utf-8?B?cTFhd0IvbTFwQUY2TDJIMkRVTWExSWxPYnJ3blVqcmRGN1I2d0pmelA2bXFT?=
 =?utf-8?B?cEF5L1Rhb3ptZ041SGNWWmFyaXlWQ2lyR1Rtb1l4cmlwem00ZGQ1TEJvUFlO?=
 =?utf-8?B?QTVzNzhwN0hNRXZySXNEUnVFTlNNM2FZT292anFudktPQjhseWZYcE1pYlBN?=
 =?utf-8?B?azB3TTJvaGd5MHVLaGVpU0xaUzJ2ckpjemNKOXUvdGo5WmtPeldmOGF0dG8r?=
 =?utf-8?B?L29NcVZPalRBajRNVHNzckplT3gweFJ0NUVNdkNrb0wySCtwc3R0RlZRTUE2?=
 =?utf-8?B?eDFvZkgrVFVyeXVBeWFoelJzTkQ5Z3cyM2JNT1RsSVhQbitGRXFUdFR5RkN3?=
 =?utf-8?Q?+R2+3mMPSwXOdkNfRGTUjAhxZ9mQOZnm9IbYO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f149288a-95ff-42e9-4418-08df38acdedb
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 06:45:23.6209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N9lBhvI+XQQ2n5oWyDYjXriv01RXRshDUJF09WqEWfxiDkILEYnM+eZoVNVeUi75P31dN8a3HbV202QsrzmSMeH1jNIaUCEq7N8Epzsqu6GZy/DFlTQ6fr5xt3DffaLm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11426

From: Peng Fan <peng.fan@nxp.com>

Since commit 4035726a6b72 ("dmaengine: fsl-edma: Use managed API
dmaenginem_async_device_register()"), dma_async_device_unregister() runs
as a devres action after fsl_edma_remove(). However, fsl_edma_remove()
still calls fsl_edma_cleanup_vchan() first, which removes every channel
from dma_dev.channels.  When the devres action later runs,
dma_async_device_unregister() sees an empty channel list and never
unregisters the channel devices. They remain visible in /sys/class/dma.

Keep the vchan cleanup, but register it as a devres action before
dmaenginem_async_device_register(). Devres actions run in reverse
order, so the DMA channels are unregistered first and the vchan list is
cleaned up afterwards. Remove the premature cleanup call from
fsl_edma_remove().

Fixes: 4035726a6b72 ("dmaengine: fsl-edma: Use managed API dmaenginem_async_device_register()")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/dma/fsl-edma-main.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 630285c854824..30d548a723462 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -31,6 +31,11 @@ static void fsl_edma_synchronize(struct dma_chan *chan)
 	vchan_synchronize(&fsl_chan->vchan);
 }
 
+static void fsl_edma_cleanup_vchan_action(void *data)
+{
+	fsl_edma_cleanup_vchan(data);
+}
+
 static irqreturn_t fsl_edma_tx_handler(int irq, void *dev_id)
 {
 	struct fsl_edma_engine *fsl_edma = dev_id;
@@ -882,6 +887,12 @@ static int fsl_edma_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, fsl_edma);
 
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       fsl_edma_cleanup_vchan_action,
+				       &fsl_edma->dma_dev);
+	if (ret)
+		return ret;
+
 	ret = dmaenginem_async_device_register(&fsl_edma->dma_dev);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret,
@@ -906,7 +917,6 @@ static void fsl_edma_remove(struct platform_device *pdev)
 	struct fsl_edma_engine *fsl_edma = platform_get_drvdata(pdev);
 
 	fsl_edma_irq_exit(pdev, fsl_edma);
-	fsl_edma_cleanup_vchan(&fsl_edma->dma_dev);
 }
 
 static int fsl_edma_suspend_late(struct device *dev)

-- 
2.34.1

