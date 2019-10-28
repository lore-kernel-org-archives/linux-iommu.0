Return-Path: <SRS0=Xx/3=YV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC34CA9EBC
	for <iommu@archiver.kernel.org>; Mon, 28 Oct 2019 10:55:11 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3C98214D9
	for <iommu@archiver.kernel.org>; Mon, 28 Oct 2019 10:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ah5A57K1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3C98214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9EA5510BB;
	Mon, 28 Oct 2019 10:55:10 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4671F10BA
	for <iommu@lists.linux-foundation.org>;
	Mon, 28 Oct 2019 10:55:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
	(mail-eopbgr130078.outbound.protection.outlook.com [40.107.13.78])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 39A2614D
	for <iommu@lists.linux-foundation.org>;
	Mon, 28 Oct 2019 10:55:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=nRtb7N8HUJbZ6I+kk+tcQRVvfUk8jbgFS3ziA6iB3LnEGQSkrkqzhXnqDzCeUP1gLQAqTQ5sUBBrGEKJh6INz3suHcxoD9eXocn5VBgttHdItd/rhERORnIqbYsiuE6aRqadLV6JHQBfsvrPVNGfJBGax6wtFCDos1fPYW/0Fz5HcEIBL7jR71g/fn0Shv73k3TI7T4FnN1QtkfIjdAdQDVLRPHr/5vlIE+6vVQX5DpMktCMWI/MkeeqPbGulGnHtKuKDvjgHrdpvGi0zz1SSuknismDam7kxk07Zh3NdAFYu5/dMD53UDqzBn3B8O65y4mP0hFpq6uNqq28IA3ChQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=gA7NVvdml+tO4M/+iSrtCV5kcc4SUQeXzYgzFAFGBGM=;
	b=fSYylWOwoH04KuRiZP708dPAgmjjT/AUhKEUcTpZPDfm+m58O/sfbR5dH6BcL5DR037BZ3scVdP2iz5bM/Aw2KjY3SdXagShldgRkomWOouGefYD+qT2HVNRS7N0AbUesSUcaevwRMEtWS3PmN3kQuwBBfZqe8aW9JWUpC/m1dv/n83CTI1jNdLkxEWgBG4wnWWDmUGyPg9lmnRIaam8PcMamSCb7GzefS+c450794U7PQo8//6bcwqAa8m0NuXgSFkJBmdeBBrPIp3NgMmrZP61czy2uBdTcu2tDZH2DrDUGQ9zmG7Dh2hg3dc/V2hcc2eT7WuNOEDObMih4bjNNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com;
	dkim=pass header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=gA7NVvdml+tO4M/+iSrtCV5kcc4SUQeXzYgzFAFGBGM=;
	b=ah5A57K1UlPIA3NIsSUvOyfI+vZtHe+Tk4mdnEZGaUgbXb7at3ga4mv9ZI4760NUIo0AnA93txwcf1y65THKiDMChKHn1NanKnI8YkAqTcr8I0QgXjVp8Y6wulw0c4osEBpTZQhBkKpnnHD/i7O0xc9FA0BksM+VKW7j0Fepv3g=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.51.208) by
	VI1PR04MB5981.eurprd04.prod.outlook.com (20.178.123.156) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2387.22; Mon, 28 Oct 2019 10:55:05 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
	([fe80::10f0:af2c:76ac:dfb]) by VI1PR04MB5134.eurprd04.prod.outlook.com
	([fe80::10f0:af2c:76ac:dfb%7]) with mapi id 15.20.2387.025;
	Mon, 28 Oct 2019 10:55:05 +0000
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Jonathan Lemon <jlemon@flugsvamp.com>
Subject: Re: [PATCH v2 3/3] dpaa2_eth: use new unmap and sync dma api variants
Thread-Topic: [PATCH v2 3/3] dpaa2_eth: use new unmap and sync dma api variants
Thread-Index: AQHVimhlfWE0TvO4OUun0YFZridDXqdriR2AgAReYAA=
Date: Mon, 28 Oct 2019 10:55:05 +0000
Message-ID: <00a138f0-3651-5441-7241-5f02956b6c2c@nxp.com>
References: <20191024124130.16871-1-laurentiu.tudor@nxp.com>
	<20191024124130.16871-4-laurentiu.tudor@nxp.com>
	<BC2F1623-D8A5-4A6E-BAF4-5C551637E472@flugsvamp.com>
