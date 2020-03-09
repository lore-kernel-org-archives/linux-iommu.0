Return-Path: <SRS0=J+1i=42=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773D4C10F27
	for <iommu@archiver.kernel.org>; Mon,  9 Mar 2020 14:45:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BD2521655
	for <iommu@archiver.kernel.org>; Mon,  9 Mar 2020 14:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=allegrodvt.com header.i=@allegrodvt.com header.b="kKsrHyU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD2521655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=allegrodvt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 157AA8836D;
	Mon,  9 Mar 2020 14:45:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DStW8cqVt9sV; Mon,  9 Mar 2020 14:45:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 25D7188366;
	Mon,  9 Mar 2020 14:45:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0437FC18D3;
	Mon,  9 Mar 2020 14:45:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96B43C0177
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 14:45:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8578184E7A
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 14:45:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BSx0klKdD5bz for <iommu@lists.linux-foundation.org>;
 Mon,  9 Mar 2020 14:45:23 +0000 (UTC)
X-Greylist: delayed 03:28:06 by SQLgrey-1.7.6
Received: from FRA01-MR2-obe.outbound.protection.outlook.com
 (mail-eopbgr90113.outbound.protection.outlook.com [40.107.9.113])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6689084518
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 14:45:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILC8UE8VPIyeC5eOyCbCgmQGh0qPZ6TFFfxvNQ7iqdMBuP01oUwlzCntfknv8s0Enxniu2Z6yDpC5GeHIBe1Hlp+cc1+U1VuAu+Lj7dWlsslR98Ev7FCg12pEr7lTa8pEBCrn5/8AQOkCSZPjP9ahLPT05IAaPzCm/2ClHqLXlGQCM7JF2CGNW2I4gRyaqcQr1yTkAphSPwO+5MoLfi7zG1Nl4mFlsZibh+wRdYsbxhpq1vHEGoRAJfXJB8GDoFB1e0xokY1plYBIhTvTDuiiQtdiXXUETChf1u3wSjUlSLiTGg380jLbn+Sm7y5MMYQ8yHi++rgjo+Lv2BsbfST8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KLoTfc+V3TKSeUD6zF9KG2h2YkzN0zOdFCRIdoters=;
 b=M2fuuH4xQQIl9OaP+VBFw5C0lVdKyHwNahcT0DRahgJFOeNGfLnC9R+/aQvitbY9JFiMfnjY4+m9CPcYyQH++nNvCEUlexlCXgi0QHv5hzhrhxGqWq8Dishobuy/cxYc0EjEvdQSUV/dvjB5n1GP+QQ/m3LCnnPiBI6FlS+UwkiG/4h5Eyn3ftmjrzp4/zxu6PNOZezN3fxq1S5lesF5vp75nqifX/XkY6NxBsN53sC1Vci56NKvj7sZGbjjiQ9UajDDB+vkxsY0ILGnwi8g6d7N0ZMPfvuuJ67JLHntObpEtMzePslQcIwVSyye6qmfY8VRxH9z2Nj8/o7vV3kGlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=allegrodvt.com; dmarc=pass action=none
 header.from=allegrodvt.com; dkim=pass header.d=allegrodvt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=allegrodvt.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KLoTfc+V3TKSeUD6zF9KG2h2YkzN0zOdFCRIdoters=;
 b=kKsrHyU3XYWQZcaKuZPRi08UrrO6s/tgQnaPoT6HxP+MPJdUsRarRaeDdDtFIaSdbIjGl9bi3NIO3eUc5YparcF3xwDb4rrvUxaXxqbOYbOqMzygsoUd/B9iZwvYozML8zKwzOphc+Oi7BUZtIclNfFVpz6bL0yFUqwDMhqmTWkeJQpNN8wPOPdkomrA6Sm762SkLRGPMaVILpoR1SfebV/PClHCqQrgOWIqzJdlm4ilCUuTvlU2V0sv3Nia1wbHgmaaBWao7UabAXDinrKbX6U0vymaWzevlxjKgBu2tLmUqiPahF1h2A/RgIZ+JHCQFMajVHqvTXAg/iyk2EYObg==
