Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794576182;
	b=01xJlOZMd0Mz4HQU4eJ3GFKaggTZ+A6I70uO94yLlV995wnJYbFhbUIqwZWoIQG4rjYg
	 2hXmJgCtB5pqQLSLYaj/frprwoxfl5BnONZHWuq3A49T7HNk9pPkTBNbUN3fJP8RaKlYH
	 qzkgDYFVMMGAz3wfmFBrf1B/Sx97HOZ5TMAcily3Jbf8mmS/pEFaWIrDuQAYrg5Iwa0NY
	 i1x3W2Q+fEUr1iN5hxnR4kUIyV+R6OJq9qna5jSB58lMHjpH5y4LCzmpTc4EfX0r62Yqn
	 gykrA2PHWy3xcOfa8WBGHrAmgH+EDtvCjW2WUTj32p6Jdr1fJScHQxfqSvQ+QrR+W3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576182;
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
	bh=QLmIipwpPeqGbl59+O/lvi6RseyoDRS2qX86rh1TOUw=;
	b=wjA+0jE68USzvSyzZ78g1yX6xhgSURXZVXK7vGriAUJ9eVZdQWHzU9nxGDteGLQit6Zx
	 ++FZ990CSsYSF2+TlpztA9Bo9wsnm0msEQEsw4cooCdYvE0zc0KCmgZio5RXR5z1TjUzY
	 g2a3d+/EWeUst+fl0OD1HPQQnpSjmI/hH63wA+G7JzHBRS0BEf+AHRPefgm8SHAxUI1D2
	 ZosmDsTybf5me++L7oGBREUBTz/AIn4t9pCxa99aejhhpf/ip2hDIBFJ75OhIKg4xbP/c
	 PKcu2/bDehtgxSxWt+k1XNiM+PhsF92WarAFAihjqqiEjxShljl+bVzfN68ctBT5vAQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=uI6D5LM9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.23
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010023.outbound.protection.outlook.com [52.101.84.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D9B606A331
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 13:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90D9B606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=uI6D5LM9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mzh4MHLTKouR6CS65fv4xbu536wVNnSS31JVtxD8d9QqWsDwGSFOsAfdiwIbGT3BC1+rHV/IaKMvCm/Z06itDnGqJNYD7JKznGKQvczTYoACDEiDLXadnavOcyP+XhESEwc30BnoekkNFswVls8KijZ29O3vGJo1CLInuB41p3v+SsMYP06r/74c4+jfFrCkPKRUp1yjYdMpcWiEkb9M8S+DCNc15NsuoAwD83fAAjnMbQ/+I7A4jdvss64xEE3E6C1zVwPgmfhmzYrj0RMofuEy/m4X8nHayTh5x71eSNoKP2mkVyW0Ye8H4lMoXrZKJmitoWqMp8b8acVRF/kH2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLmIipwpPeqGbl59+O/lvi6RseyoDRS2qX86rh1TOUw=;
 b=bVkcZ19ehrvI+TqiifkpvWjDFUGXTlv2xCNkaeTAwZEmHe4lYgLB9+DaRA7VUd+sP20K01868qa8TWG9qmGNoDeq8pdmRp5ZnLIsWAXcpcSPe2qGkFrZaKC9uSxxLKR0gsOTumNenn9fEH5w4Axg7SaAKVpMqt6VhBZymgfb6057/CZsioImseHGLQ4aQdu1mv41Y9dRUhzV9x5POMnE1XCfS8oydkWeogZQ9OJLBSqeIZJZoUF9GuE0w5BUy5nMIs2ag3SxPEqCQ7C6yeApK+0qS94MYt14j1mEUrANk2VYrU0N8KCXsHT1Nn1VSNUdnq7nieHrEe3KEGV9fafP1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLmIipwpPeqGbl59+O/lvi6RseyoDRS2qX86rh1TOUw=;
 b=uI6D5LM90ObZxJFVCeViP6p67aFlK62dY037bDhzyz260CEnYr9Fvli/414Z0KROLln7npK24JjYDfY0E0sEROJviJM9AypYb6zjirQooLzGXZnpmY1SXXEX+/KRdVEaCESAHLk8xru0Q7r7aM4ecTXhWxDngUbCqLLGxSbBLm7830XXApa2F2fCxOxEPJVbGOnU9uGWtn7mxJ24JvUZp2FdKxZJQJZPW8T6fiVEnVXlO4QlYQ95+R4db55c+BEwEn3HHNybfgiUaxazkgvdJ3Iv8qk3FrQsyId3NWYo6ew7sCGhUlY7XR16di/AIr14qUGB+yL50m/Frio3tlm4pw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by BR2PR04MB007356.eurprd04.prod.outlook.com (2603:10a6:2c8:6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 13:22:58 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.008; Fri, 13 Nov 2026
 13:22:58 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 13 Nov 2026 21:27:17 +0800
Subject: [PATCH RFC v8 5/9] iommu/arm-smmu-v3: Support shared SIDs in
 insert/remove_master
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-b4-smmu-shared-sid-ver8-v8-5-587307a77f3a@nxp.com>
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
X-ClientProxiedBy: MA5PR01CA0144.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b9::11) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 5ccc6e58-4970-4e7c-1f1a-08df41893c27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|376014|23010399003|1800799024|18002099003|22082099003|6133799003|921020|11063799006|5023799004|261102123227099003|261026140227099003|261028144727099003|261026121527099003|261022075727099003|261022113327099003|261022105027099003|261021121427099003|261021135927099003|56012099006|261021123027099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	0Mk9Tkf51ejz6w02lA+3WV2ugoApqMidbPeR4uSNoJge+/Nl2f/Urp+jXxE9ANnbjLdXrnylWOwHw1ArPU1m59dN7q8cHB656J3trT4o7iJmI08dtt4NQ47Ee8N8O7EkS7avCfAl1dVE50EUZLmyr6gV98r36Lm6FqPkp+Ws6yrP/3IV0jLgc8oE208yxYSylsXcsoaK8SFMfWC6FfMes9k1YXJudGVYnfTRyknvdA5juIUz18m53gPrR6uPBSgFbB0G3vD13w9xNG0vDk76dCR8XgEvSODVI+8zQ/n2IwCifDMpTUNXNAWnZRqLmSbX1iMm0BUirVlk3DYg0leio/AcTTQkMASTScHa/FIRGhh4vigekV0NRMd0ANG2Lfog4H8KsJAqmeb8PU7Jm9LotYEdD+SUGY5UKbhKA6De7PLrKLXtCjjROueV1JN1IDsXsDCQP7QRjJLiwoHA+O5Hn1hnft2LZXXcUe3Mk3sl2PLlnTgbIjOKhZ4kPaSObVRBHbYWOUXzfG0JCGqrvLLDhAqQIy19hpiHd0CtBF316yHpyhJA2xqTj5+xHTTsLCQJPHDg17isLnz9TvhQaG7o5Tlo3fNdRpnQmllrebIWQ2kHQtY/woAOrYCf/s1tehaFr7aFC/SRtCJmQ075XbuVwuoX4rY+hnA1ltCdW7FRwVw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(6133799003)(921020)(11063799006)(5023799004)(261102123227099003)(261026140227099003)(261028144727099003)(261026121527099003)(261022075727099003)(261022113327099003)(261022105027099003)(261021121427099003)(261021135927099003)(56012099006)(261021123027099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGlKOFN1V0krRE9tT002NkU4ei9tNHFPei9FL1V4WEc5ZHZqb2Q0d05kZjdB?=
 =?utf-8?B?TEpteFVFWVJWcHIzTnoxK1lnOXpQcC9BR2p2SU0vdlZoSGZnTFRzMDZscjgv?=
 =?utf-8?B?d3N0RGRoSHlkRGNsSVF5ajJpSFEvb1BveUVWY2ZUNmYybGIyWEJkWkw1ajIy?=
 =?utf-8?B?aTRJL2c3bjMrL0hLY0toSUVRUHF6Z0NTSHBVS0R2RHVxdzJySnBsMlh4eVQw?=
 =?utf-8?B?b2ZGcWlNSThiRTVYdTBzNzVtcXpBLzk4M2FUblNiL2JkWGlaRU9Ob0RNeW52?=
 =?utf-8?B?T3NtbHY0dGJGaURSdXBQM2dMS3dXd0VKcFd0UWxMdEJialljenJwczY4YkJ3?=
 =?utf-8?B?WGZPWlZ5dW5uTkJIek95US9zN1ZVY0p6aXgzVzFOZ0MzSFk1dFdaMEt5YWRo?=
 =?utf-8?B?ekQyLzRrSHJML3VQZ1BOMC9MVUNYb2piVVlNSUNHVXdqMllNM2pScDVGR3Qy?=
 =?utf-8?B?cFI4V1k1cElBTUNSRDdXZDhLcmZ4c080U2VucHJLdVZ4TWVxcUd1ZlF4T3A4?=
 =?utf-8?B?dXdmTjJZc1dIOFR3OENaVlVPRG44NEZWYVRlWmswdXR5S2QrSlRDV2loakcw?=
 =?utf-8?B?c1Z0NnpLS2ZQTEF2UlVQQUtOQUpmSzNaU0h3MURkajIrbVRaelVhM3NrdTlS?=
 =?utf-8?B?NEpuQndKajNvY0dtRmZOOWROd3ZQbkU3MC9sUkxSOHdWQ1ZQWUNiWnlHMVFa?=
 =?utf-8?B?RUJWM093dHNlTDNlSkxEb2xjVkVubW9WWHhVNnBBY2l2aWdlU0xLcnVzMmRO?=
 =?utf-8?B?eFhUTjdubmNJN2dUSkp0MFlGOWw1NzBGelIrKy8vbjZ4TkdEVndSeGt1akVC?=
 =?utf-8?B?TXJTL2dqa0lTVkxkaGc1bENNYldxOUxrcDc3eVB1anQvbjVXanM5NDkyV0h2?=
 =?utf-8?B?cUNtT21HdEpqYmNCSDQ1RWhaYWV2ZFdrTVpqcTlNaW9vM2RmOXZXakkzbTh2?=
 =?utf-8?B?bW54RUM1UU1JZmNJeWZ2UTlmKzkxdjdnRXVSQ0FQNjI3TmpHbmN6UGRMSmV1?=
 =?utf-8?B?K1YwdU9aS3NuSVl3MjUzM1pkTFIxcGpHUENVQzdoYXhyZjE4WUtFWHFpZy83?=
 =?utf-8?B?N0FYZ0VCOGhsWDlQRTdFTVo4Z3VNeXpmdE1mcWc5WU9PK0llVXBQaFBhMkx3?=
 =?utf-8?B?ZTlIYmoxRWZrM0NVRnh6TzBsWVhUUzM3VVl3RDVMSXdmVUlmZkh1SjJiNzFT?=
 =?utf-8?B?UWxVbWtERFF1bU5uaWhyK0M5WU10cUl5OUhsczFmYXcwUHN2U1RoYkpOaHg2?=
 =?utf-8?B?My9mckE0TzJsVDVtMnZReSsrR0dVN2pEWk1EV3hkbkd2RzYwaS9wd2tTdnJa?=
 =?utf-8?B?YTVONjd6UTJEdDI3WGZkcUtsVzQxMjdyNnlUa3U5N3J6bmJ6ZFpLMmVsR2px?=
 =?utf-8?B?YmRvQmV6L3l3R2htV2RhTXRTUCtHWVc4Sk5CQXAzWkFJOCtCaExlbHRXYUFr?=
 =?utf-8?B?ckRpLy9JczRmeTBtQm96NVM2dCt2ZU84a0Y1Q3ZzcjZkNVM1RjAyR3pFMEJP?=
 =?utf-8?B?RUpoMEppblZLRDVHVE93SEhBSXVpdEltcTBkNTdnMzRqLzBEMnlTWnlVR1VE?=
 =?utf-8?B?MkRwaU1obFpzK3ArWTFjUytJNnU2V2toVlpLaWwybkhnTTM1V2tMVXVDZHRq?=
 =?utf-8?B?UWNsaFBxVHdEMDRDQXltOVJhM3JZQjQ2aWtYTitiUHQrS1hyak9mM0Juam5B?=
 =?utf-8?B?MXlnS0NtR0tPbjVvUXcxZ21Rdnk0QkxXNFI2NnJaZWlPd0M1YU5ZSHdUWWVI?=
 =?utf-8?B?c0J0dXJZL2drVFNTMmw2RVJHeWhsT3RibTM0aHFMa094ZmRGb0FDeCsyUVY3?=
 =?utf-8?B?eHl4MWMzOVZicnowVlBQUGF1S1grbEMvakZGRStVZEZVZ1hYOUoyeEFTUm5x?=
 =?utf-8?B?RTlPdUZIbkNXQXp5dTI5OHQzYXZ3WXQvY3J5bXFHM1Z4VGZKVzhWT0lRMGRS?=
 =?utf-8?B?a1hsVW0vRkZsTk1pVFZna1JRekw2WDhIVkJPaVh4UGFZenlZOTN3VjIxcFAx?=
 =?utf-8?B?SUFOdjduclVkZ0dpUmI4UGxoZjNpTHBLaEZOQjEwcGhsdFNqRm1RbFRTNktm?=
 =?utf-8?B?THpwc2l3eVl5eDN0VFFOdXNEUzQ2U21RdGx5eFI2djF1Qk1zRHdEcmJnRGx3?=
 =?utf-8?B?N2Mzd3Qwd3crYTl1VkQ5UXRxVFQ5S1ZsTjhmR2xobVpldmY4WWdPTGlITG9L?=
 =?utf-8?B?QTZBeCtaUlFjSStkUFRQb2dkYlYwSFowbW11SURjSHRWczNZVVpKRkE3aUpv?=
 =?utf-8?B?NWRLa0djbkFJQmdUWmhHWjRESWZuS3AyMTFGYXhNTjh3ckx5dXYway84N0hU?=
 =?utf-8?B?M3B4MHJEWGtFOTVqOGh4cVBxL053MWlLdHoybWtaV3NhQ2FHazBPb28wbEFu?=
 =?utf-8?Q?io3/Hz+wrzAy6KKaek8Le3BBuOFGU0vFWvOSN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ccc6e58-4970-4e7c-1f1a-08df41893c27
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 13:22:58.8089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8k1W+WHOvCJzki9yGI+kCcf1lLfQWA5vy6/4RfjCUkcP0iyS3dEtqk8brqgBWlBrMg15wNX6nopk5Hg1acsGB5ZDR0wFV0E9140gkTm70lAfkCpVnNlkUVby/+1zpgju
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PR04MB007356

From: Peng Fan <peng.fan@nxp.com>

On SoCs like NXP i.MX95 where the SMMU has a limited number of Stream
IDs (e.g. 6-bit bus = 64 SIDs), multiple DMA-capable devices are
assigned the same Stream ID by SCU configuration.

When a second master attempts to use a SID that is already claimed,
link the masters together via the stream's shared_masters list instead
of rejecting the probe. The stream object is shared directly between
masters - no duplication.

Sharing is restricted to single-SID masters (num_streams == 1) to keep
the STE lifecycle simple. Multi-SID sharing is explicitly rejected.
Sharing is also rejected if the existing master has stall enabled, since
dynamically clearing stall_enabled without reprogramming the hardware
STE would leave the stall bit active and risk an unrecoverable bus
lockup when CMD_RESUME cannot be issued.

On removal, arm_smmu_free_master_streams() handles both the shared and
non-shared cases: a shared master detaches from the shared_masters list
and ownership transfers to the next sharer if the departing master was
the stream owner; the stream and its RB tree entry are kept alive until
the last master using that SID is removed.

Since fault events on shared SIDs cannot be attributed to a specific
master, arm_smmu_find_master() returns NULL when the stream's
shared_masters list is non-empty.

Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Link: https://lore.kernel.org/linux-iommu/Z3r-cBm00tVE4eKe@Asurada-Nvidia/
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 55 ++++++++++++++++++++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 ++
 2 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 091119e584ed..f954dc7361c4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2138,6 +2138,8 @@ arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
 	stream = arm_smmu_find_stream(smmu, sid);
 	if (!stream)
 		return NULL;
+	if (!list_empty(&stream->shared_masters))
+		return NULL;
 	return stream->master;
 }
 
@@ -4462,10 +4464,26 @@ static void arm_smmu_free_master_streams(struct arm_smmu_master *master)
 	lockdep_assert_held(&smmu->streams_mutex);
 
 	for (i = 0; i < master->num_streams; i++) {
-		if (!master->streams[i])
+		struct arm_smmu_stream *stream = master->streams[i];
+
+		if (!stream)
+			continue;
+
+		if (!list_empty(&stream->shared_masters)) {
+			struct arm_smmu_master *next;
+
+			list_del_init(&master->shared_masters_elm);
+			next = list_first_entry(&stream->shared_masters,
+						struct arm_smmu_master,
+						shared_masters_elm);
+			if (stream->master == master)
+				stream->master = next;
+			if (list_is_singular(&stream->shared_masters))
+				list_del_init(&next->shared_masters_elm);
 			continue;
-		rb_erase(&master->streams[i]->node, &smmu->streams);
-		kfree(master->streams[i]);
+		}
+		rb_erase(&stream->node, &smmu->streams);
+		kfree(stream);
 	}
 }
 
