Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794576155;
	b=4wBLnn9wlArCIb67jAeg5+V6GVXdYXiJLDLCo1eUr2gA7VujAjdVLsqqwtZhq2mdO+Js
	 3VJ+0YQwzMmyssU9XAxZXuLzRZahYWPyEFDRSJpOXYc9vITH5Stu/S0ZvsVZpCYqT44OA
	 jM3xC3dFr7V4G6lq18s3Klsdfuq6TaJt8+06FeMT9Wti9ZQQe4ReFlapqaHF5M+T70b/d
	 bdl1pnD/EYf7Tidd+Dc575FW/OxVck7U/yzIqtRuie4AXS55hdMsGGU7+EdLW8arMEu8B
	 XcUEOw/vd6stmkuaTckZvQz3loeCBx+5O94KR+XUGb+PjzHaBT+07CKFH2PpiyWjOGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576155;
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
	bh=0TrhDQdCw/VabrniAAm1t9BhEIemjop/C1wtKjAnxak=;
	b=2G/A8i+Z3pMEg4AHakXsYjjWHltn3LbJBsrFOwWxMnp2GmFXG6PwyFwx2JJGbsKFt268
	 +L0OQwoqOtU7qh6SSrnokBT7prKfQ7CfXlRVV65yN0aoClfkvy6vPF46NH9ZqqDyd086S
	 4vuXI/ko3gx2demksFWpt3CfJHuoR86d8mhTL0Vnprl88KQ5TjT5qN5OvrGj0A8gdV1zx
	 yhyHeshjIjzFh+ETZtc29MCXjlTr53cjMEdjX5Jdv6ek8+zP72nTf7cTXAFubzHViXyKR
	 X7CL5Yz0i+bzgMjy6s0MqaebzphquLf+e6FWBbg0UUGbiIdtVb7W75MRT2SK2hpJjVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Mk1Eov+t;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.53
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010053.outbound.protection.outlook.com [52.101.69.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDE3606A8A0
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 13:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BDE3606A8A0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Mk1Eov+t
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ol1nCBGWsCG4s7DPqcAn85I9DbBAwMbVxwpl3JJ/gozFFK3h67r0oAPAQax6Kxe4URJ/DEtBJfmcOHORvFQMeId/Iiag4cCHcx/7fWX/5LFYXvp21/lDO44rfMBUW0tUnGrrBGk9zKsWExN1uttlhcAzyP0Ag1a3sQEjZ74nyf2BLekDWu6AMH7HsMQXKjWr1lnc6grrtnRr5NcyUEjcKclNGMZny2QGWHwxLsdIRUY420YdAJRfLp5XHJO/OB6FboE51c78Iiokb5d38vs/+x4WS9a64pPSYz3K0P0MMY1WbkDR/QIT56ijNJ6T0vm57l1Yc0Wh+peB+wVI/naQCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TrhDQdCw/VabrniAAm1t9BhEIemjop/C1wtKjAnxak=;
 b=KwLzAFQtpziW6XH0HkQ4ZmaJugfpi0T1EG4H1/rXOjiaIGhUwds+fwdmdRWDo5W35FU7sh7Ce6xtZrswBfYzftcQ1eMFYVI3wuIt68yd8+kARMyixnWK9l59yHKu0n1tzyKpOBOeRahxDAUyRKLSdJp10nc3jX1cdi7rHDS4/xY1LFzCmQA2rl1otQeiKPOpgmfgYv8UCCavY6bFIc3StvtRJJ2cP2W1fKPmMWbzfA83bpkvOZAIhGQQv0++wW4ZSsQZdHA9KqzqJj9/p/iLhrYnE7PhtOJU5axNJym4n3wTVSJMcluyus0EQOoZvGsHTPrtWcXbE8LoGReg/3ATqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TrhDQdCw/VabrniAAm1t9BhEIemjop/C1wtKjAnxak=;
 b=Mk1Eov+tqqq+j7MtNaN0NG0KLoUgoP9n+wMGgovJS38xiKj8bnKXLMepQAN298hQTiuecygANkWrA+QT2oNAntIpRKFyoHb5Lf7tAru1585RCmBeXTaVnOFGaNlJxXYdfCOCq1DfCZ+G06AesXF8kYQnXO1fLr6OEw7B2u7+s/jFIssaYgghbJ4NIPYzCWRt9uLAMkDobBiikxNQMzxddSGoS/THJRBXyAOlvfzMxOWF85g2q7RPat9vWOUNRYR53V5BqU2QufnMPGHekev5mmBaTQ1KcVqJ9PaNHdCcmKWaD7ofJf86L+4vBYHLOmlVaJLNMHADA/VOHFsAAPaqxA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by BR2PR04MB007356.eurprd04.prod.outlook.com (2603:10a6:2c8:6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 13:22:31 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.008; Fri, 13 Nov 2026
 13:22:31 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 13 Nov 2026 21:27:13 +0800
Subject: [PATCH RFC v8 1/9] iommu/arm-smmu-v3: Allocate streams
 individually
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-b4-smmu-shared-sid-ver8-v8-1-587307a77f3a@nxp.com>
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
X-ClientProxiedBy: MA0PR01CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::12) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 413e1700-499b-46cf-3e25-08df41892b94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|376014|23010399003|1800799024|18002099003|22082099003|921020|11063799006|261102123227099003|261026140227099003|261028144727099003|261026121527099003|261022075727099003|261022105027099003|261021121427099003|261021135927099003|56012099006|261021123027099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	EgXNaRQ/aMTYQcb+QDyS0kyJVfQSGYO2fxKGF0S6oy7GfTgQxdx+97ysVHBzMVg1krAXCbIqsv0dOIfeAoRUZpRMLc2FvYmAJm0bq5AMI3LrxT0KzOVtoIIFtv49BD1I2a3C6McgE0P09biGiCxAzS/ZzjBRldMVpgqtYcOO+X4Hh3FdpdYeLwpsywl3P5NydeUDvYLk+h+b2QF602MvQBPZoySV7FLIs6vLY4T4Lav9smDyz/R7ScxaYDvWPCzqRRBQdYP+w6HJtFZxoEb4oEvX2PaZvvYYqznGsfUGbHdss97gN9jKiB/cAR9Cvysge1u+m5o0soZkPple5YtiX6yYEiPn7J2f07OYC/gVIq1CSSIdx2Ut1PTZzvbeERCEwokJvauzzwsH/o7E5Jx6pri9EgHWRyGD6u3tFD4DosVd8hwflQsveIg6CUbuQCUgPV9k/3l1TdfGvkt/Xj4FB6OT63d9A8YEDWPZTqVHoLjmrxoJkn4AbLNfz48ysUcPHLgEdmrEMZrNlxTWAe/Fb8dLLKMsV9mA5z8a6NliUmwetw0yI00hQ2ZF5nWHw8GJvTAYKy6StrXXPRYuDynPiI8Pfv0zj9+ikOhHDT3o0UlTpFX2YTq/hDH/ORw8n3nZkmy5yQVwfm0C2h7oIGKvrRYkGjY0w8OU7wILmAfAhM0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(921020)(11063799006)(261102123227099003)(261026140227099003)(261028144727099003)(261026121527099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021135927099003)(56012099006)(261021123027099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzljUDBNSWJMZzZZdytzeHBBbE02b09TWkRyemJMbzlBc2sxUDdBZzEwWjRR?=
 =?utf-8?B?ZllyUitxWHR4bWtBWG4ycTVPRWo0R0dBU3pKVklaQXVZU25WY2VkWjBTREty?=
 =?utf-8?B?b3FLTTdlNTd3SXFNTlFPRTJ1Ym56dHIydHVrdXlTOHVTdjJYVko4L1hpZEpC?=
 =?utf-8?B?MkRPOWtnbUkvVUpTZDR3MDJ1TEVnQmVDa2hZMm5hcXA0cUNCNzdqM01rc1VG?=
 =?utf-8?B?NXNXZ2E1ekkvMUVRRFJuOUt0aGJZakMwM1pXWEVQR2c2SlFXaXdMd250eVR6?=
 =?utf-8?B?L3BxbFhzbFRPOXZUZEpXbHo5OExZMTUxdEhMV3huUWJIeElBMU93cTRQTWhx?=
 =?utf-8?B?bVpnZGRLRzFkalhLelBYNU1JMUQ3UU1jcGtzU3BvWHVxa0d6N2sxVDRoUjZl?=
 =?utf-8?B?L05Hbmh2bHBMcURUTmhCR3ZjTVdyQS91K1V2OUhMdlZMbDNWWTB5Z2VlRkRn?=
 =?utf-8?B?aVorVDJYdEl2cXJ2U04zck9ReGNWcXBhN3JzSXYxUDRTeVlGait1Wjhld2lN?=
 =?utf-8?B?NFZFbjBNOTN3YTBGT1ZBR09qT1dkaDdqMTNTZDE0UHd3NDg3TG1nTnJSak9v?=
 =?utf-8?B?Q1lraGhZYnhablpzcm5xaHZqZWVxa3hJTnBGdkUzN3o5RFBodldXQWZ2UUJ4?=
 =?utf-8?B?WGYwVHkzbEQ4dGxWRng2YktmLzFVc2VNZzV4S0d1WU9iREVyckE5WjVHdlV1?=
 =?utf-8?B?SFNKbFpkR0NUQzRFYTdGU0lBYWsvVTFZSTBQeGJFbm5vcmx1VitRQTRGUjds?=
 =?utf-8?B?eEJGa0t2aVY2M0JoTHlySXJkdTBRQmt3OEFpZ29ydW5QOEtTUW52Ty8vZlov?=
 =?utf-8?B?dDVYbXd1YTZIeldaVG9XZkZzQkFNaFJvcm83S1c1MjJiZzNiOE1ZZ1BVc0Rh?=
 =?utf-8?B?NHR1cGJwOVNDOWx0MjZPMXA3VVJFTWk4WXJWaDE0b2N6Skw0OUg5MmVFNWxt?=
 =?utf-8?B?eklpVlk5WjBxZk9qTVBZZlhadFhFL1RTMjhWQTlBRmNvUElSb2R0RFFIMlh2?=
 =?utf-8?B?VDgwZGxYRWF3OTBHVVZtWDdDZGUyOE1GSGxWcllMWlhlU0NiWGM0SEdYRC9N?=
 =?utf-8?B?MnpIUE96SWZ0VkF5R2R6V0tpZjU4MEV4bUdqNFB5M1ZLWi9FcUdLN1VlQU91?=
 =?utf-8?B?Rjhvci9XaHhicUFhaE0wTkh0TW1vYnc2cVVDK2JjVzNLUDYvTXpwNXpRVlJ0?=
 =?utf-8?B?aWVxK3JITGtwajRqVGRKMk1VZUtlN2JJdzF0SjFYczFRVDJqcWYwWEVndEs3?=
 =?utf-8?B?VU41Y1F0K3liblBXSlFqRGR0RlY0RHZoOUY3a1JhSWc5RTZYM1BTUzlXMUdo?=
 =?utf-8?B?WTBRK0lKNHNsNE9YVW4rWWx2ZlJJeVpUQUN1VkFTc1NWdFNwb0VqVVVvbGR3?=
 =?utf-8?B?blhRY1hrNm81UnNKSWJ2YmpZTWFZV1VnNHdyZFYvTWhQL1V4ZXMrTlg3am9z?=
 =?utf-8?B?T3lrN3V3UUtHbG1TeVQ4dzFkNUtyQ1hidHF3bm9LZ3AxZUlyMXhtMEZ1OEZZ?=
 =?utf-8?B?cUpjVHRWL0lXS0c0RmhBSVNPL0VtU1AzeGYrWmZjRDhuU2lxa2lRL3ZFTDJI?=
 =?utf-8?B?TlMyV1RxMFBLYm5VeVVRUjUzdjBCVDlZWVpnVHMzamd2andNVUxWMWpPZmxi?=
 =?utf-8?B?Si9wMjl5ZC9qM2gvTlRjVk1IWTNQdkZTcU9qNVVVZ0x5cU9vdGZUQnk4Ymlr?=
 =?utf-8?B?WXAzc0tVdE5PSlFGV0Vwd2VPbUxtemc4aWlTM29mNERRYVQ2bmVBZjVmV2k3?=
 =?utf-8?B?MkdjdGQ0THdnaExKS1cwVXlIM2VuVThlVklPYWRIbVpFcWpmdnZwZ1ZOZWdq?=
 =?utf-8?B?VTA2SGRibDlaQVBkd0ZXd2Qrbno1SnM1aENvSUp4cE84SlpUMEx2NElrVXp0?=
 =?utf-8?B?RlZEanNHSDRmUWtHZzJocFpOeTBpZnk3SGpDVk1keTRNREJQTkRhSXZMVTVx?=
 =?utf-8?B?UWRIUHZTazVvYzhxUXc4S0VHaVBOamxGaDMzUTNGMzZaQ0pCZnpFdVFSYWRK?=
 =?utf-8?B?RUFKWEFHWFdTdGRHOTlYSkhTdFRpNVhSVUg5dU1idnNHZW9HL0FnbXRPVk9s?=
 =?utf-8?B?R3VhWStWeUVDNEgxWThycmJva2I1M0prc2V4TndqRTFNRUk1QndxU3o0U3lw?=
 =?utf-8?B?bEtySFdwOStmZHltb1pmanFjd0Fhcm04eE5pU2s3WDd6VFozbnhXWlF6dEJG?=
 =?utf-8?B?dEIzdktLZHlMMWgyR3REdjg3K0ZSM2RRNCsrTUY2QzJhTFZZdGxNdzlMUjVT?=
 =?utf-8?B?NzJRamNhSnNKSGEyaTNJWGFIQWE3ZDRlbW05YXd4RlEyYVprUEdFMEE2b3lq?=
 =?utf-8?B?RURPVjdRRW4zZzlBR0hyS0o1Unl5MG01bmNCRStIaEtPUCtCSThobkVHZXVV?=
 =?utf-8?Q?KaqDiseD6+O7QJFoF3hScYdl5gDK7faxeMyUf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 413e1700-499b-46cf-3e25-08df41892b94
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 13:22:31.0066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z3B7k2FwFK907HJS44yPZFFUobEns9PB06BEwTknSJq/KZVVkqOGLjblgx3hRpVoA1OpIn03e7gsimaSbgnTwQFJdEhKeyQ/Yso43rB8vIRArYVmapvRbKPj9a2si4O4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PR04MB007356

From: Peng Fan <peng.fan@nxp.com>

Change master->streams from an embedded array of struct arm_smmu_stream
to an array of pointers, with each stream individually allocated.

Prepare for shared-SID support where multiple masters will point to the
same stream object. With embedded structs, sharing requires duplicating
stream state and manually keeping fields like ste_installed in sync.
With individually allocated streams, a sharing master can simply point to
the existing stream.

The sort comparator is updated to dereference the pointer indirection.

No functional change.

Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Link: https://lore.kernel.org/linux-iommu/arG6hmng3NddGEHm@nvidia.com/
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c    |  2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 52 ++++++++++++++--------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |  2 +-
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c     |  2 +-
 4 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index e68b46485095..853276dd5453 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -295,7 +295,7 @@ static int arm_vsmmu_vsid_to_sid(struct arm_vsmmu *vsmmu, u32 vsid, u32 *sid)
 
 	/* At this moment, iommufd only supports PCI device that has one SID */
 	if (sid)
-		*sid = master->streams[0].id;
+		*sid = master->streams[0]->id;
 unlock:
 	xa_unlock(&vsmmu->core.vdevs);
 	return ret;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 100b34f07032..87ae1acb6146 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -977,7 +977,7 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
 	}
 
 	arm_smmu_cmdq_issue_cmd(master->smmu,
-				arm_smmu_make_cmd_resume(master->streams[0].id,
+				arm_smmu_make_cmd_resume(master->streams[0]->id,
 							 resp->grpid,
 							 resume_resp));
 	/*
@@ -1522,7 +1522,7 @@ static void arm_smmu_sync_cd(struct arm_smmu_master *master,
 	for (i = 0; i < master->num_streams; i++)
 		arm_smmu_cmdq_batch_add_cmd(
 			smmu, &cmds,
-			arm_smmu_make_cmd_cfgi_cd(master->streams[i].id, ssid,
+			arm_smmu_make_cmd_cfgi_cd(master->streams[i]->id, ssid,
 						  leaf));
 
 	arm_smmu_cmdq_batch_submit(smmu, &cmds);
@@ -2463,7 +2463,7 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
 	for (i = 0; i < master->num_streams; i++)
 		arm_smmu_cmdq_batch_add_cmd(
 			master->smmu, &cmds,
-			arm_smmu_make_cmd_atc_inv_all(master->streams[i].id,
+			arm_smmu_make_cmd_atc_inv_all(master->streams[i]->id,
 						      ssid));
 
 	return arm_smmu_cmdq_batch_submit(master->smmu, &cmds);
@@ -3155,13 +3155,13 @@ void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 		STRTAB_STE_1_EATS_TRANS;
 
 	for (i = 0; i < master->num_streams; ++i) {
-		u32 sid = master->streams[i].id;
+		u32 sid = master->streams[i]->id;
 		struct arm_smmu_ste *step =
 			arm_smmu_get_step_for_sid(smmu, sid);
 
 		/* Bridged PCI devices may end up with duplicated IDs */
 		for (j = 0; j < i; j++)
-			if (master->streams[j].id == sid)
+			if (master->streams[j]->id == sid)
 				break;
 		if (j < i)
 			continue;
@@ -3447,7 +3447,7 @@ arm_smmu_master_build_invs(struct arm_smmu_master *master, bool ats_enabled,
 		 */
 		if (!arm_smmu_master_build_inv(
 			    master, nesting ? INV_TYPE_ATS_FULL : INV_TYPE_ATS,
-			    master->streams[i].id, ssid))
+			    master->streams[i]->id, ssid))
 			return NULL;
 	}
 
