Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793601954;
	b=xwyciWCt/aG0+trMwqvsuyyUVeEIiBdLIWrkVOsbWpgPkZVPyE4tskz2YZVYtSOSFE4F
	 Cu43zMGefluTjGPIj7ziTKJH+s8exOrxlz31E1nSSsIHGNtMk4vGnK8kyftv5NRAwuH2S
	 Abx+NM9xgE49Z7oiG52vjMn952ATddMK/zGCYHYFU3Cru3qVGf6xfG9lsfIRZU80S3jjM
	 N1GobvWH3rUxSy57me30NmRF5Vhs8jlkUMVXZZS7Qzh3CWNbRJDwiF9R4ZTYs4ruB67qq
	 +v7lZ/iCB4gP59OgZ24gxG2h0OowV46BQqJvbM7Rm27GGnXJY9aeSpKPQa7Zy2lJGVw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793601954;
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
	bh=u7ICfDda+vVzXp4Htf+adcHe8YaziXOA3JRZTByOS5I=;
	b=VR0njK4p16h0Sx7Qd38CUuH/fcCyISEb/XUz5BjoEpvUfT9GOBIiS3Osb0XodG4hJP5U
	 UclSGiskdez1QeJmI5HLOBmDprOnkZ0pF/KqXqhIofTf+rjpED19UGUxhgTCfyGoO7xE1
	 J2ecYO2BfsYP2HmXdt3CbhLC7kWh+qChIXVIyqrKqsiw7Vb90+ldOCU5o7YKT7Wam02Ix
	 UASZPLUDa0v8XIUKx624y2I+jCbzJkTGXkHvwX4m8Cw7kgguc886LrM7NDm9w3EYZgjx1
	 IIY9Hk32KUdS8oG9wb1FScDrytcger35nsU3ED0bVS+huvsuKRQ1LijwZYybHvu3l0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Aai33haC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.67
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010067.outbound.protection.outlook.com [52.101.84.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A02606A339;
	Mon,  2 Nov 2026 06:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69A02606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Aai33haC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zh+FIkBrBzNRvAxOCO3zF7LCqTpzUL4bNfkDLXCDjjnhmeuId4M2rqGKkHOxo/UMuUlwqit4NGxoyxKRHMGuUML7hGos4Q+dta4F5d4OiSNXS4du8VcWps+Kum8I05CgefxSBcTXc59R6y0cI+I5zPdVWNXbQ0xYuvErzpqV9h80any1r4PUY6JcmxPzF2fU3DlmGGmTNKoYvatZVy06mgMGOGfmE2C0RSGWRzUGw6IFhSuMFvdBeQY4wZrtrb5ackghp+Bf9IMETWyCbgTISfNymwjCPiTI15gA7cVj0ozzKMisTxQQd5148AqJKmDxomY/vYo6ZvxTa73TvvcLgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7ICfDda+vVzXp4Htf+adcHe8YaziXOA3JRZTByOS5I=;
 b=JD9o3PXFn7GglHJ75ziDWnUTKWvbpYYXhu1mMQK6ah7VWhPieEvfdxGMKISD/mS4cI9ZHifr4kqm/a6rvyEf5mECiAHi+7glblq4g3jNLa9IJM6o00LuTmJRbMrjkJ5n7TkxN7XOaZgxviYrXbJC4EKTfbsCcgn1BNgmIK2MgdyMKCugZJTsnJR+XEZ3gKEJv89qhoF4871x8PgArIrjSB46X41dLP8+IL42gVLLc9bGT1cQm/WB5BsoLNlMALz485+a4PwGkKdC0knvwwQy3c6kqoigU2Psvtoaf4eAzXpeI4YYcu6L3Lbyg9nkpZf/AOxKiSaJoWiHx7hie3uyyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7ICfDda+vVzXp4Htf+adcHe8YaziXOA3JRZTByOS5I=;
 b=Aai33haC+lYJJq8k+Ggbw/rDLhMX+Uo1TY/7xfavNTqIq8Idv30/MYhFGYz1hMUauNkRF4Rd0s2AbT3rJwBbgpKsxnRvHCMeDKuT2e4TvbBFnyZEQGug+5B69B74uvvJauRE0AbFo/JHB1EgwC0yhbn9iSUhBV4wAYB7/YMFqnpjHb0dt5Z9qxcGiSJBk8AkixwbJW/dcOp4tx67pTjhXOtpMVf8rNeanCL5e2J8OO5EaqzWleLAn2rIxvUvAsGjghQtKcAPyt4vLg8Gfilbf5Zi+HKjgrqJOtUvcQLMGx3wQR2hi3/Lbzo+tVmqQDdIAo57k02qAbh0yNazzc57tw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by GV1PR04MB420767.eurprd04.prod.outlook.com (2603:10a6:150:803::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 06:45:50 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 06:45:49 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 02 Nov 2026 14:49:59 +0800
Subject: [PATCH v3 5/7] dt-bindings: dma: fsl,edma: add per-channel child
 node support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-edma-iommu-v3-v3-5-9d0e62a954eb@Example.Com>
References: <20261102-edma-iommu-v3-v3-0-9d0e62a954eb@Example.Com>
In-Reply-To: <20261102-edma-iommu-v3-v3-0-9d0e62a954eb@Example.Com>
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
X-ClientProxiedBy: MA5P287CA0104.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::12) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|GV1PR04MB420767:EE_
X-MS-Office365-Filtering-Correlation-Id: cbba4035-fb1e-42fa-d1e3-08df38acee83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|376014|23010399003|1800799024|10067099003|22082099003|18002099003|921020|56012099006|11063799006|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261022105027099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	2zDcTusbgG5KVo25lVgALvW0jKxL+xFweEwLW1SKCLv+tdiPQtMcQRkHwoQgy2vu0r9SXI8rlCX04nZv0hP/cTNEyeKIQTai6a/neUstxagR6FJPXP/S614Y6g9VW2NCtqbWTdoGdVMkW6ypOrJctzfbDsZLkljtvpuHeKgVm+FRlZbV6/z/HLTzlPmKdpc8pa4Yh68cyL0ixTIEmoz5mT9TW8+YfZpEHVsiLwk4qrEGg/cfMc0pbmnEgrQbbdsW/OEVbbnHYuxX5qpo5wmD5cL2+TPD7y80sJFknSJFibHcJKj+N0MO1Xb2kv48VOH4jke+2qD6+hKV9YnkRV91beRV06dAbuv+TDz5b/Bs7HbxT/bNPArkah2Gmccu/qIHCRN2LAJwJUTnWY+TTMq+auVvrdttEM5S5PZnbaIou4xpSgE8IntxxD1yd8VXygILhYCtcibOABZz+SEKTX4AwmXPKiOzr1qYIlkQk9kqMjniOBnFjeOyUDn4txcQLWZkCLmDRri+FObVJ6zr3gGo6kIuSxqwRnk4B8KMxJgdBqbPWycDHH6vdhqPZakMm0JCgCXBxg9Cbglp/zmydfKoNb5cLUn5xG2209wKRotoHqgvOacBJK8pD4ar5m6zGj/n6V24h+kcQYuRV6Wb0u0HXFRuit+qilQhCQjSLuiSyTju+/Y/5LQ97xqJwf9kl6F34Shm7bDUtsdXe9oM28SFbA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(23010399003)(1800799024)(10067099003)(22082099003)(18002099003)(921020)(56012099006)(11063799006)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261022105027099003)(261009223027099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RllnQlZHZENZK09ON3ZvY2pOVzJ3NVljV3ZlWSt4a3Y4R0xxYXMrR21ZblRJ?=
 =?utf-8?B?Z2RTWDBVUDhFa3BoT3drbTZjQTBXNi9aUTZ3OGlDMGtENHJnRW9oVG9teWdq?=
 =?utf-8?B?eEFSVzZzTk1UNmhvWU9sMnV3WjQ3WFYzdGdoRVptQmhpb1pLdGxweU1zNE82?=
 =?utf-8?B?S2VreHYveXRaWkFXOVRabS8xNFFVdEg2dG91VHhXSmNRYmt1dkFIbk1UM2N3?=
 =?utf-8?B?d2hTNk9hakUvSUU5aVBFaFN4allFTTBpN09MZmtWYkl2dVBzRWNwcGg4RDl1?=
 =?utf-8?B?eThYLzJkSUtsZmJIdzhNd2xNN2dnbk02NjI5M0JzR2RjK1Jwcm94aGdLK1gw?=
 =?utf-8?B?bVdtZ0F6OUx5N0o1OGNhZTdlUjNHdDRONXRBVDJOcUJUVmdnTHhKdVNzU2RB?=
 =?utf-8?B?ZmFaUi9sQUpsbmIvcFEyYUtjRnQyanp2Tk1Xa0dzTUdMNTAzUXFsa2V3SVBH?=
 =?utf-8?B?SzV5dlBmNkxwTWlNMDFhWUFOejRvUUVUVkgzVTBaeFVTUDd5YWhYM05reFNC?=
 =?utf-8?B?dVBKbWJHK0gybExZNm5PcWllZ1JKWVIxNE5RN1FOb2x3enM2YkFsU3Yvd3ll?=
 =?utf-8?B?Q2dXUjZ5bzEvbUN0b3VIL1ZUeXZxaE5wV2VQZzhhRmMzSG04NGlmaTlucmk3?=
 =?utf-8?B?WVA1dlBuRjFtK0VJY3N2b2FWdlFiV3U1QTl0YWZBSEl2dGZJNE92SDVmdDNu?=
 =?utf-8?B?TTdMaGhsTUFROHVlUjR1NEduV3ZnanpMeFBrVzBzWlpTaVlLb05rWnFVbWs5?=
 =?utf-8?B?VEM2cnFPWUdhbWszZWtjaml2U3JIc0FjSDEwazhXM2JCRyt1algwREp0OWFv?=
 =?utf-8?B?czZ1M1UyaHVNVVp5Q0lrUzRFblowTFhRbkdQUHRVNjVNK3M2MUtab1RVOHB3?=
 =?utf-8?B?NE1hYk5JMWhobkorV0pxMm56SjQzTXNkaEMxejRlZ1ljZWE2ODBnTkQyN0RU?=
 =?utf-8?B?OTMvUytZZkJwVFlPODdRQ1BncDlXUG1yaHBoQmVzZ0tOVndPZllEendvN3hF?=
 =?utf-8?B?UjUxSE5HUktZR1U0L0N1Q2U1UWZzb3MraTdRMndROGt3YUZpZ0N1dU1qZG5k?=
 =?utf-8?B?SDl3R3dYbWh6SE5rbjQ4WHBTbi9iSjJoOXdyTEdxbmFDa05BdCtQQmdhNGRE?=
 =?utf-8?B?b21vdngzRTBIREcrUllhdmY0bHNHU2wxU1l3VDVPWXVjWHBkTjd5dlc2VFlS?=
 =?utf-8?B?b3QyK2xCK3RpbWt0Mm44MGFGYjNObFRaOGdrOU5QaUJzOW0zbkFkQlZtVWdt?=
 =?utf-8?B?ZFlLeldlMm5mUXJGR1ZkQ3E1aGJjWkRCWld3cUQrSG51OTFOclpqamJuWUtl?=
 =?utf-8?B?Mm5rWExmVloyNGY2ZmV2ZlBMTFQ5LzdQeEtxMWNGTEk3V2pWVk85bkl6QnpK?=
 =?utf-8?B?QUhRRlRsR2FJTklDWDhoNnJza3lQQjczNCthcUFSOFptVTU1NU9QUlZDbHEz?=
 =?utf-8?B?NnRiYlkrcXhwdDNzMnN0byt3SndzcHZjNWtCVDFyUy9ROWlkS2RPcDlyQklK?=
 =?utf-8?B?dG5UTEIwWEFuVUtJR3p6SENxcmVRa2NMalhQTjVBRGxZcXBJbm1idkdONEZo?=
 =?utf-8?B?V1BLMTlvQUJWQXBVVUhhQzk0Z2pnd1UyTTlCem8xbzFSbS9IdzlwbW53YVFI?=
 =?utf-8?B?LzA1Y2NqMFRDbXJ2dUlBQmFHSjAvZlBnSkE3cjZtazRxR0FTbjhYcVNTYVpw?=
 =?utf-8?B?WXlKM1g3WXg4V01FM1A0NHRmTU5JSkh3bWtTbFJQOHpkRGNrbURkc01uTTd6?=
 =?utf-8?B?Vi9RSjFWQTZpdlNBWVVZYno0NEtFRDgrNzd3UWF2MUxwRnpmNTd3TXlTN0tC?=
 =?utf-8?B?ZXd5bGhHaSt3Sk5wS3lIVzZjSGtZSTFrd0dGQWU4NzRDZVgyM3lsY1d2TWQr?=
 =?utf-8?B?UGM1R0hBS1I5NkhEWk1nbzZIa2QwVGpGN3NPc1RYSHZWeW5ZMnNVZHRPWmFP?=
 =?utf-8?B?Yk8wNzNMblV6elhvVXBIL2N0Vy9EVHFEL0VRdWtVYTZDTUlBRzB6NThDak5z?=
 =?utf-8?B?Q3Rxd1VLYzYvY2RXbXhGbXpzS29NRWZhWHlhVlgxaXNVS0dUdDNIbUhkM0Rw?=
 =?utf-8?B?ajJ6UXQ3b3dldHdJOTgvS0lxY040bExidXF6bkJOUW5WZG9rTzExeWpCQ2VV?=
 =?utf-8?B?SFMxQ3ZpMFM0YzMwRmFVNUozbVlPU2tJK01EMTF0cm81ZmJReVN5YmpnMHMx?=
 =?utf-8?B?VTBOV3BEQjliT1MrRUZiQTdTcXlKRm5NaEJCa2xTRVRoMW9XWUpiSVZYS1Jm?=
 =?utf-8?B?MzRRdlpPdlpZRnZUSzY0bmtuKzhtRXV0c3ZJdXhSb05QZ3NQRHlSZGxnQzZ5?=
 =?utf-8?B?dERaWFYzTzlFaUFYUUgxU01sdndabUxtUitreWxjWkNOOGhQTnBFemVHR2dn?=
 =?utf-8?Q?MgVnhnL2YEw//6Nut7hAFbC2wC0c3gMhEz+DI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbba4035-fb1e-42fa-d1e3-08df38acee83
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 06:45:49.8033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJ9s6nSF3F1uordDSvla9CZ6Czh9p4jV/sNkXnkEqKW5VKIqtBD/kG+q/DdphLzWmm8EOsXfzuCJu4h5P37IvhwCGTM6N5EvRL85MjTVjKa3F2OZIQTZOEucoV9s9wS8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB420767

From: Peng Fan <peng.fan@nxp.com>

Add support for optional per-channel child nodes (dma-channel@<addr>)
to the fsl,edma binding. Each child node can carry its own reg,
interrupts, iommus, and power-domains properties, describing a real
per-channel MMIO region.

Enables per-channel IOMMU stream ID assignment via the standard
iommus property on each child.

The interrupts property is removed from the required list since
channels with child nodes carry their own interrupts. Existing DTS
without child nodes remains valid.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/dma/fsl,edma.yaml          | 70 +++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
index f609038e35ae1..19a103baccaf4 100644
--- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
@@ -104,11 +104,40 @@ properties:
       Bit semantics: 0 means channel available, 1 means channel unavailable
     default: 0
 
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges: true
+
+patternProperties:
+  "^dma-channel@[0-9a-f]+$":
+    type: object
+    additionalProperties: false
+
+    properties:
+      reg:
+        maxItems: 1
+        description: Per-channel register region within the eDMA block.
+
+      interrupts:
+        maxItems: 1
+
+      iommus:
+        maxItems: 1
+
+      power-domains:
+        maxItems: 1
+
+    required:
+      - reg
+
 required:
   - "#dma-cells"
   - compatible
   - reg
-  - interrupts
   - dma-channels
 
 allOf:
@@ -351,3 +380,42 @@ examples:
                       <&pd IMX_SC_R_DMA_3_CH6>,
                       <&pd IMX_SC_R_DMA_3_CH7>;
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    dma-controller@42000000 {
+      compatible = "fsl,imx95-edma5";
+      reg = <0x42000000 0x210000>;
+      #dma-cells = <3>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+      ranges;
+      dma-channels = <64>;
+      clocks = <&clk 0>;
+      clock-names = "dma";
+
+      dma-channel@42020000 {
+        reg = <0x42020000 0x8000>;
+        interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
+        iommus = <&smmu 0x30>;
+      };
+
+      dma-channel@42028000 {
+        reg = <0x42028000 0x8000>;
+        interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
+        iommus = <&smmu 0x30>;
+      };
+
+      dma-channel@42030000 {
+        reg = <0x42030000 0x8000>;
+        interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
+        iommus = <&smmu 0x31>;
+      };
+
+      dma-channel@42038000 {
+        reg = <0x42038000 0x8000>;
+        interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
+        iommus = <&smmu 0x31>;
+      };
+    };

-- 
2.34.1

