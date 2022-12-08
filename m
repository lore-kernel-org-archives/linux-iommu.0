Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20116372
	for <iommu@lists.linux.dev>; Thu,  8 Dec 2022 01:06:20 +0000 (UTC)
X-UUID: 9da44b1b3130454dac537b8da9d91367-20221208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=KN+Hfmd71TZJLp4ytGjUInbvDaRRDV6RB2uG2KsyuFk=;
	b=YEu2Vn64jJ5A4IY7V7ZgebKJiX/5b7Qxr+azJuL+xEcMZLrGJa1Ne6WCsTspE4ewmGKa2k+ufBkFd2Wtrw50ZEMln7EgYKq8jDerE9KR0O9VvucrZyIusdyGNtkgTmAFVN6iQocuMUvW+Zv7u2W9/a62l+9XsZyA8znqrb1jp6s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:2097f3b8-7c61-4a7c-92b5-859b1b5667bc,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:5afa9f24-4387-4253-a41d-4f6f2296b154,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 9da44b1b3130454dac537b8da9d91367-20221208
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
	with ESMTP id 1086474585; Thu, 08 Dec 2022 09:06:11 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 8 Dec 2022 09:06:10 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 8 Dec 2022 09:06:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UsqdT4YA+tigxyTJJDEd/eaf4MWKD+3fJiJCvPkz3rlAQP4sOGpKcRAKtd0AXQadXgzhCbCCL+zEl7QEH6z0gDDzK6rJJ1Z170/CbVoQavPfOMF5pxxB2k4xApp3XlZNBplZnP0NlGegA6jDWgdgxWcLxqb3HgkONtDuT2CZj76TuO8JSQGZzhf3jT/rfuKMBZNkOVlhWTS24b+s7iJp4PpAQ9mEHb1/KnQQirkUWwTf00cWvkVEPYiplOcKghUXuFKMiDlVGLCLZN7d+frrS5uUSROICpaoe1lXVNOjmvwsy6MQjye7QETvv/MGbpHrzMNd3oe7uBSnvoJLm9+97g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KN+Hfmd71TZJLp4ytGjUInbvDaRRDV6RB2uG2KsyuFk=;
 b=aM/1PaMjqadpgy2LlggQV/1w3Mgz67rzzbOF5ngFOYe7EAuOKjQJbNdAVJiZfQyjlT5P+nmgNdGs9sVWBIHI2v1p7onTk9Yohp4xkcy4QXdJR5rOoBsxheaW4ZpYoaGZqYLRopohrRXBUfSVuZeG+AdYb3A7PIPuJTg4gZqnTHhbB4qbEhxNmAcMO+GnYCogf+XnlUuBe7cTCpPgJeQzHwD/iF3owRb47jTiAEuSzPIUX8TMitOJK+wzxiWpO08O3VEeBMfsI9A81cN/kvXMd/zduxKqmSOuNDPxU6Gd1AsOidSbHz0GMwm3sWHBftkKeDEPTwrR5WlUn09wlh2Cxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KN+Hfmd71TZJLp4ytGjUInbvDaRRDV6RB2uG2KsyuFk=;
 b=P4psVKGX+THnLjFSqIcx9jkmQ6VfutzfBg85Ne9Hrw1+NAMzmg/qODAX0cnil1h4iVL7IMvESd1kUkfMl5BGNiS73AkJE7cKwCvaeh4yLpOHNRAHZYQQ463yHcGjMkfjvQz3r9u7NcVYFxn9tS4hk1DCc4rPdbKwuoCaHp4U6yg=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 SEYPR03MB7252.apcprd03.prod.outlook.com (2603:1096:101:c1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Thu, 8 Dec 2022 01:06:08 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4139:bb22:3bf9:f1e3]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4139:bb22:3bf9:f1e3%6]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 01:06:08 +0000
From: =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To: "error27@gmail.com" <error27@gmail.com>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "will@kernel.org"
	<will@kernel.org>
