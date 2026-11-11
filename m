Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.58
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794418067;
	b=k6T0+USiHgzsBAvPiR27mm0E1D0To+mJrCFQVikX64tS4Dex9re1Kwyu8lI1RiUZ+I7i
	 kC8krbSTOB6h/TQLYdFa+8WSRw03KM/nDx3b/Cpgvt2t/znwdYm8HKSUf1HycXWizpQU9
	 iPYKV46mLmCuvkrDN2ALkfj4fN2SECVcmrTevkhaiAH2eNpJNU4bDeutvEYQC18DE5il6
	 482iB1D5LKadNNSLiK4kV7n0dPnvlY9vuw+PmloZXyTJkLNvjWDdMG2kTn/64RJFKKxwk
	 1aw+rrX4bxYOqbWe271115nDPISvCJL17BTIPkFzb3M87Y9ONN6ixsDDfOnjoi29xOQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418067;
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
	bh=03mMARXF/20tAUZEo6HisWHoJiJeJy9dIxh8he9h454=;
	b=GJ77nUM4gFq43ZPnVLf0eO99VD8z9VOxxqztDqyeVkKwTE6LH9oJEkb6xAp5Zg3kv3oS
	 VX4J8tZSTu3paOfigGnRPanWyqsrinjIOukoWn6BAhiPuy0CYesiHp0TLaCR41T67FDDv
	 WjWxm39dDxN16O32lSsw6iQF2DEOiTsnnD9dJsjugIKY/e1v3re8MNNQAEmmtdXCtvjWz
	 JcSQdWnUZUQveHbr3cCllLbI2hGvQocZdqIvxwl4r/hAV/3plhajWVxRL7EHEzUnZfStj
	 7wx+4vpvt5+6fufyCr2NUMBhh995S+FMZLxgro8mCIxh/cZbC5/OKYP+Pey4E9Fryqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=V731rRDQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.58
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010058.outbound.protection.outlook.com [52.101.69.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08294606A32D;
	Wed, 11 Nov 2026 17:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08294606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=V731rRDQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EbvCmEssOfd7xTDf1kFiQ2LeCFT7RK1DHbohSbIpuX4+/cYZOT/Zv67dzNNFOd+OLplmoBcVzTdIILICLG+ZwGkHtJSMUZUGMxaYpzN8+Hrq/j2+vpfobzT1VemNJF599L37T/sDhE0v0N6ruquNc3fhmoh8hiScHsfyNSZA5bG1cJ0Aa1gKCMtLamN1E947MYMHTZMvPPZ9rzo22XyDAoEngwMUNHHzlMWz+39izLQEZnwkWB/ppeP087+HGfOJgeiMHlBqvYhaSyRcLLMFghVo0HHurGE5oSD3k2yqlSOs8hTFYd6i85Kr8nT2lgGilJJ7UEkNHckE65hU3VIGrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03mMARXF/20tAUZEo6HisWHoJiJeJy9dIxh8he9h454=;
 b=uSe5u9JNEGucIenXLZcsqZV04OmSe+P1j1gBC/xT0Qfq0vIJT5jpVfkruskMetS5h0RldY01Vi5FtKVj3S2acjahzYtr6HVkz/ajtbuvcB/Jw1RGYadWde/TTil0H1C5iwtgpR9ALhnqWgovGfe0hkw7KE1gOUpftvELsEeSgUOmiyFU+uEf4OMlR8CQKUHqxxfCJkowTwFeh5n6Tsxk1mVUnaqoLP7e8k9X3eXVrKg1b5UgX/clsqbfPCiDbcsj7OSFL+PKiOY5wYN8A0cWxQAaP+1wRDe8TecXV+UfuRjCNq4TbeYKn+j/RNC7fACKuUkk5YvTElyjL0meC1R8jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03mMARXF/20tAUZEo6HisWHoJiJeJy9dIxh8he9h454=;
 b=V731rRDQVcqalewnDhrZlZZHgGHSrfZpYOQOjdeBtwXZfmyh1Stikt5IjPfeavNf7F48o2jslx2et8xxRaKcsyhGopIeDi4x7SiHaR+B06T0JMJsAh34TG/GWeV1kYVNmzagUhcXvI54KipCcxjrlhjuXy+OyZCu6ofXCDvlLUlJUqV9Bgz+CYFqx7ft1ApvSuM9ewFIj4121ikuBKIwmrkO2NaMXmqPY3dI9M/f+hn8Ptyx4aKMi0ybBNX8/s1E14ZrwECg0bmXn/ufeXN9Hl9igMaiwD1BpCN9pPpek3cYtNSUXSOvZvjprUlxLiOLX4cZB9UhkaNhajLbA21doA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DBBPR04MB7882.eurprd04.prod.outlook.com (2603:10a6:10:1e7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 17:27:43 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 17:27:43 +0000
Date: Wed, 11 Nov 2026 11:27:31 -0600
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
Subject: Re: [PATCH v5 1/7] dmaengine: fsl-edma: unregister channels before
 vchan cleanup
Message-ID: <avSlg1SXLBBF9bzZ@SMW015318>
References: <20261111-edma-iommu-v3-v5-0-2537cebe6ca2@nxp.com>
 <20261111-edma-iommu-v3-v5-1-2537cebe6ca2@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111-edma-iommu-v3-v5-1-2537cebe6ca2@nxp.com>
X-ClientProxiedBy: DS7PR03CA0065.namprd03.prod.outlook.com
 (2603:10b6:5:3bb::10) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DBBPR04MB7882:EE_
X-MS-Office365-Filtering-Correlation-Id: beb61bb0-e235-4ae6-9ba8-08df40191847
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|366016|23010399003|1800799024|22082099003|18002099003|261009223027099003|56012099006|4143699003|11063799006|261028144727099003|261102123227099003|261021121427099003|261026140227099003|261021123027099003|261022105027099003|260925021911599003|260925022911599003|260925021311599003|10067099003;
X-Microsoft-Antispam-Message-Info:
	sOpQEEdxo0PvzrM5XxyjM7gGNehxDGXg9csWpc+/jCxGCcbwzVHG2jLf8EMJTTSTHLFpAakPgEstwKLKsh2wz9qICSUETR4dA0TMscsLpps9EyNRttLkNXhD5cfaLAYA1j3VD6IfwOEZ4/lr85aBXIiNOkAL4NlV5anPN+S49h0lyjdeM/z0lZ7rWFG+U/pSS5TILYkGJiLkYbDU3RJuG5iSvPAL3Z5z1Y/kWu1WNhB7NowOnEX4C3m97ODvQIe49lk5+td+yfXuv/0XUrEjCJS52kndesGhw2OCo0zhpuTws5zijrcOiD8+HUKiC9kVn4LyJCdeAMyahpfLenClW+czs/fioFC6H8i0rqRPvNUEa7Rq3ZmTfmq8MRJ6IaStkhxz6r9t77Jlhl2ZQXnhL7RtnfnZtxiVeWptE6FDKzrUxRcR2ysT+JcGrhcjIzUBxmxezH0l1Qk7xe+pWThxj2XSNOGFoOOFk5MUigFYiY8WML1zcHcyphfAq7m/HHKqWEBRnNTN0OHfxqSllA14JTz+o7X7t9619p76yxpOlsJkxnrvF6h+fFMHue4x/AzaZ1CGbjp09l+jXT29KiHB5dRvWKfmt0QjWRspeeiEc+rTbWcG7Rs3WS+11YU8mpJyUyTXnviF0V4OB5FS0zRJ9D6h9U7RESabdFlFTeNDy8c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(261009223027099003)(56012099006)(4143699003)(11063799006)(261028144727099003)(261102123227099003)(261021121427099003)(261026140227099003)(261021123027099003)(261022105027099003)(260925021911599003)(260925022911599003)(260925021311599003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A/OhqhAC7byzWTHV9UadXb44hcvUmorkneMhj3ACJUnX+dgx2czRfP1zV+55?=
 =?us-ascii?Q?ItUpn5lEX1zIH2eYA7eSmcHHyX4RF2tky6m1D7oNe2SmY8QZBCN+1PTUkvEe?=
 =?us-ascii?Q?AuaIbQOK7NQpaJEpCMvmcSeYlRJmtRfVJ/YTN29k6cNsPCUXafR2FH/lmSyG?=
 =?us-ascii?Q?3WWmEUvyT33IEAskSRDKtKQwe2w5EnWUx4eMboItqeEVCFv49kdbcttplTfx?=
 =?us-ascii?Q?/fsnw5GipTkf10atIuRI39S8d8qKNcl4rEI90fmoI0AI8FJ4zq/5hnHDAahl?=
 =?us-ascii?Q?aK0I8KFytHzvVPD6mYsCBTTSypuQrkgZsXc+K+kipnguxu7BVd+5NG7U0X9k?=
 =?us-ascii?Q?Plcr/ArQaM4R3tFxNIxtbUJiC5tRwTuwjIrJ1N8gfA1kvgciXKc7CF4Mr9BH?=
 =?us-ascii?Q?UVGikGrFGFyvlE+qNvbnx2vkOp57tIG4pXQXRuQ0ma2e8IVyDv+mazgzsX8T?=
 =?us-ascii?Q?SZrtYkjcEMnRxns1PiDfYjClgKi7aW+fZ6w95iiG/LrDVPxqQJQPINdV2Rnb?=
 =?us-ascii?Q?MBAvRo/49TV1+e5KDNSy4RZ577akZ8U9fdaU0kMw+lUAqHOtwLDgH+EJNE06?=
 =?us-ascii?Q?5IKki5NhM15pA6xynXDQD5IXv+A0rpE+beGU/ATzLvbj9kpzFlxQJRtGKAS3?=
 =?us-ascii?Q?dRPgICG3oR0wDUOLnRK1iSpiuuXiIlvomvKfBbQAjmdOt7vdbdbAnobamF4I?=
 =?us-ascii?Q?GYGJSapn5lvLjJb9Z6KdwvkfQukNkG38oKvm5icfZXLBNlkini/BDWKLc5ig?=
 =?us-ascii?Q?Af9n03QUEPx12v2GsYybmHGXpDWUvst/X0p2ZYMCYDi7sU081p6GoG838Rva?=
 =?us-ascii?Q?70iVA3CbdXNYzyym/guq1/29jgzQStHoM7KheK91aagED3A5/dmiNLmP650U?=
 =?us-ascii?Q?/wJTaMhK5qQ7GP5YYYyCDK98y6BpHerz5V/odCntpTO310CY8sLpC8Rfibx6?=
 =?us-ascii?Q?oH3DzH1r9Vy27XFkcvvdxvnqGdVEW5VI1cdNRKJko93tGWou43Y3Q+RJOMRM?=
 =?us-ascii?Q?anzuoi8dxaVBN/5AEyyTzILdwH03bEfPLlu18A5axhvfeBhALs9r/qi4km39?=
 =?us-ascii?Q?YA8FMCn85pM6U7SFcAapB0oizqUq5dcqB8RMdH+ISqJK8BuPWRELi825Mr2C?=
 =?us-ascii?Q?4fZCHVhxOX7EVyqiyRAnwnPvyFH3nmu4aeDQCJ/4yrTqRL7SA/t/rmmaFLlb?=
 =?us-ascii?Q?Z7RnZ8ActdrKfy6y3XA+gK6R1XgLwvPbNSHUOio3NTSy1D6eDfcZYd8Tchtf?=
 =?us-ascii?Q?CnlcYglmpow3QAbm8MSH9PYhVfeo7OItgRuked+2Hj/LNhZNDs9WCjM8/P23?=
 =?us-ascii?Q?6Wry1p8LEjPVGJXdn7Ld0j4X9kfcWACMRl+VaU0mRIA8U8fTBS+Qu5NxmUpP?=
 =?us-ascii?Q?eQwtcBdS3yBm1KKTcVQMqMhAK/SvbUVzlkSySQeDYalxfB4BVTQeuzdqNT1U?=
 =?us-ascii?Q?qoxyWQ4Km5PtyixJ7fBeWYngIrrnHSFx3MoWWzW9xEkOkRSJJ+qEuqKH4+dI?=
 =?us-ascii?Q?BsJBCxJ+lCgVMrAV/5ODIYAY8jJXOlCjGZ4yjBw4M2U+WwH3MfpBCptMIfZO?=
 =?us-ascii?Q?KJsFaBNz+jcdEqODxI7Bcnlg+0zlvEnwkhpqpYv1IhbURGaylRIAswlcoc2B?=
 =?us-ascii?Q?UrEYqv645iWWuFlTOKMfB2Q9QpjCrkr21/fTeAKgqIRuRxsmolGUpKL2H4Hs?=
 =?us-ascii?Q?x0K0q/7EJctYQlLKhDqWqYQAPd2X0jb0y3v9FgN1jNGXaYbA1AITTONVq1z4?=
 =?us-ascii?Q?WuGfFTXj4RN2IhjVkV832ALBmRWu9wD9ihjwD9KIEY954kkGyVoy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb61bb0-e235-4ae6-9ba8-08df40191847
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 17:27:43.7510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3B3MtJdU/IVibSPpC3EYisEGEKgLAhgP2NjNKn4IGWW5ptd1t6JM+WWXQLUDciGxF5EcQ0eexpzoCGsjjarwHOeK98pP54X4C42RO+KlbXqlU+XVp/2l4gcZJJ73VRuK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7882

On Wed, Nov 11, 2026 at 09:47:29PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> Since commit 4035726a6b72 ("dmaengine: fsl-edma: Use managed API
> dmaenginem_async_device_register()"), dma_async_device_unregister() runs
> as a devres action after fsl_edma_remove(). However, fsl_edma_remove()
> still calls fsl_edma_cleanup_vchan() first, which removes every channel
> from dma_dev.channels.  When the devres action later runs,
> dma_async_device_unregister() sees an empty channel list and never
> unregisters the channel devices. They remain visible in /sys/class/dma.
>
> Keep the vchan cleanup, but register it as a devres action before
> dmaenginem_async_device_register(). Devres actions run in reverse
> order, so the DMA channels are unregistered first and the vchan list is
> cleaned up afterwards. Remove the premature cleanup call from
> fsl_edma_remove().
>
> Fixes: 4035726a6b72 ("dmaengine: fsl-edma: Use managed API dmaenginem_async_device_register()")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/fsl-edma-main.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index da5139911488..7f82dcb7831d 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -31,6 +31,11 @@ static void fsl_edma_synchronize(struct dma_chan *chan)
>  	vchan_synchronize(&fsl_chan->vchan);
>  }
>
> +static void fsl_edma_cleanup_vchan_action(void *data)
> +{
> +	fsl_edma_cleanup_vchan(data);
> +}
> +
>  static irqreturn_t fsl_edma_tx_handler(int irq, void *dev_id)
>  {
>  	struct fsl_edma_engine *fsl_edma = dev_id;
> @@ -881,6 +886,12 @@ static int fsl_edma_probe(struct platform_device *pdev)
>
>  	platform_set_drvdata(pdev, fsl_edma);
>
> +	ret = devm_add_action_or_reset(&pdev->dev,
> +				       fsl_edma_cleanup_vchan_action,
> +				       &fsl_edma->dma_dev);
> +	if (ret)
> +		return ret;
> +
>  	ret = dmaenginem_async_device_register(&fsl_edma->dma_dev);
>  	if (ret)
>  		return dev_err_probe(&pdev->dev, ret,
> @@ -905,7 +916,6 @@ static void fsl_edma_remove(struct platform_device *pdev)
>  	struct fsl_edma_engine *fsl_edma = platform_get_drvdata(pdev);
>
>  	fsl_edma_irq_exit(pdev, fsl_edma);
> -	fsl_edma_cleanup_vchan(&fsl_edma->dma_dev);
>  }
>
>  static int fsl_edma_suspend_late(struct device *dev)
>
> --
> 2.34.1
>
