Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA50DC433E6
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 07:54:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 150002071B
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 07:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 150002071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9B3A0204C8;
	Tue,  1 Sep 2020 07:54:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bUOQxKzWnsuJ; Tue,  1 Sep 2020 07:54:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6782522DEC;
	Tue,  1 Sep 2020 07:54:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41409C07FF;
	Tue,  1 Sep 2020 07:54:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F2BFC0051
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 07:54:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1CEF187074
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 07:54:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mtFKxK-hoz1p for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 07:54:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from ZXSHCAS2.zhaoxin.com (unknown [203.148.12.82])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B238187072
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 07:53:56 +0000 (UTC)
Received: from zxbjmbx2.zhaoxin.com (10.29.252.164) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 1 Sep 2020
 15:53:48 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx2.zhaoxin.com
 (10.29.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 1 Sep 2020
 15:53:47 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::290a:f538:51e7:1416]) by
 zxbjmbx1.zhaoxin.com ([fe80::290a:f538:51e7:1416%16]) with mapi id
 15.01.1979.003; Tue, 1 Sep 2020 15:53:47 +0800
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
Thread-Index: AQHWfFkrnkv6/mVfzUi4e7pHcHTybalSzOMAgAChtwk=
Date: Tue, 1 Sep 2020 07:53:47 +0000
Message-ID: <1295ce42af404700ac89f177442bb27f@zhaoxin.com>
References: <20200827100217.21324-1-FelixCui-oc@zhaoxin.com>
 <20200827100217.21324-2-FelixCui-oc@zhaoxin.com>,
 <a7492142-2fbf-781c-8ec7-e85d5ce3f1d5@linux.intel.com>
In-Reply-To: <a7492142-2fbf-781c-8ec7-e85d5ce3f1d5@linux.intel.com>
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
Content-Type: multipart/mixed; boundary="===============8990802420435598234=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============8990802420435598234==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_1295ce42af404700ac89f177442bb27fzhaoxincom_"

--_000_1295ce42af404700ac89f177442bb27fzhaoxincom_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

