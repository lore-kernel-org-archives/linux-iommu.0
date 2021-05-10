Return-Path: <SRS0=b4g5=KF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3C7C433ED
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 08:40:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF78160FE7
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 08:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF78160FE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E6C483AE8;
	Mon, 10 May 2021 08:40:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rFwreDsv4UWn; Mon, 10 May 2021 08:40:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2213883B7C;
	Mon, 10 May 2021 08:40:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED856C000D;
	Mon, 10 May 2021 08:40:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7DB85C0001
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 08:40:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D388D83B7C
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 08:40:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lhpkv4Ss_VY1 for <iommu@lists.linux-foundation.org>;
 Mon, 10 May 2021 08:40:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EA51083AC4
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 08:40:20 +0000 (UTC)
Received: from dggeml710-chm.china.huawei.com (unknown [172.30.72.54])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FdvZN6yGFzYgV4;
 Mon, 10 May 2021 16:37:48 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggeml710-chm.china.huawei.com (10.3.17.140) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 10 May 2021 16:40:15 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 10 May 2021 16:40:14 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2176.012; Mon, 10 May 2021 09:40:12 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Steven Price <steven.price@arm.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "jon@solid-run.com" <jon@solid-run.com>
Subject: RE: [PATCH v3 09/10] iommu/arm-smmu: Get associated RMR info and
 install bypass SMR
Thread-Topic: [PATCH v3 09/10] iommu/arm-smmu: Get associated RMR info and
 install bypass SMR
Thread-Index: AQHXNcecx10jV8gxj06XfhrBLgBPDKrWmXeAgAXoLrA=
Date: Mon, 10 May 2021 08:40:12 +0000
Message-ID: <df2b37e8fb6a4704a2eb8b5241a45231@huawei.com>
References: <20210420082751.1829-1-shameerali.kolothum.thodi@huawei.com>
 <20210420082751.1829-10-shameerali.kolothum.thodi@huawei.com>
 <501cd986-7f9c-9aa7-b4e9-f2ef98fb7a95@arm.com>
In-Reply-To: <501cd986-7f9c-9aa7-b4e9-f2ef98fb7a95@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.94.9]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: Linuxarm <linuxarm@huawei.com>,
 "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 wanghuiqiang <wanghuiqiang@huawei.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RldmVuIFByaWNlIFtt
