Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794419874;
	b=whB2PHdAosP5NJDf64NJdJVy7g0hZsTaKpKiolvNcXdY9Du+drxPRsyiHD7le1VCzTSX
	 e4cj74tVvYKrJBQB0S84wjI9RsTVu+KPzkcMpjEyaeDiSJFZ4y6G+5ZyJCf8NSRnDmgFB
	 /3+Qqdfs5YrvTqkqoV/iSFAe/J7gOIZncgubk4nleiVaSQJZS90PLqeJoLH9Q3gck5bmS
	 TYSbblUcjC8shjUUfW2mMklEr81+HK26FnKtaJDeFzaCEpA+SuxBYW/Q/9K1x1/W4Geax
	 sGM930VQvIQ6zUkND09gAvToGUKNuja4aABhKyMl7M09hxAtPwc897hPKnDaQdXX1Ug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419874;
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
	bh=Bk8QYwzJOoArsGVFFryrLRrKbeVt+TM899ZcT1OWXxw=;
	b=cxd/Ly5MBTi40Mstc3WUFpE0eL+AhadUL+XlClcxbzRhyyPGPAmoSyZnC/UUeW9PqnAQ
	 hD5GGsbGdThcP8xqh0Af1VGzlIEcFG2cB2gq/PmEsHRjeo824xfPbLaJ3+HA5PztV/oj9
	 1Co3Cc2v63gbdHGoTqy2ivjyRLQoFtaWMEnUuLywXhWET1DI8pDGm71x+1/QdaZ+jPkIb
	 jl5fhZ85yQv2bB+eaNLL7po1qeAjH1swydl2E3OLU1rjb+7PNQlilWrf+WrS4iaWEOYYQ
	 asv2aHP8ccSGErD/9gz3oPVGdgHIDjz4LRiXfXMSlIxRObNQwjAphhC+LifHthzZzpg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=h5UQYuR4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.2
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010002.outbound.protection.outlook.com [52.101.84.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB954606A32A;
	Wed, 11 Nov 2026 17:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB954606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=h5UQYuR4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=axcYEVa6jm7riemql7lvzK1+kPCTYbC9+rHKYZgd8hW2XKHrp6MdaMvf1o1cJIdBHGqVXP3h7KFgKMN7oJsKGGzR+TMJssAs3qavZf4fn2bzgaLRIcQtkMoDhsU8K5FXOJ9C6VLaOX7OGG7ltHIV5XKS22pYBLDISkKpBgI9+vRy6QqT6LANFYpMOZ/3F/BVIdC7rYhI7BiLxx/sJuyxPok1A9Ab0s9yozO0/4+5UGtYnUHgY9eeJZysRJSCyer+JH9HaFT5l5jeVDYbDOPSTytZYb+2KA1lsc/TRYh9XuWQfbQM4mZKGe7ueGsHkAVlrrS027SgfSBcQZ/jAiN0mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bk8QYwzJOoArsGVFFryrLRrKbeVt+TM899ZcT1OWXxw=;
 b=lEk6B3N01J2XacBzS/h6sUAXXyyr3j5Wrsf7WIO/5f8Od7CnqRn2zu7Plqkuelr9ME3zL7E+KhXv3iAcTb6/9wK0qaQ+BFPop0V/q1eTHRJQRenDz8so3bQpYrIr0P34vOUCuHLEUXUVnCDsvEEUBUIO/Ph8GA5YaK27gdge9iHdCIO71S5krjxk6Fxqb5oeyRF9prxzHeLG7b6XqZu6HMsPbyDQWX5Quy/IzQ48CQAr0Azl4uWeNjCH6X6aWGvy8pei0Sdv1SbnIWXn8PcvwujCRanafUU5IW/SBmtvVD2kfAUIqX9hliK6QVDVpqvv+IOM/sIO5yk4ULMHKowU8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bk8QYwzJOoArsGVFFryrLRrKbeVt+TM899ZcT1OWXxw=;
 b=h5UQYuR4kIvx/vihcA4N12LiGCV51pBiTloWyL62lmPk0J+1/LARHT6DuswelrQL+3eEMhDoD4aFi3XPB1HiPjrTH3/52ZPy9HuREgoglSM2sXV4mKisCiBGIpNlrHKXUtTJMldtQlXV+gUlfagjzrFW+L8gak8xKathh57f3YkC0MqKV1MjVIvhCqBsksVOb48bKh88XJTHm3dB65yRzrIn+j+h/VsTLRLGNp/S3lOITHcY1nVYCsWnAd49VilXPtVNdB4akOZwSvtgLmpHgSGijfbVtzLJCcogpLWHeJ01240t5JK4BvMO0WDrqlAssBHgw5bKexFv9MJ3fzrceA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GV1PR04MB10632.eurprd04.prod.outlook.com (2603:10a6:150:206::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 17:57:47 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 17:57:47 +0000
Date: Wed, 11 Nov 2026 11:57:35 -0600
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
Subject: Re: [PATCH v5 6/7] dmaengine: fsl-edma: support per-channel DT child
 nodes
Message-ID: <avSsj0Ho_n6DL36_@SMW015318>
References: <20261111-edma-iommu-v3-v5-0-2537cebe6ca2@nxp.com>
 <20261111-edma-iommu-v3-v5-6-2537cebe6ca2@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111-edma-iommu-v3-v5-6-2537cebe6ca2@nxp.com>
X-ClientProxiedBy: DS7P220CA0125.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:25f::12) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GV1PR04MB10632:EE_
X-MS-Office365-Filtering-Correlation-Id: f538b365-edbf-47a1-6465-08df401d4b81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|376014|23010399003|1800799024|18002099003|22082099003|6133799003|261009223027099003|4143699003|11063799006|56012099006|10067099003|261028144727099003|261022105027099003|261102123227099003|261021121427099003|261026121527099003|261022075727099003|261021123027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	CqzJc2s0gOQNTK7/pKTh7Fv/xAf0ZTduSLbppZ8un3GpKKP9C3LOCxyDutaThqQ2XgkmlIIcq+nq1CfIQB4Mz1vIxLbBfcnigw3gxKyrC96vLMQG+QAAtwVkIcGcXhVvRlnQRa77HrIjoBQqcv3Udkv+Uy22PQYl0lV3HjThpYZRxkHlIj9ITVaPwjYZS52UP6ysQBSZClBFvmUhHzOxyFkyrgWiP2Ypfs6V1jPJBVexNRRzlIs6iHnfRDIJB2ssZc+DnhB1SJL6T1CXAcZJWBQwdSXsivNDhlsKqLQphiRiiTgt7AVXvpncliikglIqHBWyEo9sEOT+tVkj6xzFVX9l6z5QZwtvjEmaSb1U+AKqqllBgNy5RDYHFv2uZe3NQKAFu+Z8+p2ADz4IdrmVpsg3yRU3sbu+PxdHrUc/jXaNjDkaNrFyXrRA45MshYIhiEUuwZ7xhVFOSA4+etqAlkkpw+kNLyAyrFs4sFhQ+atC1zJ2vavGC2Ek6GQY2WXGoHndmskYyzNNMHlDdS7+zmhrPoLQFzhqZFiwxwjISOo8Ocak3bFNIfzZz9Zrj/LPwkxfIxv/xP5Im9nCQbe7hGIel1sXeLJzTNv4hnjHxpZLX4VMiVqZEe5leCBpP40b+5TQJc8V5zkMnc3rSRJhCNFwS1SYquvGN+trDdZ4Yo0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(6133799003)(261009223027099003)(4143699003)(11063799006)(56012099006)(10067099003)(261028144727099003)(261022105027099003)(261102123227099003)(261021121427099003)(261026121527099003)(261022075727099003)(261021123027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bj3JLplEziaGBeda5L9/U9HmedLvzaJydLYbLYBoSg9vMwXKjGfEVdjpQce6?=
 =?us-ascii?Q?pvdUsb8KXm5FI/NFCo1fJkkxom9jXjHSyNAFGFh5l4TJHWiOmk6uORTL7ooE?=
 =?us-ascii?Q?mpQE8UTr1KfXzNPqVXORY+5+lYNsMFnkw1kOU++CkfUsd7BCe7hBpPIub8AT?=
 =?us-ascii?Q?dTCkUTZULiWZNsm1hg4bGN7L5eMLUgKNi4gxclVVQpPA1KgzVkune7yEpLDh?=
 =?us-ascii?Q?E8u1SQy5x5gyBxEIX59hzRXFlEHlCclhNTfGO99Txq1N4rwmwsTjLfFMGXX5?=
 =?us-ascii?Q?dcNOwgLdFJSY1QdNMotlqbMwwE8TM5e8i6abSNMwP7x+Mxi+vyeHDUrlY7+M?=
 =?us-ascii?Q?aRCv4zgBo4l5QlM05JuJuODeXPntezciqTxAE/FeKxzyQN6zcxFZ4KenrAqR?=
 =?us-ascii?Q?lEswDV9l607n2bqxV/KR3g/nYqXlE7n0mXgqW7CeN7v4QSsc/AbvOU44pM3P?=
 =?us-ascii?Q?PtrptgSQxtxvTieutPZ3FhJB2V576aeMY+tlcLXMMIxd4k0hyIGgxjHkZ7XT?=
 =?us-ascii?Q?PV7A0eW+laDOhVroxhRz6oipZaFR4toou5QVqmEFI3AECoEUs36+k0n+4pMt?=
 =?us-ascii?Q?6ZZZLHRFS2Krm7figrNccwZJ4IkML/3Sxpygb/WWo6mv1jTHVNfVkbGHWF/f?=
 =?us-ascii?Q?7Sxi+tzCyCPUAgCBS2vvdYi7HByd2QI6UnMN8nlF5Ft1MI/PCxyshM4PPS0T?=
 =?us-ascii?Q?Wj6+3S2qloGJvbMShQuoGBFJfxccvxxIBNa3uppMIyMpur3VpfxTV0UaW9wB?=
 =?us-ascii?Q?g33OzWjTHpjhkpbHR2xdDXmakgtXUSaigCqE19RC1j7cW4/FdDKWUWPJIjpw?=
 =?us-ascii?Q?8H+dewIIpgsHfK14R7OOlL7dcxTRKPGFDhLZRihLpKAjHGbVo1ifKsbuwMPT?=
 =?us-ascii?Q?n8xqtrXRXhtFhilKRJrrq5lmfTsPjjLbQj18Q9K6irhDStlPYh4OLlu1Vvx5?=
 =?us-ascii?Q?8XhQ0msvE6qCnkBpiEyBKrgdSYmSklp8jk1sWoNRAooZGCGZYcXmBOfqTvia?=
 =?us-ascii?Q?1ioRz19ome6e/ZGNiRsJnPRFlSh7diC8zxXF8f1nNeGUIB4OnKENLbFLamOf?=
 =?us-ascii?Q?PqXLXBcvVnVQXa+9QzpruFgrGs9ich9YRXZ5vWKcMrtO0gd5YpYC/734eo3h?=
 =?us-ascii?Q?wI3W1QYOGfAIchA1oIpaboQlBUm2OMstkYzuQ/fPi3yoVFqhOxtAppq82p9/?=
 =?us-ascii?Q?miHl/GFPi/U3EHTQg28rfL1/NSR7ZM4Nf665OrdrdLsr+ttK68xPMGCL3RA6?=
 =?us-ascii?Q?h2TejAz3Wmdn/cfn5bvhOz3R2VZwwDFY8o+X5ToTQeJCaWTLHuqxplybY4iE?=
 =?us-ascii?Q?JVRVXWiRD+mAHquLprrd55MWSUOdmc3mX7nLoq7Aa+ms6IvHaZr7tnC+p+jr?=
 =?us-ascii?Q?GpJJAOM1X723dM6sLIsO2LVDQbhDq50iCVoLdjRR3NrtkLKNEvnwhyubdCGR?=
 =?us-ascii?Q?tZIcc6FWo+/0vRc/Rv1A9J9mtsKCjprmrBRvIn5p1qvRMipKhiPLXIj9jtsi?=
 =?us-ascii?Q?Md/sjiXCzfZXOC0utPNZzx/jQVTBVB8Az6yFbY7+pi/QeS/B2p8ye2Uq+2vb?=
 =?us-ascii?Q?5delRqLsA+4jxElM/SRudYu0vs71mjyhBdIoOtZNAURSYDss0VBlkA9km40a?=
 =?us-ascii?Q?AJW3GgYhvoEGSJ3JlLV02h9k3U/NcT5PL2+OoI8f/pjcXEDlXJA/kFgoGx7+?=
 =?us-ascii?Q?OY0iwqSWXR2GaNtI4UxRU+MgHPuhlCkVzCuDKXMaRj2dY9DRAYUkqJBBk7bP?=
 =?us-ascii?Q?Qt/Ze/Ck/3hO4+FO7mwXau3hyFLRred7tnHu5pWXm7g0ZSntrkzX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f538b365-edbf-47a1-6465-08df401d4b81
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 17:57:47.6736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fu7BZ4u6+MNSDjeAQV+SMA58gV1+Zs1vS+mc2MYjGOrYgWvSRh+vpyNvFXcMol6Xdpiv6keLpLtq1m76knNrZIyzuycP2STylRWClrB9D4nie1TXSImbo+LhLG5SoSvc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10632

On Wed, Nov 11, 2026 at 09:47:34PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> Add support for parsing per-channel child nodes from devicetree.
> Each child node can carry its own interrupts and iommus properties.
> Child power-domains are not handled here; power domains remain attached
> at the parent level.
>
> The implementation is split into three functions:
>
> - fsl_edma_child_to_chan_id(): derives the channel index from the
>   child MMIO address relative to the parent base.  Validate that the
>   child resource is contained in the controller resource and aligned to
>   the channel register spacing, and use div_u64_rem() to compute
>   the quotient and alignment remainder together.
>
> - fsl_edma_configure_chan_from_dt(): called before setup_irq() to
>   populate per-channel txirq from child interrupt properties.
>   fsl_edma3_irq_init() is updated to skip platform_get_irq() for
>   channels that already have an IRQ assigned from their child node.
>
> - fsl_edma_configure_chan_iommu(): called after
>   dmaenginem_async_device_register() to configure per-channel IOMMU
>   by calling of_dma_configure() on each dma_chan_dev and setting
>   chan_dma_dev so dmaengine_get_dma_device() returns the per-channel
>   device.  Propagate the controller dma_parms to the per-channel device
>   so the DMA segment size limit is preserved.

Needn't detail for each funciton.

The implementation is split into three functions:
  - fsl_edma_child_to_chan_id()
  - fsl_edma_configure_chan_from_dt()
  - fsl_edma_configure_chan_iommu()

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
> Use BIT_ULL() for the 64-bit chan_masked bitmap, and use dev_err_probe()
> so -EPROBE_DEFER is not logged as an error.  Reject a channel whose iommus
> property did not result in an IOMMU mapping.
>
> Existing DTS without child nodes continues to work unchanged.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/dma/fsl-edma-common.c |  10 +-
>  drivers/dma/fsl-edma-common.h |   1 +
>  drivers/dma/fsl-edma-main.c   | 229 +++++++++++++++++++++++++++++++++++++++---
>  3 files changed, 222 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index 513b0f4e5be2..62cd60179bc6 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -310,10 +310,10 @@ int fsl_edma_resume(struct dma_chan *chan)
>
>  static void fsl_edma_unprep_slave_dma(struct fsl_edma_chan *fsl_chan)
>  {
> +	struct device *dev = dmaengine_get_dma_device(&fsl_chan->vchan.chan);
> +
>  	if (fsl_chan->dma_dir != DMA_NONE)
> -		dma_unmap_resource(fsl_chan->vchan.chan.device->dev,
> -				   fsl_chan->dma_dev_addr,
> -				   fsl_chan->dma_dev_size,
> +		dma_unmap_resource(dev, fsl_chan->dma_dev_addr, fsl_chan->dma_dev_size,
>  				   fsl_chan->dma_dir, 0);

Use dmaengine_get_dma_device() needs sperate patches.

>  	fsl_chan->dma_dir = DMA_NONE;
>  }
> @@ -321,7 +321,7 @@ static void fsl_edma_unprep_slave_dma(struct fsl_edma_chan *fsl_chan)
>  static bool fsl_edma_prep_slave_dma(struct fsl_edma_chan *fsl_chan,
>  				    enum dma_transfer_direction dir)
>  {
> -	struct device *dev = fsl_chan->vchan.chan.device->dev;
> +	struct device *dev = dmaengine_get_dma_device(&fsl_chan->vchan.chan);
>  	enum dma_data_direction dma_dir;
>  	phys_addr_t addr = 0;
>  	u32 size = 0;
> @@ -1090,7 +1090,7 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
>  	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_CHCLK)
>  		clk_prepare_enable(fsl_chan->clk);
>
> -	fsl_chan->tcd_pool = dma_pool_create("tcd_pool", chan->device->dev,
> +	fsl_chan->tcd_pool = dma_pool_create("tcd_pool", dmaengine_get_dma_device(chan),
>  				fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_TCD64 ?
>  				sizeof(struct fsl_edma_hw_tcd64) : sizeof(struct fsl_edma_hw_tcd),
>  				32, 0);
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
> index 7f82dcb7831d..e9a7592ef076 100644
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
> @@ -123,7 +127,7 @@ static irqreturn_t fsl_edma3_err_handler_shared(int irq, void *dev_id)
>  	unsigned int ch;
>
>  	for (ch = 0; ch < fsl_edma->n_chans; ch++) {
> -		if (fsl_edma->chan_masked & BIT(ch))
> +		if (fsl_edma->chan_masked & BIT_ULL(ch))
>  			continue;
>
>  		fsl_edma3_err_check(&fsl_edma->chans[ch]);
> @@ -397,15 +401,24 @@ static int fsl_edma3_irq_init(struct platform_device *pdev, struct fsl_edma_engi
>
>  		struct fsl_edma_chan *fsl_chan = &fsl_edma->chans[i];
>
> -		if (fsl_edma->chan_masked & BIT(i))
> +		if (fsl_edma->chan_masked & BIT_ULL(i))
>  			continue;


This one need sperate patch to fix it.

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
> @@ -641,7 +658,7 @@ static void fsl_edma3_detach_pd(struct fsl_edma_engine *fsl_edma)
>  	int i;
>
>  	for (i = 0; i < fsl_edma->n_chans; i++) {
> -		if (fsl_edma->chan_masked & BIT(i))
> +		if (fsl_edma->chan_masked & BIT_ULL(i))
>  			continue;
>  		fsl_chan = &fsl_edma->chans[i];
>  		if (fsl_chan->pd_dev_link)
> @@ -669,7 +686,7 @@ static int fsl_edma3_attach_pd(struct platform_device *pdev, struct fsl_edma_eng
>  	dev = &pdev->dev;
>
>  	for (i = 0; i < fsl_edma->n_chans; i++) {
> -		if (fsl_edma->chan_masked & BIT(i))
> +		if (fsl_edma->chan_masked & BIT_ULL(i))
>  			continue;
>
>  		fsl_chan = &fsl_edma->chans[i];
> @@ -703,6 +720,184 @@ static int fsl_edma3_attach_pd(struct platform_device *pdev, struct fsl_edma_eng
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

It is okay for now. If each channel have sperate node, we can consider
dmaengine consumer direct to point to channel node when channel is fixed.

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
> +	struct device_node *child;
> +	u64 child_mask = 0;
> +	bool has_children = false;
> +	int i, ret;
> +
> +	ret = of_address_to_resource(np, 0, &parent_res);
> +	if (ret)
> +		return ret;
> +
> +	for_each_available_child_of_node(np, child) {

for_each_available_child_of_node_scoped()

> +		struct fsl_edma_chan *fsl_chan;
> +		int ch_id, irq;
> +
> +		has_children = true;
> +
> +		ch_id = fsl_edma_child_to_chan_id(fsl_edma, child,
> +						  &parent_res);
> +		if (ch_id < 0) {
> +			dev_err(&pdev->dev, "invalid channel in %pOFn\n", child);
> +			of_node_put(child);
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
> +		if (irq == -EPROBE_DEFER) {
> +			of_node_put(child);
> +			return -EPROBE_DEFER;
> +		}
> +		if (irq <= 0) {
> +			dev_err(&pdev->dev,
> +				"channel %d child node has no valid interrupt; add interrupts or disable it with dma-channel-mask\n",
> +				ch_id);
> +			of_node_put(child);
> +			return irq < 0 ? irq : -EINVAL;
> +		}
> +
> +		fsl_chan->txirq = irq;
> +		fsl_chan->irq_handler = fsl_edma3_tx_handler;
> +	}
> +
> +	if (!has_children)
> +		return 0;
> +
> +	fsl_edma->per_chan_irqs = true;
> +
> +	for (i = 0; i < fsl_edma->n_chans; i++) {
> +		if (fsl_edma->chan_masked & BIT_ULL(i))
> +			continue;
> +		if (child_mask & BIT_ULL(i))
> +			continue;
> +
> +		dev_err(&pdev->dev,
> +			"channel %d has no dma-channel child node; add one or disable it with dma-channel-mask\n",
> +			i);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int fsl_edma_configure_chan_iommu(struct platform_device *pdev,
> +					struct fsl_edma_engine *fsl_edma)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct resource parent_res;
> +	struct device_node *child;
> +	struct dma_chan *chan;
> +	int ret;
> +
> +	ret = of_address_to_resource(np, 0, &parent_res);
> +	if (ret)
> +		return ret;
> +
> +	for_each_available_child_of_node(np, child) {
> +		struct fsl_edma_chan *fsl_chan;
> +		int ch_id;
> +
> +		if (!of_property_present(child, "iommus"))
> +			continue;
> +
> +		ch_id = fsl_edma_child_to_chan_id(fsl_edma, child,
> +						  &parent_res);
> +		if (ch_id < 0)
> +			continue;
> +
> +		if (ch_id >= fsl_edma->n_chans)
> +			continue;
> +
> +		if (fsl_edma->chan_masked & BIT_ULL(ch_id))
> +			continue;
> +
> +		fsl_chan = &fsl_edma->chans[ch_id];
> +
> +		list_for_each_entry(chan, &fsl_edma->dma_dev.channels,
> +				    device_node) {
> +			struct device *chdev;
> +
> +			if (to_fsl_edma_chan(chan) != fsl_chan)
> +				continue;

Can we avoid scan channel twice?

Frank
> +
> +			chdev = dmaengine_chan_dev(chan);
> +			chdev->dma_parms = pdev->dev.dma_parms;
> +			if (fsl_edma->drvdata->flags & FSL_EDMA_DRV_TCD64)
> +				dma_coerce_mask_and_coherent(chdev,
> +					DMA_BIT_MASK(64));
> +			else
> +				dma_coerce_mask_and_coherent(chdev,
> +					DMA_BIT_MASK(32));
> +			ret = of_dma_configure(chdev, child, true);
> +			if (ret) {
> +				dev_err_probe(&pdev->dev, ret,
> +					      "IOMMU config failed for channel %d\n",
> +					      ch_id);
> +				of_node_put(child);
> +				return ret;
> +			}
> +
> +			if (!device_iommu_mapped(chdev)) {
> +				dev_err_probe(&pdev->dev, -ENODEV,
> +					      "channel %d is not behind an IOMMU\n",
> +					      ch_id);
> +				of_node_put(child);
> +				return -ENODEV;
> +			}
> +
> +			chan->chan_dev->chan_dma_dev = true;
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int fsl_edma_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> @@ -797,7 +992,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
>  		struct fsl_edma_chan *fsl_chan = &fsl_edma->chans[i];
>  		int len;
>
> -		if (fsl_edma->chan_masked & BIT(i))
> +		if (fsl_edma->chan_masked & BIT_ULL(i))
>  			continue;
>
>  		snprintf(fsl_chan->chan_name, sizeof(fsl_chan->chan_name), "%s-CH%02d",
> @@ -835,6 +1030,10 @@ static int fsl_edma_probe(struct platform_device *pdev)
>  			clk_disable_unprepare(fsl_chan->clk);
>  	}
>
> +	ret = fsl_edma_configure_chan_from_dt(pdev, fsl_edma);
> +	if (ret)
> +		return ret;
> +
>  	ret = fsl_edma->drvdata->setup_irq(pdev, fsl_edma);
>  	if (ret)
>  		return ret;
> @@ -897,6 +1096,10 @@ static int fsl_edma_probe(struct platform_device *pdev)
>  		return dev_err_probe(&pdev->dev, ret,
>  				     "Can't register Freescale eDMA engine.\n");
>
> +	ret = fsl_edma_configure_chan_iommu(pdev, fsl_edma);
> +	if (ret)
> +		return ret;
> +
>  	ret = devm_of_dma_controller_register(&pdev->dev, np,
>  			drvdata->dmamuxs ? fsl_edma_xlate : fsl_edma3_xlate,
>  			fsl_edma);
> @@ -927,7 +1130,7 @@ static int fsl_edma_suspend_late(struct device *dev)
>
>  	for (i = 0; i < fsl_edma->n_chans; i++) {
>  		fsl_chan = &fsl_edma->chans[i];
> -		if (fsl_edma->chan_masked & BIT(i))
> +		if (fsl_edma->chan_masked & BIT_ULL(i))
>  			continue;
>  		spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
>  		/* Make sure chan is idle or will force disable. */
> @@ -953,7 +1156,7 @@ static int fsl_edma_resume_early(struct device *dev)
>
>  	for (i = 0; i < fsl_edma->n_chans; i++) {
>  		fsl_chan = &fsl_edma->chans[i];
> -		if (fsl_edma->chan_masked & BIT(i))
> +		if (fsl_edma->chan_masked & BIT_ULL(i))
>  			continue;
>  		fsl_chan->pm_state = RUNNING;
>  		edma_write_tcdreg(fsl_chan, 0, csr);
>
> --
> 2.34.1
>