@@ -4493,6 +4511,7 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 		kfree(master->streams);
 		return -ENOMEM;
 	}
+	INIT_LIST_HEAD(&master->shared_masters_elm);
 
 	mutex_lock(&smmu->streams_mutex);
 	for (i = 0, n = 0; i < fwspec->num_ids; i++) {
@@ -4509,11 +4528,30 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 			if (stream->master == master)
 				continue;
 
-			dev_warn(master->dev,
-				 "Aliasing StreamID 0x%x (from %s) unsupported, expect DMA to be broken\n",
-				 sid, dev_name(stream->master->dev));
-			ret = -ENODEV;
-			break;
+			if (fwspec->num_ids != 1 ||
+			    stream->master->num_streams != 1) {
+				dev_warn(master->dev,
+					 "Shared StreamID 0x%x not supported for multi-SID masters\n",
+					 sid);
+				ret = -ENODEV;
+				break;
+			}
+
+			if (stream->master->stall_enabled) {
+				dev_warn(master->dev,
+					 "Shared StreamID 0x%x rejected: existing master has stall enabled\n",
+					 sid);
+				ret = -EBUSY;
+				break;
+			}
+
+			if (list_empty(&stream->shared_masters))
+				list_add_tail(&stream->master->shared_masters_elm,
+					      &stream->shared_masters);
+			list_add_tail(&master->shared_masters_elm,
+				      &stream->shared_masters);
+			master->streams[n++] = stream;
+			continue;
 		}
 
 		stream = kzalloc_obj(*stream, GFP_KERNEL);
@@ -4523,6 +4561,7 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 		}
 		stream->id = sid;
 		stream->master = master;
+		INIT_LIST_HEAD(&stream->shared_masters);
 
 		rb_find_add(&stream->node, &smmu->streams,
 			    arm_smmu_streams_cmp_node);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 90ba843989bb..444b88cc67c5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1021,6 +1021,7 @@ struct arm_smmu_stream {
 	u32				id;
 	struct arm_smmu_master		*master;
 	struct rb_node			node;
+	struct list_head		shared_masters;
 };
 
 struct arm_smmu_vmaster {
@@ -1069,6 +1070,7 @@ struct arm_smmu_master {
 	bool				ste_ats_enabled : 1;
 	bool				stall_enabled;
 	bool				ats_always_on;
+	struct list_head		shared_masters_elm;
 	unsigned int			ssid_bits;
 	unsigned int			iopf_refcount;
 };

-- 
2.34.1

