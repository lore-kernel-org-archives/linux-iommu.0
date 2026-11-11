Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794404583;
	b=3vEz6bosn6Fn15EebOCFmPOoTEn2te6/m1FrcabYAjGFiFNmd6rqr0OvFUcFg3w2h2ID
	 3zDiu76sW6ZHY1Guazh+AVqN+3xuZF3xXUwBbq1fz+Otb7PKEa7p+C3fGVkcMeZFPFvJB
	 WKL6ELPS3FrM+QOgGb8PezC1i1pUeklR7zxvFwl81Hpvha7t/trSk3STkK1YtM1JaOymW
	 iCg+Sg4E+JQitqB29MyqQyuGwwv5u/1WAuSK9zSbPAEZPQkDteLSXaDeum2qbuYFW509x
	 KvJzPwFSMO2uQxdK9JBiAlmuTSpQrx4P1uUOvw1i0wgjJ1/fupq3oGhsCsiBSyDyFLQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794404583;
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
	bh=FdSfeW8P1K2Rg78AGyhwgJrEpVBCZEC4l3KNgeawZ/g=;
	b=N7iGw4aGEMrB6fLNzF0s2LgcAvO9JVxI7GHCpfk8DhIEt5QDEklXwa6pwIOv72sJeSHm
	 3nUVNKLRPfV/TVV2IGq157QX7qpOxjOjGBfMDZsGiaqaf0aMxFSoP9MpdT50fuw3XrSnT
	 vsUI8l1onxOEROPnpzt2+uHQ46I63D/t55QcCSX2DYlFhaHpMikWpbWOcN2d3NVvwqrI4
	 8FtBSrV15BA31FSScpTU6zh0UapK1lNez/t0mXPXB5OxKcXsJzbj2ySc7iOFmZgwOfkob
	 gR5lkB19M6/Yf3vZuJPliPUbaF9WjnAJY7tQao2rhlAeUYVxBveHV5kmxXO4LjwgaaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=G19PlD7v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.64
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013064.outbound.protection.outlook.com [40.107.162.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DEE606A8A3;
	Wed, 11 Nov 2026 13:43:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77DEE606A8A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=G19PlD7v
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2yE6MwlT/CTTEKpf/tpA3ku9dtA/IWRE3xIMIEzRJWmYMogxqf9hIuXEmunULzi31mrlHo1NlPd9q4cJoNd7Sap3tchd4fZ0gnjc2inXzncUhrBMKv5cXzuSWBh+qfVr7hdlAuJE9vf7lP36EkbopUi3mHX3tKpG+UgOgyEhnQucVcFWb6HYYUwKUgXo+lFhjTV4d+oPehnqvJVJhyayOcLZ11+rkWtLzfBeLSgTUpbhoWP3uhrKBz5B7t+azPknZoqLVctCnWuFD9XLoRhgOgWT9+Y3zrWzVMBdEDb+4IP6BjGf4pgM9l4Njwwi9r2gQ0y2ZR1+9XcguXc+9IphQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdSfeW8P1K2Rg78AGyhwgJrEpVBCZEC4l3KNgeawZ/g=;
 b=lQLcHhoWBFeWgVMx39afxnMg+mUhQvwTvTdztWxnL1R8GdMZoEvW1JlpJdZeyWBYLKbE/GYTsr2IwzCcpfF+QTfJA9uetHFQsbBlZFQE9Jvipj2hsdl1pfXc219lAUQMUyXoTcM6NdfzoXeloJvsUGQW2OKxNsGOtvSK5PIZ8UHiIcPnBu9vYohAkB5fnmwx0WaxmvqJd9tBs2DdaKntCZJ2hnF0qIlHOiNqZaTy/x2SWpjY3S7kiY8ZK2HuxTtqZGvUSJWVeW7Pl+G30skam0HMMSU3rz7Sxq5o8pMQNHNiny/iYE9rcMOmrmvXjbFKMmLBRR4rCDJAHH/9zYn1EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdSfeW8P1K2Rg78AGyhwgJrEpVBCZEC4l3KNgeawZ/g=;
 b=G19PlD7vu9OetqR2wkj2sFklWtfrGyVdRcAXY1McRMzZGX6IGGaUA4L6Lrx/5MLbwQbx95M9JeNpame5YmV0nsw3jgaVwnlCTsOhQpylqiiTt1vr8x2sZJvyvtA3gyc1oo2IYkNCVOcygeFgNCGsiRz106N5XReLicX37+mMqWOB/UFI7StBO5yjILSHZ7e/Ahu8XpatFjlZDjXznnhSTq7KgmyFz14+ozprAiEXAeuAPSYrJ3XbRdJyRy6Vf1TlmZx0sy/OzW4N2wu1v1QuvLHR9LD/Op2V8+b3X0ReT0QImlRRFSGOOMzm8MDIwK0lU57s+m+lKiuJBDRZthB+1g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by CPHPR04MB721690.eurprd04.prod.outlook.com (2603:10a6:380:104::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 13:42:59 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 13:42:59 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 11 Nov 2026 21:47:32 +0800
Subject: [PATCH v5 4/7] dmaengine: move channel devices to the DMA channel
 bus
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-edma-iommu-v3-v5-4-2537cebe6ca2@nxp.com>
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
X-ClientProxiedBy: SI2P153CA0034.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::17) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: a6c22d8b-7893-4b92-8894-08df3ff9b32d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|19092799006|921020|10067099003|11063799006|261009223027099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|56012099006|261026140227099003|261028144727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	J4C+mF/FVnpilpFZD6KeEFnEj2oXZwzch2ffKvoZ8bJbUY9liojNHepMOlH4ve0VYy4oMKaRaRy+LbWRbHAxcOR0gMVArMmubbE76qTt/tGQnAvd6UhXT3H9mSLo/AQH8ET1YxKjkQxudE/a6ajv08hiLduzc4oXSVwILLlf3xsC1Yo+sZeK+AqCfMQFsA4LGWuQuyddYaObkiwxJgRkrvGEVAR/NEjs9Zq/kWJfGImt0nusr+shLTKM6QrISg0d8Bu0gbPy/WYj550fXenNPKsZa0AhR7zD0DV77J2cvau4OyDae5S1SMBQG4AglTAYOoGyfm+BDF/hArtLTvRIzbRf5ljFIbNQdA2jyAYSIU+v2L6bn8ZZlx0GNuwrzhSt+cbRPuPs5W3cPNKnM3vuI1+OED8kxNvAeTZNoi3OFTrDapRMqFZJodEERsVk1UfGtymviZPtKf8H/AC2x38RfFH6wOBkQOEWNoIumi2e2M3xxJt4VKwTscABZrV86Tp74JTDw6A0M5fV+QFqKQPFAXkqT6srzwvzQMq98Qjgf9zM9kIPlktMVyb9q3b0zCxz3iaJXW4875xsws2Gt1nQ4Eip239DvG3m4ihI+DC0PoehBfBTaz5hbWLxVm55o+fgh0ceyfvfw91IueJ7zly6Vh7FztERSbHU9N33Iv11NOiPGObOp6J2oT94N2F8/6lkjLNSYALaCMQ6695JWvi21w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(19092799006)(921020)(10067099003)(11063799006)(261009223027099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(56012099006)(261026140227099003)(261028144727099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1ZEOU9mdEt0SmUvY1llaFNkeElleW1pU2VkdGtDcWtZSlM3TEhLa3BHalBV?=
 =?utf-8?B?eUZDRWR6cDRkeEU2Mmd2dk9DaWxPS0w3YUYxTnoxOXA0a0hhZDYyajNjZFdH?=
 =?utf-8?B?bVpiK1c2V0Nsd29kaWJId2JvaVVaSFF1WlBIV1ZoRVZzWElRNVJuZFJab3o3?=
 =?utf-8?B?bW5uWFpuRi9MQUJhMTN4aHJRa1lIMVVraU1PWmNUTkJGenQyYTlpMlpHY1RT?=
 =?utf-8?B?SE5QT3NCVGVnNUJSUFBUYWJJR1RyM2ZmOWU4YUZiKzBadVFGNHlUelpUVFk3?=
 =?utf-8?B?TThrNjlwMnliSEoyYzBPWmdtWVBPMTA1RSt3bUtmaVRZUnlYZXcyaVZNemda?=
 =?utf-8?B?N3hkRVBOcDBkSUk4aGVKM0ViSktPZDlqb3MxUkI3a2htOXZRakxFalVGL05u?=
 =?utf-8?B?djdJUkc0d2FiR0VSV3dKRnhDVE16ZERXMmw1d3ZPbXVVSzhFQkNtRksxWVpn?=
 =?utf-8?B?VjhYbFpuUEpsOWNJdm0wRG96OWNGdExHMzBDZjRjUUJaMkQyVXRNRk8vTEZV?=
 =?utf-8?B?SGd4ZmpRQTdQdk9CNXAzSER3U3RhVlFRYmg3MktESWRTTjhmZHIvek05SWx0?=
 =?utf-8?B?OXRVbEFBSkRPQWRYY1hoRWNpdkRUdTZwQVRmRHV0S09lYUkzdGpaQWd3K2JW?=
 =?utf-8?B?aFpKWkROQlBPNzM3NTY3UHEvWjFzaExPZndUdnJaZTRJYVl5L3lEY2FBUUFL?=
 =?utf-8?B?RjVYRlVwbzZrYXBjUVl6b2hyNHFhY0NKT0pNOUQyWE54WEhKeW9WeGRpRDZw?=
 =?utf-8?B?UTAzcnkvWm9LVFZ1R2ZNYmhnNUx3aGVvWmsyZmpsRjRBNGlBdlRYcnNZOVpi?=
 =?utf-8?B?cWQ2SEk3VmlLbXFTbFVMRFhDRjRENUt1dG40MmV6NHpXdmx0VFZjeVRRT3dC?=
 =?utf-8?B?alRITTYxSVZORDg5NW9USnJJU3Z2cS9uSmIvY0VKQS9NQU9sTmc2dVk0VDdh?=
 =?utf-8?B?WGN3aGRJWVFKYytDOGI1WEluRUk2OGpwL2NPdStZdURmUFRQY1Z0SEZQRmI5?=
 =?utf-8?B?KzNUR3ljWllYdUdVU2pvZytmMGlJUTdOYy9oWVRLMkIxbDhnc1V2NXhxZ2cw?=
 =?utf-8?B?TExFbGo5Z0NaVWVWK2M3OHpkUTU5RkdkU1JhMkhIeGhJN1E0UlRKcmFER1pU?=
 =?utf-8?B?N3Y5dDZRSVdwS1d4Z2NmVTgwTmFETVBEYi9yWGlVK05XMnBIUWhSblBXV1pa?=
 =?utf-8?B?NGV5a1pjZEs2U1p2ak5CM0wrMThHdVkvcVg5NWFGZTJNa2Ftd1B3YmdZcjh6?=
 =?utf-8?B?VDFmRDA5cTFHaFVIV3B2OHczLzlaMW9JZTRFUWFuSFRtODlFMU51Wk5tSEdW?=
 =?utf-8?B?TTB2bGk3ZVZPd3N2NmlEeFlCeFR3R3JSZ1Z5bVFpaDhwRVZLZzJKOTY0Nzg4?=
 =?utf-8?B?a2t4TEpWQTNjVEtQdkZZV2dXVDVWeEVLTm5MRUR3MDRxcEFYZjVYbnVmU1d0?=
 =?utf-8?B?c0NCUWN4VmpjTWdHVUw5ekZBQVNqQzFadFNwMVA5UGVrRkhnc013ZUxhVUNN?=
 =?utf-8?B?RDhyNXVod0VyT0VTbnR5L0NLMk9sTzB1K2luU3BsSkhDQjNvQU9nSnE5VzNn?=
 =?utf-8?B?ZS9qenl6N0FGYnJCcjRaWVB1cG85c00vbmYvWThsNUdwV0tsVmhyYWdCZEVa?=
 =?utf-8?B?S1BrOE5WU0pzLzZWUDlVM0F0UTBMODRmSGZMbElITkFObzY5NXZYUDQyUERN?=
 =?utf-8?B?b292WUp2THpMVTVaVnlTRlRpanlNSzNnMTFMWlBmemlNTkYxMjl2OVQxb1NG?=
 =?utf-8?B?MFd5bWxHV3Y1T01tWnpRekxlUHpDdVhINzAxMy80YVlTZzlkNnNZQ2RDUFVU?=
 =?utf-8?B?WVBaMnBzY0pzQU5nMWhYQWtmRE43NE9FdVZBTVJXV0tiZWZVTjU5Mmh6ZU1S?=
 =?utf-8?B?R3JubWE2aWxxazJMUjFGMXdhTWtWNjVDYS9zdCtMbS9OdXR0TkJlYUg4cDVP?=
 =?utf-8?B?MVphSmUxTzRFbTB6TlpXaXBxZjRyYXZBeC9hTHpZYmZmOExTL0NXUys1OWw5?=
 =?utf-8?B?VFZZNnFNOS9kZWtERitDdTFka2tpUnFFOEMzOHBOQ2dzUXppV0tjQmwwZGhP?=
 =?utf-8?B?c0ZsY2w4Mm53Z1RBQWFKQzVyclMwQ3diN21MaC9SRlljOVFnWGlvck5ST2J6?=
 =?utf-8?B?VzNXWExxYm5uZHlmQXEwZFRJVk1aM1d2eG9wTDFpTUc2QkxLN0NUM0RLdHpY?=
 =?utf-8?B?T1JoR1pWc0xyOWY3T3NhMmJOVDlWeUM3d0lVL0FuYnhiSjFHZGZHL2VCUWgr?=
 =?utf-8?B?WlZJZUdMcXRDVzVEQkM0dGtlUDBRbTJBK0FMYXhrTVVLY1NEU29DWWprS3Jk?=
 =?utf-8?B?cEljMzIzcVo4ZFVWdTBFSy9VODdZM09XL3I2R3ZvSExpazZUNFpOUVdjZGZz?=
 =?utf-8?Q?zIAhvlgc3aMhfUcaGHXclsrFEo82mrJqDYuQb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c22d8b-7893-4b92-8894-08df3ff9b32d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 13:42:59.8106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dF/KI59WmMBC1gmqU83q2zxqaLWenPEF0AfRbSPdbQJ82AWVEOSTqkrCtlkgwv8GoYM91wedM+jsJab1YGaN/KFa3K0dXwyjoiCovlxjZCE7IElIk5T7bB6fmvuIHc/n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPHPR04MB721690

From: Peng Fan <peng.fan@nxp.com>

Register each dma_chan_dev on dma_chan_bus_type before device_register()
and make it a bus device instead of a class device. Setting the bus
before registration lets bus_add_device() take the bus subsystem
reference, so the matching bus_remove_device() calls drop references that
were actually acquired. Attach dma_dev_groups to the bus and set the
device release callback directly.

Keep the existing /sys/class/dma interface by registering a class_compat
named "dma" and creating a link for each channel device. The channel
devices now live on the DMA bus, while /sys/class/dma/dmaNchanM remains
available to userspace.

The bus is named "dma-chan" rather than "dma" to avoid colliding with the
SuperH DMA bus, which is also named "dma" and is registered later from a
postcore_initcall. As a result the device's uevent SUBSYSTEM and
"subsystem" link use "dma-chan", while /sys/class/dma is unchanged.

Remove the post-registration dev->bus assignment from the Tegra GPC DMA
driver. Leaving it in place would overwrite the bus selected by the DMA
engine core and reintroduce the reference imbalance.

The DMA channel bus match callback never matches, so no driver can bind
to these channel devices.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/dma/dmaengine.c        | 27 +++++++++++++++++----------
 drivers/dma/tegra186-gpc-dma.c |  1 -
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 9a9d54d8f7c6..36f5a12641cd 100644
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
+	dmaengine_chan_dev(chan)->bus = &dma_chan_bus_type;
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
@@ -1650,8 +1654,9 @@ static int dma_chan_bus_match(struct device *dev,
 }
 
 const struct bus_type dma_chan_bus_type = {
-	.name  = "dma-chan",
-	.match = dma_chan_bus_match,
+	.name		= "dma-chan",
+	.match		= dma_chan_bus_match,
+	.dev_groups	= dma_dev_groups,
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