Subject: Re: [PATCH] iommu/mediatek: Fix forever loop in error handling
Thread-Topic: [PATCH] iommu/mediatek: Fix forever loop in error handling
Thread-Index: AQHZClR35l3j06HsUku5hjWhbvtgVK5jLdWA
Date: Thu, 8 Dec 2022 01:06:08 +0000
Message-ID: <68cb1ee26fc61a290a9e69b15234848ec8a02b8c.camel@mediatek.com>
References: <Y5C3mTam2nkbaz6o@kili>
In-Reply-To: <Y5C3mTam2nkbaz6o@kili>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|SEYPR03MB7252:EE_
x-ms-office365-filtering-correlation-id: 116594a9-50b0-46ad-11ed-08dad8b8639e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qComcego3knmOFLHFCi+m0R8zVRKS93hy91KnCyGkCWNu6+MdmadMZxuCZXLgVhBFyVKYzYnVWKMflkGQGb2m+unOwsygF/ZqMKq+a0D/aiIxep6+kGevkYOgwXWFXhFv+dfxJioej4uwt7BK7aN+kbSgX2qpIwrdHWm9wgLaIKko3/qDQc64QxkiR7cO0xOSq1dDdcME1BrixWw9rIhyg4Dqq98PstIzC6bwdmiBOQ+DDvoJ4KjWWgX/AELXMh3HiINCVRYlAA+kH/TteUgu9CyYTUnmbs0Jm3X/2zRwiAlSUedqyTDzszjIDXRFph68TQhZyCIvClsG8Dy07qN4viFvPJ1T1WFPW+jIuQA6QBZzxUHmPGxpkfln4X2t1J7zXhPmXKb0KfWWVlTFmXaW8NcHuTZSFM/mIAY8xQ0N62a1s60zAToZyKZKphunPjEFegxw0AB1aG3I94VBrWT4VFQHTaj1A+jRsCUoA7r3nFIvqms8WZDRHk6DKANy0wrd/iO7EVSvv1XyP69z9p1bpdHKPvewdJjAF0qGYt5YeJmTLLdFJ6vJFIH4i/shwlsDKoWzk+0bGjIao/yOTQ6zj28Vn6jVK3MiinjcBXOfsKL6YEWHHn7HLz56buwWXNRcd9cSUX53fktxaYTUUHHgr4yXARWsy9PhDXaDL7+J+2Dv0zysOwWYcXYjEvG5HBBfm+emZHAQTEKGF69sGViBIoGWRnkMKLTTshQMQumBPta4xrE/c+dlns8i887U1p7SjwznmbqNCd2gLYvCCZrEA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199015)(8936002)(86362001)(36756003)(5660300002)(316002)(2906002)(85182001)(4744005)(6506007)(6486002)(38070700005)(71200400001)(38100700002)(122000001)(478600001)(54906003)(2616005)(6512007)(6916009)(83380400001)(41300700001)(26005)(64756008)(66556008)(66446008)(66476007)(8676002)(4326008)(66946007)(76116006)(91956017)(186003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clBlcHJPNFZPTmJwa2FibFJSZzlFKzdpVTVBRmVvblM2a0VzbzNjWnh2SnFB?=
 =?utf-8?B?ODhZT1dqdCsrK2syV3JLcHZWckE4Tk00T0poVFptaTZZZjNsK2Y2aXdsQWRC?=
 =?utf-8?B?dkF6ZG9KVVo1VlhhQnNBV2pwbVAwT09BUXhpeUVPeUUyNWhLT3ZuMVRRSis3?=
 =?utf-8?B?U0xPT2pYT3pTZWxVZnB5WHY5MTBabEV4bzBtRzN6a25YbW85MEZDUXVycEkv?=
 =?utf-8?B?U3cxUmUvSmEwekpDL1FOWEx5RGcvQk1CV3hoUGFzZ0k4bDhPWTYyczZrQ294?=
 =?utf-8?B?M0ZuVUhDbWhYM2liNnMraFl1U3kzbUJ1cFNpd25oNXlZdmRuQWZIMGhHL3c0?=
 =?utf-8?B?M1BiU0ptK2ZMMTZCcGVyUFB6N2RhUUovNUNKV2oxZ1JwZE9IcWkwRUpYdWFC?=
 =?utf-8?B?eWpPc28wMmE5N2NlV2hTTG81VmkvUXpiTEYzZ1dMK3o3d2lzQjJUU2c5WVUz?=
 =?utf-8?B?OHpidHhWZXZWUitObXg5Z21DaTZXTlNRZjJiN0V6c0pwMHdUaVMxdGhuTUIx?=
 =?utf-8?B?WWxPTW5iTTEwUlgybHBXYmhEU0VHZkdWNnowOFlTMm1VMjZQNmRWRzFNSndO?=
 =?utf-8?B?TXVybW5FSEJINTVNMmV2VVhjVlFyN3dQaGdQNTJHTzBRNHN1NDFhOUFqOGJZ?=
 =?utf-8?B?N00wZEtaMVFNejc1NG50SGdGVkQ4ZDU2MkkwOWo2c1EyR1ZqVS9ZQkl2c3lZ?=
 =?utf-8?B?eEZoUVlHYmd2eDVyTnp6OG9nMk1hUVpTa1ZORDNGblB3S3JtOFpSZmwvNENH?=
 =?utf-8?B?THNlYkJPaW11N0I0M3JyZmJQM1ZUWUtHNzVkV2ZReUhnSUN0QW5sd01iWVJH?=
 =?utf-8?B?YmtibnM3NVpUVWNoa2tTa1NmMVBNcnlUTkd6RkE2RnZ6UGFsN0NNZTQ3b3Np?=
 =?utf-8?B?a3diTXFKczdlaEJ4TVJTcVZUdFczM3V0REdUbmh1aVRia1p4T01RNVplOURO?=
 =?utf-8?B?OCtwWVdnTjc5a21hMU1Pck1ibWJMalB1dzdBZmd4eXlDcnNZdnpXNGVrOGRm?=
 =?utf-8?B?YXdBM2psSEtqcXBMSnI3S3J0WU1UUTM3bEpHWWZvdXYrQXc1WVIyZXlSL2Z2?=
 =?utf-8?B?NFZoTnFCaXUrcVEvejlRZDBuWmM3dk55bWNNU0diWVJ3bjg1RVp3dzk4aCt1?=
 =?utf-8?B?SzVvYTFJalZMUE5ENkJNekdvR2N6YXc0djFJbC9iVXF2YVJkUVRzSjlPdktq?=
 =?utf-8?B?dEI1UHZ4VG9LRmM0WU4rMWVBSlUzTlVuV0hJc3RHdlZIUFhickhVYm9DVTJS?=
 =?utf-8?B?VFU5cG1JMEhhZjBSbEcwTDgwVEM1QzlyaEUyRDg1a2VKMHJUSXpxa1dJZ1B2?=
 =?utf-8?B?UlZTam4xakowQXVGZHpKQk9GQ0YvRmIxY3EyU3dSaVdjdWNHalkvbnhyd2lq?=
 =?utf-8?B?WGdOMHljKzNPZVJOa0k1eW5xbGJBL3RiQ0RKYWdBVzBHNzlhZ0hxZlJWemc1?=
 =?utf-8?B?NXA0L0R3dXNNT1RFSXZOSHhIdDVlRVI3UWw0ZlRCNWMzMzRGWERRUE5rVE4v?=
 =?utf-8?B?YnV1NlhDMTBxV2NkYjJqbEdCQUYrQ2NLbGx2cEpaclBubzlrdmFtTHcvVjVn?=
 =?utf-8?B?ckhvNFh1Qi9vREJSOXdxNjJHUjV1T0haaS9QSFp5TjBheUFpZkNmVzA1bHZK?=
 =?utf-8?B?THU5K0t2TERMeHh0NFIrZzRCbC94ZzlXWW5HUlNyREgvRzhHeTEwQndlWXl0?=
 =?utf-8?B?MTZVVXE4b2lWbUhSRFByT3BOV1BEbm10WTRJTmFMRlBkc0RvdjNEUWRhT2RM?=
 =?utf-8?B?TGVGN1lvRExPTWp4N3FiZXgwZG80SEdSd1BkRjdCV05uMTB6Ly9reDg1djQx?=
 =?utf-8?B?Z2ExZzFxUU50bzc0cXlXRk51Y3ROZVBEVUNBeGNseHJsSmRVRXIvdXNlaVRo?=
 =?utf-8?B?emZZNEg2d1IzaFBzei9pTHlYZ2ExUUxYeFpFN0t5THhBSlhjaHA5L0Y3enBE?=
 =?utf-8?B?U0RaVThWVitsWVZubmtWeWIzWVA1Rnk2dmcxR0V6MXhhZ3g0TUpNUlpBNEdX?=
 =?utf-8?B?Zkl3QmIrT3ppUURzMlBLRnZteGcwbmxlQW1pQ1g4cE9KWVUyaVN0RWFDS25C?=
 =?utf-8?B?bTBxQ3FaT0FFOTg1dUtqSS8wRGZ1alhuRVZqVDFVNXNvMHI5TGtMano5bmh0?=
 =?utf-8?B?RkhWM3d2dXIxWTl5dE5qTkEzbGlwZDdWTDgrZklobG9mVEJ3azd0WlZUVjkx?=
 =?utf-8?B?cUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <986DF3C103195B4AB0EE2C6CE3986681@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 116594a9-50b0-46ad-11ed-08dad8b8639e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2022 01:06:08.2607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tf8kXcIOCLmBex3KkKGw0cgotkVLUjyk+eZ+ehNBkGJBciuh+3xFumrT1BPjZuGoyO/z86whvVTKt0Ic2EpSqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7252
X-MTK: N

T24gV2VkLCAyMDIyLTEyLTA3IGF0IDE4OjU2ICswMzAwLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0K
PiBUaGVyZSBpcyBhIHR5cG8gc28gdGhpcyBsb29wIGRvZXMgaSsrIHdoZXJlIGktLSB3YXMgaW50
ZW5kZWQuICBJdA0KPiB3aWxsDQo+IHJlc3VsdCBpbiBsb29waW5nIHVudGlsIHRoZSBrZXJuZWwg
Y3Jhc2hlcy4NCj4gDQo+IEZpeGVzOiAyNjU5MzkyODU2NGMgKCJpb21tdS9tZWRpYXRlazogQWRk
IGVycm9yIHBhdGggZm9yIGxvb3Agb2YNCj4gbW1fZHRzX3BhcnNlIikNCj4gU2lnbmVkLW9mZi1i
eTogRGFuIENhcnBlbnRlciA8ZXJyb3IyN0BnbWFpbC5jb20+DQoNClNvcnJ5IGZvciB0aGlzLg0K
DQpSZXZpZXdlZC1ieTogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQoNClRoYW5rcyBE
YW4uDQoNCj4gLS0tDQo+ICBkcml2ZXJzL2lvbW11L210a19pb21tdS5jIHwgMyArLS0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jIGIvZHJpdmVycy9pb21tdS9tdGtfaW9t
bXUuYw0KPiBpbmRleCAzZTQ2YmM4YjA3MTQuLjJiYWRkNmFjZmIyMyAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiArKysgYi9kcml2ZXJzL2lvbW11L210a19pb21t
dS5jDQo+IEBAIC0xMTYwLDggKzExNjAsNyBAQCBzdGF0aWMgaW50IG10a19pb21tdV9tbV9kdHNf
cGFyc2Uoc3RydWN0IGRldmljZQ0KPiAqZGV2LCBzdHJ1Y3QgY29tcG9uZW50X21hdGNoICoqbQ0K
PiAgCXJldHVybiAwOw0KPiAgDQo+ICBlcnJfbGFyYmRldl9wdXQ6DQo+IC0JLyogaWQgbWF5IGJl
IG5vdCBsaW5lYXIgbWFwcGluZywgbG9vcCB3aG9sZSB0aGUgYXJyYXkgKi8NCj4gLQlmb3IgKGkg
PSBNVEtfTEFSQl9OUl9NQVggLSAxOyBpID49IDA7IGkrKykgew0KPiArCWZvciAoaSA9IE1US19M
QVJCX05SX01BWCAtIDE7IGkgPj0gMDsgaS0tKSB7DQo+ICAJCWlmICghZGF0YS0+bGFyYl9pbXVb
aV0uZGV2KQ0KPiAgCQkJY29udGludWU7DQo+ICAJCXB1dF9kZXZpY2UoZGF0YS0+bGFyYl9pbXVb
aV0uZGV2KTsNCg==
