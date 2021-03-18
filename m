Return-Path: <SRS0=56b4=IQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C8CC433E0
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 08:54:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D096C64F01
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 08:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D096C64F01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8CBE060695;
	Thu, 18 Mar 2021 08:54:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qpYYTb_PBI9w; Thu, 18 Mar 2021 08:54:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4F54960633;
	Thu, 18 Mar 2021 08:54:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21CC1C000B;
	Thu, 18 Mar 2021 08:54:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B04AC0001
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 08:54:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 30E148356C
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 08:54:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u94E4PxYGmeR for <iommu@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 08:54:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CAF2B834F4
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 08:54:13 +0000 (UTC)
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.57])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4F1LPW2Nkqz5fJy;
 Thu, 18 Mar 2021 16:52:15 +0800 (CST)
Received: from dggpemm500012.china.huawei.com (7.185.36.89) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 18 Mar 2021 16:54:09 +0800
Received: from dggpeml500016.china.huawei.com (7.185.36.70) by
 dggpemm500012.china.huawei.com (7.185.36.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 18 Mar 2021 16:54:09 +0800
Received: from dggpeml500016.china.huawei.com ([7.185.36.70]) by
 dggpeml500016.china.huawei.com ([7.185.36.70]) with mapi id 15.01.2106.013;
 Thu, 18 Mar 2021 16:54:09 +0800
From: "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)"
 <longpeng2@huawei.com>
To: "Tian, Kevin" <kevin.tian@intel.com>, Nadav Amit <nadav.amit@gmail.com>
Subject: =?utf-8?B?UkU6IEEgcHJvYmxlbSBvZiBJbnRlbCBJT01NVSBoYXJkd2FyZSDvvJ8=?=
Thread-Topic: =?utf-8?B?QSBwcm9ibGVtIG9mIEludGVsIElPTU1VIGhhcmR3YXJlIO+8nw==?=
Thread-Index: AQHXGtwEduPlUZeCNUCbiy3s/+KwAaqHJckAgADDZTCAAA0+AIABZ4Ng//+HOQCAAIduIP//fRsAgACIaxA=
Date: Thu, 18 Mar 2021 08:54:09 +0000
Message-ID: <e27ceb3b87294950b9990ba8c087b0a5@huawei.com>
References: <670baaf8-4ff8-4e84-4be3-030b95ab5a5e@huawei.com>
 <FB4E11A5-84D4-4DAF-889E-FAA1BCD2E66F@gmail.com>
 <6a218e7fe42d41489d02f0b4e3ad2756@huawei.com>
 <98DB71EF-FF98-4509-85EC-26FF50825A58@gmail.com>
 <4d1c3bc0418e48b1b9d44799d65ea375@huawei.com>
 <MWHPR11MB18860801196A9319EBD96AF68C699@MWHPR11MB1886.namprd11.prod.outlook.com>
 <d7bb4ab26b8542c698926b7a0a3fc12c@huawei.com>
 <MWHPR11MB18865CD0C3B7A9CFD73D8E4C8C699@MWHPR11MB1886.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB18865CD0C3B7A9CFD73D8E4C8C699@MWHPR11MB1886.namprd11.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.151.207]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: chenjiashang <chenjiashang@huawei.com>, "will@kernel.org" <will@kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 David Woodhouse <dwmw2@infradead.org>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGlhbiwgS2V2aW4gW21h
