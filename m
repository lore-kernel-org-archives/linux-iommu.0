Return-Path: <SRS0=FWOh=HO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AD7C433E0
	for <iommu@archiver.kernel.org>; Fri, 12 Feb 2021 16:45:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BE9064E9D
	for <iommu@archiver.kernel.org>; Fri, 12 Feb 2021 16:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE9064E9D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 12AD886949;
	Fri, 12 Feb 2021 16:45:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6kZ9MeKfvFj3; Fri, 12 Feb 2021 16:45:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 44F14868E4;
	Fri, 12 Feb 2021 16:45:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1DACAC0174;
	Fri, 12 Feb 2021 16:45:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3834C013A
 for <iommu@lists.linux-foundation.org>; Fri, 12 Feb 2021 16:45:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9258386937
 for <iommu@lists.linux-foundation.org>; Fri, 12 Feb 2021 16:45:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EjaeVmT6B625 for <iommu@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 16:45:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A56A3868E4
 for <iommu@lists.linux-foundation.org>; Fri, 12 Feb 2021 16:45:16 +0000 (UTC)
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.53])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4DcfRp21Rgz13t1p;
 Sat, 13 Feb 2021 00:42:30 +0800 (CST)
Received: from dggemm751-chm.china.huawei.com (10.1.198.57) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Sat, 13 Feb 2021 00:44:49 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggemm751-chm.china.huawei.com (10.1.198.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sat, 13 Feb 2021 00:44:48 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2106.006; Fri, 12 Feb 2021 16:44:46 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Robin Murphy <robin.murphy@arm.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH v2] iommu: Check dev->iommu in iommu_dev_xxx functions
Thread-Topic: [PATCH v2] iommu: Check dev->iommu in iommu_dev_xxx functions
Thread-Index: AdcBTrfjz4ngs6VWSn6F9Rp3qrl5mQADsiaAAAAQ0NA=
Date: Fri, 12 Feb 2021 16:44:46 +0000
Message-ID: <501a26a47f6649fc8920d0a308009a5d@huawei.com>
References: <c82f6d0cced74c43947714e7de576d5a@huawei.com>
 <d541ebeb-5b89-7a9d-50a2-3867f9cf78b3@arm.com>
