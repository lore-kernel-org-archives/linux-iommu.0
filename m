Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794798083;
	b=CTKNT1mER+pfcPtEbA9jQNsCA9N601k0VoczcTvj6M4AmFx5VePCLoUY8d/wr3ANiD9q
	 VQuTM+KMwQevU0Yy4+mR1fkiyKt5GubA20AhlncrmnG1yOkeBnDOgkQtaANW5OClLw2lB
	 INvO9czGNyajGBxMghJTWDUGNQFfDtdg39GDC+g06+Avw9/6atWu9zxrXJsFmUQS/6DgF
	 zEbaq4J5Tarkqpqbp4ilNuaMnJ6t1cJnCzSPh0krKIG39x+TiLQ+hP70sUWq4haIiqo6P
	 Y5gtuZYeb84vLCiDlb5ZB/+PO584BOc5Y87GOOcZTStV6TM4KdkdyB4ri/wAkr7RA7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794798083;
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
	bh=Q4p557ehxU0m1R64op4Ol9MK9klL/1e52KKEJwCthNE=;
	b=moGTt3U3fCM2cG8hZafaxEtevNU0g31H0ssa9EUb7cUtN+tl85FGPLP2mMHrUvN/CNrj
	 JLhm1tm6UNYyNBUbcphAR8+nNnoEFS7G0qbrDfPS0BsbINlwScgZ7XnSNHeU4f1UX5iD+
	 bL7FWKvgYt7fcVxTsX+Fuo2rAmZHbUDCU9TSmX4aSoUJ+grKcCma3Aof4ijWUBsOY8NbE
	 MO+xfLlrB2Ji/8zIq+HT6FpQkmG5HxTbRaeMqSD+vuXJGWwO2qmRmuggp3HVg/Kc5JNP9
	 8kzze1zg1UMqoDJ9jjzjzKKdlRm44C0RokQXyJAdYn9jr3AfvSqo73ihYAIDHVjTyew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=J+K0IcT6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.17
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011017.outbound.protection.outlook.com [52.101.65.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB35606A32F;
	Mon, 16 Nov 2026 03:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EB35606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=J+K0IcT6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3Z//caXjfXFMsmL25DEK81qhxVgF4maxvq64fnaCkJElSzThfJrmDeaIoerN8JSyRwoYPcAD10/Z11MS+Sq8c+KMyG7+C2CycDkBJXCjPFOdX+GL89h4bg559h8dmi4lhmM2kKD+Nr9l10+kv/cF/lgauTqlW7cQAKhs95wQlw8xio/ZQtIBO2u7JlfGF8vXNyN0jfeyTJp3Iy3qtX/MeNSy7nCUH1iIlZ5rw5NDe9YafoYwM2rSncCyPaN5eiPgakDG404Zc8Sa6x+PgFtlae7RzeckmhsJq6U/KUyu4ptetInQ7x5JbmWTxppyQifCk2ADs80CQXl7DhMNCdw9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4p557ehxU0m1R64op4Ol9MK9klL/1e52KKEJwCthNE=;
 b=rgV0ZQXvRqOScNPf7IJ29jNukvj4CWzSou/wxeqPgvLf2S4K67jRRb2ydgJcNZBhNRfAnCveJxFMPnFUnx+QTh3yTp6xhfPU7OI7L+r8O0dlPq6cuqaXQw4xpQTPGMGrvaihFT4waCOibfO3VzhzdIiCZJQ/Dx8BsS+qGQn/juh9rrmu/H1ZyKL/xKNO23TFSEeMiypI+i9iwDxd8Zy0iWuyN/HYbWAHIRVXoe3ydAiyvBd2piPPdg6iQml8vJD2j8R1kdL/TEy1pLN1AQKk/XlBtqBXt3dznFOMa1a9SgNaZ702mYzjZFR1KOKOUW6OXIGRmzt534/VvV/eE0SuRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4p557ehxU0m1R64op4Ol9MK9klL/1e52KKEJwCthNE=;
 b=J+K0IcT63WMDd3HWcTY1tvPdzoYbD2gp5P1zM4KNHRMDfnuKYba9KqoX94qjCzgndRPAzK/Ww92GRNBRwCKB3bGDC0CepjhmEE00Kb8vQiUvJzVKkn/9hQ8B0wMv7Q2mt7kcI9EZ+FAa7/VeJ9z8TZa57oAvbcTzW0kaRTRkoUcgkz7WbGt8upcMdetUWuveywbda2PAMYTBKTdiu84UBI2xXEDvHJQtCxTAVvVttv0VdrHInez7S5VcJ83GZx1sXdfYNJPxV2CwzD/QZnJx10R1QMYiIOcZChiIwIdOUgZVJMezfkkqbeeqSqgrapCKw7Z4E2cQ8ElIdKb7oEjvgQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PA6PR04MB11778.eurprd04.prod.outlook.com (2603:10a6:102:525::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 03:01:19 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 03:01:19 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 16 Nov 2026 11:05:29 +0800
Subject: [PATCH v7 8/9] dmaengine: fsl-edma: support per-channel DT child
 nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-edma-iommu-v3-v7-8-32794ba8efbf@nxp.com>
References: <20261116-edma-iommu-v3-v7-0-32794ba8efbf@nxp.com>
In-Reply-To: <20261116-edma-iommu-v3-v7-0-32794ba8efbf@nxp.com>
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
X-ClientProxiedBy: SI3PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::6) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PA6PR04MB11778:EE_
X-MS-Office365-Filtering-Correlation-Id: efdadd94-0ac5-461b-6a28-08df438de383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|19092799006|921020|10067099003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	p4UZNENkNu1yR5shi1Tjluxiu7fhGeD280kS+fOTq9c7TGfTwLflEiHq0Gyai9Cg+QT6c37O3jWCc/cW5KhPXIAAyiUkWFi8GvOwFEExAOip9dYbMDIk9DpzUs0Ar7gfYk8qC1FBieKZ0Lg6XUOQ7aHW040Z3nvU5s0vuMsmZPOZNjOEQ+hzvpQQM2KvVyzAIyWq2Q66AJGweko8bFdcmJdRGlFpdp+2GMERCURUKOz+H6uUHbqeZg3BwsfwMjfFOBs4+nKqjUEYBIN/qWk/YUiOiG6aOmJIed7ZgTALqGnGP5i/AlxNxVKyFTmT7mJ8aSld+sGFVrACLVf0abaQK2M5Cak1BQ4WzBu1LE4vvI8jLP6vr0oGjIJ19X/Km8hY8k+upbWWiv/hPsrlis89S9TCz3qV9nDjyUYbZ/0cUcdpdfxioOAgk9zKkdyfQAQYWMjIWxO1r3QsQaE00gsg0rD035tCXm8owNK4gKhNYnBEFAHbIgVyYz8OcYOZM/oSL5iJTsDSIwfouFPPRremPw+uLWWkKxB22U0T0h19GFNQQS+GLycf4goBgLTBBmxYjqELqiXdWZlQjLNAyA3ABfVwAykl56izOyh4nPgUYL/lNCGTqWcY3cIwAQ4dlnSF30qgaVVELmwpXZmN5p+lwTUgneas39Z6x0VL2o9TA6AnQf//w33Mfv0H+9SAMsdhYrmh1E5ykg8r6IXs71Z2Zg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(19092799006)(921020)(10067099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alNjOWFaTUc4YTQ1VFk1dExGZmlFL3BLYWM0cjhmZ3Y5VWhSOW9Xc1pOSmFt?=
 =?utf-8?B?RWFsQmp0Q1lpcjNHcFBKOFpjMGNLUHZzZDI3S2ZrSGJTN3FuMVV2Yjc1djBR?=
 =?utf-8?B?cHlLb1ZLVmU3QTZERlZhdHNISDl6c2E1UzA1dVcyaXdvWm9DMGpIendVaks2?=
 =?utf-8?B?Z0VSQitIQVFYeHFWbXcvOUc4NEtjblNZMWw3em14alg2Z3JWZDV2NmxCazFk?=
 =?utf-8?B?dTVvaHZjdkhLV0RrSHdjWEx6Q2xGSUNxeW5YQXNJTmF3S2ttM2YzbGwwaklM?=
 =?utf-8?B?ek0rZlQ2Z043WnI1Tk1rbll2M29LbkwrNU50dTNSNkhQRnhFLzJCbEdkb1NE?=
 =?utf-8?B?NnBJZ05vaEtwZlplMDB1Nkx4Mjl0dWlBZ1c1TXphb2hvNklqZHIxaHVQWXFT?=
 =?utf-8?B?NmFxMWp6VHVUSVpyVWRnRzY0YlpCSVQ4UzFWWm4rODdLWm1aQUpZK2pBNWxI?=
 =?utf-8?B?bW1PbUZmY1orNWU0VTJKUnhBL3Nlc3dNdm5LRS9aZzN0cTZHckF6OE5CbjhD?=
 =?utf-8?B?blZuclo5ZUI0am9VQjMrcU5QUmpENU56VjNybm1LdFJRYk5FZmFvWXRpQno3?=
 =?utf-8?B?NGdndEZWdnN3U1dDdUdGSm9PU1hRMHh5Q3hBRXNPMDR6c1pUUkVXRlgrcWZR?=
 =?utf-8?B?QmhaWEFXVFJibnZ0c1pMdzZXQUdQdVB3ZHpTekZZVWpGcGNXZVRVV3pYQzM3?=
 =?utf-8?B?Ri9yV2dPQjFvSkNWSXREM3Fyc3hkaHM4S1NqamJCOVorNlFBeitOYWdnOVdV?=
 =?utf-8?B?L3UvUkhoNGlxeU0rTnB2WGR3L1VHTkRqNnFxQzdVZFpqTlE2WTgxdnhPb0Z1?=
 =?utf-8?B?YnBBWlB3S0dZNXR5Q3dFZUplT1ZDOFp2V003eE4rbE5pVkVKY3NkV0ZPa3B5?=
 =?utf-8?B?VFdEK3l5a0pNdmlqRlBkSitPOVQrS0pQc01PRjk0SmZ3NCtjanhQR2lESkc5?=
 =?utf-8?B?NmJ1azhEWXhPcWo3Snc0VEpJc1NaMjRKSlcyOXpOK1B1eEY1eGlWWFk4eVlD?=
 =?utf-8?B?U1FOWUpJajdjMHR6ZVJPckJZSzJrLy91bTZ2RktjUHIvaTZORmFyWEJ5bzB5?=
 =?utf-8?B?YnMvWWk4dzZTMlkzZzB5cFF5QWllbzNySHg2dDl2Vk9XenJKYlZTMDVLdi9i?=
 =?utf-8?B?NnQzV1dEOHp0emNUKzhjenI5eGlpNk5zSXlzU2RlV3BjL3VPTmFkdlNKQTRw?=
 =?utf-8?B?VTNpRjNBaGtML1Qrd1Y3TzlDM3AyZFZzMlBXb092Q2YyaGFhSGRPVi9PeDAx?=
 =?utf-8?B?NmZZM3FiSWZNWCtlYXlvVm1KOXJGQXpxUGI5eStycFBzTlFDOHA0TllFS3Fv?=
 =?utf-8?B?cks1aGVjWEJBdmVoR0pPL0dnUVM5SGErSzgrc1NNejVQZ0RsK3ZHa1VhQU0r?=
 =?utf-8?B?S3JDdmg4bmJGam1ReWlNWXRiVUs4bFVPOHFjN3RrRmY5Y2FSUHhXZVBYWi9i?=
 =?utf-8?B?RVBrbXRHQmsvZGpGb2kyVWoxd1U2cndtc1VIbHBvZCtjTExWMURTVWx6WjNt?=
 =?utf-8?B?SVFWeVp2UVdnU295LzBpdmFKRjF0NEhqeEhYV1d0aGpHRGpKcktwS2s1b2wz?=
 =?utf-8?B?SUY1Ym9WaFJtK3pFUXdXZmVvV3R1d1pyYnB2ZkNQNXNiMklFSSt4Y1NsZytq?=
 =?utf-8?B?am9ZajNCa2lTbU93eGFNL0JISHFSb1hSZ1QyTkY2elhGRHp3MGk5QTJFeU5H?=
 =?utf-8?B?U1hsb09kbFpPSm13bVR2TTRKQnlqS0gra0p3Y3FYZTFmMmZ4ejNLYTBXRnlQ?=
 =?utf-8?B?WVRiUTZrVTNvRnZWemdtcE1jdHo2SzVORnI4RmxWQ2t5Q1NZTExhZWF1Z2lW?=
 =?utf-8?B?eFBwUTc4LzNLbXhnWG5Dd0xFblA5OWY5UEkvYnZ0dXdLbUV0UWNvZ0lRYjgy?=
 =?utf-8?B?WTlHNVJyMndIUGZsa0dWaTVGbVJxZWsrNDJFQjhKWFg3WW5leml0aWxtSUdO?=
 =?utf-8?B?UWNYSisreGZac3FUWEI2UXVuYU82SkVlY21rY2lHcVFoZTVoaXlFZGZNLzls?=
 =?utf-8?B?RXE1cjlrTldham1xYUZpbEFOOVNzL1VuQnl1SGh1dGN0emFKUmhhbEdoNG9h?=
 =?utf-8?B?eUtpcnl6WG9vQUxMc0xXcmNtRXdZMWlBbGRvY3lHSVNQYXJjZW1tcWdXWFlj?=
 =?utf-8?B?cHJqNlpheDRoOElZaGNFNjREcW44L3lpNCtldCtnSDFlcVJ4NjZBWVhCeGlV?=
 =?utf-8?B?UmJMMzdsbTR5cnBoQmpRQTM1a1prVHRTVWNoTnFmN2N5NlBqU0FKZFh0YmFi?=
 =?utf-8?B?R0FDam82dHpCK1VzWFBjcDRGaEk5NTRWUkUzM09oMUR2SmljYW11NUFWalh2?=
 =?utf-8?B?Qnd3ZGs4WnJ3NUF6L3Mxb3VwOC9JeE5jVEI3ZFJPcjMzZDNQWnJYb0JFTWt4?=
 =?utf-8?Q?V92yJlfyGCOuzmjoHjI3EAN956Fljnb9JJEIM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efdadd94-0ac5-461b-6a28-08df438de383
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 03:01:19.8839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bal/o0REwoM1DJutqMH4WmP/rcK6/XdClavw3z/GzH0lwX/H/EZ02BwFiKh0xIlxNeAGE9fFR/M8Mn4KzHyZKXLRBHRPkkbhA0UvoKDxRgzXzmJkC9clNFmpVUB1rmca
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11778

From: Peng Fan <peng.fan@nxp.com>

Add support for parsing per-channel child nodes from devicetree.
Each child node can carry its own interrupts and iommus properties.
Child power-domains are not handled here; power domains remain attached
at the parent level.

The implementation is split into two functions:

- fsl_edma_child_to_chan_id()
- fsl_edma_configure_chan_from_dt()

The per-channel IRQ and IOMMU setup are handled in a single child-node pass
after the channel devices have been registered.

Child nodes beyond the configured dma-channels are ignored, which allows
boards to reduce dma-channels without disabling every unused child node.
If child nodes are present, every unmasked channel must have a child node
with a valid interrupt; otherwise probe fails with an error asking for
dma-channel-mask.  In child-node mode fsl_edma3_irq_init() does not fall
back to the parent's flat interrupt array.

The shared error IRQ remains a parent-node interrupt.  A child-node-only
DTS without that entry simply has no shared error IRQ.

Existing DTS without child nodes continues to work unchanged.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/dma/fsl-edma-common.h |   1 +
 drivers/dma/fsl-edma-main.c   | 159 +++++++++++++++++++++++++++++++++++++++---
 2 files changed, 150 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index cbb077e98f55..8843dd5661fb 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -271,6 +271,7 @@ struct fsl_edma_engine {
 	int			txirq_16_31;
 	int			errirq;
 	bool			big_endian;
+	bool			per_chan_irqs;
 	struct edma_regs	regs;
 	u64			chan_masked;
 	struct fsl_edma_chan	chans[] __counted_by(n_chans);
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 818b9b986f13..541f1294973a 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -12,11 +12,15 @@
 
 #include <dt-bindings/dma/fsl-edma.h>
 #include <linux/bitfield.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/clk.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/of_dma.h>
+#include <linux/of_irq.h>
 #include <linux/dma-mapping.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_domain.h>
@@ -400,12 +404,21 @@ static int fsl_edma3_irq_init(struct platform_device *pdev, struct fsl_edma_engi
 		if (fsl_edma->chan_masked & BIT_ULL(i))
 			continue;
 
-		/* request channel irq */
-		fsl_chan->txirq = platform_get_irq(pdev, i);
-		if (fsl_chan->txirq < 0)
-			return  -EINVAL;
+		if (fsl_chan->txirq <= 0) {
+			/*
+			 * In child-node mode, missing child nodes are rejected
+			 * by fsl_edma_configure_chan_from_dt(); do not fall
+			 * back to the parent's flat interrupt array.
+			 */
+			if (fsl_edma->per_chan_irqs)
+				continue;
 
-		fsl_chan->irq_handler = fsl_edma3_tx_handler;
+			fsl_chan->txirq = platform_get_irq(pdev, i);
+			if (fsl_chan->txirq < 0)
+				return fsl_chan->txirq;
+
+			fsl_chan->irq_handler = fsl_edma3_tx_handler;
+		}
 
 		if (!(fsl_edma->drvdata->flags & FSL_EDMA_DRV_ERRIRQ_SHARE)) {
 			fsl_chan->errirq = fsl_chan->txirq;
@@ -415,7 +428,11 @@ static int fsl_edma3_irq_init(struct platform_device *pdev, struct fsl_edma_engi
 
 	/* All channel err use one irq number */
 	if (fsl_edma->drvdata->flags & FSL_EDMA_DRV_ERRIRQ_SHARE) {
-		/* last one is error irq */
+		/*
+		 * The shared error IRQ remains a parent-node interrupt at
+		 * index n_chans.  A child-node-only DTS without that entry
+		 * simply has no shared error IRQ.
+		 */
 		fsl_edma->errirq = platform_get_irq_optional(pdev, fsl_edma->n_chans);
 		if (fsl_edma->errirq < 0)
 			return 0; /* dts miss err irq, treat as no err irq case */
@@ -703,6 +720,124 @@ static int fsl_edma3_attach_pd(struct platform_device *pdev, struct fsl_edma_eng
 	return -EINVAL;
 }
 
+static int fsl_edma_child_to_chan_id(struct fsl_edma_engine *fsl_edma,
+				     struct device_node *child,
+				     struct resource *parent_res)
+{
+	const struct fsl_edma_drvdata *drvdata = fsl_edma->drvdata;
+	struct resource child_res;
+	u64 offset, ch_id;
+	u32 rem;
+	int ret;
+
+	ret = of_address_to_resource(child, 0, &child_res);
+	if (ret)
+		return ret;
+
+	if (!resource_contains(parent_res, &child_res))
+		return -EINVAL;
+
+	if (child_res.start < parent_res->start + drvdata->chreg_off)
+		return -EINVAL;
+
+	offset = child_res.start - parent_res->start - drvdata->chreg_off;
+	ch_id = div_u64_rem(offset, drvdata->chreg_space_sz, &rem);
+	if (rem)
+		return -EINVAL;
+	if (ch_id > INT_MAX)
+		return -EINVAL;
+
+	return ch_id;
+}
+
+static int fsl_edma_configure_chan_from_dt(struct platform_device *pdev,
+					   struct fsl_edma_engine *fsl_edma)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct resource parent_res;
+	u64 child_mask = 0;
+	u64 missing;
+	bool has_children = false;
+	int ret;
+
+	ret = of_address_to_resource(np, 0, &parent_res);
+	if (ret)
+		return ret;
+
+	for_each_available_child_of_node_scoped(np, child) {
+		struct fsl_edma_chan *fsl_chan;
+		struct dma_chan *chan;
+		struct device *chdev;
+		int ch_id, irq;
+
+		has_children = true;
+
+		ch_id = fsl_edma_child_to_chan_id(fsl_edma, child,
+						  &parent_res);
+		if (ch_id < 0) {
+			dev_err(&pdev->dev, "invalid channel in %pOFn\n", child);
+			return -EINVAL;
+		}
+
+		if (ch_id >= fsl_edma->n_chans)
+			continue;
+
+		if (fsl_edma->chan_masked & BIT_ULL(ch_id))
+			continue;
+
+		child_mask |= BIT_ULL(ch_id);
+
+		fsl_chan = &fsl_edma->chans[ch_id];
+
+		irq = of_irq_get(child, 0);
+		if (irq <= 0)
+			return dev_err_probe(&pdev->dev, irq ? irq : -EINVAL,
+					     "channel %d child node has no valid interrupt; add interrupts or disable it with dma-channel-mask\n",
+					     ch_id);
+
+		fsl_chan->txirq = irq;
+		fsl_chan->irq_handler = fsl_edma3_tx_handler;
+
+		if (!of_property_present(child, "iommus"))
+			continue;
+
+		chan = &fsl_chan->vchan.chan;
+		chdev = dmaengine_chan_dev(chan);
+		chdev->dma_parms = pdev->dev.dma_parms;
+		if (fsl_edma->drvdata->flags & FSL_EDMA_DRV_TCD64)
+			dma_coerce_mask_and_coherent(chdev, DMA_BIT_MASK(64));
+		else
+			dma_coerce_mask_and_coherent(chdev, DMA_BIT_MASK(32));
+
+		ret = of_dma_configure(chdev, child, true);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret,
+					     "IOMMU config failed for channel %d\n",
+					     ch_id);
+
+		if (!device_iommu_mapped(chdev))
+			return dev_err_probe(&pdev->dev, -ENODEV,
+					     "channel %d is not behind an IOMMU\n",
+					     ch_id);
+
+		chan->chan_dev->chan_dma_dev = true;
+	}
+
+	if (!has_children)
+		return 0;
+
+	fsl_edma->per_chan_irqs = true;
+
+	missing = ~(fsl_edma->chan_masked | child_mask) &
+		  GENMASK_ULL(fsl_edma->n_chans - 1, 0);
+	if (missing)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "channel %u has no dma-channel child node; add one or disable it with dma-channel-mask\n",
+				     __ffs64(missing));
+
+	return 0;
+}
+
 static int fsl_edma_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -835,10 +970,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
 			clk_disable_unprepare(fsl_chan->clk);
 	}
 
-	ret = fsl_edma->drvdata->setup_irq(pdev, fsl_edma);
-	if (ret)
-		return ret;
-
 	dma_cap_set(DMA_PRIVATE, fsl_edma->dma_dev.cap_mask);
 	dma_cap_set(DMA_SLAVE, fsl_edma->dma_dev.cap_mask);
 	dma_cap_set(DMA_CYCLIC, fsl_edma->dma_dev.cap_mask);
@@ -897,6 +1028,14 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, ret,
 				     "Can't register Freescale eDMA engine.\n");
 
+	ret = fsl_edma_configure_chan_from_dt(pdev, fsl_edma);
+	if (ret)
+		return ret;
+
+	ret = fsl_edma->drvdata->setup_irq(pdev, fsl_edma);
+	if (ret)
+		return ret;
+
 	ret = devm_of_dma_controller_register(&pdev->dev, np,
 			drvdata->dmamuxs ? fsl_edma_xlate : fsl_edma3_xlate,
 			fsl_edma);

-- 
2.34.1

