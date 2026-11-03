Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.27
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793718905;
	b=fE56LBoUCKbsjtyIwSo5BvIkJQ5XA7UsOPE1VtUgJftj9sHTKdt7vnwtpGzSfQkcoTAN
	 FKF8b8pjbMDa4t9l8+QcHpEMjaew2xCP7pA1ug9JVbgMJaqLEunIicBRGMfu+72FfdFrL
	 5ntrM5NcOBlAFP0wBEBUeuSh14zvs9gNEPT498tYsJAawzCvdzSpQk0XMJftW5Kc8brQ/
	 8NGwScjorZePf6eOO9jf7ND5DNmB5tA1f3KWf8D+Dh6ooLPGWE2uOw4Nld+NNNagW6eHY
	 GSymo8ggFcJJPIxPbFxQLl9sl05ud0J8d//UZmmkIJSPiBEgPLlRu1xmsoJ26yjMoZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718905;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=gWZXrh24f5P64f5W7wFP/bDHfxgZfMTleODQcAViQoQ=;
	b=VdjkgIbbC+72cqIVLV27sqQX+Lrus/PoMSOrv8v3wwo1mo7y4M6knX0RVWR0mKwFs1/a
	 P5lZqO+U9O0LVovzBP+gh2EIotLgpDzF/n/BdmFIwohskiIh9uJqQIzHR5ld9LDsrfhVt
	 Cdfu4VssMvBBgfEeWRiKt8AjxkII9wJQ7uGko5nLFprZ5SAdEEbsVwO7eLwGvC4JUhKXy
	 9VWD/SIH1YhElpQrMOA3VzAce8TFuerzCdtzDjGxX/NZuIWgyWNFWFV82y7d5Zf55Ekne
	 njlnNO/NnTgqIPEP3zVUddbfQXyNHvu3/td/DF4mww7ZTIkEq9pXbxrIqrU9502kZWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=lCRwhyjq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.27
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010027.outbound.protection.outlook.com [52.101.69.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4C4606EE95;
	Tue,  3 Nov 2026 15:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F4C4606EE95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=lCRwhyjq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHPtSvnPhaxVWQz2+xPqK+6LMh8toARzMj6oDWMSmt+TfQ0UYI15oMDUuFDVIBq6QQXYCClye7RG710ECXUxIKWf9ROA13SuXUp1xRI9s6L79upOPiupZIdhkS+KGmNOtOdq74xGS+BgmrrPBkz5Bs80PHOlz4JrHc+6Fcs4dXjFEIf+l721EJIpU1fGQ9SGPnCivoKfQPpsRZq9JWkLRa3uRbdu5FYmS79twiC7hqR+tD/PjyOrWIcKXUEExWFrjNq7W2Zw63ssew7TcCBt9NRlGhwKoLZ8o5ATxX6Qr3I8OS14biCX77PBYNloBm2ZcObSHRuvbJkzGvnQsU8FSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWZXrh24f5P64f5W7wFP/bDHfxgZfMTleODQcAViQoQ=;
 b=rVuTHtAZJGcJtFmrEvZKaj0Wdc1ysrBxmHzDfXQ4+4B/ZdcP7+NKoFKo8mLKV3Z2AyDJnAPTXEZ/Wbr/0nP9xjueW/gpY7tz0b/n6ZHVzyl/3s/I4XmRTxsK5+OtQJzngfAbnLR15S+wH+glaNX+VC7QgMjUh3b88AG311Al05Bzyau1F3pyWam8IgNucUw9502DwDYFxRthYCcXrpVPB0GBMxvtr3zKSRNsu6cAYZZlUsotITC87mEf2IRKCDqnbJhohBA7jWiUvK6PmQMakRSibPa/xT5g1TTPyOEwtBmnwKYWA3BZfvblUKODidzobnM13HX6+p03cElGuRJiGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWZXrh24f5P64f5W7wFP/bDHfxgZfMTleODQcAViQoQ=;
 b=lCRwhyjq91AceqR7ySdPEXzpzeBXSecLYK2cq10Ez3jOaGczYTfKvNFM7yWgOegwXQBCi4tAnFYYcQZvsSqFtCc3DtITMK5qdTKaJ1YiTVNUMpRGl08YhGbDP8MpBJ74mfnAdfkyOfFsfHis7cezEPcSj39P4nBSWxJUxq/E/pI4UI44/5oW2CSFT1elUlGJaclzioxuA4cmn8b8bw/lS4cJskFBIwqeEXAHRq+iTf4bSjrF+OPGLKKkSr3KoNXCNXbf1FYvPQzwZPKexTI2/Oo1nucyN2wA+6ufXDVLIiHZMj03ba1OGOlwTiBTUA5387GwH3mDO4vuUsECIN9uHQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by VI0PR04MB11023.eurprd04.prod.outlook.com (2603:10a6:800:25c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 15:14:59 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 15:14:59 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Nov 2026 23:19:04 +0800
Subject: [PATCH v4 7/7] arm64: dts: imx95: convert eDMA to per-channel
 child nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-edma-iommu-v3-v4-7-470415d418c5@Example.Com>
References: <20261103-edma-iommu-v3-v4-0-470415d418c5@Example.Com>
In-Reply-To: <20261103-edma-iommu-v3-v4-0-470415d418c5@Example.Com>
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Laxman Dewangan <ldewangan@nvidia.com>, 
 Jon Hunter <jonathanh@nvidia.com>, 
 Thierry Reding <thierry.reding@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Frank Li <Frank.Li@kernel.org>, 
 Larisa IIeana Grigore <larisa.grigore@nxp.com>, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 iommu@lists.linux.dev, linux-tegra@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|VI0PR04MB11023:EE_
X-MS-Office365-Filtering-Correlation-Id: 3abbbebf-ab8b-4156-bafc-08df39bd39b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|366016|7416014|376014|1800799024|261021121427099003|261021123027099003|261022105027099003|261009223027099003|921020|261026140227099003|261028144727099003|11063799006|22082099003|18002099003|261102123227099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	ys+wJ19EMX7Mz4qYrUJauR0o4ybw2MgT4f4SrPbpUO6ecJ1MPJEHk6bUp4X8ZzdgARdOWhiw94AmNesUOlczEcqlKvYYp0XGn+rb/SCyC8co55GZDrkp6E4nl48LqL1oQ6qN8m2Su5eDC3+H5qz8NIxnCLXfKF2U6pab+Ho1kl0ejEUC9bJDzPVfVaPhU0a6TZPiPhEhYCeD0zcslbFVv3k+sfNefeIHOim/RpgQzpUkdm9dVtXA/bWCUgR4NmQOzSBwCHxu0p9BotR30+ICHGoDw5zxrrz4bgEybjWfjKE9R4ZIJCOjOlhccJG3VnG60D31Ahw3RSq2MnLH9kGi5/AUgJDIe/AYnC9zw00Bmax2QilYPENmUtzbCKFWM92u5IrTj4O733d7rC80qLG0aCvqWxrxXWfZ5jE6rxq+4RvmATzxTnEiP6YXa155kyctvuPofCI42kqtZw5XaBzmvMs5cleoAz3J3W796E0fIz7buNwZdLdBFDZjw+yTH/STnV1gAO0cLNAChtR015vi4prmzuNSEneJnNdQ4AWWmWui4gbPM9jlQ+bIt6bDWANMgoGHcQ9V3QSbZbyTzqy9sMnNl2UbRH5JIp5wOVNfYJ1w66YwVTqvwGEK4FkibU/zTC83gbgS/oHfp/lCgB9sjqIo7Hlt2WEoj8HYlwSN5wA6KlPZjRw6J9DlMIY8mjcugrkIHweiDDcZZVpN1CIBJg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(366016)(7416014)(376014)(1800799024)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(921020)(261026140227099003)(261028144727099003)(11063799006)(22082099003)(18002099003)(261102123227099003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTYyZ3d0VHVPZis2VWRKZ1dDYTVhT0ViOW9USjVRbXlPWEhzZC9LTHZwMjJ3?=
 =?utf-8?B?Mnh4cGhYREFJL1ZIT0RHaWlGZTVGWkJEbUJRYlBmL2c5VGpEc3RaS0V0bkFG?=
 =?utf-8?B?WlBYQ0w3Q2NpU2ltR0F4R0lMdWViVHJXNmNQR1BDTXdPcXZVWEhSU08xTWVY?=
 =?utf-8?B?elF3a3poU2ttdUhBeCtUZENZRFVudnhYblV4dCtjMG0vNENnSFFkM21RK3Uy?=
 =?utf-8?B?dHh2dmI2azE1cVJ5SnlVTmszWWFzdzcwWXUvblB2N0FOYll1K2hpM0NLaVVN?=
 =?utf-8?B?SHFlZlRNMkEyam9ETmNCdXVsaGdpK3FGR2VncUIvVHRDYmVBaW54UjZEZ3JG?=
 =?utf-8?B?djhFU3NYN0V1QjZwY3I4VjVmT0J5NnBiSjJqRzNra25nNXNsV2Z0QlhNVnZq?=
 =?utf-8?B?M2Y4cU9PNUpSVUwwOFJ4cDUvaVRzcjJWUHBKNWVGYnFMbGNKZWV6Q2lCbEFu?=
 =?utf-8?B?cC93d09EQkNhbGRBVTNZODVYRm1EOGxZLzB2cXBDdllXZWxJczN3OFpQczhs?=
 =?utf-8?B?L0FXOUpLTWhjS0NuUU96ZXFLSEVKKys4MzZVeXNia0c1SllYVG9BRjJtS2lT?=
 =?utf-8?B?SkZKWC9RZUk4WXBMYisybFF4ZHpaRVFhWm8yQVRTQWgySEt2RlFxVGlFNXBq?=
 =?utf-8?B?d0lQYUx3dUJRTzBsajB4TUVJQ2tjOElKNnB3dDFHcDVvOTl1cmpTVWRnM2Vv?=
 =?utf-8?B?YU1mWGxvRVRYVEZGaGhqVnFnTXVyQThEdVhhNVZ6NkdCNUppSkR2U3p0QlBa?=
 =?utf-8?B?Q2ZzbW5zYXJrYS91M3VKQzlaV3FxeVRCdUhVUlU3cVB6OXYycFg5Zld6RTNO?=
 =?utf-8?B?eTBmOWt4emh4VmllS0dCOTZtMnFFYjRLS0xTbFJvQXd2UTlnem0yK0UzcVFy?=
 =?utf-8?B?LzhqbVR0YXhCS2JBWnR1TERvSndMdmY3VnJ0Mmo1ZDVoNXNmbmJqRG9jTldr?=
 =?utf-8?B?VGxtbWpzN0c1QjgwNkRHcTNuK1FTL1RWUkFDTHlSR1d0VnpmdzRCQysrc01h?=
 =?utf-8?B?cjlwTnl6enFlN1B0N245Tjl2RG1sb2VUUnQyNE1ZbHB6Yk93RVRuOWlJMWdi?=
 =?utf-8?B?MW1iOTR0Nmtjakx1SEkyQmlPMkUvSktzdzh4OVFDZ0VNQk9RUG1FT2daZ3Jw?=
 =?utf-8?B?ZFpMRmQyTWZRY2swKzVSYUFqdUdMaFkwbUFDRVFBT0xyRkptaWcvNGEzd3NG?=
 =?utf-8?B?eEdib2VrUlRNcnB4WktRUGdtRFlwelNPWlg4TFRCNTVBNlp4R1RVczBmMG43?=
 =?utf-8?B?bmdqR3YzeVpCVTNSQ1dPTTFsSG5ldGxIQTd2WEFuN1Jac2JMQkd6SUc1a3lB?=
 =?utf-8?B?Tk1kWXkwZEx1c2w3ME1DcnBQMEZFUy9WV1h5ZmRqSUdMZmxRTHo0KzlzYkhJ?=
 =?utf-8?B?SkhIMkRYTzJxZ1F2eGNLd29Vd2xQSFpKZ3REcG41cHBUaERSU1BtY1h5cTdP?=
 =?utf-8?B?OGRkemg5NVVHZmZDZ04yR0pQSThtL1ZXamp6ZVFiVHA2aHJhQXdQaGpqcHY3?=
 =?utf-8?B?dEdkK1hac2g1SkFKc0tYaVpROUxDa2Z5RlBxdkxKbVF3MFhoOVkvd3dZS3hG?=
 =?utf-8?B?Q0toOS9LY0twUGZzdnVSdm4zajIvTFhxY3JtNnVYSUdSa2FBOTFlWUdheFdm?=
 =?utf-8?B?TjRKbHFkbkhEbFh5d0RWMkg0emhHQTRvYzFROHJGNUxzQTlVbm4wQVNzZVo1?=
 =?utf-8?B?bWg3enNudjdiQXFqWDU2eGZ6cDM1V3EyRUMvUHNVYldBb3IwdHNjTjd6SHhB?=
 =?utf-8?B?YTZhbVFNRlB1RHhqK0tQajdNTDRJZU5LdDE0Q2xaREU2dnI0Q2pFY0l5ekQ1?=
 =?utf-8?B?Wm9aem1SRTJhbCtrSE1FZDVhYkpEUkJ1aEZuM2VIUEx0T29kcUpySVI5bU1O?=
 =?utf-8?B?bmFtdXNRdFE1WDNLVnB1cktobFUyUnczUHR5cG81UWwrbzFvZ2c3eXNWUVpl?=
 =?utf-8?B?aEVpdWlRTzA5dFhhc09kaHBzWDZId2FxS0xnejJtOERoM2U5M1Awb0lDd0dl?=
 =?utf-8?B?VTF3L3ExZnM0OWF4Y1c3dDJIMjJ0VzI3THVCTGlFYnVjYTFNWkh3eWxDWHJB?=
 =?utf-8?B?MTJOUitDMlBqdWQ0ZnVsSzhmUk9IRHhnWWxNb08vMW9rZWN6NlFsOVoxL1A3?=
 =?utf-8?B?cmhlOWJNRkRZSVVtWWFXdURsdlY1cXhnaXVsSUQ5K0FKd3JOcndKRXByVC9v?=
 =?utf-8?B?TXJFcyt1TFBvaVlDcFJzZjVRTkxab1dHMEdVRkZjaytQUk4vU01Ha3UrczBo?=
 =?utf-8?B?cFg1Tm9xNTJPbEVFN0FEem1QQXZtWXZTbXF5UWhuSEhLVDRuVU9vTWNVM09I?=
 =?utf-8?B?RWlhSHkxNUhESThZNWhhWGozb1dESGwwYmpGOUdidldMcktFMklZZjFZS3p1?=
 =?utf-8?Q?NtpZ/U/8dm7lOHbhzebJvzqduRro4EC1G1caR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3abbbebf-ab8b-4156-bafc-08df39bd39b6
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 15:14:59.2697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6GQFpYIAQrHbjniZeoT7Ef8yqGJ4IHtoO5nBpuAyzEQApKRuyX5NfMXuuQkK4RtEhJaZHPZeM3FNpAv3+ANPPUAgDDLQhgHOTHjVV2azmNoQpKATYyeCogr0qMQWSlQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11023

From: Peng Fan <peng.fan@nxp.com>

Convert edma2 and edma3 from flat interrupt arrays at the parent node
to per-channel child nodes (dma-channel@<addr>). Each child carries
its own reg (real per-channel MMIO region) and interrupts property.

edma2 (64 channels at 0x42000000):
  - Channel N at 0x42010000 + N * 0x8000 (size 0x8000)
  - Paired interrupts: SPI 128-159, two channels per SPI

edma3 (64 channels at 0x42210000):
  - Channel N at 0x42220000 + N * 0x8000 (size 0x8000)
  - Paired interrupts: SPI 256-287, two channels per SPI

edma1 (imx93-edma3, 31 channels with 1:1 non-paired interrupts) is
left unchanged as it uses a different interrupt scheme.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 774 ++++++++++++++++++++++++++-----
 1 file changed, 646 insertions(+), 128 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index d20c2498b9aa2..64570703ce6cb 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -635,148 +635,666 @@ edma2: dma-controller@42000000 {
 				compatible = "fsl,imx95-edma5";
 				reg = <0x42000000 0x210000>;
 				#dma-cells = <3>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
 				dma-channels = <64>;
 				/* channels 0 and 1 reserved for V2X fast hash */
 				dma-channel-mask = <0x3>;
-				interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>;
 				clock-names = "dma";
+
+				dma-channel@42010000 {
+					reg = <0x42010000 0x8000>;
+					interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42018000 {
+					reg = <0x42018000 0x8000>;
+					interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42020000 {
+					reg = <0x42020000 0x8000>;
+					interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42028000 {
+					reg = <0x42028000 0x8000>;
+					interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42030000 {
+					reg = <0x42030000 0x8000>;
+					interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42038000 {
+					reg = <0x42038000 0x8000>;
+					interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42040000 {
+					reg = <0x42040000 0x8000>;
+					interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42048000 {
+					reg = <0x42048000 0x8000>;
+					interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42050000 {
+					reg = <0x42050000 0x8000>;
+					interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42058000 {
+					reg = <0x42058000 0x8000>;
+					interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42060000 {
+					reg = <0x42060000 0x8000>;
+					interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42068000 {
+					reg = <0x42068000 0x8000>;
+					interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42070000 {
+					reg = <0x42070000 0x8000>;
+					interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42078000 {
+					reg = <0x42078000 0x8000>;
+					interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42080000 {
+					reg = <0x42080000 0x8000>;
+					interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42088000 {
+					reg = <0x42088000 0x8000>;
+					interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42090000 {
+					reg = <0x42090000 0x8000>;
+					interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42098000 {
+					reg = <0x42098000 0x8000>;
+					interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@420a0000 {
+					reg = <0x420a0000 0x8000>;
+					interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@420a8000 {
+					reg = <0x420a8000 0x8000>;
+					interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@420b0000 {
+					reg = <0x420b0000 0x8000>;
+					interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@420b8000 {
+					reg = <0x420b8000 0x8000>;
+					interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@420c0000 {
+					reg = <0x420c0000 0x8000>;
+					interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@420c8000 {
+					reg = <0x420c8000 0x8000>;
+					interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@420d0000 {
+					reg = <0x420d0000 0x8000>;
+					interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@420d8000 {
+					reg = <0x420d8000 0x8000>;
+					interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@420e0000 {
+					reg = <0x420e0000 0x8000>;
+					interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@420e8000 {
+					reg = <0x420e8000 0x8000>;
+					interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@420f0000 {
+					reg = <0x420f0000 0x8000>;
+					interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@420f8000 {
+					reg = <0x420f8000 0x8000>;
+					interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42100000 {
+					reg = <0x42100000 0x8000>;
+					interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42108000 {
+					reg = <0x42108000 0x8000>;
+					interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42110000 {
+					reg = <0x42110000 0x8000>;
+					interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42118000 {
+					reg = <0x42118000 0x8000>;
+					interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42120000 {
+					reg = <0x42120000 0x8000>;
+					interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42128000 {
+					reg = <0x42128000 0x8000>;
+					interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42130000 {
+					reg = <0x42130000 0x8000>;
+					interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42138000 {
+					reg = <0x42138000 0x8000>;
+					interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42140000 {
+					reg = <0x42140000 0x8000>;
+					interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42148000 {
+					reg = <0x42148000 0x8000>;
+					interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42150000 {
+					reg = <0x42150000 0x8000>;
+					interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42158000 {
+					reg = <0x42158000 0x8000>;
+					interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42160000 {
+					reg = <0x42160000 0x8000>;
+					interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42168000 {
+					reg = <0x42168000 0x8000>;
+					interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42170000 {
+					reg = <0x42170000 0x8000>;
+					interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42178000 {
+					reg = <0x42178000 0x8000>;
+					interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42180000 {
+					reg = <0x42180000 0x8000>;
+					interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42188000 {
+					reg = <0x42188000 0x8000>;
+					interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42190000 {
+					reg = <0x42190000 0x8000>;
+					interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42198000 {
+					reg = <0x42198000 0x8000>;
+					interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@421a0000 {
+					reg = <0x421a0000 0x8000>;
+					interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@421a8000 {
+					reg = <0x421a8000 0x8000>;
+					interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@421b0000 {
+					reg = <0x421b0000 0x8000>;
+					interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@421b8000 {
+					reg = <0x421b8000 0x8000>;
+					interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@421c0000 {
+					reg = <0x421c0000 0x8000>;
+					interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@421c8000 {
+					reg = <0x421c8000 0x8000>;
+					interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@421d0000 {
+					reg = <0x421d0000 0x8000>;
+					interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@421d8000 {
+					reg = <0x421d8000 0x8000>;
+					interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@421e0000 {
+					reg = <0x421e0000 0x8000>;
+					interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@421e8000 {
+					reg = <0x421e8000 0x8000>;
+					interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@421f0000 {
+					reg = <0x421f0000 0x8000>;
+					interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@421f8000 {
+					reg = <0x421f8000 0x8000>;
+					interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42200000 {
+					reg = <0x42200000 0x8000>;
+					interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42208000 {
+					reg = <0x42208000 0x8000>;
+					interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
+				};
 			};
 
 			edma3: dma-controller@42210000 {
 				compatible = "fsl,imx95-edma5";
 				reg = <0x42210000 0x210000>;
 				#dma-cells = <3>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
 				dma-channels = <64>;
-				interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>;
 				clock-names = "dma";
+
+				dma-channel@42220000 {
+					reg = <0x42220000 0x8000>;
+					interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42228000 {
+					reg = <0x42228000 0x8000>;
+					interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42230000 {
+					reg = <0x42230000 0x8000>;
+					interrupts = <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42238000 {
+					reg = <0x42238000 0x8000>;
+					interrupts = <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42240000 {
+					reg = <0x42240000 0x8000>;
+					interrupts = <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42248000 {
+					reg = <0x42248000 0x8000>;
+					interrupts = <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42250000 {
+					reg = <0x42250000 0x8000>;
+					interrupts = <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42258000 {
+					reg = <0x42258000 0x8000>;
+					interrupts = <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42260000 {
+					reg = <0x42260000 0x8000>;
+					interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42268000 {
+					reg = <0x42268000 0x8000>;
+					interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42270000 {
+					reg = <0x42270000 0x8000>;
+					interrupts = <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42278000 {
+					reg = <0x42278000 0x8000>;
+					interrupts = <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42280000 {
+					reg = <0x42280000 0x8000>;
+					interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42288000 {
+					reg = <0x42288000 0x8000>;
+					interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42290000 {
+					reg = <0x42290000 0x8000>;
+					interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42298000 {
+					reg = <0x42298000 0x8000>;
+					interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@422a0000 {
+					reg = <0x422a0000 0x8000>;
+					interrupts = <GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@422a8000 {
+					reg = <0x422a8000 0x8000>;
+					interrupts = <GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@422b0000 {
+					reg = <0x422b0000 0x8000>;
+					interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@422b8000 {
+					reg = <0x422b8000 0x8000>;
+					interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@422c0000 {
+					reg = <0x422c0000 0x8000>;
+					interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@422c8000 {
+					reg = <0x422c8000 0x8000>;
+					interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@422d0000 {
+					reg = <0x422d0000 0x8000>;
+					interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@422d8000 {
+					reg = <0x422d8000 0x8000>;
+					interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@422e0000 {
+					reg = <0x422e0000 0x8000>;
+					interrupts = <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@422e8000 {
+					reg = <0x422e8000 0x8000>;
+					interrupts = <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@422f0000 {
+					reg = <0x422f0000 0x8000>;
+					interrupts = <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@422f8000 {
+					reg = <0x422f8000 0x8000>;
+					interrupts = <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42300000 {
+					reg = <0x42300000 0x8000>;
+					interrupts = <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42308000 {
+					reg = <0x42308000 0x8000>;
+					interrupts = <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42310000 {
+					reg = <0x42310000 0x8000>;
+					interrupts = <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42318000 {
+					reg = <0x42318000 0x8000>;
+					interrupts = <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42320000 {
+					reg = <0x42320000 0x8000>;
+					interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42328000 {
+					reg = <0x42328000 0x8000>;
+					interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42330000 {
+					reg = <0x42330000 0x8000>;
+					interrupts = <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42338000 {
+					reg = <0x42338000 0x8000>;
+					interrupts = <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42340000 {
+					reg = <0x42340000 0x8000>;
+					interrupts = <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42348000 {
+					reg = <0x42348000 0x8000>;
+					interrupts = <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42350000 {
+					reg = <0x42350000 0x8000>;
+					interrupts = <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42358000 {
+					reg = <0x42358000 0x8000>;
+					interrupts = <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42360000 {
+					reg = <0x42360000 0x8000>;
+					interrupts = <GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42368000 {
+					reg = <0x42368000 0x8000>;
+					interrupts = <GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42370000 {
+					reg = <0x42370000 0x8000>;
+					interrupts = <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42378000 {
+					reg = <0x42378000 0x8000>;
+					interrupts = <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42380000 {
+					reg = <0x42380000 0x8000>;
+					interrupts = <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42388000 {
+					reg = <0x42388000 0x8000>;
+					interrupts = <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42390000 {
+					reg = <0x42390000 0x8000>;
+					interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42398000 {
+					reg = <0x42398000 0x8000>;
+					interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@423a0000 {
+					reg = <0x423a0000 0x8000>;
+					interrupts = <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@423a8000 {
+					reg = <0x423a8000 0x8000>;
+					interrupts = <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@423b0000 {
+					reg = <0x423b0000 0x8000>;
+					interrupts = <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@423b8000 {
+					reg = <0x423b8000 0x8000>;
+					interrupts = <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@423c0000 {
+					reg = <0x423c0000 0x8000>;
+					interrupts = <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@423c8000 {
+					reg = <0x423c8000 0x8000>;
+					interrupts = <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@423d0000 {
+					reg = <0x423d0000 0x8000>;
+					interrupts = <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@423d8000 {
+					reg = <0x423d8000 0x8000>;
+					interrupts = <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@423e0000 {
+					reg = <0x423e0000 0x8000>;
+					interrupts = <GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@423e8000 {
+					reg = <0x423e8000 0x8000>;
+					interrupts = <GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@423f0000 {
+					reg = <0x423f0000 0x8000>;
+					interrupts = <GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@423f8000 {
+					reg = <0x423f8000 0x8000>;
+					interrupts = <GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42400000 {
+					reg = <0x42400000 0x8000>;
+					interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42408000 {
+					reg = <0x42408000 0x8000>;
+					interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42410000 {
+					reg = <0x42410000 0x8000>;
+					interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				dma-channel@42418000 {
+					reg = <0x42418000 0x8000>;
+					interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
+				};
 			};
 
 			mu7: mailbox@42430000 {

-- 
2.34.1

