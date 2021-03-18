Return-Path: <SRS0=56b4=IQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2CCC433DB
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 09:25:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00B1A64F24
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 09:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B1A64F24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A1C7F4ED6C;
	Thu, 18 Mar 2021 09:25:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DORGdlLrCb_A; Thu, 18 Mar 2021 09:25:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8787D4ED58;
	Thu, 18 Mar 2021 09:25:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5AAB4C000A;
	Thu, 18 Mar 2021 09:25:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1F1DC0001
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 09:25:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A808D60650
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 09:25:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8pQ3iQ9wXKft for <iommu@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 09:25:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3755E6064F
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 09:25:46 +0000 (UTC)
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4F1M651kgfzYKr5;
 Thu, 18 Mar 2021 17:23:57 +0800 (CST)
Received: from dggpemm100010.china.huawei.com (7.185.36.24) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 18 Mar 2021 17:25:42 +0800
Received: from dggpeml500016.china.huawei.com (7.185.36.70) by
 dggpemm100010.china.huawei.com (7.185.36.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 18 Mar 2021 17:25:42 +0800
Received: from dggpeml500016.china.huawei.com ([7.185.36.70]) by
 dggpeml500016.china.huawei.com ([7.185.36.70]) with mapi id 15.01.2106.013;
 Thu, 18 Mar 2021 17:25:42 +0800
From: "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)"
 <longpeng2@huawei.com>
To: "Tian, Kevin" <kevin.tian@intel.com>, Nadav Amit <nadav.amit@gmail.com>
Subject: =?utf-8?B?UkU6IEEgcHJvYmxlbSBvZiBJbnRlbCBJT01NVSBoYXJkd2FyZSDvvJ8=?=
Thread-Topic: =?utf-8?B?QSBwcm9ibGVtIG9mIEludGVsIElPTU1VIGhhcmR3YXJlIO+8nw==?=
Thread-Index: AQHXGtwEduPlUZeCNUCbiy3s/+KwAaqHJckAgADDZTCAAA0+AIABZ4Ng//+HOQCAAIduIP//gKoAgACMgPA=
Date: Thu, 18 Mar 2021 09:25:41 +0000
Message-ID: <e5b262c1ee14481ab68074be2a76b9d9@huawei.com>
References: <670baaf8-4ff8-4e84-4be3-030b95ab5a5e@huawei.com>
 <FB4E11A5-84D4-4DAF-889E-FAA1BCD2E66F@gmail.com>
 <6a218e7fe42d41489d02f0b4e3ad2756@huawei.com>
 <98DB71EF-FF98-4509-85EC-26FF50825A58@gmail.com>
 <4d1c3bc0418e48b1b9d44799d65ea375@huawei.com>
 <MWHPR11MB18860801196A9319EBD96AF68C699@MWHPR11MB1886.namprd11.prod.outlook.com>
 <d7bb4ab26b8542c698926b7a0a3fc12c@huawei.com>
 <MWHPR11MB18861A144C085677931922018C699@MWHPR11MB1886.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB18861A144C085677931922018C699@MWHPR11MB1886.namprd11.prod.outlook.com>
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
MDIxIDQ6NTYgUE0NCj4gVG86IExvbmdwZW5nIChNaWtlLCBDbG91ZCBJbmZyYXN0cnVjdHVyZSBT
ZXJ2aWNlIFByb2R1Y3QgRGVwdC4pDQo+IDxsb25ncGVuZzJAaHVhd2VpLmNvbT47IE5hZGF2IEFt
aXQgPG5hZGF2LmFtaXRAZ21haWwuY29tPg0KPiBDYzogY2hlbmppYXNoYW5nIDxjaGVuamlhc2hh
bmdAaHVhd2VpLmNvbT47IERhdmlkIFdvb2Rob3VzZQ0KPiA8ZHdtdzJAaW5mcmFkZWFkLm9yZz47
IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBMS01MDQo+IDxsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnPjsgYWxleC53aWxsaWFtc29uQHJlZGhhdC5jb207IEdvbmdsZWkgKEFy
ZWkpDQo+IDxhcmVpLmdvbmdsZWlAaHVhd2VpLmNvbT47IHdpbGxAa2VybmVsLm9yZw0KPiBTdWJq
ZWN0OiBSRTogQSBwcm9ibGVtIG9mIEludGVsIElPTU1VIGhhcmR3YXJlIO+8nw0KPiANCj4gPiBG
cm9tOiBMb25ncGVuZyAoTWlrZSwgQ2xvdWQgSW5mcmFzdHJ1Y3R1cmUgU2VydmljZSBQcm9kdWN0
IERlcHQuKQ0KPiA+IDxsb25ncGVuZzJAaHVhd2VpLmNvbT4NCj4gPg0KPiA+ID4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFRpYW4sIEtldmluIFttYWlsdG86a2V2aW4u
dGlhbkBpbnRlbC5jb21dDQo+ID4gPiBTZW50OiBUaHVyc2RheSwgTWFyY2ggMTgsIDIwMjEgNDoy
NyBQTQ0KPiA+ID4gVG86IExvbmdwZW5nIChNaWtlLCBDbG91ZCBJbmZyYXN0cnVjdHVyZSBTZXJ2
aWNlIFByb2R1Y3QgRGVwdC4pDQo+ID4gPiA8bG9uZ3BlbmcyQGh1YXdlaS5jb20+OyBOYWRhdiBB
bWl0IDxuYWRhdi5hbWl0QGdtYWlsLmNvbT4NCj4gPiA+IENjOiBjaGVuamlhc2hhbmcgPGNoZW5q
aWFzaGFuZ0BodWF3ZWkuY29tPjsgRGF2aWQgV29vZGhvdXNlDQo+ID4gPiA8ZHdtdzJAaW5mcmFk
ZWFkLm9yZz47IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBMS01MDQo+ID4gPiA8
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IGFsZXgud2lsbGlhbXNvbkByZWRoYXQuY29t
OyBHb25nbGVpDQo+ID4gKEFyZWkpDQo+ID4gPiA8YXJlaS5nb25nbGVpQGh1YXdlaS5jb20+OyB3
aWxsQGtlcm5lbC5vcmcNCj4gPiA+IFN1YmplY3Q6IFJFOiBBIHByb2JsZW0gb2YgSW50ZWwgSU9N
TVUgaGFyZHdhcmUg77yfDQo+ID4gPg0KPiA+ID4gPiBGcm9tOiBpb21tdSA8aW9tbXUtYm91bmNl
c0BsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZz4gT24gQmVoYWxmDQo+ID4gPiA+IE9mIExvbmdw
ZW5nIChNaWtlLCBDbG91ZCBJbmZyYXN0cnVjdHVyZSBTZXJ2aWNlIFByb2R1Y3QgRGVwdC4pDQo+
ID4gPiA+DQo+ID4gPiA+ID4gMi4gQ29uc2lkZXIgZW5zdXJpbmcgdGhhdCB0aGUgcHJvYmxlbSBp
cyBub3Qgc29tZWhvdyByZWxhdGVkIHRvDQo+ID4gPiA+ID4gcXVldWVkIGludmFsaWRhdGlvbnMu
IFRyeSB0byB1c2UgX19pb21tdV9mbHVzaF9pb3RsYigpIGluc3RlYWQNCj4gPiA+ID4gPiBvZg0K
PiA+ID4gcWlfZmx1c2hfaW90bGIoKS4NCj4gPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBJIHRy
aWVkIHRvIGZvcmNlIHRvIHVzZSBfX2lvbW11X2ZsdXNoX2lvdGxiKCksIGJ1dCBtYXliZSBzb21l
dGhpbmcNCj4gPiA+ID4gd3JvbmcsIHRoZSBzeXN0ZW0gY3Jhc2hlZCwgc28gSSBwcmVmZXIgdG8g
bG93ZXIgdGhlIHByaW9yaXR5IG9mDQo+ID4gPiA+IHRoaXMNCj4gPiBvcGVyYXRpb24uDQo+ID4g
PiA+DQo+ID4gPg0KPiA+ID4gVGhlIFZULWQgc3BlYyBjbGVhcmx5IHNheXMgdGhhdCByZWdpc3Rl
ci1iYXNlZCBpbnZhbGlkYXRpb24gY2FuIGJlDQo+ID4gPiB1c2VkIG9ubHkNCj4gPiB3aGVuDQo+
ID4gPiBxdWV1ZWQtaW52YWxpZGF0aW9ucyBhcmUgbm90IGVuYWJsZWQuIEludGVsLUlPTU1VIGRy
aXZlciBkb2Vzbid0DQo+ID4gPiBwcm92aWRlDQo+ID4gYW4NCj4gPiA+IG9wdGlvbiB0byBkaXNh
YmxlIHF1ZXVlZC1pbnZhbGlkYXRpb24gdGhvdWdoLCB3aGVuIHRoZSBoYXJkd2FyZSBpcw0KPiA+
IGNhcGFibGUuIElmIHlvdQ0KPiA+ID4gcmVhbGx5IHdhbnQgdG8gdHJ5LCB0d2VhayB0aGUgY29k
ZSBpbiBpbnRlbF9pb21tdV9pbml0X3FpLg0KPiA+ID4NCj4gPg0KPiA+IEhpIEtldmluLA0KPiA+
DQo+ID4gVGhhbmtzIHRvIHBvaW50IG91dCB0aGlzLiBEbyB5b3UgaGF2ZSBhbnkgaWRlYXMgYWJv
dXQgdGhpcyBwcm9ibGVtID8gSQ0KPiA+IHRyaWVkIHRvIGRlc2NyaXB0IHRoZSBwcm9ibGVtIG11
Y2ggY2xlYXIgaW4gbXkgcmVwbHkgdG8gQWxleCwgaG9wZSB5b3UNCj4gPiBjb3VsZCBoYXZlIGEg
bG9vayBpZiB5b3UncmUgaW50ZXJlc3RlZC4NCj4gPg0KPiANCj4gYnR3IEkgc2F3IHlvdSB1c2Vk
IDQuMTgga2VybmVsIGluIHRoaXMgdGVzdC4gV2hhdCBhYm91dCBsYXRlc3Qga2VybmVsPw0KPiAN
Cg0KTm90IHRlc3QgeWV0LiBJdCdzIGhhcmQgdG8gdXBncmFkZSBrZXJuZWwgaW4gb3VyIGVudmly
b25tZW50Lg0KDQo+IEFsc28gb25lIHdheSB0byBzZXBhcmF0ZSBzdy9odyBidWcgaXMgdG8gdHJh
Y2UgdGhlIGxvdyBsZXZlbCBpbnRlcmZhY2UgKGUuZy4sDQo+IHFpX2ZsdXNoX2lvdGxiKSB3aGlj
aCBhY3R1YWxseSBzZW5kcyBpbnZhbGlkYXRpb24gZGVzY3JpcHRvcnMgdG8gdGhlIElPTU1VDQo+
IGhhcmR3YXJlLiBDaGVjayB0aGUgd2luZG93IGJldHdlZW4gYikgYW5kIGMpIGFuZCBzZWUgd2hl
dGhlciB0aGUgc29mdHdhcmUgZG9lcw0KPiB0aGUgcmlnaHQgdGhpbmcgYXMgZXhwZWN0ZWQgdGhl
cmUuDQo+IA0KDQpXZSBhZGQgc29tZSBsb2cgaW4gaW9tbXUgZHJpdmVyIHRoZXNlIGRheXMsIHRo
ZSBzb2Z0d2FyZSBzZWVtcyBmaW5lLiBCdXQgd2UNCmRpZG4ndCBsb29rIGluc2lkZSB0aGUgcWlf
c3VibWl0X3N5bmMgeWV0LCBJJ2xsIHRyeSBpdCB0b25pZ2h0Lg0KDQo+IFRoYW5rcw0KPiBLZXZp
bg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUg
bWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
