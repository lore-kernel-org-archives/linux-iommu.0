Return-Path: <SRS0=ocWU=2F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DCAC43603
	for <iommu@archiver.kernel.org>; Sun, 15 Dec 2019 09:37:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F8B12072B
	for <iommu@archiver.kernel.org>; Sun, 15 Dec 2019 09:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F8B12072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id EA4AC87601;
	Sun, 15 Dec 2019 09:37:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NpU6vMFNnuT2; Sun, 15 Dec 2019 09:37:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 40BD1875DB;
	Sun, 15 Dec 2019 09:37:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25948C1D80;
	Sun, 15 Dec 2019 09:37:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03230C077D
 for <iommu@lists.linux-foundation.org>; Sun, 15 Dec 2019 09:37:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id ED14687601
 for <iommu@lists.linux-foundation.org>; Sun, 15 Dec 2019 09:37:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id owA6cJlqpZ4B for <iommu@lists.linux-foundation.org>;
 Sun, 15 Dec 2019 09:37:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 35377875DB
 for <iommu@lists.linux-foundation.org>; Sun, 15 Dec 2019 09:37:10 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Dec 2019 01:37:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,317,1571727600"; d="scan'208";a="221292910"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by fmsmga001.fm.intel.com with ESMTP; 15 Dec 2019 01:37:09 -0800
Received: from fmsmsx119.amr.corp.intel.com (10.18.124.207) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 15 Dec 2019 01:37:09 -0800
Received: from shsmsx106.ccr.corp.intel.com (10.239.4.159) by
 FMSMSX119.amr.corp.intel.com (10.18.124.207) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 15 Dec 2019 01:37:09 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.90]) by
 SHSMSX106.ccr.corp.intel.com ([169.254.10.236]) with mapi id 14.03.0439.000;
 Sun, 15 Dec 2019 17:37:07 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 "David Woodhouse" <dwmw2@infradead.org>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: RE: [PATCH v3 4/6] iommu/vt-d: Setup pasid entries for iova over
 first level
Thread-Topic: [PATCH v3 4/6] iommu/vt-d: Setup pasid entries for iova over
 first level
Thread-Index: AQHVr8iyIh/47oarrk2lLODWaUc1kqe3zByggACkbgCAAoJegA==
Date: Sun, 15 Dec 2019 09:37:06 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A132C9A@SHSMSX104.ccr.corp.intel.com>
References: <20191211021219.8997-1-baolu.lu@linux.intel.com>
 <20191211021219.8997-5-baolu.lu@linux.intel.com>
 <A2975661238FB949B60364EF0F2C25743A1309A9@SHSMSX104.ccr.corp.intel.com>
 <acb93807-7a78-b81a-3b27-fde9ee4d7edb@linux.intel.com>
In-Reply-To: <acb93807-7a78-b81a-3b27-fde9ee4d7edb@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjM3Njk1NmEtYzVjNC00NzRjLWJjM2MtODRmNDQ4YTk5NWVjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiOU9aK0RzTXY2ZUNrQlVqNWlPbENUTjc5ajNvUVY5YWlmTWlFYTVScXE1NmtyNHdDMGtMTjhYRWxDbXArc1JlYSJ9
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun, 
 Yi Y" <yi.y.sun@intel.com>
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

