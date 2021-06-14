Return-Path: <SRS0=DplC=LI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0EFC2B9F4
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 12:52:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2F97613EF
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 12:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F97613EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6E65740163;
	Mon, 14 Jun 2021 12:52:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CqurHi5C0Kxb; Mon, 14 Jun 2021 12:52:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 35AAD400B5;
	Mon, 14 Jun 2021 12:52:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0812DC000E;
	Mon, 14 Jun 2021 12:52:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC7C2C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 12:52:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CDEA840489
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 12:52:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JiEUzPNFjhLR for <iommu@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 12:52:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2350E403ED
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 12:52:00 +0000 (UTC)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G3WRj33K0zXfZT;
 Mon, 14 Jun 2021 20:46:57 +0800 (CST)
Received: from dggpemm100004.china.huawei.com (7.185.36.189) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 14 Jun 2021 20:51:56 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm100004.china.huawei.com (7.185.36.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 14 Jun 2021 20:51:55 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2176.012; Mon, 14 Jun 2021 13:51:52 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Robin Murphy <robin.murphy@arm.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: =?utf-8?B?UkU6IFtQQVRDSCB2NSA1LzhdIGlvbW11L2FybS1zbW11LXYzOiBBZGQgYnlw?=
 =?utf-8?B?YXNzIGZsYWcgdG/CoGFybV9zbW11X3dyaXRlX3N0cnRhYl9lbnQoKQ==?=
Thread-Topic: =?utf-8?B?W1BBVENIIHY1IDUvOF0gaW9tbXUvYXJtLXNtbXUtdjM6IEFkZCBieXBhc3Mg?=
 =?utf-8?B?ZmxhZyB0b8KgYXJtX3NtbXVfd3JpdGVfc3RydGFiX2VudCgp?=
Thread-Index: AQHXUIx/cOwHmW58uUq136QHDvp3LasTXKyAgAA53IA=
Date: Mon, 14 Jun 2021 12:51:52 +0000
Message-ID: <af362953f07a4236b999b8cdb1eca761@huawei.com>
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
 <20210524110222.2212-6-shameerali.kolothum.thodi@huawei.com>
 <ab9a8ca2-8611-2dcc-8b03-e13715521905@arm.com>
In-Reply-To: <ab9a8ca2-8611-2dcc-8b03-e13715521905@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.26.251]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "jon@solid-run.com" <jon@solid-run.com>, Linuxarm <linuxarm@huawei.com>,
 "steven.price@arm.com" <steven.price@arm.com>,
 "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 yangyicong <yangyicong@huawei.com>,
 "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
 wanghuiqiang <wanghuiqiang@huawei.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iaW4gTXVycGh5IFtt
