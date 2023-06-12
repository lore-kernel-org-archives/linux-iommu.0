Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2041.outbound.protection.outlook.com [40.107.113.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF711FA5
	for <iommu@lists.linux.dev>; Mon, 12 Jun 2023 07:44:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cs7AMhZiw3b8uVODPQYjTJm0UpAb0Wc6C9sxxV3BAu22NqwBJFZS0BGbCaiNGIBtVwEdhddK7tSiwQw3S+40DLH7uN/oxDD6P5Tj2UqUSg7uFxUy7buECxmseFQ8emf7rRip8xbyHao5N9QVzIJUS3XlSOBgZZEo7TzD4Uc/nQqEiZI/vYv17IQ17MUW2bvoEoZQNYjCWxqzNjHQ9rX/oSFVe5V650E54mxIvcbTctU8ZdfgilK17XUqlrLTkZjvkOrRqKzQgcIfUmHowN4zlC6YfZr99dZFEtryaIGP++fadoI8wuT4Gx/xMPlEVRX+HdYXjKNuSk0DZg4k0SRWEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZG1mGM4lfzruUB8ZCkRcbaiTVepc8RoUII2R+ni7Ok=;
 b=PvMvtbK6ea2tIaTiJnSyFGEqPw8FU9Ch/g9+c6d45dBvDZbiJUHqtstqw07nRbZJhAYeWvf/e2C4uDQtGTfJPlocVDhg1+AEwioMT/5Pdmx7YtNon3pGq7JnLN2w77j98GxtFDrlDhfhMuzkS4pLRPb+wDD279ovk2r27vM6LHpGADbL4kpO+ww2ZjZulkPVqZtpniIUADhpYH91t1UzNFyaYWgyAAMs/VhTiidoLYDGqhHhJiVCqfYkhRhSv8jOyC16miSCkd9naYvBLROPJ5qrOuAfXLHFZxLikFXUnoxIEOYdQnyZnAIoSa2WrXDthGGcEjOLCuKX2/GxvYdA6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ntt.com; dmarc=pass action=none header.from=ntt.com; dkim=pass
 header.d=ntt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ntt.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZG1mGM4lfzruUB8ZCkRcbaiTVepc8RoUII2R+ni7Ok=;
 b=FY7SfORF57pPIB9zuErCz/7LSYMzIc9zwxuqyzC8CDfDqAteM4qorgJGUOVdeo+miec3QdIcrARFrtUZzFoxExTEpZp2QNC8RHev5u4ZXw+uYPnYXfDpAFNnd3mGsI3P5AXUFMjnduwrmbsd9KczBsbplI0T+dUqZFNVxy50kgA=
Received: from TYWPR01MB10112.jpnprd01.prod.outlook.com (2603:1096:400:1e4::8)
 by OS3PR01MB8148.jpnprd01.prod.outlook.com (2603:1096:604:176::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 07:44:46 +0000
Received: from TYWPR01MB10112.jpnprd01.prod.outlook.com
 ([fe80::1edf:6acc:120e:64dd]) by TYWPR01MB10112.jpnprd01.prod.outlook.com
 ([fe80::1edf:6acc:120e:64dd%4]) with mapi id 15.20.6455.043; Mon, 12 Jun 2023
 07:44:46 +0000
From: Tomonori Fujita <tomonori.fujita@ntt.com>
To: =?utf-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>, Isaac Manjarres
	<isaacmanjarres@google.com>
CC: Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, Arnd
 Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Herbert Xu <herbert@gondor.apana.org.au>,
	Saravana Kannan <saravanak@google.com>, Alasdair Kergon <agk@redhat.com>,
	Daniel Vetter <daniel@ffwll.ch>, Joerg Roedel <joro@8bytes.org>, Mark Brown
	<broonie@kernel.org>, Mike Snitzer <snitzer@kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, FUJITA Tomonori
	<fujita.tomonori@lab.ntt.co.jp>, Konrad Rzeszutek Wilk
	<konrad.wilk@oracle.com>
Subject: RE: [PATCH v6 00/17] mm, dma, arm64: Reduce ARCH_KMALLOC_MINALIGN to
 8
Thread-Topic: [PATCH v6 00/17] mm, dma, arm64: Reduce ARCH_KMALLOC_MINALIGN to
 8
Thread-Index: AQHZmqoVweZDSWUl5keUDZ/zWCXGi6+GzIwA
Date: Mon, 12 Jun 2023 07:44:46 +0000
Message-ID:
 <TYWPR01MB101127656AB0A0D5DB1FF4CB3F354A@TYWPR01MB10112.jpnprd01.prod.outlook.com>
References: <20230531154836.1366225-1-catalin.marinas@arm.com>
	<CABfwK12_wC1t5J9c8qRmUi9H4GtYc6KR9oeJPi8ucK36prhUzQ@mail.gmail.com>
	<CAMj1kXHP_57EOOYQtuL2NO9=7sHPxrX=c0ayYwHaYx9x9hxhJw@mail.gmail.com>
	<ZIJISbauzCR/oKby@google.com> <20230609101156.6f17e3c6@meshulam.tesarici.cz>
In-Reply-To: <20230609101156.6f17e3c6@meshulam.tesarici.cz>
Accept-Language: en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ntt.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10112:EE_|OS3PR01MB8148:EE_
x-ms-office365-filtering-correlation-id: 55ed5cad-f04a-43c8-35e5-08db6b18e48b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 2VoXQdiQlu1LvZw+jt3QO/pd+q0f7iHhPHb80PxpkdGqTtYaD8+EZYKK0qmJwT64hFB0l8ySf6GZI08okNX/atnfYUVdI4c3AfElS+YG779CbgRI4n7lIMu/pIt2VEqp3KAjCJgwSTPKEpvau4P7mQxgC2ev6mvGa2aGrd0FcCTbdV4hA+hdMzdl3jCG5oTlQCyI6UPVaYJ9+QJu90OvU4k8prkn7QqcBPMoH46J4pXwu8iUk0LbGrsfHU87NpTILbCh9wbRgIxHDfPtCjtNxJWMWJimZu8Cq/tSrsDM4nr/ea7Gfodz8IPrD4fH83Ax4p1LBYjsTxGht2GO7RUsMW4JPtLMgfhgO3HxVgg3e2Gm9PMSdfiJTx1Mo2AnZ5ef0prVTub2uW4s3gTCviOooU93WaW86Aj5W264FFCeGiybA4r8wzii/0KbvvF/w0zoHEUiZRh/+stSWyHNkIbkwGYSDyl6oqkbtwMtqd48okG7ZDrorpbNVfLDHJnzRdDih/FCPpcnEiXnFzFxjizrro9NrN9ZHKXE3HMNOZESRlj2CsjEAYU+85TeB0UrlRLjVcWx0R/FGD9zYdrHF8Z7D9aaIrYiqGKMVrc+MQQQqmNnBIZ+F+D9U7K06mAdhb/+
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB10112.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199021)(85182001)(38070700005)(4744005)(2906002)(52536014)(33656002)(86362001)(7416002)(55016003)(71200400001)(7696005)(186003)(83380400001)(6506007)(9686003)(5660300002)(26005)(478600001)(122000001)(82960400001)(110136005)(54906003)(64756008)(66476007)(66556008)(4326008)(38100700002)(76116006)(66446008)(41300700001)(66946007)(316002)(8936002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SWF1ZjdkOVdPUHo0bU01NGQvQkZ1RGZaUkxXY0xjeUZnYW9GdzlyclZVdHZh?=
 =?utf-8?B?TS93ckZLTEhzMU5aOXpuTlFOVnpQMUhhUmJhSXFOMmpWTlRXQlBrV1I5RnVB?=
 =?utf-8?B?Tkl6dmtPLzJIVHYyL1JLeVE2SnpLL3FRL2NRdENBMDljaUo4WDFBaHd3ZEhN?=
 =?utf-8?B?ZldqZEJFbjV6ZHdCN21Hb250ejRmQlVlZDE2b1MzeXVIMEpBcGFqWUs0dWRt?=
 =?utf-8?B?TEloY3ljbHVFWCt3ZEVvWWZ2bmFnQjFnekFBdDJVWFBHT3NpdjFwWUVHbFh0?=
 =?utf-8?B?SDh3aENBMkMxZzZDQjRyaDZITEdUdnpIRERRQzFyMjQ4eDk1dDJONW45TUw2?=
 =?utf-8?B?UU14cWJoRWRKa0c0TzVOTjliRkp4QTdIWGxxVHExTjNCa0c1Y3ZWZ3lJdzBH?=
 =?utf-8?B?K2ZabkNORkljc1VtOVhGQ2Ywck9OYkI2ejNMMmg2UHdrbDhSd0VEc2J0anlX?=
 =?utf-8?B?T2pqYU5SQnNTbDdNMXlxWjNDdEl2eEw4S2RwYmRtZXhVbjBVSHp2OGR1UGI2?=
 =?utf-8?B?WlBxUlRkTVQwbWdscjl6Tk83ZTJFMWpNY05IY0xzS3l1OFZKVnZVTzBOL0dI?=
 =?utf-8?B?M2FDT3lRcHZUWmUreE1tOE43VHJSemd6Y1p0aVRzMVNFYldFeDhIVys5b0NG?=
 =?utf-8?B?eEJ3bURJNkdBa2hBaUJlNzZCd1UwSUx2UkRabkNyZHd1VmZiczB6MExveTVw?=
 =?utf-8?B?NFJYSXpvQVB6T0xoWUtxb0RKZ2U2dnIwWCtxZWR2S0tvMmNnSitSU01DR3F2?=
 =?utf-8?B?Zy9WMWkrZWRadmlrY3V1NlRWamxFMElOL3lhREZaQ29pY0U1d3czUmJaWXF3?=
 =?utf-8?B?bTdBbC9wNDFLSHVOVWVhVXRybWFadVIrdXFlVlZwNFpBK3ZPYTRBMzExeitt?=
 =?utf-8?B?dTQ4R1d2SUFKWU9YYldBRXNlYjJEdHB1YzNGK3liVnptZ0pSbDloTWl0U3di?=
 =?utf-8?B?Q0xsSEpLUFp4cG9mV3BvTHpQUG85cmtWQVdvdkxselNnNlNUUmI2RysrNU9U?=
 =?utf-8?B?R3U1QkRybUlwN2poU2J0cFJVQ2x5SUt4YWY0RnVGcGQvOTlLaEV1UG5xSklu?=
 =?utf-8?B?UGtkS3VrVUp2Rk9YNmJjc21semYxZUJGTFpaRTZYajZpODRxY1czSHBCU2tz?=
 =?utf-8?B?ODE2UStENzlwZkYvMDl2aFB5ekdCb2d6UE5ZRWpxRzl0R1VaQmE2a0VXYmdB?=
 =?utf-8?B?eTZVSnFlWUdEMnAxRy9abVVHTk91Rjg2YVlyQmNTMXlMNkNnSWRlMGU2Y0VQ?=
 =?utf-8?B?TU5EZndkdDlxSVpvWGh3TFhyNUxxSTZQV2xxY0YzTEU5Qnp6MlZYK1ZZNjJQ?=
 =?utf-8?B?c2lCWTU2OFRYSU15aVJwVmg2MFJ4RmFOOHBXcUYvakcxYWFSeG8xTGJXUkZy?=
 =?utf-8?B?dmdoR1lhdXllRERDV2R5RzBYZW5jVkQ5a0VhZll2a0pWKzhTYU82WFNmQVpN?=
 =?utf-8?B?MmhjTFBGTnpEcktKN1lSVVQ5dHpGTFlzQ0NjK1VMbHVCQUhhZTlqaVN4RFNo?=
 =?utf-8?B?QjM1T1kxVXlUaHFWRmd6TWlSR1V4RjFqTjFEeTBJcGJqSDUzYzlPZHMzdUNK?=
 =?utf-8?B?eFRNRGg2cHlpcWx1cG1vcEp4VmR5NGNyOUpuNjJQVVN5dC9oQkxlSGM1Q0ZC?=
 =?utf-8?B?d3JweFhVdXhUU3JNbXo4YXVrUjdrRVlZNGNpTERmRkxNZjBVV3UvU3FrZ2ZB?=
 =?utf-8?B?ZU5KN3VaSE5yZ0x4UFl4d1FFUFF5RGJKS1lPbW5ibkRpQ2lYOFA1Rzdrd25I?=
 =?utf-8?B?QzZVOU5sWWd2UDhBNjJPYmtmckcwWDIxN2hGUnFLeTVwaWYzaC9vanlma0NZ?=
 =?utf-8?B?a0VCR01pUWRLQmZnZXE2TCswMUQ5VVVwRkxxL3RqU2ZINzRRNjhKN1E5VnRr?=
 =?utf-8?B?c0JvN2I1ZEd1V0p1cTBmYUtKZGIwNWplUlRka1BNWnF4cDZ1RmhGRlo3bEVU?=
 =?utf-8?B?NDVJY2lTcU1vZGFaeDV3YXl4VCtEVG1ocS90RGhyZnZVTEVkTTl1d3FCL1RL?=
 =?utf-8?B?dllHNUdEQk9LMitBbFpSc1FldHZuOVZwOFFYRkk3bXFoU0JsdFdPNXQ4NUF3?=
 =?utf-8?B?czhFQXZ3VnVVN29ONlRUUVg1cng1SVRydkdVZm5MZ2xxRjlSalRRWU9tR1p0?=
 =?utf-8?Q?x1kz+O1oh9YthVPem/P9Q2Oui?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: ntt.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10112.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ed5cad-f04a-43c8-35e5-08db6b18e48b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 07:44:46.0340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a629ef32-67ba-47a6-8eb3-ec43935644fc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uSvJDahDfTG68OBCObMSK6byK9yxBiuVSDVAOO0I2KZfn6ymxdmrhfRHPMLVQjc0R8JezP0r1be2wdhQCVL7Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8148

SGksDQoNCk9uIFRodSwgOCBKdW4gMjAyMyAxNDoyOTo0NSAtMDcwMA0KSXNhYWMgTWFuamFycmVz
IDxpc2FhY21hbmphcnJlc0Bnb29nbGUuY29tPiB3cm90ZToNCg0KPiBQLlMuIEkgbm90aWNlZCB0
aGF0IHRoZSB0cmFjZV9zd2lvdGxiX2JvdW5jZWQoKSB0cmFjZXBvaW50IG1heSBub3QgYmUgIA0K
Pmludm9rZWQgZXZlbiB0aG91Z2ggYm91bmNpbmcgb2NjdXJzLiBGb3IgZXhhbXBsZSwgaW4gdGhl
IGRtYS1pb21tdSANCj5wYXRoLA0KPiBzd2lvdGxiX3RibF9tYXBfc2luZ2xlKCkgaXMgY2FsbGVk
IHdoZW4gYm91bmNpbmcsIGluc3RlYWQgb2YgIA0KPnN3aW90bGJfbWFwKCksIHdoaWNoIGlzIHdo
YXQgZW5kcyB1cCBjYWxsaW5nIHRyYWNlX3N3aW90bGJfYm91bmNlZCgpLg0KPiANCj4gV291bGQg
aXQgbWFrZSBzZW5zZSB0byBtb3ZlIHRoZSBjYWxsIHRvIHRyYWNlX3N3aW90bGJfYm91bmNlZCgp
IHRvDQo+IHN3aW90bGJfdGJsX21hcF9zaW5nbGUoKSBzaW5jZSB0aGF0IGZ1bmN0aW9uIGlzIGFs
d2F5cyBpbnZva2VkPw0KDQpEZWZpbml0ZWx5LCBpZiB5b3UgYXNrIG1lLiBJIGJlbGlldmUgdGhl
IGNoYW5nZSB3YXMgbWVyZWx5IGZvcmdvdHRlbiBpbiBjb21taXQgZWI2MDVhNTc1NGQwICgic3dp
b3RsYjogYWRkIHN3aW90bGJfdGJsX21hcF9zaW5nbGUgbGlicmFyeSBmdW5jdGlvbiIpLg0KDQpM
ZXQgbWUgdGFrZSB0aGUgYXV0aG9yIGludG8gQ2MuIFBsdXMgS29ucmFkLCB3aG8gYnVpbHQgZnVy
dGhlciBvbiB0aGF0IGNvbW1pdCwgbWF5IGFsc28gaGF2ZSBhbiBvcGluaW9uLg0KDQpXaGVuIEkg
d3JvdGUgdGhlIHBhdGNoLCB0cmFjZV9zd2lvdGxiX2JvdW5jZWQoKSBleGlzdGVkPw0KDQpJIGNh
bm5vdCByZWNhbGwgdGhlIHBhdGNoIGJ1dCBmcm9tIHF1aWNrIGxvb2ssIG1vdmluZyB0cmFjZV9z
d2lvdGxiX2JvdW5jZWQoKSB0bw0Kc3dpb3RsYl90YmxfbWFwX3NpbmdsZSgpIG1ha2VzIHNlbnNl
Lg0KDQp0aGFua3MNCg0K
