Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794404602;
	b=m3zdyGZaoOWHeii9AZVCRO7SGghJyrL41ydaIE2WUgkpJBS1hPJtfmTOy0soD17Bc+dk
	 kCzLANQI0SPp4YaVXdjvVEbzyF0jWQvWMyHPHB/RbyNv4Jc3x+Uf1dK6q8mplRUTp3i/5
	 ZG0dpvNk4/Us5+8cJ8671FMtPdMcPpNkBrluIJ5kM6pErS/GNrIkd6U1Un9XYdM9rbyAp
	 njScQlisciexNTUIZ6pdKiUTWgMNme9cTntHCT9/d62hilsObf3D1I4Z7Y15orRXnSApS
	 9nNMJzFYrsmIT6ACCQ66U6UGe99XLP5VUL8Z1I+sV67tQ0D3XqFzQ7dE3/dWZEiEdsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794404602;
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
	bh=mKYYQ27MTtrrNZha95pQu8ZURoZIIyu3o1V9iakQjNg=;
	b=ElpE7eQ2pHpYvU+c5lIRTTW+FDX803CyQxjS7Xgt8OV76sDuwTfPuN41YVdX2IdNveZN
	 3RGOgngg3UnY37fov3ty8TECekp73Q+UAdlduU1+7Hglhw++Da+9RvIrPyQEYlb6irXy8
	 AKu1VmPWCB/3VTWpd5iacCEtUWJrsk+zs+Tl6KJ5arhQHtuXNTqGYbkKHwOYIY2OAXDXm
	 1v/0tWlZGHT1GHHLJW+cTDLmN2kd6EjL20ezBnKA3n8MWiuU31rAdnOEQE2rYZ1E0qqwe
	 TlOD+vxi2aMmhDsAWniQ5aEkLgH2Dawar6CpCc3oAwIfr690ANv98TY1xA2nkSxgyCA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=KpflFkc8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.33
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013033.outbound.protection.outlook.com [40.107.159.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88CE606A8AC;
	Wed, 11 Nov 2026 13:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A88CE606A8AC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=KpflFkc8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=plFtO6ko/xAGwIjgqRKbcpaoa2m2HH0SYKYegtFM6sdr5ZIYzYg6J/MAOoKE+0pExGc4mwSXwActWhTOw5qyAwPIemvuT2lzx2iV028qdP4mLsX7WthDMa47FyvlpnLNrNhtmqispYFm9ij0+tdbOji1+7btismbccKPV8fLdiN8FZZVx7DxfQC5pe/KsLxODhpOVLroZ/KEbCTiwtl4X99ITtHQGmhtSAizYXfuvn5/YhGOSMsKKqwixrFRA7LgwGBHiKUDAQt6UujrRyNkDu98IQN9enAb3zVHJxRTTqowXIuCBX5nT5+j96u0MY/vjPoEsqF89UJBd480bM06Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKYYQ27MTtrrNZha95pQu8ZURoZIIyu3o1V9iakQjNg=;
 b=H1BAMxjxbJKJScmxKwJGxFcdxFe/gnFLXIcpU7F+1Odh6sRhfSxukakAoIlEPebDY2Vhw46joASOhcFfjqgMNuvhx1QSnToRmZNf9LyWEiYAWfFC2NlyFmwj4QEcSCArmwNfVYBrm8WC1Z19Pn3BoysFjfbLeNCP5j1HN7MdyLrcOJjhl+SZ+Moz1AFkNXIsMOo26PmBWI7QnUrewyBCUPSfLij9u0xKpJtvbnJNqgwaMCVNP+18RAq44ByTo4aW3Zc+Yfw+jNzyJgLj7CcC+yYvZO9Kg3FtPLZps89M5EdPkzehCNtDoNaunoq9Y6OdfbuAI6tUtS5RRYZ0v6sR4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKYYQ27MTtrrNZha95pQu8ZURoZIIyu3o1V9iakQjNg=;
 b=KpflFkc8wGQ6rOudhY0VvFGQ2sscBEpnNADD9S1AnkVwguW959bt6KK9hH3TybwA7JpjxRl0yYlkMWrBpEQ+m7w6B6Gu7mve1Xdr8019q7mmUr+BqDw1UFJu4WXrlK3uRuOfsDuFvPgnuDbhlrH+Fe7Vn7WPH+GPK9zlhLImxvC4vYKDl2MkmIFXjL445df0o6bVSh4q+MUvA1PX+gEFK5A9G+bDFdn8Bmesvygqjaqnyab5NeG3GK2oh1tq6qR+Ohy9WDLXNVyrlNaUQgY7/Uwd+/+k87OblqyKMsU5NZVa3kG1GnPROrXCdUI5+ZMdWaOuMHjzftyfAprOcPyKJw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by MA9PR04MB741259.eurprd04.prod.outlook.com (2603:10a6:250:10a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 13:43:18 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 13:43:18 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 11 Nov 2026 21:47:35 +0800
Subject: [PATCH v5 7/7] arm64: dts: imx95: convert eDMA to per-channel
 child nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-edma-iommu-v3-v5-7-2537cebe6ca2@nxp.com>
References: <20261111-edma-iommu-v3-v5-0-2537cebe6ca2@nxp.com>
In-Reply-To: <20261111-edma-iommu-v3-v5-0-2537cebe6ca2@nxp.com>
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
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|MA9PR04MB741259:EE_
X-MS-Office365-Filtering-Correlation-Id: e245eee6-02f3-4a9d-2a64-08df3ff9be0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|1800799024|366016|22082099003|18002099003|921020|11063799006|56012099006|261026140227099003|261028144727099003|261009223027099003|261102123227099003|261022105027099003|261021121427099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	pQBBGGQSltH220mRMbPraX7SJNMZDhyPdongauGmm4JIjWIla4ZQfi2cELFQBCH7D2UwrAq8Vrqd/ijjZttsfSckBlMKWhCeYPgfQr6qLcyQhfNzyoDJXQN26tthZoA9Qs8snpDwvt/ovjyLnnVggjtmQBQwm6jwiNkSMBtHeKrX15X82n1Kcs5CS/PIDQOIdTw1wU/TwqkthoCPiR04RF7rjoVQGqlyLh9r/FLixiO1/f/g7+u3AofUOFXJHU/jVMjNJZoFC5u90vrLVjWytOBsheU1/E6bAO8tiqQkgHL9PJ2ErgghCtWpTQUmjYIfYxqgDduWNHNEWAtshckIgZWlbzaoTS9fWNTt/XEPJBwewoSLzSxTsgATCsoYNLDSwm3ibYoeCSe2vzHI8OVlrmBp2gaRduuA+/pAIDa/upaOS1E0htD+Rl+YFXgaNRWsi8RpF6i9z+PSZQHKifkARSGr+x+l4v+sMDVG/ch4x5ARWRSkKfqBPHY5a5KvX4zfDjndRldpwtHdu4MOzP1pyYFe4bvoGGfTiXz+ElYg6jqQTUZB5rJEblBDNQqg2E5qvgLtgoAVwR/oza9siYKfPMGdT4ky4tM8IGF5G5yP6n/lM58Kd+i24gZcjvDJkHj7TLZy8REBUao3HwiQzg6xEinN9glm2gekM2eIsQHzWh4hUiUVd3ToWNKRMiOPlnhQ82C0oRUSi1gVDEwrGAUahg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(1800799024)(366016)(22082099003)(18002099003)(921020)(11063799006)(56012099006)(261026140227099003)(261028144727099003)(261009223027099003)(261102123227099003)(261022105027099003)(261021121427099003)(261021123027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cE8zcXNrR3RGSExyTXNkbERlMHhybElMZ0MzSDFhRVZQMFNFOUNGbE5QWUdo?=
 =?utf-8?B?NWJiL0kxWHlyREQ2VFZHWEhDN205VVZ0cUp3K3N2QS8xUmxWazZiam5oWWw5?=
 =?utf-8?B?a3doT0lRMU55bHJ1YXJzZUlaK3M1b1AvMFhOQ2Vqa0dFYS9uQmpXQ1RxUCtr?=
 =?utf-8?B?NDNyNk1Rc0diRHA1dEtWZTBRaWo5SUYxVGg1YjdSUEs2TGg2VW9yaHFvdjJq?=
 =?utf-8?B?QUYzQ2grUXp2QkpPTGxYc0hmNHVLMlZDdWxDVys0bTR3SkNNRUtuQVBNWTNt?=
 =?utf-8?B?MEdISDIwMTArRjM3ZUM1TEdaZFB6OWVRMmVQZDdaN2twZFFiZTVWSzBDZ0FQ?=
 =?utf-8?B?dlljUUVJMVl5S09oeXhtTDVwWnFwWDNmUEZBN2Q5U2ZWZG5jNm15d0tYaVkz?=
 =?utf-8?B?TFJnakNnN1V5VmNxRkVtMEgySDB5SWtTQ0JUUUlCU2kxbWZ4Vk8yWDYwZUF5?=
 =?utf-8?B?N292cE1KU2xhbUNTWGxDM25wYnhjL0lrWWhEcXJyWXVjMG1yUFdGN2t6UXpk?=
 =?utf-8?B?cm15TGl3RVU0S3RBNTVIdC8vMGI5NXc4VEVaeWtMTVNMbXlzUnFjdE0wZHpG?=
 =?utf-8?B?MzBTcmRkdFhLVzV4cmZJKzRxWHdTV0hQb0tXNWxZeWlldGg1NXJFQ0k5SzZv?=
 =?utf-8?B?b05QN1Rka09zamNsZWVHRENURVd1cWJraHUyTW9Ga0JwdE40Q05JSmY0bTVL?=
 =?utf-8?B?Ym1tTGdiNS9mS1lEcUVVejlzT3c3WUZXYzR0RWtwOU5QN001ajMzdXc5R3E2?=
 =?utf-8?B?MnVnRHFKNVUzWnFsT0pyclZKcDYvVklaKzcyWDhGSHExMnNRZm00NWZaSzRn?=
 =?utf-8?B?aG5xa0xTSXduVXNHWGFYRFFvQnF6UXR6TVBXVTRjcWptb0lFUjJVekhnS25m?=
 =?utf-8?B?djcrbGI0ZllJQXZOUUVaZkRwd1FpYUYvZlVOVnRMSUJ6Z3BjbXMyM2xva1lG?=
 =?utf-8?B?di9EUGFvL3pCam5lcDBZYncvSUNva1ZtVkRaMXJGR2VNck5tSTdvM0xOZmFD?=
 =?utf-8?B?bEZFejNiWWlHV0xWTVNjeDUxUzJWWkdvUk0zaW1vcWJoY2FDWVV2Rkx3OU9G?=
 =?utf-8?B?QVNxRDRaa1RQNUlkSHNudTkvWmVpS2l3VmpkS04yNVhGNGJYRk91V2VNaC90?=
 =?utf-8?B?WEdIVHZlWVZ1d1JHMmUxK05HVFIxaUhoYXMrUm5ucXZNb2dGbzdEVE44V2cr?=
 =?utf-8?B?UWlrdWZBUklMb2ltdHVvVHFNVmhFNlRDRmpRSWpQQUt2ZHUveERORDNEbmh2?=
 =?utf-8?B?MWdIeVpudnQvWW81QXF5ZjdJcEd3aTNUejRCQk1MZ0NSRUwwalpMTnlqTzZB?=
 =?utf-8?B?ZXRoQzQ0OFpsaks3eTZkbWVXZCt2bUY5bERKSkZFc0xUUjNEek8vajdDM1ha?=
 =?utf-8?B?OVgxc29NdWxrb2ZaMGxqaWozRjZ3aEJ4YlE1UHAxYTFWODFEc041Ykx0dExP?=
 =?utf-8?B?Q25KdDFQa1FiUm8rV1dTdkRiK2xjd2xPNWJhNVp0WGRWbG1Jb28rQ0xYODY0?=
 =?utf-8?B?eWVkSVVJYy93aXNCOFJtaE1sL2syOGlXVG9lcXlZdWJ1RURIcnZTemdUb0wy?=
 =?utf-8?B?K2VxdVlCaHBTNWtHa2VhVDd5ekR2OU5FdEpCWS93ZS9UR2laWUtqeTl6dXZ0?=
 =?utf-8?B?QU93QWRoN29wOWxpcTlXL0I4OWRQcDJ2RjVhbkxrMlJ5SExYbnRXRUlPNktP?=
 =?utf-8?B?NGllcGFmeHNNbXU5MUVQNDdmQStnREJFS0tBRlZVRjh0VXRBRlE1djVoV05o?=
 =?utf-8?B?bWVRY3JWUW16L0RCWldpL29WbmNKQUM1RjBSWWhnYWNvZHU3ekY2NjZvYUZ4?=
 =?utf-8?B?SFI4bnkrd1pWVXV0cUFQQXM2WCtQaFpuTnA1VEgyMFFmbWUvbUJlR1hIZ240?=
 =?utf-8?B?ZDZrbTN4cHBQT0xmNEtvRFk1K3FhZThUQjNSTE1yK05lSjhuQzI2MmVQU2g2?=
 =?utf-8?B?RHFLUkxMUDZHUng3WC80akpBcDFrcVlVNE9oNE9KWFdRSlJTdW5iYzNlaTly?=
 =?utf-8?B?MFVYQmlhaTZibC9Tai9idzNyejNJSlhuTlpyckV5ZVkxVTJEb0F6NnozR2Fr?=
 =?utf-8?B?cXhOS1FjMkxjNjVtaEhEejk3N3kramhma0FweG9hTDd5azRROUtlcjBYNmJF?=
 =?utf-8?B?a05OY2JFRVVPS1ovSDE5NWtjUStPNG1rdUtuYlJlMEJXamt0Mko5OWVrZkJX?=
 =?utf-8?B?YnROTmRpN0Q4czVHMDBBL0VuZUtlQ2Y4bnhNWnJkbWcrbW1TKzhSbzcvaTNZ?=
 =?utf-8?B?SFp2QzJjNUZxOFZSUWRFbm9sUjVaT0VFU0N1VTloUHR2Y1ZKcnZwdVNxWERy?=
 =?utf-8?B?NCtKVlc3V1o5RlExZ0x3bzdvY0lxT1ViYk5HWHV0cmhsRUxiSzZQNXhLa2tD?=
 =?utf-8?Q?18F8ujh9KYzHOIKgYomo/q6Ivl2IBRvACzGGt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e245eee6-02f3-4a9d-2a64-08df3ff9be0d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 13:43:18.0653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5rPhQNVT/RyiiG+BXcYQCEnGEckj2h1FuRYMxO65/HOrRdSY6tWuJqay1p/V+ZZQYYhZHxR0cDVp2Nj0f0JipWyIGUJ5P0C/9Z9g/aOqtssFl/KFeWoFWElcu6LEdjU6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR04MB741259

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
index d20c2498b9aa..64570703ce6c 100644
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

