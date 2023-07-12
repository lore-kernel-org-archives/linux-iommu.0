Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2132.outbound.protection.outlook.com [40.107.255.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A61385
	for <iommu@lists.linux.dev>; Wed, 12 Jul 2023 12:37:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJpvLsJECe+tSE4P2sCpGewBfTLxsYwgX7GaewbInlMWCiCG0m42YedOq/dJwu2E/Fu8/pQzK0oWDxzZLEgB6Rao23T97hlMQqoDIPCsWk6mTH4jY/1LwSB0HgsKbAYTjhKD1uY2b59W6htBeWWal8XQLgbbe5F1exJbINvBxpO00l5w/4FwY5Lm+hGrw/YXRFJSZ//uKZsPnO9ashoSK4DejkEDjK5z6OTbhRyas4y8nPYpjJDHnmkMIRLTJznKtI2J8D38Vs/3DZE/i1mMFy68S+xuWaD0sbWo/zdX3Yl0luH/77Y0Ft+A8TqUHwu0ccQvT0Fy8uShYXbv+DCv+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8FEtRoOOsha1mA5Ke+nl/cs2uEyQdB8VC5T42qQYAs=;
 b=mSWglxCm/jqTjj0wPofIg2gr+pQnzcbPPTf8WHXHYOendCR9u/l/nmOEK5bp/3gzaaEbZ7WD6JSQV00efbWedPBR9DD4j0NSCvaw6ICVNBYRg/Ejbyc4nBogD9WnQc/3QAx9p1FsRoGHONMk9tdd/lmWsciQlgqvlNFmC9CphHKsKL6FgH99tOPbTkiZd3maUPOFsFHxPZvb0QOpZox5dX9U7B639DxyAdl4g9DHOqcxQ4+ZQpCbqxD6rSS1MQ/LG4BUOxC2meYQbkkHwhrOx2GYub+bpbxvrGe2ASawbCb1Tq2khVZ/s7Ktih1GVMzXU46MPSRtLYEPbfpm573vMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8FEtRoOOsha1mA5Ke+nl/cs2uEyQdB8VC5T42qQYAs=;
 b=B5HhL2RZo+EVlilRweaOhQJ1fFJlL794fQWtJRQPEwbjV3lJoQcbT7WQCY+WwtWIS6aKeKIKShok388dtMYeAEDzPVOpJtd5kz1aHKz3rf7Qccf5AJoZVIaJs6Uh60PJVQ15YZ+M816ASde5Onj4I4RusNa8td6+GuEG90MIOsHEAGSxWgkH8nSEtGD+EaokCnoo1AKGn+6XnUZV3PmUzrPOs5AQhG1TY/vRO7tWIspvOI1fn+xl7WeIs1uxcG6BgUshqA/jJCSp/a4Lf7EEI+qmvjoaHW3/uyMllZcp+DKaJ2DRdx9ANPHKIvAjcGzjzVgoqB3eZspEVdOX7FWH/g==
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 SEYPR06MB6359.apcprd06.prod.outlook.com (2603:1096:101:140::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 12:37:03 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 12:37:03 +0000
From: =?gb2312?B?tsXD9L3c?= <duminjie@vivo.com>
To: Thierry Reding <thierry.reding@gmail.com>
CC: Krishna Reddy <vdumpa@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Jonathan
 Hunter <jonathanh@nvidia.com>, "open list:TEGRA IOMMU DRIVERS"
	<linux-tegra@vger.kernel.org>, "open list:IOMMU SUBSYSTEM"
	<iommu@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIIHYxXSBpb21tdTogZml4IHBhcmFtZXRlciBjaGVjayBp?=
 =?gb2312?B?biB0ZWdyYV9zbW11X2RlYnVnZnNfaW5pdCgp?=
Thread-Topic: [PATCH v1] iommu: fix parameter check in
 tegra_smmu_debugfs_init()
Thread-Index: AQHZtLR5URJhMQtAFEyK5+syqQvBVq+2DZWAgAAC6vA=
Date: Wed, 12 Jul 2023 12:37:02 +0000
Message-ID:
 <SG2PR06MB52889E70309210CD49400A64AE36A@SG2PR06MB5288.apcprd06.prod.outlook.com>
References: <20230712113145.12888-1-duminjie@vivo.com>
 <ZK6a-f2Se3HWjU7D@orome>
In-Reply-To: <ZK6a-f2Se3HWjU7D@orome>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB5288:EE_|SEYPR06MB6359:EE_
x-ms-office365-filtering-correlation-id: 0593a82b-eb2d-4802-eec4-08db82d4b1c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 t/eodogQlXhIkXrV1NAE45j3nM7XnRTYzcK09eec3+WlKkBkhbMDflocVvP/91/ixKp2psSvGksMowyL3bS+OYKAlgzqzoy4O3fiofVugOTl5fKjSizDT6lDSN+QhPOSnMuEffFdrKbA4u3XcxDvBS+O4Azbj4kAQkEquziGAcvquafIWJoOYmO9Lg8gg4mi1TvFyG4xHabNjEKDwbmuomr90uazPFM7H8rNGWRXdQPlGB6sV0WCpzn+bdYvjQDhbv/Z1gtBf1YBjjhiTlPrNX2NtfRvDVcKuHrGG7tMD+aOlTSDKChymPzf8+6I8gzj7qL0jd8lB0jnDr/2x4bV0XUyCLku+7jM7ulepZCEyNTmW97ifI9KhgGbs7UgPvroa50OySJJlHZ9IXbNnxZPoWlPzlHGaH9q5SwltziGKQtYXIiOfGFo9sFY5qABQvSfupEdhg1YkuZhgSPVrmJI1wfshSfrlCj6wdPOye0769hMqEnRJzmjCh79+i2cT/28/xEIkcKSXQ3L6F39B8n6oHVuaFC9MrgsP+mccffoD34pVbk/5CXKwvmH+eoRDZkDbvj9pe3dc0lZQLLcxckQd651gKtEwSzspLTre9zdlng6O98l4gAbQDhqm0QM+oLO
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199021)(7696005)(9686003)(71200400001)(26005)(33656002)(6506007)(224303003)(85182001)(186003)(83380400001)(122000001)(38070700005)(86362001)(38100700002)(107886003)(55016003)(5660300002)(76116006)(52536014)(8936002)(4326008)(64756008)(66446008)(66556008)(6916009)(66476007)(316002)(41300700001)(66946007)(2906002)(478600001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?NzJNbFVDZkhrd3drQVBMRi9Xb1dMeHhESFFhS1RvNTVBRkJKYmVYTWJzaWNG?=
 =?gb2312?B?NE45aGhXWTZsSHQ1bjNWQXF2L0lPUFNabzNCYmRod0w3d1NocWxRSUo0WmNT?=
 =?gb2312?B?WEFmdVFuQjNEelJOcnYxb3V3U3VlVlp4T3VZcllwM0x0VHhuRWNPcTRVOGgx?=
 =?gb2312?B?ams3RG1BTVdwSXRlSy9TbDIxWUZ5cGhvd1RaKzBRNmNTRXpLdDZZZVdmQmZP?=
 =?gb2312?B?T09MdUEyaTZGTHRYQ3lENnNKZTljTnY4MDkzd2lxTWJVaW5QWnZNMFZrTDA2?=
 =?gb2312?B?c20zTklPS0t6V0plcVB0aHZEZmJJQ01ZS2xBMVMzUDFmTVg1Uk1PYlMvcXlM?=
 =?gb2312?B?WXE5SDNzQ1o5M1BUWmovaS9qbjJmVFVWeFp2WitMZlFTYjB6V0JaUEZhNW8z?=
 =?gb2312?B?Yzc3eHoxalpocm9MRWVQMy9PMmRvYjhFT0tHUUpKejg1bjRxcFFDa2trbFRJ?=
 =?gb2312?B?UVEyWDVzbkp3aUsxN2ZwQjNrMGtPSWtVaFNrbHcxTkRkeS8zbDVsZnpyZFha?=
 =?gb2312?B?aFhJR25GMVBrMkVnZGtGRHErZUlncEprYkdEVFoveEZOZ21nTVVIRHpKOENa?=
 =?gb2312?B?c0RINCtSY3FLRWROSkNTU2VMeE4vR2NJRFEwckZ2ZHd5WDJzSmlSVCtYTzVZ?=
 =?gb2312?B?UGtxRmY1M0JRbW8ySE1jZCtnZVNCMm5kR29iOExpMGJQWmZYU2NKWFlOWmlY?=
 =?gb2312?B?b3dYSDZwQUVNaTFtK2VQSEZlTjVtZmlMdmZjZzZCek9aT3JyU1o2Ums5QTNw?=
 =?gb2312?B?Q2ZIUGxYTDJzckR3bWtJOHhpczN3ZmxMUWE0UmtUTGI1Ylg5NjJaY0JQNlAz?=
 =?gb2312?B?bXlqZWFaYlFsS0xqMXBsV2ZuaEZQeURzRCszN2Z1dFlac3Y3U1hSTVhqUUNF?=
 =?gb2312?B?ZEgxTFJzejdLekdBbjVDMk1mL3kxRjF0SElzRDlsWllIdEVPNVFqb2lPakFE?=
 =?gb2312?B?ZWU4YnBzaENYNW9mZ0ZBZ3Y5V0VWV2tCc0NqNEppYzlSampPSGo1K290M3Q3?=
 =?gb2312?B?cGRlVjQ1T1ljSjRkbmgrdnc5RHM4VDNIZlFMRkJoVWhQeEgrc016WWw3NlpM?=
 =?gb2312?B?Z3ExNHhza3pWSkhZMGh6Sk1wdVNzV1BWcW1xamJIUmFqZS9FWmQwc0MydVZ1?=
 =?gb2312?B?VXRqek5IYzhXZjJHLzRvdGxJeFZ4R3VUU3IvTDUrNDRiczRLR0QwUFdzSWls?=
 =?gb2312?B?NElaMXNlaHo5empXMUlKdmZSaE5jL0NGTzVVekpqS2wvUmp1ODltR08xWHlD?=
 =?gb2312?B?b3FaQnJzU000OEtMa0pnRlhtVVZnNUZhbWJ0eVYwVGJ6Q1NpTHRtUnhkS1N0?=
 =?gb2312?B?U0NJeHJ4S0xJTVowZ1FVak9haXRkeXgwS0s3UVVZbEhHclpib0U0Tjh4dWFs?=
 =?gb2312?B?M2lhNThYNVZOWlZqekcveVZCTnZFZTNPeDY2ZzFac0Q2bTdOZDU2TnRpNWp4?=
 =?gb2312?B?SHFKUUxCTU12SXBvL2JWVDlGSXh6ekRXeGh4Qkc2U1RIU29VTS93MTJCQURM?=
 =?gb2312?B?L1VldHdHQWo0ZytIS1BGZjBMcHVJTFVLWXd5NXA0bFNLOTlpbHpzMnJRR2pR?=
 =?gb2312?B?K2hlcHp4cVJXaXVqT0Znb2RpKzV1N3lob1gxb0pNcFpVZi90ZCtINkUxMW1N?=
 =?gb2312?B?WGdHL0pRUVZINEZrR3N4bjZpbzhTNCtQN1J6RHNRM2EvcExUSEFDOCtYc2lv?=
 =?gb2312?B?cWthWjBSUVhieWx4bWYzSndqdnhNM2RBUCt1d0c5WnlDY3RsQ0tRSC9ycDYy?=
 =?gb2312?B?bFVIRkM3UlMwNWVEanRJVjlQekFQWmQxRmkySWJJUUt4ZzZ5QnU3N2JZMW1k?=
 =?gb2312?B?d2hYY2JYK2RlVXhKVVFTQ3h5dE4rZUs4U1pxRVE1M2FWMVlqY3FSL1A0YkJH?=
 =?gb2312?B?cnpZYjNpa0FoWCthZzhvSXFsZ2hESFdWUVV3UmlxNDdJVkRhemF4VkVHeVJq?=
 =?gb2312?B?cEdCMWZkWjFnbStMZHFaZGp1bysyVFdCQlpPa2ZQVitZdXMxbkVDRTN5YWpE?=
 =?gb2312?B?ZkNSOXBCQkpITUR1YmFUZTVqdGxQVjlpbE95MlY2N0JyQUptYUo2OHl3SFFQ?=
 =?gb2312?B?RHJRQVdOZVZuYTRXV1BUcFlEWjdYdXdxVnB5eWdjeGlaSW00VlBWcUVPUzJI?=
 =?gb2312?Q?KbRtMSrd8wfIL2wZn4PmdxQ6C?=
Content-Type: text/plain; charset="gb2312"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0593a82b-eb2d-4802-eec4-08db82d4b1c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 12:37:02.9629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TWNL5rR34hl/KboH3w6yJkbWjCHO4aGGItrVdB7fyvAOCuyfg+oAC/yJ51XEP9N5En4aHJmYjvtgUu9MjjEjcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6359

SGkgVGhpZXJyeSENCg0KPkkgdGhpbmsgd2UgY2FuIGp1c3QgZHJvcCB0aGUgZXJyb3IgY2hlY2sg
YWx0b2dldGhlciBzaW5jZQ0KPmRlYnVnZnNfY3JlYXRlX2ZpbGUoKSB3aWxsIHNpbXBseSByZXR1
cm4gZWFybHkgaWYgc21tdS0+ZGVidWdmcyBpcyBhbiBlcnJvciBwb2ludGVyLg0KDQpTbyBkbyB5
b3UgbWVhbiBtYXliZSBkZWxldGUgdGhlIHNtbXUtPmRlYnVnZnMgY2hlY2sgaXMgYmV0dGVyPw0K
TWF5YmUgSSBjYW4gcmVzdWJtaXQgYSBuZXcgcGF0Y2guDQoNCg0KDQpSZWdhcmRzLA0KbWluamll
DQoNCi0tLS0t08q8/tStvP4tLS0tLQ0Kt6K8/sjLOiBUaGllcnJ5IFJlZGluZyA8dGhpZXJyeS5y
ZWRpbmdAZ21haWwuY29tPiANCreiy83KsbzkOiAyMDIzxOo31MIxMsjVIDIwOjIyDQrK1bz+yMs6
ILbFw/S93CA8ZHVtaW5qaWVAdml2by5jb20+DQqzrcvNOiBLcmlzaG5hIFJlZGR5IDx2ZHVtcGFA
bnZpZGlhLmNvbT47IEpvZXJnIFJvZWRlbCA8am9yb0A4Ynl0ZXMub3JnPjsgV2lsbCBEZWFjb24g
PHdpbGxAa2VybmVsLm9yZz47IFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFybS5jb20+OyBK
b25hdGhhbiBIdW50ZXIgPGpvbmF0aGFuaEBudmlkaWEuY29tPjsgb3BlbiBsaXN0OlRFR1JBIElP
TU1VIERSSVZFUlMgPGxpbnV4LXRlZ3JhQHZnZXIua2VybmVsLm9yZz47IG9wZW4gbGlzdDpJT01N
VSBTVUJTWVNURU0gPGlvbW11QGxpc3RzLmxpbnV4LmRldj47IG9wZW4gbGlzdCA8bGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZz47IG9wZW5zb3VyY2Uua2VybmVsIDxvcGVuc291cmNlLmtlcm5l
bEB2aXZvLmNvbT4NCtb3zOI6IFJlOiBbUEFUQ0ggdjFdIGlvbW11OiBmaXggcGFyYW1ldGVyIGNo
ZWNrIGluIHRlZ3JhX3NtbXVfZGVidWdmc19pbml0KCkNCg0KT24gV2VkLCBKdWwgMTIsIDIwMjMg
YXQgMDc6MzE6NDVQTSArMDgwMCwgTWluamllIER1IHdyb3RlOg0KPiBNYWtlIElTX0VSUigpIGp1
ZGdlIHRoZSBkZWJ1Z2ZzX2NyZWF0ZV9kaXIoKSBmdW5jdGlvbiByZXR1cm4gaW4gDQo+IHRlZ3Jh
X3NtbXVfZGVidWdmc19pbml0KCkNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1pbmppZSBEdSA8ZHVt
aW5qaWVAdml2by5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9pb21tdS90ZWdyYS1zbW11LmMgfCAy
ICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L3RlZ3JhLXNtbXUuYyBiL2RyaXZlcnMvaW9t
bXUvdGVncmEtc21tdS5jIA0KPiBpbmRleCAxY2JmMDYzY2MuLjg0MWUxNGNjZSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9pb21tdS90ZWdyYS1zbW11LmMNCj4gKysrIGIvZHJpdmVycy9pb21tdS90
ZWdyYS1zbW11LmMNCj4gQEAgLTEwNTYsNyArMTA1Niw3IEBAIERFRklORV9TSE9XX0FUVFJJQlVU
RSh0ZWdyYV9zbW11X2NsaWVudHMpOw0KPiAgc3RhdGljIHZvaWQgdGVncmFfc21tdV9kZWJ1Z2Zz
X2luaXQoc3RydWN0IHRlZ3JhX3NtbXUgKnNtbXUpICB7DQo+ICAJc21tdS0+ZGVidWdmcyA9IGRl
YnVnZnNfY3JlYXRlX2Rpcigic21tdSIsIE5VTEwpOw0KPiAtCWlmICghc21tdS0+ZGVidWdmcykN
Cj4gKwlpZiAoSVNfRVJSKHNtbXUtPmRlYnVnZnMpKQ0KPiAgCQlyZXR1cm47DQoNCkkgdGhpbmsg
d2UgY2FuIGp1c3QgZHJvcCB0aGUgZXJyb3IgY2hlY2sgYWx0b2dldGhlciBzaW5jZQ0KZGVidWdm
c19jcmVhdGVfZmlsZSgpIHdpbGwgc2ltcGx5IHJldHVybiBlYXJseSBpZiBzbW11LT5kZWJ1Z2Zz
IGlzIGFuIGVycm9yIHBvaW50ZXIuDQoNClRoaWVycnkNCg==
