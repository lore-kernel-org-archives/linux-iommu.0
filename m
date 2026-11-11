Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794404572;
	b=klwGGwcQLgz08tEArt2YdAVl/LSaHhKVmH54BgtVwucPHHCMX8RZ5ytALNEZPvf/Zsw1
	 ILrN1JYiQ7IG7r3i0eaJxMrj3LvySsrmnHSxTjbD4ZoOmovk7GUVKyE0KKIXmQpDLKPIi
	 2otgNfxDUKuD2kzK4N7NR1L3cegYH6UJG44qheetQUYQuGClIMlMgTwfOsGFBXIyqWrmm
	 RVwfz5NgM754/8hf4neyHPL16Yj++AG6TKTS4iRGZnhhrY36UKkgaiZOrVidH0evtblWy
	 4LbQDLdrYkTGjTwWrQtAy3GsghB36znbI6Z84m2rjl39z0zDkpbe/Of7w+tRRIPQQHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794404572;
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
	bh=142BWzo5SqdeGbDyQUFihRMgsSKnM/QLJMWd8Z8Vmvs=;
	b=QHNFbsTrhBEJYvkgkCr8gBZhCqgZ6NADiEv4NSA0U8/ASIgxdMLm8OuuX3vgEeLmNCDt
	 V3CMfGjnBzPrY+pTiTNsA+6KzLgtbG+mI6Tyd6LjbKXsaySIZrrxaXgE0jr3tev0+i1b9
	 BpFC7pOpqDOK0W64LHn48Or//2woHBoSYBWbTs+LB78pJUVrOWptFEnkyXMik0U5EgezD
	 sh9vH1q5u1zTw/9sdix3UX8eCrM+fAFPeUKrGhuyatLCApPtwHtsXnrDmoYL0q4UBL8RU
	 ArOl17Ry0e9oWPZlMh/3gXJAm+aYLqjo2pyVYnRX72n2jT7kp+UtvY2YHYjugeBhzaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=nJCReKkB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.24
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013024.outbound.protection.outlook.com [40.107.159.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C91606A338;
	Wed, 11 Nov 2026 13:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80C91606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=nJCReKkB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxO3AUUVFj85GOVeG9tXVeI5hqIeQneMit+MlBOBWNmU5cEtEWcTtQndqb0F+P0EMe5OFNdfGrlmSG1P8LvoNG6yHTL+gTRFO/b3sQG/+4gBgg1cvzZLmpmgYT9PCWEchvrynBZdX2K9lnjinamfj7woBy/7ldeiHygQLfJlcpRQ3077bFDLR+qoLUSB542+OmDWTOekKpzccz7OUzvaeNOAnEylKbyoWWUye1RyAnmqNCuf1amAuCM0EXZFopCqTbyYZmB03oxX+dfOcs09oT1SrmpFfTzkYQUlNfn9yIZIxaKcDl2jH222h+MELuB0JnCpeRW32GklTxb19uLkJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=142BWzo5SqdeGbDyQUFihRMgsSKnM/QLJMWd8Z8Vmvs=;
 b=ddGWfPv68na6+fmkL5TVNQj8fKo5ETD+FC+EX3mkOsBkInQ0GiVGxGhlitP8ZfesvvLPiO+6A6aRg5TGFrptKB8l6CPiaO/SZXWcJLXgpN28vXeGFjv9om8tuf7P+lSdIlOsz6XcNDnuOVUnqqx6e+umjZkKaVi8hcFTp8iHp8Ev3U4+sl1oIC8XaDLiG/EuKEVCujkl8WHtyXTvySKNliZ/vFJptcbCOCPAgFDWSyKDOaoVfiv0D+KwmYitzJDx7NUeVR916wHtOHJUKWEuPOqVjuZiCty33eTT6KBnqSDL+v3E5fiBhnAceXZG35uMM+jxNCHIq2oHcq6WC9Aohw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=142BWzo5SqdeGbDyQUFihRMgsSKnM/QLJMWd8Z8Vmvs=;
 b=nJCReKkBWVlIxMaSY8zfFuh+AAYbJzOrg3E90UnIHQf5OI/JM/6UNSSaoPFoDc/MsWFoc3DTmlOxJ1SKR1HW3NGapbjISoW2C2x+aZnuUM4AH5lbrN3Z0PHjNJ75iiKBL4W3iEBrvdakZXln9b9WRffinyC0ZyPRBbedn78sT4B+/jtvyzzS2PopywRlx9Zs+jcDgvgYAaDojHIkGaB0DQj6HzRwaDx5vfqcWWf0QFmQN+/MBuwo9k+LRdpO7c18ucUbhzuMUxHAMUWSJaHblVOVfm0SzpkYAwxVBgJ+0i1bCGHleNu15LSnt3b20Cer4nw0M70tkjXvqZEDDs3h1Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by CPHPR04MB721690.eurprd04.prod.outlook.com (2603:10a6:380:104::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 13:42:48 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 13:42:48 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 11 Nov 2026 21:47:30 +0800
Subject: [PATCH v5 2/7] dmaengine: add a bus for DMA channel devices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-edma-iommu-v3-v5-2-2537cebe6ca2@nxp.com>
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
X-ClientProxiedBy: SI2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:194::15) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|CPHPR04MB721690:EE_
X-MS-Office365-Filtering-Correlation-Id: f7b82664-c614-403b-28d1-08df3ff9acb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|19092799006|921020|10067099003|11063799006|261009223027099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261102130727099003|261102123227099003|261102124527099003|56012099006|261026140227099003|261026121527099003|261028144727099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	xym/GbsRdQCU60oIPFv3/yO0QpsZElfKXiP5uixZUvJXnrSdcgRjTXG5WMXhWM0LCbW+qCis9K15PEDfYcihmZm4BML5zz5bWU9JBBECAg8yAmZdKAQzTaguXMj2g259SaDwh1cYvFUXT4FMpDiB9F6Kr582De1mu2UOv49PwPpsyrEeeyKYBE1julSq1ZKCyaSyzXZD1i5E9mb5mLPgdP2zRygjgHZtAJA4KMoOH+5stonW2itZxEfO7sfFpRzylEKZ3EYuI2Rkc6CCCPse5qLdDw7ugpB04VCNmRYJGVEz6NrLR2+ZkmhGx9zzSXxyZAWqoR7zC0pjLFz+JfNwmwrmEdNkLm1CRMink6I8sk1LDz6rasno30MeXDO/Ls7Pc/bRzJnGDajko38Qq86pkh/ra0I3UxVp/oAilTYk0WegrWWA8as1/CY8FAlV5EL6BIEv/zdI8RJmCZNTB2X7n5EjBOmC7OVevwUvfEi8ujSCDqjlQujrb8XJF0ZHqQtZQ2iz30NFcL1YqRRtBpjhe8EB7xyJF02TKOp0a7T3m5aYuahpXCJaqWVqOX8kVJGH+LbvmuKpjqZlTgfLU3SSDVg608VRFWMC+yXnxlz5LNycToQ3m0RJL8t7jSUOPg1V+MpyXtOdejGGlqVdlc3atYHrB1Ow4ooTNqN9aqfXFYmQnJMkXvGJxgnkrr35sOXlVPMIa/ICOGCx7TpBn65McQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(19092799006)(921020)(10067099003)(11063799006)(261009223027099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102130727099003)(261102123227099003)(261102124527099003)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXMrUXlWdlBsa2NOWCticUVFZXlVTk5uR29CeDBIQ1lmV1drbStpWndSVjJ0?=
 =?utf-8?B?eGJvMnNyMjdQSGVUN21QOGJFMk11UzhENXdxcXd6QmZNWTc5d2NJRzYrUlNM?=
 =?utf-8?B?N1hNdFhOR1d0b1R4Y3psaVAvNUNQZVRRQ01RRzV4aytBekxXVnhuZnord2R3?=
 =?utf-8?B?cWhtRnZBYTJOdmo3K094emovTFNGVVRhTmFOZE94N2xrQjJVM3RHcXZ0Qko1?=
 =?utf-8?B?MUVLdExiRDkyOHNHUndLblpLRzNzNngzQndjblBHSnV3T21UOHVFMnplbjJB?=
 =?utf-8?B?K2JKZEd4RURKeExxN0JoNFdSOE9qcnJ0bmluVmdJL3FnNDNPSXVENmZxMkRU?=
 =?utf-8?B?NXh4SUNjWHhENXBkdTYreE9qS0FnbDFHZXVTME0wSThRTjhveTNZUUlPNVg1?=
 =?utf-8?B?VWwvQk51MmM1aVJBNEc3RGNjVEF2MVlwUS9zMFlaNHkxZGF3SE9WM3I5M3lw?=
 =?utf-8?B?eG1aSGp3UTdORzhQbWpGUzhaMVVMUmFocDhwZG5uVlo2dmFQUCswem9rR3l4?=
 =?utf-8?B?eFJEZllmNmlJcVRJeW1TenVlMlNZQXBvWWNNWWR3MGpYSE5YK0ZhQjlZaUwr?=
 =?utf-8?B?WGJ0ZEw2RmpzUGpSd1g1U2VFcDdPVzFZZGlidlFZTlJlcklFRENIV0QrZnB5?=
 =?utf-8?B?YWJBTXp1MFROMHR1YTFkVGdwODFZQm5ZNitsQTlSa2J2bml6aUQ1aVpsMUY1?=
 =?utf-8?B?MjIyVGMvMkcwWW5vOTAxdGVmY0h1S3ZndmI0SHFSbDhiMjU1bUtlWlVKNUZQ?=
 =?utf-8?B?UHNxa3JOZ002Q3JVdGZVRzVoV3pBaTRHbUVKYm1sdENPbytHM0djSU43TGlx?=
 =?utf-8?B?RnUzUTRkaXErR3JMRTBsc21sNTkzVCtoTnF1aG1aWjBPU29ETmRNeEUvUk93?=
 =?utf-8?B?emx2c1lwazlrMHpPdEQxYndtcTdJLzhvREg0M0JjeHZuTnhRS2pmaEIyK3gr?=
 =?utf-8?B?VCs3dHA1ZVNpWEJ5SWJuVG8ybVBXNWYxT2h2MHdpelp4VWcwc255czNMbjhV?=
 =?utf-8?B?Y2I5Tlh3cmlNNVV3SU41SWdXSFppdmtUUFNaOXl6SDVQc2o4ajF4T1dOMFRu?=
 =?utf-8?B?U2ZNNkU4TzZGTXlQcU9nbGZ5dW1RdUhvNFIzd0UvT3k2aW5ORkIram10U2l2?=
 =?utf-8?B?TXdRUmxVZUNyTzdLc3ZqMmZRbTc0MWVrV2gxWVlzc1pUVUl1eU1Id2RmYTYz?=
 =?utf-8?B?SUJRZm4yMmtKN0s4Um9PTjQrcEZvcS9tWkFON2JmUVJ4d2hsd1R1TzBRbjFj?=
 =?utf-8?B?c0RBOXdBcmM5SlpleE1QRGdhUTI2VzZDakVSSFNqK0tuUDBFRlVKME1BdE80?=
 =?utf-8?B?TnlISkdzaEN5b2JQWDQvTUZtd3VvZHlwZzRsK0pOMXhMdHRMMXpyTVd4M3Fl?=
 =?utf-8?B?OXF0UFF4cTZMREtINklvZ3ZMTUVJeXhscWJjdzhBUzZNcGtwMVZmZFpBZG5M?=
 =?utf-8?B?ZE04MFJaU3ZUMDgxaUFkT2JiMk8vWmUvMWlCaHBFRTdDMHFSWjdESk91VFBW?=
 =?utf-8?B?WTc4eXBla1EvV2t2Tll4Qk8rSGJROC82dnNzZ1dTSm9EeklxVXZ3emJwMi9V?=
 =?utf-8?B?Q3JrQmN5Ukk0Mkhmb2VENmk2enZZR3lmSDNDKzRqaFoyVlhDSnM2SC9iRVc4?=
 =?utf-8?B?djJ1Yk93VlVmQW16OTR6WVRiZUc0elY5SjQxSlQvaG9kY1o0QnJ5UmFHWlZB?=
 =?utf-8?B?aUYycVNEb1hzQ3ZMa0dLM1NNY1pBdjZBRlJxWFBWYUp6a29BSkFhaWlwZ0t3?=
 =?utf-8?B?Szk4TERNN1FnRDJFN01FVGJFUVR4RHBMYXY4R2ljMU9CSkd1eDN6OFBJZm1h?=
 =?utf-8?B?VGRUYWhvN011cTFjb0xpU0xYTGJ3clU3VXByek93Rm5yRzlKalNKaHdKWVM0?=
 =?utf-8?B?UTNjYmtxeEZRYWw3Q2FvMzgwb2NhdkFLNXJNbzMxdTdVZmR6QVRpdy9ab3lO?=
 =?utf-8?B?eWN0M0xLYXJNdXRJTTB5M2QvK3VpaThRcGN5cTlJZDA1NEdEd1JZYmYvdklV?=
 =?utf-8?B?YmJOc1VJNVRCZm5YTVpFK1BJbWt6cFhPNzYwaTlqOG1MckNpUExpTmtqUVdE?=
 =?utf-8?B?eWVXYURZRTRSRXB2U0R6dE1LSzBDTjhaWmFzbVgzMzBZMjFyUTB2UTFzZk9y?=
 =?utf-8?B?SFZnQVJIUUZTYWRGRmgyaXdyZ0FtTlRPYUUxcUUwYWo3Y3FHRDh0S0NhU1Uw?=
 =?utf-8?B?S1VIKzJieFE2K3VmdjF1UGtwZlppc1FubGxRVzZ0eFdtckhyekZQa1FKaElY?=
 =?utf-8?B?aUp2UkE1Q3hxUGdkRVRtM0FodVJMVHN0OSsxbWNKR3pvdGFTU0RieHF3N0tQ?=
 =?utf-8?B?SEQrMXdGZEpRdXNpa0EwdjYzaVVHaXhzM2FjeEFoVm80S3dYYjR0UlNsazhW?=
 =?utf-8?Q?N1+IJLOI18LkrrYwCYh8k6ZlcWripK3jASnw2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b82664-c614-403b-28d1-08df3ff9acb9
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 13:42:48.8387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 26m2oaBiLV/aQvsLTwu6io3lsj7Dfi5fD2AkLWPhSW2OdMXGl+/1oG2WJiD/1K4uXgN2nPiHKTFz3rV1WK6hKruJQ66yeWnl3psNnDPbA22oCGoUdNflJnvX6X0s+uGP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPHPR04MB721690

From: Peng Fan <peng.fan@nxp.com>

DMA channel devices are currently created as class devices without a bus.
This works for sysfs, but it prevents per-channel DMA/IOMMU configuration:
of_dma_configure() only probes the IOMMU when dev->bus is set, and the
IOMMU core only installs probe/release notifiers for buses listed in
iommu_buses[].

Drivers that need per-channel IOMMU support currently work around this by
assigning dev->bus after device_register(). That leaves the bus subsystem
reference count unbalanced because bus_add_device() already ran with a NULL
bus, and bus_remove_device() will later drop a reference that was never
taken.

Add a dedicated bus for DMA channel devices and register it during
dmaengine initialisation.  Use core_initcall so the bus exists before any
IOMMU driver can call iommu_device_register(), which iterates iommu_buses[]
and fails on an unregistered bus.  The match callback always reports no
match, so no driver can bind to these devices.  A follow-up patch will
register the channel devices on this bus.

Clean up the unmap pools if dmaengine initialisation fails after they have
been allocated.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/dma/dmaengine.c   | 28 +++++++++++++++++++++++++---
 include/linux/dmaengine.h |  4 ++++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 34be53487a21..9a9d54d8f7c6 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1643,6 +1643,17 @@ void dma_run_dependencies(struct dma_async_tx_descriptor *tx)
 }
 EXPORT_SYMBOL_GPL(dma_run_dependencies);
 
