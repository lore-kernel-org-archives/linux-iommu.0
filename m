Return-Path: <SRS0=0DsW=3G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753FFC33C9E
	for <iommu@archiver.kernel.org>; Fri, 17 Jan 2020 18:18:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5627C20748
	for <iommu@archiver.kernel.org>; Fri, 17 Jan 2020 18:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5627C20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5AACC86C4D;
	Fri, 17 Jan 2020 18:18:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QEge6+Z1lpJ0; Fri, 17 Jan 2020 18:18:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D6AAD86A16;
	Fri, 17 Jan 2020 18:18:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D14ABC18DC;
	Fri, 17 Jan 2020 18:18:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AC79FC077D
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jan 2020 18:17:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9AA4322128
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jan 2020 18:17:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5I2C3AhIXJaO for <iommu@lists.linux-foundation.org>;
 Fri, 17 Jan 2020 18:17:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by silver.osuosl.org (Postfix) with ESMTPS id 142A220347
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jan 2020 18:17:55 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Jan 2020 10:17:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,331,1574150400"; d="scan'208";a="373726753"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
 by orsmga004.jf.intel.com with ESMTP; 17 Jan 2020 10:17:54 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.147]) by
 ORSMSX102.amr.corp.intel.com ([169.254.3.133]) with mapi id 14.03.0439.000;
 Fri, 17 Jan 2020 10:17:54 -0800
From: "Derrick, Jonathan" <jonathan.derrick@intel.com>
To: "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH v3 4/5] PCI: vmd: Stop overriding dma_map_ops
Thread-Topic: [PATCH v3 4/5] PCI: vmd: Stop overriding dma_map_ops
Thread-Index: AQHVyA0OR8Dpn/C2UE++GgtBXKYjuafqZnOAgAVUbYA=
Date: Fri, 17 Jan 2020 18:17:53 +0000
Message-ID: <b36cf7bfc6ca5898ab3e6095439962af2381d533.camel@intel.com>
References: <1578676873-6206-1-git-send-email-jonathan.derrick@intel.com>
 <1578676873-6206-5-git-send-email-jonathan.derrick@intel.com>
 <20200114085425.GD32024@lst.de>
In-Reply-To: <20200114085425.GD32024@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.115.151]
Content-ID: <AB75532F4FA3C140A9F5CACAACBCEEF6@intel.com>
MIME-Version: 1.0
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "helgaas@kernel.org" <helgaas@kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>
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

