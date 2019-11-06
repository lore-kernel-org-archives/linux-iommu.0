Return-Path: <SRS0=/wjm=Y6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C946C5DF62
	for <iommu@archiver.kernel.org>; Wed,  6 Nov 2019 11:18:05 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C40B52077C
	for <iommu@archiver.kernel.org>; Wed,  6 Nov 2019 11:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DI7xPu6Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C40B52077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 80AD0B09;
	Wed,  6 Nov 2019 11:18:04 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6BB6DAEF
	for <iommu@lists.linux-foundation.org>;
	Wed,  6 Nov 2019 11:18:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
	(mail-eopbgr60087.outbound.protection.outlook.com [40.107.6.87])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 883B1196
	for <iommu@lists.linux-foundation.org>;
	Wed,  6 Nov 2019 11:18:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=J+WQV49wqDTkBCpHccgc15RrHGs2AqmFbOwfvB0nHDBYG+4wxY3uyc/W11xJ4pIUaj7a+kcmPD3oBawW/FNDvE5SF81R97/wJBfeBGeFC75Z6pYhGnQmkbVYQpOraliHwifPUf2PP/li2JITEv1omMw2NCb28eyrF0w/xkhYRRrrbIlL98B+IkC2jz1V7IkkoEDCIT9K39FPZIT9dMqTD9l0fuNAzz26/br0thmkez+Fr2BNpIo1+EeE0BdH5EpOiOTI0XImHO49ynhlpHWB5MgbUpuWO4NHwcvLm98UYp/TSLhNHfVQ1WHEYe5O6qlOIxFLuVF9A+++QcjSiJtvGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=xORQp9rJxfWywzdeoxfH2dD41fhMmfUkr/fTR1zeNBw=;
	b=LNvrSr0uX28rQLdRN0mTOdWIMJ7XV3G/uAwgT54XytRd71P9mvqsvEhxUi07GS5e7ah/XVXVqJuG6bo7hRCywnRobCvUOSCbnk1yGS7IFmQ1fP9wC0UhaQScg2EPCJV3K4WG+U9D/RHN/ATHGx0aO//A5GIf15diT88drr/WJMNFVjNOjge1Laa/JHR+WLSp6J4DeE7QvenN9QDuQcMsQiktsqKM3j+8LI370Qq62yQtwdJ0aCHQ0gXY8KUguzeX7b8MiI6JvGq6BsbBKzB8MeF0p+eZV93RZ7HoAc4DIrR9TsN2p3LtuE7lZAueBhND7h7NHFJCq5G6Ouf8XkF4/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com;
	dkim=pass header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=xORQp9rJxfWywzdeoxfH2dD41fhMmfUkr/fTR1zeNBw=;
	b=DI7xPu6YADDit3uE96/yPdx+Atd/gyhLy8D0+I0F8VCJPt6AJ7F1G5KVo0q8/7V2lHSKlo16XGYbARAHu+7Xm6pyoaX569tNb5jWzmCCjdlFIZ8P82SUsi6vXV+sDVHsJ50OAPSbV05WpIaYVD4BWIxMkfCkREh+BrYmIokanXY=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.51.208) by
	VI1PR04MB5182.eurprd04.prod.outlook.com (20.177.48.202) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2408.24; Wed, 6 Nov 2019 11:17:58 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
	([fe80::10f0:af2c:76ac:dfb]) by VI1PR04MB5134.eurprd04.prod.outlook.com
	([fe80::10f0:af2c:76ac:dfb%7]) with mapi id 15.20.2408.024;
	Wed, 6 Nov 2019 11:17:58 +0000
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH v2 3/3] dpaa2_eth: use new unmap and sync dma api variants
Thread-Topic: [PATCH v2 3/3] dpaa2_eth: use new unmap and sync dma api variants
Thread-Index: AQHVimhlfWE0TvO4OUun0YFZridDXqdriR2AgAReYACAAAwSAIAOH06A
Date: Wed, 6 Nov 2019 11:17:58 +0000
Message-ID: <ffd585c3-3808-5083-ec98-bc2fc44d34ef@nxp.com>
References: <20191024124130.16871-1-laurentiu.tudor@nxp.com>
	<20191024124130.16871-4-laurentiu.tudor@nxp.com>
	<BC2F1623-D8A5-4A6E-BAF4-5C551637E472@flugsvamp.com>
	<00a138f0-3651-5441-7241-5f02956b6c2c@nxp.com>
	<20191028113816.GB24055@lst.de>
In-Reply-To: <20191028113816.GB24055@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bb78f0bf-8f25-4168-7b1d-08d762aafabe
x-ms-traffictypediagnostic: VI1PR04MB5182:|VI1PR04MB5182:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5182B0CA2FDD91F374B3F730EC790@VI1PR04MB5182.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(199004)(189003)(305945005)(6506007)(99286004)(31696002)(229853002)(7736002)(76176011)(2351001)(26005)(36756003)(66066001)(6916009)(256004)(71200400001)(186003)(478600001)(81166006)(8676002)(86362001)(81156014)(102836004)(66556008)(66946007)(14454004)(91956017)(64756008)(66476007)(66446008)(76116006)(5660300002)(11346002)(6116002)(44832011)(53546011)(25786009)(1730700003)(316002)(8936002)(71190400001)(2906002)(6512007)(6246003)(3846002)(2501003)(31686004)(4326008)(6436002)(5640700003)(54906003)(6486002)(486006)(476003)(2616005)(446003);
	DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5182;
	H:VI1PR04MB5134.eurprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SbunjZl5129XMlk7NFADg1gTI6SftWBMRyfxFSzhVoT6sNoa7sMwf/qcGAj5Dzcrnjg2HRRRc0S44oPcXLa9fxUvrVgL8OYTUglk+bf6MAf0QrR+LdBSnwkG17CArfEk7auiO8uLTvIwAaozwTZqHNQp+Dp5wuGiCpyqxw8UTQ6Z6lE+i86aS71SW0nHaH5dgINmAEywUqljodUCAqms3tUhu8vQeXGCqxZIHBjuOwPX2RSfRWY6V+kx2ZWUNnAdE0a4kEkJdK5aW3x2PxsMRDwTR4Wxfwpi2MINlhlt6l2efpBHHn2TQKtmPE8Uwa/aj58u9S6pPQTrgk35KtFY+ewn3UEpszsyRlv4SL/KZsbX7b2bLKJcpiMU0pVy9oUzmkzd7mjpGg4Pcd0lc5JvYEWkULOq3KHGVp/VSO0UUVat8U0Kt0O/5g7lyouWDZZr