YWlsdG86c3RldmVuLnByaWNlQGFybS5jb21dDQo+IFNlbnQ6IDA2IE1heSAyMDIxIDE2OjE3DQo+
IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpIDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2Rp
QGh1YXdlaS5jb20+Ow0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxp
bnV4LWFjcGlAdmdlci5rZXJuZWwub3JnOw0KPiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZw0KPiBDYzogTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+OyBsb3JlbnpvLnBpZXJh
bGlzaUBhcm0uY29tOw0KPiBqb3JvQDhieXRlcy5vcmc7IHJvYmluLm11cnBoeUBhcm0uY29tOyB3
YW5naHVpcWlhbmcNCj4gPHdhbmdodWlxaWFuZ0BodWF3ZWkuY29tPjsgR3VvaGFuanVuIChIYW5q
dW4gR3VvKQ0KPiA8Z3VvaGFuanVuQGh1YXdlaS5jb20+OyBTYW1pLk11amF3YXJAYXJtLmNvbTsg
am9uQHNvbGlkLXJ1bi5jb207DQo+IGVyaWMuYXVnZXJAcmVkaGF0LmNvbQ0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHYzIDA5LzEwXSBpb21tdS9hcm0tc21tdTogR2V0IGFzc29jaWF0ZWQgUk1SIGlu
Zm8NCj4gYW5kIGluc3RhbGwgYnlwYXNzIFNNUg0KPiANCj4gT24gMjAvMDQvMjAyMSAwOToyNywg
U2hhbWVlciBLb2xvdGh1bSB3cm90ZToNCj4gPiBGcm9tOiBKb24gTmV0dGxldG9uIDxqb25Ac29s
aWQtcnVuLmNvbT4NCj4gPg0KPiA+IENoZWNrIGlmIHRoZXJlIGlzIGFueSBSTVIgaW5mbyBhc3Nv
Y2lhdGVkwqB3aXRoIHRoZSBkZXZpY2VzIGJlaGluZA0KPiA+IHRoZSBTTU1VIGFuZCBpZiBhbnks
IGluc3RhbGwgYnlwYXNzIFNNUnMgZm9yIHRoZW0uIFRoaXMgaXMgdG8NCj4gPiBrZWVwIGFueSBv
bmdvaW5nIHRyYWZmaWMgYXNzb2NpYXRlZCB3aXRoIHRoZXNlIGRldmljZXMgYWxpdmUNCj4gPiB3
aGVuIHdlIGVuYWJsZS9yZXNldCBTTU1VIGR1cmluZyBwcm9iZSgpLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogSm9uIE5ldHRsZXRvbiA8am9uQHNvbGlkLXJ1bi5jb20+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogU2hhbWVlciBLb2xvdGh1bQ0KPiA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3
ZWkuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUvYXJtLXNt
bXUuYyB8IDQyDQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgZHJpdmVycy9p
b21tdS9hcm0vYXJtLXNtbXUvYXJtLXNtbXUuaCB8ICAyICsrDQo+ID4gICAyIGZpbGVzIGNoYW5n
ZWQsIDQ0IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11
L2FybS9hcm0tc21tdS9hcm0tc21tdS5jDQo+IGIvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUv
YXJtLXNtbXUuYw0KPiA+IGluZGV4IGQ4YzZiZmRlNmE2MS4uNGQyZjkxNjI2ZDg3IDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11L2FybS1zbW11LmMNCj4gPiArKysg
Yi9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS9hcm0tc21tdS5jDQo+ID4gQEAgLTIxMDIsNiAr
MjEwMiw0MyBAQCBlcnJfcmVzZXRfcGxhdGZvcm1fb3BzOiBfX21heWJlX3VudXNlZDsNCj4gPiAg
IAlyZXR1cm4gZXJyOw0KPiA+ICAgfQ0KPiA+DQo+ID4gK3N0YXRpYyB2b2lkIGFybV9zbW11X3Jt
cl9pbnN0YWxsX2J5cGFzc19zbXIoc3RydWN0IGFybV9zbW11X2RldmljZQ0KPiAqc21tdSkNCj4g
PiArew0KPiA+ICsJc3RydWN0IGlvbW11X3JtciAqZTsNCj4gPiArCWludCBpLCBjbnQgPSAwOw0K
PiA+ICsJdTMyIHNtcjsNCj4gPiArDQo+ID4gKwlmb3IgKGkgPSAwOyBpIDwgc21tdS0+bnVtX21h
cHBpbmdfZ3JvdXBzOyBpKyspIHsNCj4gPiArCQlzbXIgPSBhcm1fc21tdV9ncjBfcmVhZChzbW11
LCBBUk1fU01NVV9HUjBfU01SKGkpKTsNCj4gPiArCQlpZiAoIUZJRUxEX0dFVChBUk1fU01NVV9T
TVJfVkFMSUQsIHNtcikpDQo+ID4gKwkJCWNvbnRpbnVlOw0KPiA+ICsNCj4gPiArCQlsaXN0X2Zv
cl9lYWNoX2VudHJ5KGUsICZzbW11LT5ybXJfbGlzdCwgbGlzdCkgew0KPiA+ICsJCQlpZiAoRklF
TERfR0VUKEFSTV9TTU1VX1NNUl9JRCwgc21yKSAhPSBlLT5zaWQpDQo+ID4gKwkJCQljb250aW51
ZTsNCj4gPiArDQo+ID4gKwkJCXNtbXUtPnNtcnNbaV0uaWQgPSBGSUVMRF9HRVQoQVJNX1NNTVVf
U01SX0lELCBzbXIpOw0KPiA+ICsJCQlzbW11LT5zbXJzW2ldLm1hc2sgPSBGSUVMRF9HRVQoQVJN
X1NNTVVfU01SX01BU0ssDQo+IHNtcik7DQo+ID4gKwkJCXNtbXUtPnNtcnNbaV0udmFsaWQgPSB0
cnVlOw0KPiA+ICsNCj4gPiArCQkJc21tdS0+czJjcnNbaV0udHlwZSA9IFMyQ1JfVFlQRV9CWVBB
U1M7DQo+ID4gKwkJCXNtbXUtPnMyY3JzW2ldLnByaXZjZmcgPSBTMkNSX1BSSVZDRkdfREVGQVVM
VDsNCj4gPiArCQkJc21tdS0+czJjcnNbaV0uY2JuZHggPSAweGZmOw0KPiA+ICsNCj4gPiArCQkJ
Y250Kys7DQo+ID4gKwkJfQ0KPiA+ICsJfQ0KPiANCj4gSWYgSSB1bmRlcnN0YW5kIHRoaXMgY29y
cmVjdGx5IC0gdGhpcyBpcyBsb29raW5nIGF0IHRoZSBjdXJyZW50DQo+IChoYXJkd2FyZSkgY29u
ZmlndXJhdGlvbiBvZiB0aGUgU01NVSBhbmQgYXR0ZW1wdGluZyB0byBwcmVzZXJ2ZSBhbnkNCj4g
YnlwYXNzIFNNUnMuIEhvd2V2ZXIgZnJvbSB3aGF0IEkgY2FuIHRlbGwgaXQgc3VmZmVycyBmcm9t
IHRoZSBmb2xsb3dpbmcNCj4gdHdvIHByb2JsZW1zOg0KPiANCj4gICAoYSkgT25seSB0aGUgSUQg
b2YgdGhlIFNNUiBpcyBiZWluZyBjaGVja2VkLCBub3QgdGhlIE1BU0suIFNvIGlmIHRoZQ0KPiBm
aXJtd2FyZSBoYXMgc2V0dXAgYW4gU01SIG1hdGNoaW5nIGEgbnVtYmVyIG9mIHN0cmVhbXMgdGhp
cyB3aWxsIGJyZWFrLg0KPiANCj4gICAoYikgVGhlIFNNTVUgbWlnaHQgbm90IGJlIGVuYWJsZWQg
YXQgYWxsIChDTElFTlRQRD09MSkgb3IgYnlwYXNzDQo+IGVuYWJsZWQgZm9yIHVubWF0Y2hlZCBz
dHJlYW1zIChVU0ZDRkc9PTApLg0KPiANCj4gQ2VydGFpbmx5IGluIG15IHRlc3Qgc2V0dXAgY2Fz
ZSAoYikgYXBwbGllcyBhbmQgc28gdGhpcyBkb2Vzbid0IHdvcmsuDQo+IFBlcmhhcHMgc29tZXRo
aW5nIGxpa2UgdGhlIGJlbG93IHdvdWxkIHdvcmsgYmV0dGVyPyAoSXQgd29ya3MgaW4gdGhlDQo+
IGNhc2Ugb2YgdGhlIFNNTVUgbm90IGVuYWJsZWQgLSBJJ3ZlIG5vdCB0ZXN0ZWQgY2FzZSAoYSkp
Lg0KDQpUaGFua3MgU3RldmUgZm9yIHRha2luZyBhIGxvb2sgYW5kIHRlc3RpbmcgdGhpcyBvbiBT
TU1VdjIuIE15IGtub3dsZWRnZQ0Kb24gU01NVXYyIGlzIGxpbWl0ZWQgYW4gZG9uJ3QgaGF2ZSBh
IHNldHVwIHRvIHZlcmlmeSB0aGlzLiBBZnRlciByZWFkaW5nDQp0aGUgY29kZSwgYWdyZWUgdGhh
dCB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiBhZGRyZXNzZXMgdGhlIGhhcmR3YXJlDQpjb25m
aWd1cmF0aW9uIG9ubHkgYW5kIGJyZWFrcyBhbGwgdGhlIHNjZW5hcmlvcyBleHBsYWluZWQgYWJv
dmUuDQoNCkkgd2lsbCBpbmNsdWRlIHRoZSBiZWxvdyBzbmlwcGV0IGluIG5leHQgcmVzcGluIGlm
IHRoYXQgd29ya3MuDQoNCkhpIEpvbiwNCg0KQ291bGQgeW91IHBsZWFzZSB0YWtlIGEgbG9vayBh
bmQgc2VlIHRoZSBiZWxvdyBjaGFuZ2VzIHdvcmtzIGZvcg0KeW91IHRvbz8NCg0KVGhhbmtzLA0K
U2hhbWVlcg0KDQo+IC0tLS04PC0tLS0NCj4gc3RhdGljIHZvaWQgYXJtX3NtbXVfcm1yX2luc3Rh
bGxfYnlwYXNzX3NtcihzdHJ1Y3QgYXJtX3NtbXVfZGV2aWNlDQo+ICpzbW11KQ0KPiB7DQo+IAlz
dHJ1Y3QgaW9tbXVfcm1yICplOw0KPiAJaW50IGksIGNudCA9IDA7DQo+IAl1MzIgc21yOw0KPiAJ
dTMyIHJlZzsNCj4gDQo+IAlyZWcgPSBhcm1fc21tdV9ncjBfcmVhZChzbW11LCBBUk1fU01NVV9H
UjBfc0NSMCk7DQo+IA0KPiAJaWYgKChyZWcgJiBBUk1fU01NVV9zQ1IwX1VTRkNGRykgJiYgIShy
ZWcgJg0KPiBBUk1fU01NVV9zQ1IwX0NMSUVOVFBEKSkgew0KPiAJCS8qDQo+IAkJICogU01NVSBp
cyBhbHJlYWR5IGVuYWJsZWQgYW5kIGRpc2FsbG93aW5nIGJ5cGFzcywgc28gcHJlc2VydmUNCj4g
CQkgKiB0aGUgZXhpc3RpbmcgU01Scw0KPiAJCSAqLw0KPiAJCWZvciAoaSA9IDA7IGkgPCBzbW11
LT5udW1fbWFwcGluZ19ncm91cHM7IGkrKykgew0KPiAJCQlzbXIgPSBhcm1fc21tdV9ncjBfcmVh
ZChzbW11LCBBUk1fU01NVV9HUjBfU01SKGkpKTsNCj4gCQkJaWYgKCFGSUVMRF9HRVQoQVJNX1NN
TVVfU01SX1ZBTElELCBzbXIpKQ0KPiAJCQkJY29udGludWU7DQo+IAkJCXNtbXUtPnNtcnNbaV0u
aWQgPSBGSUVMRF9HRVQoQVJNX1NNTVVfU01SX0lELCBzbXIpOw0KPiAJCQlzbW11LT5zbXJzW2ld
Lm1hc2sgPSBGSUVMRF9HRVQoQVJNX1NNTVVfU01SX01BU0ssDQo+IHNtcik7DQo+IAkJCXNtbXUt
PnNtcnNbaV0udmFsaWQgPSB0cnVlOw0KPiAJCX0NCj4gCX0NCj4gDQo+IAlsaXN0X2Zvcl9lYWNo
X2VudHJ5KGUsICZzbW11LT5ybXJfbGlzdCwgbGlzdCkgew0KPiAJCXUzMiBzaWQgPSBlLT5zaWQ7
DQo+IA0KPiAJCWkgPSBhcm1fc21tdV9maW5kX3NtZShzbW11LCBzaWQsIH4wKTsNCj4gCQlpZiAo
aSA8IDApDQo+IAkJCWNvbnRpbnVlOw0KPiAJCWlmIChzbW11LT5zMmNyc1tpXS5jb3VudCA9PSAw
KSB7DQo+IAkJCXNtbXUtPnNtcnNbaV0uaWQgPSBzaWQ7DQo+IAkJCXNtbXUtPnNtcnNbaV0ubWFz
ayA9IH4wOw0KPiAJCQlzbW11LT5zbXJzW2ldLnZhbGlkID0gdHJ1ZTsNCj4gCQl9DQo+IAkJc21t
dS0+czJjcnNbaV0uY291bnQrKzsNCj4gCQlzbW11LT5zMmNyc1tpXS50eXBlID0gUzJDUl9UWVBF
X0JZUEFTUzsNCj4gCQlzbW11LT5zMmNyc1tpXS5wcml2Y2ZnID0gUzJDUl9QUklWQ0ZHX0RFRkFV
TFQ7DQo+IAkJc21tdS0+czJjcnNbaV0uY2JuZHggPSAweGZmOw0KPiANCj4gCQljbnQrKzsNCj4g
CX0NCj4gDQo+IAlpZiAoKHJlZyAmIEFSTV9TTU1VX3NDUjBfVVNGQ0ZHKSAmJiAhKHJlZyAmDQo+
IEFSTV9TTU1VX3NDUjBfQ0xJRU5UUEQpKSB7DQo+IAkJLyogUmVtb3ZlIHRoZSB2YWxpZCBiaXQg
Zm9yIHVudXNlZCBTTVJzICovDQo+IAkJZm9yIChpID0gMDsgaSA8IHNtbXUtPm51bV9tYXBwaW5n
X2dyb3VwczsgaSsrKSB7DQo+IAkJCWlmIChzbW11LT5zMmNyc1tpXS5jb3VudCA9PSAwKQ0KPiAJ
CQkJc21tdS0+c21yc1tpXS52YWxpZCA9IGZhbHNlOw0KPiAJCX0NCj4gCX0NCj4gDQo+IAlkZXZf
bm90aWNlKHNtbXUtPmRldiwgIlx0cHJlc2VydmVkICVkIGJvb3QgbWFwcGluZyVzXG4iLCBjbnQs
DQo+IAkJICAgY250ID09IDEgPyAiIiA6ICJzIik7DQo+IH0NCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby9pb21tdQ==
