Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794848332;
	b=1J+lLpW5C2Hlq6NYLzFDEO3FbYvBqaEDUuC73pWhH0f5r7s/q8IyJNud2nknFcpiJaiX
	 YwCAQ9xUOdw1X1QuElw5gWFTlJzsr59o6RkPQcEi6x5Gqn6wwnqr4hvSn+arxnO4QwR5r
	 jix2aBaUAdYAY2kaOpksqibuJ5it432bmGF8qsFf0vCB1M2qc9nyZC5ecTC84/SoIZCvm
	 /37i8aXeeHcqXmIxKRzpvjblvsFMY7ELncQJ/qe8jvHapYH/xesImj/tZSXRbMTCP7UjS
	 WNH4IskxsrkS/f4dPnO7V4cuzZg6a4upohvH81enEJG0n7EPUpHvdYNqcMxaCo9rN0g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794848332;
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
	bh=G54De4wsbNoeSUYudftg0vTZgXX7M4oYN4N+raAIIuw=;
	b=IHE4pbZTKBz8ZTHWC5h+wBIBLFC4CPMftlHGqwV3agPNQhq2bXMsvuJvgrJFbXYccyDJ
	 w42FmO061TD6yND2PGUs2npmqr+tnix+n7eZF2/FOvxQyi3riZofRAajjgQ3WAIlUgdUK
	 6gQjsKhGniz/IePLTQoxwe3BmtwS2h+2a/CDIANU2OEPUeyF1an+HlcedCjAiPFSB3U8h
	 QI8ZSqs5Mk1KhkaGEtGtlrVaVuy9yLOnhYwkltZHCShJ1fCvpao1CVQw6+57yKxh6Ez2A
	 HgakS9sLcjrU/Lq1qGpl5K9GAjbTsAuBrRYV11tlItYUlC95aBT3PUJP+BGnh6+nq0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=jVC76APZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.10
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013010.outbound.protection.outlook.com [40.107.159.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD94D606A322;
	Mon, 16 Nov 2026 16:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD94D606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=jVC76APZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=El1hNJpIFWTw5jm3k17dlW6DVtCac+udLzLQtpjSK7ziFP7Bat3OGnHbzj/6EViRt3s8U3C3m5TjLRtDqCFcJUbS4TrGFMwq5dC1Bhx4w5i2+Gl8BxAoPC0tgd/MckRugx6UO9KvPDsLCzdjHFiR08fQ22I1R+Z61J3/qV7bWNeYnOwP5zgudhKXldkr74DJYK5m3O2Avf8jJK0FXU1A5TNJKtZU6MrohmJ7QAV5s7pAAWssPrdqlRv+nW84pmZKY0rfA1tmHqCdM+RdAWLscUK7KFTPs/YMbVwsQuyoBrlcojSloUaNe+K92jyXJ/eLmGvtrJclCkSjVekBH0Mi7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G54De4wsbNoeSUYudftg0vTZgXX7M4oYN4N+raAIIuw=;
 b=xB10AI2OJE4VszqA5M4WZF5mHh0tuJgjNkG6X+GM6sJh1GBA1T2eM03g5Pv1utiQGRiGSZxSJns1bJ57+7M6YCC3vPvxaG+HNBsGjunSXLpHReSFH2N6coFsPmwAfX9LOqHSsu1sT4leuyXw1476M0tsx+hdy0pWmHPCdJgOadg7jlzyTOEBtW9KwMTVCuNwxD6ENBzNpXz71SOHRi6ccwdZdjpKVTdIzzip93W/MLDZhrQsbT3j9U7GREDP4QQy7jQY+n7MJRkJicTR/aA4PMSP7oBWo45DtXH28OIcSdpxe5nDCnnobCK5ZjBh/ltBU1mjB6IF0m5ry2PeVgYHrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G54De4wsbNoeSUYudftg0vTZgXX7M4oYN4N+raAIIuw=;
 b=jVC76APZw0S9qmYenLd2q3PZKVUf8UEcHyuM8UdneHRrjuxjnFvg3Nl8EiNLosyAg1X0Qhy65VAz3IU02uA6utarbxu9HMXeMMJYsIrQC21kB170f89y+y4iHzplSWracQA7rfOe4mZ/AG4BuOVtUWfFEoP2R7mHiW9cqM72lw+B6hMgkbCpeN/kGENiFvfYKVRV6dcNTY+LDRthyH6Qk16MCFtKrw+ClWbll7psSl6YHADJ6Xb6TvaHfhb0Bju9mgzC/Y5o89+QR3oQWWa0lH67DBdF41xdcj42Nsu+FRcSYKfYKp/qN2q2iWcj2TJy+XUcizqdUCMVCSKmAKVH1Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PAXPR04MB8557.eurprd04.prod.outlook.com (2603:10a6:102:214::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Mon, 16 Nov
 2026 16:58:48 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 16:58:48 +0000
Date: Mon, 16 Nov 2026 10:58:35 -0600
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
Subject: Re: [PATCH v7 8/9] dmaengine: fsl-edma: support per-channel DT child
 nodes
Message-ID: <avs2OzSVJOtTk_ot@SMW015318>
References: <20261116-edma-iommu-v3-v7-0-32794ba8efbf@nxp.com>
 <20261116-edma-iommu-v3-v7-8-32794ba8efbf@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116-edma-iommu-v3-v7-8-32794ba8efbf@nxp.com>
X-ClientProxiedBy: PH8PR02CA0012.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::24) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PAXPR04MB8557:EE_
X-MS-Office365-Filtering-Correlation-Id: f204eea3-35d0-4f6c-8e81-08df4402e1d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|23010399003|366016|1800799024|18002099003|22082099003|6133799003|4143699003|11063799006|56012099006|10067099003|261026140227099003|261026121527099003|261022105027099003|261028144727099003|261022075727099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	pU5g/7arPSvG9OdseFxqJL/jPM4f6zCVOCnY1pJzJwTwczvSPvWl8nbYBCheZeZ+1s028lvTE6jQUbNFHgYIlMZSa2uQ28/30aGz/dqKZhLbleBkLa6GambAwddLfm5OK+ijq2brgYQDhjnuSwu3NwIBQiPi3H7UKpJ86xP/eLO88Dv21/RSuct5v8/I/3xQ8YCrwjFjrKuKDuEPELo3P1oauFPnWqZoNojrYgCU/TFs8R58jJ6g8Iif+aFa5jq738BLZ/coGrqtoYIlwuSa3ej/aScVVmHJ9otp+4eABGq+kepJsSo1OyGxXaObEuVm2aBzB1WfoQf3o9wx+ldzcMgvvTIBbCYkdEVorbiX4xoH05uEpiqJYTPHl7pG2xz2MaV4qp5UkxNFO7a5BYXX0sc3ZlxLySwXdI2wa7cy2DtaJduCq6mu0qM3UVIj3Mko2gFSuaG+WhSXO1RRtI+fS5ZTUeYY04uq90/lMQhl8MV6deM7ETUL3jMexvfJDYu5hfjmT6xaeBKLTDIWT4NUgkB10OLiqmmb/0gVCY2zWd4NFuEHOAehWEmm/sedULSvEKLzeONkf2PZFSQY78JGYtABb9Wn5vAVkzTBrbhszbIFzwGm9+pqqY4afZ12it5KCypOekuCNc9JCrpzEcVOBuJgVPyBg3PhQZ/9GojxXMc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(6133799003)(4143699003)(11063799006)(56012099006)(10067099003)(261026140227099003)(261026121527099003)(261022105027099003)(261028144727099003)(261022075727099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GbAM0cLZ0BMcTuXKTm3FiScrj9cDc9Ajlj+O4isO3/yJDKAmA8Ufq9IC193k?=
 =?us-ascii?Q?+XWuJbXLcDZuGV3VlpDed77WeY6Af3bHUAyzC79Z7Df6Gv27+yaISgg3tr1k?=
 =?us-ascii?Q?opocLL46raoCEtbXUiDsJrfivIITVQAmLwXW3KZnzgHgpGP/O5GnWJI63H8Q?=
 =?us-ascii?Q?OV0xhtPsEU24J39NaFdUQErhGst9Byi1JPD9AkweDqI1UR3m9QnZpRUOgLf3?=
 =?us-ascii?Q?l2I7Qy7cyyQwtn3Iiou3v9nfmXW0dIE5wunIsjfasJTOjlKXHfqHGmJOM3kM?=
 =?us-ascii?Q?JWWLUEHcgYAjZgRwpP4gT4PZHl2eYC7Me5y9tB2w8ec7+3bPU5D8W8gHyt2r?=
 =?us-ascii?Q?vqqOxfh3Q6nVFLMCKqbilg5vhiTgIdzmFXkxltpJ3O12kM9kxTq7ddo98UpX?=
 =?us-ascii?Q?ZufWGt2dM+mIXCClvr+AhWUySM+leEIz8tKfRT3RUNDr9qVrsR4pL5HSnQ7a?=
 =?us-ascii?Q?jZ3CqSQnGixPGXO2I98YSaP4x48CRvFNliYUk9LZedN3iDjifG6E4N6yNMVC?=
 =?us-ascii?Q?cBmil7et7mfbvoRbWeBRNknUaTXSiAKoTOjCyONPr9E8WnO2dWAYSsxEourY?=
 =?us-ascii?Q?x4UVLe3kaYtNQBDEIVy5HEr53txYYlOUd1rEMNGt0y9QAve5LzuW9MPBF0g7?=
 =?us-ascii?Q?C+ltvXYB4LJCJYRBBd3iEpA7Eh8UAi17GICdIN/93ChM3AXF6FAgu6twh6HX?=
 =?us-ascii?Q?BbR9mDbJG8pHeanXpAyd3RNMY1Og1wEdd4ma6GES6j3T0nytVNjpgPv/NyfM?=
 =?us-ascii?Q?xMT3h7hJkhgjnlCFZNfJV9lojY/Dqm3NbjXKM3l4G7fM7jd1L0q43s2SnAc2?=
 =?us-ascii?Q?fSNKm3WztyHwJcXyOGy1Nz6i+Xslr6ObiPS7ZH78AO0Gx4i3TkcCUCm2b8G7?=
 =?us-ascii?Q?nzEcSvT6qEo8TatAuXTw6PtMQeV21R+el1aaiLuGcktdgdK83IDoGu3zrEy8?=
 =?us-ascii?Q?WpDSJFHOi+ABVHFeXjATMlCwuyiKegDGOclslQk92VWekB4TAmOEzeEUrObK?=
 =?us-ascii?Q?NzBhVPxDUZ1zH6P0nqswzGB8EVTwqjw5wp7yQPD71CWtp/aZIyxhhou4d4aU?=
 =?us-ascii?Q?8Xt3ywcg70/33cPB+mGBBbuMGc0zWvOvAllfRjFCHuAKRfEYtdLE/tAjl5BD?=
 =?us-ascii?Q?PxEoVb743/+NXI34lAp4ejhgggy7N0pVeRVzUSYTL6Xi8MgxZGN1vI9NYUEY?=
 =?us-ascii?Q?PomAUgIW28gu0dso9gdV3IXd5ZjyO6G5FSKgjjaNCp6X2IksGZ4LJpOQVpqh?=
 =?us-ascii?Q?zrEdE3LrMCCizHUU4SB1su6XdkzmXxPStLUNU+M/gjzTPt4HYr9b0AU/Dy09?=
 =?us-ascii?Q?wUD3eJlvFwXlNeaO3Ohk1b04YQjXttztKhDMOJd3NDQ31+XCKJi1emX506XF?=
 =?us-ascii?Q?6nkL2++T2VeMu+YgJAaWGgobhMZYfu3+BBp1kEJbSvhZAcW3flhJmeRFRFiA?=
 =?us-ascii?Q?2CiGSOSrHjBABQXXVgRpfQDu00GmIspDRYLa2SzBwFfq59D/QLhV2kJn4XAB?=
 =?us-ascii?Q?UU89ucnIBHcFi43PG+lsE0PEotWRRZV/V4KspgNkI532Rr1GQ7HqRw580ie8?=
 =?us-ascii?Q?vlfI64C0Hf145UCg5LtswEsAYxzs1vYivC37ZXzeSm+DiEhy4C6I7PBrUe2M?=
 =?us-ascii?Q?lk0rpNv24j/xHES5/T6TnhdFT5Nex+x5qemmsqPkmUoLme1siasQ9FI6xP1E?=
 =?us-ascii?Q?OLKKymRhggueyxLuwYSnXamTkHkWqr3KJdDcoAwkzrDUdxkRK/TaFku2KFbp?=
 =?us-ascii?Q?IODkMKud+5G4t/Xk7xrxpDno6rieYPzHnoNYT0lHAZ4pS7knjG1j?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f204eea3-35d0-4f6c-8e81-08df4402e1d2
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 16:58:48.1443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYTuzSSVMCGVEwQe8lHet3C3A8u0+LZc5gNby8yBqaeNHe5fAWNYlyzjjXbUmJ68mDAvHBn9KKgW8z8pVEatFBd1FcR9DUVjvmC3oXa3MGl6WCnT3v7Gk5LGF5g6a8gF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8557

On Mon, Nov 16, 2026 at 11:05:29AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> Add support for parsing per-channel child nodes from devicetree.
> Each child node can carry its own interrupts and iommus properties.
> Child power-domains are not handled here; power domains remain attached
> at the parent level.
>
> The implementation is split into two functions:
>
> - fsl_edma_child_to_chan_id()
> - fsl_edma_configure_chan_from_dt()
>
> The per-channel IRQ and IOMMU setup are handled in a single child-node pass
> after the channel devices have been registered.
>
> Child nodes beyond the configured dma-channels are ignored, which allows
> boards to reduce dma-channels without disabling every unused child node.
> If child nodes are present, every unmasked channel must have a child node
> with a valid interrupt; otherwise probe fails with an error asking for
> dma-channel-mask.  In child-node mode fsl_edma3_irq_init() does not fall
> back to the parent's flat interrupt array.
>
> The shared error IRQ remains a parent-node interrupt.  A child-node-only
> DTS without that entry simply has no shared error IRQ.
>
> Existing DTS without child nodes continues to work unchanged.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/fsl-edma-common.h |   1 +
>  drivers/dma/fsl-edma-main.c   | 159 +++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 150 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
> index cbb077e98f55..8843dd5661fb 100644
> --- a/drivers/dma/fsl-edma-common.h
> +++ b/drivers/dma/fsl-edma-common.h
> @@ -271,6 +271,7 @@ struct fsl_edma_engine {
>  	int			txirq_16_31;
>  	int			errirq;
>  	bool			big_endian;
> +	bool			per_chan_irqs;
>  	struct edma_regs	regs;
>  	u64			chan_masked;
>  	struct fsl_edma_chan	chans[] __counted_by(n_chans);
> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index 818b9b986f13..541f1294973a 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -12,11 +12,15 @@
>
>  #include <dt-bindings/dma/fsl-edma.h>
>  #include <linux/bitfield.h>
> +#include <linux/math64.h>
>  #include <linux/module.h>
>  #include <linux/interrupt.h>
>  #include <linux/clk.h>
>  #include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
>  #include <linux/of_dma.h>
> +#include <linux/of_irq.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pm_domain.h>
> @@ -400,12 +404,21 @@ static int fsl_edma3_irq_init(struct platform_device *pdev, struct fsl_edma_engi
>  		if (fsl_edma->chan_masked & BIT_ULL(i))
>  			continue;
>
> -		/* request channel irq */
> -		fsl_chan->txirq = platform_get_irq(pdev, i);
> -		if (fsl_chan->txirq < 0)
> -			return  -EINVAL;
> +		if (fsl_chan->txirq <= 0) {
> +			/*
> +			 * In child-node mode, missing child nodes are rejected
> +			 * by fsl_edma_configure_chan_from_dt(); do not fall
> +			 * back to the parent's flat interrupt array.
> +			 */
> +			if (fsl_edma->per_chan_irqs)
> +				continue;
>
> -		fsl_chan->irq_handler = fsl_edma3_tx_handler;
> +			fsl_chan->txirq = platform_get_irq(pdev, i);
> +			if (fsl_chan->txirq < 0)
> +				return fsl_chan->txirq;
> +
> +			fsl_chan->irq_handler = fsl_edma3_tx_handler;
> +		}
>
>  		if (!(fsl_edma->drvdata->flags & FSL_EDMA_DRV_ERRIRQ_SHARE)) {
>  			fsl_chan->errirq = fsl_chan->txirq;
> @@ -415,7 +428,11 @@ static int fsl_edma3_irq_init(struct platform_device *pdev, struct fsl_edma_engi
>
>  	/* All channel err use one irq number */
>  	if (fsl_edma->drvdata->flags & FSL_EDMA_DRV_ERRIRQ_SHARE) {
> -		/* last one is error irq */
> +		/*
> +		 * The shared error IRQ remains a parent-node interrupt at
> +		 * index n_chans.  A child-node-only DTS without that entry
> +		 * simply has no shared error IRQ.
> +		 */
>  		fsl_edma->errirq = platform_get_irq_optional(pdev, fsl_edma->n_chans);
>  		if (fsl_edma->errirq < 0)
>  			return 0; /* dts miss err irq, treat as no err irq case */
> @@ -703,6 +720,124 @@ static int fsl_edma3_attach_pd(struct platform_device *pdev, struct fsl_edma_eng
>  	return -EINVAL;
>  }
>
> +static int fsl_edma_child_to_chan_id(struct fsl_edma_engine *fsl_edma,
> +				     struct device_node *child,
> +				     struct resource *parent_res)
> +{
> +	const struct fsl_edma_drvdata *drvdata = fsl_edma->drvdata;
> +	struct resource child_res;
> +	u64 offset, ch_id;
> +	u32 rem;
> +	int ret;
> +
> +	ret = of_address_to_resource(child, 0, &child_res);
> +	if (ret)
> +		return ret;
> +
> +	if (!resource_contains(parent_res, &child_res))
> +		return -EINVAL;
> +
> +	if (child_res.start < parent_res->start + drvdata->chreg_off)
> +		return -EINVAL;
> +
> +	offset = child_res.start - parent_res->start - drvdata->chreg_off;
> +	ch_id = div_u64_rem(offset, drvdata->chreg_space_sz, &rem);
> +	if (rem)
> +		return -EINVAL;
> +	if (ch_id > INT_MAX)
> +		return -EINVAL;
> +
> +	return ch_id;
> +}
> +
> +static int fsl_edma_configure_chan_from_dt(struct platform_device *pdev,
> +					   struct fsl_edma_engine *fsl_edma)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct resource parent_res;
> +	u64 child_mask = 0;
> +	u64 missing;
> +	bool has_children = false;
> +	int ret;
> +
> +	ret = of_address_to_resource(np, 0, &parent_res);
> +	if (ret)
> +		return ret;
> +
> +	for_each_available_child_of_node_scoped(np, child) {
> +		struct fsl_edma_chan *fsl_chan;
> +		struct dma_chan *chan;
> +		struct device *chdev;
> +		int ch_id, irq;
> +
> +		has_children = true;
> +
> +		ch_id = fsl_edma_child_to_chan_id(fsl_edma, child,
> +						  &parent_res);
> +		if (ch_id < 0) {
> +			dev_err(&pdev->dev, "invalid channel in %pOFn\n", child);
> +			return -EINVAL;
> +		}
> +
> +		if (ch_id >= fsl_edma->n_chans)
> +			continue;
> +
> +		if (fsl_edma->chan_masked & BIT_ULL(ch_id))
> +			continue;
> +
> +		child_mask |= BIT_ULL(ch_id);
> +
> +		fsl_chan = &fsl_edma->chans[ch_id];
> +
> +		irq = of_irq_get(child, 0);
> +		if (irq <= 0)
> +			return dev_err_probe(&pdev->dev, irq ? irq : -EINVAL,
> +					     "channel %d child node has no valid interrupt; add interrupts or disable it with dma-channel-mask\n",
> +					     ch_id);
> +
> +		fsl_chan->txirq = irq;
> +		fsl_chan->irq_handler = fsl_edma3_tx_handler;
> +
> +		if (!of_property_present(child, "iommus"))
> +			continue;
> +
> +		chan = &fsl_chan->vchan.chan;
> +		chdev = dmaengine_chan_dev(chan);
> +		chdev->dma_parms = pdev->dev.dma_parms;
> +		if (fsl_edma->drvdata->flags & FSL_EDMA_DRV_TCD64)
> +			dma_coerce_mask_and_coherent(chdev, DMA_BIT_MASK(64));
> +		else
> +			dma_coerce_mask_and_coherent(chdev, DMA_BIT_MASK(32));
> +
> +		ret = of_dma_configure(chdev, child, true);
> +		if (ret)
> +			return dev_err_probe(&pdev->dev, ret,
> +					     "IOMMU config failed for channel %d\n",
> +					     ch_id);
> +
> +		if (!device_iommu_mapped(chdev))
> +			return dev_err_probe(&pdev->dev, -ENODEV,
> +					     "channel %d is not behind an IOMMU\n",
> +					     ch_id);
> +
> +		chan->chan_dev->chan_dma_dev = true;
> +	}
> +
> +	if (!has_children)
> +		return 0;
> +
> +	fsl_edma->per_chan_irqs = true;
> +
> +	missing = ~(fsl_edma->chan_masked | child_mask) &
> +		  GENMASK_ULL(fsl_edma->n_chans - 1, 0);
> +	if (missing)
> +		return dev_err_probe(&pdev->dev, -EINVAL,
> +				     "channel %u has no dma-channel child node; add one or disable it with dma-channel-mask\n",
> +				     __ffs64(missing));
> +
> +	return 0;
> +}
> +
>  static int fsl_edma_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> @@ -835,10 +970,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
>  			clk_disable_unprepare(fsl_chan->clk);
>  	}
>
> -	ret = fsl_edma->drvdata->setup_irq(pdev, fsl_edma);
> -	if (ret)
> -		return ret;
> -
>  	dma_cap_set(DMA_PRIVATE, fsl_edma->dma_dev.cap_mask);
>  	dma_cap_set(DMA_SLAVE, fsl_edma->dma_dev.cap_mask);
>  	dma_cap_set(DMA_CYCLIC, fsl_edma->dma_dev.cap_mask);
> @@ -897,6 +1028,14 @@ static int fsl_edma_probe(struct platform_device *pdev)
>  		return dev_err_probe(&pdev->dev, ret,
>  				     "Can't register Freescale eDMA engine.\n");
>
> +	ret = fsl_edma_configure_chan_from_dt(pdev, fsl_edma);
> +	if (ret)
> +		return ret;
> +
> +	ret = fsl_edma->drvdata->setup_irq(pdev, fsl_edma);
> +	if (ret)
> +		return ret;
> +
>  	ret = devm_of_dma_controller_register(&pdev->dev, np,
>  			drvdata->dmamuxs ? fsl_edma_xlate : fsl_edma3_xlate,
>  			fsl_edma);
>
> --
> 2.34.1
>
