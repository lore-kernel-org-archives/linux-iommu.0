Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793601960;
	b=ax+EekSEqw+S2nFTPTu4FHhN9WnXzZ0exAYZER19AjlbFx9GpE+mEb30dK4P5fsUZSFS
	 rd3KD3FN/qDGWi5JtVRFUIe1j2RQdqZGWhF7N523z9rIpUqI3NrGD3YK/oo9sh2ZXiU9S
	 j91xya21RFejd7D1mQ2uxKz3YK8f4R1bok+oDjP6/YdE7Kcce1xAI53b0A1eTcJb1bnxu
	 Np1Ed2TCiTyJvarYw1kW6cTcXd4+ohicz4+IXy2511tr7RDVgwCOhYXkOlZWeV6WJcouF
	 6TiByoO/c2waPzlDBbIzqKr5TbDmgcEO9wOrzEhlpL0fvVrBs/odpht4Fdpd49ra0ZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793601960;
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
	bh=h11dyyBEUCWCN4VFp6zTVf0TqX7/kl9V9LfEZOTNra8=;
	b=B0Ku6nIulr3n+3lHiFMWd7KyrtBHM7R+ZATZFKZB64RKNuPlH/KHLUOqMlBUm7lnpKah
	 W5ifepvZS9J7mL/2QY8lGfsjC1A/dpLpBZwNobZhO13zH8ThtgVnliMcabnz49kTgxwQz
	 tf7wiFT4EFsHqMi1m7sWE65A/U6UDsN0qv2nj/zixRWFEBwtaS7iMgjtq2swRsHqLWHCx
	 ZnoBSrPkvDU9g+sdbZZuRsieUXKEwqmlDMgOfEB/fGYX6EIhE8D77Yyg09JH2VEjGRXtx
	 vz/CizV/9XnxDtS0X8NXr5jpYNBWvO12EhOx09fAMoYw5qAOWIPH+ESl8Q2Fk4VcSMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=lW6SSOcd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.31
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010031.outbound.protection.outlook.com [52.101.69.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EC8606A32E;
	Mon,  2 Nov 2026 06:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75EC8606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=lW6SSOcd
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=spRaYTmj/zXeHbwxI2Oq7isr8CmN6kSvObewA7GYzB1iSK9OALt7YzLhTCz+yS498AuCCLP+pYPibwUFE90GaYKD66o4VDDBRETE8w0PfcMuSBXxZqYrarqwoxCVb7uERGhzPmu8/MKCRmM/e3KgDgrC8+x+O3hdHdDudoMt4eOv2Z1A+UGT/CPW0FwRcvJy2WQiJMAonY/MOubesentqsU1Be8lX1GlwK+EQRPjNLajwapWQsuxSgVr6KgX17pRCU5D0JY4dIY7qy3EV3FAnMUWhB2DpEOBlOOWX/ODnCq2eruUakLRBH2ICYDx0V5aT4vdYJh+bxNXFsuSyNqZRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h11dyyBEUCWCN4VFp6zTVf0TqX7/kl9V9LfEZOTNra8=;
 b=asnUOUOIPFuHJT62nEbFFNvhAkbQ3cwTyIo/DPwhhFYNlf60bEZ2fD/lTRbIeVbhJdaNIFOQxm2JGNC2ueqNiTp5qiCwchbnjCGI1sZXTGWem9XCBd75WemUBvBt8pS72jEez6olTuebpB9p0dyCi0juu9PX6INsOW9A09Rj62mCpCRv2aVZ4yU4aCfSQaHZrL0mQ2ubIXiwjZynDplPlUlwntrNoIjwdvJkltO/Lz7MoSAmbh+F97nxlaEhH6VMiIj+LqX3qC08HI1OouLdiPo2AMutom3ymBqOlGab8WVy8Srx1etnq7VnDX07Jopmfkh7zHORaigfcTiouYQdBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h11dyyBEUCWCN4VFp6zTVf0TqX7/kl9V9LfEZOTNra8=;
 b=lW6SSOcddJnkNYNiQiRTA6itKkfzfNvnhOeqhM92/kZoJG6xyrD8wKXxDG6ftyoWnFlsqTxxM0WhV5ql/+C2ybk4vF5ARR29tpHu7Eeu9GmZD1dsauV5LRYS9ToYk1+dn/J62o3/lDjTPEecfLd72KQ7wJvlEraj2O3O87TSJULgHHNjd44aUidTkwjaV2nP2Oj1XwnZSz8lf0ZR90vgtCE0JHzouXNtJA8ZBJkPy5hL6GzvSOtqIw2IjpOHlDm1SuIxn6bOgAEuuirFrMvwzDVwgKxskGNWDNUPNdzk3cL37Gu/Ww5PflJpUsVo8EhsB4e1cTFb8d8YqkUNrC0wqA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by GV1PR04MB420767.eurprd04.prod.outlook.com (2603:10a6:150:803::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 06:45:56 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 06:45:56 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 02 Nov 2026 14:50:00 +0800
Subject: [PATCH v3 6/7] dmaengine: fsl-edma: support per-channel DT child
 nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-edma-iommu-v3-v3-6-9d0e62a954eb@Example.Com>
References: <20261102-edma-iommu-v3-v3-0-9d0e62a954eb@Example.Com>
In-Reply-To: <20261102-edma-iommu-v3-v3-0-9d0e62a954eb@Example.Com>
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
X-ClientProxiedBy: MA5P287CA0071.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b3::10) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|GV1PR04MB420767:EE_
X-MS-Office365-Filtering-Correlation-Id: cdba7fcb-ecc0-4fa8-3c78-08df38acf246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|376014|23010399003|1800799024|6133799003|10067099003|22082099003|18002099003|921020|56012099006|11063799006|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261022105027099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	Gh6HbCvStQyUfhD8Oq1tknVjlTW1Tz0m8hCYHp91iI2vmOntef+0e5PD45Krhg1ZdBwyWQIy6OKQiDZwDtgJtNVx73hNxt3UD2jJOXzAIPEsDBij2J4nlyCJA9FC1Ij71/jQvTjIZbeZl+6DN1CsVR8EvObjIKpH3U/jREFmnGSGQeYCm95lyt6WDkj9X+14hRmtCv5y8PqcoZ4fFTyTmBORQzkI7jpNVh9JsPH6VtKwDPSwfurmWwQPeC2AtngPSF4lBguTMmYPmvXphSsNmN8QGHmXWojdIrMTqExgENgKxl2UmxSQuK5tfbtFc8VSmO8oh69pbYvPjbHemoc34dGp47jjfRX42/Lwd+a5Ta+AD2k2dGzl3E2dSzuYuW8vTQW3GbYrYCKKkSTstIWpAbNPW+qMXN2kbhvCcX88zR3aSieKNuPJBwD4qL0/XMBsacIXOksYKNPMzqXCeONW9A0uugMIiiEwIKQsAhHMl5213+ozhYfzOg8kHz0Cpyn458IO777h5mS0qFFNnAfvH7RoacfRKpqQ3N4tRL/5PLoEkw9CbcMbixjAXRgIkMelIjL+9TIgOL+NQMvIsxawBf0kU9HXlNEBVA0xdlxKcq9m3In19jlZc02b1Ug96tZGEDmXElqTq9EpXlUGIZSbcZE1xb9L7h7yhFEUXwnyhcc9To/0lGp/ieAQaZtzNqSxZRdxMIyfW+x0aMIzVEUKag==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(921020)(56012099006)(11063799006)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261022105027099003)(261009223027099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WG03bEFBam9scy9TelpUa3Q1dStpeG8vUzFldWJhLzdJbjVidzJNdkFXb2dX?=
 =?utf-8?B?d3RuMWl6MHM1dEZibWpzZHNyMHJtckNNeWhnQXppNzZ3aE5XR3UySXdxYlVq?=
 =?utf-8?B?djQ3RnAxajZFanVmanNFRnlkWmhvMWhERmx1aHg0azVPbVd4aTdKaTZlR29G?=
 =?utf-8?B?STVSVVZKR0ZQNjVzaUV1bkk3czFBdEtSTDZuTVAxcDJXcXF5a1V0MjdsUnRG?=
 =?utf-8?B?RnlXZXpKODc5YXYwbFhKMUJHTWU2ODdybnFrS3gwMFMvVkgrN2cydVFqWWV2?=
 =?utf-8?B?S2tTelNYMWdTb3lqRFR5aHVWYk5LdnI1cERpT09YQUE2d2laMjBPZUFUVFJD?=
 =?utf-8?B?bnQveGh3a0NnZmRHU1pPakYwVldLUXFxR1ZoSkt5RkRob1p2OXErd3I0NkYw?=
 =?utf-8?B?aXVoMk9BSVI2MmhWU1hXSlVERGRHVktTYzZNRytHODFXcjRNQ1BTZ1YrMEFS?=
 =?utf-8?B?aU10ODhQZ2k5V0szeXNkNkhBQVpabGh5dU0vM2NYS1hsdWNFekZpdTVVRUdx?=
 =?utf-8?B?U295VTloT3U3OTdwc2FKUXZOdTNseXgwZ3lTV0VyY1ZsTlV1VDh4Uk1WLytS?=
 =?utf-8?B?MGNod0NhUlYvWGRQcUI0S21oOEwyUjVrQ0UyWVk4cjBrMVJ1UkF3d3ZRWmlE?=
 =?utf-8?B?N2Y2UUtQUytEVGJLSGMzR0hmbDVMZHUxWU9iNmFJSHJyYS9WUlJRMnJtVVho?=
 =?utf-8?B?cThHM1oya0hrWmlyYjU2eEh3OC91YklERFhUeUR6cXA3ZndPejJqZ1ptVVhL?=
 =?utf-8?B?SFlMOWZHTGVRYndHVFZmRS9zcFdhNjZ1VjJycTRnMEtJSmxwd0FOL3VENjla?=
 =?utf-8?B?QWEyRHQ5UDk1TVNOSTRDaDFhelRYMjNxR2Zpejd5RTFsSDB1aWVOMjZ3YnU5?=
 =?utf-8?B?K2xCNTdrUnh4OWZmWmZmaVdLODJ1L1ZERmE3WjFQdXplWGFvUlRscGhpdXcr?=
 =?utf-8?B?VVk4WHlmaVFydjdsdC9jVGd6VWljc1B5RkdyVGo1VWNuWXZjN2ZJVEFxK2tP?=
 =?utf-8?B?OFJVYjZ3ODVSV2I0b1NqU0hqbWZPb2JRS1lDVkpCSkFhY1lTbWZzVlJrZDlT?=
 =?utf-8?B?WXJxajQvZlMwMjRzR2RBVC9XRlVjcnE2T3dKUmNKc1NUUmJoOGdVOGNGK3E1?=
 =?utf-8?B?MkNoTFAxNmh3M3NnMWxhREF1U3pGdzhFaHZNcFhWNTdDMVlRa3psOFVibnlT?=
 =?utf-8?B?M2IzUTZZRThOck84bUpwcVhicDZkOXJkU3M1ZnJLZlUyWmhYM2NZQVBha1c0?=
 =?utf-8?B?aW1SdnpRZUtSdHNWRjl4Q01FdktySnp6THNkQ3Bxa2pnUGVIS1dSbDA5Zlow?=
 =?utf-8?B?eTU1dEpzbUdQNjdBUzdpd1FXci85RDlocWJZYy9wZFk2SzU3OUdrSSs1VCtL?=
 =?utf-8?B?U0pDdTN0NUVGQkZQUTQ2UDlCaVgwKzBodmFadWNoQWVDTE02ZWc2Z3hwVnBQ?=
 =?utf-8?B?VjB6ZTBUL3hIdXpTQ3gzSFpUb0tOdnZNcXVFOUJwaVROZ041TjF0dTlVc21k?=
 =?utf-8?B?SktUeDAwRkxKaE1zNHo3K0U3VlE0UWxjemROVFhmalBic0J3TE5lVmRpZm5r?=
 =?utf-8?B?QlN5SEowa0lWaUd6Mi9ST0poWjJMckVmQ21NKy8zSmhzQmRmeHBQZlF6TVZX?=
 =?utf-8?B?aFNpTjBNSWE2KzgvSmFHZEhvUThOajdTeGJTQjNzeS83WjNyYUMzOW1xdmw0?=
 =?utf-8?B?M21kRnY4VXNEWmEzaXh6VitkMlVoK0ROcnFST3FCc2xrT1N6djdxaUZvVjBw?=
 =?utf-8?B?MUxKNFk2M1NvWG5GOSthSzJVK0U4dTRVVW8rU1h2S0VYMXh0N3phN2w0MUpn?=
 =?utf-8?B?Z2J4MGZoWGJ3cmxySzVjOTdwSTRwZ0kzTHYvVDJtTEhYQVRSRGt1L0xUZlFu?=
 =?utf-8?B?YTdDNEkyd3VZbmsybnFPOHhFNEpwNklHKzJQRUpyTEVvWkNBV0pUWGc3b2Vp?=
 =?utf-8?B?c3Z3Uk5rTTF1bCtiTGFLYlhIeDlnZXUxdjI5SGhoRUdUclR2cStsRWplMDN0?=
 =?utf-8?B?cGtmaVh5akxtNElYczFncU0vSVR2NFZ2M00yaUFzTERieXE0K2pjcDMzOXhM?=
 =?utf-8?B?cHpwRElqWDFIQ2VaYThnTXYyc3prMUtxN3kyL0xKQUE3L0xTUnFFNWlyU3hp?=
 =?utf-8?B?b2ZSb0pWazZDVTBnVEJNdDJIMnREU0YxaGhHbzJub0lQMVRFK3dDbC9iV3di?=
 =?utf-8?B?YWtSM1JNTHUxY2hxSVkwbks3ZWJ3dE1GTDYrTytJeno4UzdqMUFSWnlDVnVx?=
 =?utf-8?B?Ni9PVW9jZ2paQTZuSVJ4MXB1dUh2ZFZuYk9wbUZpUmtSZTVjVytyelhaais4?=
 =?utf-8?B?dHhrN09zWDVyc203ZlVBMy9BbzRNd0lEN0ppWmZxZVF1UEJseCtxWEgwSzFX?=
 =?utf-8?Q?+vc7AT/I6mbEWQeqivtg3RNIryon6jQRV+KnD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdba7fcb-ecc0-4fa8-3c78-08df38acf246
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 06:45:56.2270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7c7evty+RGIzvIlm8GE9GI3pVzyQnC9f/y5pTqXHXcja0eUEO3pS6F70ROTRxY1UtU9VjaaaLA+FaOrNWW9cQs15S22ooPaCDRXYCPBGQVZtfQRlH5D1R817pkglRHPH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB420767

From: Peng Fan <peng.fan@nxp.com>

Add support for parsing per-channel child nodes from devicetree.
Each child node can carry its own interrupts, iommus, and
power-domains properties.

The implementation is split into three functions:

- fsl_edma_child_to_chan_id(): derives the channel index from the
  child MMIO address relative to the parent base.

- fsl_edma_configure_chan_from_dt(): called before setup_irq() to
  populate per-channel txirq from child interrupt properties.
  fsl_edma3_irq_init() is updated to skip platform_get_irq() for
  channels that already have an IRQ assigned from their child node.

- fsl_edma_configure_chan_iommu(): called after
  dmaenginem_async_device_register() to configure per-channel IOMMU
  by calling of_dma_configure() on each dma_chan_dev and setting
  chan_dma_dev so dmaengine_get_dma_device() returns the per-channel
  device.

Existing DTS without child nodes continues to work unchanged.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/dma/fsl-edma-common.c |  10 +--
 drivers/dma/fsl-edma-main.c   | 152 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 152 insertions(+), 10 deletions(-)

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
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 30d548a723462..795744e67837d 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -16,7 +16,10 @@
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
@@ -400,12 +403,13 @@ static int fsl_edma3_irq_init(struct platform_device *pdev, struct fsl_edma_engi
 		if (fsl_edma->chan_masked & BIT(i))
 			continue;
 
-		/* request channel irq */
-		fsl_chan->txirq = platform_get_irq(pdev, i);
-		if (fsl_chan->txirq < 0)
-			return  -EINVAL;
+		if (fsl_chan->txirq <= 0) {
+			fsl_chan->txirq = platform_get_irq(pdev, i);
+			if (fsl_chan->txirq < 0)
+				return fsl_chan->txirq;
 
-		fsl_chan->irq_handler = fsl_edma3_tx_handler;
+			fsl_chan->irq_handler = fsl_edma3_tx_handler;
+		}
 
 		if (!(fsl_edma->drvdata->flags & FSL_EDMA_DRV_ERRIRQ_SHARE)) {
 			fsl_chan->errirq = fsl_chan->txirq;
@@ -703,6 +707,136 @@ static int fsl_edma3_attach_pd(struct platform_device *pdev, struct fsl_edma_eng
 	return -EINVAL;
 }
 
+static int fsl_edma_child_to_chan_id(struct platform_device *pdev,
+				     struct fsl_edma_engine *fsl_edma,
+				     struct device_node *child,
+				     struct resource *parent_res)
+{
+	const struct fsl_edma_drvdata *drvdata = fsl_edma->drvdata;
+	struct resource child_res;
+	u32 ch_id;
+	int ret;
+
+	ret = of_address_to_resource(child, 0, &child_res);
+	if (ret)
+		return ret;
+
+	if (child_res.start < parent_res->start + drvdata->chreg_off)
+		return -EINVAL;
+
+	ch_id = (child_res.start - parent_res->start - drvdata->chreg_off)
+		/ drvdata->chreg_space_sz;
+
+	if (ch_id >= fsl_edma->n_chans)
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
+	int ret;
+
+	ret = of_address_to_resource(np, 0, &parent_res);
+	if (ret)
+		return ret;
+
+	for_each_available_child_of_node(np, child) {
+		struct fsl_edma_chan *fsl_chan;
+		int ch_id, irq;
+
+		ch_id = fsl_edma_child_to_chan_id(pdev, fsl_edma, child,
+						  &parent_res);
+		if (ch_id < 0) {
+			dev_err(&pdev->dev, "invalid channel in %pOFn\n", child);
+			of_node_put(child);
+			return -EINVAL;
+		}
+
+		if (fsl_edma->chan_masked & BIT(ch_id))
+			continue;
+
+		fsl_chan = &fsl_edma->chans[ch_id];
+
+		irq = of_irq_get(child, 0);
+		if (irq == -EPROBE_DEFER) {
+			of_node_put(child);
+			return -EPROBE_DEFER;
+		}
+		if (irq > 0) {
+			fsl_chan->txirq = irq;
+			fsl_chan->irq_handler = fsl_edma3_tx_handler;
+		}
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
+		ch_id = fsl_edma_child_to_chan_id(pdev, fsl_edma, child,
+						  &parent_res);
+		if (ch_id < 0)
+			continue;
+
+		if (fsl_edma->chan_masked & BIT(ch_id))
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
+			if (fsl_edma->drvdata->flags & FSL_EDMA_DRV_TCD64)
+				dma_coerce_mask_and_coherent(chdev,
+					DMA_BIT_MASK(64));
+			else
+				dma_coerce_mask_and_coherent(chdev,
+					DMA_BIT_MASK(32));
+			ret = of_dma_configure(chdev, child, true);
+			if (ret) {
+				dev_err(&pdev->dev,
+					"IOMMU config failed for channel %d: %d\n",
+					ch_id, ret);
+				of_node_put(child);
+				return ret;
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
@@ -836,6 +970,10 @@ static int fsl_edma_probe(struct platform_device *pdev)
 			clk_disable_unprepare(fsl_chan->clk);
 	}
 
+	ret = fsl_edma_configure_chan_from_dt(pdev, fsl_edma);
+	if (ret)
+		return ret;
+
 	ret = fsl_edma->drvdata->setup_irq(pdev, fsl_edma);
 	if (ret)
 		return ret;
@@ -898,6 +1036,10 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, ret,
 				     "Can't register Freescale eDMA engine.\n");
 
+	ret = fsl_edma_configure_chan_iommu(pdev, fsl_edma);
+	if (ret)
+		return ret;
+
 	ret = devm_of_dma_controller_register(&pdev->dev, np,
 			drvdata->dmamuxs ? fsl_edma_xlate : fsl_edma3_xlate,
 			fsl_edma);

-- 
2.34.1

