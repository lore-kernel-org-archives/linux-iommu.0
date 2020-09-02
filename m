Return-Path: <SRS0=BMay=CL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9EFC433E2
	for <iommu@archiver.kernel.org>; Wed,  2 Sep 2020 01:48:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BF532071B
	for <iommu@archiver.kernel.org>; Wed,  2 Sep 2020 01:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BF532071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2A32F86709;
	Wed,  2 Sep 2020 01:48:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lx94-lzSvkVm; Wed,  2 Sep 2020 01:48:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6C0C384C63;
	Wed,  2 Sep 2020 01:48:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 556C0C07FF;
	Wed,  2 Sep 2020 01:48:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FAB0C0051
 for <iommu@lists.linux-foundation.org>; Wed,  2 Sep 2020 01:48:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E165F845CB
 for <iommu@lists.linux-foundation.org>; Wed,  2 Sep 2020 01:48:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VGhXphcpiM7B for <iommu@lists.linux-foundation.org>;
 Wed,  2 Sep 2020 01:48:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from ZXSHCAS1.zhaoxin.com (unknown [203.148.12.81])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 21B3E844EC
 for <iommu@lists.linux-foundation.org>; Wed,  2 Sep 2020 01:48:38 +0000 (UTC)
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 2 Sep 2020
 09:48:28 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 2 Sep 2020
 09:48:28 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::290a:f538:51e7:1416]) by
 zxbjmbx1.zhaoxin.com ([fe80::290a:f538:51e7:1416%16]) with mapi id
 15.01.1979.003; Wed, 2 Sep 2020 09:48:28 +0800
From: FelixCui-oc <FelixCui-oc@zhaoxin.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David
 Woodhouse" <dwmw2@infradead.org>, Dan Carpenter <dan.carpenter@oracle.com>,
 "kbuild@lists.01.org" <kbuild@lists.01.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIHYzIDEvMl0gaW9tbXUvdnQtZDpBZGQgc3VwcG9ydCBm?=
 =?gb2312?Q?or_detecting_ACPI_device_in_RMRR?=
Thread-Topic: [PATCH v3 1/2] iommu/vt-d:Add support for detecting ACPI device
 in RMRR
Thread-Index: AQHWfFkrnkv6/mVfzUi4e7pHcHTybalSzOMAgAChtwmAAShzTg==
Date: Wed, 2 Sep 2020 01:48:28 +0000
Message-ID: <09f1d01c5066455a98dcb3dd22ff28d0@zhaoxin.com>
References: <20200827100217.21324-1-FelixCui-oc@zhaoxin.com>
 <20200827100217.21324-2-FelixCui-oc@zhaoxin.com>,
 <a7492142-2fbf-781c-8ec7-e85d5ce3f1d5@linux.intel.com>,
 <1295ce42af404700ac89f177442bb27f@zhaoxin.com>
In-Reply-To: <1295ce42af404700ac89f177442bb27f@zhaoxin.com>
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
Content-Type: multipart/mixed; boundary="===============2433567167370631992=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============2433567167370631992==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_09f1d01c5066455a98dcb3dd22ff28d0zhaoxincom_"

--_000_09f1d01c5066455a98dcb3dd22ff28d0zhaoxincom_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

