Return-Path: <SRS0=3kXM=IU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B18C433DB
	for <iommu@archiver.kernel.org>; Mon, 22 Mar 2021 00:28:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9386D61929
	for <iommu@archiver.kernel.org>; Mon, 22 Mar 2021 00:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9386D61929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B3BB60647;
	Mon, 22 Mar 2021 00:28:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GIAagId-r2_T; Mon, 22 Mar 2021 00:28:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB9866061A;
	Mon, 22 Mar 2021 00:28:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94C6DC000B;
	Mon, 22 Mar 2021 00:28:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 291D1C0001
 for <iommu@lists.linux-foundation.org>; Mon, 22 Mar 2021 00:27:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0A1E140335
 for <iommu@lists.linux-foundation.org>; Mon, 22 Mar 2021 00:27:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mc__yhgPiITc for <iommu@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 00:27:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8737640333
 for <iommu@lists.linux-foundation.org>; Mon, 22 Mar 2021 00:27:56 +0000 (UTC)
Received: from dggeml406-hub.china.huawei.com (unknown [172.30.72.53])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4F3Zy501kYz14714;
 Mon, 22 Mar 2021 08:24:45 +0800 (CST)
Received: from dggpemm500009.china.huawei.com (7.185.36.225) by
 dggeml406-hub.china.huawei.com (10.3.17.50) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Mon, 22 Mar 2021 08:27:52 +0800
