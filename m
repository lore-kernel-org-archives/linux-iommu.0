Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794469750;
	b=1f/Ep5mNhtpxBV1JtmAiv6MCsOra/1ylBl59xdqxMir7l7UxC2mQI8sodCt2/9wlDIXn
	 9eGJdyyKI1/PNKlbFX6ul8aBFUKQ2IaWyJLhbJ7YG5Wbloh0vQPt8fm0rs7h3DCj1x7ZO
	 IJi+YNwhQ9ocNQ4RSVpnA7yTMvj/f9BKCIXaV7Gs28HBr4riFw5KYUPRZ7awH9Tc+7Y6P
	 DNUQPg5jxurTXcSWTXqX1TjiwmObVuANhuS0yoUzBH7szCS7KKjo77JZSes4MRwcxqdaO
	 EUYUlO7J5wwMniDiObtdISomZTna6XN/duAdFZQ4MTOaC4qIhPVv4DNHlKHjd9/k4Gw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794469750;
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
	bh=/6tNI6Rwlf27/q9h2jpSAWlCuWtiKl3l+PI1lLh6+2A=;
	b=w85kxz+iNcsTN4bdRVXRQN0kPSQOFTAMVGBMXoyVeWaaIcRV+7GQGQ7sFbf58CdCS87Q
	 IWA6+u9okOpm3NP6oI8ezg9ERqh1xVfFl/85h/gndvZoUXEroAxUNrZ8cuHAt2+Q6mHe6
	 eHHFZTdSURVS7UjvPDpdKgB6q+1q3w82ReYZ1goGLYIWuomalmuklK/zBS2qT7j/lE9st
	 zTx9b+7NW+SMsO69z5yBMSGqnm8Vr1xKO5bpJFXo+QqCpacOKudVjC6Zsi2N8Zam9zTZR
	 gBXHOSv6NkGG6/lWWoJweBP/t9J1LbDULzx1AoETXZAtbqG5r+q/a+aFN+n/dY8lvxg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=B9x3igpP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.21
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012021.outbound.protection.outlook.com [52.101.66.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6913760A3820;
	Thu, 12 Nov 2026 07:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6913760A3820
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=B9x3igpP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lgaU9iioCLPVsyxBhC2g1AWsWYESUN464bA6h6TmxHPfUzpRyBJoMPh8uw72NAdWfjd26ylOkDoqaUzc6lmvAHaua8gfoPcU7KmzPgPXwj7yqNtf4tpI493QFWhT5eL2jJSMUmHUTQ9IU3lg/vHe6EKU3lFIis2xKnJWYkMGDe+emHlJ5/Cm400dX+d2pjCA7QkGmyp95pgs78Ad1n5sh9YRO7wPk7fDHXrB10EAbwHRCIG8Gw8giFI9LX5GpztvJxLPnZ+kugPfmR/8kji2RxPVNkgrnuFrNZ43K4YLSsOlTkGgpjRf6dlMJjTxJF5MgOSrXX7k41zWuNULShTARQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6tNI6Rwlf27/q9h2jpSAWlCuWtiKl3l+PI1lLh6+2A=;
 b=J7UXrwLOkP9LrObExHOSL4uCnrrdgZVk3Eust6NkU5pWjaIVE4RINiIJw8eSgBf1VhFj/ohCIscn50myvQ5qLsUzheY5wo60hg4fkB+PYGT2JDU7qnZOFWwKTpuqt/HeBe2KJVZjSAoFjQnEEIYKZpRERktE+7HskOLcWHvF3B7IVccILxuB+VbomqytOP9sa/YJeap6TN321NNohZ49wOozd8Z+fHixYEHBSBt9IW00FkGjp2kaoJU4iJq28iVWO171sGiYirq9X1lfFOFhKh30iPa9nRhnXI8FAABeThfLavkUnJM7xMWyY8cr3evYWPNMaNzQjreeVvyJO7ke8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6tNI6Rwlf27/q9h2jpSAWlCuWtiKl3l+PI1lLh6+2A=;
 b=B9x3igpPwEtAzmYEu2YBiCq8ZgkEnUq7MAfoworG0xkIbSHYVAujPiFOclO/rNd0CgeazpdPFZXgwnlFCYTZpYlD8HVBXOb1qhOFwf4Tpq5BB1bhcuygYuEdqrFFc39iDXL1c9nIsFmjyxgmuehHL7gbej88QjQgZvFFlcC3FeXZRzdXXgLy1s3MGe4kSLYV2rEKD5xQd+2ED+3PiyniKBD0yrHIA7Th4JdUkztzW75DsTX82j1STzYL5mgXcPo8jsOlqgoc5MLbFvw+qjxC1slN2zhtpgZQWk+7DG60zvc/ljTKi+nNVIWB90BZjoOPEFytz3JfU7QxkPxqtzCGQg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DB9PR04MB9645.eurprd04.prod.outlook.com (2603:10a6:10:309::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 07:49:06 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 07:49:05 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 12 Nov 2026 15:53:10 +0800
Subject: [PATCH v6 7/9] dmaengine: fsl-edma: use dmaengine_get_dma_device()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-edma-iommu-v3-v6-7-b038edb8ce6f@nxp.com>
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
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DB9PR04MB9645:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c5c488e-7650-4279-3d88-08df40916d12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|19092799006|23010399003|366016|921020|10067099003|11063799006|56012099006|261021123027099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wltDbr+oxQbipzHTOLQve/PXvQlOn01CwDyyU0P32vghZ8DzmRsgFVMO6MSSdMzOd88EDVZnAGq/yi+ey5ZwmhhpsVfft2EZa+N832cPovGmui2vKmbz7UV9AG1p6mf1B4RE/3Re0PnTC+c6NZCVE4gTTJ+vGMOXM97Rg4FHtbUpFcAPByHoBOfy9LaUNeyFkZv3OcxACVXYPXm4PCzPjiZ0xmxzi9DX8g4CpWbMCFKqQjhUwuGsZoZmkLVTDZXxpaWF+rjQpfPx4hxBXt/KvwHu9QawcoPfQEYVDfPP1UjOzqewm1gqUscH9Rvfl0FWXoi58572HD9CcpXJxr1YajpPhxJ+PTt0Hio2ZqZZiXt+y+KahJvhwkYejBez5KV+x4fx0bzoyMxt97PwMZjds9/1nzTq1OlBnRQD8kckMUuaBWqiENrT8PACmV+ifw2/OoWhHqZPC/myBV8VmN2sVB8LUEkv+AxslbfckM7h3qr79BuJL6sqAuGMUojXub/+MINKRkBCYFS9NQw70Y6GUrK3lj5FQJ/Q3aYfHviYLTxeucRg/+1/ti+9Izq47B1edgak0x+e2r4gyA/AIG/jsB+df+6OWX5kr+jWX+EGJRzD26TcX6N1irkvRxcr895nNaCKtz1Zifcr0epnVnRbkj9YTkeQSwl63QvOv9zaWZK4VpTM81AKN5EqXo7rwRBYSxrfwms0pvBYnVujyTWRww==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(19092799006)(23010399003)(366016)(921020)(10067099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3l0R2lCRlREdkRvdnJNWGNRNEIyWE9iaTNzRFNkeXAwelh6RkZkeDVGQkUv?=
 =?utf-8?B?cU5xWGlhRTBPd3NPY3R0QXZRekZ5SGdSaXcvQXN3c0Y0UWFCNUIvUzNHMmIz?=
 =?utf-8?B?Smt2TlE4NWc4SlJERDdxYWJWSk0vbWhjdUNsWXFpc0hXS2dJMDJ5R0E0blJk?=
 =?utf-8?B?WU1mbENEUDlYdzVTcjBKd2FvT1dOcmlxMDQwOEg4R3lvS3JRbU1mdU8zdXVM?=
 =?utf-8?B?d3MzbmVCR0U0TUcwN2RVN0MyR0hKNTNNRmJCQ3FzcStkUk1MQzZpb3dXajdM?=
 =?utf-8?B?blVONFlmWmdlanJ4dUw0aURDaEttNk9xWE94SUh4VEZKcHN4SWdZN0krZlVl?=
 =?utf-8?B?VkpVRm9IOFhqTlNBNzVWUGUvY1FKYTRaOEFndHM5US83WjYyU0tWeHYxdGtV?=
 =?utf-8?B?RktPOCtiS29FNUQ4Vk1JSy94NkJDYVA2TWlnVXpTNGNVM3Q1WUVkOHFuM2dz?=
 =?utf-8?B?eCthRWdlNVNGTFNleGRrNGo1eGtRL0Q3TWFtUDhQbUhobkJteks3WHlMTmov?=
 =?utf-8?B?N1JWRjNvQWtFSDRRZ1VDd3ZXTXFscElsazN4enVRZHkyRkhmaW5hOGptY28z?=
 =?utf-8?B?RUdKSmI5NDFZemNqWUkreXp2c3lJRjBrcTVOSW9YOVRxZkZpODR4eGpIREZu?=
 =?utf-8?B?aTBaRENXSzdjbjZkNDJSSFRXb3U3elJBeWNlY3BSTEdPcnRLVmZRODJvN3lu?=
 =?utf-8?B?RDEzTXN5OFNsY1B1bUd2QXBhbytucGtudjVRMzJZZ2Q1WkNXNm5VNU93WWIv?=
 =?utf-8?B?aWF6QXFkeVA2NFF4dGFyTklzUktQUzZhVTNnWjFpOW9PK2Fmbk1Qak9URjVU?=
 =?utf-8?B?TTl1clArUCtSS1VMY1BnNkVVYUthUFN1RGxsYUJpRmNxZUxLVzJIbkd0dlJQ?=
 =?utf-8?B?L3lDU2VCeWFtc3VVRFp1Z0FZSGw3UjdUaEoyRFpQZEhDbEVzK0RrbThtWHZw?=
 =?utf-8?B?MDIxcDVabHFiMVViSkRFdGtyNzhjZTlmdVhYbVZvR01VQWw3bVlrek1FVDdj?=
 =?utf-8?B?T0NMK3ZVMW9paHgzZ0kvS0FVa0dtTXlOUUVOREdZVXN2OXhscVd2dkh2VXpI?=
 =?utf-8?B?ekJNdlR3WmhIcGVST05YeWxRNUNySEtZUlJNWXdIQWY1N2ZjYTdub05xcGFR?=
 =?utf-8?B?QmpBRHAxakRiUTMvSFFJRHdKSEZtL3M0NnBXajBhbXdLRGZZc0trL3hzRE1L?=
 =?utf-8?B?RTQ4QnVkUWR2MU1GNnZTbU1oT0ZaVitvSGhnQndxS0g4RlhQT2ZZQUdPY1VG?=
 =?utf-8?B?VUNBSUtHK2IzaEtkc2QyaGw1bEtvbml0MkpPdnhLUXJsVkVWZGVpbHd1aVV6?=
 =?utf-8?B?L1dBN05sSzJ4WDFnNXlsQXN6NU40U1Q5ZVM2S0pjS1FoalR6ZkF4SkJnSDVW?=
 =?utf-8?B?Q09oT0dVSnFSb2RacE5ZcFgvNTVtTWZNY0tKQ2ducDdZYXZRTStKcEYzdUYr?=
 =?utf-8?B?ck15MDQ0SXgrNWJhUWwzL01EQjNJQTI0NTBIK0wxeVR5VWxOdFBHUW16S2Q0?=
 =?utf-8?B?em0xNHpNTzB4QytWTEFoTmI3T1VMWDJmK3JPOWZLRVBsUGRNSHpxeGdnNmFX?=
 =?utf-8?B?cGl3dkM2MUQ3dmNwT0VOTFJCd1g0VGM5aXp6Mzdqa2RCVFdhYm52dlZnVUI1?=
 =?utf-8?B?VS9KejZuYlZLOGhoZ3Q2WlNRVFFTeTJFWEFKSlBsMUFkVVJnNE04T1pQRWRZ?=
 =?utf-8?B?cHpSRXpHTG94V0NwcVFOYlJOZWRVaWRjOStpM2hTc2JPbDIvTVRxSlBERWNv?=
 =?utf-8?B?U2FiUmRaVm9uK2x6Q09YbUQ1Wk5LOHFIaDBDelVoSE5WaXA4OXFLcDVMamRO?=
 =?utf-8?B?S3dJMUY0ejVjVmVlUHI5a1lla3ljaXYwMXZqbUtHU1doTTdIS0xVQ1AwdnJX?=
 =?utf-8?B?dUhQenBsTGlINlNTL2VkUjUzcjh2ZHMxWWtVaUcxaHFsd0FPK2F4Z1drL2Rs?=
 =?utf-8?B?eEVLRG1OTHF4ZFdVbi9LNmFWZTZFd1FSYkxnK2cvWlhCV1J3TWFZWFBPak5F?=
 =?utf-8?B?K0RNeE5heFF5cE9xTFNEbUxxWGlXczRGVXJFWUlseHk3ZjJhS2M4RnV3dUVZ?=
 =?utf-8?B?UzRMR1hoV0U2MnBSTkt5U3BwclFUN0x2cVZFSW9Rdk53djJnSDJBQkRUSmE0?=
 =?utf-8?B?cTZueGI0cXBncjg2M2YzT08xUXhLK3dSMzJPL0lwNENDSS92MThac1J3M1Az?=
 =?utf-8?B?T2QvZm8wMTFTWHlIU0VwRk13Y0xINlU2TVpzZHFWTzgxL1d0TDl0dEdLdVkz?=
 =?utf-8?B?Qkk5aXJlM1czdHh5dEt1YUhVZnNnZHVDTTQ4TVVoeW9vMklSNWptY2wwa1BX?=
 =?utf-8?B?RkdEaEhwaEtBbFJoeHE1dWxKWXY5R1BSOVQrU05icHk3aVJCMlJYSUxHNk9i?=
 =?utf-8?Q?Y2A1prgMLKGg7LTdvQBtxDXtFYOu3e7In3iVv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c5c488e-7650-4279-3d88-08df40916d12
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 07:49:05.5910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yhJPhy4Ykgy2SpnbrZSSumwIm156YeX+irknCqFOHAMniEVLCytFaROqY1psVke27K/heIJIGbcWZCS6TR5KyJq5xqhSlzBX5iOcDCdkS7Gkn0dil6Y+IKE9LgCTG3bm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9645

From: Peng Fan <peng.fan@nxp.com>

Use dmaengine_get_dma_device() instead of chan->device->dev when creating
the TCD pool and when mapping the slave resource. This lets the driver use
the per-channel device once per-channel IOMMU support enables it, without
changing behaviour for existing users.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 513b0f4e5be2..62cd60179bc6 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -310,10 +310,10 @@ int fsl_edma_resume(struct dma_chan *chan)
 
 static void fsl_edma_unprep_slave_dma(struct fsl_edma_chan *fsl_chan)
 {
+	struct device *dev = dmaengine_get_dma_device(&fsl_chan->vchan.chan);
+
 	if (fsl_chan->dma_dir != DMA_NONE)
-		dma_unmap_resource(fsl_chan->vchan.chan.device->dev,
-				   fsl_chan->dma_dev_addr,
-				   fsl_chan->dma_dev_size,
+		dma_unmap_resource(dev, fsl_chan->dma_dev_addr, fsl_chan->dma_dev_size,
 				   fsl_chan->dma_dir, 0);
 	fsl_chan->dma_dir = DMA_NONE;
 }
@@ -321,7 +321,7 @@ static void fsl_edma_unprep_slave_dma(struct fsl_edma_chan *fsl_chan)
 static bool fsl_edma_prep_slave_dma(struct fsl_edma_chan *fsl_chan,
 				    enum dma_transfer_direction dir)
 {
-	struct device *dev = fsl_chan->vchan.chan.device->dev;
+	struct device *dev = dmaengine_get_dma_device(&fsl_chan->vchan.chan);
 	enum dma_data_direction dma_dir;
 	phys_addr_t addr = 0;
 	u32 size = 0;
@@ -1090,7 +1090,7 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_CHCLK)
 		clk_prepare_enable(fsl_chan->clk);
 
-	fsl_chan->tcd_pool = dma_pool_create("tcd_pool", chan->device->dev,
+	fsl_chan->tcd_pool = dma_pool_create("tcd_pool", dmaengine_get_dma_device(chan),
 				fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_TCD64 ?
 				sizeof(struct fsl_edma_hw_tcd64) : sizeof(struct fsl_edma_hw_tcd),
 				32, 0);

-- 
2.34.1

