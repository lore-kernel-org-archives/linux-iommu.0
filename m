Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012057.outbound.protection.outlook.com [52.103.66.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275E32EC559
	for <iommu@lists.linux.dev>; Fri,  7 Nov 2025 02:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762483183; cv=fail; b=lnMLqtCyte4TVb6/jFSMpmmFecPYJM+uOQ+ghNPPDj8vxsAYE/vKaSEWL1nLHwN8QZNMG0MeKZk9jj0yo0Ddu9zHhgG6xL3GU4TNSgfb1Au/ZZ/TQmFpH5B3Ekl+lzWpZUYDEZhBVyfjxAU8U0GSQmH+VQY2FE5MoXMQwy2EelI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762483183; c=relaxed/simple;
	bh=KeINN75vFfI7gXJLkuhKPOFLkOyfs5v+8jNZTWUSZgM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BhBa/4qWgDQPqoJpSJvpAlQrapjFHiiEYsWsv6/eyOCbb/ci/9cYcu39B9Xw6YxPmNDjFxK3jJmsFbZhRM5TY9I7qW1VaUz126PrF0lXHLhzmom+MVdMg+u96mrCK3bQifYoR1f7BgL1Rr+N3yMWrrIf4NF0at9C8x2ApLBZabg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=grf9tTzT; arc=fail smtp.client-ip=52.103.66.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="grf9tTzT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BvWqZZpCJSXLCEtDnRzzIEdfaMxrRmiNpVExbkfVAlbPpRSu9LMOtJhIx0n8iNljHuasosCPe+RJhlq+UynXR1LVKYESX+XKC2aLPQhojxn/LD2DlScK5fAlAYOETI84Y6yn5vKbS7+CymtBjgCExgxMvZr8JxUIf4cwxyeDG727vITxnaO7sOHgfw8VYaoAeMm+3pmdcy4bsSyBhFPkTkyDHqoWPVDpSerKbfOcGoNLec5kRtMIzQ42tLsdb9M3qU35bB5TXC2Pdn7G+zNLPccJYiDl8yR2zU27B+CseklRvilJg508LhN4mZv8obB0UKmGgWO8BBFw9fpG81mOMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KeINN75vFfI7gXJLkuhKPOFLkOyfs5v+8jNZTWUSZgM=;
 b=G997oFrLrHjQsnfCovJxd1eeCYRpQRMOoEF6wzjI++5w9Ifu7MLFmL7gEB4BTEQgJTsT9H5dNPoS2Ph9I+q7zxJc68lFQdei52/QWaWnngvjuzXQOC9QLZuIMlkBPlfupUPkYY/GO+mTwXJb5oCoZgngv3dk5upj1gdbq+eAq4vLM2rfExTCW+Leyr5u/qDl6avxgDC1rNbXLzN52IwCwFBlqHTN/uVRhGkY929DVFJfHeSHlsHUiIoJAMeI88GqadYICtiXACP3zHCI3OapIFw0masd0/GwehXWoN8RQVO6xxxE8IDiLwNixvtoqPjFvaRRpnL6VOC4PNG4R+p7NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KeINN75vFfI7gXJLkuhKPOFLkOyfs5v+8jNZTWUSZgM=;
 b=grf9tTzT7P+rebwQsfXDVk8Q8GZ+7rwU/ydGKjDvNI1+emRHGMBlZV9EJTbnm+gfAYFZfBhOWjS2cUCSziuulbASgEA9MghjyyLhLvjJffEaRlZKhzQVc490Xcu34KL9BsuvMNGZkj4l1UEx8k60osJTQWjXatPO6uaGgSzb2Tcaid1Dy4ENciPckEODVYLOknq6O4JaDAu0CdmuehPR99cXx2jHpmLspq67JcDfrwVxLnEvlpoKsO4UhKyQs9uR083GCyA3XDzjIAk2+tpkTuzKHe6bH2OWVUEV+yl4sqIWpeEs0BKRGkfL7uklLvOwklK+NJd5tQAleg0cxX0t3Q==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by KL1PR01MB5671.apcprd01.prod.exchangelabs.com
 (2603:1096:820:cc::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.10; Fri, 7 Nov
 2025 02:39:37 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::5e86:f04a:37e5:64f1]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::5e86:f04a:37e5:64f1%5]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 02:39:37 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "alex@shazbot.org" <alex@shazbot.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