In-Reply-To: <BC2F1623-D8A5-4A6E-BAF4-5C551637E472@flugsvamp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 03a6b461-5073-4961-cf4a-08d75b954a6e
x-ms-traffictypediagnostic: VI1PR04MB5981:|VI1PR04MB5981:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5981AA86C32E51F252BC80D3EC660@VI1PR04MB5981.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(189003)(199004)(31696002)(3846002)(66066001)(81166006)(6116002)(8936002)(316002)(54906003)(31686004)(44832011)(53546011)(486006)(229853002)(256004)(14444005)(71190400001)(71200400001)(6916009)(6486002)(11346002)(8676002)(2616005)(86362001)(476003)(446003)(6436002)(6246003)(36756003)(81156014)(7736002)(305945005)(91956017)(76116006)(66446008)(66476007)(66946007)(186003)(4326008)(76176011)(26005)(99286004)(64756008)(5660300002)(102836004)(2906002)(6506007)(478600001)(14454004)(25786009)(66556008)(6512007);
	DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5981;
	H:VI1PR04MB5134.eurprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jov9wT66gBEv7WqWyx3HQuBwX+yXmZnVlvxbOp5lN/ywqbbi6k3mrb6vr9/T22WvW7rVAflCjKChtmrBFS6AA+ulZy75zBKPErkzybdBMTmxXter0L79ajQygSbEq1f3xg7S4ktPux6uDbrFs7Z43no1/qeIrkH4YNKwXloyiMwUpSVDZCpr1154Jzm9wRxiAOKA5fJaxKqiohmzHbcAvQq5zWMspgBWGcBdOb+xdg6expG4ETjpYe4vHd9/5ASkPcdbyRcxMlPMjbFZifYf7BdAtcc2b+9ukmdgauHdWJimaI9IJHJ4DNV49cFnfJKmHNT5/y7YTnWYyb8ccs/ecjrAvwTv3fgqx06dxcQByEfHxIJYR3Qt2Ne/JLIO8oW7j4k9p5oxgwUr4ZJQftKsEjm6p1pI8BZXzRwIfeXDy21l3xm4KpYUQqtThRkBpD7O
Content-ID: <B58BF4CE90A3DB4CBD062FE16AE002F8@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a6b461-5073-4961-cf4a-08d75b954a6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 10:55:05.1636 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4kbD8NQCxsq5oVdPWsFpwKf0xUnYb7MVwI8A8A5wV0PK5rWIdXx22W+JDOs+zIMvc+N41vRA4hgQ1WU05DeVUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5981
Cc: Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Leo Li <leoyang.li@nxp.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