aGkgIGJhb2x1ICwNCg0KICAgICAgICAgICAgICAgICAgICAgICBBZGQgcHJfaW5mbygpLCB0aGVy
ZSB3aWxsIGJlIGEgcHJvYmxlbS4NCg0KICAgICAgICAgICAgICAgICAgICAgICBkbWFyX2FjcGlf
YnVzX2FkZF9kZXYoKSB3aWxsIGNhbGwgZG1hcl9hY3BpX2luc2VydF9kZXZfc2NvcGUoKSB0d2lj
ZS4gU28gaXQgd2lsbCAgcHJpbnQgdHdvIGlkZW50aWNhbCAgbG9ncy4gVGhpcyBpcyBzaW1pbGFy
IHRvIGRtYXJfcGNpX2J1c19hZGRfZGV2KCkuIFdoYXQgZG8geW91IHRoaW5rPw0KDQoNCg0KICAg
ICAgICAgICAgICAgICAgICAgIEFkZCBwcl93YXJuKCksIE5vIHByb2JsZW0uDQoNCg0KQmVzdCBy
ZWdhcmRzDQoNCkZlbGl4Y3VpLW9jDQoNCg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXw0Kt6K8/sjLOiBGZWxpeEN1aS1vYw0Kt6LLzcqxvOQ6IDIwMjDE6jnUwjHI1SAxNTo1Mzo0
Nw0KytW8/sjLOiBMdSBCYW9sdTsgSm9lcmcgUm9lZGVsOyBpb21tdUBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgRGF2aWQgV29vZGhvdXNl
OyBEYW4gQ2FycGVudGVyOyBrYnVpbGRAbGlzdHMuMDEub3JnDQqzrcvNOiBDb2JlQ2hlbi1vYzsg
UmF5bW9uZFBhbmctb2M7IFRvbnkgVyBXYW5nLW9jDQrW98ziOiC08Li0OiBbUEFUQ0ggdjMgMS8y
XSBpb21tdS92dC1kOkFkZCBzdXBwb3J0IGZvciBkZXRlY3RpbmcgQUNQSSBkZXZpY2UgaW4gUk1S
Ug0KDQoNCmhpICBiYW9sdSwNCg0KICAgICAgICAgICAgICAgICAgVGhlIGZ1bmN0aW9uIGRtYXJf
cm1ycl9hZGRfYWNwaV9kZXYoKSBpcyBkZWZpbmVkIGluIGludGVsL2lvbW11LmMgYmVjYXVzZSBz
dHJ1Y3QgZG1hcl9ybXJyX3VuaXQge30gaXMgZGVmaW5lZCBpbiBpbnRlbC9pb21tdS5jLg0KDQog
ICAgICAgICAgICAgICAgICBBbmQgZG1hcl9wYXJzZV9vbmVfcm1ycigpICBpcyBhbHNvIGRlZmlu
ZWQgaGVyZSwgc28gd2UgdGhpbmsgaXQgc2hvdWxkIGJlIGRlZmluZWQgaW4gaW9tbXUuYy4NCg0K
DQpCZXN0IHJlZ2FyZHMNCkZlbGl4Y3VpLW9jDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fDQq3orz+yMs6IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+DQq3osvN
yrG85DogMjAyMMTqOdTCMcjVIDE0OjA1DQrK1bz+yMs6IEZlbGl4Q3VpLW9jOyBKb2VyZyBSb2Vk
ZWw7IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBEYXZpZCBXb29kaG91c2U7IERhbiBDYXJwZW50ZXI7IGtidWlsZEBsaXN0cy4w
MS5vcmcNCrOty806IGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbTsgQ29iZUNoZW4tb2M7IFJheW1v
bmRQYW5nLW9jOyBUb255IFcgV2FuZy1vYw0K1vfM4jogUmU6IFtQQVRDSCB2MyAxLzJdIGlvbW11
L3Z0LWQ6QWRkIHN1cHBvcnQgZm9yIGRldGVjdGluZyBBQ1BJIGRldmljZSBpbiBSTVJSDQoNCkhp
IEZlbGl4LA0KDQpPbiA4LzI3LzIwIDY6MDIgUE0sIEZlbGl4Q3Vpb2Mgd3JvdGU6DQo+IFNvbWUg
QUNQSSBkZXZpY2VzIG5lZWQgdG8gaXNzdWUgZG1hIHJlcXVlc3RzIHRvIGFjY2Vzcw0KPiB0aGUg
cmVzZXJ2ZWQgbWVtb3J5IGFyZWEuQklPUyB1c2VzIHRoZSBkZXZpY2Ugc2NvcGUgdHlwZQ0KPiBB
Q1BJX05BTUVTUEFDRV9ERVZJQ0UgaW4gUk1SUiB0byByZXBvcnQgdGhlc2UgQUNQSSBkZXZpY2Vz
Lg0KPiBUaGlzIHBhdGNoIGFkZCBzdXBwb3J0IGZvciBkZXRlY3RpbmcgQUNQSSBkZXZpY2VzIGlu
IFJNUlIuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEZlbGl4Q3Vpb2MgPEZlbGl4Q3VpLW9jQHpoYW94
aW4uY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2lvbW11L2ludGVsL2RtYXIuYyAgfCA3NiArKysr
KysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tDQo+ICAgZHJpdmVycy9pb21tdS9pbnRl
bC9pb21tdS5jIHwgMjMgKysrKysrKysrKy0NCj4gICBpbmNsdWRlL2xpbnV4L2RtYXIuaCAgICAg
ICAgfCAxMiArKysrKy0NCj4gICAzIGZpbGVzIGNoYW5nZWQsIDc2IGluc2VydGlvbnMoKyksIDM1
IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pbnRlbC9kbWFy
LmMgYi9kcml2ZXJzL2lvbW11L2ludGVsL2RtYXIuYw0KPiBpbmRleCA5M2U2MzQ1ZjM0MTQuLmY2
NjkxYzM2YmQzZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC9kbWFyLmMNCj4g
KysrIGIvZHJpdmVycy9pb21tdS9pbnRlbC9kbWFyLmMNCj4gQEAgLTIxNSw3ICsyMTUsNyBAQCBz
dGF0aWMgYm9vbCBkbWFyX21hdGNoX3BjaV9wYXRoKHN0cnVjdCBkbWFyX3BjaV9ub3RpZnlfaW5m
byAqaW5mbywgaW50IGJ1cywNCj4gICB9DQo+DQo+ICAgLyogUmV0dXJuOiA+IDAgaWYgbWF0Y2gg
Zm91bmQsIDAgaWYgbm8gbWF0Y2ggZm91bmQsIDwgMCBpZiBlcnJvciBoYXBwZW5zICovDQo+IC1p
bnQgZG1hcl9pbnNlcnRfZGV2X3Njb3BlKHN0cnVjdCBkbWFyX3BjaV9ub3RpZnlfaW5mbyAqaW5m
bywNCj4gK2ludCBkbWFyX3BjaV9pbnNlcnRfZGV2X3Njb3BlKHN0cnVjdCBkbWFyX3BjaV9ub3Rp
ZnlfaW5mbyAqaW5mbywNCj4gICAgICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKnN0YXJ0LCB2
b2lkKmVuZCwgdTE2IHNlZ21lbnQsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qg
ZG1hcl9kZXZfc2NvcGUgKmRldmljZXMsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQg
ZGV2aWNlc19jbnQpDQo+IEBAIC0zMDQsNyArMzA0LDcgQEAgc3RhdGljIGludCBkbWFyX3BjaV9i
dXNfYWRkX2RldihzdHJ1Y3QgZG1hcl9wY2lfbm90aWZ5X2luZm8gKmluZm8pDQo+DQo+ICAgICAg
ICAgICAgICAgIGRyaGQgPSBjb250YWluZXJfb2YoZG1hcnUtPmhkciwNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgYWNwaV9kbWFyX2hhcmR3YXJlX3VuaXQsIGhl
YWRlcik7DQo+IC0gICAgICAgICAgICAgcmV0ID0gZG1hcl9pbnNlcnRfZGV2X3Njb3BlKGluZm8s
ICh2b2lkICopKGRyaGQgKyAxKSwNCj4gKyAgICAgICAgICAgICByZXQgPSBkbWFyX3BjaV9pbnNl
cnRfZGV2X3Njb3BlKGluZm8sICh2b2lkICopKGRyaGQgKyAxKSwNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICgodm9pZCAqKWRyaGQpICsgZHJoZC0+aGVhZGVyLmxlbmd0aCwNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRtYXJ1LT5zZWdtZW50LA0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZG1hcnUtPmRldmljZXMsIGRtYXJ1LT5kZXZpY2VzX2Nu
dCk7DQo+IEBAIC02OTcsNDcgKzY5Nyw1OSBAQCBkbWFyX2ZpbmRfbWF0Y2hlZF9kcmhkX3VuaXQo
c3RydWN0IHBjaV9kZXYgKmRldikNCj4gICAgICAgIHJldHVybiBkbWFydTsNCj4gICB9DQo+DQo+
IC1zdGF0aWMgdm9pZCBfX2luaXQgZG1hcl9hY3BpX2luc2VydF9kZXZfc2NvcGUodTggZGV2aWNl
X251bWJlciwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBz
dHJ1Y3QgYWNwaV9kZXZpY2UgKmFkZXYpDQo+ICsvKiBSZXR1cm46ID4gMCBpZiBtYXRjaCBmb3Vu
ZCwgMCBpZiBubyBtYXRjaCBmb3VuZCAqLw0KPiArYm9vbCBkbWFyX2FjcGlfaW5zZXJ0X2Rldl9z
Y29wZSh1OCBkZXZpY2VfbnVtYmVyLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBz
dHJ1Y3QgYWNwaV9kZXZpY2UgKmFkZXYsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHZvaWQgKnN0YXJ0LCB2b2lkICplbmQsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHN0cnVjdCBkbWFyX2Rldl9zY29wZSAqZGV2aWNlcywNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgaW50IGRldmljZXNfY250KQ0KPiAgIHsNCj4gLSAgICAgc3RydWN0IGRtYXJfZHJo
ZF91bml0ICpkbWFydTsNCj4gLSAgICAgc3RydWN0IGFjcGlfZG1hcl9oYXJkd2FyZV91bml0ICpk
cmhkOw0KPiAgICAgICAgc3RydWN0IGFjcGlfZG1hcl9kZXZpY2Vfc2NvcGUgKnNjb3BlOw0KPiAg
ICAgICAgc3RydWN0IGRldmljZSAqdG1wOw0KPiAgICAgICAgaW50IGk7DQo+ICAgICAgICBzdHJ1
Y3QgYWNwaV9kbWFyX3BjaV9wYXRoICpwYXRoOw0KPg0KPiArICAgICBmb3IgKDsgc3RhcnQgPCBl
bmQ7IHN0YXJ0ICs9IHNjb3BlLT5sZW5ndGgpIHsNCj4gKyAgICAgICAgICAgICBzY29wZSA9IHN0
YXJ0Ow0KPiArICAgICAgICAgICAgIGlmIChzY29wZS0+ZW50cnlfdHlwZSAhPSBBQ1BJX0RNQVJf
U0NPUEVfVFlQRV9OQU1FU1BBQ0UpDQo+ICsgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsN
Cj4gKyAgICAgICAgICAgICBpZiAoc2NvcGUtPmVudW1lcmF0aW9uX2lkICE9IGRldmljZV9udW1i
ZXIpDQo+ICsgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4gKyAgICAgICAgICAgICBw
YXRoID0gKHZvaWQgKikoc2NvcGUgKyAxKTsNCj4gKyAgICAgICAgICAgICBmb3JfZWFjaF9kZXZf
c2NvcGUoZGV2aWNlcywgZGV2aWNlc19jbnQsIGksIHRtcCkNCj4gKyAgICAgICAgICAgICAgICAg
ICAgIGlmICh0bXAgPT0gTlVMTCkgew0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBk
ZXZpY2VzW2ldLmJ1cyA9IHNjb3BlLT5idXM7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGRldmljZXNbaV0uZGV2Zm4gPSBQQ0lfREVWRk4ocGF0aC0+ZGV2aWNlLCBwYXRoLT5mdW5j
dGlvbik7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJjdV9hc3NpZ25fcG9pbnRl
cihkZXZpY2VzW2ldLmRldiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGdldF9kZXZpY2UoJmFkZXYtPmRldikpOw0KPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsNCj4gKyAgICAgICAgICAgICAgICAgICAgIH0NCj4g
KyAgICAgICAgICAgICBXQVJOX09OKGkgPj0gZGV2aWNlc19jbnQpOw0KPiArICAgICB9DQo+ICsg
ICAgIHJldHVybiBmYWxzZTsNCj4gK30NCj4gKw0KPiArc3RhdGljIGludCBkbWFyX2FjcGlfYnVz
X2FkZF9kZXYodTggZGV2aWNlX251bWJlciwgc3RydWN0IGFjcGlfZGV2aWNlICphZGV2KQ0KPiAr
ew0KPiArICAgICBzdHJ1Y3QgZG1hcl9kcmhkX3VuaXQgKmRtYXJ1Ow0KPiArICAgICBzdHJ1Y3Qg
YWNwaV9kbWFyX2hhcmR3YXJlX3VuaXQgKmRyaGQ7DQo+ICsgICAgIGludCByZXQ7DQo+ICsNCj4g
ICAgICAgIGZvcl9lYWNoX2RyaGRfdW5pdChkbWFydSkgew0KPiAgICAgICAgICAgICAgICBkcmhk
ID0gY29udGFpbmVyX29mKGRtYXJ1LT5oZHIsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgc3RydWN0IGFjcGlfZG1hcl9oYXJkd2FyZV91bml0LA0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGhlYWRlcik7DQo+ICsgICAgICAgICAgICAgcmV0ID0gZG1h
cl9hY3BpX2luc2VydF9kZXZfc2NvcGUoZGV2aWNlX251bWJlciwgYWRldiwgKHZvaWQgKikoZHJo
ZCsxKSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICgo
dm9pZCAqKWRyaGQpK2RyaGQtPmhlYWRlci5sZW5ndGgsDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBkbWFydS0+ZGV2aWNlcywgZG1hcnUtPmRldmljZXNf
Y250KTsNCj4gKyAgICAgICAgICAgICBpZiAocmV0KQ0KPiArICAgICAgICAgICAgICAgICAgICAg
YnJlYWs7DQo+ICsgICAgIH0NCj4gKyAgICAgaWYgKHJldCA+IDApDQo+ICsgICAgICAgICAgICAg
cmV0ID0gZG1hcl9ybXJyX2FkZF9hY3BpX2RldihkZXZpY2VfbnVtYmVyLCBhZGV2KTsNCj4NCj4g
LSAgICAgICAgICAgICBmb3IgKHNjb3BlID0gKHZvaWQgKikoZHJoZCArIDEpOw0KPiAtICAgICAg
ICAgICAgICAgICAgKHVuc2lnbmVkIGxvbmcpc2NvcGUgPCAoKHVuc2lnbmVkIGxvbmcpZHJoZCkg
KyBkcmhkLT5oZWFkZXIubGVuZ3RoOw0KPiAtICAgICAgICAgICAgICAgICAgc2NvcGUgPSAoKHZv
aWQgKilzY29wZSkgKyBzY29wZS0+bGVuZ3RoKSB7DQo+IC0gICAgICAgICAgICAgICAgICAgICBp
ZiAoc2NvcGUtPmVudHJ5X3R5cGUgIT0gQUNQSV9ETUFSX1NDT1BFX1RZUEVfTkFNRVNQQUNFKQ0K
PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4gLSAgICAgICAgICAg
ICAgICAgICAgIGlmIChzY29wZS0+ZW51bWVyYXRpb25faWQgIT0gZGV2aWNlX251bWJlcikNCj4g
LSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+ICsgICAgIHJldHVybiBy
ZXQ7DQo+DQo+IC0gICAgICAgICAgICAgICAgICAgICBwYXRoID0gKHZvaWQgKikoc2NvcGUgKyAx
KTsNCj4gLSAgICAgICAgICAgICAgICAgICAgIHByX2luZm8oIkFDUEkgZGV2aWNlIFwiJXNcIiB1
bmRlciBETUFSIGF0ICVsbHggYXMgJTAyeDolMDJ4LiVkXG4iLA0KPiAtICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBkZXZfbmFtZSgmYWRldi0+ZGV2KSwgZG1hcnUtPnJlZ19iYXNlX2FkZHIs
DQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNjb3BlLT5idXMsIHBhdGgtPmRldmlj
ZSwgcGF0aC0+ZnVuY3Rpb24pOw0KDQpQbGVhc2Uga2VlcCBzdWNoIGluZm9ybWF0aW9uLiBQZW9w
bGUgYXJlIHVzZWQgdG8gdXNlIHRoZW0gYXMgYSBtZXRob2QgdG8NCmtub3cgdGhlIGhhcmR3YXJl
IGNvbmZpZ3VyYXRpb24uDQoNCj4gLSAgICAgICAgICAgICAgICAgICAgIGZvcl9lYWNoX2Rldl9z
Y29wZShkbWFydS0+ZGV2aWNlcywgZG1hcnUtPmRldmljZXNfY250LCBpLCB0bXApDQo+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGlmICh0bXAgPT0gTlVMTCkgew0KPiAtICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRtYXJ1LT5kZXZpY2VzW2ldLmJ1cyA9IHNjb3Bl
LT5idXM7DQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZG1hcnUtPmRl
dmljZXNbaV0uZGV2Zm4gPSBQQ0lfREVWRk4ocGF0aC0+ZGV2aWNlLA0KPiAtICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHBhdGgtPmZ1bmN0aW9uKTsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICByY3VfYXNzaWduX3BvaW50ZXIoZG1hcnUtPmRldmljZXNbaV0uZGV2LA0KPiAtICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnZXRfZGV2
aWNlKCZhZGV2LT5kZXYpKTsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICByZXR1cm47DQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0NCj4gLSAgICAgICAg
ICAgICAgICAgICAgIEJVR19PTihpID49IGRtYXJ1LT5kZXZpY2VzX2NudCk7DQo+IC0gICAgICAg
ICAgICAgfQ0KPiAtICAgICB9DQo+IC0gICAgIHByX3dhcm4oIk5vIElPTU1VIHNjb3BlIGZvdW5k
IGZvciBBTkREIGVudW1lcmF0aW9uIElEICVkICglcylcbiIsDQo+IC0gICAgICAgICAgICAgZGV2
aWNlX251bWJlciwgZGV2X25hbWUoJmFkZXYtPmRldikpOw0KDQpEaXR0by4NCg0KPiAgIH0NCj4N
Cj4gICBzdGF0aWMgaW50IF9faW5pdCBkbWFyX2FjcGlfZGV2X3Njb3BlX2luaXQodm9pZCkNCj4g
QEAgLTc2Niw3ICs3NzgsNyBAQCBzdGF0aWMgaW50IF9faW5pdCBkbWFyX2FjcGlfZGV2X3Njb3Bl
X2luaXQodm9pZCkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhbmRk
LT5kZXZpY2VfbmFtZSk7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb250aW51
ZTsNCj4gICAgICAgICAgICAgICAgICAgICAgICB9DQo+IC0gICAgICAgICAgICAgICAgICAgICBk
bWFyX2FjcGlfaW5zZXJ0X2Rldl9zY29wZShhbmRkLT5kZXZpY2VfbnVtYmVyLCBhZGV2KTsNCj4g
KyAgICAgICAgICAgICAgICAgICAgIGRtYXJfYWNwaV9idXNfYWRkX2RldihhbmRkLT5kZXZpY2Vf
bnVtYmVyLCBhZGV2KTsNCj4gICAgICAgICAgICAgICAgfQ0KPiAgICAgICAgfQ0KPiAgICAgICAg
cmV0dXJuIDA7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMgYi9k
cml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMNCj4gaW5kZXggY2E1NTdkMzUxNTE4Li4yMDhhOTE2
MDUyODggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYw0KPiArKysg
Yi9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMNCj4gQEAgLTQ1MDgsNiArNDUwOCwyNSBAQCBp
bnQgZG1hcl9maW5kX21hdGNoZWRfYXRzcl91bml0KHN0cnVjdCBwY2lfZGV2ICpkZXYpDQo+ICAg
ICAgICByZXR1cm4gcmV0Ow0KPiAgIH0NCj4NCj4gK2ludCBkbWFyX3JtcnJfYWRkX2FjcGlfZGV2
KHU4IGRldmljZV9udW1iZXIsIHN0cnVjdCBhY3BpX2RldmljZSAqYWRldikNCj4gK3sNCj4gKyAg
ICAgaW50IHJldDsNCj4gKyAgICAgc3RydWN0IGRtYXJfcm1ycl91bml0ICpybXJydTsNCj4gKyAg
ICAgc3RydWN0IGFjcGlfZG1hcl9yZXNlcnZlZF9tZW1vcnkgKnJtcnI7DQo+ICsNCj4gKyAgICAg
bGlzdF9mb3JfZWFjaF9lbnRyeShybXJydSwgJmRtYXJfcm1ycl91bml0cywgbGlzdCkgew0KPiAr
ICAgICAgICAgICAgIHJtcnIgPSBjb250YWluZXJfb2Yocm1ycnUtPmhkciwNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGFjcGlfZG1hcl9yZXNlcnZlZF9tZW1vcnksDQo+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGhlYWRlcik7DQo+ICsgICAgICAgICAgICAg
cmV0ID0gZG1hcl9hY3BpX2luc2VydF9kZXZfc2NvcGUoZGV2aWNlX251bWJlciwgYWRldiwgKHZv
aWQgKikocm1yciArIDEpLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgKCh2b2lkICopcm1ycikgKyBybXJyLT5oZWFkZXIubGVuZ3RoLA0KPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcm1ycnUtPmRldmljZXMsIHJt
cnJ1LT5kZXZpY2VzX2NudCk7DQo+ICsgICAgICAgICAgICAgaWYgKHJldCkNCj4gKyAgICAgICAg
ICAgICAgICAgICAgIGJyZWFrOw0KPiArICAgICB9DQo+ICsgICAgIHJldHVybiAwOw0KPiArfQ0K
DQpUaGlzIGlzIG9ubHkgdXNlZCBpbiBkbWFyLmMuIFdoeSBkbyB5b3Ugd2FudCB0byBkZWZpbmUg
aXQgaGVyZSBhbmQgdXNlDQppdCBpbiBhbm90aGVyIGZpbGU/DQoNCj4gKw0KPiAgIGludCBkbWFy
X2lvbW11X25vdGlmeV9zY29wZV9kZXYoc3RydWN0IGRtYXJfcGNpX25vdGlmeV9pbmZvICppbmZv
KQ0KPiAgIHsNCj4gICAgICAgIGludCByZXQ7DQo+IEBAIC00NTIzLDcgKzQ1NDIsNyBAQCBpbnQg
ZG1hcl9pb21tdV9ub3RpZnlfc2NvcGVfZGV2KHN0cnVjdCBkbWFyX3BjaV9ub3RpZnlfaW5mbyAq
aW5mbykNCj4gICAgICAgICAgICAgICAgcm1yciA9IGNvbnRhaW5lcl9vZihybXJydS0+aGRyLA0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBhY3BpX2RtYXJfcmVz
ZXJ2ZWRfbWVtb3J5LCBoZWFkZXIpOw0KPiAgICAgICAgICAgICAgICBpZiAoaW5mby0+ZXZlbnQg
PT0gQlVTX05PVElGWV9BRERfREVWSUNFKSB7DQo+IC0gICAgICAgICAgICAgICAgICAgICByZXQg
PSBkbWFyX2luc2VydF9kZXZfc2NvcGUoaW5mbywgKHZvaWQgKikocm1yciArIDEpLA0KPiArICAg
ICAgICAgICAgICAgICAgICAgcmV0ID0gZG1hcl9wY2lfaW5zZXJ0X2Rldl9zY29wZShpbmZvLCAo
dm9pZCAqKShybXJyICsgMSksDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoKHZv
aWQgKilybXJyKSArIHJtcnItPmhlYWRlci5sZW5ndGgsDQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBybXJyLT5zZWdtZW50LCBybXJydS0+ZGV2aWNlcywNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHJtcnJ1LT5kZXZpY2VzX2NudCk7DQo+IEBAIC00NTQxLDcgKzQ1
NjAsNyBAQCBpbnQgZG1hcl9pb21tdV9ub3RpZnlfc2NvcGVfZGV2KHN0cnVjdCBkbWFyX3BjaV9u
b3RpZnlfaW5mbyAqaW5mbykNCj4NCj4gICAgICAgICAgICAgICAgYXRzciA9IGNvbnRhaW5lcl9v
ZihhdHNydS0+aGRyLCBzdHJ1Y3QgYWNwaV9kbWFyX2F0c3IsIGhlYWRlcik7DQo+ICAgICAgICAg
ICAgICAgIGlmIChpbmZvLT5ldmVudCA9PSBCVVNfTk9USUZZX0FERF9ERVZJQ0UpIHsNCj4gLSAg
ICAgICAgICAgICAgICAgICAgIHJldCA9IGRtYXJfaW5zZXJ0X2Rldl9zY29wZShpbmZvLCAodm9p
ZCAqKShhdHNyICsgMSksDQo+ICsgICAgICAgICAgICAgICAgICAgICByZXQgPSBkbWFyX3BjaV9p
bnNlcnRfZGV2X3Njb3BlKGluZm8sICh2b2lkICopKGF0c3IgKyAxKSwNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgKHZvaWQgKilhdHNyICsgYXRzci0+aGVhZGVyLmxl
bmd0aCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYXRzci0+c2Vn
bWVudCwgYXRzcnUtPmRldmljZXMsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGF0c3J1LT5kZXZpY2VzX2NudCk7DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L2RtYXIuaCBiL2luY2x1ZGUvbGludXgvZG1hci5oDQo+IGluZGV4IDY1NTY1ODIwMzI4YS4uZDA5
ODFkMzVkM2M5IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2RtYXIuaA0KPiArKysgYi9p
bmNsdWRlL2xpbnV4L2RtYXIuaA0KPiBAQCAtMTEzLDEwICsxMTMsMTQgQEAgZXh0ZXJuIGludCBk
bWFyX3BhcnNlX2Rldl9zY29wZSh2b2lkICpzdGFydCwgdm9pZCAqZW5kLCBpbnQgKmNudCwNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBkbWFyX2Rldl9zY29wZSAqKmRl
dmljZXMsIHUxNiBzZWdtZW50KTsNCj4gICBleHRlcm4gdm9pZCAqZG1hcl9hbGxvY19kZXZfc2Nv
cGUodm9pZCAqc3RhcnQsIHZvaWQgKmVuZCwgaW50ICpjbnQpOw0KPiAgIGV4dGVybiB2b2lkIGRt
YXJfZnJlZV9kZXZfc2NvcGUoc3RydWN0IGRtYXJfZGV2X3Njb3BlICoqZGV2aWNlcywgaW50ICpj
bnQpOw0KPiAtZXh0ZXJuIGludCBkbWFyX2luc2VydF9kZXZfc2NvcGUoc3RydWN0IGRtYXJfcGNp
X25vdGlmeV9pbmZvICppbmZvLA0KPiArZXh0ZXJuIGludCBkbWFyX3BjaV9pbnNlcnRfZGV2X3Nj
b3BlKHN0cnVjdCBkbWFyX3BjaV9ub3RpZnlfaW5mbyAqaW5mbywNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB2b2lkICpzdGFydCwgdm9pZCplbmQsIHUxNiBzZWdtZW50LA0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBkbWFyX2Rldl9zY29wZSAqZGV2
aWNlcywNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgZGV2aWNlc19jbnQp
Ow0KPiArZXh0ZXJuIGJvb2wgZG1hcl9hY3BpX2luc2VydF9kZXZfc2NvcGUodTggZGV2aWNlX251
bWJlciwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGFjcGlfZGV2aWNl
ICphZGV2LCB2b2lkICpzdGFydCwgdm9pZCAqZW5kLA0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBzdHJ1Y3QgZG1hcl9kZXZfc2NvcGUgKmRldmljZXMsIGludCBkZXZpY2VzX2NudCk7
DQo+ICsNCj4gICBleHRlcm4gaW50IGRtYXJfcmVtb3ZlX2Rldl9zY29wZShzdHJ1Y3QgZG1hcl9w
Y2lfbm90aWZ5X2luZm8gKmluZm8sDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dTE2IHNlZ21lbnQsIHN0cnVjdCBkbWFyX2Rldl9zY29wZSAqZGV2aWNlcywNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBpbnQgY291bnQpOw0KPiBAQCAtMTQwLDYgKzE0NCw3IEBA
IGV4dGVybiBpbnQgZG1hcl9wYXJzZV9vbmVfYXRzcihzdHJ1Y3QgYWNwaV9kbWFyX2hlYWRlciAq
aGVhZGVyLCB2b2lkICphcmcpOw0KPiAgIGV4dGVybiBpbnQgZG1hcl9jaGVja19vbmVfYXRzcihz
dHJ1Y3QgYWNwaV9kbWFyX2hlYWRlciAqaGRyLCB2b2lkICphcmcpOw0KPiAgIGV4dGVybiBpbnQg
ZG1hcl9yZWxlYXNlX29uZV9hdHNyKHN0cnVjdCBhY3BpX2RtYXJfaGVhZGVyICpoZHIsIHZvaWQg
KmFyZyk7DQo+ICAgZXh0ZXJuIGludCBkbWFyX2lvbW11X2hvdHBsdWcoc3RydWN0IGRtYXJfZHJo
ZF91bml0ICpkbWFydSwgYm9vbCBpbnNlcnQpOw0KPiArZXh0ZXJuIGludCBkbWFyX3JtcnJfYWRk
X2FjcGlfZGV2KHU4IGRldmljZV9udW1iZXIsIHN0cnVjdCBhY3BpX2RldmljZSAqYWRldik7DQo+
ICAgZXh0ZXJuIGludCBkbWFyX2lvbW11X25vdGlmeV9zY29wZV9kZXYoc3RydWN0IGRtYXJfcGNp
X25vdGlmeV9pbmZvICppbmZvKTsNCj4gICAjZWxzZSAvKiAhQ09ORklHX0lOVEVMX0lPTU1VOiAq
Lw0KPiAgIHN0YXRpYyBpbmxpbmUgaW50IGludGVsX2lvbW11X2luaXQodm9pZCkgeyByZXR1cm4g
LUVOT0RFVjsgfQ0KPiBAQCAtMTUwLDYgKzE1NSwxMSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgaW50
ZWxfaW9tbXVfc2h1dGRvd24odm9pZCkgeyB9DQo+ICAgI2RlZmluZSAgICAgZG1hcl9jaGVja19v
bmVfYXRzciAgICAgICAgICAgICBkbWFyX3Jlc19ub29wDQo+ICAgI2RlZmluZSAgICAgZG1hcl9y
ZWxlYXNlX29uZV9hdHNyICAgICAgICAgICBkbWFyX3Jlc19ub29wDQo+DQo+ICtzdGF0aWMgaW5s
aW5lIGludCBkbWFyX3JtcnJfYWRkX2FjcGlfZGV2KHU4IGRldmljZV9udW1iZXIsIHN0cnVjdCBh
Y3BpX2RldmljZSAqYWRldikNCj4gK3sNCj4gKyAgICAgcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4g
ICBzdGF0aWMgaW5saW5lIGludCBkbWFyX2lvbW11X25vdGlmeV9zY29wZV9kZXYoc3RydWN0IGRt
YXJfcGNpX25vdGlmeV9pbmZvICppbmZvKQ0KPiAgIHsNCj4gICAgICAgIHJldHVybiAwOw0KPg0K
DQpCZXN0IHJlZ2FyZHMsDQpiYW9sdQ0K

