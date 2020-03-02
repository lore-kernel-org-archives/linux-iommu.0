Return-Path: <SRS0=ZrTS=4T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF78FC3F2D1
	for <iommu@archiver.kernel.org>; Mon,  2 Mar 2020 15:22:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DA5621739
	for <iommu@archiver.kernel.org>; Mon,  2 Mar 2020 15:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HkPpUnCZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DA5621739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1AA3F8624A;
	Mon,  2 Mar 2020 15:22:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TQqNdyWGCbYn; Mon,  2 Mar 2020 15:22:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C9E2D85EB4;
	Mon,  2 Mar 2020 15:22:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B006CC1AE2;
	Mon,  2 Mar 2020 15:22:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE161C013E
 for <iommu@lists.linux-foundation.org>; Mon,  2 Mar 2020 15:21:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id ACEB920425
 for <iommu@lists.linux-foundation.org>; Mon,  2 Mar 2020 15:21:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xKfia8iLnapP for <iommu@lists.linux-foundation.org>;
 Mon,  2 Mar 2020 15:21:56 +0000 (UTC)
X-Greylist: delayed 03:00:32 by SQLgrey-1.7.6
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr150049.outbound.protection.outlook.com [40.107.15.49])
 by silver.osuosl.org (Postfix) with ESMTPS id 51FFF20026
 for <iommu@lists.linux-foundation.org>; Mon,  2 Mar 2020 15:21:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjyWcUrj7bzGOyuJxTeM84B/6+iHBCdOW91u2xfC+F1YLNXtpOvquJa219xNKdTfLN8du9Hn/5zKZDJaiiDMAzSQnuQcaeR4TMaqmNUW/SwAWzTSVyz4Vw4BFvQmFNgkvba3ObSH1DRrRzMilfyMfUk4ah4Qf3+JpiPi7Nc7m9FCBq4NGW/nL8dLXt1T+JZm/uQiwx7QXwobrU9pQ4yMVq3YpWxeapU1ybLOpEdv1yZ1sq8mT+rxTQaagVtb/dUDlbD53UHrZF8xqa2GKh0Si6Er7hcOhOolPsAcMyWUED0qpi35IBTGARuWaMpKkNkApQLURXZxwjleT+Mh8Tr70w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCjDupPiL5HHwIEq5lbIxABKiKU1ja+v+ykkAJkuJvM=;
 b=MUuU5rHLtZkR2Mq6CEHLPpW4x+jd3+2RWCFMAlG7u+Hnfhd8sAkqI7wdlEruXhq+MUjfgyX75p8ehx8OHKRuDRJD7ycVFX1wswxI0jCgfdQ/LP27FNdjVT3C5+Ard/lNKn/jJ6bPOG/TkkV6Nnz31EEv4mUCOwoJm5XIcCMKYjYv6v3Ve1EDeZAsXkHmDVInBp+a6bC5HNOrQjY7xnNyGNsnZjF9URHuXH7YZ3M4py9clqhOtgvu4OEGc6Anfo89FDNpxF4DHrIGYfZHiKgSeuVR3WU0u/bn53vdWwt9XKVhu9AbfgVd+bOqgu0tkyJTGVMVsZWoVYbaApLAREek+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCjDupPiL5HHwIEq5lbIxABKiKU1ja+v+ykkAJkuJvM=;
 b=HkPpUnCZqktvQTSrwBKG/jW1gKq/W2RteIsAUSHRjU1bQOG83u0UMAq3ak6+JfdNVGaezOR0qkUWsup3bo8T6a9DE/TdthW56QXMRLSlTV3V2H4rEyb7i2vqlUjYHdFtYy/IXnwyGY0/t2+niuoh7cZ0z5TrM/5W0FYPf1pznY8=
