Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793361921;
	b=u1L1gRov2wlKmFXQzTd1aHFzpYtwk6b7T3lt6BHXGHAqmzdq1EZhb4pO2ZxkgNiXCd2E
	 x/pFMLklEU4Ywvdzl2YS1Kc5Lq2JwxxMyqCCniCiBdv/jQ4VuneTdvoORwFa/5o0jespg
	 V0IRdBwttBQ32xllKd1m19AJhYscm8vn3wRpbaDvc/KI6ZWLrui6Rr5drvXP5e8kHp158
	 bbetirornCT3BKZkVr+636lHU8zNZDMJuWm2Z5K//6Fe94axnpBx05dDssxmdO3u5dgHI
	 KPJ9lEeYJTHuaj34EFlc8cOBJRVxLiEHBipa2tu4PAHhA/BAcCNpENGMZPqai1DwXVg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361921;
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
	bh=TCMKCsdAlv7KFnzyIqhBZ6R4EoxOy8LBWr+fs16QHWQ=;
	b=Mw/9cbaCtK4eNwy99dL/eROvLMrLqJMNswr1vsrGZtQFgn1B/c1OeSRl+kz8b2Ua+f9z
	 OCSALUzaX7kjbf7obrX9FG96rrMTA85IL3YxasJcdN28k551S3qIPJB5M+l7aM5esRwNI
	 OTOHTfJUdkkLzOI2fEBugZi66XRQCjJO99wFHmq++0Dgd3ysXZucIqttAM7C0FXt5EThN
	 NXt8HDtR/uCpkIQolZCOT50r8jo2AksVezoTpYV0OMCdXVxSFNhUJzooXkFwbB35sP1uu
	 oWM+DhtURf1irofbVNwQzHGcMJ03ZEM6xwxsHLgyZkEZPUOZBgVH+15MSFD8SvuEIkw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=whr58eye;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.49
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011049.outbound.protection.outlook.com [52.101.65.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1771606A32D
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 12:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1771606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=whr58eye
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVa81SdtYJ8KYU8JNZtjljODC/3C48DqHB1cFxu+MU3LOyIB9YS1RbwwOluSd+O7XB0LB5E+jjK0YU5NRZlU77gcLUVPrIgI9LEwLKFyyVgrCEFHF8TNazqwOZWt9iK7zGxyGfYZDcjSBeYjzExpcXoHmibC4k+3Pxo1QdtPvsEoxPtICA6IuN0FAmEwHDOe5PgBeoUfGKqW1EbiiohGvfbGMBsNipul0dgs9On7dd3OCq2xGcZJ6mpX0vyT2287SY0DLwx/k0sNa7WGRkQdhCyeKLWvyRpbx5/UqYJSYFGNOY4/U0zwMUlb+kk/kwmhuHoqY1t8XV20/PBbaH5chw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCMKCsdAlv7KFnzyIqhBZ6R4EoxOy8LBWr+fs16QHWQ=;
 b=MFx5V6gp7hEQy+R1R0QffmplYOH9DQ6tIT1bxybVz6Lk8BGC1tZm9+/cGWl4Mhf3w7NyYqykvh0AsK1+5PLR2e0d/zB7lYQ2DW3Ig9C5ApPeZBbXlGdWCyA4FNaJIx0CkDWCFKPK4Fp/pc3hXdtI3eZQWBx+ZYmhGKtj4Bg4N5He+uWYrYL9VLBYegQ5Cug20QWL+AiASoA0d0rsnZrhJvp/iHVs3xagpiQhimoMJvgakqLpxr2g9b9AFXt9g4fck3V9jVE4gROULFX+9MCmNpKTtSOPrCtCpVQ09nrzvoQQrBPlawh0EM4ARmjuj3UPKV9ShabOdLw3zzsWskIKXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCMKCsdAlv7KFnzyIqhBZ6R4EoxOy8LBWr+fs16QHWQ=;
 b=whr58eyen7oCrTm+eWomBzOG3ccIUhn1anMnVPrB5Y6Mpagy+t4U7j2VSIhAAovlxBw/sgY2L/L1qcSSd0sZqVy32Vb/ldLFUoRP+ny23XTr5DP2w6pZAyWlI8fje+ykYj/r4nYWDpHiYiozEFbl1b2Gk+vHZfPuw22Qs9hpp2gfS0cLs9dnd6HY+ZUcCQcBlFSMsub7phPtAH9z/txUj6gnsynTLDqnpwEMj3Jhhdj1yTCndJwlk6+Kbx6iZYM+FuLiqQfkH+AZo49hnwM9tYDxQEQ/9JHMZqtpG2QfdFe998SS1JOTlzJXRjNAb0djUfvARStZR4Dx/FKoxIgFSw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DB9PR04MB9354.eurprd04.prod.outlook.com (2603:10a6:10:36c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 12:05:15 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 12:05:15 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 30 Oct 2026 20:09:36 +0800
Subject: [PATCH RFC v7 4/7] iommu/arm-smmu-v3: Use a per-domain CD table
 for non-PASID streams
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-smmu-shared-sid-ver7-2026-10-26-v7-4-961726ebd6ab@Example.Com>
References: <20261030-smmu-shared-sid-ver7-2026-10-26-v7-0-961726ebd6ab@Example.Com>
In-Reply-To: <20261030-smmu-shared-sid-ver7-2026-10-26-v7-0-961726ebd6ab@Example.Com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Krishna Reddy <vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
 Jean-Philippe Brucker <jpb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: SI2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:195::22) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DB9PR04MB9354:EE_
X-MS-Office365-Filtering-Correlation-Id: 061bb7f3-33ae-47f0-d0ac-08df367e0e8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|23010399003|1800799024|376014|6133799003|10067099003|22082099003|18002099003|56012099006|11063799006|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261022075727099003|261021121427099003|261022105027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	jy1aUcfAIN2XYI0xa+4vSbZuMu2otdysqUb44FtPn7Jos6RYLhtKeMHCLHr7An6K+Fc/e9J4wNF0Rs6USnyuCCl4ZFQobqH8y7xhyWSlPxUvPth+wGCjuDRA4gNGULhmXbUE2gnD7ZWkZyqa1QGkZsh0brrKXP/vo0aYQMhCFrHS0pbG8lJVeuVCS8+/Xv0ra7xksM0bzLgTO4AX3/dZrTEUoy0qzyO0o0cUzzqE131ioKTD1A0BlTCDyc6MRw1YNWZHeATUDTwiDwWIKZ5dRpHCkpS9pZDzoBkBchsT3PAA2Tw3SS62mLWUQzy2Q9VT3QLQp4fvUMXhB0XdUIq+o1u/efRegKFgP1qp3VmfQKHnsFBALZOHKXHXeGQktW6WxpH4BAnDTbMGh0C2d/vkeHn/ETbH5fs69pEAIZBByzhUXfgrsxj8Q6xnLYTzL6KlLIM2bgTueRuJC+KyoJX90YHRkfHepeQa96xr9TDd+VGkRoi0R1pOoTE9LQ9W72+/4SYWVOtXk3kWEIyXqZdmIiETvr8KvzNeePIm15GWxAPpywKLp3Jh10k2b6ON+S/NE21SF1owiS3WDPEucq0eoSc8kd1/vpmHh54//AOEN4L6m07LAOh4Tir5B0/xTmqIE1ilPEQxGY0j50hot693+PKQO34qJVldbNxzkaF7qNA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(23010399003)(1800799024)(376014)(6133799003)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261022075727099003)(261021121427099003)(261022105027099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFU5ci96OGJGZENKL1JjZEdjVzJsL21nYTR3dE42UEo1bit3b0M4RkRPRHFJ?=
 =?utf-8?B?dmF6UTNrYzVBU1ZsNEF1b05JSlJjSDB5VXV0d0V5QllBZ0FIWXJLbnpyaXl2?=
 =?utf-8?B?cVVRczFEb1ZEU2hmTTVJdTJyb2QrMEJBbTFvWU1uSHFkaFVCa05pbmRYVGha?=
 =?utf-8?B?YnRjWTczT3FCUEhKczh5NXY1QXZlbGk5bUxsYmdSRjBwRzRRRkpuRDV6cmE3?=
 =?utf-8?B?T0VqcXVPUTQ2aTNmN01MTm4xb1Iwand3NWZUZGZpaldPckJVVkQyazdFMGZn?=
 =?utf-8?B?MDA2ajlRYTlHWWpKOFlzWmd6OTJONEZ4NmFQRitYbHZzYm52U0M5dU85TjJj?=
 =?utf-8?B?QkNOWE1qUERVbldSa1ViMVNYRmZmR2g4a0xQRk9yTW1XQjc4ejBVMFAzUzJH?=
 =?utf-8?B?THFoRWpNb0NRRWFLcWJqdWtWMDZHSWtNU2luTW9UUFB2WkZERWp3YXowdjdh?=
 =?utf-8?B?bklrSHErWmF5R1NqV3NSWFhGaXkzSk5JSXljUk5icmFnUkFFdzlxSWFpTWNY?=
 =?utf-8?B?UkRiNkwzd2xUU0szb0dGSVZMOFFEQkFGTHk0VmFjOS9rQUx5NjMzMzNwaC9O?=
 =?utf-8?B?VkRPYks5NjdoeGVkdmtYOWdWVHpBOStDUk1DN0txZk1rR3pndk56czByVHQy?=
 =?utf-8?B?UjhKYzRYY3RKT2pGTUZIOFMyUk9sNGtDNE8wdWphNmpnanJnK2UrbnV3eEd4?=
 =?utf-8?B?OHJQaktGWXJFSFRrMUY2SG1xOVJ1MC93UUE0dlcrdXdGVitPOWNFTHlQN0JJ?=
 =?utf-8?B?RmtXUFBMZlJxcGVHa1BjNVBBd3d4T0h6YnFwZ3FWbzhHTGZXWW96eUNjVDlW?=
 =?utf-8?B?M012di9iZjdLVFlMVTFqM2xUdzVmamZqczF4cDJpYjcvRWdXaDhjRjRuR09y?=
 =?utf-8?B?YVhWTS9Ldkt3R3FCekVzdWJTYk9VM1lDSGU5WFFiUVZtUmhnNmJSblRQdEor?=
 =?utf-8?B?b0N5ZmxlUVV1bnJRdkhwTHVNS2pVVVN2VldUM1V4NEo5Mk5lZ0JMVXhDNjgw?=
 =?utf-8?B?QTN2TnJXNXdCMVBVTnNlek5NdklrN3gzOE8wcGsxOGNKQ2ExelZDakc3QmZS?=
 =?utf-8?B?Yk8wT3M4Qjl3S20xR1pLMGhYZHZLTTYyR3haSUU5N25BRmpGTTNSamd6djRS?=
 =?utf-8?B?alNqaXpPZG9VNEN1N213dS9YSDJrWUc4RkpFczZXWXVsY0ZDaFh3citzcmty?=
 =?utf-8?B?UVZFRUVuUHQvbUJVWXdhR1dOSXUwcmd2bGduMmtza3g5RmlHY3dQN0dRRFRi?=
 =?utf-8?B?NXl5WFdldVdzNXJHdGVrSi81dFdLWW1XYk51NURnK1Nib3dPMnRWcWpBWG1Y?=
 =?utf-8?B?a3dwZmYzVWxlT2NBTUFnOGZoc0E5VElJV1RHcWkyVEVwOGZsTmpjTXFRbmRC?=
 =?utf-8?B?MnBCK2dWUU9kcEtDNGRKaWhDTXlvekYwTW00K2xsazRwNFBDaEplZTN5R1hn?=
 =?utf-8?B?TXVGbjFSTzY3Yk9GZ3c1OG9QaXE4b3ZQZ3lLTEQrQWVIeTNjbzdhVUhHSDNG?=
 =?utf-8?B?QzFEbHVYVjMyc1BvVzcrLzcyKzNmLzVrbTAwUDc2UUoyMlN0TkkzL1JTWnZi?=
 =?utf-8?B?L1NEN2p6SjNqdFZrcDkwcDVPWCt0TEhqaXZtak5ydUY3SGNwOXhpeHh4VFlF?=
 =?utf-8?B?MjVSZ1RRWGpYd1NVRTRuREY3cDU0UStUa2ZwRVIxc0QvVm13RGlnVVovUFg0?=
 =?utf-8?B?MkRWQzN6UWl4aWhIUjNlQ3pTc1hSODY3OG4vYVNwTXZxNW1INWRSZ2NFTG5U?=
 =?utf-8?B?LzJGSEpBR04yRmxSUEtYUmVMVkNZazJhZHI4U1RvTUdIZHBxSTVQTXlFSTlQ?=
 =?utf-8?B?SFg5MlFpR29qVnZPSFEwOHE0QXcxNGM5eXV6VkdFTlRTd0FHcWlMM2llZ0pq?=
 =?utf-8?B?ZVNyNkJ5TEVpM1RTdmx5cUxZMXhUZ2U2RHBick43TkwzRjJybmMvZ1JOSHpt?=
 =?utf-8?B?MkVhNWVhRjVMUlU3b1VuUFVpQkVObmZZdFFGOUZ4UDhReUdaQlFKUytNZ2xp?=
 =?utf-8?B?RkwxclFpTzg4Z20ySGZFOFJUVUJZQW40TFIrRFpYcHZIWmZQamR0YlJnUkpO?=
 =?utf-8?B?WmJjMzJ3dmpHeGpnZlhPMG9JVHlxbkYwTmE3VnNxa3ZsaHUwTWxLcUg1cmox?=
 =?utf-8?B?UWxoT2hyODRoOTE5NUkrQjJjMm1tTlNFV243RzJad0dNMDh4WjZkMGZOd1lB?=
 =?utf-8?B?ejVQbWFXbzFRUzJ6cWVpSkFOeUEzb2Z6SldJVk1MS0p2Q0FTOG4xUkhJbnhR?=
 =?utf-8?B?Z0l3Z2RteFB3RDV2blpxYStESGlXNXp6bWlTdHFqcm1IQjMyTlJNTWFYOHI2?=
 =?utf-8?B?RGdzUWFaek8zUUFSN3NFOGNQb2R2WWFxUEFTV0NWQWpZYUhlUXdxMnppek8v?=
 =?utf-8?Q?/SE6MR5ab7CuFdTmdoWBjewKvK4C3ZfkCfFir?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 061bb7f3-33ae-47f0-d0ac-08df367e0e8e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 12:05:15.2805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jqetFhVgN/HYwrTrfWN5ngD8lTH2m5tJp9bfEpog+5w4ywYVAlsvxsNoR3reyhXIEcQ7BtvZziMvFJvj0w8bpnpv+rr30fAfU6Dfzs2fkIHcTMamGgvsL2EnxSGiGs4E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9354

From: Peng Fan <peng.fan@nxp.com>

The CD describes the domain context, so non-PASID devices attached to the
same S1 domain do not need private copies of it. Store a CD table in
struct arm_smmu_domain and make non-PASID streams point their STE at that
table.

The per-master CD table is now used when a device needs substreams (PASID),
for ats_always_on devices which need a CD table to use S1DSS, or when the
device uses the stall model. On the first PASID attach, seed the private
table's default substream from the RID domain and switch the STE to the
private table; after the last PASID detaches, switch the STE back to the
domain table (or the native bypass/abort STE). The private table is
retained for reuse and freed at device release.

CD.S is a property of the CD and must agree with STE.S1STALLD. On an SMMU
with STALL_MODEL==0b00, CD.S=1 together with STE.S1STALLD=1 is an illegal
CD and the SMMU aborts the stream. A shared domain CD therefore cannot
serve both stalling and terminating devices. Keep stall-enabled devices on
their private CD table, where CD.S can be set for them, while terminating
devices continue to share the domain table with CD.S=0.

Prepare for devices sharing a StreamID to naturally build the same
S1ContextPtr for the same domain, instead of depending on the stream
owner's private CD table.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 147 +++++++++++++++++++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   8 ++
 2 files changed, 129 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 51de3a0b8e76b..510c9028fa19f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1832,6 +1832,17 @@ static void arm_smmu_free_master_cd_tables(struct arm_smmu_master *master)
 	arm_smmu_free_cd_tables(master->smmu, &master->cd_table);
 }
 
