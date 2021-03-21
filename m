Return-Path: <SRS0=mXGD=IT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF116C433C1
	for <iommu@archiver.kernel.org>; Sun, 21 Mar 2021 23:51:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C76661944
	for <iommu@archiver.kernel.org>; Sun, 21 Mar 2021 23:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C76661944
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0827D4028F;
	Sun, 21 Mar 2021 23:51:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0sULI4g_bPxi; Sun, 21 Mar 2021 23:51:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id BA3894028B;
	Sun, 21 Mar 2021 23:51:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78737C000A;
	Sun, 21 Mar 2021 23:51:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79C7AC0001
 for <iommu@lists.linux-foundation.org>; Sun, 21 Mar 2021 23:51:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6095E605FD
 for <iommu@lists.linux-foundation.org>; Sun, 21 Mar 2021 23:51:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uLyjY0XIfhJa for <iommu@lists.linux-foundation.org>;
 Sun, 21 Mar 2021 23:51:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 45625605FC
 for <iommu@lists.linux-foundation.org>; Sun, 21 Mar 2021 23:51:33 +0000 (UTC)
Received: from DGGEML401-HUB.china.huawei.com (unknown [172.30.72.56])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4F3Z830zb8zWNs2;
 Mon, 22 Mar 2021 07:48:19 +0800 (CST)
Received: from dggpemm500011.china.huawei.com (7.185.36.110) by
 DGGEML401-HUB.china.huawei.com (10.3.17.32) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Mon, 22 Mar 2021 07:51:26 +0800
Received: from dggpeml500016.china.huawei.com (7.185.36.70) by
 dggpemm500011.china.huawei.com (7.185.36.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 22 Mar 2021 07:51:26 +0800
Received: from dggpeml500016.china.huawei.com ([7.185.36.70]) by
 dggpeml500016.china.huawei.com ([7.185.36.70]) with mapi id 15.01.2106.013;
 Mon, 22 Mar 2021 07:51:26 +0800
From: "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)"
 <longpeng2@huawei.com>
To: Nadav Amit <nadav.amit@gmail.com>
Subject: =?utf-8?B?UkU6IEEgcHJvYmxlbSBvZiBJbnRlbCBJT01NVSBoYXJkd2FyZSDvvJ8=?=
Thread-Topic: =?utf-8?B?QSBwcm9ibGVtIG9mIEludGVsIElPTU1VIGhhcmR3YXJlIO+8nw==?=
Thread-Index: AQHXGtwEduPlUZeCNUCbiy3s/+KwAaqHJckAgADDZTCAAA0+AIABZ4Ng//+HOQCAAIduIP//gKoAgACMgPD///biAAC1Z3dw
Date: Sun, 21 Mar 2021 23:51:26 +0000
Message-ID: <ac1e9b4699c4438f80ab771e5fbb4ee9@huawei.com>
References: <670baaf8-4ff8-4e84-4be3-030b95ab5a5e@huawei.com>
 <FB4E11A5-84D4-4DAF-889E-FAA1BCD2E66F@gmail.com>
 <6a218e7fe42d41489d02f0b4e3ad2756@huawei.com>
 <98DB71EF-FF98-4509-85EC-26FF50825A58@gmail.com>
 <4d1c3bc0418e48b1b9d44799d65ea375@huawei.com>
 <MWHPR11MB18860801196A9319EBD96AF68C699@MWHPR11MB1886.namprd11.prod.outlook.com>
 <d7bb4ab26b8542c698926b7a0a3fc12c@huawei.com>
 <MWHPR11MB18861A144C085677931922018C699@MWHPR11MB1886.namprd11.prod.outlook.com>
 <e5b262c1ee14481ab68074be2a76b9d9@huawei.com>
 <55E334BA-C6D2-4892-9207-32654FBF4360@gmail.com>
In-Reply-To: <55E334BA-C6D2-4892-9207-32654FBF4360@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.151.207]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: chenjiashang <chenjiashang@huawei.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "will@kernel.org" <will@kernel.org>,
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

SGkgTmFkYXYsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmFkYXYg
QW1pdCBbbWFpbHRvOm5hZGF2LmFtaXRAZ21haWwuY29tXQ0KPiBTZW50OiBGcmlkYXksIE1hcmNo
IDE5LCAyMDIxIDEyOjQ2IEFNDQo+IFRvOiBMb25ncGVuZyAoTWlrZSwgQ2xvdWQgSW5mcmFzdHJ1
Y3R1cmUgU2VydmljZSBQcm9kdWN0IERlcHQuKQ0KPiA8bG9uZ3BlbmcyQGh1YXdlaS5jb20+DQo+
IENjOiBUaWFuLCBLZXZpbiA8a2V2aW4udGlhbkBpbnRlbC5jb20+OyBjaGVuamlhc2hhbmcNCj4g
PGNoZW5qaWFzaGFuZ0BodWF3ZWkuY29tPjsgRGF2aWQgV29vZGhvdXNlIDxkd213MkBpbmZyYWRl
YWQub3JnPjsNCj4gaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IExLTUwgPGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+Ow0KPiBhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbTsg
R29uZ2xlaSAoQXJlaSkgPGFyZWkuZ29uZ2xlaUBodWF3ZWkuY29tPjsNCj4gd2lsbEBrZXJuZWwu
b3JnDQo+IFN1YmplY3Q6IFJlOiBBIHByb2JsZW0gb2YgSW50ZWwgSU9NTVUgaGFyZHdhcmUg77yf
DQo+IA0KPiANCj4gDQo+ID4gT24gTWFyIDE4LCAyMDIxLCBhdCAyOjI1IEFNLCBMb25ncGVuZyAo
TWlrZSwgQ2xvdWQgSW5mcmFzdHJ1Y3R1cmUgU2VydmljZQ0KPiBQcm9kdWN0IERlcHQuKSA8bG9u
Z3BlbmcyQGh1YXdlaS5jb20+IHdyb3RlOg0KPiA+DQo+ID4NCj4gPg0KPiA+PiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBUaWFuLCBLZXZpbiBbbWFpbHRvOmtldmluLnRp
YW5AaW50ZWwuY29tXQ0KPiA+PiBTZW50OiBUaHVyc2RheSwgTWFyY2ggMTgsIDIwMjEgNDo1NiBQ
TQ0KPiA+PiBUbzogTG9uZ3BlbmcgKE1pa2UsIENsb3VkIEluZnJhc3RydWN0dXJlIFNlcnZpY2Ug
UHJvZHVjdCBEZXB0LikNCj4gPj4gPGxvbmdwZW5nMkBodWF3ZWkuY29tPjsgTmFkYXYgQW1pdCA8
bmFkYXYuYW1pdEBnbWFpbC5jb20+DQo+ID4+IENjOiBjaGVuamlhc2hhbmcgPGNoZW5qaWFzaGFu
Z0BodWF3ZWkuY29tPjsgRGF2aWQgV29vZGhvdXNlDQo+ID4+IDxkd213MkBpbmZyYWRlYWQub3Jn
PjsgaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IExLTUwNCj4gPj4gPGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbTsgR29uZ2xl
aQ0KPiA+PiAoQXJlaSkgPGFyZWkuZ29uZ2xlaUBodWF3ZWkuY29tPjsgd2lsbEBrZXJuZWwub3Jn
DQo+ID4+IFN1YmplY3Q6IFJFOiBBIHByb2JsZW0gb2YgSW50ZWwgSU9NTVUgaGFyZHdhcmUg77yf
DQo+ID4+DQo+ID4+PiBGcm9tOiBMb25ncGVuZyAoTWlrZSwgQ2xvdWQgSW5mcmFzdHJ1Y3R1cmUg
U2VydmljZSBQcm9kdWN0IERlcHQuKQ0KPiA+Pj4gPGxvbmdwZW5nMkBodWF3ZWkuY29tPg0KPiA+
Pj4NCj4gPj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+Pj4+IEZyb206IFRpYW4s
IEtldmluIFttYWlsdG86a2V2aW4udGlhbkBpbnRlbC5jb21dDQo+ID4+Pj4gU2VudDogVGh1cnNk
YXksIE1hcmNoIDE4LCAyMDIxIDQ6MjcgUE0NCj4gPj4+PiBUbzogTG9uZ3BlbmcgKE1pa2UsIENs
b3VkIEluZnJhc3RydWN0dXJlIFNlcnZpY2UgUHJvZHVjdCBEZXB0LikNCj4gPj4+PiA8bG9uZ3Bl
bmcyQGh1YXdlaS5jb20+OyBOYWRhdiBBbWl0IDxuYWRhdi5hbWl0QGdtYWlsLmNvbT4NCj4gPj4+
PiBDYzogY2hlbmppYXNoYW5nIDxjaGVuamlhc2hhbmdAaHVhd2VpLmNvbT47IERhdmlkIFdvb2Ro
b3VzZQ0KPiA+Pj4+IDxkd213MkBpbmZyYWRlYWQub3JnPjsgaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmc7IExLTUwNCj4gPj4+PiA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47
IGFsZXgud2lsbGlhbXNvbkByZWRoYXQuY29tOyBHb25nbGVpDQo+ID4+PiAoQXJlaSkNCj4gPj4+
PiA8YXJlaS5nb25nbGVpQGh1YXdlaS5jb20+OyB3aWxsQGtlcm5lbC5vcmcNCj4gPj4+PiBTdWJq
ZWN0OiBSRTogQSBwcm9ibGVtIG9mIEludGVsIElPTU1VIGhhcmR3YXJlIO+8nw0KPiA+Pj4+DQo+
ID4+Pj4+IEZyb206IGlvbW11IDxpb21tdS1ib3VuY2VzQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnPiBPbiBCZWhhbGYNCj4gPj4+Pj4gT2YgTG9uZ3BlbmcgKE1pa2UsIENsb3VkIEluZnJhc3Ry
dWN0dXJlIFNlcnZpY2UgUHJvZHVjdCBEZXB0LikNCj4gPj4+Pj4NCj4gPj4+Pj4+IDIuIENvbnNp
ZGVyIGVuc3VyaW5nIHRoYXQgdGhlIHByb2JsZW0gaXMgbm90IHNvbWVob3cgcmVsYXRlZCB0bw0K
PiA+Pj4+Pj4gcXVldWVkIGludmFsaWRhdGlvbnMuIFRyeSB0byB1c2UgX19pb21tdV9mbHVzaF9p
b3RsYigpIGluc3RlYWQgb2YNCj4gPj4+PiBxaV9mbHVzaF9pb3RsYigpLg0KPiA+Pj4+Pj4NCj4g
Pj4+Pj4NCj4gPj4+Pj4gSSB0cmllZCB0byBmb3JjZSB0byB1c2UgX19pb21tdV9mbHVzaF9pb3Rs
YigpLCBidXQgbWF5YmUgc29tZXRoaW5nDQo+ID4+Pj4+IHdyb25nLCB0aGUgc3lzdGVtIGNyYXNo
ZWQsIHNvIEkgcHJlZmVyIHRvIGxvd2VyIHRoZSBwcmlvcml0eSBvZg0KPiA+Pj4+PiB0aGlzDQo+
ID4+PiBvcGVyYXRpb24uDQo+ID4+Pj4+DQo+ID4+Pj4NCj4gPj4+PiBUaGUgVlQtZCBzcGVjIGNs
ZWFybHkgc2F5cyB0aGF0IHJlZ2lzdGVyLWJhc2VkIGludmFsaWRhdGlvbiBjYW4gYmUNCj4gPj4+
PiB1c2VkIG9ubHkNCj4gPj4+IHdoZW4NCj4gPj4+PiBxdWV1ZWQtaW52YWxpZGF0aW9ucyBhcmUg
bm90IGVuYWJsZWQuIEludGVsLUlPTU1VIGRyaXZlciBkb2Vzbid0DQo+ID4+Pj4gcHJvdmlkZQ0K
PiA+Pj4gYW4NCj4gPj4+PiBvcHRpb24gdG8gZGlzYWJsZSBxdWV1ZWQtaW52YWxpZGF0aW9uIHRo
b3VnaCwgd2hlbiB0aGUgaGFyZHdhcmUgaXMNCj4gPj4+IGNhcGFibGUuIElmIHlvdQ0KPiA+Pj4+
IHJlYWxseSB3YW50IHRvIHRyeSwgdHdlYWsgdGhlIGNvZGUgaW4gaW50ZWxfaW9tbXVfaW5pdF9x
aS4NCj4gPj4+Pg0KPiA+Pj4NCj4gPj4+IEhpIEtldmluLA0KPiA+Pj4NCj4gPj4+IFRoYW5rcyB0
byBwb2ludCBvdXQgdGhpcy4gRG8geW91IGhhdmUgYW55IGlkZWFzIGFib3V0IHRoaXMgcHJvYmxl
bSA/DQo+ID4+PiBJIHRyaWVkIHRvIGRlc2NyaXB0IHRoZSBwcm9ibGVtIG11Y2ggY2xlYXIgaW4g
bXkgcmVwbHkgdG8gQWxleCwgaG9wZQ0KPiA+Pj4geW91IGNvdWxkIGhhdmUgYSBsb29rIGlmIHlv
dSdyZSBpbnRlcmVzdGVkLg0KPiA+Pj4NCj4gPj4NCj4gPj4gYnR3IEkgc2F3IHlvdSB1c2VkIDQu
MTgga2VybmVsIGluIHRoaXMgdGVzdC4gV2hhdCBhYm91dCBsYXRlc3Qga2VybmVsPw0KPiA+Pg0K
PiA+DQo+ID4gTm90IHRlc3QgeWV0LiBJdCdzIGhhcmQgdG8gdXBncmFkZSBrZXJuZWwgaW4gb3Vy
IGVudmlyb25tZW50Lg0KPiA+DQo+ID4+IEFsc28gb25lIHdheSB0byBzZXBhcmF0ZSBzdy9odyBi
dWcgaXMgdG8gdHJhY2UgdGhlIGxvdyBsZXZlbA0KPiA+PiBpbnRlcmZhY2UgKGUuZy4sDQo+ID4+
IHFpX2ZsdXNoX2lvdGxiKSB3aGljaCBhY3R1YWxseSBzZW5kcyBpbnZhbGlkYXRpb24gZGVzY3Jp
cHRvcnMgdG8gdGhlDQo+ID4+IElPTU1VIGhhcmR3YXJlLiBDaGVjayB0aGUgd2luZG93IGJldHdl
ZW4gYikgYW5kIGMpIGFuZCBzZWUgd2hldGhlcg0KPiA+PiB0aGUgc29mdHdhcmUgZG9lcyB0aGUg
cmlnaHQgdGhpbmcgYXMgZXhwZWN0ZWQgdGhlcmUuDQo+ID4+DQo+ID4NCj4gPiBXZSBhZGQgc29t
ZSBsb2cgaW4gaW9tbXUgZHJpdmVyIHRoZXNlIGRheXMsIHRoZSBzb2Z0d2FyZSBzZWVtcyBmaW5l
Lg0KPiA+IEJ1dCB3ZSBkaWRuJ3QgbG9vayBpbnNpZGUgdGhlIHFpX3N1Ym1pdF9zeW5jIHlldCwg
SSdsbCB0cnkgaXQgdG9uaWdodC4NCj4gDQo+IFNvIGhlcmUgaXMgbXkgZ3Vlc3M6DQo+IA0KPiBJ
bnRlbCBwcm9iYWJseSB1c2VkIGFzIGEgYmFzaXMgZm9yIHRoZSBJT1RMQiBhbiBpbXBsZW1lbnRh
dGlvbiBvZiBzb21lIG90aGVyDQo+IChyZWd1bGFyKSBUTEIgZGVzaWduLg0KPiANCj4gSW50ZWwg
U0RNIHNheXMgcmVnYXJkaW5nIFRMQnMgKDQuMTAuNC4yIOKAnFJlY29tbWVuZGVkIEludmFsaWRh
dGlvbuKAnSk6DQo+IA0KPiAiU29mdHdhcmUgd2lzaGluZyB0byBwcmV2ZW50IHRoaXMgdW5jZXJ0
YWludHkgc2hvdWxkIG5vdCB3cml0ZSB0byBhDQo+IHBhZ2luZy1zdHJ1Y3R1cmUgZW50cnkgaW4g
YSB3YXkgdGhhdCB3b3VsZCBjaGFuZ2UsIGZvciBhbnkgbGluZWFyIGFkZHJlc3MsIGJvdGggdGhl
DQo+IHBhZ2Ugc2l6ZSBhbmQgZWl0aGVyIHRoZSBwYWdlIGZyYW1lLCBhY2Nlc3MgcmlnaHRzLCBv
ciBvdGhlciBhdHRyaWJ1dGVzLuKAnQ0KPiANCj4gDQo+IE5vdyB0aGUgYWZvcmVtZW50aW9uZWQg
dW5jZXJ0YWludHkgaXMgYSBiaXQgZGlmZmVyZW50IChtdWx0aXBsZQ0KPiAqdmFsaWQqIHRyYW5z
bGF0aW9ucyBvZiBhIHNpbmdsZSBhZGRyZXNzKS4gWWV0LCBwZXJoYXBzIHRoaXMgaXMgeWV0IGFu
b3RoZXIgdGhpbmcgdGhhdA0KPiBtaWdodCBoYXBwZW4uDQo+IA0KPiBGcm9tIGEgYnJpZWYgbG9v
ayBvbiB0aGUgaGFuZGxpbmcgb2YgTU1VIChub3QgSU9NTVUpIGh1Z2VwYWdlcyBpbiBMaW51eCwg
aW5kZWVkDQo+IHRoZSBQTUQgaXMgZmlyc3QgY2xlYXJlZCBhbmQgZmx1c2hlZCBiZWZvcmUgYSBu
ZXcgdmFsaWQgUE1EIGlzIHNldC4gVGhpcyBpcyBwb3NzaWJsZQ0KPiBmb3IgTU1VcyBzaW5jZSB0
aGV5IGFsbG93IHRoZSBzb2Z0d2FyZSB0byBoYW5kbGUgc3B1cmlvdXMgcGFnZS1mYXVsdHMgZ3Jh
Y2VmdWxseS4NCj4gVGhpcyBpcyBub3QgdGhlIGNhc2UgZm9yIHRoZSBJT01NVSB0aG91Z2ggKHdp
dGhvdXQgUFJJKS4NCj4gDQoNCkJ1dCBpbiBteSBjYXNlLCB0aGUgZmx1c2hfaW90bGIgaXMgY2Fs
bGVkIGFmdGVyIHRoZSByYW5nZSBvZiAoMHgwLCAweGEwMDAwKSBpcyB1bm1hcHBlZCwNCkkndmUg
bm8gaWRlYSB3aHkgdGhpcyBpbnZhbGlkYXRpb24gaXNuJ3QgZWZmZWN0aXZlIGV4Y2VwdCBJJ3Zl
IG5vdCBsb29rIGluc2lkZSB0aGUgcWkgeWV0LCBidXQNCnRoZXJlIGlzIG5vIGNvbXBsYWludHMg
ZnJvbSB0aGUgZHJpdmVyLg0KDQpDb3VsZCB5b3UgcGxlYXNlIHBvaW50IG91dCB0aGUgY29kZSBv
ZiBNTVUgeW91IG1lbnRpb25lZCBhYm92ZT8gSW4gTU1VIGNvZGUsIGlzIGl0DQpwb3NzaWJsZSB0
aGF0IGFsbCB0aGUgZW50cmllcyBvZiB0aGUgUFRFIGFyZSBhbGwgbm90LXByZXNlbnQgYnV0IHRo
ZSBQTUQgZW50cnkgaXMgc3RpbGwgcHJlc2VudD8NCg0KKlBhZ2UgdGFibGUgYWZ0ZXIgKDB4MCwg
MHhhMDAwMCkgaXMgdW5tYXBwZWQ6DQpQTUw0OiAweCAgICAgIDFhMzRmYmIwMDMNCiAgUERQRTog
MHggICAgICAxYTM0ZmJiMDAzDQogICBQREU6IDB4ICAgICAgMWEzNGZiZjAwMw0KICAgIFBURTog
MHggICAgICAgICAgICAgICAwDQoNCipQYWdlIHRhYmxlIGFmdGVyICgweDAsIDB4YzAwMDAwMDAp
IGlzIG1hcHBlZDoNClBNTDQ6IDB4ICAgICAgMWEzNGZiYjAwMw0KICBQRFBFOiAweCAgICAgIDFh
MzRmYmIwMDMNCiAgIFBERTogMHggICAgICAgMTVlYzAwODgzDQoNCj4gTm90IHN1cmUgdGhpcyBl
eHBsYWlucyBldmVyeXRoaW5nIHRob3VnaC4gSWYgdGhhdCBpcyB0aGUgcHJvYmxlbSwgdGhlbiBk
dXJpbmcgYQ0KPiBtYXBwaW5nIHRoYXQgY2hhbmdlcyBwYWdlLXNpemVzLCBhIFRMQiBmbHVzaCBp
cyBuZWVkZWQsIHNpbWlsYXJseSB0byB0aGUgb25lDQo+IExvbmdwZW5nIGRpZCBtYW51YWxseS4N
Cj4gDQoNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
aW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
