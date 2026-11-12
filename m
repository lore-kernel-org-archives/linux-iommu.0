Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794452940;
	b=hF5qzJpiv+Rx4c0odSOs1h//22wwp0tDcTwQQniJsOmQ/ykGug51Ybz1ndBz9vqQ0CxV
	 M9y0AO1JFMOeAHWyHmEUZRxSZqqWXjk60kzWPar63RoUHE6JEEWoJTRxa0YLt7SIIaVFj
	 jSazI35RbRCcLizlnC+vxd7GIRWtfuMsyr/TmNvjRyTOMlsQ/8f//vUT/Qq5nf6bC4DPz
	 MUzDgzmUJr7IsqbjUW021yzLUg3c6DorLc7oZXbIJkcS/Ov13n/3ShYoi0rjSFG1RYQAB
	 fRN/p4RcrTZ939D0sH1QqTlzxIX8Ko60Us5YIrrt0dozOngJDJOpCFfQy/CeaXJr7aQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794452940;
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
	bh=RiBCISnpJiqbr0nI7/ueSbTpeFzR/h0QLNdgAcoovZI=;
	b=I8VGEGlUBPl7pO8IdiNFFFHizwF4Owt6o8EWNwuPbsReN1dOvn+Vn9POXUc6ktTmGqih
	 laDE+A/C4gFbbxuw0PJHimV1VqLP70Qvu4Etk+mONcr6VR6xPTEuN8QMd1/iOxbDf0YXG
	 IvcsIMq+pZ+SuNGzJnNoe11pkSRU+92K6b4vSuUdc/2rnHTm+yMsf+hQqrZF0FTNFplRh
	 RvF2qbDc8qqsjT+gdEFbUE6RDcG13U3EQlLIlntVff/9mTwLgcKGQ0DERqMlUafgmRrTk
	 6JeYytgv2wLKoyOoFaZ9I+UroTVxmd9HPQgUVgwyvO14IMHRM41KHMl25lQafKKYp3A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=aFU2mkns;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.56
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013056.outbound.protection.outlook.com [52.101.83.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE72606A31C;
	Thu, 12 Nov 2026 03:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEE72606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=aFU2mkns
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2BiQfzVv+ikfc9JAHRUiLwM7zx4mZnFynrISmLDfv3SqLhuQL4DDKKAlVrJu+CCc5Yx5GRpA2icQbXJxChdI5YA1ezb/fC/PU9dj0CVtkFIh00WwcmnS6oaWFiFYsoelgnA1SQjDK4hT2INLhN1TAEpP6J/ux0FWBPyasEThgfps4hvltZCmFG0O02UNy7i9cm2mJ8tJnbNHplEYcaQC4lr9OxcTHSRBC/8r0vgdCHIrX/VOrwWPKQaGmvKYzlBztfnaRpY1XR1rquHzMzzeztcRcXqRIx3FB5ohRc+p/ybfkcbVNrPALIxYdnjMp34qhzuDqNzrQJHdyjqEBBNeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RiBCISnpJiqbr0nI7/ueSbTpeFzR/h0QLNdgAcoovZI=;
 b=yBEkVhVT97f1SwlMnEJc+7L5QFJzy2vZAJy23b5zqZ8pDoApC9612a5v7Y1ers65ZTp0Pdaydfsln3I7rysTBerqaRH6xI0YN40mkIhNEOFDlEZd/6x/C1Gg0NXJ/bJS+yPfSHcF4Kjm8DAyAAu34zhIVGQIedO1NSHDZEpnFh22XGjGw5QQ5qwl4QCElciAgZlhm5O/9Myyba9uUgJLTcNcI9Ncmzj4Fi5tkMDexBPDSSS2no8gh0jJzOzeB3jNMsSYpfVfs4of+7/hy6pe0Y/11HSjEfyLHFjT1xPf6x7FhUFwaOrmEr/cBld1uTFXZoo4cFwzvESxHylkXErgWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RiBCISnpJiqbr0nI7/ueSbTpeFzR/h0QLNdgAcoovZI=;
 b=aFU2mknsPygj/gIFsbK9EdBYLY9d0yATER2qBNJWORRQKtPslCeuTr4MOviGpJ+lgTKZoUGNMLe2afnGQ/SNqUaqEX9zQ3etE95QoVD2QzfeC5/3yoEAP/DGPruDg286idJ16X6oTFd4uDBKuLO48/amgEhnXzK4dt7KD6M5n6+ip0JZA3QIolfoV4Wj4NtsJbEdZM1JanIjex1yq2NxF7xVzAsHVMmrrjdttAtaJ1PAvMTRb/XQVfyDoobmyM3YZOQ3CF1kFPgFc+Be/oi13MwqUwGrUZbV7dBba42SBbYIIiPegN7GGih0UZJ28BweGjHSw3eqrvm5ZRCJGmdekg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DBBPR04MB7658.eurprd04.prod.outlook.com (2603:10a6:10:20d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 03:08:55 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 03:08:54 +0000
Date: Thu, 12 Nov 2026 11:13:49 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Frank Li <Frank.li@oss.nxp.com>
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
Subject: Re: [PATCH v5 2/7] dmaengine: add a bus for DMA channel devices
Message-ID: <avUu7akskg50FfL/@shlinux89>
References: <20261111-edma-iommu-v3-v5-0-2537cebe6ca2@nxp.com>
 <20261111-edma-iommu-v3-v5-2-2537cebe6ca2@nxp.com>
 <avSmdAQhFqKIOMis@SMW015318>
 <avUH9MXGu5AzEkv/@shlinux89>
 <avUhh6_vdOg-g1qf@SMW015318>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avUhh6_vdOg-g1qf@SMW015318>
X-ClientProxiedBy: JH0PR01CA0186.apcprd01.prod.exchangelabs.com
 (2603:1096:990:75::11) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DBBPR04MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: ebe6d7a9-4838-4a8f-1e59-08df406a4868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|366016|23010399003|1800799024|22082099003|18002099003|6133799003|261009223027099003|5023799004|261102123227099003|56012099006|11063799006|4143699003|261026121527099003|261021121427099003|261022075727099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	+3gcuJUAgl6zd/nsM7iywcBupTDSOzLww6IQYa/aFdauhswAqjbglj+p0Hd46WaWUNWpIa8cQbN136IEN/ZXDYUsyoGoo4zMgmmezhmkLK/dUqpWZH6eegXwfmmt86ojRhyhJDItgDzmzek1KvDTJGoZoi8Lf5sNIKl1OkTdYzpl5/Hm+EORy7gLPCHQaS7VNtAn9fLd9KTxKA3ehIUeGNMVLUKuj6YzB47aEuKEIxQWd3Y/rvcH+jk//VeOkNJis1Yb9vyWix9BqdMgpE35vceXRIxSxGxdHFS7MRejroHkHJz0NViZjYCXo/cMMhiFGTJ22xm4/+FQz8nQKGijsNx/0+XQoBIOpK1FtM6P7gOUOxM+W5Uu/NCVHBVweIdc5bi3hy5YQr4AZHnU0yZOAKqc3SFxiVGYmHnTbU1FiPqoZJ5OLhde9jkSZu0fVgBaAZjEhzizzjWXv3/8KFhH2Kh4yrGyuTu6ZBbjYaD/0kxMpQlBp473x6ci3cCim4WvOzdKjHWa+2dspfjxr4PIvzqctoKDw+y2KygDx4WR9Y4JdBZRLCXYQWRpDng28pwy58JDKmy761Q4OC4fbCWS/RvgNzZguT+ueHzYygYgqnHrOqItLx6iAYf7YN51yXon
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(6133799003)(261009223027099003)(5023799004)(261102123227099003)(56012099006)(11063799006)(4143699003)(261026121527099003)(261021121427099003)(261022075727099003)(261021123027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M/dGf+bOfwHgjUnECRvecyKjnH0tUMBfkfqwByAkJAgTmE362ZdF5hSlr85c?=
 =?us-ascii?Q?CKUq2vcl9e4NTdYdWAxxzh8xZycGQd5kuC183RFNQ3tg5QQfWLvJBTSCWmlM?=
 =?us-ascii?Q?cA1AnumqEWkOL7TjjHFn8wFA6RplecCi8bpG955fzGqIAx1Wcrb1hz+nqQs3?=
 =?us-ascii?Q?1CZ7O572QC7gafy7U+ltmoM/p5VDjnRKxAnLICJVPR3k/W1bskiTefA0GAT5?=
 =?us-ascii?Q?WcBykJ9Nk24GjUI7jZQkxXhrSiXy+f2twR6d8xS80mMwlqY5QH/3ezqlOy8z?=
 =?us-ascii?Q?6z4BRVp0MhLQLChMa4xfpvDb2p8WeH6MjKoveoLowMVXZtWO4YbiyEaex/0V?=
 =?us-ascii?Q?6Tg732Rb2BRGbkBTxubx9wHd1zG2V2Rt85ID+gYlVQKZBuiA2AYnKwc5p5wl?=
 =?us-ascii?Q?iwqy46vlH1MXIiPvF/KCYzUcvY2W3xZa3C9mM6WdF3fMd5pYALMRBhgDFr2v?=
 =?us-ascii?Q?jr/1dZOXY5bN6iC5qXko+fA/5SsLaDGf5md/h0ETYhLqG4qks5tdwxUVA6Nm?=
 =?us-ascii?Q?Z6lD5iwf44hnwcUBu+fJV1ZiYi7i9vK8F3hsh1OFG2kEi6TOY+1WqjxDxa+Q?=
 =?us-ascii?Q?1LuRV/9Tp0CMqad/wVA/dp46CRDaLbfKUF7T+sBJoLRk61rUECu6v/5nP0x1?=
 =?us-ascii?Q?fdJZvv6UEG4s6/wZr+K20sE9arqLyoQfZXWa7b1t0/X7nGd401xNcAL2rHR8?=
 =?us-ascii?Q?UCGUghfsZ5EdIjfN8DSj+FH1qf1fPUuOYhWE+w5z6J7Zf6abidkPIWsBsXdm?=
 =?us-ascii?Q?cEIt0w7dqewWQ+/zAEV/p9z1LVlxDFizjGgrZ4rKXCflOXlKiCXnYBtjhfIJ?=
 =?us-ascii?Q?Q8XoLMBquoc9b6yvVZG/jGAt9PKncTVGaL8tTrkGcqkeFYrBeLVycDu5aNuI?=
 =?us-ascii?Q?HjhVls5StUWfXXIwlvwSWcFUmFih/vbZd9mAfJc1bIN9qmduc5EAP7alDoFa?=
 =?us-ascii?Q?QvM98GVGcK8Ym5fSOs48TGDXbMkEtnKN/BH8+yprXPMq79H70gNw8hEQ4Xia?=
 =?us-ascii?Q?kmsSSETD6+K6bYWCYJsaQukqPcpyXurJq0Ci4H95qIdrPcfX7cloUEJARtYC?=
 =?us-ascii?Q?XtR9bQuueORyPMCP32o/3hJXzEYRtV+hWKhe8gwUHWAKHHPefEmBN2IcTRuV?=
 =?us-ascii?Q?fspgVRmK1vdtah9vVWwjYP1gsH4rBFsAmUz+Jf8m8f9XrCUv3WIOIGOcx8gu?=
 =?us-ascii?Q?dH+36+lnfwyG/59frFeeVJ7uFatOh/c8+pJkZNaWzibGEE2RTeFpKWw/5OIu?=
 =?us-ascii?Q?uyEdcJyc0w5CuWACjuSNrCIpc0bYbp93eZ5DK14zGlVz0gpOGn4BRd5J0Nhj?=
 =?us-ascii?Q?YJVlXswEitRCnavkB0vZ4lm4+iCGHDT9jSIO+mOwJuzWrQqXFPCTh4tCwOZr?=
 =?us-ascii?Q?nalfHUeVabLGsGsRerhImgbMFFcYAXL3BxqaP3/QwXjp94tIzrtbU3b7/jUO?=
 =?us-ascii?Q?2ditIn+gmcSXgg3sn16BCcoe7oeFrUQgdenTQFjTHknUTGmxxmMC4dVBDuuG?=
 =?us-ascii?Q?fpZNuWXlpAXPHnvLklO12TnspGiRWEjKgrFiAmQGvr32xjE2DTpJwdJlacpV?=
 =?us-ascii?Q?FZSIUpPnohxwNLNCECYpEiehI6W99XN7xwWKmEtkN+ulnyNp/49gLBANMV5R?=
 =?us-ascii?Q?+ULhp5Nz/aF/vCMgRY54XW4LHuXgc7cu9CEpE0lDNgIDlv7/cq/qyIrAz/fT?=
 =?us-ascii?Q?GEPdzZn9jt5UJ3DNfp4zMk9498CWdFZJv90Fvm7tYUNxmtahrhJdxL1tp5LP?=
 =?us-ascii?Q?5gJ3zd50hA8wKEaIXO+9dhfpwqbNwkARYdn9AptCW+k6JYlxjkOE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe6d7a9-4838-4a8f-1e59-08df406a4868
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 03:08:53.9301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6/ExsI+z4Tyo6P+MzK4z9Qch69uwySiwx1web2Zuk+B627zYVfEk+5o2XdNoNdxfYcwqrBZFt6tFdNUx+9umfUwc2TGwpwQkkKSDWcW6DUYRsLdPOYsjntps5emU9da8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7658

On Wed, Nov 11, 2026 at 08:16:39PM -0600, Frank Li wrote:
...
>>
>> >
>> >Not sure how other dmaengine support it before? Maybe already block for
>> >long time.
>>
>> In drivers/dma/tegra186-gpc-dma.c:
>> 1543       if (use_iommu_map) {
>> 1544                chdev->bus = pdev->dev.bus;
>>
>> I used similar method, but Sashiko spotted issue for v1 [1], we have to
>> add a new bus to handle it.
>>
>> "
>> Does this illegally modify the bus type of an already-registered device?
>>
>> This is executed after dmaenginem_async_device_register() has already called
>> device_add(). Since bus_add_device() is never executed, won't device_del()
>> invoke bus_remove_device() during driver unbinding or removal, causing a fatal
>> reference count underflow and use-after-free on the global platform_bus_type
>> subsystem?
>> "
>>
>> [1] https://lore.kernel.org/dmaengine/20260916160608.099201F000FF@smtp.kernel.org/
>
>Can you add it to commit message to know why need add new bus type

ok. Update in V6.

Thanks
Peng

>
>Frank
>
>>
>> Thanks
>> Peng
>>
>> >
>> >Frank
>> >
>> >> +#endif
>> >> +
>> >>  /**
>> >>   * enum dma_slave_buswidth - defines bus width of the DMA slave
>> >>   * device, source or target buses
>> >>
>> >> --
>> >> 2.34.1
>> >>
>> >
>
>
