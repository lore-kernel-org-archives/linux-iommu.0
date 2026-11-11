Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794418309;
	b=slzSeHqGS6SSrW1ZWEHApZWMRG+mSfj+6/xVHTalmpdR6fTZQMrWkukv2ZfupUMULOC1
	 3l3g24m8z5auI3G4g5BQt4wwZMZcv6ua+qps3+3dZVCFojLgdIBgndTf43T89iCbmpHVe
	 M68+3Vo2jpy0hUnxf5fX2wYxB/xvrXXDE6/gvjBajg7X3qwLfblpuSe+2frvQG803+b7F
	 GVzg5wAF1s9u5ap/w9EVWl4H0HTzgJuPvje/IDyHpSefxDaATP3csf3cMWN3Gl6CLMvlI
	 M+xs6oPl1Vv4+HynmC6jPADtNAiSPFVUv+0XDoEFiFIlkg8XeW9Uyc2cb5LAvZDweqg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418309;
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
	bh=Sn/95PFLglvA2JTWXRMih2dJa3NUZ+6fbtddMJSyX2o=;
	b=OGd0WGM3emv5cGNvvIP1j+t/k2nQtYWaZp2x0V7DHlUEIEqxtV4udDZHT15WAHEV59JO
	 E6vlt6McA16zpKhGb1uP0OX+Q2oxBcWesiPnULETUuG/112dl1hPJ85NU0BhQ0Zzo/ucu
	 +fNVH+0BnPxegk/A0ONUX5Yf3bSxOFV91TXV8IA81LWuF9OlQtt57qsnHzs+Srikhzd6E
	 EtQY613hDBK4FA+2ccROzxRfKdvZZRDycmk28kI6sVxA9h5dULhCcY5fHa6dtzjp99iv3
	 y0dlII3Q5+/hojSpX4Fpfamtw+7Vt//j/CAlbpcsXcelG5I5ubhmpl0wSgXYUVXTonQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=AsanDwrE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.24
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010024.outbound.protection.outlook.com [52.101.69.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD10606A336;
	Wed, 11 Nov 2026 17:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BD10606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=AsanDwrE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCSle0GENBZvtMS3WvhPzQEaeWDT7I/9YQoPjLJPLXtYzZ2X21O9Qfa3celGJTpBJv+zKc031sIarTa32vb0tavGpl06qEXDcEK4+HQlopahR13rxzOf/MAlhrLAQ2rD6Q0GV3bcVv+qOHAiWPO8jLc6DETlRM5qDz3J/beBzxfAgNLXTsGEPNnngmSi6piznOwapH2V0SH1MXFJrEFvEEPSEU0i6ixb/YWE2UZnOPjrw3/td50RX7orCusdbdvW6+nJaW2ZYY+B563kj17GX0PyIKnFR1lEr0x1KBKXh6vmkXg8vkfDcH+b19tlb4wi8+xO0ZECw4ki+OjpoNDL2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sn/95PFLglvA2JTWXRMih2dJa3NUZ+6fbtddMJSyX2o=;
 b=xzTHnj7zsqtOWYZs3N6yHWr+9rWCySTJKI8gBQ9oiQhz0+Et95k7cHgyV7hTMaLzEUuu7EUP4LtknbUMFu8IItl/ugqxw8pSp2rdajf+Hsvw9Sc9LVvwP5WqYte2Opwn4iMyZB6sU5CrcYKuCUbMc+GE+DFElRmTcURgrYEyGvyRT9SCMi5OPyckB10Nqca067qEB0ERh7bJXS2ymAgXHDeaN5hSxQnSHU/dUYhlh0PdevSPIeAeWcESPRDTfFy9O59NM6bNzqX62T4weiaFfHr0IvMkqVU2Bgl4/Ljc3HU1vPRg1g/579/tLMMQjUM0h2EvxhfUpppPgecaogKM3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sn/95PFLglvA2JTWXRMih2dJa3NUZ+6fbtddMJSyX2o=;
 b=AsanDwrE1i9eIklViSiEVnGC5P7hu0iawbcZtQxnha1pxajY6qwDKcJfL8HZFFtv8l5oxzMJhLwW6MCjbJsv9gHjFEv5OQ/29vWpCUSXaQmI4S6bqfVnrZGfMkOri8/sGP5IsMMc49l4XhnoDeWPePUoLA0GUhXaeydRwuu147+IiOWhwlA3EFF+EFIAlSslqLegR13AMIvV1KT4zGktrSyodbfzP1L+Ibe+6/7a/zl80OoFqynBufzicpnlsLC/xMdLCGoGwf1V9UUdy23e0EqdNKxjpfqU7AVC2e9nhnCAtWzjJfexNqfKymPGAqZtuZH3AfpYYiNUZQZsSYIzyw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by MI7PR04MB236726.eurprd04.prod.outlook.com (2603:10a6:290:10b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 17:31:45 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 17:31:45 +0000
Date: Wed, 11 Nov 2026 11:31:32 -0600
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
Subject: Re: [PATCH v5 2/7] dmaengine: add a bus for DMA channel devices
Message-ID: <avSmdAQhFqKIOMis@SMW015318>
References: <20261111-edma-iommu-v3-v5-0-2537cebe6ca2@nxp.com>
 <20261111-edma-iommu-v3-v5-2-2537cebe6ca2@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111-edma-iommu-v3-v5-2-2537cebe6ca2@nxp.com>
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|MI7PR04MB236726:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dfeb739-8793-4713-cd37-08df4019a81c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|23010399003|18002099003|22082099003|6133799003|261009223027099003|4143699003|11063799006|56012099006|261028144727099003|261102123227099003|261102124527099003|261021121427099003|261021123027099003|261026140227099003|261022075727099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	UyNzT0hJ2xdJHGihqBEnCJ5dRL9kqqefxkWkcJWa0VHSVAC5bJ1hXaVNDWGVQmhBnlP15Ib3TMDUBuEoZoBQXPMcDjqZVTd+eDUWM/gIAsw7PfApE4+xuSx0dt3SAchlEz8StRs1nfAHadtcnL9eFsYAFeAOOsrR6v2LBrTbcSMJdF1pb/oA28bMp1YKGEbP9SghOFrlYeJyu7BO0RrMCgmlqYULI/O2GUMcri4BW5dHsfRDwUwGujrBmKeNAds2bEIHnDYaklBU5/l+4o4jGj6VjFI/usN5X0O0ZvXwprA6DO1pVScQMmNgU6cTsfq6TD4yqhdRu5paaatRZU2V5WtWUNOyl5/6OuxUTj2uQ4c9SCyYULudQKz+OgdY1EzLtb+AkMpYcA9GloIuQlkApblkeDNnhzWJRpFR/4JRfLFWnKbbQKS+DY0XuRiaEHoOLxPJaQ6FESrwhOn0z2znZXAT863IxryHDhCiq2+ohg/Za6dgAgU1/6IbA6z59BmVWmlfq3uvIk77HzUnc1vm8f0+oM0M36fb2wEoLOY4WvE5MjsNAFinXmpEe/dNggjXL+tmDHLqrJXSB1uk3IuA6J8/T6CGS+GhsvSQP9n0rCWuvx8gdcVA4MKaN8lagR0k8E4y6tm9n8rcrzQTfomt5W5obdcjo896CDjM8LLuDoc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(261009223027099003)(4143699003)(11063799006)(56012099006)(261028144727099003)(261102123227099003)(261102124527099003)(261021121427099003)(261021123027099003)(261026140227099003)(261022075727099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L/a+9zfbAA1KxsvSbxvLkyMz70Rxyj00+Ksf01bhI/dOS0NKI/mRwJq7vztj?=
 =?us-ascii?Q?XfpT74HnRumRdRkSi+8j0Et/cOA1CL0m+ezlBPDlXn8T+4kAh/HIE/Inicht?=
 =?us-ascii?Q?JtBUPGc7PJf6iMfwDRgW+4ncFiP6x19Rb+mhyGqQwANCO0AD6DfURYN1t9Nm?=
 =?us-ascii?Q?5Rp2e/ss8qfEnODKosDLkOeolYR/2kT0tvv4TttWNWJO7qihig5gkx5M8J1D?=
 =?us-ascii?Q?HtTfCMvyeQFHBmmFctPiZd2i3GATnlcVeUK1KjlCcLmfoVR/abdx2srZeRJp?=
 =?us-ascii?Q?w+IDwWd3xXbpSTC8SA1hHht/2FpuM5/RZJv2Ri383JwSPXjq67UKAwz0qluJ?=
 =?us-ascii?Q?BhrXpJMd3OW+DV9XTD9hBdNYyTs/qEx1e9Uf6+EqTxHbIaFxdDLEtMv836du?=
 =?us-ascii?Q?dvF6dSyuNScAN1oKsw+drVUbojTwrCVD2W9EHV/+wsa/xahs+Bt0BkKI43o2?=
 =?us-ascii?Q?RQAG2jOvSQ+IURzlQnh1RzQJM2mVLNjJckp9BCdb01kXls63dpvvpqYjocNC?=
 =?us-ascii?Q?K8H8/4yQJf7LM2rQ7QvBHH9qpZaGi2JiXt6/GMhC1SXtcQh1xG0sQnYKtGUq?=
 =?us-ascii?Q?+g0zSv0/VifR5CF4kuPg1H0/Rxzmua6Oy/3MyIB87hFJCHrtdihfG2PBc01z?=
 =?us-ascii?Q?EzfKEm/AJEAXarJUKBDXmwlwgaxu6UmEvr3ESkqD890FuH1aa3IsiXevA/oR?=
 =?us-ascii?Q?bl82cGQ2iF0iuzw8m/ANK9HMpz3lSxVOL9yDzhDSDn4DdGzuHNNI75ktQ3nV?=
 =?us-ascii?Q?EQv/DdPnT664SQCfz1t+G0hSEoGkplZ9SZCZjPtWiKU6vxmmn+6IVBxyu5UA?=
 =?us-ascii?Q?FHdbNiIj2mViepuHkuA4JVfFdX7P+5yt6YNlhMJWZfY4cCnvOyBLdOXX1rXO?=
 =?us-ascii?Q?gx00a0ehkBA3Fe8ShtSxBoa5kbG0ogCvmDJNMCydJjfbimbUiKssAZ067Hkd?=
 =?us-ascii?Q?ViFa/XKIrTTe/OvtClQyGqj+Kkvxmq8jXgQkmR+CBsvcKtBqWrXAD4QKyj3g?=
 =?us-ascii?Q?FyzSrmMkTKprbCDG7/PlqoTYrD0/UaD5n5hmmoMBa29tkulXqz9SfrKzQZ9d?=
 =?us-ascii?Q?AeG9+RnhpaoCk7yGVJWUaJbKD+Ifc0RvuWy3hgyp6bXKdtn4dMZzJeaU1dYz?=
 =?us-ascii?Q?IqKo75+A9NMZ/9o3XEF0oYbLB8wHhXM7v7YnM5EX2KeVgifXd4JJ2+Vscg3b?=
 =?us-ascii?Q?NJ9IVGHVwdaEOUT+JEjhco+veHGXwz5qnEixBrGCMZqRyd+vf6Y3rzC9X2A/?=
 =?us-ascii?Q?6uTQgQC0Ap6hg72XFMiTonmOjEfJr1xZwdwb1s0LHXg2z5mvSU5uCHY3Zs01?=
 =?us-ascii?Q?aqRGFSmqQ+/WqN+0XhDYIR1vzTnLEwSW1NDYS51fXTt+mxD+DfH59iFzeh7o?=
 =?us-ascii?Q?WtAhs7nk91uMlanW/lPS8IQPkA6rdtpEYyd/XO8vDWyc/wCgeAd46wu2WJzc?=
 =?us-ascii?Q?Tl2yLD3z4dxSLs7DX5k5o5R60TMvQHo92iVYEdzzVYHFiNkUAGV3iS8Gvlk7?=
 =?us-ascii?Q?1gLWgVBqGAs7Ra6BnkByHJZiMAkgtyFBYZR5YbkDCEvWucaytSroggKSDy7c?=
 =?us-ascii?Q?RocfQaE61xEJ571gfCfg37V0UerJTPDlWTnLDgZd67cw2E50FKvx0A85xfhH?=
 =?us-ascii?Q?O6Y74U3B23gUjA1C/Dxsnpf4eagDK7GvTO2FRiwDarNdFWQ/cXzu2IAbEXpb?=
 =?us-ascii?Q?z2MfHeKC4NapReKHLlLLcOP8WShcP3/3PCTlLWXcJQNy+StzhN83t9g3rjl1?=
 =?us-ascii?Q?uxzItarm7Srzrg9ua4J8r6kqQFU2eQJFQ437iYFSolHN4W54m4u5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dfeb739-8793-4713-cd37-08df4019a81c
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 17:31:45.0788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P3YWG1bq9qeuV3u+Nr22AfL6/GgQLYh15dNsl8LcmoqhVL47O2NcQ8holKRgq/nz+xx5FUittn0RGEh4EFsf3Hi2vwhx3oHrBuDkrYytqBCnEEWIkR4vUDyWYCBxblBT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI7PR04MB236726

On Wed, Nov 11, 2026 at 09:47:30PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> DMA channel devices are currently created as class devices without a bus.
> This works for sysfs, but it prevents per-channel DMA/IOMMU configuration:
> of_dma_configure() only probes the IOMMU when dev->bus is set, and the
> IOMMU core only installs probe/release notifiers for buses listed in
> iommu_buses[].
>
> Drivers that need per-channel IOMMU support currently work around this by
> assigning dev->bus after device_register(). That leaves the bus subsystem
> reference count unbalanced because bus_add_device() already ran with a NULL
> bus, and bus_remove_device() will later drop a reference that was never
> taken.
>
> Add a dedicated bus for DMA channel devices and register it during
> dmaengine initialisation.  Use core_initcall so the bus exists before any
> IOMMU driver can call iommu_device_register(), which iterates iommu_buses[]
> and fails on an unregistered bus.  The match callback always reports no
> match, so no driver can bind to these devices.  A follow-up patch will
> register the channel devices on this bus.
>
> Clean up the unmap pools if dmaengine initialisation fails after they have
> been allocated.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/dma/dmaengine.c   | 28 +++++++++++++++++++++++++---
>  include/linux/dmaengine.h |  4 ++++
>  2 files changed, 29 insertions(+), 3 deletions(-)
>
...

> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 805668fbe437..14d8f182c7cb 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -412,6 +412,10 @@ struct dma_chan_dev {
>  	bool chan_dma_dev;
>  };
>
> +#ifdef CONFIG_DMA_ENGINE
> +extern const struct bus_type dma_chan_bus_type;

New API, need use dmaengine prefix, dmaengine_chan_bus_type

Not sure how other dmaengine support it before? Maybe already block for
long time.

Frank

> +#endif
> +
>  /**
>   * enum dma_slave_buswidth - defines bus width of the DMA slave
>   * device, source or target buses
>
> --
> 2.34.1
>
