Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794798058;
	b=vabdL4kG2UZsE122mcNWTmFKzOOwA41lufxYZqtDo6DMX7NsBx5amjgS5VJLdTjhBzN/
	 Mnx9OlZ9MljLh+P9XoEneouGiittjHXbAh2jHEvFlXIj1VfREHUgKh6W0qWxSC+0jlrZA
	 00V0k/485bXPfpgqvJ7SZR3jpDdGM+XwBcotqte1s/1pnBhzjlIKqAYQ2vBrcNn6Ut4Wm
	 Oz5pfHjoJXewEa9rgsK4QNIXjaHiqchEUPqhGjG1EIMWW3p26A9TIfBEpMQgFf0lFLRAA
	 DXNdjhOCAo6J8b7bsZpC9krhM6SJtSiPHIoxWMe1xOtvnCNb4am0JP0fprNjIXizFTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794798058;
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
	bh=xdloY7aJFcUReKdzRtXwXeMVnA4mRQzHPg+OfKLj5xE=;
	b=hvumd7WcYZx/IK25agjGE0Mbrr6xiM4K3gz0rf6gvmcA88y6gVu78+U9CfD7TV5Is0yH
	 9YZ5evSCQPPkuR4xTmn+IpPsiRNmpPQaiEYwuziC9WC2qq26e+5B4RtSUmiEaCTKd2DZz
	 ShNPalxiE5ow+IvTJY5P1w0bpXpqWF/SFkj5BYV9+ffQxSUtU5x8VV5uP7ThGWEZ9VG5e
	 6ROfUW9KY3S3N44tY0xpgbWJXcfaBhCY/ZluEBIIr71vfPeH26+0vKldRvoXXV7jhgjpA
	 B4PUjw5dVwpXkDFVR/09ACjCjGePapHDH5tPcFglia4ZAzosYP0pRdbOyg18mjhUfKQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=svuuVq4q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.45
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013045.outbound.protection.outlook.com [52.101.72.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B53606A329;
	Mon, 16 Nov 2026 03:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63B53606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=svuuVq4q
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GeVxVO2sjLuwyYLNB3pLJiy1Z/dnU1xjrik8NP45qJENs/CSbGcHyjW3KA1XAVsS1vbNvgMPq0uCJx4lZq7LmdiHQyd21BupYqtG4tULscFKshW0DHLGmllB+kj5/hiNTn+EdnIMupNv+/0/BKhTiVKPDGzPteKp5S8jWGflgwS2F978dQ8N4cee9ofMM3IJrLX5g0/stWkxcIR4C7vr3KCPmBthc5RtsrGcJGCOXAVTQf3r0oR4l5lVSMM0wsaJ7PeduvnAQmrUCICSGspHz696YgmGJ0UWH4zh3rDa1yf2w/G1RZsGBL9l/81w6ALAp8kQLHx5tQ59irk/XlGxUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdloY7aJFcUReKdzRtXwXeMVnA4mRQzHPg+OfKLj5xE=;
 b=HMQSU1qLGBNbyQ8YjRd1BIcrHkcZbBqzB94JoTAMe+v8AZBgn4ZZZGyv2O0E1VU2F+cr/k1FNEJbnqmeS4eCL6XLMAFCu1sJ/gdYnYZCLz5aIJNKzOchrkJjhle42Nh5P8wIXNWyTtCrst/sCq2jGMHh81Jkl2mZ9Tz31GYoZ93ZCVIKoeBabV0dREeCWiCbnS0i3lizbuD5FzHeOEhErPg0qnpItft5M6TDIFxD8zg5IGwQVc/3/ioQmQzcaxznO0pW+H1yQ5AKJt8VB8Kmq8H6fAXWDcdzfWmQ4HHKeb/kfrwKRyFav8y4ktIMiYxCBN+G7h5XcPDXtCjd2t5O/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdloY7aJFcUReKdzRtXwXeMVnA4mRQzHPg+OfKLj5xE=;
 b=svuuVq4qJArMbEn/SXNdWT0Ae2OrFDilsx8f+zczssjYurMF4FgYTfC9rAjozFqHyBY2ISGF0d3EQz5i/m27O3TNcfmmXu+1jFmdVLjm+vqVuZ/oSpZcUJexOhklEyuPOx9/JLCmug1MDq1zZjgxVQsFUAw4p9g9d2topRBI2SnKNP6KtE3wyhr440G6XcHYFljBVbejUDToi8Exxu6aSCvYBCgFsdNnTp2rJArl0Qk2DkxVbLVcrnY7pboWu4AWkPuUn0uaQzY+4u0Bs3RYW0sZhCloOrhGgarfomgYSo/P5vJie3AuXdp1jJD/+R8jhNuIWKkA1C9N//gPmbqdkw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PA6PR04MB11778.eurprd04.prod.outlook.com (2603:10a6:102:525::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 03:00:55 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 03:00:55 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 16 Nov 2026 11:05:25 +0800
Subject: [PATCH v7 4/9] dmaengine: move channel devices to the DMA channel
 bus
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-edma-iommu-v3-v7-4-32794ba8efbf@nxp.com>
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
X-ClientProxiedBy: SG2P153CA0049.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::18)
 To AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
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
X-MS-Office365-Filtering-Correlation-Id: aa70d7e5-4c5b-4e90-1d87-08df438dd51d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|19092799006|921020|10067099003|11063799006|56012099006|261026140227099003|261028144727099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	youjFUtJNpLZxZv643hTbnh+ltXMWxdwdtu8E0RQkzjYaw4L2z1JuZlxbyaGfNmGW0+A9ADiZjyhayK3BA9lZvMc3UBk2noVXi8y15P1cozIDbpnSn7FuXwpZl8svGveq/cDpYZyskkmHz4Z047g0dgINlD/KtZuVbk1p+YEO+0H5uGDJcw1UwfM1IhZEkBls/sSNR8P58OXBwGNM93tE9gO6lVzZmf54zlNN8eCeK9Av63yeIl/gHlEvh8AWPXooxhAr6Ds0O2CvMrcZ5h5b0/F8YmjjhPzs+bOg+1+ZrwbPyBhJZ8umjdbeqe2jn1N37v8Zedt38lwze90oDZuv3c76izRE9+sEM4udTgYMEF4egNBHrlkZE2Vi+Zp9WTnF2HeRGGQ3tjZ4Ho1xmBVb5zl9ororkUvOOYJZ7pBzDi4jG7Qd7/qgq1op4I6hxuZtaea5a5yLSooFI0uliSz1ncyjqWwWGoO6Xiq7ym4bx2wPpLt7kzYKupoSzdI/GjA43rxoTGAwBy83heT9tuk8/Ibs1+WFewAjoE7lNvGT+ZfQcp3o747saTYO7oqPqe3nmhhpKy4U6oXlHoxGYXny+tF9NzMzXjDVYiTE8XIb7Vi1dNMeEKzI1lzQWvH4cdmmkwyFg0E7FYVOIba7BQ0de7v59BwGfdRETENRnKbtpp2qi0IA/xWBRgH98OyyP+SsqZW6teNXEhSFYTuROqHaA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(19092799006)(921020)(10067099003)(11063799006)(56012099006)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THZWV0FsbGF5aE5rU3lCWEw0cjZ0SytzMGIvQW1tU3FKenppejUvZGxIZkI3?=
 =?utf-8?B?ZlBrdUhBUW5oUXZaU0RVNUdVS09ETkl2OXgyZkpyOVBiMVZ2ZXcxNUVJYnZZ?=
 =?utf-8?B?c2xqcHc5OFhkTnhiT055aVdrMGt5bjVBdDBXN0tFOGQrcFoyUk5EU1UzSjRE?=
 =?utf-8?B?Q0FrNEU0VDQ0RjNNN2h3QzFyamFUaithb3E4L3VXWUpXQXJzY2NpcXo4Zmk0?=
 =?utf-8?B?S1l3VkFSQ3VTbUwxSXBrUVJWSDhwd1BLMWJ2Sm9WeVJRcHp1WXF2Zlc4Sitn?=
 =?utf-8?B?aGU3YzhQMGlUR3ZzV2FQR3dMWVZXajBkL0hMYmt2K3l2czl5eTViUkNwNkNE?=
 =?utf-8?B?TEhWdWlyVVljaHN1REx3SVJlUG5sT2lVM0RzQXV4OXBCc0htY2VjUmdVSWVu?=
 =?utf-8?B?WkZHNG10M3ljdlYrYWMzK1A3MEtwYkxlZVM4T20zYXN5YU91SWVMckk2Tnh0?=
 =?utf-8?B?TElTNnVub0FuRUIwTnhYRXo1bzhlYkRjdGZTRWZxM0ZaaDBnb282SFpLNGx1?=
 =?utf-8?B?aTQwcSswTGl5bVE4UnRqdSsrRjc1QXVWNzRaVUwxWnhxRVh5aDdBai9mc253?=
 =?utf-8?B?QTM2M0Z0NDNhUU9NcTdIcEVKZWptNG9Oci9nOEtWb1R1SW5VcS9kVllBYUpj?=
 =?utf-8?B?QklQYjFLL3RFNGVUV3NEdTIvYzlhRXViTnhRWEpNNGJFQzlzZ1Fub2Rhb2t0?=
 =?utf-8?B?YUE1VVFOWkJmNE5FdnB2V1ZGY0gyYjVma1YrSk44cHN0aXdKWkhvWnc1cHY3?=
 =?utf-8?B?Z1ZFL3dZVVB2OEI2NTJaME1hcTNad3Nmanh2Ynh1L0w2ZWw2bTFpRU95dHZw?=
 =?utf-8?B?U09ibU9GWGxJTGZLZHAwOTZ6U2VkTUxYYml3QnNyUG5SUmJibGEwcnhSY3BM?=
 =?utf-8?B?L2lPWFJNVGdVYnVMYVdFL2JvR3ZvZEV3bkYzcTBqaDhBVWxxSHloQlpNeHJR?=
 =?utf-8?B?endTUmtxUHVpcTVoNkVCMEJBWk9nM0hwVDI3TUhEZGZXN2k5d1RLanBXVlR1?=
 =?utf-8?B?SlhEYUZZWFhyOHozRFRkNXNScDRGYmlRYjg2S2Fua09wL0x0Y25RZnc5MDM3?=
 =?utf-8?B?S2lpSjJkb0o3NFdoNlVVTlNBdFBtN0hvZnA1MFQzRnZSQmo0dGwyZ0RJUk9x?=
 =?utf-8?B?UEdjUGwyYVAyN3pBT1doSXNaN3VNTHpJODA3TkR2STBMdXBqSmdIWkxVMWRD?=
 =?utf-8?B?R2o4a1p2Qmt4M2ZIZ21OYTM5MGo1d1ZGelFPNHNqbFBOR1hCZEpaYWphbURx?=
 =?utf-8?B?UE9CZjJSZzM1TmZqNWR5enc0U3JmOXdIZUhhMzNqUHBGTGlHSTIzVDNUR1h3?=
 =?utf-8?B?YWV2czFMaDhmT0ozVXZWQ09JZ0FpMGRjbXdOb2RvNE8raHkwb0F5NWh1em5K?=
 =?utf-8?B?MDlNUXlmRjdFMDVOUmZpVGM3cnBGSGxtZHplU1ljM0NLVmJuRXFpZmpVa3o5?=
 =?utf-8?B?dTlwc1RGZVBHU3dFWjdqMDVKQTcxYlBGVEwvdGFoMzF6NklaSC91UlZpOEd1?=
 =?utf-8?B?TW5Hakc2cXpjakk2eTI2czN2NU1JaTNqRUozQ2FEUGJ1RzR2Z1drR3I5REkw?=
 =?utf-8?B?enR6aTQySkhhSzFKUXhkR2dQSXRyU09vc2JvMGRwNm1POThxMXVPRWJWVk9j?=
 =?utf-8?B?dkhJWkcyeVBoUEZqVjh1NjhqSnBNR0ZBUTlvSURnYitDd1F6dWRBMitrL3Z1?=
 =?utf-8?B?MlZKQnFDZE5SV1BCalcycEQxZHkvVnQ4aVRKUXE3MTNzQjJhNWM3bDlPakt2?=
 =?utf-8?B?bU1nUW1HcERXQXFrajI5NjBQRTIxUk02UTlxd0JlZzdrakZsQUdhQm1IOE44?=
 =?utf-8?B?QnFOU3A3VnN0TFFKWjAvbVNITGNqYUZ3ZFpZRmRxUDUzaTBHWWsvRGNlbzh3?=
 =?utf-8?B?bFMvOXJnbVhoQkpZcUw2VS9nM0gvZTBPNUVJN3BSQm5mMm5aZkpadUF6TmNm?=
 =?utf-8?B?UlNDMjhyVDAvRjhxVEM4QXlUbEtDQnVUUnM4K1duZUQ0bzdycElEcXNUNzJq?=
 =?utf-8?B?QUpJR2d3WU1MRmY1cmZZRU9qQ1ZodEtRWVM1RWxXbWRHMVlPTmVhZU44b3VR?=
 =?utf-8?B?aldFTXd4VTVlKzlDUWFLWDVOM05WYmlMcTB4NjNJMVUzOURaNWQwUk1MSXpN?=
 =?utf-8?B?RFZBOTFjemZERE1LaCtHdzBOME9wcGpUUG8rSHdVTEtBSXVWV0xKM2hDUHc1?=
 =?utf-8?B?LzNXK1NlbkFYbFNJWDhWNnh3dGFpTkZZQW55UmU4VURWWksrcEFoczFrK2Ru?=
 =?utf-8?B?dC9ESUZQZnEyTVM4bGt3TmVHd3l5blRnZXA5cG80dDBERi9lYmV1UUliSGds?=
 =?utf-8?B?ZFFLRGNmbW9ISmdsd0VsMzBhcXc1cHB2MEZXZWpsczQ2Mm96RzdDVWtsZVFl?=
 =?utf-8?Q?KiTJ6JWGsftuZt/LQCzYPacYthAof4R4BYBR3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa70d7e5-4c5b-4e90-1d87-08df438dd51d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 03:00:55.6364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: snRwA1CwumQIbSDIJmhc3hAtlly5CoHC/V0spRr0UxwvsmC9S7vT0MsvGTosdODNA1KhR63B5ZmPRb26i5trWTtXZ3qhyxbgGok0kppMAM16ypchchV2sVTFvPfXY8Mq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11778

