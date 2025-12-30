Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010001.outbound.protection.outlook.com [52.101.69.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B51254B03
	for <iommu@lists.linux.dev>; Tue, 30 Dec 2025 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767108567; cv=fail; b=LsOZqqMt7L+w3TclO5gmc2KRTcDV3zJGt7XOlTicAePssi2wY9rEWBm6ce5h0POQFTZISqCGYfPBeBa3EBtstW7eeHTA0rJxZq+pN6brX+XMKsNPfoRbhs4gdMFPoMohrU1GG6CTkuUbDuPOnE2Nr3CQ9lJYslRpnWKQ67lf53g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767108567; c=relaxed/simple;
	bh=yBiO57SP4Bbe289r40ra58wrbC7SoHRy1TAWwsT8Z0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R2e22yzA7niPJ6tnFQvQ/y6p1mG3ETifZE7Cr3gmBGwA1DD7A8mfXkBp0l/BowbPDoaxErSqZ86KuLzfuY/yg1+nSRHWLTycMxidGP6rZiKs1zby4vx+sYYGor7h/81ZhlCWQOw7J/2zhzN+0HsYlvQEzDO2YSb7Rac/7d8WOBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k8+E7cgT; arc=fail smtp.client-ip=52.101.69.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k8+E7cgT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uq3MQNS2i5BJ57Kl5S91o2t2uN4JKaoFEOEPXVE7E0DyLZVaLAeVOX2isXFTsotpv3LAswHhN0pHwO7rRQVbDPvCV1QOYo55ShGEefL6yaFFnrh/KIatGZhHClzU0wi9ZjjeZblnQjK0ql1684WUTvCRfGXgpf07RyR/ukYLabRNcsJZ9wpgmGxRVu2ToZ7hH03Eew5FOBvsBgmPqXQIX4I+Ko5jeInKrFiz/A0OlHurO4VZKGrzcWqUSP0DkjFNe1Y9umGobedwqJT2relc5YOy8T9Bn1OyF8srfOE5bO/XRj969qrDBM50EzFcy840/q9DtghgJsfnaqLy2MlGcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNR6/xKxxBd6y278YtvORoVpJIelxXZTFs5Xusb0G5o=;
 b=DZifPO4X7QqKGGVlwVyfsT+bvkfnadX5GOgPL9l0iqq0KCFdYQUcjoCJCoBvgDWBzq/4K4IU4T2qpzE645neZOJHXUaS3qFa/Bo94oDxN+BpVQbyOAvypm4ruy9x7XVwdgTgz2dGkg/LD9dPAreqkBgoNHDsfJStWzpRq78hTP2inFOt903qi6GInpNiFg4qbaloE1nDm4gUiKY5GgNrwmayorex3PhWbEZZt3lWsQJYljOYxoVGLVJjdadVfQT5qHvSUblpokQ/cVfsTHSFp6h1b5udLim4jbXN1EboFqWCKPB0NbZ3kpostDHr8D6BtG5kjTf+FbRS7PH0g5Xk3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNR6/xKxxBd6y278YtvORoVpJIelxXZTFs5Xusb0G5o=;
 b=k8+E7cgT4krOa9EaC9N95Yy2SjKztBIxOCC25MK94Jq2MJxvs1jK2AMVFVFjwR3VYEsCD0IIhmq2lFyTVno22fIhoyovLlN8TdEAWF6818SCCfW/6Bm/HlIGYyXsRu7q/S8YeAKlmSz/eb6jV5LrJNXZlK181YhPg6Hp59bjCIBORZyherNrHwYvvVZoUui287QTagzJKmn8yhsGLllz4wvwbhYsfvgg0XPoYJPAFaHjnwOXdrdUWAZn5GgZGQxN+7wZVz/xtjEUluBDLW+oYAVWudJJUrRsV3JpfH/RijcF8PJo11Tw69qlHAAg3Ri5mKVV1UYNfO+b136pVPV2ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by GVXPR04MB10112.eurprd04.prod.outlook.com (2603:10a6:150:1c0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Tue, 30 Dec
 2025 15:29:19 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9456.013; Tue, 30 Dec 2025
 15:29:19 +0000
Date: Tue, 30 Dec 2025 10:29:10 -0500
From: Frank Li <Frank.li@nxp.com>
To: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, robh@kernel.org,
	dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
	bjorn.andersson@oss.qualcomm.com, bod@kernel.org,
	conor+dt@kernel.org, krzk+dt@kernel.org, saravanak@google.com,
	prakash.gupta@oss.qualcomm.com, vikash.garodia@oss.qualcomm.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] of: Add convenience wrappers for of_map_id()
Message-ID: <aVPvxtrzo0WcHsRy@lizhi-Precision-Tower-5810>
References: <20251221213602.2413124-1-vijayanand.jitta@oss.qualcomm.com>
 <20251221213602.2413124-2-vijayanand.jitta@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251221213602.2413124-2-vijayanand.jitta@oss.qualcomm.com>
X-ClientProxiedBy: SJ0P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::16) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|GVXPR04MB10112:EE_
X-MS-Office365-Filtering-Correlation-Id: fcee7da1-0490-4102-c242-08de47b8333f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|52116014|366016|7416014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SWOZM6wql/rOkt7woK5OO6i0Y/iwOTeGlNuq+KgULJGWjBXvuvUBeKP+b/+j?=
 =?us-ascii?Q?0PbC1bjavtdtK1hf9cKlssxN993tJvsHdLBvGWwYKSM6YOgUTC2AniX/j5YM?=
 =?us-ascii?Q?AH6hkb9YDWgDO2oSnfSkiVHzd9TlpuCuwhKYNZdB4EY4Yk91y/htyTfFiYHJ?=
 =?us-ascii?Q?ape7w3KCzo3PRFCFbHsLr9TQv44lBIot5TjZri10B/pW53zz4BwrnfbpFKAB?=
 =?us-ascii?Q?iu3IpfHiShzFAq3Xp/SpqTAR6eiQfiRM9kgtGSsW4Na0EH5FfojVAzmjNtZP?=
 =?us-ascii?Q?C89CjmXfoATrLPC7DNFcOq42LYNhIpFmS+FHCE0SrVJSs4I4f5RHxeVjYkC6?=
 =?us-ascii?Q?nDvDM2K+rlQrgjFN9dJb5t4FBRkZRTwuYa6+0TDuCtNVQRBC6iOh/hxBVJw9?=
 =?us-ascii?Q?8A5Pvrtq2ugfcAUBzSt2sxUFN4AhFngByS93aGtGFUmAiHW6+D3KXuFymCy8?=
 =?us-ascii?Q?G/giTIWUxedkmZTgwithWxtPoxOQQytlFljxksjOkzCUbbvbZqQzDjXNmhsF?=
 =?us-ascii?Q?cf/WvxcgI0Ndz8uZCl9bz0eX9E4J1qhJQRWOwnP5yPYz24mpNuML24IaXt/5?=
 =?us-ascii?Q?lKWAdj+dY7uZLZUG9xTgCaMZ6dPt81VGFfAtr05CEqWy4jJlFjAAdzUsIUZy?=
 =?us-ascii?Q?V+omGBtt4m7zD80QrEYaLKjjWMCxp4kSDBseR8wyfGLjfGK893jj7wlifAl/?=
 =?us-ascii?Q?jxyxlqksSAweNzP0Gnc4KsvMkRz4o2urx1/fOiL5hTaKgCnLWEQinGMbnRDx?=
 =?us-ascii?Q?AlBG0JPmQ9IweWJyzf4Qrthwjjal+n9FmHLN1wbcuVmEXymaARVqndKZmzTO?=
 =?us-ascii?Q?izPiSQxEZ81fxZGTG/k3ehH8ASZmv+hZIgDagJFmusGH+Y45dZJLy/EJKGHU?=
 =?us-ascii?Q?m2we52EYirC2jT6Gkx2QS0zxo0MUgtAPOTxLbEkhg6T0nNf3+m5nz2l6TvXi?=
 =?us-ascii?Q?cdV7WLTzsEOANyVIX6yYIEW8+gZNPAEL2uQB44GAXkD4ljpT7Uj8r0Rtsq6W?=
 =?us-ascii?Q?QWAiwcCDULfAwfU8sRM+BsIRfCx5RSg8188JyQxKbJ1PS0vb+xBhtX/2ry8G?=
 =?us-ascii?Q?dBz1ahs670pchhWe31IQFywKGjRqu5pEl9xEm5DD5VdL9AfVQGhqnovgq4le?=
 =?us-ascii?Q?hr0JnsHoiwiD46Tk5c6dfnRE7VB04B7M2NduxA++dUWzPJ+KvluJoyhy81x6?=
 =?us-ascii?Q?hOl9im2QOupOm4p8uMw2MUeJ9SZ/45jbrq5hE9ftLBODo7eY/YyDBFgxhQ/j?=
 =?us-ascii?Q?2JVOYiXkAx7B/1DCXfhbIlDIb4OOEG3gWC4nOYcjN+I3ktU/E9DGgSGnsZ+u?=
 =?us-ascii?Q?58QK5GYRXURgKreYPeg8izAI7BRml6kR3qr50wUwGbqPlV8UMzDqT9OC8NL5?=
 =?us-ascii?Q?K7pRmHPGJVHI6jp9g3/XNVBIm82IPL5JZtgymOF8uGWpncyDlPkvf7v3antL?=
 =?us-ascii?Q?Yp58/T0ecFvmraAxZiW1GoYcJzuudirrYovOsr4hg5KV/udD0rT/6MwJhzbQ?=
 =?us-ascii?Q?ofvhsjCYBcVumOvWAtkRnB1zOCDZQsDwBVlE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(52116014)(366016)(7416014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TJ27PD9iOU4rbwqF5lhm3UnvfPzTfNtkLQRoK1sGLHD0XJmVZwbNdUKptDsQ?=
 =?us-ascii?Q?Yuvk1GWC1N7ArW7Iyjk+Vm4OkaYuQjBjCn8kseUznBsF0JPfaOMxrWP0xU2v?=
 =?us-ascii?Q?H5ryq0DKpmwT2h/Lz4NPQp5y5Ejs99gBu1ghk6HQOJDQVnhetZE6pEMpeG9j?=
 =?us-ascii?Q?iy4vG+F3O4M1tMsv54KD+cZQ3uYEorqa8zKhAyjJ+wZdW64Ml4d+50KQO1Jm?=
 =?us-ascii?Q?RAF32D88ujHdMGV97go7I3FxPvlEG4nTbjgwtnfN7FISXiGMpLq33KDnN6Lj?=
 =?us-ascii?Q?mDsKZyq7iOF5Bq9t0XjU/35YkpmPzs1cRfnnpfY6G77EFbj1zEp2NE5pb5a7?=
 =?us-ascii?Q?ygnwK1ogg/MQDJmR7iikw0sud6+iH5OY74bcYSkZaf5BThoN3SVXOs7z3KIi?=
 =?us-ascii?Q?zH2eU3RbfOyJat3OQeiHFgtG9nfGwvWsnjcimWu8k+i1En86ffFUViAi/OH4?=
 =?us-ascii?Q?up9FPUSoZagubCXG8occ+PW4rjyL5ldEKEv75EOpSRplE0cRWAZ7NvWEmUoC?=
 =?us-ascii?Q?dYaG2l7zaWQVTr31CzddpWHOvAA87s3C0qzRJvBibLoq5g1ORQkfWpiFgNu1?=
 =?us-ascii?Q?DLVx3DK/h3eE8Xw0rTN8AwRit072xtn8ip1U7434X680xXBgS2k4ZQFzbR5O?=
 =?us-ascii?Q?4i420Fz3PVcHE6zPXoyR0/oKeCxfuUlQXBFMZbM+we+BD6aSEy9LbI95ki3+?=
 =?us-ascii?Q?Ww8SZQIrUD7Th8d1Bd+5cPPfhNCekijcad2CLl/9fiSw254ye01lO0IFm/IF?=
 =?us-ascii?Q?8NWeU2rP+Iw8M0ljDHITUYiJs52fzO7gde0QHZTKCnMpGXwlOFR5si5gufWc?=
 =?us-ascii?Q?O1oj2fQUwDeFgR5r/DZmRUoYEes3UBU3FOeXWa1iJiKXWmfXGwAhLaitO7BF?=
 =?us-ascii?Q?DIkB50gqDNpQ2H3Y7Voe9xKfIQmLRWx0O6TeOwoZF3sUT7RniusRURTrM/vL?=
 =?us-ascii?Q?yn4BDEWWBAmW1Uf4XvxsP1e0fWU4fkzOnmEHVplAGcAxu9U0ZfWT2u0wRpi2?=
 =?us-ascii?Q?EJYEctITK8TEBEaJZOASITTzjbMFde1hwhG/7o8/XLkWhIFQfRcQlm45PUBb?=
 =?us-ascii?Q?K90BecyXj0NlAgoj7L/Uep6gmLPlDfiae/oTACESz9TM77YQYYBQUOmBRLc4?=
 =?us-ascii?Q?s+RQrTw1Wl8qr/KKGiOCagEvzYiF2qCtNce7efZpgKreasaaVKJZpK60g7kO?=
 =?us-ascii?Q?gHinQoZubSLpyvfqd7BPukLEkjVhw7Jktc04iSvNa/nho8vdTR2L7mQLcxwm?=
 =?us-ascii?Q?nSDgYeI4dELROV35+WMLCRDRZnGUK0HeuoMo6BKfaAy4t6hsuI8LVaqBsKSG?=
 =?us-ascii?Q?HbYz8gqGgmmeP+d6j9xACCykLR175zvbnpiWMeZBRRV9zreqWBWRi1XtN4px?=
 =?us-ascii?Q?nUy81Y2D9AoPxV4T9bFIkKcyubbOyQ3+f9MKaRyDiDTdjiQLIIuwOl82NnE9?=
 =?us-ascii?Q?sgI/nybU2QrMwJVkfScvmetJAHKrT2ch2WRdw6sFcVHYSA9DazmG+nk8YaCi?=
 =?us-ascii?Q?Ay10pRMF/1Ia2vzpkPNJq49nQoVabRjClb0VJidctGMofniN4gEdO+8HcTqj?=
 =?us-ascii?Q?4OGmd62oboL+2Dgcd25/34C3wmgwWrAgJEq727XSComqk1FhgUVdWn8Ewmkn?=
 =?us-ascii?Q?JjN+kohgO55AoTZq/Fiw6btz4/S2RASrdnV2qt3ZoGheFLr0BEFL44nO6Jpq?=
 =?us-ascii?Q?uGIH62WXPKnNOyETUNIcueLRQFYRc2C/CwXA3ne2mtOfkBcNzfyQ9zWhhSjg?=
 =?us-ascii?Q?7WNKVOWjuQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcee7da1-0490-4102-c242-08de47b8333f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 15:29:19.3860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYvoVdki0H+xPUqnCqTHjkDGl/oHX0Iw6B829OOpnhuZ+bxG1v1Gh6fnSsiwWktFwrsN4VxK07vuwzc+ZfX5lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10112

On Mon, Dec 22, 2025 at 03:06:00AM +0530, Vijayanand Jitta wrote:
> From: Robin Murphy <robin.murphy@arm.com>
>
> Since we now have quite a few users parsing "iommu-map" and "msi-map"
> properties, give them some wrappers to conveniently encapsulate the
> appropriate sets of property names. This will also make it easier to
> then change of_map_id() to correctly account for specifier cells.
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/cdx/cdx_msi.c                    |  3 +--
>  drivers/iommu/of_iommu.c                 |  4 +---
>  drivers/irqchip/irq-gic-its-msi-parent.c |  4 ++--
>  drivers/of/irq.c                         |  3 +--
>  drivers/pci/controller/dwc/pci-imx6.c    |  6 ++----
>  drivers/pci/controller/pcie-apple.c      |  3 +--
>  drivers/xen/grant-dma-ops.c              |  3 +--
>  include/linux/of.h                       | 14 ++++++++++++++
>  8 files changed, 23 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/cdx/cdx_msi.c b/drivers/cdx/cdx_msi.c
> index 91b95422b263..63b3544ec997 100644
> --- a/drivers/cdx/cdx_msi.c
> +++ b/drivers/cdx/cdx_msi.c
> @@ -128,8 +128,7 @@ static int cdx_msi_prepare(struct irq_domain *msi_domain,
>  	int ret;
>
>  	/* Retrieve device ID from requestor ID using parent device */
> -	ret = of_map_id(parent->of_node, cdx_dev->msi_dev_id, "msi-map", "msi-map-mask",
> -			NULL, &dev_id);
> +	ret = of_map_msi_id(parent->of_node, cdx_dev->msi_dev_id, NULL, &dev_id);
>  	if (ret) {
>  		dev_err(dev, "of_map_id failed for MSI: %d\n", ret);
>  		return ret;
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 6b989a62def2..a511ecf21fcd 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -48,9 +48,7 @@ static int of_iommu_configure_dev_id(struct device_node *master_np,
>  	struct of_phandle_args iommu_spec = { .args_count = 1 };
>  	int err;
>
> -	err = of_map_id(master_np, *id, "iommu-map",
> -			 "iommu-map-mask", &iommu_spec.np,
> -			 iommu_spec.args);
> +	err = of_map_iommu_id(master_np, *id, &iommu_spec.np, iommu_spec.args);
>  	if (err)
>  		return err;
>
> diff --git a/drivers/irqchip/irq-gic-its-msi-parent.c b/drivers/irqchip/irq-gic-its-msi-parent.c
> index eb1473f1448a..0884c4cbd245 100644
> --- a/drivers/irqchip/irq-gic-its-msi-parent.c
> +++ b/drivers/irqchip/irq-gic-its-msi-parent.c
> @@ -166,7 +166,7 @@ static int of_pmsi_get_dev_id(struct irq_domain *domain, struct device *dev,
>  	if (ret) {
>  		struct device_node *np = NULL;
>
> -		ret = of_map_id(dev->of_node, dev->id, "msi-map", "msi-map-mask", &np, dev_id);
> +		ret = of_map_msi_id(dev->of_node, dev->id, &np, dev_id);
>  		if (np)
>  			of_node_put(np);
>  	}
> @@ -211,7 +211,7 @@ static int of_v5_pmsi_get_msi_info(struct irq_domain *domain, struct device *dev
>  	if (ret) {
>  		struct device_node *np = NULL;
>
> -		ret = of_map_id(dev->of_node, dev->id, "msi-map", "msi-map-mask", &np, dev_id);
> +		ret = of_map_msi_id(dev->of_node, dev->id, &np, dev_id);
>  		if (np) {
>  			ret = its_translate_frame_address(np, pa);
>  			of_node_put(np);
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index 1cd93549d093..9549dda8f9d6 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -725,8 +725,7 @@ u32 of_msi_xlate(struct device *dev, struct device_node **msi_np, u32 id_in)
>  	 * "msi-map" or an "msi-parent" property.
>  	 */
>  	for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent) {
> -		if (!of_map_id(parent_dev->of_node, id_in, "msi-map",
> -				"msi-map-mask", msi_np, &id_out))
> +		if (!of_map_msi_id(parent_dev->of_node, id_in, msi_np, &id_out))
>  			break;
>  		if (!of_check_msi_parent(parent_dev->of_node, msi_np))
>  			break;
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 4668fc9648bf..c8da2e88e9c6 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1106,8 +1106,7 @@ static int imx_pcie_add_lut_by_rid(struct imx_pcie *imx_pcie, u32 rid)
>  	u32 sid = 0;
>
>  	target = NULL;
> -	err_i = of_map_id(dev->of_node, rid, "iommu-map", "iommu-map-mask",
> -			  &target, &sid_i);
> +	err_i = of_map_iommu_id(dev->of_node, rid, &target, &sid_i);
>  	if (target) {
>  		of_node_put(target);
>  	} else {
> @@ -1120,8 +1119,7 @@ static int imx_pcie_add_lut_by_rid(struct imx_pcie *imx_pcie, u32 rid)
>  	}
>
>  	target = NULL;
> -	err_m = of_map_id(dev->of_node, rid, "msi-map", "msi-map-mask",
> -			  &target, &sid_m);
> +	err_m = of_map_msi_id(dev->of_node, rid, &target, &sid_m);
>
>  	/*
>  	 *   err_m      target
> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> index 0380d300adca..ce21728d6e51 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -791,8 +791,7 @@ static int apple_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_d
>  	dev_dbg(&pdev->dev, "added to bus %s, index %d\n",
>  		pci_name(pdev->bus->self), port->idx);
>
> -	err = of_map_id(port->pcie->dev->of_node, rid, "iommu-map",
> -			"iommu-map-mask", NULL, &sid);
> +	err = of_map_iommu_id(port->pcie->dev->of_node, rid, NULL, &sid);
>  	if (err)
>  		return err;
>
> diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
> index 29257d2639db..b661f9c1f4fe 100644
> --- a/drivers/xen/grant-dma-ops.c
> +++ b/drivers/xen/grant-dma-ops.c
> @@ -321,8 +321,7 @@ static int xen_dt_grant_init_backend_domid(struct device *dev,
>  		struct pci_dev *pdev = to_pci_dev(dev);
>  		u32 rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
>
> -		if (of_map_id(np, rid, "iommu-map", "iommu-map-mask", &iommu_spec.np,
> -				iommu_spec.args)) {
> +		if (of_map_iommu_id(np, rid, &iommu_spec.np, iommu_spec.args)) {
>  			dev_dbg(dev, "Cannot translate ID\n");
>  			return -ESRCH;
>  		}
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 121a288ca92d..8cd486d89da2 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -1435,6 +1435,20 @@ static inline int of_property_read_s32(const struct device_node *np,
>  	return of_property_read_u32(np, propname, (u32*) out_value);
>  }
>
> +static inline int of_map_iommu_id(const struct device_node *np, u32 id,
> +				  struct device_node **target, u32 *id_out)
> +{
> +	return of_map_id(np, id, "iommu-map", "iommu-map-mask",
> +			 target, id_out);
> +}
> +
> +static inline int of_map_msi_id(const struct device_node *np, u32 id,
> +				struct device_node **target, u32 *id_out)
> +{
> +	return of_map_id(np, id, "msi-map", "msi-map-mask",
> +			 target, id_out);
> +}
> +
>  #define of_for_each_phandle(it, err, np, ln, cn, cc)			\
>  	for (of_phandle_iterator_init((it), (np), (ln), (cn), (cc)),	\
>  	     err = of_phandle_iterator_next(it);			\
> --
> 2.34.1
>
