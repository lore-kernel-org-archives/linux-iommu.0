Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794576176;
	b=nzvCABtnmJmHXyiS5kCqWgmumj0RtZOn3X6pRiUhV0S9Oo0h+SH36kgYRvsaqTgeD903
	 hf7Bq3IJ/HZotannoJ02jWCTh1XIBpc8gn/vRaJCPoiVQxeRc9oBQo0nh4nMcz/FEeo62
	 NpKdYmiI7gJxTM7Y4cxRmcSFX0y7nTjO7tLYYaTfMn9t3i8PCkaghYnZqQmFTIbS3gyEL
	 KU1ntHIYir+WiqndeI0JcpM24p7qlpP8536wN/pn2f9aMUFcPDB7im6tHRYhlSKvlnwOF
	 rtJL5AIh5wPZqYN5SzhsyzVcpPcAX8f/CYOwcVcPMdkj+y/SibnrFXPNdKLwwJyd1Pg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576176;
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
	bh=BJ4chI4rY0MettGyd9PVplgqq1mdaoJpmTg+lFYgINY=;
	b=Mdqc11CPfPgwjHxkiofOe9RXSxUhmCBUJ/BBk0IXzUShNMZvmahxmjHo9TiacJaMQlRF
	 YeZgNA+7rEGYD/hz8K++5vh+iBKBrIaymdafsgTHoL8zSlr4iUiAR9NB1qZ80wSfmZOei
	 xg/NLb6dRLsy+IQGuaSfHGcjNY9TaXhdh4wB4m3vuGYyC+FIQbHoqq7EC4PO+9BRU8nlq
	 Ta7ZIZyhZy9Fh/ftMZI7T4TGh9/fWlrVNpnxdq8FNd1FOzOajnEAubk413v+C+n1SSzdg
	 y3gu3ef06Rz5PwA0ou4AVOBoYaBPC9iH+p33YeD/j6LXuPgRAI4UTt47zGhdT8cADuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=LZIXcgPc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.13
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010013.outbound.protection.outlook.com [52.101.69.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73409606BC2D
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 13:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73409606BC2D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=LZIXcgPc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yRYaCJbHKQ185YbPluy8W72gTYBPm3w7EY2U705JMdDgeZjJQhg6q496Fo96F4hRNbZWPELgmp3adqF99sTYFTYiw7ACoxma7u/l9UTNYGx62df9S8ikynw3eoqjq9vXLaIrd8Epuvpay1G/Dytccq5MUltFA53iVYoVs5kw0epHP3T+1/g+hJH/ejhoqkkm5kUYb0NDwQKTLyZ0J4msPlSUrXqqxLhqTtRpguISkL4GWu4xgXZAu7XTGncr6JW6Pl6u0pJoD72hmjMMb7OTWTdILY6QJKkyPphOz8fzHglJOba6oO6gB0GXIfwpljtW4nh7D0BUvCwgjGTWR0aZPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJ4chI4rY0MettGyd9PVplgqq1mdaoJpmTg+lFYgINY=;
 b=x8+wtgoNap9HijKRSwmMg/BsiNKoxq0cAbUCdSGvEVojbdcejc2AdfL78sH5OyI4H72ePfvgNGw3VnTpExLJOBcjsO/Fo05cYKU1RdTP/lRCmZm9omU+aymBalItU5Zf5i/Kiz1CrGs2AT6WxijotrcLY4wQKLNxjxVPYtedfHpn7QvSlIOapCsTMI1hJqw9zXnYeVSm+K+C27dO4Auqb5MtFNgQLOli0wBxBoWWcHar/nFI9naXE0+RQeTWJNllNt4hiwekTBtGV69dmFrQTz5JEeCJfwC1FlDvTVFcUc4G3OVzz93TARg9oKJGIeRiRAEYOMj8RDGqz+CMrvWrIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJ4chI4rY0MettGyd9PVplgqq1mdaoJpmTg+lFYgINY=;
 b=LZIXcgPcAQ0yE4TSfdVoQnvWX8y9v4+kLOYglyzC9UT5jp7cJM5MM0E0HPGufeU62zJh5mUsH3Pcm2yv5dO/wuAsUh00hSPsVZlOJpr1nzyQbrqZGLctu7t/e0U/OylRE0mqziZznPdW0RTB60lh8gNPxuPRhHAYcd7640uNu9eh0wVbU57ocXFc1CI8vBSOAUEbT4jpY6xkgVVBpcFq9OFSzjGta9upPaiaCuJDEhRyRSL/feIt+LoSC0ryvPVnmtpKu27Im6yveoIqinlMFU6JdV0JuBbdkfSaWxRuD2msvMoPaldXRVjYopP+nbLR5vVBUGt5bXKhwBvLugh+aw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by BR2PR04MB007356.eurprd04.prod.outlook.com (2603:10a6:2c8:6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 13:22:52 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.008; Fri, 13 Nov 2026
 13:22:52 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 13 Nov 2026 21:27:16 +0800
Subject: [PATCH RFC v8 4/9] iommu/arm-smmu-v3: Use a per-domain CD table
 for non-PASID streams
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-b4-smmu-shared-sid-ver8-v8-4-587307a77f3a@nxp.com>
References: <20261113-b4-smmu-shared-sid-ver8-v8-0-587307a77f3a@nxp.com>
In-Reply-To: <20261113-b4-smmu-shared-sid-ver8-v8-0-587307a77f3a@nxp.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Jean-Philippe Brucker <jpb@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Thierry Reding <thierry.reding@kernel.org>, 
 Krishna Reddy <vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: MA5PR01CA0279.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21d::11) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|BR2PR04MB007356:EE_
X-MS-Office365-Filtering-Correlation-Id: de18914b-2d27-458a-fc84-08df41893842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|376014|23010399003|1800799024|18002099003|22082099003|6133799003|921020|11063799006|261102123227099003|261026140227099003|261028144727099003|261026121527099003|261022075727099003|261022105027099003|261021121427099003|56012099006|261021123027099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	hLBucdjsjyRJGd9dCDuW8/thBmjOJX6dBDKlNzQxcfi0Zgb2UKjiejvnZith2LE5XMr4RF0Z+B/P1JtN9TNcpFYSdZRV4XktzwRW5yIz3bGRvUxCmkUrIlrSKbobwbvyuqbrCvB5fC0hrF9ikGq1XZySfjNDlYVVqcv1ltStiTnYY0nyDj7O/dnO9yre9EnHF0g1LZHwPJCUETSelarhIfi4M3x9CTgVGFDsxUF+v3PNwAmy/5B69n217RB+3OPBHoeMYl1oPB9cZ/w5SVyGtMexYtEYNB+Y+0o9t3uSf5kQktw9K4RMMYUO+e+cOsxHHP7sbBpuVDCLEIitn/Nk9tpajCdbK9YgmrdI9BbDgTj9xWwgxnu/9jwboxIpNqPKSmS1pXf3Plo27TM2JAMAHKNg7R8rk/nDDmXdPP5K0JJx5UPlBin23UsU80TUBQZYZtCWmjYRPM7spgXcz1qUknKVsXxj6QcSUEJKhdi5R2Fy+dqmMeHEQryq23AT6VJlgtMQz1f0AwgDT+XZG+k2v2xLKGMUvddgKrGU3fcgplQJAIh+W59ZU734v/fyCrzd4fvDlyBZUkdXknNgo1s+juuKr897Kuf8xxa2+866OgKdlbcg4yC9B00QGOKQoZDgKhftYARXlfEK7v1bmiXjOesn/Og0PB3vOHvEl1VERtgqXzliHwsL4ecz7aTaJ38VoqYzSRUmvx3YWY8j1CUpKQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(6133799003)(921020)(11063799006)(261102123227099003)(261026140227099003)(261028144727099003)(261026121527099003)(261022075727099003)(261022105027099003)(261021121427099003)(56012099006)(261021123027099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnV2VHFVd01FcVRKSGZ2WXd2cTJMT01Bb1BMU1JWakk5Y2JIVFBMaEVPZDZo?=
 =?utf-8?B?Q3YrVjV1M0xIbVlndUVuekJjbUtXMnFwZXJrMmNxclg3YzFWL29vaVBQV3BG?=
 =?utf-8?B?S3BVM2lnM1pTZzRxajNtT2RmWDhENFJpYkNuNEFCT3MrbXRYTXIwZy8wM1J0?=
 =?utf-8?B?UmRtVkxSYmJPb3VZTlY5eGNUVFJ6VUVVY1VzRTZqZVdTa0pkeWFXazlqeTJk?=
 =?utf-8?B?WVkwSnYraFBEL1M5eTY5RDFDbCtlc2dMNFB5M0JkN1FjSkowSVRPL3dpOXYr?=
 =?utf-8?B?QzVIS2xwOHJJKzhNcXRkQVRXWW9HMVQvZFNwQ0JKaDQzYlFGaDB6RlR4MWVJ?=
 =?utf-8?B?SVlvTzl1SGM0MlF6R1Y5M2N4dnhPd1B3aVNSWnhEVHdDS1NrLzEwOE4yM2ly?=
 =?utf-8?B?a3prellqK05DbmhPZ0NjTnVQWTdsZ0NRNkl3V0VxQWl4QjBSVVNnNlhCSzMw?=
 =?utf-8?B?ZVJvZmdXZ3A4eEJ0Z3ZZWW9yekgvTlk0TjU5TVZyL2h3a1FyTmU0K2c5Rnli?=
 =?utf-8?B?UXZIVm1OdXd3eGErWXRpZlFJUWVhQ0t3WFRmWjZGK0pXVU9JZHpBKzhmM292?=
 =?utf-8?B?SjNjTXNOSDlNY25mbjhaaGhCZjlYY0FwQ3Z0c2ttM0NjaW1NT25jeXAydDRy?=
 =?utf-8?B?aDNOcUtEaXUxcTkrSlp1TEo5Nk4vSDJvOEc0a09ld0RTb3ZNdkZvUmZZeEtW?=
 =?utf-8?B?ckU4bVozdGZDb0Y3ZGYvZ1h6RzM3R25YTEltSWxCNjd3Q29ZSDNWS1VKQjlY?=
 =?utf-8?B?czdqMjZCVEpobHcvcU83V1ZxOXloK3dXWC9aMUV3aFB5SFFZZlVwVjUrY0hl?=
 =?utf-8?B?aTVVOGFNdHVPMVloYllSSTUvWjgyMlRNYmRpNE5LczZyTnZuRzdFN1gyWEhL?=
 =?utf-8?B?bG9PTDFtT0EwS0d3MmpJdnIzKzhQWE02aG5XMG9Nc1I0UDNCN3l6WCtTTS9j?=
 =?utf-8?B?UWR1VDhDSm1GUEFnSnd1ZkFGcjNhSkVPZEozMzZDYmhTS1poNUJOUXBaY0dP?=
 =?utf-8?B?UFdqOGhrOGtLSVBzamFtY2Jjblg4WXVwWWc4cXFYSGtiNDVpYWUwNVBhMlpE?=
 =?utf-8?B?VG04L1d5ZGc5M2NiR0V0WmN4NE9CNnNFcXBlUllDeGhmS1lRdk0waWIwMzV0?=
 =?utf-8?B?MnAxRXpBRExvaHhOWHZ3MCtidHFOUmRhVGdCN2gzT3JnUzZ4ZTVhNVpkRmMz?=
 =?utf-8?B?dUZTMjZrazdRZWRlK2tTUkp3bTUvU3VkVHhVUXd1d3AzS2Q5ZndhWDgyS3Qz?=
 =?utf-8?B?UEg3QmFIUVlrT1ZrYlVxWmFkRTNhdmNkQlg4MUpHYThwcGdvNGU5cEtrTHBH?=
 =?utf-8?B?MDZIRnl5MlFMZVBQQmRjWFVCTEFBdTBDRHlaUXY0dyswRUlCY1Z5aXhFK2NM?=
 =?utf-8?B?NE1MUlcvY1p0amhmUnJneEw3NFgvWTNvNzVjdmsyWk1RY2JQd2RFd1d5YVZU?=
 =?utf-8?B?d0RNSk1XbS9GSG9uNU9JSkVwMnowbFdxWnY2RTcwWWJpbDlDM1grTVhCR3FO?=
 =?utf-8?B?WU5XOG9UMFMzVTlRYjdXK1JVV2FqdHZJRUpieGJST09PWkh4dFhpRXRnTE1P?=
 =?utf-8?B?a3ZackpiSnBqeWh1aDZ6N3ZqQm56WHpVNzFWTUFGZzVUQnBDL0dOMmxLSUUx?=
 =?utf-8?B?QW8wN2hrLy9zUnFmaUhqNTlIRjBxUXVFOUg4aS9vdEo0VVdUUUNPZmZJblF4?=
 =?utf-8?B?dFZkSmxpQTBqcTJWUWRaR1hnYVo5cWJiVCtDVW1Bd2Nua0x3U3doU09CcWZ3?=
 =?utf-8?B?YnE4T1Blcm9KSElUYlZJakVLc1JTV0JvMFFQaXFiOUZER2d3NTNQRDRsN2ZH?=
 =?utf-8?B?aktiVGlwL0tqR1ZwYUlhYmhiYTloam1VZWREK1RkWTN6UU9DMmdNUDJEKy9W?=
 =?utf-8?B?WEJGanhJS2ZXUXMwZnZQTUZObHFrY3RTSDlJbjg0aDVGQjZOVVpxNm1IRWha?=
 =?utf-8?B?bHNMTGRNZnB5US9rMDVaZFVZMUF4NXhITXdYaWZEeDNWdmdVMkdxM3QwTytC?=
 =?utf-8?B?aHQrWk1ZUDFrRHM0djl4OVZ2S2RGQkJJVGNTcVhVNHNzK1pwS3pFcVA3TlFn?=
 =?utf-8?B?U3NqSXZjZ0pZMGhUOGtpZU9mMTNyV3JnMTdOcWdQc21Fd1IwaW1LdGVRRVVy?=
 =?utf-8?B?MHRMOERkZjY5eGhnT2c1L1JaNEhXVG5wRnRzRmJTMVYvQld6dUcwSGttOTdZ?=
 =?utf-8?B?UUx2N20vSHlMVjRhRS9DS0hFdGExRktCemhoSkFwd3lvM241ZnF5cjlwY3pv?=
 =?utf-8?B?bldHY3UzZkJ1ZUxzZ0RqdGFHNExTRjI4SWlXOFhkV3pHMi9MZTBGYU1BdEt1?=
 =?utf-8?B?eGVBckxnVnZlanozSkNMRENJNHJOLy9KS3hQTHI5VEQ2L2twbEhoY2xwNERM?=
 =?utf-8?Q?bce/kcppS8q/0xm+o+nfKR8Fstf/geuK+9nvr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de18914b-2d27-458a-fc84-08df41893842
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 13:22:52.4035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T7G4gW7x1JZGmxYGSLv0opXEax/P9iFSXuiprFUUceTBS69Pvkf77b6Kj3KdCvuzAw31oUDpurihPLN+9HrHtZ9Sy9+FF++QtBFV1WpE1vMS6Fs3ZVx56J6+VhnYMlG6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PR04MB007356

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

Allocate CD[0] as part of the private CD table allocation and track
whether the STE actually walks the private table in in_ste. This keeps a
failed L2 allocation from leaving a partially allocated table behind, and
lets teardown skip redundant STE rewrites.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 244 ++++++++++++++++++++++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   8 +
 2 files changed, 202 insertions(+), 50 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b24a4684202e..091119e584ed 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -123,6 +123,8 @@ static const char * const event_class_str[] = {
 };
 
 static int arm_smmu_master_alloc_cd_tables(struct arm_smmu_master *master);
+static void arm_smmu_free_cd_tables(struct arm_smmu_device *smmu,
+				    struct arm_smmu_ctx_desc_cfg *cd_table);
 static bool arm_smmu_ats_supported(struct arm_smmu_master *master);
 
 static void parse_driver_options(struct arm_smmu_device *smmu)
@@ -1568,11 +1570,31 @@ struct arm_smmu_cd *arm_smmu_master_get_cd_ptr(struct arm_smmu_master *master,
 	return arm_smmu_get_cd_ptr(&master->cd_table, ssid);
 }
 
+static int arm_smmu_alloc_cd_ptr_l2(struct arm_smmu_master *master, u32 ssid)
+{
+	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
+	unsigned int idx = arm_smmu_cdtab_l1_idx(ssid);
+	struct arm_smmu_cdtab_l2 **l2ptr = &cd_table->l2.l2ptrs[idx];
+	dma_addr_t l2ptr_dma;
+
+	if (*l2ptr)
+		return 0;
+
+	*l2ptr = dma_alloc_coherent(master->smmu->dev, sizeof(**l2ptr),
+				    &l2ptr_dma, GFP_KERNEL);
+	if (!*l2ptr)
+		return -ENOMEM;
+
+	arm_smmu_write_cd_l1_desc(&cd_table->l2.l1tab[idx], l2ptr_dma);
+	/* An invalid L1CD can be cached */
+	arm_smmu_sync_cd(master, ssid, false);
+	return 0;
+}
+
 static struct arm_smmu_cd *arm_smmu_alloc_cd_ptr(struct arm_smmu_master *master,
 						 u32 ssid)
 {
 	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
-	struct arm_smmu_device *smmu = master->smmu;
 
 	might_sleep();
 	iommu_group_mutex_assert(master->dev);
@@ -1582,24 +1604,10 @@ static struct arm_smmu_cd *arm_smmu_alloc_cd_ptr(struct arm_smmu_master *master,
 			return NULL;
 	}
 
-	if (cd_table->s1fmt == STRTAB_STE_0_S1FMT_64K_L2) {
-		unsigned int idx = arm_smmu_cdtab_l1_idx(ssid);
-		struct arm_smmu_cdtab_l2 **l2ptr = &cd_table->l2.l2ptrs[idx];
-
-		if (!*l2ptr) {
-			dma_addr_t l2ptr_dma;
-
-			*l2ptr = dma_alloc_coherent(smmu->dev, sizeof(**l2ptr),
-						    &l2ptr_dma, GFP_KERNEL);
-			if (!*l2ptr)
-				return NULL;
+	if (cd_table->s1fmt == STRTAB_STE_0_S1FMT_64K_L2 &&
+	    arm_smmu_alloc_cd_ptr_l2(master, ssid))
+		return NULL;
 
-			arm_smmu_write_cd_l1_desc(&cd_table->l2.l1tab[idx],
-						  l2ptr_dma);
-			/* An invalid L1CD can be cached */
-			arm_smmu_sync_cd(master, ssid, false);
-		}
-	}
 	return arm_smmu_get_cd_ptr(cd_table, ssid);
 }
 
@@ -1793,9 +1801,22 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_device *smmu,
 
 static int arm_smmu_master_alloc_cd_tables(struct arm_smmu_master *master)
 {
-	return arm_smmu_alloc_cd_tables(master->smmu, &master->cd_table,
-					master->ssid_bits,
-					master->ats_always_on);
+	int ret;
+
+	ret = arm_smmu_alloc_cd_tables(master->smmu, &master->cd_table,
+				       master->ssid_bits,
+				       master->ats_always_on);
+	if (ret)
+		return ret;
+
+	if (master->cd_table.s1fmt == STRTAB_STE_0_S1FMT_64K_L2) {
+		ret = arm_smmu_alloc_cd_ptr_l2(master, IOMMU_NO_PASID);
+		if (ret) {
+			arm_smmu_free_cd_tables(master->smmu, &master->cd_table);
+			memset(&master->cd_table, 0, sizeof(master->cd_table));
+		}
+	}
+	return ret;
 }
 
 static void arm_smmu_free_cd_tables(struct arm_smmu_device *smmu,
@@ -1830,6 +1851,12 @@ static void arm_smmu_free_cd_tables(struct arm_smmu_device *smmu,
 	}
 }
 
+static int arm_smmu_domain_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
+{
+	return arm_smmu_alloc_cd_tables(smmu_domain->smmu,
+					&smmu_domain->cd_table, 0, false);
+}
+
 /* Stream table manipulation functions */
 static void arm_smmu_write_strtab_l1_desc(struct arm_smmu_strtab_l1 *dst,
 					  dma_addr_t l2ptr_dma)
@@ -3042,6 +3069,9 @@ static void arm_smmu_domain_free_paging(struct iommu_domain *domain)
 		mutex_lock(&arm_smmu_asid_lock);
 		xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
 		mutex_unlock(&arm_smmu_asid_lock);
+
+		arm_smmu_free_cd_tables(smmu_domain->smmu,
+					&smmu_domain->cd_table);
 	} else {
 		struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
 		if (cfg->vmid)
@@ -3133,6 +3163,15 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
 	if (!pgtbl_ops)
 		return -ENOMEM;
 
+	smmu_domain->smmu = smmu;
+	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
+		ret = arm_smmu_domain_alloc_cd_tables(smmu_domain);
+		if (ret) {
+			free_io_pgtable_ops(pgtbl_ops);
+			return ret;
+		}
+	}
+
 	smmu_domain->domain.pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
 	smmu_domain->tgsz_lg2 = __ffs(pgtbl_cfg.pgsize_bitmap);
 	smmu_domain->domain.geometry.aperture_end = (1UL << pgtbl_cfg.ias) - 1;
@@ -3142,12 +3181,14 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
 
 	ret = finalise_stage_fn(smmu, smmu_domain);
 	if (ret < 0) {
+		if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1)
+			arm_smmu_free_cd_tables(smmu_domain->smmu,
+						&smmu_domain->cd_table);
 		free_io_pgtable_ops(pgtbl_ops);
 		return ret;
 	}
 
 	smmu_domain->pgtbl_ops = pgtbl_ops;
