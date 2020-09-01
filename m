Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BAEC433E2
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 09:13:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55049206A5
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 09:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55049206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 165C087074;
	Tue,  1 Sep 2020 09:13:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2bwu+IZQEaqA; Tue,  1 Sep 2020 09:13:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BB4148706D;
	Tue,  1 Sep 2020 09:13:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8CC0C07FF;
	Tue,  1 Sep 2020 09:13:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0E8AC0051
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 09:13:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B7B6387072
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 09:13:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I1SQts9NcJ78 for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 09:13:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from ZXSHCAS2.zhaoxin.com (unknown [203.148.12.82])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9A3B18706D
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 09:13:07 +0000 (UTC)
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 1 Sep 2020
 17:13:02 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 1 Sep 2020
 17:13:01 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::290a:f538:51e7:1416]) by
 zxbjmbx1.zhaoxin.com ([fe80::290a:f538:51e7:1416%16]) with mapi id
 15.01.1979.003; Tue, 1 Sep 2020 17:13:01 +0800
From: FelixCui-oc <FelixCui-oc@zhaoxin.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David
 Woodhouse" <dwmw2@infradead.org>, Dan Carpenter <dan.carpenter@oracle.com>,
 "kbuild@lists.01.org" <kbuild@lists.01.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIHYzIDIvMl0gaW9tbXUvdnQtZDpBZGQgc3VwcG9ydCBm?=
 =?gb2312?Q?or_probing_ACPI_device_in_RMRR?=
Thread-Topic: [PATCH v3 2/2] iommu/vt-d:Add support for probing ACPI device in
 RMRR
Thread-Index: AQHWfFkssCqC/uq8zUSrxxRHHTL9PKlSzvUAgAC26n8=
Date: Tue, 1 Sep 2020 09:13:01 +0000
Message-ID: <cde22f0f02f94efcae8bf044e2cd9441@zhaoxin.com>
References: <20200827100217.21324-1-FelixCui-oc@zhaoxin.com>
 <20200827100217.21324-3-FelixCui-oc@zhaoxin.com>,
 <e5b1daaf-f073-94c9-714c-832b10d284f4@linux.intel.com>
In-Reply-To: <e5b1daaf-f073-94c9-714c-832b10d284f4@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.29.8.19]
MIME-Version: 1.0
Cc: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
 CobeChen-oc <CobeChen-oc@zhaoxin.com>
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
Content-Type: multipart/mixed; boundary="===============0016849542623995408=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============0016849542623995408==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_cde22f0f02f94efcae8bf044e2cd9441zhaoxincom_"

--_000_cde22f0f02f94efcae8bf044e2cd9441zhaoxincom_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

