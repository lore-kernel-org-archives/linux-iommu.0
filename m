Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013018.outbound.protection.outlook.com [52.101.72.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27F53769EC
	for <iommu@lists.linux.dev>; Thu, 17 Sep 2026 01:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789608586; cv=fail; b=FoXzy46LjcYpRTSzV4Gtz7mEUOEacbpv8E0iXjS2RJJa7QHRKPKfq30Sl7RjY20wRm8K4k3ucTH9jPhQzV3fIl45ykYqeNTRTbQ2CoL80+4shQq/FvxyMLSNrYY0QPKX2t/HYE5vM1TBz3ExhRr9hUPsZKBOqwjoWQlNh7cc7yI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789608586; c=relaxed/simple;
	bh=BfU7LPGobMi/DTKH/bIrkpzuL6aUYJC1vXu7bGdseFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A76Vnpu/5DN1eXarFeMWH1t8xv5LtOo+OWuqX6maSKPKz1UgsLUQIzP35dbG/MGry8z2AfNKiDvvICPoCsS9e5LiQEzan4gpkMtjm8nVqIMlLFZf/0i2hX3LLKkNXYif0woE5aPobgNHC9xewUp/GRlm2KUVT6kwMYB1gyXOwi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ONq0Kqfj; arc=fail smtp.client-ip=52.101.72.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ONq0Kqfj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aMLJ8/a10F39Gm+U7/x/wpp+jN0k+YxREGYM27yuiL/QZnPfqbPHJMqxK3KdYwq2qxyBsHQqWCZNXieCa/7IZC3GkEdzRCeJABIRYPHAHfI5MilXru0f+Ty59ZI5y4j6uIViNn4kYmP3g950A3se6E4XhSge8HSJrOctwJkdQt6KgaKloIc1d20yjjj5G0s+Mlytxo8u26mQxLyWO9qlIOK7SFIOS6FPHYkNLESAl8ZECgIpb++aVV71fbLDpN/RFmNAROWqKBL0Nfq7sKpf8XdwSTrzefexviIAvNfGBhFiVedrcVQdszLokfB0CjgKld7W5IiF4YC4DLFw9XsAJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrDm+w5JVDK58UejizeyXKNYWhQ9/YdYtHwWPcPi0rk=;
 b=yy2Zwk40kSoJadbMk30J0iI8cF1R796rVAU5hTVhMVlUEViBJ6R1h4kT5lrFIcO6G7MsfjfW54YfwUFTePXoVebUaTkTzi+uqPbPnPQ2S0tSt7NxWph0ZfagDy0P8vtgar2N4a4ZVFk5Nz6MUQMDdrUSu6PJv4aVmoqaFVWAcquDxsJgmbH66KQ8QdoiX13IVXS/7KxmobH8qYnfkvH8of6LAdMa7FdXLqEgc1tnhV0EKE3pgg4Gh31+6VDGwnBUkQeMNSAvVGJAkSyqAW5zYUgD7HXjxej2G9jfFzj+LwuUP/lYnwquCywCGk2JrqYdaR7Z3h0lOqNRBPiXJTOMOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrDm+w5JVDK58UejizeyXKNYWhQ9/YdYtHwWPcPi0rk=;
 b=ONq0KqfjEsTr3IVvtI38WORc5ogj/KI/j+emlohr5QKijS3VRv5IsEQApSwkYgbdElGb0T1uovZm1/F0IaY/JJcCX5OqN/o8dEPUb9Eh4J2y1WF8w4XgMw0DO7XhEAPUl7NjFLeG6AfbskerTFq2ha41bMdtKH0nXoOCB4BfHOSf/6OwWXUvCzLStl9hL+PYwPxw9YYi0pyxQ4aTWuuv9nv3nnLl9XC0S1fjkPm6iM2o/CPmYT6xmTBxxsu6YhAGtia2ZuJr51yNN9duLz9GholX/OvrQ5GpMi2jRedOAvM4czoycReRR2Yf4HoyHM01ZFcKfmtYUauqzDDvyey6tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAWPR04MB9910.eurprd04.prod.outlook.com (2603:10a6:102:380::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 01:29:38 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.009; Thu, 17 Sep 2026
 01:29:38 +0000
Date: Thu, 17 Sep 2026 09:33:55 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC 0/4] iommu/arm-smmu-v3: Support shared Stream IDs
Message-ID: <aqtDg1EH95RYOdCJ@shlinux89>
References: <20260916-smmu-shared-sid-v1-0-517384504aee@nxp.com>
 <20260916161018.GE3196566@ziepe.ca>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916161018.GE3196566@ziepe.ca>
X-ClientProxiedBy: MA5P287CA0071.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b3::10) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PAWPR04MB9910:EE_
X-MS-Office365-Filtering-Correlation-Id: 39356197-8c90-4d36-ad72-08df145b2377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|19092799006|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4SpdiQvtVZ6rMAHemZ5Vh1UsFLjEtiLzWWvTmKT6KDkPibAB4CPPVEZ+0CWHPGR9hZDiYKICT8nqDYno7nc8WNgZDCoL3GVdDPTyizna6b7UYRz8Niijqyp6caOsJv+Q9tUktD0QhpJ3vO9Gxh8gh+k+CnT0BUSyJcZRcfRx6fFJ/4bYpxsiq3wvFh+2XT74De82nUYr4LDZ2Avtab0zcF+//6GVsbVg/v9H8EATzUzuW7yd1BjuVIczCLMqVeALRYKR8tIyCTot6WZB/+yEtndHiF6jK0J5CiIBUoSeF5cbZRZw0TTZWho67C87iF72rNoM4Uf+MGmxHLF6sOg0wE7V9ItOPwxW81t+JAT/tLuYGR4FYdHJxqalx6SW1c94s5JJs83cGf/hiYeo6AUEIIgoDO5nXA/M/pIN6zxJthQfUBwevZ2Z8VxurReVqx9P61THuuUzpx3n+e9EhQxfdugXs2xPaskc50IzRgDZfXQL32kJs5Bxxe2UDCkETPPITx1XX/V2i/WqdLtEMl4WA/xtt9X9i253+UghZcONfvBbsWmClKL1dzhilU9GQgSZhojShtGlDssTkyxxB2QH86qqAvs4d/pQt6ha+W+faUIbhuc2ZDTt/e6t/QFGo3id7RxezCP8DSoPC6GJ7h3hIfeytMiu/YYoUnBv5S4MFes=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(19092799006)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D0rn1KXhDlYYBtfRaU9nUBHp66Yhw8xOSvd6NTmBxcwXsCycFFWa88cWA0et?=
 =?us-ascii?Q?2RIdHi/icFBKX8qB2aJavT2AwCZCngTtMHlYkW2AOYRv0e3JvSz1WkaUkDMy?=
 =?us-ascii?Q?67vLl0vBuBTCROhdbbV1h2T7tCKkduzoTT0LFDE4OTnVh0l1FwSUiRNuzvvS?=
 =?us-ascii?Q?ZIBXRMmCq4OkkdHvVGMJV3t9DXLoSQZ5bZTUioKfTg/1xNLIGsQjskIvtAvJ?=
 =?us-ascii?Q?LqZXkxAKNtA8O8thdC7Q4QvNN/eY6nmKKbPQxgaKq8gbk1uUrrpII7+pgrhU?=
 =?us-ascii?Q?bQAZ8Ll0FvPskZaM9FjmqfrH8kQzYRtegfhmtdLJeUlGdvx06Db2N51ARDrK?=
 =?us-ascii?Q?1I3ChGH59If5L8PXYHJBxkB4uXiHazONgUw27S3nu8z8Mj09OMqc/HXMGBUt?=
 =?us-ascii?Q?lWZuYu1miWktWRJ0PXVcW88NrPabzSzpG34nv8IYT3A9NxLbrpeX7Nvnrb18?=
 =?us-ascii?Q?xYNCvCGUVsBIjsbeCxvUzqVljFsIqJgMHKY8X4ySAINqKkrz6urbjU78lsBW?=
 =?us-ascii?Q?i3kw2a5P6Xy2dAm9+rra8EF3GQkX3+s4PWdHW1jFeNBimIgALcNJVxYiLahk?=
 =?us-ascii?Q?YgQrZlDxcmfq/V407sSGNYnyQezXQte0GHSxqPHhRG+jr6mtyjxBZga8qvvr?=
 =?us-ascii?Q?xn4pJ75DdhbzZSYKbzzLEamjPtAJzkbjUzZEjCSi2NTAf/GH0uy/OM910QbP?=
 =?us-ascii?Q?UkrhI7wEqKEqEMrhIhk9SAwoq7e3JGHDEZmITBN5Z6sFCX6gSrcfkHb+yqV5?=
 =?us-ascii?Q?8VgEhfQqDlM2S0tUUkDEPGYG3yT5YYXDR97C/Ep63rlXYHZ/QSt/14wUYf+W?=
 =?us-ascii?Q?7R/t+wkxsQjsprQ4KuW4qNbFstfwK9q4u/r2MCCIsw87HTTGafxhvZJIwCAB?=
 =?us-ascii?Q?KUMr+jKju2Zut4KLpwgqRIGrFaTKOVpilchVfeyHbWMzP9ArBMW8qKWQOGQ9?=
 =?us-ascii?Q?71awdTAa5/2/t84GA2SRvciNCfysG631c/Q2j437Yp5WahvMoYxN8r4l7xbJ?=
 =?us-ascii?Q?JT/MllKFFkQ6houSzo1PSdCVwH0RfDMrReQj6yw8jREZgI7ZqrEk6z92wDOH?=
 =?us-ascii?Q?CCFAi63YN3sSSu+cQFJEGcSiy0gkNAZjJ0mh00aDXMyQEJFteD01I8G/n9M/?=
 =?us-ascii?Q?uX6mIInzPtxhvk8tKuw3qIAIxEiBJKcIOc89o2Hyhd3ZU6sAtVEiruAhCNxy?=
 =?us-ascii?Q?bCZZcQiZul9oafEpEDzdS3Wm4DA2bW8B72/urz4oMHdsBmF+kQuxxq2uCP22?=
 =?us-ascii?Q?4RFv/6SyOCG45lIFxjVCOQxMH9RQ6HF8FNY+aTLWiURJUvoC7Sdp65y3ItkT?=
 =?us-ascii?Q?EZeO3nApIntLj9ElHSEfeHQkm0n6LtfhpeBDcw7NgcdO20mfouulQFYo1nwN?=
 =?us-ascii?Q?8pCt/2i59RVx8dEUpRJ0egsYBNPunuMnNeZZruCSuugFQIwks99LypbAihCp?=
 =?us-ascii?Q?SMEMCXibYJyWPK0b7gQ4mqLrpqwg/22yeiCDye1ukjMmDJNkv3mvo8lhgcSI?=
 =?us-ascii?Q?xrJvZKJaVKtA1m7scTiZn8fENF5oXG3Vv0X9rpy2Y1eiJVEk49LDO3FYuFYA?=
 =?us-ascii?Q?jzZSnAsVdW+WZap0eRK4IWGbSdVpZ1SZ+yhwsiJC6OJDZya1hQLyaLddD0T6?=
 =?us-ascii?Q?/bkQcNj2oCrWceaxl+yl41G2img6Mh+ud8iZdM9OsQTDJEfmMYMDbI5BUoXS?=
 =?us-ascii?Q?nlUUlKct29UuPKWIZVRGAZGhxA4+F7y3T2VzkvDb1BMKXW94NxbHkUlBpdWR?=
 =?us-ascii?Q?g4WqrcVkRUQVj8Em8YpFijke0wFTLjnDg4BDyOkbTMymVPLkaTik?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39356197-8c90-4d36-ad72-08df145b2377
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 01:29:38.3171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d8r/luRDXD9mjSK2VQkDOiNZaI4vJhcwNNy+4/3w276XdtMNhsYNDZcL/d5IU9eic1Z3VyVC46Ci4MnwmxoyymejHAKKqkSXG61AA1P857Clte5eG71bI6Nc3KhLkh+4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9910

