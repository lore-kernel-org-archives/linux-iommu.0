Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2126.outbound.protection.outlook.com [40.107.215.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3164B6FD3
	for <iommu@lists.linux.dev>; Fri, 14 Jul 2023 08:49:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCiYP77o6IwMxTXcHSdZocZcB1VaMwHKNzOavZ3NlhOnusIyeEz/sbybVFHxFpJFpdshWQXM4dohEeSZULYxequ/CsVtWbP7heJ+oI5m7WYvvuoPD89xe064HhfPnky1+0tUPp/88mmRTzC54qIB1IwBhUSDKsOK5ICEis8S5kUijUT9j1Lqy1sUIFKlhO6mjvb11O7OHDAA0k+bJ/9SpQFWD3jgXdxe1dl9alBA0efn7zhDz6tRyPbXoPau6+x5xDMzpRrDjDGjg8utWe7zR8kSyKlQbPaa2H3hcHOEn5NZoyGyu2L0fCKriTvMP/mHf+tL/1ibmQXqLS3VX0jUCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpU81lzRtFak88xc0AtS4vw+yuQU9DCH5FDMJHYFYR8=;
 b=mIJkEaO+2j6PGGOBRC6dWnSI1EgBuzikmDTrg19rwoszMLVLlkQPM5VWff60+v5QApfl2TT2Bqk3slOAL/dNaQJu76qCV2J9YIeC77xR0ZI1kW4Ji7Shi/ncQEz/F2oq5Bc0u6W1hEP8x8hTNBDHkshMk1Qp962O74xAytyvAblerf6YmTZjmuxH3biaXf7KnfkFFWMYP/y7ca97T5qPeMs5ThAMb/N7C65/VReIoPgisNKs8mqDyb2AqvA6zkUnn6bxGIuEoFkskL701G6zOA4DIRHVNHqM9/ZrfQUhFUbrIAmfNDqiW4roXRNtaX7qdUhD93didZ9ssP3o+uYVSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpU81lzRtFak88xc0AtS4vw+yuQU9DCH5FDMJHYFYR8=;
 b=j4gtNREeuTj4zZSgcD/sEeT0rsejHMCI9dkAHpPMQhCQG2KRAgQYTl+1UM1NvJZ5BA1uqpfaPNjIxPxd6ESrMgAmQ7+t2to79HXbpW6zgbK/UZDJSGfyLNfYjtKRR04HYkgvbKGyAn/6Y+0l8Fn/B3qFedGbEX4HrVXXSXXJK+uwHF4aV0WgeEDBZRMFmWF6dzBGxSKzx+TGq7iiXSAwQCTiDvxXUO/82Lqbjrqxq+CYCL6DLipza2k0YeubWi0F/hg8NaJYYjwqiJoQbzO83Sk/n+1oUc7QKhiPP4s5ntMb5fVYFHCiu8C+/7TqSQ/ySxaOk9x9f8DnQOKqHBAQvQ==
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 KL1PR0601MB4291.apcprd06.prod.outlook.com (2603:1096:820:76::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 08:49:33 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.037; Fri, 14 Jul 2023
 08:49:33 +0000
From: =?utf-8?B?5p2c5pWP5p2w?= <duminjie@vivo.com>
To: Thierry Reding <thierry.reding@gmail.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, Krishna Reddy <vdumpa@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, "open
 list:TEGRA IOMMU DRIVERS" <linux-tegra@vger.kernel.org>, "open list:IOMMU
 SUBSYSTEM" <iommu@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>, Thierry Reding
	<treding@nvidia.com>
Subject:
 =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSCB2NF0gaW9tbXU6IHJlbW92ZSByZWR1?=
 =?utf-8?B?bmRhbnQgcGFyYW1ldGVyIGNoZWNrIGluIHRlZ3JhX3NtbXVfZGVidWdmc19p?=
 =?utf-8?Q?nit()?=
Thread-Topic:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjRdIGlvbW11OiByZW1vdmUgcmVkdW5kYW50IHBh?=
 =?utf-8?B?cmFtZXRlciBjaGVjayBpbiB0ZWdyYV9zbW11X2RlYnVnZnNfaW5pdCgp?=
Thread-Index: AQHZtVulTt9Be4N5d0ejJ/S/NfzgtK+4ky0AgAACj5CAAF1kgIAAAdYA
Date: Fri, 14 Jul 2023 08:49:33 +0000
Message-ID:
 <SG2PR06MB52888605B8B732ABFF78E44DAE34A@SG2PR06MB5288.apcprd06.prod.outlook.com>
References: <20230713072825.10348-1-duminjie@vivo.com>
 <362e4343-dcf1-58fc-7ac9-756c65bb0df6@linux.intel.com>
 <SG2PR06MB5288ED578DB3CE7DA2B25AB5AE34A@SG2PR06MB5288.apcprd06.prod.outlook.com>
 <ZLEKH8ixyRH7IzLK@orome>
In-Reply-To: <ZLEKH8ixyRH7IzLK@orome>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB5288:EE_|KL1PR0601MB4291:EE_
x-ms-office365-filtering-correlation-id: 97318d99-a9f5-41e1-eb44-08db84473ed1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 skvRSyh5sWbUujNZy1KO1sCnt+wEraSnS7t9TmduWeAVczvijAXgv+w7ktWNRHECe7/avCXacjvCSFRvuT4SmYjFmZOZjQXM1+zab2NWsfWp3ngwGAGaXQug3cWWOsk5KZdQ287us4u17mLXmKP1GvUv9HS3kNsn86noMBjhIR7ws/x13v4wbOVm6JWLX5TjXuEiDHD3t7oCejXhR7KgxZEAwanTYYfngMuPJX7ta4FbLEOQ2/I66sSNdSK15o3cOuu9f3VqxxI/4yWG+xuBlUz/MWjREHZhoopTAvGYD4lPl7oCa1ZaYOSYSZyKpAI1H2C0h9rep/14TZ1j9sVKL5gMgwJA2uSAJrssCk+EeJI74vr7rDafwdxLF5bkJsdCPeMFN2s9pGGijKkoB2j6sJpV0gcCyXln14cLlr18++fIsiLUPjkHBmTZ8S3BN/LKQ9QFcMObL+1N5XNVLo/Y4dWuxtDA0ynb2zqo+KKcF6C0Xw65MOH8izDO3sTfm/ocQq0hx0Q6zd4E0M+xoUbB3mr9iRCrgzmnEg0yeUoTArFjpTqyHwjkNDmmAExs00ZREuHLA2mVEgz7FFbzXejV7/dHIVanl/5n6+5vBcOVns3AvUX50B+kOHaCc9rduYX3
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(2906002)(55016003)(38100700002)(122000001)(83380400001)(186003)(9686003)(26005)(6506007)(53546011)(33656002)(966005)(5660300002)(86362001)(52536014)(38070700005)(8936002)(7416002)(224303003)(85182001)(478600001)(54906003)(41300700001)(7696005)(71200400001)(316002)(4326008)(6916009)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NGxQdGJFbFNIdmtwUUpSWU1GMGlVdzIvSXVIV25oQ29jNHA4Z1FPUlR4cDVu?=
 =?utf-8?B?aStYQ3k2N1RvbUlOL2dycmpxVC9ZYXNiVEE1WVlNK04xcFBxWE1ocHVEZkNp?=
 =?utf-8?B?Q050RHVya0pJTHgyVDVObGRROUVzV0RXOFZ5anJ2Q2o1Y1h5cndFckZmNkNt?=
 =?utf-8?B?b0VhVVViTlRHMUd0ODdrWHRnSlZJdnFybVRjemJJYzAvaTlyL004SXdaU3k1?=
 =?utf-8?B?UzRaWHdreFZpUm54N0dsNWhHQklsU0NNb3k4ZVVudytOOFB3Y1Mwem14YTlU?=
 =?utf-8?B?b1h0TjJIOS9oUUFRR0ZHZXJVdklUaDF6TTFJUWlaeCt1djdYSHAwQ095NjB0?=
 =?utf-8?B?TFJkclN4cVdsdlB5aGJrVTd0OWFHZVg3MWRpVUhnUlQ4VEl3SXowNURaY0Rh?=
 =?utf-8?B?WktYUGJWc0J5L1VoTVMwSDFqUGdPeXdKVDVRb1hZYlpJMzI1cnBzazhRNjIw?=
 =?utf-8?B?UWxIaGlmcWI5MWZnNlhRcGE1SVlZeFd1cEN1alBMKzlaVVZQU05PbVdMY1Ft?=
 =?utf-8?B?YXBMYjZZSXhpQURsOWRoYWNTRk42cmxaTm8xL044LzArK0Y2a09EVEtKZWxI?=
 =?utf-8?B?a0J6cjB2RWd1SDVxOXNobjBreTZrc0xPQzFYcGZoY2tGWStjWitKN0FQUDgv?=
 =?utf-8?B?QmpoSUl5QzQyODd1YnR4VFJsR3FGY0JwUEFGOXZtVkxNL3haVVRKd0VHdjNJ?=
 =?utf-8?B?ZndaaFJDMW1WYW81QWgzckszakl3ZHY3S3ZHK1poWWE2WDRHb3RhZjIreUht?=
 =?utf-8?B?a290ZVhlSVVyUTl3Mmd5L2RjOUo2Rk9KNW1FK2syYUd2TmdqcXJSekZKUGVJ?=
 =?utf-8?B?b1AzQ3VDVis2OUVtUVdvcER2MVFQaVNGbVh3Kzh5UkhSUXdkU3MyVkliRk13?=
 =?utf-8?B?Y0JMYzlYVC9vK0FmZmd3Z09CSHBIc2J3dmNOT1RYLy9LaWxFL29iS01WaW5W?=
 =?utf-8?B?QXNnQlBSREcyckVJNUZ4UGNxeUxnazV0eDdDODgrcUZUWFIrV0ZDSHNoRW00?=
 =?utf-8?B?aXcxeEVObU9NSXdzc3Bjajg0WmtPbGNET3ZpMTZFcGdJTFdieVl2emVGOHYx?=
 =?utf-8?B?MjhCWWxkKys4MklrNFlJT2twSVRJRVcyaGZNcXRSOUJxMmcxQTRnZXJDUk9i?=
 =?utf-8?B?ckR6UXBTYmYxYmtaME9OT2ZueitxMEVEcmQrK0I2aDc0UTczTFAzQ0F0RmZM?=
 =?utf-8?B?UjhTOXAycnArVE5OU3hSWmZESW1yTHZVWVhFZE9wU0lzNzE5dDVRQk9yeTE2?=
 =?utf-8?B?eTdTalIvUzFISWRRcVZoZG5RMXBrVDZkdnREQ2ZvNFNRcWlweittUytWL2Nn?=
 =?utf-8?B?UjRUak4rUG9iNUl6YVk0d3UrcXViMnRUNmwvUitldjI0M0FnNzk1RzZCS2h1?=
 =?utf-8?B?L0NWOHAvd291UmFtSG9Wd2dUY1ZhR1R0TUlCSEFrQ3lMcGdMS0hIZ2lPVUdO?=
 =?utf-8?B?enFvVjc4MTRodXVoVDZycHhSSTIvaGNVYjFiTFZTZVBEZ1pYcytoVy9PZS9p?=
 =?utf-8?B?RVkrTlBQK1dWejhKTzhqdXNQMmJRYUpOMFIwb0hXckxhVXByc3RqUHFvVWpK?=
 =?utf-8?B?M2drZlljUmE2aEZMOGdzVzVNWGFLWHR3OTJ2UDlZc0xiZnMvRkQrZUFpbHRo?=
 =?utf-8?B?aG54YURIdG5zSyt1eTBPS1Z4OWJSSFFYU0k1d2FTQ0ZTMXFXQUp2cVlaNzNT?=
 =?utf-8?B?OHlHZWZ1cE0vUGZpN2o3ang4bThxRmdRNU1BV00raXUyM3pnRFlyM0xKZG5z?=
 =?utf-8?B?QUNwRDNyc09oeG8xYWR2TnFEY1dkTzltSURFdkRMdmxYKzY4bThmMWJZaEgx?=
 =?utf-8?B?RERnZ0prQlVzTEl4WlIzc2tNN0p5elVZbjN3Y2ZoeXdyMEpQeGxITkZpWWls?=
 =?utf-8?B?WWhXalN2L2w4Z1RpOWUwZ0txZGxUNnB2OGtNNjJhUk56azNkd3VHdGVNd0gy?=
 =?utf-8?B?OHFHazI5TzZOK2tGWHVWWTRMMDVtclFzSFl4ZXk3MmlQaHBoVUUyZkkxT2Nj?=
 =?utf-8?B?ellITmFXWTRISm1Wams4MEVrSUxaZVY2WkpMdGdCemFLV0x5UlJJTzgySG1T?=
 =?utf-8?B?UnlHWEF2NGZDOUQ4cnBicUxhNUkybFdYWGt4NUVQeHVPejlVaVJNR3VUOGRW?=
 =?utf-8?Q?qKJjB6KN43iAyG+cxRK5//u4M?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 97318d99-a9f5-41e1-eb44-08db84473ed1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 08:49:33.4098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cbYRhIK36Le2XdohnhJoZqv9kGnmoHGcwAiPFsdRaj+qwNkclxToJnBxMggms3sOi1W/eo7eCbilr3hVxhF4jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4291

SGkgVGhpZXJyeSENCg0KSSBtaXN1bmRlcnN0b29kIHdoYXQgQmFvbHUgbWVhbnQsIHNvcnJ5Lg0K
SSB3aWxsIHN1Ym1pdCBhIG5ldyBwYXRjaC4NClRoYW5rcyENCg0KcmVnYXJkcywNCk1pbmppZQ0K
DQotLS0tLemCruS7tuWOn+S7ti0tLS0tDQrlj5Hku7bkuro6IFRoaWVycnkgUmVkaW5nIDx0aGll
cnJ5LnJlZGluZ0BnbWFpbC5jb20+IA0K5Y+R6YCB5pe26Ze0OiAyMDIz5bm0N+aciDE05pelIDE2
OjQxDQrmlLbku7bkuro6IOadnOaVj+adsCA8ZHVtaW5qaWVAdml2by5jb20+DQrmioTpgIE6IEJh
b2x1IEx1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+OyBLcmlzaG5hIFJlZGR5IDx2ZHVtcGFA
bnZpZGlhLmNvbT47IEpvZXJnIFJvZWRlbCA8am9yb0A4Ynl0ZXMub3JnPjsgV2lsbCBEZWFjb24g
PHdpbGxAa2VybmVsLm9yZz47IFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFybS5jb20+OyBK
b25hdGhhbiBIdW50ZXIgPGpvbmF0aGFuaEBudmlkaWEuY29tPjsgb3BlbiBsaXN0OlRFR1JBIElP
TU1VIERSSVZFUlMgPGxpbnV4LXRlZ3JhQHZnZXIua2VybmVsLm9yZz47IG9wZW4gbGlzdDpJT01N
VSBTVUJTWVNURU0gPGlvbW11QGxpc3RzLmxpbnV4LmRldj47IG9wZW4gbGlzdCA8bGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZz47IG9wZW5zb3VyY2Uua2VybmVsIDxvcGVuc291cmNlLmtlcm5l
bEB2aXZvLmNvbT47IFRoaWVycnkgUmVkaW5nIDx0cmVkaW5nQG52aWRpYS5jb20+DQrkuLvpopg6
IFJlOiDlm57lpI06IFtQQVRDSCB2NF0gaW9tbXU6IHJlbW92ZSByZWR1bmRhbnQgcGFyYW1ldGVy
IGNoZWNrIGluIHRlZ3JhX3NtbXVfZGVidWdmc19pbml0KCkNCg0KT24gRnJpLCBKdWwgMTQsIDIw
MjMgYXQgMDM6MjE6NDdBTSArMDAwMCwg5p2c5pWP5p2wIHdyb3RlOg0KPiBIaSBCYW9sdSENCj4g
DQo+IEl0IHNlZW1zIHRoYXQgJ3NtbXUtPmRlYnVnZnMnIGNoZWNrIGlzIHN0aWxsIG5lZWRlZC4N
Cj4gVGhlbiBJIHdpbGwgbW9kaWZ5IHRoZSBwYXRjaC4NCj4gVGhhbmtzIQ0KPiANCj4gcmVnYXJk
cywNCj4gTWluamllDQoNCkRvbid0IHRvcC1wb3N0LCBwbGVhc2UuIFNlZSBEb2N1bWVudGF0aW9u
L3Byb2Nlc3MvMi5Qcm9jZXNzLnJzdCBhbmQgRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N1Ym1pdHRp
bmctcGF0Y2hlcy5yc3QuDQoNCkFsc28sIGhvdyBkaWQgeW91IGNvbWUgdG8gdGhlIGFib3ZlIGNv
bmNsdXNpb24/IEJhb2x1IHNhaWQgdGhhdCBHcmVnIGtlZXBzIHJlbWluZGluZyBwZW9wbGUgdGhh
dCB3ZSBzaG91bGRuJ3QgZG8gZXJyb3IgaGFuZGxpbmcgZm9yIGRlYnVnZnMgYW5kIGdhdmUgYSBS
ZXZpZXdlZC1ieTosIHNvIHdoeSB0aGUgMTgwPw0KDQpUaGllcnJ5DQoNCj4gLS0tLS3pgq7ku7bl
jp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IEJhb2x1IEx1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5j
b20+DQo+IOWPkemAgeaXtumXtDogMjAyM+W5tDfmnIgxNOaXpSAxMDo1OA0KPiDmlLbku7bkuro6
IOadnOaVj+adsCA8ZHVtaW5qaWVAdml2by5jb20+OyBUaGllcnJ5IFJlZGluZyANCj4gPHRoaWVy
cnkucmVkaW5nQGdtYWlsLmNvbT47IEtyaXNobmEgUmVkZHkgPHZkdW1wYUBudmlkaWEuY29tPjsg
Sm9lcmcgDQo+IFJvZWRlbCA8am9yb0A4Ynl0ZXMub3JnPjsgV2lsbCBEZWFjb24gPHdpbGxAa2Vy
bmVsLm9yZz47IFJvYmluIE11cnBoeSANCj4gPHJvYmluLm11cnBoeUBhcm0uY29tPjsgSm9uYXRo
YW4gSHVudGVyIDxqb25hdGhhbmhAbnZpZGlhLmNvbT47IG9wZW4gDQo+IGxpc3Q6VEVHUkEgSU9N
TVUgRFJJVkVSUyA8bGludXgtdGVncmFAdmdlci5rZXJuZWwub3JnPjsgb3BlbiANCj4gbGlzdDpJ
T01NVSBTVUJTWVNURU0gPGlvbW11QGxpc3RzLmxpbnV4LmRldj47IG9wZW4gbGlzdCANCj4gPGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQo+IOaKhOmAgTogYmFvbHUubHVAbGludXguaW50
ZWwuY29tOyBvcGVuc291cmNlLmtlcm5lbCANCj4gPG9wZW5zb3VyY2Uua2VybmVsQHZpdm8uY29t
PjsgVGhpZXJyeSBSZWRpbmcgPHRyZWRpbmdAbnZpZGlhLmNvbT4NCj4g5Li76aKYOiBSZTogW1BB
VENIIHY0XSBpb21tdTogcmVtb3ZlIHJlZHVuZGFudCBwYXJhbWV0ZXIgY2hlY2sgaW4gDQo+IHRl
Z3JhX3NtbXVfZGVidWdmc19pbml0KCkNCj4gDQo+IFtTb21lIHBlb3BsZSB3aG8gcmVjZWl2ZWQg
dGhpcyBtZXNzYWdlIGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIA0KPiBiYW9sdS5sdUBsaW51
eC5pbnRlbC5jb20uIExlYXJuIHdoeSB0aGlzIGlzIGltcG9ydGFudCBhdCANCj4gaHR0cHM6Ly9h
a2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4gDQo+IE9uIDIwMjMvNy8x
MyAxNToyOCwgTWluamllIER1IHdyb3RlOg0KPiA+IGRlYnVnZnNfY3JlYXRlX2ZpbGUoKSB3aWxs
IHJldHVybiBlYXJseSBpZiBzbW11LT5kZWJ1Z2ZzIGlzIGFuIGVycm9yIA0KPiA+IHBvaW50ZXIs
IHNvIGFuIGV4dHJhIGVycm9yIGNoZWNrIGlzIG5vdCBuZWVkZWQuDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBNaW5qaWUgRHU8ZHVtaW5qaWVAdml2by5jb20+DQo+ID4gQWNrZWQtYnk6IFRoaWVy
cnkgUmVkaW5nPHRyZWRpbmdAbnZpZGlhLmNvbT4NCj4gDQo+IEdyZWcga2VlcHMgcmVtaW5kaW5n
IHRoYXQgbm8gZXJyb3IgYnJhbmNoIGZvciBkZWJ1Z2ZzLCBzbw0KPiANCj4gUmV2aWV3ZWQtYnk6
IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+DQo+IA0KPiBCZXN0IHJlZ2FyZHMs
DQo+IGJhb2x1DQo=