Received: from dggpeml500016.china.huawei.com (7.185.36.70) by
 dggpemm500009.china.huawei.com (7.185.36.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 22 Mar 2021 08:27:52 +0800
Received: from dggpeml500016.china.huawei.com ([7.185.36.70]) by
 dggpeml500016.china.huawei.com ([7.185.36.70]) with mapi id 15.01.2106.013;
 Mon, 22 Mar 2021 08:27:52 +0800
From: "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)"
 <longpeng2@huawei.com>
To: Nadav Amit <nadav.amit@gmail.com>
Subject: =?utf-8?B?UkU6IEEgcHJvYmxlbSBvZiBJbnRlbCBJT01NVSBoYXJkd2FyZSDvvJ8=?=
Thread-Topic: =?utf-8?B?QSBwcm9ibGVtIG9mIEludGVsIElPTU1VIGhhcmR3YXJlIO+8nw==?=
Thread-Index: AQHXGtwEduPlUZeCNUCbiy3s/+KwAaqHJckAgADDZTCAAA0+AIABZ4Ng//+HOQCAAIduIP//gKoAgACMgPD///biAAC1Z3dwAAIzCpA=
Date: Mon, 22 Mar 2021 00:27:52 +0000
Message-ID: <3440f8216ece4af78cfb9809408c771e@huawei.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTG9uZ3BlbmcgKE1pa2Us
IENsb3VkIEluZnJhc3RydWN0dXJlIFNlcnZpY2UgUHJvZHVjdCBEZXB0LikNCj4gU2VudDogTW9u
ZGF5LCBNYXJjaCAyMiwgMjAyMSA3OjUxIEFNDQo+IFRvOiAnTmFkYXYgQW1pdCcgPG5hZGF2LmFt
aXRAZ21haWwuY29tPg0KPiBDYzogVGlhbiwgS2V2aW4gPGtldmluLnRpYW5AaW50ZWwuY29tPjsg
Y2hlbmppYXNoYW5nDQo+IDxjaGVuamlhc2hhbmdAaHVhd2VpLmNvbT47IERhdmlkIFdvb2Rob3Vz
ZSA8ZHdtdzJAaW5mcmFkZWFkLm9yZz47DQo+IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnOyBMS01MIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsNCj4gYWxleC53aWxsaWFt
c29uQHJlZGhhdC5jb207IEdvbmdsZWkgKEFyZWkpIDxhcmVpLmdvbmdsZWlAaHVhd2VpLmNvbT47
DQo+IHdpbGxAa2VybmVsLm9yZzsgJ0x1IEJhb2x1JyA8YmFvbHUubHVAbGludXguaW50ZWwuY29t
PjsgJ0pvZXJnIFJvZWRlbCcNCj4gPGpvcm9AOGJ5dGVzLm9yZz4NCj4gU3ViamVjdDogUkU6IEEg
cHJvYmxlbSBvZiBJbnRlbCBJT01NVSBoYXJkd2FyZSDvvJ8NCj4gDQo+IEhpIE5hZGF2LA0KPiAN
Cj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IE5hZGF2IEFtaXQgW21h
aWx0bzpuYWRhdi5hbWl0QGdtYWlsLmNvbV0NCj4gPiBTZW50OiBGcmlkYXksIE1hcmNoIDE5LCAy
MDIxIDEyOjQ2IEFNDQo+ID4gVG86IExvbmdwZW5nIChNaWtlLCBDbG91ZCBJbmZyYXN0cnVjdHVy
ZSBTZXJ2aWNlIFByb2R1Y3QgRGVwdC4pDQo+ID4gPGxvbmdwZW5nMkBodWF3ZWkuY29tPg0KPiA+
IENjOiBUaWFuLCBLZXZpbiA8a2V2aW4udGlhbkBpbnRlbC5jb20+OyBjaGVuamlhc2hhbmcNCj4g
PiA8Y2hlbmppYXNoYW5nQGh1YXdlaS5jb20+OyBEYXZpZCBXb29kaG91c2UgPGR3bXcyQGluZnJh
ZGVhZC5vcmc+Ow0KPiA+IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBMS01MIDxs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsNCj4gPiBhbGV4LndpbGxpYW1zb25AcmVkaGF0
LmNvbTsgR29uZ2xlaSAoQXJlaSkgPGFyZWkuZ29uZ2xlaUBodWF3ZWkuY29tPjsNCj4gPiB3aWxs
QGtlcm5lbC5vcmcNCj4gPiBTdWJqZWN0OiBSZTogQSBwcm9ibGVtIG9mIEludGVsIElPTU1VIGhh
cmR3YXJlIO+8nw0KPiA+DQo+ID4NCj4gPg0KPiA+ID4gT24gTWFyIDE4LCAyMDIxLCBhdCAyOjI1
IEFNLCBMb25ncGVuZyAoTWlrZSwgQ2xvdWQgSW5mcmFzdHJ1Y3R1cmUNCj4gPiA+IFNlcnZpY2UN
Cj4gPiBQcm9kdWN0IERlcHQuKSA8bG9uZ3BlbmcyQGh1YXdlaS5jb20+IHdyb3RlOg0KPiA+ID4N
Cj4gPiA+DQo+ID4gPg0KPiA+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPj4g
RnJvbTogVGlhbiwgS2V2aW4gW21haWx0bzprZXZpbi50aWFuQGludGVsLmNvbV0NCj4gPiA+PiBT
ZW50OiBUaHVyc2RheSwgTWFyY2ggMTgsIDIwMjEgNDo1NiBQTQ0KPiA+ID4+IFRvOiBMb25ncGVu
ZyAoTWlrZSwgQ2xvdWQgSW5mcmFzdHJ1Y3R1cmUgU2VydmljZSBQcm9kdWN0IERlcHQuKQ0KPiA+
ID4+IDxsb25ncGVuZzJAaHVhd2VpLmNvbT47IE5hZGF2IEFtaXQgPG5hZGF2LmFtaXRAZ21haWwu
Y29tPg0KPiA+ID4+IENjOiBjaGVuamlhc2hhbmcgPGNoZW5qaWFzaGFuZ0BodWF3ZWkuY29tPjsg
RGF2aWQgV29vZGhvdXNlDQo+ID4gPj4gPGR3bXcyQGluZnJhZGVhZC5vcmc+OyBpb21tdUBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZzsgTEtNTA0KPiA+ID4+IDxsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnPjsgYWxleC53aWxsaWFtc29uQHJlZGhhdC5jb207IEdvbmdsZWkNCj4gPiA+PiAo
QXJlaSkgPGFyZWkuZ29uZ2xlaUBodWF3ZWkuY29tPjsgd2lsbEBrZXJuZWwub3JnDQo+ID4gPj4g
U3ViamVjdDogUkU6IEEgcHJvYmxlbSBvZiBJbnRlbCBJT01NVSBoYXJkd2FyZSDvvJ8NCj4gPiA+
Pg0KPiA+ID4+PiBGcm9tOiBMb25ncGVuZyAoTWlrZSwgQ2xvdWQgSW5mcmFzdHJ1Y3R1cmUgU2Vy
dmljZSBQcm9kdWN0IERlcHQuKQ0KPiA+ID4+PiA8bG9uZ3BlbmcyQGh1YXdlaS5jb20+DQo+ID4g
Pj4+DQo+ID4gPj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4+Pj4gRnJvbTog
VGlhbiwgS2V2aW4gW21haWx0bzprZXZpbi50aWFuQGludGVsLmNvbV0NCj4gPiA+Pj4+IFNlbnQ6
IFRodXJzZGF5LCBNYXJjaCAxOCwgMjAyMSA0OjI3IFBNDQo+ID4gPj4+PiBUbzogTG9uZ3Blbmcg
KE1pa2UsIENsb3VkIEluZnJhc3RydWN0dXJlIFNlcnZpY2UgUHJvZHVjdCBEZXB0LikNCj4gPiA+
Pj4+IDxsb25ncGVuZzJAaHVhd2VpLmNvbT47IE5hZGF2IEFtaXQgPG5hZGF2LmFtaXRAZ21haWwu
Y29tPg0KPiA+ID4+Pj4gQ2M6IGNoZW5qaWFzaGFuZyA8Y2hlbmppYXNoYW5nQGh1YXdlaS5jb20+
OyBEYXZpZCBXb29kaG91c2UNCj4gPiA+Pj4+IDxkd213MkBpbmZyYWRlYWQub3JnPjsgaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IExLTUwNCj4gPiA+Pj4+IDxsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnPjsgYWxleC53aWxsaWFtc29uQHJlZGhhdC5jb207DQo+ID4gPj4+PiBH
b25nbGVpDQo+ID4gPj4+IChBcmVpKQ0KPiA+ID4+Pj4gPGFyZWkuZ29uZ2xlaUBodWF3ZWkuY29t
Pjsgd2lsbEBrZXJuZWwub3JnDQo+ID4gPj4+PiBTdWJqZWN0OiBSRTogQSBwcm9ibGVtIG9mIElu
dGVsIElPTU1VIGhhcmR3YXJlIO+8nw0KPiA+ID4+Pj4NCj4gPiA+Pj4+PiBGcm9tOiBpb21tdSA8
aW9tbXUtYm91bmNlc0BsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZz4gT24gQmVoYWxmDQo+ID4g
Pj4+Pj4gT2YgTG9uZ3BlbmcgKE1pa2UsIENsb3VkIEluZnJhc3RydWN0dXJlIFNlcnZpY2UgUHJv
ZHVjdCBEZXB0LikNCj4gPiA+Pj4+Pg0KPiA+ID4+Pj4+PiAyLiBDb25zaWRlciBlbnN1cmluZyB0
aGF0IHRoZSBwcm9ibGVtIGlzIG5vdCBzb21laG93IHJlbGF0ZWQgdG8NCj4gPiA+Pj4+Pj4gcXVl
dWVkIGludmFsaWRhdGlvbnMuIFRyeSB0byB1c2UgX19pb21tdV9mbHVzaF9pb3RsYigpIGluc3Rl
YWQNCj4gPiA+Pj4+Pj4gb2YNCj4gPiA+Pj4+IHFpX2ZsdXNoX2lvdGxiKCkuDQo+ID4gPj4+Pj4+
DQo+ID4gPj4+Pj4NCj4gPiA+Pj4+PiBJIHRyaWVkIHRvIGZvcmNlIHRvIHVzZSBfX2lvbW11X2Zs
dXNoX2lvdGxiKCksIGJ1dCBtYXliZQ0KPiA+ID4+Pj4+IHNvbWV0aGluZyB3cm9uZywgdGhlIHN5
c3RlbSBjcmFzaGVkLCBzbyBJIHByZWZlciB0byBsb3dlciB0aGUNCj4gPiA+Pj4+PiBwcmlvcml0
eSBvZiB0aGlzDQo+ID4gPj4+IG9wZXJhdGlvbi4NCj4gPiA+Pj4+Pg0KPiA+ID4+Pj4NCj4gPiA+
Pj4+IFRoZSBWVC1kIHNwZWMgY2xlYXJseSBzYXlzIHRoYXQgcmVnaXN0ZXItYmFzZWQgaW52YWxp
ZGF0aW9uIGNhbg0KPiA+ID4+Pj4gYmUgdXNlZCBvbmx5DQo+ID4gPj4+IHdoZW4NCj4gPiA+Pj4+
IHF1ZXVlZC1pbnZhbGlkYXRpb25zIGFyZSBub3QgZW5hYmxlZC4gSW50ZWwtSU9NTVUgZHJpdmVy
IGRvZXNuJ3QNCj4gPiA+Pj4+IHByb3ZpZGUNCj4gPiA+Pj4gYW4NCj4gPiA+Pj4+IG9wdGlvbiB0
byBkaXNhYmxlIHF1ZXVlZC1pbnZhbGlkYXRpb24gdGhvdWdoLCB3aGVuIHRoZSBoYXJkd2FyZQ0K
PiA+ID4+Pj4gaXMNCj4gPiA+Pj4gY2FwYWJsZS4gSWYgeW91DQo+ID4gPj4+PiByZWFsbHkgd2Fu
dCB0byB0cnksIHR3ZWFrIHRoZSBjb2RlIGluIGludGVsX2lvbW11X2luaXRfcWkuDQo+ID4gPj4+
Pg0KPiA+ID4+Pg0KPiA+ID4+PiBIaSBLZXZpbiwNCj4gPiA+Pj4NCj4gPiA+Pj4gVGhhbmtzIHRv
IHBvaW50IG91dCB0aGlzLiBEbyB5b3UgaGF2ZSBhbnkgaWRlYXMgYWJvdXQgdGhpcyBwcm9ibGVt
ID8NCj4gPiA+Pj4gSSB0cmllZCB0byBkZXNjcmlwdCB0aGUgcHJvYmxlbSBtdWNoIGNsZWFyIGlu
IG15IHJlcGx5IHRvIEFsZXgsDQo+ID4gPj4+IGhvcGUgeW91IGNvdWxkIGhhdmUgYSBsb29rIGlm
IHlvdSdyZSBpbnRlcmVzdGVkLg0KPiA+ID4+Pg0KPiA+ID4+DQo+ID4gPj4gYnR3IEkgc2F3IHlv
dSB1c2VkIDQuMTgga2VybmVsIGluIHRoaXMgdGVzdC4gV2hhdCBhYm91dCBsYXRlc3Qga2VybmVs
Pw0KPiA+ID4+DQo+ID4gPg0KPiA+ID4gTm90IHRlc3QgeWV0LiBJdCdzIGhhcmQgdG8gdXBncmFk
ZSBrZXJuZWwgaW4gb3VyIGVudmlyb25tZW50Lg0KPiA+ID4NCj4gPiA+PiBBbHNvIG9uZSB3YXkg
dG8gc2VwYXJhdGUgc3cvaHcgYnVnIGlzIHRvIHRyYWNlIHRoZSBsb3cgbGV2ZWwNCj4gPiA+PiBp
bnRlcmZhY2UgKGUuZy4sDQo+ID4gPj4gcWlfZmx1c2hfaW90bGIpIHdoaWNoIGFjdHVhbGx5IHNl
bmRzIGludmFsaWRhdGlvbiBkZXNjcmlwdG9ycyB0bw0KPiA+ID4+IHRoZSBJT01NVSBoYXJkd2Fy
ZS4gQ2hlY2sgdGhlIHdpbmRvdyBiZXR3ZWVuIGIpIGFuZCBjKSBhbmQgc2VlDQo+ID4gPj4gd2hl
dGhlciB0aGUgc29mdHdhcmUgZG9lcyB0aGUgcmlnaHQgdGhpbmcgYXMgZXhwZWN0ZWQgdGhlcmUu
DQo+ID4gPj4NCj4gPiA+DQo+ID4gPiBXZSBhZGQgc29tZSBsb2cgaW4gaW9tbXUgZHJpdmVyIHRo
ZXNlIGRheXMsIHRoZSBzb2Z0d2FyZSBzZWVtcyBmaW5lLg0KPiA+ID4gQnV0IHdlIGRpZG4ndCBs
b29rIGluc2lkZSB0aGUgcWlfc3VibWl0X3N5bmMgeWV0LCBJJ2xsIHRyeSBpdCB0b25pZ2h0Lg0K
PiA+DQo+ID4gU28gaGVyZSBpcyBteSBndWVzczoNCj4gPg0KPiA+IEludGVsIHByb2JhYmx5IHVz
ZWQgYXMgYSBiYXNpcyBmb3IgdGhlIElPVExCIGFuIGltcGxlbWVudGF0aW9uIG9mIHNvbWUNCj4g
PiBvdGhlcg0KPiA+IChyZWd1bGFyKSBUTEIgZGVzaWduLg0KPiA+DQo+ID4gSW50ZWwgU0RNIHNh
eXMgcmVnYXJkaW5nIFRMQnMgKDQuMTAuNC4yIOKAnFJlY29tbWVuZGVkIEludmFsaWRhdGlvbuKA
nSk6DQo+ID4NCj4gPiAiU29mdHdhcmUgd2lzaGluZyB0byBwcmV2ZW50IHRoaXMgdW5jZXJ0YWlu
dHkgc2hvdWxkIG5vdCB3cml0ZSB0byBhDQo+ID4gcGFnaW5nLXN0cnVjdHVyZSBlbnRyeSBpbiBh
IHdheSB0aGF0IHdvdWxkIGNoYW5nZSwgZm9yIGFueSBsaW5lYXINCj4gPiBhZGRyZXNzLCBib3Ro
IHRoZSBwYWdlIHNpemUgYW5kIGVpdGhlciB0aGUgcGFnZSBmcmFtZSwgYWNjZXNzIHJpZ2h0cywg
b3Igb3RoZXINCj4gYXR0cmlidXRlcy7igJ0NCj4gPg0KPiA+DQo+ID4gTm93IHRoZSBhZm9yZW1l
bnRpb25lZCB1bmNlcnRhaW50eSBpcyBhIGJpdCBkaWZmZXJlbnQgKG11bHRpcGxlDQo+ID4gKnZh
bGlkKiB0cmFuc2xhdGlvbnMgb2YgYSBzaW5nbGUgYWRkcmVzcykuIFlldCwgcGVyaGFwcyB0aGlz
IGlzIHlldA0KPiA+IGFub3RoZXIgdGhpbmcgdGhhdCBtaWdodCBoYXBwZW4uDQo+ID4NCj4gPiBG
cm9tIGEgYnJpZWYgbG9vayBvbiB0aGUgaGFuZGxpbmcgb2YgTU1VIChub3QgSU9NTVUpIGh1Z2Vw
YWdlcyBpbg0KPiA+IExpbnV4LCBpbmRlZWQgdGhlIFBNRCBpcyBmaXJzdCBjbGVhcmVkIGFuZCBm
bHVzaGVkIGJlZm9yZSBhIG5ldyB2YWxpZA0KPiA+IFBNRCBpcyBzZXQuIFRoaXMgaXMgcG9zc2li
bGUgZm9yIE1NVXMgc2luY2UgdGhleSBhbGxvdyB0aGUgc29mdHdhcmUgdG8gaGFuZGxlDQo+IHNw
dXJpb3VzIHBhZ2UtZmF1bHRzIGdyYWNlZnVsbHkuDQo+ID4gVGhpcyBpcyBub3QgdGhlIGNhc2Ug
Zm9yIHRoZSBJT01NVSB0aG91Z2ggKHdpdGhvdXQgUFJJKS4NCj4gPg0KPiANCj4gQnV0IGluIG15
IGNhc2UsIHRoZSBmbHVzaF9pb3RsYiBpcyBjYWxsZWQgYWZ0ZXIgdGhlIHJhbmdlIG9mICgweDAs
IDB4YTAwMDApIGlzDQo+IHVubWFwcGVkLCBJJ3ZlIG5vIGlkZWEgd2h5IHRoaXMgaW52YWxpZGF0
aW9uIGlzbid0IGVmZmVjdGl2ZSBleGNlcHQgSSd2ZSBub3QgbG9vaw0KPiBpbnNpZGUgdGhlIHFp
IHlldCwgYnV0IHRoZXJlIGlzIG5vIGNvbXBsYWludHMgZnJvbSB0aGUgZHJpdmVyLg0KPiANCj4g
Q291bGQgeW91IHBsZWFzZSBwb2ludCBvdXQgdGhlIGNvZGUgb2YgTU1VIHlvdSBtZW50aW9uZWQg
YWJvdmU/IEluIE1NVSBjb2RlLA0KPiBpcyBpdCBwb3NzaWJsZSB0aGF0IGFsbCB0aGUgZW50cmll
cyBvZiB0aGUgUFRFIGFyZSBhbGwgbm90LXByZXNlbnQgYnV0IHRoZSBQTUQgZW50cnkgaXMNCj4g
c3RpbGwgcHJlc2VudD8NCj4gDQoNCk9oLCBJIHNlZSB0aGUgZm9sbG93aW5nIE1NVSBjb2RlOg0K
dW5tYXBfcG1kX3JhbmdlDQogIF9fdW5tYXBfcG1kX3JhbmdlDQogICAgdW5tYXBfcHRlX3Jhbmdl
DQogICAgICB0cnlfdG9fZnJlZV9wbWRfcGFnZSAoaWYgYWxsIG9mIHRoZSBQVEVzIGFyZSBwbWRf
bm9uZSkNCg0KU28gdGhlIE1NVSBjb2RlIHdvbid0IGtlZXAgdGhlIFBNRCBlbnRyeSBhcyBwcmVz
ZW50IGlmIGFsbCBvZiBpdHMgUFRFIGVudHJpZXMNCmFyZSBub3QtcHJlc2VudC4NCg0KDQo+ICpQ
YWdlIHRhYmxlIGFmdGVyICgweDAsIDB4YTAwMDApIGlzIHVubWFwcGVkOg0KPiBQTUw0OiAweCAg
ICAgIDFhMzRmYmIwMDMNCj4gICBQRFBFOiAweCAgICAgIDFhMzRmYmIwMDMNCj4gICAgUERFOiAw
eCAgICAgIDFhMzRmYmYwMDMNCj4gICAgIFBURTogMHggICAgICAgICAgICAgICAwDQo+IA0KPiAq
UGFnZSB0YWJsZSBhZnRlciAoMHgwLCAweGMwMDAwMDAwKSBpcyBtYXBwZWQ6DQo+IFBNTDQ6IDB4
ICAgICAgMWEzNGZiYjAwMw0KPiAgIFBEUEU6IDB4ICAgICAgMWEzNGZiYjAwMw0KPiAgICBQREU6
IDB4ICAgICAgIDE1ZWMwMDg4Mw0KPiANCj4gPiBOb3Qgc3VyZSB0aGlzIGV4cGxhaW5zIGV2ZXJ5
dGhpbmcgdGhvdWdoLiBJZiB0aGF0IGlzIHRoZSBwcm9ibGVtLCB0aGVuDQo+ID4gZHVyaW5nIGEg
bWFwcGluZyB0aGF0IGNoYW5nZXMgcGFnZS1zaXplcywgYSBUTEIgZmx1c2ggaXMgbmVlZGVkLA0K
PiA+IHNpbWlsYXJseSB0byB0aGUgb25lIExvbmdwZW5nIGRpZCBtYW51YWxseS4NCj4gPg0KPiAN
Cg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUg
bWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
