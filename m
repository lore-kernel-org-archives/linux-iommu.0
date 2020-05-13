Return-Path: <SRS0=oi3Z=63=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2E6C433DF
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 15:58:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2E89206A5
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 15:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E89206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 63FB5893F1;
	Wed, 13 May 2020 15:58:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 671yXfqVQJoe; Wed, 13 May 2020 15:58:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 677AC893C1;
	Wed, 13 May 2020 15:58:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46AECC0178;
	Wed, 13 May 2020 15:58:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 283CDC016F
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 15:58:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E1D368914A
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 15:58:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EM9Wsu2x8miC for <iommu@lists.linux-foundation.org>;
 Wed, 13 May 2020 15:58:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E49F488F41
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 15:58:01 +0000 (UTC)
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
 by Forcepoint Email with ESMTP id 13164FCC90C3130C7CEA;
 Wed, 13 May 2020 16:57:59 +0100 (IST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 13 May 2020 16:57:58 +0100
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.1913.007; Wed, 13 May 2020 16:57:58 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Auger Eric <eric.auger@redhat.com>, Zhangfei Gao
 <zhangfei.gao@linaro.org>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "will@kernel.org" <will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>,
 "maz@kernel.org" <maz@kernel.org>, "robin.murphy@arm.com"
 <robin.murphy@arm.com>
Subject: RE: [PATCH v11 00/13] SMMUv3 Nested Stage Setup (IOMMU part)
Thread-Topic: [PATCH v11 00/13] SMMUv3 Nested Stage Setup (IOMMU part)
Thread-Index: AQHWEm6UKSWHwUIWVEisrcDF38xxfKh7GISAgAA31ACAFixYIIAK1E8AgAnONYCAADUt8A==
Date: Wed, 13 May 2020 15:57:58 +0000
Message-ID: <9e323c4668e94ea89beec3689376b893@huawei.com>
References: <20200414150607.28488-1-eric.auger@redhat.com>
 <eb27f625-ad7a-fcb5-2185-5471e4666f09@linaro.org>
 <06fe02f7-2556-8986-2f1e-dcdf59773b8c@redhat.com>
 <c7786a2a314e4c4ab37ef157ddfa23af@huawei.com>
 <3858dd8c-ee55-b0d7-96cc-3c047ba8f652@redhat.com>
In-Reply-To: <3858dd8c-ee55-b0d7-96cc-3c047ba8f652@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.27.251]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "bbhushan2@marvell.com" <bbhushan2@marvell.com>
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

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBdWdlciBF
cmljIFttYWlsdG86ZXJpYy5hdWdlckByZWRoYXQuY29tXQ0KPiBTZW50OiAxMyBNYXkgMjAyMCAx
NDoyOQ0KPiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSA8c2hhbWVlcmFsaS5rb2xvdGh1
bS50aG9kaUBodWF3ZWkuY29tPjsNCj4gWmhhbmdmZWkgR2FvIDx6aGFuZ2ZlaS5nYW9AbGluYXJv
Lm9yZz47IGVyaWMuYXVnZXIucHJvQGdtYWlsLmNvbTsNCj4gaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGt2bUB2Z2VyLmtl
cm5lbC5vcmc7IGt2bWFybUBsaXN0cy5jcy5jb2x1bWJpYS5lZHU7IHdpbGxAa2VybmVsLm9yZzsN
Cj4gam9yb0A4Ynl0ZXMub3JnOyBtYXpAa2VybmVsLm9yZzsgcm9iaW4ubXVycGh5QGFybS5jb20N
Cj4gQ2M6IGplYW4tcGhpbGlwcGVAbGluYXJvLm9yZzsgYWxleC53aWxsaWFtc29uQHJlZGhhdC5j
b207DQo+IGphY29iLmp1bi5wYW5AbGludXguaW50ZWwuY29tOyB5aS5sLmxpdUBpbnRlbC5jb207
IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsNCj4gdG5Ac2VtaWhhbGYuY29tOyBiYmh1c2hhbjJA
bWFydmVsbC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTEgMDAvMTNdIFNNTVV2MyBOZXN0
ZWQgU3RhZ2UgU2V0dXAgKElPTU1VIHBhcnQpDQo+IA0KWy4uLl0NCg0KPiA+Pj4gWWVzIHRoYXQn
cyBub3JtYWwgdGhpcyBzZXJpZXMgaXMgbm90IG1lYW50IHRvIHN1cHBvcnQgdlNWTSBhdCB0aGlz
IHN0YWdlLg0KPiA+Pj4NCj4gPj4+IEkgaW50ZW5kIHRvIGFkZCB0aGUgbWlzc2luZyBwaWVjZXMg
ZHVyaW5nIHRoZSBuZXh0IHdlZWtzLg0KPiA+Pg0KPiA+PiBUaGFua3MgZm9yIHRoYXQuIEkgaGF2
ZSBtYWRlIGFuIGF0dGVtcHQgdG8gYWRkIHRoZSB2U1ZBIGJhc2VkIG9uDQo+ID4+IHlvdXIgdjEw
ICsgSlBCcyBzdmEgcGF0Y2hlcy4gVGhlIGhvc3Qga2VybmVsIGFuZCBRZW11IGNoYW5nZXMgY2Fu
DQo+ID4+IGJlIGZvdW5kIGhlcmVbMV1bMl0uDQo+ID4+DQo+ID4+IFRoaXMgYmFzaWNhbGx5IGFk
ZHMgbXVsdGlwbGUgcGFzaWQgc3VwcG9ydCBvbiB0b3Agb2YgeW91ciBjaGFuZ2VzLg0KPiA+PiBJ
IGhhdmUgZG9uZSBzb21lIGJhc2ljIHNhbml0eSB0ZXN0aW5nIGFuZCB3ZSBoYXZlIHNvbWUgaW5p
dGlhbCBzdWNjZXNzDQo+ID4+IHdpdGggdGhlIHppcCB2ZiBkZXYgb24gb3VyIEQwNiBwbGF0Zm9y
bS4gUGxlYXNlIG5vdGUgdGhhdCB0aGUgU1RBTEwgZXZlbnQgaXMNCj4gPj4gbm90IHlldCBzdXBw
b3J0ZWQgdGhvdWdoLCBidXQgd29ya3MgZmluZSBpZiB3ZSBtbG9jaygpIGd1ZXN0IHVzciBtZW0u
DQo+ID4NCj4gPiBJIGhhdmUgYWRkZWQgU1RBTEwgc3VwcG9ydCBmb3Igb3VyIHZTVkEgcHJvdG90
eXBlIGFuZCBpdCBzZWVtcyB0byBiZQ0KPiA+IHdvcmtpbmcob24gb3VyIGhhcmR3YXJlKS4gSSBo
YXZlIHVwZGF0ZWQgdGhlIGtlcm5lbCBhbmQgcWVtdSBicmFuY2hlcw0KPiB3aXRoDQo+ID4gdGhl
IHNhbWVbMV1bMl0uIEkgc2hvdWxkIHdhcm4geW91IHRob3VnaCB0aGF0IHRoZXNlIGFyZSBwcm90
b3R5cGUgY29kZSBhbmQgSQ0KPiBhbSBwcmV0dHkNCj4gPiBtdWNoIHJlLXVzaW5nIHRoZSBWRklP
X0lPTU1VX1NFVF9QQVNJRF9UQUJMRSBpbnRlcmZhY2UgZm9yIGFsbW9zdA0KPiBldmVyeXRoaW5n
Lg0KPiA+IEJ1dCB0aG91Z2h0IG9mIHNoYXJpbmcsIGluIGNhc2UgaWYgaXQgaXMgdXNlZnVsIHNv
bWVob3chLg0KPiANCj4gVGhhbmsgeW91IGFnYWluIGZvciBzaGFyaW5nIHRoZSBQT0MuIEkgbG9v
a2VkIGF0IHRoZSBrZXJuZWwgYW5kIFFFTVUNCj4gYnJhbmNoZXMuDQo+IA0KPiBIZXJlIGFyZSBz
b21lIHByZWxpbWluYXJ5IGNvbW1lbnRzOg0KPiAtICJhcm0tc21tdS12MzogUmVzZXQgUzJUVEIg
d2hpbGUgc3dpdGNoaW5nIGJhY2sgZnJvbSBuZXN0ZWQgc3RhZ2UiOiAgYXMNCj4geW91IG1lbnRp
b25uZWQgUzJUVEIgcmVzZXQgbm93IGlzIGZlYXR1cmVkIGluIHYxMQ0KDQpZZXMuDQoNCj4gLSAi
YXJtLXNtbXUtdjM6IEFkZCBzdXBwb3J0IGZvciBtdWx0aXBsZSBwYXNpZCBpbiBuZXN0ZWQgbW9k
ZSI6IEkgY291bGQNCj4gZWFzaWx5IGludGVncmF0ZSB0aGlzIGludG8gbXkgc2VyaWVzLiBVcGRh
dGUgdGhlIGlvbW11IGFwaSBmaXJzdCBhbmQNCj4gcGFzcyBtdWx0aXBsZSBDRCBpbmZvIGluIGEg
c2VwYXJhdGUgcGF0Y2gNCg0KT2suDQo+IC0gImFybS1zbW11LXYzOiBBZGQgc3VwcG9ydCB0byBJ
bnZhbGlkYXRlIENEIjogQ0QgaW52YWxpZGF0aW9uIHNob3VsZCBiZQ0KPiBjYXNjYWRlZCB0byBo
b3N0IHRocm91Z2ggdGhlIFBBU0lEIGNhY2hlIGludmFsaWRhdGlvbiB1YXBpIChubyBwYiB5b3UN
Cj4gd2FybmVkIHVzIGZvciB0aGUgUE9DIHlvdSBzaW1wbHkgdXNlZCBWRklPX0lPTU1VX1NFVF9Q
QVNJRF9UQUJMRSkuIEkNCj4gdGhpbmsgSSBzaG91bGQgYWRkIHRoaXMgc3VwcG9ydCBpbiBteSBv
cmlnaW5hbCBzZXJpZXMgYWx0aG91Z2ggaXQgZG9lcw0KPiBub3Qgc2VlbSB0byB0cmlnZ2VyIGFu
eSBpc3N1ZSB1cCB0byBub3cuDQoNCkFncmVlLiBDYWNoZSBpbnZhbGlkYXRpb24gdWFwaSBpcyBh
IGJldHRlciBpbnRlcmZhY2UgZm9yIHRoaXMuIEFsc28gSSBkb27igJl0IHRoaW5rDQp0aGlzIG1h
dHRlcnMgZm9yIG5vbi12c3ZhIGNhc2VzIGFzIEd1ZXN0IGtlcm5lbCB0YWJsZS9DRChwYXNpZCAw
KSB3aWxsIG5ldmVyDQpnZXQgaW52YWxpZGF0ZWQuIA0KDQo+IC0gImFybS1zbW11LXYzOiBSZW1v
dmUgZHVwbGljYXRpb24gb2YgZmF1bHQgcHJvcGFnYXRpb24iLiBJIHVuZGVyc3RhbmQNCj4gdGhl
IHRyYW5zY29kZSBpcyBkb25lIHNvbWV3aGVyZSBlbHNlIHdpdGggU1ZBIGJ1dCB3ZSBzdGlsbCBu
ZWVkIHRvIGRvIGl0DQo+IGlmIGEgc2luZ2xlIENEIGlzIHVzZWQsIHJpZ2h0PyBJIHdpbGwgcmV2
aWV3IHRoZSBTVkEgY29kZSB0byBiZXR0ZXINCj4gdW5kZXJzdGFuZC4NCg0KSG1tLi5ub3Qgc3Vy
ZS4gTmVlZCB0byB0YWtlIGFub3RoZXIgbG9vayB0byBzZWUgd2hldGhlciB3ZSBuZWVkIGEgc3Bl
Y2lhbA0KaGFuZGxpbmcgZm9yIHNpbmdsZSBDRCBvciBub3QuDQoNCj4gLSBmb3IgdGhlIFNUQUxM
IHJlc3BvbnNlIGluamVjdGlvbiBJIHdvdWxkIHRlbmQgdG8gdXNlIGEgbmV3IFZGSU8gcmVnaW9u
DQo+IGZvciByZXNwb25zZXMuIEF0IHRoZSBtb21lbnQgdGhlcmUgaXMgYSBzaW5nbGUgVkZJTyBy
ZWdpb24gZm9yIHJlcG9ydGluZw0KPiB0aGUgZmF1bHQuDQoNClN1cmUuIFRoYXQgd2lsbCBiZSBt
dWNoIGNsZWFuZXIgYW5kIHByb2JhYmx5IGltcHJvdmUgdGhlIGNvbnRleHQgc3dpdGNoDQpsYXRl
bmN5LiBBbm90aGVyIHRoaW5nIEkgbm90ZWQgd2l0aCBTVEFMTCBpcyB0aGF0IHBhc2lkX3ZhbGlk
IGZsYWcgbmVlZHMgdG8gYmUNCnRha2VuIGNhcmUgaW4gdGhlIFNWQSBrZXJuZWwgcGF0aC4gDQoN
CiJpb21tdTogUmVtb3ZlIHBhc2lkIHZhbGlkaXR5IGNoZWNrIGZvciBTVEFMTCBtb2RlbCBwYWdl
IHJlc3BvbnNlIG1zZyINCk5vdCBzdXJlIHRoaXMgb25lIGlzIGEgcHJvcGVyIHdheSB0byBoYW5k
bGUgdGhpcy4NCiANCj4gT24gUUVNVSBzaWRlOg0KPiAtIEkgYW0gY3VycmVudGx5IHdvcmtpbmcg
b24gMy4yIHJhbmdlIGludmFsaWRhdGlvbiBzdXBwb3J0IHdoaWNoIGlzDQo+IG5lZWRlZCBmb3Ig
RFBESy9WRklPDQo+IC0gV2hpbGUgYXQgaXQgSSB3aWxsIGxvb2sgYXQgaG93IHRvIGluY3JlbWVu
dGFsbHkgaW50cm9kdWNlIHNvbWUgb2YgdGhlDQo+IGZlYXR1cmVzIHlvdSBuZWVkIGluIHRoaXMg
c2VyaWVzLg0KDQpPay4gDQoNClRoYW5rcyBmb3IgdGFraW5nIGEgbG9vayBhdCB0aGUgUE9DLg0K
DQpDaGVlcnMsDQpTaGFtZWVyDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by9pb21tdQ==