YWlsdG86cm9iaW4ubXVycGh5QGFybS5jb21dDQo+IFNlbnQ6IDE0IEp1bmUgMjAyMSAxMToyMw0K
PiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9k
aUBodWF3ZWkuY29tPjsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBs
aW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsNCj4gaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcNCj4gQ2M6IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPjsgbG9yZW56by5waWVy
YWxpc2lAYXJtLmNvbTsNCj4gam9yb0A4Ynl0ZXMub3JnOyB3YW5naHVpcWlhbmcgPHdhbmdodWlx
aWFuZ0BodWF3ZWkuY29tPjsgR3VvaGFuanVuDQo+IChIYW5qdW4gR3VvKSA8Z3VvaGFuanVuQGh1
YXdlaS5jb20+OyBzdGV2ZW4ucHJpY2VAYXJtLmNvbTsNCj4gU2FtaS5NdWphd2FyQGFybS5jb207
IGpvbkBzb2xpZC1ydW4uY29tOyBlcmljLmF1Z2VyQHJlZGhhdC5jb207DQo+IHlhbmd5aWNvbmcg
PHlhbmd5aWNvbmdAaHVhd2VpLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSA1LzhdIGlv
bW11L2FybS1zbW11LXYzOiBBZGQgYnlwYXNzIGZsYWcNCj4gdG/CoGFybV9zbW11X3dyaXRlX3N0
cnRhYl9lbnQoKQ0KPiANCj4gT24gMjAyMS0wNS0yNCAxMjowMiwgU2hhbWVlciBLb2xvdGh1bSB3
cm90ZToNCj4gPiBCeSBkZWZhdWx0LMKgZGlzYWJsZV9ieXBhc3MgaXMgc2V0IGFuZCBhbnkgZGV2
IHdpdGhvdXQgYW4gaW9tbXUgZG9tYWluDQo+ID4gaW5zdGFsbHMgU1RFIHdpdGggQ0ZHX0FCT1JU
IGR1cmluZ8KgYXJtX3NtbXVfaW5pdF9ieXBhc3Nfc3RlcygpLg0KPiBJbnRyb2R1Y2UNCj4gPiBh
ICJieXBhc3MiIGZsYWcgdG/CoGFybV9zbW11X3dyaXRlX3N0cnRhYl9lbnQoKSBzbyB0aGF0IHdl
IGNhbiBmb3JjZSBpdCB0bw0KPiA+IGluc3RhbGzCoENGR19CWVBBU1MgU1RFIGZvciBzcGVjaWZp
YyBTSURzLiBUaGlzIHdpbGwgYmXCoHVzZWZ1bMKgaW4gZm9sbG93DQo+ID4gdXAgcGF0Y2ggdG8g
aW5zdGFsbCBieXBhc3MgZm9yIElPUlQgUk1SIFNJRHMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBTaGFtZWVyIEtvbG90aHVtDQo+IDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5j
b20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21t
dS12My5jIHwgOCArKysrLS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgNCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2Fy
bS9hcm0tc21tdS12My9hcm0tc21tdS12My5jDQo+IGIvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNt
bXUtdjMvYXJtLXNtbXUtdjMuYw0KPiA+IGluZGV4IDc1NGJhZDYwOTJjMS4uZjkxOTViNzQwZjQ4
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11
LXYzLmMNCj4gPiArKysgYi9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12
My5jDQo+ID4gQEAgLTExNzQsNyArMTE3NCw3IEBAIHN0YXRpYyB2b2lkIGFybV9zbW11X3N5bmNf
c3RlX2Zvcl9zaWQoc3RydWN0DQo+IGFybV9zbW11X2RldmljZSAqc21tdSwgdTMyIHNpZCkNCj4g
PiAgIH0NCj4gPg0KPiA+ICAgc3RhdGljIHZvaWQgYXJtX3NtbXVfd3JpdGVfc3RydGFiX2VudChz
dHJ1Y3QgYXJtX3NtbXVfbWFzdGVyDQo+ICptYXN0ZXIsIHUzMiBzaWQsDQo+ID4gLQkJCQkgICAg
ICBfX2xlNjQgKmRzdCkNCj4gPiArCQkJCSAgICAgIF9fbGU2NCAqZHN0LCBib29sIGJ5cGFzcykN
Cj4gPiAgIHsNCj4gPiAgIAkvKg0KPiA+ICAgCSAqIFRoaXMgaXMgaGlkZW91c2x5IGNvbXBsaWNh
dGVkLCBidXQgd2Ugb25seSByZWFsbHkgY2FyZSBhYm91dA0KPiA+IEBAIC0xMjQ1LDcgKzEyNDUs
NyBAQCBzdGF0aWMgdm9pZCBhcm1fc21tdV93cml0ZV9zdHJ0YWJfZW50KHN0cnVjdA0KPiBhcm1f
c21tdV9tYXN0ZXIgKm1hc3RlciwgdTMyIHNpZCwNCj4gPg0KPiA+ICAgCS8qIEJ5cGFzcy9mYXVs
dCAqLw0KPiA+ICAgCWlmICghc21tdV9kb21haW4gfHwgIShzMV9jZmcgfHwgczJfY2ZnKSkgew0K
PiA+IC0JCWlmICghc21tdV9kb21haW4gJiYgZGlzYWJsZV9ieXBhc3MpDQo+ID4gKwkJaWYgKCFz
bW11X2RvbWFpbiAmJiBkaXNhYmxlX2J5cGFzcyAmJiAhYnlwYXNzKQ0KPiANCj4gVW1tLi4uDQo+
IA0KPiA+ICAgCQkJdmFsIHw9IEZJRUxEX1BSRVAoU1RSVEFCX1NURV8wX0NGRywNCj4gU1RSVEFC
X1NURV8wX0NGR19BQk9SVCk7DQo+ID4gICAJCWVsc2UNCj4gPiAgIAkJCXZhbCB8PSBGSUVMRF9Q
UkVQKFNUUlRBQl9TVEVfMF9DRkcsDQo+IFNUUlRBQl9TVEVfMF9DRkdfQllQQVNTKTsNCj4gPiBA
QCAtMTMyMCw3ICsxMzIwLDcgQEAgc3RhdGljIHZvaWQgYXJtX3NtbXVfaW5pdF9ieXBhc3Nfc3Rl
cyhfX2xlNjQNCj4gKnN0cnRhYiwgdW5zaWduZWQgaW50IG5lbnQpDQo+ID4gICAJdW5zaWduZWQg
aW50IGk7DQo+ID4NCj4gPiAgIAlmb3IgKGkgPSAwOyBpIDwgbmVudDsgKytpKSB7DQo+ID4gLQkJ
YXJtX3NtbXVfd3JpdGVfc3RydGFiX2VudChOVUxMLCAtMSwgc3RydGFiKTsNCj4gPiArCQlhcm1f
c21tdV93cml0ZV9zdHJ0YWJfZW50KE5VTEwsIC0xLCBzdHJ0YWIsIGZhbHNlKTsNCj4gDQo+IC4u
LmFuZCBpbiBwYXJ0aWN1bGFyLCBhbiBvcGVyYXRpb24gbmFtZWQgImluaXRfYnlwYXNzX3N0ZXMi
IHBhc3NpbmcNCj4gYnlwYXNzPWZhbHNlIGlzIGp1c3QgYnJlYWtpbmcgbXkgYnJhaW4uIENhbiB3
ZSBwdWxsIHRoZSBsb2dpYyBmb3INCj4gZGVmYXVsdCBieXBhc3MvZmF1bHQgb3V0IHRvIGhlcmUg
YXMgcGFydCBvZiB0aGUgcmVmYWN0b3Jpbmcgc28gdGhhdCBpdA0KPiBhY3R1YWxseSBtYWtlcyBz
ZW5zZT8NCg0KQWdyZWUsIGl0IGlzIGNvbmZ1c2luZy4gV2lsbCBhZGQgdGhlIGRlZmF1bHQgYnlw
YXNzL2ZhdWx0IGxvZ2ljIGhlcmUuDQoNClRoYW5rcywNClNoYW1lZXINCg0KPiANCj4gUm9iaW4u
DQo+IA0KPiA+ICAgCQlzdHJ0YWIgKz0gU1RSVEFCX1NURV9EV09SRFM7DQo+ID4gICAJfQ0KPiA+
ICAgfQ0KPiA+IEBAIC0yMDk3LDcgKzIwOTcsNyBAQCBzdGF0aWMgdm9pZCBhcm1fc21tdV9pbnN0
YWxsX3N0ZV9mb3JfZGV2KHN0cnVjdA0KPiBhcm1fc21tdV9tYXN0ZXIgKm1hc3RlcikNCj4gPiAg
IAkJaWYgKGogPCBpKQ0KPiA+ICAgCQkJY29udGludWU7DQo+ID4NCj4gPiAtCQlhcm1fc21tdV93
cml0ZV9zdHJ0YWJfZW50KG1hc3Rlciwgc2lkLCBzdGVwKTsNCj4gPiArCQlhcm1fc21tdV93cml0
ZV9zdHJ0YWJfZW50KG1hc3Rlciwgc2lkLCBzdGVwLCBmYWxzZSk7DQo+ID4gICAJfQ0KPiA+ICAg
fQ0KPiA+DQo+ID4NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
