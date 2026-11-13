Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794576149;
	b=FZukBegeqBCyhGK1Ajm4tptZMgbxbLG8zrwMWP5SatRfW7+m84i/81u6/4Pg5goRxQ4+
	 sPfcYKfzDNoegfGtq2ndLY3qoMsf40rOdPn6lj37yXRvINdaeNFIBo/9KHKHmbz5+hxLX
	 UDKV9Y8qC2/7DEXCTEDGoaxzJwCY8/ur0QevYZTetsXy6oCcBrMdyRR8UkNJqfXarDYZh
	 xc1g7CH8MDbh1lDjzVQxWuPYig0yMX29jCPp9VwlUmiUvdV/++n0aYmP6mLfm9sgQ0c3c
	 14s7QDhZD9L/nQ5qPWhA6cYzjAY9GEiKDDPaQNHSOqt48Lx461kRnhs/1r/VBl8Viww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576149;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Subject:Date:
	 Message-Id:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-ClientProxiedBy:MIME-Version:
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
	bh=8v3w/aEoZTpWjygO6G7J7DD8VNhhx3+dBO1SDto7aBI=;
	b=o8H1Opb7LLGqirytxZY8M8kJFJdZopqsFm6ZP33IT2P3sQ1DGzYktRpXLXDWbtTcNi4T
	 4UVZk+BIjan6iRnSVNfUp9+HkxhIbv3WigGNa/KT7MNTdbG9IFkSFum4/dQuu6SOQdb0J
	 88CBqse297yzDvf1rhVPuGwVhbZu/3jBnUZSPFouPRG8FrFFe6ogM3RmTTNI6YzRUdNeb
	 9MlETAH6BCIFnTShFWTr2DEI9qae6nQBH+q7gyj5JtZpnAQ94PzeLZXCSwbc2W+xysW2s
	 da4wSKvqWpTI+RUEud8mWaA1x7ExwhYoCe69BQAQ07DbG3HUVoZ2QiAfEEHYT97mbWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=e3AHCKUi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.67
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010067.outbound.protection.outlook.com [52.101.69.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C15D606A33E
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 13:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C15D606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=e3AHCKUi
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hgr1kto+vrnj5w58axHEfGsHFSxmfXklSJehSoJb/P7cazVB8UCUlYwmAECZ2o7gYxTNHU+PaDI/yRd4c1xFnlIOnx1sVYAuAdL0ixPr9uOJb7M9hJ9x7q6Aw5OQp/DrSclpubyG4U9I6we7clK3kJiNno2n2GhZeCHVFzZI6snzWxm7h7XRN0n/MLzP4gr8dMx8A6p2yYfYWwDIg6OmUYaKnxEYhpC7LqWeciSry5XwClZDcFqGk/pQGiI9JYU9Gv3H2IO1Fu5M5gg+UHQtv8IEJJv4hxynC2cphEElw83ISJWoe7+QmyKxxW4kxvNMbxyYCyQSt+zjhIzqjE4TwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8v3w/aEoZTpWjygO6G7J7DD8VNhhx3+dBO1SDto7aBI=;
 b=BKG3KuafISs4Ho9343w2XOaC3RwMXpc93cAMQFK2AGZ1iWzJJvbRfPwMAkiaC2s53BXfex5FzGbmRS/puEGDM5RnsaUN7KzRctABKhVgv+mKFumNJ6xOKxvC0IWFqrh8dPy0dlyaf3T2+fN2Fk85Xb2m0Cu4f2iQMdOMBvxPlAPNyTQwfi0+8ilw+IAruB/fjvEZgilmQaF0gHfocqOeR1tImf8wh1wRq2cEi7mK4GOF9FCbrlllHuOSc7MWmLzSH28nZaNxx19xpx1Ok5APkLkH2CL6yQfKcNlS0wlPJF8H3kngb6W3uYxxAaMyL5BrO88GX1+NdRR4p1HyUNgB/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8v3w/aEoZTpWjygO6G7J7DD8VNhhx3+dBO1SDto7aBI=;
 b=e3AHCKUiEWWRG5f2ZknG09G6uBfL9GsKX4XjCMAKGBOJv58A1epxvaeUeJHwI2Kg8zEqYsfsePedL2dmde8GmeGAg/Wpn8HrHwKg6lDRjd5LYhzdsPr4sIJyFuWGSCxqD43/ZyIb6qvPFtdF1jEAItH9ScDRLquzeh+CGVa9uk9cIHnH35xxDSY9RgGj0GX5RRVA/20v6ZiebLnDLrdB8tmMg7x4WZ12VXEOilbqQ739FBsaL6XIX1FgB3EvmD51FIHupQd2Mae88tNdyr3K/QFUeDo3yh0S5UckQcFOqKs3sZpj1yIU022WJKPAyhIVUBaw/Fgibst9X/AoQzFZ7A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by BR2PR04MB007356.eurprd04.prod.outlook.com (2603:10a6:2c8:6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 13:22:24 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.008; Fri, 13 Nov 2026
 13:22:24 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH RFC v8 0/9] iommu/arm-smmu-v3: Support shared Stream IDs
Date: Fri, 13 Nov 2026 21:27:12 +0800
Message-Id: <20261113-b4-smmu-shared-sid-ver8-v8-0-587307a77f3a@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADAQ92oC/yWMQQrCQBAEvxLm7IC7mhC9Cj7Aq3jYZFozQqLMm
 CCE/N1V+1YNVTM5TOG0L2YyTOr6GDLUq4LaLg03sEpmiutYhRAiN1v2vh/Zu2QQdhWeYDVLhU0
 peWXaUbafhqu+f+UznY4HuvxPH5s72te3ScvyActcSheAAAAA
X-Change-ID: 20261112-b4-smmu-shared-sid-ver8-d6e35dddd5a9
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
X-ClientProxiedBy: MA5PR01CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::8) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 38acd955-5e92-4485-9406-08df41892758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|376014|23010399003|1800799024|18002099003|6133799003|921020|11063799006|5023799004|261102123227099003|261026140227099003|261028144727099003|261026121527099003|261022075727099003|261022113327099003|261022105027099003|261021121427099003|261021135927099003|56012099006|261021123027099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	8jnnNdI5NNcYbs/M35GypXlxR7askkOeWx2Yx5M8Vp1cj+O0bLIZNlpt5nWPqluMvdB4tNvl1D0ii+YAAH4HF46iXGOqKEfLpKKQTEi7kWVgy5AQ6NIpWC7xykr59Y63EuxiQBD5bpVasUm9bHuS9N8k8sPlFn0VmQ2e/pUe+cqG2FkEJzgMkAplhRm+qb/V9QQ1+nEbX43BFRS+f5kK/KTPYyQHFb5uWrtGPjTtgQM7Uvvb0QNOUjfD8cfMQ/lgFIOTISqcz7KmrqrYLlIjlkw1g41KIAxpQQInTPJbUwHib+rRozNbtYruqXcdIYb+ow3akNqaA+xgPS5qEWG1zvNJeVS4Oaj2FCHaUAUHaHvgS9AG2mkGx2sbKBAV8n3e52KosqvRITOf6oe5r/BPxkT0ic2lybNE9XkNJnh8GDNTFpOBS5/VmcVr3GKMC0UETFqrYWfBQFejS16eSGqiAbST72xfMwb4g3x7Nj+f3b3C1/NA9fSlIZ8LgYXRzwnFWnXoh1nKbGob1JuNFR6bdgHjur5zKRp8rY1eUComRAPCpn0kupM2HtW19+oliElMiKUvYUk08PZZHl6uu2ioRfKaZXTMXnnzYtZhOGw1oQu6uzF0bUvTC8/KmnRbEcFeXyG5L6wNETPI0bSKjz2xG6+ilGmYup81l+g8RyOeNDg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(23010399003)(1800799024)(18002099003)(6133799003)(921020)(11063799006)(5023799004)(261102123227099003)(261026140227099003)(261028144727099003)(261026121527099003)(261022075727099003)(261022113327099003)(261022105027099003)(261021121427099003)(261021135927099003)(56012099006)(261021123027099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkRPa1JlZnBmYWtHcGt5eVJ5aTd2UElJNHNhcTQxRHVPbEVBVkJzM1hWbFZP?=
 =?utf-8?B?RHgrVG9sMVduaFFnbXZGQ1NuOXBKS1l2NEQ0bUREYVRjNXhMQVd1d1BSYVk0?=
 =?utf-8?B?YWgzelY0dHI1clNHM3VJUzA2eWZFKy9TSEZuaFV1TWtheSsyN01iNkkrQW0r?=
 =?utf-8?B?Z0grc3ByV1ViREpIVkV6MEhUQk5nNHNWM25vM1Jxd2l5bDhNTWI3RThOUGpC?=
 =?utf-8?B?ZWJuS2F2bThObEFHNGZaaHc5Wk5WQVRGdHdyUnhhTTRGdE5Zd251bktqSHRX?=
 =?utf-8?B?Z3NjNVQ2ZGdrNmVyV2gwQWJiaUM1b09ocW16Q05teHQ1c3F1a3E0S1lOMzR0?=
 =?utf-8?B?K2JybjMrbmRBSXpOWlZLd00xVGY1Y2I3VnJuN1grVEJRekw5MkVDTTNKcHhl?=
 =?utf-8?B?TFpDbEwybU1JbURVZXBlOVNIOUdrQ3FUaEY5d3UzS1I4Q2RLSlFveGZhcHZo?=
 =?utf-8?B?K3RpKzV0c29SZUZoVnB2cGtncFNuWEcvaWZTVkRoM25tbW5uQU01VDYyL3RG?=
 =?utf-8?B?Z3pNdUhYd3B1Vi9iMDFLbnUzVUptVHZPRUZwTEpBc1FOWmFGQTlzblZMdm42?=
 =?utf-8?B?MVFpbStKMC96bFRZczg0eWUrVUpSN0dGcUl2VXhlVS9KWGVtVWhpbDNvd3A3?=
 =?utf-8?B?dWdwaFZ1a2FTL3FJUmJzekpCN1o2MG96eXBBOGR3ekdNeXFjZXZ5Q2s2QU9t?=
 =?utf-8?B?STB1U285WG5pclA3YkFoYldCWnZyWjRyOWM0ZHNqcFo4QWJZc3JYYTV2bVRP?=
 =?utf-8?B?V3ZTN0JwVTR1L2dQcTZBMWJFTlVPNVN3Y2Z0elQyd0pvL0FsekRmTHJGV3kr?=
 =?utf-8?B?UE03ZVBrQVl0eWxkRzR3dXZJdDI2bjEvOHFrK2dpdFM4ellkM3RZTVJ6bVVG?=
 =?utf-8?B?TDhKVHRma2pCY0xxZk5CRU4rdDhHZFhNYi9BVXYrY3dVUWFlbElJNG1ZdFhK?=
 =?utf-8?B?dUhCQ1JMbWN0bkM1eDBJenNzYUcwcVd2ejJLWW1SSENTUWxDTTJmUUE0Z1dP?=
 =?utf-8?B?bVRnQUR2K2JHZGZUdVZOLzViUTRGV01jQVBjbTFIQ05HOW5kMHU1L0ZGTGdn?=
 =?utf-8?B?Q0RCNDQrRU1iV2RuR0ZtVjYzU0ZTMlcvNnhmMDJrMVU2VmZsdks4bDJhTllL?=
 =?utf-8?B?dlhFYW1jWSt6TU40bUxsTHg1M0xtU0dESWFjcTNIbkxEWWI5enE1cEdJbXo5?=
 =?utf-8?B?NzZIUWdpN2MzRVV5cUt0K2gwWDQ4WXIrcHBSS0p0YmZNUmFERmsyTUVuT2Ir?=
 =?utf-8?B?bHRSWDc2WklnckM5UG8wODY5NHZCSVBUUUpZa3M4SklkaVFxUzNJaUVrcFoy?=
 =?utf-8?B?WXNtNlZVOGJlY0NETm0yeDV2QUJadmJhQjFZeTF3aXNlRU9wQlF5QVY2amFL?=
 =?utf-8?B?aUN5WWZ1UU84a1I5ditRM2k3Z0IwZEY1dmYwZzg3Z2JGZG5xZTdBOUFmTjAx?=
 =?utf-8?B?Y0NHSkJLbUpGWUpuRyszR0IrYit0b1hNc29BQUFNMFRWT01zQUdCZGxZaVRl?=
 =?utf-8?B?RWRIQTU4S0lHSGxldVIrOXBvUWkrYjdGaE05QXh0VXBuS29ITmhoaGdERXIx?=
 =?utf-8?B?RzMvWkxFWmtSZWtuZVR3OFA0eTh1TEhXVzJ1MTJIMThENUZHOUdVdzZxa2xB?=
 =?utf-8?B?UGNhcVNYQWd5ZFNrRThiNDg4d2cxYVJHSXg2WVFGV21vQ3lIZlRoRVZldEtC?=
 =?utf-8?B?ZkhQcGRkS3RBZnZpKzJwd1NpSWJMUVFBUGp1QUNVSXpYajl1ZGFGRTc4VU9n?=
 =?utf-8?B?d0F3cFc5OEdycGZPa0J4bTFvc2V1UDBIeDVralM0NDJ6YU0za2FaRlozWXhL?=
 =?utf-8?B?bDZ2NWFQR0t6NGhzcHA2NkluSXFNVVFRYjB3ci9xKzdUbWhUZW0vaWY1aXhH?=
 =?utf-8?B?SkltbDltY01BZTRwUFZwWEhkdVA3eHlsM0dzNUhwem1VaWhmZi9BRUJtNjQ2?=
 =?utf-8?B?eHJMUmg4WmJ3RTJFcjR4N3YyTms1R29Wd1ZNR2VJemo0b3BLdDJnN3lQQlhz?=
 =?utf-8?B?V1dKb1Q0a3lwY1YzZWJ5czRmZ20ydHphMUVmN3BCMDRYTlg1bEJYL216SHk5?=
 =?utf-8?B?OExyM1NxUTJWbmZSUWpMbFlnTnhVWXVMSjUxNDYrbHBBNFhmdDdTeFFiTW0x?=
 =?utf-8?B?M3JpK2FnaG5idldnNjdNZFB2K29TRFQ3ZVQ5b1VDQVltV0JTV1R1SWpONDll?=
 =?utf-8?B?cWY2K1FFd2hQSndVOC9wS2hPeFpsM1BzSzg4cEpiQ05qdkhOZDZuVi9xWXhr?=
 =?utf-8?B?bmMybDlHRmhzcFJqQ1hGdXlJTlZheWZsMVo1VzFCMmQ0eXdrd1hxWE1LVEZp?=
 =?utf-8?B?OWVUTTVsWWNZTTZ5VWNKMU9GbE9BR3VKT1hNQkxGUlhoWGt5RlJ3THZCWjVY?=
 =?utf-8?Q?v+dBfkgZYTZ5qFm2hEsH8l9Fq/330BPgd98dJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38acd955-5e92-4485-9406-08df41892758
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 13:22:23.9714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: psscjFQ67uysUAPoxblLZ426kV+k3DY8znu8wC+S7dvP4HEYjcYKvxE7RMd45lgqsowD3H9vTQaJMYf+5+WPfcsxxCbsXEVQ8+bdP+aWC+5yFucJLGkXw4wISQdUoOT5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PR04MB007356

Changes since RFC v7:
- Add a locking patch that serializes shared-SID membership changes with
  attach/PASID/ATS/vSMMU using arm_smmu_asid_lock. The lock order remains
  asid_lock -> streams_mutex; arm_smmu_set_pasid() rechecks membership
  under asid_lock, and the vSMMU checks in iommufd and Tegra241 vINTF are
  moved under asid_lock.

- Add a PASID teardown patch that quiesces the PASID before mmu_notifier
  release can unlink it. Clear the CD and invalidate ATS before removing
  master_domain, use a no-account CD write from arm_smmu_mm_release(), and
  re-clear the CD without accounting after unlinking. This closes the
  exit_mmap() use-after-free window and the used_ssids resurrection race.

- Fold the CD[0] allocation fix into the per-domain CD table patch:
  allocate CD[0] as part of arm_smmu_master_alloc_cd_tables(), factor the
  L2 allocation into arm_smmu_alloc_cd_ptr_l2(), and free/reset the new
  table if CD[0] allocation fails. A later identity/blocked/stage-2 attach
  can no longer find an allocated table with a missing CD[0] and warn in
  arm_smmu_clear_cd().

- Fold the in_ste fix into the per-domain CD table patch. in_ste now means
  the STE actually walks the private CD table, not merely that the STE is
  S1-translate. This removes the "first" special case from set_pasid and
  moves the redundant-STE-write guard back into arm_smmu_update_ste().

- Separate the per-device release domain from the group-wide blocked
  domain. A shared SID skips the release STE only while other sharers
  remain; a group-wide blocked attach still programs the abort STE.

- Complete the vSMMU gating for shared SIDs. In addition to
  arm_vsmmu_vdevice_init(), check arm_smmu_master_shares_sid() in
  tegra241_vintf_init_vsid(), arm_smmu_get_viommu_size(), and
  arm_smmu_attach_dev_nested(), and reject sharing with an existing master
  that already has a vmaster.

- Split ATS capability from ATS support. arm_smmu_ats_capable() describes
  hardware/PCIe capability; arm_smmu_ats_supported() also requires that
  the SID is not shared. Shared ATS-capable devices are prepared through
  pci_prepare_ats() but ATS is not enabled. Existing masters with ATS
  enabled, ATS-always-on, PASID, or vSMMU state reject new sharers.

- Reject shared-SID configurations that cannot be supported safely:
  multi-SID masters, stalling on either side, incoming ATS-required
  devices, and PCI/non-PCI SID aliasing.

- Resolve stall_enabled before insert_master() and use
  master->stall_enabled directly for CD.S, STE.S1STALLD, and STE.S2S.
  Remove the redundant arm_smmu_master_stall_enabled() helper and rename
  arm_smmu_is_shared_sid() to arm_smmu_master_shares_sid().

- Do not propagate attach_dev() failures when dropping the last PASID.
  The S1 RID domain now uses the same ignore-return policy as the old
  identity/blocked downgrade path; the private CD table is kept for reuse.

- Propagate arm_smmu_attach_prepare() failures from the identity, blocked,
  and release attach paths instead of installing a partially prepared STE.

- Fold the CD table allocation check into the free helper, add
  arm_smmu_master_needs_private_cdtab(), drop the trivial master/domain
  free wrappers in favour of arm_smmu_free_cd_tables(), and rename the CD
  helpers:
    arm_smmu_master_alloc_cd_tables()
    arm_smmu_domain_alloc_cd_tables()
    arm_smmu_master_get_cd_ptr()
    arm_smmu_get_cd_ptr()

- Restore the normal group return style, remove the unused downgrade
  boolean, and keep the S1/identity/blocked handling under the equivalent
  !ats_always_on gate.

Changes since RFC v6:
- Add "Plumb the CD table into the CD helpers" as a preparation patch, then
  introduce a per-domain CD table for non-PASID S1 streams. Normal non-PASID
  devices in one domain now share a single CD table; private tables are kept
  only for PASID, ATS-always-on, and stalling devices.
- Rework shared-SID STE handling. With the domain-owned CD table, all sharers
  build the same S1ContextPtr, so any sharer may program a normal domain STE.
  Release/blocked STE writes are skipped while the SID is shared, and the last
  master tears the STE down.
- Keep CD.S per-device rather than deriving it from the SMMU stall capability.
  Stall-capable masters use their private CD table so CD.S, STE.S1STALLD and
  STE.S2S remain consistent.
- Add arm_smmu_master_stall_enabled() and use it uniformly. Reject sharing if
  either master wants stalling, and resolve the stall policy before
  insert_master() so the incoming master's policy is visible.
- Reject sharing when the existing master has ATS, PASID, or stall enabled.
  Disable ATS, PASID, SVA, vSMMU and IOPF for shared SIDs.
- Link to v6: https://lore.kernel.org/linux-iommu/20261011-smmu-shared-sid-v6-0-cb76b89dc612@nxp.com/

Changes since RFC v5:
- Actively deduplicate Stream IDs during insertion instead of
  storing duplicate pointers. num_streams now reflects the unique
  count, eliminating pointer-equality dedup loops from all cleanup
  paths (Robin).
- Extracted arm_smmu_find_stream() into patch 2 instead of patch 3
  to clean up the find-before-allocate code (Nicolin).
- Extracted arm_smmu_free_master_streams() helper shared between
  error rollback and arm_smmu_remove_master() (Nicolin).
- Fixed remove_master to reassign stream->master when the current
  owner departs, preventing dangling pointer (Nicolin).
- Fixed remove_master to use a for loop iterating master->streams[]
  with per-stream shared vs non-shared handling (Nicolin).
- Reset ste_installed on ABORT so domain transitions (e.g. DMA ->
  VFIO) correctly re-write the STE instead of freezing it.
- Clear stall_enabled on the first master retroactively when
  sharing is detected in arm_smmu_insert_master(), not just on
  subsequent masters at probe time.  Prevents bus lockup when
  the first master probes before sharing is known.
- Link to v5: https://lore.kernel.org/linux-iommu/20261006-smmu-shared-sid-v5-0-169a59c671d3@nxp.com/

Changes since RFC v4:
- Include Nicolin's patch ("iommu/arm-smmu-v3: Don't rb_erase() a
  never-inserted stream node") to avoid conflicts in future.
  so the standalone patch 1 from v4 is dropped.
- Split old patch 2 (shared SID support) into two:
  - New patch 2: Convert streams from embedded array to individually
    allocated objects (struct arm_smmu_stream ** instead of *).
  - New patch 3: Move stream allocation inside the mutex and look up
    existing entries first (find-before-allocate), avoiding unnecessary
    allocation when the SID already exists.  Pure refactor, no
    functional change.
  - New patch 4: Add shared-SID logic on top of the refactored code.
- Duplicate-SID cleanup (bridged PCI) now uses pointer-equality dedup
  instead of RB_EMPTY_NODE checks, since streams are no longer
  pre-allocated with cleared nodes.
- Link to v4: https://lore.kernel.org/all/20261001-smmu-shared-sid-ver3-v4-0-06b34fb2e691@nxp.com/

Changes since RFC v3:
- Added a standalone bugfix for duplicate-SID rb_erase (new patch 1).
- Stream structures are now shared directly between masters
  instead of duplicating them (Nicolin).  No ref_count field;
  sharing is detected via list_empty(&stream->shared_masters).
- On owner removal, use rb_replace_node() + list_splice_init()
  to transfer the RB tree entry and shared_masters list to the
  next sharer, avoiding use-after-free.
- INIT_LIST_HEAD(&stream->shared_masters) moved after sort() to
  avoid list pointer corruption from bitwise memory swaps.
- Both sides of the sharing pair are checked for num_streams == 1.
- Link to v3: https://lore.kernel.org/all/20260930-smmu-shared-sid-v3-0-8abe6c1b4c20@nxp.com/

Changes since RFC v2:
- Dropped the RB tree to XArray conversion patch (Nicolin).
  The RB tree is retained as-is; a new arm_smmu_find_stream()
  helper provides stream-level lookup.
- No per-master shared_sid bool; replaced by
  list_empty(&master->shared_masters_elm) (Nicolin).
- Only SID-sharing for single SID device
- Follow Nicolin's suggestion https://lore.kernel.org/linux-iommu/arG6hmng3NddGEHm@nvidia.com/
- Link to v2: https://lore.kernel.org/linux-iommu/20260921-smmu-shared-sid-v2-0-4b656ce68178@nxp.com/

Changes since RFC v1:
- Revised cover letter to drop eDMA channel example (Jason).

Some SoCs have a limited number of IOMMU Stream IDs (SIDs) and
hardware that inherently shares them. For example, the NXP i.MX95
only has 64 SIDs, only 6 bits for SID in the system chip bus.
However there are many device IPs, such as SDHC, PCIE, NETC, GPU,
NPU, Display, VPU, ISP, ISI, JPEG, SATA, DMA and etc. Each Kind IP has
mutilple instances inside the SoC. So I introudce this patchset to
support shared SID.

The current ARM SMMUv3 driver rejects this with:
  "Aliasing StreamID unsupported, expect DMA to be broken"

I took comments in [1] and implement this patchset and only want to
support a very simple case that multiple platform devices share one SID.

Patch 1-3 are preparatory refactoring:

  - allocate stream objects individually so multiple masters can point to
    the same stream;
  - delay stream allocation into the streams_mutex-protected insertion
    loop, reusing an existing stream when the SID is already present;
  - plumb struct arm_smmu_ctx_desc_cfg through the CD helpers instead of
    always deriving it from the master.

Patch 4 moves non-PASID stage-1 streams to a per-domain CD table. The
private per-master CD table is retained only for PASID substreams,
ATS-always-on/S1DSS, and the stall model. It also allocates CD[0] together
with the private table and tracks private-table use in in_ste.

Patch 5 and patch 6 add the shared-SID object model:

  - link masters that use the same SID through stream->shared_masters;
  - keep the stream and its RB-tree entry alive until the last master goes
    away;
  - transfer stream ownership when the owner is removed;
  - group aliasing devices into the same IOMMU group.

Patch 7 wires up shared-SID STE programming and feature gating:

  - separate the per-device release domain from the group-wide blocked
    domain, so a single-device release cannot abort a shared STE while
    other sharers remain;
  - let any sharer program the common normal-domain STE;
  - disable PASID, ATS, vSMMU, SVA, and IOPF/stall for shared SIDs;
  - prepare ATS for shared ATS-capable devices without enabling it;
  - reject ATS-required devices, PCI/non-PCI mixing, multi-SID masters,
    and stalling configurations.

Patch 8 serializes shared-SID membership changes with the attach/PASID/ATS
and vSMMU paths using arm_smmu_asid_lock, keeping the lock order as
arm_smmu_asid_lock -> streams_mutex.

Patch 9 fixes the PASID teardown versus mmu_notifier release race: clear
the CD and invalidate ATS before unlinking master_domain, use a no-account
CD write in arm_smmu_mm_release(), and re-clear the CD after unlinking.
It also avoids propagating attach_dev() failures from the last-PASID
downgrade path, as required by the IOMMU core.

[1] https://lore.kernel.org/linux-iommu/DU0PR04MB94172CB3F138AD39E9B6DEEF887F9@DU0PR04MB9417.eurprd04.prod.outlook.com/

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (9):
      iommu/arm-smmu-v3: Allocate streams individually
      iommu/arm-smmu-v3: Delay stream allocation to inside the mutex
      iommu/arm-smmu-v3: Plumb the CD table into the CD helpers
      iommu/arm-smmu-v3: Use a per-domain CD table for non-PASID streams
      iommu/arm-smmu-v3: Support shared SIDs in insert/remove_master
      iommu/arm-smmu-v3: Group aliasing devices into the same IOMMU group
      iommu/arm-smmu-v3: Wire up shared-SID STE ordering and feature gating
      iommu/arm-smmu-v3: Serialize shared-SID changes with attach
      iommu/arm-smmu-v3: Quiesce PASID before mm release unlinks

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c    |  26 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |  11 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c   |   8 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 739 ++++++++++++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |  27 +-
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c     |   9 +-
 6 files changed, 632 insertions(+), 188 deletions(-)
---
base-commit: aaa2f954c21b205a0bcd0961e5b2be4e82e58455
change-id: 20261112-b4-smmu-shared-sid-ver8-d6e35dddd5a9

Best regards,
--  
Peng Fan <peng.fan@nxp.com>