From: Peng Fan <peng.fan@nxp.com>

Register each dma_chan_dev on dmaengine_chan_bus_type before
device_register() and make it a bus device instead of a class device.
Setting the bus before registration lets bus_add_device() take the bus
subsystem reference, so the matching bus_remove_device() calls drop
references that were actually acquired.  Attach dma_dev_groups to the bus
and set the device release callback directly.

Keep the existing /sys/class/dma interface by registering a class_compat
named "dma" and creating a link for each channel device. The channel
devices now live on the DMA bus, while /sys/class/dma/dmaNchanM remains
available to userspace.

The bus is named "dmaengine-chan" rather than "dma" to avoid colliding
with the SuperH DMA bus, which is also named "dma" and is registered later
from a postcore_initcall. As a result the device's uevent SUBSYSTEM and
"subsystem" link use "dmaengine-chan", while /sys/class/dma is unchanged.

Remove the post-registration dev->bus assignment from the Tegra GPC DMA
driver. Leaving it in place would overwrite the bus selected by the DMA
engine core and reintroduce the reference imbalance.

The DMA channel bus match callback never matches, so no driver can bind
to these channel devices.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/dma/dmaengine.c        | 23 +++++++++++++++--------
 drivers/dma/tegra186-gpc-dma.c |  1 -
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index e1022d297674..45e328d28689 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -239,11 +239,7 @@ static void chan_dev_release(struct device *dev)
 	kfree(chan_dev);
 }
 