-	smmu_domain->smmu = smmu;
 	return 0;
 }
 
@@ -3171,12 +3212,17 @@ void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 {
 	int i, j;
 	struct arm_smmu_device *smmu = master->smmu;
+	u64 ste = le64_to_cpu(target->data[0]);
 
 	master->cd_table.in_ste =
-		FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(target->data[0])) ==
-		STRTAB_STE_0_CFG_S1_TRANS;
+		FIELD_GET(STRTAB_STE_0_CFG, ste) ==
+			STRTAB_STE_0_CFG_S1_TRANS &&
+		(ste & STRTAB_STE_0_S1CTXPTR_MASK) ==
+			(master->cd_table.cdtab_dma &
+			 STRTAB_STE_0_S1CTXPTR_MASK);
 	master->ste_ats_enabled =
-		FIELD_GET(STRTAB_STE_1_EATS, le64_to_cpu(target->data[1])) ==
+		FIELD_GET(STRTAB_STE_1_EATS,
+			  le64_to_cpu(target->data[1])) ==
 		STRTAB_STE_1_EATS_TRANS;
 
 	for (i = 0; i < master->num_streams; ++i) {
@@ -3827,6 +3873,20 @@ void arm_smmu_attach_commit(struct arm_smmu_attach_state *state)
 	master->ats_enabled = state->ats_enabled;
 }
 
