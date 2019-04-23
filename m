Return-Path: <SRS0=UFM6=SZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7909CC10F03
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 22:09:59 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0908A21738
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 22:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="woy2IRUV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0908A21738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D2843F1A;
	Tue, 23 Apr 2019 22:09:58 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6151BF19
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 22:09:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
	(mail-eopbgr10053.outbound.protection.outlook.com [40.107.1.53])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 77824829
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 22:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=U4E2VBFXN01bmm/jpUe/xfG/nlhsA4dsQ/maP/P36T8=;
	b=woy2IRUVlKPOkevow03pSKEraXqPcP3YyGP7ABjwUSLI5cMYR0Cy9AavAxsCFxwg2O3dGunhfyK0BpmPwrUmjqqcBWo/MI3YChRE2kYt6Ll1JuekhqWdvqHN6aKG+38ROAMc2AqAFzESC86DH3EJ3MEsXJll2BYbp7oth+J3jrE=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.50.159) by
	VI1SPR01MB0364.eurprd04.prod.outlook.com (20.178.120.75) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1813.16; Tue, 23 Apr 2019 22:09:54 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
	([fe80::81d8:f74b:f91e:f071]) by
	VI1PR04MB5134.eurprd04.prod.outlook.com
	([fe80::81d8:f74b:f91e:f071%6]) with mapi id 15.20.1813.017;
	Tue, 23 Apr 2019 22:09:54 +0000
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Christoph Hellwig <hch@lst.de>
Subject: RE: [RFC PATCH] dma-mapping: create iommu mapping for newly allocated
	dma coherent mem
Thread-Topic: [RFC PATCH] dma-mapping: create iommu mapping for newly
	allocated dma coherent mem
Thread-Index: AQHU+SuhzP7n9rkWMk6epTxwq855uaZIeyMAgAHQb4A=
Date: Tue, 23 Apr 2019 22:09:54 +0000
Message-ID:
 <VI1PR04MB513407A66107759EC0DFE175EC230@VI1PR04MB5134.eurprd04.prod.outlook.com>
References: <20190422165125.21704-1-laurentiu.tudor@nxp.com>
	<20190422181100.GB32490@lst.de>
In-Reply-To: <20190422181100.GB32490@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [82.76.163.33]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66e757a5-fd78-4bdb-178b-08d6c8386a34
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:VI1SPR01MB0364; 
x-ms-traffictypediagnostic: VI1SPR01MB0364:
x-microsoft-antispam-prvs: <VI1SPR01MB03641394E7DA3E1C005001FFEC230@VI1SPR01MB0364.eurprd04.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(346002)(366004)(396003)(39860400002)(376002)(136003)(55674003)(13464003)(189003)(199004)(478600001)(66556008)(73956011)(76116006)(66946007)(102836004)(229853002)(4326008)(74316002)(86362001)(66476007)(305945005)(7736002)(97736004)(44832011)(64756008)(66446008)(486006)(26005)(6506007)(256004)(186003)(11346002)(14444005)(71190400001)(71200400001)(446003)(8936002)(9686003)(6916009)(8676002)(76176011)(7696005)(81156014)(5660300002)(476003)(53936002)(99286004)(316002)(3846002)(6246003)(52536014)(55016002)(6116002)(6436002)(25786009)(81166006)(33656002)(2906002)(14454004)(66066001)(54906003)(68736007);
	DIR:OUT; SFP:1101; SCL:1; SRVR:VI1SPR01MB0364;
	H:VI1PR04MB5134.eurprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Tu94rUtiWmOvkuuSRopJxghgT1HLTFz3dsF6AZf0r3soF4juy5DwE1FeHYgT0Jje1gHDdFlU59tXV43v0wrLAxSAyZJtehvPPtp5uukNp7A4TOEJ4g4BrBMvserPymf1G3bjnnhEGfJmlD/AyfuOs8mRIUlpU0AlIzCDr9ShCQzzgmTRXeNv6rzDIxscga0zFFZsl+YY+12WfULSb4fdruse1mUIrJncr2iZaSOCtv5ufKxmYrH68iJzc7ng2mtgZxoZfM5nPLOLhJAPSFJhSC+A5oZwJrB/7ZeMnwkZUDOW7h+7GESLPPqkauu4W/ZRw20UwgoGvZAAYsBhxcdKgAt7zeiOAtNovzdrT1mn5aN5jqzwu36mOO1MBx2dWyJfP0gWNPbpp5kL6lqpBWW9SyQv5irW2dJCmKKOIjYcGZ0=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e757a5-fd78-4bdb-178b-08d6c8386a34
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 22:09:54.3465 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1SPR01MB0364
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Leo Li <leoyang.li@nxp.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190423220954.AHcBatmvlsDm5DOfTWIq9ns18vdhd42HumhH2a-LY5M@z>