Subject: RE: [PATCH v2 1/2] iommu/amd: Add IOMMU_PROT_IE flag for memory
 encryption
Thread-Topic: [PATCH v2 1/2] iommu/amd: Add IOMMU_PROT_IE flag for memory
 encryption
Thread-Index: AQHcTMpGA/9lTKVYuEa2QjS5vGXcw7Tmar8AgAAVJ8A=
Date: Fri, 7 Nov 2025 02:39:37 +0000
Message-ID:
 <SI2PR01MB4393AF84C998C403CDCAC55CDCC3A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References:
 <SI2PR01MB439373CA7A023D8EC4C42040DCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB439351F0B7E54513710BBD3DDCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20251107010218.GC1708009@nvidia.com>
In-Reply-To: <20251107010218.GC1708009@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR01MB4393:EE_|KL1PR01MB5671:EE_
x-ms-office365-filtering-correlation-id: 13d9a6b0-35c9-47bf-130f-08de1da6e4c6
x-ms-exchange-slblob-mailprops:
 laRBL560oLT/z5vudnqSE/O7qQNjjjS46OY3Bt8lcMcrUaMPqtoWtTN/65v+IH25JiEbD8I1/e5w3YCT4PVbBhjl1bzXsybkf7HWy1yaQezlU9Uy1FnCD+BNdvXHy8PmOnqkVm9tqkI7p07umiJpjAR1tdcyzgJPWCqvT8SyMYf5GE5awzoqs5AjsLtdj7ma/zaaIuLbqTQd1/1haT7Kx04/JHm8FCfBav2FSz2mJeTCc1+hIrY3aMFQqvyBwJJTbyEu3X7ygYzCjLwp8C9DKH1lkGLZY9sXafYgFr2iH3ymlWGjGujwQnRCcl5qbY2NUSvq8ORbOOEZCafXVU8ThZiI5jsvDonAQ4b3z5XGwqk1boZbGTl2UIqO1zjVlHyxonh9BKI0nPeE4E0iTJUDJNuEcq7lOxUhxNdHhbvuQ1nCYMnbmjpFMhK9S3/DCO4y0NBHKt3vEGBpUS5VyJeM4JPENF8qGpkazaDVvOMAwfF4+JqF0O0kvs27A4bCx+iZkkwAPNmShojmWmJasY7Xt51AKlvGyudQQ2vBuEE5CpJIVCOzksS2mpd8Xr2CF/6ECkj7vNwUB6ZF4NLoB9jgNReH48cjMKLMaK6UkVm6UTDYdhrUOd3Aq46WaxB/IROKvj7Ia0dNcg0GqC2tpJ3yQCUfKr5tvNwGCNSRJTHTTt+WBkaJjA53TzBAtGIbdmpjSsPLRC7xkgVf32uRKX0/UB0FXn1v3/DoYFVq0L3wx3kAF2yOqsxwUdgf7jNCO2/8xtRSDUzy2lMc1S3UMvBx+Z2cEBQsEYxi
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|461199028|10112599003|8062599012|8060799015|51005399006|19110799012|15080799012|12121999013|13091999003|3412199025|440099028|40105399003|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?WExzQm1xSEZnWm1DbC9DcnRGTHE3SHB6TWlUODV1ZmJjdXJ3T1VnUUQrM2Y1?=
 =?utf-8?B?Wlc0bngvLzQyOWNjWmI5cVQxR0ZiVXpxbjlTUWdzVkd1Y2RpNFlNcTBydEZQ?=
 =?utf-8?B?QmQ4eUpNc216bmJrY2ZodG9yTFBYUE5JWDRNNGhUazdYZEpRQUlGM2ZQTUVh?=
 =?utf-8?B?TUN6QUNQU2cwWG9TMFhjbVlyVFdVbDJUbnp6akgyVjdabVNOZjl6amhhSGhP?=
 =?utf-8?B?TDFkY1gxVUEwb3JiSldvV3YvcmJ3VWhUWWg3MUo3VHMvWmJCZjRKTk9EQWVI?=
 =?utf-8?B?NjVHWWlmd3lHbi9lVDlodjJmbUJhNDQvcnhlVDdOK0hLU0pXc2ZHNU04eVZM?=
 =?utf-8?B?aWpHKzdLZERKR0E1elpicXVVTThYUmlpNEVCZExGOHQ2NDYzMU9pdXh4NU5C?=
 =?utf-8?B?N1Z2YkxxeXZhVmtIUEoweVhuRkhTV0xSWWlkd2RYNzEwNUUyT0ozdFI0cE1p?=
 =?utf-8?B?UDB2Qk85bG9NemRVbDQ3eVpxMGhTa2RPanZyRkwyakJvblhOWFQ3NUZhNy9Y?=
 =?utf-8?B?U0tkY3BUVkkwSjFvdk5rRDFJZlJFSlgzRmRNOTdOSzhyTU9mV1pTc2kzeU5y?=
 =?utf-8?B?VnVPQ3M1TGJRcWU2NHFBM3owTFJ4V0VNc1MvWURFMkEydHExWjhBcHhBSWcr?=
 =?utf-8?B?RTdFV0lJRXdyYm5LdDhqdTJndTUyMnRCOFhqRkx6K2xIVElOazFPbWZSVlZX?=
 =?utf-8?B?ZHNxVjNQazRYeEp1Z3FJU2hkVjVjTUhtRm5DbTM4bnBhemJGVVpxVk1qVEwy?=
 =?utf-8?B?UGtBbkhxR3ZVVUJVZHhoR0VrN1ZaMXZQb29JbWxHNG5IM2dFZ3lDNFhsMGlm?=
 =?utf-8?B?VjhseUhVMWhKZjNHcThZK2RLMnVJNEdKMzlwZ2t5d3FreStySzdqam1UT0Vy?=
 =?utf-8?B?NHJJbktHajRFbTRvQ0JvZmZHSlFhWjN0TWxqU3VHSUVwUkp6a0pYN1NMZU1l?=
 =?utf-8?B?K0ZQR0ZpSVlxd2V2bkNuN1diRlloSnRNSVJzaXRJV1dSN25BVlFHbXIxNlFG?=
 =?utf-8?B?ZTB6dHZXYVVRRkhyYkE5a3N3NUhUUzZ3d3lzNWhkb0s2eE5lQS8vMGdDdkRY?=
 =?utf-8?B?S1FyYlUrRXVFdlVDZDJWUFFkYXRXWWlLQWM0LzNiS094R1IzSDFPaXVRM2pZ?=
 =?utf-8?B?Ukk1cEFqQk9ESVdESElKcUh0Y3k4S2ZZMVcrdnVmL2k2bDkrSlFPTUtjYWdn?=
 =?utf-8?B?MTBoeDhjenRVcENndHVOU0wzQlBDNHVyU1oxaTM5YnlNcmw5QjgrMjVqdFAr?=
 =?utf-8?B?UVhwQ1FYUG5IY2VrN3dmRXluUFZ3eUZoTTY3U3JOelAyNUZ1ZEdiNnhMUkJF?=
 =?utf-8?B?QzM1amUwRFppUXVhNWR0RjZ4WXZzSUVFYWFLKzhiKzA0OFQ4VXZaazRhZW8y?=
 =?utf-8?B?MHpZUlMyM3g4ZEpDTS9XZFM3QWdWVTlRdHRSVVJyNm1TT3dtYUFoMTUxQlov?=
 =?utf-8?B?d3gxN2s1TXpIT1BlV2NLMUlHTElNYzZ6dG5Ia2hnTGlMNkFmNW1wa2NsWUY4?=
 =?utf-8?B?M0JPamlZcXVvVHArdkdwckFFM3VxdjNCcWNtbTdxWkpUWXF0ZWlMbFVTa0Fn?=
 =?utf-8?B?ZGJhTkRiRGtta3VGU0FXUmRzUHU0TjFXb0FoMkQrelhZVGJLcFdoaUJuK08y?=
 =?utf-8?B?RHplWmF2SWlJVTRFT0Y5NTYvS3Y5UFhJNXF2L3JRZWl3RUVGRktJbHpnNXJ2?=
 =?utf-8?B?ZWt6OXZpRkwxRTc0ZHNCcGRxNGNlOS9tZkg5N0VIVWhPMXlDTGJyVDF3PT0=?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q1JNUWJhdEp6bGZ2MVFDbU1CZXIyWkpYMVBPdk0xNGpoSjMxRDZjcGU3SzV4?=
 =?utf-8?B?NS9oU3dXbUlueE5vUitrbWZzMnJQcnI0bGFjVkhoQmlLL0ZPdE1JL1hYRzFi?=
 =?utf-8?B?Qy9HQ1l6THpYQ3ZiWmRuZFI2MjZTcVhWV00yY05pVWwzWGNxRHBaanQrY045?=
 =?utf-8?B?WVlsMW9CMVNiVWpIa2pJdFNURXNMdHp5UkI1MTRtRDZnaTk0VzJEdVNWZmc3?=
 =?utf-8?B?MHNRL3B6MlEyb3lpVDdYOTdGVkhGRU42cXlObE4yOHBqekRhUEZpY3Bod3RV?=
 =?utf-8?B?SndSQ1d4cTdsbDZ2a3dMaVZOSk9LcTgwS2J3ZS9tUjArRUV1WmJ4NFFzblUy?=
 =?utf-8?B?MHdHaHFuNGFsWUl1Wkw4b09scnRoRURBbzlrTDV0eWNERklZRkpBRlUydlM5?=
 =?utf-8?B?YUt1b1hkT0xnQkxSKzF4Z1lqT1VDUmpNczlGSEowMmlYbXc1T0pVeTQ1ZFhj?=
 =?utf-8?B?bW5TdlEyQUdJWEszU09SekR2L25vM0JFeDJodzdDK3JTUmIzVXZoUURyM1cy?=
 =?utf-8?B?OTYzc3NzdmsvZGdNbEM2QXF5aktYbU5reEQvYkFNTitlOWRIc3NGazJyWFVY?=
 =?utf-8?B?aTlJeFFpTzNkMjl2Rk9FZWFndnAwZWFEZ3hES1J4dHd3TG84bngwRjh2SDNN?=
 =?utf-8?B?Wk4rMWJ2czZKM3ZDMm0yN00vQUlwSGExTldqU2lZclU5NFZEN2ZpaitxK3hk?=
 =?utf-8?B?blR4M0xJd1RsUm5yWXNUVlBWb3VoWTdrNEEzZnVMTHRGNzAvM2N0cm1KR1Zp?=
 =?utf-8?B?ZmNNRS9WbmhheTBHWDlsSzczeWU4L3B4amx4QUMvWDI3NWZscHd6cGdCRHJy?=
 =?utf-8?B?czhpUSswLzVVaVRyT1B1Q0hkcVQ1Y0h6NllMUkVGTTh1ckMrN3ZGTjUyTUJJ?=
 =?utf-8?B?M1FHbVpudVpQMDdweUpkL1JCT3BEWkp1bFhHSkhCMlFRL2lvT2hDWGtyOXMx?=
 =?utf-8?B?ZnJKWUtZeVlPQk9KRkhQZG5DNFVtMTFMSmtEYnRPZ2FRall2WFdZb0pXaGJM?=
 =?utf-8?B?ekJjZjgxbGVjRlIxS25GbGp2TkIxdTI1UTNrazYwckRGb3JZQWJaSCs3RDZB?=
 =?utf-8?B?SHFjamhkMG95ZkY2emN4RkhCUGVPaVlydnZKMGZYR29Zd2FpeGZzVVFXZGNy?=
 =?utf-8?B?Vmh1d0I0TVZ6TWhCcGdTVnYzNlJSQmdyR255bFBWVFJYR1VZTnVEMEpBQkVF?=
 =?utf-8?B?L2FmUmhkN2d5QStiM2p2VXNxVlFCeTYwT0Jub3NkanZHemhuTndvbGRmK085?=
 =?utf-8?B?V2xTTVNuRDl0L2hpK2RKSzlHYWN6cXg5NEd3WnhsQXlHV1htb1ZHYkZ3S0d2?=
 =?utf-8?B?R2l3ZDB3bUFpOHdoODF6eDg3dFQ1UVVCTGtybEhUV1FnN3V6R2FEbXJFNkM0?=
 =?utf-8?B?MlV6SEQrdDJROVJxeHRibENtOHVwbzY2VUtsaVcybUFpTFpGREJYRUx1a0dj?=
 =?utf-8?B?T3NUT0VlTVpyRFBVN0lobGM5SFFlRDJQek5oVHJRakdNbTg3MzMzR25ncXMz?=
 =?utf-8?B?ZzlQZWtHUm8rd2lyQUFkb21aYmlQNUYwd2I3TVRGVzVieDd3YUpySjRPa0kx?=
 =?utf-8?B?OWlIWHYwd1ZZL005SWNkYnVYTjBJcStoZlZ6V2VPV3IrdHIvbE5jNnRINXd2?=
 =?utf-8?Q?gMekQkb7KszhHYuNh/J2BEniyEIQANZUKXT4ZuNyUl3M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9052-0-msonline-outlook-827b9.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d9a6b0-35c9-47bf-130f-08de1da6e4c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2025 02:39:37.2809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB5671

