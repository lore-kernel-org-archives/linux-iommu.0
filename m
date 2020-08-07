Return-Path: <SRS0=0w8+=BR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7EBC433DF
	for <iommu@archiver.kernel.org>; Fri,  7 Aug 2020 03:30:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A2032086A
	for <iommu@archiver.kernel.org>; Fri,  7 Aug 2020 03:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2032086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id ACA022538B;
	Fri,  7 Aug 2020 03:30:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yISj0Te3UPzJ; Fri,  7 Aug 2020 03:30:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 72755203ED;
	Fri,  7 Aug 2020 03:30:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 560ACC0733;
	Fri,  7 Aug 2020 03:30:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8EC7C004C
 for <iommu@lists.linux-foundation.org>; Fri,  7 Aug 2020 03:30:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 96E0E25281
 for <iommu@lists.linux-foundation.org>; Fri,  7 Aug 2020 03:30:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tznTrxdGjKpr for <iommu@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 03:30:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from ZXSHCAS2.zhaoxin.com (unknown [203.148.12.82])
 by silver.osuosl.org (Postfix) with ESMTPS id 30B11203ED
 for <iommu@lists.linux-foundation.org>; Fri,  7 Aug 2020 03:30:10 +0000 (UTC)
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 7 Aug 2020
 11:30:00 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 7 Aug 2020
 11:29:59 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::290a:f538:51e7:1416]) by
 zxbjmbx1.zhaoxin.com ([fe80::290a:f538:51e7:1416%16]) with mapi id
 15.01.1979.003; Fri, 7 Aug 2020 11:29:59 +0800
From: FelixCui-oc <FelixCui-oc@zhaoxin.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David
 Woodhouse" <dwmw2@infradead.org>
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlOWkjTog562U5aSNOiDnrZTlpI06IOetlA==?=
 =?utf-8?B?5aSNOiDnrZTlpI06IFtQQVRDSF0gaW9tbXUvdnQtZDpBZGQgc3VwcG9ydCBm?=
 =?utf-8?Q?or_ACPI_device_in_RMRR?=
Thread-Topic: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlOWkjTog562U5aSNOiDnrZTlpI06IOetlA==?=
 =?utf-8?B?5aSNOiBbUEFUQ0hdIGlvbW11L3Z0LWQ6QWRkIHN1cHBvcnQgZm9yIEFDUEkg?=
 =?utf-8?Q?device_in_RMRR?=
Thread-Index: AQHWaLTDQmhhOccXwUmx3ozYFRtFBKklJPeAgACMEUD//7NFgIAAiuzg//+YlYCAAIpwQIAADhiQgACAoQCAAJyo4IABEuiAgADMGDCAAMCAgIAAj7pAgADp+4CAAKaswA==
Date: Fri, 7 Aug 2020 03:29:59 +0000
Message-ID: <f25e4fdf592a455594d0e88fced8fb62@zhaoxin.com>
References: <20200802100735.2722-1-FelixCui-oc@zhaoxin.com>
 <73d4a1e4-f6b7-efb0-e225-2e462c838657@linux.intel.com>
 <f6759b9bb2594026b58f9a89e3ce9dc6@zhaoxin.com>
 <9f64d9b6-16e8-73ce-2186-9d8ba49c39f4@linux.intel.com>
 <44ff8f73fa1f49a183a1d8d6d9c2213c@zhaoxin.com>
 <314679b4-7653-041b-9310-73baf8117766@linux.intel.com>
 <1aea042a1b524ef88e491ca2a6d95fb7@zhaoxin.com>
 <36da53a6-00e2-1be1-91b5-d90906a6199f@linux.intel.com>
 <a5fda3f364da4e739736e7d7bc618972@zhaoxin.com>
 <a2658f9c-23fa-bb72-edba-ad61e52085cd@linux.intel.com>
 <9ba29114fcad43d58159fcc7a4d89501@zhaoxin.com>
 <1477b1dd-ac48-b49d-77f9-107bb4555b91@linux.intel.com>
 <06a05e49a2564909a2049eb8be401670@zhaoxin.com>
 <30ef5891-1368-d580-564a-1c21d90f47cd@linux.intel.com>
In-Reply-To: <30ef5891-1368-d580-564a-1c21d90f47cd@linux.intel.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.29.8.19]
MIME-Version: 1.0
Cc: CobeChen-oc <CobeChen-oc@zhaoxin.com>
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

