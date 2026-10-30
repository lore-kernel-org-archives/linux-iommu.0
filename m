Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.27
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793361930;
	b=48Ubf4Sa4N9qzZ8nwqsXDXatOFu11ugeyt7koLDpB+RcD/VTRsv0bMaog+tvYORTt8aE
	 fWaRzxpmf9aO5xvDSZAFUM4e5Wlonb6Eyz6bh8VRld9JrG8ulF2YmzW3xm46QcZx7bOgF
	 9D2OmPZA6Iptfyw3ovkodXlhpM1tBsOdcbBJS36XSaxKAEkSPYylEXZPsI3MV6PYrziv7
	 w1Vzq/ZvWzcsq2m0ncb0U31Sq4fe8YNISaxTitclGdowvJegJlXEt/klpah4eiD4QkP/s
	 yUybnxCwUv3ebJQRNUArH8wo/zKf4JvxyYTcryK0x3zl22lgQpFV6z9NtHuvy/kUu1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361930;
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
	bh=qHY+GhMSeIbNRpYCC6q0HBkFyoOrOzX8MkB4/QMigw8=;
	b=Fr7VENn6tDdDBRJzSGvk9EQ80Domqjd6pnrAP7BNbZfY8jY5ZCMptYy5bKhPwpJrHXyx
	 mwdyV1d2CmF59MswQQ0BImA7hWbYKcrWNkKW90Bbu/tD1Pw3NPFFHkEiLoizYXIfacj9+
	 8rEy/rEShWPpi/HIgTNOGp5T7isSlovvssET1cw0FMc/FeW5RxfEvckDwiCmekeca9zjB
	 gu4LjQZRJY27S9PkwZDKmIUsNn3c4VPcgWk4RYVKIgadCyhhjvUrq5+KgNgrzELOpIBLX
	 x4voNt8sHPgwkCGlCFPAGTUe2oSzT3/97OnoUPaQ3j+hz1r4B8jg7nLUBpXnhC+t6vQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=xCn9wFKY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.27
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013027.outbound.protection.outlook.com [52.101.72.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00A9606A31F
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 12:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E00A9606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=xCn9wFKY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZY3hbVTguKjC3JRy7fuiYH2G5sTvIflo+LUW+bZISotlXtgHxjpWxqctXwKVOOpwJzmDjPQlQ1demHd4BRnM3H/h3facrDiSlxiwf4WxKjlDt6+xYlVVmmkSoa4audeqfLZBeCEGl/7SuKOMUDRc3Z70GRv98DubfoLYO6FsPDj2qQQMDlek8FirZ3etXhjLPFL1kJgysW13dO0P+9fMhQtheQZFVFDwkg82oLASUc9wuIaT1Y272T4j4x7kjYfL3YIap1+65VN82uT/vbqcAwcYMqfGztQv5xbIj4H/4o3LKF4NxhyVen0kHQ5UN5XrvPuuggtfLb6hYDBEGTc5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHY+GhMSeIbNRpYCC6q0HBkFyoOrOzX8MkB4/QMigw8=;
 b=e38nN7CPf3qNqTf9qFaF4I10gNVDMnMUr5viynKQiCw4f161hFAnEQA9rPscToa6EOcF+ruudWLYMYBDMHyIgp0Du7z/93LOUC+Lq3rJQ1LBqADAPtdJ6YwXJRO5vq7Wi8JbH5vQPvaqhqobu9c5qJrUAG7+qxVa6jmIu16H4TU0yRhVaqNhJE7UPiEo9BOc2EfC+mka6NzaUe6QXbn+3N271r2G0nLIRvwIJ6R6WzjpW0H3Vn/M7ADx5ePFiBi2/tmIbZdqbEc8RitYAHpBm/+5+x2Iz1MFVY7w6FTLA937bXbsnZDSngts98JGqBCVg7KYPju81DgmeNCOWSuCsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHY+GhMSeIbNRpYCC6q0HBkFyoOrOzX8MkB4/QMigw8=;
 b=xCn9wFKYK9ZASXtPD9nL9cv9AkFUoF6Kx3/dkb6lbdobb9rD0CNjIij60nP2nnrCl8ADgO0Ix6ebMV3U2jfZASbULwLXzlkYJIG3Al75orA+buY5Dg/paIGbQg3yUuSSctC3+XSjxw4VgmEPeyEzmEQ0ZGs1myVYB5IqWFtzCCCuNMywuOEMbqktHS2Xvdgpd/MuwrIRh6YcCaUptDcYQoPaA72Qm2XLnf97rraLXMpJ8oGgG/jfe68NMWgvFbs9Xu2BEgf+LV4O2okeTWLCKCtpR9SaFuFK3t+v3dDOqwVpoOjpD1qdLME74lzcj+VkDYPuZGBxQsHgT4j1uZPv5Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AM0PR04MB12002.eurprd04.prod.outlook.com (2603:10a6:20b:742::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Fri, 30 Oct
 2026 12:05:27 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 12:05:27 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 30 Oct 2026 20:09:38 +0800
Subject: [PATCH RFC v7 6/7] iommu/arm-smmu-v3: Group aliasing devices into
 the same IOMMU group
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-smmu-shared-sid-ver7-2026-10-26-v7-6-961726ebd6ab@Example.Com>
References: <20261030-smmu-shared-sid-ver7-2026-10-26-v7-0-961726ebd6ab@Example.Com>
In-Reply-To: <20261030-smmu-shared-sid-ver7-2026-10-26-v7-0-961726ebd6ab@Example.Com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Krishna Reddy <vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
 Jean-Philippe Brucker <jpb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AM0PR04MB12002:EE_
X-MS-Office365-Filtering-Correlation-Id: 28d2e34a-649a-414f-a061-08df367e15c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|1800799024|23010399003|366016|22082099003|18002099003|56012099006|11063799006|261028144727099003|261026140227099003|261021123027099003|261021121427099003|10067099003|261009223027099003|261026121527099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	sjym4tjBOSJiRrth97aLJZvDGPvKwRR1mrt9MEpPSIqUChdMD6a6wCZD6GjyCZt+SVLJkgasxfMXblO8qVpFHHUGtg4vK0jpmN7R1243AeHR8DB3l0NiUIYap8Q3Tl2vs+PvQHn8LNf4fTfpbdanIY3EkyzL3dFtaPKZGoz2DfV5IWg6ruAn3sflpnwjncN25Zwz7/+ILiZAYSJ5ZY5OXG8OWpPiDC0SusYk3dWc1ylRfjsHHzM8NhbetpWIs9q6Yu3AIAxrb+zwXVqMkkgfPunF++oZ+Me/ZXvWHyBqRwV/amHd2bzc5IHt6fklntwXVyxzH8HZ36hVtM3t2SM76499soRef7FAE7DAEfOgqhXYs0+PluwbhSq/eUsu/pVqaHz1Y43utdddNHVAzdRYYXofdCGFr2MHDTiILgEQXyXo9rx8xwjSYaiDqAn5XY5az8nnjJUmeSn6usgkL1Hka2IE/N+7oq+IQoT15xFQVdXSbMOs2VCf1tQN0XjIAc8hlI46ES04axcpTqu9LWMpHvkZedci/H6GKInsOk/d9t/IG4RjZE7WW09TRG/2ANyOmIqERGChJ0089c0ktDdxw+AZJw59uTyMB/nDzqB1MxjRpix7gnPqMyhxKdKeLJVvYoCI70e9kcyVXKT0Tq8O/3hJy0jNhAnExlysN163aNU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(261028144727099003)(261026140227099003)(261021123027099003)(261021121427099003)(10067099003)(261009223027099003)(261026121527099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnRocm9HY000dkY1OGZhcGJEeDZDT2w2RmJSWmtvOEpNeE9TWGhuTWZYSHVu?=
 =?utf-8?B?MGZ6WlZ5ZUs2TmtXK1NyZVpQUzJtenJZR0NVSHlXVFQweWlyMVpLcFQ1SWdN?=
 =?utf-8?B?VDZFYWhCbGp0SEQ1T2RJMm9Hajg0QUZ6R2ppMTk1MWN6bTlSbUJGZElvRlo2?=
 =?utf-8?B?YThlU0J0SlZIY2EvYzNDMnltOXIzR1M4WXBLSE51anNxTktuVVU2OGFDTDZq?=
 =?utf-8?B?b1RJZkZBalNNcXAzc204YmxOWWFVMmZtSE9xYjBkbnZvbWFOSlZ1eXJrbVNj?=
 =?utf-8?B?c2RFNU91UGFCRjliTktteVVpWVYxZW11WndBdEY1Y21HMCtyZDFkYkZwQ0w2?=
 =?utf-8?B?QmF4Y0cwcVNCbkxhUFZqbms0Z0pwK0xkNU1sZitJelVBTndTZmxneGdTS0VM?=
 =?utf-8?B?UDhscXRKc3JmZGFGcm5PUkxpSmUxSEJpUGd6bkhZRVRCMjdXRFhPemdiTk1j?=
 =?utf-8?B?LzhSRUtucmhob1gwMTJObFVRcjBqNXVBV1BGZXlOOU12VVkxUmw4ZFBIZlVy?=
 =?utf-8?B?YlR2YXR3Y3Q3T0lxdEhKZW1xUVdwaDZ6S1BVNWlma3IzaEg3S21nQnVXYXhC?=
 =?utf-8?B?WEZoR1ZyRmFPRW02UVBHWUgxZWNGdE9zL01MZUd0cnZGc1hmdFdyelNwL2x1?=
 =?utf-8?B?RHJkdU9qbXU5M3l1anpUZ0EwS2d4MlVlRzJtR2RPeW5KNWM4SWw5cmgwZTlk?=
 =?utf-8?B?STZrSkErQ2lTWHRyZlV3OFcvM0tDS2ZmbVgyckNCc3c3N01TWE5QY0VWNDhk?=
 =?utf-8?B?V3ZLTmlHWmhSMjJQRnp2MjVZOTkvUzVTKzJuWi9Yb3hPTGF5dGMvOVZlOHo4?=
 =?utf-8?B?dDA1cHI0cVpFYmYvMVhxMy9QNEVpSmI0NStVWjJGUkxiUkw0V01WanlsNnlC?=
 =?utf-8?B?UlhvTDQ5cDhFa3E2NDFYNlhmTTlON1YzREwvSUxVNE5HQkRjb1NWcmtkTnRI?=
 =?utf-8?B?OVpNL2ZrZ3lvT1hJbndyWkFGenNOdk1qSDh5ajVrSXRBV2tLKzBEdllkRXhD?=
 =?utf-8?B?aGpGSzFPWUpyV1U1RkZyNysrUGs4eDhuQTVUcVJGNjZMQmt6alpmS1ZkUFc5?=
 =?utf-8?B?dGhqR3JDUTNPdEZJdXgvV0swU3NPb0R0Y1J4VSt3ZjQ2cGk2dFBIOTJuamJk?=
 =?utf-8?B?ZzFncVFlbCtFUXpabHEvNFhtcTVTcVhwMjhWWHlMczNHVWpKd09DWis1MWhB?=
 =?utf-8?B?UmdFcFNpalZXUGdxcS9UMXpObVYvQnhDVmN5dVVmYnR0RjNsNTQvdktSS3Rz?=
 =?utf-8?B?WnhscWFSMnUvTlhTYUdBaXR0ZnR3Yjc3UVZsdlpaVjZ6emFFTmpuZVlkZlM0?=
 =?utf-8?B?TEh2SU9zOEprdW5STStiYWpiMW9QYWwrUWJYV2hUMzV2UHJ0Tkdwb0o5SS9Y?=
 =?utf-8?B?ZW84Ulo0ODJsWXAvMWxFZ29GejVObUd0RDB2cXJOdFlrQ1Z5ZnNyNWRMVFJP?=
 =?utf-8?B?N0oyOTF1Nk1nVGtXbmZOSkp0WnJ3MG16T1Z6NWViY2ZqcU82OUt1RUdSV1p5?=
 =?utf-8?B?aC94SjZOSjh5M01kSnhlK0VpaFFvUFJkdDVOY2JQSWtaMTlzbHlDeS9MK25z?=
 =?utf-8?B?cXlUYlR3WldzVGkvQWY3UW91WDl0eGk5VEREaDZrZGtBVlZJR2ZNOGorUC96?=
 =?utf-8?B?SDJtYjdDMGF0SmdlcGoySGNTTHBnOVdqWmZZV0dRWDdmNmJNQlA2bGZsTlJv?=
 =?utf-8?B?OGxWbGpQVXNLaXZENGtxV3owV2JwZVJaL21pS1Q3MG5mdGRIaDlyT05jK3lC?=
 =?utf-8?B?eURDYW80bDhLWTJaZ25LRzZINFRXQU1NRkJqOG4rc3NZZmFoSkJhYTJqUElh?=
 =?utf-8?B?WUhpQ0JHWUl6MHN3L0VudWVwRUNlZUFUTkJkZzZQbGxwVFhOdnRsVW1hRnpV?=
 =?utf-8?B?Z0ZwQzE1Wm13K1U0OFRBVlBCTzFBUzFlNkN3ZGtxWFBJSUtQRTRkRSt0VEJO?=
 =?utf-8?B?ZkJNdWdvU3NOK2EyREg5TkhGeStUbDVEY3RVUzVnK3hGdDlDeU9IYXoyRjVP?=
 =?utf-8?B?OEJxL01mcXZLemRjbWUvNjFOTjRvd1lvWGpVMHJOTXR4RlVzSHR3a1VNRlJw?=
 =?utf-8?B?SXdiTXpvMy9tVDc3UWFBOHB1U3V4bVRYUStyMG9VSG8vNXFUaXk5TXE0VFpm?=
 =?utf-8?B?TlZXR2l3Z2RiWWpjWTRhTTMvZXhBeXZFa0FxdlBncUZ1emFVNjVzdkNzWW5n?=
 =?utf-8?B?ME5qRjlpNkJtQ01PNFFQM2h0SGQyMy8wN0RQRmpZU3N2TXNETGNNK2t1dlBR?=
 =?utf-8?B?Qm5aZlZzNnNxYlBidU9IdVB3Vk1JTnNET1h3MHR2bDZoMUQ1K1ZmaWkwcUs1?=
 =?utf-8?B?THpBMXZnQXl0Qm1CVnVHUXJnNnlENWdOcXhYRTJzYjJXejc5NXNSMHpQL21K?=
 =?utf-8?Q?vLaP1LgPKPzo8/zSCEIgDab5sLfU1Tg+bT8FB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d2e34a-649a-414f-a061-08df367e15c2
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 12:05:27.1366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jSH/mDfv/WQtv0YyiMlL/jUbGVjFCEmkls+h2kc3LVMcqRtMjuCOkmoCtq9G6YbtLvukKONJq0Fscqw0+f3KtUtrrJ25agprGEf93dEUVKpTLci94y/8zLElQE/Bu81a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12002

From: Peng Fan <peng.fan@nxp.com>

Devices sharing a SID must share a single IOMMU domain because the STE
can only point to one CD table at a time. With the domain-owned CD table,
non-PASID devices in that domain share that table directly.

Detect SID aliasing at group-assignment time by looking up the RB tree
for existing owners. Since probe_device() inserts the master before
device_group() is called, skip the device's own stream and look for a
different, already-probed master that shares the same SID.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 33 ++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 605d4179caaa9..0ff513f9e0bc1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4690,19 +4690,32 @@ static int arm_smmu_set_dirty_tracking(struct iommu_domain *domain,
 
 static struct iommu_group *arm_smmu_device_group(struct device *dev)
 {
-	struct iommu_group *group;
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_device *smmu = master->smmu;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct iommu_group *group = NULL;
+	int i;
+
+	mutex_lock(&smmu->streams_mutex);
+	for (i = 0; i < fwspec->num_ids; i++) {
+		struct arm_smmu_stream *stream;
+
+		stream = arm_smmu_find_stream(smmu, fwspec->ids[i]);
+		if (!stream || stream->master == master)
+			continue;
+
+		group = iommu_group_get(stream->master->dev);
+		break;
+	}
+	mutex_unlock(&smmu->streams_mutex);
+
+	if (group)
+		return group;
 
-	/*
-	 * We don't support devices sharing stream IDs other than PCI RID
-	 * aliases, since the necessary ID-to-device lookup becomes rather
-	 * impractical given a potential sparse 32-bit stream ID space.
-	 */
 	if (dev_is_pci(dev))
-		group = pci_device_group(dev);
-	else
-		group = generic_device_group(dev);
+		return pci_device_group(dev);
 
-	return group;
+	return generic_device_group(dev);
 }
 
 static int arm_smmu_of_xlate(struct device *dev,

-- 
2.34.1

