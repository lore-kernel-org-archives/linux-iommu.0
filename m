Return-Path: <SRS0=FWOh=HO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5D0C433DB
	for <iommu@archiver.kernel.org>; Fri, 12 Feb 2021 14:54:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4827D64E6C
	for <iommu@archiver.kernel.org>; Fri, 12 Feb 2021 14:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4827D64E6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E691586AB7;
	Fri, 12 Feb 2021 14:54:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c_yw8Z_gBzt4; Fri, 12 Feb 2021 14:54:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 492F686966;
	Fri, 12 Feb 2021 14:54:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3766FC0174;
	Fri, 12 Feb 2021 14:54:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 428A2C013A
 for <iommu@lists.linux-foundation.org>; Fri, 12 Feb 2021 14:54:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3A42386A29
 for <iommu@lists.linux-foundation.org>; Fri, 12 Feb 2021 14:54:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T6pL2H4jtt77 for <iommu@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 14:54:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BEF8686966
 for <iommu@lists.linux-foundation.org>; Fri, 12 Feb 2021 14:54:53 +0000 (UTC)
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.55])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Dcc0v27n9z13t1L;
 Fri, 12 Feb 2021 22:52:31 +0800 (CST)
Received: from dggemm752-chm.china.huawei.com (10.1.198.58) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 12 Feb 2021 22:54:50 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggemm752-chm.china.huawei.com (10.1.198.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 12 Feb 2021 22:54:49 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2106.006; Fri, 12 Feb 2021 14:54:47 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH v2] iommu: Check dev->iommu in iommu_dev_xxx functions
Thread-Topic: [PATCH v2] iommu: Check dev->iommu in iommu_dev_xxx functions
Thread-Index: AdcBTrfjz4ngs6VWSn6F9Rp3qrl5mQ==
Date: Fri, 12 Feb 2021 14:54:47 +0000
Message-ID: <c82f6d0cced74c43947714e7de576d5a@huawei.com>
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
 \(B\)" <prime.zeng@hisilicon.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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