SGkgYmFvbHUsDQoJCUkgdW5kZXJzdGFuZCB3aGF0IHlvdSBtZWFuIGlzIHRoYXQgeW91IHdhbnQg
dG8gcHV0IHRoZSBmb2xsb3dpbmcgcHJvY2Vzc2luZyBjb2RlIGluIHRoZSBhY3BpX2RldmljZV9j
cmVhdGVfZGlyZWN0X21hcHBpbmdzKCkgaW50byB0aGUgcHJvYmVfYWNwaV9uYW1lc3BhY2VfZGV2
aWNlcygpICxyaWdodD8NCgkJSWYgeW91IG1lYW4gaXQgLCBJIHRoaW5rIGl0J3MgT0suIA0KDQoJ
aWYgKHBuX2RldiA9PSBOVUxMKSB7DQoJCWFjcGlfZGV2aWNlLT5idXMtPmlvbW11X29wcyA9ICZp
bnRlbF9pb21tdV9vcHM7DQoJCXJldCA9IGlvbW11X3Byb2JlX2RldmljZShhY3BpX2RldmljZSk7
DQoJCWlmIChyZXQpIHsNCgkJCXByX2VycigiYWNwaV9kZXZpY2UgcHJvYmUgZmFpbCEgcmV0OiVk
XG4iLCByZXQpOw0KCQkJcmV0dXJuIHJldDsNCgkJfQ0KCQlyZXR1cm4gMDsNCgl9DQoNCkJlc3Qg
cmVnYXJkcw0KRmVsaXggY3VpLW9jDQoNCg0KDQoJDQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0N
CuWPkeS7tuS6ujogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4gDQrlj5HpgIHm
l7bpl7Q6IDIwMjDlubQ45pyIN+aXpSA5OjA4DQrmlLbku7bkuro6IEZlbGl4Q3VpLW9jIDxGZWxp
eEN1aS1vY0B6aGFveGluLmNvbT47IEpvZXJnIFJvZWRlbCA8am9yb0A4Ynl0ZXMub3JnPjsgaW9t
bXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IERhdmlkIFdvb2Rob3VzZSA8ZHdtdzJAaW5mcmFkZWFkLm9yZz4NCuaKhOmAgTogYmFvbHUu
bHVAbGludXguaW50ZWwuY29tOyBSYXltb25kUGFuZy1vYyA8UmF5bW9uZFBhbmctb2NAemhhb3hp
bi5jb20+OyBDb2JlQ2hlbi1vYyA8Q29iZUNoZW4tb2NAemhhb3hpbi5jb20+DQrkuLvpopg6IFJl
OiDnrZTlpI06IOetlOWkjTog562U5aSNOiDnrZTlpI06IOetlOWkjTog562U5aSNOiBbUEFUQ0hd
IGlvbW11L3Z0LWQ6QWRkIHN1cHBvcnQgZm9yIEFDUEkgZGV2aWNlIGluIFJNUlINCg0KSGkgRmVs
aXgsDQoNCk9uIDIwMjAvOC82IDE0OjUxLCBGZWxpeEN1aS1vYyB3cm90ZToNCj4gSGkgIGJhb2x1
LA0KPiAJCT5TdXJlLiBCZWZvcmUgdGhhdCwgbGV0IG1lIHN5bmMgbXkgdW5kZXJzdGFuZGluZyB3
aXRoIHlvdS4gWW91IGhhdmUgYW4gYWNwaSBuYW1lc3BhY2UgZGV2aWNlIGluIEFOREQgdGFibGUs
IGl0IGFsc28gc2hvd3MgdXAgaW4gdGhlIGRldmljZSBzY29wZSBvZiBhIFJNUlIuDQo+IAkJPkN1
cnJlbnQgY29kZSBkb2Vzbid0IGVudW1lcmF0ZSB0aGF0IGRldmljZSBmb3IgdGhlIFJNUlIsIGhl
bmNlIGlvbW11X2NyZWF0ZV9kZXZpY2VfZGlyZWN0X21hcHBpbmdzKCkgZG9lc24ndCB3b3JrIGZv
ciB0aGlzIGRldmljZS4NCj4gDQo+IAkJPkF0IHRoZSBzYW1lIHRpbWUsIHByb2JlX2FjcGlfbmFt
ZXNwYWNlX2RldmljZXMoKSBkb2Vzbid0IHdvcmsgZm9yIHRoaXMgZGV2aWNlLCBoZW5jZSB5b3Ug
d2FudCB0byBhZGQgYSBob21lLW1hZGUNCj4gCQk+YWNwaV9kZXZpY2VfY3JlYXRlX2RpcmVjdF9t
YXBwaW5ncygpIGhlbHBlci4NCj4gDQo+IAkJWW91ciB1bmRlcnN0YW5kaW5nIGlzIHJpZ2h0Lg0K
PiAJCUJ1dCB0aGVyZSBpcyBhIHByb2JsZW0gdGhhdCBldmVuIGlmIHRoZSBuYW1lc3BhY2UgZGV2
aWNlIGluIHJtcnIgaXMgZW51bWVyYXRlZCBpbiB0aGUgY29kZSwgcHJvYmVfYWNwaV9uYW1lc3Bh
Y2VfZGV2aWNlcygpIGFsc28gZG9lc24ndCB3b3JrIGZvciB0aGlzIGRldmljZS4NCj4gCQlUaGlz
IGlzIGJlY2F1c2UgdGhlIGRldiBwYXJhbWV0ZXIgb2YgdGhlIGlvbW11X2NyZWF0ZV9kZXZpY2Vf
ZGlyZWN0X21hcHBpbmdzKCkgaXMgbm90IHRoZSBuYW1lc3BhY2UgZGV2aWNlIGluIFJNUlIuDQo+
IAkJVGhlIGFjdHVhbCBwYXJhbWV0ZXIgcGFzc2VkIGluIGlzIHRoZSBuYW1lc3BhY2UgZGV2aWNl
J3MgcGh5c2ljYWwgbm9kZSBkZXZpY2UuDQo+IAkJSW4gaW9tbXVfY3JlYXRlX2RldmljZV9kaXJl
Y3RfbWFwcGluZ3MoKSwgdGhlIHBoeXNpY2FsIG5vZGUgZGV2aWNlIHBhc3NlZCBpbiBjYW5ub3Qg
bWF0Y2ggdGhlIG5hbWVzcGFjZSBkZXZpY2UgaW4gcm1yci0+ZGV2aWNlW10scmlnaHQ/DQo+IAkJ
V2UgbmVlZCBhY3BpX2RldmljZV9jcmVhdGVfZGlyZWN0X21hcHBpbmdzKCkgaGVscGVyID8NCj4g
DQo+IAkJSW4gYWRkaXRpb24sIGFkZXYtPnBoeXNpY2FsX25vZGVfbGlzdCBpcyByZWxhdGVkIHRv
IHRoZSBfX0hJRCBvZiBuYW1lc3BhY2UgZGV2aWNlIHJlcG9ydGVkIGJ5IHRoZSBiaW9zLg0KPiAJ
CUZvciBleGFtcGxlLCBpZiB0aGUgX19ISUQgcmVwb3J0ZWQgYnkgdGhlIGJpb3MgYmVsb25ncyB0
byBhY3BpX3BucF9kZXZpY2VfaWRzW10sIGFkZXYtPnBoeXNpY2FsX25vZGVfbGlzdCBoYXMgbm8g
ZGV2aWNlcy4NCj4gCQlTbyBpbiBhY3BpX2RldmljZV9jcmVhdGVfZGlyZWN0X21hcHBpbmdzKCks
IEkgYWRkZWQgdGhlIGNhc2UgdGhhdCBhZGV2LT5waHlzaWNhbF9ub2RlX2xpc3QgaXMgZW1wdHku
DQoNCkdvdCB5b3UuIFRoYW5rcyENCg0KSGF2ZSB5b3UgZXZlciB0cmllZCB0byBoYXZlIHByb2Jl
X2FjcGlfbmFtZXNwYWNlX2RldmljZXMoKSBoYW5kbGUgdGhlIGNhc2Ugb2YgZW1wdHkgYWRldi0+
cGh5c2ljYWxfbm9kZV9saXN0IGF0IHRoZSBzYW1lIHRpbWU/DQoNCkJlc3QgcmVnYXJkcywNCmJh
b2x1DQoNCj4gDQo+IA0KPiBCZXN0IHJlZ2FyZHMNCj4gRmVsaXggY3VpDQo+IA0KPiANCj4gICAN
Cj4gDQo+IC0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCj4g5Y+R5Lu25Lq6OiBMdSBCYW9sdSA8YmFv
bHUubHVAbGludXguaW50ZWwuY29tPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjDlubQ45pyINuaXpSAx
MDozNg0KPiDmlLbku7bkuro6IEZlbGl4Q3VpLW9jIDxGZWxpeEN1aS1vY0B6aGFveGluLmNvbT47
IEpvZXJnIFJvZWRlbCANCj4gPGpvcm9AOGJ5dGVzLm9yZz47IGlvbW11QGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnOyANCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgRGF2aWQgV29v
ZGhvdXNlIDxkd213MkBpbmZyYWRlYWQub3JnPg0KPiDmioTpgIE6IGJhb2x1Lmx1QGxpbnV4Lmlu
dGVsLmNvbTsgUmF5bW9uZFBhbmctb2MgDQo+IDxSYXltb25kUGFuZy1vY0B6aGFveGluLmNvbT47
IENvYmVDaGVuLW9jIDxDb2JlQ2hlbi1vY0B6aGFveGluLmNvbT4NCj4g5Li76aKYOiBSZTog562U
5aSNOiDnrZTlpI06IOetlOWkjTog562U5aSNOiDnrZTlpI06IFtQQVRDSF0gaW9tbXUvdnQtZDpB
ZGQgc3VwcG9ydCBmb3IgQUNQSSANCj4gZGV2aWNlIGluIFJNUlINCj4gDQo+IEhpIEZlbGl4LA0K
PiANCj4gT24gOC81LzIwIDM6MzcgUE0sIEZlbGl4Q3VpLW9jIHdyb3RlOg0KPj4gSGkgYmFvbHUs
DQo+PiAJCUxldCBtZSB0YWxrIGFib3V0IHdoeSBhY3BpX2RldmljZV9jcmVhdGVfZGlyZWN0X21h
cHBpbmdzKCkgaXMgbmVlZGVkIGFuZCBwbGVhc2UgdGVsbCBtZSBpZiB0aGVyZSBpcyBhbiBlcnJv
ci4NCj4gDQo+IFN1cmUuIEJlZm9yZSB0aGF0LCBsZXQgbWUgc3luYyBteSB1bmRlcnN0YW5kaW5n
IHdpdGggeW91LiBZb3UgaGF2ZSBhbiBhY3BpIG5hbWVzcGFjZSBkZXZpY2UgaW4gQU5ERCB0YWJs
ZSwgaXQgYWxzbyBzaG93cyB1cCBpbiB0aGUgZGV2aWNlIHNjb3BlIG9mIGEgUk1SUi4gQ3VycmVu
dCBjb2RlIGRvZXNuJ3QgZW51bWVyYXRlIHRoYXQgZGV2aWNlIGZvciB0aGUgUk1SUiwgaGVuY2Ug
aW9tbXVfY3JlYXRlX2RldmljZV9kaXJlY3RfbWFwcGluZ3MoKSBkb2Vzbid0IHdvcmsgZm9yIHRo
aXMgZGV2aWNlLg0KPiANCj4gQXQgdGhlIHNhbWUgdGltZSwgcHJvYmVfYWNwaV9uYW1lc3BhY2Vf
ZGV2aWNlcygpIGRvZXNuJ3Qgd29yayBmb3IgdGhpcyANCj4gZGV2aWNlLCBoZW5jZSB5b3Ugd2Fu
dCB0byBhZGQgYSBob21lLW1hZGUNCj4gYWNwaV9kZXZpY2VfY3JlYXRlX2RpcmVjdF9tYXBwaW5n
cygpIGhlbHBlci4NCj4gDQo+IERpZCBJIGdldCBpdCByaWdodD8NCj4gDQo+PiAJCUluIHRoZSBw
cm9iZV9hY3BpX25hbWVzcGFjZV9kZXZpY2VzKCkgZnVuY3Rpb24sIG9ubHkgdGhlIGRldmljZSBp
biB0aGUgYWRkZXYtPnBoeXNpY2FsX25vZGVfbGlzdCBpcyBwcm9iZWQsDQo+PiAJCWJ1dCB3ZSBu
ZWVkIHRvIGVzdGFibGlzaCBpZGVudGl0eSBtYXBwaW5nIGZvciB0aGUgbmFtZXNwYWNlIGRldmlj
ZSBpbiBSTVJSLiBUaGVzZSBhcmUgdHdvIGRpZmZlcmVudCBkZXZpY2VzLg0KPiANCj4gVGhlIG5h
bWVzcGFjZSBkZXZpY2UgaGFzIGJlZW4gcHJvYmVkIGFuZCBwdXQgaW4gb25lIGRyaGQncyBkZXZp
Y2UgbGlzdC4NCj4gSGVuY2UsIGl0IHNob3VsZCBiZSBwcm9jZXNzZWQgYnkgcHJvYmVfYWNwaV9u
YW1lc3BhY2VfZGV2aWNlcygpLiBTbyB0aGUgcXVlc3Rpb24gaXMgd2h5IHRoZXJlIGFyZSBubyBk
ZXZpY2VzIGluIGFkZGV2LT5waHlzaWNhbF9ub2RlX2xpc3Q/DQo+IA0KPj4gCQlUaGVyZWZvcmUs
IHRoZSBuYW1lc3BhY2UgZGV2aWNlIGluIFJNUlIgaXMgbm90IG1hcHBlZCBpbiBwcm9iZV9hY3Bp
X25hbWVzcGFjZV9kZXZpY2VzKCkuDQo+PiAJCWFjcGlfZGV2aWNlX2NyZWF0ZV9kaXJlY3RfbWFw
cGluZ3MoKSBpcyB0byBjcmVhdGUgZGlyZWN0IG1hcHBpbmdzIGZvciBuYW1lc3BhY2UgZGV2aWNl
cyBpbiBSTVJSLg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBiYW9sdQ0KPiANCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdApp
b21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
