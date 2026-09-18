Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011022.outbound.protection.outlook.com [52.101.65.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B994E5332
	for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 11:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789731861; cv=fail; b=lKft1RRet2UfUC4DGbHv//l6qQoUHvF5jemXNrsT8wEqk+3JSMZ5zjOltqfm7nR4R7l0yTRHObZSmSa8Xb1ZjODzHd6gCwnb0tqxPf5kRNsRQtvYBVTYcnjNWVvxe4qJA5wmPOheA4BYattk3laZ95bpmSriD13kUHy4bcj3Hg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789731861; c=relaxed/simple;
	bh=XFTqfCfqqFeD9V7SxqVap3/7Hp9lpqYJV4hXAOF4bLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I6kGyxvFFTCP1AZOUDP2z/LWcvKnuHOcjbTBq5u1Li6RIXWsJie8kwXTI7OjdZuM2p2YXOoto2D39qijHfKChS+wEcBcvBp3Z27KViQGYwBcUyUjw0ehE5kgfSdpA3QhDPIug4V1NK1A9tP8NjqjTBLuBwHdqU7z4VS08fdmYK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=DUdgs4IV; arc=fail smtp.client-ip=52.101.65.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DUdgs4IV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKJkDGIA+TtBQvvAOYVLEZXcyekhf8EWm3aeFUSgFEDCWhIhxfsDgWz2UBzFMgAtTV3sWx+htdJvjQHNRAsm7c9qcUP3Bu0PwYfMo8mcLEtFVhBwSAGsy87EYrvwriYuG0gDdIMZF+D6HB9bsJ9++qkk4NzGuzEIpx9No1mPSH7TMlzceEwW25Qkh0LbP8FU/nLSRVr0NvOqjZ9ZEDyCjFBbEH+vrCsRTfXlQa/waMmh0O0BfoXXHqStdnUnEYhCdLKHhF88t195jrluVWDlvvRvflyLPX1OqGk3IWXu51yURBbvaoDJiPavI3QcQ6UinB6WAxUh3fTm4ek9trCEbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5i7SjkLtKYWRDBq+0CnT3WolIPaeSh2z8kD5qSlVSPo=;
 b=SUVhc3xaVD+GvNGSWTauk+Kgnj2wBo9/jP3uLbTrmQoavYSD4q7EiSH7zkonq75jI8BqM+SDDtsBP3lLWYP5UssibeuK4gvKfciKQ0Dp5CgTzoAxZNP5uudvYsG2tTmmHE/qzAaCJhJYoMYxm7767jLhjJYYf32Blk+YBLAVr3/jmTMEtvGp/O9lTqoI4mnHauTFzViTsOWKf8Gj+qgEq/LhM4jaS4TP3IUAMI98uM2xf7vlbBN9fkjVlx1yc39+gni1EDA+01LkVOVd4hCUIzJcI8Zfp2AsL7oQVaylUdRRerKdnQy/xhvAuL0HMUCXNOM2035afzLMcU7PT26ejQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5i7SjkLtKYWRDBq+0CnT3WolIPaeSh2z8kD5qSlVSPo=;
 b=DUdgs4IV6YGG8oENInqVcIY9zWFijfRSH8YNS9hCqt8xmMIZd+K73QsNmaQnow4S2HE/JrvPNSGPn4HPHJSPnFIAUuZ/+bq1ysIXsMG6rS9euGkJ+GNr72hvuJE+Wy8tN/+RqezR5TlCvpgOZuaU3NC/2NkKuoNEQUjlhkc9HfGWqskisFJuP2ZBZyKioW4IvhwE7q1pxcPPP8UtW18I7n4XG03GB8EiqGJZM02bIbLY4Nt2IB1FDwcUwmXmyP/o0sj/gsFz2bzl7jDEODy20gcnOTzOk1qt9fgkggiuI1/6nyvIhPBPHRZQ3mwh08ycFok7D3ppD+1l1t2bQQjvPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AS8PR04MB7541.eurprd04.prod.outlook.com (2603:10a6:20b:29a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Fri, 18 Sep
 2026 11:44:16 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 11:44:16 +0000
Date: Fri, 18 Sep 2026 19:48:34 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Frank Li <frank.li@nxp.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC 0/4] iommu/arm-smmu-v3: Support shared Stream IDs
Message-ID: <aq0lEk56qRi93geW@shlinux89>
References: <20260916-smmu-shared-sid-v1-0-517384504aee@nxp.com>
 <20260916161018.GE3196566@ziepe.ca>
 <aqtDg1EH95RYOdCJ@shlinux89>
 <20260917144804.GI3196566@ziepe.ca>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917144804.GI3196566@ziepe.ca>
X-ClientProxiedBy: SI1PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::10) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AS8PR04MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 3033c579-8297-4b13-67cd-08df157a2abc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|19092799006|23010399003|18002099003|22082099003|4143699003|10067099003|5023799004|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	TP4dOm+jAy+FI70PABu8x3+JrmkcB0mmR5N4iLIJ4510C5MfnfPuDFOQpL5RsWB4c0Q/pw858C8n9fuscZhXhR3bsQkLk2kqZ/B1bj5bgF+6J5MD0tUAZS5phuKyCXzbIgYyVaOKfXgzkMkMAZHw1bYQ9qVnZ7zDaCWl2aGLA2NDvXFioxTu/oifUCR3oE3uJlkTKT6dPrucAnVZibpva4tMBR6xI5M6HaZDuHMpAiwyaLKlnM97iNvKM4PluXPl8P92GZHVSe5SLY4s+9XNlWWlu79+/gX5tY58gW+WjErPWdIj6J3VfLr80hxtWT2HPLJXldG6k31lx4YdRTzU2EZSw0NRROMMiNeKC/5/ia0gxCS+xJeo6qamAr/sYkp0ktgbLvE+twADMFjZquwLbYseGQb5FVB4P66bsoO6ueNcVBvZqHPzOynErpumqM0dLan89KBTCcbb0YWcPgEYB+vAOxcfPf7hyS9Pm4zkBaxDs0OU034x43Cra81v0AdIheOTjMgzsk0tAJK81GJhlnUCQ0Gl1JnQQNHUxTxx3a1mtXliS1w9Jd54+XM4bgbeeA8jK61iutwO5WRXWfoUFRNKldCbtPyV6nW1GPI8UWDBCEcbYQb5tlb5HlTAtQ7F
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(23010399003)(18002099003)(22082099003)(4143699003)(10067099003)(5023799004)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e9w9TJWN0DlZaWeqMPEuNmMaoVSOW/vxpbacB2gzydi5v2OUUvRVHMIKbSbA?=
 =?us-ascii?Q?nFsRq9xQSJWw2KmDlJPdtnl9swWmk5CELdcTbjM55T818qyugN3P3++Pnodc?=
 =?us-ascii?Q?QK846dbUgi6IORj0WlvY9tMFqSSdMRN27GjoOa/+W97uGV2V+8Ig7rZwAoIU?=
 =?us-ascii?Q?H++UbE5aFPzjTLVdC/5CmW55EpU+yj1Z+BfRE1B5kzKnCeEj4v48k1NJ32h5?=
 =?us-ascii?Q?5fPfp7lwn4zpWR3Z8qm+X8gSy3kRAzw2mNLKLEpImukZYeq8hNIijffPjFUG?=
 =?us-ascii?Q?vTjnj7UY+C6kJ+u7rq2NXsi5aMGw7n9H+/S8FCXEnhjIZ1FJMkkfO4GhEiVo?=
 =?us-ascii?Q?JVlZdQ7Ro22Io4P4JU7R7EcA0IHZuYOaUJ35kX4cyXG4XDzKhPJ0sa4rMn2b?=
 =?us-ascii?Q?2nbnE9RLv2hcguikb/rfwkXoZxJLHyZA4hwwIOeGoGRw1882S/gPP0w2h0D1?=
 =?us-ascii?Q?A1YoLnkRYDVetdtX5VmKjl9QUa8Sf69sHSL84KnECwOxulVYX5RHG+aIC5AF?=
 =?us-ascii?Q?vRQtvgJVOnVQzT6j84R7P/ZvG4q4+TufSzKTm8CytnAoXsBhdTjBLEuwZhLP?=
 =?us-ascii?Q?a5jY204W7fzACB/2r14FNaUvAHqeBj6zulyxri+RdUaJdds9C1bUvscsfPbl?=
 =?us-ascii?Q?4Rkt9cY68WFdRSH0d/LI82TPIGh965HIk6C8VXq8ee6PyBw9UrFfZy93aqPj?=
 =?us-ascii?Q?VF4VIhm+eHYcUsF9sFt3RPr9iT4vxWMWw5KLv1B5/DeOWN/V0FyYtX72x4kq?=
 =?us-ascii?Q?R5uNzjl3lVmkNxgEBsWv/6WV6K+hS1uQJ9OvmSfdZzhpn3PUdZsnJV3/r7V1?=
 =?us-ascii?Q?4W8WQfFJI7dvKmd/L8URRUn5kyp/hku7sincifAkeWVcg7d04vJo3tIQcB9X?=
 =?us-ascii?Q?Qqxr4Q2cU9xqO10jQzeoJfPO90X02nfQ3yQVJnh03dfjxn+CUFa8DRxIN8tK?=
 =?us-ascii?Q?c8cBcbEkXrxJrKK1KGKOq9vWnm44GfKjfQjRnCNLw0GM0Bs8Nx4J7C9la1wZ?=
 =?us-ascii?Q?XjrjTq16orqnqutbsTOVaPca9njsuTOjs6gJcag5xK4KNRtbSiZiFnuHlPKT?=
 =?us-ascii?Q?VPgVVzcDVyorNKz2Ld/CXguFCFp+VtjPt4kH+1lS9cFFza8KU2FKO+TnK2q8?=
 =?us-ascii?Q?627nLl84+fQnKCuxG658V+YWWiiD6Cr5ZnQZrhDJRwyH9IPSI2T5023xYc0z?=
 =?us-ascii?Q?qtBgVIOlimHPb+zUjZlhsXYMprMSWNI7oRsQR1vG4aFJZpcmTG0FTY2cWdxr?=
 =?us-ascii?Q?0GALWhnt5sfy5DIWPIlEoE21UFfJ8S7TkiRssdoUf5AhWPMOmVpQ1g6OtQqx?=
 =?us-ascii?Q?HQEDX2o1L4nno55uwaMWtfczbPG7qQytaACeBfdBxc/A7F0argQdB35PhtRT?=
 =?us-ascii?Q?mvpxwCQLrg07Do5UsWsHyTRy/w7s5mj3tmPGW9VmoUwAQmFSgs9cUHSynt9L?=
 =?us-ascii?Q?IPzwYZzbnlIBcUYRsEfJHyoaaEWYwGBKniMEkNoL2O1dQvpmBvQG/MwYVfFb?=
 =?us-ascii?Q?67JMkjchWyavvhOTLbmsjU1fRHTCEhd27/iM59DqP2bjeVKXXmkaKufLdXXs?=
 =?us-ascii?Q?2V2VIF4BP+zlmIujmbsWDQumoiPjOj8rGZf4uzysGE+o38sXCSU9mU/2wwO5?=
 =?us-ascii?Q?l3p8l70488HVuitXDQ4bjJKJOxYAvBKBKB4iuKg4hTN7ep/+7ECNvNv6sXET?=
 =?us-ascii?Q?MilH9/YaRgJ8rihwaePjJfXZ+KZqY1U/zxJK0xiLvHPdSQtDuFdNsMW4euQz?=
 =?us-ascii?Q?k8l2RZseorRYGP0E1CzrG+RnZCOVA+p278ki93+oAOIr30FgWoR1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3033c579-8297-4b13-67cd-08df157a2abc
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 11:44:16.0047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3rguOUFYO2Gf3ifJ8wJqed9HXCILG8rYK4ElCyYZxT3zn+wTSQYkUvoiAv2ayLyFcmD8xwnBu/j8ocggcVAxujN+uZt+HmvLBa375bM9kQ/RmAohqA4owOgk3NdJEJd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7541

