Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794469712;
	b=eH/ty12KhUcA6atpn1qGvtlNOfTjFyxHLPcILScCO+RbQJc4tU626t7keYXEhYExIics
	 eTnTACGjU1Z5gNAFKwKIfeVHgHLQeDQm+Fnc4qqmfjTfneAc205/BuE2KAefArh6NzYJQ
	 /1RsqpxA8CAInKhJRd+g10uMbWRS/crCfdNXgxGBJTs8RzKAAo5SXA1DvQApQ1zgaAEb0
	 1v2Nv83BsfAEoNDl3RquVrtzilEpawfMrQoERSuCU7UXVTNAsKQxbI4ZFuH0drdtlQL/X
	 I4xcLGhCgsc2VeeL/LsSaYjrpXC9oRFw48J3D/jHKijQ1rJ+2pt7LF+BEzL8enpe/cw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794469712;
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
	bh=Ae6bwlTuudYGERs98XWGPQb4qytT4DEwkhzrvMre408=;
	b=tavFsrDNAIdmga+PcYT0Yk9+RGxta3GfWZhSTOL1tEbzQ8VRXjJbJdksb4Zu1Na3iKNu
	 DWS7NThcNqGgMq2KRhLVq2Safl1udAK2EIqukCPxqhNs3eki5ql7rTiU/n1rgk6VvJl0c
	 +mzA0IUcDn4V8ksM9i+ZclvmPqehagiS5bRmaVPC5gBbvl4IvgHMhtvvjADdSZNHDIaVt
	 GZZorl8C+o8mJG/Af8OJOfECFmdTjPwagFLObeDWf/nrSZ/eSXMzJVjp26aAuj/RAin3u
	 DE7+B/yOv32J/b3+F/cAwSGfZW2iYlh9i20m8SIlZUHDxsFpha14GYWjLIZmpHtfVsg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=nQJtZVxU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.61
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011061.outbound.protection.outlook.com [52.101.65.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A420A606A335;
	Thu, 12 Nov 2026 07:48:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A420A606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=nQJtZVxU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dh4CSC4imgT1H1vCF8OMeLmd5yW9HALyYMOYLUZqvDeAEfKAr5f2pD5gwG3yuQjg4l/g4eeevSMNvQ12GARNsDNYlr+8yg/WDt9DQPlPWvPV5UVY9pXpWdX0+X9SCHrejdfWacW/c1Odol0roIwq1GneXyLWdJvutouUymmKwNOzywqpV3rnUTNi0pyWOY6V1nusWjrKuhWQ/fvgOrmwFUEdV9z8/WMtVfbu66EfSGGBa6jlvpLwr3ebgyVJuT4N5qhbRFVoBtadoNz88mFKFAIoZhYnyeL7o+JDp8WV5KWvWZZACH3WJzrqN594QskTEy/ovjSfyMi8mxzZNzxNEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ae6bwlTuudYGERs98XWGPQb4qytT4DEwkhzrvMre408=;
 b=lX8LzJpCst7xADQSa2+auR734npHSi/WdJ+LujsNmsJk0Ana4lJ4wwNfAnH9/BMTpN+IcyE6k1GwrFJd+wBtAO5pfuuXDJFCagDYcYzfK+vfXK/1IQ2fsc//lSguWnNJXXdyki0V89vVuxq0sZwbOiQmttXR0thNcFqtcG3svM9DLQIR5JouQK12uYKHCxSM983In9FV6/1Dw5rmdSzAwUMfOchDYbgv0OhY4TXclqfByjh0YxWBiJweo66t2JrtSaFu2t3ZS0IXu4ayFsTpIb+om40Ehmq+nHZvTrKocmxMUfXYYQDQMYRqyZTZem0T+/1TisAA9a+sgIZadY1UIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ae6bwlTuudYGERs98XWGPQb4qytT4DEwkhzrvMre408=;
 b=nQJtZVxU1GZ3fum+kgStyQMbsK3VClueCRJgXN2CK2bLXMx+5RRq0JI6WfyhftKo6qU0DZgS9KfCjNv18MxnHqVgPCKMIldGWuBgA3X5hgUECrNTo6T9B0d9ppTnFgUqvpGKQEViukzcVrTE80i2I201w4aVWzTXhFyl37w65/TqG4uDd6CUOoPeL14JA2kZAhB4UMYXex+WtMR7QFjvEDwNQmSdMocM7mTs2GSc4V3yVQjPDeaVYhEfnaVzRBe+yauqkJR4jGlKh4R+LqKCi+1AOyiDfOs0+RTSQYmQKF4Jt3yWHnsV2NyGF6zZYR2s1B3a9owvSGCUOiKj/tFNyg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAXPR04MB8909.eurprd04.prod.outlook.com (2603:10a6:102:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 12 Nov
 2026 07:48:27 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 07:48:27 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 12 Nov 2026 15:53:04 +0800
Subject: [PATCH v6 1/9] dmaengine: fsl-edma: unregister channels before
 vchan cleanup
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-edma-iommu-v3-v6-1-b038edb8ce6f@nxp.com>
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
X-ClientProxiedBy: MA5P287CA0049.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::12) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 015a4560-1c13-4418-0800-08df40915654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|23010399003|376014|7416014|366016|260925022911599003|261026140227099003|921020|260925021911599003|261028144727099003|260925021311599003|261102123227099003|11063799006|56012099006|261021123027099003|261022105027099003|261021121427099003|261009223027099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	raAWoWQjLc94P4Et0Fv1DJO5tJiSuWVSQ5Jbsh3NX1y5skzn9zbQS8ImocP4Ta0bzeFZcZkK63FgJPrcS2UJ/8RFLmLzvW+Kz8i9G13SXFDQFUg3HtxsKCgRlifohwTCBgjRrdUXoFh/Y2Y758JOqQ/IZWLj2bInbKNtgAj1tQQjJVdeSYUwjZLG9KRxQMb2vMNDGxA7tALNlU3TnvH8rbBDVnrEuZ0MHVPUl80wIn3Mu0QKyJBJtDPfw42lIDBeSTY8Zo0syJlS53cYUecgrDeoG5uTkcHNZoRUEaaUR8eSCFiUQOTd6284tbCQj80rverM9l32nQBTWgWg+S2nz4YWLqY/ut/ZxE0RDFPo86pIGq9aYGjCVHKOTmfR5VL+J8TgByp4L9hOT93YAD6IcjDMVNOHSDH9a7KlRgBjHGcjFhGojJh1mDYtfk6jZf7INaqrTDBAXZ3/gUmkhowuD3BKFqDs4alnFbpW3BBuaDWiEF+liCQJdVivLlgDUGYwUCV84Nf18xZDfvbLHWLw2j9Je6fUzWBoHaUKZa9zY9fcn66veMhEnsJpA8Vaga9bbWwqpES/YkgHUZkvUeragObOxAWYZHySg3QCqYmHhB3ZtgA8aUtpgqxSuvB/Ikaq4eteKk2B05kap1dOLXRJ3PbDcQID+wq9fBo5orkJSHXRCqmAFT1JktpKpBAFI5AV23t9qXrAyOztZSJGK3TB8w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(23010399003)(376014)(7416014)(366016)(260925022911599003)(261026140227099003)(921020)(260925021911599003)(261028144727099003)(260925021311599003)(261102123227099003)(11063799006)(56012099006)(261021123027099003)(261022105027099003)(261021121427099003)(261009223027099003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnFGZFpMYkF6L2pZTnE3RjRRekt4Y1FQcE1MTXIwUjZzMHI1N0J3RUZuYzE2?=
 =?utf-8?B?Tzh3NTc2NWNJdldNTGZjZy9JRllRVTRhQVRlSG1GWHc4ZXFlMk5CZGo5bzBU?=
 =?utf-8?B?cVFLTmYyTmlHN09tazRDbUZrenJwU3VSTjZkZlNDQkduQm9xVWJoeVVRRU1a?=
 =?utf-8?B?QWVqaERFeFZaVVhtMGFrTFNFWXJrYXl4d2t1L21JMlJBZVJTZzJxbGRBNnF2?=
 =?utf-8?B?c0xhMWJFaERrM2tPb0dnY1R2MDlUVDRzZG1lVlg5aEp6TnJUYkpTUXUwdUV2?=
 =?utf-8?B?dU12UC81Q1FYSGhWMkMwMGw3SGZ5d05pS1pqOVZMdU04V0c0TGVJRnY0THk4?=
 =?utf-8?B?VWdDNFN1d2pDdGxFZDRTUkpTaTRIVUMrdzVaZGlhK2wrYlJ4VGswWlB6TWJB?=
 =?utf-8?B?RFN3bWdyUXVYdkxIMlRIYzdCckFsYWFucS9kU1M4TnFYOTJaVks1eVRKaVp1?=
 =?utf-8?B?VUJBZlErTldDcDRTeHMxbE4wZVBPM2NKS3orYTcrQTZraEdUZDcrUW1paFZm?=
 =?utf-8?B?SHpLTkN1MkxBcUQ2emlpV0w2Y1oyQVhEZWpweThxN0lzZU9HSHYwY1pYVmY5?=
 =?utf-8?B?c080MHB3aWZkZEVseFYyRlFNNVNuZ1NiZ3lCdGZuMCszWVFkWk8zL1c3dHlD?=
 =?utf-8?B?ZmE3YUwvMEFCcTAveDZDWDdoY0hFNkFxOGNrVUZjY0dmWnpJNSsxM2R0a1d0?=
 =?utf-8?B?Z21MU0JSRTlib2dtc3k5NkNUWVJxSzhPOEN4NmZxOHZFQnhIbHlXNytJQ0VR?=
 =?utf-8?B?cFVMTnMxT1VTZkRBM1kyQUVjZ1g3amxPZHNJR01lRDFzQko0eVA0VjQxTXFI?=
 =?utf-8?B?cTNSVTNOeDlYM1ZXeTNEdGZocnR2TkcvKyt1WFRhcm8zZHlFamVwUUIzSFhs?=
 =?utf-8?B?S01jN3J5eEZTUk05eHIzVHpTK0IyMTBCRDVpLzB1eEsxZXJ2UFZjSHFSMjBn?=
 =?utf-8?B?SUF1elVMejJaRDNyVkcxSlVGK3lsNDRZQktwd1lycUw4WnFVTFVONEY0L3VV?=
 =?utf-8?B?Ymc4dm9XbWh6c0VqWFBKV3M3OG1tMFk0SkVWV0Rybm9ReHRSUHlrUjZlRXFB?=
 =?utf-8?B?S1NQMy9aN1hHdGFPMmwxUVN1T05FbmZPb0crbkVPa00wSHUzazA1VTFYQ0Ir?=
 =?utf-8?B?MUlHa0RrN2xQL2pvSEMrQzV5UzhCZHlqTFI1RFNJamZzdVYrQkVKZ01pbXZk?=
 =?utf-8?B?cXZDZm5kOFIrbXdVTHo4T001UUFMOFRzMVBGekdPRzBlN3d3VXdxQTYwTHJ3?=
 =?utf-8?B?d0VISU9zYTk5cEI2K1E0RDcvOEdRcHJyUkpzL09BVUJBZzQ2MnNOVk8rNDdX?=
 =?utf-8?B?cVpPcmI3SkFQc1pBc25LTkgxTUNkMXhCTnRrTkhraFJXN3hwNGFlMXVYNTFF?=
 =?utf-8?B?bDRoa3d5cWlxTjZ4UDRybE1icWhQY3dzd25aVTVCL05MUHNYbjFJUHMrYW5x?=
 =?utf-8?B?dGo1d3MrYnVkTXArMVFEV2t6a1hXekg2cmdBekhGbnA1eFVoWXRNVEJaT0Fw?=
 =?utf-8?B?UGxYR1cxR1RxMUQySjBxTGx4anFRTlptejJLeHVVMVZWbkgzb0ttdVRVV3lp?=
 =?utf-8?B?bW5rK2xnZVF0NzUzS1phb3l3WEtCREk3NVhKS3ZnT2FoeXhSaUFxWTlDazVm?=
 =?utf-8?B?aE9VTzVJTmR1M0NvNE1HMU5ZZUh0OG90YTk3bnZOb1pOenppVGo3T0FQYjRz?=
 =?utf-8?B?dHp5MmtTZ0ZrWUQzdlQzTGRaY3N3a3pBR1UzU3pTdkRDenF1MWJCZzBNNEl4?=
 =?utf-8?B?N2oyNzZLMEkydUhXUEx4YWJRYTJYQkpjWDZaeUZrc2IwNXd1U005SWpOeUw2?=
 =?utf-8?B?YkdFdkRheVgydUI0VzMzZGRRa1FSTWRyb3lRamtVb1FxRGdhYmpKa3BtYVM0?=
 =?utf-8?B?dHFGaTUzZ2h3YVRvYmNIaEhRTEF5V0FZTkJMTVVhWXhZclc4MXpFaE5tMzBS?=
 =?utf-8?B?cjk3S3JMVDRxbUV2ZzJ6UWcvamRMdnM4REYrU0RVOXZ4MkhYdzNBb01kQit2?=
 =?utf-8?B?Y2MyZE9idGRUSVVxTEhnNjBPVkVKYWZoVS9OUVE5anR1VmFDWmZBelZ6MWMy?=
 =?utf-8?B?NVFRQy9jNkViaGtxWkhJbS9EZWV5NE9FcE9pOG5scmgvR0ZHVzd5SFBWaGJK?=
 =?utf-8?B?M2lpc0gzOWpOamVPemJqUkVTeFlIeGJFOEtBMDA3T2Y3b296QlRkUFlReSsy?=
 =?utf-8?B?TVRXZXoxdkdHMnhEUnVDU3JqVisycE1YM0hMa1ZOdGRsc0IyNFdUZkJvdXZ2?=
 =?utf-8?B?SnJiNy9Dby90RUVSd01xNHp2bjFNYjl5bVJaOVJYS3NqczFVOWVicktjYzdH?=
 =?utf-8?B?cnJ1QmMzTUd5Z3F6KzJIQVpQVFdDOVMxa0lSbFFVMmU4eG5wV1FJMlRkbU1W?=
 =?utf-8?Q?7iAUCmTVJacJ8qeWPOyr57LpNTfwlpLaoLNov?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 015a4560-1c13-4418-0800-08df40915654
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 07:48:27.4490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KkFIneCdLRn3EcuFgb6wtJUA1YRuuCGzCL8uqE6oqLtQFW9J2Lags+NP87teYgX8P6Y3OJXfM/jGJ+W4n/ckK7FHdFYd+8O4bbrdUBWkUkR+iQKnnv2gGWD1LzhkSBM/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8909

From: Peng Fan <peng.fan@nxp.com>

Since commit 4035726a6b72 ("dmaengine: fsl-edma: Use managed API
dmaenginem_async_device_register()"), dma_async_device_unregister() runs
as a devres action after fsl_edma_remove(). However, fsl_edma_remove()
still calls fsl_edma_cleanup_vchan() first, which removes every channel
from dma_dev.channels.  When the devres action later runs,
dma_async_device_unregister() sees an empty channel list and never
unregisters the channel devices. They remain visible in /sys/class/dma.

Keep the vchan cleanup, but register it as a devres action before
dmaenginem_async_device_register(). Devres actions run in reverse
order, so the DMA channels are unregistered first and the vchan list is
cleaned up afterwards. Remove the premature cleanup call from
fsl_edma_remove().

Fixes: 4035726a6b72 ("dmaengine: fsl-edma: Use managed API dmaenginem_async_device_register()")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/dma/fsl-edma-main.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index da5139911488..7f82dcb7831d 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -31,6 +31,11 @@ static void fsl_edma_synchronize(struct dma_chan *chan)
 	vchan_synchronize(&fsl_chan->vchan);
 }
 
+static void fsl_edma_cleanup_vchan_action(void *data)
+{
+	fsl_edma_cleanup_vchan(data);
+}
+
 static irqreturn_t fsl_edma_tx_handler(int irq, void *dev_id)
 {
 	struct fsl_edma_engine *fsl_edma = dev_id;
@@ -881,6 +886,12 @@ static int fsl_edma_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, fsl_edma);
 
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       fsl_edma_cleanup_vchan_action,
+				       &fsl_edma->dma_dev);
+	if (ret)
+		return ret;
+
 	ret = dmaenginem_async_device_register(&fsl_edma->dma_dev);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret,
@@ -905,7 +916,6 @@ static void fsl_edma_remove(struct platform_device *pdev)
 	struct fsl_edma_engine *fsl_edma = platform_get_drvdata(pdev);
 
 	fsl_edma_irq_exit(pdev, fsl_edma);
-	fsl_edma_cleanup_vchan(&fsl_edma->dma_dev);
 }
 
 static int fsl_edma_suspend_late(struct device *dev)

-- 
2.34.1

