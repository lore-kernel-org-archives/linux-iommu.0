Return-Path: <SRS0=BMay=CL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,HEADER_FROM_DIFFERENT_DOMAINS,HTML_FONT_FACE_BAD,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085B0C433E2
	for <iommu@archiver.kernel.org>; Wed,  2 Sep 2020 03:24:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF3E42065E
	for <iommu@archiver.kernel.org>; Wed,  2 Sep 2020 03:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF3E42065E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 61ABD20386;
	Wed,  2 Sep 2020 03:24:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h-cAYSOdnTlJ; Wed,  2 Sep 2020 03:24:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 214B020397;
	Wed,  2 Sep 2020 03:24:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B67CC07FF;
	Wed,  2 Sep 2020 03:24:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 484B8C0051
 for <iommu@lists.linux-foundation.org>; Wed,  2 Sep 2020 03:24:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3E017867F1
 for <iommu@lists.linux-foundation.org>; Wed,  2 Sep 2020 03:24:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BB15FrYjg2MV for <iommu@lists.linux-foundation.org>;
 Wed,  2 Sep 2020 03:24:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from ZXSHCAS1.zhaoxin.com (unknown [203.148.12.81])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C407583204
 for <iommu@lists.linux-foundation.org>; Wed,  2 Sep 2020 03:24:34 +0000 (UTC)
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 2 Sep 2020
 11:24:27 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 2 Sep 2020
 11:24:26 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::290a:f538:51e7:1416]) by
 zxbjmbx1.zhaoxin.com ([fe80::290a:f538:51e7:1416%16]) with mapi id
 15.01.1979.003; Wed, 2 Sep 2020 11:24:26 +0800
From: FelixCui-oc <FelixCui-oc@zhaoxin.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David
 Woodhouse" <dwmw2@infradead.org>, Dan Carpenter <dan.carpenter@oracle.com>,
 "kbuild@lists.01.org" <kbuild@lists.01.org>
Subject: =?gb2312?B?tPC4tDogtPC4tDogW1BBVENIIHYzIDIvMl0gaW9tbXUvdnQtZDpBZGQgc3Vw?=
 =?gb2312?Q?port_for_probing_ACPI_device_in_RMRR?=
Thread-Topic: =?gb2312?B?tPC4tDogW1BBVENIIHYzIDIvMl0gaW9tbXUvdnQtZDpBZGQgc3VwcG9ydCBm?=
 =?gb2312?Q?or_probing_ACPI_device_in_RMRR?=
Thread-Index: AQHWfFkssCqC/uq8zUSrxxRHHTL9PKlSzvUAgAC26n+AAJ31AIAAkzS7
Date: Wed, 2 Sep 2020 03:24:26 +0000
Message-ID: <cfdd29a882d140e5aec2e8c3b77f4968@zhaoxin.com>
References: <20200827100217.21324-1-FelixCui-oc@zhaoxin.com>
 <20200827100217.21324-3-FelixCui-oc@zhaoxin.com>
 <e5b1daaf-f073-94c9-714c-832b10d284f4@linux.intel.com>
 <cde22f0f02f94efcae8bf044e2cd9441@zhaoxin.com>,
 <7e5f2c33-c6c3-f344-9014-1f6a306c55aa@linux.intel.com>
In-Reply-To: <7e5f2c33-c6c3-f344-9014-1f6a306c55aa@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.29.8.19]
MIME-Version: 1.0
Cc: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
 CobeChen-oc <CobeChen-oc@zhaoxin.com>, Ashok Raj <ashok.raj@intel.com>
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
Content-Type: multipart/mixed; boundary="===============9102775165268841522=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============9102775165268841522==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_cfdd29a882d140e5aec2e8c3b77f4968zhaoxincom_"

--_000_cfdd29a882d140e5aec2e8c3b77f4968zhaoxincom_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