--_000_09f1d01c5066455a98dcb3dd22ff28d0zhaoxincom_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p>hi&nbsp; baolu ,&nbsp;</p>
<p><font face=3D"Calibri, Helvetica, sans-serif, serif, EmojiFont"><span st=
yle=3D"font-size: 13.3333px;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Add pr_info(), there will be a proble=
m.&nbsp;</span></font></p>
<p><font face=3D"Calibri, Helvetica, sans-serif, serif, EmojiFont"><span st=
yle=3D"font-size: 13.3333px;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;dmar_acpi_bus_add_dev() will call dma=
r_acpi_insert_dev_scope() twice. So it will&nbsp;&nbsp;print two identical&=
nbsp;&nbsp;logs. This is similar to dmar_pci_bus_add_dev().&nbsp;What
 do you think?</span></font></p>
<p><font face=3D"Calibri, Helvetica, sans-serif, serif, EmojiFont"><span st=
yle=3D"font-size: 13.3333px;">&nbsp;&nbsp;</span></font></p>
<p><font face=3D"Calibri, Helvetica, sans-serif, serif, EmojiFont"><span st=
yle=3D"font-size: 13.3333px;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; Add pr_warn(), No problem.</span></font></p=
>
<p><font face=3D"Calibri, Helvetica, sans-serif, serif, EmojiFont"><span st=
yle=3D"font-size: 13.3333px;"><br>
</span></font></p>
<p><font face=3D"Calibri, Helvetica, sans-serif, serif, EmojiFont"><span st=
yle=3D"font-size: 13.3333px;">Best regards</span></font></p>
<p><font face=3D"Calibri, Helvetica, sans-serif, serif, EmojiFont"><span st=
yle=3D"font-size: 13.3333px;">Felixcui-oc</span></font></p>
<p><font face=3D"Calibri, Helvetica, sans-serif, serif, EmojiFont"><span st=
yle=3D"font-size: 13.3333px;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span></font><span style=3D"font-fam=
ily: Calibri, Helvetica, sans-serif, serif, EmojiFont; font-size: 13.3333px=
;"></span></p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>=B7=A2=BC=FE=C8=CB:</b> FelixCu=
i-oc<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> 2020=C4=EA9=D4=C21=C8=D5 15:53:47<br>
<b>=CA=D5=BC=FE=C8=CB:</b> Lu Baolu; Joerg Roedel; iommu@lists.linux-founda=
tion.org; linux-kernel@vger.kernel.org; David Woodhouse; Dan Carpenter; kbu=
ild@lists.01.org<br>
<b>=B3=AD=CB=CD:</b> CobeChen-oc; RaymondPang-oc; Tony W Wang-oc<br>
<b>=D6=F7=CC=E2:</b> =B4=F0=B8=B4: [PATCH v3 1/2] iommu/vt-d:Add support fo=
r detecting ACPI device in RMRR</font>
<div>&nbsp;</div>
</div>
<div>
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p>hi&nbsp; baolu,</p>
<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; The funct=
ion dmar_rmrr_add_acpi_dev() is defined in intel/iommu.c because struct dma=
r_rmrr_unit {} is defined in intel/iommu.c.</p>
<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; And dmar_=
parse_one_rmrr()&nbsp; is also defined here, so we think it should be defin=
ed in iommu.c.&nbsp;</p>
<p><br>
</p>
Best regards
<div>Felixcui-oc<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>=B7=A2=BC=FE=C8=CB:</b> Lu Ba=
olu &lt;baolu.lu@linux.intel.com&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> 2020=C4=EA9=D4=C21=C8=D5 14:05<br>
<b>=CA=D5=BC=FE=C8=CB:</b> FelixCui-oc; Joerg Roedel; iommu@lists.linux-fou=
ndation.org; linux-kernel@vger.kernel.org; David Woodhouse; Dan Carpenter; =
kbuild@lists.01.org<br>
<b>=B3=AD=CB=CD:</b> baolu.lu@linux.intel.com; CobeChen-oc; RaymondPang-oc;=
 Tony W Wang-oc<br>
