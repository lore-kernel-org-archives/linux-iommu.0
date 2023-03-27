Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5389D36C
	for <iommu@lists.linux.dev>; Mon, 27 Mar 2023 01:10:56 +0000 (UTC)
X-UUID: 18ebc428cc3a11edb6b9f13eb10bd0fe-20230327
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=yAgR6WSr2C+bGAWOyY/nMNgmbXJu1ZIKd3cwusu6Lmo=;
	b=i5xBE3mfQ0GyyYmqerkwIqbul6SSVOxb2B75jeyh3fWqJ8ULXJXOJ6MRBQ45GiFy7uJl9d8X0cLfYFnp7hTZtPAY2Fk78md8kH8etTjgVXyXjJoMNb9nGinZbArJ/ru3+J4L8/ISGtrvF7q+gr5KefVGIQHWce+yIzKcB+RtDBE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:c87246a3-c0f2-4947-8f54-7c7807b28094,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:059cf9f6-ddba-41c3-91d9-10eeade8eac7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 18ebc428cc3a11edb6b9f13eb10bd0fe-20230327
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1255555664; Mon, 27 Mar 2023 08:55:41 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 27 Mar 2023 08:55:40 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 27 Mar 2023 08:55:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=En/Zl35bEIFOb2Jg9yTdRB4jxzTjJjqq1Nnf1aGTT7UTB2hy1mKMrWRTNF/39FoSFMsOIeRn8yNZlMeHXklr7pXO1QrPg/lpBz65vHQ1w9m/y8WWelRS4t1CQBToXrPSEb3sS4c1OLhTOOCyzTCGDFZxQ6p6ypJNChZXhwIyAS5PeAIH90YUa50JwRPGXwr33UHANJjgAyitSAFRDeRfEVqCvFnLyQbjOCGGLABcN1rgZ4eS5hb1uH6pa9uFCIdTSgcGalviviSLFatBw85MJ5mG64wMS5sLBHI4jP+SiUS5RniZk2KhycS6S5wR5vL4B80/i/KLLKAk82GcMxvUwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAgR6WSr2C+bGAWOyY/nMNgmbXJu1ZIKd3cwusu6Lmo=;
 b=S1ciU/n/scl7m86eXc4p81ZrEwwNQMG5bn19Rq8jDf/atVImK5WFDjG5w9j3yyA6BduEEo5cCPF3n2CFElRXvGbZNMYVpvO85GmS1+/KDUxVzKHKHv3Q/h6ed2TZ3rfHquQC7IOlNcblH/8LBAUc9xrzn7dl80XNbQ7YJQ4Ovrg7v13GXOoitCAaGP5oYguOwIr56KzzzcvTDaaSxjrA8ttIgdK7IEsSRmXEghQ2VKNdVbOnzYNrUHGpnVslVvsIYTA0Dv8cLz5puVOTrag4G4D57jrTN+2qXmxgs9ZnQPLtoUhZAjqY71C7l1wJAeqq9U8YLR9B79h6eSC73g1J0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAgR6WSr2C+bGAWOyY/nMNgmbXJu1ZIKd3cwusu6Lmo=;
 b=oUi8HWPhcDHYgaZXNclpLS15TG2gTW7tA449z9+GNOqtIU9r8DADhfuzC7nLzuqO0MZKsCTfSRXqiYerrc398ttM8a5qWGBoytORdEqs5P8PHdHIU5nHAw6QmHYVOD60byvJ0Ux3b8miCfacsM2WliTfT1whZXqrlgE1u0mMsJs=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 PSAPR03MB5606.apcprd03.prod.outlook.com (2603:1096:301:4f::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.41; Mon, 27 Mar 2023 00:55:38 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4298:a8e4:7328:6bb1]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4298:a8e4:7328:6bb1%5]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 00:55:38 +0000
From: =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To: "error27@gmail.com" <error27@gmail.com>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>, =?utf-8?B?Q2hlbmdjaSBYdSAo6K645om/6LWQKQ==?=
	<Chengci.Xu@mediatek.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "will@kernel.org"
	<will@kernel.org>