aGkgYmFvbHUsDQoNCj4gU28geW91IGhhdmUgYSBoaWRkZW4gZGV2aWNlIChpbnZpc2libGUgdG8g
aG9zdCBrZXJuZWwpLiBCdXQgeW91IG5lZWQgdG8NCg0KPnNldHVwIHNvbWUgaWRlbnRpdHkgbWFw
cGluZ3MgZm9yIHRoaXMgZGV2aWNlLCBzbyB0aGF0IHRoZSBmaXJtd2FyZQ0KPmNvdWxkIGtlZXAg
d29ya2luZywgcmlnaHQ/DQoNCj5UaGUgcGxhdGZvcm0gZGVzaWducyB0aGlzIGJ5IHB1dHRpbmcg
dGhhdCByYW5nZSBpbiB0aGUgUk1SUiB0YWJsZSBhbmQNCj5leHBlY3RpbmcgdGhlIE9TIGtlcm5l
bCB0byBzZXR1cCBpZGVudGl0eSBtYXBwaW5ncyBkdXJpbmcgYm9vdC4NCg0KPkRvIEkgdW5kZXJz
dGFuZCBpdCByaWdodD8NCg0KDQpZZXMuIFdoYXQgeW91IHVuZGVyc3RhbmQgaXMgY29ycmVjdC4N
Cg0KDQpCZXN0IHJlZ2FyZHMNCg0KRmVsaXhjdWktb2MNCg0KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18NCreivP7IyzogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4N
Creiy83KsbzkOiAyMDIwxOo51MIyyNUgMTA6MzI6MzYNCsrVvP7IyzogRmVsaXhDdWktb2M7IEpv
ZXJnIFJvZWRlbDsgaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IERhdmlkIFdvb2Rob3VzZTsgRGFuIENhcnBlbnRlcjsga2J1aWxk
QGxpc3RzLjAxLm9yZw0Ks63LzTogYmFvbHUubHVAbGludXguaW50ZWwuY29tOyBDb2JlQ2hlbi1v
YzsgUmF5bW9uZFBhbmctb2M7IFRvbnkgVyBXYW5nLW9jOyBBc2hvayBSYWoNCtb3zOI6IFJlOiC0
8Li0OiBbUEFUQ0ggdjMgMi8yXSBpb21tdS92dC1kOkFkZCBzdXBwb3J0IGZvciBwcm9iaW5nIEFD
UEkgZGV2aWNlIGluIFJNUlINCg0KT24gOS8xLzIwIDU6MTMgUE0sIEZlbGl4Q3VpLW9jIHdyb3Rl
Og0KPiBoaSAgYmFvbHUgLA0KPg0KPiAgICAgICAgICAgICAgICAgICAgIFRoZXNlIEFDUEkgZGV2
aWNlcyBjYW4gYmUgcmV0cmlldmVkIGZyb20gdGhlIGtlcm5lbA0KPiBhbmQgdGhlcmUgaXMgbm8g
Ym91bmQgZGV2aWNlIGRyaXZlciAuDQoNClNvIHlvdSBoYXZlIGEgaGlkZGVuIGRldmljZSAoaW52
aXNpYmxlIHRvIGhvc3Qga2VybmVsKS4gQnV0IHlvdSBuZWVkIHRvDQpzZXR1cCBzb21lIGlkZW50
aXR5IG1hcHBpbmdzIGZvciB0aGlzIGRldmljZSwgc28gdGhhdCB0aGUgZmlybXdhcmUNCmNvdWxk
IGtlZXAgd29ya2luZywgcmlnaHQ/DQoNClRoZSBwbGF0Zm9ybSBkZXNpZ25zIHRoaXMgYnkgcHV0
dGluZyB0aGF0IHJhbmdlIGluIHRoZSBSTVJSIHRhYmxlIGFuZA0KZXhwZWN0aW5nIHRoZSBPUyBr
ZXJuZWwgdG8gc2V0dXAgaWRlbnRpdHkgbWFwcGluZ3MgZHVyaW5nIGJvb3QuDQoNCkRvIEkgdW5k
ZXJzdGFuZCBpdCByaWdodD8NCg0KQmVzdCByZWdhcmRzLA0KYmFvbHUNCg0KPg0KPg0KPiBCZXN0
IHJlZ2FyZHMNCj4NCj4gRmVsaXhjdWktb2MNCj4NCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICq3orz+
yMs6KiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiAqt6LLzcqxvOQ6KiAy
MDIwxOo51MIxyNUgMTQ6MTI6MzQNCj4gKsrVvP7IyzoqIEZlbGl4Q3VpLW9jOyBKb2VyZyBSb2Vk
ZWw7IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBEYXZpZCBXb29kaG91c2U7IERhbiBDYXJwZW50ZXI7DQo+IGtidWlsZEBs
aXN0cy4wMS5vcmcNCj4gKrOty806KiBiYW9sdS5sdUBsaW51eC5pbnRlbC5jb207IENvYmVDaGVu
LW9jOyBSYXltb25kUGFuZy1vYzsgVG9ueSBXDQo+IFdhbmctb2MNCj4gKtb3zOI6KiBSZTogW1BB
VENIIHYzIDIvMl0gaW9tbXUvdnQtZDpBZGQgc3VwcG9ydCBmb3IgcHJvYmluZyBBQ1BJDQo+IGRl
dmljZSBpbiBSTVJSDQo+IEhpIEZlbGl4LA0KPg0KPiBPbiA4LzI3LzIwIDY6MDIgUE0sIEZlbGl4
Q3Vpb2Mgd3JvdGU6DQo+PiBBZnRlciBhY3BpIGRldmljZSBpbiBSTVJSIGlzIGRldGVjdGVkLGl0
IGlzIG5lY2Vzc2FyeQ0KPj4gdG8gZXN0YWJsaXNoIGEgbWFwcGluZyBmb3IgdGhlc2UgZGV2aWNl
cy4NCj4+IEluIGFjcGlfZGV2aWNlX2NyZWF0ZV9kaXJlY3RfbWFwcGluZ3MoKSxjcmVhdGUgYSBt
YXBwaW5nDQo+PiBmb3IgdGhlIGFjcGkgZGV2aWNlIGluIFJNUlIuDQo+PiBBZGQgYSBoZWxwZXIg
dG8gYWNoaWV2ZSB0aGUgYWNwaSBuYW1lc3BhY2UgZGV2aWNlIGNhbg0KPj4gYWNjZXNzIHRoZSBS
TVJSIHJlZ2lvbi4NCj4NCj4gQXJlIHRob3NlIEFDUEkgZGV2aWNlcyB2aXNpYmxlIHRvIGtlcm5l
bD8gSWYgc28sIGFueSBkZXZpY2UgZHJpdmVyIGJvdW5kDQo+IGZvciBpdD8NCj4NCj4gQmVzdCBy
ZWdhcmRzLA0KPiBiYW9sdQ0KPg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEZlbGl4Q3Vpb2MgPEZl
bGl4Q3VpLW9jQHpoYW94aW4uY29tPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvaW9tbXUvaW50ZWwv
aW9tbXUuYyB8IDI5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgIGRyaXZlcnMv
aW9tbXUvaW9tbXUuYyAgICAgICB8ICA2ICsrKysrKw0KPj4gICBpbmNsdWRlL2xpbnV4L2lvbW11
LmggICAgICAgfCAgMyArKysNCj4+ICAgMyBmaWxlcyBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCsp
DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYyBiL2RyaXZl
cnMvaW9tbXUvaW50ZWwvaW9tbXUuYw0KPj4gaW5kZXggMjA4YTkxNjA1Mjg4Li41MWQ3YTViMThm
NDEgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMNCj4+ICsrKyBi
L2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYw0KPj4gQEAgLTQ3OTksNiArNDc5OSwyMSBAQCBz
dGF0aWMgaW50IF9faW5pdCBwbGF0Zm9ybV9vcHRpbl9mb3JjZV9pb21tdSh2b2lkKQ0KPj4gICAg
ICAgIHJldHVybiAxOw0KPj4gICB9DQo+Pg0KPj4gK3N0YXRpYyBpbnQgYWNwaV9kZXZpY2VfY3Jl
YXRlX2RpcmVjdF9tYXBwaW5ncyhzdHJ1Y3QgZGV2aWNlICpwbl9kZXYsIHN0cnVjdCBkZXZpY2Ug
KmFjcGlfZGV2aWNlKQ0KPj4gK3sNCj4+ICsgICAgIHN0cnVjdCBpb21tdV9ncm91cCAqZ3JvdXA7
DQo+PiArDQo+PiArICAgICBhY3BpX2RldmljZS0+YnVzLT5pb21tdV9vcHMgPSAmaW50ZWxfaW9t
bXVfb3BzOw0KPj4gKyAgICAgZ3JvdXAgPSBpb21tdV9ncm91cF9nZXQocG5fZGV2KTsNCj4+ICsg
ICAgIGlmICghZ3JvdXApIHsNCj4+ICsgICAgICAgICAgICAgcHJfd2FybigiQUNQSSBuYW1lIHNw
YWNlIGRldmljZXMgY3JlYXRlIGRpcmVjdCBtYXBwaW5ncyB3cm9uZyFcbiIpOw0KPj4gKyAgICAg
ICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4+ICsgICAgIH0NCj4+ICsgICAgIF9fYWNwaV9kZXZp
Y2VfY3JlYXRlX2RpcmVjdF9tYXBwaW5ncyhncm91cCwgYWNwaV9kZXZpY2UpOw0KPj4gKw0KPj4g
KyAgICAgcmV0dXJuIDA7DQo+PiArfQ0KPj4gKw0KPj4gICBzdGF0aWMgaW50IF9faW5pdCBwcm9i
ZV9hY3BpX25hbWVzcGFjZV9kZXZpY2VzKHZvaWQpDQo+PiAgIHsNCj4+ICAgICAgICBzdHJ1Y3Qg
ZG1hcl9kcmhkX3VuaXQgKmRyaGQ7DQo+PiBAQCAtNDgxMyw2ICs0ODI4LDcgQEAgc3RhdGljIGlu
dCBfX2luaXQgcHJvYmVfYWNwaV9uYW1lc3BhY2VfZGV2aWNlcyh2b2lkKQ0KPj4gICAgICAgICAg
ICAgICAgICAgICAgICBzdHJ1Y3QgYWNwaV9kZXZpY2VfcGh5c2ljYWxfbm9kZSAqcG47DQo+PiAg
ICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBpb21tdV9ncm91cCAqZ3JvdXA7DQo+PiAgICAg
ICAgICAgICAgICAgICAgICAgIHN0cnVjdCBhY3BpX2RldmljZSAqYWRldjsNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICBzdHJ1Y3QgZGV2aWNlICpwbl9kZXYgPSBOVUxMOw0KPj4NCj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgaWYgKGRldi0+YnVzICE9ICZhY3BpX2J1c190eXBlKQ0KPj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPj4gQEAgLTQ4MjMsNiArNDgz
OSw3IEBAIHN0YXRpYyBpbnQgX19pbml0IHByb2JlX2FjcGlfbmFtZXNwYWNlX2RldmljZXModm9p
ZCkNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmYWRldi0+
cGh5c2ljYWxfbm9kZV9saXN0LCBub2RlKSB7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgZ3JvdXAgPSBpb21tdV9ncm91cF9nZXQocG4tPmRldik7DQo+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgaWYgKGdyb3VwKSB7DQo+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHBuX2RldiA9IHBuLT5kZXY7DQo+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBpb21tdV9ncm91cF9wdXQoZ3JvdXApOw0KPj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfQ0KPj4gQEAgLTQ4MzEsNyArNDg0OCwxOSBAQCBzdGF0aWMgaW50
IF9faW5pdCBwcm9iZV9hY3BpX25hbWVzcGFjZV9kZXZpY2VzKHZvaWQpDQo+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcmV0ID0gaW9tbXVfcHJvYmVfZGV2aWNlKHBuLT5kZXYpOw0K
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChyZXQpDQo+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHBuX2RldiA9IHBuLT5kZXY7DQo+PiArICAgICAgICAgICAgICAgICAgICAg
fQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgIGlmICghcG5fZGV2KSB7DQo+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBkZXYtPmJ1cy0+aW9tbXVfb3BzID0gJmludGVsX2lvbW11X29w
czsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IGlvbW11X3Byb2JlX2Rl
dmljZShkZXYpOw0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHJldCkgew0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwcl9lcnIoImFjcGlfZGV2
aWNlIHByb2JlIGZhaWwhIHJldDolZFxuIiwgcmV0KTsNCj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgZ290byB1bmxvY2s7DQo+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB9DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIHVubG9jazsN
Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgfQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgIHJl
dCA9IGFjcGlfZGV2aWNlX2NyZWF0ZV9kaXJlY3RfbWFwcGluZ3MocG5fZGV2LCBkZXYpOw0KPj4g
K3VubG9jazoNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgbXV0ZXhfdW5sb2NrKCZhZGV2LT5w
aHlzaWNhbF9ub2RlX2xvY2spOw0KPj4NCj4+ICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHJl
dCkNCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2lvbW11LmMgYi9kcml2ZXJzL2lvbW11
L2lvbW11LmMNCj4+IGluZGV4IDYwOWJkMjViZjE1NC4uNGY3MTRhMmQ1ZWY3IDEwMDY0NA0KPj4g
LS0tIGEvZHJpdmVycy9pb21tdS9pb21tdS5jDQo+PiArKysgYi9kcml2ZXJzL2lvbW11L2lvbW11
LmMNCj4+IEBAIC03NzksNiArNzc5LDEyIEBAIHN0YXRpYyBib29sIGlvbW11X2lzX2F0dGFjaF9k
ZWZlcnJlZChzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4sDQo+PiAgICAgICAgcmV0dXJuIGZh
bHNlOw0KPj4gICB9DQo+Pg0KPj4gK3ZvaWQgIF9fYWNwaV9kZXZpY2VfY3JlYXRlX2RpcmVjdF9t
YXBwaW5ncyhzdHJ1Y3QgaW9tbXVfZ3JvdXAgKmdyb3VwLCBzdHJ1Y3QgZGV2aWNlICphY3BpX2Rl
dmljZSkNCj4+ICt7DQo+PiArICAgICBpb21tdV9jcmVhdGVfZGV2aWNlX2RpcmVjdF9tYXBwaW5n
cyhncm91cCwgYWNwaV9kZXZpY2UpOw0KPj4gK30NCj4+ICtFWFBPUlRfU1lNQk9MX0dQTChfX2Fj
cGlfZGV2aWNlX2NyZWF0ZV9kaXJlY3RfbWFwcGluZ3MpOw0KPj4gKw0KPj4gICAvKioNCj4+ICAg
ICogaW9tbXVfZ3JvdXBfYWRkX2RldmljZSAtIGFkZCBhIGRldmljZSB0byBhbiBpb21tdSBncm91
cA0KPj4gICAgKiBAZ3JvdXA6IHRoZSBncm91cCBpbnRvIHdoaWNoIHRvIGFkZCB0aGUgZGV2aWNl
IChyZWZlcmVuY2Ugc2hvdWxkIGJlIGhlbGQpDQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51
eC9pb21tdS5oIGIvaW5jbHVkZS9saW51eC9pb21tdS5oDQo+PiBpbmRleCBmZWUyMDllZmI3NTYu
LjliZTEzNDc3NTg4NiAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvbGludXgvaW9tbXUuaA0KPj4g
KysrIGIvaW5jbHVkZS9saW51eC9pb21tdS5oDQo+PiBAQCAtNTE0LDYgKzUxNCw5IEBAIGV4dGVy
biB2b2lkIGlvbW11X2RvbWFpbl93aW5kb3dfZGlzYWJsZShzdHJ1Y3QgaW9tbXVfZG9tYWluICpk
b21haW4sIHUzMiB3bmRfbnIpDQo+PiAgIGV4dGVybiBpbnQgcmVwb3J0X2lvbW11X2ZhdWx0KHN0
cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiwgc3RydWN0IGRldmljZSAqZGV2LA0KPj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIGlvdmEsIGludCBmbGFncyk7DQo+
Pg0KPj4gK2V4dGVybiB2b2lkIF9fYWNwaV9kZXZpY2VfY3JlYXRlX2RpcmVjdF9tYXBwaW5ncyhz
dHJ1Y3QgaW9tbXVfZ3JvdXAgKmdyb3VwLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHN0cnVjdCBkZXZpY2UgKmFjcGlfZGV2aWNlKTsNCj4+ICsNCj4+
ICAgc3RhdGljIGlubGluZSB2b2lkIGlvbW11X2ZsdXNoX3RsYl9hbGwoc3RydWN0IGlvbW11X2Rv
bWFpbiAqZG9tYWluKQ0KPj4gICB7DQo+PiAgICAgICAgaWYgKGRvbWFpbi0+b3BzLT5mbHVzaF9p
b3RsYl9hbGwpDQo+Pg0K