Hi Jason,

On Thu, Sep 17, 2026 at 11:48:04AM -0300, Jason Gunthorpe wrote:
>On Thu, Sep 17, 2026 at 09:33:55AM +0800, Peng Fan wrote:
>> Hi Jason,
>> 
>> On Wed, Sep 16, 2026 at 01:10:18PM -0300, Jason Gunthorpe wrote:
>> >On Wed, Sep 16, 2026 at 11:12:33PM +0800, Peng Fan (OSS) wrote:
>> >> Some SoCs have a limited number of IOMMU Stream IDs (SIDs) and
>> >> hardware that inherently shares them. For example, the NXP i.MX95
>> >> eDMA controller has 64 channels where each TX/RX pair is assigned
>> >> a single SID by the hardware - the two channel devices are distinct
>> >> from Linux's perspective but present the same SID to the SMMU.
>> >
>> >Is that a reflection of poor DT modelling though?
>> >
>> >Why must a TX/RX *PAIR* have two platform_devices nodes?
>> >
>> >Fix it there and you don't need any of this? Or is there more?
>> 
>> I think there may be a misunderstanding about the device topology here.
>> 
>> There is only one platform device node for the eDMA controller
>> (dma-controller@42000000). There are no separate platform device nodes per
>> channel pair.
>> 
>> What happens instead:
>> The fsl-edma driver probes the single platform device. During
>> dmaenginem_async_device_register(), the dmaengine core calls
>
>Yes, and if your DT is correct then that platform device should have a
>single iommus = [] listing all the SIDs for that logical device.