T24gRnJpZGF5LCBOb3ZlbWJlciA3LCAyMDI1IDk6MDIgQU0sIEphc29uIEd1bnRob3JwZSB3cm90
ZToNCj4gT24gTW9uLCBOb3YgMDMsIDIwMjUgYXQgMTA6MDA6MzNQTSArMDgwMCwgV2VpIFdhbmcg
d3JvdGU6DQo+ID4gSW50cm9kdWNlIHRoZSBJT01NVV9QUk9UX0lFIGZsYWcgdG8gYWxsb3cgY2Fs
bGVycyBvZg0KPiA+IGlvbW11X3YxX21hcF9wYWdlcygpIHRvIGV4cGxpY2l0bHkgcmVxdWVzdCBt
ZW1vcnkgZW5jcnlwdGlvbiBmb3INCj4gc3BlY2lmaWMgbWFwcGluZ3MuDQo+ID4NCj4gPiBXaXRo
IFNNRSBlbmFibGVkLCB0aGUgQy1iaXQgKGVuY3J5cHRpb24gYml0KSBpbiBJT01NVSBwYWdlIHRh
YmxlDQo+ID4gZW50cmllcyBpcyBub3cgc2V0IG9ubHkgd2hlbiBJT01NVV9QUk9UX0lFIGlzIHNw
ZWNpZmllZC4gVGhpcyBwcm92aWRlcw0KPiA+IGZpbmUtZ3JhaW5lZCBjb250cm9sIG92ZXIgd2hp
Y2ggSU9WQXMgYXJlIGVuY3J5cHRlZCB0aHJvdWdoIHRoZSBJT01NVQ0KPiA+IHBhZ2UgdGFibGVz
Lg0KPiA+DQo+ID4gQ3VycmVudCBQQ0llIGRldmljZXMgYW5kIHN3aXRjaGVzIGRvIG5vdCBpbnRl
cnByZXQgdGhlIEMtYml0LCBzbw0KPiA+IGFwcGx5aW5nIGl0IHRvIE1NSU8gbWFwcGluZ3Mgd291
bGQgYnJlYWsgUENJZSBwZWVy4oCRdG/igJFwZWVyDQo+ID4gY29tbXVuaWNhdGlvbi4gVXBkYXRl
IHRoZSBpbXBsZW1lbnRhdGlvbiB0byByZXN0cmljdCBDLWJpdCB1c2FnZSB0bw0KPiBub27igJFN
TUlPIGJhY2tlZCBJT1ZBcy4NCj4gPg0KPiA+IEZpeGVzOiAyNTQzYTc4NmFhMjUgKCJpb21tdS9h
bWQ6IEFsbG93IHRoZSBBTUQgSU9NTVUgdG8gd29yayB3aXRoDQo+ID4gbWVtb3J5IGVuY3J5cHRp
b24iKQ0KPiA+IFN1Z2dlc3RlZC1ieTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBXZWkgV2FuZyA8d2VpLncud2FuZ0Bob3RtYWlsLmNvbT4NCj4g
PiAtLS0NCj4gPiAgZHJpdmVycy9pb21tdS9hbWQvYW1kX2lvbW11X3R5cGVzLmggfCAzICsrLQ0K
PiA+ICBkcml2ZXJzL2lvbW11L2FtZC9pb19wZ3RhYmxlLmMgICAgICB8IDcgKysrKystLQ0KPiA+
ICBkcml2ZXJzL2lvbW11L2FtZC9pb21tdS5jICAgICAgICAgICB8IDIgKysNCj4gPiAgMyBmaWxl
cyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBTaW5jZSBK
b2VyZyB0b29rIHRoZSBpb21tdXB0IHBhdGNoZXMgdGhpcyB3aWxsIG5lZWQgdG8gYmUgcmViYXNl
ZCBvbiBoaXMNCj4gdHJlZSwgSSB0aGluayBpdCB3aWxsIGJlIHNpbXBsZXIuLg0KDQpPSywgSSB3
aWxsIGhhdmUgYSBjaGVjaywgdGhhbmtzLg0K
