Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC41C433EF
	for <iommu@archiver.kernel.org>; Tue, 19 Apr 2022 08:32:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 62566842A4;
	Tue, 19 Apr 2022 08:32:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gs71Sv1ouGqN; Tue, 19 Apr 2022 08:32:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 180848426D;
	Tue, 19 Apr 2022 08:32:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2B75C002F;
	Tue, 19 Apr 2022 08:32:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0127C002C
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 08:32:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AA380612C5
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 08:32:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 73KgaELkEa_u for <iommu@lists.linux-foundation.org>;
 Tue, 19 Apr 2022 08:32:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 48F15612C2
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 08:32:02 +0000 (UTC)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KjH8l6Z68zhXXK;
 Tue, 19 Apr 2022 16:31:51 +0800 (CST)
Received: from dggpemm100002.china.huawei.com (7.185.36.179) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Apr 2022 16:31:58 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm100002.china.huawei.com (7.185.36.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Apr 2022 16:31:57 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2375.024; Tue, 19 Apr 2022 09:31:55 +0100
To: Christoph Hellwig <hch@infradead.org>, Robin Murphy <robin.murphy@arm.com>
Subject: RE: [PATCH v9 06/11] ACPI/IORT: Add support to retrieve IORT RMR
 reserved regions
Thread-Topic: [PATCH v9 06/11] ACPI/IORT: Add support to retrieve IORT RMR
 reserved regions
Thread-Index: AQHYSCG95Y0d6z1dQEidSJE+wh/QIqzkZagAgAAHFACAAAGmAIASjl6g
Date: Tue, 19 Apr 2022 08:31:55 +0000
Message-ID: <955601f02f3b474da3327963fb1630f0@huawei.com>
References: <20220404124209.1086-1-shameerali.kolothum.thodi@huawei.com>
 <20220404124209.1086-7-shameerali.kolothum.thodi@huawei.com>
 <Yk7m8oDPtusDzReK@infradead.org>
 <b50cded6-6777-c9c7-7030-a57f28771bc3@arm.com>
 <Yk7uRPG1TwGFPbyY@infradead.org>
In-Reply-To: <Yk7uRPG1TwGFPbyY@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.178]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "jon@solid-run.com" <jon@solid-run.com>, Linuxarm <linuxarm@huawei.com>,
 "steven.price@arm.com" <steven.price@arm.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 yangyicong <yangyicong@huawei.com>,
 "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
 "will@kernel.org" <will@kernel.org>, wanghuiqiang <wanghuiqiang@huawei.com>
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
From: Shameerali Kolothum Thodi via iommu <iommu@lists.linux-foundation.org>
Reply-To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hyaXN0b3BoIEhlbGx3
aWcgW21haWx0bzpoY2hAaW5mcmFkZWFkLm9yZ10NCj4gU2VudDogMDcgQXByaWwgMjAyMiAxNTow
MA0KPiBUbzogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4NCj4gQ2M6IENocmlz
dG9waCBIZWxsd2lnIDxoY2hAaW5mcmFkZWFkLm9yZz47IFNoYW1lZXJhbGkgS29sb3RodW0gVGhv
ZGkNCj4gPHNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT47IGpvbkBzb2xpZC1y
dW4uY29tOyBMaW51eGFybQ0KPiA8bGludXhhcm1AaHVhd2VpLmNvbT47IHN0ZXZlbi5wcmljZUBh
cm0uY29tOyBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsNCj4gaW9tbXVAbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmc7IHdhbmdodWlxaWFuZw0KPiA8d2FuZ2h1aXFpYW5nQGh1YXdlaS5jb20+
OyBHdW9oYW5qdW4gKEhhbmp1biBHdW8pDQo+IDxndW9oYW5qdW5AaHVhd2VpLmNvbT47IHlhbmd5
aWNvbmcgPHlhbmd5aWNvbmdAaHVhd2VpLmNvbT47DQo+IFNhbWkuTXVqYXdhckBhcm0uY29tOyB3
aWxsQGtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHY5IDA2LzExXSBBQ1BJL0lPUlQ6IEFkZCBzdXBwb3J0IHRv
IHJldHJpZXZlIElPUlQgUk1SDQo+IHJlc2VydmVkIHJlZ2lvbnMNCj4gDQo+IE9uIFRodSwgQXBy
IDA3LCAyMDIyIGF0IDAyOjUzOjM4UE0gKzAxMDAsIFJvYmluIE11cnBoeSB3cm90ZToNCj4gPiA+
IFdoeSBjYW4ndCB0aGlzIGp1c3QgZ28gaW50byBnZW5lcmljX2lvbW11X3B1dF9yZXN2X3JlZ2lv
bnM/ICBUaGUgaWRlYQ0KPiA+ID4gdGhhdCB0aGUgaW9tbXUgbG93LWxldmVsIGRyaXZlcnMgbmVl
ZCB0byBjYWxsIGludG8gZG1hLWlvbW11IHdoaWNoIGlzDQo+ID4gPiBhIGNvbnN1bWVyIG9mIHRo
ZSBJT01NVSBBUEkgaXMgb2RkLiAgRXNwZWNpYWxseSBpZiB0aGF0IGp1c3QgY2FsbHMgb3V0DQo+
ID4gPiB0byBBQ1BJIGNvZGUgYW5kIGdlbmVyaWMgSU9NTVUgY29kZSBvbmx5IGFueXdheS4NCj4g
Pg0KPiA+IEJlY2F1c2UgYXNzdW1pbmcgQUNQSSBtZWFucyBJT1JUIGlzIG5vdCBnZW5lcmljLiBQ
YXJ0IG9mIHRoZSBhaW0gaW4gYWRkaW5nDQo+ID4gdGhlIHVuaW9uIHRvIGlvbW11X3Jlc3ZfcmVn
aW9uIGlzIHRoYXQgc3R1ZmYgbGlrZSBBTUQncyB1bml0eV9tYXBfZW50cnkNCj4gYW5kDQo+ID4g
SW50ZWwncyBkbWFyX3JtcnJfdW5pdCBjYW4gYmUgZm9sZGVkIGludG8gaXQgYXMgd2VsbCwgYW5k
IHRoZWlyIHJlc2VydmVkDQo+ID4gcmVnaW9uIGhhbmRsaW5nIGNvcnJlc3BvbmRpbmdseSBzaW1w
bGlmaWVkIHRvby4NCj4gPg0KPiA+IFRoZSBpb21tdV9kbWFfe2dldCxwdXR9X3Jlc3ZfcmVnaW9u
KCkgaGVscGVycyBhcmUga2luZCBvZiBpbnRlbmRlZCB0byBiZQ0KPiA+IHNwZWNpZmljIHRvIHRo
ZSBmd25vZGUgbWVjaGFuaXNtIHdoaWNoIGRlYWxzIHdpdGggSU9SVCBhbmQgZGV2aWNldHJlZQ0K
PiAob25jZQ0KPiA+IHRoZSByZXNlcnZlZCByZWdpb24gYmluZGluZ3MgYXJlIGZ1bGx5IHdvcmtl
ZCBvdXQpLg0KPiANCj4gQnV0IElPUlQgaXMgbm90IGRyaXZlcuKCi3NwZWNpZmljIGNvZGUuICBT
byB3ZSdsbCBuZWVkIGEgVVNFX0lPUlQgZmxhZw0KPiBzb21ld2hlcmUgaW4gY29yZSBJT01NVSBj
b2RlIGluc3RlYWQgb2YgdHJ5aW5nIHRvIHN0dWZmIHRoaXMgaW50bw0KPiBkcml2ZXIgb3BlcmF0
aW9ucy4gIGFuZCBkbWEtaW9tbXUgbW9zdGx5IGNlcnRhaW5seSBpbXBsaWVzIElPUlQgZXZlbg0K
PiBsZXNzIHRoYW4gQUNQSS4NCg0KU29ycnkgZm9yIHRoZSBkZWxheWVkIHJlc3BvbnNlKHdhcyBv
biBob2xpZGF5cykuIFNvIGlmIHdlIG1vdmUgdGhlDQppb21tdV9kbWFfcHV0X3Jlc3ZfcmVnaW9u
KCkgY2FsbCB0byBnZW5lcmljX2lvbW11X3B1dF9yZXN2X3JlZ2lvbnMoKSAsDQp3aWxsIHRoYXQg
YWRkcmVzcyB0aGUgY29uY2VybnMgaGVyZT8NCg0KSSB0aGluayBpdCB3aWxsIHJlc29sdmUgdGhl
IGlzc3VlIGluIDA1LzExIGFzIHdlbGwgcG9pbnRlZCBvdXQgYnkgQ2hyaXN0b3BoDQp3aGVyZSB3
ZSBlbmQgdXAgbm90IHJlbGVhc2luZyByZXNlcnZlZCByZWdpb25zIHdoZW4NCkNPTkZJR19JT01N
VV9ETUEgaXMgbm90IHNldC4NCg0KU29tZXRoaW5nIGxpa2UgYmVsb3csDQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2lvbW11L2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L2lvbW11LmMNCmluZGV4IGYy
YzQ1Yjg1YjlmYy4uZDA4MjA0YTI1YmE4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pb21tdS9pb21t
dS5jDQorKysgYi9kcml2ZXJzL2lvbW11L2lvbW11LmMNCkBAIC0yNjA1LDYgKzI2MDUsOCBAQCB2
b2lkIGdlbmVyaWNfaW9tbXVfcHV0X3Jlc3ZfcmVnaW9ucyhzdHJ1Y3QNCmRldmljZSAqZGV2LCBz
dHJ1Y3QgbGlzdF9oZWFkICpsaXN0KQ0KIHsNCiAgICAgICAgc3RydWN0IGlvbW11X3Jlc3ZfcmVn
aW9uICplbnRyeSwgKm5leHQ7DQoNCisgICAgICAgaW9tbXVfZG1hX3B1dF9yZXN2X3JlZ2lvbnMo
ZGV2LCBsaXN0KTsNCisNCiAgICAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKGVudHJ5LCBu
ZXh0LCBsaXN0LCBsaXN0KQ0KICAgICAgICAgICAgICAgIGtmcmVlKGVudHJ5KTsNCiB9DQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2RtYS1pb21tdS5jIGIvZHJpdmVycy9pb21tdS9kbWEt
aW9tbXUuYw0KaW5kZXggNTgxMTIzM2RjOWZiLi44Y2IxZTQxOWRiNDkgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL2lvbW11L2RtYS1pb21tdS5jDQorKysgYi9kcml2ZXJzL2lvbW11L2RtYS1pb21tdS5j
DQpAQCAtMzkzLDggKzM5Myw2IEBAIHZvaWQgaW9tbXVfZG1hX3B1dF9yZXN2X3JlZ2lvbnMoc3Ry
dWN0IGRldmljZQ0KKmRldiwgc3RydWN0IGxpc3RfaGVhZCAqbGlzdCkNCiB7DQogICAgICAgIGlm
ICghaXNfb2Zfbm9kZShkZXZfaW9tbXVfZndzcGVjX2dldChkZXYpLT5pb21tdV9md25vZGUpKQ0K
ICAgICAgICAgICAgICAgIGlvcnRfaW9tbXVfcHV0X3Jlc3ZfcmVnaW9ucyhkZXYsIGxpc3QpOw0K
LQ0KLSAgICAgICBnZW5lcmljX2lvbW11X3B1dF9yZXN2X3JlZ2lvbnMoZGV2LCBsaXN0KTsNCiB9
DQoNClBsZWFzZSBsZXQgbWUga25vdyBpZiB0aGlzIGlzIG5vdCBnb29kIGVub3VnaC4NCg0KVGhh
bmtzLA0KU2hhbWVlcg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
