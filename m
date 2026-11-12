Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794499608;
	b=enatZS/etWXzWi3/Y9bDWApvYqROS1DOBlED2fPT8eHWKpe5xloBnhzjvFQWIaNfLcxu
	 ehCZU0ABrb28dXVK2LyNezy6mmJfSnApFyijbO9XL6ezWJ9s1UeUrGOXMkBqCQiuaN8ux
	 MofkdfCWRhRuEh2q7kYBRJA6XQv5qs+wOXbmjzDH2tJiyzq2xh++0Qd3mvVcs/I+DJWhS
	 YiZvcZKROUZXRQ6HsxqLyPvQhBOM7Dg87rao4OGZwQlZvbU2p65XUtkQblKpYaY7t25G5
	 IChuQbOaU2KFbl+G29tEwyDA7WdBtvjL5v8ReP5A6NKtYVRH5XkjZdffglgbG84KqrQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794499608;
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
	bh=X/fOu0EIwP74iv4Y49vsqZtVCb4D018mu7v86BwRqIw=;
	b=KMNi2hhTYHg6Wozv00UzYFyCpH0zUfkVRC02cx3rFqziAWNgwkA6/aV8gr3vO56daltA
	 YUT/zCHGq0BSegvbfKBDet4BbfaQomgoPhnmt7ILF5AF/oHKdvYMDk5nuUmTVCcDHnOxX
	 fFUIH8qBuThUHvMtHilNE1lgn3XBCcWboJSfgbvuGRjrAeN/YQR31KLBARDAdSvfUT11d
	 UgXmdw6pqopvkynvqOeJWAv/zHjXmBa3IYk6yFJD2yl/gs5QiXxEoodSLjdfQ2zjuliHN
	 Z1rr8yeNUQDUSyuz2wddMvojEXnMpOWOa3uz3JQv+x+bMYk2XBHXid+tH6w6WNJUEVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=GE3p84jo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.34
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011034.outbound.protection.outlook.com [52.101.65.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF88606A331;
	Thu, 12 Nov 2026 16:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FF88606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=GE3p84jo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djRQIKj0EMpXlVq/BZt3nW1bzolxPpa0rFgDdYhFL9t9n9bfLIEU9nrQRMbRGbl/dwODIjGK9pwM7NOrgSiNKXw09kRpxEIaVsczWVMhFDxL8bBtvHfbjpaEhu6mm+mvq1TYcVzgRTSvLmICxg8Zkliw2YyoV1cOfLVu5HlAYkEOrnhpm7vZVujSIU6AYacYWAD6EfrnY4o5DwL94B19REUL3fxL4ARHSAIQAm3k2S/oENVjlpf8Mn2wcVNUrqu00simF+x8aEkDKsrQHuXGhF9oSyRzUMVlWjj0INIS8CAQR9Nn4k5oTJ1R4KnvRqHS+siHLyTTb2sOet8LF2BCrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/fOu0EIwP74iv4Y49vsqZtVCb4D018mu7v86BwRqIw=;
 b=u3SFcXAYmDczSposBvNzTat4tHhghasJ3FJRkqQI3eoufOrllKr+MwG7urzYU6zcpsO592SOUrCj64TDmMU83mPm5g5VKvaOfWVCWP/WivhNYe8U0XV0dlT0UisIMwaJhBhwsIJXGZaJ4cyo5ROx32liQ0HzOIDk4uCsB/oxBPdAoEbKvG9ZZ1Y+85JJluYkhE/pvuWlq+4fQxWkIdYpmguVlxhl2IVeWBKvfyCzg2bypPJclWOIwXpTMHqI21IS7Lmapx3lALmqO75b+aHsWRuTvCt47ng9oPFu2q02dIBZE8tyv9xPVHZ/dFz3Wb+pfCcK/w3Ejrb1DiT3MbmN9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/fOu0EIwP74iv4Y49vsqZtVCb4D018mu7v86BwRqIw=;
 b=GE3p84joTBS/xJR5JN0mcKmchKt8lsy305o1aTegN+irSOGA77ZnFlBKq4sq84gpTVxgbhqP9o/xLzqUvmSYOfAqabzjKmKBd0+PcKbL4iBdO08Dikq4kcKSBsV4/tPjysrKLqqINSN5h8FZRvD1LvQJYBH+TEEErb34kijHv7e8nxnYcZHAT4pms529oApsyg4cN+nJR8GjZJwuOt0vZkr08xN7tBsWckMDFYSzyYcXVutjMhvg9MC1+3kHuMOuPmCFX+EuIlyHL8Opa28fGzyY1zLbl+E3ZtTvlgEBB56rkWitAijOfQx5V7hWvH25zmz6iJJ6Lv1mC8g9t4fTIQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PAXPR04MB8911.eurprd04.prod.outlook.com (2603:10a6:102:20e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 12 Nov
 2026 16:06:43 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 16:06:43 +0000
Date: Thu, 12 Nov 2026 10:06:31 -0600
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
Subject: Re: [PATCH v6 7/9] dmaengine: fsl-edma: use
 dmaengine_get_dma_device()
Message-ID: <avXkB8apdBFfWt9e@SMW015318>
References: <20261112-edma-iommu-v3-v6-0-b038edb8ce6f@nxp.com>
 <20261112-edma-iommu-v3-v6-7-b038edb8ce6f@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112-edma-iommu-v3-v6-7-b038edb8ce6f@nxp.com>
X-ClientProxiedBy: CYXP220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:930:ee::17) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PAXPR04MB8911:EE_
X-MS-Office365-Filtering-Correlation-Id: 90302ebf-4d16-4a3b-6bff-08df40d6f1af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|19092799006|10067099003|11063799006|56012099006|261102123227099003|261009223027099003|261021121427099003|261021123027099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UZJJc002611HpBFYe+ZZahmsDu+TC5NLvPGKiGNivjr6t++WQKCvu1m5dyMfY52IQZOHRkheL3ddExQ41QNLIIrXGNyrby461Fhy6vwnkva9e0h7Pi7CMsPC6hxsRSyJNJhLJod69QSuzXY7SOqhN+Hy0QPY4VGKkvCbn/+oMol21/ogbBYOWLRLbLPEEeW0ikJXIgwcBsT0A2WYqIunBDOVkr95YtGK+HwN4IGzMJhW+xbV1C7HBLBzqch7yPtEIBGWsZt7ubvKxme+sdDq6r7qi7NUN/zxPTjdDuVH97hQVN+T8+joPDAEbZJOU5/vhPr04CJBWWg6jQR4aPCg3AHI8WvYQ7Kem+hSjpMv1t+mfuo/AOF6lp/QIHV9M5HWGQxtcToW36O6DgSV3wTEU566NFkL4Zsz7M+zDLCfZC+LjiJwMBXG6dCftF4sLTP4iQxKvP0LBsqJVmnUEJGI3WukNvyJTWj2jmmRJoANUae30ZH28X33r36OdqqDuw2ovRyMU2h1R6hE5QrlMM3szRcYAx2uO0aqXoCeyKHB3LfEyK9YhG2HHwU2o76sRTcWuS/LgUcEXADx5yoVmSiSBq+oNHrmtw3lia02TmtqR6mn6h2EkAiuDq0CvHQNJKYY59UXtaNZbI3KWRsCujyLIzeRJQs1sFDt7UuDrKEdixQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(19092799006)(10067099003)(11063799006)(56012099006)(261102123227099003)(261009223027099003)(261021121427099003)(261021123027099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e0Lwlqfc7TiD0Nn5jeunDVwu0C1XM4U3XGIM2f4hdSX49I91hJdGYRbg6k/Q?=
 =?us-ascii?Q?9fNgVukcus8lLXRvNti2/w7QzySpCS/cFvZfhuCM8/OrtAn5PyItfi3ijsFs?=
 =?us-ascii?Q?fjqMOSli012PptoOhRmT1E1jQO0Jy+ZlWtC3wejSkXA+vSjslRe43UpmrUQF?=
 =?us-ascii?Q?eDggVflgH5hE62rpRRlPPc9YYq5HQ4q8bCtd9arJPfvpy1l3zToaR/GyTy3h?=
 =?us-ascii?Q?KJMP9vHqufpeT207a2vmGZhUExr6svi3REZqY4bz4oRpnqxqkL4sB50dB1oC?=
 =?us-ascii?Q?RseVKe5j+O8oeu/0uGbzqOxgX7EKExSN6z+EzqAe5qYUEqOriGYiL+ukKx9b?=
 =?us-ascii?Q?LaJg4dRqsdsCUuBghUAlUp4r75Y3HOSMoN84k8ccEoxqD588BV0LLn1G4CA6?=
 =?us-ascii?Q?jtIuo0gJnGPg0l4BN31Mxdr9vMnYImmqyt1WdOEXREC34n0GiBQdCh47BYB+?=
 =?us-ascii?Q?lHG4JO2LpoQI4sNtwnN0D0Hli0q60FNmhwNgnaXiefn6xQNqqcf2Zpifa/6b?=
 =?us-ascii?Q?rL9VLQmV4RVyHe1NOrVAvSRUhVRpRnBHIq1d5EhL2IuwoX96Kcz1E/0F0QBB?=
 =?us-ascii?Q?ZX0nt6Ags93+hDLEs/gUMXAziVL4X+COVZTaPDOfwZoRAEhM/YLLoL8YttgG?=
 =?us-ascii?Q?rLeHrmcQYNg/N41ELUA8zcBc7fq3QyHdq97zkf4a437ShzAlxcV/T7h1Cqli?=
 =?us-ascii?Q?i9fcfu87Ow5iVGhliCSRSIE9Y8T/nfJ4stbf30Vh7FozvL0j5JdrAQsVUwp0?=
 =?us-ascii?Q?um88q3l0PDCcFcemvxaoLGk014B+akMY1cqILLXCF78YEn3FqzbSXFHHYwe8?=
 =?us-ascii?Q?4APHLMcQHC9nudpk0nJ5sthARkJacE0oejI9jGgL1wMInuBq6wVtGIJdUKie?=
 =?us-ascii?Q?zf0Hr5Jp873uQAGLYbXYiNYy/xvJADXrxMPtBdUaMAT91MnFxe3fin+EwbOy?=
 =?us-ascii?Q?N2xAz8HAxDBk9YWEjolnKH/n/LeF8uRbnQjhYYoBYUCAgRjYB38zB03DoFNk?=
 =?us-ascii?Q?NBo2Xi5Yx08wEYNkKqQ4W5UKcS8bnJ7dnsJMZWe42O/agFcqBU6xFb/q4Q/3?=
 =?us-ascii?Q?BWExPbuGOXYCcCb6z55hx7cpYFX3PEcxLB8WaUGPmJ9maFgNpYA+Gbr/Y1Mv?=
 =?us-ascii?Q?BRhLxhuiv5B0SmC2dUAzu3wZSvNYC8z66I4GqQBToJsWaeNSaL0RdglgVA7h?=
 =?us-ascii?Q?/1hM0SerfK9vC0Xz07oda2GAf2WRJwHk1ktPTtWJXvkzvQhtf6lkEmD287Z1?=
 =?us-ascii?Q?S94uctJSPxwJi0b73qwdk7kR8GEhdATXKjh5Dl4Mf1CZXCdzs2W4faZbnp5Y?=
 =?us-ascii?Q?TEu1AZ4ty5wH50AqWEy1cV/vaaoQaaV28djPkl44VSVSVXOg3k2SWQ2LAxvs?=
 =?us-ascii?Q?DHs3DJPLpXovzNZaSkkNiMte+rbTc+YYk4hSqOIHNf0AJ8VBjM2QzHgvOs/C?=
 =?us-ascii?Q?qb+VDpIMy8/uDpp6lrpq+l6fVxNKZ8xuxeCn8Bb5LLu/xOn6MJl+5WGIrxFG?=
 =?us-ascii?Q?vfvvugRm2pzcVpJQ7mM+cOC0a5iAnitFTXlt8lW5/870Q/WX2IkNWrCqiAMe?=
 =?us-ascii?Q?iawjmUdK+b7gbFJ+k+xhp4EXKixDJT6631RsrtiS+8F12YAI/TNDh+Wy2Kxg?=
 =?us-ascii?Q?tbw2elMM1hZi9swnUIV1uCSd7RmK5GIxPsXEUVdK/eRMY0UcuwlwT9rv1IdY?=
 =?us-ascii?Q?16BUFeJcQvdrSWCS/LJ/Cph+ecr1n2QmST63ehJQKGJpzaBMkk1KrLn61v6z?=
 =?us-ascii?Q?+3wJy9rdOjsvKCgRElgC/nwOSVN2L4+XRSmxZZv4+Uxvoedc0OsN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90302ebf-4d16-4a3b-6bff-08df40d6f1af
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 16:06:43.3955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vdql28pmFR6A5zxhYyLA/FQrIAvIgaH21UzgkIWaexstBcA2XDvW1aXHFlP6jVSwR8GcgIOV14fU3ogO0OnHd6ReBp/+z1n1k0VV/VQoTlnvgDcKE0e2sBWEIC5BG+2w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8911

On Thu, Nov 12, 2026 at 03:53:10PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> Use dmaengine_get_dma_device() instead of chan->device->dev when creating
> the TCD pool and when mapping the slave resource. This lets the driver use
> the per-channel device once per-channel IOMMU support enables it, without
> changing behaviour for existing users.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/fsl-edma-common.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
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
>
> --
> 2.34.1
>
