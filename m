Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794576169;
	b=vOQuT3mKhdKy7CqJ5b91NHgosnZC/mHH3DNGWbosiXnBEZy4JR1IBJDxoMyFN6PUyeqw
	 N6+YnZWlaKfS5ErhZw+529tbBk/VImQh7WWAFynNxD7/c0RV/naBBwoSxBOko0JwhD9WB
	 xZmSac8/2Rdl6QvgmQVCrVaY58tuPiDckVp2lJK52rn99+k4lpkLjibNOtzhxTZ0/WiZK
	 qy0YlJGZa+LNeHa0Jrty3T3lCFP9zCBumXW4dwyocRNkHE+bl/heGsU24TQnIWUaBOEO/
	 MSa4+G/QeUyN7KuiqWkMRcjkJWzukqg+8gAaUj7ItOR2jRgsMeH2UKTjQx6P5847lWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576169;
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
	bh=IQNQGpvK0PheoZV4qftxK95WwiSFXkZaTwXTb6BgUZ8=;
	b=os6siCgjZl90/kIYJo0y3SoF6HLiouF40uTbW3ABpUiKKzVZrS0ovIrZMSNR73C4/MY/
	 uTfrHdid50woJ+0lHjpTzxbrq4mS/wGBFJa2JI8sAXcClgiw87QTRN/i7Pd5gzMaQZi4T
	 DmThvH3uAkcKgfSdSUGE8if+NhUCEJ3QIsAeaRiyDSqxRdqIzK0/bIU4kPbBGc+Fj9wE3
	 7Hg+eZTBXsRbVg6bfhkxvqYIiHfYuPkq3k+1uyQSXQw44riUci70IGTFICHF1L6D/DWBD
	 7gFJfPdCMoJpH9u8R237zGH/FP5xKNeUk89I8Gl6DMJklmLEbNDkRln0wAxM8noH7yg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=puVE9Onw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.44
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010044.outbound.protection.outlook.com [52.101.84.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC490606BC02
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 13:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC490606BC02
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=puVE9Onw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lP/wck3yRh8v15zDO2hylnz90Q9XmooPckKsP787P9/sD7vnGFXXAGhbLt4OPt4oWegamCmg45UpH4Us20H0oV+u8R8AE4JlrH3wuYnmEFnvGAiABkB6nyaV673P5wKKgZ/nkE+Ee48jlx7piVYeBEdRQqqNSbLwqJfDe63TqLu3yFScyKqrlMCiPSjrbdm2cANEUL/UJdLPV/TrJMryCGl3i+8j3xM11KoQ3o86hlU1QUZwnMFgPHvvPhqgtp9PS4jlTtD79+Vhmx0i+C9oYn7xLU7vwRWbj7Cag0U5MXyo8rNq/yX2pFRVo2i355IJLQhZifGztIcLSwmwLdl1zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQNQGpvK0PheoZV4qftxK95WwiSFXkZaTwXTb6BgUZ8=;
 b=qywXMuaEgfTTsEgyIWAjwIq/UU/de0pgUl1+d5gtBz7582KCx4wgYjD6N7Ufvrg3WAUd4LBQEVTRLwkH7BRpAX0Yrdv0pW0uU4IavJyrEQcNbxxoZ38XsQYO6x3tyYtzj+i59toz2oqEXTTOo18zf2lIHndvz5Y+jYwgZczackfbVzjyTX5OHmw7+S0M8Y3stxg6Yd0FH9xAb8VZp/Dj8YFzBNgHTj/GRQmZ3nExYXxHOP4Z5+Fiaaq8Ay8G5FnPQoTiabTNy1e6I2A5Oil9Z3ql3n5XfqXB1QpeVWBHum7L5xedYE8HBDYcGk2vg8cxHqrdD9I4JQlAA23Pk5Q5LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQNQGpvK0PheoZV4qftxK95WwiSFXkZaTwXTb6BgUZ8=;
 b=puVE9OnwRifr/ZvShFHfGTfGJUnx5e1NFnO+XKepPkz76/o36WXQUqnHvvau+pQlOaqKHofA7yi3hNFaAjvHgAR9JefYJfkD9nkTHTC4ia+nwWsy7OOGd3EAGbqH/OXtNUVqyYZD62x26bilwjZmuLCfG+ZUEv3VadSq2nDI9aA7XuAFyzdriKMv0jXo67FEI8dnvJscHSShCkvNAC0rkrHMOd8Hu5vYlM3FGhO4079KrEG5IP3pdeTzwKX6/YmLCHBR+5VVufpNC4m+HOGQBJg6Ch3Mt14ea15gFf4WFDQ+TGNcwgN+ht69WGM8tYO4cfdhJrhf93MCf3zDZAx6hw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by BR2PR04MB007356.eurprd04.prod.outlook.com (2603:10a6:2c8:6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 13:22:46 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.008; Fri, 13 Nov 2026
 13:22:46 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 13 Nov 2026 21:27:15 +0800
Subject: [PATCH RFC v8 3/9] iommu/arm-smmu-v3: Plumb the CD table into the
 CD helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-b4-smmu-shared-sid-ver8-v8-3-587307a77f3a@nxp.com>
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
X-ClientProxiedBy: MA5P287CA0304.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21e::16) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 4bc06ea3-31bc-4db1-d1e5-08df418933f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|376014|23010399003|1800799024|18002099003|22082099003|921020|11063799006|261102123227099003|261026140227099003|261102130727099003|261028144727099003|261026121527099003|261022075727099003|261022105027099003|261021121427099003|261021135927099003|56012099006|261021123027099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	5WUSMl2GPVi3eVo1krjJFV9cqbeDOE7/uj0D2FWw4rFmfpod3f0FnHz+My67kzG7XFG3K7IyQTGeOa+kpUZ/dqsCcIQsJrr/2i5n3skTjftvFDQ2GKb9T0ro4m1I+LnU3fFcD9G95Mz9D7sR7xM5Pw/JfdOd/VORvandw/x4PopdRuyMRBWlUnEpfRv3s1SSfZ9OWxrdBfx/P/AhelvZkMjKSgvi0OzhiUIeX3abvYJhm6lEiquP0/6aSBaJNlS+wwQIqHiNl4hBEee04LhCD0JeeYi7AwQ6lnTdXUJPhisODvR0hnKD3+0kgM3zNvQHMjg2Ucwp7B82Dj0yQxOgDqwYTmyY4Wy6EAMglJ+NSRjo7X9UNOv7S5t++5TUyzoyJQEBVtk6rBmQw/z+dOkvvKyHM32aLNCYWhajcqE1HA0BJb7spm8ISMnnzNwa6sQBzZlHEcDgGe9DZRpDXk8GQeeu699vvTyYe8Ql0uA78ZQsUFK2DuIXrx6cRFIWI9UeGygNbAQXgCW3kWcBew8hrgEkBYWtwUbmGpr+YC1U3jm+tXAHBFB+vIw93XPEn/H6PqtjFHPBYXiPtOD7lEK4lfH9EhJGRAu2KcvHKcgPn9t0vi8eZboDnglQnF/ZcWFsd/kM4Ba7t3nutd17XR4/z+fTIBfaxN8JiyOCHuq27yhpe+zVA5281Dnr19D1iTU+hIgMmj1ZRnWjxp7+hkKLOA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(921020)(11063799006)(261102123227099003)(261026140227099003)(261102130727099003)(261028144727099003)(261026121527099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021135927099003)(56012099006)(261021123027099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGtoaVFHYVVhZFdPWFpER3dQVXk1T0pTTXpNc2tqN2ZBbkFIdkt3c0F0ZDBJ?=
 =?utf-8?B?dHJ3QWthK09obE1tdXdySVFidUZwQ2FzbVhmeVBqcVFUVnBqc0ZiQkJIZUZ6?=
 =?utf-8?B?a1dOR2JZTkFFRTFPTUJnVFh2OS83ZGhYcFlwRHIxNE9jSVJJNER6ZGVlNFN2?=
 =?utf-8?B?dVIwb1A2MFdxMDBVTis5cTd6amJDb29wcTNrY2FLZmFGWFdMUDUxeXladmFZ?=
 =?utf-8?B?Q09pVVN2SmMxbGRaWE93Q2FyTkMydWJPTXhFYTNWNW40MndjZThIcXpjMjdw?=
 =?utf-8?B?R2p1SkszbTZhd094RVhTallnTnR5RVZ1eTNtR2xXYTVwSTA2MXhsajFpbVo3?=
 =?utf-8?B?c0VDZVg2c3RSaDFtMFJuS2FXOTNaSU1wckNxenBrZHpZVGw0NzhGRWlRSmhC?=
 =?utf-8?B?UUxqck01cGRoK2VsZGRNSytvM29jQUZvUWxxUkt5bXVVYlZ6UE5IVy9pd3lp?=
 =?utf-8?B?UVovaGkxSkg2MVZTd2h6Nm1MN2Ewa1p5MUFMWk5MQncxakNEU0dCYkxTQjRj?=
 =?utf-8?B?TzZ4SEZKTlYwK3Z4MFpuKzlVdHVpdXRLbWY3d2NGUy9welR1eTVSMGl3Q0FD?=
 =?utf-8?B?YXJGblRuNjB4K09XVmY4NnVXWUhEV2NuWWpLWmhQVU5BSWxBRWxjdjFkandi?=
 =?utf-8?B?cXlpczAyR3o4YlpwdUVPSlAzaU1URC9PanRNVnJsL2RobkNEVEh2S1RGQWha?=
 =?utf-8?B?OGxpNzNkRG5vSWRCU29pbHJNaytiYml2d1RIWm5DMEJvaXl5a2t0WXFRSGts?=
 =?utf-8?B?Qml2cjRlVWd6TXpYNGwxZTlHTW80Q20ydWJBUGZydzY3Yml1ZEUwdXpHblhR?=
 =?utf-8?B?S1lSYzNnNUI0OHBENXdqOWlaVGwrUzhIalZFcGVzdk9MTXI4MGFiS1MrQVQ1?=
 =?utf-8?B?Tm03UERZbVYyNCswRFhUZjUrbzRrbHVreVlFQjExdTI2a2hSTGdaYkxMbVhh?=
 =?utf-8?B?ZkVSZ0EzUSsweVNIQytIbk15QS9ndDU1WGZnVERQYytMeGVJTkhQMWpzOWJ0?=
 =?utf-8?B?MXFBL1lqV1JKcGsrMml6NFdqcTVLajhJSC9pSFFsWSs5OWE2N1p2eWRncnpW?=
 =?utf-8?B?emFMQTlucExHSFBmNFRBV0lIbzJoQ2dYSlhqeUZqYy8rc2pTL25odjlWV2cv?=
 =?utf-8?B?R3JyRTlYNHhUSU1zd1BOV3Q2QVNYV0k4dVNBVUt4c3FzandDSVphY3RHeDUy?=
 =?utf-8?B?NDdxWklHY3hpVFB4ZzYzQ1g5VWtMdjF2a3Z3R3B4aUo2amxFdGx0dTBmRkQ5?=
 =?utf-8?B?V2FHRmtyblZyY0NuNUhlSFZtTmt0eWYvV281dXBYWW1CcUpDL1Vla2VrWGpY?=
 =?utf-8?B?eWVKdkF3bnd1MEQyZnJqUHpxRVNPVTQ2YWozK0xFTU0wZVNoSnZZQmdpcWFV?=
 =?utf-8?B?b2k1NXE0dE4zYTZ2dnBPQVNzSkZuM0NweHNzMVNnTmFDSE9IbGVqcm9oMVhZ?=
 =?utf-8?B?bTZDZmdQcVJxUThWNDVONTZ5Z1V2eWoyYVdsNm9Wb2lmQlVaZGlhZVkxLzNo?=
 =?utf-8?B?YkU5Q2ltZ21idGk1dHpLMFZEb3FMU0N4aEVtV3RnazJOc2EycWdpV1dxeVJr?=
 =?utf-8?B?ZDZFdFVaYkRIZWRSdEVDckpFNjdVRFVGNnJDbDBSVW1SVzdDWnR0TUpCbFRU?=
 =?utf-8?B?YThObWVQczVxbTZ0bmZMSlNtNzRWRmJOMnUrSnUyUCtqQUlTaksxU0dqdy9W?=
 =?utf-8?B?aEFMMDh3OGVGS2JVNjA2WXQwOTJCeTR1aXZDbVo0REVuWHU0dVQrZXlUck9Q?=
 =?utf-8?B?WXFPRm5QVHFzRTRTZFRlMEdqQUVobW5iR2lMc25IbGt3UnpRaWNOTGNJODF0?=
 =?utf-8?B?TDI1dE4waW1KdnhBa09iWm1SbWZKM2ZlUWZ2ZXZRcFFtblZQWXhicWx1bm45?=
 =?utf-8?B?RGw0M0ZIWlNUNjhmWDQ4ZFNMdXRpT25mTC9pNFhTNTNNT1llYnNGR25oVTRn?=
 =?utf-8?B?ZUk0TVZuU1NDcW13YUtYUzZnbUx5R1BQNkV0UTZUYmdSMjF4WDhxUHdITkhr?=
 =?utf-8?B?dWpQYjYzczdtVEVhcWZjd0VZNGEyR0FuK3hPZTdrWlJHbXozdmZ1SVdvSld1?=
 =?utf-8?B?VDRuWmVMY3VtR2tla1NUaDB2YjA0YzRteHROQ2EzMEJzN1dpNjlidVBXQWZl?=
 =?utf-8?B?NEJNbXpDLzh3bzVjcmlQTms4S1hxYkZzWGcramRXenJrOWM0K1FVYTdDMFp2?=
 =?utf-8?B?eFdZalZJVGN5aDlDVFZDdTB4dmtGRDBBVFNqK09wL0RhSFJxcDFXZEI2L3di?=
 =?utf-8?B?cVdxdTJpV1hPVU91Rjdra0hQVFR4cXU2VnM0TmRadVhPNENkTnpkZXdFZi9x?=
 =?utf-8?B?MFh0WC9kZzh5TUNLRUIyd0xSZ2pJWjZLbXlob1dNRzFQdWtsU0N2NktibThZ?=
 =?utf-8?Q?jLBMu+39ItE4npvwLBzTFQyeZ9dn89mOKsDJp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc06ea3-31bc-4db1-d1e5-08df418933f4
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 13:22:45.7354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IfHI6mYaw/rJJYseksmziDBNIlUTLR7kLilaH0z5Nipu6/pYu0bmEcLDDBIxNhK4njXZGzbJY/pSCVPk/twhnYPAqWgIZxW6MVWPVGDRi5a1t0lj/9YVrFZT8rpKYo/6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PR04MB007356

From: Peng Fan <peng.fan@nxp.com>

Refactor the CD table allocation, freeing, lookup and STE-building helpers
to take a struct arm_smmu_ctx_desc_cfg pointer instead of always deriving
it from struct arm_smmu_master. Add master wrappers so existing callers
keep the same behaviour.

Prepare for domain-owned CD tables, where non-PASID streams will point
their STE at a CD table stored in the IOMMU domain rather than in the
master.

No functional change.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c  |  4 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c |  3 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c      | 64 +++++++++++++++---------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h      |  7 +--
 4 files changed, 48 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index faeec656da9e..7f89bb7a2e9c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -25,7 +25,7 @@ arm_smmu_update_s1_domain_cd_entry(struct arm_smmu_domain *smmu_domain)
 		struct arm_smmu_master *master = master_domain->master;
 		struct arm_smmu_cd *cdptr;
 
-		cdptr = arm_smmu_get_cd_ptr(master, master_domain->ssid);
+		cdptr = arm_smmu_master_get_cd_ptr(master, master_domain->ssid);
 		if (WARN_ON(!cdptr))
 			continue;
 
@@ -173,7 +173,7 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 		struct arm_smmu_cd target;
 		struct arm_smmu_cd *cdptr;
 
-		cdptr = arm_smmu_get_cd_ptr(master, master_domain->ssid);
+		cdptr = arm_smmu_master_get_cd_ptr(master, master_domain->ssid);
 		if (WARN_ON(!cdptr))
 			continue;
 		arm_smmu_make_sva_cd(&target, master, NULL,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
index 5a4e45e15125..864d9f2350bc 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
@@ -215,7 +215,8 @@ static void arm_smmu_test_make_cdtable_ste(struct arm_smmu_ste *ste,
 		.stall_enabled = stall_enabled,
 	};
 
-	arm_smmu_make_cdtable_ste(ste, &master, ats_enabled, s1dss);
+	arm_smmu_make_cdtable_ste(ste, &master, &master.cd_table, ats_enabled,
+				  s1dss);
 	if (feat & ARM_SMMU_MASTER_TEST_NESTED) {
 		struct arm_smmu_ste s2ste;
 		int i;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 339b94f2a8a4..b24a4684202e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -122,7 +122,7 @@ static const char * const event_class_str[] = {
 	[3] = "Reserved",
 };
 
-static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
+static int arm_smmu_master_alloc_cd_tables(struct arm_smmu_master *master);
 static bool arm_smmu_ats_supported(struct arm_smmu_master *master);
 
 static void parse_driver_options(struct arm_smmu_device *smmu)
@@ -1545,11 +1545,10 @@ static dma_addr_t arm_smmu_cd_l1_get_desc(const struct arm_smmu_cdtab_l1 *src)
 	return le64_to_cpu(src->l2ptr) & CTXDESC_L1_DESC_L2PTR_MASK;
 }
 
-struct arm_smmu_cd *arm_smmu_get_cd_ptr(struct arm_smmu_master *master,
-					u32 ssid)
+static struct arm_smmu_cd *
+arm_smmu_get_cd_ptr(struct arm_smmu_ctx_desc_cfg *cd_table, u32 ssid)
 {
 	struct arm_smmu_cdtab_l2 *l2;
-	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
 
 	if (!arm_smmu_cdtab_allocated(cd_table))
 		return NULL;
@@ -1563,6 +1562,12 @@ struct arm_smmu_cd *arm_smmu_get_cd_ptr(struct arm_smmu_master *master,
 	return &l2->cds[arm_smmu_cdtab_l2_idx(ssid)];
 }
 
+struct arm_smmu_cd *arm_smmu_master_get_cd_ptr(struct arm_smmu_master *master,
+					u32 ssid)
+{
+	return arm_smmu_get_cd_ptr(&master->cd_table, ssid);
+}
+
 static struct arm_smmu_cd *arm_smmu_alloc_cd_ptr(struct arm_smmu_master *master,
 						 u32 ssid)
 {
@@ -1573,7 +1578,7 @@ static struct arm_smmu_cd *arm_smmu_alloc_cd_ptr(struct arm_smmu_master *master,
 	iommu_group_mutex_assert(master->dev);
 
 	if (!arm_smmu_cdtab_allocated(cd_table)) {
-		if (arm_smmu_alloc_cd_tables(master))
+		if (arm_smmu_master_alloc_cd_tables(master))
 			return NULL;
 	}
 
@@ -1595,7 +1600,7 @@ static struct arm_smmu_cd *arm_smmu_alloc_cd_ptr(struct arm_smmu_master *master,
 			arm_smmu_sync_cd(master, ssid, false);
 		}
 	}
-	return arm_smmu_get_cd_ptr(master, ssid);
+	return arm_smmu_get_cd_ptr(cd_table, ssid);
 }
 
 struct arm_smmu_cd_writer {
@@ -1712,7 +1717,7 @@ void arm_smmu_clear_cd(struct arm_smmu_master *master, ioasid_t ssid)
 
 	if (!arm_smmu_cdtab_allocated(&master->cd_table))
 		return;
-	cdptr = arm_smmu_get_cd_ptr(master, ssid);
+	cdptr = arm_smmu_master_get_cd_ptr(master, ssid);
 	if (!cdptr) {
 		/* Only ats_always_on allows a NULL CD on default substream */
 		WARN_ON(!master->ats_always_on || ssid);
@@ -1721,15 +1726,15 @@ void arm_smmu_clear_cd(struct arm_smmu_master *master, ioasid_t ssid)
 	arm_smmu_write_cd_entry(master, ssid, cdptr, &target);
 }
 
-static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master)
+static int arm_smmu_alloc_cd_tables(struct arm_smmu_device *smmu,
+				    struct arm_smmu_ctx_desc_cfg *cd_table,
+				    u8 ssid_bits, bool ats_always_on)
 {
 	int ret;
 	size_t l1size;
 	size_t max_contexts;
-	struct arm_smmu_device *smmu = master->smmu;
-	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
 
-	cd_table->s1cdmax = master->ssid_bits;
+	cd_table->s1cdmax = ssid_bits;
 
 	/*
 	 * When a device doesn't support PASID (non default SSID), ssid_bits is
@@ -1744,7 +1749,7 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master)
 	 * Set S1CDMAX no lower than 1. This would add a dummy substream in the
 	 * CD table but it should never be used by an actual CD.
 	 */
-	if (master->ats_always_on)
+	if (ats_always_on)
 		cd_table->s1cdmax = max_t(u8, cd_table->s1cdmax, 1);
 	max_contexts = 1 << cd_table->s1cdmax;
 
@@ -1786,11 +1791,20 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master)
 	return ret;
 }
 
-static void arm_smmu_free_cd_tables(struct arm_smmu_master *master)
+static int arm_smmu_master_alloc_cd_tables(struct arm_smmu_master *master)
+{
+	return arm_smmu_alloc_cd_tables(master->smmu, &master->cd_table,
+					master->ssid_bits,
+					master->ats_always_on);
+}
+
+static void arm_smmu_free_cd_tables(struct arm_smmu_device *smmu,
+				    struct arm_smmu_ctx_desc_cfg *cd_table)
 {
 	int i;
-	struct arm_smmu_device *smmu = master->smmu;
-	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
+
+	if (!arm_smmu_cdtab_allocated(cd_table))
+		return;
 
 	if (cd_table->s1fmt != STRTAB_STE_0_S1FMT_LINEAR) {
 		for (i = 0; i < cd_table->l2.num_l1_ents; i++) {
@@ -1900,10 +1914,10 @@ EXPORT_SYMBOL_IF_KUNIT(arm_smmu_make_bypass_ste);
 
 VISIBLE_IF_KUNIT
 void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
-			       struct arm_smmu_master *master, bool ats_enabled,
-			       unsigned int s1dss)
+			       struct arm_smmu_master *master,
+			       struct arm_smmu_ctx_desc_cfg *cd_table,
+			       bool ats_enabled, unsigned int s1dss)
 {
-	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
 	struct arm_smmu_device *smmu = master->smmu;
 
 	memset(target, 0, sizeof(*target));
@@ -3865,7 +3879,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev,
 		arm_smmu_make_s1_cd(&target_cd, master, smmu_domain);
 		arm_smmu_write_cd_entry(master, IOMMU_NO_PASID, cdptr,
 					&target_cd);
-		arm_smmu_make_cdtable_ste(&target, master, state.ats_enabled,
+		arm_smmu_make_cdtable_ste(&target, master, &master->cd_table,
+					  state.ats_enabled,
 					  STRTAB_STE_1_S1DSS_SSID0);
 		arm_smmu_install_ste_for_dev(master, &target);
 		break;
@@ -3932,7 +3947,8 @@ static void arm_smmu_update_ste(struct arm_smmu_master *master,
 	 * the S1DSS is correct and this will just update the EATS. Otherwise it
 	 * installs the entire thing. This will be hitless.
 	 */
-	arm_smmu_make_cdtable_ste(&ste, master, ats_enabled, s1dss);
+	arm_smmu_make_cdtable_ste(&ste, master, &master->cd_table, ats_enabled,
+				  s1dss);
 	arm_smmu_install_ste_for_dev(master, &ste);
 }
 
@@ -4065,7 +4081,8 @@ static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
 		 */
 		state.cd_needs_ats = true;
 		arm_smmu_attach_prepare(&state, domain);
-		arm_smmu_make_cdtable_ste(ste, master, state.ats_enabled, s1dss);
+		arm_smmu_make_cdtable_ste(ste, master, &master->cd_table,
+					  state.ats_enabled, s1dss);
 	} else {
 		arm_smmu_attach_prepare(&state, domain);
 	}
@@ -4436,7 +4453,7 @@ static int arm_smmu_master_prepare_ats(struct arm_smmu_master *master)
 
 	master->ats_always_on = true;
 
-	return arm_smmu_alloc_cd_tables(master);
+	return arm_smmu_master_alloc_cd_tables(master);
 }
 
 static struct iommu_device *arm_smmu_probe_device(struct device *dev)
@@ -4509,8 +4526,7 @@ static void arm_smmu_release_device(struct device *dev)
 
 	arm_smmu_disable_pasid(master);
 	arm_smmu_remove_master(master);
-	if (arm_smmu_cdtab_allocated(&master->cd_table))
-		arm_smmu_free_cd_tables(master);
+	arm_smmu_free_cd_tables(master->smmu, &master->cd_table);
 	kfree(master);
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 56ed6ad1dd52..b02163a48c97 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1143,8 +1143,9 @@ void arm_smmu_get_cd_used(const __le64 *ent, __le64 *used_bits);
 void arm_smmu_make_bypass_ste(struct arm_smmu_device *smmu,
 			      struct arm_smmu_ste *target);
 void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
-			       struct arm_smmu_master *master, bool ats_enabled,
-			       unsigned int s1dss);
+			       struct arm_smmu_master *master,
+			       struct arm_smmu_ctx_desc_cfg *cd_table,
+			       bool ats_enabled, unsigned int s1dss);
 void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
 			  struct arm_smmu_master *master, struct mm_struct *mm,
 			  u16 asid);
@@ -1193,7 +1194,7 @@ static inline void arm_smmu_domain_free(struct arm_smmu_domain *smmu_domain)
 }
 
 void arm_smmu_clear_cd(struct arm_smmu_master *master, ioasid_t ssid);
-struct arm_smmu_cd *arm_smmu_get_cd_ptr(struct arm_smmu_master *master,
+struct arm_smmu_cd *arm_smmu_master_get_cd_ptr(struct arm_smmu_master *master,
 					u32 ssid);
 void arm_smmu_make_s1_cd(struct arm_smmu_cd *target,
 			 struct arm_smmu_master *master,

-- 
2.34.1

