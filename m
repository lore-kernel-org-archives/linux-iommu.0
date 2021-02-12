Return-Path: <SRS0=FWOh=HO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54B4C433DB
	for <iommu@archiver.kernel.org>; Fri, 12 Feb 2021 17:28:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59A1C64E9A
	for <iommu@archiver.kernel.org>; Fri, 12 Feb 2021 17:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A1C64E9A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 255A587627;
	Fri, 12 Feb 2021 17:28:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3TT+KNWCZc4B; Fri, 12 Feb 2021 17:28:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C7E558761C;
	Fri, 12 Feb 2021 17:28:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2420C0891;
	Fri, 12 Feb 2021 17:28:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 811A2C013A
 for <iommu@lists.linux-foundation.org>; Fri, 12 Feb 2021 17:28:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 67F9E6F654
 for <iommu@lists.linux-foundation.org>; Fri, 12 Feb 2021 17:28:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NPlcf4S78D_h for <iommu@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 17:28:44 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id 4F9966F68A; Fri, 12 Feb 2021 17:28:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DC4A16F674
 for <iommu@lists.linux-foundation.org>; Fri, 12 Feb 2021 17:28:41 +0000 (UTC)
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DcgRM2rSbz5RKj;
 Sat, 13 Feb 2021 01:27:11 +0800 (CST)
Received: from dggemm751-chm.china.huawei.com (10.1.198.57) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Sat, 13 Feb 2021 01:28:37 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggemm751-chm.china.huawei.com (10.1.198.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sat, 13 Feb 2021 01:28:36 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2106.006; Fri, 12 Feb 2021 17:28:34 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Robin Murphy <robin.murphy@arm.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH v2] iommu: Check dev->iommu in iommu_dev_xxx functions
Thread-Topic: [PATCH v2] iommu: Check dev->iommu in iommu_dev_xxx functions
Thread-Index: AdcBTrfjz4ngs6VWSn6F9Rp3qrl5mQADsiaAAAAQ0NAAAVXqEA==
Date: Fri, 12 Feb 2021 17:28:34 +0000
Message-ID: <33cf95925cfb47dda3ee472e00b9846c@huawei.com>
References: <c82f6d0cced74c43947714e7de576d5a@huawei.com>
 <d541ebeb-5b89-7a9d-50a2-3867f9cf78b3@arm.com> 
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.89.255]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "will@kernel.org" <will@kernel.org>,
 "linuxarm@openeuler.org" <linuxarm@openeuler.org>, "Zengtao
 \(B\)" <prime.zeng@hisilicon.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hhbWVlcmFsaSBLb2xv
