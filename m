Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793601936;
	b=T6wUz91W0KqGNSmEjVjbq5eEMBCYZLrZHHfJu4TPsmYAusIYJqrj7bg5HEHU+9pJLwsJ
	 FgCsX5v/FAzQIuylRM7Y+etDneCZdN+q+jWfFruwDJRep9BLNYAaeBKmPCbv4EISSyh7o
	 x3KZPcW/1PlS/FJN4qDgYtyqZPL5HCT5iJd7IHh2stPl5WzQMDBLKUa9iuqmUjl3rTAOP
	 9LyrQMipzyNJGeRx2TzJ0a9lTgoqW8U061G2XW59XHLZYZyg0xjxty6RU9XKMeQiVwlfD
	 6swmHYTuKoITLHPzuLsY1RZ3Nr1Ur8eFqZZpaV3hIECgKJCNOPl9zJknvwHwjT9oKpg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793601936;
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
	bh=poGtDnZxtmePeKsTVVUnfOSeNHwkrod8TJEe1cbE62Y=;
	b=o4cqWuR4USPTNIFlZXXb4IUl7deLmjSFF4x5xDhdI9PBvJdMdIkmV9MAqbsZeEFdM5pA
	 cj8OZRDrkg50JZ3i2Kg3jja6RT2QTq5PLAF++u4DB3zmpUu7m0R6gS6xjVfcuqf4/Ru9a
	 PGY76L8Xot8hzLyqSDhzX1DLsdEALN8UNSzVBFfGoh9kWM2CHOlVCvTEaIezkKmpBsPXC
	 1EtkJJDTROmy+1pookz7kUUxqAzIDp8aUbvNwS/Sr3ujRyuvsXmHeLlYZ5Od9LP4eoBcf
	 /N7B8vULsceO4rPZTr+aAEDZfvJDVsoywjEc6moZH7jJtQuRkUAWa1cgz6Dufg/+f3A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=F18ss0CQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.32
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013032.outbound.protection.outlook.com [52.101.83.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA77606A329;
	Mon,  2 Nov 2026 06:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BA77606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=F18ss0CQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RxDDasMEw4yK5lMRC6g28/NqWe43aRsr160gBfuQ3P8IkVI1WWw4cUztr9ZtxVUr7dAGBeXc1sGguCwlbYpgad2hyz3+qdLAgduvOnRZs8KwvPZfLpcIvcY/3XaMH2g3q+a2HUz7kX1NaDHrD9jDl5kB2RfgepQJzDrAraTRaA6Drofw/s7uv+hwCj5pBU5gckjiIFRCE6JDtuvQXdSfVIE1KO1mTQp6h/YZ0wU9dEOz5f7Oyh9Vb1HOMblPVQlPgfQKg1gSbJvu0lQKAHfv5qjVKZeET06TO+3V+19TZvpGqQlZc3m/eHnuFOQQRgzgyueDxmfvhWIsXh1BLT1oOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=poGtDnZxtmePeKsTVVUnfOSeNHwkrod8TJEe1cbE62Y=;
 b=xVV1U3aHnhqsY/SNxdxM1mrXWfp1KUSqeHtmgpMlFgNAK3EBrikjRG6kOb6Zg7EbHfQrxE2q9Shv70PkNF52GU69Gf7pBIcLOU9kRpLX0sPNYpSI3azuGAZDyJe+VI9+rfS50pSsbuH57Rf49/PDxasD+oB7YNT5Y+HufxHgnUxXUva7w0oPmMcyNgMcfRWb3ffpU2bk361GNPUMc+UnWTZlVIGWV6wI13GqktlbCXg5wMGfLkVZQqjdztLgiOESj/Jp29dYNxurqNUAt7sGvQNMoF8R9c7ASAH81ogmEZtB23McemqYaxvTMTkJWLAZDDub68/+tyoBXrdCmromlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poGtDnZxtmePeKsTVVUnfOSeNHwkrod8TJEe1cbE62Y=;
 b=F18ss0CQTt48n+wk6BbohtzAzieLpjDMJ5rs7ICmBNyW+e7BGgajsHDAiWh5N/CVyjsikwvvJZ3Gav0T5Wgka8EtCHqyLDeu0Vi8t1zDXWT7a30v7IVNpKlAIwT/MOV9F4rZoqPF7VFI0i2OZRX+BicvNSfFlUkpOgGHxpKFRjccetVskRee1klzcRzA+Z7e8q/H8uDW+XGmsortZ2MOGoBJbg0ZZFFAj0EBs2V3azblQdsrELM1KZBnFwr9EPdptvtmGw5AQtPY9WUmzRyzEo3/YI52nMVBCty9TefepZ7f2NfBTgpKRY3gKoUgbOcQoVhlJPC+kaRQTRFI51MFBg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by GV2PR04MB11445.eurprd04.prod.outlook.com (2603:10a6:150:2af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 06:45:30 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 06:45:30 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 02 Nov 2026 14:49:56 +0800
Subject: [PATCH v3 2/7] dmaengine: add a bus for DMA channel devices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-edma-iommu-v3-v3-2-9d0e62a954eb@Example.Com>
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
X-ClientProxiedBy: SI2PR01CA0026.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::16) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|GV2PR04MB11445:EE_
X-MS-Office365-Filtering-Correlation-Id: e94583f8-da7d-4f60-86d1-08df38ace2bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|19092799006|6133799003|22082099003|18002099003|10067099003|56012099006|261009223027099003|921020|261021123027099003|261021121427099003|261022075727099003|11063799006|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	Q2WKtoW+uEC3k+8S8Ad/1r+vKjWi7YCEwkwkcEGebRqdKvu/Z9f9txUU+XWrf+lwSNnY6v7xLVaKlFmd1m3yQXRkg09plsnBst2GLjIKf4wibqIxylTKfT8Re/LsB7vMMYgFxf89DphVtlN3OdkllAb1xm+50689CSD3+gu1dWUMI9B9sOh11HGdj6f+jbsjh4E0N1tFOtKFmCUXE+m2s1lBMZyQKKVdH+jjuZ7sICpFWPvJx7PyLLo8G1lHsAKjGs+uXG2jJZXY+iZRBWR5GU1cKmjBLa10MO43Uipi5l2gadI7Tc1VhhvHs0DV91NVYdEfj5plR4BaTiHoNMfr5ox7GUq/gBfs5HNokmo7uTSio/CqyhU4jeDpXInzXf6LrdyiPelDIl1WMy7G1sIN/PYND5tT+xZMPUhbgAMqGNov/ebaJD/vrI5gTKVXef8vC+SW85Tw2pkrJrR4thBL7xf3FMat3CknaLw96C/U+DA7776EvGFZp1wwq6Of2mdVHchTV6gHu5KORzfM58NCXaOfbFwQQY3Y+BXi470sB6Igg5V++CK3nvECzmrxkuwN1CX3e7/hv+icASq55PzmHcFQagtNcwBq7PI5kCW9NnVsvIuMhgCB8lnknuoGQ44qP7d228HIGmXTKiSCu1X1QKwOR29JPKMf+2AV10zS9sQ81ezVTD0scLWMIjUG3C8Jezd2mUSwAmvcpNtizUDjHw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(19092799006)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006)(261009223027099003)(921020)(261021123027099003)(261021121427099003)(261022075727099003)(11063799006)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1V1TzFlTy8rSThleVVsc3pxN0pkc2JveFJ6Sm9nWVk5cHNFZmpIVDkxYTFt?=
 =?utf-8?B?V3BiSzF5T2pYT2ZwT0h3TGJ2RnpHYVhKOVdJOGVMOXdXUkxJbE1CQndDSVR2?=
 =?utf-8?B?R1JYbE1OSkwrOXcvcTlPWU5MYkZVV1FVUEJHcDlyWXREcDJvL2VjNWJ5cnlq?=
 =?utf-8?B?STVKdzIrMFVaTmZvZFN4NE5wQ1J3SmtaQWc1YVRTYUgzSDRwSTl0TGdQWFh4?=
 =?utf-8?B?UVhwUnFBZDZ3R29DSlIwLzFMVnZzYjc4dnM2TUtKWHZQbTlEbUVmcG13VFhq?=
 =?utf-8?B?aEN3N1RrTEpyNFkxNWU5TEY5UE9zZTQ4dDVSVmVoT3FudUZxSHhkdUVkVGlG?=
 =?utf-8?B?YkROejVpYUozZm10ZXRZODQ4Q2NnZWJyak0yMjJ3eFRRMzNLbXo0MzRBejBO?=
 =?utf-8?B?WnN5TlZYeEw0bTBWTGdKdXpkSVpucTdYTDBvKytzTjlPY0hrNm9RWTJINFht?=
 =?utf-8?B?ZUJkM2ljL013eHA3ZStISnFxQ2w0RXhYT3ovd2wwYS90U016VkFTWnNlN21B?=
 =?utf-8?B?emREaUsveGVVMG1JNXArT3RlZnJMZmJWTklmSk1NSytlbjBRZFZ6WXJMZWQr?=
 =?utf-8?B?ZXlFSTg0V2k2Mys0UmdGaTlQOHZvWUI4Z3lyNDRJQ0x0bVJqQVZ4ZHNUWTRY?=
 =?utf-8?B?MCsvT0pMV1RwemcycVZ5WW8xckhJUDJ0aFd0bENCUUFZeFIrK3lIWFlKekpp?=
 =?utf-8?B?M2ZleGxKaEs5OVZYVWVmU1I2NlhmUTJhSVhMWUtKZHN2N2JJNlUyMkJYa2Ev?=
 =?utf-8?B?Q3hTZmhNZGEvTkc3R3lmdWtuYW8veW5jeFV3SVRmaW1JNkdsRkFYZnJnSmFv?=
 =?utf-8?B?cXkxVGpieDhjKy9lL29wczh2YmR2TGdvM28wOHlWNHFNZGJ2bEJ1TVdqNEFw?=
 =?utf-8?B?Vis1UENuMWFHSXlWRjR0QzE5Uktsc3A4YzJGM0FNZ28rdllIeTh0cktPVGNX?=
 =?utf-8?B?UnUwck1mWEZCZlVYbmFVNWkvNTVqVFR1b1poeUl3eW1HRE5GWXlrajZzUGFT?=
 =?utf-8?B?d2U4TXhYMlBRbjJma2F1bnRFdHFXZkNDMDNRVTlOTXVrYVFzSUZQcGcxa1o2?=
 =?utf-8?B?R213cEJ1S1NRenQwcW9hWEFFeGpCRDg5UHNIUURpdnJQZHgyVk8rWUN4Sjcz?=
 =?utf-8?B?VHgyVUFqMERJQTRBZXpDQlhwSDU3L1NUSjRmMWJOZTdERzduV0ZUNWtJRUgx?=
 =?utf-8?B?THhXaU9OT3JVaDdsNDRSdUZwWVFNTElJVS8xc3lGRllTcG9SU3dEOS9VdGQx?=
 =?utf-8?B?MzVVdzRGL0h4Q2JMMFEzdytqTWJQUEhCSWYxbzJzd0E3WmlGWStORzRuSXZk?=
 =?utf-8?B?MzM3aGp5WjhGNHBVZ3drOXlxOUtJMkMzTHNPQkJJQXNYdlA2M2pndThrNzJ6?=
 =?utf-8?B?RHVMZ1d4VjBQUWczblhRRXg1ZWM4dTR2b0JuU0JNb3Q0Tm1TOEU0WUV6elZ0?=
 =?utf-8?B?LzFoYlVLUVpTVXhlZ3J3eXFPT2dKQWsxOVJWWWkwSjVGRzNZQzFTQXRaNGhZ?=
 =?utf-8?B?YTMzY0JuOW1BVlMyUGd4NFcvbnBUQzZnV1Q3Skt0OWFkaTMvV0E4N2VTQWlG?=
 =?utf-8?B?Tyt4Ykt6cGFpcmZLcUpNQmtYUG9ESkRSYlQ3bC9oc3Z5UjVqWjdIbGpNU1JB?=
 =?utf-8?B?YWJHeCtCb1RpS1pOYVNoS3NMY3k0K25PWWUvRnN4TzdOcW51cGNqNlVHS1dH?=
 =?utf-8?B?YkxsL24rd21ONUlJMzF3RHJ6S2xMeXFpRTBHQ21FSVJqcGdpQnJmejFXUkty?=
 =?utf-8?B?VXppbjg3emhvZmxmVkY3OWJyVC9TS0piMWQ3VmNDZGV6Mk1ETlpSSjhqMGxl?=
 =?utf-8?B?MEl2Y0tQQkdSRUNwRTJ2cGMzbld5N0IzWjBPRElvdWZua056WDlBRi9PcXhH?=
 =?utf-8?B?Wkl5SmxFb2VoUk1ha0RnRHJCUFpXQ0l0ckhBRTlEZ29ldkdwZEVSdVZWVEd3?=
 =?utf-8?B?UEdxRE93Uk44SnlKMnM5NEVwR2tVYWRyWk9LaGpmOVBCaXVxK0RHT0VBRHo4?=
 =?utf-8?B?dWdieXFHMkV2Z09SdFJVNk5tM1d6eG5vSG1XcVpoQUoxN0tDT2pWNGVhU2g5?=
 =?utf-8?B?bzUrUHhDMnppSXVEZStnMXVZSUN5L2lVRUV6dklGZGU3UXI5aEduYmYzR3Np?=
 =?utf-8?B?SGdRUlV5SlBRT0lIa0o1Vi9vbjJqM09QUU9qbEVCUEErZXJhVEdoeVBreDJO?=
 =?utf-8?B?Y2dRZk1SbDkrTE02d090ZER5ZWZCTzUwN1JERzEyQlUxZHJjUWRyM21WOE1L?=
 =?utf-8?B?RFY4VnFBbmx1UXdHNmZIMVNKZmZJbVJFRUtkcTlwNEJYc1lvME9NSHFqalBJ?=
 =?utf-8?B?My9kQTRYZUFtd051dTZxWEJmVDRCTVJDd0xzY1JyMGtETXA1WEE1ZS9QcTFx?=
 =?utf-8?Q?0prfSVL0mA+QaVCN8to9wN0F/doLOlbrIrE1t?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e94583f8-da7d-4f60-86d1-08df38ace2bc
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 06:45:30.0923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UelHgnrZKAMskiNvgO5/C3fMIEuigA0Oeg4lnoR5LUXt1Pizlw+gG8wA50mnbNl1s30jFUKfLha+ltvPDgGLInOhwj5bTdUFVA0xLDLV7OtJXdtDvfQOVhN/lMGSc3hf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11445

