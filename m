Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794449820;
	b=y2DhA2sDQ6BXJsW6RSXDoKb7VS3mOm7KLQhQCyMGnN3zHhm69DGfWP0qfSL8/OOML2Ng
	 RnFjZEFhyRZ6BxTpa2g3oCDAaPuUR6JEp9N1Q805DnXOCwblZXhO+PRVcfPxRN4NNm4ip
	 DL01pG3ttDy+5zUUGdjpayztNpPZm3sD3QdYxSxUfOZiGGpctANoxjVWbV6+GOPs+WDeJ
	 K6CUA6qj/dVCA9ELhJOoWdWxeuylPy24qFfL4Fzl47MdftoZNaul/KxZ5Ymvt9YQCmzMn
	 muTUj1sg23nd1DTNjX2JAUg3c83VZODvnD/+nxsr0NG2EWYO8/FiRaMRb8HBIwZ7xGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794449820;
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
	bh=eyRIiBAFu2SpbOBwKvnYZ8pUhbfFagSF6LXukhchBnw=;
	b=ubXsJbAgZunMvC9LgulYNij8SfMvmCdgiCis7VCIiYkDXNxg8x0w7Zr36Opvn8/VMTKP
	 +2SBcd7WPejqQczmkdpgnzJmNYhImEKyM3OKLTfuqpYPFmoI/Etinnxl8bBM3dYUag02a
	 nSySaSH3Mtxq0y3Br020nvQelvUFkQBYUQBkUveXfG21e0wKrRDzER25LPQrds5fthmC4
	 CYELXvj5VnqonNl6eb02N2Zl4Sij6uN0HOoFJvs27RDrKknrU4omneyXFmOoWgcRmxReJ
	 Mr3ThG2UHD0aoSk47PWMebTrAQkmAI4GRxSD9zROXqPCifrgqi7gjalgbVXAYp7kkhA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Ev+SsUh7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.42
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010042.outbound.protection.outlook.com [52.101.69.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F9A606A32E;
	Thu, 12 Nov 2026 02:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29F9A606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Ev+SsUh7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZ9MksyNzyBbH1vwAzlUxEC3h0mlixPIOgO/R3nreVDxjCn0ctU6m4uM1siJF1LmS7rN9MV9OUsMO8r7uwKLRsjNkX08tVWEFimfei4q5zmM94YkEb9Ls51cekCPLn6bqPxKOFTubHigUbnnV4B2fRZwDlHxQboKKA+gS0BUaDEKQMBXj7YqoElW4LYrAS96i8+9i92gjyzVYuQ8+cq1l09kw61/KzfXH0zb1mf+Fa8oCsmNCIJhehOyB5U/VZ7yY7/EpjMJrLHEMmCDePSshf5Sre3l1E1u/6NTMYwVU/ZZrp5P7qFXucq/Yunkoeq8VUYLVk9Tq9dmLuCjUE3fow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eyRIiBAFu2SpbOBwKvnYZ8pUhbfFagSF6LXukhchBnw=;
 b=fwtxyVhwsRSOgPeLlLuyff0bnQCQipapnMf5OdMJkBJ6mL8tcF2BHxLr3TX0yJ/3GGPuPvgbF3wRS+e8YmiFdNBwf94kH/5fx0yeCZwLKIVR7rpchQLQYbgB7o+Uqrofm9u48hLLlsqAdHIRwD5LFHpmFLhxmMbcQGM6w0pEpFsMcrlupdhofbVq6Wg+VA1ce4rTee1nI8yRF2UfzI+ZhhPDQoJRh9ljyEUpRgEzkuqCXc1At2DcOUOkW92TaUTyNB3Tkyp6Yhm3A7oZlnbtk68dnH7/urOINf2KLoViyY/RmfneNH7GA8Rpm6yd0gWr8ynKFR0q6awvbJ2U9unLyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyRIiBAFu2SpbOBwKvnYZ8pUhbfFagSF6LXukhchBnw=;
 b=Ev+SsUh7hc6FXeroqKpmBxx0k2QWfti/evRePkBeVxeGJwRvWFhZR8NXt/twx77GXrAh5DnNMezo5keALoktUxdyQznqIjKMxIAOuVv2pvqVl9XhZWOg6rALlaD5hS22M+GwirnccpWlCkfqrfzjFiu5mEwN94qoHQD10Jg3l7RkmjfM4u+0/vXITsph4ak30rYqPvlWae5U/L7MKCGAd8mp0e24JS8+MExQcQouWzvpW8WqQqiL7PytgGNlUZV8WZk+holbT2qKRZCG+oFx3T9yrZHe3iNTJhpvZN+biXsyJkiKQMwLhFplqVe00DxQdjpDnnI2SFSIKPvZbWYorw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM9PR04MB8522.eurprd04.prod.outlook.com (2603:10a6:20b:431::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 12 Nov
 2026 02:16:56 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 02:16:56 +0000
Date: Wed, 11 Nov 2026 20:16:39 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Peng Fan <peng.fan@oss.nxp.com>
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
Message-ID: <avUhh6_vdOg-g1qf@SMW015318>
References: <20261111-edma-iommu-v3-v5-0-2537cebe6ca2@nxp.com>
 <20261111-edma-iommu-v3-v5-2-2537cebe6ca2@nxp.com>
 <avSmdAQhFqKIOMis@SMW015318>
 <avUH9MXGu5AzEkv/@shlinux89>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avUH9MXGu5AzEkv/@shlinux89>
X-ClientProxiedBy: PH8P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::23) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM9PR04MB8522:EE_
X-MS-Office365-Filtering-Correlation-Id: 74f9d641-3084-4472-8a67-08df4063067c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|19092799006|261021123027099003|261022105027099003|261021121427099003|4143699003|11063799006|261028144727099003|56012099006|5023799004|261022075727099003|261102124527099003|261026121527099003|261102123227099003|261026140227099003|22082099003|18002099003|261009223027099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	7KA+Ie+76sVt1INwv0d/GqhV1Msgunkk0PXZ2NsFoF9f8V35Bd5d+y2iggoRDbSIPAGd2e832jWhDE5QxeXtckttbtW4QE4VqTKMZdj5ObWiqZ3fwR5naaWksAVTuOAnuDWVpnBTwRTMtn89CZTw8NIqUNtSENM8RsOY5Vd4HW5AHHU7/s4/NN9XZILvMLCzxJZWWzU2j/+H0GUE5GHCrWG6mI89DCQ5LKkhGrbR7P0cFLiiX8cgKVlxtcUurvPHrhLQN8lWsq9Hb4dBR2LPZdQ0wzAxUrDz0+MYl5O6ahKAc1hW2j1OhTBH1mLVEH8+jqCg74LUEi8DEY47GpgKOrTJH+9vTNfkFskrGeq5atxkYhkuC6M5PGGnuWXBQ8mtr3yK+RNylW/jmHRLACkDlhFXHCMmV7PWgpDBjO7UXQZeknvNFSCmdE9R9+5137iAZI8P9gCrQtdsebBoTrlf4Z3bO8OpLr7H+XwE6HHlpuMXGX5tUHsX4breZEF/BOl4mWfVHegDaGI/6uLqPsX0cCl4Z12rYEpfhcxtj8SiKyKR0UQSNxscyaB99l2kRLbN7vCYVC7cOtOKQos1RAhX2M7hJ64fChnCNDYDrn6+/bI8u0GQbmVaFYMIl0HRl8w6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(19092799006)(261021123027099003)(261022105027099003)(261021121427099003)(4143699003)(11063799006)(261028144727099003)(56012099006)(5023799004)(261022075727099003)(261102124527099003)(261026121527099003)(261102123227099003)(261026140227099003)(22082099003)(18002099003)(261009223027099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3X/3d9BqBOMNXH0aG5m+q6MBrzlm8+KFNOMjEg9Uu6dqzYpqgQMmiTlywq72?=
 =?us-ascii?Q?3FdBp8mZrpxnQMoEXoaaiwCNhpRkmMs8th3e/w4qHFERTNOUPhNGiybwazko?=
 =?us-ascii?Q?7fzRX7cjhToOYeDjxuEJreKbGnvguy77xhEGFiegqFRDPC5+vn+WKiudsZpE?=
 =?us-ascii?Q?oqX5CyDDxul058XnXTOa65A2T24TeBLa1gR/0hSNtet1Y3AFriHA+M/RMpg5?=
 =?us-ascii?Q?nO4s4H6oULt/XxHGfTrRa/secd2FSnT9MRiwZnAlcMBztAXecPV+87HqL5Ce?=
 =?us-ascii?Q?5HnuYDPAOPuh+sCGPqJkyJxLOolePOJWigopwLDhiPO4f29fACGq9QpeDD99?=
 =?us-ascii?Q?hVCSGEjPazh+DcI4hOBBYr6NxD3DSJXcAK5Qh0MtMe5beBX+Tdmep4AMDtw3?=
 =?us-ascii?Q?fURnv/yT0/N/66dbJcbu2WwWn6BXaOHvZOkTdJTzZkFBd1ft/8LdqCmCFLk7?=
 =?us-ascii?Q?Z+zqW8hnIXqA3Qy6coeBA7zCgjDiOkaHR4SsURDKnjgEYbkStuHNuC+icwEL?=
 =?us-ascii?Q?+s9/7BBKiYAV7JO8k3GZb5Od7o9BU6LGfyfCS1m3tdHHfIAEJTteWJcTNhOM?=
 =?us-ascii?Q?+mEUzbgnO5hWmka0m9UWix4S2HMTcd+fxccQ7/VKaIIjwF7o12BafXN5u+UZ?=
 =?us-ascii?Q?KQirfhu3MMjVPKamzhW45mo9YjQWPXmtrb7Y6NPJmsyQnUpZnFJ1FxDgcGx8?=
 =?us-ascii?Q?Yk5AOKpUugRhgsrlzQMkrcVfxIjbRmWPu2kQIbZ7UcBsbZP9Tq7PC6HHEW8r?=
 =?us-ascii?Q?b0N9LUBNA111ffYheW+CJKwi0RNQ8Yl7h3TMrTXNkkGLLvFyI0mcofs0x9pv?=
 =?us-ascii?Q?8aGRl4xMZO1hP5f/1FCY2j/1KEy3vhz1dCTQXNJjkLJaheaSaVcmjHXGYfuS?=
 =?us-ascii?Q?yU1H83g852vRgHI92s8FyStzmFrqGb1ILRJnq4FREMEg5NYTchml90lq9Q+4?=
 =?us-ascii?Q?7heBZRhesT/rBdDwG+WwIbC+SUewt3KFumeieCwcdCYmYaZk53XzG9ASiFo/?=
 =?us-ascii?Q?9q3ICBSpJQLw/zMS2WMXor+qUVS/nRT6i75EGAjPrJ886wINbATcmMiPBhZL?=
 =?us-ascii?Q?U1sngfBmkuu6ZFolsbvkmbQeDnRPHYj+6Om8NPQdlNFWoG1q9fwhvpcsgP1J?=
 =?us-ascii?Q?gSSHi3/cAZG32naXXyfIueeGP2+QQRQlhuT6Rw6H+Q7q5+EIZ8OEfbOt9TUV?=
 =?us-ascii?Q?tJqA5B2teSpYsBWy9pNbMUF5Af+ZwGV5sN1a11QLCukSf/KlGdLV66BkPAHI?=
 =?us-ascii?Q?Aha+W8gapUwS7t3mkZOEiT4DA/b3dwrUJkDx8bKkopZgW1V97bbGOSX6EXo+?=
 =?us-ascii?Q?q2GoJZWhsABnvkwuhq6S6O2h1kdpQLM0ctWcX1J/O88hT3cYpNq2ZsxXuYV+?=
 =?us-ascii?Q?+bs1sO2Tp0cgrfSDv1Tbli+2QrEoTkrCD9M5UAsY9Os5uE4T7l1SaZ17fUon?=
 =?us-ascii?Q?z7m26eX+QaPr75eIVg4b0/6I3c2ZglxpxhZHcvdGoGuBJRkDNMzkJxZgPyWA?=
 =?us-ascii?Q?oSGmmCq39C4puuG5Z1qatH9bdUoHSPEJDogo8VvGZshPeggUIc/1Neym4MYU?=
 =?us-ascii?Q?x/xAFdkAmd6LUS0hKb0pE0/r5TjnnHtJb4pqD3xQUzRlxKxbgf3rfN+k81JY?=
 =?us-ascii?Q?kruTc18r8r9LaVhOduNjL3/uJjWOSkl3dJk4NdOKrF9a6EzozGoLbdIHp2PT?=
 =?us-ascii?Q?qBVA3sXqkBRivOibU8BHMspXLklmuWceMjspo0tSgiH4/bQbVFlU0JSj1H9V?=
 =?us-ascii?Q?pOTSoLSVb24GrwgyqCh3j9jFZrLLcmWxlFwTbBj38IfPM+LK2upX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f9d641-3084-4472-8a67-08df4063067c
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 02:16:56.6891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PhlRRRhHP+DnbFA4IdpbzTVY6quxe703hOQYzaCAU/UEgPtfO9BDwWUJ5Zw1qEgh6PJFqdaXLezLtZ7SAN4QUHO9U4GqTPJ8mQM0HuNO/wsw25vHWHTd5rdncScq+s3B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8522

On Thu, Nov 12, 2026 at 08:27:32AM +0800, Peng Fan wrote:
> On Wed, Nov 11, 2026 at 11:31:32AM -0600, Frank Li wrote:
> >On Wed, Nov 11, 2026 at 09:47:30PM +0800, Peng Fan (OSS) wrote:
> >> From: Peng Fan <peng.fan@nxp.com>
> >>
> >> DMA channel devices are currently created as class devices without a bus.
> >> This works for sysfs, but it prevents per-channel DMA/IOMMU configuration:
> >> of_dma_configure() only probes the IOMMU when dev->bus is set, and the
> >> IOMMU core only installs probe/release notifiers for buses listed in
> >> iommu_buses[].
> >>
> >> Drivers that need per-channel IOMMU support currently work around this by
> >> assigning dev->bus after device_register(). That leaves the bus subsystem
> >> reference count unbalanced because bus_add_device() already ran with a NULL
> >> bus, and bus_remove_device() will later drop a reference that was never
> >> taken.
> >>
> >> Add a dedicated bus for DMA channel devices and register it during
> >> dmaengine initialisation.  Use core_initcall so the bus exists before any
> >> IOMMU driver can call iommu_device_register(), which iterates iommu_buses[]
> >> and fails on an unregistered bus.  The match callback always reports no
> >> match, so no driver can bind to these devices.  A follow-up patch will
> >> register the channel devices on this bus.
> >>
> >> Clean up the unmap pools if dmaengine initialisation fails after they have
> >> been allocated.
> >>
> >> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >> ---
> >>  drivers/dma/dmaengine.c   | 28 +++++++++++++++++++++++++---
> >>  include/linux/dmaengine.h |  4 ++++
> >>  2 files changed, 29 insertions(+), 3 deletions(-)
> >>
> >...
> >
> >> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> >> index 805668fbe437..14d8f182c7cb 100644
> >> --- a/include/linux/dmaengine.h
> >> +++ b/include/linux/dmaengine.h
> >> @@ -412,6 +412,10 @@ struct dma_chan_dev {
> >>  	bool chan_dma_dev;
> >>  };
> >>
> >> +#ifdef CONFIG_DMA_ENGINE
> >> +extern const struct bus_type dma_chan_bus_type;
> >
> >New API, need use dmaengine prefix, dmaengine_chan_bus_type
>
> Fix in v6.
>
> >
> >Not sure how other dmaengine support it before? Maybe already block for
> >long time.
>
> In drivers/dma/tegra186-gpc-dma.c:
> 1543       if (use_iommu_map) {
> 1544                chdev->bus = pdev->dev.bus;
>
> I used similar method, but Sashiko spotted issue for v1 [1], we have to
> add a new bus to handle it.
>
> "
> Does this illegally modify the bus type of an already-registered device?
>
> This is executed after dmaenginem_async_device_register() has already called
> device_add(). Since bus_add_device() is never executed, won't device_del()
> invoke bus_remove_device() during driver unbinding or removal, causing a fatal
> reference count underflow and use-after-free on the global platform_bus_type
> subsystem?
> "
>
> [1] https://lore.kernel.org/dmaengine/20260916160608.099201F000FF@smtp.kernel.org/

Can you add it to commit message to know why need add new bus type

Frank

>
> Thanks
> Peng
>
> >
> >Frank
> >
> >> +#endif
> >> +
> >>  /**
> >>   * enum dma_slave_buswidth - defines bus width of the DMA slave
> >>   * device, source or target buses
> >>
> >> --
> >> 2.34.1
> >>
> >