Content-ID: <CB7D6165312DE04EAFA8D8B259DDBB0E@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb78f0bf-8f25-4168-7b1d-08d762aafabe
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 11:17:58.6234 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KD1nTC9oY4brBCEB5rnLvqiF8X/1/iA40Z5ThfSDNnoC6oejQDL1WCIF2nWerZwUZ3bBnX+ewJakQubT1+7CtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5182
Cc: Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jonathan Lemon <jlemon@flugsvamp.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>, Leo Li <leoyang.li@nxp.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"davem@davemloft.net" <davem@davemloft.net>
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

DQpPbiAyOC4xMC4yMDE5IDEzOjM4LCBoY2hAbHN0LmRlIHdyb3RlOg0KPiBPbiBNb24sIE9jdCAy
OCwgMjAxOSBhdCAxMDo1NTowNUFNICswMDAwLCBMYXVyZW50aXUgVHVkb3Igd3JvdGU6DQo+Pj4+
IEBAIC04NSw5ICs3NSwxMCBAQCBzdGF0aWMgdm9pZCBmcmVlX3J4X2ZkKHN0cnVjdCBkcGFhMl9l
dGhfcHJpdiAqcHJpdiwNCj4+Pj4gIMKgwqDCoMKgIHNndCA9IHZhZGRyICsgZHBhYTJfZmRfZ2V0
X29mZnNldChmZCk7DQo+Pj4+ICDCoMKgwqDCoCBmb3IgKGkgPSAxOyBpIDwgRFBBQTJfRVRIX01B
WF9TR19FTlRSSUVTOyBpKyspIHsNCj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqAgYWRkciA9IGRwYWEy
X3NnX2dldF9hZGRyKCZzZ3RbaV0pOw0KPj4+PiAtwqDCoMKgwqDCoMKgwqAgc2dfdmFkZHIgPSBk
cGFhMl9pb3ZhX3RvX3ZpcnQocHJpdi0+aW9tbXVfZG9tYWluLCBhZGRyKTsNCj4+Pj4gLcKgwqDC
oMKgwqDCoMKgIGRtYV91bm1hcF9wYWdlKGRldiwgYWRkciwgRFBBQTJfRVRIX1JYX0JVRl9TSVpF
LA0KPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIERNQV9CSURJUkVD
VElPTkFMKTsNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHNnX3ZhZGRyID0gcGFnZV90b192aXJ0DQo+
Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKGRtYV91bm1hcF9wYWdlX2Rlc2Mo
ZGV2LCBhZGRyLA0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIERQQUEyX0VUSF9SWF9CVUZfU0laRSwNCj4+Pj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBETUFfQklESVJFQ1RJ
T05BTCkpOw0KPj4+DQo+Pj4gVGhpcyBpcyBkb2luZyB2aXJ0IC0+IHBhZ2UgLT4gdmlydC7CoCBX
aHkgbm90IGp1c3QgaGF2ZSB0aGUgbmV3DQo+Pj4gZnVuY3Rpb24gcmV0dXJuIHRoZSBWQSBjb3Jy
ZXNwb25kaW5nIHRvIHRoZSBhZGRyLCB3aGljaCB3b3VsZA0KPj4+IG1hdGNoIHRoZSBvdGhlciBm
dW5jdGlvbnM/DQo+Pg0KPj4gSSdkIHJlYWxseSBsaWtlIHRoYXQgYXMgaXQgd291bGQgZ2V0IHJp
ZCBvZiB0aGUgcGFnZV90b192aXJ0KCkgY2FsbHMgYnV0DQo+PiBpdCB3aWxsIGJyZWFrIHRoZSBz
eW1tZXRyeSB3aXRoIHRoZSBkbWFfbWFwX3BhZ2UoKSBBUEkuIEknbGwgbGV0IHRoZQ0KPj4gbWFp
bnRhaW5lcnMgZGVjaWRlLg0KPiANCj4gSXQgd291bGQgYmUgc3ltbWV0cmljIHdpdGggZG1hX21h
cF9zaW5nbGUsIHRob3VnaC4gIE1heWJlIHdlIG5lZWQNCj4gYm90aCB2YXJpYW50cz8NCg0KUGF0
Y2ggMS8zIGFsc28gYWRkcyBhbiBkbWFfdW5tYXBfc2luZ2xlX2Rlc2MoKS4gV291bGQgaXQgYmUg
bGVnYWwgdG8gDQpqdXN0IHVzZSBkbWFfdW5tYXBfc2luZ2xlX2Rlc2MoKSBpbiB0aGUgZHJpdmVy
IGV2ZW4gaWYgdGhlIGRyaXZlciBkb2VzIA0KaXQncyBtYXBwaW5ncyB3aXRoIGRtYV9tYXBfcGFn
ZSgpPw0KDQotLS0NCkJlc3QgUmVnYXJkcywgTGF1cmVudGl1Cl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby9pb21tdQ==