@@ -4276,10 +4276,10 @@ static int arm_smmu_init_sid_strtab(struct arm_smmu_device *smmu, u32 sid)
 
 static int arm_smmu_stream_id_cmp(const void *_l, const void *_r)
 {
-	const typeof_member(struct arm_smmu_stream, id) *l = _l;
-	const typeof_member(struct arm_smmu_stream, id) *r = _r;
+	const struct arm_smmu_stream * const *l = _l;
+	const struct arm_smmu_stream * const *r = _r;
 
-	return cmp_int(*l, *r);
+	return cmp_int((*l)->id, (*r)->id);
 }
 
 static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
@@ -4309,10 +4309,16 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 	}
 
 	for (i = 0; i < fwspec->num_ids; i++) {
-		struct arm_smmu_stream *new_stream = &master->streams[i];
+		struct arm_smmu_stream *new_stream;
 
+		new_stream = kzalloc_obj(*new_stream, GFP_KERNEL);
+		if (!new_stream) {
+			ret = -ENOMEM;
+			goto out_free_streams;
+		}
 		new_stream->id = fwspec->ids[i];
 		new_stream->master = master;
+		master->streams[i] = new_stream;
 	}
 
 	/* Put the ids into order for sorted to_merge/to_unref arrays */
@@ -4325,11 +4331,11 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 	 * which sort_nonatomic() invalidates by relocating the entries.
 	 */
 	for (i = 0; i < fwspec->num_ids; i++)