Subject: Re: [PATCH] iommu/mediatek: fix a reversed test in probe
Thread-Topic: [PATCH] iommu/mediatek: fix a reversed test in probe
Thread-Index: AQHZXwoplcayfI/YTE2M6oQRTxiFwK8Nz5uA
Date: Mon, 27 Mar 2023 00:55:38 +0000
Message-ID: <997d75b868ea71e7c3407d974b89f2c26a5e03c0.camel@mediatek.com>
References: <88c83ce7-5d1a-44a8-b9bf-0d01cfea24db@kili.mountain>
In-Reply-To: <88c83ce7-5d1a-44a8-b9bf-0d01cfea24db@kili.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|PSAPR03MB5606:EE_
x-ms-office365-filtering-correlation-id: e410c3d5-d7f7-4ba7-7d3f-08db2e5dfb24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3qV8sDRmOuWG0ofur1Fu37EsgS2RbALfynTqetakpkw6uaKrzY3ZCa7qL/RKnAGVA0DJCKUkJBkTIJil29Yaz5oNN/d85+/FxYUHnHVzbkvX2K7lu/CEBmSQtn9+UpfCZdORTUmiXdWdX7uo7kRb/OFDsyT0+fu/mUEFXX6001O9hnT+XqGxtPxLBb8K/8GEQ9Qgh2HKmszKI8l2zmYpH9j7z2fY03hYalZyWlBggRMJRKKl9MJWQcirzSZ9d0YFI14Ye6nI+A3ccXmNOX92vEnWvQnr/HkANkfb8P+xQto948xBg+4DtHf388SojcvFmT4o3C7/Krc/dk6nyhCURLTJkBuLohtBcHHl93X7xFcQSMgeQWY9+jBjxyUwDywfux/qEDgFh1p/GyAf66MxMtRT1rCJ1JQ8TRLI6TcquT5sVcjmM2qoJaeV8sn6jUUT0AAFJq1sQdxMO4iqWxLehqUj4aMjVZiR/0CghGO0PA+5Z6mxXn+GStUtS26lB/7DluC6AD4hDpr4ByIBAezq+D5K82+J5LussF9Wbdz/yWU+BC/gz8V47Z0dc4C9TdOzH23725m7Mfh+b+nrf9bRpH8iS8prSl1pv2qKqhIrFTvj6Xq+hGiOPV98wwZpwaOJVl8dIQds8sVvL6wA+0VHPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(366004)(376002)(39850400004)(451199021)(38070700005)(83380400001)(4326008)(6916009)(8676002)(66446008)(64756008)(66946007)(76116006)(316002)(66556008)(66476007)(71200400001)(54906003)(478600001)(122000001)(8936002)(5660300002)(86362001)(2906002)(4744005)(41300700001)(38100700002)(6506007)(26005)(6512007)(2616005)(186003)(85182001)(36756003)(6486002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVkrVXNMUTAxaDhYRTJsRE1hQUQyekhRTmUxaDdRdEZuNzFSQnVqekJFWFZy?=
 =?utf-8?B?WnRKVDZaWmNnaUtIL25RcU1uSW9RcTZIRFZkTVpGZ3hVSCtZUkk2aGtrVjNM?=
 =?utf-8?B?OUt1WTVGYkZacExWNTFmMERZMVlSVU8wN3A1WWllVDIxNFMvRTVFK1VYVVk4?=
 =?utf-8?B?bGIrZ0lPazVTVnZTTWUyblkzaHpXWkplVGh1bUppdEJRb1U1cVNqQ1BBbmc1?=
 =?utf-8?B?NlFlaklmSnlaZEFtK2ppU09VL0VZU1E4SjZ0SjBHUGp1Uk44RHdlMVFCdHI3?=
 =?utf-8?B?OGlVMXJzNmpDNk1tYjdIRzFRZEx4NWNlOVJZenRTclJMSW4vQS9QZUFtRVlx?=
 =?utf-8?B?K0VOci8xOUVhbWlWQTZMN3NqTnNKSks3MEJVSUVxL0o4bG5NSFE0REIydTVJ?=
 =?utf-8?B?cFVLRlN5NEszWmRyVk1jRjZIWEwyU0N3QkxaUlNtRENpRllrYjh2M0xGT050?=
 =?utf-8?B?dmtjQUE3eFZIeExVMWY3aysybnNwK2Y5TjRPa0hyMDhGdVJyaFpQSnBONC9U?=
 =?utf-8?B?N2ZrcTRXUDBlTUF6RUM0dkU0Z2ozaDg0ZFJZa1l6RCttMUtzNWZDbVBDZ3ho?=
 =?utf-8?B?d3JLU0x0V3daV0ZXekdFdC9CTk4xMENyYnptWGNIc2NYRGFHTnhmcEFYR2pL?=
 =?utf-8?B?cXZCakY3d3FtTGRKZHJwTVM2K0lHMG5PRlhXL2FmT1VsbWZ1ZTVZNE50MG5v?=
 =?utf-8?B?U2Z5VmVyTExFYkN6TVo4aE9XY1RrNEtSb1JzYzFCWEtOR1FmMExCTWJXS3Jy?=
 =?utf-8?B?Sm5zaEM3bSt2OFlJZ0o5TWVwWStxOGVzSEIxVGVHMmNvZHgzeG5QWmJWT3Rw?=
 =?utf-8?B?TjRreVRGOEc4RDlONVpReG1tSHFoOThRYnRteVdGS0xMZkttanhiR01XUjhP?=
 =?utf-8?B?UXhPaG9RMmQ3N3BYNGpjUjkyL0tDOElmUm5wdW41akltZ3lsbjcwdGhqLys5?=
 =?utf-8?B?TjZla2ZDc254MEFSdWFoN0lDOU54K1R0ZG1ycy8rVm1jdldROW1jdDIyTE1u?=
 =?utf-8?B?WXhnNURiMVBvQ0ZDTCt6OEZPa2U4VlNSZVBOY05zTXQwNDdsalVJb1Y1Y05p?=
 =?utf-8?B?UFdtdFQrUGV2VkZVMkM4S3ozdE9XSmpYMGt0cXBjOXhSVkh6MWQrOXlHenM0?=
 =?utf-8?B?aVFLeHc1V3NkVko1UXZQUFhYTWVBUEhnZUJ4bTNBRUYvSnJIUTkwN0tHd3NB?=
 =?utf-8?B?R3c4bkVPMGpnWURQbW5BZ2RsZEk3RVdWMzM3eXp2elM1TDhqdmQ5cHM3RUdI?=
 =?utf-8?B?dStXYjVUNmFnUXlhdlRzekJ0Z3o1SHZ5TFBhZXFuNEd0SnZ2cEJ5RXBWejFT?=
 =?utf-8?B?VTVGdW1xbGx0OTVuVWZ1T3ZjdFpGOGN5SEZXeXY1NXdBNHpOSDBzNGpnUTRo?=
 =?utf-8?B?eGtuYzJwZGtWd3NYVnEwWjlBVHNtOVJzay9INlBoaHNJMUpQeitCbjNQeUNk?=
 =?utf-8?B?bEIwNXpSTnEvZ0xWRm96c2wvK1lHV2NUVjVNMVJNb2xldGtvRGo0Y2p4a2ky?=
 =?utf-8?B?OVUvTDJ3SzgwOGNNVmkxL0dBT0Z1YUp2bEZYbXowZUNmSTNxdDQ4Y1pGaCt6?=
 =?utf-8?B?bEJFMkg2aWRUdmpVbG1UNlYweENtcFk0bWF2UWdHSFB6UGYxQlVvWkNpZmVt?=
 =?utf-8?B?OVFBYmJaR3h2RlZVeEtJaFplZU9pYkc1UVJ5b0ZJdFRodXo0c01icHR2T0RM?=
 =?utf-8?B?a1lzMmUwcnJhK3lWV0l2MWNib01lY1dOZWViM2JneEFCUFFQcWE5YXpMOUp0?=
 =?utf-8?B?TmE0eWJUNWZXR2hBWElGcm92Ykp3anoyRnJoZ3NHbFh2WHp1eUlOenVxNTFl?=
 =?utf-8?B?cXBKTERkU2dEeGwrOUpoNzBjSlQ0aklLbGVIaW1PMWp0MkhvMVNsUjFNSnhw?=
 =?utf-8?B?V0x1b0pzY2tyZFgxMHR4czdEQjZUSWpsZGROYU16MlRXelZsb0VCYUI3VGpJ?=
 =?utf-8?B?QXBKWm9XdEVKbHZvODlGVzFDaW5TREl4Nll0VjBLNlRpNm9wTXh2c2dCRGtS?=
 =?utf-8?B?cmk3dmZmZzc5WXArSFV0NzVYYVBad2pIaXZJcWpuRGNsRURacXpzNkR0VkNJ?=
 =?utf-8?B?Y2VmbnRETDdBbUYvdEdtNTl0VjZZL0JZdDljdGttcmd2b2UzMzFIN0pZeUZO?=
 =?utf-8?B?NXN5L0FwMFZmUWxFK0g4c2Y4LzZlUWRSSkJoSitaSmxqRzRmUm45bDdwSFUz?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F3996DAE8E6004C873BE291A7E12D54@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e410c3d5-d7f7-4ba7-7d3f-08db2e5dfb24
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2023 00:55:38.3209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J190I+1YzxDfa7DwqUbWnrp6cbNbqa7WkK6ONcoLIvhekf4L3+PhrsJ9mhI5uZ7wHcQQ/qt4YggHUErY9NoHjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5606
X-MTK: N

T24gU2F0LCAyMDIzLTAzLTI1IGF0IDE0OjA3ICswMzAwLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0K
PiANCj4gVGhlIGRtYV9zZXRfbWFzaygpIGZ1bmN0aW9uIHJldHVybnMgbmVnYXRpdmUgZXJyb3Ig
Y29kZXMgb24gZmFpbHVyZQ0KPiBidXQNCj4gdGhpcyBjb2RlIGlzIHRlc3RpbmcgZm9yIHplcm8g
aW5zdGVhZC4NCj4gDQo+IEZpeGVzOiBmNGI0OWM3YzVlNjcgKCJpb21tdS9tZWRpYXRlazogU2V0
IGRtYV9tYXNrIGZvcg0KPiBQR1RBQkxFX1BBXzM1X0VOIikNCj4gU2lnbmVkLW9mZi1ieTogRGFu
IENhcnBlbnRlciA8ZXJyb3IyN0BnbWFpbC5jb20+DQoNClJldmlld2VkLWJ5OiBZb25nIFd1IDx5
b25nLnd1QG1lZGlhdGVrLmNvbT4NCg0KVGhhbmtzIGZvciB0aGUgaGVscC4NCg0KPiAtLS0NCj4g
IGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lv
bW11L210a19pb21tdS5jIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiBpbmRleCAxYTc1
YjQzODJhOTIuLjZhMDBjZTIwOGRjMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pb21tdS9tdGtf
aW9tbXUuYw0KPiArKysgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQo+IEBAIC0xMjYwLDcg
KzEyNjAsNyBAQCBzdGF0aWMgaW50IG10a19pb21tdV9wcm9iZShzdHJ1Y3QNCj4gcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KQ0KPiANCj4gICAgICAgICBpZiAoTVRLX0lPTU1VX0hBU19GTEFHKGRhdGEt
PnBsYXRfZGF0YSwgUEdUQUJMRV9QQV8zNV9FTikpIHsNCj4gICAgICAgICAgICAgICAgIHJldCA9
IGRtYV9zZXRfbWFzayhkZXYsIERNQV9CSVRfTUFTSygzNSkpOw0KPiAtICAgICAgICAgICAgICAg
aWYgKCFyZXQpIHsNCj4gKyAgICAgICAgICAgICAgIGlmIChyZXQpIHsNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgZGV2X2VycihkZXYsICJGYWlsZWQgdG8gc2V0IGRtYV9tYXNrIDM1LlxuIik7
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ICAgICAgICAgICAgICAg
ICB9DQo+IC0tDQo+IDIuMzkuMQ0KPiANCg==
