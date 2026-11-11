Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794418883;
	b=L8weKC6/FIhlF8wuXgD5F9uPhfnSuJuejT1AMxh/pUoQ3Y7sy9fjReeKpyTc8ksMU6PX
	 +vDMFU5v4F5EF7H5+u3RybwQmxUAXJEsPAfjC6j1aG7jPLRfuxUVV7S5mjceu6HzZUkOY
	 xdB6h4bM0xsJVQ3zS+GjmRCgWVeEZlfLqLPiYYSPAd70qh8snfHqQiLY6CrW1853ToDYC
	 9yKRolgPpGL/sVaMQqzzYdBHA/NSN52FksbaLx+DTNEOoXKENMejYMr6lpoJ8HSPm91bx
	 FZMtoSEvVXGHLgVyTlk+wY1f5IT1nuUmKkgY1JUCSbUDUBkwNKZg1w+npb36ZJUgoHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418883;
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
	bh=oG9ha2LWQs56fcnZA/Rb6MMdlE844LZCFuTGodZCilk=;
	b=HaSHREtn/xD190skOD4q/geICSKhCJD3d/PlrAnnGgRSx+zoygv7FMy+k0cuHNAQqunz
	 Q8RFJhTw0P+RTCqr8YM6Ha4UhqAwOeYp6EfeMKUcK3uJkp12NbNOP7WWteqoJbDN0dPil
	 TfxQHNphLk/ur/J9qirhKXddZBReMRhkdB0gIm/37w7VeMBohtjPUioVL/0nBKVelZaUt
	 v2PUF+DvGUVwFkiG9CUCCmB4E76Q1+Kd9kjqDATpkytu25UVTrMO7Vz0Y22ZyRnp+R3m5
	 o2Hxh0WVmJcDn3F6XeaKDg8Wz8G6oQqCKr8HDz5vyXMZQSpcq20fcwYBMBwdMs0B/Bg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=p2U4fYQ2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.70
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013070.outbound.protection.outlook.com [52.101.83.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9A2606A32E;
	Wed, 11 Nov 2026 17:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C9A2606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=p2U4fYQ2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rDLTHc+X0L6ew/FNt24cDJ2em1vg+J/ZPctwY8GYcR72ZtwPw605Js+LTohUH6dmOjsBBGAGziE0oUS8D2IrNg5DnKRlV5+nyk5wSq6BnrPpI7zdp/66iHGyK0L3B0ZfIL+aCIKO5U/H4zy647WKMG4+uoNWcXf8FolLoskAE7qMIdP5cShFZ8qG9GAIfZIUzsjPJkK9rxezed0RVOvqYjofwTDEX8YWlj3UU0882KVU9aGpMTSJI6QlTZ1l9wNXtxOVdEnc6IYNq3EEWjM1+oCER2ai6OuzGlBzyoqfjhlrkZw37scO98rMKEDvAXlDA8G5HN5P8rUZkul9CyaJCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oG9ha2LWQs56fcnZA/Rb6MMdlE844LZCFuTGodZCilk=;
 b=OsqEJBh40wMP1V8eKdNbEHXKpLecNWn0mgiuaVfk1PMp2iXyghe7WSML9LYV53W4BxRknu8OeueQDGc0a1c1MOgwtqWu0vishlvAfF+UBVttWo4QKzlvvOom5GL9DhZf/TxS001h6T5xVRoTOegQ8a6+zINJTV8Xgn+6ywJfPysdUu18ZqV2OBUcnSteLyasMGNrd3s8DPSJaVtSAbTB4+44hnUEw4+3Cs0rI/iAJ9tSlf0ruBpByXLLNfiWvEOXHwv2sxvBvdXXqfM2jWN/govwVhw+phHoAl0JxBTyrR+krJWwrOfYjztBoomn99OdOfw7Hd7vd17an2A0wpki8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oG9ha2LWQs56fcnZA/Rb6MMdlE844LZCFuTGodZCilk=;
 b=p2U4fYQ2EjYxEz9szbtC2t7CPpU7dwwYjx7jerpHv8jAlYKNBnmlr9Iu396P/EByw4bW2yDVH9ZH8pGmOjDGjOlIIATR38bag42FEXlBuMiiPv4OdtDXyN97/kUblh8vZ93r47RcT7ZqpZm/I0nv9Zw1DceRu3KbZnoOvPKSnwBiEhZ62BaOXdQE1XtMDX5QWGAMcVvT9x3C82Cc712Q3yczjBjjkBg/tiTlxgGBmD4m8NaKCdrzZAG8mC7takDJhXqFQfsn7K5kWLzpYYyitKzrHPW2DBFg1cYjq3w8pb4jhxc+92ala/L5J0KkB4waFeCdz21Il+uTXvbx/h56DA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM0PR04MB949883.eurprd04.prod.outlook.com (2603:10a6:20b:7fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 17:41:19 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 17:41:19 +0000
Date: Wed, 11 Nov 2026 11:41:07 -0600
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
Subject: Re: [PATCH v5 4/7] dmaengine: move channel devices to the DMA
 channel bus
Message-ID: <avSos6SCYMYZrwX3@SMW015318>
References: <20261111-edma-iommu-v3-v5-0-2537cebe6ca2@nxp.com>
 <20261111-edma-iommu-v3-v5-4-2537cebe6ca2@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111-edma-iommu-v3-v5-4-2537cebe6ca2@nxp.com>
X-ClientProxiedBy: PH8PR02CA0032.namprd02.prod.outlook.com
 (2603:10b6:510:2da::11) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM0PR04MB949883:EE_
X-MS-Office365-Filtering-Correlation-Id: 9264cf61-cacb-44b3-1c9f-08df401afe9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|366016|1800799024|376014|7416014|261028144727099003|261026121527099003|261026140227099003|261102123227099003|261021121427099003|261022105027099003|261022075727099003|4143699003|11063799006|261021123027099003|56012099006|10067099003|22082099003|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	ZP6Ib/GPJKO8EWD6Vw3iZH+eiz8iWx8dDG27xKAxZgyi+algbJgzOzg3qb6pTFalozBtZPQZ7hyv6zGa7J9jmB/+wzW6Y1A6Hu+cJA6uDOLyqWARiKP+j6W0JaXaSuWWVN2X/7qWAgKPC+SacqqlYNFFmh5decQGwIiE5MikOZzYnKhBdCn/yaCr2gxDRsVgcfcZDgNlrMzAJDwh/rNEwDuacdVeXX/wj/7ihdkV1SpDfAyfGHxkyGxQwTvW7RcBqwQ7RNk0r6BJc1QxPHvvkLmoEqbxXO1vKyfdzk8OPZvdVzwV6k9taKusRKU0YIzx1RpXlwZWH1q3uQAPoAoe/s3tSBycziprFHqbsCs+FfZiqz+P4f37GSChn9VTkwLiirfM3DgdUKxHHaR0cQbTxAiaDXsWOz1zTmQLylNPwkkm2t34Evz9HCKcm4LEY5jfWbQGPzuwt1VktvOVmQs/YjHovMWuzHgtlyu/q+fDAKmx62oHBQf58KmbUbWmqvisICSFAossW0ZBswlekHiwKS+dfrenHRnKS9XkLtPIK6qQdxInxDfh4156WN7RW2XZ+5hF243lKY3UFfEbcgANuMIQ213a6yLgbsINg0fo7M37fPSVuXIbIm93XegBkz6wR+Ll2zrqN/uH6ZyGXHLdEo5cFIUr4YfrsgvpZW/ibPc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(366016)(1800799024)(376014)(7416014)(261028144727099003)(261026121527099003)(261026140227099003)(261102123227099003)(261021121427099003)(261022105027099003)(261022075727099003)(4143699003)(11063799006)(261021123027099003)(56012099006)(10067099003)(22082099003)(18002099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RIQUG3Ph2UH352Jdwnwq1Ee+Dz2v6CAhwPPNnlcf7EnfslmlxnwsM/dyuc2m?=
 =?us-ascii?Q?vhAS92wSNDcjo3vYQlw+pDVr4rWMI87J8RqtLyTXNJ6mD+845hJxejIV66/c?=
 =?us-ascii?Q?mgu2t7VxqxSHZBE+U0fPBMDtdVDnUPC8wbysgstLJfU5/Pq/qEZ3t2ko2yhZ?=
 =?us-ascii?Q?yDOr+/8kHRxwu1JUfqmqTrQtM77gr0fvcJ1rLfrgE6LMkqv19xsIbcsA7ZTQ?=
 =?us-ascii?Q?+17DgtdFLKxW3TlTEw3UmqQLxh7iagNJip+nlurxIYVmSO9XQD8Kk3c2O5CC?=
 =?us-ascii?Q?p/8hHwgeg41hXpJXdXRQfn46k4weubRGzBf2am+KJIQqsrPwOmLG2/zcHRVX?=
 =?us-ascii?Q?m7qKxjWj0pkX3QfRq/ppHlE+1WSp2V4teB8YZ2+lUiCyHGHcEnS5bhgviKr3?=
 =?us-ascii?Q?LSqALXt813w5oFEc+rEyvzHr0EOncMFY0nsffhJ9SsFDwXi1yQM10aajgFHn?=
 =?us-ascii?Q?y8sQ9l4IctyELvFb5NfXaAt9rtCvvYpgu8kRbxLABkXsTgbYibyLz6qChxcW?=
 =?us-ascii?Q?EicWb82thSCuV4VIK78I4qsLj7bPntn8/LvtzO6vE2tYjOJchg64eYL+WKad?=
 =?us-ascii?Q?7IKMNs+IXLMHi6igrYdz6eEkY/0i1edLMXQhbwEST2UvoeJEl2cb47tFN4lb?=
 =?us-ascii?Q?hWEld8UfFLdPyni+nzLYckKyjysqSVJaAHr4rW6W8Jw8dCO1dKAtwiC9T3ae?=
 =?us-ascii?Q?qDOZ5iAMIzmuVlxfjvkSYf3VZlFkfIJjj5rWKdEbhnFPj/t1r8ovcVNRACmS?=
 =?us-ascii?Q?KlLKjRo9qVaL0ZflnvlumvM8y8zSiXzQapESOoR1ppeoX+a45g5CfAfakj1k?=
 =?us-ascii?Q?yKWxURLSqbVwIXido4trZ7Rfd0ZjUIt3yppBjtsy2Y/7JQOwaYXvezmC3mh3?=
 =?us-ascii?Q?NdL7tVXG/+UWtLt+RdOH29Mi2JU3gDpaL7n6JqEabGbYcaB/45rug3YCQswJ?=
 =?us-ascii?Q?me7pDqxlOrgIZBOnhOOTOho4kK/YrAa7U6YkCIKFvrZb6nrzqdwQrW4/pbMB?=
 =?us-ascii?Q?i4co/j/hu7Y1TL5OkbqVGP3OaVfeFCid1UPsMNx8cOZc0gi2ahnOXlaV0iko?=
 =?us-ascii?Q?ODUv3d0c4m7zvoo31fcgXNEscsPdjubJ9SE3qAtpqBPmxtD4pv/jZBbB5ZaJ?=
 =?us-ascii?Q?SMkSDk21+The0NsM2Dcoj7IShPvfPF+jcc8AYAuHOezaa7M7kOEkZVYiuIbW?=
 =?us-ascii?Q?b7ZMnuEheg/3ez676jFicAZ3av+vLySOU79n18smFJg7eQ/jyJThxk4ScUXY?=
 =?us-ascii?Q?gG9rZQyPmv5lSBCXGoibQVbL70HalduqQu3Y8RRP8dqw6TlRdvTdhYoHUR7m?=
 =?us-ascii?Q?MVdcfBrYSt5lOXAcsLceFY6hI24brgzExZY9ccLSBsA/jvkydzyPW0+qU6Fd?=
 =?us-ascii?Q?Bhxt3r+MumCAZz1lYSW7eWPyn/TrEvV28N7nSSQn14+Rom4FYYbwaCe51nN+?=
 =?us-ascii?Q?VyE9Hdd3xx2USYySlfnYB/xgQLNOh46ziL97EHeuyQKD8+9gzWIod+jRZdiC?=
 =?us-ascii?Q?Us34RCOlq6+Q9eD5VyXdDQ8v7qkQtEFes/jTQYfjC38XmaB2O1iWfFxawKMa?=
 =?us-ascii?Q?sog6n69zfokO4GFYyMu+YL2ZtZ4K7aeYwqFCy7c9JSNfcC0OXAofhgflUOFG?=
 =?us-ascii?Q?Hhh9cZlcl9OCtRRWraDZBl6LN9VQhNKSG+CKH7obCYm6m4zClDhW6MeAUSzp?=
 =?us-ascii?Q?GxIM9DDS5oKzCPcvxKbLyWrFyLujvMv4v92h7LxqDbEYuzWyXb06M+NNc0Pk?=
 =?us-ascii?Q?AZq8D0QcvziHdSLsVB2MESLbnwTNaaXuwI7SjpB1z3MsWHMV1BjA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9264cf61-cacb-44b3-1c9f-08df401afe9d
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 17:41:19.6983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UOz8qB9mgaQ7cRWpO6aQjQAEAwTxwmdfAg7ngxwIs/Tdcau6A9XaqOQ6atsSS3ZeSUsSoCrzaSi1ZNHFXY5UgE2PQa7MYh/mDxZgWXDcRdV9bJjfrZGbeZl6JcYVN9I5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB949883

On Wed, Nov 11, 2026 at 09:47:32PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> Register each dma_chan_dev on dma_chan_bus_type before device_register()
> and make it a bus device instead of a class device. Setting the bus
> before registration lets bus_add_device() take the bus subsystem
> reference, so the matching bus_remove_device() calls drop references that
> were actually acquired. Attach dma_dev_groups to the bus and set the
> device release callback directly.
>
> Keep the existing /sys/class/dma interface by registering a class_compat
> named "dma" and creating a link for each channel device. The channel
> devices now live on the DMA bus, while /sys/class/dma/dmaNchanM remains
> available to userspace.
>
> The bus is named "dma-chan" rather than "dma" to avoid colliding with the

dmaengine-chan

> SuperH DMA bus, which is also named "dma" and is registered later from a
> postcore_initcall. As a result the device's uevent SUBSYSTEM and
> "subsystem" link use "dma-chan", while /sys/class/dma is unchanged.
>
> Remove the post-registration dev->bus assignment from the Tegra GPC DMA
> driver. Leaving it in place would overwrite the bus selected by the DMA
> engine core and reintroduce the reference imbalance.
>
> The DMA channel bus match callback never matches, so no driver can bind
> to these channel devices.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/dma/dmaengine.c        | 27 +++++++++++++++++----------
>  drivers/dma/tegra186-gpc-dma.c |  1 -
>  2 files changed, 17 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 9a9d54d8f7c6..36f5a12641cd 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -239,11 +239,7 @@ static void chan_dev_release(struct device *dev)
>  	kfree(chan_dev);
>  }
>
> -static struct class dma_devclass = {
> -	.name		= "dma",
> -	.dev_groups	= dma_dev_groups,
> -	.dev_release	= chan_dev_release,
> -};
> +static struct class_compat *dma_chan_class;
>
>  /* --- client and device registration --- */
>
> @@ -1115,8 +1111,9 @@ static int __dma_async_device_channel_register(struct dma_device *device,
>  		goto err_free_dev;
>  	}
>
> -	dmaengine_chan_dev(chan)->class = &dma_devclass;
>  	dmaengine_chan_dev(chan)->parent = device->dev;
> +	dmaengine_chan_dev(chan)->bus = &dma_chan_bus_type;
> +	dmaengine_chan_dev(chan)->release = chan_dev_release;
>  	chan->chan_dev->chan = chan;
>  	chan->chan_dev->dev_id = device->dev_id;
>  	spin_lock_init(&chan->lock);
> @@ -1128,6 +1125,11 @@ static int __dma_async_device_channel_register(struct dma_device *device,
>  	rc = device_register(dmaengine_chan_dev(chan));
>  	if (rc)
>  		goto err_out_ida;
> +
> +	rc = class_compat_create_link(dma_chan_class, dmaengine_chan_dev(chan));
> +	if (rc)
> +		dev_warn(device->dev, "Failed to create compatibility class link\n");
> +
>  	chan->client_count = 0;
>  	device->chancnt++;
>
> @@ -1172,6 +1174,7 @@ static void __dma_async_device_channel_unregister(struct dma_device *device,
>  	chan->chan_dev->chan = NULL;
>  	mutex_unlock(&dma_list_mutex);
>  	ida_free(&device->chan_ida, chan->chan_id);
> +	class_compat_remove_link(dma_chan_class, dmaengine_chan_dev(chan));
>  	device_unregister(dmaengine_chan_dev(chan));
>  	free_percpu(chan->local);
>  }
> @@ -1306,6 +1309,7 @@ int dma_async_device_register(struct dma_device *device)
>  		mutex_lock(&dma_list_mutex);
>  		chan->chan_dev->chan = NULL;
>  		mutex_unlock(&dma_list_mutex);
> +		class_compat_remove_link(dma_chan_class, dmaengine_chan_dev(chan));
>  		device_unregister(dmaengine_chan_dev(chan));
>  		free_percpu(chan->local);
>  	}
> @@ -1650,8 +1654,9 @@ static int dma_chan_bus_match(struct device *dev,
>  }
>
>  const struct bus_type dma_chan_bus_type = {
> -	.name  = "dma-chan",
> -	.match = dma_chan_bus_match,
> +	.name		= "dma-chan",
> +	.match		= dma_chan_bus_match,

don't change format, origial code style is correct.


Frank

> +	.dev_groups	= dma_dev_groups,
>  };
>
>  static int __init dma_bus_init(void)
> @@ -1665,9 +1670,11 @@ static int __init dma_bus_init(void)
>  	if (err)
>  		goto err_destroy_unmap_pool;
>
> -	err = class_register(&dma_devclass);
> -	if (err)
> +	dma_chan_class = class_compat_register("dma");
> +	if (!dma_chan_class) {
> +		err = -ENOMEM;
>  		goto err_unregister_bus;
> +	}
>
>  	dmaengine_debugfs_init();
>  	return 0;
> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
> index ec12b7288b43..93b136f875d4 100644
> --- a/drivers/dma/tegra186-gpc-dma.c
> +++ b/drivers/dma/tegra186-gpc-dma.c
> @@ -1540,7 +1540,6 @@ static int tegra_dma_probe(struct platform_device *pdev)
>  		tdc = to_tegra_dma_chan(chan);
>
>  		if (use_iommu_map) {
> -			chdev->bus = pdev->dev.bus;
>  			dma_coerce_mask_and_coherent(chdev, DMA_BIT_MASK(cdata->addr_bits));
>
>  			ret = of_dma_configure_id(chdev, pdev->dev.of_node,
>
> --
> 2.34.1
>