aGkgIGJhb2x1ICwNCg0KICAgICAgICAgICAgICAgICAgIFRoZXNlIEFDUEkgZGV2aWNlcyBjYW4g
YmUgcmV0cmlldmVkIGZyb20gdGhlIGtlcm5lbCBhbmQgdGhlcmUgaXMgbm8gYm91bmQgZGV2aWNl
IGRyaXZlciAuDQoNCg0KQmVzdCByZWdhcmRzDQoNCkZlbGl4Y3VpLW9jDQoNCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fDQq3orz+yMs6IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5p
bnRlbC5jb20+DQq3osvNyrG85DogMjAyMMTqOdTCMcjVIDE0OjEyOjM0DQrK1bz+yMs6IEZlbGl4
Q3VpLW9jOyBKb2VyZyBSb2VkZWw7IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBEYXZpZCBXb29kaG91c2U7IERhbiBDYXJwZW50
ZXI7IGtidWlsZEBsaXN0cy4wMS5vcmcNCrOty806IGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbTsg
Q29iZUNoZW4tb2M7IFJheW1vbmRQYW5nLW9jOyBUb255IFcgV2FuZy1vYw0K1vfM4jogUmU6IFtQ
QVRDSCB2MyAyLzJdIGlvbW11L3Z0LWQ6QWRkIHN1cHBvcnQgZm9yIHByb2JpbmcgQUNQSSBkZXZp
Y2UgaW4gUk1SUg0KDQpIaSBGZWxpeCwNCg0KT24gOC8yNy8yMCA2OjAyIFBNLCBGZWxpeEN1aW9j
IHdyb3RlOg0KPiBBZnRlciBhY3BpIGRldmljZSBpbiBSTVJSIGlzIGRldGVjdGVkLGl0IGlzIG5l
Y2Vzc2FyeQ0KPiB0byBlc3RhYmxpc2ggYSBtYXBwaW5nIGZvciB0aGVzZSBkZXZpY2VzLg0KPiBJ
biBhY3BpX2RldmljZV9jcmVhdGVfZGlyZWN0X21hcHBpbmdzKCksY3JlYXRlIGEgbWFwcGluZw0K
PiBmb3IgdGhlIGFjcGkgZGV2aWNlIGluIFJNUlIuDQo+IEFkZCBhIGhlbHBlciB0byBhY2hpZXZl
IHRoZSBhY3BpIG5hbWVzcGFjZSBkZXZpY2UgY2FuDQo+IGFjY2VzcyB0aGUgUk1SUiByZWdpb24u
DQoNCkFyZSB0aG9zZSBBQ1BJIGRldmljZXMgdmlzaWJsZSB0byBrZXJuZWw/IElmIHNvLCBhbnkg
ZGV2aWNlIGRyaXZlciBib3VuZA0KZm9yIGl0Pw0KDQpCZXN0IHJlZ2FyZHMsDQpiYW9sdQ0KDQo+
DQo+IFNpZ25lZC1vZmYtYnk6IEZlbGl4Q3Vpb2MgPEZlbGl4Q3VpLW9jQHpoYW94aW4uY29tPg0K
PiAtLS0NCj4gICBkcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMgfCAyOSArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKw0KPiAgIGRyaXZlcnMvaW9tbXUvaW9tbXUuYyAgICAgICB8ICA2ICsr
KysrKw0KPiAgIGluY2x1ZGUvbGludXgvaW9tbXUuaCAgICAgICB8ICAzICsrKw0KPiAgIDMgZmls
ZXMgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
b21tdS9pbnRlbC9pb21tdS5jIGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jDQo+IGluZGV4
IDIwOGE5MTYwNTI4OC4uNTFkN2E1YjE4ZjQxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lvbW11
L2ludGVsL2lvbW11LmMNCj4gKysrIGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jDQo+IEBA
IC00Nzk5LDYgKzQ3OTksMjEgQEAgc3RhdGljIGludCBfX2luaXQgcGxhdGZvcm1fb3B0aW5fZm9y
Y2VfaW9tbXUodm9pZCkNCj4gICAgICAgIHJldHVybiAxOw0KPiAgIH0NCj4NCj4gK3N0YXRpYyBp
bnQgYWNwaV9kZXZpY2VfY3JlYXRlX2RpcmVjdF9tYXBwaW5ncyhzdHJ1Y3QgZGV2aWNlICpwbl9k
ZXYsIHN0cnVjdCBkZXZpY2UgKmFjcGlfZGV2aWNlKQ0KPiArew0KPiArICAgICBzdHJ1Y3QgaW9t
bXVfZ3JvdXAgKmdyb3VwOw0KPiArDQo+ICsgICAgIGFjcGlfZGV2aWNlLT5idXMtPmlvbW11X29w
cyA9ICZpbnRlbF9pb21tdV9vcHM7DQo+ICsgICAgIGdyb3VwID0gaW9tbXVfZ3JvdXBfZ2V0KHBu
X2Rldik7DQo+ICsgICAgIGlmICghZ3JvdXApIHsNCj4gKyAgICAgICAgICAgICBwcl93YXJuKCJB
Q1BJIG5hbWUgc3BhY2UgZGV2aWNlcyBjcmVhdGUgZGlyZWN0IG1hcHBpbmdzIHdyb25nIVxuIik7
DQo+ICsgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ICsgICAgIH0NCj4gKyAgICAgX19h
Y3BpX2RldmljZV9jcmVhdGVfZGlyZWN0X21hcHBpbmdzKGdyb3VwLCBhY3BpX2RldmljZSk7DQo+
ICsNCj4gKyAgICAgcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gICBzdGF0aWMgaW50IF9faW5pdCBw
cm9iZV9hY3BpX25hbWVzcGFjZV9kZXZpY2VzKHZvaWQpDQo+ICAgew0KPiAgICAgICAgc3RydWN0
IGRtYXJfZHJoZF91bml0ICpkcmhkOw0KPiBAQCAtNDgxMyw2ICs0ODI4LDcgQEAgc3RhdGljIGlu
dCBfX2luaXQgcHJvYmVfYWNwaV9uYW1lc3BhY2VfZGV2aWNlcyh2b2lkKQ0KPiAgICAgICAgICAg
ICAgICAgICAgICAgIHN0cnVjdCBhY3BpX2RldmljZV9waHlzaWNhbF9ub2RlICpwbjsNCj4gICAg
ICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgaW9tbXVfZ3JvdXAgKmdyb3VwOw0KPiAgICAgICAg
ICAgICAgICAgICAgICAgIHN0cnVjdCBhY3BpX2RldmljZSAqYWRldjsNCj4gKyAgICAgICAgICAg
ICAgICAgICAgIHN0cnVjdCBkZXZpY2UgKnBuX2RldiA9IE5VTEw7DQo+DQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgaWYgKGRldi0+YnVzICE9ICZhY3BpX2J1c190eXBlKQ0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+IEBAIC00ODIzLDYgKzQ4MzksNyBAQCBz
dGF0aWMgaW50IF9faW5pdCBwcm9iZV9hY3BpX25hbWVzcGFjZV9kZXZpY2VzKHZvaWQpDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmYWRldi0+cGh5c2ljYWxf
bm9kZV9saXN0LCBub2RlKSB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBncm91
cCA9IGlvbW11X2dyb3VwX2dldChwbi0+ZGV2KTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGlmIChncm91cCkgew0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHBuX2RldiA9IHBuLT5kZXY7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGlvbW11X2dyb3VwX3B1dChncm91cCk7DQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfQ0KPiBAQCAtNDgzMSw3ICs0ODQ4LDE5IEBAIHN0YXRpYyBpbnQgX19pbml0IHByb2JlX2Fj
cGlfbmFtZXNwYWNlX2RldmljZXModm9pZCkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHJldCA9IGlvbW11X3Byb2JlX2RldmljZShwbi0+ZGV2KTsNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGlmIChyZXQpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGJyZWFrOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwbl9kZXYg
PSBwbi0+ZGV2Ow0KPiArICAgICAgICAgICAgICAgICAgICAgfQ0KPiArICAgICAgICAgICAgICAg
ICAgICAgaWYgKCFwbl9kZXYpIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGV2
LT5idXMtPmlvbW11X29wcyA9ICZpbnRlbF9pb21tdV9vcHM7DQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHJldCA9IGlvbW11X3Byb2JlX2RldmljZShkZXYpOw0KPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBpZiAocmV0KSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgcHJfZXJyKCJhY3BpX2RldmljZSBwcm9iZSBmYWlsISByZXQ6JWRcbiIs
IHJldCk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ290byB1bmxv
Y2s7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0NCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgZ290byB1bmxvY2s7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgfQ0K
PiArICAgICAgICAgICAgICAgICAgICAgcmV0ID0gYWNwaV9kZXZpY2VfY3JlYXRlX2RpcmVjdF9t
YXBwaW5ncyhwbl9kZXYsIGRldik7DQo+ICt1bmxvY2s6DQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgbXV0ZXhfdW5sb2NrKCZhZGV2LT5waHlzaWNhbF9ub2RlX2xvY2spOw0KPg0KPiAgICAgICAg
ICAgICAgICAgICAgICAgIGlmIChyZXQpDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2lv
bW11LmMgYi9kcml2ZXJzL2lvbW11L2lvbW11LmMNCj4gaW5kZXggNjA5YmQyNWJmMTU0Li40Zjcx
NGEyZDVlZjcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW9tbXUuYw0KPiArKysgYi9k
cml2ZXJzL2lvbW11L2lvbW11LmMNCj4gQEAgLTc3OSw2ICs3NzksMTIgQEAgc3RhdGljIGJvb2wg
aW9tbXVfaXNfYXR0YWNoX2RlZmVycmVkKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiwNCj4g
ICAgICAgIHJldHVybiBmYWxzZTsNCj4gICB9DQo+DQo+ICt2b2lkICBfX2FjcGlfZGV2aWNlX2Ny
ZWF0ZV9kaXJlY3RfbWFwcGluZ3Moc3RydWN0IGlvbW11X2dyb3VwICpncm91cCwgc3RydWN0IGRl
dmljZSAqYWNwaV9kZXZpY2UpDQo+ICt7DQo+ICsgICAgIGlvbW11X2NyZWF0ZV9kZXZpY2VfZGly
ZWN0X21hcHBpbmdzKGdyb3VwLCBhY3BpX2RldmljZSk7DQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9M
X0dQTChfX2FjcGlfZGV2aWNlX2NyZWF0ZV9kaXJlY3RfbWFwcGluZ3MpOw0KPiArDQo+ICAgLyoq
DQo+ICAgICogaW9tbXVfZ3JvdXBfYWRkX2RldmljZSAtIGFkZCBhIGRldmljZSB0byBhbiBpb21t
dSBncm91cA0KPiAgICAqIEBncm91cDogdGhlIGdyb3VwIGludG8gd2hpY2ggdG8gYWRkIHRoZSBk
ZXZpY2UgKHJlZmVyZW5jZSBzaG91bGQgYmUgaGVsZCkNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
bGludXgvaW9tbXUuaCBiL2luY2x1ZGUvbGludXgvaW9tbXUuaA0KPiBpbmRleCBmZWUyMDllZmI3
NTYuLjliZTEzNDc3NTg4NiAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9pb21tdS5oDQo+
ICsrKyBiL2luY2x1ZGUvbGludXgvaW9tbXUuaA0KPiBAQCAtNTE0LDYgKzUxNCw5IEBAIGV4dGVy
biB2b2lkIGlvbW11X2RvbWFpbl93aW5kb3dfZGlzYWJsZShzdHJ1Y3QgaW9tbXVfZG9tYWluICpk
b21haW4sIHUzMiB3bmRfbnIpDQo+ICAgZXh0ZXJuIGludCByZXBvcnRfaW9tbXVfZmF1bHQoc3Ry
dWN0IGlvbW11X2RvbWFpbiAqZG9tYWluLCBzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBpb3ZhLCBpbnQgZmxhZ3MpOw0KPg0K
PiArZXh0ZXJuIHZvaWQgX19hY3BpX2RldmljZV9jcmVhdGVfZGlyZWN0X21hcHBpbmdzKHN0cnVj
dCBpb21tdV9ncm91cCAqZ3JvdXAsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBzdHJ1Y3QgZGV2aWNlICphY3BpX2RldmljZSk7DQo+ICsNCj4gICBzdGF0
aWMgaW5saW5lIHZvaWQgaW9tbXVfZmx1c2hfdGxiX2FsbChzdHJ1Y3QgaW9tbXVfZG9tYWluICpk
b21haW4pDQo+ICAgew0KPiAgICAgICAgaWYgKGRvbWFpbi0+b3BzLT5mbHVzaF9pb3RsYl9hbGwp
DQo+DQo=