SGkgQmFvbHUsDQoNCj4gRnJvbTogTHUgQmFvbHUgW21haWx0bzpiYW9sdS5sdUBsaW51eC5pbnRl
bC5jb21dDQo+IFNlbnQ6IFNhdHVyZGF5LCBEZWNlbWJlciAxNCwgMjAxOSAxMTowNCBBTQ0KPiBU
bzogTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+OyBKb2VyZyBSb2VkZWwgPGpvcm9AOGJ5
dGVzLm9yZz47IERhdmlkDQo+IFdvb2Rob3VzZSA8ZHdtdzJAaW5mcmFkZWFkLm9yZz47IEFsZXgg
V2lsbGlhbXNvbg0KPiA8YWxleC53aWxsaWFtc29uQHJlZGhhdC5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjMgNC82XSBpb21tdS92dC1kOiBTZXR1cCBwYXNpZCBlbnRyaWVzIGZvciBpb3Zh
IG92ZXIgZmlyc3QgbGV2ZWwNCj4gDQo+IEhpIExpdSBZaSwNCj4gDQo+IFRoYW5rcyBmb3IgcmV2
aWV3aW5nIG15IHBhdGNoLg0KPiANCj4gT24gMTIvMTMvMTkgNToyMyBQTSwgTGl1LCBZaSBMIHdy
b3RlOg0KPiA+PiBGcm9tOiBrdm0tb3duZXJAdmdlci5rZXJuZWwub3JnIFttYWlsdG86a3ZtLW93
bmVyQHZnZXIua2VybmVsLm9yZ10gT24NCj4gPj4gQmVoYWxmIE9mIEx1IEJhb2x1DQo+ID4+IFNl
bnQ6IFdlZG5lc2RheSwgRGVjZW1iZXIgMTEsIDIwMTkgMTA6MTIgQU0NCj4gPj4gU3ViamVjdDog
W1BBVENIIHYzIDQvNl0gaW9tbXUvdnQtZDogU2V0dXAgcGFzaWQgZW50cmllcyBmb3IgaW92YSBv
dmVyDQo+ID4+IGZpcnN0IGxldmVsDQo+ID4+DQo+ID4+IEludGVsIFZULWQgaW4gc2NhbGFibGUg
bW9kZSBzdXBwb3J0cyB0d28gdHlwZXMgb2YgcGFnZSB0YWJsZXMgZm9yIElPVkENCj4gdHJhbnNs
YXRpb246DQo+ID4+IGZpcnN0IGxldmVsIGFuZCBzZWNvbmQgbGV2ZWwuIFRoZSBJT01NVSBkcml2
ZXIgY2FuIGNob29zZSBvbmUgZnJvbQ0KPiA+PiBib3RoIGZvciBJT1ZBIHRyYW5zbGF0aW9uIGFj
Y29yZGluZyB0byB0aGUgdXNlIGNhc2UuIFRoaXMgc2V0cyB1cCB0aGUNCj4gPj4gcGFzaWQgZW50
cnkgaWYgYSBkb21haW4gaXMgc2VsZWN0ZWQgdG8gdXNlIHRoZSBmaXJzdC1sZXZlbCBwYWdlIHRh
YmxlIGZvciBpb3ZhDQo+IHRyYW5zbGF0aW9uLg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBM
dSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiA+PiAtLS0NCj4gPj4gICBkcml2
ZXJzL2lvbW11L2ludGVsLWlvbW11LmMgfCA0OCArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKy0tDQo+ID4+ICAgaW5jbHVkZS9saW51eC9pbnRlbC1pb21tdS5oIHwgMTAgKysrKy0t
LS0NCj4gPj4gICAyIGZpbGVzIGNoYW5nZWQsIDUyIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25z
KC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsLWlvbW11LmMN
Cj4gPj4gYi9kcml2ZXJzL2lvbW11L2ludGVsLWlvbW11LmMgaW5kZXgNCj4gPj4gMmI1YTQ3NTg0
YmFmLi44M2E3YWJmMGM0ZjAgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwt
aW9tbXUuYw0KPiA+PiArKysgYi9kcml2ZXJzL2lvbW11L2ludGVsLWlvbW11LmMNCj4gPj4gQEAg
LTU3MSw2ICs1NzEsMTEgQEAgc3RhdGljIGlubGluZSBpbnQgZG9tYWluX3R5cGVfaXNfc2koc3Ry
dWN0DQo+ID4+IGRtYXJfZG9tYWluDQo+ID4+ICpkb21haW4pDQo+ID4+ICAgCXJldHVybiBkb21h
aW4tPmZsYWdzICYgRE9NQUlOX0ZMQUdfU1RBVElDX0lERU5USVRZOyAgfQ0KPiA+Pg0KPiA+PiAr
c3RhdGljIGlubGluZSBib29sIGRvbWFpbl91c2VfZmlyc3RfbGV2ZWwoc3RydWN0IGRtYXJfZG9t
YWluICpkb21haW4pIHsNCj4gPj4gKwlyZXR1cm4gZG9tYWluLT5mbGFncyAmIERPTUFJTl9GTEFH
X1VTRV9GSVJTVF9MRVZFTDsgfQ0KPiA+PiArDQo+ID4+ICAgc3RhdGljIGlubGluZSBpbnQgZG9t
YWluX3Bmbl9zdXBwb3J0ZWQoc3RydWN0IGRtYXJfZG9tYWluICpkb21haW4sDQo+ID4+ICAgCQkJ
CSAgICAgICB1bnNpZ25lZCBsb25nIHBmbikNCj4gPj4gICB7DQo+ID4+IEBAIC0yMjg4LDYgKzIy
OTMsOCBAQCBzdGF0aWMgaW50IF9fZG9tYWluX21hcHBpbmcoc3RydWN0IGRtYXJfZG9tYWluDQo+
ID4+ICpkb21haW4sIHVuc2lnbmVkIGxvbmcgaW92X3BmbiwNCj4gPj4gICAJCXJldHVybiAtRUlO
VkFMOw0KPiA+Pg0KPiA+PiAgIAlwcm90ICY9IERNQV9QVEVfUkVBRCB8IERNQV9QVEVfV1JJVEUg
fCBETUFfUFRFX1NOUDsNCj4gPj4gKwlpZiAoZG9tYWluX3VzZV9maXJzdF9sZXZlbChkb21haW4p
KQ0KPiA+PiArCQlwcm90IHw9IERNQV9GTF9QVEVfUFJFU0VOVDsNCj4gPg0KPiA+IEZvciBETUFf
UFRFX1NOUCBiaXQsIEkgdGhpbmsgdGhlcmUgbmVlZHMgc29tZSB3b3JrLiBUaGUgYml0IDExIG9m
IHByb3QNCj4gPiBzaG91bGQgYmUgY2xlYXJlZCB3aGVuIEZMUFQgaXMgdXNlZCBmb3IgSU9WQS4N
Cj4gDQo+IFNOUCAoYml0IDExKSBpcyBvbmx5IGZvciBzZWNvbmQgbGV2ZWwuIFRoaXMgYml0IGlz
IGlnbm9yZWQgZm9yIGZpcnN0IGxldmVsIHBhZ2UgdGFibGUgd2Fsay4NCj4gV2Ugc2hvdWxkIGNs
ZWFyIHRoaXMgYml0IGZvciBmaXJzdCBsZXZlbCBhbnl3YXkuDQoNCkkgdGhpbmsgdGhpcyBpcyB3
aGF0IEkgbWVhbnQgYWJvdmU/IFRoaXMgcGF0Y2ggc29tZWhvdyBtaXNzZXMgdGhlIG9wZXJhdGlv
bg0KdG8gY2xlYXIgdGhlIGJpdCAxMS4NCg0KPiA+DQo+ID4gQWxzbywgd2UgbmVlZCB0byBzZXQg
Yml0IDYzICJYRCIgcHJvcGVybHkuIGUuZy4gSWYgYml0IDExIG9mIHByb3QgaXMNCj4gPiBzZXQs
IGl0IG1lYW5zIHNub29wIHJlcXVpcmVkLCB0aGVuICJYRCIgYml0IGlzICIwIi4gSWYgYml0IDEx
IG9mIHByb3QNCj4gPiBpcyAiMCIsIGl0IG1lYW5zIHRoaXMgZG9tYWluIGlzIG5vdCBzbm9vcGlu
Zywgc28geW91IG1heSB3YW50IHRvIHNldA0KPiA+ICJYRCIgYml0IGFzICIxIi4gV2l0aCBzdWNo
IGVuaGFuY2VtZW50LCBJIHRoaW5rIElPVkEgb3ZlciBGTFBUIHdvdWxkDQo+ID4gaGF2ZSBhcyBs
ZXNzIGRpZmZlcmVuY2Ugd2l0aCBJT1ZBIG92ZXIgU0xQVC4NCj4gDQo+IFhEIChiaXQgNjMpIGlz
IG9ubHkgZm9yIHRoZSBmaXJzdCBsZXZlbCwgYW5kIFNOUCAoYml0IDExKSBpcyBvbmx5IGZvciBz
ZWNvbmQgbGV2ZWwsIHJpZ2h0PyBJDQo+IHRoaW5rIHdlIG5lZWQgdG8gYWx3YXlzIHNldCBYRCBi
aXQgZm9yIElPVkEgb3ZlciBGTCBjYXNlLiB0aG91Z2h0cz8NCg0KT29wcywgSSBtYWRlIGEgbWlz
dGFrZSBoZXJlLiBQbGVhc2UgZm9yZ2V0IFNOUCBiaXQsIHRoZXJlIGlzIG5vIHdheSB0byBjb250
cm9sIFNOUA0Kd2l0aCBmaXJzdCBsZXZlbCBwYWdlIHRhYmxlLjotKQ0KDQpBY3R1YWxseSwgaXQg
aXMgZXhlY3V0ZSAoYml0IDEpIG9mIHNlY29uZCBsZXZlbCBwYWdlIHRhYmxlIHdoaWNoIEkgd2Fu
dGVkIHRvIHNheS4NCklmIHNvZnR3YXJlIHNldHMgUi9XL1ggcGVybWlzc2lvbiB0byBhbiBJT1ZB
LCB3aXRoIElPVkEgb3ZlciBzZWNvbmQgbGV2ZWwNCnBhZ2UgdGFibGUsIGl0IHdpbGwgc2V0IGJp
dCAxLiBIb3dldmVyLCBpZiBJT1ZBIGlzIG92ZXIgZmlyc3QgbGV2ZWwgcGFnZSB0YWJsZSwgaXQN
Cm1heSBuZWVkIHRvIGNsZWFyIFhEIGJpdC4gVGhpcyBpcyB3aGF0IEkgd2FudCB0byBzYXkgaGVy
ZS4gSWYgSU9WQSBkb2VzbuKAmXQgYWxsb3cNCmV4ZWN1dGUgcGVybWlzc2lvbiwgaXQncyBvayB0
byBhbHdheXMgc2V0IFhEIGJpdCBmb3IgSU9WQSBvdmVyIEZMIGNhc2UuIEJ1dCBJDQp3b3VsZCBs
aWtlIHRvIGRvIGl0IGp1c3QgYXMgd2hhdCB3ZSBkaWQgZm9yIFIvVyBwZXJtaXNzaW9uLiBSL1cg
cGVybWlzc2lvbg0KcmVsaWVzIG9uIHRoZSBwZXJtaXNzaW9uIGNvbmZpZ3VyZWQgYnkgdGhlIHBh
Z2UgbWFwIGNhbGxlci4gcmlnaHQ/DQoNClJlZ2FyZHMsDQpZaSBMaXUNCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