From: Peng Fan <peng.fan@nxp.com>

DMA channel devices are currently created as class devices without a bus.
This works for sysfs, but it prevents per-channel DMA/IOMMU configuration:
of_dma_configure() only probes the IOMMU when dev->bus is set, and the
IOMMU core only installs probe/release notifiers for buses listed in
iommu_buses[].

Drivers that need per-channel IOMMU support currently work around this by
assigning dev->bus after device_register(). That leaves the bus subsystem
reference count unbalanced because bus_add_device() already ran with a NULL
bus, and bus_remove_device() will later drop a reference that was never
taken.

Add a dedicated bus for DMA channel devices and register it during
dmaengine initialisation, before iommu_subsys_init(). The match callback
never succeeds, so no driver can bind to these devices. A follow-up patch
will register the channel devices on this bus.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/dma/dmaengine.c   | 24 +++++++++++++++++++++---
 include/linux/dmaengine.h |  4 ++++
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 34be53487a21d..6fea67f088b35 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1643,17 +1643,35 @@ void dma_run_dependencies(struct dma_async_tx_descriptor *tx)
 }
 EXPORT_SYMBOL_GPL(dma_run_dependencies);
 
+static int dma_chan_bus_match(struct device *dev,
+			      const struct device_driver *drv)
+{
+	return 0;
+}
+
+const struct bus_type dma_chan_bus_type = {
+	.name  = "dma",
+	.match = dma_chan_bus_match,
+};
+
 static int __init dma_bus_init(void)
 {
 	int err = dmaengine_init_unmap_pool();
 
+	if (err)
+		return err;
+
+	err = bus_register(&dma_chan_bus_type);
 	if (err)
 		return err;
 
 	err = class_register(&dma_devclass);
-	if (!err)
-		dmaengine_debugfs_init();
+	if (err) {
+		bus_unregister(&dma_chan_bus_type);
+		return err;
+	}
 
-	return err;
+	dmaengine_debugfs_init();
+	return 0;
 }
 arch_initcall(dma_bus_init);
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 805668fbe4376..14d8f182c7cb5 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -412,6 +412,10 @@ struct dma_chan_dev {
 	bool chan_dma_dev;
 };
 
+#ifdef CONFIG_DMA_ENGINE
+extern const struct bus_type dma_chan_bus_type;
+#endif
+
 /**
  * enum dma_slave_buswidth - defines bus width of the DMA slave
  * device, source or target buses

-- 
2.34.1

