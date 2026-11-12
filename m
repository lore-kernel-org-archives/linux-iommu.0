Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794499499;
	b=W+xwGTJ0V8RESuBpeofpXBnCQo0z0spyp3ViRrrZiZdun3nXJT1bHhxVvpxhf3exB7as
	 pMO1Z7rwOA3+nDeZ68ayvX8mJ+9vQT+u4tQJgeAgRJvBIjtiVtqezAOoD2XzuwZHtCNU/
	 ETR1MKRig46Uf/wWWaQcor78BzmMMCz2OLXa2AAo4Hpdg+Yx1lMHNnad8e3t2q5wHmuxe
	 YeZ0Puahpor3SfRzNW3sdlofzq6CieJPYHN9CujL7J8J1YxycKRhKck5VICkIACPGNv6p
	 xNO6x4HzfTDAlVmn2AKqmsIJSlV7cfNsB2Yj5S8LHxe6RvyHISHBHI1flXOQF4ceR7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794499499;
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
	bh=fRVsIP1nEjydFCkFhHfNZRQBYqKDzWSAFJgQcQVTrX4=;
	b=ZYiwSSSrO1OWoLoaicWNE7lM8a1pEhsxoQie4dTtOpUIRBZGy7BR40jGi9i80twadlBD
	 DrU+CnWUE8pczj8DrrK2JonGIvTrRtEZhiSfOzVF/TxvukkmEPsZYqV99BKOjtSX1YDX5
	 4IxGmsc/ol34o3o7ueq8IpKmB5mMZF/s8PrP8QT3YXwEK7c1bvgd/N+vNiqgiKIXPjW3D
	 8RqfyBY2qP6Xb52/tAsU5PH8tQmn4YDfaIW3yOEEzhwMCwOGg1/PmW/tczh7wC21qZAFp
	 pPnaqILGc+wKhlOOZcPFlnIhs0n/p0KVRfQiU2soz5vVw95IaPl9jGuhoPmoKvrkWQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=rlyu2BvO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.0
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013000.outbound.protection.outlook.com [40.107.159.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4121A606A321;
	Thu, 12 Nov 2026 16:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4121A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=rlyu2BvO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jehzur+V3BDOAYTUlpC2GkwRhP8qnsWZB6a0z8J8Ns1ZvBr0ch5uFJvnaGmGJTliPx7/c/avAkkVkb8EPFgzXRYIKvJFjTt6/+BW8AaAcDohCy274agiS1551wNE2RKDns9jdDh9nK5g90gzrlSubig/EjovZ9UjTafoxy33Esacu+nXAHaVO1tkAcv0yqrZlnSM8BWYNrLLExQoZuSnVM3I6jUTx5OsYXlE9QvG1iPeXfp/N3ELUPy47DxMWFsCwBVu6whnvdSGi/rlXlr76f2MIwzdf9ixDYntxkqmygXnk53T8xZp9ytoIkDUegGShLRoRsGBea/Z2jl7oDo0BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRVsIP1nEjydFCkFhHfNZRQBYqKDzWSAFJgQcQVTrX4=;
 b=Q5tbHn8Tc5hsFV6bGQBnSlPW3eH9B57MSIBQDYBf4bDubTgWKkRGO8WmVrdMuMosncphS+jwtJUXyj7hgOqStwiPPUjv8/p1o5xmxqxouXfHj7aIvkxzZBNA10nqInx7lEWWXVDwzNeqKYzTlOg7ChYDvADiE9ykLUnDCGa+le68uMZr+AbFxZHM2wravre0apIW1VUTbAT20Emn7zq8+lUqC8DhQ/x03R0B2ArXITe/IVUt/f6D8J+KInf3Uo5kx5zSLddYlFQx6M4F25CDmurseLRjl5pP8HC7cD3pdByEuUccLb7QQj6UtRP7xPj+6xICZQV/FKAqX9EHwo6UIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRVsIP1nEjydFCkFhHfNZRQBYqKDzWSAFJgQcQVTrX4=;
 b=rlyu2BvOkMLeM82Kqahs6ui3bPnpb4Bk1yM5kNIhIxZh8/b9NcNZnjZU0SJRd/YEafn6xo4JyFGiVTGRuYgNDJF+XJcwxwSRrD8KfpW1/niNRjwUqTN3zmY466OAMIqaqZuPnydcQqJEg586tP4XZE+CZzE0P3MPZe+pGQ4y10vp5FFYQV0KIANrpPw2+UyVRX2tpMLAfA6zBvgBrJDKG8HriOGM8LsCZ8Nzlrg5Kq1Np6biJpATT2AtgavhMeLdfihQH4WeVWV2NM8yt6sYBuz8y3uC3bnFh/VugPSlTGiGs9lojDan8G+bDrroJartQ3mVgE3IyeqonHWsbbDybw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM7PR04MB6838.eurprd04.prod.outlook.com (2603:10a6:20b:10a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 16:04:54 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 16:04:54 +0000
Date: Thu, 12 Nov 2026 10:04:42 -0600
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
Subject: Re: [PATCH v6 4/9] dmaengine: move channel devices to the DMA
 channel bus
Message-ID: <avXjmsBz03maddVA@SMW015318>
References: <20261112-edma-iommu-v3-v6-0-b038edb8ce6f@nxp.com>
 <20261112-edma-iommu-v3-v6-4-b038edb8ce6f@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112-edma-iommu-v3-v6-4-b038edb8ce6f@nxp.com>
X-ClientProxiedBy: DS1PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:8:23f::15) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM7PR04MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: 03f40934-e5a3-4a9d-27e3-08df40d6b09a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|19092799006|7416014|1800799024|376014|4143699003|56012099006|11063799006|18002099003|22082099003|261021121427099003|10067099003|261026140227099003|261009223027099003|261028144727099003|261022105027099003|261021123027099003|261102123227099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	zLc5nd1A5OetB2TEt0Yu6bHc5XTuK7MgSHFuw4YmymcKL+upCXbTS8W5jmun/vZtqwFKcSfdFLSTlaXg+xFnfoglZxeyl2/HHtHGw3uWSuxlqyVQFmdY1Sby+ie2qh8NViOLetUm72hs2lrWy2ud6Elw4wkt2UBflYz4tOgcstjeL5KKO6N01eHheDiodqHfkkWWnUrh4N0ysmq3tUezZnyLfCqVzS4pj/oI64VejMw5/AU2YX/Ks+ApiesemfSAVSM8WqoSxI8J//dc+HBP9EYU4XSh2Euru9tAKR/4R47e9gu27o7EKYMhSbiCvZ0pgdkHiTLr2lS4ewh5BbatU3O1/yNYTqP3v3nSSVhWrlgk/wje998XmmyZcmmEBr19DmIn/9PYYdO5smR6T8ulxhDtuMBSNozCXPKbmYkYDhRxiVu05B94jNFMbXSXBuVrB/nLUxZ/BxjcaqmpVg51FuCGR6v87vaoTZNYOssd5N2XDhmeusHBTZ4DDi+wal+Tczju61qYy7cIGApgU+6PKljLsGqqJZL64JtExxTyJSYil4MyKwt93ZkFexfxlOBFs9smsJxao9HQe/bMGhpLW1POiKABmCTrPmVcLr5AISLHOvGlZfvqpVO6b7EIKVj/OeLVNTcpD6vuE+bfy1diw9UUxCkqmK4B2eeqXGjdSJw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(19092799006)(7416014)(1800799024)(376014)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003)(261021121427099003)(10067099003)(261026140227099003)(261009223027099003)(261028144727099003)(261022105027099003)(261021123027099003)(261102123227099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8hdxYF7Hu9rmjqB+MuSggamjyFJE9bYfHWY0/20FTQ9iV6T73UG6/jnM9WKy?=
 =?us-ascii?Q?RFMb1bWn+ilei6hRPHrRhUYXEjGMFu2cZPEVikOwbkb6ci39ATxIr8gV5GV8?=
 =?us-ascii?Q?PwPhZ6fTHFQGh0qOuLgTciRzDNqMmGu5TKaH1RMdPGFXbBgg/6v0OTE82leO?=
 =?us-ascii?Q?31nq3WN5lfupcdOL3LPQjOoZhWz0MOtCRDP5LTSBPaWZbOHIbbYatr6K/nad?=
 =?us-ascii?Q?1I90bOaIKd0MjsHWTg82+9vWcRhtUy8KaeEYJJKW9u7SzvekbifmVe4pbWql?=
 =?us-ascii?Q?ZpKg7fGEvJYGZmO5Gj8pbKhP4fFgmIirKqkFbPawzs5qiAvO0h4XPNvzj8WP?=
 =?us-ascii?Q?A+zeFsO5AOMlYApVgtpQvO2t+uAijsLQpVIiLEJ0QeuSFM8wXxUWJJdTehvI?=
 =?us-ascii?Q?5O1/eQpIYPnrve/bhPuBDBAl6jq1K8U60augzq10AfbALYd2xpc00AVF+vUS?=
 =?us-ascii?Q?5IDXF6inOToD8p8aihMoqKEvq4QpLcU0K29HHvMBrlBeTu0EuuMGGu4Tr3bg?=
 =?us-ascii?Q?NdjjRr2Et+7G7Z3ZfVohvSH2cdn4o+T8NuQb7hxMrEnLwmNPZrJT5CcZFyo8?=
 =?us-ascii?Q?0WVY4Tcox+6gtyBIuT+nuzik3gwiiasdJz9Y7eY511noMtSzgx4otFJv004d?=
 =?us-ascii?Q?m0FUhvWzOTdijjClNX7j41r7nE21Q6gt3bh7lUbfUQkRKQbtuQ/pRZRi84JT?=
 =?us-ascii?Q?rSc1x5mTqlxhE1e/s5QBwv/4eTfEBH+tKJwoPKK2gBivSiviz0bjzHr3+Fsb?=
 =?us-ascii?Q?qWrHaTA4dTk5CdVdie2enK3z73p/ciLtZqNNed40IALwSzUu0FK5YTQPm5Tg?=
 =?us-ascii?Q?0OOTW7/weD/ZU1rut3PY6W46V+nxbbwz/LyuyFm9tmNVdU+Qtx5yhh9C8iFw?=
 =?us-ascii?Q?H/Wy8Ad3FKfiSdNIQ67L0wiqqxiLm0S5UWewZ/dGAC/GHQ0wqj4Br2XJSmWa?=
 =?us-ascii?Q?fWTVi0VENrucl57XjwvzK4uu5JIkTaweg4ha1uIrBFQhVgdO1qBSTsbSHw7U?=
 =?us-ascii?Q?IwFvzl9dPgWzySQ+BAJAolTSetSAGRDdb2gyfUcvPYjpg2hD3edYifn32Cut?=
 =?us-ascii?Q?0uqr+4CdxDsncVau7saGJfKToqK0DIXvfCpbctyp/Oyf7RBxaRBihIsOkyiI?=
 =?us-ascii?Q?e22DCOArSVIAIDNBVWrL6cBJJMAuCe7f6WKOPq9dgNGf8KvoDS9GJ7dOt7c4?=
 =?us-ascii?Q?R8g+b9TWnUe13CtnpzwF9u17ZWkLgDb1Y8bhCLpC4mJW1vTbknTVe4m3vBN3?=
 =?us-ascii?Q?mDlxZa0uJ5eSRCGWoVEcju9IrkfjwHMwQxhuITKcLlisbB5DnhhDJ/ESkp8l?=
 =?us-ascii?Q?b/Ul9l8Ffd7Tf67NuM5pvX5LN1TzJK33uvJX3w46pNvUrw2r+MQWgfpBhW/z?=
 =?us-ascii?Q?H+hHIrdNxgyFZdqQ34ld24CinE6KMzIV0VVeo4FvXZQny0kAx9A7XQKvcQJE?=
 =?us-ascii?Q?PWUVGjo1fwz+hRFDhopnEwksaRoMFRHtIeR4AYxZbVrp5r86Xyj3feJUF619?=
 =?us-ascii?Q?LdAYVFUlO9LtGMF3WMlhWrh7kg0W54CdmjjiZyM82QpTNm5KYDX2mEd9pWQc?=
 =?us-ascii?Q?AI3yvn3vrtXhlpXAmAcw+k2mhfERSpjFR//+9r3kL3VCjow61HSsdJXvo4wt?=
 =?us-ascii?Q?vLEMxoH09Nji0bmqY2QeznGA+4RRn+3llM4J5v3QWmHPvzDggpAxDV2+xssi?=
 =?us-ascii?Q?0bsFRn4GKEbBG45ZIRQh0FnYwjcjtKITyZu8uEAiEkaCacB4iMDbShk7Fr+7?=
 =?us-ascii?Q?/RbsW4TYhIV7JHOpwhxJWBvTlrFyrQ5vynbXD3JrH7upAX+8XkSx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f40934-e5a3-4a9d-27e3-08df40d6b09a
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 16:04:54.1834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LfAv0PRLaPXt4N79ESViTB1gO8J1wQu9kM0Xv0zBM/erW/zLJLxLZ9Mem7mrjzsSCuVNZO1RBcyoqboqFcT82M8W54DAzEOi8jzcGv1YQ8HFBAgiU8PP+DpEgyKBoXdk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6838

On Thu, Nov 12, 2026 at 03:53:07PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> Register each dma_chan_dev on dmaengine_chan_bus_type before
> device_register() and make it a bus device instead of a class device.
> Setting the bus before registration lets bus_add_device() take the bus
> subsystem reference, so the matching bus_remove_device() calls drop
> references that were actually acquired.  Attach dma_dev_groups to the bus
> and set the device release callback directly.
>
> Keep the existing /sys/class/dma interface by registering a class_compat
> named "dma" and creating a link for each channel device. The channel
> devices now live on the DMA bus, while /sys/class/dma/dmaNchanM remains
> available to userspace.
>
> The bus is named "dmaengine-chan" rather than "dma" to avoid colliding
> with the SuperH DMA bus, which is also named "dma" and is registered later
> from a postcore_initcall. As a result the device's uevent SUBSYSTEM and
> "subsystem" link use "dmaengine-chan", while /sys/class/dma is unchanged.
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

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/dmaengine.c        | 23 +++++++++++++++--------
>  drivers/dma/tegra186-gpc-dma.c |  1 -
>  2 files changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index e1022d297674..45e328d28689 100644
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
> +	dmaengine_chan_dev(chan)->bus = &dmaengine_chan_bus_type;
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
> @@ -1652,6 +1656,7 @@ static int dma_chan_bus_match(struct device *dev,
>  const struct bus_type dmaengine_chan_bus_type = {
>  	.name  = "dmaengine-chan",
>  	.match = dma_chan_bus_match,
> +	.dev_groups = dma_dev_groups,
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