In-Reply-To: <d541ebeb-5b89-7a9d-50a2-3867f9cf78b3@arm.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iaW4gTXVycGh5IFtt
YWlsdG86cm9iaW4ubXVycGh5QGFybS5jb21dDQo+IFNlbnQ6IDEyIEZlYnJ1YXJ5IDIwMjEgMTY6
MzkNCj4gVG86IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkgPHNoYW1lZXJhbGkua29sb3RodW0u
dGhvZGlAaHVhd2VpLmNvbT47DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGlvbW11
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnDQo+IENjOiBqb3JvQDhieXRlcy5vcmc7IGplYW4t
cGhpbGlwcGVAbGluYXJvLm9yZzsgd2lsbEBrZXJuZWwub3JnOyBaZW5ndGFvIChCKQ0KPiA8cHJp
bWUuemVuZ0BoaXNpbGljb24uY29tPjsgbGludXhhcm1Ab3BlbmV1bGVyLm9yZw0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHYyXSBpb21tdTogQ2hlY2sgZGV2LT5pb21tdSBpbiBpb21tdV9kZXZfeHh4
IGZ1bmN0aW9ucw0KPiANCj4gT24gMjAyMS0wMi0xMiAxNDo1NCwgU2hhbWVlcmFsaSBLb2xvdGh1
bSBUaG9kaSB3cm90ZToNCj4gPiBIaSBSb2Jpbi9Kb2VyZywNCj4gPg0KPiA+PiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBTaGFtZWVyIEtvbG90aHVtIFttYWlsdG86c2hh
bWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tXQ0KPiA+PiBTZW50OiAwMSBGZWJydWFy
eSAyMDIxIDEyOjQxDQo+ID4+IFRvOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBpb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZw0KPiA+PiBDYzogam9yb0A4Ynl0ZXMub3JnOyBy
b2Jpbi5tdXJwaHlAYXJtLmNvbTsgamVhbi1waGlsaXBwZUBsaW5hcm8ub3JnOw0KPiA+PiB3aWxs
QGtlcm5lbC5vcmc7IFplbmd0YW8gKEIpIDxwcmltZS56ZW5nQGhpc2lsaWNvbi5jb20+Ow0KPiA+
PiBsaW51eGFybUBvcGVuZXVsZXIub3JnDQo+ID4+IFN1YmplY3Q6IFtMaW51eGFybV0gW1BBVENI
IHYyXSBpb21tdTogQ2hlY2sgZGV2LT5pb21tdSBpbg0KPiBpb21tdV9kZXZfeHh4DQo+ID4+IGZ1
bmN0aW9ucw0KPiA+Pg0KPiA+PiBUaGUgZGV2aWNlIGlvbW11IHByb2JlL2F0dGFjaCBtaWdodCBo
YXZlIGZhaWxlZCBsZWF2aW5nIGRldi0+aW9tbXUNCj4gPj4gdG8gTlVMTCBhbmQgZGV2aWNlIGRy
aXZlcnMgbWF5IHN0aWxsIGludm9rZSB0aGVzZSBmdW5jdGlvbnMgcmVzdWx0aW5nDQo+ID4+IGlu
IGEgY3Jhc2ggaW4gaW9tbXUgdmVuZG9yIGRyaXZlciBjb2RlLiBIZW5jZSBtYWtlIHN1cmUgd2Ug
Y2hlY2sgdGhhdC4NCj4gPj4NCj4gPj4gQWxzbyBhZGRlZCBpb21tdV9vcHMgdG8gdGhlICJzdHJ1
Y3QgZGV2X2lvbW11IiBhbmQgc2V0IGl0IGlmIHRoZSBkZXYNCj4gPj4gaXMgc3VjY2Vzc2Z1bGx5
IGFzc29jaWF0ZWQgd2l0aCBhbiBpb21tdS4NCj4gPj4NCj4gPj4gRml4ZXM6wqBhM2ExOTU5Mjlk
NDAgKCJpb21tdTogQWRkIEFQSXMgZm9yIG11bHRpcGxlIGRvbWFpbnMgcGVyIGRldmljZSIpDQo+
ID4+IFNpZ25lZC1vZmYtYnk6IFNoYW1lZXIgS29sb3RodW0NCj4gPHNoYW1lZXJhbGkua29sb3Ro
dW0udGhvZGlAaHVhd2VpLmNvbT4NCj4gPj4gLS0tDQo+ID4+IHYxIC0tPiB2MjoNCj4gPj4gICAt
QWRkZWQgaW9tbXVfb3BzIHRvIHN0cnVjdCBkZXZfaW9tbXUgYmFzZWQgb24gdGhlIGRpc2N1c3Np
b24gd2l0aA0KPiBSb2Jpbi4NCj4gPj4gICAtUmViYXNlZCBhZ2FpbnN0IGlvbW11LXRyZWUgY29y
ZSBicmFuY2guDQo+ID4NCj4gPiBBIGdlbnRsZSBwaW5nIG9uIHRoaXMuLi4NCj4gDQo+IElzIHRo
ZXJlIGEgY29udmluY2luZyBqdXN0aWZpY2F0aW9uIGZvciBtYWludGFpbmluZyB5ZXQgYW5vdGhl
ciBjb3B5IG9mDQo+IHRoZSBvcHMgcG9pbnRlciByYXRoZXIgdGhhbiBzaW1wbHkgZGVyZWZlcmVu
Y2luZyBpb21tdV9kZXYtPm9wcyBhdCBwb2ludA0KPiBvZiB1c2U/DQo+IA0KDQpUQkgsIG5vdGhp
bmcgSSBjYW4gdGhpbmsgb2Ygbm93LiBUaGF0IHdhcyBtYWlubHkgdGhlIHdheSBJIGludGVycHJl
dGVkIHlvdXIgc3VnZ2VzdGlvbg0KZnJvbSB0aGUgdjEuICBOb3cgaXQgbG9va3MgbGlrZSB5b3Ug
ZGlkbuKAmXQgbWVhbiBpdCA6KS4gSSBhbSBPayB0byByZXdvcmsgaXQgdG8gZGVyZWZlcmVuY2UN
Cml0IGZyb20gaW9tbXVfZGV2LiBQbGVhc2UgbGV0IG1lIGtub3cuDQoNClRoYW5rcywNClNoYW1l
ZXINCg0KPiBSb2Jpbi4NCj4gDQo+ID4gVGhhbmtzLA0KPiA+IFNoYW1lZXINCj4gPg0KPiA+PiAt
LS0NCj4gPj4gICBkcml2ZXJzL2lvbW11L2lvbW11LmMgfCAxOSArKysrKysrLS0tLS0tLS0tLS0t
DQo+ID4+ICAgaW5jbHVkZS9saW51eC9pb21tdS5oIHwgIDIgKysNCj4gPj4gICAyIGZpbGVzIGNo
YW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2lvbW11L2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L2lvbW11LmMNCj4g
Pj4gaW5kZXggZmQ3NmUyZjU3OWZlLi42MDIzZDBiN2M1NDIgMTAwNjQ0DQo+ID4+IC0tLSBhL2Ry
aXZlcnMvaW9tbXUvaW9tbXUuYw0KPiA+PiArKysgYi9kcml2ZXJzL2lvbW11L2lvbW11LmMNCj4g
Pj4gQEAgLTIxNyw2ICsyMTcsNyBAQCBzdGF0aWMgaW50IF9faW9tbXVfcHJvYmVfZGV2aWNlKHN0
cnVjdCBkZXZpY2UNCj4gKmRldiwNCj4gPj4gc3RydWN0IGxpc3RfaGVhZCAqZ3JvdXBfbGlzdA0K
PiA+PiAgIAl9DQo+ID4+DQo+ID4+ICAgCWRldi0+aW9tbXUtPmlvbW11X2RldiA9IGlvbW11X2Rl
djsNCj4gPj4gKwlkZXYtPmlvbW11LT5vcHMgPSBpb21tdV9kZXYtPm9wczsNCj4gPj4NCj4gPj4g
ICAJZ3JvdXAgPSBpb21tdV9ncm91cF9nZXRfZm9yX2RldihkZXYpOw0KPiA+PiAgIAlpZiAoSVNf
RVJSKGdyb3VwKSkgew0KPiA+PiBAQCAtMjg2NSwxMCArMjg2Niw4IEBADQo+IEVYUE9SVF9TWU1C
T0xfR1BMKGlvbW11X2Z3c3BlY19hZGRfaWRzKTsNCj4gPj4gICAgKi8NCj4gPj4gICBpbnQgaW9t
bXVfZGV2X2VuYWJsZV9mZWF0dXJlKHN0cnVjdCBkZXZpY2UgKmRldiwgZW51bQ0KPiA+PiBpb21t
dV9kZXZfZmVhdHVyZXMgZmVhdCkNCj4gPj4gICB7DQo+ID4+IC0JY29uc3Qgc3RydWN0IGlvbW11
X29wcyAqb3BzID0gZGV2LT5idXMtPmlvbW11X29wczsNCj4gPj4gLQ0KPiA+PiAtCWlmIChvcHMg
JiYgb3BzLT5kZXZfZW5hYmxlX2ZlYXQpDQo+ID4+IC0JCXJldHVybiBvcHMtPmRldl9lbmFibGVf
ZmVhdChkZXYsIGZlYXQpOw0KPiA+PiArCWlmIChkZXYtPmlvbW11ICYmIGRldi0+aW9tbXUtPm9w
cy0+ZGV2X2VuYWJsZV9mZWF0KQ0KPiA+PiArCQlyZXR1cm4gZGV2LT5pb21tdS0+b3BzLT5kZXZf
ZW5hYmxlX2ZlYXQoZGV2LCBmZWF0KTsNCj4gPj4NCj4gPj4gICAJcmV0dXJuIC1FTk9ERVY7DQo+
ID4+ICAgfQ0KPiA+PiBAQCAtMjg4MSwxMCArMjg4MCw4IEBADQo+ID4+IEVYUE9SVF9TWU1CT0xf
R1BMKGlvbW11X2Rldl9lbmFibGVfZmVhdHVyZSk7DQo+ID4+ICAgICovDQo+ID4+ICAgaW50IGlv
bW11X2Rldl9kaXNhYmxlX2ZlYXR1cmUoc3RydWN0IGRldmljZSAqZGV2LCBlbnVtDQo+ID4+IGlv
bW11X2Rldl9mZWF0dXJlcyBmZWF0KQ0KPiA+PiAgIHsNCj4gPj4gLQljb25zdCBzdHJ1Y3QgaW9t
bXVfb3BzICpvcHMgPSBkZXYtPmJ1cy0+aW9tbXVfb3BzOw0KPiA+PiAtDQo+ID4+IC0JaWYgKG9w
cyAmJiBvcHMtPmRldl9kaXNhYmxlX2ZlYXQpDQo+ID4+IC0JCXJldHVybiBvcHMtPmRldl9kaXNh
YmxlX2ZlYXQoZGV2LCBmZWF0KTsNCj4gPj4gKwlpZiAoZGV2LT5pb21tdSAmJiBkZXYtPmlvbW11
LT5vcHMtPmRldl9kaXNhYmxlX2ZlYXQpDQo+ID4+ICsJCXJldHVybiBkZXYtPmlvbW11LT5vcHMt
PmRldl9kaXNhYmxlX2ZlYXQoZGV2LCBmZWF0KTsNCj4gPj4NCj4gPj4gICAJcmV0dXJuIC1FQlVT
WTsNCj4gPj4gICB9DQo+ID4+IEBAIC0yODkyLDEwICsyODg5LDggQEANCj4gPj4gRVhQT1JUX1NZ
TUJPTF9HUEwoaW9tbXVfZGV2X2Rpc2FibGVfZmVhdHVyZSk7DQo+ID4+DQo+ID4+ICAgYm9vbCBp
b21tdV9kZXZfZmVhdHVyZV9lbmFibGVkKHN0cnVjdCBkZXZpY2UgKmRldiwgZW51bQ0KPiA+PiBp
b21tdV9kZXZfZmVhdHVyZXMgZmVhdCkNCj4gPj4gICB7DQo+ID4+IC0JY29uc3Qgc3RydWN0IGlv
bW11X29wcyAqb3BzID0gZGV2LT5idXMtPmlvbW11X29wczsNCj4gPj4gLQ0KPiA+PiAtCWlmIChv
cHMgJiYgb3BzLT5kZXZfZmVhdF9lbmFibGVkKQ0KPiA+PiAtCQlyZXR1cm4gb3BzLT5kZXZfZmVh
dF9lbmFibGVkKGRldiwgZmVhdCk7DQo+ID4+ICsJaWYgKGRldi0+aW9tbXUgJiYgZGV2LT5pb21t
dS0+b3BzLT5kZXZfZmVhdF9lbmFibGVkKQ0KPiA+PiArCQlyZXR1cm4gZGV2LT5pb21tdS0+b3Bz
LT5kZXZfZmVhdF9lbmFibGVkKGRldiwgZmVhdCk7DQo+ID4+DQo+ID4+ICAgCXJldHVybiBmYWxz
ZTsNCj4gPj4gICB9DQo+ID4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2lvbW11LmggYi9p
bmNsdWRlL2xpbnV4L2lvbW11LmgNCj4gPj4gaW5kZXggNTI0ZmZjMmZmNjRmLi5mZjBjNzZiZGZi
NjcgMTAwNjQ0DQo+ID4+IC0tLSBhL2luY2x1ZGUvbGludXgvaW9tbXUuaA0KPiA+PiArKysgYi9p
bmNsdWRlL2xpbnV4L2lvbW11LmgNCj4gPj4gQEAgLTM1NCw2ICszNTQsNyBAQCBzdHJ1Y3QgaW9t
bXVfZmF1bHRfcGFyYW0gew0KPiA+PiAgICAqIEBmYXVsdF9wYXJhbTogSU9NTVUgZGV0ZWN0ZWQg
ZGV2aWNlIGZhdWx0IHJlcG9ydGluZyBkYXRhDQo+ID4+ICAgICogQGZ3c3BlYzoJIElPTU1VIGZ3
c3BlYyBkYXRhDQo+ID4+ICAgICogQGlvbW11X2RldjoJIElPTU1VIGRldmljZSB0aGlzIGRldmlj
ZSBpcyBsaW5rZWQgdG8NCj4gPj4gKyAqIEBvcHM6CSBpb21tdS1vcHMgZm9yIHRhbGtpbmcgdG8g
dGhlIGlvbW11X2Rldg0KPiA+PiAgICAqIEBwcml2OgkgSU9NTVUgRHJpdmVyIHByaXZhdGUgZGF0
YQ0KPiA+PiAgICAqDQo+ID4+ICAgICogVE9ETzogbWlncmF0ZSBvdGhlciBwZXIgZGV2aWNlIGRh
dGEgcG9pbnRlcnMgdW5kZXINCj4gaW9tbXVfZGV2X2RhdGEsDQo+ID4+IGUuZy4NCj4gPj4gQEAg
LTM2NCw2ICszNjUsNyBAQCBzdHJ1Y3QgZGV2X2lvbW11IHsNCj4gPj4gICAJc3RydWN0IGlvbW11
X2ZhdWx0X3BhcmFtCSpmYXVsdF9wYXJhbTsNCj4gPj4gICAJc3RydWN0IGlvbW11X2Z3c3BlYwkJ
KmZ3c3BlYzsNCj4gPj4gICAJc3RydWN0IGlvbW11X2RldmljZQkJKmlvbW11X2RldjsNCj4gPj4g
Kwljb25zdCBzdHJ1Y3QgaW9tbXVfb3BzCQkqb3BzOw0KPiA+PiAgIAl2b2lkCQkJCSpwcml2Ow0K
PiA+PiAgIH07DQo+ID4+DQo+ID4+IC0tDQo+ID4+IDIuMTcuMQ0KPiA+PiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiA+PiBMaW51eGFybSBtYWlsaW5n
IGxpc3QgLS0gbGludXhhcm1Ab3BlbmV1bGVyLm9yZw0KPiA+PiBUbyB1bnN1YnNjcmliZSBzZW5k
IGFuIGVtYWlsIHRvIGxpbnV4YXJtLWxlYXZlQG9wZW5ldWxlci5vcmcNCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
