Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794499563;
	b=hgu/PZzuKEdEaWlvEWa1ki1t5lLF3OSE7pOwRggFjO5udU6RsHm/A84EYDEYVB7Ulb/R
	 bYuF+XHSdzT8mrZVTueHvInlwWQaag3vbr62HjLISZX0lcojpoHMC0poUuhx0Lxsf5K9k
	 D75IFprWOG4KTGjUgwjn6Qp8n2lWVJAcB5HwLBLYnjGXN1lmBUIfDtakzlbrS2BH3SLPA
	 UgpaxOopjhcErZAgXGXm28tWet+K4NglWwaNM7V92rFYu/44eh8QGE90UAp93xIlAs5c+
	 J7gdDR+aSKgY66PE2sQr5ekIOU1lJ+Pswxjvs/GAzBZIuquk3B4x4pqXHn/85fBy+hQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794499563;
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
	bh=/jNLFJr6NX3nDZAMNKTQOMDY+y/6iaJlnbuKVlA1g/8=;
	b=lmtoNpNNFjJZSYJLiuCwqs6NMfgEocfjjFQk91EMjfMxmmUlzMKFF0PRxN3gNn4B4TW2
	 RX4Q5rMwmSyeGBlggGF//aG8zKyECniGGNYWLKNNChhKVZXruKSUj6A4jXDqHlH3gZ1MR
	 o2k8pM22EjB1vHloLQmekJVCt9c+/0iBbqQFCr+ZOkCr4NNtVE4mQf5RSDQrecDKF5JUS
	 gA0BrGSJAr8NuAqemLMdnaqZnmVoJLiAZ74YHe0qLPKDqzYEV/VgiBa7KUNZElVqREMAP
	 gJEW4wUazSUTpUCwAGrFHYiZMgHyjFvyhk8L4kqzwA2Oney25e4wXkseaIdzpUT9pzg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=IN9Evj3z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.44
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013044.outbound.protection.outlook.com [40.107.159.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F33606A883;
	Thu, 12 Nov 2026 16:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82F33606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=IN9Evj3z
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONNAQRECuVbXZ+u703UkPY207EPO+FNqmsZdtHUQe6414ef53BSskZ0ryoOn8C7i6EvYmU3BqILV96/vwTmmHdUz3Erd8vAaqj0inqmGShPom6ZIePUX8EWNd3rXicgRgtb56ZAP3eYZX0vPq89D4oqZQt9edld6JcLbTchUVyNT1nmIGrf9RLJ2phv3AMQVovy9jvIBcdbn55NrMBq4I8P64Iu4qmqqDf1ns5JPI2q5v53wsZFCziyjBG9QiuF7WEn7AuZWIBOwZky26f2yokpEeYE7M6/Eo4rj/WWWxawnGJcPFIY+Q0j1VVmszoneXwCmSBOcn/6rOTStbGj9dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jNLFJr6NX3nDZAMNKTQOMDY+y/6iaJlnbuKVlA1g/8=;
 b=gVgOIOalkvOuqI3WQtFB10sLeF9RNZVPos5yQJJVEKRqvyKjSj6fRkbzwoOXluioo7QX1yqtFsbliBKfkbFnv57hOL5VTQ5xINhtYtpHleopiftUZ0KRykcNumlbvqjhe6+707bwWoHDfDsAZWITvmjmZBxbY9Bb5PO5kbhlbMup0StNwX8M1eQ9hpsywkhL/gn87dSUHDJCpa8kt4ynjHKRtNkEsD4b81qoXe6xSzP8OKCtUkZ9WZc8wwT/b+hVe/Q9OV74hn6+Bh4KOlJ5lIyTmQ2veC4HU5X/2mbpqkGxJfaAsH0/3gkXy/ZwCyM6UlAGOVs+XjQyE81yguW+rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jNLFJr6NX3nDZAMNKTQOMDY+y/6iaJlnbuKVlA1g/8=;
 b=IN9Evj3zIH8GG0AMgaEmS87rATE3GxEtJCLbn+ETTqy/wttmGmGG6JmoYsbsTIHUv3S4K/UKb4nYDxYX4y+WPoYEwFXbZ5O7Vv4JN8z9Ul85R6MypjTNSdJnlE+xJUhTRojmJds3slR7VVz8UyT+07+7D4B2kNgHpgDXap46z1e6AbfS+Ff+Qj1cBFYIOnHLLHz2Ex01cIeyrntRR6r4zhASCOkbj/e8INT2qcHBPphouX4SYZX5BFSpDzyUST2FXZRPmVEyGKimviPzBaV5nLo1RGwO/wM44+aQj4X3tdOtwfbc0s26T4SXkHp0vNliPvso2qF9CRGKL4uZvKusFQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DBAPR04MB7336.eurprd04.prod.outlook.com (2603:10a6:10:1a9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Thu, 12 Nov
 2026 16:05:55 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 16:05:55 +0000
Date: Thu, 12 Nov 2026 10:05:41 -0600
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
Subject: Re: [PATCH v6 6/9] dmaengine: fsl-edma: use BIT_ULL for 64-bit
 channel mask
Message-ID: <avXj1dfeFOWCo5nZ@SMW015318>
References: <20261112-edma-iommu-v3-v6-0-b038edb8ce6f@nxp.com>
 <20261112-edma-iommu-v3-v6-6-b038edb8ce6f@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112-edma-iommu-v3-v6-6-b038edb8ce6f@nxp.com>
X-ClientProxiedBy: DM6PR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:5:335::20) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DBAPR04MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: edbb2fc9-c449-4cc1-fb8f-08df40d6d550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|23010399003|376014|7416014|1800799024|22082099003|18002099003|10067099003|4143699003|261009223027099003|261028144727099003|11063799006|261022105027099003|56012099006|261021121427099003|261021123027099003|261026140227099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	tOBvdHuskvXk7eYogfE+sQZ5GwowL0dFM7T6HF8OIu56mwPsWar1l/ov+srcrUGlkyVC+Ds1s6aixBq0t7B6VgJ7/mpEu6TvtoLGY5uWOekhvVDTmKeJpM5mj543QaApL0o/RgecNdjZWTrXyRDG+epRdtlegxML5XE5UprUMb1mWRJlCg4IvSJtW6/YmuykhLPdys6KYQmX+6zsJevTwj1PHVLLsf02dQ98To2/VzYl4jILMKcgx/AF37VNqhHGhGjgupcnzi18MAhywBxWRIN+gSwWdt7nowHU9Bd8hAhMAVI5mIgMQPeRW9DrTLK7MlvbT56+oEQL3K0/lXyYmmvFJh4Lmmr2H7iD4NV0rjtL3H6qygb1SVpNQILSzc7MqnVQpZIQqsi5Eqorw1kbEpIEQmoOubK72B5xySR4AVRdlMhVlFrUF6RDp5szYNFcijioYIk3e42Tmt/i1XBydWncsRx0lcgaT1UbIG/xTAl+wKZNpeLK9DJd8TDc953/UxuDAEG1CfSD8FFO/rSkLoalP2c2EhF80//X1FSZAI2AWaUjLDEwIDwdN5lvDkxpUrpBjcM/VoAkbS4WlubzEFbAJ4u/uCG9ZwbjRg0Dfc+vbthzMhKPFtU+hoozY2HXqZr1oViIw/aG3UKJ2xze+GDsBz3NZlmd2lBmyu3ak7U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(23010399003)(376014)(7416014)(1800799024)(22082099003)(18002099003)(10067099003)(4143699003)(261009223027099003)(261028144727099003)(11063799006)(261022105027099003)(56012099006)(261021121427099003)(261021123027099003)(261026140227099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RX5lg9Ta6oXqKFb+Q83UKf7V0gzXlWXCi6tLmmDUSx5GXfh15zuYkJl1iTXU?=
 =?us-ascii?Q?1l3TkA5B5HlR9xK/j/l9gHgpYuxbhIHu6pVZXkQiqaR6B2dcBQJdvqgRuPgZ?=
 =?us-ascii?Q?0WdQc6HUNzfhMu//czIX6RrN9bj0CU3F1kisOXe3eRsxXzVGQHmn5O8BS+NG?=
 =?us-ascii?Q?MKTOvs+X0mVxmydbVSJjAeqeMxluPr9CFXnnariUc8k1LOEBb8118zJjwUMG?=
 =?us-ascii?Q?fMEuuDU79VqJ2VVUhUPabOwBNHnQoyeDg3sa8Kh4kE6+TTjLd5QfOurOpGmF?=
 =?us-ascii?Q?qGlWef0BfrRrdA69YJKMlu3Mnob9cLp9gOM9rlFV13nV7VHFhINIwyPsxSdm?=
 =?us-ascii?Q?7tkoSYMOcSADFcAvgQ9I6ReCTNJEr/XW1zCDMVaWoH5dsBp6n/n0KbzcMUB7?=
 =?us-ascii?Q?zcBw+oW7jVc6tkSZsLedWWmCtin5M/J6Ec5YAo/Nh5+MOaqv2ov53UnYY7Tw?=
 =?us-ascii?Q?T8Rv5d0KRvd94Iwy/gDCz0oDb2SL6rs08ud1PWPSxEmDWlDugtUr7//kRi4i?=
 =?us-ascii?Q?W2/FEUt6M3saUR8Hv+0OqY5uIcHfR+OWxDJLO6tBq4QG7QjUMEBGHz1FT99g?=
 =?us-ascii?Q?Qeu3fbIQ2WNMjKq1zgqoWQkAfaM50a1Hnx0cNmRnXT1YCN6D6FgaMRIEASGM?=
 =?us-ascii?Q?w9E29v6y1ieKtUnE8LOTHX02evug9s/UCbh7OLKj/zE8Ksan1zrJ1keWuHNb?=
 =?us-ascii?Q?XRLUtKJiSLo+iMXuY3tqsTRUaN+u7jK8jEklhAYPVUM1pyhO6qICl9D1i67m?=
 =?us-ascii?Q?J4jZ7UptrC8TpKBX29G5b5sGL7nigTicD6rDXxH+Rx59wPc3luD0grJOaBlN?=
 =?us-ascii?Q?S578HheqaJutdIyPWj0Aqpb7P9mw+fMH17dCPA8Pv/qt+K52Flq3sGlSm3tt?=
 =?us-ascii?Q?AXWAGnHkeIQMt6mg2Q6slDVzJOsAvFCNY2bT9EmEI4xs1I7jOAg/KDiKvLNe?=
 =?us-ascii?Q?23VKdSe/RIp2ayMy+33TaDDrpwCW88Vnp0f1TZf6+UXGmjmxKbpLniMQfHML?=
 =?us-ascii?Q?EO7xhEk1IxPzrowPQfcOP6xrv4444qhb2g/GOgakD75IhUZJtSJ+6Cn5IYy9?=
 =?us-ascii?Q?WfPKu8SM6XKCESjZHPGcVgEv31P+qkn9aO4u2xTOrPZt5hvXd7EtiX2Y8pix?=
 =?us-ascii?Q?d27ngR2N54qpfTU/TvfyBcJGfQoN3eNXAjKpAhWN0YLSpS3K5o8FengY0NuS?=
 =?us-ascii?Q?MuMA6kvkrX07jn+ZFMm3rskmLUdtcIovfpD0cBa7xCrw9hULmKyc6kIzACVj?=
 =?us-ascii?Q?OvzOowT8k0tFguMJMcv2JHiNrbC6sFmcJX+Guqd7rsUB4pc61HoLHqUuoKKf?=
 =?us-ascii?Q?6rpqoW5hdHIKtMQ+CK6QUtI9OlVK/LSbX9lYMXxQTR/RqapPdPadfvRKv5tW?=
 =?us-ascii?Q?jfDKnq7RFsIThB0XC2q5A/ahEdXsx+E7RnPwcKi68mJn6VAG2eY3LT24VtH8?=
 =?us-ascii?Q?jE/A3V+6odR2hEdzJ7uJ7i1uma2xuXb82mJJ9bGGHUzhWtSC+6xDCo0dUDEb?=
 =?us-ascii?Q?l9Esf7AX/Ahbbxv1ttsycZTJ7tto8fzRChd4kfbwBE0PFJVwbLr+VMYBZG3W?=
 =?us-ascii?Q?UMVY2K76eNyxi/I/gHoyxO+tgiUqfeIJaT1qVnHQ6gaUT/Hv4iqJTX0dEukZ?=
 =?us-ascii?Q?9ukFhCrryCbUkugXbSzHOqhEIfyw4dNDeBBp+hQcCZI3k6HjkUWvxOYlFIEG?=
 =?us-ascii?Q?4rG1JQtv6i/JOyp0tHMXNxszZI7azl5QHX/QHBULQR4oykrSvKJVyGTGTtpR?=
 =?us-ascii?Q?UISaDAVhW3PA2rR77GUnyPMPKvKYu+7souMS1vxSVjGclkM6cLhg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edbb2fc9-c449-4cc1-fb8f-08df40d6d550
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 16:05:55.8011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: THqQMhdATibVHcD8HLThRLFAt5A3fYdP91lnxsPANqBOz4KmGEjLpQn/hvtqb0gMKlc/NmSd4FaB/pA6EHUdOAkOHxduSUt95Kma8GsdlIiQUp2SRY2135uA5uDb+LP+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7336

On Thu, Nov 12, 2026 at 03:53:09PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> chan_masked is a u64 bitmap, but several checks use BIT(), which uses
> unsigned long and overflows on 32-bit architectures for channels >= 32.
> Use BIT_ULL() so the upper channels are tested correctly.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/fsl-edma-main.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index 7f82dcb7831d..818b9b986f13 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -123,7 +123,7 @@ static irqreturn_t fsl_edma3_err_handler_shared(int irq, void *dev_id)
>  	unsigned int ch;
>
>  	for (ch = 0; ch < fsl_edma->n_chans; ch++) {
> -		if (fsl_edma->chan_masked & BIT(ch))
> +		if (fsl_edma->chan_masked & BIT_ULL(ch))
>  			continue;
>
>  		fsl_edma3_err_check(&fsl_edma->chans[ch]);
> @@ -397,7 +397,7 @@ static int fsl_edma3_irq_init(struct platform_device *pdev, struct fsl_edma_engi
>
>  		struct fsl_edma_chan *fsl_chan = &fsl_edma->chans[i];
>
> -		if (fsl_edma->chan_masked & BIT(i))
> +		if (fsl_edma->chan_masked & BIT_ULL(i))
>  			continue;
>
>  		/* request channel irq */
> @@ -641,7 +641,7 @@ static void fsl_edma3_detach_pd(struct fsl_edma_engine *fsl_edma)
>  	int i;
>
>  	for (i = 0; i < fsl_edma->n_chans; i++) {
> -		if (fsl_edma->chan_masked & BIT(i))
> +		if (fsl_edma->chan_masked & BIT_ULL(i))
>  			continue;
>  		fsl_chan = &fsl_edma->chans[i];
>  		if (fsl_chan->pd_dev_link)
> @@ -669,7 +669,7 @@ static int fsl_edma3_attach_pd(struct platform_device *pdev, struct fsl_edma_eng
>  	dev = &pdev->dev;
>
>  	for (i = 0; i < fsl_edma->n_chans; i++) {
> -		if (fsl_edma->chan_masked & BIT(i))
> +		if (fsl_edma->chan_masked & BIT_ULL(i))
>  			continue;
>
>  		fsl_chan = &fsl_edma->chans[i];
> @@ -797,7 +797,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
>  		struct fsl_edma_chan *fsl_chan = &fsl_edma->chans[i];
>  		int len;
>
> -		if (fsl_edma->chan_masked & BIT(i))
> +		if (fsl_edma->chan_masked & BIT_ULL(i))
>  			continue;
>
>  		snprintf(fsl_chan->chan_name, sizeof(fsl_chan->chan_name), "%s-CH%02d",
> @@ -927,7 +927,7 @@ static int fsl_edma_suspend_late(struct device *dev)
>
>  	for (i = 0; i < fsl_edma->n_chans; i++) {
>  		fsl_chan = &fsl_edma->chans[i];
> -		if (fsl_edma->chan_masked & BIT(i))
> +		if (fsl_edma->chan_masked & BIT_ULL(i))
>  			continue;
>  		spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
>  		/* Make sure chan is idle or will force disable. */
> @@ -953,7 +953,7 @@ static int fsl_edma_resume_early(struct device *dev)
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
