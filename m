Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794469731;
	b=IkUkOm+pny9w9w1ir9LyhaOJuK6Lz0hsKz6ULtYDKIkii/HwSkSGqPh2vbGbHGmFQaFB
	 tY96U3NpvXvKjTX2/YLzaP1DlI/OafER0D95u8lHtyllVX16TCuLWM1Y0qApNVzb/mXO3
	 rKyj3NOZzZOa+StFD0XQuKOynPRUwmR15rOJJmfu4cXQMev0BakI39InSFlVWWyedi+sr
	 3uTUpHsDiI/3TnVaSrm25VJepzU2TIEVK0oPJa8W2WavIbzJgrkjOmtmHN8EY9gMQV3RT
	 W7bOEFKuS+biXuep1GRFq/+VWbcvE7v2QtuE10nrn+XRs1W1pqYktP1lcCxjOv8CKHQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794469731;
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
	bh=mZBTIaXH1MoyhoHWMr+ZZOz7LzWdFDcaSADpv6EH5mc=;
	b=hhXJl5cyjIEz2uEpKJK5ZEHGKVx9qAwbxQ7N5mC88sYocuhyEoYEKXqje+VAxscvQA+z
	 Cnitw9zarX4jhcT8yP/RRJ5QZ3Du4qWVDXpujlQp4ryyrBzAEWIVg63jcwfjLsQDkx9wz
	 sa7sTTbkF0WXOZBf18APU5EPeFAmP6cA0TrE8fPEuxfOyHWh0gdreQay6iylFhq2uUQSS
	 n9wNeocvLDO0a2oQwtXxhY674aIItF8Faj4b2k7MujF/l4V2VCMXTHlRhAA2riBzLR9+U
	 ROYSffqGVkZzp4r8+czwHL/H4uYOwpzxyYun0pLXnVCWww2xSfk0mYMjBaslOfssb+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=lLJFfDAa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.12
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013012.outbound.protection.outlook.com [52.101.72.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6055606A897;
	Thu, 12 Nov 2026 07:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6055606A897
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=lLJFfDAa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxHTTj67HuqPlA7j9WssNkMqs5DVesKiPKsQdl50nZQtnzJm/+kNVej9ffd63oMLUYYBlUEy6XynlTplGVp1ViFJVd4T92BmY1Rp6aQ9E8PZZUtEzwxVulBDjdE334mGqMlOOiez9GJSsyNlEh1WGfDgjbFXKFO6DnitXU11Va0llhW7du4+UHDMNIBeh1EMD1Ujp796ORG0sJimqZqXYelTy/B/kj1GWc3Iq0qul2BeHVQOMRJRX0+TGVa06JUXAcH0WR6UuZviHgvsUROtTiExVmnLWgxnlF3Wr5s6CE8wdQ3tXREmwooQrXaqp7iS/tphqnvnRqKnNyAsVfsWoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZBTIaXH1MoyhoHWMr+ZZOz7LzWdFDcaSADpv6EH5mc=;
 b=yYDR9+VZ2Hl3BqLYO3TKK6y9ER1lGIPkvueC88xyWyVhmWYz6myfHsN0L8Z9x4H3E1YZCsYfvBnR3C8/8msblTNMq/cTMyNbxrp4TbpPOG4rzmvNBk6hnivd/qeoVnTAZDl22r/RWgH6OIPx40mL3x1gEH6QqEDpfqFtjuWItKB909vljR7cplK9n9v9bNI8aJQH/nC2nRBVXo6Pzm24vR9OdlwNjcuMj/WDz0on+Dk2RDJck5xJGjyPwmGiUxhtVtTwcGjV/rNWmxLtCkiznemOlRAhD1djZDnhu8ZHZVv3zuH83jHcaJ57k5DwLV5Sq6gkQCncjT/3MqQq5clJDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZBTIaXH1MoyhoHWMr+ZZOz7LzWdFDcaSADpv6EH5mc=;
 b=lLJFfDAaME1YW2+z6B6hqIueFzRlz8Mf7Fxp0cdmhDDkXjhrWODCXSi9yDCmC7T/AjtRBXlPmyUwZf7JaN+8xC+KnLn9hVr55WXZwXb1Z3PG7Ra9bEdEfp3Ww7N/p3KBUfZ0Jg9o3vdlu0u6JxfnPgVLPnOCiYCDPTf4Zs/YOrGN2JDOLJRrM9NdyOmPGPlPbFt9r5NheGy7jwCnhq/ENAbpkfv9rj4SRuBt7LKwRMaia/TBRLvKZvXlsCPGLdkd7f3ozKVbnAUAQikJ+6/OMoxcvW51hayQ8OuU4DWcjFYm7wJiRcTFg2L20RFPKanuJVNvVWJVbJoJqjhkPK+rhQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAXPR04MB8909.eurprd04.prod.outlook.com (2603:10a6:102:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 12 Nov
 2026 07:48:46 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 07:48:46 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 12 Nov 2026 15:53:07 +0800
Subject: [PATCH v6 4/9] dmaengine: move channel devices to the DMA channel
 bus
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-edma-iommu-v3-v6-4-b038edb8ce6f@nxp.com>
References: <20261112-edma-iommu-v3-v6-0-b038edb8ce6f@nxp.com>
In-Reply-To: <20261112-edma-iommu-v3-v6-0-b038edb8ce6f@nxp.com>
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
X-ClientProxiedBy: SI2PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::9) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PAXPR04MB8909:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c389396-cb13-4a82-aa1e-08df4091619d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|23010399003|376014|7416014|366016|261026140227099003|921020|261028144727099003|261102123227099003|11063799006|56012099006|261022075727099003|261021123027099003|261022105027099003|261021121427099003|261009223027099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	aIPwxMxsuZn/HM+u0dmveCV7FZ3jjxiTDnmgg4B/0n/WkokezDdZPnZzskwD1RGoJ763Ki3Z0FlyjZmRe4NRwogpAdO/ynlmkm5hqU1inG31KGkCeqTOYlfRiI+JaYNcjHoa27PJa05jtpOWtK6w/dZm1rNNdOgYSomIOlBu6/4Gh4kMRshVGsCErg008U9w4A7LyYcxFr17pipc+h22Ow/JVqxUN6pRbnrtubWHALY05dWXmhpyICL0QO+3GiTKrr90LsBdbRjZU5kA0RtvyaJXlsqAjY4O9hIpYye+wLVaVFXA+7XDiFNeZXbLDIZE5RvJfGV31Ob4FfEemEEPiOaGve0TzFLTMwmYoSpkdqBowyuqgYkgZlcrN1VC3THTM4JOxNYFT2MgBBrQ2H78dYwWcXTwBZ7RZ3aB7cTORyzE+OvckqkTm7JE+P9j5mXFHMOmwj/kLB9HceM82vywQi7s88RZkZlcKO853FpkOSqXGqxmouWG3uHvNbGRVfdxBKonHNA9E8+2kxDntmlBotA1WrwCKh7sbWP+bxBLskqsYCO7K6Mz9RaZfn7XiI8nXGVBlBYT8fKhEtisYbGtMPq+at2kYeMAhvv2jWGPsHpHtML5lNwz155wKar19ZlaIeFsKYS0Ybx1GVkfxbBfk87nCI0+vMoYUuQOagAWIECPwxas/ZVqREOUjiP2SImSNs798tzASdDRARFW+xokLA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(23010399003)(376014)(7416014)(366016)(261026140227099003)(921020)(261028144727099003)(261102123227099003)(11063799006)(56012099006)(261022075727099003)(261021123027099003)(261022105027099003)(261021121427099003)(261009223027099003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUhFK1FMRG9rdHlEYTlKUG04YUUzYXRVUkxhSGlGMHRwL1poQTh4TzZyejdu?=
 =?utf-8?B?MmJUQnpMQzRqRi8xMUlsQWdneWhQWGpJczkzdU12MVJxVmQzcXZ1TGRaTmJu?=
 =?utf-8?B?MDZUYmlURE5lcUI5bVN5MjlvNkxFUzJwMkZsdmtLMWJXSDhBUWJoQk9IUkZI?=
 =?utf-8?B?bkUyS1hUbnhrendRTm9FdkR4ZnZMQ3diQ1l3YURDUjFUeVAyUGcybjFKODRW?=
 =?utf-8?B?bFptd29NeDVDdzdCVWFlYVFVZUVVOXl5TmFlbmlUVWFLWHAyZU9jdzk5a0Vi?=
 =?utf-8?B?SFc2TnYzblhyTWhLeXU4M21tRVl5ZDhTYXUrSFZBZjdKdWo0NVFyVzFta0Zp?=
 =?utf-8?B?R1picnlNdlR3ZVZGZ3Y2dGloSWRlWHNyM05od0VwVXpFM2lyamlMQVRvbjdh?=
 =?utf-8?B?MWZKUFN4a0pHb3RkM2VuZnJqSXBPT0QzWmY2UjIweXFpZUtxU0JDOEtnZzRl?=
 =?utf-8?B?NW43Y1hhcCs3Ymo4clBEUWJPMGM0THZsWFlMNlFXWEJwVUhyZ2l5MVpJU3Jk?=
 =?utf-8?B?bFRDcG5TaXdGYXpaWG94SnN5akF4N1g1elpGdXQzZHJrcGRZVEVobkZ3SVcx?=
 =?utf-8?B?dTZUT05oVG05QlBlT0kzQXg1NWFYZmYvZ05IM1djdkVQMnNRYWtXS2cyWkpD?=
 =?utf-8?B?clpGbWNHSVNSODgyYkNEMk5HazZvWVJOZzVudERnM0YxYXkvT0w3YXVWMXlx?=
 =?utf-8?B?WVRzN21Bd0FmUjhiN3lRVkVQVHNWc3IzZm5KZ1BKSjNuYXhWMFlPR2dxTkNt?=
 =?utf-8?B?U0NqRzFpZUxaUEU0QytvMGp3WnJuOE5KSEZxU09mdzlrdzNKaXB6cTBYWDJ0?=
 =?utf-8?B?Y1ZoV3RxSWlMVkErUXZqU1oyVHM5dFl3VFN3Qm14V0VkOG13UmhMajU2RDBF?=
 =?utf-8?B?akxkL3haaHNIQ2ZqUjdtZG9paFJpek9JalJJNitWT3pJT0VJZmtHT09zU1l6?=
 =?utf-8?B?em5EOG1sWWZKV2pkQlMvbEdlNXEvQm01b0FkL0dzaFlieDBGSzQ5RDVxbElz?=
 =?utf-8?B?MEh2RnBoSktJWGJFdGIvei9vdHlMb2pjTU1QdHA5b2JNbGJPOURibVNYRWU1?=
 =?utf-8?B?VGsxQ0xPOWdXQ2JRVGJhTzJtNXp5UUY4MzM1OUl5ZElyQVpVRytRY2pXQUVZ?=
 =?utf-8?B?WnVwM09KN0FMZUZiVzNPNlhJR1RFZndwVWxCb29zZWsrOWJMQWcxS25Cd2Jw?=
 =?utf-8?B?RjZYNkpzQXZ2UDA4OU9CMjg4aXdJYUhmWXVhUHl2c2FpOTcwOVpaYTJjc0VZ?=
 =?utf-8?B?RnFVNlN4aHpMOFUwalVWcFVtbUJWTG9oYnJJOXh1UUN3UHFMUG9scCthU3VY?=
 =?utf-8?B?T0lqYmZ1SERTRDJaaWNCaUVUQXVQK1FNNE1YNG1EcnRkWHR6OVdEY3lzZ0lC?=
 =?utf-8?B?WG50bTRHb2dHbk83TmtXbGI3OCt0cjFpS1BkOElETUpuWUlHb3htRXlNTmNw?=
 =?utf-8?B?N2hpdmduRWJCMGpCT01jQ1hCUGoraFRDWXJPWmwvZ2dkRzVQM1NWaCswT0pl?=
 =?utf-8?B?S3IxZzJldENSVlhtWGc2bHJNNWRvMmkvMUNvY2tqdXJmcGRhbWpQeGxncm9x?=
 =?utf-8?B?N1VTc0EwOVdIaWpua0ltRTFBZVFQMGdXandhWThOT2F4QUFqUkw0djlZaXdo?=
 =?utf-8?B?YWd6THR4WFB0cDZzWlg0UlZRZE9NODhVL3R4MEd1Q3htRWhtejZIakZINUkx?=
 =?utf-8?B?WHBkeUJuTGtCU2Z6TGU3bUI0TEg0cGp1Vm1ZMnozK1NzR01XbXdQT21XYlgx?=
 =?utf-8?B?YmpoNzRPTW9BSUlteW1VZnUrU2o4OVMzd25yUEhZekdrYU5iK3ZSNmFIbE43?=
 =?utf-8?B?dnZGNW0zcUtFYW9aZkFVV1hVaEw5NDRRMk5lRVc4Slpyb0RNd3BuTXhXT25Q?=
 =?utf-8?B?Um04SkJJOEVJcldxa0I3T3VXclNBdXBQYUc4VExaa0pyNHZ3YkxMaUJnMVUz?=
 =?utf-8?B?YjUzSFNxNCs4VU80T2FCZHV1cTdHdXRCTmI0TXRRYXhwL2FoTXBsQUowbUZ0?=
 =?utf-8?B?dnBGOW9KUTVlSC8zSnVMMU1ObkIyUzdaNUdEbE9tWnNtWEJxOGlIY1FnVDli?=
 =?utf-8?B?U0NLK3lmZXpITUdEV2llSVVaYUpzRmd4ajZEOHhxUm55Z24xMDk3MWdaTFU4?=
 =?utf-8?B?eTE1cUNMRXNFbGJoQ01FRjQxcCtTWkp2WW5McW9vNXBEYUdRUXFKckdjNTlz?=
 =?utf-8?B?bjRKRDlCamZ0MWFXTmNxUmQ3Wm8wWHR5TVE5eFdRRjg5Q0Q4Ym1rQXhQZEMy?=
 =?utf-8?B?UEo5aTRHTE5wRUliUE1FelJlS09aUlQ3bERhY3Z3QXRRTDFFY1JLajNkSFBl?=
 =?utf-8?B?Nms1TmZpT09iZW9IWVRsMUdqamhMRXBoSFpsQSt4clJkUEpHN29ZSDdsaWpu?=
 =?utf-8?Q?JAZ0KbxBqXFwx3c1/pDtqyfcVvhak5DgUOBLZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c389396-cb13-4a82-aa1e-08df4091619d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 07:48:46.4819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6+h0FptkunXhXMUm0sRc0q5u/yVE6fyz/Zq9NDvf1pofI3JU4wCM8wViB+cZP97Rxe4xxNV9f7eO1+A6UbA4NMt922uGpnepyN2hP3jWW92Ug9QeONYLDOj+SSV93Qh3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8909

From: Peng Fan <peng.fan@nxp.com>

Register each dma_chan_dev on dmaengine_chan_bus_type before
device_register() and make it a bus device instead of a class device.
Setting the bus before registration lets bus_add_device() take the bus
subsystem reference, so the matching bus_remove_device() calls drop
references that were actually acquired.  Attach dma_dev_groups to the bus
and set the device release callback directly.

Keep the existing /sys/class/dma interface by registering a class_compat
named "dma" and creating a link for each channel device. The channel
devices now live on the DMA bus, while /sys/class/dma/dmaNchanM remains
available to userspace.

The bus is named "dmaengine-chan" rather than "dma" to avoid colliding
with the SuperH DMA bus, which is also named "dma" and is registered later
from a postcore_initcall. As a result the device's uevent SUBSYSTEM and
"subsystem" link use "dmaengine-chan", while /sys/class/dma is unchanged.

Remove the post-registration dev->bus assignment from the Tegra GPC DMA
driver. Leaving it in place would overwrite the bus selected by the DMA
engine core and reintroduce the reference imbalance.

The DMA channel bus match callback never matches, so no driver can bind
to these channel devices.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/dma/dmaengine.c        | 23 +++++++++++++++--------
 drivers/dma/tegra186-gpc-dma.c |  1 -
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index e1022d297674..45e328d28689 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -239,11 +239,7 @@ static void chan_dev_release(struct device *dev)
 	kfree(chan_dev);
 }
 
-static struct class dma_devclass = {
-	.name		= "dma",
-	.dev_groups	= dma_dev_groups,
-	.dev_release	= chan_dev_release,
-};
+static struct class_compat *dma_chan_class;
 
 /* --- client and device registration --- */
 
@@ -1115,8 +1111,9 @@ static int __dma_async_device_channel_register(struct dma_device *device,
 		goto err_free_dev;
 	}
 
-	dmaengine_chan_dev(chan)->class = &dma_devclass;
 	dmaengine_chan_dev(chan)->parent = device->dev;
+	dmaengine_chan_dev(chan)->bus = &dmaengine_chan_bus_type;
+	dmaengine_chan_dev(chan)->release = chan_dev_release;
 	chan->chan_dev->chan = chan;
 	chan->chan_dev->dev_id = device->dev_id;
 	spin_lock_init(&chan->lock);
@@ -1128,6 +1125,11 @@ static int __dma_async_device_channel_register(struct dma_device *device,
 	rc = device_register(dmaengine_chan_dev(chan));
 	if (rc)
 		goto err_out_ida;
+
+	rc = class_compat_create_link(dma_chan_class, dmaengine_chan_dev(chan));
+	if (rc)
+		dev_warn(device->dev, "Failed to create compatibility class link\n");
+
 	chan->client_count = 0;
 	device->chancnt++;
 
@@ -1172,6 +1174,7 @@ static void __dma_async_device_channel_unregister(struct dma_device *device,
 	chan->chan_dev->chan = NULL;
 	mutex_unlock(&dma_list_mutex);
 	ida_free(&device->chan_ida, chan->chan_id);
+	class_compat_remove_link(dma_chan_class, dmaengine_chan_dev(chan));
 	device_unregister(dmaengine_chan_dev(chan));
 	free_percpu(chan->local);
 }
@@ -1306,6 +1309,7 @@ int dma_async_device_register(struct dma_device *device)
 		mutex_lock(&dma_list_mutex);
 		chan->chan_dev->chan = NULL;
 		mutex_unlock(&dma_list_mutex);
+		class_compat_remove_link(dma_chan_class, dmaengine_chan_dev(chan));
 		device_unregister(dmaengine_chan_dev(chan));
 		free_percpu(chan->local);
 	}
@@ -1652,6 +1656,7 @@ static int dma_chan_bus_match(struct device *dev,
 const struct bus_type dmaengine_chan_bus_type = {
 	.name  = "dmaengine-chan",
 	.match = dma_chan_bus_match,
+	.dev_groups = dma_dev_groups,
 };
 
 static int __init dma_bus_init(void)
@@ -1665,9 +1670,11 @@ static int __init dma_bus_init(void)
 	if (err)
 		goto err_destroy_unmap_pool;
 
-	err = class_register(&dma_devclass);
-	if (err)
+	dma_chan_class = class_compat_register("dma");
+	if (!dma_chan_class) {
+		err = -ENOMEM;
 		goto err_unregister_bus;
+	}
 
 	dmaengine_debugfs_init();
 	return 0;
diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index ec12b7288b43..93b136f875d4 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -1540,7 +1540,6 @@ static int tegra_dma_probe(struct platform_device *pdev)
 		tdc = to_tegra_dma_chan(chan);
 
 		if (use_iommu_map) {
-			chdev->bus = pdev->dev.bus;
 			dma_coerce_mask_and_coherent(chdev, DMA_BIT_MASK(cdata->addr_bits));
 
 			ret = of_dma_configure_id(chdev, pdev->dev.of_node,

-- 
2.34.1

