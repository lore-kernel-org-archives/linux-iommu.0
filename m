Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794502010;
	b=ixuZZQmEXeUFhN08aJL1ICA8LQRlp339TAHiPdY4flWXKW/+iEk9q/6RpQMMsiDNeGQW
	 onwx5id0m0dcMzEWFHtJMcgJNJXHpU5SHh/iV+C9ZCvErVfBTZUnnFO/2Rymzjus+aNDV
	 /I0t89wEPM2NPTgZMBYEcv4Pxg6UEQnhhGYCHIR8GoLd2TzswNXjN1VvtKNVC3JNSgTae
	 umZDroOSVkYIavswkeI1TYyrnGnWF1C+Kv0TSbtKwO2vpDWcyGsD5WLyRzZxYcKX7J9ZM
	 PP5di4cYFKgRMv2Oz9gUrwv4uMexI/I8bde+cfmerkQLSgHUrlMrrmwj9sHbYNz2ojQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794502010;
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
	bh=zuWtrs163C+i6VB3CcXv//TKbh7ZjouV8eu/fctA6hI=;
	b=YZNIQ5AZW1lq4fewiDYdZnBM5HAoPccwXd0Jt0vfzkeAAzzu9Skr7tO/Hyn6a8s8I+X4
	 J5pJluPmhaRRDZdA2AUpc5bfjTy15tta2VF+cJN1lx00JYOa1xmKCyJo32Uvz9wsv+JJF
	 fv+gaSuUxiIB6gzB9emmGQyIsXVgo8yPPE3BTyB8XUUb6LKJRI7/I7wjNlcmqp78h4VYx
	 XFB0Rk5PmTJIzuDLRrF0Pf8cgT2bXJjs85kpWXPcc6HM0eJmcVybZArCF9xWoEipao/jP
	 6S1e8NS9WDDJ5e6GGDnE/md4N5Sb0L8LAiEQXR7osmQLnE5fRHCdJOyBZqwvS3HFS8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=kobx8YkS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.2
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013002.outbound.protection.outlook.com [52.101.72.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03134606A321;
	Thu, 12 Nov 2026 16:46:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03134606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=kobx8YkS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PllXc6r838SsQRlUngtXdQ0IEa+aqjHlsZpjRY4D23abkXRnzWgK6h0S0SaPDen0Qd2eBgxHlV9uyVU8e+8vRoWbbrSchs3qaeohCINx4n8OBI3zXiJhgM49wkVF8ndBdIJ8qjuNtjhZmlCRTLabO44BY2tGmAaLTd9Ul41MCO7cHtfepiM8YhHAC7dKoyaxO9eUZKCmdhznFi/S52HT3C1Z3fxcRRNpY3kK70DJAP3s5zWcsOj5xd3D2+s28Lphg4PyB/zJgTui1FNwy3khpFrc9X2pv+6FNcKRq9Aq2B5bOJEpJ8MPK8AfW3YIRx9MpRz2T2KLOltscSVicKa0Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuWtrs163C+i6VB3CcXv//TKbh7ZjouV8eu/fctA6hI=;
 b=RhAroOK9tqHTy3635619ZbI7dXx5zJiNiMc+bfGIWFujDS+932np+aFabZLRAhiOKJz9dYgQDdjpDJ40zqGH1XohHmEF62GQ5Xv6cpYTX0OQUCmNXnfvmZ73ptnCZeql3BFxlpK1QdoYraU752xTOSPREjytmTqWLrkSR/dvmFySrD3AxyXadCnr5/nyIK++l81BknUIcTAEm6WvQriJpZUHpbY5Wj2LVLJRIxPrDY10/ZSFcAtXvswaFLcxFxv57SQGrYExChj/wjRFixgBvv0PYk85WlN9SHQk1+KV1Hbft9qcR4fksoeU0Eusvzgu75eVe/DcwV5bVioSu/7HXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuWtrs163C+i6VB3CcXv//TKbh7ZjouV8eu/fctA6hI=;
 b=kobx8YkSueu01dp4zFnity0oOMVfVN4xPUOifVGaE9P6+rG7H2dFGCPbFzcnUWJUQz4MptxhIu8y5ZB9EWuiwZzCyBPVch7KcUYoeBlzW+oqB9OaujeM9huLPlHZ8l7Xrk4Q3ZHInPr3eExYj6fpS736oat6/L1yRNc9WluBRhtQPHy+2vlrRwWrgT3RBWQMui7ofI2b1K5AaWiunPOmCgd98gn1VmvTkOs20D6sUnArmd6Yu1BKEiQnJN2n4gV5oP9/Zr/mglMSl2UBDWIDwd+lFvo977dpzZok7PkZKq1JGSspno0FfD4LzExsm9oli3fOm2yG7cJxwpMR4NtA+w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM8PR04MB7988.eurprd04.prod.outlook.com (2603:10a6:20b:24e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 16:46:46 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 16:46:46 +0000
Date: Thu, 12 Nov 2026 10:46:20 -0600
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
Subject: Re: [PATCH v6 8/9] dmaengine: fsl-edma: support per-channel DT child
 nodes
Message-ID: <avXtXBPdQcrNQ1Us@SMW015318>
References: <20261112-edma-iommu-v3-v6-0-b038edb8ce6f@nxp.com>
 <20261112-edma-iommu-v3-v6-8-b038edb8ce6f@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112-edma-iommu-v3-v6-8-b038edb8ce6f@nxp.com>
X-ClientProxiedBy: PH8P222CA0005.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::23) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM8PR04MB7988:EE_
X-MS-Office365-Filtering-Correlation-Id: ca4234b3-e156-48d8-caa8-08df40dc8a0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|19092799006|10067099003|11063799006|4143699003|56012099006|261021123027099003|261021121427099003|261022075727099003|261026140227099003|261009223027099003|261028144727099003|261026121527099003|261102123227099003|261022105027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	XNlcRG/UuHKlzJU0u8lTCgyHdNeIAcWTwGee+ya4rYSJOuSXyFk5eLsQPllswyNIfEymdW5JSaUCLCp1zhuYPJTdJSNbIu0rtDy8/NoimtGDNqmKhbYxQ5ak22VO5CcIfutrlUFw18v2azckbKR91sEILirs70fFyQZkPocO5DheteX5iNcNuMXPPupOYrhG+hdeqFXBUHlJsDymlxOLr1PPe4Z7lj55OXx0oxzB/rpPccJbdhrpWtUlcdM6Ah4e815xCaPcIZ0zJ14ZkTkmW4+y37SssFVlvBYwFUX3ctbpZiqeqH15wkUyjAsUGh7R+SOa7szq4Ws7Kia5wl7tKpzH6G/yKw++hjYerpihNVKIDB8rcD/bRh9JhSND6bASLq4+RyMAszhyvbQTdJ+ginnEgugbmK5TOPgmD9cMl0ETCQSIsZvRdJzCELjZOxLIMUj5spe0fzv9m15TtSKpJjQJJeb0BeWm+4y04/05mM92bRfayWqxvmMh2ILBgsjnDsYRoeKfgvgVdTD3yrezPrTJcEs0hLubM7owtCDpotr0bd5tnwZSMWuXj+O4t1z4BoAGDJ0/l0dmCv4aHDsWp8F5UWYuuGml/P6I9omKQLkqT+aa78/xyOdQasHcZa8zesol6AQNWLZpdLJQlWpncylRnnItF3mPsmUvq0jnq88=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(19092799006)(10067099003)(11063799006)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261022075727099003)(261026140227099003)(261009223027099003)(261028144727099003)(261026121527099003)(261102123227099003)(261022105027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rquTIftYCF5Vl4SLV10x9DrfOBQHBpjR3bkw1HucsVBVckZ9lvmIdh40dZka?=
 =?us-ascii?Q?fRXK2UmODSk2Nxp41fwbx/cob4M9sH98SlHCitvcA+ucxM5aGUl5tS8z+jdz?=
 =?us-ascii?Q?boBmyMZzFQtX0kJeE02v/cs8ivm8y4atyVtY1+5HPhoiH3BK8nwy85tPQLbc?=
 =?us-ascii?Q?ymr4SwCQmwgM6gRq5ospLNjoFf0TzYxNG4DUQDbfh/VfdYjKNVuHO7szFMZl?=
 =?us-ascii?Q?X/w33K0y6zMY30Ezo4RAp3wTO0v1gRAmrklcTCyLrOXMWOYTfUm92X7ei2+7?=
 =?us-ascii?Q?oitVEblqmH96Fg8G/Tn5R8U0PD26Hk1KLrqQK6Fc6TDsVQ5Gwla7UgU2rmbw?=
 =?us-ascii?Q?I8+deSUeJ38DuO7REfZ73gUik8PcagqUtWDsg+EGfHpGVPJGAoVG4arw9UuD?=
 =?us-ascii?Q?SsO1/nXpXqT7bhLyHtmKzij/G6KXBjV9Bm8+yJwXa3Uj5MZ6JjTV2tLoLM8U?=
 =?us-ascii?Q?vG7aIjgKvBz2iGcpYKAlVorY7vF5WeErRXd4ln7L2SI0N9nadUT9KchyJrMF?=
 =?us-ascii?Q?COZutFcgWdFGLKGprY3ZkH3b1oog+zSxFeUTMIqdnOxLfwhgsz35S2Cq0uU+?=
 =?us-ascii?Q?EPOdgD4g/GCmPlP/DrtpEPwaJCwsFIRupIeCwU7SNc6fIidflKZW09bAyE3n?=
 =?us-ascii?Q?kRiwqIIYZxNJ8SLCseFdtCS3/fX8BZb23WZRm6UHFDSpocSqkhIeI5RRW/zG?=
 =?us-ascii?Q?/M+53ll3HpgBmMbWZewRvLiug3u4BMBpK8Fe3I/QJ5o/HK/Kz3ZWMnzlIyDz?=
 =?us-ascii?Q?F5F4L3ApbtNHXogDPWT1cyv/Oj0CUdvocyVXMreSLDVM222Q7GWiiNYeqSTX?=
 =?us-ascii?Q?dFfKSh4qGog1n07JlO3g9AEdVzdbcgJxu9q41wn7PLiS66Zg/kYC6U6kr/8Z?=
 =?us-ascii?Q?LdMnjIfg6KqCgbDtjqMUs/ULv0MpZtgJR57VVCLFn7y4RKXf7S4IkIqX7io6?=
 =?us-ascii?Q?Vk0p1hVdFQfWT2UptoMnY8pM1RyKMCspA6SXL8vZUSZhToGENtOXNjyHTIRD?=
 =?us-ascii?Q?lH2LZ74xAn+gGXHkqfnwAsD31+2TiUFWWlZqkf7BHv3toaExy/FcqjCKUqm2?=
 =?us-ascii?Q?egk7Sc/cImamVcroNY/SbXC0ivFJa87W6GsdIeYXyqL4Uc6EK5cmgTTT1OeJ?=
 =?us-ascii?Q?oQ3SLIzhiR8YC4+LpG25jql9MWHgxGvCrK8huNRprXygEmg9wbR3SIeEeWVX?=
 =?us-ascii?Q?6c3xQyJ4FYVWefMtwPTfF1rWxJtqbVpO0LQwfNFju1tDYLuJwcUf+QJ9v1U6?=
 =?us-ascii?Q?XnQ0Xhxm7CczlZcA1MTxSl/Xlndk1S6E7rqSBDghM3NzyesJRqXDDmPU9xaY?=
 =?us-ascii?Q?yQLAyr0QgAfn6dCdArYAHzYnxFtiLUpvqYW0tctUmjRN7xd0HIdbQzT9JwcX?=
 =?us-ascii?Q?X5Yr7brZHYQrNiFkowlf3c0Q0Pmh78G6XTw5ljDHQjJoUKzY+p97xaX8qSG9?=
 =?us-ascii?Q?B7mnzoZn4uai4b20n+LhYrv1IidUq5/1nLMi6/kkN/+5bp6XlhOUsj8uHJ/S?=
 =?us-ascii?Q?rZkJ1KCrag5Eg09Gno/kU1xiy8MnBQdS0AqBgWRYq88QOCAeBbfgK4nCePRe?=
 =?us-ascii?Q?aGXiyyfz/8p/2YDPFD89LW7Nek9W3klW0EMO/z4cljWr31b4aemGdYgDgOK3?=
 =?us-ascii?Q?R/K42SmpFMnp0LQXIlguai/4vMAFDGwaHIKQbzWk4a25nRaztbDYZMZWPVaA?=
 =?us-ascii?Q?W0qMIUIRWjpent97o5xufwaIfW/WTIuRmrSLyNGoF8O/966Fozy9zKax7cAC?=
 =?us-ascii?Q?GpHnp9YhM5IInUFL0S78R5Ggu25qsEfyUv7okI5TivT4XNF49vj3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4234b3-e156-48d8-caa8-08df40dc8a0c
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 16:46:46.5345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TvCAXrw99iWLdQfcDJJ+l60mWqVXOjE/iUIDaZ6pIWB3gkJ6PmrmxipPNnYMhT1kYkuvWTieNZhSorLSrrplOCrDYqUm9jK82AeHuL8ZJEktLuM5I3h4Kc5i1irlNBhJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7988

On Thu, Nov 12, 2026 at 03:53:11PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> Add support for parsing per-channel child nodes from devicetree.
> Each child node can carry its own interrupts and iommus properties.
> Child power-domains are not handled here; power domains remain attached
> at the parent level.
>
> The implementation is split into three functions:
>
> - fsl_edma_child_to_chan_id()
> - fsl_edma_configure_chan_from_dt()
> - fsl_edma_configure_chan_iommu()
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
> Use dev_err_probe() so -EPROBE_DEFER is not logged as an error, and reject

This common sense, can remove

> a channel whose iommus property did not result in an IOMMU mapping.
>
> Existing DTS without child nodes continues to work unchanged.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/dma/fsl-edma-common.h |   1 +
>  drivers/dma/fsl-edma-main.c   | 199 ++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 194 insertions(+), 6 deletions(-)
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
> index 818b9b986f13..88d2b9d6b6ab 100644
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
> @@ -703,6 +720,168 @@ static int fsl_edma3_attach_pd(struct platform_device *pdev, struct fsl_edma_eng
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
> +	bool has_children = false;
> +	int i, ret;
> +
> +	ret = of_address_to_resource(np, 0, &parent_res);
> +	if (ret)
> +		return ret;
> +
> +	for_each_available_child_of_node_scoped(np, child) {
> +		struct fsl_edma_chan *fsl_chan;
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
> +		if (irq == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		if (irq <= 0) {
> +			dev_err(&pdev->dev,
> +				"channel %d child node has no valid interrupt; add interrupts or disable it with dma-channel-mask\n",
> +				ch_id);
> +			return irq < 0 ? irq : -EINVAL;

logic have some complex,

	if (irq <= 0)
		return dev_err_probe(&pdev->dev, irq ? irq: -EINVAL,
				     "...." )

basic irq < 0 (include -EPROBE_DEFER), return irq
      irq == 0, return -EINVAL
      irq > 0, okay

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

print error only when bit is 0 at both fsl_edma->chan_masked and
child_mask 0

if (~(fsl_edma->chan_masked | child_mask))
	return dev_err_probe(....);

> +
> +	return 0;
> +}
> +
> +static int fsl_edma_configure_chan_iommu(struct platform_device *pdev,
> +					struct fsl_edma_engine *fsl_edma)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct resource parent_res;
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
> +		chan = &fsl_chan->vchan.chan;
> +		chdev = dmaengine_chan_dev(chan);
> +		chdev->dma_parms = pdev->dev.dma_parms;
> +		if (fsl_edma->drvdata->flags & FSL_EDMA_DRV_TCD64)
> +			dma_coerce_mask_and_coherent(chdev,
> +				DMA_BIT_MASK(64));
> +		else
> +			dma_coerce_mask_and_coherent(chdev,
> +				DMA_BIT_MASK(32));
> +		ret = of_dma_configure(chdev, child, true);
> +		if (ret) {
> +			dev_err_probe(&pdev->dev, ret,
> +				      "IOMMU config failed for channel %d\n",
> +				      ch_id);
> +			return ret;

return dev_err_probe(...)

> +		}
> +
> +		if (!device_iommu_mapped(chdev)) {
> +			dev_err_probe(&pdev->dev, -ENODEV,
> +				      "channel %d is not behind an IOMMU\n",
> +				      ch_id);
> +			return -ENODEV;
> +		}
> +
> +		chan->chan_dev->chan_dma_dev = true;

I think you move fetch irq logic into this funcitons, over half of both
code is similar.

Frank

> +	}
> +
> +	return 0;
> +}
> +
>  static int fsl_edma_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> @@ -835,6 +1014,10 @@ static int fsl_edma_probe(struct platform_device *pdev)
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
> @@ -897,6 +1080,10 @@ static int fsl_edma_probe(struct platform_device *pdev)
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
>
> --
> 2.34.1
>