aGkgIGJhb2x1LA0KDQogICAgICAgICAgICAgICAgICBUaGUgZnVuY3Rpb24gZG1hcl9ybXJyX2Fk
ZF9hY3BpX2RldigpIGlzIGRlZmluZWQgaW4gaW50ZWwvaW9tbXUuYyBiZWNhdXNlIHN0cnVjdCBk
bWFyX3JtcnJfdW5pdCB7fSBpcyBkZWZpbmVkIGluIGludGVsL2lvbW11LmMuDQoNCiAgICAgICAg
ICAgICAgICAgIEFuZCBkbWFyX3BhcnNlX29uZV9ybXJyKCkgIGlzIGFsc28gZGVmaW5lZCBoZXJl
LCBzbyB3ZSB0aGluayBpdCBzaG91bGQgYmUgZGVmaW5lZCBpbiBpb21tdS5jLg0KDQoNCkJlc3Qg
cmVnYXJkcw0KRmVsaXhjdWktb2MNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18N
CreivP7IyzogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCreiy83KsbzkOiAy
MDIwxOo51MIxyNUgMTQ6MDUNCsrVvP7IyzogRmVsaXhDdWktb2M7IEpvZXJnIFJvZWRlbDsgaW9t
bXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IERhdmlkIFdvb2Rob3VzZTsgRGFuIENhcnBlbnRlcjsga2J1aWxkQGxpc3RzLjAxLm9yZw0K
s63LzTogYmFvbHUubHVAbGludXguaW50ZWwuY29tOyBDb2JlQ2hlbi1vYzsgUmF5bW9uZFBhbmct
b2M7IFRvbnkgVyBXYW5nLW9jDQrW98ziOiBSZTogW1BBVENIIHYzIDEvMl0gaW9tbXUvdnQtZDpB
ZGQgc3VwcG9ydCBmb3IgZGV0ZWN0aW5nIEFDUEkgZGV2aWNlIGluIFJNUlINCg0KSGkgRmVsaXgs
DQoNCk9uIDgvMjcvMjAgNjowMiBQTSwgRmVsaXhDdWlvYyB3cm90ZToNCj4gU29tZSBBQ1BJIGRl
dmljZXMgbmVlZCB0byBpc3N1ZSBkbWEgcmVxdWVzdHMgdG8gYWNjZXNzDQo+IHRoZSByZXNlcnZl
ZCBtZW1vcnkgYXJlYS5CSU9TIHVzZXMgdGhlIGRldmljZSBzY29wZSB0eXBlDQo+IEFDUElfTkFN
RVNQQUNFX0RFVklDRSBpbiBSTVJSIHRvIHJlcG9ydCB0aGVzZSBBQ1BJIGRldmljZXMuDQo+IFRo
aXMgcGF0Y2ggYWRkIHN1cHBvcnQgZm9yIGRldGVjdGluZyBBQ1BJIGRldmljZXMgaW4gUk1SUi4N
Cj4NCj4gU2lnbmVkLW9mZi1ieTogRmVsaXhDdWlvYyA8RmVsaXhDdWktb2NAemhhb3hpbi5jb20+
DQo+IC0tLQ0KPiAgIGRyaXZlcnMvaW9tbXUvaW50ZWwvZG1hci5jICB8IDc2ICsrKysrKysrKysr
KysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0NCj4gICBkcml2ZXJzL2lvbW11L2ludGVsL2lvbW11
LmMgfCAyMyArKysrKysrKysrLQ0KPiAgIGluY2x1ZGUvbGludXgvZG1hci5oICAgICAgICB8IDEy
ICsrKysrLQ0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgNzYgaW5zZXJ0aW9ucygrKSwgMzUgZGVsZXRp
b25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsL2RtYXIuYyBiL2Ry
aXZlcnMvaW9tbXUvaW50ZWwvZG1hci5jDQo+IGluZGV4IDkzZTYzNDVmMzQxNC4uZjY2OTFjMzZi
ZDNmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsL2RtYXIuYw0KPiArKysgYi9k
cml2ZXJzL2lvbW11L2ludGVsL2RtYXIuYw0KPiBAQCAtMjE1LDcgKzIxNSw3IEBAIHN0YXRpYyBi
b29sIGRtYXJfbWF0Y2hfcGNpX3BhdGgoc3RydWN0IGRtYXJfcGNpX25vdGlmeV9pbmZvICppbmZv
LCBpbnQgYnVzLA0KPiAgIH0NCj4NCj4gICAvKiBSZXR1cm46ID4gMCBpZiBtYXRjaCBmb3VuZCwg
MCBpZiBubyBtYXRjaCBmb3VuZCwgPCAwIGlmIGVycm9yIGhhcHBlbnMgKi8NCj4gLWludCBkbWFy
X2luc2VydF9kZXZfc2NvcGUoc3RydWN0IGRtYXJfcGNpX25vdGlmeV9pbmZvICppbmZvLA0KPiAr
aW50IGRtYXJfcGNpX2luc2VydF9kZXZfc2NvcGUoc3RydWN0IGRtYXJfcGNpX25vdGlmeV9pbmZv
ICppbmZvLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAqc3RhcnQsIHZvaWQqZW5k
LCB1MTYgc2VnbWVudCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBkbWFyX2Rl
dl9zY29wZSAqZGV2aWNlcywNCj4gICAgICAgICAgICAgICAgICAgICAgICAgIGludCBkZXZpY2Vz
X2NudCkNCj4gQEAgLTMwNCw3ICszMDQsNyBAQCBzdGF0aWMgaW50IGRtYXJfcGNpX2J1c19hZGRf
ZGV2KHN0cnVjdCBkbWFyX3BjaV9ub3RpZnlfaW5mbyAqaW5mbykNCj4NCj4gICAgICAgICAgICAg
ICAgZHJoZCA9IGNvbnRhaW5lcl9vZihkbWFydS0+aGRyLA0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHN0cnVjdCBhY3BpX2RtYXJfaGFyZHdhcmVfdW5pdCwgaGVhZGVyKTsN
Cj4gLSAgICAgICAgICAgICByZXQgPSBkbWFyX2luc2VydF9kZXZfc2NvcGUoaW5mbywgKHZvaWQg
KikoZHJoZCArIDEpLA0KPiArICAgICAgICAgICAgIHJldCA9IGRtYXJfcGNpX2luc2VydF9kZXZf
c2NvcGUoaW5mbywgKHZvaWQgKikoZHJoZCArIDEpLA0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgKCh2b2lkICopZHJoZCkgKyBkcmhkLT5oZWFkZXIubGVuZ3RoLA0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZG1hcnUtPnNlZ21lbnQsDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBkbWFydS0+ZGV2aWNlcywgZG1hcnUtPmRldmljZXNfY250KTsNCj4g
QEAgLTY5Nyw0NyArNjk3LDU5IEBAIGRtYXJfZmluZF9tYXRjaGVkX2RyaGRfdW5pdChzdHJ1Y3Qg
cGNpX2RldiAqZGV2KQ0KPiAgICAgICAgcmV0dXJuIGRtYXJ1Ow0KPiAgIH0NCj4NCj4gLXN0YXRp
YyB2b2lkIF9faW5pdCBkbWFyX2FjcGlfaW5zZXJ0X2Rldl9zY29wZSh1OCBkZXZpY2VfbnVtYmVy
LA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBh
Y3BpX2RldmljZSAqYWRldikNCj4gKy8qIFJldHVybjogPiAwIGlmIG1hdGNoIGZvdW5kLCAwIGlm
IG5vIG1hdGNoIGZvdW5kICovDQo+ICtib29sIGRtYXJfYWNwaV9pbnNlcnRfZGV2X3Njb3BlKHU4
IGRldmljZV9udW1iZXIsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBh
Y3BpX2RldmljZSAqYWRldiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAq
c3RhcnQsIHZvaWQgKmVuZCwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IGRtYXJfZGV2X3Njb3BlICpkZXZpY2VzLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBpbnQgZGV2aWNlc19jbnQpDQo+ICAgew0KPiAtICAgICBzdHJ1Y3QgZG1hcl9kcmhkX3VuaXQg
KmRtYXJ1Ow0KPiAtICAgICBzdHJ1Y3QgYWNwaV9kbWFyX2hhcmR3YXJlX3VuaXQgKmRyaGQ7DQo+
ICAgICAgICBzdHJ1Y3QgYWNwaV9kbWFyX2RldmljZV9zY29wZSAqc2NvcGU7DQo+ICAgICAgICBz
dHJ1Y3QgZGV2aWNlICp0bXA7DQo+ICAgICAgICBpbnQgaTsNCj4gICAgICAgIHN0cnVjdCBhY3Bp
X2RtYXJfcGNpX3BhdGggKnBhdGg7DQo+DQo+ICsgICAgIGZvciAoOyBzdGFydCA8IGVuZDsgc3Rh
cnQgKz0gc2NvcGUtPmxlbmd0aCkgew0KPiArICAgICAgICAgICAgIHNjb3BlID0gc3RhcnQ7DQo+
ICsgICAgICAgICAgICAgaWYgKHNjb3BlLT5lbnRyeV90eXBlICE9IEFDUElfRE1BUl9TQ09QRV9U
WVBFX05BTUVTUEFDRSkNCj4gKyAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiArICAg
ICAgICAgICAgIGlmIChzY29wZS0+ZW51bWVyYXRpb25faWQgIT0gZGV2aWNlX251bWJlcikNCj4g
KyAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiArICAgICAgICAgICAgIHBhdGggPSAo
dm9pZCAqKShzY29wZSArIDEpOw0KPiArICAgICAgICAgICAgIGZvcl9lYWNoX2Rldl9zY29wZShk
ZXZpY2VzLCBkZXZpY2VzX2NudCwgaSwgdG1wKQ0KPiArICAgICAgICAgICAgICAgICAgICAgaWYg
KHRtcCA9PSBOVUxMKSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRldmljZXNb
aV0uYnVzID0gc2NvcGUtPmJ1czsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGV2
aWNlc1tpXS5kZXZmbiA9IFBDSV9ERVZGTihwYXRoLT5kZXZpY2UsIHBhdGgtPmZ1bmN0aW9uKTsN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmN1X2Fzc2lnbl9wb2ludGVyKGRldmlj
ZXNbaV0uZGV2LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgZ2V0X2RldmljZSgmYWRldi0+ZGV2KSk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHJldHVybiB0cnVlOw0KPiArICAgICAgICAgICAgICAgICAgICAgfQ0KPiArICAgICAg
ICAgICAgIFdBUk5fT04oaSA+PSBkZXZpY2VzX2NudCk7DQo+ICsgICAgIH0NCj4gKyAgICAgcmV0
dXJuIGZhbHNlOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IGRtYXJfYWNwaV9idXNfYWRkX2Rl
dih1OCBkZXZpY2VfbnVtYmVyLCBzdHJ1Y3QgYWNwaV9kZXZpY2UgKmFkZXYpDQo+ICt7DQo+ICsg
ICAgIHN0cnVjdCBkbWFyX2RyaGRfdW5pdCAqZG1hcnU7DQo+ICsgICAgIHN0cnVjdCBhY3BpX2Rt
YXJfaGFyZHdhcmVfdW5pdCAqZHJoZDsNCj4gKyAgICAgaW50IHJldDsNCj4gKw0KPiAgICAgICAg
Zm9yX2VhY2hfZHJoZF91bml0KGRtYXJ1KSB7DQo+ICAgICAgICAgICAgICAgIGRyaGQgPSBjb250
YWluZXJfb2YoZG1hcnUtPmhkciwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBzdHJ1Y3QgYWNwaV9kbWFyX2hhcmR3YXJlX3VuaXQsDQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgaGVhZGVyKTsNCj4gKyAgICAgICAgICAgICByZXQgPSBkbWFyX2FjcGlf
aW5zZXJ0X2Rldl9zY29wZShkZXZpY2VfbnVtYmVyLCBhZGV2LCAodm9pZCAqKShkcmhkKzEpLA0K
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKCh2b2lkICop
ZHJoZCkrZHJoZC0+aGVhZGVyLmxlbmd0aCwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGRtYXJ1LT5kZXZpY2VzLCBkbWFydS0+ZGV2aWNlc19jbnQpOw0K
PiArICAgICAgICAgICAgIGlmIChyZXQpDQo+ICsgICAgICAgICAgICAgICAgICAgICBicmVhazsN
Cj4gKyAgICAgfQ0KPiArICAgICBpZiAocmV0ID4gMCkNCj4gKyAgICAgICAgICAgICByZXQgPSBk
bWFyX3JtcnJfYWRkX2FjcGlfZGV2KGRldmljZV9udW1iZXIsIGFkZXYpOw0KPg0KPiAtICAgICAg
ICAgICAgIGZvciAoc2NvcGUgPSAodm9pZCAqKShkcmhkICsgMSk7DQo+IC0gICAgICAgICAgICAg
ICAgICAodW5zaWduZWQgbG9uZylzY29wZSA8ICgodW5zaWduZWQgbG9uZylkcmhkKSArIGRyaGQt
PmhlYWRlci5sZW5ndGg7DQo+IC0gICAgICAgICAgICAgICAgICBzY29wZSA9ICgodm9pZCAqKXNj
b3BlKSArIHNjb3BlLT5sZW5ndGgpIHsNCj4gLSAgICAgICAgICAgICAgICAgICAgIGlmIChzY29w
ZS0+ZW50cnlfdHlwZSAhPSBBQ1BJX0RNQVJfU0NPUEVfVFlQRV9OQU1FU1BBQ0UpDQo+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiAtICAgICAgICAgICAgICAgICAg
ICAgaWYgKHNjb3BlLT5lbnVtZXJhdGlvbl9pZCAhPSBkZXZpY2VfbnVtYmVyKQ0KPiAtICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4gKyAgICAgcmV0dXJuIHJldDsNCj4N
Cj4gLSAgICAgICAgICAgICAgICAgICAgIHBhdGggPSAodm9pZCAqKShzY29wZSArIDEpOw0KPiAt
ICAgICAgICAgICAgICAgICAgICAgcHJfaW5mbygiQUNQSSBkZXZpY2UgXCIlc1wiIHVuZGVyIERN
QVIgYXQgJWxseCBhcyAlMDJ4OiUwMnguJWRcbiIsDQo+IC0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGRldl9uYW1lKCZhZGV2LT5kZXYpLCBkbWFydS0+cmVnX2Jhc2VfYWRkciwNCj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgc2NvcGUtPmJ1cywgcGF0aC0+ZGV2aWNlLCBwYXRo
LT5mdW5jdGlvbik7DQoNClBsZWFzZSBrZWVwIHN1Y2ggaW5mb3JtYXRpb24uIFBlb3BsZSBhcmUg
dXNlZCB0byB1c2UgdGhlbSBhcyBhIG1ldGhvZCB0bw0Ka25vdyB0aGUgaGFyZHdhcmUgY29uZmln
dXJhdGlvbi4NCg0KPiAtICAgICAgICAgICAgICAgICAgICAgZm9yX2VhY2hfZGV2X3Njb3BlKGRt
YXJ1LT5kZXZpY2VzLCBkbWFydS0+ZGV2aWNlc19jbnQsIGksIHRtcCkNCj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgaWYgKHRtcCA9PSBOVUxMKSB7DQo+IC0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgZG1hcnUtPmRldmljZXNbaV0uYnVzID0gc2NvcGUtPmJ1czsN
Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkbWFydS0+ZGV2aWNlc1tp
XS5kZXZmbiA9IFBDSV9ERVZGTihwYXRoLT5kZXZpY2UsDQo+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGF0
aC0+ZnVuY3Rpb24pOw0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJj
dV9hc3NpZ25fcG9pbnRlcihkbWFydS0+ZGV2aWNlc1tpXS5kZXYsDQo+IC0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdldF9kZXZpY2UoJmFk
ZXYtPmRldikpOw0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVy
bjsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiAtICAgICAgICAgICAgICAg
ICAgICAgQlVHX09OKGkgPj0gZG1hcnUtPmRldmljZXNfY250KTsNCj4gLSAgICAgICAgICAgICB9
DQo+IC0gICAgIH0NCj4gLSAgICAgcHJfd2FybigiTm8gSU9NTVUgc2NvcGUgZm91bmQgZm9yIEFO
REQgZW51bWVyYXRpb24gSUQgJWQgKCVzKVxuIiwNCj4gLSAgICAgICAgICAgICBkZXZpY2VfbnVt
YmVyLCBkZXZfbmFtZSgmYWRldi0+ZGV2KSk7DQoNCkRpdHRvLg0KDQo+ICAgfQ0KPg0KPiAgIHN0
YXRpYyBpbnQgX19pbml0IGRtYXJfYWNwaV9kZXZfc2NvcGVfaW5pdCh2b2lkKQ0KPiBAQCAtNzY2
LDcgKzc3OCw3IEBAIHN0YXRpYyBpbnQgX19pbml0IGRtYXJfYWNwaV9kZXZfc2NvcGVfaW5pdCh2
b2lkKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFuZGQtPmRldmlj
ZV9uYW1lKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiAg
ICAgICAgICAgICAgICAgICAgICAgIH0NCj4gLSAgICAgICAgICAgICAgICAgICAgIGRtYXJfYWNw
aV9pbnNlcnRfZGV2X3Njb3BlKGFuZGQtPmRldmljZV9udW1iZXIsIGFkZXYpOw0KPiArICAgICAg
ICAgICAgICAgICAgICAgZG1hcl9hY3BpX2J1c19hZGRfZGV2KGFuZGQtPmRldmljZV9udW1iZXIs
IGFkZXYpOw0KPiAgICAgICAgICAgICAgICB9DQo+ICAgICAgICB9DQo+ICAgICAgICByZXR1cm4g
MDsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYyBiL2RyaXZlcnMv
aW9tbXUvaW50ZWwvaW9tbXUuYw0KPiBpbmRleCBjYTU1N2QzNTE1MTguLjIwOGE5MTYwNTI4OCAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jDQo+ICsrKyBiL2RyaXZl
cnMvaW9tbXUvaW50ZWwvaW9tbXUuYw0KPiBAQCAtNDUwOCw2ICs0NTA4LDI1IEBAIGludCBkbWFy
X2ZpbmRfbWF0Y2hlZF9hdHNyX3VuaXQoc3RydWN0IHBjaV9kZXYgKmRldikNCj4gICAgICAgIHJl
dHVybiByZXQ7DQo+ICAgfQ0KPg0KPiAraW50IGRtYXJfcm1ycl9hZGRfYWNwaV9kZXYodTggZGV2
aWNlX251bWJlciwgc3RydWN0IGFjcGlfZGV2aWNlICphZGV2KQ0KPiArew0KPiArICAgICBpbnQg
cmV0Ow0KPiArICAgICBzdHJ1Y3QgZG1hcl9ybXJyX3VuaXQgKnJtcnJ1Ow0KPiArICAgICBzdHJ1
Y3QgYWNwaV9kbWFyX3Jlc2VydmVkX21lbW9yeSAqcm1ycjsNCj4gKw0KPiArICAgICBsaXN0X2Zv
cl9lYWNoX2VudHJ5KHJtcnJ1LCAmZG1hcl9ybXJyX3VuaXRzLCBsaXN0KSB7DQo+ICsgICAgICAg
ICAgICAgcm1yciA9IGNvbnRhaW5lcl9vZihybXJydS0+aGRyLA0KPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBzdHJ1Y3QgYWNwaV9kbWFyX3Jlc2VydmVkX21lbW9yeSwNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgaGVhZGVyKTsNCj4gKyAgICAgICAgICAgICByZXQgPSBk
bWFyX2FjcGlfaW5zZXJ0X2Rldl9zY29wZShkZXZpY2VfbnVtYmVyLCBhZGV2LCAodm9pZCAqKShy
bXJyICsgMSksDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAoKHZvaWQgKilybXJyKSArIHJtcnItPmhlYWRlci5sZW5ndGgsDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBybXJydS0+ZGV2aWNlcywgcm1ycnUtPmRl
dmljZXNfY250KTsNCj4gKyAgICAgICAgICAgICBpZiAocmV0KQ0KPiArICAgICAgICAgICAgICAg
ICAgICAgYnJlYWs7DQo+ICsgICAgIH0NCj4gKyAgICAgcmV0dXJuIDA7DQo+ICt9DQoNClRoaXMg
aXMgb25seSB1c2VkIGluIGRtYXIuYy4gV2h5IGRvIHlvdSB3YW50IHRvIGRlZmluZSBpdCBoZXJl
IGFuZCB1c2UNCml0IGluIGFub3RoZXIgZmlsZT8NCg0KPiArDQo+ICAgaW50IGRtYXJfaW9tbXVf
bm90aWZ5X3Njb3BlX2RldihzdHJ1Y3QgZG1hcl9wY2lfbm90aWZ5X2luZm8gKmluZm8pDQo+ICAg
ew0KPiAgICAgICAgaW50IHJldDsNCj4gQEAgLTQ1MjMsNyArNDU0Miw3IEBAIGludCBkbWFyX2lv
bW11X25vdGlmeV9zY29wZV9kZXYoc3RydWN0IGRtYXJfcGNpX25vdGlmeV9pbmZvICppbmZvKQ0K
PiAgICAgICAgICAgICAgICBybXJyID0gY29udGFpbmVyX29mKHJtcnJ1LT5oZHIsDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGFjcGlfZG1hcl9yZXNlcnZlZF9t
ZW1vcnksIGhlYWRlcik7DQo+ICAgICAgICAgICAgICAgIGlmIChpbmZvLT5ldmVudCA9PSBCVVNf
Tk9USUZZX0FERF9ERVZJQ0UpIHsNCj4gLSAgICAgICAgICAgICAgICAgICAgIHJldCA9IGRtYXJf
aW5zZXJ0X2Rldl9zY29wZShpbmZvLCAodm9pZCAqKShybXJyICsgMSksDQo+ICsgICAgICAgICAg
ICAgICAgICAgICByZXQgPSBkbWFyX3BjaV9pbnNlcnRfZGV2X3Njb3BlKGluZm8sICh2b2lkICop
KHJtcnIgKyAxKSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICgodm9pZCAqKXJt
cnIpICsgcm1yci0+aGVhZGVyLmxlbmd0aCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHJtcnItPnNlZ21lbnQsIHJtcnJ1LT5kZXZpY2VzLA0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgcm1ycnUtPmRldmljZXNfY250KTsNCj4gQEAgLTQ1NDEsNyArNDU2MCw3IEBA
IGludCBkbWFyX2lvbW11X25vdGlmeV9zY29wZV9kZXYoc3RydWN0IGRtYXJfcGNpX25vdGlmeV9p
bmZvICppbmZvKQ0KPg0KPiAgICAgICAgICAgICAgICBhdHNyID0gY29udGFpbmVyX29mKGF0c3J1
LT5oZHIsIHN0cnVjdCBhY3BpX2RtYXJfYXRzciwgaGVhZGVyKTsNCj4gICAgICAgICAgICAgICAg
aWYgKGluZm8tPmV2ZW50ID09IEJVU19OT1RJRllfQUREX0RFVklDRSkgew0KPiAtICAgICAgICAg
ICAgICAgICAgICAgcmV0ID0gZG1hcl9pbnNlcnRfZGV2X3Njb3BlKGluZm8sICh2b2lkICopKGF0
c3IgKyAxKSwNCj4gKyAgICAgICAgICAgICAgICAgICAgIHJldCA9IGRtYXJfcGNpX2luc2VydF9k
ZXZfc2NvcGUoaW5mbywgKHZvaWQgKikoYXRzciArIDEpLA0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAodm9pZCAqKWF0c3IgKyBhdHNyLT5oZWFkZXIubGVuZ3RoLA0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhdHNyLT5zZWdtZW50LCBh
dHNydS0+ZGV2aWNlcywNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
YXRzcnUtPmRldmljZXNfY250KTsNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZG1hci5o
IGIvaW5jbHVkZS9saW51eC9kbWFyLmgNCj4gaW5kZXggNjU1NjU4MjAzMjhhLi5kMDk4MWQzNWQz
YzkgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvZG1hci5oDQo+ICsrKyBiL2luY2x1ZGUv
bGludXgvZG1hci5oDQo+IEBAIC0xMTMsMTAgKzExMywxNCBAQCBleHRlcm4gaW50IGRtYXJfcGFy
c2VfZGV2X3Njb3BlKHZvaWQgKnN0YXJ0LCB2b2lkICplbmQsIGludCAqY250LA0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGRtYXJfZGV2X3Njb3BlICoqZGV2aWNlcywg
dTE2IHNlZ21lbnQpOw0KPiAgIGV4dGVybiB2b2lkICpkbWFyX2FsbG9jX2Rldl9zY29wZSh2b2lk
ICpzdGFydCwgdm9pZCAqZW5kLCBpbnQgKmNudCk7DQo+ICAgZXh0ZXJuIHZvaWQgZG1hcl9mcmVl
X2Rldl9zY29wZShzdHJ1Y3QgZG1hcl9kZXZfc2NvcGUgKipkZXZpY2VzLCBpbnQgKmNudCk7DQo+
IC1leHRlcm4gaW50IGRtYXJfaW5zZXJ0X2Rldl9zY29wZShzdHJ1Y3QgZG1hcl9wY2lfbm90aWZ5
X2luZm8gKmluZm8sDQo+ICtleHRlcm4gaW50IGRtYXJfcGNpX2luc2VydF9kZXZfc2NvcGUoc3Ry
dWN0IGRtYXJfcGNpX25vdGlmeV9pbmZvICppbmZvLA0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHZvaWQgKnN0YXJ0LCB2b2lkKmVuZCwgdTE2IHNlZ21lbnQsDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGRtYXJfZGV2X3Njb3BlICpkZXZpY2VzLA0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCBkZXZpY2VzX2NudCk7DQo+ICtl
eHRlcm4gYm9vbCBkbWFyX2FjcGlfaW5zZXJ0X2Rldl9zY29wZSh1OCBkZXZpY2VfbnVtYmVyLA0K
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgYWNwaV9kZXZpY2UgKmFkZXYs
IHZvaWQgKnN0YXJ0LCB2b2lkICplbmQsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHN0cnVjdCBkbWFyX2Rldl9zY29wZSAqZGV2aWNlcywgaW50IGRldmljZXNfY250KTsNCj4gKw0K
PiAgIGV4dGVybiBpbnQgZG1hcl9yZW1vdmVfZGV2X3Njb3BlKHN0cnVjdCBkbWFyX3BjaV9ub3Rp
ZnlfaW5mbyAqaW5mbywNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1MTYgc2Vn
bWVudCwgc3RydWN0IGRtYXJfZGV2X3Njb3BlICpkZXZpY2VzLA0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGludCBjb3VudCk7DQo+IEBAIC0xNDAsNiArMTQ0LDcgQEAgZXh0ZXJu
IGludCBkbWFyX3BhcnNlX29uZV9hdHNyKHN0cnVjdCBhY3BpX2RtYXJfaGVhZGVyICpoZWFkZXIs
IHZvaWQgKmFyZyk7DQo+ICAgZXh0ZXJuIGludCBkbWFyX2NoZWNrX29uZV9hdHNyKHN0cnVjdCBh
Y3BpX2RtYXJfaGVhZGVyICpoZHIsIHZvaWQgKmFyZyk7DQo+ICAgZXh0ZXJuIGludCBkbWFyX3Jl
bGVhc2Vfb25lX2F0c3Ioc3RydWN0IGFjcGlfZG1hcl9oZWFkZXIgKmhkciwgdm9pZCAqYXJnKTsN
Cj4gICBleHRlcm4gaW50IGRtYXJfaW9tbXVfaG90cGx1ZyhzdHJ1Y3QgZG1hcl9kcmhkX3VuaXQg
KmRtYXJ1LCBib29sIGluc2VydCk7DQo+ICtleHRlcm4gaW50IGRtYXJfcm1ycl9hZGRfYWNwaV9k
ZXYodTggZGV2aWNlX251bWJlciwgc3RydWN0IGFjcGlfZGV2aWNlICphZGV2KTsNCj4gICBleHRl
cm4gaW50IGRtYXJfaW9tbXVfbm90aWZ5X3Njb3BlX2RldihzdHJ1Y3QgZG1hcl9wY2lfbm90aWZ5
X2luZm8gKmluZm8pOw0KPiAgICNlbHNlIC8qICFDT05GSUdfSU5URUxfSU9NTVU6ICovDQo+ICAg
c3RhdGljIGlubGluZSBpbnQgaW50ZWxfaW9tbXVfaW5pdCh2b2lkKSB7IHJldHVybiAtRU5PREVW
OyB9DQo+IEBAIC0xNTAsNiArMTU1LDExIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBpbnRlbF9pb21t
dV9zaHV0ZG93bih2b2lkKSB7IH0NCj4gICAjZGVmaW5lICAgICBkbWFyX2NoZWNrX29uZV9hdHNy
ICAgICAgICAgICAgIGRtYXJfcmVzX25vb3ANCj4gICAjZGVmaW5lICAgICBkbWFyX3JlbGVhc2Vf
b25lX2F0c3IgICAgICAgICAgIGRtYXJfcmVzX25vb3ANCj4NCj4gK3N0YXRpYyBpbmxpbmUgaW50
IGRtYXJfcm1ycl9hZGRfYWNwaV9kZXYodTggZGV2aWNlX251bWJlciwgc3RydWN0IGFjcGlfZGV2
aWNlICphZGV2KQ0KPiArew0KPiArICAgICByZXR1cm4gMDsNCj4gK30NCj4gKw0KPiAgIHN0YXRp
YyBpbmxpbmUgaW50IGRtYXJfaW9tbXVfbm90aWZ5X3Njb3BlX2RldihzdHJ1Y3QgZG1hcl9wY2lf
bm90aWZ5X2luZm8gKmluZm8pDQo+ICAgew0KPiAgICAgICAgcmV0dXJuIDA7DQo+DQoNCkJlc3Qg
cmVnYXJkcywNCmJhb2x1DQo=

--_000_1295ce42af404700ac89f177442bb27fzhaoxincom_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
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
</body>
</html>

--_000_1295ce42af404700ac89f177442bb27fzhaoxincom_--

--===============8990802420435598234==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============8990802420435598234==--
