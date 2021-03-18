Return-Path: <SRS0=56b4=IQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149A1C433DB
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 08:20:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DED864EF6
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 08:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DED864EF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 000614E31A;
	Thu, 18 Mar 2021 08:20:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vp5HVNWqVbDt; Thu, 18 Mar 2021 08:20:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D3A64E47C;
	Thu, 18 Mar 2021 08:20:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62A29C000B;
	Thu, 18 Mar 2021 08:20:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B09EC0001
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 08:20:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1465684176
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 08:20:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MOceXubu2bIC for <iommu@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 08:20:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6E0FE83A4C
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 08:20:10 +0000 (UTC)
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.55])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4F1Kcw0cmqz1455X;
 Thu, 18 Mar 2021 16:17:04 +0800 (CST)
Received: from dggpemm100010.china.huawei.com (7.185.36.24) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 18 Mar 2021 16:20:06 +0800
Received: from dggpeml500016.china.huawei.com (7.185.36.70) by
 dggpemm100010.china.huawei.com (7.185.36.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 18 Mar 2021 16:20:06 +0800
Received: from dggpeml500016.china.huawei.com ([7.185.36.70]) by
 dggpeml500016.china.huawei.com ([7.185.36.70]) with mapi id 15.01.2106.013;
 Thu, 18 Mar 2021 16:20:06 +0800
From: "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)"
 <longpeng2@huawei.com>
To: Nadav Amit <nadav.amit@gmail.com>
Subject: =?utf-8?B?UkU6IEEgcHJvYmxlbSBvZiBJbnRlbCBJT01NVSBoYXJkd2FyZSDvvJ8=?=
Thread-Topic: =?utf-8?B?QSBwcm9ibGVtIG9mIEludGVsIElPTU1VIGhhcmR3YXJlIO+8nw==?=
Thread-Index: AQHXGtwEduPlUZeCNUCbiy3s/+KwAaqHJckAgADDZTCAAA0+AIABZ4Ng
Date: Thu, 18 Mar 2021 08:20:06 +0000
Message-ID: <4d1c3bc0418e48b1b9d44799d65ea375@huawei.com>
References: <670baaf8-4ff8-4e84-4be3-030b95ab5a5e@huawei.com>
 <FB4E11A5-84D4-4DAF-889E-FAA1BCD2E66F@gmail.com>
 <6a218e7fe42d41489d02f0b4e3ad2756@huawei.com>
 <98DB71EF-FF98-4509-85EC-26FF50825A58@gmail.com>
In-Reply-To: <98DB71EF-FF98-4509-85EC-26FF50825A58@gmail.com>
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
QW1pdCBbbWFpbHRvOm5hZGF2LmFtaXRAZ21haWwuY29tXQ0KPiBTZW50OiBUaHVyc2RheSwgTWFy
Y2ggMTgsIDIwMjEgMjoxMyBBTQ0KPiBUbzogTG9uZ3BlbmcgKE1pa2UsIENsb3VkIEluZnJhc3Ry
dWN0dXJlIFNlcnZpY2UgUHJvZHVjdCBEZXB0LikNCj4gPGxvbmdwZW5nMkBodWF3ZWkuY29tPg0K
PiBDYzogRGF2aWQgV29vZGhvdXNlIDxkd213MkBpbmZyYWRlYWQub3JnPjsgTHUgQmFvbHUNCj4g
PGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT47IEpvZXJnIFJvZWRlbCA8am9yb0A4Ynl0ZXMub3Jn
Pjsgd2lsbEBrZXJuZWwub3JnOw0KPiBhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbTsgY2hlbmpp
YXNoYW5nIDxjaGVuamlhc2hhbmdAaHVhd2VpLmNvbT47DQo+IGlvbW11QGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnOyBHb25nbGVpIChBcmVpKSA8YXJlaS5nb25nbGVpQGh1YXdlaS5jb20+Ow0K
PiBMS01MIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogQSBw
cm9ibGVtIG9mIEludGVsIElPTU1VIGhhcmR3YXJlIO+8nw0KPiANCj4gDQo+IA0KPiA+IE9uIE1h
ciAxNywgMjAyMSwgYXQgMjozNSBBTSwgTG9uZ3BlbmcgKE1pa2UsIENsb3VkIEluZnJhc3RydWN0
dXJlIFNlcnZpY2UNCj4gUHJvZHVjdCBEZXB0LikgPGxvbmdwZW5nMkBodWF3ZWkuY29tPiB3cm90
ZToNCj4gPg0KPiA+IEhpIE5hZGF2LA0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4+IEZyb206IE5hZGF2IEFtaXQgW21haWx0bzpuYWRhdi5hbWl0QGdtYWlsLmNvbV0N
Cj4gPj4+ICByZXByb2R1Y2UgdGhlIHByb2JsZW0gd2l0aCBoaWdoIHByb2JhYmlsaXR5ICh+NTAl
KS4NCj4gPj4NCj4gPj4gSSBzYXcgTHUgcmVwbGllZCwgYW5kIGhlIGlzIG11Y2ggbW9yZSBrbm93
bGVkZ2FibGUgdGhhbiBJIGFtIChJIHdhcw0KPiA+PiBqdXN0IGludHJpZ3VlZCBieSB5b3VyIGVt
YWlsKS4NCj4gPj4NCj4gPj4gSG93ZXZlciwgaWYgSSB3ZXJlIHlvdSBJIHdvdWxkIHRyeSBhbHNv
IHRvIHJlbW92ZSBzb21lDQo+ID4+IOKAnG9wdGltaXphdGlvbnPigJ0gdG8gbG9vayBmb3IgdGhl
IHJvb3QtY2F1c2UgKGUuZy4sIHVzZSBkb21haW4gc3BlY2lmaWMNCj4gaW52YWxpZGF0aW9ucyBp
bnN0ZWFkIG9mIHBhZ2Utc3BlY2lmaWMpLg0KPiA+Pg0KPiA+DQo+ID4gR29vZCBzdWdnZXN0aW9u
ISBCdXQgd2UgZGlkIGl0IHRoZXNlIGRheXMsIHdlIHRyaWVkIHRvIHVzZSBnbG9iYWwgaW52YWxp
ZGF0aW9ucyBhcw0KPiBmb2xsb3c6DQo+ID4gCQlpb21tdS0+Zmx1c2guZmx1c2hfaW90bGIoaW9t
bXUsIGRpZCwgMCwgMCwNCj4gPiAJCQkJCQlETUFfVExCX0RTSV9GTFVTSCk7DQo+ID4gQnV0IGNh
biBub3QgcmVzb2x2ZSB0aGUgcHJvYmxlbS4NCj4gPg0KPiA+PiBUaGUgZmlyc3QgdGhpbmcgdGhh
dCBjb21lcyB0byBteSBtaW5kIGlzIHRoZSBpbnZhbGlkYXRpb24gaGludCAoaWgpDQo+ID4+IGlu
IGlvbW11X2ZsdXNoX2lvdGxiX3BzaSgpLiBJIHdvdWxkIHJlbW92ZSBpdCB0byBzZWUgd2hldGhl
ciB5b3UgZ2V0DQo+ID4+IHRoZSBmYWlsdXJlIHdpdGhvdXQgaXQuDQo+ID4NCj4gPiBXZSBhbHNv
IG5vdGljZSB0aGUgSUgsIGJ1dCB0aGUgSUggaXMgYWx3YXlzIFpFUk8gaW4gb3VyIGNhc2UsIGFz
IHRoZSBzcGVjIHNheXM6DQo+ID4gJycnDQo+ID4gUGFnaW5nLXN0cnVjdHVyZS1jYWNoZSBlbnRy
aWVzIGNhY2hpbmcgc2Vjb25kLWxldmVsIG1hcHBpbmdzDQo+ID4gYXNzb2NpYXRlZCB3aXRoIHRo
ZSBzcGVjaWZpZWQgZG9tYWluLWlkIGFuZCB0aGUNCj4gPiBzZWNvbmQtbGV2ZWwtaW5wdXQtYWRk
cmVzcyByYW5nZSBhcmUgaW52YWxpZGF0ZWQsIGlmIHRoZSBJbnZhbGlkYXRpb24NCj4gPiBIaW50
DQo+ID4gKElIKSBmaWVsZCBpcyBDbGVhci4NCj4gPiAnJycNCj4gPg0KPiA+IEl0IHNlZW1zIHRo
ZSBzb2Z0d2FyZSBpcyBldmVyeXRoaW5nIGZpbmUsIHNvIHdlJ3ZlIG5vIGNob2ljZSBidXQgdG8g
c3VzcGVjdCB0aGUNCj4gaGFyZHdhcmUuDQo+IA0KPiBPaywgSSBhbSBwcmV0dHkgbXVjaCBvdXQg
b2YgaWRlYXMuIEkgaGF2ZSB0d28gbW9yZSBzdWdnZXN0aW9ucywgYnV0IHRoZXkgYXJlIG11Y2gN
Cj4gbGVzcyBsaWtlbHkgdG8gaGVscC4gWWV0LCB0aGV5IGNhbiBmdXJ0aGVyIGhlbHAgdG8gcnVs
ZSBvdXQgc29mdHdhcmUgYnVnczoNCj4gDQo+IDEuIGRtYV9jbGVhcl9wdGUoKSBzZWVtcyB0byBi
ZSB3cm9uZyBJTUhPLiBJdCBzaG91bGQgaGF2ZSB1c2VkIFdSSVRFX09OQ0UoKQ0KPiB0byBwcmV2
ZW50IHNwbGl0LXdyaXRlLCB3aGljaCBtaWdodCBwb3RlbnRpYWxseSBjYXVzZSDigJxpbnZhbGlk
4oCdIChwYXJ0aWFsbHkNCj4gY2xlYXJlZCkgUFRFIHRvIGJlIHN0b3JlZCBpbiB0aGUgVExCLiBI
YXZpbmcgc2FpZCB0aGF0LCB0aGUgc3Vic2VxdWVudCBJT1RMQiBmbHVzaA0KPiBzaG91bGQgaGF2
ZSBwcmV2ZW50ZWQgdGhlIHByb2JsZW0uDQo+IA0KDQpZZXMsIHVzZSBXUklURV9PTkNFIGlzIG11
Y2ggc2FmZXIsIGhvd2V2ZXIgSSB3YXMganVzdCB0ZXN0aW5nIHRoZSBmb2xsb3dpbmcgY29kZSwN
Cml0IGRpZG4ndCByZXNvbHZlZCBteSBwcm9ibGVtLg0KDQpzdGF0aWMgaW5saW5lIHZvaWQgZG1h
X2NsZWFyX3B0ZShzdHJ1Y3QgZG1hX3B0ZSAqcHRlKQ0Kew0KICAgICAgICBXUklURV9PTkNFKHB0
ZS0+dmFsLCAwVUxMKTsNCn0NCg0KPiAyLiBDb25zaWRlciBlbnN1cmluZyB0aGF0IHRoZSBwcm9i
bGVtIGlzIG5vdCBzb21laG93IHJlbGF0ZWQgdG8gcXVldWVkDQo+IGludmFsaWRhdGlvbnMuIFRy
eSB0byB1c2UgX19pb21tdV9mbHVzaF9pb3RsYigpIGluc3RlYWQgb2YgcWlfZmx1c2hfaW90bGIo
KS4NCj4gDQoNCkkgdHJpZWQgdG8gZm9yY2UgdG8gdXNlIF9faW9tbXVfZmx1c2hfaW90bGIoKSwg
YnV0IG1heWJlIHNvbWV0aGluZyB3cm9uZywNCnRoZSBzeXN0ZW0gY3Jhc2hlZCwgc28gSSBwcmVm
ZXIgdG8gbG93ZXIgdGhlIHByaW9yaXR5IG9mIHRoaXMgb3BlcmF0aW9uLg0KDQo+IFJlZ2FyZHMs
DQo+IE5hZGF2DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