dGh1bSBUaG9kaQ0KPiBTZW50OiAxMiBGZWJydWFyeSAyMDIxIDE2OjQ1DQo+IFRvOiAnUm9iaW4g
TXVycGh5JyA8cm9iaW4ubXVycGh5QGFybS5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOw0KPiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZw0KPiBDYzogam9yb0A4Ynl0
ZXMub3JnOyBqZWFuLXBoaWxpcHBlQGxpbmFyby5vcmc7IHdpbGxAa2VybmVsLm9yZzsgWmVuZ3Rh
byAoQikNCj4gPHByaW1lLnplbmdAaGlzaWxpY29uLmNvbT47IGxpbnV4YXJtQG9wZW5ldWxlci5v
cmcNCj4gU3ViamVjdDogUkU6IFtQQVRDSCB2Ml0gaW9tbXU6IENoZWNrIGRldi0+aW9tbXUgaW4g
aW9tbXVfZGV2X3h4eCBmdW5jdGlvbnMNCj4gDQo+IA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiA+IEZyb206IFJvYmluIE11cnBoeSBbbWFpbHRvOnJvYmluLm11cnBoeUBh
cm0uY29tXQ0KPiA+IFNlbnQ6IDEyIEZlYnJ1YXJ5IDIwMjEgMTY6MzkNCj4gPiBUbzogU2hhbWVl
cmFsaSBLb2xvdGh1bSBUaG9kaSA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29t
PjsNCj4gPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBpb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZw0KPiA+IENjOiBqb3JvQDhieXRlcy5vcmc7IGplYW4tcGhpbGlwcGVAbGlu
YXJvLm9yZzsgd2lsbEBrZXJuZWwub3JnOyBaZW5ndGFvIChCKQ0KPiA+IDxwcmltZS56ZW5nQGhp
c2lsaWNvbi5jb20+OyBsaW51eGFybUBvcGVuZXVsZXIub3JnDQo+ID4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2Ml0gaW9tbXU6IENoZWNrIGRldi0+aW9tbXUgaW4gaW9tbXVfZGV2X3h4eA0KPiBmdW5j
dGlvbnMNCj4gPg0KPiA+IE9uIDIwMjEtMDItMTIgMTQ6NTQsIFNoYW1lZXJhbGkgS29sb3RodW0g
VGhvZGkgd3JvdGU6DQo+ID4gPiBIaSBSb2Jpbi9Kb2VyZywNCj4gPiA+DQo+ID4gPj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+PiBGcm9tOiBTaGFtZWVyIEtvbG90aHVtDQo+IFtt
YWlsdG86c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tXQ0KPiA+ID4+IFNlbnQ6
IDAxIEZlYnJ1YXJ5IDIwMjEgMTI6NDENCj4gPiA+PiBUbzogbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcNCj4gPiA+PiBDYzogam9y
b0A4Ynl0ZXMub3JnOyByb2Jpbi5tdXJwaHlAYXJtLmNvbTsgamVhbi1waGlsaXBwZUBsaW5hcm8u
b3JnOw0KPiA+ID4+IHdpbGxAa2VybmVsLm9yZzsgWmVuZ3RhbyAoQikgPHByaW1lLnplbmdAaGlz
aWxpY29uLmNvbT47DQo+ID4gPj4gbGludXhhcm1Ab3BlbmV1bGVyLm9yZw0KPiA+ID4+IFN1Ympl
Y3Q6IFtMaW51eGFybV0gW1BBVENIIHYyXSBpb21tdTogQ2hlY2sgZGV2LT5pb21tdSBpbg0KPiA+
IGlvbW11X2Rldl94eHgNCj4gPiA+PiBmdW5jdGlvbnMNCj4gPiA+Pg0KPiA+ID4+IFRoZSBkZXZp
Y2UgaW9tbXUgcHJvYmUvYXR0YWNoIG1pZ2h0IGhhdmUgZmFpbGVkIGxlYXZpbmcgZGV2LT5pb21t
dQ0KPiA+ID4+IHRvIE5VTEwgYW5kIGRldmljZSBkcml2ZXJzIG1heSBzdGlsbCBpbnZva2UgdGhl
c2UgZnVuY3Rpb25zIHJlc3VsdGluZw0KPiA+ID4+IGluIGEgY3Jhc2ggaW4gaW9tbXUgdmVuZG9y
IGRyaXZlciBjb2RlLiBIZW5jZSBtYWtlIHN1cmUgd2UgY2hlY2sgdGhhdC4NCj4gPiA+Pg0KPiA+
ID4+IEFsc28gYWRkZWQgaW9tbXVfb3BzIHRvIHRoZSAic3RydWN0IGRldl9pb21tdSIgYW5kIHNl
dCBpdCBpZiB0aGUgZGV2DQo+ID4gPj4gaXMgc3VjY2Vzc2Z1bGx5IGFzc29jaWF0ZWQgd2l0aCBh
biBpb21tdS4NCj4gPiA+Pg0KPiA+ID4+IEZpeGVzOsKgYTNhMTk1OTI5ZDQwICgiaW9tbXU6IEFk
ZCBBUElzIGZvciBtdWx0aXBsZSBkb21haW5zIHBlcg0KPiBkZXZpY2UiKQ0KPiA+ID4+IFNpZ25l
ZC1vZmYtYnk6IFNoYW1lZXIgS29sb3RodW0NCj4gPiA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9k
aUBodWF3ZWkuY29tPg0KPiA+ID4+IC0tLQ0KPiA+ID4+IHYxIC0tPiB2MjoNCj4gPiA+PiAgIC1B
ZGRlZCBpb21tdV9vcHMgdG8gc3RydWN0IGRldl9pb21tdSBiYXNlZCBvbiB0aGUgZGlzY3Vzc2lv
biB3aXRoDQo+ID4gUm9iaW4uDQo+ID4gPj4gICAtUmViYXNlZCBhZ2FpbnN0IGlvbW11LXRyZWUg
Y29yZSBicmFuY2guDQo+ID4gPg0KPiA+ID4gQSBnZW50bGUgcGluZyBvbiB0aGlzLi4uDQo+ID4N
Cj4gPiBJcyB0aGVyZSBhIGNvbnZpbmNpbmcganVzdGlmaWNhdGlvbiBmb3IgbWFpbnRhaW5pbmcg
eWV0IGFub3RoZXIgY29weSBvZg0KPiA+IHRoZSBvcHMgcG9pbnRlciByYXRoZXIgdGhhbiBzaW1w
bHkgZGVyZWZlcmVuY2luZyBpb21tdV9kZXYtPm9wcyBhdCBwb2ludA0KPiA+IG9mIHVzZT8NCj4g
Pg0KPiANCj4gVEJILCBub3RoaW5nIEkgY2FuIHRoaW5rIG9mIG5vdy4gVGhhdCB3YXMgbWFpbmx5
IHRoZSB3YXkgSSBpbnRlcnByZXRlZCB5b3VyDQo+IHN1Z2dlc3Rpb24NCj4gZnJvbSB0aGUgdjEu
ICBOb3cgaXQgbG9va3MgbGlrZSB5b3UgZGlkbuKAmXQgbWVhbiBpdCA6KS4gSSBhbSBPayB0byBy
ZXdvcmsgaXQgdG8NCj4gZGVyZWZlcmVuY2UNCj4gaXQgZnJvbSBpb21tdV9kZXYuIFBsZWFzZSBs
ZXQgbWUga25vdy4NCg0KU28gd2UgY2FuIGRvIHNvbWV0aGluZyBsaWtlIHRoaXMsDQoNCmluZGV4
IGZkNzZlMmY1NzlmZS4uNWZkMzFhM2NlYzE4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pb21tdS9p
b21tdS5jDQorKysgYi9kcml2ZXJzL2lvbW11L2lvbW11LmMNCkBAIC0yODY1LDEwICsyODY1LDEy
IEBAIEVYUE9SVF9TWU1CT0xfR1BMKGlvbW11X2Z3c3BlY19hZGRfaWRzKTsNCiAgKi8NCiBpbnQg
aW9tbXVfZGV2X2VuYWJsZV9mZWF0dXJlKHN0cnVjdCBkZXZpY2UgKmRldiwgZW51bSBpb21tdV9k
ZXZfZmVhdHVyZXMgZmVhdCkNCiB7DQotICAgICAgIGNvbnN0IHN0cnVjdCBpb21tdV9vcHMgKm9w
cyA9IGRldi0+YnVzLT5pb21tdV9vcHM7DQorICAgICAgIGlmIChkZXYtPmlvbW11ICYmIGRldi0+
aW9tbXUtPmlvbW11X2RldiAmJiBkZXYtPmlvbW11LT5pb21tdV9kZXYtPm9wcykNCisgICAgICAg
ICAgICAgICBzdHJ1Y3QgaW9tbXVfb3BzICAqb3BzID0gZGV2LT5pb21tdS0+aW9tbXVfZGV2LT5v
cHM7DQogDQotICAgICAgIGlmIChvcHMgJiYgb3BzLT5kZXZfZW5hYmxlX2ZlYXQpDQotICAgICAg
ICAgICAgICAgcmV0dXJuIG9wcy0+ZGV2X2VuYWJsZV9mZWF0KGRldiwgZmVhdCk7DQorICAgICAg
ICAgICAgICAgaWYgKG9wcy0+ZGV2X2VuYWJsZV9mZWF0KQ0KKyAgICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIG9wcy0+ZGV2X2VuYWJsZV9mZWF0KGRldiwgZmVhdCk7DQorICAgICAgIH0NCiAN
CiAgICAgICAgcmV0dXJuIC1FTk9ERVY7DQogfQ0KDQpBZ2Fpbiwgbm90IHN1cmUgd2UgbmVlZCB0
byBkbyB0aGUgY2hlY2tpbmcgZm9yIGlvbW11LT5kZXYgYW5kIG9wcyBoZXJlLiBJZiB0aGUNCmRl
di0+aW9tbXUgaXMgc2V0LCBpcyBpdCBzYWZlIHRvIGFzc3VtZSB0aGF0IHdlIGhhdmUgYSB2YWxp
ZCBpb21tdS0+aW9tbXVfZGV2DQphbmQgb3BzIGFsd2F5cz8gKE1heSBiZSBpdCBpcyBzYWZlciB0
byBkbyB0aGUgY2hlY2tpbmcgaW4gY2FzZSBzb21ldGhpbmcNCmVsc2UgYnJlYWtzIHRoaXMgYXNz
dW1wdGlvbiBpbiBmdXR1cmUpLiBQbGVhc2UgbGV0IG1lIGtub3cgeW91ciB0aG91Z2h0cy4NCg0K
VGhhbmtzLA0KU2hhbWVlcg0KDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by9pb21tdQ==