+static int arm_smmu_alloc_domain_cd_tables(struct arm_smmu_domain *smmu_domain)
+{
+	return arm_smmu_alloc_cd_tables(smmu_domain->smmu,
+					&smmu_domain->cd_table, 0, false);
+}
+
+static void arm_smmu_free_domain_cd_tables(struct arm_smmu_domain *smmu_domain)
+{
+	arm_smmu_free_cd_tables(smmu_domain->smmu, &smmu_domain->cd_table);
+}
+
 /* Stream table manipulation functions */
 static void arm_smmu_write_strtab_l1_desc(struct arm_smmu_strtab_l1 *dst,
 					  dma_addr_t l2ptr_dma)
@@ -3044,6 +3055,9 @@ static void arm_smmu_domain_free_paging(struct iommu_domain *domain)
 		mutex_lock(&arm_smmu_asid_lock);
 		xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
 		mutex_unlock(&arm_smmu_asid_lock);
+
+		if (arm_smmu_cdtab_allocated(&smmu_domain->cd_table))
+			arm_smmu_free_domain_cd_tables(smmu_domain);
 	} else {
 		struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
 		if (cfg->vmid)
@@ -3135,6 +3149,15 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
 	if (!pgtbl_ops)
 		return -ENOMEM;
 
+	smmu_domain->smmu = smmu;
+	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
+		ret = arm_smmu_alloc_domain_cd_tables(smmu_domain);
+		if (ret) {
+			free_io_pgtable_ops(pgtbl_ops);
+			return ret;
+		}
+	}
+
 	smmu_domain->domain.pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
 	smmu_domain->tgsz_lg2 = __ffs(pgtbl_cfg.pgsize_bitmap);
 	smmu_domain->domain.geometry.aperture_end = (1UL << pgtbl_cfg.ias) - 1;