Received: from MRXP264MB0584.FRAP264.PROD.OUTLOOK.COM (52.134.49.145) by
 MRXP264MB0376.FRAP264.PROD.OUTLOOK.COM (52.134.47.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Mon, 9 Mar 2020 14:45:18 +0000
Received: from MRXP264MB0584.FRAP264.PROD.OUTLOOK.COM
 ([fe80::84af:fd44:26b8:7b02]) by MRXP264MB0584.FRAP264.PROD.OUTLOOK.COM
 ([fe80::84af:fd44:26b8:7b02%5]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 14:45:18 +0000
Received: from [10.3.4.135] (185.223.150.134) by
 PR0P264CA0150.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.14 via Frontend Transport; Mon, 9 Mar 2020 14:45:18 +0000
From: Kevin Grandemange <kevin.grandemange@allegrodvt.com>
To: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] [dma-coherent] Fix integer overflow in the
 reserved-memory dma allocation
Thread-Topic: [PATCH] [dma-coherent] Fix integer overflow in the
 reserved-memory dma allocation
Thread-Index: AQHV9gIojfo28FidqUKDX3pC8DIbLw==
Date: Mon, 9 Mar 2020 14:45:18 +0000
Message-ID: <0adce967-71cc-ebf4-1a7e-adfacc5d46a6@allegrodvt.com>
References: <20200309110134.7672-1-kevin.grandemange@allegrodvt.com>
 <6b2b656c-33ee-4e02-e687-c71ff43de584@arm.com>
In-Reply-To: <6b2b656c-33ee-4e02-e687-c71ff43de584@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0150.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1b::18) To MRXP264MB0584.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:23::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kevin.grandemange@allegrodvt.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.223.150.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee77f655-f5f2-40d7-9564-08d7c4387cc6
x-ms-traffictypediagnostic: MRXP264MB0376:
x-microsoft-antispam-prvs: <MRXP264MB03760CADF842BA9872C4B32587FE0@MRXP264MB0376.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0337AFFE9A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39830400003)(366004)(136003)(396003)(376002)(199004)(189003)(31686004)(66946007)(31696002)(6486002)(2906002)(5660300002)(52116002)(508600001)(4326008)(53546011)(71200400001)(316002)(54906003)(110136005)(86362001)(16576012)(66446008)(64756008)(66556008)(66476007)(8936002)(26005)(36756003)(81156014)(956004)(81166006)(186003)(16526019)(44832011)(2616005)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MRXP264MB0376;
 H:MRXP264MB0584.FRAP264.PROD.OUTLOOK.COM; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: allegrodvt.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HptsfFjzIlfs5poX9/A/HCBSK/4sBD6YKTja2r8OAqM5PjY62MJytJy4L7mfjGBczda0DsoTyHebCeOADas312zFsy00gAQKTGmVke+sSAtgM6jAQz2S8z8QZODAasj1lr5mWlADFUcC6Ft7uPDPlvgr+FWpiiXkif/8hPah542Rf3DevfSDMvxtQ159nz6IeSS97cV2zo4BsT3/FEQL6AkaMNBxzl1tfuehgjIJsC3gKjscneqJuy0jAEFhQK142qHacTszVK7McRGfBlfJ8O6t4Tp2sogQsuwEfE13OTfgTJ7M8S65HfkDGGyMHxu9qgSTWGV1SOxCTOLVR9gN79oFmrWk7bRQkWSRDkxAdfNntc7mK7Iib/I8gnHHCsk5/mtwPSAF8t6/oZbAjIVdzgyvu9pU8WvLQNF6bMQeBhUjRejXNrUYmX8y1frAaVlM
