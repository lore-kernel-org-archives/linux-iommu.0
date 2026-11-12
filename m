Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794469736;
	b=Vwg1jNCQ4t3sZlcF9ucePUej8IUL20MRouKpTpVP6bfQT5m+iogAyIOjHONPyxZk+CeB
	 GkcQQo8CZAOqT8CLEnad5rjejg3nXtrGpT6HMAvDA5oxd3z0LTmnj0G/yM+8LB0+7wMWo
	 +jyohOtCHr4A8ZD/el7O9dFxvtQf/MIbing/f0yjFxzgC0GKoTRbD5ViR3q3KinN7KQl1
	 eCaKsNRVzzQkbqmWWlmJ9XAB8iPW1k1GK5nim3gJDvHeBxVlHgtTpJv9zoYuO9NQtewNe
	 j+XaWlh+esHihiACD2KURiwfdWb9B0AqBNKXkxQbbA2v3d4kRRYkhSBcGcoeouEzh8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794469736;
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
	bh=m8ym+UYmvT8FDZT03gE/yrhsKKedLQtj9TsIenPnNdM=;
	b=KEWUD0ljQHGGtSlSZ2SdGHJ32yz3qQlIDSoJD6MHDaSuONFND9MwesD1sYzb9qKep+Yt
	 Rmmvm3zOsDfab57iDwZ/Ct/7KmB18uphAFZiO7tAm4lUSsAjEGZWm9N4q3OF5LRYaT/0n
	 2nhrpwotarrSNaMR5NFb0tS//aFPrRLyz4S8TGaximSOhc6jADEpToSB0zemaoaXIUYf1
	 fjbj9G250n4iySDVv7iTpjry813nh0Lt/wDGf/eYZ4buMFJMmlUzPfJT1yAc1Kp4SZk6f
	 Hthde2Hh7Vu0qW9pT0ZRycNHIpEmb4lD3+DN9qKLvlw7lMaVVFk/TDsverIf+TORGsw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Ykw0y5vs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.21
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013021.outbound.protection.outlook.com [40.107.162.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB8B606A8A2;
	Thu, 12 Nov 2026 07:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEB8B606A8A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Ykw0y5vs
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWC7pAloTrur0fVk4Scjr8PL6hWYCbhehSjDv0HszA0BUFkjRS7u9QqUUcjrzC4aNk8T+zrDy/WCET4dWoIsJyJAJVf/aLN2wJyacfdye2wdYY7+xtxBpH6u3dqJvq4pnZ/X62r1lt6ix/DPtHGGktw2mLDRKZw1MK6o4YDQu/DurzL/Q3vpoZtPCgycVBrCQv66754AlpcletNIpjXtUUo2Z/guTrqo4mEt2Jsk0C3m/c3WtiX7OdQ+uQU7YxUU2yo1OrEnATg9UcVV7ILJ4/oYyjDgdZ5YIdwg8GvdQ3Iw6MsUqcnO7p35zvHYUgYhd5+pDC7AG0u+8ZQivvzlRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8ym+UYmvT8FDZT03gE/yrhsKKedLQtj9TsIenPnNdM=;
 b=VkZEazIkEnPYkQAm/7WONbOj09uy9YefKqbCFRFfkUC6nnK/h+VPHZY8dofDx/jFMmQH0KmHmactVfMtDM337+s8FI8r7Eu/tU5GXLGGge2s4HEPJkPHP+tdUwOScDEJ9QLHD9Hx0HktBlKK2aihQYoWNrbTb4Ori8W1WmgIm9P17WT1uK8wSXg2iIEyrIHKzhjmM0+lHYy7WLZVRb8qy6gJZ9js5fWADmjy4MiqpXkTBxVRIzoytzXnoQmQ9BZZncl1Ta6MB0EFYIy3DNaseO9Ero1XhyN1lTEUepJc8GYEWEGH8tR5uvvgqGBzV4Za6zEY/YaZHwytfvwUirqoMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8ym+UYmvT8FDZT03gE/yrhsKKedLQtj9TsIenPnNdM=;
 b=Ykw0y5vsNZwE53q33uQTB3WEQfMQPAnw31oWEj3WgKwWBXWEOaPdOBfZ74Z5M871ZX6BomqIVzEnRX6UcDILawjntnA1/OIqDL3XOvPELi4+NcyaX3lY1vMmlSTlFC+XdYJIb+eu/f/BE/PYJkevtCJ8QzeLrgXkCMyavo/F4MDPCKjtuh92SW45gntpunT0shV49YbC8LNzICRFShxmjXDCWvRcWojSbROTVSRGPNmMOde8Jgsjd0KacPDZjvC2ssesXg4JCg6Nw1DgI0WI+IkJizJ97UqP3YjFJij+qzOU92tzMuru9J3vgBvtF45ElJIQzbpQZUvH66AuXEIrvQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAXPR04MB8909.eurprd04.prod.outlook.com (2603:10a6:102:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 12 Nov
 2026 07:48:52 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 07:48:52 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 12 Nov 2026 15:53:08 +0800
Subject: [PATCH v6 5/9] dt-bindings: dma: fsl,edma: add per-channel child
 node support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-edma-iommu-v3-v6-5-b038edb8ce6f@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PAXPR04MB8909:EE_
X-MS-Office365-Filtering-Correlation-Id: dd5dc0bd-bf4d-45a1-32f2-08df40916563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|23010399003|376014|7416014|366016|261026140227099003|921020|261028144727099003|261102123227099003|261026121527099003|11063799006|56012099006|261021123027099003|261022105027099003|261021121427099003|261009223027099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Vbi5lAG/qTRVOv3HpOOxXKLcekLVAYMWeXoEz7kwnBMKWaWpXU8av4KptbcPrx37I1iuDPNIvW7y2V1d2yOwp2Pt2jCK5MmllxAlN6MEa+Usen7AEmDVdLXCqLHuJJkbwDm+bQvs2YXF/RwnDieW/d698uWGkrYzA5h4tjV7UQzd+aybPVkNfa4GrAbWcgUkz4iYSlAXYTmiqQGeGHGNryB/fdOwwTDb5bg8m1du3XneaCjZERNjq2n5bbnyFXRIK61WFBnta+yfsL3lPREbHe3Hy9OYqL3EmBM5PGuYX+0mZlN0g321fR2GvmeoCgdeJZQedOOlhno7VX6bFPGZB85uVV2ACxuE3Ms2ltO1q9SLhsIG8qfDblo3eBKj4168M5dQz3u5rkikj7pk7PoE7ac3ZWyhbyUnpoRZzdjwXN65hoQnsiCGzgECW5VfObodS2dyEEso5y9OtDmWFLwQM6CJq5cMcLVV4X2bGeGYzc0v6hqk3lUichCBDskd6WsgtnylzRLmERi8lnAJZjWpN6K/+NuZy7jYYKkWBD8ObCa93fv8qVRsThFPAq3KyCzXk8gjvSl7Xc+mN4s24RveIj/vPU7f7RYmL9EM5ecWHUuzbu16+6fETUEGwKbAD7PVlV/qwhosDL46FEE3rxMnQ3371wUwVJYp2OBmY70bs4TpTVuklWk33eGfR4pAHfEfZrgKU/KAjtZFgSIJ5Ciejw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(23010399003)(376014)(7416014)(366016)(261026140227099003)(921020)(261028144727099003)(261102123227099003)(261026121527099003)(11063799006)(56012099006)(261021123027099003)(261022105027099003)(261021121427099003)(261009223027099003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eW9xVHpvUURNWnN5a1RKRitKWmdJOFFIVkxUUDR5RUxXN2g2LzFoN2pqUWVu?=
 =?utf-8?B?ZGN1WXBZUG9td1dINEZPbFlrY3BvS1FlUmdnOTR0Wml6MDZnSmw3VVArSVJJ?=
 =?utf-8?B?WFVOTWV4Ri9rREJ2aGxObTlwSk13c1hDVGN1RkhpakVwSnNOdDBUaU8wQVVh?=
 =?utf-8?B?aFBpQ2VUQVFGVDNGNUk2WjF1VUVJQjNBL29FeGZzQ25LUXRlSWxEK3pPYjhF?=
 =?utf-8?B?VHY2ckR6ank0NlQzaUN4T1JhMGFpWVZNOExVVWZqZ25xSHBoek44RGtTbmlR?=
 =?utf-8?B?R204ODBXZ2Nvem1mVWdvcVFJbjlVV1N3OG0vVGd3VTJlZ3hHZlpVWVc1eWwy?=
 =?utf-8?B?WUg4MkdsOEtjcFVXSzgzK3FaVTJKbVhSRklZV3JST1hSN0FxSjRoRC81MkFy?=
 =?utf-8?B?eU5Zd1F3UTZCbjNtWVhyUjVjUVNiai9XL0JFT3FySUxyZXFKYkFad1BlRjB4?=
 =?utf-8?B?dU93QmtTY1lqYkdPL1RvdlZIQ1R3SjM3UkhUS1JGT0lRc0ROTndjRFhwUkIw?=
 =?utf-8?B?QTNjU1FTLzZMMEZ1TVlVL0ltckJaYWFpaUQxV092VmR5dlhDc3hObU9FRDNI?=
 =?utf-8?B?bVlIbnBwMzJzUW9kc1h6S095cU1IVUV6a1FxVDF4R2JVTzJSMEpKVVExVStI?=
 =?utf-8?B?a29Ba3NpVkJtUEp2bnFiMTlsVnVaMWt4L3o2VEdxYytWZFN4STFDOFMxcVFq?=
 =?utf-8?B?WFQ0dVRGaG9TWlhpYjNVcldjZVhtRDVyTy85cC9HZHEzSDFURkkxQ0tPMHhI?=
 =?utf-8?B?R0IzUDBsN0xzUHduU2xrUFZCMXlodTdpNEJPNDh4SlR6VFZoUEhOWm82bjd4?=
 =?utf-8?B?NHJFZEV1NERnYXQycmpqa0NJc2p2dWszSldlWWErOHlkelIvYWZLeXhod2dj?=
 =?utf-8?B?RHR1OUwwbFBlNUx5cVdjOUFrSDlYZHR2VWM5K1kreVpPaXZhbG01b2RsSGQw?=
 =?utf-8?B?NmwzRHFYZmIyUGlBMTgxMFhKRm1iOE43TVJMSzk0cVJhZ0RsTTcwNFkvQi9R?=
 =?utf-8?B?Ujl5cytncDd4OHo4dmllbE1DZkh1Znc3NXUzT0lNQVBkQXJ2VjYrelptYktL?=
 =?utf-8?B?T0t6RlMzRzNsWHl0K09MT2J6Mk8xVHV0Uks3RTM4aUxUdG9qY3h5VHE2UW84?=
 =?utf-8?B?MXZUaXhyUDV3aHlXK1NPSVpvUnNXVUVCWnZld2VUcVUwZ2FyMzk5K0E1Wnlr?=
 =?utf-8?B?K2QrZjBEdnNiZ2xRUlRhS2hDSUJiY1Rnbm5ubWZhUURDa2ZkQzhFODBjRm42?=
 =?utf-8?B?QURzeDgvaXNQQmlDYnRhUytzWkEyaWE4ckNPbmVMT3ZiT2V6dnUxbTJkdU0r?=
 =?utf-8?B?TFVwZk5nd3Y1cXlTTWx1QnlXRnRYRGlRdnJhTDkrMkNPRTNOc2YwZmNHQ1h4?=
 =?utf-8?B?cllCejJaR2R0UW1hQU1qbm9FL29sMVVXZ1cySWRCSUtKQUdTYmU1ZkdhSmh0?=
 =?utf-8?B?UldSY0xMNEoyc25sV25yZjduN2dJUGorajEzWkVlR3M3azl0TXlHRytBamIx?=
 =?utf-8?B?WkthUi9PRFJZcDBycDlNOFlaVTJyZU5xM0M3Nml1TUEyU0kyeVJFTHgxcy8x?=
 =?utf-8?B?akF3NWRFajJOYjljOHVyNzFuVzJDQjJCQ0R2eTl5NW93MTlPRUNITm5lTzlM?=
 =?utf-8?B?dlFUWWZLLzJtcGRnczJmUHhNcExHaW1IOWZ4Zm0zOGV2eE9xai9HaDhYZ0Fa?=
 =?utf-8?B?OGlMNlNIb1dveEg5QmNVeitSbWxYRUN5MVV1d1Q5Q2JCV1NuanRJWVdDZDM0?=
 =?utf-8?B?aGNheklBd1U5dnB1TVpaTk82WHdWNW91ZGw4SUdha0dTeUxwcHlGOWZqQ3RR?=
 =?utf-8?B?NXhwRk5rbUVydStrbFZEUG9PUy9QZGUweHF1elJJcnhHREpGRzhkV0VOaVh2?=
 =?utf-8?B?MzNBY2YzSDhmd01KZGk4SitNWVNiZkZsNUUrOFJxRThhUmlrQW9YdkduaW9x?=
 =?utf-8?B?allaNDJzU25HUlY0TWx4Z05maVptV1UrR2MzQWV5OHM4UkMrcExnc1lqT1ZT?=
 =?utf-8?B?NmFSRGlTMEFVTGhwMTY4RUJOZFpFUkVtcUVQMzlxLzdsVTlVQmsveTdNU1Rp?=
 =?utf-8?B?QktjT0cvaGlRak50Zyt3VDFEWTdMVmpsU3lJU2Y0dW5iWXV4YzMyRTJuYTdz?=
 =?utf-8?B?TDgvYmRZMEMwOGRSWGYvcml0OEpFTzBnWmxEcUUxeTFYczhWc0FBcG1QODVk?=
 =?utf-8?B?QUgzc242c0JUOGF6dFBPek5VTW1LWGs2VkFsZWR0VUdwVVpiTDVSMG8yNlNZ?=
 =?utf-8?B?RU9CS1ZmV3QzZW5EaHhoeEZ4ZlQ4RnFGSENQdGZmUE8yNW02eWtUQ2lkT3Ax?=
 =?utf-8?B?Rncwb2RpaWJxcGdjZFhWMzQwcHFvOWNBSEFFK1E0aDVGVC8vZHZ2NUlTeGts?=
 =?utf-8?Q?jK3GS+Xy+JMvwNafDEEk5UBC3ik1TR3jUWIj3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5dc0bd-bf4d-45a1-32f2-08df40916563
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 07:48:52.6427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Z6I2lNzpTpEqmgZCBeiCFAKDHMCd5z3AvdiUMGlWUq0rQmBoQFYlilabhAbmMSL3RABKnHzShX+/tw1OPCYSn0e6JO01FCoMbQaQrJIV74XMiqiIsuTQJWwI5D6gS9s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8909

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
index 0260d177c7d0..65877e78330a 100644
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

