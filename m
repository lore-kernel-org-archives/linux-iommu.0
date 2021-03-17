Return-Path: <SRS0=kdPY=IP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922EFC433DB
	for <iommu@archiver.kernel.org>; Wed, 17 Mar 2021 09:40:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFAB664F51
	for <iommu@archiver.kernel.org>; Wed, 17 Mar 2021 09:40:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFAB664F51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 98A6783F13;
	Wed, 17 Mar 2021 09:40:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f1ROSPigFLlX; Wed, 17 Mar 2021 09:40:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 546B48377F;
	Wed, 17 Mar 2021 09:40:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28895C000A;
	Wed, 17 Mar 2021 09:40:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8545C0001
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 09:40:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DCED083E91
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 09:40:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fwGY14vGO6nG for <iommu@lists.linux-foundation.org>;
 Wed, 17 Mar 2021 09:40:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 922F68377F
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 09:40:43 +0000 (UTC)
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.53])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4F0lSJ2nc2z141y3;
 Wed, 17 Mar 2021 17:37:36 +0800 (CST)
Received: from dggpemm100011.china.huawei.com (7.185.36.112) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Wed, 17 Mar 2021 17:40:37 +0800
Received: from dggpeml500016.china.huawei.com (7.185.36.70) by
 dggpemm100011.china.huawei.com (7.185.36.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 17 Mar 2021 17:40:37 +0800
Received: from dggpeml500016.china.huawei.com ([7.185.36.70]) by
 dggpeml500016.china.huawei.com ([7.185.36.70]) with mapi id 15.01.2106.013;
 Wed, 17 Mar 2021 17:40:37 +0800
From: "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)"
 <longpeng2@huawei.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, "dwmw2@infradead.org"
 <dwmw2@infradead.org>, "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org"
 <will@kernel.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>
Subject: =?gb2312?B?UkU6IEEgcHJvYmxlbSBvZiBJbnRlbCBJT01NVSBoYXJkd2FyZSCjvw==?=
Thread-Topic: =?gb2312?B?QSBwcm9ibGVtIG9mIEludGVsIElPTU1VIGhhcmR3YXJlIKO/?=
Thread-Index: AQHXGtwEduPlUZeCNUCbiy3s/+KwAaqHHa0AgADFS4A=
Date: Wed, 17 Mar 2021 09:40:37 +0000
Message-ID: <a6315a46fadd4171bc69b5e53e3ad67b@huawei.com>
References: <670baaf8-4ff8-4e84-4be3-030b95ab5a5e@huawei.com>
 <692186fd-42b8-4054-ead2-f6c6b1bf5b2d@linux.intel.com>
In-Reply-To: <692186fd-42b8-4054-ead2-f6c6b1bf5b2d@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.151.207]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: chenjiashang <chenjiashang@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>
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
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGkgQmFvbHUsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTHUgQmFv
bHUgW21haWx0bzpiYW9sdS5sdUBsaW51eC5pbnRlbC5jb21dDQo+IFNlbnQ6IFdlZG5lc2RheSwg
TWFyY2ggMTcsIDIwMjEgMToxNyBQTQ0KPiBUbzogTG9uZ3BlbmcgKE1pa2UsIENsb3VkIEluZnJh
c3RydWN0dXJlIFNlcnZpY2UgUHJvZHVjdCBEZXB0LikNCj4gPGxvbmdwZW5nMkBodWF3ZWkuY29t
PjsgZHdtdzJAaW5mcmFkZWFkLm9yZzsgam9yb0A4Ynl0ZXMub3JnOw0KPiB3aWxsQGtlcm5lbC5v
cmc7IGFsZXgud2lsbGlhbXNvbkByZWRoYXQuY29tDQo+IENjOiBiYW9sdS5sdUBsaW51eC5pbnRl
bC5jb207IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBMS01MDQo+IDxsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgR29uZ2xlaSAoQXJlaSkgPGFyZWkuZ29uZ2xlaUBodWF3
ZWkuY29tPjsNCj4gY2hlbmppYXNoYW5nIDxjaGVuamlhc2hhbmdAaHVhd2VpLmNvbT4NCj4gU3Vi
amVjdDogUmU6IEEgcHJvYmxlbSBvZiBJbnRlbCBJT01NVSBoYXJkd2FyZSCjvw0KPiANCj4gSGkg
TG9uZ3BlbmcsDQo+IA0KPiBPbiAzLzE3LzIxIDExOjE2IEFNLCBMb25ncGVuZyAoTWlrZSwgQ2xv
dWQgSW5mcmFzdHJ1Y3R1cmUgU2VydmljZSBQcm9kdWN0IERlcHQuKQ0KPiB3cm90ZToNCj4gPiBI
aSBndXlzLA0KPiA+DQo+ID4gV2UgZmluZCB0aGUgSW50ZWwgaW9tbXUgY2FjaGUgKGkuZS4gaW90
bGIpIG1heWJlIHdvcmtzIHdyb25nIGluIGENCj4gPiBzcGVjaWFsIHNpdHVhdGlvbiwgaXQgd291
bGQgY2F1c2UgRE1BIGZhaWxzIG9yIGdldCB3cm9uZyBkYXRhLg0KPiA+DQo+ID4gVGhlIHJlcHJv
ZHVjZXIgKGJhc2VkIG9uIEFsZXgncyB2ZmlvIHRlc3RzdWl0ZVsxXSkgaXMgaW4gYXR0YWNobWVu
dCwNCj4gPiBpdCBjYW4gcmVwcm9kdWNlIHRoZSBwcm9ibGVtIHdpdGggaGlnaCBwcm9iYWJpbGl0
eSAofjUwJSkuDQo+ID4NCj4gPiBUaGUgbWFjaGluZSB3ZSB1c2VkIGlzOg0KPiA+IHByb2Nlc3Nv
cgk6IDQ3DQo+ID4gdmVuZG9yX2lkCTogR2VudWluZUludGVsDQo+ID4gY3B1IGZhbWlseQk6IDYN
Cj4gPiBtb2RlbAkJOiA4NQ0KPiA+IG1vZGVsIG5hbWUJOiBJbnRlbChSKSBYZW9uKFIpIEdvbGQg
NjE0NiBDUFUgQCAzLjIwR0h6DQo+ID4gc3RlcHBpbmcJOiA0DQo+ID4gbWljcm9jb2RlCTogMHgy
MDAwMDY5DQo+ID4NCj4gPiBBbmQgdGhlIGlvbW11IGNhcGFiaWxpdHkgcmVwb3J0ZWQgaXM6DQo+
ID4gdmVyIDE6MCBjYXAgOGQyMDc4YzEwNmYwNDY2IGVjYXAgZjAyMGRmIChjYWNoaW5nIG1vZGUg
PSAwICwNCj4gPiBwYWdlLXNlbGVjdGl2ZSBpbnZhbGlkYXRpb24gPSAxKQ0KPiA+DQo+ID4gKFRo
ZSBwcm9ibGVtIGlzIGFsc28gb24gJ0ludGVsKFIpIFhlb24oUikgU2lsdmVyIDQxMTQgQ1BVIEAg
Mi4yMEdIeicNCj4gPiBhbmQNCj4gPiAnSW50ZWwoUikgWGVvbihSKSBQbGF0aW51bSA4Mzc4QSBD
UFUgQCAzLjAwR0h6JykNCj4gPg0KPiA+IFdlIHJ1biB0aGUgcmVwcm9kdWNlciBvbiBMaW51eCA0
LjE4IGFuZCBpdCB3b3JrcyBhcyBmb2xsb3c6DQo+ID4NCj4gPiBTdGVwIDEuIGFsbG9jIDRHICoy
TS1odWdldGxiKiBtZW1vcnkgKE4uQi4gbm8gcHJvYmxlbSB3aXRoIDRLLXBhZ2UNCj4gPiBtYXBw
aW5nKQ0KPiANCj4gSSBkb24ndCB1bmRlcnN0YW5kIDJNLWh1Z2V0bGIgaGVyZSBtZWFucyBleGFj
dGx5LiBUaGUgSU9NTVUgaGFyZHdhcmUNCj4gc3VwcG9ydHMgYm90aCAyTSBhbmQgMUcgc3VwZXIg
cGFnZS4gVGhlIG1hcHBpbmcgcGh5c2ljYWwgbWVtb3J5IGlzIDRHLg0KPiBXaHkgY291bGRuJ3Qg
aXQgdXNlIDFHIHN1cGVyIHBhZ2U/DQo+IA0KDQpXZSB1c2UgaHVnZXRsYmZzKHN1cHBvcnQgMUcg
YW5kIDJNLCBidXQgd2UgY2hvb3NlIDJNIGluIG91ciBjYXNlKSB0byByZXF1ZXN0DQp0aGUgbWVt
b3J5IGluIHVzZXJzcGFjZTogDQp2YWRkciA9ICh1bnNpZ25lZCBsb25nKW1tYXAoMCwgTUFQX1NJ
WkUsIFBST1RfUkVBRCB8IFBST1RfV1JJVEUsDQoJCQkJICAgIE1BUF9QUklWQVRFIHwgTUFQX0FO
T05ZTU9VUyB8ICpNQVBfSFVHRVRMQiosIDAsIDApOw0KDQpZZXAsIElPTU1VIHN1cHBvcnQgYm90
aCAyTSBhbmQgMUcgc3VwZXJwYWdlLCB3ZSBqdXN0IGhhdmVuJ3QgdG8gdGVzdCB0aGUgMUcgY2Fz
ZQ0KeWV0LCBiZWNhdXNlIG91ciBwcm9kdWN0aW9ucyB1c2UgMk0gaHVnZXRsYmZzIHBhZ2UuDQoN
Cj4gPiBTdGVwIDIuIERNQSBNYXAgNEcgbWVtb3J5DQo+ID4gU3RlcCAzLg0KPiA+ICAgICAgd2hp
bGUgKDEpIHsNCj4gPiAgICAgICAgICB7VU5NQVAsIDB4MCwgMHhhMDAwMH0sIC0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSAoYSkNCj4gPiAgICAgICAgICB7VU5NQVAsIDB4YzAw
MDAsIDB4YmZmNDAwMDB9LA0KPiANCj4gSGF2ZSB0aGVzZSB0d28gcmFuZ2VzIGJlZW4gbWFwcGVk
IGJlZm9yZT8gRG9lcyB0aGUgSU9NTVUgZHJpdmVyIGNvbXBsYWlucw0KPiB3aGVuIHlvdSB0cnlp
bmcgdG8gdW5tYXAgYSByYW5nZSB3aGljaCBoYXMgbmV2ZXIgYmVlbiBtYXBwZWQ/IFRoZSBJT01N
VQ0KPiBkcml2ZXIgaW1wbGljaXRseSBhc3N1bWVzIHRoYXQgbWFwcGluZyBhbmQgdW5tYXBwaW5n
IGFyZSBwYWlyZWQuDQo+IA0KDQpPZiBjb3Vyc2UgeWVzLCBwbGVhc2UgU3RlcC0yLCB3ZSBETUEg
bWFwcGVkIGFsbCB0aGUgbWVtb3J5KDRHKSBiZWZvcmUgdGhlIHdoaWxlIGxvb3AuDQpUaGUgZHJp
dmVyIG5ldmVyIGNvbXBsYWluZWQgZHVyaW5nIE1BUCBhbmQgVU5NQVAgb3BlcmF0aW9ucy4NCg0K
PiA+ICAgICAgICAgIHtNQVAsICAgMHgwLCAweGMwMDAwMDAwfSwgLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tIChiKQ0KPiA+ICAgICAgICAgICAgICAgICAgdXNlIEdEQiB0byBwYXVz
ZSBhdCBoZXJlLCBhbmQgdGhlbiBETUEgcmVhZCBJT1ZBPTAsDQo+IA0KPiBJT1ZBIDAgc2VlbXMg
dG8gYmUgYSBzcGVjaWFsIG9uZS4gSGF2ZSB5b3UgdmVyaWZpZWQgd2l0aCBvdGhlciBhZGRyZXNz
ZXMgdGhhbg0KPiBJT1ZBIDA/DQo+IA0KDQpZZXMsIHdlIGFsc28gdGVzdCBJT1ZBPTB4MTAwMCwg
aXQgaGFzIHByb2JsZW0gdG9vLg0KDQpCdXQgb25lIG9mIHRoZSBkaWZmZXJlY2VzIGJldHdlZW4g
KDB4MCwgMHhhMDAwMCkgYW5kICgweDAsIDB4YzAwMDAwMDApIGlzIHRoZSBmb3JtZXINCmNhbiBv
bmx5IHVzZSA0SyBtYXBwaW5nIGluIERNQSBwYWdldGFibGUgYnV0IHRoZSBsYXR0ZXIgdXNlcyAy
TSBtYXBwaW5nLiBJcyBpdCBwb3NzaWJsZQ0KdGhlIGhhcmR3YXJlIGNhY2hlIG1hbmFnZW1lbnQg
d29ya3Mgc29tZXRoaW5nIHdyb25nIGluIHRoaXMgY2FzZT8NCg0KPiA+ICAgICAgICAgICAgICAg
ICAgc29tZXRpbWVzIERNQSBzdWNjZXNzIChhcyBleHBlY3RlZCksDQo+ID4gICAgICAgICAgICAg
ICAgICBidXQgc29tZXRpbWVzIERNQSBlcnJvciAocmVwb3J0IG5vdC1wcmVzZW50KS4NCj4gPiAg
ICAgICAgICB7VU5NQVAsIDB4MCwgMHhjMDAwMDAwMH0sIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLSAoYykNCj4gPiAgICAgICAgICB7TUFQLCAgIDB4MCwgMHhhMDAwMH0sDQo+ID4g
ICAgICAgICAge01BUCwgICAweGMwMDAwLCAweGJmZjQwMDAwfSwNCj4gPiAgICAgIH0NCj4gPg0K
PiA+IFRoZSBETUEgcmVhZCBvcGVyYXRpb25zIHNob2x1ZCBzdWNjZXNzIGJldHdlZW4gKGIpIGFu
ZCAoYyksIGl0IHNob3VsZA0KPiA+IE5PVCByZXBvcnQgbm90LXByZXNlbnQgYXQgbGVhc3QhDQo+
ID4NCj4gPiBBZnRlciBhbmFseXNpcyB0aGUgcHJvYmxlbSwgd2UgdGhpbmsgbWF5YmUgaXQncyBj
YXVzZWQgYnkgdGhlIEludGVsIGlvbW11IGlvdGxiLg0KPiA+IEl0IHNlZW1zIHRoZSBETUEgUmVt
YXBwaW5nIGhhcmR3YXJlIHN0aWxsIHVzZXMgdGhlIElPVExCIG9yIG90aGVyIGNhY2hlcyBvZg0K
PiAoYSkuDQo+ID4NCj4gPiBXaGVuIGRvIERNQSB1bm1hcCBhdCAoYSksIHRoZSBpb3RsYiB3aWxs
IGJlIGZsdXNoOg0KPiA+ICAgICAgaW50ZWxfaW9tbXVfdW5tYXANCj4gPiAgICAgICAgICBkb21h
aW5fdW5tYXANCj4gPiAgICAgICAgICAgICAgaW9tbXVfZmx1c2hfaW90bGJfcHNpDQo+ID4NCj4g
PiBXaGVuIGRvIERNQSBtYXAgYXQgKGIpLCBubyBuZWVkIHRvIGZsdXNoIHRoZSBpb3RsYiBhY2Nv
cmRpbmcgdG8gdGhlDQo+ID4gY2FwYWJpbGl0eSBvZiB0aGlzIGlvbW11Og0KPiA+ICAgICAgaW50
ZWxfaW9tbXVfbWFwDQo+ID4gICAgICAgICAgZG9tYWluX3Bmbl9tYXBwaW5nDQo+ID4gICAgICAg
ICAgICAgIGRvbWFpbl9tYXBwaW5nDQo+ID4gICAgICAgICAgICAgICAgICBfX21hcHBpbmdfbm90
aWZ5X29uZQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgIGlmIChjYXBfY2FjaGluZ19tb2RlKGlv
bW11LT5jYXApKSAvLyBGQUxTRQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICBpb21tdV9m
bHVzaF9pb3RsYl9wc2kNCj4gDQo+IFRoYXQncyB0cnVlLiBUaGUgaW90bGIgZmx1c2hpbmcgaXMg
bm90IG5lZWRlZCBpbiBjYXNlIG9mIFBURSBiZWVuIGNoYW5nZWQgZnJvbQ0KPiBub24tcHJlc2Vu
dCB0byBwcmVzZW50IHVubGVzcyBjYWNoaW5nIG1vZGUuDQo+IA0KDQpZZXMsIEkgYWxzbyB0aGlu
ayB0aGUgZHJpdmVyIGNvZGUgaXMgY29ycmVjdC4gQnV0IGl0J3Mgc28gY29uZnVzZWQgdGhhdCB0
aGUgcHJvYmxlbQ0KaXMgZGlzYXBwZWFyIGlmIHdlIGZvcmNlIGl0IHRvIGZsdXNoIGhlcmUuDQoN
Cj4gPiBCdXQgdGhlIHByb2JsZW0gd2lsbCBkaXNhcHBlYXIgaWYgd2UgRk9SQ0UgZmx1c2ggaGVy
ZS4gU28gd2Ugc3VzcGVjdA0KPiA+IHRoZSBpb21tdSBoYXJkd2FyZS4NCj4gPg0KPiA+IERvIHlv
dSBoYXZlIGFueSBzdWdnZXN0aW9uID8NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gYmFvbHUNCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxp
bmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
