Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794798070;
	b=No2PuB4vWJSK4ITjriwYv+Yfnna2ZJWipm0Y/PN1IKElF2e7YlqAh6rmpWLlOWh6Duro
	 tOaxwUD9Q/EShJzRZDABofxEOnpkNbki0sLRvPd79rU103wygLZZmXM+uszV5UUxbtv2R
	 aTyo5UD83dTI/iqRp/JGPETrbADmSY8s6C++L4ofjvrtJ5ywH09O+29E0oxrb2KsmYnlP
	 wm+jM3F58FyY1kpTrACsKQlh+nnywu9YDERaHdpJglYHctNaYlsuo4C46oLRx1hez8i15
	 tCQDG3ta3BAgjco6DJvq8q4X4jzg7QXf0wnzUgq7zHg8ZPDmUhWdCVGtj19Kkyw5rZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794798070;
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
	bh=9IhLr1hXEvbJe+Xv7uk56CHmRZUq7/a3htAJDzaYa60=;
	b=eC2HqwUZ+sbClN0QwegCIveRBSRoi5+XBjjrmjQvpneMHqcitOj9QTCc3Yjp+wNGgfkY
	 1GHAhQr245lEAJ4Ku7GVa6hOiPmhuNWOCEXpeIMU148B8dHI0CQnwWQfha1wb339OuDTv
	 6/eF6hD/4Y7/waqWOYITrilCNLz2pSxR8lK7VDRBWEAt+t7iqfNnIPr2F0DPa2PSxFOzq
	 vV67vayZ6t3T7fwbnqzaWk+DZRb81FDAmgQecuVUAcrGWcQdyKByTUZU8/Dj86lsmyuyN
	 +Pe68k1ogsLfpNXNyVv4DAgPQqfy0lCp4mD3HXSyN9TM7FimAg1uDx8c/7dDe1RXOfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b="sS/Bfu3w";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.45
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010045.outbound.protection.outlook.com [52.101.84.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6E4606A331;
	Mon, 16 Nov 2026 03:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE6E4606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=sS/Bfu3w
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EwveLE2FFEEA0uJjrgStjN+YaRO4LWdaBkRyy6ABVV0a/CQObDuGyp7PljYPeOYMkcam7MbQryXZYlVPleL9B7kxRagN1vl3sWt836cmH5qc/EPppIs6BAvdcqF9xECfJR2EZcNbGPjADE1ssm7AVpYLF9h6zQO+0q7CILu77iv0u9mrJPTQn+5BxTRSelQ1RMIFlwxUGiX4WGU8iBGHb2cczEtSkokGXdIQD5ChVFoAazE8WmMQDPE3tzXSQQUeb414/UmPgl46aoJe+adwzaE2mRxM83HoBxUvgsWlw+pjKlKi9BGnjO/yGDX0qeJ8bGAJ5bpJglubCOSBAKx6CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IhLr1hXEvbJe+Xv7uk56CHmRZUq7/a3htAJDzaYa60=;
 b=OruvtF7G7KUKYguz1CBWNnEdVXDTTA8zBoWAFNqeOvlsoyXeCdtJU0R9/iRNIRoWywe+EavSanFB+VUFchEL8wL9yjCVuTT90KpYAAKaRu5kWB4qisqaOPrxmUCxO0KqnRr7xJywbwPj86FocjY3zsu7wJmZfyG1UoF1Wrj8uMpJoNRdneXODy+MIB/qDO402Yosdg+lL2ifDdWEibDKgvfDpD+pYmhUtGmJoGOcmNAJnZzLfHbIN+udj4L1Ay8vgH2mKyOIcp6EEuoRVoe1pMm1KUTrPOIIBovaWOlO6KNLRuZ9/7C5MVMLgUMY49cSqSEEWQIdy0Z2MO4CZS7v6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IhLr1hXEvbJe+Xv7uk56CHmRZUq7/a3htAJDzaYa60=;
 b=sS/Bfu3w83Ci3nAjluYqOW6jecFtPnjekSuYEiVV5mFe0cV86ubWnD6BcAse0uRlR2trF1f5b0s9wi/MIlx0v8GkX8grTlf1LDtpyGE4ZGKXvQk1fTUyVUqGaYgOojNzlq/BuVS547RvPKS7KPOP60wOKLb1bPPds8GOFGru/udLnji31IHb7TEr31wW6JXr1LtrWosHRQScV1GW3k/ha0hkW0fVIcIVyFep/nchN+nq+MHaasm5tIYNEXzCNmiyDfMNcpQ2vMuucE25uAx2iaNzrCr8UuUYpw54ZbiNSukXJ+7wYBppJkWoe1qr12TruYh+8zegGvrggrii4mY45A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PA6PR04MB11778.eurprd04.prod.outlook.com (2603:10a6:102:525::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 03:01:07 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 03:01:07 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 16 Nov 2026 11:05:27 +0800
Subject: [PATCH v7 6/9] dmaengine: fsl-edma: use BIT_ULL for 64-bit channel
 mask
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-edma-iommu-v3-v7-6-32794ba8efbf@nxp.com>
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
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: a23b3131-82f5-4911-82c9-08df438ddbdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|19092799006|921020|10067099003|11063799006|56012099006|261026140227099003|261028144727099003|261022105027099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	M3Qyf1VYfH180Gunjxw5Ti2hB6hYIq8ACCbj+UzKYOoVNBlDUCiom1tLI9YZWDQ5aI05NxVZH32IrRTFIU4D96b6JXW+L7hqHtScFR8roD2gx62XWYZEXafoiPwUQmPU/WDMGBtmU0UNlFvzUnExiuBbijkmJ5zUho6v790NKGV2DwJGSytlEuGNEGVWzRfYGUIG1hoZR3Pag1FjcLb+NjdyZugQmAqWOVspADN68Qx6+G9FUl8b/mejdbpoWmO7GnrsEbfWI2eBBuYP72zl211EKb26VmwZAEXCekONY9xBl9lwJ4aH9q4Qq8IPOJ1Dcv60tyU7h4rtTWV9lxonxv5voxp+TKP00QgJEMvlgQwgtSrdomBvHVzl6TUte+KfQxe0jqCBRdn1jjoKSXTEMbmu6GIEKRvJ1/HJi/f1nDulZOVtpaT5aGEVCiZV5F0SK6WQh0Y78a2elbZw4WncUuO5VNwWfI6UHsWiCqH7o+bbMLxefvqhSdltDsqMj/fQv91hz5NwDbocVaoIp3OsfqS2iUUf50nCXVRVrSBHCrR1vUleNnw36FzWTus+GdQeW0lmanO3+mD6y0mLn+0pK58A420lQtKGHIqWgGjnnjngpICxbg/Zv3mf5gQPMUewwSzmbXLI8LB+9P5iRZcs1jhEgm9+HQbxE+TcH6jKeetWNZTwrazv8XG9Ktca/TfANA7jF/AQuhE1sKgqMYInLw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(19092799006)(921020)(10067099003)(11063799006)(56012099006)(261026140227099003)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTduc0M1d1Z5UjhhNnhrU0FYZUVQZHdpWVVtZm9naVNibHp0TVJOU3RVOFBI?=
 =?utf-8?B?RlR0bFpnMnpOekYwWG5rVVpOb1dGYU12NVJmTTlOYko2cytvdVJVL1dsTnlR?=
 =?utf-8?B?czNGMjFJb05HL2F2RVM2dmtaUWhxdnVWRno1MnJUa0Y2dWZwY1V4YVo2aTJJ?=
 =?utf-8?B?WGlyNExKWjA3cFdvUm1yQzlKUGw5cnU3bVlxNXpnT3V1cUozZ095Z1V1bEZl?=
 =?utf-8?B?VEltTDZaSzM2YW1vcXE3Q1pmQ3UzMXZ1Y2VIM2Q0UWthY255Z3l6V0RmN1Js?=
 =?utf-8?B?emJoUWRHWjZQVHBLYU1ybG1uVjBXd1VOUG1qbDdrKzZwS2RuNzdnWXVJM0E5?=
 =?utf-8?B?VzZUY0MrL2tTSXVSK3NlYjBVTkFXTHptcUVQelVQd3Fab29TRFFjWHBxaUVS?=
 =?utf-8?B?ckI4K2kranVDZlhRNTBXOUdYa1Rlc3FVWUsySk8xOEdHeUtjenZRaTREeTNP?=
 =?utf-8?B?REJkdnFVb0owaStXdThmTnJxYVlZYTk4OWI1cGc1Y2JKZUlIYU1VMWhBV01Z?=
 =?utf-8?B?NVFqRzZjT3ppaUdoTGdYTk1QTWlvb1hKcExCYWY3VExMQ2FPRHhGemNVMEtX?=
 =?utf-8?B?OFBaZXRuRzdPR0xTRndRSDNlNzRpUjRadDNjVmNUNFJMSUpTdWMwVFgxaEx2?=
 =?utf-8?B?WXRTTWxWY0RBOGZ2ZTN3Rk5wQjJCQlhqOVpSbXJGTVVucURvbE01S3pMcFJh?=
 =?utf-8?B?SjM0OGcvbGpYUTYwb0krSlBnelVtSWJDakt5M1lOdDFwVkt2Zkxha29FdHRG?=
 =?utf-8?B?dW14NGxaeis0emEzdnVDSElZT0FRdlVMRFA2ck1aaVM1Mzd0WFhiNWJ0SzVQ?=
 =?utf-8?B?Y2VZTW5DK0Y2OXZsVXFZOU9SY2trVTdNNjFHK243eGRXU0NvMTN0RHBuSU16?=
 =?utf-8?B?czBYclpPS1E0OHpuWVJSSnM1a2daVGJ1MmNDM2ovOEJaVS8wSVU2dVBrZkFr?=
 =?utf-8?B?bHdtMzdQTG1udHNVVVNBUmpBdHordVg2MWJhUmhSTjVFdDFVZ1daTHpaWURl?=
 =?utf-8?B?SnhPdTF3VXFGTUlTOC82d2wyRVdvYklaWTRlUllKMDhPWWtRbGIveFc1YUlr?=
 =?utf-8?B?a3A3dlFMaUJxZkEvVGxWM1g2b3FjeXJtcUtuaTJyZlJzRUhSU0FSbEJBTE13?=
 =?utf-8?B?a2lVaFNpYWJ0dWVVcnpDT3hjM21hbjFoZEJkb2NjYlRPczJOL0t5TGJpZkVY?=
 =?utf-8?B?NS9yNU13WGIrWEFVREVsczd3TERUK0NJQ29RZ2tDaEt6dmJvMXhkR0xNN255?=
 =?utf-8?B?dWRRZHBrS3NEL1pId3JhZ1ZpM3Y2ZkZibW9GRSs2WW1hZFVUcXVlT09mS2pt?=
 =?utf-8?B?MUZzMkhVZURJclFBMnRuMUk4MVo4MzhoS2VFbUhwRWlWTW1zSFBBWFgxOFZv?=
 =?utf-8?B?UHpaUmlxZkFnTUIzMFp6RVNZYXpVNkgrNVJlekV2YVBiOGpnQzRUMEx0anJ0?=
 =?utf-8?B?OTQ1L0JkbnNqM1NkTnliYThqbUJmQkVGUGprSUJ4M0cyeHBqaVBwN3pzUlhF?=
 =?utf-8?B?b205M0VFVGRjbmNkaFVBVlVPeHBoYkFNbGJma016bjNCWGNsVDdqWXFYSWE3?=
 =?utf-8?B?YlFtcGlRaXpaaldLcVhzenFKa1RtR3JxcEc1R3V4azVUc3IvYlVaaVFEejN6?=
 =?utf-8?B?ZnJlWG8wNEZ3WnZ1ajlKMnVWcmRtMTFiVGdsOU1KNVhQdlBTTHV6V3JMSllS?=
 =?utf-8?B?NUtlT2JNSGtuRW1lVzN6dWQwb0o4RVpFSmJPaDF2S3lWbkZsenR1U3VwZkd3?=
 =?utf-8?B?UUJ2djdXVC9HVEdPMVVLZTYzVHJIUzdhcnZlUWw3dUNiK01nNVFaaWlDU3A1?=
 =?utf-8?B?UFlVcE9scTBXTXd4STBYSFppWUtGSmpSajF0MlVNTlI3Mnk0bXJrc1NSQnNR?=
 =?utf-8?B?Sys0cEx6QjVaNzZmZFdJWnlBdUdSY0xxamdmL09qeG5WSkVZVGVqNk9Sazlr?=
 =?utf-8?B?eVd0Qlo2akhJODgyM0dRMk9CRiswUXF6S2tnWFRlU0Z3cktTcDA0L2Rqelp6?=
 =?utf-8?B?bmFwUG1CaU1rMHp5ekhoUXk5OVJNYmpPWmJudzZ3QVNBNlIvVVJiSkhRNkZT?=
 =?utf-8?B?cVEzbmNZL0tqNE1hc2RzR2tOcFRDVkpwYXF2cUpROGpqaEJmMnBWTUd5aXBO?=
 =?utf-8?B?OFQrZlFYbzZUYXhBL04vR0EyZWgxaFpJSXJqQzd0R0ZTT1NEVXZJZ0lqTUw1?=
 =?utf-8?B?UDdQZ3NhMW5Sa1k3NzVDQnJYQkxxcWo2c25UdHNnb0hWL2VCOWFLa1BUL0x4?=
 =?utf-8?B?Q1RqcUtrOERrYkNMZHdXQlptc3hueUgrc3lRRHBlRjZLS2NjdGhPdTdoMG91?=
 =?utf-8?B?SDhSVTRsTjR3eWdqS3I3SkNVZGQrRTlSaGFwWTE3OURvdEpDUlhWcXRmZG5q?=
 =?utf-8?Q?cKkqXGoxdBC8rH9QieI1cHRbZdF1RaBZJUuoT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a23b3131-82f5-4911-82c9-08df438ddbdb
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 03:01:06.8930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mwPEPoJ+Zd4eXke1BVpw8qBKdxc+a76pmSVSJB74Hil8pBoSRwzNLmaJCKkERuPkdDtTTobuoCgh3Es8jn/Orl5sLk/82mvVRLTiWuCc2xWVwp1vVKwVW8OfjJELTleZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11778

From: Peng Fan <peng.fan@nxp.com>

chan_masked is a u64 bitmap, but several checks use BIT(), which uses
unsigned long and overflows on 32-bit architectures for channels >= 32.
Use BIT_ULL() so the upper channels are tested correctly.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/dma/fsl-edma-main.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 7f82dcb7831d..818b9b986f13 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -123,7 +123,7 @@ static irqreturn_t fsl_edma3_err_handler_shared(int irq, void *dev_id)
 	unsigned int ch;
 
 	for (ch = 0; ch < fsl_edma->n_chans; ch++) {
-		if (fsl_edma->chan_masked & BIT(ch))
+		if (fsl_edma->chan_masked & BIT_ULL(ch))
 			continue;
 
 		fsl_edma3_err_check(&fsl_edma->chans[ch]);
@@ -397,7 +397,7 @@ static int fsl_edma3_irq_init(struct platform_device *pdev, struct fsl_edma_engi
 
 		struct fsl_edma_chan *fsl_chan = &fsl_edma->chans[i];
 
-		if (fsl_edma->chan_masked & BIT(i))
+		if (fsl_edma->chan_masked & BIT_ULL(i))
 			continue;
 
 		/* request channel irq */
@@ -641,7 +641,7 @@ static void fsl_edma3_detach_pd(struct fsl_edma_engine *fsl_edma)
 	int i;
 
 	for (i = 0; i < fsl_edma->n_chans; i++) {
-		if (fsl_edma->chan_masked & BIT(i))
+		if (fsl_edma->chan_masked & BIT_ULL(i))
 			continue;
 		fsl_chan = &fsl_edma->chans[i];
 		if (fsl_chan->pd_dev_link)
@@ -669,7 +669,7 @@ static int fsl_edma3_attach_pd(struct platform_device *pdev, struct fsl_edma_eng
 	dev = &pdev->dev;
 
 	for (i = 0; i < fsl_edma->n_chans; i++) {
-		if (fsl_edma->chan_masked & BIT(i))
+		if (fsl_edma->chan_masked & BIT_ULL(i))
 			continue;
 
 		fsl_chan = &fsl_edma->chans[i];
@@ -797,7 +797,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		struct fsl_edma_chan *fsl_chan = &fsl_edma->chans[i];
 		int len;
 
-		if (fsl_edma->chan_masked & BIT(i))
+		if (fsl_edma->chan_masked & BIT_ULL(i))
 			continue;
 
 		snprintf(fsl_chan->chan_name, sizeof(fsl_chan->chan_name), "%s-CH%02d",
@@ -927,7 +927,7 @@ static int fsl_edma_suspend_late(struct device *dev)
 
 	for (i = 0; i < fsl_edma->n_chans; i++) {
 		fsl_chan = &fsl_edma->chans[i];
-		if (fsl_edma->chan_masked & BIT(i))
+		if (fsl_edma->chan_masked & BIT_ULL(i))
 			continue;
 		spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
 		/* Make sure chan is idle or will force disable. */
@@ -953,7 +953,7 @@ static int fsl_edma_resume_early(struct device *dev)
 
 	for (i = 0; i < fsl_edma->n_chans; i++) {
 		fsl_chan = &fsl_edma->chans[i];
-		if (fsl_edma->chan_masked & BIT(i))
+		if (fsl_edma->chan_masked & BIT_ULL(i))
 			continue;
 		fsl_chan->pm_state = RUNNING;
 		edma_write_tcdreg(fsl_chan, 0, csr);

-- 
2.34.1

