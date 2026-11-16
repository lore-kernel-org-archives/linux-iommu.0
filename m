Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794798052;
	b=Nm1iSL9W+YXt0Ex3vlHH39FAcqrgUr/9sbNyBvVHyvtRBnVhR3dVOXM4ZctnBH1Po/mb
	 II4jJ7gWuNrAQpnVWE2RyA9QhUWofLvWCV4SVcWlWcwnkV8DUQMCHZ51ptiCL54pEMecT
	 jdVfJVtFQHfurHjXuH5+i+Dq2uwBPsdZHDVu0yPrWLaVkbSum/fgF6P6nVHA+k0NiXgg+
	 Pw2k3qnFScsdjDMY2vWfQA6NO5A9VB4guqEAsLQe7RVE93BUnQeilvC13usFpobm3m2pa
	 JdPChmKKcyHVLbe6XG+uXRmKPhzsditZk214ecy0KxTcxxp185skVt3KnTIG5abGr1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794798052;
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
	bh=ikQCnHOHFP2+XUglJTUtpFT7+r2FgjUaBXBBrRH9h9Q=;
	b=eLp2Z0t+FLIi5ViyFsu4Qmi93ooGredV5Y8FatLgr7TB1MpTLTFhCjrU2/+rTv9g0K8Q
	 rohgzEMztF8sl3forNZPYLyutzuyWHlMM3lbd3MG0Oh7M2LyMeoEHynDRSPCq+kLy1/7m
	 jnjsUJi7hLlUZ5wRyph61CXidbO+ca8hvZFwkVjFHKRhdbrdf4BT50cgwk8S4onhBCq1r
	 3RZNYBgmS8rktjAqupIS1yDnlgdfRs2AZUrcz2kBb56cjnonEX32IjtxlXE+wgumDEf67
	 N7KKchL4TH6RJCQbLg0ge64qIQQvDfeWEEFD9pu2Sh7Hf1/K1WxfVKernE8+6FKt1IQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=L2OLZC6R;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.48
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011048.outbound.protection.outlook.com [52.101.65.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013DF606A329;
	Mon, 16 Nov 2026 03:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 013DF606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=L2OLZC6R
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJ2mEnZfqDOgRXPNTUmgN68EIhw0/r7+O4aKg+57kGrXTvJAcf4G2BOLq3zT1AiMv9wDYN+DzT7LpaYxO9tBrrNLqe/QUp/hnl802i4n24QqhGyRmGQqWVetNF3NRr2q+eslR/uJnV9ykZ4EcvrGv8lgx1d7l4wiDqjnoh98lRldtnIzGgWKRilwZVBg1vuM/lHJxFYAdJ3sGexX3PvTIhR8TShamgi8Gtdo1R3BrBu4xrZBK6ewJge+6EM84mpfZLmCpkh1soRbfpVYmBQP3GEUQnmINEWuLa2P0vLnxraVimL95BQkpqZ1Zng6Wi86IzwMjxExOUYhLR9Pn+K+VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikQCnHOHFP2+XUglJTUtpFT7+r2FgjUaBXBBrRH9h9Q=;
 b=XSmTPw2M7kdSV94RdOQfL0zfjiKxcdpf4dzN7BE6hfREPSFznYEnD1wt61qblRdVUUzpxe8zM0kTZp4pIZaoVSfRdWFNdFpwidw5VlcZMXHTodhm9jr25xzpqJXRDnJOTL3uAJhsAqh9Pjg4dsQmfApoC1SOEQ9HExTc6f8BuqAveAUmxSumb0s2HkopRXY7aHmkfRJLGXrcLtFyyi158JAO6K7qZ3y2O16muaraApoEnCo/PajWsOCxFRP/3z3mwe2wq5DoTiuXFr78k2/ptrc9A+NDv66wuKoE+XpOL00KEfCUz5iUwORgZay86R7y1INlLeX8Y2zABmTnqdgbcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikQCnHOHFP2+XUglJTUtpFT7+r2FgjUaBXBBrRH9h9Q=;
 b=L2OLZC6RsfuCqCnTwbFZ7shDn4qrG/KjWgGNVfUhLi74wMrul0M/PG/TSY7ZELnhjpoAXYRltjU46t5fi1wSuTwLWf8Uh1q3p6RJ1Ahyq7vDOv3l3z79zX25y0v2gMeMUWxayOE+HylLyCsRLTstyZtP3mCrCbEwkUeG6/IKlIoTF1elBo1tKG5Ly1JVz+6KsJ6rP1hHP+/SWYw4GkOvr0TTe3W4LlCw/5FsTcLmMDFHaFlNUWtHDoXG05y8r0CeJ/jFlw+29w8k5n5tUNnvRni44vMPFjZfymqBjRc4LQbXAtYStuXalcZa28OsfQncW9R/qp4Z5aZWX21DX13d+w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PA6PR04MB11778.eurprd04.prod.outlook.com (2603:10a6:102:525::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 03:00:49 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 03:00:49 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 16 Nov 2026 11:05:24 +0800
Subject: [PATCH v7 3/9] iommu: register the DMA channel bus for IOMMU
 notifications
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-edma-iommu-v3-v7-3-32794ba8efbf@nxp.com>
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
X-ClientProxiedBy: SI3PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:295::11) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 27a8660c-b444-4224-199f-08df438dd155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|19092799006|921020|10067099003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	fYbqiIhz2KqEuXk37ucjtsHf4oSLRsTflPoFV9NyHMiAgI7pCjVM77fayZ9GPtb7LLJfOLEPVFd7nFbj2MCzITi4zOm4+sSSZ35x+WXiAiPIbvmcrJIe44T78eeEnQLvxaT8IoeKqnRYRZVKKa8NSQ686dKS8D+DGXPtJZNeKL15GKoNBskcPEkMnt7UxPeZrE9+qGDGazXmTYEHhQP/DZZKWgZR676u68BxhR9/dyLQVjrxqlMybLq3chDAeLZOIsmZlXqrQ8egtqcvIpUmMgsbpe6V+1nVijkFh42fIcF0uBPUEY+q75zdfdiNWPOQFwsmwDt1JhbgCQDzXG8fSnaa4Scpd1bDvQ9ZZFDyB0zahOLRAYB9eKL1ZFJd+60Xsooiee4J6a3kPnM4ZHyvW8ZpA2wEn2AAcTHrTJOMQ5I/Lm2mMQCzg1rLRIvQRBn/duJDwD/xvo74nUXBeQ2Zwm1Cl++EMH0grS+6RjNAjX4l4LV41oFyxg28wEpDNePFJHbcYbEtFsWm/K6X4jikTltOfNz/okVPg1/bV1bnNdlWyOOYBZkbHKaoBsjfAg4/mhveZ9BUOef2CnVK0W+M1MOg4Fp3zkC/1CKd3m2Zvj15GpvRJfHDmUyBdxxO2cQOqWxVkB5i1xfwNLOifDHfhDQwlGYwl8ms5u4y9Cs9EfKlZlMIt4ymuuUxBkZ6/qxu22dVZNxOUS1LtvqU5UCLvA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(19092799006)(921020)(10067099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWxoMWJVQjdkS0JYSU1zMFB4dGlZNVMxemdCK2VyNTRuZjd6aHl4YXR0Q1lX?=
 =?utf-8?B?a0JIQTU1N3J5b1g5WGoyTzVmaTVSN1FVK1hlNkdjeWhxbzV4YlZtMDlidC9w?=
 =?utf-8?B?RHh6R085KzhlaTF0L3NVNUE3ajR2WnM2Q2FpK1VYc2tIVVg2R0JJeUkrUmFH?=
 =?utf-8?B?dU1OZHlkZk9Eem9IbThxNEtkajlWdjE4UGJJWkFuL3p5b3VjOXoyRGx5TWh1?=
 =?utf-8?B?dFRNUU9oSmtCczVDaDZ4WXFoTVNzcDJYZTlJOXpjTVFheTFod1FaZXZ4bVhK?=
 =?utf-8?B?bW9PdnBSU0h1MnhXSVd0MWtyRzBsU3B0eE9GR094U241OUR3SGdSb0dycElR?=
 =?utf-8?B?VTBWd0U5WGwwT3BaTTZnOFFadXhGbUhWYmpiWm9oUDBpZWF6bUlKakpuQ0gz?=
 =?utf-8?B?Y1hiRmJxSkVmSjdHVVV0TGYyWUFSRCtJcC82NWpWTjBzNEtBaDlBcHFES0JF?=
 =?utf-8?B?UWpGMlRRWmFrVXNFSzNVNXZGZHp5UnN3WC9Yb1dMb29tamlIeWZ1OUI0UDk5?=
 =?utf-8?B?azZMeThvOHI3RU1hbDVlQ2Q3WmlyeGJDak14dFJtcXdpT0pSRmMvT2NsOUhr?=
 =?utf-8?B?SHVTcXNWN2JrQmJwT3Z6WFlCeWVSMGRvbXduV2E1VmZYOE5CWklBazZhWkNZ?=
 =?utf-8?B?SUVNQklqcWFLYXhsZGFib3k2b0FGUlZTUnZKNGpvL1hIUHcwdnp3RXROUGd5?=
 =?utf-8?B?OTM2blRpLzFUVHd0SGVLeWxmaERIOUwyQlRGbFZHYWxaSUFGaFJ1eC9XTThs?=
 =?utf-8?B?dytUUTU1SEFVMlhrNDFvcjZPRjNkWUN1Y3VOSjJ4YmtXclhHb0pCeW9MRG4v?=
 =?utf-8?B?ZWpZSUFoSERjNEYzN1hVZ3hKQ0hveUVIelM3NHpIS1Q2WlZLRVRYTTVhKytz?=
 =?utf-8?B?bjRHWUZUbjZBWEN2akluaENHOUQrVEtvY3IxdmlRRnJZOFBraVNJY3dEcU9q?=
 =?utf-8?B?NmorK0duYVcxNnVycHFpWk5qRm9YS2wvWmdLRzY2L2lvblMrWWZYMytSNFho?=
 =?utf-8?B?UjVndmVqVzNPRDN2bHByTlJEeGpvcDl4U0tveTNTdERWODJtb2kzZ1B2MkJV?=
 =?utf-8?B?dm5uQnRUWExqZ3ppdzFXdHdGS3duM29TRjhHbUtiT25GSHp5ZEZPOHBRd0Rw?=
 =?utf-8?B?ZkxxbzIxRGxIMnV0bFJ6UHRQTUtOMllNTlVabGRxU1dRN1c0WjZkT0ZQRS9Z?=
 =?utf-8?B?bkw1WEw4bXZhUW5GdnFVTXlmREo1QkhOdGtLMzdma280cFB3a1BqenhQeEsv?=
 =?utf-8?B?ai9NSHJzM2ZoaHlKUCs0WlRFZW1waTZUQlplTEFYcFp2b0JXNXBhdHpLMFVS?=
 =?utf-8?B?aUJhUERjOFg2aGpEc04yS3ZZRXFIYUlxRjZjUkR2MjRMRXRpaVdsQkRwbXRl?=
 =?utf-8?B?RWlZRkVZQnBzZUF5eFVjdUV4bHVvQVA4WjUwRktBbHFmTmkwTitRMkhLQ3NQ?=
 =?utf-8?B?Z0NTQ0ZnZjdFVG93QmZ0Tm9EOGJqWkJEYkRQUnVBcXJaeTZCQm1wMy9UV3JW?=
 =?utf-8?B?RHNzUGx0L1lTMW04bVU0YWJNaVF2QmZKcmpOWjg2OWlvR1JWdzkyUEUxWkNs?=
 =?utf-8?B?OEZCamtPZ0Ywemc2NlBFam5hTWJ5NWFyWVIwS1gwUC9CUTZlOEhDdERLdFE2?=
 =?utf-8?B?OXFvUmFHTkJmL1l1Rk96UGZlUUNoRGNnRSs3RGZzZWRPQzVTOWdjM0x6NkhU?=
 =?utf-8?B?M0JpRjBzbnYxbDQ1dUc5TFBGdGVad2RzZ2M4Vi9YMmUwS25IdEJjZzd1cWtx?=
 =?utf-8?B?SlJtV0NYdnhFNVlSVDFYeXE0UmJxTVdvazhnTEROWUJLclE1Zlp3c1hqK0l5?=
 =?utf-8?B?UEpQL2dBMDdSQXZGeE5qZXVCdXhKU2RVb0hTYjE2M3d6bkZCbVdFZmhtdlBv?=
 =?utf-8?B?TXJZS1phdVpjMEQ4eHVmU2YvRWpxYjNPeC9oYUNZR2lYUVBRcTRRRmozYWs4?=
 =?utf-8?B?M2FxTXlqcWY4NjU0RERGcXlGNWxUMEJKQmFzem04WmFCZThleThaVVJ1N216?=
 =?utf-8?B?aUFPeWxPc1NUTno3SGZXbTdnSEkyN1NwSzRpT0lUQ0FCTktIVVF0S1cyQk1Q?=
 =?utf-8?B?UmRSdHdtamFqaDRtd3ptVkJOWWVYakoxVERKS0l1V3BmRkZ2eVZQWlJORC9M?=
 =?utf-8?B?Mm1ub01VdjhLTHhJZ3dyQkk3MXA3TE9iRnB2MDZKdFNOTGp1OXVhS0Q5VXFr?=
 =?utf-8?B?akJ3YnVwR1JhZmxHYW01akFBUjdsOFplYlpidlQrZ3hQMlBBbTBaU2laOVBD?=
 =?utf-8?B?U1BTMlpvZzJPdzFkQy95eEN5MVFRTlVrMzRaWXNGNjN4RHE3UWJNaFZoeUE2?=
 =?utf-8?B?RnI2RFl5Y1NVYjNjcm9PZU4yUExyQVB4bDBvd3ZLQStxTTNFaHJ3anhmWG5o?=
 =?utf-8?Q?w+eqIxt+VNGtJzUNcEmLHsaZOLdge7sE5ygy0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a8660c-b444-4224-199f-08df438dd155
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 03:00:49.3829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3UAVTEVDLNrGAaG5Qc16k2Li18qowxfT2G89KegAaDW2mjAqjWAgKEfdhgYb75J0vglgSrWsIlI8C/PYwOH8Jj2EuuUVdCvJHnBLfwbYWFSFoMqBBXKdcmel8UFwK166
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11778

From: Peng Fan <peng.fan@nxp.com>

DMA channel devices are about to be registered on a dedicated DMA channel
bus so that they get a properly balanced bus association before
device_register().

Add that bus to iommu_buses[] so the IOMMU core installs its bus notifier
for it. This allows of_dma_configure() to probe a per-channel IOMMU and,
more importantly, lets BUS_NOTIFY_REMOVED_DEVICE release the IOMMU group
and domain when the channel device is unregistered.

The dmaengine bus is registered from a core_initcall, before any IOMMU
driver can call iommu_device_register(), which iterates iommu_buses[] and
fails if a bus has not been registered yet. Guard the entry with
CONFIG_DMA_ENGINE because the bus does not exist when the DMA engine core
is not built.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/iommu/iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b486b8bbd1fc..ab31cd15d1d5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -8,6 +8,7 @@
 
 #include <linux/amba/bus.h>
 #include <linux/device.h>
+#include <linux/dmaengine.h>
 #include <linux/kernel.h>
 #include <linux/bits.h>
 #include <linux/bug.h>
@@ -191,6 +192,9 @@ static const struct bus_type * const iommu_buses[] = {
 #ifdef CONFIG_ARM_AMBA
 	&amba_bustype,
 #endif
+#ifdef CONFIG_DMA_ENGINE
+	&dmaengine_chan_bus_type,
+#endif
 #ifdef CONFIG_FSL_MC_BUS
 	&fsl_mc_bus_type,
 #endif

-- 
2.34.1