@@ -3144,12 +3167,13 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
 
 	ret = finalise_stage_fn(smmu, smmu_domain);
 	if (ret < 0) {
+		if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1)
+			arm_smmu_free_domain_cd_tables(smmu_domain);
 		free_io_pgtable_ops(pgtbl_ops);
 		return ret;
 	}
 
 	smmu_domain->pgtbl_ops = pgtbl_ops;
-	smmu_domain->smmu = smmu;
 	return 0;
 }
 
@@ -3842,6 +3866,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev,
 		.ssid = IOMMU_NO_PASID,
 	};
 	struct arm_smmu_master *master;
+	struct arm_smmu_ctx_desc_cfg *cd_table = NULL;
 	struct arm_smmu_cd *cdptr;
 
 	if (!fwspec)
@@ -3854,11 +3879,27 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev,
 		return -EINVAL;
 
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		cdptr = arm_smmu_alloc_cd_ptr(master, IOMMU_NO_PASID);
+		/*
+		 * Non-PASID devices use the domain's shared CD table. The
+		 * private table is needed for substreams (PASID), for
+		 * ATS-always-on (S1DSS), and for the stall model: CD.S is a
+		 * per-CD property and cannot be shared by devices that
+		 * terminate faults.
+		 */
+		if (master->ats_always_on ||
+		    master->stall_enabled ||
+		    arm_smmu_ssids_in_use(&master->cd_table)) {
+			cd_table = &master->cd_table;
+			cdptr = arm_smmu_alloc_cd_ptr(master, IOMMU_NO_PASID);
+		} else {
+			cd_table = &smmu_domain->cd_table;
+			cdptr = arm_smmu_get_cd_ptr_in(cd_table, IOMMU_NO_PASID);
+		}
 		if (!cdptr)
 			return -ENOMEM;