-static struct class dma_devclass = {
-	.name		= "dma",
-	.dev_groups	= dma_dev_groups,
-	.dev_release	= chan_dev_release,
-};
+static struct class_compat *dma_chan_class;
 
 /* --- client and device registration --- */
 
@@ -1115,8 +1111,9 @@ static int __dma_async_device_channel_register(struct dma_device *device,
 		goto err_free_dev;
 	}
 
-	dmaengine_chan_dev(chan)->class = &dma_devclass;
 	dmaengine_chan_dev(chan)->parent = device->dev;
+	dmaengine_chan_dev(chan)->bus = &dmaengine_chan_bus_type;
+	dmaengine_chan_dev(chan)->release = chan_dev_release;
 	chan->chan_dev->chan = chan;
 	chan->chan_dev->dev_id = device->dev_id;
 	spin_lock_init(&chan->lock);
@@ -1128,6 +1125,11 @@ static int __dma_async_device_channel_register(struct dma_device *device,
 	rc = device_register(dmaengine_chan_dev(chan));
 	if (rc)
 		goto err_out_ida;
+
+	rc = class_compat_create_link(dma_chan_class, dmaengine_chan_dev(chan));
+	if (rc)
+		dev_warn(device->dev, "Failed to create compatibility class link\n");
+
 	chan->client_count = 0;
 	device->chancnt++;
 
@@ -1172,6 +1174,7 @@ static void __dma_async_device_channel_unregister(struct dma_device *device,
 	chan->chan_dev->chan = NULL;
 	mutex_unlock(&dma_list_mutex);
 	ida_free(&device->chan_ida, chan->chan_id);
+	class_compat_remove_link(dma_chan_class, dmaengine_chan_dev(chan));
 	device_unregister(dmaengine_chan_dev(chan));
 	free_percpu(chan->local);
 }
@@ -1306,6 +1309,7 @@ int dma_async_device_register(struct dma_device *device)
 		mutex_lock(&dma_list_mutex);
 		chan->chan_dev->chan = NULL;
 		mutex_unlock(&dma_list_mutex);
+		class_compat_remove_link(dma_chan_class, dmaengine_chan_dev(chan));
 		device_unregister(dmaengine_chan_dev(chan));
 		free_percpu(chan->local);
 	}
