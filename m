Return-Path: <SRS0=lUsJ=2P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EB6C2D0C3
	for <iommu@archiver.kernel.org>; Wed, 25 Dec 2019 02:05:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 488A12063A
	for <iommu@archiver.kernel.org>; Wed, 25 Dec 2019 02:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 488A12063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baidu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 057082041D;
	Wed, 25 Dec 2019 02:05:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jrkgocIOQEU2; Wed, 25 Dec 2019 02:05:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3E27D203BE;
	Wed, 25 Dec 2019 02:05:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2EC26C1D80;
	Wed, 25 Dec 2019 02:05:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96E31C0881
 for <iommu@lists.linux-foundation.org>; Wed, 25 Dec 2019 02:05:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 89AFC2041D
 for <iommu@lists.linux-foundation.org>; Wed, 25 Dec 2019 02:05:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7fXVVtwKa01Q for <iommu@lists.linux-foundation.org>;
 Wed, 25 Dec 2019 02:05:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
 by silver.osuosl.org (Postfix) with ESMTP id 3EC21203BE
 for <iommu@lists.linux-foundation.org>; Wed, 25 Dec 2019 02:05:52 +0000 (UTC)
Received: from BC-Mail-EX08.internal.baidu.com (unknown [172.31.51.48])
 by Forcepoint Email with ESMTPS id 18716B98A2156D52D209;
 Wed, 25 Dec 2019 10:05:46 +0800 (CST)
Received: from BJHW-Mail-Ex02.internal.baidu.com (10.127.64.12) by
 BC-Mail-EX08.internal.baidu.com (172.31.51.48) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1531.3; Wed, 25 Dec 2019 10:05:45 +0800
Received: from BC-Mail-Ex03.internal.baidu.com (172.31.51.43) by
 BJHW-Mail-Ex02.internal.baidu.com (10.127.64.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 25 Dec 2019 10:05:45 +0800
Received: from BC-Mail-Ex03.internal.baidu.com ([100.100.100.102]) by
 BC-Mail-Ex03.internal.baidu.com ([100.100.100.102]) with mapi id
 15.01.1531.010; Wed, 25 Dec 2019 10:05:45 +0800
From: "Jim,Yan" <jimyan@baidu.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Jerry Snitselaar <jsnitsel@redhat.com>
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlOWkjTog562U5aSNOiDnrZTlpI06IFtQQVRD?=
 =?utf-8?B?SF0gaW9tbXUvdnQtZDogRG9uJ3QgcmVqZWN0IG52bWUgaG9zdCBkdWUgdG8g?=
 =?utf-8?Q?scope_mismatch?=
Thread-Topic: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlOWkjTog562U5aSNOiBbUEFUQ0hdIGlvbW11?=
 =?utf-8?B?L3Z0LWQ6IERvbid0IHJlamVjdCBudm1lIGhvc3QgZHVlIHRvIHNjb3BlIG1p?=
 =?utf-8?Q?smatch?=
Thread-Index: AdW6BKk3WRIzqftPRCuhhluvn9v6Mv//tuqA//9dBfCAAPa3gP//eOkwgAF7SQD//3mpQA==
Date: Wed, 25 Dec 2019 02:05:45 +0000
Message-ID: <eccacec618c04a58be66809a541a95bf@baidu.com>
References: <4b77511069cb4fbc982eebaad941cd23@baidu.com>
 <149a454d-96ea-1e25-74d1-04a08f8b261e@linux.intel.com>
 <8fbd6988b0a94c5e9e4b23eed59114dc@baidu.com>
 <273a4cc4-f17b-63a6-177d-9830e683bf52@linux.intel.com>
 <062f5fd1611940b083ec34603eca94e1@baidu.com>
 <46d15bd6-4b50-d0cb-e0b8-763a808c4de8@linux.intel.com>
In-Reply-To: <46d15bd6-4b50-d0cb-e0b8-763a808c4de8@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.200.92]
x-baidu-bdmsfe-datecheck: 1_BJHW-Mail-Ex02_2019-12-25 10:05:45:837
x-baidu-bdmsfe-viruscheck: BJHW-Mail-Ex02_GRAY_Inside_WithoutAtta_2019-12-25
 10:05:45:822
MIME-Version: 1.0
X-Baidu-BdMsfe-DateCheck: 1_BC-Mail-EX08_2019-12-25 10:05:45:930
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

SGksDQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IEx1IEJhb2x1IFtt
YWlsdG86YmFvbHUubHVAbGludXguaW50ZWwuY29tXQ0KPiDlj5HpgIHml7bpl7Q6IDIwMTnlubQx
MuaciDI15pelIDEwOjAxDQo+IOaUtuS7tuS6ujogSmltLFlhbiA8amlteWFuQGJhaWR1LmNvbT47
IEplcnJ5IFNuaXRzZWxhYXIgPGpzbml0c2VsQHJlZGhhdC5jb20+DQo+IOaKhOmAgTogaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcN
Cj4g5Li76aKYOiBSZTog562U5aSNOiDnrZTlpI06IOetlOWkjTog562U5aSNOiBbUEFUQ0hdIGlv
bW11L3Z0LWQ6IERvbid0IHJlamVjdCBudm1lDQo+IGhvc3QgZHVlIHRvIHNjb3BlIG1pc21hdGNo
DQo+IA0KPiBIaSwNCj4gDQo+IE9uIDIwMTkvMTIvMjUgOTo1MiwgSmltLFlhbiB3cm90ZToNCj4g
PiBIaSwNCj4gPg0KPiA+PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+ID4+IOWPkeS7tuS6ujog
THUgQmFvbHUgW21haWx0bzpiYW9sdS5sdUBsaW51eC5pbnRlbC5jb21dDQo+ID4+IOWPkemAgeaX
tumXtDogMjAxOeW5tDEy5pyIMjTml6UgMTk6MjcNCj4gPj4g5pS25Lu25Lq6OiBKaW0sWWFuIDxq
aW15YW5AYmFpZHUuY29tPjsgSmVycnkgU25pdHNlbGFhcg0KPiA+PiA8anNuaXRzZWxAcmVkaGF0
LmNvbT4NCj4gPj4g5oqE6YCBOiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+PiDkuLvpopg6IFJlOiDnrZTlpI06IOetlOWk
jTog562U5aSNOiBbUEFUQ0hdIGlvbW11L3Z0LWQ6IERvbid0IHJlamVjdCBudm1lIGhvc3QNCj4g
ZHVlIHRvDQo+ID4+IHNjb3BlIG1pc21hdGNoDQo+ID4+DQo+ID4+IEhpLA0KPiA+Pg0KPiA+PiBP
biAyMDE5LzEyLzI0IDE2OjE4LCBKaW0sWWFuIHdyb3RlOg0KPiA+Pj4+Pj4gRm9yIGJvdGggY2Fz
ZXMsIGEgcXVpcmsgZmxhZyBzZWVtcyB0byBiZSBtb3JlIHJlYXNvbmFibGUsIHNvIHRoYXQNCj4g
Pj4+Pj4+IHVucmVsYXRlZCBkZXZpY2VzIHdpbGwgbm90IGJlIGltcGFjdGVkLg0KPiA+Pj4+Pj4N
Cj4gPj4+Pj4+IEJlc3QgcmVnYXJkcywNCj4gPj4+Pj4+IGJhb2x1DQo+ID4+Pj4+IEhpIEJhb2x1
LA0KPiA+Pj4+PiAJVGhhbmtzIGZvciB5b3VyIGFkdmljZS4gQW5kIEkgbW9kaWZ5IHRoZSBwYXRj
aCBhcyBmb2xsb3cuDQo+ID4+Pj4gSSBqdXN0IHBvc3RlZCBhIHBhdGNoIGZvciBib3RoIE5URyBh
bmQgTlZNRSBjYXNlcy4gQ2FuIHlvdSBwbGVhc2UNCj4gPj4+PiB0YWtlIGENCj4gPj4gbG9vaz8N
Cj4gPj4+PiBEb2VzIGl0IHdvcmsgZm9yIHlvdT8NCj4gPj4+Pg0KPiA+Pj4+IEJlc3QgcmVnYXJk
cywNCj4gPj4+PiBiYW9sdQ0KPiA+Pj4+DQo+ID4+PiBJIGhhdmUgdGVzdGVkIHlvdXIgcGF0Y2gu
IEl0IGRvZXMgd29yayBmb3IgbWUuIEJ1dCBJIHByZWZlciBteQ0KPiA+Pj4gc2Vjb25kIHZlcnNp
b24sDQo+ID4+IGl0IGlzIG1vcmUgZmxleGlibGUsIGFuZCBtYXkgdXNlIGZvciBzaW1pbGFyIHVu
a25vd24gZGV2aWNlcy4NCj4gPj4+DQo+ID4+DQo+ID4+IEkgZGlkbid0IGdldCB5b3VyIHBvaW50
LiBEbyB5b3UgbWluZCBleHBsYWluaW5nIHdoeSBpdCdzIG1vcmUgZmxleGlibGU/DQo+ID4+DQo+
ID4+IEJlc3QgcmVnYXJkcywNCj4gPj4gQmFvbHUNCj4gPiBGb3IgZXhhbXBsZSwgYW4gdW5rbm93
biBkZXZpY2UgaGFzIGEgbm9ybWFsIFBDSSBoZWFkZXIgYW5kIGJyaWRnZSBzY29wZQ0KPiBhbmQg
YSBjbGFzcyBvZiBQQ0lfQ0xBU1NfQlJJREdFX1BDSS4NCj4gPiBUaGVzZSBkZXZpY2VzIGRvIGhh
dmUgYSBjbGFzcyBvZiBQQ0lfQkFTRV9DTEFTU19CUklER0UgaW4gY29tbW9uLg0KPiANCj4gVGhp
cyBpcyBub3QgYSBjb21tb24gY2FzZS4gSXQncyBvbmx5IGZvciBkZXZpY2VzIG9uIHRoZSBtYXJr
ZXRpbmcgYW5kIGhhcmQgZm9yDQo+IHRoZSBWVC1kIHVzZXJzIHRvIGdldCBpdCBmaXhlZCBpbiB0
aGUgT0VNIGZpcm13YXJlLg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBCYW9sdQ0KDQpHb3QgaXQu
IFRoZW4gSSBhbSBPSyB3aXRoIHRoaXMgcGF0Y2guIEkgaGF2ZSB0ZXN0ZWQgaXQgeWVzdGVyZGF5
LiBJdCBkb2VzIHdvcmsgZm9yIG1lLiANClRoYW5rcy4NCg0KSmltDQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