-	} else if (arm_smmu_ssids_in_use(&master->cd_table))
+	} else if (arm_smmu_ssids_in_use(&master->cd_table)) {
 		return -EBUSY;
+	}
 
 	/*
 	 * Prevent arm_smmu_share_asid() from trying to change the ASID
@@ -3881,7 +3922,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev,
 		arm_smmu_make_s1_cd(&target_cd, master, smmu_domain);
 		arm_smmu_write_cd_entry(master, IOMMU_NO_PASID, cdptr,
 					&target_cd);
-		arm_smmu_make_cdtable_ste(&target, master, &master->cd_table,
+		arm_smmu_make_cdtable_ste(&target, master, cd_table,
 					  state.ats_enabled,
 					  STRTAB_STE_1_S1DSS_SSID0);
 		arm_smmu_install_ste_for_dev(master, &target);
@@ -3932,22 +3973,24 @@ static void arm_smmu_update_ste(struct arm_smmu_master *master,
 				struct iommu_domain *sid_domain,
 				bool ats_enabled)
 {
-	unsigned int s1dss = STRTAB_STE_1_S1DSS_TERMINATE;
+	unsigned int s1dss;
 	struct arm_smmu_ste ste;
 
-	if (master->cd_table.in_ste && master->ste_ats_enabled == ats_enabled)
-		return;
-
 	if (sid_domain->type == IOMMU_DOMAIN_IDENTITY)
 		s1dss = STRTAB_STE_1_S1DSS_BYPASS;
-	else
-		WARN_ON(sid_domain->type != IOMMU_DOMAIN_BLOCKED);
+	else if (sid_domain->type == IOMMU_DOMAIN_BLOCKED)
+		s1dss = STRTAB_STE_1_S1DSS_TERMINATE;
+	else if (sid_domain->type & __IOMMU_DOMAIN_PAGING)
+		s1dss = STRTAB_STE_1_S1DSS_SSID0;
+	else {
+		WARN_ON(1);
+		return;
+	}
 
 	/*
-	 * Change the STE into a cdtable one with SID IDENTITY/BLOCKED behavior
-	 * using s1dss if necessary. If the cd_table is already installed then
-	 * the S1DSS is correct and this will just update the EATS. Otherwise it
-	 * installs the entire thing. This will be hitless.
+	 * The PASID entries live in the private per-master CD table, so make
+	 * sure the STE points there even when the RID domain was previously
+	 * using the domain's shared CD table.
 	 */
 	arm_smmu_make_cdtable_ste(&ste, master, &master->cd_table, ats_enabled,
 				  s1dss);