Received: from AM0PR04MB6897.eurprd04.prod.outlook.com (52.132.213.205) by
 AM0PR04MB6194.eurprd04.prod.outlook.com (20.179.32.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Mon, 2 Mar 2020 11:48:16 +0000
Received: from AM0PR04MB6897.eurprd04.prod.outlook.com
 ([fe80::86e:9e66:998f:9528]) by AM0PR04MB6897.eurprd04.prod.outlook.com
 ([fe80::86e:9e66:998f:9528%7]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 11:48:16 +0000
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Robin Murphy <robin.murphy@arm.com>, Russell King - ARM Linux admin
 <linux@armlinux.org.uk>
Subject: RE: [PATCH] iommu: silence iommu group prints
Thread-Topic: [PATCH] iommu: silence iommu group prints
Thread-Index: AQHV7WYLWV0kZGurOECs6y3RBLC3OKgv30IAgAB6QwCAAAk9AIAAjUEAgARCtmA=
Date: Mon, 2 Mar 2020 11:48:15 +0000
Message-ID: <AM0PR04MB689792D6791F115E535BC585ECE70@AM0PR04MB6897.eurprd04.prod.outlook.com>
References: <E1j7Hnc-0004Bm-Kn@rmk-PC.armlinux.org.uk>
 <f0fc4c8c-4475-e77f-da6d-e068e7993568@linux.intel.com>
 <b4029a97-ac80-484f-9d01-d7f4eb174cdd@huawei.com>
 <20200228100644.GT25745@shell.armlinux.org.uk>
 <95af8fc3-d7b1-3b58-afc1-d203d7538b95@arm.com>
In-Reply-To: <95af8fc3-d7b1-3b58-afc1-d203d7538b95@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [78.96.83.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5956f9b8-83ac-403a-ef64-08d7be9f986c
x-ms-traffictypediagnostic: AM0PR04MB6194:|AM0PR04MB6194:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB61949B25AB0461C1EA906F87ECE70@AM0PR04MB6194.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(189003)(199004)(2906002)(316002)(110136005)(6506007)(4326008)(66476007)(66556008)(64756008)(44832011)(66446008)(53546011)(54906003)(26005)(33656002)(52536014)(71200400001)(86362001)(5660300002)(9686003)(55016002)(76116006)(8936002)(8676002)(81156014)(81166006)(478600001)(66946007)(7696005)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB6194;
 H:AM0PR04MB6897.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 23teYnFGUr5tR6Onje59ZJ4dE1bmj20DJjqzooX3xJc6vLNiVCg6pPnaTWTtnJ13qpfkaOaxWt0ympt2ElfltZ5jZOub4UI7SyHspq2fabsCysf7XwCnEZMpePpV1oY7Th9WAviOE9JcrqBSJ+FQ2jTVoOpq1fAJwBYDlaKjJHEk0u7hTh7Hr3EqxB9eAwxjqzviGiv4c3UhxOYmhlP2FYZrALQ1ZevoHi4JQgRc3I9Q3TaNXRgSg48t6FRU4kAi8cDndNpbjMnqnCJ8J6E0iLZxPTEqFDecZmImm7EIsPIYBwY3MWTOIU1dIt+zJKluQcIEP1hyaFcTKCXx0jmP2vB8Qn1XW0qqD0vf1Ta5J249GwwA1MsCNRGqSj028HU60aCCBe9MqW0vnlz39IZmiQIy0BP8PM1gcxlrrtpW7zVyGB3SjfO37HqpuEwwaT/F
x-ms-exchange-antispam-messagedata: 2lQM51MEc8tRf2rYMw9IdAKBEdBkcA/wetsa6PJLSv4Gc0zEP6fApnUutpIirfnHVyUdtXN2cVqrzrpP7k87K11F1hm30B6R/2loHEr/BkWhyKlQ1hyLZ7Hf/OADs760X9ZsvKcFQ+JK5AECtXxnNQ==
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5956f9b8-83ac-403a-ef64-08d7be9f986c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 11:48:15.9282 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uUHPMGJTS9cDPUhl+JiWf1ypb0/fnxr1lI+qYHqN7/+z2vuUvHSiWh1bv6jsw/2HeuKANHAAlepcmUQjVsForA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6194
Cc: Diana Madalina Craciun <diana.craciun@nxp.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Ioana Ciornei <ioana.ciornei@nxp.com>
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

SGkgUm9iaW4sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iaW4g
TXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4NCj4gU2VudDogRnJpZGF5LCBGZWJydWFyeSAy
OCwgMjAyMCA4OjMyIFBNDQo+IA0KPiBbICtMYXVyZW50aXUgXQ0KPiANCj4gSGkgUnVzc2VsbCwN
Cj4gDQo+IFRoYW5rcyBmb3Igc2hhcmluZyBhIGxvZywgbm93IEkgcHJvcGVybHkgdW5kZXJzdGFu
ZCB3aGF0J3MgdXAuLi4gZnVydGhlcg0KPiBjb21tZW50cyBhdCB0aGUgZW5kIChmb3IgY29udGV4
dCkuDQo+IA0KPiBPbiAyOC8wMi8yMDIwIDEwOjA2IGFtLCBSdXNzZWxsIEtpbmcgLSBBUk0gTGlu
dXggYWRtaW4gd3JvdGU6DQo+ID4gT24gRnJpLCBGZWIgMjgsIDIwMjAgYXQgMDk6MzM6NDBBTSAr
MDAwMCwgSm9obiBHYXJyeSB3cm90ZToNCj4gPj4gT24gMjgvMDIvMjAyMCAwMjoxNiwgTHUgQmFv
bHUgd3JvdGU6DQo+ID4+PiBIaSwNCj4gPj4+DQo+ID4+PiBPbiAyMDIwLzIvMjcgMTk6NTcsIFJ1
c3NlbGwgS2luZyB3cm90ZToNCj4gPj4+PiBPbiB0aGUgTFgyMTYwQSwgdGhlcmUgYXJlIGxvdHMg
KGFib3V0IDE2MCkgb2YgSU9NTVUgbWVzc2FnZXMgcHJvZHVjZWQNCj4gPj4+PiBkdXJpbmcgYm9v
dDsgdGhpcyBpcyBleGNlc3NpdmUuwqAgUmVkdWNlIHRoZSBzZXZlcml0eSBvZiB0aGVzZQ0KPiBt
ZXNzYWdlcw0KPiA+Pj4+IHRvIGRlYnVnIGxldmVsLg0KPiA+Pj4+DQo+ID4+Pj4gU2lnbmVkLW9m
Zi1ieTogUnVzc2VsbCBLaW5nIDxybWsra2VybmVsQGFybWxpbnV4Lm9yZy51az4NCj4gPj4+PiAt
LS0NCj4gPj4+PiAgwqAgZHJpdmVycy9pb21tdS9pb21tdS5jIHwgNCArKy0tDQo+ID4+Pj4gIMKg
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4+Pj4N
Cj4gPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pb21tdS5jIGIvZHJpdmVycy9pb21t
dS9pb21tdS5jDQo+ID4+Pj4gaW5kZXggM2VhZDU5N2UxYzU3Li4zMDQyODFlYzYyM2IgMTAwNjQ0
DQo+ID4+Pj4gLS0tIGEvZHJpdmVycy9pb21tdS9pb21tdS5jDQo+ID4+Pj4gKysrIGIvZHJpdmVy
cy9pb21tdS9pb21tdS5jDQo+ID4+Pj4gQEAgLTc0MSw3ICs3NDEsNyBAQCBpbnQgaW9tbXVfZ3Jv
dXBfYWRkX2RldmljZShzdHJ1Y3QgaW9tbXVfZ3JvdXANCj4gPj4+PiAqZ3JvdXAsIHN0cnVjdCBk
ZXZpY2UgKmRldikNCj4gPj4+PiAgwqDCoMKgwqDCoCB0cmFjZV9hZGRfZGV2aWNlX3RvX2dyb3Vw
KGdyb3VwLT5pZCwgZGV2KTsNCj4gPj4+PiAtwqDCoMKgIGRldl9pbmZvKGRldiwgIkFkZGluZyB0
byBpb21tdSBncm91cCAlZFxuIiwgZ3JvdXAtPmlkKTsNCj4gPj4+PiArwqDCoMKgIGRldl9kYmco
ZGV2LCAiQWRkaW5nIHRvIGlvbW11IGdyb3VwICVkXG4iLCBncm91cC0+aWQpOw0KPiA+Pj4NCj4g
Pj4+IEknbSBub3Qgc3Ryb25nbHkgYWdhaW5zdCB0aGlzLiBCdXQgdG8gbWUgdGhpcyBtZXNzYWdl
IHNlZW1zIHRvIGJlIGENCj4gZ29vZA0KPiA+Pj4gaW5kaWNhdG9yIHRoYXQgYSBkZXZpY2Ugd2Fz
IHByb2JlZCBzdWNjZXNzZnVsbHkgYnkgdGhlIGlvbW11IHN1YnN5c3RlbS4NCj4gPj4+IEtlZXBp
bmcgaXQgaW4gdGhlIGRlZmF1bHQga2VybmVsIG1lc3NhZ2UgYWx3YXlzIGhlbHBzIHRvIHRoZSBr
ZXJuZWwNCj4gPj4+IGRlYnVnZ2luZy4NCj4gPj4+DQo+ID4+DQo+ID4+IEkgd291bGQgdGVuZCB0
byBhZ3JlZS4NCj4gPg0KDQpbc25pcF0NCg0KPiA+DQo+ID4gIyBkbWVzZyB8Z3JlcCAnQWRkaW5n
IHRvIGlvbW11JyB8IHdjIC1sDQo+ID4gMTY0DQo+ID4gIyBkbWVzZyB8Z3JlcCAtdiAnQWRkaW5n
IHRvIGlvbW11JyB8IHdjIC1sDQo+ID4gNTUxDQo+ID4NCj4gPiBTbywgMjMlIG9mIHRoZSBrZXJu
ZWwgbWVzc2FnZXMgb24gdGhpcyBwbGF0Zm9ybSBhcmUgIkFkZGluZyB0byBpb21tdSIsDQo+ID4g
d2hpY2ggaXMgZXhjZXNzaXZlLg0KPiANCj4gSW5kZWVkLCBob3dldmVyIEkgd291bGQgbm90ZSB0
aGF0IG9uIG1vc3QgcGxhdGZvcm1zIGJyaW5naW5nIHVwIGENCj4gbmV0d29yayBpbnRlcmZhY2Ug
aW52b2x2ZXMgaG90LWFkZGluZyAwIGRldmljZXMsIHNvIGhvdC1hZGRpbmcgMTkNCj4gZGV2aWNl
cyBhcyBmdWxsLWJsb3duIERNQSBtYXN0ZXJzIGlzIGFyZ3VhYmx5IHRoZSByb290IG9mICJleGNl
c3NpdmUiDQo+IGFscmVhZHkuIFBlciB0aGUgY29uY2VybiBJIGluaXRpYWxseSByYWlzZWQsIGVh
Y2ggb2YgdGhvc2UgbWVzc2FnZXMNCj4gcmVwcmVzZW50cyBhIHdob2xlIGJ1bmNoIG9mIGludGVy
bmFsIGFsbG9jYXRpb24gYW5kIGJvb2trZWVwaW5nIGdvaW5nDQo+IG9uLCB3aGljaCBpZiBpdCBp
c24ndCBuZWNlc3Nhcnkgd291bGQgYmUgZmFyIGJldHRlciBhdm9pZGVkIGFsdG9nZXRoZXIsDQo+
IHRoYW4gc2ltcGx5IGRvbmUgbW9yZSBxdWlldGx5Lg0KPiANCj4gTGF1cmVudGl1LCBJIGd1ZXNz
IGF0IHRoZSBtb21lbnQgdGhlIG5hdHVyZSBvZiB0aGUgb2ZfZG1hX2NvbmZpZ3VyZSgpDQo+IGlu
dGVncmF0aW9uIG1lYW5zIHdlIGVuZCB1cCB0cmVhdGluZyBhbGwgRFBBQTIgb2JqZWN0cyBpZGVu
dGljYWxseSwgYnV0DQo+IGRvIHlvdSB0aGluayB3ZSBoYXZlIHNjb3BlIHRvIGJlIGEgYml0IGNs
ZXZlcmVyIGluIHRoYXQgcmVnYXJkPw0KPiBQcmVzdW1hYmx5IG5vdCBldmVyeSB0eXBlIG9mIG9i
amVjdCB0aGF0IHNob3dzIHVwIG9uIHRoZSBmc2xfbWMgYnVzIGlzDQo+IHJlYWxseSBhbiBpbmRl
cGVuZGVudCBETUEgbWFzdGVyLCBzbyBpZiB3ZSBjb3VsZCBza2lwIGRvaW5nIHRoZSBmdWxsDQo+
IERNQS9JT01NVS9NU0kgc2V0dXAgZm9yIHRoZSBvbmVzIHRoYXQgZG9uJ3QgbmVlZCBpdCwgaXQg
d291bGQgd29yayBvdXQNCj4gbmljZXIgYWxsIHJvdW5kLiBJbiBmYWN0IHlvdXIgLmRtYV9jb25m
aWd1cmUgcHJvcG9zYWwgKHdoaWNoIEknbGwgdHJ5IHRvDQo+IHRha2UgYSBwcm9wZXIgbG9vayBh
dCBuZXh0IHdlZWspIGNvdWxkbid0IGhhdmUgY29tZSBhdCBhIGJldHRlciB0aW1lIGZvcg0KPiB0
aGF0IGFyZ3VtZW50IDopDQogDQpUaGFua3MhIFRoYXQncyBhIHZlcnkgZ29vZCBwb2ludCAtIEkn
bGwgY2hlY2sgb24gd2hpY2ggZGV2aWNlcyB3ZSBhY3R1YWxseSB1c2UgDQpkbWEgYXBpcyBhbmQg
ZmlsdGVyIHRoZSByZXN0IG91dC4gV2lsbCBrZWVwIGluIG1pbmQgZm9yIHRoZSBuZXh0IHNwaW4g
b2YgdGhlIHBhdGNoZXMuDQoNCi0tLQ0KQmVzdCBSZWdhcmRzLCBMYXVyZW50aXUNCg0KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBs
aXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
