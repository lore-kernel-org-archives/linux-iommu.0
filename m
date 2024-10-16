Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2042.outbound.protection.outlook.com [40.107.21.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBB81F956
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 00:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729040252; cv=fail; b=LKE9vLkQl9zIFP51VUVoj8hQL8VP38yO6YjEJznX2JWWmvpSRDHqCW8DVhfandsbyaENXIeN2MuHxfnMSgsc8ZntvnVkONt/3w5qkPxoz+sQl8qGpAs3gci8b8DVoUr2/TH0gmmcolvnFkhfyxCK2SYWd7j87rRGERwvzC4Miu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729040252; c=relaxed/simple;
	bh=XPVIxLPOyRQnTvJ5UsMNAy5KQAKY7HKSXxHZio9MQoI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dWK4kYpaHjo+iGizWfMKwci1CuEBbBhxjZMYVoRhNVYvA3bLfxzPxJ0jKLnUNDVvnAp+wbrnvY2JwSP/6aP0cm8nIHfwkj7Vw6CXwGzCky3s/TPVFxvTZ6I+32Etut1KUIIGcUfVFjTPau51gMZ3Kx/sDnQxhxrETF7SvH9tHvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PhC+TVPR; arc=fail smtp.client-ip=40.107.21.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PhC+TVPR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bH/DUvGbx5YPBCaUm1ONQeDgb3/paxHHx/D7kq4RLrq9vMpCDobaD6H5+5fHGO+jdYLINlew62OfH8ccLv/OGAJksIvVETEgSobs1fquWwXh5rH1Ps3gZzEh9iyxhcCOWNsgSWciVBZluPiTZHRiTkcJnHV5jhFdqIKNwzM6t9xR9HtNPRx3qXOhocE5ogf4BCF9MO8boXIxXKfG0O1S7QEjcwHiw9VHhac1UUHKXmwEoeN52dcqlToWXSBPxmj9L/lHqAjGQJhZ91b9XrdUj/dyVLoBjbuK3f6pOes+p6BFoY88Q9w7YRIvUY3z68zHOBndhtt16rceunByABMRpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPVIxLPOyRQnTvJ5UsMNAy5KQAKY7HKSXxHZio9MQoI=;
 b=HKPMgaJRrOx2zDlYXLMc5ymgGkdxgPliFuG+XSdAMBUrqY76QwDw8Zo/3vHvb7KpoGS48Yz8hXgwqPNL5VQaAqJzqJgI7nlVeVvaG6EdqIbjlsBmu810I0WbYBRaGNZucTvY5MUacalHwl7+8czX46FfGjp318OdZGIPkyVQR60SR/X/shsdHpLuhg4PuQz515SXwzLpNSmGzs/BwiPeqFlztfdVy8X3dTSFXv0eRc5RNs8nrD0YWi8D/JhAg7IMfIW6hD3PWDnhV9CSMcMVzyeR1I2wmsvRmxwDzZR5igqSoVm0DgrfqQsjMkKlPADesRQ53vsqoVnKey+vxRJFpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPVIxLPOyRQnTvJ5UsMNAy5KQAKY7HKSXxHZio9MQoI=;
 b=PhC+TVPR/V0wKFP8kSd4K1EHm/CtUhQ0zIk+V/UhP1jr7snxSmERuuQOQzadVUT10emEDUun3Jc0kQNrj4v6Gm0KTbKB/gojfYZu9tli2h+xg649IEPPiNP4wUfS7KJfMXeTQInXUyOB3yj2LJ17fyCax2nPX73CVlmFblJ9bRsA1F2ADvBN8HCnLPNhrtM/aSKHbAMWpWP9zRRU+y0qCxiYMxIqp5MfqOM5BkW+Q8w98wcq/Tebu+HqK1+5Bf02EHMul4mceA3HHoit3ys9jzCazEOOIhPxj0A6GKaxz81i2MlbQPaIBA2I7FaEA8r6oTLdFks6l1Uwwz7Ka6K2Bg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB8282.eurprd04.prod.outlook.com (2603:10a6:10:24a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 00:57:25 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 00:57:05 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Robin Murphy <robin.murphy@arm.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, Will Deacon <will@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: Joy Zou <joy.zou@nxp.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: RE: [PATCH RFC 0/2] iommu/arm-smmu-v3: bypass streamid zero on i.MX95
Thread-Topic: [PATCH RFC 0/2] iommu/arm-smmu-v3: bypass streamid zero on
 i.MX95
Thread-Index: AQHbHq8rLo120RgQnkmAQnxom8vzEbKH5NWAgACo1SA=
Date: Wed, 16 Oct 2024 00:56:54 +0000
Message-ID:
 <PAXPR04MB8459AB654150BED2FB5FFDE188462@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241015-smmuv3-v1-0-e4b9ed1b5501@nxp.com>
 <a8c42a6c-bac3-4ebc-8a29-e6c0ed4567c3@arm.com>
In-Reply-To: <a8c42a6c-bac3-4ebc-8a29-e6c0ed4567c3@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DB9PR04MB8282:EE_
x-ms-office365-filtering-correlation-id: a1afff63-d070-45e7-1aed-08dced7d6fe0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VjdWbi92RTB2SlNtV2xEMlg2Z0lqYUhxdXJVeFV5MnJaNFNMZ1cvWXUvZWgr?=
 =?utf-8?B?WHRXazU2Z2VzMlA4a2wyb2l1M2ZtZVBjSk5mK3NkTzZuNHNjUU9YNVk2Ris3?=
 =?utf-8?B?RnlNYVN3RE8ybytzRnIvRXVld1kxTDVlVU0wS3o5OFlkU25ncUpISW9iM2pz?=
 =?utf-8?B?ZlR4aVp5eHVGUGFMSzFmSldOS1ltWEZyQjBRUmZ1T0F5NDJPL2JFb3BNN2dj?=
 =?utf-8?B?dkNWc09LeWJTZ2lGMyt6YjlOUS9lOFRjcUJEUlgybmVtMWdBNFROYjl5b2JB?=
 =?utf-8?B?eDRRckUrUzdCNmxhZHhZaFJzd0xyaXhUSFNZbGxCZVVlaC9rVVZSMHRiWjh2?=
 =?utf-8?B?WjFzenFManlrRE5PcjBSVTE3YW5CVEN4Y0I5Q0UxUVk0OHV6Rk9TOTk2ZHp5?=
 =?utf-8?B?bllxQlFzblZjMkg1N1dpbDJSRm9HVnpqcDVxVzZLeHp3Snc2Z2xFMnpJSTNU?=
 =?utf-8?B?cUJVV0VpZ21IajNJZGNvMWtyRDhLUmM2QnBJQjFTc3QrYTFpbnJnaEhhdEc0?=
 =?utf-8?B?TDZMOFAvQUN5a0ZrZUZ6WHFsQ2JYK2dQVWI0K2tXb2I3RFV0T0pQcEh5RXFQ?=
 =?utf-8?B?WkdTRTREYzhIVjBKWUhjeHJIL2NmNjVFclFBL2lXbmxySDBXbTdVckNpRTNL?=
 =?utf-8?B?akFOOEdNV2ptaGk5L016a1M3NkptMEdGL3ZKMGJhQnNoMVJCYllBbExwcUhZ?=
 =?utf-8?B?emIydXRpayt2QzJqSUROakpGcG5Tcjl6WHNWWVhwaDZxdUcweTFrU3NMc0xK?=
 =?utf-8?B?eGNlU0NFdWpFYTNYZXRTWlBVVDlKUkk3eFVNU1FrZDU0RFh1cVhMTXJmUDVB?=
 =?utf-8?B?cW5WSy95WUFxOVZyM1AzVzFuKytaUHZXVmdvN0N4anp1ZldzMytDMXlYcFVT?=
 =?utf-8?B?b2pUZlp5UnpwRUxxTzE5WEdxMFg5c3dBQlZtUzVyMGZwalpKT2g1Q2JMVENB?=
 =?utf-8?B?UnZMQ0JyN3pjTHpZSnBPR20rZjdNeUFCUnJlRVh1VlJzazdEWmQ1MWVJTmdI?=
 =?utf-8?B?VUE4a1dHbGVnZHdlUE5qczU5Q0RvR3o4bVJ3cVhIVTJvRlI2dFhiamxPUXlw?=
 =?utf-8?B?aDgvQ0tScC8wRHBHTERxclJudElPUjlpR3NwS2NuVUhXU0puZ2Z1cHIzSlpa?=
 =?utf-8?B?V0FRekV6TE1WZ1p6TDU4UC9jdEptandLMm13Ny9ROGVFcFVQYWtYelJrWEZs?=
 =?utf-8?B?SWtTc0VpS3M3aU53Qmtyd1l6YzkyME1BVDF4enhQaW5DM0NYL0IySnFSTGlP?=
 =?utf-8?B?TkJjMklmaG9nd0ZDZUNkOGtHeXVXM2sxWFM0VUFMc0JXSmd3R1ZZaEdMVk1a?=
 =?utf-8?B?NjQ5Zk5OZTVkbmcxcExsNEQySm9pZWVDdzZzT1JMaHl6ZnRGeWdQSm42SndD?=
 =?utf-8?B?UTJyZis5bkNqY3psNjdHdEQ3K2E5OEQzeGJEZncvWmZnaEt2RHp0U1p6UmVQ?=
 =?utf-8?B?M2dwUnc1UVNWSm1ScUVHaDhWUWFScmIycHFLeHBSc01ScnJSWG5rRURnaGx0?=
 =?utf-8?B?VHhaSlVqS0lCVXRhNmM4aXA1bzlwNld1dVNpaVN2SENWK1FEVzFiK3VVckUw?=
 =?utf-8?B?Nk03S1RCMkk1SkJNSWtuenRPalZuNlRqOEc2VVB2V2VmVHE5d2NoZTdCUUxp?=
 =?utf-8?B?TlROY0laTjFVczJsLzRtNVRIY3pJQkxyY3U4d0JVZFo5Z3grb2MzNHdLTk4z?=
 =?utf-8?B?S2R4Z01Lc29aaGZhRHNBcWF1THJ3YitwTUZzSUdDRCtxUzRCWHNrdmk4VHNa?=
 =?utf-8?B?Z0xwMWMzRE5uYnFMejlUTkNtcjlZNHNTZjVxQnBBVk5iTTVLc1YzQU8zRFBX?=
 =?utf-8?B?cEh5NXhhd1dYVXhObXphZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TnBjNFdYbXd6VEYyRTBtYUxJR0VuOE1qZ3poelRaTW1UdVlvUDVzRWhObGJI?=
 =?utf-8?B?V1NTY0VHcEl3R282S1k5cysxenJSdjgwc21MVWtQMDFEbllyMStHaDU1djcz?=
 =?utf-8?B?amk0aXRiL1hZMER4Sm5ERXBSbWdsREpaZnRrQ2YvNm9xeXVFenAyZ2lJNHZy?=
 =?utf-8?B?akg2OENadFMrUzRLbW5YLzVVSHVSTi9tZGlTRFNibnhkc2pwQmpvSGYvQ0VI?=
 =?utf-8?B?VlFHbGJPa0hxTG4yNGNKYzdvbnJsVnRmVFIvVzZlK3AvV09tZi9yUjhZVTdR?=
 =?utf-8?B?TTludmFuSmVUT1dNc3BUNzlramVXRWlhelBWYXQxNXJ1Nnd5UVNGNEFBSFoy?=
 =?utf-8?B?eFh4STBLOHZtWTBIdVRkZE10Q0JVYTZRcmVxOGFseDdQSjdnbFIxT015bUF0?=
 =?utf-8?B?K0tvQ2FpcG1WZldvRkZlU1UzV29jUFZXdWdraWszZlo3cUlQb2I3ZHlpVXZu?=
 =?utf-8?B?MUhGVm52N2N0bG5nMWh6eGhiWUEvVC9WaWtvdE1scjIrSlhWRit1RGJmcURh?=
 =?utf-8?B?SnlMUXF4UURnZE1scllQUldjcFl3am53SGxlbDRrd3B5c0NGTFRUYVVobG5Q?=
 =?utf-8?B?N2d1UHh6a00zRDZHN2c5eEF5QlczSllmSCtjMTJMcUpEWCswL2lvcllOb1A0?=
 =?utf-8?B?aVVFK0tUZVBZUzJ3Z0xhNDV6ZnZiZFQ4NnpxQTJmZkNIRTBpVWdNUGg1OWM1?=
 =?utf-8?B?MzB6RGtqR2Q4QTJKQUhad0NyV3pYMWdxdU5oMFNtOGsxNWl1d2dPNWpKbWZk?=
 =?utf-8?B?YTJFMmhlZkI3YXg5SkRjVHVnaGFTcEVGRDFoK3h4QkRJRHhWUDh4dkcvbXJk?=
 =?utf-8?B?cjFuSXRwRDJMMmUwWUtlNndid2xRdkMxbmd3NEI1M0VxQWt6QjFHVk1yaUd5?=
 =?utf-8?B?aDh6eGJzbWJibVc0cHBYTFlsUFlaWUdSVmtEc09wK09nQytMdGpnRHBwazZB?=
 =?utf-8?B?RWNSaEJDeGJ2c2RRNUZobkd3UUNxRkNHTEp3Q2QwTittUlZjbEZwVC9uOVFP?=
 =?utf-8?B?SmRqbkEwc2lNWXVhTzJwUS9lc0ZZUjV6bm9rRTNrUS90VEZDQ2NYV0VZMGxD?=
 =?utf-8?B?VkR4MkYyMWpoT25ock41NXNnZm5VUy9tREtQUlN6aE05STlhV3cxSEtob2Qy?=
 =?utf-8?B?NzA3VVhpeTgrc1dkQTQyYTBXaUZubHVndDd0dWFmVUJhMmViVzlEdFlFcG91?=
 =?utf-8?B?VG1MZC9LK2dQL0plWHpPaUlzdzBpRlErMS9JRWFiYmN4NlU2NTI3R0Y4SU5w?=
 =?utf-8?B?N1R6Um5YZFlCVjl6ejFSK0MrOGU4Z0RoeTJFY1UvNm9tbTMxdWY2WjhkZjJ5?=
 =?utf-8?B?UUZJZjl1K2ZLelgrdnZ6WTFjOTJZOXJFTHVOQzBWYmlUYVNiNnlDN3ZZZWVj?=
 =?utf-8?B?U1A3QWFRWlVtZVgwYUxxOXduYVdIaisydjBmSThsTjFRdHpVYmpQR1FrS3RP?=
 =?utf-8?B?dW0rempJMDJYWHhCa3dkbFZoK0tTcTBrSEthbDJ0K1VDczZEeHU0aGpJZUlW?=
 =?utf-8?B?Q2VUbHhIUGdoWktMZmUvSEJiTUhtdlJ6andXQmFGQ2JKaDdqdThGKzVkZVNE?=
 =?utf-8?B?dHlwWUEvTkd3bmQ5ZUZsaEo3RjBSM0FHMUxONkdrRFMxMDR3dUhQZ0U5cTNR?=
 =?utf-8?B?dEVybzl4NVJGVDh2c00vWWhWUnhlUUlJbXQ4eStuSGFXek9QcDRjeVdWVkpX?=
 =?utf-8?B?cGpsYlBuckpJcmRuZEcxNFJ5QU5ibWx2RVVaK05WeUVmV3A2QWtqZ3dZNXoy?=
 =?utf-8?B?R3J0RkxhbGFScC8vWkZkMWM1cEVUY1FDN0RxWDA5UlpVWTAvU2ZLL0dPaThS?=
 =?utf-8?B?NTFvMzdubGV2d3VPODc2M0RySUF4bytuSHJJQmRIblFYeUZkMENZN2NtY3g4?=
 =?utf-8?B?S01PTkNhVWJieWludjhPcEZ4SFM1RzYyWkQzVGVkUGRmczFDTzMvU3pzZHdk?=
 =?utf-8?B?QW9VVzFVUG1FVWw3ejNCdmxiQlJ3bVJjWVZUcTUrSkszOERmZkh6L20xMFF0?=
 =?utf-8?Q?w/MnRx6ggdE6/dWqBYnAz5d6R3kx50=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1afff63-d070-45e7-1aed-08dced7d6fe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 00:56:58.3350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ihcChfk9U1E78Oq1nZeSnfrHbo61yaP7kzGb/MctHpb95gLl4ukyIDvoY9n/ONGWBFHFwwmm/dJB+FUGlqNLNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8282

SGkgUm9iaW4sDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBSRkMgMC8yXSBpb21tdS9hcm0tc21t
dS12MzogYnlwYXNzIHN0cmVhbWlkDQo+IHplcm8gb24gaS5NWDk1DQo+IA0KPiBPbiAyMDI0LTEw
LTE1IDQ6MTQgYW0sIFBlbmcgRmFuIChPU1MpIHdyb3RlOg0KPiA+IGkuTVg5NSBlRE1BMyBjb25u
ZWN0cyB0byBEU1UgQUNQLCBzdXBwb3J0aW5nIGRtYSBjb2hlcmVudA0KPiBtZW1vcnkgdG8NCj4g
PiBtZW1vcnkgb3BlcmF0aW9ucy4gSG93ZXZlciBUQlUgaXMgaW4gdGhlIHBhdGggYmV0d2VlbiBl
RE1BMw0KPiBhbmQgQUNQLA0KPiA+IG5lZWQgdG8gYnlwYXNzIHRoZSBkZWZhdWx0IFNJRCAwIHRv
IG1ha2UgZURNQTMgd29yayBwcm9wZXJseS4NCj4gDQo+IEknbSBjb25mdXNlZCwgd2h5IG5vdCBq
dXN0IGRlc2NyaWJlIHRoYXQgdGhlIGRldmljZSBvd25zIHRoaXMgU3RyZWFtSUQNCj4gaW4gdGhl
IERUIHRoZSBub3JtYWwgd2F5LCBpLmUsICJpb21tdXMgPSA8JnNtbXUgMD47Ij8NCg0KQ3VycmVu
dCBTTU1VLXYzIGRyaXZlciBub3Qgc3VwcG9ydCBzdHJlYW1JRCBzaGFyaW5nLCBidXQgd2UgaGF2
ZQ0KbGltaXRlZCBzdHJlYW1JRHMoaS5NWDk1IG1heCBzdXBwb3J0cyA2NCBTSURzKS4gSG93ZXZl
ciB0aGUgZURNQQ0Kc3VwcG9ydHMgNjQgY2hhbm5lbHMsIGVhY2ggY2hhbm5lbCBtYXkgaGF2ZSBh
IFNJRCwgYnV0IG5vdCBzdXBwb3J0ZWQNCmJ5IGN1cnJlbnQgc21tdXYzIGRyaXZlci4NCg0KV2Ug
c2VlIHNtbXUgd291bGQgZGVncmFkZSB0aGUgcGVyZm9ybWFuY2UgaW4gc29tZWNhc2VzLCBzbw0K
d2Ugd2FubmEgdG8gZ2l2ZSB1c2VyIGFuIG9wdGlvbiB0byBieXBhc3MgU01NVSBmb3IgZURNQS4N
Cg0KVGhhbmtzLA0KUGVuZy4NCg0KPiANCj4gVGhhbmtzLA0KPiBSb2Jpbi4NCj4gDQo+ID4gSSB3
YXMgYWxzbyB0aGlua2luZyB0byBpbnRyb2R1Y2UgImJ5cGFzcy1zaWRzID0gPDB4QSAweEIgMHhD
IC4uLj4iIHRvDQo+ID4gbWFrZSB0aGlzIHJldXNhYmxlIGZvciBvdGhlcnMsIGJ1dCBub3Qgc3Vy
ZS4gSSBjb3VsZCBzd2l0Y2ggdG8NCj4gPiAiYnlwYXNzLXNpZHMiIGlmIHlvdSBwcmVmZXIuDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiAt
LS0NCj4gPiBQZW5nIEZhbiAoMik6DQo+ID4gICAgICAgIGR0LWJpbmRpbmdzOiBpb21tdTogYXJt
LHNtbXUtdjM6IGludHJvZHVjZSBueHAsaW14OTUtYnlwYXNzLQ0KPiBzaWQtemVybw0KPiA+ICAg
ICAgICBpb21tdS9hcm0tc21tdS12MzogQnlwYXNzIFNJRDAgZm9yIE5YUCBpLk1YOTUNCj4gPg0K
PiA+ICAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvaW9tbXUvYXJtLHNtbXUtdjMueWFtbCAgICAg
ICAgfCAgNCArKysrDQo+ID4gICBkcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21t
dS12My5jICAgICAgICAgICB8IDE5DQo+ICsrKysrKysrKysrKysrKystLS0NCj4gPiAgIGRyaXZl
cnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmggICAgICAgICAgIHwgIDEgKw0K
PiA+ICAgMyBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0K
PiA+IC0tLQ0KPiA+IGJhc2UtY29tbWl0OiBkNjFhMDA1MjU0NjRiZmM1ZmU5MmM2YWQ3MTMzNTA5
ODhlNDkyYjg4DQo+ID4gY2hhbmdlLWlkOiAyMDI0MTAxNC1zbW11djMtMTIwYjI0YmM0NjU5DQo+
ID4NCj4gPiBCZXN0IHJlZ2FyZHMsDQoNCg==
