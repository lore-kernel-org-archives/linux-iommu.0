Return-Path: <SRS0=7pZu=EE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E39C4363A
	for <iommu@archiver.kernel.org>; Thu, 29 Oct 2020 16:17:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C037620756
	for <iommu@archiver.kernel.org>; Thu, 29 Oct 2020 16:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C037620756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3906486B82;
	Thu, 29 Oct 2020 16:17:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JLxgt7Ktzz9m; Thu, 29 Oct 2020 16:17:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 67F1186B80;
	Thu, 29 Oct 2020 16:17:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51D61C0859;
	Thu, 29 Oct 2020 16:17:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7F68C0051
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 16:17:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8E2E586B05
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 16:17:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7faolUq3g3BT for <iommu@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 16:17:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 745CD86AF8
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 16:17:42 +0000 (UTC)
Received: from lhreml712-chm.china.huawei.com (unknown [172.18.7.108])
 by Forcepoint Email with ESMTP id CA0C48550552EE47B3D3;
 Thu, 29 Oct 2020 16:17:38 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml712-chm.china.huawei.com (10.201.108.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 29 Oct 2020 16:17:38 +0000
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.1913.007; Thu, 29 Oct 2020 16:17:38 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Robin Murphy <robin.murphy@arm.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH] iommu/arm-smmu-v3: Add def_domain_type callback
Thread-Topic: [PATCH] iommu/arm-smmu-v3: Add def_domain_type callback
Thread-Index: AQHWrgo3Iabw04eOkUGOz+O/IH/nbKmuuzeAgAADTMA=
Date: Thu, 29 Oct 2020 16:17:38 +0000
Message-ID: <8117c4629c5748fc9299d64fe60e6529@huawei.com>
References: <20201029154114.20364-1-shameerali.kolothum.thodi@huawei.com>
 <a3c73596-70d9-4204-d598-5e6684868544@arm.com>
