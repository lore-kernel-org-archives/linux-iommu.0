Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793718898;
	b=qB+SpRRC6qwYQiALycEi1SjVyifb56xw5N3PM2USqdDI80ci8qcDU1xqXnKGSUo2uEqd
	 mdY+eqa5LbB7cuFPvz6AaEtD2bGp0XQerhdUeUuZ7cVs4qncD1W4rkwVehrYa9IMQSQE4
	 eUVtDb0bNzqX4pCSzN7LLBCVL8VVcts3xZ2lIAWbsc4xSU4c7qbhcdcASbAaRqdzBPgy8
	 mIKoa3nkqiUhvXPRzFiNzftA3c5yc6XgwN5y+90up/E+OAk0leCj8aLY7W0IPuyRkYEfZ
	 QQBFtEdS6lxVRUNipADrgML8qNQfVDZICPwGqKRpLSpOi8MyGfesIsp7asu4KvGCdzQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718898;
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
	bh=29etbTaJ8ch6PrSb7TnY0UkwanMNTot2XX7ZzJ+4U7w=;
	b=maQFhXIr1bOYLvk7LOEMpks66pW5i6SVnc+hqA0sKWY+ON9SH1mA8W5/fLE+ONzbUzbI
	 ZGUneToJQADWLkwiw3ANtFsEKweJRFcUlSE230oszsDsA6pPvnPaofYci2TQbH2I28484
	 CTIAVMJL+GJ5VgAUozSqVX0QxObEP/4FKP6Bfv7EcBFOdLfW9ddCXgW/AxFAusVEt7Xm0
	 c9h+rittv0IZYalg49IFx+x6XfmEsPybEC8yOWgSlvWj+OoETuRkUMlC7XARiZGVb4VC1
	 quYORLe9niABu43Dvptd5VGfdwnLzbSC31BtKTgATLgJHivoCX4m8OVxn9JugQvHK6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=WV6KDQIy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.19
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013019.outbound.protection.outlook.com [40.107.159.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60181606F607;
	Tue,  3 Nov 2026 15:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60181606F607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=WV6KDQIy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fy7KS5CyCiK65Gy1Et6kLCOOxTGAQ3MYBLrHCtw+e1nXOmX/y+NG3DmtOhuWNdJ11/+1u8fJT/86buD5BfKOmc9Ql9Pz5XMTtxlLCoqsdM2p58HHMTIUq18rCpDlxTQT77tm5JbQlyaOf5HPVHN07M8glbNJ2WKzwmB7sBZpX07t/L2OcJ5gk5NorVP59WNlPnGBgclP9KrgZmj4JXt7mYUxZ1NeMCCuOpFjfQ8N7sCAOWZ1+avt+S6sSfPQUiUtAbZnc1JtTg8NDxfRoBG8YnRt2lTNf3ktsq6WefqXdnhGitzl3dvBvC3nHb4QQJbfbt8Gp21j3+DKjOMZyB8qkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29etbTaJ8ch6PrSb7TnY0UkwanMNTot2XX7ZzJ+4U7w=;
 b=b3J0kmg4nTCXhWVWZ2+9oOr56snUhzoaWf88Y/dACdBTLPA+/iERPD8AofPKGoPpmN5nxiH4HtjmYLshhbqgAGFc/eUn1gCSqasZtuvlYNGdnTgryZHKYG2noNvPrIa2DxNW31bXlQBEQmZGv4TIJN+pxz3BJH+THGjCeA6GbRFPRc4XQ7XB3zTE9wYg6cmB791UWlc62WqYcIZhHoezVU3njEEdVk6ecOn6Rk+V0EXe1KS1BlxxJmDYN++4XRTYz/sLB9ShdnV+zj6yjKUOmk0AJR7wELRHqan8WjCS6+HUvNIW60n8M9Lhld8tHPwWOJ4iZqJ2N+Uu67sDxIoR5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29etbTaJ8ch6PrSb7TnY0UkwanMNTot2XX7ZzJ+4U7w=;
 b=WV6KDQIyXjWu5YQ+jSfP73tp/pc+n2aKmAGpuyuP6r+zQyP+QvLZ5PlmkUrcrggW8uDdpfBiGAtX1KX9IGdMEdc5K5u6qIStQKRbNjf8M60r7UfVcc+og1YIdY4SPPdj//MHzMnsPqJxj1LWkzcUUavpSzn6bIbbFytu64+ohrdCryWXGZ82t6OV9Cf0RYIdPmpd6MHZ0gLkwjMVOwvqUk3ryJe5YNRzrbYgvy+VHReBYGSySxnUvwGhIlbGd7grMIq7NqGBx63VWIBJwVCrIiBts0cIEVLB2w2f5cn8mE+n7aX1piInfEkJmxjHGEvBbktc+CmsWdBtCaiRmrTraA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AS8PR04MB8037.eurprd04.prod.outlook.com (2603:10a6:20b:2ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 15:14:53 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 15:14:53 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Nov 2026 23:19:03 +0800
Subject: [PATCH v4 6/7] dmaengine: fsl-edma: support per-channel DT child
 nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-edma-iommu-v3-v4-6-470415d418c5@Example.Com>
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
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AS8PR04MB8037:EE_
X-MS-Office365-Filtering-Correlation-Id: eab625ed-352b-43ad-da59-08df39bd3653
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|19092799006|921020|261026140227099003|56012099006|11063799006|261009223027099003|261028144727099003|261022105027099003|261021123027099003|261021121427099003|261022075727099003|261026121527099003|10067099003|18002099003|22082099003|261102123227099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	aYM0IoQgVmpmJWyzl3XLJRERPZAB/BwdFkfALPhIoyzwzvYupzXFFw1jYeXEiRBjgcxfR7xzP3aVCpnH6NVrPE6qUsdFpu0PaJyleHVe1mWquZySZUsKDwNVHhufob3ZkYv5YPEODy3l+k0vnQ2yhsDHj0yBcD839DcbIJ6AptV1w7kD5BIWaeFSN6Gnd0On4u/0DNEmN/JyG/uUpnFz+g/pIIllEq3yem3c6ULDzP70KGgI0ZD/RjH3mm0RUeUeiHjo1D5T5SlvzwnSZFIOuHmMteNlzrKLx7r1oCgKYpZv1BBFRjfi/9ZJwjkm3Z0AaU4iP9h79U2invuWK5vhs6ILPGFOw1aZsbWJawQPhIFHOEb6gExLFKaSvsU2+t+QirJE27yQQZHZWb4TvK7bjlpU4LpTB5eQdPFvlguctay6Oy7pPQUeFH8RlcvBozm5xkhkFOvRopHaS2RiCZWv5CHzTMwLljRP0gdzP+IqOpajSsOZAFpzv9/ApLAKsNDpobY+iNiKMleTqnkEYxshSAvJZ20Q1cla1tbpbJhegFLZ2jc+ukSfPm353vPx5w4eg7Q1r9tenJ/IxhqRtKV20V0NulV+HhIt7PTVJv1+Xb0bhy0DU0HJOHt1eDaAFii2SPgcYX9Q0NTEKf3Ka8q94Hwe1XtnDOajzDm95NpGSmfnG7QZDF84VFxU7IIGgu4VkAmP2Mr9mRNuuMoNx5CJrw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(19092799006)(921020)(261026140227099003)(56012099006)(11063799006)(261009223027099003)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261022075727099003)(261026121527099003)(10067099003)(18002099003)(22082099003)(261102123227099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnhEUVZ1cWdNazArdDBnVDhhcXhORlZPaEU2Q1NSNHJ0TVdRYmVIMVQ5OVdv?=
 =?utf-8?B?eHFGS0xZL0lua0Y2bXRlZDFLb2c1a2FldzlYMnE0WmdyeWVDbjBBelVPSlRU?=
 =?utf-8?B?eHQvS01sMWFVb3dTS3YvN0Q3L3U4dWN4TDF0RnJRbGFZa1Y3dFF5RFJjZGgz?=
 =?utf-8?B?MklYUHhGWXU0V1dkRlh2bU1odWpHbWtNM0o0bHJpNFFyQnA1Qnk1T1NSUjR5?=
 =?utf-8?B?RzFTbkw5VDEyRHZKY3FjRDA5YkVnZTRiZ3F1dkNXQkhUVXhVQjRIQXkvWERK?=
 =?utf-8?B?RCt4c3Zqa2NDb1krelh1bUNHSWhDY0o1ZTJqalViMEswY1MwQ2pGbExqRmRj?=
 =?utf-8?B?cFkzKzQraHU1NXVBaGhmUDBiU0pCOGtDbzR5WXB4eDNCWFZBaUdnbDZTangr?=
 =?utf-8?B?c3I0ZzAvaXUxTEZiOEtWY3lZdWxxcCtDQ05DYnlWM1NQd0ZvN2MvQmN4MWlx?=
 =?utf-8?B?T1llNk9EUDA5dGlPOXJnSTNPREg0aUdScTAyWDUyZDI1QzdUYTZiNGJ4eGJK?=
 =?utf-8?B?WWx6YkRYL3JwVFVjOHVKK0tMLy9pNVZJSkFZb282RUtnUlFYbldHNnpadXNz?=
 =?utf-8?B?cXdxbDNtRGRKOUQ1SEcrak9SbUU0azArVDlhbmRlYVJ3ZHlwcGQ3ZE9UUVdY?=
 =?utf-8?B?ekRJMmxYUG1IWWpMQWRNbVpadUdjTWNYZ3B6VnpJMllkKytFOHJaZGJRZlhw?=
 =?utf-8?B?OEtPd3kyRXBnVUNzc1BTZzF4SnorZlUxQTlGQzZiTmViZFNuV2pBWlZpRmc4?=
 =?utf-8?B?YWpIWmlDZlpzazVtcXFoR2ZSUmJzdHIyZXpxYlQ0U0EwaEpJeGhhdDhzZGcy?=
 =?utf-8?B?Ly9oOENyRDM0S0ZkQWF6UTlTTi9GWEdybVhWSlpvRW9iY1RrSHhYeWZpd202?=
 =?utf-8?B?TUxoZ21hNXROS25kYS9rdG1HYW5SYTBndE9ieHVQNmtJd0pOeTYxWnhxc0Vr?=
 =?utf-8?B?dVhERHA1bVEvM3VlMlZKSnFtR1VqRUxnRE1ya0JJWG5TSjZiaUliY1FHcFN4?=
 =?utf-8?B?WTFwR3RqS2pWRGI1dDdBZWxxUVV1cEVKNmJaOGRoVzUyNmNFT0FWN3BBdmxr?=
 =?utf-8?B?ZVRuSHluc1JBUnErTnZ2QnNIWTFzbUs1a0d0dlp3KzVwUUtPekl1aCt4Yzlp?=
 =?utf-8?B?Tm9WU2ZEUEdFMDEyK0ZiS3dHck5Fc004SEF5eDExd0ltSGhXM29FMjJzZGpu?=
 =?utf-8?B?Q3g1eTdQUTJtVEhyVWpySi85dXZOOStNZ0owZXdaVGhVTGxwMlpzWVMxT2dF?=
 =?utf-8?B?bDdFUHpOT0xwMmM5SnlQa3VmSk1ETVRxNE12Y0sxU1JLSWZiL1NwbEZoMjFO?=
 =?utf-8?B?d3dWRVhOejZrRm43dFB3TENUbEZtMjNEWmRyTU8xUW1mRXc3aW1wa0FaV0hx?=
 =?utf-8?B?Q2pUUFNiZTFZWU9VL2g3ektHU2haNEU4THNnMEFMaUxzMHoyT0NPekNnbU8z?=
 =?utf-8?B?bHcrNEJ6aVd3RGlPTTRXRU9oeUpxSVMzdEdtOWFUaWRFSEp6SExOTEhlMVBv?=
 =?utf-8?B?VWlCL09kN0ZiVkJNbjFBcDYxTHZzalpnaEduYnlzZEkyZVQ1UTUxVHV1bXY1?=
 =?utf-8?B?b0d2STdMVmFvV3IvVFBDa0VxMDVWcll5RGJiUWt6WDdra3lqU0MzcDUwazBD?=
 =?utf-8?B?dUwyS2N5UFYrZTA1dTA4MUs1MGZFSmtVL2pEdHRIbUZ5cWtHazdkNmdSSUVm?=
 =?utf-8?B?WWN0QzFDNzh5NGNCYXVrU1BMR0U3TWRUVENBcmR0ejQ5ZjhiRUhvUHg3N1RF?=
 =?utf-8?B?eEdtTGNPZ25VelJvdXJocFM1aTh1aHMvSlE2SEhWSzRXZHFKTlhHTjBtSENB?=
 =?utf-8?B?aldGaVVyNjdvRFYvMzJ0SWNmWmRIZGJ1TXdBL0krU1FUVCtvd2I0VVVISHQz?=
 =?utf-8?B?RHF5VVRJczNJQ3dMelpjczVoSUNsd1o5c3NJckFyaXdaVFV4SHRtTDBnTTQw?=
 =?utf-8?B?MmpMZTR6VktHNzJBdVVSZmNZQW8wVVdQL0UzeitLSUFLZ1A5WXdES2ZFQmlG?=
 =?utf-8?B?N1NEYnBURFExSkQ5eFJXdGh5MW8zQ0VWN2lBYkc5WlJzUTJDa0I2RGJUQUdZ?=
 =?utf-8?B?Lyt6dUJGQjhqajdyOVFUd0JzTEhPUkRFdkNGUUtkeTQ5U243aFpoTmFpbktL?=
 =?utf-8?B?TnZpbjZIWktCdUxKVzlibTFmVmxVTnJWMkNPZXBVNVVWL3RJczFoZ0FqdW1p?=
 =?utf-8?B?bFVhWENwbzV0MVdSZGhhRll5T09TSDlTOHZGcjhPOU91MjlyOWVBYy91aDdN?=
 =?utf-8?B?dnVoS0FaRVc5dFMzWjd6eUxYWVMzZmw3RGttSnJ0ZHlyZnEwRTBIU29Nc3B2?=
 =?utf-8?B?d0U0aWsrQ01NTTFSQXdJMXdrTkpob0s2OUJuTzdPVTB0UWJlZ3hvZEVPWklv?=
 =?utf-8?Q?/3bAeCApCxAmuoCGvE5f0/cCT1XXuOSkGbS08?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eab625ed-352b-43ad-da59-08df39bd3653
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 15:14:53.4811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TubSfGs/UbH1hJBHd5tLj7IiGaOb86/ihqQQZy/0/elbG/iWQdm10i1BkL5NDZoSTSp4Uo9+p7A3dj0nhXUxzNx/D/UYCR3HuMl9vlhz+jaQQtXmHva6VVxknZNwGvK8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8037

From: Peng Fan <peng.fan@nxp.com>

Add support for parsing per-channel child nodes from devicetree.
Each child node can carry its own interrupts and iommus properties.
Child power-domains are not handled here; power domains remain attached
at the parent level.

The implementation is split into three functions:

- fsl_edma_child_to_chan_id(): derives the channel index from the
  child MMIO address relative to the parent base.  Validate that the
  child resource is contained in the controller resource and aligned to
  the channel register spacing, and use div_u64() for the division.

- fsl_edma_configure_chan_from_dt(): called before setup_irq() to
  populate per-channel txirq from child interrupt properties.
  fsl_edma3_irq_init() is updated to skip platform_get_irq() for
  channels that already have an IRQ assigned from their child node.

- fsl_edma_configure_chan_iommu(): called after
  dmaenginem_async_device_register() to configure per-channel IOMMU
  by calling of_dma_configure() on each dma_chan_dev and setting
  chan_dma_dev so dmaengine_get_dma_device() returns the per-channel
  device.  Propagate the controller dma_parms to the per-channel device
  so the DMA segment size limit is preserved.

Child nodes beyond the configured dma-channels are ignored, which allows
boards to reduce dma-channels without disabling every unused child node.
If child nodes are present, every unmasked channel must have a child node
with a valid interrupt; otherwise probe fails with an error asking for
dma-channel-mask.  In child-node mode fsl_edma3_irq_init() does not fall
back to the parent's flat interrupt array.

The shared error IRQ remains a parent-node interrupt.  A child-node-only
DTS without that entry simply has no shared error IRQ.

Use BIT_ULL() for the 64-bit chan_masked bitmap, and use dev_err_probe()
so -EPROBE_DEFER is not logged as an error.  Reject a channel whose iommus
property did not result in an IOMMU mapping.

Existing DTS without child nodes continues to work unchanged.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/dma/fsl-edma-common.c |  10 +-
 drivers/dma/fsl-edma-common.h |   1 +
 drivers/dma/fsl-edma-main.c   | 229 +++++++++++++++++++++++++++++++++++++++---
 3 files changed, 222 insertions(+), 18 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 513b0f4e5be21..62cd60179bc6f 100644
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
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index cbb077e98f55c..8843dd5661fbc 100644
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
index 30d548a723462..8691676b3b692 100644
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
@@ -123,7 +127,7 @@ static irqreturn_t fsl_edma3_err_handler_shared(int irq, void *dev_id)
 	unsigned int ch;
 
 	for (ch = 0; ch < fsl_edma->n_chans; ch++) {
-		if (fsl_edma->chan_masked & BIT(ch))
+		if (fsl_edma->chan_masked & BIT_ULL(ch))
 			continue;
 
 		fsl_edma3_err_check(&fsl_edma->chans[ch]);
@@ -397,15 +401,24 @@ static int fsl_edma3_irq_init(struct platform_device *pdev, struct fsl_edma_engi
 
 		struct fsl_edma_chan *fsl_chan = &fsl_edma->chans[i];
 
-		if (fsl_edma->chan_masked & BIT(i))
+		if (fsl_edma->chan_masked & BIT_ULL(i))
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
@@ -641,7 +658,7 @@ static void fsl_edma3_detach_pd(struct fsl_edma_engine *fsl_edma)
 	int i;
 
 	for (i = 0; i < fsl_edma->n_chans; i++) {
-		if (fsl_edma->chan_masked & BIT(i))
+		if (fsl_edma->chan_masked & BIT_ULL(i))
 			continue;
 		fsl_chan = &fsl_edma->chans[i];
 		if (fsl_chan->pd_dev_link)
@@ -669,7 +686,7 @@ static int fsl_edma3_attach_pd(struct platform_device *pdev, struct fsl_edma_eng
 	dev = &pdev->dev;
 
 	for (i = 0; i < fsl_edma->n_chans; i++) {
-		if (fsl_edma->chan_masked & BIT(i))
+		if (fsl_edma->chan_masked & BIT_ULL(i))
 			continue;
 
 		fsl_chan = &fsl_edma->chans[i];
@@ -703,6 +720,184 @@ static int fsl_edma3_attach_pd(struct platform_device *pdev, struct fsl_edma_eng
 	return -EINVAL;
 }
 
+static int fsl_edma_child_to_chan_id(struct fsl_edma_engine *fsl_edma,
+				     struct device_node *child,
+				     struct resource *parent_res)
+{
+	const struct fsl_edma_drvdata *drvdata = fsl_edma->drvdata;
+	struct resource child_res;
+	u64 offset, ch_id;
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
+	if (offset % drvdata->chreg_space_sz)
+		return -EINVAL;
+
+	ch_id = div_u64(offset, drvdata->chreg_space_sz);
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
+	struct device_node *child;
+	u64 child_mask = 0;
+	bool has_children = false;
+	int i, ret;
+
+	ret = of_address_to_resource(np, 0, &parent_res);
+	if (ret)
+		return ret;
+
+	for_each_available_child_of_node(np, child) {
+		struct fsl_edma_chan *fsl_chan;
+		int ch_id, irq;
+
+		has_children = true;
+
+		ch_id = fsl_edma_child_to_chan_id(fsl_edma, child,
+						  &parent_res);
+		if (ch_id < 0) {
+			dev_err(&pdev->dev, "invalid channel in %pOFn\n", child);
+			of_node_put(child);
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
+		if (irq == -EPROBE_DEFER) {
+			of_node_put(child);
+			return -EPROBE_DEFER;
+		}
+		if (irq <= 0) {
+			dev_err(&pdev->dev,
+				"channel %d child node has no valid interrupt; add interrupts or disable it with dma-channel-mask\n",
+				ch_id);
+			of_node_put(child);
+			return irq < 0 ? irq : -EINVAL;
+		}
+
+		fsl_chan->txirq = irq;
+		fsl_chan->irq_handler = fsl_edma3_tx_handler;
+	}
+
+	if (!has_children)
+		return 0;
+
+	fsl_edma->per_chan_irqs = true;
+
+	for (i = 0; i < fsl_edma->n_chans; i++) {
+		if (fsl_edma->chan_masked & BIT_ULL(i))
+			continue;
+		if (child_mask & BIT_ULL(i))
+			continue;
+
+		dev_err(&pdev->dev,
+			"channel %d has no dma-channel child node; add one or disable it with dma-channel-mask\n",
+			i);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int fsl_edma_configure_chan_iommu(struct platform_device *pdev,
+					struct fsl_edma_engine *fsl_edma)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct resource parent_res;
+	struct device_node *child;
+	struct dma_chan *chan;
+	int ret;
+
+	ret = of_address_to_resource(np, 0, &parent_res);
+	if (ret)
+		return ret;
+
+	for_each_available_child_of_node(np, child) {
+		struct fsl_edma_chan *fsl_chan;
+		int ch_id;
+
+		if (!of_property_present(child, "iommus"))
+			continue;
+
+		ch_id = fsl_edma_child_to_chan_id(fsl_edma, child,
+						  &parent_res);
+		if (ch_id < 0)
+			continue;
+
+		if (ch_id >= fsl_edma->n_chans)
+			continue;
+
+		if (fsl_edma->chan_masked & BIT_ULL(ch_id))
+			continue;
+
+		fsl_chan = &fsl_edma->chans[ch_id];
+
+		list_for_each_entry(chan, &fsl_edma->dma_dev.channels,
+				    device_node) {
+			struct device *chdev;
+
+			if (to_fsl_edma_chan(chan) != fsl_chan)
+				continue;
+
+			chdev = dmaengine_chan_dev(chan);
+			chdev->dma_parms = pdev->dev.dma_parms;
+			if (fsl_edma->drvdata->flags & FSL_EDMA_DRV_TCD64)
+				dma_coerce_mask_and_coherent(chdev,
+					DMA_BIT_MASK(64));
+			else
+				dma_coerce_mask_and_coherent(chdev,
+					DMA_BIT_MASK(32));
+			ret = of_dma_configure(chdev, child, true);
+			if (ret) {
+				dev_err_probe(&pdev->dev, ret,
+					      "IOMMU config failed for channel %d\n",
+					      ch_id);
+				of_node_put(child);
+				return ret;
+			}
+
+			if (!device_iommu_mapped(chdev)) {
+				dev_err_probe(&pdev->dev, -ENODEV,
+					      "channel %d is not behind an IOMMU\n",
+					      ch_id);
+				of_node_put(child);
+				return -ENODEV;
+			}
+
+			chan->chan_dev->chan_dma_dev = true;
+			break;
+		}
+	}
+
+	return 0;
+}
+
 static int fsl_edma_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -798,7 +993,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		struct fsl_edma_chan *fsl_chan = &fsl_edma->chans[i];
 		int len;
 
-		if (fsl_edma->chan_masked & BIT(i))
+		if (fsl_edma->chan_masked & BIT_ULL(i))
 			continue;
 
 		snprintf(fsl_chan->chan_name, sizeof(fsl_chan->chan_name), "%s-CH%02d",
@@ -836,6 +1031,10 @@ static int fsl_edma_probe(struct platform_device *pdev)
 			clk_disable_unprepare(fsl_chan->clk);
 	}
 
+	ret = fsl_edma_configure_chan_from_dt(pdev, fsl_edma);
+	if (ret)
+		return ret;
+
 	ret = fsl_edma->drvdata->setup_irq(pdev, fsl_edma);
 	if (ret)
 		return ret;
@@ -898,6 +1097,10 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, ret,
 				     "Can't register Freescale eDMA engine.\n");
 
+	ret = fsl_edma_configure_chan_iommu(pdev, fsl_edma);
+	if (ret)
+		return ret;
+
 	ret = devm_of_dma_controller_register(&pdev->dev, np,
 			drvdata->dmamuxs ? fsl_edma_xlate : fsl_edma3_xlate,
 			fsl_edma);
@@ -928,7 +1131,7 @@ static int fsl_edma_suspend_late(struct device *dev)
 
 	for (i = 0; i < fsl_edma->n_chans; i++) {
 		fsl_chan = &fsl_edma->chans[i];
-		if (fsl_edma->chan_masked & BIT(i))
+		if (fsl_edma->chan_masked & BIT_ULL(i))
 			continue;
 		spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
 		/* Make sure chan is idle or will force disable. */
@@ -954,7 +1157,7 @@ static int fsl_edma_resume_early(struct device *dev)
 
 	for (i = 0; i < fsl_edma->n_chans; i++) {
 		fsl_chan = &fsl_edma->chans[i];
-		if (fsl_edma->chan_masked & BIT(i))
+		if (fsl_edma->chan_masked & BIT_ULL(i))
 			continue;
 		fsl_chan->pm_state = RUNNING;
 		edma_write_tcdreg(fsl_chan, 0, csr);

-- 
2.34.1