--_000_cde22f0f02f94efcae8bf044e2cd9441zhaoxincom_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<meta content=3D"text/html; charset=3DUTF-8">
<style type=3D"text/css" style=3D"">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Helvetica,sans-serif">
<p></p>
<p style=3D"font-family:Calibri,Helvetica,sans-serif,EmojiFont,&quot;Apple =
Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI =
Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols; font-size:16px">
hi&nbsp; baolu ,&nbsp;</p>
<p style=3D"font-family:Calibri,Helvetica,sans-serif,EmojiFont,&quot;Apple =
Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI =
Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols; font-size:16px">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;These =
ACPI devices can be retrieved from the kernel and there is no bound device =
driver .</p>
<br>
<p></p>
<p>Best regards</p>
<p>Felixcui-oc</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>=B7=A2=BC=FE=C8=CB:</b> Lu Ba=
olu &lt;baolu.lu@linux.intel.com&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> 2020=C4=EA9=D4=C21=C8=D5 14:12:34<br>
<b>=CA=D5=BC=FE=C8=CB:</b> FelixCui-oc; Joerg Roedel; iommu@lists.linux-fou=
ndation.org; linux-kernel@vger.kernel.org; David Woodhouse; Dan Carpenter; =
kbuild@lists.01.org<br>
<b>=B3=AD=CB=CD:</b> baolu.lu@linux.intel.com; CobeChen-oc; RaymondPang-oc;=
 Tony W Wang-oc<br>
