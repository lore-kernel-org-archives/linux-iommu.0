Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794443785;
	b=e8mnfoQ/ijDfC6yCQZGpM3bRQtQjtt5tGOsq32OkpxHCqxSsZB/vgFjwLKJQjcDU3IfZ
	 3lHHci/mNJDEDptWxjQ0BDxdedD8hs8aO84o4q1JGxoQyB0QXEMSpbtB1Jenks0UJ4R+K
	 yh1cSz1QTBgG547iNVuB//laK3wui4RivsJPFF+q6FLVin0AoFBTigGMLmv3HDdVZWWKP
	 r7IiQ+u0seBD44gRKFo2CXscjotfttfoEHinSrUk6kHvRbD2dB3B7wzlzg2tB84JscD0z
	 w+MTE3dh0V6mDDa4PSfVEJE2LwrCkfffXnn0ZjiF+c0jdgJtr1KdSLMwBvaVhXdo4MA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794443785;
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
	bh=TaXxoXg0t5nBttAZgYSVgg/xNz6zmOPdNTy9TP8GuJE=;
	b=0fqFCraN7ajpbKvxP0dhjnQNulTvpjau0mZ7Si/DifN9TLCm9l+8g6PQXe8sS8Zjz4SV
	 7cebKIV7G4W2sx//Z/snfnBriHRYng4eewKzlZ0NsdJ8PptetoGBlMoFDsqkL5OsTlSf5
	 cGW2RZbMyDlUSPWu9rxm6PvUGZQvYQZjqaCjmSiMU1kCmWVA2YEcV/kj9Vlsn/raW6WcN
	 w6GJjs+8pb/qB23jrWIEpLPIDAHBKFKSyxCqzLTChaBmBGmLpSyE1ILj0lSMFwyA1G5+B
	 lwPKo1YGZUKU20tqLjHL+I1MPlbArMPxsIeafNESCORuy4he2xdggOeFBu8SqCa82Nw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=EYyHYXuN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.41
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013041.outbound.protection.outlook.com [40.107.162.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E94606A31C;
	Thu, 12 Nov 2026 00:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3E94606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=EYyHYXuN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFZB72+lBCGwR6OkRs1sdwoyjK02z/InqyYieoI6Ur/d3Pur51rkWrWDvqOIY0U+F/H9UVuMiTQu4uYzOqieniSK057w32keCywj0gAamtn+52WoWBziEMC+aq2GtC1KRY8dXRk7c1SdbPw7bHz4kT1vFjpI7U70BGAWxcag6CSJyMrnh6XybpFuCcfTHjjBoFsMkNuzPE9aon/U44oACjKxanqx4JKdn2NSscdrkouFux4de3of0GiqcakK6lwRHaDVh+ors551oHqWoFZJnfHrRJxFpe1XmzmaVNbT5ZBSQH/8Rnc5058nYQNgvXwTIkkXigV/FAKWA43QnpkIig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TaXxoXg0t5nBttAZgYSVgg/xNz6zmOPdNTy9TP8GuJE=;
 b=fGOTja5mK2214/yg84pun+j8SA9qUDFE6RyEI4NHBm0bfff2ehf5YQsMDO09os/D1ENjzR3oBNZKjbOfmQGeYG0BXLdlWNgqiBdmKRcPiWgId/z0OxQWoMbuCdXeuPoy9sa/zYrVoMJBbs54cUyUZm6JbOV2+mIsO2nUpxgPdyvZO9ldKhZPapE7p30LVENroxlawrW0DMo4AJeKzUdZyZBvJBJBBzQg4xawEx9gv2WdzYFim/kfyKL/E3OfbMwKnNBEtjQfGFu8V+5mG4CGykdT3DrF1DlD6uMV+YyT5MWaGIhEEVTGtBTcU4O91zz6nMeqIyt4/2ZsfAmTpxob7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TaXxoXg0t5nBttAZgYSVgg/xNz6zmOPdNTy9TP8GuJE=;
 b=EYyHYXuNdFYFokPbJHDCKFkxM0E336MeRIegDw/qXs6C4DQ06qYWjG27nyhQNeSVgpAE7GnhWE5enn+zQ41+uwP8beaFpR4nxYmmJzSb+MF/2ffA1LctORF0yj84+7tCQvPkVC4zyUSlsEeMS+XHeFUrjnqFKkXZefKXRQBkKt9Prd34h3oxbH63rYSpk6leCl/+WzXPDi3HkHe64OBhD6gV2/IphdcVG78sm+M4Gs3pN/sZ7NHBTaP6n0LMsJfN4ernPNOK1dayc9HQzRWaHBA7edHlnCbVhXITpjz5bR1wzAC1qPYQg8TiJCjnfM9zXVKAcgXtrLkqWB+kqreYVw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AS8PR04MB8660.eurprd04.prod.outlook.com (2603:10a6:20b:42b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 12 Nov
 2026 00:36:21 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 00:36:21 +0000
Date: Thu, 12 Nov 2026 08:41:16 +0800
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
Subject: Re: [PATCH v5 6/7] dmaengine: fsl-edma: support per-channel DT child
 nodes
Message-ID: <avULLAj1s5IRo80N@shlinux89>
References: <20261111-edma-iommu-v3-v5-0-2537cebe6ca2@nxp.com>
 <20261111-edma-iommu-v3-v5-6-2537cebe6ca2@nxp.com>
 <avSsj0Ho_n6DL36_@SMW015318>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avSsj0Ho_n6DL36_@SMW015318>
X-ClientProxiedBy: SI2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::23) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AS8PR04MB8660:EE_
X-MS-Office365-Filtering-Correlation-Id: acc5bd0d-99ff-42bf-d92b-08df4054f904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|19092799006|7416014|261026121527099003|261028144727099003|261022075727099003|11063799006|56012099006|261021121427099003|261009223027099003|4143699003|261022105027099003|261102123227099003|261026140227099003|22082099003|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	x+CNt6Ncop+hA8z+6Z7GOWE48c9sU+cus4+Ao2b6dZUJ+5DhXYmYfWptx+5NbKO+tj7n2jOIIwxE7dU6sxjI0dZFC0l0KAUOOwdTHNxygfpPaAPJXwEIdT9NSmDc+KUff9twd6H9zNigl9lZ4OaD4Cj9JCrJGLbBQScxToc4gIgpBS4szsdbyvOEiBzjaXxY9p6MicLJbyk0DXoF4t/o6WxOolZCl038qz9pe35BvMRZDiHmzcIeAmg28QG0G2OWY4bpQmuf1IGZ0gmPLJ7D69xGYFdtMQlkQevm0cIknfh3xWStxzz3KA9W6pBEchFFzplLtNpplpmB7MTuOO+BIEVe+nYpj/pe9k0tm+X7VZ557G9Gf+lQnKwQ0y5WtkqaooO+MDpHo5p1xe5hFHsYNhMLWRHkv3nOtQV4yGfPTJy2/PwCe09/DlyJhndvj5DiQzg2ht7yKDmwxZVOJ1rWQ4peAkFGXS3NynTRmidArucExna8lX9nYvUsFdXUzxdqwxpoFsl50IdKs/GOwyWW3EtT0uYB7RzxV3ga0VJntqucNFzrYLsZuoCQJWlPc7t1ztRqI7vjfhZqKGZaBXOHytX9PzzQEDFvUf7EY8hIu20FIyZPSjmsS5i8RJCE9umAX0BHuof0epOlwUGPufczqAhV822defHR16+KcutG8kQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(19092799006)(7416014)(261026121527099003)(261028144727099003)(261022075727099003)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(4143699003)(261022105027099003)(261102123227099003)(261026140227099003)(22082099003)(18002099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8YbuMpDTyK/bpi0CLSL4ZaUNV7q8SCASQ4EJ/Xbij5wf2AJyzrh/8BF69qQZ?=
 =?us-ascii?Q?9/V4wQjOYBFEnwjkBFVS+ePAOuQHpCPRmgNMnect+ZW5z02gGuhUp3lvDp4q?=
 =?us-ascii?Q?vYoIG/w+lm9nXvIT0QNc1T9TwCAj5FTFbE8GsUpe5mzknUqgKeGBon0jGo5H?=
 =?us-ascii?Q?Of9sZ40kH9oEuk6eBVq8+xGqtUEAiUyW46p6GKu+tWi7j4aVuI+ksRI5Ex6+?=
 =?us-ascii?Q?pmbsBtoDhdesbeVBP8i10AeYzwQtRwDpY/95OEW0+jJfu95I/UjKeknlFqcX?=
 =?us-ascii?Q?wZTF34KkWlIwqdgbwBfDa0izf+kksPHlX3LJKGrFtAvA0I5UiTEC2bemV/ex?=
 =?us-ascii?Q?Zzh1qADjgxGSF7OaPdl7CjFolzPjNhk6sVHlaA0c4NI6bA/MCEXVsnnaXJoR?=
 =?us-ascii?Q?eimERI1FUFL74ZEvfaU8Ka3ciJSYxSSwLGLpGxdcEgmpfhwKJOVapGiF8GWf?=
 =?us-ascii?Q?8Ji9ZpNIQISGJa8B1+RcgYovmbUy7U5Y032Ou8h67OQ8r9gjarYhvBA6EVmB?=
 =?us-ascii?Q?+Z/9Q3xD8OsN2yaJkEVH0pi2vAvYofVEl3Cr3YtRexcZHBYqjcg1+lO9OzWU?=
 =?us-ascii?Q?FlrrXeYzObZpTqboPzZfWw1WeV3eP+F5OJSoRYHzlRXYHIlW+QweENcfDhi3?=
 =?us-ascii?Q?nopbNtPqWmYwfVwtD/gkv+mRSu+DnxS3AQp4ArG12Rey/2CAM1ktaTw6dnvB?=
 =?us-ascii?Q?GwsrGFjnCjoNxUangD6kfuwGi47WTJli07rRPeM3wTnWNa1QQD7edN/TKng7?=
 =?us-ascii?Q?Q2mjaQBWjC2OY+cL5xT+HXypr5JgcQJVBoQ4hWLMZceP/UAwSm0X59bDlCWF?=
 =?us-ascii?Q?EWDhbHR++8NneLD3SXKxwumuNPatHkTEWe/TTe9vUHU6P895xyX4dcKqPgYJ?=
 =?us-ascii?Q?u5mIrYui5CF182gQfNrUcRxjMh3XjUUdwoJLqOq+6hgshDf4KAlRcomGiSFl?=
 =?us-ascii?Q?CZIsb9kklT0nX5R7aYZCKaqs/XCJ5OHn8uFI8fzjJHJXwyTPDWn+bUkgFBUa?=
 =?us-ascii?Q?w/q9LqhZV1o2qriLMCO8eIWmJ7KRDqhEhPxK17k+Ej7YWmIZIkm8k4dQPHGD?=
 =?us-ascii?Q?6dx9vDa9cnv7tZTKGYBxaMpvNZtYpNRaHQMK02y9B448AJAnf9SwGEcksdVM?=
 =?us-ascii?Q?KNHwl0vwkE0Gl+6UnC6xgv/hHETeAW0MSBCZ2qyg+VReX2h7q1WSuyDqOcAs?=
 =?us-ascii?Q?iWc53PT36DtNR01fbtx2A3tllS1H31GvdqJXsfkEGteA5aOLbLtkcHU6e4w3?=
 =?us-ascii?Q?cawWaWWyWE55pGwWLI0+h2gdTaNIkibywlmBo3mWRXQcXVQFtEE5bD4enOcq?=
 =?us-ascii?Q?/VuacCebllXw2c0GW0MFqnBeQ1lQQ8/50EZrJECmiC0qKdNSum7a9fDq9S2A?=
 =?us-ascii?Q?XtYw9HM5Q/8TVf4izeTJqNYhj4N+WSY2E0FKD3FzhHbdVdBKMEk8zdympkdf?=
 =?us-ascii?Q?FElgX+CKypUo4pHU+xpy+wYPlKeZvpMX+Gh3gaM3TM5xk6lwfUxNDUu8fkV3?=
 =?us-ascii?Q?TBIvHv5hoDwItwcuWN2kdzNCjQ1/oiuYLxZywQCrYoJzHN20vc7JF9B728E3?=
 =?us-ascii?Q?pbUoZFvmbbs+k0d9YA9ENAkieXGNdReAZyn4p4FpFpN31uDeIl56kKj6DFVj?=
 =?us-ascii?Q?xb/Kq++A4nQulbCK3jn+agT4+cb/nU2IIaSdcsmh8/i2oTeJgn62OQAKpnFK?=
 =?us-ascii?Q?Xn6smxQokvtIoiwQF1B784sQ2drn45RuOAaaCwtZfHzGQDDodMWFYKrLV2gc?=
 =?us-ascii?Q?eLa+5xrtz60rdZwL4kHG138+OQkrjJ46E0dhbow+tTULXIqm43sK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acc5bd0d-99ff-42bf-d92b-08df4054f904
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 00:36:21.4024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dEMwNJLv5/6gg9ZoUY4LI2np12T+5Tum/VEm4ghS3ge3anvffTIhh6OUZeO+mEK7tEvfCK1RpTtCmro0nJ2BRhxGWeQ3LpExzRIBwqFm3pxFufGxhSGuy3Q+pjbwF3fQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8660

On Wed, Nov 11, 2026 at 11:57:35AM -0600, Frank Li wrote:
>On Wed, Nov 11, 2026 at 09:47:34PM +0800, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> Add support for parsing per-channel child nodes from devicetree.
>> Each child node can carry its own interrupts and iommus properties.
>> Child power-domains are not handled here; power domains remain attached
>> at the parent level.

[...]

>>
>> - fsl_edma_configure_chan_iommu(): called after
>>   dmaenginem_async_device_register() to configure per-channel IOMMU
>>   by calling of_dma_configure() on each dma_chan_dev and setting
>>   chan_dma_dev so dmaengine_get_dma_device() returns the per-channel
>>   device.  Propagate the controller dma_parms to the per-channel device
>>   so the DMA segment size limit is preserved.
>
>Needn't detail for each funciton.
>
>The implementation is split into three functions:
>  - fsl_edma_child_to_chan_id()
>  - fsl_edma_configure_chan_from_dt()
>  - fsl_edma_configure_chan_iommu()

Fix in v6.

>
>>
>> Child nodes beyond the configured dma-channels are ignored, which allows
>> boards to reduce dma-channels without disabling every unused child node.
>> If child nodes are present, every unmasked channel must have a child node
>> with a valid interrupt; otherwise probe fails with an error asking for
>> dma-channel-mask.  In child-node mode fsl_edma3_irq_init() does not fall
>> back to the parent's flat interrupt array.
>>
>> The shared error IRQ remains a parent-node interrupt.  A child-node-only
>> DTS without that entry simply has no shared error IRQ.

[...]

>>  	if (fsl_chan->dma_dir != DMA_NONE)
>> -		dma_unmap_resource(fsl_chan->vchan.chan.device->dev,
>> -				   fsl_chan->dma_dev_addr,
>> -				   fsl_chan->dma_dev_size,
>> +		dma_unmap_resource(dev, fsl_chan->dma_dev_addr, fsl_chan->dma_dev_size,
>>  				   fsl_chan->dma_dir, 0);
>
>Use dmaengine_get_dma_device() needs sperate patches.

ok. I will add a new patch in this series to handle it.

>
>>  	fsl_chan->dma_dir = DMA_NONE;
>>  }
>> @@ -321,7 +321,7 @@ static void fsl_edma_unprep_slave_dma(struct fsl_edma_chan *fsl_chan)
>>  static bool fsl_edma_prep_slave_dma(struct fsl_edma_chan *fsl_chan,
>>  				    enum dma_transfer_direction dir)
>>  {

[...]
>> @@ -397,15 +401,24 @@ static int fsl_edma3_irq_init(struct platform_device *pdev, struct fsl_edma_engi
>>
>>  		struct fsl_edma_chan *fsl_chan = &fsl_edma->chans[i];
>>
>> -		if (fsl_edma->chan_masked & BIT(i))
>> +		if (fsl_edma->chan_masked & BIT_ULL(i))
>>  			continue;
>
>
>This one need sperate patch to fix it.

Fix in v6.

>
>>
>> -		/* request channel irq */
>> -		fsl_chan->txirq = platform_get_irq(pdev, i);
>> -		if (fsl_chan->txirq < 0)
>> -			return  -EINVAL;
>> +		if (fsl_chan->txirq <= 0) {
>> +		return ret;
[...]
>> +
>> +	for_each_available_child_of_node(np, child) {
>
>for_each_available_child_of_node_scoped()

Fix in v6.

>
>> +		struct fsl_edma_chan *fsl_chan;
>> +		int ch_id, irq;
>> +
>> +		has_children = true;
>> +
>> +
[...]
>> +		list_for_each_entry(chan, &fsl_edma->dma_dev.channels,
>> +				    device_node) {
>> +			struct device *chdev;
>> +
>> +			if (to_fsl_edma_chan(chan) != fsl_chan)
>> +				continue;
>
>Can we avoid scan channel twice?

yeah. Fix in v6.

Thanks
Peng