+static bool arm_smmu_master_needs_private_cdtab(struct arm_smmu_master *master)
+{
+	/* ATS-always-on needs S1DSS/EATS, which requires a private CD table */
+	if (master->ats_always_on)
+		return true;
+
+	/* CD.S is a per-CD property and cannot be shared with terminating devices */
+	if (master->stall_enabled)
+		return true;
+
+	/* PASID CDs live in the private table */
+	return arm_smmu_ssids_in_use(&master->cd_table);
+}
+
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev,
 			       struct iommu_domain *old_domain)
 {
@@ -3840,6 +3900,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev,
 		.ssid = IOMMU_NO_PASID,
 	};
 	struct arm_smmu_master *master;
+	struct arm_smmu_ctx_desc_cfg *cd_table = NULL;
 	struct arm_smmu_cd *cdptr;
 
 	if (!fwspec)
@@ -3852,11 +3913,25 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev,
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
+		if (arm_smmu_master_needs_private_cdtab(master)) {
+			cd_table = &master->cd_table;
+			cdptr = arm_smmu_alloc_cd_ptr(master, IOMMU_NO_PASID);
+		} else {
+			cd_table = &smmu_domain->cd_table;
+			cdptr = arm_smmu_get_cd_ptr(cd_table, IOMMU_NO_PASID);
+		}
 		if (!cdptr)
 			return -ENOMEM;