SGkgSm9uYXRoYW4sDQoNCk9uIDI1LjEwLjIwMTkgMTk6MTIsIEpvbmF0aGFuIExlbW9uIHdyb3Rl
Og0KPiANCj4gDQo+IE9uIDI0IE9jdCAyMDE5LCBhdCA1OjQxLCBMYXVyZW50aXUgVHVkb3Igd3Jv
dGU6DQo+IA0KPj4gRnJvbTogTGF1cmVudGl1IFR1ZG9yIDxsYXVyZW50aXUudHVkb3JAbnhwLmNv
bT4NCj4+DQo+PiBDb252ZXJ0IHRoaXMgZHJpdmVyIHRvIHVzYWdlIG9mIHRoZSBuZXdseSBpbnRy
b2R1Y2VkIGRtYSB1bm1hcCBhbmQNCj4+IHN5bmMgRE1BIEFQSXMuIFRoaXMgd2lsbCBnZXQgcmlk
IG9mIHRoZSB1bnN1cHBvcnRlZCBkaXJlY3QgdXNhZ2Ugb2YNCj4+IGlvbW11X2lvdmFfdG9fcGh5
cygpIEFQSS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBMYXVyZW50aXUgVHVkb3IgPGxhdXJlbnRp
dS50dWRvckBueHAuY29tPg0KPj4gLS0tDQo+PiDCoC4uLi9uZXQvZXRoZXJuZXQvZnJlZXNjYWxl
L2RwYWEyL2RwYWEyLWV0aC5jwqAgfCA0MCArKysrKysrLS0tLS0tLS0tLS0tDQo+PiDCoC4uLi9u
ZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2RwYWEyL2RwYWEyLWV0aC5owqAgfMKgIDEgLQ0KPj4gwqAy
IGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDI2IGRlbGV0aW9ucygtKQ0KPj4NCj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZHBhYTIvZHBhYTIt
ZXRoLmMgDQo+PiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9kcGFhMi9kcGFhMi1l
dGguYw0KPj4gaW5kZXggMTkzNzliYWUwMTQ0Li44YzMzOTFlNmU1OTggMTAwNjQ0DQo+PiAtLS0g
YS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZHBhYTIvZHBhYTItZXRoLmMNCj4+ICsr
KyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9kcGFhMi9kcGFhMi1ldGguYw0KPj4g
QEAgLTI5LDE2ICsyOSw2IEBAIE1PRFVMRV9MSUNFTlNFKCJEdWFsIEJTRC9HUEwiKTsNCj4+IMKg
TU9EVUxFX0FVVEhPUigiRnJlZXNjYWxlIFNlbWljb25kdWN0b3IsIEluYyIpOw0KPj4gwqBNT0RV
TEVfREVTQ1JJUFRJT04oIkZyZWVzY2FsZSBEUEFBMiBFdGhlcm5ldCBEcml2ZXIiKTsNCj4+DQo+
PiAtc3RhdGljIHZvaWQgKmRwYWEyX2lvdmFfdG9fdmlydChzdHJ1Y3QgaW9tbXVfZG9tYWluICpk
b21haW4sDQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRtYV9hZGRyX3QgaW92
YV9hZGRyKQ0KPj4gLXsNCj4+IC3CoMKgwqAgcGh5c19hZGRyX3QgcGh5c19hZGRyOw0KPj4gLQ0K
Pj4gLcKgwqDCoCBwaHlzX2FkZHIgPSBkb21haW4gPyBpb21tdV9pb3ZhX3RvX3BoeXMoZG9tYWlu
LCBpb3ZhX2FkZHIpIDogDQo+PiBpb3ZhX2FkZHI7DQo+PiAtDQo+PiAtwqDCoMKgIHJldHVybiBw
aHlzX3RvX3ZpcnQocGh5c19hZGRyKTsNCj4+IC19DQo+PiAtDQo+PiDCoHN0YXRpYyB2b2lkIHZh
bGlkYXRlX3J4X2NzdW0oc3RydWN0IGRwYWEyX2V0aF9wcml2ICpwcml2LA0KPj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1MzIgZmRfc3RhdHVzLA0KPj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQ0KPj4gQEAgLTg1LDkg
Kzc1LDEwIEBAIHN0YXRpYyB2b2lkIGZyZWVfcnhfZmQoc3RydWN0IGRwYWEyX2V0aF9wcml2ICpw
cml2LA0KPj4gwqDCoMKgwqAgc2d0ID0gdmFkZHIgKyBkcGFhMl9mZF9nZXRfb2Zmc2V0KGZkKTsN
Cj4+IMKgwqDCoMKgIGZvciAoaSA9IDE7IGkgPCBEUEFBMl9FVEhfTUFYX1NHX0VOVFJJRVM7IGkr
Kykgew0KPj4gwqDCoMKgwqDCoMKgwqDCoCBhZGRyID0gZHBhYTJfc2dfZ2V0X2FkZHIoJnNndFtp
XSk7DQo+PiAtwqDCoMKgwqDCoMKgwqAgc2dfdmFkZHIgPSBkcGFhMl9pb3ZhX3RvX3ZpcnQocHJp
di0+aW9tbXVfZG9tYWluLCBhZGRyKTsNCj4+IC3CoMKgwqDCoMKgwqDCoCBkbWFfdW5tYXBfcGFn
ZShkZXYsIGFkZHIsIERQQUEyX0VUSF9SWF9CVUZfU0laRSwNCj4+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgRE1BX0JJRElSRUNUSU9OQUwpOw0KPj4gK8KgwqDCoMKgwqDC
oMKgIHNnX3ZhZGRyID0gcGFnZV90b192aXJ0DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIChkbWFfdW5tYXBfcGFnZV9kZXNjKGRldiwgYWRkciwNCj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgRFBBQTJfRVRIX1JYX0JV
Rl9TSVpFLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBETUFfQklESVJFQ1RJT05BTCkpOw0KPiANCj4gVGhpcyBpcyBkb2luZyB2aXJ0
IC0+IHBhZ2UgLT4gdmlydC7CoCBXaHkgbm90IGp1c3QgaGF2ZSB0aGUgbmV3DQo+IGZ1bmN0aW9u
IHJldHVybiB0aGUgVkEgY29ycmVzcG9uZGluZyB0byB0aGUgYWRkciwgd2hpY2ggd291bGQNCj4g
bWF0Y2ggdGhlIG90aGVyIGZ1bmN0aW9ucz8NCg0KSSdkIHJlYWxseSBsaWtlIHRoYXQgYXMgaXQg
d291bGQgZ2V0IHJpZCBvZiB0aGUgcGFnZV90b192aXJ0KCkgY2FsbHMgYnV0IA0KaXQgd2lsbCBi
cmVhayB0aGUgc3ltbWV0cnkgd2l0aCB0aGUgZG1hX21hcF9wYWdlKCkgQVBJLiBJJ2xsIGxldCB0
aGUgDQptYWludGFpbmVycyBkZWNpZGUuDQoNCi0tLQ0KQmVzdCBSZWdhcmRzLCBMYXVyZW50aXUK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFp
bGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