+static int dma_chan_bus_match(struct device *dev,
+			      const struct device_driver *drv)
+{
+	return 0;
+}
+
+const struct bus_type dma_chan_bus_type = {
+	.name  = "dma-chan",
+	.match = dma_chan_bus_match,
+};
+
 static int __init dma_bus_init(void)
 {
 	int err = dmaengine_init_unmap_pool();
@@ -1650,10 +1661,21 @@ static int __init dma_bus_init(void)
 	if (err)
 		return err;
 
+	err = bus_register(&dma_chan_bus_type);
+	if (err)
+		goto err_destroy_unmap_pool;
+
 	err = class_register(&dma_devclass);
-	if (!err)
-		dmaengine_debugfs_init();
+	if (err)
+		goto err_unregister_bus;
 
+	dmaengine_debugfs_init();
+	return 0;
+
+err_unregister_bus:
+	bus_unregister(&dma_chan_bus_type);
+err_destroy_unmap_pool:
+	dmaengine_destroy_unmap_pool();
 	return err;
 }
-arch_initcall(dma_bus_init);
+core_initcall(dma_bus_init);
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 805668fbe437..14d8f182c7cb 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -412,6 +412,10 @@ struct dma_chan_dev {
 	bool chan_dma_dev;
 };
 
+#ifdef CONFIG_DMA_ENGINE
+extern const struct bus_type dma_chan_bus_type;
+#endif
+
 /**
  * enum dma_slave_buswidth - defines bus width of the DMA slave
  * device, source or target buses

-- 
2.34.1

