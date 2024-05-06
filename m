Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2100.outbound.protection.outlook.com [40.92.47.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BBC15B103
	for <iommu@lists.linux.dev>; Mon,  6 May 2024 19:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.47.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715025497; cv=fail; b=Fbbt9s9wJt2R6hnx37quyRqAtGgcDW+5hwIrPyRjh186D1Sus+Vqcl3p9XVJtjRfbyGJ9m1pG4m2pY5kLTXyPR2wTghrOpon9XbuiUxVvckHn4PHn6AjdsztVcAYznvJYCB8G2WJtoFtyJzsMnOWp2B08PLYwoJ/ls85RlgE620=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715025497; c=relaxed/simple;
	bh=zijQrdzw60OXMvkHbMO/Au15fIKSpDq6EzxqWcL3H5g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sPi416mS5aH6Wibz67gzhkrWQ/O765dCzmoavcedrqrJGt5mQ00upJ6Adr9hoi8TGBn5vhsCFJC+O76ySJg6sIwW7OHft9nwyxJnIO2nUY3kZYgY+74JGynmDoA16bPXw0cn5LtKij7bZV2fdHMuknJ42c4kahK6oWVBeMsiI+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lFNOsuOT; arc=fail smtp.client-ip=40.92.47.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lFNOsuOT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6W+QwL01Gb92IQk9nef3CHxubXIoCEFueEKJqkGv9+4Szl1T3hNKuLsb1lau0u17rLmQplPsVcV28EZ05SsusT3F0y8fZMC1oGcVFQbz+R7Z80s30RSKmUB7/nUXwPJpzhLbmK+H24XxWuBg79mvGIPzsx+1Iivxh12ARA+fMz9hU1x0fARdIxoAnJbVvuy3GHl4ZfYb3eXg9pOoA7ipnZgU+pYHogVuXJJnGDlYEwJvwcIlzD0oIcsLEUHr8TLUVnNeARoLA+7sLsvPwcO412cCn95EOMR7axU2DyqW5tRDvoFPf6Xqs0EwhAmXYJSLbPLRszvz+jeWxxW4KMe8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zijQrdzw60OXMvkHbMO/Au15fIKSpDq6EzxqWcL3H5g=;
 b=IgcGHvIC61h1WFPfD5Upk/0PVgsYg7X/TqO/YZFsDw9WTNCw5hgKiJwPfd80TI9f52GU5rABklInTWy0DzpIf4OSimPpZQsKryXsfKFkQjzH8ErKyKJWVEZrCPTMySUcbxtJxnAz1MbnD2xMeYLn6gzNr180WwBEQX/IKCghCr3jNVY9/0OlsaMper5YTL1aco/F4x+p8rkvpfS4kRecrdJy3AZEtSb0rnizRxQVnjkaGPCHg/wBtUfVn84AgkyLVYw8Gn3GYBcYH1N0ML+Mf3n3Tf+0bu8pF0edENlD5qaynhfzz1TWEytG6cTjgb3Nd+ffi0n8rewgDSiJMKbhvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zijQrdzw60OXMvkHbMO/Au15fIKSpDq6EzxqWcL3H5g=;
 b=lFNOsuOT+OdjMc6C5iR7JbpGb4Ep5o3ZroagHodjpyjb1QJcmYT+sixeO7KzuVYgBmOsbRqJPHvT10GzmuTv/7VotucB7k8OqQmhDuX6eFjBtPXXlcnzaobepbO4NS7VUDFTS8muBLHh+tD6lyrNQF2awcNydJ4cHT5oYJIIAJRYiDU1Ywsa2i8q03hxqR7hlD5TRZH80IuWV0lDNwwqUSoMKZWafL0TY7hXAP1NGqUZ9X6jAPgXqTee0bkXpesxrV4VLgyJhsP3t52C1VkP0MfkURZUXEEjsk4Vkhh7GfzWlLkJkPDKlIOhiHPUb4wjhS7uluF+VOm0+IU0tYNP3g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MN2PR02MB6688.namprd02.prod.outlook.com (2603:10b6:208:15f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 19:58:11 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 19:58:11 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "T.J. Mercier" <tjmercier@google.com>, =?utf-8?B?UGV0ciBUZXNhxZnDrWs=?=
	<petr@tesarici.cz>
CC: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H. Peter
 Anvin" <hpa@zytor.com>, "hch@infradead.org" <hch@infradead.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"isaacmanjarres@google.com" <isaacmanjarres@google.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] swiotlb: iommu/dma: Clarify swiotlb options apply only to
 dma-direct
Thread-Topic: [PATCH] swiotlb: iommu/dma: Clarify swiotlb options apply only
 to dma-direct
Thread-Index: AQHanYjIGzxHZ57Nq0awSFl6FadUXLGGu8OAgAO9NQCAACjE0A==
Date: Mon, 6 May 2024 19:58:11 +0000
Message-ID:
 <SN6PR02MB4157EE83332FF789FA6BEEE8D41C2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240503183527.1548119-1-tjmercier@google.com>
 <20240504101651.7de5106f@meshulam.tesarici.cz>
 <CABdmKX06v23-w8PQJab8kgfPDRYLU3bQSQ4AsC3zrzxYL955gQ@mail.gmail.com>
In-Reply-To:
 <CABdmKX06v23-w8PQJab8kgfPDRYLU3bQSQ4AsC3zrzxYL955gQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [xs8KVXq8VSRW9fvuelk2V03krZAb/G8f]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MN2PR02MB6688:EE_
x-ms-office365-filtering-correlation-id: 69f066cf-b88c-45ef-381c-08dc6e06dbad
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199019|102099023|3412199016|440099019|1602099003;
x-microsoft-antispam-message-info:
 eLDtnjKUUCx2RjPr/50nsLVcKog1Wavz5k68G9/leDrqz8S5QOi65Nk24NaPESxPioFumdHFJ2RRu0eKogzHae6yCUxVAY7aY7wln1mmn+PcvExgIfjwj3I5x2v0MfNWfQNQbLpUbg35hfjT894FYK0k9uvd1LM9xc1e8u6/huUPTFanFSmzB0Njg79jAHjjgVZF70QdIYMXdJTOSmLnylwQ5ftWIZyrgAoD1PTu0latjmTD0nsUrXZlal82kmLMxdpJhygxVdYpczoesveoUHOKsOVBic8dyZI6BFWG+rESdrbDXbyi0X3+7Qd/ucvCIJjYHIB0O91a5qxI5F4rpeIm0PkIHpyZwCY+F4Zo8TaaGvtS0ptpwyX7K0O9/xdch5VfThuyHvfEH5DXbrg35e+89F+LCQmZLLtRZNof9++sSHCNPo0HoPAcJhxEdwt4tZ5vyA25VLh/tSM3vcrtJbfwOhHA3tZWENqPAeKd6x+rYbUGDwXV4YvTsvoCn7cJwwZnn7RaILeZtbVKGM2Tm7PxVyh5a0B2X8wliXGR73cevWmqqetlI+iDkGyk1CWwnkZMozZDkPUGVvCO094lojHKxWGWWnw6aGQpOrMeyO8drOVSv0bAcv1ROIRbfixDszI+B2wucOyoGc45+fPGE127QOwUpjO4wdKxjcNc5IM=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YmcxaUszMzBRTjJGYXVDdnREWXpXZTFnbWhHNUM2MDBMT1d4NUd0S2N1UmM0?=
 =?utf-8?B?MEV4eDBqeGxiM2UzNHlYZUM1b1hGQ09uU0FHU2x6NTA1bmtSQnN6M3hCTXhM?=
 =?utf-8?B?cVZhUm45OUZaZGxnUG5yaC8yWStkVDlZMzdmOGtwYlBtUDUvWDBKazZma3pr?=
 =?utf-8?B?OVk1aGhJMVFNdThzWTN3aFFaWlU2cUdMMUl1L2dLSTEyTEUya09nS2lGaXJi?=
 =?utf-8?B?eE5JNXg5a2xvV2F2UWlnSUJlWXJGa014QTBYN1ZxS0JndlhDa1RXZDlnZEVv?=
 =?utf-8?B?QnMrYTJtUGxRMDg0a3ZsMDJEYTRoQ3lVSmFOQS8xR0ZiekVyUmlVQU9uT0pt?=
 =?utf-8?B?Zis0T0s1ZlJ3Qjg3SlJ5UHN1OFQvb3dkalczd3FwaHFacVBDbGVEUllEWlIx?=
 =?utf-8?B?T0NoLys0YzZFQUhhdU9qN2NBRVdISlM4T1NPaWdzamQyWXlpUVFBeWQzUVcy?=
 =?utf-8?B?dFJ6elFBbWgxSlI5UXh1U0w2bllTb042WFgrSlJFbDY2NnFQOVlLNTMyM2FU?=
 =?utf-8?B?dmtPV3luNTA3NUpEV0krRU50K1NpOW9FR2pGRVZFeUp2ZzJZN3pUMVhnd3J2?=
 =?utf-8?B?K00wN2Mxby9wUVdXVUlWd0V0MENUS1E2ZGhKMjhYaHNwQXlGK2JnbG5iYkJu?=
 =?utf-8?B?cGxxdlpCWHQ2dG05OFJYYXBwMlNIaGh2UzlVaTVyaG5WS3EyVlBXSnZSZzJs?=
 =?utf-8?B?Y1BEVGZrOTlJbTQzNzlqN2daWmxsWkZyS09IYS82cEQvUlE3Lzd4emU3eFMv?=
 =?utf-8?B?aFBXMlpQYnliMnhDZiswVlR2RUpMY3NhRU8xeXhGZitqNExXY09sSGlLbFhJ?=
 =?utf-8?B?SGFuYXFrTWl4cm90Ymk2bVZMYm8vajFPL0l5YVZDeUhWbExCaXpCTExpV2RW?=
 =?utf-8?B?VDMvcld5UVluYzVmK0s2OGVFdTVHQlk0dHpLV1RkWEFDNll4MFB2QzhNaW5E?=
 =?utf-8?B?OGpyOXdMV2FUUGxkMk5ZOTVuWTdCY1psY0phVnBCUnVldVJJUHl0dlMrOTBE?=
 =?utf-8?B?WG5FYno0bk9CR0dvMklNa3FyUHNmQ1JlRXBoeTRTWXUxdVVGZUtkK01jQS9a?=
 =?utf-8?B?amFhaUJYSEtWbmxXNWZyL2lmNTMwUWppemo0bXpEeXd4SndBRHV5OHVaVk5N?=
 =?utf-8?B?TzZDWm1vUjMzRFVKck9URGFRT2JULzhnSnd4ajJjdUU4L3czT3d2OHhHMDlC?=
 =?utf-8?B?L2p2QXZHMnM0QTB3Mk9MWEdGVFljVDZGNzF3dGh3TVBmcGV1Sm5EV1kxUnRT?=
 =?utf-8?B?NDJ6ZEdTUjRsSUFJMU0wQzNUYkRqcDF5UzhGL0Z3eG5ocklKdHRzL21oRUpt?=
 =?utf-8?B?Y0lySm81YS9jV1pwS2JKcFVNejYzVENuL3pFdVRaRXFvd2NzWGg5RlpHTERn?=
 =?utf-8?B?VE1lRDloejlZWkdNeGxUNzU4OVNTUXRNc2JCb2lOOC96eVhESTN6YVMwUkpF?=
 =?utf-8?B?VGdmVmFKSDQ0TXZPbnViRm4zaFUwUmtLTDlnbTJJTnB4ODVPanRFcUViaElm?=
 =?utf-8?B?VjdlZ1M4a01tQ3U2clZZZ2ZsZVhkME5CSFNmOTVMNzg3Tm5vL3JuSFVST0J6?=
 =?utf-8?B?NTA3OFlYOEhjWHpmL25hdnovNmtCV0xsaklJcWRFMTdITkpRS0ZqOG1RUnRB?=
 =?utf-8?Q?jmF4BXnn3Fq7gsEwsYeZp64JaYFZWJdY3eIftCa/OMak=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f066cf-b88c-45ef-381c-08dc6e06dbad
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2024 19:58:11.3562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6688

RnJvbTogVC5KLiBNZXJjaWVyIDx0am1lcmNpZXJAZ29vZ2xlLmNvbT4gU2VudDogTW9uZGF5LCBN
YXkgNiwgMjAyNCAxMDoyMyBBTQ0KPiANCj4gT24gU2F0LCBNYXkgNCwgMjAyNCBhdCAxOjE24oCv
QU0gUGV0ciBUZXNhxZnDrWsgPHBldHJAdGVzYXJpY2kuY3o+IHdyb3RlOg0KPiA+DQo+ID4gT24g
RnJpLCAgMyBNYXkgMjAyNCAxODozNToyNiArMDAwMA0KPiA+ICJULkouIE1lcmNpZXIiIDx0am1l
cmNpZXJAZ29vZ2xlLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiA+IElPTU1VIGltcGxlbWVudGF0aW9u
cyBub3cgc29tZXRpbWVzIGJvdW5jZSBtZW1vcnkgdGhyb3VnaCBTV0lPVExCIHRvDQo+ID4gPiBh
Y2hpZXZlIGNhY2hlbGluZSBhbGlnbm1lbnQgWzFdLCBvciBwcmV2ZW50IERNQSBhdHRhY2tzIGJ5
IHVudHJ1c3RlZA0KPiA+ID4gZGV2aWNlcyBbMl0uIFRoZXNlIHVzZXMgb2YgU1dJT1RMQiBkaWZm
ZXIgY29uY2VwdHVhbGx5IGZyb20gaGlzdG9yaWNhbA0KPiA+ID4gdXNlIHdoaWNoIHdhcyBhIHNv
bHV0aW9uIHRvIHRoZSBwcm9ibGVtIG9mIGRldmljZSBhZGRyZXNzaW5nDQo+ID4gPiBsaW1pdGF0
aW9ucyB0aGF0IHByZXZlbnQgRE1BIHRvIHNvbWUgcG9ydGlvbiBvZiBzeXN0ZW0gbWVtb3J5DQo+
ID4gPiAodHlwaWNhbGx5IGJleW9uZCA0IEdpQikuIElPTU1VcyBhbHNvIHNvbHZlIHRoZSBwcm9i
bGVtIG9mIGRldmljZQ0KPiA+ID4gYWRkcmVzc2luZyBsaW1pdGF0aW9ucyBhbmQgdGhlcmVmb3Jl
IGVsaW1pbmF0ZSB0aGUgbmVlZCBmb3IgU1dJT1RMQiBmb3INCj4gPiA+IHRoYXQgcHVycG9zZS4g
SG93ZXZlciBhcyBtZW50aW9uZWQsIElPTU1VcyBjYW4gdXNlIFNXSU9UTEIgZm9yIG90aGVyDQo+
ID4gPiBwdXJwb3Nlcy4NCj4gPiA+DQo+ID4gPiBUaGUgc3dpb3RsYiBrZXJuZWwgY29tbWFuZCBs
aW5lIHBhcmFtZXRlciBkb2VzIG5vdCBpbXBhY3QgSU9NTVUgcmVsYXRlZA0KPiA+ID4gdXNlIG9m
IFNXSU9UTEIsIGFuZCB0aGF0IGlzIGludGVudGlvbmFsLiBJT01NVXMgY2Fubm90IGJlIGZvcmNl
ZCB0byB1c2UNCj4gPiA+IFNXSU9UTEIgZm9yIGFsbCBidWZmZXJzLiBVcGRhdGUgdGhlIGRvY3Vt
ZW50YXRpb24gZm9yIHRoZSBzd2lvdGxiDQo+ID4gPiBwYXJhbWV0ZXIgdG8gY2xhcmlmeSB0aGF0
IFNXSU9UTEIgdXNlIGNhbiBvbmx5IGJlIGZvcmNlZCBpbiBzY2VuYXJpb3MNCj4gPiA+IHdoZXJl
IGFuIElPTU1VIGlzIG5vdCBpbnZvbHZlZC4NCj4gPiA+DQo+ID4gPiBbMV0gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsLzIwMjMwNjEyMTUzMjAxLjU1NDc0Mi0xNi1jYXRhbGluLm1hcmluYXNA
YXJtLmNvbS8NCj4gPiA+IFsyXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAxOTA5MDYw
NjE0NTIuMzA3OTEtMS1iYW9sdS5sdUBsaW51eC5pbnRlbC5jb20vDQo+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBULkouIE1lcmNpZXIgPHRqbWVyY2llckBnb29nbGUuY29tPg0KPiA+ID4gLS0tDQo+ID4g
PiAgRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQgfCAxICsN
Cj4gPiA+ICBEb2N1bWVudGF0aW9uL2FyY2gveDg2L3g4Nl82NC9ib290LW9wdGlvbnMucnN0ICB8
IDIgKy0NCj4gPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRl
L2tlcm5lbC1wYXJhbWV0ZXJzLnR4dCBiL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2VybmVs
LXBhcmFtZXRlcnMudHh0DQo+ID4gPiBpbmRleCAyMTNkMDcxOWUyYjcuLjg0YzU4MmFjMjQ2YyAx
MDA2NDQNCj4gPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2VybmVsLXBhcmFt
ZXRlcnMudHh0DQo+ID4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1w
YXJhbWV0ZXJzLnR4dA0KPiA+ID4gQEAgLTY0ODYsNiArNjQ4Niw3IEBADQo+ID4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdG8gYSBwb3dlciBvZiAyLg0KPiA+ID4gICAgICAgICAg
ICAgICAgICAgICAgIGZvcmNlIC0tIGZvcmNlIHVzaW5nIG9mIGJvdW5jZSBidWZmZXJzIGV2ZW4g
aWYgdGhleQ0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHdvdWxkbid0IGJl
IGF1dG9tYXRpY2FsbHkgdXNlZCBieSB0aGUga2VybmVsDQo+ID4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgd2hlcmUgYSBoYXJkd2FyZSBJT01NVSBpcyBub3QgaW52b2x2ZWQNCj4g
PiA+ICAgICAgICAgICAgICAgICAgICAgICBub2ZvcmNlIC0tIE5ldmVyIHVzZSBib3VuY2UgYnVm
ZmVycyAoZm9yIGRlYnVnZ2luZykNCj4gPiA+DQo+ID4gPiAgICAgICBzd2l0Y2hlcz0gICAgICAg
W0hXLE02OGssRUFSTFldDQo+ID4NCj4gPiBZZXMsIHRoaXMgcGFydCBpcyBjb3JyZWN0LiBTV0lP
VExCIGNhbm5vdCBiZSBmb3JjZWQgaWYgdGhlcmUgaXMgYW4gSU9NTVUuDQo+ID4NCj4gPiA+IGRp
ZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2FyY2gveDg2L3g4Nl82NC9ib290LW9wdGlvbnMucnN0
IGIvRG9jdW1lbnRhdGlvbi9hcmNoL3g4Ni94ODZfNjQvYm9vdC1vcHRpb25zLnJzdA0KPiA+ID4g
aW5kZXggMTM3NDMyZDM0MTA5Li4wNjZiNGJjODE1ODMgMTAwNjQ0DQo+ID4gPiAtLS0gYS9Eb2N1
bWVudGF0aW9uL2FyY2gveDg2L3g4Nl82NC9ib290LW9wdGlvbnMucnN0DQo+ID4gPiArKysgYi9E
b2N1bWVudGF0aW9uL2FyY2gveDg2L3g4Nl82NC9ib290LW9wdGlvbnMucnN0DQo+ID4gPiBAQCAt
Mjg1LDcgKzI4NSw3IEBAIGlvbW11IG9wdGlvbnMgb25seSByZWxldmFudCB0byB0aGUgQU1EIEdB
UlQgaGFyZHdhcmUgSU9NTVU6DQo+ID4gPiAgICAgICAgQWx3YXlzIHBhbmljIHdoZW4gSU9NTVUg
b3ZlcmZsb3dzLg0KPiA+ID4NCj4gPiA+ICBpb21tdSBvcHRpb25zIG9ubHkgcmVsZXZhbnQgdG8g
dGhlIHNvZnR3YXJlIGJvdW5jZSBidWZmZXJpbmcgKFNXSU9UTEIpIElPTU1VDQo+ID4gPiAtaW1w
bGVtZW50YXRpb246DQo+ID4gPiAraW1wbGVtZW50YXRpb24gd2hlcmUgYSBoYXJkd2FyZSBJT01N
VSBpcyBub3QgaW52b2x2ZWQ6DQo+ID4gPg0KPiA+ID4gICAgICBzd2lvdGxiPTxzbG90cz5bLGZv
cmNlLG5vZm9yY2VdDQo+ID4gPiAgICAgICAgPHNsb3RzPg0KPiA+DQo+ID4gQnV0IHRoaXMgcGFy
dCBuZWVkcyBzb21lIGltcHJvdmVtZW50LiBUaGUgInN3aW90bGIiIG9wdGlvbiBpcyBub3QNCj4g
PiBlbnRpcmVseSBpZ25vcmVkIGlmIHRoZXJlIGlzIGEgaGFyZHdhcmUgSU9NTVUuIEZvciBleGFt
cGxlLCB0aGUgc2l6ZSBvZg0KPiA+IHRoZSBTV0lPVExCIGNhbiBiZSBhZGp1c3RlZCB1c2luZyAi
c3dpb3RsYj08c2xvdHM+IiwgYW5kIHNpbmNlIFNXSU9UTEINCj4gPiBjYW4gYmUgdXNlZCBieSBJ
T01NVXMgZm9yIG90aGVyIHB1cnBvc2VzIChhcyB5b3UgY29ycmVjdGx5IG5vdGUgaW4gdGhlDQo+
ID4gY29tbWl0IG1lc3NhZ2UpLCB0aGlzIHNldHRpbmcgaXMgcmVsZXZhbnQgZXZlbiB3aGVyZSBh
IGhhcmR3YXJlIElPTU1VDQo+ID4gaXMgaW52b2x2ZWQuDQo+ID4NCj4gPiBQZXRyIFQNCj4gDQo+
IFRoYW5rcy4gSSB0aGluayBJIHNob3VsZCBhbHNvIHVwZGF0ZSB0aGUgY29tbWl0IG1lc3NhZ2U6
DQo+ICJUaGUgc3dpb3RsYj1mb3JjZSBrZXJuZWwgY29tbWFuZCBsaW5lIHBhcmFtZXRlciBkb2Vz
IG5vdCBpbXBhY3QgSU9NTVUNCj4gcmVsYXRlZCB1c2Ugb2YgU1dJT1RMQiINCj4gYW5kIHRpdGxl
Og0KPiAiQ2xhcmlmeSBzd2lvdGxiPWZvcmNlIG9wdGlvbiBhcHBsaWVzIG9ubHkgdG8gZG1hLWRp
cmVjdCINCj4gDQo+IEFzIGZvciBmaXhpbmcgYm9vdC1vcHRpb25zLnR4dCwgSSB0aGluayBpdCBt
YWtlcyB0aGUgbW9zdCBzZW5zZSB0bw0KPiBleHBhbmQgb24ganVzdCB0aGUgZm9yY2Ugb3B0aW9u
IHJhdGhlciB0aGFuIHRoZSBzZWN0aW9uIHN1bW1hcnkgbGlrZQ0KPiBhYm92ZToNCj4gICAgICAg
IGZvcmNlDQo+ICAgICAgICAgIEZvcmNlIGFsbCBJTyB0aHJvdWdoIHRoZSBzb2Z0d2FyZSBUTEIu
DQo+ICsgICAgICAgIEhhcmR3YXJlIElPTU1VIGltcGxlbWVudGF0aW9ucyBjYW4gdXNlIFNXSU9U
TEIgYm91bmNlIGJ1ZmZlcmluZyBpbg0KPiArICAgICAgICBzb21lIGNpcmN1bXN0YW5jZXMsIGJ1
dCB0aGV5IGNhbm5vdCBiZSBmb3JjZWQgdG8gYWx3YXlzIHVzZSB0aGVtLCBzbw0KPiArICAgICAg
ICB0aGlzIG9wdGlvbiBvbmx5IGhhcyBhbiBlZmZlY3Qgd2hlbiBubyBoYXJkd2FyZSBJT01NVSBp
cyBpbnZvbHZlZC4NCj4gICAgICAgIG5vZm9yY2UNCg0KTm90ZSBhbHNvIHRoYXQgdGhlIGRvY3Vt
ZW50YXRpb24gZm9yIHN3aW90bGI9IGluIGJvb3Qtb3B0aW9ucy5yc3QgaXMgc29tZXdoYXQNCm91
dC1vZi1kYXRlLiAgSXQgZG9lc24ndCBoYXZlIHRoZSBvcHRpb25hbCBzZWNvbmQgaW50ZWdlciBw
YXJhbWV0ZXIgdG8gc3BlY2lmeQ0KdGhlIG51bWJlciBvZiAiYXJlYXMiIHRoYXQgaGF2ZSB0aGVp
ciBvd24gbG9jay4gIFBlcmhhcHMgdGhhdCBjb3VsZCBiZSBmaXhlZA0KYXQgdGhlIHNhbWUgdGlt
ZT8NCg0KTWljaGFlbA0K