--_000_cfdd29a882d140e5aec2e8c3b77f4968zhaoxincom_
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
<p>hi baolu,</p>
<p><span style=3D"font-size:12pt">&gt;&nbsp;</span><span style=3D"color:rgb=
(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;Microsoft YaHe=
i&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,serif,Emoji=
Font; font-size:13.3333px">So you have a hidden device (invisible to host k=
ernel). But you need
 to</span></p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&gt;setup some iden=
tity mappings for this device, so that the firmware</span><br style=3D"colo=
r:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;Microsoft=
 YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,serif,=
EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&gt;could keep working=
, right?</span><br style=3D"color:rgb(33,33,33); font-family:&quot;Microsof=
t YaHei UI&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSu=
n,=CB=CE=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">
<br style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot=
;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,=
sans-serif,serif,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&gt;The platform desig=
ns this by putting that range in the RMRR table and</span><br style=3D"colo=
r:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;Microsoft=
 YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,serif,=
EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&gt;expecting the OS k=
ernel to setup identity mappings during boot.</span><br style=3D"color:rgb(=
33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;Microsoft YaHei=
&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,serif,EmojiF=
ont; font-size:13.3333px">
<br style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot=
;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,=
sans-serif,serif,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&gt;Do I understand it=
 right?</span></p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px"><br>
