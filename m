Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2072.outbound.protection.outlook.com [40.107.8.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376281990D
	for <iommu@lists.linux.dev>; Thu, 18 May 2023 11:45:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7YJn4H96KeVUT1SPmOq+brRLkehISehXJ6rgjDbV6jY9+sqkWBlNkoPJrhodIc5i5DQPXGnWsv+Y67qgjG46Dh9QvW89uNLM0SEM1RIfjq6Kd6dULubf1QwpNfdBIQOql8KHZCdYLU7b65p7a78JAO5pL6OCknf+AezHel0fPcuJNfVwQH2mJv1l+8CpZKGrkwmAItAiYCsdCtdcyFKgC+lpNlAAho4ZMyv0tUzYjdSsY2vzaI6KGypCeYpFuD2PUCXQPH1qSfpOe7g0Vrr6eBnld5DnMW99jBZnt7CzeqtgJ5E1boI5rMxTD3US+9cea2UmrUupmVm1RFDkhT7zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3daINuEoSjkAPGIOfZzzLJJDt4DXrOz4OpwtFGqkbE=;
 b=XrutrctsSl1mybBHzu4OWrWof23U/6jLRfYyRKxh9SOKqmQWqLdymmfrA/tX4GGhHWC5mGeqi4wjxZQjjaG5u7OV4C5yFIak99cCAaX7hl4RB5CDbJoeVEBSvnrYwpWk16w+CWd/zeJG+xSjbCWEB0+dWpFo+HSPWsvUwJxzYIKcwVHS1/hoLbg1fPnJBeRbfTBxSXJRe8hZb8JiKMU+68Ps/qDcax9z7H2pSVDFcX2v50+H8SC0DeApMz6BL9NljmTWgW7zmWGbXxxlbr/VMlqb++t6F4ft62xvqqKbxUZFSGfleQLnIuZrRVn51Fb8GTqHjPQzFAHa1gGzyPy51Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3daINuEoSjkAPGIOfZzzLJJDt4DXrOz4OpwtFGqkbE=;
 b=Hk/0m8eOP1jKufLqNaKQXmNJNLWaiqULSBx1EYc8/fsTJaSaSqVZWlp/925IZxQVWbAadVl/yx65jEUVsqhRWtDnuS3mEIf5/uQA4zFzNEEtlLMJyIig0+iTDEIw8bZ5JgshuJE2feuQAy4gHIS4rygk2hGYPTt1LvAWCujSiH8=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7893.eurprd04.prod.outlook.com (2603:10a6:20b:2ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 11:44:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 11:44:56 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Robin Murphy <robin.murphy@arm.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "jean-philippe.brucker@arm.com"
	<jean-philippe.brucker@arm.com>, "will@kernel.org" <will@kernel.org>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: arm-smmu-v3 sharing SID
Thread-Topic: arm-smmu-v3 sharing SID
Thread-Index: AdmJdUs1QUi3X7zdTlmw0NCi0LcA1gAB0OqAAAAx0NA=
Date: Thu, 18 May 2023 11:44:56 +0000
Message-ID:
 <DU0PR04MB9417B971D20D1572FB598769887F9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References:
 <DU0PR04MB94172CB3F138AD39E9B6DEEF887F9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <359b01bc-e87a-9a50-c971-681e89985491@arm.com>
In-Reply-To: <359b01bc-e87a-9a50-c971-681e89985491@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB7893:EE_
x-ms-office365-filtering-correlation-id: 6614b1fb-4d7f-43d5-effd-08db57954d9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 bf7fdCAHydSt+t2hONbeX/QRjfPL+qCoUR53O0ajG5FNZ7bKeu0M5HofaOIqO1HYtvdI46dYu0sIT+zAqgLfXqRFDV3cNtKO7nyTupDqUeYyI1QUcAQlxgglNByNAG4Oz0gye3oZO5CUot0dLY6ktNuGUyg55NpSTb3L/pG9LWxMQBOh7c7OkVbwiVpKRRHpKSyu5Nv6Vc+swVeI3HwlxwoDZtLgpQ7kpNtQa8hb/120sfX/RQ0OGIRg9C45M0mf7UfFZmwR0NPHB6YlFjgveyD/5zgqAB3qdQhvltRgTxhAnbx9E8n5qSzoYyK3ceHGojwlXb8C12EeeWH6iwB3dfE9iA/+Of76A5jk+UynH3B3GfcwAWIPVmmVlnWvfScQaEsoJ3etDwARdHe2z2ya+hIe0UYvTAjDXae4TgGDaMOMnUZABqZWcnxzreuKoggcsNRd1u2l45QFL/4qrinhDCIG+19rl11yMr98Jx+HdsRtS2GfvZ7BX6k6p8fetb9zaAZsvb3KgVLNITWEhcqiPqLqRbX0d+FQoKy1k2PSn2d9c1VsxHbHyV8m/J0hRrxZBOHhn4boOLgQla/ayCH7QAVLiHLWfnBVw9hce3VHPxmwfUBANmSHJL6A+8ialokG
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(451199021)(86362001)(52536014)(5660300002)(33656002)(110136005)(54906003)(4326008)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(44832011)(316002)(55016003)(83380400001)(8936002)(38100700002)(122000001)(8676002)(38070700005)(2906002)(26005)(9686003)(53546011)(6506007)(71200400001)(478600001)(7696005)(186003)(66899021)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZWdIZnJkS0orRjlacjN1b3JYSUhWbmI4S1B1OGl3UnBxQmxseWY4bDlpMVY5?=
 =?utf-8?B?YVJLZlJjOXd2R2YzMmREeS9OcmYyQVJzVTAxVThreE1lZHN6d2N4ZWdVK0FJ?=
 =?utf-8?B?NVZ5N1BDWHhYMVk1SitVdHd1d2xmTy81cWpicnlsZVRVbnk3bGNrZmxybGZ2?=
 =?utf-8?B?UWk5Q2dlTHJZSGV0UjUyQ2tZeVFjcWR5ZDI2MlBHWDdzUmRrL1V0Y05iMk5D?=
 =?utf-8?B?QW5JWXM2Rk9CeHErQ3NoT09uTWY1eEdvQmFnRWVBb2gvejdEMUpPZ0VobG44?=
 =?utf-8?B?T2UvaDNFZDF5Rk9NMzhGN2x2RTRZeC9HRHhWalFycTFuWmo0dmtvWXlNNTlv?=
 =?utf-8?B?TEwzWSt1Q3p4KzMvYUpTVFZuQnhZNDBZR2llV1FCNHZ3eGNmdkVMRjNLZWpO?=
 =?utf-8?B?NlFDVVFiRktub1lZdTJabU1PWGRkS1kyZUQ2aGdTcWRxdVlwODJqR1hBUlRj?=
 =?utf-8?B?MEk5NENDR2FwNENiRmVoeEE0bDBNbjBMTWNobFQzSTRtNlZXRzVVa0ZXSnFP?=
 =?utf-8?B?R1k0aXdMQkxRT1NMeXdIVUUxditzSkg3bEhpNXduNWsrVkMxNXI4N3Q1STdt?=
 =?utf-8?B?aThPdk9neHA4NUt1eHl0cXNhNTVkVC9ab2RLSXN4a0tobjR3b3RONVpOVFY5?=
 =?utf-8?B?b0Rwd2JOMjcvMU5kSkFwRG1RVUg5QytYUDV0YkVmTFM0WW0wMGJsczVrN0ky?=
 =?utf-8?B?RFR0NkpORlh6RGZlWTdFUWFmQzJ4cysza3E5b29GT3BML2doK0hBdmNPQTlx?=
 =?utf-8?B?aXdoY2FQeUhtNjlLOHVNdHgvWXY2K1lNZ0lhSzQwSlN0SFpLdkxleTdSUkhw?=
 =?utf-8?B?VDlqOGt1WXpURnpWSC82amt5NmxXd2N1UllNb1dqYTU3QWR0S3k4OUM0Rkgx?=
 =?utf-8?B?QXRKRkFqSlR1MEx0MGM3UHJ4MHBEYVFIWUxtSm9RbWlaeDMzakdhVTN4R1dk?=
 =?utf-8?B?eDBvZm81V2JKU1NJakUwSlVEdXhVMjN5ckxDOGlpWkE1eDU0M2ExbEFiaVdM?=
 =?utf-8?B?b2JoMGxhS3djNzNyZTJRdHlUaHluN0dOSGQvazNUU3lNUmZGZjlLRnp2Vjll?=
 =?utf-8?B?OW1iWUZjODhhSzZuYXRweEJaUk5HaWEzbTFKdkI4Qm5nR04vQ1dpdFdadXBJ?=
 =?utf-8?B?MmtNLzYxTGd1M0xPcnBhdGNHWkhxdXoxYjh2emlDcERkTGNGck45cTczQlpr?=
 =?utf-8?B?enR0a2RsR1Vaa2VCeHlseGRxcVRtRVJ0YUtKcDBaR2dxbmNTVS9PbWZyK3lB?=
 =?utf-8?B?N1RWV29IS3VRamE4YjIwcDJkOExrWjBXb2R5aVZyOS94ZG5meG8rYm82MlBI?=
 =?utf-8?B?bmhucW9PU3dlNzVXdGhLTmlYUFY3SFZMUmY1RzFjc1gzZitWSGZMaUw5Q1Nu?=
 =?utf-8?B?eGY4UjBjRFlONHU3SHdFOTdiUXpTTHpDZThtRTVMVWo1WGV3Z2JqRm1lcXpI?=
 =?utf-8?B?YXhBRWJDUlYwTkMzTHR4Y1hDMm9HQ3drR0J2WTFLNTBkL0dLRE1qenZ0VFNZ?=
 =?utf-8?B?Z3czL0pUNXNHbVAranErNWVoTGZmQjVaYTEvbVhydDQvM3JSRW5GVjhvMER5?=
 =?utf-8?B?ODVJakxTbWVxbm02SGxoZkhBSzRMVUJ5cFJyU0czLzFVanQ3LzFiUnlzKzZK?=
 =?utf-8?B?RTNCQ0tPczAvdmdPdGtmMGt3a1B6cUhRdmIrZklDdXl1ZHN4UE9wQUJpRlRM?=
 =?utf-8?B?NzlCVFVpR1pwcGJmY3pRdW5IZVNNdUQ2NS8wbUVJdFFqWnRBcDdxdkN4Q1lI?=
 =?utf-8?B?c3NuM2hWUHJlVXFwbDloaCt0aCtxb3lYNzkrcnhLYmJiaVh4RnRac3QwWW9v?=
 =?utf-8?B?MExiNm8zc1ExVmZ4QUV6cEgyZWppYzdnU2NkTWN1VHZuZnNzdFR4U3dIbnlj?=
 =?utf-8?B?eExhMnNMOXJWTUh6OEhKZmhrUEltZFdwQjZUKzZnSzJVSEJPSHVyalgxSlpu?=
 =?utf-8?B?eGttdE1XRUgvYTZQYXhMNFZxeVozSjNoSzB1TVFYVnRmS3MwNUxDUVNtK2ZV?=
 =?utf-8?B?Ym9XWXQwK1U3V2F6SUZoTy9FL0lCZEpkL1U4aFU3U0gyeFlhQ3FaekVvVUdy?=
 =?utf-8?B?YzRjSHFNeUVaQ0JQS2lOWUVYcnRIVWt6S2tJRXZZOENjSGcvVk9HTDRIbUEv?=
 =?utf-8?Q?RpT8=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6614b1fb-4d7f-43d5-effd-08db57954d9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2023 11:44:56.6772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SRlfkv58ubbdqwHTbajUQCndPN6nafDQt+x7WzjCKCtIiYLizB/ONjRz0lZIC3dpBsHO3rxsixCOYUyVKWU+Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7893

PiBTdWJqZWN0OiBSZTogYXJtLXNtbXUtdjMgc2hhcmluZyBTSUQNCj4gDQo+IE9uIDIwMjMtMDUt
MTggMTE6NDYsIFBlbmcgRmFuIHdyb3RlOg0KPiA+IEhpIGFsbCwNCj4gPg0KPiA+IEN1cnJlbnQg
YXJtLXNtbXUtdjMgZHJpdmVyIGRvZXMgbm90IHN1cHBvcnQgc2hhcmluZyBTSUQsIElmIHRoZXJl
IGFyZQ0KPiA+IHR3byBkZXZpY2VzIHNoYXJpbmcgb25lIFNJRCwgdGhlIHNtbXUtdjMgZHJpdmVy
IHdpbGwgcmVwb3J0ICJzdHJlYW0geA0KPiA+IGFscmVhZHkgaW4gdHJlZSIuDQo+ID4NCj4gPiBX
ZSBoYXZlIGFuIFNPQyB0aGF0IHVzaW5nIHNtbXUtdjMsIG9ubHkgc3VwcG9ydHMgbGltaXRlZCBT
SURzLiBGcm9tIG15DQo+ID4gdW5kZXJzdGFuZGluZywgdGhlIHNtbXUtdjMgaGFyZHdhcmUgc3Vw
cG9ydHMgU0lEIHNoYXJpbmcsIGJ1dCBsaW51eA0KPiA+IGRyaXZlciBub3Qgc3VwcG9ydCB0aGF0
Lg0KPiANCj4gVWdoLCB3ZSd2ZSBhbHdheXMgaG9wZWQgdGhhdCBub2JvZHkgd291bGQgYnVpbGQg
c3VjaCBhIHRoaW5nLCBzaW5jZQ0KPiBTTU1VdjMgYWxsb3dzIGZvciBwbGVudHkgb2Ygc3RyZWFt
IElEcyBmb3IgYW55IHJlYXNvbmFibGUgc3lzdGVtIChBcm0ncw0KPiBpbXBsZW1lbnRhdGlvbnMg
c3VwcG9ydCBhdCBsZWFzdCAyNCBiaXRzKSwgYW5kIGFsaWFzaW5nIGF0IHRoZSBTdHJlYW1JRCBs
ZXZlbA0KPiBkb2VzIHJhdGhlciBjb21wcm9taXNlIHRoZSB1c2VmdWxuZXNzLg0KDQpXZSBvbmx5
IHN1cHBvcnQgbWF4IDY0IFNJRHMuIFNvIEkgYW0gdGhpbmtpbmcgdG8gc2hhcmUgU0lELCBzaW5j
ZSB3ZQ0KaGF2ZSBsb3RzIG9mIGRtYSBjaGFubmVscy4NCg0KPiANCj4gPiBJIHdvdWxkIGxpa2Ug
a25vdyBpcyBpdCBvayB0byBhZGQgc3VwcG9ydCBmb3Igc2hhcmluZyBTSUQ/DQo+ID4gU29tZXRo
aW5nIGxpa2UgdG8gdXNlIGNvbW1vbiByYl9hZGQvZmluZCwgbm90DQo+ID4gc21tdS12MyBkcml2
ZXIgbG9jYWwgcmIgdHJlZSBhZGQvZmluZC4NCj4gDQo+IE5vdCBzdXJlIHdoYXQgeW91J3JlIHRo
aW5raW5nIHRoZXJlIC0gdGhlIFN0cmVhbUlEIHRyZWUgaXMgc3RpbGwgcHJpdmF0ZSB0byB0aGUN
Cj4gU01NVSBpbnN0YW5jZSBlaXRoZXIgd2F5LCBhbmQgdGhlIGV4aXN0aW5nIGFybV9zbW11X2Zp
bmRfbWFzdGVyKCkNCj4gZnVuY3Rpb24gaXMgaWRlYWwgZm9yIGFybV9zbW11X2RldmljZV9ncm91
cCgpIHRvIGRldGVjdCBhbGlhc2luZyBkZXZpY2VzDQo+IGFuZCBncm91cCB0aGVtIGFwcHJvcHJp
YXRlbHkuIFRoZW4geW91IGFsc28gbmVlZCBzb21lIHdheSB0byBza2lwDQo+IHVwZGF0aW5nIFNU
RXMgdGhhdCBoYXZlIGFscmVhZHkgYmVlbiB0b3VjaGVkIGZvciBhIHByZXZpb3VzIGRldmljZSBp
biB0aGUNCj4gZ3JvdXAgKGJhc2ljYWxseSBnZW5lcmFsaXNpbmcgd2hhdCBhcm1fc21tdV9pbnN0
YWxsX3N0ZV9mb3JfZGV2KCkNCj4gY3VycmVudGx5IGRvZXMgZm9yIGR1cGxpY2F0ZSBTdHJlYW1J
RHMgb3duZWQgYnkgb25lIGRldmljZSkuDQoNClRoYW5rcyBmb3Igc2hhcmluZyBpbnNpZ2h0cy4g
QlRXLCB3b3VsZCB5b3UgcGxhbiB0byBhZGQgdGhlIHN1cHBvcnQ/DQoNCj4gDQo+IEknbSBmYWly
bHkgY29uZmlkZW50IGluIHJlYXNvbmluZyBhYm91dCB0aGlzIGZvciBiYXNpYyAuYXR0YWNoX2Rl
diBwdXJwb3NlcywNCj4gc2luY2UgSSBkaWQgaW1wbGVtZW50IHRoZSBlcXVpdmFsZW50IGZvciBT
TU1VdjIsIGJ1dCBJJ20gbm90IHN1cmUgSSBldmVuDQo+IHdhbnQgdG8gdGhpbmsgYWJvdXQgd2hh
dCBpdCB3b3VsZCBtZWFuIGZvciBTVkEsIFBBU0lEcyBhbmQgbmVzdGluZy4uLg0KDQpTbW11LXYz
IGlzIGEgYml0IG5ldyB0byBtZSwgSSBoYXZlIG5vdCBsb29rIGludG8gaXQgc28gZmFyICg6DQpJ
ZiB5b3UgY291bGQgaGVscCwgSSB3b3VsZCBiZSBhcHByZWNpYXRlZC4gDQoNClRoYW5rcywNClBl
bmcuDQo+IA0KPiBUaGFua3MsDQo+IFJvYmluLg0K