@@ -3965,7 +4008,8 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
 		.ssid = pasid,
 		.old_domain = old,
 	};
-	struct arm_smmu_cd *cdptr;
+	struct arm_smmu_cd *cdptr, *cd0ptr = NULL;
+	bool first;
 	int ret;
 
 	/* The core code validates pasid */
@@ -3978,10 +4022,17 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
 	    sid_domain->type != IOMMU_DOMAIN_BLOCKED)
 		return -EINVAL;
 
+	first = !arm_smmu_ssids_in_use(&master->cd_table);
 	cdptr = arm_smmu_alloc_cd_ptr(master, pasid);
 	if (!cdptr)
 		return -ENOMEM;
 
+	if (first) {
+		cd0ptr = arm_smmu_alloc_cd_ptr(master, IOMMU_NO_PASID);
+		if (!cd0ptr)
+			return -ENOMEM;
+	}
+
 	mutex_lock(&arm_smmu_asid_lock);
 	ret = arm_smmu_attach_prepare(&state, &smmu_domain->domain);
 	if (ret) {
@@ -3997,8 +4048,39 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
 	cd->data[0] |= cpu_to_le64(
 		FIELD_PREP(CTXDESC_CD_0_ASID, smmu_domain->cd.asid));
 
+	/*
+	 * The private CD table is taking over the STE now. Make sure its
+	 * default substream matches the RID domain before the STE points at
+	 * it, since non-PASID traffic follows CD[0].
+	 */
+	if (first) {
+		if ((sid_domain->type & __IOMMU_DOMAIN_PAGING) &&
+		    to_smmu_domain(sid_domain)->stage == ARM_SMMU_DOMAIN_S1) {
+			struct arm_smmu_cd cd0;
+
+			arm_smmu_make_s1_cd(&cd0, master,
+					    to_smmu_domain(sid_domain));
+			arm_smmu_write_cd_entry(master, IOMMU_NO_PASID,
+						cd0ptr, &cd0);
+		} else if (sid_domain->type == IOMMU_DOMAIN_IDENTITY ||
+			   sid_domain->type == IOMMU_DOMAIN_BLOCKED) {
+			arm_smmu_clear_cd(master, IOMMU_NO_PASID);
+		} else {
+			WARN_ON(1);
+		}
+	}
+
 	arm_smmu_write_cd_entry(master, pasid, cdptr, cd);
-	arm_smmu_update_ste(master, sid_domain, state.ats_enabled);
+
+	/*
+	 * A repeat PASID attach leaves the STE on the private table with the
+	 * same S1DSS/EATS. Only the first attach (or an ATS change) needs to
+	 * rewrite it; arm_smmu_write_ste() would otherwise issue a redundant
+	 * CMD_PREFETCH_CFG for every stream.
+	 */
+	if (first || !master->cd_table.in_ste ||
+	    master->ste_ats_enabled != state.ats_enabled)
+		arm_smmu_update_ste(master, sid_domain, state.ats_enabled);
 
 	arm_smmu_attach_commit(&state);
 	mutex_unlock(&arm_smmu_asid_lock);
@@ -4017,35 +4099,48 @@ static int arm_smmu_blocking_set_dev_pasid(struct iommu_domain *new_domain,
 		.old_domain = old_domain,
 		.ssid = pasid,
 	};
+	int ret = 0;
 
 	mutex_lock(&arm_smmu_asid_lock);
 	arm_smmu_attach_prepare_invs(&state, NULL);
+	/*
+	 * Unlink the PASID from the domain before invalidating its CD.
+	 * arm_smmu_mm_release() walks this list with only devices_lock held
+	 * and writes a valid, faulting CD; unlinking first prevents it from
+	 * resurrecting used_ssids after the last PASID is detached.
+	 */
+	state.old_master_domain = arm_smmu_remove_master_domain(
+		master, &smmu_domain->domain, pasid);
 	arm_smmu_clear_cd(master, pasid);
 	if (master->ats_enabled)
 		arm_smmu_atc_inv_master(master, pasid);
-	state.old_master_domain = arm_smmu_remove_master_domain(
-		master, &smmu_domain->domain, pasid);
 	arm_smmu_install_old_domain_invs(&state);
 	mutex_unlock(&arm_smmu_asid_lock);
 	arm_smmu_attach_release(&state);
 
 	/*
-	 * When the last user of the CD table goes away downgrade the STE back
-	 * to a non-cd_table one, by re-attaching its sid_domain.
+	 * When the last user of the CD table goes away, switch the STE back to
+	 * the domain's shared CD table (S1) or to the native bypass/abort STE
+	 * (identity/blocked), by re-attaching its sid_domain. The private CD
+	 * table is kept allocated for reuse and freed when the device goes
+	 * away.
 	 */
 	if (!arm_smmu_ssids_in_use(&master->cd_table)) {
 		struct iommu_domain *sid_domain =
 			iommu_driver_get_domain_for_dev(master->dev);
 		bool ats_always_on = master->ats_always_on &&
 				     sid_domain->type != IOMMU_DOMAIN_BLOCKED;
-		bool downgrade = sid_domain->type == IOMMU_DOMAIN_IDENTITY ||
-				 sid_domain->type == IOMMU_DOMAIN_BLOCKED;
+		bool s1 = (sid_domain->type & __IOMMU_DOMAIN_PAGING) &&
+			  to_smmu_domain(sid_domain)->stage ==
+				  ARM_SMMU_DOMAIN_S1;
 
-		if (!ats_always_on && downgrade)
-			sid_domain->ops->attach_dev(sid_domain, dev,
-						    sid_domain);
+		if (!ats_always_on &&
+		    (s1 || sid_domain->type == IOMMU_DOMAIN_IDENTITY ||
+		     sid_domain->type == IOMMU_DOMAIN_BLOCKED))
+			ret = sid_domain->ops->attach_dev(sid_domain, dev,
+							  sid_domain);
 	}
-	return 0;
+	return ret;
 }
 
 static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 0256119e9c137..a45a5a1580e0c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -879,6 +879,7 @@ struct arm_smmu_ctx_desc_cfg {
 	};
 	dma_addr_t			cdtab_dma;
 	unsigned int			used_ssids;
+	/* The STE is S1 translate; it may point at a domain or private table */
 	u8				in_ste;
 	u8				s1fmt;
 	/* log2 of the maximum number of CDs supported by this table */
@@ -1091,6 +1092,13 @@ struct arm_smmu_domain {
 		struct arm_smmu_s2_cfg		s2_cfg;
 	};
 
+	/*
+	 * CD table shared by all non-PASID devices attached to this S1
+	 * domain. A master uses a private table only when it needs
+	 * substreams (PASID) or ATS-always-on/S1DSS.
+	 */
+	struct arm_smmu_ctx_desc_cfg	cd_table;
+
 	struct iommu_domain		domain;
 
 	struct arm_smmu_invs __rcu	*invs;

-- 
2.34.1

