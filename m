Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793361911;
	b=HD7l2WBMfXwH4j0skJT0jR6WXv9W/RgoBlMguI6zUYhDnMzEySs0uLyEqTQntNBxOO3F
	 0j4d73HhPB20CFj/7KhHNxCNmcs8//gLAECtM4o1g84WVQiyfqKw3Ca28Fua74oLg0BBu
	 Uu+FQ44GyT8WDmah6zM5UVLCXl6nprIu9QbXHj/NQYek2/eR1UHsjLlq4QuujXRy8ARts
	 LU/6CNzGm6BmmIlCH+ROGp01cLJBbFnb1/uArau2Uv7TqEKopCnOeE6fPN5XA466xJrq1
	 nXekwniOOWayQzmNQWhbBIN9FjKGsohuD+e0Xrlp7pBr3JCZH42mAj8znud8Hi5a3zg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361911;
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
	bh=FrfVSpFzQVszpwSmDSY7Bm/owvMPl9+zGGGZTZv5YWc=;
	b=I5NBbqZ02MbhO6SLU+xxm/DDLg76S8owDu0D29TXwbFlr7HdokUjirP/x+xWX8SLA6i8
	 97gar/XXuv1nRt49phhD76KdPFqp7oPOJRVa140plMOWi8D3rpzSFvXXia60lMvLUCxtl
	 4he741UOlSjP4y3Trgj525w3b97oKC8utWwkMnMiy8PtKk3d/SueYev9yH7QqphnB9zND
	 sZN3VTKPNIt6l+Kl8arkQk6FgaHXKqoGEW/MS2lPugsVi5LZgElEnJM3h4Ztc+EsIKaAu
	 o0TV+3qv8u8BmkW9Fg6YTeE90ZkRpAXPWQuoImlJItKlJyilKBAj1tNR/tdkwQqGHYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=daYNU7Up;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.10
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013010.outbound.protection.outlook.com [40.107.162.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9818D606A33F
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 12:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9818D606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=daYNU7Up
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qiwMg6jBj8GTIjwe7Lh45NIsy5SbytyqDP1yI1Hm4mudMkcFBgGrlAF7z04Ngm0S6nkz7SOmTEHctPWG5zFOrN7cfVgXb6xzEcbnwqteoDBZpDqP0Az0KJUfoy2gLmy84i893OuN/BBKy0XLqg778qOlJCTD6IpBpHoQZAQ05azByiimLIb+aHoRii5mnuLELq4sKrEYpSx0McvFVwIIqpA8y5MUmaXsxXcgJF39eRdsNBzDZ1DcZFjwf1GT8xeQTUGWcSCevr2oabjIrPd2HSPKyE90hZbHzRCNmeXJXYPcIvowJerMX72IrnCdKnv684EOA3mP0GYCBZ1Y4Cny1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FrfVSpFzQVszpwSmDSY7Bm/owvMPl9+zGGGZTZv5YWc=;
 b=V1DFD+GSzcZNcZ2US311OaKRZWrgZFKgg5pbbIq7jqMEENY+Jud+4VtN6tuXQmfD8A6r374fIAqWLGtLgLM+SAJRCiWFYWlKP2kdSaSoiYNBIKS8a6nbJ+oWLK/z9UGzery7gTV2XAm8MAoPdt839ZFCyMz0JXH/Mai2vAh+eG1pJy0DjLBQxXKZcHVewF/2pEAfFh1R9njoEooDfHrqCqHeZC6cu7IoINK1hH3Px2TgJ/+szOaXAky4K5c6yfOGc3G8t/TsNkFEiBYQUJq5+awBeUajuWvHA2uH2GFN5mxu16VHVJGmiFXP7VKsZV4gADc4sYvPdhATUYeD9j7vkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrfVSpFzQVszpwSmDSY7Bm/owvMPl9+zGGGZTZv5YWc=;
 b=daYNU7UpkMr6+czY/Hm1akstRc8uRjscF7ZcbkYm6jZxqIceVb2Q26tUpAYT8Bv0EEKNVjvop6Tnvpymo1duFFuD1xoGvZrM1PfA/IrgER/J9QOerElz0gVMeRIpB86ZQuyLMaSwcDAzyCejnrxu2KjNl6UWai/q151JSaynoPlYgmBLLb9QXexY6yqcjL4We+N3kVdUe7dKSdz8tc8uE/9ECMUVF16ae/xmOUJ2S7odEKuAZQYUlGEEO8NFOHQLFAt0OKomIY/KvX8gjcI8fOXlrrE5OIPqDBIkQSC4l1DhbxVx5LubEZzlRot61ReNBFJAYxEKSo9s2M+B1Ve2/w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by GV1PR04MB10583.eurprd04.prod.outlook.com (2603:10a6:150:203::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 12:05:04 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 12:05:04 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 30 Oct 2026 20:09:34 +0800
Subject: [PATCH RFC v7 2/7] iommu/arm-smmu-v3: Delay stream allocation to
 inside the mutex
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-smmu-shared-sid-ver7-2026-10-26-v7-2-961726ebd6ab@Example.Com>
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
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|GV1PR04MB10583:EE_
X-MS-Office365-Filtering-Correlation-Id: 8106121c-e7fc-4f3b-9d86-08df367e07fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|19092799006|11063799006|56012099006|261009223027099003|261021135927099003|261021123027099003|261021121427099003|261022075727099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yTSXI2BUsDVADljb1FEiXGcrTy81uY93JmbaJYbRlibpus+iJOFD5bo9lYqmJavSArhJqwWn99RDLSmMGDpwXTDPZRVuH5PCqFUsT+XUil0CTniMb2Ru2hVfOjgpaDmub6fyd7hR1OXSEUE+rKcjodU8Bk4OYYTQJ0yYor4hTu+kLpkpQnNgNmPDHayiQ0s2vcYJArhRX9KpC4SQZsIMjSB5kBG1bItdG7YRAf0xA8WREMOxnG1Lf8hde6VXx6W1UuGt+s74BKO7iDETLocqFFTWyffouVDnR3ITJAUsdgb7kVwaqB9QCpvfxL989VP58CV1r/7SA8rP5hhk+vkWG7Pt3J2tpGVXiGEICsaNSucRNOgksV16O4Ry0A8t2OeRp7+9UebCNkoowcEcodVJ2QCbltpEVlzRmN9gXVN1zc8jCNz9h/NQgOgmj6XDV2Rq0LfZPTRs/xp9xerD89TpYKEtIc74NLe/ppId/LdVQpcebKIiapynVD6UHp9Tt7+CLEJbdxr1hmCgLqE46EzVA745l2dkVWkp5Klt8VbD80G7nOmXibbk6Ju5WYL4j0+262wrwzp6iyCBZ5bytaAFBW3dy9XAwyh7nOJY1BOhcdIeTauFvF+4TMZZCM+Daa/O7ctW7fwR/FL7lE3DECtp28T9A/mEXlaQEe1C3qI7jzY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(19092799006)(11063799006)(56012099006)(261009223027099003)(261021135927099003)(261021123027099003)(261021121427099003)(261022075727099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0FGOFJROWJ3S3lTSkRLRXJySnhxdFloT0RUaG5YVTJMNGd3ZnFyU2ZvMU9O?=
 =?utf-8?B?RGtQMjl3TStkSmJCL3I5aFFRdjBlV3ZwWTF3YTFZdlZjTVZNS0E3a2ViYWI0?=
 =?utf-8?B?T3ZPMXdSVkttUXZmWHpoSzZoV1UvaC8rWkcvVklNdGRuck9ZRnk2MDVBaHFH?=
 =?utf-8?B?YXgzaEpPdW9KMlNMMEFzM1kzN3VqNGVNWG5kM0hsaXdCc3B1MStXZ3k2aDJ6?=
 =?utf-8?B?K2lmNEJDb1IyTFRnOVhCSmNEYVJFcm95ZVdaY241U2NDVnRlTlZNbjBzNXND?=
 =?utf-8?B?cUo4VE0yeGx5MXIxWEErM28vdzBzeUoySHFxS0RNaXZVMUZFZ1VYaXREazYz?=
 =?utf-8?B?czVyNDE3THAzd2hIZk5QY0I1M0dScDVVcEpNU1NJN0pTMVZXWjFzVjZMTVBR?=
 =?utf-8?B?cCtOQ0hmbjR4eFAwb3VVVDlOczhpdE1INkJIZjBqdmtzUjN2NjFnTHRZZWVT?=
 =?utf-8?B?TURJWTc3OGo1a0Y5ZVdpempxMHdVZEpmOXEzMDVHa1NsU29TYXJSVGJ5SzF1?=
 =?utf-8?B?U0xRYk5odkNMeU5pcGhwWDUzcWJvMEh5K0syZ2RCekRrWVhydU5KMzA1WEJX?=
 =?utf-8?B?djRwVWZnSVdQeGtCMjU1emZ6cmJPZndBYUlQdmlmQW1qZS9aUjY4RWluaVZP?=
 =?utf-8?B?MGlBS1dwem9WR0VYREg3OExwS1V1dGl5UjFCKzh1V2I0RWp0alVLWUVSaEdv?=
 =?utf-8?B?Qkl4dFNxTVhBR1RGUFZ2ZEc3WjRLR0lKREdoQ2oxR0F2TUZjNnV5cEhKb20y?=
 =?utf-8?B?ci9qOHc0MXBmOEc4RjZxMlJTNFhOT25NTmZtRW5rbE5Fa0Iwa2svMTBiNW1l?=
 =?utf-8?B?RE9wTGd5QjdRcHNqWSs3ZDFzV3ZzZlp6TENLMjVTcHI2OXpPSmNXVnJxUEFG?=
 =?utf-8?B?YUhzSlJCeHVPWWtRYzlGV0N2elBreEtVUEhTVisvRWpTT1ZNSDIxR0NrazM3?=
 =?utf-8?B?Njc4S2dWKy9RVXNhMkI3UjhUNFA5a0xxZDJRcC93KzI5aHpzN0xQM1FNU3BF?=
 =?utf-8?B?SVIzYndVTUxXa2RjRURkWm1yNTB2aXIrdVdlSWNzS0JtMzZNRUhoNjUvSGNu?=
 =?utf-8?B?akhUQ0xWS0xYTCtQQlhJVVJCZE9sVnFQVFhVcHE2QWJzdWltVlpZRkRtVkFR?=
 =?utf-8?B?NHRVOHloMHpOQldqUFdIZ2FyV1JsK0dlcUkwNEQyK0taNU91bE5nY0JrdWR3?=
 =?utf-8?B?N3NoNkVxOEJ1ZDV2Rm8zM0VZQ3o4UE9xWVZoeElucHM1ZmN6UWYrNDEyM0JE?=
 =?utf-8?B?MzNGSnprWHpkUzZLMlZPM3dja3l6dG9mcDBvS2RuVmN4SVp5eTFQdVdJS3E4?=
 =?utf-8?B?VnBnMVZjdnRscVlFUEhuM1ZVYjd4RHJMK0RhOHdLRklQYXloaTR4QmdZRnNO?=
 =?utf-8?B?bU8vVEUzYjMxMEViVHV3NHZzMDlEUGdreUw3Z3diOWpXUXd0NUQvSzFsYlI1?=
 =?utf-8?B?SU10bXZ4NENiK2xJcDN1dnZrNExYS29ENStsN3pZcmFrM2RKRFA0L0VrSWtR?=
 =?utf-8?B?VWNUbFh2cXowTGJLM1BLdWtZVHlqWlYzZDRHNXFqTDdRMkwrV1Zva3FjemEr?=
 =?utf-8?B?Sk5EdmcvTFo1Vy9pMHJEMWVvY0J3bWhUMjdGSDlJV2p0eDluVGIxS3RRMTU5?=
 =?utf-8?B?SllWM1R2VzRRbmZPMkRxK3gzQzBFdzl4V3ZQd01sS29CNFVzbXlFNXFucjBR?=
 =?utf-8?B?NXNsWlp1d1k5UGcwaU55a3JaMTFlNnQyejViN1FaWkJ4c2twVlJRNnl0Z3RJ?=
 =?utf-8?B?aEpmSVVQZTRvWjBjb245L2FFQmhWSTF5Mnp1c2k3cCtXUnQycmVTNTFCWTVC?=
 =?utf-8?B?RGYxaGNGNVh4QVRHWUN4Q2VOZ3U5Kzd5TkllUTJVdTMraGZLS1l3TkJCbTN5?=
 =?utf-8?B?REs0ay8wbzRjTEhZTTJxaWhJdWRMd0tRdUJ2QWREaTlqMG85WjhIK3pud3Fp?=
 =?utf-8?B?LzU4bjNpbTFqWDR3Rjl1bWwwSHlyQnR1RFpac3drY0xFams1MTdyMmtrbDFo?=
 =?utf-8?B?SWFkb21pWTRObHFtaDc0U05jU1BzRVRSajRnSTVRb2h4NkVUeFpMQUM2cjFh?=
 =?utf-8?B?RmVJOVppSzlMWm95QjA3UmpFdXFOOUVRTU5RbUE5WkhlcXM4UlB4Y0NUZjVp?=
 =?utf-8?B?U0FzY1JXbTV3bjBDSjQ3WUFIWWluSU1RbSs5V1M0N0NSSUJ5cTBxV0dhNTFh?=
 =?utf-8?B?cGZVL0I2V3g0azF2VXU3RC9jVVVWRnA0SXdXSlRReFk4dkJXZVgwMnJmVVJZ?=
 =?utf-8?B?UWtkdFE2VnpHRWtReU1IYVZ4NnFURVJsdW5xQVg3aW9xSzJHODcwVGNzamZ0?=
 =?utf-8?B?Z3FuSm1Md1lKZjNIeHlTUlVSWXVaZ0tqR2pqZkVlQ2poM05jcFpibVN4R2Z3?=
 =?utf-8?Q?HFUoOhoLwBdK6fFlXLbKIwbdst/TJwYWYu4EE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8106121c-e7fc-4f3b-9d86-08df367e07fa
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 12:05:04.0720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+OBMpJ9WFgQQzB986z6PDa6Id/YYzP4COp+HOm/2kN9nUzQbkI+hoidc+jRysiz6KmAZv02R2VZr7+csN3ubCk6Hl7ty3aVvks+xq5r1jzU/RogUqi8o9fRtqSmimQA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10583

From: Peng Fan <peng.fan@nxp.com>

Move arm_smmu_stream allocation from upfront (before the mutex) into
the mutex-protected loop in arm_smmu_insert_master(). Instead of
pre-allocating all stream objects and then inserting them into the RB
tree, first look up whether the SID already exists in the tree via the
new arm_smmu_find_stream() helper. Only allocate and insert a new
stream when no existing entry is found.

Duplicated Stream IDs from bridged PCI devices are now actively
skipped rather than stored as duplicate pointers. A separate write
index (n) tracks only unique entries, and master->num_streams is set
to the deduplicated count. This eliminates the need for duplicate-
pointer tracking in all cleanup paths.

Extract arm_smmu_find_stream() from arm_smmu_find_master() to provide
stream-level lookup, which will also be used by subsequent shared-SID
patches.

Extract arm_smmu_free_master_streams() to share the stream cleanup
logic between the error rollback in arm_smmu_insert_master() and
arm_smmu_remove_master().

The sort is moved after the mutex section, since streams are now
populated inside the loop rather than beforehand.

Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 124 ++++++++++++++--------------
 1 file changed, 60 insertions(+), 64 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5e092f51faad0..0ea755ea82192 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2076,8 +2076,8 @@ static int arm_smmu_streams_cmp_node(struct rb_node *lhs,
 		&rb_entry(lhs, struct arm_smmu_stream, node)->id, rhs);
 }
 
-static struct arm_smmu_master *
-arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
+static struct arm_smmu_stream *
+arm_smmu_find_stream(struct arm_smmu_device *smmu, u32 sid)
 {
 	struct rb_node *node;
 
@@ -2086,7 +2086,18 @@ arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
 	node = rb_find(&sid, &smmu->streams, arm_smmu_streams_cmp_key);
 	if (!node)
 		return NULL;
-	return rb_entry(node, struct arm_smmu_stream, node)->master;
+	return rb_entry(node, struct arm_smmu_stream, node);
+}
+
+static struct arm_smmu_master *
+arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
+{
+	struct arm_smmu_stream *stream;
+
+	stream = arm_smmu_find_stream(smmu, sid);
+	if (!stream)
+		return NULL;
+	return stream->master;
 }
 
 /* IRQ and event handlers */
@@ -4282,10 +4293,25 @@ static int arm_smmu_stream_id_cmp(const void *_l, const void *_r)
 	return cmp_int((*l)->id, (*r)->id);
 }
 
+static void arm_smmu_free_master_streams(struct arm_smmu_master *master)
+{
+	struct arm_smmu_device *smmu = master->smmu;
+	int i;
+
+	lockdep_assert_held(&smmu->streams_mutex);
+
+	for (i = 0; i < master->num_streams; i++) {
+		if (!master->streams[i])
+			continue;
+		rb_erase(&master->streams[i]->node, &smmu->streams);
+		kfree(master->streams[i]);
+	}
+}
+
 static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 				  struct arm_smmu_master *master)
 {
-	int i;
+	int i, n;
 	int ret = 0;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
 	bool ats_supported = dev_is_pci(master->dev) &&
@@ -4294,7 +4320,6 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 	master->streams = kzalloc_objs(*master->streams, fwspec->num_ids);
 	if (!master->streams)
 		return -ENOMEM;
-	master->num_streams = fwspec->num_ids;
 
 	if (!ats_supported) {
 		/* Base case has 1 ASID entry or maximum 2 VMID entries */
@@ -4308,99 +4333,70 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 		return -ENOMEM;
 	}
 
-	for (i = 0; i < fwspec->num_ids; i++) {
-		struct arm_smmu_stream *new_stream;
-
-		new_stream = kzalloc_obj(*new_stream, GFP_KERNEL);
-		if (!new_stream) {
-			ret = -ENOMEM;
-			goto out_free_streams;
-		}
-		new_stream->id = fwspec->ids[i];
-		new_stream->master = master;
-		master->streams[i] = new_stream;
-	}
-
-	/* Put the ids into order for sorted to_merge/to_unref arrays */
-	sort(master->streams, master->num_streams,
-	     sizeof(master->streams[0]), arm_smmu_stream_id_cmp,
-	     NULL);
-
-	/*
-	 * Clear after sorting: RB_CLEAR_NODE() records the node's own address,
-	 * which sort_nonatomic() invalidates by relocating the entries.
-	 */
-	for (i = 0; i < fwspec->num_ids; i++)
-		RB_CLEAR_NODE(&master->streams[i]->node);
-
 	mutex_lock(&smmu->streams_mutex);
-	for (i = 0; i < fwspec->num_ids; i++) {
-		struct arm_smmu_stream *new_stream = master->streams[i];
-		struct rb_node *existing;
-		u32 sid = new_stream->id;
+	for (i = 0, n = 0; i < fwspec->num_ids; i++) {
+		struct arm_smmu_stream *stream;
+		u32 sid = fwspec->ids[i];
 
 		ret = arm_smmu_init_sid_strtab(smmu, sid);
 		if (ret)
 			break;
 
-		/* Insert into SID tree */
-		existing = rb_find_add(&new_stream->node, &smmu->streams,
-				       arm_smmu_streams_cmp_node);
-		if (existing) {
-			struct arm_smmu_master *existing_master =
-				rb_entry(existing, struct arm_smmu_stream, node)
-					->master;
-
+		stream = arm_smmu_find_stream(smmu, sid);
+		if (stream) {
 			/* Bridged PCI devices may end up with duplicated IDs */
-			if (existing_master == master)
+			if (stream->master == master)
 				continue;
 
 			dev_warn(master->dev,
 				 "Aliasing StreamID 0x%x (from %s) unsupported, expect DMA to be broken\n",
-				 sid, dev_name(existing_master->dev));
+				 sid, dev_name(stream->master->dev));
 			ret = -ENODEV;
 			break;
 		}
+
+		stream = kzalloc_obj(*stream, GFP_KERNEL);
+		if (!stream) {
+			ret = -ENOMEM;
+			break;
+		}
+		stream->id = sid;
+		stream->master = master;
+
+		rb_find_add(&stream->node, &smmu->streams,
+			    arm_smmu_streams_cmp_node);
+		master->streams[n++] = stream;
 	}
+	master->num_streams = n;
 
 	if (ret) {
-		for (i--; i >= 0; i--)
-			if (!RB_EMPTY_NODE(&master->streams[i]->node))
-				rb_erase(&master->streams[i]->node,
-					 &smmu->streams);
+		arm_smmu_free_master_streams(master);
 		mutex_unlock(&smmu->streams_mutex);
-		goto out_free_streams;
+		kfree(master->streams);
+		kfree(master->build_invs);
+		return ret;
 	}
 	mutex_unlock(&smmu->streams_mutex);
 
-	return 0;
+	/* Put the ids into order for sorted to_merge/to_unref arrays */
+	sort(master->streams, master->num_streams,
+	     sizeof(master->streams[0]), arm_smmu_stream_id_cmp,
+	     NULL);
 
-out_free_streams:
-	for (i = 0; i < master->num_streams; i++)
-		kfree(master->streams[i]);
-	kfree(master->streams);
-	kfree(master->build_invs);
-	return ret;
+	return 0;
 }
 
 static void arm_smmu_remove_master(struct arm_smmu_master *master)
 {
-	int i;
 	struct arm_smmu_device *smmu = master->smmu;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
 
 	if (!smmu || !master->streams)
 		return;
 
 	mutex_lock(&smmu->streams_mutex);
-	for (i = 0; i < fwspec->num_ids; i++)
-		if (!RB_EMPTY_NODE(&master->streams[i]->node))
-			rb_erase(&master->streams[i]->node, &smmu->streams);
+	arm_smmu_free_master_streams(master);
 	mutex_unlock(&smmu->streams_mutex);
 
-	for (i = 0; i < master->num_streams; i++)
-		kfree(master->streams[i]);
-
 	kfree(master->streams);
 	kfree(master->build_invs);
 }

-- 
2.34.1

