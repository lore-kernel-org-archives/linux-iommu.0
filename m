Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794469747;
	b=WsjFC0ZXTiP9+/n3jPtkUt1AzxXPXhsuDxa1LEV+dFBinYXuoE8vjPJ0uozwpVZeDo6M
	 xocXTfHgkXOXFJKS7G2zFebyiqH80OYJ5s9iTniwzPBJFPoMwmUCyL2owdUqP0orptnNO
	 JOinrOIQWubp4tmPLsgeZMMbhNhWdrSVtepBWJctxAk9l0w9TQiRQQqT41mPH/Cb1JXHX
	 xQxqIcgxfH2vIIirPitXBVk606UCEwflNHwXtPp8nan16teKfaqq2l2ePCCW4LxxkCtzU
	 NN2BZBiIZUGHD5JeGuyf8zJki4hcqh2nQvKI+Z185rR/EcyQRWuuDmVujIprRpRG+ww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794469747;
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
	bh=rSRV0SRT3NU8hFSL6ZFaYWgxpdLKIFETS8XiXMi8deM=;
	b=CUCgNU9XzwE8gbhzIROydcDEGL0MN5BPGclcgCVvioGVM7CDBs6vu2I37NcECI6m2mgx
	 5NIG5XgMBX8mlv5KADQjyGw9R9NvrlHpesp8Q2zHtF8q3LzJ0UEnlIGDj8nd4vccBTVAq
	 Azss09/OJ4EaJ5UhDy02LZYWenagk3BFEe57bxP4IlSVvbsnYxOdkSmoPfzaCavUZ6zvn
	 7JD3DFTRBj8WLcL1tqfLNOHxegvQnUBgQUpOKvo8rUmeBK5kB5tZQc5dVeS0KZGlWoCGl
	 adkUenjNZwSQWSlKhimY0yxamiZh7FMhjoi2Agq3P4G2Rl069UvEv9wCLT122PHLIlA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=g6gb6bJ+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.46
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010046.outbound.protection.outlook.com [52.101.69.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81D0606A89B;
	Thu, 12 Nov 2026 07:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B81D0606A89B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=g6gb6bJ+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TxhPzgW8E9QL+m4Gj1ZgVs0zugyl5lmk7JE6BgAWlBFR/h2T2e8VKoLt/ReLvIeIyb6R08/+NQlEsN0xFY9ATSYzfN+WPsxVQKWOjAMstc+71Qmlogl/tnn60eyoENvPElJWZUWdS7G7WOsXlMsExI5FTP9FPuj7rCDxnr1mdNVAwnOpE7DfZ3ozeo4v43ltL1ju4BuFoOPMXkPvRCtPo6QqzBdy8upEn11TTfHYHVflY6Q/dwiOrbv0shFTnfbi3A9m6byEWKqiZwqgQ8xLkHbS4Akv5AwgC4kZgL0csny5b4FdAQr7k86tXQCpc2XyvXhvVB8WMDjQjJwEsZt+Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSRV0SRT3NU8hFSL6ZFaYWgxpdLKIFETS8XiXMi8deM=;
 b=HMMabdYxXN+26XWShVEADEDH6xOS4lE4cLsF8kOUPnbc4I+GIGsyIz0ttU0ZyLZyF12Nb+cpGHdO+b02SkyP9zZj1ejz/WdFVofxn9CfG2Ilz0z2GDxBa3B0DqsC/hJAjqhjplMPQooAE86rWO7Oq82gCcZuGRM4gLsV3iCBVXUSp/gNShOZnMWK4NT2EXHHTaqhdmMu51B/1o4pzNJrn36x0VAgf2VwIq/HWhhTEiHcqkP+sx4nlAtXsJZuhMXeWXT7XdKwnzlGiy8i1gofAxt2ykZ64mCoPL2Y2kgZMaoAp7FLAYK6Aw+ZBRDFtrqwq8uCGlwzaVpuYs2I6ruM5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSRV0SRT3NU8hFSL6ZFaYWgxpdLKIFETS8XiXMi8deM=;
 b=g6gb6bJ+xd7nZ4PTC+czcMkx0yQ/FAPi0XiithzQ/EueYctYSt/qEp2m3MqXz8J7u0r38d+jMiU5hBmAZ4/RMSldFribmpMqIS0YEUELgjfrOjQFkYOsX+DpQBnc8O0LhEnb8r1thR3vE4K5VKaY03MYu5mus4aV+Rq9j3FZ4JpYs4NoKaLpIo+1EMv5P2h279w46zlSbUHsxGb2liah/ISH79/xnaTPDLdzBbSPvE0bJNnxg5ADsGNI0oZ/7ZAC27q9jw4TjrV8LMw3V+aiKYxcmp8h6pP8IJgO0D5Z2/mFfuWj51PXUqBuvlRjP2blxnW8fZVnN6htiCwPPH04UQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by VI0PR04MB11954.eurprd04.prod.outlook.com (2603:10a6:800:31f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 07:48:59 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 07:48:59 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 12 Nov 2026 15:53:09 +0800
Subject: [PATCH v6 6/9] dmaengine: fsl-edma: use BIT_ULL for 64-bit channel
 mask
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-edma-iommu-v3-v6-6-b038edb8ce6f@nxp.com>
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
X-ClientProxiedBy: SI2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:194::22) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|VI0PR04MB11954:EE_
X-MS-Office365-Filtering-Correlation-Id: c9e3c1cb-b2b9-46e7-b7dd-08df4091696e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|366016|23010399003|1800799024|22082099003|18002099003|261009223027099003|921020|261102123227099003|56012099006|11063799006|261022105027099003|261028144727099003|261021121427099003|261026140227099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	L4rqQzc7rxWsvyrLnISotMI+IZ0FS/CQauue+OF1mOMt1fzrIO4fCiacFk3Wq+ogMbAEYubYQ7Aq1lwmNAqc9G2qxCZ75DSXFNSBtff3aFQkF+qG9fEuU9tIfnTc8qet2zhazK1s6PPBWGVBP0AP2daeYgISkVTpSQpNYId9ftWWvxByksMJpJ2u2M3rneacFrb2h+sz486eSZyyKCHxupAdWl6Gk5g9cHo4pPs6xDXo6erA9TgjVFic8GJS7+Qt3Dvc5ZwiYdVbnnqQ7HhJrmJJUiNTHEvx+2Lh2ZNAuuJGZbO6g2H15w+5vr53B1n+j3BHxkrtE7jPUNMnYC78lTqkU3bFbG4iDrqjmT86AYKOCHNhDMlJf3LrBFOnAQPwi77g1Ofd8hc+oIJdioc5HFgLedWjKgzIN8zvlNz/yk9+n0rO/OI80ybh8rOHn2ZTI3s2DbtPS2h7y1b1ktNG7FHk9w7zqKL6s5P4EHAdutQ3+PNoWsMSKygTVKTEn9LKneMHAb7AK+sIdR4Nz9PWDY0y59++hWK7TWkamYSDu5sdnNVN90/y6/bW/I3acLMafyDTm1KldQEd6hWiyQY2Dzf6SFWGf5yJpLZnwfQRqf4ZUa6Z12wGsrnvLMDIUqukM2lDee0iwNzlKVe/+8iItah+hgoA4pYz9T5VVKRoQ1o6fSvQgNKo0hmIdlUvbxdNa8KOVY2gL05BaBOJFZx/ww==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(261009223027099003)(921020)(261102123227099003)(56012099006)(11063799006)(261022105027099003)(261028144727099003)(261021121427099003)(261026140227099003)(261021123027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VW8zd0s2VDZQMnhEb2o5cGpDZEZ2YWZMbUZXaXZORXZIb0VTTHRsWE5QVGtS?=
 =?utf-8?B?dnl1aUxCV252d1VDakRPYjg0Q1VFK25OVWxsOENJNHc4WmlEa3NVdHFmbmg0?=
 =?utf-8?B?dElDY0hnd2k3SnpncUhBOTBBNHA3TzNiWDZLekppZjhEQVJMR3pHejFvMnhM?=
 =?utf-8?B?V0pweGVpWjRzd1lZS0RSQURiUjVhSEx1VExPLzJrZzFqWXErMkhlT3NGR0h5?=
 =?utf-8?B?ZTJLeGVxVDhNNi80N1F0TlViVHZoa1ozOXdZOERRd0dnMFM0aXBRZS83c2Jz?=
 =?utf-8?B?QXBiVExWbUVzRVhsRjIydHhSdG5xLzR4cFNNS05ZMW1KSm4xajR5N1Jjb002?=
 =?utf-8?B?Slc4R3laZTQ1aVpVemtteGdueCtZQlBkdG00aW1ybmdQN2VpOXRNUlMvd2dl?=
 =?utf-8?B?MVRPTlJMS0NVdzl4K1JEdjRvd2FkeDl5TUlRSTdMRjNZSmYrZkUrMGtsVWw0?=
 =?utf-8?B?dlZTSDduQW1hamwvOG44UjhCM2E5aWtneE9tWGRsNVdwcUozMno4d29ldHRN?=
 =?utf-8?B?elRXcGFPMFFaa0VZVDg4Z01zVjJYNndHT0pnWmQ4VmI5TUE0NGU2QXN5RFJF?=
 =?utf-8?B?MnE3ckM2QWgyQlhncFh6UU5wb3FCUWp2UWZwUGZDZlV2RGZkbU9ndlNjTHhl?=
 =?utf-8?B?SWRaWEhDekxZSVA4aGt5REhVUUx3aGdrQ1B1eTk3N05pb1hlTFgweGdyYTlr?=
 =?utf-8?B?Y1Y1cGhKckR0MUMzbFdNODVIRDQ4TDVlM09NTzNFTXlROG55V1JINTVPUmdn?=
 =?utf-8?B?bXpibEpYUVpsbGdaQkFQVmFGNUxDaEk5eUpxaWloZDdsM0RYNENZM2wwMy9p?=
 =?utf-8?B?VDBwcjZCMlROMUhSZ2tQM1NvdGJWdE8rZlIxYktHNEhuYXh0aE43bG85bjlr?=
 =?utf-8?B?dVN1MXpHcERrRCsxR3NESmFUbVBzdEc1aWtjSnorNWdqR1NDNDdyY0VwV0Ur?=
 =?utf-8?B?dnNSNkNYVlBpTVFmcFNOY0pwNGJCTVVnMVVRdG5ZTXZ3MjRzNmtnR3oxZmdP?=
 =?utf-8?B?MUJrOTN3REFENlBPYkNxeFdrNmJSbWYyMjdTcGgyZldrYnI4T1B3MXBWQVh5?=
 =?utf-8?B?SXRXcE9nR1FSUmxOM05FdXBVOWo4aHV2djNDbityRFZOU0gyUjRBOGx1N1JK?=
 =?utf-8?B?ZlYvS2h5alVwMFl0V1pobWd3YnlxNWtnbUUxcWhDS1g4RkJSeVZ4TlpiTUFv?=
 =?utf-8?B?bjRvWWQ1Tm1DVUtPei8zenJKcnQvRnBVcWZBUURlOFF4Q1VHYnVocHFDT2Ez?=
 =?utf-8?B?RWxaemJkVlNNUS9LQTJ6L3pHN1NZV3ZyWkcvOGVJNTR4TnBTNWVjT05Yck5I?=
 =?utf-8?B?eXo0THRVdjQ3Z2dnRnlIQ1loUkUzSzNaMDBkWWsvRVpjR2FWYkljWVJLak5N?=
 =?utf-8?B?YTR6bWVpd2Jnc3pPSDg3K3hHRmxQbGdYUHMyMG5adTZzWnZ4Y3lzUTBXNC9z?=
 =?utf-8?B?dEdiOHo0QkV4Nzc4Q29ROGtZSnJsak9Bblo2ejlkQkd6NmtyYWdpc1I0cTJT?=
 =?utf-8?B?YzBpRXFyYVVnM0xSQUU5cVZ6d2c1NlloMkM3K2pzZVEzUWpaSk92b2ZPOE0z?=
 =?utf-8?B?bmZFOWxpbE1xcVJ5TWtIYU4vb096cDFlQnpkQlpNS2drV2QyKzF3V2JhVERY?=
 =?utf-8?B?R0k2ZVo2Vm05NnpnQkwwZWtVUlllYlpwYnZ0R0Rrd29kN0JVWFRwTGFNUnFQ?=
 =?utf-8?B?WDZreVBrNGlrNXFvSU1TcFdDL1I3QWlxYmhpUVdTL3hjUDJsY2o0M0VxMVBJ?=
 =?utf-8?B?c2xIL0hwQjFudUphcE5XUm55N0NLTU9BbjFYZXBlOU1tME9zelJOL2xrVG9z?=
 =?utf-8?B?dXRrekpPaUNXMnlMblhKNjFzeGhWY3ZGeFhiTktONStSOVZKdVU0VEQ1cnpS?=
 =?utf-8?B?S0U0VGVFTnJUMFQ1M1dnOGVEWTVNRk9wNHliNkxqWWxmRjAvT3NpQW1ZUkVa?=
 =?utf-8?B?M0QzVTFuVmtZVEhYREVwUXBiN0xXUDd4WW5RWER2UFZKdEpOT3RlYmEzUWlB?=
 =?utf-8?B?QmROdUNtaDJlTmhPZ25Nd3pPT0h1QWxYV2RvVHp5NjhwdzYweFVkMVppQ2hu?=
 =?utf-8?B?emU2aWUrUWxKRTRhQ3VSaFVPRFZrZnlTcjV3WFRHSEtRelRBNy9IWFZIYzhK?=
 =?utf-8?B?SHkra2xVY3FrY2diUG9zRk1Kb0p0UmxCKzR2U29MY3huYk1NRkhyTG9yeUw5?=
 =?utf-8?B?UnJWMmZTMzE3QjBwNHdTMkhXL0FBZDNYTnhzYXZYVTN1MzFHaEJhRkNCVmR3?=
 =?utf-8?B?Tjk0QmMzYmErdFhuWkdDZ1lxRkZFR2IzOHRSOWs2MkF2WHhSc2Vob0VvaENl?=
 =?utf-8?B?NGZYVm5DU20vZnN0OVpDN0Flcy9GZFJoVXFrekg0TlNNVEd5cDIvY1hUQzRK?=
 =?utf-8?Q?TGfi+Gd567JP+I0VSZEmK03Cu92G4A6C48HyF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e3c1cb-b2b9-46e7-b7dd-08df4091696e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 07:48:59.5993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O+kYSA6NyLXYaBEqljqOYmnZg5xwaiTHCcgmqtHPY5OPWO4tfbEvbW0AS7OEd02kFfB2zazsWCQh7VtiISVNzd+92OMpPP6yZtrRCnjQs0mDwvyEsQ/ZK9F0bFZwjHg4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11954

From: Peng Fan <peng.fan@nxp.com>

chan_masked is a u64 bitmap, but several checks use BIT(), which uses
unsigned long and overflows on 32-bit architectures for channels >= 32.
Use BIT_ULL() so the upper channels are tested correctly.

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

