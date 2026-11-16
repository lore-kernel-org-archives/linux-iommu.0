Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794848159;
	b=4shJ6c9ndODrCtCNDTzKhx7U9cKFWWx/kAa+V9dcRqCXQzaY77+3BQU99JvjrQLg1nTW
	 QVrAUxYmgqBaSQKggAgdUxgIaOIyiY7pnh1oPAp8yrF5QXXKfl7yTlf/nWC8R/FD7rmsp
	 sS39hB7HEzYMQLDPrf6cK670yz8FhQSqUe3RPg+EJrut+iTOFGVK7HTgObqTzJjqYuK7f
	 0cTXwzYajsgyDJv+DRBquFMTGVQJLnlHMX6v0FKTaiPy4A5x6nTA2d2a9QVPDeBlz2Z52
	 xWFqiyOh1TaxAAHLMjAoDgwS/ZXcal7j6QDQY1Fp2EkgMmATthh7NLbz/4kXUfqW3Zg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794848159;
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
	bh=b5jmQ+tC0YavRr54vIVtQOf5BBZ6aEk4FcFpuCpy7PQ=;
	b=RZP7H+7RfpmrxRFUq0jjyQDPL5JwuiBkFpr8eC7A7n8WIVeyiajPrPCN11+AgAUkO85Z
	 GWrP1hnSl0yjWkO2Hw1lOF/9mJsNLSn1W9vh1kdI2x07xTtw/oXNAmtrXQbThHPWiVBoW
	 ppkXVHMJfEZQER6B11l2sPiexzGaBpG3ph77QqrKScQIVADnfzansYOAicMxd5omzqCch
	 CIMa4DCz/wDdJhPnDjRjA+NL0ieMp5A4uB0PEaNrGTpS9DzgEwcT/BJn04Zlg9OTDpMKQ
	 D41PI7DbcNO/ZfKoTnfRwFOiJD7oSWq8BOOlzvulvKu5fzMSnV0PKOb4Xz3u2WDzv6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Q4A7PA8H;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.68
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010068.outbound.protection.outlook.com [52.101.84.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52370606A32F;
	Mon, 16 Nov 2026 16:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52370606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Q4A7PA8H
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RhO0wnRNJ3sDlFUG3wKMIMUlZivkMRvjmWXQyOKYJ4ibcaiFXYUq/3nm5Q75eeGeLsFg+jg2A1CvKt7GCtH6flpVo/bcbGXRhFSCDcn3STyzpbU2ef4Ctpux7fAqPt60itePriGeDPQe0Am7uVWAp3pOMcpTLQ1mBCR2wCdho173Eo1H2aWtxLXSubUw8p2T4rD6kulnueaX2j04jWOk8QJYrxa3VQx83UdPUIW5GxfBJhqdEBiGkyLtpLE9iDpTZyyjb0YK3fEAA9+vrnB/7sU5KiklZY63WDTcVf5fhNEaOIWvhMSp19jMkY1BH0UVZq7DpyDffj/5DpYenLr7gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5jmQ+tC0YavRr54vIVtQOf5BBZ6aEk4FcFpuCpy7PQ=;
 b=tXSFoRJlqBhUBuORwj0fLXeh743Snzp8UZomoe/yqRo0iq83GxIw/0qsRXWbpSuABBDVeC4ltYmpHPs6Z0j3eqVMtpu6WL6Z3TKB+xRIQBIK9RUcgceqtyjaaciY3P3DUBJp3VXsidF6OqfNwflK9AnDfJXC06LmjJcnjxZzgRNBlT9wSRB8NSe2sHK7P+l+f6W3VZ6qqZUoiXJR0LD3pN2MrEv6kDQbUt+WEC8xBRFSY8wURCvkP+CzRNjs6+NBNVJ/1f9NaUsgeMj89ytWTzlAFOkixu3xrvkCgNe08mHGtAsV2hlZGN4WACW3aTwKbcoLScSt4Od83dXJPzpWGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5jmQ+tC0YavRr54vIVtQOf5BBZ6aEk4FcFpuCpy7PQ=;
 b=Q4A7PA8HR/071GfIxTnB3Clh5NpgF/ZOlAtE8XmP+Z7ueY7SyE0YrqAQGUWAaWVcYsLa3J0FAZTf+fBvupbkKbR0sq5Dhh4LpPWq/3KH3EV+R4kyMfdFmwbfI0+pUn2JOwE1kHM0FO4gGoKSDfsq3ESW83yQErj8hXqPSq9qID4gYVsOmbel7e/NokXWldevgtXSzNhj7a0Ui0tshvgcPUlWmTu+S66SXGZA91rgtdx/lVanlXEyXZVi6hlN1lEWAnHcbO7SUYCMUTj4IK8bUQC1Z2J9Wv767vMvDhzhcmYRVQKC+mFe1J/BbSQZ5ASLPCAShbHH3LXTECOylkOeVQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PAXPR04MB8349.eurprd04.prod.outlook.com (2603:10a6:102:1bd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 16:55:55 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 16:55:55 +0000
Date: Mon, 16 Nov 2026 10:55:42 -0600
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
Subject: Re: [PATCH v7 3/9] iommu: register the DMA channel bus for IOMMU
 notifications
Message-ID: <avs1jnMrYjHkQss3@SMW015318>
References: <20261116-edma-iommu-v3-v7-0-32794ba8efbf@nxp.com>
 <20261116-edma-iommu-v3-v7-3-32794ba8efbf@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116-edma-iommu-v3-v7-3-32794ba8efbf@nxp.com>
X-ClientProxiedBy: PH5P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::6) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PAXPR04MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: 119da20d-6b64-4518-0c92-08df44027a9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|7416014|23010399003|366016|22082099003|18002099003|261009223027099003|4143699003|56012099006|11063799006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261022105027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	lAS3hJTm0k+U9BC9qfaDDoOM5w4ciN0A1Gs4bh0RttiouLeDPk0QJWJrO+yvyGacHR/gaKyNWLELeyVRO/YAO7H1YBOiIAbVT00cd2riolj1W0b1RdZ0VkIwsFjGKy6cB52yIkRw+KlHpcHxMbA1S5472R+HT4M4VSPYwb7m6UcJ9Ml5Iqk6iq+uxXtMSNxWhosJPTNEHUrM49aNq8GRON+fbHW8zyEyXW6ICply4n6A0ksrylaJdKeUdtm/BUYwx0QZ9P/agvtkQZHKYcSv2fNoWF7/uPqTNluYet45p48zQJkadBCoCluHR5u1XbDjdhn+BMw5ZtcbKoQdHIqnjWOBYvxRY1BTkcZG28mp4LgDL9MvTSdlH2kL9G2jM+wMG1blfzwGz0WtVXG2Wr9LnHlxgYkWtzu3JWk1ONwYpFUg6EFfoCCbiy9mRdMJSWf3X2wpOoXYn5NCAM/MpGhPLqqCkHq45VuZZbcQyhGhpSvmgMEQpVLL/CLOvU39h3nYD2xjSX6+f2PrAy5LCkUsBpJxuSdCmP7XzuWuLr9EIexEY1ZCBhYonuIIjS1rcmlHEjUzm4qKBpL7D79Idb0/GUbcIQ59BYZgBIRmGVR8dLYZbKwmZZtOUjP4V9gHR7M5CdLHOD4/Ov928KzizmxnzucXhn/g9Rug9J2BTdmM0Xc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(4143699003)(56012099006)(11063799006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JGgEbNQbgvQ81CtOmRcJ9ORJpgnTNh0aIpVwgSid8NerR1xuXR3e8hO1SRvA?=
 =?us-ascii?Q?XfSeOdrS/q6IeEbv3NP2T3zx8LNtrf9mS6jArOQj/uD5LZImhFIYIHmpJBON?=
 =?us-ascii?Q?JFdpg54DCiFHSmWe/yvplTA8RZ1RzjfNfuWLATbFckdohJxuM3lfSM3hTfPC?=
 =?us-ascii?Q?DwwVJNaw5XSVy1/h3KTfOMofzahjfCJ/iemWgHcAQ6mPmggMRUQ/j/UDbk27?=
 =?us-ascii?Q?ZbS38N21j18ClpEkWOpUdbv04aQut2HCPg+258bJi1tpyvzqaD0d4JeYS1i+?=
 =?us-ascii?Q?2cDaKhli5DCv8Arn8j9WCyQ3j4ty5uYEXuorV9E7PsUFuf1130oBPkZoupKM?=
 =?us-ascii?Q?zx8uQmV+0hy+FBVhOAKWpDOzkgJvpic6RPNq8Bd89RULgUw/VreaDijL9U1V?=
 =?us-ascii?Q?AJHFhlzIzU2XqAHnvWdM2JRgZtXjke8kJl1ny/2RnkDA2Yzb/E/YW0lCB72h?=
 =?us-ascii?Q?0dWqyMZcp6R6y3ydqM65m+RYAsRfHETFH8PbAj8e+nB4QEaqLg+dmN+uzAul?=
 =?us-ascii?Q?AS8rcIMaxxGKJErBnT/+uCA793fvBf/MUhdqGTdJ6bwAQoGNnOB2Fw5CcZGv?=
 =?us-ascii?Q?Vvh1jzdAAoJsHY31riC3ZMQu9BdGzs8NsOa1bU+8kOVTTLzTqPB4z7rX7OTi?=
 =?us-ascii?Q?duNN3rOEf7ZVHz8fbbKSah2LYbqlN09x4T4Tiq9EAJ1Gk5G1QyBYmOCOVbA4?=
 =?us-ascii?Q?t5ccvx4xZ9Lp4hm3nisJF5iPEnE96dLhywEftbj6dnTCID3txUuSUCFQ0ok3?=
 =?us-ascii?Q?H3Ty4u4M6WaeANJpj7ZXwmfbQOpwmOiHXrIC7IvdMWgLA/jNwaEogGaRk0Al?=
 =?us-ascii?Q?eLkU2iVQEQ3dsfta5gzRtvwodoruogw46qOhO76WXwmifwBdQd5Caduw59It?=
 =?us-ascii?Q?9xFCn980v8rTMr3yS1U9HpmNCH41jBb9PNy/+hzgLB5Mv6RKWSLppDP5YD75?=
 =?us-ascii?Q?qYcEZtO53gj67UGVzoVs138dS3SW+K+d6IydJUi4muRFM/ehPsp5mAz4w3c0?=
 =?us-ascii?Q?CNHKV4WHXbAoiiVLbjAvuIpeh50EComq6QOaDnMuJ3zXySgqcCTzYUem/hkg?=
 =?us-ascii?Q?UBh5Dj6LxbQWyH2fGtZXYC9kGJO8HxEeqJpIze34IrTf4oG7okO8Mubo/T8X?=
 =?us-ascii?Q?Pqe8XusxSjtnfU0yc50w07ZBP5ZNpqgjDsMCOjPuLtzviixQCpgQ7+19zYZH?=
 =?us-ascii?Q?AB/oIQWAIwRFu+vVuuSjfEiSA5DUc/XpcdTznD76RvprKxK3+lyceNPT2OBR?=
 =?us-ascii?Q?U/jRoj0Y1Bvg///+EOJl8wKlLmxRE/BcVtCGm0zRAYVY23bgrP7oAuGTDH/p?=
 =?us-ascii?Q?Sdvobiv/pOLUtO3AUU0HhwrgAnWNDUe3HRT1oArOFNhRFHqBTDcIN3ZS33R7?=
 =?us-ascii?Q?RlFrNuSmeG6kltGMTSQYduKCdWnUBV4IZ+lkMf3f5gZyLbAJhB6ZiWqOHlHX?=
 =?us-ascii?Q?EeydZjWgvgtAfZheLl5CkS7mf158Xk5AIiEURvGXkRFCne1PXleiZoQZCI2Z?=
 =?us-ascii?Q?sQ8a9FRvOSdvG1Nue1VnLo4uP2ufi0wSWDHbZgPAI9F1C3FWV3fr/kWY6ef8?=
 =?us-ascii?Q?3gvNNHpQJZQvy/QomcP4bXnWrnhsDyEClJcr5O1pJapjQ0/GFnmXjw9DJzUX?=
 =?us-ascii?Q?5nfI1KkBUrL2mQs87Wx4Jh62vSXt3TS9mp7A2AhO7Fu+K4Z8vMDmuYlaNZCm?=
 =?us-ascii?Q?nh97KmlOmf+fcPhOGEPjS7aBe6Rhtngx4xoqQ/74SF7s+bfqBxVatxdDJ3Yr?=
 =?us-ascii?Q?Y6mJ1XyYsFAIB/X6uGFRzCsLwMte9aZZF1qTF1Jh9KwSOWkL3vO8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 119da20d-6b64-4518-0c92-08df44027a9d
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 16:55:54.9741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4x7HfUm0jNGmjbLNC12fBqhhp1nx53ooSQD6xkbP/Ru0tco060G73bnYocr7oxXOr4f04VCX+nu6SguhnpJl3zCwd9xVXpNasxBWZpl0uEDL16zSbKVF38Fub50Ohe6k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8349

On Mon, Nov 16, 2026 at 11:05:24AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> DMA channel devices are about to be registered on a dedicated DMA channel
> bus so that they get a properly balanced bus association before
> device_register().
>
> Add that bus to iommu_buses[] so the IOMMU core installs its bus notifier
> for it. This allows of_dma_configure() to probe a per-channel IOMMU and,
> more importantly, lets BUS_NOTIFY_REMOVED_DEVICE release the IOMMU group
> and domain when the channel device is unregistered.
>
> The dmaengine bus is registered from a core_initcall, before any IOMMU
> driver can call iommu_device_register(), which iterates iommu_buses[] and
> fails if a bus has not been registered yet. Guard the entry with
> CONFIG_DMA_ENGINE because the bus does not exist when the DMA engine core
> is not built.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/iommu/iommu.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index b486b8bbd1fc..ab31cd15d1d5 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -8,6 +8,7 @@
>
>  #include <linux/amba/bus.h>
>  #include <linux/device.h>
> +#include <linux/dmaengine.h>
>  #include <linux/kernel.h>
>  #include <linux/bits.h>
>  #include <linux/bug.h>
> @@ -191,6 +192,9 @@ static const struct bus_type * const iommu_buses[] = {
>  #ifdef CONFIG_ARM_AMBA
>  	&amba_bustype,
>  #endif
> +#ifdef CONFIG_DMA_ENGINE
> +	&dmaengine_chan_bus_type,
> +#endif
>  #ifdef CONFIG_FSL_MC_BUS
>  	&fsl_mc_bus_type,
>  #endif
>
> --
> 2.34.1
>