-	} else if (arm_smmu_ssids_in_use(&master->cd_table))
+	} else if (arm_smmu_ssids_in_use(&master->cd_table)) {
 		return -EBUSY;
+	}
 
 	/*
 	 * Prevent arm_smmu_share_asid() from trying to change the ASID
@@ -3879,7 +3954,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev,
 		arm_smmu_make_s1_cd(&target_cd, master, smmu_domain);
 		arm_smmu_write_cd_entry(master, IOMMU_NO_PASID, cdptr,
 					&target_cd);
-		arm_smmu_make_cdtable_ste(&target, master, &master->cd_table,
+		arm_smmu_make_cdtable_ste(&target, master, cd_table,
 					  state.ats_enabled,
 					  STRTAB_STE_1_S1DSS_SSID0);
 		arm_smmu_install_ste_for_dev(master, &target);
@@ -3930,22 +4005,33 @@ static void arm_smmu_update_ste(struct arm_smmu_master *master,
 				struct iommu_domain *sid_domain,
 				bool ats_enabled)
 {
-	unsigned int s1dss = STRTAB_STE_1_S1DSS_TERMINATE;
+	unsigned int s1dss;
 	struct arm_smmu_ste ste;
 
-	if (master->cd_table.in_ste && master->ste_ats_enabled == ats_enabled)
+	/*
+	 * A repeat PASID attach leaves the STE on the private table with the
+	 * same S1DSS/EATS. arm_smmu_write_ste() would otherwise issue a
+	 * redundant CMD_PREFETCH_CFG for every stream.
+	 */
+	if (master->cd_table.in_ste &&
+	    master->ste_ats_enabled == ats_enabled)
 		return;
 
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
@@ -3963,7 +4049,8 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
 		.ssid = pasid,
 		.old_domain = old,
 	};
