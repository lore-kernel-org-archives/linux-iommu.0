Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794442961;
	b=PgHI4myk0dBRZL6PCahgu3zrsCJec4zN21bfOUnifmBJC8lGwKw1xIEaxh9cygUOKlGp
	 hgPLVGKD8RQMK2tlqRrKckwSpzP4bHmsm91ru+dOp0qbG0GQmEoFVn/qXDIuvigSd9gsD
	 O2Xb1A4Yl3q5o4TxRRBbF/BxpRxuHIcWDMXQXjtBV3n+q2JccwVZtEpebLomVsmVa23jk
	 /XNBgIBQgPjqujq+9KbpwKT2M+fSyI/IX+BN7fzdnVnqH7hXEEDVMAxnIQAcHkPoBCybV
	 8bBBjNXBWwWoPlHNldpaM38lDJ0OFzoLcHAgXSx7cMb/c+5TGN0LBPTLZg42Fg5l5rg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794442961;
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
	bh=Y8bQPbgvvisFgQuHGKTK/MiElqe/HRicPEW46aBNwmQ=;
	b=Cp4UZpKUyvuu2/aXqg7g67KSf9mGUyhoeSBWmjyQk3X7I/+KtQRQYWiJtnPXwmKo5o1a
	 gd3S2TsuVCP4D2Tf/9imHY07mO6DcvlFU1AEt9QKyclatzJbnNvhdUPfI24gj5pyrfe3k
	 pGf+uBetoJn8fybFzr5ZsJZgFpzDPjJSWROPsiaa1btTdOKaxfH1GSbPQ+/lhqP3gDsOq
	 59TwvxIALSHcq8OEcZKP3bTKDUPj+KJWZyUDVKja48e0NnOME7eMSjH2ox2QjfuGChFwb
	 rokdqgaQRtLm7iOgZFK8pVBo9CJSmDR74x7gzgdEsL9PI+8sl8A7mWn6jlkCL4ug7lQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=mNrmTDUx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.59
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013059.outbound.protection.outlook.com [40.107.159.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BA5606A321;
	Thu, 12 Nov 2026 00:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7BA5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=mNrmTDUx
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fs6qSO7jUVC3FcNcGyFgj6YEPvioO7Osg9DN72so7KAWqilOgX55y/pgwYY6SxlDqyBYSu7T+gs6o9fCQY+2z8z+Hr9S3VZlM73AYNE+hW9z4Cqm7ERNhS+YxSzw+G/AWQnfmLtDV04PH5hnL7vB6PdomhaAqhgMlb3Hc8r2NmiaO13cqAxBQcbBZSpcXcH4QFvM1Cf+b8HU3732nBIq24Hi50S7/dBVdHZSI7vCeiZd1Uh22hbclbbG/yg5L3dthUanNw6jN5CslOHh3EbrH/TZ6CLa3gcepMXdQEFnW/JeyTq30Zc5EQo6FsR1vxt71/IakeH9HNpORjzgoQcHZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8bQPbgvvisFgQuHGKTK/MiElqe/HRicPEW46aBNwmQ=;
 b=xvdkr7vorm139rOx3lW+PEbHRy0yagOc43i5bV1CwCFOx2P4kOaP0E3bvOVlU2+h1nRTJei5UOyM3QmM54ZqqOGQKFYkV3cfgAodpmRZL1HsO3THwR50ziRrVxVhrQWuV0MYmPZ3H1asED1O7tPQIguANCTNAOpm77JzBRGTNKns45WJ7GTJTCIKcEIuGkeKch/mBq1KS/PsGjpzPaSW699u2xXyp2JmYktDBUiSF1DC7ShiWg0gPWV6pIVj9gdSkvYFb2YzaA/G5UgnW4jHBzbKCeK6RAxP9ITtZKMGitoFihKeF26cYm7hyBgss3agq1LzGTmeYZ6VqRulKKQJKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8bQPbgvvisFgQuHGKTK/MiElqe/HRicPEW46aBNwmQ=;
 b=mNrmTDUxmUNi5ORNyveCljPf21w765vhP56nl9q04hld5T9r8OpmoFQy0Q7SMYFngeEshTX9nWNNg8uX42qlOzgeDNvAZcAz+cykjDnkokx02p+PQB6UxSu2yL8v+ErK/zBjFg4TBbH3ttcxovva6dFtaxbrdIQE10rCoeSWycmg9dSolu7DpiY8F5nlGcxaNcYDqlFKTT8nHQK1KROf5O590S/vgFQj/HH1ODx86JW0pSPe2Z3Xqx+hO1I2U9K3DPnbFMIhWgij7v6zx7lQAZ0wYZVUABI49K9Gs0jwzRa1/hzeAMEeokjMmGvUfrTfcldeVr7Y65P9YgJPws4VQA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AMBPR04MB868630.eurprd04.prod.outlook.com (2603:10a6:20b:7df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 00:22:38 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 00:22:37 +0000
Date: Thu, 12 Nov 2026 08:27:32 +0800
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
Message-ID: <avUH9MXGu5AzEkv/@shlinux89>
References: <20261111-edma-iommu-v3-v5-0-2537cebe6ca2@nxp.com>
 <20261111-edma-iommu-v3-v5-2-2537cebe6ca2@nxp.com>
 <avSmdAQhFqKIOMis@SMW015318>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avSmdAQhFqKIOMis@SMW015318>
X-ClientProxiedBy: SI2PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::12) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AMBPR04MB868630:EE_
X-MS-Office365-Filtering-Correlation-Id: e1226a2c-48d5-4b78-e872-08df40530e3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|1800799024|376014|7416014|366016|18002099003|22082099003|6133799003|261009223027099003|5023799004|11063799006|56012099006|4143699003|10067099003|261102123227099003|261026121527099003|261026140227099003|261022105027099003|261022075727099003|261028144727099003|261102124527099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	UVGNiVUXNfPhuYH7tCLtNZ+i0IDGrHLrfoTgCZPO44n8y029xiwlE3t7GJxLpztSgxCzogUbka4wYZewzeUipRT+oh8+2+pdP8qDkUs4TFZwGDIklBAu6HnRsHILMRVO/bu7EvcB1gJQpxBgkRkIHVcvXZN2GjjIHpfqZ2KRYsgZEi12aJllwS5x1cUiprIsC83WRTz5pZeDkfZXwEUSk8T1mlqogovy+QvEZf0h9X8qKsbWGVCyyR+n2yxl5+7rWoMXpoUMmhlCe5QycB4LbIshdD6q4cQI9TP8YOGU5+l/3tSD7k0ziXG4hr9K0xzPwx+tIpa0Z2ADc0w0+glF59MWycSbSN8Z/9MUbzvMOB66EJs9zq7S/rdCbpQwRljDmXK1POnPD18IUTUbzN/h0Sl4zZAuu4WgdcuGLDsAnwJWr5Bcov/A6zC/yujg1tZGjTzH5ZFPjy4iQTZrT1tZToLl/Fjpe/YldDGYbWGxKSv6xjjwIy2FeMTELWJxa8Ct+LA1Z6WeqytGe7zhmyzZp9Zf4E5/luhSuZc+86GwQ+4LTnEoJtZXJusQpvwhpu0RKBqsBYx2he/o/7vURAk0wmLCIAzoeGcKvOvwaerCMWrjtmKOr/OnfPzbfN18sh8T
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(6133799003)(261009223027099003)(5023799004)(11063799006)(56012099006)(4143699003)(10067099003)(261102123227099003)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003)(261028144727099003)(261102124527099003)(261021121427099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c1Y4GBDRErZdXAw2k5IkL5aIW18v9anEz345A0YljSHajhwCM5F513vo/OWH?=
 =?us-ascii?Q?I97yhJ4NDwv9/cXOjxx/C84iUbuzRmU8PBdaNEKUz+g96XEQSt/K97JkFbay?=
 =?us-ascii?Q?VXyVZsLMyF84/XG85PfanIIo8f1LjnDkDXQQA9O8rE28gN9ohUxdB1Wyx8zS?=
 =?us-ascii?Q?4k3LrLP7HBgpQ8PfHTkmM9N15bHc110DOL1+f3k4ROmXVej9r/lHnwY3hkhf?=
 =?us-ascii?Q?7LrUl3L7JIIEvBJH3ehXTKDb7e1+XeTqZT5q58kwl96DNKPaAhxRYDV+yWkc?=
 =?us-ascii?Q?KcX++u5kRLbYv5zxosgBaEYw7D9tBkbiU1faDPUZlr59Mi3ors9h4Oo8YgVt?=
 =?us-ascii?Q?ePGHPwz40cuZ3q0Q8R3OkuqMZapdiMM0uvyngNEN5s1Jmn6pYNsUWgqsveeo?=
 =?us-ascii?Q?cL6KrMO8aoOMk06KFYZkt8TY43huUxnJs4PTaxVpADGVoFP8rrBb76BIB01t?=
 =?us-ascii?Q?/3cByC8ZtGk78NVG4iPvgNvfn2NXsDSSj5iUlxCtlqaVKSYjEusSuxiUQB6C?=
 =?us-ascii?Q?1LRP/+uk/Rq3tYJN82xwSiC5cwJRCnms10+Xx+aozdPmxt4loTlGZk8cug2s?=
 =?us-ascii?Q?odC9mvacKpsTfvO0gMJ2JWPI0xkNar31zC6UbgQmg3j3jN5GI27tPkyzJMuS?=
 =?us-ascii?Q?OIaQqL7YqREysueAdTg+p/AySAgt151BGduv6YywqhLDle8FJZUiSRD3YrlJ?=
 =?us-ascii?Q?HceZUZZUnEAJo+tPbGOwt280o94LhZO95/dZ3wZRTs7hKHUbCvlmnsYhb0sU?=
 =?us-ascii?Q?eLhe3hqMo143G2AGUMUL/GH/dBSTZtc7Pjw9zgp8O4fBPiGTVDiUHO1XTtpD?=
 =?us-ascii?Q?b6vq9hkHqbSHEJJtVw+zqwfj+/knHFNt5J6JCZYyvnv5Yp5wYYDo2QmbVRlB?=
 =?us-ascii?Q?2gYnZxjn1PuadGza9/hByAPcMWYPGxU56hoGbYs4hdkk93k0S10T03fRfx3S?=
 =?us-ascii?Q?Nn2AGPyumZGKRzyIzd7p58RiPgwa+pJpHth21mm4k9iGzKxpUElE1T9pW/DO?=
 =?us-ascii?Q?ARnG4K8TIegOlqEDekdOBoXyCIaWza+eQ2pDz9tGtvUvJ/HbzPQXYnsJUnzU?=
 =?us-ascii?Q?O8jgvgc8phb2q/Cnt3qHGvkdCONcNlcloP2ZFT9uSUPxPqP2r8i+T1ZMGJwy?=
 =?us-ascii?Q?8fNgj4eC27ErPxNTOAVijj2y63av+Ngvxo3Wb0RQibh7YSWibZqQwHLwBY5j?=
 =?us-ascii?Q?+J2mjm5brSSwDRo/BurpdfOncr9qtK4sLlf0HUvvEiwK4ZsJqC8dkQtwp8BD?=
 =?us-ascii?Q?2TqVCehBubSvWiCOGMN2XYcNS+VSVFknEta5sGBhGwTjqO/0FBjUmO/2fPmF?=
 =?us-ascii?Q?o3uYshO1Q2xxurWXJEwFsSiHq2nNYQZiApgaiqkO9fDISWup6dMnSYli6TBa?=
 =?us-ascii?Q?BBALgfsjzQayrNUkKOSVH7guDxETGPgkJfXVfuBIZru1tNmpp1mQi7SZyI/I?=
 =?us-ascii?Q?Ly8P3oc93LovBQ+ypu8RrXBczQg8SVBqbyKGQfs8Q3nSf5j5p+1C4owOIhtD?=
 =?us-ascii?Q?oNLaE6UwRMYn3u/+jsYOmtyNiAtxIfHJsXNi5JCU+h7bz1fODxk+qYhPTYY8?=
 =?us-ascii?Q?wqw8QbvBY8z8BJka80FCyWP6Dsre9KB8a+7787jn53pbW2FqJ+cRGLDCdVxm?=
 =?us-ascii?Q?W8SXWSTopeOfO8GGBLnEzvfUPnXsGOzfCk2xZl8bWQGK6U89QhY2LKCNUu0G?=
 =?us-ascii?Q?jS6NL19M7xYjt4wUCJb1Rd/2fi7xXuae8foAPz44Zdu1efJocvfDowMGnAgs?=
 =?us-ascii?Q?oicR19oTg8MniduPzJc8NV/aFP7UiAcpPDZaWQIo1kmWFFcwgpK4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1226a2c-48d5-4b78-e872-08df40530e3c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 00:22:37.8552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpenoCuo+BidtA+mXrhYYHJOoMAmU21PVyLuCm3bvSZZ8ndQhWDQ0VAN/3KL2hgrEwY/0D+jv5co+SW9QpngPyrb6hXieScOxqSWpZdQgWB4FHR4m7bq96BlJTmDpWyr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB868630

On Wed, Nov 11, 2026 at 11:31:32AM -0600, Frank Li wrote:
>On Wed, Nov 11, 2026 at 09:47:30PM +0800, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> DMA channel devices are currently created as class devices without a bus.
>> This works for sysfs, but it prevents per-channel DMA/IOMMU configuration:
>> of_dma_configure() only probes the IOMMU when dev->bus is set, and the
>> IOMMU core only installs probe/release notifiers for buses listed in
>> iommu_buses[].
>>
>> Drivers that need per-channel IOMMU support currently work around this by
>> assigning dev->bus after device_register(). That leaves the bus subsystem
>> reference count unbalanced because bus_add_device() already ran with a NULL
>> bus, and bus_remove_device() will later drop a reference that was never
>> taken.
>>
>> Add a dedicated bus for DMA channel devices and register it during
>> dmaengine initialisation.  Use core_initcall so the bus exists before any
>> IOMMU driver can call iommu_device_register(), which iterates iommu_buses[]
>> and fails on an unregistered bus.  The match callback always reports no
>> match, so no driver can bind to these devices.  A follow-up patch will
>> register the channel devices on this bus.
>>
>> Clean up the unmap pools if dmaengine initialisation fails after they have
>> been allocated.
>>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>  drivers/dma/dmaengine.c   | 28 +++++++++++++++++++++++++---
>>  include/linux/dmaengine.h |  4 ++++
>>  2 files changed, 29 insertions(+), 3 deletions(-)
>>
>...
>
>> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
>> index 805668fbe437..14d8f182c7cb 100644
>> --- a/include/linux/dmaengine.h
>> +++ b/include/linux/dmaengine.h
>> @@ -412,6 +412,10 @@ struct dma_chan_dev {
>>  	bool chan_dma_dev;
>>  };
>>
>> +#ifdef CONFIG_DMA_ENGINE
>> +extern const struct bus_type dma_chan_bus_type;
>
>New API, need use dmaengine prefix, dmaengine_chan_bus_type

Fix in v6.

>
>Not sure how other dmaengine support it before? Maybe already block for
>long time.

In drivers/dma/tegra186-gpc-dma.c:
1543       if (use_iommu_map) {
1544                chdev->bus = pdev->dev.bus;

I used similar method, but Sashiko spotted issue for v1 [1], we have to
add a new bus to handle it.

"
Does this illegally modify the bus type of an already-registered device?

This is executed after dmaenginem_async_device_register() has already called
device_add(). Since bus_add_device() is never executed, won't device_del()
invoke bus_remove_device() during driver unbinding or removal, causing a fatal
reference count underflow and use-after-free on the global platform_bus_type
subsystem?
"

[1] https://lore.kernel.org/dmaengine/20260916160608.099201F000FF@smtp.kernel.org/

Thanks
Peng

>
>Frank
>
>> +#endif
>> +
>>  /**
>>   * enum dma_slave_buswidth - defines bus width of the DMA slave
>>   * device, source or target buses
>>
>> --
>> 2.34.1
>>
>
