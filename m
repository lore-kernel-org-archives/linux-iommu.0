Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793718872;
	b=pQlcrIJodpSp+80eku4CHvZYC/rht5hOT9HETA1BXxLDWEkizOLdz9YR62jy9xb18xNT
	 KJiI2IRUITNzV98iJD9H+/LmJdy83TQfjAyN93PRbd8cC5dt9u9aUg2XoUpdMz5BSqr9K
	 oCT9j46Q09HMyoOXr3IPo5sSNFeMcf5rpNpcltdWGh5MXRXz5D03mySMj3wP02tKV+pVG
	 AlanVAsHpZRNclNHE50ZJHB43YDQ1KokeKLJ+NHE2oChjuLHRqM2XbY4Cb6HF88ibgYWC
	 PZVXCjcWz7S8D4HN8z4uk2EGdqizQ6BkNYb8BrawC6cpy1WyoKiOA+rFBLEK+bFlVlw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718872;
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
	bh=5K4KLkTkwJbdSe8VZn1LAj04sB2Giiu60O7ovFGPvqA=;
	b=epHq3E2ap8drNLhunij29o64zaHKTsry4xUPD5LRfUdDdaYf9LNiVQv/N0u0wUmaH1k9
	 Rucao2nqwbyzhAtq74K+BJJ5HBCSZTqBhd2fw9KI9yxxocDfDa/MvQzAKEH8+ombBTpiU
	 oKSHIhdD4XRYPcPVAZGWYYm5A0Z9zNwPCTu5hzV1oOC2o2L3QCb39lpOPqR65Y/eZu70o
	 6x0IxI25LHwAAKAlsSn5gD2hR2JXqnP4Nf/7MZmVyUTzTX+724RolBnVAjrdCpDaZtaxh
	 PsOzhzaW1n99Lg3fzI0zr+muxeJO5SPSz6Z1kYsjBOC7LIq0YQI4IAArsMBrooqeSJw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=pbjEjUrt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.19
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013019.outbound.protection.outlook.com [52.101.72.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220A9606BA3E;
	Tue,  3 Nov 2026 15:14:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 220A9606BA3E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=pbjEjUrt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dyu6ikwt1WpU57YLe1d2yTSFotWM2fzGmOxL8CyL+tJinOvt4eRzRtl8Z00ogQkBdBtHxr0sH78F2l2stNcP1tY/Zh/1UpNcT3pFKk41FuFQYS+kmqEgvMQm15ZsBkTty4hBvGXsvNV3RhrnJ7WoppTXnNSRIPyOKTJ6bUKn7oY4d4J5wHM4RJBs1yDIzI3ltDUA2oEpMJxtzDCLkWSCO1UL6btkzX0XRW5MBQX2ACrNnGfzDMY4cyAROrofZsL6q9qiqQqHFCLTqJb0HAAOLkagdCB5F/SEeO3zbG7xPXgA1OAu5Wzlvf0QKGCmv0/12o1fxUQytABDawYcRfnCWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5K4KLkTkwJbdSe8VZn1LAj04sB2Giiu60O7ovFGPvqA=;
 b=Li+kulr2tjj9d2z5t7afnxe7cPSA1pwa6v3xHBzx2M7IUzLVKAcVl1Vk446rXTemjva9rGRIr/pVX7rLuGtn/xjnYu5NDsZYEmwrKtGBthc8o7B4npc2RqXxYEZmeGdfryVVldGroZP4+IEXkEmKiqFy9p2aj3CvGZEA9+m2LhIN4uUqVOt9XxKtAxaXM7nKmSrobCzh4gY3AnmVuvEaC6B3vaWHtW+wJIYgxwTL3AFaLToPgLklYG8u+IbP0DLE5/Kf32R9fGOhdLpHwHWOeK7jfkB2x8WBXiaNg+4vBYbgfyRMP45gtxo1k08pREot1GrU8W/tnBSi2CAuoj8qBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5K4KLkTkwJbdSe8VZn1LAj04sB2Giiu60O7ovFGPvqA=;
 b=pbjEjUrtrlFh4SQg1wYNRyFSHonkmU/bzKLEwp2sj1C0oTN6fbbCqcyGxL8SiNjRlhOo7snWZ94x/sJQ3sDauBIaz+97PmIIxmC5vkfcWjqZUxAmCYqwS/Evt9EaTTgMFNSfhGA0AUEkeedePKiq+VapsfiswiiuMzb9rlDKUklMNbLYm1krb4gVkmcCnd0638UHuCVzD84AuMLN1ncJ8DHf4PqcDUQF/R4KJhJg8bsJXaK19/qm3oT1WYt3xPpfy7fZJCTzWabWwlGyaozEipXwIHDA7VGrKONuKda7QPN8fRyfwgeKKuvXjkOvNCgcMUlUg80pYGuhEFhjO7IBHg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by GV1PR04MB10727.eurprd04.prod.outlook.com (2603:10a6:150:210::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 15:14:25 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 15:14:24 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Nov 2026 23:18:58 +0800
Subject: [PATCH v4 1/7] dmaengine: fsl-edma: unregister channels before
 vchan cleanup
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-edma-iommu-v3-v4-1-470415d418c5@Example.Com>
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
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|GV1PR04MB10727:EE_
X-MS-Office365-Filtering-Correlation-Id: 28e1f6ef-7287-4641-24fa-08df39bd2523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|23010399003|1800799024|376014|10067099003|18002099003|22082099003|261102123227099003|261009223027099003|56012099006|261028144727099003|11063799006|921020|261026140227099003|261022105027099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	y4Req2FM8x2PJH+FQDF1AB99M5efmf5S3CvQINX6hQmfLVycaV0GOJmWAgrZWRkDwWNkv+mXJKUgNKXpwu1KEZ1+YW3Kwvj2dnWYoYy/jsT5aLJu6C/wjbKtVPb/TaaJL+Z1R8J1GF47wJsCNY2g12bOkjvtULXEdjzr9Nx/Tp0tTtCnz7uyALBUDEofQmS3lxuqN2cSmBP7YOwnDMnIpOlXLyTETdMUfgfS7QgOAQyJlP2ScDucDgKwfSNADyKJhMoL0Gwagi5wHafDa0htf6I2b+/mPW0LNbIKFuKcoa59S/wPQqiEKQISZGYtp8lPbNBenloPjFJOwObfJQ1BFcRMnXQPbRvxP7W5UPW1W/hyW/D3mJDh0fc68DKG+ziAPQMxG4DdljT1yh5u6rg2W4gjP61e8P+2p74msMSlJeNbNFk/tnAR7fJJnTrXG1gObSjQk46mW1vNdvQs957TW0tN2vC2kwG8rjYjmHq5XQ0+3T3xdM0O5Y3jQpZmD2kPtrsR3V2LAmmeMqPH3J8WsD4+K9PHKeXDGXRPMpSAee1YsC0+paYeOGd34O3JbOffaXo5odpvfV7GDWiqDUwTIYO3E9WIQrfPPSP22RLoxbz7neYH8SAa1YZ0GCpoPye5wvY7FFiGQCDk653mW5pZdrxlVbmSaWFlBLreqxJJUc5dQcUDf1X6itbAD35bx9KOPDmnzZBpPZRjpazhDUjNJg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(23010399003)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(261102123227099003)(261009223027099003)(56012099006)(261028144727099003)(11063799006)(921020)(261026140227099003)(261022105027099003)(261021121427099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2RKbG81cW1IY2F6R1JSV1VvVFFqV2tzR0ZBZU03N2hEMnQxUXoxODM2ODFX?=
 =?utf-8?B?cWh2MWtPVUJHbkRxUTRHSGV0bHhuRTA2SlJqSngxMm9UR244d3ptaXhFbzA1?=
 =?utf-8?B?UGlZNjYycXYvOG9hOWlkS0ZjbWs2VGRmTHA2ZkVhMkVkQXFBZWo4RVhCK05v?=
 =?utf-8?B?M1Y0aEZ5YVM1b0pZZU1Lbk9wNDZ6SVJIL3J3NloxcUFra1hpdFpxaEQ2U215?=
 =?utf-8?B?QWZJWXh2alFlMnJYQXBSaGYvSWZ0ME8xNnV1aWlJZjZ3Nkd0K1BDdlRMMURQ?=
 =?utf-8?B?NEExZzZBZVZEaFl0YmNqUC9Bc05xNHlWcmI1WURST3NmMDdhTTZFazY1OTFW?=
 =?utf-8?B?eVNqclAvM2dtbWxwQmxuRFNhSUJGTXlNbTFNRnhvRy9SOVhSbGp2cHlEdmtZ?=
 =?utf-8?B?ZnVzUGZlZm1Gcmt5MVhFNDA2SklkSGNzcUdlc1ZYV2hVTWtuRFpvelhGQldQ?=
 =?utf-8?B?L2w2SkZMK2hyV0hxTnN6emxrZHU3UGZ6RDFRYnJ0aW9SVXhHTTczNWlFQkxn?=
 =?utf-8?B?MnpGT1RQYVhodm5rTGRnbyt3QzB6dlU3Y1oyZC9Lb21NZ3kxTzRwVmE0M2V5?=
 =?utf-8?B?cFBTR2dJUXJPT1FpMEQ1eVc4Yk95V3lCTy9KQlB2cWJDL2JzdWV4a0k5YUpw?=
 =?utf-8?B?ajVmcWdma1NmQ3V5cUNWdEhkYnAvWG9wQ2tqakVtSVZnNnZ4cVhJcjl5anpP?=
 =?utf-8?B?SHptVHRQRWgwVnRxVnZ5L3BKeVU1WEh1U25oTHhwb1R3YnB1cmZjQWZvRHhs?=
 =?utf-8?B?ZkovK0tWTXpDdmsxNm8zbG82WCtsVko4dzFKUFJiOWRkaEd4d3FTUzhJRmUr?=
 =?utf-8?B?V2pIY0VZMlpQTUZKelhwRHVWWDdvQjNxRXNmQTgyeXViR2hQTlY4RXp6d2VG?=
 =?utf-8?B?NzZUTlhmbWFiZnNaV1o4T0YvbDJJeWpaVEJsTGVBNmJXL09kazhWclYxeEpt?=
 =?utf-8?B?N3A0aWgvWTNSaG1YKzB4WEFoV0ZrNWxjZ0VCcVYzd041SDhUOStJWU5BNHpT?=
 =?utf-8?B?Y3N4aVZ3Nll4Sm5uU0dDUW44c0lMeGRFaTBMdWdyTHdLaS9rRWtpQ2tqejlS?=
 =?utf-8?B?S0kvMzB0N00xRjJLUXMwdkdhRU5oZWtOTnRra2dFdEZ3eFhkM1NYRVNEbHFG?=
 =?utf-8?B?c0dpVzBtVnA1cGhpYUNvNzl0anJuYUV4Yml3Tm1mU2NiQXl3bW1kNnl0WG84?=
 =?utf-8?B?U1dpT2cza09OUlJCQlNIdXRmVlFQZzUzS3dMWW1lZU1qMVBVb2lrQjEvWE1C?=
 =?utf-8?B?MWt6QW1jT29TaGxDNTZYUWlSRk9SbTB2dW1nTFJzVUozcWlYUzlQRCt1c2pw?=
 =?utf-8?B?VVB2a1FEa0ZieHZSWGpHRVphLzkwWWtwb25Xd2ZPOTdmTzFVQ3htYWY1Z0pu?=
 =?utf-8?B?blFGNzBXcGFwYzNYTllmdUR0dUFobWVmN2hrSUMzSjRoQ1hTS2ZYc2JHZW1v?=
 =?utf-8?B?QlVUYzZjZWhKTHRnOHM4TjZ0WFRMT05JZ2NDSHMwVnlBK2grRm5ZT21FS2k4?=
 =?utf-8?B?TjU0VUhGY0JlWFVUU0Fpd25pUExDQit1WGRvMURBNlM5Szg3MjFyMEt2Uk9n?=
 =?utf-8?B?MzZhNmluZGZVVHRvUWl0amozQlRWaEtDS2RkNWdDNDJsSWRSYTd5VXRDUElz?=
 =?utf-8?B?NGZxb2wxRVhub2pIbll3VVJPMDdibGgraEYxb21WODdYUVZXZkxjcC9PUTlG?=
 =?utf-8?B?K0QzYzBOdXRYNnZDYWM1eE5OVXd6N3M3VGFqeXMyaGdjM0swa1Z6YkZVY1dV?=
 =?utf-8?B?cHZRZ241cjd4SmgxeXhNcmhNUkxWRERaRElUek9mTk9IR2VpRmRKS3NJWXFB?=
 =?utf-8?B?b21rQ1VmcEhPTTZjcTFOaEpadGVlL0FnRlJOQzlsVFFOL0FpK0VETENwYTY3?=
 =?utf-8?B?ZTRJelMwZVNJdjV1aURseGJ4Rll6VWdlMnF1dUgvSXBzbUt2QzhMejVBMlps?=
 =?utf-8?B?S0RLWXBHVmpsVmptV2c3Qmk2Tks4VWxmd1BKeVBuN09Nb01veHBORitndjlB?=
 =?utf-8?B?TjdFUVNvRzJqUDRlTGVqdUtnM1B0NmNvRWxlYWVXdEdPbVgxc2dJOFYwUVlT?=
 =?utf-8?B?MGpJbjk2RlJuMEhrWXBFZjEvbFoxOHYzb05LY2VVRlE2S2FVRGlVMWZqOXNC?=
 =?utf-8?B?YURYRjUrT3N0eUJLNlUxM2gvYmxpZWJXNHlvSlBsa1FHVDRpelZPeGJJOGxz?=
 =?utf-8?B?NG9IOHVrUGQ3Y2dqSzB3SVVyT2t5eVNNWnE1UW9CNjBLZGt1UlVUQXgyWUVM?=
 =?utf-8?B?N2RkeDFmbTdlWkI2NW9MVy9yZnFaTllaalFyeU8vK0QzRzBpQURmaUZTU1ZM?=
 =?utf-8?B?ckYvZXVXT1NDSE1iNXpJOW1ENjZvN21HbHNldGJqUW1kSlJTQUppeXViOGxo?=
 =?utf-8?Q?x4kbOmR56XSJLzkIvOOuXwNXKMS8JAwRP6t9b?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e1f6ef-7287-4641-24fa-08df39bd2523
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 15:14:24.7963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gr7IGpjCjruBI+iXK3VFdyFZbWmQSmNvwUk3ogaIyMkI5DdwDDNkSoQccyR4BkSKK+SgHMpMrfJlSwpMgeXdzeEiW26rz6um74kZQqLE2OQ7ZE+cUk41ozak20zjI32F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10727

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
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/dma/fsl-edma-main.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 630285c854824..30d548a723462 100644
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
@@ -882,6 +887,12 @@ static int fsl_edma_probe(struct platform_device *pdev)
 
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
@@ -906,7 +917,6 @@ static void fsl_edma_remove(struct platform_device *pdev)
 	struct fsl_edma_engine *fsl_edma = platform_get_drvdata(pdev);
 
 	fsl_edma_irq_exit(pdev, fsl_edma);
-	fsl_edma_cleanup_vchan(&fsl_edma->dma_dev);
 }
 
 static int fsl_edma_suspend_late(struct device *dev)

-- 
2.34.1

