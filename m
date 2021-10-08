Return-Path: <SRS0=lDjG=O4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C8EC4332F
	for <iommu@archiver.kernel.org>; Fri,  8 Oct 2021 06:34:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDE7861053
	for <iommu@archiver.kernel.org>; Fri,  8 Oct 2021 06:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BDE7861053
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8AC6283434;
	Fri,  8 Oct 2021 06:34:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m5S-0wK9D6oO; Fri,  8 Oct 2021 06:34:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4F1E883404;
	Fri,  8 Oct 2021 06:34:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 261D0C000F;
	Fri,  8 Oct 2021 06:34:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 838DBC000D
 for <iommu@lists.linux-foundation.org>; Fri,  8 Oct 2021 06:34:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 52A87404A9
 for <iommu@lists.linux-foundation.org>; Fri,  8 Oct 2021 06:34:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qNePDXd5GqfK for <iommu@lists.linux-foundation.org>;
 Fri,  8 Oct 2021 06:34:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3C6A24043F
 for <iommu@lists.linux-foundation.org>; Fri,  8 Oct 2021 06:34:18 +0000 (UTC)
Received: from dggeme713-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HQdfN4LdJz1DHfM;
 Fri,  8 Oct 2021 14:32:44 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggeme713-chm.china.huawei.com (10.1.199.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Fri, 8 Oct 2021 14:34:14 +0800
Received: from dggpeml100016.china.huawei.com ([7.185.36.216]) by
 dggpeml100016.china.huawei.com ([7.185.36.216]) with mapi id 15.01.2308.008;
 Fri, 8 Oct 2021 14:34:14 +0800
From: "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)"
 <longpeng2@huawei.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, "dwmw2@infradead.org"
 <dwmw2@infradead.org>, "will@kernel.org" <will@kernel.org>, "joro@8bytes.org"
 <joro@8bytes.org>
Subject: RE: [PATCH v3 2/2] iommu/vt-d: avoid duplicated removing in
 __domain_mapping
Thread-Topic: [PATCH v3 2/2] iommu/vt-d: avoid duplicated removing in
 __domain_mapping
Thread-Index: AQHXu9gdk8b89stVCk2Mwyelczw816vH1KOAgAAKN4CAAMI5UA==
Date: Fri, 8 Oct 2021 06:34:14 +0000
Message-ID: <83c10788b872489299a54175fe3baafd@huawei.com>
References: <20211008000433.1115-1-longpeng2@huawei.com>
 <20211008000433.1115-3-longpeng2@huawei.com>
 <54cf3663-85e0-3e63-9112-385e9d6eeceb@linux.intel.com>
 <1e83751f-5731-5786-c7d7-899542d7c2b7@linux.intel.com>
In-Reply-To: <1e83751f-5731-5786-c7d7-899542d7c2b7@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.148.223]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Liujunjie \(Jack, Cloud Infrastructure
 Service Product Dept.\)" <liujunjie23@huawei.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTHUgQmFvbHUgW21haWx0
