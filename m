Return-Path: <SRS0=3N47=YS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB5ACA9EA0
	for <iommu@archiver.kernel.org>; Fri, 25 Oct 2019 08:09:43 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E205206DD
	for <iommu@archiver.kernel.org>; Fri, 25 Oct 2019 08:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LXIEHDUQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E205206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C3528DD8;
	Fri, 25 Oct 2019 08:09:42 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 78E60DB1
	for <iommu@lists.linux-foundation.org>;
	Fri, 25 Oct 2019 08:09:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from APC01-PU1-obe.outbound.protection.outlook.com
	(mail-eopbgr1320101.outbound.protection.outlook.com [40.107.132.101])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 96E9C14D
	for <iommu@lists.linux-foundation.org>;
	Fri, 25 Oct 2019 08:09:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=aiJMZzB/GvjSZjJo5mt+9otVYd1KGkcuZthNeiGfWoTUIJTNw7okKwAH3lPgWuK/t0pUgCH/QtIZqTKcmttoJKZoqabm/6zpUhKTNV2cimry6TK5S5bcq25H2Ig+1Gf2OuDyQkrL8tSUG+h9cIip1LwyAE0z8bEbSTrzHOjl5nsmVB83FsuVN4fRqZCrv4e8/Od0T+MOXsBNWFXTiYC5jqC6Rx90451qUO0ndCUvSvnMkWp+iq0DwoWnsfXXIa2Uq2CcreBhY/Jk0gr4F4HLLWZRa/DOnvlufb6MJYbnlMif5CpHVyx/6I6hmzO+Ite7VHXFFYEVmEmqamygLjQldg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=aJzPMvF3gNhEod7hSUTXjtiYmM1Q5WpgV+lbnuyqDNY=;
	b=g6X2uQzpR3cLDjSDFW6YyRFfo/Rt87dIp2pwAI+88DkRJp8FwjC6EsMZpevxx/MRt+UK7XFvp9yT8MK7OeFyu5COnIVuh4XDDcJregHbN1fkSEjPbXls5VQQxbg/tnwAISO/9pnwjP1kXACOqeHKPD6qNw432oQH0m9TolG0kj8L+pFTSBYAD7N+QUhdDHZtZO5O2YJWK8ni9yu3Y/LEkFFSl3YXBIeIp4t5vqI2eVv+9k9ERRXF0VNhYCz0xAShQtJldY+jc87N5ukCoEbWDO7e4WH1ESH4VU00POK7Oowe3MN4PbVs8KcR//bt4Ju+VXDaLUvx/Kh93jcZ1uZBrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=microsoft.com; dmarc=pass action=none
	header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=aJzPMvF3gNhEod7hSUTXjtiYmM1Q5WpgV+lbnuyqDNY=;
	b=LXIEHDUQ2P19C8CToq7fg+qkkwRoBCWJP7Hb/5ZzKrSVMcKd2+pZjJsVmKWXmkUeG3dysTFeekH8FAmjObAMQ6Wig+UaIe3K+1cNWdEe2XHWCjWhcyRUvzuDiBV9Lj6ZYwRP1UvX7Y1F2Ebkr7hT3UXjjbHOvFlCSYITzLG8Vk4=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
	PU1P153MB0188.APCP153.PROD.OUTLOOK.COM (10.170.190.17) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2408.8; Fri, 25 Oct 2019 08:09:35 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
	([fe80::69f1:c9:209a:1809]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
	([fe80::69f1:c9:209a:1809%2]) with mapi id 15.20.2408.008;
	Fri, 25 Oct 2019 08:09:35 +0000
To: "hch@lst.de" <hch@lst.de>
Subject: RE: [PATCH] video: hyperv: hyperv_fb: Use physical memory for fb on
	HyperV Gen 1 VMs.
Thread-Topic: [PATCH] video: hyperv: hyperv_fb: Use physical memory for fb on
	HyperV Gen 1 VMs.
Thread-Index: AQHViMlWrXYtpApox02C+wFzOSr7Mqdn8eSAgAMRNnA=
Date: Fri, 25 Oct 2019 08:09:34 +0000
Message-ID: <PU1P153MB0169EA21993B5893EA7569FABB650@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <20191022110905.4032-1-weh@microsoft.com>
	<20191023091037.GB21910@lst.de>
In-Reply-To: <20191023091037.GB21910@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=weh@microsoft.com; 
x-originating-ip: [167.220.255.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 24ff4c23-8138-4d29-1133-08d75922ac57
x-ms-traffictypediagnostic: PU1P153MB0188:|PU1P153MB0188:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB018872C43B734F3DB492815FBB650@PU1P153MB0188.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(4636009)(346002)(39860400002)(396003)(136003)(366004)(376002)(51914003)(199004)(189003)(76116006)(102836004)(5640700003)(6436002)(25786009)(7416002)(10090500001)(8936002)(14444005)(486006)(81156014)(256004)(1730700003)(7696005)(2351001)(81166006)(9686003)(86362001)(66066001)(71190400001)(71200400001)(66574012)(66946007)(2906002)(55016002)(66446008)(64756008)(66556008)(66476007)(11346002)(52536014)(8990500004)(446003)(478600001)(10290500003)(14454004)(26005)(186003)(305945005)(99286004)(74316002)(2501003)(229853002)(476003)(33656002)(6506007)(107886003)(316002)(22452003)(76176011)(8676002)(6246003)(6916009)(7736002)(54906003)(3846002)(6116002)(4326008)(5660300002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:PU1P153MB0188;
	H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /iVAauybsTTLeGIrJTQszPrZF3AtTH8Z3g5fIz+CkmEnunQW13rdjgmmOhHbzX0/EZkepskwm7wQUtmYfQjtmqPqih8uC6V82NhFju+p3GK6XEUOwnoQSzwyANhNBkY6EIeXBJzRZooc4qyy/hZYAG3kVlXC+kCEkOfHCNQ2Qzz+l+TzmxpEjvpv/k+h7gJoGS4i0eejdHCCB9THaS7lpIxFCOU6ENpE4TP/m9vdIQpq9dS4D0Z9dWTRjskFx2DSRvL4yJAqqB9ck1KwSBqOuWLKNpK1BI7ZT0wsVDkMxBUUXT+XE6+s9d+eWXf1wHGGC/woNSAzjcHhTHyvct3n0jI7eQOk2CplNoHJni3l94EayPwE9akEzIkdjdhJSlGofB1Dix5fKrAyzUn9bQLLsLJgA/o2y801v71yDJewMds2hrNNHnXKzcHAyCrTnOeh
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ff4c23-8138-4d29-1133-08d75922ac57
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 08:09:34.6214 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AM2+s/rTgmL476ZEDBm5/8pDQ90Zon6rChg++pasIBno+z+MAqxmoD5Y7H/4zSfG0HwtlahD42i8IA7ysZGQwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0188
Cc: "sashal@kernel.org" <sashal@kernel.org>, "info@metux.net" <info@metux.net>,
	"alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	Stephen Hemminger <sthemmin@microsoft.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>,
	"sam@ravnborg.org" <sam@ravnborg.org>,
	Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	Michael Kelley <mikelley@microsoft.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
	KY Srinivasan <kys@microsoft.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>
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
From: Wei Hu via iommu <iommu@lists.linux-foundation.org>
Reply-To: Wei Hu <weh@microsoft.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

VGhhbmtzIGZvciB0aGUgcmV2aWV3LiBQbGVhc2Ugc2VlIG15IHJlc3BvbnNlIGlubGluZS4NCg0K
PiA+ICsJc2VsZWN0IERNQV9DTUENCj4gDQo+IFRo0ZZzIG5lZWRzIHRvIGJlDQo+IA0KPiAJc2Vs
ZWN0IERNQV9DTUEgaWYgSEFWRV9ETUFfQ09OVElHVU9VUw0KPiANCj4gPiArI2luY2x1ZGUgPGxp
bnV4L2RtYS1jb250aWd1b3VzLmg+DQo+IA0KPiA+ICsJLyogQWxsb2NhdGUgZnJvbSBDTUEgKi8N
Cj4gPiArCS8vIHJlcXVlc3RfcGFnZXMgPSAocmVxdWVzdF9zaXplID4+IFBBR0VfU0hJRlQpICsg
MTsNCj4gPiArCXJlcXVlc3RfcGFnZXMgPSAocm91bmRfdXAocmVxdWVzdF9zaXplLCBQQUdFX1NJ
WkUpID4+IFBBR0VfU0hJRlQpOw0KPiA+ICsJcGFnZSA9IGRtYV9hbGxvY19mcm9tX2NvbnRpZ3Vv
dXMoTlVMTCwgcmVxdWVzdF9wYWdlcywgMCwgZmFsc2UpOw0KPiANCj4gZG1hX2FsbG9jX2Zyb21f
Y29udGlndW91cyBpcyBhbiBpbnRlcm5hbCBoZWxwZXIsIHlvdSBtdXN0IHVzZSBpdA0KPiB0aHJv
dWdoIGRtYV9hbGxvY19jb2hlcmVudCBhbmQgcGFzcyBhIHN0cnVjdCBkZXZpY2UgdG8gdGhhdCBm
dW5jdGlvbi4NCj4gDQoNCkNhbiBJIGRpcmVjdGx5IHVzZSBjbWFfYWxsb2MoKSBhbmQgY21hX3Jl
bGVhc2UoKSBpbiB0aGlzIGNhc2U/IFRoZSBjb250aWd1b3VzDQptZW1vcnkgYWxsb2NhdGVkIGlz
IGp1c3QgZm9yIHZpcnR1YWwgZnJhbWVidWZmZXIgZGV2aWNlLCBub3QgZm9yIGFueSBETUENCm9w
ZXJhdGlvbi4gSSB0aGluayB1c2luZyBkbWFfYWxsb2NfY29oZXJlbnQoKSBtaWdodCBiZSBhIGJp
dCBvZiBvdmVya2lsbC4NCg0KPiA+ICsJaWYgKCFnZW4ydm0pIHsNCj4gPiArCQlwZGV2ID0gcGNp
X2dldF9kZXZpY2UoUENJX1ZFTkRPUl9JRF9NSUNST1NPRlQsDQo+ID4gKwkJCVBDSV9ERVZJQ0Vf
SURfSFlQRVJWX1ZJREVPLCBOVUxMKTsNCj4gPiArCQlpZiAoIXBkZXYpIHsNCj4gPiArCQkJcHJf
ZXJyKCJVbmFibGUgdG8gZmluZCBQQ0kgSHlwZXItViB2aWRlb1xuIik7DQo+ID4gKwkJCXJldHVy
biAtRU5PREVWOw0KPiA+ICsJCX0NCj4gPiArCX0NCj4gDQo+IFBsZWFzZSBhY3R1YWxseSBpbXBs
ZW1lbnQgYSBwY2lfZHJpdmVyIGluc3RlYWQgb2YgaGFja3MgbGlrZSB0aGlzLg0KPiANCg0KSSBk
b24ndCBxdWl0ZSBmb2xsb3cgdGhpcy4gV2hhdCBkbyB5b3UgbWVhbiBpbXBsZW1lbnRpbmcgYSBw
Y2lfZHJpdmVyDQppbiB0aGlzIGNhc2U/DQoNCj4gPiArCQkJcGFyLT5uZWVkX2RvY29weSA9IGZh
bHNlOw0KPiA+ICsJCQlnb3RvIGdldG1lbTE7DQo+ID4gKwkJfSBlbHNlIHsNCj4gDQo+IE5vIG5l
ZWQgZm9yIGFuIGVsc2UgYWZ0ZXIgYSBnb3RvLg0KVGhhbmtzLiBXaWxsIGRvLg0KDQpXZWkNCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxp
bmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