In-Reply-To: <a3c73596-70d9-4204-d598-5e6684868544@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.27.104]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "ashok.raj@intel.com" <ashok.raj@intel.com>, Linuxarm <linuxarm@huawei.com>,
 "will@kernel.org" <will@kernel.org>
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
YWlsdG86cm9iaW4ubXVycGh5QGFybS5jb21dDQo+IFNlbnQ6IDI5IE9jdG9iZXIgMjAyMCAxNTo1
NA0KPiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSA8c2hhbWVlcmFsaS5rb2xvdGh1bS50
aG9kaUBodWF3ZWkuY29tPjsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
OyBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZw0KPiBDYzogTGludXhhcm0gPGxpbnV4
YXJtQGh1YXdlaS5jb20+OyB3aWxsQGtlcm5lbC5vcmc7IGpvcm9AOGJ5dGVzLm9yZzsNCj4gamVh
bi1waGlsaXBwZUBsaW5hcm8ub3JnOyBhc2hvay5yYWpAaW50ZWwuY29tOyBKb2huIEdhcnJ5DQo+
IDxqb2huLmdhcnJ5QGh1YXdlaS5jb20+OyBTb25nIEJhbyBIdWEgKEJhcnJ5IFNvbmcpDQo+IDxz
b25nLmJhby5odWFAaGlzaWxpY29uLmNvbT47IEpvbmF0aGFuIENhbWVyb24NCj4gPGpvbmF0aGFu
LmNhbWVyb25AaHVhd2VpLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gaW9tbXUvYXJtLXNt
bXUtdjM6IEFkZCBkZWZfZG9tYWluX3R5cGUgY2FsbGJhY2sNCj4gDQo+IE9uIDIwMjAtMTAtMjkg
MTU6NDEsIFNoYW1lZXIgS29sb3RodW0gd3JvdGU6DQo+ID4gV2l0aCB0aGUgaW50cm9kdWN0aW9u
IG9mIGRlZl9kb21haW5fdHlwZSBpbiBpb21tdV9vcHMsIHZlbmRvcg0KPiA+IGRyaXZlcnMgY2Fu
IG5vdyBpbmZvcm0gdGhlIGlvbW11IGdlbmVyaWMgbGF5ZXIgYWJvdXQgYW55IHNwZWNpZmljDQo+
ID4gZGVmYXVsdCBkb21haW4gcmVxdWlyZW1lbnQgZm9yIGEgZGV2aWNlLiBBbnkgcGNpIGRldiBt
YXJrZWQgYXMNCj4gPiB1bnRydXN0ZWQgaXMgbm93IHByZXZlbnRlZCBmcm9tIGhhdmluZyBhbiBJ
REVOVElUWSBtYXBwaW5nDQo+ID4gZG9tYWluLg0KPiA+DQo+ID4gVGhlIGNhbGxiYWNrIGlzIGFs
c28gcmVxdWlyZWQgd2hlbiB0aGUgc3VwcG9ydCBmb3IgZHluYW1pY2FsbHkNCj4gPiBjaGFuZ2lu
ZyB0aGUgZGVmYXVsdCBkb21haW4gb2YgYSBncm91cCBpcyBhdmFpbGFibGUuDQo+IA0KPiBZZXMs
IHdlIHdhbnQgdG8gYWxsb3cgdGhlIGdyb3VwIHR5cGUgY29udHJvbCB0byB3b3JrIGZvciBhbGwg
ZHJpdmVycywNCj4gaWRlYWxseS4uLg0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGFtZWVyIEtv
bG90aHVtIDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+DQo+ID4gLS0tDQo+
ID4gICAtT25seSBkZXZpY2VzIGRvd25zdHJlYW0gZnJvbcKgZXh0ZXJuYWxseSBleHBvc2VkIFBD
SWUgaGllcmFyY2hpZXMNCj4gPiAgwqAgKHN1Y2ggYXMgVGh1bmRlcmJvbHQgb3V0c2lkZSB0aGUg
cGxhdGZvcm0pIGFyZSBjdXJyZW50bHkgbWFya2VkDQo+ID4gICAgYXMgInVudHJ1c3RlZCIuIE5v
dCBhd2FyZSBvZiBhbnkgQVJNNjQgcGxhdGZvcm1zIHRoYXQgbWF5IHVzZQ0KPiA+ICAgIHRoaXMg
dHlwZSBvZiBkZXZpY2UuDQo+ID4NCj4gPiAgwqAgTmV2ZXJ0aGVsZXNzLCB0aGUgbWFpbiBtb3Rp
dmF0aW9uIGZvciB0aGlzIHBhdGNoIGlzIHRvIGhhdmUgdGhlDQo+ID4gICAgZmxleGliaWxpdHkg
b2YgY2hhbmdpbmfCoHRoZSBpb21tdSBkZWZhdWx0IGRvbWFpbiBmb3IgYSBncm91cCBiYXNlZA0K
PiA+ICAgIG9uIHRoZSBzZXJpZXNbMV0gImlvbW11OiBBZGQgc3VwcG9ydCB0byBjaGFuZ2UgZGVm
YXVsdCBkb21haW4gb2YgYW4NCj4gPiAgICBpb21tdSBncm91cCIgYW5kIHRoYXQgbWFuZGF0ZXMg
dmVuZG9yIGlvbW11IGRyaXZlciB0byBwcm92aWRlIHRoaXMNCj4gPiAgICBjYWxsYmFjay4NCj4g
Pg0KPiA+ICDCoC1UaGlzIGlzIHRlc3RlZCBhbG9uZyB3aXRoIFsxXSBhbmQgd2FzIGFibGUgdG8g
Y2hhbmdlwqB0aGUgZGVmYXVsdA0KPiA+ICDCoCBkb21haW4gb2YgYW4gaW9tbXUgZ3JvdXAgb24g
YW4gSGlTaWxpY29uIEQwNiBoYXJkd2FyZS4NCj4gPg0KPiA+IDEuDQo+IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xpbnV4LWlvbW11LzIwMjAwOTI1MTkwNjIwLjE4NzMyLTEtYXNob2sucmFqQGlu
dGVsDQo+IC5jb20vDQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12
My9hcm0tc21tdS12My5jIHwgMjYNCj4gKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICAxIGZp
bGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMNCj4gYi9kcml2ZXJzL2lvbW11
L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5jDQo+ID4gaW5kZXggZTYzNGJiZTYwNTczLi5k
NWRiY2VlOTk1ZGIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUt
djMvYXJtLXNtbXUtdjMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYz
L2FybS1zbW11LXYzLmMNCj4gPiBAQCAtMjU2Nyw2ICsyNTY3LDMxIEBAIHN0YXRpYyBpbnQgYXJt
X3NtbXVfZGV2X2Rpc2FibGVfZmVhdHVyZShzdHJ1Y3QNCj4gZGV2aWNlICpkZXYsDQo+ID4gICAJ
fQ0KPiA+ICAgfQ0KPiA+DQo+ID4gKy8qDQo+ID4gKyAqIFJldHVybiB0aGUgcmVxdWlyZWQgZGVm
YXVsdCBkb21haW4gdHlwZSBmb3IgYSBzcGVjaWZpYyBkZXZpY2UuDQo+ID4gKyAqDQo+ID4gKyAq
IEBkZXY6IHRoZSBkZXZpY2UgaW4gcXVlcnkNCj4gPiArICoNCj4gPiArICogUmV0dXJuczoNCj4g
PiArICogIC0gSU9NTVVfRE9NQUlOX0RNQTogZGV2aWNlIHJlcXVpcmVzIGEgZHluYW1pYyBtYXBw
aW5nIGRvbWFpbg0KPiA+ICsgKiAgLSAwOiBib3RoIGlkZW50aXR5IGFuZCBkeW5hbWljIGRvbWFp
bnMgd29yayBmb3IgdGhpcyBkZXZpY2UNCj4gPiArICovDQo+ID4gK3N0YXRpYyBpbnQgYXJtX3Nt
bXVfZGVmX2RvbWFpbl90eXBlKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiArew0KPiA+ICsJaWYg
KGRldl9pc19wY2koZGV2KSkgew0KPiA+ICsJCXN0cnVjdCBwY2lfZGV2ICpwZGV2ID0gdG9fcGNp
X2RldihkZXYpOw0KPiA+ICsNCj4gPiArCQkvKg0KPiA+ICsJCSAqIFByZXZlbnQgYW55IGRldmlj
ZSBtYXJrZWQgYXMgdW50cnVzdGVkIGZyb20gZ2V0dGluZw0KPiA+ICsJCSAqIHBsYWNlZCBpbnRv
IHRoZSBJZGVudGl0eSBtYXBwaW5nIGRvbWFpbi4NCj4gPiArCQkgKi8NCj4gPiArCQlpZiAocGRl
di0+dW50cnVzdGVkKQ0KPiA+ICsJCQlyZXR1cm4gSU9NTVVfRE9NQUlOX0RNQTsNCj4gPiArCX0N
Cj4gDQo+IFRoaXMgc2hvdWxkIGJlIHNvbWV3aGVyZSBpbiBjb3JlIGNvZGUgLSBpdCBoYXMgbm90
aGluZyB0byBkbyB3aXRoIFNNTVV2My4NCg0KQWdyZWUuDQoNCj4gPiArDQo+ID4gKwlyZXR1cm4g
MDsNCj4gDQo+IEkgZG9uJ3Qgc3RyaWN0bHkgb2JqZWN0IHRvIGFkZGluZyBhIHN0dWIgY2FsbGJh
Y2sgZm9yIHRoYXQgYml0LCBidXQgd2h5DQo+IGNhbid0IGlvbW11X2NoYW5nZV9kZXZfZGVmX2Rv
bWFpbigpIHNpbXBseSBhc3N1bWUgaXQgZnJvbSBhIE5VTEwNCj4gY2FsbGJhY2s/IFRoYXQgd29y
a3MgZm9yIGV2ZXJ5b25lLCBmb3Igbm8gZXh0cmEgY29zdCA7KQ0KDQpSaWdodC4NCg0KSGkgQXNo
b2ssDQpEbyB5b3UgaGF2ZSBhbnkgcGxhbiB0byByZXNwaW4geW91ciBzZXJpZXMgYW5kIGlzIGl0
IHBvc3NpYmxlIHRvIGluY2x1ZGUNCnRoZSBhYm92ZSBzdWdnZXN0aW9ucyBpbnRvIHRoYXQ/IFBs
ZWFzZSBsZXQgbWUga25vdy4NCg0KVGhhbmtzLA0KU2hhbWVlcg0KIA0KPiBSb2Jpbi4NCj4gDQo+
ID4gK30NCj4gPiArDQo+ID4gICBzdGF0aWMgc3RydWN0IGlvbW11X29wcyBhcm1fc21tdV9vcHMg
PSB7DQo+ID4gICAJLmNhcGFibGUJCT0gYXJtX3NtbXVfY2FwYWJsZSwNCj4gPiAgIAkuZG9tYWlu
X2FsbG9jCQk9IGFybV9zbW11X2RvbWFpbl9hbGxvYywNCj4gPiBAQCAtMjU4OSw2ICsyNjE0LDcg
QEAgc3RhdGljIHN0cnVjdCBpb21tdV9vcHMgYXJtX3NtbXVfb3BzID0gew0KPiA+ICAgCS5kZXZf
ZmVhdF9lbmFibGVkCT0gYXJtX3NtbXVfZGV2X2ZlYXR1cmVfZW5hYmxlZCwNCj4gPiAgIAkuZGV2
X2VuYWJsZV9mZWF0CT0gYXJtX3NtbXVfZGV2X2VuYWJsZV9mZWF0dXJlLA0KPiA+ICAgCS5kZXZf
ZGlzYWJsZV9mZWF0CT0gYXJtX3NtbXVfZGV2X2Rpc2FibGVfZmVhdHVyZSwNCj4gPiArCS5kZWZf
ZG9tYWluX3R5cGUJPSBhcm1fc21tdV9kZWZfZG9tYWluX3R5cGUsDQo+ID4gICAJLnBnc2l6ZV9i
aXRtYXAJCT0gLTFVTCwgLyogUmVzdHJpY3RlZCBkdXJpbmcgZGV2aWNlIGF0dGFjaCAqLw0KPiA+
ICAgfTsNCj4gPg0KPiA+DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9t
bXU=