<b>=D6=F7=CC=E2:</b> Re: [PATCH v3 1/2] iommu/vt-d:Add support for detectin=
g ACPI device in RMRR</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Hi Felix,<br>
<br>
On 8/27/20 6:02 PM, FelixCuioc wrote:<br>
&gt; Some ACPI devices need to issue dma requests to access<br>
&gt; the reserved memory area.BIOS uses the device scope type<br>
&gt; ACPI_NAMESPACE_DEVICE in RMRR to report these ACPI devices.<br>
&gt; This patch add support for detecting ACPI devices in RMRR.<br>
&gt; <br>
&gt; Signed-off-by: FelixCuioc &lt;FelixCui-oc@zhaoxin.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/iommu/intel/dmar.c&nbsp; | 76 &#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;----------------<br>
&gt;&nbsp;&nbsp; drivers/iommu/intel/iommu.c | 23 &#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;-<br>
&gt;&nbsp;&nbsp; include/linux/dmar.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; | 12 &#43;&#43;&#43;&#43;&#43;-<br>
&gt;&nbsp;&nbsp; 3 files changed, 76 insertions(&#43;), 35 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c<b=
r>
&gt; index 93e6345f3414..f6691c36bd3f 100644<br>
&gt; --- a/drivers/iommu/intel/dmar.c<br>
&gt; &#43;&#43;&#43; b/drivers/iommu/intel/dmar.c<br>
&gt; @@ -215,7 &#43;215,7 @@ static bool dmar_match_pci_path(struct dmar_pc=
i_notify_info *info, int bus,<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /* Return: &gt; 0 if match found, 0 if no match found, &lt=
; 0 if error happens */<br>
&gt; -int dmar_insert_dev_scope(struct dmar_pci_notify_info *info,<br>
&gt; &#43;int dmar_pci_insert_dev_scope(struct dmar_pci_notify_info *info,<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; void *start, void*end, u16 segment,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; struct dmar_dev_scope *devices,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; int devices_cnt)<br>
&gt; @@ -304,7 &#43;304,7 @@ static int dmar_pci_bus_add_dev(struct dmar_pc=
i_notify_info *info)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; drhd =3D container_of(dmaru-&gt;hdr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct acp=
i_dmar_hardware_unit, header);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D dmar_insert_dev_scope(info, (void *)(drhd &#43; 1),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ret =3D dmar_pci_insert_dev_scope(info, (void *)(drhd &#43; 1),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((void *)drhd) &#43; drhd-&gt;head=
er.length,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dmaru-&gt;segment,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dmaru-&gt;devices, dmaru-&gt;devic=
es_cnt);<br>
&gt; @@ -697,47 &#43;697,59 @@ dmar_find_matched_drhd_unit(struct pci_dev *=
dev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return dmaru;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -static void __init dmar_acpi_insert_dev_scope(u8 device_number,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct acpi_device *adev)<br>
&gt; &#43;/* Return: &gt; 0 if match found, 0 if no match found */<br>
&gt; &#43;bool dmar_acpi_insert_dev_scope(u8 device_number,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; struct acpi_device *adev,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; void *start, void *end,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dmar_dev_scope *devices,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; int devices_cnt)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct dmar_drhd_unit *dmaru;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct acpi_dmar_hardware_unit *drhd;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct acpi_dmar_device_scop=
e *scope;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device *tmp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct acpi_dmar_pci_path *p=
ath;<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; for (; start &lt; end; start &#43;=3D sc=
ope-&gt;length) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; scope =3D start;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (scope-&gt;entry_type !=3D ACPI_DMAR_SCOPE_TYPE_NAMESPACE)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (scope-&gt;enumeration_id !=3D device_number)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; path =3D (void *)(scope &#43; 1);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; for_each_dev_scope(devices, devices_cnt, i, tmp)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tmp =3D=3D NULL=
) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; devices[i].bus =3D scope-&gt;bus;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; devices[i].devfn =3D PCI_DEVFN(path-&gt;device=
, path-&gt;function);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; rcu_assign_pointer(devices[i].dev,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_dev=
ice(&amp;adev-&gt;dev));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WARN_ON(i &gt;=3D devices_cnt);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static int dmar_acpi_bus_add_dev(u8 device_number, struct acpi_de=
vice *adev)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct dmar_drhd_unit *dmaru;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct acpi_dmar_hardware_unit *drhd;<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for_each_drhd_unit(dmaru) {<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; drhd =3D container_of(dmaru-&gt;hdr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct acp=
i_dmar_hardware_unit,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; header);<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ret =3D dmar_acpi_insert_dev_scope(device_number, adev, (void *)(dr=
hd&#43;1),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((void *)drhd)&#43;drhd-&=
gt;header.length,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dmaru-&gt;devices, dmaru-=
&gt;devices_cnt);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (ret)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &gt; 0)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ret =3D dmar_rmrr_add_acpi_dev(device_number, adev);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; for (scope =3D (void *)(drhd &#43; 1);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (unsigned long)scope &lt; ((unsigned long=
)drhd) &#43; drhd-&gt;header.length;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scope =3D ((void *)scope) &#43; scope-&gt=
;length) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (scope-&gt;entry_typ=
e !=3D ACPI_DMAR_SCOPE_TYPE_NAMESPACE)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (scope-&gt;enumerati=
on_id !=3D device_number)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; path =3D (void *)(scope=
 &#43; 1);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_info(&quot;ACPI devi=
ce \&quot;%s\&quot; under DMAR at %llx as %02x:%02x.%d\n&quot;,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; dev_name(&amp;adev-&gt;dev), dmaru-&gt;reg_base_ad=
dr,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; scope-&gt;bus, path-&gt;device, path-&gt;function)=
;<br>
<br>
Please keep such information. People are used to use them as a method to<br=
>
know the hardware configuration.<br>
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for_each_dev_scope(dmar=
u-&gt;devices, dmaru-&gt;devices_cnt, i, tmp)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (tmp =3D=3D NULL) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm=
aru-&gt;devices[i].bus =3D scope-&gt;bus;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm=
aru-&gt;devices[i].devfn =3D PCI_DEVFN(path-&gt;device,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; path-&gt;fu=
nction);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc=
u_assign_pointer(dmaru-&gt;devices[i].dev,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_device(&amp;adev-&gt;dev));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; re=
turn;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG_ON(i &gt;=3D dmaru-=
&gt;devices_cnt);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; pr_warn(&quot;No IOMMU scope found for ANDD =
enumeration ID %d (%s)\n&quot;,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; device_number, dev_name(&amp;adev-&gt;dev));<br>
<br>
Ditto.<br>
<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static int __init dmar_acpi_dev_scope_init(void)<br>
&gt; @@ -766,7 &#43;778,7 @@ static int __init dmar_acpi_dev_scope_init(voi=
d)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; andd-&gt;device_name);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dmar_acpi_insert_dev_sc=
ope(andd-&gt;device_number, adev);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dmar_acpi_bus_add_d=
ev(andd-&gt;device_number, adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c=
<br>
&gt; index ca557d351518..208a91605288 100644<br>
&gt; --- a/drivers/iommu/intel/iommu.c<br>
&gt; &#43;&#43;&#43; b/drivers/iommu/intel/iommu.c<br>
&gt; @@ -4508,6 &#43;4508,25 @@ int dmar_find_matched_atsr_unit(struct pci_=
dev *dev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;int dmar_rmrr_add_acpi_dev(u8 device_number, struct acpi_device *=
adev)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct dmar_rmrr_unit *rmrru;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct acpi_dmar_reserved_memory *rmrr;<=
br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(rmrru, &amp;dmar_rmr=
r_units, list) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; rmrr =3D container_of(rmrru-&gt;hdr,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; struct acpi_dmar_reserved_memory,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; header);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ret =3D dmar_acpi_insert_dev_scope(device_number, adev, (void *)(rm=
rr &#43; 1),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((void *)rmrr) &#43; rmrr=
-&gt;header.length,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rmrru-&gt;devices, rmrru-=
&gt;devices_cnt);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (ret)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;}<br>
<br>
This is only used in dmar.c. Why do you want to define it here and use<br>
it in another file?<br>
<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp; int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_inf=
o *info)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; @@ -4523,7 &#43;4542,7 @@ int dmar_iommu_notify_scope_dev(struct dmar_=
pci_notify_info *info)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; rmrr =3D container_of(rmrru-&gt;hdr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct acp=
i_dmar_reserved_memory, header);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (info-&gt;event =3D=3D BUS_NOTIFY_ADD_DEVICE) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D dmar_insert_dev=
_scope(info, (void *)(rmrr &#43; 1),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D dmar_pci_in=
sert_dev_scope(info, (void *)(rmrr &#43; 1),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((void *)rmrr) &#43; rmrr-&gt;head=
er.length,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rmrr-&gt;segment, rmrru-&gt;device=
s,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rmrru-&gt;devices_cnt);<br>
&gt; @@ -4541,7 &#43;4560,7 @@ int dmar_iommu_notify_scope_dev(struct dmar_=
pci_notify_info *info)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; atsr =3D container_of(atsru-&gt;hdr, struct acpi_dmar_a=
tsr, header);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (info-&gt;event =3D=3D BUS_NOTIFY_ADD_DEVICE) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D dmar_insert_dev=
_scope(info, (void *)(atsr &#43; 1),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D dmar_pci_in=
sert_dev_scope(info, (void *)(atsr &#43; 1),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; (void *)atsr &#43; atsr-&gt;header.length,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; atsr-&gt;segment, atsru-&gt;devices,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; atsru-&gt;devices_cnt);<br>
&gt; diff --git a/include/linux/dmar.h b/include/linux/dmar.h<br>
&gt; index 65565820328a..d0981d35d3c9 100644<br>
&gt; --- a/include/linux/dmar.h<br>
&gt; &#43;&#43;&#43; b/include/linux/dmar.h<br>
&gt; @@ -113,10 &#43;113,14 @@ extern int dmar_parse_dev_scope(void *start,=
 void *end, int *cnt,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dmar_dev_scope **devices, u=
16 segment);<br>
&gt;&nbsp;&nbsp; extern void *dmar_alloc_dev_scope(void *start, void *end, =
int *cnt);<br>
&gt;&nbsp;&nbsp; extern void dmar_free_dev_scope(struct dmar_dev_scope **de=
vices, int *cnt);<br>
&gt; -extern int dmar_insert_dev_scope(struct dmar_pci_notify_info *info,<b=
r>
&gt; &#43;extern int dmar_pci_insert_dev_scope(struct dmar_pci_notify_info =
*info,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *start, void*end, u16 s=
egment,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dmar_dev_scope *devic=
es,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int devices_cnt);<br>
&gt; &#43;extern bool dmar_acpi_insert_dev_scope(u8 device_number,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; struct acpi_device *adev, void *start, void *e=
nd,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dmar_dev_scope *devices, int devices_cn=
t);<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp; extern int dmar_remove_dev_scope(struct dmar_pci_notify_in=
fo *info,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u16 segment, struct dmar_dev=
_scope *devices,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int count);<br>
&gt; @@ -140,6 &#43;144,7 @@ extern int dmar_parse_one_atsr(struct acpi_dma=
r_header *header, void *arg);<br>
&gt;&nbsp;&nbsp; extern int dmar_check_one_atsr(struct acpi_dmar_header *hd=
r, void *arg);<br>
&gt;&nbsp;&nbsp; extern int dmar_release_one_atsr(struct acpi_dmar_header *=
hdr, void *arg);<br>
&gt;&nbsp;&nbsp; extern int dmar_iommu_hotplug(struct dmar_drhd_unit *dmaru=
, bool insert);<br>
&gt; &#43;extern int dmar_rmrr_add_acpi_dev(u8 device_number, struct acpi_d=
evice *adev);<br>
&gt;&nbsp;&nbsp; extern int dmar_iommu_notify_scope_dev(struct dmar_pci_not=
ify_info *info);<br>
&gt;&nbsp;&nbsp; #else /* !CONFIG_INTEL_IOMMU: */<br>
&gt;&nbsp;&nbsp; static inline int intel_iommu_init(void) { return -ENODEV;=
 }<br>
&gt; @@ -150,6 &#43;155,11 @@ static inline void intel_iommu_shutdown(void)=
 { }<br>
&gt;&nbsp;&nbsp; #define&nbsp;&nbsp;&nbsp;&nbsp; dmar_check_one_atsr&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dmar_res_=
noop<br>
&gt;&nbsp;&nbsp; #define&nbsp;&nbsp;&nbsp;&nbsp; dmar_release_one_atsr&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dmar_res_noop<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;static inline int dmar_rmrr_add_acpi_dev(u8 device_number, struct=
 acpi_device *adev)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp; static inline int dmar_iommu_notify_scope_dev(struct dmar_=
pci_notify_info *info)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; <br>
<br>
Best regards,<br>
baolu<br>
</div>
</span></font></div>
</div>
</div>
</div>
</body>
</html>

--_000_09f1d01c5066455a98dcb3dd22ff28d0zhaoxincom_--

--===============2433567167370631992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2433567167370631992==--