</span></p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">Yes. What you under=
stand is correct.</span></p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px"><br>
</span></p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">Best regards</span>=
</p>
<p><font color=3D"#212121" face=3D"Microsoft YaHei UI, Microsoft YaHei, =CE=
=A2=C8=ED=D1=C5=BA=DA, SimSun, =CB=CE=CC=E5, sans-serif, serif, EmojiFont">=
<span style=3D"font-size:13.3333px">Felixcui-oc</span></font></p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>=B7=A2=BC=FE=C8=CB:</b> Lu Ba=
olu &lt;baolu.lu@linux.intel.com&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> 2020=C4=EA9=D4=C22=C8=D5 10:32:36<br>
<b>=CA=D5=BC=FE=C8=CB:</b> FelixCui-oc; Joerg Roedel; iommu@lists.linux-fou=
ndation.org; linux-kernel@vger.kernel.org; David Woodhouse; Dan Carpenter; =
kbuild@lists.01.org<br>
<b>=B3=AD=CB=CD:</b> baolu.lu@linux.intel.com; CobeChen-oc; RaymondPang-oc;=
 Tony W Wang-oc; Ashok Raj<br>
<b>=D6=F7=CC=E2:</b> Re: =B4=F0=B8=B4: [PATCH v3 2/2] iommu/vt-d:Add suppor=
t for probing ACPI device in RMRR</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On 9/1/20 5:13 PM, FelixCui-oc wrote:<br>
&gt; hi&nbsp; baolu ,<br>
&gt; <br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp;These ACPI devices can be retrieved from the kernel <br>
&gt; and there is no bound device driver .<br>
<br>
So you have a hidden device (invisible to host kernel). But you need to<br>
setup some identity mappings for this device, so that the firmware<br>
could keep working, right?<br>
<br>
The platform designs this by putting that range in the RMRR table and<br>
expecting the OS kernel to setup identity mappings during boot.<br>
<br>
Do I understand it right?<br>
<br>
Best regards,<br>
baolu<br>
<br>
&gt; <br>
&gt; <br>
&gt; Best regards<br>
&gt; <br>
&gt; Felixcui-oc<br>
&gt; <br>
&gt; ----------------------------------------------------------------------=
--<br>
&gt; *=B7=A2=BC=FE=C8=CB:* Lu Baolu &lt;baolu.lu@linux.intel.com&gt;<br>
&gt; *=B7=A2=CB=CD=CA=B1=BC=E4:* 2020=C4=EA9=D4=C21=C8=D5 14:12:34<br>
&gt; *=CA=D5=BC=FE=C8=CB:* FelixCui-oc; Joerg Roedel; iommu@lists.linux-fou=
ndation.org; <br>
&gt; linux-kernel@vger.kernel.org; David Woodhouse; Dan Carpenter; <br>
&gt; kbuild@lists.01.org<br>
&gt; *=B3=AD=CB=CD:* baolu.lu@linux.intel.com; CobeChen-oc; RaymondPang-oc;=
 Tony W <br>
