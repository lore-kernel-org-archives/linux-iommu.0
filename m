Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793601941;
	b=VErUhOYQmbww7N4ATf14A6eolsGnKZTCnC8+86rARyStuSrr/Rcphp/fX5elzruZO9Z/
	 FJ+eQfrA7Fmx4YUaD8jaJrN4erqDXzC/WUsU76tSflb0GSOPB1Abq34GyzoSSHE+MSDfj
	 CEkv/b0lFTkzD+sApwT5/G8TeNZ84Y9trELQjoTDZdpPMVHEOeurHRCCWgvz+JL0k00NU
	 iSpUEwx4fuESabgRlNExqcqCcQRox73DoQI/UoMKE8HXKTgiT3IEq8MoyDzvlt+Nk0owx
	 uylEemyw8wPVAfVvp5wXeiOd9wbBkURQ9gSMPImHr4fpDu5lST5Ws0cFxpd1EjEQdjw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793601941;
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
	bh=EczbYvdh3JPN0uVu3WxZHYrBmYltRa9X9QZu0G1lA1k=;
	b=ugCwawJNShcuclfwBMADKsidEs5Q/1DkH43dGyr01Roi4Mjd3TUckSkn/kgTy8x9ewaq
	 zHrk0MsdJw4GkVU8O5FFE/X4B2VMfRCkDUwcBu31fHymih+6MTo342vr9aEVH+doUIjfC
	 zXQt37fvDpysSHlu6PKhSH1I9kDQXeq3vidXCbKjvbuPKpJOTi/iZrauQr/vPGa9YnZTD
	 qFDwT87ypUu8Vmzor20jXqlSYX0kTZX3bfMchPYNCboATB9pZE4PGVNiey5O1opxXU3rt
	 0XZWAR7nk2wp8XUe0p8pHtXnFMVlNmOrNsgqbWC4OH1BoNrH8tJXvWiHF+vYyllatMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=gRq5JqNq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.41
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011041.outbound.protection.outlook.com [52.101.65.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8B5606A326;
	Mon,  2 Nov 2026 06:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A8B5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=gRq5JqNq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QBhficNRJuGxhnQtFkxLBf+150kxawFQXJTVQgZeCCvtoOjt89lHtO2h4Qu7XY6TCAAbOhHRdIoFqY8SHXT4GLO1Cf85B+VIrogGA69Q7CnONsPoTVITnOcXlXKG3lWgSwkExIjqGUrayBKSyAbSblaN1075DSJfmfAdsMeJ3Eb8tl8s+YfyIaQuUpksLdAChjByFeOaoIVD+QXbpMg/mLCeJCrpWDzeXY+TEh1uRZCPnDL/ptvRBwJTY6HxNlZIHAHRxEf284J9C9I8xeF03FvUUGQA5kS2QaicFN6BqBtreGxKdVgKF0R2Cdy0FmyydGXLzFKYZVTzdP/6529Djg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EczbYvdh3JPN0uVu3WxZHYrBmYltRa9X9QZu0G1lA1k=;
 b=qwZYyh5ZBPFNdbMkjoycdif7JtLfVYLJeDAuxPSMQsksEWIZtFPJovWmCr2RJOYPeIHNnQtmfRLfWNGvE++1sIUeCIyVtfIZ7Z3Uok/eBOlLZKHIOwuFqIyl4kPZKFtq6Hqzo0JslOH1TUNRkEQSLxuYGatNvUQkC8TQJwgxOcrJecvVIJLIgwIP47YaBwDL2JIIXcF57oOa3zUN9DtJByxRftKq1+7c4pmr/a4d1+RIr3dIEghHSk3GGGglRBRVKqTQ6AE6t7Bu/IhL6DkVWLooe9AE9/cn+VBYCfuOXPz9ZeZe/CFfb09miyHSA215VRURbDNWCpiEze2G+HoJfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EczbYvdh3JPN0uVu3WxZHYrBmYltRa9X9QZu0G1lA1k=;
 b=gRq5JqNq5Buc4WhW5Yls7BYW4+5/qX5K6f7G6Zc7ex4CGoh9i3Gk5RMTKHRNL1u/qFhM5wevQ6Et59qah8mZ17ur0ItpeGTE2QO0nC8NHM5071ctAgjWDaSBCnxlyO0gyGNNEX07EsXvrfa7X0ghEsDCJ7SouD7sPRU9XKiTACfAo2U45jIzZoah0SOXVIl0Z2otp1qhcQq0Q+vEKspde9RROc5v7xpD+eJpx/OxjnS4hx14196VH7WYtP71O4lrSamueRWbkEmrwgeWirLlXos1zN7gkHC31McwzxaJ1vNc2Cw1AsQGFdueWF2Hh3MVMAmIkFXc7OqnwNladam2Sg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by BR0PR04MB055120.eurprd04.prod.outlook.com (2603:10a6:2c8:44::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 06:45:37 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 06:45:37 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 02 Nov 2026 14:49:57 +0800
Subject: [PATCH v3 3/7] iommu: register the DMA channel bus for IOMMU
 notifications
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-edma-iommu-v3-v3-3-9d0e62a954eb@Example.Com>
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
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|BR0PR04MB055120:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d5a117c-6eac-49e6-b50a-08df38ace6bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|1800799024|366016|23010399003|10067099003|22082099003|18002099003|921020|56012099006|11063799006|261021121427099003|261026121527099003|261026140227099003|261022105027099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	xjbRyCQtjU0VpAR4aeoUVOkbKl7ANP8MneibYpAgPEVPmi8XlwW5oNXmd3KlsGk4rN/91WvuHZ81uAAm5RgF4LI0R6D+R3OO5aJaW65uRXFXFF5fEouzC4FpkzOTSbWpkxwb2ZECwCG4UyLr7/pIbX8MZk32obc2eTWnYZgGfAaGEriyrNSlJ3JQj3lR+y1mFPkB1ywfwtQaKZNCUc5fD3AceQuMTAmr7c7RJegMejRppR5SKqA2jQIgw1Dkl3sh5TxiXcArEhEBtpcmoIhfHA9TN4zs7MjUPDW+MhbhnaXUodqvUJp6fXo/nmy5Hy//XV8N4KvErqergirdcQYUJy8UVuVhAAiph/7r8rnqHIPI+k3rCAtvO5wgo4Dm9uk3mP0O20qkY4z0DY8xuns0NSUmhpj8CHkyOEMdKsq+wL7tg89K6pqb2TzbdhR4wvi9i9C8MciQwrWecYL+qerqJPdYALWdCPc30CquDXJz/gkDvgoXhHMzNKVJJkE/lF7DV+p6+JtOjESDl5OSInJmtE2i7IN8/0w+yRsXYraF3YB+mtA3tqI96qw/9qKSRqdTTGfq4Nc/yhGOVhdq1nUHZnIs5j868hLZZJ22tNfGd4+jgxM+95wz//sYl+cqn5SwP5moD7RqXJiry6T+WCemvyiVOpAAhd6canh2pr7yCgCycn2UP0lwjHQvd3YHsXBEVElDZ150zCj5StPnmmqqfQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(1800799024)(366016)(23010399003)(10067099003)(22082099003)(18002099003)(921020)(56012099006)(11063799006)(261021121427099003)(261026121527099003)(261026140227099003)(261022105027099003)(261009223027099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0VidHFZSWhxYUxDSWwyRWJRd0xjMGhpNHcyV1NPVHdNbEdMNkZycjlkRHFX?=
 =?utf-8?B?SVlQczJIVjVDd1lHYzY5dWUydk5SL2FxcVlNd0RmU2R2dXhETHRDMnZiZFJR?=
 =?utf-8?B?NllTcUNFeGVxRjBXdGtMTFV6cnRnNHJ6VjViNUF4clI4Q2xvWEFSdlAydUlV?=
 =?utf-8?B?cEdqbTUxN25aVGNmWjdlQWxSRU1sMU12SHN6YmJzVFR6bTBXYVdxbXFxeDUy?=
 =?utf-8?B?YmdHZVZJUE9sa3NZSkYrY1gvK1VqRXpVK3QvR0dkZk1JbDdpaElTZG8vY1N5?=
 =?utf-8?B?bkhKTk5PemRBWW1pQldGU3gva1c1bVVJenVlY2NvczdzQW5BWEgxU0hjMXcy?=
 =?utf-8?B?OG94aUU3NTAvNUlMUnJVMklqVnZVTWF6YU1wM0FNV0tiSlBaRWtVZmxRaHdt?=
 =?utf-8?B?M3I1MDRHQVpxNVpvU1VzNUd1Rnc3MG9vU1AyczB2QzBTdE5ST08rOC9VYS9s?=
 =?utf-8?B?NlVTbGtSWWdoZ0Y0ZVdrQzdGc09zTUVsTFpBc1JtdlIxMEFid2FVbnlFOUhZ?=
 =?utf-8?B?VXFMaGUyVFowcC82M0xSSGs2L1VOYTBLOHUrb1VVZGFZbnJWbjlOclhkNnBo?=
 =?utf-8?B?dFFqdEp6SjVlMW8wRG1YRzVYQTlvZWNjMTRXV1gwNngyWTc2RVRTNmQ1WFJy?=
 =?utf-8?B?MW1kVncyaitGMzFkL2EwTkYybHJSUjNTd09URjdZeFpsTll6Yk04Z2oxVWUy?=
 =?utf-8?B?N0kwUlViYmhVNWpxQlBQdTMyc1dwUjJ2QXlqK3liblFHWWxhd1lUNGtSV0tN?=
 =?utf-8?B?NUlVdDIyMFBKd1k5WUhhcjRIUSs0cGEwRzVraTBNTFhLK2JuOVE2enk2R3I5?=
 =?utf-8?B?ZmZtbXFQenVWREU3dGRRVGo5dFVSY21IRnN3UXU1WjdYdnJRRG9CRnRSSE1Q?=
 =?utf-8?B?YW9HbFZzQnJ4RTdtY2o1S0FrT0Rydno0RzhTcEZ4R2o0ZGYzRlJYZGRkSW5v?=
 =?utf-8?B?KysvczU4S1Z3UzVLNDVSN29oN2RPb3RTVTNJUlRRRzJWaGFPMWUrSEdMOUFx?=
 =?utf-8?B?bzVOUWx5NkgveTIzTGZmZlVsVjQ0SEcvVUJnOU50Z0ZTbDVXN0Q4dlNqSHhx?=
 =?utf-8?B?RGZsMDl3TFVhNW9WcWVPbmtjNWRuc21uVzBHeTB3WklYZzM1N0ppd0YrSjlz?=
 =?utf-8?B?dG0yUExOeXl4UnNzTk9FeWJSanRNbjBvbFhrTHFwKzNjNkhLK3c3WTFja1Qz?=
 =?utf-8?B?RGlHbmpMVWRLSDF3Zk00eEgyQTEweGJEVExhdFM1Y0VpZVdYRjYxcE1xa0pR?=
 =?utf-8?B?b3Boa0lrMG8xemw5NzJNcFIxdzVXNnR5c1dQNjYyZlBpWWJSaWl6bWxMKzVl?=
 =?utf-8?B?T2FtVFdkTndlaTBSekFEdjNrMTNRMlhIajU2ME5oSm55Uk1aZlN3YWVTTjdU?=
 =?utf-8?B?L09SUGlZWEVLK05pckFDeGZvbmdycmZBSFRlRjF2UDRtMlp4QmNEV1hFNzhM?=
 =?utf-8?B?S3lvVUlzSXUzTG1aMGt4UExsZFNSa1RVU2dqdjhlV0hlRDhSVHNNeHFUeS9i?=
 =?utf-8?B?b21ZcXI0a0gwK3hZZTEvUlNpa2dkcmZzbXFLVWhBOWg1TG14VHpoeFhiaVFQ?=
 =?utf-8?B?cXVQY09FdTVkZW5kRWUweDNZSnRNcFJDMk8yV3oxdTdNUFlpd1pGdnRiWlBS?=
 =?utf-8?B?cW9aRjF2d2gzV1h6YTUzazEvTkptOHRQczZQYXBQT1BmNGxjaVF2QU5KcGh6?=
 =?utf-8?B?ak4rMHlnZDBMUEF0cjNtYVF6bVlaSk82a3EvSzZCVzk4cEJoaUE0MU9Cd3ZY?=
 =?utf-8?B?M0VXa2VYQmYwcjZFTGpQbkRsV1ZVQTVpTWZEM1NwN3Q0NTRNVTBnWldTTk1T?=
 =?utf-8?B?d1JCK2hPbVh3NkFNZU9mYmNSRlZ5Y29xV01IT1ZHREwvS3BqTUxRVzVFbHor?=
 =?utf-8?B?R0laMndVODVhNUlwWjltUUpZYThmaEhyUnhqVzRqRVF1M3ZBVFpCa0N5TlVr?=
 =?utf-8?B?QXhHNHRhSzVra0J3emNZS0VjSWpwa1FJU0gzR1pHZm51SWhsL1VBajFFajJu?=
 =?utf-8?B?L1pFanZuY2FncXFaTjBuSlpDeXZiMGh4NE5GVHJob09UdDRpc3QvRmU2bjZF?=
 =?utf-8?B?YVRna1dYRkwwamhLK1A4ZE9PaVQxUlRrOUgzT01hNjVMaWk4T2N4OUFOT2ph?=
 =?utf-8?B?MXVNUC9wYjBGWFY3ZW5PZ0cwWXZWRDVudkM0T3lrbkk0by95WTkrcjAvV2Qr?=
 =?utf-8?B?ZDhFVk1hcno5UGdlKys1NWZLREdFM1oxYThxRFBKSXYyVm52NVhML1RQbFIv?=
 =?utf-8?B?a3ZzRTBmbCt0K1VwMTVUajVXNVZqVjhsRmE1enhuc2w5N3ZrLzI4VXB6QmQ3?=
 =?utf-8?B?c01TK2xCNUJaaDdNcTU1MmZ4Z2pDb3pyOUhNeGg5L0dmSFM5ckh4ZmxHYTg4?=
 =?utf-8?Q?gffBij8dygax1vnDsL44j0YkOuQ8v/4HPlqL5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5a117c-6eac-49e6-b50a-08df38ace6bb
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 06:45:36.9593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9hNjVVIRIReHYzCm4CFBwUi1FQze5xHm7xY9KMWTibms/8T4g1WbN+5hEmXFOFgkoBa9yUrNrdIW9mHuBXw5HuLA0lmhaxHeFsMlKCqxh5aErNIHBb/HLwhGvLoBtp0M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR04MB055120

From: Peng Fan <peng.fan@nxp.com>

DMA channel devices are about to be registered on a dedicated DMA channel
bus so that they get a properly balanced bus association before
device_register().

Add that bus to iommu_buses[] so the IOMMU core installs its bus notifier
for it. This allows of_dma_configure() to probe a per-channel IOMMU and,
more importantly, lets BUS_NOTIFY_REMOVED_DEVICE release the IOMMU group
and domain when the channel device is unregistered.

The dmaengine bus is registered from an arch_initcall, before
iommu_subsys_init() consumes iommu_buses[]. Guard the entry with
CONFIG_DMA_ENGINE because the bus does not exist when the DMA engine core
is not built.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/iommu/iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b486b8bbd1fcd..6fa871bbd63ad 100644
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