T24gVHVlLCAyMDIwLTAxLTE0IGF0IDA5OjU0ICswMTAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gRnJpLCBKYW4gMTAsIDIwMjAgYXQgMTA6MjE6MTJBTSAtMDcwMCwgSm9uIERlcnJp
Y2sgd3JvdGU6DQo+ID4gRGV2aWNlcyBvbiB0aGUgVk1EIGRvbWFpbiB1c2UgdGhlIFZNRCBlbmRw
b2ludCdzIHJlcXVlc3RlciBJRCBhbmQgaGF2ZQ0KPiA+IGJlZW4gcmVseWluZyBvbiB0aGUgVk1E
IGVuZHBvaW50J3MgRE1BIG9wZXJhdGlvbnMuIFRoZSBwcm9ibGVtIHdpdGggdGhpcw0KPiA+IHdh
cyB0aGF0IFZNRCBkb21haW4gZGV2aWNlcyB3b3VsZCB1c2UgdGhlIFZNRCBlbmRwb2ludCdzIGF0
dHJpYnV0ZXMgd2hlbg0KPiA+IGRvaW5nIERNQSBhbmQgSU9NTVUgbWFwcGluZy4gV2UgY2FuIGJl
IHNtYXJ0ZXIgYWJvdXQgdGhpcyBieSBvbmx5IHVzaW5nDQo+ID4gdGhlIFZNRCBlbmRwb2ludCB3
aGVuIG1hcHBpbmcgYW5kIHByb3ZpZGluZyB0aGUgY29ycmVjdCBjaGlsZCBkZXZpY2Uncw0KPiA+
IGF0dHJpYnV0ZXMgZHVyaW5nIERNQSBvcGVyYXRpb25zLg0KPiA+IA0KPiA+IFRoaXMgcGF0Y2gg
bW9kaWZpZXMgSW50ZWwtSU9NTVUgdG8gY2hlY2sgZm9yIGEgJ0RpcmVjdCBETUEgQWxpYXMnIGFu
ZA0KPiA+IHJlZmVyIHRvIGl0IGZvciBtYXBwaW5nLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6
IEpvbiBEZXJyaWNrIDxqb25hdGhhbi5kZXJyaWNrQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAg
ZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jICAgIHwgIDE4ICsrKy0tDQo+ID4gIGRyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvS2NvbmZpZyB8ICAgMSAtDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvdm1kLmMgICB8IDE1MCAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDE1NiBkZWxldGlvbnMo
LSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jIGIv
ZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jDQo+ID4gaW5kZXggNzE2MzQ3ZTIuLjdjYTgwN2Eg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jDQo+ID4gKysrIGIv
ZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jDQo+ID4gQEAgLTgwNCwxNCArODA0LDE0IEBAIHN0
YXRpYyBzdHJ1Y3QgaW50ZWxfaW9tbXUgKmRldmljZV90b19pb21tdShzdHJ1Y3QgZGV2aWNlICpk
ZXYsIHU4ICpidXMsIHU4ICpkZXZmDQo+ID4gIA0KPiA+ICAJaWYgKGRldl9pc19wY2koZGV2KSkg
ew0KPiA+ICAJCXN0cnVjdCBwY2lfZGV2ICpwZl9wZGV2Ow0KPiA+ICsJCXN0cnVjdCBwY2lfZGV2
ICpkbWFfYWxpYXM7DQo+ID4gIA0KPiA+ICAJCXBkZXYgPSB0b19wY2lfZGV2KGRldik7DQo+ID4g
IA0KPiA+IC0jaWZkZWYgQ09ORklHX1g4Ng0KPiA+IC0JCS8qIFZNRCBjaGlsZCBkZXZpY2VzIGN1
cnJlbnRseSBjYW5ub3QgYmUgaGFuZGxlZCBpbmRpdmlkdWFsbHkgKi8NCj4gPiAtCQlpZiAoaXNf
dm1kKHBkZXYtPmJ1cykpDQo+ID4gLQkJCXJldHVybiBOVUxMOw0KPiA+IC0jZW5kaWYNCj4gDQo+
IERvbid0IHdlIG5lZWQgdGhpcyBzYW5pdHkgY2hlY2sgdG8gcHJldmVudCBhc3NpbmduaW5nIHZt
ZCBzdWJkZXZpY2VzPw0KSSBkb24ndCB0aGluayBpdCdzIG5lY2Vzc2FyeSBub3cuIFRoZSBuZXcg
Y29kZSByZXN1bHRzIGluIHRoZSBjaGlsZA0KZGV2aWNlcyBiZWluZyBhc3NpZ25lZCB0aGUgc2Ft
ZSBJT01NVSBncm91cCBhcyB0aGUgVk1EIGVuZHBvaW50Lg0KKEFGQUlLKSBZb3UgaGF2ZSB0byBh
c3NpZ24gYWxsIGRldmljZXMgaW4gYSBncm91cCB3aGVuIGRvaW5nDQphc3NpZ25tZW50LCBzbyBi
eSB1bmJpbmRpbmcgdGhlIFZNRCBlbmRwb2ludCBpbiBvcmRlciB0byBhc3NpZ24gaXQsIHlvdQ0K
d291bGQgbG9zZSB0aGUgY2hpbGQgZGV2aWNlcyBpbiB0aGUgaG9zdC4NCg0KDQo+IA0KPiA+ICsJ
CS8qIERNQSBhbGlhc2VkIGRldmljZXMgdXNlIHRoZSBETUEgYWxpYXMncyBJT01NVSAqLw0KPiA+
ICsJCWRtYV9hbGlhcyA9IHBjaV9kaXJlY3RfZG1hX2FsaWFzKHBkZXYpOw0KPiA+ICsJCWlmIChk
bWFfYWxpYXMpDQo+ID4gKwkJCXBkZXYgPSBkbWFfYWxpYXM7DQo+ID4gIA0KPiA+ICAJCS8qIFZG
cyBhcmVuJ3QgbGlzdGVkIGluIHNjb3BlIHRhYmxlczsgd2UgbmVlZCB0byBsb29rIHVwDQo+ID4g
IAkJICogdGhlIFBGIGluc3RlYWQgdG8gZmluZCB0aGUgSU9NTVUuICovDQo+ID4gQEAgLTI1MjEs
NiArMjUyMSwxNCBAQCBzdHJ1Y3QgZG1hcl9kb21haW4gKmZpbmRfZG9tYWluKHN0cnVjdCBkZXZp
Y2UgKmRldikNCj4gPiAgCQkgICAgIGRldi0+YXJjaGRhdGEuaW9tbXUgPT0gRFVNTVlfREVWSUNF
X0RPTUFJTl9JTkZPKSkNCj4gPiAgCQlyZXR1cm4gTlVMTDsNCj4gPiAgDQo+ID4gKwlpZiAoZGV2
X2lzX3BjaShkZXYpKSB7DQo+ID4gKwkJc3RydWN0IHBjaV9kZXYgKnBkZXYgPSB0b19wY2lfZGV2
KGRldik7DQo+ID4gKwkJc3RydWN0IHBjaV9kZXYgKmRtYV9hbGlhcyA9IHBjaV9kaXJlY3RfZG1h
X2FsaWFzKHBkZXYpOw0KPiA+ICsNCj4gPiArCQlpZiAoZG1hX2FsaWFzKQ0KPiA+ICsJCQlkZXYg
PSAmZG1hX2FsaWFzLT5kZXY7DQo+IA0KPiBJbnN0ZWFkIG9mIGFsbCB0aGVzZSBkdXBsaWNhdGUg
Y2FsbHMsIHNob3VsZG4ndCBwY2lfZGlyZWN0X2RtYV9hbGlhcyBiZQ0KPiByZXBsYWNlZCB3aXRo
IGEgcGNpX3JlYWxfZG1hX2RldiBoZWxwZXIgdGhhdCBlaXRoZXIgcmV0dXJucyB0aGUNCj4gZG1h
IHBhcmVudCBpZiBpdCBleGnRlXRzLCBvciB0aGUgYWN0dWFsIGRldmljZT8NCj4gDQo+IEFsc28g
SSB0aGluayB0aGlzIHBhdGNoIHNob3VsZCBiZSBzcGxpdCAtIG9uZSBmb3IgaW50ZWwtaW9tbXUg
dGhhdA0KPiBqdXN0IGFkZHMgdGhlIHJlYWwgZGV2aWNlIGNoZWNrcywgYW5kIHRoZW4gb25lIHRo
YXQgd2lyZXMgdXAgdm1kIHRvDQo+IHRoZSBuZXcgbWVjaGFuaXNtIGFuZCB0aGVuIHJlbW92ZXMg
YWxsIHRoZSBjcnVmdC4NCg0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuIEknbGwgd29yayBvbiB0
aGUgc3VnZ2VzdGlvbg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
