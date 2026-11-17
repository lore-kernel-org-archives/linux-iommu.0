Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794934324;
	b=VuARd4Mvv+2fJ2TEB8u2pz7P7yjRy3AyQJSJlnzBAXyq2J/AP5hKQXi5BBkRrfQ08vY1
	 Zz0RTbMacWVMbcGqiLD6XannniX6vFKpzqKrGcQRg/Cj2vHPZUBMFcOgZQO2DEWg/i2w4
	 7E0YKdrcCH/EEyo42CqQ1mEItqcj2dj+d3d036wEBxRG1aMTtzIO1RQ9iwbdKjHN0OVUm
	 WTY3mMna9VdSvzkIlGmvWs0wIN+8hjr+LjcwMt8a9arbhukyNoPxSgsdCGnjdqCUG+3uq
	 jragc6oNEv6F/9SuchXI3hj6QWKK6qm1WH7TiOmc87rCEYyQ4fEv08mx7k+iafhL3ug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794934324;
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
	bh=dVyO6p3THBEdpg71tAu/mvRTYtcQze6lRLEq/wqk/xE=;
	b=eI7ez15RbfDFVDiu6Ra/qtrUeQzUBGWkRC+I2A17NZWRTJri66LzI9TsEnHSW/iqbpCr
	 LOw1H0XoNwk5l4CtwUJnTs1yMAhoX3eVA5Vi2yqnB65fD6tG3eak4w/g8v6EOvBcB3Sr3
	 qZUNiLsrOB2LWEkdnzc9gA7iE5/Mn1u74Ub190Q08gvV6WpjxGAXQETsQfe5e2pOGt1tk
	 ZSOeHDPfxuOPqjNjrG2TW1/Zq1WcMm0dsyDlf6rrrU7fbFXvYGv/cjqoc3Kd57FvPyOEZ
	 3UB3d3ek5N5HAvzSgzjMeEvFS1iGUhAbzum82fc/nAKg0soJsXbylz+Ri/fABLStgHw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Z9NkscsY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.65
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011065.outbound.protection.outlook.com [40.107.130.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1F6606A32C;
	Tue, 17 Nov 2026 16:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD1F6606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Z9NkscsY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVoP0Q/stD2JD5joPEj8Yxcv7z5HsriVPfZs26k/I1Q0Yx8AFp9FzDD1oY3Mf17JcEN1IWa6xGLb5HQH2N3PHVLdZKn4dml0hLUULzjmku37la63gq4J/1ENxPqSPR2HNt4kXF7Gi1kEyAkugGdO1K9NkFDMO8UYbH6zSs+/18jlldUFaxopzby9Gc5QHP1NQK63mCPdGBk+b2KmdclhvluBtjzA8tV57iYqELxejd1R8ORywcXfd6LuQspnEbuBZVkocVOazCEZQTw2KjZN4Ny7ofdTi9IccUR33sLRGghi4i0NfYDPNIqua/nHQ4k/JZE6NdvRLfPjcjzFf0UixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVyO6p3THBEdpg71tAu/mvRTYtcQze6lRLEq/wqk/xE=;
 b=Eg4acNsZk1m1vNUnUMLw03bSdcwFhIRNbpH1NLllPUtM2eQbFUoflutzxETGJVr6QO1V8v33Zix27wwJXeSbDF78BzKe4WTcZRWrFUbQ++SN9vEGGjdzmVqJY/8iYyIKcfZSJEXJtkRi2UsKEKeCnM+n7bW82cGiGGdjZhk/yiTY5Ga9q9kTgf680Vo3JzVJuvoSgbDON3YWg4xGZrAxkuXMEx4Mjtz/NxnKb8nB3N/wxwhXcWOQ8H30OJpLGd38huLZ6IIvRzZLQTNJVuFVJllAa/uxvBVkTQni0bw+RncTTQNN8KPAJfz0zAi5EUj+WxzR1y2iud46LwAj7xOCgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVyO6p3THBEdpg71tAu/mvRTYtcQze6lRLEq/wqk/xE=;
 b=Z9NkscsYRJVF9ug61yqXN8D3f0brAehMeFsOA9cwDU+xm56BwI2BUhlPRDXuyGQe79wGq74Wmtzd1ebCST+ghmgh6OXOCNEjwgSFOpXkuOSbQs41CU/dTa+l9n9WJDxY9Sv8FYKwfcFxuRBV5UtOaORvUAQFcMbkdhoeyMh6USOiZmRJSjxwg550zLavUCtpGiV5yonAh00FTauoWMK7IlxFTyVMUoafPpQtHCmw3GwiOjexfGBQ8Qg0lEn6HXzSkhq2hj+REgsfbHgyiEstxlx+cGViPXgp8Kr7XM0XpgKJBQyFmM9ODDRXAecviseBpw5/Peav+9eTFL4YdNwgvQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PR3PR04MB7418.eurprd04.prod.outlook.com (2603:10a6:102:8b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 16:52:00 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 16:52:00 +0000
Date: Tue, 17 Nov 2026 10:51:47 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Peng Fan <peng.fan@linux.dev>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
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
Subject: Re: [PATCH v6 0/9] dmaengine: add DMA channel bus and fsl-edma
 per-channel IOMMU support
Message-ID: <avyGI6QmuZ3DUqc9@SMW015318>
References: <20261112-edma-iommu-v3-v6-0-b038edb8ce6f@nxp.com>
 <20261116193021.GB2452510@ziepe.ca>
 <avwQl18smAW4R6ec@fedora>
 <20261117130005.GC2606445@ziepe.ca>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117130005.GC2606445@ziepe.ca>
X-ClientProxiedBy: PH8PR02CA0033.namprd02.prod.outlook.com
 (2603:10b6:510:2da::6) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PR3PR04MB7418:EE_
X-MS-Office365-Filtering-Correlation-Id: 870379bf-55ad-4163-055d-08df44cb1921
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|19092799006|7416014|376014|1800799024|22082099003|18002099003|11063799006|4143699003|56012099006|261022075727099003|261026121527099003|261028144727099003|10067099003|261021123027099003|261026140227099003|261009223027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	SazQsnZKPFNZdqw7ek1CuWN+pYYD1Doq79Bd/iNYBym5lJAH1RHVt30CG6LGMzqtaTCrrGhnrP44yRl15x1yS+Nfqy2+Q/biVxURoNE0NatfS7b/01Wg5wvPwFeDjzWFaRFszLC8sfJBRaJyjk0hd8q15SvUYh5WLbm36ynz7khpZFcyh2J5kMnjtNSAErAXTfhpKoqzzwsQYuUhxNOM7J6fQYg04/B1Z8VSN7dSxENIj7VdOAwGlvlwNiQAzWKpEfAf/MF5QVzEeUjX5LL56SwCXKh8EhuGXSP5Ny7FGrINvw5hsls32mxFw/EFO0Q2ztGUk2xSYeyzzn83VLfl2JF9D2IeoI14nFLwUHuEtkQy2McS4j1AEKABfUu+9nxc+F4DVu7pzcjldp5PPqtzITZ7APER/6EnRVE3oFScUP27bZiUP6tUUVQzliRf4ZHVvVU40gpiJI/zG0fWBu+iGCsIxV7Ohii870e7BlhqVeri7bC9h4glpbZVPCGdhoR0PL5Po5RyYP2F22nIOzDBNiaFDSm7gI5wprtauiPX58zieYWMezYFuB7j1sCt9Gjo6M6uSdrnTh+ajsU0HRMSHg9wQle9nG3Ob6cJIpcHzLJMAf3Waqko2ZpGTTPlZjNE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(19092799006)(7416014)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(261022075727099003)(261026121527099003)(261028144727099003)(10067099003)(261021123027099003)(261026140227099003)(261009223027099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MeWH8g4nZGQLSHfaoCHVd1zh3gtQsafT313wXN2wqFivdHKSqZS/jkam4iJz?=
 =?us-ascii?Q?Y00M0JLAQQauExAnIgzVFbvcBGYKmKpGMrMxjqkfALQ76slKFTKkhZJlBQlI?=
 =?us-ascii?Q?ekjOmCAzpVNW3Wn0IuSpvgqeMs5Ax9zHBeBrmuif4D0QXsbYu89wURu9fTcf?=
 =?us-ascii?Q?7BsvyuGT03r6rH+eHrN+43TIB1eUQKv4HFkunqO4P6G8XILzpgCyfIdJwEWV?=
 =?us-ascii?Q?rsrXPkQYuWKCNbTFGIXusD9W8o0yYTFI8He7GKRP4Xp/B2cRNwpcyBh3Ek+2?=
 =?us-ascii?Q?EOxr2DBSCqk/kmv1lJ35MRDNkyDo1HeU+0HKmhsPKroOzdi3Y7aYSD0NCY2t?=
 =?us-ascii?Q?ZynHGvRoueIF3Zc4Bj0B2l80uzJ5RWIf7jjZlHA33I21ihKS4A9WQl/VasHX?=
 =?us-ascii?Q?MIqc9PCX9uzPU3PePi8L2Pl8TruNzsYmOGGweYpOMxtrInunDuiaO0oaBS0n?=
 =?us-ascii?Q?EEsdCXA7bjji/5DHLJB6ejaqhD84FMXUTbW3Hv6KhFukpTNODX5H2KmyUxxQ?=
 =?us-ascii?Q?i+ACJ0fvIUxGHBZMgIuooZY8+2EYToXh/9iYyjDleiNe8ETA7sGjvIwFWqB6?=
 =?us-ascii?Q?383QCWgJqgFYIAvWCn71PsRFqXmqDizAB7a7T0C6HCgkhk92KiQQsEY3ytwc?=
 =?us-ascii?Q?fpC2DDjnsFC4LGRz7N+vqT5GRpVyAub8ZH4FM/23nO+wE0uxw/LGjpFa8OVy?=
 =?us-ascii?Q?jskcgbSG3rNjQVM3xQM5i6g7LqrVbPqGmEfmYK2OMoaEhu/8wcPVowj1Gws3?=
 =?us-ascii?Q?e1R4z6BiE+G0G7tsnlc89gqUt2HuzuWNq5Uj+mc5W12iEGqQ5Y7ZO9fAgbvf?=
 =?us-ascii?Q?nJ8rMVxSHNfAb3QlFUzPkcrV0YYAJinhZ/IDsctdt/eRtmCX4mzpGW5xu2RX?=
 =?us-ascii?Q?M5Y1hupHhI48JrLVNrqQiRfXCmX2dKsb2a2zUTO4FicWFrCnOIeazUyh4sFm?=
 =?us-ascii?Q?Ql4sz9aCGXsLnTKF7DbxkD9rwh84oBqQihNLvivdRYZfkk41uX6o7kF8e6Fj?=
 =?us-ascii?Q?n8dlEvh7x0uAD+1n9JHvNI+pNkkT9LvorUA5eqNyiA9pTQi4kQ2zPG35FXeT?=
 =?us-ascii?Q?IUC5Uj6YaMA4hUx1AuSBYuDHV9J9BRX+zaQH+oS/gsKR6DgDDjIegAJAifdm?=
 =?us-ascii?Q?rkLGL38QgcSjR1Hz9GG9psY/ZDxYCUYmWgH1R2PxRBoEG0HdQLypTypFsEDm?=
 =?us-ascii?Q?3q7JIYw9U0SDAlz9GsEleoh0nrlMMFn5TUNqDiqIrnrhZiMlTtFHQLRdcAcD?=
 =?us-ascii?Q?jIT+cnQl4+4gMoJKzbo6O6NBFU3QyvZfwlztjy3hTiKSpoP/cH8oi2gGbEJl?=
 =?us-ascii?Q?330ITKeCOv6J5sSM1hEt7nYQwAi0FpN/tg3IwnAnrf6oN08gjNmp5bOcqR/4?=
 =?us-ascii?Q?65EafpfRx+yfSlp54ILL4p3ALtjXS8jXu4sdiTDMwwgf2SE/XgB8ZdxyD6ju?=
 =?us-ascii?Q?Pv0DH5b/x7MZdrEbWkoSdsV6yj6ItaF48GYUUoal9uJgs1LpeOG6zSDX2QAe?=
 =?us-ascii?Q?Flp9hUopU5Wuh4D6VFU/xNYBvTEEGgdRlzESbTbw5QH2sIIOC29fRFJCSHX0?=
 =?us-ascii?Q?0OPkAnY4e1IKu8dt4B7BhrX7Du2WfrERx3J8t+N6XfeD+q8kbdJPfGEOdqDu?=
 =?us-ascii?Q?mLyKrX1oWchsMT6S32Ebf9jeOYqsPij3AVDWKzsotrFqamRlTFu2Z4upEH/h?=
 =?us-ascii?Q?RcoTeGLYla7X7rHcZVLHvPtrf3pjM283Lx0iqlr1Ow+imV/nzHPr9hX0CqXe?=
 =?us-ascii?Q?sBl9jXVpR1pfeFTgdsprJ5Gn7Zu+6n6RXehH8l7enXH1aADJU4vi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 870379bf-55ad-4163-055d-08df44cb1921
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 16:52:00.2739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PfEMMDNhmuDH+xggEhbSqf9/onhTgWgB261YnKlVPYC2bdB94VtD6I7a5ebTHQOym2H1qgFc++r7sSoOioBmeGJVCw1FGyle3WSHXMqvuuA34SJWbdF/5QQLSmkBQNE2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7418

On Tue, Nov 17, 2026 at 09:00:05AM -0400, Jason Gunthorpe wrote:
> [You don't often get email from jgg@ziepe.ca. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Tue, Nov 17, 2026 at 04:30:15PM +0800, Peng Fan wrote:
> > On Mon, Nov 16, 2026 at 03:30:21PM -0400, Jason Gunthorpe wrote:
> > >On Thu, Nov 12, 2026 at 03:53:03PM +0800, Peng Fan (OSS) wrote:
> > >> I used iommu-map for eDMA, but iommu experts rejected it:
> > >> "Using iommu-map to describe synthetic dma_chan_dev devices that the
> > >> kernel creates is the same kind of DT abuse from over here:"
> > >> More info: https://lore.kernel.org/all/20260917144804.GI3196566@ziepe.ca/
> > >>
> > >> So I followed here [2] as Krzysztof wrote for QCOM VPU:
> > >> "Thanks Jason for context and detailed arguments. Robin did not chime in
> > >> yet, but from what I understood the DT-child-node approach will be the
> > >> way we should go here.
> > >>
> > >> I accept above point of view and I am fine with this, thus Vishnu and
> > >> Vikash - please go ahead with DT-child-node solution we had some time ago."
> > >> [2] https://lore.kernel.org/linux-iommu/c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.org/
> > >>
> > >> This series adds per-channel DT child node support to fsl-edma and, as a
> > >> prerequisite, introduces a proper bus for DMA channel devices.
> > >
> > >To be fair this is discouraged too, now that I've seen 3-4 people
> > >trying to do exactly the same thing I'm not as positive about the
> > >DT-child-node hack.
> >
> > I may not describe it clear in cover-letter.
> >
> > I understand the concern. Let me explain why I believe it is justified here
> > rather than a hack.
> >
> > On i.MX eDMA each channel has its own interrupt, its own register region,
> > and on i.MX8QM even its own power domain. Each channel may also have its
> > own Stream ID, or share one when SIDs are scarce. These are genuine
> > per-channel hardware resources, not software fiction.
> >
> > In dmaengine each channel is already modeled as a channel device (see
> > dmaengine_chan_dev()), and this series puts those devices on a real bus
> > (dmaengine_chan_bus_type) as a prerequisite. The DT child node simply
> > describes that existing device, so its reg/interrupts/power-domains/iommus
> > are attached per channel instead of as index-matched flat lists on the
> > controller.
>
> If they are real devices then why can't they come out as platform
> devices?

It cause complex when consumer to bindle channel dynmatically.

for example:

consumer_A
{
	dmas = <&dma_provider ID>;
}

if each channel is platform devices,

consumer_A
{
        dmas = <&dma_provider_chan0 ID>;
}

Consumer_A will have to bindle to chan0. Actually, dma engine support bind
to any free channel. It will be problem when there are not enough channels
for all peripheral.


>
> I think you are overstating how independent they are. Many single
> devices have per "channel" resources like MMIO and IRQs. That's
> totally normal. It doesn't make the sub resources independent devices.
>
> AFAICT what you have here is some HW designer used SID where they
> should have used SSID and you are trying to hack DT to make that
> usable because Linux does not support a SID as SSID model today.
>
> Again, since this is the 3rd - 4th case like this, it seems like a
> popular hardware choice and we should try to do better to make Linux
> support if we can.

What's your prefer?

Frank

>
> Jason