&gt; Wang-oc<br>
&gt; *=D6=F7=CC=E2:* Re: [PATCH v3 2/2] iommu/vt-d:Add support for probing =
ACPI <br>
&gt; device in RMRR<br>
&gt; Hi Felix,<br>
&gt; <br>
&gt; On 8/27/20 6:02 PM, FelixCuioc wrote:<br>
&gt;&gt; After acpi device in RMRR is detected,it is necessary<br>
&gt;&gt; to establish a mapping for these devices.<br>
&gt;&gt; In acpi_device_create_direct_mappings(),create a mapping<br>
&gt;&gt; for the acpi device in RMRR.<br>
&gt;&gt; Add a helper to achieve the acpi namespace device can<br>
&gt;&gt; access the RMRR region.<br>
&gt; <br>
&gt; Are those ACPI devices visible to kernel? If so, any device driver bou=
nd<br>
&gt; for it?<br>
&gt; <br>
&gt; Best regards,<br>
&gt; baolu<br>
&gt; <br>
&gt;&gt; <br>
&gt;&gt; Signed-off-by: FelixCuioc &lt;FelixCui-oc@zhaoxin.com&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp;&nbsp; drivers/iommu/intel/iommu.c | 29 &#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&gt;&nbsp;&nbsp; drivers/iommu/iommu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; |&nbsp; 6 &#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&gt;&nbsp;&nbsp; include/linux/iommu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; |&nbsp; 3 &#43;&#43;&#43;<br>
&gt;&gt;&nbsp;&nbsp; 3 files changed, 38 insertions(&#43;)<br>
&gt;&gt; <br>
&gt;&gt; diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iom=
mu.c<br>
&gt;&gt; index 208a91605288..51d7a5b18f41 100644<br>
&gt;&gt; --- a/drivers/iommu/intel/iommu.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/iommu/intel/iommu.c<br>
&gt;&gt; @@ -4799,6 &#43;4799,21 @@ static int __init platform_optin_force_=
iommu(void)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 1;<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; &#43;static int acpi_device_create_direct_mappings(struct device *=
pn_dev, struct device *acpi_device)<br>
&gt;&gt; &#43;{<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct iommu_group *group;<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; acpi_device-&gt;bus-&gt;iommu_ops =
=3D &amp;intel_iommu_ops;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; group =3D iommu_group_get(pn_dev);<b=
r>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (!group) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; pr_warn(&quot;ACPI name space devices create direct mappings wr=
ong!\n&quot;);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; __acpi_device_create_direct_mappings=
(group, acpi_device);<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt; &#43;}<br>
&gt;&gt; &#43;<br>
&gt;&gt;&nbsp;&nbsp; static int __init probe_acpi_namespace_devices(void)<b=
r>
&gt;&gt;&nbsp;&nbsp; {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dmar_drhd_unit *d=
rhd;<br>
&gt;&gt; @@ -4813,6 &#43;4828,7 @@ static int __init probe_acpi_namespace_d=
evices(void)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct acpi_device_physical_node *pn;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct iommu_group *group;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct acpi_device *adev;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device *=
pn_dev =3D NULL;<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(dev-&gt;bus !=3D &amp;acpi_bus_type)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&gt;&gt; @@ -4823,6 &#43;4839,7 @@ static int __init probe_acpi_namespace_d=
evices(void)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;physical_node_list,=
 node) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; group =3D iommu_group_get(pn-&=
gt;dev);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (group) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; pn_dev =3D pn-&gt;dev;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; iommu_group_put(group);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; continue;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; @@ -4831,7 &#43;4848,19 @@ static int __init probe_acpi_namespace_=
devices(void)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D iommu_probe_device(pn-=
&gt;dev);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; break;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pn_dev =3D pn-&gt;dev;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pn_dev) {<=
br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev-&gt;bus-&gt;iommu_ops =3D &amp;intel_i=
ommu_ops;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D iommu_probe_device(dev);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; pr_err(&quot;acpi_device probe fail! ret:%d\n&quot;, ret);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; goto unlock;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto unlock;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<b=
r>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D acpi_de=
vice_create_direct_mappings(pn_dev, dev);<br>
&gt;&gt; &#43;unlock:<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mut=
ex_unlock(&amp;adev-&gt;physical_node_lock);<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(ret)<br>
&gt;&gt; diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c<br>
&gt;&gt; index 609bd25bf154..4f714a2d5ef7 100644<br>
&gt;&gt; --- a/drivers/iommu/iommu.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/iommu/iommu.c<br>
&gt;&gt; @@ -779,6 &#43;779,12 @@ static bool iommu_is_attach_deferred(stru=
ct iommu_domain *domain,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; &#43;void&nbsp; __acpi_device_create_direct_mappings(struct iommu_=
group *group, struct device *acpi_device)<br>
&gt;&gt; &#43;{<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; iommu_create_device_direct_mappings(=
group, acpi_device);<br>
&gt;&gt; &#43;}<br>
&gt;&gt; &#43;EXPORT_SYMBOL_GPL(__acpi_device_create_direct_mappings);<br>
&gt;&gt; &#43;<br>
&gt;&gt;&nbsp;&nbsp; /**<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; * iommu_group_add_device - add a device to an io=
mmu group<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; * @group: the group into which to add the device=
 (reference should be held)<br>
&gt;&gt; diff --git a/include/linux/iommu.h b/include/linux/iommu.h<br>
&gt;&gt; index fee209efb756..9be134775886 100644<br>
&gt;&gt; --- a/include/linux/iommu.h<br>
&gt;&gt; &#43;&#43;&#43; b/include/linux/iommu.h<br>
&gt;&gt; @@ -514,6 &#43;514,9 @@ extern void iommu_domain_window_disable(st=
ruct iommu_domain *domain, u32 wnd_nr)<br>
&gt;&gt;&nbsp;&nbsp; extern int report_iommu_fault(struct iommu_domain *dom=
ain, struct device *dev,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long iova, int flags);<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; &#43;extern void __acpi_device_create_direct_mappings(struct iommu=
_group *group,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device *acpi_d=
evice);<br>
&gt;&gt; &#43;<br>
&gt;&gt;&nbsp;&nbsp; static inline void iommu_flush_tlb_all(struct iommu_do=
main *domain)<br>
&gt;&gt;&nbsp;&nbsp; {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (domain-&gt;ops-&gt;f=
lush_iotlb_all)<br>
&gt;&gt; <br>
</div>
</span></font>
</body>
</html>

--_000_cfdd29a882d140e5aec2e8c3b77f4968zhaoxincom_--

--===============9102775165268841522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============9102775165268841522==--