Agreed - the DMA controller should use iommus, not iommu-map. I'll
rework the DT side. The iommu-map approach has not landed upstream,
so nothing is set in stone yet.

>
>Using iommu-map to describe synthetic dma_chan_dev devices that the
>kernel creates is the same kind of DT abuse from over here:
>

Thanks for sharing the links.

>https://lore.kernel.org/linux-iommu/20260618151745.GD231643@ziepe.ca/

Per reading this thread, seems need to describe VPU sub-blocks
blocks using device tree node.


For NXP i.MX95, we just use one device tree node for the DMA controller.
https://elixir.bootlin.com/linux/v7.2.5/source/arch/arm64/boot/dts/freescale/imx95.dtsi#L634

>
>So the problem is self created, by using iommu-map instead of iommus
>and using DT to describe linux SW expectations you end up in this
>strange place of asking for aliases.

The iommu-map DT property is not landed in upstream, it is still
under reviewing.

https://lore.kernel.org/dmaengine/20260916-edma-iommu-v1-1-e1731968081e@nxp.com/

>
>> The iommu-map property sits on the eDMA controller's DT node. At channel
>> allocation time (xlate), the driver calls of_dma_configure_id(chan_dev,
>> edma_np, true, &chan_id) to look up the channel index in the eDMA node's
>> iommu-map and attach an IOMMU domain to that specific channel device. The
>> dmaengine framework's dmaengine_get_dma_device() API
>> (which checks chan->dev->chan_dma_dev) then returns the per-channel device
>> instead of the parent platform device, so DMA clients map buffers through
>> the correct IOMMU context.
>
>So go back to the basics, why did this platform use iommu-map instead
>of iommus? The only real difference is you get a DMA translation per
>queue. Is that required? Are you short IOVA? Some other reason?

No, per-queue translation is not required. A single iommus entry (or
a list of all SIDs the controller uses) on the platform device would
work. I'll take this direction.

>
>You can read what I wrote about this general problem before:
>
>https://lore.kernel.org/linux-iommu/20260818130724.GA5482@ziepe.ca/
>
>It would be really nice if you all could work together to figure out a
>better way to handle this than through DT abuses.

Understood. I'll follow up on the links you shared and work with the
dmaengine folks to sort out the DT modelling.

However, the DMA channel case was just one example - the shared-SID
need exists independently of it. Our SoC (i.MX95) has only 64 SIDs
total, serving MMC, SD, NET, PCI, DMA, NPU, DSP, DISPLAY and more.
Some of these are genuinely separate platform devices (distinct DT
nodes, distinct drivers) that share a SID by hardware design because
the SID space is exhausted.

That cross-IP case cannot be solved by DT restructuring - the devices
really are separate. Would you be open to reviewing the shared-SID
SMMU support (patches 1-4) on that basis, independent of the DMA
channel question?

Thanks,
Peng

>
>If you really need unique translations per sub-compoment of a logical
>device from some pool of SIDs that feels like a weird version of PASID
>to me, it may be an interesting to explore.
>
>Jason
>
>