<b>=D6=F7=CC=E2:</b> Re: [PATCH v3 2/2] iommu/vt-d:Add support for probing =
ACPI device in RMRR</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Hi Felix,<br>
<br>
On 8/27/20 6:02 PM, FelixCuioc wrote:<br>
&gt; After acpi device in RMRR is detected,it is necessary<br>
&gt; to establish a mapping for these devices.<br>
&gt; In acpi_device_create_direct_mappings(),create a mapping<br>
&gt; for the acpi device in RMRR.<br>
&gt; Add a helper to achieve the acpi namespace device can<br>
&gt; access the RMRR region.<br>
<br>
Are those ACPI devices visible to kernel? If so, any device driver bound<br=
>
for it?<br>
<br>
Best regards,<br>
baolu<br>
<br>
&gt; <br>
&gt; Signed-off-by: FelixCuioc &lt;FelixCui-oc@zhaoxin.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/iommu/intel/iommu.c | 29 &#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; drivers/iommu/iommu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp; 6 &#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; include/linux/iommu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp; 3 &#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; 3 files changed, 38 insertions(&#43;)<br>
&gt; <br>
&gt; diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c=
<br>
&gt; index 208a91605288..51d7a5b18f41 100644<br>
&gt; --- a/drivers/iommu/intel/iommu.c<br>
&gt; &#43;&#43;&#43; b/drivers/iommu/intel/iommu.c<br>
&gt; @@ -4799,6 &#43;4799,21 @@ static int __init platform_optin_force_iomm=
u(void)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 1;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;static int acpi_device_create_direct_mappings(struct device *pn_d=
ev, struct device *acpi_device)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct iommu_group *group;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; acpi_device-&gt;bus-&gt;iommu_ops =3D &a=
mp;intel_iommu_ops;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; group =3D iommu_group_get(pn_dev);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (!group) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; pr_warn(&quot;ACPI name space devices create direct mappings wrong!=
\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; __acpi_device_create_direct_mappings(gro=
up, acpi_device);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp; static int __init probe_acpi_namespace_devices(void)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dmar_drhd_unit *drhd;=
<br>
&gt; @@ -4813,6 &#43;4828,7 @@ static int __init probe_acpi_namespace_devic=
es(void)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct =
acpi_device_physical_node *pn;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct =
iommu_group *group;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct =
acpi_device *adev;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device *pn_d=
ev =3D NULL;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev=
-&gt;bus !=3D &amp;acpi_bus_type)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&gt; @@ -4823,6 &#43;4839,7 @@ static int __init probe_acpi_namespace_devic=
es(void)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;physical_node_list, nod=
e) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; group =3D iommu_group_get(pn-&gt;d=
ev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (group) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; pn_dev =3D pn-&gt;dev;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; iommu_group_put(group);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; continue;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; @@ -4831,7 &#43;4848,19 @@ static int __init probe_acpi_namespace_devi=
ces(void)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D iommu_probe_device(pn-&gt;=
dev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; pn_dev =3D pn-&gt;dev;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pn_dev) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; dev-&gt;bus-&gt;iommu_ops =3D &amp;intel_iommu=
_ops;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D iommu_probe_device(dev);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; pr_err(&quot;acpi_device probe fail! ret:%d\n&quot;, ret);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; goto unlock;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; goto unlock;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D acpi_device=
_create_direct_mappings(pn_dev, dev);<br>
&gt; &#43;unlock:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_u=
nlock(&amp;adev-&gt;physical_node_lock);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret=
)<br>
&gt; diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c<br>
&gt; index 609bd25bf154..4f714a2d5ef7 100644<br>
&gt; --- a/drivers/iommu/iommu.c<br>
&gt; &#43;&#43;&#43; b/drivers/iommu/iommu.c<br>
&gt; @@ -779,6 &#43;779,12 @@ static bool iommu_is_attach_deferred(struct i=
ommu_domain *domain,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;void&nbsp; __acpi_device_create_direct_mappings(struct iommu_grou=
p *group, struct device *acpi_device)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; iommu_create_device_direct_mappings(grou=
p, acpi_device);<br>
&gt; &#43;}<br>
&gt; &#43;EXPORT_SYMBOL_GPL(__acpi_device_create_direct_mappings);<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp; /**<br>
&gt;&nbsp;&nbsp;&nbsp; * iommu_group_add_device - add a device to an iommu =
group<br>
&gt;&nbsp;&nbsp;&nbsp; * @group: the group into which to add the device (re=
ference should be held)<br>
&gt; diff --git a/include/linux/iommu.h b/include/linux/iommu.h<br>
&gt; index fee209efb756..9be134775886 100644<br>
&gt; --- a/include/linux/iommu.h<br>
&gt; &#43;&#43;&#43; b/include/linux/iommu.h<br>
&gt; @@ -514,6 &#43;514,9 @@ extern void iommu_domain_window_disable(struct=
 iommu_domain *domain, u32 wnd_nr)<br>
&gt;&nbsp;&nbsp; extern int report_iommu_fault(struct iommu_domain *domain,=
 struct device *dev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long iova, int flags);<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;extern void __acpi_device_create_direct_mappings(struct iommu_gro=
up *group,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device *acpi_devic=
e);<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp; static inline void iommu_flush_tlb_all(struct iommu_domain=
 *domain)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (domain-&gt;ops-&gt;flush=
_iotlb_all)<br>
&gt; <br>
</div>
</span></font>
</body>
</html>

--_000_cde22f0f02f94efcae8bf044e2cd9441zhaoxincom_--

--===============0016849542623995408==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0016849542623995408==--