@@ -1652,6 +1656,7 @@ static int dma_chan_bus_match(struct device *dev,
 const struct bus_type dmaengine_chan_bus_type = {
 	.name  = "dmaengine-chan",
 	.match = dma_chan_bus_match,
+	.dev_groups = dma_dev_groups,
 };
 
 static int __init dma_bus_init(void)
@@ -1665,9 +1670,11 @@ static int __init dma_bus_init(void)
 	if (err)
 		goto err_destroy_unmap_pool;
 
-	err = class_register(&dma_devclass);
-	if (err)
+	dma_chan_class = class_compat_register("dma");
+	if (!dma_chan_class) {
+		err = -ENOMEM;
 		goto err_unregister_bus;
+	}
 
 	dmaengine_debugfs_init();
 	return 0;
diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index ec12b7288b43..93b136f875d4 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -1540,7 +1540,6 @@ static int tegra_dma_probe(struct platform_device *pdev)
 		tdc = to_tegra_dma_chan(chan);
 
 		if (use_iommu_map) {
-			chdev->bus = pdev->dev.bus;
 			dma_coerce_mask_and_coherent(chdev, DMA_BIT_MASK(cdata->addr_bits));
 
 			ret = of_dma_configure_id(chdev, pdev->dev.of_node,

-- 
2.34.1