-	struct arm_smmu_cd *cdptr;
+	struct arm_smmu_cd *cdptr, *cd0ptr = NULL;
+	bool first;
 	int ret;
 
 	/* The core code validates pasid */
@@ -3971,15 +4058,23 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
 	if (smmu_domain->smmu != master->smmu)
 		return -EINVAL;
 
-	if (!master->cd_table.in_ste &&
+	if (!((sid_domain->type & __IOMMU_DOMAIN_PAGING) &&
+	      to_smmu_domain(sid_domain)->stage == ARM_SMMU_DOMAIN_S1) &&
 	    sid_domain->type != IOMMU_DOMAIN_IDENTITY &&
 	    sid_domain->type != IOMMU_DOMAIN_BLOCKED)
 		return -EINVAL;
 
+	first = !arm_smmu_ssids_in_use(&master->cd_table);
 	cdptr = arm_smmu_alloc_cd_ptr(master, pasid);
 	if (!cdptr)
 		return -ENOMEM;
 
+	if (first) {
+		cd0ptr = arm_smmu_master_get_cd_ptr(master, IOMMU_NO_PASID);
+		if (WARN_ON(!cd0ptr))
+			return -ENXIO;
+	}
+
 	mutex_lock(&arm_smmu_asid_lock);
 	ret = arm_smmu_attach_prepare(&state, &smmu_domain->domain);
 	if (ret) {
@@ -3995,7 +4090,30 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
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
+
 	arm_smmu_update_ste(master, sid_domain, state.ats_enabled);
 
 	arm_smmu_attach_commit(&state);
@@ -4015,35 +4133,61 @@ static int arm_smmu_blocking_set_dev_pasid(struct iommu_domain *new_domain,
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
+	 * the RID domain's CD table (S1) or to the native bypass/abort STE
+	 * (identity/blocked). Do not call attach_dev() for an S1 paging domain:
+	 * this is a teardown path where allocation failures cannot be
+	 * propagated. The private CD table is kept allocated for reuse and
+	 * freed when the device goes away.
 	 */
 	if (!arm_smmu_ssids_in_use(&master->cd_table)) {
 		struct iommu_domain *sid_domain =
 			iommu_driver_get_domain_for_dev(master->dev);
-		bool ats_always_on = master->ats_always_on &&
-				     sid_domain->type != IOMMU_DOMAIN_BLOCKED;
-		bool downgrade = sid_domain->type == IOMMU_DOMAIN_IDENTITY ||
-				 sid_domain->type == IOMMU_DOMAIN_BLOCKED;
 
-		if (!ats_always_on && downgrade)
-			sid_domain->ops->attach_dev(sid_domain, dev,
-						    sid_domain);
+		if (!master->ats_always_on ||
+		    sid_domain->type == IOMMU_DOMAIN_BLOCKED) {
+			if ((sid_domain->type & __IOMMU_DOMAIN_PAGING) &&
+			    to_smmu_domain(sid_domain)->stage ==
+				    ARM_SMMU_DOMAIN_S1) {
+				struct arm_smmu_ste ste;
+				struct arm_smmu_domain *sid_smmu_domain =
+					to_smmu_domain(sid_domain);
+
+				mutex_lock(&arm_smmu_asid_lock);
+				arm_smmu_make_cdtable_ste(
+					&ste, master, &sid_smmu_domain->cd_table,
+					master->ats_enabled,
+					STRTAB_STE_1_S1DSS_SSID0);
+				arm_smmu_install_ste_for_dev(master, &ste);
+				mutex_unlock(&arm_smmu_asid_lock);
+			} else if (sid_domain->type == IOMMU_DOMAIN_IDENTITY ||
+				   sid_domain->type == IOMMU_DOMAIN_BLOCKED) {
+				ret = sid_domain->ops->attach_dev(sid_domain, dev,
+								  sid_domain);
+			}
+		}
 	}
-	return 0;
+	return ret;
 }
 
 static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index b02163a48c97..90ba843989bb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -879,6 +879,7 @@ struct arm_smmu_ctx_desc_cfg {
 	};
 	dma_addr_t			cdtab_dma;
 	unsigned int			used_ssids;
+	/* The STE walks this private CD table */
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

