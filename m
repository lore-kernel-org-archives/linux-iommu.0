Return-Path: <SRS0=kdPY=IP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DD4C433E0
	for <iommu@archiver.kernel.org>; Wed, 17 Mar 2021 09:36:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E6AB64F37
	for <iommu@archiver.kernel.org>; Wed, 17 Mar 2021 09:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E6AB64F37
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B418B4BA7C;
	Wed, 17 Mar 2021 09:36:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NiBgf4rNP1Kh; Wed, 17 Mar 2021 09:36:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 47CEF4ADC2;
	Wed, 17 Mar 2021 09:36:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1CE0AC000A;
	Wed, 17 Mar 2021 09:36:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C7CCC0001
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 09:35:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4DB04600D4
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 09:35:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YpPOPNJhCSuw for <iommu@lists.linux-foundation.org>;
 Wed, 17 Mar 2021 09:35:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 761B46F4F9
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 09:35:57 +0000 (UTC)
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4F0lN81yZtz5dXG;
 Wed, 17 Mar 2021 17:34:00 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Wed, 17 Mar 2021 17:35:51 +0800
Received: from dggpeml500016.china.huawei.com (7.185.36.70) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 17 Mar 2021 17:35:51 +0800
Received: from dggpeml500016.china.huawei.com ([7.185.36.70]) by
 dggpeml500016.china.huawei.com ([7.185.36.70]) with mapi id 15.01.2106.013;
 Wed, 17 Mar 2021 17:35:51 +0800
From: "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)"
 <longpeng2@huawei.com>
To: Nadav Amit <nadav.amit@gmail.com>
Subject: =?utf-8?B?UkU6IEEgcHJvYmxlbSBvZiBJbnRlbCBJT01NVSBoYXJkd2FyZSDvvJ8=?=
Thread-Topic: =?utf-8?B?QSBwcm9ibGVtIG9mIEludGVsIElPTU1VIGhhcmR3YXJlIO+8nw==?=
Thread-Index: AQHXGtwEduPlUZeCNUCbiy3s/+KwAaqHJckAgADDZTA=
Date: Wed, 17 Mar 2021 09:35:51 +0000
Message-ID: <6a218e7fe42d41489d02f0b4e3ad2756@huawei.com>
References: <670baaf8-4ff8-4e84-4be3-030b95ab5a5e@huawei.com>
 <FB4E11A5-84D4-4DAF-889E-FAA1BCD2E66F@gmail.com>
In-Reply-To: <FB4E11A5-84D4-4DAF-889E-FAA1BCD2E66F@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.151.207]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: chenjiashang <chenjiashang@huawei.com>,
 David Woodhouse <dwmw2@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 "will@kernel.org" <will@kernel.org>
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

SGkgTmFkYXYsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmFkYXYg
QW1pdCBbbWFpbHRvOm5hZGF2LmFtaXRAZ21haWwuY29tXQ0KPiBTZW50OiBXZWRuZXNkYXksIE1h
cmNoIDE3LCAyMDIxIDE6NDYgUE0NCj4gVG86IExvbmdwZW5nIChNaWtlLCBDbG91ZCBJbmZyYXN0
cnVjdHVyZSBTZXJ2aWNlIFByb2R1Y3QgRGVwdC4pDQo+IDxsb25ncGVuZzJAaHVhd2VpLmNvbT4N
Cj4gQ2M6IERhdmlkIFdvb2Rob3VzZSA8ZHdtdzJAaW5mcmFkZWFkLm9yZz47IEx1IEJhb2x1DQo+
IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+OyBKb2VyZyBSb2VkZWwgPGpvcm9AOGJ5dGVzLm9y
Zz47IHdpbGxAa2VybmVsLm9yZzsNCj4gYWxleC53aWxsaWFtc29uQHJlZGhhdC5jb207IGNoZW5q
aWFzaGFuZyA8Y2hlbmppYXNoYW5nQGh1YXdlaS5jb20+Ow0KPiBpb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZzsgR29uZ2xlaSAoQXJlaSkgPGFyZWkuZ29uZ2xlaUBodWF3ZWkuY29tPjsN
Cj4gTEtNTCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IEEg
cHJvYmxlbSBvZiBJbnRlbCBJT01NVSBoYXJkd2FyZSDvvJ8NCj4gDQo+IA0KPiANCj4gPiBPbiBN
YXIgMTYsIDIwMjEsIGF0IDg6MTYgUE0sIExvbmdwZW5nIChNaWtlLCBDbG91ZCBJbmZyYXN0cnVj
dHVyZSBTZXJ2aWNlDQo+IFByb2R1Y3QgRGVwdC4pIDxsb25ncGVuZzJAaHVhd2VpLmNvbT4gd3Jv
dGU6DQo+ID4NCj4gPiBIaSBndXlzLA0KPiA+DQo+ID4gV2UgZmluZCB0aGUgSW50ZWwgaW9tbXUg
Y2FjaGUgKGkuZS4gaW90bGIpIG1heWJlIHdvcmtzIHdyb25nIGluIGENCj4gPiBzcGVjaWFsIHNp
dHVhdGlvbiwgaXQgd291bGQgY2F1c2UgRE1BIGZhaWxzIG9yIGdldCB3cm9uZyBkYXRhLg0KPiA+
DQo+ID4gVGhlIHJlcHJvZHVjZXIgKGJhc2VkIG9uIEFsZXgncyB2ZmlvIHRlc3RzdWl0ZVsxXSkg
aXMgaW4gYXR0YWNobWVudCwNCj4gPiBpdCBjYW4gcmVwcm9kdWNlIHRoZSBwcm9ibGVtIHdpdGgg
aGlnaCBwcm9iYWJpbGl0eSAofjUwJSkuDQo+IA0KPiBJIHNhdyBMdSByZXBsaWVkLCBhbmQgaGUg
aXMgbXVjaCBtb3JlIGtub3dsZWRnYWJsZSB0aGFuIEkgYW0gKEkgd2FzIGp1c3QgaW50cmlndWVk
DQo+IGJ5IHlvdXIgZW1haWwpLg0KPiANCj4gSG93ZXZlciwgaWYgSSB3ZXJlIHlvdSBJIHdvdWxk
IHRyeSBhbHNvIHRvIHJlbW92ZSBzb21lIOKAnG9wdGltaXphdGlvbnPigJ0gdG8gbG9vayBmb3IN
Cj4gdGhlIHJvb3QtY2F1c2UgKGUuZy4sIHVzZSBkb21haW4gc3BlY2lmaWMgaW52YWxpZGF0aW9u
cyBpbnN0ZWFkIG9mIHBhZ2Utc3BlY2lmaWMpLg0KPiANCg0KR29vZCBzdWdnZXN0aW9uISBCdXQg
d2UgZGlkIGl0IHRoZXNlIGRheXMsIHdlIHRyaWVkIHRvIHVzZSBnbG9iYWwgaW52YWxpZGF0aW9u
cyBhcyBmb2xsb3c6DQoJCWlvbW11LT5mbHVzaC5mbHVzaF9pb3RsYihpb21tdSwgZGlkLCAwLCAw
LA0KCQkJCQkJRE1BX1RMQl9EU0lfRkxVU0gpOw0KQnV0IGNhbiBub3QgcmVzb2x2ZSB0aGUgcHJv
YmxlbS4NCg0KPiBUaGUgZmlyc3QgdGhpbmcgdGhhdCBjb21lcyB0byBteSBtaW5kIGlzIHRoZSBp
bnZhbGlkYXRpb24gaGludCAoaWgpIGluDQo+IGlvbW11X2ZsdXNoX2lvdGxiX3BzaSgpLiBJIHdv
dWxkIHJlbW92ZSBpdCB0byBzZWUgd2hldGhlciB5b3UgZ2V0IHRoZSBmYWlsdXJlDQo+IHdpdGhv
dXQgaXQuDQoNCldlIGFsc28gbm90aWNlIHRoZSBJSCwgYnV0IHRoZSBJSCBpcyBhbHdheXMgWkVS
TyBpbiBvdXIgY2FzZSwgYXMgdGhlIHNwZWMgc2F5czoNCicnJw0KUGFnaW5nLXN0cnVjdHVyZS1j
YWNoZSBlbnRyaWVzIGNhY2hpbmcgc2Vjb25kLWxldmVsIG1hcHBpbmdzIGFzc29jaWF0ZWQgd2l0
aCB0aGUgc3BlY2lmaWVkDQpkb21haW4taWQgYW5kIHRoZSBzZWNvbmQtbGV2ZWwtaW5wdXQtYWRk
cmVzcyByYW5nZSBhcmUgaW52YWxpZGF0ZWQsIGlmIHRoZSBJbnZhbGlkYXRpb24gSGludA0KKElI
KSBmaWVsZCBpcyBDbGVhci4NCicnJw0KDQpJdCBzZWVtcyB0aGUgc29mdHdhcmUgaXMgZXZlcnl0
aGluZyBmaW5lLCBzbyB3ZSd2ZSBubyBjaG9pY2UgYnV0IHRvIHN1c3BlY3QgdGhlIGhhcmR3YXJl
Lg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUg
bWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