bzpiYW9sdS5sdUBsaW51eC5pbnRlbC5jb21dDQo+IFNlbnQ6IEZyaWRheSwgT2N0b2JlciA4LCAy
MDIxIDEwOjQ0IEFNDQo+IFRvOiBMb25ncGVuZyAoTWlrZSwgQ2xvdWQgSW5mcmFzdHJ1Y3R1cmUg
U2VydmljZSBQcm9kdWN0IERlcHQuKQ0KPiA8bG9uZ3BlbmcyQGh1YXdlaS5jb20+OyBkd213MkBp
bmZyYWRlYWQub3JnOyB3aWxsQGtlcm5lbC5vcmc7DQo+IGpvcm9AOGJ5dGVzLm9yZw0KPiBDYzog
YmFvbHUubHVAbGludXguaW50ZWwuY29tOyBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgR29uZ2xlaSAoQXJlaSkgPGFyZWku
Z29uZ2xlaUBodWF3ZWkuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDIvMl0gaW9tbXUv
dnQtZDogYXZvaWQgZHVwbGljYXRlZCByZW1vdmluZyBpbg0KPiBfX2RvbWFpbl9tYXBwaW5nDQo+
IA0KPiBPbiAxMC84LzIxIDEwOjA3IEFNLCBMdSBCYW9sdSB3cm90ZToNCj4gPiBPbiAxMC84LzIx
IDg6MDQgQU0sIExvbmdwZW5nKE1pa2UpIHdyb3RlOg0KPiA+PiBfX2RvbWFpbl9tYXBwaW5nKCkg
YWx3YXlzIHJlbW92ZXMgdGhlIHBhZ2VzIGluIHRoZSByYW5nZSBmcm9tDQo+ID4+ICdpb3ZfcGZu
JyB0byAnZW5kX3BmbicsIGJ1dCB0aGUgJ2VuZF9wZm4nIGlzIGFsd2F5cyB0aGUgbGFzdCBwZm4N
Cj4gPj4gb2YgdGhlIHJhbmdlIHRoYXQgdGhlIGNhbGxlciB3YW50cyB0byBtYXAuDQo+ID4+DQo+
ID4+IFRoaXMgd291bGQgaW50cm9kdWNlIHRvbyBtYW55IGR1cGxpY2F0ZWQgcmVtb3ZpbmcgYW5k
IGxlYWRzIHRoZQ0KPiA+PiBtYXAgb3BlcmF0aW9uIHRha2UgdG9vIGxvbmcsIGZvciBleGFtcGxl
Og0KPiA+Pg0KPiA+PiDCoMKgIE1hcCBpb3ZhPTB4MTAwMDAwLG5yX3BhZ2VzPTB4N2Q2MTgwMA0K
PiA+PiDCoMKgwqDCoCBpb3ZfcGZuOiAweDEwMDAwMCwgZW5kX3BmbjogMHg3ZTYxN2ZmDQo+ID4+
IMKgwqDCoMKgIGlvdl9wZm46IDB4MTQwMDAwLCBlbmRfcGZuOiAweDdlNjE3ZmYNCj4gPj4gwqDC
oMKgwqAgaW92X3BmbjogMHgxODAwMDAsIGVuZF9wZm46IDB4N2U2MTdmZg0KPiA+PiDCoMKgwqDC
oCBpb3ZfcGZuOiAweDFjMDAwMCwgZW5kX3BmbjogMHg3ZTYxN2ZmDQo+ID4+IMKgwqDCoMKgIGlv
dl9wZm46IDB4MjAwMDAwLCBlbmRfcGZuOiAweDdlNjE3ZmYNCj4gPj4gwqDCoMKgwqAgLi4uDQo+
ID4+IMKgwqAgaXQgdGFrZXMgYWJvdXQgNTBtcyBpbiB0b3RhbC4NCj4gPj4NCj4gPj4gV2UgY2Fu
IHJlZHVjZSB0aGUgY29zdCBieSByZWNhbGN1bGF0ZSB0aGUgJ2VuZF9wZm4nIGFuZCBsaW1pdCBp
dA0KPiA+PiB0byB0aGUgYm91bmRhcnkgb2YgdGhlIGVuZCBvZiB0aGlzIHB0ZSBwYWdlLg0KPiA+
Pg0KPiA+PiDCoMKgIE1hcCBpb3ZhPTB4MTAwMDAwLG5yX3BhZ2VzPTB4N2Q2MTgwMA0KPiA+PiDC
oMKgwqDCoCBpb3ZfcGZuOiAweDEwMDAwMCwgZW5kX3BmbjogMHgxM2ZmZmYNCj4gPj4gwqDCoMKg
wqAgaW92X3BmbjogMHgxNDAwMDAsIGVuZF9wZm46IDB4MTdmZmZmDQo+ID4+IMKgwqDCoMKgIGlv
dl9wZm46IDB4MTgwMDAwLCBlbmRfcGZuOiAweDFiZmZmZg0KPiA+PiDCoMKgwqDCoCBpb3ZfcGZu
OiAweDFjMDAwMCwgZW5kX3BmbjogMHgxZmZmZmYNCj4gPj4gwqDCoMKgwqAgaW92X3BmbjogMHgy
MDAwMDAsIGVuZF9wZm46IDB4MjNmZmZmDQo+ID4+IMKgwqDCoMKgIC4uLg0KPiA+PiDCoMKgIGl0
IG9ubHkgbmVlZCA5bXMgbm93Lg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBMb25ncGVuZyhN
aWtlKSA8bG9uZ3BlbmcyQGh1YXdlaS5jb20+DQo+ID4+IC0tLQ0KPiA+PiDCoCBkcml2ZXJzL2lv
bW11L2ludGVsL2lvbW11LmMgfCAxMSArKysrKystLS0tLQ0KPiA+PiDCoCBpbmNsdWRlL2xpbnV4
L2ludGVsLWlvbW11LmggfMKgIDYgKysrKysrDQo+ID4+IMKgIDIgZmlsZXMgY2hhbmdlZCwgMTIg
aW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYw0K
PiA+PiBpbmRleCBkNzVmNTlhLi40NmVkYWU2IDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL2lv
bW11L2ludGVsL2lvbW11LmMNCj4gPj4gKysrIGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5j
DQo+ID4+IEBAIC0yMzU0LDEyICsyMzU0LDE3IEBAIHN0YXRpYyB2b2lkIHN3aXRjaF90b19zdXBl
cl9wYWdlKHN0cnVjdA0KPiA+PiBkbWFyX2RvbWFpbiAqZG9tYWluLA0KPiA+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU5PTUVNOw0KPiA+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBmaXJzdF9wdGUgPSBwdGU7DQo+ID4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGx2bF9wYWdlcyA9IGx2bF90b19ucl9wYWdlcyhsYXJnZXBhZ2VfbHZsKTsNCj4gPj4g
Kw0KPiA+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBJdCBpcyBsYXJnZSBwYWdlKi8N
Cj4gPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGxhcmdlcGFnZV9sdmwgPiAxKSB7
DQo+ID4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBl
bmRfcGZuOw0KPiA+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGxv
bmcgcGFnZXNfdG9fcmVtb3ZlOw0KPiA+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHB0ZXZhbCB8PSBETUFfUFRFX0xBUkdFX1BBR0U7DQo+ID4+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZW5kX3BmbiA9ICgoaW92X3BmbiArIG5yX3BhZ2VzKSAmDQo+ID4+IGxl
dmVsX21hc2sobGFyZ2VwYWdlX2x2bCkpIC0gMTsNCj4gPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBwYWdlc190b19yZW1vdmUgPSBtaW5fdCh1bnNpZ25lZCBsb25nLCBucl9wYWdl
cywNCj4gPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBucl9wdGVfdG9fbmV4dF9wYWdlKHB0ZSkgKiBsdmxfcGFnZXMpOw0KPiA+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVuZF9wZm4gPSBpb3ZfcGZuICsgcGFnZXNfdG9f
cmVtb3ZlIC0gMTsNCj4gPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzd2l0
Y2hfdG9fc3VwZXJfcGFnZShkb21haW4sIGlvdl9wZm4sIGVuZF9wZm4sDQo+ID4+IGxhcmdlcGFn
ZV9sdmwpOw0KPiA+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9IGVsc2Ugew0KPiA+PiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHB0ZXZhbCAmPSB+KHVpbnQ2NF90KURN
QV9QVEVfTEFSR0VfUEFHRTsNCj4gPj4gQEAgLTIzODEsMTAgKzIzODYsNiBAQCBzdGF0aWMgdm9p
ZCBzd2l0Y2hfdG9fc3VwZXJfcGFnZShzdHJ1Y3QNCj4gPj4gZG1hcl9kb21haW4gKmRvbWFpbiwN
Cj4gPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgV0FSTl9PTigxKTsNCj4gPj4gwqDCoMKg
wqDCoMKgwqDCoMKgIH0NCj4gPj4gLcKgwqDCoMKgwqDCoMKgIGx2bF9wYWdlcyA9IGx2bF90b19u
cl9wYWdlcyhsYXJnZXBhZ2VfbHZsKTsNCj4gPj4gLQ0KPiA+PiAtwqDCoMKgwqDCoMKgwqAgQlVH
X09OKG5yX3BhZ2VzIDwgbHZsX3BhZ2VzKTsNCj4gPj4gLQ0KPiA+PiDCoMKgwqDCoMKgwqDCoMKg
wqAgbnJfcGFnZXMgLT0gbHZsX3BhZ2VzOw0KPiA+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaW92X3Bm
biArPSBsdmxfcGFnZXM7DQo+ID4+IMKgwqDCoMKgwqDCoMKgwqDCoCBwaHlzX3BmbiArPSBsdmxf
cGFnZXM7DQo+ID4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2ludGVsLWlvbW11LmggYi9p
bmNsdWRlL2xpbnV4L2ludGVsLWlvbW11LmgNCj4gPj4gaW5kZXggOWJjYWJjNy4uYjI5YjJhMyAx
MDA2NDQNCj4gPj4gLS0tIGEvaW5jbHVkZS9saW51eC9pbnRlbC1pb21tdS5oDQo+ID4+ICsrKyBi
L2luY2x1ZGUvbGludXgvaW50ZWwtaW9tbXUuaA0KPiA+PiBAQCAtNzEzLDYgKzcxMywxMiBAQCBz
dGF0aWMgaW5saW5lIGJvb2wgZmlyc3RfcHRlX2luX3BhZ2Uoc3RydWN0DQo+ID4+IGRtYV9wdGUg
KnB0ZSkNCj4gPj4gwqDCoMKgwqDCoCByZXR1cm4gSVNfQUxJR05FRCgodW5zaWduZWQgbG9uZylw
dGUsIFZURF9QQUdFX1NJWkUpOw0KPiA+PiDCoCB9DQo+ID4+ICtzdGF0aWMgaW5saW5lIGludCBu
cl9wdGVfdG9fbmV4dF9wYWdlKHN0cnVjdCBkbWFfcHRlICpwdGUpDQo+ID4+ICt7DQo+ID4+ICvC
oMKgwqAgcmV0dXJuIGZpcnN0X3B0ZV9pbl9wYWdlKHB0ZSkgPyBCSVRfVUxMKFZURF9TVFJJREVf
U0hJRlQpIDoNCj4gPj4gK8KgwqDCoMKgwqDCoMKgIChzdHJ1Y3QgZG1hX3B0ZSAqKUFMSUdOKCh1
bnNpZ25lZCBsb25nKXB0ZSwgVlREX1BBR0VfU0laRSkgLQ0KPiA+PiBwdGU7DQo+ID4NCj4gPiBX
ZSBzaG91bGQgbWFrZSBpdCBsaWtlIHRoaXMgdG8gYXZvaWQgdGhlIDBkYXkgd2FybmluZzoNCj4g
Pg0KPiA+ICDCoMKgwqDCoChzdHJ1Y3QgZG1hX3B0ZSAqKSh1aW50cHRyX3QpVlREX1BBR0VfQUxJ
R04oKHVuc2lnbmVkIGxvbmcpcHRlKSAtIHB0ZTsNCj4gPg0KPiA+IENhbiB5b3UgcGxlYXNlIHRl
c3QgdGhpcyBsaW5lIG9mIGNoYW5nZT8gTm8gbmVlZCB0byBzZW5kIGEgbmV3IHZlcnNpb24uDQo+
ID4gSSB3aWxsIGhhbmRsZSBpdCBpZiBpdCBwYXNzZXMgeW91ciB0ZXN0Lg0KPiANCj4gSnVzdCBy
ZWFsaXplZCB0aGF0IEFMSUdOKCkgaGFzIGFscmVhZHkgZG9uZSB0aGUgdHlwZSBjYXN0LiBQbGVh
c2UgaWdub3JlDQo+IGFib3ZlIGNvbW1lbnQuIFNvcnJ5IGZvciB0aGUgbm9pc2UuDQo+IA0KDQpI
aSBCYW9sdSwNCg0KT3VyIHRlc3RpbmcgaXMgY29tcGxldGVkLCBubyBjb21waWxlIHdhcm5pbmcg
b24gYm90aCBYODYgNjRiaXQgYW5kIDMyYml0IGFyY2gsDQphbmQgdGhlIHN5c3RlbSBpcyB3b3Jr
aW5nIGFzIGV4cGVjdGVkLg0KDQpQbGVhc2UgYWRkOg0KDQpUZXN0ZWQtYnk6IExpdWp1bmppZSA8
bGl1anVuamllMjNAaHVhd2VpLmNvbT4NCg0KPiBCZXN0IHJlZ2FyZHMsDQo+IGJhb2x1DQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5n
IGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