Hi Jason,

On Wed, Sep 16, 2026 at 01:10:18PM -0300, Jason Gunthorpe wrote:
>On Wed, Sep 16, 2026 at 11:12:33PM +0800, Peng Fan (OSS) wrote:
>> Some SoCs have a limited number of IOMMU Stream IDs (SIDs) and
>> hardware that inherently shares them. For example, the NXP i.MX95
>> eDMA controller has 64 channels where each TX/RX pair is assigned
>> a single SID by the hardware - the two channel devices are distinct
>> from Linux's perspective but present the same SID to the SMMU.
>
>Is that a reflection of poor DT modelling though?
>
>Why must a TX/RX *PAIR* have two platform_devices nodes?
>
>Fix it there and you don't need any of this? Or is there more?

I think there may be a misunderstanding about the device topology here.

There is only one platform device node for the eDMA controller
(dma-controller@42000000). There are no separate platform device nodes per
channel pair.

What happens instead:
The fsl-edma driver probes the single platform device. During
dmaenginem_async_device_register(), the dmaengine core calls
__dma_async_device_channel_register() for each channel, which creates a
struct dma_chan_dev containing a struct device - registered via
device_register() with class = &dma_devclass and parent = edma_platform_dev
(see drivers/dma/dmaengine.c line 1115-1125)

