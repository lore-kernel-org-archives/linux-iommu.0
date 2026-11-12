Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.60
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794498478;
	b=0e/nRTXOwsMrJrK00NmEcNBg50UPo3sOY8uHdRLlqWTAju4bJg1/ONkLX5SGvVhKxxzJ
	 wfrB5bWMCzXahtZjytD750SY9FkffvFC+jFnLZULXu2nXfF8izPoCAoH5voy5iRuTrH6x
	 AnIWN85FXemPv6yifZ+kHVH8cBgA83BvNmdGcLbtqXz7CO74pa65zU9HPnnkDnqxVKdE0
	 FQ6VO1v2pYw0bI8CCD3D0L/okE7lM/gXraoBcgEW/nN5XU/Q1dnljSltPzFlMA+zrFYtp
	 0jttNfZoI0rniar+WjLg6lJI9+YAtaSrRb7gS2SvRW9SUw5InBoev7YyjAMgG9ou6Ag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498478;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=sAl1s24kP8ODnZ2bhPBD7erUVW/lulh9YNRN1oKpN7o=;
	b=WOjmKulZj7O51gnVs6qrl4n7y4zmaNvTUROyBSRHn4CBQW2P5isA239VpYQJLap857g7
	 +wplAkE1+EuWW43dApzhLJv2xJGgi1K0SbMabttEZieJVVv+u3bSD8PcMfebmtPQyADOd
	 FRzDfcIuTR7wgwaJMK/Cg/xZocDPE+yjuzHkLO6fnSSQBtTYObKODAAyoUjXLaUOi9hY9
	 guvgxTrvhd4+4YVuXQlDxy6jFoClJsTDijpRfrK3luBLExWXDOYFWnnqN8GiCo1LrAMFQ
	 t23gjj2qZz3NxNffG6HRtqW74wxTc8/gi+s+8fCSab6tB55Fy5pP1YOcHTUIAu69mqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=gpHWiBHb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.60
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012060.outbound.protection.outlook.com [52.101.66.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B5E606A321;
	Thu, 12 Nov 2026 15:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37B5E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=gpHWiBHb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v6MeYUhy9b8Wr/kDB19czlazqF2Zx0/m2W4l1qbD2Qe1ckq0YE4Ajjo5MUyHlCkwl1UG0/LN5dmmwqPv/w8yptUUSFVeQ2nme0Ig/pieCCWcFM/Ban95O6gEwCI/AfWYnfZVPkNpd/ZPc5Md2lvuFwXYhSHNZfrbp1e37hunIVIM9HdzVF1ACCXh5ycAPzRfod+yE8O8R9txgAxjMa0T1xnHoMMpRI5cYW8OAFsZy+LuYMhljnm2/4G0dL4YrK//P36Ks6Q47IJCVIe5xYztd6to081fB+n8VODMeFTD69CpUNxZnShjr02v00CsUqZoi4IhABzl7yW3uJj3XnjW6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAl1s24kP8ODnZ2bhPBD7erUVW/lulh9YNRN1oKpN7o=;
 b=pNy6DRJ0mkRh2C6DgG6Agjqr5idhyE0oIeXVJ+F6UGflc1a65Eh8BsjPDObTD7n2wL5hltrlfzfvNVYUyANFqKASG/no/0co8WD8SBEzYbZb7yNYA2FX4E8w7L2TCYJc3mGdL97DWFVT+qxhEZJrbH8QDhHB6GOdMZiUsdA+TK5YQoTxfGaJVuskzZLv13Vad5sxsll3EL7+fqr2NSOLKADdoRYpVYgimkSbirBjVGrZuA2fz8nQLL68lpK48jlEgeMrZIpPbREFCd2h/FzAuRGWI8xS9ErGxjN5uCLDcDvLR8lZZLaidnq5SsBKalbWdYweaF02C+V+mkVtZl+ASQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAl1s24kP8ODnZ2bhPBD7erUVW/lulh9YNRN1oKpN7o=;
 b=gpHWiBHb4tCIHjNjwrzel9cjX5MRys8pRc6dBdSul8FPGGLYIdhs1H5LsF5RlcF2LAYcxdFIT0NqZerH+Dqm6EakSgLZFVCJ1/PWsWg4jzcPozkDy/XosYEYQ81moRIii8JAI+Rjs9jzIIIAhY0iMMaz3MgQo3xiUROIW/yjHs0d40plbX4pqjn2uuXkkva7wjgtD3D+1r0XR670K3UlkYwFBks6eSiSHt+TUGWspAlP3rVodLGOduzGD2hP2bLaVbKuNlOwNk5t8Pb1dSkz3k+FbXc7GeDYGMk+oyfg6mqbU0dAuOnk8E/bZs0LNzF8MPVKEu1fhWPlT+YUoBp4GA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by WA4PR04MB786416.eurprd04.prod.outlook.com (2603:10a6:1d0:2b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 15:47:51 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 15:47:51 +0000
Date: Thu, 12 Nov 2026 09:47:40 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@kernel.org>,
	Larisa IIeana Grigore <larisa.grigore@nxp.com>, imx@lists.linux.dev,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-tegra@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v6 2/9] dmaengine: add a bus for DMA channel devices
Message-ID: <avXfnHZVV2QRgSvu@SMW015318>
References: <20261112-edma-iommu-v3-v6-0-b038edb8ce6f@nxp.com>
 <20261112-edma-iommu-v3-v6-2-b038edb8ce6f@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112-edma-iommu-v3-v6-2-b038edb8ce6f@nxp.com>
X-ClientProxiedBy: DS1PR07CA0024.namprd07.prod.outlook.com
 (2603:10b6:8:44d::6) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|WA4PR04MB786416:EE_
X-MS-Office365-Filtering-Correlation-Id: 1805f44f-7a55-4c3e-6b3d-08df40d44eea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|19092799006|1800799024|261102130727099003|260925021911599003|260925022911599003|260925021311599003|11063799006|261026121527099003|4143699003|261022105027099003|56012099006|261021121427099003|261026140227099003|261102124527099003|261009223027099003|261021123027099003|261022075727099003|261028144727099003|261102123227099003|22082099003|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	b7YEeaurCpJP++hcai4uapI9Ob3rn8QJHpjBHhp5ge/L/ei31cbyqFObbTO8L+TjvIz/+xzW3OT00sWXAQ55SpLYG/8rboag/OC75x4uPDjeYJUxl/OFUW8BRpJlTjN0jsfspW7wmo8nTNx0aDxyIBflri5ZFx7L3EGCbuKkI+1sSPX/54uqwg2RkOFYIgQynK/lR2Z/fMT2XSL8TziyWsjXQTTYIE4rcen7koHtXm6KlGNOFr9iXLwY9GVEARreTK9oFSWdy33hzWTGlnsqFn1LXVL+OxG6fhWiKVGL0YKCdIhVYpezTiJzWVIBOQ73qwp9ma1s8KgdsDr7DbfaDnOY7XPXsz9lA65oxnyU5P1OcLK2hlQ2+yz629RwU4r3eVPtmJESSJTUv3MT/QoeihEtDkYCD3pF7Gzf0s2WnkvLgJxYiDddaF7YSE3oXKZ0Fd7X6BQ3H1Qf7n6ZtxgTCIFPw7n2qfsrzu4Tfb5vYhB7dfcxN7I7FhMjcbb1gOaQHb2F06y3UXtaKw4OLd/a529NWtSGELynD0yEWg5cPDvkaSXzK30Y07IV4xhPctuKR8tr/JMukTRTFH7vDATofrHFwyo6lvBImutWW9tLw5cPs7bv/xPI2unZ0sqo5fNY5UnEECaAUqWujl1THp3+zjf3r4vyX0+Ua30Cx2pwcCA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(19092799006)(1800799024)(261102130727099003)(260925021911599003)(260925022911599003)(260925021311599003)(11063799006)(261026121527099003)(4143699003)(261022105027099003)(56012099006)(261021121427099003)(261026140227099003)(261102124527099003)(261009223027099003)(261021123027099003)(261022075727099003)(261028144727099003)(261102123227099003)(22082099003)(18002099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hti6NSkNL2kWMvtW6weE+gJtL6NWDQnmmYCATYhVNyFvtyOMzeG8kmYQsDkf?=
 =?us-ascii?Q?vZMdNUJi0LEvMWf89pfZlCE9m24XNKymnLMLNhtj5seJc+gmq6hcgkia/fTH?=
 =?us-ascii?Q?cJZAg46U63IrboUwMj1QiQtDIC1wc/X0byf+l4YofnFvLKr6qEoO+8YKGI+P?=
 =?us-ascii?Q?vIfRrwM9ph2QOWx2yBZ0HuBi2hS3ReZ6R/qaga+3FcJWwS8gTJB+XDh2lQlk?=
 =?us-ascii?Q?wzLpNm9OYcZoFFuPzbQcmZVkkF2Qh4laA7IC4spb7z/tLbfhAQqgvfAyWGLY?=
 =?us-ascii?Q?/u+5GDLZWHjBHPrKxTL6cU001pNoez7mhf6aps9IA+/nPw2hs6qpYbaitbPg?=
 =?us-ascii?Q?AVFl3vtRg3Pyo+k0eoKg4zisV+a6BGurj71mDjwhGUg4EKpp4lmW748oBgYO?=
 =?us-ascii?Q?hfa5j3e50m9so754M53i9C++vUxUPjx2LyIxd7LHBmkDAdL9/Cyb0r7rwhXE?=
 =?us-ascii?Q?bg6Ni8OQUAP4+gbnoipn2KCfIyCZxR/ndgYbwuoCs56My/MfmGk1xWwhdxHY?=
 =?us-ascii?Q?dQFC9v2I1A0KrVwG2gBtc4/1uFIVWaNViMMv2aeZQq0Dp8H1WVMJJD0TMg20?=
 =?us-ascii?Q?Hivb/R5Pnd5waaY44NFX/519O0A4ZpUutRhEbrDPkPA+V/QzY6r3aLkQdzNo?=
 =?us-ascii?Q?lF6M5kA0L5B3aE2Y292btNKls8zOGD74nDqtF44P6V/2gCvHwwOL24BWiX/J?=
 =?us-ascii?Q?h+V4Mf5TqHOrDfC/sadrRWqQArvYpu0VSlaLwUj2BpJ6EQJWuNTyCuDqdqs6?=
 =?us-ascii?Q?0nphqHJj7uJTtxOlzOCq3A2DyvvQoTCgH3Vrzj4d52uRYrb0zxiuO3M/kpSW?=
 =?us-ascii?Q?MdLnl+Ys5Y1x64EbxLgauGXwM2ei+CihFcXsYdLIzVQjYBnj4OE5wBbFs8/8?=
 =?us-ascii?Q?MYMoW0Q7vwDfnXXj8LCw/Ah9r32UQg5TPyfjjh2H3b4813x3V9yZXhFnZrZ2?=
 =?us-ascii?Q?O3iHQcgpRykCGB4544AdiQfoKr2QwuffP8v107EWYYaWgjpiZw2soxe43KHI?=
 =?us-ascii?Q?REot1j+gI0xXT9eMlVCur+7c+eeU3iiutBymhjJrrIkik2uyaAZByZPmblRc?=
 =?us-ascii?Q?t5RJSTN21TklEy1gFuk+yk3YW1d7o8MjoNdl7/VWkbyAvkt2a3c4Qf1fyNZz?=
 =?us-ascii?Q?PNR8Id+p5IfqSfoTyyszfZpsmlNLeN3SRtRm3mc3gk8JiVgNDUM2W1bhJz/r?=
 =?us-ascii?Q?th0oFJengnFu66AxtAZj/q7TDJ1dFXXYytx/VtUqHXJ0Z4hoGdHSSswa6hWJ?=
 =?us-ascii?Q?iu4No4njNZiqNcW+/a+5/ivIe6vL6RFFwkhsZw6qT7VTT5y2KIqnBnWzfExd?=
 =?us-ascii?Q?GzDZ+yCNCtwqwrIWO0+6ouu3IrpdBOfXJ5G1uKyYo2t5oh62jzv3qO1WKFmI?=
 =?us-ascii?Q?7tw6Qgxo/rVBO552A9Iw97JQdPudDI9Ny4LbkppnnRmgND2obnS+tL0njb+V?=
 =?us-ascii?Q?13H2rdy8GYEv6vRvAnKw4p2p5urJzljeb00gLbmmIjn3xa6Pr6TJjpZH+0X7?=
 =?us-ascii?Q?hgAcfU631XMb0ywNVqDFPQvWZkK9+3mc/nQkCh4IxWOfFZAnXwRn9jshRkah?=
 =?us-ascii?Q?+retGSgn13zpU7CtS93BKVZBEP3y6C9AShIQsDcxxOwEgxM9xHqRuxRVecJl?=
 =?us-ascii?Q?BBmTBjm+qYrU9/roILutmGeDNE5X7W1EYCgIEVewPZntnTpWhn0VoOTqqZiH?=
 =?us-ascii?Q?K8nlW+/MXu2gDRZA2kSmYZyyjMzgij0gIav3nwZZXulx+D48n97LdRsFxj7k?=
 =?us-ascii?Q?VzoN/Fwl+A84ujlWuuyFhxz/DL+OZVBKhMV+uOVVLNiY9U8VYxoJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1805f44f-7a55-4c3e-6b3d-08df40d44eea
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 15:47:51.2446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BjrJAdPx5qlm8x5MPwNMeliGsZBAZa5/fzXoYBOcU+aqP1NHGNXm/1aHByeYomIvUuYydaFF64M8sYn4OBF79ctVvmISQkUxYT3QcQBkknmMrR8LUM2XRkZMFnvW3N3z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA4PR04MB786416

On Thu, Nov 12, 2026 at 03:53:05PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> DMA channel devices are currently created as class devices without a bus.
> This works for sysfs, but it prevents per-channel DMA/IOMMU configuration:
> of_dma_configure() only probes the IOMMU when dev->bus is set, and the
> IOMMU core only installs probe/release notifiers for buses listed in
> iommu_buses[].
>
> Drivers that need per-channel IOMMU support currently work around this by
> assigning dev->bus after device_register(). That leaves the bus subsystem
> reference count unbalanced because bus_add_device() already ran with a NULL
> bus, and bus_remove_device() will later drop a reference that was never
> taken. For example, tegra186-gpc-dma.c assigns chdev->bus after channel
> registration. Review noted that this can underflow the platform bus
> reference count and lead to a use-after-free when the device is removed.
>
> Add a dedicated bus for DMA channel devices and register it during
> dmaengine initialisation. Use core_initcall so the bus exists before any
> IOMMU driver can call iommu_device_register(), which iterates iommu_buses[]
> and fails on an unregistered bus. The match callback always reports no
> match, so no driver can bind to these devices. A follow-up patch will
> register the channel devices on this bus.
>
> Clean up the unmap pools if dmaengine initialisation fails after they have
> been allocated.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/dmaengine.c   | 28 +++++++++++++++++++++++++---
>  include/linux/dmaengine.h |  4 ++++
>  2 files changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 34be53487a21..e1022d297674 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -1643,6 +1643,17 @@ void dma_run_dependencies(struct dma_async_tx_descriptor *tx)
>  }
>  EXPORT_SYMBOL_GPL(dma_run_dependencies);
>
> +static int dma_chan_bus_match(struct device *dev,
> +			      const struct device_driver *drv)
> +{
> +	return 0;
> +}
> +
> +const struct bus_type dmaengine_chan_bus_type = {
> +	.name  = "dmaengine-chan",
> +	.match = dma_chan_bus_match,
> +};
> +
>  static int __init dma_bus_init(void)
>  {
>  	int err = dmaengine_init_unmap_pool();
> @@ -1650,10 +1661,21 @@ static int __init dma_bus_init(void)
>  	if (err)
>  		return err;
>
> +	err = bus_register(&dmaengine_chan_bus_type);
> +	if (err)
> +		goto err_destroy_unmap_pool;
> +
>  	err = class_register(&dma_devclass);
> -	if (!err)
> -		dmaengine_debugfs_init();
> +	if (err)
> +		goto err_unregister_bus;
>
> +	dmaengine_debugfs_init();
> +	return 0;
> +
> +err_unregister_bus:
> +	bus_unregister(&dmaengine_chan_bus_type);
> +err_destroy_unmap_pool:
> +	dmaengine_destroy_unmap_pool();
>  	return err;
>  }
> -arch_initcall(dma_bus_init);
> +core_initcall(dma_bus_init);
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 805668fbe437..be9308739676 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -412,6 +412,10 @@ struct dma_chan_dev {
>  	bool chan_dma_dev;
>  };
>
> +#ifdef CONFIG_DMA_ENGINE
> +extern const struct bus_type dmaengine_chan_bus_type;
> +#endif
> +
>  /**
>   * enum dma_slave_buswidth - defines bus width of the DMA slave
>   * device, source or target buses
>
> --
> 2.34.1
>
