Return-Path: <SRS0=XdCg=6O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0C3C8300C
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 09:39:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A817E214D8
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 09:39:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A817E214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6B5C886957;
	Thu, 30 Apr 2020 09:39:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uPURy20WPwbw; Thu, 30 Apr 2020 09:39:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 125508693C;
	Thu, 30 Apr 2020 09:39:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7BFBC0889;
	Thu, 30 Apr 2020 09:39:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 900CBC016F
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 09:39:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 75418204D3
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 09:39:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8+u04Fogk7C9 for <iommu@lists.linux-foundation.org>;
 Thu, 30 Apr 2020 09:39:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by silver.osuosl.org (Postfix) with ESMTPS id 99326204BD
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 09:39:33 +0000 (UTC)
Received: from lhreml720-chm.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id C417D18DAC98B96D170F;
 Thu, 30 Apr 2020 10:39:30 +0100 (IST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml720-chm.china.huawei.com (10.201.108.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 30 Apr 2020 10:39:30 +0100
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.1913.007; Thu, 30 Apr 2020 10:39:30 +0100
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
Thread-Index: AQHWEm6UKSWHwUIWVEisrcDF38xxfKh7GISAgAA31ACAFixYIA==
Date: Thu, 30 Apr 2020 09:39:30 +0000
Message-ID: <d3929f528f4347e6a84c627a0b34a245@huawei.com>
References: <20200414150607.28488-1-eric.auger@redhat.com>
 <eb27f625-ad7a-fcb5-2185-5471e4666f09@linaro.org>
 <06fe02f7-2556-8986-2f1e-dcdf59773b8c@redhat.com>
In-Reply-To: <06fe02f7-2556-8986-2f1e-dcdf59773b8c@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.80.61]
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
cmljIFttYWlsdG86ZXJpYy5hdWdlckByZWRoYXQuY29tXQ0KPiBTZW50OiAxNiBBcHJpbCAyMDIw
IDA4OjQ1DQo+IFRvOiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BsaW5hcm8ub3JnPjsgZXJp
Yy5hdWdlci5wcm9AZ21haWwuY29tOw0KPiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4ga3ZtQHZnZXIua2VybmVsLm9yZzsg
a3ZtYXJtQGxpc3RzLmNzLmNvbHVtYmlhLmVkdTsgd2lsbEBrZXJuZWwub3JnOw0KPiBqb3JvQDhi
eXRlcy5vcmc7IG1hekBrZXJuZWwub3JnOyByb2Jpbi5tdXJwaHlAYXJtLmNvbQ0KPiBDYzogamVh
bi1waGlsaXBwZUBsaW5hcm8ub3JnOyBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpDQo+IDxzaGFt
ZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+OyBhbGV4LndpbGxpYW1zb25AcmVkaGF0
LmNvbTsNCj4gamFjb2IuanVuLnBhbkBsaW51eC5pbnRlbC5jb207IHlpLmwubGl1QGludGVsLmNv
bTsgcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOw0KPiB0bkBzZW1paGFsZi5jb207IGJiaHVzaGFu
MkBtYXJ2ZWxsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxMSAwMC8xM10gU01NVXYzIE5l
c3RlZCBTdGFnZSBTZXR1cCAoSU9NTVUgcGFydCkNCj4gDQo+IEhpIFpoYW5nZmVpLA0KPiANCj4g
T24gNC8xNi8yMCA2OjI1IEFNLCBaaGFuZ2ZlaSBHYW8gd3JvdGU6DQo+ID4NCj4gPg0KPiA+IE9u
IDIwMjAvNC8xNCDkuIvljYgxMTowNSwgRXJpYyBBdWdlciB3cm90ZToNCj4gPj4gVGhpcyB2ZXJz
aW9uIGZpeGVzIGFuIGlzc3VlIG9ic2VydmVkIGJ5IFNoYW1lZXIgb24gYW4gU01NVSAzLjIsDQo+
ID4+IHdoZW4gbW92aW5nIGZyb20gZHVhbCBzdGFnZSBjb25maWcgdG8gc3RhZ2UgMSBvbmx5IGNv
bmZpZy4NCj4gPj4gVGhlIDIgaGlnaCA2NGIgb2YgdGhlIFNURSBub3cgZ2V0IHJlc2V0LiBPdGhl
cndpc2UsIGxlYXZpbmcgdGhlDQo+ID4+IFMyVFRCIHNldCBtYXkgY2F1c2UgYSBDX0JBRF9TVEUg
ZXJyb3IuDQo+ID4+DQo+ID4+IFRoaXMgc2VyaWVzIGNhbiBiZSBmb3VuZCBhdDoNCj4gPj4gaHR0
cHM6Ly9naXRodWIuY29tL2VhdWdlci9saW51eC90cmVlL3Y1LjYtMnN0YWdlLXYxMV8xMC4xDQo+
ID4+IChpbmNsdWRpbmcgdGhlIFZGSU8gcGFydCkNCj4gPj4gVGhlIFFFTVUgZmVsbG93IHNlcmll
cyBzdGlsbCBjYW4gYmUgZm91bmQgYXQ6DQo+ID4+IGh0dHBzOi8vZ2l0aHViLmNvbS9lYXVnZXIv
cWVtdS90cmVlL3Y0LjIuMC0yc3RhZ2UtcmZjdjYNCj4gPj4NCj4gPj4gVXNlcnMgaGF2ZSBleHBy
ZXNzZWQgaW50ZXJlc3QgaW4gdGhhdCB3b3JrIGFuZCB0ZXN0ZWQgdjkvdjEwOg0KPiA+PiAtIGh0
dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvY292ZXIvMTEwMzk5OTUvIzIzMDEyMzgxDQo+ID4+
IC0gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9jb3Zlci8xMTAzOTk5NS8jMjMxOTcyMzUN
Cj4gPj4NCj4gPj4gQmFja2dyb3VuZDoNCj4gPj4NCj4gPj4gVGhpcyBzZXJpZXMgYnJpbmdzIHRo
ZSBJT01NVSBwYXJ0IG9mIEhXIG5lc3RlZCBwYWdpbmcgc3VwcG9ydA0KPiA+PiBpbiB0aGUgU01N
VXYzLiBUaGUgVkZJTyBwYXJ0IGlzIHN1Ym1pdHRlZCBzZXBhcmF0ZWx5Lg0KPiA+Pg0KPiA+PiBU
aGUgSU9NTVUgQVBJIGlzIGV4dGVuZGVkIHRvIHN1cHBvcnQgMiBuZXcgQVBJIGZ1bmN0aW9uYWxp
dGllczoNCj4gPj4gMSkgcGFzcyB0aGUgZ3Vlc3Qgc3RhZ2UgMSBjb25maWd1cmF0aW9uDQo+ID4+
IDIpIHBhc3Mgc3RhZ2UgMSBNU0kgYmluZGluZ3MNCj4gPj4NCj4gPj4gVGhlbiB0aG9zZSBjYXBh
YmlsaXRpZXMgZ2V0cyBpbXBsZW1lbnRlZCBpbiB0aGUgU01NVXYzIGRyaXZlci4NCj4gPj4NCj4g
Pj4gVGhlIHZpcnR1YWxpemVyIHBhc3NlcyBpbmZvcm1hdGlvbiB0aHJvdWdoIHRoZSBWRklPIHVz
ZXIgQVBJDQo+ID4+IHdoaWNoIGNhc2NhZGVzIHRoZW0gdG8gdGhlIGlvbW11IHN1YnN5c3RlbS4g
VGhpcyBhbGxvd3MgdGhlIGd1ZXN0DQo+ID4+IHRvIG93biBzdGFnZSAxIHRhYmxlcyBhbmQgY29u
dGV4dCBkZXNjcmlwdG9ycyAoc28tY2FsbGVkIFBBU0lEDQo+ID4+IHRhYmxlKSB3aGlsZSB0aGUg
aG9zdCBvd25zIHN0YWdlIDIgdGFibGVzIGFuZCBtYWluIGNvbmZpZ3VyYXRpb24NCj4gPj4gc3Ry
dWN0dXJlcyAoU1RFKS4NCj4gPj4NCj4gPj4NCj4gPg0KPiA+IFRoYW5rcyBFcmljDQo+ID4NCj4g
PiBUZXN0ZWQgdjExIG9uIEhpc2lsaWNvbiBrdW5wZW5nOTIwIGJvYXJkIHZpYSBoYXJkd2FyZSB6
aXAgYWNjZWxlcmF0b3IuDQo+ID4gMS4gbm8tc3ZhIHdvcmtzLCB3aGVyZSBndWVzdCBhcHAgZGly
ZWN0bHkgdXNlIHBoeXNpY2FsIGFkZHJlc3MgdmlhIGlvY3RsLg0KPiBUaGFuayB5b3UgZm9yIHRo
ZSB0ZXN0aW5nLiBHbGFkIGl0IHdvcmtzIGZvciB5b3UuDQo+ID4gMi4gdlNWQSBzdGlsbCBub3Qg
d29yaywgc2FtZSBhcyB2MTAsDQo+IFllcyB0aGF0J3Mgbm9ybWFsIHRoaXMgc2VyaWVzIGlzIG5v
dCBtZWFudCB0byBzdXBwb3J0IHZTVk0gYXQgdGhpcyBzdGFnZS4NCj4gDQo+IEkgaW50ZW5kIHRv
IGFkZCB0aGUgbWlzc2luZyBwaWVjZXMgZHVyaW5nIHRoZSBuZXh0IHdlZWtzLg0KDQpUaGFua3Mg
Zm9yIHRoYXQuIEkgaGF2ZSBtYWRlIGFuIGF0dGVtcHQgdG8gYWRkIHRoZSB2U1ZBIGJhc2VkIG9u
IA0KeW91ciB2MTAgKyBKUEJzIHN2YSBwYXRjaGVzLiBUaGUgaG9zdCBrZXJuZWwgYW5kIFFlbXUg
Y2hhbmdlcyBjYW4gDQpiZSBmb3VuZCBoZXJlWzFdWzJdLg0KDQpUaGlzIGJhc2ljYWxseSBhZGRz
IG11bHRpcGxlIHBhc2lkIHN1cHBvcnQgb24gdG9wIG9mIHlvdXIgY2hhbmdlcy4NCkkgaGF2ZSBk
b25lIHNvbWUgYmFzaWMgc2FuaXR5IHRlc3RpbmcgYW5kIHdlIGhhdmUgc29tZSBpbml0aWFsIHN1
Y2Nlc3MNCndpdGggdGhlIHppcCB2ZiBkZXYgb24gb3VyIEQwNiBwbGF0Zm9ybS4gUGxlYXNlIG5v
dGUgdGhhdCB0aGUgU1RBTEwgZXZlbnQgaXMNCm5vdCB5ZXQgc3VwcG9ydGVkIHRob3VnaCwgYnV0
IHdvcmtzIGZpbmUgaWYgd2UgbWxvY2soKSBndWVzdCB1c3IgbWVtLg0KDQpJIGFsc28gbm90ZWQg
dGhhdCBJbnRlbCBwYXRjaGVzIGZvciB2U1ZBIGhhcyBjb3VwbGUgb2YgY2hhbmdlcyBpbiB0aGUg
dmZpbyBpbnRlcmZhY2VzDQphbmQgaG9wZSB0aGVyZSB3aWxsIGJlIGEgY29udmVyZ2VuY2Ugc29v
bi4gUGxlYXNlIGxldCBtZSBrbm93IHlvdXIgcGxhbnMNCm9mIGEgcmVzcGluIG9mIHRoaXMgc2Vy
aWVzIGFuZCBzZWUgd2hldGhlciBpbmNvcnBvcmF0aW5nIHRoZSBjaGFuZ2VzIGZvciBtdWx0aXBs
ZQ0KcGFzaWQgbWFrZSBzZW5zZSBvciBub3QgZm9yIG5vdy4NCg0KVGhhbmtzLA0KU2hhbWVlcg0K
DQpbMV1odHRwczovL2dpdGh1Yi5jb20vaGlzaWxpY29uL3FlbXUvdHJlZS92NC4yLjAtMnN0YWdl
LXJmY3Y2LXZzdmEtcHJvdG90eXBlLXYxDQpbMl1odHRwczovL2dpdGh1Yi5jb20vaGlzaWxpY29u
L2tlcm5lbC1kZXYvdHJlZS92c3ZhLXByb3RvdHlwZS1ob3N0LXYxDQoNCj4gVGhhbmtzDQo+IA0K
PiBFcmljDQo+ID4gMy7CoCB0aGUgdjEwIGlzc3VlIHJlcG9ydGVkIGJ5IFNoYW1lZXIgaGFzIGJl
ZW4gc29sdmVkLMKgIGZpcnN0IHN0YXJ0IHFlbXUNCj4gPiB3aXRowqAgaW9tbXU9c21tdXYzLCB0
aGVuIHN0YXJ0IHFlbXUgd2l0aG91dMKgIGlvbW11PXNtbXV2Mw0KPiA+IDQuIG5vLXN2YSBhbHNv
IHdvcmtzIHdpdGhvdXTCoCBpb21tdT1zbW11djMNCj4gPg0KPiA+IFRlc3QgZGV0YWlscyBpbiBo
dHRwczovL2RvY3MucXEuY29tL2RvYy9EUlU1b1IxTnRVRVJzZUZOTA0KPiA+DQo+ID4gVGhhbmtz
DQo+ID4NCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
aW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