For a 64-channel eDMA, this creates 64 channel devices: dma0chan[0-63]
These channel devices are not platform devices. They are class devices under
the dma device class. They have no DT node, no of_node. They are purely
software constructs created by the dmaengine framework.

The iommu-map property sits on the eDMA controller's DT node. At channel
allocation time (xlate), the driver calls of_dma_configure_id(chan_dev,
edma_np, true, &chan_id) to look up the channel index in the eDMA node's
iommu-map and attach an IOMMU domain to that specific channel device. The
dmaengine framework's dmaengine_get_dma_device() API
(which checks chan->dev->chan_dma_dev) then returns the per-channel device
instead of the parent platform device, so DMA clients map buffers through
the correct IOMMU context.

The shared-SID situation arises because in hardware, each TX/RX channel
pair presents the same Stream ID to the SMMU. So dma0chan0 and dma0chan1
both get configured with SID 0x30 via:
iommu-map = <2  &smmu 0x30 1>,
            <3  &smmu 0x30 1>,
            ...
Both channel devices end up in the same IOMMU group, but currently the SMMU
driver rejects the second device trying to register the same SID. That is
what this series fixes.

And merging TX and RX into a single channel device is not possible -
the dmaengine framework allocates one dma_chan (and thus one dma_chan_dev) per
direction. SPI/I2C/UART clients call dma_request_chan() separately
for "tx" and "rx", each returning an independent channel with its own device.
The two channels have different source ids (e.g. 83 for TX, 84 for RX) and
are independently programmable hardware resources - they only share a SID per
hardware design.

one more point to support SID sharing is that i.MX95 only support 64 SIDs,
however there are more than 64 DMA initiators. 

Hope this explains well.

Thanks,
Peng

>
>Jason
>
>
