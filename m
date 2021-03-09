Return-Path: <SRS0=6QSB=IH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9426DC433DB
	for <iommu@archiver.kernel.org>; Tue,  9 Mar 2021 11:12:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C599F65256
	for <iommu@archiver.kernel.org>; Tue,  9 Mar 2021 11:12:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C599F65256
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 863486F4EA;
	Tue,  9 Mar 2021 11:12:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9BUStsOWv210; Tue,  9 Mar 2021 11:12:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5FCFE6F59B;
	Tue,  9 Mar 2021 11:12:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1476CC000B;
	Tue,  9 Mar 2021 11:12:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78EFBC0001
 for <iommu@lists.linux-foundation.org>; Tue,  9 Mar 2021 11:12:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 668396F562
 for <iommu@lists.linux-foundation.org>; Tue,  9 Mar 2021 11:12:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AchQ4dbIznqS for <iommu@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 11:12:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 82C3A6F4EA
 for <iommu@lists.linux-foundation.org>; Tue,  9 Mar 2021 11:12:52 +0000 (UTC)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Dvsrp527Tz67x2w;
 Tue,  9 Mar 2021 19:08:26 +0800 (CST)
Received: from lhreml713-chm.china.huawei.com (10.201.108.64) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 9 Mar 2021 12:12:48 +0100
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml713-chm.china.huawei.com (10.201.108.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 9 Mar 2021 11:12:48 +0000
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2106.013; Tue, 9 Mar 2021 11:12:47 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Marc Zyngier <maz@kernel.org>
Subject: RE: [RFC PATCH 3/5] KVM: ARM64: Add support for pinned VMIDs
Thread-Topic: [RFC PATCH 3/5] KVM: ARM64: Add support for pinned VMIDs
Thread-Index: AQHXFM+pNzn6N7qD+EC2ipQhTHsQxqp7fRwA
Date: Tue, 9 Mar 2021 11:12:47 +0000
Message-ID: <aa47e87828d54ae09f844ce496d22acc@huawei.com>
References: <20210222155338.26132-1-shameerali.kolothum.thodi@huawei.com>
 <20210222155338.26132-4-shameerali.kolothum.thodi@huawei.com>
 <87tupky5v8.wl-maz@kernel.org>
In-Reply-To: <87tupky5v8.wl-maz@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.86.145]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 Will Deacon <will@kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

SGkgTWFyYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjIFp5
bmdpZXIgW21haWx0bzptYXpAa2VybmVsLm9yZ10NCj4gU2VudDogMDkgTWFyY2ggMjAyMSAxMDoz
Mw0KPiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSA8c2hhbWVlcmFsaS5rb2xvdGh1bS50
aG9kaUBodWF3ZWkuY29tPg0KPiBDYzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnOyBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsNCj4ga3ZtYXJtQGxpc3RzLmNz
LmNvbHVtYmlhLmVkdTsgYWxleC53aWxsaWFtc29uQHJlZGhhdC5jb207DQo+IGplYW4tcGhpbGlw
cGVAbGluYXJvLm9yZzsgZXJpYy5hdWdlckByZWRoYXQuY29tOyB6aGFuZ2ZlaS5nYW9AbGluYXJv
Lm9yZzsNCj4gSm9uYXRoYW4gQ2FtZXJvbiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsg
WmVuZ3RhbyAoQikNCj4gPHByaW1lLnplbmdAaGlzaWxpY29uLmNvbT47IGxpbnV4YXJtQG9wZW5l
dWxlci5vcmc7IFdpbGwgRGVhY29uDQo+IDx3aWxsQGtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJl
OiBbUkZDIFBBVENIIDMvNV0gS1ZNOiBBUk02NDogQWRkIHN1cHBvcnQgZm9yIHBpbm5lZCBWTUlE
cw0KPiANCj4gSGkgU2hhbWVlciwNCj4gDQo+IFsrV2lsbF0NCj4gDQo+IE9uIE1vbiwgMjIgRmVi
IDIwMjEgMTU6NTM6MzYgKzAwMDAsDQo+IFNoYW1lZXIgS29sb3RodW0gPHNoYW1lZXJhbGkua29s
b3RodW0udGhvZGlAaHVhd2VpLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBPbiBhbiBBUk02NCBzeXN0
ZW0gd2l0aCBhIFNNTVV2M8KgaW1wbGVtZW50YXRpb24gdGhhdCBmdWxseSBzdXBwb3J0cw0KPiA+
IEJyb2FkY2FzdCBUTEIgTWFpbnRlbmFuY2UoQlRNKSBmZWF0dXJlLCB0aGUgQ1BVIFRMQiBpbnZh
bGlkYXRlDQo+ID4gaW5zdHJ1Y3Rpb25zIGFyZSByZWNlaXZlZMKgYnkgU01NVS4gVGhpcyBpc8Kg
dmVyecKgdXNlZnVsIHdoZW4gdGhlDQo+ID4gU01NVSBzaGFyZXPCoHRoZSBwYWdlIHRhYmxlcyB3
aXRoIHRoZSBDUFUoZWc6IEd1ZXN0IFNWQSB1c2UgY2FzZSkuDQo+ID4gRm9yIHRoaXMgdG8gd29y
aywgdGhlIFNNTVUgbXVzdCB1c2UgdGhlIHNhbWUgVk1JRCB0aGF0IGlzIGFsbG9jYXRlZA0KPiA+
IGJ5IEtWTSB0byBjb25maWd1cmUgdGhlIHN0YWdlIDIgdHJhbnNsYXRpb25zLg0KPiA+DQo+ID4g
QXQgcHJlc2VudCBLVk0gVk1JRCBhbGxvY2F0aW9ucyBhcmUgcmVjeWNsZWQgb24gcm9sbG92ZXIg
YW5kIG1heQ0KPiA+IGNoYW5nZSBhcyBhIHJlc3VsdC4gVGhpcyB3aWxsIGNyZWF0ZcKgaXNzdWVz
IGlmIHdlIGhhdmXCoHRvIHNoYXJlDQo+ID4gdGhlIEtWTSBWTUlEIHdpdGggU01NVS4gSGVuY2Us
IHdlIHNwaWx0wqB0aGUgS1ZNIFZNSUQgc3BhY2UgaW50bw0KPiA+IHR3bywgdGhlIGZpcnN0IGhh
bGYgZm9sbG93cyB0aGUgbm9ybWFsIHJlY3ljbGXCoG9uIHJvbGxvdmVyIHBvbGljeQ0KPiA+IHdo
aWxlIHRoZSBzZWNvbmQgaGFsZiBvZiB0aGUgVk1JRCBwYWNlIGlzIHVzZWQgdG8gYWxsb2NhdGUg
cGlubmVkDQo+ID4gVk1JRHMuIFRoaXMgZmVhdHVyZSBpcyBlbmFibGVkIGJhc2VkIG9uIGEgY29t
bWFuZCBsaW5lIG9wdGlvbg0KPiA+ICJrdm0tYXJtLnBpbm5lZF92bWlkX2VuYWJsZSIuDQo+IA0K
PiBJIHRoaW5rIHRoaXMgaXMgdGhlIHdyb25nIGFwcHJvYWNoLiBJbnN0ZWFkIG9mIHNob3Zpbmcg
dGhlIG5vdGlvbiBvZg0KPiBwaW5uZWQgVk1JRCBpbnRvIHRoZSBjdXJyZW50IGFsbG9jYXRvciwg
d2hpY2ggcmVhbGx5IGlzbid0IGRlc2lnbmVkDQo+IGZvciB0aGlzLCBpdCdkIGJlIGEgbG90IGJl
dHRlciBpZiB3ZSBhbGlnbmVkIHRoZSBLVk0gVk1JRCBhbGxvY2F0b3INCj4gd2l0aCB0aGUgQVNJ
RCBhbGxvY2F0b3IsIHdoaWNoIGFscmVhZHkgaGFzIHN1cHBvcnQgZm9yIHBpbm5pbmcgYW5kIGlz
DQo+IGluIGdlbmVyYWwgbXVjaCBtb3JlIGVmZmljaWVudC4NCg0KT2suIEFncmVlIHRoYXQgdGhp
cyBpcyBub3QgZWZmaWNpZW50LCBidXQgd2FzIGVhc3kgdG8gcHJvdG90eXBlIHNvbWV0aGluZyA6
KQ0KDQo+IEp1bGllbiBHcmFsbCB3b3JrZWQgb24gc3VjaCBhIHNlcmllc1sxXSBhIGxvbmcgd2hp
bGUgYWdvLCB3aGljaCBnb3QNCj4gc3RhbGxlZCBiZWNhdXNlIG9mIHRoZSAzMmJpdCBLVk0gcG9y
dC4gU2luY2Ugd2UgZG9uJ3QgaGF2ZSB0aGlzIGJ1cmRlbg0KPiBhbnltb3JlLCBJJ2QgcmF0aGVy
IHlvdSBsb29rIGluIHRoYXQgZGlyZWN0aW9uIGluc3RlYWQgb2Ygd2FzdGluZyBoYWxmDQo+IG9m
IHRoZSBWTUlEIHNwYWNlIG9uIHBvdGVudGlhbGx5IHBpbm5lZCBWTUlEcy4NCg0KU3VyZS4gSSB3
aWxsIGNoZWNrIHRoYXQgYW5kIHdvcmsgb24gaXQuDQoNClRoYW5rcywNClNoYW1lZXINCg0KPiBU
aGFua3MsDQo+IA0KPiAJTS4NCj4gDQo+IFsxXQ0KPiBodHRwczovL3BhdGNod29yay5rZXJuZWwu
b3JnL3Byb2plY3QvbGludXgtYXJtLWtlcm5lbC9jb3Zlci8yMDE5MDcyNDE2MjUzNA0KPiAuNzM5
MC0xLWp1bGllbi5ncmFsbEBhcm0uY29tLw0KPiANCj4gDQo+IC0tDQo+IFdpdGhvdXQgZGV2aWF0
aW9uIGZyb20gdGhlIG5vcm0sIHByb2dyZXNzIGlzIG5vdCBwb3NzaWJsZS4NCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdApp
b21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