-		RB_CLEAR_NODE(&master->streams[i].node);
+		RB_CLEAR_NODE(&master->streams[i]->node);
 
 	mutex_lock(&smmu->streams_mutex);
 	for (i = 0; i < fwspec->num_ids; i++) {
-		struct arm_smmu_stream *new_stream = &master->streams[i];
+		struct arm_smmu_stream *new_stream = master->streams[i];
 		struct rb_node *existing;
 		u32 sid = new_stream->id;
 
@@ -4359,14 +4365,21 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 
 	if (ret) {
 		for (i--; i >= 0; i--)
-			if (!RB_EMPTY_NODE(&master->streams[i].node))
-				rb_erase(&master->streams[i].node,
+			if (!RB_EMPTY_NODE(&master->streams[i]->node))
+				rb_erase(&master->streams[i]->node,
 					 &smmu->streams);
-		kfree(master->streams);
-		kfree(master->build_invs);
+		mutex_unlock(&smmu->streams_mutex);
+		goto out_free_streams;
 	}
 	mutex_unlock(&smmu->streams_mutex);
 
+	return 0;
+
+out_free_streams:
+	for (i = 0; i < master->num_streams; i++)
+		kfree(master->streams[i]);
+	kfree(master->streams);
+	kfree(master->build_invs);
 	return ret;
 }
 
@@ -4381,10 +4394,13 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 
 	mutex_lock(&smmu->streams_mutex);
 	for (i = 0; i < fwspec->num_ids; i++)
-		if (!RB_EMPTY_NODE(&master->streams[i].node))
-			rb_erase(&master->streams[i].node, &smmu->streams);
+		if (!RB_EMPTY_NODE(&master->streams[i]->node))
+			rb_erase(&master->streams[i]->node, &smmu->streams);
 	mutex_unlock(&smmu->streams_mutex);
 
+	for (i = 0; i < master->num_streams; i++)
+		kfree(master->streams[i]);
+
 	kfree(master->streams);
 	kfree(master->build_invs);
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index bb048e08d613..56ed6ad1dd52 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1051,7 +1051,7 @@ struct arm_smmu_event {
 struct arm_smmu_master {
 	struct arm_smmu_device		*smmu;
 	struct device			*dev;
-	struct arm_smmu_stream		*streams;
+	struct arm_smmu_stream		**streams;
 	/*
 	 * Scratch memory for a to_merge or to_unref array to build a per-domain
 	 * invalidation array. It'll be pre-allocated with enough enries for all
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 710a4c694b94..8166cece943c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -1257,7 +1257,7 @@ static int tegra241_vintf_init_vsid(struct iommufd_vdevice *vdev)
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct tegra241_vintf *vintf = viommu_to_vintf(vdev->viommu);
 	struct tegra241_vintf_sid *vsid = vdev_to_vsid(vdev);
-	struct arm_smmu_stream *stream = &master->streams[0];
+	struct arm_smmu_stream *stream = master->streams[0];
 	u64 virt_sid = vdev->virt_id;
 	int sidx;
 

-- 
2.34.1