x-ms-exchange-antispam-messagedata: IJV8M5mEDR/9rPRphPsLhMIJoTjgMNw51xYs2THwLGDThoFhM2oC/YpasdMq/FRoNW59Zlmptk3dIJVfDkc/avLNsYmqwAnzLeDliB0+lW0ZvRGiUVVIkf2ggjeXlDAr2/clZbEhfi/omoieO9NJFg==
x-ms-exchange-transport-forked: True
Content-ID: <912340ADCA883848A1B9E580567FD46D@FRAP264.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-OriginatorOrg: allegrodvt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee77f655-f5f2-40d7-9564-08d7c4387cc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2020 14:45:18.8065 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6c7a5ec0-2d92-465a-a3e1-9e3f1e9fd917
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fYdY3N9lT7Jy+qX5f7SlXSXVM80eFO8BZgNPR99pDirG8XhJvE6aj4WPtHePGlFFatvztPpKY4SGexstFniCfSXfP4JNnCrvVRVJUoo/whfKIdFq1vs7qiuPGUzsVMJX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRXP264MB0376
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMy85LzIwIDI6NTYgUE0sIFJvYmluIE11cnBoeSB3cm90ZToNCg0KPiBPbiAwOS8wMy8yMDIw
IDExOjAyIGFtLCBLZXZpbiBHcmFuZGVtYW5nZSB3cm90ZToNCj4+IHBhZ2VubyBpcyBhbiBpbnQg
YW5kIHRoZSBQQUdFX1NISUZUIHNoaWZ0IGlzIGRvbmUgb24gYW4gaW50LA0KPj4gb3ZlcmZsb3dp
bmcgaWYgdGhlIG1lbW9yeSBpcyBiaWdnZXIgdGhhbiAyRw0KPj4NCj4+IFRoaXMgY2FuIGJlIHJl
cHJvZHVjZWQgdXNpbmcgZm9yIGV4YW1wbGUgYSByZXNlcnZlZC1tZW1vcnkgb2YgNEcNCj4NCj4g
Tml0OiB0aGUgZXhhbXBsZSBzaG93cyAxNkdCLCBub3QgNC4NCj4NCldpbGwgZml4LiBNeSB1c2Vj
YXNlIGlzIGFuIGV4dGVybmFsIG1lbW9yeSB0aGF0IGNhbiBzcGFuIDE2R0IgLyA0R0IgZGVwZW5k
aW5nIG9uIHRoZSBjb25maWd1cmF0aW9uLg0KPj4gcmVzZXJ2ZWQtbWVtb3J5IHsNCj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgI2FkZHJlc3MtY2VsbHMgPSA8Mj47DQo+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgICNzaXplLWNlbGxzID0gPDI+Ow0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBy
YW5nZXM7DQo+Pg0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXNlcnZlZF9kbWE6IGJ1ZmZl
ckAwIHsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb21wYXRpYmxlID0gInNo
YXJlZC1kbWEtcG9vbCI7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbm8tbWFw
Ow0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlZyA9IDwweDUgMHgwMDAwMDAw
MCAweDQgMHgwPjsNCj4+IMKgwqDCoMKgwqDCoMKgwqAgfTsNCj4+IH07DQo+Pg0KPj4gU2lnbmVk
LW9mZi1ieTogS2V2aW4gR3JhbmRlbWFuZ2UgPGtldmluLmdyYW5kZW1hbmdlQGFsbGVncm9kdnQu
Y29tPg0KPj4gLS0tDQo+PiDCoCBrZXJuZWwvZG1hL2NvaGVyZW50LmMgfCA2ICsrKystLQ0KPj4g
wqAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+DQo+
PiBkaWZmIC0tZ2l0IGEva2VybmVsL2RtYS9jb2hlcmVudC5jIGIva2VybmVsL2RtYS9jb2hlcmVu
dC5jDQo+PiBpbmRleCA1NTFiMGViNzAyOGEuLmMyMGM2YzA2MzViNyAxMDA2NDQNCj4+IC0tLSBh
L2tlcm5lbC9kbWEvY29oZXJlbnQuYw0KPj4gKysrIGIva2VybmVsL2RtYS9jb2hlcmVudC5jDQo+
PiBAQCAtMTMwLDYgKzEzMCw3IEBAIHN0YXRpYyB2b2lkICpfX2RtYV9hbGxvY19mcm9tX2NvaGVy
ZW50KHN0cnVjdCBkZXZpY2UgKmRldiwNCj4+IMKgwqDCoMKgwqAgaW50IG9yZGVyID0gZ2V0X29y
ZGVyKHNpemUpOw0KPj4gwqDCoMKgwqDCoCB1bnNpZ25lZCBsb25nIGZsYWdzOw0KPj4gwqDCoMKg
wqDCoCBpbnQgcGFnZW5vOw0KPj4gK8KgwqDCoCBzc2l6ZV90IG1lbV9vZmZzZXQ7DQo+PiDCoMKg
wqDCoMKgIHZvaWQgKnJldDsNCj4+IMKgIMKgwqDCoMKgwqAgc3Bpbl9sb2NrX2lycXNhdmUoJm1l
bS0+c3BpbmxvY2ssIGZsYWdzKTsNCj4+IEBAIC0xNDQsOCArMTQ1LDkgQEAgc3RhdGljIHZvaWQg
Kl9fZG1hX2FsbG9jX2Zyb21fY29oZXJlbnQoc3RydWN0IGRldmljZSAqZGV2LA0KPj4gwqDCoMKg
wqDCoCAvKg0KPj4gwqDCoMKgwqDCoMKgICogTWVtb3J5IHdhcyBmb3VuZCBpbiB0aGUgY29oZXJl
bnQgYXJlYS4NCj4+IMKgwqDCoMKgwqDCoCAqLw0KPj4gLcKgwqDCoCAqZG1hX2hhbmRsZSA9IGRt
YV9nZXRfZGV2aWNlX2Jhc2UoZGV2LCBtZW0pICsgKHBhZ2VubyA8PCBQQUdFX1NISUZUKTsNCj4+
IC3CoMKgwqAgcmV0ID0gbWVtLT52aXJ0X2Jhc2UgKyAocGFnZW5vIDw8IFBBR0VfU0hJRlQpOw0K
Pj4gK8KgwqDCoCBtZW1fb2Zmc2V0ID0gKHNzaXplX3QpcGFnZW5vIDw8IFBBR0VfU0hJRlQ7DQo+
DQo+IElzbid0IHRoaXMgc3RpbGwgY2FwYWJsZSBvZiBvdmVyZmxvd2luZyBmb3IgMzItYml0IGFy
Y2hpdGVjdHVyZXMgd2hlcmUgc3NpemVfdCBpcyBtb3N0IGxpa2VseSB0byBiZSBsb25nIGFuZCBM
T05HX01BWCA9PSBJTlRfTUFYIChiZWZvcmUgd2UgZXZlbiBnZXQgdG8gUEFFIGFuZCBmcmllbmRz
KT8gTG9naWNhbGx5LCBkbWFfYWRkcl90IHdvdWxkIGJlIHRoZSBtb3N0IGFwcHJvcHJpYXRlIHR5
cGUgaGVyZS4NCg0KWW91IGFyZSByaWdodCwgSSB3YXMgb25seSB0aGlua2luZyBpbiBteSB1c2Vj
YXNlIChhcm02NCkgYW5kIHdyb25nbHkgYXNzdW1pbmcgc3NpemVfdCBoYWQgdGhlIHNhbWUgcHJv
cGVydGllcyBhcyBzaXplX3QuDQoNCkkgd2lsbCBjaGFuZ2UgdGhhdCB0byBkbWFfYWRkcl90Lg0K
DQo+DQo+IEZXSVcgc2luY2UgeW91IGhhdmUgdG8gaGF2ZSBhbiBleHBsaWNpdCBjYXN0IGVpdGhl
ciB3YXksIEkgZG9uJ3Qgc2VlIG11Y2ggcG9pbnQgaW4gaW50cm9kdWNpbmcgdGhlIGxvY2FsIHZh
cmlhYmxlIHZzLiBqdXN0IGFkZGluZyB0aGUgY2FzdCBpbnRvIHRoZSBleGlzdGluZyBleHByZXNz
aW9uLg0KVGhlIGxvY2FsIHZhcmlhYmxlIHdhcyBqdXN0IGZvciBjaGVja3BhdGNoLnBsIGxpbmUg
bGVuZ3RoIGNoZWNrLCBJIGFncmVlIHdpdGggeW91LCBpdCBkb2Vzbid0IGFkZCBtdWNoLg0KPg0K
PiBUaGFua3MsDQo+IFJvYmluLg0KPg0KPj4gK8KgwqDCoCAqZG1hX2hhbmRsZSA9IGRtYV9nZXRf
ZGV2aWNlX2Jhc2UoZGV2LCBtZW0pICsgbWVtX29mZnNldDsNCj4+ICvCoMKgwqAgcmV0ID0gbWVt
LT52aXJ0X2Jhc2UgKyBtZW1fb2Zmc2V0Ow0KPj4gwqDCoMKgwqDCoCBzcGluX3VubG9ja19pcnFy
ZXN0b3JlKCZtZW0tPnNwaW5sb2NrLCBmbGFncyk7DQo+PiDCoMKgwqDCoMKgIG1lbXNldChyZXQs
IDAsIHNpemUpOw0KPj4gwqDCoMKgwqDCoCByZXR1cm4gcmV0Ow0KPj4NCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
