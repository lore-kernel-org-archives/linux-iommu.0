Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794933624;
	b=WCsi+ZB333gV3Fj6jGAsSE2ERt1PLI5VG/rORP6GVi6LboRgYlmNjxRZkWmDMifgruxU
	 UWDo/4wbHExKt9a11H8NRzG3Fze4NB+HyFqeanrhOdr2zUp9S37Sc7tq7IpGUhEm9Qc1M
	 K19UyNd9lvLdrGvew6FNDTFGNtB37gXYb5zrmn3QmbaGukXkPLYpusxnN7Fpz71RZEVWt
	 niK0H0F0Fst0tRf6icvrDHQM6UKU1+iZzghYxQJ59JCBC3OSpqcpHxFENBWP7YsoI2cgF
	 uOhFIaJU7MbYrf4PmdAIPm/AkWYTHa2G3I/oUp83ZhVdU/FVQkLREL6LiQ0aqgurzow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933624;
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
	bh=M727wGkLTtjAZnjOX2TNbeV+MnJ9WDQlWKzRHPAV2Bs=;
	b=CLwF8gkg8SsYl3/8mOzqB6eP0jcC0gCMx854Wb2jtWkH4THudMfxcN2QM+3n1Sc4Bra3
	 EEfk+6pkqEBdvEWMFabb5bD+LaNYMiD327G6ae1lraDpZPgpH5G2Kq8nqer9BwSHb4Jvb
	 2KTe7sM7Y3FRjLn2KCA3xuvoFR/r94Ba2GXIafCxE3dbIXAKtYCagKp3oUVcDfasrOv95
	 gYPVWt9KmLtl3ljXvcq1ZZU7OZMKlG8ojRUtx9Ceq++dN7qWx+pRGs2RY/F/8kITMClFM
	 zAh7T6XY/xAX3LrwpaTLGXZdp+uEQvpzhw68hR1vmFSw1O7x/xplMHFn8qqUM4V9MvQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=b7O9dP4g;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.48
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010048.outbound.protection.outlook.com [52.101.69.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A326606A31C;
	Tue, 17 Nov 2026 16:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A326606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=b7O9dP4g
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APbUymgVH9GuhIot43wWl8w2dWdYodK832W1UpM4eDz82w4vRwI+b+gVr3SdhRXyzfxzYlvhx2LXbStGR0imlc0LLycPx4Jh3h97JaKOfe17h9b2Lh6YT8/l97X5drs9PVQ1Xg0Whf/5yk4jGrB57jPh/0CAnjR8NgM0LGZjB0n3ZvqI1YyG1NZt9Q85DhAkhHW8tIu2ooo5veEEQxyoxuT0zrKRpA2kqoQTDi47+UyEXQP7fUARwwxYzYVbLtzIeCbpLbIpdiX63W3QdDBaiibsBP+RgWGQQcVhKbaqGuHqAu9cc/lKnLOZHHpsoH/Dn/kzx4AtYO12NvSBmVspVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M727wGkLTtjAZnjOX2TNbeV+MnJ9WDQlWKzRHPAV2Bs=;
 b=rgnljJjdqANjkOdEAtnsjsvfWpNUI2y2QmvKyoGVOX+cvgDp2SQ1iV+qTR8Ey72qzk4CQS70PphmLwSQ89JvJPIWp5Zl8u9LdVi44e7se+GrydjIoMtYodv2ludYUQvDZ1ko4haOvl4txfWV5xvNz5ZamqbKia4PbJj3dh4gKoeZQPLzjBMlS1AaZkjryErt8aHmTZMBUgP45VRprUkM9lT+87LQQn8z4lLvWb79nIAkcDgVtofsUp4AKiTDL8ToGT89LQHbZo2VwrUU3xz0N+nNG2Z04aLlqcEgOEWEHmKhgFxHAh+IygiRxnVJ8DegNfWBfB1LyGbgeX7wPVfOvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M727wGkLTtjAZnjOX2TNbeV+MnJ9WDQlWKzRHPAV2Bs=;
 b=b7O9dP4g8frz1JXvQKD4u31NDdFfVIsupWJCftxF54MUkd82JN/b3p+SnFpU85X65h9Fj98MkUXwmVa/GoygjGpbgqUwJwQY1RKFB8r/a+Gnk3MeFyzD6JINd4C3TCmwLM3PB7OvmHb9DeP/GLMOC1xnsIK8SITI5/qymlSLiCJGUK5lepsiRP7i6UlCjx741IDlCkPPRH6lzvHYq4s8DqhNYU93hMb9dMWURhr93vLgX/OfobeSpCeq1VK2ngojaxNF2BmRpNDnKiATZRHJ+f+ts2PNES6eOT078LgAmbvwv9s6+lYbTFBd9Q3E1MfxaFiAIJr2mSoGPazC55g9dA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM0PR04MB7155.eurprd04.prod.outlook.com (2603:10a6:208:194::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 16:40:21 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 16:40:21 +0000
Date: Tue, 17 Nov 2026 10:40:09 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
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
Message-ID: <avyDaU3oLRCMWDcz@SMW015318>
References: <20261112-edma-iommu-v3-v6-0-b038edb8ce6f@nxp.com>
 <20261116193021.GB2452510@ziepe.ca>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116193021.GB2452510@ziepe.ca>
X-ClientProxiedBy: PH0PR07CA0074.namprd07.prod.outlook.com
 (2603:10b6:510:f::19) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM0PR04MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: 774711b6-c958-4b5d-497e-08df44c97877
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|23010399003|7416014|366016|22082099003|18002099003|261009223027099003|11063799006|56012099006|10067099003|4143699003|261028144727099003|261026121527099003|261026140227099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	EFa23NMftRsM7EaJRlWoJ4fiiURk1YfKi0LdmErb48GBBu1rBjMmxjAw0dwf0EFgkPeYQ8koVBiAVnm7Nnl7e8gEWWGB5hHxagrQP8GLccXQIJ53GC4mgrm8yHIacWOk6/YDJArPu/7kcIMyf7HAKmUeNTPojUjU4O4cN4z/plUQo+17e7tn7fklungvniH7XDKEuBKh14gsaX9MOCQFTdIYF1SBtoi913OIidLlRJOw0QPIwFR+NBecYvGeHF/ggoIjc9+c627/wIL9MM7xka8BZ7mLN0fJ0u/kcI9fWBXHYANPhkg7whADTWKSLopF8wAbdObONbKH3hYqDMgcyk5d8lHFI8eEfEQ5m5chocRXNZcLV/fTMU8o3qADI/4mJa5jz/H7b7YNxjqErI6Xz/YJebmhjvbcn2A4zJOM3NAqmUv1Cr7LEBWH0eFh7S33Wj3ecufYOEL9/wRYkP3PYuJxXT8zfA3qNcdpN5J7j2GNnS8TS8ExkzCghR+8scWWI/z9P269tBpsp93jHjX2w2sdbbjaN0wlk2LlQ4TZVOsTCWkC8nhQDPpE+IURJVtyVONpzmO7wGCOeRtfU5AObPh+nsZTesku4YIssdd8s51bQ9unIaGTBlKuOeCaji4s
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(23010399003)(7416014)(366016)(22082099003)(18002099003)(261009223027099003)(11063799006)(56012099006)(10067099003)(4143699003)(261028144727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RHOPhWL/yWWQMobudAPm1Ti3BVO4fIDecWMA5HZwL3FTMJH+KkMg6zTjaBFL?=
 =?us-ascii?Q?lX0kAp2tiFTNb87/Tdh8j2VWng2WpKCsNGxRNYt4yoJQ8XHTjQJYFf2wwBcq?=
 =?us-ascii?Q?DZXI8ccBL5oG6kRyxFHEx1JLqVpzthxBPX8+vC50H0e4E69wYQCh3rTB8K5U?=
 =?us-ascii?Q?voniCHa1J+GJtQuxV7w9QgtFl9jsCYukBb+gpJMT3dtzM4NmBKlu6AwOnjYn?=
 =?us-ascii?Q?63vh2HJgit1s/AoJVc7bTXaF5UoGIpcWsni2rSVPVUcsnwvDUBGT/ML55oHL?=
 =?us-ascii?Q?lp8Z+06BEoNy28dVWFsHx5QSzv3ld2fUjzHf9KQmKetwAUEZ9vDIyy4aAXb1?=
 =?us-ascii?Q?8wT4zshL6VlogmGz/Mfxth7gqPI8+xegIMeYUTmL3RI6ZcPzHF79JKoMFCVX?=
 =?us-ascii?Q?m6h6HWUk9B5VIfJMbxz9glVj9/y3iVROWCxYKdFK7b6F0y6Af5+wGUmvo2lL?=
 =?us-ascii?Q?yY+PSVmeP03EZhNmcUSZLDn62qjHrZcORTxkD3a5mG/v5Oz2AT1AeS94PMj2?=
 =?us-ascii?Q?sjIj1qOruBbDLmtzm5Dd1r6WFfE9yIlmQC80lSs9ih9InWQetz/CkOn4K9fE?=
 =?us-ascii?Q?bCPeGjIqogxYM8n7xKAa9B4lOuj3KCg9opjx8ltWJF5O8pJl6hIyCGjFhj8O?=
 =?us-ascii?Q?tjZlCxPnLM5lCElxhUF0NlNLiXllFtlS4CZpvWW0HlnYgqXUMqWU2k7FCso4?=
 =?us-ascii?Q?2XOl1p+7m+xaPhuMn847sQomRYgsdJJ30x+eoZXmzUOns73FLxbBQFjRtq8+?=
 =?us-ascii?Q?Go/Kxymn5vEKP81gWDLi7U2QjVy7/zBQmZiIlUcJxnnsp3RZigP/3WvTZcg/?=
 =?us-ascii?Q?AN+k69Y4HobwiD2WC9L0PqXqitETljDV5y+kPA0a5XVDxNLtGkr7cqBbaG1h?=
 =?us-ascii?Q?aq2pQaaPyBMPZ9JR6evES5oF1Go+sAERKFeBf5dNUu+YSIWlQ9bFq3/hyyPf?=
 =?us-ascii?Q?LITKIHmtgzxpGBDfHo/4fT8P7c3OShlriwT6k/3iCE9qZSwgrV7suUXobMkF?=
 =?us-ascii?Q?NlAjdvjygm/Z9L7jyiy49cFORNk6W/fH+7Pq6SCiRnYcKO7fvcF2bKmax9NB?=
 =?us-ascii?Q?wLXxXdt554IaMvZMhlmbqPFwQAqjXtzcmmTThPfvLEXeSH7gg3ibC9qJ7tck?=
 =?us-ascii?Q?RsaTkC+qvRmcpbRmcgDTU0/N/O/t6/Sdq4g0yIvYEbCfWKZVWnCpcwCO8wY1?=
 =?us-ascii?Q?WKCyPo88nRmdLHoJZoYBiASYOzQT3Ip3dHHyhO5F5vOBBG4MiyJB1tq47Aqw?=
 =?us-ascii?Q?Yf6daUSjpjadfaLmTUEs3OGkdpq6AuVNd7D958l66rz9TqM3LmJfE0Lks3Zt?=
 =?us-ascii?Q?QBWBCiO5BHnxUf/FR60Ntrs2Kw/2gvUbCezrxxUdFnSTueW0hDn5aPs1xRqD?=
 =?us-ascii?Q?xEOQnSSocyCL4dfO7g8yKFcvo0/LWxcUen1Uv0RiOBr/aaRxSHgxhf5TDm8u?=
 =?us-ascii?Q?eOzILxM4eK4/emN8urqfLPUoFtM67OIuceMFrubn/Yw3Ze14DxBu3vtw5jeS?=
 =?us-ascii?Q?TDS9tiRKjmEGCGGSbKUq2BqFersU7psiffg/PXqEASGdaNK1AftYnlMjFEog?=
 =?us-ascii?Q?jCn7i2B73zWb+5y9jVvS9ntpcV7sMR7uNsBBDvIn+X51W/mP0eItX4puSgGT?=
 =?us-ascii?Q?ddMH6HKsN8jhIyE0dMCXeGodaI+SozV3vCqZ31lVPCvpV8uNs2Nt5Lzzp1sh?=
 =?us-ascii?Q?CQrv2N2vnqwhCwbeKTwqNv/9wfjZuRfpFpKffo/vMC3NpTIOmvHKZA6FfY5p?=
 =?us-ascii?Q?sIET0ZIiwzqAR6DXTP0gzYWbdZwYzeG4F6T0FawYzq3WT8YGqDaq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 774711b6-c958-4b5d-497e-08df44c97877
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 16:40:21.2601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b2/km7n2Wj4t3YlVn9HpdlVubuUt6f3I4wDNeZSuR0wb5tQhHOO4zSpvfswzVFcME7RSpKttJj/bL8IsYO7q6Ec+xqDEofWc2NG65BRf0Yna7Cy4GgM1rSlpNtZV69jb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7155

On Mon, Nov 16, 2026 at 03:30:21PM -0400, Jason Gunthorpe wrote:
> [You don't often get email from jgg@ziepe.ca. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Thu, Nov 12, 2026 at 03:53:03PM +0800, Peng Fan (OSS) wrote:
> > I used iommu-map for eDMA, but iommu experts rejected it:
> > "Using iommu-map to describe synthetic dma_chan_dev devices that the
> > kernel creates is the same kind of DT abuse from over here:"
> > More info: https://lore.kernel.org/all/20260917144804.GI3196566@ziepe.ca/
> >
> > So I followed here [2] as Krzysztof wrote for QCOM VPU:
> > "Thanks Jason for context and detailed arguments. Robin did not chime in
> > yet, but from what I understood the DT-child-node approach will be the
> > way we should go here.
> >
> > I accept above point of view and I am fine with this, thus Vishnu and
> > Vikash - please go ahead with DT-child-node solution we had some time ago."
> > [2] https://lore.kernel.org/linux-iommu/c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.org/
> >
> > This series adds per-channel DT child node support to fsl-edma and, as a
> > prerequisite, introduces a proper bus for DMA channel devices.
>
> To be fair this is discouraged too, now that I've seen 3-4 people
> trying to do exactly the same thing I'm not as positive about the
> DT-child-node hack.

Can you help list these thread?

>
> Can all of you come up with a proposal that doesn't involve hacking up
> DT just to unbundle the SIDs?

What's you expect? Basically two methods, one is use iommux-map, other
use child node to tell SIDs informaiton.

Frank

>
> Jason
>