SGkgUm9iaW4vSm9lcmcsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
U2hhbWVlciBLb2xvdGh1bSBbbWFpbHRvOnNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2Vp
LmNvbV0NCj4gU2VudDogMDEgRmVicnVhcnkgMjAyMSAxMjo0MQ0KPiBUbzogbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcNCj4gQ2M6
IGpvcm9AOGJ5dGVzLm9yZzsgcm9iaW4ubXVycGh5QGFybS5jb207IGplYW4tcGhpbGlwcGVAbGlu
YXJvLm9yZzsNCj4gd2lsbEBrZXJuZWwub3JnOyBaZW5ndGFvIChCKSA8cHJpbWUuemVuZ0BoaXNp
bGljb24uY29tPjsNCj4gbGludXhhcm1Ab3BlbmV1bGVyLm9yZw0KPiBTdWJqZWN0OiBbTGludXhh
cm1dIFtQQVRDSCB2Ml0gaW9tbXU6IENoZWNrIGRldi0+aW9tbXUgaW4gaW9tbXVfZGV2X3h4eA0K
PiBmdW5jdGlvbnMNCj4gDQo+IFRoZSBkZXZpY2UgaW9tbXUgcHJvYmUvYXR0YWNoIG1pZ2h0IGhh
dmUgZmFpbGVkIGxlYXZpbmcgZGV2LT5pb21tdQ0KPiB0byBOVUxMIGFuZCBkZXZpY2UgZHJpdmVy
cyBtYXkgc3RpbGwgaW52b2tlIHRoZXNlIGZ1bmN0aW9ucyByZXN1bHRpbmcNCj4gaW4gYSBjcmFz
aCBpbiBpb21tdSB2ZW5kb3IgZHJpdmVyIGNvZGUuIEhlbmNlIG1ha2Ugc3VyZSB3ZSBjaGVjayB0
aGF0Lg0KPiANCj4gQWxzbyBhZGRlZCBpb21tdV9vcHMgdG8gdGhlICJzdHJ1Y3QgZGV2X2lvbW11
IiBhbmQgc2V0IGl0IGlmIHRoZSBkZXYNCj4gaXMgc3VjY2Vzc2Z1bGx5IGFzc29jaWF0ZWQgd2l0
aCBhbiBpb21tdS4NCj4gDQo+IEZpeGVzOsKgYTNhMTk1OTI5ZDQwICgiaW9tbXU6IEFkZCBBUElz
IGZvciBtdWx0aXBsZSBkb21haW5zIHBlciBkZXZpY2UiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBTaGFt
ZWVyIEtvbG90aHVtIDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+DQo+IC0t
LQ0KPiB2MSAtLT4gdjI6DQo+ICAtQWRkZWQgaW9tbXVfb3BzIHRvIHN0cnVjdCBkZXZfaW9tbXUg
YmFzZWQgb24gdGhlIGRpc2N1c3Npb24gd2l0aCBSb2Jpbi4NCj4gIC1SZWJhc2VkIGFnYWluc3Qg
aW9tbXUtdHJlZSBjb3JlIGJyYW5jaC4NCg0KQSBnZW50bGUgcGluZyBvbiB0aGlzLi4uDQoNClRo
YW5rcywNClNoYW1lZXINCg0KPiAtLS0NCj4gIGRyaXZlcnMvaW9tbXUvaW9tbXUuYyB8IDE5ICsr
KysrKystLS0tLS0tLS0tLS0NCj4gIGluY2x1ZGUvbGludXgvaW9tbXUuaCB8ICAyICsrDQo+ICAy
IGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pb21tdS5jIGIvZHJpdmVycy9pb21tdS9pb21tdS5j
DQo+IGluZGV4IGZkNzZlMmY1NzlmZS4uNjAyM2QwYjdjNTQyIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2lvbW11L2lvbW11LmMNCj4gKysrIGIvZHJpdmVycy9pb21tdS9pb21tdS5jDQo+IEBAIC0y
MTcsNiArMjE3LDcgQEAgc3RhdGljIGludCBfX2lvbW11X3Byb2JlX2RldmljZShzdHJ1Y3QgZGV2
aWNlICpkZXYsDQo+IHN0cnVjdCBsaXN0X2hlYWQgKmdyb3VwX2xpc3QNCj4gIAl9DQo+IA0KPiAg
CWRldi0+aW9tbXUtPmlvbW11X2RldiA9IGlvbW11X2RldjsNCj4gKwlkZXYtPmlvbW11LT5vcHMg
PSBpb21tdV9kZXYtPm9wczsNCj4gDQo+ICAJZ3JvdXAgPSBpb21tdV9ncm91cF9nZXRfZm9yX2Rl
dihkZXYpOw0KPiAgCWlmIChJU19FUlIoZ3JvdXApKSB7DQo+IEBAIC0yODY1LDEwICsyODY2LDgg
QEAgRVhQT1JUX1NZTUJPTF9HUEwoaW9tbXVfZndzcGVjX2FkZF9pZHMpOw0KPiAgICovDQo+ICBp
bnQgaW9tbXVfZGV2X2VuYWJsZV9mZWF0dXJlKHN0cnVjdCBkZXZpY2UgKmRldiwgZW51bQ0KPiBp
b21tdV9kZXZfZmVhdHVyZXMgZmVhdCkNCj4gIHsNCj4gLQljb25zdCBzdHJ1Y3QgaW9tbXVfb3Bz
ICpvcHMgPSBkZXYtPmJ1cy0+aW9tbXVfb3BzOw0KPiAtDQo+IC0JaWYgKG9wcyAmJiBvcHMtPmRl
dl9lbmFibGVfZmVhdCkNCj4gLQkJcmV0dXJuIG9wcy0+ZGV2X2VuYWJsZV9mZWF0KGRldiwgZmVh
dCk7DQo+ICsJaWYgKGRldi0+aW9tbXUgJiYgZGV2LT5pb21tdS0+b3BzLT5kZXZfZW5hYmxlX2Zl
YXQpDQo+ICsJCXJldHVybiBkZXYtPmlvbW11LT5vcHMtPmRldl9lbmFibGVfZmVhdChkZXYsIGZl
YXQpOw0KPiANCj4gIAlyZXR1cm4gLUVOT0RFVjsNCj4gIH0NCj4gQEAgLTI4ODEsMTAgKzI4ODAs
OCBAQA0KPiBFWFBPUlRfU1lNQk9MX0dQTChpb21tdV9kZXZfZW5hYmxlX2ZlYXR1cmUpOw0KPiAg
ICovDQo+ICBpbnQgaW9tbXVfZGV2X2Rpc2FibGVfZmVhdHVyZShzdHJ1Y3QgZGV2aWNlICpkZXYs
IGVudW0NCj4gaW9tbXVfZGV2X2ZlYXR1cmVzIGZlYXQpDQo+ICB7DQo+IC0JY29uc3Qgc3RydWN0
IGlvbW11X29wcyAqb3BzID0gZGV2LT5idXMtPmlvbW11X29wczsNCj4gLQ0KPiAtCWlmIChvcHMg
JiYgb3BzLT5kZXZfZGlzYWJsZV9mZWF0KQ0KPiAtCQlyZXR1cm4gb3BzLT5kZXZfZGlzYWJsZV9m
ZWF0KGRldiwgZmVhdCk7DQo+ICsJaWYgKGRldi0+aW9tbXUgJiYgZGV2LT5pb21tdS0+b3BzLT5k
ZXZfZGlzYWJsZV9mZWF0KQ0KPiArCQlyZXR1cm4gZGV2LT5pb21tdS0+b3BzLT5kZXZfZGlzYWJs
ZV9mZWF0KGRldiwgZmVhdCk7DQo+IA0KPiAgCXJldHVybiAtRUJVU1k7DQo+ICB9DQo+IEBAIC0y
ODkyLDEwICsyODg5LDggQEANCj4gRVhQT1JUX1NZTUJPTF9HUEwoaW9tbXVfZGV2X2Rpc2FibGVf
ZmVhdHVyZSk7DQo+IA0KPiAgYm9vbCBpb21tdV9kZXZfZmVhdHVyZV9lbmFibGVkKHN0cnVjdCBk
ZXZpY2UgKmRldiwgZW51bQ0KPiBpb21tdV9kZXZfZmVhdHVyZXMgZmVhdCkNCj4gIHsNCj4gLQlj
b25zdCBzdHJ1Y3QgaW9tbXVfb3BzICpvcHMgPSBkZXYtPmJ1cy0+aW9tbXVfb3BzOw0KPiAtDQo+
IC0JaWYgKG9wcyAmJiBvcHMtPmRldl9mZWF0X2VuYWJsZWQpDQo+IC0JCXJldHVybiBvcHMtPmRl
dl9mZWF0X2VuYWJsZWQoZGV2LCBmZWF0KTsNCj4gKwlpZiAoZGV2LT5pb21tdSAmJiBkZXYtPmlv
bW11LT5vcHMtPmRldl9mZWF0X2VuYWJsZWQpDQo+ICsJCXJldHVybiBkZXYtPmlvbW11LT5vcHMt
PmRldl9mZWF0X2VuYWJsZWQoZGV2LCBmZWF0KTsNCj4gDQo+ICAJcmV0dXJuIGZhbHNlOw0KPiAg
fQ0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9pb21tdS5oIGIvaW5jbHVkZS9saW51eC9p
b21tdS5oDQo+IGluZGV4IDUyNGZmYzJmZjY0Zi4uZmYwYzc2YmRmYjY3IDEwMDY0NA0KPiAtLS0g
YS9pbmNsdWRlL2xpbnV4L2lvbW11LmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9pb21tdS5oDQo+
IEBAIC0zNTQsNiArMzU0LDcgQEAgc3RydWN0IGlvbW11X2ZhdWx0X3BhcmFtIHsNCj4gICAqIEBm
YXVsdF9wYXJhbTogSU9NTVUgZGV0ZWN0ZWQgZGV2aWNlIGZhdWx0IHJlcG9ydGluZyBkYXRhDQo+
ICAgKiBAZndzcGVjOgkgSU9NTVUgZndzcGVjIGRhdGENCj4gICAqIEBpb21tdV9kZXY6CSBJT01N
VSBkZXZpY2UgdGhpcyBkZXZpY2UgaXMgbGlua2VkIHRvDQo+ICsgKiBAb3BzOgkgaW9tbXUtb3Bz
IGZvciB0YWxraW5nIHRvIHRoZSBpb21tdV9kZXYNCj4gICAqIEBwcml2OgkgSU9NTVUgRHJpdmVy
IHByaXZhdGUgZGF0YQ0KPiAgICoNCj4gICAqIFRPRE86IG1pZ3JhdGUgb3RoZXIgcGVyIGRldmlj
ZSBkYXRhIHBvaW50ZXJzIHVuZGVyIGlvbW11X2Rldl9kYXRhLA0KPiBlLmcuDQo+IEBAIC0zNjQs
NiArMzY1LDcgQEAgc3RydWN0IGRldl9pb21tdSB7DQo+ICAJc3RydWN0IGlvbW11X2ZhdWx0X3Bh
cmFtCSpmYXVsdF9wYXJhbTsNCj4gIAlzdHJ1Y3QgaW9tbXVfZndzcGVjCQkqZndzcGVjOw0KPiAg
CXN0cnVjdCBpb21tdV9kZXZpY2UJCSppb21tdV9kZXY7DQo+ICsJY29uc3Qgc3RydWN0IGlvbW11
X29wcwkJKm9wczsNCj4gIAl2b2lkCQkJCSpwcml2Ow0KPiAgfTsNCj4gDQo+IC0tDQo+IDIuMTcu
MQ0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBM
aW51eGFybSBtYWlsaW5nIGxpc3QgLS0gbGludXhhcm1Ab3BlbmV1bGVyLm9yZw0KPiBUbyB1bnN1
YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4YXJtLWxlYXZlQG9wZW5ldWxlci5vcmcNCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxp
bmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