aWx0bzprZXZpbi50aWFuQGludGVsLmNvbV0NCj4gU2VudDogVGh1cnNkYXksIE1hcmNoIDE4LCAy
MDIxIDQ6NDMgUE0NCj4gVG86IExvbmdwZW5nIChNaWtlLCBDbG91ZCBJbmZyYXN0cnVjdHVyZSBT
ZXJ2aWNlIFByb2R1Y3QgRGVwdC4pDQo+IDxsb25ncGVuZzJAaHVhd2VpLmNvbT47IE5hZGF2IEFt
aXQgPG5hZGF2LmFtaXRAZ21haWwuY29tPg0KPiBDYzogY2hlbmppYXNoYW5nIDxjaGVuamlhc2hh
bmdAaHVhd2VpLmNvbT47IERhdmlkIFdvb2Rob3VzZQ0KPiA8ZHdtdzJAaW5mcmFkZWFkLm9yZz47
IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBMS01MDQo+IDxsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnPjsgYWxleC53aWxsaWFtc29uQHJlZGhhdC5jb207IEdvbmdsZWkgKEFy
ZWkpDQo+IDxhcmVpLmdvbmdsZWlAaHVhd2VpLmNvbT47IHdpbGxAa2VybmVsLm9yZw0KPiBTdWJq
ZWN0OiBSRTogQSBwcm9ibGVtIG9mIEludGVsIElPTU1VIGhhcmR3YXJlIO+8nw0KPiANCj4gPiBG
cm9tOiBMb25ncGVuZyAoTWlrZSwgQ2xvdWQgSW5mcmFzdHJ1Y3R1cmUgU2VydmljZSBQcm9kdWN0
IERlcHQuKQ0KPiA+IDxsb25ncGVuZzJAaHVhd2VpLmNvbT4NCj4gPg0KPiA+DQo+ID4gPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogVGlhbiwgS2V2aW4gW21haWx0bzpr
ZXZpbi50aWFuQGludGVsLmNvbV0NCj4gPiA+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAxOCwgMjAy
MSA0OjI3IFBNDQo+ID4gPiBUbzogTG9uZ3BlbmcgKE1pa2UsIENsb3VkIEluZnJhc3RydWN0dXJl
IFNlcnZpY2UgUHJvZHVjdCBEZXB0LikNCj4gPiA+IDxsb25ncGVuZzJAaHVhd2VpLmNvbT47IE5h
ZGF2IEFtaXQgPG5hZGF2LmFtaXRAZ21haWwuY29tPg0KPiA+ID4gQ2M6IGNoZW5qaWFzaGFuZyA8
Y2hlbmppYXNoYW5nQGh1YXdlaS5jb20+OyBEYXZpZCBXb29kaG91c2UNCj4gPiA+IDxkd213MkBp
bmZyYWRlYWQub3JnPjsgaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IExLTUwNCj4g
PiA+IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgYWxleC53aWxsaWFtc29uQHJlZGhh
dC5jb207IEdvbmdsZWkNCj4gPiAoQXJlaSkNCj4gPiA+IDxhcmVpLmdvbmdsZWlAaHVhd2VpLmNv
bT47IHdpbGxAa2VybmVsLm9yZw0KPiA+ID4gU3ViamVjdDogUkU6IEEgcHJvYmxlbSBvZiBJbnRl
bCBJT01NVSBoYXJkd2FyZSDvvJ8NCj4gPiA+DQo+ID4gPiA+IEZyb206IGlvbW11IDxpb21tdS1i
b3VuY2VzQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnPiBPbiBCZWhhbGYNCj4gPiA+ID4gT2Yg
TG9uZ3BlbmcgKE1pa2UsIENsb3VkIEluZnJhc3RydWN0dXJlIFNlcnZpY2UgUHJvZHVjdCBEZXB0
LikNCj4gPiA+ID4NCj4gPiA+ID4gPiAyLiBDb25zaWRlciBlbnN1cmluZyB0aGF0IHRoZSBwcm9i
bGVtIGlzIG5vdCBzb21laG93IHJlbGF0ZWQgdG8NCj4gPiA+ID4gPiBxdWV1ZWQgaW52YWxpZGF0
aW9ucy4gVHJ5IHRvIHVzZSBfX2lvbW11X2ZsdXNoX2lvdGxiKCkgaW5zdGVhZA0KPiA+ID4gPiA+
IG9mDQo+ID4gPiBxaV9mbHVzaF9pb3RsYigpLg0KPiA+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+
IEkgdHJpZWQgdG8gZm9yY2UgdG8gdXNlIF9faW9tbXVfZmx1c2hfaW90bGIoKSwgYnV0IG1heWJl
IHNvbWV0aGluZw0KPiA+ID4gPiB3cm9uZywgdGhlIHN5c3RlbSBjcmFzaGVkLCBzbyBJIHByZWZl
ciB0byBsb3dlciB0aGUgcHJpb3JpdHkgb2YNCj4gPiA+ID4gdGhpcw0KPiA+IG9wZXJhdGlvbi4N
Cj4gPiA+ID4NCj4gPiA+DQo+ID4gPiBUaGUgVlQtZCBzcGVjIGNsZWFybHkgc2F5cyB0aGF0IHJl
Z2lzdGVyLWJhc2VkIGludmFsaWRhdGlvbiBjYW4gYmUNCj4gPiA+IHVzZWQgb25seQ0KPiA+IHdo
ZW4NCj4gPiA+IHF1ZXVlZC1pbnZhbGlkYXRpb25zIGFyZSBub3QgZW5hYmxlZC4gSW50ZWwtSU9N
TVUgZHJpdmVyIGRvZXNuJ3QNCj4gPiA+IHByb3ZpZGUNCj4gPiBhbg0KPiA+ID4gb3B0aW9uIHRv
IGRpc2FibGUgcXVldWVkLWludmFsaWRhdGlvbiB0aG91Z2gsIHdoZW4gdGhlIGhhcmR3YXJlIGlz
DQo+ID4gY2FwYWJsZS4gSWYgeW91DQo+ID4gPiByZWFsbHkgd2FudCB0byB0cnksIHR3ZWFrIHRo
ZSBjb2RlIGluIGludGVsX2lvbW11X2luaXRfcWkuDQo+ID4gPg0KPiA+DQo+ID4gSGkgS2V2aW4s
DQo+ID4NCj4gPiBUaGFua3MgdG8gcG9pbnQgb3V0IHRoaXMuIERvIHlvdSBoYXZlIGFueSBpZGVh
cyBhYm91dCB0aGlzIHByb2JsZW0gPyBJDQo+ID4gdHJpZWQgdG8gZGVzY3JpcHQgdGhlIHByb2Js
ZW0gbXVjaCBjbGVhciBpbiBteSByZXBseSB0byBBbGV4LCBob3BlIHlvdQ0KPiA+IGNvdWxkIGhh
dmUgYSBsb29rIGlmIHlvdSdyZSBpbnRlcmVzdGVkLg0KPiA+DQo+IA0KPiBJIGFncmVlIHdpdGgg
TmFkYXYuIExvb2tzIHRoaXMgaW1wbGllcyBzb21lIHN0YWxlIHBhZ2luZyBzdHJ1Y3R1cmUgY2Fj
aGUgZW50cnkgKGUuZy4NCj4gUE1EKSBpcyBub3QgaW52YWxpZGF0ZWQgcHJvcGVybHkuIEl0J3Mg
YmV0dGVyIGlmIEJhb2x1IGNhbiByZXByb2R1Y2UgdGhpcyBwcm9ibGVtIGluDQo+IGhpcyBsb2Nh
bCBlbnZpcm9ubWVudCBhbmQgdGhlbiBkbyBtb3JlIGRlYnVnIHRvIGlkZW50aWZ5IHdoZXRoZXIg
aXQncyBhIHNvZnR3YXJlIG9yDQo+IGhhcmR3YXJlIGRlZmVjdC4NCj4gDQo+IGJ0dyB3aGF0IGlz
IHRoZSBkZXZpY2UgdW5kZXIgdGVzdD8gRG9lcyBpdCBzdXBwb3J0IEFUUz8NCj4gDQoNClRoZSBk
ZXZpY2UgaXMgb3VyIG9mZmxvYWQgY2FyZCwgaXQgZG9lcyBub3Qgc3VwcG9ydCBBVFMgY2FwLg0K
DQo+IFRoYW5rcw0KPiBLZXZpbg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2lvbW11
