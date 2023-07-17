Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2099.outbound.protection.outlook.com [40.107.215.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB04EA49
	for <iommu@lists.linux.dev>; Mon, 17 Jul 2023 02:14:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCT9iBaMV2joS+BeoOpRaIKX1BQoeLt25B0zYsQfBqQtc4sdoG1mGGb/5saHsblZjRc0VUC7ztE8KHQZmYC3/QZW42Uj/1N+5UymSquymoPLaoUpD7vNE46KII8c/SA36y2Mqgd0ESxf3FCv09LcY3WvcInfGfVXbvXuw280BYQ94hR5YwWLAlpzQWLIvQjG5bq6PRpVmFtRFwqvq7a56WBJDB52vjbemEffdFRzr4BVS6TrNWrVTd7Xdn1HMDTEhmvy6QOItEvceKC9EGEMZ4BcYfLI3fG4rXPnOF+n4FDJUZqSdMKcxnfI9r95f2Si9WECe0nDtNF8TBhQpz+qtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKt0KikQ6ESjHluV6DdsqoHs76rOmVMz/DEFbPknzFk=;
 b=ZsGjxKyl6mSvWTIFO9mZjc2sPL9AUKjq+03YwapPykzTCp03PBp5JtMy5Lx3L2s6HPMDRWRR+qelXygt05LTBPW8CHaHs8xI6ofN9nICieoloatdBpCrgQBpefCHgRSs6PLgbk7IvREEQcq1eRb3qFBx6GaaIdUU0Zy2H7qLv+YsTWlzorc7F1AObXALB8wdSXl7GYdDVuTqC6bnMAdsBdYjK4Ip48rsnMXmAH+95KCXbgYocgGRjrrpN1Ae5iEM3TBXszD+6+cyUWE1Lx6eUTJAMXPvf7moEPhh4kZD0QfB7kGvmOdo+7zddID3alKCAE5ElyoFHGfdD1gICD59RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKt0KikQ6ESjHluV6DdsqoHs76rOmVMz/DEFbPknzFk=;
 b=YkUS5bFF7TnuxOkkEkffLjPQVR3mt0rzaA4syfz1u68UN7N+32gNX95XwOMoRi6qvwv14MSIhoczUIv7WPCVukGwBwWu4a+XZOz9v9KfikI6zwsYTfz6SFzky32HoWZ3AeJcD6CWBHYenqJZuHcUJn/u8QbqqDMrdBds0kTB14Q/WasK0iNJerknTgc9cq0rhQ7txWWq14HPGVe4+bL59BSCWtZwSn8JrqnEHgZlH7E+XXpf1vEhEp159WaQvA2u++Uj19xhltk/+O8QiP/LUNbZq++fGAvHL+/8vbAJpQwNQOOjNoGoLLsgL+8aFt9hjl8qYYZoQrJNoveCmY5FFg==
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 TYZPR06MB4240.apcprd06.prod.outlook.com (2603:1096:400:65::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31; Mon, 17 Jul 2023 02:14:14 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.037; Mon, 17 Jul 2023
 02:14:14 +0000
From: =?utf-8?B?5p2c5pWP5p2w?= <duminjie@vivo.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Thierry Reding
	<thierry.reding@gmail.com>, Krishna Reddy <vdumpa@nvidia.com>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, "open
 list:TEGRA IOMMU DRIVERS" <linux-tegra@vger.kernel.org>, "open list:IOMMU
 SUBSYSTEM" <iommu@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
CC: opensource.kernel <opensource.kernel@vivo.com>
Subject:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjVdIGlvbW11OiBGaXggYW4gZXJyb3IgY2hlY2sg?=
 =?utf-8?B?aW4gdGVncmFfc21tdV9kZWJ1Z2ZzX2luaXQoKQ==?=
Thread-Topic: [PATCH v5] iommu: Fix an error check in
 tegra_smmu_debugfs_init()
Thread-Index: AQHZtisSu01BzDxsvEWu1GvQfmCRS6+6XicAgALcaXA=
Date: Mon, 17 Jul 2023 02:14:14 +0000
Message-ID:
 <SG2PR06MB5288FE67D20491B9B5F714ACAE3BA@SG2PR06MB5288.apcprd06.prod.outlook.com>
References: <20230714081320.1998-1-duminjie@vivo.com>
 <db554c27-f663-0146-5e5f-b319547757c3@linux.intel.com>
In-Reply-To: <db554c27-f663-0146-5e5f-b319547757c3@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB5288:EE_|TYZPR06MB4240:EE_
x-ms-office365-filtering-correlation-id: a78eac1c-bef5-46ea-ae39-08db866b842e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 nNfxnxvkYR/EOoFVVCIhDWhidAEF/Qn7z/P20ppgjjQ824L9TY+M0JUiN1Gwtwht1/BDxcgp7V+fvBvLS0o15+ZvJFIQxwhxE9JkxXCkPpmGujwdGE537GPsBl9K2MYPsVW75j4Fi0PWeqUG/o+KTo01H6wocNXFik40usL1hAv8hEvTl9rMOc+2/ky6gKuab6ToTijl16B8fNcs5AHd1DDnwp6Ki/6hZctC6QPhbzBMmJbCqilyUmOMrmkJYB3oWH7nLTY4Sdglb3Tdk0tGFLgD5PfH6CSweDt31LBq7sz5Ns9dJPB6TaoIhD3R0feUNC/XWHk4I25AGXrnXjnJv2+HBGFiOAfFAZVE989DVI2oAUtdgV8VFBqnmMLf7VXIUvsBUZV3hJM7//OOTIreBNnOmiZM0LiZEF1ZfZRe8Sb/Qj7t6W4l136jY1JOLh6k/pICEwpuR+CbEzUo1Prz05HChJK1C4dATbgCywMMIjC7GVtt+aM2M7zIRLk5GvJSgBgQJ2AsWEd0rjdAcnRUDo1eTCrQfOQletGE0XBKm6lojZ5RjNuqLS2DgvCVS/ky1+JDF+OuUo6VP+SKci2KMktK8caciBy4aynjSkzLRBk+ajI4wjmmCbUZkNiuzo/tNB5+drBvgnvwZnvN0GcGMQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39850400004)(136003)(376002)(346002)(451199021)(478600001)(66946007)(66556008)(66446008)(64756008)(66476007)(4326008)(5660300002)(52536014)(7416002)(316002)(76116006)(8936002)(55016003)(2906002)(41300700001)(71200400001)(110136005)(966005)(26005)(9686003)(6506007)(53546011)(7696005)(107886003)(921005)(38100700002)(33656002)(186003)(224303003)(83380400001)(85182001)(122000001)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bmcwMGFNQ1RoTkpjVDBNSERTNDJoWUtacG9CaGVzYTlGVVRKSVFoQmRSVFF0?=
 =?utf-8?B?QlJZbUpmWllod1E0QS9GT2dLOGI2NStMZ1ZENVJ3TFM4QmVOQzN2VFFQZHdJ?=
 =?utf-8?B?bHl4WTVaV1hlVHVlWjBMYm4zRERQWWdUcW53bnYwci9tR2Q5eWs3aVIvUTFR?=
 =?utf-8?B?SEJnNk5kWVNTOW9VMjFnVlpvSGNGcVZGd25qdW5nZU92aWFYSldSSnF6Q09m?=
 =?utf-8?B?cEkrdUkrZTZTQ3cyTFVvVWQ1R1RjNHpqbDZCcUFXekNNZEV3WVZrLzhrK3g2?=
 =?utf-8?B?WjhpcVprVURLNmRNRkxKL1ZYY1VKRnV4bWczemY0ZExJV1d6VlJwZmlRdENX?=
 =?utf-8?B?ZTVyUFYwYWRTL2cxRUtCYWNJd1lqODdSWnBQSW5IRjRKSEx6LzZURHlRMkVH?=
 =?utf-8?B?aHFxbm5ZckRLZmUxYkZmeG9GcDJiOHl5Y0xkdlZuNzRJN3JmdnpBMEFZRkQw?=
 =?utf-8?B?WkNvcDlkd3I0ZVZ0Y1dNNzRjajltcDFsWUpwbFdUTXN4YnZDc3o1cFdpeEJk?=
 =?utf-8?B?R1pRZWZHK2djWE0rZ2FxeDRRRzdqNk5BUjNoZ0VPWlcrai93YTNGK281cWE5?=
 =?utf-8?B?dENlTm9HTVNOajlkZlNla0xxemw2UDRpalovS2VabkovMWhBaUhsVE40SGZ1?=
 =?utf-8?B?Z0JsMThUbmlmQ0FUTEJkNzhHY3BuLzlodUxCVXBmMkZBcHh3K2dMYmtrTk9n?=
 =?utf-8?B?MmZDMWYwU2FkSVF0Nk0wbGZHZk9rN0taUHVzYW9mUWFyZUZiQm1YbnFQVllM?=
 =?utf-8?B?YWk5cHJhR1llSmo4eUpqcis3WXNrNGh6clNaRTc0VDJLM0xLb1FieTA0OHFm?=
 =?utf-8?B?c0V2NFlXTGxuQnh3MVNnbWIxVmhHRGFxVzhFMW9DOEdKUGo3UnFFbUNocGdl?=
 =?utf-8?B?Ny9MSVNuK2xQb1JRQ3F5S1NVR0JlRDA3Z2JYQUI5Q0E1dXBGekg4cGVoTWxm?=
 =?utf-8?B?TlMvVkVwM25nT0pwWXJZQmtDT3BiQ2FmaHYwVzkwdWlGTEhVcHpWemhianVP?=
 =?utf-8?B?OHZVVVZhei9PMDZ3WnpQWEhOQkRzQkwrUldjMFU0MEpuUjFRcFRSRVNmSTRs?=
 =?utf-8?B?UVdDT1N0ZndmMjVhTW5FM1hReVY2VDlsb1FwQSsxSnZVb2tKRGZGQ0JoM0Ni?=
 =?utf-8?B?ako5aWd2RW81L0pCMHZ1Nzg5MGJGYjZWYTJxeW5ORldzM1pybUNBNS9ZTnhX?=
 =?utf-8?B?c3ZlLzdYVWFoVVI0MnB3RytxYnNPeUlEdFdjNERzOWI4Znhta1NMZC9MRmhQ?=
 =?utf-8?B?eVM0bElwQUZjL2hLZW0xWDZHUkVXUDIrVmNZczdYZkU0ckdGNlRCQUFTQmpn?=
 =?utf-8?B?ZFFqVE1iZTVlUUlmcnZROHZXbjkzZzQ5b1JOQWVaTWtmWGkzV0JiYkFabWF3?=
 =?utf-8?B?bTIzU010TGt6ZjBQM3FuWi9YZVdWOVByMEtoQnRxMjNYQVFNczlMSzg5SGlF?=
 =?utf-8?B?RGpBM0VQTmkzNWtoNm1OMWdodmY0dEw0NGQwZ0g3Y2phNTE0UjQ4ODFkRXBl?=
 =?utf-8?B?Y3k3K3hJdEFFdGZ5WVZYcGFoUDdEbEV6b2V0WUVFNlRqWjRjclI4cTNiY1d5?=
 =?utf-8?B?OXFWRDBjWXFoUzB1aFNucmdaNC9ETjd2SUNzUXkwWTg4T2dlY0ZxYWNONndX?=
 =?utf-8?B?QllnUTdlWEh4a3llQUFuK1BYYkIrd1d6M0FrcDUxYVkxMlVkVDd0RVpDeW9S?=
 =?utf-8?B?RG1pKzNUZ1ZYN25kTVJOZlNNaW1pVlVrcHJyQ1ZlTFBrZklPNlFHMlJEdXNJ?=
 =?utf-8?B?aWNuVWI2SkwrRkZqQVhiRXpCdk5uWHgzaGFDRnNiNXNSVjVJQnNKeTE5VEtG?=
 =?utf-8?B?eWhPSkc5ZXEyakNwVFhVY1ZpS0pRYmY3S09QQklVUTY4UU1qSG95KzVFcm5I?=
 =?utf-8?B?WVlmK2dOVVJ2TldvSTZwQXptbzJHRTRzTXUwYnM3bnlDTVF1VWZDUktQYXc0?=
 =?utf-8?B?dG0xOEJ3YU5DWFZ1REZlVmFCQW5lNHB1NkRGRDB3L3EzRFNjc2VzYjY5K1Y0?=
 =?utf-8?B?UXRlNkhaQkNDVVFsUldwb2tBbWkvejY1Ly9ldGEyeGZHUHBlUUllbW1hL0Jw?=
 =?utf-8?B?Vmt0SllvaUZVU2l1SFlaV0VzSS8ramU5Qi9hT29paHpET3R1Z1VRVEU4WWRQ?=
 =?utf-8?Q?mn00=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a78eac1c-bef5-46ea-ae39-08db866b842e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2023 02:14:14.0200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8+YSaAFBUXy6oRd0ihJY278qJ//StG+kKuKpqJVzgLMoIklO2kZPA2CMntu16QAonQgDs2RI5etNGZxrs5Nb2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4240

SGkgQmFvbHUhDQoNCkknbSBzbyBzb3JyeSwgSSBtYWRlIGEgbWlzdGFrZS4NClRoZSBwYXRjaCA6
DQonW1BBVENIIHY1XSBpb21tdTogRml4IGFuIGVycm9yIGNoZWNrIGluIHRlZ3JhX3NtbXVfZGVi
dWdmc19pbml0KCknDQpUaGlzIGlzIGEgd3JvbmcgcGF0Y2gsIHNob3VsZSBiZSBzaG91bGQgYmUg
ZGlzY2FyZGVkLg0KDQpJIHN1Ym1pdHRlZCBbcGF0Y2ggdjZdLCBUaGlzIGlzIHRoZSBjb3JyZWN0
IHBhdGNoLg0KU29ycnkgYWdhaW4gZm9yIG15IG1pc3Rha2UuDQpUaGFua3MhDQoNCnJlZ2FyZHMs
DQpNaW5qaWUNCg0KLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0K5Y+R5Lu25Lq6OiBCYW9sdSBMdSA8
YmFvbHUubHVAbGludXguaW50ZWwuY29tPiANCuWPkemAgeaXtumXtDogMjAyM+W5tDfmnIgxNeaX
pSAxNDoyNg0K5pS25Lu25Lq6OiDmnZzmlY/mnbAgPGR1bWluamllQHZpdm8uY29tPjsgVGhpZXJy
eSBSZWRpbmcgPHRoaWVycnkucmVkaW5nQGdtYWlsLmNvbT47IEtyaXNobmEgUmVkZHkgPHZkdW1w
YUBudmlkaWEuY29tPjsgSm9lcmcgUm9lZGVsIDxqb3JvQDhieXRlcy5vcmc+OyBXaWxsIERlYWNv
biA8d2lsbEBrZXJuZWwub3JnPjsgUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT47
IEpvbmF0aGFuIEh1bnRlciA8am9uYXRoYW5oQG52aWRpYS5jb20+OyBvcGVuIGxpc3Q6VEVHUkEg
SU9NTVUgRFJJVkVSUyA8bGludXgtdGVncmFAdmdlci5rZXJuZWwub3JnPjsgb3BlbiBsaXN0OklP
TU1VIFNVQlNZU1RFTSA8aW9tbXVAbGlzdHMubGludXguZGV2Pjsgb3BlbiBsaXN0IDxsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnPg0K5oqE6YCBOiBiYW9sdS5sdUBsaW51eC5pbnRlbC5jb207
IG9wZW5zb3VyY2Uua2VybmVsIDxvcGVuc291cmNlLmtlcm5lbEB2aXZvLmNvbT4NCuS4u+mimDog
UmU6IFtQQVRDSCB2NV0gaW9tbXU6IEZpeCBhbiBlcnJvciBjaGVjayBpbiB0ZWdyYV9zbW11X2Rl
YnVnZnNfaW5pdCgpDQoNCltTb21lIHBlb3BsZSB3aG8gcmVjZWl2ZWQgdGhpcyBtZXNzYWdlIGRv
bid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbS4gTGVhcm4g
d2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJ
ZGVudGlmaWNhdGlvbiBdDQoNCk9uIDcvMTQvMjMgNDoxMyBQTSwgTWluamllIER1IHdyb3RlOg0K
PiBkZWJ1Z2ZzX2NyZWF0ZV9kaXIoKSBmdW5jdGlvbiByZXR1cm5zIGFuIGVycm9yIHZhbHVlKFBU
Ul9FUlIpLg0KPiBXZSBuZWVkIHRvIGV2YWx1YXRlIHRoZSByZXR1cm4gdmFsdWUgdXNpbmcgSVNf
RVJSLCByYXRoZXIgdGhhbiANCj4gY2hlY2tpbmcgZm9yIE5VTEwuDQo+DQo+IEZpeGVzOiBkMTMx
M2U3ODk2ZTkgKCJpb21tdS90ZWdyYS1zbW11OiBBZGQgZGVidWdmcyBzdXBwb3J0IikNCj4gU2ln
bmVkLW9mZi1ieTogTWluamllIER1PGR1bWluamllQHZpdm8uY29tPg0KPiAtLS0NCj4gVjQgLT4g
VjU6IGRlYnVnZnMgbmVlZHMgdG8gaGF2ZSBlcnJvciBjaGVja2luZywgc28gdXNlIElTX0VSUigp
IHRvIGVycm9yIGNoZWNrLg0KDQpXaHk/DQoNClsuLi5dDQogICogTk9URTogaXQncyBleHBlY3Rl
ZCB0aGF0IG1vc3QgY2FsbGVycyBzaG91bGQgX2lnbm9yZV8gdGhlIGVycm9ycyByZXR1cm5lZA0K
ICAqIGJ5IHRoaXMgZnVuY3Rpb24uIE90aGVyIGRlYnVnZnMgZnVuY3Rpb25zIGhhbmRsZSB0aGUg
ZmFjdCB0aGF0IHRoZSAiZGVudHJ5Ig0KICAqIHBhc3NlZCB0byB0aGVtIGNvdWxkIGJlIGFuIGVy
cm9yIGFuZCB0aGV5IGRvbid0IGNyYXNoIGluIHRoYXQgY2FzZS4NCiAgKiBEcml2ZXJzIHNob3Vs
ZCBnZW5lcmFsbHkgd29yayBmaW5lIGV2ZW4gaWYgZGVidWdmcyBmYWlscyB0byBpbml0IGFueXdh
eS4NCiAgKi8NCnN0cnVjdCBkZW50cnkgKmRlYnVnZnNfY3JlYXRlX2Rpcihjb25zdCBjaGFyICpu
YW1lLCBzdHJ1Y3QgZGVudHJ5ICpwYXJlbnQpIHsNCiAgICAgICAgIHN0cnVjdCBkZW50cnkgKmRl
bnRyeSA9IHN0YXJ0X2NyZWF0aW5nKG5hbWUsIHBhcmVudCk7DQogICAgICAgICBzdHJ1Y3QgaW5v
ZGUgKmlub2RlOw0KDQogICAgICAgICBpZiAoSVNfRVJSKGRlbnRyeSkpDQogICAgICAgICAgICAg
ICAgIHJldHVybiBkZW50cnk7DQoNClsuLi5dDQoNCkJlc3QgcmVnYXJkcywNCmJhb2x1DQo=