SGVsbG8sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hyaXN0b3Bo
IEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IFNlbnQ6IE1vbmRheSwgQXByaWwgMjIsIDIwMTkgOTox
MSBQTQ0KPiANCj4gT24gTW9uLCBBcHIgMjIsIDIwMTkgYXQgMDc6NTE6MjVQTSArMDMwMCwgbGF1
cmVudGl1LnR1ZG9yQG54cC5jb20gd3JvdGU6DQo+ID4gRnJvbTogTGF1cmVudGl1IFR1ZG9yIDxs
YXVyZW50aXUudHVkb3JAbnhwLmNvbT4NCj4gPg0KPiA+IElmIHBvc3NpYmxlIC8gYXZhaWxhYmxl
IGNhbGwgaW50byB0aGUgRE1BIEFQSSB0byBnZXQgYSBwcm9wZXIgaW9tbXUNCj4gPiBtYXBwaW5n
IGFuZCBhIGRtYSBhZGRyZXNzIGZvciB0aGUgbmV3bHkgYWxsb2NhdGVkIGNvaGVyZW50IGRtYSBt
ZW1vcnkuDQo+IA0KPiBJIGRvbid0IHRoaW5rIHRoaXMgaXMgc28gc2ltcGxlLiAgVGhlIG9yaWdp
bmFsIHVzZSBjYXNlIG9mDQo+IGRtYV9kZWNsYXJlX2NvaGVyZW50X21lbW9yeSB3YXMgbWVtb3J5
IHRoYXQgaXMgbG9jYWwgdG8gYSBkZXZpY2UsIHdoZXJlDQo+IHdlIGNvcHkgaW4gZGF0YSB0aHJv
dWdoIGEgTU1JTyBtYXBwaW5nIGFuZCB0aGUgZGV2aWNlIGNhbiB0aGVuIGFjY2Vzcw0KPiBpdC4g
IFRoaXMgdXNlIGNhc2Ugc3RpbGwgc2VlbXMgdG8gYmUgYWxpdmUgaW4gdGhlIG9oY2ktc201MDEg
YW5kDQo+IG9oY2ktdG1pbyBkcml2ZXJzLiAgR29pbmcgdGhyb3VnaCB0aGUgaW9tbXUgaW4gdGhv
c2UgY2FzZXMgd291bGQgYmUNCj4gY291bnRlciBwcm9kdWN0aXZlLg0KDQpJIGhhZCBhIGZlZWxp
bmcgdGhhdCBJIGRpZG4ndCBnZXQgdGhlIHdob2xlIHN0b3J5IGFuZCBzb21ldGhpbmcgaXNuJ3Qg
cXVpdGUgcmlnaHQgd2l0aCB0aGlzIHBhdGNoLiDwn5iKIEJ1dCBJJ20gaGFwcHkgdGhhdCB3ZSBo
YXZlIGEgZGlzY3Vzc2lvbiBzdGFydGVkIG9uIHRoZSB0b3BpYyBhbmQsIEkgbXVzdCBzYXksIEkn
bSB2ZXJ5IGludGVyZXN0ZWQgaW4gZ2V0dGluZyB0byB0aGUgYm90dG9tIG9mIGl0IChJIGhhdmUg
c29tZSBwYXRjaGVzIGVuYWJsaW5nIFNNTVUgb24gYSBjb3VwbGUgb2YgTlhQIGNoaXBzIGFuZCBk
ZXBlbmQgb24gcmVzb2x2aW5nIHRoaXMpLg0KSSdsbCB0cnkgdG8gdW5kZXJzdGFuZCB3aGF0IHlv
dSdyZSBwbGFubmluZyBidXQgaW4gdGhlIG1lYW50aW1lIHBsZWFzZSBsZXQgbWUga25vdyBpZiB5
b3UgdGhpbmsgSSBjYW4gYmUgb2YgYW55IGhlbHAuDQoNCi0tLQ0KVGhhbmtzICYgQmVzdCBSZWdh
cmRzLCBMYXVyZW50aXUNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21t
dQ==
