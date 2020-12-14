Return-Path: <SRS0=68Au=FS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D26C4361B
	for <iommu@archiver.kernel.org>; Mon, 14 Dec 2020 14:47:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BE59225A9
	for <iommu@archiver.kernel.org>; Mon, 14 Dec 2020 14:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BE59225A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EB7B18623B;
	Mon, 14 Dec 2020 14:47:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jTVjIiVzWD4E; Mon, 14 Dec 2020 14:47:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2EE4C86234;
	Mon, 14 Dec 2020 14:47:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15BBCC0893;
	Mon, 14 Dec 2020 14:47:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32A22C013B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Dec 2020 14:47:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2CECF8623B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Dec 2020 14:47:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6A67sqsOuV3S for <iommu@lists.linux-foundation.org>;
 Mon, 14 Dec 2020 14:47:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2A53B86234
 for <iommu@lists.linux-foundation.org>; Mon, 14 Dec 2020 14:47:11 +0000 (UTC)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CvkfF3Pj2z67QF3;
 Mon, 14 Dec 2020 22:43:33 +0800 (CST)
Received: from lhreml716-chm.china.huawei.com (10.201.108.67) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 14 Dec 2020 15:47:08 +0100
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml716-chm.china.huawei.com (10.201.108.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 14 Dec 2020 14:47:08 +0000
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2106.002; Mon, 14 Dec 2020 14:47:08 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Steven Price <steven.price@arm.com>, Robin Murphy <robin.murphy@arm.com>, 
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "devel@acpica.org" <devel@acpica.org>
Subject: RE: [RFC PATCH v2 0/8] ACPI/IORT: Support for IORT RMR node
Thread-Topic: [RFC PATCH v2 0/8] ACPI/IORT: Support for IORT RMR node
Thread-Index: AQHWvm1ikW2cGVer1kuw1XacsP3g9qnwQL+AgAY7lgCAADGKgIAAE1CAgAANPCA=
Date: Mon, 14 Dec 2020 14:47:08 +0000
Message-ID: <3d0a3ae81241474f91748dde0cdd4d39@huawei.com>
References: <20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com>
 <e9837ba5-deeb-c64c-2261-d0ab82eebfac@arm.com>
 <67cb563d19114f609348dc9f8b4307e9@huawei.com>
 <8f92d0b3-360b-5d47-10a7-83d09e75d993@arm.com>
 <6dcf51b2-cad5-d377-a34c-4e64fd3acbb8@arm.com>
In-Reply-To: <6dcf51b2-cad5-d377-a34c-4e64fd3acbb8@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.200.67.216]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 Linuxarm <linuxarm@huawei.com>, "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
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
YWlsdG86c3RldmVuLnByaWNlQGFybS5jb21dDQo+IFNlbnQ6IDE0IERlY2VtYmVyIDIwMjAgMTM6
NDMNCj4gVG86IFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFybS5jb20+OyBTaGFtZWVyYWxp
IEtvbG90aHVtIFRob2RpDQo+IDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+
Ow0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWFjcGlAdmdl
ci5rZXJuZWwub3JnOw0KPiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsgZGV2ZWxA
YWNwaWNhLm9yZw0KPiBDYzogTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+OyBsb3Jlbnpv
LnBpZXJhbGlzaUBhcm0uY29tOw0KPiBqb3JvQDhieXRlcy5vcmc7IHdhbmdodWlxaWFuZyA8d2Fu
Z2h1aXFpYW5nQGh1YXdlaS5jb20+OyBHdW9oYW5qdW4NCj4gKEhhbmp1biBHdW8pIDxndW9oYW5q
dW5AaHVhd2VpLmNvbT47IEpvbmF0aGFuIENhbWVyb24NCj4gPGpvbmF0aGFuLmNhbWVyb25AaHVh
d2VpLmNvbT47IFNhbWkuTXVqYXdhckBhcm0uY29tDQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENI
IHYyIDAvOF0gQUNQSS9JT1JUOiBTdXBwb3J0IGZvciBJT1JUIFJNUiBub2RlDQo+IA0KPiBPbiAx
NC8xMi8yMDIwIDEyOjMzLCBSb2JpbiBNdXJwaHkgd3JvdGU6DQo+ID4gT24gMjAyMC0xMi0xNCAx
MDo1NSwgU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSB3cm90ZToNCj4gPj4gSGkgU3RldmUsDQo+
ID4+DQo+ID4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+Pj4gRnJvbTogU3RldmVu
IFByaWNlIFttYWlsdG86c3RldmVuLnByaWNlQGFybS5jb21dDQo+ID4+PiBTZW50OiAxMCBEZWNl
bWJlciAyMDIwIDEwOjI2DQo+ID4+PiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaQ0KPiA8
c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPjsNCj4gPj4+IGxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7DQo+
ID4+PiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsgZGV2ZWxAYWNwaWNhLm9yZw0K
PiA+Pj4gQ2M6IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPjsgbG9yZW56by5waWVyYWxp
c2lAYXJtLmNvbTsNCj4gPj4+IGpvcm9AOGJ5dGVzLm9yZzsgcm9iaW4ubXVycGh5QGFybS5jb207
IHdhbmdodWlxaWFuZw0KPiA+Pj4gPHdhbmdodWlxaWFuZ0BodWF3ZWkuY29tPjsgR3VvaGFuanVu
IChIYW5qdW4gR3VvKQ0KPiA+Pj4gPGd1b2hhbmp1bkBodWF3ZWkuY29tPjsgSm9uYXRoYW4gQ2Ft
ZXJvbg0KPiA+Pj4gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbT47IFNhbWkuTXVqYXdhckBh
cm0uY29tDQo+ID4+PiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2MiAwLzhdIEFDUEkvSU9SVDog
U3VwcG9ydCBmb3IgSU9SVCBSTVIgbm9kZQ0KPiA+Pj4NCj4gPj4+IE9uIDE5LzExLzIwMjAgMTI6
MTEsIFNoYW1lZXIgS29sb3RodW0gd3JvdGU6DQo+ID4+Pj4gUkZDIHYxIC0tPiB2MjoNCj4gPj4+
PiDCoCDCoC0gQWRkZWQgYSBnZW5lcmljIGludGVyZmFjZSBmb3IgSU9NTVUgZHJpdmVycyB0byBy
ZXRyaWV2ZSBhbGwgdGhlDQo+ID4+Pj4gwqAgwqAgwqBSTVIgaW5mbyBhc3NvY2lhdGVkIHdpdGgg
YSBnaXZlbiBJT01NVS4NCj4gPj4+PiDCoCDCoC0gU01NVXYzIGRyaXZlciBnZXRzIHRoZSBSTVIg
bGlzdCBkdXJpbmcgcHJvYmUoKSBhbmQgaW5zdGFsbHMNCj4gPj4+PiDCoCDCoMKgIGJ5cGFzcyBT
VEVzIGZvciBhbGwgdGhlIFNJRHMgaW4gdGhlIFJNUiBsaXN0LiBUaGlzIGlzIHRvIGtlZXANCj4g
Pj4+PiDCoMKgIMKgIHRoZSBvbmdvaW5nIHRyYWZmaWMgYWxpdmUoaWYgYW55KSBkdXJpbmcgU01N
VXYzIHJlc2V0LiBUaGlzIGlzDQo+ID4+Pj4gwqDCoMKgwqAgYmFzZWQgb24gdGhlIHN1Z2dlc3Rp
b25zIHJlY2VpdmVkIGZvciB2MSB0byB0YWtlIGNhcmUgb2YgdGhlDQo+ID4+Pj4gwqDCoMKgwqAg
RUZJIGZyYW1lYnVmZmVyIHVzZSBjYXNlLiBPbmx5IHNhbml0eSB0ZXN0ZWQgZm9yIG5vdy4NCj4g
Pj4+DQo+ID4+PiBIaSBTaGFtZWVyLA0KPiA+Pj4NCj4gPj4+IFNvcnJ5IGZvciBub3QgbG9va2lu
ZyBhdCB0aGlzIGJlZm9yZS4NCj4gPj4+DQo+ID4+PiBEbyB5b3UgaGF2ZSBhbnkgcGxhbnMgdG8g
aW1wbGVtZW50IHN1cHBvcnQgaW4gdGhlIFNNTVV2MiBkcml2ZXI/IFRoZQ0KPiA+Pj4gcGxhdGZv
cm0gSSd2ZSBiZWVuIHRlc3RpbmcgdGhlIEVGSSBmcmFtZWJ1ZmZlciBzdXBwb3J0IG9uIGhhcyB0
aGUNCj4gPj4+IGRpc3BsYXkgY29udHJvbGxlciBiZWhpbmQgU01NVXYyLCBzbyBhcyBpdCBzdGFu
ZHMgdGhpcyBzZXJpZXMgZG9lc24ndA0KPiA+Pj4gd29yay4gSSBkaWQgaGFjayBzb21ldGhpbmcg
dXAgZm9yIFNNTVV2MiBzbyBJIHdhcyBhYmxlIHRvIHRlc3QgdGhlIGZpcnN0DQo+ID4+PiA0IHBh
dGNoZXMuDQo+ID4+DQo+ID4+IFRoYW5rcyBmb3IgdGFraW5nIGEgbG9vay4gU3VyZSwgSSBjYW4g
bG9vayBpbnRvIGFkZGluZyB0aGUgc3VwcG9ydCBmb3INCj4gPj4gU01NVXYyLg0KPiANCj4gR3Jl
YXQsIHRoYW5rcyENCj4gDQo+ID4+Pg0KPiA+Pj4+IMKgIMKgLSBEdXJpbmcgdGhlIHByb2JlL2F0
dGFjaCBkZXZpY2UsIFNNTVV2MyBkcml2ZXIgcmVzZXJ2ZXMgYW55DQo+ID4+Pj4gwqAgwqAgwqBS
TVIgcmVnaW9uIGFzc29jaWF0ZWQgd2l0aCB0aGUgZGV2aWNlIHN1Y2ggdGhhdCB0aGVyZSBpcyBh
IHVuaXR5DQo+ID4+Pj4gwqAgwqAgwqBtYXBwaW5nIGZvciB0aGVtIGluIFNNTVUuDQo+ID4+Pg0K
PiA+Pj4gRm9yIHRoZSBFRkkgZnJhbWVidWZmZXIgdXNlIGNhc2UgdGhlcmUgaXMgbm8gZGV2aWNl
IHRvIGF0dGFjaCBzbyBJDQo+ID4+PiBiZWxpZXZlIHdlIGFyZSBsZWZ0IHdpdGgganVzdCB0aGUg
c3RyZWFtIElEIGluIGJ5cGFzcyBtb2RlIC0gd2hpY2ggaXMNCj4gPj4+IGRlZmluaXRlbHkgYW4g
aW1wcm92ZW1lbnQgKHRoZSBkaXNwbGF5IHdvcmtzISkNCj4gPj4NCj4gPj4gQ29vbC4gVGhhdOKA
mXMgZ29vZCB0byBrbm93Lg0KPiA+Pg0KPiA+PiDCoCBidXQgbm90IGFjdHVhbGx5IGEgdW5pdHkN
Cj4gPj4+IG1hcHBpbmcgb2YgdGhlIFJNUiByYW5nZS4gSSdtIG5vdCBzdXJlIHdoZXRoZXIgaXQn
cyB3b3J0aCBmaXhpbmcgdGhpcyBvcg0KPiA+Pj4gbm90LCBidXQgSSBqdXN0IHdhbnRlZCB0byBw
b2ludCBvdXQgdGhlcmUncyBzdGlsbCBhIG5lZWQgZm9yIGEgZHJpdmVyDQo+ID4+PiBmb3IgdGhl
IGRldmljZSBiZWZvcmUgdGhlIGJ5cGFzcyBtb2RlIGlzIHJlcGxhY2VkIHdpdGggdGhlIHVuaXR5
DQo+ID4+PiBtYXBwaW5nLg0KPiA+Pg0KPiA+PiBJIGFtIG5vdCBzdXJlIGVpdGhlci4gTXkgaWRl
YSB3YXMgd2Ugd2lsbCBoYXZlIGJ5cGFzcyBTVEUgc2V0dXAgZm9yDQo+ID4+IGFsbCBkZXZpY2Vz
DQo+ID4+IHdpdGggUk1SIGluaXRpYWxseSBhbmQgd2hlbiB0aGUgY29ycmVzcG9uZGluZyBkcml2
ZXIgdGFrZXMgb3ZlcihpZg0KPiA+PiB0aGF0IGhhcHBlbnMpDQo+ID4+IHdlIHdpbGwgaGF2ZSB0
aGUgdW5pdHkgbWFwcGluZyBzZXR1cCBwcm9wZXJseSBmb3IgdGhlIFJNUiByZWdpb25zLiBBbmQN
Cj4gPj4gZm9yIGNhc2VzDQo+ID4+IGxpa2UgdGhlIGFib3ZlLCBpdCB3aWxsIHJlbWFpbiBpbiB0
aGUgYnlwYXNzIG1vZGUuDQo+ID4+DQo+ID4+IERvIHlvdSBzZWUgYW55IHByb2JsZW0oc2VjdXJp
dHk/KSBpZiB0aGUgZGV2IHN0cmVhbXMgcmVtYWluIGluIGJ5cGFzcw0KPiA+PiBtb2RlIGZvcg0K
PiA+PiB0aGlzIGRldj8gT3IgaXMgaXQgcG9zc2libGUgdG8gaGF2ZSBhIHN0dWIgZHJpdmVyIGZv
ciB0aGlzIGRldiwgc28NCj4gPj4gdGhhdCB3ZSB3aWxsIGhhdmUNCj4gPj4gdGhlIHByb2JlL2F0
dGFjaCBpbnZva2VkIGFuZCBldmVyeXRoaW5nIHdpbGwgZmFsbCBpbiBwbGFjZT8NCj4gPg0KPiA+
IFRoZSBkb3duc2lkZSBpcyB0aGF0IGlmIGEgZHJpdmVyIG5ldmVyIGJpbmRzIHRvIHRoYXQgZGV2
aWNlLCBpdCByZW1haW5zDQo+ID4gYnlwYXNzZWQuIElmIHNvbWUgb3RoZXIgZXh0ZXJuYWxseS1j
b250cm9sbGVkIG1hbGljaW91cyBkZXZpY2UgY291bGQNCj4gPiBtYW5hZ2UgdG8gc3Bvb2YgdGhh
dCBkZXZpY2UncyByZXF1ZXN0ZXIgSUQsIHRoYXQgY291bGQgcG90ZW50aWFsbHkgYmUNCj4gPiBl
eHBsb2l0ZWQuDQo+ID4NCj4gPj4gVEJILCBJIGhhdmVuJ3QgbG9va2VkIGludG8gY3JlYXRpbmcg
YSB0ZW1wIGRvbWFpbiBmb3IgdGhlc2UgdHlwZXMgb2YNCj4gPj4gdGhlIGRldmljZXMNCj4gPj4g
YW5kIGFsc28gbm90IHN1cmUgaG93IHdlIGJlbmVmaXQgZnJvbSB0aGF0IGNvbXBhcmVkIHRvIHRo
ZSBTVEUgYnlwYXNzDQo+ID4+IG1vZGUuDQo+ID4NCj4gPiBUaGF0IHNhaWQsIHNldHRpbmcgdXAg
dGVtcG9yYXJ5IHRyYW5zbGF0aW9uIGNvbnRleHRzIHRoYXQgZW5zdXJlIGFueQ0KPiA+IGFjY2Vz
cyBjYW4gKm9ubHkqIGJlIHRvIFJNUiByZWdpb25zIHVudGlsIGEgZHJpdmVyIHRha2VzIG92ZXIg
aXMgYW4NCj4gPiBhd2Z1bCBsb3QgbW9yZSB3b3JrLiBJJ20gaW5jbGluZWQgdG8gYmUgcHJhZ21h
dGljIGhlcmUgYW5kIHNheSB3ZSBzaG91bGQNCj4gPiBnZXQgdGhpbmdzIHdvcmtpbmcgYXQgYWxs
IHdpdGggdGhlIHNpbXBsZSBieXBhc3MgU1RFL1MyQ1IgbWV0aG9kLCB0aGVuDQo+ID4gbG9vayBh
dCBhZGRpbmcgdGhlIGhpZ2hlci1zZWN1cml0eSBlZmZvcnQgb24gdG9wLg0KPiA+DQo+ID4gUmln
aHQgbm93IHN5c3RlbXMgdGhhdCBuZWVkIHRoaXMgYXJlIGVpdGhlciBicm9rZW4gKGJ1dCBlZmZl
Y3RpdmVseQ0KPiA+IHNlY3VyZSkgb3IgdXNpbmcgZGVmYXVsdCBieXBhc3Mgd2l0aCBTTU1VdjIu
IFBlb3BsZSB3aG8gcHJlZmVyIHRvDQo+ID4gbWFpbnRhaW4gc2VjdXJpdHkgb3ZlciBmdW5jdGlv
bmFsaXR5IGluIHRoZSBpbnRlcmltIGNhbiBtYWludGFpbiB0aGF0DQo+ID4gc3RhdHVzIHF1byBi
eSBzaW1wbHkgY29udGludWluZyB0byBub3QgZGVzY3JpYmUgYW55IFJNUnMuDQo+IA0KPiBJIGFn
cmVlIHdpdGggUm9iaW4sIGxldCdzIGdldCB0aGlzIHdvcmtpbmcgd2l0aCB0aGUgYnlwYXNzIG1v
ZGUgKHVudGlsDQo+IHRoZSBkZXZpY2UgYmluZHMpIGxpa2UgeW91J3ZlIGN1cnJlbnRseSBnb3Qu
IEl0J3MgbXVjaCBiZXR0ZXIgdGhhbiB3aGF0DQo+IHdlIGhhdmUgb3RoZXJ3aXNlLiBUaGVuIG9u
Y2UgdGhhdCBpcyBtZXJnZWQgd2UgY2FuIGxvb2sgYXQgdGhlIHRlbXBvcmFyeQ0KPiB0cmFuc2xh
dGlvbiBjb250ZXh0IG9yIHN0dWIgZHJpdmVyLiBUaGUgdGVtcG9yYXJ5IHRyYW5zbGF0aW9uIGNv
bnRleHQNCj4gd291bGQgYmUgJ25lYXRlc3QnLCBidXQgSSdtIG9ubHkgYXdhcmUgb2YgdGhlIEVG
SSBmcmFtZWJ1ZmZlciB1c2UgY2FzZQ0KPiBhbmQgZm9yIHRoYXQgaXQgbWlnaHQgYmUgcG9zc2li
bGUgdG8gZG8gc29tZXRoaW5nIHNpbXBsZXIgLSBpZiBpbmRlZWQNCj4gYW55dGhpbmcgaXMgbmVl
ZGVkIGF0IGFsbC4gSSdtIG5vdCBzdXJlIGhvdyBtdWNoIHdlIG5lZWQgdG8gYmUgd29ycmllZA0K
PiBhYm91dCBtYWxpY2lvdXMgZGV2aWNlcyBzcG9vZmluZyByZXF1ZXN0ZXIgSURzLg0KDQpQZXJm
ZWN0LiBJIHdpbGwga2VlcCB0aGUgU1RFIGJ5cGFzcyBhbmQgcmVzcGluIHRoZSBzZXJpZXMgb25j
ZSB0aGUgdXBkYXRlDQp0byB0aGUgSU9SVCByZXYgRSBpcyBtYWRlIHB1YmxpYyhob3BlIHRoYXQg
d2lsbCBoYXBwZW4gc29vbikuIEluIHRoZQ0KbWVhbnRpbWUsIGFwcHJlY2lhdGUgYW55IGZlZWRi
YWNrIG9uIHRoZSByZXN0IG9mIHRoZSBwYXRjaGVzIGluIHRoaXMgc2VyaWVzLg0KDQpUaGFua3Ms
DQpTaGFtZWVyDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
